// /***************************************************************************//**
//  * @file
//  * @brief Core application logic - EAD Advertiser + RTOS PPG/FILTER/AI pipeline
//  ******************************************************************************/

#include "sl_common.h"
#include "sl_bt_api.h"
#include "app_assert.h"
#include "app.h"
#include "sl_bt_ead_core.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "psa/crypto_values.h"
#include "psa/crypto.h"
#include "sl_memory_manager.h"
#include "gatt_db.h"
#include "sl_sleeptimer.h"
#include "sl_simple_button_instances.h"
#include "app_log.h"
#include "FreeRTOS.h"
#include "semphr.h"

#define BLE_EA_ADV_DATA_LEN           0xBF
#define ADDRESS_CHANGE_PERIOD_MS      20000
#define BTN_CONFIRM_PERIOD_MS         2000

#define CONFIRM_BTN                   0
#define ONESHOT_BTN_TIMER_CALLBACK    1
#define PERIODIC_TIMER_CALLBACK       2
#define PAYLOAD_UPDATE_PERIOD_MS       3000
#define PAYLOAD_UPDATE_TIMER_CALLBACK  3

/* Bật = 1 để tự chấp nhận passkey (dùng khi debug kết nối).
 * Đặt = 0 nếu muốn bắt buộc nhấn btn0 hai lần. */
#define AUTO_ACCEPT_PASSKEY           1

uint8_t btn_count = 0;

// The advertising set handle allocated from Bluetooth stack.
static uint8_t advertising_set_handle = 0xff;
uint8_t advertisement_buffer[BLE_EA_ADV_DATA_LEN];

sl_sleeptimer_timer_handle_t periodic_timer_handle;
sl_sleeptimer_timer_handle_t oneshot_btn_timer_handle;
sl_sleeptimer_timer_handle_t payload_timer_handle;

char name[] = "Encrypted Advertiser";

/* health_payload + Mutex - khai bao trong app.h, dinh nghia o day */
health_data_t health_payload = { .heart_rate = 0, .systolic = 0, .diastolic = 0, .spo2 = 0 };
SemaphoreHandle_t g_health_payload_mutex = NULL;

// -----------------------------------------------------------------------------
// Thread-safe logging
// -----------------------------------------------------------------------------
static SemaphoreHandle_t g_log_mutex = NULL;

#define LOG_SAFE(...) \
  do { \
    if (g_log_mutex != NULL) { xSemaphoreTake(g_log_mutex, portMAX_DELAY); } \
    app_log_info(__VA_ARGS__); \
    if (g_log_mutex != NULL) { xSemaphoreGive(g_log_mutex); } \
  } while (0)

// -----------------------------------------------------------------------------
// Sleeptimer callbacks
// -----------------------------------------------------------------------------
void payload_sleeptimer_callback(sl_sleeptimer_timer_handle_t *handle, void *data)
{
  (void)handle;
  (void)data;
  sl_bt_external_signal(PAYLOAD_UPDATE_TIMER_CALLBACK);
}

void oneshot_sleeptimer_callback(sl_sleeptimer_timer_handle_t *handle, void *data)
{
  (void)handle;
  (void)data;
  sl_bt_external_signal(ONESHOT_BTN_TIMER_CALLBACK);
}

void periodic_sleeptimer_callback(sl_sleeptimer_timer_handle_t *handle, void *data)
{
  (void)handle;
  (void)data;
  sl_bt_external_signal(PERIODIC_TIMER_CALLBACK);
}

void sl_button_on_change(const sl_button_t *handle)
{
  if (handle == &sl_button_btn0 && sl_button_get_state(handle) == SL_SIMPLE_BUTTON_PRESSED) {
    sl_bt_external_signal(CONFIRM_BTN);
  }
}

// -----------------------------------------------------------------------------
// EAD key material
// -----------------------------------------------------------------------------
sl_status_t initialize_and_store_key_material(sl_bt_ead_key_material_p key_material,
                                              psa_key_id_t *key_id)
{
  sl_status_t sc = SL_STATUS_FAIL;
  sl_bt_ead_session_key_t session_key;
  sl_bt_ead_iv_t initialization_vector;

  if (psa_generate_random(session_key, SL_BT_EAD_SESSION_KEY_SIZE) != PSA_SUCCESS
      || psa_generate_random(initialization_vector, SL_BT_EAD_IV_SIZE) != PSA_SUCCESS) {
    LOG_SAFE("[ERR] Failed to generate session key / IV\r\n");
    return sc;
  }

  memcpy(key_material->key, session_key, SL_BT_EAD_SESSION_KEY_SIZE);
  memcpy(key_material->iv, initialization_vector, SL_BT_EAD_IV_SIZE);

  // Gộp hex dump thành 1 chuỗi rồi log 1 lần
  char key_str[3 * SL_BT_EAD_SESSION_KEY_SIZE + 1];
  char iv_str[3 * SL_BT_EAD_IV_SIZE + 1];
  size_t pos = 0;

  for (uint8_t i = 0; i < SL_BT_EAD_SESSION_KEY_SIZE; i++) {
    pos += snprintf(key_str + pos, sizeof(key_str) - pos, "%02X:", key_material->key[i]);
  }
  if (pos > 0) key_str[pos - 1] = '\0';   // bỏ dấu ':' cuối

  pos = 0;
  for (uint8_t i = 0; i < SL_BT_EAD_IV_SIZE; i++) {
    pos += snprintf(iv_str + pos, sizeof(iv_str) - pos, "%02X:", key_material->iv[i]);
  }
  if (pos > 0) iv_str[pos - 1] = '\0';

  LOG_SAFE("session key: %s\r\n", key_str);
  LOG_SAFE("initialization vector: %s\r\n", iv_str);

  sc = sl_bt_gatt_server_write_attribute_value(gattdb_Encrypted_Data_Key_Material,
                                               0,
                                               SL_BT_EAD_KEY_MATERIAL_SIZE,
                                               (uint8_t *)key_material);
  app_assert_status(sc);
  LOG_SAFE("[OK] Key material written to GATT attribute\r\n");

  sc = sl_bt_ead_store_key(PSA_KEY_USAGE_ENCRYPT,
                           PSA_KEY_LIFETIME_VOLATILE,
                           key_material,
                           key_id);
  app_assert_status(sc);
  LOG_SAFE("[OK] Key material stored via PSA crypto (key_id=0x%08lx)\r\n",
           (unsigned long)*key_id);

  return sc;
}

// -----------------------------------------------------------------------------
// Build encrypted advertisement payload from health_payload
// -----------------------------------------------------------------------------
sl_status_t construct_advertisement_payload(sl_bt_ead_key_material_p key_material,
                                            sl_bt_ead_nonce_p nonce,
                                            uint8_t *index)
{
  sl_status_t sc = SL_STATUS_FAIL;
  *index = 0;
  health_data_t local_health_payload;

  // Giữ mutex xuyên suốt lúc đọc
  if (g_health_payload_mutex != NULL) {
    if (xSemaphoreTake(g_health_payload_mutex, pdMS_TO_TICKS(50)) == pdTRUE) {
      memcpy(&local_health_payload, &health_payload, sizeof(health_data_t));
      xSemaphoreGive(g_health_payload_mutex);
    } else {
      // Timeout → dùng giá trị 0 để tránh crash
      memset(&local_health_payload, 0, sizeof(health_data_t));
      LOG_SAFE("[WARN] health_payload mutex timeout\r\n");
    }
  } else {
    memcpy(&local_health_payload, &health_payload, sizeof(health_data_t));
  }

  // 1. Unencrypted header: Flags
  advertisement_buffer[(*index)++] = 0x02;
  advertisement_buffer[(*index)++] = 0x01;
  advertisement_buffer[(*index)++] = 0x06;

  // 2. Unencrypted header: Complete Local Name
  advertisement_buffer[(*index)++] = (uint8_t)(strlen(name) + 1);
  advertisement_buffer[(*index)++] = 0x09;
  memcpy(advertisement_buffer + *index, name, strlen(name));
  *index += (uint8_t)strlen(name);

  // 3. Construct encrypted health data
  static uint8_t health_data_buf[BLE_EA_ADV_DATA_LEN];
  size_t health_data_len = 2 + sizeof(health_data_t);

  sl_bt_ead_mic_t message_integrity_check;

  health_data_buf[0] = (uint8_t)(sizeof(health_data_t) + 1);
  health_data_buf[1] = 0x16;   // Service Data - 16-bit UUID (hoặc AD type tùy bạn)
  memcpy(health_data_buf + 2, &local_health_payload, sizeof(health_data_t));

  sc = sl_bt_ead_encrypt(key_material,
                         nonce,
                         health_data_len,
                         health_data_buf,
                         message_integrity_check);
  app_assert_status(sc);
  //LOG_SAFE("[OK] Health payload encrypted (len=%u)\r\n", (unsigned)health_data_len);

  sl_bt_ead_ad_structure_p encrypted_ad_structure =
      (sl_bt_ead_ad_structure_p)sl_malloc(sizeof(struct sl_bt_ead_ad_structure_s));
  app_assert(encrypted_ad_structure != NULL, "sl_malloc failed");

  uint8_t encrypted_data_length = BLE_EA_ADV_DATA_LEN;

  encrypted_ad_structure->length    = (uint8_t)health_data_len;
  encrypted_ad_structure->ad_type   = SL_BT_ENCRYPTED_DATA_AD_TYPE;
  encrypted_ad_structure->ad_data   = health_data_buf;
  encrypted_ad_structure->randomizer = &(nonce->randomizer);
  encrypted_ad_structure->mic       = &message_integrity_check;

  sc = sl_bt_ead_pack_ad_data(encrypted_ad_structure,
                              &encrypted_data_length,
                              advertisement_buffer + *index);
  app_assert_status(sc);

  LOG_SAFE("Health Payload before encryption -> Heart Rate: %d bpm, BP: %d/%d mmHg, SpO2: %d%%\r\n",
           local_health_payload.heart_rate,
           local_health_payload.systolic,
           local_health_payload.diastolic,
           local_health_payload.spo2);

  sl_free(encrypted_ad_structure);   // dùng sl_free cho đồng bộ với sl_malloc
  (*index) += encrypted_data_length;

  //LOG_SAFE("[OK] Advertisement payload constructed (total_len=%u)\r\n", (unsigned)*index);

  return sc;
}

// -----------------------------------------------------------------------------
// Application Init
// -----------------------------------------------------------------------------
void app_init(void)
{
  sl_status_t sc;

  // Tạo mutex log TRƯỚC TIÊN
  g_log_mutex = xSemaphoreCreateMutex();
  app_assert(g_log_mutex != NULL, "Log mutex creation failed.");

  // Tạo Mutex health_payload
  g_health_payload_mutex = xSemaphoreCreateMutex();
  app_assert(g_health_payload_mutex != NULL, "Health payload mutex creation failed.");
  LOG_SAFE("[OK] Health payload mutex created\r\n");

  sc = sl_sleeptimer_start_periodic_timer_ms(&periodic_timer_handle,
                                             ADDRESS_CHANGE_PERIOD_MS,
                                             periodic_sleeptimer_callback,
                                             (void *)NULL,
                                             0,
                                             0);
  app_assert_status(sc);
  LOG_SAFE("[OK] Periodic address-change timer started (%d ms)\r\n", ADDRESS_CHANGE_PERIOD_MS);

  // Khởi tạo Queue + 4 Task RTOS (PPG/FILTER/AI/BLE)
  app_init_bt();
  LOG_SAFE("[OK] app_init_bt() done - PPG/FILTER/AI/BLE tasks created\r\n");
}

// Application Process Action
void app_process_action(void)
{
  if (app_is_process_required()) {
    /////////////////////////////////////////////////////////////////////////////
    // Put your additional application code here!                              //
    /////////////////////////////////////////////////////////////////////////////
  }
}

/**************************************************************************//**
 * Bluetooth stack event handler
 *****************************************************************************/
void sl_bt_on_event(sl_bt_msg_t *evt)
{
  sl_status_t sc;
  static struct sl_bt_ead_key_material_s key_material;
  static struct sl_bt_ead_nonce_s nonce;
  static psa_key_id_t key_id = PSA_KEY_ID_NULL;
  static uint8_t index;
  static uint8_t connection_handle = SL_BT_INVALID_CONNECTION_HANDLE;
  static uint8_t pairing_state = 0;
  static bd_addr random_address;          // <-- FIX: static để dùng ở mọi case

  switch (SL_BT_MSG_ID(evt->header)) {

    // ------------------------------------------------------------------
    case sl_bt_evt_system_boot_id:
      pairing_state = 0;
      LOG_SAFE("boot\r\n");

      sl_bt_sm_delete_bondings();
      LOG_SAFE("[OK] Old bondings deleted\r\n");

      sc = sl_sleeptimer_start_periodic_timer_ms(&payload_timer_handle,
                                                 PAYLOAD_UPDATE_PERIOD_MS,
                                                 payload_sleeptimer_callback,
                                                 (void *)NULL,
                                                 0,
                                                 0);
      app_assert_status(sc);
      LOG_SAFE("[OK] Payload-update timer started (%d ms)\r\n", PAYLOAD_UPDATE_PERIOD_MS);

      sc = sl_bt_sm_set_bondable_mode(1);
      app_assert_status(sc);

      sc = sl_bt_sm_configure(SL_BT_SM_CONFIGURATION_MITM_REQUIRED
                              | SL_BT_SM_CONFIGURATION_BONDING_REQUIRED
                              | SL_BT_SM_CONFIGURATION_SC_ONLY
                              | SL_BT_SM_CONFIGURATION_BONDING_REQUEST_REQUIRED,
                              sl_bt_sm_io_capability_displayyesno);
      app_assert_status(sc);
      LOG_SAFE("[OK] Security manager configured (MITM + SC-only bonding)\r\n");

      initialize_and_store_key_material(&key_material, &key_id);   // <-- FIX: truyền &key_id
      sl_bt_ead_session_init(&key_material, NULL, &nonce);
      //LOG_SAFE("[OK] EAD session initialized\r\n");

      sc = sl_bt_advertiser_create_set(&advertising_set_handle);
      app_assert_status(sc);
      //LOG_SAFE("[OK] Advertising set created (handle=%d)\r\n", advertising_set_handle);

      sc = sl_bt_advertiser_set_random_address(advertising_set_handle,
                                               sl_bt_gap_random_resolvable_address,
                                               (bd_addr){ 0 },
                                               &random_address);
      app_assert_status(sc);
      //LOG_SAFE("[OK] Random resolvable address set\r\n");

      sc = construct_advertisement_payload(&key_material, &nonce, &index);
      app_assert_status(sc);

      sc = sl_bt_extended_advertiser_set_data(advertising_set_handle, index, advertisement_buffer);
      app_assert_status(sc);
      //LOG_SAFE("[OK] Advertisement data set (%d bytes)\r\n", index);

      sc = sl_bt_advertiser_set_timing(advertising_set_handle, 160, 160, 0, 0);
      app_assert_status(sc);

      sc = sl_bt_extended_advertiser_start(advertising_set_handle,
                                           sl_bt_extended_advertiser_connectable,
                                           0);
      app_assert_status(sc);
      LOG_SAFE("started advertisement\r\n");
      break;

    // ------------------------------------------------------------------
    case sl_bt_evt_connection_opened_id:
      LOG_SAFE("connection opened (handle=%d)\r\n",
               evt->data.evt_connection_opened.connection);
      sl_sleeptimer_stop_timer(&periodic_timer_handle);
      connection_handle = evt->data.evt_connection_opened.connection;
      break;

    // ------------------------------------------------------------------
    case sl_bt_evt_connection_parameters_id:
      switch (evt->data.evt_connection_parameters.security_mode) {
        case sl_bt_connection_mode1_level1:
          LOG_SAFE("No Security\r\n");
          break;
        case sl_bt_connection_mode1_level2:
          LOG_SAFE("Unauthenticated pairing with encryption\r\n");
          break;
        case sl_bt_connection_mode1_level3:
          LOG_SAFE("Authenticated pairing with encryption\r\n");
          break;
        case sl_bt_connection_mode1_level4:
          LOG_SAFE("Authenticated Secure Connections pairing with encryption\r\n");
          break;
        default:
          LOG_SAFE("Unknown security mode\r\n");
          break;
      }
      break;

    // ------------------------------------------------------------------
    case sl_bt_evt_connection_closed_id:
      LOG_SAFE("closed connection reason: 0x%04X\r\n",
               evt->data.evt_connection_closed.reason);
      connection_handle = SL_BT_INVALID_CONNECTION_HANDLE;
      pairing_state = 0;
      btn_count = 0;

      sc = sl_sleeptimer_start_periodic_timer_ms(&periodic_timer_handle,
                                                 ADDRESS_CHANGE_PERIOD_MS,
                                                 periodic_sleeptimer_callback,
                                                 (void *)NULL,
                                                 0,
                                                 0);
      app_assert_status(sc);

      sc = sl_bt_extended_advertiser_start(advertising_set_handle,
                                           sl_bt_extended_advertiser_connectable,
                                           0);
      app_assert_status(sc);
      LOG_SAFE("[OK] Re-started advertisement after disconnect\r\n");
      break;

    // ------------------------------------------------------------------
    case sl_bt_evt_sm_confirm_passkey_id:
      pairing_state = 1;
      LOG_SAFE("The passkey is: %06lu\r\n",
               (unsigned long)evt->data.evt_sm_confirm_passkey.passkey);

#if AUTO_ACCEPT_PASSKEY
      // DEBUG: tự chấp nhận để dễ test kết nối
      if (connection_handle != SL_BT_INVALID_CONNECTION_HANDLE) {
        sc = sl_bt_sm_passkey_confirm(connection_handle, 1);
        app_assert_status(sc);
        LOG_SAFE("[DEBUG] Auto-accepted passkey\r\n");
      }
#else
      LOG_SAFE("Please press btn0 twice within %d ms to accept bonding\r\n",
               BTN_CONFIRM_PERIOD_MS);
#endif
      break;

    // ------------------------------------------------------------------
    case sl_bt_evt_sm_confirm_bonding_id:
      LOG_SAFE("New bonding request\r\n");
      sc = sl_bt_sm_bonding_confirm(evt->data.evt_sm_confirm_bonding.connection, 1);
      app_assert_status(sc);
      break;

    // ------------------------------------------------------------------
    case sl_bt_evt_sm_bonded_id:
      LOG_SAFE("[OK] device bonded successfully\r\n");
      pairing_state = 0;
      btn_count = 0;
      break;

    // ------------------------------------------------------------------
    case sl_bt_evt_sm_bonding_failed_id:
      LOG_SAFE("[ERR] bonding failed, reason 0x%04X\r\n",
               evt->data.evt_sm_bonding_failed.reason);
      pairing_state = 0;
      btn_count = 0;
      sl_bt_sm_delete_bondings();
      break;

    // ------------------------------------------------------------------
    case sl_bt_evt_system_external_signal_id:
    {
      uint32_t signals = evt->data.evt_system_external_signal.extsignals;

      // ---- Periodic address rotation ----
      if (signals & (1 << PERIODIC_TIMER_CALLBACK) || signals == PERIODIC_TIMER_CALLBACK) {
        sl_bt_advertiser_stop(advertising_set_handle);

        sc = sl_bt_advertiser_set_random_address(advertising_set_handle,
                                                 sl_bt_gap_random_resolvable_address,
                                                 (bd_addr){ 0 },
                                                 &random_address);
        app_assert_status(sc);

        sl_bt_ead_randomizer_update(&nonce);

        construct_advertisement_payload(&key_material, &nonce, &index);
        sl_bt_extended_advertiser_set_data(advertising_set_handle, index, advertisement_buffer);

        sc = sl_bt_extended_advertiser_start(advertising_set_handle,
                                             sl_bt_extended_advertiser_connectable,
                                             0);
        app_assert_status(sc);
        //LOG_SAFE("[OK] Periodic address rotation done\r\n");
        break;
      }

      // ---- Payload refresh ----
      if (signals & (1 << PAYLOAD_UPDATE_TIMER_CALLBACK) || signals == PAYLOAD_UPDATE_TIMER_CALLBACK) {
        construct_advertisement_payload(&key_material, &nonce, &index);
        sl_bt_extended_advertiser_set_data(advertising_set_handle, index, advertisement_buffer);
        //LOG_SAFE("[OK] Advertisement payload refreshed\r\n");
        break;
      }

      // Chỉ xử lý nút khi đang trong quá trình pairing
      if (pairing_state == 0) {
        break;
      }

      // ---- Oneshot timer (timeout nhấn nút) ----
      if (signals == ONESHOT_BTN_TIMER_CALLBACK) {
        btn_count = 0;
        if (connection_handle != SL_BT_INVALID_CONNECTION_HANDLE) {
          sl_bt_sm_passkey_confirm(connection_handle, 0);
          //LOG_SAFE("[OK] Bonding refused (timeout / single press)\r\n");
        }
        break;
      }

      // ---- Button press ----
      if (signals == CONFIRM_BTN) {
        btn_count++;
        LOG_SAFE("btn_count = %d\r\n", btn_count);

        if (btn_count >= 2) {
          if (connection_handle != SL_BT_INVALID_CONNECTION_HANDLE) {
            sc = sl_bt_sm_passkey_confirm(connection_handle, 1);
            app_assert_status(sc);
            LOG_SAFE("[OK] Bonding accepted by user\r\n");
          }
          btn_count = 0;
          // Dừng oneshot timer nếu đang chạy
          sl_sleeptimer_stop_timer(&oneshot_btn_timer_handle);
        } else if (btn_count == 1) {
          sc = sl_sleeptimer_start_timer_ms(&oneshot_btn_timer_handle,
                                            BTN_CONFIRM_PERIOD_MS,
                                            oneshot_sleeptimer_callback,
                                            (void *)NULL,
                                            0,
                                            0);
          app_assert_status(sc);
        }
        break;
      }
      break;
    }

    // ------------------------------------------------------------------
    default:
      break;
  }
}
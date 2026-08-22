/***************************************************************************//**
 * @file app_advertiser.c
 * @brief EAD Advertiser with Custom Health Service Payload
 ******************************************************************************/
#include "sl_common.h"
#include "sl_bt_api.h"
#include "app_assert.h"
#include "app.h"
#include "sl_bt_ead_core.h"
#include <stdio.h>
#include <stdlib.h>
#include "psa/crypto_values.h"
#include "psa/crypto.h"
#include "sl_memory_manager.h"
#include "gatt_db.h"
#include "sl_sleeptimer.h"
#include "sl_simple_button_instances.h"

#define BLE_EA_ADV_DATA_LEN 0xBF
#define ADDRESS_CHANGE_PERIOD_MS 20000
#define BTN_CONFIRM_PERIOD_MS 2000

#define CONFIRM_BTN 0
#define ONESHOT_BTN_TIMER_CALLBACK 1
#define PERIODIC_TIMER_CALLBACK 2
#define PAYLOAD_UPDATE_PERIOD_MS 3000
#define PAYLOAD_UPDATE_TIMER_CALLBACK 3


uint8_t btn_count = 0;

// The advertising set handle allocated from Bluetooth stack.
static uint8_t advertising_set_handle = 0xff;
uint8_t advertisement_buffer[BLE_EA_ADV_DATA_LEN];

sl_sleeptimer_timer_handle_t periodic_timer_handle;
sl_sleeptimer_timer_handle_t oneshot_btn_timer_handle;

char name[] = "Encrypted Advertiser";

// -----------------------------------------------------------------------------
// Custom Health Service Payload Structure
// -----------------------------------------------------------------------------
typedef struct {
  uint8_t heart_rate;   // Heart rate in beats per minute (bpm)
  uint8_t body_temp;    // Body temperature in Celsius
  uint8_t spo2;         // Blood oxygen saturation percentage (%)
} health_data_t;

static health_data_t health_payload = { .heart_rate = 72, .body_temp = 37, .spo2 = 98 };

sl_sleeptimer_timer_handle_t payload_timer_handle;

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

sl_status_t initialize_and_store_key_material(sl_bt_ead_key_material_p key_material, psa_key_id_t key_id)
{
  sl_status_t sc = SL_STATUS_FAIL;
  // generate the session key and the IV needed to create the key material
  sl_bt_ead_session_key_t session_key;
  sl_bt_ead_iv_t initialization_vector;
  if (psa_generate_random(session_key, SL_BT_EAD_SESSION_KEY_SIZE) != PSA_SUCCESS || psa_generate_random(initialization_vector, SL_BT_EAD_IV_SIZE) != PSA_SUCCESS) {
    return sc;
  }
  memcpy(key_material->key, session_key, SL_BT_EAD_SESSION_KEY_SIZE);
  memcpy(key_material->iv, initialization_vector, SL_BT_EAD_IV_SIZE);
  app_log("session key: ");
  for (uint8_t i = 0; i < 16; i++) {
    app_log("%02X:", key_material->key[i]);
  }
  app_log("\r\ninitiazation vector: ");
  for (uint8_t i = 0; i < 8; i++) {
    app_log("%02X:", key_material->iv[i]);
  }
  app_log("\r\n");
  // set the key material Gatt characteristic to the key material value
  sc = sl_bt_gatt_server_write_attribute_value(gattdb_Encrypted_Data_Key_Material, 0, SL_BT_EAD_KEY_MATERIAL_SIZE, (uint8_t *)key_material);
  app_assert_status(sc);
  // store the key material and flush the input buffer
  sc = sl_bt_ead_store_key(PSA_KEY_USAGE_ENCRYPT, PSA_KEY_LIFETIME_VOLATILE, key_material, &key_id);
  app_assert_status(sc);
  return sc;
}

sl_status_t construct_advertisement_payload(sl_bt_ead_key_material_p key_material, sl_bt_ead_nonce_p nonce, uint8_t *index)
{
  sl_status_t sc = SL_STATUS_FAIL;
  *index = 0;

  // 1. Simulate new health measurement data
  health_payload.heart_rate = 60 + (rand() % 40); // 60-99 bpm
  health_payload.body_temp  = 36 + (rand() % 3);  // 36-38 C
  health_payload.spo2       = 95 + (rand() % 5);  // 95-99 %

  // 2. Add unencrypted header: Flags
  advertisement_buffer[(*index)++] = 0x02; // Ad structure len
  advertisement_buffer[(*index)++] = 0x01; // Ad structure type
  advertisement_buffer[(*index)++] = 0x06; // Ad structure data

  // 3. Add unencrypted header: Complete Local Name
  advertisement_buffer[(*index)++] = strlen(name) + 1;       // Ad structure len
  advertisement_buffer[(*index)++] = 0x09;                   // Ad structure type
  memcpy(advertisement_buffer + *index, name, strlen(name)); // Ad structure data
  *index += strlen(name);

  // 4. Construct encrypted health data structure
  uint8_t health_data_buf[BLE_EA_ADV_DATA_LEN];
  size_t health_data_len = 2 + sizeof(health_data_t); // len + type + payload

  sl_bt_ead_mic_t message_integraty_check;

  health_data_buf[0] = sizeof(health_data_t) + 1; // AD structure len
  health_data_buf[1] = 0x16;                       // AD structure type (Service Data)
  memcpy(health_data_buf + 2, &health_payload, sizeof(health_data_t)); // AD structure data

  // Encrypt the health payload
  sc = sl_bt_ead_encrypt(key_material, nonce, health_data_len, health_data_buf, message_integraty_check);
  app_assert_status(sc);

  sl_bt_ead_ad_structure_p encrypted_ad_structure = (sl_bt_ead_ad_structure_p)sl_malloc(sizeof(struct sl_bt_ead_ad_structure_s));
  uint8_t *encrypted_data_length = &(uint8_t){BLE_EA_ADV_DATA_LEN };
  encrypted_ad_structure->length = health_data_len;
  encrypted_ad_structure->ad_type = SL_BT_ENCRYPTED_DATA_AD_TYPE;
  encrypted_ad_structure->ad_data = health_data_buf;
  encrypted_ad_structure->randomizer = &(nonce->randomizer);
  encrypted_ad_structure->mic = &message_integraty_check;

  sc = sl_bt_ead_pack_ad_data(encrypted_ad_structure, encrypted_data_length, advertisement_buffer + *index);

  app_log("--------------------------------------------------------------------------\n\r");
  app_log("Health Payload before encryption -> Heart Rate: %d bpm, Temp: %d C, SpO2: %d%%\n\r",
          health_payload.heart_rate, health_payload.body_temp, health_payload.spo2);
  app_log("Information after encryption:\n\r");
  for (uint8_t i = *index; i < *index + *encrypted_data_length; i++) {
    app_log("%02X", advertisement_buffer[i]);
  }
  printf("\n\r");
  app_assert_status(sc);

  free(encrypted_ad_structure);
  (*index) += *encrypted_data_length;

  return sc;
}

// Application Init.
SL_WEAK void app_init(void)
{
  sl_status_t sc;
  sc = sl_sleeptimer_start_periodic_timer_ms(&periodic_timer_handle, ADDRESS_CHANGE_PERIOD_MS, periodic_sleeptimer_callback, (void *)NULL, 0, 0);
  app_assert_status(sc);
}

// Application Process Action.
SL_WEAK void app_process_action(void)
{
  if (app_is_process_required()) {
  }
}

/***************************************************************************//**
 * Bluetooth stack event handler.
 ******************************************************************************/
void sl_bt_on_event(sl_bt_msg_t *evt)
{
  sl_status_t sc;
  static struct sl_bt_ead_key_material_s key_material;
  static struct sl_bt_ead_nonce_s nonce;
  static psa_key_id_t key_id = PSA_KEY_ID_NULL;
  static uint8_t index;
  static uint8_t connection_handle = SL_BT_INVALID_CONNECTION_HANDLE;
  static uint8_t pairing_state;

  switch (SL_BT_MSG_ID(evt->header)) {
    case sl_bt_evt_system_boot_id:
      pairing_state = 0;
      app_log("boot\r\n");

      sl_bt_sm_delete_bondings();

      // Start updating health payload every 3 seconds
      sl_sleeptimer_start_periodic_timer_ms(&payload_timer_handle, PAYLOAD_UPDATE_PERIOD_MS, payload_sleeptimer_callback, (void *)NULL, 0, 0);

      sc = sl_bt_sm_set_bondable_mode(1);
      app_assert_status(sc);
      sc = sl_bt_sm_configure(SL_BT_SM_CONFIGURATION_MITM_REQUIRED | SL_BT_SM_CONFIGURATION_BONDING_REQUIRED | SL_BT_SM_CONFIGURATION_SC_ONLY | SL_BT_SM_CONFIGURATION_BONDING_REQUEST_REQUIRED, sl_bt_sm_io_capability_displayyesno);
      app_assert_status(sc);
      // initializes the key material
      initialize_and_store_key_material(&key_material, key_id);
      // initializes the nonce
      sl_bt_ead_session_init(&key_material, NULL, &nonce);
      // Create an advertising set.
      sc = sl_bt_advertiser_create_set(&advertising_set_handle);
      app_assert_status(sc);
      bd_addr random_address;
      sc = sl_bt_advertiser_set_random_address(advertising_set_handle, sl_bt_gap_random_resolvable_address, (bd_addr){0 }, &random_address);
      app_assert_status(sc);
      // fill advertisement with encrypted health payload and unencrypted headers
      sc = construct_advertisement_payload(&key_material, &nonce, &index);
      app_assert_status(sc);
      sc = sl_bt_extended_advertiser_set_data(advertising_set_handle, index, advertisement_buffer);
      app_assert_status(sc);
      // Set advertising interval to 100ms.
      sc = sl_bt_advertiser_set_timing(
        advertising_set_handle,
        160, // min. adv. interval (milliseconds * 1.6)
        160, // max. adv. interval (milliseconds * 1.6)
        0,   // adv. duration
        0);  // max. num. adv. events
      app_assert_status(sc);
      // Start advertising and enable connections.
      sc = sl_bt_extended_advertiser_start(advertising_set_handle,
                                           sl_bt_extended_advertiser_connectable, 0);
      app_assert_status(sc);
      app_log("started advertisement\r\n");
      break;

    case sl_bt_evt_connection_opened_id:
      app_log("connection opened\r\n");
      // Stop timer safely without asserting on return codes
      sl_sleeptimer_stop_timer(&periodic_timer_handle);
      connection_handle = evt->data.evt_connection_opened.connection;
      break;

    case sl_bt_evt_connection_parameters_id:
      switch (evt->data.evt_connection_parameters.security_mode) {
        case sl_bt_connection_mode1_level1:
          app_log("No Security\r\n");
          break;
        case sl_bt_connection_mode1_level2:
          app_log("Unauthenticated pairing with encryption\r\n");
          break;
        case sl_bt_connection_mode1_level3:
          app_log("Authenticated pairing with encryption\r\n");
          break;
        case sl_bt_connection_mode1_level4:
          app_log("Authenticated Secure Connections pairing with encryption\r\n");
          break;
      }
      break;

    case sl_bt_evt_connection_closed_id:
      app_log("closed connection reason: 0x%4X\r\n", evt->data.evt_connection_closed.reason);
      connection_handle = SL_BT_INVALID_CONNECTION_HANDLE;
      sc = sl_sleeptimer_start_periodic_timer_ms(&periodic_timer_handle, ADDRESS_CHANGE_PERIOD_MS, periodic_sleeptimer_callback, (void *)NULL, 0, 0);
      app_assert_status(sc);
      sc = sl_bt_extended_advertiser_start(advertising_set_handle,
                                           sl_bt_extended_advertiser_connectable, 0);
      app_assert_status(sc);
      break;

    case sl_bt_evt_sm_confirm_passkey_id:
      pairing_state = 1;
      app_log("The passkey is: %06li\r\n", evt->data.evt_sm_confirm_passkey.passkey);
      app_log("Please press btn0 once to refuse bonding or twice to accept bonding\n\r");
      break;

    case sl_bt_evt_sm_confirm_bonding_id:
      app_log("New bonding request\r\n");
      sc = sl_bt_sm_bonding_confirm(evt->data.evt_sm_confirm_bonding.connection, 1);
      app_assert_status(sc);
      break;

    case sl_bt_evt_sm_bonded_id:
      app_log("device bonded successfully\r\n");
      pairing_state = 0;
      break;

    case sl_bt_evt_sm_bonding_failed_id:
      app_log("bonding failed, reason 0x%04X\r\n",
              evt->data.evt_sm_bonding_failed.reason);
      pairing_state = 0;
      sl_bt_sm_delete_bondings(); // Clear old keys on failure so you can retry
      break;

    case sl_bt_evt_system_external_signal_id:
          // 1. Periodic Random Address & Randomizer Update
          if (evt->data.evt_system_external_signal.extsignals == PERIODIC_TIMER_CALLBACK) {
            sl_bt_advertiser_stop(advertising_set_handle);
            sl_bt_advertiser_set_random_address(advertising_set_handle, sl_bt_gap_random_resolvable_address, (bd_addr){0}, &random_address);
            sl_bt_ead_randomizer_update(&nonce);
            construct_advertisement_payload(&key_material, &nonce, &index);
            sl_bt_extended_advertiser_set_data(advertising_set_handle, index, advertisement_buffer);
            sl_bt_extended_advertiser_start(advertising_set_handle, sl_bt_extended_advertiser_connectable, 0);
            break;
          }

          // 2. Periodic Health Payload Update (Safely update data without crashing on status 0x0002)
          if (evt->data.evt_system_external_signal.extsignals == PAYLOAD_UPDATE_TIMER_CALLBACK) {
            construct_advertisement_payload(&key_material, &nonce, &index);
            sl_bt_extended_advertiser_set_data(advertising_set_handle, index, advertisement_buffer);
            break;
          }

          // Ignore button pairing signals if not actively in pairing state
          if (pairing_state == 0) {
            break;
          }

          // 3. Oneshot Button Timer (Refuse Pairing)
          if (evt->data.evt_system_external_signal.extsignals == ONESHOT_BTN_TIMER_CALLBACK) {
            btn_count = 0;
            if (connection_handle != SL_BT_INVALID_CONNECTION_HANDLE) {
              sl_bt_sm_passkey_confirm(connection_handle, 0);
            }
            break;
          }

          // 4. Button Press Signal (Accept Pairing on Double-Click)
          if (evt->data.evt_system_external_signal.extsignals == CONFIRM_BTN) {
            btn_count++;
            if (btn_count == 2) {
              app_log("connection handle %d\r\n", connection_handle);
              if (connection_handle != SL_BT_INVALID_CONNECTION_HANDLE) {
                sl_bt_sm_passkey_confirm(connection_handle, 1);
              }
              btn_count = 0;
            } else if (btn_count == 1) {
              sc = sl_sleeptimer_start_timer_ms(&oneshot_btn_timer_handle, BTN_CONFIRM_PERIOD_MS, oneshot_sleeptimer_callback, (void *)NULL, 0, 0);
              app_assert_status(sc);
            }
            break;
          }
          break;
  }
}
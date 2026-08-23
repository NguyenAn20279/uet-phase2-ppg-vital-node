/***************************************************************************//**
 * @file app.c
 * @brief Merged Application — EAD Scanner (Project 1) + SSD1306 OLED (Project 2)
 *
 * Gộp app_encryption_advertising.c (quét/giải mã Encrypted Advertising Data,
 * in ra VCOM) và app_i2c.c (điều khiển OLED SSD1306 qua I2C0, SCL=PD02,
 * SDA=PD03). Toàn bộ log ra VCOM giữ nguyên như cũ; dữ liệu health sau khi
 * giải mã thành công sẽ được ghi thêm lên OLED.
 *
 * Giả định các phần khác (thư viện driver, GATT database, CMakeLists.txt...)
 * đã được cấu hình sẵn trong project như bạn đã nêu — file này chỉ thay thế
 * app.c chính.
 ******************************************************************************/
#include "sl_common.h"
#include "sl_bt_api.h"
#include "app_assert.h"
#include "app.h"
#include "app_log.h"
#include "sl_sleeptimer.h"
#include "sl_simple_button_instances.h"
#include "sl_bt_ead_core.h"
#include "psa/crypto_values.h"
#include "psa/crypto.h"

#include "sl_i2cspm_instances.h"
#include "ssd1306.h"

#include <stdio.h>
#include <stdbool.h>
#include <string.h>

#define ADVERTISEMENT_READ_PERIOD_MS 5000
#define BTN_CONFIRM_PERIOD_MS        2000

#define CONFIRM_BTN                 0
#define ONESHOT_BTN_TIMER_CALLBACK  1
#define PERIODIC_TIMER_CALLBACK     2
#define CLOSE_CONN_TIMER_CALLBACK   3

// GATT Procedure States
#define SERVICE_DISCOVERY          1
#define CHARACTERISTIC_DISCOVERY   2
#define CHARACTERISTIC_READ        3

#define OLED_LINE_TITLE   0
#define OLED_LINE_STATUS  1
#define OLED_LINE_HR      2
#define OLED_LINE_BP      3   // Thay cho OLED_LINE_TEMP
#define OLED_LINE_SPO2    4
#define OLED_LINE_COUNT   5

#define CONNECTION_HOLD_TIME_MS   10000 // Hold duration in milliseconds

// -----------------------------------------------------------------------------
// BLE / EAD globals (từ app_encryption_advertising.c)
// -----------------------------------------------------------------------------
sl_sleeptimer_timer_handle_t conn_close_timer_handle;
sl_sleeptimer_timer_handle_t periodic_timer_handle;
sl_sleeptimer_timer_handle_t oneshot_btn_timer_handle;

uint8_t btn_count = 0;

char remote_name[] = "Encrypted Advertiser";
// Gap service UUID
const uint8_t Gap_service_uuid[] = { 0x00, 0x18 };
// Key material characteristic UUID
const uint8_t key_material_char_uuid[] = { 0x88, 0x2b };

// -----------------------------------------------------------------------------
// OLED globals (từ app_i2c.c)
// -----------------------------------------------------------------------------
static sl_sleeptimer_timer_handle_t update_timer;
static volatile bool update_due = false;
static uint16_t counter = 0;
static bool oled_ready = false; // false nếu init OLED thất bại -> bỏ qua các lần ghi sau

// -----------------------------------------------------------------------------
// Custom Health Service Payload Structure (Must match Advertiser)
// -----------------------------------------------------------------------------
typedef struct {
  uint8_t heart_rate;   // Nhịp tim (bpm)
  uint8_t systolic;     // Huyết áp tâm thu (mmHg)
  uint8_t diastolic;    // Huyết áp tâm trương (mmHg)
  uint8_t spo2;         // Nồng độ oxy trong máu (%)
} health_data_t;


// -----------------------------------------------------------------------------
// Timer callbacks
// -----------------------------------------------------------------------------
void conn_close_timer_callback(sl_sleeptimer_timer_handle_t *handle, void *data)
{
  (void)handle;
  (void)data;
  sl_bt_external_signal(CLOSE_CONN_TIMER_CALLBACK);
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

// chỉ set cờ trong callback, xử lý thật (ghi I2C) ở main loop
static void update_timer_callback(sl_sleeptimer_timer_handle_t *handle, void *data)
{
  (void)handle;
  (void)data;
  update_due = true;
}

void sl_button_on_change(const sl_button_t *handle)
{
  if (handle == &sl_button_btn0 && sl_button_get_state(handle) == SL_SIMPLE_BUTTON_PRESSED) {
    sl_bt_external_signal(CONFIRM_BTN);
  }
}

// -----------------------------------------------------------------------------
// OLED helpers
// -----------------------------------------------------------------------------
// Layout (SSD1306 128x64 -> 8 page/dong, xac nhan tu ssd1306.h SSD1306_PAGES=8):
//   Dong 0: tieu de (tinh, ghi 1 lan luc init)
//   Dong 1: trang thai (WAITING / KEY UPDATED / DECRYPT FAILED / OK)
//   Dong 2: Heart Rate
//   Dong 3: Body Temperature
//   Dong 4: SpO2
//   Dong 5: heartbeat counter (debug xac nhan I2C/OLED khong bi treo)
//   Dong 6-7: chua dung, de trong cho mo rong sau nay
//
// QUAN TRONG: ssd1306_font.c chi co glyph cho chu HOA (A-Z), so 0-9 va cac
// ky tu ' ' '.' ':' '%' '-' '/'. Chu thuong hoac ky tu khac se bi ve thanh
// 1 khoi dac (xem ssd1306_font_lookup tra ve false -> memset 0x7F).
// => Moi chuoi truyen cho ssd1306_print_line() phia duoi PHAI viet HOA.
// Moi dong toi da ~21 ky tu (128px / 6px moi glyph); cac chuoi ben duoi deu
// duoi gioi han nay.
#define OLED_LINE_TITLE   0
#define OLED_LINE_STATUS  1
#define OLED_LINE_HR      2
#define OLED_LINE_TEMP    3
#define OLED_LINE_SPO2    4
#define OLED_LINE_COUNT   5

static void oled_show_status(const char *status)
{
  if (!oled_ready) {
    return;
  }
  ssd1306_print_line(sl_i2cspm_oled, OLED_LINE_STATUS, status);
}

static void oled_display_health_data(health_data_t *data)
{
  char line[17];

  if (!oled_ready) {
    return;
  }

  oled_show_status("OK");

  // Dòng 2: Nhịp tim
  snprintf(line, sizeof(line), "HR:%3u BPM", data->heart_rate);
  ssd1306_print_line(sl_i2cspm_oled, OLED_LINE_HR, line);

  // Dòng 3: Huyết áp (Tâm thu / Tâm trương)
  snprintf(line, sizeof(line), "BP:%3u/%3u", data->systolic, data->diastolic);
  ssd1306_print_line(sl_i2cspm_oled, OLED_LINE_BP, line);

  // Dòng 4: SpO2
  snprintf(line, sizeof(line), "SPO2:%3u %%", data->spo2);
  ssd1306_print_line(sl_i2cspm_oled, OLED_LINE_SPO2, line);
}

// -----------------------------------------------------------------------------
// Advertisement parsing / decryption (logic giữ nguyên như bản gốc)
// -----------------------------------------------------------------------------
sl_status_t find_advertiser_by_local_name(sl_bt_evt_scanner_extended_advertisement_report_t *adv_report)
{
  sl_status_t sc = SL_STATUS_FAIL;
  uint8_t ad_len;
  uint8_t ad_type;
  uint8_t i = 0;
  while (i < adv_report->data.len) {
    ad_len = adv_report->data.data[i];
    ad_type = adv_report->data.data[i + 1];
    if (ad_type == 0x09) {
      if (memcmp(remote_name, &(adv_report->data.data[i + 2]), ad_len - 1) == 0) {
        return SL_STATUS_OK;
      }
    }
    i = i + ad_len + 1;
  }
  return sc;
}

sl_status_t extract_and_deycrypt(sl_bt_evt_scanner_extended_advertisement_report_t *adv_report,
                                 sl_bt_ead_key_material_p key_material,
                                 sl_bt_ead_nonce_p nonce)
{
  sl_status_t sc = SL_STATUS_FAIL;
  uint8_t ad_len;
  uint8_t ad_type;
  uint8_t i = 0;
  struct sl_bt_ead_ad_structure_s advertisement_info;
  sl_bt_ead_randomizer_t randomizer;
  uint8_t encrypted_data_buffer[30];
  sl_bt_ead_mic_t mic;

  app_log("--------------------------------------------------------------------------\n\r");
  app_log("Decrypting\r\n");

  advertisement_info.length = sizeof(encrypted_data_buffer);
  advertisement_info.randomizer = &randomizer;
  advertisement_info.ad_data = encrypted_data_buffer;
  advertisement_info.mic = &mic;

  while (i < adv_report->data.len) {
    ad_len = adv_report->data.data[i];
    ad_type = adv_report->data.data[i + 1];
    if (ad_type == SL_BT_ENCRYPTED_DATA_AD_TYPE) {
      app_log("secret information encrypted:\r\n");
      for (uint8_t j = 0; j < ad_len + 1; j++) {
        app_log("%02X", adv_report->data.data[i + j]);
      }
      sc = sl_bt_ead_unpack_ad_data(&adv_report->data.data[i], &advertisement_info);
      if (sc != 0) {
        app_log("unpacking unsuccessful with rc %08lX\r\n", sc);
      }
      memcpy(nonce->randomizer, advertisement_info.randomizer, SL_BT_EAD_RANDOMIZER_SIZE);
      sc = sl_bt_ead_decrypt(key_material, nonce, (uint8_t *)advertisement_info.mic, advertisement_info.length, advertisement_info.ad_data);
      if (sc != 0) {
        app_log("decrypting unsuccessful with rc %08lX\r\n", sc);
        oled_show_status("DECRYPT FAILED");
      } else {
        app_log("\r\nDecrypted Health Payload Received:\r\n");
        health_data_t *received_health = (health_data_t *)&advertisement_info.ad_data[2];
        app_log("  - Heart Rate:        %d bpm\r\n", received_health->heart_rate);
        app_log("  - Blood Pressure:    %d/%d mmHg\r\n", received_health->systolic, received_health->diastolic);
        app_log("  - Oxygen Saturation: %d%%\r\n", received_health->spo2);

        // Đẩy dữ liệu vừa giải mã lên màn hình OLED
        oled_display_health_data(received_health);

        // NEW: đẩy dữ liệu vừa giải mã lên OLED
        oled_display_health_data(received_health);
      }
    }
    i = i + ad_len + 1;
  }
  return sc;
}

// -----------------------------------------------------------------------------
// Application Init
// -----------------------------------------------------------------------------
void app_init(void)
{
  sl_status_t sc;

  // ---- OLED init (từ app_i2c.c) ----
  if (ssd1306_init(sl_i2cspm_oled)) {
    oled_ready = true;
    app_log_info("OLED: khoi tao thanh cong\r\n");
    ssd1306_print_line(sl_i2cspm_oled, OLED_LINE_TITLE, "EAD HEALTH MON.");
    oled_show_status("WAITING DATA...");
  } else {
    oled_ready = false;
    app_log_error("OLED: khong tim thay man hinh / loi I2C\r\n");
  }

  // ---- BLE / EAD periodic advertisement read timer (từ app_encryption_advertising.c) ----
  sc = sl_sleeptimer_start_periodic_timer_ms(&periodic_timer_handle, ADVERTISEMENT_READ_PERIOD_MS, periodic_sleeptimer_callback, (void *)NULL, 0, 0);
  app_assert_status(sc);
}

// -----------------------------------------------------------------------------
// Application Process Action
// -----------------------------------------------------------------------------
void app_process_action(void)
{
  if (app_is_process_required()) {
  }

  // Heartbeat counter (từ app_i2c.c) — xác nhận OLED/I2C không bị treo.
  // Panel 128x64 có 8 dòng, dòng 5 chưa dùng bởi dữ liệu health nên in
  // counter ở đó, không đè lên HR/TEMP/SPO2/STATUS.
  if (update_due) {
    update_due = false;
    counter++;
    if (oled_ready) {
      char line[17];
      snprintf(line, sizeof(line), "COUNT:%05u", counter);
      ssd1306_print_line(sl_i2cspm_oled, OLED_LINE_COUNT, line);
    }
  }
}

/***************************************************************************//**
 * Bluetooth stack event handler.
 ******************************************************************************/
void sl_bt_on_event(sl_bt_msg_t *evt)
{
  sl_status_t sc;
  static uint8_t connection_handle = SL_BT_INVALID_CONNECTION_HANDLE;
  static uint8_t key_need_update;
  static uint8_t pairing_state;
  static uint32_t gap_service_handle;
  static uint32_t key_material_char_handle;
  static uint8_t Gatt_procedure;
  static struct sl_bt_ead_key_material_s key_material;
  static struct sl_bt_ead_nonce_s nonce;
  static psa_key_id_t key_id = PSA_KEY_ID_NULL;
  static uint8_t decrypt_adv;

  switch (SL_BT_MSG_ID(evt->header)) {
    case sl_bt_evt_system_boot_id:
      pairing_state = 0;
      key_need_update = 1;
      decrypt_adv = 1;
      app_log("boot\r\n");

      sl_bt_sm_delete_bondings();

      sc = sl_bt_sm_set_bondable_mode(1);
      app_assert_status(sc);
      sc = sl_bt_sm_configure(SL_BT_SM_CONFIGURATION_MITM_REQUIRED | SL_BT_SM_CONFIGURATION_BONDING_REQUIRED | SL_BT_SM_CONFIGURATION_SC_ONLY | SL_BT_SM_CONFIGURATION_BONDING_REQUEST_REQUIRED, sl_bt_sm_io_capability_displayyesno);
      app_assert_status(sc);
      sc = sl_bt_scanner_set_parameters(sl_bt_scanner_scan_mode_passive, 200, 200);
      app_assert_status(sc);
      sc = sl_bt_scanner_start(sl_bt_scanner_scan_phy_1m, sl_bt_scanner_discover_observation);
      app_assert_status(sc);
      break;

    case sl_bt_evt_scanner_extended_advertisement_report_id:
      sl_bt_evt_scanner_extended_advertisement_report_t *adv_report = &evt->data.evt_scanner_extended_advertisement_report;
      if (find_advertiser_by_local_name(adv_report) == 0) {
        if (key_need_update == 1) {
          sc = sl_bt_scanner_stop();
          app_assert_status(sc);
          sc = sl_bt_connection_open(adv_report->address,
                                     adv_report->address_type,
                                     adv_report->primary_phy,
                                     &connection_handle);
          app_assert_status(sc);
        } else {
          sc = extract_and_deycrypt(adv_report, &key_material, &nonce);
          if (sc != 0) {
            app_log("failed to decrypt the message, fetching new key\r\n");
            key_need_update = 1;
          }
        }
      }
      break;

    case sl_bt_evt_scanner_legacy_advertisement_report_id:
      break;

    case sl_bt_evt_connection_opened_id:
      sl_bt_evt_connection_opened_t connection_data = evt->data.evt_connection_opened;
      app_log("connection opened\r\n");
      connection_handle = connection_data.connection;
      if (connection_data.bonding == SL_BT_INVALID_BONDING_HANDLE) {
        sl_bt_sm_increase_security(connection_handle);
      } else {
        app_log("discovering services\r\n");
        Gatt_procedure = SERVICE_DISCOVERY;
        sc = sl_bt_gatt_discover_primary_services_by_uuid(connection_handle, sizeof(Gap_service_uuid), Gap_service_uuid);
        app_assert_status(sc);
      }
      break;

    case sl_bt_evt_connection_closed_id:
      app_log("closed connection reason: 0x%4X\r\n", evt->data.evt_connection_closed.reason);
      connection_handle = SL_BT_INVALID_CONNECTION_HANDLE;
      sc = sl_bt_scanner_start(sl_bt_scanner_scan_phy_1m, sl_bt_scanner_discover_observation);
      app_assert_status(sc);
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

    case sl_bt_evt_gatt_service_id:
      app_log("Service discovery using UUID: ");
      gap_service_handle = evt->data.evt_gatt_service.service;
      for (int i = 0; i < evt->data.evt_gatt_service.uuid.len; i++) {
        app_log("%02X", evt->data.evt_gatt_service.uuid.data[i]);
      }
      app_log("\r\nresulted in the handle: %08lX\r\n", gap_service_handle);
      break;

    case sl_bt_evt_gatt_characteristic_id:
      app_log("Characteristic discovery using UUID: ");
      key_material_char_handle = evt->data.evt_gatt_characteristic.characteristic;
      for (int i = 0; i < evt->data.evt_gatt_characteristic.uuid.len; i++) {
        app_log("%02X", evt->data.evt_gatt_characteristic.uuid.data[i]);
      }
      app_log("\r\nresulted in the handle: %04X \r\n", evt->data.evt_gatt_characteristic.characteristic);
      break;

    case sl_bt_evt_gatt_characteristic_value_id:
          memcpy(key_material.key, evt->data.evt_gatt_characteristic_value.value.data, SL_BT_EAD_SESSION_KEY_SIZE);
          memcpy(key_material.iv, evt->data.evt_gatt_characteristic_value.value.data + SL_BT_EAD_SESSION_KEY_SIZE, SL_BT_EAD_IV_SIZE);
          memcpy(nonce.iv, key_material.iv, SL_BT_EAD_IV_SIZE);

          app_log("key material: ");
          for (uint8_t i = 0; i < SL_BT_EAD_SESSION_KEY_SIZE; i++) {
            app_log("%02X:", key_material.key[i]);
          }
          app_log("\r\ninitialization vector: ");
          for (uint8_t i = 0; i < SL_BT_EAD_IV_SIZE; i++) {
            app_log("%02X:", key_material.iv[i]);
          }
          app_log("\r\n");

          sc = sl_bt_ead_store_key(PSA_KEY_USAGE_DECRYPT, PSA_KEY_LIFETIME_VOLATILE, &key_material, &key_id);
          app_assert_status(sc);

          key_need_update = 0;
          oled_show_status("KEY UPDATED");

          // Start a 10-second timer before disconnecting
          app_log("Key material saved. Holding connection open for 10 seconds...\r\n");
          sc = sl_sleeptimer_start_timer_ms(&conn_close_timer_handle,
                                            CONNECTION_HOLD_TIME_MS,
                                            conn_close_timer_callback,
                                            (void *)NULL,
                                            0,
                                            0);
          app_assert_status(sc);
          break;

    case sl_bt_evt_gatt_procedure_completed_id:
      app_log("Gatt procedure result:  0x%04X \r\n", evt->data.evt_gatt_procedure_completed.result);
      if (Gatt_procedure == SERVICE_DISCOVERY) {
        Gatt_procedure = CHARACTERISTIC_DISCOVERY;
        sc = sl_bt_gatt_discover_characteristics_by_uuid(connection_handle, gap_service_handle, sizeof(key_material_char_uuid), key_material_char_uuid);
      } else if (Gatt_procedure == CHARACTERISTIC_DISCOVERY) {
        Gatt_procedure = CHARACTERISTIC_READ;
        sl_bt_sm_increase_security(connection_handle);
        sl_bt_gatt_read_characteristic_value(connection_handle, key_material_char_handle);
      }
      break;

    case sl_bt_evt_sm_confirm_passkey_id:
      pairing_state = 1;
      app_log("The passkey is: %06li\r\n", evt->data.evt_sm_confirm_passkey.passkey);
      app_log("Please press btn0 once to refuse bonding or twice to accept bonding\n\r");
      break;

    case sl_bt_evt_sm_bonded_id:
      app_log("device bonded successfully\r\n");
      pairing_state = 0;
      sc = sl_bt_connection_close(connection_handle);
      app_assert_status(sc);
      break;

    case sl_bt_evt_sm_bonding_failed_id:
      app_log("bonding failed, reason 0x%2X\r\n",
              evt->data.evt_sm_bonding_failed.reason);
      sc = sl_bt_connection_close(connection_handle);
      app_assert_status(sc);
      break;

    case sl_bt_evt_system_external_signal_id:
      if (evt->data.evt_system_external_signal.extsignals == CLOSE_CONN_TIMER_CALLBACK) {
        app_log("10-second hold elapsed. Closing connection now...\r\n");
        if (connection_handle != SL_BT_INVALID_CONNECTION_HANDLE) {
          sl_bt_connection_close(connection_handle);
        }
        break;
      }
      if (evt->data.evt_system_external_signal.extsignals == PERIODIC_TIMER_CALLBACK) {
        decrypt_adv = 1;
        break;
      }
      if (pairing_state == 0) {
        break;
      }
      if (evt->data.evt_system_external_signal.extsignals == ONESHOT_BTN_TIMER_CALLBACK) {
        btn_count = 0;
        sc = sl_bt_sm_passkey_confirm(connection_handle, 0);
        app_assert_status(sc);
        break;
      }
      if (evt->data.evt_system_external_signal.extsignals == CONFIRM_BTN) {
        btn_count++;
        if (btn_count == 2) {
          app_log("connection handle %d\r\n", connection_handle);
          sc = sl_bt_sm_passkey_confirm(connection_handle, 1);
          app_assert_status(sc);
          btn_count = 0;
        } else if (btn_count == 1) {
          sc = sl_sleeptimer_start_timer_ms(&oneshot_btn_timer_handle, BTN_CONFIRM_PERIOD_MS, oneshot_sleeptimer_callback, (void *)NULL, 0, 0);
          app_assert_status(sc);
        }
        break;
      }
  }
}
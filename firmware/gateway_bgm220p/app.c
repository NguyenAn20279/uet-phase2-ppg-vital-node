/***************************************************************************//**
 * @file
 * @brief Top level application functions
 *******************************************************************************
 * # License
 * <b>Copyright 2020 Silicon Laboratories Inc. www.silabs.com</b>
 *******************************************************************************
 *
 * The licensor of this software is Silicon Laboratories Inc. Your use of this
 * software is governed by the terms of Silicon Labs Master Software License
 * Agreement (MSLA) available at
 * www.silabs.com/about-us/legal/master-software-license-agreement. This
 * software is distributed to you in Source Code format and is governed by the
 * sections of the MSLA applicable to Source Code.
 *
 ******************************************************************************/

/***************************************************************************//**
 * Initialize application.
 ******************************************************************************/
#include "sl_i2cspm_instances.h"   
#include "ssd1306.h"
#include "sl_sleeptimer.h"
#include "app_log.h"
#include <stdio.h>
 
static sl_sleeptimer_timer_handle_t update_timer;
static volatile bool update_due = false;
static uint16_t counter = 0;
 
static void update_timer_callback(sl_sleeptimer_timer_handle_t *handle, void *data)
{
  (void)handle;
  (void)data;
  update_due = true; // chỉ set cờ trong callback, xử lý thật ở main loop
}
 
void app_init(void)
{
  if (ssd1306_init(sl_i2cspm_oled)) {
    app_log_info("OLED: khoi tao thanh cong\r\n");
 
    ssd1306_print_line(sl_i2cspm_oled, 0, "OLED TEST OK");
    ssd1306_print_line(sl_i2cspm_oled, 1, "BGM220P I2C");
  } else {
    app_log_error("OLED: khong tim thay man hinh / loi I2C\r\n");
    return;
  }
 
  // Cập nhật 1 dòng đếm số mỗi giây để xác nhận màn hình không bị treo/đứng hình
  sl_sleeptimer_start_periodic_timer_ms(&update_timer, 1000,
                                         update_timer_callback, NULL, 0, 0);
}
 
void app_process_action(void)
{
  if (update_due) {
    update_due = false;
 
    char line[17];
    snprintf(line, sizeof(line), "COUNT:%05u", counter);
    ssd1306_print_line(sl_i2cspm_oled, 3, line);
 
    counter++;
  }
}

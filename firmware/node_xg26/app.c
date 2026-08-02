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
#include "app_log.h"
#include "max30102.h"
#include "sl_i2cspm_instances.h"
#include "gpiointerrupt.h"
#include "em_gpio.h"

#define MAX30102_INT_PORT   gpioPortC
#define MAX30102_INT_PIN    0
 
static max30102_sample_t sample_buf[32];
static volatile bool data_ready_flag = false;

static void max30102_int_callback(uint8_t intNo)
{
  (void)intNo;
  data_ready_flag = true;
}
 
static void max30102_int_pin_init(void)
{
  // Cấu hình chân làm input, pull-up nội (phòng khi board chưa có pull-up ngoài)
  GPIO_PinModeSet(MAX30102_INT_PORT, MAX30102_INT_PIN, gpioModeInputPull, 1);
 
  GPIOINT_Init();
 
  // MAX30102 kéo INT xuống THẤP khi có sự kiện -> bắt cạnh xuống (falling edge)
  GPIOINT_CallbackRegister(MAX30102_INT_PIN, max30102_int_callback);

  max30102_clear_interrupt(sl_i2cspm_sensor);

  GPIO_ExtIntConfig(MAX30102_INT_PORT, MAX30102_INT_PIN, MAX30102_INT_PIN,
                     false,   // risingEdge = false
                     true,    // fallingEdge = true
                     true);   // enable ngay
}

void app_init(void)
{
    if (max30102_init(sl_i2cspm_sensor)) {
    app_log_info("MAX30102: khoi tao thanh cong\r\n");
    max30102_int_pin_init();
  } else {
    app_log_error("MAX30102: khoi tao that bai\r\n");
  }
}


void app_process_action(void)
{
  if (data_ready_flag) {
    data_ready_flag = false;
 
    uint8_t n = max30102_get_fifo_count(sl_i2cspm_sensor);
    if (n > 0) {
      uint8_t got = max30102_read_fifo_burst(sl_i2cspm_sensor, sample_buf, n);
      for (uint8_t i = 0; i < got; i++) {
        app_log_info("RED=%lu IR=%lu\r\n",
                      (unsigned long)sample_buf[i].red,
                      (unsigned long)sample_buf[i].ir);
      }
    }

    max30102_clear_interrupt(sl_i2cspm_sensor);
  }
}





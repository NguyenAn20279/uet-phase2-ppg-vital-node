#include "app_log.h"
#include "app_ml.h"
#include "max30102.h"
#include "filter.h"
#include "sl_i2cspm_instances.h"
#include "gpiointerrupt.h"
#include "em_gpio.h"

#define MAX30102_INT_PORT   gpioPortC
#define MAX30102_INT_PIN    0

static max30102_sample_t sample_buf[32];
static volatile bool data_ready_flag = false;

static ppg_filter_pipeline_t filter_red;
static ppg_filter_pipeline_t filter_ir;

static void max30102_int_callback(uint8_t intNo)
{
  (void)intNo;
  data_ready_flag = true;
}

static void max30102_int_pin_init(void)
{
  GPIO_PinModeSet(MAX30102_INT_PORT, MAX30102_INT_PIN, gpioModeInputPull, 1);
  GPIOINT_Init();
  GPIOINT_CallbackRegister(MAX30102_INT_PIN, max30102_int_callback);
  max30102_clear_interrupt(sl_i2cspm_sensor);
  GPIO_ExtIntConfig(MAX30102_INT_PORT, MAX30102_INT_PIN, MAX30102_INT_PIN,
                     false, true, true);
}

void app_init(void)
{
  if (max30102_init(sl_i2cspm_sensor)) {
    app_log_info("MAX30102: khoi tao thanh cong\r\n");
    max30102_int_pin_init();
  } else {
    app_log_error("MAX30102: khoi tao that bai\r\n");
  }

  ppg_filter_pipeline_init(&filter_red, 0.3f);
  ppg_filter_pipeline_init(&filter_ir, 0.3f);

  ml_init();
}

void app_process_action(void)
{
  if (data_ready_flag) {
    data_ready_flag = false;

    uint8_t n = max30102_get_fifo_count(sl_i2cspm_sensor);
    if (n > 0) {
      uint8_t got = max30102_read_fifo_burst(sl_i2cspm_sensor, sample_buf, n);
      for (uint8_t i = 0; i < got; i++) {
        float red_bp, ir_bp;
        // _ex() tra ve z-score qua return value, va bandpass-only qua bp_out
        float red_z = ppg_filter_pipeline_update_ex(&filter_red, (float)sample_buf[i].red, &red_bp);
        float ir_z  = ppg_filter_pipeline_update_ex(&filter_ir,  (float)sample_buf[i].ir,  &ir_bp);

        ml_push_sample(red_bp, ir_bp, red_z, ir_z,
                       sample_buf[i].red, sample_buf[i].ir);
      }
    }

    max30102_clear_interrupt(sl_i2cspm_sensor);
  }
}
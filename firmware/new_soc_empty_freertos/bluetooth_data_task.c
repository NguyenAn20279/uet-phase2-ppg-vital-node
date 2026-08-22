#include "bluetooth_data_task.h"
#include "app_log.h"
#include "FreeRTOS.h"
#include "task.h"

void bluetooth_data_task(void *p_arg)
{
  (void)p_arg;

  for (;;) {
    app_log_info("[BT Data] Task dang chay...\r\n");
    vTaskDelay(pdMS_TO_TICKS(1000));
  }
}
// filter_task.c
#include "filter_task.h"
#include "ppg_task.h"
#include "filter.h"
#include "app_log.h"
#include "FreeRTOS.h"
#include "task.h"

QueueHandle_t xFilterQueue = NULL;

static ppg_filter_pipeline_t filter_red;
static ppg_filter_pipeline_t filter_ir;

void filter_queue_create(void)
{
    xFilterQueue = xQueueCreate(32, sizeof(filtered_sample_t));
}

void filter_task(void *p_arg)
{
    (void)p_arg;
    ppg_raw_sample_t raw;
    uint32_t sample_index = 0;

    if (xFilterQueue == NULL) {
        app_log_error("[Filter] xFilterQueue chua duoc tao!\r\n");
        vTaskDelete(NULL);
        return;
    }

    ppg_filter_pipeline_init(&filter_red, 0.3f);
    ppg_filter_pipeline_init(&filter_ir,  0.3f);

    app_log_info("[Filter] Filter Task started\r\n");

    for (;;) {
        if (xQueueReceive(xPPGQueue, &raw, portMAX_DELAY) == pdPASS) {

            filtered_sample_t out;
            out.red_z = ppg_filter_pipeline_update_ex(&filter_red, (float)raw.red, &out.red_bp);
            out.ir_z  = ppg_filter_pipeline_update_ex(&filter_ir,  (float)raw.ir,  &out.ir_bp);
            out.red_raw = raw.red;
            out.ir_raw  = raw.ir;

            if (xQueueSend(xFilterQueue, &out, 0) != pdPASS) {
                // AI task xu ly chua kip -> drop, khong duoc block filter task
            }

            if ((sample_index % 100) == 0) {
                app_log_info(
                    "[Filter] RED_bp=%.2f IR_bp=%.2f | RED_z=%.2f IR_z=%.2f\r\n",
                    out.red_bp, out.ir_bp, out.red_z, out.ir_z
                );
            }
            sample_index++;
        }
    }
}
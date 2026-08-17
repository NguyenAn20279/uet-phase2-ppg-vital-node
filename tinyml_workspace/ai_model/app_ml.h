#ifndef APP_ML_H
#define APP_ML_H

#include <stdint.h>
#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

void ml_init(void);
void ml_reset(void);

// red_bp/ir_bp : tin hieu sau EMA+bandpass (chua z-score) -> dung cho vitals_compute()
// red_z/ir_z   : tin hieu sau z-score (running-window 200 mau) -> dung cho nhanh CNN
// red_raw/ir_raw: gia tri tho tu FIFO -> dung tinh DC cho SpO2/finger-detect
void ml_push_sample(float red_bp, float ir_bp,
                     float red_z,  float ir_z,
                     uint32_t red_raw, uint32_t ir_raw);

#ifdef __cplusplus
}
#endif

#endif // APP_ML_H
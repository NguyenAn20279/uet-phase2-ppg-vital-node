#ifndef VITALS_H
#define VITALS_H

#include <stdint.h>
#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

#define VITALS_FS_HZ            25
#define VITALS_WINDOW_SAMPLES   125   // 5s @ 25Hz

#define VITALS_IBI_MIN_S        0.3f   // 200 bpm
#define VITALS_IBI_MAX_S        1.5f   // 40 bpm
#define VITALS_R_MIN            0.1f
#define VITALS_R_MAX            3.0f

#define VITALS_MIN_IR_DC        50000.0f

typedef struct {
    float hr;              // bpm
    float spo2;             // %
    bool  hr_valid;
    bool  spo2_valid;
    bool  finger_detected;  // co dat ngon tay hay khong (dua vao DC cua kenh IR)
    int   num_peaks;        // de debug/log
} vitals_result_t;

void vitals_compute(const float *red_bp, const float *ir_bp,
                     const uint32_t *red_raw, const uint32_t *ir_raw,
                     int n, vitals_result_t *out);

#ifdef __cplusplus
}
#endif

#endif // VITALS_H
/**
 * @file    filter.c
 * @brief   Trien khai bo loc so cho PPG Filter Task
 *
 * Pipeline de nghi trong filter task:
 *      raw (25Hz, tu PPG task qua queue)
 *        -> EMA (khu nhieu tan so cao, muot tin hieu)
 *        -> IIR Bandpass SOS 0.5-5Hz (loai baseline wander + high-freq noise,
 *           giu lai dai tan nhip tim ~30-300 bpm)
 *        -> Z-score (chuan hoa bien do, window 200 mau ~ 8s)
 *        -> dua vao queue cho AI task
 */

#include "filter.h"
#include <math.h>
#include <string.h>

#define FS_HZ           25.0f
#define BPF_LOW_HZ      0.5f
#define BPF_HIGH_HZ     5.0f

void ema_filter_init(ema_filter_t *f, float alpha)
{
    f->alpha = alpha;
    f->y_prev = 0.0f;
    f->initialized = false;
}

float ema_filter_update(ema_filter_t *f, float x)
{
    if (!f->initialized) {
        f->y_prev = x;              
        f->initialized = true;
        return x;
    }
    // y[n] = alpha * x[n] + (1 - alpha) * y[n-1]
    float y = f->alpha * x + (1.0f - f->alpha) * f->y_prev;
    f->y_prev = y;
    return y;
}


void sos_filter_init(sos_filter_t *f)
{
    // Section 0
    f->sections[0].b0 = 0.1750876437f;
    f->sections[0].b1 = 0.3501752873f;
    f->sections[0].b2 = 0.1750876437f;
    f->sections[0].a1 = -0.4733854564f;
    f->sections[0].a2 =  0.2607010831f;
    f->sections[0].z1 = 0.0f;
    f->sections[0].z2 = 0.0f;

    // Section 1
    f->sections[1].b0 =  1.0000000000f;
    f->sections[1].b1 = -2.0000000000f;
    f->sections[1].b2 =  1.0000000000f;
    f->sections[1].a1 = -1.8256698997f;
    f->sections[1].a2 =  0.8425510982f;
    f->sections[1].z1 = 0.0f;
    f->sections[1].z2 = 0.0f;
}

// Xu ly 1 mau qua 1 bien the (Direct Form II Transposed)
static inline float biquad_process(biquad_t *bq, float x)
{
    float y = bq->b0 * x + bq->z1;
    bq->z1  = bq->b1 * x - bq->a1 * y + bq->z2;
    bq->z2  = bq->b2 * x - bq->a2 * y;
    return y;
}

float sos_filter_update(sos_filter_t *f, float x)
{
    float y = x;
    for (int i = 0; i < SOS_NUM_SECTIONS; i++) {
        y = biquad_process(&f->sections[i], y);
    }
    return y;
}


#define ZSCORE_MIN_SAMPLES  (int)(1.0f * FS_HZ)  // ~1s dau: chua du tin cay de chuan hoa

void zscore_filter_init(zscore_filter_t *f)
{
    memset(f->buffer, 0, sizeof(f->buffer));
    f->head = 0;
    f->count = 0;
    f->sum = 0.0f;
    f->sum_sq = 0.0f;
}

static void zscore_resync(zscore_filter_t *f)
{
    float sum = 0.0f, sum_sq = 0.0f;
    for (int i = 0; i < f->count; i++) {
        float v = f->buffer[i];
        sum    += v;
        sum_sq += v * v;
    }
    f->sum    = sum;
    f->sum_sq = sum_sq;
}

float zscore_filter_update(zscore_filter_t *f, float x)
{
    if (f->count < ZSCORE_WINDOW_SIZE) {
        // buffer chua day: chi them mau moi
        f->buffer[f->head] = x;
        f->sum    += x;
        f->sum_sq += x * x;
        f->count++;
    } else {
        // buffer day: loai mau cu nhat, them mau moi (circular)
        float old = f->buffer[f->head];
        f->sum    += x - old;
        f->sum_sq += x * x - old * old;
        f->buffer[f->head] = x;
    }
    f->head = (f->head + 1) % ZSCORE_WINDOW_SIZE;

    if (f->head == 0) {
        zscore_resync(f);
    }

    float n = (float)f->count;
    float mean = f->sum / n;
    float var  = (f->sum_sq / n) - (mean * mean);
    if (var < 1e-6f) var = 1e-6f;     
    float std = sqrtf(var);

    if (f->count < ZSCORE_MIN_SAMPLES) {
        return 0.0f;
    }

    return (x - mean) / std;
}

void ppg_filter_pipeline_init(ppg_filter_pipeline_t *p, float ema_alpha)
{
    ema_filter_init(&p->ema, ema_alpha);
    sos_filter_init(&p->sos);
    zscore_filter_init(&p->zscore);
}

float ppg_filter_pipeline_update_ex(ppg_filter_pipeline_t *p, float raw_sample, float *bp_out)
{
    float y1 = ema_filter_update(&p->ema, raw_sample);
    float y2 = sos_filter_update(&p->sos, y1);   // bandpass-only, chua z-score
    float y3 = zscore_filter_update(&p->zscore, y2);

    if (bp_out != NULL) {
        *bp_out = y2;
    }
    return y3;
}

float ppg_filter_pipeline_update(ppg_filter_pipeline_t *p, float raw_sample)
{
    return ppg_filter_pipeline_update_ex(p, raw_sample, NULL);
}
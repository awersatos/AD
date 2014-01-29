/** @file
 *      TMR3 Dual Timer Unit
 *
 * The dual timer unit peripheral devices are used to provide additional
 * functionality to microcontroller devices that do not inherently contain
 * dedicated timing units. The peripherals can be configured as counters or
 * timers and provide four distinct modes of operation.
 */

#ifndef DRV_TMR3_H_
#define DRV_TMR3_H_

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdbool.h>
#include <stdint.h>
#include <stddef.h>

typedef struct _tmr3_t  tmr3_t;

typedef void (*tmr3_handler)(tmr3_t *drv, void *data);

extern tmr3_t *drv_tmr3_open(int id);
extern int drv_tmr3_close(tmr3_t *drv);

extern int drv_tmr3_timer_a_start(tmr3_t *drv);
extern int drv_tmr3_timer_a_stop(tmr3_t *drv);
extern int drv_tmr3_timer_a_set_handler(tmr3_t *drv, tmr3_handler handler, void *data);
extern int drv_tmr3_timer_a_13bit_mode(tmr3_t *drv, bool gated, bool counter_mode, uint16_t value);
extern int drv_tmr3_timer_a_16bit_mode(tmr3_t *drv, bool gated, bool counter_mode, uint16_t value);
extern int drv_tmr3_timer_a_8bit_autoreload_mode(tmr3_t *drv, bool gated, bool counter_mode, uint8_t value);
extern int drv_tmr3_timer_a_dual_8bit_mode(tmr3_t *drv, bool gated, bool counter_mode, uint8_t val_1, uint8_t val_h);

extern int drv_tmr3_timer_b_start(tmr3_t *drv);
extern int drv_tmr3_timer_b_stop(tmr3_t *drv);
extern int drv_tmr3_timer_b_set_handler(tmr3_t *drv, tmr3_handler handler, void *data);
extern int drv_tmr3_timer_b_13bit_mode(tmr3_t *drv, bool gated, bool counter_mode, uint16_t value);
extern int drv_tmr3_timer_b_16bit_mode(tmr3_t *drv, bool gated, bool counter_mode, uint16_t value);
extern int drv_tmr3_timer_b_8bit_autoreload_mode(tmr3_t *drv, bool gated, bool counter_mode, uint8_t value);

#ifdef  __cplusplus
}
#endif

#endif /* ndef DRV_TMR3_H_ */

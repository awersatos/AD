/*****************************************************************************
|*
|*  COPYRIGHT:          Copyright (c) 2008, Altium
|*
|*  Description:        PWM8 peripheral device driver interface.
|*
|*****************************************************************************/

/**
 * @file
 * Device driver interface for WB_PWM8 peripheral.
 */

#ifndef _DRV_PWM8_H
#define _DRV_PWM8_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

typedef struct pwm8_s pwm8_t;

extern void pwm8_set_frequency(pwm8_t * restrict pwm8_drv, uint32_t frequency);
extern void pwm8_set_dutycycle(pwm8_t * restrict pwm8_drv, uint32_t dutycycle);

extern void pwm8_set_pulsewidth(pwm8_t * restrict pwm8_drv, uint8_t value);
extern void pwm8_set_prescaler(pwm8_t * restrict pwm8_drv, uint16_t value);

extern void pwm8_enable_controller(pwm8_t * restrict pwm8_drv);
extern void pwm8_disable_controller(pwm8_t * restrict pwm8_drv);
extern void pwm8_enable_interrupts(pwm8_t * restrict pwm8_drv);
extern void pwm8_disable_interrupts(pwm8_t * restrict pwm8_drv);
extern void pwm8_enable_prescaler_interrupt(pwm8_t * restrict pwm8_drv);
extern void pwm8_disable_prescaler_interrupt(pwm8_t * restrict pwm8_drv);
extern bool pwm8_prescaler_interrupt_flag(pwm8_t * restrict pwm8_drv);
extern void pwm8_clear_prescaler_interrupt_flag(pwm8_t * restrict pwm8_drv);
extern void pwm8_enable_pulsewidth_interrupt(pwm8_t * restrict pwm8_drv);
extern void pwm8_disable_pulsewidth_interrupt(pwm8_t * restrict pwm8_drv);
extern void pwm8_clear_pulsewidth_interrupt_flag(pwm8_t * restrict pwm8_drv);
extern bool pwm8_pulsewidth_interrupt_flag(pwm8_t * restrict pwm8_drv);

extern pwm8_t * pwm8_open(int id);

#ifdef  __cplusplus
}
#endif

#endif /* _DRV_PWM8_H */


/*****************************************************************************
|*
|*  COPYRIGHT:          Copyright (c) 2008, Altium
|*
|*  Description:        PWMX peripheral device driver interface.
|*
|*****************************************************************************/

/**
 * @file
 * Device driver interface for WB_PWMX peripheral.
 */

#ifndef _DRV_PWMX_H
#define _DRV_PWMX_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>


/**
 * @brief
 *  Resolution modes
 *
 *  This enum defines all supported word resolution modes.
 */
typedef enum
{
    PWMX_MODE_8BIT            = 0,   /**<  8 bits resolution         */
    PWMX_MODE_10BIT           = 1,   /**< 10 bits resolution         */
    PWMX_MODE_12BIT           = 2,   /**< 12 bits resolution         */
    PWMX_MODE_14BIT           = 3    /**< 14 bits resolution         */
} pwmx_mode_t;


typedef struct pwmx_s pwmx_t;

extern void pwmx_set_frequency(pwmx_t * restrict pwmx_drv, uint32_t frequency);
extern void pwmx_set_dutycycle(pwmx_t * restrict pwmx_drv, uint32_t dutycycle);

extern uint16_t pwmx_max_pulsewidth(pwmx_t * restrict pwmx_drv);
extern pwmx_mode_t pwmx_get_resolution_mode(pwmx_t * restrict pwmx_drv);
extern void pwmx_set_resolution_mode(pwmx_t * pwmx_drv, pwmx_mode_t mode);

extern void pwmx_set_pulsewidth(pwmx_t * restrict pwmx_drv, uint16_t value);
extern void pwmx_set_prescaler(pwmx_t * restrict pwmx_drv, uint16_t value);

extern void pwmx_enable_controller(pwmx_t * restrict pwmx_drv);
extern void pwmx_disable_controller(pwmx_t * restrict pwmx_drv);
extern void pwmx_enable_interrupts(pwmx_t * restrict pwmx_drv);
extern void pwmx_disable_interrupts(pwmx_t * restrict pwmx_drv);
extern void pwmx_enable_prescaler_interrupt(pwmx_t * restrict pwmx_drv);
extern void pwmx_disable_prescaler_interrupt(pwmx_t * restrict pwmx_drv);
extern bool pwmx_prescaler_interrupt_flag(pwmx_t * restrict pwmx_drv);
extern void pwmx_clear_prescaler_interrupt_flag(pwmx_t * restrict pwmx_drv);
extern void pwmx_enable_pulsewidth_interrupt(pwmx_t * restrict pwmx_drv);
extern void pwmx_disable_pulsewidth_interrupt(pwmx_t * restrict pwmx_drv);
extern void pwmx_clear_pulsewidth_interrupt_flag(pwmx_t * restrict pwmx_drv);
extern bool pwmx_pulsewidth_interrupt_flag(pwmx_t * restrict pwmx_drv);

extern pwmx_t * pwmx_open(int id);

#ifdef  __cplusplus
}
#endif

#endif /* _DRV_PWMX_H */


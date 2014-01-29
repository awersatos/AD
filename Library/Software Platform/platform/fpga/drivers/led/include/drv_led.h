/*****************************************************************************\
|*
|*  IN PACKAGE:         LED Controller Driver
|*
|*  COPYRIGHT:          Copyright (c) 2009, Altium
|*
|*  DESCRIPTION:        LED Controller Driver Interface
 */

/**
 * @file
 * This is the driver for the LED Controller.
 *
 * The WB_LED_CTRL component is a configurable LED Controller which controls
 * the intensity of LEDs within an FPGA design.
 *
 * To open an LED Controller driver, use the led_open() function.  The
 * intensity value of an LED when it is on can be set using the
 * led_set_on_intensity() function.  To turn an LED on/off, use either
 * led_turn_on() or led_turn_off().
 *
 * The LED IDs needed to change individual LED settings are specified in the
 * led_info.h header file.
 */


#ifndef _DRV_LED_H
#define _DRV_LED_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

typedef struct _led_s led_t;

extern void led_turn_on (led_t * restrict led_drv, uint8_t led_id);
extern void led_turn_off(led_t * restrict led_drv, uint8_t led_id);

extern void led_turn_all_on (led_t * restrict led_drv);
extern void led_turn_all_off(led_t * restrict led_drv);

extern void led_set_on_intensity    (led_t * restrict led_drv, uint8_t led_id, uint8_t intensity);
extern void led_set_all_on_intensity(led_t * restrict led_drv, uint8_t intensity);

extern void led_set_intensity(led_t * restrict led_drv, uint8_t led_id, uint8_t intensity);

extern led_t * led_open(int id);

#ifdef  __cplusplus
}
#endif

#endif /* _DRV_LED_H */

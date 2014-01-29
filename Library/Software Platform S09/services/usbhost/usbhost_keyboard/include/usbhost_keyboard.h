/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007, Altium
|*
|*  Description:        USB-Host Keyboard driver
|*
 *****************************************************************************/

/**
 * @file
 * Driver for USB-Host Keyboard
 */

#ifndef _DRV_USBHOST_KEYBOARD_H
#define _DRV_USBHOST_KEYBOARD_H

#include <stdint.h>
#include <stdbool.h>

typedef struct usbhost_keyboard_s usbhost_keyboard_t;

/**
 * @name scancode modifier key flags
 */
/** @{ */
#define USBHOST_KEYBOARD_MOD_LEFTCTRL    0x01  /**< Flag for LeftCtrl modifier key */
#define USBHOST_KEYBOARD_MOD_LEFTSHIFT   0x02  /**< Flag for LeftShift modifier key */
#define USBHOST_KEYBOARD_MOD_LEFTALT     0x04  /**< Flag for LeftAlt modifier key */
#define USBHOST_KEYBOARD_MOD_LEFTGUI     0x08  /**< Flag for LeftGui modifier key */
#define USBHOST_KEYBOARD_MOD_RIGHTCTRL   0x10  /**< Flag for RightCtrl modifier key */
#define USBHOST_KEYBOARD_MOD_RIGHTSHIFT  0x20  /**< Flag for RightShift modifier key */
#define USBHOST_KEYBOARD_MOD_RIGHTALT    0x40  /**< Flag for RightAlt modifier key */
#define USBHOST_KEYBOARD_MOD_RIGHTGUI    0x80  /**< Flag for RightGui modifier key */
/** @} */

/**
 * @name LED flags
 */
/** @{ */
#define USBHOST_KEYBOARD_LED_NUMLOCK     0x01  /**< Flag for NumLock LED */
#define USBHOST_KEYBOARD_LED_CAPSLOCK    0x02  /**< Flag for CapsLock LED */
#define USBHOST_KEYBOARD_LED_SCROLLOCK   0x04  /**< Flag for ScrollLock LED */
/** @} */

#define USBHOST_KEYBOARD_SCANCODE_TO_KEY


extern usbhost_keyboard_t *usbhost_keyboard_open(int id);

extern uint16_t usbhost_keyboard_get_scancode(usbhost_keyboard_t *drv);
extern int usbhost_keyboard_setleds(usbhost_keyboard_t *drv, uint8_t leds);

#endif /* _DRV_USBHOST_KEYBOARD_H */

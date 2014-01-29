/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007, Altium
|*
|*  Description:        USB-Host Mouse driver
|*
 *****************************************************************************/

/**
 * @file
 * Driver for USB-Host Mouse
 */

#ifndef _DRV_USBHOST_MOUSE_H
#define _DRV_USBHOST_MOUSE_H

#include <stdint.h>
#include <stdbool.h>

typedef struct usbhost_mouse_s usbhost_mouse_t;

/**
 * @name Mouse button flags
 */
/** @{ */
#define USBHOST_MOUSE_BUTTON_LEFT    0x1     /**< Flag for left mouse button (see usbhost_mouse_state_t) */
#define USBHOST_MOUSE_BUTTON_RIGHT   0x2     /**< Flag for right mouse button (see usbhost_mouse_state_t) */
#define USBHOST_MOUSE_BUTTON_MIDDLE  0x4     /**< Flag for middle mouse button (see usbhost_mouse_state_t) */
/** @} */


/**
 * @brief
 *      Mouse movement and button state
 *
 * This data structure holds information about the mouse's movement and button state.
 * The @em buttons field contains three flags: USBHOST_MOUSE_BUTTON_LEFT,
 * USBHOST_MOUSE_BUTTON_MIDDLE and USBHOST_MOUSE_BUTTON_RIGHT.
 *
 * @see
 *      usbhost_mouse_get_state
 */
typedef struct
{
    int16_t xmov;       /**< Movement in x direction */
    int16_t ymov;       /**< Movement in y direction */
    uint8_t buttons;    /**< Mouse button state */
} usbhost_mouse_state_t;

usbhost_mouse_t *usbhost_mouse_open(int id);

extern int usbhost_mouse_get_state(usbhost_mouse_t *drv, usbhost_mouse_state_t *state);


#endif /* _DRV_USBHOST_MOUSE_H */

/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    PS/2 mouse driver.
|*
\*****************************************************************************/

#ifndef _DRV_PS2MOUSE_H
#define _DRV_PS2MOUSE_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

#define PS2MOUSE_BUTTON_LEFT    0x1     /**< Flag for left mouse button (see ps2mouse_state_t) */
#define PS2MOUSE_BUTTON_RIGHT   0x2     /**< Flag for right mouse button (see ps2mouse_state_t) */
#define PS2MOUSE_BUTTON_MIDDLE  0x4     /**< Flag for middle mouse button (see ps2mouse_state_t) */

/**
 * @brief
 *      Mouse movement and button state
 *
 * This data structure holds information about the mouse's movement and button state.
 * The @em buttons field contains three flags: PS2MOUSE_BUTTON_LEFT,
 * PS2MOUSE_BUTTON_MIDDLE and PS2MOUSE_BUTTON_RIGHT.
 *
 * @see
 *      ps2mouse_get_state
 *      ps2mouse_install_callback
 */
typedef struct
{
    int16_t xmov;       /**< Movement in x direction */
    int16_t ymov;       /**< Movement in y direction */
    uint8_t buttons;    /**< Mouse button state */
} ps2mouse_state_t;

typedef struct ps2mouse_s ps2mouse_t;

extern ps2mouse_t *ps2mouse_open(int id);

extern int ps2mouse_set_streaming(ps2mouse_t *ps2mouse, bool streaming);

extern int ps2mouse_set_scaling(ps2mouse_t *ps2mouse, bool scale);

extern int ps2mouse_set_resolution(ps2mouse_t *ps2mouse, uint8_t val);

extern int ps2mouse_set_sample_rate(ps2mouse_t *ps2mouse, uint8_t rate);

extern void ps2mouse_install_callback(ps2mouse_t *ps2mouse,
                                      void (*mouse_event_callback) (ps2mouse_t *ps2mouse,
                                                                    ps2mouse_state_t *state,
                                                                    void *data),
                                      ps2mouse_state_t *state,
                                      void *data);

extern int ps2mouse_get_state(ps2mouse_t *ps2mouse, ps2mouse_state_t *state);

#ifdef  __cplusplus
}
#endif

#endif /* _DRV_PS2MOUSE_H */

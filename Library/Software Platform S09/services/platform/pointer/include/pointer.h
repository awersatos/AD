/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2007, Altium
|*
|*  Description:    POINTER services: Generic Interface 
|*
\*****************************************************************************/

#ifndef _POINTER_H
#define _POINTER_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>


/**
 * @brief
 *      Buttons and events
 *
 * This enum defines all possible buttons and events.
 * The value of pointer_state_t is an or-function of all relevant values.
 *
 * @see
 *      pointer_state_t
 */
typedef enum
{
    BUTTON_NONE         = 0x00, /**< no button down or button event */
    BUTTON_LEFT         = 0x01, /**< left button down */
    BUTTON_LEFT_EVENT   = 0x02, /**< left button event */
    BUTTON_RIGHT        = 0x04, /**< right button down */
    BUTTON_RIGHT_EVENT  = 0x08, /**< right button event */
    BUTTON_MIDDLE       = 0x10, /**< middle button down */
    BUTTON_MIDDLE_EVENT = 0x20, /**< middle button event */
} pointer_buttons_t;

typedef struct _pointer_s pointer_t;

/**
 * @brief
 *      Pointer state
 *
 * This struct contains the current state of the pointer.
 *
 */
typedef struct
{
    int                x;          /**< current x position */
    int                y;          /**< current y position */
    pointer_buttons_t  buttons;    /**< current buttons down and button events */
} pointer_state_t;

extern pointer_t * pointer_open( unsigned int id );
extern bool pointer_set_position(pointer_t *srv, int x, int y);
extern bool pointer_update( pointer_t *srv, pointer_state_t *state );

#ifdef  __cplusplus
}
#endif

#endif /* _POINTER_H */


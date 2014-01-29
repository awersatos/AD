/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2008, Altium
|*
|*  Description:
|*
\*****************************************************************************/

#include <stdlib.h>
#include <fcntl.h>
#include <errno.h>

#include <stdbool.h>
#include <stdint.h>

#include <pointer_i.h>      /* internal header */
#include <pointer.h>
#include <usbhost_mouse.h>   /* usbhost_mouse driver interface */

#include "ad_usbhostmouse_to_pointer_cfg_instance.h"

/* the device implementation */

static bool usbhostmouse_to_pointer_get_state( usbhost_mouse_t *drv, pointer_i_state_t *state )
{
    usbhost_mouse_state_t mstate;

    if ( usbhost_mouse_get_state ( drv, &mstate ) == 0 ) /* no error */
    {
        /* NOTE: For the graphics driver up is negative, down is positive,
         *       so we reverse the y direction here. */
        state->x = mstate.xmov;
        state->y = -mstate.ymov;
        state->buttons = mstate.buttons;
        state->relative = true;
        return true;
    }
    return false;
}

/* register devices with the pointer service */

void usbhostmouse_to_pointer_init( void )
{
    int id;
    int i = 0;

    for ( int drv_id = 0; drv_id < AD_USBHOSTMOUSE_TO_POINTER_INSTANCE_COUNT; drv_id++ )
    {
        id = ad_usbhostmouse_to_pointer_instance_table[drv_id].ad_pointer;

        for (i = 0; i < POINTER_MAX_INPUTS; i++)
        {
            if (pointer_table[id].input[i].open == NULL)
            {
                break;
            }
        }

        if (i < POINTER_MAX_INPUTS)
        {
            pointer_table[id].input[i].id = drv_id;
            pointer_table[id].input[i].open = (void*)usbhost_mouse_open;
            pointer_table[id].input[i].get_input = (void*)usbhostmouse_to_pointer_get_state;
        }
    }
}


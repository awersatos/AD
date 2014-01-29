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
#include <drv_ps2mouse.h>   /* ps2mouse driver interface */

#include "ad_ps2mouse_to_pointer_cfg_instance.h"

/* the device implementation */

static bool ps2mouse_to_pointer_get_state( ps2mouse_t *drv, pointer_i_state_t *state )
{
    ps2mouse_state_t mstate;

    if ( ps2mouse_get_state ( drv, &mstate ) == 0 ) /* no error */
    {
        /* NOTE: For the graphics driver up is negative, down is positive,
         *       so we reverse the y direction here. */
        state->x        = mstate.xmov;
        state->y        = -mstate.ymov;
        state->buttons  = mstate.buttons;
        state->relative = true;
        return true;
    }
    return false;
}

/* register devices with the pointer service */

void ps2mouse_to_pointer_init( void )
{
    int pointer_id;
    int drv_id;
    int i = 0;

    for ( int adaptor_id = 0; adaptor_id < AD_PS2MOUSE_TO_POINTER_INSTANCE_COUNT; adaptor_id++ )
    {
        pointer_id = ad_ps2mouse_to_pointer_instance_table[adaptor_id].ad_pointer;
        drv_id     = ad_ps2mouse_to_pointer_instance_table[adaptor_id].drv_ps2mouse;

        // there may be more than one device connected to this pointer service
        for (i = 0; i < POINTER_MAX_INPUTS; i++)
        {
            if (pointer_table[pointer_id].input[i].open == NULL)
            {
                break;
            }
        }

        if (i < POINTER_MAX_INPUTS)
        {
            pointer_table[pointer_id].input[i].id        = drv_id;
            pointer_table[pointer_id].input[i].open      = (void*)ps2mouse_open;
            pointer_table[pointer_id].input[i].get_input = (void*)ps2mouse_to_pointer_get_state;
        }
    }
}

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
#include <touchscreen.h>    /* touchscreen service interface */

#include "ad_touchscreen_to_pointer_cfg_instance.h"

/* the adaptor implementation */

static bool touchscreen_to_pointer_get_state( touchscreen_t *srv, pointer_i_state_t *state )
{
    touchscreen_data_t tdata;

    if ( touchscreen_get_pos( srv, &tdata ) )
    {
        if ( tdata.pendown )
        {
            state->x = tdata.x;
            state->y = tdata.y;
            state->buttons = 1;
            state->relative = false;
        }
        else
        {
            state->x = 0;
            state->y = 0;
            state->buttons = 0;
            state->relative = true;
        }
        return true;
    }
    return false;
}


/* register adaptor */

void touchscreen_to_pointer_init( void )
{
    int id;
    int i = 0;

    for ( int srv_id = 0; srv_id < AD_TOUCHSCREEN_TO_POINTER_INSTANCE_COUNT; srv_id++ )
    {
        id = ad_touchscreen_to_pointer_instance_table[srv_id].ad_pointer;

        for (i = 0; i < POINTER_MAX_INPUTS; i++)
        {
            if (pointer_table[id].input[i].open == NULL)
            {
                break;
            }
        }

        if (i < POINTER_MAX_INPUTS)
        {
            pointer_table[id].input[i].id = srv_id;
            pointer_table[id].input[i].open = (void*)touchscreen_open;
            pointer_table[id].input[i].get_input = (void*)touchscreen_to_pointer_get_state;
        }
    }
}



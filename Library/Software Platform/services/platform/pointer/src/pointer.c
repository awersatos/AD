/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2007, Altium
|*
|*  Description:    Interface for POINTER services
|*
\*****************************************************************************/

#include <stdlib.h>
#include <string.h>
#include <assert.h>

#include <stdbool.h>
#include <stdint.h>
#include <pointer.h>
#include <pointer_i.h>

#include "pointer_cfg.h"
#include "pointer_cfg_instance.h"

static const int button_table[] = 
{
    0,
    BUTTON_LEFT,
    BUTTON_RIGHT,
    BUTTON_RIGHT | BUTTON_LEFT,
    BUTTON_MIDDLE,
    BUTTON_MIDDLE | BUTTON_LEFT,
    BUTTON_MIDDLE | BUTTON_RIGHT,
    BUTTON_MIDDLE | BUTTON_RIGHT | BUTTON_LEFT
};


pointer_t pointer_table[POINTER_INSTANCE_COUNT];


static bool pointer_button_events(int *pointer_buttons, int buttons)
{
    bool result = false;
    int old_buttons;
    int new_buttons = 0;

    buttons = button_table[buttons];

    if (*pointer_buttons != buttons)
    {
        old_buttons  = *pointer_buttons;

        new_buttons  = (old_buttons & BUTTON_LEFT)   ^ (buttons & BUTTON_LEFT)   ? BUTTON_LEFT_EVENT   : 0;
        new_buttons |= (buttons & BUTTON_LEFT);
        new_buttons |= (old_buttons & BUTTON_RIGHT)  ^ (buttons & BUTTON_RIGHT)  ? BUTTON_RIGHT_EVENT  : 0;
        new_buttons |= (buttons & BUTTON_RIGHT);
        new_buttons |= (old_buttons & BUTTON_MIDDLE) ^ (buttons & BUTTON_MIDDLE) ? BUTTON_MIDDLE_EVENT : 0;
        new_buttons |= (buttons & BUTTON_MIDDLE);

        *pointer_buttons = new_buttons;
        result = true;
    }

    return result;
}


/**
 * @brief    Open an instance of the service
 *
 * The first time the function is called, it initializes both the pointer service and the input devices beneath.
 * Further attemps to open an already opened instance of the driver simply returns the same pointer.
 *
 * @param  id  valid driver id
 *
 * @return Context pointer
 */

pointer_t * pointer_open(unsigned int id)
{
    assert(id < POINTER_INSTANCE_COUNT);

    pointer_t * restrict srv = &pointer_table[id];
    // get configuration of driver (created by plugin system)
    const pointer_cfg_instance_t * restrict srv_cfg = &pointer_instance_table[id];

    if (!srv->input[0].device)
    {
        for (int i = 0; i < POINTER_MAX_INPUTS; i++)
        {
            if (!srv->input[i].device && srv->input[i].open)
            {
                srv->input[i].device = srv->input[i].open(srv->input[i].id);
            }
        }
        srv->boundary_left   = srv_cfg->left;
        srv->boundary_right  = srv_cfg->right;
        srv->boundary_top    = srv_cfg->top;
        srv->boundary_bottom = srv_cfg->bottom;
        srv->x               = (srv->boundary_left + srv->boundary_right) / 2;
        srv->y               = (srv->boundary_top + srv->boundary_bottom) / 2;
    }

    return srv;
}


/**
 * @brief    Update pointer position and button state
 *
 * This function updates the pointer position and button state.
 *
 * @param  srv    Context pointer as returned from pointer_open()
 * @param  state  Pointer to structure, this structure will be updated by the function
 *
 * @return True if the position and/or the button state is updated, false otherwise
 */

bool pointer_update(pointer_t *srv, pointer_state_t *state)
{
    bool result = false;
    bool valid_input = false;
    pointer_i_state_t ps;
    int x = srv->x;
    int y = srv->y;
    int buttons = 0;
    bool result_1;
    bool result_2;

    /* clear previous events */
    srv->buttons &= ~(BUTTON_LEFT_EVENT | BUTTON_MIDDLE_EVENT | BUTTON_RIGHT_EVENT);

    for (int i = 0; i < POINTER_MAX_INPUTS; i++)
    {
        if (srv->input[i].get_input && srv->input[i].get_input(srv->input[i].device, &ps))
        {
            if (ps.relative)
            {
                /* relative input */
                x += ps.x;
                y += ps.y;
            }
            else
            {
                /* absolute input */
                x = ps.x;
                y = ps.y;
            }
            srv->input[i].last_buttons = ps.buttons;
            valid_input = true;
        }
        buttons |= srv->input[i].last_buttons;
    }

    if (valid_input)
    {
        result_1 = pointer_set_position( srv, x, y );
        result_2 = pointer_button_events( &(srv->buttons), buttons);
        result = result_1 || result_2;
    }

    state->x = srv->x;
    state->y = srv->y;
    state->buttons = srv->buttons;

    return result;
}


/**
 * @brief    Set pointer position
 *
 * This function sets the pointer to the given position.
 * If the given position is outside the area boundaries, the position is set at the boundary.
 *
 * @param  srv    Service pointer as returned from graphics_open()
 * @param  x      New x-position
 * @param  y      New y-position
 *
 * @return True if the new position differs from the old position, otherwise false.
 */

bool pointer_set_position(pointer_t *srv, int x, int y)
{
    if ((x != srv->x) || (y != srv->y))
    {
        if ( x < srv->boundary_left )   x = srv->boundary_left;
        if ( x > srv->boundary_right )  x = srv->boundary_right;
        if ( y < srv->boundary_top )    y = srv->boundary_top;
        if ( y > srv->boundary_bottom ) y = srv->boundary_bottom;
        srv->x = x;
        srv->y = y;

        return true;
    }
    return false;
}



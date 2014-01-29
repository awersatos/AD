/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2007, Altium
|*
|*  Description:    POINTER platform device handler
|*
\*****************************************************************************/

#ifndef _POINTER_I_H
#define _POINTER_I_H

#include <stdint.h>
#include <stdbool.h>

#include <pointer.h>
#include "pointer_cfg.h"

#define POINTER_MAX_INPUTS 3

typedef struct
{
    int                x;          /**< current x position */
    int                y;          /**< current y position */
    pointer_buttons_t  buttons;    /**< current buttons down and button events */
    bool               relative;   /**< position is relative */
} pointer_i_state_t;

typedef struct
{
    int     id;
    void    *device;
    void*   (*open)(int);
    bool    (*get_input)(void*, pointer_i_state_t*);
    int     last_buttons;
} pointer_input_t ;

struct _pointer_s
{
    pointer_input_t input[POINTER_MAX_INPUTS];
    int x;
    int y;
    int buttons;
    int boundary_left;
    int boundary_right;
    int boundary_top;
    int boundary_bottom;
};


extern pointer_t pointer_table[POINTER_INSTANCE_COUNT];


#endif  // _POINTER_I_H

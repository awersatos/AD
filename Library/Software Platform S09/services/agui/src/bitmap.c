/*****************************************************************************\
|*
|*  IN PACKAGE:     Agui
|*
|*  COPYRIGHT:      Copyright (c) 2008, Altium
|*
|*  DESCRIPTION:    Separator routines
|*
 */

#include <stdlib.h>
#include <graphics.h>
#include <pointer.h>
#include <agui.h>
#include <agui_i.h>
#include "agui_cfg.h"


/**
 * @brief    Draw a bitmap
 *
 * Draw an bitmap on the canvas.
 *
 * @see
 *     bitmap_t
 *
 * @param obj    Pointer to the object member of the bitmap
 *
 * @return Nothing
 */

void bitmap_draw(obj_t *obj)
{
    bitmap_t * restrict bitmap = (bitmap_t*)obj;
    obj_t *parent = obj->parent;
    int x = obj->x;
    int y = obj->y;
    int agui_index = obj->agui_index;
    agui_t * restrict agui;
    canvas_t * restrict canvas;
    pointer_t * restrict pointer;

    obj->invalidated = false;

    if (bitmap->bm)
    {
        while (parent != NULL)
        {
            x += parent->x;
            y += parent->y;
            agui_index = parent->agui_index;
            parent = parent->parent;
        }
        agui = &agui_table[agui_index];
        canvas = agui->canvas;
        pointer = agui->pointer;

        graphics_draw_bitmap(canvas, bitmap->bm, x, y, obj->width, obj->height, 0);
    }
}


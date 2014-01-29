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
 * @brief    Draw a bevel
 *
 * Draw an bevel on the canvas.
 *
 * @see
 *     bevel_t
 *
 * @param obj    Pointer to the object member of the bevel
 *
 * @return Nothing
 */

void bevel_draw(obj_t *obj)
{
    bevel_t *bevel = (bevel_t*)obj;
    obj_t *parent = obj->parent;
#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D
    relief_t relief;
    int thickness;
#endif    
    int x1 = obj->x;
    int x2;
    int y1 = obj->y;
    int y2;
    int w = obj->width;
    int h = obj->height;
    int agui_index = obj->agui_index;
    agui_t * restrict agui;
    canvas_t * restrict canvas;

    obj->invalidated = false;

    /* add position of parent(s) to own position */
    while (parent != NULL)
    {
        x1 += parent->x;
        y1 += parent->y;
        agui_index = parent->agui_index;
        parent = parent->parent;
    }
    agui = &agui_table[agui_index];
    canvas = agui->canvas;
    x2 = x1 + w - 1;
    y2 = y1 + h - 1;


    cursor_hide(agui);

#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D

    relief = bevel->relief;
    thickness = relief == RELIEF_FLAT ? 1 : 2;

    switch (bevel->outline)
    {
    case OUTLINE_LEFT:
        agui_draw_outline_3d(agui, x1, y1, thickness, h, false, false, relief);
        break;
    case OUTLINE_TOP:
        agui_draw_outline_3d(agui, x1, y1, w, thickness, true, true, relief);
        break;
    case OUTLINE_RIGHT:
        agui_draw_outline_3d(agui, x2 - thickness, y1, thickness, h, false, false, relief);
        break;
    case OUTLINE_BOTTOM:
        agui_draw_outline_3d(agui, x1, y2 - thickness, w, thickness, true, true, relief);
        break;
    case OUTLINE_FRAME:
        agui_draw_outline_3d(agui, x1, y1, w, h, true, true, relief);
        if (relief == RELIEF_LOWERED)
        {
            agui_draw_outline_3d(agui, x1+1, y1+1, w-2, h-2, true, true, RELIEF_RAISED);
        }
        else if (relief == RELIEF_RAISED)
        {
            agui_draw_outline_3d(agui, x1+1, y1+1, w-2, h-2, true, true, RELIEF_LOWERED);
        }
        break;
    case OUTLINE_PANEL:
        agui_draw_outline_3d(agui, x1, y1, w, h, true, true, relief);
        break;
    }

#elif AGUI_APPEARANCE==AGUI_APPEARANCE_2D

    switch (bevel->outline)
    {
    case OUTLINE_LEFT:
        graphics_draw_line(canvas, x1, y1, x1, y2, agui->palette.outline);
        break;
    case OUTLINE_TOP:
        graphics_draw_line(canvas, x1, y1, x2, y1, agui->palette.outline);
        break;
    case OUTLINE_RIGHT:
        graphics_draw_line(canvas, x2, y1, x2, y2, agui->palette.outline);
        break;
    case OUTLINE_BOTTOM:
        graphics_draw_line(canvas, x1, y2, x2, y2, agui->palette.outline);
        break;
    case OUTLINE_FRAME:
    case OUTLINE_PANEL:
        agui_draw_outline_2d(agui, x1, y1, x2 - x1 + 1, y2 - y1 + 1, true, true);
        break;
    }

#endif
    cursor_show(agui);
}




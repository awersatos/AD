/*****************************************************************************\
|*
|*  IN PACKAGE:     Agui
|*
|*  COPYRIGHT:      Copyright (c) 2008, Altium
|*
|*  DESCRIPTION:    Panel routines
|*
 */

#include <stdlib.h>
#include <graphics.h>
#include <pointer.h>
#include <agui.h>
#include <agui_i.h>
#include "agui_cfg.h"


/**
 * @brief    Draw a panel
 *
 * Draw an panel on the canvas.
 *
 * @see
 *     panel_t
 *
 * @param obj    Pointer to the object member of the panel
 *
 * @return Nothing
 */

bool begin_paneldraw(obj_t* obj, draw_struct_t* draw_struct)
{
    panel_t *panel = (panel_t*)obj;
    obj_t **objects = panel->children;
    obj_t *o = NULL;    // object
    obj_t *op;          // object his parent
    int ox, oy;         // object his x, object his y
    int iw;
    int ih;
    unsigned int agui_index = obj->agui_index;
    agui_t * restrict agui;
    canvas_t * restrict canvas;
    bool result = false;

    agui = &agui_table[agui_index];
    canvas = agui->canvas;

    if (obj->invalidated)
    {
        obj->invalidated = false;
        obj->invalidated_child = true;
        panel->invalidated_area.width = panel->invalidated_area.height = 0;
        if (obj->visible)
        {
            for (int i = panel->n_children - 1; i >= 0; i--)
            {
                if (objects[i] != NULL)
                {
                    o = objects[i];
                    if (o->draw != NULL && o->visible)
                    {
                        o->invalidated = true;
                    }
                }
            }
        }
        result = true;
    }
    else if (panel->invalidated_area.width && panel->invalidated_area.height)
    {
        iw = panel->invalidated_area.width;
        ih = panel->invalidated_area.height;
        panel->invalidated_area.width = panel->invalidated_area.height = 0;
        graphics_set_pane(canvas,
                          panel->invalidated_area.x,
                          panel->invalidated_area.y,
                          iw,
                          ih);
        for (int i = panel->n_children - 1; i >= 0; i--)
        {
            if (objects[i] != NULL)
            {
                o = objects[i];
                if (o->draw != NULL && o->visible)
                {
                    op = o->parent;
                    ox = o->x;
                    oy = o->y;
                    while (op)
                    {
                        ox += op->x;
                        oy += op->y;
                        op  = op->parent;
                    }
                    if ((ox < (panel->invalidated_area.x + iw)) &&
                        ((ox + o->width) > panel->invalidated_area.x) &&
                        (oy < (panel->invalidated_area.y + ih)) &&
                        ((oy + o->height) > panel->invalidated_area.y))
                    {
                        o->invalidated = true;
                        obj->invalidated_child = true;
                    }
                }
            }
        }
        result = true;
    }
    cursor_hide(agui);

    draw_struct->agui = agui;
    draw_struct->graphics = draw_struct->agui->graphics;
    draw_struct->canvas = draw_struct->agui->canvas;
    draw_struct->x1 = obj->x;
    draw_struct->y1 = obj->y;
    draw_struct->x2 = draw_struct->x1 + obj->width - 1;
    draw_struct->y2 = draw_struct->y1 + obj->height - 1;

    return result;
}

void end_paneldraw(obj_t* obj, draw_struct_t* draw_struct)
{
    panel_t *panel = (panel_t*)obj;
    obj_t **objects = panel->children;
    obj_t *o = NULL;    // object
    canvas_t * restrict canvas = draw_struct->canvas;

    graphics_set_pane(canvas, 0, 0, canvas_get_width(canvas), canvas_get_height(canvas));

    if (obj->invalidated_child)
    {
        obj->invalidated_child = false;
        for (int i = panel->n_children - 1; i >= 0; i--)
        {
            if (objects[i] != NULL)
            {
                o = objects[i];
                if (o->invalidated || o->invalidated_child)
                {
                    if (o->draw && o->visible)
                    {
                        o->draw(o);
                    }
                }
            }
        }
    }
    cursor_show(draw_struct->agui);
}

static void _draw_empty_panel(agui_t *agui, panel_t *panel)
{
    obj_t *parent = panel->obj.parent;
#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D
    int thickness;
#endif
    relief_t relief;
    int x1 = panel->obj.x;
    int x2;
    int y1 = panel->obj.y;
    int y2;
    int w = panel->obj.width;
    int h = panel->obj.height;
    int agui_index = panel->obj.agui_index;
    color_t color;
    canvas_t * restrict canvas;

    panel->obj.invalidated = false;

    /* add position of parent(s) to own position */
    while (parent != NULL)
    {
        x1 += parent->x;
        y1 += parent->y;
        parent = parent->parent;
    }
    canvas = agui->canvas;
    x2 = x1 + w - 1;
    y2 = y1 + h - 1;


    //cursor_hide(agui);

#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D

    relief = panel->relief;
    color = panel->obj.enabled ? agui->palette.form : agui->palette.disabled_light;
    thickness = relief == RELIEF_FLAT ? 1 : 2;

    switch (panel->outline)
    {
    case OUTLINE_LEFT:
        agui_draw_body_3d(agui, x1, y1, thickness, h, false, false, relief, color);
        break;
    case OUTLINE_TOP:
        agui_draw_body_3d(agui, x1, y1, w, thickness, relief != RELIEF_FLAT, true, relief, color);
        break;
    case OUTLINE_RIGHT:
        agui_draw_body_3d(agui, x2 - thickness, y1, thickness, h, false, false, relief, color);
        break;
    case OUTLINE_BOTTOM:
        agui_draw_body_3d(agui, x1, y2 - thickness, w, thickness, relief != RELIEF_FLAT, true, relief, color);
        break;
    case OUTLINE_FRAME:
        if ((relief == RELIEF_LOWERED) || (relief == RELIEF_RAISED))
            agui_draw_outline_3d(agui, x1, y1, w, h, true, true, relief);
        else
            agui_draw_body_3d   (agui, x1, y1, w, h, true, true, relief, color);
        if (relief == RELIEF_LOWERED)
        {
            agui_draw_body_3d(agui, x1+1, y1+1, w-2, h-2, true, true, RELIEF_RAISED, color);
        }
        else if (relief == RELIEF_RAISED)
        {
            agui_draw_outline_3d(agui, x1+1, y1+1, w-2, h-2, true, true, RELIEF_LOWERED);
        }
        break;
    case OUTLINE_PANEL:
        agui_draw_body_3d(agui, x1, y1, w, h, true, true, relief, color);
        break;
    }

#elif AGUI_APPEARANCE==AGUI_APPEARANCE_2D

    relief = panel->relief;
    color = panel->obj.enabled ? agui->palette.form : agui->palette.disabled_light;

    switch (panel->outline)
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
        agui_draw_body_2d(agui, x1, y1, x2 - x1 + 1, y2 - y1 + 1, true, true, color, relief);
        break;
    }

#endif
    //cursor_show(agui);
}

void panel_draw(obj_t *obj)
{
    if (!obj->visible)
        return;

    struct draw_struct_t draw_struct;
    if (begin_paneldraw(obj, &draw_struct))
    {
        _draw_empty_panel(draw_struct.agui, (panel_t*)obj);
    }
    end_paneldraw(obj, &draw_struct);
}

/**
 * @brief    Handler for panel
 *
 * This function is the handler for the panel. The input event may result in one or more actions.
 *
 * @see
 *     panel_t
 *
 * @param obj    Pointer to the object member of the panel
 * @param input  Pointer to the input event (location and button state)
 *
 * @return Nothing
 */

void panel_handler(obj_t *obj, const input_event_t *input)
{
    panel_t *panel = (panel_t*)obj;
    uint8_t i;
    obj_t **objects = panel->children;
    obj_t *cur_obj = NULL;
    obj_t *parent;
    int32_t x, y;
    action_event_t action;
    const input_event_t input_leave = {0, 0, ACTION_LEAVED};

    for (i = 0; i < panel->n_children; i++)
    {
        if (objects[i] != NULL)
        {
            cur_obj = objects[i];
            parent = cur_obj->parent;
            x = cur_obj->x;
            y = cur_obj->y;
            while (parent != NULL)
            {
                x += parent->x;
                y += parent->y;
                parent = parent->parent;
            }
            if (x <= input->x &&
                x + cur_obj->width >= input->x &&
                y <= input->y &&
                y + cur_obj->height >= input->y)
            {
                if (cur_obj->handler != NULL && cur_obj->visible)
                {
                    break;
                }
            }
        }
    }
    if (i == panel->n_children)
    {
        cursor_set_shape(&agui_table[obj->agui_index], obj->cursor_shape);

        cur_obj = NULL;
        if ( input->buttons & BUTTON_LEFT_EVENT )
        {
            action.x = input->x;
            action.y = input->y;
            action.button = BUTTON_LEFT;
            action.event = input->buttons & BUTTON_LEFT ? ACTION_PRESSED : ACTION_RELEASED;
            obj_store_action(obj, obj->action, &action );
        }
    }
    if (panel->last_child != cur_obj)
    {
        if ((panel->last_child != NULL) && (panel->last_child->handler != NULL))
        {
            panel->last_child->handler(panel->last_child, &input_leave);
        }
        panel->last_child = cur_obj;
    }

    if ((cur_obj != NULL) && (cur_obj->handler != NULL) && cur_obj->visible)
    {
        cursor_set_shape(&agui_table[obj->agui_index], cur_obj->cursor_shape);
        cur_obj->handler(cur_obj, input);
    }
}


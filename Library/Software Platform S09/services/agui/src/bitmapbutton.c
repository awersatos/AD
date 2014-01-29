#include <stdlib.h>
#include <graphics.h>
#include <pointer.h>
#include <agui.h>
#include <agui_i.h>
#include "agui_cfg.h"


/**
 * @brief    Draw a bitmap-button
 *
 * Draw a bitmap-button on the canvas.
 *
 * @see
 *     bitmapbutton_t
 *
 * @param obj    Pointer to the object member of the bitmap-button
 *
 * @return Nothing
 */

void bitmapbutton_draw( obj_t *obj )
{
    bitmapbutton_t *bbutton = (bitmapbutton_t*)obj;
    obj_t *parent = obj->parent;
    int x1;
    int x2;
    int y1;
    int y2;
    int w = obj->width;
    int h = obj->height;
    int z;
    canvas_t * restrict canvas;
    agui_t * restrict agui;
    unsigned int agui_index = obj->agui_index;
#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D
    relief_t relief;
#endif

    obj->invalidated = false;

    x1 = bbutton->obj.x;
    y1 = bbutton->obj.y;
    while (parent != NULL)
    {
        x1 += parent->x;
        y1 += parent->y;
        agui_index = parent->agui_index;
        parent = parent->parent;
    }
    x2 = x1 + w - 1;
    y2 = y1 + h - 1;
    agui = &agui_table[agui_index];
    canvas = agui->canvas;

    cursor_hide(agui);

#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D

    switch (bbutton->relief)
    {
    case RELIEF_FLAT:
        relief = RELIEF_FLAT;
        break;
    case RELIEF_LOWERED:
    case RELIEF_RAISED:
        relief = bbutton->pressed ? RELIEF_LOWERED : RELIEF_RAISED;
        break;
    default:
        relief = RELIEF_NONE;
        break;
    }

    if (relief != RELIEF_NONE)
    {
        agui_draw_outline_3d(agui, x1, y1, w, h, true, true, relief);
        x1++;
        y1++;
        w -= 2;
        h -= 2;
    }

#endif

    z = bbutton->fit ? 0 : 100;
    graphics_draw_bitmap(canvas, bbutton->bm, x1, y1, w, h, z);

    cursor_show(agui);
}


/**
 * @brief    Handler for bitmap-button
 *
 * This function is the handler for the bitmap-button. The input event may result in one or more actions.
 *
 * @see
 *     bitmapbutton_t
 *
 * @param obj    Pointer to the object member of the bitmap-button
 * @param input  Pointer to the input event (location and button state)
 *
 * @return Nothing
 */

void bitmapbutton_handler( obj_t *obj, const input_event_t *input )
{
    bitmapbutton_t *bbutton = (bitmapbutton_t*)obj;
    action_event_t action;
    bool was_pressed;

    action.x = input->x;
    action.y = input->y;

    if ( obj->enabled )
    {
        if ( input->buttons == ACTION_LEAVED )
        {
            if (bbutton->pressed)
            {
                bbutton->pressed = false;
                obj_invalidate(obj);
            }
            action.button = BUTTON_NONE;
            action.event = ACTION_LEAVED;
            obj_store_action(obj, obj->action, &action);
        }
        else if ( input->buttons & BUTTON_LEFT_EVENT )
        {
            action.button = BUTTON_LEFT;

            if (input->buttons & BUTTON_LEFT)
            {
                bbutton->pressed = true;
                obj_invalidate(obj);
                action.event = ACTION_PRESSED;
                obj_store_action(obj, obj->action, &action);
            }
            else
            {
                was_pressed = bbutton->pressed;
                bbutton->pressed = false;
                obj_invalidate(obj);
                action.event = ACTION_RELEASED;
                obj_store_action(obj, obj->action, &action);
                if (was_pressed)
                {
                    action.event = ACTION_CLICKED;
                    obj_store_action(obj, obj->action, &action);
                }
            }
        }
    }
    else if ( bbutton->pressed )
    {
        bbutton->pressed = 0;
        obj_invalidate(obj);
    }
}




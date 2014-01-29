#include <stdlib.h>
#include <graphics.h>
#include <pointer.h>
#include <agui.h>
#include <agui_i.h>
#include "agui_cfg.h"


/**
 * @brief    Draw a button
 *
 * Draw a button on the canvas.
 *
 * @see
 *     button_t
 *
 * @param obj    Pointer to the object member of the button
 *
 * @return Nothing
 */

void button_draw( obj_t *obj )
{
    button_t *button = (button_t*)obj;
    obj_t *parent = obj->parent;
    int x1 = obj->x;
    int x2;
    int y1 = obj->y;
    int y2;
    int w = obj->width;
    int h = obj->height;
    color_t color;
    uint8_t button_move = 0;
    graphics_t * restrict graphics;
    agui_t * restrict agui;
    unsigned int agui_index = obj->agui_index;
    relief_t relief = button->relief;

    obj->invalidated = false;
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
    graphics = agui->graphics;

    cursor_hide(agui);

#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D

    switch (relief)
    {
    case RELIEF_FLAT:
        color = obj->pressed ? agui->palette.pressed : button->color;
        relief = RELIEF_FLAT;
        break;
    case RELIEF_LOWERED:
    case RELIEF_RAISED:
        color = button->color;
        relief = obj->pressed ? RELIEF_LOWERED : RELIEF_RAISED;
        button_move = 1;
        break;
    default:
        color = obj->pressed ? agui->palette.pressed : button->color;
        relief = RELIEF_NONE;
        break;
    }

    agui_draw_body_3d(agui, x1, y1, w, h, true, true, relief, color);

#elif AGUI_APPEARANCE==AGUI_APPEARANCE_2D

    color = obj->pressed ? agui->palette.pressed : button->color;

    agui_draw_body_2d(agui, x1, y1, w, h, true, true, color, relief);
    x1++;
    y1++;
    x2--;
    y2--;

#endif


#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D
    if (obj->pressed && button_move)
    {
        agui_draw_string(agui, x1+1, y1+1, x2+1, y2+1, &button->label, obj->enabled);
    }
    else
#endif
    {
        agui_draw_string(agui, x1, y1, x2, y2, &button->label, obj->enabled);
    }

    cursor_show(agui);
}


/**
 * @brief    Handler for button
 *
 * This function is the handler for the button. The input event may result in one or more actions.
 *
 * @see
 *     button_t
 *
 * @param obj    Pointer to the object member of the button
 * @param input  Pointer to the input event (location and button state)
 *
 * @return Nothing
 */

void button_handler( obj_t *obj, const input_event_t *input )
{
    button_t *button = (button_t*)obj;
    action_event_t action;
    bool was_pressed;

    action.x = input->x;
    action.y = input->y;

    if ( obj->enabled )
    {
        if ( input->buttons == ACTION_LEAVED )
        {
            if (obj->pressed)
            {
                obj->pressed = false;
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
                obj->pressed = true;
                obj_invalidate(obj);
                action.event = ACTION_PRESSED;
                obj_store_action(obj, obj->action, &action);
            }
            else
            {
                was_pressed = obj->pressed;
                obj->pressed = false;
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
    else if ( obj->pressed )
    {
        obj->pressed = 0;
        obj_invalidate(obj);
    }
}




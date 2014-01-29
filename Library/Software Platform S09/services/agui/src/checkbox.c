#include <stdlib.h>
#include <graphics.h>
#include <pointer.h>
#include <agui.h>
#include <agui_i.h>
#include "agui_cfg.h"


/**
 * @brief    Draw a checkbox
 *
 * Draw a checkbox on the canvas.
 *
 * @see
 *     checkbox_t
 *
 * @param obj    Pointer to the object member of the checkbox
 *
 * @return Nothing
 */

void checkbox_draw(obj_t *obj)
{
    checkbox_t *checkbox = (checkbox_t*)obj;
    obj_t *parent = obj->parent;
    color_t checkcolor, color;
    int x1 = obj->x;
    int y1 = obj->y;
    int x2;
    int y2;
    int checkbox_size = AGUI_CHECKBOX_SIZE;
    canvas_t * restrict canvas;
    agui_t * restrict agui;
    unsigned int agui_index = obj->agui_index;
    bool draw_label = obj->invalidated;

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
    checkcolor = agui->palette.edittext;
    x2 = x1 + AGUI_CHECKBOX_SIZE - 1;
    y2 = y1 + AGUI_CHECKBOX_SIZE - 1;

    cursor_hide(agui);

#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D

    /* draw outline */
    if (checkbox->pressed)
    {
        color = agui->palette.pressed;
    }
    else if (!obj->enabled)
    {
        color = agui->palette.disabled;
    }
    else
    {
        color = checkbox->color;
    }

    agui_draw_body_3d(agui, x1, y1, AGUI_CHECKBOX_SIZE, AGUI_CHECKBOX_SIZE, true, true, checkbox->relief, color);

#elif AGUI_APPEARANCE==AGUI_APPEARANCE_2D

    /* draw outline */
    if (checkbox->pressed)
    {
        color = agui->palette.pressed;
    }
    else if (!obj->enabled)
    {
        color = agui->palette.disabled;
    }
    else
    {
        color = checkbox->color;
    }

    agui_draw_body_2d(agui, x1, y1, checkbox_size, checkbox_size, true, true, color);

#endif
    if ( checkbox->checked )
    {
        graphics_draw_arc( canvas, x1 - 5 * checkbox_size, y1 - 1 + (5 * checkbox_size) + (checkbox_size / 4), 7 * checkbox_size, 40, 3, checkcolor );
        graphics_draw_arc( canvas, x1 + 6 * checkbox_size, y1 - 2 + (5 * checkbox_size), 7 * checkbox_size, 138, 5, checkcolor );

        graphics_draw_arc( canvas, x1 - 5 * checkbox_size, y1     + (5 * checkbox_size) + (checkbox_size / 4), 7 * checkbox_size, 40, 3, checkcolor );
        graphics_draw_arc( canvas, x1 + 6 * checkbox_size, y1 - 1 + (5 * checkbox_size), 7 * checkbox_size, 138, 5, checkcolor );

#if AGUI_CHECKBOX_SIZE >= 20
        graphics_draw_arc( canvas, x1 - 5 * checkbox_size, y1 + 1 + (5 * checkbox_size) + (checkbox_size / 4), 7 * checkbox_size, 40, 3, checkcolor );
        graphics_draw_arc( canvas, x1 + 6 * checkbox_size, y1     + (5 * checkbox_size), 7 * checkbox_size, 138, 5, checkcolor );
#endif
#if AGUI_CHECKBOX_SIZE >= 30
        graphics_draw_arc( graphics, x1 - 5 * checkbox_size, y1 + 2 + (5 * checkbox_size) + (checkbox_size / 4), 7 * checkbox_size, 40, 3, checkcolor );
        graphics_draw_arc( graphics, x1 + 6 * checkbox_size, y1 + 1 + (5 * checkbox_size), 7 * checkbox_size, 138, 5, checkcolor );
#endif
    }

    if (draw_label)
    {
        agui_draw_string( agui, x2 + 2, y1, x1 - 2, y2, &checkbox->label, obj->enabled);
    }

    cursor_show(agui);
}


/**
 * @brief    Handler for checkbox
 *
 * This function is the handler for the checkbox. The input event may result in one or more actions.
 *
 * @see
 *     checkbox_t
 *
 * @param obj    Pointer to the object member of the checkbox
 * @param input  Pointer to the input event (location and button state)
 *
 * @return Nothing
 */

void checkbox_handler(obj_t *obj, const input_event_t *input)
{
    checkbox_t *checkbox = (checkbox_t*)obj;
    action_event_t action;
    bool was_pressed;

    action.x = input->x;
    action.y = input->y;

    if ( obj->enabled )
    {
        if ( input->buttons == ACTION_LEAVED )
        {
            if (checkbox->pressed)
            {
                checkbox->pressed = false;
                obj_invalidate_child(obj);
            }
            action.button = BUTTON_NONE;
            action.event = ACTION_LEAVED;
            obj_store_action(obj, obj->action, &action);
        }
        else if ( input->buttons & BUTTON_LEFT_EVENT )
        {
            action.button = BUTTON_LEFT;
            if ( input->buttons & BUTTON_LEFT )
            {
                checkbox->pressed = true;
                action.event = ACTION_PRESSED;
                obj_invalidate_child(obj);
                obj_store_action(obj, obj->action, &action);
            }
            else
            {
                was_pressed = checkbox->pressed;
                checkbox->pressed = false;
                if (was_pressed)
                {
                    checkbox->checked = !checkbox->checked;
                    obj_invalidate_child(obj);
                    action.event = ACTION_RELEASED;
                    obj_store_action(obj, obj->action, &action);
                    action.event = ACTION_CLICKED;
                    obj_store_action(obj, obj->action, &action);
                }
                else
                {
                    obj_invalidate_child(obj);
                    action.event = ACTION_RELEASED;
                    obj_store_action(obj, obj->action, &action);
                }
            }
        }
    }
}

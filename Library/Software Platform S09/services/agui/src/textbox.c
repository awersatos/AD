#include <stdlib.h>
#include <canvas.h>
#include <pointer.h>
#include <agui.h>
#include <agui_i.h>
#include "agui_cfg.h"


/**
 * @brief    Draw a textbox
 *
 * Draw a textbox on the canvas.
 *
 * @see
 *     textbox_t
 *
 * @param obj    Pointer to the object member of the textbox
 *
 * @return Nothing
 */

void textbox_draw(obj_t *obj)
{
    textbox_t *textbox = (textbox_t*)obj;
    obj_t *parent = obj->parent;
    int x1 = obj->x;
    int x2;
    int y1 = obj->y;
    int y2;
    int w = obj->width;
    int h = obj->height;
    string_t string;
    char str[256];
    canvas_t * restrict canvas;
    agui_t * restrict agui;
    int agui_index = textbox->obj.agui_index;
#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D
    relief_t relief;
#endif

    obj->invalidated = false;

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

    relief = textbox->relief;

    agui_draw_outline_3d(agui, x1, y1, w, h, true, true, relief);

    if (relief != RELIEF_NONE)
    {
        x1++;
        y1++;
        x2--;
        y2--;
        w -= 2;
        h -= 2;
    }

    graphics_fill_rect( canvas, x1, y1, w, h, textbox->color );    // background

#elif AGUI_APPEARANCE==AGUI_APPEARANCE_2D

    agui_draw_body_2d(agui, x1, y1, w, h, true, true, textbox->color);
    x1++;
    y1++;
    x2--;
    y2--;

#endif

    string = textbox->text;
    agui_cut_string_indicated(agui, str, textbox->text.text, sizeof(str)-1, textbox->text.font, textbox->text.fontstyle, w - 2 * textbox->text.x - 2);
    string.text = str;
    agui_draw_string(agui, x1, y1, x2, y2, &string, true);

    cursor_show(agui);
}


/**
 * @brief    Handler for textbox
 *
 * This function is the handler for the textbox. The input event may result in one or more actions.
 *
 * @see
 *     textbox_t
 *
 * @param obj    Pointer to the object member of the textbox
 * @param input  Pointer to the input event (location and button state)
 *
 * @return Nothing
 */

void textbox_handler(obj_t *obj, const input_event_t *input)
{
    action_event_t action;

    cursor_set_shape(&agui_table[obj->agui_index], obj->cursor_shape);

    if (input->buttons & BUTTON_LEFT_EVENT)
    {
        action.x = input->x;
        action.y = input->y;
        action.button = BUTTON_LEFT;
        action.event = input->buttons & BUTTON_LEFT ? ACTION_PRESSED : ACTION_RELEASED;
        obj_store_action(obj, obj->action, &action);
    }
}



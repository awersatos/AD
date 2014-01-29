/*****************************************************************************\
|*
|*  IN PACKAGE:     Agui
|*
|*  COPYRIGHT:      Copyright (c) 2008, Altium
|*
|*  DESCRIPTION:    Textarea routines
|*
 */

#include <stdlib.h>
#include <string.h>
#include <graphics.h>
#include <pointer.h>
#include <agui.h>
#include <agui_i.h>
#include "agui_cfg.h"


/**
 * @brief    Draw a textarea
 *
 * Draw an textarea on the canvas.
 *
 * @see
 *     textarea_t
 *
 * @param obj    Pointer to the object member of the textarea
 *
 * @return Nothing
 */

void textarea_draw(obj_t *obj)
{
    textarea_t * restrict textarea = (textarea_t*)obj;
    obj_t *parent = obj->parent;
    int x1 = obj->x;
    int x2;
    int y1 = obj->y;
    int y2;
    int w = obj->width;
    int h = obj->height;
    int x_text, y_text;
    int strl;
    string_t s;
    int agui_index = obj->agui_index;
    canvas_t * restrict canvas;
    agui_t * restrict agui;
    relief_t relief = textarea->relief;
    color_t color;

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

    const font_t *font = textarea->text.font;
    int line_height = graphics_get_fontheight(canvas, font) + 1;

    cursor_hide(agui);

#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D

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

    graphics_fill_rect( canvas, x1, y1, w, h, textarea->color );    // background

#elif AGUI_APPEARANCE==AGUI_APPEARANCE_2D

    agui_draw_body_2d(agui, x1, y1, w, h, true, true, textarea->color, relief);

    if (relief != RELIEF_NONE)
    {
        x1++;
        y1++;
        x2--;
        y2--;
        w -= 2;
        h -= 2;
    }

#endif

    x_text = x1 + textarea->text.x;
    y_text = y1 + textarea->text.y;
    s = textarea->text;
    color = obj->enabled ? s.color : agui->palette.disabled_dark;

    while (( s.text != NULL ) && ( *s.text != '\0' ) && ( y_text + graphics_get_fontheight(canvas, s.font) + 1 < y2 ))
    {
        strl = agui_get_breaking_string_count(agui, &s, w - 2 * s.x);
        x_text = agui_align_horizontal_count(agui, x1, x2, &s, strl);
        graphics_draw_nstring( canvas, x_text, y_text, s.text, s.font, color, s.fontstyle, strl);  // draw text
        y_text += line_height + textarea->text.y;
        s.text += strl;
        if (*s.text == '\n' || *s.text == '\t' || *s.text == ' ')
        {
            s.text++;
        }
    }
    cursor_show(agui);
}


/**
 * @brief    Handler for textarea
 *
 * This function is the handler for the textarea. The input event may result in one or more actions.
 *
 * @see
 *     textarea_t
 *
 * @param obj    Pointer to the object member of the textarea
 * @param input  Pointer to the input event (location and button state)
 *
 * @return Nothing
 */

void textarea_handler(obj_t *obj, const input_event_t *input)
{
    action_event_t action;

    if (input->buttons & BUTTON_LEFT_EVENT)
    {
        action.x = input->x;
        action.y = input->y;
        action.button = BUTTON_LEFT;
        action.event = input->buttons & BUTTON_LEFT ? ACTION_PRESSED : ACTION_RELEASED;
        obj_store_action(obj, obj->action, &action);
    }
}




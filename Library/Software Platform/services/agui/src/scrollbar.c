#include <stdlib.h>
#include <graphics.h>
#include <pointer.h>
#include <agui.h>
#include <agui_i.h>
#include "agui_cfg.h"

void _scrollbar_draw(_scrollbar_draw_t *scrollbar)
{
    int x1 = scrollbar->x;
    int y1 = scrollbar->y;
    int w = scrollbar->w;
    int h = scrollbar->h;
    int x2;
    int y2;
    int pos;
    int span;
    int offset;
    unsigned int window = scrollbar->window;
    unsigned int range = scrollbar->range;
    unsigned int handlesize;
    int scrollsize; // size of the part that is used by the handle
    agui_t *agui = scrollbar->agui;
    canvas_t * restrict canvas = agui->canvas;
    color_t color1, color2;
#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D
    color_t color3;
#endif
    relief_t relief = scrollbar->relief;

    x2 = x1 + w - 1;
    y2 = y1 + h - 1;

    scrollsize = w > h ? w : h;
    offset = w > h ? x1 : y1;

    color1 = scrollbar->enabled ? scrollbar->handlecolor : agui->palette.disabled_light;
    color2 = scrollbar->enabled ? scrollbar->color : agui->palette.disabled_light;

#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D

    color3 = scrollbar->enabled ? agui->palette.controltext : agui->palette.disabled_dark;
    scrollsize -= 2 * AGUI_BAR_WIDTH;
    offset += AGUI_BAR_WIDTH;

    if (range > window)
    {
        handlesize = scrollsize * window / range;
        if (handlesize < 3) handlesize = 3;
        span = scrollsize - handlesize;
        pos = scrollbar->position * span / (range - window) + offset;
    }
    else
    {
        handlesize = scrollsize;
        pos = offset;
    }

    /* set relief for scrollbar handle and buttons */
    if (relief == RELIEF_LOWERED)
    {
        relief = RELIEF_RAISED;
    }

    if (h > w)
    {
        agui_draw_body_3d(agui, x1, y1, AGUI_BAR_WIDTH, h, true, true, RELIEF_NONE, scrollbar->color);
        agui_draw_body_3d(agui, x1, y1, AGUI_BAR_WIDTH, AGUI_BAR_WIDTH, true, true, relief, scrollbar->handlecolor);
        agui_draw_body_3d(agui, x1, y1 + h - AGUI_BAR_WIDTH, AGUI_BAR_WIDTH, AGUI_BAR_WIDTH, true, true, relief, scrollbar->handlecolor);
        if (scrollbar->enabled)
        {
            agui_draw_body_3d(agui, x1, pos, AGUI_BAR_WIDTH, handlesize, true, true, relief, scrollbar->handlecolor);
        }
        graphics_fill_triangle(canvas, x1 +     AGUI_BAR_WIDTH / 3, y1 - 1 + 2 * AGUI_BAR_WIDTH / 3,
                                         x1 +     AGUI_BAR_WIDTH / 2, y1 - 1 +     AGUI_BAR_WIDTH / 3,
                                         x1 + 2 * AGUI_BAR_WIDTH / 3, y1 - 1 + 2 * AGUI_BAR_WIDTH / 3,
                                         color3);
        graphics_fill_triangle(canvas, x1 +     AGUI_BAR_WIDTH / 3, y1 + h - AGUI_BAR_WIDTH +     AGUI_BAR_WIDTH / 3,
                                         x1 +     AGUI_BAR_WIDTH / 2, y1 + h - AGUI_BAR_WIDTH + 2 * AGUI_BAR_WIDTH / 3,
                                         x1 + 2 * AGUI_BAR_WIDTH / 3, y1 + h - AGUI_BAR_WIDTH +     AGUI_BAR_WIDTH / 3,
                                         color3);
    }
    else
    {
        agui_draw_body_3d(agui, x1, y1, w, AGUI_BAR_WIDTH, true, true, RELIEF_NONE, scrollbar->color);
        agui_draw_body_3d(agui, x1, y1, AGUI_BAR_WIDTH, AGUI_BAR_WIDTH, true, true, relief, scrollbar->handlecolor);
        agui_draw_body_3d(agui, x1 + w - AGUI_BAR_WIDTH, y1, AGUI_BAR_WIDTH, AGUI_BAR_WIDTH, true, true, relief, scrollbar->handlecolor);
        if (scrollbar->enabled)
        {
            agui_draw_body_3d(agui, pos, y1, handlesize, AGUI_BAR_WIDTH, true, true, relief, scrollbar->handlecolor);
        }
        graphics_fill_triangle(canvas, x1 - 1 + 2 * AGUI_BAR_WIDTH / 3, y1 +     AGUI_BAR_WIDTH / 3,
                                         x1 - 1 +     AGUI_BAR_WIDTH / 3, y1 +     AGUI_BAR_WIDTH / 2,
                                         x1 - 1 + 2 * AGUI_BAR_WIDTH / 3, y1 + 2 * AGUI_BAR_WIDTH / 3,
                                         color3);
        graphics_fill_triangle(canvas, x1 + w - AGUI_BAR_WIDTH +     AGUI_BAR_WIDTH / 3, y1 +     AGUI_BAR_WIDTH / 3,
                                         x1 + w - AGUI_BAR_WIDTH + 2 * AGUI_BAR_WIDTH / 3, y1 +     AGUI_BAR_WIDTH / 2,
                                         x1 + w - AGUI_BAR_WIDTH +     AGUI_BAR_WIDTH / 3, y1 + 2 * AGUI_BAR_WIDTH / 3,
                                         color3);
    }

#elif AGUI_APPEARANCE==AGUI_APPEARANCE_2D

    scrollsize -= 2 * (AGUI_BAR_WIDTH + AGUI_BAR_WIDTH/2);
    offset += AGUI_BAR_WIDTH + AGUI_BAR_WIDTH/2;

    if (range > window)
    {
        handlesize = scrollsize * window / range;
        span = scrollsize - handlesize;
        pos = scrollbar->position * span / (range - window) + offset;
    }
    else
    {
        handlesize = scrollsize;
        pos = offset;
    }

    if (w > h)
    {
        agui_draw_body_2d(agui, x1, y1, w, AGUI_BAR_WIDTH, true, true, color2, relief);   // body of the scrollbar
        agui_draw_body_2d(agui, x1, y1, AGUI_BAR_WIDTH, AGUI_BAR_WIDTH, true, true, color2, relief); // body of the left arrow
        agui_draw_body_2d(agui, x1 + w - AGUI_BAR_WIDTH, y1, AGUI_BAR_WIDTH, AGUI_BAR_WIDTH, true, true, color2, relief); // body of the right arrow
        graphics_fill_triangle(canvas, x1 - 1 + 2 * AGUI_BAR_WIDTH / 3, y1 +     AGUI_BAR_WIDTH / 3,
                                         x1 - 1 +     AGUI_BAR_WIDTH / 3, y1 +     AGUI_BAR_WIDTH / 2,
                                         x1 - 1 + 2 * AGUI_BAR_WIDTH / 3, y1 + 2 * AGUI_BAR_WIDTH / 3,
                                         color1);
        graphics_fill_triangle(canvas, x1 + w - AGUI_BAR_WIDTH +     AGUI_BAR_WIDTH / 3, y1 +     AGUI_BAR_WIDTH / 3,
                                         x1 + w - AGUI_BAR_WIDTH + 2 * AGUI_BAR_WIDTH / 3, y1 +     AGUI_BAR_WIDTH / 2,
                                         x1 + w - AGUI_BAR_WIDTH +     AGUI_BAR_WIDTH / 3, y1 + 2 * AGUI_BAR_WIDTH / 3,
                                         color1);

        if (scrollbar->enabled)
        {
            graphics_fill_segment(canvas, pos, y1 + AGUI_BAR_WIDTH/2, AGUI_BAR_WIDTH/4, 90, 180, color1);
            graphics_fill_rect(canvas, pos, y1 + AGUI_BAR_WIDTH/2 - AGUI_BAR_WIDTH/4, handlesize, 2 * (AGUI_BAR_WIDTH/4) + 1, color1);
            graphics_fill_segment(canvas, pos + handlesize - 1, y1 + AGUI_BAR_WIDTH/2, AGUI_BAR_WIDTH/4, 270, 180, color1);
        }
        else
        {
            graphics_draw_arc(canvas, pos, y1 + AGUI_BAR_WIDTH/2, AGUI_BAR_WIDTH/4, 90, 180, color1);
            graphics_draw_line(canvas, pos, y1 + AGUI_BAR_WIDTH/2 - AGUI_BAR_WIDTH/4, pos + handlesize, y1 + AGUI_BAR_WIDTH/2 - AGUI_BAR_WIDTH/4, color1);
            graphics_draw_line(canvas, pos, y1 + AGUI_BAR_WIDTH/2 + AGUI_BAR_WIDTH/4, pos + handlesize, y1 + AGUI_BAR_WIDTH/2 + AGUI_BAR_WIDTH/4, color1);
            graphics_draw_arc(canvas, pos + handlesize - 1, y1 + AGUI_BAR_WIDTH/2, AGUI_BAR_WIDTH/4, 270, 180, color1);
        }
    }
    else
    {
        agui_draw_body_2d(agui, x1, y1, AGUI_BAR_WIDTH, h, true, true, color2, relief);   // body of the scrollbar
        agui_draw_body_2d(agui, x1, y1, AGUI_BAR_WIDTH, AGUI_BAR_WIDTH, true, true, color2, relief);  // body of the top arrow
        agui_draw_body_2d(agui, x1, y1 + h - AGUI_BAR_WIDTH, AGUI_BAR_WIDTH, AGUI_BAR_WIDTH, true, true, color2, relief); // body of the bottom arrow
        graphics_fill_triangle(canvas, x1 +     AGUI_BAR_WIDTH / 3, y1 - 1 + 2 * AGUI_BAR_WIDTH / 3,
                                         x1 +     AGUI_BAR_WIDTH / 2, y1 - 1 +     AGUI_BAR_WIDTH / 3,
                                         x1 + 2 * AGUI_BAR_WIDTH / 3, y1 - 1 + 2 * AGUI_BAR_WIDTH / 3,
                                         color1);
        graphics_fill_triangle(canvas, x1 +     AGUI_BAR_WIDTH / 3, y1 + h - AGUI_BAR_WIDTH +     AGUI_BAR_WIDTH / 3,
                                         x1 +     AGUI_BAR_WIDTH / 2, y1 + h - AGUI_BAR_WIDTH + 2 * AGUI_BAR_WIDTH / 3,
                                         x1 + 2 * AGUI_BAR_WIDTH / 3, y1 + h - AGUI_BAR_WIDTH +     AGUI_BAR_WIDTH / 3,
                                         color1);

        if (scrollbar->enabled)
        {
            graphics_fill_segment(canvas, x1 + AGUI_BAR_WIDTH/2, pos + handlesize, AGUI_BAR_WIDTH/4, 180, 180, color1);
            graphics_fill_rect(canvas, x1 + AGUI_BAR_WIDTH/2 - AGUI_BAR_WIDTH/4, pos, 2 * (AGUI_BAR_WIDTH/4) + 1, handlesize, color1);
            graphics_fill_segment(canvas, x1 + AGUI_BAR_WIDTH/2, pos, AGUI_BAR_WIDTH/4, 0, 180, color1);
        }
        else
        {
            graphics_draw_arc(canvas, x1 + AGUI_BAR_WIDTH/2, pos + handlesize, AGUI_BAR_WIDTH/4, 180, 180, color1);
            graphics_draw_line(canvas, x1 + AGUI_BAR_WIDTH/2 - AGUI_BAR_WIDTH/4, pos, x1 + AGUI_BAR_WIDTH/2 - AGUI_BAR_WIDTH/4, pos + handlesize, color1);
            graphics_draw_line(canvas, x1 + AGUI_BAR_WIDTH/2 + AGUI_BAR_WIDTH/4, pos, x1 + AGUI_BAR_WIDTH/2 + AGUI_BAR_WIDTH/4, pos + handlesize, color1);
            graphics_draw_arc(canvas, x1 + AGUI_BAR_WIDTH/2, pos, AGUI_BAR_WIDTH/4, 0, 180, color1);
        }
    }
#endif
}


void _scrollbar_handler(_scrollbar_handler_t *scrollbar, const input_event_t *input)
{
    int x1 = scrollbar->x;
    int y1 = scrollbar->y;
    int w = scrollbar->w;
    int h = scrollbar->h;
    int pos;
    int value;
    int down_pos;
    int up_pos;
    int offset;
    int span;
    action_event_t action;
    unsigned int window = scrollbar->window;
    unsigned int range = scrollbar->range;
    unsigned int handlesize;
    int scrollsize; // size of the part that is used by the handle

    action.button = BUTTON_LEFT;
    action.x = input->x;
    action.y = input->y;

    if (h > w)
    {
        /* vertical */
        value = input->y;
        down_pos = y1 + AGUI_BAR_WIDTH;
        up_pos = y1 + h - AGUI_BAR_WIDTH;
    }
    else
    {
        /* horizontal */
        value = input->x;
        down_pos = x1 + AGUI_BAR_WIDTH;
        up_pos = x1 + w - AGUI_BAR_WIDTH;
    }

    /* first test for up/down buttons */
    if (value < down_pos)
    {
        /* down button */
        if (input->buttons & BUTTON_LEFT)
        {
            pos = *scrollbar->position;
            if (input->buttons & BUTTON_LEFT_EVENT)
            {
                obj_set_repeat(scrollbar->caller);
                action.event = ACTION_PRESSED;
                obj_store_action(scrollbar->caller, scrollbar->action, &action);
            }
            if (((input->buttons & BUTTON_LEFT_EVENT) || obj_repeat(scrollbar->caller)) && (pos > 0))
            {
                pos--;
                obj_invalidate(scrollbar->caller);
                action.event = ACTION_DRAGGED;
                obj_store_action(scrollbar->caller, scrollbar->action, &action);
            }
            *scrollbar->position = pos;
        }
        else
        {
            *scrollbar->moving = false;
        }
    }
    else if (value > up_pos)
    {
        /* up button */
        if (input->buttons & BUTTON_LEFT)
        {
            pos = *scrollbar->position;
            if (input->buttons & BUTTON_LEFT_EVENT)
            {
                obj_set_repeat(scrollbar->caller);
                action.event = ACTION_PRESSED;
                obj_store_action(scrollbar->caller, scrollbar->action, &action);
            }
            if (((input->buttons & BUTTON_LEFT_EVENT) || obj_repeat(scrollbar->caller)) && (pos < (range-window)))
            {
                pos++;
                obj_invalidate(scrollbar->caller);
                action.event = ACTION_DRAGGED;
                obj_store_action(scrollbar->caller, scrollbar->action, &action);
            }
            *scrollbar->position = pos;
        }
        else
        {
            *scrollbar->moving = false;
        }
    }
    else
    {
        if (h > w)
        {

#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D
            scrollsize = h - 2 * AGUI_BAR_WIDTH;
#elif AGUI_APPEARANCE==AGUI_APPEARANCE_2D
            scrollsize = h - 2 * AGUI_BAR_WIDTH - 2 * (AGUI_BAR_WIDTH/2);
#endif
            if (range > window)
            {
                handlesize = scrollsize * window / range;
            }
            else
            {
                handlesize = scrollsize;
            }

#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D
            offset = y1 + handlesize / 2 + AGUI_BAR_WIDTH;
#elif  AGUI_APPEARANCE==AGUI_APPEARANCE_2D
            offset = y1 + handlesize / 2 + AGUI_BAR_WIDTH + AGUI_BAR_WIDTH / 2;
#endif
            span = scrollsize - handlesize;
        }
        else
        {
#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D
            scrollsize = w - 2 * AGUI_BAR_WIDTH;
#elif AGUI_APPEARANCE==AGUI_APPEARANCE_2D
            scrollsize = w - 2 * AGUI_BAR_WIDTH - 2 * (AGUI_BAR_WIDTH/2);
#endif
            if (range > window)
            {
                handlesize = scrollsize * window / range;
            }
            else
            {
                handlesize = scrollsize;
            }

#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D
            offset = x1 + handlesize / 2 + AGUI_BAR_WIDTH;
#elif  AGUI_APPEARANCE==AGUI_APPEARANCE_2D
            offset = x1 + handlesize / 2 + AGUI_BAR_WIDTH + AGUI_BAR_WIDTH / 2;
#endif
            span = scrollsize - handlesize;
        }

        /* new scrollbar value? */
        if (input->buttons & BUTTON_LEFT_EVENT)
        {
            if (input->buttons & BUTTON_LEFT)
            {
                *scrollbar->moving = true;
                action.event = ACTION_PRESSED;
            }
            else
            {
                *scrollbar->moving = false;
                action.event = ACTION_RELEASED;
            }
            obj_store_action(scrollbar->caller, scrollbar->action, &action);
        }
        else
        {
            if ((input->buttons & BUTTON_LEFT == 0) || (input->buttons & ACTION_LEAVED))
            {
                *scrollbar->moving = false;
            }
            /* else keep last moving */
        }

        /* get new scrollbar value */
        if (*scrollbar->moving)
        {
            pos = ((value - offset) * (int)(range - window) + span / 2) / span;
            pos = pos < 0 ? 0 : pos;
            pos = pos > range  - window ? range - window : pos;

            if (pos != *scrollbar->position)
            {
                *scrollbar->position = pos;
                obj_invalidate(scrollbar->caller);
                action.event = ACTION_DRAGGED;
                obj_store_action(scrollbar->caller, scrollbar->action, &action);
            }
        }
    }
}


/**
 * @brief    Draw a scrollbar
 *
 * Draw a scrollbar on the canvas.
 *
 * @see
 *     scrollbar_t
 *
 * @param obj    Pointer to the object member of the scrollbar
 *
 * @return Nothing
 */

void scrollbar_draw(obj_t *obj)
{
    scrollbar_t *scrollbar = (scrollbar_t*)obj;
    obj_t *parent = obj->parent;
    int x1 = obj->x;
    int x2;
    int y1 = obj->y;
    int y2;
    int h = obj->height;
    int w = obj->width;
    canvas_t * restrict canvas;
    agui_t * restrict agui;
    int agui_index = obj->agui_index;
    _scrollbar_draw_t _scrollbar_i;

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

    _scrollbar_i.agui = agui;
    _scrollbar_i.x = x1;
    _scrollbar_i.y = y1;
    _scrollbar_i.w = w;
    _scrollbar_i.h = h;
    _scrollbar_i.relief = scrollbar->relief;
    _scrollbar_i.color = scrollbar->color;
    _scrollbar_i.enabled = obj->enabled;
    _scrollbar_i.range = scrollbar->range;
    _scrollbar_i.window = scrollbar->window;
    _scrollbar_i.position = scrollbar->position;
    _scrollbar_i.handlecolor =scrollbar->handlecolor;

    cursor_hide(agui);
    _scrollbar_draw(&_scrollbar_i);
    cursor_show(agui);
}


/**
 * @brief    Handler for scrollbar
 *
 * This function is the handler for the scrollbar. The input event may result in one or more actions.
 *
 * @see
 *     scrollbar_t
 *
 * @param obj    Pointer to the object member of the scrollbar
 * @param input  Pointer to the input event (location and button state)
 *
 * @return Nothing
 */

void scrollbar_handler(obj_t *obj, const input_event_t *input)
{
    scrollbar_t *scrollbar = (scrollbar_t*)obj;
    obj_t *parent = obj->parent;
    int x1 = obj->x;
    int y1 = obj->y;
    _scrollbar_handler_t _scrollbar_i;

    if (obj->enabled)
    {
        while (parent != NULL)
        {
            x1 += parent->x;
            y1 += parent->y;
            parent = parent->parent;
        }

        _scrollbar_i.x = x1;
        _scrollbar_i.y = y1;
        _scrollbar_i.w = obj->width;
        _scrollbar_i.h = obj->height;
        _scrollbar_i.relief = scrollbar->relief;
        _scrollbar_i.range = scrollbar->range;
        _scrollbar_i.window = scrollbar->window;
        _scrollbar_i.position = &scrollbar->position;
        _scrollbar_i.moving = &scrollbar->moving;
        _scrollbar_i.action = obj->action;
        _scrollbar_i.caller = obj;

        _scrollbar_handler(&_scrollbar_i, input);
    }
}


/**
 * @brief    Set the scrollbar position
 *
 * This function sets the position of the scrollbar and invalidates the scrollbar if the position has changed.
 *
 * @see
 *     scrollbar_t
 *
 * @param obj       Pointer to the object member of the scrollbar
 * @param position  New position
 *
 * @return Nothing
 */

void scrollbar_set_position(obj_t *obj, unsigned int position)
{
    scrollbar_t *scrollbar = (scrollbar_t*)obj;
    int max_pos;

    max_pos = scrollbar->range - scrollbar->window;
    max_pos = max_pos > 0 ? max_pos : 0;
    position = position > max_pos ? max_pos : position;
    if (position != scrollbar->position)
    {
        scrollbar->position = position;
        obj_invalidate(obj);
    }
}


/**
 * @brief    Set the scrollbar handle size
 *
 * This function sets the size of the scrollbar handle and invalidates the scrollbar if the size has changed.
 *
 * @see
 *     scrollbar_t
 *
 * @param obj       Pointer to the object member of the scrollbar
 * @param size      New size
 *
 * @return Nothing
 */

void scrollbar_set_handlesize(obj_t *obj, unsigned int size)
{
    scrollbar_t *scrollbar = (scrollbar_t*)obj;

    if (size != scrollbar->window)
    {
        scrollbar->window = size;
        obj_invalidate(obj);
    }
}


/**
 * @brief    Set the scrollbar range
 *
 * This function sets the range of the scrollbar and invalidates the scrollbar if the range has changed.
 *
 * @see
 *     scrollbar_t
 *
 * @param obj       Pointer to the object member of the scrollbar
 * @param range     New range
 *
 * @return Nothing
 */

void scrollbar_set_range(obj_t *obj, unsigned int range)
{
    scrollbar_t *scrollbar = (scrollbar_t*)obj;
    int max_pos;

    if (scrollbar->range != range)
    {
        scrollbar->range = range;
        max_pos = range > scrollbar->window ? range - scrollbar->window : 0;
        scrollbar->position = scrollbar->position > max_pos ? max_pos : scrollbar->position;
        obj_invalidate(obj);
    }
}


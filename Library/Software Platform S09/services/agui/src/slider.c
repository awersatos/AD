#include <stdlib.h>
#include <graphics.h>
#include <pointer.h>
#include <agui.h>
#include <agui_i.h>
#include "agui_cfg.h"


/**
 * @brief    Draw a slider
 *
 * Draw a slider on the canvas.
 *
 * @see
 *     slider_t
 *
 * @param obj    Pointer to the object member of the slider
 *
 * @return Nothing
 */

void slider_draw(obj_t *obj)
{
    slider_t *slider = (slider_t*)obj;
    obj_t *parent = obj->parent;
    int x1 = obj->x;
    int x2;
    int y1 = obj->y;
    int y2;
    int pos;
    int span;
    int offset;
    int h = slider->obj.height;
    int w = slider->obj.width;
    int high;
    int low;
    int handlesize;
    canvas_t * restrict canvas;
    agui_t * restrict agui;
    int agui_index = obj->agui_index;
    color_t color1;
#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D
    relief_t relief;
    color_t color2;
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

    relief = slider->relief;

    agui_draw_outline_3d(agui, x1, y1, w, h, true, true, relief);

    if (relief != RELIEF_NONE)
    {
        x1++;
        y1++;
        x2--;
        y2--;
        h -= 2;
        w -= 2;
    }


    if (h > w)
    {
        handlesize = (slider->handlesize * h) / 100;
        if (handlesize < 3) handlesize = 3;
        span = h - handlesize;
        offset = y1;
        /* invert for y-graphics-direction (=increasing to bottom) */
        high = slider->low;
        low = slider->high;
        color1 = slider->color1;
        color2 = slider->color2;
        if (!obj->enabled)
        {
            graphics_fill_rect(canvas, x1, y1, w, h, agui->palette.disabled);
        }
        else if (color1 == color2)
        {
            graphics_fill_rect(canvas, x1, y1, w, h, color1);
        }
        else
        {
            graphics_fill_triangle(canvas, x2, y2, x1+1, y2, x2, y1, color1);
            graphics_fill_triangle(canvas, x1, y1, x1, y2, x2-1, y1, color2);
        }
    }
    else
    {
        handlesize = (slider->handlesize * w) / 100;
        if (handlesize < 3) handlesize = 3;
        span = w - handlesize;
        offset = x1;
        high = slider->high;
        low = slider->low;
        color1 = slider->color1;
        color2 = slider->color2;
        if (!obj->enabled)
        {
            graphics_fill_rect(canvas, x1, y1, w, h, agui->palette.disabled);
        }
        else if (color1 == color2)
        {
            graphics_fill_rect(canvas, x1, y1, w, h, color1);
        }
        else
        {
            graphics_fill_triangle(canvas, x1, y1, x1, y2-1, x2, y1, color1);
            graphics_fill_triangle(canvas, x2, y2, x1, y2, x2, y1+1, color2);
        }
    }


    /* calculate slider position */
    if (high > low)
    {
        pos = ((span * (slider->position - low)) / (high - low)) + offset;
    }
    else
    {
        pos = ((span * (low - slider->position )) / (low - high)) + offset;
    }


    /* draw slider handle */
    if (relief == RELIEF_LOWERED)
    {
        relief = RELIEF_RAISED;
    }

    if (h > w)
    {
        agui_draw_outline_3d(agui, x1, pos, w, handlesize, true, true, relief);
        if (relief == RELIEF_RAISED)
        {
            pos++;
            x1++;
            y1++;
            w -= 2;
            h = handlesize-2;
        }
        else
        {
            h = handlesize;
        }
        if (obj->enabled)
        {
            graphics_fill_rect( canvas, x1, pos, w, h, slider->handlecolor);    // fill
        }
    }
    else
    {
        agui_draw_outline_3d(agui, pos, y1, handlesize, h, true, true, relief);
        if (relief == RELIEF_RAISED)
        {
            pos++;
            x1++;
            y1++;
            w= handlesize-2;
            h -= 2;
        }
        else
        {
            w= handlesize;
        }
        if (obj->enabled)
        {
            graphics_fill_rect( canvas, pos, y1, w, h, slider->handlecolor);    // fill
        }
    }

#elif AGUI_APPEARANCE==AGUI_APPEARANCE_2D

    color1 = obj->enabled ? slider->color1 : agui->palette.disabled;
    if (w > h)
    {
        agui_draw_body_2d(agui, x1, y1, w, AGUI_BAR_WIDTH, true, true, color1);
    }
    else
    {
        agui_draw_body_2d(agui, x1, y1, AGUI_BAR_WIDTH, h, true, true, color1);
    }

    if (h > w)
    {
        handlesize = (slider->handlesize * (h - 2 * (AGUI_BAR_WIDTH/2) - 1)) / 100;
        span = h - 2 * (AGUI_BAR_WIDTH/2) - 1 - handlesize;
        offset = y1 + AGUI_BAR_WIDTH/2;
        /* invert for y-canvas-direction (=increasing to bottom) */
        high = slider->low;
        low = slider->high;
    }
    else
    {
        handlesize = (slider->handlesize * (w - 2 * (AGUI_BAR_WIDTH/2) - 1)) / 100;
        span = w - 2 * (AGUI_BAR_WIDTH/2) - 1 - handlesize;
        offset = x1 + AGUI_BAR_WIDTH/2;
        high = slider->high;
        low = slider->low;
    }

    /* calculate slider position */
    pos = ((span * (slider->position - low)) / (high - low)) + offset;

    if (obj->enabled)
    {
        if (w > h)
        {
        graphics_fill_segment(canvas, pos, y1 + AGUI_BAR_WIDTH/2, AGUI_BAR_WIDTH/4, 90, 180, slider->handlecolor);
        graphics_fill_rect(canvas, pos, y1 + AGUI_BAR_WIDTH/2 - AGUI_BAR_WIDTH/4, handlesize, 2 * (AGUI_BAR_WIDTH/4) + 1, slider->handlecolor);
        graphics_fill_segment(canvas, pos + handlesize, y1 + AGUI_BAR_WIDTH/2, AGUI_BAR_WIDTH/4, 270, 180, slider->handlecolor);
        }
        else
        {
        graphics_fill_segment(canvas, x1 + AGUI_BAR_WIDTH/2, pos + handlesize, AGUI_BAR_WIDTH/4, 180, 180, slider->handlecolor);
        graphics_fill_rect(canvas, x1 + AGUI_BAR_WIDTH/2 - AGUI_BAR_WIDTH/4, pos, 2 * (AGUI_BAR_WIDTH/4) + 1, handlesize, slider->handlecolor);
        graphics_fill_segment(canvas, x1 + AGUI_BAR_WIDTH/2, pos, AGUI_BAR_WIDTH/4, 0, 180, slider->handlecolor);
        }
    }
    else
    {
        if (w > h)
        {
        graphics_draw_arc(canvas, pos, y1 + AGUI_BAR_WIDTH/2, AGUI_BAR_WIDTH/4, 90, 180, slider->handlecolor);
        graphics_draw_line(canvas, pos, y1 + AGUI_BAR_WIDTH/2 - AGUI_BAR_WIDTH/4, pos + handlesize, y1 + AGUI_BAR_WIDTH/2 - AGUI_BAR_WIDTH/4, slider->handlecolor);
        graphics_draw_line(canvas, pos, y1 + AGUI_BAR_WIDTH/2 + AGUI_BAR_WIDTH/4, pos + handlesize, y1 + AGUI_BAR_WIDTH/2 + AGUI_BAR_WIDTH/4, slider->handlecolor);
        graphics_draw_arc(canvas, pos + handlesize, y1 + AGUI_BAR_WIDTH/2, AGUI_BAR_WIDTH/4, 270, 180, agui->palette.outline);
        }
        else
        {
        graphics_draw_arc(canvas, x1 + AGUI_BAR_WIDTH/2, pos + handlesize, AGUI_BAR_WIDTH/4, 180, 180, slider->handlecolor);
        graphics_draw_line(canvas, x1 + AGUI_BAR_WIDTH/2 - AGUI_BAR_WIDTH/4, pos, x1 + AGUI_BAR_WIDTH/2 - AGUI_BAR_WIDTH/4, pos + handlesize, slider->handlecolor);
        graphics_draw_line(canvas, x1 + AGUI_BAR_WIDTH/2 + AGUI_BAR_WIDTH/4, pos, x1 + AGUI_BAR_WIDTH/2 + AGUI_BAR_WIDTH/4, pos + handlesize, slider->handlecolor);
        graphics_draw_arc(canvas, x1 + AGUI_BAR_WIDTH/2, pos, AGUI_BAR_WIDTH/4, 0, 180, slider->handlecolor);
        }
    }
#endif
    cursor_show(agui);
}


/**
 * @brief    Handler for slider
 *
 * This function is the handler for the slider. The input event may result in one or more actions.
 *
 * @see
 *     slider_t
 *
 * @param obj    Pointer to the object member of the slider
 * @param input  Pointer to the input event (location and button state)
 *
 * @return Nothing
 */

void slider_handler(obj_t *obj, const input_event_t *input)
{
    slider_t *slider = (slider_t*)obj;
    obj_t *parent;
    int retval = -1;
    int x1;
    int y1;
    int w = obj->width - 2;
    int h = obj->height - 2;
    int pos;
    int handlesize;
    int value;
    int offset;
    int span;
    int high;
    int low;
    action_event_t action;

    if (obj->enabled)
    {
        x1 = slider->obj.x;
        y1 = slider->obj.y;
        parent = slider->obj.parent;
        while (parent != NULL)
        {
            x1 += parent->x;
            y1 += parent->y;
            parent = parent->parent;
        }

        /* horizontal or vertical slider? */
        if (slider->obj.height > slider->obj.width)
        {
            /* vertical */
#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D
            handlesize = (slider->handlesize * h) / 100;
            if (handlesize < 3) handlesize = 3;
            value = input->y;
            offset = y1 + handlesize / 2 + 1;
            span = slider->obj.height - handlesize - 2;
#elif AGUI_APPEARANCE==AGUI_APPEARANCE_2D
            handlesize = (slider->handlesize * (h - 2 * (AGUI_BAR_WIDTH/2) + 1)) / 100;
            value = input->y;
            offset = y1 + handlesize / 2 + AGUI_BAR_WIDTH / 2;
            span = slider->obj.height - 2 * (AGUI_BAR_WIDTH/2) - 1 - handlesize;
#endif
            /* invert for y-canvas-direction (=increasing to bottom) */
            high = slider->low;
            low = slider->high;
        }
        else
        {
            /* horizontal */
#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D
            handlesize = (slider->handlesize * w) / 100;
            if (handlesize < 3) handlesize = 3;
            value = input->x;
            offset = x1 + handlesize / 2 + 1;
            span = slider->obj.width - handlesize - 2;
#elif AGUI_APPEARANCE==AGUI_APPEARANCE_2D
            handlesize = (slider->handlesize * (w - 2 * (AGUI_BAR_WIDTH/2) + 1)) / 100;
            value = input->x;
            offset = x1 + handlesize / 2 + AGUI_BAR_WIDTH / 2;
            span = slider->obj.width - 2 * (AGUI_BAR_WIDTH/2) - 1 - handlesize;
#endif
            high = slider->high;
            low = slider->low;
        }

        /* new slider value? */
        if (input->buttons & BUTTON_LEFT_EVENT)
        {
            action.x = input->x;
            action.y = input->y;
            action.button = BUTTON_LEFT;

            if (input->buttons & BUTTON_LEFT)
            {
                slider->moving = true;
                action.event = ACTION_PRESSED;
            }
            else
            {
                slider->moving = false;
                action.event = ACTION_RELEASED;
            }
            obj_store_action(obj, obj->action, &action);
        }
        else
        {
            if ((input->buttons & BUTTON_LEFT == 0) || (input->buttons & ACTION_LEAVED))
            {
                slider->moving = false;
            }
            /* else keep last moving */
        }

        /* get new slider value */
        if (slider->moving)
        {
            if (high > low)
            {
                pos = low + ((value - offset) * (high - low) + span / 2) / span;
                pos = pos > high ? high : pos;
                pos = pos < low ? low : pos;
                pos = slider->handlesize == 100 ? 0 : pos;
            }
            else
            {
                pos = low - ((value - offset) * (low - high) + span / 2) / span;
                pos = pos < high ? high : pos;
                pos = pos > low ? low : pos;
                pos = slider->handlesize == 100 ? 0 : pos;
            }
            if (pos != slider->position)
            {
                slider->position = pos;
                obj_invalidate(obj);
                action.x = input->x;
                action.y = input->y;
                action.event = ACTION_DRAGGED;
                action.button = BUTTON_LEFT;
                obj_store_action(obj, obj->action, &action);
            }
        }
    }
}


/**
 * @brief    Set the slider position
 *
 * This function sets the position of the slider and invalidates the slider if the position has changed.
 *
 * @see
 *     slider_t
 *
 * @param obj       Pointer to the object member of the slider
 * @param position  New position
 *
 * @return Nothing
 */

void slider_set_position(obj_t *obj, int position)
{
    slider_t *slider = (slider_t*)obj;

    position = position < slider->low ? slider->low : position;
    position = position > slider->high ? slider->high : position;

    if (position != slider->position)
    {
        slider->position = position;
        obj_invalidate(obj);
    }
}


/**
 * @brief    Set the slider handle size
 *
 * This function sets the size of the slider handle and invalidates the slider if the size has changed.
 *
 * @see
 *     slider_t
 *
 * @param obj       Pointer to the object member of the slider
 * @param size      New size
 *
 * @return Nothing
 */

void slider_set_handlesize(obj_t *obj, int size)
{
    slider_t *slider = (slider_t*)obj;

    size = size < 0 ? 0 : size;
    size = size > 100 ? 100 : size;

    if (size != slider->handlesize)
    {
        slider->handlesize = size;
        obj_invalidate(obj);
    }
}


/**
 * @brief    Set the slider range
 *
 * This function sets the range of the slider and invalidates the slider if the range has changed.
 *
 * @see
 *     slider_t
 *
 * @param obj      Pointer to the object member of the slider
 * @param low      Low side of range
 * @param high     High side of range
 *
 * @return Nothing
 */

void slider_set_range(obj_t *obj, int low, int high)
{
    slider_t *slider = (slider_t*)obj;

    if (slider->low != low || slider->high != high)
    {
        slider->low = low;
        slider->high = high;
        if (slider->position < low)
            slider->position = low;
        if (slider->position > high)
            slider->position = high;
        obj_invalidate(obj);
    }
}


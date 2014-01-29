#include <stdlib.h>
#include <graphics.h>
#include <pointer.h>
#include <agui.h>
#include <agui_i.h>
#include "agui_cfg.h"

/**
 * @brief    Draw a progressbar
 *
 * Draw a progressbar on the canvas.
 *
 * @see
 *     progressbar_t
 *
 * @param obj    Pointer to the object member of the progressbar
 *
 * @return Nothing
 */

void progressbar_draw(obj_t *obj)
{
    progressbar_t *progressbar = (progressbar_t*)obj;
    obj_t *parent = obj->parent;
    int x1 = obj->x;
    int x2;
    int y1 = obj->y;
    int y2;
    int done;
    int w = obj->width;
    int h = obj->height;
    unsigned int percent = progressbar->percentage;
    canvas_t * restrict canvas;
    int agui_index = obj->agui_index;
    agui_t * restrict agui;
    bool invalidated = obj->invalidated;
    bool update = obj->invalidated_child;
#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D
    relief_t relief;
#endif
#if AGUI_APPEARANCE==AGUI_APPEARANCE_2D
    int span, offset;
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

    if (invalidated)
    {
        relief = progressbar->relief;

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
    }

    if (percent > 100)
    {
        percent = 100;
    }

    if (w > h)
    {
        done = (percent * w )/ 100;

        if (invalidated)
        {
            /* draw background */
            graphics_fill_rect(canvas, x1, y1, done, h, progressbar->progresscolor);
            graphics_fill_rect(canvas, x1 + done, y1, w - done, h, progressbar->color);
        }
    }
    else
    {
        done = (percent * h) / 100;

        if (invalidated)
        {
            /* draw background */
            graphics_fill_rect(canvas, x1, y2 + 1 - done, w, done, progressbar->progresscolor);
            graphics_fill_rect(canvas, x1, y1, w, h - done, progressbar->color);
        }
    }

#elif AGUI_APPEARANCE==AGUI_APPEARANCE_2D

    if (w > h)
    {
        if (invalidated)
        {
            agui_draw_body_2d(agui, x1, y1, w, AGUI_BAR_WIDTH, true, true, progressbar->color);
        }

        span = w - 2 * (AGUI_BAR_WIDTH/2) - 1;
        offset = x1 + AGUI_BAR_WIDTH/2;

        if (percent > 100)
        {
            percent = 100;
        }
        done = (percent * span) / 100;
        graphics_fill_segment(canvas, offset, y1 + AGUI_BAR_WIDTH/2, AGUI_BAR_WIDTH/4, 90, 180, progressbar->progresscolor);
        graphics_fill_rect(canvas, offset, y1 + AGUI_BAR_WIDTH/2 - AGUI_BAR_WIDTH/4, done, 2 * (AGUI_BAR_WIDTH/4) + 1, progressbar->progresscolor);
        graphics_fill_segment(canvas, offset + done, y1 + AGUI_BAR_WIDTH/2, AGUI_BAR_WIDTH/4, 270, 180, progressbar->progresscolor);
    }
    else
    {
        if (invalidated)
        {
            agui_draw_body_2d(agui, x1, y1, AGUI_BAR_WIDTH, h, true, true, progressbar->color);
        }

        span = h - 2 * (AGUI_BAR_WIDTH/2) - 1;
        offset = y2 - AGUI_BAR_WIDTH/2;

        if (percent > 100)
        {
            percent = 100;
        }
        done = (percent * span) / 100;
        graphics_fill_segment(canvas, x1 + AGUI_BAR_WIDTH/2, offset, AGUI_BAR_WIDTH/4, 180, 180, progressbar->progresscolor);
        graphics_fill_rect(canvas, x1 + AGUI_BAR_WIDTH/2 - AGUI_BAR_WIDTH/4, offset - done, 2 * (AGUI_BAR_WIDTH/4) + 1, done, progressbar->progresscolor);
        graphics_fill_segment(canvas, x1 + AGUI_BAR_WIDTH/2, offset - done, AGUI_BAR_WIDTH/4, 0, 180, progressbar->progresscolor);
    }

#endif

    cursor_show(agui);
}


/**
 * @brief    Set percentage of progressbar
 *
 * This function sets the percentage of the progressbar. Valid values are from 0 to 100.
 *
 * @see
 *     progressbar_t
 *
 * @param obj         Pointer to the object member of the progressbar
 * @param percentage  Percentage to set
 *
 * @return Nothing
 */

void progressbar_set_percentage(obj_t *obj, unsigned int percentage)
{
    progressbar_t *progressbar = (progressbar_t*)obj;
    percentage = percentage > 100 ? 100 : percentage;

    if (percentage > progressbar->percentage)
    {
        progressbar->percentage = percentage;
        obj_invalidate_child(obj);
    }
    else if (percentage < progressbar->percentage)
    {
        progressbar->percentage = percentage;
        obj_invalidate(obj);
    }
}

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
    relief_t relief = progressbar->relief;
    color_t color1, color2;
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

    color1 = obj->enabled ? progressbar->progresscolor : agui->palette.disabled_dark;
    color2 = obj->enabled ? progressbar->color : agui->palette.disabled_light;

#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D

    if (invalidated)
    {
        agui_draw_outline_3d(agui, x1, y1, w, h, true, true, relief);

    }

    if (invalidated || update)
    {
        if (relief != RELIEF_NONE)
        {
            x1++;
            y1++;
            x2--;
            y2--;
            w -= 2;
            h -= 2;
        }

        if (percent > 100)
        {
            percent = 100;
        }

        if (w > h)
        {
            done = (percent * w )/ 100;
            graphics_fill_rect(canvas, x1, y1, done, h, color1);            // progress
            graphics_fill_rect(canvas, x1 + done, y1, w - done, h, color2); // background
        }
        else
        {
            done = (percent * h) / 100;
            graphics_fill_rect(canvas, x1, y2 + 1 - done, w, done, color1); // progress
            graphics_fill_rect(canvas, x1, y1, w, h - done, color2);        // background
        }
    }

#elif AGUI_APPEARANCE==AGUI_APPEARANCE_2D

    if (w > h)
    {
        if (invalidated)
        {
            agui_draw_body_2d(agui, x1, y1, w, AGUI_BAR_WIDTH, true, true, color2, relief);
        }

        span = w - 2 * (AGUI_BAR_WIDTH/2) - 1;
        offset = x1 + AGUI_BAR_WIDTH/2;

        if (percent > 100)
        {
            percent = 100;
        }
        done = (percent * span) / 100;
        graphics_fill_segment(canvas, offset, y1 + AGUI_BAR_WIDTH/2, AGUI_BAR_WIDTH/4, 90, 180, color1);
        graphics_fill_rect(canvas, offset, y1 + AGUI_BAR_WIDTH/2 - AGUI_BAR_WIDTH/4, done, 2 * (AGUI_BAR_WIDTH/4) + 1, color1);
        graphics_fill_segment(canvas, offset + done, y1 + AGUI_BAR_WIDTH/2, AGUI_BAR_WIDTH/4, 270, 180, color1);
    }
    else
    {
        if (invalidated)
        {
            agui_draw_body_2d(agui, x1, y1, AGUI_BAR_WIDTH, h, true, true, color2, relief);
        }

        span = h - 2 * (AGUI_BAR_WIDTH/2) - 1;
        offset = y2 - AGUI_BAR_WIDTH/2;

        if (percent > 100)
        {
            percent = 100;
        }
        done = (percent * span) / 100;
        graphics_fill_segment(canvas, x1 + AGUI_BAR_WIDTH/2, offset, AGUI_BAR_WIDTH/4, 180, 180, color1);
        graphics_fill_rect(canvas, x1 + AGUI_BAR_WIDTH/2 - AGUI_BAR_WIDTH/4, offset - done, 2 * (AGUI_BAR_WIDTH/4) + 1, done, color1);
        graphics_fill_segment(canvas, x1 + AGUI_BAR_WIDTH/2, offset - done, AGUI_BAR_WIDTH/4, 0, 180, color1);
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

#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D

    if (percentage != progressbar->percentage)
    {
        progressbar->percentage = percentage;
        obj_invalidate_child(obj);
    }

#elif AGUI_APPEARANCE==AGUI_APPEARANCE_2D

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

#endif
}

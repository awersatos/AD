/*****************************************************************************\
|*
|*  IN PACKAGE:     Graphics         
|*
|*  COPYRIGHT:      Copyright (c) 2008, Altium
|*
|*  DESCRIPTION:    Filled rectangle routines
|*
 */

#include <stdint.h>
#include <graphics.h>
#include <graphics_i.h>
#include "graphics_cfg.h"
#include "graphics_cfg_instance.h"

static void _graphics_fill_rect(canvas_t const * restrict canvas, int x, int y, int width, int height, color_t color);

/*
 * FILL RECT
 */

/**
 * @brief    Draw filled rectangle on canvas
 *
 * Draw a filled rectangle on the canvas.
 *
 * The width and height should be positive to draw the rectangle. If one of these parameters is negative, the rectangle is not drawn.
 *
 * The color can be specified as SVG color or as RGB-color. 
 * For a complete list of SVG-colors, see SVG_colors.h.
 * For RGB-colors, use the macro RGB(R-value, G-value, B-value).
 *
 * @param canvas Canvas pointer
 * @param x      Left location of rectangle
 * @param y      Top location of rectangle
 * @param width  Width of the rectangle
 * @param height Height of the rectangle
 * @param color  Color as SVG-color or RGB-color.
 *
 * @return Nothing
 */

void graphics_fill_rect(canvas_t const * restrict canvas, int x, int y, int width, int height, color_t color)
{
    switch(canvas->rotation)
    {
#if (GRAPHICS_INSTANCE_ROTATION_0_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_0:
        _graphics_fill_rect(canvas, X_0_DEGR(canvas, x, y), Y_0_DEGR(canvas, x, y), width, height, color);
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_90_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_90:
        _graphics_fill_rect(canvas, X_90_DEGR(canvas, x, y) - height + 1, Y_90_DEGR(canvas, x, y), height, width, color);
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_180_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_180:
        _graphics_fill_rect(canvas, X_180_DEGR(canvas, x, y) - width + 1, Y_180_DEGR(canvas, x, y) - height + 1, width, height, color);
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_270_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_270:
        _graphics_fill_rect(canvas, X_270_DEGR(canvas, x, y), Y_270_DEGR(canvas, x, y) - width + 1, height, width, color);
        break;
#endif
    }
}


static void _graphics_fill_rect(canvas_t const * restrict canvas, int x, int y, int width, int height, color_t color)
{
    int  w      = canvas->buffer_width;
    int  left   = canvas->pane_left;      // left, right, top, bottom of drawable area
    int  right  = canvas->pane_right;
    int  top    = canvas->pane_top;
    int  bottom = canvas->pane_bottom;

    color = canvas->convert_color_to_native(color);  // convert color to native format

#if GRAPHICS_CHECK_COORDINATES == 1
    if (x < left)
    {
        width -= left - x;
        x = left;
    }
    if ((x + width - 1) > right)
    {
        width = right - x + 1;
    }

    if (y < top)
    {
        height -= top - y;
        y = top;
    }
    if ((y + height - 1) > bottom)
    {
        height = bottom - y + 1;
    }
#endif

    if (w == width)
    {
        /* full width, calculate start- and end-point and fill mem */
        canvas->draw_horizontal(canvas, x, w * height - 1, y, color);
    }
    else
    {
        /* else fill one line at a time */
        for (int i = 0; i < height; i++)
        {
            canvas->draw_horizontal(canvas, x, x + width - 1, i + y, color);
        }
    }
}


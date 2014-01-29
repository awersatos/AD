/*****************************************************************************\
|*
|*  IN PACKAGE:     Graphics         
|*
|*  COPYRIGHT:      Copyright (c) 2008, Altium
|*
|*  DESCRIPTION:    Line routines
|*
 */

#include <stdint.h>
#include <graphics.h>
#include <graphics_i.h>
#include "graphics_cfg.h"
#include "graphics_cfg_instance.h"

static void _graphics_draw_line(canvas_t const * restrict canvas, int x1, int y1, int x2, int y2, color_t color);

/*
 * DRAW LINE
 */

/**
 * @brief    Draw line on canvas
 *
 * Draw a straight line on the canvas.
 *
 * Both start point and end point are included in the line.
 *
 * The color can be specified as SVG color or as RGB-color.
 * For a complete list of SVG-colors, see SVG_colors.h.
 * For RGB-colors, use the macro RGB(R-value, G-value, B-value).
 *
 * @param canvas Canvas pointer
 * @param x1     x Location of start point of line
 * @param y1     y Location of start point of line
 * @param x2     x Location of end point of line
 * @param y2     y Location of end point of line
 * @param color  Color as SVG-color or RGB-color.
 *
 * @return Nothing
 */

void graphics_draw_line(canvas_t const * restrict canvas, int x1, int y1, int x2, int y2, color_t color)
{
    switch(canvas->rotation)
    {
#if (GRAPHICS_INSTANCE_ROTATION_0_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_0:
        _graphics_draw_line(canvas, x1 + canvas->canvas_left, y1 + canvas->canvas_top, x2 + canvas->canvas_left, y2 + canvas->canvas_top, color);
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_90_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_90:
        _graphics_draw_line(canvas, canvas->canvas_top - y1, canvas->canvas_left + x1, canvas->canvas_top - y2, canvas->canvas_left + x2, color);
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_180_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_180:
        _graphics_draw_line(canvas, canvas->canvas_left - x1, canvas->canvas_top - y1, canvas->canvas_left - x2, canvas->canvas_top - y2, color);
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_270_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_270:
        _graphics_draw_line(canvas, y1 + canvas->canvas_top, canvas->canvas_left - x1, y2 + canvas->canvas_top, canvas->canvas_left - x2, color);
        break;
#endif
    }
}


static void _graphics_draw_line(canvas_t const * restrict canvas, int x1, int y1, int x2, int y2, color_t color)
{
    int   sx, sy;
    int   dx, dy;
    int   d;
    int   left   = canvas->pane_left;      // left, right, top, bottom of drawable area
    int   right  = canvas->pane_right;
    int   top    = canvas->pane_top;
    int   bottom = canvas->pane_bottom;

    color = canvas->convert_color_to_native(color);  // convert color to native format

    if (x1 == x2)       /* optimize for vertical line */
    {
#if GRAPHICS_CHECK_COORDINATES == 1
        if ((x1 < left) || (x1 > right))
        {
            return; // nothing to draw
        }
#endif
        if (y2 > y1)
        {
#if GRAPHICS_CHECK_COORDINATES == 1
            if ((y1 > bottom) || (y2 < top))
            {
                return;
            }
            if (y1 < top)
            {
                y1 = top;
            }
            if (y2 > bottom)
            {
                y2 = bottom;
            }
#endif
            canvas->draw_vertical(canvas, x1, y1, y2, color);
        }
        else
        {
#if GRAPHICS_CHECK_COORDINATES == 1
            if ((y2 > bottom) || (y1 < top))
            {
                return;
            }
            if (y2 < top)
            {
                y2 = top;
            }
            if (y1 > bottom)
            {
                y1 = bottom;
            }
#endif
            canvas->draw_vertical(canvas, x1, y2, y1, color);
        }
    }

    else if (y1 == y2)  /* optimize for horizontal line */
    {
#if GRAPHICS_CHECK_COORDINATES == 1
        if ((y1 < top) || (y1 > bottom))
        {
            return; // nothing to draw
        }
#endif
        if (x2 > x1)
        {
#if GRAPHICS_CHECK_COORDINATES == 1
            if ((x1 > right) || (x2 < left))
            {
                return;
            }
            if (x1 < left)
            {
                x1 = left;
            }
            if (x2 > right)
            {
                x2 = right;
            }
#endif
            canvas->draw_horizontal(canvas, x1, x2, y1, color);
        }
        else
        {
#if GRAPHICS_CHECK_COORDINATES == 1
            if ((x2 > right) || (x1 < left))
            {
                return;
            }
            if (x2 < left)
            {
                x2 = left;
            }
            if (x1 >= right)
            {
                x1 = right;
            }
#endif
            canvas->draw_horizontal(canvas, x2, x1, y1, color);
        }
    }

    else    /* diagonal line */
    {
        if ( x2 > x1 )
        {
            sx = 1;
            dx = x2 - x1;
        }
        else
        {
            sx = -1;
            dx = x1 - x2;
        }

        if ( y2 > y1 )
        {
            sy = 1;
            dy = y2 - y1;
        }
        else
        {
            sy = -1;
            dy = y1 - y2;
        }

        if ( dy > dx )
        {
            /* steep line? calculate x for each y */
            d = (2 * dx) - dy;
            do
            {
#if GRAPHICS_CHECK_COORDINATES == 1
                if ((x1 >= left) && (x1 <= right) && (y1 >= top) && (y1 <= bottom))
                {
                    canvas->draw_pixel(canvas, x1, y1, color);
                }
#else
                canvas->draw_pixel(canvas, x1, y1, color);
#endif
                if ( d >= 0 )
                {
                    x1 += sx;
                    d -= 2 * dy;
                }
                y1 += sy;
                d += 2 * dx;
            } while (y1 != y2);
        }
        else
        {
            /* otherwise calculate y for each x */
            d = (2 * dy) - dx;
            do
            {
#if GRAPHICS_CHECK_COORDINATES == 1
                if ((x1 >=left) && (x1 <= right) && (y1 >= top) && (y1 <= bottom))
                {
                    canvas->draw_pixel(canvas, x1, y1, color);
                }
#else
                canvas->draw_pixel(canvas, x1, y1, color);
#endif
                if ( d >= 0 )
                {
                    y1 += sy;
                    d -= 2 * dx;
                }
                x1 += sx;
                d += 2 * dy;
            } while (x1 != x2);
        }
#if GRAPHICS_CHECK_COORDINATES == 1
        if ((x1 >= left) && (x1 <= right) && (y1 >= top) && (y1 <= bottom))
        {
            canvas->draw_pixel(canvas, x1, y1, color);
        }
#else
        canvas->draw_pixel(canvas, x1, y1, color);
#endif
    }
}


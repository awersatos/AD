/*****************************************************************************\
|*
|*  IN PACKAGE:     Graphics         
|*
|*  COPYRIGHT:      Copyright (c) 2008, Altium
|*
|*  DESCRIPTION:    Filled circle routines
|*
 */

#include <stdint.h>
#include <graphics.h>
#include <graphics_i.h>
#include "graphics_cfg.h"
#include "graphics_cfg_instance.h"

static void _graphics_fill_circle(canvas_t const * restrict canvas, int x, int y, unsigned int r, color_t color );

/*
 * FILL CIRCLE
 */

/**
 * @brief    Draw filled circle on canvas
 *
 * Draw a filled circle on the canvas.
 *
 * The color can be specified as SVG color or as RGB-color. 
 * For a complete list of SVG-colors, see SVG_colors.h.
 * For RGB-colors, use the macro RGB(R-value, G-value, B-value).
 *
 * @param canvas Canvas pointer
 * @param x      x Location of centrepoint of circle
 * @param y      y Location of centrepoint of circle
 * @param r      Radius of circle
 * @param color  Color as SVG-color or RGB-color.
 *
 * @return Nothing
 */

void graphics_fill_circle(canvas_t const * restrict canvas, int x, int y, unsigned int r, color_t color)
{
    switch (canvas->rotation)
    {
#if (GRAPHICS_INSTANCE_ROTATION_0_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_0:
        _graphics_fill_circle(canvas, X_0_DEGR(canvas, x, y), Y_0_DEGR(canvas, x, y), r, color);
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_90_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_90:
        _graphics_fill_circle(canvas, X_90_DEGR(canvas, x, y), Y_90_DEGR(canvas, x, y), r, color);
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_180_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_180:
        _graphics_fill_circle(canvas, X_180_DEGR(canvas, x, y), Y_180_DEGR(canvas, x, y), r, color);
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_270_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_270:
        _graphics_fill_circle(canvas, X_270_DEGR(canvas, x, y), Y_270_DEGR(canvas, x, y), r, color);
        break;
#endif
    }
}


static void _graphics_fill_circle(canvas_t const * restrict canvas, int x, int y, unsigned int r, color_t color )
{
    int   eps;
    int   d1;     // delta 1
    int   d2;     // delta 2
    int   left   = canvas->pane_left;      // left, right, top, bottom of drawable area
    int   right  = canvas->pane_right;
    int   top    = canvas->pane_top;
    int   bottom = canvas->pane_bottom;
#if GRAPHICS_CHECK_COORDINATES == 1
    int   a;      // draw line from a to b
    int   b;
#endif

    color = canvas->convert_color_to_native(color);  // convert color to native format

    d1 = 0;
    d2 = r;
    eps = 3 - (r << 1);
    while( d1 <= d2 )
    {
#if GRAPHICS_CHECK_COORDINATES == 1
        a = x - d1;
        if (a < left)  a = left;      // check coordinate

        b = x + d1;
        if (b > right) b = right;  // check coordinate

        if (((y + d2) >= top) && ((y + d2) <= bottom)) // check coordinate
        {
            canvas->draw_horizontal(canvas, a, b, y + d2, color);
        }

        if (((y - d2) >= top) && ((y - d2) <= bottom)) // check coordinate
        {
            canvas->draw_horizontal(canvas, a, b, y - d2, color);
        }

        a = x - d2;
        if (a < left)  a = left;      // check coordinate

        b = x + d2;
        if (b > right) b = right;  // check coordinate

        if (((y + d1) >= top) && ((y + d1) <= bottom)) // check coordinate
        {
            canvas->draw_horizontal(canvas, a, b, y + d1, color);
        }

        if (((y - d1) >= top) && ((y - d1) <= bottom)) // check coordinate
        {
            canvas->draw_horizontal(canvas, a, b, y - d1, color);
        }

#else

        canvas->draw_horizontal(canvas, x - d1, x + d1, y + d2, color);
        canvas->draw_horizontal(canvas, x - d1, x + d1, y - d2, color);
        canvas->draw_horizontal(canvas, x - d2, x + d2, y + d1, color);
        canvas->draw_horizontal(canvas, x - d2, x + d2, y - d1, color);

#endif

        if ( eps < 0 )
        {
            eps += (d1 << 2) + 6;
        }
        else
        {
            eps += ((d1 - d2) << 2) + 10;
            d2--;
        }
        d1++;
    }
}


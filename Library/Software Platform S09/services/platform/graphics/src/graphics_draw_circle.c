/*****************************************************************************\
|*
|*  IN PACKAGE:     Graphics
|*
|*  COPYRIGHT:      Copyright (c) 2008, Altium
|*
|*  DESCRIPTION:    Circle routines
|*
 */

#include <stdint.h>
#include <graphics.h>
#include <graphics_i.h>
#include "graphics_cfg.h"
#include "graphics_cfg_instance.h"

static void _graphics_draw_circle(canvas_t const * restrict canvas, int x, int y, unsigned int r, color_t color );

/*
 * DRAW CIRCLE
 */

/**
 * @brief    Draw circle on canvas
 *
 * Draw a circle on the canvas.
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

void graphics_draw_circle(canvas_t const * restrict canvas, int x, int y, unsigned int r, color_t color)
{
    switch (canvas->rotation)
    {
#if (GRAPHICS_INSTANCE_ROTATION_0_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_0:
        _graphics_draw_circle(canvas, X_0_DEGR(canvas, x, y), Y_0_DEGR(canvas, x, y), r, color);
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_90_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_90:
        _graphics_draw_circle(canvas, X_90_DEGR(canvas, x, y), Y_90_DEGR(canvas, x, y), r, color);
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_180_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_180:
        _graphics_draw_circle(canvas, X_180_DEGR(canvas, x, y), Y_180_DEGR(canvas, x, y), r, color);
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_270_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_270:
        _graphics_draw_circle(canvas, X_270_DEGR(canvas, x, y), Y_270_DEGR(canvas, x, y), r, color);
        break;
#endif
    }
}


static void _graphics_draw_circle(canvas_t const * restrict canvas, int x, int y, unsigned int r, color_t color )
{
    int  eps;
    int  d1;
    int  d2;
    int  left   = canvas->pane_left;      // left, right, top, bottom of drawable area
    int  right  = canvas->pane_right;
    int  top    = canvas->pane_top;
    int  bottom = canvas->pane_bottom;

    color = canvas->convert_color_to_native(color);  // convert color to native format

    d1 = 0;
    d2 = r;
    eps = 3 - (r << 1);
    while( d1 <= d2 )
    {
#if GRAPHICS_CHECK_COORDINATES == 1
        if ((y + d2) >= top && (y + d2) <= bottom)
        {
            if  ((x + d1) >= left && (x + d1) <= right)
            {
                canvas->draw_pixel(canvas, x + d1, y + d2, color);   //segment 6
            }
            if ((x - d1) >= left && (x - d1) <= right)
            {
                canvas->draw_pixel(canvas, x - d1, y + d2, color);   //segment 5
            }
        }
        if ((y - d2) >= top && (y - d2) <= bottom)
        {
            if ((x + d1) >= left && (x + d1) <= right)
            {
                canvas->draw_pixel(canvas, x + d1, y - d2, color);   //segment 1
            }
            if ((x - d1) >= left && (x - d1) <= right)
            {
                canvas->draw_pixel(canvas, x - d1, y - d2, color);   //segment 2
            }
        }

        if ((y + d1) >= top && (y + d1) <= bottom)
        {
            if ((x + d2) >= left && (x + d2) <= right)
            {
                canvas->draw_pixel(canvas, x + d2, y + d1, color);   //segment 7
            }
            if ((x - d2) >= left && (x - d2) <= right)
            {
                canvas->draw_pixel(canvas, x - d2, y + d1, color);   //segment 4
            }
        }
        if ((y - d1) >= top && (y - d1) <= bottom)
        {
            if ((x + d2) >= left && (x + d2) <= right)
            {
                canvas->draw_pixel(canvas, x + d2, y - d1, color);   //segment 0
            }
            if ((x - d2) >= left && (x - d2) <= right)
            {
                canvas->draw_pixel(canvas, x - d2, y - d1, color);   //segment 3
            }
        }

#else
        canvas->draw_pixel(canvas, x + d1, y + d2, color);   //segment 6
        canvas->draw_pixel(canvas, x - d1, y + d2, color);   //segment 5
        canvas->draw_pixel(canvas, x + d1, y - d2, color);   //segment 1
        canvas->draw_pixel(canvas, x - d1, y - d2, color);   //segment 2
        canvas->draw_pixel(canvas, x + d2, y + d1, color);   //segment 7
        canvas->draw_pixel(canvas, x - d2, y + d1, color);   //segment 4
        canvas->draw_pixel(canvas, x + d2, y - d1, color);   //segment 0
        canvas->draw_pixel(canvas, x - d2, y - d1, color);   //segment 3
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


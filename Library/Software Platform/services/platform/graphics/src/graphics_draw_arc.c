/*****************************************************************************\
|*
|*  IN PACKAGE:     Graphics         
|*
|*  COPYRIGHT:      Copyright (c) 2008, Altium
|*
|*  DESCRIPTION:    Arc routines
|*
 */

#include <stdint.h>
#include <stdbool.h>
#include <graphics.h>
#include <graphics_i.h>
#include "graphics_cfg.h"
#include "graphics_cfg_instance.h"

static void _graphics_draw_arc(canvas_t const * restrict canvas, int x, int y, unsigned int r, int start_angle, int arc_angle, color_t color );

/*
 * DRAW ARC
 */

/**
 * @brief    Draw arc on canvas
 *
 * Draw an circular arc on the canvas. An circular arc is a segment of the circumference of a circle.
 *
 * The start angle of the arc is given in degrees, 0 degrees is at the 3 o'clock position.
 * A positive value indicates a counterclockwise rotation.
 *
 * The arc angle gives the number of degrees between start and end angle.
 * A positive value indicates a counterclockwise rotation.
 *
 * The pixels at the start and end angle are included in the arc.
 *
 * The color can be specified as SVG color or as RGB-color. 
 * For a complete list of SVG-colors, see SVG_colors.h.
 * For RGB-colors, use the macro RGB(R-value, G-value, B-value).
 *
 * @param canvas       Canvas pointer
 * @param x            x Location of centrepoint of corresponding circle
 * @param y            y Location of centrepoint of corresponding circle
 * @param r            Radius of corresponding circle
 * @param start_angle  Start angle of arc
 * @param arc_angle    Angle of arc
 * @param color        Color as SVG-color or RGB-color.
 *
 * @return Nothing
 */

void graphics_draw_arc(canvas_t const * restrict canvas, int x, int y, unsigned int r, int start_angle, int arc_angle, color_t color )
{
    switch (canvas->rotation)
    {
#if (GRAPHICS_INSTANCE_ROTATION_0_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_0:
        _graphics_draw_arc(canvas, X_0_DEGR(canvas, x, y), Y_0_DEGR(canvas, x, y), r, start_angle, arc_angle, color );
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_90_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_90:
        _graphics_draw_arc(canvas, X_90_DEGR(canvas, x, y), Y_90_DEGR(canvas, x, y), r, start_angle - 90, arc_angle, color );
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_180_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_180:
        _graphics_draw_arc(canvas, X_180_DEGR(canvas, x, y), Y_180_DEGR(canvas, x, y), r, start_angle + 180, arc_angle, color );
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_270_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_270:
        _graphics_draw_arc(canvas, X_270_DEGR(canvas, x, y), Y_270_DEGR(canvas, x, y), r, start_angle + 90, arc_angle, color );
        break;
#endif
    }
}


static void _graphics_draw_arc(canvas_t const * restrict canvas, int x, int y, unsigned int r, int start_angle, int arc_angle, color_t color )
{
    bool    part_mask[8] = {false}; // a circle is divided in 8 symmetrical parts which are defined by either horizontal, vertical and/or diagonal mirroring
    int     start_segment;
    int     end_segment;
    int     start_pos = 0;
    int     end_pos = 0;
    int     sa;
    int     ea;
    int     eps;
    int     d1;     // delta 1
    int     d2;     // delta 2
    int     w = canvas->buffer_width;
    int     h = canvas->buffer_height;
    int     i;
    int     left   = canvas->pane_left;      // left, right, top, bottom of drawable area
    int     right  = canvas->pane_right;
    int     top    = canvas->pane_top;
    int     bottom = canvas->pane_bottom;

    color = canvas->convert_color_to_native(color);  // convert color to native format

    if (arc_angle == 0)
    {
        return;     // nothing to draw
    }

    if ((arc_angle >= 360) || (arc_angle <= -360))  // full circle
    {
        for (int i = 0; i < 8; i++)
        {
            part_mask[i] = true;
        }
        start_segment = 0;
        start_pos = -1;
        end_segment = 0;
        end_pos = -1;
    }
    else
    {
        if (arc_angle < 0)
        {
            sa = start_angle + arc_angle;
            ea = start_angle;
        }
        else
        {
            sa = start_angle;
            ea = start_angle + arc_angle;
        }
        sa %= 360;
        if (sa < 0)  sa += 360;

        ea %= 360;
        if (ea < 0)  ea += 360;

        start_segment = sa / 45;
        switch(start_segment)
        {
        case 0:
            start_pos = ((unsigned int)_sin_degrees_lut[sa] * r) >> 16;
            break;
        case 1:
            start_pos = ((unsigned int)_sin_degrees_lut[90 - sa] * r) >> 16;
            break;
        case 2:
            start_pos = ((unsigned int)_sin_degrees_lut[sa - 90] * r) >> 16;
            break;
        case 3:
            start_pos = ((unsigned int)_sin_degrees_lut[180 - sa] * r) >> 16;
            break;
        case 4:
            start_pos = ((unsigned int)_sin_degrees_lut[sa - 180] * r) >> 16;
            break;
        case 5:
            start_pos = ((unsigned int)_sin_degrees_lut[270 - sa] * r) >> 16;
            break;
        case 6:
            start_pos = ((unsigned int)_sin_degrees_lut[sa - 270] * r) >> 16;
            break;
        case 7:
            start_pos = ((unsigned int)_sin_degrees_lut[360 - sa] * r) >> 16;
            break;
        }

        end_segment = ea / 45;
        switch(end_segment)
        {
        case 0:
            end_pos = ((unsigned int)_sin_degrees_lut[ea] * r) >> 16;
            break;
        case 1:
            end_pos = ((unsigned int)_sin_degrees_lut[90 - ea] * r) >> 16;
            break;
        case 2:
            end_pos = ((unsigned int)_sin_degrees_lut[ea - 90] * r) >> 16;
            break;
        case 3:
            end_pos = ((unsigned int)_sin_degrees_lut[180 - ea] * r) >> 16;
            break;
        case 4:
            end_pos = ((unsigned int)_sin_degrees_lut[ea - 180] * r) >> 16;
            break;
        case 5:
            end_pos = ((unsigned int)_sin_degrees_lut[270 - ea] * r) >> 16;
            break;
        case 6:
            end_pos = ((unsigned int)_sin_degrees_lut[ea - 270] * r) >> 16;
            break;
        case 7:
            end_pos = ((unsigned int)_sin_degrees_lut[360 - ea] * r) >> 16;
            break;
        }

        if (start_segment == end_segment)
        {
            if (sa > ea)
            {
                for (i = 0; i < 8; i++)
                {
                    part_mask[i] = true;
                }
            }
            else
            {
                for (i = 0; i < 8; i++)
                {
                    part_mask[i] = false;
                }
            }
        }
        else
        {
            i = start_segment;
            while (i != end_segment)
            {
                part_mask[i] = true;
                i++;
                i %= 8;
            }
            part_mask[start_segment] = start_segment % 2;
            part_mask[end_segment] = !(end_segment % 2);
        }
    }

    /* draw partial circle */
    d1 = 0;
    d2 = r;
    eps = 3 - (r << 1);
    while( d1 <= d2 )
    {
        /* toggle start- and end-segment on when reaching the respective positions */
        if ((d1 == start_pos) && ((start_segment % 2) == 0))
        {
            part_mask[start_segment] = true;
            start_pos = -1;
        }
        if ((d1 == end_pos) && ((end_segment % 2) == 1))
        {
            part_mask[end_segment] = true;
            end_pos = -1;
        }
#if GRAPHICS_CHECK_COORDINATES == 1
        if ((y + d2) >= top && (y + d2) <= bottom)
        {
            if (part_mask[6] && (x + d1) >= left && (x + d1) <= right)
            {
                canvas->draw_pixel(canvas, x + d1, y + d2, color);   // segment 6
            }
            if (part_mask[5] && (x - d1) >= left && (x - d1) <= right)
            {
                canvas->draw_pixel(canvas, x - d1, y + d2, color);   // segment 5
            }
        }
        if ((y - d2) >= top && (y - d2) <= bottom)
        {
            if (part_mask[1] && (x + d1) >= left && (x + d1) <= right)
            {
                canvas->draw_pixel(canvas, x + d1, y - d2, color);   // segment 1
            }
            if (part_mask[2] && (x - d1) >= left && (x - d1) <= right)
            {
                canvas->draw_pixel(canvas, x - d1, y - d2, color);   // segment 2
            }
        }

        if ((y + d1) >= top && (y + d1) <= bottom)
        {
            if (part_mask[7] && (x + d2) >= left && (x + d2) <= right)
            {
                canvas->draw_pixel(canvas, x + d2, y + d1, color);   // segment 7
            }
            if (part_mask[4] && (x - d2) >= left && (x - d2) <= right)
            {
                canvas->draw_pixel(canvas, x - d2, y + d1, color);   // segment 4
            }
        }
        if ((y - d1) >= top && (y - d1) <= bottom)
        {
            if (part_mask[0] && (x + d2) >= left && (x + d2) <= right)
            {
                canvas->draw_pixel(canvas, x + d2, y - d1, color);   // segment 0
            }
            if (part_mask[3] && (x - d2) >= left && (x - d2) <= right)
            {
                canvas->draw_pixel(canvas, x - d2, y - d1, color);   // segment 3
            }
        }

#else
        if (part_mask[6])
        {
            canvas->draw_pixel(canvas, x + d1, y + d2, color);   // segment 6
        }
        if (part_mask[5])
        {
            canvas->draw_pixel(canvas, x - d1, y + d2, color);   // segment 5
        }
        if (part_mask[1])
        {
            canvas->draw_pixel(canvas, x + d1, y - d2, color);   // segment 1
        }
        if (part_mask[2])
        {
            canvas->draw_pixel(canvas, x - d1, y - d2, color);   // segment 2
        }
        if (part_mask[7])
        {
            canvas->draw_pixel(canvas, x + d2, y + d1, color);   // segment 7
        }
        if (part_mask[4])
        {
            canvas->draw_pixel(canvas, x - d2, y + d1, color);   // segment 4
        }
        if (part_mask[0])
        {
            canvas->draw_pixel(canvas, x + d2, y - d1, color);   // segment 0
        }
        if (part_mask[3])
        {
            canvas->draw_pixel(canvas, x - d2, y - d1, color);   // segment 3
        }
#endif

        /* toggle start- and end-segment off when passing the respective positions */
        if ((d1 == start_pos) && ((start_segment % 2) == 1))
        {
            part_mask[start_segment] = false;
            start_pos = -1;
        }
        if ((d1 == end_pos) && ((end_segment % 2) == 0))
        {
            part_mask[end_segment] = false;
            end_pos = -1;
        }

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


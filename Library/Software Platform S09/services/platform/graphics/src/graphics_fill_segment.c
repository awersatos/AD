/*****************************************************************************\
|*
|*  IN PACKAGE:     Graphics         
|*
|*  COPYRIGHT:      Copyright (c) 2008, Altium
|*
|*  DESCRIPTION:    Filled segment routines
|*
 */

#include <stdint.h>
#include <stdbool.h>
#include <graphics.h>
#include <graphics_i.h>
#include "graphics_cfg.h"
#include "graphics_cfg_instance.h"

static void _graphics_fill_segment(canvas_t const * restrict canvas, int x, int y, unsigned int r, int start_angle, int segment_angle, color_t color );
static int _get_delta2(int delta1, unsigned int r);
static int _get_x(int x1, int y1, int x2, int y2, int y, bool left);

/*
 * FILL SEGMENT
 */

/**
 * @brief    Draw segment on canvas
 *
 * Draw an circular segment on the canvas.
 * A segment is a area of a circle enclosed by a circular arc and a straight line from the start to the end of the arc.
 *
 * The start angle of the segment is given in degrees, 0 degrees is at the 3 o'clock position.
 * A positive value indicates a counterclockwise rotation.
 *
 * The segment angle gives the number of degrees between start and end angle.
 * A positive value indicates a counterclockwise rotation.
 *
 * The pixels at the start and end angle are included in the segment.
 *
 * The color can be specified as SVG color or as RGB-color. 
 * For a complete list of SVG-colors, see SVG_colors.h.
 * For RGB-colors, use the macro RGB(R-value, G-value, B-value).
 *
 * @param canvas        Canvas pointer
 * @param x             x Location of centrepoint of corresponding circle
 * @param y             y Location of centrepoint of corresponding circle
 * @param r             Radius of corresponding circle
 * @param start_angle   Start angle of segment
 * @param segment_angle Angle of segment
 * @param color         Color as SVG-color or RGB-color.
 *
 * @return Nothing
 */

void graphics_fill_segment(canvas_t const * restrict canvas, int x, int y, unsigned int r, int start_angle, int segment_angle, color_t color )
{
    switch (canvas->rotation)
    {
#if (GRAPHICS_INSTANCE_ROTATION_0_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_0:
        _graphics_fill_segment(canvas, X_0_DEGR(canvas, x, y), Y_0_DEGR(canvas, x, y), r, start_angle, segment_angle, color);
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_90_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_90:
        _graphics_fill_segment(canvas, X_90_DEGR(canvas, x, y), Y_90_DEGR(canvas, x, y), r, start_angle - 90, segment_angle, color );
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_180_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_180:
        _graphics_fill_segment(canvas, X_180_DEGR(canvas, x, y), Y_180_DEGR(canvas, x, y), r, start_angle + 180, segment_angle, color );
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_270_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_270:
        _graphics_fill_segment(canvas, X_270_DEGR(canvas, x, y), Y_270_DEGR(canvas, x, y), r, start_angle + 90, segment_angle, color );
        break;
#endif
    }
}


static void _graphics_fill_segment(canvas_t const * restrict canvas, int x, int y, unsigned int r, int start_angle, int segment_angle, color_t color )
{
    bool part_mask[8] = {false}; // a circle is divided in 8 symmetrical part which are defined by either horizontal, vertical or diagonal mirroring
    int  start_part;
    int  end_part;
    int  start_delta = 0;
    int  end_delta = 0;
    int  sa;
    int  ea;
    int  eps;
    int  d1;     // delta 1
    int  d2;     // delta 2
    int  x1 = 0, y1 = 0; // start point of chord
    int  x2 = 0, y2 = 0; // end point of chord
    int  a, b;   // to fill, draw horizontal lines from x=a to x=b.
    int  swap;
    int  left   = canvas->pane_left;      // left, right, top, bottom of drawable area
    int  right  = canvas->pane_right;
    int  top    = canvas->pane_top;
    int  bottom = canvas->pane_bottom;
    int  i;

    color = canvas->convert_color_to_native(color);  // convert color to native format

    if (segment_angle == 0)
    {
        return;     // nothing to draw
    }

    if ((segment_angle >= 360) || (segment_angle <= -360))
    {
        graphics_fill_circle(canvas, x, y, r, color);  // full circle
        return;
    }

    if (segment_angle < 0)
    {
        sa = start_angle + segment_angle;
        ea = start_angle;
    }
    else
    {
        sa = start_angle;
        ea = start_angle + segment_angle;
    }
    sa %= 360;
    if (sa < 0)  sa += 360;

    ea %= 360;
    if (ea < 0)  ea += 360;

    start_part = sa / 45;
    switch(start_part)
    {
    case 0:
        start_delta = ((unsigned int)_sin_degrees_lut[sa] * r) >> 16;
        x1 = _get_delta2(start_delta, r);
        y1 = -start_delta;
        break;
    case 1:
        start_delta = ((unsigned int)_sin_degrees_lut[90 - sa] * r) >> 16;
        x1 = start_delta;
        y1 = -_get_delta2(start_delta, r);
        break;
    case 2:
        start_delta = ((unsigned int)_sin_degrees_lut[sa - 90] * r) >> 16;
        x1 = -start_delta;
        y1 = -_get_delta2(start_delta, r);
        break;
    case 3:
        start_delta = ((unsigned int)_sin_degrees_lut[180 - sa] * r) >> 16;
        x1 = -_get_delta2(start_delta, r);
        y1 = -start_delta;
        break;
    case 4:
        start_delta = ((unsigned int)_sin_degrees_lut[sa - 180] * r) >> 16;
        x1 = -_get_delta2(start_delta, r);
        y1 = start_delta;
        break;
    case 5:
        start_delta = ((unsigned int)_sin_degrees_lut[270 - sa] * r) >> 16;
        x1 = -start_delta;
        y1 = _get_delta2(start_delta, r);
        break;
    case 6:
        start_delta = ((unsigned int)_sin_degrees_lut[sa - 270] * r) >> 16;
        x1 = start_delta;
        y1 = _get_delta2(start_delta, r);
        break;
    case 7:
        start_delta = ((unsigned int)_sin_degrees_lut[360 - sa] * r) >> 16;
        x1 = _get_delta2(start_delta, r);
        y1 = start_delta;
        break;
    }

    end_part = ea / 45;
    switch(end_part)
    {
    case 0:
        end_delta = ((unsigned int)_sin_degrees_lut[ea] * r) >> 16;
        x2 = _get_delta2(end_delta, r);
        y2 = -end_delta;
        break;
    case 1:
        end_delta = ((unsigned int)_sin_degrees_lut[90 - ea] * r) >> 16;
        x2 = end_delta;
        y2 = -_get_delta2(end_delta, r);
        break;
    case 2:
        end_delta = ((unsigned int)_sin_degrees_lut[ea - 90] * r) >> 16;
        x2 = -end_delta;
        y2 = -_get_delta2(end_delta, r);
        break;
    case 3:
        end_delta = ((unsigned int)_sin_degrees_lut[180 - ea] * r) >> 16;
        x2 = -_get_delta2(end_delta, r);
        y2 = -end_delta;
        break;
    case 4:
        end_delta = ((unsigned int)_sin_degrees_lut[ea - 180] * r) >> 16;
        x2 = -_get_delta2(end_delta, r);
        y2 = end_delta;
        break;
    case 5:
        end_delta = ((unsigned int)_sin_degrees_lut[270 - ea] * r) >> 16;
        x2 = -end_delta;
        y2 = _get_delta2(end_delta, r);
        break;
    case 6:
        end_delta = ((unsigned int)_sin_degrees_lut[ea - 270] * r) >> 16;
        x2 = end_delta;
        y2 = _get_delta2(end_delta, r);
        break;
    case 7:
        end_delta = ((unsigned int)_sin_degrees_lut[360 - ea] * r) >> 16;
        x2 = _get_delta2(end_delta, r);
        y2 = end_delta;
        break;
    }

    /* sort chord points */
    if (y1 > y2)
    {
        swap = x2;
        x2 = x1;
        x1 = swap;
        swap = y2;
        y2 = y1;
        y1 = swap;
    }

    if (start_part == end_part)
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
        i = start_part;
        while (i != end_part)
        {
            part_mask[i] = true;
            i++;
            i %= 8;
        }
        part_mask[start_part] = start_part % 2;
        part_mask[end_part] = !(end_part % 2);
    }

    /* draw partial circle */
    d1 = 0;
    d2 = r;
    eps = 3 - (r << 1);
    while( d1 <= d2 )
    {
        /* toggle start- and end-segment on when reaching the respective positions */
        if ((d1 == start_delta) && ((start_part % 2) == 0))
        {
            part_mask[start_part] = true;
            start_delta = -1;
        }
        if ((d1 == end_delta) && ((end_part % 2) == 1))
        {
            part_mask[end_part] = true;
            end_delta = -1;
        }

#if GRAPHICS_CHECK_COORDINATES == 1

        if (((y - d2) >= top) && ((y - d2) <= bottom)) 
        {
            if (part_mask[1] && part_mask[2])
            {
                a = x - d1;
                b = x + d1;

                // check coordinate
                if (a < left)  a = left;
                if (b > right) b = right;
                canvas->draw_horizontal(canvas, a, b, y - d2, color);
            }
            else
            {
                if (part_mask[1])
                {
                    a = x + _get_x(x1, y1, x2, y2, -d2, true);
                    b = x + d1;

                    // check coordinates
                    if (a < left)  a = left;
                    if (b > right) b = right;

                    canvas->draw_horizontal(canvas, a, b, y - d2, color);
                }
                else if (part_mask[2])
                {
                    a = x - d1;
                    b = x + _get_x(x1, y1, x2, y2, -d2, false);

                    // check coordinates
                    if (a < left)  a = left;
                    if (b > right) b = right;

                    canvas->draw_horizontal(canvas, a, b, y - d2, color);
                }
            }
        }


        if (((y - d1) >= top) && ((y - d1) <= bottom))
        {
            if (part_mask[0] && part_mask[3])
            {
                a = x - d2;
                b = x + d2;

                // check coordinate
                if (a < left)  a = left;
                if (b > right) b = right;

                canvas->draw_horizontal(canvas, a, b, y - d1, color);
            }
            else
            {
                if (part_mask[0])
                {
                    a = x + _get_x(x1, y1, x2, y2, -d1, true);
                    b = x + d2;

                    // check coordinate
                    if (a < left)  a = left;
                    if (b > right) b = right;

                    canvas->draw_horizontal(canvas, a, b, y - d1, color);
                }
                else if (part_mask[3])
                {
                    a = x - d2;
                    b = x + _get_x(x1, y1, x2, y2, -d1, false);

                    // check coordinate
                    if (a < left)  a = left;
                    if (b > right) b = right;

                    canvas->draw_horizontal(canvas, a, b, y - d1, color);
                }
            }
        }

        if (((y + d1) >= top) && ((y + d1) <= bottom))
        {
            if (part_mask[4] && part_mask[7])
            {
                a = x - d2;
                b = x + d2;

                // check coordinate
                if (a < left)  a = left;
                if (b > right) b = right;

                canvas->draw_horizontal(canvas, a, b, y + d1, color);
            }
            else
            {
                if (part_mask[7])
                {
                    a = x + _get_x(x1, y1, x2, y2, d1, true);
                    b = x + d2;

                    // check coordinate
                    if (a < left)  a = left;
                    if (b > right) b = right;

                    canvas->draw_horizontal(canvas, a, b, y + d1, color);
                }
                else if (part_mask[4])
                {
                    a = x - d2;
                    b = x + _get_x(x1, y1, x2, y2, d1, false);

                    // check coordinate
                    if (a < left)  a = left;
                    if (b > right) b = right;

                    canvas->draw_horizontal(canvas, a, b, y + d1, color);
                }
            }
        }

        if (((y + d2) >= top) && ((y + d2) <= bottom))
        {
            if (part_mask[5] && part_mask[6])
            {
                a = x - d1;
                b = x + d1;

                // check coordinate
                if (a < left)  a = left;
                if (b > right) b = right;

                canvas->draw_horizontal(canvas, a, b, y + d2, color);
            }
            else
            {
                if (part_mask[6])
                {
                    a = x + _get_x(x1, y1, x2, y2, d2, true);
                    b = x + d1;

                    if (a < left)  a = left;
                    if (b > right) b = right;

                    canvas->draw_horizontal(canvas, a, b, y + d2, color);
                }
                else if (part_mask[5])
                {
                    a = x - d1;
                    b = x + _get_x(x1, y1, x2, y2, d2, false);

                    // check coordinate
                    if (a < left)  a = left;
                    if (b > right) b = right;

                    canvas->draw_horizontal(canvas, a, b, y + d2, color);
                }
            }
        }

#else

        if (part_mask[1] && part_mask[2])
        {
            canvas->draw_horizontal(canvas, x - d1, x + d1, y - d2, color);
        }
        else
        {
            if (part_mask[1])
            {
                a = _get_x(x1, y1, x2, y2, -d2, true);
                canvas->draw_horizontal(canvas, x + a, x + d1, y - d2, color);
            }
            else if (part_mask[2])
            {
                b = _get_x(x1, y1, x2, y2, -d2, false);
                canvas->draw_horizontal(canvas, x - d1, x + b, y - d2, color);
            }
        }

        if (part_mask[0] && part_mask[3])
        {
            canvas->draw_horizontal(canvas, x - d2, x + d2, y - d1, color);
        }
        else
        {
            if (part_mask[0])
            {
                a = _get_x(x1, y1, x2, y2, -d1, true);
                canvas->draw_horizontal(canvas, x + a, x + d2, y - d1, color);
            }
            else if (part_mask[3])
            {
                b = _get_x(x1, y1, x2, y2, -d1, false);
                canvas->draw_horizontal(canvas, x - d2, x + b, y - d1, color);
            }
        }

        if (part_mask[4] && part_mask[7])
        {
            canvas->draw_horizontal(canvas, x - d2, x + d2, y + d1, color);
        }
        else
        {
            if (part_mask[7])
            {
                a = _get_x(x1, y1, x2, y2, d1, true);
                canvas->draw_horizontal(canvas, x + a, x + d2, y + d1, color);
            }
            else if (part_mask[4])
            {
                b = _get_x(x1, y1, x2, y2, d1, false);
                canvas->draw_horizontal(canvas, x - d2, x + b, y + d1, color);
            }
        }

        if (part_mask[5] && part_mask[6])
        {
            canvas->draw_horizontal(canvas, x - d1, x + d1, y + d2, color);
        }
        else
        {
            if (part_mask[6])
            {
                a = _get_x(x1, y1, x2, y2, d2, true);
                canvas->draw_horizontal(canvas, x + a, x + d1, y + d2, color);
            }
            else if (part_mask[5])
            {
                b = _get_x(x1, y1, x2, y2, d2, false);
                canvas->draw_horizontal(canvas, x - d1, x + b, y + d2, color);
            }
        }

#endif

        /* toggle start- and end-segment off when passing the respective positions */
        if ((d1 == start_delta) && ((start_part % 2) == 1))
        {
            part_mask[start_part] = false;
            start_delta = -1;
        }
        if ((d1 == end_delta) && ((end_part % 2) == 0))
        {
            part_mask[end_part] = false;
            end_delta = -1;
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


static int _get_delta2(int delta1, unsigned int r)
{
    int eps;
    int d1;     // delta 1
    int d2;     // delta 2

    d1 = 0;
    d2 = r;
    eps = 3 - (r << 1);
    while( d1 <= d2 )
    {
        if (d1 == delta1)
        {
            break;
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

    return d2;
}


static int _get_x(int x1, int y1, int x2, int y2, int y, bool left)
{
    int  result = x1;
    int  step;
    int  dx, dy;
    bool steep;
    bool extend;
    int  err;

    if (y == y1)
    {
        return x1;
    }

    if (y == y2)
    {
        return x2;
    }

    if (x2 > x1)
    {
        step = 1;
        dx = x2 - x1;
    }
    else
    {
        step = -1;
        dx = x1 - x2;
    }

    dy = y2 - y1;

    if (dx > dy)
    {
        steep = false;
        err = 2 * dy - dx;
    }
    else
    {
        steep = true;
        err = 2 * dx - dy;
    }
    extend = left != (step == 1);

    if (steep)
    {
        while (y1 != y)
        {
            if (err >= 0)
            {
                result += step;
                err -= 2 * dy;
            }
            err += 2 * dx;
            y1++;
        }
    }
    else
    {
        if (extend)
        {
            y++;
        }
        while (y1 != y)
        {
            if (err >= 0)
            {
                y1++;
                err -= 2 * dx;
            }
            result += step;
            err += 2 * dy;
        }
        if (extend)
        {
            result -= step;
        }
    }

    return result;
}


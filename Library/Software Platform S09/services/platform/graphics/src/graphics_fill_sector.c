/*****************************************************************************\
|*
|*  IN PACKAGE:     Graphics         
|*
|*  COPYRIGHT:      Copyright (c) 2008, Altium
|*
|*  DESCRIPTION:    Filled sector routines
|*
 */

#include <stdint.h>
#include <stdbool.h>
#include <graphics.h>
#include <graphics_i.h>
#include "graphics_cfg.h"
#include "graphics_cfg_instance.h"

static int _get_delta2(int delta1, unsigned int r);

/*
 * FILL SECTOR
 */

/**
 * @brief    Draw sector on canvas
 *
 * Draw an circular sector on the canvas. 
 * A sector (also known as pie piece) is a portion of a circle enclosed by two lines from the centre of a circle
 * to the circumference of the circle and the circular arc between these two lines. 
 *
 * The start angle of the sector is given in degrees, 0 degrees is at the 3 o'clock position.
 * A positive value indicates a counterclockwise rotation.
 *
 * The sector angle gives the number of degrees between start and end angle.
 * A positive value indicates a counterclockwise rotation.
 *
 * The pixels at the start and end angle are included in the sector.
 *
 * The color can be specified as SVG color or as RGB-color. 
 * For a complete list of SVG-colors, see SVG_colors.h.
 * For RGB-colors, use the macro RGB(R-value, G-value, B-value).
 *
 * @param canvas       Canvas pointer
 * @param x            x Location of centrepoint of corresponding circle
 * @param y            y Location of centrepoint of corresponding circle
 * @param r            Radius of corresponding circle
 * @param start_angle  Start angle of sector
 * @param sector_angle Angle of sector
 * @param color        Color as SVG-color or RGB-color.
 *
 * @return Nothing
 */

void graphics_fill_sector(canvas_t const * restrict canvas, int x, int y, unsigned int r, int start_angle, int sector_angle, color_t color )
{
    int start_part;
    int end_part;
    int start_delta = 0;
    int end_delta = 0;
    int sa;     // start angle (0-359 degrees)
    int ea;     // end angle (0-359 degrees)
    int da;     // delta angle
    int x1 = 0, y1 = 0; // start point of chord
    int x2 = 0, y2 = 0; // end point of chord

    if (sector_angle == 0)
    {
        return;     // nothing to draw
    }

    if ((sector_angle >= 360) || (sector_angle <= -360))
    {
        graphics_fill_segment(canvas, x, y, r,   0, 180, color);
        graphics_fill_segment(canvas, x, y, r, 180, 180, color);   // use segment to avoid extraction of the circle routine
        return;
    }

    /* calculate segment and triangle */
    if (sector_angle < 0)
    {
        sa = start_angle + sector_angle;
        ea = start_angle;
    }
    else
    {
        sa = start_angle;
        ea = start_angle + sector_angle;
    }
    sa %= 360;
    if (sa < 0)  sa += 360;

    ea %= 360;
    if (ea < 0)  ea += 360;

    da = ea - sa;
    if (da < 0)  da += 360;

    if (da >= 180)    // if more than 180 degrees, first draw half circle, then draw rest as sector
    {
        /* fill half circle */
        graphics_fill_segment(canvas, x, y, r, sa, 180, color);
        if (da == 180)
        {
            return; // done
        }

        if (sa < 180)
        {
            sa += 180;
        }
        else
        {
            sa -= 180;
        }
        da -= 180;
    }


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

    /* fill segment */
    graphics_fill_segment(canvas, x, y, r, sa, da, color);

    /* and fill triangle */
    graphics_fill_triangle(canvas, x + x1, y + y1, x + x2, y + y2, x, y, color);
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

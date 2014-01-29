/*****************************************************************************\
|*
|*  IN PACKAGE:     Graphics         
|*
|*  COPYRIGHT:      Copyright (c) 2008, Altium
|*
|*  DESCRIPTION:    Filled triangle routines
|*
 */

#include <stdint.h>
#include <stdbool.h>
#include <graphics.h>
#include <graphics_i.h>
#include "graphics_cfg.h"
#include "graphics_cfg_instance.h"

struct _boundary_s
{
    int    x;
    int    dx;
    int    dy;
    int    err;
    int8_t step;
    bool   steep;
    bool   extended_x;
};

static void _graphics_fill_triangle(canvas_t const * restrict canvas, int x1, int y1, int x2, int y2, int x3, int y3, color_t color);
static int _get_next_x(struct _boundary_s *b);
static void _init_struct(struct _boundary_s *b, int xa, int ya, int xb, int yb, bool left);

/*
 * FILL TRIANGLE
 */

/**
 * @brief    Draw triangle on canvas
 *
 * Draw an triangle on the canvas.
 *
 * The triangle is enclosed by the three different lines drawn from each of the three points to another of the three points.
 * The lines itself are included in the triangle.
 *
 * The color can be specified as SVG color or as RGB-color. 
 * For a complete list of SVG-colors, see SVG_colors.h.
 * For RGB-colors, use the macro RGB(R-value, G-value, B-value).
 *
 * @param canvas Canvas pointer
 * @param x1     x Location of first point
 * @param y1     y Location of first point
 * @param x2     x Location of second point
 * @param y2     y Location of second point
 * @param x3     x Location of third point
 * @param y3     y Location of third point
 * @param color  Color as SVG-color or RGB-color.
 *
 * @return Nothing
 */

void graphics_fill_triangle(canvas_t const * restrict canvas, int x1, int y1, int x2, int y2, int x3, int y3, color_t color)
{
    switch (canvas->rotation)
    {
#if (GRAPHICS_INSTANCE_ROTATION_0_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_0:
        _graphics_fill_triangle(canvas, X_0_DEGR(canvas, x1, y1), Y_0_DEGR(canvas, x1, y1),
                                        X_0_DEGR(canvas, x2, y2), Y_0_DEGR(canvas, x2, y2),
                                        X_0_DEGR(canvas, x3, y3), Y_0_DEGR(canvas, x3, y3), color);
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_90_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_90:
        _graphics_fill_triangle(canvas, X_90_DEGR(canvas, x1, y1), Y_90_DEGR(canvas, x1, y1),
                                        X_90_DEGR(canvas, x2, y2), Y_90_DEGR(canvas, x2, y2),
                                        X_90_DEGR(canvas, x3, y3), Y_90_DEGR(canvas, x3, y3), color);
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_180_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_180:
        _graphics_fill_triangle(canvas, X_180_DEGR(canvas, x1, y1), Y_180_DEGR(canvas, x1, y1),
                                        X_180_DEGR(canvas, x2, y2), Y_180_DEGR(canvas, x2, y2),
                                        X_180_DEGR(canvas, x3, y3), Y_180_DEGR(canvas, x3, y3), color);
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_270_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_270:
        _graphics_fill_triangle(canvas, X_270_DEGR(canvas, x1, y1), Y_270_DEGR(canvas, x1, y1),
                                        X_270_DEGR(canvas, x2, y2), Y_270_DEGR(canvas, x2, y2),
                                        X_270_DEGR(canvas, x3, y3), Y_270_DEGR(canvas, x3, y3), color);
        break;
#endif
    }
}


static void _graphics_fill_triangle(canvas_t const * restrict canvas, int x1, int y1, int x2, int y2, int x3, int y3, color_t color)
{
    struct _boundary_s boundary_12, boundary_13, boundary_23;
    int    x, y;
    int    xa, xb;     // both sides of triangle
    int    w = canvas->buffer_width;
    int    h = canvas->buffer_height;
    int    left   = canvas->pane_left;      // left, right, top, bottom of drawable area
    int    right  = canvas->pane_right;
    int    top    = canvas->pane_top;
    int    bottom = canvas->pane_bottom;

    color = canvas->convert_color_to_native(color);  // convert color to native format

    // sort vertices
    if (y1 > y2)
    {
        x = x1;
        x1 = x2;
        x2 = x;
        y = y1;
        y1 = y2;
        y2 = y;
    }

    if (y2 > y3)
    {
        x = x2;
        x2 = x3;
        x3 = x;
        y = y2;
        y2 = y3;
        y3 = y;
    }

    if (y1 > y2)
    {
        x = x1;
        x1 = x2;
        x2 = x;
        y = y1;
        y1 = y2;
        y2 = y;
    }

    xa = x1;
    xb = (y2 == y1) ? x2 : x1;

    if ((y1 == y2) && (y1 == y3))
    {
        // horizontal line
#if GRAPHICS_CHECK_COORDINATES == 1
        if ((y1 < top) || (y1 > bottom))
        {
            return;     // line is outside canvas
        }
#endif

        y = y1;
        if (x1 < x2)
        {
            xa = x1;
            xb = x2;
        }
        else
        {
            xa = x2;
            xb = x1;
        }
        if (x3 < xa)
        {
            xa = x3;
        }
        else if (x3 > xb)
        {
            xb = x3;
        }

#if GRAPHICS_CHECK_COORDINATES == 1
        if (xa < left)  xa = left;
        if (xb > right) xb = right;
#endif
        canvas->draw_horizontal(canvas, xa, xb, y, color);
        return;
    }

    // see if vertex 2 is at left or right side
    if ((((int)x2 - x1) * ((int)y3 - y1)) < (((int)x3 - x1) * ((int)y2 - y1)))  // (x12 * y13) < (x13 * y12) means at left side
    {
        // vertex 2 is at left side
        _init_struct(&boundary_12, x1, y1, x2, y2, true);
        _init_struct(&boundary_13, x1, y1, x3, y3, false);
        _init_struct(&boundary_23, x2, y2, x3, y3, true);

        for (y = y1; y < y2; y++)
        {
            xa = _get_next_x(&boundary_12);
            xb = _get_next_x(&boundary_13);
#if GRAPHICS_CHECK_COORDINATES == 1
            if ((y >= top) && (y <= bottom))
            {
                if (xa < left)  xa = left;
                if (xb > right) xb = right;
                canvas->draw_horizontal(canvas, xa, xb, y, color);
            }
#else
            canvas->draw_horizontal(canvas, xa, xb, y, color);
#endif
        }
        for ( ; y < y3; y++)
        {
            xa = _get_next_x(&boundary_23);
            xb = _get_next_x(&boundary_13);
#if GRAPHICS_CHECK_COORDINATES == 1
            if ((y >= top) && (y <= bottom))
            {
                if (xa < left)  xa = left;
                if (xb > right) xb = right;
                canvas->draw_horizontal(canvas, xa, xb, y, color);
            }
#else
            canvas->draw_horizontal(canvas, xa, xb, y, color);
#endif
        }
        xa = boundary_23.extended_x && !boundary_23.steep ? x3 : _get_next_x(&boundary_23);
        xb = boundary_13.extended_x && !boundary_13.steep ? x3 : _get_next_x(&boundary_13);
#if GRAPHICS_CHECK_COORDINATES == 1
        if ((y >= top) && (y <= bottom))
        {
            if (xa < left)  xa = left;
            if (xb > right) xb = right;
            canvas->draw_horizontal(canvas, xa, xb, y, color);
        }
#else
        canvas->draw_horizontal(canvas, xa, xb, y, color);
#endif
    }
    else
    {
        // vertex 2 is at right side
        _init_struct(&boundary_12, x1, y1, x2, y2, false);
        _init_struct(&boundary_13, x1, y1, x3, y3, true);
        _init_struct(&boundary_23, x2, y2, x3, y3, false);

        for (y = y1; y < y2; y++)
        {
            xa = _get_next_x(&boundary_13);
            xb = _get_next_x(&boundary_12);
#if GRAPHICS_CHECK_COORDINATES == 1
            if ((y >= top) && (y <= bottom))
            {
                if (xa < left)  xa = left;
                if (xb > right) xb = right;
                canvas->draw_horizontal(canvas, xa, xb, y, color);
            }
#else
            canvas->draw_horizontal(canvas, xa, xb, y, color);
#endif
        }
        for ( ; y < y3; y++)
        {
            xa = _get_next_x(&boundary_13);
            xb = _get_next_x(&boundary_23);
#if GRAPHICS_CHECK_COORDINATES == 1
            if ((y >= top) && (y <= bottom))
            {
                if (xa < left)  xa = left;
                if (xb > right) xb = right;
                canvas->draw_horizontal(canvas, xa, xb, y, color);
            }
#else
            canvas->draw_horizontal(canvas, xa, xb, y, color);
#endif
        }
        xa = boundary_13.extended_x && !boundary_13.steep ? x3 : _get_next_x(&boundary_13);
        xb = boundary_23.extended_x && !boundary_23.steep ? x3 : _get_next_x(&boundary_23);
#if GRAPHICS_CHECK_COORDINATES == 1
        if ((y >= top) && (y <= bottom))
        {
            if (xa < left)  xa = left;
            if (xb > right) xb = right;
            canvas->draw_horizontal(canvas, xa, xb, y, color);
        }
#else
        canvas->draw_horizontal(canvas, xa, xb, y, color);
#endif
    }
}


static int _get_next_x(struct _boundary_s *b)
{
    int result = 0;

    result = b->x;

    if (b->dy == 0)
    {
        if (b->extended_x)
        {
            if (b->step == 1)
            {
                result += b->dx;
            }
            else
            {
                result -= b->dx;
            }
        }
    }
    else if (b->steep)
    {
        if ( b->err >= 0 )
        {
            b->x += b->step;
            b->err -= 2 * b->dy;
        }
        b->err += 2 * b->dx;
    }
    else
    {
        while (1)
        {
            if ( b->err >= 0)
            {
                b->err -= 2 * b->dx;
                b->x += b->step;
                b->err += 2 * b->dy;
                break;
            }
            b->x += b->step;
            b->err += 2 * b->dy;
        }
        if (b->extended_x)
        {
            result = b->x - b->step;
        }
    }
    return result;
}


static void _init_struct(struct _boundary_s *b, int xa, int ya, int xb, int yb, bool left)
{
    b->x = xa;

    if (xb > xa)
    {
        b->step = 1;
        b->dx = xb - xa;
    }
    else
    {
        b->step = -1;
        b->dx = xa - xb;
    }

    b->dy = yb - ya;

    if (b->dx > b->dy)
    {
        b->steep = false;
        b->err = 2 * b->dy - b->dx;
    }
    else
    {
        b->steep = true;
        b->err = 2 * b->dx - b->dy;
    }
    b->extended_x = left != (b->step == 1);
}




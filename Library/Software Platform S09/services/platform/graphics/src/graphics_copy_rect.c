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
#include <string.h>
#include <graphics.h>
#include <graphics_i.h>
#include "graphics_cfg.h"
#include "graphics_cfg_instance.h"


static void _graphics_copy_rect(canvas_t const * restrict canvas, int x, int y, int width, int height, int shift_x, int shift_y);

/*
 * COPY RECT
 */

/**
 * @brief    Copy rectangle on canvas
 *
 * Copy the contents of a rectangle to another location on the canvas.
 *
 * The width and height should be positive to define the rectangle.
 * If one of these parameters is negative, nothing is moved.
 * Shift_x and shift_y define the displacement of the copied rectangle,
 * positive shift_x displaces to the right, positive shift_y displaces to the bottom.
 *
 * @param canvas  Canvas pointer
 * @param x       Left location of rectangle
 * @param y       Top location of rectangle
 * @param width   Width of the rectangle
 * @param height  Height of the rectangle
 * @param shift_x Displacement in x direction.
 * @param shift_y Displacement in y direction.
 *
 * @return Nothing
 */

void graphics_copy_rect(canvas_t const * restrict canvas, int x, int y, int width, int height, int shift_x, int shift_y)
{
    switch(canvas->rotation)
    {
#if (GRAPHICS_INSTANCE_ROTATION_0_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_0:
        _graphics_copy_rect(canvas, X_0_DEGR(canvas, x, y), Y_0_DEGR(canvas, x, y), width, height, shift_x, shift_y);
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_90_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_90:
        _graphics_copy_rect(canvas, X_0_DEGR(canvas, x, y) - height + 1, Y_0_DEGR(canvas, x, y),height, width, -shift_y, shift_x);
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_180_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_180:
        _graphics_copy_rect(canvas, X_0_DEGR(canvas, x, y) - width + 1, Y_0_DEGR(canvas, x, y) - height + 1, width, height, -shift_x, -shift_y);
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_270_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_270:
        _graphics_copy_rect(canvas, X_0_DEGR(canvas, x, y), Y_0_DEGR(canvas, x, y) - width + 1, height, width, shift_y, -shift_x);
        break;
#endif
    }
}


static void _graphics_copy_rect(canvas_t const * restrict canvas, int x, int y, int width, int height, int shift_x, int shift_y)
{
    uint8_t *source;
    uint8_t *dest;
    int size;
    int step;
    int left   = canvas->pane_left;      // left, right, top, bottom of drawable area
    int right  = canvas->pane_right;
    int top    = canvas->pane_top;
    int bottom = canvas->pane_bottom;
    int xs = x;
    int ys = y;
    int xd = x + shift_x;
    int yd = y + shift_y;

    if ((shift_x == 0) && (shift_y == 0))
    {
        return;
    }

    /* check corrdinates */
#if GRAPHICS_CHECK_COORDINATES == 1
    if (xs < xd)
    {
        if (xs < left)
        {
            width -= left - xs;
            xs = left;
            xd = xs + shift_x;
        }
        if ((xd + width - 1) > right)
        {
            width = right - xd + 1;
        }
    }
    else
    {
        if (xd < left)
        {
            width -= left - xd;
            xd = left;
            xs = xd - shift_x;
        }
        if ((xs + width - 1) > right)
        {
            width = right - xs + 1;
        }
    }

    if (ys < yd)
    {
        if (ys < top)
        {
            height -= top - ys;
            ys = top;
            yd = ys + shift_y;
        }
        if ((yd + height - 1) > bottom)
        {
            height = bottom - yd + 1;
        }
    }
    else
    {
        if (yd < top)
        {
            height -= top - yd;
            yd = top;
            ys = yd - shift_y;
        }
        if ((ys + height - 1) > bottom)
        {
            height = bottom - ys + 1;
        }
    }

#endif

    switch (canvas->color_format)
    {
    case COLOR_RGB565:
        source = (uint8_t*)canvas->buffer + 2 * (ys * canvas->buffer_width + xs);
        dest =   (uint8_t*)canvas->buffer + 2 * (yd * canvas->buffer_width + xd);
        size = width * 2;
        step = canvas->buffer_width * 2;
        break;
    case COLOR_PALETTE8:
        source = (uint8_t*)canvas->buffer + ys * canvas->buffer_width + xs;
        dest =   (uint8_t*)canvas->buffer + yd * canvas->buffer_width + xd;
        size = width;
        step = canvas->buffer_width;
        break;
    default:
        return;
    }

    if (dest > source)
    {
        dest += step * (height - 1);
        source += step * (height - 1);

        for (int i = 0; i < height; i++)
        {
            memmove(dest, source, size);
            dest -= step;
            source -= step;
        }
    }
    else
    {
        for (int i = 0; i < height; i++)
        {
            memmove(dest, source, size);
            dest += step;
            source += step;
        }
    }
}



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


/**
 * @brief    Draw one pixel on canvas
 *
 * Set the color of one pixel on the canvas.
 * The color can be specified as SVG color or as RGB-color.
 * For a complete list of SVG-colors, see SVG_colors.h.
 * For RGB-colors, use the macro RGB(R-value, G-value, B-value).
 *
 * @param canvas Canvas pointer
 * @param x      x Location on canvas
 * @param y      y Location on canvas
 * @param color  Color as SVG-color or RGB-color.
 *
 * @return Nothing
 */

void graphics_draw_pixel(canvas_t const * restrict canvas, int x, int y, color_t color)
{
    int xx = 0;
    int yy = 0;

    switch (canvas->rotation)
    {
#if (GRAPHICS_INSTANCE_ROTATION_0_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_0:
        xx = X_0_DEGR(canvas, x, y);
        yy = Y_0_DEGR(canvas, x, y);
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_90_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_90:
        xx = X_90_DEGR(canvas, x, y);
        yy = Y_90_DEGR(canvas, x, y);
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_180_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_180:
        xx = X_180_DEGR(canvas, x, y);
        yy = Y_180_DEGR(canvas, x, y);
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_270_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_270:
        xx = X_270_DEGR(canvas, x, y);
        yy = Y_270_DEGR(canvas, x, y);
        break;
#endif
    }

#if GRAPHICS_CHECK_COORDINATES == 1
    if ((xx >= canvas->pane_left) && (xx <= canvas->pane_right) && (yy >= canvas->pane_top) && (yy <= canvas->pane_bottom))
#endif
    {
        color = canvas->convert_color_to_native(color);  // convert color to native format
        canvas->draw_pixel(canvas, xx, yy, color);
    }
}



/**
 * @brief    Draw one pixel with given opacity on canvas
 *
 * Set the color of one pixel on the canvas.
 * The color can be specified as SVG color or as RGB-color.
 * For a complete list of SVG-colors, see SVG_colors.h.
 * For RGB-colors, use the macro RGB(R-value, G-value, B-value).
 * The opacity of the color is set by the 4 most significant bits of alpha and can change in steps of 12.5%:
 *
 * ||alpha (msb's)  ||  opacity  ||
 * |     0000       |       0%    |
 * |     0001       |    12.5%    |
 * |     0010       |    12.5%    |
 * |     0011       |      25%    |
 * |     0100       |      25%    |
 * |     0101       |    37.5%    |
 * |     0110       |    37.5%    |
 * |     0111       |      50%    |
 * |     1000       |      50%    |
 * |     1001       |    62.5%    |
 * |     1010       |    62.5%    |
 * |     1011       |      75%    |
 * |     1100       |      75%    |
 * |     1101       |    87.5%    |
 * |     1110       |    87.5%    |
 * |     1111       |     100%    |
 *
 * @param canvas Canvas pointer
 * @param  x      x Location on canvas
 * @param  y      y Location on canvas
 * @param  color  Color as SVG-color or RGB-color.
 * @param  alpha  Opacity
 *
 * @return Nothing
 */

void graphics_draw_pixel_alpha(canvas_t const * restrict canvas, int x, int y, color_t color, uint8_t alpha)
{
    int xx = 0;
    int yy = 0;

    switch (canvas->rotation)
    {
#if (GRAPHICS_INSTANCE_ROTATION_0_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_0:
        xx = X_0_DEGR(canvas, x, y);
        yy = Y_0_DEGR(canvas, x, y);
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_90_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_90:
        xx = X_90_DEGR(canvas, x, y);
        yy = Y_90_DEGR(canvas, x, y);
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_180_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_180:
        xx = X_180_DEGR(canvas, x, y);
        yy = Y_180_DEGR(canvas, x, y);
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_270_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_270:
        xx = X_270_DEGR(canvas, x, y);
        yy = Y_270_DEGR(canvas, x, y);
        break;
#endif
    }

#if GRAPHICS_CHECK_COORDINATES == 1
    if ((xx >= canvas->pane_left) && (xx <= canvas->pane_right) && (yy >= canvas->pane_top) && (yy <= canvas->pane_bottom))
#endif
    {
        canvas->draw_pixel_alpha(canvas, xx, yy, canvas->convert_color_to_native(color), alpha);   // write color in native format
    }
}


/**
 * @brief    Get color of one pixel on canvas
 *
 * Get the color of one pixel on the canvas. The returned color-format is accepted by other graphics routines.
 *
 * @param  canvas Canvas pointer
 * @param  x      x Location on canvas
 * @param  y      y Location on canvas
 *
 * @return Color of pixel at the given location
 */

color_t graphics_get_pixel(canvas_t const * restrict canvas, int x, int y)
{
    color_t color;

    switch (canvas->rotation)
    {
#if (GRAPHICS_INSTANCE_ROTATION_0_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_0:
        color = canvas->get_pixel(canvas, x, y);
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_90_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_90:
        color = canvas->get_pixel(canvas, canvas->buffer_width - 1 - y, x);
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_180_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_180:
        color = canvas->get_pixel(canvas, canvas->buffer_width - 1 - x, canvas->buffer_height - 1 - y);
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_270_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_270:
        color = canvas->get_pixel(canvas, y, canvas->buffer_height - 1 - x);
        break;
#endif
    default:
        color = 0;
        break;
    }
    return canvas->convert_color_from_native(color);
}


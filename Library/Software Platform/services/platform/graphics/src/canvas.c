/*****************************************************************************\
|*
|*  IN PACKAGE:     Graphics
|*
|*  COPYRIGHT:      Copyright (c) 2008, Altium
|*
|*  DESCRIPTION:    Canvas routines
|*
 */

#include <stdint.h>
#include <stdbool.h>
#include <canvas.h>
#include <canvas_i.h>
#include <string.h>
#include <assert.h>
#include "graphics_cfg.h"


/*****************************
 * static PIXEL routines
 *****************************/

/*****************************
 * Common for 1 to 8 bpp
 *****************************/

/*
 * One-entry cache, used to store the last converted color.
 * As the palettes for canvases with same colordepth are the same, the cache is global for all canvases with the same colordepth.
 */

typedef struct
{
    color_t color;
    color_t palette_color;
} color_cache_t;

enum
{   alloc_none = 0, // nothing is allocated on heap
    alloc_canvas,   // canvas structure is allocated on heap
    alloc_both      // both canvas structure and buffer are allocated on heap
};

static color_cache_t color_cache_p1;
static color_cache_t color_cache_p2;
static color_cache_t color_cache_p4;
static color_cache_t color_cache_p8;


static color_t _graphics_convert_color_to_palette(color_t color, color_format_t color_format, color_cache_t *color_cache)
{
    int distance;
    int imax;
    unsigned int min_distance = -1;
    color_t best_match = 0;
    color_t color1, color2;

    if (color == color_cache->color)         // color is the same as previous?
    {
        return color_cache->palette_color;   // get from cache
    }

    switch (color_format)
    {
    case COLOR_PALETTE1:
        imax = 2;
        break;
    case COLOR_PALETTE2:
        imax = 4;
        break;
    case COLOR_PALETTE4:
        imax = 16;
        break;
    default:
        imax = sizeof(svg_colors) / sizeof(svg_colors[0]);
        break;
    }
    for (int i = 0; i < imax; i++)
    {
        /*
           To find the best matching color, determine distance to each palette entry and
           use the entry with the smallest distance.
           The distance is defined by:
           distance = sqrt( (delta red)^2 + (delta green)^2 + (delta blue)^2 ).
           We are not interrested in the absolute distance, therefore we skip the sqrt function:
           distance' = (delta red)^2 + (delta green)^2 + (delta blue)^2
        */
        color1 = color;
        color2 = svg_colors[i];
        distance = ((color1 & 0xFF) - (color2 & 0xFF)) * ((color1 & 0xFF) - (color2 &0xFF));    // (delta blue)^2
        color1 >>= 8;
        color2 >>= 8;
        distance += ((color1 & 0xFF) - (color2 &0xFF)) * ((color1 & 0xFF) - (color2 &0xFF));    // (delta green)^2
        color1 >>= 8;
        color2 >>= 8;
        distance += ((color1 & 0xFF) - (color2 &0xFF)) * ((color1 & 0xFF) - (color2 &0xFF));    // (delta red)^2

        if (distance < min_distance)
        {
            min_distance = distance;
            best_match = (color_t)i;
            if (min_distance < 1)
            {
                break;  // exact color, stop searching
            }
        }
    }

    // update cache
    color_cache->color = color;
    color_cache->palette_color = best_match;

    return best_match;
}


/*****************************
 * 1 bpp
 *****************************/

static color_t _graphics_convert_color_to_p1(color_t color)
{
    if (!(color & 0xFE000000))     // color contains palette index in 2 bit range?
    {
        return color >> 24;     // return palette index
    }

    return _graphics_convert_color_to_palette(color, COLOR_PALETTE1, &color_cache_p1);
}


static color_t _graphics_convert_color_from_p1(color_t color)
{
    return svg_colors[color & 0x01];
}


static void _graphics_draw_pixel_p1(canvas_t const * restrict canvas, int x, int y, color_t color)
{
    uint8_t *p = (uint8_t*)canvas->buffer + (y * canvas->buffer_width + x) / 8;

    if (color & 1)
    {
        *p |= 1 << (7 - (x % 8));
    }
    else
    {
        *p &= ~(1 << (7 - (x % 8)));
    }
}


static void _graphics_draw_pixel_alpha_p1(canvas_t const * restrict canvas, int x, int y, color_t color, uint8_t alpha)
{
    if (alpha > 127)
    {
        _graphics_draw_pixel_p1(canvas, x, y, color);
    }
}


static color_t _graphics_get_pixel_p1(canvas_t const * restrict canvas, int x, int y)
{
    int offset = x + y * canvas->buffer_width;

    return (*(((uint8_t*)canvas->buffer) + (offset / 8))) & (0x01 << (offset % 8)) ? 1 : 0;
}


static void _graphics_draw_horizontal_p1(canvas_t const * restrict canvas, int left, int right, int y, color_t color)
{
    uint32_t fill_color;
    uint8_t *p = (uint8_t*)canvas->buffer + (y * canvas->buffer_width) / 8;

    while ((left % 32) && (left <= right))
    {
        _graphics_draw_pixel_p1(canvas, left, y, color);
        left++;
    }
    while (((right + 1) % 32) && (left <= right))
    {
        _graphics_draw_pixel_p1(canvas, right, y, color);
        right--;
    }
    fill_color = color ? 0xFFFFFFFF : 0;
    for (int i = left/8; i < right/8; i += 4)
    {
        *((uint32_t*)(p + i)) = fill_color;   // fill per 32-bit
    }
}


static void _graphics_draw_vertical_p1(canvas_t const * restrict canvas, int x, int top, int bottom, color_t color)
{
    uint8_t *p = (uint8_t*)canvas->buffer + (top * canvas->buffer_width + x) / 8;
    uint8_t and_mask =  ~(1 << (7 - (x % 8)));
    uint8_t or_mask = 1 << (7 - (x % 8));

    if (color & 1)
    {
        for (int i = top; i <= bottom; i++)
        {
            *p |= or_mask;
            p += canvas->buffer_width / 8;
        }
    }
    else
    {
        for (int i = top; i <= bottom; i++)
        {
            *p &= and_mask;
            p += canvas->buffer_width / 8;
        }
    }
}


/*****************************
 * 2 bpp
 *****************************/

static color_t _graphics_convert_color_to_p2(color_t color)
{
    if (!(color & 0xFC000000))     // color contains palette index in 2 bit range?
    {
        return color >> 24;     // return palette index
    }

    return _graphics_convert_color_to_palette(color, COLOR_PALETTE2, &color_cache_p2);
}


static color_t _graphics_convert_color_from_p2(color_t color)
{
    return svg_colors[color & 0x03];
}


static void _graphics_draw_pixel_p2(canvas_t const * restrict canvas, int x, int y, color_t color)
{
    uint8_t pixels;
    uint8_t *p = (uint8_t*)canvas->buffer + (y * canvas->buffer_width + x) / 4;

    pixels = *p;
    pixels &= ~(0x03 << (6 - (x % 4) * 2));
    pixels |= (color & 0x03) << (6 - (x % 4) * 2);
    *p = pixels;
}


static void _graphics_draw_pixel_alpha_p2(canvas_t const * restrict canvas, int x, int y, color_t color, uint8_t alpha)
{
    if (alpha > 127)
    {
        _graphics_draw_pixel_p2(canvas, x, y, color);
    }
}


static color_t _graphics_get_pixel_p2(canvas_t const * restrict canvas, int x, int y)
{
    int offset = x + y * canvas->buffer_width;

    return ((*(((uint8_t*)canvas->buffer) + (offset / 4))) & (0x03 << (offset % 4))) >> (offset % 4);
}


static void _graphics_draw_horizontal_p2(canvas_t const * restrict canvas, int left, int right, int y, color_t color)
{
    uint32_t fill_color;
    uint8_t *p = (uint8_t*)canvas->buffer + (y * canvas->buffer_width) / 4;

    color &= 0x03;

    while ((left % 16) && (left <= right))
    {
        _graphics_draw_pixel_p2(canvas, left, y, color);
        left++;
    }
    while (((right + 1) % 16) && (left <= right))
    {
        _graphics_draw_pixel_p2(canvas, right, y, color);
        right--;
    }
    fill_color = color << 6 | color << 4 | color << 2 | color;
    fill_color = fill_color << 24 | fill_color << 16 | fill_color << 8 | fill_color;
    for (int i = left/4; i < right/4; i += 4)
    {
        *((uint32_t*)(p + i)) = fill_color;   // fill per 32-bit
    }
}


static void _graphics_draw_vertical_p2(canvas_t const * restrict canvas, int x, int top, int bottom, color_t color)
{
    uint8_t pixels;
    uint8_t and_mask = ~(0x03 << (6 - (x % 4) * 2));
    uint8_t or_mask = (color & 0x03) << (6 - (x % 4) * 2);
    uint8_t *p = (uint8_t*)canvas->buffer + (top * canvas->buffer_width + x) / 4;

    for (int i = top; i <= bottom; i++)
    {
        pixels = *p;
        pixels &= and_mask;
        pixels |= or_mask;
        *p = pixels;
        p += 4 * ((canvas->buffer_width + 15) / 16);
    }
}


/*****************************
 * 4 bpp
 *****************************/

static color_t _graphics_convert_color_to_p4(color_t color)
{
    if (!(color & 0xF0000000))     // color contains palette index in 4 bit range?
    {
        return color >> 24;     // return palette index
    }

    return _graphics_convert_color_to_palette(color, COLOR_PALETTE4, &color_cache_p4);
}


static color_t _graphics_convert_color_from_p4(color_t color)
{
    return svg_colors[color & 0x0F];
}


static void _graphics_draw_pixel_p4(canvas_t const * restrict canvas, int x, int y, color_t color)
{
    uint8_t pixels;
    uint8_t *p = (uint8_t*)canvas->buffer + (y * canvas->buffer_width + x) / 2;

    pixels = *p;
    pixels &= ~(0x0F << (4 - (x % 2) * 4));
    pixels |= (color & 0x0F) << (4 - (x % 2) * 4);
    *p = pixels;
}


static void _graphics_draw_pixel_alpha_p4(canvas_t const * restrict canvas, int x, int y, color_t color, uint8_t alpha)
{
    if (alpha > 127)
    {
        _graphics_draw_pixel_p4(canvas, x, y, color);
    }
}


static color_t _graphics_get_pixel_p4(canvas_t const * restrict canvas, int x, int y)
{
    int offset = x + y * canvas->buffer_width;

    return ((*(((uint8_t*)canvas->buffer) + (offset / 2))) & (0x07 << (offset % 2))) >> (offset % 2);
}


static void _graphics_draw_horizontal_p4(canvas_t const * restrict canvas, int left, int right, int y, color_t color)
{
    uint32_t fill_color;
    uint8_t *p = (uint8_t*)canvas->buffer + (y * canvas->buffer_width / 2);

    color &= 0x0F;

    while ((left % 8) && (left <= right))
    {
        _graphics_draw_pixel_p4(canvas, left, y, color);
        left++;
    }
    while (((right + 1) % 8) && (left <= right))
    {
        _graphics_draw_pixel_p4(canvas, right, y, color);
        right--;
    }
    fill_color = color << 4 | color;
    fill_color = fill_color << 24 | fill_color << 16 | fill_color << 8 | fill_color;
    for (int i = left/2; i < right/2; i += 4)
    {
        *((uint32_t*)(p + i)) = fill_color;   // fill per 32-bit
    }
}


static void _graphics_draw_vertical_p4(canvas_t const * restrict canvas, int x, int top, int bottom, color_t color)
{
    uint8_t pixels;
    uint8_t and_mask = ~(0x0F << (4 - (x % 2) * 4));
    uint8_t or_mask = (color & 0x0F) << (4 - (x % 2) * 4);
    uint8_t *p = (uint8_t*)canvas->buffer + (top * canvas->buffer_width + x) / 2;

    for (int i = top; i <= bottom; i++)
    {
        pixels = *p;
        pixels &= ~(0x0F << (4 - (x % 2) * 4));
        pixels |= (color & 0x0F) << (4 - (x % 2) * 4);
        *p = pixels;
        p += canvas->buffer_width / 2;
    }
}


/*****************************
 * 8 bpp
 *****************************/

static color_t _graphics_convert_color_to_p8(color_t color)
{
    if (color < 0xFF000000)     // color contains palette index in 8 bit range?
    {
        return color >> 24;     // return palette index
    }

    return _graphics_convert_color_to_palette(color, COLOR_PALETTE8, &color_cache_p8);
}


static color_t _graphics_convert_color_from_p8(color_t color)
{
    return svg_colors[color &0xFF];
}


static void _graphics_draw_pixel_p8(canvas_t const * restrict canvas, int x, int y, color_t color)
{
    uint8_t *p = (uint8_t*)canvas->buffer + y * canvas->buffer_width + x;

    *p = (uint8_t)color;
}


static void _graphics_draw_pixel_alpha_p8(canvas_t const * restrict canvas, int x, int y, color_t color, uint8_t alpha)
{
    uint8_t *p;

    if (alpha > 127)
    {
        p = (uint8_t*)canvas->buffer + y * canvas->buffer_width + x;
        *p = (uint8_t)color;
    }
}


static color_t _graphics_get_pixel_p8(canvas_t const * restrict canvas, int x, int y)
{
    int offset = x + y * canvas->buffer_width;

    return *(((uint8_t*)canvas->buffer) + offset);
}


static void _graphics_draw_horizontal_p8(canvas_t const * restrict canvas, int left, int right, int y, color_t color)
{
    uint8_t *p;
    uint32_t fill_color;
    p = (uint8_t*)canvas->buffer + y * canvas->buffer_width;

    color &= 0xFF;

    while ((left % 4) && (left <= right))
    {
        *(p + left) = (uint8_t)color;
        left++;
    }
    while (((right + 1) % 4) && (left <= right))
    {
        *(p + right) = (uint8_t)color;
        right--;
    }

    fill_color = color << 24 | color << 16 | color << 8 | color;
    for (int i = left; i < right; i += 4)
    {
        *((uint32_t*)(p + i)) =  fill_color;   // fill per 32-bit
    }
}


static void _graphics_draw_vertical_p8(canvas_t const * restrict canvas, int x, int top, int bottom, color_t color)
{
    uint8_t *p = (uint8_t*)canvas->buffer + top * canvas->buffer_width + x;

    for (int i = top; i <= bottom; i++)
    {
        *p = (uint8_t)color;
        p += canvas->buffer_width;
    }
}


/*****************************
 * 16 bpp
 *****************************/

#define MASK_RGB565_HALF    0x7BEF7BEF /*01111 011111 01111 -> 0111 1011 1110 1111*/
#define MASK_RGB565_QUARTER 0x39E739E7 /*00111 001111 00111 -> 0011 1001 1110 0111*/
#define MASK_RGB565_OCTAVA  0x18E318E3 /*00011 000111 00011 -> 0001 1000 1110 0011*/

#define MASK_RGB565_LASTBIT 0x08210821 /*00001 000001 00001 -> 0000 1000 0010 0001*/

static color_t alpha_125_rgb565(color_t color1, color_t color2)
{
    color_t c1  =  color1;
    color_t c1o = (color1 >> 3) & MASK_RGB565_OCTAVA;
    color_t c2o = (color2 >> 3) & MASK_RGB565_OCTAVA;
    return (c1 - c1o + c2o) | MASK_RGB565_LASTBIT;
}

static color_t alpha_250_rgb565(color_t color1, color_t color2)
{
    color_t c1  =  color1;
    color_t c1q = (color1 >> 2) & MASK_RGB565_QUARTER;
    color_t c2q = (color2 >> 2) & MASK_RGB565_QUARTER;
    return (c1 - c1q + c2q) | MASK_RGB565_LASTBIT;
}

static color_t alpha_375_rgb565(color_t color1, color_t color2)
{
    color_t c1h = (color1 >> 1) & MASK_RGB565_HALF;
    color_t c1o = (color1 >> 3) & MASK_RGB565_OCTAVA;
    color_t c2h = (color2 >> 1) & MASK_RGB565_HALF;
    color_t c2o = (color2 >> 3) & MASK_RGB565_OCTAVA;
    return (c2h - c2o + c1h + c1o) | MASK_RGB565_LASTBIT;
}

static color_t alpha_500_rgb565(color_t color1, color_t color2)
{
    color_t c1h = (color1 >> 1) & MASK_RGB565_HALF;
    color_t c2h = (color2 >> 1) & MASK_RGB565_HALF;
    return (c1h + c2h) | MASK_RGB565_LASTBIT;
}

static color_t alpha_625_rgb565(color_t color1, color_t color2)
{
    color_t c2o = (color2 >> 3) & MASK_RGB565_OCTAVA;
    color_t c2h = (color2 >> 1) & MASK_RGB565_HALF;
    color_t c1o = (color1 >> 3) & MASK_RGB565_OCTAVA;
    color_t c1h = (color1 >> 1) & MASK_RGB565_HALF;
    return (c1h - c1o + c2h + c2o) | MASK_RGB565_LASTBIT;
}

static color_t alpha_750_rgb565(color_t color1, color_t color2)
{
    color_t c2 =   color2;
    color_t c2q = (color2 >> 2) & MASK_RGB565_QUARTER;
    color_t c1q = (color1 >> 2) & MASK_RGB565_QUARTER;
    return (c2 - c2q + c1q) | MASK_RGB565_LASTBIT;
}


static color_t alpha_875_rgb565(color_t color1, color_t color2)
{
    color_t c2  =  color2;
    color_t c2o = (color2 >> 3) & MASK_RGB565_OCTAVA;
    color_t c1o = (color1 >> 3) & MASK_RGB565_OCTAVA;
    return (c2 - c2o + c1o) | MASK_RGB565_LASTBIT;
}


static color_t alpha_composing_rgb565(color_t color1, color_t color2, uint8_t alpha)
{
    switch (alpha >> 4)
    {
    case  0:
        return color1;
    case  1:
    case  2:
        return alpha_125_rgb565(color1, color2);
    case  3:
    case  4:
        return alpha_250_rgb565(color1, color2);
    case  5:
    case  6:
        return alpha_375_rgb565(color1, color2);
    case  7:
    case  8:
        return alpha_500_rgb565(color1, color2);
    case  9:
    case 10:
        return alpha_625_rgb565(color1, color2);
    case 11:
    case 12:
        return alpha_750_rgb565(color1, color2);
    case 13:
    case 14:
        return alpha_875_rgb565(color1, color2);
    default:
        return color2;
    }
}


static color_t _graphics_convert_color_to_rgb565(color_t color)
{
    return ((color & 0xF8) >> 3) + ((color & 0xFC00) >> 5) + ((color & 0xF80000) >> 8);
}


static color_t _graphics_convert_color_from_rgb565(color_t color)
{
    return 0xFF000000 + ((color & 0x001F) << 3) + ((color & 0x07E0) << 5) + ((color & 0xF800) << 8);
}


static void _graphics_draw_pixel_rgb565(canvas_t const * restrict canvas, int x, int y, color_t color)
{
    *(((uint16_t*)canvas->buffer) + x + y * canvas->buffer_width) = (uint16_t)color;
}


void _graphics_draw_pixel_alpha_rgb565(canvas_t const * restrict canvas, int x, int y, color_t color, uint8_t alpha)
{
    if (alpha == 0) return; // nothing to draw

    uint16_t *p = ((uint16_t*)canvas->buffer) + x + y * canvas->buffer_width;

    if (alpha >= 0xF0)
    {
        *p = (uint16_t)color;
    }
    else
    {
        *p = (uint16_t)alpha_composing_rgb565(*p, color, alpha);
    }
}


color_t _graphics_get_pixel_rgb565(canvas_t const * restrict canvas, int x, int y)
{
    return (color_t)(*((uint16_t*)canvas->buffer + y * canvas->buffer_width + x));
}


void _graphics_draw_horizontal_rgb565(canvas_t const * restrict canvas, int left, int right, int y, color_t color)
{
    uint16_t *p = (uint16_t*)canvas->buffer + y * canvas->buffer_width;

    if ((left % 2) && (left <= right))
    {
        *(p + left) = (uint16_t)color;
        left++;
    }
    if (!(right % 2) && (left <= right))
    {
        *(p + right) = (uint16_t)color;
        right--;
    }
    for (int i = left; i <= right; i += 2)
    {
        *((uint32_t*)(p + i)) = (uint16_t)color | color << 16;   // fill per 32-bit
    }
}


void _graphics_draw_vertical_rgb565(canvas_t const * restrict canvas, int x, int top, int bottom, color_t color)
{
    uint16_t *p = (uint16_t*)canvas->buffer + x;

    for (int i = top; i <= bottom; i++)
    {
        *(p + i * canvas->buffer_width) = (uint16_t)color;
    }
}


void _graphics_fill_canvas_rgb565(canvas_t const * restrict canvas, color_t color)
{
    uint32_t *p   = (uint32_t*)canvas->buffer;

    for (int i = 0; i < canvas->canvas_width * canvas->canvas_height / 2; i++)
    {
        p[i] = color << 16 | (uint16_t)color;   // set 2 pixels at a time
    }
}


/*****************************
 * Canvas routines
 *****************************/

static bool _canvas_is_compatible(const canvas_t *canvas1, const canvas_t *canvas2)
{
    if (canvas1->color_format != canvas2->color_format)
    {
        return false;
    }

    if (canvas1->rotation != canvas2->rotation)
    {
        return false;
    }

    return true;
}


int _canvas_unset_rotation(canvas_t * restrict canvas)
{
    int left_norm = 0;
    int top_norm = 0;
    int width_norm = 0;
    int height_norm = 0;
    int rotation;

    switch (canvas->rotation)
    {
    case CANVAS_ROTATION_0:
        left_norm   = canvas->canvas_left;
        top_norm    = canvas->canvas_top;
        width_norm  = canvas->canvas_width;
        height_norm = canvas->canvas_height;
        break;
    case CANVAS_ROTATION_90:
        left_norm   = canvas->canvas_top - canvas->canvas_height + 1;
        top_norm    = canvas->canvas_left;
        width_norm  = canvas->canvas_height;
        height_norm = canvas->canvas_width;
        break;
    case CANVAS_ROTATION_180:
        left_norm   = canvas->canvas_left - canvas->canvas_width + 1;
        top_norm    = canvas->canvas_top - canvas->canvas_height + 1;
        width_norm  = canvas->canvas_width;
        height_norm = canvas->canvas_height;
        break;
    case CANVAS_ROTATION_270:
        left_norm   = canvas->canvas_top;
        top_norm    = canvas->canvas_left - canvas->canvas_width + 1;
        width_norm  = canvas->canvas_height;
        height_norm = canvas->canvas_width;
        break;
    default:
        break;
    }

    canvas->canvas_left   = left_norm;
    canvas->canvas_top    = top_norm;
    canvas->canvas_width  = width_norm;
    canvas->canvas_height = height_norm;
    rotation = canvas->rotation;
    canvas->rotation = 0;

    return rotation;
}

/*
 * Static function _canvas_set_rotation()
 * See below for description
 */

static int _canvas_set_rotation(canvas_t * restrict canvas, int rotation)
{
    int left_norm = 0;
    int top_norm = 0;
    int width_norm = 0;
    int height_norm = 0;
    int r = (rotation / 90 ) % 4;
    if (r < 0) r += 4;

//    if (r != canvas->rotation / 90) // calcultate new canvas position
    {
        _canvas_unset_rotation(canvas);

        left_norm = canvas->canvas_left;
        top_norm = canvas->canvas_top;
        width_norm = canvas->canvas_width;
        height_norm = canvas->canvas_height;

        switch (r)
        {
        case 0:
            canvas->canvas_left   = left_norm;
            canvas->canvas_top    = top_norm;
            canvas->canvas_width  = width_norm;
            canvas->canvas_height = height_norm;
            canvas->rotation = CANVAS_ROTATION_0;
            break;
        case 1:
            canvas->canvas_left   = top_norm;
            canvas->canvas_top    = left_norm + width_norm - 1;
            canvas->canvas_width  = height_norm;
            canvas->canvas_height = width_norm;
            canvas->rotation = CANVAS_ROTATION_90;
            break;
        case 2:
            canvas->canvas_left   = left_norm + width_norm - 1;
            canvas->canvas_top    = top_norm + height_norm - 1;
            canvas->canvas_width  = width_norm;
            canvas->canvas_height = height_norm;
            canvas->rotation = CANVAS_ROTATION_180;
            break;
        case 3:
            canvas->canvas_left   = top_norm + height_norm - 1;
            canvas->canvas_top    = left_norm;
            canvas->canvas_width  = height_norm;
            canvas->canvas_height = width_norm;
            canvas->rotation = CANVAS_ROTATION_270;
            break;
        default:
            break;
        }
    }

    canvas->pane_left   = left_norm;
    canvas->pane_top    = top_norm;
    canvas->pane_right  = left_norm + width_norm - 1;
    canvas->pane_bottom = top_norm + height_norm - 1;

    return canvas->rotation;
}


/**
 * @brief    Set canvas rotation
 *
 * Set the canvas rotation
 * This function is similar to graphics_set_rotation(), although this function sets the rotation of only the provided canvas.
 *
 * @see graphics_set_rotation(), canvas_get_rotation()
 *
 * @param  canvas       Canvas pointer
 * @param  rotation       New rotation in degrees
 *
 * @return Pointer to copied canvas
 */

int canvas_set_rotation(canvas_t * restrict canvas, int rotation)
{
    return _canvas_set_rotation(canvas, rotation);
}


/**
 * @brief    Get rotation
 *
 * Get the current rotation of the canvas. The rotation is returned in degrees and can only be one of the following values: 0, 90, 180, 270.
 *
 * @param  canvas       Canvas pointer
 *
 * @return Current rotation in degrees
 *
 * @see graphics_set_rotation()
 */

int canvas_get_rotation(canvas_t const * restrict canvas)
{
    return canvas->rotation;
}


/**
 * @brief    Get width
 *
 * Get the width of the canvas.
 *
 * @param  canvas       Canvas pointer
 *
 * @return Width
 */

int canvas_get_width(canvas_t const * restrict canvas)
{
    return canvas->canvas_width;
}


/**
 * @brief    Get height
 *
 * Get the height of the canvas.
 *
 * @param  canvas       Canvas pointer
 *
 * @return Height
 */

int canvas_get_height(canvas_t const * restrict canvas)
{
    return canvas->canvas_height;
}


/**
 * @brief   Set default font
 *
 * Set the default font for given canvas. The default font is used if, in text related functions, the font parameter is given a NULL pointer.
 *
 * @param  canvas         Canvas pointer
 * @param  default_font   Pointer to new default font
 *
 * @return Nothing
 *
 * @see graphics_set_default_font(), graphics_draw_char(), graphics_draw_string(), graphics_draw_nstring(), graphics_get_stringwidth(), graphics_get_nstringwidth(), graphics_get_charwidth(), graphics_get_fontheight()
 */

void canvas_set_default_font(canvas_t * restrict canvas, font_t const * default_font)
{
    canvas->default_font = default_font;
}


/**
 * @brief    Get canvas color format
 *
 * Get the color format of the canvas.
 *
 * @param  canvas       Pointer to canvas
 *
 * @return Color format
 */

color_format_t canvas_get_color_format(canvas_t const * restrict canvas)
{
    return canvas->color_format;
}


/**
 * @brief    Get pixel size
 *
 * Get the size of the pixel in bits
 *
 * @param  canvas       Pointer to canvas
 *
 * @return Bits per pixel
 */

int canvas_get_bpp(canvas_t const * restrict canvas)
{
    switch (canvas->color_format)
    {
    case COLOR_PALETTE1:
        return 1;
    case COLOR_PALETTE2:
        return 2;
    case COLOR_PALETTE4:
        return 4;
    case COLOR_PALETTE8:
        return 8;
    case COLOR_RGB565:
        return 16;
    default:
        return 0;
    }
}


/**
 * @brief    Initialize canvas
 *
 * Initialize the canvas. It is the responsability of the caller to provide a buffer that is large enough to hold the canvas data.
 * In general the needed size is: (width * bpp / 8) * height
 *
 * The width and height parameters are the dimensions of the rotated canvas.
 * Therefore, initializing the canvas with a rotation 'r' is not the same as
 * intializing the canvas with a rotation '0' and afterwards calling canvas_set_rotation() with a rotation 'r'.
 *
 * @param  canvas       Canvas pointer
 * @param  buffer       Buffer address
 * @param  color_format Color format
 * @param  width        Width
 * @param  height       Height
 * @param  rotation     Rotation
 * @param  default_font Default Font pointer
 *
 * @return true on success, false otherwise
 *
 * @see canvas_create()
 */

bool canvas_initialize(canvas_t * canvas, uintptr_t buffer, color_format_t color_format, int width, int height, int rotation, font_t const *default_font)
{
    canvas->buffer = buffer;
    canvas->default_font = default_font;
    int r = (rotation / 90 ) % 2;
    if (r < 0) r += 2;

    int byte_align = r ? height : width;

    switch(color_format)
    {
    case COLOR_PALETTE1:
        if (byte_align % 8)
        {
            return false;
        }
        canvas->draw_pixel                = _graphics_draw_pixel_p1;
        canvas->draw_pixel_alpha          = _graphics_draw_pixel_alpha_p1;
        canvas->get_pixel                 = _graphics_get_pixel_p1;
        canvas->draw_horizontal           = _graphics_draw_horizontal_p1;
        canvas->draw_vertical             = _graphics_draw_vertical_p1;
        canvas->convert_color_to_native   = _graphics_convert_color_to_p1;
        canvas->convert_color_from_native = _graphics_convert_color_from_p1;
        canvas->color_format              = COLOR_PALETTE1;
        break;
    case COLOR_PALETTE2:
        if (byte_align % 4)
        {
            return false;
        }
        canvas->draw_pixel                = _graphics_draw_pixel_p2;
        canvas->draw_pixel_alpha          = _graphics_draw_pixel_alpha_p2;
        canvas->get_pixel                 = _graphics_get_pixel_p2;
        canvas->draw_horizontal           = _graphics_draw_horizontal_p2;
        canvas->draw_vertical             = _graphics_draw_vertical_p2;
        canvas->convert_color_to_native   = _graphics_convert_color_to_p2;
        canvas->convert_color_from_native = _graphics_convert_color_from_p2;
        canvas->color_format              = COLOR_PALETTE2;
        break;
    case COLOR_PALETTE4:
        if (byte_align % 2)
        {
            return false;
        }
        canvas->draw_pixel                = _graphics_draw_pixel_p4;
        canvas->draw_pixel_alpha          = _graphics_draw_pixel_alpha_p4;
        canvas->get_pixel                 = _graphics_get_pixel_p4;
        canvas->draw_horizontal           = _graphics_draw_horizontal_p4;
        canvas->draw_vertical             = _graphics_draw_vertical_p4;
        canvas->convert_color_to_native   = _graphics_convert_color_to_p4;
        canvas->convert_color_from_native = _graphics_convert_color_from_p4;
        canvas->color_format              = COLOR_PALETTE4;
        break;
    case COLOR_PALETTE8:
        canvas->draw_pixel                = _graphics_draw_pixel_p8;
        canvas->draw_pixel_alpha          = _graphics_draw_pixel_alpha_p8;
        canvas->get_pixel                 = _graphics_get_pixel_p8;
        canvas->draw_horizontal           = _graphics_draw_horizontal_p8;
        canvas->draw_vertical             = _graphics_draw_vertical_p8;
        canvas->convert_color_to_native   = _graphics_convert_color_to_p8;
        canvas->convert_color_from_native = _graphics_convert_color_from_p8;
        canvas->color_format              = COLOR_PALETTE8;
        break;
    case COLOR_RGB565:
        canvas->draw_pixel                = _graphics_draw_pixel_rgb565;
        canvas->draw_pixel_alpha          = _graphics_draw_pixel_alpha_rgb565;
        canvas->get_pixel                 = _graphics_get_pixel_rgb565;
        canvas->draw_horizontal           = _graphics_draw_horizontal_rgb565;
        canvas->draw_vertical             = _graphics_draw_vertical_rgb565;
        canvas->convert_color_to_native   = _graphics_convert_color_to_rgb565;
        canvas->convert_color_from_native = _graphics_convert_color_from_rgb565;
        canvas->color_format              = COLOR_RGB565;
        break;
    default:
        break;
    }

    canvas->buffer_width  = width;
    canvas->buffer_height = height;
    canvas->canvas_left   = 0;
    canvas->canvas_top    = 0;
    canvas->canvas_width  = r ? height : width;
    canvas->canvas_height = r ? width : height;
    canvas->rotation      = 0;
    canvas->allocation_type = alloc_none;

    _canvas_set_rotation(canvas, rotation);

    return true;
}


/**
 * @brief    Create canvas
 *
 * Create a canvas structure and a buffer on the heap. Initialize the canvas.
 * In general the used size for the buffer is: (width * bpp / 8) * height
 *
 * The width and height parameters are the dimensions of the rotated canvas.
 * Therefore, creating the canvas with a rotation 'r' is not the same as
 * creating the canvas with a rotation '0' and afterwards calling canvas_set_rotation() with a rotation 'r'.
 *
 * @param  color_format Color format
 * @param  width        Width
 * @param  height       Height
 * @param  rotation     Rotation
 * @param  default_font Default Font pointer
 *
 * @return Canvas pointer if succeeded, NULL otherwise
 *
 * @see canvas_initialize(), canvas_destroy()
 */

canvas_t *canvas_create(color_format_t color_format, int width, int height, int rotation, font_t const *default_font)
{
    int size = 0;
    uintptr_t buffer;
    canvas_t *canvas;

    switch (color_format)
    {
    case COLOR_PALETTE1:
        size = (width / 8) * height;
        break;
    case COLOR_PALETTE2:
        size = (width / 4) * height;
        break;
    case COLOR_PALETTE4:
        size = (width / 2) * height;
        break;
    case COLOR_PALETTE8:
        size = width * height;
        break;
    case COLOR_RGB565:
        size = width * 2 * height;
        break;
    default:
        return NULL;
    }

    buffer = (uintptr_t)malloc(size);
    if (buffer == 0)
    {
        return NULL;
    }

    canvas = (canvas_t*)malloc(sizeof(canvas_t));
    if (canvas == 0)
    {
        free((void*)buffer);
        return NULL;
    }

    if (!canvas_initialize(canvas, buffer, color_format, width, height, rotation, default_font))
    {
        free((void*)buffer);
        free(canvas);
        return NULL;
    }

    canvas->allocation_type = alloc_both;

    return canvas;
}


/**
 * @brief    Destroy canvas
 *
 * Destroy a canvas created by canvas_create(), canvas_copy() or canvas_extract().
 *
 * @param  canvas       Pointer to canvas
 *
 * @return true on success, false otherwise
 *
 * @see canvas_create(), canvas_copy(), canvas_extract()
 */

bool canvas_destroy(canvas_t *canvas)
{

    switch (canvas->allocation_type)
    {
    case alloc_none:
        return false;
    case alloc_canvas:
        free(canvas);
        return true;
    case alloc_both:
        free((void*)canvas->buffer);
        free(canvas);
        return true;
    default:
        return false;
    }
}


/**
 * @brief    Get canvas buffer
 *
 * Get the buffer the canvas is located. The value returned is the address of the first pixel of the canvas
 *
 * @param  canvas       Pointer to canvas
 *
 * @return Canvas buffer
 */

uintptr_t canvas_get_buffer(canvas_t const * restrict canvas)
{
    switch (canvas->color_format)
    {
    case COLOR_PALETTE1:
        return canvas->buffer + (canvas->canvas_top * canvas->buffer_width + canvas->canvas_left) / 8;
    case COLOR_PALETTE2:
        return canvas->buffer + (canvas->canvas_top * canvas->buffer_width + canvas->canvas_left) / 4;
    case COLOR_PALETTE4:
        return canvas->buffer + (canvas->canvas_top * canvas->buffer_width + canvas->canvas_left) / 2;
    case COLOR_PALETTE8:
        return canvas->buffer + canvas->canvas_top * canvas->buffer_width + canvas->canvas_left;
    case COLOR_RGB565:
        return canvas->buffer + (canvas->canvas_top * canvas->buffer_width + canvas->canvas_left) * 2;
    default:
        return 0;
    }
}


/**
 * @brief    Extract canvas
 *
 * Extract a canvas from another canvas.
 * The extracted canvas gives access to a part of the original canvas.
 * As the extracted canvas and the original canvas share the same buffer,
 * drawing on the extracted canvas is visible on the original canvas and vv.
 *
 * If the dimensions of the extracted canvas are partly outside the original canvas,
 * the extracted canvas is cropped to dimensions that fit inside the original canvas
 *
 * Left and right side of the canvas must always be on a byte boundary.
 * In COLOR_PALETTE4 mode, left and with must be even.
 * In COLOR_PALETTE2 mode, left and with must be a multiple of 4.
 * In COLOR_PALETTE1 mode, left and with must be a multiple of 8.
 *
 * @param  canvas       Canvas pointer to the original canvas
 * @param  left         Left position of the extracted canvas relative to the origin of the original canvas
 * @param  top          Top position of the extracted canvas relative to the origin of the original canvas
 * @param  width        Width of the extracted canvas
 * @param  height       Height of the extracted canvas
 *
 * @return Canvas pointer if succeeded, NULL otherwise
 *
 * @see canvas_destroy()
 */

canvas_t *canvas_extract(const canvas_t * canvas, int left, int top, int width, int height)
{
    int  rotation;
    canvas_t *destination;

    /* check for invalid dimensions */
    if (width < 0 || height < 0)
    {
        return NULL;    //invalid dimensions
    }

    destination = (canvas_t*)malloc(sizeof(canvas_t));
    if (destination == 0)
    {
        return NULL;    //malloc failed
    }

    *destination = *canvas;

    /* check if canvas borders are byte aligned */
    switch (canvas->color_format)
    {
    case COLOR_PALETTE1:
        if ((left % 8) || (width % 8))
        {
            free(destination);
            return NULL;
        }
        break;
    case COLOR_PALETTE2:
        if ((left % 4) || (width % 4))
        {
            free(destination);
            return NULL;
        }
        break;
    case COLOR_PALETTE4:
        if ((left % 2) || (width % 2))
        {
            free(destination);
            return NULL;
        }
        break;
    default:
        break;
    }

    if (left < 0)
    {
        width += left;
        left = 0;
    }
    if (left + width > canvas->canvas_width)
    {
        width = canvas->canvas_width - left;
    }
    if (top < 0)
    {
        height += top;
        top = 0;
    }
    if (top + height > canvas->canvas_height)
    {
        height = canvas->canvas_height - top;
    }

    switch (destination->rotation)
    {
    case CANVAS_ROTATION_0:
        destination->canvas_left   = canvas->canvas_left + left;
        destination->canvas_top    = canvas->canvas_top + top;
        destination->canvas_width  = width;
        destination->canvas_height = height;
        break;
    case CANVAS_ROTATION_90:
        destination->canvas_left   = canvas->canvas_left + left;
        destination->canvas_top    = canvas->canvas_top - top;
        destination->canvas_width  = width;
        destination->canvas_height = height;
        break;
    case CANVAS_ROTATION_180:
        destination->canvas_left   = canvas->canvas_left - left;
        destination->canvas_top    = canvas->canvas_top - top;
        destination->canvas_width  = width;
        destination->canvas_height = height;
        break;
    case CANVAS_ROTATION_270:
        destination->canvas_left   = canvas->canvas_left - left;
        destination->canvas_top    = canvas->canvas_top + top;
        destination->canvas_width  = width;
        destination->canvas_height = height;
        break;
    }

    rotation = _canvas_unset_rotation(destination);
    _canvas_set_rotation(destination, rotation);

    destination->allocation_type = alloc_canvas;

    return destination;
}


/**
 * @brief    Blit canvas
 *
 * Blit a canvas into another canvas.
 * The graphic contents of the second canvas is copied to the first canvas at the given location.
 * The function returns true if the source canvas is (partly) copied to the destination canvas, otherwise it returns false.
 *
 * Both canvases must have the same color format and the same rotation, otherwise the blit can not be performed.
 *
 * @param  destination  Canvas pointer to the destination canvas
 * @param  source       Canvas pointer to the source canvas
 * @param  left         Left position of the destination relative to the origin of the destination canvas
 * @param  top          Top position of the destination relative to the origin of the destination canvas
 *
 * @return true on success, false otherwise
 */

bool canvas_blit(canvas_t *destination, const canvas_t *source, int left, int top)
{
    int od = 0; // offset destination
    int os = 0; // offset source
    int size = 0;   // line size
    int ld;     // left destination
    int ls;     // left source
    int td;     // top destination
    int ts;     // top source
    int bwd;    // buffer width destination in bytes
    int bws;    // buffer width source in bytes
    int w, h;   // width, height
    int rotation;
    int temp;
    canvas_t src;

    if (! _canvas_is_compatible(destination, source))
    {
        return false;
    }

    src = *source;
    rotation = _canvas_unset_rotation(destination);
    _canvas_unset_rotation(&src);

    switch (rotation)
    {
    case CANVAS_ROTATION_90:
        temp = left;
        left = destination->canvas_width - top - src.canvas_width;
        top  = temp;
        break;
    case CANVAS_ROTATION_180:
        temp = left;
        top  = destination->canvas_height - top - src.canvas_height;
        left = destination->canvas_width - left - src.canvas_width;
        break;
    case CANVAS_ROTATION_270:
        temp = left;
        left = top;
        top  = destination->canvas_height - temp - src.canvas_height;
        break;
    default:
        break;
    }

    /* check corrdinates */
#if GRAPHICS_CHECK_COORDINATES == 1
    if (left < 0)
    {
        ls = src.canvas_left - left;
        ld = destination->canvas_left;
        w = src.canvas_width + left;

        if (w > destination->canvas_width)
        {
            w = destination->canvas_width;
        }
    }
    else
    {
        ld = destination->canvas_left + left;
        ls = src.canvas_left;
        w = src.canvas_width;

        if ((ld + w) > (destination->canvas_left + destination->canvas_width))
        {
            w = destination->canvas_left + destination->canvas_width - ld;
        }
    }

    if (top < 0)
    {
        ts = src.canvas_top - top;
        td = destination->canvas_top;
        h = src.canvas_height + top;

        if (h > destination->canvas_height)
        {
            h = destination->canvas_height;
        }
    }
    else
    {
        td = destination->canvas_top + top;
        ts = src.canvas_top;
        h = src.canvas_height;

        if ((td + h) > (destination->canvas_top + destination->canvas_height))
        {
            h = destination->canvas_top + destination->canvas_height - td;
        }
    }

#else

    ld = destination->canvas_left + left;
    ls = src.canvas_left;
    td = destination->canvas_top + top;
    ts = src.canvas_top;
    w =  src.canvas_width;
    h =  src.canvas_height;

#endif

    switch (src.color_format)
    {
        case COLOR_PALETTE1:
            if (left % 8)
            {
                _canvas_set_rotation(destination, rotation);
                return false;
            }
            bwd = destination->buffer_width / 8;
            bws = src.buffer_width / 8;
            od = (destination->buffer_width * td + ld) / 8;
            os = (src.buffer_width * ts + ls) / 8;
            size = w / 8;
            break;
        case COLOR_PALETTE2:
            if (left % 4)
            {
                _canvas_set_rotation(destination, rotation);
                return false;
            }
            bwd = destination->buffer_width / 4;
            bws = src.buffer_width / 4;
            od = (destination->buffer_width * td + ld) / 4;
            os = (src.buffer_width * ts + ls) / 4;
            size = w / 4;
            break;
        case COLOR_PALETTE4:
            if (left % 2)
            {
                _canvas_set_rotation(destination, rotation);
                return false;
            }
            bwd = destination->buffer_width / 2;
            bws = src.buffer_width / 2;
            od = (destination->buffer_width * td + ld) / 2;
            os = (src.buffer_width * ts + ls) / 2;
            size = w / 2;
            break;
        case COLOR_PALETTE8:
            bwd = destination->buffer_width;
            bws = src.buffer_width;
            od = destination->buffer_width * td + ld;
            os = src.buffer_width * ts + ls;
            size = w;
            break;
        case COLOR_RGB565:
            bwd = destination->buffer_width * 2;
            bws = src.buffer_width * 2;
            od = (destination->buffer_width * td + ld) * 2;
            os = (src.buffer_width * ts + ls) * 2;
            size = w * 2;
            break;
        default:
            return false;
    }

    if ( (destination->buffer + od) < (src.buffer + os))
    {
        for (int i = 0; i < h; i++)
        {
            memmove((void*)(destination->buffer + od + i * bwd), (void*)(src.buffer + os + i * bws), size);
        }
    }
    else
    {
        for (int i = h-1; i >= 0; i--)
        {
            memmove((void*)(destination->buffer + od + i * bwd), (void*)(src.buffer + os + i * bws), size);
        }
    }

    _canvas_set_rotation(destination, rotation);
    return true;
}


/**
 * @brief    Copy canvas
 *
 * The copy function creates a new canvas on the heap that contains the same data as the original canvas.
 * If the original canvas was extracted from a larger canvas, the new canvas has only the data of the extracted canvas
 * and the buffer is only the size needed for this canvas.
 *
 * @param  canvas       Canvas pointer
 *
 * @see canvas_destroy()
 *
 * @return Pointer to copied canvas
 */

canvas_t *canvas_copy(const canvas_t *canvas)
{
    canvas_t *new_canvas;
    new_canvas = canvas_create(canvas->color_format, canvas->canvas_width, canvas->canvas_height, canvas->rotation, canvas->default_font);

    if (new_canvas == NULL)
    {
        return NULL;
    }

    if (!canvas_blit(new_canvas, canvas, 0, 0))
    {
        canvas_destroy(new_canvas);
        return NULL;
    }

    return new_canvas;
}


/**
 * @brief    Get canvas line length
 *
 * Get the length of the lines of the canvas. The linelength is the sum of the width of the canvas in bytes
 * and the gap between 2 successive canvas lines in bytes. If memory location m points to pixel (xn,yn) on the canvas,
 * memory location (m + line-length) points to pixel (xn,yn+1) on the canvas.
 *
 * @param  canvas       Canvas pointer
 *
 * @return Canvas line length in bytes
 */

unsigned canvas_get_linelength(canvas_t const * restrict canvas)
{
    return canvas->buffer_width;
}




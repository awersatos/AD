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
#include <util_endian.h>
#include <graphics.h>
#include <graphics_i.h>
#include "graphics_cfg.h"
#include "graphics_cfg_instance.h"

#define TO_GRAY(R,G,B) ((R*306+G*601+B*117)/1024)   // Y = 0.299 R + 0.587 G + 0.114 B
#define RGB_GRAY(R,G,B,gray) gray ? RGB(TO_GRAY(R,G,B),TO_GRAY(R,G,B),TO_GRAY(R,G,B)) : RGB(R,G,B)

#define graphics_draw_pixel_mod(canvas,x,y,R,G,B,transparent,transparent_color,gray)  if (!transparent || RGB(R,G,B) != transparent_color) graphics_draw_pixel(canvas, x, y, RGB_GRAY(R,G,B,gray))

/*
 * DRAW BITMAP
 */

/**
 * @brief    Draw bitmap on canvas
 *
 * Draw an bitmap on the canvas.
 * A bitmap
 *
 * The 'left' and 'top' parameters set the position of the bitmap.
 * The 'width' and 'height' parameters set the maximum canvas space occupied by the bitmap.
 * if the bitmap, after zooming, is larger as the given width and height, the bitmap is cropped.
 * Because of the nature of a bitmap, this cropping is done at the right side and the top!
 *
 * The 'zoom' parameter sets the zoom factor. The zoom factor is given in percents. If zoom is set to 0, the maximum zoom factor is calculated.
 * The maximum zoom factor is the zoom factor where the bitmap occupies most of the rectangle defined by 'width' and 'height', without cropping.
 *
 * If the bitmap is displayed on a paletted driver (i.e. vga 1 to 8 bpp driver), 
 * the bitmap is mapped on the palette using a "nearest color" algorithm.
 *
 * See "Importing Binary Files" in the Embedded Tools documentation for adding bitmaps to your project.
 *
 *
 * @param canvas Canvas pointer
 * @param bm     Pointer to bitmap structure
 * @param left   Location of left side of the bitmap
 * @param top    Location of top of the bitmap
 * @param width  Maximal width of the bitmap
 * @param height Maximal height of the bitmap
 * @param zoom   Zoom factor in percents
 *
 * @return Nothing
 */

void graphics_draw_bitmap(canvas_t const * restrict canvas, const graphics_bitmap_t *bm, int left, int top, int width, int height, int zoom)
{
    int bm_offset;
    int file_size;
    int color_depth;
    int w, h, z;
    int line_bound;
    int column, row, i, j, x, y;
    int dx, dy;
    uint8_t red, green, blue;
    uint8_t color_index = 0, pixel;
    int canvas_width = canvas->canvas_width;
    int canvas_height = canvas->canvas_height;

    if (zoom == 0 && (width == 0 || height == 0))
    {
        return;     /* invalid paramters */
    }

    if ( bm->bmfh.type[0] != 'B' || bm->bmfh.type[1] != 'M' )
    {
        return;     /* unsupported or corrupted file format */
    }

    file_size = read_little32from8( bm->bmfh.size );
    bm_offset = read_little32from8( bm->bmfh.offset );

    if ( bm_offset >= file_size )
    {
        return;     /* unsupported or corrupted file format */
    }

    bm_offset -= ( sizeof( bmfileheader_t ) + sizeof( bminfoheader_t ));
    w = read_little32from8( bm->bmih.width );
    h = read_little32from8( bm->bmih.height );
    color_depth = read_little16from8( bm->bmih.bitcount );

    if (zoom == 0)
    {
        z = height * 100 / h;
        zoom = width * 100 / w;
        zoom = zoom < z ? zoom : z;
        height = h * zoom / 100;
        width = w * zoom / 100;
    }

    if (zoom <= 100)
    {
        height = height + top > canvas_height ? canvas_height - top : height;   // crop height if outside screen
        height = (h * zoom) > (height * 100) ? height * 100 / zoom : h;
        width = width + left > canvas_width ? canvas_width - left : width;        // crop width if outside screen
        width = (w * zoom) > (width * 100) ? width * 100 / zoom : w;
        height = h < height ? h : height;
        width  = w < width  ? w : width;
    }
    else
    {
        height = h * zoom < height * 100 ? h * zoom / 100 : height;
        width  = w * zoom < width  * 100 ? w * zoom / 100 : width;
    }

    if (zoom < 100)
    {
        switch( color_depth )
        {
        case 1:
            line_bound = ((( w + 7 ) / 8 ) + 3) & ~3;
            top += ( height * zoom / 100 ) - 1;
            dy = (2 * zoom) - 100;
            y = top;
            for (row = 0; row < height; row++, top-- )
            {
                if ( dy >= 0 )
                {
                    dx = (2 * zoom) - 100;
                    x = left;
                    for (column = 0, pixel = 0; column < width; column++)
                    {
                        if ( pixel == 0 )
                        {
                            color_index = bm->data[bm_offset + row * line_bound + column / 8];
                            pixel = 0x80;
                        }
                        if ( dx >= 0 )
                        {
                            if (color_index & pixel)
                            {
                                blue  = bm->data[4];
                                green = bm->data[5];
                                red   = bm->data[6];
                            }
                            else
                            {
                                blue  = bm->data[0];
                                green = bm->data[1];
                                red   = bm->data[2];
                            }
                            graphics_draw_pixel(canvas, x, y, RGB(red, green, blue));
                            dx -= 2 * 100;
                            x++;
                        }
                        pixel >>= 1;
                        dx += 2 * zoom;
                    }
                    dy -= 2 * 100;
                    y--;
                }
                dy += 2 * zoom;
            }
            break;
        case 4:
            line_bound = ((( w + 1 ) / 2 ) + 3) & ~3;
            top += ( height * zoom / 100 ) - 1;
            dy = (2 * zoom) - 100;
            y = top;
            for (row = 0; row < height; row++, top-- )
            {
                if ( dy >= 0 )
                {
                    dx = (2 * zoom) - 100;
                    x = left;
                    for (column = 0; column < width; column++)
                    {
                        if ( dx >= 0 )
                        {
                            if ( !(column & 0x01 ))
                            {
                                color_index = bm->data[bm_offset + row * line_bound + column / 2];
                                blue        = bm->data[4 * (color_index >> 4)];
                                green       = bm->data[4 * (color_index >> 4) + 1];
                                red         = bm->data[4 * (color_index >> 4) + 2];
                            }
                            else
                            {
                                blue        = bm->data[4 * (color_index & 0x0f)];
                                green       = bm->data[4 * (color_index & 0x0f) + 1];
                                red         = bm->data[4 * (color_index & 0x0f) + 2];
                            }
                            graphics_draw_pixel(canvas, x, y, RGB(red, green, blue));
                            dx -= 2 * 100;
                            x++;
                        }
                        dx += 2 * zoom;
                    }
                    dy -= 2 * 100;
                    y--;
                }
                dy += 2 * zoom;
            }
            break;
        case 8:
            line_bound = (w + 3) & ~3;
            top += ( height * zoom / 100 ) - 1;
            dy = (2 * zoom) - 100;
            y = top;
            for (row = 0; row < height; row++)
            {
                if ( dy >= 0 )
                {
                    dx = (2 * zoom) - 100;
                    x = left;
                    for (column = 0; column < width; column++)
                    {
                        if ( dx >= 0 )
                        {
                            color_index = bm->data[bm_offset + row * line_bound + column];
                            blue        = bm->data[4 * color_index];
                            green       = bm->data[4 * color_index + 1];
                            red         = bm->data[4 * color_index + 2];
                            graphics_draw_pixel(canvas, x, y, RGB(red, green, blue));
                            dx -= 2 * 100;
                            x++;
                        }
                        dx += 2 * zoom;
                    }
                    dy -= 2 * 100;
                    y--;
                }
                dy += 2 * zoom;
            }
            break;
        case 24:
            line_bound = (( w * 3 ) + 3) & ~3;
            top += ( height * zoom / 100 ) - 1;
            dy = (2 * zoom) - 100;
            y = top;
            for (row = 0; row < height; row++ )
            {
                if ( dy >= 0 )
                {
                    dx = (2 * zoom) - 100;
                    x = left;
                    for (column = 0, i = 0; column < width; column++)
                    {
                        if ( dx >= 0 )
                        {
                            blue  = bm->data[row * line_bound + i++];
                            green = bm->data[row * line_bound + i++];
                            red   = bm->data[row * line_bound + i++];
                            graphics_draw_pixel(canvas, x, y, RGB(red, green, blue));
                            dx -= 2 * 100;
                            x++;
                        }
                        else
                        {
                            i += 3;
                        }
                        dx += 2 * zoom;
                    }
                    dy -= 2 * 100;
                    y--;
                }
                dy += 2 * zoom;
            }
            break;
        default:
            return;     /* unsupported or corrupted file format */
        }
    }
    else if (zoom > 100)
    {
        switch( color_depth )
        {
        case 1:
            line_bound = ((( w + 7 ) / 8 ) + 3) & ~3;
            top += ( height * zoom / 100 ) - 1;
            dy = (2 * zoom) - 100;
            y = top;
            for (row = 0; row < height; row++, top-- )
            {
                if ( dy >= 0 )
                {
                    dx = (2 * zoom) - 100;
                    x = left;
                    for (column = 0, pixel = 0; column < width; column++)
                    {
                        if ( pixel == 0 )
                        {
                            color_index = bm->data[bm_offset + row * line_bound + column / 8];
                            pixel = 0x80;
                        }
                        if ( dx >= 0 )
                        {
                            if (color_index & pixel)
                            {
                                blue  = bm->data[4];
                                green = bm->data[5];
                                red   = bm->data[6];
                            }
                            else
                            {
                                blue  = bm->data[0];
                                green = bm->data[1];
                                red   = bm->data[2];
                            }
                            graphics_draw_pixel(canvas, x, y, RGB(red, green, blue));
                            dx -= 2 * 100;
                            x++;
                        }
                        pixel >>= 1;
                        dx += 2 * zoom;
                    }
                    dy -= 2 * 100;
                    y--;
                }
                dy += 2 * zoom;
            }
            break;
        case 4:
            line_bound = ((( w + 1 ) / 2 ) + 3) & ~3;
            y = top + height - 1;
            dy = 200 - 2 * zoom;
            for (row = 0, j = 0; row < height; row++, y-- )
            {
                dx = 200 - 2 * zoom;
                x = left;
                for (column = 0, i = 0; column < width; column++)
                {
                    if ( !(i & 0x01 ))
                    {
                        color_index = bm->data[bm_offset + j * line_bound + i / 2];
                        blue        = bm->data[4 * (color_index >> 4)    ];
                        green       = bm->data[4 * (color_index >> 4) + 1];
                        red         = bm->data[4 * (color_index >> 4) + 2];
                    }
                    else
                    {
                        blue        = bm->data[4 * (color_index & 0x0F)    ];
                        green       = bm->data[4 * (color_index & 0x0F) + 1];
                        red         = bm->data[4 * (color_index & 0x0F) + 2];
                    }
                    graphics_draw_pixel(canvas, x, y, RGB(red, green, blue));
                    if ( dx >= 0 )
                    {
                        i++;
                        dx -= 2 * zoom;
                    }
                    x++;
                    dx += 2 * 100;
                }
                if ( dy >= 0 )
                {
                    j++;
                    dy -= 2 * zoom;
                }
                dy += 2 * 100;
            }
            break;
        case 8:
            line_bound = (w + 3) & ~3;
            y = top + height - 1;
            dy = 200 - 2 * zoom;
            for (row = 0, j = 0; row < height; row++, y--)
            {
                dx = 200 - 2 * zoom;
                x = left;
                for (column = 0, i = 0; column < width; column++)
                {
                    color_index = bm->data[bm_offset + j * line_bound + i];
                    blue        = bm->data[4 * color_index    ];
                    green       = bm->data[4 * color_index + 1];
                    red         = bm->data[4 * color_index + 2];
                    graphics_draw_pixel(canvas, x, y, RGB(red, green, blue));
                    if ( dx >= 0 )
                    {
                        i++;
                        dx -= 2 * zoom;
                    }
                    x++;
                    dx += 2 * 100;
                }
                if ( dy >= 0 )
                {
                    j++;
                    dy -= 2 * zoom;
                }
                dy += 2 * 100;
            }
            break;
        case 24:
            line_bound = (( w * 3 ) + 3) & ~3;
            y = top + height - 1;
            dy = 200 - 2 * zoom;
            for (row = 0, j = 0; row < height; row++, y-- )
            {
                dx = 200 - 2 * zoom;
                x = left;
                for (column = 0, i = 0; column < width; column++)
                {
                    blue  = bm->data[j * line_bound + i    ];
                    green = bm->data[j * line_bound + i + 1];
                    red   = bm->data[j * line_bound + i + 2];
                    graphics_draw_pixel(canvas, x, y, RGB(red, green, blue));
                    if ( dx >= 0 )
                    {
                        i += 3;
                        dx -= 2 * zoom;
                    }
                    x++;
                    dx += 2 * 100;
                }
                if ( dy >= 0 )
                {
                    j++;
                    dy -= 2 * zoom;
                }
                dy += 2 * 100;
            }
            break;
        default:
            return;     /* unsupported or corrupted file format */
        }
    }
    else    // -> zoom = 100
    {
        switch( color_depth )
        {
        case 1:
            line_bound = ((( w + 7 ) / 8 ) + 3) & ~3;
            y = top + height - 1;
            for (row = 0; row < height; row++, y-- )
            {
                x = left;
                for (column = 0, pixel = 0; column < width; column++, x++)
                {
                    if ( pixel == 0 )
                    {
                        color_index = bm->data[bm_offset + row * line_bound + column / 8];
                        pixel = 0x80;
                    }
                    if (color_index & pixel)
                    {
                        blue  = bm->data[4];
                        green = bm->data[5];
                        red   = bm->data[6];
                    }
                    else
                    {
                        blue  = bm->data[0];
                        green = bm->data[1];
                        red   = bm->data[2];
                    }
                    graphics_draw_pixel(canvas, x, y, RGB(red, green, blue));
                    pixel >>= 1;
                }
            }
            break;
        case 4:
            line_bound = ((( w + 1 ) / 2 ) + 3) & ~3;
            y = top + height - 1;
            for (row = 0; row < height; row++, y-- )
            {
                x = left;
                for (column = 0; column < width; column++, x++)
                {
                    if ( !(column & 0x01 ))
                    {
                        color_index = bm->data[bm_offset + row * line_bound + column / 2];
                        blue        = bm->data[4 * (color_index >> 4)];
                        green       = bm->data[4 * (color_index >> 4) + 1];
                        red         = bm->data[4 * (color_index >> 4) + 2];
                    }
                    else
                    {
                        blue        = bm->data[4 * (color_index & 0x0f)];
                        green       = bm->data[4 * (color_index & 0x0f) + 1];
                        red         = bm->data[4 * (color_index & 0x0f) + 2];
                    }
                    graphics_draw_pixel(canvas, x, y, RGB(red, green, blue));
                }
            }
            break;
        case 8:
            line_bound = (w + 3) & ~3;
            y = top + height - 1;
            for (row = 0; row < height; row++, y--)
            {
                x = left;
                for (column = 0; column < width; column++, x++)
                {
                    color_index = bm->data[bm_offset + row * line_bound + column];
                    blue        = bm->data[4 * color_index];
                    green       = bm->data[4 * color_index + 1];
                    red         = bm->data[4 * color_index + 2];
                    graphics_draw_pixel(canvas, x, y, RGB(red, green, blue));
                }
            }
            break;
        case 24:
            line_bound = (( w * 3 ) + 3) & ~3;
            y = top + height - 1;
            for (row = 0; row < height; row++, y-- )
            {
                x = left;
                for (column = 0, i = 0; column < width; column++, x++)
                {
                    blue  = bm->data[row * line_bound + i++];
                    green = bm->data[row * line_bound + i++];
                    red   = bm->data[row * line_bound + i++];
                    graphics_draw_pixel(canvas, x, y, RGB(red, green, blue));
                }
            }
            break;
        default:
            return;     /* unsupported or corrupted file format */
        }
    }
}



void graphics_draw_bitmap_modified(canvas_t const * restrict canvas, const graphics_bitmap_t *bm, int left, int top, int width, int height, int zoom,
                                   bool transparent, color_t transparent_color, bool grayed)
{
    int bm_offset;
    int file_size;
    int color_depth;
    int w, h, z;
    int line_bound;
    int column, row, i, j, x, y;
    int dx, dy;
    uint8_t red, green, blue;
    uint8_t color_index = 0, pixel;
    int canvas_width = canvas->canvas_width;
    int canvas_height = canvas->canvas_height;

    if (zoom == 0 && (width == 0 || height == 0))
    {
        return;     /* invalid paramters */
    }

    if ( bm->bmfh.type[0] != 'B' || bm->bmfh.type[1] != 'M' )
    {
        return;     /* unsupported or corrupted file format */
    }

    file_size = read_little32from8( bm->bmfh.size );
    bm_offset = read_little32from8( bm->bmfh.offset );

    if ( bm_offset >= file_size )
    {
        return;     /* unsupported or corrupted file format */
    }

    bm_offset -= ( sizeof( bmfileheader_t ) + sizeof( bminfoheader_t ));
    w = read_little32from8( bm->bmih.width );
    h = read_little32from8( bm->bmih.height );
    color_depth = read_little16from8( bm->bmih.bitcount );

    if (zoom == 0)
    {
        z = height * 100 / h;
        zoom = width * 100 / w;
        zoom = zoom < z ? zoom : z;
        height = h * zoom / 100;
        width = w * zoom / 100;
    }

    if (zoom <= 100)
    {
        height = height + top > canvas_height ? canvas_height - top : height;   // crop height if outside screen
        height = (h * zoom) > (height * 100) ? height * 100 / zoom : h;
        width = width + left > canvas_width ? canvas_width - left : width;        // crop width if outside screen
        width = (w * zoom) > (width * 100) ? width * 100 / zoom : w;
        height = h < height ? h : height;
        width  = w < width  ? w : width;
    }
    else
    {
        height = h * zoom < height * 100 ? h * zoom / 100 : height;
        width  = w * zoom < width  * 100 ? w * zoom / 100 : width;
    }

    if (zoom < 100)
    {
        switch( color_depth )
        {
        case 1:
            line_bound = ((( w + 7 ) / 8 ) + 3) & ~3;
            top += ( height * zoom / 100 ) - 1;
            dy = (2 * zoom) - 100;
            y = top;
            for (row = 0; row < height; row++, top-- )
            {
                if ( dy >= 0 )
                {
                    dx = (2 * zoom) - 100;
                    x = left;
                    for (column = 0, pixel = 0; column < width; column++)
                    {
                        if ( pixel == 0 )
                        {
                            color_index = bm->data[bm_offset + row * line_bound + column / 8];
                            pixel = 0x80;
                        }
                        if ( dx >= 0 )
                        {
                            if (color_index & pixel)
                            {
                                blue  = bm->data[4];
                                green = bm->data[5];
                                red   = bm->data[6];
                            }
                            else
                            {
                                blue  = bm->data[0];
                                green = bm->data[1];
                                red   = bm->data[2];
                            }
                            graphics_draw_pixel_mod(canvas, x, y, red, green, blue, transparent, transparent_color, grayed);
                            dx -= 2 * 100;
                            x++;
                        }
                        pixel >>= 1;
                        dx += 2 * zoom;
                    }
                    dy -= 2 * 100;
                    y--;
                }
                dy += 2 * zoom;
            }
            break;
        case 4:
            line_bound = ((( w + 1 ) / 2 ) + 3) & ~3;
            top += ( height * zoom / 100 ) - 1;
            dy = (2 * zoom) - 100;
            y = top;
            for (row = 0; row < height; row++, top-- )
            {
                if ( dy >= 0 )
                {
                    dx = (2 * zoom) - 100;
                    x = left;
                    for (column = 0; column < width; column++)
                    {
                        if ( dx >= 0 )
                        {
                            if ( !(column & 0x01 ))
                            {
                                color_index = bm->data[bm_offset + row * line_bound + column / 2];
                                blue        = bm->data[4 * (color_index >> 4)];
                                green       = bm->data[4 * (color_index >> 4) + 1];
                                red         = bm->data[4 * (color_index >> 4) + 2];
                            }
                            else
                            {
                                blue        = bm->data[4 * (color_index & 0x0f)];
                                green       = bm->data[4 * (color_index & 0x0f) + 1];
                                red         = bm->data[4 * (color_index & 0x0f) + 2];
                            }
                            graphics_draw_pixel_mod(canvas, x, y, red, green, blue, transparent, transparent_color, grayed);
                            dx -= 2 * 100;
                            x++;
                        }
                        dx += 2 * zoom;
                    }
                    dy -= 2 * 100;
                    y--;
                }
                dy += 2 * zoom;
            }
            break;
        case 8:
            line_bound = (w + 3) & ~3;
            top += ( height * zoom / 100 ) - 1;
            dy = (2 * zoom) - 100;
            y = top;
            for (row = 0; row < height; row++)
            {
                if ( dy >= 0 )
                {
                    dx = (2 * zoom) - 100;
                    x = left;
                    for (column = 0; column < width; column++)
                    {
                        if ( dx >= 0 )
                        {
                            color_index = bm->data[bm_offset + row * line_bound + column];
                            blue        = bm->data[4 * color_index];
                            green       = bm->data[4 * color_index + 1];
                            red         = bm->data[4 * color_index + 2];
                            graphics_draw_pixel_mod(canvas, x, y, red, green, blue, transparent, transparent_color, grayed);
                            dx -= 2 * 100;
                            x++;
                        }
                        dx += 2 * zoom;
                    }
                    dy -= 2 * 100;
                    y--;
                }
                dy += 2 * zoom;
            }
            break;
        case 24:
            line_bound = (( w * 3 ) + 3) & ~3;
            top += ( height * zoom / 100 ) - 1;
            dy = (2 * zoom) - 100;
            y = top;
            for (row = 0; row < height; row++ )
            {
                if ( dy >= 0 )
                {
                    dx = (2 * zoom) - 100;
                    x = left;
                    for (column = 0, i = 0; column < width; column++)
                    {
                        if ( dx >= 0 )
                        {
                            blue  = bm->data[row * line_bound + i++];
                            green = bm->data[row * line_bound + i++];
                            red   = bm->data[row * line_bound + i++];
                            graphics_draw_pixel_mod(canvas, x, y, red, green, blue, transparent, transparent_color, grayed);
                            dx -= 2 * 100;
                            x++;
                        }
                        else
                        {
                            i += 3;
                        }
                        dx += 2 * zoom;
                    }
                    dy -= 2 * 100;
                    y--;
                }
                dy += 2 * zoom;
            }
            break;
        default:
            return;     /* unsupported or corrupted file format */
        }
    }
    else if (zoom > 100)
    {
        switch( color_depth )
        {
        case 1:
            line_bound = ((( w + 7 ) / 8 ) + 3) & ~3;
            top += ( height * zoom / 100 ) - 1;
            dy = (2 * zoom) - 100;
            y = top;
            for (row = 0; row < height; row++, top-- )
            {
                if ( dy >= 0 )
                {
                    dx = (2 * zoom) - 100;
                    x = left;
                    for (column = 0, pixel = 0; column < width; column++)
                    {
                        if ( pixel == 0 )
                        {
                            color_index = bm->data[bm_offset + row * line_bound + column / 8];
                            pixel = 0x80;
                        }
                        if ( dx >= 0 )
                        {
                            if (color_index & pixel)
                            {
                                blue  = bm->data[4];
                                green = bm->data[5];
                                red   = bm->data[6];
                            }
                            else
                            {
                                blue  = bm->data[0];
                                green = bm->data[1];
                                red   = bm->data[2];
                            }
                            graphics_draw_pixel_mod(canvas, x, y, red, green, blue, transparent, transparent_color, grayed);
                            dx -= 2 * 100;
                            x++;
                        }
                        pixel >>= 1;
                        dx += 2 * zoom;
                    }
                    dy -= 2 * 100;
                    y--;
                }
                dy += 2 * zoom;
            }
            break;
        case 4:
            line_bound = ((( w + 1 ) / 2 ) + 3) & ~3;
            y = top + height - 1;
            dy = 200 - 2 * zoom;
            for (row = 0, j = 0; row < height; row++, y-- )
            {
                dx = 200 - 2 * zoom;
                x = left;
                for (column = 0, i = 0; column < width; column++)
                {
                    if ( !(i & 0x01 ))
                    {
                        color_index = bm->data[bm_offset + j * line_bound + i / 2];
                        blue        = bm->data[4 * (color_index >> 4)    ];
                        green       = bm->data[4 * (color_index >> 4) + 1];
                        red         = bm->data[4 * (color_index >> 4) + 2];
                    }
                    else
                    {
                        blue        = bm->data[4 * (color_index & 0x0F)    ];
                        green       = bm->data[4 * (color_index & 0x0F) + 1];
                        red         = bm->data[4 * (color_index & 0x0F) + 2];
                    }
                    graphics_draw_pixel_mod(canvas, x, y, red, green, blue, transparent, transparent_color, grayed);
                    if ( dx >= 0 )
                    {
                        i++;
                        dx -= 2 * zoom;
                    }
                    x++;
                    dx += 2 * 100;
                }
                if ( dy >= 0 )
                {
                    j++;
                    dy -= 2 * zoom;
                }
                dy += 2 * 100;
            }
            break;
        case 8:
            line_bound = (w + 3) & ~3;
            y = top + height - 1;
            dy = 200 - 2 * zoom;
            for (row = 0, j = 0; row < height; row++, y--)
            {
                dx = 200 - 2 * zoom;
                x = left;
                for (column = 0, i = 0; column < width; column++)
                {
                    color_index = bm->data[bm_offset + j * line_bound + i];
                    blue        = bm->data[4 * color_index    ];
                    green       = bm->data[4 * color_index + 1];
                    red         = bm->data[4 * color_index + 2];
                    graphics_draw_pixel_mod(canvas, x, y, red, green, blue, transparent, transparent_color, grayed);
                    if ( dx >= 0 )
                    {
                        i++;
                        dx -= 2 * zoom;
                    }
                    x++;
                    dx += 2 * 100;
                }
                if ( dy >= 0 )
                {
                    j++;
                    dy -= 2 * zoom;
                }
                dy += 2 * 100;
            }
            break;
        case 24:
            line_bound = (( w * 3 ) + 3) & ~3;
            y = top + height - 1;
            dy = 200 - 2 * zoom;
            for (row = 0, j = 0; row < height; row++, y-- )
            {
                dx = 200 - 2 * zoom;
                x = left;
                for (column = 0, i = 0; column < width; column++)
                {
                    blue  = bm->data[j * line_bound + i    ];
                    green = bm->data[j * line_bound + i + 1];
                    red   = bm->data[j * line_bound + i + 2];
                    graphics_draw_pixel_mod(canvas, x, y, red, green, blue, transparent, transparent_color, grayed);
                    if ( dx >= 0 )
                    {
                        i += 3;
                        dx -= 2 * zoom;
                    }
                    x++;
                    dx += 2 * 100;
                }
                if ( dy >= 0 )
                {
                    j++;
                    dy -= 2 * zoom;
                }
                dy += 2 * 100;
            }
            break;
        default:
            return;     /* unsupported or corrupted file format */
        }
    }
    else    // -> zoom = 100
    {
        switch( color_depth )
        {
        case 1:
            line_bound = ((( w + 7 ) / 8 ) + 3) & ~3;
            y = top + height - 1;
            for (row = 0; row < height; row++, y-- )
            {
                x = left;
                for (column = 0, pixel = 0; column < width; column++, x++)
                {
                    if ( pixel == 0 )
                    {
                        color_index = bm->data[bm_offset + row * line_bound + column / 8];
                        pixel = 0x80;
                    }
                    if (color_index & pixel)
                    {
                        blue  = bm->data[4];
                        green = bm->data[5];
                        red   = bm->data[6];
                    }
                    else
                    {
                        blue  = bm->data[0];
                        green = bm->data[1];
                        red   = bm->data[2];
                    }
                    graphics_draw_pixel_mod(canvas, x, y, red, green, blue, transparent, transparent_color, grayed);
                    pixel >>= 1;
                }
            }
            break;
        case 4:
            line_bound = ((( w + 1 ) / 2 ) + 3) & ~3;
            y = top + height - 1;
            for (row = 0; row < height; row++, y-- )
            {
                x = left;
                for (column = 0; column < width; column++, x++)
                {
                    if ( !(column & 0x01 ))
                    {
                        color_index = bm->data[bm_offset + row * line_bound + column / 2];
                        blue        = bm->data[4 * (color_index >> 4)];
                        green       = bm->data[4 * (color_index >> 4) + 1];
                        red         = bm->data[4 * (color_index >> 4) + 2];
                    }
                    else
                    {
                        blue        = bm->data[4 * (color_index & 0x0f)];
                        green       = bm->data[4 * (color_index & 0x0f) + 1];
                        red         = bm->data[4 * (color_index & 0x0f) + 2];
                    }
                    graphics_draw_pixel_mod(canvas, x, y, red, green, blue, transparent, transparent_color, grayed);
                }
            }
            break;
        case 8:
            line_bound = (w + 3) & ~3;
            y = top + height - 1;
            for (row = 0; row < height; row++, y--)
            {
                x = left;
                for (column = 0; column < width; column++, x++)
                {
                    color_index = bm->data[bm_offset + row * line_bound + column];
                    blue        = bm->data[4 * color_index];
                    green       = bm->data[4 * color_index + 1];
                    red         = bm->data[4 * color_index + 2];
                    graphics_draw_pixel_mod(canvas, x, y, red, green, blue, transparent, transparent_color, grayed);
                }
            }
            break;
        case 24:
            line_bound = (( w * 3 ) + 3) & ~3;
            y = top + height - 1;
            for (row = 0; row < height; row++, y-- )
            {
                x = left;
                for (column = 0, i = 0; column < width; column++, x++)
                {
                    blue  = bm->data[row * line_bound + i++];
                    green = bm->data[row * line_bound + i++];
                    red   = bm->data[row * line_bound + i++];
                    graphics_draw_pixel_mod(canvas, x, y, red, green, blue, transparent, transparent_color, grayed);
                }
            }
            break;
        default:
            return;     /* unsupported or corrupted file format */
        }
    }
}





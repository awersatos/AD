/*****************************************************************************\
|*
|*  IN PACKAGE:     Graphics         
|*
|*  COPYRIGHT:      Copyright (c) 2008, Altium
|*
|*  DESCRIPTION:    Text related routines
|*
 */

#include <stdint.h>
#include <stdbool.h>
#include <graphics.h>
#include <graphics_i.h>
#include "graphics_cfg.h"
#include "graphics_cfg_instance.h"
#include <font.h>


static void _graphics_draw_glyph(canvas_t *canvas, int x, int y, int width, int height, const uint16_t *data, color_t color, fontstyle_t style, const font_t *font)
{
    int          bpp = font->bits_per_pixel;
    int          hi_bit = (16 / bpp) * bpp;
    int          bit_number = hi_bit;
    int          i, j;
    unsigned int value;
    unsigned int data_value;
    unsigned int mask = (1 << bpp) - 1;
    int          d = 0;
    int          full_width = font->values_per_line * (16 / bpp);

    if ( style & FS_ITALIC )
    {
        d = height / 3;
    }

    data_value = *data;

    for(i = 0; i < height; i++)
    {
        for(j = d; j < full_width + d; j++)
        {
            if(bit_number == 0)
            {
                bit_number = hi_bit;
                data++;
                data_value = *data;
            }
            switch (bpp)
            {
            case 1:
                bit_number--;
                value = (data_value >> bit_number) & 0x01;
                if (value)
                {
                    graphics_draw_pixel(canvas, x + j, y + i, color);
                    if (style & FS_BOLD)
                    {
                        graphics_draw_pixel(canvas, x + j + 1, y + i, color);
                    }
                }
                break;
            case 2:
            case 3:
                bit_number -= bpp;
                value = (data_value >> bit_number) & mask;
                if (value)
                {
                    value = (value << (8 - bpp)) + (value << (8 - 2 * bpp));
                    graphics_draw_pixel_alpha(canvas, x + j, y + i, color, (uint8_t)value);
                    if (style & FS_BOLD)
                    {
                        graphics_draw_pixel_alpha(canvas, x + j + 1, y + i, color, (uint8_t)value);
                    }
                }
                break;
            default:
                bit_number -= bpp;
                value = (data_value >> bit_number) & mask;
                if (value)
                {
                    value = (value << (8 - bpp));
                    graphics_draw_pixel_alpha(canvas, x + j, y + i, color, (uint8_t)value);
                    if (style & FS_BOLD)
                    {
                        graphics_draw_pixel_alpha(canvas, x + j + 1, y + i, color, (uint8_t)value);
                    }
                }
            }
        }
        bit_number = hi_bit;
        data++;
        data_value = *data;
        if (( d > 0 ) && !( i % 3))
        {
            d--;
        }
    }
}


/**
 * @brief    Draw character on canvas
 *
 * Draw a character on the canvas.
 *
 * The character is drawn in the given font. Anti-aliased fonts are supported.
 * If no font is specified (font = NULL pointer), the default font is used.
 * The fontstyle is used to draw the character bold and/or italic independent of the used font.
 *
 * The color can be specified as SVG color or as RGB-color. 
 * For a complete list of SVG-colors, see SVG_colors.h.
 * For RGB-colors, use the macro RGB(R-value, G-value, B-value).
 *
 * @param canvas    Canvas pointer
 * @param x         Left location of the character
 * @param y         Top location of the font
 * @param c         Ascii value of char
 * @param font      Pointer to font
 * @param color     Color as SVG-color or RGB-color.
 * @param fontstyle Fontstyle for the character, independent of the font
 *
 * @return Width of the character
 */

int graphics_draw_char(canvas_t *canvas, int x, int y, char c, const font_t *font, color_t color, fontstyle_t fontstyle)
{
    int index;
    uint8_t uc = (uint8_t)c;
    
    if (!font)
    {
        font = canvas->default_font;
        if (!font)
        {
            return 0;
        }
    }

    if (( uc >= font->first_char ) && ( uc <= (font->first_char + font->number_of_chars - 1)))
    {
        index = (uc - font->first_char) * (font->values_per_line * font->height+1);
        _graphics_draw_glyph(canvas, x, y, font->data[index], font->height,
                  &font->data[index + 1], color, fontstyle, font);

        x = font->data[index];
    }
    else
    {
        x = font->space;
    }

    if (fontstyle & FS_BOLD)
    {
        x++;
    }

    return x;
}


/**
 * @brief    Draw string on canvas
 *
 * Draw a string on the canvas.
 *
 * The string is drawn in the given font. Anti-aliased fonts are supported.
 * If no font is specified (font = NULL pointer), the default font is used.
 * The fontstyle is used to draw the string bold and/or italic independent of the used font.
 *
 * The color can be specified as SVG color or as RGB-color. 
 * For a complete list of SVG-colors, see SVG_colors.h.
 * For RGB-colors, use the macro RGB(R-value, G-value, B-value).
 *
 * @param canvas    Canvas pointer
 * @param x         Left location of the character
 * @param y         Top location of the font
 * @param str       Sting
 * @param font      Pointer to font
 * @param color     Color as SVG-color or RGB-color.
 * @param fontstyle Fontstyle for the character, independent of the font
 *
 * @return Right location of last character
 */

int graphics_draw_string(canvas_t *canvas, int x, int y, const char *str, const font_t *font, color_t color, fontstyle_t fontstyle)
{
    if (!font)
    {
        font = canvas->default_font;
        if (!font)
        {
            return x;
        }
    }

    while (*str)
    {
        x += graphics_draw_char(canvas, x, y, *str++, font, color, fontstyle);
    }
    return x;
}

/**
 * @brief    Get string width
 *
 * Get the width of the string when drawn with the given font.
 * If no font is specified (font = NULL pointer), the default font is used.
 *
 * @param canvas    Canvas pointer
 * @param str       Pointer to string
 * @param font      Pointer to font
 * @param fontstyle Fontstyle for the string, independent of the font
 *
 * @return Width of the string
 */

int graphics_get_stringwidth(canvas_t *canvas,  const char *str, const font_t *font, fontstyle_t fontstyle )
{
    int result = 0;
    uint8_t uc;
    int index;

    if (!font)
    {
        font = canvas->default_font;
        if (!font)
        {
            return 0;
        }
    }

    while(*str != 0)
    {
        uc = *str++;

        if (( uc >= font->first_char ) && ( uc <= (font->first_char + font->number_of_chars - 1)))
        {
            index = (uc - font->first_char) * (font->values_per_line * font->height+1);
            result += font->data[index];
        }
        else
        {
            result += font->space;
        }

        if (fontstyle & FS_BOLD)
        {
            result++;
        }
    }

    if (fontstyle & FS_ITALIC)
    {
        result += font->height / 3;
    }

    return result;
}


/**
 * @brief    Get character width
 *
 * Get the width of the character when drawn with the given font.
 * If no font is specified (font = NULL pointer), the default font is used.
 *
 * @param canvas    Canvas pointer
 * @param c         Ascii value of character
 * @param font      Pointer to font
 * @param fontstyle Fontstyle for the character, independent of the font
 *
 * @return Width of the character
 */

int graphics_get_charwidth(canvas_t *canvas, char c, const font_t *font, fontstyle_t fontstyle )
{
    int result = 0;
    uint8_t uc = (uint8_t)c;
    int index;

    if (!font)
    {
        font = canvas->default_font;
        if (!font)
        {
            return 0;
        }
    }

    if (( uc >= font->first_char ) && ( uc <= (font->first_char + font->number_of_chars - 1)))
    {
        index = (uc - font->first_char) * (font->values_per_line * font->height+1);
        result = font->data[index];
    }
    else
    {
        result = font->space;
    }

    if (fontstyle & FS_BOLD)
    {
        result++;
    }

    if (fontstyle & FS_ITALIC)
    {
        result += font->height / 3;
    }

    return result;
}



/**
 * @brief    Get font height
 *
 * Get the height of the given font.
 * If no font is specified (font = NULL pointer), the height of the default font is returned.
 *
 * @param canvas    Canvas pointer
 * @param font      Pointer to font
 *
 * @return Height of the font
 */

int graphics_get_fontheight(canvas_t *canvas, const font_t *font)
{
    if (!font)
    {
        font = canvas->default_font;
        if (!font)
        {
            return 0;
        }
    }

    return font->height;
}


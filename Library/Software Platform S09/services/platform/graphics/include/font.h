#ifndef _FONT_H
#define _FONT_H


/* do not include in application files! */

struct _font_s
{
    const uint16_t bits_per_pixel;
    const uint16_t values_per_line;
    const uint16_t height;
    const uint16_t centreheight;
    const uint8_t first_char;
    const uint8_t number_of_chars;
    const uint16_t space;
    const uint16_t *data;
};

#endif

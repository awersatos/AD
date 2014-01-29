#ifndef _GRAPHICS_I_H
#define _GRAPHICS_I_H

#include <graphics.h>
#include <../internal/canvas_i.h>
#include <stdbool.h>


/*
 * macros to convert canvas-coordinates to buffer-coordinates
 */
#define X_0_DEGR(canvas, x, y)      (canvas->canvas_left + x)
#define Y_0_DEGR(canvas, x, y)      (canvas->canvas_top + y)
#define W_0_DEGR(canvas)            (canvas->canvas_width)
#define H_0_DEGR(canvas)            (canvas->canvas_height)

#define X_90_DEGR(canvas, x, y)     (canvas->canvas_top - y)
#define Y_90_DEGR(canvas, x, y)     (canvas->canvas_left + x)
#define W_90_DEGR(canvas)           (canvas->canvas_height)
#define H_90_DEGR(canvas)           (canvas->canvas_width)

#define X_180_DEGR(canvas, x, y)    (canvas->canvas_left - x)
#define Y_180_DEGR(canvas, x, y)    (canvas->canvas_top - y)
#define W_180_DEGR(canvas)          (canvas->canvas_width)
#define H_180_DEGR(canvas)          (canvas->canvas_height)

#define X_270_DEGR(canvas, x, y)    (canvas->canvas_top + y)
#define Y_270_DEGR(canvas, x, y)    (canvas->canvas_left - x)
#define W_270_DEGR(canvas)          (canvas->canvas_height)
#define H_270_DEGR(canvas)          (canvas->canvas_width)


/* lookup table for f(x) = sin(x) * 2^16  (x = 0 to 45 degrees)*/
extern uint16_t _sin_degrees_lut[46];

struct _graphics_s
{
    void           *drv;
    int            drv_id;
    void           *(*drv_open)(unsigned int id);
    void           (*load_palette)(void *drv, color_t *palette);
    const font_t   *default_font;     
    bool           (*screen_is_set)(void *drv);
    void           (*set_screen)(void *drv, uintptr_t screen);
    uintptr_t      (*get_screen)(void *drv);
    unsigned       width;
    unsigned       height;
    canvas_t       *visible_canvas;
    canvas_t       canvases[4];
    int            rotation;
    color_format_t color_format;
    uint8_t        canvas_count;
    bool           initialized;
};


extern graphics_t graphics_table[];

/**
 * @brief
 *      Windows bitmap file-header structure
 *
 * This structure contains information about the bitmap file.
 */

typedef struct
{
    char type[2];           /**< Start of header "BM" */
    uint8_t size[4];
    uint8_t reserved[4];
    uint8_t offset[4];
} bmfileheader_t;           /* size = 14 */


/**
 * @brief
 *      Windows bitmap info-header structure
 *
 * This structure contains information about the bitmap.
 */

typedef struct
{
    uint8_t size[4];
    uint8_t width[4];
    uint8_t height[4];
    uint8_t planes[2];
    uint8_t bitcount[2];
    uint8_t compression[4];
    uint8_t imagesize[4];
    uint8_t xppm[4];
    uint8_t yppm[4];
    uint8_t colorused[4];
    uint8_t colorimportant[4];
} bminfoheader_t;           /* size = 40 */


/**
 * @brief
 *      Windows bitmap color structure
 *
 * This structure contains RGB levels to define a color.
 */

typedef struct
{
    uint8_t blue;
    uint8_t green;
    uint8_t red;
    uint8_t reserved;
} bmrgb_t;                  /* size = 4 */


/**
 * @brief
 *      Windows bitmap structure
 *
 * This structure contains a bitmap.
 */

struct _graphics_bitmap_s
{
    bmfileheader_t bmfh;    // bitmap file header
    bminfoheader_t bmih;    // bitmap info header
    uint8_t data[];         // color data and pixel data
};


extern int _graphics_unset_rotation(canvas_t * restrict canvas);

#endif

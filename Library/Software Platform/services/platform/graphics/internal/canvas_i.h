#ifndef _CANVAS_I_H
#define _CANVAS_I_H

#include <canvas.h>
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


struct _canvas_s
{
    uintptr_t      buffer;
    void           (*draw_pixel)(struct _canvas_s const * canvas, int x, int y, color_t color);
    void           (*draw_pixel_alpha)(struct _canvas_s const * canvas, int x, int y, color_t color, uint8_t alpha);
    color_t        (*get_pixel)(struct _canvas_s const * canvas, int x, int y);
    void           (*draw_horizontal)(struct _canvas_s const * canvas, int left, int right, int y, color_t color);
    void           (*draw_vertical)(struct _canvas_s const * canvas, int x, int top, int bottom, color_t color);
    color_t        (*convert_color_to_native)(color_t color);
    color_t        (*convert_color_from_native)(color_t color);
    int            buffer_width;              // width of the unrotated parent screen
    int            buffer_height;             // height of the unrotated parent screen
    int            canvas_left;               // left of the unrotated parent screen
    int            canvas_top;                // top of the unrotated parent screen
    int            canvas_width;       // width of the rotated canvas
    int            canvas_height;      // height of the rotated canvas
    int            pane_left;          // left of drawable window,   coordinate in unrotated screen
    int            pane_top;           // top of drawable window,    coordinate in unrotated screen
    int            pane_right;         // right of drawable window,  coordinate in unrotated screen
    int            pane_bottom;        // bottom of drawable window, coordinate in unrotated screen
    const font_t   *default_font;
    color_format_t color_format;
    uint16_t       rotation;
    uint8_t        allocation_type;
    bool           locked;
};

extern int _canvas_unset_rotation(canvas_t * restrict canvas);

#endif

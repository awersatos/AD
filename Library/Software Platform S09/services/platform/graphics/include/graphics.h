/**
 * @file
 * Service for graphics routines.
 * 
 * It provide routines for most low level drawing functionality.
 * This includes pixels, lines, rectangles, triangles, circles, arcs, characters and related routines.
 *
 * This service will run on a vga driver like drv_vga_tft or drv_vga_1to8bpp. The graphics service will
 * load the SVG-palette in case of a paletted driver with 8-bit color depth (256 colors).
 * When using SVG colornames, both paletted driver and 16-bit drivers will reproduce the same colors,
 * within the limitations of the driver. For a full list of colors, see svg_colors.h.
 * SVG colornames are in UPPERCASE and without spaces.
 *
 * Support for double buffering and diffferent color depths relays on the functionality of the driver beneath.
 *
 */

#ifndef _GRAPHICS_H
#define _GRAPHICS_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

#ifndef _COLOR_T_DEF
typedef uint32_t        color_t;
#define _COLOR_T_DEF
#endif

#include <svg_colors.h>

/**
 * @brief
 *      Font styles
 *
 * This enum defines the different font styles.
 *
 * @see
 *      graphics_draw_char(), graphics_get_stringwidth(), graphics_get_charwidth()
 */

typedef enum
{
    FS_NONE,            /**< Unaltered */
    FS_BOLD,            /**< Bold */
    FS_ITALIC,          /**< Italic */
    FS_BOLD_ITALIC      /**< Bold and Italic */
} fontstyle_t;


/**
 * @brief
 *      Color formats
 *
 * This enum defines the supported color formats.
 *
 * @see
 *      canvas_create(), canvas_initialize(), graphics_get_color_format()
 */

typedef enum
{
    COLOR_INVALID  = 0,     /**< invalid color format */
    COLOR_PALETTE1 = 1,     /**< 1 bpp Palette, 2 colors */
    COLOR_PALETTE2 = 2,     /**< 2 bpp Palette, 4 colors */
    COLOR_PALETTE4 = 4,     /**< 4 bpp Palette, 16 colors */
    COLOR_PALETTE8 = 8,     /**< 8 bpp Palette, 256 colors */
    COLOR_RGB565   = 16     /**< 16 bpp RGB in 5-6-5 format, 65536 colors */
} color_format_t;


typedef struct _font_s font_t;

#include <canvas.h>

typedef struct _graphics_s graphics_t;
typedef struct _graphics_bitmap_s graphics_bitmap_t;

/* included fonts */
extern const font_t bitstreamverasans8;
extern const font_t bitstreamverasansmono8;
extern const font_t bitstreamveraserif8;
extern const font_t bitstreamverasans10;
extern const font_t bitstreamverasansmono10;
extern const font_t bitstreamveraserif10;
extern const font_t bpmono8;
extern const font_t bpmono10;

extern graphics_t *graphics_open(unsigned int id);
extern bool graphics_set_visible_canvas(graphics_t * restrict graphics, canvas_t *canvas);
extern canvas_t *graphics_get_visible_canvas(graphics_t const * restrict graphics);
extern canvas_t *graphics_get_canvas(graphics_t * restrict graphics, int index);
extern bool graphics_visible_canvas_is_set(graphics_t * restrict graphics);

extern bool graphics_lock(canvas_t * restrict canvas);
extern void graphics_unlock(canvas_t * restrict canvas);

extern int graphics_set_rotation(graphics_t * restrict graphics, int rotation);
extern int graphics_get_rotation(graphics_t const * restrict graphics);
extern color_format_t graphics_get_color_format(graphics_t const * restrict graphics);
extern int graphics_get_bpp(graphics_t const * restrict graphics);
extern int graphics_get_width(graphics_t const * restrict graphics);
extern int graphics_get_height(graphics_t const * restrict graphics);

extern void graphics_set_pane(canvas_t * restrict canvas, int x, int y, unsigned int width, unsigned int height);
extern void graphics_draw_pixel(canvas_t const * restrict canvas, int x, int y, color_t color);
extern void graphics_draw_pixel_alpha(canvas_t const * restrict canvas, int x, int y, color_t color, uint8_t alpha);
extern color_t graphics_get_pixel(canvas_t const * restrict canvas, int x, int y);
extern void graphics_fill_canvas(canvas_t const * restrict canvas, color_t color);
extern void graphics_draw_line(canvas_t const * restrict canvas, int x1, int y1, int x2, int y2, color_t color);
extern void graphics_fill_rect(canvas_t const * restrict canvas, int x, int y, int width, int height, color_t color);
extern void graphics_fill_triangle(canvas_t const * restrict canvas, int x1, int y1, int x2, int y2, int x3, int y3, color_t color);
extern void graphics_draw_circle(canvas_t const * restrict canvas, int x, int y, unsigned int r, color_t color);
extern void graphics_fill_circle(canvas_t const * restrict canvas, int x, int y, unsigned int r, color_t color);
extern void graphics_draw_arc(canvas_t const * restrict canvas, int x, int y, unsigned int r, int start_angle, int arc_angle, color_t color );
extern void graphics_fill_segment(canvas_t const * restrict canvas, int x, int y, unsigned int r, int start_angle, int segment_angle, color_t color );
extern void graphics_fill_sector(canvas_t const * restrict canvas, int x, int y, unsigned int r, int start_angle, int sector_angle, color_t color );
extern int graphics_draw_char(canvas_t *canvas, int x, int y, const char c, const font_t *font, color_t color, fontstyle_t fontstyle);
extern int graphics_draw_string(canvas_t *canvas, int x, int y, const char *str, const font_t *font, color_t color, fontstyle_t fontstyle);
extern int graphics_get_stringwidth(canvas_t *canvas, const char *str, const font_t *font, fontstyle_t fontstyle );
extern int graphics_get_charwidth(canvas_t *canvas, const char c, const font_t *font, fontstyle_t fontstyle );
extern int graphics_get_fontheight(canvas_t *canvas, const font_t *font);
extern void graphics_draw_bitmap(canvas_t const * restrict canvas, const graphics_bitmap_t *bm, int x, int y, int width, int height, int zoom);
extern void graphics_copy_rect(canvas_t const * restrict canvas, int x, int y, int width, int height, int dx, int dy);

#ifdef  __cplusplus
}
#endif

#endif

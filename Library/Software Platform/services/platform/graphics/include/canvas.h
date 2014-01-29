/**
 * @file
 * Service for graphics routines.
 *
 */

#ifndef _CANVAS_H
#define _CANVAS_H

#ifdef  __cplusplus
extern "C" {
#endif

typedef struct _canvas_s canvas_t;

#include <stdint.h>
#include <stdbool.h>
#include <graphics.h>


#define CANVAS_ROTATION_0           0
#define CANVAS_ROTATION_90          90
#define CANVAS_ROTATION_180         180
#define CANVAS_ROTATION_270         270



extern canvas_t *canvas_create(color_format_t color_format, int width, int height, int rotation, font_t const *default_font);
extern bool canvas_destroy(canvas_t *canvas);
extern bool canvas_initialize(canvas_t * canvas, uintptr_t buffer, color_format_t color_format, int width, int height, int rotation, font_t const *default_font);
extern canvas_t *canvas_extract(const canvas_t * canvas, int left, int top, int width, int height);
extern bool canvas_blit(canvas_t *destination, const canvas_t *source, int left, int top);
extern canvas_t *canvas_copy(const canvas_t *canvas);

extern int canvas_set_rotation(canvas_t * restrict canvas, int rotation);
extern int canvas_get_rotation(canvas_t const * restrict canvas);
extern void canvas_set_default_font(canvas_t * restrict canvas, font_t const * default_font);
extern uintptr_t canvas_get_buffer(canvas_t const * restrict canvas);
extern int canvas_get_height(canvas_t const * restrict canvas);
extern int canvas_get_width(canvas_t const * restrict canvas);
extern unsigned canvas_get_linelength(canvas_t const * restrict canvas);
extern color_format_t canvas_get_color_format(canvas_t const * restrict canvas);
extern int canvas_get_bpp(canvas_t const * restrict canvas);


#ifdef  __cplusplus
}
#endif

#endif

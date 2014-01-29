/*****************************************************************************\
|*
|*  IN PACKAGE:     Graphics
|*
|*  COPYRIGHT:      Copyright (c) 2008, Altium
|*
|*  DESCRIPTION:    Generic routines
|*
 */

#include <stdint.h>
#include <stdbool.h>
#include <assert.h>
#include <graphics.h>
#include <graphics_i.h>
#include "graphics_cfg_instance.h"
#include "graphics_cfg.h"


#define GRAPHICS_INSTANCE_CANVASCOUNT_1 1
#define GRAPHICS_INSTANCE_CANVASCOUNT_2 2
#define GRAPHICS_INSTANCE_CANVASCOUNT_3 3
#define GRAPHICS_INSTANCE_CANVASCOUNT_4 4

graphics_t graphics_table[GRAPHICS_INSTANCE_COUNT];

/*
 * Static function _graphics_set_pane()
 * See below for description
 */

static void _graphics_set_pane(canvas_t * restrict canvas, int x, int y, unsigned int width, unsigned int height)
{
    if (x >= canvas->buffer_width || y >= canvas->buffer_height)
    {
        canvas->pane_left = 0;
        canvas->pane_right = -1;
        canvas->pane_top = 0;
        canvas->pane_bottom = -1;
    }
    else
    {
        if (x < 0)
        {
            width += x;
            x = 0;
        }
        if (y < 0)
        {
            height += x;
            y = 0;
        }
        if (width <= 0 || height <= 0)
        {
            canvas->pane_left = 0;
            canvas->pane_right = -1;
            canvas->pane_top = 0;
            canvas->pane_bottom = -1;
        }
        else
        {
            if ((x + width) > canvas->buffer_width)
            {
                width = canvas->buffer_width - x;
            }
            if ((y + height) > canvas->buffer_height)
            {
                height = canvas->buffer_height - x;
            }
            canvas->pane_left = x;
            canvas->pane_top = y;
            canvas->pane_right = x + width - 1;
            canvas->pane_bottom = y + height - 1;
        }
    }
}


/**
 * @brief    Open an instance of the service
 *
 * This function initializes the service and opens the driver beneath the first time the function is called.
 * Further attemps to open an already opened instance of the service simply returns the same pointer.
 *
 * @param  id  Valid service id
 *
 * @return Service pointer if succesful initialized
 */

graphics_t *graphics_open(unsigned int id)
{
    assert(id < GRAPHICS_INSTANCE_COUNT);

    graphics_t * restrict graphics = &graphics_table[id];
    // get configuration of driver (created by plugin system)
    const graphics_cfg_instance_t * restrict srv_cfg = &graphics_instance_table[id];

    if (graphics->initialized == false)
    {
        if (srv_cfg->default_font == (void*)-1L)
        {
            graphics->default_font = srv_cfg->user_supplied;
        }
        else
        {
            graphics->default_font = srv_cfg->default_font;
        }
        graphics->rotation     = srv_cfg->rotation;

        if (srv_cfg->ad_graphics_size != 0)
        {
            graphics->drv = graphics->drv_open(graphics->drv_id);
            if (graphics->load_palette)
            {
                graphics->load_palette(graphics->drv, svg_colors);
            }
        }

        graphics->color_format = srv_cfg->color_format;
        graphics->width =srv_cfg->canvas_width;
        graphics->height =srv_cfg->canvas_height;
        graphics->canvas_count = (uint8_t)srv_cfg->canvascount;
        graphics->visible_canvas = NULL;

#if GRAPHICS_INSTANCE_CANVASCOUNT_MAX > 0
        if (graphics->canvas_count > 0)
        {
            canvas_initialize(&graphics->canvases[0], (uintptr_t)srv_cfg->canvasbuffer1, graphics->color_format, graphics->width, graphics->height, 0, graphics->default_font);
            canvas_set_rotation(&graphics->canvases[0], graphics->rotation);
        }
#endif

#if GRAPHICS_INSTANCE_CANVASCOUNT_MAX > 1
        if (graphics->canvas_count > 1)
        {
            canvas_initialize(&graphics->canvases[1], (uintptr_t)srv_cfg->canvasbuffer2, graphics->color_format, graphics->width, graphics->height, 0, graphics->default_font);
            canvas_set_rotation(&graphics->canvases[1], graphics->rotation);
        }
#endif

#if GRAPHICS_INSTANCE_CANVASCOUNT_MAX > 2
        if (graphics->canvas_count > 2)
        {
            canvas_initialize(&graphics->canvases[2], (uintptr_t)srv_cfg->canvasbuffer3, graphics->color_format, graphics->width, graphics->height, 0, graphics->default_font);
            canvas_set_rotation(&graphics->canvases[2], graphics->rotation);
        }
#endif

#if GRAPHICS_INSTANCE_CANVASCOUNT_MAX > 3
        if (graphics->canvas_count > 3)
        {
            canvas_initialize(&graphics->canvases[3], (uintptr_t)srv_cfg->canvasbuffer4, graphics->color_format, graphics->width, graphics->height, 0, graphics->default_font);
            canvas_set_rotation(&graphics->canvases[3], graphics->rotation);
        }
#endif

        if (graphics->canvas_count > 0)
        {
            graphics->visible_canvas = &graphics->canvases[0];
            if (graphics->drv)
            {
                graphics->set_screen(graphics->drv, graphics->visible_canvas->buffer);
            }
        }
    }

    return graphics;
}


/**
 * @brief    Lock the canvas
 *
 * This function locks the canvas.
 * If the canvas isn't locked yet, the function marks the canvas as locked and returns true, otherwise it returns false.
 * Call graphics_unlock() to unlock the canvas.
 *
 * The service doesn't check the lock when performing graphics routines, it only assists that no-one else uses the same canvas at the same time.
 *
 * @param  canvas    canvas pointer
 *
 * @return True if this call locked the canvas, false otherwise
 */

bool graphics_lock(canvas_t * restrict canvas)
{
    if (canvas->locked)
    {
        return false;
    }
    else
    {
        canvas->locked = true;
        return true;
    }
}


/**
 * @brief    Unlock the canvas
 *
 * This function unlocks the canvas. From now on another user can lock the canvas
 *
 * @see graphics_lock()
 *
 * @param  canvas    Canvas pointer
 *
 * @return Nothing
 */

void graphics_unlock(canvas_t * restrict canvas)
{
    canvas->locked = false;
}


/**
 * @brief    Set the visible canvas
 *
 * This function sets the visible canvas.
 * The visible canvas is the canvas which contains the data shown by the core beneath.
 * The physical memory where the visible canvas buffer is located must be connected to the core.
 * The requested canvas buffer must have been statically allocated by the graphics instance.
 *
 * @see graphics_visible_canvas_is_set()
 *
 * @param  graphics    Service pointer as returned from graphics_open()
 * @param  canvas      Canvas which is to become the visible canvas
 *
 * @return True if the canvas will become visible, false if the canvas buffer is invalid
 */

bool graphics_set_visible_canvas(graphics_t * restrict graphics, canvas_t *canvas)
{
    bool result = false;

    for (int i = 0; i < graphics->canvas_count; i++)
    {
        if (&graphics->canvases[i] == canvas)
        {
            graphics->visible_canvas = canvas;
            graphics->set_screen(graphics->drv, canvas->buffer);
            result = true;
            break;
        }
    }

    return result;
}


/**
 * @brief    Get the visible canvas
 *
 * This function returns the canvas which contains the data shown by the core beneath.
 *
 * @see graphics_set_visible_canvas()
 *
 * @param  graphics    Service pointer as returned from graphics_open()
 *
 * @return Currently visible canvas
 */

canvas_t *graphics_get_visible_canvas(graphics_t const * restrict graphics)
{
    return graphics->visible_canvas;
}


/**
 * @brief    Get the canvas
 *
 * This function returns the canvas indicated by index.
 *
 * @param  graphics    Service pointer as returned from graphics_open()
 * @param  index       Index of the statically allocated canvas
 *
 * @return Statically allocated canvas or NULL if invalid index
 */

canvas_t *graphics_get_canvas(graphics_t * restrict graphics, int index)
{
    if ((unsigned)index < 4)
    {
        return &graphics->canvases[index];
    }
    return NULL;
}


#if GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1
/**
 * @brief    Set rotation
 *
 * Set the rotation of the canvases. The rotation can be set in multiples of 90 degrees.
 * A positive value indicates a clockwise rotation of the contents.
 *
 * For positive values, if rotation is not a multiple of 90, the value is round down to the nearest multiple of 90.
 * If the value if more than 270, the value is lowered by a multiple of 360 to get a value between 0 and 270 (both inclusive).
 *
 * For negative values, if rotation in not a multiple of 90, the value is round up to the nearest multiple of 90
 * and increamented by a multiple of 360 to get a positive value between 0 and 270 (both inclusive).
 *
 * ||input||rotation (degrees)||
 * |    0 |    0    |
 * |    1 |    0    |
 * |   89 |    0    |
 * |   90 |   90    |
 * |   91 |   90    |
 * |  359 |  270    |
 * |  360 |    0    |
 * |  450 |   90    |
 * |   -1 |    0    |
 * |  -89 |    0    |
 * |  -90 |  270    |
 * |  -91 |  270    |
 * | -359 |   90    |
 * | -360 |    0    |
 * | -450 |  270    |
 *
 * This function sets the pane to full canvas.
 *
 * The new rotation is set to all canvases allocated by this graphics instance.
 *
 * @param  graphics       Service pointer as returned from graphics_open()
 * @param  rotation       New rotation in degrees
 *
 * @return New normalized rotation in degrees
 */

int graphics_set_rotation(graphics_t * restrict graphics, int rotation)
{
    int  r = ((rotation / 90) % 4) * 90;

    if (r < 0) r += 4;
    graphics->rotation = r;

    for (int i = 0; i < graphics->canvas_count; i++)
    {
        canvas_set_rotation(&graphics->canvases[i], r);
    }
    return r;
}
#endif


/**
 * @brief    Get rotation
 *
 * Get the current rotation of the canvases. The rotation is returned in degrees and can only be one of the following values: 0, 90, 180, 270.
 *
 * @param  graphics       Service pointer as returned from graphics_open()
 *
 * @return Current canvases rotation in degrees
 *
 * @see graphics_set_rotation()
 */

int graphics_get_rotation(graphics_t const * restrict graphics)
{
    return graphics->rotation;
}


/**
 * @brief   Set default font
 *
 * Set the default font. The default font is used if, in text related functions, the font parameter is given a NULL pointer.
 *
 * @param  graphics       Service pointer as returned from graphics_open()
 * @param  default_font   Pointer to new default font
 *
 * @return Nothing
 *
 * @see graphics_draw_char(), graphics_draw_string(), graphics_draw_nstring(), graphics_get_stringwidth(), graphics_get_nstringwidth(), graphics_get_charwidth(), graphics_get_fontheight()
 */

void graphics_set_default_font(graphics_t * restrict graphics, font_t const * default_font)
{
    graphics->default_font = default_font;
    for (int i = 0; i < graphics->canvas_count; i++)
    {
        canvas_set_default_font(&graphics->canvases[i], default_font);
    }
}


/**
 * @brief    Get color format
 *
 * Get the color format of the graphics.
 *
 * @param  graphics       Service pointer as returned from graphics_open()
 *
 * @return Color format
 */

color_format_t graphics_get_color_format(graphics_t const * restrict graphics)
{
    return graphics->color_format;
}


/**
 * @brief    Get pixel size
 *
 * Get the size if the pixel in bits
 *
 * @param  graphics       Service pointer as returned from graphics_open()
 *
 * @return bits per pixel
 */

int graphics_get_bpp(graphics_t const * restrict graphics)
{
    switch (graphics->color_format)
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
 * @brief    Get width of connected canvasses
 *
 * Get the width of the statically allocated canvasses of this graphics context.
 *
 * @param  graphics       Pointer to context
 *
 * @return Width of canvasses
 */

int graphics_get_width(graphics_t const * restrict graphics)
{
    return graphics->width;
}


/**
 * @brief    Get height of connected canvasses
 *
 * Get the height of the statically allocated canvasses of this graphics context.
 *
 * @param  graphics       Pointer to context
 *
 * @return Height of canvasses
 */

int graphics_get_height(graphics_t const * restrict graphics)
{
    return graphics->height;
}


/**
 * @brief    Set drawable pane
 *
 * Set the pane in which can be drawn. If coordinates are outside the canvas the pane is cropped to a valid size.
 * To use the functionality, the "Check Coordinates" option in the Graphics Service configurator of the Software
 * Platform document must be checked.
 *
 * If the pane is set and the "Check Coordinates" option is checked,
 * all calls to graphics routines only draw the parts that are inside the pane.
 * The pane settings are cleared and set to full canvas after the rotation is set.
 *
 * Note: An exception is made for graphics_fill_canvas() which always fills the whole canvas, independent of the pane settings.
 *
 * @param  canvas Pointer to canvas for which pane must be set
 * @param  x      Left side of pane
 * @param  y      Top side of pane
 * @param  width  Width of pane
 * @param  height Height of pane
 *
 * @return Nothing
 */

void graphics_set_pane(canvas_t * restrict canvas, int x, int y, unsigned int width, unsigned int height)
{
    switch(canvas->rotation)
    {
#if (GRAPHICS_INSTANCE_ROTATION_0_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_0:
        _graphics_set_pane(canvas, x, y, width, height);
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_90_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_90:
        _graphics_set_pane(canvas, canvas->buffer_width - y - height, x, height, width);
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_180_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_180:
        _graphics_set_pane(canvas, canvas->buffer_width - x - width, canvas->buffer_height - y - height, width, height);
        break;
#endif
#if (GRAPHICS_INSTANCE_ROTATION_270_USED != 0) || (GRAPHICS_INCLUDE_RUNTIME_ROTATION == 1)
    case GRAPHICS_ROTATION_270:
        _graphics_set_pane(canvas, y, canvas->buffer_height - x - width, height, width);
        break;
#endif
    }
}


/**
 * @brief    Check if canvas-switch is performed by the hardware
 *
 * If multiple canvases are available, after a set_visible_canvas this function checks if the
 * hardware core has switched to using the buffer belonging to the newly visibe canvas yet.
 * After the switch has been performed it's safe to draw to the previously visible canvas.
 *
 * @param  graphics    Service pointer as returned from graphics_open()
 *
 * @return true if new canvas is used by the hardware, false otherwise
 */

bool graphics_visible_canvas_is_set(graphics_t * restrict graphics)
{
    return graphics->screen_is_set(graphics->drv);
}


/**
 * @brief    Fill canvas with color
 *
 * Set the color of the whole canvas.
 * The color can be specified as SVG color or as RGB-color.
 * For a complete list of SVG-colors, see SVG_colors.h.
 * For RGB-colors, use the macro RGB(R-value, G-value, B-value).
 *
 * @param  canvas    Service pointer as returned from graphics_open()
 * @param  color  Color as SVG-color or RGB-color.
 *
 * @return Nothing
 */

void graphics_fill_canvas(canvas_t const * restrict canvas, color_t color)
{
    graphics_fill_rect(canvas, 0, 0, canvas->canvas_width, canvas->canvas_height, color);
}


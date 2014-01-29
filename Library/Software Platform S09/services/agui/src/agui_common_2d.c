#include <graphics.h>
#include <agui.h>
#include <agui_i.h>
#include "agui_cfg.h"


/* No public functions insite this file */



#if AGUI_APPEARANCE==AGUI_APPEARANCE_2D

void agui_draw_body_2d(agui_t *agui, int x, int y, int width, int height, bool top, bool bottom, color_t color)
{
    color_t color_out = agui->palette.outline;
    canvas_t *canvas = agui->canvas;
    int x2 = x + width - 1;
    int y2 = y + height - 1;

    if (width <= 0 || height <= 0)
    {
        return;
    }

    if (top)
    {
        graphics_fill_rect( canvas, x + AGUI_CORNER_RADIUS + 1, y + 1, width - 2 * AGUI_CORNER_RADIUS - 2, AGUI_CORNER_RADIUS, color );     // top-middle
        graphics_fill_sector( canvas, x2 - AGUI_CORNER_RADIUS, y + AGUI_CORNER_RADIUS, AGUI_CORNER_RADIUS,   0, 90, color); // top-right
        graphics_fill_sector( canvas, x + AGUI_CORNER_RADIUS, y + AGUI_CORNER_RADIUS, AGUI_CORNER_RADIUS,  90, 90, color); // top-left
        graphics_draw_line( canvas, x + AGUI_CORNER_RADIUS, y, x2 - AGUI_CORNER_RADIUS, y, color_out );   // top
        graphics_draw_arc( canvas, x2 - AGUI_CORNER_RADIUS, y + AGUI_CORNER_RADIUS, AGUI_CORNER_RADIUS,   0, 90, color_out); // top-right
        graphics_draw_arc( canvas, x + AGUI_CORNER_RADIUS, y + AGUI_CORNER_RADIUS, AGUI_CORNER_RADIUS,  90, 90, color_out); // top-left
        y += AGUI_CORNER_RADIUS + 1;
        height -= AGUI_CORNER_RADIUS + 1;
    }
    if (bottom)
    {
        graphics_fill_rect( canvas, x + AGUI_CORNER_RADIUS + 1, y2 - AGUI_CORNER_RADIUS, width - 2 * AGUI_CORNER_RADIUS - 2, AGUI_CORNER_RADIUS, color );   // bottom-middle
        graphics_fill_sector( canvas, x + AGUI_CORNER_RADIUS, y2 - AGUI_CORNER_RADIUS, AGUI_CORNER_RADIUS, 180, 90, color); // bottom-left
        graphics_fill_sector( canvas, x2 - AGUI_CORNER_RADIUS, y2 - AGUI_CORNER_RADIUS, AGUI_CORNER_RADIUS, 270, 90, color); // bottom-right
        graphics_draw_line( canvas, x + AGUI_CORNER_RADIUS, y2, x2 - AGUI_CORNER_RADIUS, y2, color_out );   // bottom
        graphics_draw_arc( canvas, x + AGUI_CORNER_RADIUS, y2 - AGUI_CORNER_RADIUS, AGUI_CORNER_RADIUS, 180, 90, color_out); // bottom-left
        graphics_draw_arc( canvas, x2 - AGUI_CORNER_RADIUS, y2 - AGUI_CORNER_RADIUS, AGUI_CORNER_RADIUS, 270, 90, color_out); // bottom-right
        y2 -= AGUI_CORNER_RADIUS + 1;
        height -= AGUI_CORNER_RADIUS + 1;
    }
    graphics_fill_rect( canvas, x + 1, y, width - 2, height, color ); // middle
    graphics_draw_line( canvas, x, y, x, y2, color_out );             // left
    graphics_draw_line( canvas, x2, y, x2, y2, color_out );           // right
}


void agui_draw_outline_2d(agui_t *agui, int x, int y, int width, int height, bool top, bool bottom)
{
    color_t color_out = agui->palette.outline;
    canvas_t *canvas = agui->canvas;
    int x2 = x + width - 1;
    int y2 = y + height - 1;

    if (top)
    {
        graphics_draw_line( canvas, x + AGUI_CORNER_RADIUS, y, x2 - AGUI_CORNER_RADIUS, y, color_out );   // top
        graphics_draw_arc( canvas, x2 - AGUI_CORNER_RADIUS, y + AGUI_CORNER_RADIUS, AGUI_CORNER_RADIUS,   0, 90, color_out); // top-right
        graphics_draw_arc( canvas, x + AGUI_CORNER_RADIUS, y + AGUI_CORNER_RADIUS, AGUI_CORNER_RADIUS,  90, 90, color_out); // top-left
        y += AGUI_CORNER_RADIUS + 1;
        height -= AGUI_CORNER_RADIUS + 1;
    }
    if (bottom)
    {
        graphics_draw_line( canvas, x + AGUI_CORNER_RADIUS, y2, x2 - AGUI_CORNER_RADIUS, y2, color_out );   // bottom
        graphics_draw_arc( canvas, x + AGUI_CORNER_RADIUS, y2 - AGUI_CORNER_RADIUS, AGUI_CORNER_RADIUS, 180, 90, color_out); // bottom-left
        graphics_draw_arc( canvas, x2 - AGUI_CORNER_RADIUS, y2 - AGUI_CORNER_RADIUS, AGUI_CORNER_RADIUS, 270, 90, color_out); // bottom-right
        y2 -= AGUI_CORNER_RADIUS + 1;
        height -= AGUI_CORNER_RADIUS + 1;
    }
    graphics_draw_line( canvas, x, y, x, y2, color_out );             // left
    graphics_draw_line( canvas, x2, y, x2, y2, color_out );           // right
}

#endif

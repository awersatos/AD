#include <canvas.h>
#include <agui.h>
#include <agui_i.h>


/* No public functions insite this file */



#if AGUI_APPEARANCE==AGUI_APPEARANCE_3D

void agui_draw_outline_3d(agui_t *agui, int x, int y, int width, int height, bool top, bool bottom, relief_t relief)
{
    color_t color1 = agui->palette.lightoutline;
    color_t color2 = agui->palette.darkoutline;
    canvas_t *canvas = agui->canvas;
    int x2 = x + width - 1;
    int y2 = y + height - 1;

    switch (relief)
    {
    case RELIEF_FLAT:
        if (top)
        {
            graphics_draw_line( canvas, x, y, x2, y, color2 );    // top line
        }
        graphics_draw_line( canvas, x, y, x, y2, color2 );        // left line
        graphics_draw_line( canvas, x2, y, x2, y2, color2 );      // right line
        if (bottom)
        {
            graphics_draw_line( canvas, x, y2, x2, y2, color2 );  // bottom line
        }
        break;
    case RELIEF_RAISED:
        if (top)
        {
            graphics_draw_line( canvas, x, y, x2, y, color1 );    // top line
        }
        graphics_draw_line( canvas, x, y, x, y2, color1 );        // left line
        graphics_draw_line( canvas, x2, y, x2, y2, color2 );      // right line
        if (bottom)
        {
            graphics_draw_line( canvas, x, y2, x2, y2, color2 );  // bottom line
        }
        break;
    case RELIEF_LOWERED:
        if (top)
        {
            graphics_draw_line( canvas, x, y, x2, y, color2 );    // top line
        }
        graphics_draw_line( canvas, x, y, x, y2, color2 );        // left line
        graphics_draw_line( canvas, x2, y, x2, y2, color1 );      // right line
        if (bottom)
        {
            graphics_draw_line( canvas, x, y2, x2, y2, color1 );  // bottom line
        }
        break;
    default:
        break;
    }
}


void agui_draw_body_3d(agui_t *agui, int x, int y, int width, int height, bool top, bool bottom, relief_t relief, color_t color)
{
    color_t color1 = agui->palette.lightoutline;
    color_t color2 = agui->palette.darkoutline;
    canvas_t *canvas = agui->canvas;
    int x2 = x + width - 1;
    int y2 = y + height - 1;

    switch (relief)
    {
    case RELIEF_FLAT:
        if (top)
        {
            graphics_draw_line( canvas, x, y, x2, y, color2 );    // top line
            y++;
            height--;
        }
        graphics_draw_line( canvas, x, y, x, y2, color2 );        // left line
        graphics_draw_line( canvas, x2, y, x2, y2, color2 );      // right line
        if (bottom)
        {
            graphics_draw_line( canvas, x, y2, x2, y2, color2 );  // bottom line
            height--;
        }
        graphics_fill_rect(canvas, x+1, y, width-2, height, color);
        break;
    case RELIEF_RAISED:
        graphics_fill_rect(canvas, x+1, y, width-2, height, color);
        if (top)
        {
            graphics_draw_line( canvas, x, y, x2, y, color1 );    // top line
        }
        graphics_draw_line( canvas, x, y, x, y2, color1 );        // left line
        graphics_draw_line( canvas, x2, y, x2, y2, color2 );      // right line
        if (bottom)
        {
            graphics_draw_line( canvas, x, y2, x2, y2, color2 );  // bottom line
        }
        break;
    case RELIEF_LOWERED:
        graphics_fill_rect(canvas, x+1, y, width-2, height, color);
        if (top)
        {
            graphics_draw_line( canvas, x, y, x2, y, color2 );    // top line
        }
        graphics_draw_line( canvas, x, y, x, y2, color2 );        // left line
        graphics_draw_line( canvas, x2, y, x2, y2, color1 );      // right line
        if (bottom)
        {
            graphics_draw_line( canvas, x, y2, x2, y2, color1 );  // bottom line
        }
        break;
    default:
        graphics_fill_rect(canvas, x, y, width, height, color);
        break;
    }
}

#endif

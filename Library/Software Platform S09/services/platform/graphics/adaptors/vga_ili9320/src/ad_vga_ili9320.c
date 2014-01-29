#include "ad_vga_ili9320_cfg_instance.h"
#include "drv_vga_ili9320_cfg_instance.h"
#include "graphics_cfg_instance.h"
#include "graphics_cfg.h"
#include <graphics_i.h>
#include <drv_vga_ili9320.h>

void vga_ili9320_init_canvas(canvas_t *canvas, void *drv);


void ad_vga_ili9320_init(void)
{
    int id;

    for (int drv_id = 0; drv_id < DRV_VGA_ILI9320_INSTANCE_COUNT; drv_id++)
    {
        id = ad_vga_ili9320_instance_table[drv_id].ad_graphics;

        graphics_table[id].drv_id             = drv_id;
        graphics_table[id].drv_open           = (void*)vga_ili9320_open;
        graphics_table[id].screen_is_set      = (void*)vga_ili9320_screen_set;
        graphics_table[id].set_screen         = (void*)vga_ili9320_set_screen;
        graphics_table[id].get_screen         = (void*)vga_ili9320_get_screen;
    }
}


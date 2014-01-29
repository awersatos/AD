#include "ad_vga_16bpp_cfg_instance.h"
#include "drv_vga_16bpp_cfg_instance.h"
#include "graphics_cfg_instance.h"
#include "graphics_cfg.h"
#include <graphics_i.h>
#include <drv_vga_16bpp.h>
#include <stdbool.h>


void ad_vga_16bpp_init(void)
{
    int id;

    for (int drv_id = 0; drv_id < DRV_VGA_16BPP_INSTANCE_COUNT; drv_id++)
    {
        id = ad_vga_16bpp_instance_table[drv_id].ad_graphics;

        graphics_table[id].drv_id             = drv_id;
        graphics_table[id].drv_open           = (void*)vga_16bpp_open;
        graphics_table[id].screen_is_set      = (void*)vga_16bpp_vsync_passed;
        graphics_table[id].set_screen         = (void*)vga_16bpp_set_screen;
        graphics_table[id].get_screen         = (void*)vga_16bpp_get_screen;
    }
}




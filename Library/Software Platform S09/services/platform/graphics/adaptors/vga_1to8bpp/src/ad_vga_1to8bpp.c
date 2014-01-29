#include "ad_vga_1to8bpp_cfg_instance.h"
#include "drv_vga_1to8bpp_cfg_instance.h"
#include "graphics_cfg_instance.h"
#include "graphics_cfg.h"
#include <graphics_i.h>
#include <drv_vga_1to8bpp.h>


void ad_vga_1to8bpp_init(void)
{
    int id;

    for (int drv_id = 0; drv_id < DRV_VGA_1TO8BPP_INSTANCE_COUNT; drv_id++)
    {
        id = ad_vga_1to8bpp_instance_table[drv_id].ad_graphics;

        graphics_table[id].drv_id             = drv_id;
        graphics_table[id].drv_open           = (void*)vga_1to8bpp_open;
        graphics_table[id].screen_is_set      = (void*)vga_1to8bpp_vsync_passed;
        graphics_table[id].set_screen         = (void*)vga_1to8bpp_set_screen;
        graphics_table[id].get_screen         = (void*)vga_1to8bpp_get_screen;
        graphics_table[id].load_palette       = (void*)vga_1to8bpp_load_palette;
    }
}



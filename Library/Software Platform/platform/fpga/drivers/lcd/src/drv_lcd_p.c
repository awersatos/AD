/*
 * %W% %E%
 */

#include <stdint.h>

#include <drv_lcd_p.h>
#include <drv_lcd_cfg.h>

struct _drv_lcd_t lcds[DRV_LCD_INSTANCE_COUNT];

void lcd_set_baseaddress(int id, uint32_t baseaddress)
{
    if (id >= 0 && id < DRV_LCD_INSTANCE_COUNT)
    {
        lcds[id].baseaddress = baseaddress;
    }
}

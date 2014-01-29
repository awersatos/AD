/**
 * @file
 *
 * @brief
 *      lcd driver adaptor for lcdctrl_sram
 */

#include "lcdctrl_sram_to_lcd_cfg_instance.h"
#include "per_lcdctrl_sram_cfg_instance.h"
#include "drv_lcd_cfg.h"

#include <assert.h>
#include <drv_lcd_p.h>

/**
 * @brief   initialization routine that informs the lcd driver of the
 *          base address of the lcdctrl_sram peripheral.
 *
 * @param   none
 * @return  none
 */
void lcdctrl_sram_to_lcd_init(void)
{
    for (int i = 0; i < DRV_LCD_INSTANCE_COUNT; i++)
    {
        assert(per_lcdctrl_sram_instance_table[lcdctrl_sram_to_lcd_instance_table[i].per_lcdctrl_sram].baseaddress != 0);
		lcd_set_baseaddress(
                lcdctrl_sram_to_lcd_instance_table[i].lcd_adaptor,
                per_lcdctrl_sram_instance_table[lcdctrl_sram_to_lcd_instance_table[i].per_lcdctrl_sram].baseaddress);
    }
}


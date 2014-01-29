/**
 * @file
 *
 * @brief
 *      WB_LCDCTRL_SRAM and WB_LCDCTRL peripheral
 *
 * This interface provides direct access to the WB_LCDCTRL_SRAM and
 * WB_LCDCTRL_SRAM peripheral.
 *
 * For a detailed description of the LCDCTRL peripheral, see the Core
 * Reference <a href="CR0107 LCD Controller.PDF">LCD Controller</a>.
 */

#ifndef _PER_LCD_H
#define _PER_LCD_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>

#define LCD_BASE(base) ((volatile unsigned char *) base)
#define LCD_CTRL(base) LCD_BASE(base)[0]
#define LCD_DATA(base) LCD_BASE(base)[1]

extern unsigned char lcd_basic_read_ctrl(uint32_t base);
extern unsigned char lcd_basic_read_data(uint32_t base);
extern void lcd_basic_write_ctrl(uint32_t base, unsigned char value);
extern void lcd_basic_write_data(uint32_t base, unsigned char value);

#ifdef  __cplusplus
}
#endif

#endif /* ndef _PER_LCD_H */


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

#include <per_lcd.h>

#ifdef __CPPC__
/* copied from dsf (llpi_config.h), no idea why this is/isn't necessary */
#include <pal.h>
#define LCD_RW_DELAY    pal_delay_ns(1600)
#else
#define LCD_RW_DELAY
#endif

/**
 * @brief   read one character from the lcd ctrl register
 *
 * @param   base    base address of lcd device
 *
 * @return  character read form the lcd ctrl register
 */
unsigned char
lcd_basic_read_ctrl(uint32_t base)
{
    unsigned char ret;

    ret = LCD_CTRL(base);
    LCD_RW_DELAY;

    return ret;
}

/**
 * @brief   read one character from the lcd data register
 *
 * @param   base    base address of lcd device
 *
 * @return  character read form the lcd data register
 */
unsigned char
lcd_basic_read_data(uint32_t base)
{
    unsigned char ret;

    ret = LCD_DATA(base);
    LCD_RW_DELAY;

    return ret;
}

/**
 * @brief   write one character to the lcd ctrl register
 *
 * @param   base    base address of lcd device
 * @param   value   value to write to lcd ctrl register
 *
 * @return  none
 */
void
lcd_basic_write_ctrl(uint32_t base, unsigned char value)
{
    LCD_CTRL(base) = value;
    LCD_RW_DELAY;
}

/**
 * @brief   write one character to the lcd data register
 *
 * @param   base    base address of lcd device
 * @param   value   value to write to lcd data register
 *
 * @return  none
 */
void
lcd_basic_write_data(uint32_t base, unsigned char value)
{
    LCD_DATA(base) = value;
    LCD_RW_DELAY;
}


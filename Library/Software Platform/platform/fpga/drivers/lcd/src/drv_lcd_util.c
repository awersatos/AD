/**
 * @file
 *
 * @brief
 *      utility routines for lcd peripheral driver
 */

#include <drv_lcd.h>
#include <stdbool.h>
#include <stddef.h>

#include <pal.h>

#include <drv_lcd_util.h>
#include <per_lcd.h>
#include "drv_lcd_p.h"

/**
 * @brief   initialize the LCD controller
 *
 * @param   drv     lcd driver
 *
 * @return  none
 */
void
lcd_init(drv_lcd_t *drv)
{
    pal_delay_ms(20);                    // wait for more than 15ms after powerup

    lcd_write_ctrl(drv, 0x38);          // Function set 8 Bit
    pal_delay_ms(8);                    // wait for another 8 ms

    lcd_write_ctrl(drv, 0x38);          // Function set 8 Bit
    pal_delay_ms(2);                    // wait for another 2 ms

    lcd_write_ctrl(drv, 0x38);          // Function set 8 Bit
    pal_delay_us(200);

    lcd_write_ctrl(drv, 0x38);          // Function set 8 Bit, 2 lines, 5X7 dots
    pal_delay_us(200);

    lcd_write_ctrl(drv, 0x06);          // Display Off, Cursor off, Blink off
    pal_delay_us(200);

    lcd_write_ctrl(drv, 0x0E);          // Display on, Cursor On

    lcd_write_ctrl(drv, 0x01);          // Clear Display
    pal_delay_us(1640);
}


/**
 * @brief   wait while lcd is busy
 *
 * @param   drv     lcd driver
 *
 * @return  none
 */
void
lcd_wait_while_busy(drv_lcd_t *drv)
{
    while(lcd_basic_read_ctrl(drv->baseaddress) & 0x80);
}


/**
 * @brief   direct access routine to write control data to the lcd
 *
 * @param   drv     lcd driver
 * @param   c       control charater for lcd
 *
 * @return  none
 */
void
lcd_write_ctrl(drv_lcd_t *drv, unsigned char c)
{
    lcd_wait_while_busy (drv);
    lcd_basic_write_ctrl(drv->baseaddress, c);
}


/**
 * @brief   direct access routine to write data to lcd
 *
 * @param   drv     lcd driver
 * @param   c       control data for lcd
 *
 * @return  none
 */
void
lcd_write_data(drv_lcd_t *drv, unsigned char c)
{
    lcd_wait_while_busy (drv);
    lcd_basic_write_data(drv->baseaddress, c);
}


/**
 * @brief   clear lcd screen
 *
 * @param   drv     lcd driver
 *
 * @return  none
 */
void
lcd_clear_screen(drv_lcd_t *drv)
{
    lcd_wait_while_busy (drv);
    lcd_basic_write_ctrl(drv->baseaddress, 0x01);
    #ifdef __PPC__
    pal_delay_us(1640);
    #endif
}


/**
 * @brief   control Cursor appearance
 *
 * @param   drv     lcd driver
 * @param   visible set visibility of the cursor
 * @param   blink   set blink state for the cursor
 *
 * @return  none
 */
void
lcd_set_cursor(drv_lcd_t *drv, bool visible, bool blink)
{
    unsigned char data = 0x0C; // display on

    lcd_wait_while_busy(drv);
    if (visible)
    {
        data |= 0x02;
    }
    if (blink)
    {
        data |= 0x01;
    }
    lcd_basic_write_ctrl(drv->baseaddress, data);
}


/**
 * @brief   get Cursor appearance
 *
 * @param   drv     lcd driver
 * @param   visible pointer to location to store value of cursor visibility, or NULL
 * @param   blink   pointer to location to store cursor blink state, or NULL
 *
 * @return none
 */
void
lcd_get_cursor(drv_lcd_t *drv, bool *visible, bool *blink)
{
    unsigned char data;

    lcd_wait_while_busy(drv);
    data = lcd_basic_read_ctrl(drv->baseaddress);
    if (visible != NULL)
    {
        *visible = (data & 0x02) ? true : false;
    }
    if (blink != NULL)
    {
        *blink = (data & 0x01) ? true : false;
    }
}


/**
 * @brief   set cursor position
 *
 * @param   drv     lcd driver
 * @param   x       x for cursor location
 * @param   y       y for cursor location
 *
 * @return  none
 */
void
lcd_goto_xy(drv_lcd_t *drv, unsigned int x, unsigned int y)
{
    unsigned char c;
    lcd_wait_while_busy(drv);
    c = 0x80 | (x + 0x40* y);
    lcd_basic_write_ctrl(drv->baseaddress, c);
}


/**
 * @brief   get raw location data
 *
 * @param   drv     lcd driver
 *
 * @return  x y
 */
unsigned char
lcd_get_addr(drv_lcd_t *drv)
{
    lcd_wait_while_busy(drv);
    return lcd_basic_read_ctrl(drv->baseaddress) & 0x7F;
}


/**
 * @brief   get current cursor location
 *
 * @param   drv     lcd driver
 * @param   x       pointer to location to store x part of cursor location, or NULL
 * @param   y       pointer to location to store y part of cursor loaction, or NULL
 *
 * @return  none
 */
void
lcd_get_xy(drv_lcd_t *drv, unsigned int *x, unsigned int *y)
{
    unsigned char addr;

    lcd_wait_while_busy(drv);
    addr = lcd_basic_read_ctrl(drv->baseaddress);
    if (x != NULL)
    {
        *x = addr & 0x0F;
    }
    if (y != NULL)
    {
        *y = (addr & 0x70) >> 6;
    }
}


/**
 * @brief   direct access routine to write data to the lcd
 *
 * @param   drv     lcd driver
 * @param   c       charater for lcd
 *
 * @return  none
 */
void
lcd_write_char(drv_lcd_t *drv, unsigned char c)
{
    lcd_wait_while_busy(drv);
    lcd_basic_write_data(drv->baseaddress, c);
}


/**
 * @brief   direct access to write a line to the lcd (no character conversions)
 *
 * @param   drv     lcd driver
 * @param   line    lcd line number
 * @param   msg     '\0' terminated line to write to lcd (current implementation restircts line length to 16 characters)
 *
 * @return  none
 */
void
lcd_output_string(drv_lcd_t *drv, unsigned int line, unsigned char * msg)
{
    unsigned char c;

    lcd_goto_xy(drv, 0, line);

    for (int i = 0; (i < 16) && (c = *msg++ ); i++)
    {
        lcd_write_char(drv, c);
    }
}


/**
 * @brief   shift displayed data a number of places to the left (negative) or right (positive)
 *
 * @param   drv     lcd driver
 * @param   places  number fo places to shift (negative to the left, positive to the right)
 *
 * @return none
 */
void
lcd_shift(drv_lcd_t *drv, int places)
{
    int i;

    if (places > 0)
    {
        for (i = 0; i < places; i++)
        {
            lcd_write_ctrl(drv, 0x18);
        }
    }
    if (places < 0)
    {
        for (i = places; i < 0; i++)
        {
            lcd_write_ctrl(drv, 0x1C);
        }
    }
}


/**
 * @brief   set custom character
 *
 * @param   drv     lcd driver
 * @param   charno  custom character identifier (can be from 0 to 7)
 * @param   data    characer data for custom character.
 *                  array of 8 characters. Only bits 5..0 are significant,
 *                  a set bit indicates dark, cleared light
 *                  top row is first byte (LSB is on right)
 *
 * @return  none
 */
void
lcd_set_custom_char(drv_lcd_t *drv, unsigned int charno, unsigned char *data)
{
    unsigned char addr, i;

    if (charno > 7)
    {
        return;
    }
    addr = 0x40 + (8*charno);
    lcd_wait_while_busy(drv);
    lcd_basic_write_ctrl(drv->baseaddress, addr);
    for(i = 0; i < 8; i++)
    {
        lcd_wait_while_busy(drv);
        lcd_basic_write_data(drv->baseaddress, *data++);
    }
    // ???
    lcd_goto_xy(drv, 0, 0);  // set DD ram Address again

    lcd_goto_xy(drv, 0, 0);  // set DD ram Address again
}


/**
 * @brief   set backlight (not supported because this is hardwired in the design)
 *
 * @param   drv     lcd driver
 * @param   on      on/off
 *
 * @return   none
 */
void lcd_set_backlight(drv_lcd_t *drv, bool on)
{
    //LCD_BACKLIGHT = on;
}


/**
 * @brief   get backlight (not supported return false)
 *
 * @param   drv     lcd driver
 *
 * @return   false
 */
bool
lcd_get_backlight(drv_lcd_t *drv)
{
    return false;//LCD_BACKLIGHT;
}


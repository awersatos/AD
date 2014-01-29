/**
 * @file
 *
 * @brief
 *      driver for lcd peripheral
 */

#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <stdint.h>
#include <unistd.h>

#if ( __POSIX_KERNEL__ != 0 )
#include <pthread.h>
#endif

#include <drv_lcd.h>
#include <drv_lcd_p.h>
#include <drv_lcd_cfg.h>
#include <drv_lcd_cfg_instance.h>
#include <per_lcd.h>
#include <drv_lcd_util.h>

/**
 * @brief   open the lcd driver fot the lcd device identied by id
 *
 * @param   id  lcd device to open
 *
 * @return  the opened lcd device, or NULL when there is no such device
 */
drv_lcd_t *
lcd_open(int id)
{
    drv_lcd_t *ret = NULL;
    uint32_t baseaddress;       // is set by during init by adaptor

    if (id >= 0 && id < DRV_LCD_INSTANCE_COUNT)
    {
        ret = &lcds[id];
        baseaddress = ret->baseaddress;
        memset(ret, 0, sizeof(*ret));
        memset(ret->line_buffer, ' ', LINE_MAX);
        ret->line_buffer[LINE_MAX] = '\0';
        ret->column_count = LINE_MAX;
        ret->baseaddress = baseaddress;
        lcd_init(ret);
    }
    return ret;
}


/**
 * @brief   set the number of columns for the device
 *
 * @param   drv     open lcd device
 * @param   columns new value for number of columns
 *
 * @return  0 new value for number of columns is set, -1 in case of error
 */
int
lcd_set_columns(drv_lcd_t *drv, unsigned int columns)
{
    if (columns < 1 || columns > LINE_MAX || drv == NULL)
    {
        return -1;
    }
    drv->column_count = (uint8_t)columns;
    return 0;
}


/**
 * @brief   scroll one row
 *
 * @param   drv     lcd driver
 *
 * @return  none
 */
void
lcd_scroll(drv_lcd_t *drv)
{
    if (drv != NULL)
    {
        if (drv->current_line == 1)
        {
            lcd_output_string(drv, 0, drv->line_buffer);
        }
        lcd_output_string(drv, 1, (unsigned char*)"                ");
        lcd_goto_xy(drv, 0, 1);
        drv->current_line = 1;
        drv->buffer_offset = 0;
        memset(drv->line_buffer, ' ', drv->column_count);
    }
}


/**
 * @brief   write one character
 *          does 'conversion' of '\\n', '\\f', '\\r', '\\b' and '\\t'
 *
 * @param   c       character to write
 * @param   drv     lcd driver
 *
 * @return  c
 */
int
lcd_putc(int c, drv_lcd_t *drv)
{
    if (drv != NULL)
    {
        if (drv->scroll_needed)
        {
            lcd_scroll(drv);
        }
        drv->scroll_needed = 0;
        switch (c)
        {
            case '\n':
                drv->scroll_needed = 1;
                break;
            case '\f':
                lcd_clear_screen(drv);
                break;
            case '\r':
                lcd_goto_xy(drv, 0, drv->current_line);
                drv->buffer_offset = 0;
                break;
            case '\b':
                if (drv->buffer_offset > 0)
                {
                    drv->buffer_offset--;
                    lcd_goto_xy(drv, drv->buffer_offset, drv->current_line);
                }
                break;
            case '\t':
                lcd_putc(' ', drv);
                lcd_putc(' ', drv);
                break;
            default:
                if (drv->buffer_offset >= drv->column_count)
                {
                    lcd_scroll(drv);
                }
                lcd_write_data(drv, (unsigned char)c);
                drv->line_buffer[drv->buffer_offset] = (unsigned char)c;
                drv->buffer_offset++;
        }
    }
    return c;
}


/**
 * @brief   write characters to lcd
 *
 * @param   drv     lcd driver
 * @param   buf     data buffer containing characters to write to lcd
 * @param   nbyte   number of characters in data buffer
 *
 * @return  number of characters written
 */
ssize_t
lcd_write(drv_lcd_t *drv, const void *buf, size_t nbyte)
{
    for (int i = 0; i < nbyte; i++)
    {
        lcd_putc(*(((unsigned char *)buf)+i), drv);
    }
    return nbyte;
}


/**
 * @file
 *
 * @brief
 *      definition of lcd driver private data and routines
 */

#ifndef _DRV_LCD_P_H
#define _DRV_LCD_P_H

#include <stdbool.h>
#include <stdint.h>

#if ( __POSIX_KERNEL__ != 0 )
#include <pthread.h>
#endif

#define LINE_MAX        16

struct _drv_lcd_t
{
    unsigned char       line_buffer[LINE_MAX+1];
    uint8_t             buffer_offset;
    uint8_t             current_line;
    bool                scroll_needed;
    uint8_t             column_count;

    uint8_t             device_id;
    bool                open;
    uint32_t            baseaddress;

#if ( __POSIX_KERNEL__ != 0 )
    pthread_mutex_t     mutex;
#endif
};

extern struct _drv_lcd_t lcds[];

extern void lcd_set_baseaddress(int id, uint32_t baseaddress);

#endif /* ndef _DRV_LCD_P_H */


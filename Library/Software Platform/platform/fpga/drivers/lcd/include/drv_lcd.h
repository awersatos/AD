/**
 * @file
 * Driver for the NB-1 16x2 LCD peripheral
 */

#ifndef _DRV_LCD_H
#define _DRV_LCD_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <unistd.h>

//..............................................................................

typedef struct _drv_lcd_t drv_lcd_t;

//..............................................................................

extern drv_lcd_t    *lcd_open(int id);
extern int          lcd_set_columns(drv_lcd_t *drv, unsigned int columns);
extern void         lcd_scroll(drv_lcd_t *drv);
extern int          lcd_putc(int c, drv_lcd_t *drv);
extern int          lcd_puts(const char *restrict s, drv_lcd_t *drv);
extern ssize_t      lcd_write(drv_lcd_t *drv, const void *buf, size_t nbyte);

//..............................................................................

#ifdef  __cplusplus
}
#endif

#endif /* ndef _DRV_LCD_H */


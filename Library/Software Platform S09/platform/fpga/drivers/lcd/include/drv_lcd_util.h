/**
 * @file
 *
 * @brief
 *      utility routines for lcd peripheral driver
 */

#ifndef _DRV_LCD_UTIL_H
#define _DRV_LCD_UTIL_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <drv_lcd.h>
#include <stdbool.h>


extern void             lcd_init            (drv_lcd_t *drv);
extern void             lcd_wait_while_busy (drv_lcd_t *drv);
extern void             lcd_write_ctrl      (drv_lcd_t *drv, unsigned char c);
extern void             lcd_write_data      (drv_lcd_t *drv, unsigned char c);
extern void             lcd_clear_screen    (drv_lcd_t *drv);
extern void             lcd_set_cursor      (drv_lcd_t *drv, bool visible, bool blink);
extern void             lcd_get_cursor      (drv_lcd_t *drv, bool *visible, bool *blink);
extern void             lcd_goto_xy         (drv_lcd_t *drv, unsigned int x, unsigned int y);
extern unsigned char    lcd_get_addr        (drv_lcd_t *drv);
extern void             lcd_get_xy          (drv_lcd_t *drv, unsigned int *x, unsigned int *y);
extern void             lcd_write_char      (drv_lcd_t *drv, unsigned char c);
extern void             lcd_output_string   (drv_lcd_t *drv, unsigned int line, unsigned char * msg);
extern void             lcd_shift           (drv_lcd_t *drv, int places);
extern void             lcd_set_custom_char (drv_lcd_t *drv, unsigned int charno, unsigned char *data);
extern void             lcd_set_backlight   (drv_lcd_t *drv, bool on);
extern bool             lcd_get_backlight   (drv_lcd_t *drv);

//..............................................................................
// Program custom character bitpattern
// Up to 8 custom characters allowed.
//
// Parameters:
//    charno - Custom character identifier, can be from 0 to 7
//    data   - Array of 8 characters. Only bits 5..0 are significant
//             A set bit indicates dark, cleared light
//             Top row is first byte (*data)
//             LSB is on right
extern void             lcd_set_custom_char (drv_lcd_t *drv, unsigned int charno, unsigned char * data);

#ifdef  __cplusplus
}
#endif

#endif /* ndef _DRV_LCD_UTIL_H */



 /**
 * @file
 * Device driver for VGA32_ILI9320 peripheral.
 *
 * This driver supports the 240x320 pixels TFT-Module. Colors must be in 5-6-5 format.
 * The lower 16bits of the color_t contain the color.
 *
 */

#ifndef _DRV_VGA_ILI9320_H
#define _DRV_VGA_ILI9320_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

#ifndef _COLOR_T_DEF
typedef uint32_t        color_t;
#define _COLOR_T_DEF
#endif

#define VGA_ILI9320_COLOR(R,G,B)    ((((R) & 0xF8) << 8) | (((G) & 0xFC) << 3) | (((B) & 0xF8) >> 3))    // 5-6-5 format
#define ILI9320_WIDTH               240
#define ILI9320_HEIGHT              320
#define ILI9320_BPP                 16

void init_lcd(void);

typedef struct _vga_ili9320_s vga_ili9320_t;

extern vga_ili9320_t *vga_ili9320_open(unsigned int id);
extern void vga_ili9320_set_screen(vga_ili9320_t * restrict drv, uintptr_t screen);
extern bool vga_ili9320_screen_set(vga_ili9320_t * restrict drv);
extern uintptr_t vga_ili9320_get_screen(vga_ili9320_t const * restrict drv);
extern int vga_ili9320_get_width(vga_ili9320_t const * restrict drv);
extern int vga_ili9320_get_height(vga_ili9320_t const * restrict drv);
extern void vga_ili9320_manual_refresh(vga_ili9320_t * drv);
extern void vga_ili9320_set_auto_refresh(vga_ili9320_t * drv, bool auto_refresh);
extern void vga_ili9320_set_refresh_interval(vga_ili9320_t const * restrict drv, int ms);
extern bool vga_ili9320_manual_refresh_done(vga_ili9320_t * drv);


 /**
 * @brief    Get bits per pixel
 *
 * Get the bpp (Bits Per Pixel) of the TFT-module. This function always returns 16.
 *
 * @param  drv  Driver pointer as returned from vga_ili9320_open()
 *
 * @return bpp
 */

inline int vga_ili9320_bits_per_pixel(vga_ili9320_t const * restrict drv)
{
    return ILI9320_BPP;
}

#if __POSIX_KERNEL__ == 0
inline void vga_ili9320_init(void) { /* empty */ }
#else
inline void vga_ili9320_init(void);
#endif

#ifdef  __cplusplus
}
#endif

#endif /* _DRV_VGA_ILI9320_H */



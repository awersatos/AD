
 /**
 * @file
 * Device driver for VGA32_TFT peripheral.
 *
 * This driver supports the 240x320 pixels TFT screen. Colors must be in 5-6-5 format.
 * The lower 16bits of the color_t contain the color.
 *
 */

#ifndef _DRV_VGA_TFT_H
#define _DRV_VGA_TFT_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

#ifndef _COLOR_T_DEF
typedef uint32_t        color_t;
#define _COLOR_T_DEF
#endif

#define VGA_TFT_COLOR(R,G,B)    ((((R) & 0xF8) << 8) | (((G) & 0xFC) << 3) | (((B) & 0xF8) >> 3))    // 5-6-5 format
#define TFT_WIDTH               240
#define TFT_HEIGHT              320
#define TFT_BPP                 16

typedef struct _vga_tft_s vga_tft_t;

extern vga_tft_t *vga_tft_open(unsigned int id);
extern void vga_tft_set_screen(vga_tft_t * restrict drv, uintptr_t screen);
extern uintptr_t vga_tft_get_screen(vga_tft_t const * restrict drv);
extern void vga_tft_watch_for_vsync(vga_tft_t * restrict drv);
extern bool vga_tft_vsync_passed(vga_tft_t * restrict drv);

 /**
 * @brief    Get tft width
 *
 * Get the width of the TFT. This width is the same for both screen and canvas. This function always returns 240.
 *
 * @param  drv  Driver pointer as returned from vga_tft_open()
 *
 * @return Width of screen/canvas
 */

inline int vga_tft_get_width(vga_tft_t const * restrict drv)
{
    return TFT_WIDTH;
}


 /**
 * @brief    Get tft height
 *
 * Get the height of the TFT. This height is the same for both screen and canvas. This function always returns 320.
 *
 * @param  drv  Driver pointer as returned from vga_tft_open()
 *
 * @return Height of screen/canvas
 */

inline int vga_tft_get_height(vga_tft_t const * restrict drv)
{
    return TFT_HEIGHT;
}


 /**
 * @brief    Get bits per pixel
 *
 * Get the bpp (Bits Per Pixel) of the TFT. This function always returns 16.
 *
 * @param  drv  Driver pointer as returned from vga_tft_open()
 *
 * @return bpp
 */

inline int vga_tft_bits_per_pixel(vga_tft_t const * restrict drv)
{
    return TFT_BPP;
}

#if __POSIX_KERNEL__ == 0
inline void vga_tft_init(void) { /* empty */ }
#else
inline void vga_tft_init(void);
#endif

#ifdef  __cplusplus
}
#endif

#endif /* _DRV_VGA_TFT_H */


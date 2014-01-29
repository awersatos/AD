
/**
 * @file
 * Device driver for VGA32_1TO8BPP peripheral.
 *
 * This driver supports display devices up to 1024x768 pixels. Colors must be provided as index of the palette.
 * For this driver, the upper 8 bits of the color_t contain the index, independent from color depth.
 */

#ifndef _DRV_VGA_1TO8BPP_H
#define _DRV_VGA_1TO8BPP_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

#ifndef _COLOR_T_DEF
typedef uint32_t        color_t;
#define _COLOR_T_DEF
#endif

/**
 * @brief
 *      Supported resolutions
 *
 * This enum defines all the possible resolution as can be set by the user.
 *
 * @see
 *      vga_1to8bpp_set_resolution()
 */
typedef enum 
{
    VGA_1TO8BPP_RES_CUSTOM,         /**< Custom resolution */
    VGA_1TO8BPP_RES_320X240,        /**< 320 * 240 */
    VGA_1TO8BPP_RES_640X480,        /**< 640 * 480 */
    VGA_1TO8BPP_RES_800X600,        /**< 800 * 600 */
    VGA_1TO8BPP_RES_1024X768,       /**< 1024 * 768 */
    VGA_1TO8BPP_RES_PAL720X288,     /**< PAL (720 * 288, both fields identical) */
    VGA_1TO8BPP_RES_NTSC720X240     /**< NTSC (720 * 240, both fields identical) */
} vga_1to8bpp_resolution_t;


/**
 * @brief
 *      Supported color depths
 *
 * This enum defines all available color depths.
 *
 * @see
 *      vga_1to8bpp_set_colordepth()
 */
typedef enum 
{
    VGA_1TO8BPP_COLOR_PALETTE8 = 0,        /**< 8 bit per pixel (256 colors) */
    VGA_1TO8BPP_COLOR_PALETTE4 = 1,        /**< 4 bit per pixel (16 colors) */
    VGA_1TO8BPP_COLOR_PALETTE2 = 2,        /**< 2 bit per pixel (4 colors) */
    VGA_1TO8BPP_COLOR_PALETTE1 = 3,        /**< 1 bit per pixel (2 colors) */
} vga_1to8bpp_colordepth_t;

typedef struct _vga_1to8bpp_s vga_1to8bpp_t;

extern vga_1to8bpp_t *vga_1to8bpp_open(unsigned int id);
extern void vga_1to8bpp_set_screen(vga_1to8bpp_t * restrict drv, uintptr_t screen);
extern uintptr_t vga_1to8bpp_get_screen(vga_1to8bpp_t const * restrict drv);
extern void vga_1to8bpp_watch_for_vsync(vga_1to8bpp_t * restrict drv);
extern bool vga_1to8bpp_vsync_passed(vga_1to8bpp_t * restrict drv);
extern void vga_1to8bpp_set_resolution(vga_1to8bpp_t * restrict drv, vga_1to8bpp_resolution_t resolution);
extern int vga_1to8bpp_get_width(vga_1to8bpp_t const * restrict drv);
extern int vga_1to8bpp_get_height(vga_1to8bpp_t const * restrict drv);
extern void vga_1to8bpp_set_colordepth(vga_1to8bpp_t * restrict drv, vga_1to8bpp_colordepth_t colordepth);
extern vga_1to8bpp_colordepth_t vga_1to8bpp_get_colordepth(const vga_1to8bpp_t * restrict drv);
extern void vga_1to8bpp_select_palette(vga_1to8bpp_t * restrict drv, uint8_t index);
extern void vga_1to8bpp_load_palette(vga_1to8bpp_t * restrict drv, color_t *lut);


#if __POSIX_KERNEL__ == 0
inline void vga_1to8bpp_init(void) { /* empty */ }
#else
inline void vga_1to8bpp_init(void);
#endif

#ifdef  __cplusplus
}
#endif

#endif /* _DRV_VGA_1TO8BPP_H */


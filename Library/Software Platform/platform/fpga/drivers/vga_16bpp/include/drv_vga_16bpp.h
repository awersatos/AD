
/**
 * @file
 * Device driver for VGA32_16BPP peripheral.
 *
 * This driver supports display devices up to 1024x768 pixels. Colors must be in 5-6-5 format.
 * The lower 16bits of the color_t contain the color.
 */

#ifndef _DRV_VGA_16BPP_H
#define _DRV_VGA_16BPP_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

#define VGA_16BPP_COLOR(R,G,B)  ((((R) & 0xF8) << 8) | (((G) & 0xFC) << 3) | (((B) & 0xF8) >> 3))    // 5-6-5 format

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
 *      vga_16bpp_set_resolution()
 */
typedef enum 
{
    VGA_16BPP_RES_CUSTOM,         /**< Custom resolution */
    VGA_16BPP_RES_320X240,        /**< 320 * 240 */
    VGA_16BPP_RES_640X480,        /**< 640 * 480 */
    VGA_16BPP_RES_800X600,        /**< 800 * 600 */
    VGA_16BPP_RES_1024X768,       /**< 1024 * 768 */
    VGA_16BPP_RES_PAL720X288,     /**< PAL (720 * 288, both fields identical) */
    VGA_16BPP_RES_NTSC720X240     /**< NTSC (720 * 240, both fields identical) */
} vga_16bpp_resolution_t;

typedef struct _vga_16bpp_s vga_16bpp_t;

extern vga_16bpp_t *vga_16bpp_open(unsigned int id);
extern void vga_16bpp_set_screen(vga_16bpp_t * restrict drv, uintptr_t screen);
extern uintptr_t vga_16bpp_get_screen(vga_16bpp_t const * restrict drv);
extern void vga_16bpp_watch_for_vsync(vga_16bpp_t * restrict drv);
extern bool vga_16bpp_vsync_passed(vga_16bpp_t * restrict drv);
extern void vga_16bpp_set_resolution(vga_16bpp_t * restrict drv, vga_16bpp_resolution_t resolution);
extern int vga_16bpp_get_width(vga_16bpp_t const * restrict drv);
extern int vga_16bpp_get_height(vga_16bpp_t const * restrict drv);


#if __POSIX_KERNEL__ == 0
inline void vga_16bpp_init(void) { /* empty */ }
#else
inline void vga_16bpp_init(void);
#endif

#ifdef  __cplusplus
}
#endif

#endif /* _DRV_VGA_16BPP_H */


/*****************************************************************************\
|*
|*  IN PACKAGE:
|*
|*  COPYRIGHT:          Copyright (c) 2008, Altium
|*
|*  DESCRIPTION:
|*
 */

#include <assert.h>
#include <pal.h>
#include <vga_16bpp_resolutions.h>
#include <interrupts.h>

#include <drv_vga_16bpp_cfg_instance.h>

#include <drv_vga_16bpp.h>
#include <per_vga32_16bpp.h>

#ifndef _PIXEL_T_DEF
typedef uint16_t        pixel_t;
#define _PIXEL_T_DEF
#endif

#define VGA_ENABLED     (VGA32_16BPP_CKDE | VGA32_16BPP_VOP | VGA32_16BPP_HOP | VGA32_16BPP_VSE)
#define VGA_DISABLED    (VGA32_16BPP_CKDE | VGA32_16BPP_VOP | VGA32_16BPP_HOP)


// runtime driver table
static vga_16bpp_t vga_16bpp_table[DRV_VGA_16BPP_INSTANCE_COUNT];


struct _vga_16bpp_s
{
    uintptr_t baseaddress;
    int       vsync_int;
    uintptr_t screen;
    int       width;
    int       height;
    int       resolution;
    bool      vsync_passed;
};


static void _vga_16bpp_set_resolution(vga_16bpp_t * restrict drv, int width, int height, int hor_freq, int vert_freq, int hor_back_porch, int vert_back_porch)
{
    int back_porch;
    int sync;
    int h_len, v_len;
    int cldiv;

    drv->width  = width;
    drv->height = height;

    /* clock divider setting */
    cldiv = 1;
    h_len = PAL_CLOCKHZ / hor_freq;
    while ((h_len / cldiv) > ((width * 2) + (width / 4)))
    {
        cldiv++;
    }

    /* horizontal regiter settings */
    h_len /= cldiv;
    // minimal front- and back-porch is 1us (CLOCK/1000000)
    // horizontal sync is 25% of ( total hor length - minimal front-porch - minimal back-porch - visible length )
    sync = (h_len - (PAL_CLOCKHZ / 500000) / cldiv - width) / 4;
    if (sync > 255)
    {
        sync = 255;
    }
    back_porch = ((PAL_CLOCKHZ / 1000000) / cldiv) + ((h_len - sync - width - (PAL_CLOCKHZ / 500000) / cldiv) * hor_back_porch) / 10;
    if (back_porch > 255)
    {
        back_porch = 255;
    }
    VGA32_16BPP_HTIM_REG(drv->baseaddress) = ((sync - 1) << 24) | ((back_porch - 1) << 16) | (width - 1);

    /* vertical register settings */
    v_len = hor_freq / vert_freq;
    // vertical sync is 6 lines
    sync = 6;
    back_porch = 2 + ((v_len - height - sync - 4) * vert_back_porch) / 10;
    if (back_porch > 255)
    {
        back_porch = 255;
    }
    VGA32_16BPP_VTIM_REG(drv->baseaddress)  = ((sync - 1) << 24) | ((back_porch - 1) << 16) | (height - 1);

    VGA32_16BPP_HVLEN_REG(drv->baseaddress) = ((h_len - 1) << 16) | (v_len - 1);
    VGA32_16BPP_CDIV_REG(drv->baseaddress)   = cldiv - 1;
    VGA32_16BPP_VMBA_REG(drv->baseaddress)  = drv->screen;
    VGA32_16BPP_CTRL_REG(drv->baseaddress)  = drv->screen ? VGA_ENABLED : VGA_DISABLED;
}


// native interrupt wrapper
__INTERRUPT_NATIVE void vga_16bpp_vsync_interrupt(void)
{
    int num = interrupt_get_current();
    vga_16bpp_t * drv = (vga_16bpp_t *) interrupt_native_context(num);
    
    drv->vsync_passed = true;

    // clear interrupt and disable further interrupts
    interrupt_acknowledge(num);
    interrupt_disable(num);
}


/**
 * @brief    Open an instance of the driver
 *
 * This function initializes the VGA32_16BPP core and its driver the first time the function is called.
 * Further attemps to open an already opened instance of the driver simply returns the same pointer.
 *
 * @param  id  Valid driver id
 *
 * @return Driver pointer if succesful initialized
 */

vga_16bpp_t *vga_16bpp_open(unsigned int id)
{
    assert(id < DRV_VGA_16BPP_INSTANCE_COUNT);

    vga_16bpp_t * restrict drv = &vga_16bpp_table[id];
    // get configuration of driver instance (created by plugin system)
    drv_vga_16bpp_cfg_instance_t * restrict drv_cfg = &drv_vga_16bpp_instance_table[id];
    // get configuration of peripheral instance below driver (created by plugin system)
    per_vga32_16bpp_cfg_instance_t * restrict per_cfg = &per_vga32_16bpp_instance_table[drv_cfg->per_vga32_16bpp];

    // copy all configuration needed to driver
    if (drv->baseaddress == 0)
    {
        assert(per_cfg->baseaddress != 0); 
        drv->baseaddress = per_cfg->baseaddress;
        drv->resolution  = drv_cfg->resolution;
        drv->screen      = 0;

        // initialize hardware
        vga_16bpp_set_resolution(drv, drv_cfg->resolution);

        drv->vsync_int = per_cfg->vsync_interrupt;
        if (drv->vsync_int != -1)
        {
            interrupt_register_native(drv->vsync_int, (void*) drv, vga_16bpp_vsync_interrupt);
            interrupt_configure(drv->vsync_int, EDGE_RISING);
            interrupt_acknowledge(drv->vsync_int);
            interrupt_enable(drv->vsync_int);
        }
    }
    
    return drv;
}


/**
 * @brief    Enable controller
 *
 * This function enables the controller.
 * To succeed this function, screen must be initialized.
 *
 * @param  drv    Driver pointer as returned from vga_16bpp_open()
 *
 * @return true if core is enabled, false otherwise
 */

bool vga_16bpp_enable(vga_16bpp_t * restrict drv)
{
    if (drv->screen)
    {
        VGA32_16BPP_CTRL_REG(drv->baseaddress) = VGA_ENABLED;
        return true;
    }
    return false;
}


/**
 * @brief    Disable controller
 *
 * This function disables the controller.
 *
 * @param  drv    Driver pointer as returned from vga_16bpp_open()
 *
 * @return Nothing
 */

void vga_16bpp_disable(vga_16bpp_t * restrict drv)
{
    VGA32_16BPP_CTRL_REG(drv->baseaddress) = VGA_DISABLED;
}


/**
 * @brief    Set the screen location
 *
 * This function sets the location of the screen.
 * The screen is the memory buffer which contains the data shown by the core.
 * The physical memory where the screen is located must be connected to the core.
 *
 * If the screen is set to NULL the controller is disabled, otherwise the controller is enabled.
 *
 * @param  drv    Driver pointer as returned from vga_16bpp_open()
 * @param  screen New location of screen
 *
 * @return Nothing
 */

void vga_16bpp_set_screen(vga_16bpp_t * restrict drv, uintptr_t screen)
{
    VGA32_16BPP_VMBA_REG(drv->baseaddress) = drv->screen = screen;
    VGA32_16BPP_CTRL_REG(drv->baseaddress) = screen ? VGA_ENABLED : VGA_DISABLED;
    drv->vsync_passed = false;
    if (drv->vsync_int != -1)
    {
        interrupt_acknowledge(drv->vsync_int);  // clear pending interrupts
        interrupt_enable(drv->vsync_int);
    }
}


/**
 * @brief    Get the screen location
 *
 * This function returns the location of the screen used by the core.
 *
 * @param  drv  Driver pointer as returned from vga_16bpp_open()
 *
 * @return Location of current screen
 */

uintptr_t vga_16bpp_get_screen(vga_16bpp_t const * restrict drv)
{
    return drv->screen;
}


/**
 * @brief    Watch for vsync
 *
 * This function enables the vsync-interrupt to see if one has passed.
 * Connect the vsync-interrupt and enable global interrupts when this function is used.
 *
 * Use this function in combination with vga_16bpp_vsync_passed().
 *
 * @param   drv  Driver pointer as returned from vga_16bpp_open()
 *
 * @return  Nothing
 *
 * @see     vga_16bpp_vsync_passed()
 */

void vga_16bpp_watch_for_vsync(vga_16bpp_t * restrict drv)
{
    drv->vsync_passed = false;
    if (drv->vsync_int != -1)
    {
        interrupt_acknowledge(drv->vsync_int);  // clear pending interrupts
        interrupt_enable(drv->vsync_int);
    }
}


/**
 * @brief    Check if vsync has passed
 *
 * After a vga_16bpp_watch_for_vsync(), check if the vsync has passed.
 * Connect the vsync-interrupt and enable global interrupts when this function is used.
 *
 * @param   drv   Driver pointer as returned from vga_16bpp_open()
 *
 * @return  true if vsync has passed, false otherwise
 *
 * @see     vga_16bpp_watch_for_vsync()
 */

bool vga_16bpp_vsync_passed(vga_16bpp_t * restrict drv)
{
    return drv->vsync_passed;
}


/**
 * @brief    Get screen and canvas width
 *
 * Get the width of the screen and the canvas, which is the same for both.
 *
 * @param  drv  Driver pointer as returned from vga_16bpp_open()
 *
 * @return Width of screen/canvas
 */

int vga_16bpp_get_width(vga_16bpp_t const * restrict drv)
{
    return drv->width;
}


/**
 * @brief    Get screen and canvas height
 *
 * Get the height of the screen and the canvas, which is the same for both.
 *
 * @param  drv  Driver pointer as returned from vga_16bpp_open()
 *
 * @return Height of screen/canvas
 */

int vga_16bpp_get_height(vga_16bpp_t const * restrict drv)
{
    return drv->height;
}


/**
 * @brief    Set resolution
 *
 * Set the output resolution of the core. Use
 *
 * @param  drv  Driver pointer as returned from vga_16bpp_open()
 * @param  resolution  New resolution
 *
 * @return Height of screen/canvas
 */

void vga_16bpp_set_resolution(vga_16bpp_t * restrict drv, vga_16bpp_resolution_t resolution)
{
    drv_vga_16bpp_cfg_instance_t * restrict drv_cfg = &drv_vga_16bpp_instance_table[0];

    drv->resolution = resolution;
    switch (resolution)
    {
    case VGA_16BPP_RES_CUSTOM:
        _vga_16bpp_set_resolution(drv, drv_cfg->hor_res, drv_cfg->vert_res, drv_cfg->hor_freq, drv_cfg->vert_freq,
                                  drv_cfg->back_porch, drv_cfg->vert_back_porch);
        break;
    case VGA_16BPP_RES_320X240:
        _vga_16bpp_set_resolution(drv, RES_320X240_WIDTH, RES_320X240_HEIGHT, RES_320X240_HOR_FREQ, RES_320X240_VERT_FREQ,
                                  RES_320X240_HOR_BACK_PORCH, RES_320X240_VERT_BACK_PORCH);
        break;
    case VGA_16BPP_RES_640X480:
        _vga_16bpp_set_resolution(drv, RES_640X480_WIDTH, RES_640X480_HEIGHT, RES_640X480_HOR_FREQ, RES_640X480_VERT_FREQ,
                                  RES_640X480_HOR_BACK_PORCH, RES_640X480_VERT_BACK_PORCH);
        break;
    case VGA_16BPP_RES_800X600:
        _vga_16bpp_set_resolution(drv, RES_800X600_WIDTH, RES_800X600_HEIGHT, RES_800X600_HOR_FREQ, RES_800X600_VERT_FREQ,
                                  RES_800X600_HOR_BACK_PORCH, RES_800X600_VERT_BACK_PORCH);
        break;
    case VGA_16BPP_RES_1024X768:
        _vga_16bpp_set_resolution(drv, RES_1024X768_WIDTH, RES_1024X768_HEIGHT, RES_1024X768_HOR_FREQ, RES_1024X768_VERT_FREQ,
                                  RES_1024X768_HOR_BACK_PORCH, RES_1024X768_VERT_BACK_PORCH);
        break;
    case VGA_16BPP_RES_PAL720X288:
        _vga_16bpp_set_resolution(drv, RES_PAL720X288_WIDTH, RES_PAL720X288_HEIGHT, RES_PAL720X288_HOR_FREQ, RES_PAL720X288_VERT_FREQ,
                                  RES_PAL720X288_HOR_BACK_PORCH, RES_PAL720X288_VERT_BACK_PORCH);
        break;
    case VGA_16BPP_RES_NTSC720X240:
        _vga_16bpp_set_resolution(drv, RES_NTSC720X240_WIDTH, RES_NTSC720X240_HEIGHT, RES_NTSC720X240_HOR_FREQ, RES_NTSC720X240_VERT_FREQ,
                                  RES_NTSC720X240_HOR_BACK_PORCH, RES_NTSC720X240_VERT_BACK_PORCH);
        break;
    default:
        break;
    }
}

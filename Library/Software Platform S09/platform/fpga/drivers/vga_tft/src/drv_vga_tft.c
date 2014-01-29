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
#include <stdio.h>
#include <vga_tft_modes.h>
#include <pal.h>
#include <interrupts.h>

#include <drv_vga_tft_cfg_instance.h>

#include <drv_vga_tft.h>
#include <per_vga32_tft.h>

#define PIXEL_FREQ    (5 * 1000 * 1000)

#ifndef _PIXEL_T_DEF
typedef uint16_t        pixel_t;
#define _PIXEL_T_DEF
#endif

#define TFT_ENABLED     (VGA32_TFT_CKDE | VGA32_TFT_VOP | VGA32_TFT_HOP | VGA32_TFT_VSE)
#define TFT_DISABLED    (VGA32_TFT_CKDE | VGA32_TFT_VOP | VGA32_TFT_HOP)

#define TFT_CANVAS_WIDTH    TFT_WIDTH
#define TFT_CANVAS_HEIGHT   TFT_HEIGHT


// runtime driver table
static vga_tft_t tft_table[DRV_VGA_TFT_INSTANCE_COUNT];

struct _vga_tft_s
{
    uintptr_t     baseaddress;
    int           vsync_int;
    uintptr_t     screen;
    volatile bool vsync_passed;
};


// native interrupt wrapper
__INTERRUPT_NATIVE void vga_tft_vsync_interrupt(void)
{
    int num = interrupt_get_current();
    vga_tft_t * drv = (vga_tft_t *) interrupt_native_context(num);

    drv->vsync_passed = true;

    // clear interrupt and disable further interrupts
    interrupt_acknowledge(num);
    interrupt_disable(num);
}


/**
 * @brief    Open an instance of the driver
 *
 * This function initializes the VGA32_TFT core and its driver the first time the function is called.
 * Further attemps to open an already opened instance of the driver simply returns the same pointer.
 *
 * @param  id  Valid driver id
 *
 * @return Driver pointer if succesful initialized
 */

vga_tft_t * vga_tft_open(unsigned int id)
{
    assert(id < DRV_VGA_TFT_INSTANCE_COUNT);

    vga_tft_t * restrict drv = &tft_table[id];
    // get configuration of driver (created by plugin system)
    drv_vga_tft_cfg_instance_t * restrict drv_cfg = &drv_vga_tft_instance_table[id];
    // get configuration peripheral below driver (created by plugin system)
    per_vga32_tft_cfg_instance_t * restrict per_cfg = &per_vga32_tft_instance_table[drv_cfg->per_vga32_tft];

    // copy all configuration needed to driver
    if (drv->baseaddress == 0)
    {
        assert(per_cfg->baseaddress != 0);
        drv->baseaddress = per_cfg->baseaddress;
        drv->screen = 0;

        // initialize hardware
        VGA32_TFT_CTRL_REG(drv->baseaddress)  = TFT_DISABLED;
        VGA32_TFT_CDIV_REG(drv->baseaddress)  = (PAL_CLOCKHZ + PIXEL_FREQ/2) / PIXEL_FREQ;
        VGA32_TFT_HTIM_REG(drv->baseaddress)  = HTIM_TFT;
        VGA32_TFT_VTIM_REG(drv->baseaddress)  = VTIM_TFT;
        VGA32_TFT_HVLEN_REG(drv->baseaddress) = HVLEN_TFT;

        drv->vsync_int = per_cfg->vsync_interrupt;
        if (drv->vsync_int != -1)
        {
            interrupt_register_native(drv->vsync_int, (void*) drv, vga_tft_vsync_interrupt);
            interrupt_configure(drv->vsync_int, EDGE_RISING);
            interrupt_acknowledge(drv->vsync_int);
            interrupt_enable(drv->vsync_int);
        }
    }

    return drv;
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
 * @param  drv    Driver pointer as returned from vga_tft_open()
 * @param  screen New location of screen
 *
 * @return Nothing
 */

void vga_tft_set_screen(vga_tft_t * restrict drv, uintptr_t screen)
{
    VGA32_TFT_VMBA_REG(drv->baseaddress) = drv->screen = screen;
    VGA32_TFT_CTRL_REG(drv->baseaddress)  = screen ? TFT_ENABLED : TFT_DISABLED;
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
 * @param  drv  Driver pointer as returned from vga_tft_open()
 *
 * @return Location of current screen
 */

uintptr_t vga_tft_get_screen(vga_tft_t const * restrict drv)
{
    return drv->screen;
}


/**
 * @brief    Watch for vsync
 *
 * This function enables the vsync-interrupt to see if one has passed.
 * Connect the vsync-interrupt and enable global interrupts when this function is used.
 *
 * Use this function in combination with vga_tft_vsync_passed().
 *
 * @param   drv  Driver pointer as returned from vga_tft_open()
 *
 * @return  Nothing
 *
 * @see     vga_tft_vsync_passed()
 */

void vga_tft_watch_for_vsync(vga_tft_t * restrict drv)
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
 * After a vga_tft_watch_for_vsync(), check if the vsync has passed.
 * Connect the vsync-interrupt and enable global interrupts when this function is used.
 *
 * @param   drv   Driver pointer as returned from vga_tft_open()
 *
 * @return  true if vsync has passed, false otherwise
 *
 * @see     vga_tft_watch_for_vsync()
 */

bool vga_tft_vsync_passed(vga_tft_t * restrict drv)
{
    return drv->vsync_passed;
}


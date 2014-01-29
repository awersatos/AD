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
#include <vga_1to8bpp_resolutions.h>
#include <interrupts.h>

#include <drv_vga_1to8bpp_cfg_instance.h>

#include <drv_vga_1to8bpp.h>
#include <per_vga32.h>

#ifdef __LITTLE_ENDIAN__
#define DEFAULT_CTRL_REG ( VGA32_LITTLEENDIAN | VGA32_CKDE | VGA32_HOP | VGA32_VOP | VGA32_CME )
#else
#define DEFAULT_CTRL_REG ( VGA32_CKDE | VGA32_HOP | VGA32_VOP | VGA32_CME )
#endif

// runtime driver table
static vga_1to8bpp_t vga_1to8bpp_table[DRV_VGA_1TO8BPP_INSTANCE_COUNT];

static void _vga_1to8bpp_set_resolution(vga_1to8bpp_t * restrict drv, int width, int height, int hor_freq, int vert_freq, int hor_back_porch, int vert_back_porch);


struct _vga_1to8bpp_s
{
    uintptr_t                     baseaddress;
    int                           vsync_int;
    uintptr_t                     screen;
    int                           width;
    int                           height;
    vga_1to8bpp_resolution_t      resolution;
    vga_1to8bpp_colordepth_t      colordepth;
    uint8_t                       palette;
    bool                          vsync_passed;
};

// native interrupt wrapper
__INTERRUPT_NATIVE void vga_1to8bpp_vsync_interrupt(void)
{
    int num = interrupt_get_current();
    vga_1to8bpp_t * drv = (vga_1to8bpp_t *) interrupt_native_context(num);

    drv->vsync_passed = true;

    // clear interrupt and disable further interrupts
    interrupt_acknowledge(num);
    interrupt_disable(num);
}


/**
 * @brief    Open an instance of the driver
 *
 * This function initializes the VGA32_1TO8BPP core and its driver the first time the function is called.
 * Further attemps to open an already opened instance of the driver simply returns the same pointer.
 *
 * @param  id  Valid driver id
 *
 * @return Driver pointer if succesful initialized
 */

vga_1to8bpp_t *vga_1to8bpp_open(unsigned int id)
{
    assert(id < DRV_VGA_1TO8BPP_INSTANCE_COUNT);

    vga_1to8bpp_t * restrict drv = &vga_1to8bpp_table[id];
    // get configuration of driver (created by plugin system)
    const drv_vga_1to8bpp_cfg_instance_t * restrict drv_cfg = &drv_vga_1to8bpp_instance_table[id];
    // get configuration peripheral below driver (created by plugin system)
    const per_vga32_cfg_instance_t * restrict per_cfg = &per_vga32_instance_table[drv_cfg->per_vga32];

    // copy all configuration needed to driver
    if (drv->baseaddress == 0)
    {
        assert(per_cfg->baseaddress != 0);
        drv->baseaddress      = per_cfg->baseaddress;
        drv->resolution       = drv_cfg->resolution;
        drv->colordepth       = drv_cfg->color_format;
        drv->palette          = 0;
        drv->screen           = 0;

        // initialize hardware
        vga_1to8bpp_set_resolution(drv, drv_cfg->resolution);   // this function also sets number of active palette
        vga_1to8bpp_set_colordepth(drv, drv->colordepth);
        vga_1to8bpp_select_palette(drv, drv->palette);
        vga_1to8bpp_load_palette(drv, NULL);

        drv->vsync_int = per_cfg->vsync_interrupt;
        if (drv->vsync_int != -1)
        {
            interrupt_register_native(drv->vsync_int, (void*) drv, vga_1to8bpp_vsync_interrupt);
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
 * @param  drv    Driver pointer as returned from vga_1to8bpp_open()
 *
 * @return Nothing
 */

bool vga_1to8bpp_enable(vga_1to8bpp_t * restrict drv)
{
    uint32_t ctrl_reg;

    if (drv->screen)
    {
        ctrl_reg = DEFAULT_CTRL_REG | VGA32_VSE;
        ctrl_reg |= drv->palette ? VGA32_LTB : 0;
        ctrl_reg |= (drv->colordepth & 0x03) << 5;
        VGA32_CTRL_REG(drv->baseaddress) = ctrl_reg;
        return true;
    }
    return false;
}


/**
 * @brief    Disable controller
 *
 * This function disables the controller.
 *
 * @param  drv    Driver pointer as returned from vga_1to8bpp_open()
 *
 * @return Nothing
 */

void vga_1to8bpp_disable(vga_1to8bpp_t * restrict drv)
{
    VGA32_CTRL_REG(drv->baseaddress) = DEFAULT_CTRL_REG;
}


/**
 * @brief    Set the screen location
 *
 * This function sets the location of the screen.
 * The screen is the memory buffer which contains the data shown by the core.
 * The physical memory where the screen is located must be connected to the core.
 *
 * If double-buffering is enabled screen and canvas are at different locations.
 * Both are swapped when the vga_1to8bpp_publish() function is called.
 *
 * If double-buffering is disabled screen and canvas are at the same location,
 * setting the screen also sets the canvas.
 *
 * @param  drv    Driver pointer as returned from vga_1to8bpp_open()
 * @param  screen New location of screen
 *
 * @return Nothing
 */

void vga_1to8bpp_set_screen(vga_1to8bpp_t * restrict drv, uintptr_t screen)
{
    uint32_t ctrl_reg;

    VGA32_VMBA_REG(drv->baseaddress) = drv->screen = screen;

    ctrl_reg = DEFAULT_CTRL_REG;
    ctrl_reg |= drv->palette ? VGA32_LTB : 0;
    ctrl_reg |= (drv->colordepth & 0x03) << 5;
    ctrl_reg |= screen ? VGA32_VSE : 0;
    VGA32_CTRL_REG(drv->baseaddress) = ctrl_reg;

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
 * @param  drv  Driver pointer as returned from vga_1to8bpp_open()
 *
 * @return Location of current screen
 */

uintptr_t vga_1to8bpp_get_screen(vga_1to8bpp_t const * restrict drv)
{
    return drv->screen;
}


/**
 * @brief    Watch for vsync
 *
 * This function enables the vsync-interrupt to see if one has passed.
 * Connect the vsync-interrupt and enable global interrupts when this function is used.
 *
 * Use this function in combination with vga_1to8bpp_vsync_passed().
 *
 * @param   drv  Driver pointer as returned from vga_1to8bpp_open()
 *
 * @return  Nothing
 *
 * @see     vga_1to8bpp_vsync_passed()
 */

void vga_1to8bpp_watch_for_vsync(vga_1to8bpp_t * restrict drv)
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
 * After a vga_1to8bpp_watch_for_vsync(), check if the vsync has passed.
 * Connect the vsync-interrupt and enable global interrupts when this function is used.
 *
 * @param   drv   Driver pointer as returned from vga_1to8bpp_open()
 *
 * @return  true if vsync has passed, false otherwise
 *
 * @see     vga_1to8bpp_watch_for_vsync()
 */

bool vga_1to8bpp_vsync_passed(vga_1to8bpp_t * restrict drv)
{
    return drv->vsync_passed;
}


/**
 * @brief    Get screen and canvas width
 *
 * Get the width of the screen and the canvas, which is the same for both.
 *
 * @param  drv  Driver pointer as returned from vga_1to8bpp_open()
 *
 * @return Width of screen/canvas
 */

int vga_1to8bpp_get_width(vga_1to8bpp_t const * restrict drv)
{
    return drv->width;
}


/**
 * @brief    Get screen and canvas height
 *
 * Get the height of the screen and the canvas, which is the same for both.
 *
 * @param  drv  Driver pointer as returned from vga_1to8bpp_open()
 *
 * @return Height of screen/canvas
 */

int vga_1to8bpp_get_height(vga_1to8bpp_t const * restrict drv)
{
    return drv->height;
}


/**
 * @brief    Set resolution
 *
 * Set the output resolution of the core.
 *
 * @param  drv  Driver pointer as returned from vga_1to8bpp_open()
 * @param  resolution  New resolution
 *
 * @return Nothing
 *
 * @see    vga_1to8bpp_resolution_t
 */

void vga_1to8bpp_set_resolution(vga_1to8bpp_t * restrict drv, vga_1to8bpp_resolution_t resolution)
{
    const drv_vga_1to8bpp_cfg_instance_t * restrict drv_cfg = &drv_vga_1to8bpp_instance_table[0];

    drv->resolution = resolution;
    switch (resolution)
    {
    case VGA_1TO8BPP_RES_CUSTOM:
        _vga_1to8bpp_set_resolution(drv, drv_cfg->hor_res, drv_cfg->vert_res, drv_cfg->hor_freq, drv_cfg->vert_freq,
                                  drv_cfg->back_porch, drv_cfg->vert_back_porch);
        break;
    case VGA_1TO8BPP_RES_320X240:
        _vga_1to8bpp_set_resolution(drv, RES_320X240_WIDTH, RES_320X240_HEIGHT, RES_320X240_HOR_FREQ, RES_320X240_VERT_FREQ,
                                  RES_320X240_HOR_BACK_PORCH, RES_320X240_VERT_BACK_PORCH);
        break;
    case VGA_1TO8BPP_RES_640X480:
        _vga_1to8bpp_set_resolution(drv, RES_640X480_WIDTH, RES_640X480_HEIGHT, RES_640X480_HOR_FREQ, RES_640X480_VERT_FREQ,
                                  RES_640X480_HOR_BACK_PORCH, RES_640X480_VERT_BACK_PORCH);
        break;
    case VGA_1TO8BPP_RES_800X600:
        _vga_1to8bpp_set_resolution(drv, RES_800X600_WIDTH, RES_800X600_HEIGHT, RES_800X600_HOR_FREQ, RES_800X600_VERT_FREQ,
                                  RES_800X600_HOR_BACK_PORCH, RES_800X600_VERT_BACK_PORCH);
        break;
    case VGA_1TO8BPP_RES_1024X768:
        _vga_1to8bpp_set_resolution(drv, RES_1024X768_WIDTH, RES_1024X768_HEIGHT, RES_1024X768_HOR_FREQ, RES_1024X768_VERT_FREQ,
                                  RES_1024X768_HOR_BACK_PORCH, RES_1024X768_VERT_BACK_PORCH);
        break;
    case VGA_1TO8BPP_RES_PAL720X288:
        _vga_1to8bpp_set_resolution(drv, RES_PAL720X288_WIDTH, RES_PAL720X288_HEIGHT, RES_PAL720X288_HOR_FREQ, RES_PAL720X288_VERT_FREQ,
                                  RES_PAL720X288_HOR_BACK_PORCH, RES_PAL720X288_VERT_BACK_PORCH);
        break;
    case VGA_1TO8BPP_RES_NTSC720X240:
        _vga_1to8bpp_set_resolution(drv, RES_NTSC720X240_WIDTH, RES_NTSC720X240_HEIGHT, RES_NTSC720X240_HOR_FREQ, RES_NTSC720X240_VERT_FREQ,
                                  RES_NTSC720X240_HOR_BACK_PORCH, RES_NTSC720X240_VERT_BACK_PORCH);
        break;
    default:
        break;
    }
}


/**
 * @brief    Set color depth
 *
 * Set the colordepth of the core to 1bpp (2 colors), 2bpp(4 colors), 4bpp (16 colors) or 8bpp (256 colors).
 *
 * @param  drv  Driver pointer as returned from vga_1to8bpp_open()
 * @param  colordepth  New color depth
 *
 * @return Nothing
 *
 * @see    vga_1to8bpp_colordepth_t, vga_1to8bpp_get_colordepth()
 */

void vga_1to8bpp_set_colordepth(vga_1to8bpp_t * restrict drv, vga_1to8bpp_colordepth_t colordepth)
{
    uint32_t ctrl_reg;

    ctrl_reg = DEFAULT_CTRL_REG;
    ctrl_reg |= drv->palette ? VGA32_LTB : 0;
    ctrl_reg |= (colordepth & 0x03) << 5;
    ctrl_reg |= drv->screen ? VGA32_VSE : 0;
    VGA32_CTRL_REG(drv->baseaddress) = ctrl_reg;
    drv->colordepth = colordepth;
}


/**
 * @brief    Get color depth
 *
 * Get the current colordepth of the core.
 *
 * @param  drv  Driver pointer as returned from vga_1to8bpp_open()
 *
 * @return Current colordepth
 *
 * @see    vga_1to8bpp_colordepth_t, vga_1to8bpp_set_colordepth()
 */

vga_1to8bpp_colordepth_t vga_1to8bpp_get_colordepth(const vga_1to8bpp_t * restrict drv)
{
    return drv->colordepth;
}


/**
 * @brief    Select palette
 *
 * Choose which of the two palettes is active
 *
 * @param   drv     Driver pointer as returned from vga_1to8bpp_open()
 * @param   index   Number of active palette
 *
 * @return Current colordepth
 *
 * @see    vga_1to8bpp_colordepth_t, vga_1to8bpp_set_colordepth()
 */

void vga_1to8bpp_select_palette(vga_1to8bpp_t * restrict drv, uint8_t index)
{
    uint32_t ctrl_reg;

    ctrl_reg = DEFAULT_CTRL_REG;
    ctrl_reg |= index ? VGA32_LTB : 0;
    ctrl_reg |= (drv->colordepth & 0x03) << 5;
    ctrl_reg |= drv->screen ? VGA32_VSE : 0;
    VGA32_CTRL_REG(drv->baseaddress) = ctrl_reg;
    drv->palette = index;
}


/**
 * @brief    Load palette
 *
 * The palette contains a number of color definitions.
 * The size of the palette depends on the color depth (1 bpp = 2 color, 2bpp = 4 colors, 4bpp = 16 colors, 8bpp = 256 colors).
 * This function loads the selected palette.
 *
 * @param   drv     Driver pointer as returned from vga_1to8bpp_open()
 * @param   palette   pointer to color-palette
 *
 * @return Current colordepth
 *
 * @see    vga_1to8bpp_colordepth_t, vga_1to8bpp_set_colordepth(), vga_1to8bpp_select_palette()
 */

void vga_1to8bpp_load_palette(vga_1to8bpp_t * restrict drv, color_t *palette)
{
    int r,g,b;
    volatile uint32_t *lut;

    lut = drv->palette ? &VGA32_CLUT1(drv->baseaddress) : &VGA32_CLUT0(drv->baseaddress);

    if (!palette)
    {
        switch (drv->colordepth)
        {
        case DRV_VGA_1TO8BPP_COLOR_FORMAT_COLOR_PALETTE1:
            // load black and white
            lut[0] = 0;
            lut[1] = 0x00FFFFFF;
            break;
        case DRV_VGA_1TO8BPP_COLOR_FORMAT_COLOR_PALETTE2:
            // load black, amber, cyan, white,
            lut[0] = 0;
            lut[1] = 0x00FF00FF;
            lut[2] = 0x0000FFFF;
            lut[3] = 0x00FFFFFF;
            break;
        case DRV_VGA_1TO8BPP_COLOR_FORMAT_COLOR_PALETTE4:
            // calculate 16 table entries according RGBI
            for (int i = 0; i < 16; i++)
            {
                if (i == 6)
                {
                    r = 0xAA;
                    g = 0x55;
                    b = 0x00;
                }
                else
                {
                    r = 128*(i & 4)/3 + 32*(i & 8)/3;
                    g = 256*(i & 2)/3 + 32*(i & 8)/3;
                    b = 512*(i & 1)/3 + 32*(i & 8)/3;
                }
                // store color
                lut[i] = r << 16 | g << 8 | b;
            }
            break;
        default:
            // calculate 256 table entries according 3-3-2 RGB
            for (int i = 0; i < 256; i++)
            {
                if (i == 255)
                {
                    b = 0xFF;
                    g = 0xFF;
                    r = 0xFF;
                }
                else
                {
                    b = (i & 0x03) << 6;
                    g = (i & 0x1C) << 3;
                    r = (i & 0xE0);
                }
                // store color
                lut[i] = r << 16 | g << 8 | b;
            }
            break;
        }
    }
    else
    {
        switch (drv->colordepth)
        {
        case DRV_VGA_1TO8BPP_COLOR_FORMAT_COLOR_PALETTE1:
            lut[0] = palette[0];
            lut[1] = palette[1];
            break;
        case DRV_VGA_1TO8BPP_COLOR_FORMAT_COLOR_PALETTE2:
            for (int i = 0; i < 4; i++)
            {
                lut[i] = palette[i];
            }
            break;
        case DRV_VGA_1TO8BPP_COLOR_FORMAT_COLOR_PALETTE4:
            for (int i = 0; i < 16; i++)
            {
                lut[i] = palette[i];
            }
            break;
        default:
            for (int i = 0; i < 256; i++)
            {
                lut[i] = palette[i];
            }
            break;
        }
    }
}


//--------------------------------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
 * STATIC FUNCTIONS
 */
//--------------------------------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------------------------------


static void _vga_1to8bpp_set_resolution(vga_1to8bpp_t * restrict drv, int width, int height, int hor_freq, int vert_freq, int hor_back_porch, int vert_back_porch)
{
    int back_porch;
    int sync;
    int h_len, v_len;
    int cldiv;
    uint32_t ctrl_reg;

    drv->width  = width;
    drv->height = height;

    /* clock divider setting */
    cldiv = 1;
    h_len = PAL_CLOCKHZ / hor_freq;
    while ((h_len / cldiv) > ((width * 2) + (width / 4)))
    {
        cldiv++;
    }

    /* horizontal register settings */
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
    VGA32_HTIM_REG(drv->baseaddress) = ((sync - 1) << 24) | ((back_porch - 1) << 16) | (width - 1);

    /* vertical register settings */
    v_len = hor_freq / vert_freq;
    // vertical sync is 6 lines
    sync = 6;
    back_porch = 2 + ((v_len - height - sync - 4) * vert_back_porch) / 10;
    if (back_porch > 255)
    {
        back_porch = 255;
    }
    VGA32_VTIM_REG(drv->baseaddress)  = ((sync - 1) << 24) | ((back_porch - 1) << 16) | (height - 1);

    VGA32_HVLEN_REG(drv->baseaddress) = ((h_len - 1) << 16) | (v_len - 1);
    VGA32_CDIV_REG(drv->baseaddress)   = cldiv - 1;

    ctrl_reg = DEFAULT_CTRL_REG;
    ctrl_reg |= drv->palette ? VGA32_LTB : 0;
    ctrl_reg |= (drv->colordepth & 0x03) << 5;
    ctrl_reg |= drv->screen ? VGA32_VSE : 0;
    VGA32_CTRL_REG(drv->baseaddress) = ctrl_reg;
    VGA32_VMBA_REG(drv->baseaddress)  = drv->screen;
}



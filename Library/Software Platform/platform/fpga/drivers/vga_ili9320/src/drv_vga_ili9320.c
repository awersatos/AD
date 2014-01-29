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
#include <interrupts.h>

#include <drv_vga_ili9320_cfg_instance.h>

#include <drv_vga_ili9320.h>
#include <per_vga32_ili9320.h>

#ifndef _PIXEL_T_DEF
typedef uint16_t        pixel_t;
#define _PIXEL_T_DEF
#endif

#include <stdint.h>
#include <timing.h>

struct _commands_s
{
    uint16_t reg;
    uint16_t data;
    uint16_t delay;
};

static uint16_t degr_0   = 0x1080;
static uint16_t degr_90  = 0x1098;
static uint16_t degr_180 = 0x10B0;
static uint16_t degr_270 = 0x10A8;

static struct _commands_s init_ili9320[] =
{

    {0x0004, 0x9600, 0},
    {0x0005, 0x0022, 0},

/* Partial Display control */
    {0x0100, 0x0001, 0},
    {0x0101, 0x0000, 0},
    {0x0102, 0x0700, 0},
    {0x0103, 0x1098, 0},    //rotation, register will be overwritten later in init
    {0x0104, 0x0000, 0},
    {0x0108, 0x0202, 0},
    {0x0109, 0x0000, 0},
    {0x010a, 0x0000, 0},
    {0x010c, 0x0000, 0},
    {0x010d, 0x0000, 0},
    {0x010f, 0x0000, 0},

/* Power On sequence */
    {0x0110, 0x0000, 0},
    {0x0111, 0x0000, 0},
    {0x0112, 0x0000, 0},
    {0x0113, 0x0000, 600},
    {0x0110, 0x17b0, 0},
    {0x0111, 0x0131, 150},
    {0x0112, 0x013c, 150},
    {0x0113, 0x1900, 0},
    {0x0129, 0x000f, 0},
    {0x012b, 0x000c, 150},
    {0x0120, 0x0000, 0},
    {0x0121, 0x0000, 0},

/* Adjust the Gamma Curve */
    {0x0130, 0x0002, 0},
    {0x0131, 0x0406, 0},
    {0x0132, 0x0501, 0},
    {0x0135, 0x0206, 0},
    {0x0136, 0x0504, 0},
    {0x0137, 0x0707, 0},
    {0x0138, 0x0306, 0},
    {0x0139, 0x0007, 0},
    {0x013c, 0x0705, 0},
    {0x013d, 0x0700, 0},

/* Set GRAM area */
    {0x0150, 0x0000, 0},
    {0x0151, 0x00ef, 0},
    {0x0152, 0x0000, 0},
    {0x0153, 0x013f, 0},
    {0x0160, 0x2700, 0},
    {0x0161, 0x0001, 0},
    {0x016a, 0x0000, 0},

/* Partial Display Control */
    {0x0180, 0x0000, 0},
    {0x0181, 0x0000, 0},
    {0x0182, 0x0000, 0},
    {0x0183, 0x0000, 0},
    {0x0184, 0x0000, 0},
    {0x0185, 0x0000, 0},

/* Panel Control */
    {0x0190, 0x0010, 0},
    {0x0192, 0x0000, 0},
    {0x0193, 0x0003, 0},
    {0x0195, 0x0110, 0},
    {0x0197, 0x0000, 0},
    {0x0198, 0x0000, 0},

/* Partial Display Control */
    {0x0107, 0x0173, 300}
};

// runtime driver table
static vga_ili9320_t ili9320_table[DRV_VGA_ILI9320_INSTANCE_COUNT];

enum _rs_e{_rs_done, _rs_same_refresh, _rs_same_pending, _rs_diff_pending};   // refresh_state

struct _vga_ili9320_s
{
    uintptr_t           baseaddress;
    int                 int_num;
    uintptr_t           screen;
    int                 rotation;
    volatile enum _rs_e refresh_state;
    bool                auto_refresh;
};


static void _ili9320_write(vga_ili9320_t * drv, uint16_t reg, uint16_t data)
{
    *((volatile uint32_t*) drv->baseaddress + reg) = data;
}


static void _ili9320_init(vga_ili9320_t * drv)
{
    for (int i = 0; i < (sizeof(init_ili9320) / sizeof(init_ili9320[0])); i++)
    {
        _ili9320_write(drv, init_ili9320[i].reg, init_ili9320[i].data);
        delay_ms(init_ili9320[i].delay);
    }
}


// native interrupt wrapper
__INTERRUPT_NATIVE void vga_ili9320_sync_interrupt(void)
{
    int num = interrupt_get_current();
    vga_ili9320_t * drv = (vga_ili9320_t *) interrupt_native_context(num);

    interrupt_acknowledge(num);
    switch (drv->refresh_state)
    {
    case _rs_same_refresh:
        interrupt_disable(num);
        drv->refresh_state = _rs_done;
        break;
    case _rs_same_pending:
        VGA32_ILI9320_REFR_REG( drv->baseaddress ) |= VGA32_ILI9320_RO;
        interrupt_enable(num);
        drv->refresh_state = _rs_same_refresh;
        break;
    case _rs_diff_pending:
        VGA32_ILI9320_REFR_REG( drv->baseaddress ) |= VGA32_ILI9320_RO;
        interrupt_disable(num);
        drv->refresh_state = _rs_done;
        break;
    default:
        interrupt_disable(num);
        drv->refresh_state =_rs_done;
    }
}


/**
 * @brief    Open an instance of the driver
 *
 * This function initializes the VGA32_ILI9320 core and its driver the first time the function is called.
 * Further attemps to open an already opened instance of the driver simply returns the same pointer.
 *
 * @param  id  Valid driver id
 *
 * @return Driver pointer if succesful initialized
 */

vga_ili9320_t *vga_ili9320_open(unsigned int id)
{
    assert(id < DRV_VGA_ILI9320_INSTANCE_COUNT);

    vga_ili9320_t * restrict drv = &ili9320_table[id];
    // get configuration of driver (created by plugin system)
    const drv_vga_ili9320_cfg_instance_t * restrict drv_cfg = &drv_vga_ili9320_instance_table[id];
    // get configuration peripheral below driver (created by plugin system)
    const per_vga32_ili9320_cfg_instance_t * restrict per_cfg = &per_vga32_ili9320_instance_table[drv_cfg->per_vga32_ili9320];

    // copy all configuration needed to driver
    if (drv->baseaddress == 0)
    {
        assert(per_cfg->baseaddress != 0);
        drv->baseaddress = per_cfg->baseaddress;

        // initialize hardware
#ifdef __LITTLE_ENDIAN__
        VGA32_ILI9320_VERSION_REG(drv->baseaddress) = VGA32_ILI9320_LITTLEENDIAN;
#else
        VGA32_ILI9320_VERSION_REG(drv->baseaddress) = 0;
#endif
        VGA32_ILI9320_REFR_REG(drv->baseaddress)   = 0;
        VGA32_ILI9320_PIX_REG(drv->baseaddress)    = 0x9600;
        VGA32_ILI9320_GRAM_REG(drv->baseaddress)   = 0x22;

        assert(PAL_CLOCKHZ < 320000000);    // max clockfreq = 320 MHz

#define W_LOW  ((PAL_CLOCKHZ-1) / 20000000)
#define W_HIGH ((PAL_CLOCKHZ-1) / 20000000)

        if (W_HIGH != 0)
        {
            VGA32_ILI9320_WPULSE_REG(drv->baseaddress) = ((W_HIGH-1) << 4) | W_LOW;
        }
        else
        {
            VGA32_ILI9320_WPULSE_REG(drv->baseaddress) = (W_HIGH << 4) | W_LOW;
        }

        _ili9320_init(drv);

        switch (drv_cfg->rotation)                  // set rotation and clear GRAM Horizontal and Vertical Address
        {
        case 0:
            _ili9320_write(drv, 0x0103, degr_0);
            _ili9320_write(drv, 0x0120, 0);
            _ili9320_write(drv, 0x0121, 0);
            drv->rotation = 0;
            break;
        case 90:
            _ili9320_write(drv, 0x0103, degr_90);
            _ili9320_write(drv, 0x0120, 0);
            _ili9320_write(drv, 0x0121, 0);
            drv->rotation = 90;
            break;
        case 180:
            _ili9320_write(drv, 0x0103, degr_180);
            _ili9320_write(drv, 0x0120, 0);
            _ili9320_write(drv, 0x0121, 0);
            drv->rotation = 180;
            break;
        case 270:
            _ili9320_write(drv, 0x0103, degr_270);
            _ili9320_write(drv, 0x0120, 0);
            _ili9320_write(drv, 0x0121, 0);
            drv->rotation = 270;
            break;
        default:
            break;
        }

        // Set gamma correction

        // Set additional gamma registers if required
        if(drv_cfg->chipset == DRV_VGA_ILI9320_CHIPSET_ILI9320)
        {
            _ili9320_write(drv, 0x0130, (drv_cfg->gammacontrol_2 << 8)  | drv_cfg->gammacontrol_1 );
            _ili9320_write(drv, 0x0131, (drv_cfg->gammacontrol_4 << 8)  | drv_cfg->gammacontrol_3 );
            _ili9320_write(drv, 0x0132, (drv_cfg->gammacontrol_6 << 8)  | drv_cfg->gammacontrol_5 );
            _ili9320_write(drv, 0x0135, (drv_cfg->gammacontrol_8 << 8)  | drv_cfg->gammacontrol_7 );
            _ili9320_write(drv, 0x0136, (drv_cfg->gammacontrol_10 << 8) | drv_cfg->gammacontrol_9 );
            _ili9320_write(drv, 0x0137, (drv_cfg->gammacontrol_12 << 8) | drv_cfg->gammacontrol_11);
            _ili9320_write(drv, 0x0138, (drv_cfg->gammacontrol_14 << 8) | drv_cfg->gammacontrol_13);
            _ili9320_write(drv, 0x0139, (drv_cfg->gammacontrol_16 << 8) | drv_cfg->gammacontrol_15);
            _ili9320_write(drv, 0x013C, (drv_cfg->gammacontrol_18 << 8) | drv_cfg->gammacontrol_17);
            _ili9320_write(drv, 0x013D, (drv_cfg->gammacontrol_20 << 8) | drv_cfg->gammacontrol_19);
        }
        else
        {
            _ili9320_write(drv, 0x0130, (drv_cfg->gammacontrol_1  << 8) | drv_cfg->gammacontrol_6 );
            _ili9320_write(drv, 0x0131, (drv_cfg->gammacontrol_2  << 8) | drv_cfg->gammacontrol_5 );
            _ili9320_write(drv, 0x0132, (drv_cfg->gammacontrol_3  << 8) | drv_cfg->gammacontrol_4 );
            _ili9320_write(drv, 0x0133, (drv_cfg->gammacontrol_4  << 8) | drv_cfg->gammacontrol_3 );
            _ili9320_write(drv, 0x0134, (drv_cfg->gammacontrol_5  << 8) | drv_cfg->gammacontrol_2 );
            _ili9320_write(drv, 0x0135, (drv_cfg->gammacontrol_6  << 8) | drv_cfg->gammacontrol_1 );
            _ili9320_write(drv, 0x0136, (drv_cfg->gammacontrol_7  << 8) | drv_cfg->gammacontrol_8 );
            _ili9320_write(drv, 0x0137, (drv_cfg->gammacontrol_8  << 8) | drv_cfg->gammacontrol_7 );
            _ili9320_write(drv, 0x0138, (drv_cfg->gammacontrol_9  << 8) | drv_cfg->gammacontrol_16);
            _ili9320_write(drv, 0x0139, (drv_cfg->gammacontrol_10 << 8) | drv_cfg->gammacontrol_15);
            _ili9320_write(drv, 0x013a, (drv_cfg->gammacontrol_11 << 8) | drv_cfg->gammacontrol_14);
            _ili9320_write(drv, 0x013b, (drv_cfg->gammacontrol_12 << 8) | drv_cfg->gammacontrol_13);
            _ili9320_write(drv, 0x013c, (drv_cfg->gammacontrol_13 << 8) | drv_cfg->gammacontrol_12);
            _ili9320_write(drv, 0x013d, (drv_cfg->gammacontrol_14 << 8) | drv_cfg->gammacontrol_11);
            _ili9320_write(drv, 0x013e, (drv_cfg->gammacontrol_15 << 8) | drv_cfg->gammacontrol_10);
            _ili9320_write(drv, 0x013f, (drv_cfg->gammacontrol_16 << 8) | drv_cfg->gammacontrol_9);
        }

        drv->int_num = per_cfg->sync_interrupt;
        if (drv->int_num != -1)
        {
            interrupt_register_native(drv->int_num, (void*) drv, vga_ili9320_sync_interrupt);
            interrupt_configure(drv->int_num, EDGE_RISING);
            interrupt_acknowledge(drv->int_num);
        }
        drv->auto_refresh = drv_cfg->auto_refresh;
        if (drv->auto_refresh)
        {
            VGA32_ILI9320_ARP_REG(drv->baseaddress) = (PAL_CLOCKHZ / 1000) * drv_cfg->refresh_interval;
            VGA32_ILI9320_REFR_REG(drv->baseaddress) = VGA32_ILI9320_RR;
        }

    }

    return drv;
}



 /**
 * @brief    Get display width
 *
 * Get the width of the display. The width depends on the rotation of the display. In landscape it will return 320, in portrait it will return 240.
 *
 * @param  drv  Driver pointer as returned from vga_ili9320_open()
 *
 * @return Width of display
 */

int vga_ili9320_get_width(vga_ili9320_t const * restrict drv)
{
    switch (drv->rotation)
    {
    case 90:
        return ILI9320_HEIGHT;
    case 180:
        return ILI9320_WIDTH;
    case 270:
        return ILI9320_HEIGHT;
    default:
        return ILI9320_WIDTH;
    }
}


 /**
 * @brief    Get display height
 *
 * Get the height of the display. This height depends on the rotation of the display. In landscape it will return 240, in portrait it will return 320.
 *
 * @param  drv  Driver pointer as returned from vga_ili9320_open()
 *
 * @return Height of display
 */

int vga_ili9320_get_height(vga_ili9320_t const * restrict drv)
{
    switch (drv->rotation)
    {
    case 90:
        return ILI9320_WIDTH;
    case 180:
        return ILI9320_HEIGHT;
    case 270:
        return ILI9320_WIDTH;
    default:
        return ILI9320_HEIGHT;
    }
}


 /**
 * @brief    Manual refresh
 *
 * Refresh the display. Each time this function is called the display will be refreshed
 *
 * @param  drv  Driver pointer as returned from vga_ili9320_open()
 *
 * @return Nothing
 *
 * $see vga_ili9320_manual_refresh_done()
 */

void vga_ili9320_manual_refresh(vga_ili9320_t * drv)
{
    VGA32_ILI9320_REFR_REG(drv->baseaddress) |= VGA32_ILI9320_RO;
}


 /**
 * @brief    Manual refresh is done
 *
 * Check if the manual refresh is done.
 *
 * @param  drv  Driver pointer as returned from vga_ili9320_open()
 *
 * @return true if refresh is done, otherwise false.
 *
 * $see vga_ili9320_manual_refresh()
 */

bool vga_ili9320_manual_refresh_done(vga_ili9320_t * drv)
{
    return (VGA32_ILI9320_REFR_REG(drv->baseaddress) & VGA32_ILI9320_RO) == 0;
}


 /**
 * @brief    Set auto refresh
 *
 * Set the auto refresh mode on or off. If on, the time between two refreshes is set by vga_ili9320_set_refresh_interval().
 *
 * @param  drv           Driver pointer as returned from vga_ili9320_open()
 * @param  auto_refresh  Auto refresh if true, no auto refresh if false
 *
 * @return Nothing
 */

void vga_ili9320_set_auto_refresh(vga_ili9320_t * drv, bool auto_refresh)
{
    VGA32_ILI9320_REFR_REG(drv->baseaddress) = auto_refresh ? VGA32_ILI9320_RR : 0;
    drv->auto_refresh = auto_refresh;
}


 /**
 * @brief    Check if screen is set
 *
 * Check if the screen is set. After the screen is set, if the current screen differs from the previous screen,
 * writing to the previous screen is not visible on the TFT.
 * If both current and previous screen are the same, writing to the screen is visble at the next refresh.
 *
 * @param  drv  Driver pointer as returned from vga_ili9320_open()
 *
 * @return True if screen is set, false otherwise
 */

bool vga_ili9320_screen_set(vga_ili9320_t * restrict drv)
{
    if (drv->int_num != -1)
    {
        return drv->refresh_state == _rs_done;
    }
    return (VGA32_ILI9320_REFR_REG(drv->baseaddress) & VGA32_ILI9320_RO) == 0;
}


 /**
 * @brief    Set the screen location
 *
 * Set the location of the screen buffer. If the new location is the same as the current location, a refresh will be performed.
 *
 * @param  drv      Driver pointer as returned from vga_ili9320_open()
 * @param  screen   New screen location
 *
 * @return Nothing
 */

void vga_ili9320_set_screen(vga_ili9320_t * restrict drv, uintptr_t screen)
{

    VGA32_ILI9320_VMBA_REG( drv->baseaddress ) = screen;    // new address will be used next time a refresh is started

    if (drv->int_num != -1)
    {
        if (screen == drv->screen)
        {
            // same
            if (VGA32_ILI9320_REFR_REG(drv->baseaddress) & VGA32_ILI9320_RO)
            {
                // pending
                drv->refresh_state = _rs_same_pending;
                drv->screen = screen;
                interrupt_acknowledge(drv->int_num);
                interrupt_enable(drv->int_num);
            }
            if ((VGA32_ILI9320_REFR_REG(drv->baseaddress) & VGA32_ILI9320_RO) == 0) // not an else! register can change between both tests
            {
                // not pending
                drv->refresh_state = _rs_same_refresh;
                drv->screen = screen;
                VGA32_ILI9320_REFR_REG(drv->baseaddress) |= VGA32_ILI9320_RO;
                interrupt_acknowledge(drv->int_num);
                interrupt_enable(drv->int_num);
            }
        }
        else
        {
            // different
            if (VGA32_ILI9320_REFR_REG(drv->baseaddress) & VGA32_ILI9320_RO)
            {
                // pending
                drv->refresh_state = _rs_diff_pending;
                drv->screen = screen;
                interrupt_acknowledge(drv->int_num);
                interrupt_enable(drv->int_num);
            }
            if ((VGA32_ILI9320_REFR_REG(drv->baseaddress) & VGA32_ILI9320_RO) == 0) // not an else! register can change between both tests
            {
                // not pending
                drv->refresh_state = _rs_done;
                drv->screen = screen;
                VGA32_ILI9320_REFR_REG(drv->baseaddress) |= VGA32_ILI9320_RO;
                interrupt_disable(drv->int_num);
            }
        }
    }
    else
    {
        if (!drv->auto_refresh)
        {
            drv->screen = screen;
            VGA32_ILI9320_REFR_REG(drv->baseaddress) = VGA32_ILI9320_RO;
        }
    }
}


 /**
 * @brief    Get screen
 *
 * Get the location of the screen.
 *
 * @param  drv  Driver pointer as returned from vga_ili9320_open()
 *
 * @return Screen location
 */

uintptr_t vga_ili9320_get_screen(vga_ili9320_t const * restrict drv)
{
    return drv->screen;
}


 /**
 * @brief    Set auto refresh interval
 *
 * Set the interval time between two refreshes if the driver is in auto refresh mode.
 *
 * @param  drv  Driver pointer as returned from vga_ili9320_open()
 * @param  ms   Interval in miliseconds
 *
 * @return Width of display
 */

void vga_ili9320_set_refresh_interval(vga_ili9320_t const * restrict drv, int ms)
{
    VGA32_ILI9320_ARP_REG( drv->baseaddress ) = (PAL_CLOCKHZ / 1000) * ms;
}



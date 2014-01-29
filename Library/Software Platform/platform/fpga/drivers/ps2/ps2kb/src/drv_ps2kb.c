/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
\*****************************************************************************/

/**
 * @file drv_ps2kb.h
 *
 * @brief
 *       PS/2 keyboard driver
 *
 * This is a low level driver for PS/2 keyboard devices. The driver only returns
 * keyboard scancodes. To read characters, use the higher level POSIX keyboard
 * service instead.
 *
 * Requires: <a href="drv_ps2.chm::/index.htm">PS/2 driver</a>.
 */

#include <assert.h>
#include <sysutils.h>
#include <pal.h>
#include <drv_ps2.h>
#include <drv_ps2_internal.h>
#include <drv_ps2kb.h>
#include <drv_ps2kb_internal.h> // also contains definition of struct ps2kb_s
#include "drv_ps2kb_cfg_instance.h"

static ps2kb_t ps2kb_table[DRV_PS2KB_INSTANCE_COUNT];

/*
 * Public interface
 */

/**
 * @brief
 *      Initialize the PS/2 keyboard
 *
 * This function initializes communications with the PS/2 controller and resets the keyboard.
 *
 * @param id
 *      Driver id (defined in devices.h)
 *
 * @return
 *      The ps2kb driver pointer for the specified device, or NULL for invalid id.
 */
extern ps2kb_t *ps2kb_open(unsigned int id)
{
    ps2kb_t * restrict ps2kb;
    const drv_ps2kb_cfg_instance_t *cfg;

    if (id < DRV_PS2KB_INSTANCE_COUNT)
    {
        ps2kb = &ps2kb_table[id];
        if (ps2kb->ps2 == NULL)
        {
            cfg = &drv_ps2kb_instance_table[id];

            ps2kb->bytes_read = 0;

            ps2kb->ps2 = ps2_open(cfg->drv_ps2);
            if (ps2kb->ps2 != NULL)
            {
                ps2kb_reset(ps2kb);
            }
        }
        return ps2kb;
    }
    return NULL;
}

/**
 * @brief
 *      Reset the PS/2 keyboard
 *
 * This function sends a reset command to the keyboard.
 *
 * @param ps2kb
 *      ps2kb driver pointer
 *
 * @return
 *      0 if successful, -1 otherwise.
 */
extern int ps2kb_reset(ps2kb_t * restrict ps2kb)
{
    int retval = -1;

    assert(ps2kb != NULL);

    PS2_MUTEX_PREPARE();
    PS2_MUTEX_LOCK(ps2kb->ps2);

    if (ps2_put_byte(ps2kb->ps2, PS2_KBD_RESET) == 0
        && ps2_wait_for_byte(ps2kb->ps2, PS2_RESP_BAT_PASSED) == PS2_RESP_BAT_PASSED)
    {
        ps2kb->ps2->tail = ps2kb->ps2->head; // reset buffer
        retval = 0;
    }
    ps2kb->status = (retval == 0) ? PS2KB_OK : PS2KB_RESET_FAILED;

    PS2_MUTEX_UNLOCK(ps2kb->ps2);

    return retval;
}

/**
 * @brief
 *      Get driver status
 *
 * This function returns the driver status:
 * - PS2KB_OK           : no problems found
 * - PS2KB_RESET_FAILED : keyboard reset failed
 *
 * @param ps2kb
 *      ps2kb driver pointer
 *
 * @return
 *      Driver status.
 */
extern int ps2kb_get_drvstat(ps2kb_t * restrict ps2kb)
{
    assert(ps2kb != NULL);

    return ps2kb->status;
}

/**
 * @brief
 *      Set keyboard LEDs on/off
 *
 * Turn keyboard LEDs on or off for NumLock, CapsLock and ScrollLock.
 * Only bits 0, 1 and 2 of the @em leds bitmask value are used, which
 * correspond with the NumLock, Capslock and ScrollLock LED respectively.
 *
 * @param ps2kb
 *      ps2kb driver pointer
 * @param leds
 *      Bitmask containing LED values
 *
 * @return
 *      0 if successful, -1 otherwise.
 */
extern int ps2kb_setleds(ps2kb_t * restrict ps2kb, uint8_t leds)
{
    int retval;

    assert(ps2kb != NULL);

    PS2_MUTEX_PREPARE();
    PS2_MUTEX_LOCK(ps2kb->ps2);
    retval = ps2kb_set_led_bitmask(ps2kb, leds);
    PS2_MUTEX_UNLOCK(ps2kb->ps2);
    return retval;
}

/**
 * @brief
 *      Get next scancode from the keyboard
 *
 * The keyboard sends scancodes for key presses and key releases. A
 * scancode is 1 to 8 bytes long. This function returns a pointer to an
 * 8 byte array that contains the bytes of the scancode. The unused
 * bytes are 0. If no scancode can be read, all bytes will be 0.
 *
 * @param ps2kb
 *      ps2kb driver pointer
 *
 * @return
 *      Pointer to an 8 byte array with the scancode.
 */
extern const uint8_t *ps2kb_get_scancode(ps2kb_t * restrict ps2kb)
{
    assert(ps2kb != NULL);

    PS2_MUTEX_PREPARE();
    PS2_MUTEX_LOCK(ps2kb->ps2);
    ps2kb_fill_scancode_buffer(ps2kb);
    PS2_MUTEX_UNLOCK(ps2kb->ps2);
    return ps2kb->bytes;
}

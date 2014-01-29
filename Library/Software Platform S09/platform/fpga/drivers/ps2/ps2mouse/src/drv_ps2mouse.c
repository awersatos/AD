/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    PS/2 mouse driver.
|*
\*****************************************************************************/

/**
 * @file drv_ps2mouse.h
 *
 * @brief
 *      PS/2 mouse driver
 *
 * This driver translates mouse packets to movement and button state.
 *
 * Requires: <a href="drv_ps2.chm::/index.htm">PS/2 driver</a>.
 */

#include <assert.h>
#include <pal.h>
#include <drv_ps2.h>
#include <drv_ps2_internal.h>
#include <drv_ps2mouse.h>

#include "drv_ps2mouse_cfg_instance.h"

/*
 * PS/2 Response Codes
 */
#define PS2_RESP_BAT_PASSED     0xAA    /* Returned after reset, when self test succeeds. */
#define PS2_RESP_BAT_FAILED     0xFC    /* Returned after reset, when self test fails */
#define PS2_RESP_ACK            0xFA    /* Acknowledge response. */

/*
 * PS/2 Mouse Commands
 */
#define PS2_MOUSE_SETSCALE1_1   0xE6    /* Set scaling 1:1, mouse response = ACK. */
#define PS2_MOUSE_SETSCALE2_1   0xE7    /* Set scaling 2:1, mouse response = ACK. */
#define PS2_MOUSE_SETRES        0xE8    /* Set resolution, mouse response = ACK, host sends resaolution, mouse response = ACK. */
#define PS2_MOUSE_STATUSREQ     0xE9    /* Status request, mouse response = ACK, then 3 byte status packet. */
#define PS2_MOUSE_SETSTREAM     0xEA    /* Set stream mode, mouse response = ACK, then enters stream mode. */
#define PS2_MOUSE_READDATA      0xEB    /* Read data, mouse response = ACK, then movement data packet. */
#define PS2_MOUSE_RESETWRAP     0xEC    /* Reset wrap mode, back to previous mode, mouse response = ACK. */
#define PS2_MOUSE_SETWRAP       0xEE    /* Set wrap mode, mouse response = ACK. */
#define PS2_MOUSE_SETREMOTE     0xF0    /* Set remote mode, mouse response = ACK. */
#define PS2_MOUSE_GETID         0xF2    /* response = ACK, then ID: 0x00 is standard mouse. */
#define PS2_MOUSE_SETRATE       0xF3    /* Set sample rate, mouse respons = ACK, host sends sample rate, mouse response = ACK.*/
#define PS2_MOUSE_ENABLE        0xF4    /* Enable data reporting, mouse response = ACK. */
#define PS2_MOUSE_DISABLE       0xF5    /* Disable data reporting, mouse response = ACK. */
#define PS2_MOUSE_SETDEFAULTS   0xF6    /* Set default (sample rate = 100, resolution = 4counts/mm, scaling 1:1, disable reporting), response = ACK. */
#define PS2_MOUSE_RESEND        0xFE    /* Resend request for last byte, mouse response = last byte. */
#define PS2_MOUSE_RESET         0xFF    /* Reset mouse, response = 0xAA ("OK") or 0xFC ("Failed"). */

#define MOUSE_ID                0

/* Mouse Movement Data Packet
 *
 *             Bit 7     Bit 6    Bit 5    Bit 4   Bit 3     Bit 2       Bit 1      Bit 0
 *        +---------------------------------------------------------------------------------+
 * Byte 1 | Y overfl | X overfl | Y sign | X sign | '1' | Middle Btn | Right Btn | Left Btn |
 * Byte 2 | X movement                                                                      |
 * Byte 3 | Y movement                                                                      |
 *        +---------------------------------------------------------------------------------+
 */
#define Y_OVERFL        0x80
#define X_OVERFL        0x40
#define Y_SIGN          0x20
#define X_SIGN          0x10
#define BIT_3           0x08    /* always 1 for movement packet */

struct ps2mouse_s
{
    ps2_t * restrict ps2;
    bool remote;
    void (*callback)(ps2mouse_t *, ps2mouse_state_t *, void *);
    ps2mouse_state_t *user_state;
    void *user_data;
    int block_callback;
};

static ps2mouse_t ps2mouse_table[DRV_PS2MOUSE_INSTANCE_COUNT];

/*
 * Local interface
 */

// Reset mouse
inline int ps2mouse_reset(ps2mouse_t *ps2mouse)
{
    int retval = 0;

    ps2mouse->ps2->tail = ps2mouse->ps2->head;

    ps2_put_byte(ps2mouse->ps2, PS2_MOUSE_ENABLE);       // reset counters
    retval = (ps2_wait_for_byte(ps2mouse->ps2, PS2_RESP_ACK) == PS2_RESP_ACK) ? 1 : 0;

    return retval;
}

// (Re)Initialize mouse state
inline void ps2mouse_reset_state(ps2mouse_state_t *state)
{
    state->xmov = 0;
    state->ymov = 0;
    state->buttons = 0;
}

// Change settings
inline int ps2mouse_change_setting(ps2mouse_t *ps2mouse, uint8_t cmd)
{
    int retval = 0;
    PS2_MUTEX_PREPARE();

    ps2mouse->block_callback++;

    PS2_MUTEX_LOCK(ps2mouse->ps2);
    ps2_put_byte(ps2mouse->ps2, cmd);
    retval = (ps2_wait_for_byte(ps2mouse->ps2, PS2_RESP_ACK) == PS2_RESP_ACK) ? 0 : -1;
    PS2_MUTEX_UNLOCK(ps2mouse->ps2);

    ps2mouse->block_callback--;
    return retval;
}

inline int ps2mouse_set_value(ps2mouse_t *ps2mouse, uint8_t cmd, uint8_t value)
{
    int retval = -1;
    PS2_MUTEX_PREPARE();

    ps2mouse->block_callback++;

    PS2_MUTEX_LOCK(ps2mouse->ps2);
    ps2_put_byte(ps2mouse->ps2, cmd);
    if (ps2_wait_for_byte(ps2mouse->ps2, PS2_RESP_ACK) == PS2_RESP_ACK)
    {
        ps2_put_byte(ps2mouse->ps2, value);
        retval = (ps2_wait_for_byte(ps2mouse->ps2, PS2_RESP_ACK) == PS2_RESP_ACK) ? 0 : -1;
    }
    PS2_MUTEX_UNLOCK(ps2mouse->ps2);

    ps2mouse->block_callback--;
    return retval;
}

// Try to read one movement packet
inline bool ps2mouse_get_packet(ps2mouse_t *ps2mouse)
{
    bool handled = false;
    bool fullbuffer;
    int byte1;
    int byte2;
    int byte3;
    int nbytes;

    PS2_MUTEX_PREPARE();
    PS2_MUTEX_LOCK(ps2mouse->ps2);

    /* in remote mode we need to request a packet */
    if (ps2mouse->remote)
    {
        ps2_reset_buffer(ps2mouse->ps2);
        ps2_putchar(ps2mouse->ps2, PS2_MOUSE_READDATA);
        if (ps2_waitfor(ps2mouse->ps2, PS2_RESP_ACK) == PS2_RESP_ACK)
        {
            /* wait 3*timeout for the data to arrive */
            for (int i = 0; ps2_available_bytes(ps2mouse->ps2) < 3 && i < 3; i++)
            {
                pal_delay_ms(PS2_READ_TIMEOUT_MS);
            }
        }
    }

    /* if buffer is full we will reset it later */
    fullbuffer = ps2_check_buffer_full(ps2mouse->ps2);
   
    /* get one mouse packet */
    nbytes = ps2_available_bytes(ps2mouse->ps2);
    if (nbytes >= 3)
    {
        byte1 = -1;
        /* sync to next control byte */
        for (; nbytes >= 3; nbytes--)
        {
            byte1 = ps2_timed_get_byte(ps2mouse->ps2);

            if ((byte1 & BIT_3))
            {
                break;
            }
        }

        if (nbytes >= 3 && byte1 != -1)
        {
            byte2 = ps2_timed_get_byte(ps2mouse->ps2);
            byte3 = ps2_timed_get_byte(ps2mouse->ps2);

            ps2mouse->user_state->buttons = byte1 & 0x7;

            if (byte1 & X_OVERFL)
            {
                if (byte1 & X_SIGN)
                {
                    byte2 = -255;
                }
                else
                {
                    byte2 = 255;
                }
            }
            else if (byte1 & X_SIGN)
            {
                byte2 -= 256;
            }

            if (byte1 & Y_OVERFL)
            {
                if (byte1 & Y_SIGN)
                {
                    byte3 = -255;
                }
                else
                {
                    byte3 = 255;
                }
            }
            else if (byte1 & Y_SIGN)
            {
                byte3 -= 256;
            }
            ps2mouse->user_state->xmov = (int16_t)byte2;
            ps2mouse->user_state->ymov = (int16_t)byte3;
            handled = true;
        }
    }

    /* if an overflow occurred we have missed bytes,
     * so we need to reset the buffer
     */
    if (fullbuffer)
    {
        ps2mouse->ps2->tail = ps2mouse->ps2->head;
    }

    PS2_MUTEX_UNLOCK(ps2mouse->ps2);

    return handled;
}

// Interrupt callback
static void ps2mouse_interrupt_callback(ps2_t *ps2, void *user_data)
{
    ps2mouse_t *ps2mouse = (ps2mouse_t*)user_data;

    if (ps2mouse->callback && !ps2mouse->block_callback)
    {
        if (ps2mouse_get_packet(ps2mouse))
        {
            ps2mouse->callback(ps2mouse, ps2mouse->user_state, ps2mouse->user_data);
        }
    }
}

/*
 * Public interface
 */

/**
 * @brief
 *      Initialize the PS/2 mouse
 *
 * This function initializes the communication with the PS/2 controller and
 * resets the mouse.
 * 
 * @param id
 *      Driver id (defined in devices.h)
 *
 * @return
 *      The ps2mouse driver pointer for the specified device, or NULL on error.
 */
extern ps2mouse_t *ps2mouse_open(int id)
{
    bool success = false;
    ps2mouse_t *ps2mouse;
    drv_ps2mouse_cfg_instance_t *cfg;

    assert(id >= 0 && id < DRV_PS2MOUSE_INSTANCE_COUNT);
    ps2mouse = &ps2mouse_table[id];
    cfg = &drv_ps2mouse_instance_table[id];

    ps2mouse->remote = false;
    ps2mouse->callback = NULL;
    ps2mouse->user_state = NULL;
    ps2mouse->user_data = NULL;
    ps2mouse->block_callback = 0;

    ps2mouse->ps2 = ps2_open(cfg->drv_ps2);

    PS2_MUTEX_PREPARE();
    PS2_MUTEX_LOCK(ps2mouse->ps2);
    ps2_put_byte(ps2mouse->ps2, PS2_MOUSE_RESET);
    if (ps2_wait_for_byte(ps2mouse->ps2, PS2_RESP_BAT_PASSED) == PS2_RESP_BAT_PASSED
        && ps2_wait_for_byte(ps2mouse->ps2, MOUSE_ID) == MOUSE_ID
        && ps2mouse_reset(ps2mouse) == 1)
    {
        success = true;
    }
    PS2_MUTEX_UNLOCK(ps2mouse->ps2);

    return success ? ps2mouse : NULL;
}

/**
 * @brief
 *      Set mouse to streaming mode or remote mode
 *
 * Set the PS/2 mouse to streaming mode or remote mode. In streaming mode the
 * device sends movement packets whenever the mouse is moved or a button
 * state is changed. In remote mode (streaming set to false), movement
 * packets are only send on request (<code>ps2mouse_get_state()</code>).
 * After a reset the mouse will be in streaming mode.
 * 
 * @param ps2mouse
 *      ps2mouse driver pointer
 * @param streaming
 *      True for streaming mode, false for remote mode
 *
 * @return
 *      0 if successful, -1 otherwise.
 *
 * @see
 *      ps2mouse_get_state
 *      ps2mouse_install_callback
 */
extern int ps2mouse_set_streaming(ps2mouse_t *ps2mouse, bool streaming)
{
    int retval = ps2mouse_change_setting(ps2mouse, streaming ? PS2_MOUSE_SETSTREAM : PS2_MOUSE_SETREMOTE);
    if (retval == 0)
    {
        ps2mouse->remote = !streaming;
    }
    return retval;
}

/**
 * @brief
 *      Set mouse scaling
 *
 * Set the scaling factor to 2:1 or 1:1. With 2:1 scaling, the reported movement
 * (see <code>psmouse_get_state()</code>) is multiplied by 2.
 * 
 * @param ps2mouse
 *      ps2mouse pointer driver
 * @param scale
 *      True for 2:1, false for 1:1
 *
 * @return
 *      0 if successful, -1 otherwise.
 */
extern int ps2mouse_set_scaling(ps2mouse_t *ps2mouse, bool scale)
{
    return ps2mouse_change_setting(ps2mouse, scale ? PS2_MOUSE_SETSCALE2_1 : PS2_MOUSE_SETSCALE1_1);
}

/**
 * @brief
 *      Set mouse resolution
 *
 * Set the resolution to 1, 2, 4, or 8 counts per millimeter. Allowed values
 * for @em val are:
 *      - 0 = 1 count per millimeter
 *      - 1 = 2 counts per millimeter
 *      - 2 = 4 counts per millimeter
 *      - 3 = 8 counts per millimeter
 * 
 * @param ps2mouse
 *      ps2mouse pointer driver
 * @param val
 *      Desired resolution
 *
 * @return
 *      0 if successful, -1 otherwise.
 */
extern int ps2mouse_set_resolution(ps2mouse_t *ps2mouse, uint8_t val)
{
    return ps2mouse_set_value(ps2mouse, PS2_MOUSE_SETRES, val & 0x3);
}

/**
 * @brief
 *      Set sample rate
 *
 * Set sample rate in samples per second. Allowed values are 10, 20, 40, 60,
 * 80, 100 and 200.
 * 
 * @param ps2mouse
 *      ps2mouse pointer driver
 * @param rate
 *      Sample rate.
 *
 * @return
 *      0 if successful, -1 otherwise.
 */
extern int ps2mouse_set_sample_rate(ps2mouse_t *ps2mouse, uint8_t rate)
{
    return ps2mouse_set_value(ps2mouse, PS2_MOUSE_SETRATE, rate);
}

/**
 * @brief
 *      Install mouse event callback function
 *
 * Install a callback function. This function is called each time a mouse event
 * is received. This may be a movement or a button state change (or both). To
 * receive these mouse events, the device must be set to streaming mode. The
 * callback takes precedence over the <code>ps2mouse_get_state()</code> call
 * (which will report no changes in that case).
 * 
 * @param ps2mouse
 *      ps2mouse pointer driver
 * @param mouse_event_callback
 *      Callback function, or NULL to disable the mouse event callback
 * @param state
 *      Location of a ps2mouse_state_t data structure
 * @param data
 *      User data, will be passed back to mouse_event_callback
 *
 * @return
 *      Nothing.
 *
 * @see
 *      ps2mouse_set_streaming
 *      ps2mouse_get_state
 */
extern void ps2mouse_install_callback(ps2mouse_t *ps2mouse,
                                      void (*mouse_event_callback) (ps2mouse_t *ps2mouse,
                                                                    ps2mouse_state_t *state,
                                                                    void *data),
                                      ps2mouse_state_t *state,
                                      void *data)
{
    ps2_install_interrupt_callback(ps2mouse->ps2, NULL, NULL);
    ps2mouse->callback = mouse_event_callback;
    ps2mouse->user_state = state;
    ps2mouse->user_data = data;
    ps2_install_interrupt_callback(ps2mouse->ps2, ps2mouse_interrupt_callback, (void*)ps2mouse);
}

/**
 * @brief
 *      Get mouse state
 *
 * Get the next received mouse state. You can use this function with the mouse set
 * either to streaming mode or remote mode. However, in streaming mode an installed event
 * callback handler takes precedence over the <code>ps2mouse_get_state()</code> call
 * (which will report no changes in that case).
 *
 * @param ps2mouse
 *      ps2mouse pointer driver
 * @param state
 *      Location of a ps2mouse_state_t data structure
 *
 * @return
 *      0 if successful, -1 if no new mouse state was available.
 *
 * @see
 *      ps2mouse_install_callback
 */
extern int ps2mouse_get_state(ps2mouse_t *ps2mouse, ps2mouse_state_t *state)
{
    int retval;

    ps2mouse_reset_state(state);
    if (ps2mouse->callback)
    {
        /* change gets reported in callback */
        return -1;
    }

    ps2mouse->block_callback++;

    ps2mouse->user_state = state;
    retval = ps2mouse_get_packet(ps2mouse) ? 0 : -1;

    ps2mouse->block_callback--;
    return retval;
}

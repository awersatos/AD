/*****************************************************************************
|*
|* Copyright:   Copyright (c) 2008, Altium
|*
|* Description: Internal interface for higher level drivers. This interface
|*              provides access to the non-thread-safe implementation of
|*              PS/2 keyboard driver functionality. The mutex must be
|*              obtained from PS/2 low level driver.
|*
\*****************************************************************************/

#ifndef _DRV_PS2KB_INTERNAL_H
#define _DRV_PS2KB_INTERNAL_H

#include <drv_ps2_internal.h>

/*
 * PS/2 Response Codes
 */
#define PS2_RESP_BAT_PASSED     0xAA    /* Returned after reset, when self test succeeds. */
#define PS2_RESP_BAT_FAILED     0xFC    /* Returned after reset, when self test fails */
#define PS2_RESP_ACK            0xFA    /* Acknowledge response. */

/*
 * PS/2 Keyboard Commands
 */
#define PS2_KBD_SETLED          0xED    /* Set LEDs. Must be followed by LED pattern. */
#define PS2_KBD_ECHO            0xEE    /* Echo command, keyboard echoes "0xEE". */
#define PS2_KBD_SELECT_SCANSET  0xF0    /* Scan code set select 1, 2 or 3. 0 = Query. */
#define PS2_KBD_GETID           0xF2    /* Response: 0xFA (ACK), than ID: 0x83 0xAB. */
#define PS2_KBD_SETREPEAT       0xF3    /* Set repeat rate, keyboard respons 0xFA, host sends repeat info, keyboard response = ACK. */
#define PS2_KBD_ENABLE          0xF4    /* Enable keyboard, response = ACK. */
#define PS2_KBD_DISABLE         0xF5    /* Disable keyboard, response = ACK. */
#define PS2_KBD_RESEND          0xFE    /* Resend request for last byte, response = last byte. */
#define PS2_KBD_RESET           0xFF    /* Reset keyboard, response = 0xAA ("OK") or 0xFC ("Failed"). */

struct ps2kb_s
{
    ps2_t * restrict ps2;
    uint8_t bytes[8];
    uint8_t bytes_read;
};

inline int ps2kb_set_led_bitmask(ps2kb_t *ps2kb, uint8_t leds)
{
    /* NOTE
     *
     * If this function is called from an interrupt handler (e.g. from a timer),
     * we won't get the ACK.  However, the keyboard still expects us to send
     * a value!  To solve this problem, we don't check for the return values
     * of the calls below.
     */
    /* if ( */
    ps2_put_byte(ps2kb->ps2, PS2_KBD_SETLED);       /* == 0            && */
    ps2_wait_for_byte(ps2kb->ps2, PS2_RESP_ACK);    /* == PS2_RESP_ACK && */
    ps2_put_byte(ps2kb->ps2, leds);                 /* == 0            && */
    ps2_wait_for_byte(ps2kb->ps2, PS2_RESP_ACK);    /* == PS2_RESP_ACK    */
    /* ) */
    return 0;
    /* else return -1; */
}

inline void ps2kb_fill_scancode_buffer(ps2kb_t *ps2kb)
{
    int ch;
    int state = 0; // 0 = 'normal', '1' = break code, '2' = pause/break
    bool scancode_found = false;
    bool extended = false;

    for (int i =0; i < 8; i++)
    {
        ps2kb->bytes[i] = 0;
    }
    ps2kb->bytes_read = 0;

    /* Read until we have a scancode, or -1. */
    while (ch = ps2_timed_get_byte(ps2kb->ps2), ch != -1)
    {
        /* sanity check */
        if ( ps2kb->bytes_read >= 8 )
        {
            ps2kb->bytes[0] = 0;
            ps2kb->bytes_read = 0;
            ps2_reset_buffer( ps2kb->ps2 );
            break;
        }
        ps2kb->bytes[ps2kb->bytes_read++] = (uint8_t)ch;

        switch (state)
        {
        case 0:
            switch (ch)
            {
            case 0xF0:
                /* Break code */
                state = 1;
                break;

            case 0xE1:
                /* Pause / break, wait for complete string */
                state = 2;
                break;

            case 0xE0:
                /* Extended code, continue */
                extended = true;
                break;

            default:
                if (extended && ch == 0x12)
                {
                    /* printscreen */
                    break;
                }
                scancode_found = true;
                break;
            }
            break;

        case 1:
            state = 0;
            if (extended && ch == 0x7C)
            {
                /* printscreen */
                break;
            }
            scancode_found = true;
            break;

        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
            /* PAUSE code: receive 8 bytes */
            state++;
            break;

        case 8:
            state = 0;
            break;
        }

        if (scancode_found)
        {
            break;
        }
    }
}
#endif /* _DRV_PS2KB_INTERNAL_H */

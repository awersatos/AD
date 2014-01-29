/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007, Altium
|*
|*  Description:        Create and install POSIX keyboard devices. The device will be
|*                      accessed through standard POSIX_DEVICEIO services.
\*****************************************************************************/

#include <assert.h>
#include <sysutils.h>
#include <stdlib.h>
#include <fcntl.h>
#include <errno.h>
#include <stdbool.h>
#include <stdint.h>

#include <devio_adaptor.h>
#include <keyboard.h>
#include <drv_ps2kb.h>
#include <drv_ps2kb_internal.h>

#include "drv_ps2_internal.h"
#include "keyboard_cfg_instance.h"
#include "ps2kb_to_keyboard_cfg_instance.h"

/* Keycodes and values */

#define PS2KB_RELCTRL_CODE      0x14
#define PS2KB_RELLSHIFT_CODE    0x12
#define PS2KB_RELRSHIFT_CODE    0x59
#define PS2KB_RELALT_CODE       0x11

#define SHIFT_SCRL              0x01
#define SHIFT_NUM               0x02
#define SHIFT_CAPS              0x04
#define SHIFT_LEFT              0x10
#define SHIFT_RIGHT             0x20
#define SHIFT_CTRL              0x40
#define SHIFT_ALT               0x80

static const int ps2kb_scancodes_key_values[] = {
    -1, KEY_F9, -1, KEY_F5, KEY_F3, KEY_F1, KEY_F2, KEY_F12, -1,
    KEY_F10, KEY_F8, KEY_F6, KEY_F4, '\t', '`', -1, -1, KEY_ALT,
    KEY_LSHIFT, -1, KEY_CTRL, 'q', '1', -1, -1, -1, 'z', 's', 'a',
    'w', '2', KEY_LWIN, -1, 'c', 'x', 'd', 'e', '4', '3', KEY_RWIN,
    -1, ' ', 'v', 'f', 't', 'r', '5', KEY_MENU, -1, 'n', 'b', 'h',
    'g', 'y', '6', -1, -1, -1, 'm', 'j', 'u', '7', '8', -1, -1,
    ',', 'k', 'i', 'o', '0', '9', -1, -1, '.', '/', 'l', ';', 'p',
    '-', -1, -1, -1, '\'', -1, '[', '=', -1, -1, KEY_CAPSLOCK,
    KEY_RSHIFT, '\n', ']', -1, '\\', -1, -1, -1, -1, -1, -1, -1, -1,
    '\b',-1, -1, KEY_END, -1, KEY_LEFT, KEY_HOME, -1, -1, -1,
    KEY_INS, KEY_DEL, KEY_DOWN, '5', KEY_RIGHT, KEY_UP, '\x1B',
    KEY_NUMLOCK, KEY_F11, '+', KEY_PGDN, '-', '*', KEY_PGUP,
    KEY_SCROLLOCK, -1, -1, -1, -1, KEY_F7
};

static const char *ps2kb_scancodes_special_shifts[] = {
    "`1234567890-=[]\\;',./",
    "~!@#$%^&*()_+{}|:\"<>?"
};

static const uint8_t ps2kb_scancodes_numlock_keys[] = {
    KEY_HOME, KEY_UP, KEY_PGUP, KEY_LEFT, KEY_RIGHT,
    KEY_END, KEY_DOWN, KEY_PGDN, KEY_INS, KEY_DEL, 0
};

static const char ps2kb_scancodes_numlock_nums[] = "789461230.";


/* the io functions */
static int      ps2kb_to_keyboard_open  ( devio_t *dev, int flags );
static ssize_t  ps2kb_to_keyboard_write ( devio_t *dev, ioreq_t *iotx ) { return ENOTSUP; }
static ssize_t  ps2kb_to_keyboard_read  ( devio_t *dev, ioreq_t *iorx );
static int      ps2kb_to_keyboard_ctl   ( devio_t *dev, int, void *,size_t, int * );
static int      ps2kb_to_keyboard_mmap  ( devio_t* dev, void* addr, size_t len, int flag,
                                            off_t off, void** ret ) { return EINVAL; }

typedef struct
{
    devio_t     dev;
    unsigned int shift_state;
    ps2kb_t     *ps2kb;
    bool        blocking;
#if ( __POSIX_KERNEL__ != 0 )
    uint32_t polling_interval;
    uint32_t polling_timeout;
#endif

} ps2kb_to_keyboard_t;

static devio_iofuns_t     ps2kb_to_keyboard_iofuncs;
static ps2kb_to_keyboard_t   ps2kb_to_keyboard_table[PS2KB_TO_KEYBOARD_INSTANCE_COUNT];

extern void ps2kb_to_keyboard_init( void )
{
    ps2kb_to_keyboard_t *device;
    const ps2kb_to_keyboard_cfg_instance_t * cfg;

    /* register posix io functions */
    DEV_IOFUNS_CREATE( &ps2kb_to_keyboard_iofuncs,
                       ps2kb_to_keyboard_open,
                       ps2kb_to_keyboard_write,
                       ps2kb_to_keyboard_read,
                       ps2kb_to_keyboard_ctl,
                       ps2kb_to_keyboard_mmap,
                       NULL );

    /* posix device table (devio_t) */
    for ( int i =0; i< PS2KB_TO_KEYBOARD_INSTANCE_COUNT;i++ )
    {
        device      = &ps2kb_to_keyboard_table[i];
        cfg         = &ps2kb_to_keyboard_instance_table[i];
        DEV_CREATE( (devio_t*)device,
                    keyboard_instance_table[cfg->keyboard_adaptor].name,
                    &ps2kb_to_keyboard_iofuncs,
                    (void*)cfg->drv_ps2kb );

        devio_install( (devio_t*)device );
    }
}

static int ps2kb_to_keyboard_open( devio_t *dev, int flags )
{

    int                 retval   = 0;
    ps2kb_t*            ps2kb    = 0;
    ps2kb_to_keyboard_t    *kbdev   = (ps2kb_to_keyboard_t *)dev;
    ps2kb                        = ps2kb_open( (int)dev->device );
    if (ps2kb)
    {
        kbdev->ps2kb            = ps2kb;
        kbdev->shift_state      = 0;
        if ( (flags & O_NONBLOCK) == 0 )
            kbdev->blocking = true;
        return 0;
    }
    return EIOCONF;
}

static int ps2kb_to_keyboard_ctl(devio_t *dev, int cmd, void *buf, size_t size, int *res)
{
    int     retval = 0;
    posix_devctl_keyboard_leds_t *leds = (posix_devctl_keyboard_leds_t *) buf;
    ps2kb_to_keyboard_t *kbdev = (ps2kb_to_keyboard_t *)dev;

    switch ( cmd )
    {
    case DEVCTL_KEYBOARD_LEDS:
        ps2kb_setleds(kbdev->ps2kb,leds->leds); // use public function with mutex
        break;
    case DEVCTL_KEYBOARD_BLOCKING:
        kbdev->blocking = ((posix_devctl_keyboard_blocking_t*)buf)->blocking;
        break;
    default:
        break;
    }

    return retval;
}


static int ps2kb_to_keyboard_getchar(ps2kb_to_keyboard_t* kbd);

static ssize_t ps2kb_to_keyboard_read( devio_t *dev, ioreq_t *iorx )
{
    ps2kb_to_keyboard_t *kbdev = (ps2kb_to_keyboard_t *)dev;
    ps2kb_t*          ps2kb    = kbdev->ps2kb;
    int    count = 0;
    int     val;


    PS2_MUTEX_PREPARE();
    PS2_MUTEX_LOCK(ps2kb->ps2);
    while ( count < iorx->len )
    {
        val = ps2kb_to_keyboard_getchar( kbdev );
        if ( val != -1 )
        {
            iorx->buf[count++] = (char)val;
        }
        else if ( !kbdev->blocking )
        {
            break;
        }
    }
    PS2_MUTEX_UNLOCK(ps2kb->ps2);

    if ( count == 0 && iorx->len != 0 )
    {
        count = -1;
    }
    iorx->cnt = count;
    return 0;
}

inline uint8_t ps2kb_to_keyboard_shift_special(uint8_t val)
{
    for (int ix = 0; ps2kb_scancodes_special_shifts[0][ix] != 0; ix++)
    {
        if (val == (uint8_t)ps2kb_scancodes_special_shifts[0][ix])
        {
            val = (uint8_t)ps2kb_scancodes_special_shifts[1][ix];
            break;
        }
    }
    return val;
}

inline uint8_t ps2kb_to_keyboard_handle_numlock(uint8_t val)
{
    for (int ix = 0; ps2kb_scancodes_numlock_keys[ix] != 0; ix++)
    {
        if (val == ps2kb_scancodes_numlock_keys[ix])
        {
            val = (uint8_t)ps2kb_scancodes_numlock_nums[ix];
            break;
        }
    }
    return val;
}

// Read as many bytes as needed to get a "normal" key value, or return -1.
inline int ps2kb_to_keyboard_get_key(ps2kb_to_keyboard_t *kbd)
{
    uint8_t *scancode = kbd->ps2kb->bytes;
    int key = -1;

    /* parse scancodes to look for a 'normal' character or a shift key event */
    while (ps2kb_fill_scancode_buffer(kbd->ps2kb), scancode[0] != 0)
    {
        switch (scancode[0])
        {
        case 0xF0:
            /* Break code, check for shifts, otherwise ignore */
            switch (scancode[1])
            {
            case PS2KB_RELCTRL_CODE:
                key = KEY_RELCTRL;
                break;
            case PS2KB_RELLSHIFT_CODE:
                key = KEY_RELLSHIFT;
                break;
            case PS2KB_RELRSHIFT_CODE:
                key = KEY_RELRSHIFT;
                break;
            case PS2KB_RELALT_CODE:
                key = KEY_RELALT;
                break;
            }
            break;

        case 0xE1:
            /* Pause / break */
            break;
        case 0xE0:
            /* Extended code */
            break;

        default:
            if ( scancode[0] < (sizeof(ps2kb_scancodes_key_values) / sizeof(ps2kb_scancodes_key_values[0])) )
            {
               key = ps2kb_scancodes_key_values[scancode[0]];
            }
            break;
        }

        if (key != -1)
        {
            break;
        }
    }

    return key;
}

// Perform the appropriate action when a shift or control key is pressed.
// Returns true when the shift state was changed.
inline bool ps2kb_to_keyboard_update_shift_state(ps2kb_to_keyboard_t *kbd, uint8_t val)
{
    bool update = true;
    switch (val)
    {
    case KEY_LSHIFT:
        kbd->shift_state |= SHIFT_LEFT;
        break;
    case KEY_RELLSHIFT:
        kbd->shift_state &= ~SHIFT_LEFT;
        break;
    case KEY_RSHIFT:
        kbd->shift_state |= SHIFT_RIGHT;
        break;
    case KEY_RELRSHIFT:
        kbd->shift_state &= ~SHIFT_RIGHT;
        break;
    case KEY_CTRL:
        kbd->shift_state |= SHIFT_CTRL;
        break;
    case KEY_RELCTRL:
        kbd->shift_state &= ~SHIFT_CTRL;
        break;
    case KEY_ALT:
        kbd->shift_state |= SHIFT_ALT;
        break;
    case KEY_RELALT:
        kbd->shift_state &= ~SHIFT_ALT;
        break;
    case KEY_CAPSLOCK:
        kbd->shift_state ^= SHIFT_CAPS;
        ps2kb_set_led_bitmask(kbd->ps2kb, kbd->shift_state & 0x07); // use internal function without mutex
        break;
    case KEY_NUMLOCK:
        kbd->shift_state ^= SHIFT_NUM;
        ps2kb_set_led_bitmask(kbd->ps2kb, kbd->shift_state & 0x07); // use internal function without mutex
        break;
    case KEY_SCROLLOCK:
        kbd->shift_state ^= SHIFT_SCRL;
        ps2kb_set_led_bitmask(kbd->ps2kb, kbd->shift_state & 0x07); // use internal function without mutex
        break;
    default:
        /* no shift/control key */
        update = false;
        break;
    }
    return update;
}

// Update the key value based on the current shift state.
inline uint8_t ps2kb_to_keyboard_handle_shift_state(ps2kb_to_keyboard_t *kbd, uint8_t val)
{
    if ( val >= 'a' && val <= 'z' )
    {
        if (kbd->shift_state & SHIFT_CAPS) // caps lock
        {
            if ((kbd->shift_state & (SHIFT_LEFT | SHIFT_RIGHT)) == 0) // ... and no shift
            {
                val -= ('a' - 'A');
            }
        }
        else if (kbd->shift_state & (SHIFT_LEFT | SHIFT_RIGHT))
        {
            val -= ('a' - 'A');
        }
    }
    else
    {
        if (kbd->shift_state & (SHIFT_LEFT | SHIFT_RIGHT))
        {
            val = ps2kb_to_keyboard_shift_special(val);
        }
        if (kbd->shift_state & SHIFT_NUM)
        {
            val = ps2kb_to_keyboard_handle_numlock(val);
        }
    }
    return val;
}


static int ps2kb_to_keyboard_getchar(ps2kb_to_keyboard_t* kbd)
{
    int ch;

    /* Read until we have a 'normal' character, or -1. */
    while (ch = ps2kb_to_keyboard_get_key(kbd), ch != -1)
    {
        if (!ps2kb_to_keyboard_update_shift_state(kbd, (uint8_t)ch))   /* handle shift/control keys */
        {
            ch = ps2kb_to_keyboard_handle_shift_state(kbd, (uint8_t)ch);
            /* this is a 'normal' character */
            break;
        }
    }
    return ch;
}

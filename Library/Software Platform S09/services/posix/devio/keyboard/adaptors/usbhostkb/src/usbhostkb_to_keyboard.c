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
#include "keyboard_cfg_instance.h"

#include <usbhost_keyboard.h>
#include <usbhost_keyboard_cfg_instance.h>
#include "usbhostkb_to_keyboard_cfg_instance.h"

enum keyboard_codes_internal { KEYPAD_DOT = -12,
                               KEYPAD_1, KEYPAD_2, KEYPAD_3, KEYPAD_4, KEYPAD_5,
                               KEYPAD_6, KEYPAD_7, KEYPAD_8, KEYPAD_9, KEYPAD_0 };

// keycode to value translation
static const int usbhostkb_scancodes_key_values[] =
{
    -1, -1, -1, -1,
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
    'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
    '1', '2', '3', '4', '5', '6', '7', '8', '9', '0',
    '\n', '\x1B', '\b', '\t', ' ',
    '-', '=', '[', ']', '\\', '@', ';', '\'', '`', ',', '.', '/',
    KEY_CAPSLOCK,
    KEY_F1, KEY_F2, KEY_F3, KEY_F4, KEY_F5, KEY_F6, KEY_F7, KEY_F8, KEY_F9, KEY_F10, KEY_F11, KEY_F12,
    KEY_PRSCR, KEY_SCROLLOCK, KEY_PAUSE,
    KEY_INS, KEY_HOME, KEY_PGUP, KEY_DEL, KEY_END, KEY_PGDN,
    KEY_RIGHT, KEY_LEFT, KEY_DOWN, KEY_UP,
    KEY_NUMLOCK, '/', '*', '-', '+', '\n',
    KEYPAD_1, KEYPAD_2, KEYPAD_3, KEYPAD_4, KEYPAD_5, KEYPAD_6, KEYPAD_7, KEYPAD_8, KEYPAD_9, KEYPAD_0, KEYPAD_DOT
};

static const char *usbhostkb_shift_from[] = "`1234567890-=[]\\;',./";
static const char *usbhostkb_shift_on[] = "~!@#$%^&*()_+{}|:\"<>?";

static const int usbhostkb_numlock_from[] = { KEYPAD_1, KEYPAD_2, KEYPAD_3, KEYPAD_4, KEYPAD_5,
                                              KEYPAD_6, KEYPAD_7, KEYPAD_8, KEYPAD_9, KEYPAD_0, KEYPAD_DOT};
static const char usbhostkb_numlock_off[] = { KEY_END, KEY_DOWN, KEY_PGDN, KEY_LEFT, -1,
                                              KEY_RIGHT, KEY_HOME, KEY_UP, KEY_PGUP, KEY_INS, KEY_DEL};
static const char usbhostkb_numlock_on[] = "1234567890.";

typedef struct
{
    devio_t dev;
    uint8_t shift_state;
    usbhost_keyboard_t *usbhost_keyboard;
    bool blocking;
}
usbhostkb_to_keyboard_t;


static usbhostkb_to_keyboard_t usbhostkb_to_keyboard_table[USBHOSTKB_TO_KEYBOARD_INSTANCE_COUNT];

static devio_iofuns_t usbhostkb_to_keyboard_iofuncs;

/* the io functions */
static int usbhostkb_to_keyboard_open(devio_t * dev, int flags);
static ssize_t usbhostkb_to_keyboard_write(devio_t * dev) { return ENOTSUP; }
static ssize_t usbhostkb_to_keyboard_read(devio_t * dev);
static int usbhostkb_to_keyboard_ctl(devio_t * dev, int, void *, size_t, int *);
static int usbhostkb_to_keyboard_mmap(devio_t * dev, void *addr, size_t len, int flag, off_t off, void **ret) { return EINVAL; }

static int usbhostkb_to_keyboard_getchar(usbhostkb_to_keyboard_t * kbd);


extern void usbhostkb_to_keyboard_init(void)
{
    usbhostkb_to_keyboard_t *device;
    usbhostkb_to_keyboard_cfg_instance_t *cfg;

    /* register posix io functions */
    DEV_IOFUNS_CREATE(&usbhostkb_to_keyboard_iofuncs,
                      usbhostkb_to_keyboard_open,
                      usbhostkb_to_keyboard_write,
                      usbhostkb_to_keyboard_read,
                      usbhostkb_to_keyboard_ctl,
                      usbhostkb_to_keyboard_mmap,
                      NULL);

    /* posix device table (devio_t) */
    for (int i = 0; i < USBHOSTKB_TO_KEYBOARD_INSTANCE_COUNT; i++)
    {
        device = &usbhostkb_to_keyboard_table[i];
        cfg = &usbhostkb_to_keyboard_instance_table[i];
        DEV_CREATE((devio_t *) device,
                   keyboard_instance_table[cfg->keyboard_adaptor].name,
                   &usbhostkb_to_keyboard_iofuncs, (void *) cfg->usbhost_keyboard);

        devio_install((devio_t *) device);
    }
}

static int usbhostkb_to_keyboard_open(devio_t * dev, int flags)
{
    usbhostkb_to_keyboard_t *adapter = (usbhostkb_to_keyboard_t *) dev;
    usbhost_keyboard_t *usbhost_keyboard;

    usbhost_keyboard = usbhost_keyboard_open((int) dev->device);

    if (usbhost_keyboard)
    {
        adapter->usbhost_keyboard = usbhost_keyboard;
        adapter->shift_state = 0;
        if ((flags & O_NONBLOCK) == 0)
            adapter->blocking = true;
        return 0;
    }

    return EIOCONF;
}


static int usbhostkb_to_keyboard_ctl(devio_t * dev, int cmd, void *buf, size_t size, int *res)
{
    usbhostkb_to_keyboard_t *adapter = (usbhostkb_to_keyboard_t *) dev;

    switch (cmd)
    {
    case DEVCTL_KEYBOARD_LEDS:
        {
            posix_devctl_keyboard_leds_t *leds = (posix_devctl_keyboard_leds_t *) buf;
            usbhost_keyboard_setleds(adapter->usbhost_keyboard, leds->leds);
        }
        break;

    case DEVCTL_KEYBOARD_BLOCKING:
        {
            posix_devctl_keyboard_blocking_t *blocking = (posix_devctl_keyboard_blocking_t *) buf;
            adapter->blocking = blocking->blocking;
        }
        break;

    default:
        break;

    }

    return 0;
}


static ssize_t usbhostkb_to_keyboard_read(devio_t * dev)
{
    usbhostkb_to_keyboard_t *adapter = (usbhostkb_to_keyboard_t *) dev;
    int count = 0;
    int val;

// TODO: mutexes
//    USBHOST_MUTEX_PREPARE();
//    USBHOST_MUTEX_LOCK(usbhostkb->usbhost);
    while (count < dev->iorx->len)
    {
        val = usbhostkb_to_keyboard_getchar(adapter);
        if (val != -1)
        {
            dev->iorx->buf[count++] = (char) val;
        }
        else if (!adapter->blocking)
        {
            break;
        }
    }
//    USBHOST_MUTEX_UNLOCK(usbhostkb->usbhost);

    if (count == 0 && dev->iorx->len != 0)
    {
        count = -1;
    }
    dev->iorx->cnt = count;
    return 0;
}


// Read as many bytes as needed to get a "normal" key value, or return -1.
static int usbhostkb_to_keyboard_getchar(usbhostkb_to_keyboard_t * adapter)
{
    uint16_t scancode;

    /* parse scancodes to look for a 'normal' character or a shift key event */
    while ((scancode = usbhost_keyboard_get_scancode(adapter->usbhost_keyboard)) != 0xFFFF)
    {
        int key = scancode & 0xFF;
        uint8_t shift = (uint8_t) (scancode >> 8);

        if (!key) continue; // only shift keys pressed, ignore

        if (key >= (sizeof(usbhostkb_scancodes_key_values)/sizeof(usbhostkb_scancodes_key_values[0]))) continue; // discard unknown scancode

        key = usbhostkb_scancodes_key_values[key];

        if (key < -1)
        {
            // internal keycode
            for (int i = 0; usbhostkb_numlock_from[i] != 0; ++i)
            {
                if (key == usbhostkb_numlock_from[i])
                {
                    if (adapter->shift_state & USBHOST_KEYBOARD_LED_NUMLOCK)
                    {
                        key = usbhostkb_numlock_on[i];
                    }
                    else
                    {
                        key = usbhostkb_numlock_off[i];
                    }
                    break;
                }
            }
        }

        if (key == -1) continue; // discard dead key

        if (key == KEY_NUMLOCK)
        {
            adapter->shift_state ^= USBHOST_KEYBOARD_LED_NUMLOCK;
            usbhost_keyboard_setleds(adapter->usbhost_keyboard, adapter->shift_state);
            continue;
        }
        else if (key == KEY_CAPSLOCK)
        {
            adapter->shift_state ^= USBHOST_KEYBOARD_LED_CAPSLOCK;
            usbhost_keyboard_setleds(adapter->usbhost_keyboard, adapter->shift_state);
            continue;
        }
        else if (key == KEY_SCROLLOCK)
        {
            adapter->shift_state ^= USBHOST_KEYBOARD_LED_SCROLLOCK;
            usbhost_keyboard_setleds(adapter->usbhost_keyboard, adapter->shift_state);
            continue;
        }
        else
        {
            if (key >= 'a' && key <= 'z')
            {
                if ((shift & (USBHOST_KEYBOARD_MOD_LEFTSHIFT | USBHOST_KEYBOARD_MOD_RIGHTSHIFT)) || (adapter->shift_state & USBHOST_KEYBOARD_LED_CAPSLOCK))
                {
                    key -= ('a' - 'A');
                }
            }
            else if (shift & (USBHOST_KEYBOARD_MOD_LEFTSHIFT | USBHOST_KEYBOARD_MOD_RIGHTSHIFT))
            {
                for (int i = 0; usbhostkb_shift_from[i] != 0; ++i)
                {
                    if (key == (uint8_t) usbhostkb_shift_from[i])
                    {
                        key = (uint8_t) usbhostkb_shift_on[i];
                        break;
                    }
                }
            }
        }

        return key;
    }

    return -1;
}


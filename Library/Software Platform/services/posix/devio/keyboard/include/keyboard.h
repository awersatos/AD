/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007, Altium
|*
|*  Description:        Definition of posix_dev_ctl() interfaces for keyboard
|*                      posix devices.
|*
\*****************************************************************************/

#ifndef _POSIX_KEYBOARD_H
#define _POSIX_KEYBOARD_H

#ifdef  __cplusplus
extern "C" {
#endif

/**
 * @file
 *	POSIX keyboard device i/o interface
 *
 *  Generic access to keyboard devices is performed with the standard services
 *  of the POSIX_DEVIO Unit of Functionality: write, read, open, close,
 *  and posix_devctl among them.
 *
 *  You can, in this way, use standard Clib functionality to access posix keyboards.
 */

#include <limits.h>
#include <devctl.h>
#if ( __POSIX_KERNEL__ != 0 )
#include <pthread.h>
#endif

/**
 * @brief
 *  Key code values
 *
 * Values of special key codes (other than regular characters) returned when
 * reading from the keyboard.
 */
enum keyboard_codes {
    KEY_F1 = 0x80, KEY_F2, KEY_F3, KEY_F4, KEY_F5, KEY_F6, KEY_F7,
    KEY_F8, KEY_F9, KEY_F10, KEY_F11, KEY_F12, KEY_UP, KEY_DOWN, KEY_LEFT,
    KEY_RIGHT, KEY_PGUP, KEY_PGDN, KEY_HOME, KEY_END, KEY_INS, KEY_DEL,
    KEY_PRSCR, KEY_SCROLLOCK, KEY_PAUSE, KEY_NUMLOCK, KEY_CAPSLOCK,
    KEY_LSHIFT, KEY_RSHIFT, KEY_CTRL, KEY_ALT, KEY_LWIN, KEY_RWIN,
    KEY_MENU, KEY_RELLSHIFT, KEY_RELRSHIFT, KEY_RELCTRL, KEY_RELALT
};

/**
 * @brief POSIX keyboard posix_devctl commands
 */
/** @{ */
#define DEVCTL_KEYBOARD_LEDS              ( DEVCTL_COMMON_NO + 0 )	/**< set keyboard leds */
#define DEVCTL_KEYBOARD_BLOCKING          ( DEVCTL_COMMON_NO + 1 )	/**< set keyboard blocking mode */
/** @} */

/**
 * @brief
 *      Keyboard leds data
 *
 * This data structure holds the serial leds data. Use this as an
 * argument to posix_devctl() with the DEVCTL_KEYBOARD_LEDS command
 * in order to set the keyboard leds.
 *
 * @code
 * posix_devctl_keyboard_leds_t leds;
 * leds.leds = 0xF0;
 * posix_devctl( fd, DEVCTL_KEYBOARD_LEDS, (void*)&leds, sizeof( leds ), NULL );
 * @endcode
 */
typedef struct {
	/** leds data */
    uint8_t	   leds;
} posix_devctl_keyboard_leds_t;


/**
 * @brief
 *      Keyboard blocking mode
 *
 * This data structure holds the blocking mode data. Use this as an
 * argument to posix_devctl() with the DEVCTL_KEYBOARD_BLOCKING command
 * in order to set the keyboard blocking mode.
 *
 * @code
 * posix_devctl_keyboard_blocking_t blocking;
 * blocking.blocking = true;
 * posix_devctl( fd, DEVCTL_KEYBOARD_BLOCKING, (void*)&blocking, sizeof( blocking ), NULL );
 * @endcode
 */
typedef struct {
	/** non blocking data */
    bool	   blocking;
} posix_devctl_keyboard_blocking_t;

#ifdef  __cplusplus
}
#endif

#endif /* _POSIX_KEYBOARD_H */


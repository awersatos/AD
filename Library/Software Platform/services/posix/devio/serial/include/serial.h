/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007, Altium
|*
|*  Description:        Definition of posix_dev_ctl() interfaces for serial
|*                      posix devices.
|*
\*****************************************************************************/

#ifndef _POSIX_SERIAL_H
#define _POSIX_SERIAL_H

#ifdef  __cplusplus
extern "C" {
#endif

/**
 * @file
 *	POSIX serial device i/o interface
 *
 *  Generic access to serial devices is performed with the standard services
 *  of the POSIX_DEVIO Unit of Functionality: write, read, open, close, 
 *  and posix_devctl among them.
 *
 *  You can, in this way, use standard Clib functionality to access posix serial
 *  devices.
 */

#include <limits.h>     /* for __POSIX_DEVIO__ */
#include <devctl.h>
#if ( __POSIX_KERNEL__ != 0 )
#include <pthread.h>
#endif

/**
 * @name POSIX serial posix_devctl commands
 */
/** @{ */
#define DEVCTL_SERIAL_IMPL                     ( DEVCTL_COMMON_NO + 0  )	/**< Get driver implementattion */
#define DEVCTL_SERIAL_POWER_ON                 ( DEVCTL_COMMON_NO + 10 )    /**< Power On the device        */
#define DEVCTL_SERIAL_SUSPEND                  ( DEVCTL_COMMON_NO + 11 )    /**< Suspend the device         */
/** @} */

/**
 * @brief
 *      Serial driver implementation
 *
 * This data structure holds the serial driver implementation. Use this as an
 * argument to posix_devctl() with the DEVCTL_SERIAL_IMPL command in order to
 * get direct access to the serial driver implementation. 
 *
 * @code
 * posix_devctl_serial_impl_t impl;
 *
 * posix_devctl( fd, DEVCTL_SERIAL_IMPL, (void*)&impl, sizeof( impl ), NULL );
 * impl.putchar( impl.device, val );
 * @endcode
 */
typedef struct {
    /** Device specific driver pointer */
	void       *device;
    /** Device specific getchar function  */
	int        (*f_getchar)(void *device);
    /** Device specific putchar function  */
    int        (*f_putchar)(void *device, int val);
    /** Device specific set baudrate function  */
    void       (*f_set_baudrate)(void *device, int baudrate);
    /** Device specific get baudrate function  */
    int        (*f_get_baudrate)(void *device);
    /** Device specific transmit character delay function  */
    void       (*f_set_transmit_chardelay)(void *device, uint8_t delay);
    /** Address of mutex to serialize io rx requests (multithreading only)  */
    void*	   (*f_get_rx_mutex)(void *device);
    /** Address of mutex to serialize io tx requests (multithreading only)  */
    void*	   (*f_get_tx_mutex)(void *device);
} posix_devctl_serial_impl_t;

#define DEVCTL_COMMON_SERIAL_NO                ( DEVCTL_COMMON_NO + 128 )


#ifdef  __cplusplus
}
#endif

#endif /* _POSIX_SERIAL_H */


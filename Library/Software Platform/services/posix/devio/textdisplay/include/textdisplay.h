/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007, Altium
|*
|*  Description:        Definition of posix_dev_ctl() interfaces for textdisplay
|*                      posix devices.
|*
\*****************************************************************************/

#ifndef _POSIX_TEXTDISPLAY_H
#define _POSIX_TEXTDISPLAY_H

#ifdef  __cplusplus
extern "C" {
#endif

/**
 * @file
 *  POSIX textdisplay device i/o interface
 *
 *  Generic access to textdisplay devices is performed with the standard services
 *  of the POSIX_DEVIO Unit of Functionality: write, read, open, close,
 *  and posix_devctl among them.
 *
 *  You can, in this way, use standard Clib functionality to access posix textdisplay
 *  devices.
 */

#include <limits.h>     /* for __POSIX_DEVIO__ */
#include <devctl.h>
#if ( __POSIX_KERNEL__ != 0 )
#include <pthread.h>
#endif

/**
 * @name POSIX textdisplay posix_devctl commands
 */
/** @{ */
#define DEVCTL_TEXTDISPLAY_IMPL              ( DEVCTL_COMMON_NO + 0 )   /**< Get driver implementattion */
/** @} */

/**
 * @brief
 *      Text display driver implementation
 *
 * This data structure holds the textdisplay driver implementation. Use this as an
 * argument to posix_devctl() with the DEVCTL_TEXTDISPLAY_IMPL command in order to
 * get direct access to the textdisplay driver implementation.
 *
 * @code
 * posix_devctl_textdisplay_impl_t impl;
 *
 * posix_devctl( fd, DEVCTL_TEXTDISPLAY_IMPL, (void*)&impl, sizeof( impl ), NULL );
 * impl.setfont( impl.device, myfont, FS_NONE );
 * @endcode
 */
typedef struct {
    /** Device specific driver pointer */
    void       *device;
    /** Device specific font control function */
    int        (*setfont)(void *device, const void * font );
} posix_devctl_textdisplay_impl_t;

#define DEVCTL_COMMON_TEXTDISPLAY_NO                ( DEVCTL_COMMON_NO + 128 )


#ifdef  __cplusplus
}
#endif

#endif /* _POSIX_TEXTDISPLAY_H */


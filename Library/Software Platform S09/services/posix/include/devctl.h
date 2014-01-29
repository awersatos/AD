/******************************************************************************
 * FILE:        @(#)devctl.h    1.2 05/08/19
 * DESCRIPTION:
 *      device control interface: POSIX.26
 *****************************************************************************/
#ifndef _DEVCTL_H
#define _DEVCTL_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stddef.h>
#include <stdint.h>

/* list of reserved (common) commands for posix_devctl (0-127) */

#define DEVCTL_COMMON_NO          128

extern int posix_devctl( int fildes, int dcmd, void* dev_data_ptr,
                         size_t nbyte, int *dev_info_ptr);

#ifdef  __cplusplus
}
#endif

#endif

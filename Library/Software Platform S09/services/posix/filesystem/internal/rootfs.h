/******************************************************************************
|*
|* COPYRIGHT:   Copyright (c) 2008, ALtium
|*
|* DESCRIPTION: Virtual root file system.
|*
\******************************************************************************/

#ifndef _ROOTFS_H
#define _ROOTFS_H

#include <fsio.h>

extern void rootfs_init( mount_t mount_table[], size_t mount_table_size );

#endif /* _ROOTFS_H */

/******************************************************************************
|*
|* COPYRIGHT:   Copyright (c) 2008, ALtium
|*
|* DESCRIPTION: Generic (POSIX-compatible) file system interface.
|*
\******************************************************************************/

#ifndef _FS_H
#define _FS_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdio.h>
#include <errno.h>
#include <limits.h>
#include <fcntl.h>
#include <dirent.h>
#include <stdbool.h>

// Path separator

#define FS_DIRSEPCHAR           '/'                 /**< Character used to separate elements of a file path */

// partition table

extern int write_partition_table( const char *device, int32_t size1, int32_t size2, int32_t size3, int32_t size4  );
extern int write_partition_type( const char *device, int nr, uint8_t type );

// mounting

#define MOUNT_FLAG_RDWR         0x0     /**< Mount file system read-write (see mount()) */
#define MOUNT_FLAG_RDONLY       0x1     /**< Mount file system read-only (see mount()) */
#define MOUNT_FLAG_SYNC         0x10    /**< Write all data to disk immediately (see mount()) */
#define MOUNT_FLAG_FORCE        0x2     /**< Force unmount of file system even if there are open files */

extern int mkfs( const char *device, const char *fsname, unsigned int partition, const char *label, bool removable );

extern int mount( const char *device, const char *mountpoint, const char *fsname, unsigned int partition, unsigned int flags );
extern int umount( const char *mountpoint );
extern int unmount( const char *mountpoint, int flags );

// For other operations use C library interfaces

#ifdef  __cplusplus
}
#endif

#endif /* _FS_H */

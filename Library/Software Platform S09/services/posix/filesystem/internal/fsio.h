/******************************************************************************
|*
|* COPYRIGHT:   Copyright (c) 2008, ALtium
|*
|* DESCRIPTION: Generic (POSIX-compatible) file system interface.
|*
\******************************************************************************/

#ifndef _FSIO_H
#define _FSIO_H

#include <unistd.h>
#include <limits.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <dirent.h>

#include <ioreq.h>
#include <fs.h>

#include "posix_filesystem_cfg.h"

// Limits
#define MAX_OPEN_FILES          OPEN_MAX
#define MAX_OPEN_DIRS           OPEN_MAX
#define FD_TABLE_SIZE           MAX_OPEN_FILES + 3
#define MOUNT_TABLE_SIZE        2 + POSIX_FILESYSTEM_MOUNT_MAX

// Keep in sync with number of supported file systems
#define MAX_FS                  POSIX_FILESYSTEM_FS_MAX

// Data structures
typedef struct mount_s mount_t;
typedef struct fs_s fs_t;
typedef struct fileops_s fileops_t;
typedef struct file_s file_t;

// mount points
struct mount_s
{
    char mountpoint[NAME_MAX+2];
    const char *devname;
    unsigned int partition;
    unsigned int flags;
    const fs_t * restrict fs;
    void *data;
};

// file systems
// NOTE: the file operations defined here do not require an open file
struct fs_s
{
    const char *name;

    // file system ops
    int (*fs_mkfs)( mount_t * restrict mount, const char *label, bool removable );
    int (*fs_mount)( mount_t * restrict mount );
    int (*fs_umount)( mount_t *restrict mount, int flags );

    // file ops
    int (*fs_open)( mount_t * restrict mount, const char *name, unsigned int flags, file_t *file );
    int (*fs_munmap)( mount_t * restrict mount, void* addr, size_t len );
    int (*fs_unlink)( mount_t * restrict mount, const char *name );
    int (*fs_stat)( mount_t * restrict mount, const char *name, struct stat *stat );

    // dir ops
    int (*fs_opendir)( mount_t * restrict mount, const char *name, file_t *file );
    int (*fs_mkdir)( mount_t * restrict mount, const char *name );
    int (*fs_rmdir)( mount_t * restrict mount, const char *name );
    int (*fs_chdir)( mount_t * restrict mount, const char *name );
    // eCOS has getinfo()/setinfo() functions that are used for this, among other things...
    int (*fs_getcwd)( mount_t * restrict mount, char *buf, size_t size );

    // file or dir
    int (*fs_rename)( mount_t * restrict mount, const char *oldname, const char *newname );
    int (*fs_remove)( mount_t * restrict mount, const char *name );

    // special non-posix open call // FIXME: optimize this inside fs_fat
    int (*fs_open_dirent)( const struct dirent *dirent, unsigned int flags, file_t *file );
};

// file operations (including directories and devices)
// NOTE: the file operations defined here require a file descriptor ,i.e. an open file
struct fileops_s
{
    int (*f_read)( file_t *file );
    int (*f_write)( file_t *file );
#if ( __POSIX_MAPPED_FILES != 0 )
    int (*f_mmap)( file_t *file, void* addr, size_t len, int flags, off_t off, void** retval );
#endif
    int (*f_lseek)( file_t *file, off_t offset, int whence );
    int (*f_flush)( file_t *file, bool invalidate );
    int (*f_fstat)( file_t *file, struct stat *stat );
    int (*f_ctl)( file_t *file, int cmd, void *buf, size_t size, int *result );
    int (*f_close)( file_t *file );

    /* eCOS overloads read/lseek/close for this */
    int (*f_readdir)( file_t *file, struct dirent **dirent );
    int (*f_rewinddir)( file_t *file );
    int (*f_closedir)( file_t *file );
};

// open files (including directories, shm and devices)
struct file_s
{
    const char *name;       /* file ,device or shm name */
    const fileops_t *ops;   /* I/O functions */
    void *data;             /* file, device or shm specific data */
    ioreq_t *iotx;          /* write request */
    ioreq_t *iorx;          /* read request */
    mount_t *mount;         /* mount table entry */
};

// Interface for file system implementations
extern int register_fs( const fs_t * restrict fs );

// Implementation of file system ops returning ENOTSUP
extern int fs_mkfs_notsup( mount_t *restrict mount, const char *label, bool removable );
// fs_mount _must_ be supported
extern int fs_unmount_notsup( mount_t *restrict mount, int flags );

extern int fs_open_notsup( mount_t * restrict mount, const char *name, unsigned int flags, file_t *file );
extern int fs_munmap_notsup( mount_t * restrict mount, void* addr, size_t len );
extern int fs_unlink_notsup( mount_t * restrict mount, const char *name );
extern int fs_stat_notsup( mount_t * restrict mount, const char *name, struct stat *stat );

extern int fs_opendir_notsup( mount_t * restrict mount, const char *name, file_t *file );
extern int fs_mkdir_notsup( mount_t * restrict mount, const char *name );
extern int fs_rmdir_notsup( mount_t * restrict mount, const char *name );
extern int fs_chdir_notsup( mount_t * restrict mount, const char *name );
extern int fs_getcwd_notsup( mount_t * restrict mount, char *buf, size_t size );

extern int fs_rename_notsup( mount_t * restrict mount, const char *oldname, const char *newname );
extern int fs_remove_notsup( mount_t * restrict mount, const char *name );

extern int fs_open_dirent_notsup( const struct dirent *dirent, unsigned int flags, file_t *file );

// Implementation of file ops returning ENOTSUP
extern int f_read_notsup( file_t *file );
extern int f_write_notsup( file_t *file );
#if ( __POSIX_MAPPED_FILES != 0 )
extern int f_mmap_notsup( file_t *file, void* addr, size_t len, int flags, off_t off, void** retval );
#endif
extern int f_lseek_notsup( file_t *file, off_t offset, int whence );
extern int f_flush_notsup( file_t *file, bool invalidate );
extern int f_fstat_notsup( file_t *file, struct stat *stat );
extern int f_ctl_notsup( file_t *file, int cmd, void *buf, size_t size, int *result );
extern int f_close_notsup( file_t *file );

extern int f_readdir_notsup( file_t *file, struct dirent **dirent );
extern int f_rewinddir_notsup( file_t *file );
extern int f_closedir_notsup( file_t *file );

#endif /* _FSIO_H */

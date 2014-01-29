/******************************************************************************
|*
|* COPYRIGHT:   Copyright (c) 2008, ALtium
|*
|* DESCRIPTION: Virtual root file system.
|*
\******************************************************************************/

#include <assert.h>
#include <errno.h>
#include <string.h>

#include <fsio.h>

/* supported fs ops */

static int rootfs_mount( mount_t * restrict mount );
static int rootfs_stat( mount_t * restrict mount, const char *name, struct stat *stat );
static int rootfs_opendir( mount_t * restrict mount, const char *name, file_t *file );
static int rootfs_chdir( mount_t * restrict mount, const char *name );
static int rootfs_getcwd( mount_t * restrict mount, char *buf, size_t size );

/* supported file ops */

static int rootfs_fstat( file_t *file, struct stat *stat );
static int rootfs_readdir( file_t *file, struct dirent **dirent );
static int rootfs_rewinddir( file_t *file );
static int rootfs_closedir( file_t *file );

/* global data */

static mount_t *rootfs_mount_table;
static size_t rootfs_mount_table_size;
static size_t rootfs_index = 0;
static struct dirent rootfs_dirent; /* one global dirent for "/" */

/* file system implementation */

static const fs_t rootfs = {
    "rootfs",
    fs_mkfs_notsup,
    rootfs_mount,
    fs_unmount_notsup,
    fs_open_notsup,
    fs_munmap_notsup,
    fs_unlink_notsup,
    rootfs_stat,
    rootfs_opendir,
    fs_mkdir_notsup,
    fs_rmdir_notsup,
    rootfs_chdir,
    rootfs_getcwd,
    fs_rename_notsup,
    fs_remove_notsup,
    fs_open_dirent_notsup
};

// file operations (including directories and devices)
// NOTE: the file operations defined here require a file descriptor
static const fileops_t rootfs_fileops = {
    f_read_notsup,
    f_write_notsup,
#if ( __POSIX_MAPPED_FILES != 0 )
    f_mmap_notsup,
#endif
    f_lseek_notsup,
    f_flush_notsup,
    rootfs_fstat,
    f_ctl_notsup,
    f_close_notsup,

    /* eCOS overloads read/lseek/close for this */
    rootfs_readdir,
    rootfs_rewinddir,
    rootfs_closedir
};


/*
 * rootfs initialization, called from fs_plugin_init()
 */

extern void rootfs_init( mount_t mount_table[], size_t mount_table_size )
{
    rootfs_mount_table = mount_table;
    rootfs_mount_table_size = mount_table_size;

    register_fs( &rootfs );
    mount( "", "/", rootfs.name, 0, MOUNT_FLAG_RDONLY );
    chdir( "/" );
}

/*
 * filesystem operations
 */

static int rootfs_mount( mount_t * restrict mount )
{
    // nothing to do
    return 0;
}

static int rootfs_opendir( mount_t * restrict mount, const char *name, file_t *file )
{
    if ( *name == '\0' || strcmp( "/", name ) == 0 )
    {
        rootfs_index = 0;
        file->ops = &rootfs_fileops;
        return 0;
    }
    return ENOENT;
}

static int rootfs_chdir( mount_t * restrict mount, const char *name )
{
    if ( name == NULL || *name == '\0' || *name == '/' )
    {
        return 0;
    }

    return ENOTDIR;
}

static int rootfs_getcwd( mount_t * restrict mount, char *buf, size_t size )
{
    // buf already contains "/"
    return 0;
}

static int rootfs_stat( mount_t * restrict mount, const char *name, struct stat *stat )
{
    // TODO: implement stat
    return ENOTSUP;
}


/*
 * file operations
 */

static int rootfs_fstat( file_t *file, struct stat *stat )
{
    // TODO: implement stat
    return ENOTSUP;
}

static int rootfs_readdir( file_t *file, struct dirent **dirent )
{
    while ( rootfs_index < rootfs_mount_table_size )
    {
        mount_t *mount = rootfs_mount_table + rootfs_index++;
        const char *mp = mount->mountpoint;

        if ( mp )
        {
            if ( *mp == '/' )
            {
                mp++;
            }
            if ( *mp != '\0' )
            {
                strcpy( rootfs_dirent.d_name, mp );
                *dirent = &rootfs_dirent;
                return 0;
            }
        }
    }
    return EOF;
}

static int rootfs_rewinddir( file_t *file )
{
    rootfs_index = 0;
    return 0;
}

static int rootfs_closedir( file_t *file )
{
    return 0;
}

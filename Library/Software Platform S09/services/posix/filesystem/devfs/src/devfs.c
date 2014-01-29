/******************************************************************************
|*
|* COPYRIGHT:   Copyright (c) 2008, ALtium
|*
|* DESCRIPTION: Generic (POSIX-compatible) file system interface for devices.
|*
\******************************************************************************/

#include <assert.h>
#include <string.h>

#include <fs.h>
#include <fsio.h>
#include <devio.h>
#include <devio_adaptor.h>

// fs ops
static int devfs_mount( mount_t * restrict mount );
static int devfs_open( mount_t * restrict mount, const char *name, unsigned int flags, file_t *file );
static int devfs_munmap ( mount_t * restrict mount, void* addr, size_t len );
static int devfs_stat( mount_t * restrict mount, const char *name, struct stat *stat );
static int devfs_opendir( mount_t * restrict mount, const char *name, file_t *file );
static int devfs_chdir( mount_t * restrict mount, const char *name );
static int devfs_getcwd( mount_t * restrict mount, char *buf, size_t size );

// file ops
static int devfs_read( file_t *file );
static int devfs_write( file_t *file );
static int devfs_mmap( file_t *file, void* addr, size_t len, int flags, off_t off, void** retval );
static int devfs_lseek( file_t *file, off_t offset, int whence );
static int devfs_flush( file_t *file, bool invalidate );
static int devfs_fstat( file_t *file, struct stat *stat );
static int devfs_ctl( file_t *file, int cmd, void *buf, size_t size, int *result );
static int devfs_close( file_t *file );

static int devfs_readdir( file_t *file, struct dirent **dirent );
static int devfs_rewinddir( file_t *file );
static int devfs_closedir( file_t *file );

static const fs_t devfs = {
    "devfs",
    fs_mkfs_notsup,
    devfs_mount,
    fs_unmount_notsup,
    devfs_open,
    devfs_munmap,
    fs_unlink_notsup,
    devfs_stat,
    devfs_opendir,
    fs_mkdir_notsup,
    fs_rmdir_notsup,
    devfs_chdir,
    devfs_getcwd,
    fs_rename_notsup,
    fs_remove_notsup,
    fs_open_dirent_notsup
};

// file operations (including directories and devices)
// NOTE: the file operations defined here require a file descriptor
static const fileops_t devfs_fileops = {
    devfs_read,
    devfs_write,
    devfs_mmap,
    devfs_lseek,
    devfs_flush,
    devfs_fstat,
    devfs_ctl,
    devfs_close,

    /* eCOS overloads read/lseek/close for this */
    f_readdir_notsup,
    f_rewinddir_notsup,
    f_closedir_notsup
};

// dir operations (including directories and devices)
// NOTE: the file operations defined here require a file descriptor
static const fileops_t devfs_dirops = {
    f_read_notsup,
    f_write_notsup,
    f_mmap_notsup,
    f_lseek_notsup,
    f_flush_notsup,
    f_fstat_notsup,
    f_ctl_notsup,
    f_close_notsup,

    /* eCOS overloads read/lseek/close for this */
    devfs_readdir,
    devfs_rewinddir,
    devfs_closedir
};

static int devfs_dirindex = 0;
static struct dirent devfs_dirent; /* one global dirent for "/dev" */

/*
 * Plugin initialization
 */
extern void devfs_plugin_init( void )
{
    register_fs( &devfs );
    mount( "", "/dev", devfs.name, 0, MOUNT_FLAG_RDONLY );
}

/*
 * filesystem operations
 */

static int devfs_mount( mount_t * restrict mount )
{
    // nothing to do
    return 0;
}

static int devfs_open( mount_t * restrict mount, const char *name, unsigned int flags, file_t *file )
{
    void *dptr;

    while ( *name == '/' )
    {
        name++;
    }
    dptr = devio_getdev( devio_lookup( name ) );

    if ( dptr )
    {
        file->ops = &devfs_fileops;
        file->data = dptr;

        return devio_open( dptr, flags );
    }
    return -1;
}

static int devfs_munmap ( mount_t * restrict mount, void* addr, size_t len )
{
#if ( __POSIX_MAPPED_FILES != 0 )
       int ret = devio_munmap ( addr, len );
       if ( ret )
       {
          errno = ret;
          return -1;
       }
       return 0;
#else
     fs_munmap_notsup(mount,addr,len);
#endif
}


static int devfs_stat( mount_t * restrict mount, const char *name, struct stat *stat )
{
    // TODO: implement stat
    return ENOTSUP;
}

static int devfs_opendir( mount_t * restrict mount, const char *name, file_t *file )
{
    if ( *name == '\0' || strcmp( "/", name ) == 0 )
    {
        devfs_dirindex = 0;
        file->ops = &devfs_dirops;
        return 0;
    }
    return ENOENT;
}

static int devfs_chdir( mount_t * restrict mount, const char *name )
{
    if ( name == NULL || *name == '\0' || *name == '/' )
    {
        return 0;
    }

    return ENOTDIR;
}

static int devfs_getcwd( mount_t * restrict mount, char *buf, size_t size )
{
    // buffer already contains "/dev"
    return 0;
}

/*
 * file operations
 */

static int devfs_read( file_t *file )
{
    return devio_readwrite( file->data, file->iorx, false );
}

static int devfs_write( file_t *file )
{
    return devio_readwrite( file->data, file->iotx, true );
}

static int devfs_mmap( file_t *file, void* addr, size_t len, int flags, off_t off, void** retval )
{
#if ( __POSIX_MAPPED_FILES != 0 )
    return devio_mmap( file->data, addr, len, flags, off, retval );
#else
    return f_mmap_notsup(file, addr, len, flags, off, retval );
#endif
}

static int devfs_lseek( file_t *file, off_t offset, int whence )
{
    // called by fflush/printf
    return 0;
}

static int devfs_flush( file_t *file, bool invalidate )
{
    return devio_flush( file->data, invalidate );
}

static int devfs_ctl( file_t *file, int cmd, void *buf, size_t size, int *result )
{
    return devio_posix_devctl( file->data, cmd, buf, size, result );
}

static int devfs_close( file_t *file )
{
    return devio_close( file->data );
}

static int devfs_fstat( file_t *file, struct stat *stat )
{
    // TODO: implement stat
    return ENOTSUP;
}

static int devfs_readdir( file_t *file, struct dirent **dirent )
{
    if ( devfs_dirindex < DEV_MAX )
    {
        const char *dev = devio_table[devfs_dirindex++].name;

        if ( dev )
        {
            strcpy( devfs_dirent.d_name, dev );
            *dirent = &devfs_dirent;
            return 0;
        }
    }
    return EOF;
}

static int devfs_rewinddir( file_t *file )
{
    devfs_dirindex = 0;
    return 0;
}

static int devfs_closedir( file_t *file )
{
    return 0;
}

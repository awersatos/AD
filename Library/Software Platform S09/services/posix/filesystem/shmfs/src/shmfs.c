/******************************************************************************
|*
|* COPYRIGHT:   Copyright (c) 2008, ALtium
|*
|* DESCRIPTION: Generic (POSIX-compatible) file system interface for shared memory objects.
|*
\******************************************************************************/

#include <limits.h>

#if ( __POSIX_SHARED_MEMORY_OBJECTS != 0 )

#include <assert.h>
#include <string.h>

#include <fs.h>
#include <fsio.h>
#include <shmio.h>

// fs ops
static int shmfs_mount( mount_t * restrict mount );
static int shmfs_open ( mount_t * restrict mount, const char *name, unsigned int flags, file_t *file );
static int shmfs_munmap ( mount_t * restrict mount, void* addr, size_t len );
static int shmfs_unlink ( mount_t * restrict mount, const char *name );
static int shmfs_stat ( mount_t * restrict mount, const char *name, struct stat *stat );
static int shmfs_opendir( mount_t * restrict mount, const char *name, file_t *file );
static int shmfs_chdir ( mount_t * restrict mount, const char *name );
static int shmfs_getcwd( mount_t * restrict mount, char *buf, size_t size );

// file ops
#if ( __POSIX_MAPPED_FILES != 0 )
static int shmfs_mmap( file_t *file, void* addr, size_t len, int flags, off_t off, void** retval );
#endif
static int shmfs_lseek( file_t *file, off_t offset, int whence );
static int shmfs_flush( file_t *file, bool invalidate );
static int shmfs_fstat( file_t *file, struct stat *stat );
static int shmfs_ctl( file_t *file, int cmd, void *buf, size_t size, int *result );
static int shmfs_close( file_t *file );

static int shmfs_readdir( file_t *file, struct dirent **dirent );
static int shmfs_rewinddir( file_t *file );
static int shmfs_closedir( file_t *file );

static const fs_t shmfs = {
    "shmfs",
    fs_mkfs_notsup,
    shmfs_mount,
    fs_unmount_notsup,
    shmfs_open,
    shmfs_munmap,
    shmfs_unlink,
    shmfs_stat,
    shmfs_opendir,
    fs_mkdir_notsup,
    fs_rmdir_notsup,
    shmfs_chdir,
    shmfs_getcwd,
    fs_rename_notsup,
    fs_remove_notsup,
    fs_open_dirent_notsup
};

// file operations (including directories and devices)
// NOTE: the file operations defined here require a file descriptor
static const fileops_t shmfs_fileops = {
    f_read_notsup,
    f_write_notsup,
#if ( __POSIX_MAPPED_FILES != 0 )
    shmfs_mmap,
#endif    
    shmfs_lseek,
    f_flush_notsup,
    shmfs_fstat,
    f_ctl_notsup,
    shmfs_close,
    /* eCOS overloads read/lseek/close for this */
    f_readdir_notsup,
    f_rewinddir_notsup,
    f_closedir_notsup
};

// dir operations (including directories and devices)
// NOTE: the file operations defined here require a file descriptor
static const fileops_t shmfs_dirops = {
    f_read_notsup,
    f_write_notsup,
#if ( __POSIX_MAPPED_FILES != 0 )
    f_mmap_notsup,
#endif    
    f_lseek_notsup,
    f_flush_notsup,
    f_fstat_notsup,
    f_ctl_notsup,
    f_close_notsup,
    /* eCOS overloads read/lseek/close for this */
    shmfs_readdir,
    shmfs_rewinddir,
    shmfs_closedir
};

static int shmfs_dirindex = 0;
static struct dirent shmfs_dirent; /* one global dirent for "/shm" */

/*
 * Plugin initialization
 */
extern void shmfs_plugin_init( void )
{
    register_fs( &shmfs );
    mount( "", "/shm", shmfs.name, 0, MOUNT_FLAG_RDONLY );
}

/*
 * filesystem operations
 */

static int shmfs_mount( mount_t * restrict mount )
{
    // nothing to do
    return 0;
}

static int shmfs_open( mount_t * restrict mount, const char *name, unsigned int flags, file_t *file )
{
    int index;
    int ret;
    while ( *name == '/' )
    {
        name++;
    }
    if ( (ret = shmio_open( name, flags, &index)) == 0 )
    {
        file->ops           = &shmfs_fileops;
        file->data          = (void*)shmio_getshm(index);
        return 0;
    }
    return ret;
}

static int shmfs_munmap ( mount_t * restrict mount, void* addr, size_t len )
{
       int ret = shmio_munmap ( addr, len );
       if ( ret )
       {
          errno = ret;
          return -1;
       }
       return 0;
}


static int shmfs_unlink ( mount_t * restrict mount, const char *name )
{
       int ret;
       while ( *name == '/' )
       {
             name++;
       }

       ret = shmio_unlink( name );
       if ( ret )
       {
          errno = ret;
          return -1;
       }
       return 0;
}


static int shmfs_stat( mount_t * restrict mount, const char *name, struct stat *stat )
{
    // TODO: implement stat
    return ENOTSUP;
}

static int shmfs_opendir( mount_t * restrict mount, const char *name, file_t *file )
{
    if ( *name == '\0' || strcmp( "/", name ) == 0 )
    {
        shmfs_dirindex = 0;
        file->ops = &shmfs_dirops;
        return 0;
    }
    return ENOENT;
}

static int shmfs_chdir( mount_t * restrict mount, const char *name )
{
    if ( name == NULL || *name == '\0' || *name == '/' )
    {
        return 0;
    }

    return ENOTDIR;
}

static int shmfs_getcwd( mount_t * restrict mount, char *buf, size_t size )
{
    // buffer already contains "/shm"
    return 0;
}

/*
 * file operations
 */

#if ( __POSIX_MAPPED_FILES != 0 )
static int shmfs_mmap( file_t *file, void* addr, size_t len, int flags, off_t off, void** retval )
{
    return shmio_mmap( file->data, addr, len, flags, retval );
}
#endif

static int shmfs_lseek( file_t *file, off_t offset, int whence )
{
    // called by fflush/printf
    return 0;
}

static int shmfs_close( file_t *file )
{
    return shmio_close( file->data );
}

static int shmfs_fstat( file_t *file, struct stat *stat )
{
    // TODO: implement stat
    return ENOTSUP;
}

static int shmfs_readdir( file_t *file, struct dirent **dirent )
{
    if ( shmfs_dirindex < __POSIX_SHARED_MEMORY_OBJECT_MAX )
    {
        const char *shm = shmio_name(shmfs_dirindex++);
        if ( shm )
        {
            strcpy( shmfs_dirent.d_name, shm );
            *dirent = &shmfs_dirent;
            return 0;
        }
    }
    return EOF;
}

static int shmfs_rewinddir( file_t *file )
{
    shmfs_dirindex = 0;
    return 0;
}

static int shmfs_closedir( file_t *file )
{
    return 0;
}

#endif

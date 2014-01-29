/******************************************************************************
|*
|* COPYRIGHT:   Copyright (c) 2008, ALtium
|*
|* DESCRIPTION: Generic (POSIX-compatible) filesystem interface.
|*
\******************************************************************************/

#include <assert.h>
#include <errno.h>
#include <string.h>

#include <sysutils.h>
#include <fsio.h>
#include <rootfs.h>
#include <blockio.h>
#include <sys/mman.h>

// filesystem table
static const fs_t *filesystem_table[MAX_FS];

// mount table
static mount_t mount_table[MOUNT_TABLE_SIZE];
static mount_t *current_mount_point;

// file descriptor table (open files and directories)
// NOTE: for files we add an offset to the fd, so we don't run into problems with
//       default fd's for stdin, stdout, stderr in the C library
// NOTE: for directory streams we add an offset to make sure the (DIR*) pointer is never NULL
static file_t fd_table[FD_TABLE_SIZE];
#define FILE_OFFSET     3
#define DIR_OFFSET      FD_TABLE_SIZE

extern off_t _lseek( int fd, off_t offset, int whence );

/*
 * Plugin initialization
 */

extern void fs_plugin_init( void )
{
   for ( int i = 0; i < MAX_FS; i++ )
   {
        filesystem_table[i] = NULL;
   }
   rootfs_init( mount_table, MOUNT_TABLE_SIZE );
}


// partition table

/**
 * @brief
 *      Write a new partition table to a device
 *
 * This function writes to the master boot record of a device an installs a
 * partition table. The @em size argument is a four entry array describing the
 * division of the disk in 4 partitions according to the following rules:
 * - size[n] == 0 means entry n+1 not used
 * - size[n] > 0 means entry n+1 uses absoluut size in MB
 * - size[n] < 0 means entry n+1 uses relative size
 *
 * For example:
 * @code
 * write_partition_table( "/dev/BLOCKIO_0", { 10, -1, -4, 0 } );
 * @endcode
 *
 * This will:
 * - allocate 10 MB for partition 1
 * - allocate 1/5 of (disksize - 10 MB) for partition 2
 * - allocate 4/5 of (disksize - 10 MB) for partition 3
 * - mark partition 4 unused
 *
 *
 * @param device
 *      Block device name, e.g. "/dev/BLOCKIO_0"
 * @param size
 *      4-entry array describing the partition division
 *
 * @return
 *      Unallocated space in MB, or <0 on error.
 */
extern int write_partition_table( const char *device, int32_t size[] )
{
    int fd;
    int status;

    fd = open( device, O_RDWR );
    if ( fd < 0 )
    {
        return -1;
    }

    status = blockio_write_partitiontable( fd, size );
    close( fd );

    return status;
}

// filesystems

/* Look up filesystem
 *
 * type = filesystem type
 *
 * Returns fs_t pointer if successful, NULL otherwise.
 */
static const fs_t *lookup_fs( const char *name )
{
    if ( name != NULL )
    {
        for ( int i = 0; i < MAX_FS && filesystem_table[i] != NULL; i++ )
        {
            if ( strcmp( filesystem_table[i]->name, name ) == 0 )
            {
                return filesystem_table[i];
            }
        }
    }

    return NULL;
}

/* Register filesystem
 *
 * fs = fs_t pointer
 *
 * Returns 0 if successful, or -1 if the filesystem table is full.
 */
extern int register_fs( const fs_t * restrict fs )
{
    for ( int i = 0; i < MAX_FS; i++ )
    {
        if ( filesystem_table[i] == NULL )
        {
            filesystem_table[i] = fs;
            return 0;
        }
    }
    return -1;
}


// Mount points

/* lookup mount point and update path
 *
 * path = absolute or relative path
 * mount = output location for mount table entry
 * local_path = location of local part of the path
 *
 * Returns 0 if successful, or -1 otherwise.
 */
static int lookup_mount_point( const char *path, mount_t **mount, const char **local_path )
{
    const char *best = NULL;
    mount_t *best_mount = NULL;
    int best_len = 0;

    assert( path != NULL && mount != NULL );

    if ( *path != '/' )
    {
        if (!current_mount_point || current_mount_point->mountpoint[0] == '\0')
        {
            return -1;
        }

        *mount = current_mount_point;
        *local_path = path;
        return 0;
    }
    else
    {
        for ( int i = 0; i < MOUNT_TABLE_SIZE; i++ )
        {
            int len;

            if ( mount_table[i].mountpoint[0] == '\0' )
            {
                continue;
            }

            len = strlen(mount_table[i].mountpoint);

            if ( len > best_len )
            {
                if ( strncmp( mount_table[i].mountpoint, path, len ) == 0 )
                {
                    best_len = len;
                    best = path + len;
                    best_mount = &mount_table[i];
                }
            }
        }
        if ( best_len > 0 )
        {
            *mount = best_mount;
            if ( *best == '\0' )
            {
                *local_path = "/";
            }
            else
            {
                *local_path = best;
            }
            return 0;
        }
    }
    return -1;
}

/*
 * Public interface: mkfs, mount, umount, unmount
 */

/**
 * @brief
 *      Create filesystem on selected device partition
 *
 * This function creates a new filesystem on the device and partition specified.
 *
 * Limitations:
 * - No way to specify filesystem options like sectors per cluster or subtype, e.g. FAT16
 *
 * The @em partition argument:
 * - 0 = use entire disk
 * - 1 - 4 = use specified partition
 *
 * @param device
 *      Device name, e.g "/dev/BLOCKIO_0"
 * @param fsname
 *      Filesystem name, e.g. "fatfs"
 * @param partition
 *      Partition number or 0 to use entire disk
 * @param label
 *      Volume label or NULL
 * @param removable
 *      If true sets mediatype to "removable", otherwise to "fixed"
 *
 * @return
 *      0 if successful, -1 otherwise.
 *
 * @see
 *      mount
 */
extern int mkfs( const char *device, const char *fsname, unsigned int partition, const char *label, bool removable )
{
    const fs_t *fs = lookup_fs( fsname );
    int status;
    mount_t tmpmount;

    if ( !device || !fs )
    {
        errno = EINVAL;
        return -1;
    }

    // check if device isn't already mounted
    for ( int i = 0; i < MOUNT_TABLE_SIZE; i++ )
    {
        if ( mount_table[i].mountpoint[0] == '\0' )
        {
            continue;
        }
        if ( partition == mount_table[i].partition && strcmp( mount_table[i].devname, device ) == 0 )
        {
            errno = EBUSY;
            return -1;
        }
    }

    // use temporary mount structure
    tmpmount.mountpoint[0] = '\0';
    tmpmount.devname = device;
    tmpmount.fs = fs;
    tmpmount.partition = partition;
    tmpmount.flags = 0;

    status = fs->fs_mkfs( &tmpmount, label, removable );
    if ( status != 0 )
    {
        errno = status;
        return -1;
    }
    // success
    return 0;
}

/**
 * @brief
 *      Mount a filesystem
 *
 * This function mounts a filesystem on a device at a specified mount point.
 *
 * Limitations:
 * - "/" and "/dev" are reserved mount points
 * - Mount points must be subdirectories of the root, so "/sdcard" is fine, "/mnt/sdcard" is not.
 *
 * The @em partition argument:
 * - 0 = use entire disk
 * - 1 - 4 = use specified partition
 *
 * Example:
 * @code
 * // try mounting first partition
 * if ( mount( "/dev/BLOCKIO_0", "/sdcard", "fatfs", 1, MOUNT_FLAG_RDONLY ) < 0 )
 * {
 *     // try using entire disk instead
 *     if ( mount( "/dev/BLOCKIO_0", "/sdcard", "fatfs", 0, MOUNT_FLAG_RDONLY ) < 0 )
 *     {
 *         return -1;
 *     }
 * }
 * @endcode
 *
 * @param device
 *      device name, e.g "/dev/BLOCKIO_0"
 * @param mountpoint
 *      mount point, e.g. "/sdcard"
 * @param fsname
 *      filesystem (i.e. plugin) name, e.g. "fatfs"
 * @param partition
 *      partition number
 * @param flags
 *      mount flags, may be ignored depending on the filesystem
 *
 * @return
 *      0 if successful, -1 otherwise.
 *
 * @see
 *      mkfs
 *      umount
 *		unmount
 */
extern int mount( const char *device, const char *mountpoint, const char *fsname, unsigned int partition, unsigned int flags )
{
    const fs_t *fs = lookup_fs( fsname );
    int status;

    if ( !mountpoint || !device || !fs || (strlen(mountpoint) > NAME_MAX + 1))
    {
        errno = EINVAL;
        return -1;
    }

    // check if device isn't already mounted or mountpoint already used
    for ( int i = 0; i < MOUNT_TABLE_SIZE; i++ )
    {
        if ( mount_table[i].mountpoint[0] == '\0' )
        {
            continue;
        }
        if ( strcmp( mount_table[i].mountpoint, mountpoint ) == 0 )
        {
            errno = EBUSY;
            return -1;
        }
#if 0
        // Do we need this? I think not...
        if ( partition == mount_table[i].partition && strcmp( mount_table[i].devname, device ) == 0 )
        {
            errno = EBUSY;
            return -1;
        }
#endif
    }

    // find an empty table entry and mount the device
    for ( int i = 0; i < MOUNT_TABLE_SIZE; i++ )
    {
        if ( mount_table[i].mountpoint[0] == '\0' )
        {
            strcpy(mount_table[i].mountpoint, mountpoint);
            mount_table[i].devname = device;
            mount_table[i].fs = fs;
            mount_table[i].partition = partition;
            mount_table[i].flags = flags;

            status = fs->fs_mount( &mount_table[i] );
            if ( status != 0 )
            {
                errno = status;
                mount_table[i].mountpoint[0] = '\0';
                return -1;
            }
            // success
            return 0;
        }
    }
    // table full
    errno = ENOMEM;
    return -1;
}

/**
 * @brief
 *      Unmount filesystem
 *
 * This function unmounts the filesystem mounted on the specified mount point.
 *
 * @param mountpoint
 *      Mount point of the filesystem
 *
 * @return
 *      0 if successful, -1 otherwise.
 *
 * @see
 *      mount
 *		unmount
 */
extern int umount( const char *mountpoint )
{
    return unmount(mountpoint, 0);
}

/**
 * @brief
 *      Unmount filesystem
 *
 * This function unmounts the filesystem mounted on the specified mount point.
 *
 * @param mountpoint
 *      Mount point of the filesystem
 * @param flags
 *      Flags for unmounting the file system
 *
 * @return
 *      0 if successful, -1 otherwise.
 *
 * @see
 *      mount
 *		umount
 */
extern int unmount( const char *mountpoint, int flags )
{
    int status;

    if ( mountpoint )
    {
        for ( int i = 0; i < MOUNT_TABLE_SIZE; i++ )
        {
            if ( mount_table[i].mountpoint[0] == '\0' )
            {
                continue;
            }
            if ( strcmp( mount_table[i].mountpoint, mountpoint ) == 0 )
            {
                status = mount_table[i].fs->fs_umount( &mount_table[i], flags );
                if ( status != 0 && !(flags & MOUNT_FLAG_FORCE))
                {
                    errno = status;
                    return -1;
                }
                // success
                mount_table[i].mountpoint[0] = '\0';
                if (current_mount_point == &mount_table[i])
                {
                    current_mount_point = &mount_table[0];
                }
                return 0;
            }
        }
    }
    // no such mount point
    errno = EINVAL;
    return -1;
}


// File descriptors

/* Check validity of file descriptor
 *
 * fd = file descriptor
 *
 * Returns true if file descriptor is valid, or false otherwise;
 */
inline bool valid_fd( int fd )
{
    return ( fd >= 0 && fd < FD_TABLE_SIZE && fd_table[fd].mount != NULL );
}

/* Allocate new file descriptor
 *
 * mount = mount table entry of current filesystem
 * file = location for resulting file pointer
 *
 * Returns file descriptor if successful, -1 otherwise.
 */
static int allocate_fd( mount_t *mount, file_t **file )
{
    assert( mount->mountpoint[0] );

    for ( int i = 0; i < FD_TABLE_SIZE; i++ )
    {
        if ( !fd_table[i].mount )
        {
            fd_table[i].mount = mount;
            *file = &fd_table[i];
            return i;
        }
    }

    return -1;
}

/* Free file descriptor
 *
 * fd = file descriptor
 *
 * Returns nothing.
 */
static void free_fd( int fd )
{
    assert( valid_fd( fd ) );
    fd_table[fd].mount = NULL;
}


// C library I/O 'backend'

/* Open file
 *
 * path = file path with optional mount point
 * flags = access flags
 *
 * Return file descriptor if successful, or -1 otherwise.
 */
#pragma alias _open=open
extern int open( const char *path, int flags, ... /* mode_t */ )
{
    mount_t *mount;
    int fd;
    file_t *file;
    int status;

    if ( !path )
    {
        return -1;
    }

    status = lookup_mount_point( path, &mount, &path );
    if ( status != 0 )
    {
        return -1;
    }

    fd = allocate_fd( mount, &file );
    if ( fd < 0 )
    {
        errno = ENOMEM;
        return -1;
    }

    file->name = path;
    status = mount->fs->fs_open( mount, path, (unsigned int)flags, file );

    if ( status != 0 )
    {
        errno = status;
        free_fd( fd );
        return -1;
    }

    return fd + FILE_OFFSET;
}

#pragma alias _close=close
extern int close( int fd )
{
    file_t *file;
    int status;

    fd -= FILE_OFFSET;
    if ( !valid_fd( fd ) )
    {
        errno = EBADF;
        return -1;
    }

    file = &fd_table[fd];
    status = file->ops->f_close( file );

    if ( status != 0 )
    {
        errno = status;
        return -1;
    }

    free_fd( fd );
    return 0;
}

#pragma alias _read=read
extern ssize_t read( int fd, void *buffer, size_t size )
{
    file_t *file;
    int status;
    ioreq_t io;

    fd -= FILE_OFFSET;
    if ( !valid_fd( fd ) )
    {
        errno = EBADF;
        return -1;
    }
    else if ( buffer == NULL )
    {
        errno = EINVAL;
        return -1;
    }
    else if ( size == 0 )
    {
        return 0;
    }

    CANCELLATION_POINT();

    file = &fd_table[fd];

    io.buf = buffer;
    io.len = size;
    io.cnt = 0;

    file->iorx = &io;
    status = file->ops->f_read( file );

    CANCELLATION_POINT();

    if ( status != 0 )
    {
        errno = status;
        return -1;
    }

    return io.cnt;
}

#pragma alias _write=write
extern ssize_t write( int fd, const void *buffer, size_t size )
{
    file_t *file;
    int status;
    ioreq_t io;

    fd -= FILE_OFFSET;
    if ( !valid_fd( fd ) )
    {
        errno = EBADF;
        return -1;
    }
    else if ( buffer == NULL )
    {
        errno = EINVAL;
        return -1;
    }
    else if ( size == 0 )
    {
        return 0;
    }

    CANCELLATION_POINT();

    file = &fd_table[fd];

    io.buf = (void*)buffer;
    io.len = size;
    io.cnt = 0;

    file->iotx = &io;
    status = file->ops->f_write( file );

    CANCELLATION_POINT();

    if ( status != 0 )
    {
        errno = status;
        return -1;
    }

    return io.cnt;
}

extern void *mmap( void *addr, size_t len,  int prot, int flags, int fildes, off_t off )
{
    file_t  *file;
    int     status;
    void    *ret;

    fildes -= FILE_OFFSET;
    if ( !valid_fd( fildes ) )
    {
        errno = EBADF;
        return MAP_FAILED;
    }

    if ( len == 0 )
    {
        errno = EINVAL;
        return MAP_FAILED;
    }

    file = &fd_table[fildes];
    status = file->ops->f_mmap( file, addr, len, flags, off, &ret );
    if ( status != 0 )
    {
        errno = status;
        return MAP_FAILED;
    }

    return ret;
}

extern int munmap(void *addr, size_t len)
{
    for ( int i = 0; i < MOUNT_TABLE_SIZE; i++ )
    {
        if ( mount_table[i].fs->fs_munmap( &mount_table[i], addr, len ) == 0 )
        {
            return 0;
        }
    }
    return EINVAL;
}

extern int shm_open(const char *name, int oflag, mode_t mode)
{
       /* add '/shm/' to the path */
       char    mntname[PATH_MAX] = { '/','s','h','m','/', 0 };
       /* and route it to normal 'open' call */
       return open ( strncat( mntname, name, strlen(name)), oflag );
}

extern int shm_unlink(const char *name)
{
       /* add '/shm/' to the name */
        char    mntname[PATH_MAX] = { '/','s','h','m','/', 0 };
       /* and route it to normal 'unlink' call */
       return unlink ( strncat( mntname, name, strlen(name)) );
}


extern int posix_devctl( int fd, int dcmd, void *dev_data_ptr, size_t nbyte, int *dev_info_ptr )
{
    file_t *file;
    int status;

    fd -= FILE_OFFSET;
    if ( !valid_fd( fd ) )
    {
        errno = EBADF;
        return -1;
    }

    CANCELLATION_POINT();

    file = &fd_table[fd];

    status = file->ops->f_ctl( file, dcmd, dev_data_ptr, nbyte, dev_info_ptr );

    CANCELLATION_POINT();

    if ( status != 0 )
    {
        errno = status;
        return -1;
    }

    return 0;
}

extern off_t lseek(int fd, off_t offset, int whence)
{
        return _lseek(fd, offset, whence);
}

extern off_t _lseek( int fd, off_t offset, int whence )
{
    file_t *file;
    off_t result;

    fd -= FILE_OFFSET;
    if ( !valid_fd( fd ) )
    {
        errno = EBADF;
        return -1;
    }

    CANCELLATION_POINT();

    file = &fd_table[fd];

    result = file->ops->f_lseek( file, offset, whence );

    CANCELLATION_POINT();

    // NOTE: errno should be set by implementation
    return result;
}

extern int fstat( int fd, struct stat *stat )
{
    file_t *file;
    int status;

    fd -= FILE_OFFSET;
    if ( !valid_fd( fd ) )
    {
        errno = EBADF;
        return -1;
    }

    CANCELLATION_POINT();

    file = &fd_table[fd];

    status = file->ops->f_fstat( file, stat );

    CANCELLATION_POINT();

    if ( status != 0 )
    {
        errno = status;
        return -1;
    }

    return 0;
}

extern int access( const char *name, int amode )
{
    mount_t *mount;
    int status;
    struct stat statbuf;

    if ( !name )
    {
        errno = ENOENT;
        return -1;
    }

    status = lookup_mount_point( name, &mount, &name );
    if ( status != 0 )
    {
        errno = ENOENT;
        return -1;
    }

    status = mount->fs->fs_stat( mount, name, &statbuf );
    if ( status != 0 )
    {
        errno = status;
        return -1;
    }

    /* if amode == F_OK we're done, otherwise check the requested access permissions */
    if ( amode != F_OK )
    {
        if ( amode & R_OK == R_OK && statbuf.st_mode & S_IRUSR != S_IRUSR )
        {
            errno = EACCES;
            return -1;
        }
        if ( amode & W_OK == W_OK && statbuf.st_mode & S_IWUSR != S_IWUSR )
        {
            errno = EACCES;
            return -1;
        }
        if ( amode & X_OK == X_OK && statbuf.st_mode & S_IXUSR != S_IXUSR )
        {
            errno = EACCES;
            return -1;
        }
    }

    return 0;
}

extern int stat( const char *name, struct stat *stat )
{
    mount_t *mount;
    int status;

    if ( !name )
    {
        return -1;
    }

    status = lookup_mount_point( name, &mount, &name );
    if ( status != 0 )
    {
        return -1;
    }

    status = mount->fs->fs_stat( mount, name, stat );
    if ( status != 0 )
    {
        errno = status;
        return -1;
    }

    return 0;
}

extern int rename( const char *oldname, const char *newname )
{
    mount_t *mount;
    mount_t *mount2;
    int status;

    if ( !oldname || !newname )
    {
        return -1;
    }

    status = lookup_mount_point( oldname, &mount, &oldname );
    if ( status != 0 )
    {
        return -1;
    }

    status = lookup_mount_point( newname, &mount2, &newname );
    if ( status != 0 )
    {
        return -1;
    }
    if ( mount != mount2 )
    {
        return -1;
    }

    status = mount->fs->fs_rename( mount, oldname, newname );
    if ( status != 0 )
    {
        errno = status;
        return -1;
    }

    return 0;
}

extern int remove( const char *name )
{
    mount_t *mount;
    int status;

    if ( !name )
    {
        return -1;
    }

    status = lookup_mount_point( name, &mount, &name );
    if ( status != 0 )
    {
        return -1;
    }

    status = mount->fs->fs_remove( mount, name );
    if ( status != 0 )
    {
        errno = status;
        return -1;
    }

    return 0;
}

#pragma alias _unlink=unlink
extern int unlink( const char *name )
{
    mount_t *mount;
    int status;

    if ( !name )
    {
        return -1;
    }

    status = lookup_mount_point( name, &mount, &name );
    if ( status != 0 )
    {
        return -1;
    }

    status = mount->fs->fs_unlink( mount, name );
    if ( status != 0 )
    {
        errno = status;
        return -1;
    }

    return 0;
}


// directory operations

extern DIR* opendir( const char *dir )
{
    mount_t *mount;
    int fd;
    file_t *file;
    int status;

    if ( !dir )
    {
        return NULL;
    }

    status = lookup_mount_point( dir, &mount, &dir );
    if ( status != 0 )
    {
        return NULL;
    }

    fd = allocate_fd( mount, &file );
    if ( fd < 0 )
    {
        errno = ENOMEM;
        return NULL;
    }

    file->name = dir;
    status = mount->fs->fs_opendir( mount, dir, file );

    if ( status != 0 )
    {
        errno = status;
        free_fd( fd );
        return NULL;
    }

    fd += DIR_OFFSET;
    return (DIR*)fd;
}

extern int closedir( DIR *dir )
{
    file_t *file;
    int status;
    int fd = (int)dir;

    fd -= DIR_OFFSET;
    if ( !valid_fd( fd ) )
    {
        errno = EBADF;
        return -1;
    }

    CANCELLATION_POINT();

    file = &fd_table[fd];

    status = file->ops->f_closedir( file );

    CANCELLATION_POINT();

    if ( status != 0 )
    {
        errno = status;
        return -1;
    }

    free_fd( fd );
    return 0;
}

extern struct dirent *readdir( DIR *dir )
{
    file_t *file;
    int status;
    struct dirent *dirent;
    int fd = (int)dir;

    fd -= DIR_OFFSET;
    if ( !valid_fd( fd ) )
    {
        errno = EBADF;
        return NULL;
    }

    CANCELLATION_POINT();

    file = &fd_table[fd];

    status = file->ops->f_readdir( file, &dirent );

    CANCELLATION_POINT();

    if ( status != 0 )
    {
        errno = status;
        return NULL;
    }

    return dirent;
}

extern void rewinddir( DIR *dir )
{
    file_t *file;
    int status;
    int fd = (int)dir;

    fd -= DIR_OFFSET;
    if ( !valid_fd( fd ) )
    {
        return;
    }

    file = &fd_table[fd];

    status = file->ops->f_rewinddir( file );
}

extern int mkdir( const char *dir, mode_t ignored )
{
    mount_t *mount;
    int status;

    if ( !dir )
    {
        return -1;
    }

    status = lookup_mount_point( dir, &mount, &dir );
    if ( status != 0 )
    {
        return -1;
    }

    status = mount->fs->fs_mkdir( mount, dir );

    if ( status != 0 )
    {
        errno = status;
        return -1;
    }

    return 0;
}

extern int rmdir( const char *dir )
{
    mount_t *mount;
    int status;

    if ( !dir )
    {
        return -1;
    }

    status = lookup_mount_point( dir, &mount, &dir );
    if ( status != 0 )
    {
        return -1;
    }

    status = mount->fs->fs_rmdir( mount, dir );

    if ( status != 0 )
    {
        errno = status;
        return -1;
    }

    return 0;
}

extern int chdir( const char *dir )
{
    mount_t *mount;
    int status;

    if ( !dir )
    {
        return -1;
    }

    status = lookup_mount_point( dir, &mount, &dir );
    if ( status != 0 )
    {
        return -1;
    }

    status = mount->fs->fs_chdir( mount, dir );

    if ( status != 0 )
    {
        errno = status;
        return -1;
    }

    current_mount_point = mount;

    return 0;
}

extern char *getcwd( char *buf, size_t size )
{
    mount_t *mount = current_mount_point;
    int len;
    char *cwd = NULL;

    if (mount)
    {
        len = strlen( mount->mountpoint );
        if ( size > len )
        {
            strcpy( buf, mount->mountpoint );
            if ( mount->fs->fs_getcwd( mount, buf + len, size - len ) == 0 )
            {
                cwd = buf;
            }
        }
    }

    return cwd;
}

/*
 * Implementation of filesystem ops returning ENOTSUP
 */

extern int fs_mkfs_notsup( mount_t *restrict mount, const char *label, bool removable )
{
    return ENOTSUP;
}

extern int fs_unmount_notsup( mount_t *restrict mount, int flags )
{
    return ENOTSUP;
}

extern int fs_open_notsup( mount_t * restrict mount, const char *name, unsigned int flags, file_t *file )
{
    return ENOTSUP;
}

extern int fs_munmap_notsup( mount_t * restrict mount, void* addr, size_t len )
{
    return ENOTSUP;
}

extern int fs_unlink_notsup( mount_t * restrict mount, const char *name )
{
    return ENOTSUP;
}

extern int fs_stat_notsup( mount_t * restrict mount, const char *name, struct stat *stat )
{
    return ENOTSUP;
}

extern int fs_opendir_notsup( mount_t * restrict mount, const char *name, file_t *file )
{
    return ENOTSUP;
}

extern int fs_mkdir_notsup( mount_t * restrict mount, const char *name )
{
    return ENOTSUP;
}

extern int fs_rmdir_notsup( mount_t * restrict mount, const char *name )
{
    return ENOTSUP;
}

extern int fs_chdir_notsup( mount_t * restrict mount, const char *name )
{
    return ENOTSUP;
}

extern int fs_getcwd_notsup( mount_t * restrict mount, char *buf, size_t size )
{
    return ENOTSUP;
}

extern int fs_rename_notsup( mount_t * restrict mount, const char *oldname, const char *newname )
{
    return ENOTSUP;
}

extern int fs_remove_notsup( mount_t * restrict mount, const char *name )
{
    return ENOTSUP;
}

extern int fs_open_dirent_notsup( const struct dirent *dirent, unsigned int flags, file_t *file )
{
    return ENOTSUP;
}


/*
 * Implementation of file ops returning ENOTSUP
 */

extern int f_read_notsup( file_t *file )
{
    return ENOTSUP;
}

extern int f_write_notsup( file_t *file )
{
    return ENOTSUP;
}

#if ( __POSIX_MAPPED_FILES != 0 )
extern int f_mmap_notsup( file_t *file, void* addr, size_t len, int flags, off_t off, void** retval )
{
    return ENOTSUP;
}
#endif

extern int f_lseek_notsup( file_t *file, off_t offset, int whence )
{
    return ENOTSUP;
}

extern int f_flush_notsup( file_t *file, bool invalidate )
{
    return ENOTSUP;
}

extern int f_fstat_notsup( file_t *file, struct stat *stat )
{
    return ENOTSUP;
}

extern int f_ctl_notsup( file_t *file, int cmd, void *buf, size_t size, int *result )
{
    return ENOTSUP;
}

extern int f_close_notsup( file_t *file )
{
    return ENOTSUP;
}

extern int f_readdir_notsup( file_t *file, struct dirent **dirent )
{
    return ENOTSUP;
}

extern int f_rewinddir_notsup( file_t *file )
{
    return ENOTSUP;
}

extern int f_closedir_notsup( file_t *file )
{
    return ENOTSUP;
}




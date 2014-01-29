/******************************************************************************
|*
|* COPYRIGHT:   Copyright (c) 2008, ALtium
|*
|* DESCRIPTION: Generic (POSIX-compatible) file system interface for FAT.
|*
\******************************************************************************/

#include <string.h>
#include <fsio.h>
#include "fatfs.h"
#include "fat.h"

/*
 * POSIX file system implementation
 */

// file system ops
static int fatfs_mkfs( mount_t * restrict mount, const char *label, bool removable );
static int fatfs_mount( mount_t * restrict mount );
static int fatfs_unmount( mount_t *restrict mount, int flags );
static int fatfs_open( mount_t * restrict mount, const char *name, unsigned int flags, file_t *file );
static int fatfs_unlink( mount_t * restrict mount, const char *name );
static int fatfs_stat( mount_t * restrict mount, const char *name, struct stat *statbuf );
static int fatfs_opendir( mount_t * restrict mount, const char *name, file_t *file );
static int fatfs_mkdir( mount_t * restrict mount, const char *name );
static int fatfs_rmdir( mount_t * restrict mount, const char *name );
static int fatfs_chdir( mount_t * restrict mount, const char *name );
static int fatfs_getcwd( mount_t * restrict mount, char *buf, size_t size );
static int fatfs_rename( mount_t * restrict mount, const char *oldname, const char *newname );
static int fatfs_remove( mount_t * restrict mount, const char *name );
static int fatfs_open_dirent( const struct dirent *dirent, unsigned int flags, file_t *file );

// file ops
static int fatfs_read( file_t * restrict file );
static int fatfs_write( file_t * restrict file );
#if ( __POSIX_MAPPED_FILES != 0 )
static int fatfs_mmap( file_t * restrict file, void* addr, size_t len, int flags, off_t off, void** retval );
#endif
static int fatfs_lseek( file_t * restrict file, off_t offset, int whence );
static int fatfs_flush( file_t * restrict file, bool invalidate );
static int fatfs_fstat( file_t * restrict file, struct stat *statbuf );
static int fatfs_ctl( file_t * restrict file, int cmd, void *buf, size_t size, int *result );
static int fatfs_close( file_t * restrict file );

// dir ops
static int fatfs_readdir( file_t * restrict file, struct dirent **dirent );
static int fatfs_rewinddir( file_t * restrict file );
static int fatfs_closedir( file_t * restrict file );


/*
 * Data structures
 */

// file systems
// NOTE: the file operations defined here do not require an open file
static const fs_t fatfs = {
    "fatfs",
    fatfs_mkfs,
    fatfs_mount,
    fatfs_unmount,
    fatfs_open,
    fs_munmap_notsup,
    fatfs_unlink,
    fatfs_stat,
    fatfs_opendir,
    fatfs_mkdir,
    fatfs_rmdir,
    fatfs_chdir,
    fatfs_getcwd,
    fatfs_rename,
    fatfs_remove,
    fatfs_open_dirent
};

// file operations
// NOTE: the file operations defined here require a file descriptor, i.e. an open file
static const fileops_t fatfs_fileops = {
    fatfs_read,
    fatfs_write,
#if ( __POSIX_MAPPED_FILES != 0 )
    fatfs_mmap,
#endif
    fatfs_lseek,
    fatfs_flush,
    fatfs_fstat,
    fatfs_ctl,
    fatfs_close,

    f_readdir_notsup,
    f_rewinddir_notsup,
    f_closedir_notsup
};

// directory operations
// NOTE: the file operations defined here require a file descriptor, i.e. an open file
static const fileops_t fatfs_dirops = {
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

    fatfs_readdir,
    fatfs_rewinddir,
    fatfs_closedir,
};

/*
 * Data
 */

// NOTE: maximum open files is 31 (no 32 is reserved for scratch FCBs)
// each possible file takes up a FCB in RAM
#if ( FOPEN_MAX > 31 )
#define MAX_OPENFILES           32
#else
#define MAX_OPENFILES           FOPEN_MAX
#endif
#define MAX_DIRENTRIES          MAX_OPENFILES

// the filemask for file 32 (bit 31 set) is reserved for scratch purposes
#define FCB_FILEMASK_SCRATCH    0x80000000

// file systems
static fatfs_t fatfs_table[FATFS_MOUNT_MAX];

// FCB's
static fs_fcb_t fcblist[MAX_OPENFILES];
static fs_fcb_t *fcb_free;

// Directory data
static fatfs_dirent_t direntlist[MAX_DIRENTRIES];
static fatfs_dirent_t *dirent_free;

/*
 * Plugin initialization
 */

extern void fatfs_plugin_init( void )
{
    uint8_t i;
    uint32_t filemask;
    fs_fcb_t *fcb;
    fatfs_dirent_t *dirent;

    /* chain all fcb's into the free fcb list */
    filemask = 1;
    fcb_free = NULL;
    fcb = &fcblist[MAX_OPENFILES - 1];
    for ( i = MAX_OPENFILES; i > 0; --i, --fcb )
    {
        fcb->filemask = filemask;
        fcb->fs = NULL;
        fcb->fcb_next = fcb_free;
        fcb_free = fcb;
        filemask <<= 1;
    }
    /* chain all dirent structures into the free dirent list */
    dirent_free = NULL;
    dirent = &direntlist[MAX_DIRENTRIES - 1];
    for ( i = MAX_DIRENTRIES; i > 0; --i, --dirent )
    {
        dirent->fs = NULL;
        dirent->dirent_next = dirent_free;
        dirent_free = dirent;
    }

    /* register file system */
    register_fs( &fatfs );
}

/*
 * Helper functions
 */

static fatfs_t *get_free_fs( mount_t *mount )
{
    for ( int i = 0; i < FATFS_MOUNT_MAX; i++ )
    {
        fatfs_t *restrict fatfs = &fatfs_table[i];
        if ( ( fatfs->flags & FS_FLAG_MOUNTED ) == 0 )
        {
            memset(fatfs, 0, sizeof(*fatfs));
#if ( FATFS_USE_MUTEX != 0 )
            pthread_mutexattr_t mutexattr;

            pthread_mutexattr_init( &mutexattr );
            pthread_mutex_init( &fatfs->mutex, &mutexattr );
#endif

            fatfs->block_device = mount->devname;
            fatfs->partition_nr = mount->partition;

            /* set file system in error state before it has been opened */
            fatfs->error = 1;

            /* uninitialized file descriptor */
            fatfs->blk_id = -1;

            return fatfs;
        }
    }
    return NULL;
}

static void release_fs( fatfs_t *restrict fatfs )
{
    // set flag to 0
    fatfs->flags = 0;
    if (fatfs->blk_id != -1)
    {
        // close the device
        close(fatfs->blk_id);
    }
}

// find free file descriptor
static fs_fcb_t *fcb_allocate( fatfs_t * fs )
{
    fs_fcb_t *fcb;

    if ( !fcb_free )
    {
        debugprintf( "***NO MORE HANDLES ***\n" );
        return 0;
    }

    // remove fcb from single linked free fcb list
    fcb = fcb_free;
    fcb_free = fcb->fcb_next;

    // insert new fcb at head of double linked open fcb list for fs
    if ( fs->fcblist )
    {
        fs->fcblist->fcb_prev = fcb;
    }
    fcb->fcb_next = fs->fcblist;
    fcb->fcb_prev = 0;
    fs->fcblist = fcb;

    fcb->fs = fs;
    fcb->dirent = NULL;

    return fcb;
}

// return file descriptor to the free pool
static void fcb_release( fs_fcb_t * restrict fcb )
{
    fatfs_t *fs = fcb->fs;

    // remove fcb from double linked open fcb list for fs
    if ( fcb->fcb_prev )
    {
        fcb->fcb_prev->fcb_next = fcb->fcb_next;
    }
    else
    {
        if (fs != NULL)
        {
            fs->fcblist = fcb->fcb_next;
        }
    }

    if ( fcb->fcb_next )
    {
        fcb->fcb_next->fcb_prev = fcb->fcb_prev;
    }

    // insert fcb at head of single linked free fcb list
    fcb->fcb_next = fcb_free;
    fcb_free = fcb;

    fcb->fs = 0;
}

// find free dirent structure
static fatfs_dirent_t *dirent_allocate( fatfs_t *fs )
{
    fatfs_dirent_t *dirent;

    if ( !dirent_free )
    {
        debugprintf( "***NO MORE HANDLES ***\n" );
        return NULL;
    }

    // remove dirent from single linked free dirent list
    dirent = dirent_free;
    dirent_free = dirent->dirent_next;

    memset( (void*)dirent, 0, sizeof( dirent ) );
    dirent->fs = fs;

    return dirent;
}

// return dirent structure to the free pool
static void dirent_release( fatfs_dirent_t * dirent )
{
    // insert dirent at head of single linked free dirent list
    dirent->dirent_next = dirent_free;
    dirent_free = dirent;

    dirent->fs = 0;
}

/*
 * Filesystem tree traversing/parsing
 *
 * fs           filesystem
 * node         node of starting dir
 * name_p       name incl optional drive & path
 *
 * Returns 0 if found, < 0 if error.
 */
static int findnode( fatfs_t * fs, uint32_t node, fatfs_dirent_t * dirent, const char **name_p )
{
    const char *name = *name_p;
    int status;

    dirent->fs = fs;
    dirent->dirnode = node;

    if ( *name == FS_DIRSEPCHAR )
    {
        // from root on
        dirent->dirnode = dirent->fs->rootdir_node;
        name += 1;
    }
    else if ( dirent->dirnode == ( uint32_t ) -1 )
    {
        // default to current dir
        dirent->dirnode = dirent->fs->curdir_node;
    }

    // we start from a directory by definition
    // simulate finding one in case we only need the current dir
    dirent->node = dirent->dirnode;
    dirent->attributes = FS_ATTRIBUTE_SUBDIR;

    while ( *name )
    {
        if ( ( name[0] == '.' ) && ( name[1] == FS_DIRSEPCHAR ) )
        {
            name += 2;
        }
        else if ( ( name[0] == '.' ) && !name[1] )
        {
            name += 1;
        }
        else if ( *name == FS_DIRSEPCHAR )
        {
            name += 1;
        }
        else
        {
            char *slashpos = strchr( name, FS_DIRSEPCHAR );

            if ( ( slashpos - name ) > NAME_MAX )
            {
                return ENAMETOOLONG;
            }

            // use scratch FCB
            fs_fcb_t fcb = {0};
            uint8_t found = 0;
            fcb.filemask = FCB_FILEMASK_SCRATCH;
            fcb.fs = dirent->fs;
            fcb.flags = O_RDONLY;

            status = fat_diropen( &fcb, dirent->dirnode );
            if ( status != 0 )
            {
                return status;
            }

            status = fat_dirread( &fcb, dirent, name, 0 );
            if ( status == 0 )
            {
                found = 1;
            }

            fat_close( &fcb );

            if ( !found )
            {
                // no file or dir found

                // show to where could parse the path
                *name_p = name;

                return status;
            }

            if ( !slashpos )
            {
                return 0;
            }

            // we only resolved a level of the path
            name = slashpos + 1;
            dirent->dirnode = dirent->node;
        }
    }

    // we have a trailing backslash or an empty name, only acceptable if we were looking for a directory
    // (empty name for a dir equals '.')
    if ( !( dirent->attributes & FS_ATTRIBUTE_SUBDIR ) )
    {
        // no file or dir found
        return ENOENT;
    }

    return 0;
}

/*
 * File system operations
 */

static int fatfs_mkfs( mount_t * restrict mount, const char *label, bool removable )
{
    fatfs_t *fatfs = get_free_fs( mount );
    int status;

    if ( !fatfs )
    {
        return ENOMEM;
    }

    FATFS_MUTEX_PREPARE();
    FATFS_MUTEX_LOCK( fatfs );

    status = fat_mkfs( fatfs, 0, 0, removable, label, fatfs->cache );

    FATFS_MUTEX_UNLOCK( fatfs );

    if ( status < 0 )
    {
        errno = status;
        status = -1;
    }
    else
    {
        status = 0;
    }

    return status;
}

static int fatfs_mount( mount_t * restrict mount )
{
    fatfs_t *fatfs = get_free_fs( mount );
    int status;

    if ( !fatfs )
    {
        return ENOMEM;
    }

    FATFS_MUTEX_PREPARE();
    FATFS_MUTEX_LOCK( fatfs );

    // this sets mounted flag
    status = fat_open_filesystem( fatfs, (uint16_t)mount->flags, fatfs->cache, FATFS_CACHE_ELEM );
    if ( status == 0 )
    {
        mount->data = (void*)fatfs;
        fatfs->flags |= FS_FLAG_MOUNTED;
    }
    else
    {
        mount->data = NULL;
        release_fs(fatfs);
    }

    FATFS_MUTEX_UNLOCK( fatfs );

    return status;
}

static int fatfs_unmount( mount_t *restrict mount, int flags )
{
    fatfs_t *fatfs = mount->data;
    int status;

    FATFS_MUTEX_PREPARE();
    FATFS_MUTEX_LOCK( fatfs );
    status = fat_flush_all( fatfs, 1 );
    FATFS_MUTEX_UNLOCK( fatfs );

    if (flags & MOUNT_FLAG_FORCE)
    {
        if ( fatfs->filecount_open > 0 )
        {
            fs_fcb_t *fcb;
            fcb = fatfs->fcblist;
            while (fcb != NULL)
            {
                fcb->fs = NULL;
                fcb = fcb->fcb_next;
            }
            fatfs->filecount_open = 0;
        }
        release_fs(fatfs);
    }
    else
    {
        if ( status == 0 )
        {
            if ( fatfs->filecount_open > 0 )
            {
                status = EBUSY;
            }
            if ( status == 0 )
            {
                release_fs(fatfs);
            }
        }
    }

    return status;
}

static int fatfs_open( mount_t * restrict mount, const char *name, unsigned int flags, file_t *file )
{
    fatfs_dirent_t dirent;
    uint8_t newfile = 0;
    int status = 0;
    fatfs_t * restrict fatfs = mount->data;

    FATFS_MUTEX_PREPARE();
    FATFS_MUTEX_LOCK( fatfs );

    if ( findnode( fatfs, -1, &dirent, &name ) )
    {
        if ( ( flags & O_CREAT ) && !strchr( name, FS_DIRSEPCHAR ) )
        {
            // findnode could parse up to the last dirsep, so we can create the file
            newfile = 1;
        }
        else
        {
            // not found
            status = ENOENT;
        }
    }

    if ( status == 0 )
    {
        if ( ( flags & ( O_CREAT | O_RDWR | O_WRONLY ) ) && ( dirent.fs->flags & FS_FLAG_RDONLY ) )
        {
            // read only
            status = EROFS;
        }
        else if ( !newfile && ( dirent.attributes & FS_ATTRIBUTE_SUBDIR ) )
        {
            // trying to open an existing directory
            status = EISDIR;
        }
        else
        {
            fs_fcb_t *fcb = fcb_allocate( dirent.fs );

            if ( !fcb )
            {
                // too many open files
                status = EMFILE;
            }
            else if ( newfile && strlen( name ) > NAME_MAX )
            {
                status = ENAMETOOLONG;
            }
            else
            {
                fcb->flags = flags;

                if ( newfile )
                {
                    strncpy( dirent.dirent.d_name, name, NAME_MAX + 1 );
                    dirent.size = 0;
                    dirent.attributes = 0;

                    status = fat_create( fcb, &dirent );
                    if (  status != 0 )
                    {
                        fcb_release( fcb );
                    }
                }
                else
                {
                    status = fat_open( fcb, &dirent );
                    if ( status != 0 )
                    {
                        fcb_release( fcb );
                    }
                }
            }

            if ( status == 0 )
            {
                fcb->size = dirent.size;
                fcb->attributes = dirent.attributes;

                file->ops = &fatfs_fileops;
                file->data = fcb;
            }
        }
    }

    FATFS_MUTEX_UNLOCK( fatfs );

    return status;
}

static int fatfs_unlink( mount_t * restrict mount, const char *name )
{
    return fatfs_remove( mount, name );
}

static int fatfs_stat( mount_t * restrict mount, const char *name, struct stat *statbuf )
{
    fatfs_dirent_t dirent;
    int status = 0;
    fatfs_t * restrict fatfs = mount->data;

    FATFS_MUTEX_PREPARE();
    FATFS_MUTEX_LOCK( fatfs );


    status = findnode( fatfs, -1, &dirent, &name );
    if ( status == 0 )
    {
        memset((void*)statbuf, 0, sizeof(struct stat));
        statbuf->st_dev = (dev_t)fatfs;
        statbuf->st_ino = (ino_t)dirent.node;
        statbuf->st_size = dirent.size;

        if ( dirent.attributes & FS_ATTRIBUTE_SUBDIR )
        {
            statbuf->st_mode = S_IFDIR;
        }
        else
        {
            statbuf->st_mode = S_IFREG;
        }
        if ( fatfs->flags & FS_FLAG_RDONLY )
        {
            statbuf->st_mode |= (S_IRUSR | S_IXUSR | S_IRGRP | S_IXGRP | S_IROTH | S_IXOTH);
        }
        else
        {
            statbuf->st_mode |= (S_IRWXU | S_IRWXG | S_IRWXO);
        }
        // TODO: time values
    }

    FATFS_MUTEX_UNLOCK( fatfs );

    return status;
}

static int fatfs_opendir( mount_t * restrict mount, const char *name, file_t *file )
{
    fatfs_t * restrict fatfs = mount->data;
    fatfs_dirent_t dirent;
    int status = 0;

    FATFS_MUTEX_PREPARE();
    FATFS_MUTEX_LOCK( fatfs );

    if ( findnode( fatfs, -1, &dirent, &name ) )
    {
        // not found
        status = ENOENT;
    }
    else if ( !( dirent.attributes & FS_ATTRIBUTE_SUBDIR ) )
    {
        // is not a dir
        status = ENOTDIR;
    }
    else
    {
        fs_fcb_t *fcb = fcb_allocate( dirent.fs );
        if ( !fcb )
        {
            // too many open files
            status = EMFILE;
        }
        else
        {
            status = fat_diropen( fcb, dirent.node );
            if ( status == 0 )
            {
                fcb->size = dirent.size;
                fcb->attributes = dirent.attributes;

                file->ops = &fatfs_dirops;
                file->data = fcb;
            }
            else
            {
                fcb_release( fcb );
            }
        }
    }

    FATFS_MUTEX_UNLOCK( fatfs );

    return status;
}

static int fatfs_mkdir( mount_t * restrict mount, const char *name )
{
    fatfs_dirent_t dirent;
    int status = 0;
    fatfs_t * restrict fatfs = mount->data;

    FATFS_MUTEX_PREPARE();
    FATFS_MUTEX_LOCK( fatfs );

    if ( fatfs->flags & FS_FLAG_RDONLY )
    {
        // read only
        status = EROFS;
    }
    else if ( !findnode( fatfs, -1, &dirent, &name ) )
    {
        // already file or dir with that name
        status = EEXIST;
    }
    else if ( strchr( name, FS_DIRSEPCHAR ) )
    {
        // findnode could not parse up to the last dirsep
        status = ENOENT;
    }
    else if ( strlen( name ) > NAME_MAX )
    {
        status = ENAMETOOLONG;
    }
    else
    {
        // use scratch FCB
        fs_fcb_t fcb = {0};
        fcb.filemask = FCB_FILEMASK_SCRATCH;
        fcb.fs = dirent.fs;

        strncpy( dirent.dirent.d_name, name, NAME_MAX + 1 );
        dirent.attributes = FS_ATTRIBUTE_SUBDIR;

        status = fat_mkdir( &fcb, &dirent );
    }

    FATFS_MUTEX_UNLOCK( fatfs );

    return status;
}

static int fatfs_rmdir( mount_t * restrict mount, const char *name )
{
    return fatfs_remove( mount, name );
}

static int fatfs_chdir( mount_t * restrict mount, const char *name )
{
    fatfs_dirent_t dirent;
    int status = 0;
    fatfs_t * restrict fatfs = mount->data;

    FATFS_MUTEX_PREPARE();
    FATFS_MUTEX_LOCK( fatfs );

    if ( findnode( fatfs, -1, &dirent, &name ) )
    {
        // not found
        status = ENOENT;
    }
    else if ( !( dirent.attributes & FS_ATTRIBUTE_SUBDIR ) )
    {
        // is not a dir
        status = ENOTDIR;
    }
    else
    {
        fatfs->curdir_node = dirent.node;
    }

    FATFS_MUTEX_UNLOCK( fatfs );

    return status;
}

static int fatfs_getcwd( mount_t * restrict mount, char *buf, size_t size )
{
    fatfs_t * restrict fatfs = mount->data;
    fatfs_dirent_t dirent;
    uint32_t dirnode;
    uint32_t parentnode;
    char dotdot[] = "..";
    const char unknown[] = { '?', ':', FS_DIRSEPCHAR, 0 };
    const char *dotdotp = dotdot;
    int bufpos;
    int namelen;
    int status;
    int subdir;
    fs_fcb_t fcb = {0};

    FATFS_MUTEX_PREPARE();
    FATFS_MUTEX_LOCK( fatfs );

    bufpos = size;
    buf[--bufpos] = 0;

    // setup scratch FCB
    fcb.fs = fatfs;
    fcb.filemask = FCB_FILEMASK_SCRATCH;
    fcb.flags = O_RDONLY;

    // this is where we are
    dirnode = fatfs->curdir_node;

    status = 0;
    subdir = 0;
    for ( ;; )
    {
        // find our parentdirectory
        if ( findnode( fatfs, dirnode, &dirent, &dotdotp ) )
        {
            break;
        }                       // no more ..-dir

        parentnode = dirent.node;

        if ( dirent.node == dirnode )
        {
            break;
        }                       // ..-dir points to itself

        status = fat_diropen( &fcb, parentnode );
        if ( status != 0 )
        {
            break;
        }
        // look up the entry for ourselves
        status = fat_dirread( &fcb, &dirent, 0, dirnode );

        fat_close( &fcb );

        if ( status != 0 )
        {
            break;
        }

        // glue name in front of the buffer
        namelen = strlen( dirent.dirent.d_name );
        if ( bufpos <= ( namelen + 1 ) )
        {
            status =ENOMEM;
            break;
        }
        if ( subdir )
        {
            buf[--bufpos] = FS_DIRSEPCHAR;
        }

        bufpos -= namelen;
        memcpy( buf + bufpos, dirent.dirent.d_name, namelen );

        dirnode = parentnode;
        subdir = 1;
    }

    if ( status == 0 )
    {
        if ( bufpos <= 1 ) /* use 3 when using drive letters: 'a:/' */
        {
            status = ENOMEM;
        }
        else
        {
            // glue root dir in front of the buffer
            buf[--bufpos] = FS_DIRSEPCHAR;

            // shift buffer to front
            memcpy( buf, buf + bufpos, size - bufpos );
        }
    }

    FATFS_MUTEX_UNLOCK( fatfs );

    return status;
}

static int fatfs_rename( mount_t * restrict mount, const char *oldname, const char *newname )
{
    fatfs_t * restrict fatfs = mount->data;
    fatfs_dirent_t dirent_old;
    fatfs_dirent_t dirent;
    uint32_t newdirnode = (uint32_t)-1;
    int status = 0;
    bool done = false;

    FATFS_MUTEX_PREPARE();
    FATFS_MUTEX_LOCK( fatfs );

    if ( fatfs->flags & FS_FLAG_RDONLY )
    {
        // read only
        status = EROFS;
        done = true;
    }
    else if ( findnode( fatfs, -1, &dirent_old, &oldname ) )
    {
        // not found
        status = ENOENT;
        done = true;
    }
    else if ( findnode( fatfs, -1, &dirent, &newname ) )
    {
        // new name does not exist

        if ( strchr( newname, FS_DIRSEPCHAR ) )
        {
            // findnode could not parse up to the last dirsep
            // so even the containing directory does not exists
            status = ENOTDIR;
            done = true;
        }
        else
        {
            newdirnode = dirent.dirnode;
        }
    }
    else if ( !( dirent.attributes & FS_ATTRIBUTE_SUBDIR ) )
    {
        // new name exists as a file
        status = EEXIST;
        done = true;
    }
    else
    {
        // new name exists as directory, just move
        newdirnode = dirent.node;
        newname = 0;
    }

    if ( status == 0 )
    {
        if ( dirent_old.fs != dirent.fs )
        {
            // cross device move
            status = EXDEV;
            done = true;
        }
        else if ( ( dirent_old.dirnode == newdirnode ) && ( !newname ) )
        {
            // no new name and same directory -> no action needed
            status = 0;
            done = true;
        }
        else if ( ( dirent_old.dirnode != newdirnode ) && ( dirent_old.attributes & FS_ATTRIBUTE_SUBDIR ) )
        {
            int dirnode = newdirnode;

            // dir move, check if not circular
            for ( ;; )
            {
                // multiple checks to see if we end up on the rootnode,
                // different filesystems behave in different ways:
                // (1) cd .. fails, or (2) node is rootnode as specified for filesystem,
                // or (3) cd .. does not change directory
                char dotdot[] = "..";
                const char *p = dotdot;

                if ( findnode( dirent.fs, dirnode, &dirent, &p ) ||
                     ( dirent.node == dirent.fs->rootdir_node ) || ( dirent.node == dirnode ) )
                {
                    break;
                }

                if ( dirent.node == dirent_old.node )
                {
                    // move would create circular tree
                    status = EINVAL;
                    done = true;
                    break;
                }

                dirnode = dirent.node;
            }
        }

        if ( !done )
        {
            // use scratch FCB
            fs_fcb_t fcb = {0};
            fcb.filemask = FCB_FILEMASK_SCRATCH;
            fcb.fs = dirent_old.fs;

            status = fat_rename( &fcb, &dirent_old, newdirnode, newname );
        }
    }

    FATFS_MUTEX_UNLOCK( fatfs );

    return status;
}

static int fatfs_remove( mount_t * restrict mount, const char *name )
{
    fatfs_dirent_t dirent;
    int status = 0;
    fatfs_t * restrict fatfs = mount->data;

    FATFS_MUTEX_PREPARE();
    FATFS_MUTEX_LOCK( fatfs );

    if ( fatfs->flags & FS_FLAG_RDONLY )
    {
        // read only
        status = EROFS;
    }
    else if ( findnode( fatfs, -1, &dirent, &name ) )
    {
        // not found
        status = ENOENT;
    }
    else
    {
        // use scratch FCB
        fs_fcb_t fcb = {0};
        fcb.filemask = FCB_FILEMASK_SCRATCH;
        fcb.fs = dirent.fs;

        status = fat_remove( &fcb, &dirent );
    }

    FATFS_MUTEX_UNLOCK( fatfs );

    return status;
}

static int fatfs_open_dirent( const struct dirent *dirent, unsigned int flags, file_t *file )
{
    fatfs_dirent_t *fat_dirent = (fatfs_dirent_t *)dirent;
    fatfs_t * restrict fatfs = file->mount->data;
    int status = 0;

    // check if we allocated this directory entry
    if ( fat_dirent < direntlist || fat_dirent >= direntlist + MAX_DIRENTRIES )
    {
        return fatfs_open( file->mount, dirent->d_name, flags, file );
    }

    FATFS_MUTEX_PREPARE();
    FATFS_MUTEX_LOCK( fatfs );

    if ( ( flags & ( O_CREAT | O_RDWR | O_WRONLY ) ) && ( fatfs->flags & FS_FLAG_RDONLY ) )
    {
        // read only
        status = EROFS;
    }
    else
    {
        fs_fcb_t *fcb = fcb_allocate( fatfs );
        if ( !fcb )
        {
            // too many open files
            status = EMFILE;
        }
        else
        {
            fcb->flags = flags;

            status = fat_open( fcb, fat_dirent );
            if ( status == 0 )
            {
                fcb->size = fat_dirent->size;
                fcb->attributes = fat_dirent->attributes;

                file->ops = &fatfs_fileops;
                file->data = fcb;
            }
            else
            {
                fcb_release( fcb );
            }
        }
    }

    FATFS_MUTEX_UNLOCK( fatfs );

    return status;
}

// file ops
static int fatfs_read( file_t * restrict file )
{
    fs_fcb_t *fcb = file->data;
    int status = 0;

    if ( !fcb )
    {
        status = EBADF;
    }
    else if ( ( ( fcb->flags & O_ACCMODE ) != O_RDONLY ) && ( ( fcb->flags & O_ACCMODE ) != O_RDWR ) )
    {
        status = EACCES;
    }
    else
    {
        FATFS_MUTEX_PREPARE();
        FATFS_MUTEX_LOCK( fcb->fs );
        file->iorx->cnt = fat_read( fcb, file->iorx->buf, file->iorx->len );
        FATFS_MUTEX_UNLOCK( fcb->fs );
    }

    return status;
}

static int fatfs_write( file_t * restrict file )
{
    fs_fcb_t *fcb = file->data;
    int status = 0;

    if ( !fcb )
    {
        status = EBADF;
    }
    else if ( ( ( fcb->flags & O_WRONLY ) != O_WRONLY ) && ( ( fcb->flags & O_RDWR ) != O_RDWR ) )
    {
        status = EACCES;
    }
    else
    {
        FATFS_MUTEX_PREPARE();
        FATFS_MUTEX_LOCK( fcb->fs );
        file->iotx->cnt = fat_write( fcb, file->iotx->buf, file->iotx->len );
        FATFS_MUTEX_UNLOCK( fcb->fs );
    }

    return status;
}

#if ( __POSIX_MAPPED_FILES != 0 )
static int fatfs_mmap( file_t * restrict file, void* addr, size_t len, int flags, off_t off, void** retval )
{
    // TODO: implement mmap
    return ENOTSUP;
}
#endif
static int fatfs_lseek( file_t * restrict file, off_t offset, int whence )
{
    fs_fcb_t *fcb = file->data;
    int status = 0;

    if ( !fcb )
    {
        status = EBADF;
    }
    else
    {
        FATFS_MUTEX_PREPARE();
        FATFS_MUTEX_LOCK( fcb->fs );
        status = fat_seek( fcb, offset, (uint8_t)whence );
        FATFS_MUTEX_UNLOCK( fcb->fs );
    }

    return status;
}

static int fatfs_flush( file_t * restrict file, bool invalidate )
{
    fs_fcb_t *fcb = file->data;
    int status = 0;

    if ( !fcb )
    {
        status = EBADF;
    }
    else
    {
        FATFS_MUTEX_PREPARE();
        FATFS_MUTEX_LOCK( fcb->fs );
        status = fat_flush( fcb );
        FATFS_MUTEX_UNLOCK( fcb->fs );
    }

    return status;
}

static int fatfs_fstat( file_t * restrict file, struct stat *statbuf )
{
    fs_fcb_t *fcb = file->data;
    int status = 0;

    FATFS_MUTEX_PREPARE();
    FATFS_MUTEX_LOCK( fcb->fs );

    memset((void*)statbuf, 0, sizeof(struct stat));
    statbuf->st_dev = (dev_t)fcb->fs;
    statbuf->st_ino = (ino_t)fcb->u.fat.cluster;
    statbuf->st_size = fcb->size;

    if ( fcb->attributes & FS_ATTRIBUTE_SUBDIR )
    {
        statbuf->st_mode = S_IFDIR;
    }
    else
    {
        statbuf->st_mode = S_IFREG;
    }
    if ( ( fcb->flags & O_ACCMODE ) == O_RDONLY )
    {
        statbuf->st_mode |= (S_IRUSR | S_IXUSR | S_IRGRP | S_IXGRP | S_IROTH | S_IXOTH);
    }
    else if ( ( fcb->flags & O_ACCMODE ) == O_WRONLY )
    {
        statbuf->st_mode |= (S_IWUSR | S_IXUSR | S_IWGRP | S_IXGRP | S_IWOTH | S_IXOTH);
    }
    else
    {
        statbuf->st_mode |= (S_IRWXU | S_IRWXG | S_IRWXO);
    }
    // TODO: time values

    FATFS_MUTEX_UNLOCK( fcb->fs );

    return status;
}

static int fatfs_ctl( file_t * restrict file, int cmd, void *buf, size_t size, int *result )
{
    return ENOTSUP;
}

static int fatfs_close( file_t * restrict file )
{
    fs_fcb_t *fcb = file->data;
    fatfs_t * restrict fatfs = fcb->fs;
    int status = 0;

    if ( !fcb )
    {
        status = EBADF;
    }
    else
    {
        FATFS_MUTEX_PREPARE();
        FATFS_MUTEX_LOCK( fatfs );
        status = fat_close( fcb );
        if ( status == 0 )
        {
            fcb_release( fcb );
            file->ops = NULL;
            file->data = NULL;
        }
        FATFS_MUTEX_UNLOCK( fatfs );
    }

    return status;
}

// dir ops
static int fatfs_readdir( file_t * restrict file, struct dirent **dirent )
{
    fs_fcb_t *fcb = file->data;
    fatfs_dirent_t *fat_dirent;
    int status = 0;

    if ( !fcb )
    {
        status = EBADF;
    }
    else
    {
        // reuse existing dirent
        if ( fcb->dirent )
        {
            fat_dirent = fcb->dirent;
        }
        else
        {
            fcb->dirent = fat_dirent = dirent_allocate( fcb->fs );
        }

        if ( !fat_dirent )
        {
            status = ENOMEM;
        }
        else
        {
            FATFS_MUTEX_PREPARE();
            FATFS_MUTEX_LOCK( fcb->fs );
            /* skip volume labels */
            do
            {
                status = fat_dirread( fcb, fat_dirent, NULL /* wildcard */, 0 );
            } while ( status == 0 && fat_dirent->attributes & FATFS_ATTRIBUTE_VOLUME );
            if ( status == 0 )
            {
                *dirent = (struct dirent *)fat_dirent;
            }
            else
            {
                dirent_release( fat_dirent );
                fcb->dirent = NULL;
            }
            FATFS_MUTEX_UNLOCK( fcb->fs );
        }
    }

    return status;
}

static int fatfs_rewinddir( file_t * restrict file )
{
    fs_fcb_t *fcb = file->data;
    int status = 0;

    if ( !fcb )
    {
        status = EBADF;
    }
    else
    {
        FATFS_MUTEX_PREPARE();
        FATFS_MUTEX_LOCK( fcb->fs );
        fat_fcb_pos_at_node( fcb->fs, fcb, fcb->u.fat.cluster );
        FATFS_MUTEX_UNLOCK( fcb->fs );
    }
    return status;
}

static int fatfs_closedir( file_t * restrict file )
{
    fs_fcb_t *fcb = file->data;
    fatfs_t * restrict fatfs = fcb->fs;
    int status = 0;

    if ( !fcb )
    {
        status = EBADF;
    }
    else
    {
        FATFS_MUTEX_PREPARE();
        FATFS_MUTEX_LOCK( fatfs );
        status = fat_close( fcb );
        if ( status == 0 )
        {
            if ( fcb->dirent )
            {
                dirent_release( fcb->dirent );
                fcb->dirent = NULL;
            }
            fcb_release( fcb );
            file->ops = NULL;
            file->data = NULL;
        }
        FATFS_MUTEX_UNLOCK( fatfs );
    }

    return status;
}

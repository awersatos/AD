#include <limits.h>

#include <sys/mman.h>
#include <stdlib.h>
#include <stdbool.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>
#include "shmio.h"
#if ( __POSIX_KERNEL__ != 0 )
#include <pthread.h>
#endif

typedef struct shmio_t {
        char            name[ PATH_MAX ];
        bool            unlink;
        bool            alloc;
        int             index;
        int             ref;
        int             len;
        void*           addr;
} shmio_t ;


static struct shmio_t _shmio_table[ __POSIX_SHARED_MEMORY_OBJECT_MAX ];

#if ( __POSIX_KERNEL__ != 0 )
static pthread_mutex_t           _shmio_mutex = PTHREAD_MUTEX_INITIALIZER;
# define POSIX_SHM_LOCK()        pthread_mutex_lock(&_shmio_mutex)
# define POSIX_SHM_UNLOCK()      pthread_mutex_unlock(&_shmio_mutex)
#else
# define POSIX_SHM_LOCK()
# define POSIX_SHM_UNLOCK()
#endif

static void         shmio_free( shmio_t * shm );
static shmio_t*     shmio_lookup_name (const char*);
static shmio_t*     shmio_lookup_addr (void *);

void    shmio_init(void)
{
        int i;
        struct shmio_t*       shm;

        for ( i=0, shm = &_shmio_table[0];
              i < __POSIX_SHARED_MEMORY_OBJECT_MAX ; i++,shm++ )
        {
                shmio_free ( shm );
                shm->name[0]         = '\0';
                shm->unlink          = false;
                shm->ref             = 0;
                shm->index           = i;
        }
        return;
}

static void shmio_free( struct shmio_t * shm )
{
        if ( shm->alloc == true )
        {
                free( shm->addr );
                shm->alloc = false;
        }
        shm->addr       = NULL;
        shm->len        = 0;
}

static shmio_t* shmio_alloc (const char* name)
{
        /* search for empty entry in shm table */
        int i = 0;
        for (; i < __POSIX_SHARED_MEMORY_OBJECT_MAX ; i++ )
        {
                if ( _shmio_table[i].name[0] == '\0' &&
                     _shmio_table[i].unlink == false )
                break;
        }
        if ( i ==  __POSIX_SHARED_MEMORY_OBJECT_MAX)
        {
                /* Too many shared memory objects are currently open */
                return NULL;
        }

        strncpy( _shmio_table[i].name, name, PATH_MAX );
        _shmio_table[i].ref    = 1;
        _shmio_table[i].unlink = false;

        return &_shmio_table[i];
}

static shmio_t* shmio_lookup_name (const char* name)
{
        /* find shm among the opened ones */
        int i = 0;
        for (; i < __POSIX_SHARED_MEMORY_OBJECT_MAX; i++ )
        {
                if ( 0 == strncmp(name, _shmio_table[i].name, PATH_MAX) )
                {
                        return &_shmio_table[i];
                }
        }
        return (shmio_t*)NULL;
}

static shmio_t* shmio_lookup_addr (void * addr)
{
        int i=0;
        for ( ; i < __POSIX_SHARED_MEMORY_OBJECT_MAX; i++ )
        {
                if ( _shmio_table[i].addr == addr )
                {
                        return &_shmio_table[i];
                }
        }
        return NULL;
}

int shmio_mmap   (       void*   pshm,
                        void*   addr,
                        size_t  len,
                        int     flags,
                        void**  retval)
{
        int             ret = 0;
        shmio_t     *shm = (shmio_t*)pshm;

        POSIX_SHM_LOCK();

        if (    shm->name[0] == '\0' && shm->unlink == false )
        {
                ret = EBADF;
        }
        else
        {
                if ( shm->addr != NULL )
                {
                        if (flags & MAP_FIXED || len != shm->len)
                        {
                                ret = EINVAL;
                        }
                        else
                        {
                                shm->ref++;
                                *retval = shm->addr;
                        }
                }
                else
                {
                        if ( flags & MAP_FIXED )
                        {
                                shm->addr = addr;
                        }
                        else
                        {
                                shm->addr  = malloc(len);
                                shm->alloc = true;
                        }
                        shm->ref++;
                        shm->len = len;
                        *retval = shm->addr;
                }
        }

        POSIX_SHM_UNLOCK();

        return ret;
}

int     shmio_open (     const char *path,
                         int oflag,
                         int* index )
{
        struct shmio_t *shm = NULL;
        int retval              = 0;

        POSIX_SHM_LOCK();
        shm = shmio_lookup_name ( path );

        if (    (NULL != shm) && ( (oflag & (O_EXCL | O_CREAT)) == (O_EXCL | O_CREAT) ) )
        {
                /* O_CREAT and O_EXCL are set and the named
                 * shared memory object already exists */
                retval = EEXIST;
        }
        else if ( (NULL == shm) && (O_CREAT != (oflag & O_CREAT)) )
        {
                /* O_CREAT is not set and the named message queue
                 * does not exist */
                retval  = ENOENT;
        }
        else if (NULL == shm)
        {
                shm = shmio_alloc ( path );

                if ( shm == NULL )
                {
                        retval = ENFILE;
                }
        }
        else
        {
                if ( shm->unlink == true )
                {
                        /* but cannot open anymore */
                        retval = EACCES;
                }
                else
                {
                        shm->ref++;
                }
        }
        POSIX_SHM_UNLOCK();

        if ( (shm!=NULL) && (index!=NULL)  )
        {
                *index  = shm->index + DEV_MAX;
        }
        return retval;
}

extern const char*  shmio_name ( int fildes )
{
    if ( fildes < DEV_MAX || fildes >= DEV_MAX + __POSIX_SHARED_MEMORY_OBJECT_MAX )
    {
        return NULL;
    }
    return _shmio_table[fildes-DEV_MAX].name;
}

extern void*        shmio_getshm( int fildes )
{
    if ( fildes < DEV_MAX || fildes >= DEV_MAX + __POSIX_SHARED_MEMORY_OBJECT_MAX )
    {
        return NULL;
    }
    return &_shmio_table[fildes-DEV_MAX];
}

int shmio_unlink(const char *path)
{

        int ret = 0;
        struct shmio_t *shm ;

        if ( strlen(path) > PATH_MAX )
        {
                return ENAMETOOLONG;
        }

        POSIX_SHM_LOCK();
        shm = shmio_lookup_name ( path );
        if ( NULL == shm )
        {
                ret =  ENOENT;
        }
        else
        {
                shm->unlink = true;
                shm->name[0] = '\0';
                if ( shm->ref == 0 )
                {
                        shmio_free ( shm );
                }
        }
        POSIX_SHM_UNLOCK();
        return ret;
}

int shmio_close( void * pshm)
{
        shmio_t     *shm = (shmio_t*)pshm;

        if ( shm == NULL )
        {
                return EBADF;
        }

        POSIX_SHM_LOCK();
        if ( --shm->ref == 0 && shm->unlink == true )
        {
                shmio_free ( shm );
                shm->unlink = false;
        }

        POSIX_SHM_UNLOCK();
        return 0;
}

int shmio_munmap(void *addr, size_t len)
{
        struct shmio_t*     shm;
        int                 retval = EINVAL;

        POSIX_SHM_LOCK();

        shm = shmio_lookup_addr ( addr );

        if ( shm )
        {
                if ( len != shm->len )
                {
                        goto munmap_exit;
                }

                if ( shm->ref ) shm->ref--;

                if ( shm->ref == 0 && shm->unlink == true )
                {
                        shmio_free( shm );
                        shm->unlink = false;
                }
                retval = 0;
        }

munmap_exit:
        POSIX_SHM_UNLOCK();
        return retval;
}



extern int shm_open(const char *name, int oflag, mode_t mode)
{
       /* add '/shm/' to the path */
       char    mntname[PATH_MAX] = { '/','s','h','m','/', 0 };
       strncat( mntname, name, strlen(name));
       /* and route it to normal 'open' call */
       return open ( mntname, oflag );
}

extern int shm_unlink(const char *name)
{
       /* add '/shm/' to the name */
        char    mntname[PATH_MAX] = { '/','s','h','m','/', 0 };
       /* and route it to normal 'unlink' call */
       return unlink ( strncat( mntname, name, strlen(name)) );
}



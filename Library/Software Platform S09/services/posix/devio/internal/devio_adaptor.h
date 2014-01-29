/******************************************************************************
 * FILE:        devio_adaptor.h
 * DESCRIPTION:
 *      Adaptor interface for POSIX device I/O
 *****************************************************************************/

#ifndef _DEVIO_ADAPTOR_H
#define _DEVIO_ADAPTOR_H

#include <limits.h>

#include <stdbool.h>
#include <ioreq.h>

/* data structures */

typedef struct devio_iofuns_s devio_iofuns_t;
typedef struct devio_s        devio_t;
typedef struct devlink_s      devlink_t;

struct devio_s
{
    const char*         name;       /* device name/path */
    devio_iofuns_t*     iofuns;     /* device implementation */
    void *              device;     /* device specific information */
    ioreq_t*            iotx;       /* write io request */
    ioreq_t*            iorx;       /* read io request */

#if ( __POSIX_MAPPED_FILES != 0 )
    /* mmap */
    int                 mmaps;
    int                 mmaplen;
    void*               mmapaddr;
#endif
};

struct devio_iofuns_s
{
    int (*init) (devio_t*, int);
    int (*write)(devio_t*);
    int (*read) (devio_t*);
    int (*ctl)  (devio_t*, int, void *, size_t, int *);
#if ( __POSIX_MAPPED_FILES != 0 )
    int (*mmap) (devio_t*, void*, size_t, int, off_t, void**);
#endif
    int (*flush)(devio_t *, int);
};

struct devlink_s
{
    const char *       name;
    devio_t*           dev;
};

/* convenience functions to create device data structures */

inline void DEV_IOFUNS_CREATE( devio_iofuns_t* iofuns,
                               int (*init) (devio_t*, int),
                               int (*write)(devio_t*),
                               int (*read) (devio_t*),
                               int (*ctl)  (devio_t*, int, void *, size_t, int *),
                               int (*mmap) (devio_t*, void*, size_t, int, off_t, void**),
                               int (*flush)(devio_t *, int) )
{
    iofuns->init        = init;
    iofuns->write       = write;
    iofuns->read        = read;
    iofuns->ctl         = ctl;

#if ( __POSIX_MAPPED_FILES != 0 )
    iofuns->mmap        = mmap;
#endif

    iofuns->flush       = flush;

    return;
}

inline void DEV_CREATE( devio_t * dev,
                        const char * name,
                        devio_iofuns_t* iofuns,
                        void* device )
{
    dev->name           = name;
    dev->iofuns         = iofuns;
    dev->device         = device;
    dev->iotx           = (ioreq_t*)NULL;
    dev->iorx           = (ioreq_t*)NULL;

#if ( __POSIX_MAPPED_FILES != 0 )
    dev->mmaps          = 0;
    dev->mmaplen        = 0;
    dev->mmapaddr       = (void*)0;
#endif

    return;
}

/* installs a device handler in the device handler table */

extern void devio_install( devio_t* device );
extern void devio_deinstall( devio_t* device );

extern devlink_t devio_table[DEV_MAX];

#endif /* _POSIX_DEV_H */

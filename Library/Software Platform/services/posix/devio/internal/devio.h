/******************************************************************************
 * FILE:        devio.h
 * DESCRIPTION:
 *      Internal interface for POSIX device I/O
 *****************************************************************************/

#ifndef _DEVIO_H
#define _DEVIO_H

#include <limits.h>

#include <ioreq.h>
#include <stdbool.h>

extern void*    devio_getdev            ( int fildes );

extern int      devio_lookup            ( const char* name );

extern int      devio_readwrite         ( void *dptr,
                                          ioreq_t *io,
                                          bool write );

extern int      devio_open              ( void *dptr,
                                          int flags );

extern int      devio_close             ( void *dptr );

extern int      devio_posix_devctl      ( void* dptr,
                                          int dcmd,
                                          void *dev_data_ptr,
                                          size_t nbyte,
                                          int *dev_info_ptr );

#if ( __POSIX_MAPPED_FILES != 0 )
extern int      devio_mmap              ( void *dptr,
                                          void *addr,
                                          size_t len,
                                          int flags,
                                          off_t off,
                                          void** retval );

extern int      devio_munmap            ( void *addr,
                                          size_t len );
#endif

extern int      devio_flush             ( void *dptr,
                                          int invalidate );

#endif // _DEVIO_H

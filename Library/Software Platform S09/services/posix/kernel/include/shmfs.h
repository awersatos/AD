/******************************************************************************
 * FILE:        @(#)shmfs.h     1.2 07/03/13
 * DESCRIPTION:
 *      Shared memory objects interface to file systems
 *****************************************************************************/
#ifndef _H_SHMFS
#define _H_SHMFS

#ifdef  __cplusplus
extern "C" {
#endif

#include <stddef.h>

extern int posix_shm_open( const char*, int, void**,int*);
extern int posix_shm_open_fildes( const char*, int, int*);
extern int posix_shm_close ( void* );
extern int posix_shm_map   ( void*,void*,size_t,int,void** );
extern int posix_shm_unlink( const char*);
extern int posix_shm_munmap( void*,size_t);

#ifdef  __cplusplus
}
#endif

#endif

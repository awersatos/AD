#ifndef _H_SHMFS
#define _H_SHMFS

#include <stddef.h>


extern int          shmio_open  ( const char *,int oflag, int* );
extern void*        shmio_getshm( int );
extern const char*  shmio_name  ( int );
extern int          shmio_open_fildes( const char*, int, int* );
extern int          shmio_close ( void* );
extern int          shmio_mmap   ( void*,void*,size_t,int,void** );
extern int          shmio_unlink( const char* );
extern int          shmio_munmap( void*,size_t );

#endif

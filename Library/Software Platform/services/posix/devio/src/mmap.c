/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    mmap
|*
\*****************************************************************************/

#if ( __POSIX_FILE_SYSTEM__ == 0 )

#include <sys/mman.h>
#include <stdlib.h>
#include <fcntl.h>
#include <limits.h>
#include <errno.h>
#include <devio.h>

#if (__POSIX_SHARED_MEMORY_OBJECTS != 0 || __POSIX_MAPPED_FILES != 0 )

# include "shmio.h"

/**
 * @brief
 *      establishes a mapping between a process' address space and a file or a shared memory object
 *  
 *      The format of the call is as follows:
 *          pa=mmap(addr, len, prot, flags, fildes, off)
 *      The mmap() function shall establish a mapping between the address space of the 
 *      process at an address pa for len bytes to the memory object represented by the file 
 *      descriptor fildes at offset off for len bytes. The value of pa is an implementation-defined 
 *      function of the parameter addr and the values of flags. A successful mmap() call shall 
 *      return pa as its result. The address range starting at pa and continuing for len bytes 
 *      shall be legitimate for the possible (not necessarily current) address space of the process. 
 *      The range of bytes starting at off and continuing for len bytes shall be legitimate 
 *      for the possible (not necessarily current) offsets in the file or shared memory object
 *      represented by fildes.
 *
 * @param addr
 *      address to map
 * @param len
 *      length in bytes of the mapped area
 * @param prot
 *      The parameter prot determines whether read, write, execute, or some combination of accesses 
 *      are permitted to the data being mapped. The prot shall be either PROT_NONE or the 
 *      bitwise-inclusive OR of one or more of the other flags ( PROT_WRITE, PROT_READ, PROT_EXEC )
 * @param flags
 *      The parameter flags provides other information about the handling of the mapped data.
 *      When MAP_FIXED is set in the flags argument, the implementation is informed that the value 
 *      of pa shall be addr, exactly. When MAP_FIXED is not set, the implementation uses addr in 
 *      an implementation-defined manner to arrive at pa. An addr value of 0 as granting the implementation 
 *      complete freedom in selecting pa.
 *      MAP_SHARED or MAP_PRIVATE are meaningless in a uni-process system.
 *  @param fildes
 *      file descriptor of the file or shared memory object
 *  @param off
 *      offset in the object
 * 
 * @return
 *      Upon successful completion, the mmap() function shall return the address at which
 *      the mapping was placed ( pa); otherwise, it shall return a value of MAP_FAILED 
 *      and set errno to indicate the error.        
 */
 
void *mmap(     void *addr, size_t len,  int prot, int flags, int fildes, off_t off )
{
        void*           ret        = MAP_FAILED;
        int             status     = EINVAL;
        void*           file;

        if ( len == 0 )
        {
                goto mmap_exit_label;
        }

        /* try first devices */
        #if ( __POSIX_DEVIO__ != 0 && __POSIX_MAPPED_FILES != 0 )
        if (    (file = devio_getdev(fildes)) != NULL  )
        {
                status = devio_mmap ( file, addr, len, flags, off, &ret );
                goto mmap_exit_label;
        }
        #endif

        /* else shared memory objects */
        #if (__POSIX_SHARED_MEMORY_OBJECTS != 0 )
        if (    (file = shmio_getshm(fildes)) != NULL   )
        {
                status = shmio_mmap ( file, addr, len, flags, &ret );
                goto mmap_exit_label;
        }
        #endif

        /* wrong fildes */
        status = EBADF;

mmap_exit_label:
        if ( status != 0 )
        {
                errno = status;
                return MAP_FAILED;
        }

        return ret;
}

#endif // (__POSIX_SHARED_MEMORY_OBJECTS != 0 || __POSIX_MAPPED_FILES != 0 )

#endif // ( __POSIX_FILE_SYSTEM__ == 0 )








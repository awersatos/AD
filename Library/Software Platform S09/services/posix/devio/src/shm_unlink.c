/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    shm_unlink
|*
\*****************************************************************************/

#include <limits.h>

#if ( (__POSIX_SHARED_MEMORY_OBJECTS != 0) && (__POSIX_FILE_SYSTEM__ == 0) )

#include <sys/mman.h>
#include <string.h>
#include <errno.h>
#include "shmio.h"

/**
 * @brief
 *      removes the name of a shared memory object
 *
 *      If one or more references to the shared memory object exist when the object is unlinked,
 *      the name shall be removed before shm_unlink() returns, but the removal of the memory object
 *      contents shall be postponed until all open and map references to the shared memory object
 *      have been removed.
 *      Even if the object continues to exist after the last shm_unlink(), reuse of the name shall
 *      subsequently cause shm_open() to behave as if no shared memory object of this name exists
 *       (that is, shm_open() will fail if O_CREAT is not set, or will create a new shared memory
 *      object if O_CREAT is set).
 *
 * @param name
 *        shared memory object name
 * @return
 *      Upon successful completion, the  function shall return zero.
 *      Otherwise, the function shall return -1 and set errno to indicate the error.
 *
 */
int shm_unlink(const char *name)
{
       int ret = shmio_unlink( name );
       if ( ret )
       {
          errno = ret;
          return -1;
       }
       return 0;
}

        
#endif


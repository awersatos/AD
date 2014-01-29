/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    shm_open
|*
\*****************************************************************************/


#include <limits.h>

#if ( (__POSIX_SHARED_MEMORY_OBJECTS != 0) && (__POSIX_FILE_SYSTEM__ == 0) )

#include <sys/mman.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <fcntl.h>
#include "shmio.h"

/**
 * @brief establishes a connection between a shared memory object and a file descriptor 
 *      
 *      The function shall create an open file description that refers to the shared memory objec
 *      and a file descriptor that refers to that open file description.
 *      If successful, shm_open() shall return a file descriptor for the shared memory object 
 *      that is the lowest numbered file descriptor not currently open for that process. 
 *      The open file description is new, and therefore the file descriptor does not share 
 *      it with any other processes. It is unspecified whether the file offset is set. 
 *      
 *      The oflag argument is the bitwise-inclusive OR of the following flags ( one of O_RDONLY
 *      or O_RDWR and any combination of O_CREAT,O_EXCL,O_TRUNC ).
 *      When a shared memory object is created, the state of the shared memory object, 
 *      including all data associated with the shared memory object, persists until the shared 
 *      memory object is unlinked and all other references are gone.
 *       
 * @param name 
 *        shared memory object name
 * @param oflag
 *        open flags
 * @param mode
 *        not used
 * @return
 *      Upon successful completion, the shm_open() function shall return a non-negative integer
 *      representing the lowest numbered unused file descriptor. Otherwise, it shall return -1 
 *      and set errno to indicate the error.
 * 
 */
int shm_open(const char *name, int oflag, mode_t mode)
{

        int fildes = -1;
        int ret = shmio_open ( name , oflag, &fildes );
        if ( ret == 0 )
        {
                return fildes;
        }
        errno = ret;
        return -1;
}

#endif


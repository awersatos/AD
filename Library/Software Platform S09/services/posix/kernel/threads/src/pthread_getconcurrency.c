/******************************************************************************
 * FILE:        @(#)pthread_getconcurrency.c    1.3 06/06/09
 * DESCRIPTION:
 *      The pthread_getconcurrency() function shall return the value set
 *      by a previous call to the pthread_setconcurrency() function. 
 *      If the pthread_setconcurrency() function was not previously called, 
 *      this function shall return zero to indicate that the implementation is 
 *      maintaining the concurrency level.      
 ******************************************************************************/
#include <pthread.h>
#include <errno.h>
#include "kernel.h"

#if (__XSI_THREAD_EXIT != 0)

extern int concurrency_level;

int pthread_getconcurrency(void)
{
        int level;
        
        posix_scheduler_lock();
        level = concurrency_level;
        posix_scheduler_unlock();
        
        return level;
}

#endif

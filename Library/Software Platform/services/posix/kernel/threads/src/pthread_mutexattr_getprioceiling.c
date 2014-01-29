/*****************************************************************************
 * FILE:        07/02/21 @(#)pthread_mutexattr_getprioceiling.c 1.6
 * DESCRIPTION:
 *
 *      The 'pthread_mutexattr_getprioceiling()' function shall get 
 *      the priority ceiling attribute of a mutex attributes object 
 *      pointed to by attr which was previously created by the 
 *      function 'pthread_mutexattr_init()'.
 ****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include <sys/types.h>
#include "kernel.h"

#if ( __POSIX_THREAD_PRIO_PROTECT != 0 )

int pthread_mutexattr_getprioceiling (  const pthread_mutexattr_t *attr, 
                                        int *prioceiling)
{
        int ret = 0;

        posix_scheduler_lock();

        if (    attr == NULL                    || 
                attr->init != _ATTR_INIT_KEY    || 
                prioceiling==NULL )
        {
                ret = EINVAL; 
        }
        else
        {
                *prioceiling = attr->prioceiling;
        }
        
        posix_scheduler_unlock();
                       
        return ret;
}

#endif


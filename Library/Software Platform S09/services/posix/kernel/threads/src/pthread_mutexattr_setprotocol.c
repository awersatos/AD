/*****************************************************************************
 * FILE:        07/02/21 @(#)pthread_mutexattr_setprotocol.c    1.5
 * DESCRIPTION:
 *              The 'pthread_mutexattr_setprotocol()' function shall set the 
 *              protocol attribute of a mutex attributes object pointed to by 'attr' 
 *              which was previously created by the function 
 *              'pthread_mutexattr_init()'.
 ****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include <sys/types.h>
#include "kernel.h"

int pthread_mutexattr_setprotocol(pthread_mutexattr_t *attr,
                        int protocol)
{
        int ret = 0;
        
        if ( attr == NULL) 
        {
                return EINVAL;
        }
        else if ( protocol != PTHREAD_PRIO_NONE &&
                  protocol != PTHREAD_PRIO_INHERIT &&
                  protocol != PTHREAD_PRIO_PROTECT )
        {
                return ENOTSUP;
        }

        posix_scheduler_lock();
        
        if (attr->init!=_ATTR_INIT_KEY)
        {
                ret = EINVAL; 
        }
        else
        {
                attr->protocol = protocol;
        }
        
        posix_scheduler_unlock();
        
        return ret;
}

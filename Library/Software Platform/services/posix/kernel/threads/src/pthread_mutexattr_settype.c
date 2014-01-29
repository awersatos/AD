/*****************************************************************************
 * FILE:        07/02/21 @(#)pthread_mutexattr_settype.c        1.6
 * DESCRIPTION:
 *      The 'pthread_mutexattr_settype()' function  shall  set the mutex 
 *      type attribute. 
 *      The default value of the type attribute is PTHREAD_MUTEX_DEFAULT.       
 ****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include <sys/types.h>
#include "kernel.h"

#if (__XSI_THREAD_MUTEX_EXT!=0)
int pthread_mutexattr_settype(pthread_mutexattr_t *attr, int type)
{
        int ret = 0;
        
        if ( attr == NULL                               || 
             (type != PTHREAD_MUTEX_NORMAL              &&
              type != PTHREAD_MUTEX_DEFAULT             &&
              type != PTHREAD_MUTEX_RECURSIVE           &&
              type != PTHREAD_MUTEX_ERRORCHECK)
           )
        {
                return EINVAL;
        }
        
        posix_scheduler_lock();

        if (attr->init != _ATTR_INIT_KEY)
        {
                ret = EINVAL; 
        }
        else
        {
                attr->type = type;
        }
        posix_scheduler_unlock();

        return ret;
}
#endif


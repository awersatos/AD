/******************************************************************************
 * FILE:        @(#)pthread_attr_setschedpolicy.c       1.7 07/02/21
 * DESCRIPTION:
 *      The pthread_attr_setschedpolicy() function shall set the 
 *      schedpolicy attribute in the attr argument.
 *****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include "kernel.h"

int pthread_attr_setschedpolicy (pthread_attr_t *attr, int policy)
{
        int ret = 0;

        if (    attr == NULL                            ||
                ( policy != SCHED_OTHER         &&
#if (__POSIX_THREAD_SPORADIC_SERVER != 0)
                  policy != SCHED_SPORADIC      &&
#endif
                  policy != SCHED_FIFO          &&
                  policy != SCHED_RR )
        )
        {
                return EINVAL;
        }

        posix_scheduler_lock();

        if ( attr->init != _ATTR_INIT_KEY )
        {
                ret = EINVAL;
        }
        else
        {
#if (__POSIX_THREAD_SPORADIC_SERVER != 0)

                if (    policy == SCHED_SPORADIC        && 
                        _posix_sporadic_cleanup_key == PTHREAD_KEY_INVALID_ID)
                {
                        pthread_key_create(
                                &_posix_sporadic_cleanup_key, 
                                posix_sporadic_cleanup_function );
                }

#endif

                attr->schedpolicy = policy;
        }

        posix_scheduler_unlock();

        return ret;
}


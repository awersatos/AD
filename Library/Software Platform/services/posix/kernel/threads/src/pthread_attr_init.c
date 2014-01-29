/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_attr_init
|*
\*****************************************************************************/

#include <errno.h>
#include <limits.h>
#include <pthread.h>
#include <sys/types.h>
#include <string.h>
#include "kernel.h"

/**
 * @brief
 *      initialize a thread attributes object
 *
 *      The pthread_attr_init() function shall initialize a thread attributes
 *      object attr with the default value for all of the individual
 *      attributes used by a given implementation.
 *
 *      The default values are:
 *      - detachstate: PTHREAD_CREATE_JOINABLE
 *      - schedpolicy: SCHED_OTHER
 *      - schedparam:priority: 1 ( level 0 is reserved for 'idle' mechanism)
 *      - inheritsched: PTHREAD_INHERIT_SCHED
 *      - scope: PTHREAD_SCOPE_SYSTEM
 *      - stackaddr: NULL
 *      - stacksize: PTHREAD_STACK_MIN
 *
 * @param attr
 *      pointer to the thread's attribute object
 *
 * @return
 *      Upon successful completion it shall return a value of 0; otherwise, an error number
 *      shall be returned to indicate the error.
 */
int pthread_attr_init(pthread_attr_t *attr)
{
    int ret = 0;

    if (attr == NULL)
    {
        return EINVAL;
    }

    posix_scheduler_lock();

    attr->init              = _ATTR_INIT_KEY;
    attr->stacksize         = PTHREAD_STACK_MIN;
#if (__XSI_THREAD_EXIT != 0)
    attr->guardsize         = PAGESIZE;
#endif
    attr->stackaddr         = NULL;
    attr->detachstate       = PTHREAD_CREATE_JOINABLE;
    attr->scope             = PTHREAD_SCOPE_SYSTEM;
    attr->inheritsched      = PTHREAD_INHERIT_SCHED;
    attr->schedpolicy       = SCHED_OTHER;
    memset(&attr->schedparam, 0, sizeof(attr->schedparam));
    attr->schedparam.sched_priority = 1;
#if (__POSIX_THREAD_ATTR_NAME != 0)
    memset(attr->name, 0, sizeof(attr->name));
#endif

    posix_scheduler_unlock();

    return ret;
}


/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2009, Altium
|*
|*  Description:    pthread_attr_getname
|*
\*****************************************************************************/

#include <string.h>
#include <pthread.h>
#include <errno.h>
#include "kernel.h"


/**
 * @brief
 *      gets the name attribute in the attr object
 *
 *          The pthread_attr_getname() function gets the thread's name
 *          attribute in the attr object.
 *          The thread's name is set via pthread_attr_setname.
 *
 * @param attr
 *      pointer to the thread's attribute object
 * @param name
 *      Address of a character buffer to receive the name. (Must have a size of
 *      atleast POSIX_THREAD_THREAD_NAME_MAX.)
 *
 * @return
 *      Upon successful completion it shall return a value of 0; otherwise, an error number
 *      shall be returned to indicate the error.
 */
int pthread_attr_getname(const pthread_attr_t *attr, char *name)
{
#if (__POSIX_THREAD_ATTR_NAME != 0)
    int ret =0;

    if (attr == NULL || name == NULL)
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
        strncpy(name, attr->name, POSIX_THREADS_THREAD_NAME_MAX);
    }

    posix_scheduler_unlock();

    return ret;
#else
    if (attr == NULL || name == NULL)
    {
        return EINVAL;
    }

	name[0] = '\0';

	return ENOTSUP;
#endif
}

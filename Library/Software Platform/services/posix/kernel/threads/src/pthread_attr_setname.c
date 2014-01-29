/******************************************************************************
 * FILE:        @(#)pthread_attr_setname.c 1.4 07/02/21
 * DESCRIPTION:
 *          The pthread_attr_setname() function shall set the name
 *          attribute in the attr object.
 *****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include <string.h>
#include "kernel.h"


/**
 * @brief
 *      sets the name attribute in the attr object
 *
 *          The pthread_attr_setname() function sets the thread's name
 *          attribute in the attr object.
 *          The thread's name can be retrieved via pthread_attr_getname.
 *
 * @param attr
 *      pointer to the thread's attribute object
 * @param name
 *      Address of a null terminated character buffer containing the name.
 *      If the length of name is greater than POSIX_THREADS_THREAD_NAME_MAX - 1
 *      characters, the excess characters are ignored.
 *
 * @return
 *      Upon successful completion it shall return a value of 0; otherwise, an error number
 *      shall be returned to indicate the error.
 */
int pthread_attr_setname(pthread_attr_t * attr, const char *name)
{
#if (__POSIX_THREAD_ATTR_NAME != 0)
    int ret = 0;

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
        strncpy(attr->name, name, POSIX_THREADS_THREAD_NAME_MAX);
        attr->name[POSIX_THREADS_THREAD_NAME_MAX-1] = '\0';
    }

    posix_scheduler_unlock();

    return ret;
#else
	return ENOTSUP;
#endif
}

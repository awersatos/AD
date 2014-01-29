/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_detach
|*
\*****************************************************************************/

#include <pthread.h>
#include <errno.h>
#include "posix_pthread.h"

/**
 * @brief
 *      reclaims storage for the thread when terminates
 *
 *		The pthread_detach() function shall indicate to the implementation that 
 *		storage for the thread thread can be reclaimed when the thread terminates. 
 *		If thread has not terminated, pthread_detach() shall not cause it to terminate. 
 *		The effect of multiple pthread_detach() calls on the same target thread 
 *		is unspecified.
 *
 * @param thread
 *      thread id
 *
 * @return
 * 		Upon successful completion it shall return a value of 0; otherwise, an error number 
 *		shall be returned to indicate the error.     
 */
int pthread_detach (pthread_t thread)
{
        int ret         = 0;
        posix_thread_t  *detachee;

        if (thread<0 || thread>=PTHREAD_THREADS_MAX)
        {
                /* non-existing thread */
                return ESRCH;
        }

        pthread_mutex_lock(&_posix_threads_mutex);
                
        detachee = posix_get_thread(thread);
        if( detachee == NULL )
        {
                /* non-existing thread */
                ret = ESRCH;
        }
        else if( detachee->joinstate == PTHREAD_JOINSTATE_DETACH )
        {
                /* error when already detachad */
                ret = EINVAL;
        }
        else if (detachee->joinstate == PTHREAD_JOINSTATE_FREE)
        {
                /* detach when not joined by other threads */
                detachee->joinstate = PTHREAD_JOINSTATE_DETACH;
        }
        else if (detachee->joinstate == PTHREAD_JOINSTATE_BUSY)
        {
                /* do nothing: thread has joiners */
        }
        else if (detachee->joinstate == PTHREAD_JOINSTATE_JOIN ||
                 detachee->joinstate == PTHREAD_JOINSTATE_EXIT   )
        {
                /* thread has exited and is waiting to be
                 * finally joined or has even been joined already */
        }

        pthread_mutex_unlock(&_posix_threads_mutex);

        return ret;

}



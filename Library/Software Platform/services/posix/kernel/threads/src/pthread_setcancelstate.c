/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_setcancelstate
|*
\*****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include "posix_pthread.h"
#include "kernel.h"

/**
 * @brief
 *		sets the calling thread's cancelability state 
 *	
 *		The pthread_setcancelstate() function shall atomically both set the 
 *		calling thread's cancelability state to the indicated state and return 
 *		the previous cancelability state at the location referenced by oldstate. 
 *		Legal values for state are PTHREAD_CANCEL_ENABLE and PTHREAD_CANCEL_DISABLE.
 *
 *		The cancelability state and type of any newly created threads, including 
 *		the thread in which main() was first invoked, shall be PTHREAD_CANCEL_ENABLE 
 *
 * @param state
 *      thread's new cancel state
 * @param oldstate
 *		return parameter holding the old cancel state of calling thread
 * 
 * @return
 * 		Upon successful completion it shall return a value of 0; otherwise, an error number 
 *		shall be returned to indicate the error.     
 *
 */
int pthread_setcancelstate(int state, int *oldstate)
{
        posix_thread_t * self = posix_self_thread();

        if(     state != PTHREAD_CANCEL_ENABLE &&
                state != PTHREAD_CANCEL_DISABLE )
        {
                return EINVAL;
        }
        
        pthread_mutex_lock(&_posix_threads_mutex);

        if( oldstate != NULL ) 
        {
                *oldstate = self->cancelstate;
        }
        self->cancelstate = state;
        
        pthread_mutex_unlock(&_posix_threads_mutex);

        pthread_testcancel();

        return 0;
}


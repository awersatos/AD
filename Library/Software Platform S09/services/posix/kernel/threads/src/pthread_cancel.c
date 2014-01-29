/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_cancel
|*
\*****************************************************************************/

#include <pthread.h>
#include <errno.h>
#include "posix_pthread.h"
#include "kernel.h"

int pthread_canceled_dummy_var;

/**
 * @brief
 *      requests a thread cancellation
 *
 *    	The pthread_cancel() function shall request that thread be canceled. 
 *		The target thread's cancelability state and type determines when the 
 *		cancellation takes effect. When the cancellation is acted on, the cancellation 
 *		cleanup handlers for thread shall be called. When the last cancellation 
 *		cleanup handler returns, the thread-specific data destructor functions shall be 
 *		called for thread. When the last destructor function returns, thread shall be terminated.
 *	    The cancellation processing in the target thread shall run asynchronously with respect to 
 *		the calling thread returning from pthread_cancel().
 * 
 * @param thread
 *      identity of thread to be cancelled
 *
 * @return
 * 		Upon successful completion it shall return a value of 0; otherwise, an error number 
 *		shall be returned to indicate the error.     
 */
int pthread_cancel (pthread_t thread)
{
        posix_thread_t *        th;
        int             ret = 0;
        
        if (thread < 0 || thread >= PTHREAD_THREADS_MAX)
                return ESRCH;

        posix_scheduler_lock();
        
        if ( (th = posix_get_thread(thread)) == NULL)
        {
                ret = ESRCH;
        }
        else 
        {
                if ( th->cancelpending == 0 )
                {       
                        th->cancelpending = 1;
        
                        if ( th->cancelstate == PTHREAD_CANCEL_ENABLE )
                        {
                                if ( th->canceltype == 
                                        PTHREAD_CANCEL_ASYNCHRONOUS )
                                {
                                        th->asrpending = 1;
                                }
                                
                                posix_thread_ready(th,POSIX_WAKE_CANCEL);
                                
                        }
                }
        }
        
        posix_scheduler_unlock();
        
        return ret;
}




/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pause
|*
\*****************************************************************************/

#include <errno.h>
#include <limits.h>
#include "posix_signal.h"
#include "kernel.h"

#if ( __POSIX_SIGNALS != 0 )

/**
 * @brief
 *		suspends the calling thread until delivery of a signal
 *	
 *		The pause() function shall suspend the calling thread until delivery of 
 *		a signal whose action is either to execute a signal-catching function 
 *		or to terminate the process.
 *      If the action is to terminate the process, pause() shall not return.
 * 	    If the action is to execute a signal-catching function, pause() shall 
 *      return after the signal-catching function returns.
 *	
 * @return
 *		Since pause() suspends thread execution indefinitely unless interrupted 
 *		by a signal, there is no successful completion return value. 
 *		A value of -1 shall be returned and errno set to indicate the error.
 * 
 */
int     pause(void)
{
        
        posix_thread_t *self = posix_self_thread();

        /* pause is cancellation point */
        pthread_testcancel();
        
        pthread_mutex_lock(&_posix_signals_mutex);
        
        while( !posix_deliver_signal_point() )
        {
                self->sigwait = ~(self->sigmask);
                self->osmutex = 1;

                __pthread_cond_timedwait( &_posix_signals_cond,
                                          &_posix_signals_mutex,
                                          -1);

                /* pause is cancellation point */
                pthread_testcancel();
        }

        posix_try_deliver_signal();
        
        pthread_mutex_unlock(&_posix_signals_mutex);

        errno = EINTR;
        return -1;
}

#endif

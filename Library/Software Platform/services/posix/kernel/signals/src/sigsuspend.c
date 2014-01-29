/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    sigsuspend
|*
\*****************************************************************************/
#include <errno.h>
#include <signal.h>
#include "posix_signal.h"
#include "kernel.h"

#if ( __POSIX_SIGNALS != 0 )

/**
 * @brief
 *		suspends the thread until delivery of a signal
 *	
 *      The sigsuspend() function shall replace the current signal mask of the 
 *		calling thread with the set of signals pointed to by sigmask and then 
 *		suspend the thread until delivery of a signal whose action is either to 
 *		execute a signal-catching function or to terminate the process. 
 *		This shall not cause any other signals that may have been pending on 
 *		the process to become pending on the thread.
 *		If the action is to terminate the process then sigsuspend() shall never 
 *		return. If the action is to execute a signal-catching function, 
 *		then sigsuspend() shall return after the signal-catching function returns, 
 *		with the signal mask restored to the set that existed prior to the sigsuspend() call.
 *    	It is not possible to block signals that cannot be ignored. This is enforced by 
 *		the system without causing an error to be indicated.

 * @param sigmask
 *      pointer to signal set
 * @return
 * 		Since sigsuspend() suspends thread execution indefinitely, there is no successful 
 *		completion return value. If a return occurs, -1 shall be returned and errno set 
 *		to indicate the error.
 */
int sigsuspend(const sigset_t *sigmask)
{
        
        posix_thread_t *self = posix_self_thread();
        sigset_t old;

        /* sigsuspend is cancellation point */
        pthread_testcancel();
        
        pthread_mutex_lock(&_posix_signals_mutex);
        
        old             = self->sigmask;
        self->sigmask   = *sigmask;

        while( !posix_deliver_signal_point() )
        {
                self->sigwait = ~(*sigmask);
                self->osmutex = 1;
                __pthread_cond_timedwait(       &_posix_signals_cond,
                                                &_posix_signals_mutex,-1 );
                /* sigsuspend is cancellation point */
                pthread_testcancel();
        }
        self->sigwait = 0;

        /* deliver sigsuspend signals */
        posix_try_deliver_signal();
        /* restore old mask */
        self->sigmask = old;
        /* deliver again: mask has changed */
        posix_try_deliver_signal();
        
        pthread_mutex_unlock(&_posix_signals_mutex);

        errno = EINTR;
        return -1;
        
}

#endif


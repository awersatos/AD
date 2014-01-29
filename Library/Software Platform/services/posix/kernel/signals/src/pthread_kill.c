/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_kill
|*
\*****************************************************************************/

#include <errno.h>
#include <signal.h>
#include "posix_signal.h"
#include "kernel.h"

/**
 * 	@file pthread.h
 *		
 *	This plugin implements the POSIX_SIGNALS Unit of Functionality
 *  
 *	Signal services are a basic mechanism within POSIX-based systems and are
 *	required for error and event handling. 
 *
 *	Realtime systems typically have several logically concurrent software elements 
 *  executing. Each such entity must respond to several cyclic and/or acyclic stimuli, 
 *	often in a time-critical manner. Although purely synchronous models can supply such 
 *	functionality via the use of additional processes or threads, the current realtime 
 *	practice for asynchronous notification for events such as timeout, message arrival, 
 *	and hardware interrupt can generally be expected to offer higher performance and 
 *	lower latency than signals. That is why the usage of POSIX signals is somehow 
 *	restricted here in comparison with desktop systems (the kernel prefers mutex and 
 *	condition variables over signals for its internal synchronization)  	
 *
 *	However, and for the same reason that user-level processes may send signals to 
 *	another processes in UNIX, in Minimal Realtime Systems, threads may send signals 
 *  to another threads (see supported functions below).
 */


#if ( __POSIX_SIGNALS != 0 )

/**
 * @brief
 *		requests that a signal be delivered to the specified thread.
 *	
 * @param thread
 *      thread's identity
 * @param sig
 * 		signal number
 * @return
 *		Upon successful completion, the function shall return a value of zero. 
 *		Otherwise, the function shall return an error number. If the pthread_kill() 
 *		function fails, no signal shall be sent.
 * 
 */
int pthread_kill(pthread_t thread, int sig)
{
        struct sigevent         sev;
        posix_thread_t*         th;
        
        if( !VALID_SIGNAL(sig) )
        {
                errno = EINVAL;return -1;
        }

        posix_scheduler_lock();
        th      = _posix_thread_table[thread];
        posix_scheduler_unlock();
        
        if ( th == NULL )
        {
                errno = ESRCH;return -1;
        }

        sev.sigev_notify           = SIGEV_SIGNAL;
        sev.sigev_signo            = sig;
        sev.sigev_value.sival_int  = 0;
        
        /* generates signal for thread and check whether
         * thread is on sigwait() or unblocked.
         * If so, the thread will run asynchronously the 
         * signal handler */ 
        posix_generate_signal( &sev, SI_USER, th );

        /* what if 'th = self' ? */
        posix_deliver_signals();
                
        return 0;
}

#endif

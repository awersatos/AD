
/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    sigwait
|*
\*****************************************************************************/

#include <errno.h>
#include <signal.h>
#include "posix_signal.h"
#include "posix_time.h"
#include "kernel.h"

#if ( __POSIX_SIGNALS != 0 )

/**
 * @brief
 *		selects a pending signal from set
 *	
 *		The sigwait() function shall select a pending signal from set, atomically clear 
 *		it from the system's set of pending signals, and return that signal number 
 *		in the location referenced by sig. If prior to the call to sigwait() there 
 *		are multiple pending instances of a single signal number, it is 
 *		implementation-defined whether upon successful return there are any remaining 
 *		pending signals for that signal number. 
 *		If the implementation supports queued signals and there are multiple signals 
 *		queued for the signal number selected, the first such queued signal shall cause a 
 *		return from sigwait() and the remainder shall remain queued.
 *		If no signal in set is pending at the time of the call, the thread shall be 
 *		suspended until one or more becomes pending. The signals defined by set shall 
 *		have been blocked at the time of the call to sigwait(); otherwise, the behavior 
 *		is undefined. The effect of sigwait() on the signal actions for the signals 
 *		in set is unspecified.
 *		If more than one thread is using sigwait() to wait for the same signal, no more 
 *		than one of these threads shall return from sigwait() with the signal number. 
 *		If more than a single thread is blocked in sigwait() for a signal when that signal 
 *		is generated for the process, it is unspecified which of the waiting threads returns
 * 		from sigwait(). If the signal is generated for a specific thread, as by pthread_kill(), 
 *		only that thread shall return. 
 *
 * @param set
 *      pointer to a read-only sigset_t variable
 * @param sig
 * 		a return parameter that holds the number of received signal
 * @return
 *		Upon successful completion, sigwait() shall store the signal number of the 
 *		received signal at the location referenced by sig and return zero. Otherwise, an error 
 *	    number shall be returned to indicate the error.
 * 
 */
int sigwait(const sigset_t *set, int * sig)
{

        siginfo_t info;
        int ret = sigtimedwait( set, &info, NULL );
        
        if (sig !=NULL)
        {
                *sig = ret;
        }

        return 0;
}

#endif


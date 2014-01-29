/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    sigqueue
|*
\*****************************************************************************/
#include <errno.h>
#include <signal.h>
#include "posix_signal.h"

#if ( __POSIX_SIGNALS != 0 && __POSIX_REALTIME_SIGNALS!=0 )
/**
 * @brief
 *		causes the signal specified by signo to be sent with the value specified by value 
 *	
 *	    The sigqueue() function shall cause the signal specified by signo to be sent 
 *		with the value specified by value to the process specified by pid. If signo is 
 *		zero (the null signal), error checking is performed but no signal is actually sent. 
 *    	The sigqueue() function shall return immediately. If SA_SIGINFO is set for signo 
 *		and if the resources were available to queue the signal, the signal shall be queued 
 *		and sent to the receiving process. If SA_SIGINFO is not set for signo, then signo 
 *		shall be sent at least once to the receiving process; it is unspecified whether 
 *		value shall be sent to the receiving process as a result of this call.
 *   	If signo is not blocked for the calling thread and if no other thread has signo 
 *		unblocked or is waiting in a sigwait() function for signo, either signo or at least 
 *		the pending, unblocked signal shall be delivered to the calling thread before the 
 *		sigqueue() function returns. Should any multiple pending signals in the range 
 *		SIGRTMIN to SIGRTMAX be selected for delivery, it shall be the lowest numbered one. 
 *		The selection order between realtime and non-realtime signals, or between multiple 
 *		pending non-realtime signals, is unspecified.
 *
 * @param pid
 *      process id (ignored)
 * @param signo
 * 		signal number
 * @param sigval
 * 		signal value
 * @return
 *		Upon successful completion, the specified signal shall have been queued, 
 *		and the sigqueue() function shall return a value of zero. Otherwise, the 
 *		function shall return a value of -1 and set errno to indicate the error.
 * 
 */
int sigqueue(pid_t pid, int signo, const union sigval value)
{
   
        struct sigevent sev;
        
        if( !VALID_SIGNAL(signo) )
        {
             errno = EINVAL;return -1;
        }

        sev.sigev_notify           = SIGEV_SIGNAL;
        sev.sigev_signo            = signo;
        sev.sigev_value            = value;

        /* generates signal and checks sigwait() 
         * and unblocking threads */
        posix_generate_signal( &sev, SI_QUEUE , NULL);

        /* normally calling thread should have it masked */
        posix_deliver_signals();

        return 0;
}
#endif 



/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    kill
|*
\*****************************************************************************/
#include <errno.h>
#include <signal.h>
#include "posix_signal.h"

#if ( __POSIX_SIGNALS != 0 )

/**
 * @brief
 *		sends a signal to the whole process (i.e. to all threads)
 *	
 *		The signal to be sent is specified by sig and is either one from the list 
 *		given in <signal.h> or 0. If sig is 0 (the null signal), error checking 
 *		is performed but no signal is actually sent.

 *	
 * @param pid
 *      process id ( not used )
 * @param sig
 * 		signal number
 * @return
 *		Upon successful completion, 0 shall be returned. Otherwise, -1 shall be 
 *		returned and errno set to indicate the error.
 * 
 */
int kill(pid_t pid, int sig)
{
   
        struct sigevent sev;
        
        if( !VALID_SIGNAL(sig) )
        {
             errno = EINVAL;return -1;
        }

        sev.sigev_notify           = SIGEV_SIGNAL;
        sev.sigev_signo            = sig;
        sev.sigev_value.sival_int  = 0;

        /* generates signal and checks sigwait() 
         * and unblocking threads */
        posix_generate_signal( &sev, SI_USER , NULL);

        /* normally calling thread should have it masked */
        posix_deliver_signals();

        return 0;
}

#endif

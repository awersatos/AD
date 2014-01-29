/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    sigaction
|*
\*****************************************************************************/

#include <errno.h>
#include <signal.h>
#include "posix_signal.h"
#include "kernel.h"

#if ( __POSIX_SIGNALS != 0 )

/**
 * @brief
 *		examines and/or specifies the action to be associated with a specific signal
 *	
 *		If the argument act is not a null pointer, it points to a structure specifying 
 *		the action to be associated with the specified signal. If the argument oact is 
 *		not a null pointer, the action previously associated with the signal is stored 
 *		in the location pointed to by the argument oact. If the argument act is a null 
 *		pointer, signal handling is unchanged; thus, the call can be used to enquire about 
 *		the current handling of a given signal. 
 *
 *		Check sigation description in http://www.opengroup.org/onlinepubs/009695399/toc.htm
 *		for more details
 *
 * @param sig
 * 		a return parameter that holds the number of received signal
 * @param act
 * 		pointer to read-only struct sigaction variable to set  
 * @param oact
 * 		pointer to struct sigaction variable that holds the current signal actions 
 * @return
 * 		Upon successful completion, sigaction() shall return 0; otherwise, -1 shall be returned, 
 *		errno shall be set  to indicate the error, and no new signal-catching function shall be installed.
 */
int sigaction(  int sig, const struct sigaction * act, struct sigaction *oact)
{
        posix_thread_t* self = posix_self_thread();
        posix_signal_t* signal;
        sigset_t        sigmask;        
        if( !VALID_SIGNAL(sig) )
        {
                errno = EINVAL;return -1;
        }
        signal = &_posix_signal_table[sig];

        pthread_mutex_lock(&_posix_signals_mutex);

        if (oact != NULL)
        {       
                oact->sa_handler = signal->sa.sa_handler;
                oact->sa_mask    = signal->sa.sa_mask;
                oact->sa_flags   = signal->sa.sa_flags;
        }

        if (act!=NULL)
        {
                /* The system shall not allow the action for the signals
                 * SIGKILL or SIGSTOP to be set to SIG_IGN
                 */
                if (sig == SIGKILL || sig == SIGSTOP)
                {
                        if (act->sa_handler != SIG_IGN)
                        {
                                signal->sa.sa_handler   = act->sa_handler;
                        }
                }
                else
                {
                        signal->sa.sa_handler   = act->sa_handler;
                }

                /* also dont add SIGKILL and SIGSTOP to the mask */
                signal->sa.sa_mask      = act->sa_mask & ~(SIGKILL|SIGSTOP);
                signal->sa.sa_flags     = act->sa_flags;
                        
        }
        
        if( signal->sa.sa_handler == SIG_IGN )
        {
                /* Setting a signal action to SIG_IGN for a signal 
                 * that is pending shall cause the pending signal 
                 * to be discarded, whether or not it is blocked.
                 * Any queued values pending shall be discarded and
                 * the resources used to queue them shall be released 
                 * and made available to queue other signals.
                 */
                sigmask = 1<<sig;

                if( (_posix_sig_pending | self->sigpending) & sigmask )
                {
                        /* this signal is pending */
                        _posix_sig_pending &= ~sigmask;
                        self->sigpending &= ~sigmask;

                        /* dequeue all pending values for signal */
                        posix_free_signal(signal);                      
                }
        }

        pthread_mutex_unlock(&_posix_signals_mutex);

        return 0;

}

#endif

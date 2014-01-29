/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    signal
|*
\*****************************************************************************/

#include <errno.h>
#include <signal.h>
#include "posix_signal.h"

#if ( __POSIX_SIGNALS != 0 )

/**
 * @brief
 *		chooses the way to handle a signal 
 *	
 *		The signal() function chooses one of three ways in which receipt of the signal 
 *		number sig is to be subsequently handled. If the value of func is SIG_DFL, 
 *		default handling for that signal shall occur. If the value of func is SIG_IGN, 
 *		the signal shall be ignored. Otherwise, the application shall ensure that func 
 *		points to a function to be called when that signal occurs. An invocation of such 
 *		a function because of a signal, or (recursively) of any further functions called 
 *		by that invocation (other than functions in the standard library), 
 *		is called a "signal handler".
 *		
 *		At program start-up, the equivalent of signal(sig, SIG_IGN) is executed for 
 *		some signals, and the equivalent of signal(sig, SIG_DFL) is executed for all 
 *		other signals
 *
 * @param sig
 *      signal number
 * @param func
 * 		signal handler
 * @return
 *		f the request can be honored, signal() shall return the value of func for 
 *		the most recent call to signal() for the specified signal sig. 
 *		Otherwise, SIG_ERR shall be returned and a positive value shall be stored in errno.
 * 
 */
void (*signal(int sig, void (*func)(int)))(int)
{
        int err = 0;
        sa_sighandler_t ret;
    
        struct sigaction new_action;
        struct sigaction old_action;

        sigemptyset( &new_action.sa_mask );
        new_action.sa_flags = 0;
        new_action.sa_handler = func;

        err = sigaction( sig, &new_action, &old_action );

        if( err < 0 )
        {
                ret = SIG_ERR;
        }
        else 
        {
                ret = old_action.sa_handler;
        }

        return ret;
}

#endif

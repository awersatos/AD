/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    sigwaitinfo
|*
\*****************************************************************************/

#include <errno.h>
#include <signal.h>
#include "posix_signal.h"
#include "posix_time.h"
#include "kernel.h"

#if ( __POSIX_SIGNALS != 0 && __POSIX_REALTIME_SIGNALS!=0 )

/**
 * @brief
 *		selects a pending signal from set (with info)
 *	
 *		The sigwaitinfo() function shall be equivalent to the sigwait() function 
 *		if the info argument is NULL. If the info argument is non-NULL, the sigwaitinfo()
 *	    function shall be equivalent to sigwait(), except that the selected signal number 
 *		shall be stored in the si_signo member, and the cause of the signal shall be stored 
 *		in the si_code member. If any value is queued to the selected signal, the first 
 *		such queued value shall be dequeued and, if the info argument is non-NULL, the value 
 *		shall be stored in the si_value member of info. The system resource used to queue the 
 *		signal shall be released and returned to the system for other use. If no value is queued, 
 *		the content of the si_value member is undefined. If no further signals are queued for 
 *		the selected signal, the pending indication for that signal shall be reset. 
 *
 * @param set
 *      pointer to a read-only sigset_t variable
 * @param info
 * 		return parameter that holds the signals info
 * @return
 * 		Upon successful completion (that is, one of the signals specified by set is pending or is generated) 
 *		sigwaitinfo() shall return the selected signal number. Otherwise, the function shall 
 *		return a value of -1 and set errno to indicate the error.
 */
int sigwaitinfo(const sigset_t *set, siginfo_t* info)
{
    return sigtimedwait( set, info, NULL );
}

#endif

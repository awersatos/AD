/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    sigpending
|*
\*****************************************************************************/

#include <signal.h>
#include <errno.h>
#include "kernel.h"
#include "posix_signal.h"

#if ( __POSIX_SIGNALS != 0 )
/**
 * @brief
 *		stores the set of pending signals that are blocked from delivery
 *
 * 		The sigpending() function shall store, in the location referenced by the 
 *		set argument, the set of signals that are blocked from delivery to the calling 
 *		thread and that are pending on the process or the calling thread.
 *
 * @param set
 *      return paramater for the signal set
 * @return
 *		Upon successful completion, sigpending() shall return 0; otherwise, -1 
 *		shall be returned and errno set to indicate the error.	
 * 
 */
int sigpending(sigset_t *set)
{
        posix_thread_t* self;
        
        if( set == NULL )
        {
                errno =EINVAL;return -1;
        }

        self = posix_self_thread();
        
        posix_scheduler_lock();
        *set = (self->sigpending | _posix_sig_pending) & self->sigmask;
        posix_scheduler_unlock();

        return 0;
}

#endif


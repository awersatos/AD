/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_sigmask
|*
\*****************************************************************************/
#include <signal.h>
#include <errno.h>
#include "kernel.h"
#include "posix_signal.h"

#if ( __POSIX_SIGNALS != 0 )

/**
 * @brief
 *		examines or change (or both) the calling thread's signal mask,
 *	
 *		The pthread_sigmask() function shall examine or change (or both) 
 *		the calling thread's signal mask, regardless of the number of threads 
 *		in the process. The function shall be equivalent to sigprocmask(), 
 *		without the restriction that the call be made in a single-threaded process.
 *		If the argument set is not a null pointer, it points to a set of signals 
 *		to be used to change the currently blocked set. 
 *		The argument how indicates the way in which the set is changed, and 
 *		the application shall ensure it consists of one of the following values:
 *		SIG_BLOCK:  	The resulting set shall be the union of the current set and 
 *			the signal set pointed to by set.
 *		SIG_SETMASK: 	The resulting set shall be the signal set pointed to by set. 
 *		SIG_UNBLOCK:    The resulting set shall be the intersection of the current set 
 *			and the complement of the signal set pointed to by set.
 *		If the argument oset is not a null pointer, the previous mask shall be stored 
 *		in the location pointed to by oset. If set is a null pointer, the value of the 
 *		argument how is not significant and the thread's signal mask shall be unchanged; 
 *		thus the call can be used to enquire about currently blocked signals.
 *		If there are any pending unblocked signals after the call to sigprocmask(), 
 *		at least one of those signals shall be delivered before the call to sigprocmask()
 *		returns. It is not possible to block those signals which cannot be ignored. 
 *		This shall be enforced by the system without causing an error to be indicated.
 *
 * @param how
 *      how flags
 * @param set
 * 		pointer to a read-only const sigset_t variable
 * @param oset
 * 		pointer to sigset_t variable that holds the previous mask
 
 * @return
 *		Upon successful completion pthread_sigmask() shall return 0; otherwise, 
 *		it shall return the corresponding error number
 * 
 */
int pthread_sigmask(int how, const sigset_t * set, sigset_t * oset)
{

        posix_thread_t* self = posix_self_thread();
        int             err  = 0;

        if( oset != NULL )
        {
                *oset = self->sigmask;
        }
        
        if( set != NULL )
        {
                switch( how )
                {
                        case SIG_BLOCK:
                                self->sigmask |= *set;
                                break;

                        case SIG_UNBLOCK:
                                self->sigmask &= ~*set;
                                break;

                        case SIG_SETMASK:
                                self->sigmask = *set;
                                break;

                        default:
                                err = EINVAL;
                        break;
                }
        }

        /* deliver newly unblocked signals */
        posix_deliver_signals();

        if (err)
        {
                errno = err; 
                return -1;
        }

        return 0;
}

#endif

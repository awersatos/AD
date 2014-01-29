/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    sigprocmask
|*
\*****************************************************************************/

#include <signal.h>

#if ( __POSIX_SIGNALS != 0 )

/**
 * @brief
 *		examines or change (or both) the calling thread's signal mask,
 *	
 *		equivalent to pthread_sigmask( how, set, oset )
 *
 * @param how
 *      how flags
 * @param set
 * 		pointer to a read-only const sigset_t variable
 * @param oset
 * 		pointer to sigset_t variable that holds the previous mask
 
 * @return
 *		Upon successful completion, sigprocmask() shall return 0; otherwise, -1 
 *		shall be returned, errno shall be set to indicate the error, and the process' 
 *		signal mask shall be unchanged.
 * 
 */
int sigprocmask(int how, const sigset_t * set, sigset_t * oset)
{
        /* we ll just map it to pthread_sigmask */
        
        return pthread_sigmask( how, set, oset );
}

#endif

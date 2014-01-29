/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    sigismember
|*
\*****************************************************************************/
#include <signal.h>
#include <errno.h>

#if ( __POSIX_SIGNALS != 0 )

/**
 * @brief
 *		test membership of a signal in a given set
 *
 * @param set
 *      pointer to a signal set
 * @param signo
 *      signal number
 * @return
 *		Upon successful completion, sigismember() shall return 0; otherwise, -1 
 *		shall be returned and errno set to indicate the error.	
 * 
 */
int sigismember(const sigset_t *set, int signo)
{
        if( ! VALID_SIGNAL(signo) )
        {
                errno = EINVAL; 
                return -1;
        }
        
        if( *set & (1LL<<signo) )
        {
                return 1;
        }
        
        return 0;
}

#endif

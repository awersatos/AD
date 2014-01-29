/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    sigdelset
|*
\*****************************************************************************/
#include <signal.h>
#include <errno.h>

#if     (__POSIX_SIGNALS != 0)

/**
 * @brief
 *		deletes the individual signal specified by signo from a signal set
 *
 * @param set
 *      pointer to the signal set
 * @param signo
 *      signal number 
 * @return
 *		Upon successful completion, the function shall return 0; otherwise, -1 
 *		shall be returned and errno set to indicate the error.	
 * 
 */
int sigdelset(sigset_t *set, int signo)
{
        if( !VALID_SIGNAL(signo) )
        {
                errno= EINVAL;
                return -1;
        }
    
        *set &= ~(1LL<<signo);
        return 0;

}

#endif

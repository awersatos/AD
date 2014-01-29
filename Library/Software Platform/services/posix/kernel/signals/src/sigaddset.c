/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    sigaddset
|*
\*****************************************************************************/
#include <signal.h>
#include <errno.h>
    
#if ( __POSIX_SIGNALS != 0 )

/**
 * @brief
 *		adds the individual signal specified by the signo to the signal set pointed to by set.
 *
 * @param set
 *      pointer to a signal set
 * @return
 *		Upon successful completion, it returns 0; otherwise, -1 
 *		shall be returned and errno set to indicate the error.	
 * 
 */
int sigaddset(sigset_t *set, int signo)
{
        if( !VALID_SIGNAL(signo) )
        {
                errno = EINVAL;
                return -1;
        }
        
        *set |= (1LL<<signo);
        return 0;
}

#endif



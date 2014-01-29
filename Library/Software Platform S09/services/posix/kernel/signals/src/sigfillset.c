/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    sigfillset
|*
\*****************************************************************************/
#include <signal.h>

#if ( __POSIX_SIGNALS != 0 )

/**
 * @brief
 *		initializes the signal set pointed to by set, such that all signals are included
 *
 *
 * @param set
 *      pointer to the signal set
 * @return
 *		Upon successful completion, sigfillset() shall return 0; otherwise, -1 
 *		shall be returned and errno set to indicate the error.	
 * 
 */
int sigfillset(sigset_t *set)
{
        *set = ~0;
        return 0;
}

#endif

/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    raise
|*
\*****************************************************************************/

#include <pthread.h>

#if ( __POSIX_SIGNALS != 0 )

/**
 * @brief
 *		sends the signal sig to the executing thread
 *	
 *		the effect of the raise() function shall be equivalent to calling:
 *		pthread_kill(pthread_self(), sig);
 *		 
 * @param sig
 *      signal number
 * 
 * @return
 *		Upon successful completion, 0 shall be returned. Otherwise, a non-zero 
 *		value shall be returned [CX] [Option Start]  and errno shall be set to indicate the error
 * 
 */
int raise(int sig)
{
        return  pthread_kill(pthread_self(), sig);      
}

#endif

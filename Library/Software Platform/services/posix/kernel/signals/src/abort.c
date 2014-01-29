/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    abort
|*
\*****************************************************************************/
#include <signal.h>

#if ( __POSIX_SIGNALS != 0 )

/**
 * @brief
 *      causes abnormal process termination to occur,
 *
 *      The SIGABRT signal shall be sent to the calling process as if by means
 *      of raise() with the argument SIGABRT.
 * 
 */
void abort(void)
{
    raise(SIGABRT);
    _Exit(EXIT_FAILURE);
}

#endif


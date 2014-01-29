/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_testcancel
|*
\*****************************************************************************/
#include <pthread.h>
#include "posix_pthread.h"
#include "kernel.h"


/**
 * @brief
 *		creates a cancellation point in the calling thread. 
 *		
 *		The function shall have no effect if cancelability is disabled.
 */
void pthread_testcancel(void)
{
    posix_thread_t *self = posix_self_thread();

    if( self != NULL &&
        self->cancelpending &&
        self->cancelstate == PTHREAD_CANCEL_ENABLE )
    {
                pthread_exit(PTHREAD_CANCELED);
        }

        return;
}

        

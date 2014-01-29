/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_self
|*
\*****************************************************************************/
#include <pthread.h>
#include "posix_pthread.h"
#include "kernel.h"

/**
 * @brief
 *		returns the thread ID of the calling thread
 * 
 * @return
 *		thread ID of the calling thread
 *
 */
pthread_t pthread_self ( void )
{
        posix_thread_t* self = (posix_thread_t*)posix_self_thread();
        return self->thread_id;
}


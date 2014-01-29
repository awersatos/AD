/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_cleanup_pop ( see pthread.h )
|*
\*****************************************************************************/

#include <pthread.h>
#include "posix_pthread.h"
#include "kernel.h"

/**
 * @brief
 *      removes the routine at the top of the calling thread's cancellation cleanup stack 
 *
 * 		The functions shall remove the routine at the top of the calling thread's cancellation 
 *		cleanup stack and optionally invoke it (if execute is non-zero).
 *		See pthread_cleanup_push
 *
 * @param buf
 *      pointer to the thread's cleanup buffer
 * @param execute
 *		see description
 *
 */
void __pthread_cleanup_pop(struct pthread_cleanup_buffer *buf,  int execute)
{
        posix_thread_t *self    = posix_self_thread();
   
        /* normally in deferred cancelation mode */
        if (self->cancelbuffer  == buf)
        {
                self->cancelbuffer = buf->prev;     
        }
        else
        {
                /* not stack-like discipline */
                execute = 0;
        }

        if(execute)
        {
                buf->routine(buf->arg);
        }
        
        return;
}



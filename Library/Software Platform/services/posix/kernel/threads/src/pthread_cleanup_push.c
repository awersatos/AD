/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_cleanup_push ( see pthread.h )
|*
\*****************************************************************************/

#include <pthread.h>
#include "posix_pthread.h"
#include "kernel.h"

/**
 * @brief
 *      pushes a cancellation cleanup handler onto the thread's cleanup stack
 *
 * 		The function shall push the specified cancellation cleanup handler routine 
 *		onto the calling thread's cancellation cleanup stack. The cancellation cleanup 
 *		handler shall be popped from the cancellation cleanup stack and invoked with 
 *		the argument arg when:
 *		- The thread exits ( that is, calls pthread_exit() )
 *		- The thread acts upon a cancellation request
 *		- The thread calls pthread_cleanup_pop() with a non-zero execute argument
 * 
 *		The application shall ensure that they appear as statements, and in pairs 
 *		within the same lexical scope (that is, the pthread_cleanup_push() macro may be 
 *		thought to expand to a token list whose first token is '{' with pthread_cleanup_pop() 
 *		expanding to a token list whose last token is the corresponding '}' )
 *
 * @param buf
 *      pointer to the thread's cleanup buffer
 * @param routine
 *		cancellation routine handler
 *
 */
void __pthread_cleanup_push(struct pthread_cleanup_buffer* buf, void (*routine) (void *), void *arg)
{
        posix_thread_t *self    = posix_self_thread();
 
        
        /* the buffer has been created locally in 
         * the running thread's stack  */
        buf->routine            = routine;
        buf->arg                = arg;
        buf->prev               = self->cancelbuffer;
        
        /* normally in deferred cancelation mode */
        self->cancelbuffer  = buf;
}


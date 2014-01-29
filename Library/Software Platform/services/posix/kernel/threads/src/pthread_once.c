/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_once
|*
\*****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include "kernel.h"

/**
 * @brief
 *		calls the init_routine with no arguments for a given once_control
 *	
 *		The first call to pthread_once() by any thread in a process, 
 *		with a given once_control, shall call the init_routine with no arguments. 
 *		Subsequent calls of pthread_once() with the same once_control shall not call 
 *		the init_routine. On return from pthread_once(), init_routine shall 
 *		have completed. The once_control parameter shall determine whether the 
 *		associated initialization routine has been called.
 *
 *		The behavior of pthread_once() is undefined if once_control has automatic 
 *		storage duration or is not initialized by PTHREAD_ONCE_INIT.
 *
 * @param once_control
 *      pointer to a pthread_once_t variable
 * @param init_routine
 *		init_routine handler
 * 
 * @return
 * 		Upon successful completion it shall return a value of 0; otherwise, an error number 
 *		shall be returned to indicate the error.     
 *
 */
int pthread_once (      pthread_once_t *once_control, void (*init_routine) (void))
{
        pthread_once_t once;

        if ( once_control == NULL || init_routine == NULL)
        {
                return EINVAL;
        }
        
        posix_scheduler_lock();
        once = *once_control;
        *once_control = 1;
        posix_scheduler_unlock();

        if( !once )
        {
                init_routine();
        }
        
        return 0;
}


/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    pthread_setcanceltype
|*
\*****************************************************************************/
#include <pthread.h>
#include <errno.h>
#include "posix_pthread.h"
#include "kernel.h"

/**
 * @brief
 *		sets the calling thread's cancelability type 
 *	
 * 		The pthread_setcanceltype() function shall atomically both set the 
 *		calling thread's cancelability type to the indicated type and return 
 *		the previous cancelability type at the location referenced by oldtype.
 *  	Legal values for type are PTHREAD_CANCEL_DEFERRED and PTHREAD_CANCEL_ASYNCHRONOUS.
 *		The cancelability type of any newly created threads, including the thread in which 
 *		main() was first invoked shall be PTHREAD_CANCEL_DEFERRED
 *		
 * @param state
 *      thread's new cancel state
 * @param oldstate
 *		return parameter holding the old cancel state of calling thread
 * 
 * @return
 * 		Upon successful completion it shall return a value of 0; otherwise, an error number 
 *		shall be returned to indicate the error.     
 *
 */
int pthread_setcanceltype (int type, int *oldtype)
{

        posix_thread_t * self = posix_self_thread();
        
        if(     type != PTHREAD_CANCEL_ASYNCHRONOUS &&
                type != PTHREAD_CANCEL_DEFERRED )
        {
                return EINVAL;
        }
        
        pthread_mutex_lock(&_posix_threads_mutex);

        if( oldtype != NULL ) 
        {
                *oldtype = self->canceltype;
        }
        self->canceltype = type;
        
        pthread_mutex_unlock(&_posix_threads_mutex);

        return 0;
}



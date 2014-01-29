/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    mq_setattr
|*
\*****************************************************************************/

#include <errno.h>
#include <mqueue.h>
#include <fcntl.h>
#include "posix_mqueue.h"
#include "kernel.h"

#if ( __POSIX_MESSAGE_PASSING != 0 )

/**
 * @brief
 *		sets attributes associated with an open message queue 
 *	
 *		The mq_setattr() function shall set attributes associated with the open 
 *		message queue description referenced by the message queue descriptor specified 
 *		by mqdes. 

 * @param mqdes
 *      message queue descriptor
 * @param mqstat
 *		pointer to a read-only struct mq_attr variable that holds the message new attributes  
 * @param omqstat
 *		pointer to a struct mq_attr variable that returns the current message attributes
 *		( when not NULL )  
 *
 * @return
 *		Upon successful completion, the mq_setattr() function shall return zero. 
 *		Otherwise, the function shall return -1 and set errno to indicate the error.
 * 
 */
int mq_setattr(mqd_t mqdes, const struct mq_attr *mqstat,
 struct mq_attr *omqstat)
{
        struct posix_mquser_t *user = (struct posix_mquser_t *)mqdes;

        if ( user->initi != _ATTR_INIT_KEY )
        {
                errno  = EBADF;
                return -1;
        }

        
        if ( NULL != omqstat ) 
        {
                mq_getattr( mqdes, omqstat );
        }

        /* lock scheduler faster than locking mutex */
        posix_scheduler_lock();
        
        user->flags &= ~O_NONBLOCK;  
        if ( (mqstat->mq_flags & O_NONBLOCK) == O_NONBLOCK )
        {
                user->flags |= O_NONBLOCK;
        }
        
        posix_scheduler_unlock();

        return 0;

}

#endif


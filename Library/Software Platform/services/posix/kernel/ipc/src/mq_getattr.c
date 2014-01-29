/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    mq_getattr
|*
\*****************************************************************************/
#include <errno.h>
#include <mqueue.h>
#include "posix_mqueue.h"
#include "kernel.h"

#if ( __POSIX_MESSAGE_PASSING != 0 )

/**
 * @brief obtains status information and attributes of the message queue
 *		
 *		The results shall be returned in the mq_attr structure referenced by the mqstat 
 *		argument as set when the message queue was opened and as modified by 
 *		subsequent mq_setattr() calls.
 *		 
 * @param mqdes 
 *		  specifies a message queue descriptor
 * @param mqstat 
 *		  pointer to a struct mq_attr where to return the information  
 * @return
 *		Upon successful completion, the mq_getattr() function shall return zero. 
 *		Otherwise, the function shall return -1 and set errno to indicate the error.
 * 
 */
int mq_getattr(mqd_t mqdes, struct mq_attr *mqstat)
{
        struct posix_mquser_t *user     = (struct posix_mquser_t *)mqdes;
        struct posix_mqueue_t *mqueue   = user->table;

        if ( user->initi != _ATTR_INIT_KEY )
        {
                errno  = EBADF;
                return -1;
        }

        mqstat->mq_flags   = user->flags;
        mqstat->mq_maxmsg  = mqueue->maxmsg;
        mqstat->mq_msgsize = mqueue->msgsize;

        posix_scheduler_lock();
        mqstat->mq_curmsgs = mqueue->count;
        posix_scheduler_unlock();

        return 0;
}

#endif

/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    mq_notify
|*
\*****************************************************************************/

#include <errno.h>
#include <mqueue.h>
#include "posix_mqueue.h"

#if ( __POSIX_MESSAGE_PASSING != 0 )

/**
 * @brief registers the calling process to be notified of message arrival 
 *		
 *		If the argument notification is not NULL, this function shall register 
 *		the calling process to be notified of message arrival at an empty message 
 *		queue associated with the specified message queue descriptor, mqdes. 
 *		The notification specified by the notification argument shall be sent to 
 *		the process when the message queue transitions from empty to non-empty. 
 *		At any time, only one process may be registered for notification by a message 
 *		queue. If the calling process or any other process has already registered for 
 *		notification of message arrival at the specified message queue, subsequent 
 *		attempts to register for that message queue shall fail.
 *		If a process has registered for notification of message arrival at a message 
 *		queue and some thread is blocked in mq_receive() waiting to receive a message 
 *		when a message arrives at the queue, the arriving message shall satisfy the 
 *		appropriate mq_receive(). The resulting behavior is as if the message queue 
 *		remains empty, and no notification shall be sent.
 *
 * @param mqdes 
 *		  a message queue descriptor
 * @param notification 
 *		  pointer to a read-only struct sigevent notification variable   
 * @return
 *		  Upon successful completion, the mq_notify() function shall return a value 
 *		  of zero; otherwise, the function shall return a value of -1 and set errno 
 *		  to indicate the error.
 * 
 */
int mq_notify(mqd_t mqdes, const struct sigevent *notification)
{
        struct posix_mquser_t *user     = (struct posix_mquser_t *)mqdes;
        struct posix_mqueue_t *mqueue   = user->table;
        int retval = 0;
        
        if ( user->initi != _ATTR_INIT_KEY ) 
        {
                errno  = EBADF;
                return -1;
        }

        pthread_mutex_lock(&_posix_mqueue_mutex);

        if ( NULL == notification ) 
        {
                /* existing registration (if at all) shall be removed */
                mqueue->sigev           = NULL;
                mqueue->notifyuser      = NULL;
                retval = 0;
                goto exit_unlock;
        }

        if ( NULL != mqueue->sigev )
        {
                 /* already registered */
                errno = EBUSY;
                retval = -1;
                goto exit_unlock;
        } 

        /* register notification */
        mqueue->sigev           = notification;
        mqueue->notifyuser      = user;
    
exit_unlock:
    
        pthread_mutex_unlock(&_posix_mqueue_mutex);
        return retval;

}

#endif

/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    mq_timedsend
|*
\*****************************************************************************/
#include <mqueue.h>
#include <fcntl.h>
#include "posix_mqueue.h"


#if ( (__POSIX_TIMEOUTS != 0) && (__POSIX_MESSAGE_PASSING != 0) )


/**
 * @brief adds the message pointed to by the argument msg_ptr to the message queue mqdes
 *		
 *		The mq_timedsend() function shall add a message to the message queue specified by 
 *		mqdes in the manner defined for the mq_send() function. However, if the specified 
 *		message queue is full and O_NONBLOCK is not set in the message queue description 
 *		associated with mqdes, the wait for sufficient room in the queue shall be terminated 
 *		when the specified timeout expires. If O_NONBLOCK is set in the message queue description, 
 *		this function shall be equivalent to mq_send().
 *		The timeout shall expire when the absolute time specified by abs_timeout passes, 
 *		as measured by the clock on which timeouts are based (that is, when the value of that 
 *		clock equals or exceeds abs_timeout), or if the absolute time specified by abs_timeout 
 *		has already been passed at the time of the call.
 *
 * @param mqdes 
 *		  a message queue descriptor
 * @param msg_ptr 
 *		  pointer to read-only transmit message buffer
 * @param msg_len 
 *		  length of the message
 * @param msg_prio 
 *		  message's priority
 * @param abs_timeout 
 *		  parameter to read-only struct timespec variable
 * @return
 *		Upon successful completion, the mq_send() function shall return a value of zero.
 *		Otherwise, no message shall be enqueued, the functions shall return -1, and errno 
 *		shall be set to indicate the error.
 * 
 */
int mq_timedsend(       mqd_t mqdes, 
                        const char *msg_ptr, 
                        size_t msg_len,
                        unsigned msg_prio, 
                        const struct timespec *abs_timeout
                )
{

        struct posix_mquser_t *user      = (struct posix_mquser_t *)mqdes;

        return posix_mqueue_send (
                        user, 
                        msg_ptr, 
                        msg_len, 
                        msg_prio,
                        ((user->flags & O_NONBLOCK) != O_NONBLOCK) , 
                        abs_timeout
                        );
}


#endif



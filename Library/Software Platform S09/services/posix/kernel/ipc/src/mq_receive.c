/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    mq_receive
|*
\*****************************************************************************/

#include <mqueue.h>
#include <fcntl.h>
#include "posix_mqueue.h"

#if ( __POSIX_MESSAGE_PASSING != 0 )

/**
 * @brief receives the oldest of the highest priority message(s) from the message queue mqdes
 *		
 *		The mq_receive() function shall receive the oldest of the highest priority message(s) 
 *		from the message queue specified by mqdes. If the size of the buffer in bytes, 
 *		specified by the msg_len argument, is less than the mq_msgsize attribute of the 
 *		message queue, the function shall fail and return an error. Otherwise, the 
 *		selected message shall be removed from the queue and copied to the buffer pointed 
 *		to by the msg_ptr argument.
 *		If the value of msg_len is greater than {SSIZE_MAX}, the result is implementation-defined.
 *		If the argument msg_prio is not NULL, the priority of the selected message shall be 
 *		stored in the location referenced by msg_prio.
 *		If the specified message queue is empty and O_NONBLOCK is not set in the message 
 *		queue description associated with mqdes, mq_receive() shall block until a message 
 *		is enqueued on the message queue or until mq_receive() is interrupted by a signal. 
 *		If more than one thread is waiting to receive a message when a message arrives at 
 *		an empty queue and the Priority Scheduling option is supported, then the thread of 
 *		highest priority that has been waiting the longest shall be selected to receive the message. 
 *		Otherwise, it is unspecified which waiting thread receives the message. 
 *		If the specified message queue is empty and O_NONBLOCK is set in the message queue 
 *		description associated with mqdes, no message shall be removed from the queue, 
 *		and mq_receive() shall return an error.
 *
 * @param mqdes 
 *		  a message queue descriptor
 * @param msg_ptr 
 *		  buffer pointer to receive the message
 * @param msg_len 
 *		  length of the message
 * @param msg_prio 
 *		  return parameter holding the message's priority
 * @return
 *		  Upon successful completion, the mq_receive() function shall return the length 
 *		  of the selected message in bytes and the message shall be removed from the queue. 
 *		  Otherwise, no message shall be removed from the queue, the functions shall return 
 *		  a value of -1, and set errno to indicate the error.
 * 
 */
ssize_t mq_receive(mqd_t mqdes, char *msg_ptr, size_t msg_len, unsigned *msg_prio)
{

        struct posix_mquser_t *user = (struct posix_mquser_t *)mqdes;

        return posix_mqueue_receive (   
                        user,
                        msg_ptr,
                        msg_len, 
                        msg_prio,
                        ((user->flags & O_NONBLOCK) != O_NONBLOCK),
                        NULL );
}

#endif




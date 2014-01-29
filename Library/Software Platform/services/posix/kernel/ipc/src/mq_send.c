/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    mq_send
|*
\*****************************************************************************/
#include <mqueue.h>
#include <fcntl.h>
#include "posix_mqueue.h"

#if ( __POSIX_MESSAGE_PASSING != 0 )

/**
 * @brief adds the message pointed to by the argument msg_ptr to the message queue mqdes
 *		
 *		The mq_send() function shall add the message pointed to by the argument msg_ptr 
 *		to the message queue specified by mqdes. The msg_len argument specifies the length 
 *		of the message, in bytes, pointed to by msg_ptr. The value of msg_len shall be less 
 *		than or equal to the mq_msgsize attribute of the message queue, or mq_send() shall fail.
 *		If the specified message queue is not full, mq_send() shall behave as if the message 
 *		is inserted into the message queue at the position indicated by the msg_prio argument. 
 *		A message with a larger numeric value of msg_prio shall be inserted before messages 
 *		with lower values of msg_prio. A message shall be inserted after other messages in 
 *		the queue, if any, with equal msg_prio. The value of msg_prio shall be less than {MQ_PRIO_MAX}.
 *		If the specified message queue is full and O_NONBLOCK is not set in the message 
 *		queue description associated with mqdes, mq_send() shall block until space becomes 
 *		available to enqueue the message, or until mq_send() is interrupted by a signal. 
 *		If more than one thread is waiting to send when space becomes available in the message 
 *		queue and the Priority Scheduling option is supported, then the thread of the highest 
 *		priority that has been waiting the longest shall be unblocked to send its message. 
 *		Otherwise, it is unspecified which waiting thread is unblocked. If the specified 
 *		message queue is full and O_NONBLOCK is set in the message queue description associated 
 *		with mqdes, the message shall not be queued and mq_send() shall return an error.
 *
 * @param mqdes 
 *		  a message queue descriptor
 * @param msg_ptr 
 *		  pointer to read-only transmit message buffer
 * @param msg_len 
 *		  length of the message
 * @param msg_prio 
 *		  message's priority
 * @return
 *		Upon successful completion, the mq_send() function shall return a value of zero.
 *		Otherwise, no message shall be enqueued, the functions shall return -1, and errno 
 *		shall be set to indicate the error.
 * 
 */
int mq_send(mqd_t mqdes, const char *msg_ptr, size_t msg_len, unsigned msg_prio)
{

        struct posix_mquser_t *user = (struct posix_mquser_t *)mqdes;

        return posix_mqueue_send (
                user, 
                msg_ptr, 
                msg_len, 
                msg_prio,
                ((user->flags & O_NONBLOCK) != O_NONBLOCK), 
                NULL );
}

#endif



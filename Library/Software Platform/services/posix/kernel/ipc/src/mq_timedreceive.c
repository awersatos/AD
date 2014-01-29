/******************************************************************************
 * FILE:        @(#)mq_timedreceive.c   1.4 07/02/21    
 * DESCRIPTION:
 *      
 *      The mq_timedreceive() function shall receive the oldest of the highest
 *      priority messages from the message queue specified by mqdes as described 
 *      for the mq_receive() function. 
 *      If O_NONBLOCK is set, this function is equivalent to mq_receive().
 *
 *****************************************************************************/
#include <mqueue.h>
#include <fcntl.h>
#include "posix_mqueue.h"

#if ( __POSIX_TIMEOUTS != 0 && __POSIX_MESSAGE_PASSING != 0 )


/**
 * @brief receives the oldest of the highest priority message(s) from the message queue mqdes
 *		
 *		The mq_timedreceive() function shall receive the oldest of the highest priority messages 
 *		from the message queue specified by mqdes as described for the mq_receive() function. 
 *		However, if O_NONBLOCK was not specified when the message queue was opened via the 
 *		mq_open() function, and no message exists on the queue to satisfy the receive, 
 *		the wait for such a message shall be terminated when the specified timeout expires. 
 *		If O_NONBLOCK is set, this function is equivalent to mq_receive().
 *		The timeout expires when the absolute time specified by abs_timeout passes, 
 *		as measured by the clock on which timeouts are based (that is, when the value of that 
 *		clock equals or exceeds abs_timeout), or if the absolute time specified by abs_timeout 
 *		has already been passed at the time of the call. 
 *
 * @param mqdes 
 *		  a message queue descriptor
 * @param msg_ptr 
 *		  buffer pointer to receive the message
 * @param msg_len 
 *		  length of the message
 * @param msg_prio 
 *		  return parameter holding the message's priority
 * @param abs_timeout 
 *		  parameter to read-only struct timespec variable
 *  
 * @return
 *		  Upon successful completion, the function shall return the length 
 *		  of the selected message in bytes and the message shall be removed from the queue. 
 *		  Otherwise, no message shall be removed from the queue, the functions shall return 
 *		  a value of -1, and set errno to indicate the error.
 * 
 */
ssize_t mq_timedreceive(        mqd_t mqdes, 
                                char *msg_ptr, 
                                size_t msg_len,
                                unsigned *msg_prio, 
                                const struct timespec * abs_timeout
                        )
{

        struct posix_mquser_t *user = (struct posix_mquser_t *)mqdes;

        return posix_mqueue_receive (
                user, 
                msg_ptr, 
                msg_len, 
                msg_prio,
                ((user->flags & O_NONBLOCK) != O_NONBLOCK) , 
                abs_timeout );
}

#endif








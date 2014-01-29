/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    mq_close
|*
\*****************************************************************************/

#include <errno.h>
#include <mqueue.h>
#include <sys/types.h>
#include <stdarg.h>
#include <pthread.h>
#include <fcntl.h>
#include <string.h>
#include <stdlib.h>
#include "posix_mqueue.h"

#if ( __POSIX_MESSAGE_PASSING != 0 )

/**
 * @brief
 *		removes the association between the message queue descriptor, mqdes, and its message queue.
 *	
 *		The results of using this message queue descriptor after successful return from this
 * 		mq_close(), and until the return of this message queue descriptor from a subsequent 
 *		mq_open(), are undefined. 
 *
 * @param mqdes
 *      message queue descriptor
 * 
 * @return
 * 		Upon successful completion, the mq_close() function shall return a value of zero; 
 *		otherwise, the function shall return a value of -1 and set errno to indicate the error.
 */
int mq_close(mqd_t mqdes)
{

        struct posix_mquser_t *user = (struct posix_mquser_t *)mqdes;
        struct posix_mquser_t *usertmp;
        struct posix_mqueue_t *mqueue;
        
        if ( user->initi != _ATTR_INIT_KEY )
        {
                /* The mqdes argument is not a valid message 
                 * queue descriptor */
                errno  = EBADF;
                return -1;
        }

        pthread_mutex_lock( &_posix_mqueue_mutex );

        mqueue = user->table;
        
        if (mqueue->users == NULL)
        {
                /* no users in mqueue? */
                errno  = EBADF;
                pthread_mutex_unlock( &_posix_mqueue_mutex );
                return -1;

        }
        
        /* de-register notification */
        if ( user == mqueue->notifyuser ) 
        {
                mqueue->sigev           = NULL;
                mqueue->notifyuser      = NULL;
        }

        /* de-register user from mqueue */
        if (mqueue->users == user ) 
        {
                mqueue->users = user->next;  
        } 
        else
        {
                for ( usertmp = mqueue->users; NULL != usertmp->next;
                        usertmp = usertmp->next )
                {
                        if ( usertmp->next == user )
                                break;
                }

                usertmp->next = user->next;
        }

        user->initi = 0; 
        free( user );

        if ( (true == mqueue->unlink) && (NULL == mqueue->users) ) 
        {
                posix_mqueue_unlink( mqueue );
        }

        pthread_mutex_unlock( &_posix_mqueue_mutex );
    
        return 0;
}

#endif

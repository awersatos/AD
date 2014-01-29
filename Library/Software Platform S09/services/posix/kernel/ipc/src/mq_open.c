/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    mq_open
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

/**
 *  @file mqueue.h
 *      
 *      This plugin implements the POSIX_MESSAGE_PASSING Unit of Functionality
 *      to support message queueing mechanisms for communication between threads.
 *      
 */

#if ( __POSIX_MESSAGE_PASSING != 0 )

static struct mq_attr open_default_attr = { 0, MQ_OPEN_MAX, 128 };

/**
 * @brief
 *      establishes the connection with a message queue
 *  
 *      It shall create an open message queue description that refers to the message queue,
 *      and a message queue descriptor that refers to that open message queue description. 
 *      The message queue descriptor is used by other functions to refer to that message queue.
 *      The mq_open() function does not add or remove messages from the queue.
 *       
 * @param name
 *      path name of the message queue
 * @param oflag
 *      the oflag parameter requests the desired receive and/or send access to 
 *      the message queue. The value of oflag is the bitwise-inclusive 
 *      OR of values from the following list: ( one of O_RDONLY,O_WRONLY,O_RDWR 
 *      and any combination of O_CREAT,O_EXCL,O_NONBLOCK ) 
 * 
 * @return
 *      Upon successful completion, the function shall return a message queue 
 *      descriptor; otherwise, the function shall return (mqd_t)-1 and set 
 *      errno to indicate the error. The value of oflag is the bitwise-inclusive 
 *      OR of values from the following list: O_RDONLY, O_WRONLY, O_RDWR.
 * 
 */
mqd_t mq_open(const char *name, int oflag, ...)
{
        mqd_t retval;
        int i;
        struct posix_mqueue_t * mqueue = NULL;
        
        mode_t mode; 
        const struct mq_attr *attr;
        va_list args;
    
        struct posix_mquser_t *user;

        void    *queue; 
        size_t  headersize;

        struct posix_mqheader_t * qtmp;
        
        if( (oflag & O_ACCMODE) != O_RDWR && (oflag & O_ACCMODE) != O_RDONLY && (oflag & O_ACCMODE) != O_WRONLY)
        {
                errno = EINVAL; return (mqd_t)-1;
        }

        pthread_mutex_lock( &_posix_mqueue_mutex );
    
        /* find mqueue among opened ones */
        for ( i=0; i < MQ_OPEN_MAX ; i++ )
        {
                if ( 0 == strncmp(      name, 
                                        _posix_mqueue_table[i].name, 
                                        PATH_MAX) &&
                     _posix_mqueue_table[i].queue != NULL ) 
                {
                        mqueue = &_posix_mqueue_table[i];
                        break;
                }
        }
        
        if (    (NULL != mqueue)                &&
                ( (oflag & (O_EXCL | O_CREAT)) == (O_EXCL | O_CREAT) ) ) 
        {
                /* O_CREAT and O_EXCL are set and the named message 
                 * queue already exists */
                errno = EEXIST;
                retval = (mqd_t)-1;
                goto exit_unlock;
        }

        if ( (NULL == mqueue) && (O_CREAT != (oflag & O_CREAT)) )
        {
                /* O_CREAT is not set and the named message queue 
                 * does not exist */
                errno  = ENOENT;
                retval = (mqd_t)-1;
                goto exit_unlock;
        }

        if (NULL == mqueue) 
        {
                /* message queue to be created */
                
                /* It requires two additional arguments: 
                 * mode: which shall be of type mode_t, 
                 * attr: which shall be a pointer to an mq_attr structure.
                 */
                va_start( args, oflag );
                mode = va_arg( args, mode_t );
                attr = va_arg( args, struct mq_attr * );
                va_end( args );

                /* search for empty entry in mqueue table */
                for ( i=0; i < MQ_OPEN_MAX; i++ ) 
                {
                        if ( NULL == _posix_mqueue_table[i].queue )
                        break;
                }

        
                if ( i == MQ_OPEN_MAX ) 
                {
                        /* Too many message queues are currently 
                         * open in the system */
                        errno = ENFILE;
                        retval = (mqd_t)-1;
                        goto exit_unlock;
                }
                
                mqueue = &_posix_mqueue_table[i];

                if ( NULL == attr )
                {
                        /* If attr is NULL, the message queue shall be
                         * created with implementation-defined default 
                         * message queue attributes */ 
                        attr = &open_default_attr;
                }
                else 
                {
                        /* O_CREAT was specified in oflag, the value of 
                         * attr is not NULL, and either mq_maxmsg or 
                         * mq_msgsize was less than or equal to zero */
                        if (attr->mq_maxmsg <= 0 || attr->mq_msgsize <= 0)
                        {
                                errno = EINVAL;
                                retval = (mqd_t)-1;
                                goto exit_unlock;
                        }
                }
        
                /* allocate the underlying queue */
                #define addralign       (sizeof(void *) - 1)
                headersize = sizeof(struct posix_mqheader_t) +  attr->mq_msgsize;
                headersize = (headersize + addralign) & ~addralign;
                queue = malloc( headersize * attr->mq_maxmsg );
                if (queue == NULL)
                {
                        /* There is insufficient space for the creation of 
                         * the new message underlaying queue */
                        errno = ENOSPC;
                        retval = (mqd_t)-1;
                        goto exit_unlock;
                }
                /* link up freelist */
                for ( i=0, qtmp=(struct posix_mqheader_t *)queue;
                        i<attr->mq_maxmsg; i++, qtmp=qtmp->next ) 
                {
                        qtmp->busy = false;
                        qtmp->next = (struct posix_mqheader_t *)
                                        ((char *)qtmp + headersize);
                        qtmp->buf  = ((char *)qtmp + sizeof(struct posix_mqheader_t)) ;
                }
                qtmp->next = NULL;
                qtmp->busy = false;
                qtmp->buf  = ((char *)qtmp + sizeof(struct posix_mqheader_t)) ;

                /* allocate users information */ 
                user = (struct posix_mquser_t *) 
                                malloc( sizeof(struct posix_mquser_t) );
                if ( NULL == user ) 
                {
                        free( queue );
                        errno = ENOSPC;
                        retval = (mqd_t)-1;
                        goto exit_unlock;
                }
                user->next              = NULL;
                user->flags             = oflag ;
                user->table             = mqueue;
                user->initi             = _ATTR_INIT_KEY;

                /* mqueue */
                strncpy( mqueue->name, name, PATH_MAX );
                mqueue->maxmsg          = attr->mq_maxmsg;
                mqueue->msgsize         = attr->mq_msgsize;
                mqueue->freelist        = queue;
                mqueue->queue           = queue;
                mqueue->queuesize       = headersize * attr->mq_maxmsg ;
                mqueue->users           = user;
        }
        else
        {
                /* we are not creating */
                
                /* has it been unlinked */
                if (true == mqueue->unlink) 
                {
                        errno = EINVAL;
                        retval = (mqd_t)-1;
                        goto exit_unlock;
                }

                user = (struct posix_mquser_t *) 
                        malloc( sizeof(struct posix_mquser_t) );
                if ( NULL == user )
                {
                        errno = ENOSPC;
                        retval = (mqd_t)-1;
                        goto exit_unlock;
                }
                
                /* prepend it */
                user->next      = mqueue->users;
                mqueue->users   = user;

                user->flags     = oflag;
                user->table     = mqueue;
                user->flags     = oflag;
                user->initi     = _ATTR_INIT_KEY;
        }
        
        /* returns pointer to user's mqd_t */
        retval=(mqd_t)user;

exit_unlock:
        
        pthread_mutex_unlock( &_posix_mqueue_mutex );
        
        return retval;
}


#endif


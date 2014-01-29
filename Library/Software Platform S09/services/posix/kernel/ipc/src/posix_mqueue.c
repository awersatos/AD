#include <errno.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include "posix_mqueue.h"
#include "posix_signal.h"
#include "posix_time.h"
#include "kernel.h"

#if ( __POSIX_MESSAGE_PASSING != 0 )

/* mqueue critical code */
pthread_mutex_t         _posix_mqueue_mutex = PTHREAD_MUTEX_INITIALIZER;

/* mqueue information table */
struct posix_mqueue_t   _posix_mqueue_table[MQ_OPEN_MAX];


/* init mqueues */
void    posix_mqueue_init(void)
{
        int i;
        struct posix_mqueue_t*       mqueue;
        
        for ( i=0,mqueue = &_posix_mqueue_table[0];
                        i < MQ_OPEN_MAX ; i++,mqueue++ )
        {
                mqueue->name[0] = '\0'; 
                mqueue->maxmsg          = 0;
                mqueue->msgsize         = 0;
                mqueue->unlink          = false;
                mqueue->uselist         = NULL;
                mqueue->freelist        = NULL;
                mqueue->count           = 0;
                mqueue->queue           = NULL;
                mqueue->users           = NULL;
                mqueue->sigev           = NULL;
                mqueue->notifyuser      = NULL;

                /* initialize mutex and conds */
                posix_mutex_init(&mqueue->mutex);
                posix_cond_init(&mqueue->txcond);
                posix_cond_init(&mqueue->rxcond);
        }

        return;
}


/* unlink a mqueue entry */
void posix_mqueue_unlink( struct posix_mqueue_t * mqueue )
{
        mqueue->name[0] = '\0'; 
                
        free( mqueue->queue );
        mqueue->queue=NULL;
}


void posix_mqueue_notify( struct posix_mqueue_t * mqueue )
{

        const struct sigevent *ev;
        
        posix_scheduler_lock();

        ev =  mqueue->sigev;
        if ( NULL == ev )
        {
                posix_scheduler_unlock();
                return;
        }

        /* de-register */
        mqueue->sigev    = NULL;
        mqueue->notifyuser = NULL; 
        
        posix_scheduler_unlock();
        
        #if ( __POSIX_SIGNALS != 0 )
        posix_generate_signal( ev, SI_MESGQ, NULL );
        posix_deliver_signals();
        #endif
        
        return; 
}


int posix_mqueue_send ( struct posix_mquser_t *user, 
                        const char *msg_ptr, 
                        size_t msg_len,
                        unsigned int msg_prio, 
                        bool block, 
                        const struct timespec *timeout )
{
        int retval = 0;
        struct posix_mqueue_t*       mqueue = user->table;
        struct posix_mqheader_t      *hdr, **hdrp;
        clock_t                      ticks;
        bool                         notification_todo = false;
        posix_thread_t*              self = posix_self_thread();

        /* 'mq_send/mq_timedsend' are cancellation points */
        pthread_testcancel();

        if (    msg_prio > MQ_PRIO_MAX  ||
                msg_ptr == NULL         ) 
        {
                /* The value of msg_prio was outside the valid range or
                 * msg_ptr == NULL */
                retval = EINVAL ;
        }
        else if (       user->initi != _ATTR_INIT_KEY )
        {
                /* The mqdes argument is not a valid message 
                 * queue descriptor */
                retval  = EBADF;
        }
        else if ( msg_len > (size_t)mqueue->msgsize )
        {
                /* The specified message length, msg_len, exceeds 
                 * the message size attribute of the message queue */
                retval = EMSGSIZE;
        }
        else if (       (O_WRONLY != (user->flags & O_WRONLY)) &&
                (O_RDWR != (user->flags & O_RDWR)) )
        {
                /* not open for writing */
                retval = EBADF;
        }
        else
        {
                /* send operation: lock the mqueue */
                pthread_mutex_lock(&mqueue->mutex);

                /* is the queue full? */
                while (mqueue->count == mqueue->maxmsg && retval==0 )
                {
                        if (block==false)
                        {
                                retval = EAGAIN;        
                                break;
                        }
                        else
                        {
#                               if ( __POSIX_TIMEOUTS != 0 )
                                if ( timeout != NULL )
                                {
                                        if ( !posix_valid_timespec(timeout) )
                                        {
                                                retval = EINVAL;
                                                break;
                                        }

                                        ticks = posix_timespec_to_ticks(
                                                &_posix_system_clock,
                                                timeout );    
                                }
                                else
                                {
#                               endif

                                        ticks = -1;
#                               if ( __POSIX_TIMEOUTS != 0 )                                
                                }
#                               endif
                        
                                /* block until space in the queue for 
                                 * new messages */
                                self->osmutex = 1;      
                                retval = __pthread_cond_timedwait(
                                        &mqueue->txcond,
                                        &mqueue->mutex,
                                        ticks);

                                /* 'mq_send/mq_timedsend' are 
                                 * cancellation points */
                                pthread_testcancel();
                        }
                }

                /* now i should write if retval == 0 */
                if (retval==0)
                {
                        /* get next header from the freelist */
                        if (!mqueue->freelist->busy)
                        {
                                hdr      = mqueue->freelist;
                                mqueue->freelist = 
                                        mqueue->freelist->next;
                        }
                        else 
                        {
                                for ( hdrp = &mqueue->freelist; 
                                        !(*hdrp)->next->busy; 
                                        hdrp = &(*hdrp)->next ) ;
                                hdr = (*hdrp)->next;
                                (*hdrp)->next   = hdr->next;
                        }

                        /* and add it to uselist */
                        if ( NULL == mqueue->uselist ) 
                        {
                                mqueue->uselist = hdr;
                                mqueue->uselist->next = NULL;
                        } 
                        else
                        {
                  
                                /* insert into uselist */
                                for (   hdrp=&mqueue->uselist; 
                                        NULL != *hdrp; 
                                        hdrp = &((*hdrp)->next) 
                                )
                                {
                                        if ((*hdrp)->priority < msg_prio)
                                        break;
                                }
                                hdr->next = *hdrp;
                                *hdrp = hdr;
                        }
                        
                        /* hdr points at where to write, now in the uselist
                         * BUT marked as busy until data is copied */

                        hdr->priority = msg_prio;
                        hdr->busy = true; 

                        /* copy process: mutex must be unlocked */
                        pthread_mutex_unlock(&mqueue->mutex);
                        hdr->buflen     = msg_len;
                        memcpy( hdr->buf, msg_ptr, msg_len );
                        pthread_mutex_lock(&mqueue->mutex);
                
                        hdr->busy = false;
                
                        /* empty to non-empty transition */
                        if ( mqueue->count == 0 )
                        {
                                if ( posix_qthread_empty(&mqueue->rxcond.queue) )
                                {
                                        /* no waiters */
                                        if (mqueue->sigev != NULL)
                                        {
                                                /* notify */
                                                notification_todo = true;
                                        }
                                }
                                else
                                {
                                        /* signal oldest: 
                                         * No PRIORITY_SCHEDULING in PSE51 */
                                        pthread_cond_signal(&mqueue->rxcond);
                                }
                        }

                        /* check not need but add security */
                        if (mqueue->count < mqueue->maxmsg) 
                        {
                                mqueue->count++;
                        }
                }    
            
                pthread_mutex_unlock(&mqueue->mutex);
        
                if (notification_todo)
                {
                        posix_mqueue_notify(mqueue);
                }
        }

        /* 'mq_send/mq_timedsend' are cancellation points */
        
        if (retval)
        {
                errno = retval;
                retval = -1;
        }
        
        return retval;
        
}

ssize_t posix_mqueue_receive(   struct posix_mquser_t *user,
                                char *msg_ptr, 
                                size_t msg_len,
                                unsigned int *msg_prio, 
                                bool block, 
                                const struct timespec *timeout )
{
        int retval = 0;             
        struct posix_mqheader_t      * hdr, *hdrtmp;
        struct posix_mqueue_t*       mqueue = user->table;
        clock_t                         ticks;
        posix_thread_t*              self = posix_self_thread();

        /* mq_receive/mq_timedreceive are cancellation points */
        pthread_testcancel();
        
        if ( msg_ptr == NULL || msg_len == 0 )
        {
                retval = EINVAL;
        }
        else if ( user->initi != _ATTR_INIT_KEY  )
        {
                retval = EBADF;
        }
        else if ( (O_RDONLY != (user->flags & O_ACCMODE) ) && 
                  (O_RDWR   != (user->flags & O_ACCMODE)   )  )
        {
                retval = EBADF;
        }
        else if ( msg_len < (size_t)mqueue->msgsize ) 
        {
                retval = EMSGSIZE;
        }
        else
        {
                /* receive operation: lock the mqueue */
                pthread_mutex_lock(&mqueue->mutex);

                /* is the queue empty? */
                while ( mqueue->count == 0 && retval==0 )
                {
                        if (block==false)
                        {
                                retval = EAGAIN;        
                                break;
                        }
                        else
                        {
#                               if ( __POSIX_TIMEOUTS != 0 )
                                if ( timeout != NULL )
                                {
                                        if ( !posix_valid_timespec(timeout) )
                                        {
                                                retval = EINVAL;
                                                break;
                                        }

                                        ticks = posix_timespec_to_ticks(
                                                        &_posix_system_clock,
                                                        timeout );    
                                }
                                else
                                {
#                               endif
                                        
                                        ticks = -1;
                                        
#                               if ( __POSIX_TIMEOUTS != 0 )
                                }
#                               endif   

                                /* wait until a new msg arrives */
                                self->osmutex = 1;
                                retval = __pthread_cond_timedwait(
                                        &mqueue->rxcond,
                                        &mqueue->mutex,
                                        ticks);

                                /* mq_receive/mq_timedreceive are 
                                 * cancellation points */
                                pthread_testcancel();
                                if (retval == ETIMEDOUT)
                                {
                                        break;
                                }
                        }
                }

                /* now I should be able to read if retval == 0 */
                if (retval==0)
                {
                        /* get next header from uselist */
                        if ( !mqueue->uselist->busy ) 
                        { 
                                /* fast case */
                                hdr             = mqueue->uselist;
                                mqueue->uselist = hdr->next;
                        } 
                        else 
                        {
                                for ( hdrtmp = mqueue->uselist; 
                                      !hdrtmp->next->busy; 
                                      hdrtmp=hdrtmp->next ) ; 
                                hdr             = hdrtmp->next;
                                hdrtmp->next    = hdr->next;
                        } 

                        /* hdr points at where to read from 
                         * (now located in the freelist BUT marked as 
                         * busy until data is copied ) */
                        hdr->next               = mqueue->freelist;
                        mqueue->freelist        = hdr;
                        hdr->busy               = true;
                        if (msg_prio != NULL)
                        {
                                *msg_prio = hdr->priority;
                        }

                        /* copy process: mutex must be unlocked */
                        pthread_mutex_unlock(&mqueue->mutex);
                        msg_len = hdr->buflen;
                        memcpy( msg_ptr, hdr->buf, msg_len );
                        pthread_mutex_lock(&mqueue->mutex);
                
                        hdr->busy = false;
                
                        /* empty to non-empty transition */
                        if (mqueue->count == mqueue->maxmsg)
                        {
                                if ( ! posix_qthread_empty(&mqueue->txcond.queue) )
                                {
                                        /* signal oldest: 
                                         * No PRIORITY_SCHEDULING in PSE51 */
                                        pthread_cond_signal(&mqueue->txcond);
                                }
                        }
                        
                        if (mqueue->count>0) /* check not need but add security */
                        {
                                mqueue->count--;
                        }
                }
                
                pthread_mutex_unlock(&mqueue->mutex);
        }
        
        if (retval)
        {
                errno = retval;
                retval = (ssize_t)-1;
        }
        else
        {
                retval = msg_len;
        }

        return retval;
}

#endif /* __POSIX_MESSAGE_PASSING */


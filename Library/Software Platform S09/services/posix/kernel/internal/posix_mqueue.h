/******************************************************************************
 * FILE:        @(#)posix_mqueue.h      1.4 07/02/21    
 * DESCRIPTION:
 *      mqueue posix internal interface
 *****************************************************************************/
#ifndef _H_POSIX_MQUEUE
#define _H_POSIX_MQUEUE

#include <limits.h>
#include <pthread.h>
#include <mqueue.h>
#include <stdbool.h>
#include "posix_pthread.h"

#if ( __POSIX_MESSAGE_PASSING != 0 )

/* typedefs */

struct posix_mquser_t 
{
        int                     flags;          
        struct posix_mqueue_t   *table; 
        struct posix_mquser_t   *next;
        int32_t                 initi;
};

struct posix_mqheader_t 
{
        int                     priority;
        size_t                  buflen;
        char *                  buf;
        volatile bool           busy;
        struct posix_mqheader_t *next;
};

struct posix_mqueue_t 
{
        char                    name[ PATH_MAX ]; 
        long                    maxmsg;           
        long                    msgsize;          
        bool                    unlink; 
        
        pthread_mutex_t         mutex;
        pthread_cond_t          txcond;
        pthread_cond_t          rxcond;
        struct posix_mqheader_t         *uselist;
        struct posix_mqheader_t         *freelist;     
        int                     count;

        void                    *queue; 
        size_t                  queuesize;

        struct posix_mquser_t   *users;  
        const struct sigevent   *sigev; 
        struct posix_mquser_t   *notifyuser;
};


extern struct posix_mqueue_t _posix_mqueue_table[];
extern pthread_mutex_t       _posix_mqueue_mutex;

extern void posix_mqueue_init(void);
extern void posix_mqueue_unlink( struct posix_mqueue_t * );
extern void posix_mqueue_notify( struct posix_mqueue_t * );

extern int  posix_mqueue_send ( struct posix_mquser_t *user, 
                                const char *msg_ptr, 
                                size_t msg_len,
                                unsigned int msg_prio, 
                                bool block, 
                                const struct timespec *timeout );

extern ssize_t posix_mqueue_receive(    struct posix_mquser_t *user,
                                        char *msg_ptr, 
                                        size_t msg_len,
                                        unsigned *msg_prio, 
                                        bool block, 
                                        const struct timespec *timeout );

#endif /* __POSIX_MESSAGE_PASSING */

#endif



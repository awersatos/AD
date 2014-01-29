/******************************************************************************
 * FILE:        @(#)mqueue.h    1.4 06/06/09
 * DESCRIPTION:
 *      message queue box posix interface
 *****************************************************************************/
#ifndef _MQUEUE_H
#define _MQUEUE_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <limits.h>

#if ( __POSIX_MESSAGE_PASSING != 0 )

#include <signal.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

struct mq_attr
{
        long    mq_flags; 
        long    mq_maxmsg;  
        long    mq_msgsize; 
        long    mq_curmsgs;  
};

int      mq_close(mqd_t);
int      mq_getattr(mqd_t, struct mq_attr *);
int      mq_notify(mqd_t, const struct sigevent *);
mqd_t    mq_open(const char *, int, ...);
ssize_t  mq_receive(mqd_t, char *, size_t, unsigned *);
int      mq_send(mqd_t, const char *, size_t, unsigned );
int      mq_setattr(mqd_t, const struct mq_attr *,
             struct mq_attr *);
#if ( __POSIX_TIMEOUTS != 0 )
ssize_t  mq_timedreceive(mqd_t, char *, size_t,
             unsigned *, const struct timespec *);
int      mq_timedsend(mqd_t, const char *, size_t, unsigned ,
             const struct timespec *);
#endif
int      mq_unlink(const char *);

#endif

#ifdef  __cplusplus
}
#endif

#endif



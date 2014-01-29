/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    mq_unlink
|*
\*****************************************************************************/
#include <errno.h>
#include <mqueue.h>
#include <sys/types.h>
#include <pthread.h>
#include <string.h>
#include "posix_mqueue.h"

#if ( __POSIX_MESSAGE_PASSING != 0 )

/**
 * @brief
 *		removes the message queue named by the pathname name.
 *	
 *		The mq_unlink() function shall remove the message queue named 
 *		by the pathname name. After a successful call to mq_unlink() with name, 
 *		a call to mq_open() with name shall fail if the flag O_CREAT is not set 
 *		in flags. If one or more processes have the message queue open when mq_unlink() 
 *		is called, destruction of the message queue shall be postponed until all 
 *		references to the message queue have been closed.
 *
 * @param name
 *      path name of the message queue
 * 
 * @return
 *		Upon successful completion, the function shall return a value of zero. 
 *		Otherwise, the named message queue shall be unchanged by this function call, 
 *		and the function shall return a value of -1 and set errno to indicate the error.
 */
int mq_unlink(const char *name)
{
        int retval;
        int i;
        struct posix_mqueue_t *mqueue = NULL;

        /* find the entry first */
        if ( strlen(name) >PATH_MAX )
        {
                errno = ENAMETOOLONG;
                return -1;
        }
        
        pthread_mutex_lock( &_posix_mqueue_mutex );

        for ( i=0; i < MQ_OPEN_MAX ; i++ )
        {
                if ( 0 == strncmp(      name, 
                                        _posix_mqueue_table[i].name, 
                                        PATH_MAX) )
                {
                        mqueue = &_posix_mqueue_table[i];
                        break;
                } 
        }

        if ( NULL == mqueue )
        { 
                errno = ENOENT;
                retval = -1;
                goto exit_unlock;
        }

        if ( NULL != mqueue->users )
        {
                /* still has users: mark it pending */
                mqueue->unlink = true;     
        } 
        else
        {
                posix_mqueue_unlink( mqueue );
        }
        
        retval = 0;

 exit_unlock:
    
    pthread_mutex_unlock( &_posix_mqueue_mutex );
    
    return retval;
        
}
#endif

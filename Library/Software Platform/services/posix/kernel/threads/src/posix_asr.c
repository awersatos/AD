/*****************************************************************************
 * FILE:                @(#)posix_asr.c 1.8 06/06/09
 * DESCRIPTION:
 *      posix asr handler implementation
 ****************************************************************************/
#include <pthread.h>
#include <interrupts.h>
#include "posix_pthread.h"
#include "posix_asr.h"
#include "posix_signal.h"
#include "kernel.h"

void posix_asr_handler(void* _sptr)
{
        /* i'm running at thread level */
        posix_thread_t *self = (posix_thread_t *)posix_self_thread();

        /* Check for cancellation */
        if( self->cancelpending &&
            self->cancelstate == PTHREAD_CANCEL_ENABLE &&
            self->canceltype  == PTHREAD_CANCEL_ASYNCHRONOUS )
        {
            /* If we have a pending cancellation, cancellations are
             * enabled and we are in asynchronous mode, then we can do the
             * cancellation processing.  Since pthread_exit() does
             * everything we need to do, we just call that here.
             */
            pthread_exit(PTHREAD_CANCELED);
        }
        
#       if ( __POSIX_SIGNALS != 0 )
        /* check for signals */
        posix_deliver_signals();
#       endif

        /* disable interrupts */
        posix_interrupts_disable();
        /* we leave the asr handler */
        self->inasrhandler = 0;
        /* return to saved thread's context */
        _hal_load_ctx(_sptr);
}



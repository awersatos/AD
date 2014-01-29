/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    interrupt services
|*
\********************************************************************/
#include <stddef.h>
#include <pal.h>
#include <interrupts.h>
#include "interrupts_cfg.h"


#if ( __POSIX_KERNEL__ != 0 )
#include <errno.h>
#include "posix_pthread.h"
#include "posix_time.h"
#include "kernel.h"
#include "k_schedule.h"
#endif

interrupt_t  interrupt_table[PAL_ARCH_MAXINTRS];
#if ( __POSIX_KERNEL__ != 0 )
uint32_t     posix_interrupts_bitmask = 0;
#endif

#if ( INTERRUPTS_ISR_MAX      > 1 )

static uint32_t isr_common_handler    ( uint32_t number, void * context);
static bool     isr_register_handler  (interrupt_t* entry, interrupt_handler_t handler, void*context);
static bool     isr_deregister_handler(interrupt_t* entry, interrupt_handler_t handler, void*context);
static bool     isr_associate_thread  ( interrupt_t     *entry, interrupt_handler_t handler,
                                      void* context, posix_thread_t  * thread );
#endif

#define INSTALL_HANDLER(e,h,c)    e->handler = h; e->context = c;
#define DEINSTALL_HANDLER(e )     e->handler = NULL; e->context = NULL;


extern void interrupts_init(void)
{
    int i;
#if ( INTERRUPTS_ISR_MAX      > 1 )
    int j;
#endif
    interrupt_t * entry;
    for ( i = 0; i < PAL_ARCH_MAXINTRS; i++ )
    {
        entry = &interrupt_table[i];
        entry->handler      = NULL;
        entry->context      = NULL;
#if ( __POSIX_KERNEL__ != 0 )
        entry->thread       = NULL;
#endif

#if ( INTERRUPTS_ISR_MAX      > 1 )
        entry->isr_count = 0;
        for ( j=0; j<INTERRUPTS_ISR_MAX; j++ )
        {
            entry->isr_handlers[j].handler = NULL;
            entry->isr_handlers[j].queue   = NULL;
            entry->isr_handlers[j].context = NULL;
#if ( __POSIX_KERNEL__ != 0 )
            entry->isr_handlers[j].thread  = NULL;
#endif
        }
#endif
    }
}

extern bool interrupt_configure( uint32_t number, interrupt_cfg_t cfg )
{
    switch ( cfg )
    {
        case EDGE_RISING : return pal_architecture_interrupt_configure(number,true,true);
        case EDGE_FALLING: return pal_architecture_interrupt_configure(number,true,false);
        case LEVEL_HIGH  : return pal_architecture_interrupt_configure(number,false,true);
        case LEVEL_LOW   : return pal_architecture_interrupt_configure(number,false,false);
        default          : break;
    }
    return false;
}

#if ( __POSIX_KERNEL__ != 0)
extern bool interrupt_set_posix  ( uint32_t number, bool posix )
{
    if (posix)
    {
        posix_interrupts_bitmask |= ( 1 << number );
    }
    else
    {
        posix_interrupts_bitmask &= ~( 1 << number );
    }
    return true;
}

#endif


extern bool interrupt_register_native(uint32_t number, void *context, interrupt_native_handler_t handler)
{
    if (number >= PAL_ARCH_MAXINTRS) return false;
    if (pal_architecture_set_native_handler(number, handler))
    {
        interrupt_table[number].context = context;
        return true;
    }
    return false;
}

extern bool interrupt_register (uint32_t number, void* context, interrupt_handler_t handler)
{
#if ( INTERRUPTS_ISR_MAX      > 1 )
    bool    ret = true;
    uint32_t    count;
#endif

    interrupt_t *entry;
    if (number >= PAL_ARCH_MAXINTRS) return false;
    entry = &interrupt_table[number];

#if ( INTERRUPTS_ISR_MAX      == 1 )

    INSTALL_HANDLER (entry, handler, context);
    return true;

#else

    interrupt_disable(number);
    count = entry->isr_count;
    if ( count >= INTERRUPTS_ISR_MAX )
    {
        ret = false;
    }
    else if (count == 0 )
    {
         INSTALL_HANDLER (entry, handler, context);
         entry->isr_count = 1;
    }
    else
    {
         if ( count == 1 )
         {
            isr_register_handler(entry,entry->handler,entry->context);
            INSTALL_HANDLER (entry, isr_common_handler, NULL );
         }

         if( ! isr_register_handler(entry,handler,context) )
         {
             ret = false;
         }
         else
         {
             entry->isr_count++;
         }
    }
    interrupt_enable(number);
    return ret;
#endif

}

extern bool interrupt_deregister     (uint32_t number, void* context, interrupt_handler_t handler)
{

#if ( INTERRUPTS_ISR_MAX      > 1 )
    bool                ret = true;
    uint32_t            count;
    interrupt_handler_t ahandler;
    void*               acontext;
#endif

    interrupt_t *entry;
    if (number >= PAL_ARCH_MAXINTRS) return false;
    entry = &interrupt_table[number];

#if ( INTERRUPTS_ISR_MAX      == 1 )
    DEINSTALL_HANDLER (entry);
    return true;
#else

    interrupt_disable(number);
    count = entry->isr_count;
    if ( count == 0 || count >= INTERRUPTS_ISR_MAX )
    {
        ret = false;
    }
    else if (count == 1 )
    {
         DEINSTALL_HANDLER (entry);
         entry->isr_count = 0;
    }
    else
    {
        if ( !isr_deregister_handler( entry, handler, context  ) )
        {
             ret = false;
        }
        else
        {
        if ( count == 2 )
            {
                ahandler = entry->head->handler;
                acontext = entry->head->context;
                if ( isr_deregister_handler( entry, ahandler, acontext ) )
                {
                    INSTALL_HANDLER (entry, ahandler, acontext);
                }
            }
        entry->isr_count--;
        }
    }


    if ( entry->isr_count > 0 )
    {
        interrupt_enable(number);
    }
#   if ( __POSIX_KERNEL__ != 0)
    else
    {
        interrupt_thread_notify(number,false);
    }
#   endif
    return ret;
#endif
}




#if ( INTERRUPTS_ISR_MAX      > 1 )

static  bool isr_register_handler (interrupt_t* entry , interrupt_handler_t handler,void*context)
{
    isr_t       *isrptr;
    bool         ret  = false;
    int          i;

    if ( handler == NULL )  return false;

    for (i=0;i<INTERRUPTS_ISR_MAX;i++)
    {
            if ( entry->isr_handlers[i].handler == NULL )
            {
                    break;
            }
    }
    if ( i == INTERRUPTS_ISR_MAX)
    {
            return false;
    }

    isrptr                  = &entry->isr_handlers[i];
    isrptr->queue           = entry->head ;
    entry->head             = isrptr;
    INSTALL_HANDLER( isrptr, handler, context );

    return true;

}

static  bool isr_deregister_handler(interrupt_t* entry, interrupt_handler_t handler,void*context )
{
    isr_t            *isrptr,*isrfound = NULL;
    int              i=0;

    if ( entry->head == NULL )
    {
            return false;
    }

    if ( (entry->head->handler == handler) & (entry->head->context == context) )
    {
           isrfound        = entry->head;
           entry->head     = entry->head->queue;
    }
    else
    {
           for (isrptr = entry->head; isrptr->queue != NULL;isrptr=isrptr->queue)
           {
                   if ( ( isrptr->queue->handler == handler )& (entry->head->context == context) )
                   {
                           isrfound = isrptr->queue;
                           isrptr   = isrptr->queue->queue;
                           break;
                   }
           }
    }

    if ( isrfound == NULL )
    {
           return false;
    }

    DEINSTALL_HANDLER( isrptr );

    return true;
}


static bool  isr_associate_thread( interrupt_t  *entry, interrupt_handler_t handler,
                   void* context, posix_thread_t  * thread )
{
    bool     ret   = true;
    uint32_t count = entry->isr_count;
    int      i;
    isr_t    *isrptr;

    if ( count == 0 || count >= INTERRUPTS_ISR_MAX )
    {
        ret = false;
    }
    else if (count == 1)
    {
        if ( (entry->handler != handler) || (entry->context != context) )
        {
            ret = false;
        }
        else
        {
        entry->thread   = thread;
        }
    }
    else if (count > 1)
    {
        for ( i=0; i<INTERRUPTS_ISR_MAX; i++ )
        {
            isrptr = &entry->isr_handlers[i];
            if ( (isrptr->handler == handler) && (isrptr->context == context) )
        {
            isrptr->thread               = thread;
                break;
        }
        }
        if ( i == INTERRUPTS_ISR_MAX )
        {
            ret = false;
        }
    }

    return ret;

}


static  uint32_t isr_common_handler   ( uint32_t number, void * context)
{
    isr_t*               isrptr = interrupt_table[number].head;
    uint32_t             result;
#if ( __POSIX_KERNEL__ != 0 )
    posix_thread_t*       th;
#endif
        while (isrptr != NULL)
        {
            result = isrptr->handler(number, isrptr->context);

#if ( __POSIX_KERNEL__ != 0 )

            if ( result & INTERRUPT_NOTIFY )
            {
                th              = (posix_thread_t*)isrptr->thread;
                if ( th == NULL ) continue;
                th->intr_notify = 1;
                if ( th->intr_wait )
                {   
                     posix_thread_ready(th, POSIX_WAKE_TIMEDINTR);
                }
            }

#endif
            if ( result & INTERRUPT_HANDLED )
            {
                break;
            }

            isrptr=isrptr->queue;
        }
    return 0;
}

#endif  //  ( INTERRUPTS_ISR_MAX      > 1 )

#if ( __POSIX_KERNEL__ != 0 )


/**
 * @brief
 *      associates the given user-written ISR intr_handler with a given interrupt line
 *
 *      After executing the posix_intr_associate() function, the issuing thread shall
 *      become connected to the given interrupt. (If ISR_MAX > 1 ) the system shall call
 *      the handlers in the reverse order that the ISRs were registered until one of
 *      the handlers returns a code signifying that the interrupt has been handled. 
 *      The argument context identifies a communication region where the handler 
 *      and the thread shall be able to exchange data. When the handler is called, 
 *      it shall receive the address of the communication region as its first argument. 
 *      The return code which is returned by the ISR determines whether the interrupt 
 *      has been handled by this ISR, and whether the thread that registered the handler 
 *      should be notified of the successful handling of this interrupt.
 *      An interrupt handler wakes up a thread by posting one of the notify return codes, 
 *      which causes a thread waiting in a corresponding posix_intr_timedwait() to unblock. 
 *      No other ISR-to-thread notification mechanism is specified.
 *
 * @param number
 *      interrupt number
 * @param handler
 *      standard handler
 * @param context
 *      standard handler context 
 * @return
 *      0 upon success; otherwise an error code
 */
extern int  pthread_interrupt_associate ( uint32_t number, interrupt_handler_t handler, void* context )
{
    int        ret = 0;
    interrupt_t     *entry = &interrupt_table[number];
    posix_thread_t  *self  = posix_self_thread();

    if ( (number >= PAL_ARCH_MAXINTRS) ||  (handler==NULL)  )
    {
        return  EINVAL;
    }

    if ( ( posix_interrupts_bitmask & ( 1 << number ) ) == 0 )
    {
        return  EINVAL;
    }


#if ( INTERRUPTS_ISR_MAX      > 1 )

    ret = isr_associate_thread(entry,handler,context,self );

#else

    if ( (entry->handler != handler) || (entry->context != context) )
    {
        ret = -1;
    }
    else
    {
    entry->thread           = self;
    }
#endif

    if ( ret )
    {
        self->intr_notify       = 0;
    }

    return ret;

}

/**
 * @brief
 *      cancels any existing association between the interrupt line and the ISR interrupt_handler.
 *
 * @param number
 *      interrupt number
 * @param handler
 *      standard handler
 * @param context
 *      standard handler context 
 * @return
 *      0 upon success; otherwise an error code
 */
extern int  pthread_interrupt_disassociate   ( uint32_t number, interrupt_handler_t handler,  void* context )
{
    int        ret = 0;
    interrupt_t     *entry = &interrupt_table[number];
    posix_thread_t  *self  = posix_self_thread();

    if ( (number >= PAL_ARCH_MAXINTRS) ||  (handler==NULL)  )
    {
        return  EINVAL;
    }

    if ( ( posix_interrupts_bitmask & ( 1 << number ) ) == 0 )
    {
        return  EINVAL;
    }

#if ( INTERRUPTS_ISR_MAX      > 1 )

    ret = isr_associate_thread( entry, handler, context, NULL );

#else

    if ( (entry->handler != handler) || (entry->context != context) )
    {
        ret = -1;
    }
    else
    {
    entry->thread   = NULL;
    }


#endif


    return ret;

}

/**
 * @brief
 *      causes the calling thread to block until notified that an interrupt has occurred
 *
 *      If an interrupt notification was delivered to the calling thread prior to the 
 *      call to the posix_intr_timedwait() function, and this notification has not previously
 *      caused a call to the posix_intr_timedwait() function to be unblocked, then
 *      the calling thread is not blocked and instead the posix_intr_timedwait()
 *      function returns immediately.
 *      If the value of the timeout input argument is non-null, the wait for an 
 *      interrupt to occur shall be terminated when the specified timeout period expires.
 *      If the timeout input argument is null, the wait is terminated only by the
 *      interrupt.
 *      The timeout expires after the interval specified by timeout has elapsed since
 *      the wait began. 
 *      Under no circumstance will the function fail with a timeout if the interrupt
 *      notification occurred prior to the posix_intr_timedwait() call.
 *
 * @param timeout
 *      pointer to read-only timespec tiemout variable
 * @return
 *      0 upon success; otherwise an error code
 */
extern int  pthread_interrupt_timedwait      ( const struct timespec* timeout )
{
        posix_thread_t*         self = posix_self_thread();
#if ( __POSIX_TIMEOUTS != 0 )
        clock_t                 ticks = 0;
        posix_timer_t           timer;
        int                     oldcanceltype = 0;
#endif
        int                     err = 0,i=0;

        posix_scheduler_lock();

        posix_interrupts_disable();

        if (!self->intr_notify)
        {
                self->intr_wait = 1;

                posix_thread_reset_rc();

                posix_interrupts_enable();

#if ( __POSIX_TIMEOUTS != 0 )
                if (timeout!=NULL)
                {
                        if( !posix_valid_timespec( timeout ) )
                        {
                                posix_scheduler_unlock();
                                return EINVAL;
                        }

                        posix_timer_init(       &timer, 
                                                CLOCK_REALTIME, 
                                                POSIX_TIMER_TIMEOUT );  

                        if ((ticks = posix_timespec_to_ticks( timer.clock,timeout )))
                        {
                                if (posix_set_timer(ticks,&timer,false)!=0)
                                {
                                        /* time has elapsed */
                                        posix_scheduler_unlock();
                                        return 0;
                                }
                                oldcanceltype = self->canceltype;
                                self->canceltype = PTHREAD_CANCEL_DEFERRED;
                        }
                }
#endif

                posix_thread_wait();

                /* scheduler locked */
#               if ( __POSIX_TIMEOUTS != 0 )               
                if (ticks)
                {
                        if (self->wake_reason == POSIX_WAKE_TIMEOUT)
                        {
                                err = ETIMEDOUT;
                        }
                        else
                        {
                                /* thread has been awaken but not due to
                                * a delay reason but due to a signal
                                * or cancellation or _WAKE_TIMEDINTR */
                                posix_timer_rm(&timer);
                        }
                        
                        self->canceltype = oldcanceltype;
                }
#               endif
                
                if (self->wake_reason == POSIX_WAKE_SIGNAL)
                {
                        err = EINTR;
                }
                /* else : _WAKE_TIMEDINTR */
        }
        else
        {
                posix_interrupts_enable();
        }
        
        self->intr_notify = 0;

        posix_scheduler_unlock();
        
        pthread_testcancel();

        return err;
}

#endif // #if ( __POSIX_KERNEL__ != 0 )


void interrupts_common_handler(uint32_t number)
{
    interrupt_t *entry = &interrupt_table[number];

#   if ( __POSIX_KERNEL__ ) && ( INTERRUPTS_ISR_MAX == 1 )
    posix_thread_t * th;
    uint32_t result =
#   endif
            entry->handler( number, entry->context );

#   if ( INTERRUPTS_ISR_MAX > 1 )
    if ( entry->isr_count > 1 ) return;
#   endif

#   if ( __POSIX_KERNEL__ ) && ( INTERRUPTS_ISR_MAX == 1 )
    if ( result & INTERRUPT_NOTIFY )
    {
        th              = (posix_thread_t*) entry->thread;
        if ( th == NULL ) return;
        th->intr_notify = 1;
        if ( th->intr_wait )
        {
            posix_thread_ready(th, POSIX_WAKE_TIMEDINTR);
        }
    }
#endif

    return;
}


#if ( __POSIX_KERNEL__ != 0 )

void posix_interrupts_handler(uint32_t number)
{
     _posix_sched_lock++;

    #if ( POSIX_THREADS_DEBUG != 0 )
     if( _posix_current_thread != NULL )
     {
        _posix_current_thread->ra      = _posix_resume_address;
        _posix_current_thread->spuser  = _posix_user_stack;
     }
    #endif

    interrupts_common_handler( number );

    #if ( __POSIX_THREAD_CPUTIME != 0 )
    posix_cpuclock_update();
    #endif

     if( _posix_current_thread != NULL )
     {
        posix_interrupt_schedule_point();
     }

    return;
}

#endif



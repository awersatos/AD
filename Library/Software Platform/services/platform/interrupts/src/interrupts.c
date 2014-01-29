/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2010, Altium
|*
|*  Description:    interrupt services
|*
\********************************************************************/

#include <stddef.h>
#include <assert.h>

#include <pal.h>
#include <interrupts.h>

#if  ( __POSIX_KERNEL__ != 0 )
#include <errno.h>
#include "posix_pthread.h"
#include "posix_time.h"
#include "kernel.h"
#include "k_schedule.h"
#endif

#include "interrupts_cfg.h"

#define INSTALL_HANDLER(e,h,c)    e->handler = h; e->context = c;
#define DEINSTALL_HANDLER(e )     e->handler = NULL; e->context = NULL;

#if ( INTERRUPTS_ISR_MAX > 1 )
static uint32_t multiple_isr_common_handler(uint32_t number, void * context);
static bool     multiple_isr_already_registered(interrupt_t* entry, interrupt_handler_t handler, void*context);
static bool     multiple_isr_register_handler(interrupt_t* entry, interrupt_handler_t handler, void*context);
static bool     multiple_isr_deregister_handler(interrupt_t* entry, interrupt_handler_t handler, void*context);
# if  ( __POSIX_KERNEL__ != 0 )
static bool     multiple_isr_associate_thread(interrupt_t *entry, interrupt_handler_t handler,
                                              void* context, posix_thread_t  * thread );
# endif
#endif

// global interrupt context table
interrupt_t  interrupt_table[PAL_ARCH_MAXINTRS];

#if  ( __POSIX_KERNEL__ != 0 )
uint32_t     posix_interrupts_bitmask = 0;
#endif


/* Private API */

#if ( __POSIX_KERNEL__ != 0 )
static inline void interrupts_notify_thread(posix_thread_t *th)
{
    if (th != NULL)
    {
        th->intr_notify = 1;
        if ( th->intr_wait )
        {
             posix_thread_ready(th, POSIX_WAKE_TIMEDINTR);
        }
    }
}
#endif

#if ( INTERRUPTS_ISR_MAX > 1 )

// check if handler is already installed
static bool multiple_isr_already_registered(interrupt_t* entry, interrupt_handler_t handler, void*context)
{
    isr_t * restrict isr;

    if (entry->handler == handler && entry->context == context)
    {
        return true;
    }

    for (isr = entry->head; isr != NULL; isr = isr->queue)
    {
        if (isr->handler == handler && isr->context == context)
        {
            return true;
        }
    }

    return false;
}

// add handler
static bool multiple_isr_register_handler(interrupt_t* entry , interrupt_handler_t handler, void*context)
{
    isr_t * isr;
    int i;

    if ( handler == NULL ) return false;

    for (i=0; i<INTERRUPTS_ISR_MAX; i++)
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

    isr = &entry->isr_handlers[i];
    INSTALL_HANDLER( isr, handler, context );

    isr->queue  = entry->head ;
    entry->head = isr;

    return true;
}

// remove handler
static bool multiple_isr_deregister_handler(interrupt_t* entry, interrupt_handler_t handler,void*context)
{
    isr_t *isr;
    isr_t *prev;

    for (isr = entry->head, prev = NULL; isr != NULL; prev = isr, isr = isr->queue)
    {
        if (isr->handler == handler && isr->context == context)
        {
            if (prev != NULL)
            {
                prev->queue = isr->queue;
            }
            else
            {
                entry->head = isr->queue;
            }
            DEINSTALL_HANDLER(isr);
            return true;
        }
    }

    return false;
}

#if  ( __POSIX_KERNEL__ != 0 )
// associate thread with specific handler
static bool multiple_isr_associate_thread(interrupt_t  *entry, interrupt_handler_t handler,
                                          void* context, posix_thread_t *thread)
{
    isr_t *isr;

    for (isr = entry->head; isr != NULL; isr = isr->queue)
    {
        if ( (isr->handler == handler) && (isr->context == context) )
        {
            isr->thread = thread;
            return true;
        }
    }

    return false;
}
#endif

// service interrupt with multiple handlers
static uint32_t multiple_isr_common_handler(uint32_t number, void * context)
{
    interrupt_t * restrict entry = &interrupt_table[number];
    isr_t* isr;
    uint32_t result;

    for (isr = entry->head; isr != NULL; isr = isr->queue)
    {
        result = isr->handler(number, isr->context);

#if  ( __POSIX_KERNEL__ != 0 )
        if ( result & INTERRUPT_NOTIFY )
        {
            posix_thread_t* th = (posix_thread_t*)isr->thread;

            interrupts_notify_thread(th);
        }
#endif
        if ( result & INTERRUPT_HANDLED )
        {
            break;
        }
    }

    return 0;
}

#endif  //  ( INTERRUPTS_ISR_MAX > 1 )


/* Public API */

/**
 * @brief
 *      Register a native interrupt handler
 *
 * This function declares an interrupt line as native and installs its native
 * handler.  Native interrupt lines can only hold one handler which executes
 * immediately upon interrupt arrival, bypassing all framework activities.
 *
 * Native lines do not support sharing.  In multithreaded applications, threads
 * cannot block on native handlers.
 *
 * The @em handler function should be declared with the __INTERRUPT_NATIVE
 * macro.
 *
 * @param number
 *      Interrupt number
 * @param context
 *      Native handler context (normally private driver data)
 * @param handler
 *      Native handler
 *
 * @return  true if native handler was installed, false if handler could not be
 *          installed (incorrect value for number).
 */
extern bool interrupt_register_native(uint32_t number, void *context, interrupt_native_handler_t handler)
{
    if (number >= PAL_ARCH_MAXINTRS) return false;

    if (pal_architecture_set_native_handler(number, handler))
    {
        // no need to store the handler for native interrupts
        interrupt_table[number].context = context;
        return true;
    }
    return false;
}

/**
 * @brief
 *      Register a standard interrupt handler
 *
 * This function declares an interrupt line as standard and installs its
 * standard handler.  Standard lines can hold more than one handler (up to
 * ISR_MAX). Handlers for shared interrupt lines are called in the reverse
 * order that they were registered until one of the handlers returns a code
 * signifying that the interrupt has been handled.
 *
 * Standard handlers are not as fast as native handlers since they must execute
 * after some framework housekeeping activities.
 * In multithreaded applications, threads can block on standard handlers but
 * only when they are declared as posix interrupts (see interrupt_set_posix()).
 *
 * @param number
 *      Interrupt number
 * @param context
 *      Standard handler context (normally private driver data)
 * @param handler
 *      Standard handler
 *
 * @return true to indicate success, or false otherwise.
 */
extern bool interrupt_register (uint32_t number, void* context, interrupt_handler_t handler)
{
    interrupt_t *entry;
    entry = &interrupt_table[number];

    if (number >= PAL_ARCH_MAXINTRS) return false;

#if ( INTERRUPTS_ISR_MAX == 1 )

    INSTALL_HANDLER (entry, handler, context);
    return true;

#else /* ( INTERRUPTS_ISR_MAX > 1 ) */

    bool ret = true;
    uint32_t count;

    count = entry->isr_count;
    if ( count == 0 )
    {
        // directly install handler
        INSTALL_HANDLER (entry, handler, context);
        entry->isr_count = 1;
    }
    else if (!multiple_isr_already_registered(entry,handler,context))
    {
        if ( count >= INTERRUPTS_ISR_MAX )
        {
            // no space left
            ret = false;
        }
        else
        {
#if ( INTERRUPTS_ISR_MAX > 2 )
            if ( count == 1 )
#endif
            {
                // move currently installed handler to the queue
                multiple_isr_register_handler(entry,entry->handler,entry->context);
                // install common 'muli'-handler for the interrupt
                INSTALL_HANDLER (entry, multiple_isr_common_handler, NULL );
            }

            // add handler to the queue
            if( ! multiple_isr_register_handler(entry,handler,context) )
            {
                ret = false;
            }
            else
            {
                entry->isr_count++;
            }
        }
    }
    return ret;

#endif /* ( INTERRUPTS_ISR_MAX > 1 ) */
}

/**
 * @brief
 *      Deregister a standard interrupt handler
 *
 * This function de-registers a standard interrupt handler for the specified
 * interrupt line.
 *
 * @param number
 *      Interrupt number
 * @param context
 *      Standard handler context (normally private driver data)
 * @param handler
 *      Standard handler
 *
 * @return true to indicate success, or false otherwise.
 */
extern bool interrupt_deregister     (uint32_t number, void* context, interrupt_handler_t handler)
{
    interrupt_t *entry;
    if (number >= PAL_ARCH_MAXINTRS) return false;
    entry = &interrupt_table[number];

#if ( INTERRUPTS_ISR_MAX == 1 )

    DEINSTALL_HANDLER (entry);
    return true;

#else
    bool ret = true;

    if ( entry->isr_count == 0 )
    {
        return false;
    }

    if ( entry->isr_count == 1 )
    {
        // first handler is installed directly
        DEINSTALL_HANDLER (entry);
        entry->isr_count = 0;
    }
    else
    {
        // remove from queue
        ret = multiple_isr_deregister_handler(entry, handler, context);
        if (ret)
        {
            entry->isr_count--;

            if ( entry->isr_count == 1 ) // 1 handler remaining
            {
                interrupt_handler_t ahandler = entry->head->handler;
                void *acontext               = entry->head->context;
                // remove last remaining handler from the queue...
                if ( multiple_isr_deregister_handler( entry, ahandler, acontext ) )
                {
                    // ... and install it as main handler instead of the common 'multi'-handler
                    INSTALL_HANDLER (entry, ahandler, acontext);
                }
            }
        }
    }

    return ret;

#endif
}

/**
 * @brief
 *      Configure interrupt type
 *
 * This function sets the interrupt type for a given interrupt. It should be
 * used by drivers during initialization to configure the interrupt in the
 * controller.
 *
 * @param number
 *      Interrupt number
 * @param cfg
 *      Interrupt type
 *
 * @return true to indicate success, or false otherwise.
 */
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

#if  ( __POSIX_KERNEL__ != 0 )
/**
 * @brief
 *      Configure a posix interrupt
 *
 * This function declares a standard interrupt line as a posix interrupt.  With
 * posix interrupts, threads can be associated with registered handlers using
 * pthread_interrupt_associate().  Threads can block waiting for interrupt
 * synchronization using pthread_interrupt_timedwait().
 *
 * @param number
 *      Interrupt number
 * @param posix
 *      True to set a posix interrupt
 *
 * @return true to indicate success, or false otherwise.
 */
extern bool interrupt_set_posix(uint32_t number, bool posix)
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

/**
 * @brief
 *      Associate current thread with an interrupt handler
 *
 * This function associates the current thread with the specified interrupt
 * handler for the specified interrupt.  The thread can block, waiting for
 * notification, by calling pthread_interrupt_timedwait().  The handler can
 * cause the thread to be notified by including the INTERRUPT_NOTIFY flag in
 * its return value.  Only one thread can be associated with a handler at the
 * same time.
 *
 * The @em handler and @em context paramaters should match the ones given to the
 * corresponding interrupt_register() call of the handler.
 *
 * @param number
 *      interrupt number
 * @param handler
 *      standard handler
 * @param context
 *      standard handler context
 *
 * @return 0 if successful, or an error code otherwise.
 *
 * @see
 *      pthread_interrupt_disassociate()
 */
extern int  pthread_interrupt_associate ( uint32_t number, interrupt_handler_t handler, void* context )
{
    int ret = -1;
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

    // isr_count == 1
    if ( (entry->handler == handler) && (entry->context == context) )
    {
        entry->thread = self;
        ret = 0;
    }
#if ( INTERRUPTS_ISR_MAX > 1 )
    else // isr_count == 0 || isr_count > 1
    {
        ret = multiple_isr_associate_thread(entry,handler,context,self );
    }
#endif

    if ( ret )
    {
        self->intr_notify = 0;
    }

    return ret;
}

/**
 * @brief
 *      Disassociate thread from interrupt handler
 *
 * This function cancels any existing association between the interrupt line and
 * the specified interrupt handler.
 *
 * The @em handler and @em context paramaters should match the ones given to the
 * corresponding interrupt_register() call.
 *
 * @param number
 *      interrupt number
 * @param handler
 *      standard handler
 * @param context
 *      standard handler context
 *
 * @return 0 if successful, or an error code otherwise.
 *
 * @see
 *      pthread_interrupt_associate()
 */
extern int  pthread_interrupt_disassociate   ( uint32_t number, interrupt_handler_t handler,  void* context )
{
    int ret = -1;
    interrupt_t *entry = &interrupt_table[number];
    posix_thread_t *self = posix_self_thread();

    if ( (number >= PAL_ARCH_MAXINTRS) || (handler==NULL) )
    {
        return  EINVAL;
    }

    if ( ( posix_interrupts_bitmask & ( 1 << number ) ) == 0 )
    {
        return  EINVAL;
    }

    // isr_count == 1
    if ( (entry->handler == handler) && (entry->context == context) )
    {
        entry->thread = NULL;
        ret = 0;
    }
#if ( INTERRUPTS_ISR_MAX > 1 )
    else // isr_count == 0 || isr_count > 1
    {
        ret = multiple_isr_associate_thread( entry, handler, context, NULL );
    }
#endif

    return ret;
}

/**
 * @brief
 *      Block current thread waiting for interrupt notification
 *
 * This function causes the calling thread to block until notified by an
 * interrupt handler (see pthread_interrupt_associate()) or when an optional
 * timeout was reached.
 *
 * If an interrupt notification was delivered to the calling thread prior to the
 * call to the pthread_interrupt_timedwait() function, and this notification has
 * not previously caused a call to the pthread_interrupt_timedwait() function to
 * be unblocked, then the calling thread is not blocked and instead the
 * pthread_interrupt_timedwait() function returns immediately.
 *
 * Under no circumstance will the function fail with a timeout if the interrupt
 * notification occurred prior to the pthread_interrupt_timedwait() call.
 *
 * @param timeout
 *      pointer to read-only timespec variable or NULL
 *
 * @return 0 if successful, or an error code otherwis.
 */
extern int  pthread_interrupt_timedwait      ( const struct timespec* timeout )
{
    posix_thread_t* self = posix_self_thread();
#if ( __POSIX_TIMEOUTS != 0 )
    clock_t ticks = 0;
    posix_timer_t timer;
    int oldcanceltype = 0;
#endif
    int err = 0;
    int i = 0;

    posix_scheduler_lock();
    posix_interrupts_disable();

    if (self->intr_notify)
    {
        // already notified
        posix_interrupts_enable();
    }
    else
    {
        self->intr_wait = 1;
        posix_thread_reset_rc();

        posix_interrupts_enable();

#if ( __POSIX_TIMEOUTS != 0 )
        if (timeout != NULL)
        {
            if( !posix_valid_timespec( timeout ) )
            {
                posix_scheduler_unlock();
                return EINVAL;
            }

            posix_timer_init(&timer, CLOCK_REALTIME, POSIX_TIMER_TIMEOUT);

            if ((ticks = posix_timespec_to_ticks( timer.clock,timeout )))
            {
                if (posix_set_timer(ticks,&timer,false) != 0)
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

        // block thread
        posix_thread_wait();

        /* scheduler locked */
#if ( __POSIX_TIMEOUTS != 0 )
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
#endif

        if (self->wake_reason == POSIX_WAKE_SIGNAL)
        {
            err = EINTR;
        }
        /* else : _WAKE_TIMEDINTR */
    }

    // we're done
    self->intr_notify = 0;

    posix_scheduler_unlock();
    pthread_testcancel();

    return err;
}

#endif /* ( __POSIX_KERNEL__ != 0 ) */


/*
 * Common interrupt handlers for the software platform framework
 *
 * NOTE: These handlers are used from architecture specific 'pal'
 *       implementations.  These plugins can be found in the
 *       platform/fpga/processors/ folder.
 */

// non-posix handler
void interrupts_common_handler(uint32_t number)
{
    interrupt_t *entry = &interrupt_table[number];

#if ( __POSIX_KERNEL__ != 0 )
    uint32_t result = entry->handler(number, entry->context);
#else
    entry->handler(number, entry->context);
#endif

#if ( INTERRUPTS_ISR_MAX > 1 )
    if ( entry->isr_count != 1 )
    {
        // either no handler registered or
        // everything already handled by common 'multi'-handler
        return;
    }
#endif

#if ( __POSIX_KERNEL__ != 0 )
    if ( result & INTERRUPT_NOTIFY )
    {
        posix_thread_t * th = (posix_thread_t*) entry->thread;

        interrupts_notify_thread(th);
    }
#endif

    return;
}

#if ( __POSIX_KERNEL__ != 0 )

// posix handler
void posix_interrupts_handler(uint32_t number)
{
    // run with the scheduler locked
    _posix_sched_lock++;

#if POSIX_THREADS_DEBUG
    if( _posix_current_thread != NULL )
    {
        _posix_current_thread->ra     = _posix_resume_address;
        _posix_current_thread->spuser = _posix_user_stack;
    }
#endif

    // handle the interrupt
    interrupts_common_handler( number );

#if __POSIX_THREAD_CPUTIME
    posix_cpuclock_update();
#endif


    if( _posix_current_thread != NULL )
    {
        // this will decrease _posix_sched_lock
        posix_interrupt_schedule_point();
    }
    else
    {
        _posix_sched_lock--;
    }

    return;
}

#endif /* ( __POSIX_KERNEL__ != 0 ) */

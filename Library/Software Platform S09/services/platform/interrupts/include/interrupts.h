/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007, Altium
|*
|*  Description:        Timing services
|*
\*****************************************************************************/

/**
 * @file
 * Interrupt services
 *
 * These system utilities provide standard services to disable, enable, mask, 
 * configure, acknowledge etc.. interrupts. Plus extra mechanisms to register/associate 
 * native, standard and kernel isr handlers to interrupts.
 * 
 * These utilities are mostly used by interrupt-driven driver software. 
 *
 */

#ifndef _H_INTERRUPTS
#define _H_INTERRUPTS

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdbool.h>
#include <stdint.h>
#include <pal_arch.h>
#include "interrupts_cfg.h"

/* macros to support nesting native interrupts */

/**
 * @brief
 *      This macro functions as a keyword to declare an interrupt handler as native
 *
 */
#define __INTERRUPT_NATIVE          PAL_ARCH_INTERRUPT_NATIVE

#if ( PAL_NATIVE_INTERRUPTS_SUPPORT > 0 )

#define INTERRUPT_NESTING_BEGIN(level)                                              \
    {                                                                               \
        uint32_t oldmask = pal_architecture_interrupts_mask_levels_below(level);    \
        pal_architecture_interrupts_enable();

# define INTERRUPT_NESTING_END()                                    \
        pal_architecture_interrupts_disable();                      \
        pal_architecture_interrupts_set_mask(oldmask);              \
    }

#else

#define INTERRUPT_NESTING_BEGIN(level)
#define INTERRUPT_NESTING_END()

#endif

/**
 * @brief
 *      enables globally all maskable interrupts
 *
 * @return none
 *
 */
inline void interrupts_enable(void)
{
    pal_architecture_interrupts_enable();
}

/**
 * @brief
 *      disables globally all maskable interrupts
 *
 *      Executing with interrupts disabled might have an effect on the overall response
 *      of the system (real-time latency). They should be disabled only for extremely
 *      short periods of time
 *
 * @return none
 *
 */
inline void interrupts_disable(void)
{
    pal_architecture_interrupts_disable();
}

/**
 * @brief
 *      enables a given maskable interrupt
 *
 * @param number
 *      interrupt number
 *
 * @return none
 *
 */
inline void interrupt_enable(uint32_t number)
{
    pal_architecture_interrupt_enable(number);
}

/**
 * @brief
 *      disables a given maskable interrupt
 *
 *      Normally used by system drivers to avoid race conditions between
 *      interrupts and application code.
 *      
 * @param number
 *      interrupt number
 *
 * @return none
 *
 */
inline void interrupt_disable(uint32_t number)
{
    pal_architecture_interrupt_disable(number);
}

/**
 * @brief
 *      enables a set of maskable interrupts
 *
 * @param mask
 *      interrupts set
 *
 * @return none
 *
 */
inline void interrupts_set_enable_mask(uint32_t mask)
{
    pal_architecture_interrupts_set_mask (mask);
}

/**
 * @brief
 *      gets the current set of enabled interrupts
 *
 * @return 
 *      set of enabled interrupts 
 *
 */
inline uint32_t interrupts_get_enable_mask(void)
{
    return pal_architecture_interrupts_get_mask();
}



/**
 * @brief
 *      disables all interrupts below a certain priority level
 *
 *      Regardless of the level, the clock interrupt and the posix
 *      interrupts (if multi-threaded) will also be disabled.
 *
 * @param level
 *      interrupt priority level below which to disable all interrupts
 *
 * @return 
 *      old set of enabled interrupts 
 *
 */
inline uint32_t interrupts_mask_levels_below(uint32_t level)
{
    return pal_architecture_interrupts_mask_levels_below(level);
}


/**
 * @brief
 *      acknowledges a given interrupt
 *
 *      Mainly used in driver's interrupt handlers to acknowledge receipt of
 *      a given interrupts. 
 *
 * @param number
 *      interrupt number
 *
 * @return none
 *
 */
inline void interrupt_acknowledge(uint32_t number)
{
    pal_architecture_interrupt_acknowledge(number);
}

/* software configure interrupt number */

/**
 * @brief
 *      interrupt configure type
 *
 * Interrupt configure type
 *
 */
typedef enum
{
    EDGE_RISING,    /**< Interrupt on rising edge */
    EDGE_FALLING,   /**< Interrupt on falling edge */
    LEVEL_HIGH,     /**< Interrupt on high level */
    LEVEL_LOW       /**< Interrupt on low level */
} interrupt_cfg_t;

/**
 * @brief
 *      configures a given interrupt
 *
 *      Mainly used in driver's initialization to configure the interrupt
 *      in the controller.
 *
 * @param number
 *      interrupt number
 * @param cfg
 *      interrupt configuration
 * @return
 *      true to indicate success, otherwise false
 *
 */
extern bool interrupt_configure( uint32_t number, interrupt_cfg_t cfg );

/**
 * @brief
 *      native interrupt handler prototype
 *
 */
typedef     void     (*interrupt_native_handler_t)  ( void );


/**
 * @brief
 *      registers a native interrupt handler
 *
 *      Declares an interrupt line as native and install its native handler.
 *      Native interrupt lines hold only one handler which executes directly upon
 *      interrupt arrival bypassing all framework activities.
 *      Drivers use these lines for extremely fast interrupt serving.
 *
 *      Native lines do not support sharing.
 *      In multithreading applications, threads cannot block on native handlers.
 *
 * @param number
 *      interrupt number
 * @param context
 *      native handler context (normally private driver data)
 * @param handler
 *      native handler
 *
 *
 * @return  true        native handler installed
 *          false       handler could not be installed (incorrect value for number)
 *
 */
extern bool interrupt_register_native( uint32_t number, void* context, interrupt_native_handler_t handler );

/**
 * @name Interrupt handler return values
 */
/** @{ */
#define INTERRUPT_NOT_HANDLED                   1   /**< Interrupt has not been handled  */
#define INTERRUPT_HANDLED                       2   /**< Interrupt has been handled  */
#define INTERRUPT_NOTIFY                        4   /**< Notify to awake associated waiting thread  */
/** @} */

typedef     uint32_t (*interrupt_handler_t)         ( uint32_t number, void * context );

/**
 * @brief
 *      registers a standard interrupt handler
 *
 *      Declares an interrupt line as standard and installs its standard handler.
 *      Standard lines do support sharing since they can hold more than one 
 *      handlers ( up to ISR_MAX ). They are called in registration order. 
 *      Standard handlers are not as fast as native handlers since they must execute 
 *      after some framework's housekeeping activities.
 *      In multithreading applications, threads can block on standard handlers but only
 *      when they are declared as standard posix interrupts.
 *       
 *
 * @param number
 *      interrupt number
 * @param context
 *      standard handler context (normally private driver data)
 * @param handler
 *      standard handler
 * @return
 *      true to indicate success, otherwise false
 *
 */
extern bool interrupt_register       ( uint32_t number, void* context, interrupt_handler_t handler);

/**
 * @brief
 *      de-registers a standard interrupt handler for a given interrupt
 *
 * @param number
 *      interrupt number
 * @param context
 *      standard handler context (normally private driver data)
 * @param handler
 *      standard handler
 * @return
 *      true to indicate success, otherwise false
 */
extern bool interrupt_deregister     ( uint32_t number, void* context, interrupt_handler_t handler);

#if ( __POSIX_KERNEL__ != 0 )

/**
 * @brief
 *      declares a standard interrupt line as a posix interrupt
 *
 *      In posix interrupts, threads can be associated with standard registered handlers
 *      with the pthread_interrupt_associate system call.
 *      Threads can block waiting for interrupt synchronization with the
 *      pthread_interrupt_timedwait system call.
 *
 * @param number
 *      interrupt number
 * @param posix
 *      true to set a posix interrupt
 * @return
 *      true to indicate success, otherwise false
 *      
 */
extern bool interrupt_set_posix     ( uint32_t number, bool posix );

#endif


#if ( __POSIX_KERNEL__ != 0 )
extern uint32_t         posix_interrupts_bitmask;
extern int              _posix_irq_level;

/**
 * @brief
 *      disables all posix interrups in the system
 *
 *      With posix interrupts disabled, the system is prevented from
 *      unwanted context switches (scheduler is effectively locked).
 *      Non posix interrupts are still served.
 *
 *      The pair posix_interrupts_disable/enable pair does not support 
 *      nesting. They should always be called in balance, preferibly at the 
 *      same function level. 
 *
 *      Application code while posix interrupts are disabled should be fast 
 *      and should never use posix system calls.  
 *
 *
 * @return none
 *
 */
inline void     posix_interrupts_disable(void)
{
    if ( _posix_irq_level==0 )
    {
        pal_architecture_interrupts_disable();
        pal_architecture_posix_interrupts_disable();
        pal_architecture_interrupts_enable();
    }
}

/**
 * @brief
 *      enables all posix interrups in the system
 *
 *      reverse action of posix_interrupts_disable
 *
 * @return none
 *
 */
inline void     posix_interrupts_enable(void)
{
    if ( _posix_irq_level==0 )
    {
        pal_architecture_interrupts_disable();
        pal_architecture_posix_interrupts_enable();
        pal_architecture_interrupts_enable();
    }
}
#endif


#if ( INTERRUPTS_ISR_MAX      > 1 )
typedef struct isr_s isr_t;
struct isr_s
{
    void*                   context;
    interrupt_handler_t     handler;
#if (__POSIX_KERNEL__ != 0)
    void*                   thread;
#endif
    isr_t*                  queue;
};
#endif

typedef struct interrupt_s  interrupt_t;

struct interrupt_s
{
    void                    *context;
    interrupt_handler_t     handler;
#if (__POSIX_KERNEL__ != 0)
    void*                   thread;
#endif
#if ( INTERRUPTS_ISR_MAX      > 1 )
    uint32_t                isr_count;
    isr_t                   isr_handlers[INTERRUPTS_ISR_MAX];
    isr_t*                  head;
#endif
};

extern interrupt_t  interrupt_table[];

/**
 * @brief
 *      returns the native interrupt context
 *
 * @param number
 *      interrupt native number
 * @return
 *      interrupt context
 *      
 */
inline void* interrupt_native_context(uint32_t number)
{
    return interrupt_table[number].context;
}

/**
 * @brief
 *      gets the current executing interrupt 
 *
 *      Usually called at driver's interrupt handler to find out which device
 *      triggered the interrupt. It is normally followed by a call to 
 *      interrupt_native_context(n) to get the device's context. 
 *
 * @return
 *      current executing interrupt
 *      
 */
inline uint32_t interrupt_get_current(void)
{
   return pal_architecture_current_interrupt();
}

#if ( __POSIX_KERNEL__ != 0 )

#include <time.h> 
extern int  pthread_interrupt_associate      ( uint32_t number, interrupt_handler_t, void* arg );
extern int  pthread_interrupt_disassociate   ( uint32_t number, interrupt_handler_t, void* arg );
extern int  pthread_interrupt_timedwait      ( const struct timespec* timeout );

#endif

#ifdef  __cplusplus
}
#endif

#endif

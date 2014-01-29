/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2010, Altium
|*
|*  Description:        Interrupt services
|*
\*****************************************************************************/

/**
 * @file
 *      Interrupt services
 *
 * These system utilities provide standard services to disable, enable, mask,
 * configure, acknowledge etc.. interrupts. Plus extra mechanisms to
 * register/associate native, standard and kernel interrupt handlers to
 * interrupts.
 *
 * These utilities are mostly used by interrupt-driven driver software in the
 * Software Platform.
 */

#ifndef _INTERRUPTS_H
#define _INTERRUPTS_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdbool.h>
#include <stdint.h>

#if ( __POSIX_KERNEL__ != 0 )
# include <time.h>
#endif

#include <pal_arch.h>           // processor specific implementations
#include "interrupts_cfg.h"     // SwPlatform interrupt service configuration


/* Macro definitions */

/** Define native interrupt handler. See interrupt_register_native().
 *  For example: <code>__INTERRUPT_NATIVE void my_handler(void)</code>
 */
#define __INTERRUPT_NATIVE              PAL_ARCH_INTERRUPT_NATIVE

#if PAL_NATIVE_INTERRUPTS_SUPPORT

/** Enable interrupt nesting. Must match associated INTERRUPT_NESTING_END(). */
#define INTERRUPT_NESTING_BEGIN(level)                                              \
    {                                                                               \
        uint32_t oldmask = pal_architecture_interrupts_mask_levels_below(level);    \
        pal_architecture_interrupts_enable();

/** End interrupt nesting. Must match associated INTERRUPT_NESTING_BEGIN(). */
# define INTERRUPT_NESTING_END()                                                    \
        pal_architecture_interrupts_disable();                                      \
        pal_architecture_interrupts_set_mask(oldmask);                              \
    }

#else // no support for interrupt nesting

#define INTERRUPT_NESTING_BEGIN(level)
#define INTERRUPT_NESTING_END()

#endif /* PAL_NATIVE_INTERRUPTS_SUPPORT */

// standard interrupt handler return values
#define INTERRUPT_NOT_HANDLED           1   /**< Interrupt has not been handled  */
#define INTERRUPT_HANDLED               2   /**< Interrupt has been handled  */
#define INTERRUPT_NOTIFY                4   /**< Notify to awake associated waiting thread  */


/* Type definitions */

/** Flags used to configure the interrupt type. */
typedef enum
{
    EDGE_RISING,    /**< Interrupt on rising edge */
    EDGE_FALLING,   /**< Interrupt on falling edge */
    LEVEL_HIGH,     /**< Interrupt on high level */
    LEVEL_LOW       /**< Interrupt on low level */
} interrupt_cfg_t;

/** Native interrupt handler prototype */
typedef void (*interrupt_native_handler_t)( void );

/** Standard interrupt handler prototype */
typedef uint32_t (*interrupt_handler_t)( uint32_t number, void * context );

#if ( INTERRUPTS_ISR_MAX > 1 )
/* shared interrupt handler context */
typedef struct isr_s isr_t;
struct isr_s
{
    void*                   context;
    interrupt_handler_t     handler;
#if ( __POSIX_KERNEL__ != 0 )
    void*                   thread;
#endif
    isr_t*                  queue;
};
#endif

/* interrupt context */
typedef struct interrupt_s  interrupt_t;

struct interrupt_s
{
    void                    *context;
    interrupt_handler_t     handler;
#if ( __POSIX_KERNEL__ != 0 )
    void*                   thread;
#endif
#if ( INTERRUPTS_ISR_MAX > 1 )
    uint32_t                isr_count;
    isr_t                   isr_handlers[INTERRUPTS_ISR_MAX];
    isr_t*                  head;
#endif
};


/* Prototypes */

inline void     interrupts_enable(void);
inline void     interrupts_disable(void);

inline void     interrupt_enable(uint32_t number);
inline void     interrupt_disable(uint32_t number);

inline void     interrupts_set_enable_mask(uint32_t mask);
inline uint32_t interrupts_get_enable_mask(void);
inline uint32_t interrupts_mask_levels_below(uint32_t level);

extern bool     interrupt_register_native(uint32_t number, void* context, interrupt_native_handler_t handler);
extern bool     interrupt_register(uint32_t number, void* context, interrupt_handler_t handler);
extern bool     interrupt_deregister(uint32_t number, void* context, interrupt_handler_t handler);
extern bool     interrupt_configure(uint32_t number, interrupt_cfg_t cfg);

inline void     interrupt_acknowledge(uint32_t number);
inline void*    interrupt_native_context(uint32_t number);
inline uint32_t interrupt_get_current(void);

#if ( __POSIX_KERNEL__ != 0 )
inline void     posix_interrupts_disable(void);
inline void     posix_interrupts_enable(void);

extern bool     interrupt_set_posix(uint32_t number, bool posix);

extern int      pthread_interrupt_associate(uint32_t number, interrupt_handler_t handler, void* context);
extern int      pthread_interrupt_disassociate(uint32_t number, interrupt_handler_t handler, void* context);
extern int      pthread_interrupt_timedwait(const struct timespec* timeout);
#endif /* ( __POSIX_KERNEL__ != 0 ) */


/* Global data */

/** global interrupt context table */
extern interrupt_t  interrupt_table[];

#if ( __POSIX_KERNEL__ != 0 )
extern uint32_t     posix_interrupts_bitmask;
extern int          _posix_irq_level; /* defined in services/posix/kernel/threads/src/k_schedule.c */
#endif


/* Inline function definitions */

/**
 * @brief
 *      Enable interrupt handling
 *
 * This function globally enables all maskable interrupts.
 *
 * @return Nothing
 *
 * @see
 *      interrupts_disable()
 */
inline void interrupts_enable(void)
{
    pal_architecture_interrupts_enable();
}

/**
 * @brief
 *      Disable interrupt handling
 *
 * This function globally disables all maskable interrupts.  Executing with
 * interrupts disabled might have an effect on the overall response of the
 * system (real-time latency); they should be disabled for extremely short
 * periods of time only.
 *
 * @return Nothing
 *
 * @see
 *      interrupts_enable()
 */
inline void interrupts_disable(void)
{
    pal_architecture_interrupts_disable();
}

/**
 * @brief
 *      Enables one interrupt
 *
 * This function enables the maskable interrupt specified by @em number.
 *
 * @param number
 *      interrupt number
 *
 * @return Nothing
 *
 * @see
 *      interrupt_disable()
 */
inline void interrupt_enable(uint32_t number)
{
    pal_architecture_interrupt_enable(number);
}

/**
 * @brief
 *      Disable one interrupt
 *
 * This function disables the maskable interrupt specified by @em number.  It
 * is used by system drivers to avoid race conditions between interrupts and
 * application code.
 *
 * @param number
 *      interrupt number
 *
 * @return Nothing
 *
 * @see
 *      interrupts_enable()
 */
inline void interrupt_disable(uint32_t number)
{
    pal_architecture_interrupt_disable(number);
}

/**
 * @brief
 *      Enable set of interrupts
 *
 * This function enables a set of maskable interrupts given by @em mask.
 *
 * @param mask
 *      Set of interrupts to enable
 *
 * @return Nothing
 */
inline void interrupts_set_enable_mask(uint32_t mask)
{
    pal_architecture_interrupts_set_mask (mask);
}

/**
 * @brief
 *      Get current enabled interrupts
 *
 * This function returns a mask with the currently enabled interrupts.
 *
 * @return Set of enabled interrupts.
 */
inline uint32_t interrupts_get_enable_mask(void)
{
    return pal_architecture_interrupts_get_mask();
}

/**
 * @brief
 *      Disable interrupts with lower priority
 *
 * This function disables all interrupts below a certain priority level given
 * by @em level.  On top of that, regardless of the level, the clock interrupt
 * and posix interrupts (if multi-threaded) will also be disabled.
 *
 * @param level
 *      Interrupt priority level below which to disable all interrupts
 *
 * @return Old set of enabled interrupts.
 */
inline uint32_t interrupts_mask_levels_below(uint32_t level)
{
    return pal_architecture_interrupts_mask_levels_below(level);
}

/**
 * @brief
 *      Acknowledge an interrupt
 *
 * This function should be used in interrupt handlers to acknowledge reception
 * of the specified interrupt.  It will clear the interrupt pending flag in the
 * interrupt controller and allow generation of a new interrupt.
 *
 * @param number
 *      Interrupt number
 *
 * @return Nothing
 */
inline void interrupt_acknowledge(uint32_t number)
{
    pal_architecture_interrupt_acknowledge(number);
}

/**
 * @brief
 *      Get native interrupt context
 *
 * This function returns the native interrupt context that was provided with
 * the interrupt_register_native() call.
 *
 * @param number
 *      Native interrupt number
 *
 * @return Native interrupt context.
 */
inline void* interrupt_native_context(uint32_t number)
{
    return interrupt_table[number].context;
}

/**
 * @brief
 *      Get current interrupt number
 *
 * This function retreives the number of the currently executing interrupt.
 * It can be used inside an interrupt handler to find out which device
 * triggered the interrupt.  It is normally followed by a call to
 * interrupt_native_context() to get the associated interrupt context.
 *
 * @return Currently executing interrupt.
 */
inline uint32_t interrupt_get_current(void)
{
   return pal_architecture_current_interrupt();
}

#if ( __POSIX_KERNEL__ != 0 )

/**
 * @brief
 *      Disable all posix interrupts
 *
 * This function disables all posix interrups in the system.  With posix
 * interrupts disabled, the system is protected against unwanted context
 * switches; the scheduler is effectively locked.  Non-posix interrupts are
 * still served.
 *
 * The functions posix_interrupts_disable()/posix_interrupts_enable() do not
 * support nesting.  They should always be called in combination, preferibly
 * at the same function level.
 *
 * Application code that runs while posix interrupts are disabled should be
 * fast and should never use posix system calls.
 *
 * @return Nothing
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
 *      Enable all posix interrupts
 *
 * This function enables all posix interrups in the system. It should
 * be called exactly once for each call to posix_interrupts_disable().
 * Nesting is not supported.
 *
 * @return Nothing
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

#endif /* ( __POSIX_KERNEL__ != 0 ) */

#ifdef  __cplusplus
}
#endif

#endif /* _INTERRUPTS_H */

/******************************************************************************\
|*
|*  PACKAGE:        PAL
|*
|*  DESCRIPTION:    Processor Abstraction Layer. Part of the Software Platform.
|*                  These interfaces are not meant to be used directly from
|*                  application code.
|*
|*  COPYRIGHT:      Copyright (c) 2009 Altium
|*
\******************************************************************************/
#ifndef _PAL_H
#define _PAL_H

#include <stdint.h>
#include <stdbool.h>
#include "pal_arch.h"
#include "framework_config_cfg.h"
#include "pal_cfg.h"
#include "timing_cfg.h"

#define __TIMERS__                  TIMING_USETIMERS
#define PAL_CLOCKHZ                 FRAMEWORK_CONFIG_CLOCKHZ

extern void             interrupts_common_handler (uint32_t);

#if ( (__TIMERS__ != 0) || (__POSIX_KERNEL__ !=0 ) )
#define pal_timer_interrupt_acknowledge             pal_architecture_timer_interrupt_acknowledge
#define pal_timer_interrupt_enable                  pal_architecture_timer_interrupt_enable
#define pal_timer_interrupt_disable                 pal_architecture_timer_interrupt_disable
#define pal_timer_interrupt_start                   pal_architecture_timer_interrupt_start
#define pal_timer_interrupt_stop                    pal_architecture_timer_interrupt_stop
#define pal_timer_interrupt_init                    pal_architecture_timer_interrupt_init
#endif

#if ( __POSIX_KERNEL__ != 0 )
extern int              pal_lsbit32_index(uint32_t val32);
extern int              pal_lsbit64_index(uint64_t val64);
extern int              pal_msbit32_index(uint32_t val32);
extern int              pal_msbit64_index(uint64_t val64);
#endif

#if  ( __TIMERS__ > 0 )
#define PAL_TIMERS_BASE              TIMING_BASE
#define PAL_MAXTIMERS                TIMING_MAX
typedef void (*pal_timer_handler_t) (void *);
extern bool  pal_timers_init (void );
extern void* pal_timer_register_handler   (void*, int64_t, pal_timer_handler_t);
extern bool  pal_timer_deregister_handler (void*);
extern void  pal_timers_common_handler    (void);
#endif

#if ( __POSIX_KERNEL__ != 0 )
extern int      _posix_irq_level;
extern int      _posix_sched_lock;
extern void     posix_clock_interrupt_handler( void );
extern void     posix_interrupts_handler (uint32_t);
#endif // ( __POSIX_KERNEL__ == 0 )

inline uint32_t pal_freq_hz( void ) { return (uint32_t) PAL_CLOCKHZ; }

extern uint64_t clock(void);
#define pal_clock   clock

inline uint64_t pal_clock_ns (void)
{
    return ( pal_clock() * (1000L*1000L*1000L) / PAL_CLOCKHZ );
}

inline uint64_t pal_clock_us (void)
{
    return ( pal_clock() * (1000L*1000L) / PAL_CLOCKHZ );
}

inline uint64_t pal_clock_ms (void)
{
    return ( pal_clock() * (1000L) / PAL_CLOCKHZ );
}

extern void     pal_delay_ns ( uint64_t ns );
extern void     pal_delay_us ( uint64_t us );
extern void     pal_delay_ms ( uint64_t ms );

#endif //_PAL_H

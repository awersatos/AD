#ifndef PAL_VIRTUAL_H
#define PAL_VIRTUAL_H

#include <lh79520.h>
#include "lh79520_vic.h"
#include "lh79520_rcpc.h"
#include "lh79520_iocon.h"
#include "lh79520_smc.h"

#include "timing_cfg.h"

#define PAL_VARIANT_CLOCK_INTNO                         20

inline void     pal_variant_interrupts_set_mask(uint32_t mask)
{
    VIC->intenable  =  mask;
    VIC->intenclear = ~mask;
}

inline uint32_t pal_variant_interrupts_get_mask(void)
{
    return (VIC->intenable);
}

inline void pal_variant_interrupt_enable(uint32_t num)
{
    pal_variant_interrupts_set_mask(  pal_variant_interrupts_get_mask() | ( 1<<num) );
}

inline void pal_variant_interrupt_disable(uint32_t num)
{
    pal_variant_interrupts_set_mask(  pal_variant_interrupts_get_mask() & ~(1<<num) );
}

inline void pal_variant_interrupt_acknowledge(uint32_t value)
{
     RCPC->intclear = (1<<value) ;
}

extern void     pal_variant_interrupt_configure( uint32_t number, bool edge, bool high );
extern uint32_t pal_variant_current_interrupt(void);
extern bool     pal_variant_clock_init(void);
extern bool     pal_variant_processor_init(void);
extern bool     pal_variant_interrupts_init (void);

#if ( TIMING_USETIMERS>0 ) || (__POSIX_KERNEL__ !=0)
extern bool     pal_variant_timer_interrupt_init(void);

inline void     pal_variant_timer_interrupt_enable(void)
{
    pal_variant_interrupt_enable(PAL_VARIANT_CLOCK_INTNO);
}

inline void     pal_variant_timer_interrupt_disable(void)
{
    pal_variant_interrupt_disable(PAL_VARIANT_CLOCK_INTNO);
}

inline void     pal_variant_timer_interrupt_acknowledge(void)
{
     RCPC->intclear = (1<<PAL_VARIANT_CLOCK_INTNO) ;
}

inline void     pal_variant_timer_interrupt_start(void)
{
    pal_variant_timer_interrupt_init();
    pal_variant_timer_interrupt_enable();
}
inline void     pal_variant_timer_interrupt_stop(void)
{
    pal_variant_timer_interrupt_disable();
    TIMER3->control &= ~( TMRCTRL_ENABLE | TMRCTRL_MODE_PERIODIC );  
}

#endif

extern void     pal_variant_irq_handler(void);

#endif


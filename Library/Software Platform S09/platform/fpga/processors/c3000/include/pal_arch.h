#ifndef _H_PAL_ARCH
#define _H_PAL_ARCH


#include <stdint.h>
#include <stdbool.h>
#include "pal_cfg.h"
#include "pal_arch_cfg.h"

#define PAL_ARCH_INTERNAL_NUMBER               0
#define PAL_ARCH_EXTERNAL_NUMBER               32
#define PAL_ARCH_MAXINTRS                      PAL_ARCH_EXTERNAL_NUMBER
#define PAL_ARCH_CLOCK_INTNO                   PAL_ARCH_3000_TIMER_INTERRUPT_NUMBER

#define PAL_ARCH_INTERRUPT_NATIVE              __interrupt()
#define PAL_ARCH_NESTING_INTERRUPTS_SUPPORT    0

#define FIX_ENDIANESS(x) (x)
#define FIX_ENDIANESS16(x) (x)

#define TSK3000_COP_Status                      0
#define TSK3000_COP_InterruptEnable             1
#define TSK3000_COP_InterruptPending            2
#define TSK3000_COP_TimebaseLO                  3
#define TSK3000_COP_TimebaseHI                  4
#define TSK3000_COP_Compare                     5
#define TSK3000_COP_DebugData                   6
#define TSK3000_COP_ExceptionReturn             7
#define TSK3000_COP_ExceptionBase               8
#define TSK3000_COP_InterruptMode               9

#define TSK3000_Status_InterruptEnable           0x0001
#define TSK3000_Status_UserMode                  0x0002
#define TSK3000_Status_InterruptEnable_Previous  0x0004
#define TSK3000_Status_UserMode_Previous         0x0008
#define TSK3000_Status_InterruptEnable_Old       0x0010
#define TSK3000_Status_UserMode_Old              0x0020
#define TSK3000_Status_Reserved0                 0x0040
#define TSK3000_Status_IntervalTimerReset        0x0080
#define TSK3000_Status_IntervalTimerEnable       0x0100
#define TSK3000_Status_VectorModeEnable          0x0200
#define TSK3000_Status_WishboneTimeOut           0x0400

#if ( __POSIX_KERNEL__ != 0 )
#include "pal_platform_posix.h"
#endif


typedef int pal_arch_atomic_t;

inline void tsk3000_reset_interval_timer(void)
{
    __mtc0( __mfc0(TSK3000_COP_Status) |  TSK3000_Status_IntervalTimerReset   , TSK3000_COP_Status);
    __mtc0( __mfc0(TSK3000_COP_Status) & (~TSK3000_Status_IntervalTimerReset) , TSK3000_COP_Status);
}

inline void tsk3000_set_interrupt_mode(uint32_t value){
    __mtc0(value,TSK3000_COP_InterruptMode);
}

inline uint32_t tsk3000_get_interrupt_mode(void){
    return __mfc0(TSK3000_COP_InterruptMode);
}

inline void tsk3000_set_exception_return(uint32_t value){
    __mtc0(value,TSK3000_COP_ExceptionReturn);
}

inline uint32_t tsk3000_get_exception_return(void){
    return __mfc0(TSK3000_COP_ExceptionReturn);
}

inline void tsk3000_set_exception_base(uint32_t value){
    __mtc0(value,TSK3000_COP_ExceptionBase);
}

inline uint32_t tsk3000_get_exception_base(void){
    return __mfc0(TSK3000_COP_ExceptionBase);
}

inline uint32_t tsk3000_get_timebase_lo(void)
{
    return __mfc0(TSK3000_COP_TimebaseLO);
}

inline uint32_t tsk3000_get_timebase_hi(void)
{
    return __mfc0(TSK3000_COP_TimebaseHI);
}

inline uint32_t tsk3000_get_interval_timer(void){
    return __mfc0(TSK3000_COP_Compare);
}

inline void tsk3000_set_vectored_interrupts (void ){
    __mtc0( __mfc0(TSK3000_COP_Status) | TSK3000_Status_VectorModeEnable, TSK3000_COP_Status );
    return;
}

extern  void tsk3000_set_interval_timer(uint32_t value);
extern  void tsk3000_extract_vector_table(void);




inline void* pal_architecture_get_current_sp(void) {
    void* sp;
    __asm("addi %0, $sp, 0":"=r"(sp): );
    return sp;
}

inline uint32_t pal_architecture_get_status_register(void)
{
    return __mfc0(TSK3000_COP_Status);
}

extern bool pal_architecture_set_native_handler( uint32_t number, void* handler );
extern bool pal_architecture_interrupt_configure(   uint32_t number, bool edge, bool high);

inline uint32_t pal_architecture_current_interrupt(void)
{
    uint32_t number;
    __asm("addi %0, $k1, 0":"=r"(number): );
    return number;
}

inline void     pal_architecture_interrupts_enable (void)
{
    __mtc0( __mfc0(TSK3000_COP_Status) | TSK3000_Status_InterruptEnable ,TSK3000_COP_Status);
}

inline void     pal_architecture_interrupts_disable (void)
{
    __mtc0( __mfc0(TSK3000_COP_Status) & ~TSK3000_Status_InterruptEnable, TSK3000_COP_Status );
    __nop();
    __nop();
    __nop();
}

inline void     pal_architecture_interrupts_set_mask(uint32_t mask)
{
    __mtc0(mask,TSK3000_COP_InterruptEnable);
}

inline uint32_t pal_architecture_interrupts_get_mask(void)
{
    return __mfc0(TSK3000_COP_InterruptEnable);
}

inline uint32_t   pal_architecture_interrupts_mask_levels_below (uint32_t level)
{
    uint32_t oldmask;
    uint32_t status;

    status = __mfc0(TSK3000_COP_Status);
    if (status & TSK3000_Status_InterruptEnable)
    {
        pal_architecture_interrupts_disable();
        oldmask = __mfc0(TSK3000_COP_InterruptEnable);
#if ( __POSIX_KERNEL__ == 0 )
        __mtc0( oldmask & (0xffffffffU >> (32 - level) ) & ~(1<<PAL_ARCH_3000_TIMER_INTERRUPT_NUMBER) , TSK3000_COP_InterruptEnable );
#else
        extern uint32_t         posix_interrupts_bitmask;
        __mtc0( oldmask & (0xffffffffU >> (32 - level) ) & (~(posix_interrupts_bitmask))
                & ~(1<<PAL_ARCH_3000_TIMER_INTERRUPT_NUMBER) , TSK3000_COP_InterruptEnable );
#endif
        pal_architecture_interrupts_enable();
    }
    else
    {
        oldmask = __mfc0(TSK3000_COP_InterruptEnable);
#if ( __POSIX_KERNEL__ == 0 )
        __mtc0( oldmask & (0xffffffffU >> (32 - level) ) & ~(1<<PAL_ARCH_3000_TIMER_INTERRUPT_NUMBER) , TSK3000_COP_InterruptEnable );
#else
        extern uint32_t         posix_interrupts_bitmask;
        __mtc0( oldmask & (0xffffffffU >> (32 - level) ) & (~(posix_interrupts_bitmask))
                & ~(1<<PAL_ARCH_3000_TIMER_INTERRUPT_NUMBER) , TSK3000_COP_InterruptEnable );
#endif
    }

    return oldmask;
}


#if ( __POSIX_KERNEL__ != 0 )
extern uint32_t  posix_interrupts_bitmask;
extern volatile  uint32_t  tsk3000_posix_interrupts_savemask;
inline void   pal_architecture_posix_interrupts_enable ()
{
    uint32_t mask;
    uint32_t status;

    status = __mfc0(TSK3000_COP_Status);
    if (status & TSK3000_Status_InterruptEnable)
    {
        pal_architecture_interrupts_disable();
        mask = __mfc0(TSK3000_COP_InterruptEnable);
        mask |= tsk3000_posix_interrupts_savemask;
        __mtc0(mask, TSK3000_COP_InterruptEnable);
        pal_architecture_interrupts_enable();
    }
    else
    {
        mask = __mfc0(TSK3000_COP_InterruptEnable);
        mask |= tsk3000_posix_interrupts_savemask;
        __mtc0(mask, TSK3000_COP_InterruptEnable);
    }
}

inline void   pal_architecture_posix_interrupts_disable ()
{
    uint32_t mask;
    uint32_t status;

    status = __mfc0(TSK3000_COP_Status);
    if (status & TSK3000_Status_InterruptEnable)
    {
        pal_architecture_interrupts_disable();

        mask = __mfc0(TSK3000_COP_InterruptEnable);
        tsk3000_posix_interrupts_savemask = mask & (posix_interrupts_bitmask | (1 << PAL_ARCH_3000_TIMER_INTERRUPT_NUMBER));
        mask &= ~(posix_interrupts_bitmask | (1 << PAL_ARCH_3000_TIMER_INTERRUPT_NUMBER));
        __mtc0(mask, TSK3000_COP_InterruptEnable);

        pal_architecture_interrupts_enable();
    }
    else
    {
        mask = __mfc0(TSK3000_COP_InterruptEnable);
        tsk3000_posix_interrupts_savemask = mask & (posix_interrupts_bitmask | (1 << PAL_ARCH_3000_TIMER_INTERRUPT_NUMBER));
        mask &= ~(posix_interrupts_bitmask | (1 << PAL_ARCH_3000_TIMER_INTERRUPT_NUMBER));
        __mtc0(mask, TSK3000_COP_InterruptEnable);
    }
}
#endif

extern void pal_architecture_interrupt_enable(uint32_t number);
extern void pal_architecture_interrupt_disable(uint32_t number);

inline void     pal_architecture_interrupt_acknowledge(uint32_t number){
    __mtc0( (1<<number), TSK3000_COP_InterruptPending);
    return;
}

inline void     pal_architecture_timer_interrupt_acknowledge(void){
    tsk3000_reset_interval_timer();
    pal_architecture_interrupt_acknowledge((1<<PAL_ARCH_CLOCK_INTNO) );
    return;
}

inline void pal_architecture_timer_interrupt_enable(void)
{
    pal_architecture_interrupt_enable(PAL_ARCH_CLOCK_INTNO );
}

inline void pal_architecture_timer_interrupt_disable(void)
{
    pal_architecture_interrupt_disable(PAL_ARCH_CLOCK_INTNO );
}

inline void     pal_architecture_timer_interrupt_start ( void )
{
    pal_architecture_interrupt_enable(PAL_ARCH_CLOCK_INTNO );
    __mtc0( __mfc0(TSK3000_COP_Status) | TSK3000_Status_IntervalTimerEnable , TSK3000_COP_Status);
}

inline void     pal_architecture_timer_interrupt_stop ( void )
{
    __mtc0( __mfc0(TSK3000_COP_Status) & (~TSK3000_Status_IntervalTimerEnable) , TSK3000_COP_Status);
    pal_architecture_interrupt_disable(PAL_ARCH_CLOCK_INTNO );
}

extern bool     pal_architecture_interrupts_init( void );
extern bool     pal_architecture_timer_interrupt_init( void );
extern bool     pal_architecture_processor_init ( void );
extern bool     pal_architecture_clock_init ( void );

#endif


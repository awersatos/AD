#ifndef _H_PAL_ARCH
#define _H_PAL_ARCH

#include <stdint.h>
#include <stdbool.h>
#include "pal_cfg.h"
#include "pal_arch_cfg.h"

#define PAL_ARCH_INTERNAL_NUMBER               0
#define PAL_ARCH_EXTERNAL_NUMBER               PAL_ARCH_NIOS_MAXINTRS
#define PAL_ARCH_MAXINTRS                      PAL_ARCH_EXTERNAL_NUMBER
#define PAL_ARCH_CLOCK_INTNO                   PAL_ARCH_NIOS_TIMER_INTERRUPT_NUMBER

#define PAL_ARCH_INTERRUPT_NATIVE              
#define PAL_ARCH_NESTING_INTERRUPTS_SUPPORT    0

#define NIOS2_STATUS_INTERRUPT_ENABLE          0x1
#define NIOS2_STATUS_USER_MODE                 0x2
#define NIOS2_STATUS_EXCEPTION_HANDLER         0x4

#define NIOS2_TIMEBASE_LOW                     0xFFFFFFE0
#define NIOS2_TIMEBASE_HI                      0xFFFFFFE4
#define NIOS2_TIMEBASE_INTERVAL_TIMER          0xFFFFFFE8
#define NIOS2_TIMEBASE_STATUS                  0xFFFFFFEE

#define NIOS2_TIMEBASE_INTERVAL_TIMER_ENABLE   0x1
#define NIOS2_TIMEBASE_INTERRUPT_PENDING       0x2
#define NIOS2_TIMEBASE_INTERRUPT_CLEAR         0x4
#define NIOS2_TIMEBASE_INTERVAL_TIMER_RESET    0x8

#define NIOS2_EXCEPTION_ADDRESS                0x100

inline void* pal_architecture_get_current_sp(void) {
    void* sp;
    __asm("addi %0, r27, 0":"=r"(sp): );
    return sp;
}

#if ( __POSIX_KERNEL__ != 0 )
#include "pal_platform_posix.h"
#endif

typedef int pal_arch_atomic_t;

inline void nios_set_status_reg( uint32_t value )
{
    __asm("wrctl ctl0, %0" : : "r"(value) : );
}

inline uint32_t nios_get_status_reg( void )
{
    uint32_t result;
    __asm("rdctl %0, ctl0" : "=r"(result) : : );
    return result;
}

inline void nios_enable_interrupts(void)
{
    nios_set_status_reg(nios_get_status_reg() | NIOS2_STATUS_INTERRUPT_ENABLE);
}

inline void nios_disable_interrupts(void)
{
    nios_set_status_reg(nios_get_status_reg() & (~NIOS2_STATUS_INTERRUPT_ENABLE));
}

inline void nios_set_enabled_interrupts(uint32_t value)
{
    __asm("wrctl ctl3, %0" : : "r"(value) : );
}

inline uint32_t nios_get_enabled_interrupts(void)
{
    uint32_t result;
    __asm("rdctl %0, ctl3" : "=r"(result) : : );
    return result;
}

inline void nios_set_vectored_interrupts(void)
{
    return;
}

inline uint32_t nios_get_pending_interrupts(void)
{
    uint32_t result;
    __asm("rdctl %0, ctl4" : "=r"(result) : : );
    return result;
}

inline void     nios_interrupt_acknowledge(uint32_t number){
    return;
}

inline void nios_set_interval_timer(uint32_t value)
{
    *((volatile uint32_t*) NIOS2_TIMEBASE_INTERVAL_TIMER) = value;
}

inline uint32_t nios_get_interval_timer(void)
{
    return *((volatile uint32_t*) NIOS2_TIMEBASE_INTERVAL_TIMER);
}

inline void nios_reset_interval_timer(void)
{
   *((volatile uint32_t*) NIOS2_TIMEBASE_STATUS) = NIOS2_TIMEBASE_INTERVAL_TIMER_RESET;
}

inline void nios_acknowledge_interval_timer(void)
{
    unsigned int status;

    __asm("ldwio    %0, -18(r0)": "=r"(status));
    status |= NIOS2_TIMEBASE_INTERRUPT_CLEAR;
    __asm("stwio    %0, -18(r0)"::"r"(status));
}

inline void nios_enable_interval_timer(void)
{
    *((volatile uint32_t*) NIOS2_TIMEBASE_STATUS) = NIOS2_TIMEBASE_INTERVAL_TIMER_ENABLE;
}

inline void nios_disable_interval_timer(void)
{
    *((volatile uint32_t*) NIOS2_TIMEBASE_STATUS) = 
        *((volatile uint32_t*) NIOS2_TIMEBASE_STATUS) & ~NIOS2_TIMEBASE_INTERVAL_TIMER_ENABLE;
}

inline bool pal_architecture_interrupt_configure(  uint32_t number, bool edge, bool high)
{
    return true;
}

inline uint32_t pal_architecture_get_status_register(void)
{
    return nios_get_status_reg();
}

inline uint32_t pal_architecture_current_interrupt(void)
{
    extern uint32_t nios_current_interrupt;
    return nios_current_interrupt;
}

inline void     pal_architecture_interrupts_enable (void)
{
    nios_enable_interrupts();
}

inline void     pal_architecture_interrupts_disable (void)
{
    nios_disable_interrupts();
}

inline void     pal_architecture_interrupts_set_mask(uint32_t mask)
{
    nios_set_enabled_interrupts(mask);
}

inline uint32_t pal_architecture_interrupts_get_mask(void)
{
    return  nios_get_enabled_interrupts();
}

inline uint32_t   pal_architecture_interrupts_mask_levels_below (uint32_t level)
{
     uint32_t mask = nios_get_enabled_interrupts();
#if ( __POSIX_KERNEL__ == 0 )
    nios_set_enabled_interrupts( mask & (0xffffffffU >> (32 - level) ) & ~(1<<PAL_ARCH_NIOS_TIMER_INTERRUPT_NUMBER) );
#else
    extern uint32_t         posix_interrupts_bitmask;
    nios_set_enabled_interrupts( mask & (0xffffffffU >> (32 - level) ) & (~(posix_interrupts_bitmask))
            & ~(1<<PAL_ARCH_NIOS_TIMER_INTERRUPT_NUMBER) );
#endif
    return mask;
}


#if ( __POSIX_KERNEL__ != 0 )
extern uint32_t  posix_interrupts_bitmask;
extern volatile  uint32_t  nios_posix_interrupts_savemask;
inline void   nios_posix_interrupts_internal_enable ()
{
    nios_set_enabled_interrupts( nios_posix_interrupts_savemask ) ;
}

inline void   nios_posix_interrupts_internal_disable ()
{
    uint32_t mask = nios_get_enabled_interrupts();
    nios_set_enabled_interrupts( mask & ~(posix_interrupts_bitmask) & ~(1<<PAL_ARCH_NIOS_TIMER_INTERRUPT_NUMBER) );
    nios_posix_interrupts_savemask = mask;
}
#define     pal_architecture_posix_interrupts_enable    nios_posix_interrupts_internal_enable
#define     pal_architecture_posix_interrupts_disable   nios_posix_interrupts_internal_disable
#endif

inline void     pal_architecture_interrupt_enable  (uint32_t number){
    nios_set_enabled_interrupts ( nios_get_enabled_interrupts() | (1<<number) );
    return;
}

inline void     pal_architecture_interrupt_disable  (uint32_t number){
    nios_set_enabled_interrupts ( nios_get_enabled_interrupts() & ~(1<<number) );
    return;
}

inline void     pal_architecture_interrupt_acknowledge(uint32_t number){
    nios_interrupt_acknowledge(number);
    return;
}

inline void     pal_architecture_timer_interrupt_acknowledge(void){
    nios_acknowledge_interval_timer();
    nios_interrupt_acknowledge((1<<PAL_ARCH_CLOCK_INTNO) );
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
    nios_enable_interval_timer();
}

inline void     pal_architecture_timer_interrupt_stop ( void )
{
    nios_disable_interval_timer();
    pal_architecture_interrupt_disable(PAL_ARCH_CLOCK_INTNO );
}

extern bool     pal_architecture_interrupts_init( void );
extern bool     pal_architecture_timer_interrupt_init( void );
extern bool     pal_architecture_processor_init ( void );
extern bool     pal_architecture_clock_init ( void );
extern bool     pal_architecture_set_native_handler( uint32_t number, void* handler );

#endif


#ifndef _H_PAL_ARCH
#define _H_PAL_ARCH

#include <stdint.h>
#include <stdbool.h>
#include "pal_cfg.h"
#include "pal_arch_cfg.h"
#include "pal_variant.h"

#include "timing_cfg.h"

#define PAL_ARCH_INTERNAL_NUMBER               2
#define PAL_ARCH_EXTERNAL_NUMBER               32
#define PAL_ARCH_INTERNAL_CLOCK                1
#define PAL_ARCH_CLOCK_INTNO                   PPC_PIT_INTERRUPT
#define PAL_ARCH_MAXINTRS                      (PAL_ARCH_EXTERNAL_NUMBER + PAL_ARCH_INTERNAL_NUMBER)
#define PAL_ARCH_CLOCK_INTNO                   PPC_PIT_INTERRUPT
#define PAL_ARCH_INTERRUPT_NATIVE
#define PAL_ARCH_NESTING_INTERRUPTS_SUPPORT    0

/* some spr values */
#define _TBL                            0x10C
#define _TBU                            0x10D
#define _TSR                            0x3D8
#define _TCR                            0x3DA
#define _PIT                            0x3DB
#define _EVPR                           0x3D6

/* TSR bit masks*/
#define _TSR_FIS    0x04000000
#define _TSR_PIS    0x08000000
#define _TSR_WIS    0x40000000
#define _TCR_PIE    0x04000000
#define _TCR_FIE     0x00800000
#define _TCR_ARE    0x00400000

#define CriticalInput_Interrupt             0
#define MachineCheck_Interrupt              1
#define DataStorage_Interrupt               2
#define InstructionStorage_Interrupt        3
#define External_Interrupt                  4
#define Alignment_Interrupt                 5
#define Program_Interrupt                   6
#define FPU_Interrupt                       7
#define SystemCall_Interrupt                8
#define APU_Interrupt                       9
#define ProgrammableIntervalTimer_Interrupt 10
#define PIT_Interrupt                       10
#define FixedIntervalTimer_Interrupt        11
#define FIT_Interrupt                       11
#define WatchdogTimer_Interrupt             12
#define DataTLBMiss_Interrupt               13
#define InstructionTLBMiss_Interrupt        14
#define Debug_Interrupt                     15

#define PPC_PIT_INTERRUPT             32
#define PPC_FIT_INTERRUPT             33

#define FIX_ENDIANESS(x) (x)
#define FIX_ENDIANESS16(x) (x)

#if ( __POSIX_KERNEL__ != 0 )
#include "pal_platform_posix.h"
#endif

typedef int pal_arch_atomic_t;


inline void         ppc405_set_exception_vector_prefix(uint32_t address){
    __asm("mtevpr %0": :"r"(address): );
}

inline uint32_t     ppc405_get_exception_vector_prefix (void){
    uint32_t ret = 0;
    __asm("mfspr %0, %1":"=r"(ret): "i"(_EVPR): );
    return ret;
}

inline void        ppc405_pit_set_interval(unsigned int value)
{
     __mtspr( _PIT , value );
     __mtspr( _TCR, __mfspr(_TCR)| _TCR_ARE);
}

inline uint32_t    ppc405_pit_get_interval(void)
{
        uint32_t ret = 0;
        __asm("mfspr %0, %1":"=r"(ret): "i"(_PIT): );
        return ret;
}

inline void        ppc405_pit_interrupt_acknowledge(void)
{
    __mtspr( _TSR, _TSR_PIS );
}

inline void        ppc405_pit_interrupt_enable(void)
{
    __mtspr( _TCR , __mfspr(_TCR) | _TCR_PIE );
}

inline void        ppc405_pit_interrupt_disable(void)
{
      __mtspr( _TCR , __mfspr(_TCR) & ~_TCR_PIE );
}

inline void        ppc405_fit_interrupt_enable(void)
{
       __mtspr( _TCR , __mfspr(_TCR) | _TCR_FIE );
}

inline void        ppc405_fit_interrupt_disable(void){
       __mtspr( _TCR , __mfspr(_TCR) & ~_TCR_FIE );
}

inline void        ppc405_fit_interrupt_acknowledge(void){
       __mtspr( _TSR, _TSR_FIS );
}

extern void ppc405_extract_vector_table(void);
extern bool pal_architecture_set_native_handler( uint32_t number, void* handler );


inline void* pal_architecture_get_current_sp(void)
{
    void* sp;
    __asm("addi %0,%%r1, 0":"=r"(sp):);
    return sp;
}

inline uint32_t pal_architecture_get_status_register(void)
{
        return __mfmsr();
}

#define pal_architecture_interrupt_configure(n,e,h)     pal_variant_interrupt_configure(n,e,h)
#define pal_architecture_current_interrupt              pal_variant_current_interrupt
#define pal_architecture_interrupts_set_mask            pal_variant_interrupts_set_mask
#define pal_architecture_interrupts_get_mask            pal_variant_interrupts_get_mask

inline void     pal_architecture_interrupts_enable (void)
{
    __asm("wrteei 1");
}

inline void     pal_architecture_interrupts_disable (void)
{
        __asm("wrteei 0");
}


inline uint32_t   pal_architecture_interrupts_mask_levels_below (uint32_t level)
{
     uint32_t oldmask = pal_variant_interrupts_get_mask();
#if ( __POSIX_KERNEL__ == 0 )
    pal_variant_interrupts_set_mask ( oldmask & (0xffffffffU >> (32 - level) ) );
#else
    extern uint32_t         posix_interrupts_bitmask;
    pal_variant_interrupts_set_mask ( oldmask & (0xffffffffU >> (32 - level) ) & (~(posix_interrupts_bitmask)) );
#endif
    return oldmask;
}

#if ( __POSIX_KERNEL__ != 0 )

extern uint32_t  posix_interrupts_bitmask;
extern uint32_t  ppc405_posix_interrupts_savemask;

inline void pal_architecture_posix_interrupts_disable() {
    uint32_t mask = pal_variant_interrupts_get_mask();
    pal_variant_interrupts_set_mask( mask & ~(posix_interrupts_bitmask) );
    ppc405_posix_interrupts_savemask = mask;
#if ( TIMING_USETIMERS>0 ) || (__POSIX_KERNEL__ !=0)
    ppc405_pit_interrupt_disable();
#endif
#if ( PPC_405_ARCH_FIT > 0 )
    ppc405_fit_interrupt_disable();
#endif
    return;
}

inline void pal_architecture_posix_interrupts_enable() {
    pal_variant_interrupts_set_mask( ppc405_posix_interrupts_savemask  );
#if ( TIMING_USETIMERS>0 ) || (__POSIX_KERNEL__ !=0)
    ppc405_pit_interrupt_enable();
#endif
#if ( PPC_405_ARCH_FIT > 0 )
    ppc405_fit_interrupt_enable();
#endif
    return;
}

#endif


inline void     pal_architecture_interrupt_enable  (uint32_t number)
{
#if ( TIMING_USETIMERS>0 ) || (__POSIX_KERNEL__ !=0)
    if ( PPC_PIT_INTERRUPT == number )
    {
        ppc405_pit_interrupt_enable();
        return;
    }
#endif
#if ( PPC_405_ARCH_FIT > 0 )
    if ( PPC_FIT_INTERRUPT == number )
    {
        ppc405_fit_interrupt_enable();
        return;
    }
#endif
    pal_variant_interrupt_enable(number);
    return;
}

inline void     pal_architecture_interrupt_disable  (uint32_t number){
#if ( TIMING_USETIMERS>0 ) || (__POSIX_KERNEL__ !=0)
    if ( PPC_PIT_INTERRUPT == number )
    {
        ppc405_pit_interrupt_disable();
        return;
    }
#endif
#if ( PPC_405_ARCH_FIT > 0 )
    if ( PPC_FIT_INTERRUPT == number )
    {
        ppc405_fit_interrupt_disable();
        return;
    }
#endif
    pal_variant_interrupt_disable(number);
    return;
}

inline void     pal_architecture_interrupt_acknowledge(uint32_t number)
{
#if ( TIMING_USETIMERS>0 ) || (__POSIX_KERNEL__ !=0)
   if ( PPC_PIT_INTERRUPT == number )
    {
         ppc405_pit_interrupt_acknowledge();
         return;
    }
#endif
#if ( PPC_405_ARCH_FIT > 0 )
    if ( PPC_FIT_INTERRUPT == number )
    {
        ppc405_fit_interrupt_acknowledge();
        return;
    }
#endif

    pal_variant_interrupt_acknowledge(number);
    return;
}

#if ( TIMING_USETIMERS>0 ) || (__POSIX_KERNEL__ !=0)
extern uint32_t pal_cppc_pit_reload_value;
inline void     pal_architecture_timer_interrupt_start ( void )
{
    ppc405_pit_set_interval(pal_cppc_pit_reload_value);
    ppc405_pit_interrupt_enable();
}

inline void     pal_architecture_timer_interrupt_stop ( void )
{
    ppc405_pit_interrupt_disable();
}

inline void pal_architecture_timer_interrupt_enable(void)
{
    ppc405_pit_interrupt_enable();
}

inline void pal_architecture_timer_interrupt_disable(void)
{
    ppc405_pit_interrupt_disable();
}

inline void     pal_architecture_timer_interrupt_acknowledge(void){

    ppc405_pit_interrupt_acknowledge();
    return;
}
extern bool     pal_architecture_timer_interrupt_init( void );
#endif

extern bool     pal_architecture_interrupts_init( void );
extern bool     pal_architecture_processor_init ( void );
extern bool     pal_architecture_clock_init ( void );

#endif


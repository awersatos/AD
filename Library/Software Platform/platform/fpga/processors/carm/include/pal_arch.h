#ifndef _H_PAL_ARCH
#define _H_PAL_ARCH

#include <stdint.h>
#include <stdbool.h>
#include "pal_cfg.h"
#include "pal_arch_cfg.h"
#include "pal_variant.h"

#include "timing_cfg.h"

#define PAL_ARCH_INTERNAL_NUMBER               0
#define PAL_ARCH_EXTERNAL_NUMBER               PAL_VARIANT_EXTERNAL_NUMBER
#define PAL_ARCH_INTERNAL_CLOCK                0
#define PAL_ARCH_CLOCK_INTNO                   PAL_VARIANT_CLOCK_INTN0
#define PAL_ARCH_MAXINTRS                      (PAL_ARCH_EXTERNAL_NUMBER + PAL_ARCH_INTERNAL_NUMBER)
#define PAL_ARCH_INTERRUPT_NATIVE
#define PAL_ARCH_NESTING_INTERRUPTS_SUPPORT    0

#define FIX_ENDIANESS(x)    ((((x) & 0xFF) << 24) | (((x) & 0xFF00) << 8) | (((x) & 0xFF0000) >> 8) | (((x) & 0xFF000000) >> 24))
#define FIX_ENDIANESS16(x)  (x)

inline void pal_architecture_set_current_sp(void*sp)
{
    __asm("mov      sp,%0"::"r"(sp));
}

inline void* pal_architecture_get_current_sp(void)
{
        void* ret;
        __asm("mov      %0,sp":"=r"(ret));
        return ret;
}

#if ( __POSIX_KERNEL__ != 0 )
#include "pal_platform_posix.h"
#endif

typedef int pal_arch_atomic_t;

#define CPSR_F_BIT                 0x40
#define CPSR_I_BIT                 0x80


/* processor exceptions */
#define Exception_Undefined          0x04
#define Exception_SWI                0x08
#define Exception_Prefetch           0x0C
#define Exception_Data               0x10
#define Exception_FIQ                0x1C

/* processor modes */
#define ARM7_USER_MODE             0x10
#define ARM7_FIQ_MODE              0x11
#define ARM7_IRQ_MODE              0x12
#define ARM7_SVC_MODE              0x13
#define ARM7_ABORT_MODE            0x17
#define ARM7_UNDEF_MODE            0x1B
#define ARM7_SYSTEM_MODE           0x1F



extern void pal_architecture_extract_vector_table(void);
extern bool pal_architecture_set_native_handler( uint32_t number, void* handler );

inline uint32_t pal_architecture_get_status_register(void)
{
      int cpsr;
      __asm("mrs  %0,cpsr":"=r"(cpsr));
      return cpsr;
}

#define pal_architecture_interrupt_enable               pal_variant_interrupt_enable
#define pal_architecture_interrupt_disable              pal_variant_interrupt_disable
#define pal_architecture_interrupt_acknowledge          pal_variant_interrupt_acknowledge
#define pal_architecture_interrupt_configure(n,e,h)     pal_variant_interrupt_configure(n,e,h)
#define pal_architecture_current_interrupt              pal_variant_current_interrupt
#define pal_architecture_interrupts_set_mask            pal_variant_interrupts_set_mask
#define pal_architecture_interrupts_get_mask            pal_variant_interrupts_get_mask

extern bool pal_architecture_set_native_handler( uint32_t number, void* handler );
extern bool pal_architecture_clock_init(void);
extern bool pal_architecture_processor_init(void);
extern bool pal_architecture_interrupts_init(void);

#if ( TIMING_USETIMERS>0 ) || (__POSIX_KERNEL__ !=0)
#define pal_architecture_timer_interrupt_init           pal_variant_timer_interrupt_init
#define pal_architecture_timer_interrupt_start          pal_variant_timer_interrupt_start
#define pal_architecture_timer_interrupt_stop           pal_variant_timer_interrupt_stop
#define pal_architecture_timer_interrupt_enable         pal_variant_timer_interrupt_enable
#define pal_architecture_timer_interrupt_disable        pal_variant_timer_interrupt_disable
#define pal_architecture_timer_interrupt_acknowledge    pal_variant_timer_interrupt_acknowledge
#endif


inline void     pal_architecture_interrupts_enable (void)
{
      int cpsr;
      __asm("mrs  %0,cpsr":"=r"(cpsr));
      cpsr &= ~(CPSR_I_BIT | CPSR_F_BIT );
      __asm("msr  cpsr_fsxc,%0"::"r"(cpsr));
      return;
}

inline void     pal_architecture_interrupts_disable (void)
{
      int cpsr;
      __asm("mrs  %0,cpsr":"=r"(cpsr));
      cpsr |= (CPSR_I_BIT | CPSR_F_BIT );
      __asm("msr  cpsr_fsxc,%0"::"r"(cpsr));
      return;
}

inline void arm7_processor_mode(unsigned int mode){
        int cpsr;

        __asm("mrs     %0,cpsr":"=r"(cpsr));
        cpsr    &= ~0x1F;
        cpsr    |= mode ;
        __asm("msr     cpsr_fsxc,%0"::"r"(cpsr));

        return;
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
extern uint32_t  arm7_posix_interrupts_savemask;
inline void pal_architecture_posix_interrupts_disable() {
    uint32_t mask = pal_variant_interrupts_get_mask();
    pal_variant_interrupts_set_mask( mask & ~(posix_interrupts_bitmask) );
    arm7_posix_interrupts_savemask = mask;
    pal_variant_timer_interrupt_disable();
    return;
}
inline void pal_architecture_posix_interrupts_enable() {
    pal_variant_interrupts_set_mask( arm7_posix_interrupts_savemask  );
    pal_variant_timer_interrupt_enable();
    return;
}

#endif

extern void arm7_extract_vector_table(void);

#endif


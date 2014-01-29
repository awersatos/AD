
#include <stdint.h>
#include <stdbool.h>
#include <pal.h>
#include "pal_platform_posix.h"

#if ( __POSIX_KERNEL__ != 0 )
#include "posix_threads_cfg.h"

extern void*        _posix_current_thread;
extern uint32_t     posix_interrupts_bitmask;
uint32_t            ppc405_posix_interrupts_savemask=0;
int32_t             _posix_interrupt_stack[(POSIX_THREADS_INTR_STACKSIZE/4)];
void*               _posix_interrupt_stack_top =
                        &_posix_interrupt_stack[((POSIX_THREADS_INTR_STACKSIZE/4)-2)];

#define ppc405_posix_interrupt_stack_swap(ID)                                   \
    __asm(".extern  _posix_irq_level");                                         \
    __asm(".extern  _posix_current_thread");                                    \
    __asm(".extern  _posix_irq_level");                                         \
    __asm("lwz      %%r4,@sda21(_posix_irq_level)(%%r0)");                      \
    __asm("cmpwi    %%cr0,%%r4,0");                                             \
    __asm("addi     %%r4,%%r4,1");                                              \
    __asm("stw      %%r4,@sda21(_posix_irq_level)(%%r0)");                      \
    __asm("bne      %%cr0,.L9"#ID"");                                           \
    __asm("lwz      %%r4,@sda21(_posix_current_thread)(%%r0)");                 \
    __asm("cmplwi   %%cr0,%%r4,0x0");                                           \
    __asm("beq      %%cr0,.L10"#ID"");                                          \
    __asm("lis      %%r4,@ha(_posix_current_thread)");                          \
    __asm("la       %%r5,@lo(_posix_current_thread)(%%r4)");                    \
    __asm("lwzu     %%r6,0(%%r5)");                                             \
    __asm("stw      %%r1,0x0(%%r6)");                                           \
    __asm("b        .L11"#ID"");                                                \
__asm(".L10"#ID":");                                                            \
    __asm("mtsprg0          %%r1");                                             \
__asm(".L11"#ID":");                                                            \
    __asm("lis              %%r5,@ha(_posix_interrupt_stack_top)");             \
    __asm("la               %%r6,@lo(_posix_interrupt_stack_top)(%%r5)");       \
    __asm("lwzu             %%r5,0(%%r6)");                                     \
    __asm("mr               %%r1,%%r5");                                        \
__asm(".L9"#ID":");

#define ppc405_posix_interrupt_stack_restore(ID)                                \
    __asm("lwz      %%r3,@sda21(_posix_irq_level)(%%r0)");                      \
    __asm("cmpwi    %%cr0,%%r3,1");                                             \
    __asm("addi     %%r3,%%r3,-1");                                             \
    __asm("stw      %%r3,@sda21(_posix_irq_level)(%%r0)");                      \
    __asm("bne      %%cr0,.L14"#ID"");                                          \
    __asm("lwz      %%r3,@sda21(_posix_current_thread)(%%r0)");                 \
    __asm("cmplwi   %%cr0,%%r3,0x0");                                           \
    __asm("beq      %%cr0,.L13"#ID"");                                          \
    __asm("lis      %%r3,@ha(_posix_current_thread)");                          \
    __asm("la       %%r4,@lo(_posix_current_thread)(%%r3)");                    \
    __asm("lwzu     %%r5,0(%%r4)");                                             \
    __asm("lwzu     %%r1,0x0(%%r5)");                                           \
    __asm("b        .L14"#ID"");                                                \
__asm(".L13"#ID":");                                                            \
    __asm("mfsprg0  %%r1");                                                     \
__asm(".L14"#ID":");

#endif // __POSIX_KERNEL__

typedef void (*ppc405_native_handler_t)(void);
static  ppc405_native_handler_t  ppc405_native_table[PAL_ARCH_MAXINTRS];

extern bool pal_architecture_set_native_handler( uint32_t number, void* handler )
{
    if ( number >= PAL_ARCH_MAXINTRS ) return false;
    ppc405_native_table[number] = (ppc405_native_handler_t)handler ;
    return true;
}




void     ppc405_external_nonnative_interrupt_handler(void)
{
    uint32_t number = pal_variant_current_interrupt ();

#if ( __POSIX_KERNEL__ == 0 )
    interrupts_common_handler(number);
#else
    if ( posix_interrupts_bitmask & (1<<number) )
    {
        posix_interrupts_handler(number);
    }
    else
    {
        interrupts_common_handler(number);
    }
#endif
}

void  ppc405_external_interrupt_handler(void)
{
    ppc405_interrupt_native_context_save();

    // uint32_t number = pal_variant_current_interrupt ();
    __asm("mfdcr    %%r3, 4");
    // if ( ppc405_native_table[number] )
    __asm("lis      %%r4,@ha(ppc405_native_table)");
    __asm("rlwinm   %%r5,%%r3,2,0,29");
    __asm("la       %%r4,@lo(ppc405_native_table)(%%r4)");
    __asm("lwzx     %%r4,%%r5,%%r4");
    __asm("cmplwi   %%cr0,%%r4,0x0");
    // else
    __asm("beq      %%cr0,.external_to_nonnative_handler");
    // ppc405_native_table[number]();
    __asm("mtctr    %%r4");
    __asm("bctrl");
    __asm("b    .external_restore_native_ctx");

__asm(".external_to_nonnative_handler:");

    #if ( __POSIX_KERNEL__ != 0 )
    // save rest of the context
    ppc405_non_volatile_reg_save();
    // swap stacks : save sp
    ppc405_posix_interrupt_stack_swap(EXTERNAL)
    #endif

    __asm("addi             %%r1,%%r1,-0x8");
    __asm("bl   ppc405_external_nonnative_interrupt_handler");
    __asm("addi             %%r1,%%r1,0x8");

    #if ( __POSIX_KERNEL__ != 0 )
    // restore stacks : restore sp
    ppc405_posix_interrupt_stack_restore(EXTERNAL)
    // restore non volatile context
    ppc405_non_volatile_reg_restore();
    //pal_architecture_interrupts_disable();
    __asm("wrteei 0");
    // pal_architecture_posix_interrupts_enable();
    __asm("lwz %%r3,@sda21(ppc405_posix_interrupts_savemask)(%%r0)");
    __asm("mtdcr 0, %%r3");
    __asm("mfspr    %%r3,986");
    __asm("oris     %%r3,%%r3,0x400");
    __asm("mtspr    986,%%r3");
    #endif

__asm(".external_restore_native_ctx:");
    ppc405_native_context_restore();

  __asm("rfi");

}

__interrupt_indirect(External_Interrupt)  __frame() void ppc405_external_interrupt(void)
{
    __asm("b ppc405_external_interrupt_handler");
}

#if ( __TIMERS__ > 0 ) || ( __POSIX_KERNEL__ != 0 )

void  ppc405_pit_interrupt_handler(void)
{
    ppc405_interrupt_native_context_save();

#if ( __POSIX_KERNEL__ == 0 )
    __asm(".extern pal_timers_common_handler");
    __asm("bl   pal_timers_common_handler");
#else
    __asm(".extern posix_clock_interrupt_handler");
    //ppc405_pit_interrupt_acknowledge();
    __asm("lis      %%r3,2048");
    __asm("mtspr      984,%%r3");
    //pal_architecture_posix_interrupts_disable();
    __asm("mfdcr    %%r3, 0");
    __asm("lwz      %%r4,@sda21(posix_interrupts_bitmask)(%%r0)");
    __asm("andc     %%r4,%%r3,%%r4");
    __asm("mtdcr    0, %%r4");
    __asm("stw      %%r3,@sda21(ppc405_posix_interrupts_savemask)(%%r0)");
    //pal_architecture_interrupts_enable();
    __asm("wrteei 1");
    /* save non-volatile context */
    ppc405_non_volatile_reg_save();
    // swap stacks : save sp in thread block
    ppc405_posix_interrupt_stack_swap(PIT)
    // posix clock handler
    __asm("addi             %%r1,%%r1,-0x8");
    __asm("bl   posix_clock_interrupt_handler");
    __asm("addi             %%r1,%%r1,0x8");
    // restore stacks : restore sp from thread block
    ppc405_posix_interrupt_stack_restore(PIT)
    // restore non volatile context
    ppc405_non_volatile_reg_restore();
    //pal_architecture_interrupts_disable();
    __asm("wrteei 0");
    //pal_architecture_posix_interrupts_enable();
    __asm("lwz %%r3,@sda21(ppc405_posix_interrupts_savemask)(%%r0)");
    __asm("mtdcr 0, %%r3");
#endif

    ppc405_native_context_restore();

     __asm("rfi");
}

__interrupt_indirect(PIT_Interrupt) __frame() void ppc405_pit_interrupt(void)
{
    __asm("b ppc405_pit_interrupt_handler");
}

#endif // ( __TIMERS__>0 ) || (__POSIX_KERNEL__!=0)


void ppc405_extract_vector_table(void) { return; }



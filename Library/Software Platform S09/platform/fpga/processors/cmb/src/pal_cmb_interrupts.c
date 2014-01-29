#include <stdint.h>
#include <stdbool.h>
#include <pal.h>



 /*
 * MicroBlaze supports one external interrupt source
 * (connecting to the Interrupt input port). The processor will only react
 * to interrupts if the Interrupt Enable (IE) bit in the MSR is set to 1.
 * On an interrupt the instruction in the execution stage will complete,
 * while the instruction in the decode stage is replaced by a branch to the
 * interrupt vector (address 0x10).
 * The interrupt return address (the PC associated with the instruction in
 * the decode stage at the time of the interrupt) is automatically loaded into
 * general purpose register R14.
 * In addition, the processor also disables future interrupts by clearing
 * the IE bit in the MSR.
 * The IE bit is automatically set again when executing the RTID instruction
 *
 * r14      <-- PC
 * PC       <-- 0x00000010
 * MSR[IE]  <--- 0
 *
 */

#if ( __POSIX_KERNEL__ != 0 )
#include "posix_threads_cfg.h"

extern void*        _posix_current_thread;
extern uint32_t     posix_interrupts_bitmask;
static void         *_posix_preempted_stack;
int32_t             _posix_interrupt_stack[(POSIX_THREADS_INTR_STACKSIZE/4)];
void*               _posix_interrupt_stack_top =
                        &_posix_interrupt_stack[((POSIX_THREADS_INTR_STACKSIZE/4)-2)];
volatile uint32_t  microblaze_posix_interrupts_savemask=0;

inline void microblaze_posix_interrupt_stack_swap(void)
{
   if (_posix_irq_level++==0)
    {
       if (_posix_current_thread!=NULL)
       {
        __asm("sw      r1, r0, %0" : : "r"(_posix_current_thread) : );
       }
       else
       {
        __asm("swi      r1, r0, %0" : : "i"(&_posix_preempted_stack) );
       }
        __asm("lwi      r1, r0, %0" : : "i"(&_posix_interrupt_stack_top) : );
    }
}

inline void microblaze_posix_interrupt_stack_restore(void)
{
    if (_posix_irq_level--==1)
    {
        if (_posix_current_thread!=NULL )
        {
            __asm("lw      r1, r0, %0" : : "r"(_posix_current_thread) : );
        }
        else
        {
            __asm("lwi      r1, r0, %0" : : "i"(&_posix_preempted_stack) );
        }
    }
}
#endif

typedef void (*microblaze_native_handler_t)(void);
static  microblaze_native_handler_t  microblaze_native_table[PAL_ARCH_MAXINTRS];



#define __FRAME() __frame(rmsr,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15)

__interrupt(Interrupt_Interrupt) __FRAME() void microblaze_external_interrupt(void)
{

    uint32_t number =  pal_architecture_current_interrupt();
    if ( microblaze_native_table[number]  )
    {
        microblaze_native_table[number]();
        return;
    }

#if ( __POSIX_KERNEL__ == 0 )

    #if ( __TIMERS__ > 0 )
    if (number == PAL_ARCH_MB_TIMER_INTERRUPT_NUMBER )
        pal_timers_common_handler();
    else
    #endif
    interrupts_common_handler(number);

#else

    if (number == PAL_ARCH_MB_TIMER_INTERRUPT_NUMBER )
    {
        microblaze_timer_interrupt_acknowledge();
        microblaze_posix_interrupts_internal_disable();
        pal_architecture_interrupts_enable();
        microblaze_save_interrupt_callee();
        microblaze_posix_interrupt_stack_swap();
        posix_clock_interrupt_handler();
        microblaze_posix_interrupt_stack_restore();
        microblaze_restore_callee();
        pal_architecture_interrupts_disable();
        microblaze_posix_interrupts_internal_enable();
    }
    else if ( posix_interrupts_bitmask & (1<<number) )
    {
        microblaze_save_interrupt_callee();
        microblaze_posix_interrupt_stack_swap();
        posix_interrupts_handler(number);
        microblaze_posix_interrupt_stack_restore();
        microblaze_restore_callee();
        pal_architecture_interrupts_disable();
        microblaze_posix_interrupts_internal_enable();
    }
    else
    {
        interrupts_common_handler(number);
    }


#endif

}



void microblaze_extract_vector_table(void)
{
    return;
}

bool pal_architecture_set_native_handler( uint32_t number, void* handler )
{
    if ( (number < 0) || (number >= PAL_ARCH_MAXINTRS) )
        return false;

    microblaze_native_table[number] = (microblaze_native_handler_t)handler;
    return true;
}





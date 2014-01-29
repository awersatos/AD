
#include <stdint.h>
#include <stdbool.h>
#include <pal.h>
#include "pal_platform_posix.h"

#if ( __POSIX_KERNEL__ != 0 )
#include "posix_threads_cfg.h"

extern uint32_t     posix_interrupts_bitmask;
uint32_t            arm7_posix_interrupts_savemask=0;
int32_t             _posix_interrupt_stack[(POSIX_THREADS_INTR_STACKSIZE/4)];
void*               _posix_interrupt_stack_top =
                        &_posix_interrupt_stack[((POSIX_THREADS_INTR_STACKSIZE/4)-2)];


/* bootup stack buffer */
#define _POSIX_BOOT_STACK_SIZE                               600
uint32_t   _posix_boot_stack[_POSIX_BOOT_STACK_SIZE/4];
void*      _posix_boot_stack_top =
           &_posix_boot_stack[(_POSIX_BOOT_STACK_SIZE/4)-1];

/* irq stack (only used in posix to keep some temporaries).
 * currently five words are stored here, let us make enough room.
 * posix does not want to rely on values given by the user in
 * linker options */
 int32_t _irq_exception_buffer[8];
 void*   _irq_exception_buffer_top = &_irq_exception_buffer[7];
#endif

typedef void(*native_handler)(void);
static  native_handler natives[32];

bool pal_architecture_set_native_handler( uint32_t number, void* handler )
{
    if ( number >= PAL_VARIANT_EXTERNAL_NUMBER ) return false;
    natives[number] = handler;
    return true;
}


void  arm_external_common_handler(uint32_t n)
{
    arm_current_irq = n;
    if ( natives[n] ) {
        natives[n]();
        return;
    }
#if ( __POSIX_KERNEL__ != 0 )
    if ( posix_interrupts_bitmask & (1 << n) )
    {
        pal_architecture_posix_interrupts_disable();
        pal_architecture_interrupts_enable();

        posix_interrupts_handler(n);

        pal_architecture_interrupts_disable();
        pal_architecture_posix_interrupts_enable();
        return;
    }
#endif
    interrupts_common_handler(n);
}

void  arm_clock_common_handler(void)
{
#if ( __POSIX_KERNEL__ !=0 )

    pal_architecture_timer_interrupt_acknowledge();
    pal_architecture_posix_interrupts_disable();
    pal_architecture_interrupts_enable();

    posix_clock_interrupt_handler();

    pal_architecture_interrupts_disable();
    pal_architecture_posix_interrupts_enable();

#elif ( TIMING_USETIMERS > 0 )
    pal_timers_common_handler();
 #endif

    return;
}

#if ( __POSIX_KERNEL__ !=0 )

__interrupt_irq __frame() void _posix_irq_handler(void)
{
    __asm(".extern _posix_irq_level");
    __asm(".extern _posix_current_thread");
    __asm(".extern  pal_variant_irq_handler");

    /* LR_irq   = address of next instruction + 4
     * SPSR_irq = CPSR
     * IRQ mode
     * ARM state
     * IRQ disabled
     */

    /* tmp stack
     * r0: preempted pc
     * r1: preempted cpsr
     * r2: irq sp
     * r3: tmp
     * r4: tmp
     */

    /* reset sp value to posix irq buffer */
    __asm("ldr     sp,=_irq_exception_buffer_top");
    __asm("ldr     sp,[sp]");

    /* store tmp r0-r4 */
    __asm("stmfd   sp!,{r0-r4}");
    /* irq sp */
    __asm("mov     r2,sp");
    /* next pc */
    __asm("sub     r0,lr,#4");
    /* next cpsr */
    __asm("mrs     r1,spsr");

    /* back to previous mode : svc mode (support for nested irq interrupts) */
    __asm("mrs     r3,cpsr");
    __asm("bic     r3,r3,#0x1F");
    __asm("orr     r3,r3,#0xD3");
    __asm("msr     cpsr_fsxc,r3");

    /* preempted svc sp value */
    __asm("mov r3, sp");

    /* push preempted context in running svc stack */
    /* push cpsr, pc */
    __asm("stmfd   sp!,{r0-r1}");
    /* push lr,sp */
    __asm("mov     r0,r3");
    __asm("mov     r1,lr");
    __asm("stmfd   sp!,{r0-r1}");
    /* push {r8-r12} */
    __asm("stmfd   sp!,{r8-r12}");
    /* push {r0-r7} */
    __asm("ldmfd   r2,{r0-r4}");
    __asm("stmfd   sp!,{r0-r7}");

    __asm("ldr   r3,=_posix_irq_level");
    __asm("ldr   r1,[r3]");
    __asm("cmp   r1, #0");
    __asm("add   r2,r1,#1");
    __asm("str   r2,[r3]");
    __asm("bne   _stack_save");
    __asm("ldr   r3,=_posix_current_thread");
    __asm("ldr   r1,[r3]");
    __asm("cmp   r1, #0");
    __asm("beq   _grey_area_save");
    __asm("str   sp, [r1]");
    __asm("ldr   r3,=_posix_interrupt_stack_top");
    __asm("ldr   sp,[r3]");
    __asm("b _stack_save");
    __asm("_grey_area_save:");
    __asm("ldr   r3,=_posix_interrupt_stack_top");
    __asm("mov   r1,sp");
    __asm("ldr   sp,[r3]");
    __asm("stmfd sp!,{r1}");

    __asm("_stack_save:");

    /* call common pal handler after posix context has been saved */
    __asm("bl      pal_variant_irq_handler");

    __asm("ldr   r3,=_posix_irq_level");
    __asm("ldr   r1,[r3]");
    __asm("cmp   r1,#1");
    __asm("sub   r2,r1,#1");
    __asm("str   r2,[r3]");
    __asm("bne   _stack_restore");
    __asm("ldr   r3,=_posix_current_thread");
    __asm("ldr   r1,[r3]");
    __asm("cmp   r1, #0");
    __asm("beq   _grey_area_restore");
    __asm("ldr   r3,=_posix_current_thread");
    __asm("ldr   r3,[r3]");
    __asm("ldr   sp, [r3]");
    __asm("b    _stack_restore");
    __asm("_grey_area_restore:");
    __asm("ldr   sp, [sp]");
    __asm("_stack_restore:");

   /* restore context */
    __asm("ldr     r0,[sp,#0x40]");
    __asm("msr     spsr_fsxc,r0");
    __asm("ldmfd   sp,{r0-r14,pc}^");

    /* never here */
    __asm("nop");

}

#else

__interrupt_irq  void _pal_irq_handler( void )
{
    pal_variant_irq_handler();
}

#endif


void arm7_extract_vector_table(void)
{
    return;
}



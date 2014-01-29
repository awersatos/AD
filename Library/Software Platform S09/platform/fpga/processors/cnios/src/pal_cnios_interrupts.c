#include <stdint.h>
#include <stdbool.h>
#include <pal.h>
#include "interrupts_cfg.h"

/*
 * Nios II Exception Processing
 *
 * Determining the Cause of Exceptions
 *
 * The exception handler must determine the cause of each exception and then
 * transfer control to the appropriate exception routine.
 *
 * Process to Determine the Cause of an Exception
 *
 * If the EPIE bit of the estatus register (ctl1) is 1 and the value of the
 * ipending register (ctl4) is non-zero, the exception was caused by an
 * external hardware interrupt and otherwise, the exception might have been
 * caused by a software trap or an unimplemented instruction
 * (we dont deal here with them).
 *
 * So if (EPIE == 1) & (ipending != 0)?     ->  Process hardware interrupt
 *
 * The Nios II architecture provides a simple, non-vectored exception
 * controller to handle all exception types. All exceptions, including
 * hardware interrupts, cause the processor to transfer to a single
 * exception address. The exception handler at this address determines
 * the cause of the exception and dispatches an appropriate exception
 * routine.
 *
 * Nested Exceptions
 *
 * Exception routines must take special precautions before:
 *  Re-enabling hardware interrupts
 * Before allowing any of these actions, the exception routine must save
 * estatus (ctl1) and ea (r29), so that they can be restored properly
 * before returning.
 *
 * Returning from an Exception
 *
 * The eret instruction is used to resume execution from the pre-exception
 * address. Except for the et register (r24), any registers modified during
 * exception processing must be restored by the exception routine before
 * returning from exception processing.
 * When executing the eret instruction, the processor:
 * 1. Copies the contents of estatus (ctl1) to status (ctl0)
 * 2. Transfers program execution to the address in the ea register (r29)
 *
 * Return Address
 *
 * The return address requires some consideration when returning from
 * exception processing routines. After an exception occurs, ea contains the
 * address of the instruction after the point where the exception was
 * generated.
 * On the other hand, hardware interrupt exceptions must resume execution
 * from the interrupted instruction itself. In this case, the exception handler
 * must subtract 4 from ea to point to the interrupted instruction.
 */
uint32_t            nios_current_interrupt;

#if ( __POSIX_KERNEL__ != 0 )

#include "posix_threads_cfg.h"

extern void*        _posix_current_thread;
extern uint32_t     posix_interrupts_bitmask;

static void         *nios_posix_preempted_stack;
int32_t             nios_posix_interrupt_stack[(POSIX_THREADS_INTR_STACKSIZE/4)];
void*               nios_posix_interrupt_stack_top = &nios_posix_interrupt_stack[((POSIX_THREADS_INTR_STACKSIZE/4)-2)];
volatile uint32_t   nios_posix_interrupts_savemask=0;

inline void nios_posix_interrupt_stack_swap(void)
{
   if (_posix_irq_level++ == 0)
    {
        if (_posix_current_thread != NULL)
        {
            __asm("ldw r1, %0"::"m"(_posix_current_thread));
            __asm("stw r27, 0(r1)");
        }
        else
        {
            __asm("stw r27, %0": "=m"(nios_posix_preempted_stack));
        }
        __asm("ldw r27, %0": : "m"(nios_posix_interrupt_stack_top));
    }
}

inline void nios_posix_interrupt_stack_restore(void)
{
   if (_posix_irq_level-- == 1)
    {
        if (_posix_current_thread != NULL)
        {
            __asm("ldw r1, %0": : "m"(_posix_current_thread));
            __asm("ldw r27, 0(r1)");
        }
        else
        {
            __asm("ldw r27, %0" : : "m"(&nios_posix_preempted_stack) : );
        }
    }
}
#endif

typedef void (*nios_native_handler_t)(void);
static  nios_native_handler_t  nios_native_table[PAL_ARCH_MAXINTRS];


#if ( __POSIX_KERNEL__ != 0 )

inline void nios_posix_interrupt_save_ctx(void)
{
    /* make room for the context */
    __asm("subi r27, r27, %0": : "i"(sizeof(nios_ctx_t)));

    /* save the current thread */
    __asm("stw r1, %0(r27)": : "i"(offsetof(nios_ctx_t, r1)) : );
    __asm("stw r2, %0(r27)": : "i"(offsetof(nios_ctx_t, r2)));
    __asm("stw r3, %0(r27)": : "i"(offsetof(nios_ctx_t, r3)));
    __asm("stw r4, %0(r27)": : "i"(offsetof(nios_ctx_t, r4)));
    __asm("stw r5, %0(r27)": : "i"(offsetof(nios_ctx_t, r5)));
    __asm("stw r6, %0(r27)": : "i"(offsetof(nios_ctx_t, r6)));
    __asm("stw r7, %0(r27)": : "i"(offsetof(nios_ctx_t, r7)));
    __asm("stw r8, %0(r27)": : "i"(offsetof(nios_ctx_t, r8)));
    __asm("stw r9, %0(r27)": : "i"(offsetof(nios_ctx_t, r9)));
    __asm("stw r10, %0(r27)": : "i"(offsetof(nios_ctx_t, r10)));
    __asm("stw r11, %0(r27)": : "i"(offsetof(nios_ctx_t, r11)));
    __asm("stw r12, %0(r27)": : "i"(offsetof(nios_ctx_t, r12)));
    __asm("stw r13, %0(r27)": : "i"(offsetof(nios_ctx_t, r13)));
    __asm("stw r14, %0(r27)": : "i"(offsetof(nios_ctx_t, r14)));
    __asm("stw r15, %0(r27)": : "i"(offsetof(nios_ctx_t, r15)));
    __asm("stw r16, %0(r27)": : "i"(offsetof(nios_ctx_t, r16)));
    __asm("stw r17, %0(r27)": : "i"(offsetof(nios_ctx_t, r17)));
    __asm("stw r18, %0(r27)": : "i"(offsetof(nios_ctx_t, r18)));
    __asm("stw r19, %0(r27)": : "i"(offsetof(nios_ctx_t, r19)));
    __asm("stw r20, %0(r27)": : "i"(offsetof(nios_ctx_t, r20)));
    __asm("stw r21, %0(r27)": : "i"(offsetof(nios_ctx_t, r21)));
    __asm("stw r22, %0(r27)": : "i"(offsetof(nios_ctx_t, r22)));
    __asm("stw r23, %0(r27)": : "i"(offsetof(nios_ctx_t, r23)));
    __asm("stw r24, %0(r27)": : "i"(offsetof(nios_ctx_t, r24)));
#if 0
    __asm("stw r25, %0(r27)": : "i"(offsetof(nios_ctx_t, r25)));
    __asm("stw r26, %0(r27)": : "i"(offsetof(nios_ctx_t, r26)));
#endif
    /*__asm("stw r27, %0(r27)": : "i"(offsetof(nios_ctx_t, r27)));*/
    __asm("stw r28, %0(r27)": : "i"(offsetof(nios_ctx_t, r28)));
    /* correct the return address */
    __asm("addi r29, r29, -4");
    __asm("stw r29, %0(r27)": : "i"(offsetof(nios_ctx_t, r29)));
#if 0
    __asm("stw r30, %0(r27)": : "i"(offsetof(nios_ctx_t, r30)));
#endif
    __asm("stw r31, %0(r27)": : "i"(offsetof(nios_ctx_t, r31)));

}

inline void nios_posix_interrupt_restore_ctx(void)
{
   /* return to the current thread */
    __asm("ldw r1, %0(r27)": : "i"(offsetof(nios_ctx_t, r1)));
    __asm("ldw r2, %0(r27)": : "i"(offsetof(nios_ctx_t, r2)));
    __asm("ldw r3, %0(r27)": : "i"(offsetof(nios_ctx_t, r3)));
    __asm("ldw r4, %0(r27)": : "i"(offsetof(nios_ctx_t, r4)));
    __asm("ldw r5, %0(r27)": : "i"(offsetof(nios_ctx_t, r5)));
    __asm("ldw r6, %0(r27)": : "i"(offsetof(nios_ctx_t, r6)));
    __asm("ldw r7, %0(r27)": : "i"(offsetof(nios_ctx_t, r7)));
    __asm("ldw r8, %0(r27)": : "i"(offsetof(nios_ctx_t, r8)));
    __asm("ldw r9, %0(r27)": : "i"(offsetof(nios_ctx_t, r9)));
    __asm("ldw r10, %0(r27)": : "i"(offsetof(nios_ctx_t, r10)));
    __asm("ldw r11, %0(r27)": : "i"(offsetof(nios_ctx_t, r11)));
    __asm("ldw r12, %0(r27)": : "i"(offsetof(nios_ctx_t, r12)));
    __asm("ldw r13, %0(r27)": : "i"(offsetof(nios_ctx_t, r13)));
    __asm("ldw r14, %0(r27)": : "i"(offsetof(nios_ctx_t, r14)));
    __asm("ldw r15, %0(r27)": : "i"(offsetof(nios_ctx_t, r15)));
    __asm("ldw r16, %0(r27)": : "i"(offsetof(nios_ctx_t, r16)));
    __asm("ldw r17, %0(r27)": : "i"(offsetof(nios_ctx_t, r17)));
    __asm("ldw r18, %0(r27)": : "i"(offsetof(nios_ctx_t, r18)));
    __asm("ldw r19, %0(r27)": : "i"(offsetof(nios_ctx_t, r19)));
    __asm("ldw r20, %0(r27)": : "i"(offsetof(nios_ctx_t, r20)));
    __asm("ldw r21, %0(r27)": : "i"(offsetof(nios_ctx_t, r21)));
    __asm("ldw r22, %0(r27)": : "i"(offsetof(nios_ctx_t, r22)));
    __asm("ldw r23, %0(r27)": : "i"(offsetof(nios_ctx_t, r23)));
    __asm("ldw r24, %0(r27)": : "i"(offsetof(nios_ctx_t, r24)));
#if 0
    __asm("ldw r25, %0(r27)": : "i"(offsetof(nios_ctx_t, r25)));
    __asm("ldw r26, %0(r27)": : "i"(offsetof(nios_ctx_t, r26)));
#endif
    /*__asm("ldw r27, %0(r27)": : "i"(offsetof(nios_ctx_t, r27)));*/
    __asm("ldw r28, %0(r27)": : "i"(offsetof(nios_ctx_t, r28)));
    __asm("ldw r29, %0(r27)": : "i"(offsetof(nios_ctx_t, r29)));
#if 0
    __asm("ldw r30, %0(r27)": : "i"(offsetof(nios_ctx_t, r30)));
#endif
    __asm("ldw r31, %0(r27)": : "i"(offsetof(nios_ctx_t, r31)));

    /* fix the stack */
    __asm("addi r27, r27, %0": : "i"(sizeof(nios_ctx_t)));

    /* return */
    __asm("eret");
}

#endif

#if ( __POSIX_KERNEL__ == 0 )

inline void nios_common_interrupt_handler(uint32_t number)
{
    nios_current_interrupt = number;
    if ( nios_native_table[number] )
    {
        nios_native_table[number]();
        return;
    }
    #if ( __TIMERS__ > 0 )
    if (number == PAL_ARCH_NIOS_TIMER_INTERRUPT_NUMBER )
    {
        pal_timers_common_handler();
        return;
    }
    #endif
    interrupts_common_handler(number);
}

#else

inline void nios_common_interrupt_handler(uint32_t number)
{
    nios_current_interrupt = number;
    if ( nios_native_table[number] )
    {
        nios_native_table[number]();
    }
    else if (number == PAL_ARCH_NIOS_TIMER_INTERRUPT_NUMBER )
    {
        pal_architecture_timer_interrupt_acknowledge();
        nios_posix_interrupts_internal_disable();
        pal_architecture_interrupts_enable();
        nios_posix_interrupt_stack_swap();
        posix_clock_interrupt_handler();
        nios_posix_interrupt_stack_restore();
        pal_architecture_interrupts_disable();
        nios_posix_interrupts_internal_enable();
    }
    else if ( posix_interrupts_bitmask & (1<<number) )
    {
        nios_posix_interrupt_stack_swap();
        posix_interrupts_handler(number);
        nios_posix_interrupt_stack_restore();
        pal_architecture_interrupts_disable();
        nios_posix_interrupts_internal_enable();
    }
    else
    {
        interrupts_common_handler(number);
    }
    return;
}

#endif


#define INT_MASK(n)                             (1<<n)
#define INTR_MASK                               (PAL_INTERRUPT_CONTROL_CFG | INTERRUPTS_APPLICATION_MASK)
#define HAS_CLOCK                               ( (__POSIX_KERNEL__!=0) || (__TIMERS__!=0) )
#define IS_CLOCK(n)                             ( HAS_CLOCK && (n==PAL_ARCH_CLOCK_INTNO) )
#define GENERATE_NIOS_INTERRUPT_HANDLER(n)      ( (INTR_MASK & INT_MASK(n)) || (IS_CLOCK(n)) )
#define INTERRUPT_NIOS_HANDLER(num)                                         \
        if ( (1<<num) &  mask )                    \
           nios_common_interrupt_handler(num);

#if ( __POSIX_KERNEL__ == 0 )
#define __FRAME()
#define INTERRUPT_SAVE_CTX()
#define INTERRUPT_RESTORE_CTX()               __asm("addi r29,r29,-4");
#else
#define __FRAME()                             __frame()
#define INTERRUPT_SAVE_CTX()                  nios_posix_interrupt_save_ctx();
#define INTERRUPT_RESTORE_CTX()               nios_posix_interrupt_restore_ctx();
#endif


static uint32_t mask;

__interrupt( NIOS2_EXCEPTION_ADDRESS ) __FRAME() void nios_external_interrupt(void)  __at(NIOS2_EXCEPTION_ADDRESS)
{

    INTERRUPT_SAVE_CTX()

    mask = nios_get_pending_interrupts();

    /* although uglier it is considerably faster than a while loop with 32 tests */
    #if GENERATE_NIOS_INTERRUPT_HANDLER( 1 )
    INTERRUPT_NIOS_HANDLER(1)
    #endif
    #if GENERATE_NIOS_INTERRUPT_HANDLER( 2 )
    INTERRUPT_NIOS_HANDLER(2)
    #endif
    #if GENERATE_NIOS_INTERRUPT_HANDLER( 3 )
    INTERRUPT_NIOS_HANDLER(3)
    #endif
    #if GENERATE_NIOS_INTERRUPT_HANDLER( 4 )
    INTERRUPT_NIOS_HANDLER(4)
    #endif
    #if GENERATE_NIOS_INTERRUPT_HANDLER( 5 )
    INTERRUPT_NIOS_HANDLER(5)
    #endif
    #if GENERATE_NIOS_INTERRUPT_HANDLER( 6 )
    INTERRUPT_NIOS_HANDLER(6)
    #endif
    #if GENERATE_NIOS_INTERRUPT_HANDLER( 7 )
    INTERRUPT_NIOS_HANDLER(7)
    #endif
    #if GENERATE_NIOS_INTERRUPT_HANDLER( 8 )
    INTERRUPT_NIOS_HANDLER(8)
    #endif
    #if GENERATE_NIOS_INTERRUPT_HANDLER( 9 )
    INTERRUPT_NIOS_HANDLER(9)
    #endif
    #if GENERATE_NIOS_INTERRUPT_HANDLER( 10 )
    INTERRUPT_NIOS_HANDLER(11)
    #endif
    #if GENERATE_NIOS_INTERRUPT_HANDLER( 12 )
    INTERRUPT_NIOS_HANDLER(12)
    #endif
    #if GENERATE_NIOS_INTERRUPT_HANDLER( 13 )
    INTERRUPT_NIOS_HANDLER(13)
    #endif
    #if GENERATE_NIOS_INTERRUPT_HANDLER( 14 )
    INTERRUPT_NIOS_HANDLER(14)
    #endif
    #if GENERATE_NIOS_INTERRUPT_HANDLER( 15 )
    INTERRUPT_NIOS_HANDLER(15)
    #endif
    #if GENERATE_NIOS_INTERRUPT_HANDLER( 16 )
    INTERRUPT_NIOS_HANDLER(16)
    #endif
    #if GENERATE_NIOS_INTERRUPT_HANDLER( 17 )
    INTERRUPT_NIOS_HANDLER(17)
    #endif
    #if GENERATE_NIOS_INTERRUPT_HANDLER( 18 )
    INTERRUPT_NIOS_HANDLER(18)
    #endif
    #if GENERATE_NIOS_INTERRUPT_HANDLER( 19 )
    INTERRUPT_NIOS_HANDLER(19)
    #endif
    #if GENERATE_NIOS_INTERRUPT_HANDLER( 20 )
    INTERRUPT_NIOS_HANDLER(20)
    #endif
    #if GENERATE_NIOS_INTERRUPT_HANDLER( 21 )
    INTERRUPT_NIOS_HANDLER(21)
    #endif
    #if GENERATE_NIOS_INTERRUPT_HANDLER( 22 )
    INTERRUPT_NIOS_HANDLER(23)
    #endif
    #if GENERATE_NIOS_INTERRUPT_HANDLER( 24 )
    INTERRUPT_NIOS_HANDLER(24)
    #endif
    #if GENERATE_NIOS_INTERRUPT_HANDLER( 25 )
    INTERRUPT_NIOS_HANDLER(25)
    #endif
    #if GENERATE_NIOS_INTERRUPT_HANDLER( 26 )
    INTERRUPT_NIOS_HANDLER(27)
    #endif
    #if GENERATE_NIOS_INTERRUPT_HANDLER( 28 )
    INTERRUPT_NIOS_HANDLER(28)
    #endif
    #if GENERATE_NIOS_INTERRUPT_HANDLER( 29 )
    INTERRUPT_NIOS_HANDLER(29)
    #endif
    #if GENERATE_NIOS_INTERRUPT_HANDLER( 30 )
    INTERRUPT_NIOS_HANDLER(30)
    #endif
    #if GENERATE_NIOS_INTERRUPT_HANDLER( 31 )
    INTERRUPT_NIOS_HANDLER(31)
    #endif
    #if GENERATE_NIOS_INTERRUPT_HANDLER( 0 )
    INTERRUPT_NIOS_HANDLER(0)
    #endif

    INTERRUPT_RESTORE_CTX()

 }


void nios_extract_vector_table(void)
{
    return;
}

bool pal_architecture_set_native_handler( uint32_t number, void* handler )
{
    if ( (number < 0) || (number >= PAL_ARCH_MAXINTRS) )
        return false;

    nios_native_table[number] = (nios_native_handler_t)handler;
    return true;
}





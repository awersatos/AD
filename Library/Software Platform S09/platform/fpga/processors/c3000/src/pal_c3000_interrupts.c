#include <stdlib.h>
#include "pal.h"
#include "pal_arch_cfg.h"
#include "interrupts_cfg.h"

#define INT_MASK(n) (1<<n)
#define INTR_MASK   (PAL_INTERRUPT_CONTROL_CFG | INTERRUPTS_APPLICATION_MASK)
#define CLOCK_NO    PAL_ARCH_CLOCK_INTNO

#if ( __POSIX_KERNEL__ == 0 )

#define INTERRUPT_HANDLER_BODY(n)                                     \
    __interrupt(n)  void interrupt_##n##_handler(void)                \
    {                                                                 \
        interrupts_common_handler(n);                                 \
    }


#if ( __TIMERS__ > 0 )
__interrupt(CLOCK_NO) void pal_interrupt_clock_handler(void)
{
     pal_timers_common_handler();
}
#endif

#else

#define INTERRUPT_HANDLER_BODY(n)                                     \
    __interrupt(n)  void interrupt_##n##_handler(void)                \
    {                                                                 \
        __asm(".extern tsk3000_posix_interrupt_handler");             \
        __asm("sw  $ra, 0($sp)");                                     \
        __asm("sub $sp, $sp, 0x4");                                   \
        __asm("sw  $fp, 0($sp)");                                     \
        __asm("ori $fp,$zero,"#n" ");                                 \
        __asm("jal tsk3000_posix_interrupt_handler");                 \
        __asm("nop");                                                 \
    }

__interrupt(CLOCK_NO)  void interrupt_clock_handler(void)
    {
        __asm(".extern tsk3000_posix_clock_handler");
        __asm("sw  $ra, 0($sp)");
        __asm("sub $sp, $sp, 0x4");
        __asm("sw  $fp, 0($sp)");
        __asm("jal tsk3000_posix_clock_handler");
        __asm("nop");
    }

#endif

#define GENERATE_INTERRUPT_HANDLER( n )                               \
        ((INTR_MASK& INT_MASK(n)) && (CLOCK_NO != n ) )

#if GENERATE_INTERRUPT_HANDLER( 0 )
INTERRUPT_HANDLER_BODY(0)
#endif
#if GENERATE_INTERRUPT_HANDLER( 1 )
INTERRUPT_HANDLER_BODY(1)
#endif
#if GENERATE_INTERRUPT_HANDLER( 2 )
INTERRUPT_HANDLER_BODY(2)
#endif
#if GENERATE_INTERRUPT_HANDLER( 3 )
INTERRUPT_HANDLER_BODY(3)
#endif
#if GENERATE_INTERRUPT_HANDLER( 4 )
INTERRUPT_HANDLER_BODY(4)
#endif
#if GENERATE_INTERRUPT_HANDLER( 5 )
INTERRUPT_HANDLER_BODY(5)
#endif
#if GENERATE_INTERRUPT_HANDLER( 6 )
INTERRUPT_HANDLER_BODY(6)
#endif
#if GENERATE_INTERRUPT_HANDLER( 7 )
INTERRUPT_HANDLER_BODY(7)
#endif
#if GENERATE_INTERRUPT_HANDLER( 8 )
INTERRUPT_HANDLER_BODY(8)
#endif
#if GENERATE_INTERRUPT_HANDLER( 9 )
INTERRUPT_HANDLER_BODY(9)
#endif
#if GENERATE_INTERRUPT_HANDLER( 10 )
INTERRUPT_HANDLER_BODY(10)
#endif
#if GENERATE_INTERRUPT_HANDLER( 11 )
INTERRUPT_HANDLER_BODY(11)
#endif
#if GENERATE_INTERRUPT_HANDLER( 12 )
INTERRUPT_HANDLER_BODY(12)
#endif
#if GENERATE_INTERRUPT_HANDLER( 13 )
INTERRUPT_HANDLER_BODY(13)
#endif
#if GENERATE_INTERRUPT_HANDLER( 14 )
INTERRUPT_HANDLER_BODY(14)
#endif
#if GENERATE_INTERRUPT_HANDLER( 15 )
INTERRUPT_HANDLER_BODY(15)
#endif
#if GENERATE_INTERRUPT_HANDLER( 16 )
INTERRUPT_HANDLER_BODY(16)
#endif
#if GENERATE_INTERRUPT_HANDLER( 17 )
INTERRUPT_HANDLER_BODY(17)
#endif
#if GENERATE_INTERRUPT_HANDLER( 18 )
INTERRUPT_HANDLER_BODY(18)
#endif
#if GENERATE_INTERRUPT_HANDLER( 19 )
INTERRUPT_HANDLER_BODY(19)
#endif
#if GENERATE_INTERRUPT_HANDLER( 20 )
INTERRUPT_HANDLER_BODY(20)
#endif
#if GENERATE_INTERRUPT_HANDLER( 21 )
INTERRUPT_HANDLER_BODY(21)
#endif
#if GENERATE_INTERRUPT_HANDLER( 22 )
INTERRUPT_HANDLER_BODY(22)
#endif
#if GENERATE_INTERRUPT_HANDLER( 23 )
INTERRUPT_HANDLER_BODY(23)
#endif
#if GENERATE_INTERRUPT_HANDLER( 24 )
INTERRUPT_HANDLER_BODY(24)
#endif
#if GENERATE_INTERRUPT_HANDLER( 25 )
INTERRUPT_HANDLER_BODY(25)
#endif
#if GENERATE_INTERRUPT_HANDLER( 26 )
INTERRUPT_HANDLER_BODY(26)
#endif
#if GENERATE_INTERRUPT_HANDLER( 27 )
INTERRUPT_HANDLER_BODY(27)
#endif
#if GENERATE_INTERRUPT_HANDLER( 28 )
INTERRUPT_HANDLER_BODY(28)
#endif
#if GENERATE_INTERRUPT_HANDLER( 29 )
INTERRUPT_HANDLER_BODY(29)
#endif
#if GENERATE_INTERRUPT_HANDLER( 30 )
INTERRUPT_HANDLER_BODY(30)
#endif
#if GENERATE_INTERRUPT_HANDLER( 31 )
INTERRUPT_HANDLER_BODY(31)
#endif

void tsk3000_extract_vector_table(void) { return; }

#define VECTOR_TABLE_OFFSET             __mfc0(TSK3000_COP_ExceptionBase)
#define VECTOR_TABLE_SIZE_BYTES         8
#define OPCODE_ADDI_KT1_R0              0x341B0000
#define OPCODE_J                        0x08000000

bool pal_architecture_set_native_handler(uint32_t number, void *handler)
{
    if ((INTR_MASK & INT_MASK(number)) && !((uint32_t)handler & 0xF0000000))
    {
        uint32_t * vecaddress = (uint32_t*)(VECTOR_TABLE_OFFSET + number * VECTOR_TABLE_SIZE_BYTES);
        /* jump to native handler */
        *vecaddress++ = OPCODE_J | ((uint32_t)handler/4);
        /* store the interrupt vector number in $kt1 : OS reserved register */
        /* this instruction is executed in the branch delay slot, previous to the jump */
        *vecaddress  = OPCODE_ADDI_KT1_R0 | (uint32_t)number;
        return true;
    }
    return false;
}

void pal_architecture_interrupt_enable(uint32_t number)
{
    uint32_t status;

    status = __mfc0(TSK3000_COP_Status);
    if (status & TSK3000_Status_InterruptEnable)
    {
        pal_architecture_interrupts_disable();
        pal_architecture_interrupts_set_mask(pal_architecture_interrupts_get_mask() | (1 << number));
        pal_architecture_interrupts_enable();
    }
    else
    {
        pal_architecture_interrupts_set_mask(pal_architecture_interrupts_get_mask() | (1 << number));
    }
    return;
}

void pal_architecture_interrupt_disable(uint32_t number)
{
    uint32_t status;

    status = __mfc0(TSK3000_COP_Status);
    if (status & TSK3000_Status_InterruptEnable)
    {
        pal_architecture_interrupts_disable();
        pal_architecture_interrupts_set_mask(pal_architecture_interrupts_get_mask() & ~(1 << number));
        pal_architecture_interrupts_enable();
    }
    else
    {
        pal_architecture_interrupts_set_mask(pal_architecture_interrupts_get_mask() & ~(1 << number));
    }
    return;
}

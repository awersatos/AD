#include <stdlib.h>
#include "pal.h"
#include "pal_arch_cfg.h"
#include "interrupts_cfg.h"

#define INT_MASK(n) (1<<n)
#define INTR_MASK   (PAL_INTERRUPT_CONTROL_CFG | INTERRUPTS_APPLICATION_MASK)
#define CLOCK_NO    PAL_ARCH_CLOCK_INTNO


#define INTERRUPT_LOOP_BODY(m) __asm (              \
        ".section .text.intvec_" m "\n\t"           \
        ".align 4\n\t"                              \
        ".global _text_intvec_" m "\n"              \
        "_text_intvec_" m ": .type func\n\t"        \
        "j _text_intvec_" m "\n\t"                  \
        "nop\n\t"                                   \
        ".endsec ; End of section\n"                \
        );

#define GENERATE_INTERRUPT_LOOP( n )                               \
        ((INTR_MASK& INT_MASK(n)) || (CLOCK_NO == n ) )

#if GENERATE_INTERRUPT_LOOP( 0 )
INTERRUPT_LOOP_BODY("0000")
#endif
#if GENERATE_INTERRUPT_LOOP( 1 )
INTERRUPT_LOOP_BODY("0008")
#endif
#if GENERATE_INTERRUPT_LOOP( 2 )
INTERRUPT_LOOP_BODY("0010")
#endif
#if GENERATE_INTERRUPT_LOOP( 3 )
INTERRUPT_LOOP_BODY("0018")
#endif
#if GENERATE_INTERRUPT_LOOP( 4 )
INTERRUPT_LOOP_BODY("0020")
#endif
#if GENERATE_INTERRUPT_LOOP( 5 )
INTERRUPT_LOOP_BODY("0028")
#endif
#if GENERATE_INTERRUPT_LOOP( 6 )
INTERRUPT_LOOP_BODY("0030")
#endif
#if GENERATE_INTERRUPT_LOOP( 7 )
INTERRUPT_LOOP_BODY("0038")
#endif
#if GENERATE_INTERRUPT_LOOP( 8 )
INTERRUPT_LOOP_BODY("0040")
#endif
#if GENERATE_INTERRUPT_LOOP( 9 )
INTERRUPT_LOOP_BODY("0048")
#endif
#if GENERATE_INTERRUPT_LOOP( 10 )
INTERRUPT_LOOP_BODY("0050")
#endif
#if GENERATE_INTERRUPT_LOOP( 11 )
INTERRUPT_LOOP_BODY("0058")
#endif
#if GENERATE_INTERRUPT_LOOP( 12 )
INTERRUPT_LOOP_BODY("0060")
#endif
#if GENERATE_INTERRUPT_LOOP( 13 )
INTERRUPT_LOOP_BODY("0068")
#endif
#if GENERATE_INTERRUPT_LOOP( 14 )
INTERRUPT_LOOP_BODY("0070")
#endif
#if GENERATE_INTERRUPT_LOOP( 15 )
INTERRUPT_LOOP_BODY("0078")
#endif
#if GENERATE_INTERRUPT_LOOP( 16 )
INTERRUPT_LOOP_BODY("0080")
#endif
#if GENERATE_INTERRUPT_LOOP( 17 )
INTERRUPT_LOOP_BODY("0088")
#endif
#if GENERATE_INTERRUPT_LOOP( 18 )
INTERRUPT_LOOP_BODY("0090")
#endif
#if GENERATE_INTERRUPT_LOOP( 19 )
INTERRUPT_LOOP_BODY("0098")
#endif
#if GENERATE_INTERRUPT_LOOP( 20 )
INTERRUPT_LOOP_BODY("00a0")
#endif
#if GENERATE_INTERRUPT_LOOP( 21 )
INTERRUPT_LOOP_BODY("00a8")
#endif
#if GENERATE_INTERRUPT_LOOP( 22 )
INTERRUPT_LOOP_BODY("00b0")
#endif
#if GENERATE_INTERRUPT_LOOP( 23 )
INTERRUPT_LOOP_BODY("00b8")
#endif
#if GENERATE_INTERRUPT_LOOP( 24 )
INTERRUPT_LOOP_BODY("00c0")
#endif
#if GENERATE_INTERRUPT_LOOP( 25 )
INTERRUPT_LOOP_BODY("00c8")
#endif
#if GENERATE_INTERRUPT_LOOP( 26 )
INTERRUPT_LOOP_BODY("00d0")
#endif
#if GENERATE_INTERRUPT_LOOP( 27 )
INTERRUPT_LOOP_BODY("00d8")
#endif
#if GENERATE_INTERRUPT_LOOP( 28 )
INTERRUPT_LOOP_BODY("00e0")
#endif
#if GENERATE_INTERRUPT_LOOP( 29 )
INTERRUPT_LOOP_BODY("00e8")
#endif
#if GENERATE_INTERRUPT_LOOP( 30 )
INTERRUPT_LOOP_BODY("00f0")
#endif
#if GENERATE_INTERRUPT_LOOP( 31 )
INTERRUPT_LOOP_BODY("00f8")
#endif

#if ( __POSIX_KERNEL__ == 0 )
static __interrupt()  void interrupt_handler(void)
{
    uint32_t number;
    __asm("ori $a0,$k1,0" : "=r"(number));
    interrupts_common_handler(number);
}

#if ( __TIMERS__ > 0 )
static __interrupt() void pal_interrupt_clock_handler(void)
{
    pal_timers_common_handler();
}
#endif
#endif

void tsk3000_extract_vector_table(void) { return; }

#define VECTOR_TABLE_OFFSET             __mfc0(TSK3000_COP_ExceptionBase)
#define VECTOR_TABLE_SIZE_BYTES         8
#define OPCODE_ADDI_KT1_R0              0x341B0000
#define OPCODE_J                        0x08000000

void tsk3000_architecture_set_native_handler(uint32_t number, void *handler)
{
    uint32_t * vecaddress = (uint32_t*)(VECTOR_TABLE_OFFSET + number * VECTOR_TABLE_SIZE_BYTES);
    /* jump to native handler */
    *vecaddress++ = OPCODE_J | ((uint32_t)handler/4);
    /* store the interrupt vector number in $kt1 : OS reserved register */
    /* this instruction is executed in the branch delay slot, previous to the jump */
    *vecaddress  = OPCODE_ADDI_KT1_R0 | (uint32_t)number;
}

bool pal_architecture_set_native_handler(uint32_t number, void *handler)
{
    if ((INTR_MASK & INT_MASK(number)) && !((uint32_t)handler & 0xF0000000))
    {
        tsk3000_architecture_set_native_handler(number, handler);
        return true;
    }
    return false;
}

void tsk3000_patch_vector_table(void)
{
    for (int i=0; i < 32; i++)
        {
        if ((INTR_MASK & INT_MASK(i)) && (CLOCK_NO != i ) )
            {
#if ( __POSIX_KERNEL__ == 0 )
            tsk3000_architecture_set_native_handler(i,interrupt_handler);
#else
            extern __interrupt() void tsk3000_posix_interrupt_handler(void);
            tsk3000_architecture_set_native_handler(i,tsk3000_posix_interrupt_handler);
#endif
            }
        }

#if ( __POSIX_KERNEL__ == 0 )
#if ( __TIMERS__ > 0 )
    tsk3000_architecture_set_native_handler(CLOCK_NO,pal_interrupt_clock_handler);
#endif
#else
    extern __interrupt() void tsk3000_posix_clock_handler(void);
    tsk3000_architecture_set_native_handler(CLOCK_NO,tsk3000_posix_clock_handler);
#endif
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

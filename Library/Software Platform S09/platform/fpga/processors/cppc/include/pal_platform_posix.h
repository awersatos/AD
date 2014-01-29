
#ifndef _PAL_PLATFORM_POSIX_H
#define _PAL_PLATFORM_POSIX_H

#include <stdint.h>
#include <stddef.h>

#define _hal_MSR_DE_BIT                 0x00000200
#define _hal_MSR_ME_BIT                 0x00001000
#define _hal_MSR_EE_BIT                 0x00008000
#define _hal_MSR_CE_BIT                 0x00020000

#define _hal_STACKDOWNWARDS            1

typedef struct ppc405_ctx_t
{
        /* non-volatile GPR registers */
        uint32_t R31;
        uint32_t R30;
        uint32_t R29;
        uint32_t R28;
        uint32_t R27;
        uint32_t R26;
        uint32_t R25;
        uint32_t R24;
        uint32_t R23;
        uint32_t R22;
        uint32_t R21;
        uint32_t R20;
        uint32_t R19;
        uint32_t R18;
        uint32_t R17;
        uint32_t R16;
        uint32_t R15;
        uint32_t R14;

        /* XER,CR,CTR,LR : always saved in interrupts */
        uint32_t XER;
        uint32_t CR;
        uint32_t CTR;
        uint32_t LR;
        /* program counter/MSR: for exceptions and interrupts */
        uint32_t MSR;
        uint32_t PC;
        /* volatile GPR registers: always saved in interrupts */
        uint32_t R12;
        uint32_t R11;
        uint32_t R10;
        uint32_t R9;
        uint32_t R8;
        uint32_t R7;
        uint32_t R6;
        uint32_t R5;
        uint32_t R4;
         /* first arg */
        uint32_t R3;
        /* return link */
        uint32_t R0;
        /* prologue */
        uint32_t prologue0;
        uint32_t prologue1;

} ppc405_ctx_t;

inline void ppc405_interrupt_native_context_save(void)
{
  __asm("addi   %%r1,%%r1, %0 ": : "i"(offsetof(ppc405_ctx_t,R14)-offsetof(ppc405_ctx_t,R0)));

  __asm("stw    %%r12,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R12)-offsetof(ppc405_ctx_t,R14)));
  __asm("stw    %%r11,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R11)-offsetof(ppc405_ctx_t,R14)));
  __asm("stw    %%r10,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R10)-offsetof(ppc405_ctx_t,R14)));
  __asm("stw    %%r9 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R9)-offsetof(ppc405_ctx_t,R14)));
  __asm("stw    %%r8 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R8)-offsetof(ppc405_ctx_t,R14)));
  __asm("stw    %%r7 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R7)-offsetof(ppc405_ctx_t,R14)));
  __asm("stw    %%r6 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R6)-offsetof(ppc405_ctx_t,R14)));
  __asm("stw    %%r5 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R5)-offsetof(ppc405_ctx_t,R14)));
  __asm("stw    %%r4 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R4)-offsetof(ppc405_ctx_t,R14)));
  __asm("stw    %%r3 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R3)-offsetof(ppc405_ctx_t,R14)));
  __asm("stw    %%r0 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R0)-offsetof(ppc405_ctx_t,R14)));
  __asm("mfsrr0 %%r11");
  __asm("stw    %%r11,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,PC)-offsetof(ppc405_ctx_t,R14)));
  __asm("mfsrr1 %%r11");
  __asm("stw    %%r11,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,MSR)-offsetof(ppc405_ctx_t,R14)));
  __asm("mflr   %%r11");
  __asm("stw    %%r11,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,LR)-offsetof(ppc405_ctx_t,R14)));
  __asm("mfctr  %%r11");
  __asm("stw    %%r11,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,CTR)-offsetof(ppc405_ctx_t,R14)));
  __asm("mfcr   %%r11");
  __asm("stw    %%r11,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,CR)-offsetof(ppc405_ctx_t,R14)));
  __asm("mfxer  %%r11");
  __asm("stw    %%r11,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,XER)-offsetof(ppc405_ctx_t,R14)));

}

inline void ppc405_native_context_save(void)
{
  __asm("addi   %%r1,%%r1, %0 ": : "i"(offsetof(ppc405_ctx_t,R14)-offsetof(ppc405_ctx_t,R0)));

  __asm("stw    %%r12,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R12)-offsetof(ppc405_ctx_t,R14)));
  __asm("stw    %%r11,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R11)-offsetof(ppc405_ctx_t,R14)));
  __asm("stw    %%r10,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R10)-offsetof(ppc405_ctx_t,R14)));
  __asm("stw    %%r9 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R9)-offsetof(ppc405_ctx_t,R14)));
  __asm("stw    %%r8 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R8)-offsetof(ppc405_ctx_t,R14)));
  __asm("stw    %%r7 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R7)-offsetof(ppc405_ctx_t,R14)));
  __asm("stw    %%r6 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R6)-offsetof(ppc405_ctx_t,R14)));
  __asm("stw    %%r5 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R5)-offsetof(ppc405_ctx_t,R14)));
  __asm("stw    %%r4 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R4)-offsetof(ppc405_ctx_t,R14)));
  __asm("stw    %%r3 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R3)-offsetof(ppc405_ctx_t,R14)));
  __asm("stw    %%r0 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R0)-offsetof(ppc405_ctx_t,R14)));
  __asm("mflr   %%r11");
  __asm("stw    %%r11,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,PC)-offsetof(ppc405_ctx_t,R14)));
  __asm("mfmsr  %%r11");
  __asm("stw    %%r11,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,MSR)-offsetof(ppc405_ctx_t,R14)));
  __asm("mflr   %%r11");
  __asm("stw    %%r11,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,LR)-offsetof(ppc405_ctx_t,R14)));
  __asm("mfctr  %%r11");
  __asm("stw    %%r11,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,CTR)-offsetof(ppc405_ctx_t,R14)));
  __asm("mfcr   %%r11");
  __asm("stw    %%r11,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,CR)-offsetof(ppc405_ctx_t,R14)));
  __asm("mfxer  %%r11");
  __asm("stw    %%r11,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,XER)-offsetof(ppc405_ctx_t,R14)));

}



inline void ppc405_non_volatile_reg_save(void)
{
  __asm("addi   %%r1,%%r1, %0 ": : "i"(offsetof(ppc405_ctx_t,R31)-offsetof(ppc405_ctx_t,R14)));

  __asm("stw    %%r14,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R14)-offsetof(ppc405_ctx_t,R31)));
  __asm("stw    %%r15,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R15)-offsetof(ppc405_ctx_t,R31)));
  __asm("stw    %%r16,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R16)-offsetof(ppc405_ctx_t,R31)));
  __asm("stw    %%r17 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R17)-offsetof(ppc405_ctx_t,R31)));
  __asm("stw    %%r18 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R18)-offsetof(ppc405_ctx_t,R31)));
  __asm("stw    %%r19 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R19)-offsetof(ppc405_ctx_t,R31)));
  __asm("stw    %%r20 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R20)-offsetof(ppc405_ctx_t,R31)));
  __asm("stw    %%r21 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R21)-offsetof(ppc405_ctx_t,R31)));
  __asm("stw    %%r22 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R22)-offsetof(ppc405_ctx_t,R31)));
  __asm("stw    %%r23 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R23)-offsetof(ppc405_ctx_t,R31)));
  __asm("stw    %%r24 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R24)-offsetof(ppc405_ctx_t,R31)));
  __asm("stw    %%r25,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R25)-offsetof(ppc405_ctx_t,R31)));
  __asm("stw    %%r26,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R26)-offsetof(ppc405_ctx_t,R31)));
  __asm("stw    %%r27,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R27)-offsetof(ppc405_ctx_t,R31)));
  __asm("stw    %%r28,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R28)-offsetof(ppc405_ctx_t,R31)));
  __asm("stw    %%r29,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R29)-offsetof(ppc405_ctx_t,R31)));
  __asm("stw    %%r30,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R30)-offsetof(ppc405_ctx_t,R31)));
  __asm("stw    %%r31,%0(%%r1)": : "i"(0));

}

inline void ppc405_non_volatile_reg_restore(void)
{
  __asm("lwz    %%r31,%0(%%r1)" : : "i"(0));
  __asm("lwz    %%r30,%0(%%r1)" : : "i"(offsetof(ppc405_ctx_t,R30)-offsetof(ppc405_ctx_t,R31)));
  __asm("lwz    %%r29,%0(%%r1)" : : "i"(offsetof(ppc405_ctx_t,R29)-offsetof(ppc405_ctx_t,R31)));
  __asm("lwz    %%r28,%0(%%r1)" : : "i"(offsetof(ppc405_ctx_t,R28)-offsetof(ppc405_ctx_t,R31)));
  __asm("lwz    %%r27,%0(%%r1)" : : "i"(offsetof(ppc405_ctx_t,R27)-offsetof(ppc405_ctx_t,R31)));
  __asm("lwz    %%r26,%0(%%r1)" : : "i"(offsetof(ppc405_ctx_t,R26)-offsetof(ppc405_ctx_t,R31)));
  __asm("lwz    %%r25,%0(%%r1)" : : "i"(offsetof(ppc405_ctx_t,R25)-offsetof(ppc405_ctx_t,R31)));
  __asm("lwz    %%r24,%0(%%r1)" : : "i"(offsetof(ppc405_ctx_t,R24)-offsetof(ppc405_ctx_t,R31)));
  __asm("lwz    %%r23,%0(%%r1)" : : "i"(offsetof(ppc405_ctx_t,R23)-offsetof(ppc405_ctx_t,R31)));
  __asm("lwz    %%r22,%0(%%r1)" : : "i"(offsetof(ppc405_ctx_t,R22)-offsetof(ppc405_ctx_t,R31)));
  __asm("lwz    %%r21 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R21)-offsetof(ppc405_ctx_t,R31)));
  __asm("lwz    %%r20 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R20)-offsetof(ppc405_ctx_t,R31)));
  __asm("lwz    %%r19 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R19)-offsetof(ppc405_ctx_t,R31)));
  __asm("lwz    %%r18 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R18)-offsetof(ppc405_ctx_t,R31)));
  __asm("lwz    %%r17 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R17)-offsetof(ppc405_ctx_t,R31)));
  __asm("lwz    %%r16 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R16)-offsetof(ppc405_ctx_t,R31)));
  __asm("lwz    %%r15 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R15)-offsetof(ppc405_ctx_t,R31)));
  __asm("lwz    %%r14 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R14)-offsetof(ppc405_ctx_t,R31)));

  __asm("addi   %%r1,%%r1,%0  ": : "i"(offsetof(ppc405_ctx_t,R14)-offsetof(ppc405_ctx_t,R31)));
}


inline void ppc405_native_context_restore(void)
{
    // do not r3 as local ( here we do r12 )
  __asm("lwz    %%r11,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R11)-offsetof(ppc405_ctx_t,R14)));
  __asm("lwz    %%r10,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R10)-offsetof(ppc405_ctx_t,R14)));
  __asm("lwz    %%r9 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R9)-offsetof(ppc405_ctx_t,R14)));
  __asm("lwz    %%r8 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R8)-offsetof(ppc405_ctx_t,R14)));
  __asm("lwz    %%r7 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R7)-offsetof(ppc405_ctx_t,R14)));
  __asm("lwz    %%r6 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R6)-offsetof(ppc405_ctx_t,R14)));
  __asm("lwz    %%r5 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R5)-offsetof(ppc405_ctx_t,R14)));
  __asm("lwz    %%r4 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R4)-offsetof(ppc405_ctx_t,R14)));
  __asm("lwz    %%r3 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R3)-offsetof(ppc405_ctx_t,R14)));
  __asm("lwz    %%r0 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R0)-offsetof(ppc405_ctx_t,R14)));
  __asm("lwz    %%r12,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,PC)-offsetof(ppc405_ctx_t,R14)));
  __asm("mtsrr0 %%r12");
  __asm("lwz    %%r12,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,MSR)-offsetof(ppc405_ctx_t,R14)));
  __asm("ori    %%r12,%%r12,0x8000");
  __asm("mtsrr1\t %%r12");
  __asm("lwz    %%r12,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,LR)-offsetof(ppc405_ctx_t,R14)));
  __asm("mtlr   %%r12");
  __asm("lwz    %%r12,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,CTR)-offsetof(ppc405_ctx_t,R14)));
  __asm("mtctr  %%r12");
  __asm("lwz    %%r12,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,CR)-offsetof(ppc405_ctx_t,R14)));
  __asm("mtcr   %%r12");
  __asm("lwz    %%r12,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,XER)-offsetof(ppc405_ctx_t,R14)));
  __asm("mtxer  %%r12");
  __asm("lwz    %%r12 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R12)-offsetof(ppc405_ctx_t,R14)));
  __asm("addi   %%r1,%%r1, %0 ": : "i"(offsetof(ppc405_ctx_t,R0)-offsetof(ppc405_ctx_t,R14)));
}



inline void _hal_jump_main(void){
        __asm("bl       main");
}

extern void ppc405_init_ctx(void* (*)(void*),void*, void (*)(void*),void **);
#define _hal_init_ctx			ppc405_init_ctx
extern void ppc405_load_ctx( void *);
#define _hal_load_ctx			ppc405_load_ctx
extern void ppc405_switch_ctx( void **, void * );
#define _hal_switch_ctx			ppc405_switch_ctx

inline void ppc405_save_ctx(void)
{
        /* dont modify r3 value r3: __oldspptr       */

        ppc405_native_context_save();
        ppc405_non_volatile_reg_save();

        /* save sp in tcb */
        __asm("lis      %%r4,@ha(_posix_current_thread)");                          \
        __asm("la       %%r5,@lo(_posix_current_thread)(%%r4)");                    \
        __asm("lwzu     %%r6,0(%%r5)");                                             \
        __asm("stw      %%r1,0x0(%%r6)");                                           \

       /* prepare for next prologs */
       __asm("addi   %%r1,%%r1,-0x8");
}

#define _hal_save_ctx       	ppc405_save_ctx
extern void ppc405_load_asr_ctx(void**, void (*)(void*));
#define _hal_load_asr_ctx		ppc405_load_asr_ctx


#endif

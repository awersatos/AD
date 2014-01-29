#if ( __POSIX_KERNEL__ !=0 )

#include <stdlib.h>
#include "pal_platform_posix.h"
#include "posix_threads_cfg.h"

void ppc405_init_ctx(void* (*_entry)(void*),void*_argc, void (*_exit)(void*), void **__stack)
{
         ppc405_ctx_t* pctx =  ( ppc405_ctx_t*)
                (( char*)*__stack -sizeof(ppc405_ctx_t));
        pctx->PC               = (unsigned int)_entry;
        pctx->R3               = (unsigned int)_argc;
        pctx->LR               = (unsigned int)_exit;
        pctx->XER              = 0;
        pctx->CR               = 0;
        pctx->CTR              = 0;
        /* to be tested on real hardware : weird things happen with the simulator */
        pctx->MSR              = _hal_MSR_EE_BIT | _hal_MSR_ME_BIT | _hal_MSR_CE_BIT ;

#define  __DEBUG_CONTEXT_SWITCH__ 1
#if (__DEBUG_CONTEXT_SWITCH__ == 1)
        {
            int i;
            uint32_t * regptr;
            for (i=0, regptr = &(pctx->R31);i<18;i++, regptr++)
            {
                *regptr = (0x31-i);
            }
            for (i=0, regptr = &(pctx->R12);i<9;i++, regptr++)
            {
                *regptr = (0x12-i);
            }
        }
#endif
        *__stack        = ( void *)pctx;

}

void ppc405_load_ctx( void *_sptr)
{
        __asm(".extern ppc405_posix_interrupts_savemask");

        __asm("mr\t%%r1,%0"::"r"(_sptr));

        ppc405_non_volatile_reg_restore();

        __asm("lwz    %%r10,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R10)-offsetof(ppc405_ctx_t,R14)));
        __asm("lwz    %%r9 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R9)-offsetof(ppc405_ctx_t,R14)));
        __asm("lwz    %%r8 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R8)-offsetof(ppc405_ctx_t,R14)));
        __asm("lwz    %%r7 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R7)-offsetof(ppc405_ctx_t,R14)));
        __asm("lwz    %%r6 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R6)-offsetof(ppc405_ctx_t,R14)));
        __asm("lwz    %%r5 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R5)-offsetof(ppc405_ctx_t,R14)));
        __asm("lwz    %%r4 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R4)-offsetof(ppc405_ctx_t,R14)));
        __asm("lwz    %%r3 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R3)-offsetof(ppc405_ctx_t,R14)));

        // disable ee native interrupts
        __asm("wrteei 0");

        __asm("mfdcr %%r11, 0");  // interrupt mask

        __asm("lis	%%r12,@ha(ppc405_posix_interrupts_savemask)");
        __asm("lwz	%%r12,@lo(ppc405_posix_interrupts_savemask)(%%r12)");  // saved posix interrupts
        __asm("or	%%r11,%%r11,%%r12");
        __asm("mtdcr 0, %%r11 ");

        // enable pit
        __asm("mfspr	%%r11,986");
        __asm("oris	%%r11,%%r11,0x400");
        __asm("mtspr	986,%%r11");

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

        // finally restore r11/r12
        __asm("lwz    %%r11 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R11)-offsetof(ppc405_ctx_t,R14)));
        __asm("lwz    %%r12 ,%0(%%r1)": : "i"(offsetof(ppc405_ctx_t,R12)-offsetof(ppc405_ctx_t,R14)));

        __asm("addi   %%r1,%%r1, %0 ": : "i"(offsetof(ppc405_ctx_t,R0)-offsetof(ppc405_ctx_t,R14)));


        /* r1 must point to same value as when pthread was preemted */
//        __asm("addi   %%r1,%%r1,0x8");
        __asm("rfi");
}

void ppc405_switch_ctx( void ** __oldspptr, void * _nextsptr)
{

        /* save running pthread */

        /* dont modify r3/r4 values */
        /* r3: __oldspptr       */
        /* r4: _nextspptr       */

        ppc405_native_context_save();
        ppc405_non_volatile_reg_save();

        /* store new stack value in __oldspptr */
       __asm("stw    %%r1,0(%0)"::"r"(__oldspptr));

        /* load next runnable */
        ppc405_load_ctx(_nextsptr);

        /* never here */
        return;
}

void ppc405_load_asr_ctx(void** __sptr,void (*_asrhandler)(void*))
{
        ppc405_ctx_t* pctx;

        pctx =  ( ppc405_ctx_t*)(((char*)*__sptr) -sizeof(ppc405_ctx_t));
        pctx->PC               = (uintptr_t)_asrhandler;
        pctx->R3               = (uintptr_t)*__sptr;
        pctx->LR               = (uintptr_t)ppc405_load_ctx;
        pctx->XER              = 0;
        pctx->CR               = 0;
        pctx->CTR              = 0;
        pctx->MSR              = _hal_MSR_EE_BIT | _hal_MSR_ME_BIT | _hal_MSR_CE_BIT;\
        * __sptr                = pctx;
}

#endif

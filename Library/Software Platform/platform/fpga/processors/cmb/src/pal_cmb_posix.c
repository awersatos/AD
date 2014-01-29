#if ( __POSIX_KERNEL__ > 0 )

#include <string.h>
#include <stdint.h>
#include "pal_arch.h"
#include "posix_threads_cfg.h"

void microblaze_init_ctx(void* (*_entry)(void*),void*_argc,
                               void (*_exit)(void*), void **__stack)
{
    microblaze_ctx_t* pctx =  ( microblaze_ctx_t*)
                      (( char*)*__stack -sizeof(microblaze_ctx_t));
    unsigned long   r13;

    /* arg */
    pctx->r3    = (unsigned int)_argc;
    /* dont touch anchor register */
    __asm("addik    %0, r13, 0" : "=r"(r13) : : );
    pctx->r13   = r13;
    /* 32-bit r14 reg used to store return addresses for interrupts */
    pctx->r14   = (unsigned int)_entry;
    /* exit: uses 'bralid/nop' to call: r15 stores the PC back then: 8 less */
    pctx->r15   = (unsigned int)(_exit) - 8;
    /* machine status register: IE, EE enabled */
    pctx->msr   = _hal_MSR_IE_BIT | _hal_MSR_EE_BIT ;

    *__stack        = ( void *)pctx;

}

void microblaze_load_ctx( void *_sptr)
{
    __asm(".extern microblaze_posix_interrupts_savemask");
    /* restore the registers for the context */
    __asm("lw   r1, %0, r0" : : "r"(&_sptr) : );

    microblaze_restore_callee();

    __asm("lwi  r15, r1, %0" : : "i"( offsetof(microblaze_ctx_t, r15) - offsetof(microblaze_ctx_t, msr) ) : );
    __asm("lwi  r13, r1, %0" : : "i"( offsetof(microblaze_ctx_t, r13) - offsetof(microblaze_ctx_t, msr) ) : );
    __asm("lwi  r12, r1, %0" : : "i"( offsetof(microblaze_ctx_t, r12) - offsetof(microblaze_ctx_t, msr) ) : );
    __asm("lwi  r11, r1, %0" : : "i"( offsetof(microblaze_ctx_t, r11) - offsetof(microblaze_ctx_t, msr) ) : );
    __asm("lwi  r10, r1, %0" : : "i"( offsetof(microblaze_ctx_t, r10) - offsetof(microblaze_ctx_t, msr) ) : );
    __asm("lwi  r9, r1, %0"  : : "i"( offsetof(microblaze_ctx_t, r9)  - offsetof(microblaze_ctx_t, msr) ) : );
    __asm("lwi  r8, r1, %0"  : : "i"( offsetof(microblaze_ctx_t, r8)  - offsetof(microblaze_ctx_t, msr) ) : );
    __asm("lwi  r7, r1, %0"  : : "i"( offsetof(microblaze_ctx_t, r7)  - offsetof(microblaze_ctx_t, msr) ) : );
    __asm("lwi  r6, r1, %0"  : : "i"( offsetof(microblaze_ctx_t, r6)  - offsetof(microblaze_ctx_t, msr) ) : );
    __asm("lwi  r5, r1, %0"  : : "i"( offsetof(microblaze_ctx_t, r5)  - offsetof(microblaze_ctx_t, msr) ) : );
    __asm("lwi  r2, r1, %0"  : : "i"( offsetof(microblaze_ctx_t, r2)  - offsetof(microblaze_ctx_t, msr) ) : );

    // microblaze_interrupts_disable();
    __asm("mfs  r3,  rmsr");
    __asm("andi r3,r3,-3");
    __asm("mts  rmsr, r3");

    //microblaze_posix_interrupts_internal_enable();
    __asm("lwi      r3,r13,microblaze_posix_interrupts_savemask-_base_r13");
    __asm("addik    r4,r0,-248");
    __asm("sw       r3,r4,r0");

    /* restore r4 */
    __asm("lwi  r4, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r4) - offsetof(microblaze_ctx_t, msr) ) : );
    /* restore r3 */
    __asm("lwi  r3, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r3) - offsetof(microblaze_ctx_t, msr) ) : );

    /* use r14 to restore msr */
    __asm("lwi  r14, r1, %0" : : "i"(0) : );
    /* clear IE bit: restore later with rtid */
    __asm("andni r14, r14, 2");
    __asm("mts   rmsr, r14");
    /* restore r14 */
    __asm("lwi  r14, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r14) - offsetof(microblaze_ctx_t, msr) ) : );

   /* adjust the stack pointer */
    __asm("addik    r1, r1, %0" : : "i"(sizeof(microblaze_ctx_t)- offsetof(microblaze_ctx_t, msr) ) : );

    /* pc */
    __asm("rtid r14, 0");
    __asm("nop");
}

void microblaze_switch_ctx( void ** __oldspptr, void * _nextsptr)
{
    return;
}

void microblaze_load_asr_ctx(void** __sptr,void (*_asrhandler)(void*))
{
    microblaze_ctx_t* pctx = ( microblaze_ctx_t*)
                      (((char*)*__sptr) -sizeof(microblaze_ctx_t));
    unsigned long   r13;

    /* dont touch anchor register */
    __asm("addik    %0, r13, 0" : "=r"(r13) : : );
    pctx->r13   = r13;
    /* arg */
    pctx->r3    = (unsigned int)*__sptr;
    /* 32-bit r14 reg used to store return addresses for interrupts */
    pctx->r14   = (unsigned int)_asrhandler;
    /* exit: uses 'bralid/nop' to call: r15 stores the PC back then: 8 less */
    pctx->r15   = (unsigned int)((uintptr_t)microblaze_load_ctx) - 8;
    /* machine status register: IE, EE enabled */
    pctx->msr   = _hal_MSR_IE_BIT | _hal_MSR_EE_BIT ;

    *__sptr     = (void*)pctx;

}

extern void microblaze_save_thread_sp(void* sp)
{
    extern void* _posix_current_thread;
    * (uint32_t*) _posix_current_thread = (uint32_t)sp;
}

#endif // __POSIX_KERNEL__


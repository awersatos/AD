#if ( __POSIX_KERNEL__ !=0 )

#include <stdlib.h>
#include "pal_arch.h"
#include "pal_platform_posix.h"
#include "posix_threads_cfg.h"

void arm7_init_ctx ( void* (*_entry)(void*) , void* _argc,
                    void (*_exit)(void*) , void **__stack)
 {
    pal_ctx_t* pctx =  ( pal_ctx_t*) (( char*)*__stack - sizeof(pal_ctx_t));

    pctx->sp            = (uintptr_t)*__stack;
    pctx->reg0_10[0]    = (uintptr_t)_argc;
    pctx->lr            = (uintptr_t)_exit;
    pctx->pc            = (uintptr_t)_entry;
    /* arm mode / I F enabled */
    pctx->cpsr          =  ARM7_SVC_MODE;

    *__stack        = ( void *)pctx;

}


inline void arm7_local_load_ctx( void *_sptr)
{
    __asm("mov      r11,%0"::"r"(_sptr));
    __asm("mrs      r0,cpsr");
    __asm("orr      r0,r0,#0xC0");    __asm("msr      cpsr_fsxc,r0");
    __asm("ldr      r0,[r11,#0x40]");
    __asm("bic      r0,r0,#0xC0");
    __asm("msr      spsr_fsxc,r0");
    __asm("ldmfd    r11,{r0-r11,ip,sp,lr,pc}^");
}

void arm7_load_ctx( void *_sptr)
{
    pal_architecture_interrupts_disable();
    pal_architecture_posix_interrupts_enable();
    arm7_local_load_ctx(_sptr);
}


void arm7_switch_ctx( void ** __oldspptr, void * _nextsptr)
{
    /* r1 -> next thread sp
     * r0 -> address of save location for old thread */

    arm7_save_ctx();
    __asm("mov  r0, r1");
    arm7_local_load_ctx(_nextsptr);

    /* never here */
    return;
}

void arm7_load_asr_ctx(void** __sptr,void (*_asrhandler)(void*))
{
    pal_ctx_t* pctx =  ( pal_ctx_t*)
                (( char*)*__sptr -sizeof(pal_ctx_t));

    pctx->sp            = (uintptr_t)*__sptr;
    pctx->reg0_10[0]    = (uintptr_t)*__sptr;
    pctx->lr            = (uintptr_t)arm7_load_ctx;
    pctx->pc            = (uintptr_t)_asrhandler;
    /* arm mode / I F enabled */
    pctx->cpsr          = ARM7_SVC_MODE ;
    *__sptr     = (void*)pctx;

}

#endif

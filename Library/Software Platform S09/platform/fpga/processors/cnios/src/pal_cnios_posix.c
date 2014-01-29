
#if (__POSIX_KERNEL__ != 0 )

#include <stdlib.h>
#include "pal_arch.h"
#include "posix_threads_cfg.h"

void swap(void)
{
        __asm("mov r4, r2");
        __asm("ldw ra, 0(sp)");
        __asm("addi sp, sp, %0": : "i"(sizeof(void *)));
    __asm("ret");
}

extern void nios_init_ctx(void* (*_entry)(void*),void*_argc, void (*_exit)(void*), void **__stack)
{
    unsigned *routine;
    nios_ctx_t *pctx;
#ifdef NIOS_CTX_DEBUG
    static int cnt;
#endif

    routine = ((unsigned*)*__stack) - sizeof(unsigned*);
    *routine = (unsigned)_exit;

    pctx =  (nios_ctx_t*)(( char*)routine - sizeof(nios_ctx_t));

#ifdef NIOS_CTX_DEBUG
    cnt ++;
    pctx->r1    = 0x00100000 + cnt;
    pctx->r2    = 0x00200000 + cnt;
    pctx->r3    = 0x00300000 + cnt;
    pctx->r4    = 0x00400000 + cnt;
    pctx->r5    = 0x00500000 + cnt;
    pctx->r6    = 0x00600000 + cnt;
    pctx->r7    = 0x00700000 + cnt;
    pctx->r8    = 0x00800000 + cnt;
    pctx->r9    = 0x00900000 + cnt;
    pctx->r10   = 0x01000000 + cnt;
    pctx->r11   = 0x01100000 + cnt;
    pctx->r12   = 0x01200000 + cnt;
    pctx->r13   = 0x01300000 + cnt;
    pctx->r14   = 0x01400000 + cnt;
    pctx->r15   = 0x01500000 + cnt;
    pctx->r16   = 0x01600000 + cnt;
    pctx->r17   = 0x01700000 + cnt;
    pctx->r18   = 0x01800000 + cnt;
    pctx->r19   = 0x01900000 + cnt;
    pctx->r20   = 0x02000000 + cnt;
    pctx->r21   = 0x02100000 + cnt;
    pctx->r22   = 0x02200000 + cnt;
    pctx->r23   = 0x02300000 + cnt;
    pctx->r24   = 0x02400000 + cnt;
#if 0
    pctx->r25   = 0x02500000 + cnt;
    pctx->r26   = 0x02600000 + cnt;
    pctx->r27   = 0x02700000 + cnt;
#endif
    pctx->r28   = 0x02800000 + cnt;
    pctx->r29   = 0x02900000 + cnt;
#if 0
    pctx->r30   = 0x03000000 + cnt;
#endif
    pctx->r31   = 0x03100000 + cnt;
#endif

    /* arg */
    pctx->r4    = (unsigned int)_argc;

    /* 32-bit r29 reg used to store return addresses for interrupts */
    pctx->r29   = (unsigned int)_entry;

    /* exit, return to this address after _entry */
    /* return to swap that will copy r2 to r4 and then goto _exit that is already saved on the stack */
    pctx->r31   = (unsigned)swap;

    *__stack    = (void *)pctx;
}

extern void nios_load_ctx( void *_sptr)
{

    __asm(".extern nios_posix_interrupts_savemask");

    /* restore the registers for the context, set stack pointer first */
    __asm("mov  r27, %0" : : "r"(_sptr) : );

    /* setup estatus (ctl1) so interrupts get enabled when returning using "eret" */
    __asm("movi r31, 1");
    __asm("wrctl    estatus, r31");

    /* restore r31 */
    __asm("ldw  r31, %0(r27)" : : "i"(offsetof(nios_ctx_t, r31)) : );
#if 0
    /* restore r30 */
    __asm("ldw  r30, %0(r27)" : : "i"(offsetof(nios_ctx_t, r30)) : );
#endif
    /* restore r29 */
    __asm("ldw  r29, %0(r27)" : : "i"(offsetof(nios_ctx_t, r29)) : );
    /* restore r28 */
    __asm("ldw  r28, %0(r27)" : : "i"(offsetof(nios_ctx_t, r28)) : );
#if 0
    /* restore r27 */
    __asm("ldw  r27, %0(r27)" : : "i"(offsetof(nios_ctx_t, r27)) : );
    /* restore r26 */
    __asm("ldw  r26, %0(r27)" : : "i"(offsetof(nios_ctx_t, r26)) : );
    /* restore r25 */
    __asm("ldw  r25, %0(r27)" : : "i"(offsetof(nios_ctx_t, r25)) : );
#endif
    /* restore r24 */
    __asm("ldw  r24, %0(r27)" : : "i"(offsetof(nios_ctx_t, r24)) : );
    /* restore r23 */
    __asm("ldw  r23, %0(r27)" : : "i"(offsetof(nios_ctx_t, r23)) : );
    /* restore r22 */
    __asm("ldw  r22, %0(r27)" : : "i"(offsetof(nios_ctx_t, r22)) : );
    /* restore r21 */
    __asm("ldw  r21, %0(r27)" : : "i"(offsetof(nios_ctx_t, r21)) : );
    /* restore r20 */
    __asm("ldw  r20, %0(r27)" : : "i"(offsetof(nios_ctx_t, r20)) : );
    /* restore r19 */
    __asm("ldw  r19, %0(r27)" : : "i"(offsetof(nios_ctx_t, r19)) : );
    /* restore r18 */
    __asm("ldw  r18, %0(r27)" : : "i"(offsetof(nios_ctx_t, r18)) : );
    /* restore r17 */
    __asm("ldw  r17, %0(r27)" : : "i"(offsetof(nios_ctx_t, r17)) : );
    /* restore r16 */
    __asm("ldw  r16, %0(r27)" : : "i"(offsetof(nios_ctx_t, r16)) : );
    /* restore r15 */
    __asm("ldw  r15, %0(r27)" : : "i"(offsetof(nios_ctx_t, r15)) : );
    /* restore r14 */
    __asm("ldw  r14, %0(r27)" : : "i"(offsetof(nios_ctx_t, r14)) : );
    /* restore r13 */
    __asm("ldw  r13, %0(r27)" : : "i"(offsetof(nios_ctx_t, r13)) : );
    /* restore r12 */
    __asm("ldw  r12, %0(r27)" : : "i"(offsetof(nios_ctx_t, r12)) : );
    /* restore r11 */
    __asm("ldw  r11, %0(r27)" : : "i"(offsetof(nios_ctx_t, r11)) : );
    /* restore r10 */
    __asm("ldw  r10, %0(r27)" : : "i"(offsetof(nios_ctx_t, r10)) : );
    /* restore r9 */
    __asm("ldw  r9, %0(r27)" : : "i"(offsetof(nios_ctx_t, r9)) : );
    /* restore r8 */
    __asm("ldw  r8, %0(r27)" : : "i"(offsetof(nios_ctx_t, r8)) : );
    /* restore r7 */
    __asm("ldw  r7, %0(r27)" : : "i"(offsetof(nios_ctx_t, r7)) : );
    /* restore r6 */
    __asm("ldw  r6, %0(r27)" : : "i"(offsetof(nios_ctx_t, r6)) : );
    /* restore r5 */
    __asm("ldw  r5, %0(r27)" : : "i"(offsetof(nios_ctx_t, r5)) : );
    /* restore r4 */
    __asm("ldw  r4, %0(r27)" : : "i"(offsetof(nios_ctx_t, r4)) : );
    /* restore r1 */
    __asm("ldw  r1, %0(r27)" : : "i"(offsetof(nios_ctx_t, r1)) : );


    //nios_disable_interrupts();
    __asm("rdctl r2, ctl0");
    __asm("addi  r3,r0,-2");
    __asm("and   r2,r2,r3");
    __asm("wrctl ctl0, r2");
    //nios_posix_interrupts_internal_enable();
    __asm("ldw   r2,  nios_posix_interrupts_savemask");
    __asm("wrctl ctl3, r2");

    /* restore r3 */
    __asm("ldw  r3, %0(r27)" : : "i"(offsetof(nios_ctx_t, r3)) : );
    /* restore r2 */
    __asm("ldw  r2, %0(r27)" : : "i"(offsetof(nios_ctx_t, r2)) : );

    /* adjust the stack pointer */
    __asm("addi r27, r27, %0" : : "i"(sizeof(nios_ctx_t)) : );

    /* pc */
    __asm("eret");
    __asm("nop");
}

extern void nios_switch_ctx( void ** __oldspptr, void * _nextsptr)
{
    /* not implemented */
    return;
}

extern void nios_load_asr_ctx(void **__sptr, void (*_asrhandler)(void*))
{
    nios_ctx_t *pctx = (nios_ctx_t*)(((char*)*__sptr) - sizeof(nios_ctx_t));

    /* r4 stores first register parameter */
    pctx->r4    = (unsigned int)*__sptr;

    /* r29 stores return addresses for exceptions */
    pctx->r29   = (unsigned int)_asrhandler;

    /* r31 stores return address */
    pctx->r31   = (unsigned int)(nios_load_ctx);

    *__sptr      = pctx;
}

extern void nios_save_thread_sp(void* sp)
{
    extern void* _posix_current_thread;
    * (uint32_t*) _posix_current_thread = (uint32_t)sp;
}

#endif // __POSIX_KERNEL__



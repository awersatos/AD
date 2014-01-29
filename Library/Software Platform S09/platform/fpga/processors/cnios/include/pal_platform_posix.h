#ifndef _PAL_PLATFORM_POSIX_H
#define _PAL_PLATFORM_POSIX_H

#if ( __POSIX_KERNEL__ !=0 )

#include <stddef.h>          /* offsetof */
#include "posix_threads_cfg.h"

#define _hal_STACKDOWNWARDS            1

/* status bits */
#define _hal_STATUS_PIE_BIT         (1<<0)
#define _hal_STATUS_U_BIT           (1<<1)

/* estatus bits */
#define _hal_ESTATUS_EPIE_BIT       (1<<0)
#define _hal_ESTATUS_EU_BIT         (1<<1)

/* bstatus bits */
#define _hal_BSTATUS_BPIE_BIT       (1<<0)
#define _hal_BSTATUS_BU_BIT         (1<<1)


inline void _hal_jump_main(void)
{
    __asm(".extern main");
    __asm("call main");
    __asm("nop");
}

typedef struct _hal_ctx_t
{
#if 0
    unsigned int    r0;     /* zero, is alway 0 */
#endif
    unsigned int    r1;     /* at, Assembler Temporary */
    unsigned int    r2;     /* Return value (least significant 32 bits) */
    unsigned int    r3;     /* Return value (Most-significant 32 bits) */
    unsigned int    r4;     /* Register Arguments (First 32 bits) */
    unsigned int    r5;     /* Register Arguments (Second 32 bits) */
    unsigned int    r6;     /* Register Arguments (Third 32 bits) */
    unsigned int    r7;     /* Register Arguments (Fourth 32 bits) */
    unsigned int    r8;     /* Caller-Saved General-Purpose Registers */
    unsigned int    r9;
    unsigned int    r10;
    unsigned int    r11;
    unsigned int    r12;
    unsigned int    r13;
    unsigned int    r14;
    unsigned int    r15;
    unsigned int    r16;        /* Callee-Saved General-Purpose Registers */
    unsigned int    r17;
    unsigned int    r18;
    unsigned int    r19;
    unsigned int    r20;
    unsigned int    r21;
    unsigned int    r22;
    unsigned int    r23;
    unsigned int    r24;        /* et, Exception Temporary */
#if 0
    unsigned int    r25;        /* bt, Break Temporary */
    unsigned int    r26;        /* gp, Global Pointer */
    unsigned int    r27;        /* sp, Stack Pointer */
#endif
    unsigned int    r28;        /* fp, Frame Pointer */
    unsigned int    r29;        /* ea, Exception Return Address */
#if 0
    unsigned int    r30;        /* ba, Break Return Address */
#endif
    unsigned int    r31;        /* ra, Return Address */
} nios_ctx_t;


extern void nios_save_thread_sp(void* sp);

inline void nios_save_ctx( void )
{
    /* we saved r31 on the stack. just overwrite it */
  //  __asm("addi r27, r27, 4");

    /* save current context */

    /* adjust the stack pointer */
    __asm("addi r27, r27, %0" : : "i"(-(long)sizeof(nios_ctx_t)) : );

    /* save r31 */
    __asm("stw  r31, %0(r27)" : : "i"(offsetof(nios_ctx_t, r31)) : );
#if 0
    /* save r30 */
    __asm("stw  r30, %0(r27)" : : "i"(offsetof(nios_ctx_t, r30)) : );
#endif
    /* save r29, store r31 (return address) because loading uses eret to return */
    __asm("stw  r31, %0(r27)" : : "i"(offsetof(nios_ctx_t, r29)) : );
    /* save r28 */
    __asm("stw  r28, %0(r27)" : : "i"(offsetof(nios_ctx_t, r28)) : );
#if 0
    /* save r27 */
    __asm("stw  r27, %0(r27)" : : "i"(offsetof(nios_ctx_t, r27)) : );
    /* save r26 */
    __asm("stw  r26, %0(r27)" : : "i"(offsetof(nios_ctx_t, r26)) : );
    /* save r25 */
    __asm("stw  r25, %0(r27)" : : "i"(offsetof(nios_ctx_t, r25)) : );
#endif
    /* save r24 */
    __asm("stw  r24, %0(r27)" : : "i"(offsetof(nios_ctx_t, r24)) : );
    /* save r23 */
    __asm("stw  r23, %0(r27)" : : "i"(offsetof(nios_ctx_t, r23)) : );
    /* save r22 */
    __asm("stw  r22, %0(r27)" : : "i"(offsetof(nios_ctx_t, r22)) : );
    /* save r21 */
    __asm("stw  r21, %0(r27)" : : "i"(offsetof(nios_ctx_t, r21)) : );
    /* save r20 */
    __asm("stw  r20, %0(r27)" : : "i"(offsetof(nios_ctx_t, r20)) : );
    /* save r19 */
    __asm("stw  r19, %0(r27)" : : "i"(offsetof(nios_ctx_t, r19)) : );
    /* save r18 */
    __asm("stw  r18, %0(r27)" : : "i"(offsetof(nios_ctx_t, r18)) : );
    /* save r17 */
    __asm("stw  r17, %0(r27)" : : "i"(offsetof(nios_ctx_t, r17)) : );
    /* save r16 */
    __asm("stw  r16, %0(r27)" : : "i"(offsetof(nios_ctx_t, r16)) : );
    /* save r15 */
    __asm("stw  r15, %0(r27)" : : "i"(offsetof(nios_ctx_t, r15)) : );
    /* save r14 */
    __asm("stw  r14, %0(r27)" : : "i"(offsetof(nios_ctx_t, r14)) : );
    /* save r13 */
    __asm("stw  r13, %0(r27)" : : "i"(offsetof(nios_ctx_t, r13)) : );
    /* save r12 */
    __asm("stw  r12, %0(r27)" : : "i"(offsetof(nios_ctx_t, r12)) : );
    /* save r11 */
    __asm("stw  r11, %0(r27)" : : "i"(offsetof(nios_ctx_t, r11)) : );
    /* save r10 */
    __asm("stw  r10, %0(r27)" : : "i"(offsetof(nios_ctx_t, r10)) : );
    /* save r9 */
    __asm("stw  r9, %0(r27)" : : "i"(offsetof(nios_ctx_t, r9)) : );
    /* save r8 */
    __asm("stw  r8, %0(r27)" : : "i"(offsetof(nios_ctx_t, r8)) : );
    /* save r7 */
    __asm("stw  r7, %0(r27)" : : "i"(offsetof(nios_ctx_t, r7)) : );
    /* save r6 */
    __asm("stw  r6, %0(r27)" : : "i"(offsetof(nios_ctx_t, r6)) : );
    /* save r5 */
    __asm("stw  r5, %0(r27)" : : "i"(offsetof(nios_ctx_t, r5)) : );
    /* save r4 */
    __asm("stw  r4, %0(r27)" : : "i"(offsetof(nios_ctx_t, r4)) : );
    /* save r3 */
    __asm("stw  r3, %0(r27)" : : "i"(offsetof(nios_ctx_t, r3)) : );
    /* save r2 */
    __asm("stw  r2, %0(r27)" : : "i"(offsetof(nios_ctx_t, r2)) : );
    /* save r1 */
    __asm("stw  r1, %0(r27)" : : "i"(offsetof(nios_ctx_t, r1)) : );

    nios_save_thread_sp(pal_architecture_get_current_sp());

}

#define _hal_save_ctx           nios_save_ctx
extern void nios_init_ctx(void* (*)(void*),void*, void (*)(void*),void **);
#define _hal_init_ctx       nios_init_ctx
extern void nios_load_ctx( void *);
#define _hal_load_ctx       nios_load_ctx
extern void nios_switch_ctx( void **, void * );
#define _hal_switch_ctx     nios_switch_ctx
extern void nios_load_asr_ctx(void**, void (*)(void*));
#define _hal_load_asr_ctx   nios_load_asr_ctx

#endif // __POSIX_KERNEL__

#endif // _PLATFORM_POSIX_H



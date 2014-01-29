#ifndef _PAL_PLATFORM_POSIX_H
#define _PAL_PLATFORM_POSIX_H

#if ( __POSIX_KERNEL__ != 0 )

#include <stddef.h>          /* offsetof */

#define _hal_STACKDOWNWARDS            1

/* machine status register bit masks */
#define _hal_MSR_BE_BIT         0x1
#define _hal_MSR_IE_BIT         0x2
#define _hal_MSR_C_BIT          0x4
#define _hal_MSR_BIP_BIT        0x8
#define _hal_MSR_FSL_BIT        0x10
#define _hal_MSR_ICE_BIT        0x20
#define _hal_MSR_DZ_BIT         0x40
#define _hal_MSR_DCE_BIT        0x80
#define _hal_MSR_EE_BIT         0x100
#define _hal_MSR_EIP_BIT        0x200


inline void _hal_jump_main(void){
    __asm(".extern main");
        __asm("bralid  r15,main");
        __asm("nop");
}

typedef struct microblaze_ctx_t
{
    unsigned int    r19;
    unsigned int    r20;
    unsigned int    r21;
    unsigned int    r22;
    unsigned int    r23;
    unsigned int    r24;
    unsigned int    r25;
    unsigned int    r26;
    unsigned int    r27;
    unsigned int    r28;
    unsigned int    r29;
    unsigned int    r30;
    unsigned int    r31;
    /* The Machine Status Register contains control and
     * status bits for the processor */
    unsigned int    msr;
#if 0
    /* R0 is defined to always have the value of zero */.
    unsigned int    r0;
    /* saved in thread->sp */
    unsigned int    r1;
#endif
    unsigned int    r2;
    unsigned int    r3;
    unsigned int    r4;
    unsigned int    r5;
    unsigned int    r6;
    unsigned int    r7;
    unsigned int    r8;
    unsigned int    r9;
    unsigned int    r10;
    unsigned int    r11;
    unsigned int    r12;
    unsigned int    r13;
    unsigned int    r14;
    unsigned int    r15;
#if 0
    /* dedicated: return @ in hardware break */
    unsigned int    r16;
    /* dedicated: return @ exceptions */
    unsigned int    r17;
    /* reserved */
    unsigned int    r18;
#endif

} microblaze_ctx_t;

inline void microblaze_restore_callee(void)
{
    __asm("lwi      r31, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r31)) : );
    __asm("lwi      r30, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r30)) : );
    __asm("lwi      r29, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r29)) : );
    __asm("lwi      r28, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r28)) : );
    __asm("lwi      r27, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r27)) : );
    __asm("lwi      r26, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r26)) : );
    __asm("lwi      r25, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r25)) : );
    __asm("lwi      r24, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r24)) : );
    __asm("lwi      r23, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r23)) : );
    __asm("lwi      r22, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r22)) : );
    __asm("lwi      r21, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r21)) : );
    __asm("lwi      r20, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r20)) : );
    __asm("lwi      r19, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r19)) : );
    __asm("addik    r1,  r1, %0" : : "i"(offsetof(microblaze_ctx_t, msr)) : );
}

inline void microblaze_save_callee_internal(void)
{
    __asm("swi      r31, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r31)) : );
    __asm("swi      r30, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r30)) : );
    __asm("swi      r29, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r29)) : );
    __asm("swi      r28, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r28)) : );
    __asm("swi      r27, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r27)) : );
    __asm("swi      r26, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r26)) : );
    __asm("swi      r25, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r25)) : );
    __asm("swi      r24, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r24)) : );
    __asm("swi      r23, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r23)) : );
    __asm("swi      r22, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r22)) : );
    __asm("swi      r21, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r21)) : );
    __asm("swi      r20, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r20)) : );
    __asm("swi      r19, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r19)) : );
}

inline void microblaze_save_interrupt_callee(void)
{
    __asm("addik    r1, r1, %0" : : "i"( offsetof(microblaze_ctx_t, r31) - offsetof(microblaze_ctx_t, msr) ) : );
    microblaze_save_callee_internal();
}

extern void microblaze_save_thread_sp(void* sp);

inline void microblaze_save_ctx(void)
{
    /* the routine that called us saved r15 on the stack.
     * just overwrite it STILL NEEDED IF NO PARAMETERS? */
        __asm("addik    r1, r1, 4");

    /* save current context */
    __asm("addik    r1, r1, %0" : : "i"( -(long)sizeof(microblaze_ctx_t) ) : );
    microblaze_save_callee_internal();

    __asm("mfs      r31, rmsr");
    __asm("swi      r31, r1, %0" : : "i"(offsetof(microblaze_ctx_t, msr)) : );
    __asm("swi      r15, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r15)) : );
    /* save r14, we return using r14, store r15 + 8 */
    __asm("addik    r14, r15, 8");
    __asm("swi      r14, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r14)) : );
    __asm("swi      r13, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r13)) : );
    __asm("swi      r12, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r12)) : );
    __asm("swi      r11, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r11)) : );
    __asm("swi      r10, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r10)) : );
    __asm("swi      r9, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r9)) : );
    __asm("swi      r8, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r8)) : );
    __asm("swi      r7, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r7)) : );
    __asm("swi      r6, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r6)) : );
    __asm("swi      r5, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r5)) : );
    __asm("swi      r4, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r4)) : );
    __asm("swi      r3, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r3)) : );
    __asm("swi      r2, r1, %0" : : "i"(offsetof(microblaze_ctx_t, r2)) : );

    /* store the sp new value */
    //__asm(".extern _posix_current_thread");
    //microblaze___asm("lwi      r3,r13,_posix_current_thread-_base_r13");
    //__asm("sw       r1,r3,r0");
    microblaze_save_thread_sp(pal_architecture_get_current_sp());
}

#define _hal_save_ctx       microblaze_save_ctx
extern void microblaze_init_ctx(void* (*)(void*),void*, void (*)(void*),void **);
#define _hal_init_ctx       microblaze_init_ctx
extern void microblaze_load_ctx( void *);
#define _hal_load_ctx       microblaze_load_ctx
extern void microblaze_switch_ctx( void **, void * );
#define _hal_switch_ctx     microblaze_switch_ctx
extern void microblaze_load_asr_ctx(void**, void (*)(void*));
#define _hal_load_asr_ctx   microblaze_load_asr_ctx

#endif // __POSIX_KERNEL__

#endif // ifndef

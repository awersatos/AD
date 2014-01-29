#ifndef _PAL_PLATFORM_POSIX_H
#define _PAL_PLATFORM_POSIX_H

#include <stddef.h>          /* offsetof */
#include "posix_threads_cfg.h"

#define _hal_STACKDOWNWARDS            1

extern struct thread_t* _posix_current_thread;

inline void _hal_jump_main(void)
{
    __asm(".extern  main");
    __asm("jal      main");
    __asm("nop");
}

typedef struct __hal_ctx_t
{
    /* General Purpose Registers */
    unsigned int    null;       /* $0 */
    unsigned int    at;     /* $1 */
    unsigned int    v0;     /* $2 */
    unsigned int    v1;     /* $3 */
    unsigned int    a0;     /* $4 */
    unsigned int    a1;     /* $5 */
    unsigned int    a2;     /* $6 */
    unsigned int    a3;     /* $7 */
    unsigned int    t0;     /* $8 */
    unsigned int    t1;     /* $9 */

    unsigned int    t2;     /* $10 */
    unsigned int    t3;     /* $11 */
    unsigned int    t4;     /* $12 */
    unsigned int    t5;     /* $13 */
    unsigned int    t6;     /* $14 */
    unsigned int    t7;     /* $15 */
    unsigned int    s0;     /* $16 */
    unsigned int    s1;     /* $17 */
    unsigned int    s2;     /* $18 */
    unsigned int    s3;     /* $19 */

    unsigned int    s4;     /* $20 */
    unsigned int    s5;     /* $21 */
    unsigned int    s6;     /* $22 */
    unsigned int    s7;     /* $23 */
    unsigned int    t8;     /* $24 */
    unsigned int    t9;     /* $25 */
    unsigned int    k0;     /* $26 */
 //   unsigned int    k1;     /* $27 */
    unsigned int    gp;     /* $28 */
#if defined __HW_DIVIDE__ || defined __HW_MULTIPLY__
    unsigned int    hi;     /* $hi */
    unsigned int    lo;     /* $lo */
#endif
    unsigned int    sp;     /* $29 */
    unsigned int    fp;     /* $30 */
    unsigned int    ra;     /* $31 */
    unsigned int    ieop;  /* Interrupt Enable Old and Previous */
} _hal_ctx_t;

extern uint32_t _posix_resume_address;
extern uint32_t _posix_user_stack;

extern void tsk3000_init_ctx(void* (*)(void*),void*, void (*)(void*),void **);
#define _hal_init_ctx       tsk3000_init_ctx

// v0 and v1 are used for temporary storage and must be saved first
inline void tsk3000_V0_V1(void)
{
    __asm("sw $v0, %0($sp)": : "i"(offsetof(_hal_ctx_t, v0)));      /* $2 */
    __asm("sw $v1, %0($sp)": : "i"(offsetof(_hal_ctx_t, v1)));      /* $3 */
}

inline void tsk3000_AT_A0_ER_IE(void)
{
    __asm("sw $at, %0($sp)": : "i"(offsetof(_hal_ctx_t, at)));      /* $1 */
    __asm("sw $a0, %0($sp)": : "i"(offsetof(_hal_ctx_t, a0)));      /* $4 */
    __asm("sw $k0, %0($sp)": : "i"(offsetof(_hal_ctx_t, k0)));      /* $26 */

    // Interrupt Enable: old, previous and current
    __asm("mfc0     $v0, $Status");
    __asm("andi     $v1, $v0, 1");
    __asm("andi     $v0, $v0, 20");         // get ieo and iep
    __asm("beq      $v1, $0,  1n");         // nothing to do when iec is not set
    __asm("nop");                           // delayslot
    __asm("ori      $v0, $v0, 4");          // make sure iep is set to re-enable iec in rfe
__asm("1:");
    __asm("sw       $v0, %0($sp)": : "i"(offsetof(_hal_ctx_t, ieop))); /* IEo and IEp bits from $Status */
}

inline void tsk3000_SAVE_REG_REST(void)
{
    __asm("sw $a1, %0($sp)": : "i"(offsetof(_hal_ctx_t, a1)));      /* $5 */
    __asm("sw $a2, %0($sp)": : "i"(offsetof(_hal_ctx_t, a2)));      /* $6 */
    __asm("sw $a3, %0($sp)": : "i"(offsetof(_hal_ctx_t, a3)));      /* $7 */
    __asm("sw $t0, %0($sp)": : "i"(offsetof(_hal_ctx_t, t0)));      /* $8 */
    __asm("sw $t1, %0($sp)": : "i"(offsetof(_hal_ctx_t, t1)));      /* $9 */
    __asm("sw $t2, %0($sp)": : "i"(offsetof(_hal_ctx_t, t2)));      /* $10 */
    __asm("sw $t3, %0($sp)": : "i"(offsetof(_hal_ctx_t, t3)));      /* $11 */
    __asm("sw $t4, %0($sp)": : "i"(offsetof(_hal_ctx_t, t4)));      /* $12 */
    __asm("sw $t5, %0($sp)": : "i"(offsetof(_hal_ctx_t, t5)));      /* $13 */
    __asm("sw $t6, %0($sp)": : "i"(offsetof(_hal_ctx_t, t6)));      /* $14 */
    __asm("sw $t7, %0($sp)": : "i"(offsetof(_hal_ctx_t, t7)));      /* $15 */
    __asm("sw $s0, %0($sp)": : "i"(offsetof(_hal_ctx_t, s0)));      /* $16 */
    __asm("sw $s1, %0($sp)": : "i"(offsetof(_hal_ctx_t, s1)));      /* $17 */
    __asm("sw $s2, %0($sp)": : "i"(offsetof(_hal_ctx_t, s2)));      /* $18 */
    __asm("sw $s3, %0($sp)": : "i"(offsetof(_hal_ctx_t, s3)));      /* $19 */
    __asm("sw $s4, %0($sp)": : "i"(offsetof(_hal_ctx_t, s4)));      /* $20 */
    __asm("sw $s5, %0($sp)": : "i"(offsetof(_hal_ctx_t, s5)));      /* $21 */
    __asm("sw $s6, %0($sp)": : "i"(offsetof(_hal_ctx_t, s6)));      /* $22 */
    __asm("sw $s7, %0($sp)": : "i"(offsetof(_hal_ctx_t, s7)));      /* $23 */
    __asm("sw $t8, %0($sp)": : "i"(offsetof(_hal_ctx_t, t8)));      /* $24 */
    __asm("sw $t9, %0($sp)": : "i"(offsetof(_hal_ctx_t, t9)));      /* $25 */
//    __asm("sw $k1, %0($sp)": : "i"(offsetof(_hal_ctx_t, k1)));      /* $27 */
    __asm("sw $gp, %0($sp)": : "i"(offsetof(_hal_ctx_t, gp)));      /* $28 */
    __asm("sw $fp, %0($sp)": : "i"(offsetof(_hal_ctx_t, fp)));      /* $30 */
    __asm("sw $ra, %0($sp)": : "i"(offsetof(_hal_ctx_t, ra)));      /* $31 */
#if defined __HW_DIVIDE__ || defined __HW_MULTIPLY__
    __asm("mfhi $v0");
    __asm("sw   $v0, %0($sp)": : "i"(offsetof(_hal_ctx_t, hi)));      /* $hi */
    __asm("mflo $v0");
    __asm("sw   $v0, %0($sp)": : "i"(offsetof(_hal_ctx_t, lo)));      /* $lo */
#endif
}

inline void tsk3000_SAVE_REGISTERS(void)
{
    tsk3000_V0_V1();
    tsk3000_AT_A0_ER_IE();
    tsk3000_SAVE_REG_REST();
}

inline void POSIX_CONTEXT_RESTORE(void)
{
    //__asm("lw $v0, %0($sp)": : "i"(offsetof(_hal_ctx_t, v0)));      /* $2 */
    //__asm("lw $v1, %0($sp)": : "i"(offsetof(_hal_ctx_t, v1)));      /* $3 */
    __asm("lw $a0, %0($sp)": : "i"(offsetof(_hal_ctx_t, a0)));      /* $4 */
    __asm("lw $a1, %0($sp)": : "i"(offsetof(_hal_ctx_t, a1)));      /* $5 */
    __asm("lw $a2, %0($sp)": : "i"(offsetof(_hal_ctx_t, a2)));      /* $6 */
    __asm("lw $a3, %0($sp)": : "i"(offsetof(_hal_ctx_t, a3)));      /* $7 */
    __asm("lw $t0, %0($sp)": : "i"(offsetof(_hal_ctx_t, t0)));      /* $8 */
    __asm("lw $t1, %0($sp)": : "i"(offsetof(_hal_ctx_t, t1)));      /* $9 */
    __asm("lw $t2, %0($sp)": : "i"(offsetof(_hal_ctx_t, t2)));      /* $10 */
    __asm("lw $t3, %0($sp)": : "i"(offsetof(_hal_ctx_t, t3)));      /* $11 */
    __asm("lw $t4, %0($sp)": : "i"(offsetof(_hal_ctx_t, t4)));      /* $12 */
    __asm("lw $t5, %0($sp)": : "i"(offsetof(_hal_ctx_t, t5)));      /* $13 */
    __asm("lw $t6, %0($sp)": : "i"(offsetof(_hal_ctx_t, t6)));      /* $14 */
    __asm("lw $t7, %0($sp)": : "i"(offsetof(_hal_ctx_t, t7)));      /* $15 */
    __asm("lw $s0, %0($sp)": : "i"(offsetof(_hal_ctx_t, s0)));      /* $16 */
    __asm("lw $s1, %0($sp)": : "i"(offsetof(_hal_ctx_t, s1)));      /* $17 */
    __asm("lw $s2, %0($sp)": : "i"(offsetof(_hal_ctx_t, s2)));      /* $18 */
    __asm("lw $s3, %0($sp)": : "i"(offsetof(_hal_ctx_t, s3)));      /* $19 */
    __asm("lw $s4, %0($sp)": : "i"(offsetof(_hal_ctx_t, s4)));      /* $20 */
    __asm("lw $s5, %0($sp)": : "i"(offsetof(_hal_ctx_t, s5)));      /* $21 */
    __asm("lw $s6, %0($sp)": : "i"(offsetof(_hal_ctx_t, s6)));      /* $22 */
    __asm("lw $s7, %0($sp)": : "i"(offsetof(_hal_ctx_t, s7)));      /* $23 */
    __asm("lw $t8, %0($sp)": : "i"(offsetof(_hal_ctx_t, t8)));      /* $24 */
    __asm("lw $t9, %0($sp)": : "i"(offsetof(_hal_ctx_t, t9)));      /* $25 */
//  __asm("lw $k0, %0($sp)": : "i"(offsetof(_hal_ctx_t, k0)));      /* $26 */
//  __asm("lw $k1, %0($sp)": : "i"(offsetof(_hal_ctx_t, k1)));      /* $27 */
    __asm("lw $gp, %0($sp)": : "i"(offsetof(_hal_ctx_t, gp)));      /* $28 */
//  __asm("lw $sp, %0($sp)": : "i"(offsetof(_hal_ctx_t, sp)));      /* $29 */
    __asm("lw $fp, %0($sp)": : "i"(offsetof(_hal_ctx_t, fp)));      /* $30 */
    __asm("lw $ra, %0($sp)": : "i"(offsetof(_hal_ctx_t, ra)));      /* $31 */
#if defined __HW_DIVIDE__ || defined __HW_MULTIPLY__
    __asm("lw $v0, %0($sp)": : "i"(offsetof(_hal_ctx_t, hi)));      /* $hi */
    __asm("mthi $v0");
    __asm("lw $v0, %0($sp)": : "i"(offsetof(_hal_ctx_t, lo)));      /* $lo */
    __asm("mtlo $v0");
#endif
    __asm("addiu    $v0, $zero, -22"); //: : "i"(~(TSK3000_Status_InterruptEnable|TSK3000_Status_InterruptEnable_Previous|TSK3000_Status_InterruptEnable_Old)));
    __asm("mfc0     $v1, $Status");
    __asm("and      $v1, $v1, $v0");
    __asm("lw       $v0, %0($sp)": : "i"(offsetof(_hal_ctx_t, ieop)));
    __asm("or       $v0, $v0, $v1");
    __asm("mtc0     $v0, $Status");

    __asm("lw $k0, %0($sp)": : "i"(offsetof(_hal_ctx_t, k0)));      /* $26 */
//  __asm("lw $k1, %0($sp)": : "i"(offsetof(_hal_ctx_t, k1)));      /* $27 */
    __asm("lw $v1, %0($sp)": : "i"(offsetof(_hal_ctx_t, v1)));      /* $3 */
    __asm("lw $v0, %0($sp)": : "i"(offsetof(_hal_ctx_t, v0)));      /* $2 */
    __asm("lw $at, %0($sp)": : "i"(offsetof(_hal_ctx_t, at)));      /* $1 */
    __asm("addiu $sp, $sp, %0": : "i"(sizeof(_hal_ctx_t)));
    __asm("jr $k0");
    __asm("rfe");

}

inline void POSIX_CLOCK_INTERRUPT_CONTEXT_RESTORE(void)
{
    //__asm("lw $v0, %0($sp)": : "i"(offsetof(_hal_ctx_t, v0)));      /* $2 */
    //__asm("lw $v1, %0($sp)": : "i"(offsetof(_hal_ctx_t, v1)));      /* $3 */
    __asm("lw $a0, %0($sp)": : "i"(offsetof(_hal_ctx_t, a0)));      /* $4 */
    __asm("lw $a1, %0($sp)": : "i"(offsetof(_hal_ctx_t, a1)));      /* $5 */
    __asm("lw $a2, %0($sp)": : "i"(offsetof(_hal_ctx_t, a2)));      /* $6 */
    __asm("lw $a3, %0($sp)": : "i"(offsetof(_hal_ctx_t, a3)));      /* $7 */
    __asm("lw $t0, %0($sp)": : "i"(offsetof(_hal_ctx_t, t0)));      /* $8 */
    __asm("lw $t1, %0($sp)": : "i"(offsetof(_hal_ctx_t, t1)));      /* $9 */
    __asm("lw $t2, %0($sp)": : "i"(offsetof(_hal_ctx_t, t2)));      /* $10 */
    __asm("lw $t3, %0($sp)": : "i"(offsetof(_hal_ctx_t, t3)));      /* $11 */
    __asm("lw $t4, %0($sp)": : "i"(offsetof(_hal_ctx_t, t4)));      /* $12 */
    __asm("lw $t5, %0($sp)": : "i"(offsetof(_hal_ctx_t, t5)));      /* $13 */
    __asm("lw $t6, %0($sp)": : "i"(offsetof(_hal_ctx_t, t6)));      /* $14 */
    __asm("lw $t7, %0($sp)": : "i"(offsetof(_hal_ctx_t, t7)));      /* $15 */
    __asm("lw $s0, %0($sp)": : "i"(offsetof(_hal_ctx_t, s0)));      /* $16 */
    __asm("lw $s1, %0($sp)": : "i"(offsetof(_hal_ctx_t, s1)));      /* $17 */
    __asm("lw $s2, %0($sp)": : "i"(offsetof(_hal_ctx_t, s2)));      /* $18 */
    __asm("lw $s3, %0($sp)": : "i"(offsetof(_hal_ctx_t, s3)));      /* $19 */
    __asm("lw $s4, %0($sp)": : "i"(offsetof(_hal_ctx_t, s4)));      /* $20 */
    __asm("lw $s5, %0($sp)": : "i"(offsetof(_hal_ctx_t, s5)));      /* $21 */
    __asm("lw $s6, %0($sp)": : "i"(offsetof(_hal_ctx_t, s6)));      /* $22 */
    __asm("lw $s7, %0($sp)": : "i"(offsetof(_hal_ctx_t, s7)));      /* $23 */
    __asm("lw $t8, %0($sp)": : "i"(offsetof(_hal_ctx_t, t8)));      /* $24 */
    __asm("lw $t9, %0($sp)": : "i"(offsetof(_hal_ctx_t, t9)));      /* $25 */
//  __asm("lw $k0, %0($sp)": : "i"(offsetof(_hal_ctx_t, k0)));      /* $26 */
//  __asm("lw $k1, %0($sp)": : "i"(offsetof(_hal_ctx_t, k1)));      /* $27 */
    __asm("lw $gp, %0($sp)": : "i"(offsetof(_hal_ctx_t, gp)));      /* $28 */
//  __asm("lw $sp, %0($sp)": : "i"(offsetof(_hal_ctx_t, sp)));      /* $29 */
    __asm("lw $fp, %0($sp)": : "i"(offsetof(_hal_ctx_t, fp)));      /* $30 */
    __asm("lw $ra, %0($sp)": : "i"(offsetof(_hal_ctx_t, ra)));      /* $31 */
#if defined __HW_DIVIDE__ || defined __HW_MULTIPLY__
    __asm("lw $v0, %0($sp)": : "i"(offsetof(_hal_ctx_t, hi)));      /* $hi */
    __asm("mthi $v0");
    __asm("lw $v0, %0($sp)": : "i"(offsetof(_hal_ctx_t, lo)));      /* $lo */
    __asm("mtlo $v0");
#endif
    __asm("addiu    $v0, $zero, -22"); //: : "i"(~(TSK3000_Status_InterruptEnable|TSK3000_Status_InterruptEnable_Previous|TSK3000_Status_InterruptEnable_Old)));
    __asm("mfc0     $v1, $Status");
    __asm("and      $v1, $v1, $v0");
    __asm("lw       $v0, %0($sp)": : "i"(offsetof(_hal_ctx_t, ieop)));
    __asm("or       $v0, $v0, $v1");
    __asm("mtc0     $v0, $Status");

    //tsk3000_posix_interrupts_internal_enable();
    __asm("nop");    // 3 instructions before interrupts are off
    __asm("lui  $v1, @hi(tsk3000_posix_interrupts_savemask)");
    __asm("lw   $v0, @lo(tsk3000_posix_interrupts_savemask)($v1)");
    __asm("mfc0 $v1, $1");
    __asm("or   $v0, $v0, $v1");
    __asm("mtc0 $v0, $1");

    __asm("lw $k0, %0($sp)": : "i"(offsetof(_hal_ctx_t, k0)));      /* $26 */
//  __asm("lw $k1, %0($sp)": : "i"(offsetof(_hal_ctx_t, k1)));      /* $27 */
    __asm("lw $v1, %0($sp)": : "i"(offsetof(_hal_ctx_t, v1)));      /* $3 */
    __asm("lw $v0, %0($sp)": : "i"(offsetof(_hal_ctx_t, v0)));      /* $2 */
    __asm("lw $at, %0($sp)": : "i"(offsetof(_hal_ctx_t, at)));      /* $1 */
    __asm("addiu $sp, $sp, %0": : "i"(sizeof(_hal_ctx_t)));
    __asm("jr $k0");
    __asm("rfe");

}

/* NO interprocedural register optimazation */
inline void tsk3000_load_ctx(void *_spptr)
{
    /* load the stack pointer first */
    __asm("or $sp, %0, $0"::"r"(_spptr));

    POSIX_CLOCK_INTERRUPT_CONTEXT_RESTORE();
}

#define _hal_load_ctx       tsk3000_load_ctx

inline void tsk3000_save_ctx(void)
{
    __asm("sub   $sp, $sp, %0": : "i"(sizeof(_hal_ctx_t)));

    // save v0:v1
    tsk3000_V0_V1();

    // store sp in _posix_current_thread->sp ( first field )
    __asm("lw $v0, %0": : "m"(_posix_current_thread));
    __asm("sw $sp, ($v0)");

    tsk3000_AT_A0_ER_IE();
    tsk3000_SAVE_REG_REST();

#if ( POSIX_THREADS_DEBUG != 0 )
    // store $ra in _posix_resume_address
    __asm("lui  $v0, @hi(_posix_resume_address)");
    __asm("sw   $ra, @lo(_posix_resume_address)($v0)");
#endif

    __asm("sw $fp, %0($sp)": : "i"(offsetof(_hal_ctx_t, fp)));      /* $30 */
    __asm("sw $ra, %0($sp)": : "i"(offsetof(_hal_ctx_t, ra)));      /* $31 */
    __asm("sw $ra, %0($sp)": : "i"(offsetof(_hal_ctx_t, k0)));      /* $31 */
}

#define _hal_save_ctx           tsk3000_save_ctx
extern void tsk3000_load_asr_ctx(void **__sp, void (*_asr_handler)(void*));
#define _hal_load_asr_ctx       tsk3000_load_asr_ctx
extern void tsk3000_switch_ctx( void **, void * );
#define _hal_switch_ctx         tsk3000_switch_ctx

#endif


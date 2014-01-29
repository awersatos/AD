
#ifndef _PAL_PLATFORM_POSIX_H
#define _PAL_PLATFORM_POSIX_H

#include <stdint.h>
#include <stddef.h>
#include "pal_variant.h"

#define  _hal_STACKDOWNWARDS                                    1

inline void _hal_jump_main(void)
{
    __asm(".extern  main");
    __asm("str     lr,[sp,#-4]!");
    __asm("mov     r0,#0");
    __asm("bl      main");
    __asm("ldr     lr,[sp],#4");
}

typedef struct pal_ctx_t
{
    /* general purpose registers: r0 - r11 */
    uint32_t reg0_10[11];
    uint32_t  fp;
    uint32_t  ip;
    uint32_t  sp;
    uint32_t  lr;
    uint32_t  pc;
    uint32_t  cpsr;     /* 0x40 */
} pal_ctx_t;


extern struct thread_t * _posix_current_thread;

inline void arm7_save_ctx( void )
{
    /* prepare scratch register */
    __asm("str  r1,[r13,#-4]");

    /* push next pc */
    __asm("ldr     r1,[sp,#0]");
    __asm("str     r1,[sp,#-12]");
    /* push next lr */
    __asm("ldr     r1,[sp,#4]");
    __asm("str     r1,[sp,#-16]");
    /* push sp */
    __asm("add     sp,sp,#4");
    __asm("str     sp,[sp,#-24]");
    /* push ip,fp,r10-r0 */
    __asm("sub     sp,sp,#24");
    __asm("stmfd   sp!,{r0-r11,ip}");
    /* push cpsr */
    __asm("mrs     r2,cpsr");
    __asm("str     r2,[sp,#0x40]");

    /* restore scratch */
    __asm("ldr     r1,[sp,#0x44]");

    /* store new sp in _posix_current_thread */
    * (uint32_t*) _posix_current_thread = (uint32_t)pal_architecture_get_current_sp();
}

#define _hal_save_ctx              arm7_save_ctx

extern void arm7_load_asr_ctx(void**, void (*)(void*));
#define _hal_load_asr_ctx       arm7_load_asr_ctx
extern void arm7_init_ctx(void* (*)(void*),void*, void (*)(void*),void **);
#define _hal_init_ctx           arm7_init_ctx
extern void arm7_load_ctx( void *);
#define _hal_load_ctx           arm7_load_ctx
extern void arm7_switch_ctx( void **, void * );
#define _hal_switch_ctx         arm7_switch_ctx



#endif

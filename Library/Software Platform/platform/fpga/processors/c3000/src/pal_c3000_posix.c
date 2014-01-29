#if ( __POSIX_KERNEL__ > 0 )

#include <string.h>
#include <stdint.h>
#include "posix_threads_cfg.h"


/* interrupt stack buffer */
int32_t         _posix_interrupt_stack[(POSIX_THREADS_INTR_STACKSIZE/4)];
volatile void*  _posix_interrupt_stack_top =
         (void*)&_posix_interrupt_stack[(POSIX_THREADS_INTR_STACKSIZE/4)-1];


#include "pal.h"
#include "pal_platform_posix.h"


#if ( POSIX_THREADS_DEBUG != 0 )
extern uint32_t        _posix_resume_address;
extern uint32_t        _posix_user_stack;
#endif

volatile uint32_t  tsk3000_posix_interrupts_savemask=0;

/* sp pointer at first nesting level */
volatile void*  _posix_irq_sp = 0;

/* specific posix code for context switching at interrupt level */

inline void POSIX_INTERRUPT_CONTEXT_SAVE( void )
{
     /* the stack is adjusted to make room for the context */
    __asm("sub $sp, $sp, %0": : "i"(sizeof(_hal_ctx_t)));

    /* since this is an interrupt handler the return address is stored in $ER */
    /* the $k0 is used to jump to after loading a context */
    __asm("mfc0 $k0, $ER");

    tsk3000_SAVE_REGISTERS();
}

inline void POSIX_CLOCK_INTERRUPT_CONTEXT_SAVE( void )
{
     /* the stack is adjusted to make room for the context */
    __asm("sub $sp, $sp, %0": : "i"(sizeof(_hal_ctx_t)));

    /* since this is an interrupt handler the return address is stored in $ER */
    /* the $k0 is used to jump to after loading a context */
    __asm("mfc0 $k0, $ER");

    tsk3000_V0_V1();
    tsk3000_AT_A0_ER_IE();

    // pal_timer_interrupt_acknowledge();
    __asm("mfc0 $v0,$0");
    __asm("ori  $v0,$v0,0x80");
    __asm("mtc0 $v0,$0");
    __asm("mfc0 $v0,$0");
    __asm("addiu    $v1,$zero,-129");
    __asm("and  $v0,$v0,$v1");
    __asm("mtc0 $v0,$0");
    // ATTENTION: it assumes clock interrupt = 0
    __asm("li   $v0,0x1");
    __asm("mtc0 $v0,$2");

    //pal_architecture_posix_interrupts_disable();
    __asm("mfc0 $v0, $1");                                      // load IEnable
    __asm("lui  $v1, @hi(posix_interrupts_bitmask)");
    __asm("lw   $v1, @lo(posix_interrupts_bitmask)($v1)");      // load posix_interrupts_bitmask
    __asm("ori  $v1, $v1, 1");                                  // or timer interrupt with posix_interrupts_bitmask
    __asm("and  $a0, $v0, $v1");                                // current enabled posix interrupts and timer interrupt
    __asm("nor  $v1, $v1, $v1");                                // invert bits
    __asm("and  $v1, $v0, $v1");                                // clear posix and timer interrupt bits
    __asm("mtc0 $v1, $1");                                      // save new IEnable
    __asm("lui  $v1, @hi(tsk3000_posix_interrupts_savemask)");
    __asm("sw   $a0, @lo(tsk3000_posix_interrupts_savemask)($v1)"); // save current enabled posix interrupts and timer interrupt

   // pal_architecture_interrupts_enable();
    __asm("mfc0 $v0,$0");
    __asm("ori  $v0,$v0,0x1");
    __asm("mtc0 $v0,$0");

    tsk3000_SAVE_REG_REST();

}

inline void SWAP_TO_INTERRUPT_STACK(void)
{
    if ( _posix_irq_level++==0)
    {
       if (_posix_current_thread !=NULL)
       {
          __asm("lw $1, %0": : "m"(_posix_current_thread));
          __asm("sw $sp, ($1)");
       }
       else
       {
          __asm("sw $sp, %0":"=m"(_posix_irq_sp));
       }
       __asm("lw $sp, %0"::"m"(_posix_interrupt_stack_top));
    }

}

inline void STACK_RESTORE(void)
{
    if ( _posix_irq_level--==1)
    {
       if (_posix_current_thread !=NULL)
       {
          __asm("lw $1, %0": : "m"(_posix_current_thread));
          __asm("lw $sp, ($1)");
       }
       else
       {
          __asm("lw $sp, %0":"=m"(_posix_irq_sp));
       }
    }
}

inline void SAVE_DEBUG_INFO(void)
{
#if ( POSIX_THREADS_DEBUG != 0 )
    {   _hal_ctx_t* ctx;
        __asm("addi %0, $sp, 0":"=r"(ctx): );
        _posix_resume_address = ctx->k0;
        _posix_user_stack     = (uint32_t)(ctx+1);
    }
#endif
}

extern uint32_t  posix_interrupts_bitmask;
#pragma warning 796
__interrupt() __frame() void tsk3000_posix_interrupt_handler(void)
{
    __asm(".extern posix_interrupts_handler");
    __asm(".extern interrupts_common_handler");
    __asm(".extern posix_interrupts_bitmask");

    __asm("nop");

    POSIX_INTERRUPT_CONTEXT_SAVE();

    __asm("lw   $v0, %0": : "m"(posix_interrupts_bitmask));
    __asm("ori  $a0, $zero, 1");
    __asm("sllv $v1,$a0,$k1");
    __asm("and  $v0,$v0,$v1");
    __asm("beq  $v0,$zero, tsk3000_posix_interrupt_handler_not_notify");

    SAVE_DEBUG_INFO();
    SWAP_TO_INTERRUPT_STACK();

    /* jump to upper C handler: argument is vector */
    __asm("ori  $a0, $k1, 0 ");
    __asm("jal  posix_interrupts_handler");
    __asm("nop");

    STACK_RESTORE();
    POSIX_CONTEXT_RESTORE();

__asm("tsk3000_posix_interrupt_handler_not_notify:");

    /* jump to upper C handler: argument is vector */
    __asm("ori  $a0, $k1, 0 ");
    __asm("jal  interrupts_common_handler");
    __asm("nop");

    POSIX_CONTEXT_RESTORE();
}
#pragma warning restore

#pragma warning 796
__interrupt() __frame() void tsk3000_posix_clock_handler(void)
{
    __asm(".extern posix_clock_interrupt_handler");
    __asm("nop");

    POSIX_CLOCK_INTERRUPT_CONTEXT_SAVE();
    SAVE_DEBUG_INFO();
    SWAP_TO_INTERRUPT_STACK();

   /* jump to upper posix clock handler */
    __asm("jal posix_clock_interrupt_handler");
    __asm("nop");

    STACK_RESTORE();
    POSIX_CLOCK_INTERRUPT_CONTEXT_RESTORE();
}
#pragma warning restore


void swap(void)
{
        __asm("or $a0, $v0, $0");
        __asm("lw $ra, ($sp)");
        __asm("jr $ra");
        __asm("addiu $sp, $sp, %0": : "i"(sizeof(void *)));
}

void tsk3000_init_ctx(
        void *(*_entry)(void*),
        void *_arg,
        void (*_exit)(void*),
        void **__spptr)
{
        unsigned *routine;
        _hal_ctx_t *context;

        routine = ((unsigned*)*__spptr)-sizeof(unsigned*);
        *routine = (unsigned)_exit;

        context = (_hal_ctx_t*)(((char*)routine)-sizeof(_hal_ctx_t));

        /* initialize all registers to zero */
        memset(context, 0, sizeof(*context));

        /* set parameter */
        context->a0 = (unsigned)_arg;

        /* set entry point */
        context->k0 = (unsigned)_entry;

        /* copy the context pointer $gp == $28 */
        {
                unsigned int gp;
                __asm("move %0, $28" : "=r"(gp));
                context->gp = gp;
        }

        /* set the stackpointer */
        context->sp = (unsigned)(context);
        *__spptr = context;

        /* return address */
        context->ra = (unsigned)swap;

        /* set Interrupt Enable Previous bit so interrupt are set on by rfe when context is loaded */
        context->ieop = TSK3000_Status_InterruptEnable_Previous;

        return;
}

 void tsk3000_load_asr_ctx(void **__sp, void (*_asr_handler)(void*))
{
    unsigned int *routine;
    _hal_ctx_t *context;

    routine = ((unsigned*)*__sp)-sizeof(unsigned*);

    context = (_hal_ctx_t*)(((char*)routine)-sizeof(_hal_ctx_t));

    /* set parameter */
    context->a0 = (unsigned)*__sp;

    /* set entry point */
    context->k0 = (unsigned)_asr_handler;

    /* set Interrupt Enable Previous bit so interrupts are set on by rfe when context is loaded */
    context->ieop = TSK3000_Status_InterruptEnable_Previous;

    /* copy the context pointer $gp == $28 */
    {
        unsigned int gp;
        __asm("move %0, $28" : "=r"(gp));
        context->gp = gp;
    }

    /* set the stackpointer */
    context->sp = (unsigned)(context);
    *__sp = context;
}

#endif /* __POSIX_KERNEL__ */


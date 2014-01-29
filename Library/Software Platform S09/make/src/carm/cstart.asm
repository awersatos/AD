

Mode_USR        .equ            0x10
Mode_FIQ        .equ            0x11
Mode_IRQ        .equ            0x12
Mode_SVC        .equ            0x13
Mode_ABT        .equ            0x17
Mode_UND        .equ            0x1B
Mode_SYS        .equ            0x1F

I_Bit           .equ            0x80    ; when I bit is set, IRQ is disabled
F_Bit           .equ            0x40    ; when F bit is set, FIQ is disabled

        .extern _lc_ub_stack            ; usr/sys mode stack pointer
        .extern _lc_ue_stack            ; symbol required by debugger
        .extern _lc_ub_table            ; ROM to RAM copy table
        .extern _lc_ub_stack_fiq
        .extern _lc_ub_stack_irq
        .extern _lc_ub_stack_svc
        .extern _lc_ub_stack_abt
        .extern _lc_ub_stack_und
        .extern main
        .extern _Exit
        .extern exit
        .weak   exit
        .extern __init_hardware
        .extern __init_vector_table
        
        .extern _APPLICATION_MODE_      ; symbol defined in LSL file
        
    .if @defined('__PROF_ENABLE__')
        .extern __prof_init
    .endif
    .if @defined('__FRAMEWORK__')
        .extern framework_init
        .if @defined('__POSIX_KERNEL__')
        .extern posix_main
        .extern _posix_boot_stack_top
        .endif
    .endif
        .global _START

        .section .text.cstart

        .code32
        .align  4
_START: 
        ;; anticipate possible ROM/RAM remapping
        ;; by loading the 'real' program address
        ldr     pc,=_Next
_Next:
        ;; initialize the stack pointer for each mode
        ;; while keeping interrupts disabled

        msr     cpsr_c,#Mode_FIQ | F_Bit | I_Bit        ; change to FIQ mode
        ldr     sp,=_lc_ub_stack_fiq                    ; initialize FIQ stack pointer

        msr     cpsr_c,#Mode_IRQ | F_Bit | I_Bit        ; change to IRQ mode
        ldr     sp,=_lc_ub_stack_irq                    ; initialize IRQ stack pointer

        msr     cpsr_c,#Mode_SVC | F_Bit | I_Bit        ; change to Supervisor mode
        ldr     sp,=_lc_ub_stack_svc                    ; initialize SVC stack pointer

        msr     cpsr_c,#Mode_ABT | F_Bit | I_Bit        ; change to Abort mode
        ldr     sp,=_lc_ub_stack_abt                    ; initialize ABT stack pointer

        msr     cpsr_c,#Mode_UND | F_Bit | I_Bit        ; change to Undefined mode
        ldr     sp,=_lc_ub_stack_und                    ; initialize UND stack pointer

        msr     cpsr_c,#Mode_SYS | F_Bit | I_Bit        ; change to System mode
        ldr     sp,=_lc_ub_stack                        ; initialize USR/SYS stack pointer

        ;; call a user function which initializes hardware
        ;; such as ROM/RAM re-mapping or MMU configuration
        bl      __init_hardware

        ;; copy initialized sections from ROM to RAM
        ;; and clear uninitialized data sections in RAM

        ldr     r3,=_lc_ub_table
        mov     r0,#0
cploop:
        ldr     r4,[r3],#4      ; load type
        ldr     r5,[r3],#4      ; dst address
        ldr     r6,[r3],#4      ; src address
        ldr     r7,[r3],#4      ; size

        cmp     r4,#1
        beq     copy
        cmp     r4,#2
        beq     clear
        b       done

copy:
        ldrb    r8,[r6],#1
        strb    r8,[r5],#1
        subs    r7,r7,#1
        bne     copy

        b       cploop

clear:
        strb    r0,[r5],#1
        subs    r7,r7,#1
        bne     clear
        
        b       cploop
        
done:   
        ;; initialize or copy the vector table
        bl      __init_vector_table
 
      .if @defined('__POSIX_KERNEL__')
        
        ;; run always in svc mode with interrupts disable
        msr     cpsr_c, #Mode_SVC | F_Bit | I_Bit      
        ;; posix stack buffer for system upbringing
        ldr     sp,=_posix_boot_stack_top
        ldr     sp, [sp]                        
     
     .else
        
        ;; switch to user-defined application mode
        ;; as defined through a symbol in LSL file
        ldr     r0,=_APPLICATION_MODE_
        msr     cpsr_c,r0
        ;; load r10 with end of USR/SYS stack, which is
        ;; needed in case stack overflow checking is on
        ldr     r10,=_lc_ue_stack    
     
     .endif

    .if @thumb()
        ldr     r0,=_thumb
        bx      r0
        .code16
_thumb:
    .endif

    .if @defined('__PROF_ENABLE__')
        bl      __prof_init
    .endif


    .if @defined('__FRAMEWORK__')
        bl      framework_init
    .if @defined('__POSIX_KERNEL__')
        ;; call posix_main with no arguments
        bl      posix_main
    .else
        ;; call main with argv[0]==NULL & argc==0
        mov     r0,#0
        mov     r1,#0
        bl      main
    .endif
    .else
        ;; call main with argv[0]==NULL & argc==0
        mov     r0,#0
        mov     r1,#0
        bl      main
    .endif

        ;; call exit using the return value from main()
        ;; Note. Calling exit will also run all functions
        ;; that were supplied through atexit().
        bl      exit

        .ltorg                  ; assemble literal data pool here
        
        .endsec

        .calls  '_START','__init_hardware'
        .calls  '_START','__init_vector_table'
    .if @defined('__PROF_ENABLE__')
        .calls  '_START','__prof_init'
    .endif
    .if @defined('__POSIX__')
        .calls  '_START','posix_main'
    .else
        .calls  '_START','main'
    .endif
        .calls  '_START','exit'
        .calls  '_START','',0

        .end

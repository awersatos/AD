
        .extern _lc_ub_stack
        .extern _lc_ub_table
        .extern _SDA_BASE_
        .extern _EXCEPTION_BASE_
        .extern _VECTORED_INTERRUPTS_
    .if @defined('__FRAMEWORK__')
        .extern framework_init
        .if @defined('__POSIX_KERNEL__')
        .extern posix_main
        .endif
    .endif
    .if @defined('__POSIX__')
        .extern posix_main
    .else
        .extern main
    .endif
        .extern _Exit
        .extern exit
        .weak   exit
    .if @defined('__PROF_ENABLE__')
        .extern __prof_init
    .endif
                
        .section .start code
        ;; this section allows for the actual startup code (defined
        ;; in .text.cstart below) to be located at an arbitrary address
        ;; within a range of 2**28 bytes from _START (usually fixed at 0x0) 
        .global _START
_START: 
        j       __cstart
        nop
        .endsec


        .section .text.cstart

        .global __cstart
        
__cstart: 

        ;; setup the EB register (16-bits) and the VIE status bit (bit-9)
        addiu   $at,$0,_EXCEPTION_BASE_         ; symbol defined in LSL file 
        mtc0    $at,$EB
        mfc0    $at,$Status
        ori     $at,$at,_VECTORED_INTERRUPTS_   ; symbol defined in LSL file 
        mtc0    $at,$Status
        
        ;; initialize the stack pointer
        lui     $at,@hi(_lc_ub_stack)
        addiu   $sp,$at,@lo(_lc_ub_stack)

        ;; setup .sdata section
        lui     $at,@hi(_SDA_BASE_)     ; symbol defined in LSL file
        addiu   $gp,$at,@lo(_SDA_BASE_)
        
        ;; copy initialized sections from ROM to RAM
        lui     $4,@hi(_lc_ub_table)
        addiu   $4,$4,@lo(_lc_ub_table)
        
cploop:
        lw      $8,0($4)        ; load type
        lw      $9,4($4)        ; dst address
        lw      $10,8($4)       ; src address
        lw      $11,12($4)      ; size

        ori     $5,$0,1
        beq     $5,$8,copy
        addiu   $4,$4,16
        ori     $5,$0,2
        beq     $5,$8,clear
        nop
        
        j       done
        nop

copy:
        lb      $5,0($10)
        sb      $5,0($9)
        addiu   $11,$11,-1
        addiu   $10,$10,1
        bgtz    $11,copy
        addiu   $9,$9,1 

        j       cploop
        nop

clear:
        sb      $0,0($9)
        addiu   $11,$11,-1
        bgtz    $11,clear
        addiu   $9,$9,1
        
        j       cploop
        nop
        
done:

_cptable_handled:       ;; Symbol may be used by debugger

    .if @defined('__PROF_ENABLE__')
        jal     __prof_init
        nop
    .endif

    .if @defined('__FRAMEWORK__')
        ;; new dsf framework
        .extern framework_init
        jal     framework_init
        nop
      .if !@defined('__POSIX_KERNEL__')
        ;; call main with argv[0]==NULL & argc==0
        li      $4,0
        jal     main
        li      $5,0
      .else
        ;; call posix_main
        jal     posix_main
        nop
      .endif
    .else
        ;; without new dsf framework (old style application)
      .if @defined('__POSIX__')
        ;; call posix_main
        jal      posix_main
        nop
      .else
        ;; call main with argv[0]==NULL & argc==0
        li      $4,0
        jal     main
        li      $5,0
      .endif
    .endif
        ;; call exit using the return value from main()
        ;; Note. Calling exit will also run all functions
        ;; that were supplied through atexit().
        j       exit
        move    $4,$2

        .endsec

        .end

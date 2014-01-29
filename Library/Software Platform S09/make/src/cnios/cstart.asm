;;  cstart.asm  ---  C startup code
;;
;;  FILE:               cstart.asm
;;
;;  COPYRIGHT:          Copyright 2001-2006 Altium BV
;;
;;  DESCRIPTION:
;;
;;      The system startup code initializes the Stack Pointer and the
;;      application C variables.
;;
;;      When linking your C modules with the library, you automatically
;;      link the object module, containing the C startup code. This
;;      module is called cstart.obj and is present in every C library
;;

        .extern _lc_ub_stack
        .extern _lc_ub_table
        .extern _SDA_BASE_
        .extern main
        .extern _Exit
        .extern exit
        .weak   exit
        .extern _dcti
        .weak   _dcti

    .if @defined('__PROF_ENABLE__')
        .extern __prof_init
    .endif

    .if @defined('__POSIX__') || @defined('__POSIX_KERNEL__')
        .extern posix_main
    .endif
        
        .section .text.cstart

        .global _START

_START: 

        ;; initialize the stack pointer
        orhi    at,r0,@hiadj(_lc_ub_stack)
        addi    sp,at,@lo(_lc_ub_stack)

        ;; setup .sdata section
        movia   gp,_SDA_BASE_   ; symbol defined in LSL file
        
        ;; copy initialized sections from ROM to RAM
        movia   r16,_lc_ub_table
        
cploop:
        ldw     r8,0(r16)       ; load type
        ldw     r4,4(r16)       ; dst address
        ldw     r5,8(r16)       ; src address
        ldw     r6,12(r16)      ; size

        ;; r16 is callee-saved
                
        addi    r16,r16,16
        cmpeqi  r9,r8,1
        bne     r9,r0,copy
        cmpeqi  r9,r8,2
        bne     r9,r0,clear
        cmpeqi  r9,r8,3
        bne     r9,r0,decompress
       
        br      done

copy:
        ldb     r9,0(r5)
        stb     r9,0(r4)
        addi    r4,r4,1 
        addi    r5,r5,1
        addi    r6,r6,-1
        bgtu    r6,r0,copy

        br      cploop

clear:
        stb     r0,0(r4)
        addi    r4,r4,1
        addi    r6,r6,-1
        bgtu    r6,r0,clear
        
        br      cploop

decompress:     
        call    _dcti           ; void _dcti (unsigned char * dest, const unsigned char * src, size_t size)

        br      cploop
        
done:
    .if @defined('__PROF_ENABLE__')
        call    __prof_init
    .endif

    .if @defined('__FRAMEWORK__')
        ;; new dsf framework
        .extern framework_init
        call     framework_init
        nop
      .if !@defined('__POSIX_KERNEL__')
        ;; call main with argv[0]==NULL & argc==0
        mov     r4,r0
        mov     r5,r0
        call    main
      .else
        ;; call posix_main
        call     posix_main
        nop
      .endif
    .else
    .if @defined('__POSIX__')
        call    posix_main
    .else
        ;; call main with argv[0]==NULL & argc==0
        mov     r4,r0
        mov     r5,r0
        call    main
    .endif
    .endif


        ;; call exit using the return value from main()
        ;; Note. Calling exit will also run all functions
        ;; that were supplied through atexit().
        mov     r4,r2
        call    exit

        .endsec

        .end

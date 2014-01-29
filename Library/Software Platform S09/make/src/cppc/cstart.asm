
        .section .text.cstart

        .extern _lc_ub_stack
        .extern _lc_ub_table
        .extern _SDA_BASE_
        .extern _SDA2_BASE_
        .extern _EXCEPTION_BASE_
    .if @defined('__POSIX_KERNEL__')
        .extern posix_main
    .else
        .extern main
    .endif
    .if @defined('__FRAMEWORK__')
        .extern framework_init
    .endif
        .extern _Exit
        .extern exit
        .weak   exit
    .if @defined('__PROF_ENABLE__')
        .extern __prof_init
    .endif
        
        .global _START
        .global _START405

_START:
_START405:

        ;; initialize the stack pointer
        lis     %r3,@ha(_lc_ub_stack)
        la      %r4,@lo(_lc_ub_stack)(%r3)
        addi    %r1,%r4,-8              ; create room for first stack frame
        li      %r0,0
        stw     %r0,0(%r1)              ; TOS is identified with zero

        ;; setup .sdata section
        lis     %r3,@ha(_SDA_BASE_)     ; symbol defined in LSL file
        la      %r13,@lo(_SDA_BASE_)(%r3)
        
        ;; setup .sdata2 section
        lis     %r3,@ha(_SDA2_BASE_)    ; symbol defined in LSL file
        la      %r2,@lo(_SDA2_BASE_)(%r3)
        
        ;; initialize the EVPR and the vector table
        lis     %r3,@hi(_EXCEPTION_BASE_)       ; symbol defined in LSL file
        mtevpr  %r3

        ;; initialize the MSR register (zero at reset)

        ;; copy initialized sections from ROM to RAM
        lis     %r3,@ha(_lc_ub_table-4)
        la      %r3,@lo(_lc_ub_table-4)(%r3)
        li      %r0,0
cploop:
        lwzu    %r4,4(%r3)      ; load type
        lwzu    %r5,4(%r3)      ; dst address
        lwzu    %r6,4(%r3)      ; src address
        lwzu    %r7,4(%r3)      ; size

        mtctr   %r7             ; setup loop counter
        
        cmpwi   %cr0,%r4,1
        beq     %cr0,copy
        cmpwi   %cr0,%r4,2
        beq     %cr0,clear
        b       done

copy:
        lbz     %r8,0(%r6)
        stb     %r8,0(%r5)
        addi    %r5,%r5,1
        addi    %r6,%r6,1
        bdnz+   copy

        b       cploop

clear:
        stb     %r0,0(%r5)
        addi    %r5,%r5,1
        bdnz+   clear
        
        b       cploop
        
done:
        
    .if @defined('__PROF_ENABLE__')
        bl      __prof_init
    .endif

    .if @defined('__FRAMEWORK__')
        ;; new dsf framework
        .extern framework_init
        bl      framework_init
      .if !@defined('__POSIX_KERNEL__')
        ;; call main with argv[0]==NULL & argc==0
        li      %r3,0
        li      %r4,0
        bl      main
      .else
        li      %r3,0
        li      %r4,0
        bl      posix_main
      .endif
    .endif

        ;; call exit using the return value from main()
        ;; Note. Calling exit will also run all functions
        ;; that were supplied through atexit().
        b       exit
                
        .endsec

        .end

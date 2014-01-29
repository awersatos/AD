/************************************************************************************************************
**
**  FILE        : cstart.c
**
**  VERSION     : 1.12
**
**  DESCRIPTION :
**
**      The system startup code initializes:
**
**      - the system stack pointer (r1).
**      - the __sdata anchor register (r13).
**      - the application C variables.
**
**      When linking your C modules with the library, you automatically
**      link the object module, containing the system startup code. This
**      module is called cstart.obj and is present in every C library.
**
**  Copyright 1996-2006 Altium BV                                         *
**
*************************************************************************************************************/

#include <stdlib.h>
#include <start.h>

/* =========================================================
 * prototypes
 * =========================================================
 */
void    __interrupt( 0x00000000 ) _START( void );

/* =========================================================
 * external data
 * =========================================================
 */
extern  __no_sdata      int *   _lc_ub_stack;                           /* system stack end label (defined in mb.lsl file)      */
extern  __no_sdata      int *   _base_r13;                              /* base of __sdata space (defined in mb.lsl file)       */

/* =========================================================
 * external functions
 * =========================================================
 */
extern  void    __prof_init( void );
extern  int     main( int argc );
#pragma weak    exit
#pragma extern  _Exit

/* =========================================================
 * implementation
 * =========================================================
 */
#pragma profiling off

/************************************************************************************************************
 *
 *  FUNCTION:           _START
 *
 *  ENVIRONMENT:        --
 *
 *  REQUIREMENTS:       none
 *
 *  RETURN VALUE:       none
 *
 *  DESCRIPTION:
 *
 *      This function implements the MicroBlaze reset vector. It performs
 *      the following tasks:
 *
 *              - initialize the stack pointer
 *              - initialize anchor register (r13) to access the __sdata memory space.
 *              - execute actions defined in the copy table.
 *              - call main() function.
 *
 */

void __interrupt( 0x00000000 ) _START( void )
{
        extern void posix_main(void);
        
        __asm( "addik   r1,r0,%0" : : "i"(&_lc_ub_stack) : );           /* initialize user stack pointer                        */
        __asm( "addik   r13,r0,%0" : : "i"(&_base_r13) : );             /* initialize anchor register (r13)                     */
        _init();                                                        /* initialize C-variables                               */
        __asm( "\n_cptable_handled:       ;; Symbol may be used by debugger" );
#if __PROF_ENABLE__
        __prof_init();                                                  /* set up profiling                                     */
#endif

#ifdef __FRAMEWORK__
        extern void framework_init(void);
        framework_init();
        #if ( __POSIX_KERNEL__ != 0 )
        posix_main();
        /* should never end up here */
        exit( 0 );
        #else
        exit( main( 0 ) );                                              /* call application                                     */
        #endif
#endif

        return;
}

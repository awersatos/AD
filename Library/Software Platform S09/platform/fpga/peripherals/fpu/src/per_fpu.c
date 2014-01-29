/*****************************************************************************\
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  IN PACKAGE:         FPU
|*
|*  COPYRIGHT:          Copyright (c) 2007, Altium
|*
|*  DESCRIPTION:        Runtime library interface to floating point unit. Do not call directly!
|*
 */

#include <per_fpu.h>        
#include <per_fpu_cfg_instance.h>

#if PER_FPU_INSTANCE_LIB_USES_FPU_TRUE_USED > 1
#error Only one FPU can be marked for use by the floating point runtime library!
#endif

#if PER_FPU_INSTANCE_LIB_USES_FPU_TRUE_USED

static volatile float * fpu = NULL;

/*
 * Initialize the FPU pointer for future use (pre-main)
 *
 * This function should never be called directly from your application!
  */

void fpu_rtl_init( void )
{
    for ( int i = 0; i < PER_FPU_INSTANCE_COUNT; i++ )
    {
        if ( per_fpu_instance_table[i].lib_uses_fpu )
        {
            fpu = (volatile float *)per_fpu_instance_table[i].baseaddress;
        }
    }
} 
 

/*
 * Convert a 16-bit integer to a single precision floating point number
 *
 * This function replaces the _f_itof function from the floating point runtime library
 */

float _f_itof( int32_t op1 )
{
    volatile int32_t * opr = (volatile int32_t *)fpu;
    opr[1] = op1;
    return fpu[6];
}

/*
 * Multiply 2 single precision floating point numbers
 *
 * This function replaces the _f_mul function from the floating point runtime library
 */

float _f_mul( float op1, float op2 )
{
    fpu[1] = op1;
    fpu[2] = op2;
    return fpu[4];
}

/*
 * Divide 2 single precision floating point numbers
 *
 * This function replaces the _f_div function from the floating point runtime library
 */

float _f_div( float op1, float op2 )
{
    fpu[1] = op1;
    fpu[2] = op2;
    return fpu[5];
}

/*
 * Add 2 single precision floating point numbers
 *
 * This function replaces the _f_add function from the floating point runtime library
 */

float _f_add( float op1, float op2 )
{
    fpu[1] = op1;
    fpu[2] = op2;
    return fpu[2];
}

/*
 * Subtract 2 single precision floating point numbers
 *
 * This function replaces the _f_sub function from the floating point runtime library
 */

float _f_sub( float op1, float op2 )
{
    fpu[1] = op1;
    fpu[2] = op2;
    return fpu[3];
}

/*
 * Convert a single precision floating point number to a 16-bit integer
 *
 * This function replaces the _f_ftoi function from the floating point runtime library
 */

int32_t _f_ftoi( float op1 )
{
    volatile int32_t * res = (volatile int32_t *)fpu;
    fpu[1] = op1;
    return res[7];
}
#else
void fpu_rtl_init( void )
{
    // Do nothing
}
#endif


















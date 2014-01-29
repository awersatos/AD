/*****************************************************************************\
|*
||*  COPYRIGHT:          Copyright (c) 2007, Altium
|*
|*  DESCRIPTION:
|*
 */

/**
 * @file
 * Device driver for WB_FPU peripheral.
 *
 */

#include <stdlib.h>
#include <assert.h>
#include <time.h>

#if __POSIX_KERNEL__
# include <pthread.h>
#else
# include <pal.h>
#endif

#include <per_fpu.h>
#include <drv_fpu.h>

struct drv_fpu_s
{
    uintptr_t   baseaddress;
} ;

// runtime driver table
static fpu_t drv_table[DRV_FPU_INSTANCE_COUNT];

/**
 * @brief    Open an instance of the driver
 *
 * This function initializes the WB_FPU core and its driver.
 * You should call it only once per instantiation.
 *
 * @param  id  valid driver id
 *
 * @return Driver pointer if succesful initialization, NULL otherwise
 */

fpu_t * fpu_open( unsigned int id )
{
    assert( id < DRV_FPU_INSTANCE_COUNT );

    fpu_t * restrict drv = &drv_table[id];
    drv_fpu_cfg_instance_t * restrict drv_cfg = &drv_fpu_instance_table[id];
    per_fpu_cfg_instance_t * restrict per_cfg = &per_fpu_instance_table[drv_cfg->per_fpu];

    drv->baseaddress = per_cfg->baseaddress;
    assert( drv->baseaddress != 0 );

    // And we're done!
    return drv;
}

/**
 * @brief    Floating point addition
 *
 * Add two floating point numbers
 *
 * @param   drv address of device driver structure
 * @param   op1 left operand of ADD operation
 * @param   op2 right operand of ADD operation
 *
 * @return op1 + op2
 */

float fpu_add( fpu_t * restrict drv, float op1, float op2 )
{
    FPU_FOPA( drv->baseaddress ) = op1;
    FPU_FOPB( drv->baseaddress ) = op2;
    return FPU_ADD_RESULT( drv->baseaddress );
}

/**
 * @brief    Floating point subtraction
 *
 * Subtract two floating point numbers
 *
 * @param   drv address of device driver structure
 * @param   op1 left operand of SUB operation
 * @param   op2 right operand of SUB operation
 *
 * @return op1 - op2
 */

float fpu_sub( fpu_t * restrict drv, float op1, float op2 )
{
    FPU_FOPA( drv->baseaddress ) = op1;
    FPU_FOPB( drv->baseaddress ) = op2;
    return FPU_SUB_RESULT( drv->baseaddress );
}

/**
 * @brief    Floating point multiplication
 *
 * Multiply two floating point numbers
 *
 * @param   drv address of device driver structure
 * @param   op1 left operand of MUL operation
 * @param   op2 right operand of MUL operation
 *
 * @return op1 * op2
 */


float fpu_mul( fpu_t * restrict drv, float op1, float op2 )
{
    FPU_FOPA( drv->baseaddress ) = op1;
    FPU_FOPB( drv->baseaddress ) = op2;
    return FPU_MUL_RESULT( drv->baseaddress );
}

/**
 * @brief    Floating point multiplication
 *
 * Multiply a floating point number by 2.0
 *
 * @param   drv address of device driver structure
 * @param   op1 left operand of MUL operation
 *
 * @return op1 * 2.0
 */

float fpu_mul2( fpu_t * restrict drv, float op1 )
{
    FPU_FOPAB( drv->baseaddress ) = op1;
    return FPU_ADD_RESULT( drv->baseaddress );
}

/**
 * @brief    Floating point division
 *
 * Divide two floating point numbers
 *
 * @param   drv address of device driver structure
 * @param   op1 left operand of DIV operation
 * @param   op2 right operand of DIV operation
 *
 * @return op1 / op2
 */

float fpu_div( fpu_t * restrict drv, float op1, float op2 )
{
    FPU_FOPA( drv->baseaddress ) = op1;
    FPU_FOPB( drv->baseaddress ) = op2;
    return FPU_DIV_RESULT( drv->baseaddress );
}

/**
 * @brief    Floating point involution
 *
 * Calculate square of two floating point numbers
 *
 * @param   drv address of device driver structure
 * @param   op1 operand of SQR operation
 *
 * @return op1 * op1
 */

float fpu_sqr( fpu_t * restrict drv, float op1 )
{
    FPU_FOPAB( drv->baseaddress ) = op1;
    return FPU_MUL_RESULT( drv->baseaddress );
}


/**
 * @brief    Integer conversion
 *
 * Convert an integer to a single precision floating point number
 *
 * @param   drv address of device driver structure
 * @param   op1 operand of conversion
 *
 * @return (float)op1
 */

float fpu_itof( fpu_t * restrict drv, int32_t op1 )
{
    FPU_IOPA( drv->baseaddress ) = op1;
    return FPU_ITOF_RESULT( drv->baseaddress );
}

/**
 * @brief    Floating point conversion
 *
 * Convert a single precision floating point number to a 32-bit integer
 *
 * @param   drv address of device driver structure
 * @param   op1 operand of conversion
 *
 * @return (int)op1
 */

int32_t fpu_ftoi( fpu_t * restrict drv, float op1 )
{
    FPU_FOPA( drv->baseaddress ) = op1;
    return FPU_FTOI_RESULT( drv->baseaddress );
}

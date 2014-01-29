/*****************************************************************************\
|*
|*  COPYRIGHT:          Copyright (c) 2008, Altium
|*
|*  DESCRIPTION:        
|*
 */

/**
 * @file
 * Device driver for floating point unit
 */
 
#ifndef _FPU_H
#define _FPU_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>
#include <drv_fpu_cfg_instance.h>

typedef struct drv_fpu_s fpu_t;

extern fpu_t * fpu_open( unsigned int id );

extern float fpu_add( fpu_t * restrict drv, float op1, float op2 );
extern float fpu_sub( fpu_t * restrict drv, float op1, float op2 );
extern float fpu_mul( fpu_t * restrict drv, float op1, float op2 );
extern float fpu_div( fpu_t * restrict drv, float op1, float op2 );

extern float fpu_mul2( fpu_t * restrict drv, float op1 );
extern float fpu_sqr( fpu_t * restrict drv, float op1 );

extern float fpu_itof( fpu_t * restrict drv, int32_t op1 );
extern int32_t fpu_ftoi( fpu_t * restrict drv, float op1 );

#ifdef  __cplusplus
}
#endif

#endif // _FPU_H

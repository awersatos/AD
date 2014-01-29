/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2008, Altium
|*
|*  Description:        Single precision floating point unit
|*
\*****************************************************************************/

#ifndef _PER_FPU_H
#define _PER_FPU_H

/**
 * @file
 * Direct access to the WB_FPU peripheral.
 * Generally, application writers will use a higher level interface.
 *
 */

#include <stdint.h>
#include <stdbool.h>

#define FPU_WORD(BASEADDR)      ((volatile uint32_t *)(BASEADDR))
#define FPU_INT(BASEADDR)       ((volatile int32_t *)(BASEADDR))
#define FPU_FLOAT(BASEADDR)     ((volatile float *) (BASEADDR))

/**
 * @name Core Registers
 */

/** @{ */
#define FPU_STAT(ADDR)          FPU_WORD(ADDR)[0]       /**< Status register */
#define FPU_IOPA(ADDR)          FPU_INT(ADDR)[1]        /**< Operand register A, accepts integer */
#define FPU_FOPA(ADDR)          FPU_FLOAT(ADDR)[1]      /**< Operand register A, accepts float */
#define FPU_FOPB(ADDR)          FPU_FLOAT(ADDR)[2]      /**< Operand register B */
#define FPU_FOPAB(ADDR)         FPU_FLOAT(ADDR)[3]      /**< Operand registers A and B */

#define FPU_ADD_RESULT(ADDR)    FPU_FLOAT(ADDR)[2]      /**< Result register for add operation */
#define FPU_SUB_RESULT(ADDR)    FPU_FLOAT(ADDR)[3]      /**< Result register for subtract operation */
#define FPU_MUL_RESULT(ADDR)    FPU_FLOAT(ADDR)[4]      /**< Result register for multiply operation */
#define FPU_DIV_RESULT(ADDR)    FPU_FLOAT(ADDR)[5]      /**< Result register for divide operation */
#define FPU_ITOF_RESULT(ADDR)   FPU_FLOAT(ADDR)[6]      /**< Result register for integer to float conversion */
#define FPU_FTOI_RESULT(ADDR)   FPU_INT(ADDR)[7]        /**< Result register for float to integer conversion */
/** @} */

/**
 * @name Core status register bitmasks
 */

/** @{ */
#define FPU_STAT_ADD_RDY    0x01    /**< Add unit ready */
#define FPU_STAT_SUB_RDY    0x02    /**< Subtract unit ready */
#define FPU_STAT_MUL_RDY    0x04    /**< Multiply unit ready */
#define FPU_STAT_DIV_RDY    0x08    /**< Division unit ready */
#define FPU_STAT_ITOF_RDY   0x10    /**< Integer to float conversion unit ready */
#define FPU_STAT_FTOI_RDY   0x20    /**< Float to integer conversion unit ready */

/** @} */

#endif /* _PER_FPU_H */

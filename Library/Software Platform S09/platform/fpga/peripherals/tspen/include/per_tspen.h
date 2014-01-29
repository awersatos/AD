/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2008, Altium
|*
|*  Description:        Touchscreen pen detection peripheral
|*
\*****************************************************************************/

#ifndef _PER_TSPEN_H
#define _PER_TSPEN_H

/**
 * @file
 * Direct access to the WB_TSPENDOWN peripheral.
 * Generally, application writers will use a higher level interface.
 *
 */

#include <stdint.h>
#include <stdbool.h>

#define TSPEN_BYTE(BASEADDR)    ((volatile uint8_t *)(BASEADDR))

/**
 * @name Core Registers
 */

/** @{ */
#define TSPEN_STAT(ADDR)        TSPEN_BYTE(ADDR)[0]     /**< Status register */
/** @} */

/**
 * @name Core status register bitmasks
 */

/** @{ */
#define TSPEN_STAT_PENDOWN      0x01                    /**< Pen is down on touchscreen */

/** @} */

typedef struct
{
    uintptr_t   baseaddress;
} per_tspen_t;

#endif /* _PER_TSPEN_H */

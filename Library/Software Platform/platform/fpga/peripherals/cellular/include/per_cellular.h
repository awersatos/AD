/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007-2010, Altium
|*
|*  Description:        CELLULAR peripheral direct access. Generally this
|*                      interface will not be used directly, but instead
|*                      through a higher level driver interface.
|*
\*****************************************************************************/

/**
 * @file
 * Direct access to the CELLULAR peripherals.
 * Generally, application writers will use a higher level interface.
 *
 * For a detailed description of the CELLULAR peripherals, see the Core Reference
 * <a href="zzz.PDF">zzz</a>
 *
 */

#ifndef _PER_CELLULAR_H
#define _PER_CELLULAR_H

#include <stdint.h>
#include "per_uart8.h"

#define CELLULAR_BASE(baseaddr)    ((volatile uint8_t *) baseaddr+UART8_HW_SIZE)

/**
 * @name Core Registers
 */
/** @{ */                                                  
#define CELLULAR_STATUS(addr)         CELLULAR_BASE(addr)[0]    /**< Status register */
#define CELLULAR_COMMAND(addr)        CELLULAR_BASE(addr)[1]    /**< Command register*/
/** @} */

/**
 * @name Core Command Register Values
 */
/** @{ */
#define CELLULAR_COMMAND_PWR_ON          0x01   /**< Turn CELLULAR peripheral on  */
#define CELLULAR_COMMAND_DTR             0x02   /**< Assert the CELLULAR DTR line */
/** @} */


#endif /* _PER_CELLULAR_H */


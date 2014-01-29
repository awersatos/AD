/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*
|*  Description:    I2CM peripheral direct access. Generally this
|*                  interface will not be used directly, but instead
|*                  through a higher level driver interface.
|*
 *****************************************************************************/

#ifndef _PER_I2CM_H
#define _PER_I2CM_H

/**
 * @file
 * Direct access to the I2CM_W peripheral.
 * Generally, application writers will use a higher level interface.
 *
 * See also CR0105 - I2CM Controller
 */

#include <stdint.h>         // Required for uint8_t

#define I2CM_BYTE( BASE )       ((volatile uint8_t * const) (BASE) )

/**
 * @name Core Registers
 */

/** @{ */
#define I2CM_CTRL( BASE )       I2CM_BYTE( BASE )[0]    /**< Control register */
#define I2CM_STAT( BASE )       I2CM_BYTE( BASE )[1]    /**< Status register */
#define I2CM_CLK0( BASE )       I2CM_BYTE( BASE )[2]    /**< Clock divisor, low byte */
#define I2CM_CLK1( BASE )       I2CM_BYTE( BASE )[3]    /**< Clock divisor, high byte */
#define I2CM_WRDAT( BASE )      I2CM_BYTE( BASE )[4]    /**< Write data buffer */
#define I2CM_RDDAT( BASE )      I2CM_BYTE( BASE )[5]    /**< Read data buffer */
/** @} */

/**
 * @name Core control register bitmasks
 */

/** @{ */
#define I2CM_CTRL_ENABLE        0x01    /**< Enable (core powers down if not set) */
#define I2CM_CTRL_IEN           0x02    /**< Interrupt enable */
#define I2CM_CTRL_IACK          0x04    /**< Interrupt acknowledge */
#define I2CM_CTRL_WR            0x08    /**< Write data to I2C bus */
#define I2CM_CTRL_RD            0x10    /**< Read data from I2C bus */
#define I2CM_CTRL_STO           0x20    /**< Generate a stop condition */
#define I2CM_CTRL_STA           0x40    /**< Generate a start condition */
#define I2CM_CTRL_NACK          0x80    /**< Generate a negative acknowledge on read */
/** @} */

/**
 * @name Core status register bitmasks
 */

/** @{ */
#define I2CM_STAT_INTREQ        0x01    /**< Interrupt request */
#define I2CM_STAT_RXACK         0x02    /**< ACK state from remote when transmitting */
#define I2CM_STAT_BUSY          0x04    /**< Core is busy, do not write control register */
/** @} */

#endif  // _PER_I2CM_H


/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2008, Altium
|*
|*  Description:        Dedicated SPI master controller:
|*
\*****************************************************************************/

#ifndef _PER_SPI_H
#define _PER_SPI_H

/**
 * @file
 * Direct access to the WB_SPI peripheral.
 * Generally, application writers will use a higher level interface.
 *
 */

#include <stdint.h>
#include <stdbool.h>

#define SPI_WORD(BASE)      ((volatile uint32_t *)(BASE))

/**
 * @name Core Registers
 */

/** @{ */
#define SPI_DATA8(BASE)     SPI_WORD(BASE)[0]   /**< 8-bit data transfer register (use lowest byte only!) */
#define SPI_DATA16(BASE)    SPI_WORD(BASE)[1]   /**< 16-bit data transfer register (use lowest bytes only!) */
#define SPI_DATA32(BASE)    SPI_WORD(BASE)[2]   /**< 32-bit data transfer register */
#define SPI_CTRL(BASE)      SPI_WORD(BASE)[3]   /**< Control register */
#define SPI_STAT(BASE)      SPI_WORD(BASE)[4]   /**< Status register */
#define SPI_CDIV(BASE)      SPI_WORD(BASE)[5]   /**< Clock divisor register */
#define SPI_GPIN(BASE)      SPI_WORD(BASE)[6]   /**< General purpose input pins */
#define SPI_CS(BASE)        SPI_WORD(BASE)[7]   /**< Chip Select output pins */
/** @} */

/**
 * @name Core control register bitmasks
 */

/** @{ */
#define SPI_CTRL_ENDIAN     0x20            /**< Endianess. Use big-endianess for multi-byte writes */
#define SPI_CTRL_CPHA       0x10            /**< Clock phase control. Data will change on leading edge and latched on trailing edge if set */
#define SPI_CTRL_CPOL       0x08            /**< Clock polarity control. Determines idle (inactive) state of SPI_CLK signal */
#define SPI_CTRL_MODE       0x04            /**< Mode pin control. Set to raise SPI_MODE pin */
#define SPI_CTRL_CS         0x02            /**< Chip select pin control. Set SPI_CS pin */
/** @} */

/**
 * @name Core status register bitmasks
 */

/** @{ */
#define SPI_STAT_BUSY       0x01            /**< Controller busy status flag. Set while a transfer is underway (FSM has left the IDLE state) */
#define SPI_STAT_8BIT       0x02            /**< Controller trasnfers size flag. If set Core only supports 8bit trasnfers */
/** @} */

typedef struct
{
    uintptr_t   baseaddress;
} per_spi_t;

#endif /* _PER_SPI_H */

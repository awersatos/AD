/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2008, Altium
|*
|*  Description:        Dedicated SD host controller:
|*
\*****************************************************************************/

#ifndef _PER_SDHC_H
#define _PER_SDHC_H

/**
 * @file
 * Direct access to the WB_SDHC peripheral.
 * Generally, application writers will use a higher level interface.
 *
 */

#include <stdint.h>
#include <stdbool.h>

#define SDHC_WORD(BASE)      ((volatile uint32_t *)(BASE))

/**
 * @name Core Registers
 */

/** @{ */
#define SDHC_CDIV(BASE)         SDHC_WORD(BASE)[0]   /**< Clock divisor register */
#define SDHC_CTRL(BASE)         SDHC_WORD(BASE)[1]   /**< Control register */
#define SDHC_STAT(BASE)         SDHC_WORD(BASE)[2]   /**< Status register */
#define SDHC_CMD_TXCMD(BASE)    SDHC_WORD(BASE)[3]   /**< 8-bit cmd transmitter command register */
#define SDHC_CMD_TXARG(BASE)    SDHC_WORD(BASE)[4]   /**< 32-bit cmd transmitter argument register */
#define SDHC_CMD_RXSIZE(BASE)   SDHC_WORD(BASE)[5]   /**< Cmd receiver size register */
#define SDHC_CMD_RXFIFO(BASE)   SDHC_WORD(BASE)[6]   /**< Cmd receiver data register */
#define SDHC_DAT_BLKSIZE(BASE)  SDHC_WORD(BASE)[7]   /**< Data block size (in bytes) */
#define SDHC_DAT_RXSIZE(BASE)   SDHC_WORD(BASE)[8]   /**< Data transfer size */
#define SDHC_DAT_MEMADR(BASE)   SDHC_WORD(BASE)[9]   /**< DMA address */
#define SDHC_VERSION_INFO(BASE) SDHC_WORD(BASE)[15]  /**< Version and configuration information */
/** @} */

/**
 * @name Core control register bitmasks
 */

/** @{ */
#define SDHC_CTRL_RESET         (0x00000001 <<  0 )  /**< Core reset */
#define SDHC_CTRL_CMD_TXENABLE  (0x00000001 <<  1 )  /**< Cmd transmit enable */
#define SDHC_CTRL_CMD_RXENABLE  (0x00000001 <<  2 )  /**< Cmd receive enable */
#define SDHC_CTRL_DAT_TXENABLE  (0x00000001 <<  3 )  /**< Data transmit enable */
#define SDHC_CTRL_DAT_RXENABLE  (0x00000001 <<  4 )  /**< Data receive enable */
#define SDHC_CTRL_ENDIANESS     (0x00000001 <<  5 )  /**< DMA endianess */
#define SDHC_CTRL_RSTMASK       (0x00000001 << 30 )  /**< Reset bits only */
#define SDHC_CTRL_SETMASK       (0x00000001 << 31 )  /**< Set bits only */

/** @} */

/**
 * @name Core status register bitmasks
 */

/** @{ */
#define SDHC_STAT_SD_DETECT     (0x00000001 <<  0 )  /**< Value of sd_detect pin */
#define SDHC_STAT_SD_PROTECT    (0x00000001 <<  1 )  /**< Value of sd_protect pin */
#define SDHC_STAT_SD_REMOVED    (0x00000001 <<  2 )  /**< Set if media has been removed, must be reset through software */

#define SDHC_STAT_CMD_TXENABLE  (0x00000001 <<  3 )  /**< Copy of SDHC_CTRL_CMD_TXENABLE */
#define SDHC_STAT_CMD_TXBUSY    (0x00000001 <<  4 )  /**< CMD transmitter is actively transmitting */

#define SDHC_STAT_CMD_RXENABLE  (0x00000001 <<  5 )  /**< Copy of SDHC_CTRL_CMD_RXENABLE */
#define SDHC_STAT_CMD_RXBUSY    (0x00000001 <<  6 )  /**< CMD receiver is actively receiving */
#define SDHC_STAT_CMD_RXFULL    (0x00000001 <<  7 )  /**< CMD receiver FIFO is full */
#define SDHC_STAT_CMD_RXEMPTY   (0x00000001 <<  8 )  /**< CMD receiver FIFO is empty */
#define SDHC_STAT_CMD_CRCERR    (0x00000001 <<  9 )  /**< CMD receiver detected a CRC error */

#define SDHC_STAT_DAT_TXENABLE  (0x00000001 << 10 )  /**< Copy of SDHC_CTRL_DAT_TXENABLE */
#define SDHC_STAT_DAT_TXBUSY    (0x00000001 << 11 )  /**< DAT transmitter is actively transmitting */

#define SDHC_STAT_DAT_RXENABLE  (0x00000001 << 12 )  /**< Copy of SDHC_CTRL_DAT_RXENABLE */
#define SDHC_STAT_DAT_RXBUSY    (0x00000001 << 13 )  /**< DAT receiver is actively receiving */
#define SDHC_STAT_DMA_TIMEOUT   (0x00000001 << 14 )  /**< DMA overrun or underrun */
#define SDHC_STAT_DAT_CRCERR    (0x00000001 << 15 )  /**< Data transceiver detected a CRC error */
#define SDHC_STAT_DAT_READY     (0x00000001 << 16 )  /**< Data transceiver busy waiting if not set */
/** @} */

#endif /* _PER_SDHC_H */

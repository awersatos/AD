/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2008, Altium
|*
|*  Description:        S29 FLASH device, low level interface. Application
|*                      witers should generally use a higher level interface.
|*
\*****************************************************************************/

/**
 * @file
 * Direct access to the S29 Flash memory.
 * Generally, application writers will use a higher level interface.
 *
 */

#ifndef _PER_S29_H
#define _PER_S29_H

#ifndef FLASH_SHIFT_ADDR_LINES
# define FLASH_SHIFT_ADDR_LINES     0           /**< For some chips the memory addresses need to be shifted. */
#endif

#if FLASH_SHIFT_ADDR_LINES == 0
# ifdef __LITTLE_ENDIAN__
#   define FLASH_ADDR(x) ((x) ^ 1)
# else
#   define FLASH_ADDR(x) (x)
# endif
#else
#  define FLASH_ADDR(x) ((x) << FLASH_SHIFT_ADDR_LINES)
#endif

/**
 * @name Magic addresses
 */
/** @{ */
#define FLASH_ADDR_UNLOCK1          FLASH_ADDR(0x555)   /**< Unlock address #1 */
#define FLASH_ADDR_UNLOCK2          FLASH_ADDR(0x2AA)   /**< Unlock address #2 */
#define FLASH_ADDR_MAN_ID           FLASH_ADDR(0x00)    /**< Read: manufacturer ID */
#define FLASH_ADDR_DEV_ID           FLASH_ADDR(0x01)    /**< Read: device ID */
#define FLASH_ADDR_DEV_ID1          FLASH_ADDR(0x0E)    /**< Read: Device ID data #1 */
#define FLASH_ADDR_DEV_ID2          FLASH_ADDR(0x0F)    /**< Read: Device ID data #2 */
/** @} */

/**
 * @name Magic command values
 */
/** @{ */
#define FLASH_CMD_PRE1              0xAA        /**< PRE1 */
#define FLASH_CMD_PRE2              0x55        /**< PRE2 */
#define FLASH_CMD_PRG               0xA0        /**< PRG */
#define FLASH_CMD_ERA1              0x80        /**< ERA1 */
#define FLASH_CMD_ERA2              0x10        /**< Chip erase */
#define FLASH_CMD_ERA3              0x30        /**< Sector erase */
#define FLASH_CMD_AUTO              0x90        /**< Auto select mode */
#define FLASH_CMD_RESET             0xF0        /**< Reset chip */
#define FLASH_CMD_WBL               0x25        /**< Write buffer load */
#define FLASH_CMD_PBF               0x29        /**< Program buffer to flash */
#define FLASH_CMD_CFI               0x98        /**< Switch to CFI mode */
/** @} */

#define FLASH_DQ6                   (1<<6)      /**< Bit mask to test program/erase status */

/**
 * @name CFI interface
 */
/** @{ */
#define FLASH_ADDR_CFI              FLASH_ADDR(0x55)    /**< CFI */
#define FLASH_ADDR_CFI_QUERY0       FLASH_ADDR(0x10)    /**< Should read 'Q' */
#define FLASH_ADDR_CFI_QUERY1       FLASH_ADDR(0x11)    /**< Should read 'R' */
#define FLASH_ADDR_CFI_QUERY2       FLASH_ADDR(0x12)    /**< Should read 'Y' */
#define FLASH_ADDR_CFI_WRWORD_TO    FLASH_ADDR(0x1F)    /**< Typical word write timeout */
#define FLASH_ADDR_CFI_WRBUF_TO     FLASH_ADDR(0x20)    /**< Typical buffer write timeout (note: usec!) */
#define FLASH_ADDR_CFI_SECTERA_TO   FLASH_ADDR(0x21)    /**< Typical sector erase timeout */
#define FLASH_ADDR_CFI_CHIPERA_TO   FLASH_ADDR(0x22)    /**< Typical full chip erase timeout */
#define FLASH_ADDR_CFI_WRWORD_MUL   FLASH_ADDR(0x23)    /**< Max. word write timeout multiplier */
#define FLASH_ADDR_CFI_WRBUF_MUL    FLASH_ADDR(0x24)    /**< Max. buffer write timeout multiplier */
#define FLASH_ADDR_CFI_SECTERA_MUL  FLASH_ADDR(0x25)    /**< Max. sector erase timeout multiplier */
#define FLASH_ADDR_CFI_CHIPERA_MUL  FLASH_ADDR(0x26)    /**< Max. full chip erase timeout multiplier */
#define FLASH_ADDR_CFI_DEVSIZE      FLASH_ADDR(0x27)    /**< Device size in bytes as power of 2 */
#define FLASH_ADDR_CFI_BUFSIZE_L    FLASH_ADDR(0x2A)    /**< Buffered writing max bufsize, least significant word */
#define FLASH_ADDR_CFI_BUFSIZE_H    FLASH_ADDR(0x2B)    /**< Buffered writing max bufsize, most significant word */
#define FLASH_ADDR_CFI_EBR          FLASH_ADDR(0x2C)    /**< Erase blocks in device */
#define FLASH_ADDR_CFI_EBRI         FLASH_ADDR(0x2D)    /**< Erase block #0 information */
#define FLASH_ADDR_CFI_EBRI_COUNT_L FLASH_ADDR(0x2D)    /**< Erase block #0 blockcount, least significant word */
#define FLASH_ADDR_CFI_EBRI_COUNT_H FLASH_ADDR(0x2E)    /**< Erase block #0 blockcount, most significant word */
#define FLASH_ADDR_CFI_EBRI_SIZE_L  FLASH_ADDR(0x2F)    /**< Erase block #0 blocksize, least significant word */
#define FLASH_ADDR_CFI_EBRI_SIZE_H  FLASH_ADDR(0x30)    /**< Erase block #0 blocksize, most significant word */
/** @} */

#endif /* _PER_S29_H */

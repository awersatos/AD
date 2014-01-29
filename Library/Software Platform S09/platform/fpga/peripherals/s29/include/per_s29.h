/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2008, Altium
|*
|*  Description:        S29 FLASH device, low level interface. Application
|*                      witers should generally use a higher level interface.
|*
\*****************************************************************************/

#ifndef _PER_S29_H
#define _PER_S29_H

#ifndef FLASH_SHIFT_ADDR_LINES
# define FLASH_SHIFT_ADDR_LINES     0           /**< For some chips the memory addresses need to be shifted. */
#endif

/* Magic addresses */
#define FLASH_ADDR_UNLOCK1          (0x555 << FLASH_SHIFT_ADDR_LINES)   /**< Unlock address #1 */
#define FLASH_ADDR_UNLOCK2          (0x2AA << FLASH_SHIFT_ADDR_LINES)   /**< Unlock address #2 */
#define FLASH_ADDR_MAN_ID           (0x00 << FLASH_SHIFT_ADDR_LINES)    /**< Read: manufacturer ID */
#define FLASH_ADDR_DEV_ID           (0x01 << FLASH_SHIFT_ADDR_LINES)    /**< Read: device ID */
#define FLASH_ADDR_DEV_ID1          (0x0E << FLASH_SHIFT_ADDR_LINES)    /**< Read: Device ID data #1 */
#define FLASH_ADDR_DEV_ID2          (0x0F << FLASH_SHIFT_ADDR_LINES)    /**< Read: Device ID data #2 */

/* Magic command values */
#define FLASH_CMD_PRE1              0xAA        /**< */
#define FLASH_CMD_PRE2              0x55        /**< */
#define FLASH_CMD_PRG               0xA0        /**< */
#define FLASH_CMD_ERA1              0x80        /**< */
#define FLASH_CMD_ERA2              0x10        /**< Chip erase */
#define FLASH_CMD_ERA3              0x30        /**< Sector erase */
#define FLASH_CMD_AUTO              0x90        /**< Auto select mode */
#define FLASH_CMD_RESET             0xF0        /**< Reset chip */
#define FLASH_CMD_WBL               0x25        /**< Write buffer load */
#define FLASH_CMD_PBF               0x29        /**< Program buffer to flash */

#define FLASH_DQ6                   (1<<6)      /**< Bit mask to test program/erase status */

/* CFI interface */
#define FLASH_ADDR_CFI              (0x55 << FLASH_SHIFT_ADDR_LINES)    /**< Switch to CFI mode */
#define FLASH_CMD_CFI               0x98

#define FLASH_ADDR_CFI_QUERY0       (0x10 << FLASH_SHIFT_ADDR_LINES)    /**< Should read 'Q' */
#define FLASH_ADDR_CFI_QUERY1       (0x11 << FLASH_SHIFT_ADDR_LINES)    /**< Should read 'R' */
#define FLASH_ADDR_CFI_QUERY2       (0x12 << FLASH_SHIFT_ADDR_LINES)    /**< Should read 'Y' */
#define FLASH_ADDR_CFI_DEVSIZE      (0x27 << FLASH_SHIFT_ADDR_LINES)    /**< Device size in bytes as power of 2 */
#define FLASH_ADDR_CFI_EBR          (0x2C << FLASH_SHIFT_ADDR_LINES)    /**< Erase blocks in device */
#define FLASH_ADDR_CFI_EBRI         (0x2D << FLASH_SHIFT_ADDR_LINES)    /**< Erase block #0 information */
#define FLASH_ADDR_CFI_CHIPERA_TO   (0x22 << FLASH_SHIFT_ADDR_LINES)    /**< Typical full chip erase timeout */
#define FLASH_ADDR_CFI_CHIPERA_MUL  (0x26 << FLASH_SHIFT_ADDR_LINES)    /**< Max. full chip erase timeout multiplier */
#define FLASH_ADDR_CFI_SECTERA_TO   (0x21 << FLASH_SHIFT_ADDR_LINES)    /**< Typical sector erase timeout */
#define FLASH_ADDR_CFI_SECTERA_MUL  (0x25 << FLASH_SHIFT_ADDR_LINES)    /**< Max. sector erase timeout multiplier */
#define FLASH_ADDR_CFI_WRWORD_TO    (0x1F << FLASH_SHIFT_ADDR_LINES)    /**< Typical word write timeout */
#define FLASH_ADDR_CFI_WRWORD_MUL   (0x23 << FLASH_SHIFT_ADDR_LINES)    /**< Max. word write timeout multiplier */
#define FLASH_ADDR_CFI_WRBUF_TO     (0x20 << FLASH_SHIFT_ADDR_LINES)    /**< Typical buffer write timeout (note: usec!) */
#define FLASH_ADDR_CFI_WRBUF_MUL    (0x24 << FLASH_SHIFT_ADDR_LINES)    /**< Max. buffer write timeout multiplier */
#define FLASH_ADDR_CFI_BUFSIZE_L    (0x2A << FLASH_SHIFT_ADDR_LINES)    /**< Buffered writing max bufsize, least significant word */
#define FLASH_ADDR_CFI_BUFSIZE_H    (0x2B << FLASH_SHIFT_ADDR_LINES)    /**< Buffered writing max bufsize, most significant word */

#endif /* _PER_S29_H */

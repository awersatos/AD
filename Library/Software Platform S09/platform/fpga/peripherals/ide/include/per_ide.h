/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
\*****************************************************************************/

/**
 * @file
 *
 * @brief
 *      WB_IDE peripheral
 *
 * This interface provides direct access to the WB_IDE peripheral. Normally,
 * you do not need this interface because higher level interfaces are
 * available.
 *
 * For a detailed description of the WB_IDE peripheral, see the Core Reference
 * <a href="CR0172 WB_IDE IDE Interface Controller.PDF">WB_IDE - IDE Interface Controller</a>
 */

#ifndef _PER_IDE_H
#define _PER_IDE_H

#include <stdint.h>

#define IDECORE_BASE( address )         ( (volatile uint32_t * const)(address) )        /**< Device base address for register definitions. */

/*
 * Core Registers
 */
#define IDECORE_DATA( address )         IDECORE_BASE( address )[0]       /**< Data register. */
#define IDECORE_COMMAND( address )      IDECORE_BASE( address )[1]       /**< Command register. */
#define IDECORE_MEMSTART( address )     IDECORE_BASE( address )[2]       /**< Register containing start address of memory buffer. */
#define IDECORE_SETUP( address )        IDECORE_BASE( address )[3]       /**< Setup register. */

/*
 * Core Register Flags
 */
#define IDECORE_DATA_BUSY               0x00010000      /**< This data register bit is set when the device is busy. */
#define IDECORE_DATA_DETECT             0x00020000      /**< This data register bit is set when a CF card is present in the card reader. */

#define IDECORE_COMMAND_REGSELECT       0x001F          /**< Select a register. */
#define IDECORE_COMMAND_SECTOR          0x0020          /**< Select a sector. */
#define IDECORE_COMMAND_BUSYCHECK       0x0040          /**< Automatically update busy flag. */
#define IDECORE_COMMAND_WRITE           0x0080          /**< Start a write request. */

#define IDECORE_SETUP_DELAY_SETUP       0x0007          /**< TBD */
#define IDECORE_SETUP_DELAY_PULSE       0x00F8          /**< TBD */
#define IDECORE_SETUP_DELAY_RECOVER     0x1FC0          /**< TBD */
#define IDECORE_SETUP_CSEL              0x2000          /**< TBD */
#define IDECORE_SETUP_RESET             0x4000          /**< TBD */
#define IDECORE_SETUP_POWERDOWN         0x8000          /**< TBD */

#endif /* _PER_IDE_H */

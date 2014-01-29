/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    Registers and flags of the PS2_W peripheral.
|*
\*****************************************************************************/

/**
 * @file
 *
 * @brief
 *      PS2_W peripheral
 *
 * This interface provides direct access to the PS2_W peripheral. Normally,
 * you do not need this interface because higher level interfaces are
 * available.
 *
 * For a detailed description of the PS2_W peripheral, see the Core
 * Reference <a href="CR0109 PS2 Controller.PDF">PS2 Controller</a>.
 */

#ifndef _PER_PS2_H
#define _PER_PS2_H

#include <stdint.h>

#define PS2_BASE(address)       ((volatile uint8_t * const)(address))   /**< Device base address for register definitions. */

#define PS2_CTRL(address)       PS2_BASE(address)[0]                    /**< Control register access. */
#define PS2_DATA(address)       PS2_BASE(address)[1]                    /**< Data register access. */

#define PS2_CTRL_BUSY_FLAG      0x1                                     /**< This control register bit indicates whether the device is busy. */
#define PS2_CTRL_STROBE_FLAG    0x2                                     /**< Set this control register bit to start data transmition. */

#endif /* _PER_PS2_H */

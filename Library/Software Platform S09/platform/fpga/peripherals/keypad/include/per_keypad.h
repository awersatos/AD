/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007, Altium
|*
|*  Description:        keypad peripheral direct access. Generally this
|*                      interface will not be used directly, but instead
|*                      through a higher level driver interface.
|*
\*****************************************************************************/

/**
 * @file
 * Direct access to the KEYPADA_W peripheral.
 * Generally, application writers will use a higher level interface.
 *
 * For a detailed description of the KEYPADA_W peripheral, see the Core Reference
 * <a href="CR0106 Keypad Controller.PDF">CR0106 Keypad Controller</a>
 *
 */

#ifndef _PER_KEYPAD_H
#define _PER_KEYPAD_H

#include <stdint.h>

#define KEYPAD_BASE(baseaddr)    ((volatile uint8_t *) baseaddr)

/**
 * @name Core Registers
 */
/** @{ */
#define KEYPAD_KEYREG(addr)      KEYPAD_BASE(addr)[0]    /**< key value */
#define KEYPAD_VALKEYREG(addr)   KEYPAD_BASE(addr)[1]    /**< valid key value (bit 0) */
/** @} */

#endif /* _PER_KEYPAD_H */


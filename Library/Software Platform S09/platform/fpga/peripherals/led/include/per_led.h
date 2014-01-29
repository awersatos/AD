/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2009, Altium
|*
|*  Description:        Direct access to the WB_LED_CTRL peripheral. Generally
|*                      this interface will not be used directly, but instead
|*                      through a higher level driver interface.
|*
\*****************************************************************************/

/**
 * @file
 * Direct access to the WB_LED_CTRL peripheral.
 * Generally, application writers will use a higher level interface.
 */

#ifndef _PER_LED_H
#define _PER_LED_H

#include <stdint.h>

#define LED_BASE8(base)      ((volatile uint8_t *) base)

#endif /* ndef _PER_LED_H */



/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007, Altium
|*
\*****************************************************************************/

/**
 * @file
 * PRTIO peripheral direct access.
 * Generally this interface will not be used directly,
 * but instead through a higher level driver interface.
 *
 */

#ifndef _IOPORT_H
#define _IOPORT_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>

#define IOPORT_BASE32(base)     ((volatile uint32_t *) base)
#define IOPORT_BASE16(base)     ((volatile uint16_t *) base)
#define IOPORT_BASE8(base)      ((volatile uint8_t *) base)

extern uint32_t per_ioport_get_base_address ( int id  );

#ifdef  __cplusplus
}
#endif

#endif /* _IOPORT_H */


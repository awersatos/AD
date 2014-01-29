/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2008, Altium
|*
\*****************************************************************************/

/**
 * @file
 * Custom Instrument peripheral direct access.
 * Generally this interface will not be used directly,
 * but instead through a higher level driver interface.
 *
 */

#ifndef _INSTRUMENT_H_
#define _INSTRUMENT_H_

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>


#define INSTRUMENT_BASE32(base)     ((volatile uint32_t *) base)
#define INSTRUMENT_BASE16(base)     ((volatile uint16_t *) base)
#define INSTRUMENT_BASE8(base)      ((volatile uint8_t *) base)


extern uint32_t per_instrument_get_base_address(int id);


#ifdef  __cplusplus
}
#endif

#endif /* _INSTRUMENT_H_ */


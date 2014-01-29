/*****************************************************************************\
|*
|*  COPYRIGHT:          Copyright (c) 2008, Altium
|*
|*  DESCRIPTION:
|*
 */

////////////////////////////////////////////////////////////////////////////////
/**
 * @file
 * Device driver for max6966 (10-Port Constant-Current LED Driver) peripheral.
 *
 */
////////////////////////////////////////////////////////////////////////////////

#ifndef _MAX6966_H
#define _MAX6966_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <time.h>
#include <stdint.h>

////////////////////////////////////////////////////////////////////////////////
typedef struct drv_max6966_s max6966_t;

////////////////////////////////////////////////////////////////////////////////
max6966_t * max6966_open( uint32_t id );
void max6966_Reset(max6966_t *drv);
void max6966_set_channel_duty(max6966_t *drv, uint8_t channel, uint8_t duty);

#ifdef  __cplusplus
}
#endif

#endif // _MAX6966_H


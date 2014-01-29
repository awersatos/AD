/*****************************************************************************
|*
|*  COPYRIGHT:          Copyright (c) 2008, Altium
|*
|*  Description:        I2C master device driver.
|*
\*****************************************************************************/

/**
 * @file
 * Device driver for I2C master peripheral.
 */

#ifndef _DRV_I2CM_H
#define _DRV_I2CM_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

typedef struct drv_i2cm_s   i2cm_t;

extern i2cm_t * i2cm_open( unsigned int id );
extern int i2cm_putchar( i2cm_t * restrict drv, bool start, const uint8_t data );
extern int i2cm_getchar( i2cm_t * restrict drv, bool start, bool ack );
extern int i2cm_write( i2cm_t * restrict drv, const uint8_t address, const uint8_t * data, size_t length );
extern int i2cm_read( i2cm_t * restrict drv, const uint8_t address, uint8_t * data, size_t length );
extern int i2cm_stop( i2cm_t * restrict drv );

extern int i2cm_get_bus( i2cm_t * restrict drv );
extern void i2cm_release_bus( i2cm_t * restrict drv );

#ifdef  __cplusplus
}
#endif

#endif // _DRV_I2CM_H

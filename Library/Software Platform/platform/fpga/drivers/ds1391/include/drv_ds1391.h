/*****************************************************************************\
|*
|*  COPYRIGHT:          Copyright (c) 2008, Altium
|*
|*  DESCRIPTION:        
|*
 */

/**
 * @file
 * Device driver for DS1391 (Real Time Clock) peripheral.
 *
 */
 
#ifndef _DS1391_H
#define _DS1391_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <time.h>

typedef struct drv_ds1391_s ds1391_t;

extern ds1391_t * ds1391_open( unsigned int id );
extern int ds1391_get_time( ds1391_t * drv, struct tm * t );
extern int ds1391_set_time( ds1391_t * drv, struct tm * t );

#ifdef  __cplusplus
}
#endif

#endif // _DS1391_H

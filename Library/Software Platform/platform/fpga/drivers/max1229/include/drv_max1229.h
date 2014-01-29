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
 * Device driver for max1229 (Real Time Clock) peripheral.
 *
 */
////////////////////////////////////////////////////////////////////////////////

#ifndef _max1229_H
#define _max1229_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <time.h>
#include <stdint.h>

////////////////////////////////////////////////////////////////////////////////
#define cCurrentSense_ConversionRegister    0x80
#define cCurrentSense_SetupRegister         0x40
#define cCurrentSense_AveragingRegister     0x20
#define cCurrentSense_ResetRegister         0x10
#define cCurrentSense_ScanChannelWithAvg    0x04
#define cCurrentSense_NoScan                0x06
#define cCurrentSense_MeasureTemperature    0x01
#define cCurrentSense_ExternallyTimed       0x30
#define cCurrentSense_InternalReference     0x08
#define cCurrentSense_ExternalReference     0x04
#define cCurrentSense_EnableAvergaing       0x10
#define cCurrentSense_Averge32Conversions   0x10
#define cCurrentSense_AvergeScanMode12      0x03

////////////////////////////////////////////////////////////////////////////////
typedef struct drv_max1229_s max1229_t;

////////////////////////////////////////////////////////////////////////////////
max1229_t * max1229_open( uint32_t id );
void max1229_Reset(max1229_t *drv);
uint32_t max1229_ReadTemperature(max1229_t *drv);
uint32_t max1229_ReadChannel(max1229_t *drv, uint8_t channel);

#ifdef  __cplusplus
}
#endif

#endif // _max1229_H


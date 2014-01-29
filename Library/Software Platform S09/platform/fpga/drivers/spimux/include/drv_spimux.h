/*****************************************************************************\
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  IN PACKAGE:
|*
|*  COPYRIGHT:          Copyright (c) 2007, Altium
|*
|*  DESCRIPTION:
|*
 */

/**
 * @file
 * Public interface to the NanoBoard SPI multiplexer.
 * This interface is also available through drv_spi.h include file.
 */

#ifndef _SPIMUX_H
#define _SPIMUX_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>

/**
 * @name Component identifiers for NB2 multiplexer
 */
/** @{ */
#define DEVICE_M25P40_CONFIGURATION 1   /**< M25P40-Configuration */
#define DEVICE_M25P40_EMBEDDED      2   /**< M25P40-Embedded */
#define DEVICE_TESTER               3
#define DEVICE_CLOCK                4   /**< Board clock */
#define DEVICE_TS                   5   /**< Touchscreen */
#define DEVICE_RTC                  6   /**< Real Time Clock */
#define DEVICE_EXTA0                7   /**< Extension Board A Channel 0 */
#define DEVICE_EXTA1                8   /**< Extension Board A Channel 1 */
#define DEVICE_EXTB0                9   /**< Extension Board B Channel 0 */
#define DEVICE_EXTB1                10  /**< Extension Board B Channel 1 */
#define DEVICE_EXTC0                11  /**< Extension Board C Channel 0 */
#define DEVICE_EXTC1                12  /**< Extension Board B Channel 1 */
#define DEVICE_1WIRE_NB             16
#define DEVICE_BOOTFLASH            21
#define DEVICE_NORMFLASH            22
/** @} */

typedef struct drv_spi_s spimux_t;

extern spimux_t * spimux_open( int id );
extern bool spi_get_bus( spimux_t * restrict drv, uint8_t channel );
extern void spi_release_bus( spimux_t * restrict drv );

#ifdef  __cplusplus
}
#endif

#endif // _SPIMUX_H

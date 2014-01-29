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
 * Interface to device driver for WB_SPI peripheral.
 *
 */

#ifndef _SPI_H
#define _SPI_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>
#include <drv_spi_cfg_instance.h>

/**
 * @brief SPI modes
 *
 * SPI mode
 */
typedef enum
{
    SPI_MODE0,  /**< Mode 0 */
    SPI_MODE1,  /**< Mode 1 */
    SPI_MODE2,  /**< Mode 2 */
    SPI_MODE3   /**< Mode 3 */
} spi_mode_t;

typedef struct drv_spi_s spi_t;

extern spi_t * spi_open( int id );
extern void spi_set_baudrate( spi_t * restrict drv, uint32_t baudrate );
extern uint32_t spi_get_baudrate( spi_t * restrict drv );
extern void spi_set_endianess( spi_t * restrict drv, bool endianess );
extern void spi_set_mode( spi_t * restrict drv, const spi_mode_t mode );

extern void spi_cs_lo( spi_t * restrict drv );
extern void spi_cs_hi( spi_t * restrict drv );

extern void spi_transmit8( spi_t * restrict drv, uint8_t val );
extern void spi_transmit16( spi_t * restrict drv, uint16_t val );
extern void spi_transmit32( spi_t * restrict drv, uint32_t val );

extern uint8_t spi_transceive8( spi_t * restrict drv, uint8_t val );
extern uint16_t spi_transceive16( spi_t * restrict drv, uint16_t val );
extern uint32_t spi_transceive32( spi_t * restrict drv, uint32_t val );

extern uint8_t spi_received8( spi_t * restrict drv );
extern uint16_t spi_received16( spi_t * restrict drv );
extern uint32_t spi_received32( spi_t * restrict drv );

extern void spi_readblock( spi_t * restrict drv, uint8_t * buf, int bufsize );
extern void spi_writeblock( spi_t * restrict drv, uint8_t * buf, int bufsize );

extern uint8_t spi_get_gpin( spi_t * restrict drv );

#if DRV_SPI_INSTANCE_NB_MULTIPLEX_SUPPORT_TRUE_USED

 
/**
 * @name Component channel numbers for NB multiplexer
 */
/** @{ */
#define DEVICE_M25P40_CONFIGURATION 1    /**< M25P40-Configuration */       
#define DEVICE_M25P40_EMBEDDED      2    /**< M25P40-Embedded */            
#define DEVICE_TESTER               3
#define DEVICE_CLOCK                4    /**< Board clock */                
#define DEVICE_TS                   5    /**< Touch screen */                
#define DEVICE_RTC                  6    /**< Real Time Clock */            
#define DEVICE_EXTA0                7    /**< Extension Board A Channel 0 */
#define DEVICE_EXTA1                8    /**< Extension Board A Channel 1 */
#define DEVICE_EXTB0                9    /**< Extension Board B Channel 0 */
#define DEVICE_EXTB1                10   /**< Extension Board B Channel 1 */
#define DEVICE_EXTC0                11   /**< Extension Board C Channel 0 */
#define DEVICE_EXTC1                12   /**< Extension Board B Channel 1 */
#define DEVICE_1WIRE_NB             16
#define DEVICE_BOOTFLASH            21
#define DEVICE_NORMFLASH            22
/** @} */
#endif

extern bool spi_get_bus( spi_t * restrict drv, uint8_t channel );
extern void spi_release_bus( spi_t * restrict drv );
extern bool spi_init_channel( spi_t * restrict drv, uint8_t channel, uint32_t baudrate, spi_mode_t spimode );
extern bool spi_busy( spi_t * restrict drv );

#ifdef  __cplusplus
}
#endif

#endif // _SPI_H

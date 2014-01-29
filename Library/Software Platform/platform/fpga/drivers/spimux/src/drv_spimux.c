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
 * Interface to SPI multiplexer
 *
 */

#include <stdlib.h>
#include <assert.h>

// Please note: the order in which the following files are included _is important_!
#include <drv_spi.h>
#include <drv_spimux.h>
#include <drv_spimux_cfg_instance.h>

/**
 * @brief    Open an instance of the driver
 *
 * This function retrieves the SPI device driver ID and calls spi_open.
 *
 * @param  id  valid driver id
 *
 * @return Driver pointer if succesful initialization, NULL otherwise
 */

spimux_t * spimux_open( int id )
{
    assert( id < DRV_SPI_INSTANCE_COUNT );

    const drv_spimux_cfg_instance_t * restrict drv_cfg = &drv_spimux_instance_table[id];
    return spi_open( drv_cfg->drv_spi );
}

/**
 * @brief    Get control of the SPI bus
 *
 * This function gets control over the SPI bus
 *
 * @param  drv  spimux context pointer as returned by spimux_open
 * @param  channel  channel to transfer control to if the bus request is honoured
 *
 * @return true if succesful, false otherwise
 */

extern bool spi_get_bus( spimux_t * restrict drv, uint8_t channel );

/**
 * @brief    Release control of the SPI bus
 *
 * This function releases control over the SPI bus to the system
 *
 * @param  drv  spimux context pointer as returned by spimux_open
 *
 * @return Nothing
 */

extern void spi_release_bus( spimux_t * restrict drv );


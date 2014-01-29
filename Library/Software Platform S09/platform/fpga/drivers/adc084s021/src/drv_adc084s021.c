/*****************************************************************************\
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  IN PACKAGE:
|*
|*  COPYRIGHT:          Copyright (c) 2009, Altium
|*
|*  DESCRIPTION:
|*
 */

/**
 * @file
 * Device driver for National Semiconductor ADC084S021 4 Channel, 50 ksps to 200 Ksps, 8-Bit A/D Converter
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#include <drv_spi.h>
#include <drv_adc084s021.h>
#include <drv_adc084s021_cfg_instance.h>
#include <util_endian.h>

/*
 * driver data
 */
struct drv_adc084s021_s
{
    spi_t   *spi;
    uint8_t next_channel;
};

/*
 * driver table
 */
static adc084s021_t drv_table[DRV_ADC084S021_INSTANCE_COUNT];

/**
 * @brief    Open an instance of the driver
 *
 * This function initializes the adc084s021 device driver.
 *
 * @param  id  valid driver id
 *
 * @return Driver pointer if succesful - NULL otherwise
 */

adc084s021_t * adc084s021_open( unsigned int id )
{
    spi_t * spi;

    assert( id < DRV_ADC084S021_INSTANCE_COUNT );

    // Copy peripheral data to driver table
    adc084s021_t * restrict drv = &drv_table[id];
    drv_adc084s021_cfg_instance_t * restrict drv_cfg = &drv_adc084s021_instance_table[id];

    spi = spi_open(drv_cfg->drv_spi);
    if (spi == NULL)
    {
        /* Unable to open SPI bus device driver */
        return NULL;
    }

    spi_set_endianess(spi, true);
    drv->spi = spi;

    spi_cs_hi(drv->spi);

    return drv;
}

/**
 * @brief    Read a single value from the AD converter
 *
 * This function reads a single value from the adc084s021 device.
 *
 * @param   drv             pointer to opened device driver
 * @param   next_channel    channel for the next read (0 .. 3)
 *
 * @return  -1 on error, value read from ADC otherwise
 */

int adc084s021_read( adc084s021_t * restrict drv, int next_channel )
{
    int val = -1;

    assert( drv != NULL );
    assert( next_channel >= 0 );
    assert( next_channel < 4 );

    spi_cs_lo(drv->spi);
    val = spi_transceive16(drv->spi, big16(next_channel << 11));
    spi_cs_hi(drv->spi);
    drv->next_channel = (uint8_t)next_channel;

    return val >> 4;
}

/**
 * @brief    Get next active channel
 *
 * This function returns the next active channel, the next read will return the value of this channel
 *
 * @param   drv             pointer to opened device driver
 *
 * @return  next active channel
 */

int adc084s021_get_next_channel( adc084s021_t * restrict drv )
{
    return drv->next_channel;
}

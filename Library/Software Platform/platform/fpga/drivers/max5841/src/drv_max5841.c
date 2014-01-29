/*****************************************************************************\
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  IN PACKAGE:
|*
|*  COPYRIGHT:          Copyright (c) 2008, Altium
|*
|*  DESCRIPTION:
|*
 */

/**
 * @file
 * Device driver for MAX5841 DA converter
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>


#if __POSIX_KERNEL__
# include <pthread.h>
#else
# include <pal.h>
#endif

#include <drv_i2cm.h>
#include <drv_max5841.h>
#include <drv_max5841_internal.h>
#include <drv_max5841_cfg_instance.h>


// runtime driver table
static max5841_t drv_table[DRV_MAX5841_INSTANCE_COUNT];



/**
 * @brief    Open an instance of the driver
 *
 * This function initializes the MAX5841 device driver.
 * You should call it only once per instantiation.
 *
 * @param  id  valid driver id
 *
 * @return Driver pointer if succesful - NULL otherwise
 */

max5841_t * max5841_open( unsigned int id )
{
    i2cm_t * i2cm;
    assert( id < DRV_MAX5841_INSTANCE_COUNT );

    // Copy peripheral data to driver table
    max5841_t * restrict drv = &drv_table[id];

    if (drv->i2cm == NULL)
    {
        const drv_max5841_cfg_instance_t * restrict drv_cfg = &drv_max5841_instance_table[id];

        if ( i2cm = i2cm_open( drv_cfg->drv_i2cm ), !i2cm )
        {
            return NULL;    // Could not open I2C driver for some reason
        }

        switch( drv_cfg->i2c_address )
        {
        case DRV_MAX5841_I2C_ADDRESS_0111100 : drv->i2c_addr = 0x78; break;
        case DRV_MAX5841_I2C_ADDRESS_0111101 : drv->i2c_addr = 0x7A; break;
        case DRV_MAX5841_I2C_ADDRESS_1011100 : drv->i2c_addr = 0xB8; break;
        case DRV_MAX5841_I2C_ADDRESS_1011101 : drv->i2c_addr = 0xBA; break;
        default : drv = NULL;   // Error, should never happen!
        }

        if ( drv )
        {
            switch( drv_cfg->power_down )
            {
            case DRV_MAX5841_POWER_DOWN_POWERUP : drv->pd = 0x00; break;
            case DRV_MAX5841_POWER_DOWN_POWERDOWNFLOAT : drv->pd = 0x01; break;
            case DRV_MAX5841_POWER_DOWN_POWERDOWNTERM1K : drv->pd = 0x02; break;
            case DRV_MAX5841_POWER_DOWN_POWERDOWNTERM100K : drv->pd = 0x03; break;
            default : drv = NULL;
            }
        }

        if ( drv )
        {
#if DRV_MAX5841_INSTANCE_BUS_SHARING_TRUE_USED
            drv->bus_sharing = drv_cfg->bus_sharing;
            if ( drv->bus_sharing )
            {
                if ( i2cm_get_bus( i2cm ) == -1 )
                {
                    return NULL;
                }
            }
#endif
            if ( i2cm_putchar( i2cm, true, drv->i2c_addr ) ||
                 i2cm_putchar( i2cm, false, 0xF0 ) ||
                 i2cm_putchar( i2cm, false, 0x3C | drv->pd ) )
            {
                drv = NULL;
            }
            else
            {
            drv->i2cm = i2cm;
            }
            i2cm_stop( i2cm );
#if DRV_MAX5841_INSTANCE_BUS_SHARING_TRUE_USED
            i2cm_release_bus( i2cm );
#endif
        }
    }
    // And we're done!
    return drv;
}

/**
 * @brief    Write value to DAC
 *
 * @param  drv Pointer to DAC device driver
 * @param   channel  Channel number to write value to (range 0..3)
 * @param   value   Value to write (range 0..1023)
 *
 * @return 0: OK, -1 on failure
 */

int max5841_out( max5841_t * drv, uint8_t channel, uint16_t value, bool flush )
{
    int retval;
    uint8_t update = flush ? 0 : 0x40;

    assert( drv != NULL );
    assert( value < 0x0400 );
    assert( channel < 4 );
    if ( max5841_get_bus( drv ) )
    {
        if ( i2cm_putchar( drv->i2cm, true, drv->i2c_addr ) ||
             i2cm_putchar( drv->i2cm, false, update | (channel << 4) | (value >> 6 ) ) ||
             i2cm_putchar( drv->i2cm, false, (value << 2) ) )
        {
            retval = -1;
        }
        else
        {
            retval = 0;
        }
        i2cm_stop( drv->i2cm );
    }
    max5841_release_bus( drv );

    return retval;
}


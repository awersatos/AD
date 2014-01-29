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
 * Device driver for MAX1037 AD converter
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
#include <drv_max1037.h>
#include <drv_max1037_internal.h>
#include <drv_max1037_cfg_instance.h>


// runtime driver table
static max1037_t drv_table[DRV_MAX1037_INSTANCE_COUNT];

/**
 * @brief    Open an instance of the driver
 *
 * This function initializes the MAX1037 device driver.
 * Further attemps to open an already opened instance of the driver simply returns the same pointer.
 *
 * @param  id  valid driver id
 *
 * @return Driver pointer if succesful - NULL otherwise
 */

max1037_t * max1037_open( unsigned int id )
{
    i2cm_t * i2cm;
    assert( id < DRV_MAX1037_INSTANCE_COUNT );

    // Copy peripheral data to driver table
    max1037_t * restrict drv = &drv_table[id];
    drv_max1037_cfg_instance_t * restrict drv_cfg = &drv_max1037_instance_table[id];

    if (drv->i2cm != NULL)  // driver already opened, return pointer
    {
        return drv;
    }
    
    if ( i2cm = i2cm_open( drv_cfg->drv_i2cm ), !i2cm )
    {
        // Unable to open I2C bus device driver for some reason
        return NULL;
    }

    drv->i2cm = i2cm;
    drv->config = drv_cfg->configbyte;
    drv->setup = drv_cfg->setupbyte;
#if DRV_MAX1037_INSTANCE_BUS_SHARING_TRUE_USED
    drv->bus_sharing = drv_cfg->bus_sharing;
    if ( drv->bus_sharing )
    {
        if ( i2cm_get_bus( i2cm ) == -1 )
        {
            return NULL;
        }
    }
#endif

    // Send address, setup and configuration
    if (i2cm_putchar( i2cm, true, SLAVE_WRITE_ADDR ) ||
        i2cm_putchar( i2cm, false, drv->setup ) ||
        i2cm_putchar( i2cm, false, drv->config ) )
    {
        drv = NULL; // Missed an ACK somewhere => failure!
    }
    i2cm_stop( i2cm );
#if DRV_MAX1037_INSTANCE_BUS_SHARING_TRUE_USED
    i2cm_release_bus( i2cm );
#endif
    // And we're done
    return drv;
}

/**
 * @brief    Read a single value from the AD converter
 *
 * This function reads a single value from the MAX1037 device. 
 * The channel to read must be set by max1037_select_channel() or by max1037_read_channel().
 *
 * @param  drv  pointer to a valid device driver
 *
 * @return MAX1037_ERR on error, value read from ADC otherwise
 */

int max1037_read( max1037_t * restrict drv )
{
    int val = MAX1037_ERR;
    assert( drv != NULL );

    if ( max1037_get_bus( drv ) )
    {
        if (!i2cm_putchar( drv->i2cm, true, SLAVE_READ_ADDR ))
        {
            val = i2cm_getchar( drv->i2cm, false, false );
            if (!(drv->config & MAX1037_CONFIG_SGL) && (drv->setup & MAX1037_SETUP_BIPOLAIR) && (val & 0x80))
            {
                val |= ~0xFF;
            }
        }
        i2cm_stop( drv->i2cm );
        max1037_release_bus( drv );
    }
    return val;
}

/**
 * @brief    Read a single value from the given channel of the AD converter
 *
 * This function reads a single value from the given channel of the MAX1037 device.
 *
 * @param  drv      pointer to a valid device driver
 * @param  channel  channel to read from
 *
 * @return MAX1037_ERR on error, value read from ADC otherwise
 */

int max1037_read_channel( max1037_t * restrict drv, uint8_t channel )
{
    int val = MAX1037_ERR;
    assert( drv != NULL );
    assert( channel < 12 );

    if (((drv->config & MAX1037_CONFIG_CS_MASK) != (channel << 1)) || ((drv->config & MAX1037_CONFIG_SCAN_MASK) != MAX1037_CONFIG_SCAN_MASK))
    {
        val = max1037_select_channel(drv, channel);
        if (val == MAX1037_ERR)
        {
            return MAX1037_ERR;
        }
    }

    val = max1037_read(drv);
    return val;
}

/**
 * @brief    Read multiple values from the AD converter
 *
 * This function reads multiple values from the MAX1037 device.
 *
 * @param  drv      pointer to a valid device driver
 * @param  data     pointer to memory to store read data in
 * @param  length   number of bytes to read
 *
 * @return MAX1037_ERR on error, 0 on succes
 */

int max1037_multiread( max1037_t * restrict drv, uint8_t * data, size_t length )
{
    int retval = MAX1037_ERR;
    assert( drv != NULL );
    if ( max1037_get_bus( drv ) )
    {
        retval = i2cm_read( drv->i2cm, SLAVE_READ_ADDR, data, length );
        max1037_release_bus( drv );
    }
    return retval;
}

/**
 * @brief    Write the configuration register
 *
 * This function writes a new configuration to the MAX1037 device.
 * Use the flags MAX1037_CONFIG_* to define the configuration with.
 *
 * @param  drv      pointer to a valid device driver
 * @param  config   new configuration byte to write
 *
 * @return MAX1037_ERR on error, 0 on succes
 */

int max1037_write_config( max1037_t * restrict drv, uint8_t config )
{
    int retval = MAX1037_ERR;
    assert( drv != NULL );
    if ( max1037_get_bus( drv ) )
    {
        if (!i2cm_putchar( drv->i2cm, true, SLAVE_WRITE_ADDR ) &&
            !i2cm_putchar( drv->i2cm, false, config & ~MAX1037_SETUP_REG ) )
        {
            drv->config = config;
            retval = 0;
        }
        i2cm_stop( drv->i2cm );
        max1037_release_bus( drv );
    }
    return retval;
}

/**
 * @brief    Write the setup register
 *
 * This function writes a new setup to the MAX1037 device.
 * Use the flags MAX1037_SETUP_* to define the configuration with.
 *
 * @param  drv      pointer to a valid device driver
 * @param  setup   new setup byte to write
 *
 * @return MAX1037_ERR on error, 0 on succes
 */

int max1037_write_setup( max1037_t * restrict drv, uint8_t setup )
{
    int retval = MAX1037_ERR;
    assert( drv != NULL );
    if ( max1037_get_bus( drv ) )
    {
        if (!i2cm_putchar( drv->i2cm, true, SLAVE_WRITE_ADDR ) &&
            !i2cm_putchar( drv->i2cm, false, setup | MAX1037_SETUP_REG ) )
        {
            if ( (setup & MAX1037_SETUP_nRST) == 0) drv->config = 0x01;
            drv->setup = setup;
            retval = 0;
        }
        i2cm_stop( drv->i2cm );
        max1037_release_bus( drv );
    }
    return retval;
}

/**
 * @brief    Select channel to read from
 *
 * This function selects single channel conversion and selects
 * a single channel for further conversions.
 *
 * @param  drv      pointer to a valid device driver
 * @param  channel  channel to be used
 *
 * @return MAX1037_ERR on error, 0 on succes
 */

int max1037_select_channel( max1037_t * restrict drv, uint8_t channel )
{
    uint8_t config;
    assert( drv != NULL );
    assert( channel < 12 );
    config = drv->config & ~MAX1037_CONFIG_CS_MASK & ~MAX1037_CONFIG_SCAN_MASK;
    config |= MAX1037_CONFIG_SCAN0 | MAX1037_CONFIG_SCAN1;
    config |= channel << 1;
    return max1037_write_config( drv, config );
}


/**
 * @brief    Select channels to read from
 *
 * This function selects multiple channel conversion and sets
 * the number of channels for further conversions. The first channel is always set to channel 0 (zero)
 *
 * @param  drv      pointer to a valid device driver
 * @param  channels number of channels to be used
 *
 * @return MAX1037_ERR on error, 0 on succes
 */

int max1037_select_multichannel( max1037_t * restrict drv, uint8_t channels )
{
    uint8_t config;
    assert( drv != NULL );
    assert( channels < 12 );
    config = drv->config & ~MAX1037_CONFIG_CS_MASK & ~MAX1037_CONFIG_SCAN_MASK;
    config |= (channels-1) << 1;
    return max1037_write_config( drv, config );
}


/**
 * @brief    Read Configuration register
 *
 * This function returns the value of the Configuration register
 *
 * @param  drv      pointer to a valid device driver
 *
 * @return Configuraton register value
 */

uint8_t max1037_read_config( max1037_t * restrict drv )
{
    assert( drv != NULL );
    return drv->config;
}


/**
 * @brief    Read Setup register
 *
 * This function returns the value of the Setup register
 *
 * @param  drv      pointer to a valid device driver
 *
 * @return Setup register value
 */

uint8_t max1037_read_setup( max1037_t * restrict drv )
{
    assert( drv != NULL );
    return drv->setup;
}




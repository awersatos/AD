/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2008, Altium
|*
|*  Description:        Direct (non-blockio) interface for TVP5150 card
|*                      devices.
|*
\*****************************************************************************/

/**
 * @file drv_tvp5150.h
 *
 * @brief
 *      Video Input Decoder
 *
 * This plugin provides access to the configuration registers of a TVP5150 video
 * input decoder device over an I2C bus.
 *
 * For a more detailed description of the TVP5150 peripheral, see the Technical Reference
 * <a href="TR0145 Technical Reference for Altium's Audio-Video Peripheral Board PB01.pdf">Technical Reference for Altium's Audio / Video Peripheral Board PB01</a>.
 */

#include <stdbool.h>
#include <assert.h>

#include <pal.h>
#include <drv_i2cm.h>
#include <drv_tvp5150.h>

#include "drv_tvp5150_cfg_instance.h"

/*
 * mutex support
 */

#if ( DRV_TVP5150_USE_MUTEX != 0 )
# define TVP5150_MUTEX_PREPARE()                POSIX_DEV_MUTEX_PREPARE(tvp5150_mutex_buffer)
# define TVP5150_MUTEX_LOCK( tvp5150 )          POSIX_DEV_MUTEX_LOCK(&tvp5150->mutex, tvp5150_mutex_buffer)
# define TVP5150_MUTEX_UNLOCK( tvp5150 )        POSIX_DEV_MUTEX_UNLOCK(&tvp5150->mutex, tvp5150_mutex_buffer)
#else
# define TVP5150_MUTEX_PREPARE()                do {} while (0)
# define TVP5150_MUTEX_LOCK( tvp5150 )          do {} while (0)
# define TVP5150_MUTEX_UNLOCK( tvp5150 )        do {} while (0)
#endif

struct tvp5150_s
{
    i2cm_t *i2cm;
    uint8_t busaddress;
    bool init;
};

static tvp5150_t tvp5150_table[DRV_TVP5150_INSTANCE_COUNT];

/*
 * Helper functions
 */

inline int tvp5150_setreg( i2cm_t * restrict i2cm, uint8_t busaddress, uint8_t reg, uint8_t val )
{
    int status = -1;
    if ( i2cm_putchar( i2cm, true, busaddress ) == 0
         && i2cm_putchar( i2cm, false, reg ) == 0 )
    {
        status = i2cm_putchar( i2cm, false, val );
    }
    i2cm_stop( i2cm );
    return status;
}

inline int tvp5150_getreg( i2cm_t * restrict i2cm, uint8_t busaddress, uint8_t reg )
{
    int status = -1;
    if ( i2cm_putchar( i2cm, true, busaddress ) == 0
         && i2cm_putchar( i2cm, false, reg ) == 0 )
    {
        status = i2cm_getchar( i2cm, false, false );
    }
    i2cm_stop( i2cm );
    return status;
}

/*
 * Public interface
 */

/**
 * @brief
 *      Initialize TVP5150 device
 *
 * This function sets initial configuration values for the TVP5150 video input
 * decoder device.
 *
 * @param id
 *      Device id (defined in devices.h)
 *
 * @return
 *      tvp5150 driver pointer if successful, or NULL otherwise.
 */
extern tvp5150_t *tvp5150_open( unsigned int id )
{
    tvp5150_t *tvp5150;
    drv_tvp5150_cfg_instance_t *cfg;
    int status;
#if ( DRV_TVP5150_USE_MUTEX != 0 )
    pthread_mutexattr_t mutexattr;
#endif
    
    assert( id < DRV_TVP5150_INSTANCE_COUNT );
    tvp5150 = &tvp5150_table[id];

    if ( tvp5150->init )
    {
        return tvp5150;
    }

    cfg = &drv_tvp5150_instance_table[id];

    tvp5150->i2cm = i2cm_open( cfg->drv_i2cm );
    tvp5150->busaddress = cfg->busaddress;

#if ( DRV_TVP5150_USE_MUTEX != 0 )
    pthread_mutexattr_init( &mutexattr );
    pthread_mutex_init( &tvp5150->mutex, &mutexattr );
#endif

    TVP5150_MUTEX_PREPARE();
    TVP5150_MUTEX_LOCK( tvp5150 );

    if ( i2cm_get_bus( tvp5150->i2cm ) != 0 )
    {
        TVP5150_MUTEX_UNLOCK( tvp5150 );
        return NULL;
    }

    // reset device
    status = tvp5150_setreg( tvp5150->i2cm, tvp5150->busaddress, TVP5150_SOFTWARE_RESET,
                             cfg->format_and_rates );
    if ( status != 0 )
    {
        i2cm_release_bus( tvp5150->i2cm );
        TVP5150_MUTEX_UNLOCK( tvp5150 );
        return NULL;
    }

    // set register 0x0D to 0x27 (format of the output data stream, see TVP5150 doc for details)
    status = tvp5150_setreg( tvp5150->i2cm, tvp5150->busaddress, TVP5150_FORMAT_AND_RATES,
                             cfg->format_and_rates );
    if ( status != 0 )
    {
        i2cm_release_bus( tvp5150->i2cm );
        TVP5150_MUTEX_UNLOCK( tvp5150 );
        return NULL;
    }

    // set register 0x0F to 0x02 (enable output VBLK, see TVP5150 doc for details)
    status = tvp5150_setreg( tvp5150->i2cm, tvp5150->busaddress, TVP5150_SHARED_PINS, cfg->shared_pins );
    if ( status != 0 )
    {
        i2cm_release_bus( tvp5150->i2cm );
        TVP5150_MUTEX_UNLOCK( tvp5150 );
        return NULL;
    }

    // set register 0x03 to 0xAF (enable outputs, see TVP5150 doc for details)
    status = tvp5150_setreg( tvp5150->i2cm, tvp5150->busaddress, TVP5150_MISC, cfg->misc );
    if ( status != 0 )
    {
        i2cm_release_bus( tvp5150->i2cm );
        TVP5150_MUTEX_UNLOCK( tvp5150 );
        return NULL;
    }

    // set register 0x00 to select input source (see TVP5150 doc for details)
    status = tvp5150_setreg( tvp5150->i2cm, tvp5150->busaddress, TVP5150_VIDEO_INPUT,
                             (uint8_t)cfg->video_input );
    if ( status != 0 )
    {
        i2cm_release_bus( tvp5150->i2cm );
        TVP5150_MUTEX_UNLOCK( tvp5150 );
        return NULL;
    }

    i2cm_release_bus( tvp5150->i2cm );

    tvp5150->init = true;

    TVP5150_MUTEX_UNLOCK( tvp5150 );

    return tvp5150;
}

/**
 * @brief
 *      Crop the video output
 *
 * This function sets the appropriate registers of the TVP5150 device to crop
 * the video output.
 *
 * @param tvp5150
 *      tvp5150 driver pointer
 * @param x1
 *      Number of pixels to skip on from the left side of the video image
 * @param y1
 *      Number of lines to skip on from the top of the video image
 * @param x2
 *      Number of pixels to skip on from the right side of the video image
 * @param y2
 *      Number of lines to skip on from the bottom of the video image
 *
 * @return
 *      0 if successful, -1 otherwise.
 */
extern int tvp5150_set_crop( tvp5150_t * restrict tvp5150, uint16_t x1, uint16_t y1, uint16_t x2, uint16_t y2 )
{
    int status;

    TVP5150_MUTEX_PREPARE();
    TVP5150_MUTEX_LOCK( tvp5150 );

    if ( i2cm_get_bus( tvp5150->i2cm ) != 0 )
    {
        TVP5150_MUTEX_UNLOCK( tvp5150 );
        return -1;
    }

    // Make sure we use only even numbers
    x1 = ( x1 < 512 ) && ( x1 > 0 ) ? x1 & 0xFFFE : 0;
    x2 = ( x2 < 512 ) && ( x2 > 0 ) ? x2 & 0xFFFE : 0;
    y1 /= 2;
    y2 /= 2;
    y1 = ( y1 < 128 ) && ( y1 > 0 ) ? y1 : 0;
    y2 = ( y2 < 128 ) && ( y2 > 0 ) ? y2 : 0;

    // PAL  default 579 lines
    // NTSC default 484 lines

    // set register 0x11 and 0x12 to crop value x1 (see TVP5150 doc for details)
    status = tvp5150_setreg( tvp5150->i2cm, tvp5150->busaddress, TVP5150_AVID_CROP_START_MSB, ( x1 >> 2 ) & 0xFF );
    if ( status != 0 )
    {
        i2cm_release_bus( tvp5150->i2cm );
        TVP5150_MUTEX_UNLOCK( tvp5150 );
        return -1;
    }
    status = tvp5150_setreg( tvp5150->i2cm, tvp5150->busaddress, TVP5150_AVID_CROP_START_LSB, x1 & 0x02 );
    if ( status != 0 )
    {
        i2cm_release_bus( tvp5150->i2cm );
        TVP5150_MUTEX_UNLOCK( tvp5150 );
        return -1;
    }

    // set register 0x13 and 0x14 to crop value x2 (see TVP5150 doc for details)
    status = tvp5150_setreg( tvp5150->i2cm, tvp5150->busaddress, TVP5150_AVID_CROP_STOP_MSB, 
                             ( -x2 >> 2 ) & 0xFF );
    if ( status != 0 )
    {
        i2cm_release_bus( tvp5150->i2cm );
        TVP5150_MUTEX_UNLOCK( tvp5150 );
        return -1;
    }
    status = tvp5150_setreg( tvp5150->i2cm, tvp5150->busaddress, TVP5150_AVID_CROP_STOP_LSB, -x2 & 0x02 );
    if ( status != 0 )
    {
        i2cm_release_bus( tvp5150->i2cm );
        TVP5150_MUTEX_UNLOCK( tvp5150 );
        return -1;
    }

    // set register 0x18 to crop value y2 (see TVP5150 doc for details)
    status = tvp5150_setreg( tvp5150->i2cm, tvp5150->busaddress, TVP5150_VBLANK_START, ( uint8_t ) ( -y2 ) );
    if ( status != 0 )
    {
        i2cm_release_bus( tvp5150->i2cm );
        TVP5150_MUTEX_UNLOCK( tvp5150 );
        return -1;
    }
    status = tvp5150_setreg( tvp5150->i2cm, tvp5150->busaddress, TVP5150_VBLANK_STOP, ( uint8_t ) y1 );

    i2cm_release_bus( tvp5150->i2cm );

    TVP5150_MUTEX_UNLOCK( tvp5150 );

    return status;
}

/**
 * @brief
 *      Write register value
 *
 * This function writes a value to the specified register of the TVP5150
 * device.
 *
 * @param tvp5150
 *      tvp5150 driver pointer
 * @param reg
 *      TVP5150 register number
 * @param value
 *      Value to write to the register
 *
 * @return 
 *      0 if successful, -1 otherwise.
 */
extern int tvp5150_set_register( tvp5150_t * restrict tvp5150, uint8_t reg, uint8_t value )
{
    int status = -1;

    TVP5150_MUTEX_PREPARE();
    TVP5150_MUTEX_LOCK( tvp5150 );

    if ( i2cm_get_bus( tvp5150->i2cm ) == 0 )
    {
        status = tvp5150_setreg( tvp5150->i2cm, tvp5150->busaddress, reg, value );
        i2cm_release_bus( tvp5150->i2cm );
    }

    TVP5150_MUTEX_UNLOCK( tvp5150 );

    return status;
}

/**
 * @brief
 *      Read register value
 *
 * This function reads the specified register of the TVP5150 device.
 *
 * @param tvp5150
 *      tvp5150 driver pointer
 * @param reg
 *      TVP5150 register number
 *
 * @return
 *      Register value if successful, -1 otherwise.
 */
extern int tvp5150_get_register( tvp5150_t * restrict tvp5150, uint8_t reg )
{
    int status = -1;
 
    TVP5150_MUTEX_PREPARE();
    TVP5150_MUTEX_LOCK( tvp5150 );

    if ( i2cm_get_bus( tvp5150->i2cm ) == 0 )
    {
        status = tvp5150_getreg( tvp5150->i2cm, tvp5150->busaddress, reg );
        i2cm_release_bus( tvp5150->i2cm );
    }
 
    TVP5150_MUTEX_UNLOCK( tvp5150 );

    return status;
}

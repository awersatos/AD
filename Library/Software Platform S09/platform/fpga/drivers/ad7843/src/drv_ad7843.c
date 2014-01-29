/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007, Altium
|*
|*  Description:        Direct (non-blockio) interface for AD7843 touchscreen controllers.
|*
\*****************************************************************************/

/**
 * @file
 * Device driver for SPI based AD7843 touchscreen controllers
 *
 */

#include <assert.h>
#include <time.h>

#include <pal.h>
#include <drv_spi.h>
#include <drv_ad7843.h>
#include <per_tspen.h>

#include <drv_ad7843_cfg_instance.h>

#define _AD7843_STARTBIT        0x80
#define _AD7843_ADDRX           0x50
#define _AD7843_ADDRY           0x10
#define _AD7843_8BIT            0x08
#define _AD7843_12BIT           0x00
#define _AD7843_SER             0x04
#define _AD7843_DFR             0x00
#define _AD7843_POWERUP         0x02
#define _AD7843_POWERDOWN       0x00
#define _AD7843_IRQDISABLED     0x01
#define _AD7843_IRQENABLED      0x00
#define _AD7843_CONTROL_MODE    (_AD7843_STARTBIT | _AD7843_12BIT | _AD7843_SER | _AD7843_POWERDOWN | _AD7843_IRQENABLED)

/*
 * mutex support
 */

#if DRV_AD7843_USE_MUTEX
# define AD7843_MUTEX_PREPARE()             POSIX_DEV_MUTEX_PREPARE(ad7843_mutex_buffer)
# define AD7843_MUTEX_LOCK( ad7843 )        POSIX_DEV_MUTEX_LOCK(&ad7843->mutex, ad7843_mutex_buffer)
# define AD7843_MUTEX_UNLOCK( ad7843 )      POSIX_DEV_MUTEX_UNLOCK(&ad7843->mutex, ad7843_mutex_buffer)
#else
# define AD7843_MUTEX_PREPARE()            
# define AD7843_MUTEX_LOCK( ad7843 )          
# define AD7843_MUTEX_UNLOCK( ad7843 )        
#endif

/*
 * driver data
 */

struct drv_ad7843_s
{
    spi_t    *spi;                    // SPI device driver pointer
    uint8_t  *pendown;                // touchscreen pen down address
    uint8_t   channel;                // Channel for this device, 0 if not shared
    int       last_x;
    int       last_y;
    int       last_pd;
    clock_t   next_sample;
    bool      swap;
#if DRV_AD7843_USE_MUTEX
    pthread_mutex_t mutex;
#endif
};



// runtime driver table
static ad7843_t drv_table[DRV_AD7843_INSTANCE_COUNT];

/**
 * @brief    Open an instance of the driver
 *
 * The first time the function is called, it initializes both the WB_SPI core and the touchscreen controller (including drivers).
 * Further attemps to open an already successfully opened instance of the driver simply returns the same pointer.
 *
 * @param  id  valid driver id
 *
 * @return Driver pointer if succesful initialized, NULL otherwise (for example: if the SPI bus could not be opened)
 */

ad7843_t * ad7843_open( unsigned int id )
{
    assert( id < DRV_AD7843_INSTANCE_COUNT );

    uint8_t control;

    // Copy configuration data to driver table
    ad7843_t * restrict drv = &drv_table[id];
    drv_ad7843_cfg_instance_t * restrict drv_cfg = &drv_ad7843_instance_table[id];
    
//    if (drv->spi)
    {

#if DRV_AD7843_USE_MUTEX
        pthread_mutexattr_t mutexattr;
        pthread_mutexattr_init( &mutexattr );
        pthread_mutex_init( &drv->mutex, &mutexattr );
#endif

        AD7843_MUTEX_PREPARE();
        AD7843_MUTEX_LOCK( drv );

        drv->pendown = (uint8_t *)per_tspen_instance_table[drv_cfg->per_tspen].baseaddress;
        drv->swap = drv_cfg->swap;
        drv->spi = spi_open( drv_cfg->drv_spi );

#if DRV_AD7843_INSTANCE_BUS_SHARING_TRUE_USED
        drv->channel = drv_cfg->channel;
        if ( drv_cfg->bus_sharing && drv->spi && !spi_get_bus( drv->spi, drv->channel ) )
        {
            drv->spi = NULL;
        }
#endif

        if ( drv->spi )
        {
            spi_cs_hi( drv->spi );                                                  // Reset chip's SPI FSM
            control = _AD7843_CONTROL_MODE | _AD7843_ADDRX;
            spi_cs_lo( drv->spi );
            spi_transceive8( drv->spi, control );
            spi_transceive8( drv->spi, 0 );
            spi_transceive8( drv->spi, 0 );
            spi_cs_hi( drv->spi );
        
            drv->last_pd    = 0;

#if DRV_AD7843_INSTANCE_BUS_SHARING_TRUE_USED
            spi_release_bus( drv->spi );
#endif
        }
        AD7843_MUTEX_UNLOCK( drv );
    }
    return drv->spi ? drv : NULL;
}

/**
 * @brief    Get raw position data
 *
 * This function returns the raw position data from the chip.
 *
 * @param  drv  Driver pointer as returned from ad7843_open()
 * @param  raw  Pointer to ad7843_raw_t structure
 *
 * @return 0 if sample is valid, -1 otherwise
 */


int ad7843_get_raw(ad7843_t *drv, ad7843_raw_t *raw)
{
    assert( drv );
    assert( raw );

    int result = AD7843_ERR_SPI;
    int valx = 0;
    int valy = 0;
    bool pendown = false;
    uint8_t control;
    uint8_t spi_result;
    
    if (clock() > drv->next_sample)
    {
        AD7843_MUTEX_PREPARE();
        AD7843_MUTEX_LOCK( drv );
#if DRV_AD7843_INSTANCE_BUS_SHARING_TRUE_USED
        if ( (drv->channel == 0 ) || spi_get_bus( drv->spi, drv->channel ))
        {
#endif
            result = AD7843_ERR_OK;

            if (*(drv->pendown) == 0)
            {
                /* pendown */
                drv->last_pd++;

                control = _AD7843_CONTROL_MODE | _AD7843_ADDRX;
                spi_cs_lo( drv->spi );
                spi_transceive8( drv->spi, control );
                spi_result = spi_transceive8( drv->spi, 0 );
                if (drv->swap)
                {
                    valy = (spi_result << 5) | (spi_transceive8(drv->spi, 0 ) >> 3);  // add last 5 bits
                }
                else
                {
                    valx = (spi_result << 5) | (spi_transceive8(drv->spi, 0 ) >> 3);  // add last 5 bits
                }

                control = _AD7843_CONTROL_MODE | _AD7843_ADDRY;
                spi_transceive8(drv->spi, control);
                spi_result = spi_transceive8(drv->spi, 0);       // spi_result contains first 7 bits
                if (drv->swap)
                {
                    valx = (spi_result << 5) | (spi_transceive8(drv->spi, 0) >> 3);  // add last 5 bits
                }
                else
                {
                    valy = (spi_result << 5) | (spi_transceive8(drv->spi, 0) >> 3);  // add last 5 bits
                }

                spi_cs_hi( drv->spi );
            }
            else
            {
                drv->last_pd = 0;
            }

#if DRV_AD7843_INSTANCE_BUS_SHARING_TRUE_USED
            if ( drv->channel ) spi_release_bus( drv->spi );
        }
#endif
        if (result == AD7843_ERR_OK)
        {
            if (drv->last_pd > 2)
            {
                raw->x = drv->last_x;
                raw->y = drv->last_y;
                raw->pendown = true;
                drv->last_pd = 2;
            }
            else
            {
                raw->pendown = false;
            }
        }
        drv->last_x = valx;
        drv->last_y = valy;
        drv->next_sample = drv->last_pd == 1 ? clock() + (uint64_t)PAL_CLOCKHZ * DRV_AD7843_PENDOWN_DELAY / 1000 : clock() + (uint64_t)PAL_CLOCKHZ * DRV_AD7843_PENUP_DELAY / 1000;
        AD7843_MUTEX_UNLOCK( drv );
    }

    return result;
}

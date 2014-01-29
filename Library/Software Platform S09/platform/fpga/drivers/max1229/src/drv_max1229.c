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
 * Device driver for max1229 peripheral.
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

#include <drv_spi.h>
#include <drv_max1229.h>
#include <drv_max1229_cfg_instance.h>

////////////////////////////////////////////////////////////////////////////////
struct drv_max1229_s
{
    bool bus_sharing;
    spi_t * spi;
#if DRV_MAX1229_INSTANCE_BUS_SHARING_TRUE_USED
    uint8_t channel;
# if __POSIX_KERNEL__
    int wait_mode;
#  if DRV_MAX1229_INSTANCE_WAIT_MODE_SLEEP_USED
    uint32_t wait_sleepms;
#  endif
# endif
#endif
} ;

// runtime driver table
static max1229_t drv_table[DRV_MAX1229_INSTANCE_COUNT];

////////////////////////////////////////////////////////////////////////////////
#if DRV_MAX1229_INSTANCE_BUS_SHARING_TRUE_USED
inline void threadwait(max1229_t * restrict drv)
{
#if __POSIX_KERNEL__
# if DRV_max1229_INSTANCE_WAIT_MODE_NOP_USED
    if (drv->wait_mode == DRV_max1229_WAIT_MODE_NOP)
    {
        __nop();
    }
    else
# endif
# if DRV_MAX1229_INSTANCE_WAIT_MODE_YIELD_USED
    if (drv->wait_mode == DRV_max1229_WAIT_MODE_YIELD)
    {
        sched_yield();
    }
    else
# endif
# if DRV_MAX1229_INSTANCE_WAIT_MODE_SLEEP_USED
    if (drv->wait_mode == DRV_max1229_WAIT_MODE_SLEEP)
    {
        struct timespec ts = { 0, drv->wait_sleepms * 1000 * 1000 };

        nanosleep (&ts, NULL);
    }
    else
# endif
    { /* never reached */ }
#else
    // without RTOS
    __nop();
#endif
}
#endif // DRV_MAX1229_INSTANCE_BUS_SHARING_TRUE_USED

////////////////////////////////////////////////////////////////////////////////
/**
 * @brief    Open an instance of the driver
 *
 * This function initializes the MAX1229 device driver.
 * You should call it only once per instantiation.
 *
 * @param  id  valid driver id
 *
 * @return Driver pointer if succesful - NULL otherwise
 */
////////////////////////////////////////////////////////////////////////////////
max1229_t * max1229_open( uint32_t id  )
{


    assert( id < DRV_MAX1229_INSTANCE_COUNT );

    // Copy peripheral data to driver table
    max1229_t * restrict drv = &drv_table[id];
    drv_max1229_cfg_instance_t * restrict drv_cfg = &drv_max1229_instance_table[id];

    drv->spi = spi_open( drv_cfg->drv_spi );
    drv->bus_sharing = drv_cfg->bus_sharing;
#if DRV_MAX1229_INSTANCE_BUS_SHARING_TRUE_USED
    drv->channel = drv_cfg->channel;
# if __POSIX_KERNEL__
    drv->wait_mode = drv_cfg->wait_mode;
#  if DRV_MAX1229_INSTANCE_WAIT_MODE_SLEEP_USED
    drv->wait_sleepms = drv_cfg->wait_sleepms;
#  endif
# endif
#endif

    max1229_Reset(drv);

    // And we're done!
    return drv;
}

////////////////////////////////////////////////////////////////////////////////
/**
 * @brief    Read ADC channel
 *
 * This function returns a sample from a given ADC channel.
 *
 * @param  drv      pointer to driver
 * @param  channel  ADC Channel to access (0->11)
 *
 * @return Sampled channels converted value
 */
////////////////////////////////////////////////////////////////////////////////
uint32_t max1229_ReadChannel(max1229_t *drv, uint8_t channel)
{
    uint32_t value = 0;

    #if DRV_MAX1229_INSTANCE_BUS_SHARING_TRUE_USED
    if ( drv->bus_sharing )
    {
        while( !spi_get_bus( drv->spi, drv->channel ) ) threadwait(drv);
    }
    #endif

    spi_cs_lo(drv->spi);
    spi_transceive8(drv->spi, cCurrentSense_ConversionRegister | cCurrentSense_NoScan | (channel<<3));
    value = spi_transceive8(drv->spi,0);
    value = (value << 8) | spi_transceive8(drv->spi,0);
    spi_cs_hi(drv->spi);

    #if DRV_MAX1229_INSTANCE_BUS_SHARING_TRUE_USED
    if ( drv->bus_sharing )
    {
        spi_release_bus( drv->spi );
    }
    #endif

    return value;
}

////////////////////////////////////////////////////////////////////////////////
/**
 * @brief    Read Device Temperature
 *
 * This function reads the current internal temperature of the device
 *
 * @param  drv pointer to driver
 *
 * @return Current device temperature where 1LSB = 1/8 DegreeC ie. Temp = return/8
 */
////////////////////////////////////////////////////////////////////////////////
uint32_t max1229_ReadTemperature(max1229_t *drv)
{
    uint32_t    i;
    uint32_t    value = 0;

    #if DRV_MAX1229_INSTANCE_BUS_SHARING_TRUE_USED
    if ( drv->bus_sharing )
    {
        while( !spi_get_bus( drv->spi, drv->channel ) ) threadwait(drv);
    }
    #endif


    spi_cs_lo(drv->spi);
    spi_transceive8(drv->spi, cCurrentSense_ConversionRegister | cCurrentSense_NoScan | cCurrentSense_MeasureTemperature);

    for(i=0;i<12;i++){
        value = spi_transceive8(drv->spi, 0);
        value = (value << 8) | spi_transceive8(drv->spi, 0);
    }
    spi_cs_hi(drv->spi);

    #if DRV_MAX1229_INSTANCE_BUS_SHARING_TRUE_USED
    if ( drv->bus_sharing )
    {
        spi_release_bus( drv->spi );
    }
    #endif

    return value;
}

////////////////////////////////////////////////////////////////////////////////
/**
 * @brief    Reset the device
 *
 * This function resets the deviced to a initialized and ready state
 *
 * @param  drv pointer to driver
 *
 * @return nothing
 */
////////////////////////////////////////////////////////////////////////////////
void max1229_Reset(max1229_t *drv)
{
static uint8_t retval;
    #if DRV_MAX1229_INSTANCE_BUS_SHARING_TRUE_USED
    if ( drv->bus_sharing )
    {
        while( !spi_get_bus( drv->spi, drv->channel ) ) threadwait(drv);
    }
    #endif

    spi_cs_lo(drv->spi);
    retval = spi_transceive8(drv->spi, cCurrentSense_ResetRegister);
    spi_cs_hi(drv->spi);

    #if DRV_MAX1229_INSTANCE_BUS_SHARING_TRUE_USED
    if ( drv->bus_sharing )
    {
        spi_release_bus( drv->spi );
    }
    #endif

    #if DRV_MAX1229_INSTANCE_BUS_SHARING_TRUE_USED
    if ( drv->bus_sharing )
    {
        while( !spi_get_bus( drv->spi, drv->channel ) ) threadwait(drv);
    }
    #endif

    spi_cs_lo(drv->spi);
    retval = spi_transceive8(drv->spi, cCurrentSense_SetupRegister | cCurrentSense_ExternallyTimed | cCurrentSense_InternalReference);
    spi_cs_hi(drv->spi);

    #if DRV_MAX1229_INSTANCE_BUS_SHARING_TRUE_USED
    if ( drv->bus_sharing )
    {
        spi_release_bus( drv->spi );
    }
    #endif
}





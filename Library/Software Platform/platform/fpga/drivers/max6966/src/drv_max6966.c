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

////////////////////////////////////////////////////////////////////////////////
/**
 * @file
 * Device driver for max1229 peripheral.
 *
 */
////////////////////////////////////////////////////////////////////////////////

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>


#if __POSIX_KERNEL__
# include <pthread.h>
#else
# include <pal.h>
#endif

#include <drv_spi.h>
#include <drv_max6966.h>
#include <drv_max6966_cfg_instance.h>

////////////////////////////////////////////////////////////////////////////////
#define MAX6966_CHANNEL_COUNT       10
#define MAX6966_CONFIG_REGISTER     0x10
#define MAX6966_MODE_PWM            0x21


////////////////////////////////////////////////////////////////////////////////
static void max6966_write_port(max6966_t *drv, uint8_t address, uint8_t value);


////////////////////////////////////////////////////////////////////////////////
struct drv_max6966_s
{
    bool bus_sharing;
    spi_t * spi;
#if DRV_MAX6966_INSTANCE_BUS_SHARING_TRUE_USED
    uint8_t channel;
# if __POSIX_KERNEL__
    int wait_mode;
#  if DRV_MAX6966_INSTANCE_WAIT_MODE_SLEEP_USED
    uint32_t wait_sleepms;
#  endif
# endif
#endif
} ;

// runtime driver table
static max6966_t drv_table[DRV_MAX6966_INSTANCE_COUNT];


////////////////////////////////////////////////////////////////////////////////
inline void threadwait(max6966_t * restrict drv)
{
#if __POSIX_KERNEL__
# if DRV_max6966_INSTANCE_WAIT_MODE_NOP_USED
    if (drv->wait_mode == DRV_max6966_WAIT_MODE_NOP)
    {
        __nop();
    }
    else
# endif
# if DRV_MAX6966_INSTANCE_WAIT_MODE_YIELD_USED
    if (drv->wait_mode == DRV_max6966_WAIT_MODE_YIELD)
    {
        sched_yield();
    }
    else
# endif
# if DRV_MAX6966_INSTANCE_WAIT_MODE_SLEEP_USED
    if (drv->wait_mode == DRV_max6966_WAIT_MODE_SLEEP)
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

////////////////////////////////////////////////////////////////////////////////
void max6966_write_port(max6966_t *drv, uint8_t address, uint8_t value)
{
    #if DRV_MAX6966_INSTANCE_BUS_SHARING_TRUE_USED
    if ( drv->bus_sharing )
    {
        while( !spi_get_bus( drv->spi, drv->channel ) ) threadwait(drv);
    }
    #endif


    // open toggling
    spi_cs_hi(drv->spi);
    spi_cs_lo(drv->spi);

    spi_transceive8(drv->spi, address);
    spi_transceive8(drv->spi, value);
    while(spi_busy(drv->spi)) threadwait(drv);
    // closing toggling
    spi_cs_hi(drv->spi);


    #if DRV_MAX6966_INSTANCE_BUS_SHARING_TRUE_USED
    if ( drv->bus_sharing )
    {
        spi_release_bus( drv->spi );
    }
    #endif

}

////////////////////////////////////////////////////////////////////////////////
/**
 * @brief    Open an instance of the driver
 *
 * This function initializes the MAX6966 device driver.
 * You should call it only once per instantiation.
 *
 * @param  id  valid driver id
 *
 * @return Driver pointer if succesful - NULL otherwise
 */
////////////////////////////////////////////////////////////////////////////////
max6966_t * max6966_open( uint32_t id )
{
    assert( id < DRV_MAX6966_INSTANCE_COUNT );

    // Copy peripheral data to driver table
    max6966_t * restrict drv = &drv_table[id];
    if (drv->spi == NULL)
    {
        const drv_max6966_cfg_instance_t * restrict drv_cfg = &drv_max6966_instance_table[id];

        drv->spi = spi_open( drv_cfg->drv_spi );
        if (drv->spi != NULL)
        {
            drv->bus_sharing = drv_cfg->bus_sharing;
#if DRV_MAX6966_INSTANCE_BUS_SHARING_TRUE_USED
            drv->channel = drv_cfg->channel;
# if __POSIX_KERNEL__
            drv->wait_mode = drv_cfg->wait_mode;
#  if DRV_MAX6966_INSTANCE_WAIT_MODE_SLEEP_USED
            drv->wait_sleepms = drv_cfg->wait_sleepms;
#  endif
# endif
#endif
            max6966_Reset(drv);
        }
    }
    // And we're done!
    return drv->spi == NULL ? NULL : drv;
}

////////////////////////////////////////////////////////////////////////////////
/**
 * @brief    Set channel duty cycle
 *
 * This function sets the duty cycle of the given channel
 *
 * @param  drv      pointer to driver
 * @param  channel  Channel index ( 0 => 9)
 * @param  duty     PWM duty cycle ( 0 => 255)
 *
 * @return nothing
 */
////////////////////////////////////////////////////////////////////////////////
void max6966_set_channel_duty(max6966_t *drv, uint8_t channel, uint8_t duty)
{
    assert(channel <= 9);

    if(duty){
        if(duty > 252) duty = 252;
        duty += 2;
    } else {
        duty = 0xFF;
    }

    max6966_write_port(drv, channel, duty);
}

////////////////////////////////////////////////////////////////////////////////
/**
 * @brief    Reset Device
 *
 * This function initializes and configures the MAX6966 device into 8Bit PWM mode.
 *
 * @param  drv      pointer to driver
 *
 * @return nothing
 */
////////////////////////////////////////////////////////////////////////////////
void max6966_Reset(max6966_t *drv)
{
    uint8_t i;

    // Init Device
    max6966_write_port(drv, MAX6966_CONFIG_REGISTER, MAX6966_MODE_PWM);

    for(i=0;i<MAX6966_CHANNEL_COUNT;i++){
        max6966_set_channel_duty(drv, i, 0);
    }
}






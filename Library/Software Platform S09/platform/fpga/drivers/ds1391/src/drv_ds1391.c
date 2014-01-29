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
 * Device driver for DS1391 peripheral.
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
#include <drv_ds1391.h>
#include <drv_ds1391_cfg_instance.h>

static inline uint8_t bcd2bin( uint8_t bcd )
{
    return 10 * (bcd >> 4) + (bcd & 0x0F);
}

static inline uint32_t bin2bcd( int bin )
{
    return bin % 10 + ((bin / 10) << 4);
}

struct drv_ds1391_s
{
    bool bus_sharing;
    spi_t * spi;
#if DRV_DS1391_INSTANCE_BUS_SHARING_TRUE_USED
    uint8_t channel;
# if __POSIX_KERNEL__
    int wait_mode;
#  if DRV_DS1391_INSTANCE_WAIT_MODE_SLEEP_USED
    uint32_t wait_sleepms;
#  endif
# endif
#endif
} ;

// runtime driver table
static ds1391_t drv_table[DRV_DS1391_INSTANCE_COUNT];


#if DRV_DS1391_INSTANCE_BUS_SHARING_TRUE_USED

inline void threadwait(ds1391_t * restrict drv)
{
#if __POSIX_KERNEL__
# if DRV_DS1391_INSTANCE_WAIT_MODE_NOP_USED
    if (drv->wait_mode == DRV_DS1391_WAIT_MODE_NOP)
    {
        __nop();
    }
    else
# endif
# if DRV_DS1391_INSTANCE_WAIT_MODE_YIELD_USED
    if (drv->wait_mode == DRV_DS1391_WAIT_MODE_YIELD)
    {
        sched_yield();
    }
    else
# endif
# if DRV_DS1391_INSTANCE_WAIT_MODE_SLEEP_USED
    if (drv->wait_mode == DRV_DS1391_WAIT_MODE_SLEEP)
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

#endif

/**
 * @brief    Open an instance of the driver
 *
 * This function initializes the DS1391 device driver.
 * You should call it only once per instantiation.
 *
 * @param  id  valid driver id
 *
 * @return Driver pointer if succesful - NULL otherwise
 */

ds1391_t * ds1391_open( unsigned int id )
{
    assert( id < DRV_DS1391_INSTANCE_COUNT );

    // Copy peripheral data to driver table
    ds1391_t * restrict drv = &drv_table[id];
    drv_ds1391_cfg_instance_t * restrict drv_cfg = &drv_ds1391_instance_table[id];

    drv->spi = spi_open( drv_cfg->drv_spi );
    drv->bus_sharing = drv_cfg->bus_sharing;
#if DRV_DS1391_INSTANCE_BUS_SHARING_TRUE_USED
    drv->channel = drv_cfg->channel;
    spi_init_channel( drv->spi, drv->channel, 4000000, SPI_MODE1 );
# if __POSIX_KERNEL__
    drv->wait_mode = drv_cfg->wait_mode;
#  if DRV_DS1391_INSTANCE_WAIT_MODE_SLEEP_USED
    drv->wait_sleepms = drv_cfg->wait_sleepms;
#  endif
# endif
#else
    spi_set_baudrate( drv->spi, 4000000 );
    spi_set_mode( drv->spi, SPI_MODE1 );
#endif
    // And we're done!
    return drv;
}

/**
 * @brief    Get current time from RTC
 *
 * This function reads the current calendar time from the DS1391 device.
 *
 * @param  drv pointer to driver
 * @param  t   pointer to tm structure
 *
 * @return 0 on succes, error otherwise
 */

int ds1391_get_time( ds1391_t * drv, struct tm * t )
{
    uint32_t time;
    uint32_t date;

    assert( drv != NULL );
    assert( t != NULL );

    spi_cs_hi( drv->spi );

#if DRV_DS1391_INSTANCE_BUS_SHARING_TRUE_USED
    if ( drv->bus_sharing )
    {
        while( !spi_get_bus( drv->spi, drv->channel ) ) threadwait(drv);
    }
#endif

    spi_cs_lo( drv->spi );
    spi_set_endianess( drv->spi, false );               // Switch SPI to little endian
    spi_transmit8( drv->spi, 0x00 );                    // Send address
    time = spi_transceive32( drv->spi, 0xFFFFFFFF );
    date = spi_transceive32( drv->spi, 0xFFFFFFFF );    // Read time & date from RTC
    spi_cs_hi( drv->spi );

#if DRV_DS1391_INSTANCE_BUS_SHARING_TRUE_USED
    if ( drv->bus_sharing )
    {
        spi_release_bus( drv->spi );
    }
#endif

    t->tm_sec  = bcd2bin( time >> 8 );
    t->tm_min  = bcd2bin( time >> 16 );
    t->tm_hour = bcd2bin( time >> 24 );
    if ( time & 0x40000000 )        // Correction for 12-hour format:
    {
        t->tm_hour -= (time & 0x20000000 ) ? 38 : 40;
    }

    t->tm_wday = (date & 0x07) - 1;
    t->tm_mday = bcd2bin( date >> 8 );
    t->tm_mon = bcd2bin( ((date >> 16) & 0x7F ) - 1);   // tm_mon   Month of year [0,11], ds1391 Month 01 - 12
    t->tm_year = bcd2bin( date >> 24 );
    if ( date & 0x00800000 ) t->tm_year += 100;

    t->tm_isdst = 0;
    t->tm_yday = 0;
    return 0;
}

/**
 * @brief    Writes current calendar time to RTC
 *
 * This function reads the current time from the DS1391 device.
 *
 * @param  drv pointer to driver
 * @param  t   pointer to valid tm structure
 *
 * @return 0 on succes, error otherwise
 */

int ds1391_set_time( ds1391_t * drv, struct tm * t )
{
    uint32_t time;
    uint32_t date;

    assert( drv != NULL );
    assert( t != NULL );


    time = (bin2bcd( t->tm_sec ) << 8) | (bin2bcd( t->tm_min ) << 16) | (bin2bcd( t->tm_hour ) << 24 );
    // tm_mon Month of year [0,11], ds1391 Month 01 - 12
    date = (t->tm_wday + 1) | (bin2bcd(t->tm_mday) << 8) | (bin2bcd( t->tm_mon+1) << 16) | (bin2bcd( t->tm_year % 100 ) << 24);
    if ( t->tm_year >= 100 ) date |= 0x00800000;

    spi_cs_hi( drv->spi );

#if DRV_DS1391_INSTANCE_BUS_SHARING_TRUE_USED
    if ( drv->bus_sharing )
    {
        while( !spi_get_bus( drv->spi, drv->channel ) ) threadwait(drv);
    }
#endif

    spi_cs_lo( drv->spi );
    spi_set_endianess( drv->spi, false );               // Switch SPI to little endian
    spi_transmit8( drv->spi, 0x80 );                    // Send address
    time = spi_transceive32( drv->spi, time );
    date = spi_transceive32( drv->spi, date );          // Write time & date to RTC
    spi_cs_hi( drv->spi );

#if DRV_DS1391_INSTANCE_BUS_SHARING_TRUE_USED
    if ( drv->bus_sharing )
    {
        spi_release_bus( drv->spi );
    }
#endif

    return 0;
}


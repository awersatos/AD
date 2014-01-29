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
 * Device driver for PCF2123 peripheral.
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#if __POSIX_KERNEL__
# include <pthread.h>
#endif

#include <drv_spi.h>
#include <drv_pcf2123.h>
#include <drv_pcf2123_cfg_instance.h>

static inline uint8_t bcd2bin( uint8_t bcd )
{
    return 10 * (bcd >> 4) + (bcd & 0x0F);
}

static inline uint32_t bin2bcd( int bin )
{
    return bin % 10 + ((bin / 10) << 4);
}

struct drv_pcf2123_s
{
    bool bus_sharing;
    spi_t * spi;
#if DRV_PCF2123_INSTANCE_BUS_SHARING_TRUE_USED
    uint8_t channel;
# if __POSIX_KERNEL__
    int wait_mode;
#  if DRV_PCF2123_INSTANCE_WAIT_MODE_SLEEP_USED
    uint32_t wait_sleepms;
#  endif
# endif
#endif
} ;

// runtime driver table
static pcf2123_t drv_table[DRV_PCF2123_INSTANCE_COUNT];


#if DRV_PCF2123_INSTANCE_BUS_SHARING_TRUE_USED

inline void threadwait(pcf2123_t * restrict drv)
{
#if __POSIX_KERNEL__
# if DRV_PCF2123_INSTANCE_WAIT_MODE_NOP_USED
    if (drv->wait_mode == DRV_PCF2123_WAIT_MODE_NOP)
    {
        __nop();
    }
    else
# endif
# if DRV_PCF2123_INSTANCE_WAIT_MODE_YIELD_USED
    if (drv->wait_mode == DRV_PCF2123_WAIT_MODE_YIELD)
    {
        sched_yield();
    }
    else
# endif
# if DRV_PCF2123_INSTANCE_WAIT_MODE_SLEEP_USED
    if (drv->wait_mode == DRV_PCF2123_WAIT_MODE_SLEEP)
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
 * This function initializes the PCF2123 device driver.
 * You should call it only once per instantiation.
 *
 * @param  id  valid driver id
 *
 * @return Driver pointer if succesful - NULL otherwise
 */

pcf2123_t * pcf2123_open( unsigned int id )
{
    assert( id < DRV_PCF2123_INSTANCE_COUNT );

    // Copy peripheral data to driver table
    pcf2123_t * restrict drv = &drv_table[id];
    drv_pcf2123_cfg_instance_t * restrict drv_cfg = &drv_pcf2123_instance_table[id];

    drv->spi = spi_open( drv_cfg->drv_spi );
    drv->bus_sharing = drv_cfg->bus_sharing;
#if DRV_PCF2123_INSTANCE_BUS_SHARING_TRUE_USED
    drv->channel = drv_cfg->channel;
# if __POSIX_KERNEL__
    drv->wait_mode = drv_cfg->wait_mode;
#  if DRV_PCF2123_INSTANCE_WAIT_MODE_SLEEP_USED
    drv->wait_sleepms = drv_cfg->wait_sleepms;
#  endif
# endif
#endif
    // And we're done!
    return drv;
}

/**
 * @brief    Get current time from RTC
 *
 * This function reads the current calendar time from the PCF2123 device.
 * (Day of year and Daylight Savings flag of tm structure are not supported.)
 *
 * @param  drv pointer to driver
 * @param  t   pointer to tm structure
 *
 * @return 0 on succes, error otherwise
 */

int pcf2123_get_time( pcf2123_t * drv, struct tm * t )
{
    uint32_t part_1, part_2, part_3;

    assert( drv != NULL );
    assert( t != NULL );

#if DRV_PCF2123_INSTANCE_BUS_SHARING_TRUE_USED
    if ( drv->bus_sharing )
    {
        while( !spi_get_bus( drv->spi, drv->channel ) ) threadwait(drv);
    }
#endif

    spi_cs_hi(drv->spi);   //Toggle CS high then low
    spi_cs_lo(drv->spi);

    spi_set_endianess( drv->spi, false );               // Switch SPI to little endian
    spi_transceive8( drv->spi, 0x90 );
    part_1 = spi_transceive32( drv->spi, 0xFFFFFFFF );
    part_2 = spi_transceive32( drv->spi, 0xFFFFFFFF );
    part_3 = spi_transceive32( drv->spi, 0xFFFFFFFF );

    spi_cs_hi( drv->spi );

#if DRV_PCF2123_INSTANCE_BUS_SHARING_TRUE_USED
    if ( drv->bus_sharing )
    {
        spi_release_bus( drv->spi );
    }
#endif

    t->tm_sec  = bcd2bin( (part_1 >> 16) & 0x7f );
    t->tm_min  = bcd2bin( (part_1 >> 24) & 0x7f );
    if (part_1 & (1<<2))        /* 12 hour mode */
    {
        int hour = part_2 & 0x1f;

        if (part_2 & (1<<5))    /* PM */
        {
            if (hour == 12)
            {
                t->tm_hour = 0;
            }
            else
            {
                t->tm_hour = 12 + hour;
            }
        }
        else                    /* AM */
        {
            t->tm_hour = hour;
        }
    }
    else                        /* 24 hour mode */
    {
        t->tm_hour = bcd2bin( (part_2) & 0x3f );
    }
    t->tm_mday = bcd2bin( (part_2 >> 8) & 0x3f);
    t->tm_wday = bcd2bin( (part_2 >> 16) & 0x07 );
    t->tm_mon  = bcd2bin( (part_2 >> 24) & 0x1F ) - 1;  // device 1 - 12, tm_mon Month of year [0,11]
    t->tm_year = bcd2bin( (part_3) & 0xff) + 100;       // tm_year  Years since 1900

    t->tm_isdst = 0;
    t->tm_yday = 0;

    return 0;
}

/**
 * @brief    Set the current time to RTC
 *
 * This function sets the current time of the PCF2123 device.
 * (Day of year and Daylight Savings flag of tm structure are not supported.)
 *
 * @param  drv pointer to driver
 * @param  t   pointer to valid tm structure
 *
 * @return 0 on succes, error otherwise
 */

int pcf2123_set_time( pcf2123_t * drv, struct tm * t )
{
#if DRV_PCF2123_INSTANCE_12_HOUR_MODE_SUPPORT
    uint8_t control_1
#endif
    uint8_t hour;

    assert( drv != NULL );
    assert( t != NULL );

#if DRV_PCF2123_INSTANCE_BUS_SHARING_TRUE_USED
    if ( drv->bus_sharing )
    {
        while( !spi_get_bus( drv->spi, drv->channel ) ) threadwait(drv);
    }
#endif

    spi_cs_hi( drv->spi );
    spi_cs_lo( drv->spi );

#if DRV_PCF2123_INSTANCE_12_HOUR_MODE_SUPPORT
    spi_transmit8( drv->spi, 0x10);                     // read control_1 register
    control_1 = spi_transceive8( drv->spi, 0xff);

    if (control_1 & (1<<2))                             // device in 12 hour mode
    {
        if (t->tm_hour == 0)
        {
            hour = (1<<5) | 12;
        }
        else if (t->tm_hour > 12)
        {
            hour = (1<<5) | (t->tm_hour - 12);
        }
        else
        {
            hour = (uint8_t)t->tm_hour;
        }
    }
    else                                                // device in 24 hour mode
    {
        hour = (uint8_t)t->tm_hour;
    }

    spi_cs_hi( drv->spi );
    spi_cs_lo( drv->spi );
#else
    hour = (uint8_t)t->tm_hour;
#endif

    spi_transmit8( drv->spi, 0x12 );                    // Send address
    spi_transceive8( drv->spi, bin2bcd( t->tm_sec ) );
    spi_transceive8( drv->spi, bin2bcd( t->tm_min ) );
    spi_transceive8( drv->spi, bin2bcd( hour ) );
    spi_transceive8( drv->spi, bin2bcd( t->tm_mday ) );
    spi_transceive8( drv->spi, bin2bcd( t->tm_wday ) );
    spi_transceive8( drv->spi, bin2bcd( t->tm_mon + 1 ) );      // tm_mon Month of year [0,11], pcf2123 MONTHS (1 to 12)
    spi_transceive8( drv->spi, bin2bcd( t->tm_year % 100 ) );

    spi_cs_hi( drv->spi );

#if DRV_PCF2123_INSTANCE_BUS_SHARING_TRUE_USED
    if ( drv->bus_sharing )
    {
        spi_release_bus( drv->spi );
    }
#endif

    return 0;
}


/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007-2010, Altium
|*
|*  Description:        GPS_NMEA driver. This plugin extends a UART8 plugin
|*
\*****************************************************************************/

#include "drv_gps_nmea_internal.h"

static drv_gps_nmea_t gps_nmea_driver_table[DRV_GPS_NMEA_INSTANCE_COUNT];

/**
 * @brief Open an instance of the driver
 *
 * This function initializes the GPS_NMEA driver, along with its associated UART8 core and driver by means of uart8_open().
 *
 * @param      id    valid driver id
 *
 * @return NULL if invalid id is passed, pointer to initialized driver otherwise
 */
drv_gps_nmea_t * drv_gps_nmea_open( unsigned int id )
{
    drv_gps_nmea_t * drv = &gps_nmea_driver_table[id];
    const drv_gps_nmea_cfg_instance_t * cfg = &drv_gps_nmea_instance_table[id];

    if ( id >= DRV_GPS_NMEA_INSTANCE_COUNT ) return NULL;

    if (drv->signature != DRV_GPS_NMEA_SIGNATURE)
    {
        drv->uart8     = uart8_open(cfg->drv_uart8);
        if (!drv->uart8) return NULL;

        drv->signature = DRV_GPS_NMEA_SIGNATURE;
    }
    return drv;
}


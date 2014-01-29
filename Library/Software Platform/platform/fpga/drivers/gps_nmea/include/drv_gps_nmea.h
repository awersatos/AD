/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007-2010, Altium
|*
|*  Description:        GPS_NMEA driver. This plugin extends a UART8 plugin
|*
\*****************************************************************************/

/**
 * @file
 * This driver is an extension of the UART serial port driver.
 */

#ifndef _DRV_GPS_NMEA_H
#define _DRV_GPS_NMEA_H

#include "drv_uart8.h"

typedef struct drv_gps_nmea_s drv_gps_nmea_t;

extern drv_gps_nmea_t * drv_gps_nmea_open(unsigned int id);

#endif /* _DRV_GPS_NMEA_H */


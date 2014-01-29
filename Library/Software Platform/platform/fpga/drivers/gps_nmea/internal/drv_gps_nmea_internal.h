/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007-2010, Altium
|*
|*  Description:        GPS_NMEA driver. This plugin extends a UART8 plugin
|*
\*****************************************************************************/

#ifndef _DRV_GPS_NMEA_I_H
#define _DRV_GPS_NMEA_I_H

#include "drv_gps_nmea.h"
#include "drv_uart8_internal.h"
#include "drv_gps_nmea_cfg_instance.h"

#define DRV_GPS_NMEA_SIGNATURE 0x785924AF

struct drv_gps_nmea_s
{
    uint32_t     signature;
    uart8_t    * uart8;
};

#endif /* _DRV_GPS_NMEA_I_H */


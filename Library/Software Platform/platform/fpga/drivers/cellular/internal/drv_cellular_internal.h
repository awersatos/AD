/*************************************************************************
|*
|*  VERSION CONTROL:    $Version$   $17/03/2010$
|*
|*  IN PACKAGE:         
|*
|*  COPYRIGHT:          Copyright (c) 2010, Altium
|*
|*  DESCRIPTION:        
|*
 */

#ifndef DRV_CELLULAR_INTERNAL_H_
#define DRV_CELLULAR_INTERNAL_H_

#include <stdint.h>

#include "drv_cellular_cfg_instance.h"

#include "drv_cellular.h"
#include "drv_uart8_internal.h"

#define DRV_CELLULAR_GPS_BAUDRATE    4800
#define DRV_CELLULAR_GPS_BUFFER_SIZE 128

struct drv_cellular_s
{
    uint32_t  signature;
    uart8_t * uart8;
    uint8_t   gps_buffer[DRV_CELLULAR_GPS_BUFFER_SIZE];
    uint8_t * baseaddress;
};


#endif /* DRV_CELLULAR_INTERNAL_H_ */

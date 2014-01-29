/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2010 Altium
|*
|*  Description:        Create and install location services
|*
\*****************************************************************************/

#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <assert.h>

#include <location.h>
#include <gps_simcom.h>
#include "location_internal.h"
#include "location_cfg_instance.h"
#include "gps_simcom_to_location_cfg_instance.h"


/*****************************************************************************
|*
|*  Function:           gps_simcom_to_location_open
|*
|*  Parameters:         id     : instance index
|*
|*  Returns:            an pointer to an initialized gps_simcom context if successful,
|*                      NULL otherwise.
|*
|*  Description:        Open gps_simcom device. Initializes a device and
|*                      registers device context.
 */
static void * gps_simcom_to_location_open(unsigned int id)
{
    return (void *) gps_simcom_open(id);
}

/*****************************************************************************
|*
|*  Function:           gps_nmea_to_location_start
|*
|*  Parameters:         id     : instance index
|*
|*  Returns:            an pointer to an initialized gps_nmea context if successful,
|*                      NULL otherwise.
|*
|*  Description:        Starts gps_nmea device.
 */
static bool gps_simcom_to_location_start(void * instance)
{
    return gps_simcom_start((gps_simcom_t *) instance, GPS_AUTO_START);
}

/*****************************************************************************
|*
|*  Function:           gps_nmea_to_location_stop
|*
|*  Parameters:         id     : instance index
|*
|*  Returns:            nothing
|*
|*  Description:        stops gps_nmea device. (NOP)
 */
static bool gps_simcom_to_location_stop(void * instance)
{
    return gps_simcom_stop((gps_simcom_t *) instance);
}

/*****************************************************************************
|*
|*  Function:           gps_simcom_to_location_get_info
|*
|*  Parameters:         id     : instance index
|*
|*  Returns:            an pointer to an initialized gps_simcom context if successful,
|*                      NULL otherwise.
|*
|*  Description:        Open gps_simcom device. Initializes a device and
|*                      registers device context.
 */
static bool gps_simcom_to_location_get_info(void * instance, location_info_t * info)
{
     gps_simcom_info_t gps_simcom_info;
     int success;

     assert(instance && info);
     success = gps_simcom_get_info((gps_simcom_t *) instance,&gps_simcom_info);
     if (!success) return false;

     info->latitude  = gps_simcom_info.latitude;
     info->longitude = gps_simcom_info.longitude;
     info->altitude  = gps_simcom_info.altitude;
     info->speed     = gps_simcom_info.speed;
     info->UTC       = gps_simcom_info.UTC;

     return true;
}


/*****************************************************************************
|*
|*  Function:           gps_simcom_to_location_init
|*
|*  Description:        Plugin initialization. Initializes the location services
|*                      instance table.
|*
 */
extern void gps_simcom_to_location_init(void)
{
    const gps_simcom_to_location_cfg_instance_t * cfg;

    /* posix device table (devio_t) */
    for (int gps_simcom_id = 0; gps_simcom_id < GPS_SIMCOM_TO_LOCATION_INSTANCE_COUNT; gps_simcom_id++)
    {
        cfg = &gps_simcom_to_location_instance_table[gps_simcom_id];
        location_init(cfg->location_adaptor,
                      gps_simcom_id,
                      gps_simcom_to_location_open,
                      gps_simcom_to_location_start,
                      gps_simcom_to_location_stop,
                      gps_simcom_to_location_get_info);
    }
}


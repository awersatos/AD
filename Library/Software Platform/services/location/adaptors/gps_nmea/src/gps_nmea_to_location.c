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
#include <gps_nmea.h>
#include "location_internal.h"
#include "location_cfg_instance.h"
#include "gps_nmea_to_location_cfg_instance.h"


/*****************************************************************************
|*
|*  Function:           gps_nmea_to_location_open
|*
|*  Parameters:         id     : instance index
|*
|*  Returns:            an pointer to an initialized gps_nmea context if successful,
|*                      NULL otherwise.
|*
|*  Description:        Open gps_nmea device. Initializes a device and
|*                      registers device context.
 */
static void * gps_nmea_to_location_open(unsigned int id)
{
    return (void *) gps_nmea_open(id);
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
|*  Description:        Starts gps_nmea device. (NOP)
 */
static bool gps_nmea_to_location_start(void * instance)
{
    return (bool) gps_nmea_start((gps_nmea_t *) instance);
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
static bool gps_nmea_to_location_stop(void * instance)
{
    return (bool) gps_nmea_stop((gps_nmea_t *) instance);
}

/*****************************************************************************
|*
|*  Function:           gps_nmea_to_location_get_info
|*
|*  Parameters:         id     : instance index
|*
|*  Returns:            an pointer to an initialized gps_nmea context if successful,
|*                      NULL otherwise.
|*
|*  Description:        Open gps_nmea device. Initializes a device and
|*                      registers device context.
 */
static bool gps_nmea_to_location_get_info(void * instance, location_info_t * info)
{
     gps_info_t * gps_nmea_info;

     assert(instance && info);
     gps_nmea_info = gps_nmea_decode((gps_nmea_t *) instance,false);
     if (!gps_nmea_info) return false;

     info->latitude  = gps_nmea_info->latitude;
     info->longitude = gps_nmea_info->longitude;
     info->altitude  = gps_nmea_info->altitude;
     info->speed     = gps_nmea_info->speed;
     info->UTC       = gps_nmea_info->UTC;

     return (gps_nmea_info->fix & GPS_VALID) != 0;
}

/*****************************************************************************
|*
|*  Function:           gps_nmea_to_location_init
|*
|*  Description:        Plugin initialization. Initializes the location services
|*                      instance table.
|*
 */
extern void gps_nmea_to_location_init(void)
{
    const gps_nmea_to_location_cfg_instance_t * cfg;

    /* posix device table (devio_t) */
    for (int gps_nmea_id = 0; gps_nmea_id < GPS_NMEA_TO_LOCATION_INSTANCE_COUNT; gps_nmea_id++)
    {
        cfg = &gps_nmea_to_location_instance_table[gps_nmea_id];
        location_init(cfg->location_adaptor,
                      gps_nmea_id,
                      gps_nmea_to_location_open,
                      gps_nmea_to_location_start,
                      gps_nmea_to_location_stop,
                      gps_nmea_to_location_get_info);
    }
}


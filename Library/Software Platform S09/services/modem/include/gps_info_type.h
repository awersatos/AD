/*****************************************************************************\
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  COPYRIGHT:          Copyright (c) 2007, Altium
|*
|*  DESCRIPTION:        GPS info type
|*
 */
#ifndef _GPS_INFO_TYPE_H_
#define _GPS_INFO_TYPE_H_

#include <time.h>

/**
 * @brief
 *      GPS info structure
 *
 * This data structure holds information received from the GPS receiver.
 */
typedef struct modem_gps_info_s
{
    double latitude;        /**< latitude in degrees; positive = North, negative = South */
    double longitude;       /**< longitude in degrees; positive = East, negative = West */
    double altitude;        /**< altitude in meters */
    float speed;            /**< speed in knots */
    struct tm UTC;          /**< UTC time */
} modem_gps_info_t;

#endif //_GPS_INFO_TYPE_H_

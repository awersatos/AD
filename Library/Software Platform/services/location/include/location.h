#ifndef _LOCATION_H
#define _LOCATION_H

/**
 * @file
 * GPS-NMEA decoder. Messages from a NMEA compatible receiver are decoded and used to update the current time and position information.
 * The decoded messages can be get for other use, like storing in a log-file.
 */

#include <stdbool.h>
#include <time.h>

/**
 * @brief
 *      location info structure
 *
 * This data structure holds location information
 */
typedef struct location_info_s
{
    double latitude;        /**< latitude in degrees; positive = North, negative = South */
    double longitude;       /**< longitude in degrees; positive = East, negative = West */
    double altitude;        /**< altitude in meters */
    float speed;            /**< speed in knots */
    struct tm UTC;          /**< UTC time that info was computed */
} location_info_t;

typedef struct location_s location_t;

#ifdef  __cplusplus
extern "C" {
#endif

location_t * location_open    (unsigned int id);
bool         location_start   (location_t * location);
bool         location_stop    (location_t * location);
bool         location_get_info(location_t * location, location_info_t * info);

#ifdef  __cplusplus
}
#endif

#endif // _LOCATION_H

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

#ifdef  __cplusplus
extern "C" {
#endif

#include <time.h>

typedef struct gps_simcom_s gps_simcom_t;

/**
 * @brief
 *      GPS info structure
 *
 * This data structure holds information received from the GPS receiver.
 */
typedef struct gps_simcom_info_s
{
    double latitude;        /**< latitude in degrees; positive = North, negative = South */
    double longitude;       /**< longitude in degrees; positive = East, negative = West */
    double altitude;        /**< altitude in meters */
    float speed;            /**< speed in knots */
    struct tm UTC;          /**< UTC time */
} gps_simcom_info_t;

typedef enum
{
  GPS_AUTO_START,
  GPS_COLD_START,
  GPS_HOT_START,
} gps_simcom_start_t;

extern gps_simcom_t * gps_simcom_open(unsigned int id);
extern int gps_simcom_start   (gps_simcom_t * simcom, gps_simcom_start_t mode);
extern int gps_simcom_stop    (gps_simcom_t * simcom);
extern int gps_simcom_get_info(gps_simcom_t * simcom, gps_simcom_info_t *info);

#ifdef  __cplusplus
}
#endif

#endif //_GPS_INFO_TYPE_H_

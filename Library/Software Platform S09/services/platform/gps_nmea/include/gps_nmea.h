#ifndef DRV_GPS_H
#define DRV_GPS_H

/**
 * @file
 * GPS-NMEA decoder. Messages from a NMEA compatible receiver are decoded and used to update the current time and position information.
 * The decoded messages can be get for other use, like storing in a log-file.
 */

#include <stdbool.h>
#include <time.h>
#include <gps_nmea_cfg.h>


#define GPS_VALID   0x01
#define GPS_3D      0x02
#define GPS_DIFF    0x04

typedef struct gps_nmea_s gps_nmea_t;

#if GPS_NMEA_EXTENDED == 1

 /**
 * @brief
 *      GPS satellite information structure
 *
 * This structure describes a GPS satellite.
 *
 */

typedef struct
{
    unsigned char   id;         /**< ID */
    unsigned char   elevation;  /**< elevation in degrees; 0 = horizon, 90 = zenith */
    unsigned short  azimuth;    /**< azimuth in degrees; 0 = North */
    unsigned char   snr;        /**< signal to noise ratio */
    bool            used;       /**< used in calculation */
} gps_sat_t;
#endif

 /**
 * @brief
 *      GPS infromation structure
 *
 * This structure describes the GPS information. @em PDOP, @em HDOP, @em VDOP and @em sats are only available in extended mode.
 *
 */

typedef struct
{
    double latitude;        /**< latitude in degrees; positive = North, negative = South */
    double longitude;       /**< longitude in degrees; positive = East, negative = West */
    double altitude;        /**< altitude in meters */
    float speed;            /**< speed in knots */
    float course;           /**< course in degrees, 0 = true North */
    struct tm UTC;          /**< UTC time */
    int fix;                /**< fix type: bit 0 = valid; bit 1 = 3D; bit 2 = differential mode */
#if GPS_NMEA_EXTENDED == 1
    float PDOP;             /**< Position Dilution Of Precision */
    float HDOP;             /**< Horizontal Dilution Of Precision */
    float VDOP;             /**< Vertical Dilution Of Precision */
    gps_sat_t sats[12];     /**< Satellite info */
#endif
} gps_info_t;



#ifdef  __cplusplus
extern "C" {
#endif

gps_nmea_t *gps_nmea_open(unsigned int id);
gps_info_t *gps_nmea_decode(gps_nmea_t *gps, bool all);
char *gps_nmea_get_message(gps_nmea_t *gps);

#ifdef  __cplusplus
}
#endif

#endif

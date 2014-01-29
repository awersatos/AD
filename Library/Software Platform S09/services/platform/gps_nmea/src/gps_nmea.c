#include <stdio.h>
#include <stdbool.h>
#include <float.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include <time.h>
#include <drv_uart8.h>
#include <gps_nmea.h>
#include <gps_nmea_cfg_instance.h>
#include <assert.h>

static void gga(gps_info_t *gps_info, char *message);
static void rmc(gps_info_t *gps_info, char *message);
#if GPS_NMEA_EXTENDED == 1
static void gll(gps_info_t *gps_info, char *message);
static void gsa(gps_info_t *gps_info, char *message);
static void gsv(gps_info_t *gps_info, char *message);
static void vtg(gps_info_t *gps_info, char *message);
#endif
static bool checksum_ok(char *message);
static int  gps_decode_message(gps_nmea_t *gps);

// runtime driver table
static gps_nmea_t gps_nmea_table[GPS_NMEA_INSTANCE_COUNT];


struct gps_nmea_s
{
    uart8_t *uart8;
    gps_info_t  gps_info;
    int last_message_result;
    char *cm;
    char message[128];
};


inline int xtoi(char c)
{
    if (isdigit(c))
    {
        return c - '0';
    }
    return toupper(c) - 'A' + 10;
}


/**
 * @brief    Open an instance of the service
 *
 * This function initializes the service and opens the drivers beneath first time the service is called.
 * Further attemps to open an already opened instance of the service simply returns the same pointer.
 *
 * @param  id  valid driver id
 *
 * @return Service pointer if succesful initialized, NULL otherwise
 */

gps_nmea_t *gps_nmea_open(unsigned int id)
{
    assert( id < GPS_NMEA_INSTANCE_COUNT );

    // Copy peripheral data to driver table
    gps_nmea_t * restrict srv = &gps_nmea_table[id];
    if (!srv->uart8)
    {
        gps_nmea_cfg_instance_t * restrict srv_cfg = &gps_nmea_instance_table[id];

        assert( srv_cfg->drv_uart8 != -1);
        srv->uart8 = uart8_open( srv_cfg->drv_uart8 );
    }
    return srv->uart8 ? srv : NULL;
}


/**
 * @brief    Decode NMEA message(s)
 *
 * This function decodes an NMEA message if available and updates the structure holding the GPS information.
 * If @em all is true, all available messages will be decoded sequential, otherwise only one message will be decoded.
 * The function returns a pointer to the structure containing the GPS information.
 *
 * A successive call to gps_nmea_get_message() gives the last processed message if that message was valid,
 * otherwise it will return @em NULL. If @em all = true, the function will proceed until the
 *
 * @param  gps  Service pointer as returned from gps_nmea_open()
 * @param  all  Continue decoding until all available messages are processed
 *
 * @return Pointer to a structure containing the GPS information
 */

gps_info_t *gps_nmea_decode(gps_nmea_t *gps, bool all)
{
    int result;

    while ((result = gps_decode_message(gps)) && all);

    gps->last_message_result = result;
    return &gps->gps_info;
}


/**
 * @brief    Get the last decoded message
 *
 * This function returns the last decoded message.
 * If the last attemp of gps_nmea_decode() failed due to an error or lack of messages, this function returns @em NULL.
 * If gps_nmea_decode() was called with @em all = true, it continued until it failed by lack of messages,
 * which inplies that this function will return @em NULL.
 *
 * @param  gps  Service pointer as returned from gps_nmea_open()
 *
 * @return Pointer to the last decoded message if available, otherwise NULL
 */

char *gps_nmea_get_message(gps_nmea_t *gps)
{
    return gps->last_message_result == 1 ? gps->message : NULL;
}



// return 1: valid message decoded; 0: nothing to decode; -1: error detected
static int gps_decode_message(gps_nmea_t *gps)
{
    int c = 0;

    // look for start of message
    while (gps->cm == NULL)
    {
        c = uart8_getchar(gps->uart8);
        if (c == -1)
        {
            return 0;   // empty receiver buffer
        }
        if (c == '$')
        {
            gps->message[0] = '$';
            gps->cm = gps->message + 1;
        }

    }

    // copy message
    do
    {
        c = uart8_getchar(gps->uart8);
        if (c ==  -1)
        {
            return 0;   // empty receiver buffer
        }
        *gps->cm = (char)c;
    } while (*gps->cm != '\n' && gps->cm++ < (gps->message + 126));

    if (gps->cm == gps->message + 127)    // buffer overrun, ignore message
    {
        gps->cm = NULL;
        return -1;  // buffer overrun
    }
    *(gps->cm + 1) = '\0';
    gps->cm = NULL;


    // check checksum
    if (!checksum_ok(gps->message))
    {
        return -1;  // checksum error
    }

    // decode message
    if (strncmp(gps->message, "$GPGGA,", 7) == 0)
    {
        gga(&gps->gps_info, gps->message);
    }
    else if (strncmp(gps->message, "$GPRMC,", 7) == 0)
    {
        rmc(&gps->gps_info, gps->message);
    }

#if GPS_NMEA_EXTENDED == 1
    // messages for extended mode
    else if (strncmp(gps->message, "$GPGLL,", 7) == 0)
    {
        gll(&gps->gps_info, gps->message);
    }
    else if (strncmp(gps->message, "$GPGSA,", 7) == 0)
    {
        gsa(&gps->gps_info, gps->message);
    }
    else if (strncmp(gps->message, "$GPGSV,", 7) == 0)
    {
        gsv(&gps->gps_info, gps->message);
    }
    else if (strncmp(gps->message, "$GPVTG,", 7) == 0)
    {
        vtg(&gps->gps_info, gps->message);
    }
#endif

    return 1;
}

static bool checksum_ok(char *message)
{
    char *c = message + 1;
    int checksum = 0;

    while (checksum ^= *c, *++c != '*');  // calc checksum

    if (checksum != (xtoi(*(c+1)) * 16 + xtoi(*(c+2))))
    {
        return false;
    }
    return true;
}


static char *decode_time(gps_info_t *gps_info, char *str)
{
    if (*str == ',') return str + 1;
    gps_info->UTC.tm_hour = str[0] * 10 + str[1] - 11 * '0';
    gps_info->UTC.tm_min = str[2] * 10 + str[3] - 11 * '0';
    gps_info->UTC.tm_sec = str[4] * 10 + str[5] - 11 * '0';
    while (*str++ != ',');  // skip fraction of sec (if available)
    return str;
}


static char *decode_date(gps_info_t *gps_info, char *str)
{
    if (*str == ',') return str + 1;
    gps_info->UTC.tm_mday = str[0] * 10 + str[1] - 11 * '0';
    gps_info->UTC.tm_mon = str[2] * 10 + str[3] - 11 * '0' - 1;     // GPS date: month = 1-12; struct tm: month is 0-11
    gps_info->UTC.tm_year = str[4] * 10 + str[5] - 11 * '0' + 100;  // we live in the 21 century
    mktime(&gps_info->UTC);
    return str + 7;
}


static char *decode_lat(gps_info_t *gps_info, char *str)
{
    int degr;
    double min;

    if (*str == ',') return str + 2;
    degr = str[0] * 10 + str[1] - 11 * '0';
    min = strtod(str + 2, &str);
    gps_info->latitude = str[1] == 'S' ? min / -60.0 - degr : min / 60.0 + degr;
    return str + 3;
}


static char *decode_lon(gps_info_t *gps_info, char *str)
{
    int degr;
    double min;

    if (*str == ',') return str + 2;
    degr = str[0] * 100 + str[1] * 10 + str[2] - 111 * '0';
    min = strtod(str + 3, &str);
    gps_info->longitude = str[1] == 'W' ? min / -60.0 - degr : min / 60.0 + degr;
    return str + 3;
}


static void gga(gps_info_t *gps_info, char *message)
{
    char *cp = message + 7;

    // UTC time
    cp = decode_time(gps_info, cp);

    // latitude
    cp = decode_lat(gps_info, cp);

    // longitude
    cp = decode_lon(gps_info, cp);

    // fix
    switch (*cp)
    {
    case '1':
        gps_info->fix |= GPS_VALID;
        gps_info->fix &= ~GPS_DIFF;
        break;
    case '2':
        gps_info->fix |= GPS_VALID | GPS_DIFF;
        break;
    default:
        gps_info->fix = 0;
        break;
    }
    cp += 2;

    while (*cp++ != ',');               // skip number of sats

#if GPS_NMEA_EXTENDED == 1
    gps_info->HDOP = strtod(cp, &cp);   // horizontal dilution
    cp++;
#else
    while (*cp++ != ',');               // skip hor. dilution
#endif

    // altitude
    gps_info->altitude = strtod(cp, &cp);
//    cp++;
//    cp += 2;    // ignore altitude units
//
//    // geoidal separation
//    gps_info->altitude += strtod(cp, &cp);
}


static void rmc(gps_info_t *gps_info, char *message)
{
    char *cp = message + 7;

    // UTC time
    cp = decode_time(gps_info, cp);

    // fix
    switch (*cp)
    {
    case 'A':
        gps_info->fix |= GPS_VALID;
        break;
    default:
        gps_info->fix = 0;
        break;
    }
    cp += 2;

    // latitude
    cp = decode_lat(gps_info, cp);

    // longintude
    cp = decode_lon(gps_info, cp);


    // ground speed
    gps_info->speed = strtod(cp, &cp);
    cp++;

    // track course
    gps_info->course = strtod(cp, &cp);
    cp++;

    // date
    cp = decode_date(gps_info, cp);
}



#if GPS_NMEA_EXTENDED == 1

static void gll(gps_info_t *gps_info, char *message)
{
    char *cp = message + 7;

    // latitude
    cp = decode_lat(gps_info, cp);

    // longintude
    cp = decode_lon(gps_info, cp);

    // UTC time
    cp = decode_time(gps_info, cp);

    // fix
    switch (*cp)
    {
    case 'A':
        gps_info->fix |= GPS_VALID;
        break;
    default:
        gps_info->fix = 0;
        break;
    }
}


static void gsa(gps_info_t *gps_info, char *message)
{
    char *cp = message + 7;
    int id;
    int used = 0;

    //skip auto/manual 2D-3D mode
    cp += 2;

    // fix type
    switch (*cp)
    {
    case '2':
        gps_info->fix |= GPS_VALID;
        gps_info->fix &= ~GPS_3D;
        break;
    case '3':
        gps_info->fix |= GPS_VALID | GPS_3D;
        break;
    default:
        gps_info->fix = 0;
        break;
    }
    cp += 2;

    for (int i = 0; i < 12; i++)
    {
        gps_info->sats[i].used = false;
    }

    for (int i = 0; i < 12; i++)
    {
        if (*cp != ',')
        {
            used++;
            id = cp[0] * 10 + cp[1] - 11 * '0';
            cp += 2;
            for (int j = 0; j < 12; j++)
            {
                if (gps_info->sats[j].id == id)
                {
                    gps_info->sats[j].used = true;
                    break;
                }
            }
        }
        cp++;
    }
    gps_info->PDOP = strtod(cp, &cp);  // position dilution
    cp++;
    gps_info->HDOP = strtod(cp, &cp);  // horizontal dilution
    cp++;
    gps_info->VDOP = strtod(cp, &cp);  // vertical dilution
    cp++;
}


static void gsv(gps_info_t *gps_info, char *message)
{
    char *cp = message + 7;
    int i;

    // clear sats not covered by any message
    for (i = ((*cp - '0') * 4); i < 12; i++)
    {
        gps_info->sats[i].id = 0;
        gps_info->sats[i].elevation = 0;
        gps_info->sats[i].azimuth = 0;
        gps_info->sats[i].snr = 0;
        gps_info->sats[i].used = 0;
    }
    cp += 2;

    // first index in this nessage and skip total sats
    i = (*cp - '1') * 4;

    if (i >= 12)
    {
        return; // ignore messages not describing first 12 satelites
    }
    cp += 4;

    while (*cp != '*')
    {
        cp++;
        if (*cp != ',')
        {
            gps_info->sats[i].id = cp[0] * 10 + cp[1] - 11 * '0';
            cp +=3;
        }
        else
        {
            cp++;
        }
        if (*cp != ',')
        {
            gps_info->sats[i].elevation = cp[0] * 10 + cp[1] - 11 * '0';
            cp += 3;
        }
        else
        {
            cp++;
        }
        if (*cp != ',')
        {
            gps_info->sats[i].azimuth = cp[0] * 100 + cp[1] * 10 + cp[2] - 111 * '0';
            cp += 4;
        }
        else
        {
            cp++;
        }
        if (*cp != ',' && *cp != '*')
        {
            gps_info->sats[i].snr = cp[0] * 10 + cp[1] - 11 * '0';
            cp += 2;
        }
        i++;
    }
    while (i%4)
    {
        gps_info->sats[i].id = 0;
        gps_info->sats[i].elevation = 0;
        gps_info->sats[i].azimuth = 0;
        gps_info->sats[i].snr = 0;
        gps_info->sats[i].used = 0;
        i++;
    }

}


static void vtg(gps_info_t *gps_info, char *message)
{
    char *cp = message + 7;

    // track course (True)
    gps_info->course = strtod(cp, &cp);

    // skip reference (True)
    cp += 3;

    while (*cp++ != ',');  // skip course  (Magnetic)
    while (*cp++ != ',');  // skip reference (Magnetic)

    gps_info->speed = atof(cp);  // speed in knots

    // ignore rest of message
}

#endif

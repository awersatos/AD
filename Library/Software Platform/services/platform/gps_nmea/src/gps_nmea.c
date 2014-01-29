#include <stdbool.h>
#include <float.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
#include <assert.h>

#include <gps_nmea.h>
#include <gps_nmea_cfg_instance.h>
#include <serial_cfg_instance.h>

static void gga(gps_info_t *gps_info, char *message);
static void rmc(gps_info_t *gps_info, char *message);
#if GPS_NMEA_EXTENDED == 1
static void gll(gps_info_t *gps_info, char *message);
static void gsa(gps_info_t *gps_info, char *message);
static void gsv(gps_info_t *gps_info, char *message);
static void vtg(gps_info_t *gps_info, char *message);
#endif
static int  get_checksum(char * message);
static bool checksum_ok(char *message);
static int  gps_decode_message(gps_nmea_t *gps);

// runtime driver table
static gps_nmea_t gps_nmea_table[GPS_NMEA_INSTANCE_COUNT];

#define GPS_NMEA_SIGNATURE 0x243982fc
struct gps_nmea_s
{
    uint32_t signature;
    FILE *fd;
    gps_info_t  last_fix;
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
 * Further attempts to open an already opened instance of the service simply return the same pointer.
 *
 * @param  id  valid service id
 *
 * @return Service pointer if succesful initialized, NULL otherwise
 */

gps_nmea_t *gps_nmea_open(unsigned int id)
{
    char serial_name[128] = "/dev/";
    assert( id < GPS_NMEA_INSTANCE_COUNT );

    gps_nmea_t * restrict srv = &gps_nmea_table[id];
    const gps_nmea_cfg_instance_t * srv_cfg    = &gps_nmea_instance_table[id];
    const serial_cfg_instance_t   * serial_cfg = & serial_instance_table[srv_cfg->serial];

    if (srv->signature != GPS_NMEA_SIGNATURE)
    {
        memset (srv, 0, sizeof(gps_nmea_t));

        strncat(serial_name,serial_cfg->name,127);
        srv->fd = fopen(serial_name,"r+");
        if (srv->fd < 0) return NULL;

        srv->signature = GPS_NMEA_SIGNATURE;
    }
    return srv;
}

#define SECONDS_PER_MIN   60
#define SECONDS_PER_HOUR (60 * SECONDS_PER_MIN)
#define SECONDS_PER_DAY  (24 * SECONDS_PER_HOUR)
#define SECONDS_PER_WEEK ( 7 * SECONDS_PER_DAY)

typedef enum
{
    GPS_HOT_START = 1,
    GPS_WARM_START = 2,
    GPS_WARM_INIT_START = 3,
    GPS_COLD_START = 4,
    GPS_FACTORY_RESET = 8,
} gps_nmea_reset_t;

static int gps_time_of_week(struct tm * time)
{
    return time->tm_wday * SECONDS_PER_DAY
        +  time->tm_hour * SECONDS_PER_HOUR
        +  time->tm_min  * SECONDS_PER_MIN
        +  time->tm_sec;
}

static int extended_gps_week_number(struct tm * time)
{
    static struct tm jan_1_1980 = { 0, 0, 0, 1, 0, 1980, 0, 0, 0};
    double seconds_since_1980 = difftime(mktime(time),mktime(&jan_1_1980));
    return 1024 + (int) (seconds_since_1980 / SECONDS_PER_WEEK);
}

static int gps_channel_count(gps_nmea_t * gps)
{
    int count = 0;
#if GPS_NMEA_EXTENDED == 1
    while (gps->gps_info.sats[count].id && ++count < 12);
#endif
    return count;
}

#define GPS_START_TYPE GPS_HOT_START   // try to hot start; if the GPS doesn't have the data, maybe ours is useful (below)

/**
 * @brief (Re)activate the GPS_NMEA device
 *
 * @param  gps       a pointer to a gps_nmea_t instance previously returned by gps_nmea_open()
 * @return non-zero  if the device started, or
 *         0         if the device failed to start
 */
int gps_nmea_start(gps_nmea_t * gps)
{
    char buf[BUFSIZ];
    bool result = true;

    assert(gps);

    result = snprintf(buf,BUFSIZ,"$PSRF104,%lf,%lf,%lf,0,%u,%u,%02u,%u",
                                 gps->last_fix.latitude,
                                 gps->last_fix.longitude,
                                 gps->last_fix.altitude,
                                 gps_time_of_week(&gps->gps_info.UTC),
                                 extended_gps_week_number(&gps->gps_info.UTC),
                                 gps_channel_count(gps),
                                 GPS_START_TYPE
                                 ) >= 0;
    result = result && fprintf(gps->fd, "%s*%02x\r\n", buf, get_checksum(buf)) >= 0;
    result = result && fflush(gps->fd) >= 0;
    return result;
}

/**
 * @brief Deactivate the GPS_NMEA device
 *
 * @param  gps       a pointer to a gps_nmea_t instance previously returned by gps_nmea_open()
 * @return non-zero  if the device stopped, or
 *         0         if the device failed to stop
 */
int gps_nmea_stop(gps_nmea_t * gps)
{
    bool result = true;

    assert(gps);
    return true;
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

    assert(gps);

    while ((result = gps_decode_message(gps)) && all);

    gps->last_message_result = result;

    if(gps->gps_info.fix & GPS_VALID) gps->last_fix = gps->gps_info;

    return &gps->gps_info;
}

/**
 * @brief    Get the GPS information decoded last time a valid fix was held
 *
 * This function returns the last info decoded from the GPS where a valid fix was present, if any.
 *
 * @param  gps  Service pointer as returned from gps_nmea_open()
 *
 * @return Pointer to the gps info last time a valid fix was held, if any, otherwise NULL
 */
gps_info_t * gps_nmea_last_fix(gps_nmea_t *gps)
{
    assert(gps);

    return gps->last_fix.fix & GPS_VALID ? &gps->last_fix : NULL;
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
    assert(gps);

    return gps->last_message_result == 1 ? gps->message : NULL;
}



// return 1: valid message decoded; 0: nothing to decode; -1: error detected
static int gps_decode_message(gps_nmea_t *gps)
{
    int c = 0;

    assert(gps);

    // look for start of message
    while (gps->cm == NULL)
    {
        c = fgetc(gps->fd);
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
        c = fgetc(gps->fd);
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

static int get_checksum(char * message)
{
    char *c = message;

    assert(message);

    int checksum = 0;

    if (*c == '$') c++;

    do
    {
        checksum ^= *c++;
    }
    while (*c != '*' && *c != '\0');

    return checksum;
}

static bool checksum_ok(char *message)
{
    int source_checksum;

    assert(message);

    char * c = strchr(message,'*');
    if (!c) return false;

    source_checksum = xtoi(*(c+1)) * 16 + xtoi(*(c+2));
    return get_checksum(message) == source_checksum;
}

#define ATOI_2(str) ((str)[0] * 10  + (str)[1] - 11 * '0')
#define ATOI_3(str) ((str)[0] * 100 + (str)[1] * 10 + (str)[2] - 111 * '0')
static char *decode_time(gps_info_t *gps_info, char *str)
{
    assert(gps_info);
    assert(str);

    if (*str == ',') return str + 1;
    gps_info->UTC.tm_hour = ATOI_2(str);
    gps_info->UTC.tm_min  = ATOI_2(str+2);
    gps_info->UTC.tm_sec  = ATOI_2(str+4);
    while (*str++ != ',');  // skip fraction of sec (if available)
    return str;
}


static char *decode_date(gps_info_t *gps_info, char *str)
{
    assert(gps_info);
    assert(str);

    if (*str == ',') return str + 1;
    gps_info->UTC.tm_mday = ATOI_2(str);
    gps_info->UTC.tm_mon  = ATOI_2(str+2) - 1;     // GPS date: month = 1-12; struct tm: month is 0-11
    gps_info->UTC.tm_year = ATOI_2(str+4) + 100;   // we live in the 21 century
    mktime(&gps_info->UTC);
    return str + 7;
}


static char *decode_lat(gps_info_t *gps_info, char *str)
{
    int degr;
    double min;

    assert(gps_info);
    assert(str);

    if (*str == ',') return str + 2;
    degr = ATOI_2(str);
    min = strtod(str + 2, &str);
    gps_info->latitude = str[1] == 'S' ? min / -60.0 - degr : min / 60.0 + degr;
    return str + 3;
}


static char *decode_lon(gps_info_t *gps_info, char *str)
{
    int degr;
    double min;

    assert(gps_info);
    assert(str);

    if (*str == ',') return str + 2;
    degr = ATOI_3(str);
    min = strtod(str + 3, &str);
    gps_info->longitude = str[1] == 'W' ? min / -60.0 - degr : min / 60.0 + degr;
    return str + 3;
}


static void gga(gps_info_t *gps_info, char *message)
{
    char *cp = message + 7;

    assert(gps_info);
    assert(message);

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

    gps_info->channel_count = ATOI_2(cp);
    cp += 3;

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

    assert(gps_info);
    assert(message);

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

    assert(gps_info);
    assert(message);

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

    assert(gps_info);
    assert(message);

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
            id = ATOI_2(cp);
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

    assert(gps_info);
    assert(message);

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
            gps_info->sats[i].id = ATOI_2(cp);
            cp +=3;
        }
        else
        {
            cp++;
        }
        if (*cp != ',')
        {
            gps_info->sats[i].elevation = ATOI_2(cp);
            cp += 3;
        }
        else
        {
            cp++;
        }
        if (*cp != ',')
        {
            gps_info->sats[i].azimuth = ATOI_3(cp);
            cp += 4;
        }
        else
        {
            cp++;
        }
        if (*cp != ',' && *cp != '*')
        {
            gps_info->sats[i].snr = ATOI_2(cp);
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

    assert(gps_info);
    assert(message);

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

/*******************************************************************************
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  IN PACKAGE:         GPS Simcom commands
|*
|*  COPYRIGHT:          Copyright (c) 2007, Altium
|*
|*  DESCRIPTION:        AT Commands to handle GPS messages
 ******************************************************************************/
#if ( __POSIX_KERNEL__ != 0 )
# include <pthread.h>
#else
#include <time.h>
#endif

#include <assert.h>

#include <string.h>
#include <stdlib.h>
#include <time.h>
#include "gps_simcom.h"
#include "gps_simcom_cfg_instance.h"
#include <modem.h>

#define GPS_SIMCOM_COMMAND_TIMEOUT_MS 600
#define GPS_SIMCOM_INFO_MAX_LENGTH    512
#define GPS_SIMCOM_SIGNATURE          0x43825078

static char *decode_time(gps_simcom_info_t *gps_info, char *str);
static char *decode_date(gps_simcom_info_t *gps_info, char *str);
static char *decode_lat(gps_simcom_info_t *gps_info, char *str);
static char *decode_lon(gps_simcom_info_t *gps_info, char *str);

typedef struct {
    const char * string;
    int          curr;
} seek_t;

struct gps_simcom_s {
    uint32_t  signature;
    modem_t * modem;
    bool      has_cold_started;
};

static gps_simcom_t gps_simcom_table[GPS_SIMCOM_INSTANCE_COUNT];

extern gps_simcom_t * gps_simcom_open(unsigned int id)
{
    gps_simcom_t * drv = &gps_simcom_table[id];
    const gps_simcom_cfg_instance_t * restrict drv_cfg = &gps_simcom_instance_table[id];

    if ( id >= GPS_SIMCOM_INSTANCE_COUNT ) return NULL;

    if (drv->signature != GPS_SIMCOM_SIGNATURE)
    {
        memset( drv, 0, sizeof( gps_simcom_t ));

        drv->modem = modem_open(drv_cfg->modem);
        if (drv->modem)
            drv->signature = GPS_SIMCOM_SIGNATURE;
    }
    return drv;
}

/**
 * @brief Start the GPS receiver
 *
 * This function starts the GPS receiver.
 * Start with a cold start, hot start of automatically chosen.
 *
 * @param simcom     pointer to simcom device struct
 * @param mode      Start mode, 0 = auto, 1 = cold, 2 = hot
 *
 * @return 1 on success, 0 on error.
 */
int gps_simcom_start(gps_simcom_t *simcom, gps_simcom_start_t mode)
{
    char * command;

    assert(simcom);

    // FIXME - jtk startup
    switch (mode)
    {
    case GPS_AUTO_START:                   // NB AT+CGPS=1 seems to be broken in 240150B16SIM5218A..SIM5218A_240150_100724_V1.
        if (simcom->has_cold_started)
        {
            command = "AT+CGPSHOT";
            break;
        }
        /* fall through */
    case GPS_COLD_START:
        command = "AT+CGPSCOLD";
        simcom->has_cold_started = true;
        break;
    case GPS_HOT_START:
        command = "AT+CGPSHOT";
        break;
    default:
        return 0;

    }
    return modem_cmd(simcom->modem, command);
}

/**
 * @brief Sop the GPS receiver
 * 
 * This function stops the GPS receiver.
 *
 * @param simcom     pointer to simcom device struct
 *
 * @return 1 on success, 0 on error.
 */
int gps_simcom_stop(gps_simcom_t *simcom)
{
    return modem_cmd(simcom->modem, "AT+CGPS=0");
}

/**
 * @brief Get GPS information
 *
 * Get the most recent gps location data from the simcom device.
 *
 * @param simcom      pointer to simcom device struct
 * @param info        pointer to info structure which will be filled with current gps info
 *
 * @return 1 on success, 0 on error.
 */
int gps_simcom_get_info(gps_simcom_t *simcom, gps_simcom_info_t *info)
{
    const char * expected = "+CGPSINFO:";
    char buffer[GPS_SIMCOM_INFO_MAX_LENGTH];
    char *cp = buffer;
    bool success = false;
  
    assert(simcom);
  
    if (modem_cmd_ex(simcom->modem, "AT+CGPSINFO", &expected,1,MODEM_DEFAULT_TIMEOUT) == 0)
    {
        if (modem_read(simcom->modem,(uint8_t *) buffer,GPS_SIMCOM_INFO_MAX_LENGTH))
        {
            cp = decode_lat(info, cp);
            cp = decode_lon(info, cp);
            cp = decode_date(info, cp);
            cp = decode_time(info, cp);
            info->altitude = strtod(cp, &cp);
            cp++;
            info->speed = strtod(cp, &cp);
            success = strncmp(buffer,",,,",3)!=0;
        }
    }
    return success;
}


static char *decode_time(gps_simcom_info_t *gps_info, char *str)
{
    assert(gps_info);
    assert(str);

    if (*str == ',') return str + 1;
    gps_info->UTC.tm_hour = str[0] * 10 + str[1] - 11 * '0';
    gps_info->UTC.tm_min  = str[2] * 10 + str[3] - 11 * '0';
    gps_info->UTC.tm_sec  = str[4] * 10 + str[5] - 11 * '0';
    while (*str++ != ',');  // skip fraction of sec (if available)
    return str;
}


static char *decode_date(gps_simcom_info_t *gps_info, char *str)
{
    assert(gps_info);
    assert(str);

    if (*str == ',') return str + 1;
    gps_info->UTC.tm_mday = str[0] * 10 + str[1] - 11 * '0';
    gps_info->UTC.tm_mon  = str[2] * 10 + str[3] - 11 * '0' - 1;     // GPS date: month = 1-12; struct tm: month is 0-11
    gps_info->UTC.tm_year = str[4] * 10 + str[5] - 11 * '0' + 100;  // we live in the 21 century
    mktime(&gps_info->UTC);
    return str + 7;
}


static char *decode_lat(gps_simcom_info_t *gps_info, char *str)
{
    int degr;
    double min;

    assert(gps_info);
    assert(str);

    if (*str == ',') return str + 2;
    degr = str[0] * 10 + str[1] - 11 * '0';
    min = strtod(str + 2, &str);
    gps_info->latitude = str[1] == 'S' ? min / -60.0 - degr : min / 60.0 + degr;
    return str + 3;
}


static char *decode_lon(gps_simcom_info_t *gps_info, char *str)
{
    int degr;
    double min;

    assert(gps_info);
    assert(str);

    if (*str == ',') return str + 2;
    degr = str[0] * 100 + str[1] * 10 + str[2] - 111 * '0';
    min = strtod(str + 3, &str);
    gps_info->longitude = str[1] == 'W' ? min / -60.0 - degr : min / 60.0 + degr;
    return str + 3;
}

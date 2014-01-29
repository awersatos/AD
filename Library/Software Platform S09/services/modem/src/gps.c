/*******************************************************************************
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  IN PACKAGE:         MODEM Communication
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

#include <string.h>
#include <stdlib.h>
#include <time.h>
#include <modem.h>

static char *decode_time(modem_gps_info_t *gps_info, char *str);
static char *decode_date(modem_gps_info_t *gps_info, char *str);
static char *decode_lat(modem_gps_info_t *gps_info, char *str);
static char *decode_lon(modem_gps_info_t *gps_info, char *str);

/**
 * @brief Start the GPS receiver
 * 
 * This function starts the GPS receiver.
 * Start with a cold start, hot start of automatically chosen.
 *
 * @param modem     pointer to modem device struct
 * @param mode      Start mode, 0 = auto, 1 = cold, 2 = hot
 *
 * @return 1 on success, 0 on error.
 */
int modem_gps_start(modem_t *modem, int mode)
{
    switch (mode)
    {
    case 1:
        return modem_cmd(modem, "AT+CGPSCOLD", NULL);
    case 2:
        return modem_cmd(modem, "AT+CGPSHOT", NULL);
    default:
        return modem_cmd(modem, "AT+CGPS=1", NULL);
    }
}

/**
 * @brief Sop the GPS receiver
 * 
 * This function stops the GPS receiver.
 *
 * @param modem     pointer to modem device struct
 *
 * @return 1 on success, 0 on error.
 */
int modem_gps_stop(modem_t *modem)
{
    return modem_cmd(modem, "AT+CGPS=0", NULL);
}

/**
 * @brief Get GPS information
 *
 * Get a received message and return the message location from the first message
 * found. the SMS message itself is returned in message.
 *
 * @param modem       pointer to modem device struct
 * @param info        pointer to info structure which will be filled with current gps info
 *
 * @return 1 on success, 0 on error.
 */
int modem_get_gps_info(modem_t *modem, modem_gps_info_t *info)
{
    char str[100];
    char *cp;

    if (modem_cmd(modem, "AT+CGPSINFO", str))
    {
        cp = strchr(str, ':');
        if (cp)
        {
            cp = decode_lat(info, cp + 1);
            cp = decode_lon(info, cp);
            cp = decode_date(info, cp);
            cp = decode_time(info, cp);
            info->altitude = strtod(cp, &cp);
            cp++;
            info->speed = strtod(cp, &cp);
            return 1;
        }
    }
    return 0;
}


static char *decode_time(modem_gps_info_t *gps_info, char *str)
{
    if (*str == ',') return str + 1;
    gps_info->UTC.tm_hour = str[0] * 10 + str[1] - 11 * '0';
    gps_info->UTC.tm_min = str[2] * 10 + str[3] - 11 * '0';
    gps_info->UTC.tm_sec = str[4] * 10 + str[5] - 11 * '0';
    while (*str++ != ',');  // skip fraction of sec (if available)
    return str;
}


static char *decode_date(modem_gps_info_t *gps_info, char *str)
{
    if (*str == ',') return str + 1;
    gps_info->UTC.tm_mday = str[0] * 10 + str[1] - 11 * '0';
    gps_info->UTC.tm_mon = str[2] * 10 + str[3] - 11 * '0' - 1;     // GPS date: month = 1-12; struct tm: month is 0-11
    gps_info->UTC.tm_year = str[4] * 10 + str[5] - 11 * '0' + 100;  // we live in the 21 century
    mktime(&gps_info->UTC);
    return str + 7;
}


static char *decode_lat(modem_gps_info_t *gps_info, char *str)
{
    int degr;
    double min;

    if (*str == ',') return str + 2;
    degr = str[0] * 10 + str[1] - 11 * '0';
    min = strtod(str + 2, &str);
    gps_info->latitude = str[1] == 'S' ? min / -60.0 - degr : min / 60.0 + degr;
    return str + 3;
}


static char *decode_lon(modem_gps_info_t *gps_info, char *str)
{
    int degr;
    double min;

    if (*str == ',') return str + 2;
    degr = str[0] * 100 + str[1] * 10 + str[2] - 111 * '0';
    min = strtod(str + 3, &str);
    gps_info->longitude = str[1] == 'W' ? min / -60.0 - degr : min / 60.0 + degr;
    return str + 3;
}

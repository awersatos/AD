/*************************************************************************
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  IN PACKAGE:         MODEM Communication
|*
|*  COPYRIGHT:          Copyright (c) 2007, Altium
|*
|*  DESCRIPTION:        Generic AT commands to access and handle the GSM network
|*
 */
#include <timing.h>
#if ( __POSIX_KERNEL__ != 0 )
# include <pthread.h>
#else
#include <time.h>
#endif

#include <string.h>
#include <modem.h>
/**
 * @brief Enter PIN code (AT+CPIN)
 *
 * @param modem        pointer to modem device struct
 * @param pin_code     string containing the pincode
 *
 * @return   1 on success, 0 on error.
 */
int modem_enter_pin(modem_t *modem, const char *pin_code)
{
    char buf[MODEM_SMALL_MSG];
    int ret = 0;

    // check if PIN is needed
    if (modem_cmd(modem, "AT+CPIN?", buf))
    {
        if (strstr(buf, "+CPIN: SIM PIN") && pin_code)
        {
            strcpy(buf, "AT+CPIN=");
            strcat(buf, pin_code);
            // yes, we do need a PIN
            modem_cmd(modem, buf, NULL);
            // refresh CPIN query to check if we passed the pin...
            modem_cmd(modem, "AT+CPIN?", buf);
        }
        if (strstr(buf, "+CPIN: READY"))
        {
            ret = 1;
        }
    }
    return ret;
}


/**
 * @brief Check mobile network registration (AT+CREG?)
 *
 * Checks if mobile is registered to the GSM-network (AT+CREG). Reply is like :
 * AT+CREG: <n>, <stat>[, ....] stat should be 1 or 5 (mobile registered)
 *
 * @param modem     pointer to modem device struct
 *
 * @return 1 on success, 0 on error.
 */
int modem_check_network(modem_t *modem)
{
    int i = 0;
    int ret = 0;
    char rsp[MODEM_SMALL_MSG];
    char *rspptr = rsp;

    // check if registration to GSM network is ok
    modem_cmd(modem, "AT+CREG?", rsp);
    // get the <stat> parameter from the response
    if (strstr(rsp, "+CREG:") != NULL)
    {
        if (modem_get_token(&rspptr, 1) && ((rspptr[0] == '1') || (rspptr[0] == '5')))
        {
            ret = 1;
        }
    }
    return ret;
}


/**
 * @brief Get the signal quality (AT+CSQ) and convert value on a scale 0-5
 *
 * @param modem     pointer to modem device struct
 *
 * @return signal quality (0 = very bad, 5 = very good)
 */
int modem_signal_quality(modem_t *modem)
{
    int ret = 0;
    int i, level;
    char rsp[MODEM_SMALL_MSG];
    char *rspptr = rsp;

    // check GSM reception level
    modem_cmd(modem, "AT+CSQ", rsp);
    if (strstr(rsp, "+CSQ:") != NULL)
    {
        i = modem_get_token(&rspptr, 0);
        if (i)
        {
            rspptr[i] = 0;
            level = atoi(rspptr);
            ret = 0;                 // -113 dBm or less
            if (level > 0 ) ret = 1; // -111 dBm
            if (level > 1 ) ret = 2; //  -109
            if (level > 20) ret = 3; //      ...
            if (level > 27) ret = 4; //         -53 dBm
            if (level > 30) ret = 5; // -51 dBm or more
            if (level > 31) ret = 0; // level unknown
        }
    }
    return ret;
}

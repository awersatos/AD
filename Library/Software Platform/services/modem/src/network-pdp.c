/*************************************************************************
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  IN PACKAGE:         MODEM Communication
|*
|*  COPYRIGHT:          Copyright (c) 2010, Altium
|*
|*  DESCRIPTION:        At Commands to handle GSM data transmissions (GPRS, EDGE, HPSDA, etc.)
|*
 */
#include <string.h>
#include <stdio.h>

#include "modem_i.h"

/**
 * @brief Define IP type Packet Data Protocol Context (AT+CGDCONT)
 *
 * Define Packet Data Protocol (PDP) context (IP type) identified by the
 * numeric parameter cid. use this cid also in other
 * commands to refer to this now defined pdp context.
 *
 * @param modem   pointer to modem device struct
 * @param cid     PDP context identifier eg. 1
 * @param apn     access point name eg. "internet"
 *
 * @return 1 on success, 0 on error.
 */
extern int modem_define_pdp(modem_t *modem, int cid, const char *apn)
{
    char buf[MODEM_SMALL_MSG];

    snprintf(buf,MODEM_SMALL_MSG,"AT+CGACT=0,%u",cid);
    modem_cmd(modem, buf);
    snprintf(buf,MODEM_SMALL_MSG,"AT+CGDCONT=%u,\"IP\",\"%s\"",cid,apn);
    return modem_cmd(modem, buf);

}

/**
 * @brief Initiate GPRS connection with a defined
 * Packet Data Protocol (PDP) context (ATD*99***x#)
 *
 * @param modem   pointer to modem device struct
 * @param cid     PDP context identifier eg. 1 that
 *                has previously been defined with modem_define_pdp()
 *
 * @return 1 on success, 0 on error.
 */
extern int modem_connect_pdp(modem_t *modem, int cid)
{
    char number[MODEM_SMALL_MSG];
    int result = 0;

    snprintf(number,MODEM_SMALL_MSG,"*99***%u#",cid);
    result = modem_dial(modem, number);

    if (result) modem->mode = MODEM_DATA;

    return result;
}



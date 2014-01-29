/*************************************************************************
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  IN PACKAGE:         MODEM Communication
|*
|*  COPYRIGHT:          Copyright (c) 2007, Altium
|*
|*  DESCRIPTION:        At Commands to handle GSM data transmissions (GPRS, EDGE, HPSDA, etc.)
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
 * @brief Define IP type PDP Context (AT+CGDCONT)
 *
 * Define PDP context (IP type) identified by the 
 * numeric parameter cid. use this cid also in other
 * commands to refer to this now defined pdp context.
 *
 * @param *modem  pointer to modem device struct
 * @param cid     PDP context identifier eg. 1
 * @param apn     access point name eg. "internet"
 *
 * @return 1 on success, 0 on error.
 */
int modem_define_pdp(modem_t *modem, int cid, const char *apn)
{
    char buf[MODEM_SMALL_MSG] = "AT+CGDCONT=";

    modem_itoa(cid, buf + 11);
    strcat (buf, ",\"IP\",");
    strcat (buf, apn);
    return modem_cmd(modem, buf, NULL);
}

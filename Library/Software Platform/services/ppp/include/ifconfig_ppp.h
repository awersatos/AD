/*************************************************************************
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*
|*  IN PACKAGE:         PPP Interface Config
|*
|*  COPYRIGHT:          Copyright (c) 2010, Altium
|*
|*  DESCRIPTION:        Configure a PPP-based network interface
|*
 */
#ifndef IFCONFIG_PPP_H
#define IFCONFIG_PPP_H

#include "ppp_api.h"

extern int ifconfig_ppp_set_credentials       (ppp_t * ppp, const char * username, const char * password);
extern int ifconfig_ppp_set_access_point      (ppp_t * ppp, const char * access_point_name);
extern int ifconfig_ppp_set_retry_count       (ppp_t * ppp, uint8_t retries);

#endif // IFCONFIG_PPP_H

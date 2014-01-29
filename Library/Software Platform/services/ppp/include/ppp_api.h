/*************************************************************************
|*
|*  VERSION CONTROL:    $Version$   $25/09/2009$
|*
|*  COPYRIGHT:          Copyright (c) 2009, Altium
|*
 */

/**
 * @file
 * LWIP PPP service
 *
 * Further documentation on LWIP can be found at
 * http://savannah.nongnu.org/projects/lwip/
 */

#ifndef PPP_H_
#define PPP_H_

#include <stdint.h>
#include <stdbool.h>

typedef struct ppp_s ppp_t;

#include "ifconfig_ppp.h"

extern ppp_t           * ppp_open                  (unsigned int id);
extern int               ppp_start                 (ppp_t * instance);
extern int               ppp_stop                  (ppp_t * instance);

extern struct ip_addr    ppp_get_local_addr        (ppp_t * instance);
extern struct ip_addr    ppp_get_remote_addr       (ppp_t * instance);
extern struct ip_addr    ppp_get_primary_dns_addr  (ppp_t * instance);
extern struct ip_addr    ppp_get_secondary_dns_addr(ppp_t * instance);
extern int               ppp_set_default           (ppp_t * ppp, bool is_default);

#endif /* PPP_H_ */

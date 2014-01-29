/*************************************************************************
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  IN PACKAGE:         TCP/IP Plugin
|*
|*  COPYRIGHT:          Copyright (c) 2009, Altium
|*
|*  DESCRIPTION:        Plugin providing TCP/IP communication using the Light Weight IP (LWIP) package
|*
 */

#ifndef _LWIP_I_H
#define _LWIP_I_H

#include "lwip.h"

#include "netif_impl.h"


extern void lwip_init_plugin();
extern void lwip_set_netif(unsigned int id, netif_impl_t * netif);

#endif /* _LWIP_I_H*/

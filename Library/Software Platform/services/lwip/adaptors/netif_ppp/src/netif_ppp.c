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
#include <string.h>
#include <assert.h>

#include "lwip_cfg_instance.h"
#include "ppp_cfg_instance.h"
#include "netif_ppp_cfg_instance.h"

#include <netif_impl.h>
#include <ppp_api.h>
#include <lwip_i.h>


static void             * netif_ppp_open                  (unsigned int id)
{
    return ppp_open(id);
}

static int                netif_ppp_start                 (void * instance)
{
    return ppp_start((ppp_t *) instance);
}

static int                netif_ppp_stop                  (void * instance)
{
    return ppp_stop((ppp_t *) instance);
}
static int                netif_ppp_set_default           (void * instance, bool is_default)
{
    return ppp_set_default((ppp_t *) instance,is_default);
}

static struct ip_addr     netif_ppp_get_local_addr        (void * instance)
{
    return ppp_get_local_addr( (ppp_t *) instance);
}
static struct ip_addr     netif_ppp_get_remote_addr       (void * instance)
{
    return ppp_get_remote_addr( (ppp_t *) instance);
}
static struct ip_addr     netif_ppp_get_primary_dns_addr  (void * instance)
{
    return ppp_get_primary_dns_addr( (ppp_t *) instance);
}
static struct ip_addr     netif_ppp_get_secondary_dns_addr(void * instance)
{
    return ppp_get_secondary_dns_addr( (ppp_t *) instance);
}


void netif_ppp_init_adaptor()
{
    int netif_id;

    for (netif_id=0;netif_id<NETIF_PPP_INSTANCE_COUNT;netif_id++)
    {
        int lwip_id = netif_ppp_instance_table[netif_id].netif;
        netif_impl_t * netif = netif_impl_init(lwip_id,netif_id,
                                   &netif_ppp_open,
                                   &netif_ppp_start,
                                   &netif_ppp_stop,
                                   &netif_ppp_get_local_addr,
                                   &netif_ppp_get_remote_addr,
                                   NULL,
                                   NULL,
                                   &netif_ppp_get_primary_dns_addr,
                                   &netif_ppp_get_secondary_dns_addr,
                                   &netif_ppp_set_default,
                                   NULL);

        assert(lwip_id  >= 0 && lwip_id  < LWIP_INSTANCE_COUNT);
        assert (netif);

        lwip_set_netif(lwip_id,netif);
    }
}

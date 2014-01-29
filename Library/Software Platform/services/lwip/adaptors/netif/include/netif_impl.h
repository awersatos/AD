/*************************************************************************
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  IN PACKAGE:         TCP/IP Plugin
|*
|*  COPYRIGHT:          Copyright (c) 2009, Altium
|*
|*  DESCRIPTION:        Part of LWIP. Implements the generic netif adaptor interface.
|*                      Internal interface to be used by netif adaptors and LWIP only.
|*
 */

#ifndef __NETIF_IMPL_H__
#define __NETIF_IMPL_H__

#include <stdint.h>
#include <stdbool.h>

#ifdef  __cplusplus
extern "C" {
#endif


#include "lwip/err.h"
#include "lwip/ip_addr.h"

#define NETIF_IMPL_SIGNATURE 0x56787654

typedef void             * netif_open_fn                  (unsigned int id);
typedef int                netif_start_fn                 (void * instance);
typedef int                netif_stop_fn                  (void * instance);
typedef int                netif_set_default_fn           (void * instance, bool is_default);

typedef struct ip_addr     netif_get_local_addr_fn        (void * instance);
typedef struct ip_addr     netif_get_remote_addr_fn       (void * instance);
typedef struct ip_addr     netif_get_netmask_fn           (void * instance);
typedef struct ip_addr     netif_get_gateway_addr_fn      (void * instance);
typedef struct ip_addr     netif_get_primary_dns_addr_fn  (void * instance);
typedef struct ip_addr     netif_get_secondary_dns_addr_fn(void * instance);

typedef int                netif_set_link_callback_fn     (void * instance, void (* link_callback)(void * lwip), void * context);

typedef struct netif_impl  netif_impl_t;

netif_impl_t * netif_impl_init(unsigned int lwip_id, unsigned int netif_id,
                               netif_open_fn                    * open_fn,
                               netif_start_fn                   * start_fn,
                               netif_stop_fn                    * stop_fn,
                               netif_get_local_addr_fn          * get_local_addr_fn,
                               netif_get_remote_addr_fn         * get_remote_addr_fn,
                               netif_get_netmask_fn             * get_netmask_fn,
                               netif_get_gateway_addr_fn        * get_gateway_addr_fn,
                               netif_get_primary_dns_addr_fn    * get_primary_dns_addr_fn,
                               netif_get_secondary_dns_addr_fn  * get_secondary_dns_addr_fn,
                               netif_set_default_fn             * set_default_fn,
                               netif_set_link_callback_fn       * set_link_callback_fn);

extern err_t              netif_impl_open                   (netif_impl_t * impl);
extern err_t              netif_impl_start                  (netif_impl_t * impl);
extern err_t              netif_impl_stop                   (netif_impl_t * impl);
extern err_t              netif_impl_set_default            (netif_impl_t * impl, bool is_default);
extern struct ip_addr     netif_impl_get_local_addr         (netif_impl_t * impl);
extern struct ip_addr     netif_impl_get_remote_addr        (netif_impl_t * impl);
extern struct ip_addr     netif_impl_get_netmask            (netif_impl_t * impl);
extern struct ip_addr     netif_impl_get_gateway_addr       (netif_impl_t * impl);
extern struct ip_addr     netif_impl_get_primary_dns_addr   (netif_impl_t * impl);
extern struct ip_addr     netif_impl_get_secondary_dns_addr (netif_impl_t * impl);
extern err_t              netif_impl_set_link_callback      (netif_impl_t * impl, void (* link_callback)(void * lwip), void * context);

#ifdef  __cplusplus
}
#endif

#endif

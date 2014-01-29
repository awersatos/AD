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

#include <assert.h>
#include <string.h>

#include <lwip_i.h>
#include <lwip/netif.h>
#include "lwip_cfg.h"

struct netif_impl
{
    uint32_t                           signature;
    unsigned int                       id;          // adaptor id
    void                             * instance;    // return value from open()
    netif_open_fn                    * open_fn;
    netif_start_fn                   * start_fn;
    netif_stop_fn                    * stop_fn;
    netif_get_local_addr_fn          * get_local_addr_fn;
    netif_get_remote_addr_fn         * get_remote_addr_fn;
    netif_get_netmask_fn             * get_netmask_fn;
    netif_get_gateway_addr_fn        * get_gateway_addr_fn;
    netif_get_primary_dns_addr_fn    * get_primary_dns_addr_fn;
    netif_get_secondary_dns_addr_fn  * get_secondary_dns_addr_fn;
    netif_set_default_fn             * set_default_fn;
    netif_set_link_callback_fn       * set_link_callback_fn;
};

netif_impl_t netif_impl_table[LWIP_INSTANCE_COUNT];

/** @brief Internal function which calls open on the actual adaptor instance.
 *
 * @param  impl     a pointer to a netif_impl instance previously
 *                  returned by netif_impl_init.
 * @return ERR_RST  if the adaptor instance did not provide an open routine
 *         ERR_CLSD if the adaptor open call failed, OR
 *         ERR_OK   otherwise.
 */
err_t netif_impl_open(netif_impl_t * impl)
{
    assert(impl);

    if (impl->signature != NETIF_IMPL_SIGNATURE)
        return ERR_ARG;
    if (!impl->open_fn)
        return ERR_RST;

    impl->instance = impl->open_fn(impl->id);
    if (!impl->instance)
        return ERR_CLSD;

    return ERR_OK;
}

/** @brief Internal function which calls set_default on the actual adaptor instance.
 *
 * @param  impl     a pointer to a netif_impl instance previously
 *                  returned by netif_impl_init.
 * @return ERR_RST  if the adaptor instance did not provide a set_default routine
 *         Other interface-specific error codes, OR
 *         ERR_OK   otherwise.
 */
err_t netif_impl_set_default(netif_impl_t * impl, bool is_default)
{
    assert(impl);

    if (impl->signature != NETIF_IMPL_SIGNATURE)
        return ERR_ARG;
    if (!impl->set_default_fn)
        return ERR_RST;
    if (!impl->instance)
        return ERR_CLSD;

    return (err_t)impl->set_default_fn(impl->instance, is_default);
}

/** @brief Internal function which calls open on the actual adaptor instance.
 *
 * @param  impl     a pointer to a netif_impl instance previously
 *                  returned by netif_impl_init.
 * @return ERR_RST  if the adaptor instance did not provide a start routine
 *         ERR_CLSD if the adaptor open call failed, OR
 *         Other interface-specific error codes, OR
 *         ERR_OK   otherwise.
 */
err_t netif_impl_start(netif_impl_t * impl)
{
    assert(impl);

    if (impl->signature != NETIF_IMPL_SIGNATURE)
        return ERR_ARG;
    if (!impl->start_fn)
        return ERR_RST;
    if (!impl->instance)
        return ERR_CLSD;
    return (err_t)impl->start_fn(impl->instance);
}

/** @brief Internal function which calls stop on the actual adaptor instance.
 *
 * @param  impl     a pointer to a netif_impl instance previously
 *                  returned by netif_impl_init.
 */
err_t netif_impl_stop(netif_impl_t * impl)
{
    assert(impl);

    if (impl->signature != NETIF_IMPL_SIGNATURE)
        return ERR_ARG;
    if (!impl->stop_fn)
        return ERR_RST;

    return impl->stop_fn(impl->instance);
}

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
                               netif_set_link_callback_fn       * set_link_callback_fn)
{
    netif_impl_t * impl;
    assert(lwip_id  < LWIP_INSTANCE_COUNT);

    impl = &netif_impl_table[lwip_id];
    memset(impl,0,sizeof(netif_impl_t));
    impl->id                        = netif_id;
    impl->open_fn                   = open_fn;
    impl->start_fn                  = start_fn;
    impl->stop_fn                   = stop_fn;
    impl->set_default_fn            = set_default_fn;
    impl->get_local_addr_fn         = get_local_addr_fn;
    impl->get_remote_addr_fn        = get_remote_addr_fn;
    impl->get_netmask_fn            = get_netmask_fn;
    impl->get_gateway_addr_fn       = get_gateway_addr_fn;
    impl->get_primary_dns_addr_fn   = get_primary_dns_addr_fn;
    impl->get_secondary_dns_addr_fn = get_secondary_dns_addr_fn;
    impl->set_link_callback_fn      = set_link_callback_fn;
    impl->signature                 = NETIF_IMPL_SIGNATURE;
    return impl;
}

struct ip_addr netif_impl_get_local_addr(netif_impl_t * impl)
{
    assert(impl);
    if (impl->get_local_addr_fn)
        return impl->get_local_addr_fn(impl->instance);
    else
        return *IP_ADDR_ANY;
}

struct ip_addr netif_impl_get_remote_addr(netif_impl_t * impl)
{
    assert(impl);
    if (impl->get_remote_addr_fn)
        return impl->get_remote_addr_fn(impl->instance);
    else
        return *IP_ADDR_ANY;
}

struct ip_addr netif_impl_get_netmask(netif_impl_t * impl)
{
    assert(impl);
    if (impl->get_netmask_fn)
        return impl->get_netmask_fn(impl->instance);
    else
        return *IP_ADDR_ANY;
}

struct ip_addr netif_impl_get_gateway_addr(netif_impl_t * impl)
{
    assert(impl);
    if (impl->get_gateway_addr_fn)
        return impl->get_gateway_addr_fn(impl->instance);
    else
        return *IP_ADDR_ANY;
}

struct ip_addr netif_impl_get_primary_dns_addr(netif_impl_t * impl)
{
    assert(impl);
    if (impl->get_primary_dns_addr_fn)
        return impl->get_primary_dns_addr_fn(impl->instance);
    else
        return *IP_ADDR_ANY;
}

struct ip_addr netif_impl_get_secondary_dns_addr(netif_impl_t * impl)
{
    assert(impl);
    if (impl->get_secondary_dns_addr_fn)
        return impl->get_secondary_dns_addr_fn(impl->instance);
    else
        return *IP_ADDR_ANY;
}

err_t netif_impl_set_link_callback(netif_impl_t * impl, void (* link_callback)(void * lwip), void * context)
{
    assert(impl);
    if (impl->set_link_callback_fn)
        return impl->set_link_callback_fn(impl->instance, link_callback, context);
    else
        return ERR_ARG;

}


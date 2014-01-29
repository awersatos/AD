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

#include <assert.h>
#include <stdint.h>
#include <string.h>
#include <stdbool.h>
#include <stdio.h>

#include <pthread.h>
#include <init.h>

#define LWIP_DEBUG   // so it will print ip addrs
#define LWIP_DBG_ALL 0x83U

#include "lwip_cfg_instance.h"

#include "lwip_i.h"
#include "lwip/sys.h"
#include "lwip/tcpip.h"
#include "lwip/netif.h"

#include "netif_impl.h"

#define LWIP_SIGNATURE 0x249294ca
struct _lwip {
    uint32_t       signature;
    netif_impl_t * netif;
    bool           is_default;
};

static lwip_t lwip_table[LWIP_INSTANCE_COUNT];

static bool lwip_is_initialized = false;
static sys_sem_t init_sem;


static void lwip_open_done(void *arg)
{
    sys_sem_signal(&init_sem);
}

void lwip_init_mainhook(void)
{
    lwip_is_initialized = true;
    sys_sem_new(&init_sem, 0);
    tcpip_init(lwip_open_done, init_sem);
}

void lwip_init_plugin(void)
{
    posix_mainhook_install(lwip_init_mainhook, 1);
}

/**
 * @brief Initialize network device and LWIP services.
 *
 * This function initializes the associated network device and starts the TCP/IP service.
 * The device still needs to be activated by calling lwip_start().
 *
 * @param  id      the identification number of the LWIP instance to open (see devices.h)
 * @return A pointer to the LWIP instance if successful, or NULL otherwise.
 */
lwip_t * lwip_open(unsigned int id)
{
    lwip_t * lwip;
    err_t result;

    assert(id < LWIP_INSTANCE_COUNT);

    sys_sem_wait(&init_sem);

    lwip = &lwip_table[id];
    // this should have been initialized by the adaptor
    if (!lwip->netif)
        return NULL;

    if (lwip->signature != LWIP_SIGNATURE)
    {
        result = netif_impl_open(lwip->netif);
        if (result!=ERR_OK)
            return NULL;

#if LWIP_INSTANCE_COUNT == 1
        lwip->is_default = true;
#else
        lwip->is_default = (&lwip_instance_table[id] == LWIP_DEFAULT_INTERFACE);
#endif
        lwip->signature = LWIP_SIGNATURE;
    }
    return lwip;
}

/**
 * @brief Activate the associated network device
 *
 * This function activates the associated network device and makes it the
 * default adaptor for LWIP services.
 *
 * @param  lwip       a pointer to a lwip_t instance returned by lwip_open()
 * @return ERR_OK if the function was successful, ERR_RST if lwip_open() has
 *         not been called or ERR_CLSD if the previous call to lwip_open() was
 *         unsuccessful.
 */
int lwip_start(lwip_t * lwip)
{
    err_t result;
    assert(lwip);

    if (lwip->signature != LWIP_SIGNATURE)
        return ERR_ARG;
    if (!lwip_is_initialized)
        return ERR_RST;
    if (!lwip->netif)
        return ERR_CLSD;
    result = netif_impl_start(lwip->netif);
    if (result!=ERR_OK)
        return result;
    result = netif_impl_set_default(lwip->netif,true);

    return result;
}

/** @brief Sets the provided netif_impl adaptor to be
 *         the active adaptor for the specified LWIP instance id
 *
 * @param  id         the id of the LWIP instance on which to
 *                    set the netif.
 * @param  instance   a pointer to a netif_impl instance
 *                    which was previously returned by
 *                    netif_impl_init.
 */
void lwip_set_netif(unsigned int id, netif_impl_t * netif)
{
    assert(id < LWIP_INSTANCE_COUNT);

    lwip_table[id].netif = netif;
}

/** @brief Set a callback function for link status notification
 *
 * @param  id               the id of the LWIP instance on which to
 *                          set the netif.
 * @param  link_callback    function pointer
 */
void lwip_set_netif_callback(lwip_t * lwip, void (* link_callback)(lwip_t * lwip))
{
    assert(lwip);
    netif_impl_set_link_callback(lwip->netif, (void *)link_callback, lwip);
}

/** @brief Get the local IP address that is associated with the adaptor
 *         attached to the lower interface of the provided LWIP
 *         instance.
 *
 * @param  instance    a pointer to a lwip_t instance
 *                     which was previously returned by
 *                     lwip_open
 * @return IP_ADDR_ANY if the address is not found, OR
 *         a valid IP address.
 */
extern struct ip_addr     lwip_get_local_addr         (lwip_t * lwip)
{
    assert(lwip);
    if (lwip->signature != LWIP_SIGNATURE)
        return ip_addr_any;
    if (!lwip->netif)
        return ip_addr_any;

    return netif_impl_get_local_addr(lwip->netif);
}

/** @brief Get the remote IP address that is associated with the adaptor
 *         attached to the lower interface of the provided LWIP
 *         instance.
 *
 * @param  instance    a pointer to a lwip_t instance
 *                     which was previously returned by
 *                     lwip_open
 * @return IP_ADDR_ANY if the address is not found, OR
 *         a valid IP address.
 */
extern struct ip_addr     lwip_get_remote_addr        (lwip_t * lwip)
{
    assert(lwip);
    if (lwip->signature != LWIP_SIGNATURE)
        return ip_addr_any;
    if (!lwip->netif)
        return ip_addr_any;

    return netif_impl_get_remote_addr(lwip->netif);
}

/** @brief Get the Network mask that is associated with the adaptor
 *         attached to the lower interface of the provided LWIP
 *         instance.
 *
 * @param  instance    a pointer to a lwip_t instance
 *                     which was previously returned by
 *                     lwip_open
 * @return IP_ADDR_ANY if the address is not found, OR
 *         a valid IP address.
 */
extern struct ip_addr     lwip_get_netmask            (lwip_t * lwip)
{
    assert(lwip);
    if (lwip->signature != LWIP_SIGNATURE)
        return ip_addr_any;
    if (!lwip->netif)
        return ip_addr_any;

    return netif_impl_get_netmask(lwip->netif);
}

/** @brief Get the gateway IP address that is associated with the adaptor
 *         attached to the lower interface of the provided LWIP
 *         instance.
 *
 * @param  instance    a pointer to a lwip_t instance
 *                     which was previously returned by
 *                     lwip_open
 * @return IP_ADDR_ANY if the address is not found, OR
 *         a valid IP address.
 */
extern struct ip_addr     lwip_get_gateway_addr       (lwip_t * lwip)
{
    assert(lwip);
    if (lwip->signature != LWIP_SIGNATURE)
        return ip_addr_any;
    if (!lwip->netif)
        return ip_addr_any;

    return netif_impl_get_gateway_addr(lwip->netif);
}

/** @brief Get the primary DNS address that is associated with the adaptor
 *         attached to the lower interface of the provided LWIP
 *         instance.
 *
 * @param  instance    a pointer to a lwip_t instance
 *                     which was previously returned by
 *                     lwip_open
 * @return IP_ADDR_ANY if the address is not found, OR
 *         a valid IP address.
 */
extern struct ip_addr     lwip_get_primary_dns_addr   (lwip_t * lwip)
{
    assert(lwip);
    if (lwip->signature != LWIP_SIGNATURE)
        return ip_addr_any;
    if (!lwip->netif)
        return ip_addr_any;

    return netif_impl_get_primary_dns_addr(lwip->netif);
}

/** @brief Get the secondary DNS address that is associated with the adaptor
 *         attached to the lower interface of the provided LWIP
 *         instance.
 *
 * @param  instance    a pointer to a lwip_t instance
 *                     which was previously returned by
 *                     lwip_open
 * @return IP_ADDR_ANY if the address is not found, OR
 *         a valid IP address.
 */
extern struct ip_addr     lwip_get_secondary_dns_addr (lwip_t * lwip)
{
    assert(lwip);
    if (lwip->signature != LWIP_SIGNATURE)
        return ip_addr_any;
    if (!lwip->netif)
        return ip_addr_any;

    return netif_impl_get_secondary_dns_addr(lwip->netif);
}


/** @brief Print the IP addresses that are associated with
 *         the provided LWIP instance.
 *
 * @param  instance    a pointer to a lwip_t instance
 *                     which was previously returned by
 *                     lwip_open
 */
void lwip_print_addrs(lwip_t * lwip)
{
    struct ip_addr addr;
    assert(lwip);
#if LWIP_NETIF_HOSTNAME
//    printf("hostname= %s\n",lwip->netif->instance->hostname);
#endif
    printf("addr    = ");
    addr = lwip_get_local_addr(lwip);
    ip_addr_print(&addr);
    printf("\n");

    printf("gateway = ");
    addr = lwip_get_gateway_addr(lwip);
    ip_addr_print(&addr);
    printf("\n");

    printf("netmask = ");
    addr = lwip_get_netmask(lwip);
    ip_addr_print(&addr);
    printf("\n");
#if LWIP_DNS == 1
    printf("pri dns = ");
    addr = lwip_get_primary_dns_addr(lwip);
    ip_addr_print(&addr);
    printf("\n");
    printf("sec dns = ");
    addr = lwip_get_secondary_dns_addr(lwip);
    ip_addr_print(&addr);
    printf("\n");
#endif
}

extern int lwip_stop(lwip_t * lwip)
{
    if (!lwip->signature != LWIP_SIGNATURE)
        return ERR_ARG;
    if (!lwip->netif)
        return ERR_RST;
    return netif_impl_stop(lwip->netif);
}

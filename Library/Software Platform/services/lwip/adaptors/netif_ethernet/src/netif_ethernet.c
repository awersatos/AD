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


#include <pthread.h>
#include <ethernet.h>
#include <string.h>
#include <assert.h>

#include <swp_ifconfig.h>

#include "lwip_cfg_instance.h"

#include "lwip_i.h"
#include "lwip/opt.h"
#include "lwip/def.h"
#include "lwip/mem.h"
#include "lwip/pbuf.h"
#include "lwip/sys.h"
#include "lwip/stats.h"
#include "lwip/snmp.h"
#include "lwip/tcpip.h"
#include "lwip/dns.h"
#include "lwip/dhcp.h"
#include "lwip/netif.h"

#include "netif/etharp.h"
#include "netif/ppp_oe.h"




#define NETIF_ETHERNET_SIGNATURE 0x00EEE000

typedef struct lwip_ethernet_s {
    int signature;

    struct netif netif;
    ethernet_t* ethernet;
#if !LWIP_DHCP
    struct ip_addr ip_address;
    struct ip_addr netmask;
    struct ip_addr gateway;
#endif
#if LWIP_DNS && !LWIP_DHCP
    struct ip_addr primary_dns;
    struct ip_addr secondary_dns;
#endif
} netif_ethernet_t;

static netif_ethernet_t netif_ethernet_table[NETIF_ETHERNET_INSTANCE_COUNT];

/* Define those to better describe your network interface. */
#define EMAC32_IFNAME0 'e'
#define EMAC32_IFNAME1 'n'

/** This function does the actual transmission of the packet. The packet is
 * contained in the pbuf that is passed to the function. This pbuf
 * might be chained.  *
 * @param netif the lwip network interface structure for this ethernetif
 * @param p the MAC packet to send (e.g. IP packet including MAC addresses and type)
 * @return ERR_OK if the packet could be sent  *
 *         an err_t value if the packet couldn't be sent  *
 * @note Returning ERR_MEM here if a DMA queue of your MAC is full can lead to  *
 *    strange results. You might consider waiting for space in the DMA queue  *
 *        to become availale since the stack doesn't retry to send a packet  *
 *          dropped because of memory failure (except for the TCP timers).  */
static err_t low_level_output(struct netif *netif, struct pbuf *p) {
    ethernet_t *ethernet = (ethernet_t *) netif->state;
    uint32_t *ethernet_corebuf;
    struct pbuf *q;
    char *qdata;

#if ETH_PAD_SIZE
    pbuf_header(p, -ETH_PAD_SIZE); /* drop the padding word */
#endif

    do {
        ethernet_corebuf = ethernet_corebuf_alloc(ethernet, p->tot_len);
    } while (ethernet_corebuf == NULL);

    qdata = (char *) (ethernet_corebuf + 1);

    /* copy data from pbuf chain into the core */
    for (q = p; q != NULL; q = q->next) {
        memcpy(qdata, q->payload, q->len);
        qdata += q->len;
    }

    //    printf("send %08X %i\n", (int) ethernet_corebuf, *ethernet_corebuf);
    ethernet_corebuf_send(ethernet, ethernet_corebuf);

#if ETH_PAD_SIZE
    pbuf_header(p, ETH_PAD_SIZE); /* reclaim the padding word */
#endif

    LINK_STATS_INC(link.xmit);

    return ERR_OK;
}

/** Allocate a pbuf and transfer the bytes of the incoming
 * packet from the interface into the pbuf.  *
 * @param netif the lwip network interface structure for this ethernetif
 * @return a pbuf filled with the received packet (including MAC header)  *
 *          NULL if no packet received, or on memory error  */
static struct pbuf *low_level_input(struct netif *netif) {
    ethernet_t *ethernet = (ethernet_t *) netif->state;
    uint32_t *ethernet_corebuf;
    struct pbuf *p, *q;
    char *qdata;
    u16_t len;

    /* driver should be blocking and release CPU while waiting */
    ethernet_corebuf = ethernet_corebuf_receive(ethernet);

    if (ethernet_corebuf == NULL)
        return NULL;

    //    printf("recv %08X %i\n", (int) ethernet_corebuf, *ethernet_corebuf);

    len = (uint16_t) * ethernet_corebuf;

#if ETH_PAD_SIZE
    len += ETH_PAD_SIZE; /* allow room for Ethernet padding */
#endif

    /* We allocate a pbuf chain of pbufs from the pool. */
    p = pbuf_alloc(PBUF_RAW, len, PBUF_POOL);
    qdata = (char *) (ethernet_corebuf + 1);

    if (p != NULL) {

#if ETH_PAD_SIZE
        pbuf_header(p, -ETH_PAD_SIZE); /* drop the padding word */
#endif

        /* copy core data into pbuf chain */
        for (q = p; q != NULL; q = q->next) {
            memcpy(q->payload, qdata, q->len);
            qdata += q->len;
        }

#if ETH_PAD_SIZE
        pbuf_header(p, ETH_PAD_SIZE); /* reclaim the padding word */
#endif

        LINK_STATS_INC(link.recv);
    } else {
        /* out of memory, drop packet */
        LINK_STATS_INC(link.memerr); LINK_STATS_INC(link.drop);
    }

    ethernet_corebuf_free(ethernet, ethernet_corebuf);

    return p;
}

/** This function is called when a packet is ready to be read
 * from the interface. It uses the function low_level_input() that
 * should handle the actual reception of bytes from the network
 * interface. Then the type of the received packet is determined and
 * the appropriate input function is called.  *
 * @param netif the lwip network interface structure for this ethernetif  */
static void process_input(struct netif *netif, struct pbuf *p) {
    ethernet_t *ethernet = (ethernet_t *) netif->state;
    struct eth_hdr *ethhdr;

    /* no packet could be read, silently ignore this */
    if (p == NULL)
        return;

    /* points to packet payload, which starts with an Ethernet header */
    ethhdr = p->payload;

    switch (htons(ethhdr->type)) {
    /* IP or ARP packet? */
    case ETHTYPE_IP:
    case ETHTYPE_ARP:
#if PPPOE_SUPPORT
        /* PPPoE packet? */
        case ETHTYPE_PPPOEDISC:
        case ETHTYPE_PPPOE:
#endif
        /* PPPOE_SUPPORT */
        /* full packet send to tcpip_thread to process */
        if (netif->input(p, netif) != ERR_OK) {
            LWIP_DEBUGF(NETIF_DEBUG, ("ethernetif_input: IP input error\n"));
            pbuf_free(p);
            p = NULL;
        }
        break;

    default:
        pbuf_free(p);
        p = NULL;
        break;
    }
}

static void ethernetif_input_thread(void *arg) {
    struct netif *netif = (struct netif *) arg;
    struct pbuf *p;

    for (;;) {
        /* test for new packet, if received move into a new pbuf          */
        p = low_level_input(netif);

        if (p) {
            process_input(netif, p);
        } else {
            sched_yield();
        }
    }
}

/** In this function, the hardware should be initialized.
 * Called from ethernetif_init().  *
 * @param netif the already initialized lwip network interface structure  *
 *      for this ethernetif  */
static void low_level_init(struct netif *netif) {
    ethernet_t *ethernet = (ethernet_t *) netif->state;
    uint8_t mac[6];

    /* get MAC hardware address */
    ethernet_getmac(ethernet, mac);

    netif->hwaddr_len = 6;
    for (int i = 0; i < 6; ++i) {
        netif->hwaddr[i] = mac[i];
    }

    /* maximum transfer unit */
    netif->mtu = 1500;

    /* device capabilities */
    netif->flags = NETIF_FLAG_BROADCAST | NETIF_FLAG_ETHARP | NETIF_FLAG_LINK_UP;

    /* start input thread */
    sys_thread_new("ethernet_input", ethernetif_input_thread, netif, (15*1024), TCPIP_THREAD_PRIO);
}

/** @brief LWIP NETIF initialization function. This function should be
 *         passed as a parameter to netif_add().  *
 *
 * @param netif the lwip network interface structure for this ethernetif
 * @return ERR_OK  if the loopif is initialized  *
 *         ERR_MEM if private data couldn't be allocated  *
 *                 any other err_t on error
 */

err_t netif_ethernet_init(struct netif *netif) {
    ethernet_t *ethernet = (ethernet_t *) netif->state;

    LWIP_ASSERT("netif != NULL", (netif != NULL));

#if 0
    /* Initialize the snmp variables and counters inside the struct netif.
     * The last argument should be replaced with your link speed, in units
     * of bits per second.      */
    NETIF_INIT_SNMP(netif, snmp_ifType_ethernet_csmacd, ? ? ?);
#endif

    netif->name[0] = EMAC32_IFNAME0;
    netif->name[1] = EMAC32_IFNAME1;

    /* We directly use etharp_output() here to save a function call.
     * You can instead declare your own function an call etharp_output()
     * from it if you have to do some checks before sending (e.g. if link
     * is available...) */
    netif->output = etharp_output;
    netif->linkoutput = low_level_output;

    /* initialize the hardware */
    low_level_init(netif);

    return ERR_OK;
}

static void netif_ethernet_link_state_change(void *context, uint32_t state)
{
    struct netif * netif = context;

    if(state == IFCONFIG_LINK_S_UP){
        netif->flags |= NETIF_FLAG_UP;
        netif_set_link_up(netif);
    } else {
        netif->flags &= ~NETIF_FLAG_UP;
        netif_set_link_down(netif);
    }
}

/** @brief Open function which sets up the adaptor and calls open on the plugin
 *         attached to the lower interface.
 *
 * @param  id      the identification number of the netif_ethernet adaptor to open
 * @return NULL    if the adaptor failed to open, OR
 *         A pointer to the adaptor instance.
 */
static void * netif_ethernet_open(unsigned int id)
{
    const netif_ethernet_cfg_instance_t * restrict netif_cfg;
    netif_ethernet_t                    * restrict netif;
    const lwip_cfg_instance_t           * restrict lwip_cfg;

    assert(id < NETIF_ETHERNET_INSTANCE_COUNT);

    netif_cfg = &netif_ethernet_instance_table[id];
    netif     = &netif_ethernet_table[netif_cfg->ethernet];

    if (netif->ethernet == NULL)
    {
        lwip_cfg  = &lwip_instance_table[netif_cfg->netif];

        memset(netif,0,sizeof(netif_ethernet_t));

        netif->ethernet = ethernet_open(netif_cfg->ethernet);
        if (netif->ethernet != NULL)
        {
            netif->signature = NETIF_ETHERNET_SIGNATURE;
#if LWIP_NETIF_HOSTNAME
            netif->netif.hostname = lwip_cfg->hostname;
#endif

#if !LWIP_DHCP
            IP4_ADDR(&netif->ip_address, lwip_cfg->ipaddr[0], lwip_cfg->ipaddr[1],lwip_cfg->ipaddr[2], lwip_cfg->ipaddr[3]);
            IP4_ADDR(&netif->netmask, lwip_cfg->netmask[0], lwip_cfg->netmask[1], lwip_cfg->netmask[2], lwip_cfg->netmask[3]);
            IP4_ADDR(&netif->gateway, lwip_cfg->gw[0], lwip_cfg->gw[1], lwip_cfg->gw[2], lwip_cfg->gw[3]);
#endif

#if LWIP_DNS && !LWIP_DHCP
            IP4_ADDR(&netif->primary_dns, lwip_cfg->primary_dns[0], lwip_cfg->primary_dns[1],
                    lwip_cfg->primary_dns[2], lwip_cfg->primary_dns[3]);
            IP4_ADDR(&netif->secondary_dns, lwip_cfg->secondary_dns[0], lwip_cfg->secondary_dns[1],
                    lwip_cfg->secondary_dns[2], lwip_cfg->secondary_dns[3]);
 #endif

            ifconfig_link_set_state_callback(ifconfig_get_interface(netif->ethernet), netif_ethernet_link_state_change, &netif->netif);

        }
    }
    return netif->ethernet != NULL ? netif : NULL;
}

/** @brief Sets the provided netif_ethernet instance to be
 *         the default adaptor for LWIP
 *
 * @param  instance   a pointer to a netif_ethernet instance
 *                    which was previously returned by
 *                    netif_ethernet_open
 * @return ERR_ARG    if instance does not point to a valid
 *                    netif_ethernet instance.
 *         ERR_OK     if the function was successful.
 */
static int netif_ethernet_set_default(void * instance, bool is_default)
{
    netif_ethernet_t* netif_ethernet = (netif_ethernet_t *) instance;

    assert(netif_ethernet);

    if (netif_ethernet->signature != NETIF_ETHERNET_SIGNATURE)
        return ERR_ARG;
    if (!is_default)
        return ERR_OK;

    netif_set_default(&netif_ethernet->netif);
    return ERR_OK;
}

////////////////////////////////////////////////////////////////////////////////
static int netif_ethernet_set_link_callback(void * instance, void (* link_callback)(lwip_t * lwip), void * context)
{
netif_ethernet_t* netif_ethernet = (netif_ethernet_t *) instance;

    assert(netif_ethernet);

    if (netif_ethernet->signature != NETIF_ETHERNET_SIGNATURE)
        return ERR_ARG;

    netif_set_link_callback_ex(&netif_ethernet->netif, (void *)link_callback, context);

    return ERR_OK;
}

/** @brief Start function which activates the adaptor and registers it with
 *         LWIP. If DHCP is enabled, it will initiate a request and return immediately
 *
 * @param  instance   a pointer to a netif_ethernet instance
 *                    which was previously returned by
 *                    netif_ethernet_open
 * @return ERR_ARG    if instance does not point to a valid
 *                    netif_ethernet instance.
 *         ERR_OK     if the function was successful.
 */
static int netif_ethernet_start(void * instance)
{
    struct ip_addr ipaddr, netmask, gw;
    netif_ethernet_t* netif_ethernet = (netif_ethernet_t *) instance;

    assert(netif_ethernet);

    if (netif_ethernet->signature != NETIF_ETHERNET_SIGNATURE)
        return ERR_ARG;
#if LWIP_DHCP
    ipaddr.addr = 0;
    netmask.addr = 0;
    gw.addr = 0;
#else
    ipaddr.addr = netif_ethernet->ip_address.addr;
    netmask.addr = netif_ethernet->netmask.addr;
    gw.addr = netif_ethernet->gateway.addr;
#endif

    netif_add(&netif_ethernet->netif, &ipaddr, &netmask, &gw, netif_ethernet->ethernet,
              netif_ethernet_init, tcpip_input);


#if LWIP_DNS && !LWIP_DHCP
    dns_setserver(0,&netif_ethernet->primary_dns);
    dns_setserver(1,&netif_ethernet->secondary_dns);
#endif

#if LWIP_DHCP
    dhcp_start(&netif_ethernet->netif);
#else
    netif_set_up(&netif_ethernet->netif);
#endif         
    return ERR_OK;
}

int netif_ethernet_stop(void * impl)
{
    netif_ethernet_t* netif_ethernet = (netif_ethernet_t *) impl;

    assert(netif_ethernet);

    if (netif_ethernet->signature != NETIF_ETHERNET_SIGNATURE)
        return ERR_ARG;

    netif_remove(&netif_ethernet->netif);
    return ERR_OK;
}

static struct ip_addr     netif_ethernet_get_local_addr         (void * impl)
{
    netif_ethernet_t* netif_ethernet = (netif_ethernet_t *) impl;

    assert(netif_ethernet);

    if (netif_ethernet->signature != NETIF_ETHERNET_SIGNATURE)
        return *IP_ADDR_ANY;

    return netif_ethernet->netif.ip_addr;
}
static struct ip_addr     netif_ethernet_get_netmask            (void * impl)
{
    netif_ethernet_t* netif_ethernet = (netif_ethernet_t *) impl;

    assert(netif_ethernet);

    if (netif_ethernet->signature != NETIF_ETHERNET_SIGNATURE)
        return *IP_ADDR_ANY;

    return netif_ethernet->netif.netmask;
}

static struct ip_addr     netif_ethernet_get_gateway_addr       (void * impl)
{
    netif_ethernet_t* netif_ethernet = (netif_ethernet_t *) impl;

    assert(netif_ethernet);

    if (netif_ethernet->signature != NETIF_ETHERNET_SIGNATURE)
        return *IP_ADDR_ANY;
 
    return netif_ethernet->netif.gw;
}
static struct ip_addr     netif_ethernet_get_primary_dns_addr   (void * impl)
{
    netif_ethernet_t* netif_ethernet = (netif_ethernet_t *) impl;

    assert(netif_ethernet);

    if (netif_ethernet->signature != NETIF_ETHERNET_SIGNATURE)
        return *IP_ADDR_ANY;

#if LWIP_DNS
    return dns_getserver(0);
#else
    return *IP_ADDR_ANY;
#endif
}
static struct ip_addr     netif_ethernet_get_secondary_dns_addr (void * impl)
{
    netif_ethernet_t* netif_ethernet = (netif_ethernet_t *) impl;

    assert(netif_ethernet);

    if (netif_ethernet->signature != NETIF_ETHERNET_SIGNATURE)
        return *IP_ADDR_ANY;

#if LWIP_DNS
    return dns_getserver(1);
#else
    return *IP_ADDR_ANY;
#endif
}

/** @brief Initialize the adaptor by creating a netif_impl
 *         structure and passing it to the LWIP instance on
 *         the upper interface.
 */
void netif_ethernet_init_adaptor()
{
    unsigned int netif_id;

    for (netif_id=0;netif_id<NETIF_ETHERNET_INSTANCE_COUNT;netif_id++)
    {
        unsigned int lwip_id = netif_ethernet_instance_table[netif_id].netif; // JTK -- should really be a new id in the adaptor cfg
        netif_impl_t * netif = netif_impl_init(lwip_id,netif_id,
                                                &netif_ethernet_open,
                                                &netif_ethernet_start,
                                                &netif_ethernet_stop,
                                                &netif_ethernet_get_local_addr,
                                                NULL,
                                                &netif_ethernet_get_netmask,
                                                &netif_ethernet_get_gateway_addr,
                                                &netif_ethernet_get_primary_dns_addr,
                                                &netif_ethernet_get_secondary_dns_addr,
                                                &netif_ethernet_set_default,
                                                (void *)&netif_ethernet_set_link_callback);

        assert(lwip_id  >= 0 && lwip_id  < LWIP_INSTANCE_COUNT);
        assert (netif);

        lwip_set_netif(lwip_id,netif);
    }
}

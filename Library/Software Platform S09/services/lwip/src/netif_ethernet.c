/**
 * LWIP ETHERNET interface
 */

/*
 * Copyright (c) 2001-2004 Swedish Institute of Computer Science.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
 * SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
 * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
 * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY
 * OF SUCH DAMAGE.
 *
 * This file is part of the lwIP TCP/IP stack.
 *
 * Author: Adam Dunkels <adam@sics.se>
 *
 */

#include "lwip/opt.h"

#include "lwip/def.h"
#include "lwip/mem.h"
#include "lwip/pbuf.h"
#include "lwip/sys.h"
#include <lwip/stats.h>
#include <lwip/snmp.h>
#include "netif/etharp.h"
#include "netif/ppp_oe.h"

#include <pthread.h>
#include <ethernet.h>

#include <string.h>
#include <assert.h>

#include <lwip/tcpip.h>
#include <lwip/netif_ethernet.h>
#include <lwip_cfg.h>
#include <lwip_cfg_instance.h>

/* Define those to better describe your network interface. */
#define EMAC32_IFNAME0 'e'
#define EMAC32_IFNAME1 'n'


/**
 * This function does the actual transmission of the packet. The packet is
 * contained in the pbuf that is passed to the function. This pbuf
 * might be chained.
 *
 * @param netif the lwip network interface structure for this ethernetif
 * @param p the MAC packet to send (e.g. IP packet including MAC addresses and type)
 * @return ERR_OK if the packet could be sent
 *         an err_t value if the packet couldn't be sent
 *
 * @note Returning ERR_MEM here if a DMA queue of your MAC is full can lead to
 *       strange results. You might consider waiting for space in the DMA queue
 *       to become availale since the stack doesn't retry to send a packet
 *       dropped because of memory failure (except for the TCP timers).
 */
static err_t low_level_output(struct netif *netif, struct pbuf *p)
{
	ethernet_t *ethernet = (ethernet_t *) netif->state;
	uint32_t *ethernet_corebuf;
	struct pbuf *q;
	char *qdata;

#if ETH_PAD_SIZE
	pbuf_header(p, -ETH_PAD_SIZE);	/* drop the padding word */
#endif

	do {
		ethernet_corebuf = ethernet_corebuf_alloc(ethernet, p->tot_len);
	}
	while (ethernet_corebuf == NULL);

	qdata = (char *) (ethernet_corebuf + 1);

	/* copy data from pbuf chain into the core */
	for (q = p; q != NULL; q = q->next) {
		memcpy(qdata, q->payload, q->len);
		qdata += q->len;
	}

	//    printf("send %08X %i\n", (int) ethernet_corebuf, *ethernet_corebuf);
	ethernet_corebuf_send(ethernet, ethernet_corebuf);

#if ETH_PAD_SIZE
	pbuf_header(p, ETH_PAD_SIZE);	/* reclaim the padding word */
#endif

	LINK_STATS_INC(link.xmit);

	return ERR_OK;
}


/**
 * Allocate a pbuf and transfer the bytes of the incoming
 * packet from the interface into the pbuf.
 *
 * @param netif the lwip network interface structure for this ethernetif
 * @return a pbuf filled with the received packet (including MAC header)
 *         NULL if no packet received, or on memory error
 */
static struct pbuf *low_level_input(struct netif *netif)
{
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
	len += ETH_PAD_SIZE;		/* allow room for Ethernet padding */
#endif

	/* We allocate a pbuf chain of pbufs from the pool. */
	p = pbuf_alloc(PBUF_RAW, len, PBUF_POOL);
	qdata = (char *) (ethernet_corebuf + 1);

	if (p != NULL) {

#if ETH_PAD_SIZE
		pbuf_header(p, -ETH_PAD_SIZE);	/* drop the padding word */
#endif

		/* copy core data into pbuf chain */
		for (q = p; q != NULL; q = q->next) {
			memcpy(q->payload, qdata, q->len);
			qdata += q->len;
		}

#if ETH_PAD_SIZE
		pbuf_header(p, ETH_PAD_SIZE);	/* reclaim the padding word */
#endif

		LINK_STATS_INC(link.recv);
	} else {
		/* out of memory, drop packet */
		LINK_STATS_INC(link.memerr);
		LINK_STATS_INC(link.drop);
	}

	ethernet_corebuf_free(ethernet, ethernet_corebuf);

	return p;
}


/**
 * This function is called when a packet is ready to be read
 * from the interface. It uses the function low_level_input() that
 * should handle the actual reception of bytes from the network
 * interface. Then the type of the received packet is determined and
 * the appropriate input function is called.
 *
 * @param netif the lwip network interface structure for this ethernetif
 */
static void process_input(struct netif *netif, struct pbuf *p)
{
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
#endif							/* PPPOE_SUPPORT */
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


static void *ethernetif_input_thread(void *arg)
{
	struct netif *netif = (struct netif *) arg;
	struct pbuf *p;

	for (;;) {
		/*
		 * test for new packet, if received move into a new pbuf
		 */
		p = low_level_input(netif);

		if (p) {
			process_input(netif, p);
		} else {
			sched_yield();
		}
	}
}


/**
 * In this function, the hardware should be initialized.
 * Called from ethernetif_init().
 *
 * @param netif the already initialized lwip network interface structure
 *        for this ethernetif
 */
static void low_level_init(struct netif *netif)
{
	ethernet_t *ethernet = (ethernet_t *) netif->state;
	uint8_t mac[6];
	pthread_t thread;
	pthread_attr_t attr;

	/* get MAC hardware address */
	ethernet_getmac(ethernet, mac);

	netif->hwaddr_len = 6;
	for (int i = 0; i < 6; ++i) {
		netif->hwaddr[i] = mac[i];
	}

	/* maximum transfer unit */
	netif->mtu = 1500;

	/* device capabilities */
	netif->flags =
		NETIF_FLAG_BROADCAST | NETIF_FLAG_ETHARP | NETIF_FLAG_LINK_UP;

	/* start input thread */
	pthread_attr_init(&attr);
	pthread_create(&thread, &attr, &ethernetif_input_thread, netif);
}



/**
 * Should be called at the beginning of the program to set up the
 * network interface. It calls the function low_level_init() to do the
 * actual setup of the hardware.
 *
 * This function should be passed as a parameter to netif_add().
 *
 * @param netif the lwip network interface structure for this ethernetif
 * @return ERR_OK if the loopif is initialized
 *         ERR_MEM if private data couldn't be allocated
 *         any other err_t on error
 */
/* static */ err_t netif_ethernet_init(struct netif *netif)
{
	ethernet_t *ethernet = (ethernet_t *) netif->state;

	LWIP_ASSERT("netif != NULL", (netif != NULL));

#if LWIP_NETIF_HOSTNAME
	/* Initialize interface hostname */
	netif->hostname = "lwip";
#endif							/* LWIP_NETIF_HOSTNAME */

#if 0
	/*
	 * Initialize the snmp variables and counters inside the struct netif.
	 * The last argument should be replaced with your link speed, in units
	 * of bits per second.
	 */
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


/****************************** SSAS SPECIFIC ************************************/



struct netifethernet_s {
	struct netif netif;
};

typedef struct netifethernet_s netifethernet_t;


static netifethernet_t srv_table[LWIP_INSTANCE_COUNT];


struct netif *netif_ethernet_open(int id)
{
	assert((id >= 0) && (id < LWIP_INSTANCE_COUNT));

	ethernet_t *ethernet;
	struct ip_addr ipaddr, netmask, gw;

	netifethernet_t *restrict srv = &srv_table[id];
	lwip_cfg_instance_t *restrict srv_cfg = &lwip_instance_table[id];

	// open underlying generic ethernet device
	ethernet = ethernet_open(srv_cfg->ethernet);

#if LWIP_DHCP
	ipaddr.addr = 0;
	netmask.addr = 0;
	gw.addr = 0;
#else
	IP4_ADDR(&ipaddr, srv_cfg->ipaddr[0], srv_cfg->ipaddr[1],
			 srv_cfg->ipaddr[2], srv_cfg->ipaddr[3]);
	IP4_ADDR(&netmask, srv_cfg->netmask[0], srv_cfg->netmask[1],
			 srv_cfg->netmask[2], srv_cfg->netmask[3]);
	IP4_ADDR(&gw, srv_cfg->gw[0], srv_cfg->gw[1], srv_cfg->gw[2],
			 srv_cfg->gw[3]);
#endif

	// add interface to LWIP
	netif_add(&srv->netif, &ipaddr, &netmask, &gw, ethernet,
			  netif_ethernet_init, tcpip_input);

#if LWIP_DHCP
	dhcp_start(&netif);
#else
	netif_set_up(&srv->netif);
#endif

	// normally for SSAS the 'srv' itself should be returned
	// but 'netif' makes a lot more sense for later usage of LWIP
	return &srv->netif;
}

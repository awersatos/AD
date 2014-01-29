/*************************************************************************
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  COPYRIGHT:          Copyright (c) 2009, Altium
|*
 */

/**
 * @file
 * LWIP TCP/IP stack service
 *
 * Further documentation on LWIP can be found at
 * http://savannah.nongnu.org/projects/lwip/
 */

#ifndef _LWIP_H
#define _LWIP_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <lwip/err.h>
#include <lwip/ip_addr.h>
#include <lwip/netif.h>

#if LWIP_UNIFIED

#include <sockfs.h>

#define accept(a,b,c)         sockfs_accept(a,b,c)
#define bind(a,b,c)           sockfs_bind(a,b,c)
#define shutdown(a,b)         sockfs_shutdown(a,b)
#define closesocket(s)        close(s)
#define getpeername(a,b,c)    sockfs_getpeername(a,b,c)
#define getsockname(a,b,c)    sockfs_getsockname(a,b,c)
#define getsockopt(a,b,c,d,e) sockfs_getsockopt(a,b,c,d,e)
#define setsockopt(a,b,c,d,e) sockfs_setsockopt(a,b,c,d,e)
#define connect(a,b,c)        sockfs_connect(a,b,c)
#define listen(a,b)           sockfs_listen(a,b)
#define recv(a,b,c,d)         sockfs_recv(a,b,c,d)
#define recvfrom(a,b,c,d,e,f) sockfs_recvfrom(a,b,c,d,e,f)
#define send(a,b,c,d)         sockfs_send(a,b,c,d)
#define sendto(a,b,c,d,e,f)   sockfs_sendto(a,b,c,d,e,f)
#define socket(a,b,c)         sockfs_socket(a,b,c)
#define select(a,b,c,d,e)     sockfs_select(a,b,c,d,e)
#define ioctlsocket(a,b,c)    sockfs_ioctl(a,b,c)

#endif

#define LWIP_INVALID_SOCKET 0xFFFF

typedef struct _lwip lwip_t;

typedef enum
{
    NETIF_ADDR_LOCAL,
    NETIF_ADDR_NETMASK,
    NETIF_ADDR_GATEWAY,
#if LWIP_DNS
    NETIF_ADDR_PRIMARY_DNS,
    NETIF_ADDR_SECONDARY_DNS,
#endif
} netif_addr_type_t;

extern lwip_t * lwip_open(unsigned int id);
extern int lwip_start(lwip_t * lwip);
extern int lwip_stop(lwip_t * lwip);

extern struct ip_addr     lwip_get_local_addr         (lwip_t * lwip);
extern struct ip_addr     lwip_get_remote_addr        (lwip_t * lwip);
extern struct ip_addr     lwip_get_netmask            (lwip_t * lwip);
extern struct ip_addr     lwip_get_gateway_addr       (lwip_t * lwip);
extern struct ip_addr     lwip_get_primary_dns_addr   (lwip_t * lwip);
extern struct ip_addr     lwip_get_secondary_dns_addr (lwip_t * lwip);

extern void lwip_set_netif_callback(lwip_t * lwip, void (* link_callback)(lwip_t * lwip));

extern void lwip_print_addrs(lwip_t * lwip);

#define ip_addr_print(ipaddr) \
  (ipaddr==NULL ? 0 : printf("%u.%u.%u.%u",   \
                      (u16_t)(ntohl((ipaddr)->addr) >> 24) & 0xff,  \
                      (u16_t)(ntohl((ipaddr)->addr) >> 16) & 0xff,  \
                      (u16_t)(ntohl((ipaddr)->addr) >> 8 ) & 0xff,  \
                      (u16_t) ntohl((ipaddr)->addr)        & 0xff)  )

#ifdef  __cplusplus
}
#endif

#endif /* _LWIP_H*/

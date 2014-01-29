/******************************************************************************
 * FILE:        @(#)in.h        1.1 07/03/13
 * DESCRIPTION:
 *      netinet/in.h - Internet address family
 *****************************************************************************/
#ifndef _IN_H
#define _IN_H

#include <inttypes.h>
#include <sys/socket.h>

typedef uint16_t        in_port_t;
typedef uint32_t        in_addr_t;


struct in_addr {
        in_addr_t       s_addr;
};

struct sockaddr_in {
        sa_family_t     sin_family;     /* AF_INET      */
        in_port_t       sin_port;       /* Port number  */
        struct in_addr  sin_addr;       /* IP address   */
};

/*
 * The sin_port and sin_addr members shall be in network byte order.
 *
 * The sockaddr_in structure is used to store addresses for the Internet
 * address family. Values of this type shall be cast by applications to
 * struct sockaddr for use with socket functions.
 */


#if (__POSIX_IPV6 != 0)

/*
 * [IP6] [Option Start] The <netinet/in.h> header shall define the in6_addr structure that contains at least the following member:
 */

struct in6_addr {
        uint8_t s6_addr[16];    /* This array is used to contain a 128-bit IPv6 address, stored in network byte order. */
};

/*
 * The <netinet/in.h> header shall define the sockaddr_in6 structure that includes at least the following members:
 */
struct sockaddr_in6 {
        sa_family_t     sin6_family;    /* AF_INET6. */
        in_port_t       sin6_port;      /* Port number. */
        uint32_t        sin6_flowinfo;  /* IPv6 traffic class and flow information. */
        struct in6_addr sin6_addr;      /* IPv6 address. */
        uint32_t        sin6_scope_id;  /* Set of interfaces for a scope. */
};

/*
 * The sin6_port and sin6_addr members shall be in network byte order.
 *
 * The sockaddr_in6 structure shall be set to zero by an application prior to
 * using it, since implementations are free to have additional,
 * implementation-defined fields in sockaddr_in6.
 *
 * The sin6_scope_id field is a 32-bit integer that identifies a set of
 * interfaces as appropriate for the scope of the address carried in the
 * sin6_addr field. For a link scope sin6_addr, the application shall
 * ensure that sin6_scope_id is a link index. For a site scope sin6_addr,
 * the application shall ensure that sin6_scope_id is a site index.
 * The mapping of sin6_scope_id to an interface or set of interfaces is
 * implementation-defined.
 */

/*
 * The <netinet/in.h> header shall declare the following external variable:
 */
extern const struct in6_addr in6addr_any;       /* :: */

/*
 * This variable is initialized by the system to contain the wildcard IPv6
 * address. The <netinet/in.h> header also defines the IN6ADDR_ANY_INIT macro.
 * This macro must be constant at compile time and can be used to initialize
 * a variable of type struct in6_addr to the IPv6 wildcard address.
 */
#define IN6ADDR_ANY_INIT        { { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 } }

/*
 * The <netinet/in.h> header shall declare the following external variable:
 */
extern const struct in6_addr in6addr_loopback;  /* ::1 */

/*
 * This variable is initialized by the system to contain the loopback IPv6
 * address. The <netinet/in.h> header also defines the IN6ADDR_LOOPBACK_INIT
 * macro. This macro must be constant at compile time and can be used to
 * initialize a variable of type struct in6_addr to the IPv6 loopback address.
 */
#define IN6ADDR_LOOPBACK_INIT   { { 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1 } }

/*
 * The <netinet/in.h> header shall define the ipv6_mreq structure that includes 
 * at least the following members:
 */
struct ipv6_mreq {
        struct in6_addr ipv6mr_multiaddr;       /* IPv6 multicast address. */
        unsigned        ipv6mr_interface;       /* Interface index. */
};

#endif /* if (__POSIX_IPV6 != 0) */


/*
 * The <netinet/in.h> header shall define the following macros for use as
 * values of the level argument of getsockopt() and setsockopt():
 */
#define IPPROTO_IP              0       /* Internet protocol            */
#if (__POSIX_IPV6 != 0)
#define IPPROTO_IPV6            41      /* Internet Protocol Version 6  */
#endif /* if (__POSIX_IPV6 != 0) */
#define IPPROTO_ICMP            1       /* Control message protocol     */
#if (__POSIX_RAW_SOCKETS != 0)
#define IPPROTO_RAW             255     /* Raw IP Packets Protocol      */
#endif /* (__POSIX_RAW_SOCKETS != 0) */
#define IPPROTO_TCP             6       /* Transmission control protocol        */
#define IPPROTO_UDP             17      /* User datagram protocol               */

/*
 * The <netinet/in.h> header shall define the following macros for use as
 * destination addresses for connect(), sendmsg(), and sendto():
 */
#define INADDR_ANY              ((in_addr_t) 0x00000000)        /* IPv4 local host address      */
#define INADDR_BROADCAST        ((in_addr_t) 0xffffffff)        /* IPv4 broadcast address       */

/*
 * The <netinet/in.h> header shall define the following macro to help
 * applications declare buffers of the proper size to store IPv4 addresses
 * in string form:
 */
#define INET_ADDRSTRLEN         16      /* Length of the string form for IP     */

/*
 * The htonl(), htons(), ntohl(), and ntohs() functions shall be available
 * as defined in <arpa/inet.h>. Inclusion of the <netinet/in.h> header may
 * also make visible all symbols from <arpa/inet.h>.
 */
#include <arpa/inet.h>

#if (__POSIX_IPV6 != 0)
/*
 * [IP6] [Option Start] The <netinet/in.h> header shall define the following
 * macro to help applications declare buffers of the proper size to store
 * IPv6 addresses in string form:
 */
#define INET6_ADDRSTRLEN        46      /* Length of the string form for IPv6. */

/*
 * The <netinet/in.h> header shall define the following macros, with distinct
 * integer values, for use in the option_name argument in the getsockopt() or
 * setsockopt() functions at protocol level IPPROTO_IPV6:
 */
#define IPV6_JOIN_GROUP
        /* Join a multicast group. */
#define IPV6_LEAVE_GROUP
        /* Quit a multicast group. */
#define IPV6_MULTICAST_HOPS

        /* Multicast hop limit. */
#define IPV6_MULTICAST_IF
        /* Interface to use for outgoing multicast packets. */
#define IPV6_MULTICAST_LOOP

        /* Multicast packets are delivered back to the local application. */
#define IPV6_UNICAST_HOPS
        /* Unicast hop limit. */
#define IPV6_V6ONLY
        /* Restrict AF_INET6 socket to IPv6 communications only. */

/*
 * The <netinet/in.h> header shall define the following macros that test for
 * special IPv6 addresses. Each macro is of type int and takes a single
 * argument of type const struct in6_addr *:
 */
#define IN6_IS_ADDR_UNSPECIFIED(addr)   addr

        /* Unspecified address. */
#define IN6_IS_ADDR_LOOPBACK

        /* Loopback address. */
#define IN6_IS_ADDR_MULTICAST

        /* Multicast address. */
#define IN6_IS_ADDR_LINKLOCAL

        /* Unicast link-local address. */
#define IN6_IS_ADDR_SITELOCAL

        /* Unicast site-local address. */
#define IN6_IS_ADDR_V4MAPPED

        /* IPv4 mapped address. */
#define IN6_IS_ADDR_V4COMPAT

        /* IPv4-compatible address. */
#define IN6_IS_ADDR_MC_NODELOCAL

        /* Multicast node-local address. */
#define IN6_IS_ADDR_MC_LINKLOCAL

        /* Multicast link-local address. */
#define IN6_IS_ADDR_MC_SITELOCAL

        /* Multicast site-local address. */
#define IN6_IS_ADDR_MC_ORGLOCAL

        /* Multicast organization-local address. */
#define IN6_IS_ADDR_MC_GLOBAL

        /* Multicast global address. */
#endif /* if (__POSIX_IPV6 != 0) */



#endif /* ndef _IN_H */


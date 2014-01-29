/******************************************************************************
 * FILE:        @(#)inet.h      1.1 07/03/13
 * DESCRIPTION:
 *      arpa/inet.h - definitions for internet operations
 *****************************************************************************/
#ifndef _INET_H
#define _INET_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <inttypes.h>
#include <netinet/in.h>

/*
DESCRIPTION

    The in_port_t and in_addr_t types shall be defined as described in <netinet/in.h>.

    The in_addr structure shall be defined as described in <netinet/in.h>.

    The INET_ADDRSTRLEN [IP6] [Option Start]  and INET6_ADDRSTRLEN [Option End] macros shall be defined as described in <netinet/in.h>.

    The following shall either be declared as functions, defined as macros, or both. If functions are declared, function prototypes shall be provided.

 */

extern uint32_t htonl(uint32_t);
extern uint16_t htons(uint16_t);
extern uint32_t ntohl(uint32_t);
extern uint16_t ntohs(uint16_t);

/*
    The uint32_t and uint16_t types shall be defined as described in <inttypes.h>.

    The following shall be declared as functions and may also be defined as macros. Function prototypes shall be provided.
 */

extern in_addr_t        inet_addr(const char *);
extern char             *inet_ntoa(struct in_addr);
extern const char       *inet_ntop(int, const void *restrict, char *restrict, socklen_t);
extern int              inet_pton(int, const char *restrict, void *restrict);

#ifdef  __cplusplus
}
#endif

#endif /* ndef _INET_H */


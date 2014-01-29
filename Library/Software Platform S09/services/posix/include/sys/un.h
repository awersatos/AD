/******************************************************************************
 * FILE:        %W% %E%
 * DESCRIPTION:
 *      sys/un.h - definitions for UNIX domain sockets
 *****************************************************************************/
#ifndef _UN_H
#define _UN_H

#include <sys/socket.h>

/*
 * The <sys/un.h> header shall define the sockaddr_un structure that includes at least the following members:
 */
struct sockaddr_un {
        uint8_t         sa_len;         /* total length */ // TODO see i we can get rid of this member
        sa_family_t     sun_family;     /* Address family.      */
        char            sun_path[104];  /* Socket pathname.     */
};

/*
 * The sockaddr_un structure is used to store addresses for UNIX domain sockets.
 * Values of this type shall be cast by applications to struct sockaddr for use
 * with socket functions.
 */

/* actual length of an initialized sockaddr_un */
#define SUN_LEN(su) \
        (sizeof(*(su)) - sizeof((su)->sun_path) + strlen((su)->sun_path))

#endif /* ndef _UN_H */


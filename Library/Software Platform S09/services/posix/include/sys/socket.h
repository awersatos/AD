/******************************************************************************
 * FILE:        %W% %E%
 * DESCRIPTION:
 *      sys/socket.h - main sockets header
 *****************************************************************************/
#ifndef _SOCKET_H
#define _SOCKET_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <unistd.h>

#if (__POSIX_NETWORKING != 0)

#include <sys/uio.h>


typedef int32_t         socklen_t;
typedef uint8_t         sa_family_t;

/*
 *  Desired design of maximum size and alignment.
 */
#define _SS_MAXSIZE 128
        /* Implementation-defined maximum size. */
#define _SS_ALIGNSIZE (sizeof(int64_t))
        /* Implementation-defined desired alignment. */


/*
 *  Definitions used for sockaddr_storage structure paddings design.
 */
#define _SS_PAD1SIZE (_SS_ALIGNSIZE - sizeof(sa_family_t) - sizeof(uint8_t))
#define _SS_PAD2SIZE (_SS_MAXSIZE - (sizeof(sa_family_t) + sizeof(uint8_t) + \
                          _SS_PAD1SIZE + _SS_ALIGNSIZE))
struct sockaddr_storage {
        uint8_t         sa_len;         /* total length */ // TODO see if we can get rid of this member
        sa_family_t     sa_family;      /* Address family. */
        char _ss_pad1[_SS_PAD1SIZE];
        int64_t _ss_align;              /* Field to force desired structure storage alignment. */
        char _ss_pad2[_SS_PAD2SIZE];
};

struct sockaddr {
        uint8_t         sa_len;         /* total length */ // TODO see i we can get rid of this member
        sa_family_t     sa_family;      /* Address family. */
        char            sa_data[sizeof(struct sockaddr_storage) - sizeof(sa_family_t) - sizeof(uint8_t)];       /* Socket address (variable-length data). */
};



struct msghdr {
        void            *msg_name;      /* Optional address.            */
        socklen_t       msg_namelen;    /* Size of address.             */
        struct iovec    *msg_iov;       /* Scatter/gather array.        */
        int             msg_iovlen;     /* Members in msg_iov.          */
        void            *msg_control;   /* Ancillary data; see below.   */
        socklen_t       msg_controllen; /* Ancillary data buffer len.   */
        int             msg_flags;      /* Flags on received message.   */
};

struct cmsghdr {
        socklen_t       cmsg_len;       /* Data byte count, including the cmsghdr.      */
        int             cmsg_level;     /* Originating protocol.        */
        int             cmsg_type;      /* Protocol-specific type.      */
        /* followed by  u_char  cmsg_data[]; */
};

/*
    The cmsghdr structure is used for storage of ancillary data object information.

    Ancillary data consists of a sequence of pairs, each consisting of a cmsghdr structure followed by a data array. The data array contains the ancillary data message, and the cmsghdr structure contains descriptive information that allows an application to correctly parse the data.

    The values for cmsg_level shall be legal values for the level argument to the getsockopt() and setsockopt() functions. The system documentation shall specify the cmsg_type definitions for the supported protocols.

    Ancillary data is also possible at the socket level. The <sys/socket.h> header defines the following macro for use as the cmsg_type value when cmsg_level is SOL_SOCKET:
*/
#define SCM_RIGHTS      1
        /* Indicates that the data array contains the access rights to be sent or received. */

/*
 * The <sys/socket.h> header defines the following macros to gain access to
 * the data arrays in the ancillary data associated with a message header:
 */
#define CMSG_DATA(cmsg)         ((unsigned char *)((cmsg) + 1))

/*
 * If the argument is a pointer to a cmsghdr structure, this macro shall
 * return an unsigned character pointer to the data array associated with
 * the cmsghdr structure.
 */
#define CMSG_NXTHDR(mhdr,cmsg)  \
        (((caddr_t)(cmsg) + (cmsg)->cmsg_len + sizeof(struct cmsghdr) > \
            (mhdr)->msg_control + (mhdr)->msg_controllen) ? \
            (struct cmsghdr *)NULL : \
            (struct cmsghdr *)((caddr_t)(cmsg) + ALIGN((cmsg)->cmsg_len)))

/*
 * If the first argument is a pointer to a msghdr structure and the second
 * argument is a pointer to a cmsghdr structure in the ancillary data
 * pointed to by the msg_control field of that msghdr structure, this
 * macro shall return a pointer to the next cmsghdr structure, or a null
 * pointer if this structure is the last cmsghdr in the ancillary data.
 */
#define CMSG_FIRSTHDR(mhdr)     ((struct cmsghdr *)(mhdr)->msg_control)

/*
 * If the argument is a pointer to a msghdr structure, this macro shall
 * return a pointer to the first cmsghdr structure in the ancillary data
 * associated with this msghdr structure, or a null pointer if there is
 * no ancillary data associated with the msghdr structure.
 */

struct linger {
        int     l_onoff;                /* Indicates whether linger option is enabled.  */
        int     l_linger;               /* Linger time, in seconds.                     */
};

#define SOCK_DGRAM              1       /* Datagram socket.     */
#if (__POSIX_RAW_SOCKETS != 0)
#define SOCK_RAW                2       /* [RS] [Option Start] Raw Protocol Interface. [Option End] */
#endif /* (__POSIX_RAW_SOCKETS != 0) */
#define SOCK_SEQPACKET          3       /* Sequenced-packet socket.     */
#define SOCK_STREAM             4       /* Byte-stream socket.          */


/*
 * The <sys/socket.h> header shall define the following macro for use as the
 * level argument of setsockopt() and getsockopt().
 */
#define SOL_SOCKET              1       /* Options to be accessed at socket level, not protocol level. */


/*
 * The <sys/socket.h> header shall define the following macros, with distinct
 * integer values, for use as the option_name argument in getsockopt() or
 * setsockopt() calls:
 */
#define SO_ACCEPTCONN           (1<<0)  /* Socket is accepting connections. */
#define SO_BROADCAST            (1<<1)  /* Transmission of broadcast messages is supported. */
#define SO_DEBUG                (1<<2)  /* Debugging information is being recorded. */
#define SO_DONTROUTE            (1<<3)  /* Bypass normal routing. */
#define SO_ERROR                (1<<4)  /* Socket error status. */
#define SO_KEEPALIVE            (1<<5)  /* Connections are kept alive with periodic messages. */
#define SO_LINGER               (1<<6)  /* Socket lingers on close. */
#define SO_OOBINLINE            (1<<7)  /* Out-of-band data is transmitted in line. */
#define SO_RCVBUF               (1<<8)  /* Receive buffer size. */
#define SO_RCVLOWAT             (1<<9)  /* Receive ``low water mark''. */
#define SO_RCVTIMEO             (1<<10) /* Receive timeout. */
#define SO_REUSEADDR            (1<<11) /* Reuse of local addresses is supported. */
#define SO_SNDBUF               (1<<12) /* Send buffer size. */
#define SO_SNDLOWAT             (1<<13) /* Send ``low water mark''. */
#define SO_SNDTIMEO             (1<<14) /* Send timeout. */
#define SO_TYPE                 (1<<15) /* Socket type. */
#define SO_USELOOPBACK          (1<<15) /* internal */

/*
 * The <sys/socket.h> header shall define the following macro as the maximum
 * backlog queue length which may be specified by the backlog field of the
 * listen() function:
 */
#define SOMAXCONN               5       /* The maximum backlog queue length. */

/*
 * The <sys/socket.h> header shall define the following macros, with distinct integer
 * values, for use as the valid values for the msg_flags field in the msghdr structure,
 * or the flags parameter in recvfrom(), recvmsg(), sendmsg(), or sendto() calls:
 */
#define MSG_CTRUNC              (1<<0)  /* Control data truncated. */
#define MSG_DONTROUTE           (1<<1)  /* Send without using routing tables. */
#define MSG_EOR                 (1<<2)  /* Terminates a record (if supported by the protocol). */
#define MSG_OOB                 (1<<3)  /* Out-of-band data. */
#define MSG_PEEK                (1<<4)  /* Leave received data in queue. */
#define MSG_TRUNC               (1<<5)  /* Normal data truncated. */
#define MSG_WAITALL             (1<<6)  /* Attempt to fill the read buffer. */
#define MSG_DONTWAIT            (1<<7)  /* TODO MSG_DONTWAIT is not in the opengroup specification. */

/*
 * The <sys/socket.h> header shall define the following macros, with distinct integer values:
 */
#define AF_INET                 1       /* Internet domain sockets for use with IPv4 addresses. */
#if (__POSIX_IPV6 != 0)
#define AF_INET6                2       /* [IP6] [Option Start] Internet domain sockets for use with IPv6 addresses. [Option End] */
#endif /* (__POSIX_IPV6 != 0) */
#define AF_UNIX                 3       /* UNIX domain sockets. */
#define AF_UNSPEC               4       /* Unspecified. */
#define AF_LINK                 5       /* internal */
#define AF_ROUTE                6       /* Internal Routing Protocol */
#define AF_MAX                  7

/*
 * The <sys/socket.h> header shall define the following macros, with distinct integer values:
 */
#define SHUT_RD                 1       /* Disables further receive operations. */
#define SHUT_RDWR               2       /* Disables further send and receive operations. */
#define SHUT_WR                 3       /* Disables further send operations. */

/*
 * The following shall be declared as functions and may also be defined as macros. Function prototypes shall be provided.
 */
extern int      accept(int, struct sockaddr *restrict, socklen_t *restrict);
extern int      bind(int, const struct sockaddr *, socklen_t);
extern int      connect(int, const struct sockaddr *, socklen_t);
extern int      getpeername(int, struct sockaddr *restrict, socklen_t *restrict);
extern int      getsockname(int, struct sockaddr *restrict, socklen_t *restrict);
extern int      getsockopt(int, int, int, void *restrict, socklen_t *restrict);
extern int      listen(int, int);
extern ssize_t  recv(int, void *, size_t, int);
extern ssize_t  recvfrom(int, void *restrict, size_t, int,
                        struct sockaddr *restrict, socklen_t *restrict);
extern ssize_t  recvmsg(int, struct msghdr *, int);
extern ssize_t  send(int, const void *, size_t, int);
extern ssize_t  sendmsg(int, const struct msghdr *, int);
extern ssize_t  sendto(int, const void *, size_t, int, const struct sockaddr *, socklen_t);
extern int      setsockopt(int, int, int, const void *, socklen_t);
extern int      shutdown(int, int);
extern int      socket(int, int, int);
extern int      sockatmark(int);
extern int      socketpair(int, int, int, int[2]);

/*
 * Inclusion of <sys/socket.h> may also make visible all symbols from <sys/uio.h>.
 */

#if 0
The following sections are informative.
APPLICATION USAGE

    To forestall portability problems, it is recommended that applications not use values larger than 231 -1 for the socklen_t type.

    The sockaddr_storage structure solves the problem of declaring storage for automatic variables which is both large enough and aligned enough for storing the socket address data structure of any family. For example, code with a file descriptor and without the context of the address family can pass a pointer to a variable of this type, where a pointer to a socket address structure is expected in calls such as getpeername(), and determine the address family by accessing the received content after the call.

    The example below illustrates a data structure which aligns on a 64-bit boundary. An implementation-defined field _ss_align following _ss_pad1 is used to force a 64-bit alignment which covers proper alignment good enough for needs of at least sockaddr_in6 (IPv6) and sockaddr_in (IPv4) address data structures. The size of padding field _ss_pad1 depends on the chosen alignment boundary. The size of padding field _ss_pad2 depends on the value of overall size chosen for the total size of the structure. This size and alignment are represented in the above example by implementation-defined (not required) constants _SS_MAXSIZE (chosen value 128) and _SS_ALIGNMENT (with chosen value 8). Constants _SS_PAD1SIZE (derived value 6) and _SS_PAD2SIZE (derived value 112) are also for illustration and not required. The implementation-defined definitions and structure field names above start with an underscore to denote implementation private name space. Portable code is not expected to access or reference those fields or constants.

    /*
     *  Desired design of maximum size and alignment.
     */
    #define _SS_MAXSIZE 128
        /* Implementation-defined maximum size. */
    #define _SS_ALIGNSIZE (sizeof(int64_t))
        /* Implementation-defined desired alignment. */


    /*
     *  Definitions used for sockaddr_storage structure paddings design.
     */
    #define _SS_PAD1SIZE (_SS_ALIGNSIZE - sizeof(sa_family_t))
    #define _SS_PAD2SIZE (_SS_MAXSIZE - (sizeof(sa_family_t)+ \
                          _SS_PAD1SIZE + _SS_ALIGNSIZE))
    struct sockaddr_storage {
        sa_family_t  ss_family;  /* Address family. */
    /*
     *  Following fields are implementation-defined.
     */
        char _ss_pad1[_SS_PAD1SIZE];
            /* 6-byte pad; this is to make implementation-defined
               pad up to alignment field that follows explicit in
               the data structure. */
        int64_t _ss_align;  /* Field to force desired structure
                               storage alignment. */
        char _ss_pad2[_SS_PAD2SIZE];
            /* 112-byte pad to achieve desired size,
               _SS_MAXSIZE value minus size of ss_family
               __ss_pad1, __ss_align fields is 112. */
    };

RATIONALE

    None.

FUTURE DIRECTIONS

    None.

SEE ALSO

    <sys/uio.h>, the System Interfaces volume of IEEE Std 1003.1-2001, accept(), bind(), connect(), getpeername(), getsockname(), getsockopt(), listen(), recv(), recvfrom(), recvmsg(), send(), sendmsg(), sendto(), setsockopt(), shutdown(), socket(), socketpair()

CHANGE HISTORY

    First released in Issue 6. Derived from the XNS, Issue 5.2 specification.

    The restrict keyword is added to the prototypes for accept(), getpeername(), getsockname(), getsockopt(), and recvfrom().

End of informative text.
#endif /* 0 */

#endif /* (__POSIX_NETWORKING != 0) */

#ifdef  __cplusplus
}
#endif

#endif /* _SOCKET_H */


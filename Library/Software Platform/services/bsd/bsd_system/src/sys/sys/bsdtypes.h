/*  $OpenBSD: types.h,v 1.31 2008/03/16 19:42:57 otto Exp $ */
/*  $NetBSD: types.h,v 1.29 1996/11/15 22:48:25 jtc Exp $   */

/*-
 * Copyright (c) 1982, 1986, 1991, 1993
 *  The Regents of the University of California.  All rights reserved.
 * (c) UNIX System Laboratories, Inc.
 * All or some portions of this file are derived from material licensed
 * to the University of California by American Telephone and Telegraph
 * Co. or Unix System Laboratories, Inc. and are reproduced herein with
 * the permission of UNIX System Laboratories, Inc.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. Neither the name of the University nor the names of its contributors
 *    may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 *
 *  @(#)types.h 8.4 (Berkeley) 1/21/94
 */

#include <pthread.h>
#include <sys/systm.h>

extern clock_t bsdticks_routine(void);
#define bsdticks        bsdticks_routine()
#define bsdtick         (CLOCKS_PER_SEC)

#define SMALL_KERNEL
/* Define platform endianness */
#ifndef BYTE_ORDER
# ifdef __LITTLE_ENDIAN__
# define BYTE_ORDER LITTLE_ENDIAN
# else
# define BYTE_ORDER BIG_ENDIAN
# endif
#endif /* BYTE_ORDER */

#ifndef _BSD_SYS_TYPES_H_
#define _BSD_SYS_TYPES_H_

#include <timing.h>

#include <sys/timeout.h>
#include <util_endian.h>

//#define BSD_USB_DEBUG
#undef BSD_USB_DEBUG

#ifdef BSD_USB_DEBUG
#define BSD_USB_DEBUG_LEVEL 14;
extern uint32_t usbdebug;
#define DPRINTF(x)  do { if (usbdebug) printf x; } while (0)
#define DPRINTFN(n,x)   do { if (usbdebug>(n)) printf x; } while (0)
#else
#define DPRINTF(x)
#define DPRINTFN(n,x)
#endif

#define letoh16(x)  little16(x)
#define letoh32(x)  little32(x)

#define betoh16(x)  big16(x)
#define betoh32(x)  big32(x)

#define htole16(x)  little16(x)
#define htole32(x)  little32(x)
#define htole64(x)  little64(x)

#define htobe16(x)  big16(x)
#define htobe32(x)  big32(x)
#define htobe64(x)  big64(x)

#ifndef htons
#define htons(x)    big16(x)
#endif

#ifndef ntohs
#define ntohs(x)    big16(x)
#endif

#define MINALLOCSIZE 4

//#define DELAY(x)    delay_us(x)
#define DELAY(x)      delay_yield_us(x)


//extern uint32_t htonl(uint32_t);
//extern uint16_t htons(uint16_t);
//extern uint32_t ntohl(uint32_t);
//extern uint16_t ntohs(uint16_t);

#define swap16(val) ((val << 8) | (val >> 8))

#define schednetisr(x)
#define ovbcopy bcopy

extern int hz;

#define ALIGN(x) x

#define KASSERT(...)

/* Maximum number of alternate routing tables */
#define RT_TABLEID_MAX  255


#ifndef ALIGNED_POINTER
/*
 * ALIGNED_POINTER is a boolean macro that checks whether an address
 * is valid to fetch data elements of type t from on this architecture.
 * This does not reflect the optimal alignment, just the possibility
 * (within reasonable limits).
 *
 */
#define ALIGNED_POINTER(p,t)    1
#endif

#define suser(a,b) 0
#define curproc 0

extern unsigned char etherbroadcastaddr[];

#include <sys/cdefs.h>
#include <errno.h>
//#include <sys/_types.h>

//#include <machine/endian.h>


// From socket.h
#define NBBY  8               /* number of bits in a byte */
#define NFDBITS ((unsigned)(sizeof(__fd_mask) * __NBBY)) /* bits per mask */
#define howmany(x, y) (((x) + ((y) - 1)) / (y))

/* Macros for min/max. */
#define MIN(a,b) (((a)<(b))?(a):(b))
#define MAX(a,b) (((a)>(b))?(a):(b))


#define panic printf

/*
 * flags to malloc
 */
#define M_WAITOK    0x0000
#define M_NOWAIT    0x0001
#define M_CANFAIL   0x0002
#define M_ZERO      0x0004


/*
 * XXX The exact-width bit types should only be exposed if __BSD_VISIBLE
 *     but the rest of the includes are not ready for that yet.
 */
#ifndef __BIT_TYPES_DEFINED__
#define __BIT_TYPES_DEFINED__
#endif

#ifndef _INT8_T_DEFINED_
#define _INT8_T_DEFINED_
typedef int8_t __int8_t        ;
#endif

#ifndef _UINT8_T_DEFINED_
#define _UINT8_T_DEFINED_
typedef uint8_t __uint8_t       ;
#endif

#ifndef _INT16_T_DEFINED_
#define _INT16_T_DEFINED_
typedef int16_t __int16_t       ;
#endif

#ifndef _UINT16_T_DEFINED_
#define _UINT16_T_DEFINED_
typedef uint16_t __uint16_t      ;
#endif

#ifndef _INT32_T_DEFINED_
#define _INT32_T_DEFINED_
typedef int32_t __int32_t       ;
#endif

#ifndef _UINT32_T_DEFINED_
#define _UINT32_T_DEFINED_
typedef uint32_t __uint32_t      ;
#endif

#ifndef _INT64_T_DEFINED_
#define _INT64_T_DEFINED_
typedef int64_t __int64_t       ;
#endif

#ifndef _UINT64_T_DEFINED_
#define _UINT64_T_DEFINED_
typedef uint64_t __uint64_t      ;
#endif

/* BSD-style unsigned bits types */
typedef __uint8_t   u_int8_t;
typedef __uint16_t  u_int16_t;

typedef __uint32_t  u_int32_t;
typedef __uint64_t  u_int64_t;

/* quads, deprecated in favor of 64 bit int types */
typedef __int64_t   quad_t;
typedef __uint64_t  u_quad_t;
typedef quad_t *    qaddr_t;

#if 0 //__BSD_VISIBLE
/* VM system types */
typedef __vaddr_t   vaddr_t;
typedef __paddr_t   paddr_t;
typedef __vsize_t   vsize_t;
typedef __psize_t   psize_t;
#endif /* __BSD_VISIBLE */

typedef unsigned long   __cpuid_t;  /* CPU id */
typedef __int32_t   __dev_t;    /* device number */
typedef __uint32_t  __fixpt_t;  /* fixed point number */
typedef __uint32_t  __gid_t;    /* group id */
typedef __uint32_t  __id_t;     /* may contain pid, uid or gid */
typedef __uint32_t  __in_addr_t;    /* base type for internet address */
typedef __uint16_t  __in_port_t;    /* IP port type */
typedef __uint32_t  __ino_t;    /* inode number */
typedef long        __key_t;    /* IPC key (for Sys V IPC) */
typedef __uint32_t  __mode_t;   /* permissions */
typedef __uint32_t  __nlink_t;  /* link count */
typedef __int32_t   __pid_t;    /* process id */
typedef __uint64_t  __rlim_t;   /* resource limit */
typedef __uint8_t   __sa_family_t;  /* sockaddr address family type */
typedef __int32_t   __segsz_t;  /* segment size */
typedef __uint32_t  __socklen_t;    /* length type for network syscalls */
typedef __int32_t   __swblk_t;  /* swap offset */
typedef __uint32_t  __uid_t;    /* user id */
typedef __uint32_t  __useconds_t;   /* microseconds */
typedef __int32_t   __suseconds_t;  /* microseconds (signed) */
typedef __uint64_t  __fsblkcnt_t;   /* file system block count */
typedef __uint64_t  __fsfilcnt_t;   /* file system file count */

/*
 * mbstate_t is an opaque object to keep conversion state, during multibyte
 * stream conversions. The content must not be referenced by user programs.
 */
typedef union {
    char __mbstate8[128];
    __int64_t __mbstateL;           /* for alignment */
} __mbstate_t;


/* Standard system types */
#if 0
typedef __gid_t         gid_t;          /* group id                 */
typedef __rlim_t        rlim_t;         /* resource limit           */
typedef __uid_t         uid_t;          /* user id                  */
typedef __suseconds_t   suseconds_t;    /* microseconds (signed)    */
typedef __pid_t         pid_t;          /* process id               */
typedef __mode_t        mode_t;         /* permissions              */
typedef __ino_t         ino_t;          /* inode number             */
typedef __nlink_t       nlink_t;        /* link count               */
typedef __dev_t         dev_t;          /* device number            */
#endif

typedef char *          caddr_t;        /* core address                 */
typedef __int32_t       daddr_t;        /* 32-bit disk address          */
typedef __int32_t       daddr32_t;      /* 32-bit disk address          */
typedef __int64_t       daddr64_t;      /* 64-bit disk address          */
typedef __fixpt_t       fixpt_t;        /* fixed point number           */
typedef __id_t          id_t;           /* may contain pid, uid or gid  */
typedef __key_t         key_t;          /* IPC key (for Sys V IPC)      */
typedef __segsz_t       segsz_t;        /* segment size                 */
typedef __swblk_t       swblk_t;        /* swap offset                  */
typedef __useconds_t    useconds_t;     /* microseconds                 */
typedef __fsblkcnt_t    fsblkcnt_t;     /* file system block count      */
typedef __fsfilcnt_t    fsfilcnt_t;     /* file system file count       */

/*
 * XPG4.2 states that inclusion of <netinet/in.h> must pull these
 * in and that inclusion of <sys/socket.h> must pull in sa_family_t.
 * We put these here because there are other headers that require
 * these types and <sys/socket.h> and <netinet/in.h> will indirectly
 * include <sys/types.h>.
 * XXX - now that we have protected versions these should move.
 */
//typedef __in_addr_t in_addr_t;  /* base type for internet address */
//typedef __in_port_t in_port_t;  /* IP port type */
//typedef __sa_family_t   sa_family_t;    /* sockaddr address family type */
//typedef __socklen_t socklen_t;  /* length type for network syscalls */

#include <netinet/in.h>

/*
 * The following types may be defined in multiple header files.
 */
#ifndef _CLOCK_T_DEFINED_
#define _CLOCK_T_DEFINED_
//typedef __clock_t   clock_t;
#endif

#ifndef _CLOCKID_T_DEFINED_
#define _CLOCKID_T_DEFINED_
//typedef __clockid_t clockid_t;
#endif

#ifndef _SIZE_T_DEF
#define _SIZE_T_DEF
typedef __size_t    size_t;
#endif

#ifndef _SIZE_T_DEF
#define _SIZE_T_DEF
typedef __ssize_t   ssize_t;
#endif

#ifndef _TIME_T_DEFINED_
#define _TIME_T_DEFINED_
//typedef __time_t    time_t;
#endif

#ifndef _TIMER_T_DEFINED_
#define _TIMER_T_DEFINED_
//typedef __timer_t   timer_t;
#endif

#ifndef _OFF_T_DEFINED_
#define _OFF_T_DEFINED_
//typedef __off_t     off_t;
#endif

#if __BSD_VISIBLE
typedef unsigned char   u_char;
typedef unsigned short  u_short;
typedef unsigned int    u_int;
typedef unsigned long   u_long;

typedef unsigned char   unchar;     /* Sys V compatibility */
typedef unsigned short  ushort;     /* Sys V compatibility */
typedef unsigned int    uint;       /* Sys V compatibility */
typedef unsigned long   ulong;      /* Sys V compatibility */

typedef __cpuid_t   cpuid_t;    /* CPU id */
//typedef __register_t    register_t; /* register-sized type */
#endif /* __BSD_VISIBLE */

#if __BSD_VISIBLE
/* Major, minor numbers, dev_t's. */
#define major(x)    ((int32_t)(((u_int32_t)(x) >> 8) & 0xff))
#define minor(x)    ((int32_t)((x) & 0xff) | (((x) & 0xffff0000) >> 8))
//#define makedev(x,y)    ((dev_t)((((x) & 0xff) << 8) | ((y) & 0xff) | (((y) & 0xffff00) << 8)))
#endif

#if __BSD_VISIBLE
#include <sys/select.h> /* must be after type declarations */
#endif

#if defined(__STDC__) && defined(_KERNEL)
/*
 * Forward structure declarations for function prototypes.  We include the
 * common structures that cross subsystem boundaries here; others are mostly
 * used in the same place that the structure is defined.
 */
struct  proc;
struct  pgrp;
struct  ucred;
struct  rusage;
struct  file;
struct  buf;
struct  tty;
struct  uio;
#endif

// From usbdi.h
struct usb_devno {
    u_int16_t ud_vendor;
    u_int16_t ud_product;
};

#include <sys/queue.h>


#define satosin(sa) ((struct sockaddr_in *)(sa))
#define satosin6(sa)    ((struct sockaddr_in6 *)(sa))

unsigned int min(unsigned int a, unsigned int b);

#define SET(t, f)   ((t) |= (f))
#define CLR(t, f)   ((t) &= ~(f))
#define ISSET(t, f) ((t) & (f))

/* Bit map related macros. */
#define setbit(a,i) ((a)[(i)>>3] |= 1<<((i)&(NBBY-1)))
#define clrbit(a,i) ((a)[(i)>>3] &= ~(1<<((i)&(NBBY-1))))
#define isset(a,i)  ((a)[(i)>>3] & (1<<((i)&(NBBY-1))))
#define isclr(a,i)  (((a)[(i)>>3] & (1<<((i)&(NBBY-1)))) == 0)

/* Macros for counting and rounding. */
#ifndef howmany
#define howmany(x, y)   (((x)+((y)-1))/(y))
#endif
#define roundup(x, y)   ((((x)+((y)-1))/(y))*(y))
#define powerof2(x) ((((x)-1)&(x))==0)

/* Macros for min/max. */
#define MIN(a,b) (((a)<(b))?(a):(b))
#define MAX(a,b) (((a)>(b))?(a):(b))

/* Macros for calculating the offset of a field */
#if !defined(offsetof) && defined(_KERNEL)
#define offsetof(s, e) ((size_t)&((s *)0)->e)
#endif

#define LLADDR(s) ((caddr_t)((s)->sdl_data + (s)->sdl_nlen))

#define ETHER_ADDR_LEN  6   /* Ethernet address length      */
#define ETHER_IS_MULTICAST(addr) (*(addr) & 0x01) /* is address mcast/bcast? */


// From: sys/param.h
#define nitems(_a)      (sizeof((_a)) / sizeof((_a)[0]))


 extern unsigned char etherbroadcastaddr[ETHER_ADDR_LEN];

 void splx(int32_t intr);
 int  splnet(void);
 void Init_BSD_Subystem(void);


extern struct  ifqueue bsdInputQ;
extern pthread_cond_t  usbMacInputQ_cond;
extern pthread_mutex_t usbMacInputQ_mutex;
extern pthread_mutex_t usbMacOutputQ_mutex;

extern pthread_mutex_t mbuf_Free_mutex;
extern pthread_mutex_t mbuf_Alloc_mutex;


#endif /* !_SYS_TYPES_H_ */

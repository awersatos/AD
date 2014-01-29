/******************************************************************************
|*
|* COPYRIGHT:   Copyright (c) 2008, ALtium
|*
|* DESCRIPTION: SOCKFS layer over LWIP to implement unified handles
|*
\******************************************************************************/

#ifndef _SOCKFS_H
#define _SOCKFS_H

#include <lwip/sockets.h>

#ifdef  __cplusplus
extern "C" {
#endif

extern int sockfs_accept(int s, struct sockaddr *addr, socklen_t *addrlen);
extern int sockfs_bind(int s, const struct sockaddr *name, socklen_t namelen);
extern int sockfs_shutdown(int s, int how);
extern int sockfs_getpeername (int s, struct sockaddr *name, socklen_t *namelen);
extern int sockfs_getsockname (int s, struct sockaddr *name, socklen_t *namelen);
extern int sockfs_getsockopt (int s, int level, int optname, void *optval, socklen_t *optlen);
extern int sockfs_setsockopt (int s, int level, int optname, const void *optval, socklen_t optlen);
extern int sockfs_connect(int s, const struct sockaddr *name, socklen_t namelen);
extern int sockfs_listen(int s, int backlog);
extern int sockfs_recv(int s, void *mem, size_t len, int flags);
extern int sockfs_recvfrom(int s, void *mem, size_t len, int flags, struct sockaddr *from, socklen_t *fromlen);
extern int sockfs_send(int s, const void *dataptr, size_t size, int flags);
extern int sockfs_sendto(int s, const void *dataptr, size_t size, int flags, const struct sockaddr *to, socklen_t tolen);
extern int sockfs_socket(int domain, int type, int protocol);
extern int sockfs_select(int maxfdp1, fd_set *readset, fd_set *writeset, fd_set *exceptset, struct timeval *timeout);
extern int sockfs_ioctl(int s, long cmd, void *argp);

#ifdef  __cplusplus
}
#endif

#endif

/******************************************************************************
|*
|* COPYRIGHT:   Copyright (c) 2008, ALtium
|*
|* DESCRIPTION: Virtual socket file system.
|*
\******************************************************************************/

#include <assert.h>
#include <errno.h>
#include <string.h>
#include <fsio.h>

#include <lwip/sockets.h>

#include <sockfs.h>

/* supported fs ops */

static int sockfs_mount( mount_t * restrict mount );
static int sockfs_open( mount_t * restrict mount, const char *name, unsigned int flags, file_t *file );

/* supported file ops */

static int sockfs_read( file_t *file, ioreq_t *iorx );
static int sockfs_write( file_t *file, ioreq_t *iotx );
static int sockfs_close( file_t *file );

/* file system implementation */

static const fs_t sockfs = {
    "sockfs",
    fs_mkfs_notsup,
    sockfs_mount,
    fs_unmount_notsup,
    sockfs_open,
#if ( __POSIX_MAPPED_FILES != 0 )
    fs_munmap_notsup,
#endif
    fs_unlink_notsup,
    fs_stat_notsup,
    fs_opendir_notsup,
    fs_mkdir_notsup,
    fs_rmdir_notsup,
    fs_chdir_notsup,
    fs_getcwd_notsup,
    fs_rename_notsup,
    fs_remove_notsup,
    fs_open_dirent_notsup
};

// file operations (including directories and devices)
// NOTE: the file operations defined here require a file descriptor
static const fileops_t sockfs_fileops = {
    sockfs_read,
    sockfs_write,
#if ( __POSIX_MAPPED_FILES != 0 )
    f_mmap_notsup,
#endif
    f_lseek_notsup,
    f_flush_notsup,
    f_fstat_notsup,
    f_ctl_notsup,
    sockfs_close,

    /* eCOS overloads read/lseek/close for this */
    f_readdir_notsup,
    f_rewinddir_notsup,
    f_closedir_notsup
};


static int lwip2unified[MEMP_NUM_NETCONN];


/*
 * Plugin initialization
 */
extern void sockfs_plugin_init( void )
{
    register_fs( &sockfs );
    mount( "", "/sock", sockfs.name, 0, MOUNT_FLAG_RDONLY );

    for (int i = 0; i < MEMP_NUM_NETCONN; ++i) lwip2unified[i] = -1;
}


/*
 * filesystem operations
 */

static int sockfs_mount( mount_t * restrict mount )
{
    // nothing to do
    return 0;
}


// open() is not intended for the enduser, used internally by lwip socket layer
static int sockfs_open( mount_t * restrict mount, const char *name, unsigned int flags, file_t *file )
{
    file->name = NULL;
    file->ops  = &sockfs_fileops;
    file->data = (void *) -1;

    return 0;
}


/*
 * file operations
 */

static int sockfs_read(file_t *file, ioreq_t *iorx)
{
    int sock = (int) file->data;
    int cnt = lwip_read(sock, iorx->buf, iorx->len);
    if (cnt < 0) return errno ? errno : -1;
    iorx->cnt = cnt;
    return 0;
}

static int sockfs_write(file_t *file, ioreq_t *iotx)
{
    int sock = (int) file->data;
    int cnt = lwip_write(sock, iotx->buf, iotx->len);
    if (cnt < 0) return errno ? errno : -1;
    iotx->cnt = cnt;
    return 0;
}


static int sockfs_close(file_t *file)
{
    int sock = (int) file->data;

    lwip2unified[sock] = -1;

    return lwip_close(sock);
}



/*
 * wrappers over LWIP to supply unified handles
 */


int sockfs_socket(int domain, int type, int protocol)
{
    int fd = open("/sock", 0);

    if (fd < 0) return -1;

    int sock = lwip_socket(domain, type, protocol);

    if (sock < 0)
    {
        // no socket avaible, discard unified handle
        close(fd);
        return -1;
    }

    file_t *file = fs_fd_file(fd);
    file->data = (void*) sock;
    lwip2unified[sock] = fd;

    return fd;
}


int sockfs_accept(int fd, struct sockaddr *addr, socklen_t *addrlen)
{
    file_t *file = fs_fd_file(fd);
    int sock = (int) file->data;

    int newsock = lwip_accept(sock, addr, addrlen);

    if (newsock < 0) return newsock;

    int newfd = open("/sock", 0);

    if (newfd < 0)
    {
        // no unified handle available, discard socket
        lwip_close(newsock);
        return -1;
    }

    file_t *newfile = fs_fd_file(newfd);
    newfile->data = (void*) newsock;
    lwip2unified[newsock] = newfd;

    return newfd;
}


int sockfs_bind(int fd, const struct sockaddr *name, socklen_t namelen)
{
    file_t *file = fs_fd_file(fd);
    int sock = (int) file->data;

    return lwip_bind(sock, name, namelen);
}


int sockfs_shutdown(int fd, int how)
{
    file_t *file = fs_fd_file(fd);
    int sock = (int) file->data;

    return lwip_shutdown(fd, how);
}


int sockfs_getpeername (int fd, struct sockaddr *name, socklen_t *namelen)
{
    file_t *file = fs_fd_file(fd);
    int sock = (int) file->data;

    return lwip_getpeername(sock, name, namelen);
}


int sockfs_getsockname (int fd, struct sockaddr *name, socklen_t *namelen)
{
    file_t *file = fs_fd_file(fd);
    int sock = (int) file->data;

    return lwip_getsockname(sock, name, namelen);
}


int sockfs_getsockopt (int fd, int level, int optname, void *optval, socklen_t *optlen)
{
    file_t *file = fs_fd_file(fd);
    int sock = (int) file->data;

    return lwip_getsockopt(sock, level, optname, optval, optlen);
}


int sockfs_setsockopt (int fd, int level, int optname, const void *optval, socklen_t optlen)
{
    file_t *file = fs_fd_file(fd);
    int sock = (int) file->data;

    return lwip_setsockopt(sock, level, optname, optval, optlen);
}


int sockfs_connect(int fd, const struct sockaddr *name, socklen_t namelen)
{
    file_t *file = fs_fd_file(fd);
    int sock = (int) file->data;

    return lwip_connect(sock, name, namelen);
}


int sockfs_listen(int fd, int backlog)
{
    file_t *file = fs_fd_file(fd);
    int sock = (int) file->data;

    return lwip_listen(sock, backlog);
}


int sockfs_recv(int fd, void *mem, size_t len, int flags)
{
    file_t *file = fs_fd_file(fd);
    int sock = (int) file->data;

    return lwip_recv(sock, mem, len, flags);
}


int sockfs_recvfrom(int fd, void *mem, size_t len, int flags, struct sockaddr *from, socklen_t *fromlen)
{
    file_t *file = fs_fd_file(fd);
    int sock = (int) file->data;

    return lwip_recvfrom(sock, mem, len, flags, from, fromlen);
}


int sockfs_send(int fd, const void *dataptr, size_t size, int flags)
{
    file_t *file = fs_fd_file(fd);
    int sock = (int) file->data;

    return lwip_send(sock, dataptr, size, flags);
}


int sockfs_sendto(int fd, const void *dataptr, size_t size, int flags, const struct sockaddr *to, socklen_t tolen)
{
    file_t *file = fs_fd_file(fd);
    int sock = (int) file->data;

    return lwip_sendto(sock, dataptr, size, flags, to, tolen);
}


int sockfs_ioctl(int fd, long cmd, void *argp)
{
    file_t *file = fs_fd_file(fd);
    int sock = (int) file->data;

    return lwip_ioctl(sock, cmd, argp);
}


static int fdset_unified2lwip(int nfds, fd_set *unified, fd_set *lwip)
{
    int maxsock = 0;

    FD_ZERO(lwip);

    if (unified)
    {
        for(int fd = 0; fd < nfds; fd++)
        {
            if (FD_ISSET(fd, unified))
            {
                file_t *file = fs_fd_file(fd);
                int sock = (int) file->data;

                FD_SET(sock, lwip);

                sock++;
                if (sock > maxsock) maxsock = sock;
            }
        }
    }

    return maxsock;
}


static int fdset_lwip2unified(int nfds, fd_set *lwip, fd_set *unified)
{
    int maxfd = 0;

    FD_ZERO(unified);

    if (unified)
    {
        for(int sock = 0; sock < nfds; sock++)
        {
            if (FD_ISSET(sock, lwip))
            {
                int fd = lwip2unified[sock];

                FD_SET(fd, unified);

                fd++;
                if (fd > maxfd) maxfd = fd;
            }
        }
    }

    return maxfd;
}


int sockfs_select(int nfds, fd_set *readset, fd_set *writeset, fd_set *exceptset, struct timeval *timeout)
{
    fd_set lwip_readset, lwip_writeset, lwip_exceptset;
    int read_nfds, write_nfds, except_nfds, lwip_nfds;

    read_nfds = fdset_unified2lwip(nfds, readset, &lwip_readset);
    write_nfds = fdset_unified2lwip(nfds, writeset, &lwip_writeset);
    except_nfds = fdset_unified2lwip(nfds, exceptset, &lwip_exceptset);

    lwip_nfds = read_nfds;
    if (write_nfds > lwip_nfds) lwip_nfds = write_nfds;
    if (except_nfds > lwip_nfds) lwip_nfds = except_nfds;

    int res = lwip_select(lwip_nfds, readset ? &lwip_readset : NULL, writeset ? &lwip_writeset : NULL, exceptset ? &lwip_exceptset : NULL, timeout);

    fdset_lwip2unified(read_nfds, &lwip_readset, readset);
    fdset_lwip2unified(write_nfds, &lwip_writeset, writeset);
    fdset_lwip2unified(except_nfds, &lwip_exceptset, exceptset);

    return res;
}


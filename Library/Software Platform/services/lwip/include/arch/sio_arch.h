/*
 * arc_sio.h
 *
 *  Created on: 10/08/2009
 *      Author: joseph.thomas-kerr
 */

#ifndef _ARCH_SIO_ARCH_H_
#define _ARCH_SIO_ARCH_H_

// map serial io lwip system calls to modem.h and drv_uart8.h calls
#if PPP_SUPPORT

#include <modem.h>

#define SIO_RECV_FAILED ((u8_t)-1)

#define __sio_fd_t_defined

typedef modem_t * sio_fd_t;
#define sio_open(id)            modem_open(id)
#define sio_send(ch,fd)         modem_send(fd,ch)
#define sio_recv(fd)            modem_recv(fd)
#define sio_read(fd,buf,len)    modem_read(fd,buf,len)
#define sio_write(fd,buf,len)   modem_write(fd,buf,len)
#define sio_read_abort(fd)

#endif

#endif /* _ARCH_SIO_ARCH_H_ */

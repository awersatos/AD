///////////////////////////////////////////////////////////////////////////////
// usbhost_network.h

#ifndef __USBHOST_NETWORK_H
#define __USBHOST_NETWORK_H

#include <stdint.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <assert.h>

#ifdef  __cplusplus
extern "C" {
#endif

#include <swp_ifconfig.h>

#include <net/if.h>

#if __POSIX_KERNEL__
# include <pthread.h>
#else
# include <pal.h>
#endif

#include <interrupts.h>
#include <sysutils.h>

#define USBN_MAX_PACKET_SIZE 1524

///////////////////////////////////////////////////////////////////////////////
struct usbhost_network_s
{
    uint32_t        ident;
    void            *(*get_ifconfig)(void *);

    struct ifnet   *ifp;
    struct mbuf    *sendMBuf;
    struct mbuf    *recvMBuf;
    int             instanceId;
    ifconfig_t      ifconfig;
    int8_t          *passphrase;
    uint8_t         recvBuf[USBN_MAX_PACKET_SIZE];
};

typedef struct usbhost_network_s usbhost_network_t;

///////////////////////////////////////////////////////////////////////////////

extern usbhost_network_t *usbhost_network_open(int id);
extern ifconfig_t *usbhost_network_ifconfig(int id);

///////////////////////////////////////////////////////////////////////////////
extern uint32_t *usbhost_network_corebuf_alloc  (usbhost_network_t * restrict drv, int size);
extern void      usbhost_network_corebuf_send   (usbhost_network_t * restrict drv, uint32_t *corebuf);
extern uint32_t *usbhost_network_corebuf_receive(usbhost_network_t * restrict drv);
extern void      usbhost_network_corebuf_free   (usbhost_network_t * restrict drv, uint32_t *corebuf);
extern int       usbhost_network_send           (usbhost_network_t * restrict drv, uint8_t *buf, int size);
extern int       usbhost_network_receive        (usbhost_network_t * restrict drv, uint8_t *buf, int size);
extern void      usbhost_network_setmode        (usbhost_network_t * restrict drv, uint32_t rx_cmd, uint32_t tx_cmd);
extern void      usbhost_network_setmac         (usbhost_network_t * restrict drv, const uint8_t *mac);
extern void      usbhost_network_getmac         (usbhost_network_t * restrict drv, uint8_t *mac);

extern int       usbhost_network_driver_link_get_state(usbhost_network_t *drv, uint32_t *state);

#ifdef  __cplusplus
}
#endif

#endif // __USBHOST_NETWORK_H

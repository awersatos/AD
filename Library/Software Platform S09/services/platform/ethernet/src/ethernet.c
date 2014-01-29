/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2008, Altium
|*
|*  Description:    ETHERNET services: Generic Interface
|*
\*****************************************************************************/

#include <stdlib.h>
#include <string.h>
#include <assert.h>

#include <stdbool.h>
#include <stdint.h>
#include <ethernet.h>
#include <ethernet_i.h>

#include <ethernet_cfg.h>
#include <ethernet_cfg_instance.h>


ethernet_t ethernet_table[ETHERNET_INSTANCE_COUNT];


//*** zero-copy interface **********************************************************

/**
 * @brief Allocate an empty sendbuffer
 *
 * Returns pointer to free core buffer (uint32 size plus ethernetframe) for packet
 * with given frame size, initialized with originating MAC.
 * After allocating a buffer must be send using ethernet_corebuf_send().
 * Part of the zero-copy interface.
 *
 * @param      srv         valid ethernet service pointer
 * @param      datasize    size of packet (including ethernet header) to send
 *
 * @return     pointer to core buffer, NULL if not enough free space available
 *
 * @see        ethernet_corebuf_send
 */
extern uint32_t *ethernet_corebuf_alloc(ethernet_t * restrict srv, int datasize)
{
    return srv->corebuf_alloc(srv->drv, datasize);
}


/**
 * @brief Transmit a sendbuffer
 *
 * Send corebuffer (uint32 size plus ethernetframe).
 * The corebuffer must be the one returned from last ethernet_corebuf_alloc() call.
 * Part of the zero-copy interface.
 *
 * @param      srv       valid ethernet service pointer
 * @param      corebuf   pointer to corebuffer last allocated
 *
 * @return     void
 *
 * @see        ethernet_corebuf_alloc
 */
extern void ethernet_corebuf_send(ethernet_t * restrict srv, uint32_t *corebuf)
{
    srv->corebuf_send(srv->drv, corebuf);
}


/**
 * @brief Get a receivebuffer if available
 *
 * Returns pointer to corebuffer (uint32 size plus ethernetframe) with next
 * received packet.
 * After receiving a buffer must be freed using emac32_corebuf_free().
 * Part of the zero-copy interface.
 *
 * @param      srv           valid ethernet service pointer
 *
 * @return     pointer to corebuffer, NULL none available
 *
 * @see        ethernet_corebuf_free
 */
extern uint32_t *ethernet_corebuf_receive(ethernet_t * restrict srv)
{
    return srv->corebuf_receive(srv->drv);
}


/**
 * @brief Release a receivebuffer
 *
 * Release corebuffer (uint32 size plus ethernetframe).
 * The corebuffer must be the one returned from last ethernet_corebuf_receive() call.
 * Part of the zero-copy interface.
 *
 * @param      srv       valid ethernet service pointer
 * @param      corebuf   pointer to corebuffer last received
 *
 * @return     void
 *
 * @see        ethernet_corebuf_receive
 */
extern void ethernet_corebuf_free(ethernet_t * restrict srv, uint32_t *corebuf)
{
    srv->corebuf_free(srv->drv, corebuf);
}


//*** copying interface **********************************************************

/**
 * @brief Transmit data
 *
 * Send packet, data is copied to core buffer.
 * Part of the copying interface.
 *
 * @param      srv        valid ethernet service pointer
 * @param      buf        user supplied buffer containing ethernet frame
 *                        (use 16-bit or 32-bit aligned buffers to speed up copying)
 * @param      size       number of bytes to send
 *
 * @return     size of data send, -1 for error
 */
extern int ethernet_send(ethernet_t * restrict srv, uint8_t *buf, int size)
{
    return srv->send(srv->drv, buf, size);
}


/**
 * @brief Receive data if available
 *
 * Get received ethernet frame, data is copied to user buffer.
 * Part of the zero-copy interface.
 *
 * @param      srv        valid ethernet service pointer
 * @param      buf        user supplied buffer to store received data
 *                        (use 16-bit or 32-bit aligned buffers to speed up copying)
 * @param      size       size of buffer
 *
 * @return     size of data received (might be more than what was copied in buffer), 0 for no data
 */
extern int ethernet_receive(ethernet_t * restrict srv, uint8_t *buf, int size)
{
    return srv->receive(srv->drv, buf, size);
}


/**
 * @brief Set MAC address
 *
 * Set a new MAC address as given in the buffer @em mac.
 *
 * @param      srv           valid ethernet service pointer
 * @param      mac           6-byte array with new receiver MAC address
 *
 * @return     Nothing.
 */
extern void ethernet_setmac(ethernet_t * restrict srv, const uint8_t *mac)
{
    srv->setmac(srv->drv, mac);
}


/**
 * @brief Get MAC address
 *
 * Copy the current MAC address to the buffer @em mac.
 *
 * @param      srv           valid ethernet service pointer
 * @param      mac           pointer to 6-byte array where current MAC address will be stored
 *
 * @return     Nothing.
 */
extern void ethernet_getmac(ethernet_t * restrict srv, uint8_t *mac)
{
    srv->getmac(srv->drv, mac);
}


/**
 * @brief Open the service
 *
 * Open an instance of the service. This function must be called once before any other
 * service function can be used.
 *
 * @param      id    valid drv id
 *
 * @return     service pointer if ok, otherwise NULL
 */
extern ethernet_t * ethernet_open(int id)
{
    assert((id >= 0) && (id < ETHERNET_INSTANCE_COUNT));

    ethernet_t * restrict ethernet;
    void *drv;

    ethernet = &ethernet_table[id];

    drv = ethernet->open(ethernet->drv_id);

    if (drv == NULL) return NULL;

    ethernet->drv = drv;

    return ethernet;
}



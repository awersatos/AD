/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2010, Altium
|*
|*  Description:        EMAC32 driver
|*
\*****************************************************************************/

#include <stddef.h>
#include <stdint.h>
#include <string.h>
#include <assert.h>
#include <util_endian.h>

#include <swp_ifconfig.h>

#include "drv_emac32.h"
#include "drv_emac32_internal.h"

#define EMAC32_IDENT IFCONFIG_SIGNATURE

/*
 * runtime driver properties,
 * compiletime properties and buffers are
 * located in drv_emac32_instance_cfg[]
 */
static emac32_t emac32_table[DRV_EMAC32_INSTANCE_COUNT];

/* 32bit memcpy */
static void memcpyfast(void* restrict destination, const void* restrict source, size_t num)
{
    uintptr_t dst = (uintptr_t) destination;
    uintptr_t src = (uintptr_t) source;

    if (((dst & 3) == 0) && ((src & 3) == 0))
    {
        while (num > 3)
        {
            *(uint32_t*) dst = *(uint32_t*) src;
            dst += 4;
            src += 4;
            num -= 4;
        }
    }
    else if (((dst & 1) == 0) && ((src & 1) == 0))
    {
        while (num > 1)
        {
            *(uint16_t*) dst = *(uint16_t*) src;
            dst += 2;
            src += 2;
            num -= 2;
        }
    }

    while (num > 0)
    {
        *(uint8_t*) dst = *(uint8_t*) src;
        dst += 1;
        src += 1;
        num -= 1;
    }
}


/*
 * ifconfig API
 */

int ifconfig_emac32_link_get_state(ifconfig_t *ifcfg, uint32_t *state)
{
    emac32_t *drv = (emac32_t *)ifcfg->priv;

    if(drv)
    {
        *state = drv->linkstatus(drv) & PHY_VALID_LINK ?  IFCONFIG_LINK_S_UP : IFCONFIG_LINK_S_DOWN;
    } 
    else 
    {
        *state = IFCONFIG_S_UNKNOWN;
    }

    return 0;
}


static int ifconfig_emac32_phy_get_state(ifconfig_t *ifcfg, uint32_t *state)
{
    // emac core is always available
    *state = IFCONFIG_PHY_S_AVAILABLE;
    return 0;
}


static int ifconfig_emac32_setmac(ifconfig_t *ifcfg, const uint8_t *mac)
{
    emac32_t *drv = (emac32_t *)ifcfg->priv;
    emac32_setmac(drv, mac);
    return 0;
}


static int ifconfig_emac32_getmac(ifconfig_t *ifcfg, uint8_t *mac)
{
    emac32_t *drv = (emac32_t *)ifcfg->priv;
    emac32_getmac(drv, mac);
    return 0;
}


static ifconfig_phy_t emac32_phy_ifconfig =
{
    &ifconfig_emac32_phy_get_state,     // get_state
    &ifconfig_emac32_setmac,            // set_mac
    &ifconfig_emac32_getmac             // get_mac
};


static ifconfig_link_t emac32_link_ifconfig =
{  
    &ifconfig_emac32_link_get_state,    // get_state
    NULL,                               // start
    NULL,                               // stop
    NULL,                               // state_callback
    NULL                                // state_callback_context
};


static void *emac32_get_ifconfig(void *inst)
{
    emac32_t *drv = inst;

    if(drv){
        return &drv->ifconfig;
    }

    return NULL;
}


/*
 * Public API
 */

/**
 * @brief Initialize the driver
 *
 * This function initializes driver resources and connects the interrupt
 * handler.  Subsequent calls to this function will simply return a pointer
 * to the initialized driver.
 *
 * @param      id    valid driver id (see devices.h)
 *
 * @return     Driver pointer if ok, or NULL otherwise
 */
extern emac32_t *emac32_open(unsigned int id)
{
    emac32_t * restrict drv = &emac32_table[id];

    if (id >= DRV_EMAC32_INSTANCE_COUNT)
        return NULL;

    if (drv->baseaddress == 0) // initialize only once
    {
        const drv_emac32_cfg_instance_t * restrict drv_cfg = &drv_emac32_instance_table[id];
        const per_emac32_cfg_instance_t * restrict per_cfg = &per_emac32_instance_table[drv_cfg->per_emac32];

        // copy peripheral configuration needed to driver
        assert(per_cfg->baseaddress != 0);
        drv->baseaddress = per_cfg->baseaddress;
        drv->interrupt   = per_cfg->interrupt0;
        drv->phy         = per_cfg->phy;

        // MAC address
        memcpy(drv->mac, drv_cfg->mac, MAC_SIZE);

        // TX
        drv->tx_cmd             = drv_cfg->tx_cmd;
#if __POSIX_KERNEL__
        drv->tx_wait_mode       = drv_cfg->tx_wait_mode;
# if TX_KERNEL_WAIT_SLEEP
        drv->tx_wait_sleepms    = drv_cfg->tx_wait_sleepms;
# endif
#else // no kernel
        drv->tx_blocking        = drv_cfg->tx_blocking;
#endif

        // RX
        drv->rx_cmd             = drv_cfg->rx_cmd;
#if __POSIX_KERNEL__
        drv->rx_wait_mode       = drv_cfg->rx_wait_mode;
# if RX_KERNEL_WAIT_SLEEP
        drv->rx_wait_sleepms    = drv_cfg->rx_wait_sleepms;
# endif
#else
        drv->rx_blocking        = drv_cfg->rx_blocking;
#endif

        drv->linkstatus       = drv_cfg->linkstatus;

#if USE_MUTEX
# if DRV_EMAC32_USE_MUTEX_FALSE_USED
        if (drv->use_mutex)
# endif
        {
            pthread_mutexattr_t mutexattr;
            pthread_mutexattr_init(&mutexattr);

            pthread_mutex_init(&drv->tx_mutex, &mutexattr);
            pthread_mutex_init(&drv->rx_mutex, &mutexattr);
        }
#endif

         EMAC32_TX_MUTEX_PREPARE();
         EMAC32_RX_MUTEX_PREPARE();
         EMAC32_TX_MUTEX_LOCK(drv);
         EMAC32_RX_MUTEX_LOCK(drv);

        // endianness
#ifdef __LITTLE_ENDIAN__
        EMAC32_VERSION(drv->baseaddress) |=  EMAC32_LITTLE_ENDIAN;    // set little_endian bit. only supported in version 4 and higher, older cores will ignore this
#else
        EMAC32_VERSION(drv->baseaddress) &= ~EMAC32_LITTLE_ENDIAN;    // clear little-endian bit
#endif

        // reset EMAC
        EMAC32_TX_CMD(drv->baseaddress)    = EMAC32_TX_CMD_RESET;
        EMAC32_RX_CMD(drv->baseaddress)    = EMAC32_RX_CMD_RESET;
        EMAC32_MDI_CMD(drv->baseaddress)   = EMAC32_MDI_CMD_RESET;
        EMAC32_TX_CMD(drv->baseaddress)    = 0;
        EMAC32_RX_CMD(drv->baseaddress)    = 0;
        EMAC32_MDI_CMD(drv->baseaddress)   = 0;

        // set MAC address
        EMAC32_RX_MAC1(drv->baseaddress)   =  ((uint32_t) drv->mac[0] << 24) | (((uint32_t) drv->mac[1]) << 16) |
                                               (((uint32_t) drv->mac[2]) << 8) | (((uint32_t) drv->mac[3]) << 0);
        EMAC32_RX_MAC2(drv->baseaddress)   =  ((uint32_t) drv->mac[4] << 8) | (((uint32_t) drv->mac[5]) << 0);

        // set external buffer registers
        EMAC32_TX_START(drv->baseaddress)  = (int32_t) drv_cfg->tx_buffer;
        EMAC32_TX_END(drv->baseaddress)    = (int32_t) drv_cfg->tx_buffer + (drv_cfg->tx_buffer_size << 2) - 4;
        EMAC32_TX_INPUT(drv->baseaddress)  = (int32_t) drv_cfg->tx_buffer;
        EMAC32_TX_OUTPUT(drv->baseaddress) = (int32_t) drv_cfg->tx_buffer;
        EMAC32_RX_START(drv->baseaddress)  = (int32_t) drv_cfg->rx_buffer;
        EMAC32_RX_END(drv->baseaddress)    = (int32_t) drv_cfg->rx_buffer + (drv_cfg->rx_buffer_size << 2) - 4;
        EMAC32_RX_INPUT(drv->baseaddress)  = (int32_t) drv_cfg->rx_buffer;
        EMAC32_RX_OUTPUT(drv->baseaddress) = (int32_t) drv_cfg->rx_buffer;

        // interrupts
        emac32_connect_interrupts(drv);

        // Enable ifconfig interface support
        drv->ifconfig.if_phy  = &emac32_phy_ifconfig;
        drv->ifconfig.if_link = &emac32_link_ifconfig;
        drv->ifconfig.priv = drv;
        drv->get_ifconfig = &emac32_get_ifconfig;
        drv->ident = EMAC32_IDENT;
        
        // we're done
        EMAC32_TX_CMD(drv->baseaddress) = drv->tx_cmd;
        EMAC32_RX_CMD(drv->baseaddress) = drv->rx_cmd;

        EMAC32_TX_MUTEX_UNLOCK(drv);
        EMAC32_RX_MUTEX_UNLOCK(drv);
    }
    return drv;
}

/**
 * @brief Change receive and transmit modes
 *
 * Sets the receive mode to @em rx_cmd and the transmit mode to @em tx_cmd.
 *
 * @param      drv           valid emac32 driver pointer
 * @param      rx_cmd        receive mode (see RX_CMD register documentation)
 * @param      tx_cmd        transmit mode (see TX_CMD register documentation)
 *
 * @return     Nothing.
 */
extern void emac32_setmode(emac32_t * restrict drv, uint32_t rx_cmd, uint32_t tx_cmd)
{
    assert(drv != NULL);

    // reset EMAC
    EMAC32_RX_CMD(drv->baseaddress)    = 0;
    EMAC32_TX_CMD(drv->baseaddress)    = 0;

    drv->rx_cmd = rx_cmd;
    drv->tx_cmd = tx_cmd;

    EMAC32_RX_CMD(drv->baseaddress)    = rx_cmd;
    EMAC32_TX_CMD(drv->baseaddress)    = tx_cmd;
}


/**
 * @brief Set MAC address
 *
 * Set a new MAC address as given in the buffer @em mac.
 *
 * @param      drv           valid emac32 driver pointer
 * @param      mac           6-byte array with new receiver MAC address
 *
 * @return     Nothing.
 */
extern void emac32_setmac(emac32_t * restrict drv, const uint8_t *mac)
{
    assert(drv != NULL);

    uint32_t rx_cmd_org = EMAC32_RX_CMD(drv->baseaddress);

    if (rx_cmd_org & EMAC32_RX_CMD_ENABLE)
    {
        // MAC changes are only accepted when receiver is inactive
        EMAC32_RX_CMD(drv->baseaddress) = 0;
        while (EMAC32_RX_STATUS(drv->baseaddress) & EMAC32_RX_STATUS_BUSY) {}
    }

    // set MAC address
    EMAC32_RX_MAC1(drv->baseaddress) = ((uint32_t) mac[0] << 24) | (((uint32_t) mac[1]) << 16) |
                                        (((uint32_t) mac[2]) << 8) | (((uint32_t) mac[3]) << 0);
    EMAC32_RX_MAC2(drv->baseaddress) = ((uint32_t) mac[4] << 8) | (((uint32_t) mac[5]) << 0);

    EMAC32_RX_CMD(drv->baseaddress)  = rx_cmd_org;

    memcpy(drv->mac, mac, MAC_SIZE);
}


/**
 * @brief Get MAC address
 *
 * Copy the current MAC address to the buffer @em mac.
 *
 * @param      drv           valid emac32 driver pointer
 * @param      mac           pointer to 6-byte array where current MAC address will be stored
 *
 * @return     Nothing.
 */
extern void emac32_getmac(emac32_t * restrict drv, uint8_t *mac)
{
    assert(drv != NULL);

    memcpy(mac, drv->mac, MAC_SIZE);
}


//*** zero-copy interface **********************************************************

/**
 * @brief Allocate an empty sendbuffer
 *
 * Returns pointer to free core buffer (uint32 size plus ethernetframe) for packet
 * with given frame size, initialized with originating MAC.
 * After allocating a buffer must be send using emac32_corebuf_send().
 * Part of the zero-copy interface.
 *
 * @param      drv         valid emac32 driver pointer
 * @param      size        size of packet (including ethernet header) to send
 *
 * @return     pointer to core buffer, NULL if not enough free space available
 *
 * @see        emac32_corebuf_send
 */
extern uint32_t *emac32_corebuf_alloc(emac32_t * restrict drv, int size)
{
    uint32_t *corebuf;

    assert(drv != NULL);

    // core limit
    if (size > MAX_FRAME_SIZE)
    {
        return NULL;
    }

    EMAC32_TX_MUTEX_PREPARE();
    EMAC32_TX_MUTEX_LOCK(drv);

    corebuf = emac32_transmit_getbuf(drv, size);

// prevent compiler warning
#if ( TX_WAIT_ALWAYS_BLOCK != 1 )
    if (corebuf)
#endif
    {
         memcpy(((emac32_buf_t *) corebuf)->sourcemac, drv->mac, MAC_SIZE);
    }

    EMAC32_TX_MUTEX_UNLOCK(drv);

    return corebuf;
}



/**
 * @brief Transmit a sendbuffer
 *
 * Send corebuffer (uint32 size plus ethernetframe).
 * The corebuffer must be the one returned from last emac32_corebuf_alloc() call.
 * Part of the zero-copy interface.
 *
 * @param      drv       valid emac32 driver pointer
 * @param      corebuf   pointer to corebuffer last allocated
 *
 * @return     void
 *
 * @see        emac32_corebuf_alloc
 */
extern void emac32_corebuf_send(emac32_t * restrict drv, uint32_t *corebuf)
{
    assert(drv != NULL);

    EMAC32_TX_MUTEX_PREPARE();
    EMAC32_TX_MUTEX_LOCK(drv);
    emac32_txbuffer_send(drv, corebuf);
    EMAC32_TX_MUTEX_UNLOCK(drv);
}


/**
 * @brief Get a receivebuffer if available
 *
 * Returns pointer to corebuffer (uint32 size plus ethernetframe) with next
 * received packet.
 * After receiving a buffer must be freed using emac32_corebuf_free().
 * Part of the zero-copy interface.
 *
 * @param      drv           valid emac32 driver pointer
 *
 * @return     pointer to corebuffer, NULL none available
 *
 * @see        emac32_corebuf_free
 */
extern uint32_t *emac32_corebuf_receive(emac32_t * restrict drv)
{
    assert(drv != NULL);

    uint32_t *corebuf;

    EMAC32_RX_MUTEX_PREPARE();
    EMAC32_RX_MUTEX_LOCK(drv);
    corebuf = emac32_receive_getbuf(drv);
    EMAC32_RX_MUTEX_UNLOCK(drv);

    return corebuf;
}


/**
 * @brief Release a receivebuffer
 *
 * Release corebuffer (uint32 size plus ethernetframe).
 * The corebuffer must be the one returned from last emac32_corebuf_receive() call.
 * Part of the zero-copy interface.
 *
 * @param      drv       valid emac32 driver pointer
 * @param      corebuf   pointer to corebuffer last received
 *
 * @return     void
 *
 * @see        emac32_corebuf_receive
 */
extern void emac32_corebuf_free(emac32_t * restrict drv, uint32_t *corebuf)
{
    assert(drv != NULL);

    EMAC32_RX_MUTEX_PREPARE();
    EMAC32_RX_MUTEX_LOCK(drv);
    emac32_rxbuffer_free(drv->baseaddress, corebuf);
    EMAC32_RX_MUTEX_UNLOCK(drv);
}


//*** copying interface **********************************************************


/**
 * @brief Transmit data
 *
 * Send packet, data is copied to core buffer.
 * Part of the copying interface.
 *
 * @param      drv        valid emac32 driver pointer
 * @param      buf        user supplied buffer containing ethernet frame
 *                        (use 16-bit or 32-bit aligned buffers to speed up copying)
 * @param      size       number of bytes to send
 *
 * @return     size of data send, -1 for error
 */
extern int emac32_send(emac32_t * restrict drv, uint8_t *buf, int size)
{
    uint32_t *corebuf;

    assert(drv != NULL);

    // core limit
    if (size > MAX_FRAME_SIZE)
    {
        return -1;
    }

    EMAC32_TX_MUTEX_PREPARE();
    EMAC32_TX_MUTEX_LOCK(drv);
    corebuf = emac32_transmit_getbuf(drv, size);
// prevent compiler warning
#if ( TX_WAIT_ALWAYS_BLOCK != 1 )
    if (corebuf)
#endif
    {
        memcpyfast(corebuf + 1, buf, size);
        memcpy(((emac32_buf_t *) corebuf)->sourcemac, drv->mac, MAC_SIZE);
        emac32_txbuffer_send(drv, corebuf);
    }
#if ( TX_WAIT_ALWAYS_BLOCK != 1 )
    else
    {
        size = -1;
    }
#endif    
    EMAC32_TX_MUTEX_UNLOCK(drv);

    return size;
}


/**
 * @brief Receive data if available
 *
 * Get received ethernet frame, data is copied to user buffer.
 * Part of the zero-copy interface.
 *
 * @param      drv        valid emac32 driver pointer
 * @param      buf        user supplied buffer to store received data
 *                        (use 16-bit or 32-bit aligned buffers to speed up copying)
 * @param      size       size of buffer
 *
 * @return     size of data received (might be more than what was copied in buffer), 0 for no data
 */
extern int emac32_receive(emac32_t * restrict drv, uint8_t *buf, int size)
{
    uint32_t *corebuf;
    int copysize = 0;

    assert(drv != NULL);

    // core limit
    if (size > MAX_FRAME_SIZE)
    {
        return 0;
    }

    EMAC32_RX_MUTEX_PREPARE();
    EMAC32_RX_MUTEX_LOCK(drv);
    corebuf = emac32_receive_getbuf(drv);
// prevent compiler warning
#if ( RX_WAIT_ALWAYS_BLOCK != 1 )
    if (corebuf)
#endif
    {
        copysize = *corebuf;

        if (size > copysize) size = copysize;

        memcpyfast(buf, corebuf + 1, size);

        emac32_rxbuffer_free(drv->baseaddress, corebuf);
    }
    EMAC32_RX_MUTEX_UNLOCK(drv);

    return copysize;
}


/**
 * @brief Read md register
 *
 * Read management data register
 *
 * @param      drv           valid emac32 driver pointer
 * @param      reg           md register address
 *
 * @return     md register value.
 */
extern uint16_t emac32_read_md(emac32_t * restrict drv, uint8_t reg )
{
    uintptr_t base = drv->baseaddress;
    uint16_t  result;

    EMAC32_MDI_LOCK(base);
    while ( EMAC32_MDI_CMD(base)) __nop();
    EMAC32_MDI_PHYADDR(base) = (uint32_t)drv->phy;
    EMAC32_MDI_REGADDR(base) = (uint32_t)reg;
    EMAC32_MDI_DATA(base) = 1 << 11;
    EMAC32_MDI_CMD(base) = EMAC32_MDI_CMD_READ;
    while ( EMAC32_MDI_CMD(base) ) __nop();
    result = (uint16_t)EMAC32_MDI_DATA(base);
    EMAC32_MDI_UNLOCK(base);
    return result;
}


/**
 * @brief Write md register
 *
 * Write Management data register
 *
 * @param      drv           valid emac32 driver pointer
 * @param      reg           md register address
 * @param      data          new md register value
 *
 * @return     Nothing.
 */
extern void emac32_write_md( emac32_t * restrict drv, uint8_t reg, uint16_t data )
{
    uintptr_t base = drv->baseaddress;

    EMAC32_MDI_LOCK(base);
    while ( EMAC32_MDI_CMD(base)) __nop();
    EMAC32_MDI_PHYADDR(base) = (uint32_t)drv->phy;
    EMAC32_MDI_REGADDR(base) = (uint32_t)reg;
    EMAC32_MDI_DATA(base) = (uint32_t)data;
    EMAC32_MDI_CMD(base) = EMAC32_MDI_CMD_WRITE;
    while ( EMAC32_MDI_CMD(base) );
    EMAC32_MDI_UNLOCK(base);
}


/**
 * @brief Get Link status
 *
 * Get current link status. The return value is a combination of the following flags:
 * PHY_VALID_LINK
 * PHY_FULL_DUPLEX,
 * PHY_LINK_100MB,
 * PHY_AUTO_NEG_COMPLETE and
 * PHY_JABBER.
 * Support for PHY_LINK_100MB, PHY_AUTO_NEG_COMPLETE and PHY_JABBER is optional.
 *
 * @param      drv           valid emac32 driver pointer
 *
 * @return     Link Status.
 */
uint8_t emac32_linkstatus(emac32_t *restrict drv)
{
    return drv->linkstatus(drv);
}

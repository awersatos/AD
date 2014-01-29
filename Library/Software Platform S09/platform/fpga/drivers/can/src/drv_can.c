/*****************************************************************************\
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  IN PACKAGE:         CAN device driver
|*
|*  COPYRIGHT:          Copyright (c) 2008, Altium
|*
|*  Description:        Interface to WB_CAN device driver
|*
\*****************************************************************************/
#include <stdlib.h>

#include <interrupts.h>
#include <timing.h>
#include <assert.h>
#include "per_can.h"
#include "drv_can.h"

//#define CAN_DEBUG

// runtime driver table
static can_t can_driver_table[DRV_CAN_INSTANCE_COUNT];

void drv_can_init(void)
{
    __nop();
}


/**
 * @brief Change the baudrate of the device
 *
 * @param       base       device base address
 * @param       fclk       device clock frequency
 * @param       baudrate   requested baudrate
 *
 * @return      set baudrate
 */
uint32_t set_baudrate(uintptr_t base, uint32_t fclk, int baudrate)
{
    uint32_t ret = CAN_BAUD_ERR;
    char i;
    char best_quanta = 0;
    int32_t bpr;       // baudrate prescaler
    int32_t diff;
    uint32_t best_diff = 0xFFFFFFFF;

    // switch to reset mode to get access to the configuration registers
    CAN_MOD(base) = MOD_RM;
    // donot output clock on CLK_OUT
    CAN_CDR(base) = 0xC8;
    // calculate best fitting values for bpr and number of time-quanta per bit
    for (i = 25; i > 2; i--)
    {
        // calculate parameters
        bpr = (fclk / 2) / (int32_t)(baudrate * i);
        diff = (bpr * baudrate * i) - (fclk / 2);
        if (diff < 0)
        {
            diff = -diff;
        }

        if ((diff < best_diff) && (bpr < 32)) // better fit?
        {
            best_diff = diff;
            best_quanta = i;
        }
    }

    // set bit timing registers
    if (best_quanta >= 20)
    {
        // sample point 4 time-quanta before end
        bpr = (fclk / 2) / (int32_t)(baudrate * (int32_t)best_quanta);
        CAN_BTR0(base) = (char)bpr - 1;
        CAN_BTR1(base) = 15 + ((best_quanta - 18) << 4);

        ret = (fclk / 2) / ((3 + (CAN_BTR1(base) & 0x0F) + \
              ((CAN_BTR1(base) >> 4) & 0x07)) * (CAN_BTR0(base) + 1));
    }
    else if (best_quanta >= 6)
    {
        // sample point 2 time-quanta before end
        bpr = (fclk / 2) / (int32_t)(baudrate * (int32_t)best_quanta);
        CAN_BTR0(base) = (char)bpr - 1;
        CAN_BTR1(base) = best_quanta - 4 + (1 << 4);

        ret = (fclk / 2) / ((3 + (CAN_BTR1(base) & 0x0F) + \
              ((CAN_BTR1(base) >> 4) & 0x07)) * (CAN_BTR0(base) + 1));
    }
    else if (best_quanta >= 3)
    {
        // sample point 1 time-quantum before end
        bpr = (fclk / 2) / (int32_t)(baudrate * (int32_t)best_quanta);
        CAN_BTR0(base) = (char)bpr - 1;
        CAN_BTR1(base) = best_quanta - 3;

        ret =   (fclk / 2) / ((3 + (CAN_BTR1(base) & 0x0F) + \
                ((CAN_BTR1(base) & 0x70) >> 4)) * (CAN_BTR0(base) + 1));
    }
    return ret;
}


/**
 *  @brief reset and start the CAN-controller.
 *
 *  @param    drv     pointer to CAN driver structure
 *
 *  @return   CAN_OK if OK, CAN_ERR if not in reset mode at function entry.
 */
int can_reset(can_t * restrict drv)
{
    drv_can_cfg_instance_t * restrict drv_cfg = drv->cfg;
    uintptr_t base = drv->base;
    int ret = CAN_ERR;

    // is the reset bit set?
    if (CAN_MOD(base) & MOD_RM)
    {
        // clear the mode register including the reset bit
        CAN_MOD(base) = 0;
        can_set_state(drv , 0);
        ret = CAN_OK;
    }
    return ret;
}


/**
 *  @brief stop the CAN-controller: enter CAN reset mode
 *
 *  @param     drv           pointer to CAN driver structure
 *
 *  @return    Nothing.
 */
void can_stop(can_t * restrict drv)
{
    drv_can_cfg_instance_t * restrict drv_cfg = drv->cfg;
    uintptr_t base = drv->base;

    // set reset bit
    CAN_MOD(base) = MOD_RM;
    can_set_state(drv, CAN_STBUSOFF);
}

/**
 *  @brief Get can driver state.
 *
 *  In case CAN_STBUSOFF you should can_reset() the driver
 *  to enable the can transceiver again.
 *
 *  @param     drv    pointer to CAN driver structure
 *
 *  @return    dev->state
 */
uint8_t can_get_state(can_t * restrict drv)
{
    return drv->state;
}


/**
 *  @brief Set can driver to required state.
 *
 *  @param     drv    pointer to CAN driver structure
 *  @param     state  required state
 *
 *  @return    Nothing.
 */
void can_set_state(can_t * restrict drv, uint8_t state)
{
    drv->state = state;
}


/**
 * @brief initialize a CAN message object for receiving can messages.
 *
 * initializes first free CAN message object in the receive message object array.
 * Only received messages with the configured canid will be placed in the provided 
 * data buffer.
 *
 * @param     drv    pointer to CAN driver structure
 * @param     canid  only rcvd message using this id will be placed in data
 * @param     rtr    only mssages having the rtr bit set will be recvd
 * @param     data   message data will be put in this buffer
 * @param     dsize  specifies size of data buffer.
 *
 * @return    CAN_ERR in case there're no more empty receive buffers.
 */
int can_init_rxmo(     can_t         * restrict drv,
                       canid_t       canid,
                       unsigned char rtr,
                       uint8_t       *data,
                       int           dsize )
{
    int i;
    int ret;

    for (i = 0; i < drv->rxbuf_size; i++)
    {
        if(drv->rxbuf[i].data == NULL)
            break;
    }
#ifdef CAN_DEBUG
    if(i>=drv->rxbuf_size)
        printf("init_rxmo: MO not allocated\n");
    else
        printf("init_rxmo: id 0x%x, sz %d\n", canid, data_size);
#endif
    if(i < drv->rxbuf_size)
    {
        can_init_mo(&drv->rxbuf[i], canid, rtr, data, dsize);
        ret = CAN_OK;
    }
    else
    {
        can_set_state(drv, CAN_STRXFULL);
        ret = CAN_ERR;
    }
    return ret;
}


/**
 * @brief initialize a CAN message object for transmission.
 *
 * initializes the first free CAN message object in the transmit
 * message object array.  Provide a buffer and its size to transmit 
 * the data from. A can message is 8 bytes. Larger messages are transmitted
 * using a sequence of 8 bytes can messages.  The last messaage in this sequence is 
 * marked by setting  FRAME_RB0.
 *
 * @param     drv     pointer to CAN driver structure
 * @param     canid   transmit message data using this id
 * @param     rtr     True -> only messages having the rtr bit set will be recvd
 * @param     data    message data is sent from this buffer
 * @param     dsize   specifies size of data buffer.
 *
 * @return    CAN_ERR in case there're no more empty transmit buffers.
 */
int can_init_txmo(     can_t         * restrict drv,
                       canid_t       canid,
                       unsigned char rtr,
                       uint8_t       *data,
                       int           dsize )
{
    int i;
    int ret;

    for (i = 0; i < drv->txbuf_size; i++)
    {
         if(drv->txbuf[i].data == NULL)
             break;
    }
#ifdef CAN_DEBUG
    if(i>=drv->txbuf_size)
        printf("init_txmo: MO not allocated\n");
    else
        printf("init_txmo: id 0x%x, sz %d", canid, data_size);
#endif
    if(i < drv->txbuf_size)
    {
        can_init_mo(&drv->txbuf[i], canid, rtr, data, dsize);
        ret = CAN_OK;
    }
    else
    {
        can_set_state(drv, CAN_STTXFULL);
        ret = CAN_ERR;
    }
    return ret;
}


/**
 *  @brief Initialize one CAN message object (common code)
 *
 *  Normally you would like to use can_init_txmo() or can_init_rxmo()
 *
 *  @param     mo     pointer to message object which will be initialized
 *  @param     canid  only rcvd message using this id will be placed in data
 *  @param     rtr    True -> only messages having the rtr bit set will be recvd
 *  @param     data   message data will be put in this buffer
 *  @param     dsize  specifies size of data buffer.
 *
 *  @return    Nothing.
 */
void can_init_mo(      canmo_t       *mo,
                       canid_t       canid,
                       unsigned char rtr,
                       uint8_t       *data,
                       int           dsize )
{
    canid = canid << 1;
    if (rtr)
        canid++;       // set the ident rtr bit
#ifdef CAN_EXTENDED_ID
    // id (29 bits) plus rtr bit is 30 bits
    mo->ident = (canid & 0x3FFFFFFF) << 2;
#else
    // id (11 bit) plus rtr bit is 12 bits
    mo->ident = (canid & 0xFFF) << 4;
#endif
    mo->newmsg = 0;
    mo->data = data;
    mo->doffset = data;
    mo->dsize = dsize;
    mo->state = 0;
}


/**
 *  @brief Clear the data from a message object with the given id.
 *
 *  Memory is not freed. The message object can now be configured to hold
 *  another message using can_init_txmo() or can_init_rxmo().
 *
 *  @param     drv     pointer to CAN driver structure
 *  @param     canid   clear from the message object array the message
 *                     object having this canid.
 *
 *  @return    CAN_OK = success, CAN_ERR = error (id not found)
 */
int can_clear_rxmo(can_t * restrict drv, canid_t canid)
{
    int i;
    int ret = CAN_ERR;

    // check if given id exists
    for (i = 0; i < drv->rxbuf_size; i++)
    {
#ifdef CAN_EXTENDED_ID
        if ((drv->rxbuf[i].ident >> 3) == canid)
#else
        if ((drv->rxbuf[i].ident >> 5) == canid)
#endif
        {
            drv->rxbuf[i].newmsg = 0;
            drv->rxbuf[i].data = NULL;
            drv->rxbuf[i].doffset = NULL;
            drv->rxbuf[i].state = 0;
            ret = CAN_OK;
            break;
        }
    }
    // if not one message in the buffer has the given id, return CAN_ERR, else return CAN_OK
    return ret;
}


/**
 *  @brief Clear the data from a message object with the given id.
 *
 *  Memory is not freed. The message object can now configured to hold another
 *  message.
 *
 *  @param     drv     pointer to CAN driver structure
 *  @param     canid   clear from the message object array the message
 *                     object having this canid.
 *
 *  @return    CAN_OK = success, CAN_ERR = error (id not found)
 */
int can_clear_txmo(can_t * restrict drv, canid_t canid)
{
    int i;
    int ret = CAN_ERR;

    // check if given id exists
    for (i = 0; i < drv->txbuf_size; i++)
    {
#ifdef CAN_EXTENDED_ID
        if ((drv->txbuf[i].ident >> 3) == canid)
#else
        if ((drv->txbuf[i].ident >> 5) == canid)
#endif
         {
             drv->txbuf[i].newmsg = 0;
             drv->txbuf[i].data = NULL;
             drv->txbuf[i].doffset = NULL;
             drv->txbuf[i].state = 0;
             ret = CAN_OK;
             break;
         }
    }
    // if not one message in the buffer has the given id, return CAN_ERR, else return CAN_OK
    return ret;
}


/**
 *  @brief Get (copy) data from message object having this id.
 *
 *  If data in message object is not null it is copied to *data. Also the mo
 *  objects itself is released afterwards using can_release_rxmo(). The function
 *  returns the size of the received data.
 *
 *  @param     drv        pointer to CAN driver structure
 *  @param     canid      get data size from the message object having this id.
 *  @param     data       copy data to this buffer; buffer should be large
 *                        enough (drv->rxbuf[canid].dsize) to hold this message.
 *
 *  @return    size of received data. CAN_ERR if canid not found
 */
int can_getdata_rxmo(can_t * restrict drv, canid_t canid, uint8_t *data)
{
    int i;
    int ret = CAN_ERR;
    uint8_t *modata;

    // check if given canid exists
    for (i = 0; i < drv->rxbuf_size; i++)
    {
#ifdef CAN_EXTENDED_ID
        if ((drv->rxbuf[i].ident >> 3) == canid)
#else
        if ((drv->rxbuf[i].ident >> 5) == canid)
#endif
        {
            if (data)
            {
                modata = drv->rxbuf[i].data;
                while(modata < drv->rxbuf[i].doffset)
                    *data++ = *modata++;
                can_release_rxmo(drv, canid);
            }
            ret = drv->rxbuf[i].doffset - drv->rxbuf[i].data;
            break;
        }
    }
    // if not one message in the buffer has the given canid, return CAN_ERR, else return size
    return ret;
}


/**
 * @brief Set data pointer of message object having this canid.
 *
 * Use this function to (re)set a datapointer in the a transmit message
 * object. A can message is 8 bytes. Larger messages are transmitted
 * using a sequence of 8 bytes can messages.  The last messaage in this sequence is 
 * marked by setting  FRAME_RB0.
 *
 * @param     drv      pointer to CAN driver structure
 * @param     canid    set data of message object having this id.
 * @param     data     pointer to data you would like to transmit
 * @param     dsize    size of this data
 *
 * @return    CAN_OK if data set, CAN_ERR if id not found
 */
int can_setdata_txmo(can_t * restrict drv, canid_t canid, uint8_t *data, int dsize)
{
    int i;
    int ret = CAN_ERR;

    // check if given id exists
    for (i = 0; i < drv->txbuf_size; i++)
    {
#ifdef CAN_EXTENDED_ID
        if ((drv->txbuf[i].ident >> 3) == canid)
#else
        if ((drv->txbuf[i].ident >> 5) == canid)
#endif
        {
            drv->txbuf[i].data = data;
            drv->txbuf[i].doffset = data;
            drv->txbuf[i].dsize = dsize;
            ret = CAN_OK;
            break;
        }
    }
    return ret;
}


/**
 *  @brief Release message object having the passed canid.
 *
 *  Another message using this canid can now be received. The difference
 *  between this function and the can_clear_txmo() / can_clear_rxmo() functions
 *  is that the latter will clear the entire message object while this
 *  function only empties the contained data by resetting the newmsg flag.
 *
 *  @param     drv         pointer to CAN driver structure
 *  @param     canid       message id
 *
 *  @return    CAN_OK if released, CAN_ERR if no new message found
 */
int can_release_rxmo(can_t * restrict drv, canid_t canid)
{
    int i;
    int ret = CAN_ERR;

     // check if given id exists
    for (i = 0; i < drv->rxbuf_size; i++)
    {
#ifdef CAN_EXTENDED_ID
        if ((drv->rxbuf[i].newmsg == 1) && (drv->rxbuf[i].ident >> 3) == canid)
#else
        if ((drv->rxbuf[i].newmsg == 1) && (drv->rxbuf[i].ident >> 5) == canid)
#endif
        {
            // new message found; release it
            drv->rxbuf[i].doffset = drv->rxbuf[i].data;
            drv->rxbuf[i].newmsg = 0;
            ret = CAN_OK;
            break;
        }
    }
    return ret;
}


/**
 *  @brief Copy data of a message object to the hardware transmit buffer
 *
 *  @param     mo        pointer to message object which will be transmitted
 *  @param     base      base address of hardware txbuffer
 *
 *  @return    Nothing.
 */
void can_mo_to_txbuf(canmo_t *mo, uintptr_t base)
{
    uint8_t dlc;
    uint8_t i;
    // pointer to CAN-controller data-buffer
    volatile uint8_t *txbuf = &CAN_TB1(base) + sizeof(canid_t);
    uint8_t frame_info = 0;
    unsigned char rtr;

#ifdef CAN_EXTENDED_ID
    frame_info = FRM_IDE;
    rtr = (mo->ident>>2)&1;
    CAN_TB1(base) = (mo->ident >> 24) & 0xFF;
    CAN_TB2(base) = (mo->ident >> 16) & 0xFF;
    CAN_TB3(base) = (mo->ident >> 8) & 0xFF;
    CAN_TB4(base) = mo->ident & 0xFF;
#else
    rtr = (mo->ident>>4)&1;
    CAN_TB1(base) = (mo->ident >> 8) & 0xFF;
    CAN_TB2(base) = mo->ident & 0xFF;
#endif

    if (rtr)
        frame_info |= FRM_RTR;

    if ((mo->dsize - (mo->doffset - mo->data)) > 8)
    {
        // more then 8 bytes data to send, more CAN-messages to go
        dlc = 8;
        frame_info |= FRM_RB0; // signal receiver can message not complete
        mo->newmsg = 1; // interrupt will send rest
        // copy message header and data to the CAN-controller
        CAN_TB0(base) = frame_info + dlc;  // frame info
        for (i=0; i<dlc; i++)
        {
            *txbuf++ = *mo->doffset++;          // copy data
        }
    }
    else
    {
        dlc = (uint8_t)(mo->dsize - (mo->doffset - mo->data));
        // copy message header and data to the CAN-controller
        CAN_TB0(base) = frame_info + dlc;  // frame info
        for (i=0; i<dlc; i++)
        {
            *txbuf++ = *mo->doffset++;          // copy data
        }
        mo->doffset = mo->data;
    }
}


/**
 *  @brief Check for new received message objects.
 *
 *  @param     drv        pointer to CAN driver structure
 *
 *  @return    The canid of the first message containing a new message, 0xFFFF if none found
 */
canid_t can_receive_rxmo(can_t * restrict drv)
{
    int i;
    canid_t ret = (canid_t)0xFFFF;

     // check if given id exists
    for (i = 0; i < drv->rxbuf_size; i++)
    {
        if (drv->rxbuf[i].newmsg == 1)
        {
#ifdef CAN_EXTENDED_ID
            ret = drv->rxbuf[i].ident >> 3;
#else
            ret = drv->rxbuf[i].ident >> 5;
#endif
            break;
        }
    }
    return ret;
}


/**
 *  @brief Transmit the message object having the provided canid
 *
 *  @param     drv    pointer to CAN driver structure
 *  @param     canid  can message id
 *
 *  @return    CAN_OK if success, CAN_ERR if no message with given canid found
 */
int can_sent_txmo(can_t * restrict drv, canid_t canid)
{
    uintptr_t base = drv->base;
    int i;
    int ret = CAN_ERR;
    uint8_t ier = CAN_IER(base);

     // check if given canid exists
    for (i = 0; i < drv->txbuf_size; i++)
    {
#ifdef CAN_EXTENDED_ID
        if (((drv->txbuf[i].ident >> 3) == canid) && (drv->txbuf[i].newmsg == 0))
#else
        if (((drv->txbuf[i].ident >> 5) == canid) && (drv->txbuf[i].newmsg == 0))
#endif
        {
            // right message found, send message data
            can_sent_mo(&drv->txbuf[i], base);
            ret = CAN_OK;
            break;
        }
    }
    return ret;
}


/**
 *  @brief Transmits data from an arbitrary message object.
 *
 *  Normally you would use can_sent_txmo()
 *
 *  @param    mo       pointer to CAN device structure
 *  @param    base     base address of hardware
 *
 *  @return Nothing.
 */
void can_sent_mo(canmo_t *mo, uintptr_t base)
{
    uint8_t ier = CAN_IER(base);

    // start send process
    if (CAN_SR(base) & SR_TBS) // tx buffer free?
    {
        // start tx chain
        can_mo_to_txbuf(mo, base);
        CAN_CMR(base) = CMR_TR; // transmit the message
    }
    else
    {
        // Disable tx interrupt
        CAN_IER(base) = ier & ~IER_TI;
        // add to running tx chain; interrupt will send it
        mo->newmsg = 1;
        // message added to tx chain; we can now safely turn the tx interrupt back on.
        CAN_IER(base) = ier;
    }
}


/**
 *  @brief Abort transmission of message in the txbuf
 *
 *  @param     drv = pointer to CAN device structure
 *  @return Nothing.
 */
void can_txabort(can_t * restrict drv)
{
    uintptr_t base = drv->base;
    CAN_CMR(base) = CMR_AT;
}


/**
 *  @brief Handle receive, transmit warning and datoverrun interrupt
 *
 *  @param     drv     pointer to CAN driver structure
 *
 *  @return    Nothing.
 */
void can_interrupt_handler(can_t * restrict drv)
{
    uintptr_t           base = drv->base;
    int                 i;
    uint8_t             frame_info;
    uint8_t             dlc;
    uint8_t             flags = CAN_IR(base);
    volatile uint8_t    *msg_buf = NULL;
    canid_t             canid = 0;
    char                ignore = 0;

    if (flags & IR_RI)
    {
        frame_info = CAN_RB0(base);
        dlc = frame_info & FRM_DLC;
        if(frame_info & FRM_IDE)
        {
#ifdef CAN_EXTENDED_ID
            canid = (CAN_RB1(base) << 24) + \
                    (CAN_RB2(base) << 16) + \
                    (CAN_RB3(base) << 8) + \
                     CAN_RB4(base);
            msg_buf = &CAN_RB5(base);
#else
            ignore = 1;
#endif
        }
        else
        {
            canid = (CAN_RB1(base) << 8) + \
                     CAN_RB2(base);
            msg_buf = &CAN_RB3(base);
        }
        if (!ignore)
        {
            for(i = 0; i < drv->rxbuf_size; i++)
                if(drv->rxbuf[i].ident == canid) break;
            if(i < drv->rxbuf_size) // Verify, if message is matched
            {
                if(!drv->rxbuf[i].newmsg)
                {
                    // Verify overflow
                    if ((drv->rxbuf[i].doffset - drv->rxbuf[i].data + dlc) <= drv->rxbuf[i].dsize)
                    {
                        while (dlc > 0)
                        {
                            *drv->rxbuf[i].doffset++ = *msg_buf++;
                            dlc--;
                        }
                    }
                    else
                    {
                        drv->rxbuf[i].state |= CAN_RXOVL;
                    }
                     // message is complete when FRM_RB0 is 0
                    if (!(frame_info & FRM_RB0))
                    {
                        drv->rxbuf[i].newmsg = 1;
                    }
                }
            }
        }
        CAN_CMR(base) = CMR_RRB;  // release receive message buffer in the CAN-controller
    }
    if (flags & IR_TI) // transmit buffer sent/empty, another message can now be sent
    {
        for(i=0; i<drv->txbuf_size; i++)
        {
            if(drv->txbuf[i].newmsg)
            {
                drv->txbuf[i].newmsg = 0;                   // message can now be transmitted
                can_mo_to_txbuf(&drv->txbuf[i], base);
                CAN_CMR(base) = CMR_TR; // transmit CAN message
                break;
            }
        } // end of for loop
    }
    if (flags & IR_EI) // Error Warning interrrupt
    {
        if (CAN_SR(base) & SR_BS)
            can_set_state(drv, can_get_state(drv) | CAN_STBUSOFF);
        else
            can_set_state(drv, can_get_state(drv) | CAN_STWARNING);
    }
    if (flags & IR_DOI) // Data Overrun interrrupt
    {
        can_set_state(drv, can_get_state(drv) | CAN_STOVL);
        // Clear data overrun
        CAN_CMR(base) = CMR_CDO;
    }
}


__INTERRUPT_NATIVE void can_interrupt_handler_native(void)
{
    int num = interrupt_get_current();
    can_t * restrict drv = (can_t *) interrupt_native_context(num);

    can_interrupt_handler(drv);
    interrupt_acknowledge(num);
}


/**
 * @brief initialize the CAN controller
 * 
 * This function is provided to allow for resetting the buffers and the 
 * interrupt handler. CANopen uses this function to hookup its own buffers
 * and interrupt handler
 *
 * @param     drv           pointer to CAN driver structure
 * @param     rxbuf         pointer to rx-buffer
 * @param     rxbuf_size    size of rx-buffer in number of messages
 * @param     txbuf         pointer to tx-buffer
 * @param     txbuf_size    size of tx-buffer in number of messages
 * @param     handler       pointer to interrupt function
 *
 * @return    Nothing.
 */
void can_init(can_t * restrict drv, canmo_t *rxbuf, int rxbuf_size, canmo_t *txbuf, int txbuf_size, interrupt_native_handler_t handler)
{
    drv->rxbuf = rxbuf;
    drv->rxbuf_size = rxbuf_size;
    drv->txbuf = txbuf;
    drv->txbuf_size = txbuf_size;
    if (rxbuf_size || txbuf_size)
    {
        // there is a software buffer, enable fast interrupt handling
        assert(per_can_instance_table[drv->cfg->per_can].interrupt0 != -1);
        interrupt_register_native((uint32_t)per_can_instance_table[drv->cfg->per_can].interrupt0, (void *) drv, handler);
        interrupt_enable((uint32_t)per_can_instance_table[drv->cfg->per_can].interrupt0);
        CAN_IER(drv->base) |= IER_RI | IER_TI;
        // clear the reset bit, switch to operating mode
        CAN_MOD(drv->base) = 0;
    }
}


/**
 * @brief initialize and start the CAN controller
 *
 * @param     id         CAN driver id
 *
 * @return    pointer to the initialized driver structure or NULL on failure.
 */
can_t * can_open(int id)
{
    can_t * restrict drv = &can_driver_table[id];
    drv_can_cfg_instance_t * restrict drv_cfg = &drv_can_instance_table[id];
    uintptr_t base = per_can_instance_table[drv_cfg->per_can].baseaddress;

    assert (base != 0);
    if (base != 0)
    {
        // copy driver configuration to driver
        drv->rxbuf = drv_cfg->rx_buffer;
        drv->rxbuf_size = drv_cfg->rx_buffer_size;
        drv->txbuf = drv_cfg->tx_buffer;
        drv->txbuf_size = drv_cfg->tx_buffer_size;
        drv->state = 0;
        drv->base = base;
        drv->cfg = drv_cfg;

        // switch to reset mode to get access to the configuration registers
        CAN_MOD(base) = MOD_RM;
        // donot output clock on CLK_OUT
        CAN_CDR(base) = 0xC8;
        CAN_CMR(base) = 0x0E;                           // Perform a fresh start
        CAN_OCR(base) = 2;                              // set output mode to normal
        CAN_EWL(base) = 96;                             // set error warning level
        CAN_IER(base) = IER_DOI|IER_EI;                 // enable warning and data overrun interrrupt
        CAN_AMR0(base) = (drv_cfg->accept_mask >> 24) & 0xFF;    // only bits set to 0 are considered relevant
        CAN_AMR1(base) = (drv_cfg->accept_mask >> 16) & 0xFF;    // so when you define the accept_mask=0xFFFFFFFF
        CAN_AMR2(base) = (drv_cfg->accept_mask >>  8) & 0xFF;    // not one message will be filtered an all received
        CAN_AMR3(base) = drv_cfg->accept_mask & 0xFF;            // messages will thus be placed in the fifo
        CAN_ACR0(base) = (drv_cfg->accept_filt >> 24) & 0xFF;
        CAN_ACR1(base) = (drv_cfg->accept_filt >> 16) & 0xFF;
        CAN_ACR2(base) = (drv_cfg->accept_filt >>  8) & 0xFF;
        CAN_ACR3(base) = drv_cfg->accept_filt & 0xFF;

        set_baudrate(base, (uint32_t) freq_hz(), drv_cfg->baudrate);
        can_set_state(drv, 0);

    #ifdef CAN_DEBUG
        if(rxbuf == NULL || txbuf == NULL)
            printf("init: rxbuf or txbuf received NULL pointer\n");
        else
            printf("init: rxbuf_sz %d, txbuf_sz %d, baud %d\n", rxbuf_size, txbuf_size, drv_cfg->baudrate);
    #endif

        if (drv->rxbuf_size || drv->txbuf_size)
        {
            // driver has a software buffer, enable fast interrupt handling
            assert(per_can_instance_table[drv_cfg->per_can].interrupt0 != -1);
            interrupt_register_native((uint32_t)per_can_instance_table[drv_cfg->per_can].interrupt0, (void *) drv, can_interrupt_handler_native);
            interrupt_enable((uint32_t)per_can_instance_table[drv_cfg->per_can].interrupt0);
            CAN_IER(base) |= IER_RI | IER_TI;
            // clear the reset bit, switch to operating mode
            CAN_MOD(base) = 0;
        }
        return drv;
    }
    else
    {
        return NULL;
    }
}


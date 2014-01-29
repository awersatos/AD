/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2007, Altium
|*
|*  Description:    CANopen communications service. Non-posix
|*                  interface.
|*
\*****************************************************************************/
#include <stdlib.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include <io.h>
#include <stdio.h>
#include <time.h>
#include <per_can.h>
#include <drv_can.h>
#include <canopen.h>
#include <timers.h>
#include <interrupts.h>
#include "drv_can_cfg_instance.h"

static    can_t     *can_drv;          // we only support one can(open) instance
/*******************************************************************************
   MACROS FOR CAN RX MESSAGE FILTERING

   NOTE: At the moment we donot apply hardware filters.

   By default, CAN rx messages are filtered by CAN module, if total number of
   CANopen received messages is less than or equal to 16 (CO_RXCAN_NO_MSGS <= 16).
   If CO_RXCAN_NO_MSGS > 16, CAN modulr rx filters are disabled and filtering is
   implemented in hardware. For more information see manual.
*******************************************************************************/
#define CAN_MODULE_NUMBER_OF_FILTERS    0 // Do not use hardware filters

#ifndef CAN_MODULE_DISABLE_RX_FILTERS
   #if(CO_RXCAN_NO_MSGS > CAN_MODULE_NUMBER_OF_FILTERS)
      #define CAN_MODULE_DISABLE_RX_FILTERS
   #endif
#endif


/*******************************************************************************
   Variables and functions
*******************************************************************************/
   extern int       candriver_id;
   extern UNSIGNED8 CO_NodeID;               // Variable must be intialized here
   unsigned char    CO_BitRate;              // Variable must be intialized here
   void             *can_timer;


/**
 * @brief Read node-id and can bitrate
 *
 * This is mainline function and is called from Communication reset.
 * NodeID and BitRate can be read also from DIP switches.
 *
 * @return Nothing.
 */
void CO_Read_NodeId_BitRate(void)
{
   CO_NodeID = OD_CANNodeID;    //range 1 to 127
   CO_BitRate = OD_CANBitRate;  //range 0 to 7
                                    // 0 = 10 kbps    1 = 20 kbps
                                    // 2 = 50 kbps    3 = 125 kbps
                                    // 4 = 250 kbps   5 = 500 kbps
                                    // 6 = 800 kbps   7 = 1000 kbps

   if(CO_NodeID==0 || CO_NodeID>127 || CO_BitRate > 7){
      ErrorReport(ERROR_WrongNodeIDorBitRate, (CO_NodeID<<8)|CO_BitRate);
      CO_NodeID = 1;
      if(CO_BitRate > 7) CO_BitRate = 1;
   }
}


// This is mainline function and is called cyclically from CO_ProcessMain().
void CO_ProcessDriver(void){}


/**
 * @brief Configure CAN rx module and CO_RXCAN Variables
 *
 * This function configures one element of CO_RXCAN array. It sets CAN
 * identifier, message length, and inhibit flag. If necessary it configures
 * filters on CAN module.
 *
 * @param index          0 ... (CO_RXCAN_NO_MSGS - 1)) index to CO_RXCAN[] array.
 * @param id             11-bit standard CAN Identifier.
 * @param rtr            If true, only 'Remote Transmit Request' messages will be accepted.
 * @param noofbytes      Length of CAN message in bytes.
 *                       Value == 0 ... 8 - Accept only messages with this length or
 *                       generate error
 *                       Value > 8 - Accept messages with any length.
 * @param inhibit        If this flag bit is true and NewMsg bit is set (nobody
 *                       didn't read previous data and didn't clear flag), data will
 *                       not be copied from new message and error will be generated.
 * @return               0 if configuration was successful.
 *                       less than 0 if configuration was not possible.
*/
char CO_RXCANconfigure( UNSIGNED16 index,
                        UNSIGNED16 id,
                        unsigned char rtr,
                        unsigned char noofbytes,
                        unsigned char inhibit)
{
    char ret = -1;

    if (index < can_drv->rxbuf_size) // use user specified index
    {
        can_init_mo((canmo_t *)&CO_RXCAN[index], id, rtr, (unsigned char*)&CO_RXDATA[8*index], 8);
        CO_RXCANEXT[index].noofbytes = noofbytes;
        CO_RXCANEXT[index].inhibit = inhibit? 1 : 0;
        ret = 0;
    }
    return ret;
}


/**
 * @brief Configure CAN tx module and CO_TXCAN Variables
 *
 * This function configures one element of CO_TXCAN array. It sets CAN
 * identifier, message length, and inhibit flag.
 *
 * @param index        (0 ... (CO_TXCAN_NO_MSGS - 1)) index to CO_TXCAN[] array.
 * @param id           11-bit standard CAN Identifier.
 * @param rtr          If true, 'Remote Transmit Request' messages will be send.
 * @param noofbytes    (0 ... 8) - Length of CAN message in bytes.
 * @param inhibit      This flag bit is used for synchronous TPDO messages. If set,
 *                     message will not be sent, if curent time is outside
 *                     CO_SYNCwindow.
 *
 * @return            0 if configuration was successful.
 *                    less than 0 if configuration was not possible.
*/
char CO_TXCANconfigure( UNSIGNED16 index,
                        UNSIGNED16 id,
                        unsigned char rtr,
                        unsigned char noofbytes,
                        unsigned char inhibit)
{
    char ret = -1;

    if (index < can_drv->txbuf_size) // use user specified index
    {
        can_init_mo((canmo_t *)&CO_TXCAN[index], id, rtr, (unsigned char*)&CO_TXDATA[8*index], noofbytes);
        CO_TXCANEXT[index].noofbytes = noofbytes;
        CO_TXCANEXT[index].inhibit = inhibit? 1 : 0;
        ret = 0;
    }
    return ret;
}


/**
* @brief Send CAN message
*
* Function can be called from mainline or timer function. If any CAN tx buffer
* is free, it will send message directly, othervise it will set flag, so
* message will be sent by interrupt.
*
* @param  index   index of CO_TXCAN array to be send
*
* @return         0 success
*                 -1 = error, previous message was not sent, buffer full
*                 -2 = error, synchronous TPDO outside window
*/
char CO_TXCANsend(UNSIGNED16 index)
{
    //Was previous message sent or it is still waiting?
    if(CO_TXCAN[index].newmsg)
    {
        ErrorReport(ERROR_CAN_TX_OVERFLOW, index);
        return -1;
    }
    // messages with Inhibit flag set must be transmited inside window
    if(CO_TXCANEXT[index].inhibit & !(can_drv->state & CAN_STINHIBIT))
    {
        ErrorReport(ERROR_TPDO_OUTSIDE_WINDOW, index);
        return -2;
    }
    can_sent_mo((canmo_t *)&CO_TXCAN[index], can_drv->base);
    return 0;
}


/**
 * @brief Clears all Pending synch. PDOS from CAN tx buffers
 *
 * CANopen allows synchronous PDO communication only inside time between SYNC
 * message and SYNC Window. If time is outside this window, new synch. PDOs
 * must not be sent and all pending sync TPDOs, which may be on CAN TX buffers,
 * must be cleared.
 * This function checks (and aborts transmission if necessary) CAN TX buffers
 * at the moment when time goes outside the window.
 *
 * @return Nothing.
 */
#if CO_NO_SYNC > 0
extern void CO_ClearPendingSyncPDOs(void)
{
    //abort transmission if there's a message with the inhibit flag in the txbuf
    if(can_get_state(can_drv) & CAN_STTXINH)
        can_txabort(can_drv);
}
#endif


/******
 * Handle receive, transmit warning and datoverrun the canopen way
 *
 * param  drv     pointer to CAN driver structure
 *
 * return Nothing.
 */
void CO_interrupt_handler(can_t * restrict drv)
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
                // Verify length
                if( (drv->rxbuf[i].doffset == drv->rxbuf[i].data) && \
                    (CO_RXCANEXT[i].noofbytes <= 8) && \
                    (CO_RXCANEXT[i].noofbytes != dlc) )
                {
                    drv->rxbuf[i].state |= CAN_RXLEN;
                }
                else if(dlc > 8) // Verify DLC
                {
                    drv->rxbuf[i].state |= CAN_RXDLC;
                }
                else if(drv->rxbuf[i].newmsg && CO_RXCANEXT[i].inhibit) // Verify Inhibit
                {
                    drv->rxbuf[i].state |= CAN_RXINH;
                }
                else if(!drv->rxbuf[i].newmsg)
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
                        CO_RXCANEXT[i].noofbytes = drv->rxbuf[i].doffset - drv->rxbuf[i].data;
                        drv->rxbuf[i].doffset = drv->rxbuf[i].data;
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
            can_set_state(drv, can_get_state(drv) & ~CAN_STTXINH); // Inhibited message is sent
            if(drv->txbuf[i].newmsg)
            {
                // messages with Inhibit flag set must be transmited inside window
                if(CO_TXCANEXT[i].inhibit)
                {
                    if(!(drv->state & CAN_STINHIBIT))
                    {
                         continue;
                    }
                    can_set_state(drv, can_get_state(drv) | CAN_STTXINH); // inh message will be sent
                }
                drv->txbuf[i].newmsg = 0;       // this message will now be transmitted
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


__INTERRUPT_NATIVE void CO_interrupt_handler_native(void)
{
    int num = interrupt_get_current();
    can_t * restrict drv = (can_t *) interrupt_native_context(num);

    CO_interrupt_handler(drv);
    interrupt_acknowledge(num);
}


void tmr_intr_handler(void *context)
{
    CO_Timer_Isr();
    if (CO_TimeIsInsideSyncWindow)
        can_set_state(can_drv, can_get_state(can_drv) | CAN_STINHIBIT);
    else
        can_set_state(can_drv, can_get_state(can_drv) & ~CAN_STINHIBIT);
}


/**
 * @brief Init CAN controller interface
 *
 * This is mainline function and is called after Communication reset.
 * All interrupts must be disabled before this function call.
 * 
 * @return Nothing.
 */
void CO_SetupCAN(void)
{
    interrupts_disable();

    // Initialize the CAN driver
    can_drv = can_open(canopen_instance_table[0].drv_can);
    //initialize the driver with our own buffers and handler
    can_init(can_drv, (canmo_t *)CO_RXCAN, CO_RXCAN_NO_MSGS, (canmo_t *)CO_TXCAN, CO_TXCAN_NO_MSGS, CO_interrupt_handler_native);

    // register a timer which is called once every 1*1000us
    can_timer = timer_register_handler(NULL, 1000L, &tmr_intr_handler);

    // enables the configured interrupts
    interrupts_enable();
}


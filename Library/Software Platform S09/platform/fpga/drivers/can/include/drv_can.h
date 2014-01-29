/*****************************************************************************\
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  IN PACKAGE:         CAN device driver
|*
|*  COPYRIGHT:          Copyright (c) 2007, Altium
|*
 */
/**
 * @file
 * Configure this driver using the Software platform builder.  After this open
 * the device using  can_open(). In CAN, devices are addressed using an id. To be 
 * able to transmit messages you need to configure (can_init_txmo() )  the id of the 
 * transmitted messages. Using can_init_rxmo()  you can configure which id you want 
 * to receive.  Both function need a scratch data buffer to hold the transmitted / received data.  
 * Transmission of message objects is done using can_sent_txmo() . Use can_setdata_txmo() 
 * to reset the scratch data buffer of one message object.
* Use can_receive_rxmo() to check for new arrived message objects. The data can 
* be copied from the scratch buffer to your data object using can_getdata_rxmo(). 
* This function also releases the message  object such that it is available again to receive new 
* can messages. Can_release_rxmo() can be used to release the message object without copying 
* data. 
 * For a detailed description of the CAN peripheral, see the Core Reference
 * <a href="CR0104 CAN Controller.pdf">CR0104 CAN Controller</a>
 */
#ifndef _DRV_CAN_H
#define _DRV_CAN_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>
#include <interrupts.h>
#include "drv_can_cfg_instance.h"
#include "can_msgobj_type.h"

/**
 * @name CAN system status
 */
/** @{ */
#define    CAN_OK        0   /**< CAN OK */
#define    CAN_ERR      -1   /**< Generic error */
#define    CAN_BAUD_ERR -2   /**< Baudrate setting error */
/** @} */


/** 
  * @brief Message Object status
  *
  * Message Object status
  */
typedef enum
{
    CAN_RXINH = 1<<3,       /**< Received new message with inhibit status */
    CAN_RXDLC = 1<<2,       /**< Received message with invalid DLC */
    CAN_RXLEN = 1<<1,       /**< Received message with unsuspected length */
    CAN_RXOVL = 1,          /**< Overflow on message */
} can_rxmostatus_t;


/** 
  * @brief CAN driver status
  *
  * CAN driver status
  */
typedef enum
{
    CAN_STTXINH = 1<<6,      /**< There's a message with the inhibit status in the HW buffer */
    CAN_STINHIBIT = 1<<5,    /**< INHIBIT window active; inhibited message will be sent */
    CAN_STTXFULL = 1<<4,     /**< TX MO queue full */
    CAN_STRXFULL = 1<<3,     /**< RX MO queue full */
    CAN_STBUSOFF = 1<<2,     /**< Bus-Off state active */
    CAN_STWARNING = 1<<1,    /**< Warning limit reached */
    CAN_STOVL = 1,           /**< Overflow on hardware receive buffer */
} can_rxdrvstatus_t;


typedef struct can_drv_s
{
    canmo_t                     *rxbuf;     // 'array' for received message objects
    int                         rxbuf_size; // size of message receive 'array'
    canmo_t                     *txbuf;     // 'array' with message objects to be transmitted
    int                         txbuf_size; // size of message transmit 'array'
    uint8_t                     state;      // Overflow
    uintptr_t                   base;       // base address
    drv_can_cfg_instance_t      *cfg;
} can_t;

/* functions handling global can context */
extern can_t * can_open(int id);
void can_init(can_t * restrict drv, canmo_t *rxbuf, int rxbuf_size, canmo_t *txbuf, int txbuf_size, interrupt_native_handler_t handler);

extern int can_reset(can_t * restrict drv);
extern void can_stop(can_t * restrict drv);

extern uint8_t can_get_state(can_t * restrict drv);
extern void can_set_state(can_t * restrict drv, uint8_t state);

/* functions handling individual message objects */
extern int can_init_rxmo(can_t * restrict drv, canid_t canid, unsigned char rtr, uint8_t *data, int dsize);
extern int can_init_txmo(can_t * restrict drv, canid_t canid, unsigned char rtr, uint8_t *data, int dsize);
extern void can_init_mo(canmo_t *mo, canid_t canid, unsigned char rtr, uint8_t *data, int dsize);

extern int can_clear_rxmo(can_t * restrict drv, canid_t canid);
extern int can_clear_txmo(can_t * restrict drv, canid_t canid);

extern int can_getdata_rxmo(can_t * restrict drv, canid_t canid, uint8_t *data);
extern int can_setdata_txmo(can_t * restrict drv, canid_t canid, uint8_t *data, int dsize);

extern canid_t can_receive_rxmo(can_t * restrict drv);

extern void can_mo_to_txbuf(canmo_t *mo, uintptr_t base);
extern int can_sent_txmo(can_t * restrict drv, canid_t canid);
extern void can_sent_mo(canmo_t *mo, uintptr_t base);

extern void can_txabort(can_t * restrict drv);

extern int can_release_rxmo(can_t * restrict drv, canid_t canid);

extern void drv_can_init(void);

#ifdef  __cplusplus
}
#endif

#endif /*  _DRV_CAN_H */

/*****************************************************************************\
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  COPYRIGHT:          Copyright (c) 2007, Altium
|*
|*  DESCRIPTION:        CAN Message Object type
|*
 */
#ifndef _CAN_MSGOBJ_TYPE_H_
#define _CAN_MSGOBJ_TYPE_H_

#ifdef  __cplusplus
extern "C" {
#endif


//#define CAN_EXTENDED_ID      // use extended CAN id's
#ifdef CAN_EXTENDED_ID
typedef uint32_t canid_t;
#else
typedef uint16_t canid_t;
#endif

/**
 * @brief
 *       structure of a can message object
 *
 * Normally you would like to define two arrays (one for receiving and one for
 * transmitting) of these message objects. Each message object in the array
 * should first be initialised using can_init_rxmo() / can_init_txmo().
 */
typedef struct
{
      canid_t       ident;       /**< CAN id + RTR (copy of CAN_RB1/RB2/RB3/RB4)
                                      rx: receive message only if matched RTR
                                      tx: send normal or RTR message */
      uint8_t       *data;       /**< message data buffer (payload) */
      uint8_t       *doffset;    /**< big messages are split into multiple 8 bytes can messages.
                                      From this offset in the data buffer we send/receive the next
                                      8 bytes */
      int           dsize;       /**< rx: size of data buffer,
                                      tx: size of message in databuffer */
      uint8_t       newmsg;      /**< rx: new mo has been received,
                                      tx: mo is waiting to be sent */
      uint8_t       state;       /**< Overflow */
} canmo_t;

#ifdef  __cplusplus
}
#endif

#endif //_CAN_MSGOBJ_TYPE_H_

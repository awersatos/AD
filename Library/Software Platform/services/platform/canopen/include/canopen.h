/**
 * @file
 * CANopen service to run on top of the CAN driver.
 *
 * This service is an adaption layer between the LGPL licensed public available CANopenNode
 * software (http://canopennode.sourceforge.net/) and the Altium CAN driver. CANopenNode is 
 * a partial implementation of the CANopen protocol described at http://www.can-cia.org/
 * CANopen is a CAN-based higher layer protocol and runs on top of a CAN physical and a CAN
 * data link layer. In software the layers of the stack are implemented in:
 * -# Per_can.h (the physical layer - description of the CAN hardware registers)
 * -# Drv_can.c/h (the datalink layer - the Altium CAN driver)
 * -# CANopen.c/h (an adaption layer between the CAN driver and the CANopenNode software)
 * -# Co_stack.c (the CANopen protocol - implementation taken from CANopenNode)
 * -# Main.c (Your user program)
 * 
 * Depending on the application your new CANopen device does not need all features CANopen supports.
 * For example not every CANopen device needs NMT master functionality or SDO server functionality.
 * Also the required features need to be configured. For instance your device needs a proper device id
 * to allow communication with other CANopen devices. These and many other can be configured by running 
 * the "CANopen Configurator" available from the CANopen device/service in the Software Platform view.
 * 
 * After running the tool, selecting the required features and configuring the hardware registers
 * (Object Dictionary) of your CANopen device, the tool can generate three source files 
 * required by the CANopenNode stack.
 * CO_OD.c and CO_OD.h define the Object Dictionary and they also do contain the selected features. 
 * The USER.c file contains user functions called by the CANopenNode stack. Save those three 
 * files to your embedded project directory, include framework.h and CANopen.h in your user 
 * application and you immediatly can use the functions listed below. Start the program by 
 * first resetting communication by calling CO_ResetComm(). Detailed information on those 
 * CANopen functions, can be found in the documentation accompanying the CANopenNode software. 
 * Because of the complexity  it is recommended to start from an already running example.
 *
 * <b>Note:</b> this stack is provided as is without any guarentee. Because the CANopenNode stack is 
 * LGPL every change in the stack should be made publically available and merged back into 
 * the original stack available at Sourceforge.
 */
#ifndef _CANOPEN_H
#define _CANOPEN_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <drv_can.h>
#include "canopen_cfg_instance.h"

#include "CO_OD.h"
#include "co_defs.h"
#include "co_errors.h"

#define    CAN_INHIBIT  -3   // tried to send an inhibit message outside window


/* CANopen needs an extension on CAN messages */
typedef canmo_t                 CO_CanMessage;

typedef struct
{
    UNSIGNED8                   noofbytes;          //actual length of message, if>8, length is not monitored at receive
    UNSIGNED8                   inhibit;            //Used to support CANopen Reception: Data are not copied, if
                                                    //inhibit==1 AND newmsg==1 Transmission: message is not send
                                                    //if inhibit==1 AND time is outside window
} CO_CanMsgExt;                                     //used to extend CAN driver message functionality


/* bits status leds */
typedef struct {
    unsigned int On          :1;
    unsigned int Off         :1;
    unsigned int Flickering  :1;
    unsigned int Blinking    :1;
    unsigned int SingleFlash :1;
    unsigned int DoubleFlash :1;
    unsigned int TripleFlash :1;
} CO_StatusLED_struct;
 

/*******************************************************************************
   global declared variables by canopennode. --> Todo: we should get rid of them
*******************************************************************************/

   extern volatile CO_StatusLED_struct CO_StatusLED;
   extern int CO_old_ipl;                            //backup variable

   extern volatile CO_CanMessage CO_RXCAN[];                 //Receive
   extern volatile CO_CanMsgExt CO_RXCANEXT[];               //Receive extension
   extern volatile UNSIGNED8 CO_RXDATA[];


/* CO_TXCAN[] array and indexes */
   extern volatile CO_CanMessage CO_TXCAN[];                //Transmit
   extern volatile CO_CanMsgExt CO_TXCANEXT[];              //Trasnmit extension
   extern volatile UNSIGNED8 CO_TXDATA[];


/* Curent CANopen Node ID and CAN Bit Rate, read only aloved */
   extern UNSIGNED8 CO_NodeID;
   extern UNSIGNED8 CO_BitRate;


/* NMT state of nodes */
   //Curent Operating state of this node
   extern volatile UNSIGNED8 CO_NMToperatingState;
   //Variable has value 5, if all monitored nodes are operational or if ODL_consumerHeartbeatTime_arrayLength == 0
   extern volatile UNSIGNED8 CO_HBcons_AllMonitoredOperational;
   //Variable shows NMT State of each monitored node (0 <= i < ODL_consumerHeartbeatTime_arrayLength)
   #ifndef ODL_consumerHeartbeatTime_arrayLength
      #define ODL_consumerHeartbeatTime_arrayLength 0
   #else
      extern volatile unsigned char CO_HBcons_NMTstate[ODL_consumerHeartbeatTime_arrayLength];
   #endif


/* Variables associated with sync message */
   //If variable is true, Synchronous TPDOs are allowed to be sent
   extern volatile UNSIGNED8 CO_TimeIsInsideSyncWindow;


/*******************************************************************************
   Functions prototypes from canopen.c
*******************************************************************************/
extern void CO_Timer_Isr(void);
extern char CO_RXCANconfigure(UNSIGNED16 index, UNSIGNED16 id,
            unsigned char rtr, unsigned char noofbytes, unsigned char inhibit);
extern char CO_TXCANconfigure(UNSIGNED16 index, UNSIGNED16 id,
            unsigned char rtr, unsigned char noofbytes, unsigned char inhibit);
extern char CO_TXCANsend(UNSIGNED16 index);

/*******************************************************************************
   Functions prototypes from user.c
*******************************************************************************/

/**
 * @brief    User execution on exit of program
 *
 * Function is called before end of program.
 *
 * @return Nothing
 */
extern void User_Remove(void);

/**
 * @brief    User reset communication
 *
 * Function is called after start of program and after CANopen NMT command: 
 * Reset Communication.
 *
 * @return Nothing
 */
extern void User_ResetComm(void);

/**
 * @brief    User process mainline
 *
 * This function is cyclycally called from main(). It is non blocking function.
 * It is asynchronous. Here is longer and time consuming code.
 *
 * @return Nothing
 */
extern void User_ProcessMain(void);

/**
 * @brief    1 ms User timer function
 *
 * Function is executed every 1 ms. It is deterministic and has priority over mainline functions.
 *
 * @return Nothing
 */
extern void User_ProcessTimer(void);

/*******************************************************************************
   Functions prototypes from co_stack.c
*******************************************************************************/
extern void CO_ResetComm(void);
extern void CO_ProcessMain(void);

// for SDO client
   #if CO_NO_SDO_CLIENT > 0
      //Nonblocking function for SDO Client setup
      extern INTEGER8 CO_SDOclient_setup(UNSIGNED8 channel, UNSIGNED32 COB_IDClientToServer,
            UNSIGNED32 COB_IDServerToClient, UNSIGNED8 nodeIDOfTheSDOServer);

      //Nonblocking function for initialization of SDO download
      extern INTEGER8 CO_SDOclientDownload_init(UNSIGNED8 channel, UNSIGNED16 index, UNSIGNED8 subindex,
                                     UNSIGNED8* pBuff, UNSIGNED8 dataSize);

      //Nonblocking function which must be cyclycally called untill end of SDO download
      extern INTEGER8 CO_SDOclientDownload(UNSIGNED8 channel, UNSIGNED32* pSDOabortCode);

      //Nonblocking function for initialization of SDO upload
      extern INTEGER8 CO_SDOclientUpload_init(UNSIGNED8 channel, UNSIGNED16 index, UNSIGNED8 subindex,
                                   UNSIGNED8* pBuff, UNSIGNED8 BuffMaxSize);

      //Nonblocking function which must be cyclycally called untill end of SDO upload
      extern INTEGER8 CO_SDOclientUpload(UNSIGNED8 channel, UNSIGNED32* pSDOabortCode, UNSIGNED8* dataSize);

      //Simplified blocking function for SDO Download (Includes CO_SDOclient_setup, CO_SDOclientDownload_init and CO_SDOclientDownload)
      extern INTEGER8 CO_SDOclientDownload_wait(UNSIGNED8 nodeIDOfTheSDOServer, UNSIGNED16 index, UNSIGNED8 subindex,
                                     UNSIGNED8* pBuff, UNSIGNED8 dataSize, UNSIGNED32* pSDOabortCode);

      //Simplified blocking function for SDO upload (Includes CO_SDOclient_setup, CO_SDOclientUpload_init and CO_SDOclientUpload)
      extern INTEGER8 CO_SDOclientUpload_wait(UNSIGNED8 nodeIDOfTheSDOServer, UNSIGNED16 index, UNSIGNED8 subindex,
                                   UNSIGNED8* pBuff, UNSIGNED8 BuffMaxSize, UNSIGNED8* dataSize, UNSIGNED32* pSDOabortCode);
   #endif

   #if CO_NO_TPDO > 0
   extern INTEGER8 CO_TPDOsend(UNSIGNED16 index);
   extern void CO_PDOhandleTransmission (void);
   #endif
   #if CO_NO_RPDO > 0
   extern void CO_PDOhandleReception(void);
   #endif

#ifdef  __cplusplus
}
#endif

#endif

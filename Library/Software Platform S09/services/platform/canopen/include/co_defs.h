#ifndef _CO_DEFS_H
#define _CO_DEFS_H

#ifdef __BIG_ENDIAN__
#define SWAP2(i) \
  ((((uint16_t)(i) & 0xff00) >> 8) | \
  (((uint16_t)(i) & 0x00ff) << 8))
#else
#define SWAP2(i) (i)
#endif

#ifdef __BIG_ENDIAN__
#define SWAP4(i) \
    ((((uint32_t)(i) & 0xff000000) >> 24) | \
    (((uint32_t)(i) & 0x00ff0000) >> 8)  | \
    (((uint32_t)(i) & 0x0000ff00) << 8)  | \
    (((uint32_t)(i) & 0x000000ff) << 24))
#else
#define SWAP4(i) (i)
#endif


#define RETURN(code)                \
   {  STATE = 0;                       \
      CO_RXCANrelease(RXC_INDEX);     \
      return code;                     \
   }

   #define CO_RXCAN_NMT       0                                      //index for NMT message
   #define CO_RXCAN_SYNC      1                                      //index for SYNC message
   #define CO_RXCAN_RPDO     (CO_RXCAN_SYNC+CO_NO_SYNC)              //start index for RPDO messages
   #define CO_RXCAN_SDO_SRV  (CO_RXCAN_RPDO+CO_NO_RPDO)              //start index for SDO server message (request)
   #define CO_RXCAN_SDO_CLI  (CO_RXCAN_SDO_SRV+CO_NO_SDO_SERVER)     //start index for SDO client message (response)
   #define CO_RXCAN_CONS_HB  (CO_RXCAN_SDO_CLI+CO_NO_SDO_CLIENT)     //start index for Heartbeat Consumer messages
   #define CO_RXCAN_USER     (CO_RXCAN_CONS_HB+ODL_consumerHeartbeatTime_arrayLength) //start index for user defined CANrx messages
   //total number of received CAN messages
   #define CO_RXCAN_NO_MSGS (1+CO_NO_SYNC+CO_NO_RPDO+CO_NO_SDO_SERVER+CO_NO_SDO_CLIENT+ODL_consumerHeartbeatTime_arrayLength+CO_NO_USER_CANRX)

   #define CO_TXCAN_SYNC      0                                      //index for SYNC message
   #define CO_TXCAN_EMERG    (CO_TXCAN_SYNC+CO_NO_SYNC)              //index for Emergency message
   #define CO_TXCAN_TPDO     (CO_TXCAN_EMERG+CO_NO_EMERGENCY)        //start index for TPDO messages
   #define CO_TXCAN_SDO_SRV  (CO_TXCAN_TPDO+CO_NO_TPDO)              //start index for SDO server message (response)
   #define CO_TXCAN_SDO_CLI  (CO_TXCAN_SDO_SRV+CO_NO_SDO_SERVER)     //start index for SDO client message (request)
   #define CO_TXCAN_HB       (CO_TXCAN_SDO_CLI+CO_NO_SDO_CLIENT)     //index for Heartbeat message
   #define CO_TXCAN_USER     (CO_TXCAN_HB+1)                         //start index for user defined CANtx messages
   //total number of transmitted CAN messages
   #define CO_TXCAN_NO_MSGS (CO_NO_SYNC+CO_NO_EMERGENCY+CO_NO_TPDO+CO_NO_SDO_SERVER+CO_NO_SDO_CLIENT+1+CO_NO_USER_CANTX)


/*******************************************************************************
   Processor specific hardware macros
*******************************************************************************/
/* CANopen RUN and ERROR LED diodes */
   //CANopen standard led diodes can be connected to any two free output pins
   //of microcontroller. See manual or standard CiA DR-303-3 for more info.
   #ifndef PCB_DISABLE_CAN_LEDS_MACROS
      //Green RUN led *EXTERNAL*
      #define PCB_RUN_LED_INIT()
      #define PCB_RUN_LED(i)
      //Red ERROR led *EXTERNAL*
      #define PCB_ERROR_LED_INIT()
      #define PCB_ERROR_LED(i)
   #endif

/*******************************************************************************
   CANopen BASIC DATA TYPES AND VARIABLES
*******************************************************************************/
/* Data Types */
   #define UNSIGNED8  uint8_t
   #define UNSIGNED16 uint16_t
   #define UNSIGNED32 uint32_t
   #define INTEGER8   int8_t
   #define INTEGER16  int16_t
   #define INTEGER32  int32_t
   #define VISIBLE_STRING int8_t
   #define OCTET_STRING   uint8_t

/*******************************************************************************
   Processor specific software macros
*******************************************************************************/
/* Specifier for constant variables */
   //qualifier for variables located in read-only memory. C18 compiler put those
   //variables in flash memory space ('rom' qualifier). C30 compiler also put
   //those variables in flash memory space, but it uses 'const' qualifier. If
   //those variables are located in RAM, 'const' should be used.
   //ROM Variables in Object Dictionary MUST have attribute ATTR_ROM appended.
   //Anyway, those variables can also be written via CAN network. This is made
   //with different mechanisms on different microcontrollers.
   #define ROM             const    /*EXTERNAL*/

/* Macros for copying between Object Dictionary data objects */ /*EXTERNAL*/
   #define CO_memcpy(dst, src, len)          memcpy((void*)dst, (void*)src, len)
   #define CO_memcpyRom2Ram(dst, src, len)   memcpy(dst, (void*)src, len)
   #define memcpyRam2Rom(dst, src, len)      memcpy((void*)dst, src, len)

/* Macro for resetting microcontroller */
   #define CO_Reset()

/* Timer Interrupt service routine macros */
   //Short description of Timer Module operation on dsPIC30F:
   //Clock source is FCY, which increments TMRx (16 bit) register. When TMRx
   //value reaches value stored in period register (PRx, 16 bit), TMRx is
   //reset to zero and interrupt is generated. This interrupt then triggers
   //CO_TIMER_ISR timer procedure with time period 1 millisecond by default.

   //Timer interrupt frequency in [kHz]. If it is set to high or if there is
   //too much code to execute, timer overflow can occur. In that case the error
   //'ERROR_isr_timer_overflow' is reported and next cycle is not executed.
   //Base time unit in CANopenNode is millisecond. However, timer frequency
   //can be higher if there is a need for more accurate synchronous PDO
   //communication and if user timer procedure must run more frequently.
   //If there is no special need for speed, set frequency to 1 kHz.
   #ifndef CO_TIMER_ISR_FREQUENCY
      #define CO_TIMER_ISR_FREQUENCY   1     /*EXTERNAL*/
   #endif

    //Timer module registers
    //function specifiers and name
      #define CO_TIMER_ISR        void CO_Timer_Isr(void)
      #define CO_TMR_TMR          0             // TODO
      #define CO_TMR_PR           1             // TODO

   //acknowledge the timer interrupt (called on the beginning of the interrupt)
   #define CO_TIMER_ACKNOWLEDGE()      /*EXTERNAL*/

   //condition for timer overflow (verified on the end of the interrupt)
   #define CO_TIMER_IS_OVERFLOWED  0          /*EXTERNAL*/

   //Calculate timer bandwidth in [%] at the end of interrupt
   #define CO_CALCULATE_TIMER_BANDWIDTH()                                     \
      (unsigned int)(((unsigned long)CO_TMR_TMR) * 100 / CO_TMR_PR)

   //disable/enable all interrupts from mainline procedure
   #define CO_DISABLE_ALL()
   #define CO_ENABLE_ALL()
   //disable/enable timer interrupt from mainline procedure
   #define CO_DISABLE_TMR()
   #define CO_ENABLE_TMR()
   //disable/enable CANrx interrupt
   #define CO_DISABLE_CANRX()
   #define CO_ENABLE_CANRX()
   //disable/enable CANtx interrupt
   #define CO_DISABLE_CANTX()
   #define CO_ENABLE_CANTX()

/*******************************************************************************
   CAN module specific macros
*******************************************************************************/
/* Macros for reading CAN_ID and RTR bit from CO_RXCAN array member */
   //Macro returns 11 bit CAN identifier
   #define CO_RXCANread_CAN_ID(index) (CO_RXCAN[index].ident >> 5)

   //Macro returns true if RTR bit is set
   #define CO_RXCANread_RTR(index) (CO_RXCAN[index].ident & 0x10)

/* Macros for reading CAN_ID and RTR bit from CO_TXCAN array member */
   //Macro returns 11 bit CAN identifier
   #define CO_TXCANread_CAN_ID(index) (CO_TXCAN[index].ident >> 5)

   //Macro returns true if RTR bit is set
   #define CO_TXCANread_RTR(index) (CO_TXCAN[index].ident & 0x10)

/* This macro requests CAN configuration mode and waits untill it is set */
   #define CO_CAN_SET_CONFIGURATION_MODE()


/*******************************************************************************
   CANopen specific constants
*******************************************************************************/
/* NMT */
   //internal States
   #define NMT_INITIALIZING            0
   #define NMT_PRE_OPERATIONAL         127
   #define NMT_OPERATIONAL             5
   #define NMT_STOPPED                 4
   //commands
   #define NMT_ENTER_OPERATIONAL       1
   #define NMT_ENTER_STOPPED           2
   #define NMT_ENTER_PRE_OPERATIONAL   128
   #define NMT_RESET_NODE              129
   #define NMT_RESET_COMMUNICATION     130


/* Default COB-IDs */
   #define CAN_ID_NMT_SERVICE  0x000
   #define CAN_ID_SYNC         0x080
   #define CAN_ID_EMERGENCY    0x080   // + NODE ID
   #define CAN_ID_TIME_STAMP   0x100
   #define CAN_ID_TPDO0        0x180   // + NODE ID
   #define CAN_ID_RPDO0        0x200   // + NODE ID
   #define CAN_ID_TPDO1        0x280   // + NODE ID
   #define CAN_ID_RPDO1        0x300   // + NODE ID
   #define CAN_ID_TPDO2        0x380   // + NODE ID
   #define CAN_ID_RPDO2        0x400   // + NODE ID
   #define CAN_ID_TPDO3        0x480   // + NODE ID
   #define CAN_ID_RPDO3        0x500   // + NODE ID
   #define CAN_ID_TSDO         0x580   // + NODE ID
   #define CAN_ID_RSDO         0x600   // + NODE ID
   #define CAN_ID_HEARTBEAT    0x700   // + NODE ID

/*******************************************************************************
   Macros for Received CAN messages

   0 <= index < CO_RXCAN_NO_MSGS
*******************************************************************************/
/* Read configured values from CO_RXCAN */
   //Read CAN_ID from CO_RXCAN. (Macro is CAN module specific, so it is defined in CO_driver.h.)
   //#define CO_RXCANread_CAN_ID(index)
   //Read RTR from CO_RXCAN. (Macro is CAN module specific, so it is defined in CO_driver.h.)
   //#define CO_RXCANread_RTR(index)
   //Read noofbytes from CO_RXCAN.
   #define CO_RXCANreadnoofbytes(index)   CO_RXCANEXT[index].noofbytes
   //Read inhibit from CO_RXCAN.
   #define CO_RXCANreadinhibit(index)     CO_RXCANEXT[index].inhibit


/* How to Receive CAN messages */
   //First, CO_RXCAN must be configured (Take care, when CAN module filters are enabled).
   //Macro returns true, if new CAN message was received
   #define CO_RXCANisnewmsg(index)        CO_RXCAN[index].newmsg
   //Pointer to data in CO_RXCAN.
   #define CO_RXCANdata(index)            CO_RXCAN[index].data
   //Macro relelases the buffer, so it is available for new message
   //If buffer has inhibit bit set, overflow will cause error.
   #define CO_RXCANrelease(index)        CO_RXCAN[index].newmsg = 0


/*******************************************************************************
   Macros for Transmitted CAN messages

   0 <= index < CO_TXCAN_NO_MSGS
*******************************************************************************/
/* Read configured values from CO_TXCAN */
   //Read CAN_ID from CO_TXCAN. (Macro is CAN module specific, so it is defined in CO_driver.h.)
   //#define CO_TXCANread_CAN_ID(index)
   //Read RTR from CO_TXCAN. (Macro is CAN module specific, so it is defined in CO_driver.h.)
   //#define CO_TXCANread_RTR(index)
   //Read noofbytes from CO_TXCAN.
   #define CO_TXCANreadnoofbytes(index)   CO_TXCANEXT[index].noofbytes
   //Read inhibit from CO_TXCAN.
   #define CO_TXCANreadinhibit(index)     CO_TXCANEXT[index].inhibit

/* Transmit CAN messages */
   //First, CO_TXCAN must be configured.
   //Pointer to data in CO_TXCAN.
   #define CO_TXCANdata(index)            CO_TXCAN[index].data
   //Read only flag bit returns true, if old message was not yet sent
   #define CO_TXCANpending(index)         CO_TXCAN[index].newmsg

#endif

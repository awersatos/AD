/**

   CO_stack.c - Functions for CANopenNode - processor independent

   Copyright (C) 2004  Janez Paternoster, Slovenia

   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with this library; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA


   Author: janez.paternoster@siol.net

*/

#include <string.h>
#include "canopen.h"

/**
   VERIFY MACROS
*/
   #if CO_NO_SYNC != 0 && CO_NO_SYNC != 1
      #error define_CO_NO_SYNC (CO_NO_SYNC) not valid!
   #endif
   #if CO_NO_EMERGENCY != 0 && CO_NO_EMERGENCY != 1
      #error define_CO_NO_EMERGENCY (CO_NO_EMERGENCY) not valid!
   #endif
   #if CO_NO_SDO_SERVER < 0 || CO_NO_SDO_SERVER > 128
      #error define_CO_NO_SDO_SERVER (CO_NO_SDO_SERVER) not valid!
   #endif
   #if CO_NO_SDO_CLIENT < 0 || CO_NO_SDO_CLIENT > 128
      #error define_CO_NO_SDO_CLIENT (CO_NO_SDO_CLIENT) not valid!
   #endif
   #if CO_NO_RPDO < 0 || CO_NO_RPDO > 512
      #error define_CO_NO_RPDO (CO_NO_RPDO) not valid!
   #endif
   #if CO_NO_TPDO < 0 || CO_NO_TPDO > 512
      #error define_CO_NO_TPDO (CO_NO_TPDO) not valid!
   #endif
   #if CO_NO_TPDO > 0 || CO_NO_RPDO > 0
      #if CO_NO_RPDO_USAGE < 1 || CO_NO_RPDO_USAGE > 11
         #error define_CO_NO_RPDO_USAGE (CO_NO_RPDO_USAGE) not valid!
      #endif
      #if CO_NO_TPDO_USAGE < 1 || CO_NO_TPDO_USAGE > 11
         #error define_CO_NO_TPDO_USAGE (CO_NO_TPDO_USAGE) not valid!
      #endif
   #endif
   #if CO_NO_USER_CANRX < 0
      #error define_CO_NO_USER_CANRX (CO_NO_USER_CANRX) not valid!
   #endif
   #if CO_NO_USER_CANTX < 0
      #error define_CO_NO_USER_CANTX (CO_NO_USER_CANTX) not valid!
   #endif
   #if CO_RXCAN_NO_MSGS > 0xFFFF
      #error number of receiving messages CO_RXCAN_NO_MSGS too large!
   #endif
   #if CO_TXCAN_NO_MSGS > 0xFFFF
      #error number of transmiting messages CO_TXCAN_NO_MSGS too large!
   #endif
   #if CO_NO_MAX_OBJECT_SIZE < 4 || CO_NO_MAX_OBJECT_SIZE > 256
      #error define_CO_NO_MAX_OBJECT_SIZE (CO_NO_MAX_OBJECT_SIZE) not valid
   #endif
   #if CO_TIMER_ISR_FREQUENCY < 1 || CO_TIMER_ISR_FREQUENCY > 200
      #error define_CO_TIMER_ISR_FREQUENCY (CO_TIMER_ISR_FREQUENCY) not valid
   #endif


/**
   FUNCTION PROTOTYPES
*/
   //Implemented by user
   void User_ResetComm(void);
   void User_ProcessTimer(void);

   //from CO_driver.c
   void CO_Read_NodeId_BitRate(void);  //determine NodeId and BitRate
   void CO_SetupCAN(void);             //setup CAN controller
   void CO_ProcessDriver(void);        //process microcontroller specific code
   #if CO_NO_SYNC > 0
      void CO_ClearPendingSyncPDOs(void); //Clear all pending synchronous PDOs from CAN TX buffers
   #endif


/**
   VARIABLES
*/
//timer variables and macros (immune on overflow)
   volatile UNSIGNED16 CO_Timer16bit1ms = 0;   //16-bit variable, increments every 1ms
   volatile UNSIGNED8 CO_Timer8bit100ms = 0;   //8-bit variable, increments every 100ms
   #define TMR8Z(ttimerVariable) (UNSIGNED8)(ttimerVariable = CO_Timer8bit100ms)
   #define TMR8(ttimerVariable)  (UNSIGNED8)(CO_Timer8bit100ms - ttimerVariable)

//Counter for mainline procedure passes per 100 ms
   volatile UNSIGNED16 mainlineCounterPer100Ms = 0;

//when CO_TIMER_ISR is executing, this variable is set to 1. This way some functions
//distinguish between being called from mainline or timer functions
   volatile UNSIGNED8 CO_TIMER_ISR_isExecuting = 0;

//Status LEDs
   volatile CO_StatusLED_struct CO_StatusLED = {1, 0};

//CANopen nodeID
   UNSIGNED8 CO_NodeID;

//CAN transmit
   volatile UNSIGNED16 CO_TXCANcount;

//main variables for storing CAN messages, filled at CanInit, see CANopen.h for indexes
      volatile CO_CanMessage CO_RXCAN[CO_RXCAN_NO_MSGS];
      volatile CO_CanMsgExt  CO_RXCANEXT[CO_RXCAN_NO_MSGS];
      volatile UNSIGNED8 CO_RXDATA[8*CO_RXCAN_NO_MSGS];
      volatile CO_CanMessage CO_TXCAN[CO_TXCAN_NO_MSGS];
      volatile CO_CanMsgExt  CO_TXCANEXT[CO_TXCAN_NO_MSGS];
      volatile UNSIGNED8 CO_TXDATA[8*CO_TXCAN_NO_MSGS];

//NMT operating state of node
   volatile UNSIGNED8 CO_NMToperatingState;

//SYNC
   //If variable is true, Synchronous TPDOs are allowed to be sent
   volatile UNSIGNED8 CO_TimeIsInsideSyncWindow;
   #if CO_NO_SYNC > 0
      volatile UNSIGNED16 CO_SYNCwindow;  //window [timer period]
      UNSIGNED16 CO_SYNCperiod;           //period [Timer period]
      UNSIGNED16 CO_SYNCperiodTimeout;    //1,5 * CO_SYNCperiod [Timer period]
      UNSIGNED16 CO_SYNCperiodEarly;      //0,5 * CO_SYNCperiod [Timer period]
      UNSIGNED8  CO_SYNCproducer;         //if true, node is SYNC producer
   #endif

//Number of errors, Emergency message control and Error codes (see CO_errors.h)
   #ifdef ODL_preDefinedErrorField_arrayLength
      UNSIGNED8 CO_OD_preDefinedErrorField_NoOfErrors;
   #endif
   volatile struct{
      UNSIGNED16 CheckErrors     :1;
      UNSIGNED16 EmergencyToSend :1;
      UNSIGNED16 EmergencyErrorCode;
      UNSIGNED8 ErrorBit;
      UNSIGNED16 CodeVal;
   }ErrorControl;
   ROM UNSIGNED16 ErrorCodesTable[] = ERROR_CODES;

//HeartBeat Consumer (CO_RXCAN[CO_RXCAN_CONS_HB].data (except first byte) is not used by CAN receive)
   volatile UNSIGNED8 CO_HBcons_AllMonitoredOperational;
   UNSIGNED8 CO_HBcons_AllMonitoredOperationalCpy;
   #if ODL_consumerHeartbeatTime_arrayLength > 0
      volatile UNSIGNED8 CO_HBcons_NMTstate[ODL_consumerHeartbeatTime_arrayLength];
      UNSIGNED16 CO_HBcons_TimerValue[ODL_consumerHeartbeatTime_arrayLength];
      UNSIGNED16 CO_HBcons_Time[ODL_consumerHeartbeatTime_arrayLength];
      UNSIGNED8  CO_HBcons_MonStarted[ODL_consumerHeartbeatTime_arrayLength];
   #endif

   #define CO_SDO_TIMEOUT_TIME 10      //[in 100*ms], Timeout in SDO communication.
//SDO Server
   #if CO_NO_SDO_SERVER > 0
      struct{
         ROM sCO_OD_object* pODE;      //Location of curent object dictionary object
         UNSIGNED16  Index;            //Curent OD Index
         UNSIGNED8 SubIndex;           //Curent OD SubIndex
         UNSIGNED8 State;              //state of SDO server
                     //bit1: 1=segmented download in progress
                     //bit2: 1=segmented upload in progress
                     //bit4: toggle bit in previous object
         UNSIGNED8 Buff[CO_NO_MAX_OBJECT_SIZE]; //buffer for data
         UNSIGNED8 Length;             //Actual length of data
         #if CO_NO_MAX_OBJECT_SIZE > 0x04
            UNSIGNED8 BuffSize;        //position in Buff of next data segment being read/written
            UNSIGNED8 tTimeout;        //timeout timer
         #endif
      }CO_SDOserverVar[CO_NO_SDO_SERVER];
   #endif

//SDO Client
   #if CO_NO_SDO_CLIENT > 0
      struct{
         UNSIGNED8 State;              //state of SDO client
                     //bit1: 1=segmented download in progress
                     //bit2: 1=segmented upload in progress
                     //bit4: toggle bit in previous object
                     //bit6: 1=download initiated
                     //bit7: 1=upload initiated
         UNSIGNED8* pBuff;             //pointer to data buffer supplied by user
         UNSIGNED8 BuffMaxSize;        //by download: size of data in buffer; by upload: size of buffer
         UNSIGNED8 BuffSize;           //position in Buff of next data segment being read/written
         UNSIGNED8 tTimeout;           //timeout timer
      }CO_SDOclientVar[CO_NO_SDO_CLIENT];
   #endif

//PDOs
   #if CO_NO_RPDO > 0
      typedef struct{
         UNSIGNED8 enabled;            //Is RPDO enabled
         #if CO_NO_RPDO_USAGE > 6      //RPDO data are automatically copied to OD variables.
            UNSIGNED8* data[8];        //Pointers to 8 data objects, where PDO will be copied
         #endif
      }sCO_RPDOvar; 
      volatile sCO_RPDOvar CO_RPDOvar[CO_NO_RPDO];
   #endif

   #if CO_NO_TPDO > 0
      typedef struct{
         #if CO_NO_SYNC > 0
            UNSIGNED8 syncCount;       //SYNC counter used for trigger PDO sending
         #endif
         UNSIGNED8 enabled;            //Is TPDO enabled
         UNSIGNED16 inhibitTimer;      //Inhibit timer used for inhibit PDO sending
         UNSIGNED16 eventTimer;        //Event timer used for trigger PDO sending
         #if CO_NO_TPDO_USAGE > 6      //TPDO data are automatically copied to OD variables.
            UNSIGNED8* data[8];        //Pointers to 8 data objects, which will be copied to PDO
         #endif
      }sCO_TPDOvar;
      volatile sCO_TPDOvar CO_TPDOvar[CO_NO_TPDO];
      //through this variable application reports Change Of State and thus request sending
      UNSIGNED8 CO_TPDOsendRequest[CO_NO_TPDO];
   #endif


// converts *data to little endian
void swap(unsigned char attribute, unsigned char length, void *data){
    if(attribute&CO_ODA_MB_VALUE){
        switch(length){
            case 4:
                *((UNSIGNED32 *)data) = SWAP4(*((UNSIGNED32 *)data));
                break;
            case 2:
                *((UNSIGNED16 *)data) = SWAP2(*((UNSIGNED16 *)data));
                break;
        }
    }
}

/*******************************************************************************

   ERROR HANDLING FUNCTIONS

*******************************************************************************/

/**
 * @brief Report error condition
 *
 * Function is used to report any error occurred in program. It can be used from
 * mainline or interrupt. It sets appropriate error bit and sends emergency if
 * it is the first time for that bit. If critical bits are set, node will not be
 * able to enter operational state. For detailed description see CO_errors.h
 *
 * @param ErrorBit   specific error bit, use defined constants
 * @param Code         informative value, send as 4-th and 5-th byte in Emergency message
 *
 * @return Nothing.
*/
void ErrorReport(UNSIGNED8 ErrorBit, UNSIGNED16 Code){
   unsigned char index = ErrorBit >> 3;
   unsigned char bitmask = 1 << (ErrorBit & 0x7);

   //if ErrorBit value not supported, set ERROR_ErrorReport_ParametersNotSupp
   if(index > (ODL_errorStatusBits_stringLength-1)){
      index = 0; bitmask = 2;
   }
   if((OD_errorStatusBits[index]&bitmask) == 0){
      if(ErrorBit) OD_errorStatusBits[index] |= bitmask; //set bit, if NO_ERROR just send emergency
      ErrorControl.CheckErrors = 1;
      if(!ErrorControl.EmergencyToSend){  //free
         ErrorControl.EmergencyToSend = 1;
         ErrorControl.EmergencyErrorCode = ErrorCodesTable[ErrorBit];
         ErrorControl.ErrorBit = ErrorBit;
         ErrorControl.CodeVal = Code;
      }
   }
}


/**
 * @brief Reset error condition
 *
 * Function is used to report any if error condition is no more present. It can
 * be used from mainline or interrupt function. It resets appropriate error bit
 * and sends emergency 'no error'.
 * For detailed description see CO_errors.h
 *
 * @param ErrorBit  specific error bit, use defined constants
 * @param Code      informative value, send as 4-th and 5-th byte in Emergency message
 *
 * @return Nothing.
*/
void ErrorReset(UNSIGNED8 ErrorBit, UNSIGNED16 Code){
   UNSIGNED8 index = ErrorBit >> 3;
   UNSIGNED8 bitmask = 1 << (ErrorBit & 0x7);

   if(index > (ODL_errorStatusBits_stringLength-1)){
      ErrorReport(ERROR_ErrorReport_ParametersNotSupp, ErrorBit);
      return;
   }
   if((OD_errorStatusBits[index]&bitmask) != 0){
      OD_errorStatusBits[index] &= ~bitmask; //erase bit
      ErrorControl.CheckErrors = 1;
      if(!ErrorControl.EmergencyToSend){  //free
         ErrorControl.EmergencyToSend = 1;
         ErrorControl.EmergencyErrorCode = 0x0000; //no error
         ErrorControl.ErrorBit = ErrorBit;
         ErrorControl.CodeVal = Code;
      }
   }
}


/*******************************************************************************

   OBJECT DICTIONARY FUNCTIONS

*******************************************************************************/

/**
 * @brief Search Object Dictionary
 *
 * Function is used for searching object dictionary for object with specified index.
 *
 * @param index     address of object in object dictionary
 *
 * @return if found, pointer to object, otherwise 0
*/
ROM sCO_OD_object* CO_OD_find(UNSIGNED16 index){
   //Fast search in ordered Object Dictionary. If indexes are mixed, this won't work.
   //If CO_OD has up to 2^N entries, then N is max number of loop passes.
   UNSIGNED16 cur, min, max;
   ROM sCO_OD_object* object;
   min = 0;
   max = CO_OD_NoOfElements - 1;
   while(min < max){
      cur = (min + max) / 2;
      object = &CO_OD[cur];
      //Is object matched
      if(index == object->index) return object;
      if(index < object->index){
         max = cur;
         if(max) max--;
      }
      else
         min = cur + 1;
   }
   if(min == max){
      object = &CO_OD[min];
      //Is object matched
      if(index == object->index) return object;
   }
   return 0;  //object does not exist in OD
}

/**
 * @brief get length of specific object in OD
 *
 * Function returns length of given object with specific subIndex. If Object
 * Type is Record, then length is located in special structure.
 *
 * @param object        CO_OD object
 * @param subIndex      subIndex in given object
 *
 * @return CO_OD variable length.
*/
UNSIGNED8 CO_OD_getLength(ROM sCO_OD_object* object, UNSIGNED8 subIndex){
  if(object->length){//object type is var or array
    if(subIndex == 0 && object->subNumber > 1) return 1;  //object type is array
    return object->length;
  }
  return ((ROM ODrecord*)(object->pData))[subIndex].length;
}

/**
 * @brief get attribute of specific object in OD
 *
 * Function returns attribute of given object with specific subIndex. If Object
 * Type is Record, then attribute is located in special structure.
 * SUBINDEX 0 DOES NOT WORK ALWAYS CORRECT, IF OBJECT TYPE IS ARRAY!
 *
 * @param object    CO_OD object
 * @param subIndex  subIndex in given object
 *
 * @return CO_OD attribute.
*/
UNSIGNED8 CO_OD_getAttribute(ROM sCO_OD_object* object, UNSIGNED8 subIndex){
  if(object->length){//object type is var or array
    UNSIGNED8 attr = object->attribute;
    if(subIndex == 0 && object->subNumber > 1) return (attr&0x03) | 0x04;  //object type is array
    return attr;
  }
  return ((ROM ODrecord*)(object->pData))[subIndex].attribute;
}

/**
 * @brief Get data pointer of specific object in OD
 *
 * Function returns pointer to data buffer, which is attached to specific object and
 * has specific subIndex. SUBINDEX 0 DOES NOT WORK, IF OBJECT TYPE IS ARRAY!
 *
 * @param object   CO_OD object
 * @param subIndex subIndex in given object
 *
 * @return pointer to data.
*/
ROM void* CO_OD_getDataPointer(ROM sCO_OD_object* object, UNSIGNED8 subIndex){
   //Object Type is Var
   if(object->subNumber == 1) return object->pData;
   //Object Type is Array
   if(object->length){
      if(subIndex==0){
         //this is the data, for the subIndex 0 in the array
         static UNSIGNED8 data;
         data = object->subNumber - 1;
         return (ROM void*) &data;
      }
      return (ROM void*)(((ROM INTEGER8*)object->pData) + ((subIndex-1) * object->length));
   }
   //Object Type is Record, data pointer is located in special structure.
   return ((ROM ODrecord*)(object->pData))[subIndex].pData;
}

#define READING (dir==0)
#define WRITING (dir==1)
/**
 * @brief SDO SERVER ACCESS FUNCTIONS
 *
 * SDO server access functions are called through function pointer, which is
 * assigned to each object in Object Dictionary. Functions are called by SDO
 * Server, which reads (or writes) value from (to) specific Object. For more
 * information see manual.
 *
 * @param (sub)index  address of object in object dictionary (informative)
 * @param attribute   attribute of object in object dictionary (informative)
 * @param length      length of data
 * @param dir         0 when reading, 1 when writing
 * @param dataBuff    pointer to RAM data buffer
 * @param pData*      pointer to variable in Object Dictionary
 *
 * @return 0 if success, otherwise abort code
*/
UNSIGNED32 CO_ODF(UNSIGNED16 index, UNSIGNED8 subIndex, UNSIGNED8 attribute,
                     UNSIGNED8 length, UNSIGNED8 dir, void* dataBuff, ROM void* pData){
//Default function for accessing variables from Object Dictionary.
   if(attribute&CO_ODA_MEM_RAM){
      //variable in RAM
      if(READING){  //Reading Object Dictionary variable
         CO_DISABLE_ALL();
         CO_memcpy(dataBuff, pData, length);
         CO_ENABLE_ALL();
      }
      else{ //Writing Object Dictionary variable
         CO_DISABLE_ALL();
         CO_memcpy(pData, dataBuff, length);
         CO_ENABLE_ALL();
      }
   }
   else{
      //variable in ROM
      if(READING){
         #if CO_NO_RETENTIVE_USAGE==1 || CO_NO_RETENTIVE_USAGE==3 || CO_NO_RETENTIVE_USAGE==5 || CO_NO_RETENTIVE_USAGE==7
            CO_DISABLE_ALL();
            CO_memcpy(dataBuff, pData, length);
            CO_ENABLE_ALL();
         #else
            CO_DISABLE_ALL();
            CO_memcpyRom2Ram(dataBuff, pData, length);
            CO_ENABLE_ALL();
         #endif
      }
      else{
         #if CO_NO_RETENTIVE_USAGE==1 || CO_NO_RETENTIVE_USAGE==3 || CO_NO_RETENTIVE_USAGE==5 || CO_NO_RETENTIVE_USAGE==7
            CO_DISABLE_ALL();
            CO_memcpy(pData, dataBuff, length);
            CO_ENABLE_ALL();
         #elif CO_NO_RETENTIVE_USAGE==4 || CO_NO_RETENTIVE_USAGE==6
            CO_DISABLE_ALL();
            memcpyRam2Rom(pData, dataBuff, length);
            CO_ENABLE_ALL();
         #else
            return 0x06010002L;     //Attempt to write a read only object
         #endif
      }
   }
   return 0L;
}


//Function for accessing OD_preDefinedErrorField (index 0x1003)
#ifdef ODL_preDefinedErrorField_arrayLength
UNSIGNED32 CO_ODF_1003(UNSIGNED16 index, UNSIGNED8 subIndex, UNSIGNED8 attribute,
                          UNSIGNED8 length, UNSIGNED8 dir, void* dataBuff, ROM void* pData){

   if(subIndex==0) pData = (ROM void*) &CO_OD_preDefinedErrorField_NoOfErrors;

   if(READING){
      if(subIndex > CO_OD_preDefinedErrorField_NoOfErrors) return 0x08000024L;  //No data available.
   }
   else{
      //only '0' may be written to subIndex 0
      if(subIndex==0 && *((UNSIGNED8*)dataBuff)!=0)
         return 0x06090030L;  //Invalid value for parameter
      else
         return 0x06010002L;  //Attempt to write a read only object.
   }

   return CO_ODF(index, subIndex, attribute, length, dir, dataBuff, pData);

}
#endif


//Function for accessing OD_consumerHeartbeatTime (index 0x1016)
//Heartbeat monitoring parameters are updated on communication reset
#if ODL_consumerHeartbeatTime_arrayLength > 0
UNSIGNED32 CO_ODF_1016(UNSIGNED16 index, UNSIGNED8 subIndex, UNSIGNED8 attribute,
                          UNSIGNED8 length, UNSIGNED8 dir, void* dataBuff, ROM void* pData){

   if(WRITING){
      UNSIGNED8 i;
      UNSIGNED32 dataBuffCopy = *(UNSIGNED32*)dataBuff;
      UNSIGNED8 NodeID = (dataBuffCopy>>16) & 0xFF;
      UNSIGNED16 HBconsTime = dataBuffCopy & 0xFFFF;

      if(dataBuffCopy & 0xFF000000)
         return 0x06040043L;  //General parameter incompatibility reason.

      if(HBconsTime && NodeID){
         //there must not be more entries with same index and time different than zero
         for(i = 0; i<ODL_consumerHeartbeatTime_arrayLength; i++){
            UNSIGNED32 objectCopy = OD_consumerHeartbeatTime[i];
            UNSIGNED8 NodeIDObj = (objectCopy>>16) & 0xFF;
            UNSIGNED16 HBconsTimeObj = objectCopy & 0xFFFF;
            if((subIndex-1)!=i && HBconsTimeObj && (NodeID == NodeIDObj))
               return 0x06040043L;  //General parameter incompatibility reason.
         }
      }
   }

   return CO_ODF(index, subIndex, attribute, length, dir, dataBuff, pData);

}
#endif


/*******************************************************************************
 * @brief Configure RPDO Communication parameters
 *
 * Function is called from commuincation reset or when parameter changed.
 *
 * @param Index       index of RPDO (0 = first RPDO)
 *
 * @return Nothing.
*******************************************************************************/
#if CO_NO_RPDO > 0
   void CO_RPDOconfigCom(UNSIGNED16 i){
      UNSIGNED16 ID;

      //is RPDO used?
      if((OD_RPDOCommunicationParameter[i].COB_IDUsedByRPDO & 0x80000000L) == 0
         #if CO_NO_RPDO_USAGE > 3
         && OD_RPDOMappingParameter[i].numberOfMappedObjects
         #endif
         ){
         ID = (UNSIGNED16)OD_RPDOCommunicationParameter[i].COB_IDUsedByRPDO;
         //is used default COB-ID?
         if(ID==(CAN_ID_RPDO0 + 0x100*i) && i<4) ID += CO_NodeID;
         CO_RPDOvar[i].enabled = 1;
      }
      else{
         ID = 0;
         CO_RPDOvar[i].enabled = 0;
      }

      CO_RXCANconfigure(i+CO_RXCAN_RPDO, ID/*CAN_ID*/, 0/*RTR*/, CO_RXCANEXT[i+CO_RXCAN_RPDO].noofbytes/*Len*/, 0/*Inh*/);

   }
#endif

#if CO_NO_TPDO > 0
/**
 * @brief Configure TPDO Communication parameters
 *
 * Function is called from commuincation reset or when parameter changed.
 *
 * @param Index       index of TPDO (0 = first TPDO)
 *
 * @return Nothing.
*/
   void CO_TPDOconfigCom(UNSIGNED16 i){
      UNSIGNED16 ID;
      UNSIGNED8 inhibit = 0;
      ROM ODs_TPDOCommunicationParameter* TPDOparam = &OD_TPDOCommunicationParameter[i];
      volatile sCO_TPDOvar* TPDOvar = &CO_TPDOvar[i];

      //is TPDO used?
      if((TPDOparam->COB_IDUsedByTPDO & 0x80000000L) == 0
         #if CO_NO_TPDO_USAGE > 3
         && OD_TPDOMappingParameter[i].numberOfMappedObjects
         #endif
         ){
         ID = (UNSIGNED16)TPDOparam->COB_IDUsedByTPDO;
         #if CO_NO_SYNC > 0
            if((TPDOparam->transmissionType-1) < 253){
               inhibit = 1; //mark Synchronous TPDOs
               TPDOvar->syncCount = TPDOparam->transmissionType;
            }
         #endif
         //is used default COB-ID?
         if(ID==(CAN_ID_TPDO0 + 0x100*i) && i<4) ID += CO_NodeID;
         TPDOvar->enabled = 1;
      }
      else{
         ID = 0;
         TPDOvar->enabled = 0;
      }

      CO_TXCANconfigure(i+CO_TXCAN_TPDO, ID/*CAN_ID*/, 0/*RTR*/, CO_TXCANEXT[i+CO_TXCAN_TPDO].noofbytes/*Len*/, inhibit/*Inh*/);

      //configure variables
      TPDOvar->inhibitTimer = 0;
      TPDOvar->eventTimer = TPDOparam->eventTimer;
      CO_TPDOsendRequest[i] = 0;
   }
#endif


#if (CO_NO_RPDO_USAGE > 6 || CO_NO_TPDO_USAGE > 6) && (CO_NO_RPDO > 0 || CO_NO_TPDO > 0)
/**
 * @brief Find mapped variable
 *
 * Function is called from CO_xPDOconfigMap or when mapping parameter changed.
 *
 * @param map:     PDO mapping parameter
 * @param R_T:     0 for RPDO map, 1 for TPDO map
 * @param length:  pointer to curent PDO length. length will be increased for length in map (also returning parameter)
 * @param ppData:  pointer to pointer of mapped data (returning parameter)
 * @param ppTPDOflags: pointer to pointer of TPDO flags (returning parameter)
 *
 * @return  0 - success
 *          1 - Error: Wrong PDO mapping (not used here)
 *          2 - Error: Data length is not byte aligned (0x06040043L  General parameter incompatibility reason.)
 *          3 - Error: 0x06040042L  The number and length of the objects to be mapped would exceed PDO length.
 *          4 - Error: 0x06020000L  Object does not exist in the object dictionary.
 *          5 - Error: 0x06040041L  Object cannot be mapped to the PDO.
 *          7 - Error: Length of variable < map length (0x06040043L  General parameter incompatibility reason.)
 */
   UNSIGNED8 CO_PDOfindMap(UNSIGNED32 map, UNSIGNED8 R_T, UNSIGNED8* length,
                              UNSIGNED8** ppData, UNSIGNED16** ppTPDOflags){
      ROM sCO_OD_object* pODE;
      UNSIGNED8 attr;
      UNSIGNED16 index;
      UNSIGNED8 subIndex;

      index = (UNSIGNED16)(map>>16);
      subIndex = (UNSIGNED8)(map>>8);
      UNSIGNED8 dataLen = (UNSIGNED8) map;   //data length in bits

      //data length must be byte aligned
      if(dataLen&0x07) return 2;

      dataLen >>= 3;    //new data length is in bytes
      *length += dataLen;

      //total PDO length can not be more than 8 bytes
      if(*length > 8) return 3;

      //is there a reference to dummy entries
      if(index >= 2 && index <=7 && subIndex == 0){
         static UNSIGNED32 dummyTX = 0;
         static UNSIGNED32 dummyRX;
         UNSIGNED8 dummySize = 4;

         if(index==2 || index==5) dummySize = 1;
         else if(index==3 || index==6) dummySize = 2;

         //is size of variable big enough for map
         if(dummySize < dataLen) return 7;

         //Data and ODE pointer
         if(R_T == 0) *ppData = (UNSIGNED8*) &dummyRX;
         else         *ppData = (UNSIGNED8*) &dummyTX;
         *ppTPDOflags = 0;

         return 0;
      }

      //find object in Object Dictionary
      pODE = CO_OD_find(index);

      //Does object exist in OD?
      if(!pODE || subIndex >= pODE->subNumber) return 4;

      attr = CO_OD_getAttribute(pODE, subIndex);
      //Is object Mappable for RPDO?
      if(R_T==0 && !(attr&CO_ODA_RPDO_MAPABLE && attr&CO_ODA_WRITEABLE && attr&CO_ODA_MEM_RAM)) return 5;
      //Is object Mappable for TPDO?
      if(R_T!=0 && !(attr&CO_ODA_TPDO_MAPABLE && attr&CO_ODA_READABLE && attr&CO_ODA_MEM_RAM)) return 5;

      //is size of variable big enough for map
      if(CO_OD_getLength(pODE, subIndex) < dataLen) return 7;

      //Data and TPDO flags
      *ppData = (UNSIGNED8*) CO_OD_getDataPointer(pODE, subIndex);
      
      if(attr&CO_ODA_TPDO_REQUESTABLE) *ppTPDOflags = ((UNSIGNED16*) *ppData) - 1;
      else *ppTPDOflags = 0;

      return 0;
   }
#endif


#if CO_NO_RPDO > 0
/**
 * @brief Configure RPDO Mapping Parameters
 *
 * Function is called from commuincation reset or when parameter changed.
 *
 * @param Index       index of RPDO (0 = first RPDO)
 *
 * @return 0 - success,
 *         other - Error: see CO_PDOfindMap function description
 */
   UNSIGNED8 CO_RPDOconfigMap(UNSIGNED16 i){
      UNSIGNED8 length;
      UNSIGNED8 ret = 0;

      //Mapping parameters does not exist. Length of RPDO is any.
      #if CO_NO_RPDO_USAGE <= 3
         length = 9;

      //Mapping parameters are read-only. Length of RPDO is calculated
      //from Mapping. RPDO data are NOT automatically copied to OD variables.
      #elif CO_NO_RPDO_USAGE <= 6
         UNSIGNED8 j;
         UNSIGNED32* pMap = &OD_RPDOMappingParameter[i].mappedObject1;

         length = 7;  //round up to use whole byte
         for(j=OD_RPDOMappingParameter[i].numberOfMappedObjects; j>0; j--)
            length += (UNSIGNED8)*(pMap++);
         length >>= 3;
         if(length > 8){
            length = 9;  //size of RPDO is not important
         }

      //RPDO data are automatically copied to OD variables.
      #else
         UNSIGNED8 j;
         UNSIGNED32* pMap = (UNSIGNED32*) &(OD_RPDOMappingParameter[i].mappedObject1);

         length = 0;
         for(j=OD_RPDOMappingParameter[i].numberOfMappedObjects; j>0; j--){
            UNSIGNED8 k;
            UNSIGNED8* pData;
            UNSIGNED16* pTPDOflags;
            UNSIGNED8 prevLength = length;

            //function do much checking of errors in map
            ret = CO_PDOfindMap(*(pMap++), 0, &length, &pData, &pTPDOflags);
            if(ret){
               length = 0;
               break;
            }
            //write PDO data pointers
            for(k=prevLength; k<length; k++){
               CO_RPDOvar[i].data[k] = pData++;
            }
         }
      #endif

      CO_RXCANEXT[i+CO_RXCAN_RPDO].noofbytes = length;

      return ret;
   }
#endif


#if CO_NO_TPDO > 0
/**
 * @brief Configure TPDO Mapping Parameters
 *
 * Function is called from commuincation reset or when parameter changed.
 *
 * @param Index      index of TPDO (0 = first TPDO)
 *
 * @return 0 - success,
 *         1 - Error: Wrong PDO mapping,
 *         other - Error: see CO_PDOfindMap function description.
 */
   UNSIGNED8 CO_TPDOconfigMap(UNSIGNED16 i){
      UNSIGNED8 length;
      UNSIGNED8 ret = 0;

      //Mapping parameters does not exist. Default length of TPDO is 8 bytes.
      #if CO_NO_TPDO_USAGE <= 3
         length = 8;

      //Mapping parameters are read-only. Length of TPDO is calculated
      //from Mapping. TPDO data are NOT automatically copied from OD variables.
      #elif CO_NO_TPDO_USAGE <= 6
         UNSIGNED8 j;
         UNSIGNED32* pMap = (UNSIGNED32*) &(OD_TPDOMappingParameter[i].mappedObject1);

         length = 7;  //round up to use whole byte
         for(j=OD_TPDOMappingParameter[i].numberOfMappedObjects; j>0; j--)
            length += (UNSIGNED8)*(pMap++);
         length >>= 3;
         if(length > 8){
            length = 0;
            ret = 1;
         }

      //TPDO data are automatically copied from OD variables.
      #else
         UNSIGNED8 j;
         UNSIGNED32* pMap = (UNSIGNED32*) &(OD_TPDOMappingParameter[i].mappedObject1);

         length = 0;
         for(j=OD_TPDOMappingParameter[i].numberOfMappedObjects; j>0; j--){
            UNSIGNED8 k;
            UNSIGNED8* pData;
            UNSIGNED16* pTPDOflags;
            UNSIGNED8 prevLength = length;

            //function do much checking of errors in map
            ret = CO_PDOfindMap(*(pMap++), 1, &length, &pData, &pTPDOflags);
            if(ret){
               length = 0;
               break;
            }
            //is this a Change of State report capable variable
            if(pTPDOflags){
               //set TPDO flags for curent variable, so application can request TPDO, to which variable is mapped.
               if(i<16) *pTPDOflags |= (UNSIGNED16)1 << i;
            }
            //write PDO data pointers
            for(k=prevLength; k<length; k++){
               CO_TPDOvar[i].data[k] = pData++;
            }
         }
      #endif

      CO_TXCANEXT[i+CO_TXCAN_TPDO].noofbytes = length;

      return ret;
   }
#endif


#if CO_NO_RPDO > 0
//Function for accessing RPDO Communication Parameters
UNSIGNED32 CO_ODF_RPDOcom(UNSIGNED16 index, UNSIGNED8 subIndex, UNSIGNED8 attribute,
                             UNSIGNED8 length, UNSIGNED8 dir, void* dataBuff, ROM void* pData){

   UNSIGNED16 PDOindex = index - 0x1400;
   UNSIGNED16 defaultCOB_ID = (UNSIGNED16)CAN_ID_RPDO0 + 0x100*PDOindex;

   if(READING){
      UNSIGNED32 abortCode;
      abortCode = CO_ODF(index, subIndex, attribute, length, dir, dataBuff, pData);
      if(abortCode==0 && subIndex==1){
         //if default COB ID is used, write default value here
         if(*((UNSIGNED16*)dataBuff) == defaultCOB_ID && PDOindex < 4)
            *((UNSIGNED16*)dataBuff) = defaultCOB_ID + CO_NodeID;
         //bit 30 is 1
         *((UNSIGNED32*)dataBuff) |= 0x40000000L;
      }
      return abortCode;
   }

   //Writing Object Dictionary variable
   #if CO_NO_RPDO_USAGE==1 || CO_NO_RPDO_USAGE==4 || CO_NO_RPDO_USAGE==7
      return 0x06010002L;  //Attempt to write a read only object.
   #else
   else{
      UNSIGNED32 dataBuffCopy, abortCode;

      switch(subIndex){
       case 1: //COB_ID
         dataBuffCopy = *((UNSIGNED32*)dataBuff);
         //bits 11...29 must be zero
         if(dataBuffCopy&0x3FFF8000L)
            return 0x06040043L;  //General parameter incompatibility reason.
         //bit 30 must be 1
         dataBuffCopy |= 0x40000000L;
         //if default COB-ID is being written, write zero to parameter
         if(PDOindex < 4 && (UNSIGNED16)dataBuffCopy == (defaultCOB_ID + CO_NodeID)){
            dataBuffCopy &= 0xC0000000L;
            dataBuffCopy += defaultCOB_ID;
         }
         break;

       case 2: //Transmission_type
         dataBuffCopy = *((UNSIGNED8*)dataBuff);
         //values from 241...253 are not valid
         if(dataBuffCopy>=241 && dataBuffCopy<=253)
            return 0x06040043L;  //General parameter incompatibility reason.
         break;
      }

      abortCode = CO_ODF(index, subIndex, attribute, length, dir, (void*)(&dataBuffCopy), pData);

      //Configure RPDO
      #if CO_NO_RPDO_USAGE == 3 || CO_NO_RPDO_USAGE == 6 || CO_NO_RPDO_USAGE == 9 || CO_NO_RPDO_USAGE == 11
         if(abortCode == 0 && subIndex == 1){
            CO_DISABLE_ALL();
            CO_RPDOconfigCom(PDOindex);
            CO_ENABLE_ALL();
         }
      #endif

      return abortCode;
   }
   #endif
}
#endif


#if CO_NO_TPDO > 0
//Function for accessing TPDO Communication Parameters
UNSIGNED32 CO_ODF_TPDOcom(UNSIGNED16 index, UNSIGNED8 subIndex, UNSIGNED8 attribute,
                             UNSIGNED8 length, UNSIGNED8 dir, void* dataBuff, ROM void* pData){

   UNSIGNED16 PDOindex = index - 0x1800;
   UNSIGNED16 defaultCOB_ID = (UNSIGNED16)CAN_ID_TPDO0 + 0x100*PDOindex;
   
   if(subIndex==4) return 0x06090011L;  //Sub-index does not exist.

   //Reading Object Dictionary variable
   if(READING){
      UNSIGNED32 abortCode;
      abortCode = CO_ODF(index, subIndex, attribute, length, dir, dataBuff, pData);
      if(abortCode==0 && subIndex==1){
         //if default COB ID is used, write default value here
         if(*((UNSIGNED16*)dataBuff) == defaultCOB_ID && PDOindex < 4)
            *((UNSIGNED16*)dataBuff) = defaultCOB_ID + CO_NodeID;
         //bit 30 is 1
         *((UNSIGNED32*)dataBuff) |= 0x40000000L;
      }
      return abortCode;
   }

   //Writing Object Dictionary variable
   #if CO_NO_TPDO_USAGE==1 || CO_NO_TPDO_USAGE==4 || CO_NO_TPDO_USAGE==7
      return 0x06010002L;  //Attempt to write a read only object.
   #else
   else{
      UNSIGNED32 dataBuffCopy, abortCode;

      switch(subIndex){
       case 1: //COB_ID
         dataBuffCopy = *((UNSIGNED32*)dataBuff);
         //bits 11...29 must be zero
         if(dataBuffCopy&0x3FFF8000L)
            return 0x06040043L;  //General parameter incompatibility reason.
         //bit 30 must be 1
         dataBuffCopy |= 0x40000000L;
         //if default COB-ID is being written, write zero to parameter
         if(PDOindex < 4 && (UNSIGNED16)dataBuffCopy == (defaultCOB_ID + CO_NodeID)){
            dataBuffCopy &= 0xC0000000L;
            dataBuffCopy += defaultCOB_ID;
         }
         break;

       case 2: //Transmission_type
         dataBuffCopy = *((UNSIGNED8*)dataBuff);
         //values from 241...253 are not valid
         if(dataBuffCopy>=241 && dataBuffCopy<=253)
            return 0x06040043L;  //General parameter incompatibility reason.
         break;

       case 3: //Inhibit_Time
         dataBuffCopy = *((UNSIGNED16*)dataBuff);
         break;

       case 5: //Event_Timer
         dataBuffCopy = *((UNSIGNED16*)dataBuff);
         break;
      }

      abortCode = CO_ODF(index, subIndex, attribute, length, dir, (void*)(&dataBuffCopy), pData);

      //Configure TPDO
      if(abortCode == 0){
         #if CO_NO_TPDO_USAGE == 3 || CO_NO_TPDO_USAGE == 6 || CO_NO_TPDO_USAGE == 9 || CO_NO_TPDO_USAGE == 11
            if(subIndex == 1){   //COB-ID
               CO_DISABLE_ALL();
               CO_TPDOconfigCom(PDOindex);
               CO_ENABLE_ALL();
            }
         #endif
   
         #if CO_NO_SYNC > 0
            if(subIndex == 2){   //Transmission_type
               CO_TPDOvar[PDOindex].syncCount = OD_TPDOCommunicationParameter[PDOindex].transmissionType;
            }
         #endif
         
         if(subIndex == 3){   //Inhibit_Time
            CO_TPDOvar[PDOindex].inhibitTimer = 0;
         }
         else if(subIndex == 5){   //Event_Timer
            CO_TPDOvar[PDOindex].eventTimer = OD_TPDOCommunicationParameter[PDOindex].eventTimer;
         }
      }

      return abortCode;
   }
   #endif
}
#endif


#if CO_NO_RPDO > 0 && CO_NO_RPDO_USAGE > 3
//Function for accessing RPDO Mapping Parameters
UNSIGNED32 CO_ODF_RPDOmap(UNSIGNED16 index, UNSIGNED8 subIndex, UNSIGNED8 attribute,
                             UNSIGNED8 length, UNSIGNED8 dir, void* dataBuff, ROM void* pData){

   UNSIGNED16 PDOindex = index - 0x1600;

   //Reading Object Dictionary variable
   if(READING){
      return CO_ODF(index, subIndex, attribute, length, dir, dataBuff, pData);
   }

   //Writing Object Dictionary variable
   else{
      #if CO_NO_RPDO_USAGE < 10
         return 0x06010002L;  //Attempt to write a read only object.
      #else
         UNSIGNED32 dataBuffCopy, abortCode;

         //number of entries
         if(subIndex == 0){
            dataBuffCopy = *((UNSIGNED8*)dataBuff);
            if(dataBuffCopy > 8)
               return 0x06090031L;  //Value of parameter written too high.
         }
   
         //mapping
         else{
            UNSIGNED8 length = 0;
            UNSIGNED8* pData;
            UNSIGNED16* pTPDOflags;
            UNSIGNED8 ret;
   
            if(OD_RPDOMappingParameter[PDOindex].numberOfMappedObjects != 0){
               return 0x06010000L;  //Unsupported access to an object.
            }
            dataBuffCopy = *((UNSIGNED32*)dataBuff);

            //verify if mapping is correct
            ret = CO_PDOfindMap(dataBuffCopy, 0, &length, &pData, &pTPDOflags);
            //if ret is not zero, report error
            switch(ret){
               case 2: return 0x06040043L;  //General parameter incompatibility reason. (Data length is not byte aligned.)
               case 3: return 0x06040042L;  //The number and length of the objects to be mapped would exceed PDO length.
               case 4: return 0x06020000L;  //Object does not exist in the object dictionary.
               case 5: return 0x06040041L;  //Object cannot be mapped to the PDO.
               case 7: return 0x06040043L;  //General parameter incompatibility reason. (Length of variable < map length)
            }
         }

         abortCode = CO_ODF(index, subIndex, attribute, length, dir, (void*)(&dataBuffCopy), pData);

         //Configure mapping
         #if CO_NO_RPDO_USAGE == 11
            if(abortCode == 0 && subIndex == 0){
               //number of entries was set to zero -> disable PDO
               if(OD_RPDOMappingParameter[PDOindex].numberOfMappedObjects == 0){
                  CO_RPDOvar[PDOindex].enabled = 0;
               }
               //number of entries was set to non zero -> recalculate PDO mapping
               else{
                  UNSIGNED8 ret;
                  CO_DISABLE_ALL();
                  ret = CO_RPDOconfigMap(PDOindex);
                  if(ret){
                     ErrorReport(ERROR_wrong_PDO_mapping, ret<<8 | PDOindex);
                     CO_RPDOvar[PDOindex].enabled = 0;
                  }
                  else if((OD_RPDOCommunicationParameter[PDOindex].COB_IDUsedByRPDO & 0x80000000L) == 0){
                     CO_RPDOvar[PDOindex].enabled = 1;
                  }
                  CO_ENABLE_ALL();
               }
            }
         #endif
      
         return abortCode;

      #endif

   }//end of Writing Object Dictionary variable

}
#endif


#if CO_NO_TPDO > 0 && CO_NO_TPDO_USAGE > 3
//Function for accessing TPDO Mapping Parameters
UNSIGNED32 CO_ODF_TPDOmap(UNSIGNED16 index, UNSIGNED8 subIndex, UNSIGNED8 attribute,
                             UNSIGNED8 length, UNSIGNED8 dir, void* dataBuff, ROM void* pData){

   UNSIGNED16 PDOindex = index - 0x1A00;

   //Reading Object Dictionary variable
   if(READING){
      return CO_ODF(index, subIndex, attribute, length, dir, dataBuff, pData);
   }

   //Writing Object Dictionary variable
   else{
      #if CO_NO_TPDO_USAGE < 10
         return 0x06010002L;  //Attempt to write a read only object.
      #else
         UNSIGNED32 dataBuffCopy, abortCode;
   
         //number of entries
         if(subIndex == 0){
            dataBuffCopy = *((UNSIGNED8*)dataBuff);
            if(dataBuffCopy > 8)
               return 0x06090031L;  //Value of parameter written too high.
         }
   
         //mapping
         else{
            UNSIGNED8 length = 0;
            UNSIGNED8* pData;
            UNSIGNED16* pTPDOflags;
            UNSIGNED8 ret;

            if(OD_TPDOMappingParameter[PDOindex].numberOfMappedObjects != 0){
               return 0x06010000L;  //Unsupported access to an object.
            }
            dataBuffCopy = *((UNSIGNED32*)dataBuff);
   
            //verify if mapping is correct
            ret = CO_PDOfindMap(dataBuffCopy, 1, &length, &pData, &pTPDOflags);
            //if ret is not zero, report error
            switch(ret){
               case 2: return 0x06040043L;  //General parameter incompatibility reason. (Data length is not byte aligned.)
               case 3: return 0x06040042L;  //The number and length of the objects to be mapped would exceed PDO length.
               case 4: return 0x06020000L;  //Object does not exist in the object dictionary.
               case 5: return 0x06040041L;  //Object cannot be mapped to the PDO.
               case 7: return 0x06040043L;  //General parameter incompatibility reason. (Length of variable < map length)
            }
         }
   
         abortCode = CO_ODF(index, subIndex, attribute, length, dir, (void*)(&dataBuffCopy), pData);
   
         //Configure mapping
         #if CO_NO_TPDO_USAGE == 11
            if(abortCode == 0 && subIndex == 0){
               //number of entries was set to zero -> disable PDO
               if(OD_TPDOMappingParameter[PDOindex].numberOfMappedObjects == 0){
                  CO_TPDOvar[PDOindex].enabled = 0;
               }
               //number of entries was set to non zero -> recalculate PDO mapping
               else{
                  UNSIGNED8 ret;
                  CO_DISABLE_ALL();
                  ret = CO_TPDOconfigMap(PDOindex);
                  if(ret){
                     ErrorReport(ERROR_wrong_PDO_mapping, ret<<8 | PDOindex);
                     CO_TPDOvar[PDOindex].enabled = 0;
                  }
                  else if((OD_TPDOCommunicationParameter[PDOindex].COB_IDUsedByTPDO & 0x80000000L) == 0){
                     CO_TPDOvar[PDOindex].enabled = 1;
                  }
                  CO_ENABLE_ALL();
               }
            }
         #endif
      
         return abortCode;

      #endif

   }//end of Writing Object Dictionary variable

}
#endif

#undef READING
#undef WRITING

/*******************************************************************************

   PROCESS DATA OBJECT (PDO) FUNCTIONS

*******************************************************************************/

#if CO_NO_TPDO > 0
/**
 * @brief Send TPDO message
 *
 * Function can be called from mainline or timer function. It marks TPDO for
 * sending.
 *
 * @param Index    index of PDO to be send (0 = first PDO)
 *
 * @return        0 = success, 
 *                -1 = error, previous message was not sent, buffer full, 
 *                -2 = error, synchronous TPDO outside window, 
 *                -10 = error; TPDO was inhibited.
*/
   INTEGER8 CO_TPDOsend(UNSIGNED16 index){

      //Prepare TPDO data automatically from Object Dictionary variables
      #if CO_NO_TPDO_USAGE > 6
         volatile UNSIGNED8* pPDOdataByte;
         volatile UNSIGNED8** ppODdataByte;

         pPDOdataByte = &CO_TXCAN[CO_TXCAN_TPDO + index].data[0];
         ppODdataByte = (volatile UNSIGNED8**)&CO_TPDOvar[index].data[0];

         *(pPDOdataByte++) = **(ppODdataByte++);
         *(pPDOdataByte++) = **(ppODdataByte++);
         *(pPDOdataByte++) = **(ppODdataByte++);
         *(pPDOdataByte++) = **(ppODdataByte++);
         *(pPDOdataByte++) = **(ppODdataByte++);
         *(pPDOdataByte++) = **(ppODdataByte++);
         *(pPDOdataByte++) = **(ppODdataByte++);
         *(pPDOdataByte++) = **(ppODdataByte++);
      #endif

      CO_TPDOsendRequest[index] = 0;

      return CO_TXCANsend(CO_TXCAN_TPDO+index);
   }


/**
 * @brief Mark TPDO message(s) for sending
 *
 * Function marks specific TPDOs, so they will be send on next call of
 * CO_PDOhandleTransmission(). It is called by application through macro.
 *
 * @param TPDOflags  16 bit variable, if bit0 is set, TPDO(0) will be sent and so on
 *
 * @return Nothing.
 */
   void CO_TPDOsendIfFlag(UNSIGNED16 TPDOflags){
      UNSIGNED8 i;
      UNSIGNED8 mask = 1;
      for(i=0; i<CO_NO_TPDO; i++){
         if(TPDOflags&mask) CO_TPDOsendRequest[i] = 1;
         mask <<= 1;
      }
   }
#endif


#if CO_NO_RPDO > 0
/**
 * @brief Handle RPDO reception
 *
 * Function is be called from mainline or timer function before user process
 * function. For now it only clears RPDO newmsg flags, if node is not operational
 *
 * @return Nothing.
*/
   void CO_PDOhandleReception(void){
      UNSIGNED16 i;

      //if not operational, forget all RPDOs
      if(CO_NMToperatingState != NMT_OPERATIONAL){
         for(i=0; i<CO_NO_RPDO; i++)
            CO_RXCAN[CO_RXCAN_RPDO + i].newmsg = 0;
      }
      //Copy RPDO data automatically to Object Dictionary variables
      #if CO_NO_RPDO_USAGE > 6
      else{
         //Synchronous RPDOs are copied only in the upper half of the Communication Cycle Period
         UNSIGNED8 allowSynchrRPDO = 1;
         #if CO_NO_SYNC > 0
            if(OD_SYNCTime < CO_SYNCperiodEarly) allowSynchrRPDO = 0;
         #endif
         
         for(i=0; i<CO_NO_RPDO; i++){
            #if CO_NO_SYNC > 0
               if(CO_RXCAN[CO_RXCAN_SYNC].newmsg) allowSynchrRPDO = 0;
            #endif
            if(CO_RXCAN[CO_RXCAN_RPDO + i].newmsg && (allowSynchrRPDO || OD_RPDOCommunicationParameter[i].transmissionType>=254)){
               volatile UNSIGNED8* pPDOdataByte;
               volatile UNSIGNED8** ppODdataByte;
               UNSIGNED8 len;
               pPDOdataByte = &CO_RXCAN[CO_RXCAN_RPDO + i].data[0];
               ppODdataByte = (volatile UNSIGNED8**)&CO_RPDOvar[i].data[0];

               //copy data from RPDO to variables
               for(len=CO_RXCANEXT[CO_RXCAN_RPDO + i].noofbytes; len>0; len--)
                  **(ppODdataByte++) = *(pPDOdataByte++);

               CO_RXCAN[CO_RXCAN_RPDO + i].newmsg = 0;
            }
         }
      }
      #endif

   }
#endif


#if CO_NO_TPDO > 0
/**
 * @brief Handle TPDO transmission
 *
 * Function can be called from mainline.
 * It automatically sends PDOs, depending on TPDO parameter setting and
 * CO_NO_TPDO_USAGE setting. With full functionality enabled, PDOs can be transmitted:
 * - Based on user event after next SYNC message (TPDO transmission type = 0);
 * - After n-th SYNC message (TPDO transmission type = 1...240);
 * - Ater event (TPDO transmission type = 254...255). Too frequent sending
 * is prevented with inhibit timer.
 * Event is triggered by Event timer or by user application (change of state
 * for example). User application can trigger event by setting the variable
 * CO_TPDOsendRequest[TPDOno] to nonzero value.
 * There is one additional functionality with CO_TPDOsendRequest[] variable:
 * Since user application operates with Object dictionary variables and it
 * does not know, to which TPDO specific variable is mapped, some variables
 * have the capability to store information about PDOs they are mapped to.
 * For example, if there is variable OD_myVariable, user application can trigger
 * events for TPDOs, to which variable is mapped simply by calling following
 * macro: ODR_myVariable_requestTPDO()
 *
 * @return Nothing.
 */
   void CO_PDOhandleTransmission (void){
   
      if(CO_NMToperatingState == NMT_OPERATIONAL){
         UNSIGNED16 i;
         for(i=0; i<CO_NO_TPDO; i++){
            ROM ODs_TPDOCommunicationParameter* TPDOparam = &OD_TPDOCommunicationParameter[i];
            volatile sCO_TPDOvar* TPDOvar = &CO_TPDOvar[i];

            if(TPDOvar->enabled == 0) continue;

            //Send PDO by user application request or by Event timer
            if(TPDOparam->transmissionType >= 253){
               if(TPDOvar->inhibitTimer == 0 && (CO_TPDOsendRequest[i] || (TPDOparam->eventTimer && TPDOvar->eventTimer == 0))){
                  if(CO_TPDOsend(i) == 0){
                     //successfully sent
                     TPDOvar->inhibitTimer = TPDOparam->inhibitTime / 10;
                     TPDOvar->eventTimer = TPDOparam->eventTimer;
                  }
               }
            }
            //Synchronous PDOs
            #if CO_NO_SYNC > 0
            else{
               static UNSIGNED16 SYNCtimePrevious = 0;
               //is TPDO Synchronous (Inhibit flag) and Sync period is not zero and
               //Sync message was either received or transmitted
               if(CO_SYNCperiod && OD_SYNCTime<SYNCtimePrevious){
                  //send synchronous acyclic PDO
                  if(TPDOparam->transmissionType == 0){
                     if(CO_TPDOsendRequest[i]){
                        CO_TPDOsend(i);
                     }
                  }
                  //Send PDO after every N-th Sync
                  else if(--TPDOvar->syncCount == 0){
                     TPDOvar->syncCount = TPDOparam->transmissionType;
                     CO_TPDOsend(i);
                  }
               }
               SYNCtimePrevious = OD_SYNCTime;
            }
            #endif
         }//end of for loop
      }
   }
#endif


/*******************************************************************************

   SDO CLIENT FUNCTIONS

*******************************************************************************/

#if CO_NO_SDO_CLIENT > 0
   #if CO_NO_SDO_CLIENT == 1
      #define CH     0
   #else
      UNSIGNED8 CH = channel;
   #endif

/**
 * @brief SETUP SDO CLIENT CHANNEL (non-blocking)
 *
 * Function specifies SDO communication parameters for specified channel. It
 * writes to  object dictionary CLI_PARAM and RXCAN and TXCAN variables.
 * Usually is used one channel (param = 0). In this case
 * only one SDO client is allowed in one network in same time. Anyway, CANopen
 * allowes more channels to be used. In this case, COB-IDs must be set manually on
 * both, client and server. All channels on one node can also 'work' simultaneously.
 *
 * @param channel               see above.
 * @param COB_IDClientToServer  COB-IDs for communication, if zero, use default CANopen COB-IDs.
 * @param COB_IDServerToClient  COB-IDs for communication, if zero, use default CANopen COB-IDs.
 * @param nodeIDOfTheSDOServer  NODE-ID of SDO server, if this node, then exchange
 *                              data with this node
 *
 * @return >0 communication in progress, 
 * 1 waiting for RXCAN response, 
 * 2 responsed by server; new message sent, 
 * 0 success, 
 * -1 wrong argument 'channel', 
 * -2 wrong other arguments, 
 * -3 communication was not properly initiaded, 
 * -10 error in SDO communication; SDO abort code is in value pointed by pSDOabortCode, 
 * -11 timeout in SDO communication; SDO abort code is in value pointed by pSDOabortCode.
*/
INTEGER8 CO_SDOclient_setup(UNSIGNED8 channel, UNSIGNED32 COB_IDClientToServer,
      UNSIGNED32 COB_IDServerToClient, UNSIGNED8 nodeIDOfTheSDOServer){
   UNSIGNED16 RX_ID, TX_ID;
   //verify parameters
   if(channel > (CO_NO_SDO_CLIENT-1)) return -1;
   if((COB_IDClientToServer&0x7FFFF800L) || (COB_IDServerToClient&0x7FFFF800L) ||
      nodeIDOfTheSDOServer < 1 || nodeIDOfTheSDOServer > 127) return -2;
   //Clear State
   CO_SDOclientVar[CH].State = 0;
   //setup Object Dictionary
   if(COB_IDClientToServer == 0 || COB_IDServerToClient == 0){
      OD_SDOClientParameter[CH].COB_IDClientToServer = CAN_ID_RSDO + nodeIDOfTheSDOServer;
      OD_SDOClientParameter[CH].COB_IDServerToClient = CAN_ID_TSDO + nodeIDOfTheSDOServer;
   }
   else{
      OD_SDOClientParameter[CH].COB_IDClientToServer = COB_IDClientToServer;
      OD_SDOClientParameter[CH].COB_IDServerToClient = COB_IDServerToClient;
   }
   OD_SDOClientParameter[CH].nodeIDOfTheSDOServer = nodeIDOfTheSDOServer;
   //setup RXCAN and TXCAN variables
   if((OD_SDOClientParameter[CH].COB_IDClientToServer & 0x80000000L) == 0 &&
      (OD_SDOClientParameter[CH].COB_IDServerToClient & 0x80000000L) == 0){//is SDO used
      RX_ID = (UNSIGNED16)OD_SDOClientParameter[CH].COB_IDServerToClient;
      TX_ID = (UNSIGNED16)OD_SDOClientParameter[CH].COB_IDClientToServer;
   }
   else{
      RX_ID = 0;
      TX_ID = 0;
   }
   CO_RXCANconfigure(CO_RXCAN_SDO_CLI + CH, RX_ID/*CAN_ID*/, 0/*RTR*/, 8/*Len*/, 1/*Inh*/);
   CO_TXCANconfigure(CO_TXCAN_SDO_CLI + CH, TX_ID/*CAN_ID*/, 0/*RTR*/, 8/*Len*/, 0/*Inh*/);
   return 0;

   #if CO_NO_SDO_CLIENT == 1
      #undef CH
   #endif
}


/**
 * @brief INITIATE SDO CLIENT DOWNLOAD (non-blocking)
 *
 * Function initiates SDO download communication with server specified in
 * CO_SDOclient_setup() function. Data will be written to remote node.
 * Usually is used one channel (param = 0). In this case
 * only one SDO client is allowed in one network in same time. Anyway, CANopen
 * allowes more channels to be used. In this case, COB-IDs must be set manually on
 * both, client and server. All channels on one node can also 'work' simultaneously.
 *
 * @param channel       see above.
 * @param (sub)index    address of object in object dictionary in remote node
 * @param pBuff         pointer to buffer which contains data to be written. Buffer must
 *                      be valid untill end of communication.
 * @param dataSize      Size of data in buffer.
 *
 * @return    >0 communication in progress, 
 *             1 waiting for RXCAN response, 
 *             2 responsed by server; new message sent, 
 *             0 success (end of communication), 
 *            -1 wrong argument 'channel', 
 *            -2 wrong other arguments, 
 *            -3 communication was not properly initiaded, 
 *           -10 error in SDO communication; SDO abort code is in value pointed by pSDOabortCode, 
 *           -11 timeout in SDO communication; SDO abort code is in value pointed by pSDOabortCode.
*/
INTEGER8 CO_SDOclientDownload_init(UNSIGNED8 channel, UNSIGNED16 index, UNSIGNED8 subIndex,
                               UNSIGNED8* pBuff, UNSIGNED8 dataSize){

   #if CO_NO_SDO_CLIENT == 1
      #define CH     0
   #else
      UNSIGNED8 CH = channel;
   #endif

   //verify parameters
   if(channel > (CO_NO_SDO_CLIENT-1)) return -1;
   if(pBuff == 0 || dataSize == 0) return -2;
   //reset timeout timer
   TMR8Z(CO_SDOclientVar[CH].tTimeout);
   //save parameters
   CO_SDOclientVar[CH].pBuff = pBuff;
   CO_SDOclientVar[CH].BuffMaxSize = dataSize;
   CO_SDOclientVar[CH].State = 0x20;
   //prepare dataBuff for CAN message
   CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[1] = index & 0xFF;
   CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[2] = index >> 8;
   CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[3] = subIndex;
   //if nodeIDOfTheSDOServer == node-ID of this node, then exchange data with this node
   if(OD_SDOClientParameter[CH].nodeIDOfTheSDOServer == CO_NodeID){
      return 0;
   }
   //continue: prepare dataBuff for CAN message
   if(CO_SDOclientVar[CH].BuffMaxSize <= 4){
      UNSIGNED8 i;
      //expedited transfer
      CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[0] = 0x23 | ((4-CO_SDOclientVar[CH].BuffMaxSize) << 2);
      *((UNSIGNED32 *)(CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data+4)) = *((UNSIGNED32 *)CO_SDOclientVar[CH].pBuff);
      for(i=CO_SDOclientVar[CH].BuffMaxSize; i<4; i++) CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[i+4] = 0;
   }
   else{
      //segmented transfer
      CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[0] = 0x21;
      *((UNSIGNED32 *)(CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data+4)) = SWAP4((UNSIGNED32)CO_SDOclientVar[CH].BuffMaxSize);
   }
   //empty receive buffer and send message
   CO_RXCAN[CO_RXCAN_SDO_CLI + CH].newmsg = 0;
   CO_TXCANsend(CO_TXCAN_SDO_CLI + CH);
   return 0;

   #if CO_NO_SDO_CLIENT == 1
      #undef CH
   #endif
}


/**
 * @brief PROCEED SDO CLIENT DOWNLOAD (non-blocking)
 *
 * Function must be called cyclically untill it returns <=0. It Proceeds SDO
 * download communication initiated with CO_SDOclientDownload_init() function.
 * Usually is used one channel (param = 0). In this case
 * only one SDO client is allowed in one network in same time. Anyway, CANopen
 * allowes more channels to be used. In this case, COB-IDs must be set manually on
 * both, client and server. All channels on one node can also 'work' simultaneously.
 *
 * @param channel         see above.
 * @param pSDOabortCode   pointer to user defined variable written by function
 *                        in case of error in communication.
 *
 * @return    >0 communication in progress,
 *             1 waiting for RXCAN response, 
 *             2 responsed by server; new message sent, 
 *             0 success, (end of communication), 
 *            -1 wrong argument 'channel', 
 *            -2 wrong other arguments, 
 *            -3 communication was not properly initiaded, 
 *           -10 error in SDO communication; SDO abort code is in value pointed by pSDOabortCode, 
 *           -11 timeout in SDO communication; SDO abort code is in value pointed by pSDOabortCode.
*/
INTEGER8 CO_SDOclientDownload(UNSIGNED8 channel, UNSIGNED32* pSDOabortCode){

   #if CO_NO_SDO_CLIENT == 1
      #define CH     0
   #else
      UNSIGNED8 CH = channel;
   #endif

   UNSIGNED8 i,j;

   //clear abort code
   *pSDOabortCode = 0;
   //verify parameters
   if(channel > (CO_NO_SDO_CLIENT-1)){
      CO_SDOclientVar[CH].State = 0;
      CO_RXCAN[CO_RXCAN_SDO_CLI + CH].newmsg = 0;
      return -1;
   }
   if(!(CO_SDOclientVar[CH].State&0x22)){
      //communication was not properly initiaded
      CO_SDOclientVar[CH].State = 0;
      CO_RXCAN[CO_RXCAN_SDO_CLI + CH].newmsg = 0;
      return -3;
   }
   //if nodeIDOfTheSDOServer == node-ID of this node, then exchange data with this node
   if(OD_SDOClientParameter[CH].nodeIDOfTheSDOServer == CO_NodeID){
      ROM sCO_OD_object* pODE;
      UNSIGNED8 length, attr;
      UNSIGNED16 index = (UNSIGNED16)CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[2]<<8 | CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[1];
      UNSIGNED8 subIndex = CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[3];
      pODE = CO_OD_find(index);
      CO_SDOclientVar[CH].State = 0;
      CO_RXCAN[CO_RXCAN_SDO_CLI + CH].newmsg = 0;
      if(pODE == 0){
         *pSDOabortCode = 0x06020000L;  //object does not exist in OD
         return -10;
      }
      if(subIndex >= pODE->subNumber){
         *pSDOabortCode = 0x06090011L;  //Sub-index does not exist.
         return -10;
      }
      length = CO_OD_getLength(pODE, subIndex);
      if(CO_SDOclientVar[CH].BuffMaxSize != length){
         *pSDOabortCode = 0x06070010L;   //Length of service parameter does not match
         return -10;
      }
      attr = CO_OD_getAttribute(pODE, subIndex);
      if(!(attr&CO_ODA_WRITEABLE)){
         *pSDOabortCode = 0x06010002L;   //attempt to write a read-only object
         return -10;
      }
      //write to OD variable
      *pSDOabortCode = pODE->pFunct(index, subIndex, attr, length, 1, (void*)CO_SDOclientVar[CH].pBuff, CO_OD_getDataPointer(pODE, subIndex));
      if(*pSDOabortCode){
         return -10;
      }
      return 0;
   }
   //check if new SDO object received
   if(CO_RXCAN[CO_RXCAN_SDO_CLI + CH].newmsg){
      TMR8Z(CO_SDOclientVar[CH].tTimeout);
      if(CO_SDOclientVar[CH].State & 0x20){
         //download initiated
         //verify response (byte0(bit4..0), index, subIndex)
         //if((CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data[0]&0x1F) || CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data[1] != CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[1] ||
         //    CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data[2] != CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[2] || CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data[3] != CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[3]){
         //   *pSDOabortCode = 0x06040043L; //General parameter incompatibility reason
         //    CO_SDOclientVar[CH].State = 0;
         //    CO_RXCAN[CO_RXCAN_SDO_CLI + CH].newmsg = 0;
         //    return -10;
         //}
         switch(CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data[0]>>5){  //Switch Server Command Specifier
            case 3:  //response OK
               if(CO_SDOclientVar[CH].BuffMaxSize <= 4){
                  //expedited transfer
                  CO_SDOclientVar[CH].State = 0;
                  CO_RXCAN[CO_RXCAN_SDO_CLI + CH].newmsg = 0;
                  return 0;
               }
               else{
                  //segmented transfer - prepare first segment
                  CO_SDOclientVar[CH].BuffSize = 0;
                  CO_SDOclientVar[CH].State = 0x22;
                  //continue with segmented download
               }
               break;
            case 4:  //abort by server
               *pSDOabortCode = SWAP4(*((UNSIGNED32 *)(CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data+4)));
               CO_SDOclientVar[CH].State = 0;
               CO_RXCAN[CO_RXCAN_SDO_CLI + CH].newmsg = 0;
               return -10;
            default:
               *pSDOabortCode = 0x05040001L; //Client/server command specifier not valid or unknown
               CO_SDOclientVar[CH].State = 0;
               CO_RXCAN[CO_RXCAN_SDO_CLI + CH].newmsg = 0;
               return -10;
         }
      }//end of download initiated
      if(CO_SDOclientVar[CH].State & 0x02){
         //segmented download in progress
         if(CO_SDOclientVar[CH].State & 0x20){   //is the first segment?
            CO_SDOclientVar[CH].State = 0x02;
         }
         else{
            //verify response from previous segment sent
            switch(CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data[0]>>5){  //Switch Server Command Specifier
               case 1:  //response OK
                  //verify toggle bit
                  if((CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data[0]&0x10) != (CO_SDOclientVar[CH].State&0x10)){
                     *pSDOabortCode = 0x05030000L;  //toggle bit not alternated
                     CO_SDOclientVar[CH].State = 0;
                     CO_RXCAN[CO_RXCAN_SDO_CLI + CH].newmsg = 0;
                     return -10;
                  }
                  //is end of transfer?
                  if(CO_SDOclientVar[CH].BuffSize==CO_SDOclientVar[CH].BuffMaxSize){
                     CO_SDOclientVar[CH].State = 0;
                     CO_RXCAN[CO_RXCAN_SDO_CLI + CH].newmsg = 0;
                     return 0;
                  }
                  //alternate toggle bit
                  if(CO_SDOclientVar[CH].State&0x10) CO_SDOclientVar[CH].State &= 0xEF;
                  else CO_SDOclientVar[CH].State |= 0x10;
                  break;
               case 4:  //abort by server
                  //verify byte0(bit4..0), index, subIndex
                  //if((CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data[0]&0x1F) || CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data[1] != CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[1] ||
                  //    CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data[2] != CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[2] || CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data[3] != CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[3]){
                  //   *pSDOabortCode = 0x06040043L; //General parameter incompatibility reason
                  //}
                  *pSDOabortCode = SWAP4(*((UNSIGNED32 *)(CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data+4)));
                  CO_SDOclientVar[CH].State = 0;
                  CO_RXCAN[CO_RXCAN_SDO_CLI + CH].newmsg = 0;
                  return -10;
               default:
                  *pSDOabortCode = 0x05040001L; //Client/server command specifier not valid or unknown
                  CO_SDOclientVar[CH].State = 0;
                  CO_RXCAN[CO_RXCAN_SDO_CLI + CH].newmsg = 0;
                  return -10;
            }
         }
         //calculate length to be sent
         j = CO_SDOclientVar[CH].BuffMaxSize - CO_SDOclientVar[CH].BuffSize;
         if(j > 7) j = 7;
         //fill data bytes
         for(i=0; i<j; i++)
            CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[i+1] = CO_SDOclientVar[CH].pBuff[CO_SDOclientVar[CH].BuffSize+i];
         for(; i<7; i++)
            CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[i+1] = 0;
         CO_SDOclientVar[CH].BuffSize += j;
         CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[0] = 0x00 | (CO_SDOclientVar[CH].State&0x10) | ((7-j)<<1);
         //is end of transfer?
         if(CO_SDOclientVar[CH].BuffSize==CO_SDOclientVar[CH].BuffMaxSize){
            CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[0] |= 1;
         }
         CO_TXCANsend(CO_TXCAN_SDO_CLI + CH);
         CO_RXCAN[CO_RXCAN_SDO_CLI + CH].newmsg = 0;
         return 2;
      }
   }
   else{
      //verify timeout
      if(TMR8(CO_SDOclientVar[CH].tTimeout) >= CO_SDO_TIMEOUT_TIME){
         *pSDOabortCode = 0x05040000L;  //SDO protocol timed out
         CO_SDOclientVar[CH].State = 0;
         CO_RXCAN[CO_RXCAN_SDO_CLI + CH].newmsg = 0;
         return -11;
      }
      return 1;
   }
   return 0;

   #if CO_NO_SDO_CLIENT == 1
      #undef CH
   #endif
}


/**
 * @brief Initialize SDO client upload (non-blocking)
 *
 * Function initiates SDO upload communication with server specified in
 * CO_SDOclient_setup() function. Data will be read from remote node.
 * Usually is used one channel (param = 0). In this case
 * only one SDO client is allowed in one network in same time. Anyway, CANopen
 * allowes more channels to be used. In this case, COB-IDs must be set manually on
 * both, client and server. All channels on one node can also 'work' simultaneously.
 *
 * @param channel         see above.
 * @param (sub)index      address of object in object dictionary in remote node
 * @param pBuff           pointer to buffer where data will be written. Buffer must
 *                        be valid untill end of communication.
 *  @param BuffMaxSize    Size of buffer (to prevent overflow).
 *
 * @return    >0 communication in progress, 
 *             1 waiting for RXCAN response, 
 *             2 responsed by server; new message sent, 
 *             0 success, (end of communication), 
 *            -1 wrong argument 'channel', 
 *            -2 wrong other arguments, 
 *            -3 communication was not properly initiaded, 
 *           -10 error in SDO communication; SDO abort code is in value pointed by pSDOabortCode, 
 *           -11 timeout in SDO communication; SDO abort code is in value pointed by pSDOabortCode.
*/
INTEGER8 CO_SDOclientUpload_init(UNSIGNED8 channel, UNSIGNED16 index, UNSIGNED8 subIndex,
                             UNSIGNED8* pBuff, UNSIGNED8 BuffMaxSize){

   #if CO_NO_SDO_CLIENT == 1
      #define CH     0
   #else
      UNSIGNED8 CH = channel;
   #endif

   //verify parameters
   if(channel > (CO_NO_SDO_CLIENT-1)) return -1;
   if(pBuff == 0 || BuffMaxSize < 4) return -2;
   //reset timeout timer
   TMR8Z(CO_SDOclientVar[CH].tTimeout);
   //save parameters
   CO_SDOclientVar[CH].pBuff = pBuff;
   CO_SDOclientVar[CH].BuffMaxSize = BuffMaxSize;
   CO_SDOclientVar[CH].State = 0x40;
   //prepare dataBuff for CAN message
   CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[0] = 0x40;
   CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[1] = index & 0xFF;
   CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[2] = index >> 8;
   CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[3] = subIndex;
   *((UNSIGNED32 *)(CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data+4)) = 0;
   //if nodeIDOfTheSDOServer == node-ID of this node, then exchange data with this node
   if(OD_SDOClientParameter[CH].nodeIDOfTheSDOServer == CO_NodeID){
      return 0;
   }
   //empty receive buffer and send message
   CO_RXCAN[CO_RXCAN_SDO_CLI + CH].newmsg = 0;
   CO_TXCANsend(CO_TXCAN_SDO_CLI + CH);
   return 0;

   #if CO_NO_SDO_CLIENT == 1
      #undef CH
   #endif
}


/**
 * @brief Proceed SDO client upload (non-blocking)
 *
 * Function must be called cyclically untill it returns <=0. It Proceeds SDO
 * upload communication initiated with CO_SDOclientUpload_init() function.
 * Usually is used one channel (param = 0). In this case
 * only one SDO client is allowed in one network in same time. Anyway, CANopen
 * allowes more channels to be used. In this case, COB-IDs must be set manually on
 * both, client and server. All channels on one node can also 'work' simultaneously.
 *
 * @param channel       see above.
 * @param pSDOabortCode pointer to user defined variable written by function
 *                      in case of error in communication.
 * @param pDataSize     pointer to variable, where size of data (in *pBuff) will be written.
 *
 * @return    >0 communication in progress, 
 *             1 waiting for RXCAN response, 
 *             2 responsed by server; new message sent, 
 *             0 success, (end of communication), 
 *            -1 wrong argument 'channel', 
 *            -2 wrong other arguments, 
 *            -3 communication was not properly initiaded, 
 *           -10 error in SDO communication; SDO abort code is in value pointed by pSDOabortCode, 
 *           -11 timeout in SDO communication; SDO abort code is in value pointed by pSDOabortCode.
*/
INTEGER8 CO_SDOclientUpload(UNSIGNED8 channel, UNSIGNED32* pSDOabortCode, UNSIGNED8* pDataSize){

   #if CO_NO_SDO_CLIENT == 1
      #define CH     0
   #else
      UNSIGNED8 CH = channel;
   #endif

   UNSIGNED8 i;

   //clear abort code
   *pSDOabortCode = 0;
   //verify parameters
   if(channel > (CO_NO_SDO_CLIENT-1)){
      CO_SDOclientVar[CH].State = 0;
      CO_RXCAN[CO_RXCAN_SDO_CLI + CH].newmsg = 0;
      return -1;
   }
   if(!(CO_SDOclientVar[CH].State&0x44)){
      //communication was not properly initiaded
      CO_SDOclientVar[CH].State = 0;
      CO_RXCAN[CO_RXCAN_SDO_CLI + CH].newmsg = 0;
      return -3;
   }
   //if nodeIDOfTheSDOServer == node-ID of this node, then exchange data with this node
   if(OD_SDOClientParameter[CH].nodeIDOfTheSDOServer == CO_NodeID){
      ROM sCO_OD_object* pODE;
      UNSIGNED8 length, attr;
      UNSIGNED16 index = (UNSIGNED16)CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[2]<<8 | CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[1];
      UNSIGNED8 subIndex = CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[3];
      pODE = CO_OD_find(index);
      CO_SDOclientVar[CH].State = 0;
      CO_RXCAN[CO_RXCAN_SDO_CLI + CH].newmsg = 0;
      if(pODE == 0){
         *pSDOabortCode = 0x06020000L;  //object does not exist in OD
         return -10;
      }
      if(subIndex >= pODE->subNumber){
         *pSDOabortCode = 0x06090011L;  //Sub-index does not exist.
         return -10;
      }
      length = CO_OD_getLength(pODE, subIndex);
      if(CO_SDOclientVar[CH].BuffMaxSize < length){
         *pSDOabortCode = 0x05040005L;  //Out of memory
         return -10;
      }
      attr = CO_OD_getAttribute(pODE, subIndex);
      if(!(attr&CO_ODA_READABLE)){
         *pSDOabortCode = 0x06010001L;  //attempt to read a write-only object
         return -10;
      }
      //set data size
      *pDataSize = length;
      //copy data from OD
      *pSDOabortCode = pODE->pFunct(index, subIndex, attr, length, 0, (void*)CO_SDOclientVar[CH].pBuff, CO_OD_getDataPointer(pODE, subIndex));
      if(*pSDOabortCode){
         return -10;
      }
      return 0;
   }
   //check if new SDO object received
   if(CO_RXCAN[CO_RXCAN_SDO_CLI + CH].newmsg){
      TMR8Z(CO_SDOclientVar[CH].tTimeout);
      if(CO_SDOclientVar[CH].State & 0x40){
         //upload initiated
         //verify response (byte0(bit4), index, subIndex)
         //if((CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data[0]&0x10) || CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data[1] != CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[1] ||
         //    CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data[2] != CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[2] || CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data[3] != CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[3]){
         //   *pSDOabortCode = 0x06040043L; //General parameter incompatibility reason
         //    CO_SDOclientVar[CH].State = 0;
         //    CO_RXCAN[CO_RXCAN_SDO_CLI + CH].newmsg = 0;
         //    return -10;
         //}
         switch(CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data[0]>>5){  //Switch Server Command Specifier
            case 2:  //response OK
               if(CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data[0] & 0x02){
                  //Expedited transfer
                  if(CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data[0] & 0x01)//is size indicated
                     i = 4 - ((CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data[0]>>2)&0x03);   //size
                  else i = 4;
                  //copy data and set size
                  memcpy(CO_SDOclientVar[CH].pBuff, &CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data[4], i);
                  *pDataSize = i;
                  CO_SDOclientVar[CH].State = 0;
                  CO_RXCAN[CO_RXCAN_SDO_CLI + CH].newmsg = 0;
                  return 0;
               }
               else{
                  //segmented transfer - prepare first segment
                  CO_SDOclientVar[CH].BuffSize = 0;
                  CO_SDOclientVar[CH].State = 0x44;
                  //continue with segmented upload
               }
               break;
            case 4:  //abort by server
               *pSDOabortCode = SWAP4(*((UNSIGNED32 *)(CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data+4)));
               CO_SDOclientVar[CH].State = 0;
               CO_RXCAN[CO_RXCAN_SDO_CLI + CH].newmsg = 0;
               return -10;
            default:
               *pSDOabortCode = 0x05040001L; //Client/server command specifier not valid or unknown
               CO_SDOclientVar[CH].State = 0;
               CO_RXCAN[CO_RXCAN_SDO_CLI + CH].newmsg = 0;
               return -10;
         }
      }//end of upload initiated
      if(CO_SDOclientVar[CH].State & 0x04){
         //segmented upload in progress
         if(CO_SDOclientVar[CH].State & 0x40){   //is the first segment?
            CO_SDOclientVar[CH].State = 0x04;
         }
         else{
            //verify response from previous segment sent
            switch(CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data[0]>>5){  //Switch Server Command Specifier
               case 0:  //response OK
                  //verify toggle bit
                  if((CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data[0]&0x10) != (CO_SDOclientVar[CH].State&0x10)){
                     *pSDOabortCode = 0x05030000L;  //toggle bit not alternated
                     CO_SDOclientVar[CH].State = 0;
                     CO_RXCAN[CO_RXCAN_SDO_CLI + CH].newmsg = 0;
                     return -10;
                  }
                  //get size
                  i = 7 - ((CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data[0]>>1)&0x07);   //size
                  //verify length
                  if((CO_SDOclientVar[CH].BuffSize + i) > CO_SDOclientVar[CH].BuffMaxSize){
                     *pSDOabortCode = 0x05040005L;  //Out of memory
                     CO_SDOclientVar[CH].State = 0;
                     CO_RXCAN[CO_RXCAN_SDO_CLI + CH].newmsg = 0;
                     return -10;
                  }
                  //copy data to buffer
                  memcpy(CO_SDOclientVar[CH].pBuff+CO_SDOclientVar[CH].BuffSize, &CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data[1], i);
                  CO_SDOclientVar[CH].BuffSize += i;
                  //If no more segments to be uploaded, finish communication
                  if(CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data[0] & 0x01){
                     *pDataSize = CO_SDOclientVar[CH].BuffSize;
                     CO_SDOclientVar[CH].State = 0;
                     CO_RXCAN[CO_RXCAN_SDO_CLI + CH].newmsg = 0;
                     return 0;
                  }
                  //alternate toggle bit
                  if(CO_SDOclientVar[CH].State&0x10) CO_SDOclientVar[CH].State &= 0xEF;
                  else CO_SDOclientVar[CH].State |= 0x10;
                  break;
               case 4:  //abort by server
                  //verify byte0(bit4..0), index, subIndex
                  //if((CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data[0]&0x1F) || CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data[1] != CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[1] ||
                  //    CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data[2] != CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[2] || CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data[3] != CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[3]){
                  //   *pSDOabortCode = 0x06040043L; //General parameter incompatibility reason
                  //}
                  *pSDOabortCode = SWAP4(*((UNSIGNED32 *)(CO_RXCAN[CO_RXCAN_SDO_CLI + CH].data+4)));
                  CO_SDOclientVar[CH].State = 0;
                  CO_RXCAN[CO_RXCAN_SDO_CLI + CH].newmsg = 0;
                  return -10;
               default:
                  *pSDOabortCode = 0x05040001L; //Client/server command specifier not valid or unknown
                  CO_SDOclientVar[CH].State = 0;
                  CO_RXCAN[CO_RXCAN_SDO_CLI + CH].newmsg = 0;
                  return -10;
            }
         }
         //prepare next segment
         CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[0] = 0x60 | (CO_SDOclientVar[CH].State&0x10);
         CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data[1] = 0;
         *((UNSIGNED16 *)(CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data+2)) = 0;
         *((UNSIGNED32 *)(CO_TXCAN[CO_TXCAN_SDO_CLI + CH].data+4)) = 0;
         CO_TXCANsend(CO_TXCAN_SDO_CLI + CH);
         CO_RXCAN[CO_RXCAN_SDO_CLI + CH].newmsg = 0;
         return 2;
      }
   }
   else{
      //verify timeout
      if(TMR8(CO_SDOclientVar[CH].tTimeout) >= CO_SDO_TIMEOUT_TIME){
         *pSDOabortCode = 0x05040000L;  //SDO protocol timed out
         CO_SDOclientVar[CH].State = 0;
         CO_RXCAN[CO_RXCAN_SDO_CLI + CH].newmsg = 0;
         return -11;
      }
      return 1;
   }
   return 0;

   #if CO_NO_SDO_CLIENT == 1
      #undef CH
   #endif
}


/**
 * @brief SDO CLIENT DOWNLOAD (blocking)
 *
 * This is blocking function and waits untill end of communication or timeout (500 ms).
 * It writes data to object dictionary in the remote node. It uses default COB-IDs.
 * It can be used in multitasking OS. For nonblocking implementation, this function
 * can be an example.
 *
 * @param nodeIDOfTheSDOServer   NODE-ID of SDO server, if this node, then exchange
 *                               data with this node
 * @param (sub)index             address of object in object dictionary in the remote node
 * @param pBuff                  pointer to buffer which contains data to be written.
 * @param dataSize               Size of data in buffer.
 * @param pSDOabortCode          pointer to user defined variable written by function
 *                               in case of error in communication.
 * @return    >0 communication in progress, 
 *             1 waiting for RXCAN response, 
 *             2 responsed by server; new message sent, 
 *             0 success, (end of communication), 
 *            -1 wrong argument 'channel', 
 *            -2 wrong other arguments, 
 *            -3 communication was not properly initiaded, 
 *           -10 error in SDO communication, SDO abort code is in value pointed by pSDOabortCode, 
 *           -11 timeout in SDO communication, SDO abort code is in value pointed by pSDOabortCode.
*/
INTEGER8 CO_SDOclientDownload_wait(UNSIGNED8 nodeIDOfTheSDOServer, UNSIGNED16 index, UNSIGNED8 subIndex,
                               UNSIGNED8* pBuff, UNSIGNED8 dataSize, UNSIGNED32* pSDOabortCode){
   INTEGER8 ret;
   ret = CO_SDOclient_setup(0, 0, 0, nodeIDOfTheSDOServer);
   if(ret) return ret;
   ret = CO_SDOclientDownload_init(0, index, subIndex, pBuff, dataSize);
   if(ret) return ret;
   do{
      ret = CO_SDOclientDownload(0, pSDOabortCode);
   }while(ret > 0);
   return ret;
}


/**
 * @brief SDO CLIENT UPLOAD (blocking)
 *
 * This is blocking function and waits untill end of communication or timeout (500 ms).
 * It reads data from object dictionary in the remote node. It uses default COB-IDs.
 * It can be used in multitasking OS. For nonblocking implementation, this function
 * can be an example.
 *
 * @param nodeIDOfTheSDOServer  NODE-ID of SDO server, if this node, then exchange
 *                              data with this node
 * @param (sub)index            address of object in object dictionary in the remote node
 * @param pBuff                 pointer to buffer where data will be written.
 * @param BuffMaxSize           Size of buffer (to prevent overflow).
 * @param pDataSize             pointer to variable, where size of data (in *pBuff) will be written.
 * @param pSDOabortCode         pointer to user defined variable written by function
 *                              in case of error in communication.
 * @return    >0 communication in progress, 
 *             1 waiting for RXCAN response, 
 *             2 responsed by server; new message sent, 
 *             0 success, (end of communication), 
 *            -1 wrong argument 'channel', 
 *            -2 wrong other arguments, 
 *            -3 communication was not properly initiaded, 
 *           -10 error in SDO communication, SDO abort code is in value pointed by pSDOabortCode, 
 *           -11 timeout in SDO communication, SDO abort code is in value pointed by pSDOabortCode.
*/
INTEGER8 CO_SDOclientUpload_wait(UNSIGNED8 nodeIDOfTheSDOServer, UNSIGNED16 index, UNSIGNED8 subIndex,
                             UNSIGNED8* pBuff, UNSIGNED8 BuffMaxSize, UNSIGNED8* pDataSize, UNSIGNED32* pSDOabortCode){
   INTEGER8 ret;
   ret = CO_SDOclient_setup(0, 0, 0, nodeIDOfTheSDOServer);
   if(ret) return ret;
   ret = CO_SDOclientUpload_init(0, index, subIndex, pBuff, BuffMaxSize);
   if(ret) return ret;
   do{
      ret = CO_SDOclientUpload(0, pSDOabortCode, pDataSize);
   }while(ret > 0);
   return ret;
}


#endif   //end of SDO Client


/**
 * @brief      Reset communication
 *
 * Function is called after start of program and after CANopen NMT command: Reset
 * Communication. It resets CAN interface and majority of CANopen variables.
 * It also calls User_ResetComm() function.
 *
 * @return Nothing.
*/
void CO_ResetComm(void){
   UNSIGNED16 i;
   UNSIGNED16 ii;

/* Set CAN bus Configuration mode */
   CO_CAN_SET_CONFIGURATION_MODE();

/* Set leds and NMT state */
   PCB_RUN_LED(0);
   CO_NMToperatingState = NMT_INITIALIZING;

/* Clear CO_RXCAN and CO_TXCAN arrays
   for(ii=0; ii<sizeof(CO_RXCAN); ii++)
      *(((UNSIGNED8*)CO_RXCAN)+ii) = 0;
   for(ii=0; ii<sizeof(CO_TXCAN); ii++)
      *(((UNSIGNED8*)CO_TXCAN)+ii) = 0;*/

/* Setup variables */
   //Read CANopen NODE-ID and CAN Bit Rate
   CO_Read_NodeId_BitRate();

   /* Setup CAN bus */
   CO_SetupCAN();

   //Sync
   CO_TimeIsInsideSyncWindow = 1;
   #if CO_NO_SYNC > 0
      CO_SYNCperiod = (UNSIGNED16)(OD_communicationCyclePeriod * CO_TIMER_ISR_FREQUENCY / 1000);
      CO_SYNCperiodTimeout = (UNSIGNED16)(OD_communicationCyclePeriod * 3 * CO_TIMER_ISR_FREQUENCY / 2000);
      CO_SYNCperiodEarly = (UNSIGNED16)(OD_communicationCyclePeriod * CO_TIMER_ISR_FREQUENCY / 2000);
      CO_SYNCproducer = (OD_COB_ID_SYNCMessage & 0x40000000L)?1:0;
      CO_SYNCwindow = (UNSIGNED16)(OD_synchronousWindowLength * CO_TIMER_ISR_FREQUENCY / 1000);
      OD_SYNCCounter = 0;
      OD_SYNCTime = 0;
   #endif

   //Errors and Emergency
   ErrorControl.EmergencyToSend = 0;
   ErrorControl.CheckErrors = 1;
   for(i=0; i<ODL_errorStatusBits_stringLength; i++)
      OD_errorStatusBits[i] = 0;
   OD_errorRegister = 0;
   #ifdef ODL_preDefinedErrorField_arrayLength
      CO_OD_preDefinedErrorField_NoOfErrors = 0;
   #endif

   //CAN transmit
   CO_TXCANcount = 0;

   //SDO Server
   #if CO_NO_SDO_SERVER > 0
      for(i=0; i<CO_NO_SDO_SERVER; i++) CO_SDOserverVar[i].State = 0;
   #endif

   //SDO Client
   #if CO_NO_SDO_CLIENT > 0
      for(i=0; i<CO_NO_SDO_CLIENT; i++) CO_SDOclientVar[i].State = 0;
   #endif

/* Setup CO_RXCAN array */
   CO_RXCANconfigure(CO_RXCAN_NMT, CAN_ID_NMT_SERVICE, 0/*RTR*/, 2/*noofbytes*/, 0/*inhibit*/);

   #if CO_NO_SYNC > 0
      CO_RXCANconfigure(CO_RXCAN_SYNC, (UNSIGNED16)OD_COB_ID_SYNCMessage, 0/*RTR*/, 0/*Len*/, 1/*Inh*/);
   #endif

   #if CO_NO_RPDO > 0
      for(i=0; i<CO_NO_RPDO; i++){
         UNSIGNED16 ret;
         CO_RPDOconfigCom(i);
         ret = CO_RPDOconfigMap(i);
         if(ret){
            ErrorReport(ERROR_wrong_PDO_mapping, ret<<8 | i);
            CO_RPDOvar[i].enabled = 0;
         }
      }
   #endif

   #if CO_NO_SDO_SERVER > 0
      for(i=CO_RXCAN_SDO_SRV; i<CO_RXCAN_SDO_SRV+CO_NO_SDO_SERVER; i++){
         if((OD_SDOServerParameter[i-CO_RXCAN_SDO_SRV].COB_IDClientToServer & 0x80000000L) == 0 &&
            (OD_SDOServerParameter[i-CO_RXCAN_SDO_SRV].COB_IDServerToClient & 0x80000000L) == 0){//is SDO used
            UNSIGNED16 ID = (UNSIGNED16)OD_SDOServerParameter[i-CO_RXCAN_SDO_SRV].COB_IDClientToServer;
            if((i-CO_RXCAN_SDO_SRV) == 0) //first SDO? -> standard predefined COB-ID is used.
               ID += (UNSIGNED16)CO_NodeID;
            CO_RXCANconfigure(i, ID/*CAN_ID*/, 0/*RTR*/, 8/*Len*/, 1/*Inh*/);
         }
         else
            CO_RXCANconfigure(i, 0/*CAN_ID*/, 0/*RTR*/, 0/*Len*/, 0/*Inh*/);
      }
   #endif

   #if CO_NO_SDO_CLIENT > 0
      for(i=CO_RXCAN_SDO_CLI; i<CO_RXCAN_SDO_CLI+CO_NO_SDO_CLIENT; i++){
         if((OD_SDOClientParameter[i-CO_RXCAN_SDO_CLI].COB_IDClientToServer & 0x80000000L) == 0 &&
            (OD_SDOClientParameter[i-CO_RXCAN_SDO_CLI].COB_IDServerToClient & 0x80000000L) == 0){//is SDO used
            UNSIGNED16 ID = (UNSIGNED16)OD_SDOClientParameter[i-CO_RXCAN_SDO_CLI].COB_IDServerToClient;
            CO_RXCANconfigure(i, ID/*CAN_ID*/, 0/*RTR*/, 8/*Len*/, 1/*Inh*/);
         }
         else
            CO_RXCANconfigure(i, 0/*CAN_ID*/, 0/*RTR*/, 0/*Len*/, 0/*Inh*/);
      }
   #endif

   #if ODL_consumerHeartbeatTime_arrayLength > 0
      for(i=0; i<ODL_consumerHeartbeatTime_arrayLength; i++){
         UNSIGNED16 NodeID = (UNSIGNED16)((OD_consumerHeartbeatTime[i]>>16)&0xFF);
         CO_HBcons_Time[i] = (UNSIGNED16)OD_consumerHeartbeatTime[i];
         CO_HBcons_NMTstate[i] = 0;

         //is channel used
         if(NodeID && CO_HBcons_Time[i]){
            CO_RXCANconfigure(i+CO_RXCAN_CONS_HB, NodeID + CAN_ID_HEARTBEAT/*CAN_ID*/, 0/*RTR*/, 1/*Len*/, 1/*Inh*/);
         }
         else{
            CO_RXCANconfigure(i+CO_RXCAN_CONS_HB, 0/*CAN_ID*/, 0/*RTR*/, 0/*Len*/, 0/*Inh*/);
            CO_HBcons_Time[i] = 0;
         }
      }
   #endif
   CO_HBcons_AllMonitoredOperational = 0;

/* Setup CO_TXCAN array */
   #if CO_NO_SYNC > 0
      CO_TXCANconfigure(CO_TXCAN_SYNC, (UNSIGNED16)OD_COB_ID_SYNCMessage, 0/*RTR*/, 0/*Len*/, 0/*Inh*/);
   #endif

   #if CO_NO_EMERGENCY > 0
      CO_TXCANconfigure(CO_TXCAN_EMERG, (UNSIGNED16)OD_COB_ID_EMCY+CO_NodeID, 0/*RTR*/, 8/*Len*/, 0/*Inh*/);
   #endif

   #if CO_NO_TPDO > 0
      for(i=0; i<CO_NO_TPDO; i++){
         UNSIGNED16 ret;
         CO_TPDOconfigCom(i);
         ret = CO_TPDOconfigMap(i);
         if(ret){
            ErrorReport(ERROR_wrong_PDO_mapping, ret<<8 | i);
            CO_TPDOvar[i].enabled = 0;
         }
      }
   #endif

   #if CO_NO_SDO_SERVER > 0
      for(i=CO_TXCAN_SDO_SRV; i<CO_TXCAN_SDO_SRV+CO_NO_SDO_SERVER; i++){
         if((OD_SDOServerParameter[i-CO_TXCAN_SDO_SRV].COB_IDClientToServer & 0x80000000L) == 0 &&
            (OD_SDOServerParameter[i-CO_TXCAN_SDO_SRV].COB_IDServerToClient & 0x80000000L) == 0){//is SDO used
            UNSIGNED16 ID = (UNSIGNED16)OD_SDOServerParameter[i-CO_TXCAN_SDO_SRV].COB_IDServerToClient;
            if((i-CO_TXCAN_SDO_SRV) == 0) //first SDO? -> standard predefined COB-ID is used.
               ID += (UNSIGNED16)CO_NodeID;
            CO_TXCANconfigure(i, ID/*CAN_ID*/, 0/*RTR*/, 8/*Len*/, 0/*Inh*/);
         }
         else
            CO_TXCANconfigure(i, 0/*CAN_ID*/, 0/*RTR*/, 0/*Len*/, 0/*Inh*/);
      }
   #endif

   #if CO_NO_SDO_CLIENT > 0
      for(i=CO_TXCAN_SDO_CLI; i<CO_TXCAN_SDO_CLI+CO_NO_SDO_CLIENT; i++){
         if((OD_SDOClientParameter[i-CO_TXCAN_SDO_CLI].COB_IDClientToServer & 0x80000000L) == 0 &&
            (OD_SDOClientParameter[i-CO_TXCAN_SDO_CLI].COB_IDServerToClient & 0x80000000L) == 0){//is SDO used
            UNSIGNED16 ID = (UNSIGNED16)OD_SDOClientParameter[i-CO_TXCAN_SDO_CLI].COB_IDClientToServer;
            CO_TXCANconfigure(i, ID/*CAN_ID*/, 0/*RTR*/, 8/*Len*/, 0/*Inh*/);
         }
         else
            CO_TXCANconfigure(i, 0/*CAN_ID*/, 0/*RTR*/, 0/*Len*/, 0/*Inh*/);
      }
   #endif

   CO_TXCANconfigure(CO_TXCAN_HB, CAN_ID_HEARTBEAT + CO_NodeID, 0/*RTR*/, 1/*Len*/, 0/*Inh*/);

/* User configuration function */
   User_ResetComm();
}

/**
 * @brief Process stack mainline.
 *
 * This function has to be cyclycally called from main(). It is non blocking function.
 * It is asynchronous. Here is long and time consuming code.
 *
 * @return Nothing.
*/
void CO_ProcessMain(void){

/* variables */
   //multipurpose usage
   UNSIGNED16 i, j;
   //SDO server
   #if CO_NO_SDO_SERVER > 1
      static UNSIGNED8 SDOserverChannel = 0;
   #endif
   //Heartbeat producer timer variable
   static UNSIGNED16 tProducerHeartbeatTime = 0;


/* 16 bit mainline timer variable */
   UNSIGNED16 CO_Timer16bit1msCopy;
   CO_DISABLE_TMR();
   CO_Timer16bit1msCopy = CO_Timer16bit1ms;
   if(mainlineCounterPer100Ms != 0xFFFF) mainlineCounterPer100Ms++;
   CO_ENABLE_TMR();
   #define TMR16Z(ttimerVariable)  (UNSIGNED16)(ttimerVariable = CO_Timer16bit1msCopy)
   #define TMR16(ttimerVariable)   (UNSIGNED16)(CO_Timer16bit1msCopy - ttimerVariable)


/* Process microcontroller specific code */
   CO_ProcessDriver();


/* Verify if new NMT message received */
   if(CO_RXCAN[CO_RXCAN_NMT].newmsg){
      if(CO_RXCAN[CO_RXCAN_NMT].data[1] == 0 || CO_RXCAN[CO_RXCAN_NMT].data[1] == CO_NodeID){
         switch(CO_RXCAN[CO_RXCAN_NMT].data[0]){//switch NMT command
            case NMT_ENTER_OPERATIONAL:      CO_NMToperatingState = NMT_OPERATIONAL;      break;
            case NMT_ENTER_STOPPED:          CO_NMToperatingState = NMT_STOPPED;          break;
            case NMT_ENTER_PRE_OPERATIONAL:  CO_NMToperatingState = NMT_PRE_OPERATIONAL;  break;
            case NMT_RESET_NODE:             CO_Reset();                                  break;
            case NMT_RESET_COMMUNICATION:    CO_DISABLE_ALL();
                                             CO_ResetComm();
                                             CO_ENABLE_ALL();                             break;
            default: ErrorReport(ERROR_CO_RXMSG_NMTcmd, 0);      //Error in NMT Command
         }
      }
      CO_RXCAN[CO_RXCAN_NMT].newmsg = 0;
   }


/* Error handling and Emergency message sending */
   //calculate Error register
   if(ErrorControl.CheckErrors){
      ErrorControl.CheckErrors = 0;
      //generic error
      if(ERROR_REGISTER_BIT0_CONDITION) OD_errorRegister |= 0x01;
      else                              OD_errorRegister &= 0xFE;
      //current
      if(ERROR_REGISTER_BIT1_CONDITION) OD_errorRegister |= 0x02;
      else                              OD_errorRegister &= 0xFD;
      //voltage
      if(ERROR_REGISTER_BIT2_CONDITION) OD_errorRegister |= 0x04;
      else                              OD_errorRegister &= 0xFB;
      //temperature
      if(ERROR_REGISTER_BIT3_CONDITION) OD_errorRegister |= 0x08;
      else                              OD_errorRegister &= 0xF7;
      //communication error (overrun, error state)
      if(ERROR_REGISTER_BIT4_CONDITION) OD_errorRegister |= 0x10;
      else                              OD_errorRegister &= 0xEF;
      //device profile specific error
      if(ERROR_REGISTER_BIT5_CONDITION) OD_errorRegister |= 0x20;
      else                              OD_errorRegister &= 0xDF;
      //manufacturer specific error
      if(ERROR_REGISTER_BIT7_CONDITION) OD_errorRegister |= 0x80;
      else                              OD_errorRegister &= 0x7F;

      //send emergency message
      if(CO_NMToperatingState==NMT_PRE_OPERATIONAL || CO_NMToperatingState==NMT_OPERATIONAL){
         //is new emergency, buffer free and no inhibit?
         if(ErrorControl.EmergencyToSend){
            #if CO_NO_EMERGENCY > 0
               static UNSIGNED16 tInhibitEmergency = 0;
               if(!CO_TXCAN[CO_TXCAN_EMERG].newmsg && (TMR16(tInhibitEmergency) > (OD_inhibitTimeEMCY/10))){
                  *((UNSIGNED16 *)(CO_TXCAN[CO_TXCAN_EMERG].data)) = SWAP2(ErrorControl.EmergencyErrorCode);
                  CO_TXCAN[CO_TXCAN_EMERG].data[2] = OD_errorRegister;
                  CO_TXCAN[CO_TXCAN_EMERG].data[3] = ErrorControl.ErrorBit;
                  *((UNSIGNED16 *)(CO_TXCAN[CO_TXCAN_EMERG].data+4)) = SWAP2(ErrorControl.CodeVal);
                  CO_TXCAN[CO_TXCAN_EMERG].data[6] = ERROR_EMERGENCY_BYTE6;
                  CO_TXCAN[CO_TXCAN_EMERG].data[7] = ERROR_EMERGENCY_BYTE7;
                  CO_TXCANsend(CO_TXCAN_EMERG);
               }
               TMR16Z(tInhibitEmergency);
            #endif
            ErrorControl.EmergencyToSend = 0;
            //write to history
            #ifdef ODL_preDefinedErrorField_arrayLength
               if(CO_OD_preDefinedErrorField_NoOfErrors < ODL_preDefinedErrorField_arrayLength)
                  CO_OD_preDefinedErrorField_NoOfErrors++;
               for(i=CO_OD_preDefinedErrorField_NoOfErrors-1; i>0; i--)
                  OD_preDefinedErrorField[i] = OD_preDefinedErrorField[i-1];
               OD_preDefinedErrorField[0] = ErrorControl.EmergencyErrorCode | (((UNSIGNED32)ErrorControl.CodeVal)<<16);
            #endif
         }
      }
   }

   //in case of error enter pre-operational state
   if(OD_errorRegister && (CO_NMToperatingState == NMT_OPERATIONAL)){
      if(OD_errorRegister&0xEF){  //all, except communication error
         CO_NMToperatingState = NMT_PRE_OPERATIONAL;
      }
      if(OD_errorRegister&0x10){  //communication error
         switch(OD_errorBehavior[ODA_errorBehavior_communicationError]){
            case 0x01:
               break;
            case 0x02:
               CO_NMToperatingState = NMT_STOPPED;
               break;
            default:
               CO_NMToperatingState = NMT_PRE_OPERATIONAL;
         }
      }
   }


#if CO_NO_SDO_SERVER > 0
/* SDO SERVER */
   //SDO server makes Object Dictionary of this node available to SDO client (Master on CAN bus)
   //SDO download means, that SDO client wants to WRITE to Object Dictionary of this node
   //SDO upload means, that SDO client wants to READ from Object Dictionary of this node
   if(CO_NMToperatingState==NMT_PRE_OPERATIONAL || CO_NMToperatingState==NMT_OPERATIONAL){
      #if CO_NO_SDO_SERVER == 1
         #define CH     0
      #else
         UNSIGNED8 CH = channel;
         i = SDOserverChannel;
         do{
            if(++SDOserverChannel == CO_NO_SDO_SERVER) SDOserverChannel = 0;
            if(CO_RXCAN[CO_RXCAN_SDO_SRV + CH].newmsg) break;
         }while(SDOserverChannel != i);
      #endif

      //Abort macro:
      #define SDO_ABORT(Code){                                                      \
         CO_TXCAN[CO_TXCAN_SDO_SRV + CH].data[0] = 0x80;                            \
         *((UNSIGNED32 *)(CO_TXCAN[CO_TXCAN_SDO_SRV + CH].data+4)) = SWAP4(Code);   \
         CO_SDOserverVar[CH].State = 0;                                             \
         CO_TXCANsend(CO_TXCAN_SDO_SRV + CH);                                       \
      }
      if(CO_RXCAN[CO_RXCAN_SDO_SRV + CH].newmsg && !CO_TXCAN[CO_TXCAN_SDO_SRV + CH].newmsg){  //New SDO object has to be processed and SDO CAN send buffer is free
         //setup variables for default response
         CO_TXCAN[CO_TXCAN_SDO_SRV + CH].data[1] = CO_RXCAN[CO_RXCAN_SDO_SRV + CH].data[1];
         CO_TXCAN[CO_TXCAN_SDO_SRV + CH].data[2] = CO_RXCAN[CO_RXCAN_SDO_SRV + CH].data[2];
         CO_TXCAN[CO_TXCAN_SDO_SRV + CH].data[3] = CO_RXCAN[CO_RXCAN_SDO_SRV + CH].data[3];
         *((UNSIGNED32 *)(CO_TXCAN[CO_TXCAN_SDO_SRV + CH].data+4)) = 0;

         switch(CO_RXCAN[CO_RXCAN_SDO_SRV + CH].data[0]>>5){  //Switch Client Command Specifier
            UNSIGNED32 abortCode;

            UNSIGNED8 attr;

            case 1:   //Initiate SDO Download request
               CO_SDOserverVar[CH].Index = (UNSIGNED16)(CO_RXCAN[CO_RXCAN_SDO_SRV + CH].data[2]<<8) | CO_RXCAN[CO_RXCAN_SDO_SRV + CH].data[1];
               CO_SDOserverVar[CH].SubIndex = CO_RXCAN[CO_RXCAN_SDO_SRV + CH].data[3];
               //find pointer to object dictionary object
               CO_SDOserverVar[CH].pODE = CO_OD_find(CO_SDOserverVar[CH].Index);
               if(!CO_SDOserverVar[CH].pODE){
                  SDO_ABORT(0x06020000L)  //object does not exist in OD
                  break;
               }
               if(CO_SDOserverVar[CH].SubIndex >= CO_SDOserverVar[CH].pODE->subNumber){
                  SDO_ABORT(0x06090011L)  //Sub-index does not exist.
                  break;
               }
               CO_SDOserverVar[CH].Length = CO_OD_getLength(CO_SDOserverVar[CH].pODE, CO_SDOserverVar[CH].SubIndex);
               attr = CO_OD_getAttribute(CO_SDOserverVar[CH].pODE, CO_SDOserverVar[CH].SubIndex);
               //verify length
               if(CO_SDOserverVar[CH].Length > CO_NO_MAX_OBJECT_SIZE){
                  SDO_ABORT(0x06040047L)   //general internal incompatibility in the device
                  break;
               }
               if(!(attr&CO_ODA_WRITEABLE)){
                  SDO_ABORT(0x06010002L)  //attempt to write a read-only object
                  break;
               }
               if(CO_RXCAN[CO_RXCAN_SDO_SRV + CH].data[0] & 0x02){
                  UNSIGNED8 len;
                  //Expedited transfer
                  if(CO_RXCAN[CO_RXCAN_SDO_SRV + CH].data[0] & 0x01)//is size indicated
                     len = 4 - ((CO_RXCAN[CO_RXCAN_SDO_SRV + CH].data[0]>>2)&0x03);   //size
                  else len = 4;
                  //verify length
                  if(CO_SDOserverVar[CH].Length != len){
                     SDO_ABORT(0x06070010L)   //Length of service parameter does not match
                     break;
                  }
                  //write to memory
                  swap(attr, CO_SDOserverVar[CH].Length, &CO_RXCAN[CO_RXCAN_SDO_SRV + CH].data[4]);
                  abortCode = CO_SDOserverVar[CH].pODE->pFunct(CO_SDOserverVar[CH].Index, CO_SDOserverVar[CH].SubIndex, attr, CO_SDOserverVar[CH].Length, 1, &CO_RXCAN[CO_RXCAN_SDO_SRV + CH].data[4], CO_OD_getDataPointer(CO_SDOserverVar[CH].pODE, CO_SDOserverVar[CH].SubIndex));
                  //send response and finish
                  if(abortCode)
                     CO_TXCAN[CO_TXCAN_SDO_SRV + CH].data[0] = 0x80;
                  else
                     CO_TXCAN[CO_TXCAN_SDO_SRV + CH].data[0] = 0x60;
                  *((UNSIGNED32 *)(CO_TXCAN[CO_TXCAN_SDO_SRV + CH].data+4)) = SWAP4(abortCode);
                  CO_SDOserverVar[CH].State = 0;
                  CO_TXCANsend(CO_TXCAN_SDO_SRV + CH);
               }
               else{
#if CO_NO_MAX_OBJECT_SIZE == 0x04
                  SDO_ABORT(0x06010000L)   //unsupported access to an object
               }
               break;
#else
                  //segmented transfer
                  //verify length if size is indicated
                  if(CO_RXCAN[CO_RXCAN_SDO_SRV + CH].data[0]&0x01){
                     if(*((UNSIGNED32*)&CO_RXCAN[CO_RXCAN_SDO_SRV + CH].data[4]) != SWAP4((UNSIGNED32)CO_SDOserverVar[CH].Length)){
                        SDO_ABORT(0x06070010L)   //Length of service parameter does not match
                        break;
                     }
                  }
                  CO_SDOserverVar[CH].BuffSize = 0;
                  TMR8Z(CO_SDOserverVar[CH].tTimeout);
                  CO_SDOserverVar[CH].State = 0x02;
                  CO_TXCAN[CO_TXCAN_SDO_SRV + CH].data[0] = 0x60;
                  CO_TXCANsend(CO_TXCAN_SDO_SRV + CH);
               }
               break;

            case 0:   //Download SDO segment
               if(!(CO_SDOserverVar[CH].State&0x02)){//download SDO segment was not initiated
                  SDO_ABORT(0x05040001L) //command specifier not valid
                  break;
               }
               //verify toggle bit
               if((CO_RXCAN[CO_RXCAN_SDO_SRV + CH].data[0]&0x10) != (CO_SDOserverVar[CH].State&0x10)){
                  SDO_ABORT(0x05030000L) //toggle bit not alternated
                  break;
               }
               //get size
               i = 7 - ((CO_RXCAN[CO_RXCAN_SDO_SRV + CH].data[0]>>1)&0x07);   //size
               //verify length
               CO_SDOserverVar[CH].Length = CO_OD_getLength(CO_SDOserverVar[CH].pODE, CO_SDOserverVar[CH].SubIndex);
               if((CO_SDOserverVar[CH].BuffSize + i) > CO_SDOserverVar[CH].Length || (CO_SDOserverVar[CH].BuffSize + i) > CO_NO_MAX_OBJECT_SIZE){
                  SDO_ABORT(0x06070012L)   //Length of service parameter too high
                  break;
               }
               //copy data to buffer
               memcpy(&CO_SDOserverVar[CH].Buff[CO_SDOserverVar[CH].BuffSize], &CO_RXCAN[CO_RXCAN_SDO_SRV + CH].data[1], i);
               swap(CO_OD_getAttribute(CO_SDOserverVar[CH].pODE, CO_SDOserverVar[CH].SubIndex), CO_SDOserverVar[CH].Length, CO_SDOserverVar[CH].Buff);
               CO_SDOserverVar[CH].BuffSize += i;
               //write response data (partial)
               CO_TXCAN[CO_TXCAN_SDO_SRV + CH].data[0] = 0x20 | (CO_SDOserverVar[CH].State&0x10);
               //If no more segments to be downloaded, copy data to variable
               if(CO_RXCAN[CO_RXCAN_SDO_SRV + CH].data[0] & 0x01){
                  //verify length
                  if(CO_SDOserverVar[CH].Length != CO_SDOserverVar[CH].BuffSize){
                     SDO_ABORT(0x06070010L)   //Length of service parameter does not match
                     break;
                  }
                  abortCode = CO_SDOserverVar[CH].pODE->pFunct(CO_SDOserverVar[CH].Index, CO_SDOserverVar[CH].SubIndex, CO_OD_getAttribute(CO_SDOserverVar[CH].pODE, CO_SDOserverVar[CH].SubIndex), CO_SDOserverVar[CH].Length, 1, CO_SDOserverVar[CH].Buff, CO_OD_getDataPointer(CO_SDOserverVar[CH].pODE, CO_SDOserverVar[CH].SubIndex));
                  *((UNSIGNED32 *)(CO_TXCAN[CO_TXCAN_SDO_SRV + CH].data+4)) = SWAP4(abortCode);
                  if(abortCode){
                     //send SDO_ABORT
                     CO_TXCAN[CO_TXCAN_SDO_SRV + CH].data[0] = 0x80;
                     CO_SDOserverVar[CH].State = 0;
                     CO_TXCANsend(CO_TXCAN_SDO_SRV + CH);
                     break;
                  }
                  CO_SDOserverVar[CH].State = 0;
               }
               else{
                  //reset timeout timer, alternate toggle bit
                  TMR8Z(CO_SDOserverVar[CH].tTimeout);
                  if(CO_SDOserverVar[CH].State&0x10) CO_SDOserverVar[CH].State &= 0xEF;
                  else CO_SDOserverVar[CH].State |= 0x10;
               }
               //write other response data
               CO_TXCAN[CO_TXCAN_SDO_SRV + CH].data[1] = 0;
               CO_TXCAN[CO_TXCAN_SDO_SRV + CH].data[2] = 0;
               CO_TXCAN[CO_TXCAN_SDO_SRV + CH].data[3] = 0;
               //download segment response
               CO_TXCANsend(CO_TXCAN_SDO_SRV + CH);
               break;
#endif
            case 2:   //Initiate SDO Upload request
               CO_SDOserverVar[CH].Index = (UNSIGNED16)CO_RXCAN[CO_RXCAN_SDO_SRV + CH].data[2]<<8 | CO_RXCAN[CO_RXCAN_SDO_SRV + CH].data[1];
               CO_SDOserverVar[CH].SubIndex = CO_RXCAN[CO_RXCAN_SDO_SRV + CH].data[3];
               //find pointer to object dictionary object
               CO_SDOserverVar[CH].pODE = CO_OD_find(CO_SDOserverVar[CH].Index);
               if(!CO_SDOserverVar[CH].pODE){
                  SDO_ABORT(0x06020000L)  //object does not exist in OD
                  break;
               }
               if(CO_SDOserverVar[CH].SubIndex >= CO_SDOserverVar[CH].pODE->subNumber){
                  SDO_ABORT(0x06090011L)  //Sub-index does not exist.
                  break;
               }
               CO_SDOserverVar[CH].Length = CO_OD_getLength(CO_SDOserverVar[CH].pODE, CO_SDOserverVar[CH].SubIndex);
               attr = CO_OD_getAttribute(CO_SDOserverVar[CH].pODE, CO_SDOserverVar[CH].SubIndex);
               //verify length
               if(CO_SDOserverVar[CH].Length > CO_NO_MAX_OBJECT_SIZE){
                  SDO_ABORT(0x06040047L)   //general internal incompatibility in the device
                  break;
               }
               if(!(attr&CO_ODA_READABLE)){
                  SDO_ABORT(0x06010001L)   //attempt to read a write-only object
                  break;
               }
               abortCode = CO_SDOserverVar[CH].pODE->pFunct(CO_SDOserverVar[CH].Index, CO_SDOserverVar[CH].SubIndex, attr, CO_SDOserverVar[CH].Length, 0, CO_SDOserverVar[CH].Buff, CO_OD_getDataPointer(CO_SDOserverVar[CH].pODE, CO_SDOserverVar[CH].SubIndex));
               if(abortCode){
                  SDO_ABORT(abortCode)
                  break;
               }
               if(CO_SDOserverVar[CH].Length <= 4){
                  swap(attr, CO_SDOserverVar[CH].Length, CO_SDOserverVar[CH].Buff);
                  //expedited transfer
                  memcpy(CO_TXCAN[CO_TXCAN_SDO_SRV + CH].data+4, CO_SDOserverVar[CH].Buff, CO_SDOserverVar[CH].Length);
                  CO_TXCAN[CO_TXCAN_SDO_SRV + CH].data[0] = 0x43 | ((4-CO_SDOserverVar[CH].Length) << 2);
                  CO_SDOserverVar[CH].State = 0;
                  CO_TXCANsend(CO_TXCAN_SDO_SRV + CH);
               }
#if CO_NO_MAX_OBJECT_SIZE == 0x04
               break;
#else
               else{
                  CO_SDOserverVar[CH].BuffSize = 0;  //indicates pointer to next data to be send
                  TMR8Z(CO_SDOserverVar[CH].tTimeout);
                  CO_SDOserverVar[CH].State = 0x04;
                  CO_TXCAN[CO_TXCAN_SDO_SRV + CH].data[0] = 0x41;
                  *((UNSIGNED32 *)(CO_TXCAN[CO_TXCAN_SDO_SRV + CH].data+4)) = SWAP4((UNSIGNED32)CO_SDOserverVar[CH].Length);
                  CO_TXCANsend(CO_TXCAN_SDO_SRV + CH);
               }
               break;

            case 3:   //Upload SDO segment
               if(!(CO_SDOserverVar[CH].State&0x04)){//upload SDO segment was not initiated
                  SDO_ABORT(0x05040001L) //command specifier not valid
                  break;
               }
               //verify toggle bit
               if((CO_RXCAN[CO_RXCAN_SDO_SRV + CH].data[0]&0x10) != (CO_SDOserverVar[CH].State&0x10)){
                  SDO_ABORT(0x05030000L) //toggle bit not alternated
                  break;
               }
               //calculate length to be sent
               j = CO_SDOserverVar[CH].Length - CO_SDOserverVar[CH].BuffSize;
               if(j > 7) j = 7;
               //fill data bytes
               for(i=0; i<j; i++)
                  CO_TXCAN[CO_TXCAN_SDO_SRV + CH].data[i+1] = CO_SDOserverVar[CH].Buff[CO_SDOserverVar[CH].BuffSize+i];
               for(; i<7; i++)
                  CO_TXCAN[CO_TXCAN_SDO_SRV + CH].data[i+1] = 0;
               CO_SDOserverVar[CH].BuffSize += j;
               CO_TXCAN[CO_TXCAN_SDO_SRV + CH].data[0] = 0x00 | (CO_SDOserverVar[CH].State&0x10) | ((7-j)<<1);
               //is end of transfer?
               if(CO_SDOserverVar[CH].BuffSize==CO_SDOserverVar[CH].Length){
                  CO_TXCAN[CO_TXCAN_SDO_SRV + CH].data[0] |= 1;
                  CO_SDOserverVar[CH].State = 0;
               }
               else{
                  //reset timeout timer, alternate toggle bit
                  TMR8Z(CO_SDOserverVar[CH].tTimeout);
                  if(CO_SDOserverVar[CH].State&0x10) CO_SDOserverVar[CH].State &= 0xEF;
                  else CO_SDOserverVar[CH].State |= 0x10;
               }
               CO_TXCANsend(CO_TXCAN_SDO_SRV + CH);
               break;
#endif
            case 4:   //Abort SDO transfer by client
#if CO_NO_MAX_OBJECT_SIZE > 0x04
               CO_SDOserverVar[CH].State = 0;
#endif
               break;

            default:
               SDO_ABORT(0x05040001L) //command specifier not valid
         }//end switch
         CO_RXCAN[CO_RXCAN_SDO_SRV + CH].newmsg = 0;
      }//end process new SDO object



   //verify timeout of segmented transfer
#if CO_NO_MAX_OBJECT_SIZE > 0x04
      if(CO_SDOserverVar[CH].State){ //Segmented SDO transfer in progress
         if(TMR8(CO_SDOserverVar[CH].tTimeout) >= CO_SDO_TIMEOUT_TIME){
            SDO_ABORT(0x05040000L)  //SDO protocol timed out
         }
      }
#endif
   }
   else{ //not in (pre)operational state
      CO_SDOserverVar[CH].State = 0;
      CO_RXCAN[CO_RXCAN_SDO_SRV + CH].newmsg = 0;
   }

   #if CO_NO_SDO_SERVER == 1
      #undef CH
   #endif

#endif //end of SDO server


/* Heartbeat consumer message handling */
   //DS 301: "Monitoring starts after the reception of the first HeartBeat. (Not bootup)"
   CO_HBcons_AllMonitoredOperationalCpy = 5;
#if ODL_consumerHeartbeatTime_arrayLength > 0
   if(CO_NMToperatingState==NMT_PRE_OPERATIONAL || CO_NMToperatingState==NMT_OPERATIONAL){
      for(i=0; i<ODL_consumerHeartbeatTime_arrayLength; i++){
         if(CO_HBcons_Time[i]){//is node monitored
            //Verify if new Consumer Heartbeat message received
            if(CO_RXCAN[CO_RXCAN_CONS_HB+i].newmsg){
               CO_HBcons_NMTstate[i] = CO_RXCAN[CO_RXCAN_CONS_HB+i].data[0];
               if(CO_HBcons_NMTstate[i]){
                  //not a bootup message
                  CO_HBcons_MonStarted[i] = 1;
                  TMR16Z(CO_HBcons_TimerValue[i]);  //reset timer
               }
               CO_RXCAN[CO_RXCAN_CONS_HB+i].newmsg = 0;
            }
            //Verify timeout
            if(CO_HBcons_MonStarted[i]){
               if(TMR16(CO_HBcons_TimerValue[i]) > CO_HBcons_Time[i]){
                  ErrorReport(ERROR_HEARTBEAT_CONSUMER, CO_RXCANread_CAN_ID(CO_RXCAN_CONS_HB + i));
                  CO_HBcons_NMTstate[i] = 0;
               }
               if(CO_HBcons_NMTstate[i] == 0){
                  //there was a bootup message
                  ErrorReport(ERROR_HEARTBEAT_CONSUMER_REMOTE_RESET, CO_RXCANread_CAN_ID(CO_RXCAN_CONS_HB + i));
               }
            }
            if(CO_HBcons_NMTstate[i] != NMT_OPERATIONAL)
               CO_HBcons_AllMonitoredOperationalCpy = 0;
         }
      }
   }
   else{ //not in (pre)operational state
      for(i=0; i<ODL_consumerHeartbeatTime_arrayLength; i++){
         CO_HBcons_NMTstate[i] = 0;
         CO_RXCAN[CO_RXCAN_CONS_HB+i].newmsg = 0;
         CO_HBcons_MonStarted[i] = 0;
      }
      CO_HBcons_AllMonitoredOperationalCpy = 0;
   }
#endif
   CO_HBcons_AllMonitoredOperational = CO_HBcons_AllMonitoredOperationalCpy;


/* Heartbeat producer message & Bootup message*/
   //Sent only if not in TX passive, bootup send always
   if((OD_producerHeartbeatTime && (TMR16(tProducerHeartbeatTime) >= OD_producerHeartbeatTime))
          || CO_NMToperatingState == NMT_INITIALIZING){
      TMR16Z(tProducerHeartbeatTime);
      CO_TXCAN[CO_TXCAN_HB].data[0] = CO_NMToperatingState;
      CO_TXCANsend(CO_TXCAN_HB);
      if(CO_NMToperatingState == NMT_INITIALIZING){
         if((OD_NMTStartup & 0x04) == 0) CO_NMToperatingState = NMT_OPERATIONAL;
         else                              CO_NMToperatingState = NMT_PRE_OPERATIONAL;
      }
   }


/* Status LEDs */
   //green RUN LED (DR 303-3)
   switch(CO_NMToperatingState){
      case NMT_STOPPED:
         if(CO_StatusLED.SingleFlash) PCB_RUN_LED(1); else PCB_RUN_LED(0);
         break;
      case NMT_PRE_OPERATIONAL:
         if(CO_StatusLED.Blinking) PCB_RUN_LED(1); else PCB_RUN_LED(0);
         break;
      case NMT_OPERATIONAL:
         PCB_RUN_LED(1);
         break;
   }

   //red ERROR LED (DR 303-3)
   if(ERROR_BIT_READ(ERROR_CAN_TX_BUS_OFF)){
      PCB_ERROR_LED(1);
   }
   #if CO_NO_SYNC > 0
   else if(ERROR_BIT_READ(ERROR_SYNC_TIME_OUT)){
      if(CO_StatusLED.TripleFlash) PCB_ERROR_LED(1); else PCB_ERROR_LED(0);
   }   
   #endif
   #if ODL_consumerHeartbeatTime_arrayLength > 0
   else if(ERROR_BIT_READ(ERROR_HEARTBEAT_CONSUMER) || ERROR_BIT_READ(ERROR_HEARTBEAT_CONSUMER_REMOTE_RESET)){
      if(CO_StatusLED.DoubleFlash) PCB_ERROR_LED(1); else PCB_ERROR_LED(0);
   }   
   #endif
   else if( ERROR_BIT_READ(ERROR_CAN_TX_BUS_PASSIVE) || ERROR_BIT_READ(ERROR_CAN_RX_BUS_PASSIVE) || ERROR_BIT_READ(ERROR_CAN_BUS_WARNING)){
      if(CO_StatusLED.SingleFlash) PCB_ERROR_LED(1); else PCB_ERROR_LED(0);
   }
   else if(OD_errorRegister){
      if(CO_StatusLED.Blinking) PCB_ERROR_LED(1); else PCB_ERROR_LED(0);
   }
   else{
      PCB_ERROR_LED(0);
   }
}

/*******************************************************************************
 * Process stack by timer Interrupt Service Routine
 *
 * Function is executed every fixed time interval (Typically every
 * 1 millisecond). It is deterministic and has priority over mainline function.
*******************************************************************************/
CO_TIMER_ISR{
   UNSIGNED16 i;
   static UNSIGNED8 timer1ms = 0;
   static UNSIGNED8 timer100ms = 0;
   //Blinking bits
   static UNSIGNED8 tLEDflicker = 0;
   static UNSIGNED16 tLEDblink = 0, tLEDflash = 0;


/* Acknowledge the timer interrupt */
   CO_TIMER_ACKNOWLEDGE();

/* information for some functions (when variable = 1, timer is executing and mainline is waiting)*/
   CO_TIMER_ISR_isExecuting = 1;


/* Timer period 1 millisecond */
   if(++timer1ms == CO_TIMER_ISR_FREQUENCY){

      //16 bit timer variable with period 1 millisecond
      CO_Timer16bit1ms++;

      //8 bit timer variable with period 100 milliseconds and mainline counts reset
      if(++timer100ms == 100){
         CO_Timer8bit100ms++;
         timer100ms = 0;

         if(mainlineCounterPer100Ms > OD_performance.mainlineCountPer100MsMax)
            OD_performance.mainlineCountPer100MsMax = mainlineCounterPer100Ms;
         OD_performance.mainlineCountPer100Ms = mainlineCounterPer100Ms;
         mainlineCounterPer100Ms = 0;
      }

      //Inhibit and Event Timers for PDO transmission
      #if CO_NO_TPDO > 0
         for(i=0; i<CO_NO_TPDO; i++){
            if(CO_TPDOvar[i].inhibitTimer) CO_TPDOvar[i].inhibitTimer--;
            if(CO_TPDOvar[i].eventTimer) CO_TPDOvar[i].eventTimer--;
         }
      #endif

      //Blinking bits 10Hz
      if   (++tLEDflicker == 50)    CO_StatusLED.Flickering = 1;
      else if(tLEDflicker == 100){  CO_StatusLED.Flickering = 0; tLEDflicker = 0;}
   
      //Blinking bits 2.5Hz
      if   (++tLEDblink == 200)     CO_StatusLED.Blinking = 1;
      else if(tLEDblink == 400){    CO_StatusLED.Blinking = 0; tLEDblink = 0;}
   
      //Flashes
      switch(++tLEDflash){
         case 200:  CO_StatusLED.TripleFlash = 1;
                    CO_StatusLED.DoubleFlash = 1;
                    CO_StatusLED.SingleFlash = 1;
                    break;
         case 400:  CO_StatusLED.TripleFlash = 0;
                    CO_StatusLED.DoubleFlash = 0;
                    CO_StatusLED.SingleFlash = 0;
                    break;
         case 600:  CO_StatusLED.TripleFlash = 1;
                    CO_StatusLED.DoubleFlash = 1;
                    break;
         case 800:  CO_StatusLED.TripleFlash = 0;
                    CO_StatusLED.DoubleFlash = 0;
                    break;
         case 1000: CO_StatusLED.TripleFlash = 1;
                    break;
         case 1200: CO_StatusLED.TripleFlash = 0;
                    break;
         case 2000: tLEDflash = 0;
                    break;
      }

      timer1ms = 0;
   }


/* SYNC timer/counter variables, SYNC producer */
   #if CO_NO_SYNC > 0
      if(CO_SYNCperiod && (CO_NMToperatingState==NMT_PRE_OPERATIONAL || CO_NMToperatingState==NMT_OPERATIONAL)){
         //increment SYNC timer variable, don't allow overflow
         if(++OD_SYNCTime == 0){
            OD_SYNCTime--;
         }

         //Verify if new SYNC message received
         if(CO_RXCAN[CO_RXCAN_SYNC].newmsg){
            //Verify is SYNC is to early (two producers)
            if(OD_SYNCTime<CO_SYNCperiodEarly && CO_NMToperatingState == NMT_OPERATIONAL)
               ErrorReport(ERROR_SYNC_EARLY, OD_SYNCTime);
            OD_SYNCCounter++;
            OD_SYNCTime = 0;
            CO_RXCAN[CO_RXCAN_SYNC].newmsg = 0;
         }

         //SYNC producer (On CAN bus must NOT exist two equal SYNC producers)
         if(CO_SYNCproducer){
            static UNSIGNED16 tSYNCperiod = 0;
            if(++tSYNCperiod >= CO_SYNCperiod){
               CO_TXCANsend(CO_TXCAN_SYNC);
               OD_SYNCCounter++;
               OD_SYNCTime = 0;
               tSYNCperiod = 0;
            }
         }

         //Synchronous PDOs are allowed only inside time window
         if(OD_SYNCTime == 0)
            CO_TimeIsInsideSyncWindow = 1;
         else if(OD_SYNCTime == CO_SYNCwindow){
            CO_TimeIsInsideSyncWindow = 0;
            CO_ClearPendingSyncPDOs();
         }

         //Verify timeout of SYNC
         if(OD_SYNCTime > CO_SYNCperiodTimeout && CO_NMToperatingState == NMT_OPERATIONAL)
            ErrorReport(ERROR_SYNC_TIME_OUT, OD_SYNCTime);

      }
   #endif


/* User timer procedure */
   User_ProcessTimer();


/* Calculate Timer Bandwidth */
   OD_performance.timerBandwidthPerc = CO_CALCULATE_TIMER_BANDWIDTH();
   if(OD_performance.timerBandwidthPerc > OD_performance.timerBandwidthPercMax)
      OD_performance.timerBandwidthPercMax = OD_performance.timerBandwidthPerc;


/* information for some functions */
   CO_TIMER_ISR_isExecuting = 0;


/* Verify overflow of timer interrupt */
   if(CO_TIMER_IS_OVERFLOWED){
      ErrorReport(ERROR_isr_timer_overflow, 0);
      CO_TIMER_ACKNOWLEDGE();
   }

}
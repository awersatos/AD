/*******************************************************************************

   CO_errors.h - Header for error handling

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

********************************************************************************

   Error Status Bits indicate any error occurred in program. Specific bit is set
   by ErrorReport() function, when error occurs in program. It can also be reset
   by ErrorReset() function, if error is solved. On each change of any Error
   Status Bit Emergency message is sent. If critical bits are set, node will not
   be able to enter operational state.

****** standards ***************************************************************

   Error register 0x1001 (ds-301):
   bit      mandatory/opt      description
   -----------------------------------------------------------------------------
   0        M                  generic error
   1        O                  current
   2        O                  voltage
   3        O                  temperature
   4        O                  communication error (overrun, error state)
   5        O                  device profile specific
   6        O                  Reserved (always 0)
   7        O                  manufacturer specific


   Emergency error codes (ds-301):
   error code       description
   -----------------------------------------------------------------------------
   00xx             Error Reset or No Error
   10xx             Generic Error
   20xx             Current
   21xx             Current, device input side
   22xx             Current inside the device
   23xx             Current, device output side
   30xx             Voltage
   31xx             Mains Voltage
   32xx             Voltage inside the device
   33xx             Output Voltage
   40xx             Temperature
   41xx             Ambient Temperature
   42xx             Device Temperature
   50xx             Device Hardware
   60xx             Device Software
   61xx             Internal Software
   62xx             User Software
   63xx             Data Set
   70xx             Additional Modules
   80xx             Monitoring
   81xx             Communication
   8110             CAN Overrun (Objects lost)
   8120             CAN in Error Passive Mode
   8130             Life Guard Error or Heartbeat Error
   8140             recovered from bus off
   8150             Transmit COB-ID collision
   82xx             Protocol Error
   8210             PDO not processed due to length error
   8220             PDO length exceeded
   90xx             External Error
   F0xx             Additional Functions
   FFxx             Device specific


   Emergency error codes (ds-401):
   error code       description
   -----------------------------------------------------------------------------
   2310             Current at outputs too high (overload)
   2320             Short circuit at outputs
   2330             Load dump at outputs
   3110             Input voltage too high
   3120             Input voltage too low
   3210             Internal voltage too high
   3220             Internal voltage too low
   3310             Output voltage too high
   3320             Output voltage too low

   Contents of Emergency message (COB-ID = 0x80 + Node-ID):
   byte no.         description
   -----------------------------------------------------------------------------
   byte 0..1        Error code
   byte 2           Error Register (OD_errorRegister, OD index 1001)
   byte 3..7        Manufacturer specific:
   byte 3              ErrorControl.ErrorBit (see definitions of specific error bits)
   byte 4..5           ErrorControl.CodeVal  (code argument to ErrorReport() or ErrorReset())
   byte 6              ERROR_EMERGENCY_BYTE6 (see below)
   byte 7              ERROR_EMERGENCY_BYTE7 (see below)

   Contents of Pre Defined Error Field (Index 1003):
   byte no.         description
   -----------------------------------------------------------------------------
   byte 0..1        Error code
   byte 3..4        Manufacturer specific:
                       ErrorControl.CodeVal  (code argument to ErrorReport() or ErrorReset())
*******************************************************************************/

#ifndef _ERRORS_H
#define _ERRORS_H

/***** Table of standard error codes (DS 301) *********************************/
   //Each error code value corresponds one error bit
   #define ERROR_CODES {                                                   \
         0x0000, 0x6100, 0x6110, 0x6120, 0x6000, 0x6300, 0     , 0x8100,   \
         0x8110, 0x8140, 0x8120, 0x8120, 0x8110, 0x8100, 0x8130, 0x8130,   \
         0x1001, 0x1002, 0x1003, 0x1004, 0x1005, 0x1006, 0x1007, 0x1008,   \
         0x8210, 0x8200, 0x8200, 0x8200, 0x0000, 0x8100, 0x8100, 0         }


/***** definitions for Error Status Bits **************************************/
   //byte 0, important generic and communication errors
   #define ERROR_NO_ERROR                             0x00
   #define ERROR_ErrorReport_ParametersNotSupp        0x01
   #define ERROR_WrongInterrupt                       0x02
   #define ERROR_wrong_PDO_mapping                    0x03
   #define ERROR_isr_timer_overflow                   0x04
   #define ERROR_WrongNodeIDorBitRate                 0x05

   #define ERROR_SYNC_TIME_OUT                        0x07

   //byte 1, important communication errors
   #define ERROR_CAN_RXB_OVERFLOW                     0x08
   #define ERROR_CAN_TX_BUS_OFF                       0x09
   #define ERROR_CAN_TX_BUS_PASSIVE                   0x0A
   #define ERROR_CAN_RX_BUS_PASSIVE                   0x0B
   #define ERROR_CAN_TX_OVERFLOW                      0x0C
   #define ERROR_TPDO_OUTSIDE_WINDOW                  0x0D
   #define ERROR_HEARTBEAT_CONSUMER                   0x0E
   #define ERROR_HEARTBEAT_CONSUMER_REMOTE_RESET      0x0F

   //byte 2, important or unimpotrant user defined errors
   #define ERROR_USER_0_IMPORTANT                     0x10
   #define ERROR_USER_1_IMPORTANT                     0x11
   #define ERROR_USER_2_IMPORTANT                     0x12
   #define ERROR_USER_3_IMPORTANT                     0x13
   #define ERROR_USER_4                               0x14
   #define ERROR_USER_5                               0x15
   #define ERROR_USER_6                               0x16
   #define ERROR_USER_7                               0x17

   //byte 3, protocol errors, not important
   #define ERROR_CO_RXMSG_PDOlength                   0x18
   #define ERROR_CO_RXMSG_Length                      0x19
   #define ERROR_CO_RXMSG_NMTcmd                      0x1A
   #define ERROR_CO_RXMSG_Inhibit                     0x1B
   #define ERROR_CAN_BUS_WARNING                      0x1C
   #define ERROR_SYNC_EARLY                           0x1D
   #define ERROR_CANRXTX_INT                          0x1E

/***** calculation of Error register 0x1001 ***********************************/
   //generic error
   #define ERROR_REGISTER_BIT0_CONDITION (OD_errorStatusBits[0] & 0xFE)
   //current
   #define ERROR_REGISTER_BIT1_CONDITION (OD_errorStatusBits[0] & 0x00)
   //voltage
   #define ERROR_REGISTER_BIT2_CONDITION (OD_errorStatusBits[0] & 0x00)
   //temperature
   #define ERROR_REGISTER_BIT3_CONDITION (OD_errorStatusBits[0] & 0x00)
   //communication error
   #define ERROR_REGISTER_BIT4_CONDITION (OD_errorStatusBits[1])
   //device profile specific
   #define ERROR_REGISTER_BIT5_CONDITION (OD_errorStatusBits[0] & 0x00)
   //manufacturer specific
   #define ERROR_REGISTER_BIT7_CONDITION (OD_errorStatusBits[2] & 0x0F)

/***** other defines **********************************************************/
   #define ERROR_BIT_READ(error_bit)   (OD_errorStatusBits[error_bit>>3] & (1<<(error_bit & 0x07)))

   //Defines for bytes 6 and 7 in emergency message
   #define ERROR_EMERGENCY_BYTE6    OD_errorStatusBits[0]
   #define ERROR_EMERGENCY_BYTE7    OD_errorStatusBits[1]

/*******************************************************************************
   ErrorReport - REPORT ERROR CONDITION
   Function is used to report any error occurred in program. It can be used from
   mainline or interrupt. It sets appropriate error bit and sends emergency if
   it is the first time for that bit. If critical bits are set, node will not be
   able to enter operational state.
   PARAM ErrorBit: specific error bit, use defined constants
   PARAM Code: informative value, send as 4-th and 5-th byte in Emergency message
*******************************************************************************/
   void ErrorReport(UNSIGNED8 ErrorBit, UNSIGNED16 Code);

/*******************************************************************************
   ErrorReset - RESET ERROR CONDITION
   Function is used to report any if error condition is no more present. It can
   be used from mainline or interrupt function. It resets appropriate error bit
   and sends emergency 'no error'. Parameters are same as above.
*******************************************************************************/
   void ErrorReset(UNSIGNED8 ErrorBit, UNSIGNED16 Code);

#endif

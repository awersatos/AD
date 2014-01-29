/*****************************************************************************\
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  COPYRIGHT:          Copyright (c) 2007, Altium
|*
|*  DESCRIPTION:        SMS Message type
|*
 */
#ifndef _SMSG_TYPE_H_
#define _SMSG_TYPE_H_

#define SMS_MSG_SIZE    512

/**
 * @brief
 *      SMS message structure
 *
 * This data structure holds some key information (according etsi gsm 03.40
 * specification) of a sms message.
 */
typedef struct smsg_s
{
    char timestamp[32];            /**< TP-SCTS timestamp field */
    unsigned char addr_type;       /**< type of address / phone number format */
    char from[32];                 /**< phone number */
    char message[SMS_MSG_SIZE];    /**< actual message */
} smsg_t;

#endif //_SMSG_TYPE_H_

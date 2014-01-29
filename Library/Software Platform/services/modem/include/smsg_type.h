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

#ifdef  __cplusplus
extern "C" {
#endif

#define PHONE_NUM_LEN   32
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
    char from[PHONE_NUM_LEN];      /**< phone number */
    char message[SMS_MSG_SIZE];    /**< actual message */
} smsg_t;

typedef enum
{
    SMS_UNREAD = 0,
    SMS_READ   = 1,
    SMS_UNSENT = 2,
    SMS_SENT   = 3,
    SMS_ALL    = 4
} sms_type_t;

typedef enum
{
    SMS_STORAGE_FLASH,
    SMS_STORAGE_SIM,

    SMS_STORAGE_INVALID
} sms_storage_t;

#ifdef  __cplusplus
}
#endif

#endif //_SMSG_TYPE_H_

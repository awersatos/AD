/*************************************************************************
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*
|*  IN PACKAGE:         MODEM Communication
|*
|*  COPYRIGHT:          Copyright (c) 2007, Altium
|*
|*  DESCRIPTION:        send modem AT commands and read modem results
|*
 */
/**
 * @file
 * Service enabling you to communicate with Modems using hayes AT commands
 *
 * The API supports Hayes AT commands in three major areas:<BR>
 * -# General commands like dialing a number disconnecting the line etc.<BR>
 * -# GSM commands like SMS handling, setting a pin code etc.<BR>
 * -# Voice modem commands like sending a wave file etc.<BR>
 *
 * Functions ( sms_pdu_encode() and sms_pdu_decode() ) to decode and 
 * encode pdu encoded sms messages are delivered through the pdu.h library.
 */
#ifndef _MODEM_H_
#define _MODEM_H_

#ifdef  __cplusplus
extern "C" {
#endif

#define MODEM_SMALL_MSG   512
#define MODEM_SMS_SIZE    512

#include <stdint.h>
#include <stdbool.h>
#include <serial.h>
#include <smsg_type.h>

/**
 * @brief HAYES modes
 *
 * Hayes operational modes
 */
typedef enum
{
    MODEM_CMD,  /**< Command Mode */
    MODEM_DATA, /**< Data Mode */
    MODEM_VOICE, /**< Voice Mode */

    MODEM_UNKNOWN_MODE = -1
} modem_mode_t;

typedef enum
{
     MODEM_STATUS_IDLE = 0,
     MODEM_STATUS_REGISTERED_HOME = 1,
     MODEM_STATUS_SEARCHING = 2,
     MODEM_STATUS_REGISTRATION_DENIED = 3,
     MODEM_STATUS_UNKNOWN = 4,
     MODEM_STATUS_REGISTERED_ROAMING = 5,

     MODEM_STATUS_INVALID
} modem_status_t;

typedef enum
{
    CME_PHONE_FAILURE = 0,
    CME_NO_CONNECTION_TO_PHONE = 1,
    CME_PHONE_ADAPTOR_LINK_RESERVED = 2,
    CME_OPERATION_NOT_ALLOWED = 3,
    CME_OPERATION_NOT_SUPPORTED = 4,
    CME_PH_SIM_PIN_REQUIRED = 5,
    CME_PH_FSIM_PIN_REQUIRED = 6,
    CME_PH_FSIM_PUK_REQUIRED = 7,
    CME_SIM_NOT_INSERTED = 10,
    CME_SIM_PIN_REQUIRED = 11,
    CME_SIM_PUK_REQUIRED = 12,
    CME_SIM_FAILURE = 13,
    CME_SIM_BUSY = 14,
    CME_SIM_WRONG = 15,
    CME_INCORRECT_PASSWORD = 16,
    CME_SIM_PIN_2_REQUIRED = 17,
    CME_SIM_PUK_2_REQUIRED = 18,
    CME_MEMORY_FULL = 20,
    CME_INVALID_INDEX = 21,
    CME_NOT_FOUND = 22,
    CME_MEMORY_FAILURE = 23,
    CME_STRING_TOO_LONG = 24,
    CME_INVALID_TEXT_STRING = 25,
    CME_DIAL_STRING_TOO_LONG = 26,
    CME_INVALID_DIAL_STRING = 27,
    CME_NO_NETWORK_SERVICE = 30,
    CME_NETWORK_TIMEOUT = 31,
    CME_NETWORK_NOT_ALLOWED_EMERGENCY_CALLS_ONLY = 32,
    CME_NETWORK_PERSONALIZATION_PIN_REQUIRED = 40,
    CME_NETWORK_PERSONALIZATION_PUK_REQUIRED = 41,
    CME_NETWORK_SUBSET_PERSONALIZATION_PIN_REQUIRED = 42,
    CME_NETWORK_SUBSET_PERSONALIZATION_PUK_REQUIRED = 43,
    CME_SERVICE_PROVIDER_PERSONALIZATION_PIN_REQUIRED = 44,
    CME_SERVICE_PROVIDER_PERSONALIZATION_PUK_REQUIRED = 45,
    CME_CORPORATE_PERSONALIZATION_PIN_REQUIRED = 46,
    CME_CORPORATE_PERSONALIZATION_PUK_REQUIRED = 47,
    CME_UNKNOWN = 100,
    CME_ILLEGAL_MS = 103,
    CME_ILLEGAL_ME = 106,
    CME_GPRS_NOT_ALLOWED = 107,
    CME_PLMN_NOT_ALLOWED = 111,
    CME_LOCATION_AREA_NOT_ALLOWED = 112,
    CME_ROAMING_NOT_ALLOWED = 113,
    CME_SERVICE_OPTION_NOT_SUPPORTED = 132,
    CME_REQUESTED_SERVICE_OPTION_NOT_SUBSCRIBED = 133,
    CME_SERVICE_OPTION_TEMPORARILY_OUT_OF_ORDER = 134,
    CME_PDP_AUTHENTICATION_FAILURE = 149,
    CME_INVALID_MOBILE_CLASS = 150,
    CME_UNSPECIFIED_GPRS_ERROR = 148,
    CME_VBS_VGCS_NOT_SUPPORTED_BY_THE_NETWORK = 151,
    CME_NO_SERVICE_SUBSCRIPTION_ON_SIM = 152,
    CME_NO_SUBSCRIPTION_FOR_GROUP_ID = 153,
    CME_GROUP_ID_NOT_ACTIVATED_ON_SIM = 154,
    CME_NO_MATCHING_NOTIFICATION = 155,
    CME_VBS_VGCS_CALL_ALREADY_PRESENT = 156,
    CME_CONGESTION = 157,
    CME_NETWORK_FAILURE = 158,
    CME_UPLINK_BUSY = 159,
    CME_NO_ACCESS_RIGHTS_FOR_SIM_FILE = 160,
    CME_NO_SUBSCRIPTION_FOR_PRIORITY = 161,
    CME_OPERATION_NOT_APPLICABLE = 162,

    CME_OK,
} modem_cme_error_t;

typedef struct modem_drv_s modem_t;

/* generic modem handling: */
extern modem_t *modem_open                (unsigned int id);
extern bool     modem_start               (modem_t * modem);
extern bool     modem_reset               (modem_t * modem);

/* modem IO commands */
#define MODEM_DEFAULT_TIMEOUT 0xFFFFFFFF
extern int modem_cmd                      (modem_t *modem, const char * command);
extern int modem_cmd_ex                   (modem_t *modem, const char * command, const char ** expected, int expected_count, uint32_t timeout_ms);
extern bool is_modem_ready                (modem_t *modem);
extern int modem_read                     (modem_t *modem, uint8_t * buf, size_t len);
extern int modem_write                    (modem_t *modem, const uint8_t *buf, size_t size);
extern void modem_send                    (modem_t *modem, uint8_t ch);
extern int modem_recv                     (modem_t *modem);

/* modem status requests */
extern int modem_is_ringing               (modem_t *modem);
extern int modem_is_hangup                (modem_t *modem);
extern modem_mode_t modem_get_mode        (modem_t * modem);
extern int modem_get_current_call         (modem_t *modem, char * number);

/* generic modem AT commands: */
extern int modem_echo                     (modem_t *modem, bool echo_on, bool verbose_results);
extern int modem_speaker                  (modem_t *modem, bool speaker_on);
extern int modem_autoanswer               (modem_t *modem, int count);
extern int modem_answer                   (modem_t *modem);
extern int modem_dial                     (modem_t *modem, const char *number);
extern int modem_hangup                   (modem_t *modem);
extern int modem_set_mode                 (modem_t *modem, modem_mode_t mode);
extern int modem_get_revision_string      (modem_t *modem, char * revision, size_t revision_len);

/* GSM modem specific modem AT commands: */
extern int modem_enter_pin                (modem_t *modem, const char *pin_code);
extern int modem_check_network            (modem_t *modem);
extern int modem_signal_quality           (modem_t *modem);
extern modem_status_t modem_network_status(modem_t *modem);
extern const char * modem_cme_error_str   (modem_cme_error_t error);
extern modem_cme_error_t modem_sim_status (modem_t *modem);


/* GSM modem specific modem SMS AT commands: */
#define MODEM_SEND_SMS_TIMEOUT 30000
extern int modem_sms_init                 (modem_t *modem, sms_storage_t storage);
extern int modem_read_sms                 (modem_t *modem, char *message, sms_type_t type);
extern int modem_read_sms_at_index        (modem_t *modem, char *message, int index);
extern int modem_send_sms                 (modem_t *modem, char *pdu);
extern int modem_get_sms_max_index        (modem_t *modem);
extern int modem_delete_sms               (modem_t *modem, int index);
extern int modem_delete_multiple_sms      (modem_t *modem, sms_type_t what);

extern void sms_pdu_decode                (char * pdu, smsg_t * sms_message);
extern void sms_pdu_encode                (const char * message, char * dest_nr, char * pdu);
extern char * sms_pdu_timestamp_to_string (smsg_t * msg, char * buf, size_t len);

/* GSM PDP Domain specific AT commands: */
extern int modem_define_pdp               (modem_t *modem, int cid, const char *apn);
extern int modem_connect_pdp              (modem_t *modem, int cid);

/* Voice modem (Rockwell) specific AT commands: */
extern int modem_voice_transmit           (modem_t *modem, uint8_t *wav, size_t size);
extern void modem_filter_dle              (char *buf);

#ifdef  __cplusplus
}
#endif

#endif

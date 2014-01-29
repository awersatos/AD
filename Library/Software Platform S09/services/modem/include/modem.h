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
#include <gps_info_type.h>

/**
 * @brief HAYES modes
 *
 * Hayes operational modes
 */
typedef enum
{
    MODEM_CMD,  /**< Command Mode */
    MODEM_DATA, /**< Data Mode */
    MODEM_VOICE /**< Voice Mode */
} modem_mode_t;

typedef struct
{
    void         *device;                // transceiver device
    posix_devctl_serial_impl_t serial;   // posix serial implementation
    uint32_t     speed;                  // bits/s
    uint64_t     timeout;                // modem_cmd timeout
    int32_t      kind;                   // modem kind
    modem_mode_t mode;                   // current Hayes operational mode
    bool         isRinging;              // Incoming call
    bool         isHangup;               // Phone is hang up
} modem_t;

/* generic modem handling: */
extern modem_t *modem_open(int id);
extern int modem_rxdata(modem_t *modem);
extern int modem_txdata(modem_t *modem, const char *data);
extern int modem_cmd(modem_t *modem, const char *cmd, char *rsp);
extern int modem_is_ringing(modem_t *modem);
extern int modem_is_hangup(modem_t *modem);
extern int modem_get_token(char** buf, int item);
extern char *modem_itoa(int value, char* result);

/* generic modem AT commands: */
extern int modem_echo(modem_t *modem, int onoff);
extern int modem_speaker(modem_t *modem, int onoff);
extern int modem_set_autoanswer(modem_t *modem, int count);
extern int modem_answer(modem_t *modem);
extern int modem_dial(modem_t *modem, const char *number);
extern int modem_hangup(modem_t *modem);


/* GSM modem specific modem AT commands: */
extern int modem_enter_pin(modem_t *modem, const char *pin_code);
extern int modem_check_network(modem_t *modem);
extern int modem_signal_quality(modem_t *modem);


/* GSM modem specific modem SMS AT commands: */
extern int modem_sms_init(modem_t *modem);
extern int modem_read_sms(modem_t *modem, char *message);
extern int modem_send_sms(modem_t *modem, char *pdu);
extern int modem_read_totalsms(modem_t *modem);
extern int modem_delete_sms(modem_t *modem, int index);
extern void sms_pdu_decode(char * pdu, smsg_t * sms_message);
extern void sms_pdu_encode(char * message, char * dest_nr, char * pdu);

/* GSM PDP Domain specific AT commands: */
int modem_define_pdp(modem_t *modem, int cid, const char *apn);

/* Voice modem (Rockwell) specific AT commands: */
extern int modem_select_voice(modem_t *modem);
extern int modem_voice_transmit(modem_t *modem, unsigned char *wav, int size);
extern void modem_filter_dle(char *buf);

/* GPS specific AT commands */
extern int modem_gps_start(modem_t *modem, int mode);
extern int modem_gps_stop(modem_t *modem);
extern int modem_get_gps_info(modem_t *modem, modem_gps_info_t *info);



#ifdef  __cplusplus
}
#endif

#endif

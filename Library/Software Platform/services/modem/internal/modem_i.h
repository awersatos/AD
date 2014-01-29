 /*
 * modem_internal.h
 *
 *  Created on: 10/08/2009
 *      Author: joseph.thomas-kerr
 */

#ifndef MODEM_INTERNAL_H_
#define MODEM_INTERNAL_H_

#if __POSIX_KERNEL__
# include <pthread.h>
#endif
#include <serial.h>
#include "modem_cfg_instance.h"

#define MODEM_SUPPORTS_SUSPEND(modem)  (modem->kind == MODEM_KIND_MODEM_SIM5218A)
#define MODEM_SUPPORTS_PLUS_PLUS_PLUS(modem) (            \
             modem->kind == MODEM_KIND_MODEM_HAYES ||     \
             modem->kind == MODEM_KIND_MODEM_TELIT ||     \
             modem->kind == MODEM_KIND_MODEM_SIM548C)
#define MODEM_SIMCOM(modem) (                             \
             modem->kind == MODEM_KIND_MODEM_SIM5218A ||  \
             modem->kind == MODEM_KIND_MODEM_SIM548C)


#include "modem.h"

#define MODEM_SIGNATURE 0x30DE3

#define MODEM_MAX_LISTENERS  10
#define MODEM_MAX_UNREAD_SMS 32

#define MODEM_COMMAND_BUFFER_SIZE 128

typedef int modem_listener_found_fn(modem_t * modem, void * arg);

#define MODEM_LISTENER_RUNNING  0
#define MODEM_LISTENER_TIMEOUT  1
#define MODEM_LISTENER_ERROR    2
#define MODEM_LISTENER_FOUND    3

typedef struct modem_listener_s
{
    const char * string;
    int          curr;
    modem_listener_found_fn * found;
    void *       found_arg;
} modem_listener_t;


struct modem_drv_s
{
    bool             signature;
    int              fd;
    void            *device;                 // transceiver device
    posix_devctl_serial_impl_t serial;   // posix serial implementation
    uint32_t         speed;                  // bits/s
    uint64_t         timeout_ms;             // modem_cmd timeout
    int32_t          kind;                   // modem kind
    modem_mode_t     mode;                   // current Hayes operational mode
    bool             isRinging;              // Incoming call
    bool             isHangup;               // Phone is hang up
#if __POSIX_KERNEL__
    pthread_mutex_t  MODEM_mutex;
#endif

    modem_listener_t listeners[MODEM_MAX_LISTENERS];

    sms_storage_t    sms_storage;
    uint8_t          unread_sms_head;
    uint8_t          unread_sms_tail;
    uint8_t          unread_sms[MODEM_MAX_UNREAD_SMS];
};


void modem_sleep(unsigned long msec);

typedef enum
{
    MODEM_DTR_IGNORE = 0,
    MODEM_DTR_CMD    = 1,
    MODEM_DTR_HANGUP = 2,

    MODEM_DTR_MAX
} modem_dtr_mode_t;

extern int modem_set_dtr_mode          (modem_t *modem, modem_dtr_mode_t mode);

bool       modem_add_listener          (modem_t * modem, const char * listening_for, modem_listener_found_fn * found, void * found_arg);
bool       modem_remove_listener       (modem_t * modem, const char * listening_for);
int        modem_listen                (modem_t * modem, modem_listener_t * listener, char actual);


#define MODEM_ERROR_STRING           "\r\nERROR\r\n"
#define MODEM_RING_STRING            "\r\nRING\r\n"
#define MODEM_NO_CARRIER_STRING      "\r\nNO CARRIER\r\n"
#define MODEM_SMS_UNSOLICITED_STRING "\r\n+CMTI: "

modem_listener_found_fn modem_error_found;
modem_listener_found_fn modem_ring_found;
modem_listener_found_fn modem_no_carrier_found;
modem_listener_found_fn modem_sms_unsolicited_found;

#define SMS_STORE_COUNT 3
#define SMS_MAX_TOKENS 10

const char *  sms_storage_string          (modem_t * modem, sms_storage_t storage);
sms_storage_t sms_storage_from_string     (modem_t * modem, const char* storage);
int           modem_pop_unread_message    (modem_t * modem);
int           modem_parse_sms_response    (char ** line, int preamble_len, char ** next_message);
int           modem_read_first_sms_of_type(modem_t *modem, char *message, sms_type_t type);
int           get_sim548c_sms_type        (sms_type_t type);

#endif /* MODEM_INTERNAL_H_ */

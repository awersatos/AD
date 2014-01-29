/*************************************************************************
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  IN PACKAGE:         MODEM Communication internal functions
|*
|*  COPYRIGHT:          Copyright (c) 2007, Altium
|*
|*  DESCRIPTION:        Generic package to be able to send and receive modem AT commands
|*
 */

#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <errno.h>
#include <assert.h>
#include <string.h>
#include <timing.h>
#include <time.h>

#include <sysutils.h>
#include "modem_i.h"
#include "csv.h"

int modem_error_found(modem_t * modem, void * arg)
{
    return MODEM_LISTENER_ERROR;
}
int modem_ring_found(modem_t * modem, void * arg)
{
    modem->isRinging = true;
    return MODEM_LISTENER_RUNNING;
}
int modem_no_carrier_found(modem_t * modem, void * arg)
{
    modem->isHangup = true;
    modem->mode = MODEM_CMD;
    return MODEM_LISTENER_RUNNING;
}

/**
 * @brief Sleep for a period in milliseconds
 *
 * @param  msec     the number of milliseconds to sleep
 */
void modem_sleep(unsigned long msec)
{
#if ( __POSIX_KERNEL__ != 0 )
    struct timespec ts;
    timespec_from_ms(&ts,msec);
    nanosleep(&ts, NULL);
#else
    delay_ms(msec);
#endif
}

/**
 * @brief Determine whether the provided character completes
 *        a match of the string contained in seek
 *
 * @param  seek     a pointer to an initialized seek structure
 *                  containing the string to seek and the current
 *                  match state.
 * @param  actual   the character to check
 *
 * @return true     if the string has been completely found, OR
 *         false    otherwise.
 */
int modem_listen(modem_t * modem, modem_listener_t * listener, char actual)
{
    if (!listener || !listener->string) return false;
    if (actual == listener->string[listener->curr])
        listener->curr++;
    else
        listener->curr = 0;

    if (listener->string[listener->curr] == '\0')
    {
        if (listener->found)
            return listener->found(modem, listener->found_arg);
        else
            return MODEM_LISTENER_FOUND;
    }
    return MODEM_LISTENER_RUNNING;
}

bool modem_add_listener(modem_t * modem, const char * listening_for, modem_listener_found_fn * found, void * found_arg)
{
    int i;

    assert(modem && listening_for);

    if (!listening_for)
        return false;

    for (i=0;i<MODEM_MAX_LISTENERS;i++)
        if (!modem->listeners[i].string)
           break;

    if (i==MODEM_MAX_LISTENERS)
        return false;

    modem->listeners[i].string    = listening_for;
    modem->listeners[i].curr      = 0;
    modem->listeners[i].found     = found;
    modem->listeners[i].found_arg = found_arg;

    return true;
}

bool modem_remove_listener(modem_t * modem, const char * listening_for)
{
    int i;

    assert(modem && listening_for);

    if (!listening_for)
        return false;

    for (i=0;i<MODEM_MAX_LISTENERS;i++)
        if (strcmp(modem->listeners[i].string,listening_for)==0)
           break;

    if (i==MODEM_MAX_LISTENERS)
        return false;

    modem->listeners[i].string = NULL;
    return true;
}

/**
 * @brief Set the behaviour of the modem when the DTR line is set low
 *
 * @param modem     pointer to modem device struct
 * @param mode      one of the values of modem_dtr_mode_t
 *
 * @return 0 if the command was unsuccessful, non-zero if it was successful
 */
int modem_set_dtr_mode(modem_t *modem, modem_dtr_mode_t mode)
{
    char buf[10];
    int result = 0;

    if (MODEM_SUPPORTS_SUSPEND(modem))
    {
        if (modem->kind == MODEM_KIND_MODEM_SIM5218A)
            result = modem_cmd(modem,"AT+CSUART=1,1");
        sprintf(buf,"AT&D%u",mode);
        result = result && modem_cmd(modem, buf);
    }
    return result;
}


const char * sms_storage_string(modem_t * modem, sms_storage_t storage)
{
    switch (storage)
    {
    case SMS_STORAGE_FLASH:
        if (modem->kind == MODEM_KIND_MODEM_SIM5218A)
            return "ME";
        else
            return "";
    case SMS_STORAGE_SIM:
        return "SM";
    default:
        return "";
    }
}

sms_storage_t sms_storage_from_string(modem_t * modem, const char* storage)
{
    if (strcmp(storage,"SM"))
        return SMS_STORAGE_SIM;
    if (strcmp(storage,"ME") && modem->kind == MODEM_KIND_MODEM_SIM5218A)
            return SMS_STORAGE_FLASH;
    return SMS_STORAGE_INVALID;
}


bool modem_push_unread_message(modem_t * modem, uint8_t index)
{
    int i = modem->unread_sms_head;

    while (i != modem->unread_sms_tail)
    {
        if (modem->unread_sms[i] == index)
            return true;
        i = (i+1) % MODEM_MAX_UNREAD_SMS;
    }

    if ((modem->unread_sms_tail+1) % MODEM_MAX_UNREAD_SMS == modem->unread_sms_head)
        return false;       // list is full

    modem->unread_sms[modem->unread_sms_tail] = index;
    modem->unread_sms_tail = (modem->unread_sms_tail+1) % MODEM_MAX_UNREAD_SMS;
    return true;
}

int modem_pop_unread_message(modem_t * modem)
{
    int result;
    if (modem->unread_sms_tail == modem->unread_sms_head)
        return 0;       // list is empty

    result = modem->unread_sms[modem->unread_sms_head];
    modem->unread_sms[modem->unread_sms_head] = 0;
    modem->unread_sms_head = (modem->unread_sms_head+1) % MODEM_MAX_UNREAD_SMS;

    return result;
}

int modem_parse_sms_response(char ** line, int preamble_len, char ** next_message)
{
    char * token[SMS_MAX_TOKENS];
    int token_count = SMS_MAX_TOKENS;
    int len = 0;
    int line_len = 0;
    int result = -1;

    token_count = SMS_MAX_TOKENS;
    line_len = tokenize_csv_line(*line + preamble_len,SMS_MSG_SIZE,token,&token_count);
    if (token_count < 2) goto final;

    result = atoi(token[0]);

    *line += preamble_len + line_len;
    line_len = tokenize_csv_line(*line,SMS_MSG_SIZE,token,&token_count);
    if (next_message) *next_message = *line + line_len;
final:
    return result;
}


/* NOTE: if there are many messages matching <type>, the AT+CMGL command may
 * return more than BUFSIZ bytes, causing some messages to be
 * incompletely read or marked as SMS_READ without being saved by the plugin.
 */
int modem_read_first_sms_of_type(modem_t *modem, char *message, sms_type_t type)
{
    bool success;
    int result = -1;
    int msg_index, len;
    char buf[BUFSIZ];
    char * line, * next_message;
    const char * expected = "+CMGL: ";
    int expected_len = strlen(expected);

    snprintf(buf, BUFSIZ,"AT+CMGL=%u",type);
    success = modem_cmd_ex(modem, buf, &expected,1, MODEM_DEFAULT_TIMEOUT) == 0;
    if (!success) goto final;

    len = modem_read(modem,(uint8_t *) buf + expected_len, BUFSIZ-expected_len);
    if (len==0) goto final;

    // parse the retreived data
    line = buf;
    while(*line != '\0')
    {
        msg_index = modem_parse_sms_response(&line, expected_len,&next_message);
        if (msg_index<0) break;

        if (result<0)
        {
            strncpy(message,line,SMS_MSG_SIZE);
            result = msg_index;
        }
        else if (type==SMS_UNREAD)
        {
            modem_push_unread_message(modem,(uint8_t) msg_index);
        }
        line = next_message;
    }
final:
    return result;
}


int get_sim548c_sms_type(sms_type_t type)
{
    switch(type)
    {
    case SMS_READ:     return 1;
    case SMS_UNREAD:   return 2;
    case SMS_SENT:     return 3;
    case SMS_UNSENT:   return 4;
    case SMS_ALL:      return 6;
    }
    return 0;
}

int modem_sms_unsolicited_found(modem_t * modem, void * arg)
{
    int len;
    char * token[SMS_MAX_TOKENS];
    int token_count = SMS_MAX_TOKENS;
    char buf[MODEM_COMMAND_BUFFER_SIZE];

    len = modem_read(modem,(uint8_t *) buf, MODEM_COMMAND_BUFFER_SIZE);
    if (len==0) goto final;

    tokenize_csv_line(buf,MODEM_COMMAND_BUFFER_SIZE,token,&token_count);
    if (token_count < 2) goto final;

    modem_push_unread_message(modem,atoi(token[1]));
final:
    return MODEM_LISTENER_RUNNING;
}





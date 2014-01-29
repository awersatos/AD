/*******************************************************************************
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  IN PACKAGE:         MODEM Communication
|*
|*  COPYRIGHT:          Copyright (c) 2007, Altium
|*
|*  DESCRIPTION:        AT Commands to handle SMS messages
 ******************************************************************************/
#if __POSIX_KERNEL__
# include <pthread.h>
#else
# include <time.h>
#endif

#include <stdio.h>
#include <string.h>
#include <modem_i.h>
#include "csv.h"

/**
 * @brief Init the mobile for handling SMS messages
 * 
 * This function sets the mobile to receive sms messages in pdu format
 * and selects the preferred message store
 *
 * @param modem     pointer to modem device struct
 * @param storage   an sms_storage_t value to indicate where SMS messages are to be stored
 *
 * @return 1 on success, 0 on error.
 */
extern int modem_sms_init(modem_t *modem, sms_storage_t storage)
{
    bool success;
    char buf[MODEM_COMMAND_BUFFER_SIZE];
    const char * s;

    // SET SMS system into pdu mode
    success = modem_cmd(modem, "AT+CMGF=0");
    if (!success) return 0;

    // Buffer new message indications when in data mode so as not to corrupt the data stream
    success = modem_cmd(modem, "AT+CNMI=2");
    if (!success) return 0;

    // Specify circuit switched sms delivery to avoid clashing with GPRS data
    success = modem_cmd(modem, "AT+CGSMS=1");
    if (!success) return 0;

    // Set the message store
    s = sms_storage_string(modem,storage);
    snprintf(buf,MODEM_COMMAND_BUFFER_SIZE,"AT+CPMS=\"%s\",\"%s\",\"%s\"",s,s,s);
    success = modem_cmd(modem, buf);
    if (!success) return 0;

    modem->sms_storage = storage;
    return 1;
}

/**
 * @brief Read message (AT+CMGR)
 *
 * Read an SMS from the storage location indicated by index.
 * the SMS message itself is returned in message.
 *
 * @param modem       pointer to modem device struct
 * @param message     the sms message retreived from the modem
 * @param index       the index of the message to retrieve
 *
 * @return the message storage location of the message, zero on error.
 */
extern int modem_read_sms_at_index(modem_t *modem, char *message, int index)
{
    bool success;
    int result = -1;
    const char * expected =  "+CMGR: ";
    int expected_len = strlen(expected);
    int len;
    char * line;

    snprintf(message, BUFSIZ,"AT+CMGR=%u",index);
    success = modem_cmd_ex(modem,message,&expected,1,MODEM_DEFAULT_TIMEOUT) == 0;
    if (!success) goto final;

    len = modem_read(modem,(uint8_t *) message + expected_len,BUFSIZ);
    if (len==0) goto final;

    line = message;
    modem_parse_sms_response(&line, expected_len, NULL);
    strncpy(message,line,SMS_MSG_SIZE);
    result = index;
final:
    return result;
}

/**
 * @brief Read message (AT+CMGR)
 *
 * Get a received message and return the message location from the first message
 * found. the SMS message itself is returned in message.
 *
 * @param modem       pointer to modem device struct
 * @param message     the PDU-encoded sms message retreived from the modem,
 *                    the size of the buffer must be at least SMS_MSG_SIZE bytes
 *
 * @return the message storage location of the message, -1 on error.
 *
 * NOTE: If type==SMS_UNREAD, then the modem will mark all unread messages as read.
 * The message returned will be considered to be SMS_READ, but the modem PLUGIN
 * will keep track of the status of any other unread messages until the processor is reset.
 */
extern int modem_read_sms(modem_t *modem, char *message, sms_type_t type)
{
    int msg_index;

    if (modem->kind == MODEM_KIND_MODEM_SIM5218A) // this modem seems to require
        modem_sms_init(modem,modem->sms_storage); // this to trigger messages to download from the air

    if (type == SMS_UNREAD && (msg_index = modem_pop_unread_message(modem)))
        return modem_read_sms_at_index(modem,message,msg_index);
    else
        return modem_read_first_sms_of_type(modem,message,type);
}


/**
 * @brief Send a pdu encoded SMS message (AT+CMGS)
 *
 * @param modem     pointer to modem device struct
 * @param pdu       pdu encoded message to send
 *
 * @return 1 on success, 0 on error.
 */
int modem_send_sms(modem_t *modem, char *pdu)
{
    int length;
    int success;
    char buf[MODEM_COMMAND_BUFFER_SIZE];
    const char * response_cmd =  ">";
    const char * response_result[2] = { "ERROR", "OK" };

    // pdu msg includes CTRL-Z and SMSC address octet: do not count them in length
    length = (strlen(pdu)  - 1) / 2  -1;
    sprintf(buf,"AT+CMGS=%u",length);
    success = modem_cmd_ex(modem, buf,&response_cmd,1,MODEM_DEFAULT_TIMEOUT) == 0;
    modem_write(modem, (uint8_t *) pdu,0);  // do this regardless otherwise we might get stuck in PDU mode
    if (!success) return success;

    success = modem_cmd_ex(modem, NULL, response_result, 2, MODEM_SEND_SMS_TIMEOUT);
    return success;
}


/**
 * @brief Read the total number of message storage locations (AT+CPMS?)
 *
 * @param modem     pointer to modem device struct
 *
 * @return number of message storage locations.
 */
extern int modem_get_sms_max_index(modem_t *modem)
{
    char * token[SMS_MAX_TOKENS];
    int token_count = SMS_MAX_TOKENS;
    int len = 0;
    int line_len = 0;
    bool success;
    char buf[MODEM_COMMAND_BUFFER_SIZE];
    const char * expected =  "+CPMS:";

    // reply like +CPMS: <mem1>, used1, total1, <mem2>, used2, total2, <mem3>, used3, total3 OK
    success = modem_cmd_ex(modem, "AT+CPMS?",&expected,1,MODEM_DEFAULT_TIMEOUT)==0;
    if (!success) return 0;

    len = modem_read(modem,(uint8_t *) buf,MODEM_SMALL_MSG);
    if (len == 0) return 0;

    tokenize_csv_line(buf,len,token,&token_count);
    if (token_count < 3) return 0;

    return atoi(token[2]);
}

/**
 * @brief Delete message (AT+CMGD) at index in message store
 *
 * @param modem     pointer to modem device struct
 * @param index     index of message to be deleted
 *
 * @return 1 on success, 0 on error.
 */
extern int modem_delete_sms(modem_t *modem, int index)
{
    char buf[MODEM_COMMAND_BUFFER_SIZE];

    sprintf( buf,"AT+CMGD=%u",index);
    return modem_cmd(modem, buf);
}

/**
 * @brief Delete multiple messages (AT+CMGD) at index in message store
 *
 * @param modem     pointer to modem device struct
 * @param what      type of messages to delete
 *
 * @return 1 on success, 0 on error.
 */
extern int modem_delete_multiple_sms(modem_t *modem, sms_type_t type)
{
    char buf[MODEM_COMMAND_BUFFER_SIZE];

    switch (modem->kind)
    {
    case MODEM_KIND_MODEM_SIM548C:
        snprintf( buf,MODEM_COMMAND_BUFFER_SIZE,"AT+CMGDA=%u",get_sim548c_sms_type(type));
        break;
    case MODEM_KIND_MODEM_SIM5218A:
        snprintf( buf,MODEM_COMMAND_BUFFER_SIZE,"AT+CMGD=,%u",type);
        break;
    default:
        return 0;
    }
    return modem_cmd(modem, buf);
}

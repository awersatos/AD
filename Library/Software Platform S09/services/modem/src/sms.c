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
#if ( __POSIX_KERNEL__ != 0 )
# include <pthread.h>
#else
#include <time.h>
#endif

#include <string.h>
#include <modem.h>

/**
 * @brief Init the mobile for handling SMS messages
 * 
 * This function sets the mobile to receive sms messages in pdu format
 * and store all messages in the SIM message store.
 *
 * @param modem     pointer to modem device struct
 *
 * @return 1 on success, 0 on error.
 */
int modem_sms_init(modem_t *modem)
{
    int  ret = 0;

    // SET SMS system into pdu mode
    if (modem_cmd(modem, "AT+CMGF=0", NULL))
    {
        if (modem_cmd(modem, "AT+CPMS=\"SM\",\"SM\",\"SM\"", NULL))
            ret = 1;
    }
    return ret;
}

/**
 * @brief Read message (AT+CMGR)
 *
 * Get a received message and return the message location from the first message
 * found. the SMS message itself is returned in message.
 *
 * @param modem       pointer to modem device struct
 * @param message     the sms message retreived from the modem
 *
 * @return the message storage location of the message, zero on error.
 */
int modem_read_sms(modem_t *modem, char *message)
{
    int message_idx;
    int max_msg_idx;
    char *message_bgn;
    char *message_end;

    // get number of messages stored
    max_msg_idx = modem_read_totalsms(modem);

    for (message_idx = max_msg_idx; message_idx > 0; message_idx--)
    {
        strcpy(message, "AT+CMGR=");
        modem_itoa(message_idx, message+8);
        modem_cmd(modem, message, message);
        // check if this message was stored in "received message" (either read or unread) memory
        if ( strstr(message, "OK") && !strstr(message, "+CMGR: 0,,0") &&
             (strstr(message, " 1,") || strstr(message, " 0,")) )
        {
            // strip the |+CMGR: 0, , 0||OK| part of the message
            message_bgn = strstr(message, "+CMGR:");
            message_bgn = strstr(message_bgn + 1, "\r");
            message_end = strstr(message_bgn + 1, "\r");
            message_end[0] = 0;
            if (strlen(message_bgn) > 2)
            {
                strcpy(message, message_bgn + 2);
                break;
            }
        }
    }
    return message_idx;
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
    int ret = 0;
    char buf[MODEM_SMALL_MSG] = "AT+CMGS=";

    // pdu msg includes CTRL-Z and SMSC address octets: donot count them in length
    length = (strlen(pdu) - 3) / 2;
    modem_itoa(length, buf + 8);
    strcat(buf, "\r");
    if (modem_cmd(modem, buf, NULL))
    {
        modem_txdata(modem, pdu);
        ret = modem_cmd(modem, NULL, NULL);
    }
    return ret;
}


/**
 * @brief Read the total number of message storage locations (AT+CPMS?)
 *
 * @param modem     pointer to modem device struct
 *
 * @return number of received messages.
 */
int modem_read_totalsms(modem_t *modem)
{
    int i;
    int msg_nr = 0;
    char rsp[MODEM_SMALL_MSG];
    char* rspptr = rsp;

    // reply like +CPMS: <mem1>, used1, total1, <mem2>, used2, total2, <mem3>, used3, total3 OK
    if (modem_cmd(modem, "AT+CPMS?", rsp))
    {
        //get total mem1 locations
        i = modem_get_token(&rspptr, 2);
        if (i)
        {
            rspptr[i] = 0;
            msg_nr = atoi(rspptr);
        }
    }
    return msg_nr;
}


/**
 * @brief Delete message (AT+CMGD) at index in message store
 *
 * @param modem     pointer to modem device struct
 * @param index     index of message to be deleted
 *
 * @return 1 on success, 0 on error.
 */
int modem_delete_sms(modem_t *modem, int index)
{
    char buf[MODEM_SMALL_MSG] = "AT+CMGD=";

    modem_itoa(index, buf + 8);
    return modem_cmd(modem, buf, NULL);
}

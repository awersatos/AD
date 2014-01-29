/*************************************************************************
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  IN PACKAGE:         MODEM Communication
|*
|*  COPYRIGHT:          Copyright (c) 2007, Altium
|*
|*  DESCRIPTION:        Generic package to be able to send and receive modem AT commands
|*
 */
#include <timing.h>
#if ( __POSIX_KERNEL__ != 0 )
# include <pthread.h>
#else
#include <time.h>
#endif
//#define MODEM_DEBUG
#ifdef MODEM_DEBUG
#include <stdio.h>
#endif

#include <stdint.h>
#include <stdbool.h>
#include <errno.h>
#include <assert.h>
#include <string.h>
#include <fcntl.h>
#include <modem.h>
#include "modem_cfg_instance.h"

// device data
static modem_t modem_table[MODEM_INSTANCE_COUNT];

/**
 * @brief get a token from a comma seperated list
 *
 * The response from a modem is typically a comma seperated list like
 * +COPS: (1,NL KPN,NL KPN,20408,0),2,,(0,1,2,3,4,5),(0,1,2). In this
 * example list "1,NL KPN,NL KPN,20408,0" (starting "+COPS: " and enclosing
 * parentheses are ignored) has index 0 length 23, the "2" has index 1 length 1
 * and so on. The token is returned by setting *buf to the start of the token.
 * So if you want to keep your original pointer *buf you need to store it before
 * calling this function!
 *
 * @param  **buf   the comma seperated list, *buf will be set to the specified token
 * @param  index   the index of the token you want
 *
 * @return The lengt of the token found
 */
int modem_get_token(char** buf, int index)
{
    int ident = 0;
    int tokencnt = 0;
    int len = 0;
    int tmplen;

    if (*buf != NULL)
    {
        while (**buf != '\0')
        {
            if (**buf == '(')
                ident++;
            if (**buf == ')')
                ident--;
            if ((ident == 0) && (**buf == ','))
                tokencnt++;
            else if (tokencnt == index)
                len++;
            if (tokencnt > index)
                break;
            (*buf)++;
        }
        *buf -= len;
        // delete possible strarting command specifier eg +CREG: in list +CREG: 0,1
        if (index == 0 && **buf == '+')
        {
            tmplen = len;
            while (**buf != ':' && len)
            {
                (*buf)++;
                len--;
            } 
            if (len)
            {
                (*buf)++;
                len--;
                while (**buf == ' ' && len)
                {
                    len--;
                    (*buf)++;
                }
            }
            else // no ':' found restore the values for *buf and len;
            {
                *buf -= tmplen;
                len = tmplen;
            }
        }
        // Delete possible enclosing parentheses
        if ((**buf == '(') && (*(*buf + len - 1) == ')'))
        {
            len -= 2;
            (*buf)++;
        }
    }
    return len;
}

/**
 * @brief Convert an integer into a char
 *
 * @param  value    integer to be converted into a string
 * @param  result   the resulting string
 *
 * @return pointer to the resulting string.
 */
char *modem_itoa(int value, char* result)
{
    char* ptr = result, *ptr1 = result, tmp_char;
    int tmp_value;

    do
    {
        tmp_value = value;
        value /= 10;
        *ptr++ = "zyxwvutsrqponmlkjihgfedcba9876543210123456789abcdefghijklmnopqrstuvwxyz" [35 + (tmp_value - value * 10)];
    } while ( value );

    // Apply negative sign
    if (tmp_value < 0) *ptr++ = '-';
    *ptr-- = '\0';
    while(ptr1 < ptr)
    {
        tmp_char = *ptr;
        *ptr--= *ptr1;
        *ptr1++ = tmp_char;
    }
    return result;
}

/**
 * @brief Initialize the modem device
 *
 * This function initializes the communication with the modem device.
 *
 * @param id  Service id
 *
 * @return The modem service pointer for the specified device, or NULL on error.
 */
extern modem_t *modem_open(int id)
{
    modem_t *modem = &modem_table[id];
    modem_cfg_instance_t *cfg = &modem_instance_table[id];
    int fd;
    int serial_id;
    const char *name;

    assert(id >= 0 & id < MODEM_INSTANCE_COUNT);

    serial_id = modem_instance_table[id].serial;
    name = serial_instance_table[serial_id].name;

    fd = open(name, O_RDWR);

    posix_devctl(fd, DEVCTL_SERIAL_IMPL, &modem->serial, sizeof(posix_devctl_serial_impl_t), NULL);
    modem->speed      = modem->serial.f_get_baudrate(modem->serial.device);
    modem->timeout    = cfg->timeout;
    modem->mode       = MODEM_CMD;
    modem->kind       = cfg->kind;
    modem->isRinging  = false;
    modem->isHangup   = false;
    if (modem->kind != MODEM_KIND_MODEM_TELIT)
        modem_cmd(modem, "AT&D0\\Q3", NULL); // Set RTS/CTS, ignore DTR
    if (fd >= 0)
    {
        return modem;
    }
    return NULL;
}


/**
 * @brief Read data from modem
 */
inline int modem_rxdata(modem_t *modem)
{
    return modem->serial.f_getchar(modem->serial.device);
}

/**
 * @brief Transmit data to modem
 *
 * @param modem    pointer to modem device struct
 * @param data     string to send to modem.
 *
 * @return number of bytes actually sent
 */
int modem_txdata(modem_t *modem, const char *data)
{
    int i;
    int size = strlen(data);
#ifdef MODEM_DEBUG
    printf("%s", data);
#endif
    for (i = 0; i < size; i++)
    {
        modem->serial.f_putchar(modem->serial.device, (unsigned char)*data++);
    }
    return i;
}

/**
 * @brief Send AT command to modem and wait for repsonse (OK/ERROR)
 *
 * Specify a command without the trailing '\r'. The '\r' it is added by this function. 
 * If no command specified (cmd == NULL) the function will just wait on a modem repsonse.
 * This response including the OK or ERROR result is copied to rsp (rsp != NULL). 
 * Use modem_txdata when you donot want to wait on an answer (OK/ERROR).
 *  
 * @param modem     pointer to modem device struct
 * @param cmd       AT command (without trialing '\r') to send to modem
 * @param rsp       if rsp != NULL, modem reponse
 *
 * @return 1 on OK, 0 on ERROR, Timeout or modem not in command mode
 */
int modem_cmd(modem_t *modem, const char *cmd, char *rsp)
{
    char ch;
    int  count = 0;
    int  ret = 0;
    char buf[MODEM_SMALL_MSG] = "";
    uint64_t since_ms; // record current time

    if (modem->mode == MODEM_CMD)
    {
        if (cmd)
        {
            modem_txdata(modem, cmd);
            modem_txdata(modem, "\r");
        }
        since_ms = clock_ms();  // record current time
        while (1)
        {
        
            ch = modem->serial.f_getchar(modem->serial.device);
            if (ch != -1)
            {
                buf[count++] = (char)ch;
                buf[count] = 0;
            }
            // on ATCMGS= modem reponds with ">" instead of "OK" 
            if (strstr(buf, "OK") || strstr(buf, "CONNECT") || (strstr(cmd, "AT+CMGS=") && strstr(buf, ">")))
            {
                ret = 1;
                break;
            } else if (strstr(buf, "ERROR") || strstr(buf, "NO CARRIER") || (elapsed_time_ms(since_ms) >= modem->timeout))
            {
                break;
            }
        }
        if (strstr(buf, "RING"))
            modem->isRinging = true;
        if (strstr(buf, "NO CARRIER"))
            modem->isHangup = true;
        if (rsp)
            strcpy(rsp, buf);
    }
    #ifdef MODEM_DEBUG
        printf(" answer %s after %llums\n", buf, elapsed_time_ms(since_ms));
    #endif
    
    return ret; 
}
 
/**
 * @brief check if phone is ringing
 *
 * @param *modem     pointer to modem device struct
 *
 * @return 1 if modem is ringing, 0 otherwise.
 */
int modem_is_ringing(modem_t *modem)
{
    if (!modem->isRinging)
        modem_cmd(modem, "", NULL);
    return modem->isRinging;
}


/**
 * @brief check if phone is on the hook
 *
 * @param *modem     pointer to modem device struct
 *
 * @return 1 if modem is hangup, 0 otherwise.
 */
int modem_is_hangup(modem_t *modem)
{
    if (!modem->isHangup)
        modem_cmd(modem, "", NULL);
    return modem->isHangup;
}

/*******************************************************************************
 *
 *
 *
 *  Generic MODEM AT commands
 *
 *
 *
 ******************************************************************************/

 /**
 * @brief Set command echo (ATE)
 *
 * @param *modem  pointer to modem device struct
 * @param onoff   1 set echo on, 0 set echo off
 *
 * @return 1 on success, 0 on error.
 */
int modem_echo(modem_t *modem, int onoff)
{
    char buf[MODEM_SMALL_MSG] = "ATE";

    modem_itoa(onoff, buf + 3);
    return modem_cmd(modem, buf, NULL);
}

/**
 * @brief Set monitor speaker mode (ATM)
 *
 * @param *modem  pointer to modem device struct
 * @param onoff   1 set speaker on, 0 set speaker off
 *
 * @return 1 on success, 0 on error.
 */
int modem_speaker(modem_t *modem, int onoff)
{
    char buf[MODEM_SMALL_MSG] = "ATM";

    modem_itoa(onoff, buf + 3);
    return modem_cmd(modem, buf, NULL);
}

/**
 * @brief Set automatic answer (ATS0) on the specified ring number
 *
 * After count rings the modem will be answered automatically
 * if count = 0, automatic answering is disabled.
 *
 * @param modem     pointer to modem device struct
 * @param count     answer phone on this ring count
 *
 * @return 1 on success, 0 on error.
 */
int modem_set_autoanswer(modem_t *modem, int count)
{
    char buf[MODEM_SMALL_MSG] = "ATS0=";

    modem_itoa(count, buf + 5);
    return modem_cmd(modem, buf, NULL);
}

/**
 * @brief Answer call (ATA)
 *
 * @param *modem     pointer to modem device struct
 *
 * @return 1 on success, 0 on error.
 */
int modem_answer(modem_t *modem)
{
    int ret = modem_cmd(modem, "ATA", NULL);

    if (ret)
    {
        modem->isRinging = false;
        modem->mode = MODEM_DATA;
    }
    return ret;
}

/**
 * @brief Dial command (ATD)
 *
 * Dial the passed phone number
 *
 * @param *modem     pointer to modem device struct
 * @param *number    pointer to string phone number
 *
 * @return 1 on success, 0 on error.
 */
int modem_dial(modem_t *modem, const char *number)
{
    char buf[MODEM_SMALL_MSG] = "ATD ";
    
    strcat(buf, number);
    return modem_cmd(modem, buf, NULL);
}

/**
 * @brief Hangup the modem (ATH)
 *
 * @param modem     pointer to modem device struct
 *
 * @return 1 on success, 0 on error.
 */
int modem_hangup(modem_t *modem)
{
    int ret = 0;

    if (modem->mode != MODEM_CMD)
    {
        if (modem->mode == MODEM_VOICE)
        {
            // required for rockwell modems in voice tranmit mode
            modem_txdata(modem, "\x10\x03");  // <DLE><ETX> goto online voice command mode
        }
        delay_ms(1500);
        if (modem_cmd(modem, "+++", NULL))   // goto command mode
            modem->mode = MODEM_CMD;
    }   
    if (modem->mode == MODEM_CMD)
    {
        ret = modem_cmd(modem, "ATH", NULL);
        modem->isRinging = false;
        if (ret)
            modem->isHangup = true;
    }
    return ret;
}

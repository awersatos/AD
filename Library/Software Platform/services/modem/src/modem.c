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
#if __POSIX_KERNEL__
# include <pthread.h>
#else
#include <time.h>
#endif

#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <errno.h>
#include <assert.h>
#include <string.h>
#include <fcntl.h>

#include <sysutils.h>

#include <csv.h>                                   
#include <modem_i.h>
#include "modem_cfg_instance.h"

// device data
static modem_t modem_table[MODEM_INSTANCE_COUNT];

/**
 * @brief Initialize the modem device if it is not yet initialized.
 *        Return the a handle to the modem instance.
 *
 * This function initializes the communication with the modem device.
 *
 * @param id  Service id
 *
 * @return The modem service pointer for the specified device, or NULL on error.
 */
extern modem_t *modem_open(unsigned int id)
{
    modem_t *modem = &modem_table[id];
    const modem_cfg_instance_t *cfg = &modem_instance_table[id];
    int fd;
    int serial_id;
    const char *name;

    assert(id < MODEM_INSTANCE_COUNT);

    if (modem->signature != MODEM_SIGNATURE)
    {
        memset(modem,0,sizeof(modem_t));

        serial_id = cfg->serial;
        name = serial_instance_table[serial_id].name;

        fd = open(name, O_RDWR);
        if (fd < 0)
        {
            modem = NULL;
        }
        else
        {
            posix_devctl(fd, DEVCTL_SERIAL_IMPL, &modem->serial, sizeof(posix_devctl_serial_impl_t), NULL);
            modem->fd              = fd;
            modem->speed           = modem->serial.f_get_baudrate(modem->serial.device);
            modem->timeout_ms      = cfg->timeout;
            modem->mode            = MODEM_UNKNOWN_MODE;
            modem->kind            = cfg->kind;
            modem->sms_storage     = SMS_STORAGE_SIM;
            
            modem_add_listener(modem,MODEM_ERROR_STRING,     &modem_error_found,     NULL);
            modem_add_listener(modem,MODEM_RING_STRING,      &modem_ring_found,      NULL);
            modem_add_listener(modem,MODEM_NO_CARRIER_STRING,&modem_no_carrier_found,NULL);

            modem->signature  = MODEM_SIGNATURE;

#if __POSIX_KERNEL__
            {
                pthread_mutexattr_t mutexattr;
                pthread_mutexattr_init(&mutexattr);
                pthread_mutexattr_settype(&mutexattr, PTHREAD_MUTEX_RECURSIVE);
                pthread_mutex_init(&modem->MODEM_mutex, &mutexattr);
            }
#endif
        }
    }
    return modem;
}

#define MODEM_STARTUP_TIMEOUT_MS 40000

/**
 * @brief Activate the associated modem device
 *
 * @param  modem       a pointer to a modem_t instance returned by modem_open()
 * @return true        if the function was successful, or
 *         false       otherwise.
 */
extern bool modem_start(modem_t * modem)
{
    uint64_t timeout;

    if (is_modem_ready(modem))
        goto success;

    modem_reset(modem);

    timeout = clock_ms() + MODEM_STARTUP_TIMEOUT_MS;
    while (clock_ms() < timeout)
        if (is_modem_ready(modem))
            goto success;

    return false;
success:
    if (MODEM_SUPPORTS_SUSPEND(modem))
        modem_set_dtr_mode(modem, MODEM_DTR_CMD);
    return true;
}

/**
 * @brief Reset the associated modem device
 *
 * @param  modem       a pointer to a modem_t instance returned by modem_open()
 * @return true        if the operation was successful, or
 *         false       otherwise.
 */
extern bool modem_reset(modem_t * modem)
{
    bool result;

    result = posix_devctl(modem->fd, DEVCTL_SERIAL_POWER_ON, NULL, 0, NULL) == 0;
    if (result) modem_sleep(6000); // ignore initial period where modem responds to AT
    return result;
}

/*******************************************************************************
 *  Modem IO Functions
 ******************************************************************************/

/**
 * @brief Read multiple characters from the modem and look a response of "OK"
  *
 * Read the modem and wait until either
 *           -- "OK" was received, or
 *           -- a timeout has occured.
 *
 * Note: that some commands (eg. AT+IPR=PINCODE) take a long time before you
 * actually get a reponse. When using such commands wait before calling this
 * routine. Also note ther're commands resulting in two answers (eg. ATDT -->
 * OK and later CONNECT)
 *
 * @param modem      pointer to modem device struct
 * @param cmd        AT command (without trialing '\r') to send to modem
 *
 * @return 0 if "OK" is not found, non-zero if it is found.
 */
int modem_cmd(modem_t *modem, const char * command)
{
    const char *expected = "OK";
    return modem_cmd_ex(modem,command,&expected,1,MODEM_DEFAULT_TIMEOUT) == 0;
}

/**
 * @brief Read multiple characters from the modem and look for any one of a number of given strings
  *
 * Read the modem and wait until either
 *           -- one of the expected responses was received, or
 *           -- a timeout has occured.
 *
 * Note: that some commands (eg. AT+IPR=PINCODE) take a long time before you
 * actually get a reponse. When using such commands wait before calling this
 * routine. Also note ther're commands resulting in two answers (eg. ATDT -->
 * OK and later CONNECT)
 *
 * @param modem          pointer to modem device struct
 * @param cmd            AT command (without trialing '\r') to send to modem
 * @param expected       an array of expected responses
 * @param expected_count the length of the expected array
 * @param timeout_ms     the timeout, in milliseconds
 *
 * @return -1 if the expected response is not found, or the index of the expected result that was found
 */
int modem_cmd_ex(modem_t *modem, const char * command, const char ** expected, int expected_count, uint32_t timeout_ms)
{
    modem_listener_t expected_response[MODEM_MAX_LISTENERS];
    int      i,ch;
    uint64_t start_ms = clock_ms();
    uint64_t actual_timeout_ms = timeout_ms==MODEM_DEFAULT_TIMEOUT ? modem->timeout_ms : timeout_ms;
    int      status = MODEM_LISTENER_RUNNING;
    int      result = -1;

#if __POSIX_KERNEL__
    pthread_mutex_lock(&modem->MODEM_mutex);
#endif

    assert(expected_count < MODEM_MAX_LISTENERS);

    for (i=0;i<expected_count;i++)
    {
        memset(&expected_response[i],0,sizeof(modem_listener_t));
        expected_response[i].string = expected[i];
    }

    if (modem_get_mode(modem)!=MODEM_CMD)
        modem_set_mode(modem,MODEM_CMD);
    if (command)
    {
        modem_write(modem, (uint8_t *) command,0);
        modem_send(modem, '\r');
    }
    while(status == MODEM_LISTENER_RUNNING)
    {
        ch = modem_recv(modem);
        if (ch == -1)
        {
            if (clock_ms() >= start_ms + actual_timeout_ms)
                status = MODEM_LISTENER_TIMEOUT;
 #if __POSIX_KERNEL__
            else
               sched_yield();
 #endif
            continue;
        }
        else
        {
#ifdef MODEM_DEBUG
            fputc(ch,stdout);
#endif
            for (i=0;i<MODEM_MAX_LISTENERS;i++)
            {
                status = modem_listen(modem, &modem->listeners[i],(char)ch);
                if (status == MODEM_LISTENER_FOUND) break;
            }
            for (i=0;i<expected_count;i++)
            {
                status = modem_listen(modem,&expected_response[i],(char)ch);
                if (status == MODEM_LISTENER_FOUND)
                {
                    result = i;
                    break;
                }
            }
        }
    };
#ifdef MODEM_DEBUG
    printf("modem_seek: \"%s\" %s\n", *expected,
            status == MODEM_LISTENER_RUNNING ? "not in command mode" :
            status == MODEM_LISTENER_TIMEOUT ? "timed out"           :
            status == MODEM_LISTENER_ERROR   ? "found ERROR"         :
            status == MODEM_LISTENER_FOUND   ? "found"               :
            "something impossible happened");
#endif

#if __POSIX_KERNEL__
    pthread_mutex_unlock(&modem->MODEM_mutex);
#endif

    return status == MODEM_LISTENER_FOUND ? result : -1;
}
                        

#define MODEM_TEST_INTERVAL_MS 600
#define MODEM_TEST_REPETITIONS 4
bool is_modem_ready(modem_t * modem)
{
    int i;
    bool retVal = false;

    for (i=0;i<MODEM_TEST_REPETITIONS;i++)
    {
        if (modem_cmd(modem,"AT"))
        {
            modem->mode = MODEM_CMD;
            retVal = true;
            break;
        }
        modem_sleep(MODEM_TEST_INTERVAL_MS);
    }
    return retVal;
}

/**
 * @brief Read multiple bytes from the modem
 *
 * Read the modem and wait until either
 *           -- the serial device fails to return a character and the timeout has elapses, or
 *           -- len characters are received
 *
 * @param modem     pointer to modem device struct
 * @param buf       the buffer into which the data is placed
 * @param len       the buffer length in bytes.
 *
 * @return the number of characters read
 */
int modem_read(modem_t *modem, uint8_t * buf, size_t len)
{
    int         ch, i;
    uint32_t    count = 0;
    uint64_t    timeout_ms = clock_ms() + modem->timeout_ms;
    int         status = MODEM_LISTENER_RUNNING;

#if __POSIX_KERNEL__
    pthread_mutex_lock(&modem->MODEM_mutex);
#endif

    for (;;)
    {
        ch = modem->serial.f_getchar(modem->serial.device);
        if (ch == -1)
        {
            if (clock_ms() >= timeout_ms)
            {
                break;
            }
            else
            {
 #if __POSIX_KERNEL__
                sched_yield();
 #endif
                continue;
            }
        }
        if (count >= len) break;
        buf[count++] = (uint8_t) ch;

        for (i=0;i<MODEM_MAX_LISTENERS && status != MODEM_LISTENER_FOUND;i++)
            status = modem_listen(modem, &modem->listeners[i],(char)ch);

#ifdef MODEM_DEBUG_HEX
       if (count==1) fputs("modem_read()=",stderr);
       fprintf(stderr," %02x",ch);
       if (!(count % 16)) fputs("\n             ",stderr);
#endif
    }
#ifdef MODEM_DEBUG_HEX
    fputs("\n\n",stderr);
#endif
#ifdef MODEM_DEBUG
    if (count>0) printf("modem_read: %u chars read\n", count);
#endif

#if __POSIX_KERNEL__
    pthread_mutex_unlock(&modem->MODEM_mutex);
#endif

    return count;
}

/**
 * @brief write data to the modem
 *
 * @param modem     pointer to modem device struct
 * @param buf       data to send to the modem
 * @param size      the number of bytes to send. If this is 0,
 *                  buf is treated as a null-terminated string.
 *
 * @return number of bytes actually sent
 */
int modem_write(modem_t *modem, const uint8_t *buf, size_t len)
{
    int i;
    int actual_size = (len==0) ? strlen((char *) buf) : len;
#ifdef MODEM_DEBUG
    fprintf(stdout,">>    %s\n", buf);
#endif

#if __POSIX_KERNEL__
    pthread_mutex_lock(&modem->MODEM_mutex);
#endif

    while(modem->serial.f_getchar(modem->serial.device) != -1);
    for (i = 0; i < actual_size; i++)
    {
        modem->serial.f_putchar(modem->serial.device, *buf++);
    }

#if __POSIX_KERNEL__
    pthread_mutex_unlock(&modem->MODEM_mutex);
#endif

    return i;
}


/**
 * @brief read a character from the modem
 *
 * @param modem     pointer to modem device struct
 * @return the character read, or -1 if none was read
 */
int modem_recv(modem_t *modem)
{
    int ch;
#if __POSIX_KERNEL__
    pthread_mutex_lock(&modem->MODEM_mutex);
#endif
    ch = modem->serial.f_getchar(modem->serial.device);
#if __POSIX_KERNEL__
    pthread_mutex_unlock(&modem->MODEM_mutex);
#endif
#ifdef MODEM_DEBUG
    fputc(ch,stdout);
#endif
    return ch;
}

/**
 * @brief send a character to the modem
 *
 * @param modem     pointer to modem device struct
 * @param ch        the character to write
 *
 */
void modem_send(modem_t *modem, uint8_t ch)
{
#ifdef MODEM_DEBUG
    fputc(ch,stderr);
#endif
#if __POSIX_KERNEL__
    pthread_mutex_lock(&modem->MODEM_mutex);
#endif
    modem->serial.f_putchar(modem->serial.device,ch);
#if __POSIX_KERNEL__
    pthread_mutex_unlock(&modem->MODEM_mutex);
#endif
}


/*******************************************************************************
 *  Modem status requests
 ******************************************************************************/

/**
 * @brief check if phone is ringing
 *
 * @param *modem     pointer to modem device struct
 *
 * @return 1 if modem is ringing, 0 otherwise.
 */
int modem_is_ringing(modem_t *modem)
{
#if __POSIX_KERNEL__
    pthread_mutex_lock(&modem->MODEM_mutex);
#endif

    if (!modem->isRinging)
        modem_cmd(modem,  NULL); // read anything pending - this searches for the ringing indicator

#if __POSIX_KERNEL__
    pthread_mutex_unlock(&modem->MODEM_mutex);
#endif
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
#if __POSIX_KERNEL__
    pthread_mutex_lock(&modem->MODEM_mutex);
#endif

    if (!modem->isHangup)
        modem_cmd(modem, NULL); // read anything pending - this searches for the no carrier indicator

#if __POSIX_KERNEL__
    pthread_mutex_unlock(&modem->MODEM_mutex);
#endif
    return modem->isHangup;
}

/*******************************************************************************
 *  Generic MODEM AT commands
 ******************************************************************************/

 /**
 * @brief Set command echo (ATE)
 *
 * @param *modem  pointer to modem device struct
 * @param echo_on true set echo on, false set echo off
 * @param verbose true set verbose response codes on, false set verbose response codes off
 *
 * @return 1 on success, 0 on error.
 */
int modem_echo(modem_t *modem, bool echo_on, bool verbose_results)
{
    char buf[MODEM_SMALL_MSG];
    snprintf(buf,MODEM_SMALL_MSG,"ATE%uV%u",echo_on ? 1 : 0,verbose_results ? 1 : 0);
    return modem_cmd(modem, buf);
}

/**
 * @brief Set monitor speaker mode (ATM)
 *
 * @param *modem  pointer to modem device struct
 * @param speaker_on   true set speaker on, false set speaker off
 *
 * @return 1 on success, 0 on error.
 */
int modem_speaker(modem_t *modem, bool speaker_on)
{
    char buf[MODEM_SMALL_MSG];
    snprintf(buf,MODEM_SMALL_MSG,"ATM%u",speaker_on ? 1 : 0);
    return modem_cmd(modem,  buf);
}

/**
 * @brief Set automatic answer (ATS0) on the specified ring count
 *
 * After count rings the modem will be answered automatically
 * if count = 0, automatic answering is disabled.
 *
 * @param modem     pointer to modem device struct
 * @param count     answer phone on this ring count
 *
 * @return 1 on success, 0 on error.
 */
int modem_autoanswer(modem_t *modem, int count)
{
    char buf[MODEM_SMALL_MSG];

    snprintf( buf,MODEM_SMALL_MSG, "ATS0=%u",count);
    return modem_cmd(modem, buf);
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
    int ret = modem_cmd(modem, "ATA");

    if (ret)
    {
#if __POSIX_KERNEL__
    pthread_mutex_lock(&modem->MODEM_mutex);
#endif
        modem->isRinging = false;
        modem->mode = MODEM_DATA; // JTK -- not always!!
#if __POSIX_KERNEL__
    pthread_mutex_unlock(&modem->MODEM_mutex);
#endif
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
    const char * responses[] = { "CONNECT", "VOICE CALL: BEGIN"};
    int ret;

#if __POSIX_KERNEL__
    pthread_mutex_lock(&modem->MODEM_mutex);
#endif

    strcat(buf, number);
    if (number[0] == '*')
    {
        ret = modem_cmd_ex(modem, buf,&responses[0],1 ,MODEM_DEFAULT_TIMEOUT) == 0;
        if (ret)
            modem->mode = MODEM_DATA;
    }
    else
    {
        strcat(buf,";");
        ret = modem_cmd_ex(modem, buf, &responses[1],1,MODEM_DEFAULT_TIMEOUT) == 0;
        if (ret)
            modem->mode = MODEM_VOICE;
    }

#if __POSIX_KERNEL__
    pthread_mutex_unlock(&modem->MODEM_mutex);
#endif

    return ret;
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

#if __POSIX_KERNEL__
    pthread_mutex_lock(&modem->MODEM_mutex);
#endif

    modem_set_mode(modem, MODEM_CMD);
    if (modem->mode == MODEM_CMD)
    {
        ret = modem_cmd(modem, "ATH");
        modem->isRinging = false;
        if (ret)
            modem->isHangup = true;
    }

#if __POSIX_KERNEL__
    pthread_mutex_unlock(&modem->MODEM_mutex);
#endif

    return ret;
}

/**
 * @brief Select modem mode (AT#CLS=8)
 *
 * @param modem     pointer to modem device struct
 * @param mode      the desired mode
 *
 * @return 1 on success, 0 on error.
 */
int modem_set_mode(modem_t *modem, modem_mode_t mode)
{
    int ret=0, i=0;
    char buf[MODEM_SMALL_MSG];
    const char * expected = "CONNECT";

#if __POSIX_KERNEL__
    pthread_mutex_lock(&modem->MODEM_mutex);
#endif
    switch (mode)
    {
    case MODEM_CMD:
        if (modem->mode == MODEM_VOICE)
        {
            // required for rockwell modems in voice tranmit mode
            modem_write(modem, (uint8_t *) "\x10\x03",0);  // <DLE><ETX> goto online voice command mode
        }
        while (ret==0 && i++ < MODEM_TEST_REPETITIONS)
        {
            if (MODEM_SUPPORTS_PLUS_PLUS_PLUS(modem))
            {
                modem_sleep(1000);
                modem_write(modem, (uint8_t *) "+++",3);
                modem_sleep(1000);
            }
            else if (MODEM_SUPPORTS_SUSPEND(modem))
                posix_devctl(modem->fd, DEVCTL_SERIAL_SUSPEND, NULL, 0, NULL);
            // can't use is_modem_ready() here because that calls modem_cmd which calls modem_set_mode => infinite recursion
#ifdef MODEM_DEBUG //write this to the uart so you can see it in the data stream. Note that this will not affect communications.
            modem_write(modem, (uint8_t *) "DTR\r", 0); 
#endif
            modem_write(modem, (uint8_t *) "AT\r", 0);
            modem_read(modem,  (uint8_t *) buf, MODEM_SMALL_MSG);
            ret = (strstr(buf,"OK") || strstr(buf,"+++"));
        }
        break;
    case MODEM_DATA:
        ret = modem_cmd_ex(modem, "ATO", &expected,1,MODEM_DEFAULT_TIMEOUT) == 0;
        break;
    case MODEM_VOICE:
        ret = modem_cmd(modem, "AT#CLS=8");
        break;
    default:
        ret = 0;
        break;    
    }

    if (ret)
        modem->mode = mode;

#if __POSIX_KERNEL__
    pthread_mutex_unlock(&modem->MODEM_mutex);
#endif

    return ret;
}

/**
 * @brief get the current mode of the modem
 *
 * @param modem     pointer to modem device struct
 *
 * @return the current mode
 */
modem_mode_t modem_get_mode(modem_t * modem)
{
    return modem->mode;
}


/**
 * @brief Retrieve first active call number (AT+CLCC)
 *
 * Retrieves the telephone number of the first active call, if any.
 *
 * @param modem     pointer to modem device struct
 * @param number    pointer to a character string which will contain the phone number called, if any
 *
 * @return 1 if an incoming call is current, 2 if an outgoing call is current, 0 if no calls are active.
 */
int modem_get_current_call(modem_t *modem, char * number)
{
    #define MAX_TOKENS  10
    char * token[MAX_TOKENS];
    int token_count = MAX_TOKENS;
    bool success;
    int len;
    char buf[MODEM_SMALL_MSG];
    const char * expected =  "+CLCC: ";

    // check if registration to GSM network is ok
    success = modem_cmd_ex(modem, "AT+CLCC", &expected, 1,MODEM_DEFAULT_TIMEOUT) == 0;
    if (!success) return 0;

    len = modem_read(modem,(uint8_t *) buf,MODEM_SMALL_MSG);
    if (len == 0) return 0;

    tokenize_csv_line(buf,len,token,&token_count);
    if (token_count < 2) return 0;

    if (token_count > 5)
        strcpy(number,token[5]);

    switch (*token[1])       // look at <dir> parameter
    {
        case '0':    return 1;
        case '1':    return 2;
        default:     return 0;
    }
}

/**
 * @brief Retrieve the revision string of the modem (ATI)
 *
 * Retrieves the revision string for the modem, if any.
 *
 * @param modem     pointer to modem device struct
 * @param number    pointer to a character string which will contain the revision string, if any
 *
 * @return 1 if a revision string is found, 0 if no string is returned.
 */
int modem_get_revision_string(modem_t *modem, char * revision, size_t revision_len)
{
    bool success;
    char * eol = NULL;
    size_t len;
    const char * expected = "Revision: ";

    success = modem_cmd_ex(modem, "ATI", &expected, 1, MODEM_DEFAULT_TIMEOUT) == 0;
    if (!success) return 0;

    len = modem_read(modem,(uint8_t *) revision,revision_len);
    if (len == 0) return 0;

    eol = strchr(revision,'\n');
    if (eol) *eol = '\0';

    return 1;
}

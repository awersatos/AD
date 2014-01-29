/*************************************************************************
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  IN PACKAGE:         MODEM Communication
|*
|*  COPYRIGHT:          Copyright (c) 2007, Altium
|*
|*  DESCRIPTION:        AT Commands to handle rending and receiving voice messages
|*                      using a modem
 */
#include <timing.h>
#if ( __POSIX_KERNEL__ != 0 )
# include <pthread.h>
#else
#include <time.h>
#endif

#ifdef MODEM_DEBUG
#include <stdio.h>
#endif
#include <string.h>
#include <modem.h>
/**
 * @brief Select VOICE/Audio mode (AT#CLS=8)
 *
 * @param modem     pointer to modem device struct
 *
 * @return 1 on success, 0 on error.
 */
int modem_select_voice(modem_t *modem)
{
    int ret = modem_cmd(modem, "AT#CLS=8", NULL);

    if (ret)
    {
        modem->mode = MODEM_VOICE;
    }
    return ret;
}


/**
 * @brief Voice transmit (AT#VTX) a wav file
 *
 * Send a wavefile in rockwell-4 format through modem.
 *
 * @param *modem   pointer to modem device struct
 * @param *wav     pointer to begin of a buffer containing a wav file
 * @param size     size of the wav buffer
 *
 * @return 1 on success, 0 on error.
 */
int modem_voice_transmit(modem_t *modem, unsigned char *wav, int size)
{
    int i;
    int ret = modem_cmd(modem, "AT#VTX", NULL);

    if(ret)
    {
        for (i=0; i<size; i++)
            modem->serial.f_putchar(modem->serial.device, wav[i]);
        modem_txdata(modem, "\x10\x03");  //send <DLE><ETX> to switchback to (voice) command mode
    }
    return ret;
}


/**
 * @brief Filter DLE (Data Link Escape 0x10 chars) from buf
 *
 * @param buf          a string (0 terminated)
 *
 * @return Nothing.
 */
void modem_filter_dle(char *buf)
{
    int size = strlen(buf);
    int i;
    int j = 0;

    for (i = 0; i < size + 1; i++)
    {
        if ( buf[i] != '\x10')
        {
            buf[j] = buf[i];
            j++;
        }
    }
    buf[j] = 0;
}

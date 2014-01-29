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

#include <stdio.h>
#include <string.h>
#include <modem_i.h>


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
extern int modem_voice_transmit(modem_t *modem, uint8_t *wav, size_t size)
{
    int ret = 0;

    if(modem_cmd(modem, "AT#VTX"))
    {
        modem_write(modem, wav, size);
        modem_write(modem, (uint8_t *) "\x10\x03",0);  //send <DLE><ETX> to switchback to (voice) command mode
        ret = 1;
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

/*****************************************************************************\
|*
|*  VERSION CONTROL:    $Version$   $Date$
|*
|*  IN PACKAGE:         PDU SMS Coder/Decoder
|*
|*  COPYRIGHT:          Copyright (c) 2007, Altium
|*
|*  DESCRIPTION:        handling of PDU encoded SMS messages
|*
 */
#define SMALL_SIZE 32

#include <string.h>
#include <ctype.h>
#include <assert.h>
#include <modem_i.h>


typedef enum bit_decode_mode {
    RESET_BIT_DECODER,
    FEED_BIT_DECODER
} BIT_DECODER_MODE;

typedef enum bit_encode_mode {
    RESET_BIT_ENCODER,
    FEED_BIT_ENCODER,
    FLUSH_BIT_ENCODER
} BIT_ENCODER_MODE;

/**
 *
 *  @brief    add a byte in hex notation to a char array
 *
 *  @param    buf            string to store data and add the specified byte to
 *  @param    c              byte value to add as a hex string to buf
 *  @param    max_len        max. length of buf
 *
 *  @return Nothing.
 */
static void pdu_add_hex(char * buf, char c, int max_len)
{
    const char hex_table[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
    int len;

    len = strlen(buf);

    // Check if there is room
    if ( len < (max_len - 1) )
    {
            // high nibble
            buf[len] = hex_table[(c >> 4) & 0x0f];
            len++;
            // low nibble
            buf[len] = hex_table[c & 0x0f];
            len++;
            // terminate
            buf[len]=0;
    }
}


/**
 *
 *  @brief
 *
 *  @return:   1 on succes, 0 on invalid constructed char value (>= 128)
 */
static int pdu_add_constructed_byte(char * buf, unsigned char constructed, int * len, int data_length)
{
    // iso 8859-1 default 7-bit charset
    const char charset[128] = {'@' , (char)163 ,       '$' , (char)165 , (char)232 , (char)233 , (char)249 , (char)236 ,
    (char)242 , (char)199 , (char) 10 , (char)216 , (char)248 , (char) 13 , (char)197 , (char)229 ,
    (char)255 ,       '_' , (char)255 , (char)255 , (char)255 , (char)255 , (char)255 , (char)255 ,
    (char)255 , (char)255 , (char)255 , (char)255 , (char)198 , (char)230 , (char)223 , (char)201 ,
       ' ' ,       '!' , (char) 34 ,       '#' ,       '$' ,       '%' ,       '&' , (char) 39 ,
       '(' ,       ')' ,       '*' ,       '+' ,       ',' ,       '-' ,       '.' ,       '/' ,
       '0' ,       '1' ,       '2' ,       '3' ,       '4' ,       '5' ,       '6' ,       '7' ,
       '8' ,       '9' ,       ':' ,       ';' ,       '<' ,       '=' ,       '>' ,       '?' ,
    (char)161 ,       'A' ,       'B' ,       'C' ,       'D' ,       'E' ,       'F' ,       'G' ,
       'H' ,       'I' ,       'J' ,       'K' ,       'L' ,       'M' ,       'N' ,       'O' ,
       'P' ,       'Q' ,       'R' ,       'S' ,       'T' ,       'U' ,       'V' ,       'W' ,
       'X' ,       'Y' ,       'Z' , (char)196 , (char)214 , (char)209 , (char)220 , (char)167 ,
    (char)191 ,       'a' ,       'b' ,       'c' ,       'd' ,       'e' ,       'f' ,       'g' ,
       'h' ,       'i' ,       'j' ,       'k' ,       'l' ,       'm' ,       'n' ,       'o' ,
       'p' ,       'q' ,       'r' ,       's' ,       't' ,       'u' ,       'v' ,       'w' ,
       'x' ,       'y' ,       'z' , (char)228 , (char)246 , (char)241 , (char)252 , (char)224 };
    int ret = 0;

    if (*len < data_length)
    {
        // only add char from 7 bit alphabet
        if (constructed < 128)
        {
            buf[*len] = charset[constructed];
            *len = (*len) + 1;
            buf[*len] = 0;
            ret = 1;
        }
    }
    return ret;
}


/**
 *
 *  @brief   bit-operations to decode the 8-bit PDU data bytes into septets
 *
 *  The translation is like:
 *  input octets             .  .  .  .  .  .  .  . |.  .  .  .  .  .  .  . |.  .  .  .  .  .  .  .
 *  septets bits for A, B, C..  B0 A6 A5 A4 A3 A2 A1 A0 C1 C0 B6 B5 B4 B3 B2 B1 D2 D1 D0 C6 C5 C4 C3 C2
 *
 *  @param    b              byte to decode
 *  @param    mode           flag to reset or feed the decoding part
 *  @param    data_length    length of data to come
 *  @param    buf            room to store decoded stuff
 *
 *  @return Number of bytes written.
 */
static int pdu_decode_byte(unsigned char b, BIT_DECODER_MODE mode, int data_length, char * buf)
{
    static unsigned char kept = 0;
    static unsigned char bits = 7;
    static int len = 0;
    int ret = 0;
    int i;
    unsigned char mask;
    unsigned char constructed;

    if (mode == RESET_BIT_DECODER)
    {
        len = 0;
        kept = 0;
        bits = 7;
    }
    else
    {
        mask = 0;
        for (i = 0; i < bits; i++)
        {
            mask = mask | (0x01 << i);
        }

        constructed = ((b & mask) << (7-bits)) | (kept >> (bits+1)) ;
        ret = ret + pdu_add_constructed_byte(buf, constructed, &len, data_length);
        kept = b & ~mask;

        bits--;

        // after processing seven octets (and storing the septets)
        // we have again another septet available. Add this septet
        // and reset the bits and "kept" values
        if (bits == 0)
        {
            ret = ret + pdu_add_constructed_byte(buf, (unsigned char)(kept >> 1), &len, data_length);
            bits = 7;
            kept= 0;
        }
    }
    return ret;
}


/**
 *  @brief State machine for decoding SMS PDU message.
 *
 *  SMS PDU message globally is like:
 *  Length_of_SMSC_info - SMSC_info - first_SMS_octet - sender_address_length
 *  - [sender_address] - protocol+coding - timestamp - user-data-length - user-data
 *
 *  @param    c        char to feed to the state machine
 *  @param    mode     flag to reset, feed or flush the encoding part 
 *  @param    message  pointer to the SMS
 *
 *  @return Nothing.
 */
static void pdu_decode_state(unsigned char c, BIT_DECODER_MODE mode, smsg_t * message)
{
    static int dec_state = 0;
    static int smsc_len = 0;
    static int smsc_info_count = 0;
    static int addr_len = 0;
    static int addr_count = 0;
    static int msg_len = 0;
    static int msg_count = 0;
    static int timestamp_count = 0;
    static char buf [SMS_MSG_SIZE] = "";

    int tmp;

    if (mode == RESET_BIT_DECODER)
    {
        dec_state = 0;
        smsc_len = 0;
        smsc_info_count = 0;
        addr_len = 0;
        addr_count = 0;
        msg_len = 0;
        msg_count = 0;
        timestamp_count = 0;
        strcpy(buf, "");
        pdu_decode_byte(0, RESET_BIT_DECODER, 0, buf);
        strcpy(buf, "");
    }
    else
    {
        switch (dec_state)
        {
        case 0:
            // get SMSC info length
            smsc_len = c;
            if (smsc_len != 0)
            {
                dec_state = 1;
            }
            else
            {
                dec_state = 2; // no smsc info available
            }
            break;
        case 1:
            // get SMSC info
            smsc_info_count++;
            if (smsc_info_count == smsc_len)
            {
                dec_state = 2; // info done, goto next state
            }
            break;
        case 2:
            // process first octet and go to next state
            dec_state = 3;
            break;
        case 3:
            // get address length
            addr_len = c;
            if (addr_len != 0)
            {
                // correct for odd/even
                addr_len = addr_len + addr_len % 2;

                // correct address length for semi octets and extra info
                // type-byte, semi-octets, tp_pid and tp-dcs
                addr_len = addr_len/2 + 3;
                strcpy(buf, "");
                addr_count = 0;
                dec_state = 4;
            }
            else
            {
                dec_state = 5; // no addr available
            }
            break;
        case 4:
            // get addr
            addr_count++;

            if (addr_count == 1)
            {
                message->addr_type = (unsigned char)c;
            }
            else
            {
                if (addr_count <= addr_len - 2)
                {
                    // swap high and low nibble
                    tmp = ((c & 0x00F0) >> 4) | ((c & 0x000F) << 4);
                    pdu_add_hex(buf, (char)tmp, SMALL_SIZE);
                }
                else
                {
                    if (buf[strlen(buf) - 1] == 'F')
                        buf[strlen(buf) - 1] = 0;
                }
            }

            if (addr_count == addr_len)
            {
                strcpy(message->from, buf);
                strcpy(buf, "");
                dec_state = 5;
            }

            break;
        case 5:
            // get timestamp
            timestamp_count++;
            // swap high and low nibble
            tmp = ((c & 0x00F0) >> 4) | ((c & 0x000F) << 4);
            pdu_add_hex(buf, (char)tmp, SMALL_SIZE);

            if (timestamp_count == 7)
            {
                strcpy(message->timestamp, buf);
                strcpy(buf, "");
                dec_state = 6;
            }
            break;
        case 6:
            // get message length (depends on tpdcs field !!!)
            msg_len = c;
            dec_state = 7;
            break;
        case 7:
            // process message data
            msg_count = msg_count+pdu_decode_byte(c, FEED_BIT_DECODER, msg_len, buf);
            if (msg_count >= msg_len)
            {
                strcpy(message->message, buf);
                strcpy(buf, "");

                dec_state = 0;
            }
            break;
        default:
            dec_state = 0;
            break;

        }
    }
}


/**
 *  @brief   decode an entire PDU encoded message and store the result in the
 *           smsg_t message structure
 *
 *  @param    pdu            pointer to a pdu encoded message
 *  @param    message        structure to store the decoded message
 *
 *  @return Nothing.
 */
void sms_pdu_decode(char * pdu, smsg_t * message)
{
    char * rsp = pdu;
    unsigned int pos;
    unsigned char c;
    char hi_nibble, lo_nibble;

    // reset state machine
    pdu_decode_state(0, RESET_BIT_DECODER, message);

    // reset message structure
    strcpy(message->timestamp, "");
    strcpy(message->from, "");
    strcpy(message->message, "");

    // assume reply is pdu
    pos = 0;
    while ((rsp[pos] != 0x0d) && (pos < strlen(rsp)))
    {
        c = 0;
        hi_nibble = (char) toupper(rsp[pos]);
        pos++;
        lo_nibble = (char) toupper(rsp[pos]);
        pos++;

        if ((isxdigit(hi_nibble)) && (isxdigit(lo_nibble)))
        {
            if (isdigit(hi_nibble))
            {
                c = (hi_nibble - '0') << 4;
            }
            else
            {
                c = ((hi_nibble - 'A')+10) << 4;
            }

            if (isdigit(lo_nibble))
            {
                c = c + (lo_nibble - '0');
            }
            else
            {
                c = c + ((lo_nibble - 'A') + 10);
            }
        }
        pdu_decode_state(c, FEED_BIT_DECODER, message);
    }

}


/**
 *  @brief    do the bit shift operations to store septets as 8-bit PDU data
 *
 *  The translation is like:
 *  septets bits for A, B, C..    B0 A6 A5 A4 A3 A2 A1 A0 C1 C0 B6 B5 B4 B3 B2 B1 D2 D1 D0 C6 C5 C4 C3 C2
 *  output octets                 .  .  .  .  .  .  .  . |.  .  .  .  .  .  .  . |.  .  .  .  .  .  .  .
 *
 *  @param    bit     bit value (1/0) to store
 *  @param    mode    flag to reset,  feed or flush the encoding part
 *  @param    buf     room to store PDU encoded stuff
 *
 *  @return Nothing.
 */
static void pdu_encode_bit(unsigned char bit,  BIT_ENCODER_MODE mode,  char * buf)
{
    static unsigned char kept = 0;
    static unsigned char bits = 8;
    unsigned char mask;

    if (mode == FEED_BIT_ENCODER)
    {
        if (bits == 0)
        {
            pdu_add_hex(buf, kept, SMS_MSG_SIZE);
            kept = 0;
            bits = 8;
        }

        mask = 0x80;  // fill highest bit
        kept = (kept >> 1) | (bit*mask);
        bits--;
    }
    else
    {
        // when invoked in flush mode,  output the pending byte
        if (mode == FLUSH_BIT_ENCODER)
        {
            kept = kept >> bits;
            pdu_add_hex(buf, kept, SMS_MSG_SIZE);
        }
        kept = 0;
        bits = 8;
    }
}


/**
 *  @brief    Bitwise encode the septet in PDU buffer
 *
 *  @param    b      byte (septet) to encode
 *  @param    buf    room to store encoded result
 *
 *  @return Nothing.
 */
static void pdu_encode_byte(unsigned char b,  char * buf)
{
    pdu_encode_bit((unsigned char)((b &  1))     , FEED_BIT_ENCODER,  buf);
    pdu_encode_bit((unsigned char)((b &  2) >> 1), FEED_BIT_ENCODER,  buf);
    pdu_encode_bit((unsigned char)((b &  4) >> 2), FEED_BIT_ENCODER,  buf);
    pdu_encode_bit((unsigned char)((b &  8) >> 3), FEED_BIT_ENCODER,  buf);
    pdu_encode_bit((unsigned char)((b & 16) >> 4), FEED_BIT_ENCODER,  buf);
    pdu_encode_bit((unsigned char)((b & 32) >> 5), FEED_BIT_ENCODER,  buf);
    pdu_encode_bit((unsigned char)((b & 64) >> 6), FEED_BIT_ENCODER,  buf);
}


/**
 *  @brief Convert an integer into a twobyte hex string eg. 26 becomes "1A"
 *
 *  @param   value      integer to be converted into a hex string
 *  @param   result     the resulting string
 *
 * @return Nothing.
 */
static void pdu_int_to_hexstr(int value, char * result)
{
    const char hex_table[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
    result[0] = hex_table[value / 16];
    result[1] = hex_table[value % 16];
    result[2] = 0;
}


/**
 *  @brief Convert an international phone number to the PDU format
 *
 *  The PDU formatted number is "length of phonenumber|91|phonenumber|F"
 *
 *  @param    normal_nr     normal notation int. phone nr.
 *  @param    encoded_nr    PDU formatted phone nr.
 *
 *  @return Nothing.
 */
static void pdu_encode_nr(char * normal_nr, char * encoded_nr)
{
    unsigned int i;
    unsigned int length = strlen(normal_nr);

    // set the length and nr-format to international
    pdu_int_to_hexstr(length, encoded_nr);
    strcat (encoded_nr, "91");
    strcat (encoded_nr, normal_nr);

    if (length % 2)
        length++;
    /* swap characters on odd and even indexes */
    for (i = 0; i < length; i++)
    {
        if ((i % 2) == 0)
        {
            if (i < (length - 2))
            {
               encoded_nr[i + 4] = normal_nr[i + 1];
            }
            else
            {
                encoded_nr[i + 4] = 'F'; /* padding F */
            }
        }
        else
        {
            encoded_nr[i + 4] = normal_nr[i - 1];
        }
        encoded_nr[i + 4 + 1] = 0; /* terminate string... */
    }
}


/**
 *  @brief Encodes a message according to the PDU message format
 *
 *  @param    message     message to PDU-encode
 *  @param    dest_nr     international format phone nr. eg. "31632145678"
 *  @param    pdu         room to store the encoded result
 *
 *  @return Nothing.
 */
void sms_pdu_encode(const char * message, char * dest_nr, char * pdu)
{
    int i;
    int ret = 0;
    char encoded_nr[SMALL_SIZE] = "";
    char * pdu_bgn;

    strcpy(pdu, "001100");
    //           ^^      SMSC length 00
    //             ^^    SMS submit first octet 11 (valifity present,  PDU format...)
    //               ^^  message reference 00 (let phone decide)
    pdu_encode_nr(dest_nr, encoded_nr);
    strcat(pdu, encoded_nr);
    strcat(pdu, "0000AA");
    //           ^^      protocol id.
    //             ^^    data coding 7-bits
    //               ^^  4 day validity

    pdu_bgn = pdu + strlen(pdu);
    pdu_encode_bit(0, RESET_BIT_ENCODER, pdu_bgn);
    pdu_int_to_hexstr(strlen(message), pdu_bgn);
    for (i=0; i < strlen(message); i++)
    {
        pdu_encode_byte(message[i], pdu_bgn);
    }
    // flush bit encoder
    pdu_encode_bit(0, FLUSH_BIT_ENCODER, pdu_bgn);
    // add CTRL-Z
    strcat(pdu_bgn, "\x1A");
}

/**
 *  @brief Converts the timestamp of an initialized smsg_t structure to a string of the format dd-mm-yy hh:mm:ss
 *
 *  @param    msg         message containing the timestamp to convert
 *  @param    buf         a character buffer in which to place the resulting string
 *  @param    len         the length of buf
 *
 *  @return   buf
 */
char * sms_pdu_timestamp_to_string(smsg_t * msg, char * buf, size_t len)
{
    assert(msg);

    snprintf(buf,len,"%02x-%02x-%02x %02x:%02x:%02x",
                      msg->timestamp[2],
                      msg->timestamp[1],
                      msg->timestamp[0],
                      msg->timestamp[3],
                      msg->timestamp[4],
                      msg->timestamp[5]);
    return buf;
}

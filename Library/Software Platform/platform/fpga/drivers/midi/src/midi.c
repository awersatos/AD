/*****************************************************************************
|*
|*  Copyright:      Copyright (c) 2009, Altium
|*
|*  Description:    MIDI serial communications drv.
|*
\*****************************************************************************/

/**
 * @file
 * Driver for WB_MIDI peripheral.
 *
 * The driver can either use the UART core buffer, or it can use an additional, interrupt
 * controlled software buffer.
 *
 * You can configure these buffer settings independently for receive and transmit.
 *
 * For a detailed description of the WB_MIDI peripheral, see the Core Reference
 * <a href="CR0157 WB_MIDI Serial Communications Port.PDF">CR0157 WB_MIDI Serial Communications Port</a>
 */

 

#include <timing.h>
#if ( __POSIX_KERNEL__ != 0 )
# include <pthread.h>
#else
#include <time.h>
#endif

#include <stdio.h>

#include <stdint.h>
#include <stdbool.h>
#include <errno.h>
#include <assert.h>
#include <string.h>  // for memcpy
#include <fcntl.h>
#include <midi.h>

#include "midi_cfg_instance.h"

 
#include <assert.h>
#include <timing.h>
#include <interrupts.h>

#if __POSIX_KERNEL__
# include <pthread.h>
#endif

#include <sysutils.h>

#include <per_uart8.h>
#include <midi.h>
#include "midi_cfg_instance.h"


// runtime driver table
static midi_t midi_driver_table[MIDI_INSTANCE_COUNT];

struct midi_s
{
    midi_msg_t              *first;         // first received message
    midi_msg_t              *last;          // last received message
    void (*rxmsg)(uint8_t, uint8_t, uint8_t, uint8_t);       // user function called when midi message received
    uintptr_t               baseaddress;
    uint8_t                 rx_interrupt;
    int                     rxintmode;      // driver is operated in rx interrupt mode
    uint8_t                 rxbusy;         // busy receiving midi message
    uint8_t                 channel;        // channel we're interested in
    int                     capture;        // capture messages if true
};

static midi_msg_t *rx_handler_common(midi_t * restrict midi, int capture, midi_msg_t *prev_msg)
{
    static uint64_t since_us;
    midi_msg_t *msg = NULL;
    static int count;
    static uint8_t status;
    static uint8_t prev_byte;
    uint8_t eventid;
    uint8_t channel;
    uint8_t byte;

    while (UART8_STATUS(midi->baseaddress) & UART8_STATUS_RXNEMPTY)
    {
        byte = (uint8_t)(UART8_SBUF(midi->baseaddress) & 0xFF);
        if(capture || count) // stop capturing after finishing the current message
        {
            if (byte & STATUS_MASK)  // is it a statusbyte?
            {   // it's a statusbyte
                status = byte;
                count = 0;
                switch (status & EVENT_MASK)  // ignore channel#
                {
                /* These events take 2 bytes as arguments */
                case MIDI_NOTE_OFF:
                case MIDI_NOTE_ON:
                case MIDI_KEY_PRESSURE:
                case MIDI_CONTROL_CHANGE:
                case MIDI_PITCH_BEND:
                    count = 2;
                    midi->rxbusy = 1;
                    break;
                /* 1 byte arguments */
                case MIDI_PROGRAM_CHANGE:
                case MIDI_CHANNEL_PRESSURE:
                    count = 1;
                    midi->rxbusy = 1;
                    break;
                case MIDI_SYSTEMF0:
                /* we donot handle system messages for the moment */
                default: ;
                }
            } else
            {   // it's a databyte
                if(count)
                    count--;
                if (count == 0)
                {
                    eventid = status & EVENT_MASK;
                    channel = (status & CHANNEL_MASK) + 1;

                    /* See if this event matches our MIDI channel, (0 = we accept all msgs) */
                    if (eventid < MIDI_SYSTEMF0 && (!midi->channel || (channel == midi->channel)))
                    {
                        msg = midi_createvoicemsg(prev_msg, elapsed_time_us(since_us), eventid, channel, prev_byte, byte);
                        since_us = clock_us();
                        if (midi->rxmsg && midi->rxintmode)
                            midi->rxmsg(eventid, channel, prev_byte, byte);
                    }
                    midi->rxbusy = 0;
                }
                prev_byte = byte;
            }
        }
    }
    return msg;
}

// native interrupt wrapper
__INTERRUPT_NATIVE void rx_handler_native(void)
{
    int num = interrupt_get_current();
    midi_t * restrict midi = (midi_t*) interrupt_native_context(num);
    midi_msg_t *msg = NULL;

    interrupt_acknowledge(num);
    msg = rx_handler_common(midi, midi->capture, midi->last);
    if (msg)
    {
        midi->last = msg;
        if (!midi->first)
            midi->first = msg;
    }
}

static void midi_putchar(midi_t * restrict midi, int val)
{
    assert(midi != NULL);
    assert((val >= 0) && (val <= 0xFF));

    while(UART8_STATUS(midi->baseaddress) & UART8_STATUS_TXFULL);
    UART8_SBUF(midi->baseaddress) = val & 0xFF;
}


/**
 * @brief Set a new uart baudrate
 *
 * The baudrate changes instantly and will invalidate any character
 * that is currently being received or transmitted over the line.
 *
 * @param       midi       midi driver pointer
 * @param       baudrate  new baudrate
 *
 * @return Nothing.
 */
static void midi_set_baudrate(midi_t * restrict midi, uint32_t baudrate)
{
    assert(midi != NULL);
    assert(baudrate != 0);
    uint32_t clk = freq_hz();
    uint32_t brg = (uint32_t)((baudrate * 0x8000000ULL) / clk);

    UART8_BRGLOW(midi->baseaddress)  = brg & 0xFF;
    brg >>= 8;
    UART8_BRGMID(midi->baseaddress)  = brg & 0xFF;
    brg >>= 8;
    UART8_BRGHIGH(midi->baseaddress) = brg & 0xFF;
}

/**
 * @brief Open an instance of the driver
 *
 * This function initializes both a MIDI core and its driver.
 * You should call it only once per id.
 *
 * @param      id    valid driver id
 *
 * @return Driver pointer if succesful initialization, NULL otherwise.
 */
midi_t *midi_open(int id)
{
    assert((id >= 0) && (id < MIDI_INSTANCE_COUNT));
    midi_t * restrict midi = &midi_driver_table[id];
    if (midi->baseaddress == 0)
    {
        // get configuration of driver (created by plugin system)
        const midi_cfg_instance_t * restrict midi_cfg = &midi_instance_table[id];
        // get configuration peripheral below driver (created by plugin system)
        const per_midi_cfg_instance_t * restrict per_midi_cfg = &per_midi_instance_table[midi_cfg->per_midi];
        const per_uart8_cfg_instance_t * restrict per_uart8_cfg = &per_uart8_instance_table[per_midi_cfg->per_uart8];

        // copy all configuration needed to driver
        midi->channel          = midi_cfg->channel;
        midi->rxintmode        = midi_cfg->rxintmode;
        midi->capture          = 0;
        midi->rxmsg            = NULL;
        midi->first            = NULL;
        midi->last             = NULL;

        assert(per_uart8_cfg->baseaddress != 0);
        midi->baseaddress      = per_uart8_cfg->baseaddress;
        midi->rx_interrupt     = per_uart8_cfg->rx_interrupt;

        // set up hardware based on configuration
        UART8_RXLOWMARK(midi->baseaddress) = 14;
        UART8_RXHIGHMARK(midi->baseaddress) = 14;
    //    UART8_RXDTO(drv->baseaddress)      = 255;
        UART8_ICD(midi->baseaddress) = 0;                       // Set inter-character delay to 0 bits

        midi_set_baudrate(midi, 31250);

        // Midi doesn't do handshaking
        UART8_LCR(midi->baseaddress) = 0;

        // disable all interrupts
        UART8_INTMASK_RST(midi->baseaddress) = 0xFF;

        if (midi->rxintmode)
        {
            interrupt_register_native(midi->rx_interrupt, (void*) midi, rx_handler_native);
            interrupt_configure(midi->rx_interrupt, LEVEL_HIGH);
            interrupt_acknowledge(midi->rx_interrupt);
            interrupt_enable(midi->rx_interrupt);
            UART8_INTMASK_SET(midi->baseaddress) = UART8_STATUS_RXNEMPTY;
        }
    }
    return midi;
}

/**
 * @brief Register user function to call on midi message received
 *
 * This function will be called when a midi voice message is captured and
 * the driver is operated in rx interrupt mode. In this mode do not forget
 * to turn midi_capture on. Only register simple functions because it's called
 * on an interrupt!
 *
 * @see midi_capture
 *
 * @param midi     pointer to midi device struct
 * @param rxmsg    The user function
 *
 * @return Nothing.
 */
void midi_regrxmsg(midi_t *midi, void (*rxmsg)(uint8_t, uint8_t, uint8_t, uint8_t))
{
    midi->rxmsg = rxmsg;
}

static void midi_txvoicemsg(midi_t *midi, uint8_t eventid, uint8_t channel, uint8_t dbyte1, uint8_t dbyte2)
{
    uint8_t status = eventid + channel - 1;

    midi_putchar(midi, status);
    midi_putchar(midi, dbyte1);
    if ((eventid != MIDI_PROGRAM_CHANGE) && (eventid != MIDI_CHANNEL_PRESSURE))
        midi_putchar(midi, dbyte2);
}

static void midi_txsystemmsg(midi_t *midi, uint8_t eventid, uint32_t length, uint8_t *data)
{
    midi_putchar(midi, eventid);
    for (int i = 0; i << length; i++)
        midi_putchar(midi, data[i]);
}

/**
 * @brief transmit one MIDI message to the MIDI out port
 *
 * @param midi     pointer to midi device struct
 * @param msg      pointer to the midi message to transmit
 *
 * @return Nothing.
 */
void midi_txmsg(midi_t *midi, midi_msg_t *msg)
{
    uint8_t dbyte1 = 0, dbyte2 = 0;

    switch (msg->eventid)
    {
    case MIDI_NOTE_OFF:
        dbyte1 = msg->event.note_off.note;
        dbyte2 = msg->event.note_off.velocity;
        break;
    case MIDI_NOTE_ON:
        dbyte1 = msg->event.note_on.note;
        dbyte2 = msg->event.note_on.velocity;
        break;
    case MIDI_KEY_PRESSURE:
        dbyte1 = msg->event.key_pressure.note;
        dbyte2 = msg->event.key_pressure.amount;
        break;
    case MIDI_CONTROL_CHANGE:
        dbyte1 = msg->event.control_change.number;
        dbyte2 = msg->event.control_change.value;
        break;
    case MIDI_PROGRAM_CHANGE:
        dbyte1 = msg->event.program_change.number;
        dbyte2 = 0;
        break;
    case MIDI_CHANNEL_PRESSURE:
        dbyte1 = msg->event.channel_pressure.amount;
        dbyte2 = 0;
        break;
    case MIDI_PITCH_BEND:
        dbyte1 = msg->event.pitch_bend.value & 0x7f;
        dbyte2 = (dbyte1 >> 7) & 0x7f;
        break;
    case MIDI_SYSTEMF0:
    case MIDI_SYSTEMF7:
        midi_txsystemmsg(midi, msg->eventid, msg->event.sysex.length, msg->event.sysex.data);
        break;
    default: return; // donot sent other (eg SMF Meta) messages
    }
    if (msg->eventid < MIDI_SYSTEMF0)
        midi_txvoicemsg(midi, msg->eventid, msg->channel, dbyte1, dbyte2);
}


/**
 * @brief play/transmit a complete (captured) message list
 *
 * @param midi     pointer to midi device struct
 *
 * @return Nothing.
 */
void midi_play(midi_t *midi)
{
    for(midi_msg_t *msg = midi->first; msg; msg = msg->next)
    {
        midi_txmsg(midi, msg);
        delay_us(msg->delta);
    }
}

/**
 * @brief Read the midi port for midi messages
 *
 * Creates a midi message from received midi data. in capture mode
 * the message is also added to the linked list of midi messages
 * which is avaliable through the midi_get*msg() set of functions.
 *
 * @see midi_capture
 *
 * @param midi     pointer to midi device struct
 *
 * @return message received or NULL when none available.
 */
midi_msg_t *midi_rxmsg(midi_t *midi)
{
    midi_msg_t *msg = NULL;

    if (midi->capture)
        msg = rx_handler_common(midi, 1, midi->last);
    else
        msg = rx_handler_common(midi, 1, NULL);
    if (!msg  && midi->capture)
    {
        midi->last = msg;
        if (!midi->first)
            midi->first = msg;
    }
    return msg;
}

/**
 * @brief Set message capturing on or off
 *
 * When this setting is turned on messages will be captured in a linked
 * list available using the midi_getmsg* functions. The list can be flushed
 * using midi-flushmsglist
 *
 * @see midi_flushmsglist
 *
 * @param midi     pointer to midi device struct
 * @param onoff    0 = off, on otherwise
 *
 * @return Nothing
 */
void midi_capture(midi_t *midi, int onoff)
{
    volatile int rxbusy = midi->rxbusy;
    midi->capture = onoff;
    
    if (midi->rxintmode)
    {
        if (onoff)
        {
            interrupt_enable(midi->rx_interrupt);
        } else
        {
            while (rxbusy);  // tricky
            interrupt_disable(midi->rx_interrupt);
        }
    }
}

/**
 * @brief Flush list of midi messages
 *
 * This function deletes a list of midi messages from memory.
 * It deletes every message until the last (msg->next == NULL).
 *
 * @param msg    message to start from deleting
 *
 * @return Nothing.
 */
void midi_flushmsgs(midi_msg_t *msg)
{
    midi_msg_t *nextmsg;

    while (msg != NULL)
    {
        nextmsg = msg->next;
        free(msg);
        msg = nextmsg;
    }
}

/**
 * @brief Get first received midi message
 *
 * This function returns the first in a list of captured midi messages.
 *
 * @see midi_capture
 *
 * @param midi     pointer to midi device struct
 *
 * @return Pointer to the first received midi message.
 */
midi_msg_t *midi_getfirstmsg(midi_t *midi)
{
    return midi->first;
}

/**
 * @brief Get last received midi message
 *
 * This function returns the last in a list of captured midi messages.
 *
 * @see midi_capture
 *
 * @param midi     pointer to midi device struct
 *
 * @return Pointer to the last received midi message.
 */
midi_msg_t *midi_getlastmsg(midi_t *midi)
{
    return midi->last;
}

/**
 * @brief Get previous received midi message
 *
 * This function returns the previous captured midi messages.
 *
 * @see midi_capture
 *
 * @param midi    pointer to midi device struct
 * @param msg     The previous message is taken relative to this message
 *
 * @return Pointer to the previous midi message.
 */
midi_msg_t *midi_getprevmsg(midi_t *midi, midi_msg_t *msg)
{
    return msg->prev;
}

/**
 * @brief Get next received midi message
 *
 * This function returns the next captured midi messages.
 *
 * @see midi_capture
 *
 * @param midi    pointer to midi device struct
 * @param msg     The next message is taken relative to this message
 *
 * @return Pointer to the next midi message.
 */
midi_msg_t *midi_getnextmsg(midi_t *midi, midi_msg_t *msg)
{
    return msg->prev;
}

/**
 * @brief Creates a MIDI voice message struct
 *
 * @param prev_msg pointer to previous message
 * @param delta    delta timestamp of message in usecs
 * @param eventid  event type
 * @param channel  message channel
 * @param dbyte1   data byte 1
 * @param dbyte2   data byte 2
 *
 * @return Pointer to the created message struct.
 */
midi_msg_t *midi_createvoicemsg(midi_msg_t *prev_msg, uint64_t delta, uint8_t eventid, uint8_t channel, uint8_t dbyte1, uint8_t dbyte2)
{
    midi_msg_t *msg = malloc(sizeof(midi_msg_t));

    if (prev_msg)
    {
        prev_msg->next = msg;
        prev_msg->delta = delta;
    }
    if (msg)
    {
        msg->next = NULL;
        msg->prev = prev_msg;
        msg->delta = 0;
        msg->eventid = eventid;
        msg->channel = channel;
        switch (eventid)
        {
            case MIDI_NOTE_OFF:
                msg->event.note_off.note = dbyte1;
                msg->event.note_off.velocity = dbyte2;
                break;
            case MIDI_NOTE_ON:
                msg->event.note_on.note = dbyte1;
                msg->event.note_on.velocity = dbyte2;
                break;
            case MIDI_KEY_PRESSURE:
                msg->event.key_pressure.note = dbyte1;
                msg->event.key_pressure.amount = dbyte2;
                break;
            case MIDI_CONTROL_CHANGE:
                msg->event.control_change.number = dbyte1;
                msg->event.control_change.value = dbyte2;
                break;
            case MIDI_PROGRAM_CHANGE:
                msg->event.program_change.number = dbyte2;
                break;
            case MIDI_CHANNEL_PRESSURE:
                msg->event.channel_pressure.amount = dbyte2;
                break;
            case MIDI_PITCH_BEND:
                msg->event.pitch_bend.value = (dbyte2 << 7) | dbyte1;
                break;
            default:
                free(msg);
        }
    }
    return msg;
}

/**
 * @brief Creates a MIDI system message struct
 *
 * @param prev_msg pointer to previous message
 * @param delta    delta timestamp of message in usecs
 * @param eventid  event type
 * @param length   message length in bytes
 * @param data     message data
 *
 * @return Pointer to the created message struct.
 */
midi_msg_t *midi_createsystemmsg(midi_msg_t *prev_msg, uint64_t delta, uint8_t eventid, uint32_t length, void *data)
{
    midi_msg_t *msg = malloc(sizeof(midi_msg_t));

    if (prev_msg)
    {
        prev_msg->next = msg;
        prev_msg->delta = delta;
    }   
    if (msg)
    {
        msg->next = NULL;
        msg->prev = prev_msg;
        msg->delta = 0;
        msg->eventid = eventid;
        msg->channel = 0;  // not relevant
        msg->event.sysex.length = length;
        msg->event.sysex.data = malloc(length);
        memcpy(msg->event.sysex.data, data, length);
    }
    return msg;
}

/**
 * @brief Get delta timestamp from message
 *
 * Delta represents the number of usecs between this message and the next
 *
 * @param msg     pointer to the midi message
 *
 * @return The timestamp, -1 when message == NULL.
 */
uint64_t midi_getdelta(midi_msg_t *msg)
{
    if (msg)
        return msg->delta;
    else
        return -1;
}

/**
 * @brief Set delta timestamp of message
 *
 * @param msg     pointer to the midi message
 * @param delta   delta timestamp of message
 *
 * @return Nothing.
 */
void midi_setdelta(midi_msg_t *msg, uint64_t delta)
{
    if (msg != NULL)
        msg->delta = delta;
}


/**
 * @brief Get channel of MIDI message
 *
 * @param msg     pointer to the midi message
 *
 * @return The channel, -1 when message == NULL.
 */
uint8_t midi_getchannel(midi_msg_t *msg)
{
    if (msg)
        return msg->channel;
    else
        return -1;
}


/**
 * @brief Set channel of MIDI message
 *
 * @param msg     pointer to the midi message
 * @param channel the channel
 *
 * @return Nothing
 */
void midi_setchannel(midi_msg_t *msg, uint8_t channel)
{
    if (msg != NULL)
        msg->channel = channel;
}


/**
 * @brief Get note of MIDI message
 *
 * @param msg     pointer to the midi message
 *
 * @return The note, -1 when not Note on/off
 */
uint8_t midi_getnote(midi_msg_t *msg)
{
    uint8_t ret = -1;
    if (msg)
    {
        switch (msg->eventid)
        {
            case MIDI_NOTE_ON:
                ret = msg->event.note_on.note;
                break;
            case MIDI_NOTE_OFF:
                ret = msg->event.note_off.note;
                break;
            default:
                ret = -1;
        }
    }
    return ret;
}

/**
 * @brief Set note of MIDI message
 *
 * @param msg     pointer to the midi message
 * @param note    the note
 *
 * @return Nothing.
 */
void midi_setnote(midi_msg_t *msg, uint8_t note)
{
    if (msg)
    {
        switch (msg->eventid)
        {
            case MIDI_NOTE_ON:
                msg->event.note_on.note = note;
                break;
            case MIDI_NOTE_OFF:
                msg->event.note_off.note = note;
                break;
            default:; // nothing
        }
    }
}

/**
 * @brief Get velocity of MIDI message
 *
 * @param msg     pointer to the midi message
 *
 * @return The velocity, -1 when not Note on/off.
 */
uint8_t midi_getvelocity(midi_msg_t *msg)
{
    uint8_t ret = -1;

    if (msg)
    {
        switch (msg->eventid)
        {
            case MIDI_NOTE_ON:
                ret = msg->event.note_on.velocity;
                break;
            case MIDI_NOTE_OFF:
                ret = msg->event.note_off.velocity;
                break;
            default:
                ret = -1;
        }
    }
    return ret;
}

/**
 * @brief Set velocity of MIDI message
 *
 * @param msg      pointer to the midi message
 * @param velocity the velocity
 *
 * @return Nothing.
 */
void midi_setvelocity(midi_msg_t *msg, uint8_t velocity)
{
    if (msg)
    {
        switch (msg->eventid)
        {
            case MIDI_NOTE_ON:
                msg->event.note_on.velocity = velocity;
                break;
            case MIDI_NOTE_OFF:
                msg->event.note_off.velocity = velocity;
                break;
            default: ; // nothing
        }
    }
}

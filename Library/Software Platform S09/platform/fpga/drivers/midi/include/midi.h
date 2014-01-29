/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2009, Altium
|*
|*  Description:        MIDI driver
|*
\*****************************************************************************/

#ifndef _DRV_MIDI_H
#define _DRV_MIDI_H

#ifdef  __cplusplus
extern "C" {
#endif

// MIDI Message Types
#define MIDI_NOTE_OFF           0x80
#define MIDI_NOTE_ON            0x90
#define MIDI_KEY_PRESSURE       0xA0
#define MIDI_CONTROL_CHANGE     0xB0
#define MIDI_PROGRAM_CHANGE     0xC0
#define MIDI_CHANNEL_PRESSURE   0xD0
#define MIDI_PITCH_BEND         0xE0
#define MIDI_SYSTEMF0           0xF0
#define MIDI_SYSTEMF7           0xF7

// System Common messages
#define MIDI_START_SYSTEM       0xF0
#define MIDI_MTC_QUARTERFRAME   0xF1
#define MIDI_SONG_POSITION      0xF2
#define MIDI_SONG_SELECT        0xF3
#define MIDI_TUNE_REQUEST       0xF6
#define MIDI_END_SYSTEM         0xF7

// System Real Time messages
#define MIDI_SYNC               0xF8
#define MIDI_START              0xFA
#define MIDI_CONTINUE           0xFB
#define MIDI_STOP               0xFC
#define MIDI_ACTIVE_SENSE       0xFE
#define MIDI_RESET              0xFF

// Meta messages
#define MIDI_ENDOFTRACK         0x2F

#define STATUS_MASK             0x80
#define EVENT_MASK              0xF0
#define CHANNEL_MASK            0x0F

/*
 * Data Types
 */
typedef struct midi_s midi_t;

typedef struct
{
    uint8_t note;
    uint8_t velocity;
} note_off_t;

typedef struct
{
    uint8_t note;
    uint8_t velocity;
} note_on_t;

typedef struct
{
    uint8_t note;
    uint8_t amount;
} key_pressure_t;

typedef struct
{
    uint8_t number;
    uint8_t value;
} control_change_t;

typedef struct
{
    uint8_t number;
} program_change_t;

typedef struct
{
    uint8_t amount;
} channel_pressure_t;

typedef struct
{
    int value;
} pitch_bend_t;

typedef struct
{
    uint32_t length;
    unsigned char *data;
} sysex_t;

typedef struct
{
    uint8_t number;
    uint32_t length;
    unsigned char *data;
} meta_t;


typedef struct midi_msg_s midi_msg_t;

struct midi_msg_s
{
    midi_msg_t              *prev;
    midi_msg_t              *next;
    uint8_t                 eventid;
    uint8_t                 channel;
    uint64_t                delta;  // usecs between this and the next message
    union
    {
        note_off_t          note_off;
        note_on_t           note_on;
        key_pressure_t      key_pressure;
        control_change_t    control_change;
        program_change_t    program_change;
        channel_pressure_t  channel_pressure;
        pitch_bend_t        pitch_bend;
        sysex_t             sysex;
        meta_t              meta;
    } event;
};

extern midi_t *midi_open(int id);
extern void midi_regrxmsg(midi_t *midi, void (*rxmsg)(uint8_t, uint8_t, uint8_t, uint8_t));
extern void midi_txmsg(midi_t *midi, midi_msg_t *msg);
extern void midi_play(midi_t *midi);
extern midi_msg_t *midi_rxmsg(midi_t *midi);

extern void midi_capture(midi_t *midi, int onoff);
extern void midi_flushmsglist(midi_t *midi);
extern midi_msg_t *midi_getfirstmsg(midi_t *midi);
extern midi_msg_t *midi_getlastmsg(midi_t *midi);
extern midi_msg_t *midi_getprevmsg(midi_t *midi, midi_msg_t *msg);
extern midi_msg_t *midi_getnextmsg(midi_t *midi, midi_msg_t *msg);

extern midi_msg_t *midi_createvoicemsg(midi_msg_t *prev_msg, uint64_t delta, uint8_t eventid, uint8_t channel, uint8_t dbyte1, uint8_t dbyte2);
extern midi_msg_t *midi_createsystemmsg(midi_msg_t *prev_msg, uint64_t delta, uint8_t eventid, uint32_t length, void *data);

extern uint64_t midi_getdelta(midi_msg_t *msg);
extern void midi_setdelta(midi_msg_t *msg, uint64_t delta);
extern uint8_t midi_getchannel(midi_msg_t *msg);
extern void midi_setchannel(midi_msg_t *msg, uint8_t channel);
extern uint8_t midi_getnote(midi_msg_t *msg);
extern void midi_setnote(midi_msg_t *msg, uint8_t note);
extern uint8_t midi_getvelocity(midi_msg_t *msg);
extern void midi_setvelocity(midi_msg_t *msg, uint8_t velocity);

#endif /* _DRV_MIDI_H */


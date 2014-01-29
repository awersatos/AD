/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007, Altium
|*
|*  Description:        TVP5150 specific I/O interface.
|*
\*****************************************************************************/

#ifndef _DRV_TVP5150_H
#define _DRV_TVP5150_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>

//..............................................................................
// TVP5150 registers

#define TVP5150_VIDEO_INPUT             0x00
#define TVP5150_ANALOG_CHANNEL          0x01
#define TVP5150_OPERATION_MODE          0x02
#define TVP5150_MISC                    0x03
#define TVP5150_AUTOSWITCH              0x04
#define TVP5150_SOFTWARE_RESET          0x05
#define TVP5150_COLOR_KILLER_THRESHOLD  0x06
#define TVP5150_LUMINANCE_1             0x07
#define TVP5150_LUMINANCE_2             0x08
#define TVP5150_BRIGHTNESS              0x09
#define TVP5150_COLOR_SATURATION        0x0A
#define TVP5150_HUE                     0x0B
#define TVP5150_CONTRAST                0x0C
#define TVP5150_FORMAT_AND_RATES        0x0D
#define TVP5150_LUMINANCE_3             0x0E
#define TVP5150_SHARED_PINS             0x0F
// Reserved                             0x10
#define TVP5150_AVID_CROP_START_MSB     0x11
#define TVP5150_AVID_CROP_START_LSB     0x12
#define TVP5150_AVID_CROP_STOP_MSB      0x13
#define TVP5150_AVID_CROP_STOP_LSB      0x14
#define TVP5150_GENCLOCK_RTC            0x15
#define TVP5150_HSYNC_START             0x16
// Reserved                             0x17
#define TVP5150_VBLANK_START            0x18
#define TVP5150_VBLANK_STOP             0x19
#define TVP5150_CHROMINANCE_1           0x1A
#define TVP5150_CHROMINANCE_2           0x1B
#define TVP5150_INTERRUPT_RESET_B       0x1C
#define TVP5150_INTERRUPT_ENABLE_B      0x1D
#define TVP5150_INTERRUPT_CONF_B        0x1E
// Reserved                             0x1F-0x27
#define TVP5150_VIDEO_STANDARD          0x28
// Reserved                             0x29-0x7F
#define TVP5150_DEVICE_ID_MSB           0x80
#define TVP5150_DEVICE_ID_LSB           0x81
#define TVP5150_ROM_VERSION             0x82
#define TVP5150_RAM_PATCH_VERSION       0x83
#define TVP5150_VLINE_COUNT_MSB         0x84
#define TVP5150_VLINE_COUNT_LSB         0x85
#define TVP5150_INTERRUPT_STATUS_B      0x86
#define TVP5150_INTERRUPT_ACTIVE_B      0x87
#define TVP5150_STATUS_REG_1            0x88
#define TVP5150_STATUS_REG_2            0x89
#define TVP5150_STATUS_REG_3            0x8A
#define TVP5150_STATUS_REG_4            0x8B
#define TVP5150_STATUS_REG_5            0x8C
// Reserved                             0x8D-0x8F
#define TVP5150_CAPTION_DATA            0x90
// Closed caption data registers        0x90-0x93
#define TVP5150_WSS_DATA                0x94
// Wss data registers                   0x94-0x99
#define TVP5150_VPS_DATA                0x9A
// VPS data registers                   0x9A-0xA6
#define TVP5150_VITC_DATA               0xA7
// VITC data registers                  0xA7-0xAF
#define TVP5150_VBI_FIFO_DATA           0xB0
#define TVP5150_TELETEXT_FILTER_1       0xB1
// Teletext filter 1                    0xB1-0xB5
#define TVP5150_TELETEXT_FILTER_2       0xB6
// Teletext filter 2                    0xB6-0xBA
#define TVP5150_TELETEXT_FILTER_ENABLE  0xBB
// Reserved                             0xBC-0xBF
#define TVP5150_INTERRUPT_STATUS_A      0xC0
#define TVP5150_INTERRUPT_ENABLE_A      0xC1
#define TVP5150_INTERRUPT_CONF_A        0xC2
#define TVP5150_VDP_CONF_RAM_DATA       0xC3
#define TVP5150_CONF_RAM_ADDR_LOW       0xC4
#define TVP5150_CONF_RAM_ADDR_HIGH      0xC5
#define TVP5150_VDP_STATUS              0xC6
#define TVP5150_FIFO_WORD_COUNT         0xC7
#define TVP5150_FIFO_INTR_THRESHOLD     0xC8
#define TVP5150_RESET                   0xC9
#define TVP5150_LINE_NUMBER_INTERRUPT   0xCA
#define TVP5150_PIXEL_ALIGNMENT_LOW     0xCB
#define TVP5150_PIXEL_ALIGNMENT_HIGH    0xCC
#define TVP5150_FIFO_OUTPUT_CTRL        0xCD
#define TVP5150_AUTO_INIT               0xCE
#define TVP5150_FULL_FIELD_ENABLE       0XCF
#define TVP5150_LINE_MODE               0xD0
// Line mode registers                  0xD0-0xFB
#define TVP5150_FULL_FIELD_MODE         0xFC
// Reserved                             0xFD-0xFF

//..............................................................................
// Nanoboard defaults

#define TVP5150_NB_FORMAT_AND_RATES     0x27
#define TVP5150_NB_SHARED_PINS          0x02
#define TVP5150_NB_MISC                 0xAF

//..............................................................................
// Slave address on the I2C bus

#define TVP5150_NB_ADDRESS              0xB8

//..............................................................................
// Video modes

#define TVP5150_COMP1                   0
#define TVP5150_S_VIDEO                 1
#define TVP5150_COMP2                   2

//..............................................................................
// Public interface

typedef struct tvp5150_s tvp5150_t;

extern tvp5150_t *tvp5150_open( unsigned int id );

// Convenience functions

extern int tvp5150_set_crop( tvp5150_t * restrict tvp5150, uint16_t x1, uint16_t y1, uint16_t x2,
                             uint16_t y2 );

// Low level access

extern int tvp5150_set_register( tvp5150_t * restrict tvp5150, uint8_t reg, uint8_t value );

extern int tvp5150_get_register( tvp5150_t * restrict tvp5150, uint8_t reg );

#ifdef  __cplusplus
}
#endif

#endif /* _DRV_TVP5150_H */

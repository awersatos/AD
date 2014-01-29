/** @file
 * Interface to SPI control port of CS4270 stereo audio CODEC
 */

#ifndef _DRV_CS4270_H
#define _DRV_CS4270_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stddef.h>

/**
 * @name Error codes
 */

/** @{ */
#define CS4270_ERR_OK           0       /**<  No error                              */
#define CS4270_ERR_SPI          -1      /**<  Could not get control over SPI bus    */
/** @} */

/**
 * @name Register map
 */
/** @{ */
#define CS4270_REG_CHIP_ID              0x01    /**< Chip ID                        */
#define CS4270_REG_POWER_CONTROL        0x02    /**< Power Control                  */
#define CS4270_REG_FUNCTION_MODE        0x03    /**< Mode Control                   */
#define CS4270_REG_SERIAL_AUDIO_FORMAT  0x04    /**< ADC and DAC Control            */
#define CS4270_REG_TRANSITION_CONTROL   0x05    /**< Transition Control             */
#define CS4270_REG_MUTE_CONTROL         0x06    /**< Mute Control                   */
#define CS4270_REG_VOL_CONTROL_AOUTA    0x07    /**< DAC Channel A Volume Control   */
#define CS4270_REG_VOL_CONTROL_AOUTB    0x08    /**< DAC Channel B Volume Control   */
/** @} */


/**
 * @name Chip ID Register Layout
 *
 *  CS4270_REG_CHIP_ID  -   CHIP ID - Address 0x01  -   Read Only
 *
 *  0000----    :   ID[3:0]     - part number ID 1100 for CS4270
 *  ----0000    :   REV[3:0]    - chip revision
 */

/**
 * @name Power Control register layout
 *
 *  CS4270_REG_POWER_CONTROL    - POWER CONTROL - Address 0x02 - Read/Write
 *
 *  0-------    :   FREEZE      -   Allows to make multiple changes to control port bits. 1 - Freeze, 0 - Release
 *                                  When released, all changes take effect simultaneously
 *                                  Registers affected:
 *                                  CS4270_REG_TRANSITION_CONTROL (0x05)
 *                                  CS4270_REG_MUTE               (0x06)
 *                                  CS4270_REG_VOL_CONTROL_AOUTA  (0x07)
 *                                  CS4270_REG_VOL_CONTROL_AOUTB  (0x08)
 *  -0------    :   RESERVED    -   do not use
 *  --0-----    :   PDN_ADC     -   1 - Power down ADC, 0 - ADC is up and running
 *  ---000--    :   RESERVED    -   do not use
 *  ------0-    :   PDN_DAC     -   1 - Power down DAC, 0 - DAC is up and running
 *  -------0    :   PDN         -   1 - Power down device, 0 - Device is up and running. The contents of the control registers are retained during power-down.
 */
/** @{ */
#define CS4270_FREEZE                   0x80    /**< Freeze state so mulitple changes can be made, unfreeze when done */
#define CS4270_POWERDOWN_ADC            0x20    /**< ADC in low-power state         */
#define CS4270_POWERDOWN_DAC            0x02    /**< DAC in low-power state         */
#define CS4270_POWERDOWN                0x01    /**< Device in low-power state      */
/** @} */

/**
 * @name Mode Control register layout
 *
 *  CS4270_REG_FUNCTION_MODE    - MODE CONTROL - Address 0x03 - Read/Write
 *
 *  00------    :   RESERVED    -   do not use
 *  --00----    :   FM_MS_MODE  -   Functional Mode and Master/Slave mode [1:0]
 *                                  00  -   Single-Speed Mode: 4 to 54kHz sample rates
 *                                  01  -   Double-Speed Mode: 50 to 108 kHz sample rates
 *                                  10  -   Quad-Speed Mode: 100 to 216 kHz sample rates
 *                                  11  -   Slave Mode (default)
 *  ----000-    :   MCLK_FREQ   -   MCLK clocking ratios
 *                                  000 -   Divide by 1 (default)
 *                                  001 -   Divide by 1.5
 *                                  010 -   Divide by 2
 *                                  011 -   Divide by 3
 *                                  100 -   Divide by 4
 *                                  101 -> 111 - Reserved, do not use
 *  -------0    :   POPGUARD_DIS -  1 - Disables Popguard, 0 - enables popguard (default)
 */
/** @{ */
#define CS4270_MODE_SINGLE_SPEED        0x00       /**< Single-Speed Mode: 4 to 54kHz sample rates     */
#define CS4270_MODE_DOUBLE_SPEED        0x10       /**< Double-Speed Mode: 50 to 108 kHz sample rates  */
#define CS4270_MODE_QUAD_SPEED          0x20      /**< Quad-Speed Mode: 100 to 216 kHz sample rates   */
#define CS4270_MODE_SLAVE_MODE          0x30      /**< Slave Mode (default)                           */
#define CS4270_MODE_MASK                0x30

#define CS4270_MODE_MCLK_DIV_1          0x00       /**< Divide by 1 (default)                          */
#define CS4270_MODE_MCLK_DIV_1_5        0x02       /**< Divide by 1.5                                  */
#define CS4270_MODE_MCLK_DIV_2          0x04       /**< Divide by 2                                    */
#define CS4270_MODE_MCLK_DIV_3          0x06       /**< Divide by 3                                    */
#define CS4270_MODE_MCLK_DIV_4          0x08       /**< Divide by 4                                    */
#define CS4270_MODE_MCLK_MASK           0x0E

#define CS4270_MODE_POPGUARD_DISABLE    0x01    /**< Diasbales Popguard when set. Popguard is enabled by default.    */
/** @} */

/*
 * @name ADC and DAC Control register layout
 *
 *  CS4270_REG_SERIAL_AUDIO_FORMAT    - ADC and DAC Control - Address 0x04 - Read/Write
 *
 *  0-------    :   ADC_HPF_A   -   ADC HPF Freeze A, 1 - the internal high-pass filter for the selected channel will be disabled.
 *                                  The current DC offset value will be frozen and continuously subtracted from the conversion result.
 *  -0------    :   ADC_HPF_B   -   ADC HPF Freeze B, 1 - the internal high-pass filter for the selected channel will be disabled.
 *                                  The current DC offset value will be frozen and continuously subtracted from the conversion result.
 *  --0-----    :   DIG_LOOPBACK -  1 - enables internal digital loopback from the ADC to the DAC.
 *  ---00---    :   DAC_DIF     -   DAC Digital Interface Format
 *                                  00  - Left-Justified, up to 24-bit data (default) - Format 0
 *                                  01  - I2S, up to 24-bit data                      - Format 1
 *                                  10  - Right-Justifed, 24-bit data                 - Format 3 (note format 3 is "10" not "11")
 *                                  11  - Right-Justified, 16-bit data                - Format 2
 *  -----00-    :   RESERVED    -   do not use
 *  -------0    :   ADC_DIF     -   ADC Digital interface Format,
 *                                  0 - Left-Justified, up to 24-bit data (default) - Format 0
 *                                  1 - I2S, up to 24-bit data                      - Format 1
 */
/** @{ */
#define CS4270_FORMAT_ADC_HPF_A         0x80    /**< ADC HPF Freeze A. When this bit is set, the internal high-pass filter for the selected channel will be disabled.   */
#define CS4270_FORMAT_ADC_HPF_B         0x40    /**< ADC HPF Freeze B. When this bit is set, the internal high-pass filter for the selected channel will be disabled.   */
#define CS4270_FORMAT_DIG_LOOPBACK      0x20    /**< Digital Loopback. When this bit is set, an internal digital loopback from ADC to DAC will be enabled.              */

#define CS4270_FORMAT_DAC_DIF_MASK      0x18
#define CS4270_FORMAT_DAC_DIF_FORMAT_I2S_LEFT_JUSTIFIED_24_BIT   0x00  /**< Left-Justified, up to 24-bit data (default)    */
#define CS4270_FORMAT_DAC_DIF_FORMAT_I2S_NORMAL_24_BIT           0x08  /**< I2S, up to 24-bit data                         */
#define CS4270_FORMAT_DAC_DIF_FORMAT_I2S_RIGHT_JUSTIFIED_16_BIT  0x18  /**< Right-Justified, 16-bit data                   */
#define CS4270_FORMAT_DAC_DIF_FORMAT_I2S_RIGHT_JUSTIFIED_24_BIT  0x10  /**< Right-Justified, 24-bit data                   */

#define CS4270_FORMAT_ADC_DIF           0x01    /**< ADC Digital Interface Format. 0 Left-Justified, up to 24-bit data. 1 I2S, up to 24-bit data */
/** @} */

/**
 * @name Transition Control register layout
 *
 *  CS4270_REG_TRANSITION_CONTROL    - TRANSITION CONTROL - Address 0x05 - Read/Write
 *
 *  0-------    :   DAC_VOLUME  -
 *  -00-----    :   SOFT_CROS   -   Soft Ramp and Zero Cross Enable - [Soft Ramp : Zero Cross]
 *                                  00  - Changes to affect immediately
 *                                  01  - Zero Cross Enabled
 *                                  10  - Soft Ramp Enabled
 *                                  11  - Soft Ramp and Zero Cross enabled (default)
 *                                  Soft Ramp Enable allows level changes, both muting and attenuation,
 *                                  to be implemented by incrementally ramping in 1/8 dB steps at a rate of 1dB per 8 left/right clock periods.
 *                                  Zero Cross Enable dictates that signal level changes, either by attenuation changes or muting will occur on a signal zero crossing to minimize audible artifacts
 *                                  The requested level change will occur after a time out period between 512 and 1024 sample periods (10.7ms to 21.3 ms at 48kHz sample rate)
 *                                  if the signal does not encounter a zero crossing. This is independent for each channel
 *  ---0000-    :   INVERT_CTRL -   ADC, DAC Invert Signal Polarity, [ADC ch B, ADC ch A, DAC ch B, DAC ch A] When set, enables inversion of signal polarity for the appropriate channel
 *  -------0    :   DE_EMPH     -   De-Emphasis Control,
 *
 */
 /** @{ */
#define CS4270_TRAN_DAC_VOLUME          0x80    /**< DAC Single Volume  */

#define CS4270_TRAN_SOFT_CROSS_MASK     0x60    /**< Soft Ramp or Zero Cross Enable (Bits 6:5)  */
#define CS4270_TRAN_SOFT_OFF_CROSS_OFF  0x00    /**< Changes to affect immediately              */
#define CS4270_TRAN_SOFT_OFF_CROSS_ON   0x20    /**< Zero Cross enabled                         */
#define CS4270_TRAN_SOFT_ON_CROSS_OFF   0x40    /**< Soft Ramp enabled                          */
#define CS4270_TRAN_SOFT_ON_CROSS_ON    0x60    /**< Soft Ramp and Zero Cross enabled (default) */

#define CS4270_TRAN_INVERT_SIG_POL_MASK 0x1E    /**< Invert Signal Polarity (Bits 4:1)          */
#define CS4270_TRAN_INVERT_ADC_B        0x10    /**< Invert ADC channel B                       */
#define CS4270_TRAN_INVERT_ADC_A        0x08    /**< Invert ADC channel A                       */
#define CS4270_TRAN_INVERT_DAC_B        0x04    /**< Invert DAC channel B                       */
#define CS4270_TRAN_INVERT_DAC_A        0x02    /**< Invert DAC channle A                       */

#define CS4270_TRAN_DE_EMPH             0x01    /**< De-Emphasis, 50/15us digital de-emphaisis filter on the DAC output (only available in single speed mode) */
/** @} */

/**
 * @name Mute Control register layout
 *
 *  CS4270_REG_MUTE_CONTROL    - MUTE CONTROL - Address 0x06 - Read/Write
 *
 *  00------    :   RESERVED    -   do not use
 *  --0-----    :   AUTO_MUTE   -   1 - enables auto mute, 0 - disables auto mute
 *  ---00---    :   ADC_MUTE    -   ADC Channel A and B Mute [B:A],
 *                                  00 - Disable mute on both channels
 *                                  01 - Mute channel A only
 *                                  10 - Mute channel B only
 *                                  11 - Mute both channels
 *  -----0--    :   MUTE_POL    -   Mute Polarity, 1 - mute pins are active high 0 - mute pins are active low (default)
 *  ------00    :   DAC_MUTE    -   DAC Channel A and B Mute [B:A]
 *                                  00 - Disable mute on both channels
 *                                  01 - Mute channel A only
 *                                  10 - Mute channel B only
 *                                  11 - Mute both channels
 */
/** @{ */
#define CS4270_MUTE_AUTO_MUTE       0x20    /**< Auto-Mute. When set, enables the Auto-Mute function.           */
#define CS4270_MUTE_ADC_B           0x10    /**< Mute ADC Channel B                                             */
#define CS4270_MUTE_ADC_A           0x08    /**< Mute ADC Channel A                                             */
#define CS4270_MUTE_POLARITY        0x04    /**< Mute Polarity. When set the MUTEA and MUTEB pins are active high.  */
#define CS4270_MUTE_DAC_B           0x02    /**< Mute DAC Channel B                                             */
#define CS4270_MUTE_DAC_A           0x01    /**< Mute DAC Channel A                                             */
/** @} */

/**
 * @name DAC Volume Control
 *
 *  CS4270_REG_VOL_CONTROL_AOUTA    - DAC Channel A Volume Control - Address 0x06 - Read/Write
 *  CS4270_REG_VOL_CONTROL_AOUTB    - DAC Channel B Volume Control - Address 0x07 - Read/Write
 *  00000000    :   Volume level    -    Volume level independent for each channel
 *                                       00000000    00.00 dB
 *                                       00000001   -00.50 dB
 *                                       00101000   -20.00 dB
 *                                       00101001   -20.50 dB
 *                                       11111110   -127.0 dB
 *                                       11111111   -127.5 dB
 * The digital volume control allows the user to attenuate the signal in 0.5 dB increments from 0 to -127 dB.
 * The vol<0> bit activates a 0.5 dB attenuation when set, and no attenuation when cleared. The Vol[7:1]
 * bits activate attenuation equal to their decimal value (in dB). The volume changes are implemented as
 * dictated by the DAC Soft and DAC Zero-Cross bits in the Transition Control register.
 */

/**
 * @brief
 *      Channel selections
 *
 * This enum defines all possible audio channel selection values.
 *
 */
typedef enum {
    eChannel_R,		/**< right channel */
    eChannel_L,		/**< left channel */
    eChannel_Stereo	/**< two channels */
} channel_select_t;

typedef struct cs4270_s cs4270_t;

extern int  cs4270_reset        (cs4270_t * restrict drv);
extern int  cs4270_set_default  (cs4270_t * restrict drv);
extern int  cs4270_write        (cs4270_t * restrict drv, uint8_t address, uint8_t data);
extern int  cs4270_read         (cs4270_t * restrict drv, uint8_t address, uint8_t * data);
extern int  cs4270_set_volume   (cs4270_t * restrict drv, uint8_t volume, channel_select_t channel);

extern cs4270_t * cs4270_open(int id);

#ifdef  __cplusplus
}
#endif

#endif /* _DRV_CS4270_H */


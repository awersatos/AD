/*****************************************************************************
|*
|*  COPYRIGHT:          Copyright (c) 2008, Altium
|*
|*  Description:        I2S peripheral device driver interface.
|*
|*****************************************************************************/

/**
 * @file
 * Device driver interface for WB_I2S peripheral.
 */

#ifndef _DRV_I2S_H
#define _DRV_I2S_H

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdbool.h>


/**
 * @brief
 *  Word widths
 *
 *  This enum defines all supported word widths.
 */
typedef enum
{
    I2S_WWIDTH_16           = 16,   /**< 16 bits word width         */
    I2S_WWIDTH_20           = 20,   /**< 20 bits word width         */
    I2S_WWIDTH_24           = 24,   /**< 24 bits word width         */
    I2S_WWIDTH_32           = 32    /**< 32 bits word width         */
} i2s_wwidth_t;

/**
 * @brief
 *  Word Justification
 *
 *  This enum defines all supported word justifications.
 */
typedef enum
{
    I2S_WJUST_I2S           = 0,    /**< I2S word justification     */
    I2S_WJUST_LEFT          = 1,    /**< left word justification    */
    I2S_WJUST_RIGHT         = 2     /**< right word justification   */
} i2s_wjust_t;

/**
 * @brief
 *  Output mode
 *
 *  This enum defines all supported audio output modes.
 */
typedef enum
{
    I2S_STEREO_OUTPUT       = 0,    /**< stereo output              */
    I2S_MONO_OUTPUT         = 1     /**< mono output                */
} i2s_output_t;

/**
 * @brief
 *  Input mode
 *
 *  This enum defines all supported audio input modes.
 */
typedef enum
{
    I2S_STEREO_INPUT        = 0,    /**< stereo input                   */
    I2S_MONO_INPUT_LEFT     = 2,    /**< mono input from left channel   */
    I2S_MONO_INPUT_RIGHT    = 6     /**< mono input from right channel  */
} i2s_input_t;

typedef struct i2s_s i2s_t;

extern void i2s_write8(i2s_t * restrict i2s_drv, int8_t * buffer, unsigned int n);
extern void i2s_read8(i2s_t * restrict i2s_drv, int8_t * buffer, unsigned int n);
extern void i2s_write16(i2s_t * restrict i2s_drv, int16_t * buffer, unsigned int n);
extern void i2s_read16(i2s_t * restrict i2s_drv, int16_t * buffer, unsigned int n);
extern void i2s_write32(i2s_t * restrict i2s_drv, int32_t * buffer, unsigned int n);
extern void i2s_read32(i2s_t * restrict i2s_drv, int32_t * buffer, unsigned int n);
extern uint32_t i2s_tx_avail(i2s_t * restrict i2s_drv);
extern uint32_t i2s_rx_avail(i2s_t * restrict i2s_drv);
extern void i2s_tx_start(i2s_t * restrict i2s_drv);
extern void i2s_rx_start(i2s_t * restrict i2s_drv);
extern void i2s_tx_stop(i2s_t * restrict i2s_drv);
extern void i2s_rx_stop(i2s_t * restrict i2s_drv);

extern void i2s_calculate_and_set_prescaler(i2s_t * restrict i2s_drv, uint32_t samplerate, uint32_t clock_frequency);

extern void i2s_set_prescaler(i2s_t * restrict i2s_drv, uint8_t value);
extern void i2s_set_watermark(i2s_t * restrict i2s_drv, uint16_t value);
extern bool i2s_set_wwidth(i2s_t * restrict i2s_drv, i2s_wwidth_t wwidth);
extern i2s_wwidth_t i2s_get_wwidth(i2s_t * restrict i2s_drv);
extern bool i2s_set_wjust(i2s_t * restrict i2s_drv, i2s_wjust_t wjust);
extern bool i2s_set_output_mode(i2s_t * restrict i2s_drv, i2s_output_t mode);
extern bool i2s_set_input_mode(i2s_t * restrict i2s_drv, i2s_input_t mode);

extern i2s_t * i2s_open(int id);

#ifdef  __cplusplus
}
#endif

#endif /* _DRV_I2S_H */


/** @file
 *      MAXIM 1104 audio CODEC
 *
 * The MAX1104 CODEC provides both an 8-bit analog-to-digital converter (ADC)
 * and an 8-bit digital-to-analog converter (DAC)
 */

#ifndef _DRV_MAX1104_H_
#define _DRV_MAX1104_H_

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdbool.h>

typedef struct _max1104_t max1104_t;

/**
 * @name Control-Byte Format
 *
 * +------+-------+------------------------------------------------------------+
 * | BIT# | NAME  |  DESCRIPTION                                               |
 * +------+-------+------------------------------------------------------------+
 * |7(MSB)| START |  1=New Control Word,                                       |
 * |      |       |  0=Control word ignored                                    |
 * +------+-------+------------------------------------------------------------+
 * |  6   |  A1   |  1=DAC addressed Current byte configures DAC, then DAC Data|
 * |      |       |  0=DAC not addressed                                       |
 * +------+-------+------------------------------------------------------------+
 * |  5   |  A0   |  1=ADC Current byte configuration, next byte returns Data  |
 * |      |       |  0=ADC not addressed                                       |
 * +------+-------+------------------------------------------------------------+
 * |  4   |  C1   |  1=ADC input to Vdd/2   (not recommended for MAX1104)      |
 * |      |       |  0=ADC input to AIN                                        |
 * +------+-------+------------------------------------------------------------+
 * |  3   |  C0   |  1=Continuous conversion until reconfigured                |
 * |      |       |  0=Single conversion, controlword reqd. for next conversion|
 * +------+-------+------------------------------------------------------------+
 * |  2   |  E2   |  1=reference enabled    (don't care for MAX1104)           |
 * |      |       |  0=reference disabled                                      |
 * +------+-------+------------------------------------------------------------+
 * |  1   |  E1   |  1=ADC enabled                                             |
 * |      |       |  0=ADC disabled                                            |
 * +------+-------+------------------------------------------------------------+
 * |  0   |  E0   |  1=DAC enabled                                             |
 * |      |       |  0=DAC disabled                                            |
 * +------+-------+------------------------------------------------------------+
 */
/** @{ */
#define MAX1104_START 0x80  /**< START */
#define MAX1104_A1    0x40  /**< A1 */
#define MAX1104_A0    0x20  /**< A0 */
#define MAX1104_C1    0x10  /**< C1 */
#define MAX1104_C0    0x08  /**< C0 */
#define MAX1104_E2    0x04  /**< E2 */
#define MAX1104_E1    0x02  /**< E1 */
#define MAX1104_E0    0x01  /**< E0 */
/**@} */

/*
 * mode for max1104_open_in_mode() and max1104_set_mode()
 */
typedef enum {
    Continuous_ADCDAC   = MAX1104_START | MAX1104_A1 | MAX1104_A0 | MAX1104_C0 | MAX1104_E1 | MAX1104_E0,
    Continuous_ADC      = MAX1104_START |              MAX1104_A0 | MAX1104_C0 | MAX1104_E1 | MAX1104_E0,
    Continuous_DAC      = MAX1104_START | MAX1104_A1 |              MAX1104_C0 | MAX1104_E1 | MAX1104_E0,
    Single_ADCDAC       = MAX1104_START | MAX1104_A1 | MAX1104_A0 |              MAX1104_E1 | MAX1104_E0,
    Single_ADC          = MAX1104_START |              MAX1104_A0 |              MAX1104_E1 | MAX1104_E0,
    Single_DAC          = MAX1104_START | MAX1104_A1 |                           MAX1104_E1 | MAX1104_E0
} max1104_mode_t;

extern max1104_t *drv_max1104_open_in_mode(int id, max1104_mode_t mode);
extern max1104_t *drv_max1104_open(int id);
extern int drv_max1104_close(max1104_t *drv);
extern int drv_max1104_set_mode(max1104_t *drv, max1104_mode_t mode);
extern void drv_max1104_set_enabled(max1104_t *drv, bool enable_adc, bool enable_dac);
extern int drv_max1104_getc(max1104_t *drv);
extern int drv_max1104_putc(int c, max1104_t *drv);
extern int drv_max1104_rx_avail(max1104_t *drv);
extern int drv_max1104_tx_avail(max1104_t *drv);
extern int drv_max1104_read(max1104_t *drv, void *buf, int nbyte);
extern int drv_max1104_write(max1104_t *drv, const void *buf, int nbyte);
extern void drv_max1104_timer_handler(max1104_t *drv);

#ifdef  __cplusplus
}
#endif

#endif /* ndef _DRV_MAX_1104_H_ */


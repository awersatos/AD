/** @file
 *      National Semiconductor ADC084S021 4 Channel, 50 ksps to 200 Ksps, 8-Bit A/D Converter
 *
 * The ADC084S021 is a low-power, four-channel CMOS 8-bit analog-to-digital
 * converter with a high-speed serial interface.
 */

#ifndef _DRV_ADC084S021_H_
#define _DRV_ADC084S021_H_

#ifdef  __cplusplus
extern "C" {
#endif

#define ADC084S021_IN1		0
#define ADC084S021_IN2		1
#define ADC084S021_IN3		2
#define ADC084S021_IN4		3

typedef struct drv_adc084s021_s adc084s021_t;

extern adc084s021_t *adc084s021_open(unsigned int id);
extern int adc084s021_read(adc084s021_t * restrict drv, int next_channel);
extern int adc084s021_get_next_channel( adc084s021_t * restrict drv );

#ifdef  __cplusplus
}
#endif

#endif /* ndef _DRV_ADC084S021_H_ */


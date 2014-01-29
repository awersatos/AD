/** @file
 *      Generic interface for Digital-to-Analog Converters
 *
 * This device provides a generic interface for different ADCs
 */

#ifndef _ADC_H
#define _ADC_H

#include <stdio.h>
#include <stdint.h>
#include <limits.h>

#define ADC_OK  0
#define ADC_ERR INT_MIN

typedef struct _adc_s adc_t;

#ifdef  __cplusplus
extern "C" {
#endif

extern adc_t *adc_open(unsigned int id);
extern int adc_read(adc_t *adc, unsigned channel);
extern int adc_read_multichannel(adc_t *adc, int *data, int nr_channels);

#ifdef  __cplusplus
}
#endif

#endif

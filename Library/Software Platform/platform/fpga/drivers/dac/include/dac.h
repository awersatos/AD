/** @file
 *      Generic interface for Analog-to-Digital Converters
 *
 * This device provides a generic interface for different DACs
 */

#ifndef _DAC_H
#define _DAC_H

#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>

#define DAC_OK  0
#define DAC_ERR 0x80000000

typedef struct _dac_s dac_t;

#ifdef  __cplusplus
extern "C" {
#endif

extern dac_t *dac_open(unsigned int id);
extern bool dac_write(dac_t *dac, unsigned channel, int value, bool flush);

#ifdef  __cplusplus
}
#endif

#endif

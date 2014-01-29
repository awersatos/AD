#ifndef __DRV_DAC084S085_H
#define __DRV_DAC084S085_H

#ifdef  __cplusplus
extern "C" {
#endif

/** @file
  * Interface to the DAC084S085 DA converter device driver
  */

#include <stdint.h>
#include <stdbool.h>

#define DAC084S085_OUTA     0
#define DAC084S085_OUTB     1
#define DAC084S085_OUTC     2
#define DAC084S085_OUTD     3

typedef struct drv_dac084s085_s dac084s085_t;

extern dac084s085_t * dac084s085_open( unsigned int id );
extern int dac084s085_write( dac084s085_t * drv, uint8_t channel, uint8_t value, bool flush );

#ifdef  __cplusplus
}
#endif

#endif // __DRV_DAC084S085_H

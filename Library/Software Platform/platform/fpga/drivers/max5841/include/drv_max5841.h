#ifndef __DRV_MAX5841_H
#define __DRV_MAX5841_H

#ifdef  __cplusplus
extern "C" {
#endif

/** @file
  * Interface to the MAX5841 DA converter device driver
  */

#include <stdint.h>

typedef struct drv_max5841_s max5841_t;

extern max5841_t * max5841_open( unsigned int id );
extern int max5841_out( max5841_t * drv, uint8_t channel, uint16_t value, bool flush );

#ifdef  __cplusplus
}
#endif

#endif // __DRV_MAX5841_H

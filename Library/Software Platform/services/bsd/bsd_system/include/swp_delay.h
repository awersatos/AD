////////////////////////////////////////////////////////////////////////////////
// swp_delay.h

#ifndef __SWP_DELAY_H
#define __SWP_DELAY_H

#include <stdint.h>
#include <time.h>

#ifdef  __cplusplus
extern "C" {
#endif

extern void delay_yield_us(uint32_t us);

#ifdef  __cplusplus
}
#endif

#endif // __SWP_DELAY_H

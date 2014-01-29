/*****************************************************************************
|*
|*  Copyright:          Copyright (c) 2007, Altium
|*
|*  Description:        Timers services
|*
\*****************************************************************************/

#ifndef _H_TIMERS
#define _H_TIMERS

#ifdef  __cplusplus
extern "C" {
#endif

#include <stdbool.h>
#include <stdint.h>
#include "timing_cfg.h"

#if ( TIMING_USETIMERS != 0 ) 

/**
 * @brief
 *      periodic software timer handler
 *
 */
typedef void (*timer_handler_t) (void * context);

extern void* 		timer_register_handler   (void* context, int64_t freq, timer_handler_t handler);
extern bool  		timer_deregister_handler (void* id);

#endif

#ifdef  __cplusplus
}
#endif

#endif

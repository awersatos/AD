
#if !defined LH79520_TIMER_H
#define LH79520_TIMER_H

#include "lh79520_chip.h"

/***********************************************************************
 * Timer Module Register Structure
 **********************************************************************/
typedef struct
{
    volatile unsigned int load;
    volatile unsigned int value;
    volatile unsigned int control;
    volatile unsigned int clear;
} TIMER_REGS_T;

/***********************************************************************
 * Timer Control Register Bit Field constants
 * All other bits in the Timer Control Register must be written as
 * zero
 **********************************************************************/
/* Timer control register bit field - enable timer */ 
#define TMRCTRL_ENABLE          _SBF(7,1)
/* Timer control register bit field - disable timer */ 
#define TMRCTRL_DISABLE         _SBF(7,0)
/* Timer control register bit field - set timer mode periodic */ 
#define TMRCTRL_MODE_PERIODIC   _SBF(6,1)
/* Timer control register bit field - set timer mode free running */ 
#define TMRCTRL_MODE_FREERUN    _SBF(6,0)
/* Timer control register bit field - timer cascade mode enable */ 
#define TMRCTRL_CASCADE_ENABLE  _SBF(4,1)
/* Timer control register bit field - timer cascade mode disable */ 
#define TMRCTRL_CASCADE_DISABLE _SBF(4,0)
/* Timer control register bit field - prescaler is 1 */ 
#define TMRCTRL_PRESCALE1       _SBF(2,0)
/* Timer control register bit field - prescaler is 16 */ 
#define TMRCTRL_PRESCALE16      _SBF(2,1)
/* Timer control register bit field - prescaler is 256 */ 
#define TMRCTRL_PRESCALE256     _SBF(2,2)

/* Macro pointing to TIMER0 registers */
#define TIMER0  ((TIMER_REGS_T *)(TIMER0_BASE))
/* Macro pointing to TIMER1 registers */
#define TIMER1  ((TIMER_REGS_T *)(TIMER1_BASE))
/* Macro pointing to TIMER2 registers */
#define TIMER2  ((TIMER_REGS_T *)(TIMER2_BASE))
/* Macro pointing to TIMER3 registers */
#define TIMER3  ((TIMER_REGS_T *)(TIMER3_BASE))

/* Timers prescale value */
#define TIMERS_PRESCALE                        1


#endif /* LH79520_TIMER_H */ 

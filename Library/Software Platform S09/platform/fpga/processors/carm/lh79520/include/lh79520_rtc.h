
#if !defined LH79520_RTC_H
#define LH79520_RTC_H

#include "lh79520_chip.h"

/**********************************************************************
 * Real Time Clock Module Register Structure
 *********************************************************************/
typedef struct
{
    volatile unsigned int dr;         /* Data */
    volatile unsigned int mr;         /* Match */
    volatile unsigned int stat_eoi;   /* Interrupt Status/Interrupt Clear */
    volatile unsigned int clr;        /* Counter Load */
    volatile unsigned int cr;         /* Control */
} RTC_REGS_T;

/**********************************************************************
 * Real Time Clock Register Bit Fields
 *********************************************************************/ 

/**********************************************************************
 * RTC Status and Interrupt Clear Register (stat, eoi) Bit Fields
 *********************************************************************/
/* bit definition for RTC interruption clear */
#define RTC_RTCINTR     _BIT(0)

/**********************************************************************
 * RTC Control Register (cr) Bit Fields
 *********************************************************************/ 
#define RTC_CR_MIE      _BIT(0)

/* Macro pointing to RTC registers */
#define RTC    ((RTC_REGS_T *)(RTC_BASE))


#endif /* LH79520_RTC_H */ 

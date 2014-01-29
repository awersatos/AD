 /*****************************************************************************\
|*
|*  COPYRIGHT:     Copyright (c) 2006, Altium
|*
|*  DESCRIPTION:   lh79520 smc definitions
|*
\*****************************************************************************/

#if !defined LH79520_SMC_H
#define LH79520_SMC_H

#include "lh79520_chip.h"

/***********************************************************************
 * Static Memory Controller Module Register Structure
 **********************************************************************/
typedef struct 
{
    volatile uint32_t bcr0;    /* Configuration for bank 0 */
    volatile uint32_t bcr1;    /* Configuration for bank 1 */
    volatile uint32_t bcr2;    /* Configuration for bank 2 */
    volatile uint32_t bcr3;    /* Configuration for bank 3 */
    volatile uint32_t bcr4;    /* Configuration for bank 4 */
    volatile uint32_t bcr5;    /* Configuration for bank 5 */
    volatile uint32_t bcr6;    /* Configuration for bank 6 */
    volatile uint32_t bcr7;    /* Configuration for bank 7 */
} SMC_REGS_TYPE;

/***********************************************************************
 * Static Memory Controller Bit Field constants
 **********************************************************************/
/* Static Memory Controller bit field - Idle Cycle Time */
#define IDCY(n)     _SBF(0,((n)&_BITMASK(4)))  /* Idle Cycle Time */
/* Static Memory Controller bit field - Wait State 1 */
#define WST1(n)     _SBF(5,((n)&_BITMASK(5)))  /* Wait State 1 */
/* Static Memory Controller bit field - Read Byte Lane Enable*/
#define RBLE(n)     _SBF(10,((n)&_BITMASK(1))) /*Read Byte Lane Enable*/
/* Static Memory Controller bit field - Wait State 2 */
#define WST2(n)     _SBF(11,((n)&_BITMASK(5))) /* Wait State 2 */
/* Static Memory Controller bit field - Bus Transfer Error Flag */
#define BUSERR      _BIT(24)            /* Bus Transfer Error Flag */
/* Static Memory Controller bit field - Write Protect Error Flag */
#define WPERR       _BIT(25)            /* Write Protect Error Flag */
/* Static Memory Controller bit field - Write Protect */
#define WP          _BIT(26)            /* Write Protect */
/* Static Memory Controller bit field - Burst Mode */
#define BM          _BIT(27)            /* Burst Mode */
/* Static Memory Controller bit field - Memory width 8 bits */
#define MW8         _SBF(28,0)          /* Memory width 8 bits */
/* Static Memory Controller bit field - Memory width 16 bits */
#define MW16        _SBF(28,1)          /* Memory width 16 bits */
/* Static Memory Controller bit field - Memory width 32 bits */
#define MW32        _SBF(28,2)          /* Memory width 32 bits */

/* Macro pointing to SMC registers */
#define SMC    ((SMC_REGS_TYPE *)(SMC_REGS_BASE))

#endif /* LH79520_SMC_H */

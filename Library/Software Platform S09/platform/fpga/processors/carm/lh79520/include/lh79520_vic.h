
#ifndef _LH79520_VIC_H
#define _LH79520_VIC_H

#include "lh79520_chip.h"

#define VIC_VECTORED_IRQ_MODE           0
#define VIC_NONVECTORED_FIQ_MODE        1
#define VIC_MODE                        VIC_VECTORED_IRQ_MODE

#define VIC_BASE_MIRROR                 (AHB_BASE + 0x0000)
#define VIC_BASE                        (AHB_BASE + 0xF000)

/*
 * Vectored Interrupt Controller Module Register Structure
 */ 
typedef struct 
{
    volatile uint32_t irqstatus;
    volatile uint32_t fiqstatus;
    volatile uint32_t rawintr;
    volatile uint32_t intselect;
    volatile uint32_t intenable;
    volatile uint32_t intenclear;
    volatile uint32_t softint;
    volatile uint32_t softintclear;
    volatile uint32_t reserved1[4];
    volatile uint32_t vectoraddr;
    volatile uint32_t defvectaddr;
    volatile uint32_t reserved2[50];
    volatile uint32_t vectaddr[16];   /* name arranged as array */
    volatile uint32_t reserved3[48];
    volatile uint32_t vectcntl[16];   /* name arranged as array */
    volatile uint32_t reserved4[51];
    volatile uint32_t itop1;
} VIC_REGS_TYPE;

/**********************************************************************
 * Vectored Interrupt Controller Register Bit Fields
 *********************************************************************/ 

/**********************************************************************
 * The bit fields of the following registers have implementation
 * specific meaning, and must be defined at the implementation level.
 *
 *      irqstatus   - VICIRQStatus
 *      fiqstatus   - VICFIQStatus
 *      rawintr     - VICRawIntr
 *      intselect   - VICIntSelect
 *      intenable   - VICIntEnable
 *      intenclear  - VICIntEnClear
 *      softint     - VICSoftInt
 *      softintclear- VICSoftIntClear
 *
 * The following definitions for these registers are generic,
 * i.e., they are implementation independent. They can be used to
 * create implementation specific macros.
 *********************************************************************/ 

/**********************************************************************
 * VIC Interrupt Select Register Bit Fields
 *********************************************************************/ 
/* The following can be OR'd with the IntSelect Register to select
 * an interrupt as FIQ. */ 
#define VIC_INTSELECT_FIQ(n)    _BIT((n) & _BITMASK(5))
/* The following can be AND'd with the IntSelect Register to select
 * an interrupt as IRQ. */
#define VIC_INTSELECT_IRQ(n)    ~(_BIT((n) & _BITMASK(5)))

/* constant for IRQ type */
#define VIC_INT_TYPE_IRQ    0
/* constant for FIQ type */
#define VIC_INT_TYPE_FIQ    1

/**********************************************************************
 * VIC Interrupt Enable, Interrupt Enable Clear Register Bit Fields
 * VIC Soft Interrupt, Soft Interrupt Clear Register Bit Fields
 *********************************************************************/ 
/* bit field definition for VIC interruption enable */
#define VIC_INT_ENABLE(n)       _BIT((n) & _BITMASK(5))
/* bit field definition for VIC interruption clear */
#define VIC_INT_CLEAR(n)        _BIT((n) & _BITMASK(5))

/**********************************************************************
 * VIC Vector Address Clear Register
 *********************************************************************/ 
#define VIC_VECTORADDR_CLEAR    0

/**********************************************************************
 * VIC Vector Control Register Bit Fields
 *********************************************************************/ 

/* To revise a Vector Control Register, clear the register, then 
 * use the SELECT macro to associate a line and enable the vector 
 * with the same operation.
 * The ENABLE macro is provided for completeness.
 * Use this register to enable and disable the VECTOR feature;
 * use the intenable register to enable the interrupt
 * itself, and the intenclear register to clear the interrupt. */ 
#define VIC_VECTCNTL_SELECT(n)  (_SBF(0,((n) & _BITMASK(5))) | _BIT(5))
/* vic vector control register enable bit */
#define VIC_VECTCNTL_ENABLE     _BIT(5)

/**********************************************************************
 * Vectored Interrupt Controller Register ITOP1   - Test Output 1
 * (used for debugging)
 *********************************************************************/ 
/* vic interruption ITOP1 register bits - FIQ */
#define VIC_ITOP1_FIQ         _BIT(6)
/* vic interruption ITOP1 register bits - IRQ */
#define VIC_ITOP1_IRQ         _BIT(7)

/***********************************************************************
 * VIC Vectors
 **********************************************************************/
/* vectored interruption number - VIC 0 */ 
#define VIC_VECT_0          0
/* vectored interruption number - VIC 1 */ 
#define VIC_VECT_1          1
/* vectored interruption number - VIC 2 */ 
#define VIC_VECT_2          2
/* vectored interruption number - VIC 3 */ 
#define VIC_VECT_3          3
/* vectored interruption number - VIC 4 */ 
#define VIC_VECT_4          4
/* vectored interruption number - VIC 5 */ 
#define VIC_VECT_5          5
/* vectored interruption number - VIC 6 */ 
#define VIC_VECT_6          6
/* vectored interruption number - VIC 7 */ 
#define VIC_VECT_7          7
/* vectored interruption number - VIC 8 */ 
#define VIC_VECT_8          8
/* vectored interruption number - VIC 9 */ 
#define VIC_VECT_9          9
/* vectored interruption number - VIC 10 */ 
#define VIC_VECT_10         10
/* vectored interruption number - VIC 11 */ 
#define VIC_VECT_11         11
/* vectored interruption number - VIC 12 */ 
#define VIC_VECT_12         12
/* vectored interruption number - VIC 13 */ 
#define VIC_VECT_13         13
/* vectored interruption number - VIC 14 */ 
#define VIC_VECT_14         14
/* vectored interruption number - VIC 15 */ 
#define VIC_VECT_15         15
/* vectored interruption number - VIC MAX */ 
#define VIC_VECT_MAX        VIC_VECT_15
/* vectored interruption number - VIC default */ 
#define VIC_VECT_DEFAULT    ~(0)

/***********************************************************************
 * LH79520 VIC Interrupt Sources
 **********************************************************************/
typedef enum
{
   VIC_EXINT0,     /* external interrupt 0 */
   VIC_EXINT1,     /* external interrupt 1 */
   VIC_EXINT2,     /* external interrupt 2 */
   VIC_EXINT3,     /* external interrupt 3 */
   VIC_EXINT4,     /* external interrupt 4 */
   VIC_EXINT5,     /* external interrupt 5 */
   VIC_EXINT6,     /* external interrupt 6 */
   VIC_EXINT7,     /* external interrupt 7 */
   VIC_SPAREINT0,  /* spare interrupt 0 */
   VIC_COMRX,      /* debug channel receive interrupt */
   VIC_COMTX,      /* debug channel transmit interrupt */
   VIC_SSPRXTO,    /* SSP receive timeout interrupt */
   VIC_CLCD,       /* LCD controller combined interrupt */
   VIC_SSPTX,      /* SSP transmit interrupt */
   VIC_SSPRX,      /* SSP receive interrupt */
   VIC_SSPROR,     /* SSP receive overrun interrupt */
   VIC_SSPINT,     /* SSP combined interrupt */
   VIC_TIMER0,       /* counter-timer0 nterrupt */
   VIC_TIMER1,       /* counter-timer1 interrupt */
   VIC_TIMER2,       /* counter-timer2 interrupt */
   VIC_TIMER3,       /* counter-timer3 interrupt */
   VIC_UARTRX0,    /* UART0 Receive interrupt */
   VIC_UARTTX0,    /* UART0 Transmit interrupt */
   VIC_UARTINT0,   /* UART0 combined interrupt */
   VIC_UARTINT1,   /* UART1 combined interrupt */
   VIC_UARTINT2,   /* UART2 combined interrupt */
   VIC_DMA,        /* DMA combined interrupt */
   VIC_SPAREINT1,  /* spare interrupt 1 */
   VIC_SPAREINT2,  /* spare interrupt 2 */
   VIC_SPAREINT3,  /* spare interrupt 3 */
   VIC_RTCINT,     /* Real-time Clock interrupt 1 */
   VIC_WDTINT,     /* Watchdog timer interrupt 1 */
   VIC_BAD_SOURCE  /* Invalid source; drivers return this on error */
} INT_SOURCE;

/* Macro pointing to VIC registers */
#define VIC         ((VIC_REGS_TYPE *)(VIC_BASE))
/* Macro pointing to VIC mirror registers */
#define VICMIRROR   ((VIC_REGS_TYPE *)(VIC_BASE_MIRROR))


#endif

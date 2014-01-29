#if !defined LH79520_RCPC_H
#define LH79520_RCPC_H

#include "lh79520_chip.h"

/**********************************************************************
 * Reset, Clock, and Power Controller Register Structure
 *********************************************************************/
typedef struct
{
    volatile unsigned int rcpcctrl;        /* RCPC Control */
    volatile unsigned int reserved1;       /* not used */
    volatile unsigned int remap;           /* Remap Control */
    volatile unsigned int softreset;       /* Soft Reset */
    volatile unsigned int resetstatus;     /* Reset Status */
    volatile unsigned int resetstatusclr;  /* Reset Status Clear */
    volatile unsigned int hclkprescale;    /* HCLK Prescale */
    volatile unsigned int cpuclkprescale;  /* Core Clock Prescale */
    volatile unsigned int pclkprescale;    /* PCLK Prescale */
    volatile unsigned int periphclkctrl;   /* Peripheral Clock Ctrl */
    volatile unsigned int periphclkctrl2;  /* Peripheral Clock Ctrl 2 */
    volatile unsigned int ahbclkctrl;      /* AHB Clock Ctrl */
    volatile unsigned int periphclksel;    /* Peripheral Clock Select*/
    volatile unsigned int periphclksel2;   /* Peripheral Clock Select 2 */
    volatile unsigned int pwm0prescale;    /* PWM 0 Prescale*/
    volatile unsigned int pwm1prescale;    /* PWM 1 Prescale*/
    volatile unsigned int lcdclkprescale;  /* LCD clock Prescale */
    volatile unsigned int sspclkprescale;  /* SSP clock Prescale */
    volatile unsigned int reserved2[14];   /* not used */
    volatile unsigned int intconfig;       /* Ext. Interrupt Config */
    volatile unsigned int intclear;        /* Ext. Interrupt Clear  */
    volatile unsigned int coreclkconfig;   /* Core Clock Config */
} RCPC_REGS_T;

/**********************************************************************
 * Reset, Clock, and Power Controller Register Bit Fields
 *********************************************************************/

/**********************************************************************
 * rcpcctrl - RCPCCtrl Register Bit Fields
 *********************************************************************/
/* RCPC control bit fields - enable pll */
#define RCPC_CTRL_EP        _BIT(0) /* Enable PLL */
/* RCPC control bit fields - enable external oscillator */
#define RCPC_CTRL_EX        _BIT(1) /* Enable Internal XTAL */

/* bit fields for power down mode */
#define RCPC_CTRL_PWRDWNSEL(n)  _SBF(2,(n)) /* Power Down Mode Sel*/
/* bit fields for power down mode - active mode*/
#define RCPC_PWRDWNSEL_ACTIVE    RCPC_CTRL_PWRDWNSEL(0)
/* bit fields for power down mode - standby mode*/
#define RCPC_PWRDWNSEL_STANDBY   RCPC_CTRL_PWRDWNSEL(1)
/* bit fields for power down mode - sleep mode */
#define RCPC_PWRDWNSEL_SLEEP     RCPC_CTRL_PWRDWNSEL(2)
/* bit fields for power down mode - stop1 mode */
#define RCPC_PWRDWNSEL_STOP1     RCPC_CTRL_PWRDWNSEL(3)
/* bit fields for power down mode - stop2 mode */
#define RCPC_PWRDWNSEL_STOP2     RCPC_CTRL_PWRDWNSEL(4)

/* bit fields for output selection field */
#define RCPC_CTRL_OUTSEL(n)     _SBF(5,(n))
/* bit fields for clock output selection - clock use internal oscillator */
#define RCPC_OUTSEL_CLK_INTOSC   RCPC_CTRL_OUTSEL(0)
/* bit fields for clock output selection - clock use pll */
#define RCPC_OUTSEL_CLK_PLL      RCPC_CTRL_OUTSEL(1)
/* bit fields for clock output selection field - clock use fclk */
#define RCPC_OUTSEL_FCLK_CPU     RCPC_CTRL_OUTSEL(2)
/* bit fields for clock output selection field - clock use hclk */
#define RCPC_OUTSEL_HCLK         RCPC_CTRL_OUTSEL(3)

/* bit fields for clock input select - select pll */
#define RCPC_CTRL_CLKSEL_PLL    _SBF(7,0)
/* bit fields for clock input select - select external */
#define RCPC_CTRL_CLKSEL_EXT    _SBF(7,1)

/* bit fields for RCPC controller write lock bit - locked */
#define RCPC_CTRL_WRTLOCK_LOCKED    _SBF(9,0)
/* bit fields for RCPC controller write lock bit - unlocked */
#define RCPC_CTRL_WRTLOCK_ENABLED   _SBF(9,1)

/**********************************************************************
 * remap - Remap Control Register Bit Fields
 *********************************************************************/
/* bit fields for remap register - set static memory at address 0x0 */
#define RCPC_REMAP_SMEM0    (0)
/* bit fields for remap register - set SDRAM at address 0x0 */
#define RCPC_REMAP_SDMEM0   (1)
/* bit fields for remap register - set internal SRAM at address 0x0 */
#define RCPC_REMAP_IMEM0    (2)

/**********************************************************************
 * softreset - Soft Reset Register Bit Fields
 *********************************************************************/
/* bit fields for software reset register - reset all */
#define RCPC_SOFTRESET_ALL  (0xDEAD)
/* bit fields for software reset register - reset global */
#define RCPC_SOFTRESET_GBL  (0xDEAC)

/**********************************************************************
 * resetstatus, resetstatusclr - Reset Status Register Bit Fields
 *********************************************************************/
/* bit fields for reset status register - reset from external */
#define RCPC_RESET_STATUS_EXT   _BIT(0)
/* bit fields for reset status register - reset from watch dog timer */
#define RCPC_RESET_STATUS_WDTO  _BIT(1)

/**********************************************************************
 * hclkPrescale - HCLK Prescaler Register Bit Fields
 * cpuclkPrescale - Core Clock Prescaler Register Bit Fields
 * pclkPrescale - PCLK Prescaler Register Bit Fields
 * pwm0Prescale - PWM0 Prescaler Register Bit Fields
 * pwm1Prescale - PWM1 Prescaler Register Bit Fields
 * sparePrescale - Spare Prescaler Register Bit Fields
 * Note: not all constants are applicable to all registers.
 *  See Reference.
 *********************************************************************/
/* bit fields for prescaler divider value - divider is 1 */
#define RCPC_PRESCALER_DIV1     _SBF(0,0)
/* bit fields for prescaler divider value - divider is 2 */
#define RCPC_PRESCALER_DIV2     _SBF(0,1)
/* bit fields for prescaler divider value - divider is 4 */
#define RCPC_PRESCALER_DIV4     _SBF(0,2)
/* bit fields for prescaler divider value - divider is 6 */
#define RCPC_PRESCALER_DIV6     _SBF(0,3)
/* bit fields for prescaler divider value - divider is 8 */
#define RCPC_PRESCALER_DIV8     _SBF(0,4)
/* bit fields for prescaler divider value - divider is 16 */
#define RCPC_PRESCALER_DIV16    _SBF(0,8)
/* bit fields for prescaler divider value - divider is 30 */
#define RCPC_PRESCALER_DIV30    _SBF(0,15)
/* bit fields for prescaler divider value - divider is 32 */
#define RCPC_PRESCALER_DIV32    _SBF(0,16)
/* bit fields for prescaler divider value - divider is 64 */
#define RCPC_PRESCALER_DIV64    _SBF(0,32)
/* bit fields for prescaler divider value - divider is 128 */
#define RCPC_PRESCALER_DIV128   _SBF(0,64)
/* bit fields for prescaler divider value - divider is 256 */
#define RCPC_PRESCALER_DIV256   _SBF(0,128)
/* bit fields for prescaler divider value - divider is 65534 */
#define RCPC_PRESCALER_DIV65534 (0xFFFF)

/**********************************************************************
 * periphclkctrl - Peripheral Clock Control Register Bit Fields
 * spareclkctrl - Spare Clock Control Register Bit Fields
 * ahbclkctrl - AHB Clock Control Register Bit Fields
 * Writing a "0" to a bit in these registers enables the
 *  corresponding clock
 *********************************************************************/
/* clock disable bit field definition - Uart 0 disable */
#define RCPC_CLKCTRL_U0_DISABLE         _BIT(0)
/* clock disable bit field definition - Uart 1 disable */
#define RCPC_CLKCTRL_U1_DISABLE         _BIT(1)
/* clock disable bit field definition - Uart 2 disable */
#define RCPC_CLKCTRL_U2_DISABLE         _BIT(2)
/* clock disable bit field definition - Counter 0,1 disable */
#define RCPC_CLKCTRL_CT01_DISABLE       _BIT(4)
/* clock disable bit field definition - Counter 2,3 disable */
#define RCPC_CLKCTRL_CT23_DISABLE       _BIT(5)
/* clock disable bit field definition - Counter 0 disable */
#define RCPC_CLKCTRL_CT0_DISABLE        _BIT(3)
/* clock disable bit field definition - Counter 1 disable */
#define RCPC_CLKCTRL_CT1_DISABLE        _BIT(4)
/* clock disable bit field definition - Counter 2 disable */
#define RCPC_CLKCTRL_CT2_DISABLE        _BIT(5)
/* clock disable bit field definition - Counter 3 disable */
#define RCPC_CLKCTRL_CT3_DISABLE        _BIT(6)
/* clock disable bit field definition - PWM0 disable */
#define RCPC_CLKCTRL_PWM0_DISABLE       _BIT(7)
/* clock disable bit field definition - PWM1 disable */
#define RCPC_CLKCTRL_PWM1_DISABLE       _BIT(8)
/* clock disable bit field definition - RTC disable */
#define RCPC_CLKCTRL_RTC_DISABLE        _BIT(9)
/* clock disable bit field definition - Sparre disable */
#define RCPC_CLKCTRL_SPARE_DISABLE(f)   _BIT(f)
/* clock disable bit field definition - SSP disable */
#define RCPC_CLKCTRL_SSPCLK_DISABLE     _BIT(1)
/* clock disable bit field definition - LCD disable */
#define RCPC_CLKCTRL_LCDCLK_DISABLE     _BIT(0)
/* clock disable bit field definition - DMA disable */
#define RCPC_CLKCTRL_DMAC_DISABLE       _BIT(0)
/* clock disable bit field definition - SDRAM disable */
#define RCPC_CLKCTRL_SDC_DISABLE        _BIT(1)

/**********************************************************************
 * periphclksel - Peripheral Clock Select Register Bit Fields
 * Writing a "0" to U0-U2 in this register enables the
 *  XTAL Oscillator as the clock source
 * Writing a "0" to CT0-CT3 in this register enables the
 *  HCLK as the clock source
 *********************************************************************/
/* clock source select bit field - Uart 0 as external */
#define RCPC_PCLKSEL_U0_EXT     _BIT(0) /* U0 Clock Source */
/* clock source select bit field - Uart 1 as external */
#define RCPC_PCLKSEL_U1_EXT     _BIT(1) /* U1 Clock Source */
/* clock source select bit field - Uart 2 as external */
#define RCPC_PCLKSEL_U2_EXT     _BIT(2) /* U2 Clock Source */
/* clock source select bit field - Counter 0 as external */
#define RCPC_PCLKSEL_CT0_EXT    _BIT(3) /* CT0 Clock Source */
/* clock source select bit field - Counter 1 as external */
#define RCPC_PCLKSEL_CT1_EXT    _BIT(4) /* CT1 Clock Source */
/* clock source select bit field - Counter 2 as external */
#define RCPC_PCLKSEL_CT2_EXT    _BIT(5) /* CT2 Clock Source */
/* clock source select bit field - Counter 3 as external */
#define RCPC_PCLKSEL_CT3_EXT    _BIT(6) /* CT3 Clock Source */
/* clock source select bit field - RTC use 1 hz clock */
#define RCPC_PCLKSEL_RTC_1HZ    0       /* RTC Clock Source 1Hz */
/* clock source select bit field - RTC use 32 Khz clock */
#define RCPC_PCLKSEL_RTC_32KHZ  _SBF(7,3) /* RTC Clock Source 32Khz */

/**********************************************************************
 * spareclksel - Peripheral Clock Select Register Bit Fields
 * Writing a "0" to a bit in this register enables the
 *  HCLK as the clock source
 *********************************************************************/
#define RCPC_SCLKSEL_SP(n)      _SBF((n),1) /* SP2 - SP15 */
/* clock source select bit field - SSP clock external */
#define RCPC_SCLKSEL_SSPCLK     _BIT(1) /* SSP Clock External */
/* clock source select bit field - LCD clock as external */
#define RCPC_SCLKSEL_LCDCLK     _BIT(0) /* LCD Clock External */

/**********************************************************************
 * intconfig - External Interrupt Configuration Register Bit Fields
 *********************************************************************/
/* macro definition for Intconfig register */
#define RCPC_INTCONFIG(f,v)     _SBF((f),(v))
/* RCPC_INTCONFIG arguments for 'f' parameter */
/* bit field - RCPC intconfig select INT 0 */
#define RCPC_INT0       0
/* bit field - RCPC intconfig select INT 1 */
#define RCPC_INT1       2
/* bit field - RCPC intconfig select INT 2 */
#define RCPC_INT2       4
/* bit field - RCPC intconfig select INT 3 */
#define RCPC_INT3       6
/* bit field - RCPC intconfig select INT 4 */
#define RCPC_INT4       8
/* bit field - RCPC intconfig select INT 5 */
#define RCPC_INT5       10
/* bit field - RCPC intconfig select INT 6 */
#define RCPC_INT6       12
/* bit field - RCPC intconfig select INT 7 */
#define RCPC_INT7       14
/* RCPC_INTCONFIG arguments for 'v' parameter */
/* bit fields for external INT trigger level - low level */
#define RCPC_INT_LLT    0       /* Low Level Trigger */
/* bit fields for external INT trigger level - high level */
#define RCPC_INT_HLT    1       /* High Level Trigger */
/* bit fields for external INT trigger level - falling edge */
#define RCPC_INT_FET    2       /* Falling Edge Trigger */
/* bit fields for external INT trigger level - rising edge */
#define RCPC_INT_RET    3       /* Rising Edge Trigger */

/**********************************************************************
 * intclear - External Interrupt Clear Register Bit Fields
 *********************************************************************/
/* macro for intclear register bit fields */
#define RCPC_INTCLEAR(n)    _BIT(n) /* Clear Edge Interrupt 'n' */

/**********************************************************************
 * coreclkconfig - Core Clock Configuration Register Bit Fields
 *********************************************************************/
/* bit fields for coreclkconfig register - standard mode, async */
#define RCPC_CCC_STDASYNCH      0 /* Standard Mode, Asynch operation */
/* bit fields for coreclkconfig register - fast bus mode */
#define RCPC_CCC_FASTBUS        1 /* Fast Bus Extension Mode */
/* bit fields for coreclkconfig register - standard mode, sync */
#define RCPC_CCC_STDSYNCH       2 /* Standard Mode, Synch operation */

/*  CPUCLK Prescale */
#define RCPC_CPUCLK_PRESCALE    2 
/*  HCLK Prescale */
#define RCPC_HCLK_PRESCALE      2




/* Macro pointing to RCPC registers */
#define RCPC    ((RCPC_REGS_T *)(RCPC_BASE))

#endif /* LH79520_RCPC_H */


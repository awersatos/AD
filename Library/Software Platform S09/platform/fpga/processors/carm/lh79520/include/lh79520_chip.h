
#if !defined LH79520_CHIP_H
#define LH79520_CHIP_H

#include <stdint.h>

#define _SBF(f,v)          (((unsigned int)(v)) << (f))
#define _BIT(n)            (((unsigned int)(1)) << (n))
#define _BITMASK(n)        (_BIT(n)-1)

/**********************************************************************
 * AHB BASES
 *********************************************************************/
/* MCU Advanced High speed bus base address */
#define AHB_BASE            (0xFFFF0000)
/* static memory controller controller base address */
#define SMC_REGS_BASE       (AHB_BASE + 0x1000)
/* synchronous dynamic RAM controller base address */
#define SDRAM_REGS_BASE     (AHB_BASE + 0x2000)
/* LCD controller base address */
#define LCD_LCDBASE         (AHB_BASE + 0x4000)

/**********************************************************************
 * APB BASES
 *********************************************************************/
/* MCU Advanced Peripheral Bus base address */
#define APB_BASE        (0xFFFC0000)
/* UART 0 base address */
#define UART0_BASE      (APB_BASE + 0x00000)
/* UART 1 base address */
#define UART1_BASE      (APB_BASE + 0x01000)
/* UART 2 base address */
#define UART2_BASE      (APB_BASE + 0x02000)
/* PWM base address */
#define PWM_BASE        (APB_BASE + 0x03000)
/* Timer 0 base address */
#define TIMER0_BASE     (APB_BASE + 0x04000)
/* Timer 1 base address */
#define TIMER1_BASE     (APB_BASE + 0x04020)
/* Timer 2 base address */
#define TIMER2_BASE     (APB_BASE + 0x05000)
/* Timer 3 base address */
#define TIMER3_BASE     (APB_BASE + 0x05020)
/* Synchronous serial peripheral base address */
#define SSP_BASE        (APB_BASE + 0x06000)
/* GPIO 3 base address */
#define GPIO3_BASE      (APB_BASE + 0x1C000)
/* GPIO 2 base address */
#define GPIO2_BASE      (APB_BASE + 0x1D000)
/* GPIO 1 base address */
#define GPIO1_BASE      (APB_BASE + 0x1E000)
/* GPIO 0 base address */
#define GPIO0_BASE      (APB_BASE + 0x1F000)
/* real time clock base address */
#define RTC_BASE        (APB_BASE + 0x20000)
/* DMA controller base address */
#define DMAC_BASE       (APB_BASE + 0x21000)
/* reset, clock, peripheral controler base address */
#define RCPC_BASE       (APB_BASE + 0x22000)
/* watch dog timer base address */
#define WDTIMER_BASE    (APB_BASE + 0x23000)
/* hr-tft lcd controller base address */
#define LCDICP_BASE     (APB_BASE + 0x24000)
/* input, output controller base address */
#define IOCON_BASE      (APB_BASE + 0x25000)

/* SDRAM memory base address */
#define SDRAM_MEM_BASE              (0x20000000)
/* static memory base address */
#define SMC_MEM_BASE                (0xFFFF1000)
/* MCU internal memory base address */
#define INTERNAL_MEM_BASE           (0x60000000)

/**********************************************************************
 * REMAP  (See the Memory Map section of the ARM Core and Buses
 *         chapter of the LH79520 User's Guide. The LH79520 Memory
 *         Map Variations figure shows how REMAP value determines
 *         whether the SMC, SDRAM, or internal SRAM is mirrored to
 *         the first 512 Mbytes of the LH79520's physical memory map)
 *
 *         Use the preprocessor define mechanism for your build
 *         environment to define the REMAP value.
 *********************************************************************/
#if !defined REMAP
#define REMAP 0     /* remap bit selection */
#endif

#if REMAP == 0
/* remap SRAM to 0x0 */
#define SMC_MIRROR_MEM_BASE         (0x00000000)    
#elif REMAP == 1 
/* remap SDRAM to 0x0 */
#define SDRAM_MIRROR_MEM_BASE       (0x00000000)    
#elif REMAP == 2 
/* remap internal SRAM to 0x0 */ 
#define INTERNAL_MIRROR_MEM_BASE    (0x00000000)    
#else
#error REMAP must be defined as 0, 1, or 2
#endif

/**********************************************************************
 * SMC Memory Bank Address Space Bases
 *********************************************************************/
/* static memory controller chip select 0 base address */
#define SMC_BANK0_BASE      (SMC_MEM_BASE + 0x00000000)
/* static memory controller chip select 1 base address */
#define SMC_BANK1_BASE      (SMC_MEM_BASE + 0x04000000)
/* static memory controller chip select 2 base address */
#define SMC_BANK2_BASE      (SMC_MEM_BASE + 0x08000000)
/* static memory controller chip select 3 base address */
#define SMC_BANK3_BASE      (SMC_MEM_BASE + 0x0C000000)
/* static memory controller chip select 4 base address */
#define SMC_BANK4_BASE      (SMC_MEM_BASE + 0x10000000)
/* static memory controller chip select 5 base address */
#define SMC_BANK5_BASE      (SMC_MEM_BASE + 0x14000000)
/* static memory controller chip select 6 base address */
#define SMC_BANK6_BASE      (SMC_MEM_BASE + 0x18000000)
/* static memory controller chip select 7 base address */
#define SMC_BANK7_BASE      (SMC_MEM_BASE + 0x1C000000)

/**********************************************************************
 * SDRAMC Memory Bank Address Space Bases
 *********************************************************************/
/* SDRAM chip select 0 base address */
#define SDRAM_BANK0_BASE        (SDRAM_MEM_BASE + 0x00000000)
/* SDRAM chip select 1 base address */
#define SDRAM_BANK1_BASE        (SDRAM_MEM_BASE + 0x08000000)


/***********************************************************************
 * Clock and crystal information
 **********************************************************************/
/* RTC clock input value */
#define CLOCK_32KHZ           32768         /* 32KHz clock frequency */
/* main MCU crystal value */
#define CLOCK_MAINOSC         14745600      /* Main clock frequency */

#endif /* LH79520_MAP_H */ 

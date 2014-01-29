///////////////////////////////////////////////////////////
//  Copyright (c) 1995/2006 Xilinx Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////////
//
//   ____   ___
//  /   /\/   / 
// /___/  \  /    Vendor      : Xilinx 
// \  \    \/     Version     : 11.1
//  \  \          Description : 
//  /  /                      
// /__/   /\      Filename    : X_GTX_DUAL.v
// \  \  /  \     Timestamp   : Tue Jan  9 10:05:08 2007
//  \__\/\__ \                    
//                                 
//  Revision:
//  09/12/06 - CR#423671 - Initial version.
//  12/05/06 - CR#426138 - J.31 spreadsheet update
//  01/23/07 - CR#430426 - J.32 pinTime added
//  02/20/07 - CR#434096 - Parameter default value update PLL_RXDIVSEL_OUT_0/1
//  06/18/07 - CR#441601 - BT1445 - Test attributes made visible 
//  06/18/07 - CR#441576 - BT1488 - Add STEPPING attribute
//  08/02/07 - CR#445080 - Extended setuphold checks to support negative setuphold
//  08/09/07 - CR#445080 - Update assign section to match setuphold _delay to avoid multiple drivers
//  10/05/07 - CR#451343 - BT1514 - Add ES1 (ES1 mapped to 0) as STEPPING value
//  11/05/07 - CR#452590 - BT1514 - Remove STEPPING attribute from unisim/simprim wrapper
//  02/05/08 - CR#459742 - Attribute default changes
//  03/14/08 - CR#468285 - Updated timing checks
//  03/17/08 - CR#467692 - Add SIM_MODE attribute with values LEGACY & FAST model
//  04/24/08 - CR#472011 - OOBDETECT_THRESHOLD_0/1 default from 001 to 110, range changes from 000-111 to 110-111
//  05/13/08 - CR#472931 - OOBDETECT_THRESHOLD_0/1 case statement updates
//  05/19/08 - CR#472395 - Remove GTX_DUAL LEGACY model
//  05/27/08 - CR#472395 - Set SIM_MODE to FAST, Add DRC checks
//////////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

module X_GTX_DUAL (
	DFECLKDLYADJMONITOR0,
	DFECLKDLYADJMONITOR1,
	DFEEYEDACMONITOR0,
	DFEEYEDACMONITOR1,
	DFESENSCAL0,
	DFESENSCAL1,
	DFETAP1MONITOR0,
	DFETAP1MONITOR1,
	DFETAP2MONITOR0,
	DFETAP2MONITOR1,
	DFETAP3MONITOR0,
	DFETAP3MONITOR1,
	DFETAP4MONITOR0,
	DFETAP4MONITOR1,
	DO,
	DRDY,
	PHYSTATUS0,
	PHYSTATUS1,
	PLLLKDET,
	REFCLKOUT,
	RESETDONE0,
	RESETDONE1,
	RXBUFSTATUS0,
	RXBUFSTATUS1,
	RXBYTEISALIGNED0,
	RXBYTEISALIGNED1,
	RXBYTEREALIGN0,
	RXBYTEREALIGN1,
	RXCHANBONDSEQ0,
	RXCHANBONDSEQ1,
	RXCHANISALIGNED0,
	RXCHANISALIGNED1,
	RXCHANREALIGN0,
	RXCHANREALIGN1,
	RXCHARISCOMMA0,
	RXCHARISCOMMA1,
	RXCHARISK0,
	RXCHARISK1,
	RXCHBONDO0,
	RXCHBONDO1,
	RXCLKCORCNT0,
	RXCLKCORCNT1,
	RXCOMMADET0,
	RXCOMMADET1,
	RXDATA0,
	RXDATA1,
	RXDATAVALID0,
	RXDATAVALID1,
	RXDISPERR0,
	RXDISPERR1,
	RXELECIDLE0,
	RXELECIDLE1,
	RXHEADER0,
	RXHEADER1,
	RXHEADERVALID0,
	RXHEADERVALID1,
	RXLOSSOFSYNC0,
	RXLOSSOFSYNC1,
	RXNOTINTABLE0,
	RXNOTINTABLE1,
	RXOVERSAMPLEERR0,
	RXOVERSAMPLEERR1,
	RXPRBSERR0,
	RXPRBSERR1,
	RXRECCLK0,
	RXRECCLK1,
	RXRUNDISP0,
	RXRUNDISP1,
	RXSTARTOFSEQ0,
	RXSTARTOFSEQ1,
	RXSTATUS0,
	RXSTATUS1,
	RXVALID0,
	RXVALID1,
	TXBUFSTATUS0,
	TXBUFSTATUS1,
	TXGEARBOXREADY0,
	TXGEARBOXREADY1,
	TXKERR0,
	TXKERR1,
	TXN0,
	TXN1,
	TXOUTCLK0,
	TXOUTCLK1,
	TXP0,
	TXP1,
	TXRUNDISP0,
	TXRUNDISP1,

	CLKIN,
	DADDR,
	DCLK,
	DEN,
	DFECLKDLYADJ0,
	DFECLKDLYADJ1,
	DFETAP10,
	DFETAP11,
	DFETAP20,
	DFETAP21,
	DFETAP30,
	DFETAP31,
	DFETAP40,
	DFETAP41,
	DI,
	DWE,
	GTXRESET,
	GTXTEST,
	INTDATAWIDTH,
	LOOPBACK0,
	LOOPBACK1,
	PLLLKDETEN,
	PLLPOWERDOWN,
	PRBSCNTRESET0,
	PRBSCNTRESET1,
	REFCLKPWRDNB,
	RXBUFRESET0,
	RXBUFRESET1,
	RXCDRRESET0,
	RXCDRRESET1,
	RXCHBONDI0,
	RXCHBONDI1,
	RXCOMMADETUSE0,
	RXCOMMADETUSE1,
	RXDATAWIDTH0,
	RXDATAWIDTH1,
	RXDEC8B10BUSE0,
	RXDEC8B10BUSE1,
	RXENCHANSYNC0,
	RXENCHANSYNC1,
	RXENEQB0,
	RXENEQB1,
	RXENMCOMMAALIGN0,
	RXENMCOMMAALIGN1,
	RXENPCOMMAALIGN0,
	RXENPCOMMAALIGN1,
	RXENPMAPHASEALIGN0,
	RXENPMAPHASEALIGN1,
	RXENPRBSTST0,
	RXENPRBSTST1,
	RXENSAMPLEALIGN0,
	RXENSAMPLEALIGN1,
	RXEQMIX0,
	RXEQMIX1,
	RXEQPOLE0,
	RXEQPOLE1,
	RXGEARBOXSLIP0,
	RXGEARBOXSLIP1,
	RXN0,
	RXN1,
	RXP0,
	RXP1,
	RXPMASETPHASE0,
	RXPMASETPHASE1,
	RXPOLARITY0,
	RXPOLARITY1,
	RXPOWERDOWN0,
	RXPOWERDOWN1,
	RXRESET0,
	RXRESET1,
	RXSLIDE0,
	RXSLIDE1,
	RXUSRCLK0,
	RXUSRCLK1,
	RXUSRCLK20,
	RXUSRCLK21,
	TXBUFDIFFCTRL0,
	TXBUFDIFFCTRL1,
	TXBYPASS8B10B0,
	TXBYPASS8B10B1,
	TXCHARDISPMODE0,
	TXCHARDISPMODE1,
	TXCHARDISPVAL0,
	TXCHARDISPVAL1,
	TXCHARISK0,
	TXCHARISK1,
	TXCOMSTART0,
	TXCOMSTART1,
	TXCOMTYPE0,
	TXCOMTYPE1,
	TXDATA0,
	TXDATA1,
	TXDATAWIDTH0,
	TXDATAWIDTH1,
	TXDETECTRX0,
	TXDETECTRX1,
	TXDIFFCTRL0,
	TXDIFFCTRL1,
	TXELECIDLE0,
	TXELECIDLE1,
	TXENC8B10BUSE0,
	TXENC8B10BUSE1,
	TXENPMAPHASEALIGN0,
	TXENPMAPHASEALIGN1,
	TXENPRBSTST0,
	TXENPRBSTST1,
	TXHEADER0,
	TXHEADER1,
	TXINHIBIT0,
	TXINHIBIT1,
	TXPMASETPHASE0,
	TXPMASETPHASE1,
	TXPOLARITY0,
	TXPOLARITY1,
	TXPOWERDOWN0,
	TXPOWERDOWN1,
	TXPREEMPHASIS0,
	TXPREEMPHASIS1,
	TXRESET0,
	TXRESET1,
	TXSEQUENCE0,
	TXSEQUENCE1,
	TXSTARTSEQ0,
	TXSTARTSEQ1,
	TXUSRCLK0,
	TXUSRCLK1,
	TXUSRCLK20,
	TXUSRCLK21

);

parameter LOC = "UNPLACED";

parameter AC_CAP_DIS_0 = "TRUE";
parameter AC_CAP_DIS_1 = "TRUE";
parameter CHAN_BOND_KEEP_ALIGN_0 = "FALSE";
parameter CHAN_BOND_KEEP_ALIGN_1 = "FALSE";
parameter CHAN_BOND_MODE_0 = "OFF";
parameter CHAN_BOND_MODE_1 = "OFF";
parameter CHAN_BOND_SEQ_2_USE_0 = "FALSE";
parameter CHAN_BOND_SEQ_2_USE_1 = "FALSE";
parameter CLKINDC_B = "TRUE";
parameter CLKRCV_TRST = "TRUE";
parameter CLK_CORRECT_USE_0 = "TRUE";
parameter CLK_CORRECT_USE_1 = "TRUE";
parameter CLK_COR_INSERT_IDLE_FLAG_0 = "FALSE";
parameter CLK_COR_INSERT_IDLE_FLAG_1 = "FALSE";
parameter CLK_COR_KEEP_IDLE_0 = "FALSE";
parameter CLK_COR_KEEP_IDLE_1 = "FALSE";
parameter CLK_COR_PRECEDENCE_0 = "TRUE";
parameter CLK_COR_PRECEDENCE_1 = "TRUE";
parameter CLK_COR_SEQ_2_USE_0 = "FALSE";
parameter CLK_COR_SEQ_2_USE_1 = "FALSE";
parameter COMMA_DOUBLE_0 = "FALSE";
parameter COMMA_DOUBLE_1 = "FALSE";
parameter DEC_MCOMMA_DETECT_0 = "TRUE";
parameter DEC_MCOMMA_DETECT_1 = "TRUE";
parameter DEC_PCOMMA_DETECT_0 = "TRUE";
parameter DEC_PCOMMA_DETECT_1 = "TRUE";
parameter DEC_VALID_COMMA_ONLY_0 = "TRUE";
parameter DEC_VALID_COMMA_ONLY_1 = "TRUE";
parameter MCOMMA_DETECT_0 = "TRUE";
parameter MCOMMA_DETECT_1 = "TRUE";
parameter OVERSAMPLE_MODE = "FALSE";
parameter PCI_EXPRESS_MODE_0 = "FALSE";
parameter PCI_EXPRESS_MODE_1 = "FALSE";
parameter PCOMMA_DETECT_0 = "TRUE";
parameter PCOMMA_DETECT_1 = "TRUE";
parameter PLL_FB_DCCEN = "FALSE";
parameter PLL_SATA_0 = "FALSE";
parameter PLL_SATA_1 = "FALSE";
parameter RCV_TERM_GND_0 = "FALSE";
parameter RCV_TERM_GND_1 = "FALSE";
parameter RCV_TERM_VTTRX_0 = "FALSE";
parameter RCV_TERM_VTTRX_1 = "FALSE";
parameter RXGEARBOX_USE_0 = "FALSE";
parameter RXGEARBOX_USE_1 = "FALSE";
parameter RX_BUFFER_USE_0 = "TRUE";
parameter RX_BUFFER_USE_1 = "TRUE";
parameter RX_DECODE_SEQ_MATCH_0 = "TRUE";
parameter RX_DECODE_SEQ_MATCH_1 = "TRUE";
parameter RX_EN_IDLE_HOLD_CDR = "FALSE";
parameter RX_EN_IDLE_HOLD_DFE_0 = "TRUE";
parameter RX_EN_IDLE_HOLD_DFE_1 = "TRUE";
parameter RX_EN_IDLE_RESET_BUF_0 = "TRUE";
parameter RX_EN_IDLE_RESET_BUF_1 = "TRUE";
parameter RX_EN_IDLE_RESET_FR = "TRUE";
parameter RX_EN_IDLE_RESET_PH = "TRUE";
parameter RX_LOSS_OF_SYNC_FSM_0 = "FALSE";
parameter RX_LOSS_OF_SYNC_FSM_1 = "FALSE";
parameter RX_SLIDE_MODE_0 = "PCS";
parameter RX_SLIDE_MODE_1 = "PCS";
parameter RX_STATUS_FMT_0 = "PCIE";
parameter RX_STATUS_FMT_1 = "PCIE";
parameter RX_XCLK_SEL_0 = "RXREC";
parameter RX_XCLK_SEL_1 = "RXREC";
parameter SIM_MODE = "FAST";
parameter SIM_PLL_PERDIV2 = 9'h140;
parameter SIM_RECEIVER_DETECT_PASS_0 = "TRUE";
parameter SIM_RECEIVER_DETECT_PASS_1 = "TRUE";
parameter TERMINATION_OVRD = "FALSE";
parameter TXGEARBOX_USE_0 = "FALSE";
parameter TXGEARBOX_USE_1 = "FALSE";
parameter TX_BUFFER_USE_0 = "TRUE";
parameter TX_BUFFER_USE_1 = "TRUE";
parameter TX_XCLK_SEL_0 = "TXOUT";
parameter TX_XCLK_SEL_1 = "TXOUT";
parameter [11:0] TRANS_TIME_FROM_P2_0 = 12'h03c;
parameter [11:0] TRANS_TIME_FROM_P2_1 = 12'h03c;
parameter [13:0] TX_DETECT_RX_CFG_0 = 14'h1832;
parameter [13:0] TX_DETECT_RX_CFG_1 = 14'h1832;
parameter [19:0] PMA_TX_CFG_0 = 20'h80082;
parameter [19:0] PMA_TX_CFG_1 = 20'h80082;
parameter [1:0] CM_TRIM_0 = 2'b10;
parameter [1:0] CM_TRIM_1 = 2'b10;
parameter [23:0] PLL_COM_CFG = 24'h21680a;
parameter [24:0] PMA_RX_CFG_0 = 25'h0f44089;
parameter [24:0] PMA_RX_CFG_1 = 25'h0f44089;
parameter [26:0] PMA_CDR_SCAN_0 = 27'h6404035;
parameter [26:0] PMA_CDR_SCAN_1 = 27'h6404035;
parameter [2:0] GEARBOX_ENDEC_0 = 3'b000;
parameter [2:0] GEARBOX_ENDEC_1 = 3'b000;
parameter [2:0] OOBDETECT_THRESHOLD_0 = 3'b110;
parameter [2:0] OOBDETECT_THRESHOLD_1 = 3'b110;
parameter [2:0] PLL_LKDET_CFG = 3'b101;
parameter [2:0] PLL_TDCC_CFG = 3'b000;
parameter [2:0] SATA_BURST_VAL_0 = 3'b100;
parameter [2:0] SATA_BURST_VAL_1 = 3'b100;
parameter [2:0] SATA_IDLE_VAL_0 = 3'b100;
parameter [2:0] SATA_IDLE_VAL_1 = 3'b100;
parameter [2:0] TXRX_INVERT_0 = 3'b011;
parameter [2:0] TXRX_INVERT_1 = 3'b011;
parameter [2:0] TX_IDLE_DELAY_0 = 3'b010;
parameter [2:0] TX_IDLE_DELAY_1 = 3'b010;
parameter [31:0] PRBS_ERR_THRESHOLD_0 = 32'h00000001;
parameter [31:0] PRBS_ERR_THRESHOLD_1 = 32'h00000001;
parameter [3:0] CHAN_BOND_SEQ_1_ENABLE_0 = 4'b0001;
parameter [3:0] CHAN_BOND_SEQ_1_ENABLE_1 = 4'b0001;
parameter [3:0] CHAN_BOND_SEQ_2_ENABLE_0 = 4'b0000;
parameter [3:0] CHAN_BOND_SEQ_2_ENABLE_1 = 4'b0000;
parameter [3:0] CLK_COR_SEQ_1_ENABLE_0 = 4'b0001;
parameter [3:0] CLK_COR_SEQ_1_ENABLE_1 = 4'b0001;
parameter [3:0] CLK_COR_SEQ_2_ENABLE_0 = 4'b0000;
parameter [3:0] CLK_COR_SEQ_2_ENABLE_1 = 4'b0000;
parameter [3:0] COM_BURST_VAL_0 = 4'b1111;
parameter [3:0] COM_BURST_VAL_1 = 4'b1111;
parameter [3:0] RX_IDLE_HI_CNT_0 = 4'b1000;
parameter [3:0] RX_IDLE_HI_CNT_1 = 4'b1000;
parameter [3:0] RX_IDLE_LO_CNT_0 = 4'b0000;
parameter [3:0] RX_IDLE_LO_CNT_1 = 4'b0000;
parameter [4:0] CDR_PH_ADJ_TIME = 5'b01010;
parameter [4:0] DFE_CAL_TIME = 5'b00110;
parameter [4:0] TERMINATION_CTRL = 5'b10100;
parameter [68:0] PMA_COM_CFG = 69'h0;
parameter [6:0] PMA_RXSYNC_CFG_0 = 7'h0;
parameter [6:0] PMA_RXSYNC_CFG_1 = 7'h0;
parameter [7:0] PLL_CP_CFG = 8'h00;
parameter [7:0] TRANS_TIME_NON_P2_0 = 8'h19;
parameter [7:0] TRANS_TIME_NON_P2_1 = 8'h19;
parameter [9:0] CHAN_BOND_SEQ_1_1_0 = 10'b0101111100;
parameter [9:0] CHAN_BOND_SEQ_1_1_1 = 10'b0101111100;
parameter [9:0] CHAN_BOND_SEQ_1_2_0 = 10'b0000000000;
parameter [9:0] CHAN_BOND_SEQ_1_2_1 = 10'b0000000000;
parameter [9:0] CHAN_BOND_SEQ_1_3_0 = 10'b0000000000;
parameter [9:0] CHAN_BOND_SEQ_1_3_1 = 10'b0000000000;
parameter [9:0] CHAN_BOND_SEQ_1_4_0 = 10'b0000000000;
parameter [9:0] CHAN_BOND_SEQ_1_4_1 = 10'b0000000000;
parameter [9:0] CHAN_BOND_SEQ_2_1_0 = 10'b0000000000;
parameter [9:0] CHAN_BOND_SEQ_2_1_1 = 10'b0000000000;
parameter [9:0] CHAN_BOND_SEQ_2_2_0 = 10'b0000000000;
parameter [9:0] CHAN_BOND_SEQ_2_2_1 = 10'b0000000000;
parameter [9:0] CHAN_BOND_SEQ_2_3_0 = 10'b0000000000;
parameter [9:0] CHAN_BOND_SEQ_2_3_1 = 10'b0000000000;
parameter [9:0] CHAN_BOND_SEQ_2_4_0 = 10'b0000000000;
parameter [9:0] CHAN_BOND_SEQ_2_4_1 = 10'b0000000000;
parameter [9:0] CLK_COR_SEQ_1_1_0 = 10'b0100011100;
parameter [9:0] CLK_COR_SEQ_1_1_1 = 10'b0100011100;
parameter [9:0] CLK_COR_SEQ_1_2_0 = 10'b0000000000;
parameter [9:0] CLK_COR_SEQ_1_2_1 = 10'b0000000000;
parameter [9:0] CLK_COR_SEQ_1_3_0 = 10'b0000000000;
parameter [9:0] CLK_COR_SEQ_1_3_1 = 10'b0000000000;
parameter [9:0] CLK_COR_SEQ_1_4_0 = 10'b0000000000;
parameter [9:0] CLK_COR_SEQ_1_4_1 = 10'b0000000000;
parameter [9:0] CLK_COR_SEQ_2_1_0 = 10'b0000000000;
parameter [9:0] CLK_COR_SEQ_2_1_1 = 10'b0000000000;
parameter [9:0] CLK_COR_SEQ_2_2_0 = 10'b0000000000;
parameter [9:0] CLK_COR_SEQ_2_2_1 = 10'b0000000000;
parameter [9:0] CLK_COR_SEQ_2_3_0 = 10'b0000000000;
parameter [9:0] CLK_COR_SEQ_2_3_1 = 10'b0000000000;
parameter [9:0] CLK_COR_SEQ_2_4_0 = 10'b0000000000;
parameter [9:0] CLK_COR_SEQ_2_4_1 = 10'b0000000000;
parameter [9:0] COMMA_10B_ENABLE_0 = 10'b0001111111;
parameter [9:0] COMMA_10B_ENABLE_1 = 10'b0001111111;
parameter [9:0] DFE_CFG_0 = 10'b1101111011;
parameter [9:0] DFE_CFG_1 = 10'b1101111011;
parameter [9:0] MCOMMA_10B_VALUE_0 = 10'b1010000011;
parameter [9:0] MCOMMA_10B_VALUE_1 = 10'b1010000011;
parameter [9:0] PCOMMA_10B_VALUE_0 = 10'b0101111100;
parameter [9:0] PCOMMA_10B_VALUE_1 = 10'b0101111100;
parameter [9:0] TRANS_TIME_TO_P2_0 = 10'h064;
parameter [9:0] TRANS_TIME_TO_P2_1 = 10'h064;
parameter integer ALIGN_COMMA_WORD_0 = 1;
parameter integer ALIGN_COMMA_WORD_1 = 1;
parameter integer CB2_INH_CC_PERIOD_0 = 8;
parameter integer CB2_INH_CC_PERIOD_1 = 8;
parameter integer CHAN_BOND_1_MAX_SKEW_0 = 7;
parameter integer CHAN_BOND_1_MAX_SKEW_1 = 7;
parameter integer CHAN_BOND_2_MAX_SKEW_0 = 7;
parameter integer CHAN_BOND_2_MAX_SKEW_1 = 7;
parameter integer CHAN_BOND_LEVEL_0 = 0;
parameter integer CHAN_BOND_LEVEL_1 = 0;
parameter integer CHAN_BOND_SEQ_LEN_0 = 1;
parameter integer CHAN_BOND_SEQ_LEN_1 = 1;
parameter integer CLK25_DIVIDER = 10;
parameter integer CLK_COR_ADJ_LEN_0 = 1;
parameter integer CLK_COR_ADJ_LEN_1 = 1;
parameter integer CLK_COR_DET_LEN_0 = 1;
parameter integer CLK_COR_DET_LEN_1 = 1;
parameter integer CLK_COR_MAX_LAT_0 = 20;
parameter integer CLK_COR_MAX_LAT_1 = 20;
parameter integer CLK_COR_MIN_LAT_0 = 18;
parameter integer CLK_COR_MIN_LAT_1 = 18;
parameter integer CLK_COR_REPEAT_WAIT_0 = 0;
parameter integer CLK_COR_REPEAT_WAIT_1 = 0;
parameter integer OOB_CLK_DIVIDER = 6;
parameter integer PLL_DIVSEL_FB = 2;
parameter integer PLL_DIVSEL_REF = 1;
parameter integer PLL_RXDIVSEL_OUT_0 = 1;
parameter integer PLL_RXDIVSEL_OUT_1 = 1;
parameter integer PLL_TXDIVSEL_OUT_0 = 1;
parameter integer PLL_TXDIVSEL_OUT_1 = 1;
parameter integer RX_LOS_INVALID_INCR_0 = 1;
parameter integer RX_LOS_INVALID_INCR_1 = 1;
parameter integer RX_LOS_THRESHOLD_0 = 4;
parameter integer RX_LOS_THRESHOLD_1 = 4;
parameter integer SATA_MAX_BURST_0 = 7;
parameter integer SATA_MAX_BURST_1 = 7;
parameter integer SATA_MAX_INIT_0 = 22;
parameter integer SATA_MAX_INIT_1 = 22;
parameter integer SATA_MAX_WAKE_0 = 7;
parameter integer SATA_MAX_WAKE_1 = 7;
parameter integer SATA_MIN_BURST_0 = 4;
parameter integer SATA_MIN_BURST_1 = 4;
parameter integer SATA_MIN_INIT_0 = 12;
parameter integer SATA_MIN_INIT_1 = 12;
parameter integer SATA_MIN_WAKE_0 = 4;
parameter integer SATA_MIN_WAKE_1 = 4;
parameter integer SIM_GTXRESET_SPEEDUP = 1;
parameter integer TERMINATION_IMP_0 = 50;
parameter integer TERMINATION_IMP_1 = 50;

localparam in_delay =  0;
localparam out_delay = 0;
localparam CLK_DELAY = 0;

output DRDY;
output PHYSTATUS0;
output PHYSTATUS1;
output PLLLKDET;
output REFCLKOUT;
output RESETDONE0;
output RESETDONE1;
output RXBYTEISALIGNED0;
output RXBYTEISALIGNED1;
output RXBYTEREALIGN0;
output RXBYTEREALIGN1;
output RXCHANBONDSEQ0;
output RXCHANBONDSEQ1;
output RXCHANISALIGNED0;
output RXCHANISALIGNED1;
output RXCHANREALIGN0;
output RXCHANREALIGN1;
output RXCOMMADET0;
output RXCOMMADET1;
output RXDATAVALID0;
output RXDATAVALID1;
output RXELECIDLE0;
output RXELECIDLE1;
output RXHEADERVALID0;
output RXHEADERVALID1;
output RXOVERSAMPLEERR0;
output RXOVERSAMPLEERR1;
output RXPRBSERR0;
output RXPRBSERR1;
output RXRECCLK0;
output RXRECCLK1;
output RXSTARTOFSEQ0;
output RXSTARTOFSEQ1;
output RXVALID0;
output RXVALID1;
output TXGEARBOXREADY0;
output TXGEARBOXREADY1;
output TXN0;
output TXN1;
output TXOUTCLK0;
output TXOUTCLK1;
output TXP0;
output TXP1;
output [15:0] DO;
output [1:0] RXLOSSOFSYNC0;
output [1:0] RXLOSSOFSYNC1;
output [1:0] TXBUFSTATUS0;
output [1:0] TXBUFSTATUS1;
output [2:0] DFESENSCAL0;
output [2:0] DFESENSCAL1;
output [2:0] RXBUFSTATUS0;
output [2:0] RXBUFSTATUS1;
output [2:0] RXCLKCORCNT0;
output [2:0] RXCLKCORCNT1;
output [2:0] RXHEADER0;
output [2:0] RXHEADER1;
output [2:0] RXSTATUS0;
output [2:0] RXSTATUS1;
output [31:0] RXDATA0;
output [31:0] RXDATA1;
output [3:0] DFETAP3MONITOR0;
output [3:0] DFETAP3MONITOR1;
output [3:0] DFETAP4MONITOR0;
output [3:0] DFETAP4MONITOR1;
output [3:0] RXCHARISCOMMA0;
output [3:0] RXCHARISCOMMA1;
output [3:0] RXCHARISK0;
output [3:0] RXCHARISK1;
output [3:0] RXCHBONDO0;
output [3:0] RXCHBONDO1;
output [3:0] RXDISPERR0;
output [3:0] RXDISPERR1;
output [3:0] RXNOTINTABLE0;
output [3:0] RXNOTINTABLE1;
output [3:0] RXRUNDISP0;
output [3:0] RXRUNDISP1;
output [3:0] TXKERR0;
output [3:0] TXKERR1;
output [3:0] TXRUNDISP0;
output [3:0] TXRUNDISP1;
output [4:0] DFEEYEDACMONITOR0;
output [4:0] DFEEYEDACMONITOR1;
output [4:0] DFETAP1MONITOR0;
output [4:0] DFETAP1MONITOR1;
output [4:0] DFETAP2MONITOR0;
output [4:0] DFETAP2MONITOR1;
output [5:0] DFECLKDLYADJMONITOR0;
output [5:0] DFECLKDLYADJMONITOR1;

input CLKIN;
input DCLK;
input DEN;
input DWE;
input GTXRESET;
input INTDATAWIDTH;
input PLLLKDETEN;
input PLLPOWERDOWN;
input PRBSCNTRESET0;
input PRBSCNTRESET1;
input REFCLKPWRDNB;
input RXBUFRESET0;
input RXBUFRESET1;
input RXCDRRESET0;
input RXCDRRESET1;
input RXCOMMADETUSE0;
input RXCOMMADETUSE1;
input RXDEC8B10BUSE0;
input RXDEC8B10BUSE1;
input RXENCHANSYNC0;
input RXENCHANSYNC1;
input RXENEQB0;
input RXENEQB1;
input RXENMCOMMAALIGN0;
input RXENMCOMMAALIGN1;
input RXENPCOMMAALIGN0;
input RXENPCOMMAALIGN1;
input RXENPMAPHASEALIGN0;
input RXENPMAPHASEALIGN1;
input RXENSAMPLEALIGN0;
input RXENSAMPLEALIGN1;
input RXGEARBOXSLIP0;
input RXGEARBOXSLIP1;
input RXN0;
input RXN1;
input RXP0;
input RXP1;
input RXPMASETPHASE0;
input RXPMASETPHASE1;
input RXPOLARITY0;
input RXPOLARITY1;
input RXRESET0;
input RXRESET1;
input RXSLIDE0;
input RXSLIDE1;
input RXUSRCLK0;
input RXUSRCLK1;
input RXUSRCLK20;
input RXUSRCLK21;
input TXCOMSTART0;
input TXCOMSTART1;
input TXCOMTYPE0;
input TXCOMTYPE1;
input TXDETECTRX0;
input TXDETECTRX1;
input TXELECIDLE0;
input TXELECIDLE1;
input TXENC8B10BUSE0;
input TXENC8B10BUSE1;
input TXENPMAPHASEALIGN0;
input TXENPMAPHASEALIGN1;
input TXINHIBIT0;
input TXINHIBIT1;
input TXPMASETPHASE0;
input TXPMASETPHASE1;
input TXPOLARITY0;
input TXPOLARITY1;
input TXRESET0;
input TXRESET1;
input TXSTARTSEQ0;
input TXSTARTSEQ1;
input TXUSRCLK0;
input TXUSRCLK1;
input TXUSRCLK20;
input TXUSRCLK21;
input [13:0] GTXTEST;
input [15:0] DI;
input [1:0] RXDATAWIDTH0;
input [1:0] RXDATAWIDTH1;
input [1:0] RXENPRBSTST0;
input [1:0] RXENPRBSTST1;
input [1:0] RXEQMIX0;
input [1:0] RXEQMIX1;
input [1:0] RXPOWERDOWN0;
input [1:0] RXPOWERDOWN1;
input [1:0] TXDATAWIDTH0;
input [1:0] TXDATAWIDTH1;
input [1:0] TXENPRBSTST0;
input [1:0] TXENPRBSTST1;
input [1:0] TXPOWERDOWN0;
input [1:0] TXPOWERDOWN1;
input [2:0] LOOPBACK0;
input [2:0] LOOPBACK1;
input [2:0] TXBUFDIFFCTRL0;
input [2:0] TXBUFDIFFCTRL1;
input [2:0] TXDIFFCTRL0;
input [2:0] TXDIFFCTRL1;
input [2:0] TXHEADER0;
input [2:0] TXHEADER1;
input [31:0] TXDATA0;
input [31:0] TXDATA1;
input [3:0] DFETAP30;
input [3:0] DFETAP31;
input [3:0] DFETAP40;
input [3:0] DFETAP41;
input [3:0] RXCHBONDI0;
input [3:0] RXCHBONDI1;
input [3:0] RXEQPOLE0;
input [3:0] RXEQPOLE1;
input [3:0] TXBYPASS8B10B0;
input [3:0] TXBYPASS8B10B1;
input [3:0] TXCHARDISPMODE0;
input [3:0] TXCHARDISPMODE1;
input [3:0] TXCHARDISPVAL0;
input [3:0] TXCHARDISPVAL1;
input [3:0] TXCHARISK0;
input [3:0] TXCHARISK1;
input [3:0] TXPREEMPHASIS0;
input [3:0] TXPREEMPHASIS1;
input [4:0] DFETAP10;
input [4:0] DFETAP11;
input [4:0] DFETAP20;
input [4:0] DFETAP21;
input [5:0] DFECLKDLYADJ0;
input [5:0] DFECLKDLYADJ1;
input [6:0] DADDR;
input [6:0] TXSEQUENCE0;
input [6:0] TXSEQUENCE1;

reg AC_CAP_DIS_0_BINARY;
reg AC_CAP_DIS_1_BINARY;
reg ALIGN_COMMA_WORD_0_BINARY;
reg ALIGN_COMMA_WORD_1_BINARY;
reg CHAN_BOND_KEEP_ALIGN_0_BINARY;
reg CHAN_BOND_KEEP_ALIGN_1_BINARY;
reg [1:0] CHAN_BOND_MODE_0_BINARY;
reg [1:0] CHAN_BOND_MODE_1_BINARY;
reg CHAN_BOND_SEQ_2_USE_0_BINARY;
reg CHAN_BOND_SEQ_2_USE_1_BINARY;
reg CLKINDC_B_BINARY;
reg CLKRCV_TRST_BINARY;
reg CLK_CORRECT_USE_0_BINARY;
reg CLK_CORRECT_USE_1_BINARY;
reg CLK_COR_INSERT_IDLE_FLAG_0_BINARY;
reg CLK_COR_INSERT_IDLE_FLAG_1_BINARY;
reg CLK_COR_KEEP_IDLE_0_BINARY;
reg CLK_COR_KEEP_IDLE_1_BINARY;
reg CLK_COR_PRECEDENCE_0_BINARY;
reg CLK_COR_PRECEDENCE_1_BINARY;
reg CLK_COR_SEQ_2_USE_0_BINARY;
reg CLK_COR_SEQ_2_USE_1_BINARY;
reg COMMA_DOUBLE_0_BINARY;
reg COMMA_DOUBLE_1_BINARY;
reg DEC_MCOMMA_DETECT_0_BINARY;
reg DEC_MCOMMA_DETECT_1_BINARY;
reg DEC_PCOMMA_DETECT_0_BINARY;
reg DEC_PCOMMA_DETECT_1_BINARY;
reg DEC_VALID_COMMA_ONLY_0_BINARY;
reg DEC_VALID_COMMA_ONLY_1_BINARY;
reg MCOMMA_DETECT_0_BINARY;
reg MCOMMA_DETECT_1_BINARY;
reg OVERSAMPLE_MODE_BINARY;
reg PCI_EXPRESS_MODE_0_BINARY;
reg PCI_EXPRESS_MODE_1_BINARY;
reg PCOMMA_DETECT_0_BINARY;
reg PCOMMA_DETECT_1_BINARY;
reg PLL_FB_DCCEN_BINARY;
reg PLL_SATA_0_BINARY;
reg PLL_SATA_1_BINARY;
reg RCV_TERM_GND_0_BINARY;
reg RCV_TERM_GND_1_BINARY;
reg RCV_TERM_VTTRX_0_BINARY;
reg RCV_TERM_VTTRX_1_BINARY;
reg RXGEARBOX_USE_0_BINARY;
reg RXGEARBOX_USE_1_BINARY;
reg RX_BUFFER_USE_0_BINARY;
reg RX_BUFFER_USE_1_BINARY;
reg RX_DECODE_SEQ_MATCH_0_BINARY;
reg RX_DECODE_SEQ_MATCH_1_BINARY;
reg RX_EN_IDLE_HOLD_CDR_BINARY;
reg RX_EN_IDLE_HOLD_DFE_0_BINARY;
reg RX_EN_IDLE_HOLD_DFE_1_BINARY;
reg RX_EN_IDLE_RESET_BUF_0_BINARY;
reg RX_EN_IDLE_RESET_BUF_1_BINARY;
reg RX_EN_IDLE_RESET_FR_BINARY;
reg RX_EN_IDLE_RESET_PH_BINARY;
reg RX_LOSS_OF_SYNC_FSM_0_BINARY;
reg RX_LOSS_OF_SYNC_FSM_1_BINARY;
reg RX_SLIDE_MODE_0_BINARY;
reg RX_SLIDE_MODE_1_BINARY;
reg RX_STATUS_FMT_0_BINARY;
reg RX_STATUS_FMT_1_BINARY;
reg RX_XCLK_SEL_0_BINARY;
reg RX_XCLK_SEL_1_BINARY;
reg SIM_GTXRESET_SPEEDUP_BINARY;
reg SIM_MODE_BINARY;
reg SIM_RECEIVER_DETECT_PASS_0_BINARY;
reg SIM_RECEIVER_DETECT_PASS_1_BINARY;
reg TERMINATION_IMP_0_BINARY;
reg TERMINATION_IMP_1_BINARY;
reg TERMINATION_OVRD_BINARY;
reg TXGEARBOX_USE_0_BINARY;
reg TXGEARBOX_USE_1_BINARY;
reg TX_BUFFER_USE_0_BINARY;
reg TX_BUFFER_USE_1_BINARY;
reg TX_XCLK_SEL_0_BINARY;
reg TX_XCLK_SEL_1_BINARY;
reg [1:0] CHAN_BOND_SEQ_LEN_0_BINARY;
reg [1:0] CHAN_BOND_SEQ_LEN_1_BINARY;
reg [1:0] CLK_COR_ADJ_LEN_0_BINARY;
reg [1:0] CLK_COR_ADJ_LEN_1_BINARY;
reg [1:0] CLK_COR_DET_LEN_0_BINARY;
reg [1:0] CLK_COR_DET_LEN_1_BINARY;
reg [1:0] PLL_RXDIVSEL_OUT_0_BINARY;
reg [1:0] PLL_RXDIVSEL_OUT_1_BINARY;
reg [1:0] PLL_TXDIVSEL_OUT_0_BINARY;
reg [1:0] PLL_TXDIVSEL_OUT_1_BINARY;
reg [2:0] CHAN_BOND_LEVEL_0_BINARY;
reg [2:0] CHAN_BOND_LEVEL_1_BINARY;
reg [2:0] CLK25_DIVIDER_BINARY;
reg [2:0] OOB_CLK_DIVIDER_BINARY;
reg [2:0] OOBDETECT_THRESHOLD_0_BINARY;
reg [2:0] OOBDETECT_THRESHOLD_1_BINARY;
reg [2:0] RX_LOS_INVALID_INCR_0_BINARY;
reg [2:0] RX_LOS_INVALID_INCR_1_BINARY;
reg [2:0] RX_LOS_THRESHOLD_0_BINARY;
reg [2:0] RX_LOS_THRESHOLD_1_BINARY;
reg [3:0] CB2_INH_CC_PERIOD_0_BINARY;
reg [3:0] CB2_INH_CC_PERIOD_1_BINARY;
reg [3:0] CHAN_BOND_1_MAX_SKEW_0_BINARY;
reg [3:0] CHAN_BOND_1_MAX_SKEW_1_BINARY;
reg [3:0] CHAN_BOND_2_MAX_SKEW_0_BINARY;
reg [3:0] CHAN_BOND_2_MAX_SKEW_1_BINARY;
reg [4:0] CLK_COR_REPEAT_WAIT_0_BINARY;
reg [4:0] CLK_COR_REPEAT_WAIT_1_BINARY;
reg [4:0] PLL_DIVSEL_FB_BINARY;
reg [5:0] CLK_COR_MAX_LAT_0_BINARY;
reg [5:0] CLK_COR_MAX_LAT_1_BINARY;
reg [5:0] CLK_COR_MIN_LAT_0_BINARY;
reg [5:0] CLK_COR_MIN_LAT_1_BINARY;
reg [5:0] PLL_DIVSEL_REF_BINARY;
reg [5:0] SATA_MAX_BURST_0_BINARY;
reg [5:0] SATA_MAX_BURST_1_BINARY;
reg [5:0] SATA_MAX_INIT_0_BINARY;
reg [5:0] SATA_MAX_INIT_1_BINARY;
reg [5:0] SATA_MAX_WAKE_0_BINARY;
reg [5:0] SATA_MAX_WAKE_1_BINARY;
reg [5:0] SATA_MIN_BURST_0_BINARY;
reg [5:0] SATA_MIN_BURST_1_BINARY;
reg [5:0] SATA_MIN_INIT_0_BINARY;
reg [5:0] SATA_MIN_INIT_1_BINARY;
reg [5:0] SATA_MIN_WAKE_0_BINARY;
reg [5:0] SATA_MIN_WAKE_1_BINARY;

tri0 GSR = glbl.GSR;
reg notifier;

wire DRDY_OUT;
wire PHYSTATUS0_OUT;
wire PHYSTATUS1_OUT;
wire PLLLKDET_OUT;
wire REFCLKOUT_OUT;
wire RESETDONE0_OUT;
wire RESETDONE1_OUT;
wire RXBYTEISALIGNED0_OUT;
wire RXBYTEISALIGNED1_OUT;
wire RXBYTEREALIGN0_OUT;
wire RXBYTEREALIGN1_OUT;
wire RXCHANBONDSEQ0_OUT;
wire RXCHANBONDSEQ1_OUT;
wire RXCHANISALIGNED0_OUT;
wire RXCHANISALIGNED1_OUT;
wire RXCHANREALIGN0_OUT;
wire RXCHANREALIGN1_OUT;
wire RXCOMMADET0_OUT;
wire RXCOMMADET1_OUT;
wire RXDATAVALID0_OUT;
wire RXDATAVALID1_OUT;
wire RXELECIDLE0_OUT;
wire RXELECIDLE1_OUT;
wire RXHEADERVALID0_OUT;
wire RXHEADERVALID1_OUT;
wire RXOVERSAMPLEERR0_OUT;
wire RXOVERSAMPLEERR1_OUT;
wire RXPRBSERR0_OUT;
wire RXPRBSERR1_OUT;
wire RXRECCLK0_OUT;
wire RXRECCLK1_OUT;
wire RXSTARTOFSEQ0_OUT;
wire RXSTARTOFSEQ1_OUT;
wire RXVALID0_OUT;
wire RXVALID1_OUT;
wire TXGEARBOXREADY0_OUT;
wire TXGEARBOXREADY1_OUT;
wire TXN0_OUT;
wire TXN1_OUT;
wire TXOUTCLK0_OUT;
wire TXOUTCLK1_OUT;
wire TXP0_OUT;
wire TXP1_OUT;
wire [15:0] DO_OUT;
wire [1:0] RXLOSSOFSYNC0_OUT;
wire [1:0] RXLOSSOFSYNC1_OUT;
wire [1:0] TXBUFSTATUS0_OUT;
wire [1:0] TXBUFSTATUS1_OUT;
wire [2:0] DFESENSCAL0_OUT;
wire [2:0] DFESENSCAL1_OUT;
wire [2:0] RXBUFSTATUS0_OUT;
wire [2:0] RXBUFSTATUS1_OUT;
wire [2:0] RXCLKCORCNT0_OUT;
wire [2:0] RXCLKCORCNT1_OUT;
wire [2:0] RXHEADER0_OUT;
wire [2:0] RXHEADER1_OUT;
wire [2:0] RXSTATUS0_OUT;
wire [2:0] RXSTATUS1_OUT;
wire [31:0] RXDATA0_OUT;
wire [31:0] RXDATA1_OUT;
wire [3:0] DFETAP3MONITOR0_OUT;
wire [3:0] DFETAP3MONITOR1_OUT;
wire [3:0] DFETAP4MONITOR0_OUT;
wire [3:0] DFETAP4MONITOR1_OUT;
wire [3:0] RXCHARISCOMMA0_OUT;
wire [3:0] RXCHARISCOMMA1_OUT;
wire [3:0] RXCHARISK0_OUT;
wire [3:0] RXCHARISK1_OUT;
wire [3:0] RXCHBONDO0_OUT;
wire [3:0] RXCHBONDO1_OUT;
wire [3:0] RXDISPERR0_OUT;
wire [3:0] RXDISPERR1_OUT;
wire [3:0] RXNOTINTABLE0_OUT;
wire [3:0] RXNOTINTABLE1_OUT;
wire [3:0] RXRUNDISP0_OUT;
wire [3:0] RXRUNDISP1_OUT;
wire [3:0] TXKERR0_OUT;
wire [3:0] TXKERR1_OUT;
wire [3:0] TXRUNDISP0_OUT;
wire [3:0] TXRUNDISP1_OUT;
wire [4:0] DFEEYEDACMONITOR0_OUT;
wire [4:0] DFEEYEDACMONITOR1_OUT;
wire [4:0] DFETAP1MONITOR0_OUT;
wire [4:0] DFETAP1MONITOR1_OUT;
wire [4:0] DFETAP2MONITOR0_OUT;
wire [4:0] DFETAP2MONITOR1_OUT;
wire [5:0] DFECLKDLYADJMONITOR0_OUT;
wire [5:0] DFECLKDLYADJMONITOR1_OUT;

wire CLKIN_IN;
wire DCLK_IN;
wire DEN_IN;
wire DWE_IN;
wire GTXRESET_IN;
wire INTDATAWIDTH_IN;
wire PLLLKDETEN_IN;
wire PLLPOWERDOWN_IN;
wire PRBSCNTRESET0_IN;
wire PRBSCNTRESET1_IN;
wire REFCLKPWRDNB_IN;
wire RXBUFRESET0_IN;
wire RXBUFRESET1_IN;
wire RXCDRRESET0_IN;
wire RXCDRRESET1_IN;
wire RXCOMMADETUSE0_IN;
wire RXCOMMADETUSE1_IN;
wire RXDEC8B10BUSE0_IN;
wire RXDEC8B10BUSE1_IN;
wire RXENCHANSYNC0_IN;
wire RXENCHANSYNC1_IN;
wire RXENEQB0_IN;
wire RXENEQB1_IN;
wire RXENMCOMMAALIGN0_IN;
wire RXENMCOMMAALIGN1_IN;
wire RXENPCOMMAALIGN0_IN;
wire RXENPCOMMAALIGN1_IN;
wire RXENPMAPHASEALIGN0_IN;
wire RXENPMAPHASEALIGN1_IN;
wire RXENSAMPLEALIGN0_IN;
wire RXENSAMPLEALIGN1_IN;
wire RXGEARBOXSLIP0_IN;
wire RXGEARBOXSLIP1_IN;
wire RXN0_IN;
wire RXN1_IN;
wire RXP0_IN;
wire RXP1_IN;
wire RXPMASETPHASE0_IN;
wire RXPMASETPHASE1_IN;
wire RXPOLARITY0_IN;
wire RXPOLARITY1_IN;
wire RXRESET0_IN;
wire RXRESET1_IN;
wire RXSLIDE0_IN;
wire RXSLIDE1_IN;
wire RXUSRCLK0_IN;
wire RXUSRCLK1_IN;
wire RXUSRCLK20_IN;
wire RXUSRCLK21_IN;
wire TXCOMSTART0_IN;
wire TXCOMSTART1_IN;
wire TXCOMTYPE0_IN;
wire TXCOMTYPE1_IN;
wire TXDETECTRX0_IN;
wire TXDETECTRX1_IN;
wire TXELECIDLE0_IN;
wire TXELECIDLE1_IN;
wire TXENC8B10BUSE0_IN;
wire TXENC8B10BUSE1_IN;
wire TXENPMAPHASEALIGN0_IN;
wire TXENPMAPHASEALIGN1_IN;
wire TXINHIBIT0_IN;
wire TXINHIBIT1_IN;
wire TXPMASETPHASE0_IN;
wire TXPMASETPHASE1_IN;
wire TXPOLARITY0_IN;
wire TXPOLARITY1_IN;
wire TXRESET0_IN;
wire TXRESET1_IN;
wire TXSTARTSEQ0_IN;
wire TXSTARTSEQ1_IN;
wire TXUSRCLK0_IN;
wire TXUSRCLK1_IN;
wire TXUSRCLK20_IN;
wire TXUSRCLK21_IN;
wire [13:0] GTXTEST_IN;
wire [15:0] DI_IN;
wire [1:0] RXDATAWIDTH0_IN;
wire [1:0] RXDATAWIDTH1_IN;
wire [1:0] RXENPRBSTST0_IN;
wire [1:0] RXENPRBSTST1_IN;
wire [1:0] RXEQMIX0_IN;
wire [1:0] RXEQMIX1_IN;
wire [1:0] RXPOWERDOWN0_IN;
wire [1:0] RXPOWERDOWN1_IN;
wire [1:0] TXDATAWIDTH0_IN;
wire [1:0] TXDATAWIDTH1_IN;
wire [1:0] TXENPRBSTST0_IN;
wire [1:0] TXENPRBSTST1_IN;
wire [1:0] TXPOWERDOWN0_IN;
wire [1:0] TXPOWERDOWN1_IN;
wire [2:0] LOOPBACK0_IN;
wire [2:0] LOOPBACK1_IN;
wire [2:0] TXBUFDIFFCTRL0_IN;
wire [2:0] TXBUFDIFFCTRL1_IN;
wire [2:0] TXDIFFCTRL0_IN;
wire [2:0] TXDIFFCTRL1_IN;
wire [2:0] TXHEADER0_IN;
wire [2:0] TXHEADER1_IN;
wire [31:0] TXDATA0_IN;
wire [31:0] TXDATA1_IN;
wire [3:0] DFETAP30_IN;
wire [3:0] DFETAP31_IN;
wire [3:0] DFETAP40_IN;
wire [3:0] DFETAP41_IN;
wire [3:0] RXCHBONDI0_IN;
wire [3:0] RXCHBONDI1_IN;
wire [3:0] RXEQPOLE0_IN;
wire [3:0] RXEQPOLE1_IN;
wire [3:0] TXBYPASS8B10B0_IN;
wire [3:0] TXBYPASS8B10B1_IN;
wire [3:0] TXCHARDISPMODE0_IN;
wire [3:0] TXCHARDISPMODE1_IN;
wire [3:0] TXCHARDISPVAL0_IN;
wire [3:0] TXCHARDISPVAL1_IN;
wire [3:0] TXCHARISK0_IN;
wire [3:0] TXCHARISK1_IN;
wire [3:0] TXPREEMPHASIS0_IN;
wire [3:0] TXPREEMPHASIS1_IN;
wire [4:0] DFETAP10_IN;
wire [4:0] DFETAP11_IN;
wire [4:0] DFETAP20_IN;
wire [4:0] DFETAP21_IN;
wire [5:0] DFECLKDLYADJ0_IN;
wire [5:0] DFECLKDLYADJ1_IN;
wire [6:0] DADDR_IN;
wire [6:0] TXSEQUENCE0_IN;
wire [6:0] TXSEQUENCE1_IN;



initial begin
       
	case (PLL_TXDIVSEL_OUT_0)
		1 : PLL_TXDIVSEL_OUT_0_BINARY = 2'b00;
		2 : PLL_TXDIVSEL_OUT_0_BINARY = 2'b01;
		4 : PLL_TXDIVSEL_OUT_0_BINARY = 2'b10;
		default : begin
			$display("Attribute Syntax Error : The Attribute PLL_TXDIVSEL_OUT_0 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1, 2 or 4.", PLL_TXDIVSEL_OUT_0);
			$finish;
		end
	endcase

	case (PLL_RXDIVSEL_OUT_0)
		1 : PLL_RXDIVSEL_OUT_0_BINARY = 2'b00;
		2 : PLL_RXDIVSEL_OUT_0_BINARY = 2'b01;
		4 : PLL_RXDIVSEL_OUT_0_BINARY = 2'b10;
		default : begin
			$display("Attribute Syntax Error : The Attribute PLL_RXDIVSEL_OUT_0 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1, 2 or 4.", PLL_RXDIVSEL_OUT_0);
			$finish;
		end
	endcase

	case (PLL_TXDIVSEL_OUT_1)
		1 : PLL_TXDIVSEL_OUT_1_BINARY = 2'b00;
		2 : PLL_TXDIVSEL_OUT_1_BINARY = 2'b01;
		4 : PLL_TXDIVSEL_OUT_1_BINARY = 2'b10;
		default : begin
			$display("Attribute Syntax Error : The Attribute PLL_TXDIVSEL_OUT_1 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1, 2 or 4.", PLL_TXDIVSEL_OUT_1);
			$finish;
		end
	endcase

	case (PLL_RXDIVSEL_OUT_1)
		1 : PLL_RXDIVSEL_OUT_1_BINARY = 2'b00;
		2 : PLL_RXDIVSEL_OUT_1_BINARY = 2'b01;
		4 : PLL_RXDIVSEL_OUT_1_BINARY = 2'b10;
		default : begin
			$display("Attribute Syntax Error : The Attribute PLL_RXDIVSEL_OUT_1 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1, 2 or 4.", PLL_RXDIVSEL_OUT_1);
			$finish;
		end
	endcase

	case (PLL_DIVSEL_FB)
		1 : PLL_DIVSEL_FB_BINARY = 5'b10000;
		2 : PLL_DIVSEL_FB_BINARY = 5'b00000;
		3 : PLL_DIVSEL_FB_BINARY = 5'b00001;
		4 : PLL_DIVSEL_FB_BINARY = 5'b00010;
		5 : PLL_DIVSEL_FB_BINARY = 5'b00011;
		8 : PLL_DIVSEL_FB_BINARY = 5'b00110;
		10 : PLL_DIVSEL_FB_BINARY = 5'b00111;
		default : begin
			$display("Attribute Syntax Error : The Attribute PLL_DIVSEL_FB on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1, 2, 3, 4, 5, 8 or 10.", PLL_DIVSEL_FB);
			$finish;
		end
	endcase

	case (PLL_DIVSEL_REF)
		1 : PLL_DIVSEL_REF_BINARY = 6'b010000;
		2 : PLL_DIVSEL_REF_BINARY = 6'b000000;
		3 : PLL_DIVSEL_REF_BINARY = 6'b000001;
		4 : PLL_DIVSEL_REF_BINARY = 6'b000010;
		5 : PLL_DIVSEL_REF_BINARY = 6'b000011;
		6 : PLL_DIVSEL_REF_BINARY = 6'b000101;
		8 : PLL_DIVSEL_REF_BINARY = 6'b000110;
		10 : PLL_DIVSEL_REF_BINARY = 6'b000111;
		12 : PLL_DIVSEL_REF_BINARY = 6'b001101;
		16 : PLL_DIVSEL_REF_BINARY = 6'b001110;
		20 : PLL_DIVSEL_REF_BINARY = 6'b001111;
		default : begin
			$display("Attribute Syntax Error : The Attribute PLL_DIVSEL_REF on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1, 2, 3, 4, 5, 6, 8, 10, 12, 16 or 20.", PLL_DIVSEL_REF);
			$finish;
		end
	endcase

	case (PLL_SATA_0)
		"FALSE" : PLL_SATA_0_BINARY = 1'b0;
		"TRUE" : PLL_SATA_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute PLL_SATA_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", PLL_SATA_0);
			$finish;
		end
	endcase

	case (PLL_SATA_1)
		"FALSE" : PLL_SATA_1_BINARY = 1'b0;
		"TRUE" : PLL_SATA_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute PLL_SATA_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", PLL_SATA_1);
			$finish;
		end
	endcase


	case (OOB_CLK_DIVIDER)
		1 : OOB_CLK_DIVIDER_BINARY = 3'b000;
		2 : OOB_CLK_DIVIDER_BINARY = 3'b001;
		4 : OOB_CLK_DIVIDER_BINARY = 3'b010;
		6 : OOB_CLK_DIVIDER_BINARY = 3'b011;
		8 : OOB_CLK_DIVIDER_BINARY = 3'b100;
		10 : OOB_CLK_DIVIDER_BINARY = 3'b101;
		12 : OOB_CLK_DIVIDER_BINARY = 3'b110;
		14 : OOB_CLK_DIVIDER_BINARY = 3'b111;
		default : begin
			$display("Attribute Syntax Error : The Attribute OOB_CLK_DIVIDER on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1, 2, 4, 6, 8, 10, 12 or 14.", OOB_CLK_DIVIDER);
			$finish;
		end
	endcase

        case (OOBDETECT_THRESHOLD_0)
	        3'b110 : OOBDETECT_THRESHOLD_0_BINARY  = 3'b110;
		3'b111 : OOBDETECT_THRESHOLD_0_BINARY  = 3'b111;
		default : begin
			$display("Attribute Syntax Warning : The Attribute OOBDETECT_THRESHOLD_0 on X_GTX_DUAL instance %m is set to %b.  Legal values for this attribute are 110 or 111.", OOBDETECT_THRESHOLD_0);
			//$finish;
		end
        endcase 

        case (OOBDETECT_THRESHOLD_1)
	        3'b110 : OOBDETECT_THRESHOLD_1_BINARY  = 3'b110;
		3'b111 : OOBDETECT_THRESHOLD_1_BINARY  = 3'b111;
		default : begin
			$display("Attribute Syntax Warning : The Attribute OOBDETECT_THRESHOLD_1 on X_GTX_DUAL instance %m is set to %b.  Legal values for this attribute are 110 or 111.", OOBDETECT_THRESHOLD_1);
			//$finish;
		end
        endcase 
   
	case (AC_CAP_DIS_0)
		"FALSE" : AC_CAP_DIS_0_BINARY = 1'b0;
		"TRUE" : AC_CAP_DIS_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute AC_CAP_DIS_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", AC_CAP_DIS_0);
			$finish;
		end
	endcase

	case (AC_CAP_DIS_1)
		"FALSE" : AC_CAP_DIS_1_BINARY = 1'b0;
		"TRUE" : AC_CAP_DIS_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute AC_CAP_DIS_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", AC_CAP_DIS_1);
			$finish;
		end
	endcase

	case (RCV_TERM_GND_0)
		"FALSE" : RCV_TERM_GND_0_BINARY = 1'b0;
		"TRUE" : RCV_TERM_GND_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute RCV_TERM_GND_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RCV_TERM_GND_0);
			$finish;
		end
	endcase

	case (RCV_TERM_GND_1)
		"FALSE" : RCV_TERM_GND_1_BINARY = 1'b0;
		"TRUE" : RCV_TERM_GND_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute RCV_TERM_GND_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RCV_TERM_GND_1);
			$finish;
		end
	endcase

	case (TERMINATION_IMP_0)
		50 : TERMINATION_IMP_0_BINARY = 1'b0;
		75 : TERMINATION_IMP_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute TERMINATION_IMP_0 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are  50 or 75.", TERMINATION_IMP_0);
			$finish;
		end
	endcase

	case (TERMINATION_IMP_1)
		50 : TERMINATION_IMP_1_BINARY = 1'b0;
		75 : TERMINATION_IMP_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute TERMINATION_IMP_1 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are  50 or 75.", TERMINATION_IMP_1);
			$finish;
		end
	endcase

	case (TERMINATION_OVRD)
		"FALSE" : TERMINATION_OVRD_BINARY = 1'b0;
		"TRUE" : TERMINATION_OVRD_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute TERMINATION_OVRD on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", TERMINATION_OVRD);
			$finish;
		end
	endcase

	case (RCV_TERM_VTTRX_0)
		"FALSE" : RCV_TERM_VTTRX_0_BINARY = 1'b0;
		"TRUE" : RCV_TERM_VTTRX_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute RCV_TERM_VTTRX_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RCV_TERM_VTTRX_0);
			$finish;
		end
	endcase

	case (RCV_TERM_VTTRX_1)
		"FALSE" : RCV_TERM_VTTRX_1_BINARY = 1'b0;
		"TRUE" : RCV_TERM_VTTRX_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute RCV_TERM_VTTRX_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RCV_TERM_VTTRX_1);
			$finish;
		end
	endcase

	case (CLKINDC_B)
		"FALSE" : CLKINDC_B_BINARY = 1'b0;
		"TRUE" : CLKINDC_B_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute CLKINDC_B on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", CLKINDC_B);
			$finish;
		end
	endcase

	case (PCOMMA_DETECT_0)
		"FALSE" : PCOMMA_DETECT_0_BINARY = 1'b0;
		"TRUE" : PCOMMA_DETECT_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute PCOMMA_DETECT_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", PCOMMA_DETECT_0);
			$finish;
		end
	endcase

	case (MCOMMA_DETECT_0)
		"FALSE" : MCOMMA_DETECT_0_BINARY = 1'b0;
		"TRUE" : MCOMMA_DETECT_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute MCOMMA_DETECT_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MCOMMA_DETECT_0);
			$finish;
		end
	endcase

	case (COMMA_DOUBLE_0)
		"FALSE" : COMMA_DOUBLE_0_BINARY = 1'b0;
		"TRUE" : COMMA_DOUBLE_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute COMMA_DOUBLE_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", COMMA_DOUBLE_0);
			$finish;
		end
	endcase

	case (ALIGN_COMMA_WORD_0)
		1 : ALIGN_COMMA_WORD_0_BINARY = 1'b0;
		2 : ALIGN_COMMA_WORD_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute ALIGN_COMMA_WORD_0 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are  1 or 2.", ALIGN_COMMA_WORD_0);
			$finish;
		end
	endcase

	case (DEC_PCOMMA_DETECT_0)
		"FALSE" : DEC_PCOMMA_DETECT_0_BINARY = 1'b0;
		"TRUE" : DEC_PCOMMA_DETECT_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute DEC_PCOMMA_DETECT_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", DEC_PCOMMA_DETECT_0);
			$finish;
		end
	endcase

	case (DEC_MCOMMA_DETECT_0)
		"FALSE" : DEC_MCOMMA_DETECT_0_BINARY = 1'b0;
		"TRUE" : DEC_MCOMMA_DETECT_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute DEC_MCOMMA_DETECT_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", DEC_MCOMMA_DETECT_0);
			$finish;
		end
	endcase

	case (DEC_VALID_COMMA_ONLY_0)
		"FALSE" : DEC_VALID_COMMA_ONLY_0_BINARY = 1'b0;
		"TRUE" : DEC_VALID_COMMA_ONLY_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute DEC_VALID_COMMA_ONLY_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", DEC_VALID_COMMA_ONLY_0);
			$finish;
		end
	endcase

	case (PCOMMA_DETECT_1)
		"FALSE" : PCOMMA_DETECT_1_BINARY = 1'b0;
		"TRUE" : PCOMMA_DETECT_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute PCOMMA_DETECT_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", PCOMMA_DETECT_1);
			$finish;
		end
	endcase

	case (MCOMMA_DETECT_1)
		"FALSE" : MCOMMA_DETECT_1_BINARY = 1'b0;
		"TRUE" : MCOMMA_DETECT_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute MCOMMA_DETECT_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MCOMMA_DETECT_1);
			$finish;
		end
	endcase

	case (COMMA_DOUBLE_1)
		"FALSE" : COMMA_DOUBLE_1_BINARY = 1'b0;
		"TRUE" : COMMA_DOUBLE_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute COMMA_DOUBLE_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", COMMA_DOUBLE_1);
			$finish;
		end
	endcase

	case (ALIGN_COMMA_WORD_1)
		1 : ALIGN_COMMA_WORD_1_BINARY = 1'b0;
		2 : ALIGN_COMMA_WORD_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute ALIGN_COMMA_WORD_1 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are  1 or 2.", ALIGN_COMMA_WORD_1);
			$finish;
		end
	endcase

	case (DEC_PCOMMA_DETECT_1)
		"FALSE" : DEC_PCOMMA_DETECT_1_BINARY = 1'b0;
		"TRUE" : DEC_PCOMMA_DETECT_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute DEC_PCOMMA_DETECT_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", DEC_PCOMMA_DETECT_1);
			$finish;
		end
	endcase

	case (DEC_MCOMMA_DETECT_1)
		"FALSE" : DEC_MCOMMA_DETECT_1_BINARY = 1'b0;
		"TRUE" : DEC_MCOMMA_DETECT_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute DEC_MCOMMA_DETECT_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", DEC_MCOMMA_DETECT_1);
			$finish;
		end
	endcase

	case (DEC_VALID_COMMA_ONLY_1)
		"FALSE" : DEC_VALID_COMMA_ONLY_1_BINARY = 1'b0;
		"TRUE" : DEC_VALID_COMMA_ONLY_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute DEC_VALID_COMMA_ONLY_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", DEC_VALID_COMMA_ONLY_1);
			$finish;
		end
	endcase

	case (RX_LOSS_OF_SYNC_FSM_0)
		"FALSE" : RX_LOSS_OF_SYNC_FSM_0_BINARY = 1'b0;
		"TRUE" : RX_LOSS_OF_SYNC_FSM_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute RX_LOSS_OF_SYNC_FSM_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RX_LOSS_OF_SYNC_FSM_0);
			$finish;
		end
	endcase

	case (RX_LOS_INVALID_INCR_0)
		1 : RX_LOS_INVALID_INCR_0_BINARY = 3'b000;
		2 : RX_LOS_INVALID_INCR_0_BINARY = 3'b001;
		4 : RX_LOS_INVALID_INCR_0_BINARY = 3'b010;
		8 : RX_LOS_INVALID_INCR_0_BINARY = 3'b011;
		16 : RX_LOS_INVALID_INCR_0_BINARY = 3'b100;
		32 : RX_LOS_INVALID_INCR_0_BINARY = 3'b101;
		64 : RX_LOS_INVALID_INCR_0_BINARY = 3'b110;
		128 : RX_LOS_INVALID_INCR_0_BINARY = 3'b111;
		default : begin
			$display("Attribute Syntax Error : The Attribute RX_LOS_INVALID_INCR_0 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1, 2, 4, 8, 16, 32, 64 or 128.", RX_LOS_INVALID_INCR_0);
			$finish;
		end
	endcase

	case (RX_LOS_THRESHOLD_0)
		4 : RX_LOS_THRESHOLD_0_BINARY = 3'b000;
		8 : RX_LOS_THRESHOLD_0_BINARY = 3'b001;
		16 : RX_LOS_THRESHOLD_0_BINARY = 3'b010;
		32 : RX_LOS_THRESHOLD_0_BINARY = 3'b011;
		64 : RX_LOS_THRESHOLD_0_BINARY = 3'b100;
		128 : RX_LOS_THRESHOLD_0_BINARY = 3'b101;
		256 : RX_LOS_THRESHOLD_0_BINARY = 3'b110;
		512 : RX_LOS_THRESHOLD_0_BINARY = 3'b111;
		default : begin
			$display("Attribute Syntax Error : The Attribute RX_LOS_THRESHOLD_0 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 4, 8, 16, 32, 64, 128, 256 or 512.", RX_LOS_THRESHOLD_0);
			$finish;
		end
	endcase

	case (RX_LOSS_OF_SYNC_FSM_1)
		"FALSE" : RX_LOSS_OF_SYNC_FSM_1_BINARY = 1'b0;
		"TRUE" : RX_LOSS_OF_SYNC_FSM_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute RX_LOSS_OF_SYNC_FSM_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RX_LOSS_OF_SYNC_FSM_1);
			$finish;
		end
	endcase

	case (RX_LOS_INVALID_INCR_1)
		1 : RX_LOS_INVALID_INCR_1_BINARY = 3'b000;
		2 : RX_LOS_INVALID_INCR_1_BINARY = 3'b001;
		4 : RX_LOS_INVALID_INCR_1_BINARY = 3'b010;
		8 : RX_LOS_INVALID_INCR_1_BINARY = 3'b011;
		16 : RX_LOS_INVALID_INCR_1_BINARY = 3'b100;
		32 : RX_LOS_INVALID_INCR_1_BINARY = 3'b101;
		64 : RX_LOS_INVALID_INCR_1_BINARY = 3'b110;
		128 : RX_LOS_INVALID_INCR_1_BINARY = 3'b111;
		default : begin
			$display("Attribute Syntax Error : The Attribute RX_LOS_INVALID_INCR_1 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1, 2, 4, 8, 16, 32, 64 or 128.", RX_LOS_INVALID_INCR_1);
			$finish;
		end
	endcase

	case (RX_LOS_THRESHOLD_1)
		4 : RX_LOS_THRESHOLD_1_BINARY = 3'b000;
		8 : RX_LOS_THRESHOLD_1_BINARY = 3'b001;
		16 : RX_LOS_THRESHOLD_1_BINARY = 3'b010;
		32 : RX_LOS_THRESHOLD_1_BINARY = 3'b011;
		64 : RX_LOS_THRESHOLD_1_BINARY = 3'b100;
		128 : RX_LOS_THRESHOLD_1_BINARY = 3'b101;
		256 : RX_LOS_THRESHOLD_1_BINARY = 3'b110;
		512 : RX_LOS_THRESHOLD_1_BINARY = 3'b111;
		default : begin
			$display("Attribute Syntax Error : The Attribute RX_LOS_THRESHOLD_1 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 4, 8, 16, 32, 64, 128, 256 or 512.", RX_LOS_THRESHOLD_1);
			$finish;
		end
	endcase

	case (RX_BUFFER_USE_0)
		"FALSE" : RX_BUFFER_USE_0_BINARY = 1'b0;
		"TRUE" : RX_BUFFER_USE_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute RX_BUFFER_USE_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RX_BUFFER_USE_0);
			$finish;
		end
	endcase

	case (RX_DECODE_SEQ_MATCH_0)
		"FALSE" : RX_DECODE_SEQ_MATCH_0_BINARY = 1'b0;
		"TRUE" : RX_DECODE_SEQ_MATCH_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute RX_DECODE_SEQ_MATCH_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RX_DECODE_SEQ_MATCH_0);
			$finish;
		end
	endcase

	case (RX_BUFFER_USE_1)
		"FALSE" : RX_BUFFER_USE_1_BINARY = 1'b0;
		"TRUE" : RX_BUFFER_USE_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute RX_BUFFER_USE_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RX_BUFFER_USE_1);
			$finish;
		end
	endcase

	case (RX_DECODE_SEQ_MATCH_1)
		"FALSE" : RX_DECODE_SEQ_MATCH_1_BINARY = 1'b0;
		"TRUE" : RX_DECODE_SEQ_MATCH_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute RX_DECODE_SEQ_MATCH_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RX_DECODE_SEQ_MATCH_1);
			$finish;
		end
	endcase

	case (CLK_COR_MIN_LAT_0)
		3 : CLK_COR_MIN_LAT_0_BINARY = 6'b000011;
		4 : CLK_COR_MIN_LAT_0_BINARY = 6'b000100;
		5 : CLK_COR_MIN_LAT_0_BINARY = 6'b000101;
		6 : CLK_COR_MIN_LAT_0_BINARY = 6'b000110;
		7 : CLK_COR_MIN_LAT_0_BINARY = 6'b000111;
		8 : CLK_COR_MIN_LAT_0_BINARY = 6'b001000;
		9 : CLK_COR_MIN_LAT_0_BINARY = 6'b001001;
		10 : CLK_COR_MIN_LAT_0_BINARY = 6'b001010;
		11 : CLK_COR_MIN_LAT_0_BINARY = 6'b001011;
		12 : CLK_COR_MIN_LAT_0_BINARY = 6'b001100;
		13 : CLK_COR_MIN_LAT_0_BINARY = 6'b001101;
		14 : CLK_COR_MIN_LAT_0_BINARY = 6'b001110;
		15 : CLK_COR_MIN_LAT_0_BINARY = 6'b001111;
		16 : CLK_COR_MIN_LAT_0_BINARY = 6'b010000;
		17 : CLK_COR_MIN_LAT_0_BINARY = 6'b010001;
		18 : CLK_COR_MIN_LAT_0_BINARY = 6'b010010;
		19 : CLK_COR_MIN_LAT_0_BINARY = 6'b010011;
		20 : CLK_COR_MIN_LAT_0_BINARY = 6'b010100;
		21 : CLK_COR_MIN_LAT_0_BINARY = 6'b010101;
		22 : CLK_COR_MIN_LAT_0_BINARY = 6'b010110;
		23 : CLK_COR_MIN_LAT_0_BINARY = 6'b010111;
		24 : CLK_COR_MIN_LAT_0_BINARY = 6'b011000;
		25 : CLK_COR_MIN_LAT_0_BINARY = 6'b011001;
		26 : CLK_COR_MIN_LAT_0_BINARY = 6'b011010;
		27 : CLK_COR_MIN_LAT_0_BINARY = 6'b011011;
		28 : CLK_COR_MIN_LAT_0_BINARY = 6'b011100;
		29 : CLK_COR_MIN_LAT_0_BINARY = 6'b011101;
		30 : CLK_COR_MIN_LAT_0_BINARY = 6'b011110;
		31 : CLK_COR_MIN_LAT_0_BINARY = 6'b011111;
		32 : CLK_COR_MIN_LAT_0_BINARY = 6'b100000;
		33 : CLK_COR_MIN_LAT_0_BINARY = 6'b100001;
		34 : CLK_COR_MIN_LAT_0_BINARY = 6'b100010;
		35 : CLK_COR_MIN_LAT_0_BINARY = 6'b100011;
		36 : CLK_COR_MIN_LAT_0_BINARY = 6'b100100;
		37 : CLK_COR_MIN_LAT_0_BINARY = 6'b100101;
		38 : CLK_COR_MIN_LAT_0_BINARY = 6'b100110;
		39 : CLK_COR_MIN_LAT_0_BINARY = 6'b100111;
		40 : CLK_COR_MIN_LAT_0_BINARY = 6'b101000;
		41 : CLK_COR_MIN_LAT_0_BINARY = 6'b101001;
		42 : CLK_COR_MIN_LAT_0_BINARY = 6'b101010;
		43 : CLK_COR_MIN_LAT_0_BINARY = 6'b101011;
		44 : CLK_COR_MIN_LAT_0_BINARY = 6'b101100;
		45 : CLK_COR_MIN_LAT_0_BINARY = 6'b101101;
		46 : CLK_COR_MIN_LAT_0_BINARY = 6'b101110;
		47 : CLK_COR_MIN_LAT_0_BINARY = 6'b101111;
		48 : CLK_COR_MIN_LAT_0_BINARY = 6'b110000;
		default : begin
			$display("Attribute Syntax Error : The Attribute CLK_COR_MIN_LAT_0 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 3 to 48.", CLK_COR_MIN_LAT_0);
			$finish;
		end
	endcase

	case (CLK_COR_MAX_LAT_0)
		3 : CLK_COR_MAX_LAT_0_BINARY = 6'b000011;
		4 : CLK_COR_MAX_LAT_0_BINARY = 6'b000100;
		5 : CLK_COR_MAX_LAT_0_BINARY = 6'b000101;
		6 : CLK_COR_MAX_LAT_0_BINARY = 6'b000110;
		7 : CLK_COR_MAX_LAT_0_BINARY = 6'b000111;
		8 : CLK_COR_MAX_LAT_0_BINARY = 6'b001000;
		9 : CLK_COR_MAX_LAT_0_BINARY = 6'b001001;
		10 : CLK_COR_MAX_LAT_0_BINARY = 6'b001010;
		11 : CLK_COR_MAX_LAT_0_BINARY = 6'b001011;
		12 : CLK_COR_MAX_LAT_0_BINARY = 6'b001100;
		13 : CLK_COR_MAX_LAT_0_BINARY = 6'b001101;
		14 : CLK_COR_MAX_LAT_0_BINARY = 6'b001110;
		15 : CLK_COR_MAX_LAT_0_BINARY = 6'b001111;
		16 : CLK_COR_MAX_LAT_0_BINARY = 6'b010000;
		17 : CLK_COR_MAX_LAT_0_BINARY = 6'b010001;
		18 : CLK_COR_MAX_LAT_0_BINARY = 6'b010010;
		19 : CLK_COR_MAX_LAT_0_BINARY = 6'b010011;
		20 : CLK_COR_MAX_LAT_0_BINARY = 6'b010100;
		21 : CLK_COR_MAX_LAT_0_BINARY = 6'b010101;
		22 : CLK_COR_MAX_LAT_0_BINARY = 6'b010110;
		23 : CLK_COR_MAX_LAT_0_BINARY = 6'b010111;
		24 : CLK_COR_MAX_LAT_0_BINARY = 6'b011000;
		25 : CLK_COR_MAX_LAT_0_BINARY = 6'b011001;
		26 : CLK_COR_MAX_LAT_0_BINARY = 6'b011010;
		27 : CLK_COR_MAX_LAT_0_BINARY = 6'b011011;
		28 : CLK_COR_MAX_LAT_0_BINARY = 6'b011100;
		29 : CLK_COR_MAX_LAT_0_BINARY = 6'b011101;
		30 : CLK_COR_MAX_LAT_0_BINARY = 6'b011110;
		31 : CLK_COR_MAX_LAT_0_BINARY = 6'b011111;
		32 : CLK_COR_MAX_LAT_0_BINARY = 6'b100000;
		33 : CLK_COR_MAX_LAT_0_BINARY = 6'b100001;
		34 : CLK_COR_MAX_LAT_0_BINARY = 6'b100010;
		35 : CLK_COR_MAX_LAT_0_BINARY = 6'b100011;
		36 : CLK_COR_MAX_LAT_0_BINARY = 6'b100100;
		37 : CLK_COR_MAX_LAT_0_BINARY = 6'b100101;
		38 : CLK_COR_MAX_LAT_0_BINARY = 6'b100110;
		39 : CLK_COR_MAX_LAT_0_BINARY = 6'b100111;
		40 : CLK_COR_MAX_LAT_0_BINARY = 6'b101000;
		41 : CLK_COR_MAX_LAT_0_BINARY = 6'b101001;
		42 : CLK_COR_MAX_LAT_0_BINARY = 6'b101010;
		43 : CLK_COR_MAX_LAT_0_BINARY = 6'b101011;
		44 : CLK_COR_MAX_LAT_0_BINARY = 6'b101100;
		45 : CLK_COR_MAX_LAT_0_BINARY = 6'b101101;
		46 : CLK_COR_MAX_LAT_0_BINARY = 6'b101110;
		47 : CLK_COR_MAX_LAT_0_BINARY = 6'b101111;
		48 : CLK_COR_MAX_LAT_0_BINARY = 6'b110000;
		default : begin
			$display("Attribute Syntax Error : The Attribute CLK_COR_MAX_LAT_0 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 3 to 48.", CLK_COR_MAX_LAT_0);
			$finish;
		end
	endcase

	case (CLK_CORRECT_USE_0)
		"FALSE" : CLK_CORRECT_USE_0_BINARY = 1'b0;
		"TRUE" : CLK_CORRECT_USE_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute CLK_CORRECT_USE_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", CLK_CORRECT_USE_0);
			$finish;
		end
	endcase

	case (CLK_COR_PRECEDENCE_0)
		"FALSE" : CLK_COR_PRECEDENCE_0_BINARY = 1'b0;
		"TRUE" : CLK_COR_PRECEDENCE_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute CLK_COR_PRECEDENCE_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", CLK_COR_PRECEDENCE_0);
			$finish;
		end
	endcase

	case (CLK_COR_DET_LEN_0)
		1 : CLK_COR_DET_LEN_0_BINARY = 2'b00;
		2 : CLK_COR_DET_LEN_0_BINARY = 2'b01;
		3 : CLK_COR_DET_LEN_0_BINARY = 2'b10;
		4 : CLK_COR_DET_LEN_0_BINARY = 2'b11;
		default : begin
			$display("Attribute Syntax Error : The Attribute CLK_COR_DET_LEN_0 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1, 2, 3 or 4.", CLK_COR_DET_LEN_0);
			$finish;
		end
	endcase

	case (CLK_COR_ADJ_LEN_0)
		1 : CLK_COR_ADJ_LEN_0_BINARY = 2'b00;
		2 : CLK_COR_ADJ_LEN_0_BINARY = 2'b01;
		3 : CLK_COR_ADJ_LEN_0_BINARY = 2'b10;
		4 : CLK_COR_ADJ_LEN_0_BINARY = 2'b11;
		default : begin
			$display("Attribute Syntax Error : The Attribute CLK_COR_ADJ_LEN_0 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1, 2, 3 or 4.", CLK_COR_ADJ_LEN_0);
			$finish;
		end
	endcase

	case (CLK_COR_KEEP_IDLE_0)
		"FALSE" : CLK_COR_KEEP_IDLE_0_BINARY = 1'b0;
		"TRUE" : CLK_COR_KEEP_IDLE_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute CLK_COR_KEEP_IDLE_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", CLK_COR_KEEP_IDLE_0);
			$finish;
		end
	endcase

	case (CLK_COR_INSERT_IDLE_FLAG_0)
		"FALSE" : CLK_COR_INSERT_IDLE_FLAG_0_BINARY = 1'b0;
		"TRUE" : CLK_COR_INSERT_IDLE_FLAG_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute CLK_COR_INSERT_IDLE_FLAG_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", CLK_COR_INSERT_IDLE_FLAG_0);
			$finish;
		end
	endcase

	case (CLK_COR_REPEAT_WAIT_0)
		0 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b00000;
		1 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b00001;
		2 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b00010;
		3 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b00011;
		4 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b00100;
		5 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b00101;
		6 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b00110;
		7 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b00111;
		8 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b01000;
		9 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b01001;
		10 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b01010;
		11 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b01011;
		12 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b01100;
		13 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b01101;
		14 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b01110;
		15 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b01111;
		16 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b10000;
		17 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b10001;
		18 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b10010;
		19 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b10011;
		20 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b10100;
		21 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b10101;
		22 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b10110;
		23 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b10111;
		24 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b11000;
		25 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b11001;
		26 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b11010;
		27 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b11011;
		28 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b11100;
		29 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b11101;
		30 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b11110;
		31 : CLK_COR_REPEAT_WAIT_0_BINARY = 5'b11111;
		default : begin
			$display("Attribute Syntax Error : The Attribute CLK_COR_REPEAT_WAIT_0 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 0 to 31.", CLK_COR_REPEAT_WAIT_0);
			$finish;
		end
	endcase

	case (CLK_COR_SEQ_2_USE_0)
		"FALSE" : CLK_COR_SEQ_2_USE_0_BINARY = 1'b0;
		"TRUE" : CLK_COR_SEQ_2_USE_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute CLK_COR_SEQ_2_USE_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", CLK_COR_SEQ_2_USE_0);
			$finish;
		end
	endcase

	case (CLK_COR_MIN_LAT_1)
		3 : CLK_COR_MIN_LAT_1_BINARY = 6'b000011;
		4 : CLK_COR_MIN_LAT_1_BINARY = 6'b000100;
		5 : CLK_COR_MIN_LAT_1_BINARY = 6'b000101;
		6 : CLK_COR_MIN_LAT_1_BINARY = 6'b000110;
		7 : CLK_COR_MIN_LAT_1_BINARY = 6'b000111;
		8 : CLK_COR_MIN_LAT_1_BINARY = 6'b001000;
		9 : CLK_COR_MIN_LAT_1_BINARY = 6'b001001;
		10 : CLK_COR_MIN_LAT_1_BINARY = 6'b001010;
		11 : CLK_COR_MIN_LAT_1_BINARY = 6'b001011;
		12 : CLK_COR_MIN_LAT_1_BINARY = 6'b001100;
		13 : CLK_COR_MIN_LAT_1_BINARY = 6'b001101;
		14 : CLK_COR_MIN_LAT_1_BINARY = 6'b001110;
		15 : CLK_COR_MIN_LAT_1_BINARY = 6'b001111;
		16 : CLK_COR_MIN_LAT_1_BINARY = 6'b010000;
		17 : CLK_COR_MIN_LAT_1_BINARY = 6'b010001;
		18 : CLK_COR_MIN_LAT_1_BINARY = 6'b010010;
		19 : CLK_COR_MIN_LAT_1_BINARY = 6'b010011;
		20 : CLK_COR_MIN_LAT_1_BINARY = 6'b010100;
		21 : CLK_COR_MIN_LAT_1_BINARY = 6'b010101;
		22 : CLK_COR_MIN_LAT_1_BINARY = 6'b010110;
		23 : CLK_COR_MIN_LAT_1_BINARY = 6'b010111;
		24 : CLK_COR_MIN_LAT_1_BINARY = 6'b011000;
		25 : CLK_COR_MIN_LAT_1_BINARY = 6'b011001;
		26 : CLK_COR_MIN_LAT_1_BINARY = 6'b011010;
		27 : CLK_COR_MIN_LAT_1_BINARY = 6'b011011;
		28 : CLK_COR_MIN_LAT_1_BINARY = 6'b011100;
		29 : CLK_COR_MIN_LAT_1_BINARY = 6'b011101;
		30 : CLK_COR_MIN_LAT_1_BINARY = 6'b011110;
		31 : CLK_COR_MIN_LAT_1_BINARY = 6'b011111;
		32 : CLK_COR_MIN_LAT_1_BINARY = 6'b100000;
		33 : CLK_COR_MIN_LAT_1_BINARY = 6'b100001;
		34 : CLK_COR_MIN_LAT_1_BINARY = 6'b100010;
		35 : CLK_COR_MIN_LAT_1_BINARY = 6'b100011;
		36 : CLK_COR_MIN_LAT_1_BINARY = 6'b100100;
		37 : CLK_COR_MIN_LAT_1_BINARY = 6'b100101;
		38 : CLK_COR_MIN_LAT_1_BINARY = 6'b100110;
		39 : CLK_COR_MIN_LAT_1_BINARY = 6'b100111;
		40 : CLK_COR_MIN_LAT_1_BINARY = 6'b101000;
		41 : CLK_COR_MIN_LAT_1_BINARY = 6'b101001;
		42 : CLK_COR_MIN_LAT_1_BINARY = 6'b101010;
		43 : CLK_COR_MIN_LAT_1_BINARY = 6'b101011;
		44 : CLK_COR_MIN_LAT_1_BINARY = 6'b101100;
		45 : CLK_COR_MIN_LAT_1_BINARY = 6'b101101;
		46 : CLK_COR_MIN_LAT_1_BINARY = 6'b101110;
		47 : CLK_COR_MIN_LAT_1_BINARY = 6'b101111;
		48 : CLK_COR_MIN_LAT_1_BINARY = 6'b110000;
		default : begin
			$display("Attribute Syntax Error : The Attribute CLK_COR_MIN_LAT_1 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 3 to 48.", CLK_COR_MIN_LAT_1);
			$finish;
		end
	endcase

	case (CLK_COR_MAX_LAT_1)
		3 : CLK_COR_MAX_LAT_1_BINARY = 6'b000011;
		4 : CLK_COR_MAX_LAT_1_BINARY = 6'b000100;
		5 : CLK_COR_MAX_LAT_1_BINARY = 6'b000101;
		6 : CLK_COR_MAX_LAT_1_BINARY = 6'b000110;
		7 : CLK_COR_MAX_LAT_1_BINARY = 6'b000111;
		8 : CLK_COR_MAX_LAT_1_BINARY = 6'b001000;
		9 : CLK_COR_MAX_LAT_1_BINARY = 6'b001001;
		10 : CLK_COR_MAX_LAT_1_BINARY = 6'b001010;
		11 : CLK_COR_MAX_LAT_1_BINARY = 6'b001011;
		12 : CLK_COR_MAX_LAT_1_BINARY = 6'b001100;
		13 : CLK_COR_MAX_LAT_1_BINARY = 6'b001101;
		14 : CLK_COR_MAX_LAT_1_BINARY = 6'b001110;
		15 : CLK_COR_MAX_LAT_1_BINARY = 6'b001111;
		16 : CLK_COR_MAX_LAT_1_BINARY = 6'b010000;
		17 : CLK_COR_MAX_LAT_1_BINARY = 6'b010001;
		18 : CLK_COR_MAX_LAT_1_BINARY = 6'b010010;
		19 : CLK_COR_MAX_LAT_1_BINARY = 6'b010011;
		20 : CLK_COR_MAX_LAT_1_BINARY = 6'b010100;
		21 : CLK_COR_MAX_LAT_1_BINARY = 6'b010101;
		22 : CLK_COR_MAX_LAT_1_BINARY = 6'b010110;
		23 : CLK_COR_MAX_LAT_1_BINARY = 6'b010111;
		24 : CLK_COR_MAX_LAT_1_BINARY = 6'b011000;
		25 : CLK_COR_MAX_LAT_1_BINARY = 6'b011001;
		26 : CLK_COR_MAX_LAT_1_BINARY = 6'b011010;
		27 : CLK_COR_MAX_LAT_1_BINARY = 6'b011011;
		28 : CLK_COR_MAX_LAT_1_BINARY = 6'b011100;
		29 : CLK_COR_MAX_LAT_1_BINARY = 6'b011101;
		30 : CLK_COR_MAX_LAT_1_BINARY = 6'b011110;
		31 : CLK_COR_MAX_LAT_1_BINARY = 6'b011111;
		32 : CLK_COR_MAX_LAT_1_BINARY = 6'b100000;
		33 : CLK_COR_MAX_LAT_1_BINARY = 6'b100001;
		34 : CLK_COR_MAX_LAT_1_BINARY = 6'b100010;
		35 : CLK_COR_MAX_LAT_1_BINARY = 6'b100011;
		36 : CLK_COR_MAX_LAT_1_BINARY = 6'b100100;
		37 : CLK_COR_MAX_LAT_1_BINARY = 6'b100101;
		38 : CLK_COR_MAX_LAT_1_BINARY = 6'b100110;
		39 : CLK_COR_MAX_LAT_1_BINARY = 6'b100111;
		40 : CLK_COR_MAX_LAT_1_BINARY = 6'b101000;
		41 : CLK_COR_MAX_LAT_1_BINARY = 6'b101001;
		42 : CLK_COR_MAX_LAT_1_BINARY = 6'b101010;
		43 : CLK_COR_MAX_LAT_1_BINARY = 6'b101011;
		44 : CLK_COR_MAX_LAT_1_BINARY = 6'b101100;
		45 : CLK_COR_MAX_LAT_1_BINARY = 6'b101101;
		46 : CLK_COR_MAX_LAT_1_BINARY = 6'b101110;
		47 : CLK_COR_MAX_LAT_1_BINARY = 6'b101111;
		48 : CLK_COR_MAX_LAT_1_BINARY = 6'b110000;
		default : begin
			$display("Attribute Syntax Error : The Attribute CLK_COR_MAX_LAT_1 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 3 to 48.", CLK_COR_MAX_LAT_1);
			$finish;
		end
	endcase

	case (CLK_CORRECT_USE_1)
		"FALSE" : CLK_CORRECT_USE_1_BINARY = 1'b0;
		"TRUE" : CLK_CORRECT_USE_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute CLK_CORRECT_USE_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", CLK_CORRECT_USE_1);
			$finish;
		end
	endcase

	case (CLK_COR_PRECEDENCE_1)
		"FALSE" : CLK_COR_PRECEDENCE_1_BINARY = 1'b0;
		"TRUE" : CLK_COR_PRECEDENCE_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute CLK_COR_PRECEDENCE_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", CLK_COR_PRECEDENCE_1);
			$finish;
		end
	endcase

	case (CLK_COR_DET_LEN_1)
		1 : CLK_COR_DET_LEN_1_BINARY = 2'b00;
		2 : CLK_COR_DET_LEN_1_BINARY = 2'b01;
		3 : CLK_COR_DET_LEN_1_BINARY = 2'b10;
		4 : CLK_COR_DET_LEN_1_BINARY = 2'b11;
		default : begin
			$display("Attribute Syntax Error : The Attribute CLK_COR_DET_LEN_1 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1, 2, 3 or 4.", CLK_COR_DET_LEN_1);
			$finish;
		end
	endcase

	case (CLK_COR_ADJ_LEN_1)
		1 : CLK_COR_ADJ_LEN_1_BINARY = 2'b00;
		2 : CLK_COR_ADJ_LEN_1_BINARY = 2'b01;
		3 : CLK_COR_ADJ_LEN_1_BINARY = 2'b10;
		4 : CLK_COR_ADJ_LEN_1_BINARY = 2'b11;
		default : begin
			$display("Attribute Syntax Error : The Attribute CLK_COR_ADJ_LEN_1 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1, 2, 3 or 4.", CLK_COR_ADJ_LEN_1);
			$finish;
		end
	endcase

	case (CLK_COR_KEEP_IDLE_1)
		"FALSE" : CLK_COR_KEEP_IDLE_1_BINARY = 1'b0;
		"TRUE" : CLK_COR_KEEP_IDLE_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute CLK_COR_KEEP_IDLE_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", CLK_COR_KEEP_IDLE_1);
			$finish;
		end
	endcase

	case (CLK_COR_INSERT_IDLE_FLAG_1)
		"FALSE" : CLK_COR_INSERT_IDLE_FLAG_1_BINARY = 1'b0;
		"TRUE" : CLK_COR_INSERT_IDLE_FLAG_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute CLK_COR_INSERT_IDLE_FLAG_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", CLK_COR_INSERT_IDLE_FLAG_1);
			$finish;
		end
	endcase

	case (CLK_COR_REPEAT_WAIT_1)
		0 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b00000;
		1 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b00001;
		2 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b00010;
		3 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b00011;
		4 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b00100;
		5 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b00101;
		6 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b00110;
		7 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b00111;
		8 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b01000;
		9 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b01001;
		10 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b01010;
		11 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b01011;
		12 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b01100;
		13 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b01101;
		14 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b01110;
		15 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b01111;
		16 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b10000;
		17 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b10001;
		18 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b10010;
		19 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b10011;
		20 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b10100;
		21 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b10101;
		22 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b10110;
		23 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b10111;
		24 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b11000;
		25 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b11001;
		26 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b11010;
		27 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b11011;
		28 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b11100;
		29 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b11101;
		30 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b11110;
		31 : CLK_COR_REPEAT_WAIT_1_BINARY = 5'b11111;
		default : begin
			$display("Attribute Syntax Error : The Attribute CLK_COR_REPEAT_WAIT_1 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 0 to 31.", CLK_COR_REPEAT_WAIT_1);
			$finish;
		end
	endcase

	case (CLK_COR_SEQ_2_USE_1)
		"FALSE" : CLK_COR_SEQ_2_USE_1_BINARY = 1'b0;
		"TRUE" : CLK_COR_SEQ_2_USE_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute CLK_COR_SEQ_2_USE_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", CLK_COR_SEQ_2_USE_1);
			$finish;
		end
	endcase

	case (CHAN_BOND_MODE_0)
		"OFF" : CHAN_BOND_MODE_0_BINARY = 2'b00;
		"MASTER" : CHAN_BOND_MODE_0_BINARY = 2'b01;
		"SLAVE" : CHAN_BOND_MODE_0_BINARY = 2'b10;
		default : begin
			$display("Attribute Syntax Error : The Attribute CHAN_BOND_MODE_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are OFF, MASTER or SLAVE.", CHAN_BOND_MODE_0);
			$finish;
		end
	endcase

	case (CHAN_BOND_LEVEL_0)
		0 : CHAN_BOND_LEVEL_0_BINARY = 3'b000;
		1 : CHAN_BOND_LEVEL_0_BINARY = 3'b001;
		2 : CHAN_BOND_LEVEL_0_BINARY = 3'b010;
		3 : CHAN_BOND_LEVEL_0_BINARY = 3'b011;
		4 : CHAN_BOND_LEVEL_0_BINARY = 3'b100;
		5 : CHAN_BOND_LEVEL_0_BINARY = 3'b101;
		6 : CHAN_BOND_LEVEL_0_BINARY = 3'b110;
		7 : CHAN_BOND_LEVEL_0_BINARY = 3'b111;
		default : begin
			$display("Attribute Syntax Error : The Attribute CHAN_BOND_LEVEL_0 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 0 to 7.", CHAN_BOND_LEVEL_0);
			$finish;
		end
	endcase

	case (CHAN_BOND_SEQ_LEN_0)
		1 : CHAN_BOND_SEQ_LEN_0_BINARY = 2'b00;
		2 : CHAN_BOND_SEQ_LEN_0_BINARY = 2'b01;
		3 : CHAN_BOND_SEQ_LEN_0_BINARY = 2'b10;
		4 : CHAN_BOND_SEQ_LEN_0_BINARY = 2'b11;
		default : begin
			$display("Attribute Syntax Error : The Attribute CHAN_BOND_SEQ_LEN_0 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1, 2, 3 or 4.", CHAN_BOND_SEQ_LEN_0);
			$finish;
		end
	endcase

	case (CHAN_BOND_SEQ_2_USE_0)
		"FALSE" : CHAN_BOND_SEQ_2_USE_0_BINARY = 1'b0;
		"TRUE" : CHAN_BOND_SEQ_2_USE_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute CHAN_BOND_SEQ_2_USE_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", CHAN_BOND_SEQ_2_USE_0);
			$finish;
		end
	endcase

	case (CHAN_BOND_1_MAX_SKEW_0)
		1 : CHAN_BOND_1_MAX_SKEW_0_BINARY = 4'b0001;
		2 : CHAN_BOND_1_MAX_SKEW_0_BINARY = 4'b0010;
		3 : CHAN_BOND_1_MAX_SKEW_0_BINARY = 4'b0011;
		4 : CHAN_BOND_1_MAX_SKEW_0_BINARY = 4'b0100;
		5 : CHAN_BOND_1_MAX_SKEW_0_BINARY = 4'b0101;
		6 : CHAN_BOND_1_MAX_SKEW_0_BINARY = 4'b0110;
		7 : CHAN_BOND_1_MAX_SKEW_0_BINARY = 4'b0111;
		8 : CHAN_BOND_1_MAX_SKEW_0_BINARY = 4'b1000;
		9 : CHAN_BOND_1_MAX_SKEW_0_BINARY = 4'b1001;
		10 : CHAN_BOND_1_MAX_SKEW_0_BINARY = 4'b1010;
		11 : CHAN_BOND_1_MAX_SKEW_0_BINARY = 4'b1011;
		12 : CHAN_BOND_1_MAX_SKEW_0_BINARY = 4'b1100;
		13 : CHAN_BOND_1_MAX_SKEW_0_BINARY = 4'b1101;
		14 : CHAN_BOND_1_MAX_SKEW_0_BINARY = 4'b1110;
		default : begin
			$display("Attribute Syntax Error : The Attribute CHAN_BOND_1_MAX_SKEW_0 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1 to 14.", CHAN_BOND_1_MAX_SKEW_0);
			$finish;
		end
	endcase

	case (CHAN_BOND_2_MAX_SKEW_0)
		1 : CHAN_BOND_2_MAX_SKEW_0_BINARY = 4'b0001;
		2 : CHAN_BOND_2_MAX_SKEW_0_BINARY = 4'b0010;
		3 : CHAN_BOND_2_MAX_SKEW_0_BINARY = 4'b0011;
		4 : CHAN_BOND_2_MAX_SKEW_0_BINARY = 4'b0100;
		5 : CHAN_BOND_2_MAX_SKEW_0_BINARY = 4'b0101;
		6 : CHAN_BOND_2_MAX_SKEW_0_BINARY = 4'b0110;
		7 : CHAN_BOND_2_MAX_SKEW_0_BINARY = 4'b0111;
		8 : CHAN_BOND_2_MAX_SKEW_0_BINARY = 4'b1000;
		9 : CHAN_BOND_2_MAX_SKEW_0_BINARY = 4'b1001;
		10 : CHAN_BOND_2_MAX_SKEW_0_BINARY = 4'b1010;
		11 : CHAN_BOND_2_MAX_SKEW_0_BINARY = 4'b1011;
		12 : CHAN_BOND_2_MAX_SKEW_0_BINARY = 4'b1100;
		13 : CHAN_BOND_2_MAX_SKEW_0_BINARY = 4'b1101;
		14 : CHAN_BOND_2_MAX_SKEW_0_BINARY = 4'b1110;
		default : begin
			$display("Attribute Syntax Error : The Attribute CHAN_BOND_2_MAX_SKEW_0 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1 to 14.", CHAN_BOND_2_MAX_SKEW_0);
			$finish;
		end
	endcase

	case (CHAN_BOND_KEEP_ALIGN_0)
		"FALSE" : CHAN_BOND_KEEP_ALIGN_0_BINARY = 1'b0;
		"TRUE" : CHAN_BOND_KEEP_ALIGN_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute CHAN_BOND_KEEP_ALIGN_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", CHAN_BOND_KEEP_ALIGN_0);
			$finish;
		end
	endcase

	case (CB2_INH_CC_PERIOD_0)
		0 : CB2_INH_CC_PERIOD_0_BINARY = 4'b0000;
		1 : CB2_INH_CC_PERIOD_0_BINARY = 4'b0001;
		2 : CB2_INH_CC_PERIOD_0_BINARY = 4'b0010;
		3 : CB2_INH_CC_PERIOD_0_BINARY = 4'b0011;
		4 : CB2_INH_CC_PERIOD_0_BINARY = 4'b0100;
		5 : CB2_INH_CC_PERIOD_0_BINARY = 4'b0101;
		6 : CB2_INH_CC_PERIOD_0_BINARY = 4'b0110;
		7 : CB2_INH_CC_PERIOD_0_BINARY = 4'b0111;
		8 : CB2_INH_CC_PERIOD_0_BINARY = 4'b1000;
		9 : CB2_INH_CC_PERIOD_0_BINARY = 4'b1001;
		10 : CB2_INH_CC_PERIOD_0_BINARY = 4'b1010;
		11 : CB2_INH_CC_PERIOD_0_BINARY = 4'b1011;
		12 : CB2_INH_CC_PERIOD_0_BINARY = 4'b1100;
		13 : CB2_INH_CC_PERIOD_0_BINARY = 4'b1101;
		14 : CB2_INH_CC_PERIOD_0_BINARY = 4'b1110;
		15 : CB2_INH_CC_PERIOD_0_BINARY = 4'b1111;
		default : begin
			$display("Attribute Syntax Error : The Attribute CB2_INH_CC_PERIOD_0 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 0 to 15.", CB2_INH_CC_PERIOD_0);
			$finish;
		end
	endcase

	case (CHAN_BOND_MODE_1)
		"OFF" : CHAN_BOND_MODE_1_BINARY = 2'b00;
		"MASTER" : CHAN_BOND_MODE_1_BINARY = 2'b01;
		"SLAVE" : CHAN_BOND_MODE_1_BINARY = 2'b10;
		default : begin
			$display("Attribute Syntax Error : The Attribute CHAN_BOND_MODE_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are OFF, MASTER or SLAVE.", CHAN_BOND_MODE_1);
			$finish;
		end
	endcase

	case (CHAN_BOND_LEVEL_1)
		0 : CHAN_BOND_LEVEL_1_BINARY = 3'b000;
		1 : CHAN_BOND_LEVEL_1_BINARY = 3'b001;
		2 : CHAN_BOND_LEVEL_1_BINARY = 3'b010;
		3 : CHAN_BOND_LEVEL_1_BINARY = 3'b011;
		4 : CHAN_BOND_LEVEL_1_BINARY = 3'b100;
		5 : CHAN_BOND_LEVEL_1_BINARY = 3'b101;
		6 : CHAN_BOND_LEVEL_1_BINARY = 3'b110;
		7 : CHAN_BOND_LEVEL_1_BINARY = 3'b111;
		default : begin
			$display("Attribute Syntax Error : The Attribute CHAN_BOND_LEVEL_1 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 0 to 7.", CHAN_BOND_LEVEL_1);
			$finish;
		end
	endcase

	case (CHAN_BOND_SEQ_LEN_1)
		1 : CHAN_BOND_SEQ_LEN_1_BINARY = 2'b00;
		2 : CHAN_BOND_SEQ_LEN_1_BINARY = 2'b01;
		3 : CHAN_BOND_SEQ_LEN_1_BINARY = 2'b10;
		4 : CHAN_BOND_SEQ_LEN_1_BINARY = 2'b11;
		default : begin
			$display("Attribute Syntax Error : The Attribute CHAN_BOND_SEQ_LEN_1 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1, 2, 3 or 4.", CHAN_BOND_SEQ_LEN_1);
			$finish;
		end
	endcase

	case (CHAN_BOND_SEQ_2_USE_1)
		"FALSE" : CHAN_BOND_SEQ_2_USE_1_BINARY = 1'b0;
		"TRUE" : CHAN_BOND_SEQ_2_USE_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute CHAN_BOND_SEQ_2_USE_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", CHAN_BOND_SEQ_2_USE_1);
			$finish;
		end
	endcase

	case (CHAN_BOND_1_MAX_SKEW_1)
		1 : CHAN_BOND_1_MAX_SKEW_1_BINARY = 4'b0001;
		2 : CHAN_BOND_1_MAX_SKEW_1_BINARY = 4'b0010;
		3 : CHAN_BOND_1_MAX_SKEW_1_BINARY = 4'b0011;
		4 : CHAN_BOND_1_MAX_SKEW_1_BINARY = 4'b0100;
		5 : CHAN_BOND_1_MAX_SKEW_1_BINARY = 4'b0101;
		6 : CHAN_BOND_1_MAX_SKEW_1_BINARY = 4'b0110;
		7 : CHAN_BOND_1_MAX_SKEW_1_BINARY = 4'b0111;
		8 : CHAN_BOND_1_MAX_SKEW_1_BINARY = 4'b1000;
		9 : CHAN_BOND_1_MAX_SKEW_1_BINARY = 4'b1001;
		10 : CHAN_BOND_1_MAX_SKEW_1_BINARY = 4'b1010;
		11 : CHAN_BOND_1_MAX_SKEW_1_BINARY = 4'b1011;
		12 : CHAN_BOND_1_MAX_SKEW_1_BINARY = 4'b1100;
		13 : CHAN_BOND_1_MAX_SKEW_1_BINARY = 4'b1101;
		14 : CHAN_BOND_1_MAX_SKEW_1_BINARY = 4'b1110;
		default : begin
			$display("Attribute Syntax Error : The Attribute CHAN_BOND_1_MAX_SKEW_1 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1 to 14.", CHAN_BOND_1_MAX_SKEW_1);
			$finish;
		end
	endcase

	case (CHAN_BOND_2_MAX_SKEW_1)
		1 : CHAN_BOND_2_MAX_SKEW_1_BINARY = 4'b0001;
		2 : CHAN_BOND_2_MAX_SKEW_1_BINARY = 4'b0010;
		3 : CHAN_BOND_2_MAX_SKEW_1_BINARY = 4'b0011;
		4 : CHAN_BOND_2_MAX_SKEW_1_BINARY = 4'b0100;
		5 : CHAN_BOND_2_MAX_SKEW_1_BINARY = 4'b0101;
		6 : CHAN_BOND_2_MAX_SKEW_1_BINARY = 4'b0110;
		7 : CHAN_BOND_2_MAX_SKEW_1_BINARY = 4'b0111;
		8 : CHAN_BOND_2_MAX_SKEW_1_BINARY = 4'b1000;
		9 : CHAN_BOND_2_MAX_SKEW_1_BINARY = 4'b1001;
		10 : CHAN_BOND_2_MAX_SKEW_1_BINARY = 4'b1010;
		11 : CHAN_BOND_2_MAX_SKEW_1_BINARY = 4'b1011;
		12 : CHAN_BOND_2_MAX_SKEW_1_BINARY = 4'b1100;
		13 : CHAN_BOND_2_MAX_SKEW_1_BINARY = 4'b1101;
		14 : CHAN_BOND_2_MAX_SKEW_1_BINARY = 4'b1110;
		default : begin
			$display("Attribute Syntax Error : The Attribute CHAN_BOND_2_MAX_SKEW_1 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1 to 14.", CHAN_BOND_2_MAX_SKEW_1);
			$finish;
		end
	endcase

	case (CHAN_BOND_KEEP_ALIGN_1)
		"FALSE" : CHAN_BOND_KEEP_ALIGN_1_BINARY = 1'b0;
		"TRUE" : CHAN_BOND_KEEP_ALIGN_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute CHAN_BOND_KEEP_ALIGN_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", CHAN_BOND_KEEP_ALIGN_1);
			$finish;
		end
	endcase

	case (CB2_INH_CC_PERIOD_1)
		0 : CB2_INH_CC_PERIOD_1_BINARY = 4'b0000;
		1 : CB2_INH_CC_PERIOD_1_BINARY = 4'b0001;
		2 : CB2_INH_CC_PERIOD_1_BINARY = 4'b0010;
		3 : CB2_INH_CC_PERIOD_1_BINARY = 4'b0011;
		4 : CB2_INH_CC_PERIOD_1_BINARY = 4'b0100;
		5 : CB2_INH_CC_PERIOD_1_BINARY = 4'b0101;
		6 : CB2_INH_CC_PERIOD_1_BINARY = 4'b0110;
		7 : CB2_INH_CC_PERIOD_1_BINARY = 4'b0111;
		8 : CB2_INH_CC_PERIOD_1_BINARY = 4'b1000;
		9 : CB2_INH_CC_PERIOD_1_BINARY = 4'b1001;
		10 : CB2_INH_CC_PERIOD_1_BINARY = 4'b1010;
		11 : CB2_INH_CC_PERIOD_1_BINARY = 4'b1011;
		12 : CB2_INH_CC_PERIOD_1_BINARY = 4'b1100;
		13 : CB2_INH_CC_PERIOD_1_BINARY = 4'b1101;
		14 : CB2_INH_CC_PERIOD_1_BINARY = 4'b1110;
		15 : CB2_INH_CC_PERIOD_1_BINARY = 4'b1111;
		default : begin
			$display("Attribute Syntax Error : The Attribute CB2_INH_CC_PERIOD_1 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 0 to 15.", CB2_INH_CC_PERIOD_1);
			$finish;
		end
	endcase

	case (PCI_EXPRESS_MODE_0)
		"FALSE" : PCI_EXPRESS_MODE_0_BINARY = 1'b0;
		"TRUE" : PCI_EXPRESS_MODE_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute PCI_EXPRESS_MODE_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", PCI_EXPRESS_MODE_0);
			$finish;
		end
	endcase

	case (PCI_EXPRESS_MODE_1)
		"FALSE" : PCI_EXPRESS_MODE_1_BINARY = 1'b0;
		"TRUE" : PCI_EXPRESS_MODE_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute PCI_EXPRESS_MODE_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", PCI_EXPRESS_MODE_1);
			$finish;
		end
	endcase

	case (RX_STATUS_FMT_0)
		"PCIE" : RX_STATUS_FMT_0_BINARY = 1'b0;
		"SATA" : RX_STATUS_FMT_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute RX_STATUS_FMT_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are PCIE or SATA.", RX_STATUS_FMT_0);
			$finish;
		end
	endcase

	case (TX_BUFFER_USE_0)
		"FALSE" : TX_BUFFER_USE_0_BINARY = 1'b0;
		"TRUE" : TX_BUFFER_USE_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute TX_BUFFER_USE_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", TX_BUFFER_USE_0);
			$finish;
		end
	endcase

	case (TX_XCLK_SEL_0)
		"TXUSR" : TX_XCLK_SEL_0_BINARY = 1'b1;
		"TXOUT" : TX_XCLK_SEL_0_BINARY = 1'b0;
		default : begin
			$display("Attribute Syntax Error : The Attribute TX_XCLK_SEL_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TXUSR or TXOUT.", TX_XCLK_SEL_0);
			$finish;
		end
	endcase

	case (RX_XCLK_SEL_0)
		"RXREC" : RX_XCLK_SEL_0_BINARY = 1'b0;
		"RXUSR" : RX_XCLK_SEL_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute RX_XCLK_SEL_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are RXREC or RXUSR.", RX_XCLK_SEL_0);
			$finish;
		end
	endcase

	case (RX_STATUS_FMT_1)
		"PCIE" : RX_STATUS_FMT_1_BINARY = 1'b0;
		"SATA" : RX_STATUS_FMT_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute RX_STATUS_FMT_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are PCIE or SATA.", RX_STATUS_FMT_1);
			$finish;
		end
	endcase

	case (TX_BUFFER_USE_1)
		"FALSE" : TX_BUFFER_USE_1_BINARY = 1'b0;
		"TRUE" : TX_BUFFER_USE_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute TX_BUFFER_USE_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", TX_BUFFER_USE_1);
			$finish;
		end
	endcase

	case (TX_XCLK_SEL_1)
		"TXUSR" : TX_XCLK_SEL_1_BINARY = 1'b1;
		"TXOUT" : TX_XCLK_SEL_1_BINARY = 1'b0;
		default : begin
			$display("Attribute Syntax Error : The Attribute TX_XCLK_SEL_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TXUSR or TXOUT.", TX_XCLK_SEL_1);
			$finish;
		end
	endcase

	case (RX_XCLK_SEL_1)
		"RXREC" : RX_XCLK_SEL_1_BINARY = 1'b0;
		"RXUSR" : RX_XCLK_SEL_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute RX_XCLK_SEL_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are RXREC or RXUSR.", RX_XCLK_SEL_1);
			$finish;
		end
	endcase

	case (RX_SLIDE_MODE_0)
		"PCS" : RX_SLIDE_MODE_0_BINARY = 1'b0;
		"PMA" : RX_SLIDE_MODE_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute RX_SLIDE_MODE_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are PCS or PMA.", RX_SLIDE_MODE_0);
			$finish;
		end
	endcase

	case (RX_SLIDE_MODE_1)
		"PCS" : RX_SLIDE_MODE_1_BINARY = 1'b0;
		"PMA" : RX_SLIDE_MODE_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute RX_SLIDE_MODE_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are PCS or PMA.", RX_SLIDE_MODE_1);
			$finish;
		end
	endcase

	case (SATA_MIN_BURST_0)
		1 : SATA_MIN_BURST_0_BINARY = 6'b000001;
		2 : SATA_MIN_BURST_0_BINARY = 6'b000010;
		3 : SATA_MIN_BURST_0_BINARY = 6'b000011;
		4 : SATA_MIN_BURST_0_BINARY = 6'b000100;
		5 : SATA_MIN_BURST_0_BINARY = 6'b000101;
		6 : SATA_MIN_BURST_0_BINARY = 6'b000110;
		7 : SATA_MIN_BURST_0_BINARY = 6'b000111;
		8 : SATA_MIN_BURST_0_BINARY = 6'b001000;
		9 : SATA_MIN_BURST_0_BINARY = 6'b001001;
		10 : SATA_MIN_BURST_0_BINARY = 6'b001010;
		11 : SATA_MIN_BURST_0_BINARY = 6'b001011;
		12 : SATA_MIN_BURST_0_BINARY = 6'b001100;
		13 : SATA_MIN_BURST_0_BINARY = 6'b001101;
		14 : SATA_MIN_BURST_0_BINARY = 6'b001110;
		15 : SATA_MIN_BURST_0_BINARY = 6'b001111;
		16 : SATA_MIN_BURST_0_BINARY = 6'b010000;
		17 : SATA_MIN_BURST_0_BINARY = 6'b010001;
		18 : SATA_MIN_BURST_0_BINARY = 6'b010010;
		19 : SATA_MIN_BURST_0_BINARY = 6'b010011;
		20 : SATA_MIN_BURST_0_BINARY = 6'b010100;
		21 : SATA_MIN_BURST_0_BINARY = 6'b010101;
		22 : SATA_MIN_BURST_0_BINARY = 6'b010110;
		23 : SATA_MIN_BURST_0_BINARY = 6'b010111;
		24 : SATA_MIN_BURST_0_BINARY = 6'b011000;
		25 : SATA_MIN_BURST_0_BINARY = 6'b011001;
		26 : SATA_MIN_BURST_0_BINARY = 6'b011010;
		27 : SATA_MIN_BURST_0_BINARY = 6'b011011;
		28 : SATA_MIN_BURST_0_BINARY = 6'b011100;
		29 : SATA_MIN_BURST_0_BINARY = 6'b011101;
		30 : SATA_MIN_BURST_0_BINARY = 6'b011110;
		31 : SATA_MIN_BURST_0_BINARY = 6'b011111;
		32 : SATA_MIN_BURST_0_BINARY = 6'b100000;
		33 : SATA_MIN_BURST_0_BINARY = 6'b100001;
		34 : SATA_MIN_BURST_0_BINARY = 6'b100010;
		35 : SATA_MIN_BURST_0_BINARY = 6'b100011;
		36 : SATA_MIN_BURST_0_BINARY = 6'b100100;
		37 : SATA_MIN_BURST_0_BINARY = 6'b100101;
		38 : SATA_MIN_BURST_0_BINARY = 6'b100110;
		39 : SATA_MIN_BURST_0_BINARY = 6'b100111;
		40 : SATA_MIN_BURST_0_BINARY = 6'b101000;
		41 : SATA_MIN_BURST_0_BINARY = 6'b101001;
		42 : SATA_MIN_BURST_0_BINARY = 6'b101010;
		43 : SATA_MIN_BURST_0_BINARY = 6'b101011;
		44 : SATA_MIN_BURST_0_BINARY = 6'b101100;
		45 : SATA_MIN_BURST_0_BINARY = 6'b101101;
		46 : SATA_MIN_BURST_0_BINARY = 6'b101110;
		47 : SATA_MIN_BURST_0_BINARY = 6'b101111;
		48 : SATA_MIN_BURST_0_BINARY = 6'b110000;
		49 : SATA_MIN_BURST_0_BINARY = 6'b110001;
		50 : SATA_MIN_BURST_0_BINARY = 6'b110010;
		51 : SATA_MIN_BURST_0_BINARY = 6'b110011;
		52 : SATA_MIN_BURST_0_BINARY = 6'b110100;
		53 : SATA_MIN_BURST_0_BINARY = 6'b110101;
		54 : SATA_MIN_BURST_0_BINARY = 6'b110110;
		55 : SATA_MIN_BURST_0_BINARY = 6'b110111;
		56 : SATA_MIN_BURST_0_BINARY = 6'b111000;
		57 : SATA_MIN_BURST_0_BINARY = 6'b111001;
		58 : SATA_MIN_BURST_0_BINARY = 6'b111010;
		59 : SATA_MIN_BURST_0_BINARY = 6'b111011;
		60 : SATA_MIN_BURST_0_BINARY = 6'b111100;
		61 : SATA_MIN_BURST_0_BINARY = 6'b111101;
		default : begin
			$display("Attribute Syntax Error : The Attribute SATA_MIN_BURST_0 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1 to 61.", SATA_MIN_BURST_0);
			$finish;
		end
	endcase

	case (SATA_MAX_BURST_0)
		1 : SATA_MAX_BURST_0_BINARY = 6'b000001;
		2 : SATA_MAX_BURST_0_BINARY = 6'b000010;
		3 : SATA_MAX_BURST_0_BINARY = 6'b000011;
		4 : SATA_MAX_BURST_0_BINARY = 6'b000100;
		5 : SATA_MAX_BURST_0_BINARY = 6'b000101;
		6 : SATA_MAX_BURST_0_BINARY = 6'b000110;
		7 : SATA_MAX_BURST_0_BINARY = 6'b000111;
		8 : SATA_MAX_BURST_0_BINARY = 6'b001000;
		9 : SATA_MAX_BURST_0_BINARY = 6'b001001;
		10 : SATA_MAX_BURST_0_BINARY = 6'b001010;
		11 : SATA_MAX_BURST_0_BINARY = 6'b001011;
		12 : SATA_MAX_BURST_0_BINARY = 6'b001100;
		13 : SATA_MAX_BURST_0_BINARY = 6'b001101;
		14 : SATA_MAX_BURST_0_BINARY = 6'b001110;
		15 : SATA_MAX_BURST_0_BINARY = 6'b001111;
		16 : SATA_MAX_BURST_0_BINARY = 6'b010000;
		17 : SATA_MAX_BURST_0_BINARY = 6'b010001;
		18 : SATA_MAX_BURST_0_BINARY = 6'b010010;
		19 : SATA_MAX_BURST_0_BINARY = 6'b010011;
		20 : SATA_MAX_BURST_0_BINARY = 6'b010100;
		21 : SATA_MAX_BURST_0_BINARY = 6'b010101;
		22 : SATA_MAX_BURST_0_BINARY = 6'b010110;
		23 : SATA_MAX_BURST_0_BINARY = 6'b010111;
		24 : SATA_MAX_BURST_0_BINARY = 6'b011000;
		25 : SATA_MAX_BURST_0_BINARY = 6'b011001;
		26 : SATA_MAX_BURST_0_BINARY = 6'b011010;
		27 : SATA_MAX_BURST_0_BINARY = 6'b011011;
		28 : SATA_MAX_BURST_0_BINARY = 6'b011100;
		29 : SATA_MAX_BURST_0_BINARY = 6'b011101;
		30 : SATA_MAX_BURST_0_BINARY = 6'b011110;
		31 : SATA_MAX_BURST_0_BINARY = 6'b011111;
		32 : SATA_MAX_BURST_0_BINARY = 6'b100000;
		33 : SATA_MAX_BURST_0_BINARY = 6'b100001;
		34 : SATA_MAX_BURST_0_BINARY = 6'b100010;
		35 : SATA_MAX_BURST_0_BINARY = 6'b100011;
		36 : SATA_MAX_BURST_0_BINARY = 6'b100100;
		37 : SATA_MAX_BURST_0_BINARY = 6'b100101;
		38 : SATA_MAX_BURST_0_BINARY = 6'b100110;
		39 : SATA_MAX_BURST_0_BINARY = 6'b100111;
		40 : SATA_MAX_BURST_0_BINARY = 6'b101000;
		41 : SATA_MAX_BURST_0_BINARY = 6'b101001;
		42 : SATA_MAX_BURST_0_BINARY = 6'b101010;
		43 : SATA_MAX_BURST_0_BINARY = 6'b101011;
		44 : SATA_MAX_BURST_0_BINARY = 6'b101100;
		45 : SATA_MAX_BURST_0_BINARY = 6'b101101;
		46 : SATA_MAX_BURST_0_BINARY = 6'b101110;
		47 : SATA_MAX_BURST_0_BINARY = 6'b101111;
		48 : SATA_MAX_BURST_0_BINARY = 6'b110000;
		49 : SATA_MAX_BURST_0_BINARY = 6'b110001;
		50 : SATA_MAX_BURST_0_BINARY = 6'b110010;
		51 : SATA_MAX_BURST_0_BINARY = 6'b110011;
		52 : SATA_MAX_BURST_0_BINARY = 6'b110100;
		53 : SATA_MAX_BURST_0_BINARY = 6'b110101;
		54 : SATA_MAX_BURST_0_BINARY = 6'b110110;
		55 : SATA_MAX_BURST_0_BINARY = 6'b110111;
		56 : SATA_MAX_BURST_0_BINARY = 6'b111000;
		57 : SATA_MAX_BURST_0_BINARY = 6'b111001;
		58 : SATA_MAX_BURST_0_BINARY = 6'b111010;
		59 : SATA_MAX_BURST_0_BINARY = 6'b111011;
		60 : SATA_MAX_BURST_0_BINARY = 6'b111100;
		61 : SATA_MAX_BURST_0_BINARY = 6'b111101;
		default : begin
			$display("Attribute Syntax Error : The Attribute SATA_MAX_BURST_0 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1 to 61.", SATA_MAX_BURST_0);
			$finish;
		end
	endcase

	case (SATA_MIN_INIT_0)
		1 : SATA_MIN_INIT_0_BINARY = 6'b000001;
		2 : SATA_MIN_INIT_0_BINARY = 6'b000010;
		3 : SATA_MIN_INIT_0_BINARY = 6'b000011;
		4 : SATA_MIN_INIT_0_BINARY = 6'b000100;
		5 : SATA_MIN_INIT_0_BINARY = 6'b000101;
		6 : SATA_MIN_INIT_0_BINARY = 6'b000110;
		7 : SATA_MIN_INIT_0_BINARY = 6'b000111;
		8 : SATA_MIN_INIT_0_BINARY = 6'b001000;
		9 : SATA_MIN_INIT_0_BINARY = 6'b001001;
		10 : SATA_MIN_INIT_0_BINARY = 6'b001010;
		11 : SATA_MIN_INIT_0_BINARY = 6'b001011;
		12 : SATA_MIN_INIT_0_BINARY = 6'b001100;
		13 : SATA_MIN_INIT_0_BINARY = 6'b001101;
		14 : SATA_MIN_INIT_0_BINARY = 6'b001110;
		15 : SATA_MIN_INIT_0_BINARY = 6'b001111;
		16 : SATA_MIN_INIT_0_BINARY = 6'b010000;
		17 : SATA_MIN_INIT_0_BINARY = 6'b010001;
		18 : SATA_MIN_INIT_0_BINARY = 6'b010010;
		19 : SATA_MIN_INIT_0_BINARY = 6'b010011;
		20 : SATA_MIN_INIT_0_BINARY = 6'b010100;
		21 : SATA_MIN_INIT_0_BINARY = 6'b010101;
		22 : SATA_MIN_INIT_0_BINARY = 6'b010110;
		23 : SATA_MIN_INIT_0_BINARY = 6'b010111;
		24 : SATA_MIN_INIT_0_BINARY = 6'b011000;
		25 : SATA_MIN_INIT_0_BINARY = 6'b011001;
		26 : SATA_MIN_INIT_0_BINARY = 6'b011010;
		27 : SATA_MIN_INIT_0_BINARY = 6'b011011;
		28 : SATA_MIN_INIT_0_BINARY = 6'b011100;
		29 : SATA_MIN_INIT_0_BINARY = 6'b011101;
		30 : SATA_MIN_INIT_0_BINARY = 6'b011110;
		31 : SATA_MIN_INIT_0_BINARY = 6'b011111;
		32 : SATA_MIN_INIT_0_BINARY = 6'b100000;
		33 : SATA_MIN_INIT_0_BINARY = 6'b100001;
		34 : SATA_MIN_INIT_0_BINARY = 6'b100010;
		35 : SATA_MIN_INIT_0_BINARY = 6'b100011;
		36 : SATA_MIN_INIT_0_BINARY = 6'b100100;
		37 : SATA_MIN_INIT_0_BINARY = 6'b100101;
		38 : SATA_MIN_INIT_0_BINARY = 6'b100110;
		39 : SATA_MIN_INIT_0_BINARY = 6'b100111;
		40 : SATA_MIN_INIT_0_BINARY = 6'b101000;
		41 : SATA_MIN_INIT_0_BINARY = 6'b101001;
		42 : SATA_MIN_INIT_0_BINARY = 6'b101010;
		43 : SATA_MIN_INIT_0_BINARY = 6'b101011;
		44 : SATA_MIN_INIT_0_BINARY = 6'b101100;
		45 : SATA_MIN_INIT_0_BINARY = 6'b101101;
		46 : SATA_MIN_INIT_0_BINARY = 6'b101110;
		47 : SATA_MIN_INIT_0_BINARY = 6'b101111;
		48 : SATA_MIN_INIT_0_BINARY = 6'b110000;
		49 : SATA_MIN_INIT_0_BINARY = 6'b110001;
		50 : SATA_MIN_INIT_0_BINARY = 6'b110010;
		51 : SATA_MIN_INIT_0_BINARY = 6'b110011;
		52 : SATA_MIN_INIT_0_BINARY = 6'b110100;
		53 : SATA_MIN_INIT_0_BINARY = 6'b110101;
		54 : SATA_MIN_INIT_0_BINARY = 6'b110110;
		55 : SATA_MIN_INIT_0_BINARY = 6'b110111;
		56 : SATA_MIN_INIT_0_BINARY = 6'b111000;
		57 : SATA_MIN_INIT_0_BINARY = 6'b111001;
		58 : SATA_MIN_INIT_0_BINARY = 6'b111010;
		59 : SATA_MIN_INIT_0_BINARY = 6'b111011;
		60 : SATA_MIN_INIT_0_BINARY = 6'b111100;
		61 : SATA_MIN_INIT_0_BINARY = 6'b111101;
		default : begin
			$display("Attribute Syntax Error : The Attribute SATA_MIN_INIT_0 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1 to 61.", SATA_MIN_INIT_0);
			$finish;
		end
	endcase

	case (SATA_MAX_INIT_0)
		1 : SATA_MAX_INIT_0_BINARY = 6'b000001;
		2 : SATA_MAX_INIT_0_BINARY = 6'b000010;
		3 : SATA_MAX_INIT_0_BINARY = 6'b000011;
		4 : SATA_MAX_INIT_0_BINARY = 6'b000100;
		5 : SATA_MAX_INIT_0_BINARY = 6'b000101;
		6 : SATA_MAX_INIT_0_BINARY = 6'b000110;
		7 : SATA_MAX_INIT_0_BINARY = 6'b000111;
		8 : SATA_MAX_INIT_0_BINARY = 6'b001000;
		9 : SATA_MAX_INIT_0_BINARY = 6'b001001;
		10 : SATA_MAX_INIT_0_BINARY = 6'b001010;
		11 : SATA_MAX_INIT_0_BINARY = 6'b001011;
		12 : SATA_MAX_INIT_0_BINARY = 6'b001100;
		13 : SATA_MAX_INIT_0_BINARY = 6'b001101;
		14 : SATA_MAX_INIT_0_BINARY = 6'b001110;
		15 : SATA_MAX_INIT_0_BINARY = 6'b001111;
		16 : SATA_MAX_INIT_0_BINARY = 6'b010000;
		17 : SATA_MAX_INIT_0_BINARY = 6'b010001;
		18 : SATA_MAX_INIT_0_BINARY = 6'b010010;
		19 : SATA_MAX_INIT_0_BINARY = 6'b010011;
		20 : SATA_MAX_INIT_0_BINARY = 6'b010100;
		21 : SATA_MAX_INIT_0_BINARY = 6'b010101;
		22 : SATA_MAX_INIT_0_BINARY = 6'b010110;
		23 : SATA_MAX_INIT_0_BINARY = 6'b010111;
		24 : SATA_MAX_INIT_0_BINARY = 6'b011000;
		25 : SATA_MAX_INIT_0_BINARY = 6'b011001;
		26 : SATA_MAX_INIT_0_BINARY = 6'b011010;
		27 : SATA_MAX_INIT_0_BINARY = 6'b011011;
		28 : SATA_MAX_INIT_0_BINARY = 6'b011100;
		29 : SATA_MAX_INIT_0_BINARY = 6'b011101;
		30 : SATA_MAX_INIT_0_BINARY = 6'b011110;
		31 : SATA_MAX_INIT_0_BINARY = 6'b011111;
		32 : SATA_MAX_INIT_0_BINARY = 6'b100000;
		33 : SATA_MAX_INIT_0_BINARY = 6'b100001;
		34 : SATA_MAX_INIT_0_BINARY = 6'b100010;
		35 : SATA_MAX_INIT_0_BINARY = 6'b100011;
		36 : SATA_MAX_INIT_0_BINARY = 6'b100100;
		37 : SATA_MAX_INIT_0_BINARY = 6'b100101;
		38 : SATA_MAX_INIT_0_BINARY = 6'b100110;
		39 : SATA_MAX_INIT_0_BINARY = 6'b100111;
		40 : SATA_MAX_INIT_0_BINARY = 6'b101000;
		41 : SATA_MAX_INIT_0_BINARY = 6'b101001;
		42 : SATA_MAX_INIT_0_BINARY = 6'b101010;
		43 : SATA_MAX_INIT_0_BINARY = 6'b101011;
		44 : SATA_MAX_INIT_0_BINARY = 6'b101100;
		45 : SATA_MAX_INIT_0_BINARY = 6'b101101;
		46 : SATA_MAX_INIT_0_BINARY = 6'b101110;
		47 : SATA_MAX_INIT_0_BINARY = 6'b101111;
		48 : SATA_MAX_INIT_0_BINARY = 6'b110000;
		49 : SATA_MAX_INIT_0_BINARY = 6'b110001;
		50 : SATA_MAX_INIT_0_BINARY = 6'b110010;
		51 : SATA_MAX_INIT_0_BINARY = 6'b110011;
		52 : SATA_MAX_INIT_0_BINARY = 6'b110100;
		53 : SATA_MAX_INIT_0_BINARY = 6'b110101;
		54 : SATA_MAX_INIT_0_BINARY = 6'b110110;
		55 : SATA_MAX_INIT_0_BINARY = 6'b110111;
		56 : SATA_MAX_INIT_0_BINARY = 6'b111000;
		57 : SATA_MAX_INIT_0_BINARY = 6'b111001;
		58 : SATA_MAX_INIT_0_BINARY = 6'b111010;
		59 : SATA_MAX_INIT_0_BINARY = 6'b111011;
		60 : SATA_MAX_INIT_0_BINARY = 6'b111100;
		61 : SATA_MAX_INIT_0_BINARY = 6'b111101;
		default : begin
			$display("Attribute Syntax Error : The Attribute SATA_MAX_INIT_0 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1 to 61.", SATA_MAX_INIT_0);
			$finish;
		end
	endcase

	case (SATA_MIN_WAKE_0)
		1 : SATA_MIN_WAKE_0_BINARY = 6'b000001;
		2 : SATA_MIN_WAKE_0_BINARY = 6'b000010;
		3 : SATA_MIN_WAKE_0_BINARY = 6'b000011;
		4 : SATA_MIN_WAKE_0_BINARY = 6'b000100;
		5 : SATA_MIN_WAKE_0_BINARY = 6'b000101;
		6 : SATA_MIN_WAKE_0_BINARY = 6'b000110;
		7 : SATA_MIN_WAKE_0_BINARY = 6'b000111;
		8 : SATA_MIN_WAKE_0_BINARY = 6'b001000;
		9 : SATA_MIN_WAKE_0_BINARY = 6'b001001;
		10 : SATA_MIN_WAKE_0_BINARY = 6'b001010;
		11 : SATA_MIN_WAKE_0_BINARY = 6'b001011;
		12 : SATA_MIN_WAKE_0_BINARY = 6'b001100;
		13 : SATA_MIN_WAKE_0_BINARY = 6'b001101;
		14 : SATA_MIN_WAKE_0_BINARY = 6'b001110;
		15 : SATA_MIN_WAKE_0_BINARY = 6'b001111;
		16 : SATA_MIN_WAKE_0_BINARY = 6'b010000;
		17 : SATA_MIN_WAKE_0_BINARY = 6'b010001;
		18 : SATA_MIN_WAKE_0_BINARY = 6'b010010;
		19 : SATA_MIN_WAKE_0_BINARY = 6'b010011;
		20 : SATA_MIN_WAKE_0_BINARY = 6'b010100;
		21 : SATA_MIN_WAKE_0_BINARY = 6'b010101;
		22 : SATA_MIN_WAKE_0_BINARY = 6'b010110;
		23 : SATA_MIN_WAKE_0_BINARY = 6'b010111;
		24 : SATA_MIN_WAKE_0_BINARY = 6'b011000;
		25 : SATA_MIN_WAKE_0_BINARY = 6'b011001;
		26 : SATA_MIN_WAKE_0_BINARY = 6'b011010;
		27 : SATA_MIN_WAKE_0_BINARY = 6'b011011;
		28 : SATA_MIN_WAKE_0_BINARY = 6'b011100;
		29 : SATA_MIN_WAKE_0_BINARY = 6'b011101;
		30 : SATA_MIN_WAKE_0_BINARY = 6'b011110;
		31 : SATA_MIN_WAKE_0_BINARY = 6'b011111;
		32 : SATA_MIN_WAKE_0_BINARY = 6'b100000;
		33 : SATA_MIN_WAKE_0_BINARY = 6'b100001;
		34 : SATA_MIN_WAKE_0_BINARY = 6'b100010;
		35 : SATA_MIN_WAKE_0_BINARY = 6'b100011;
		36 : SATA_MIN_WAKE_0_BINARY = 6'b100100;
		37 : SATA_MIN_WAKE_0_BINARY = 6'b100101;
		38 : SATA_MIN_WAKE_0_BINARY = 6'b100110;
		39 : SATA_MIN_WAKE_0_BINARY = 6'b100111;
		40 : SATA_MIN_WAKE_0_BINARY = 6'b101000;
		41 : SATA_MIN_WAKE_0_BINARY = 6'b101001;
		42 : SATA_MIN_WAKE_0_BINARY = 6'b101010;
		43 : SATA_MIN_WAKE_0_BINARY = 6'b101011;
		44 : SATA_MIN_WAKE_0_BINARY = 6'b101100;
		45 : SATA_MIN_WAKE_0_BINARY = 6'b101101;
		46 : SATA_MIN_WAKE_0_BINARY = 6'b101110;
		47 : SATA_MIN_WAKE_0_BINARY = 6'b101111;
		48 : SATA_MIN_WAKE_0_BINARY = 6'b110000;
		49 : SATA_MIN_WAKE_0_BINARY = 6'b110001;
		50 : SATA_MIN_WAKE_0_BINARY = 6'b110010;
		51 : SATA_MIN_WAKE_0_BINARY = 6'b110011;
		52 : SATA_MIN_WAKE_0_BINARY = 6'b110100;
		53 : SATA_MIN_WAKE_0_BINARY = 6'b110101;
		54 : SATA_MIN_WAKE_0_BINARY = 6'b110110;
		55 : SATA_MIN_WAKE_0_BINARY = 6'b110111;
		56 : SATA_MIN_WAKE_0_BINARY = 6'b111000;
		57 : SATA_MIN_WAKE_0_BINARY = 6'b111001;
		58 : SATA_MIN_WAKE_0_BINARY = 6'b111010;
		59 : SATA_MIN_WAKE_0_BINARY = 6'b111011;
		60 : SATA_MIN_WAKE_0_BINARY = 6'b111100;
		61 : SATA_MIN_WAKE_0_BINARY = 6'b111101;
		default : begin
			$display("Attribute Syntax Error : The Attribute SATA_MIN_WAKE_0 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1 to 61.", SATA_MIN_WAKE_0);
			$finish;
		end
	endcase

	case (SATA_MAX_WAKE_0)
		1 : SATA_MAX_WAKE_0_BINARY = 6'b000001;
		2 : SATA_MAX_WAKE_0_BINARY = 6'b000010;
		3 : SATA_MAX_WAKE_0_BINARY = 6'b000011;
		4 : SATA_MAX_WAKE_0_BINARY = 6'b000100;
		5 : SATA_MAX_WAKE_0_BINARY = 6'b000101;
		6 : SATA_MAX_WAKE_0_BINARY = 6'b000110;
		7 : SATA_MAX_WAKE_0_BINARY = 6'b000111;
		8 : SATA_MAX_WAKE_0_BINARY = 6'b001000;
		9 : SATA_MAX_WAKE_0_BINARY = 6'b001001;
		10 : SATA_MAX_WAKE_0_BINARY = 6'b001010;
		11 : SATA_MAX_WAKE_0_BINARY = 6'b001011;
		12 : SATA_MAX_WAKE_0_BINARY = 6'b001100;
		13 : SATA_MAX_WAKE_0_BINARY = 6'b001101;
		14 : SATA_MAX_WAKE_0_BINARY = 6'b001110;
		15 : SATA_MAX_WAKE_0_BINARY = 6'b001111;
		16 : SATA_MAX_WAKE_0_BINARY = 6'b010000;
		17 : SATA_MAX_WAKE_0_BINARY = 6'b010001;
		18 : SATA_MAX_WAKE_0_BINARY = 6'b010010;
		19 : SATA_MAX_WAKE_0_BINARY = 6'b010011;
		20 : SATA_MAX_WAKE_0_BINARY = 6'b010100;
		21 : SATA_MAX_WAKE_0_BINARY = 6'b010101;
		22 : SATA_MAX_WAKE_0_BINARY = 6'b010110;
		23 : SATA_MAX_WAKE_0_BINARY = 6'b010111;
		24 : SATA_MAX_WAKE_0_BINARY = 6'b011000;
		25 : SATA_MAX_WAKE_0_BINARY = 6'b011001;
		26 : SATA_MAX_WAKE_0_BINARY = 6'b011010;
		27 : SATA_MAX_WAKE_0_BINARY = 6'b011011;
		28 : SATA_MAX_WAKE_0_BINARY = 6'b011100;
		29 : SATA_MAX_WAKE_0_BINARY = 6'b011101;
		30 : SATA_MAX_WAKE_0_BINARY = 6'b011110;
		31 : SATA_MAX_WAKE_0_BINARY = 6'b011111;
		32 : SATA_MAX_WAKE_0_BINARY = 6'b100000;
		33 : SATA_MAX_WAKE_0_BINARY = 6'b100001;
		34 : SATA_MAX_WAKE_0_BINARY = 6'b100010;
		35 : SATA_MAX_WAKE_0_BINARY = 6'b100011;
		36 : SATA_MAX_WAKE_0_BINARY = 6'b100100;
		37 : SATA_MAX_WAKE_0_BINARY = 6'b100101;
		38 : SATA_MAX_WAKE_0_BINARY = 6'b100110;
		39 : SATA_MAX_WAKE_0_BINARY = 6'b100111;
		40 : SATA_MAX_WAKE_0_BINARY = 6'b101000;
		41 : SATA_MAX_WAKE_0_BINARY = 6'b101001;
		42 : SATA_MAX_WAKE_0_BINARY = 6'b101010;
		43 : SATA_MAX_WAKE_0_BINARY = 6'b101011;
		44 : SATA_MAX_WAKE_0_BINARY = 6'b101100;
		45 : SATA_MAX_WAKE_0_BINARY = 6'b101101;
		46 : SATA_MAX_WAKE_0_BINARY = 6'b101110;
		47 : SATA_MAX_WAKE_0_BINARY = 6'b101111;
		48 : SATA_MAX_WAKE_0_BINARY = 6'b110000;
		49 : SATA_MAX_WAKE_0_BINARY = 6'b110001;
		50 : SATA_MAX_WAKE_0_BINARY = 6'b110010;
		51 : SATA_MAX_WAKE_0_BINARY = 6'b110011;
		52 : SATA_MAX_WAKE_0_BINARY = 6'b110100;
		53 : SATA_MAX_WAKE_0_BINARY = 6'b110101;
		54 : SATA_MAX_WAKE_0_BINARY = 6'b110110;
		55 : SATA_MAX_WAKE_0_BINARY = 6'b110111;
		56 : SATA_MAX_WAKE_0_BINARY = 6'b111000;
		57 : SATA_MAX_WAKE_0_BINARY = 6'b111001;
		58 : SATA_MAX_WAKE_0_BINARY = 6'b111010;
		59 : SATA_MAX_WAKE_0_BINARY = 6'b111011;
		60 : SATA_MAX_WAKE_0_BINARY = 6'b111100;
		61 : SATA_MAX_WAKE_0_BINARY = 6'b111101;
		default : begin
			$display("Attribute Syntax Error : The Attribute SATA_MAX_WAKE_0 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1 to 61.", SATA_MAX_WAKE_0);
			$finish;
		end
	endcase

	case (SATA_MIN_BURST_1)
		1 : SATA_MIN_BURST_1_BINARY = 6'b000001;
		2 : SATA_MIN_BURST_1_BINARY = 6'b000010;
		3 : SATA_MIN_BURST_1_BINARY = 6'b000011;
		4 : SATA_MIN_BURST_1_BINARY = 6'b000100;
		5 : SATA_MIN_BURST_1_BINARY = 6'b000101;
		6 : SATA_MIN_BURST_1_BINARY = 6'b000110;
		7 : SATA_MIN_BURST_1_BINARY = 6'b000111;
		8 : SATA_MIN_BURST_1_BINARY = 6'b001000;
		9 : SATA_MIN_BURST_1_BINARY = 6'b001001;
		10 : SATA_MIN_BURST_1_BINARY = 6'b001010;
		11 : SATA_MIN_BURST_1_BINARY = 6'b001011;
		12 : SATA_MIN_BURST_1_BINARY = 6'b001100;
		13 : SATA_MIN_BURST_1_BINARY = 6'b001101;
		14 : SATA_MIN_BURST_1_BINARY = 6'b001110;
		15 : SATA_MIN_BURST_1_BINARY = 6'b001111;
		16 : SATA_MIN_BURST_1_BINARY = 6'b010000;
		17 : SATA_MIN_BURST_1_BINARY = 6'b010001;
		18 : SATA_MIN_BURST_1_BINARY = 6'b010010;
		19 : SATA_MIN_BURST_1_BINARY = 6'b010011;
		20 : SATA_MIN_BURST_1_BINARY = 6'b010100;
		21 : SATA_MIN_BURST_1_BINARY = 6'b010101;
		22 : SATA_MIN_BURST_1_BINARY = 6'b010110;
		23 : SATA_MIN_BURST_1_BINARY = 6'b010111;
		24 : SATA_MIN_BURST_1_BINARY = 6'b011000;
		25 : SATA_MIN_BURST_1_BINARY = 6'b011001;
		26 : SATA_MIN_BURST_1_BINARY = 6'b011010;
		27 : SATA_MIN_BURST_1_BINARY = 6'b011011;
		28 : SATA_MIN_BURST_1_BINARY = 6'b011100;
		29 : SATA_MIN_BURST_1_BINARY = 6'b011101;
		30 : SATA_MIN_BURST_1_BINARY = 6'b011110;
		31 : SATA_MIN_BURST_1_BINARY = 6'b011111;
		32 : SATA_MIN_BURST_1_BINARY = 6'b100000;
		33 : SATA_MIN_BURST_1_BINARY = 6'b100001;
		34 : SATA_MIN_BURST_1_BINARY = 6'b100010;
		35 : SATA_MIN_BURST_1_BINARY = 6'b100011;
		36 : SATA_MIN_BURST_1_BINARY = 6'b100100;
		37 : SATA_MIN_BURST_1_BINARY = 6'b100101;
		38 : SATA_MIN_BURST_1_BINARY = 6'b100110;
		39 : SATA_MIN_BURST_1_BINARY = 6'b100111;
		40 : SATA_MIN_BURST_1_BINARY = 6'b101000;
		41 : SATA_MIN_BURST_1_BINARY = 6'b101001;
		42 : SATA_MIN_BURST_1_BINARY = 6'b101010;
		43 : SATA_MIN_BURST_1_BINARY = 6'b101011;
		44 : SATA_MIN_BURST_1_BINARY = 6'b101100;
		45 : SATA_MIN_BURST_1_BINARY = 6'b101101;
		46 : SATA_MIN_BURST_1_BINARY = 6'b101110;
		47 : SATA_MIN_BURST_1_BINARY = 6'b101111;
		48 : SATA_MIN_BURST_1_BINARY = 6'b110000;
		49 : SATA_MIN_BURST_1_BINARY = 6'b110001;
		50 : SATA_MIN_BURST_1_BINARY = 6'b110010;
		51 : SATA_MIN_BURST_1_BINARY = 6'b110011;
		52 : SATA_MIN_BURST_1_BINARY = 6'b110100;
		53 : SATA_MIN_BURST_1_BINARY = 6'b110101;
		54 : SATA_MIN_BURST_1_BINARY = 6'b110110;
		55 : SATA_MIN_BURST_1_BINARY = 6'b110111;
		56 : SATA_MIN_BURST_1_BINARY = 6'b111000;
		57 : SATA_MIN_BURST_1_BINARY = 6'b111001;
		58 : SATA_MIN_BURST_1_BINARY = 6'b111010;
		59 : SATA_MIN_BURST_1_BINARY = 6'b111011;
		60 : SATA_MIN_BURST_1_BINARY = 6'b111100;
		61 : SATA_MIN_BURST_1_BINARY = 6'b111101;
		default : begin
			$display("Attribute Syntax Error : The Attribute SATA_MIN_BURST_1 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1 to 61.", SATA_MIN_BURST_1);
			$finish;
		end
	endcase

	case (SATA_MAX_BURST_1)
		1 : SATA_MAX_BURST_1_BINARY = 6'b000001;
		2 : SATA_MAX_BURST_1_BINARY = 6'b000010;
		3 : SATA_MAX_BURST_1_BINARY = 6'b000011;
		4 : SATA_MAX_BURST_1_BINARY = 6'b000100;
		5 : SATA_MAX_BURST_1_BINARY = 6'b000101;
		6 : SATA_MAX_BURST_1_BINARY = 6'b000110;
		7 : SATA_MAX_BURST_1_BINARY = 6'b000111;
		8 : SATA_MAX_BURST_1_BINARY = 6'b001000;
		9 : SATA_MAX_BURST_1_BINARY = 6'b001001;
		10 : SATA_MAX_BURST_1_BINARY = 6'b001010;
		11 : SATA_MAX_BURST_1_BINARY = 6'b001011;
		12 : SATA_MAX_BURST_1_BINARY = 6'b001100;
		13 : SATA_MAX_BURST_1_BINARY = 6'b001101;
		14 : SATA_MAX_BURST_1_BINARY = 6'b001110;
		15 : SATA_MAX_BURST_1_BINARY = 6'b001111;
		16 : SATA_MAX_BURST_1_BINARY = 6'b010000;
		17 : SATA_MAX_BURST_1_BINARY = 6'b010001;
		18 : SATA_MAX_BURST_1_BINARY = 6'b010010;
		19 : SATA_MAX_BURST_1_BINARY = 6'b010011;
		20 : SATA_MAX_BURST_1_BINARY = 6'b010100;
		21 : SATA_MAX_BURST_1_BINARY = 6'b010101;
		22 : SATA_MAX_BURST_1_BINARY = 6'b010110;
		23 : SATA_MAX_BURST_1_BINARY = 6'b010111;
		24 : SATA_MAX_BURST_1_BINARY = 6'b011000;
		25 : SATA_MAX_BURST_1_BINARY = 6'b011001;
		26 : SATA_MAX_BURST_1_BINARY = 6'b011010;
		27 : SATA_MAX_BURST_1_BINARY = 6'b011011;
		28 : SATA_MAX_BURST_1_BINARY = 6'b011100;
		29 : SATA_MAX_BURST_1_BINARY = 6'b011101;
		30 : SATA_MAX_BURST_1_BINARY = 6'b011110;
		31 : SATA_MAX_BURST_1_BINARY = 6'b011111;
		32 : SATA_MAX_BURST_1_BINARY = 6'b100000;
		33 : SATA_MAX_BURST_1_BINARY = 6'b100001;
		34 : SATA_MAX_BURST_1_BINARY = 6'b100010;
		35 : SATA_MAX_BURST_1_BINARY = 6'b100011;
		36 : SATA_MAX_BURST_1_BINARY = 6'b100100;
		37 : SATA_MAX_BURST_1_BINARY = 6'b100101;
		38 : SATA_MAX_BURST_1_BINARY = 6'b100110;
		39 : SATA_MAX_BURST_1_BINARY = 6'b100111;
		40 : SATA_MAX_BURST_1_BINARY = 6'b101000;
		41 : SATA_MAX_BURST_1_BINARY = 6'b101001;
		42 : SATA_MAX_BURST_1_BINARY = 6'b101010;
		43 : SATA_MAX_BURST_1_BINARY = 6'b101011;
		44 : SATA_MAX_BURST_1_BINARY = 6'b101100;
		45 : SATA_MAX_BURST_1_BINARY = 6'b101101;
		46 : SATA_MAX_BURST_1_BINARY = 6'b101110;
		47 : SATA_MAX_BURST_1_BINARY = 6'b101111;
		48 : SATA_MAX_BURST_1_BINARY = 6'b110000;
		49 : SATA_MAX_BURST_1_BINARY = 6'b110001;
		50 : SATA_MAX_BURST_1_BINARY = 6'b110010;
		51 : SATA_MAX_BURST_1_BINARY = 6'b110011;
		52 : SATA_MAX_BURST_1_BINARY = 6'b110100;
		53 : SATA_MAX_BURST_1_BINARY = 6'b110101;
		54 : SATA_MAX_BURST_1_BINARY = 6'b110110;
		55 : SATA_MAX_BURST_1_BINARY = 6'b110111;
		56 : SATA_MAX_BURST_1_BINARY = 6'b111000;
		57 : SATA_MAX_BURST_1_BINARY = 6'b111001;
		58 : SATA_MAX_BURST_1_BINARY = 6'b111010;
		59 : SATA_MAX_BURST_1_BINARY = 6'b111011;
		60 : SATA_MAX_BURST_1_BINARY = 6'b111100;
		61 : SATA_MAX_BURST_1_BINARY = 6'b111101;
		default : begin
			$display("Attribute Syntax Error : The Attribute SATA_MAX_BURST_1 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1 to 61.", SATA_MAX_BURST_1);
			$finish;
		end
	endcase

	case (SATA_MIN_INIT_1)
		1 : SATA_MIN_INIT_1_BINARY = 6'b000001;
		2 : SATA_MIN_INIT_1_BINARY = 6'b000010;
		3 : SATA_MIN_INIT_1_BINARY = 6'b000011;
		4 : SATA_MIN_INIT_1_BINARY = 6'b000100;
		5 : SATA_MIN_INIT_1_BINARY = 6'b000101;
		6 : SATA_MIN_INIT_1_BINARY = 6'b000110;
		7 : SATA_MIN_INIT_1_BINARY = 6'b000111;
		8 : SATA_MIN_INIT_1_BINARY = 6'b001000;
		9 : SATA_MIN_INIT_1_BINARY = 6'b001001;
		10 : SATA_MIN_INIT_1_BINARY = 6'b001010;
		11 : SATA_MIN_INIT_1_BINARY = 6'b001011;
		12 : SATA_MIN_INIT_1_BINARY = 6'b001100;
		13 : SATA_MIN_INIT_1_BINARY = 6'b001101;
		14 : SATA_MIN_INIT_1_BINARY = 6'b001110;
		15 : SATA_MIN_INIT_1_BINARY = 6'b001111;
		16 : SATA_MIN_INIT_1_BINARY = 6'b010000;
		17 : SATA_MIN_INIT_1_BINARY = 6'b010001;
		18 : SATA_MIN_INIT_1_BINARY = 6'b010010;
		19 : SATA_MIN_INIT_1_BINARY = 6'b010011;
		20 : SATA_MIN_INIT_1_BINARY = 6'b010100;
		21 : SATA_MIN_INIT_1_BINARY = 6'b010101;
		22 : SATA_MIN_INIT_1_BINARY = 6'b010110;
		23 : SATA_MIN_INIT_1_BINARY = 6'b010111;
		24 : SATA_MIN_INIT_1_BINARY = 6'b011000;
		25 : SATA_MIN_INIT_1_BINARY = 6'b011001;
		26 : SATA_MIN_INIT_1_BINARY = 6'b011010;
		27 : SATA_MIN_INIT_1_BINARY = 6'b011011;
		28 : SATA_MIN_INIT_1_BINARY = 6'b011100;
		29 : SATA_MIN_INIT_1_BINARY = 6'b011101;
		30 : SATA_MIN_INIT_1_BINARY = 6'b011110;
		31 : SATA_MIN_INIT_1_BINARY = 6'b011111;
		32 : SATA_MIN_INIT_1_BINARY = 6'b100000;
		33 : SATA_MIN_INIT_1_BINARY = 6'b100001;
		34 : SATA_MIN_INIT_1_BINARY = 6'b100010;
		35 : SATA_MIN_INIT_1_BINARY = 6'b100011;
		36 : SATA_MIN_INIT_1_BINARY = 6'b100100;
		37 : SATA_MIN_INIT_1_BINARY = 6'b100101;
		38 : SATA_MIN_INIT_1_BINARY = 6'b100110;
		39 : SATA_MIN_INIT_1_BINARY = 6'b100111;
		40 : SATA_MIN_INIT_1_BINARY = 6'b101000;
		41 : SATA_MIN_INIT_1_BINARY = 6'b101001;
		42 : SATA_MIN_INIT_1_BINARY = 6'b101010;
		43 : SATA_MIN_INIT_1_BINARY = 6'b101011;
		44 : SATA_MIN_INIT_1_BINARY = 6'b101100;
		45 : SATA_MIN_INIT_1_BINARY = 6'b101101;
		46 : SATA_MIN_INIT_1_BINARY = 6'b101110;
		47 : SATA_MIN_INIT_1_BINARY = 6'b101111;
		48 : SATA_MIN_INIT_1_BINARY = 6'b110000;
		49 : SATA_MIN_INIT_1_BINARY = 6'b110001;
		50 : SATA_MIN_INIT_1_BINARY = 6'b110010;
		51 : SATA_MIN_INIT_1_BINARY = 6'b110011;
		52 : SATA_MIN_INIT_1_BINARY = 6'b110100;
		53 : SATA_MIN_INIT_1_BINARY = 6'b110101;
		54 : SATA_MIN_INIT_1_BINARY = 6'b110110;
		55 : SATA_MIN_INIT_1_BINARY = 6'b110111;
		56 : SATA_MIN_INIT_1_BINARY = 6'b111000;
		57 : SATA_MIN_INIT_1_BINARY = 6'b111001;
		58 : SATA_MIN_INIT_1_BINARY = 6'b111010;
		59 : SATA_MIN_INIT_1_BINARY = 6'b111011;
		60 : SATA_MIN_INIT_1_BINARY = 6'b111100;
		61 : SATA_MIN_INIT_1_BINARY = 6'b111101;
		default : begin
			$display("Attribute Syntax Error : The Attribute SATA_MIN_INIT_1 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1 to 61.", SATA_MIN_INIT_1);
			$finish;
		end
	endcase

	case (SATA_MAX_INIT_1)
		1 : SATA_MAX_INIT_1_BINARY = 6'b000001;
		2 : SATA_MAX_INIT_1_BINARY = 6'b000010;
		3 : SATA_MAX_INIT_1_BINARY = 6'b000011;
		4 : SATA_MAX_INIT_1_BINARY = 6'b000100;
		5 : SATA_MAX_INIT_1_BINARY = 6'b000101;
		6 : SATA_MAX_INIT_1_BINARY = 6'b000110;
		7 : SATA_MAX_INIT_1_BINARY = 6'b000111;
		8 : SATA_MAX_INIT_1_BINARY = 6'b001000;
		9 : SATA_MAX_INIT_1_BINARY = 6'b001001;
		10 : SATA_MAX_INIT_1_BINARY = 6'b001010;
		11 : SATA_MAX_INIT_1_BINARY = 6'b001011;
		12 : SATA_MAX_INIT_1_BINARY = 6'b001100;
		13 : SATA_MAX_INIT_1_BINARY = 6'b001101;
		14 : SATA_MAX_INIT_1_BINARY = 6'b001110;
		15 : SATA_MAX_INIT_1_BINARY = 6'b001111;
		16 : SATA_MAX_INIT_1_BINARY = 6'b010000;
		17 : SATA_MAX_INIT_1_BINARY = 6'b010001;
		18 : SATA_MAX_INIT_1_BINARY = 6'b010010;
		19 : SATA_MAX_INIT_1_BINARY = 6'b010011;
		20 : SATA_MAX_INIT_1_BINARY = 6'b010100;
		21 : SATA_MAX_INIT_1_BINARY = 6'b010101;
		22 : SATA_MAX_INIT_1_BINARY = 6'b010110;
		23 : SATA_MAX_INIT_1_BINARY = 6'b010111;
		24 : SATA_MAX_INIT_1_BINARY = 6'b011000;
		25 : SATA_MAX_INIT_1_BINARY = 6'b011001;
		26 : SATA_MAX_INIT_1_BINARY = 6'b011010;
		27 : SATA_MAX_INIT_1_BINARY = 6'b011011;
		28 : SATA_MAX_INIT_1_BINARY = 6'b011100;
		29 : SATA_MAX_INIT_1_BINARY = 6'b011101;
		30 : SATA_MAX_INIT_1_BINARY = 6'b011110;
		31 : SATA_MAX_INIT_1_BINARY = 6'b011111;
		32 : SATA_MAX_INIT_1_BINARY = 6'b100000;
		33 : SATA_MAX_INIT_1_BINARY = 6'b100001;
		34 : SATA_MAX_INIT_1_BINARY = 6'b100010;
		35 : SATA_MAX_INIT_1_BINARY = 6'b100011;
		36 : SATA_MAX_INIT_1_BINARY = 6'b100100;
		37 : SATA_MAX_INIT_1_BINARY = 6'b100101;
		38 : SATA_MAX_INIT_1_BINARY = 6'b100110;
		39 : SATA_MAX_INIT_1_BINARY = 6'b100111;
		40 : SATA_MAX_INIT_1_BINARY = 6'b101000;
		41 : SATA_MAX_INIT_1_BINARY = 6'b101001;
		42 : SATA_MAX_INIT_1_BINARY = 6'b101010;
		43 : SATA_MAX_INIT_1_BINARY = 6'b101011;
		44 : SATA_MAX_INIT_1_BINARY = 6'b101100;
		45 : SATA_MAX_INIT_1_BINARY = 6'b101101;
		46 : SATA_MAX_INIT_1_BINARY = 6'b101110;
		47 : SATA_MAX_INIT_1_BINARY = 6'b101111;
		48 : SATA_MAX_INIT_1_BINARY = 6'b110000;
		49 : SATA_MAX_INIT_1_BINARY = 6'b110001;
		50 : SATA_MAX_INIT_1_BINARY = 6'b110010;
		51 : SATA_MAX_INIT_1_BINARY = 6'b110011;
		52 : SATA_MAX_INIT_1_BINARY = 6'b110100;
		53 : SATA_MAX_INIT_1_BINARY = 6'b110101;
		54 : SATA_MAX_INIT_1_BINARY = 6'b110110;
		55 : SATA_MAX_INIT_1_BINARY = 6'b110111;
		56 : SATA_MAX_INIT_1_BINARY = 6'b111000;
		57 : SATA_MAX_INIT_1_BINARY = 6'b111001;
		58 : SATA_MAX_INIT_1_BINARY = 6'b111010;
		59 : SATA_MAX_INIT_1_BINARY = 6'b111011;
		60 : SATA_MAX_INIT_1_BINARY = 6'b111100;
		61 : SATA_MAX_INIT_1_BINARY = 6'b111101;
		default : begin
			$display("Attribute Syntax Error : The Attribute SATA_MAX_INIT_1 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1 to 61.", SATA_MAX_INIT_1);
			$finish;
		end
	endcase

	case (SATA_MIN_WAKE_1)
		1 : SATA_MIN_WAKE_1_BINARY = 6'b000001;
		2 : SATA_MIN_WAKE_1_BINARY = 6'b000010;
		3 : SATA_MIN_WAKE_1_BINARY = 6'b000011;
		4 : SATA_MIN_WAKE_1_BINARY = 6'b000100;
		5 : SATA_MIN_WAKE_1_BINARY = 6'b000101;
		6 : SATA_MIN_WAKE_1_BINARY = 6'b000110;
		7 : SATA_MIN_WAKE_1_BINARY = 6'b000111;
		8 : SATA_MIN_WAKE_1_BINARY = 6'b001000;
		9 : SATA_MIN_WAKE_1_BINARY = 6'b001001;
		10 : SATA_MIN_WAKE_1_BINARY = 6'b001010;
		11 : SATA_MIN_WAKE_1_BINARY = 6'b001011;
		12 : SATA_MIN_WAKE_1_BINARY = 6'b001100;
		13 : SATA_MIN_WAKE_1_BINARY = 6'b001101;
		14 : SATA_MIN_WAKE_1_BINARY = 6'b001110;
		15 : SATA_MIN_WAKE_1_BINARY = 6'b001111;
		16 : SATA_MIN_WAKE_1_BINARY = 6'b010000;
		17 : SATA_MIN_WAKE_1_BINARY = 6'b010001;
		18 : SATA_MIN_WAKE_1_BINARY = 6'b010010;
		19 : SATA_MIN_WAKE_1_BINARY = 6'b010011;
		20 : SATA_MIN_WAKE_1_BINARY = 6'b010100;
		21 : SATA_MIN_WAKE_1_BINARY = 6'b010101;
		22 : SATA_MIN_WAKE_1_BINARY = 6'b010110;
		23 : SATA_MIN_WAKE_1_BINARY = 6'b010111;
		24 : SATA_MIN_WAKE_1_BINARY = 6'b011000;
		25 : SATA_MIN_WAKE_1_BINARY = 6'b011001;
		26 : SATA_MIN_WAKE_1_BINARY = 6'b011010;
		27 : SATA_MIN_WAKE_1_BINARY = 6'b011011;
		28 : SATA_MIN_WAKE_1_BINARY = 6'b011100;
		29 : SATA_MIN_WAKE_1_BINARY = 6'b011101;
		30 : SATA_MIN_WAKE_1_BINARY = 6'b011110;
		31 : SATA_MIN_WAKE_1_BINARY = 6'b011111;
		32 : SATA_MIN_WAKE_1_BINARY = 6'b100000;
		33 : SATA_MIN_WAKE_1_BINARY = 6'b100001;
		34 : SATA_MIN_WAKE_1_BINARY = 6'b100010;
		35 : SATA_MIN_WAKE_1_BINARY = 6'b100011;
		36 : SATA_MIN_WAKE_1_BINARY = 6'b100100;
		37 : SATA_MIN_WAKE_1_BINARY = 6'b100101;
		38 : SATA_MIN_WAKE_1_BINARY = 6'b100110;
		39 : SATA_MIN_WAKE_1_BINARY = 6'b100111;
		40 : SATA_MIN_WAKE_1_BINARY = 6'b101000;
		41 : SATA_MIN_WAKE_1_BINARY = 6'b101001;
		42 : SATA_MIN_WAKE_1_BINARY = 6'b101010;
		43 : SATA_MIN_WAKE_1_BINARY = 6'b101011;
		44 : SATA_MIN_WAKE_1_BINARY = 6'b101100;
		45 : SATA_MIN_WAKE_1_BINARY = 6'b101101;
		46 : SATA_MIN_WAKE_1_BINARY = 6'b101110;
		47 : SATA_MIN_WAKE_1_BINARY = 6'b101111;
		48 : SATA_MIN_WAKE_1_BINARY = 6'b110000;
		49 : SATA_MIN_WAKE_1_BINARY = 6'b110001;
		50 : SATA_MIN_WAKE_1_BINARY = 6'b110010;
		51 : SATA_MIN_WAKE_1_BINARY = 6'b110011;
		52 : SATA_MIN_WAKE_1_BINARY = 6'b110100;
		53 : SATA_MIN_WAKE_1_BINARY = 6'b110101;
		54 : SATA_MIN_WAKE_1_BINARY = 6'b110110;
		55 : SATA_MIN_WAKE_1_BINARY = 6'b110111;
		56 : SATA_MIN_WAKE_1_BINARY = 6'b111000;
		57 : SATA_MIN_WAKE_1_BINARY = 6'b111001;
		58 : SATA_MIN_WAKE_1_BINARY = 6'b111010;
		59 : SATA_MIN_WAKE_1_BINARY = 6'b111011;
		60 : SATA_MIN_WAKE_1_BINARY = 6'b111100;
		61 : SATA_MIN_WAKE_1_BINARY = 6'b111101;
		default : begin
			$display("Attribute Syntax Error : The Attribute SATA_MIN_WAKE_1 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1 to 61.", SATA_MIN_WAKE_1);
			$finish;
		end
	endcase

	case (SATA_MAX_WAKE_1)
		1 : SATA_MAX_WAKE_1_BINARY = 6'b000001;
		2 : SATA_MAX_WAKE_1_BINARY = 6'b000010;
		3 : SATA_MAX_WAKE_1_BINARY = 6'b000011;
		4 : SATA_MAX_WAKE_1_BINARY = 6'b000100;
		5 : SATA_MAX_WAKE_1_BINARY = 6'b000101;
		6 : SATA_MAX_WAKE_1_BINARY = 6'b000110;
		7 : SATA_MAX_WAKE_1_BINARY = 6'b000111;
		8 : SATA_MAX_WAKE_1_BINARY = 6'b001000;
		9 : SATA_MAX_WAKE_1_BINARY = 6'b001001;
		10 : SATA_MAX_WAKE_1_BINARY = 6'b001010;
		11 : SATA_MAX_WAKE_1_BINARY = 6'b001011;
		12 : SATA_MAX_WAKE_1_BINARY = 6'b001100;
		13 : SATA_MAX_WAKE_1_BINARY = 6'b001101;
		14 : SATA_MAX_WAKE_1_BINARY = 6'b001110;
		15 : SATA_MAX_WAKE_1_BINARY = 6'b001111;
		16 : SATA_MAX_WAKE_1_BINARY = 6'b010000;
		17 : SATA_MAX_WAKE_1_BINARY = 6'b010001;
		18 : SATA_MAX_WAKE_1_BINARY = 6'b010010;
		19 : SATA_MAX_WAKE_1_BINARY = 6'b010011;
		20 : SATA_MAX_WAKE_1_BINARY = 6'b010100;
		21 : SATA_MAX_WAKE_1_BINARY = 6'b010101;
		22 : SATA_MAX_WAKE_1_BINARY = 6'b010110;
		23 : SATA_MAX_WAKE_1_BINARY = 6'b010111;
		24 : SATA_MAX_WAKE_1_BINARY = 6'b011000;
		25 : SATA_MAX_WAKE_1_BINARY = 6'b011001;
		26 : SATA_MAX_WAKE_1_BINARY = 6'b011010;
		27 : SATA_MAX_WAKE_1_BINARY = 6'b011011;
		28 : SATA_MAX_WAKE_1_BINARY = 6'b011100;
		29 : SATA_MAX_WAKE_1_BINARY = 6'b011101;
		30 : SATA_MAX_WAKE_1_BINARY = 6'b011110;
		31 : SATA_MAX_WAKE_1_BINARY = 6'b011111;
		32 : SATA_MAX_WAKE_1_BINARY = 6'b100000;
		33 : SATA_MAX_WAKE_1_BINARY = 6'b100001;
		34 : SATA_MAX_WAKE_1_BINARY = 6'b100010;
		35 : SATA_MAX_WAKE_1_BINARY = 6'b100011;
		36 : SATA_MAX_WAKE_1_BINARY = 6'b100100;
		37 : SATA_MAX_WAKE_1_BINARY = 6'b100101;
		38 : SATA_MAX_WAKE_1_BINARY = 6'b100110;
		39 : SATA_MAX_WAKE_1_BINARY = 6'b100111;
		40 : SATA_MAX_WAKE_1_BINARY = 6'b101000;
		41 : SATA_MAX_WAKE_1_BINARY = 6'b101001;
		42 : SATA_MAX_WAKE_1_BINARY = 6'b101010;
		43 : SATA_MAX_WAKE_1_BINARY = 6'b101011;
		44 : SATA_MAX_WAKE_1_BINARY = 6'b101100;
		45 : SATA_MAX_WAKE_1_BINARY = 6'b101101;
		46 : SATA_MAX_WAKE_1_BINARY = 6'b101110;
		47 : SATA_MAX_WAKE_1_BINARY = 6'b101111;
		48 : SATA_MAX_WAKE_1_BINARY = 6'b110000;
		49 : SATA_MAX_WAKE_1_BINARY = 6'b110001;
		50 : SATA_MAX_WAKE_1_BINARY = 6'b110010;
		51 : SATA_MAX_WAKE_1_BINARY = 6'b110011;
		52 : SATA_MAX_WAKE_1_BINARY = 6'b110100;
		53 : SATA_MAX_WAKE_1_BINARY = 6'b110101;
		54 : SATA_MAX_WAKE_1_BINARY = 6'b110110;
		55 : SATA_MAX_WAKE_1_BINARY = 6'b110111;
		56 : SATA_MAX_WAKE_1_BINARY = 6'b111000;
		57 : SATA_MAX_WAKE_1_BINARY = 6'b111001;
		58 : SATA_MAX_WAKE_1_BINARY = 6'b111010;
		59 : SATA_MAX_WAKE_1_BINARY = 6'b111011;
		60 : SATA_MAX_WAKE_1_BINARY = 6'b111100;
		61 : SATA_MAX_WAKE_1_BINARY = 6'b111101;
		default : begin
			$display("Attribute Syntax Error : The Attribute SATA_MAX_WAKE_1 on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1 to 61.", SATA_MAX_WAKE_1);
			$finish;
		end
	endcase

	case (CLK25_DIVIDER)
		1 : CLK25_DIVIDER_BINARY = 3'b000;
		2 : CLK25_DIVIDER_BINARY = 3'b001;
		3 : CLK25_DIVIDER_BINARY = 3'b010;
		4 : CLK25_DIVIDER_BINARY = 3'b011;
		5 : CLK25_DIVIDER_BINARY = 3'b100;
		6 : CLK25_DIVIDER_BINARY = 3'b101;
		10 : CLK25_DIVIDER_BINARY = 3'b110;
		12 : CLK25_DIVIDER_BINARY = 3'b111;
		default : begin
			$display("Attribute Syntax Error : The Attribute CLK25_DIVIDER on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are 1, 2, 3, 4, 5, 6, 10 or 12.", CLK25_DIVIDER);
			$finish;
		end
	endcase

	case (OVERSAMPLE_MODE)
		"FALSE" : OVERSAMPLE_MODE_BINARY = 1'b0;
		"TRUE" : OVERSAMPLE_MODE_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute OVERSAMPLE_MODE on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", OVERSAMPLE_MODE);
			$finish;
		end
	endcase

	case (TXGEARBOX_USE_0)
		"FALSE" : TXGEARBOX_USE_0_BINARY = 1'b0;
		"TRUE" : TXGEARBOX_USE_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute TXGEARBOX_USE_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", TXGEARBOX_USE_0);
			$finish;
		end
	endcase

	case (RXGEARBOX_USE_0)
		"FALSE" : RXGEARBOX_USE_0_BINARY = 1'b0;
		"TRUE" : RXGEARBOX_USE_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute RXGEARBOX_USE_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RXGEARBOX_USE_0);
			$finish;
		end
	endcase

	case (TXGEARBOX_USE_1)
		"FALSE" : TXGEARBOX_USE_1_BINARY = 1'b0;
		"TRUE" : TXGEARBOX_USE_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute TXGEARBOX_USE_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", TXGEARBOX_USE_1);
			$finish;
		end
	endcase

	case (RXGEARBOX_USE_1)
		"FALSE" : RXGEARBOX_USE_1_BINARY = 1'b0;
		"TRUE" : RXGEARBOX_USE_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute RXGEARBOX_USE_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RXGEARBOX_USE_1);
			$finish;
		end
	endcase

	case (PLL_FB_DCCEN)
		"FALSE" : PLL_FB_DCCEN_BINARY = 1'b0;
		"TRUE" : PLL_FB_DCCEN_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute PLL_FB_DCCEN on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", PLL_FB_DCCEN);
			$finish;
		end
	endcase

	case (CLKRCV_TRST)
		"FALSE" : CLKRCV_TRST_BINARY = 1'b0;
		"TRUE" : CLKRCV_TRST_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute CLKRCV_TRST on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", CLKRCV_TRST);
			$finish;
		end
	endcase

	case (RX_EN_IDLE_HOLD_DFE_0)
		"FALSE" : RX_EN_IDLE_HOLD_DFE_0_BINARY = 1'b0;
		"TRUE" : RX_EN_IDLE_HOLD_DFE_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute RX_EN_IDLE_HOLD_DFE_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RX_EN_IDLE_HOLD_DFE_0);
			$finish;
		end
	endcase

	case (RX_EN_IDLE_RESET_BUF_0)
		"FALSE" : RX_EN_IDLE_RESET_BUF_0_BINARY = 1'b0;
		"TRUE" : RX_EN_IDLE_RESET_BUF_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute RX_EN_IDLE_RESET_BUF_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RX_EN_IDLE_RESET_BUF_0);
			$finish;
		end
	endcase

	case (RX_EN_IDLE_HOLD_DFE_1)
		"FALSE" : RX_EN_IDLE_HOLD_DFE_1_BINARY = 1'b0;
		"TRUE" : RX_EN_IDLE_HOLD_DFE_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute RX_EN_IDLE_HOLD_DFE_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RX_EN_IDLE_HOLD_DFE_1);
			$finish;
		end
	endcase

	case (RX_EN_IDLE_RESET_BUF_1)
		"FALSE" : RX_EN_IDLE_RESET_BUF_1_BINARY = 1'b0;
		"TRUE" : RX_EN_IDLE_RESET_BUF_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute RX_EN_IDLE_RESET_BUF_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RX_EN_IDLE_RESET_BUF_1);
			$finish;
		end
	endcase

	case (RX_EN_IDLE_HOLD_CDR)
		"FALSE" : RX_EN_IDLE_HOLD_CDR_BINARY = 1'b0;
		"TRUE" : RX_EN_IDLE_HOLD_CDR_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute RX_EN_IDLE_HOLD_CDR on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RX_EN_IDLE_HOLD_CDR);
			$finish;
		end
	endcase

	case (RX_EN_IDLE_RESET_PH)
		"FALSE" : RX_EN_IDLE_RESET_PH_BINARY = 1'b0;
		"TRUE" : RX_EN_IDLE_RESET_PH_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute RX_EN_IDLE_RESET_PH on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RX_EN_IDLE_RESET_PH);
			$finish;
		end
	endcase

	case (RX_EN_IDLE_RESET_FR)
		"FALSE" : RX_EN_IDLE_RESET_FR_BINARY = 1'b0;
		"TRUE" : RX_EN_IDLE_RESET_FR_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute RX_EN_IDLE_RESET_FR on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RX_EN_IDLE_RESET_FR);
			$finish;
		end
	endcase

	case (SIM_GTXRESET_SPEEDUP)
		0 : SIM_GTXRESET_SPEEDUP_BINARY = 0;
		1 : SIM_GTXRESET_SPEEDUP_BINARY = 1;
		default : begin
			$display("Attribute Syntax Error : The Attribute SIM_GTXRESET_SPEEDUP on X_GTX_DUAL instance %m is set to %d.  Legal values for this attribute are  0 or 1.", SIM_GTXRESET_SPEEDUP);
			$finish;
		end
	endcase

         case (SIM_MODE)
		"FAST"   : SIM_MODE_BINARY = 1'b1;
		"LEGACY" : begin
		   $display("Attribute Syntax Warning : The Attribute SIM_MODE on X_GTX_DUAL instance %m is set to %s. The Legacy model is not supported from ISE 11.1 onwards. X_GTX_DUAL defaults to FAST model. There are no functionality differences between X_GTX_DUAL LEGACY and X_GTX_DUAL FAST simulation models. Although, if you want to use the X_GTX_DUAL LEGACY model, please use an earlier ISE build", SIM_MODE);
		   //$finish;
		end
	        default : begin
		   $display("Attribute Syntax Warning : The Attribute SIM_MODE on X_GTX_DUAL instance %m is set to %s.  Legal value for this attribute is FAST.", SIM_MODE);
		   //$finish;
		end
         endcase
   
	case (SIM_RECEIVER_DETECT_PASS_0)
		"FALSE" : SIM_RECEIVER_DETECT_PASS_0_BINARY = 1'b0;
		"TRUE" : SIM_RECEIVER_DETECT_PASS_0_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute SIM_RECEIVER_DETECT_PASS_0 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", SIM_RECEIVER_DETECT_PASS_0);
			$finish;
		end
	endcase

	case (SIM_RECEIVER_DETECT_PASS_1)
		"FALSE" : SIM_RECEIVER_DETECT_PASS_1_BINARY = 1'b0;
		"TRUE" : SIM_RECEIVER_DETECT_PASS_1_BINARY = 1'b1;
		default : begin
			$display("Attribute Syntax Error : The Attribute SIM_RECEIVER_DETECT_PASS_1 on X_GTX_DUAL instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", SIM_RECEIVER_DETECT_PASS_1);
			$finish;
		end
	endcase 
end

buf B_REFCLKOUT (REFCLKOUT, REFCLKOUT_OUT);
buf B_RXRECCLK0 (RXRECCLK0, RXRECCLK0_OUT);
buf B_TXOUTCLK0 (TXOUTCLK0, TXOUTCLK0_OUT);
buf B_RXRECCLK1 (RXRECCLK1, RXRECCLK1_OUT);
buf B_TXOUTCLK1 (TXOUTCLK1, TXOUTCLK1_OUT);
buf B_TXP0 (TXP0, TXP0_OUT);
buf B_TXN0 (TXN0, TXN0_OUT);
buf B_TXP1 (TXP1, TXP1_OUT);
buf B_TXN1 (TXN1, TXN1_OUT);
buf B_RXDATA00 (RXDATA0[0], RXDATA0_OUT[0]);
buf B_RXDATA01 (RXDATA0[1], RXDATA0_OUT[1]);
buf B_RXDATA02 (RXDATA0[2], RXDATA0_OUT[2]);
buf B_RXDATA03 (RXDATA0[3], RXDATA0_OUT[3]);
buf B_RXDATA04 (RXDATA0[4], RXDATA0_OUT[4]);
buf B_RXDATA05 (RXDATA0[5], RXDATA0_OUT[5]);
buf B_RXDATA06 (RXDATA0[6], RXDATA0_OUT[6]);
buf B_RXDATA07 (RXDATA0[7], RXDATA0_OUT[7]);
buf B_RXDATA08 (RXDATA0[8], RXDATA0_OUT[8]);
buf B_RXDATA09 (RXDATA0[9], RXDATA0_OUT[9]);
buf B_RXDATA010 (RXDATA0[10], RXDATA0_OUT[10]);
buf B_RXDATA011 (RXDATA0[11], RXDATA0_OUT[11]);
buf B_RXDATA012 (RXDATA0[12], RXDATA0_OUT[12]);
buf B_RXDATA013 (RXDATA0[13], RXDATA0_OUT[13]);
buf B_RXDATA014 (RXDATA0[14], RXDATA0_OUT[14]);
buf B_RXDATA015 (RXDATA0[15], RXDATA0_OUT[15]);
buf B_RXDATA016 (RXDATA0[16], RXDATA0_OUT[16]);
buf B_RXDATA017 (RXDATA0[17], RXDATA0_OUT[17]);
buf B_RXDATA018 (RXDATA0[18], RXDATA0_OUT[18]);
buf B_RXDATA019 (RXDATA0[19], RXDATA0_OUT[19]);
buf B_RXDATA020 (RXDATA0[20], RXDATA0_OUT[20]);
buf B_RXDATA021 (RXDATA0[21], RXDATA0_OUT[21]);
buf B_RXDATA022 (RXDATA0[22], RXDATA0_OUT[22]);
buf B_RXDATA023 (RXDATA0[23], RXDATA0_OUT[23]);
buf B_RXDATA024 (RXDATA0[24], RXDATA0_OUT[24]);
buf B_RXDATA025 (RXDATA0[25], RXDATA0_OUT[25]);
buf B_RXDATA026 (RXDATA0[26], RXDATA0_OUT[26]);
buf B_RXDATA027 (RXDATA0[27], RXDATA0_OUT[27]);
buf B_RXDATA028 (RXDATA0[28], RXDATA0_OUT[28]);
buf B_RXDATA029 (RXDATA0[29], RXDATA0_OUT[29]);
buf B_RXDATA030 (RXDATA0[30], RXDATA0_OUT[30]);
buf B_RXDATA031 (RXDATA0[31], RXDATA0_OUT[31]);
buf B_RXNOTINTABLE00 (RXNOTINTABLE0[0], RXNOTINTABLE0_OUT[0]);
buf B_RXNOTINTABLE01 (RXNOTINTABLE0[1], RXNOTINTABLE0_OUT[1]);
buf B_RXNOTINTABLE02 (RXNOTINTABLE0[2], RXNOTINTABLE0_OUT[2]);
buf B_RXNOTINTABLE03 (RXNOTINTABLE0[3], RXNOTINTABLE0_OUT[3]);
buf B_RXDISPERR00 (RXDISPERR0[0], RXDISPERR0_OUT[0]);
buf B_RXDISPERR01 (RXDISPERR0[1], RXDISPERR0_OUT[1]);
buf B_RXDISPERR02 (RXDISPERR0[2], RXDISPERR0_OUT[2]);
buf B_RXDISPERR03 (RXDISPERR0[3], RXDISPERR0_OUT[3]);
buf B_RXCHARISK00 (RXCHARISK0[0], RXCHARISK0_OUT[0]);
buf B_RXCHARISK01 (RXCHARISK0[1], RXCHARISK0_OUT[1]);
buf B_RXCHARISK02 (RXCHARISK0[2], RXCHARISK0_OUT[2]);
buf B_RXCHARISK03 (RXCHARISK0[3], RXCHARISK0_OUT[3]);
buf B_RXRUNDISP00 (RXRUNDISP0[0], RXRUNDISP0_OUT[0]);
buf B_RXRUNDISP01 (RXRUNDISP0[1], RXRUNDISP0_OUT[1]);
buf B_RXRUNDISP02 (RXRUNDISP0[2], RXRUNDISP0_OUT[2]);
buf B_RXRUNDISP03 (RXRUNDISP0[3], RXRUNDISP0_OUT[3]);
buf B_RXCHARISCOMMA00 (RXCHARISCOMMA0[0], RXCHARISCOMMA0_OUT[0]);
buf B_RXCHARISCOMMA01 (RXCHARISCOMMA0[1], RXCHARISCOMMA0_OUT[1]);
buf B_RXCHARISCOMMA02 (RXCHARISCOMMA0[2], RXCHARISCOMMA0_OUT[2]);
buf B_RXCHARISCOMMA03 (RXCHARISCOMMA0[3], RXCHARISCOMMA0_OUT[3]);
buf B_RXVALID0 (RXVALID0, RXVALID0_OUT);
buf B_RXDATA10 (RXDATA1[0], RXDATA1_OUT[0]);
buf B_RXDATA11 (RXDATA1[1], RXDATA1_OUT[1]);
buf B_RXDATA12 (RXDATA1[2], RXDATA1_OUT[2]);
buf B_RXDATA13 (RXDATA1[3], RXDATA1_OUT[3]);
buf B_RXDATA14 (RXDATA1[4], RXDATA1_OUT[4]);
buf B_RXDATA15 (RXDATA1[5], RXDATA1_OUT[5]);
buf B_RXDATA16 (RXDATA1[6], RXDATA1_OUT[6]);
buf B_RXDATA17 (RXDATA1[7], RXDATA1_OUT[7]);
buf B_RXDATA18 (RXDATA1[8], RXDATA1_OUT[8]);
buf B_RXDATA19 (RXDATA1[9], RXDATA1_OUT[9]);
buf B_RXDATA110 (RXDATA1[10], RXDATA1_OUT[10]);
buf B_RXDATA111 (RXDATA1[11], RXDATA1_OUT[11]);
buf B_RXDATA112 (RXDATA1[12], RXDATA1_OUT[12]);
buf B_RXDATA113 (RXDATA1[13], RXDATA1_OUT[13]);
buf B_RXDATA114 (RXDATA1[14], RXDATA1_OUT[14]);
buf B_RXDATA115 (RXDATA1[15], RXDATA1_OUT[15]);
buf B_RXDATA116 (RXDATA1[16], RXDATA1_OUT[16]);
buf B_RXDATA117 (RXDATA1[17], RXDATA1_OUT[17]);
buf B_RXDATA118 (RXDATA1[18], RXDATA1_OUT[18]);
buf B_RXDATA119 (RXDATA1[19], RXDATA1_OUT[19]);
buf B_RXDATA120 (RXDATA1[20], RXDATA1_OUT[20]);
buf B_RXDATA121 (RXDATA1[21], RXDATA1_OUT[21]);
buf B_RXDATA122 (RXDATA1[22], RXDATA1_OUT[22]);
buf B_RXDATA123 (RXDATA1[23], RXDATA1_OUT[23]);
buf B_RXDATA124 (RXDATA1[24], RXDATA1_OUT[24]);
buf B_RXDATA125 (RXDATA1[25], RXDATA1_OUT[25]);
buf B_RXDATA126 (RXDATA1[26], RXDATA1_OUT[26]);
buf B_RXDATA127 (RXDATA1[27], RXDATA1_OUT[27]);
buf B_RXDATA128 (RXDATA1[28], RXDATA1_OUT[28]);
buf B_RXDATA129 (RXDATA1[29], RXDATA1_OUT[29]);
buf B_RXDATA130 (RXDATA1[30], RXDATA1_OUT[30]);
buf B_RXDATA131 (RXDATA1[31], RXDATA1_OUT[31]);
buf B_RXNOTINTABLE10 (RXNOTINTABLE1[0], RXNOTINTABLE1_OUT[0]);
buf B_RXNOTINTABLE11 (RXNOTINTABLE1[1], RXNOTINTABLE1_OUT[1]);
buf B_RXNOTINTABLE12 (RXNOTINTABLE1[2], RXNOTINTABLE1_OUT[2]);
buf B_RXNOTINTABLE13 (RXNOTINTABLE1[3], RXNOTINTABLE1_OUT[3]);
buf B_RXDISPERR10 (RXDISPERR1[0], RXDISPERR1_OUT[0]);
buf B_RXDISPERR11 (RXDISPERR1[1], RXDISPERR1_OUT[1]);
buf B_RXDISPERR12 (RXDISPERR1[2], RXDISPERR1_OUT[2]);
buf B_RXDISPERR13 (RXDISPERR1[3], RXDISPERR1_OUT[3]);
buf B_RXCHARISK10 (RXCHARISK1[0], RXCHARISK1_OUT[0]);
buf B_RXCHARISK11 (RXCHARISK1[1], RXCHARISK1_OUT[1]);
buf B_RXCHARISK12 (RXCHARISK1[2], RXCHARISK1_OUT[2]);
buf B_RXCHARISK13 (RXCHARISK1[3], RXCHARISK1_OUT[3]);
buf B_RXRUNDISP10 (RXRUNDISP1[0], RXRUNDISP1_OUT[0]);
buf B_RXRUNDISP11 (RXRUNDISP1[1], RXRUNDISP1_OUT[1]);
buf B_RXRUNDISP12 (RXRUNDISP1[2], RXRUNDISP1_OUT[2]);
buf B_RXRUNDISP13 (RXRUNDISP1[3], RXRUNDISP1_OUT[3]);
buf B_RXCHARISCOMMA10 (RXCHARISCOMMA1[0], RXCHARISCOMMA1_OUT[0]);
buf B_RXCHARISCOMMA11 (RXCHARISCOMMA1[1], RXCHARISCOMMA1_OUT[1]);
buf B_RXCHARISCOMMA12 (RXCHARISCOMMA1[2], RXCHARISCOMMA1_OUT[2]);
buf B_RXCHARISCOMMA13 (RXCHARISCOMMA1[3], RXCHARISCOMMA1_OUT[3]);
buf B_RXVALID1 (RXVALID1, RXVALID1_OUT);
buf B_RESETDONE0 (RESETDONE0, RESETDONE0_OUT);
buf B_RESETDONE1 (RESETDONE1, RESETDONE1_OUT);
buf B_TXKERR00 (TXKERR0[0], TXKERR0_OUT[0]);
buf B_TXKERR01 (TXKERR0[1], TXKERR0_OUT[1]);
buf B_TXKERR02 (TXKERR0[2], TXKERR0_OUT[2]);
buf B_TXKERR03 (TXKERR0[3], TXKERR0_OUT[3]);
buf B_TXRUNDISP00 (TXRUNDISP0[0], TXRUNDISP0_OUT[0]);
buf B_TXRUNDISP01 (TXRUNDISP0[1], TXRUNDISP0_OUT[1]);
buf B_TXRUNDISP02 (TXRUNDISP0[2], TXRUNDISP0_OUT[2]);
buf B_TXRUNDISP03 (TXRUNDISP0[3], TXRUNDISP0_OUT[3]);
buf B_TXBUFSTATUS00 (TXBUFSTATUS0[0], TXBUFSTATUS0_OUT[0]);
buf B_TXBUFSTATUS01 (TXBUFSTATUS0[1], TXBUFSTATUS0_OUT[1]);
buf B_TXKERR10 (TXKERR1[0], TXKERR1_OUT[0]);
buf B_TXKERR11 (TXKERR1[1], TXKERR1_OUT[1]);
buf B_TXKERR12 (TXKERR1[2], TXKERR1_OUT[2]);
buf B_TXKERR13 (TXKERR1[3], TXKERR1_OUT[3]);
buf B_TXRUNDISP10 (TXRUNDISP1[0], TXRUNDISP1_OUT[0]);
buf B_TXRUNDISP11 (TXRUNDISP1[1], TXRUNDISP1_OUT[1]);
buf B_TXRUNDISP12 (TXRUNDISP1[2], TXRUNDISP1_OUT[2]);
buf B_TXRUNDISP13 (TXRUNDISP1[3], TXRUNDISP1_OUT[3]);
buf B_TXBUFSTATUS10 (TXBUFSTATUS1[0], TXBUFSTATUS1_OUT[0]);
buf B_TXBUFSTATUS11 (TXBUFSTATUS1[1], TXBUFSTATUS1_OUT[1]);
buf B_RXCOMMADET0 (RXCOMMADET0, RXCOMMADET0_OUT);
buf B_RXBYTEREALIGN0 (RXBYTEREALIGN0, RXBYTEREALIGN0_OUT);
buf B_RXBYTEISALIGNED0 (RXBYTEISALIGNED0, RXBYTEISALIGNED0_OUT);
buf B_RXLOSSOFSYNC00 (RXLOSSOFSYNC0[0], RXLOSSOFSYNC0_OUT[0]);
buf B_RXLOSSOFSYNC01 (RXLOSSOFSYNC0[1], RXLOSSOFSYNC0_OUT[1]);
buf B_RXCHBONDO00 (RXCHBONDO0[0], RXCHBONDO0_OUT[0]);
buf B_RXCHBONDO01 (RXCHBONDO0[1], RXCHBONDO0_OUT[1]);
buf B_RXCHBONDO02 (RXCHBONDO0[2], RXCHBONDO0_OUT[2]);
buf B_RXCHBONDO03 (RXCHBONDO0[3], RXCHBONDO0_OUT[3]);
buf B_RXCHANBONDSEQ0 (RXCHANBONDSEQ0, RXCHANBONDSEQ0_OUT);
buf B_RXCHANREALIGN0 (RXCHANREALIGN0, RXCHANREALIGN0_OUT);
buf B_RXCHANISALIGNED0 (RXCHANISALIGNED0, RXCHANISALIGNED0_OUT);
buf B_RXBUFSTATUS00 (RXBUFSTATUS0[0], RXBUFSTATUS0_OUT[0]);
buf B_RXBUFSTATUS01 (RXBUFSTATUS0[1], RXBUFSTATUS0_OUT[1]);
buf B_RXBUFSTATUS02 (RXBUFSTATUS0[2], RXBUFSTATUS0_OUT[2]);
buf B_RXCOMMADET1 (RXCOMMADET1, RXCOMMADET1_OUT);
buf B_RXBYTEREALIGN1 (RXBYTEREALIGN1, RXBYTEREALIGN1_OUT);
buf B_RXBYTEISALIGNED1 (RXBYTEISALIGNED1, RXBYTEISALIGNED1_OUT);
buf B_RXLOSSOFSYNC10 (RXLOSSOFSYNC1[0], RXLOSSOFSYNC1_OUT[0]);
buf B_RXLOSSOFSYNC11 (RXLOSSOFSYNC1[1], RXLOSSOFSYNC1_OUT[1]);
buf B_RXCHBONDO10 (RXCHBONDO1[0], RXCHBONDO1_OUT[0]);
buf B_RXCHBONDO11 (RXCHBONDO1[1], RXCHBONDO1_OUT[1]);
buf B_RXCHBONDO12 (RXCHBONDO1[2], RXCHBONDO1_OUT[2]);
buf B_RXCHBONDO13 (RXCHBONDO1[3], RXCHBONDO1_OUT[3]);
buf B_RXCHANBONDSEQ1 (RXCHANBONDSEQ1, RXCHANBONDSEQ1_OUT);
buf B_RXCHANREALIGN1 (RXCHANREALIGN1, RXCHANREALIGN1_OUT);
buf B_RXCHANISALIGNED1 (RXCHANISALIGNED1, RXCHANISALIGNED1_OUT);
buf B_RXBUFSTATUS10 (RXBUFSTATUS1[0], RXBUFSTATUS1_OUT[0]);
buf B_RXBUFSTATUS11 (RXBUFSTATUS1[1], RXBUFSTATUS1_OUT[1]);
buf B_RXBUFSTATUS12 (RXBUFSTATUS1[2], RXBUFSTATUS1_OUT[2]);
buf B_PHYSTATUS0 (PHYSTATUS0, PHYSTATUS0_OUT);
buf B_PHYSTATUS1 (PHYSTATUS1, PHYSTATUS1_OUT);
buf B_RXELECIDLE0 (RXELECIDLE0, RXELECIDLE0_OUT);
buf B_RXSTATUS00 (RXSTATUS0[0], RXSTATUS0_OUT[0]);
buf B_RXSTATUS01 (RXSTATUS0[1], RXSTATUS0_OUT[1]);
buf B_RXSTATUS02 (RXSTATUS0[2], RXSTATUS0_OUT[2]);
buf B_RXCLKCORCNT00 (RXCLKCORCNT0[0], RXCLKCORCNT0_OUT[0]);
buf B_RXCLKCORCNT01 (RXCLKCORCNT0[1], RXCLKCORCNT0_OUT[1]);
buf B_RXCLKCORCNT02 (RXCLKCORCNT0[2], RXCLKCORCNT0_OUT[2]);
buf B_RXELECIDLE1 (RXELECIDLE1, RXELECIDLE1_OUT);
buf B_RXSTATUS10 (RXSTATUS1[0], RXSTATUS1_OUT[0]);
buf B_RXSTATUS11 (RXSTATUS1[1], RXSTATUS1_OUT[1]);
buf B_RXSTATUS12 (RXSTATUS1[2], RXSTATUS1_OUT[2]);
buf B_RXCLKCORCNT10 (RXCLKCORCNT1[0], RXCLKCORCNT1_OUT[0]);
buf B_RXCLKCORCNT11 (RXCLKCORCNT1[1], RXCLKCORCNT1_OUT[1]);
buf B_RXCLKCORCNT12 (RXCLKCORCNT1[2], RXCLKCORCNT1_OUT[2]);
buf B_PLLLKDET (PLLLKDET, PLLLKDET_OUT);
buf B_RXPRBSERR0 (RXPRBSERR0, RXPRBSERR0_OUT);
buf B_RXPRBSERR1 (RXPRBSERR1, RXPRBSERR1_OUT);
buf B_DO0 (DO[0], DO_OUT[0]);
buf B_DO1 (DO[1], DO_OUT[1]);
buf B_DO2 (DO[2], DO_OUT[2]);
buf B_DO3 (DO[3], DO_OUT[3]);
buf B_DO4 (DO[4], DO_OUT[4]);
buf B_DO5 (DO[5], DO_OUT[5]);
buf B_DO6 (DO[6], DO_OUT[6]);
buf B_DO7 (DO[7], DO_OUT[7]);
buf B_DO8 (DO[8], DO_OUT[8]);
buf B_DO9 (DO[9], DO_OUT[9]);
buf B_DO10 (DO[10], DO_OUT[10]);
buf B_DO11 (DO[11], DO_OUT[11]);
buf B_DO12 (DO[12], DO_OUT[12]);
buf B_DO13 (DO[13], DO_OUT[13]);
buf B_DO14 (DO[14], DO_OUT[14]);
buf B_DO15 (DO[15], DO_OUT[15]);
buf B_DRDY (DRDY, DRDY_OUT);
buf B_RXOVERSAMPLEERR0 (RXOVERSAMPLEERR0, RXOVERSAMPLEERR0_OUT);
buf B_RXOVERSAMPLEERR1 (RXOVERSAMPLEERR1, RXOVERSAMPLEERR1_OUT);
buf B_TXGEARBOXREADY0 (TXGEARBOXREADY0, TXGEARBOXREADY0_OUT);
buf B_RXHEADER00 (RXHEADER0[0], RXHEADER0_OUT[0]);
buf B_RXHEADER01 (RXHEADER0[1], RXHEADER0_OUT[1]);
buf B_RXHEADER02 (RXHEADER0[2], RXHEADER0_OUT[2]);
buf B_RXHEADERVALID0 (RXHEADERVALID0, RXHEADERVALID0_OUT);
buf B_RXDATAVALID0 (RXDATAVALID0, RXDATAVALID0_OUT);
buf B_RXSTARTOFSEQ0 (RXSTARTOFSEQ0, RXSTARTOFSEQ0_OUT);
buf B_TXGEARBOXREADY1 (TXGEARBOXREADY1, TXGEARBOXREADY1_OUT);
buf B_RXHEADER10 (RXHEADER1[0], RXHEADER1_OUT[0]);
buf B_RXHEADER11 (RXHEADER1[1], RXHEADER1_OUT[1]);
buf B_RXHEADER12 (RXHEADER1[2], RXHEADER1_OUT[2]);
buf B_RXHEADERVALID1 (RXHEADERVALID1, RXHEADERVALID1_OUT);
buf B_RXDATAVALID1 (RXDATAVALID1, RXDATAVALID1_OUT);
buf B_RXSTARTOFSEQ1 (RXSTARTOFSEQ1, RXSTARTOFSEQ1_OUT);
buf B_DFECLKDLYADJMONITOR00 (DFECLKDLYADJMONITOR0[0], DFECLKDLYADJMONITOR0_OUT[0]);
buf B_DFECLKDLYADJMONITOR01 (DFECLKDLYADJMONITOR0[1], DFECLKDLYADJMONITOR0_OUT[1]);
buf B_DFECLKDLYADJMONITOR02 (DFECLKDLYADJMONITOR0[2], DFECLKDLYADJMONITOR0_OUT[2]);
buf B_DFECLKDLYADJMONITOR03 (DFECLKDLYADJMONITOR0[3], DFECLKDLYADJMONITOR0_OUT[3]);
buf B_DFECLKDLYADJMONITOR04 (DFECLKDLYADJMONITOR0[4], DFECLKDLYADJMONITOR0_OUT[4]);
buf B_DFECLKDLYADJMONITOR05 (DFECLKDLYADJMONITOR0[5], DFECLKDLYADJMONITOR0_OUT[5]);
buf B_DFEEYEDACMONITOR00 (DFEEYEDACMONITOR0[0], DFEEYEDACMONITOR0_OUT[0]);
buf B_DFEEYEDACMONITOR01 (DFEEYEDACMONITOR0[1], DFEEYEDACMONITOR0_OUT[1]);
buf B_DFEEYEDACMONITOR02 (DFEEYEDACMONITOR0[2], DFEEYEDACMONITOR0_OUT[2]);
buf B_DFEEYEDACMONITOR03 (DFEEYEDACMONITOR0[3], DFEEYEDACMONITOR0_OUT[3]);
buf B_DFEEYEDACMONITOR04 (DFEEYEDACMONITOR0[4], DFEEYEDACMONITOR0_OUT[4]);
buf B_DFETAP1MONITOR00 (DFETAP1MONITOR0[0], DFETAP1MONITOR0_OUT[0]);
buf B_DFETAP1MONITOR01 (DFETAP1MONITOR0[1], DFETAP1MONITOR0_OUT[1]);
buf B_DFETAP1MONITOR02 (DFETAP1MONITOR0[2], DFETAP1MONITOR0_OUT[2]);
buf B_DFETAP1MONITOR03 (DFETAP1MONITOR0[3], DFETAP1MONITOR0_OUT[3]);
buf B_DFETAP1MONITOR04 (DFETAP1MONITOR0[4], DFETAP1MONITOR0_OUT[4]);
buf B_DFETAP2MONITOR00 (DFETAP2MONITOR0[0], DFETAP2MONITOR0_OUT[0]);
buf B_DFETAP2MONITOR01 (DFETAP2MONITOR0[1], DFETAP2MONITOR0_OUT[1]);
buf B_DFETAP2MONITOR02 (DFETAP2MONITOR0[2], DFETAP2MONITOR0_OUT[2]);
buf B_DFETAP2MONITOR03 (DFETAP2MONITOR0[3], DFETAP2MONITOR0_OUT[3]);
buf B_DFETAP2MONITOR04 (DFETAP2MONITOR0[4], DFETAP2MONITOR0_OUT[4]);
buf B_DFETAP3MONITOR00 (DFETAP3MONITOR0[0], DFETAP3MONITOR0_OUT[0]);
buf B_DFETAP3MONITOR01 (DFETAP3MONITOR0[1], DFETAP3MONITOR0_OUT[1]);
buf B_DFETAP3MONITOR02 (DFETAP3MONITOR0[2], DFETAP3MONITOR0_OUT[2]);
buf B_DFETAP3MONITOR03 (DFETAP3MONITOR0[3], DFETAP3MONITOR0_OUT[3]);
buf B_DFETAP4MONITOR00 (DFETAP4MONITOR0[0], DFETAP4MONITOR0_OUT[0]);
buf B_DFETAP4MONITOR01 (DFETAP4MONITOR0[1], DFETAP4MONITOR0_OUT[1]);
buf B_DFETAP4MONITOR02 (DFETAP4MONITOR0[2], DFETAP4MONITOR0_OUT[2]);
buf B_DFETAP4MONITOR03 (DFETAP4MONITOR0[3], DFETAP4MONITOR0_OUT[3]);
buf B_DFECLKDLYADJMONITOR10 (DFECLKDLYADJMONITOR1[0], DFECLKDLYADJMONITOR1_OUT[0]);
buf B_DFECLKDLYADJMONITOR11 (DFECLKDLYADJMONITOR1[1], DFECLKDLYADJMONITOR1_OUT[1]);
buf B_DFECLKDLYADJMONITOR12 (DFECLKDLYADJMONITOR1[2], DFECLKDLYADJMONITOR1_OUT[2]);
buf B_DFECLKDLYADJMONITOR13 (DFECLKDLYADJMONITOR1[3], DFECLKDLYADJMONITOR1_OUT[3]);
buf B_DFECLKDLYADJMONITOR14 (DFECLKDLYADJMONITOR1[4], DFECLKDLYADJMONITOR1_OUT[4]);
buf B_DFECLKDLYADJMONITOR15 (DFECLKDLYADJMONITOR1[5], DFECLKDLYADJMONITOR1_OUT[5]);
buf B_DFEEYEDACMONITOR10 (DFEEYEDACMONITOR1[0], DFEEYEDACMONITOR1_OUT[0]);
buf B_DFEEYEDACMONITOR11 (DFEEYEDACMONITOR1[1], DFEEYEDACMONITOR1_OUT[1]);
buf B_DFEEYEDACMONITOR12 (DFEEYEDACMONITOR1[2], DFEEYEDACMONITOR1_OUT[2]);
buf B_DFEEYEDACMONITOR13 (DFEEYEDACMONITOR1[3], DFEEYEDACMONITOR1_OUT[3]);
buf B_DFEEYEDACMONITOR14 (DFEEYEDACMONITOR1[4], DFEEYEDACMONITOR1_OUT[4]);
buf B_DFETAP1MONITOR10 (DFETAP1MONITOR1[0], DFETAP1MONITOR1_OUT[0]);
buf B_DFETAP1MONITOR11 (DFETAP1MONITOR1[1], DFETAP1MONITOR1_OUT[1]);
buf B_DFETAP1MONITOR12 (DFETAP1MONITOR1[2], DFETAP1MONITOR1_OUT[2]);
buf B_DFETAP1MONITOR13 (DFETAP1MONITOR1[3], DFETAP1MONITOR1_OUT[3]);
buf B_DFETAP1MONITOR14 (DFETAP1MONITOR1[4], DFETAP1MONITOR1_OUT[4]);
buf B_DFETAP2MONITOR10 (DFETAP2MONITOR1[0], DFETAP2MONITOR1_OUT[0]);
buf B_DFETAP2MONITOR11 (DFETAP2MONITOR1[1], DFETAP2MONITOR1_OUT[1]);
buf B_DFETAP2MONITOR12 (DFETAP2MONITOR1[2], DFETAP2MONITOR1_OUT[2]);
buf B_DFETAP2MONITOR13 (DFETAP2MONITOR1[3], DFETAP2MONITOR1_OUT[3]);
buf B_DFETAP2MONITOR14 (DFETAP2MONITOR1[4], DFETAP2MONITOR1_OUT[4]);
buf B_DFETAP3MONITOR10 (DFETAP3MONITOR1[0], DFETAP3MONITOR1_OUT[0]);
buf B_DFETAP3MONITOR11 (DFETAP3MONITOR1[1], DFETAP3MONITOR1_OUT[1]);
buf B_DFETAP3MONITOR12 (DFETAP3MONITOR1[2], DFETAP3MONITOR1_OUT[2]);
buf B_DFETAP3MONITOR13 (DFETAP3MONITOR1[3], DFETAP3MONITOR1_OUT[3]);
buf B_DFETAP4MONITOR10 (DFETAP4MONITOR1[0], DFETAP4MONITOR1_OUT[0]);
buf B_DFETAP4MONITOR11 (DFETAP4MONITOR1[1], DFETAP4MONITOR1_OUT[1]);
buf B_DFETAP4MONITOR12 (DFETAP4MONITOR1[2], DFETAP4MONITOR1_OUT[2]);
buf B_DFETAP4MONITOR13 (DFETAP4MONITOR1[3], DFETAP4MONITOR1_OUT[3]);
buf B_DFESENSCAL00 (DFESENSCAL0[0], DFESENSCAL0_OUT[0]);
buf B_DFESENSCAL01 (DFESENSCAL0[1], DFESENSCAL0_OUT[1]);
buf B_DFESENSCAL02 (DFESENSCAL0[2], DFESENSCAL0_OUT[2]);
buf B_DFESENSCAL10 (DFESENSCAL1[0], DFESENSCAL1_OUT[0]);
buf B_DFESENSCAL11 (DFESENSCAL1[1], DFESENSCAL1_OUT[1]);
buf B_DFESENSCAL12 (DFESENSCAL1[2], DFESENSCAL1_OUT[2]);

buf B_CLKIN (CLKIN_IN, CLKIN);
buf B_TXUSRCLK0 (TXUSRCLK0_IN, TXUSRCLK0);
buf B_TXUSRCLK20 (TXUSRCLK20_IN, TXUSRCLK20);
buf B_RXUSRCLK0 (RXUSRCLK0_IN, RXUSRCLK0);
buf B_RXUSRCLK20 (RXUSRCLK20_IN, RXUSRCLK20);
buf B_TXUSRCLK1 (TXUSRCLK1_IN, TXUSRCLK1);
buf B_TXUSRCLK21 (TXUSRCLK21_IN, TXUSRCLK21);
buf B_RXUSRCLK1 (RXUSRCLK1_IN, RXUSRCLK1);
buf B_RXUSRCLK21 (RXUSRCLK21_IN, RXUSRCLK21);
buf B_RXP0 (RXP0_IN, RXP0);
buf B_RXN0 (RXN0_IN, RXN0);
buf B_TXDATA00 (TXDATA0_IN[0], TXDATA0[0]);
buf B_TXDATA01 (TXDATA0_IN[1], TXDATA0[1]);
buf B_TXDATA02 (TXDATA0_IN[2], TXDATA0[2]);
buf B_TXDATA03 (TXDATA0_IN[3], TXDATA0[3]);
buf B_TXDATA04 (TXDATA0_IN[4], TXDATA0[4]);
buf B_TXDATA05 (TXDATA0_IN[5], TXDATA0[5]);
buf B_TXDATA06 (TXDATA0_IN[6], TXDATA0[6]);
buf B_TXDATA07 (TXDATA0_IN[7], TXDATA0[7]);
buf B_TXDATA08 (TXDATA0_IN[8], TXDATA0[8]);
buf B_TXDATA09 (TXDATA0_IN[9], TXDATA0[9]);
buf B_TXDATA010 (TXDATA0_IN[10], TXDATA0[10]);
buf B_TXDATA011 (TXDATA0_IN[11], TXDATA0[11]);
buf B_TXDATA012 (TXDATA0_IN[12], TXDATA0[12]);
buf B_TXDATA013 (TXDATA0_IN[13], TXDATA0[13]);
buf B_TXDATA014 (TXDATA0_IN[14], TXDATA0[14]);
buf B_TXDATA015 (TXDATA0_IN[15], TXDATA0[15]);
buf B_TXDATA016 (TXDATA0_IN[16], TXDATA0[16]);
buf B_TXDATA017 (TXDATA0_IN[17], TXDATA0[17]);
buf B_TXDATA018 (TXDATA0_IN[18], TXDATA0[18]);
buf B_TXDATA019 (TXDATA0_IN[19], TXDATA0[19]);
buf B_TXDATA020 (TXDATA0_IN[20], TXDATA0[20]);
buf B_TXDATA021 (TXDATA0_IN[21], TXDATA0[21]);
buf B_TXDATA022 (TXDATA0_IN[22], TXDATA0[22]);
buf B_TXDATA023 (TXDATA0_IN[23], TXDATA0[23]);
buf B_TXDATA024 (TXDATA0_IN[24], TXDATA0[24]);
buf B_TXDATA025 (TXDATA0_IN[25], TXDATA0[25]);
buf B_TXDATA026 (TXDATA0_IN[26], TXDATA0[26]);
buf B_TXDATA027 (TXDATA0_IN[27], TXDATA0[27]);
buf B_TXDATA028 (TXDATA0_IN[28], TXDATA0[28]);
buf B_TXDATA029 (TXDATA0_IN[29], TXDATA0[29]);
buf B_TXDATA030 (TXDATA0_IN[30], TXDATA0[30]);
buf B_TXDATA031 (TXDATA0_IN[31], TXDATA0[31]);
buf B_TXBYPASS8B10B00 (TXBYPASS8B10B0_IN[0], TXBYPASS8B10B0[0]);
buf B_TXBYPASS8B10B01 (TXBYPASS8B10B0_IN[1], TXBYPASS8B10B0[1]);
buf B_TXBYPASS8B10B02 (TXBYPASS8B10B0_IN[2], TXBYPASS8B10B0[2]);
buf B_TXBYPASS8B10B03 (TXBYPASS8B10B0_IN[3], TXBYPASS8B10B0[3]);
buf B_TXCHARISK00 (TXCHARISK0_IN[0], TXCHARISK0[0]);
buf B_TXCHARISK01 (TXCHARISK0_IN[1], TXCHARISK0[1]);
buf B_TXCHARISK02 (TXCHARISK0_IN[2], TXCHARISK0[2]);
buf B_TXCHARISK03 (TXCHARISK0_IN[3], TXCHARISK0[3]);
buf B_TXCHARDISPMODE00 (TXCHARDISPMODE0_IN[0], TXCHARDISPMODE0[0]);
buf B_TXCHARDISPMODE01 (TXCHARDISPMODE0_IN[1], TXCHARDISPMODE0[1]);
buf B_TXCHARDISPMODE02 (TXCHARDISPMODE0_IN[2], TXCHARDISPMODE0[2]);
buf B_TXCHARDISPMODE03 (TXCHARDISPMODE0_IN[3], TXCHARDISPMODE0[3]);
buf B_TXCHARDISPVAL00 (TXCHARDISPVAL0_IN[0], TXCHARDISPVAL0[0]);
buf B_TXCHARDISPVAL01 (TXCHARDISPVAL0_IN[1], TXCHARDISPVAL0[1]);
buf B_TXCHARDISPVAL02 (TXCHARDISPVAL0_IN[2], TXCHARDISPVAL0[2]);
buf B_TXCHARDISPVAL03 (TXCHARDISPVAL0_IN[3], TXCHARDISPVAL0[3]);
buf B_RXP1 (RXP1_IN, RXP1);
buf B_RXN1 (RXN1_IN, RXN1);
buf B_TXDATA10 (TXDATA1_IN[0], TXDATA1[0]);
buf B_TXDATA11 (TXDATA1_IN[1], TXDATA1[1]);
buf B_TXDATA12 (TXDATA1_IN[2], TXDATA1[2]);
buf B_TXDATA13 (TXDATA1_IN[3], TXDATA1[3]);
buf B_TXDATA14 (TXDATA1_IN[4], TXDATA1[4]);
buf B_TXDATA15 (TXDATA1_IN[5], TXDATA1[5]);
buf B_TXDATA16 (TXDATA1_IN[6], TXDATA1[6]);
buf B_TXDATA17 (TXDATA1_IN[7], TXDATA1[7]);
buf B_TXDATA18 (TXDATA1_IN[8], TXDATA1[8]);
buf B_TXDATA19 (TXDATA1_IN[9], TXDATA1[9]);
buf B_TXDATA110 (TXDATA1_IN[10], TXDATA1[10]);
buf B_TXDATA111 (TXDATA1_IN[11], TXDATA1[11]);
buf B_TXDATA112 (TXDATA1_IN[12], TXDATA1[12]);
buf B_TXDATA113 (TXDATA1_IN[13], TXDATA1[13]);
buf B_TXDATA114 (TXDATA1_IN[14], TXDATA1[14]);
buf B_TXDATA115 (TXDATA1_IN[15], TXDATA1[15]);
buf B_TXDATA116 (TXDATA1_IN[16], TXDATA1[16]);
buf B_TXDATA117 (TXDATA1_IN[17], TXDATA1[17]);
buf B_TXDATA118 (TXDATA1_IN[18], TXDATA1[18]);
buf B_TXDATA119 (TXDATA1_IN[19], TXDATA1[19]);
buf B_TXDATA120 (TXDATA1_IN[20], TXDATA1[20]);
buf B_TXDATA121 (TXDATA1_IN[21], TXDATA1[21]);
buf B_TXDATA122 (TXDATA1_IN[22], TXDATA1[22]);
buf B_TXDATA123 (TXDATA1_IN[23], TXDATA1[23]);
buf B_TXDATA124 (TXDATA1_IN[24], TXDATA1[24]);
buf B_TXDATA125 (TXDATA1_IN[25], TXDATA1[25]);
buf B_TXDATA126 (TXDATA1_IN[26], TXDATA1[26]);
buf B_TXDATA127 (TXDATA1_IN[27], TXDATA1[27]);
buf B_TXDATA128 (TXDATA1_IN[28], TXDATA1[28]);
buf B_TXDATA129 (TXDATA1_IN[29], TXDATA1[29]);
buf B_TXDATA130 (TXDATA1_IN[30], TXDATA1[30]);
buf B_TXDATA131 (TXDATA1_IN[31], TXDATA1[31]);
buf B_TXBYPASS8B10B10 (TXBYPASS8B10B1_IN[0], TXBYPASS8B10B1[0]);
buf B_TXBYPASS8B10B11 (TXBYPASS8B10B1_IN[1], TXBYPASS8B10B1[1]);
buf B_TXBYPASS8B10B12 (TXBYPASS8B10B1_IN[2], TXBYPASS8B10B1[2]);
buf B_TXBYPASS8B10B13 (TXBYPASS8B10B1_IN[3], TXBYPASS8B10B1[3]);
buf B_TXCHARISK10 (TXCHARISK1_IN[0], TXCHARISK1[0]);
buf B_TXCHARISK11 (TXCHARISK1_IN[1], TXCHARISK1[1]);
buf B_TXCHARISK12 (TXCHARISK1_IN[2], TXCHARISK1[2]);
buf B_TXCHARISK13 (TXCHARISK1_IN[3], TXCHARISK1[3]);
buf B_TXCHARDISPMODE10 (TXCHARDISPMODE1_IN[0], TXCHARDISPMODE1[0]);
buf B_TXCHARDISPMODE11 (TXCHARDISPMODE1_IN[1], TXCHARDISPMODE1[1]);
buf B_TXCHARDISPMODE12 (TXCHARDISPMODE1_IN[2], TXCHARDISPMODE1[2]);
buf B_TXCHARDISPMODE13 (TXCHARDISPMODE1_IN[3], TXCHARDISPMODE1[3]);
buf B_TXCHARDISPVAL10 (TXCHARDISPVAL1_IN[0], TXCHARDISPVAL1[0]);
buf B_TXCHARDISPVAL11 (TXCHARDISPVAL1_IN[1], TXCHARDISPVAL1[1]);
buf B_TXCHARDISPVAL12 (TXCHARDISPVAL1_IN[2], TXCHARDISPVAL1[2]);
buf B_TXCHARDISPVAL13 (TXCHARDISPVAL1_IN[3], TXCHARDISPVAL1[3]);
buf B_GTXRESET (GTXRESET_IN, GTXRESET);
buf B_RXCDRRESET0 (RXCDRRESET0_IN, RXCDRRESET0);
buf B_TXRESET0 (TXRESET0_IN, TXRESET0);
buf B_RXRESET0 (RXRESET0_IN, RXRESET0);
buf B_RXBUFRESET0 (RXBUFRESET0_IN, RXBUFRESET0);
buf B_RXCDRRESET1 (RXCDRRESET1_IN, RXCDRRESET1);
buf B_TXRESET1 (TXRESET1_IN, TXRESET1);
buf B_RXRESET1 (RXRESET1_IN, RXRESET1);
buf B_RXBUFRESET1 (RXBUFRESET1_IN, RXBUFRESET1);
buf B_TXPOWERDOWN00 (TXPOWERDOWN0_IN[0], TXPOWERDOWN0[0]);
buf B_TXPOWERDOWN01 (TXPOWERDOWN0_IN[1], TXPOWERDOWN0[1]);
buf B_RXPOWERDOWN00 (RXPOWERDOWN0_IN[0], RXPOWERDOWN0[0]);
buf B_RXPOWERDOWN01 (RXPOWERDOWN0_IN[1], RXPOWERDOWN0[1]);
buf B_TXPOWERDOWN10 (TXPOWERDOWN1_IN[0], TXPOWERDOWN1[0]);
buf B_TXPOWERDOWN11 (TXPOWERDOWN1_IN[1], TXPOWERDOWN1[1]);
buf B_RXPOWERDOWN10 (RXPOWERDOWN1_IN[0], RXPOWERDOWN1[0]);
buf B_RXPOWERDOWN11 (RXPOWERDOWN1_IN[1], RXPOWERDOWN1[1]);
buf B_PLLPOWERDOWN (PLLPOWERDOWN_IN, PLLPOWERDOWN);
buf B_REFCLKPWRDNB (REFCLKPWRDNB_IN, REFCLKPWRDNB);
buf B_LOOPBACK00 (LOOPBACK0_IN[0], LOOPBACK0[0]);
buf B_LOOPBACK01 (LOOPBACK0_IN[1], LOOPBACK0[1]);
buf B_LOOPBACK02 (LOOPBACK0_IN[2], LOOPBACK0[2]);
buf B_LOOPBACK10 (LOOPBACK1_IN[0], LOOPBACK1[0]);
buf B_LOOPBACK11 (LOOPBACK1_IN[1], LOOPBACK1[1]);
buf B_LOOPBACK12 (LOOPBACK1_IN[2], LOOPBACK1[2]);
buf B_TXDIFFCTRL00 (TXDIFFCTRL0_IN[0], TXDIFFCTRL0[0]);
buf B_TXDIFFCTRL01 (TXDIFFCTRL0_IN[1], TXDIFFCTRL0[1]);
buf B_TXDIFFCTRL02 (TXDIFFCTRL0_IN[2], TXDIFFCTRL0[2]);
buf B_TXBUFDIFFCTRL00 (TXBUFDIFFCTRL0_IN[0], TXBUFDIFFCTRL0[0]);
buf B_TXBUFDIFFCTRL01 (TXBUFDIFFCTRL0_IN[1], TXBUFDIFFCTRL0[1]);
buf B_TXBUFDIFFCTRL02 (TXBUFDIFFCTRL0_IN[2], TXBUFDIFFCTRL0[2]);
buf B_TXPREEMPHASIS00 (TXPREEMPHASIS0_IN[0], TXPREEMPHASIS0[0]);
buf B_TXPREEMPHASIS01 (TXPREEMPHASIS0_IN[1], TXPREEMPHASIS0[1]);
buf B_TXPREEMPHASIS02 (TXPREEMPHASIS0_IN[2], TXPREEMPHASIS0[2]);
buf B_TXPREEMPHASIS03 (TXPREEMPHASIS0_IN[3], TXPREEMPHASIS0[3]);
buf B_TXDIFFCTRL10 (TXDIFFCTRL1_IN[0], TXDIFFCTRL1[0]);
buf B_TXDIFFCTRL11 (TXDIFFCTRL1_IN[1], TXDIFFCTRL1[1]);
buf B_TXDIFFCTRL12 (TXDIFFCTRL1_IN[2], TXDIFFCTRL1[2]);
buf B_TXBUFDIFFCTRL10 (TXBUFDIFFCTRL1_IN[0], TXBUFDIFFCTRL1[0]);
buf B_TXBUFDIFFCTRL11 (TXBUFDIFFCTRL1_IN[1], TXBUFDIFFCTRL1[1]);
buf B_TXBUFDIFFCTRL12 (TXBUFDIFFCTRL1_IN[2], TXBUFDIFFCTRL1[2]);
buf B_TXPREEMPHASIS10 (TXPREEMPHASIS1_IN[0], TXPREEMPHASIS1[0]);
buf B_TXPREEMPHASIS11 (TXPREEMPHASIS1_IN[1], TXPREEMPHASIS1[1]);
buf B_TXPREEMPHASIS12 (TXPREEMPHASIS1_IN[2], TXPREEMPHASIS1[2]);
buf B_TXPREEMPHASIS13 (TXPREEMPHASIS1_IN[3], TXPREEMPHASIS1[3]);
buf B_RXENEQB0 (RXENEQB0_IN, RXENEQB0);
buf B_RXEQMIX00 (RXEQMIX0_IN[0], RXEQMIX0[0]);
buf B_RXEQMIX01 (RXEQMIX0_IN[1], RXEQMIX0[1]);
buf B_RXEQPOLE00 (RXEQPOLE0_IN[0], RXEQPOLE0[0]);
buf B_RXEQPOLE01 (RXEQPOLE0_IN[1], RXEQPOLE0[1]);
buf B_RXEQPOLE02 (RXEQPOLE0_IN[2], RXEQPOLE0[2]);
buf B_RXEQPOLE03 (RXEQPOLE0_IN[3], RXEQPOLE0[3]);
buf B_RXENEQB1 (RXENEQB1_IN, RXENEQB1);
buf B_RXEQMIX10 (RXEQMIX1_IN[0], RXEQMIX1[0]);
buf B_RXEQMIX11 (RXEQMIX1_IN[1], RXEQMIX1[1]);
buf B_RXEQPOLE10 (RXEQPOLE1_IN[0], RXEQPOLE1[0]);
buf B_RXEQPOLE11 (RXEQPOLE1_IN[1], RXEQPOLE1[1]);
buf B_RXEQPOLE12 (RXEQPOLE1_IN[2], RXEQPOLE1[2]);
buf B_RXEQPOLE13 (RXEQPOLE1_IN[3], RXEQPOLE1[3]);
buf B_INTDATAWIDTH (INTDATAWIDTH_IN, INTDATAWIDTH);
buf B_TXDATAWIDTH00 (TXDATAWIDTH0_IN[0], TXDATAWIDTH0[0]);
buf B_TXDATAWIDTH01 (TXDATAWIDTH0_IN[1], TXDATAWIDTH0[1]);
buf B_TXDATAWIDTH10 (TXDATAWIDTH1_IN[0], TXDATAWIDTH1[0]);
buf B_TXDATAWIDTH11 (TXDATAWIDTH1_IN[1], TXDATAWIDTH1[1]);
buf B_TXENPMAPHASEALIGN0 (TXENPMAPHASEALIGN0_IN, TXENPMAPHASEALIGN0);
buf B_TXPMASETPHASE0 (TXPMASETPHASE0_IN, TXPMASETPHASE0);
buf B_RXENPMAPHASEALIGN0 (RXENPMAPHASEALIGN0_IN, RXENPMAPHASEALIGN0);
buf B_RXPMASETPHASE0 (RXPMASETPHASE0_IN, RXPMASETPHASE0);
buf B_TXENPMAPHASEALIGN1 (TXENPMAPHASEALIGN1_IN, TXENPMAPHASEALIGN1);
buf B_TXPMASETPHASE1 (TXPMASETPHASE1_IN, TXPMASETPHASE1);
buf B_RXENPMAPHASEALIGN1 (RXENPMAPHASEALIGN1_IN, RXENPMAPHASEALIGN1);
buf B_RXPMASETPHASE1 (RXPMASETPHASE1_IN, RXPMASETPHASE1);
buf B_TXENC8B10BUSE0 (TXENC8B10BUSE0_IN, TXENC8B10BUSE0);
buf B_TXPOLARITY0 (TXPOLARITY0_IN, TXPOLARITY0);
buf B_TXINHIBIT0 (TXINHIBIT0_IN, TXINHIBIT0);
buf B_TXENC8B10BUSE1 (TXENC8B10BUSE1_IN, TXENC8B10BUSE1);
buf B_TXPOLARITY1 (TXPOLARITY1_IN, TXPOLARITY1);
buf B_TXINHIBIT1 (TXINHIBIT1_IN, TXINHIBIT1);
buf B_RXPOLARITY0 (RXPOLARITY0_IN, RXPOLARITY0);
buf B_RXENPCOMMAALIGN0 (RXENPCOMMAALIGN0_IN, RXENPCOMMAALIGN0);
buf B_RXENMCOMMAALIGN0 (RXENMCOMMAALIGN0_IN, RXENMCOMMAALIGN0);
buf B_RXSLIDE0 (RXSLIDE0_IN, RXSLIDE0);
buf B_RXCOMMADETUSE0 (RXCOMMADETUSE0_IN, RXCOMMADETUSE0);
buf B_RXDEC8B10BUSE0 (RXDEC8B10BUSE0_IN, RXDEC8B10BUSE0);
buf B_RXENCHANSYNC0 (RXENCHANSYNC0_IN, RXENCHANSYNC0);
buf B_RXCHBONDI00 (RXCHBONDI0_IN[0], RXCHBONDI0[0]);
buf B_RXCHBONDI01 (RXCHBONDI0_IN[1], RXCHBONDI0[1]);
buf B_RXCHBONDI02 (RXCHBONDI0_IN[2], RXCHBONDI0[2]);
buf B_RXCHBONDI03 (RXCHBONDI0_IN[3], RXCHBONDI0[3]);
buf B_RXDATAWIDTH00 (RXDATAWIDTH0_IN[0], RXDATAWIDTH0[0]);
buf B_RXDATAWIDTH01 (RXDATAWIDTH0_IN[1], RXDATAWIDTH0[1]);
buf B_RXPOLARITY1 (RXPOLARITY1_IN, RXPOLARITY1);
buf B_RXENPCOMMAALIGN1 (RXENPCOMMAALIGN1_IN, RXENPCOMMAALIGN1);
buf B_RXENMCOMMAALIGN1 (RXENMCOMMAALIGN1_IN, RXENMCOMMAALIGN1);
buf B_RXSLIDE1 (RXSLIDE1_IN, RXSLIDE1);
buf B_RXCOMMADETUSE1 (RXCOMMADETUSE1_IN, RXCOMMADETUSE1);
buf B_RXDEC8B10BUSE1 (RXDEC8B10BUSE1_IN, RXDEC8B10BUSE1);
buf B_RXENCHANSYNC1 (RXENCHANSYNC1_IN, RXENCHANSYNC1);
buf B_RXCHBONDI10 (RXCHBONDI1_IN[0], RXCHBONDI1[0]);
buf B_RXCHBONDI11 (RXCHBONDI1_IN[1], RXCHBONDI1[1]);
buf B_RXCHBONDI12 (RXCHBONDI1_IN[2], RXCHBONDI1[2]);
buf B_RXCHBONDI13 (RXCHBONDI1_IN[3], RXCHBONDI1[3]);
buf B_RXDATAWIDTH10 (RXDATAWIDTH1_IN[0], RXDATAWIDTH1[0]);
buf B_RXDATAWIDTH11 (RXDATAWIDTH1_IN[1], RXDATAWIDTH1[1]);
buf B_TXELECIDLE0 (TXELECIDLE0_IN, TXELECIDLE0);
buf B_TXDETECTRX0 (TXDETECTRX0_IN, TXDETECTRX0);
buf B_TXELECIDLE1 (TXELECIDLE1_IN, TXELECIDLE1);
buf B_TXDETECTRX1 (TXDETECTRX1_IN, TXDETECTRX1);
buf B_TXCOMSTART0 (TXCOMSTART0_IN, TXCOMSTART0);
buf B_TXCOMTYPE0 (TXCOMTYPE0_IN, TXCOMTYPE0);
buf B_TXCOMSTART1 (TXCOMSTART1_IN, TXCOMSTART1);
buf B_TXCOMTYPE1 (TXCOMTYPE1_IN, TXCOMTYPE1);
buf B_PLLLKDETEN (PLLLKDETEN_IN, PLLLKDETEN);
buf B_TXENPRBSTST00 (TXENPRBSTST0_IN[0], TXENPRBSTST0[0]);
buf B_TXENPRBSTST01 (TXENPRBSTST0_IN[1], TXENPRBSTST0[1]);
buf B_RXENPRBSTST00 (RXENPRBSTST0_IN[0], RXENPRBSTST0[0]);
buf B_RXENPRBSTST01 (RXENPRBSTST0_IN[1], RXENPRBSTST0[1]);
buf B_PRBSCNTRESET0 (PRBSCNTRESET0_IN, PRBSCNTRESET0);
buf B_TXENPRBSTST10 (TXENPRBSTST1_IN[0], TXENPRBSTST1[0]);
buf B_TXENPRBSTST11 (TXENPRBSTST1_IN[1], TXENPRBSTST1[1]);
buf B_RXENPRBSTST10 (RXENPRBSTST1_IN[0], RXENPRBSTST1[0]);
buf B_RXENPRBSTST11 (RXENPRBSTST1_IN[1], RXENPRBSTST1[1]);
buf B_PRBSCNTRESET1 (PRBSCNTRESET1_IN, PRBSCNTRESET1);
buf B_DCLK (DCLK_IN, DCLK);
buf B_DADDR0 (DADDR_IN[0], DADDR[0]);
buf B_DADDR1 (DADDR_IN[1], DADDR[1]);
buf B_DADDR2 (DADDR_IN[2], DADDR[2]);
buf B_DADDR3 (DADDR_IN[3], DADDR[3]);
buf B_DADDR4 (DADDR_IN[4], DADDR[4]);
buf B_DADDR5 (DADDR_IN[5], DADDR[5]);
buf B_DADDR6 (DADDR_IN[6], DADDR[6]);
buf B_DI0 (DI_IN[0], DI[0]);
buf B_DI1 (DI_IN[1], DI[1]);
buf B_DI2 (DI_IN[2], DI[2]);
buf B_DI3 (DI_IN[3], DI[3]);
buf B_DI4 (DI_IN[4], DI[4]);
buf B_DI5 (DI_IN[5], DI[5]);
buf B_DI6 (DI_IN[6], DI[6]);
buf B_DI7 (DI_IN[7], DI[7]);
buf B_DI8 (DI_IN[8], DI[8]);
buf B_DI9 (DI_IN[9], DI[9]);
buf B_DI10 (DI_IN[10], DI[10]);
buf B_DI11 (DI_IN[11], DI[11]);
buf B_DI12 (DI_IN[12], DI[12]);
buf B_DI13 (DI_IN[13], DI[13]);
buf B_DI14 (DI_IN[14], DI[14]);
buf B_DI15 (DI_IN[15], DI[15]);
buf B_DEN (DEN_IN, DEN);
buf B_DWE (DWE_IN, DWE);
buf B_RXENSAMPLEALIGN0 (RXENSAMPLEALIGN0_IN, RXENSAMPLEALIGN0);
buf B_RXENSAMPLEALIGN1 (RXENSAMPLEALIGN1_IN, RXENSAMPLEALIGN1);
buf B_GTXTEST0 (GTXTEST_IN[0], GTXTEST[0]);
buf B_GTXTEST1 (GTXTEST_IN[1], GTXTEST[1]);
buf B_GTXTEST2 (GTXTEST_IN[2], GTXTEST[2]);
buf B_GTXTEST3 (GTXTEST_IN[3], GTXTEST[3]);
buf B_GTXTEST4 (GTXTEST_IN[4], GTXTEST[4]);
buf B_GTXTEST5 (GTXTEST_IN[5], GTXTEST[5]);
buf B_GTXTEST6 (GTXTEST_IN[6], GTXTEST[6]);
buf B_GTXTEST7 (GTXTEST_IN[7], GTXTEST[7]);
buf B_GTXTEST8 (GTXTEST_IN[8], GTXTEST[8]);
buf B_GTXTEST9 (GTXTEST_IN[9], GTXTEST[9]);
buf B_GTXTEST10 (GTXTEST_IN[10], GTXTEST[10]);
buf B_GTXTEST11 (GTXTEST_IN[11], GTXTEST[11]);
buf B_GTXTEST12 (GTXTEST_IN[12], GTXTEST[12]);
buf B_GTXTEST13 (GTXTEST_IN[13], GTXTEST[13]);
buf B_TXHEADER00 (TXHEADER0_IN[0], TXHEADER0[0]);
buf B_TXHEADER01 (TXHEADER0_IN[1], TXHEADER0[1]);
buf B_TXHEADER02 (TXHEADER0_IN[2], TXHEADER0[2]);
buf B_TXSEQUENCE00 (TXSEQUENCE0_IN[0], TXSEQUENCE0[0]);
buf B_TXSEQUENCE01 (TXSEQUENCE0_IN[1], TXSEQUENCE0[1]);
buf B_TXSEQUENCE02 (TXSEQUENCE0_IN[2], TXSEQUENCE0[2]);
buf B_TXSEQUENCE03 (TXSEQUENCE0_IN[3], TXSEQUENCE0[3]);
buf B_TXSEQUENCE04 (TXSEQUENCE0_IN[4], TXSEQUENCE0[4]);
buf B_TXSEQUENCE05 (TXSEQUENCE0_IN[5], TXSEQUENCE0[5]);
buf B_TXSEQUENCE06 (TXSEQUENCE0_IN[6], TXSEQUENCE0[6]);
buf B_TXSTARTSEQ0 (TXSTARTSEQ0_IN, TXSTARTSEQ0);
buf B_RXGEARBOXSLIP0 (RXGEARBOXSLIP0_IN, RXGEARBOXSLIP0);
buf B_TXHEADER10 (TXHEADER1_IN[0], TXHEADER1[0]);
buf B_TXHEADER11 (TXHEADER1_IN[1], TXHEADER1[1]);
buf B_TXHEADER12 (TXHEADER1_IN[2], TXHEADER1[2]);
buf B_TXSEQUENCE10 (TXSEQUENCE1_IN[0], TXSEQUENCE1[0]);
buf B_TXSEQUENCE11 (TXSEQUENCE1_IN[1], TXSEQUENCE1[1]);
buf B_TXSEQUENCE12 (TXSEQUENCE1_IN[2], TXSEQUENCE1[2]);
buf B_TXSEQUENCE13 (TXSEQUENCE1_IN[3], TXSEQUENCE1[3]);
buf B_TXSEQUENCE14 (TXSEQUENCE1_IN[4], TXSEQUENCE1[4]);
buf B_TXSEQUENCE15 (TXSEQUENCE1_IN[5], TXSEQUENCE1[5]);
buf B_TXSEQUENCE16 (TXSEQUENCE1_IN[6], TXSEQUENCE1[6]);
buf B_TXSTARTSEQ1 (TXSTARTSEQ1_IN, TXSTARTSEQ1);
buf B_RXGEARBOXSLIP1 (RXGEARBOXSLIP1_IN, RXGEARBOXSLIP1);
buf B_DFECLKDLYADJ00 (DFECLKDLYADJ0_IN[0], DFECLKDLYADJ0[0]);
buf B_DFECLKDLYADJ01 (DFECLKDLYADJ0_IN[1], DFECLKDLYADJ0[1]);
buf B_DFECLKDLYADJ02 (DFECLKDLYADJ0_IN[2], DFECLKDLYADJ0[2]);
buf B_DFECLKDLYADJ03 (DFECLKDLYADJ0_IN[3], DFECLKDLYADJ0[3]);
buf B_DFECLKDLYADJ04 (DFECLKDLYADJ0_IN[4], DFECLKDLYADJ0[4]);
buf B_DFECLKDLYADJ05 (DFECLKDLYADJ0_IN[5], DFECLKDLYADJ0[5]);
buf B_DFETAP100 (DFETAP10_IN[0], DFETAP10[0]);
buf B_DFETAP101 (DFETAP10_IN[1], DFETAP10[1]);
buf B_DFETAP102 (DFETAP10_IN[2], DFETAP10[2]);
buf B_DFETAP103 (DFETAP10_IN[3], DFETAP10[3]);
buf B_DFETAP104 (DFETAP10_IN[4], DFETAP10[4]);
buf B_DFETAP200 (DFETAP20_IN[0], DFETAP20[0]);
buf B_DFETAP201 (DFETAP20_IN[1], DFETAP20[1]);
buf B_DFETAP202 (DFETAP20_IN[2], DFETAP20[2]);
buf B_DFETAP203 (DFETAP20_IN[3], DFETAP20[3]);
buf B_DFETAP204 (DFETAP20_IN[4], DFETAP20[4]);
buf B_DFETAP300 (DFETAP30_IN[0], DFETAP30[0]);
buf B_DFETAP301 (DFETAP30_IN[1], DFETAP30[1]);
buf B_DFETAP302 (DFETAP30_IN[2], DFETAP30[2]);
buf B_DFETAP303 (DFETAP30_IN[3], DFETAP30[3]);
buf B_DFETAP400 (DFETAP40_IN[0], DFETAP40[0]);
buf B_DFETAP401 (DFETAP40_IN[1], DFETAP40[1]);
buf B_DFETAP402 (DFETAP40_IN[2], DFETAP40[2]);
buf B_DFETAP403 (DFETAP40_IN[3], DFETAP40[3]);
buf B_DFECLKDLYADJ10 (DFECLKDLYADJ1_IN[0], DFECLKDLYADJ1[0]);
buf B_DFECLKDLYADJ11 (DFECLKDLYADJ1_IN[1], DFECLKDLYADJ1[1]);
buf B_DFECLKDLYADJ12 (DFECLKDLYADJ1_IN[2], DFECLKDLYADJ1[2]);
buf B_DFECLKDLYADJ13 (DFECLKDLYADJ1_IN[3], DFECLKDLYADJ1[3]);
buf B_DFECLKDLYADJ14 (DFECLKDLYADJ1_IN[4], DFECLKDLYADJ1[4]);
buf B_DFECLKDLYADJ15 (DFECLKDLYADJ1_IN[5], DFECLKDLYADJ1[5]);
buf B_DFETAP110 (DFETAP11_IN[0], DFETAP11[0]);
buf B_DFETAP111 (DFETAP11_IN[1], DFETAP11[1]);
buf B_DFETAP112 (DFETAP11_IN[2], DFETAP11[2]);
buf B_DFETAP113 (DFETAP11_IN[3], DFETAP11[3]);
buf B_DFETAP114 (DFETAP11_IN[4], DFETAP11[4]);
buf B_DFETAP210 (DFETAP21_IN[0], DFETAP21[0]);
buf B_DFETAP211 (DFETAP21_IN[1], DFETAP21[1]);
buf B_DFETAP212 (DFETAP21_IN[2], DFETAP21[2]);
buf B_DFETAP213 (DFETAP21_IN[3], DFETAP21[3]);
buf B_DFETAP214 (DFETAP21_IN[4], DFETAP21[4]);
buf B_DFETAP310 (DFETAP31_IN[0], DFETAP31[0]);
buf B_DFETAP311 (DFETAP31_IN[1], DFETAP31[1]);
buf B_DFETAP312 (DFETAP31_IN[2], DFETAP31[2]);
buf B_DFETAP313 (DFETAP31_IN[3], DFETAP31[3]);
buf B_DFETAP410 (DFETAP41_IN[0], DFETAP41[0]);
buf B_DFETAP411 (DFETAP41_IN[1], DFETAP41[1]);
buf B_DFETAP412 (DFETAP41_IN[2], DFETAP41[2]);
buf B_DFETAP413 (DFETAP41_IN[3], DFETAP41[3]);

wire DRDY_delay;
wire PHYSTATUS0_delay;
wire PHYSTATUS1_delay;
wire PLLLKDET_delay;
wire REFCLKOUT_delay;
wire RESETDONE0_delay;
wire RESETDONE1_delay;
wire RXBYTEISALIGNED0_delay;
wire RXBYTEISALIGNED1_delay;
wire RXBYTEREALIGN0_delay;
wire RXBYTEREALIGN1_delay;
wire RXCHANBONDSEQ0_delay;
wire RXCHANBONDSEQ1_delay;
wire RXCHANISALIGNED0_delay;
wire RXCHANISALIGNED1_delay;
wire RXCHANREALIGN0_delay;
wire RXCHANREALIGN1_delay;
wire RXCOMMADET0_delay;
wire RXCOMMADET1_delay;
wire RXDATAVALID0_delay;
wire RXDATAVALID1_delay;
wire RXELECIDLE0_delay;
wire RXELECIDLE1_delay;
wire RXHEADERVALID0_delay;
wire RXHEADERVALID1_delay;
wire RXOVERSAMPLEERR0_delay;
wire RXOVERSAMPLEERR1_delay;
wire RXPRBSERR0_delay;
wire RXPRBSERR1_delay;
wire RXRECCLK0_delay;
wire RXRECCLK1_delay;
wire RXSTARTOFSEQ0_delay;
wire RXSTARTOFSEQ1_delay;
wire RXVALID0_delay;
wire RXVALID1_delay;
wire TXGEARBOXREADY0_delay;
wire TXGEARBOXREADY1_delay;
wire TXN0_delay;
wire TXN1_delay;
wire TXOUTCLK0_delay;
wire TXOUTCLK1_delay;
wire TXP0_delay;
wire TXP1_delay;
wire [15:0] DO_delay;
wire [1:0] RXLOSSOFSYNC0_delay;
wire [1:0] RXLOSSOFSYNC1_delay;
wire [1:0] TXBUFSTATUS0_delay;
wire [1:0] TXBUFSTATUS1_delay;
wire [2:0] DFESENSCAL0_delay;
wire [2:0] DFESENSCAL1_delay;
wire [2:0] RXBUFSTATUS0_delay;
wire [2:0] RXBUFSTATUS1_delay;
wire [2:0] RXCLKCORCNT0_delay;
wire [2:0] RXCLKCORCNT1_delay;
wire [2:0] RXHEADER0_delay;
wire [2:0] RXHEADER1_delay;
wire [2:0] RXSTATUS0_delay;
wire [2:0] RXSTATUS1_delay;
wire [31:0] RXDATA0_delay;
wire [31:0] RXDATA1_delay;
wire [3:0] DFETAP3MONITOR0_delay;
wire [3:0] DFETAP3MONITOR1_delay;
wire [3:0] DFETAP4MONITOR0_delay;
wire [3:0] DFETAP4MONITOR1_delay;
wire [3:0] RXCHARISCOMMA0_delay;
wire [3:0] RXCHARISCOMMA1_delay;
wire [3:0] RXCHARISK0_delay;
wire [3:0] RXCHARISK1_delay;
wire [3:0] RXCHBONDO0_delay;
wire [3:0] RXCHBONDO1_delay;
wire [3:0] RXDISPERR0_delay;
wire [3:0] RXDISPERR1_delay;
wire [3:0] RXNOTINTABLE0_delay;
wire [3:0] RXNOTINTABLE1_delay;
wire [3:0] RXRUNDISP0_delay;
wire [3:0] RXRUNDISP1_delay;
wire [3:0] TXKERR0_delay;
wire [3:0] TXKERR1_delay;
wire [3:0] TXRUNDISP0_delay;
wire [3:0] TXRUNDISP1_delay;
wire [4:0] DFEEYEDACMONITOR0_delay;
wire [4:0] DFEEYEDACMONITOR1_delay;
wire [4:0] DFETAP1MONITOR0_delay;
wire [4:0] DFETAP1MONITOR1_delay;
wire [4:0] DFETAP2MONITOR0_delay;
wire [4:0] DFETAP2MONITOR1_delay;
wire [5:0] DFECLKDLYADJMONITOR0_delay;
wire [5:0] DFECLKDLYADJMONITOR1_delay;

wire CLKIN_delay;
wire DCLK_delay;
wire DEN_delay;
wire DWE_delay;
wire GTXRESET_delay;
wire INTDATAWIDTH_delay;
wire PLLLKDETEN_delay;
wire PLLPOWERDOWN_delay;
wire PRBSCNTRESET0_delay;
wire PRBSCNTRESET1_delay;
wire REFCLKPWRDNB_delay;
wire RXBUFRESET0_delay;
wire RXBUFRESET1_delay;
wire RXCDRRESET0_delay;
wire RXCDRRESET1_delay;
wire RXCOMMADETUSE0_delay;
wire RXCOMMADETUSE1_delay;
wire RXDEC8B10BUSE0_delay;
wire RXDEC8B10BUSE1_delay;
wire RXENCHANSYNC0_delay;
wire RXENCHANSYNC1_delay;
wire RXENEQB0_delay;
wire RXENEQB1_delay;
wire RXENMCOMMAALIGN0_delay;
wire RXENMCOMMAALIGN1_delay;
wire RXENPCOMMAALIGN0_delay;
wire RXENPCOMMAALIGN1_delay;
wire RXENPMAPHASEALIGN0_delay;
wire RXENPMAPHASEALIGN1_delay;
wire RXENSAMPLEALIGN0_delay;
wire RXENSAMPLEALIGN1_delay;
wire RXGEARBOXSLIP0_delay;
wire RXGEARBOXSLIP1_delay;
wire RXN0_delay;
wire RXN1_delay;
wire RXP0_delay;
wire RXP1_delay;
wire RXPMASETPHASE0_delay;
wire RXPMASETPHASE1_delay;
wire RXPOLARITY0_delay;
wire RXPOLARITY1_delay;
wire RXRESET0_delay;
wire RXRESET1_delay;
wire RXSLIDE0_delay;
wire RXSLIDE1_delay;
wire RXUSRCLK0_delay;
wire RXUSRCLK1_delay;
wire RXUSRCLK20_delay;
wire RXUSRCLK21_delay;
wire TXCOMSTART0_delay;
wire TXCOMSTART1_delay;
wire TXCOMTYPE0_delay;
wire TXCOMTYPE1_delay;
wire TXDETECTRX0_delay;
wire TXDETECTRX1_delay;
wire TXELECIDLE0_delay;
wire TXELECIDLE1_delay;
wire TXENC8B10BUSE0_delay;
wire TXENC8B10BUSE1_delay;
wire TXENPMAPHASEALIGN0_delay;
wire TXENPMAPHASEALIGN1_delay;
wire TXINHIBIT0_delay;
wire TXINHIBIT1_delay;
wire TXPMASETPHASE0_delay;
wire TXPMASETPHASE1_delay;
wire TXPOLARITY0_delay;
wire TXPOLARITY1_delay;
wire TXRESET0_delay;
wire TXRESET1_delay;
wire TXSTARTSEQ0_delay;
wire TXSTARTSEQ1_delay;
wire TXUSRCLK0_delay;
wire TXUSRCLK1_delay;
wire TXUSRCLK20_delay;
wire TXUSRCLK21_delay;
wire [13:0] GTXTEST_delay;
wire [15:0] DI_delay;
wire [1:0] RXDATAWIDTH0_delay;
wire [1:0] RXDATAWIDTH1_delay;
wire [1:0] RXENPRBSTST0_delay;
wire [1:0] RXENPRBSTST1_delay;
wire [1:0] RXEQMIX0_delay;
wire [1:0] RXEQMIX1_delay;
wire [1:0] RXPOWERDOWN0_delay;
wire [1:0] RXPOWERDOWN1_delay;
wire [1:0] TXDATAWIDTH0_delay;
wire [1:0] TXDATAWIDTH1_delay;
wire [1:0] TXENPRBSTST0_delay;
wire [1:0] TXENPRBSTST1_delay;
wire [1:0] TXPOWERDOWN0_delay;
wire [1:0] TXPOWERDOWN1_delay;
wire [2:0] LOOPBACK0_delay;
wire [2:0] LOOPBACK1_delay;
wire [2:0] TXBUFDIFFCTRL0_delay;
wire [2:0] TXBUFDIFFCTRL1_delay;
wire [2:0] TXDIFFCTRL0_delay;
wire [2:0] TXDIFFCTRL1_delay;
wire [2:0] TXHEADER0_delay;
wire [2:0] TXHEADER1_delay;
wire [31:0] TXDATA0_delay;
wire [31:0] TXDATA1_delay;
wire [3:0] DFETAP30_delay;
wire [3:0] DFETAP31_delay;
wire [3:0] DFETAP40_delay;
wire [3:0] DFETAP41_delay;
wire [3:0] RXCHBONDI0_delay;
wire [3:0] RXCHBONDI1_delay;
wire [3:0] RXEQPOLE0_delay;
wire [3:0] RXEQPOLE1_delay;
wire [3:0] TXBYPASS8B10B0_delay;
wire [3:0] TXBYPASS8B10B1_delay;
wire [3:0] TXCHARDISPMODE0_delay;
wire [3:0] TXCHARDISPMODE1_delay;
wire [3:0] TXCHARDISPVAL0_delay;
wire [3:0] TXCHARDISPVAL1_delay;
wire [3:0] TXCHARISK0_delay;
wire [3:0] TXCHARISK1_delay;
wire [3:0] TXPREEMPHASIS0_delay;
wire [3:0] TXPREEMPHASIS1_delay;
wire [4:0] DFETAP10_delay;
wire [4:0] DFETAP11_delay;
wire [4:0] DFETAP20_delay;
wire [4:0] DFETAP21_delay;
wire [5:0] DFECLKDLYADJ0_delay;
wire [5:0] DFECLKDLYADJ1_delay;
wire [6:0] DADDR_delay;
wire [6:0] TXSEQUENCE0_delay;
wire [6:0] TXSEQUENCE1_delay;

assign #(CLK_DELAY) DFECLKDLYADJMONITOR0_OUT = DFECLKDLYADJMONITOR0_delay;
assign #(CLK_DELAY) DFECLKDLYADJMONITOR1_OUT = DFECLKDLYADJMONITOR1_delay;
assign #(CLK_DELAY) REFCLKOUT_OUT = REFCLKOUT_delay;
assign #(CLK_DELAY) RXCLKCORCNT0_OUT = RXCLKCORCNT0_delay;
assign #(CLK_DELAY) RXCLKCORCNT1_OUT = RXCLKCORCNT1_delay;
assign #(CLK_DELAY) RXRECCLK0_OUT = RXRECCLK0_delay;
assign #(CLK_DELAY) RXRECCLK1_OUT = RXRECCLK1_delay;
assign #(CLK_DELAY) TXOUTCLK0_OUT = TXOUTCLK0_delay;
assign #(CLK_DELAY) TXOUTCLK1_OUT = TXOUTCLK1_delay;

assign #(out_delay) DFEEYEDACMONITOR0_OUT = DFEEYEDACMONITOR0_delay;
assign #(out_delay) DFEEYEDACMONITOR1_OUT = DFEEYEDACMONITOR1_delay;
assign #(out_delay) DFESENSCAL0_OUT = DFESENSCAL0_delay;
assign #(out_delay) DFESENSCAL1_OUT = DFESENSCAL1_delay;
assign #(out_delay) DFETAP1MONITOR0_OUT = DFETAP1MONITOR0_delay;
assign #(out_delay) DFETAP1MONITOR1_OUT = DFETAP1MONITOR1_delay;
assign #(out_delay) DFETAP2MONITOR0_OUT = DFETAP2MONITOR0_delay;
assign #(out_delay) DFETAP2MONITOR1_OUT = DFETAP2MONITOR1_delay;
assign #(out_delay) DFETAP3MONITOR0_OUT = DFETAP3MONITOR0_delay;
assign #(out_delay) DFETAP3MONITOR1_OUT = DFETAP3MONITOR1_delay;
assign #(out_delay) DFETAP4MONITOR0_OUT = DFETAP4MONITOR0_delay;
assign #(out_delay) DFETAP4MONITOR1_OUT = DFETAP4MONITOR1_delay;
assign #(out_delay) DO_OUT = DO_delay;
assign #(out_delay) DRDY_OUT = DRDY_delay;
assign #(out_delay) PHYSTATUS0_OUT = PHYSTATUS0_delay;
assign #(out_delay) PHYSTATUS1_OUT = PHYSTATUS1_delay;
assign #(out_delay) PLLLKDET_OUT = PLLLKDET_delay;
assign #(out_delay) RESETDONE0_OUT = RESETDONE0_delay;
assign #(out_delay) RESETDONE1_OUT = RESETDONE1_delay;
assign #(out_delay) RXBUFSTATUS0_OUT = RXBUFSTATUS0_delay;
assign #(out_delay) RXBUFSTATUS1_OUT = RXBUFSTATUS1_delay;
assign #(out_delay) RXBYTEISALIGNED0_OUT = RXBYTEISALIGNED0_delay;
assign #(out_delay) RXBYTEISALIGNED1_OUT = RXBYTEISALIGNED1_delay;
assign #(out_delay) RXBYTEREALIGN0_OUT = RXBYTEREALIGN0_delay;
assign #(out_delay) RXBYTEREALIGN1_OUT = RXBYTEREALIGN1_delay;
assign #(out_delay) RXCHANBONDSEQ0_OUT = RXCHANBONDSEQ0_delay;
assign #(out_delay) RXCHANBONDSEQ1_OUT = RXCHANBONDSEQ1_delay;
assign #(out_delay) RXCHANISALIGNED0_OUT = RXCHANISALIGNED0_delay;
assign #(out_delay) RXCHANISALIGNED1_OUT = RXCHANISALIGNED1_delay;
assign #(out_delay) RXCHANREALIGN0_OUT = RXCHANREALIGN0_delay;
assign #(out_delay) RXCHANREALIGN1_OUT = RXCHANREALIGN1_delay;
assign #(out_delay) RXCHARISCOMMA0_OUT = RXCHARISCOMMA0_delay;
assign #(out_delay) RXCHARISCOMMA1_OUT = RXCHARISCOMMA1_delay;
assign #(out_delay) RXCHARISK0_OUT = RXCHARISK0_delay;
assign #(out_delay) RXCHARISK1_OUT = RXCHARISK1_delay;
assign #(out_delay) RXCHBONDO0_OUT = RXCHBONDO0_delay;
assign #(out_delay) RXCHBONDO1_OUT = RXCHBONDO1_delay;
assign #(out_delay) RXCOMMADET0_OUT = RXCOMMADET0_delay;
assign #(out_delay) RXCOMMADET1_OUT = RXCOMMADET1_delay;
assign #(out_delay) RXDATA0_OUT = RXDATA0_delay;
assign #(out_delay) RXDATA1_OUT = RXDATA1_delay;
assign #(out_delay) RXDATAVALID0_OUT = RXDATAVALID0_delay;
assign #(out_delay) RXDATAVALID1_OUT = RXDATAVALID1_delay;
assign #(out_delay) RXDISPERR0_OUT = RXDISPERR0_delay;
assign #(out_delay) RXDISPERR1_OUT = RXDISPERR1_delay;
assign #(out_delay) RXELECIDLE0_OUT = RXELECIDLE0_delay;
assign #(out_delay) RXELECIDLE1_OUT = RXELECIDLE1_delay;
assign #(out_delay) RXHEADER0_OUT = RXHEADER0_delay;
assign #(out_delay) RXHEADER1_OUT = RXHEADER1_delay;
assign #(out_delay) RXHEADERVALID0_OUT = RXHEADERVALID0_delay;
assign #(out_delay) RXHEADERVALID1_OUT = RXHEADERVALID1_delay;
assign #(out_delay) RXLOSSOFSYNC0_OUT = RXLOSSOFSYNC0_delay;
assign #(out_delay) RXLOSSOFSYNC1_OUT = RXLOSSOFSYNC1_delay;
assign #(out_delay) RXNOTINTABLE0_OUT = RXNOTINTABLE0_delay;
assign #(out_delay) RXNOTINTABLE1_OUT = RXNOTINTABLE1_delay;
assign #(out_delay) RXOVERSAMPLEERR0_OUT = RXOVERSAMPLEERR0_delay;
assign #(out_delay) RXOVERSAMPLEERR1_OUT = RXOVERSAMPLEERR1_delay;
assign #(out_delay) RXPRBSERR0_OUT = RXPRBSERR0_delay;
assign #(out_delay) RXPRBSERR1_OUT = RXPRBSERR1_delay;
assign #(out_delay) RXRUNDISP0_OUT = RXRUNDISP0_delay;
assign #(out_delay) RXRUNDISP1_OUT = RXRUNDISP1_delay;
assign #(out_delay) RXSTARTOFSEQ0_OUT = RXSTARTOFSEQ0_delay;
assign #(out_delay) RXSTARTOFSEQ1_OUT = RXSTARTOFSEQ1_delay;
assign #(out_delay) RXSTATUS0_OUT = RXSTATUS0_delay;
assign #(out_delay) RXSTATUS1_OUT = RXSTATUS1_delay;
assign #(out_delay) RXVALID0_OUT = RXVALID0_delay;
assign #(out_delay) RXVALID1_OUT = RXVALID1_delay;
assign #(out_delay) TXBUFSTATUS0_OUT = TXBUFSTATUS0_delay;
assign #(out_delay) TXBUFSTATUS1_OUT = TXBUFSTATUS1_delay;
assign #(out_delay) TXGEARBOXREADY0_OUT = TXGEARBOXREADY0_delay;
assign #(out_delay) TXGEARBOXREADY1_OUT = TXGEARBOXREADY1_delay;
assign #(out_delay) TXKERR0_OUT = TXKERR0_delay;
assign #(out_delay) TXKERR1_OUT = TXKERR1_delay;
assign #(out_delay) TXN0_OUT = TXN0_delay;
assign #(out_delay) TXN1_OUT = TXN1_delay;
assign #(out_delay) TXP0_OUT = TXP0_delay;
assign #(out_delay) TXP1_OUT = TXP1_delay;
assign #(out_delay) TXRUNDISP0_OUT = TXRUNDISP0_delay;
assign #(out_delay) TXRUNDISP1_OUT = TXRUNDISP1_delay;

//assign #(CLK_DELAY) DCLK_delay = DCLK_IN;
//assign #(CLK_DELAY) RXUSRCLK0_delay = RXUSRCLK0_IN;
//assign #(CLK_DELAY) RXUSRCLK1_delay = RXUSRCLK1_IN;
//assign #(CLK_DELAY) RXUSRCLK20_delay = RXUSRCLK20_IN;
//assign #(CLK_DELAY) RXUSRCLK21_delay = RXUSRCLK21_IN;
assign #(CLK_DELAY) TXUSRCLK0_delay = TXUSRCLK0_IN;
assign #(CLK_DELAY) TXUSRCLK1_delay = TXUSRCLK1_IN;
//assign #(CLK_DELAY) TXUSRCLK20_delay = TXUSRCLK20_IN;
//assign #(CLK_DELAY) TXUSRCLK21_delay = TXUSRCLK21_IN;

assign #(in_delay) CLKIN_delay = CLKIN_IN;
//assign #(in_delay) DADDR_delay = DADDR_IN;
//assign #(in_delay) DEN_delay = DEN_IN;
//assign #(in_delay) DFECLKDLYADJ0_delay = DFECLKDLYADJ0_IN;
//assign #(in_delay) DFECLKDLYADJ1_delay = DFECLKDLYADJ1_IN;
//assign #(in_delay) DFETAP10_delay = DFETAP10_IN;
//assign #(in_delay) DFETAP11_delay = DFETAP11_IN;
//assign #(in_delay) DFETAP20_delay = DFETAP20_IN;
//assign #(in_delay) DFETAP21_delay = DFETAP21_IN;
//assign #(in_delay) DFETAP30_delay = DFETAP30_IN;
//assign #(in_delay) DFETAP31_delay = DFETAP31_IN;
//assign #(in_delay) DFETAP40_delay = DFETAP40_IN;
//assign #(in_delay) DFETAP41_delay = DFETAP41_IN;
//assign #(in_delay) DI_delay = DI_IN;
//assign #(in_delay) DWE_delay = DWE_IN;
assign #(in_delay) GTXRESET_delay = GTXRESET_IN;
assign #(in_delay) GTXTEST_delay = GTXTEST_IN;
assign #(in_delay) INTDATAWIDTH_delay = INTDATAWIDTH_IN;
assign #(in_delay) LOOPBACK0_delay = LOOPBACK0_IN;
assign #(in_delay) LOOPBACK1_delay = LOOPBACK1_IN;
assign #(in_delay) PLLLKDETEN_delay = PLLLKDETEN_IN;
assign #(in_delay) PLLPOWERDOWN_delay = PLLPOWERDOWN_IN;
//assign #(in_delay) PRBSCNTRESET0_delay = PRBSCNTRESET0_IN;
//assign #(in_delay) PRBSCNTRESET1_delay = PRBSCNTRESET1_IN;
assign #(in_delay) REFCLKPWRDNB_delay = REFCLKPWRDNB_IN;
assign #(in_delay) RXBUFRESET0_delay = RXBUFRESET0_IN;
assign #(in_delay) RXBUFRESET1_delay = RXBUFRESET1_IN;
assign #(in_delay) RXCDRRESET0_delay = RXCDRRESET0_IN;
assign #(in_delay) RXCDRRESET1_delay = RXCDRRESET1_IN;
//assign #(in_delay) RXCHBONDI0_delay = RXCHBONDI0_IN;
//assign #(in_delay) RXCHBONDI1_delay = RXCHBONDI1_IN;
//assign #(in_delay) RXCOMMADETUSE0_delay = RXCOMMADETUSE0_IN;
//assign #(in_delay) RXCOMMADETUSE1_delay = RXCOMMADETUSE1_IN;
assign #(in_delay) RXDATAWIDTH0_delay = RXDATAWIDTH0_IN;
assign #(in_delay) RXDATAWIDTH1_delay = RXDATAWIDTH1_IN;
//assign #(in_delay) RXDEC8B10BUSE0_delay = RXDEC8B10BUSE0_IN;
//assign #(in_delay) RXDEC8B10BUSE1_delay = RXDEC8B10BUSE1_IN;
//assign #(in_delay) RXENCHANSYNC0_delay = RXENCHANSYNC0_IN;
//assign #(in_delay) RXENCHANSYNC1_delay = RXENCHANSYNC1_IN;
assign #(in_delay) RXENEQB0_delay = RXENEQB0_IN;
assign #(in_delay) RXENEQB1_delay = RXENEQB1_IN;
//assign #(in_delay) RXENMCOMMAALIGN0_delay = RXENMCOMMAALIGN0_IN;
//assign #(in_delay) RXENMCOMMAALIGN1_delay = RXENMCOMMAALIGN1_IN;
//assign #(in_delay) RXENPCOMMAALIGN0_delay = RXENPCOMMAALIGN0_IN;
//assign #(in_delay) RXENPCOMMAALIGN1_delay = RXENPCOMMAALIGN1_IN;
assign #(in_delay) RXENPMAPHASEALIGN0_delay = RXENPMAPHASEALIGN0_IN;
assign #(in_delay) RXENPMAPHASEALIGN1_delay = RXENPMAPHASEALIGN1_IN;
//assign #(in_delay) RXENPRBSTST0_delay = RXENPRBSTST0_IN;
//assign #(in_delay) RXENPRBSTST1_delay = RXENPRBSTST1_IN;
//assign #(in_delay) RXENSAMPLEALIGN0_delay = RXENSAMPLEALIGN0_IN;
//assign #(in_delay) RXENSAMPLEALIGN1_delay = RXENSAMPLEALIGN1_IN;
assign #(in_delay) RXEQMIX0_delay = RXEQMIX0_IN;
assign #(in_delay) RXEQMIX1_delay = RXEQMIX1_IN;
assign #(in_delay) RXEQPOLE0_delay = RXEQPOLE0_IN;
assign #(in_delay) RXEQPOLE1_delay = RXEQPOLE1_IN;
//assign #(in_delay) RXGEARBOXSLIP0_delay = RXGEARBOXSLIP0_IN;
//assign #(in_delay) RXGEARBOXSLIP1_delay = RXGEARBOXSLIP1_IN;
assign #(in_delay) RXN0_delay = RXN0_IN;
assign #(in_delay) RXN1_delay = RXN1_IN;
assign #(in_delay) RXP0_delay = RXP0_IN;
assign #(in_delay) RXP1_delay = RXP1_IN;
assign #(in_delay) RXPMASETPHASE0_delay = RXPMASETPHASE0_IN;
assign #(in_delay) RXPMASETPHASE1_delay = RXPMASETPHASE1_IN;
//assign #(in_delay) RXPOLARITY0_delay = RXPOLARITY0_IN;
//assign #(in_delay) RXPOLARITY1_delay = RXPOLARITY1_IN;
assign #(in_delay) RXPOWERDOWN0_delay = RXPOWERDOWN0_IN;
assign #(in_delay) RXPOWERDOWN1_delay = RXPOWERDOWN1_IN;
assign #(in_delay) RXRESET0_delay = RXRESET0_IN;
assign #(in_delay) RXRESET1_delay = RXRESET1_IN;
//assign #(in_delay) RXSLIDE0_delay = RXSLIDE0_IN;
//assign #(in_delay) RXSLIDE1_delay = RXSLIDE1_IN;
assign #(in_delay) TXBUFDIFFCTRL0_delay = TXBUFDIFFCTRL0_IN;
assign #(in_delay) TXBUFDIFFCTRL1_delay = TXBUFDIFFCTRL1_IN;
//assign #(in_delay) TXBYPASS8B10B0_delay = TXBYPASS8B10B0_IN;
//assign #(in_delay) TXBYPASS8B10B1_delay = TXBYPASS8B10B1_IN;
//assign #(in_delay) TXCHARDISPMODE0_delay = TXCHARDISPMODE0_IN;
//assign #(in_delay) TXCHARDISPMODE1_delay = TXCHARDISPMODE1_IN;
//assign #(in_delay) TXCHARDISPVAL0_delay = TXCHARDISPVAL0_IN;
//assign #(in_delay) TXCHARDISPVAL1_delay = TXCHARDISPVAL1_IN;
//assign #(in_delay) TXCHARISK0_delay = TXCHARISK0_IN;
//assign #(in_delay) TXCHARISK1_delay = TXCHARISK1_IN;
//assign #(in_delay) TXCOMSTART0_delay = TXCOMSTART0_IN;
//assign #(in_delay) TXCOMSTART1_delay = TXCOMSTART1_IN;
//assign #(in_delay) TXCOMTYPE0_delay = TXCOMTYPE0_IN;
//assign #(in_delay) TXCOMTYPE1_delay = TXCOMTYPE1_IN;
//assign #(in_delay) TXDATA0_delay = TXDATA0_IN;
//assign #(in_delay) TXDATA1_delay = TXDATA1_IN;
assign #(in_delay) TXDATAWIDTH0_delay = TXDATAWIDTH0_IN;
assign #(in_delay) TXDATAWIDTH1_delay = TXDATAWIDTH1_IN;
//assign #(in_delay) TXDETECTRX0_delay = TXDETECTRX0_IN;
//assign #(in_delay) TXDETECTRX1_delay = TXDETECTRX1_IN;
assign #(in_delay) TXDIFFCTRL0_delay = TXDIFFCTRL0_IN;
assign #(in_delay) TXDIFFCTRL1_delay = TXDIFFCTRL1_IN;
//assign #(in_delay) TXELECIDLE0_delay = TXELECIDLE0_IN;
//assign #(in_delay) TXELECIDLE1_delay = TXELECIDLE1_IN;
//assign #(in_delay) TXENC8B10BUSE0_delay = TXENC8B10BUSE0_IN;
//assign #(in_delay) TXENC8B10BUSE1_delay = TXENC8B10BUSE1_IN;
assign #(in_delay) TXENPMAPHASEALIGN0_delay = TXENPMAPHASEALIGN0_IN;
assign #(in_delay) TXENPMAPHASEALIGN1_delay = TXENPMAPHASEALIGN1_IN;
//assign #(in_delay) TXENPRBSTST0_delay = TXENPRBSTST0_IN;
//assign #(in_delay) TXENPRBSTST1_delay = TXENPRBSTST1_IN;
//assign #(in_delay) TXHEADER0_delay = TXHEADER0_IN;
//assign #(in_delay) TXHEADER1_delay = TXHEADER1_IN;
//assign #(in_delay) TXINHIBIT0_delay = TXINHIBIT0_IN;
//assign #(in_delay) TXINHIBIT1_delay = TXINHIBIT1_IN;
assign #(in_delay) TXPMASETPHASE0_delay = TXPMASETPHASE0_IN;
assign #(in_delay) TXPMASETPHASE1_delay = TXPMASETPHASE1_IN;
//assign #(in_delay) TXPOLARITY0_delay = TXPOLARITY0_IN;
//assign #(in_delay) TXPOLARITY1_delay = TXPOLARITY1_IN;
assign #(in_delay) TXPOWERDOWN0_delay = TXPOWERDOWN0_IN;
assign #(in_delay) TXPOWERDOWN1_delay = TXPOWERDOWN1_IN;
assign #(in_delay) TXPREEMPHASIS0_delay = TXPREEMPHASIS0_IN;
assign #(in_delay) TXPREEMPHASIS1_delay = TXPREEMPHASIS1_IN;
assign #(in_delay) TXRESET0_delay = TXRESET0_IN;
assign #(in_delay) TXRESET1_delay = TXRESET1_IN;
//assign #(in_delay) TXSEQUENCE0_delay = TXSEQUENCE0_IN;
//assign #(in_delay) TXSEQUENCE1_delay = TXSEQUENCE1_IN;
//assign #(in_delay) TXSTARTSEQ0_delay = TXSTARTSEQ0_IN;
//assign #(in_delay) TXSTARTSEQ1_delay = TXSTARTSEQ1_IN;

   GTX_DUAL_FAST gtx_dual_fast_1 (
	.AC_CAP_DIS_0 (AC_CAP_DIS_0_BINARY),
	.AC_CAP_DIS_1 (AC_CAP_DIS_1_BINARY),
	.ALIGN_COMMA_WORD_0 (ALIGN_COMMA_WORD_0_BINARY),
	.ALIGN_COMMA_WORD_1 (ALIGN_COMMA_WORD_1_BINARY),
	.CB2_INH_CC_PERIOD_0 (CB2_INH_CC_PERIOD_0_BINARY),
	.CB2_INH_CC_PERIOD_1 (CB2_INH_CC_PERIOD_1_BINARY),
	.CDR_PH_ADJ_TIME (CDR_PH_ADJ_TIME),
	.CHAN_BOND_1_MAX_SKEW_0 (CHAN_BOND_1_MAX_SKEW_0_BINARY),
	.CHAN_BOND_1_MAX_SKEW_1 (CHAN_BOND_1_MAX_SKEW_1_BINARY),
	.CHAN_BOND_2_MAX_SKEW_0 (CHAN_BOND_2_MAX_SKEW_0_BINARY),
	.CHAN_BOND_2_MAX_SKEW_1 (CHAN_BOND_2_MAX_SKEW_1_BINARY),
	.CHAN_BOND_KEEP_ALIGN_0 (CHAN_BOND_KEEP_ALIGN_0_BINARY),
	.CHAN_BOND_KEEP_ALIGN_1 (CHAN_BOND_KEEP_ALIGN_1_BINARY),
	.CHAN_BOND_LEVEL_0 (CHAN_BOND_LEVEL_0_BINARY),
	.CHAN_BOND_LEVEL_1 (CHAN_BOND_LEVEL_1_BINARY),
	.CHAN_BOND_MODE_0 (CHAN_BOND_MODE_0_BINARY),
	.CHAN_BOND_MODE_1 (CHAN_BOND_MODE_1_BINARY),
	.CHAN_BOND_SEQ_1_1_0 (CHAN_BOND_SEQ_1_1_0),
	.CHAN_BOND_SEQ_1_1_1 (CHAN_BOND_SEQ_1_1_1),
	.CHAN_BOND_SEQ_1_2_0 (CHAN_BOND_SEQ_1_2_0),
	.CHAN_BOND_SEQ_1_2_1 (CHAN_BOND_SEQ_1_2_1),
	.CHAN_BOND_SEQ_1_3_0 (CHAN_BOND_SEQ_1_3_0),
	.CHAN_BOND_SEQ_1_3_1 (CHAN_BOND_SEQ_1_3_1),
	.CHAN_BOND_SEQ_1_4_0 (CHAN_BOND_SEQ_1_4_0),
	.CHAN_BOND_SEQ_1_4_1 (CHAN_BOND_SEQ_1_4_1),
	.CHAN_BOND_SEQ_1_ENABLE_0 (CHAN_BOND_SEQ_1_ENABLE_0),
	.CHAN_BOND_SEQ_1_ENABLE_1 (CHAN_BOND_SEQ_1_ENABLE_1),
	.CHAN_BOND_SEQ_2_1_0 (CHAN_BOND_SEQ_2_1_0),
	.CHAN_BOND_SEQ_2_1_1 (CHAN_BOND_SEQ_2_1_1),
	.CHAN_BOND_SEQ_2_2_0 (CHAN_BOND_SEQ_2_2_0),
	.CHAN_BOND_SEQ_2_2_1 (CHAN_BOND_SEQ_2_2_1),
	.CHAN_BOND_SEQ_2_3_0 (CHAN_BOND_SEQ_2_3_0),
	.CHAN_BOND_SEQ_2_3_1 (CHAN_BOND_SEQ_2_3_1),
	.CHAN_BOND_SEQ_2_4_0 (CHAN_BOND_SEQ_2_4_0),
	.CHAN_BOND_SEQ_2_4_1 (CHAN_BOND_SEQ_2_4_1),
	.CHAN_BOND_SEQ_2_ENABLE_0 (CHAN_BOND_SEQ_2_ENABLE_0),
	.CHAN_BOND_SEQ_2_ENABLE_1 (CHAN_BOND_SEQ_2_ENABLE_1),
	.CHAN_BOND_SEQ_2_USE_0 (CHAN_BOND_SEQ_2_USE_0_BINARY),
	.CHAN_BOND_SEQ_2_USE_1 (CHAN_BOND_SEQ_2_USE_1_BINARY),
	.CHAN_BOND_SEQ_LEN_0 (CHAN_BOND_SEQ_LEN_0_BINARY),
	.CHAN_BOND_SEQ_LEN_1 (CHAN_BOND_SEQ_LEN_1_BINARY),
	.CLK25_DIVIDER (CLK25_DIVIDER_BINARY),
	.CLKINDC_B (CLKINDC_B_BINARY),
	.CLKRCV_TRST (CLKRCV_TRST_BINARY),
	.CLK_CORRECT_USE_0 (CLK_CORRECT_USE_0_BINARY),
	.CLK_CORRECT_USE_1 (CLK_CORRECT_USE_1_BINARY),
	.CLK_COR_ADJ_LEN_0 (CLK_COR_ADJ_LEN_0_BINARY),
	.CLK_COR_ADJ_LEN_1 (CLK_COR_ADJ_LEN_1_BINARY),
	.CLK_COR_DET_LEN_0 (CLK_COR_DET_LEN_0_BINARY),
	.CLK_COR_DET_LEN_1 (CLK_COR_DET_LEN_1_BINARY),
	.CLK_COR_INSERT_IDLE_FLAG_0 (CLK_COR_INSERT_IDLE_FLAG_0_BINARY),
	.CLK_COR_INSERT_IDLE_FLAG_1 (CLK_COR_INSERT_IDLE_FLAG_1_BINARY),
	.CLK_COR_KEEP_IDLE_0 (CLK_COR_KEEP_IDLE_0_BINARY),
	.CLK_COR_KEEP_IDLE_1 (CLK_COR_KEEP_IDLE_1_BINARY),
	.CLK_COR_MAX_LAT_0 (CLK_COR_MAX_LAT_0_BINARY),
	.CLK_COR_MAX_LAT_1 (CLK_COR_MAX_LAT_1_BINARY),
	.CLK_COR_MIN_LAT_0 (CLK_COR_MIN_LAT_0_BINARY),
	.CLK_COR_MIN_LAT_1 (CLK_COR_MIN_LAT_1_BINARY),
	.CLK_COR_PRECEDENCE_0 (CLK_COR_PRECEDENCE_0_BINARY),
	.CLK_COR_PRECEDENCE_1 (CLK_COR_PRECEDENCE_1_BINARY),
	.CLK_COR_REPEAT_WAIT_0 (CLK_COR_REPEAT_WAIT_0_BINARY),
	.CLK_COR_REPEAT_WAIT_1 (CLK_COR_REPEAT_WAIT_1_BINARY),
	.CLK_COR_SEQ_1_1_0 (CLK_COR_SEQ_1_1_0),
	.CLK_COR_SEQ_1_1_1 (CLK_COR_SEQ_1_1_1),
	.CLK_COR_SEQ_1_2_0 (CLK_COR_SEQ_1_2_0),
	.CLK_COR_SEQ_1_2_1 (CLK_COR_SEQ_1_2_1),
	.CLK_COR_SEQ_1_3_0 (CLK_COR_SEQ_1_3_0),
	.CLK_COR_SEQ_1_3_1 (CLK_COR_SEQ_1_3_1),
	.CLK_COR_SEQ_1_4_0 (CLK_COR_SEQ_1_4_0),
	.CLK_COR_SEQ_1_4_1 (CLK_COR_SEQ_1_4_1),
	.CLK_COR_SEQ_1_ENABLE_0 (CLK_COR_SEQ_1_ENABLE_0),
	.CLK_COR_SEQ_1_ENABLE_1 (CLK_COR_SEQ_1_ENABLE_1),
	.CLK_COR_SEQ_2_1_0 (CLK_COR_SEQ_2_1_0),
	.CLK_COR_SEQ_2_1_1 (CLK_COR_SEQ_2_1_1),
	.CLK_COR_SEQ_2_2_0 (CLK_COR_SEQ_2_2_0),
	.CLK_COR_SEQ_2_2_1 (CLK_COR_SEQ_2_2_1),
	.CLK_COR_SEQ_2_3_0 (CLK_COR_SEQ_2_3_0),
	.CLK_COR_SEQ_2_3_1 (CLK_COR_SEQ_2_3_1),
	.CLK_COR_SEQ_2_4_0 (CLK_COR_SEQ_2_4_0),
	.CLK_COR_SEQ_2_4_1 (CLK_COR_SEQ_2_4_1),
	.CLK_COR_SEQ_2_ENABLE_0 (CLK_COR_SEQ_2_ENABLE_0),
	.CLK_COR_SEQ_2_ENABLE_1 (CLK_COR_SEQ_2_ENABLE_1),
	.CLK_COR_SEQ_2_USE_0 (CLK_COR_SEQ_2_USE_0_BINARY),
	.CLK_COR_SEQ_2_USE_1 (CLK_COR_SEQ_2_USE_1_BINARY),
	.CM_TRIM_0 (CM_TRIM_0),
	.CM_TRIM_1 (CM_TRIM_1),
	.COMMA_10B_ENABLE_0 (COMMA_10B_ENABLE_0),
	.COMMA_10B_ENABLE_1 (COMMA_10B_ENABLE_1),
	.COMMA_DOUBLE_0 (COMMA_DOUBLE_0_BINARY),
	.COMMA_DOUBLE_1 (COMMA_DOUBLE_1_BINARY),
	.COM_BURST_VAL_0 (COM_BURST_VAL_0),
	.COM_BURST_VAL_1 (COM_BURST_VAL_1),
	.DEC_MCOMMA_DETECT_0 (DEC_MCOMMA_DETECT_0_BINARY),
	.DEC_MCOMMA_DETECT_1 (DEC_MCOMMA_DETECT_1_BINARY),
	.DEC_PCOMMA_DETECT_0 (DEC_PCOMMA_DETECT_0_BINARY),
	.DEC_PCOMMA_DETECT_1 (DEC_PCOMMA_DETECT_1_BINARY),
	.DEC_VALID_COMMA_ONLY_0 (DEC_VALID_COMMA_ONLY_0_BINARY),
	.DEC_VALID_COMMA_ONLY_1 (DEC_VALID_COMMA_ONLY_1_BINARY),
	.DFE_CAL_TIME (DFE_CAL_TIME),
	.DFE_CFG_0 (DFE_CFG_0),
	.DFE_CFG_1 (DFE_CFG_1),
	.GEARBOX_ENDEC_0 (GEARBOX_ENDEC_0),
	.GEARBOX_ENDEC_1 (GEARBOX_ENDEC_1),
	.MCOMMA_10B_VALUE_0 (MCOMMA_10B_VALUE_0),
	.MCOMMA_10B_VALUE_1 (MCOMMA_10B_VALUE_1),
	.MCOMMA_DETECT_0 (MCOMMA_DETECT_0_BINARY),
	.MCOMMA_DETECT_1 (MCOMMA_DETECT_1_BINARY),
	.OOBDETECT_THRESHOLD_0 (OOBDETECT_THRESHOLD_0_BINARY),
	.OOBDETECT_THRESHOLD_1 (OOBDETECT_THRESHOLD_1_BINARY),
	.OOB_CLK_DIVIDER (OOB_CLK_DIVIDER_BINARY),
	.OVERSAMPLE_MODE (OVERSAMPLE_MODE_BINARY),
	.PCI_EXPRESS_MODE_0 (PCI_EXPRESS_MODE_0_BINARY),
	.PCI_EXPRESS_MODE_1 (PCI_EXPRESS_MODE_1_BINARY),
	.PCOMMA_10B_VALUE_0 (PCOMMA_10B_VALUE_0),
	.PCOMMA_10B_VALUE_1 (PCOMMA_10B_VALUE_1),
	.PCOMMA_DETECT_0 (PCOMMA_DETECT_0_BINARY),
	.PCOMMA_DETECT_1 (PCOMMA_DETECT_1_BINARY),
	.PLL_COM_CFG (PLL_COM_CFG),
	.PLL_CP_CFG (PLL_CP_CFG),		 
	.PLL_DIVSEL_FB (PLL_DIVSEL_FB_BINARY),
	.PLL_DIVSEL_REF (PLL_DIVSEL_REF_BINARY),
	.PLL_FB_DCCEN (PLL_FB_DCCEN_BINARY),
	.PLL_LKDET_CFG (PLL_LKDET_CFG),			 
	.PLL_RXDIVSEL_OUT_0 (PLL_RXDIVSEL_OUT_0_BINARY),
	.PLL_RXDIVSEL_OUT_1 (PLL_RXDIVSEL_OUT_1_BINARY),
	.PLL_SATA_0 (PLL_SATA_0_BINARY),
	.PLL_SATA_1 (PLL_SATA_1_BINARY),
	.PLL_TDCC_CFG (PLL_TDCC_CFG),			 
	.PLL_TXDIVSEL_OUT_0 (PLL_TXDIVSEL_OUT_0_BINARY),
	.PLL_TXDIVSEL_OUT_1 (PLL_TXDIVSEL_OUT_1_BINARY),
	.PMA_CDR_SCAN_0 (PMA_CDR_SCAN_0),
	.PMA_CDR_SCAN_1 (PMA_CDR_SCAN_1),
        .PMA_COM_CFG (PMA_COM_CFG),
	.PMA_RXSYNC_CFG_0 (PMA_RXSYNC_CFG_0),
	.PMA_RXSYNC_CFG_1 (PMA_RXSYNC_CFG_1),
	.PMA_RX_CFG_0 (PMA_RX_CFG_0),
	.PMA_RX_CFG_1 (PMA_RX_CFG_1),
	.PMA_TX_CFG_0 (PMA_TX_CFG_0),
	.PMA_TX_CFG_1 (PMA_TX_CFG_1),
	.PRBS_ERR_THRESHOLD_0 (PRBS_ERR_THRESHOLD_0),
	.PRBS_ERR_THRESHOLD_1 (PRBS_ERR_THRESHOLD_1),
	.RCV_TERM_GND_0 (RCV_TERM_GND_0_BINARY),
	.RCV_TERM_GND_1 (RCV_TERM_GND_1_BINARY),
	.RCV_TERM_VTTRX_0 (RCV_TERM_VTTRX_0_BINARY),
	.RCV_TERM_VTTRX_1 (RCV_TERM_VTTRX_1_BINARY),
	.RXGEARBOX_USE_0 (RXGEARBOX_USE_0_BINARY),
	.RXGEARBOX_USE_1 (RXGEARBOX_USE_1_BINARY),
	.RX_BUFFER_USE_0 (RX_BUFFER_USE_0_BINARY),
	.RX_BUFFER_USE_1 (RX_BUFFER_USE_1_BINARY),
	.RX_DECODE_SEQ_MATCH_0 (RX_DECODE_SEQ_MATCH_0_BINARY),
	.RX_DECODE_SEQ_MATCH_1 (RX_DECODE_SEQ_MATCH_1_BINARY),
	.RX_EN_IDLE_HOLD_CDR (RX_EN_IDLE_HOLD_CDR_BINARY),
	.RX_EN_IDLE_HOLD_DFE_0 (RX_EN_IDLE_HOLD_DFE_0_BINARY),
	.RX_EN_IDLE_HOLD_DFE_1 (RX_EN_IDLE_HOLD_DFE_1_BINARY),
	.RX_EN_IDLE_RESET_BUF_0 (RX_EN_IDLE_RESET_BUF_0_BINARY),
	.RX_EN_IDLE_RESET_BUF_1 (RX_EN_IDLE_RESET_BUF_1_BINARY),
	.RX_EN_IDLE_RESET_FR (RX_EN_IDLE_RESET_FR_BINARY),
	.RX_EN_IDLE_RESET_PH (RX_EN_IDLE_RESET_PH_BINARY),
	.RX_IDLE_HI_CNT_0 (RX_IDLE_HI_CNT_0),
	.RX_IDLE_HI_CNT_1 (RX_IDLE_HI_CNT_1),
	.RX_IDLE_LO_CNT_0 (RX_IDLE_LO_CNT_0),
	.RX_IDLE_LO_CNT_1 (RX_IDLE_LO_CNT_1),
	.RX_LOSS_OF_SYNC_FSM_0 (RX_LOSS_OF_SYNC_FSM_0_BINARY),
	.RX_LOSS_OF_SYNC_FSM_1 (RX_LOSS_OF_SYNC_FSM_1_BINARY),
	.RX_LOS_INVALID_INCR_0 (RX_LOS_INVALID_INCR_0_BINARY),
	.RX_LOS_INVALID_INCR_1 (RX_LOS_INVALID_INCR_1_BINARY),
	.RX_LOS_THRESHOLD_0 (RX_LOS_THRESHOLD_0_BINARY),
	.RX_LOS_THRESHOLD_1 (RX_LOS_THRESHOLD_1_BINARY),
	.RX_SLIDE_MODE_0 (RX_SLIDE_MODE_0_BINARY),
	.RX_SLIDE_MODE_1 (RX_SLIDE_MODE_1_BINARY),
	.RX_STATUS_FMT_0 (RX_STATUS_FMT_0_BINARY),
	.RX_STATUS_FMT_1 (RX_STATUS_FMT_1_BINARY),
	.RX_XCLK_SEL_0 (RX_XCLK_SEL_0_BINARY),
	.RX_XCLK_SEL_1 (RX_XCLK_SEL_1_BINARY),
	.SATA_BURST_VAL_0 (SATA_BURST_VAL_0),
	.SATA_BURST_VAL_1 (SATA_BURST_VAL_1),
	.SATA_IDLE_VAL_0 (SATA_IDLE_VAL_0),
	.SATA_IDLE_VAL_1 (SATA_IDLE_VAL_1),
	.SATA_MAX_BURST_0 (SATA_MAX_BURST_0_BINARY),
	.SATA_MAX_BURST_1 (SATA_MAX_BURST_1_BINARY),
	.SATA_MAX_INIT_0 (SATA_MAX_INIT_0_BINARY),
	.SATA_MAX_INIT_1 (SATA_MAX_INIT_1_BINARY),
	.SATA_MAX_WAKE_0 (SATA_MAX_WAKE_0_BINARY),
	.SATA_MAX_WAKE_1 (SATA_MAX_WAKE_1_BINARY),
	.SATA_MIN_BURST_0 (SATA_MIN_BURST_0_BINARY),
	.SATA_MIN_BURST_1 (SATA_MIN_BURST_1_BINARY),
	.SATA_MIN_INIT_0 (SATA_MIN_INIT_0_BINARY),
	.SATA_MIN_INIT_1 (SATA_MIN_INIT_1_BINARY),
	.SATA_MIN_WAKE_0 (SATA_MIN_WAKE_0_BINARY),
	.SATA_MIN_WAKE_1 (SATA_MIN_WAKE_1_BINARY),
	.SIM_GTXRESET_SPEEDUP (SIM_GTXRESET_SPEEDUP_BINARY),
	.SIM_PLL_PERDIV2 (SIM_PLL_PERDIV2),
	.SIM_RECEIVER_DETECT_PASS_0 (SIM_RECEIVER_DETECT_PASS_0_BINARY),
	.SIM_RECEIVER_DETECT_PASS_1 (SIM_RECEIVER_DETECT_PASS_1_BINARY),
	.STEPPING (1'b0),			 
	.TERMINATION_CTRL (TERMINATION_CTRL),
	.TERMINATION_IMP_0 (TERMINATION_IMP_0_BINARY),
	.TERMINATION_IMP_1 (TERMINATION_IMP_1_BINARY),
	.TERMINATION_OVRD (TERMINATION_OVRD_BINARY),
	.TRANS_TIME_FROM_P2_0 (TRANS_TIME_FROM_P2_0),
	.TRANS_TIME_FROM_P2_1 (TRANS_TIME_FROM_P2_1),
	.TRANS_TIME_NON_P2_0 (TRANS_TIME_NON_P2_0),
	.TRANS_TIME_NON_P2_1 (TRANS_TIME_NON_P2_1),
	.TRANS_TIME_TO_P2_0 (TRANS_TIME_TO_P2_0),
	.TRANS_TIME_TO_P2_1 (TRANS_TIME_TO_P2_1),
	.TXGEARBOX_USE_0 (TXGEARBOX_USE_0_BINARY),
	.TXGEARBOX_USE_1 (TXGEARBOX_USE_1_BINARY),
	.TXRX_INVERT_0 (TXRX_INVERT_0),
	.TXRX_INVERT_1 (TXRX_INVERT_1),
	.TX_BUFFER_USE_0 (TX_BUFFER_USE_0_BINARY),
	.TX_BUFFER_USE_1 (TX_BUFFER_USE_1_BINARY),
	.TX_DETECT_RX_CFG_0 (TX_DETECT_RX_CFG_0),
	.TX_DETECT_RX_CFG_1 (TX_DETECT_RX_CFG_1),		 
	.TX_IDLE_DELAY_0 (TX_IDLE_DELAY_0),
	.TX_IDLE_DELAY_1 (TX_IDLE_DELAY_1),
	.TX_XCLK_SEL_0 (TX_XCLK_SEL_0_BINARY),
	.TX_XCLK_SEL_1 (TX_XCLK_SEL_1_BINARY),

	.DFECLKDLYADJMONITOR0 (DFECLKDLYADJMONITOR0_delay),
	.DFECLKDLYADJMONITOR1 (DFECLKDLYADJMONITOR1_delay),
	.DFEEYEDACMONITOR0 (DFEEYEDACMONITOR0_delay),
	.DFEEYEDACMONITOR1 (DFEEYEDACMONITOR1_delay),
	.DFESENSCAL0 (DFESENSCAL0_delay),
	.DFESENSCAL1 (DFESENSCAL1_delay),
	.DFETAP1MONITOR0 (DFETAP1MONITOR0_delay),
	.DFETAP1MONITOR1 (DFETAP1MONITOR1_delay),
	.DFETAP2MONITOR0 (DFETAP2MONITOR0_delay),
	.DFETAP2MONITOR1 (DFETAP2MONITOR1_delay),
	.DFETAP3MONITOR0 (DFETAP3MONITOR0_delay),
	.DFETAP3MONITOR1 (DFETAP3MONITOR1_delay),
	.DFETAP4MONITOR0 (DFETAP4MONITOR0_delay),
	.DFETAP4MONITOR1 (DFETAP4MONITOR1_delay),
	.DO (DO_delay),
	.DRDY (DRDY_delay),
	.PHYSTATUS0 (PHYSTATUS0_delay),
	.PHYSTATUS1 (PHYSTATUS1_delay),
	.PLLLKDET (PLLLKDET_delay),
	.REFCLKOUT (REFCLKOUT_delay),
	.RESETDONE0 (RESETDONE0_delay),
	.RESETDONE1 (RESETDONE1_delay),
	.RXBUFSTATUS0 (RXBUFSTATUS0_delay),
	.RXBUFSTATUS1 (RXBUFSTATUS1_delay),
	.RXBYTEISALIGNED0 (RXBYTEISALIGNED0_delay),
	.RXBYTEISALIGNED1 (RXBYTEISALIGNED1_delay),
	.RXBYTEREALIGN0 (RXBYTEREALIGN0_delay),
	.RXBYTEREALIGN1 (RXBYTEREALIGN1_delay),
	.RXCHANBONDSEQ0 (RXCHANBONDSEQ0_delay),
	.RXCHANBONDSEQ1 (RXCHANBONDSEQ1_delay),
	.RXCHANISALIGNED0 (RXCHANISALIGNED0_delay),
	.RXCHANISALIGNED1 (RXCHANISALIGNED1_delay),
	.RXCHANREALIGN0 (RXCHANREALIGN0_delay),
	.RXCHANREALIGN1 (RXCHANREALIGN1_delay),
	.RXCHARISCOMMA0 (RXCHARISCOMMA0_delay),
	.RXCHARISCOMMA1 (RXCHARISCOMMA1_delay),
	.RXCHARISK0 (RXCHARISK0_delay),
	.RXCHARISK1 (RXCHARISK1_delay),
	.RXCHBONDO0 (RXCHBONDO0_delay),
	.RXCHBONDO1 (RXCHBONDO1_delay),
	.RXCLKCORCNT0 (RXCLKCORCNT0_delay),
	.RXCLKCORCNT1 (RXCLKCORCNT1_delay),
	.RXCOMMADET0 (RXCOMMADET0_delay),
	.RXCOMMADET1 (RXCOMMADET1_delay),
	.RXDATA0 (RXDATA0_delay),
	.RXDATA1 (RXDATA1_delay),
	.RXDATAVALID0 (RXDATAVALID0_delay),
	.RXDATAVALID1 (RXDATAVALID1_delay),
	.RXDISPERR0 (RXDISPERR0_delay),
	.RXDISPERR1 (RXDISPERR1_delay),
	.RXELECIDLE0 (RXELECIDLE0_delay),
	.RXELECIDLE1 (RXELECIDLE1_delay),
	.RXHEADER0 (RXHEADER0_delay),
	.RXHEADER1 (RXHEADER1_delay),
	.RXHEADERVALID0 (RXHEADERVALID0_delay),
	.RXHEADERVALID1 (RXHEADERVALID1_delay),
	.RXLOSSOFSYNC0 (RXLOSSOFSYNC0_delay),
	.RXLOSSOFSYNC1 (RXLOSSOFSYNC1_delay),
	.RXNOTINTABLE0 (RXNOTINTABLE0_delay),
	.RXNOTINTABLE1 (RXNOTINTABLE1_delay),
	.RXOVERSAMPLEERR0 (RXOVERSAMPLEERR0_delay),
	.RXOVERSAMPLEERR1 (RXOVERSAMPLEERR1_delay),
	.RXPRBSERR0 (RXPRBSERR0_delay),
	.RXPRBSERR1 (RXPRBSERR1_delay),
	.RXRECCLK0 (RXRECCLK0_delay),
	.RXRECCLK1 (RXRECCLK1_delay),
	.RXRUNDISP0 (RXRUNDISP0_delay),
	.RXRUNDISP1 (RXRUNDISP1_delay),
	.RXSTARTOFSEQ0 (RXSTARTOFSEQ0_delay),
	.RXSTARTOFSEQ1 (RXSTARTOFSEQ1_delay),
	.RXSTATUS0 (RXSTATUS0_delay),
	.RXSTATUS1 (RXSTATUS1_delay),
	.RXVALID0 (RXVALID0_delay),
	.RXVALID1 (RXVALID1_delay),
	.TXBUFSTATUS0 (TXBUFSTATUS0_delay),
	.TXBUFSTATUS1 (TXBUFSTATUS1_delay),
	.TXGEARBOXREADY0 (TXGEARBOXREADY0_delay),
	.TXGEARBOXREADY1 (TXGEARBOXREADY1_delay),
	.TXKERR0 (TXKERR0_delay),
	.TXKERR1 (TXKERR1_delay),
	.TXN0 (TXN0_delay),
	.TXN1 (TXN1_delay),
	.TXOUTCLK0 (TXOUTCLK0_delay),
	.TXOUTCLK1 (TXOUTCLK1_delay),
	.TXP0 (TXP0_delay),
	.TXP1 (TXP1_delay),
	.TXRUNDISP0 (TXRUNDISP0_delay),
	.TXRUNDISP1 (TXRUNDISP1_delay),

	.CLKIN (CLKIN_delay),
	.DADDR (DADDR_delay),
	.DCLK (DCLK_delay),
	.DEN (DEN_delay),
	.DFECLKDLYADJ0 (DFECLKDLYADJ0_delay),
	.DFECLKDLYADJ1 (DFECLKDLYADJ1_delay),
	.DFETAP10 (DFETAP10_delay),
	.DFETAP11 (DFETAP11_delay),
	.DFETAP20 (DFETAP20_delay),
	.DFETAP21 (DFETAP21_delay),
	.DFETAP30 (DFETAP30_delay),
	.DFETAP31 (DFETAP31_delay),
	.DFETAP40 (DFETAP40_delay),
	.DFETAP41 (DFETAP41_delay),
	.DI (DI_delay),
	.DWE (DWE_delay),
	.GTXRESET (GTXRESET_delay),
	.GTXTEST (GTXTEST_delay),
	.INTDATAWIDTH (INTDATAWIDTH_delay),
	.LOOPBACK0 (LOOPBACK0_delay),
	.LOOPBACK1 (LOOPBACK1_delay),
	.PLLLKDETEN (PLLLKDETEN_delay),
	.PLLPOWERDOWN (PLLPOWERDOWN_delay),
	.PRBSCNTRESET0 (PRBSCNTRESET0_delay),
	.PRBSCNTRESET1 (PRBSCNTRESET1_delay),
	.REFCLKPWRDNB (REFCLKPWRDNB_delay),
	.RXBUFRESET0 (RXBUFRESET0_delay),
	.RXBUFRESET1 (RXBUFRESET1_delay),
	.RXCDRRESET0 (RXCDRRESET0_delay),
	.RXCDRRESET1 (RXCDRRESET1_delay),
	.RXCHBONDI0 (RXCHBONDI0_delay),
	.RXCHBONDI1 (RXCHBONDI1_delay),
	.RXCOMMADETUSE0 (RXCOMMADETUSE0_delay),
	.RXCOMMADETUSE1 (RXCOMMADETUSE1_delay),
	.RXDATAWIDTH0 (RXDATAWIDTH0_delay),
	.RXDATAWIDTH1 (RXDATAWIDTH1_delay),
	.RXDEC8B10BUSE0 (RXDEC8B10BUSE0_delay),
	.RXDEC8B10BUSE1 (RXDEC8B10BUSE1_delay),
	.RXENCHANSYNC0 (RXENCHANSYNC0_delay),
	.RXENCHANSYNC1 (RXENCHANSYNC1_delay),
	.RXENEQB0 (RXENEQB0_delay),
	.RXENEQB1 (RXENEQB1_delay),
	.RXENMCOMMAALIGN0 (RXENMCOMMAALIGN0_delay),
	.RXENMCOMMAALIGN1 (RXENMCOMMAALIGN1_delay),
	.RXENPCOMMAALIGN0 (RXENPCOMMAALIGN0_delay),
	.RXENPCOMMAALIGN1 (RXENPCOMMAALIGN1_delay),
	.RXENPMAPHASEALIGN0 (RXENPMAPHASEALIGN0_delay),
	.RXENPMAPHASEALIGN1 (RXENPMAPHASEALIGN1_delay),
	.RXENPRBSTST0 (RXENPRBSTST0_delay),
	.RXENPRBSTST1 (RXENPRBSTST1_delay),
	.RXENSAMPLEALIGN0 (RXENSAMPLEALIGN0_delay),
	.RXENSAMPLEALIGN1 (RXENSAMPLEALIGN1_delay),
	.RXEQMIX0 (RXEQMIX0_delay),
	.RXEQMIX1 (RXEQMIX1_delay),
	.RXEQPOLE0 (RXEQPOLE0_delay),
	.RXEQPOLE1 (RXEQPOLE1_delay),
	.RXGEARBOXSLIP0 (RXGEARBOXSLIP0_delay),
	.RXGEARBOXSLIP1 (RXGEARBOXSLIP1_delay),
	.RXN0 (RXN0_delay),
	.RXN1 (RXN1_delay),
	.RXP0 (RXP0_delay),
	.RXP1 (RXP1_delay),
	.RXPMASETPHASE0 (RXPMASETPHASE0_delay),
	.RXPMASETPHASE1 (RXPMASETPHASE1_delay),
	.RXPOLARITY0 (RXPOLARITY0_delay),
	.RXPOLARITY1 (RXPOLARITY1_delay),
	.RXPOWERDOWN0 (RXPOWERDOWN0_delay),
	.RXPOWERDOWN1 (RXPOWERDOWN1_delay),
	.RXRESET0 (RXRESET0_delay),
	.RXRESET1 (RXRESET1_delay),
	.RXSLIDE0 (RXSLIDE0_delay),
	.RXSLIDE1 (RXSLIDE1_delay),
	.RXUSRCLK0 (RXUSRCLK0_delay),
	.RXUSRCLK1 (RXUSRCLK1_delay),
	.RXUSRCLK20 (RXUSRCLK20_delay),
	.RXUSRCLK21 (RXUSRCLK21_delay),
	.TXBUFDIFFCTRL0 (TXBUFDIFFCTRL0_delay),
	.TXBUFDIFFCTRL1 (TXBUFDIFFCTRL1_delay),
	.TXBYPASS8B10B0 (TXBYPASS8B10B0_delay),
	.TXBYPASS8B10B1 (TXBYPASS8B10B1_delay),
	.TXCHARDISPMODE0 (TXCHARDISPMODE0_delay),
	.TXCHARDISPMODE1 (TXCHARDISPMODE1_delay),
	.TXCHARDISPVAL0 (TXCHARDISPVAL0_delay),
	.TXCHARDISPVAL1 (TXCHARDISPVAL1_delay),
	.TXCHARISK0 (TXCHARISK0_delay),
	.TXCHARISK1 (TXCHARISK1_delay),
	.TXCOMSTART0 (TXCOMSTART0_delay),
	.TXCOMSTART1 (TXCOMSTART1_delay),
	.TXCOMTYPE0 (TXCOMTYPE0_delay),
	.TXCOMTYPE1 (TXCOMTYPE1_delay),
	.TXDATA0 (TXDATA0_delay),
	.TXDATA1 (TXDATA1_delay),
	.TXDATAWIDTH0 (TXDATAWIDTH0_delay),
	.TXDATAWIDTH1 (TXDATAWIDTH1_delay),
	.TXDETECTRX0 (TXDETECTRX0_delay),
	.TXDETECTRX1 (TXDETECTRX1_delay),
	.TXDIFFCTRL0 (TXDIFFCTRL0_delay),
	.TXDIFFCTRL1 (TXDIFFCTRL1_delay),
	.TXELECIDLE0 (TXELECIDLE0_delay),
	.TXELECIDLE1 (TXELECIDLE1_delay),
	.TXENC8B10BUSE0 (TXENC8B10BUSE0_delay),
	.TXENC8B10BUSE1 (TXENC8B10BUSE1_delay),
	.TXENPMAPHASEALIGN0 (TXENPMAPHASEALIGN0_delay),
	.TXENPMAPHASEALIGN1 (TXENPMAPHASEALIGN1_delay),
	.TXENPRBSTST0 (TXENPRBSTST0_delay),
	.TXENPRBSTST1 (TXENPRBSTST1_delay),
	.TXHEADER0 (TXHEADER0_delay),
	.TXHEADER1 (TXHEADER1_delay),
	.TXINHIBIT0 (TXINHIBIT0_delay),
	.TXINHIBIT1 (TXINHIBIT1_delay),
	.TXPMASETPHASE0 (TXPMASETPHASE0_delay),
	.TXPMASETPHASE1 (TXPMASETPHASE1_delay),
	.TXPOLARITY0 (TXPOLARITY0_delay),
	.TXPOLARITY1 (TXPOLARITY1_delay),
	.TXPOWERDOWN0 (TXPOWERDOWN0_delay),
	.TXPOWERDOWN1 (TXPOWERDOWN1_delay),
	.TXPREEMPHASIS0 (TXPREEMPHASIS0_delay),
	.TXPREEMPHASIS1 (TXPREEMPHASIS1_delay),
	.TXRESET0 (TXRESET0_delay),
	.TXRESET1 (TXRESET1_delay),
	.TXSEQUENCE0 (TXSEQUENCE0_delay),
	.TXSEQUENCE1 (TXSEQUENCE1_delay),
	.TXSTARTSEQ0 (TXSTARTSEQ0_delay),
	.TXSTARTSEQ1 (TXSTARTSEQ1_delay),
	.TXUSRCLK0 (TXUSRCLK0_delay),
	.TXUSRCLK1 (TXUSRCLK1_delay),
	.TXUSRCLK20 (TXUSRCLK20_delay),
	.TXUSRCLK21 (TXUSRCLK21_delay),
        .GSR(GSR)
      );

specify
	$setuphold (posedge DCLK, negedge DADDR[0], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DADDR_delay[0]);
	$setuphold (posedge DCLK, negedge DADDR[1], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DADDR_delay[1]);
	$setuphold (posedge DCLK, negedge DADDR[2], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DADDR_delay[2]);
	$setuphold (posedge DCLK, negedge DADDR[3], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DADDR_delay[3]);
	$setuphold (posedge DCLK, negedge DADDR[4], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DADDR_delay[4]);
	$setuphold (posedge DCLK, negedge DADDR[5], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DADDR_delay[5]);
	$setuphold (posedge DCLK, negedge DADDR[6], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DADDR_delay[6]);
	$setuphold (posedge DCLK, negedge DEN, 0:0:0, 0:0:0, notifier,,,DCLK_delay,DEN_delay);
	$setuphold (posedge DCLK, negedge DI[0], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[0]);
	$setuphold (posedge DCLK, negedge DI[10], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[10]);
	$setuphold (posedge DCLK, negedge DI[11], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[11]);
	$setuphold (posedge DCLK, negedge DI[12], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[12]);
	$setuphold (posedge DCLK, negedge DI[13], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[13]);
	$setuphold (posedge DCLK, negedge DI[14], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[14]);
	$setuphold (posedge DCLK, negedge DI[15], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[15]);
	$setuphold (posedge DCLK, negedge DI[1], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[1]);
	$setuphold (posedge DCLK, negedge DI[2], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[2]);
	$setuphold (posedge DCLK, negedge DI[3], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[3]);
	$setuphold (posedge DCLK, negedge DI[4], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[4]);
	$setuphold (posedge DCLK, negedge DI[5], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[5]);
	$setuphold (posedge DCLK, negedge DI[6], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[6]);
	$setuphold (posedge DCLK, negedge DI[7], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[7]);
	$setuphold (posedge DCLK, negedge DI[8], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[8]);
	$setuphold (posedge DCLK, negedge DI[9], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[9]);
	$setuphold (posedge DCLK, negedge DWE, 0:0:0, 0:0:0, notifier,,,DCLK_delay,DWE_delay);
	$setuphold (posedge DCLK, posedge DADDR[0], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DADDR_delay[0]);
	$setuphold (posedge DCLK, posedge DADDR[1], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DADDR_delay[1]);
	$setuphold (posedge DCLK, posedge DADDR[2], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DADDR_delay[2]);
	$setuphold (posedge DCLK, posedge DADDR[3], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DADDR_delay[3]);
	$setuphold (posedge DCLK, posedge DADDR[4], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DADDR_delay[4]);
	$setuphold (posedge DCLK, posedge DADDR[5], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DADDR_delay[5]);
	$setuphold (posedge DCLK, posedge DADDR[6], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DADDR_delay[6]);
	$setuphold (posedge DCLK, posedge DEN, 0:0:0, 0:0:0, notifier,,,DCLK_delay,DEN_delay);
	$setuphold (posedge DCLK, posedge DI[0], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[0]);
	$setuphold (posedge DCLK, posedge DI[10], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[10]);
	$setuphold (posedge DCLK, posedge DI[11], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[11]);
	$setuphold (posedge DCLK, posedge DI[12], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[12]);
	$setuphold (posedge DCLK, posedge DI[13], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[13]);
	$setuphold (posedge DCLK, posedge DI[14], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[14]);
	$setuphold (posedge DCLK, posedge DI[15], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[15]);
	$setuphold (posedge DCLK, posedge DI[1], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[1]);
	$setuphold (posedge DCLK, posedge DI[2], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[2]);
	$setuphold (posedge DCLK, posedge DI[3], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[3]);
	$setuphold (posedge DCLK, posedge DI[4], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[4]);
	$setuphold (posedge DCLK, posedge DI[5], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[5]);
	$setuphold (posedge DCLK, posedge DI[6], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[6]);
	$setuphold (posedge DCLK, posedge DI[7], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[7]);
	$setuphold (posedge DCLK, posedge DI[8], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[8]);
	$setuphold (posedge DCLK, posedge DI[9], 0:0:0, 0:0:0, notifier,,,DCLK_delay,DI_delay[9]);
	$setuphold (posedge DCLK, posedge DWE, 0:0:0, 0:0:0, notifier,,,DCLK_delay,DWE_delay);
	$setuphold (posedge RXUSRCLK0, negedge RXCHBONDI0[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK0_delay,RXCHBONDI0_delay[0]);
	$setuphold (posedge RXUSRCLK0, negedge RXCHBONDI0[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK0_delay,RXCHBONDI0_delay[1]);
	$setuphold (posedge RXUSRCLK0, negedge RXCHBONDI0[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK0_delay,RXCHBONDI0_delay[2]);
	$setuphold (posedge RXUSRCLK0, negedge RXCHBONDI0[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK0_delay,RXCHBONDI0_delay[3]);
   $setuphold (posedge RXUSRCLK0, posedge RXCHBONDI0[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK0_delay,RXCHBONDI0_delay[0]);
	$setuphold (posedge RXUSRCLK0, posedge RXCHBONDI0[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK0_delay,RXCHBONDI0_delay[1]);
	$setuphold (posedge RXUSRCLK0, posedge RXCHBONDI0[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK0_delay,RXCHBONDI0_delay[2]);
	$setuphold (posedge RXUSRCLK0, posedge RXCHBONDI0[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK0_delay,RXCHBONDI0_delay[3]);
	$setuphold (posedge RXUSRCLK1, negedge RXCHBONDI1[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK1_delay,RXCHBONDI1_delay[0]);
	$setuphold (posedge RXUSRCLK1, negedge RXCHBONDI1[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK1_delay,RXCHBONDI1_delay[1]);
	$setuphold (posedge RXUSRCLK1, negedge RXCHBONDI1[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK1_delay,RXCHBONDI1_delay[2]);
	$setuphold (posedge RXUSRCLK1, negedge RXCHBONDI1[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK1_delay,RXCHBONDI1_delay[3]);
   $setuphold (posedge RXUSRCLK1, posedge RXCHBONDI1[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK1_delay,RXCHBONDI1_delay[0]);
	$setuphold (posedge RXUSRCLK1, posedge RXCHBONDI1[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK1_delay,RXCHBONDI1_delay[1]);
	$setuphold (posedge RXUSRCLK1, posedge RXCHBONDI1[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK1_delay,RXCHBONDI1_delay[2]);
	$setuphold (posedge RXUSRCLK1, posedge RXCHBONDI1[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK1_delay,RXCHBONDI1_delay[3]);
	$setuphold (posedge RXUSRCLK20, negedge PRBSCNTRESET0, 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,PRBSCNTRESET0_delay);
	$setuphold (posedge RXUSRCLK20, negedge RXCOMMADETUSE0, 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,RXCOMMADETUSE0_delay);
	$setuphold (posedge RXUSRCLK20, negedge RXDEC8B10BUSE0, 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,RXDEC8B10BUSE0_delay);
	$setuphold (posedge RXUSRCLK20, negedge RXENCHANSYNC0, 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,RXENCHANSYNC0_delay);
	$setuphold (posedge RXUSRCLK20, negedge RXENMCOMMAALIGN0, 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,RXENMCOMMAALIGN0_delay);
	$setuphold (posedge RXUSRCLK20, negedge RXENPCOMMAALIGN0, 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,RXENPCOMMAALIGN0_delay);
	$setuphold (posedge RXUSRCLK20, negedge RXENPRBSTST0[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,RXENPRBSTST0_delay[0]);
	$setuphold (posedge RXUSRCLK20, negedge RXENPRBSTST0[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,RXENPRBSTST0_delay[1]);
	$setuphold (posedge RXUSRCLK20, negedge RXGEARBOXSLIP0, 0:0:0, 0:0:0);
	$setuphold (posedge RXUSRCLK20, negedge RXPOLARITY0, 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,RXPOLARITY0_delay);
	$setuphold (posedge RXUSRCLK20, negedge RXSLIDE0, 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,RXSLIDE0_delay);
	$setuphold (posedge RXUSRCLK20, posedge PRBSCNTRESET0, 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,PRBSCNTRESET0_delay);
	$setuphold (posedge RXUSRCLK20, posedge RXCOMMADETUSE0, 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,RXCOMMADETUSE0_delay);
	$setuphold (posedge RXUSRCLK20, posedge RXDEC8B10BUSE0, 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,RXDEC8B10BUSE0_delay);
	$setuphold (posedge RXUSRCLK20, posedge RXENCHANSYNC0, 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,RXENCHANSYNC0_delay);
	$setuphold (posedge RXUSRCLK20, posedge RXENMCOMMAALIGN0, 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,RXENMCOMMAALIGN0_delay);
	$setuphold (posedge RXUSRCLK20, posedge RXENPCOMMAALIGN0, 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,RXENPCOMMAALIGN0_delay);
	$setuphold (posedge RXUSRCLK20, posedge RXENPRBSTST0[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,RXENPRBSTST0_delay[0]);
	$setuphold (posedge RXUSRCLK20, posedge RXENPRBSTST0[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,RXENPRBSTST0_delay[1]);
	$setuphold (posedge RXUSRCLK20, posedge RXGEARBOXSLIP0, 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,RXGEARBOXSLIP0_delay);
	$setuphold (posedge RXUSRCLK20, posedge RXPOLARITY0, 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,RXPOLARITY0_delay);
	$setuphold (posedge RXUSRCLK20, posedge RXSLIDE0, 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,RXSLIDE0_delay);

	//Added in K.35
  	$setuphold (posedge RXUSRCLK20, negedge DFECLKDLYADJ0[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFECLKDLYADJ0_delay[0]);
 	$setuphold (posedge RXUSRCLK20, negedge DFECLKDLYADJ0[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFECLKDLYADJ0_delay[1]);
 	$setuphold (posedge RXUSRCLK20, negedge DFECLKDLYADJ0[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFECLKDLYADJ0_delay[2]);
 	$setuphold (posedge RXUSRCLK20, negedge DFECLKDLYADJ0[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFECLKDLYADJ0_delay[3]);
 	$setuphold (posedge RXUSRCLK20, negedge DFECLKDLYADJ0[4], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFECLKDLYADJ0_delay[4]);
 	$setuphold (posedge RXUSRCLK20, negedge DFECLKDLYADJ0[5], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFECLKDLYADJ0_delay[5]);
 	$setuphold (posedge RXUSRCLK20, negedge DFETAP10[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP10_delay[0]);
 	$setuphold (posedge RXUSRCLK20, negedge DFETAP10[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP10_delay[1]);
 	$setuphold (posedge RXUSRCLK20, negedge DFETAP10[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP10_delay[2]);
 	$setuphold (posedge RXUSRCLK20, negedge DFETAP10[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP10_delay[3]);
 	$setuphold (posedge RXUSRCLK20, negedge DFETAP10[4], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP10_delay[4]);
 	$setuphold (posedge RXUSRCLK20, negedge DFETAP20[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP20_delay[0]);
 	$setuphold (posedge RXUSRCLK20, negedge DFETAP20[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP20_delay[1]);
 	$setuphold (posedge RXUSRCLK20, negedge DFETAP20[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP20_delay[2]);
 	$setuphold (posedge RXUSRCLK20, negedge DFETAP20[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP20_delay[3]);
 	$setuphold (posedge RXUSRCLK20, negedge DFETAP20[4], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP20_delay[4]);
 	$setuphold (posedge RXUSRCLK20, negedge DFETAP30[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP30_delay[0]);
 	$setuphold (posedge RXUSRCLK20, negedge DFETAP30[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP30_delay[1]);
 	$setuphold (posedge RXUSRCLK20, negedge DFETAP30[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP30_delay[2]);
 	$setuphold (posedge RXUSRCLK20, negedge DFETAP30[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP30_delay[3]);
 	$setuphold (posedge RXUSRCLK20, negedge DFETAP40[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP40_delay[0]);
 	$setuphold (posedge RXUSRCLK20, negedge DFETAP40[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP40_delay[1]);
 	$setuphold (posedge RXUSRCLK20, negedge DFETAP40[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP40_delay[2]);
 	$setuphold (posedge RXUSRCLK20, negedge DFETAP40[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP40_delay[3]);



//Added in K.35
 	$setuphold (posedge RXUSRCLK20, posedge DFECLKDLYADJ0[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFECLKDLYADJ0_delay[0]);
 	$setuphold (posedge RXUSRCLK20, posedge DFECLKDLYADJ0[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFECLKDLYADJ0_delay[1]);
 	$setuphold (posedge RXUSRCLK20, posedge DFECLKDLYADJ0[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFECLKDLYADJ0_delay[2]);
 	$setuphold (posedge RXUSRCLK20, posedge DFECLKDLYADJ0[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFECLKDLYADJ0_delay[3]);
 	$setuphold (posedge RXUSRCLK20, posedge DFECLKDLYADJ0[4], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFECLKDLYADJ0_delay[4]);
 	$setuphold (posedge RXUSRCLK20, posedge DFECLKDLYADJ0[5], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFECLKDLYADJ0_delay[5]);
 	$setuphold (posedge RXUSRCLK20, posedge DFETAP10[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP10_delay[0]);
 	$setuphold (posedge RXUSRCLK20, posedge DFETAP10[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP10_delay[1]);
 	$setuphold (posedge RXUSRCLK20, posedge DFETAP10[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP10_delay[2]);
 	$setuphold (posedge RXUSRCLK20, posedge DFETAP10[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP10_delay[3]);
 	$setuphold (posedge RXUSRCLK20, posedge DFETAP10[4], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP10_delay[4]);
 	$setuphold (posedge RXUSRCLK20, posedge DFETAP20[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP20_delay[0]);
 	$setuphold (posedge RXUSRCLK20, posedge DFETAP20[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP20_delay[1]);
 	$setuphold (posedge RXUSRCLK20, posedge DFETAP20[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP20_delay[2]);
 	$setuphold (posedge RXUSRCLK20, posedge DFETAP20[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP20_delay[3]);
 	$setuphold (posedge RXUSRCLK20, posedge DFETAP20[4], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP20_delay[4]);
 	$setuphold (posedge RXUSRCLK20, posedge DFETAP30[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP30_delay[0]);
 	$setuphold (posedge RXUSRCLK20, posedge DFETAP30[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP30_delay[1]);
 	$setuphold (posedge RXUSRCLK20, posedge DFETAP30[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP30_delay[2]);
 	$setuphold (posedge RXUSRCLK20, posedge DFETAP30[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP30_delay[3]);
 	$setuphold (posedge RXUSRCLK20, posedge DFETAP40[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP40_delay[0]);
 	$setuphold (posedge RXUSRCLK20, posedge DFETAP40[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP40_delay[1]);
 	$setuphold (posedge RXUSRCLK20, posedge DFETAP40[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP40_delay[2]);
 	$setuphold (posedge RXUSRCLK20, posedge DFETAP40[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,DFETAP40_delay[3]);
 	$setuphold (posedge RXUSRCLK20, negedge RXENSAMPLEALIGN0, 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,RXENSAMPLEALIGN0_delay);
 	$setuphold (posedge RXUSRCLK20, posedge RXENSAMPLEALIGN0, 0:0:0, 0:0:0, notifier,,,RXUSRCLK20_delay,RXENSAMPLEALIGN0_delay);
 	$setuphold (posedge RXUSRCLK21, negedge RXENSAMPLEALIGN1, 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,RXENSAMPLEALIGN1_delay);
 	$setuphold (posedge RXUSRCLK21, posedge RXENSAMPLEALIGN1, 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,RXENSAMPLEALIGN1_delay);

// $setuphold (posedge RXUSRCLK21, negedge DFECLKDLYADJ0[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFECLKDLYADJ0_delay[0]);
//	$setuphold (posedge RXUSRCLK21, negedge DFECLKDLYADJ0[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFECLKDLYADJ0_delay[1]);
//	$setuphold (posedge RXUSRCLK21, negedge DFECLKDLYADJ0[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFECLKDLYADJ0_delay[2]);
//	$setuphold (posedge RXUSRCLK21, negedge DFECLKDLYADJ0[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFECLKDLYADJ0_delay[3]);
//	$setuphold (posedge RXUSRCLK21, negedge DFECLKDLYADJ0[4], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFECLKDLYADJ0_delay[4]);
//	$setuphold (posedge RXUSRCLK21, negedge DFECLKDLYADJ0[5], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFECLKDLYADJ0_delay[5]);
	$setuphold (posedge RXUSRCLK21, negedge DFECLKDLYADJ1[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFECLKDLYADJ1_delay[0]);
	$setuphold (posedge RXUSRCLK21, negedge DFECLKDLYADJ1[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFECLKDLYADJ1_delay[1]);
	$setuphold (posedge RXUSRCLK21, negedge DFECLKDLYADJ1[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFECLKDLYADJ1_delay[2]);
	$setuphold (posedge RXUSRCLK21, negedge DFECLKDLYADJ1[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFECLKDLYADJ1_delay[3]);
	$setuphold (posedge RXUSRCLK21, negedge DFECLKDLYADJ1[4], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFECLKDLYADJ1_delay[4]);
	$setuphold (posedge RXUSRCLK21, negedge DFECLKDLYADJ1[5], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFECLKDLYADJ1_delay[5]);
//	$setuphold (posedge RXUSRCLK21, negedge DFETAP10[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP10_delay[0]);
//	$setuphold (posedge RXUSRCLK21, negedge DFETAP10[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP10_delay[1]);
//	$setuphold (posedge RXUSRCLK21, negedge DFETAP10[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP10_delay[2]);
//	$setuphold (posedge RXUSRCLK21, negedge DFETAP10[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP10_delay[3]);
	$setuphold (posedge RXUSRCLK21, negedge DFETAP10[4], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP10_delay[4]);
	$setuphold (posedge RXUSRCLK21, negedge DFETAP11[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP11_delay[0]);
	$setuphold (posedge RXUSRCLK21, negedge DFETAP11[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP11_delay[1]);
	$setuphold (posedge RXUSRCLK21, negedge DFETAP11[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP11_delay[2]);
	$setuphold (posedge RXUSRCLK21, negedge DFETAP11[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP11_delay[3]);
	$setuphold (posedge RXUSRCLK21, negedge DFETAP11[4], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP11_delay[4]);
//	$setuphold (posedge RXUSRCLK21, negedge DFETAP20[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP20_delay[0]);
// $setuphold (posedge RXUSRCLK21, negedge DFETAP20[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP20_delay[1]);
//	$setuphold (posedge RXUSRCLK21, negedge DFETAP20[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP20_delay[2]);
//	$setuphold (posedge RXUSRCLK21, negedge DFETAP20[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP20_delay[3]);
//	$setuphold (posedge RXUSRCLK21, negedge DFETAP20[4], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP20_delay[4]);
	$setuphold (posedge RXUSRCLK21, negedge DFETAP21[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP21_delay[0]);
	$setuphold (posedge RXUSRCLK21, negedge DFETAP21[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP21_delay[1]);
	$setuphold (posedge RXUSRCLK21, negedge DFETAP21[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP21_delay[2]);
	$setuphold (posedge RXUSRCLK21, negedge DFETAP21[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP21_delay[3]);
	$setuphold (posedge RXUSRCLK21, negedge DFETAP21[4], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP21_delay[4]);
//	$setuphold (posedge RXUSRCLK21, negedge DFETAP30[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP30_delay[0]);
//	$setuphold (posedge RXUSRCLK21, negedge DFETAP30[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP30_delay[1]);
//	$setuphold (posedge RXUSRCLK21, negedge DFETAP30[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP30_delay[2]);
//	$setuphold (posedge RXUSRCLK21, negedge DFETAP30[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP30_delay[3]);
	$setuphold (posedge RXUSRCLK21, negedge DFETAP31[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP31_delay[0]);
	$setuphold (posedge RXUSRCLK21, negedge DFETAP31[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP31_delay[1]);
	$setuphold (posedge RXUSRCLK21, negedge DFETAP31[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP31_delay[2]);
	$setuphold (posedge RXUSRCLK21, negedge DFETAP31[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP31_delay[3]);
//	$setuphold (posedge RXUSRCLK21, negedge DFETAP40[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP40_delay[0]);
//	$setuphold (posedge RXUSRCLK21, negedge DFETAP40[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP40_delay[1]);
//	$setuphold (posedge RXUSRCLK21, negedge DFETAP40[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP40_delay[2]);
//	$setuphold (posedge RXUSRCLK21, negedge DFETAP40[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP40_delay[3]);
	$setuphold (posedge RXUSRCLK21, negedge DFETAP41[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP41_delay[0]);
	$setuphold (posedge RXUSRCLK21, negedge DFETAP41[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP41_delay[1]);
	$setuphold (posedge RXUSRCLK21, negedge DFETAP41[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP41_delay[2]);
	$setuphold (posedge RXUSRCLK21, negedge DFETAP41[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP41_delay[3]);
	$setuphold (posedge RXUSRCLK21, negedge PRBSCNTRESET1, 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,PRBSCNTRESET1_delay);
	$setuphold (posedge RXUSRCLK21, negedge RXCOMMADETUSE1, 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,RXCOMMADETUSE1_delay);
	$setuphold (posedge RXUSRCLK21, negedge RXDEC8B10BUSE1, 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,RXDEC8B10BUSE1_delay);
	$setuphold (posedge RXUSRCLK21, negedge RXENCHANSYNC1, 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay, RXENCHANSYNC1_delay);
	$setuphold (posedge RXUSRCLK21, negedge RXENMCOMMAALIGN1, 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay, RXENMCOMMAALIGN1_delay);
	$setuphold (posedge RXUSRCLK21, negedge RXENPCOMMAALIGN1, 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay, RXENPCOMMAALIGN1_delay);
	$setuphold (posedge RXUSRCLK21, negedge RXENPRBSTST1[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay, RXENPRBSTST1_delay[0]);
	$setuphold (posedge RXUSRCLK21, negedge RXENPRBSTST1[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,  RXENPRBSTST1_delay[1]);
	$setuphold (posedge RXUSRCLK21, negedge RXGEARBOXSLIP1, 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay, RXGEARBOXSLIP1_delay);
	$setuphold (posedge RXUSRCLK21, negedge RXPOLARITY1, 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay, RXPOLARITY1_delay);
	$setuphold (posedge RXUSRCLK21, negedge RXSLIDE1, 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,RXSLIDE1_delay);
//	$setuphold (posedge RXUSRCLK21, negedge TXHEADER1[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,TXHEADER1_delay[0]);
//	$setuphold (posedge RXUSRCLK21, negedge TXHEADER1[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,TXHEADER1_delay[1]);
//	$setuphold (posedge RXUSRCLK21, negedge TXHEADER1[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,TXHEADER1_delay[2]);
//	$setuphold (posedge RXUSRCLK21, negedge TXSEQUENCE1[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,TXSEQUENCE1_delay[0]);
//	$setuphold (posedge RXUSRCLK21, negedge TXSEQUENCE1[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,TXSEQUENCE1_delay[1]);
//	$setuphold (posedge RXUSRCLK21, negedge TXSEQUENCE1[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,TXSEQUENCE1_delay[2]);
//	$setuphold (posedge RXUSRCLK21, negedge TXSEQUENCE1[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,TXSEQUENCE1_delay[3]);
//	$setuphold (posedge RXUSRCLK21, negedge TXSEQUENCE1[4], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,TXSEQUENCE1_delay[4]);
//	$setuphold (posedge RXUSRCLK21, negedge TXSEQUENCE1[5], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,TXSEQUENCE1_delay[5]);
//	$setuphold (posedge RXUSRCLK21, negedge TXSEQUENCE1[6], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,TXSEQUENCE1_delay[6]);
//	$setuphold (posedge RXUSRCLK21, negedge TXSTARTSEQ1, 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,TXSTARTSEQ1_delay);
//	$setuphold (posedge RXUSRCLK21, posedge DFECLKDLYADJ0[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFECLKDLYADJ0_delay[0]);
//	$setuphold (posedge RXUSRCLK21, posedge DFECLKDLYADJ0[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFECLKDLYADJ0_delay[1]);
//	$setuphold (posedge RXUSRCLK21, posedge DFECLKDLYADJ0[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFECLKDLYADJ0_delay[2]);
//	$setuphold (posedge RXUSRCLK21, posedge DFECLKDLYADJ0[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFECLKDLYADJ0_delay[3]);
//	$setuphold (posedge RXUSRCLK21, posedge DFECLKDLYADJ0[4], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFECLKDLYADJ0_delay[4]);
//	$setuphold (posedge RXUSRCLK21, posedge DFECLKDLYADJ0[5], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFECLKDLYADJ0_delay[5]);
	$setuphold (posedge RXUSRCLK21, posedge DFECLKDLYADJ1[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFECLKDLYADJ1_delay[0]);
	$setuphold (posedge RXUSRCLK21, posedge DFECLKDLYADJ1[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFECLKDLYADJ1_delay[1]);
	$setuphold (posedge RXUSRCLK21, posedge DFECLKDLYADJ1[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFECLKDLYADJ1_delay[2]);
	$setuphold (posedge RXUSRCLK21, posedge DFECLKDLYADJ1[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFECLKDLYADJ1_delay[3]);
	$setuphold (posedge RXUSRCLK21, posedge DFECLKDLYADJ1[4], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFECLKDLYADJ1_delay[4]);
	$setuphold (posedge RXUSRCLK21, posedge DFECLKDLYADJ1[5], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFECLKDLYADJ1_delay[5]);
//	$setuphold (posedge RXUSRCLK21, posedge DFETAP10[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP10_delay[0]);
//	$setuphold (posedge RXUSRCLK21, posedge DFETAP10[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP10_delay[1]);
//	$setuphold (posedge RXUSRCLK21, posedge DFETAP10[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP10_delay[2]);
//	$setuphold (posedge RXUSRCLK21, posedge DFETAP10[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP10_delay[3]);
//	$setuphold (posedge RXUSRCLK21, posedge DFETAP10[4], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP10_delay[4]);
	$setuphold (posedge RXUSRCLK21, posedge DFETAP11[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP11_delay[0]);
	$setuphold (posedge RXUSRCLK21, posedge DFETAP11[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP11_delay[1]);
	$setuphold (posedge RXUSRCLK21, posedge DFETAP11[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP11_delay[2]);
	$setuphold (posedge RXUSRCLK21, posedge DFETAP11[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP11_delay[3]);
	$setuphold (posedge RXUSRCLK21, posedge DFETAP11[4], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP11_delay[4]);
//	$setuphold (posedge RXUSRCLK21, posedge DFETAP20[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP20_delay[0]);
//	$setuphold (posedge RXUSRCLK21, posedge DFETAP20[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP20_delay[1]);
//	$setuphold (posedge RXUSRCLK21, posedge DFETAP20[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP20_delay[2]);
//	$setuphold (posedge RXUSRCLK21, posedge DFETAP20[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP20_delay[3]);
//	$setuphold (posedge RXUSRCLK21, posedge DFETAP20[4], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP20_delay[4]);
	$setuphold (posedge RXUSRCLK21, posedge DFETAP21[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP21_delay[0]);
	$setuphold (posedge RXUSRCLK21, posedge DFETAP21[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP21_delay[1]);
	$setuphold (posedge RXUSRCLK21, posedge DFETAP21[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP21_delay[2]);
	$setuphold (posedge RXUSRCLK21, posedge DFETAP21[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP21_delay[3]);
	$setuphold (posedge RXUSRCLK21, posedge DFETAP21[4], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP21_delay[4]);
//	$setuphold (posedge RXUSRCLK21, posedge DFETAP30[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP30_delay[0]);
//	$setuphold (posedge RXUSRCLK21, posedge DFETAP30[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP30_delay[1]);
//	$setuphold (posedge RXUSRCLK21, posedge DFETAP30[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP30_delay[2]);
//	$setuphold (posedge RXUSRCLK21, posedge DFETAP30[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP30_delay[3]);
	$setuphold (posedge RXUSRCLK21, posedge DFETAP31[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP31_delay[0]);
	$setuphold (posedge RXUSRCLK21, posedge DFETAP31[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP31_delay[1]);
	$setuphold (posedge RXUSRCLK21, posedge DFETAP31[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP31_delay[2]);
	$setuphold (posedge RXUSRCLK21, posedge DFETAP31[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP31_delay[3]);
//	$setuphold (posedge RXUSRCLK21, posedge DFETAP40[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP40_delay[0]);
// $setuphold (posedge RXUSRCLK21, posedge DFETAP40[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP40_delay[1]);
//	$setuphold (posedge RXUSRCLK21, posedge DFETAP40[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP40_delay[2]);
//	$setuphold (posedge RXUSRCLK21, posedge DFETAP40[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP40_delay[3]);
	$setuphold (posedge RXUSRCLK21, posedge DFETAP41[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP41_delay[0]);
	$setuphold (posedge RXUSRCLK21, posedge DFETAP41[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP41_delay[1]);
	$setuphold (posedge RXUSRCLK21, posedge DFETAP41[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP41_delay[2]);
	$setuphold (posedge RXUSRCLK21, posedge DFETAP41[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,DFETAP41_delay[3]);
	$setuphold (posedge RXUSRCLK21, posedge PRBSCNTRESET1, 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,PRBSCNTRESET1_delay);
	$setuphold (posedge RXUSRCLK21, posedge RXCOMMADETUSE1, 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,RXCOMMADETUSE1_delay);
	$setuphold (posedge RXUSRCLK21, posedge RXDEC8B10BUSE1, 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,RXDEC8B10BUSE1_delay);
	$setuphold (posedge RXUSRCLK21, posedge RXENCHANSYNC1, 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay, RXENCHANSYNC1_delay);
	$setuphold (posedge RXUSRCLK21, posedge RXENMCOMMAALIGN1, 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay, RXENMCOMMAALIGN1_delay);
	$setuphold (posedge RXUSRCLK21, posedge RXENPCOMMAALIGN1, 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay, RXENPCOMMAALIGN1_delay);
	$setuphold (posedge RXUSRCLK21, posedge RXENPRBSTST1[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay, RXENPRBSTST1_delay[0]);
	$setuphold (posedge RXUSRCLK21, posedge RXENPRBSTST1[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay, RXENPRBSTST1_delay[1]);
	$setuphold (posedge RXUSRCLK21, posedge RXGEARBOXSLIP1, 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay, RXGEARBOXSLIP1_delay);
	$setuphold (posedge RXUSRCLK21, posedge RXPOLARITY1, 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay, RXPOLARITY1_delay);
	$setuphold (posedge RXUSRCLK21, posedge RXSLIDE1, 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay, RXSLIDE1_delay);
//	$setuphold (posedge RXUSRCLK21, posedge TXHEADER1[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay, TXHEADER1_delay[0]);
//	$setuphold (posedge RXUSRCLK21, posedge TXHEADER1[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay, TXHEADER1_delay[1]);
//	$setuphold (posedge RXUSRCLK21, posedge TXHEADER1[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay, TXHEADER1_delay[2]);
//	$setuphold (posedge RXUSRCLK21, posedge TXSEQUENCE1[0], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,TXSEQUENCE1_delay[0]);
//	$setuphold (posedge RXUSRCLK21, posedge TXSEQUENCE1[1], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,TXSEQUENCE1_delay[1]);
//	$setuphold (posedge RXUSRCLK21, posedge TXSEQUENCE1[2], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,TXSEQUENCE1_delay[2]);
//	$setuphold (posedge RXUSRCLK21, posedge TXSEQUENCE1[3], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,TXSEQUENCE1_delay[3]);
//	$setuphold (posedge RXUSRCLK21, posedge TXSEQUENCE1[4], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,TXSEQUENCE1_delay[4]);
//	$setuphold (posedge RXUSRCLK21, posedge TXSEQUENCE1[5], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,TXSEQUENCE1_delay[5]);
//	$setuphold (posedge RXUSRCLK21, posedge TXSEQUENCE1[6], 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,TXSEQUENCE1_delay[6]);
//	$setuphold (posedge RXUSRCLK21, posedge TXSTARTSEQ1, 0:0:0, 0:0:0, notifier,,,RXUSRCLK21_delay,TXSTARTSEQ1_delay);

//Added in K.35
  	$setuphold (posedge TXUSRCLK20, negedge TXELECIDLE0, 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay, TXELECIDLE0_delay);
  	$setuphold (posedge TXUSRCLK20, posedge TXELECIDLE0, 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay, TXELECIDLE0_delay);

 
//	$setuphold (posedge TXUSRCLK20, negedge RXENSAMPLEALIGN0, 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay, RXENSAMPLEALIGN0_delay);
	$setuphold (posedge TXUSRCLK20, negedge TXBYPASS8B10B0[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay, TXBYPASS8B10B0_delay[0]);
	$setuphold (posedge TXUSRCLK20, negedge TXBYPASS8B10B0[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay, TXBYPASS8B10B0_delay[1]);
	$setuphold (posedge TXUSRCLK20, negedge TXBYPASS8B10B0[2], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay, TXBYPASS8B10B0_delay[2]);
	$setuphold (posedge TXUSRCLK20, negedge TXBYPASS8B10B0[3], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay, TXBYPASS8B10B0_delay[3]);
	$setuphold (posedge TXUSRCLK20, negedge TXCHARDISPMODE0[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXCHARDISPMODE0_delay[0]);
	$setuphold (posedge TXUSRCLK20, negedge TXCHARDISPMODE0[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXCHARDISPMODE0_delay[1]);
	$setuphold (posedge TXUSRCLK20, negedge TXCHARDISPMODE0[2], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXCHARDISPMODE0_delay[2]);
	$setuphold (posedge TXUSRCLK20, negedge TXCHARDISPMODE0[3], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXCHARDISPMODE0_delay[3]);
	$setuphold (posedge TXUSRCLK20, negedge TXCHARDISPVAL0[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXCHARDISPVAL0_delay[0]);
	$setuphold (posedge TXUSRCLK20, negedge TXCHARDISPVAL0[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXCHARDISPVAL0_delay[1]);
	$setuphold (posedge TXUSRCLK20, negedge TXCHARDISPVAL0[2], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXCHARDISPVAL0_delay[2]);
	$setuphold (posedge TXUSRCLK20, negedge TXCHARDISPVAL0[3], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXCHARDISPVAL0_delay[3]);
	$setuphold (posedge TXUSRCLK20, negedge TXCHARISK0[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXCHARISK0_delay[0]);
	$setuphold (posedge TXUSRCLK20, negedge TXCHARISK0[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXCHARISK0_delay[1]);
	$setuphold (posedge TXUSRCLK20, negedge TXCHARISK0[2], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXCHARISK0_delay[2]);
	$setuphold (posedge TXUSRCLK20, negedge TXCHARISK0[3], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXCHARISK0_delay[3]);
	$setuphold (posedge TXUSRCLK20, negedge TXCOMSTART0, 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay, TXCOMSTART0_delay);
	$setuphold (posedge TXUSRCLK20, negedge TXCOMTYPE0, 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXCOMTYPE0_delay);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[0]);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[10], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[10]);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[11], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[11]);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[12], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[12]);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[13], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[13]);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[14], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[14]);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[15], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[15]);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[16], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[16]);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[17], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[17]);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[18], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[18]);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[19], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[19]);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[1]);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[20], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[20]);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[21], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[21]);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[22], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[22]);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[23], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[23]);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[24], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[24]);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[25], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[25]);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[26], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[26]);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[27], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[27]);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[28], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[28]);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[29], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[29]);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[2], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[2]);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[30], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[30]);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[31], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[31]);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[3], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[3]);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[4], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[4]);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[5], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[5]);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[6], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[6]);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[7], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[7]);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[8], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[8]);
	$setuphold (posedge TXUSRCLK20, negedge TXDATA0[9], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[9]);
	$setuphold (posedge TXUSRCLK20, negedge TXDETECTRX0, 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDETECTRX0_delay);
	$setuphold (posedge TXUSRCLK20, negedge TXENC8B10BUSE0, 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXENC8B10BUSE0_delay);
	$setuphold (posedge TXUSRCLK20, negedge TXENPRBSTST0[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXENPRBSTST0_delay[0]);
	$setuphold (posedge TXUSRCLK20, negedge TXENPRBSTST0[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXENPRBSTST0_delay[1]);
	$setuphold (posedge TXUSRCLK20, negedge TXHEADER0[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXHEADER0_delay[0]);
	$setuphold (posedge TXUSRCLK20, negedge TXHEADER0[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXHEADER0_delay[1]);
	$setuphold (posedge TXUSRCLK20, negedge TXHEADER0[2], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXHEADER0_delay[2]);
	$setuphold (posedge TXUSRCLK20, negedge TXINHIBIT0, 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXINHIBIT0_delay);
	$setuphold (posedge TXUSRCLK20, negedge TXPOLARITY0, 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXPOLARITY0_delay);
	$setuphold (posedge TXUSRCLK20, negedge TXSEQUENCE0[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXSEQUENCE0_delay[0]);
	$setuphold (posedge TXUSRCLK20, negedge TXSEQUENCE0[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXSEQUENCE0_delay[1]);
	$setuphold (posedge TXUSRCLK20, negedge TXSEQUENCE0[2], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXSEQUENCE0_delay[2]);
	$setuphold (posedge TXUSRCLK20, negedge TXSEQUENCE0[3], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXSEQUENCE0_delay[3]);
	$setuphold (posedge TXUSRCLK20, negedge TXSEQUENCE0[4], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXSEQUENCE0_delay[4]);
	$setuphold (posedge TXUSRCLK20, negedge TXSEQUENCE0[5], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXSEQUENCE0_delay[5]);
	$setuphold (posedge TXUSRCLK20, negedge TXSEQUENCE0[6], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXSEQUENCE0_delay[6]);
	$setuphold (posedge TXUSRCLK20, negedge TXSTARTSEQ0, 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXSTARTSEQ0_delay);

//	$setuphold (posedge TXUSRCLK20, posedge RXENSAMPLEALIGN0, 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,RXENSAMPLEALIGN0_delay);
	$setuphold (posedge TXUSRCLK20, posedge TXBYPASS8B10B0[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXBYPASS8B10B0_delay[0]);
	$setuphold (posedge TXUSRCLK20, posedge TXBYPASS8B10B0[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXBYPASS8B10B0_delay[1]);
	$setuphold (posedge TXUSRCLK20, posedge TXBYPASS8B10B0[2], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXBYPASS8B10B0_delay[2]);
	$setuphold (posedge TXUSRCLK20, posedge TXBYPASS8B10B0[3], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXBYPASS8B10B0_delay[3]);
	$setuphold (posedge TXUSRCLK20, posedge TXCHARDISPMODE0[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXCHARDISPMODE0_delay[0]);
	$setuphold (posedge TXUSRCLK20, posedge TXCHARDISPMODE0[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXCHARDISPMODE0_delay[1]);
	$setuphold (posedge TXUSRCLK20, posedge TXCHARDISPMODE0[2], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXCHARDISPMODE0_delay[2]);
	$setuphold (posedge TXUSRCLK20, posedge TXCHARDISPMODE0[3], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXCHARDISPMODE0_delay[3]);
	$setuphold (posedge TXUSRCLK20, posedge TXCHARDISPVAL0[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXCHARDISPVAL0_delay[0]);
	$setuphold (posedge TXUSRCLK20, posedge TXCHARDISPVAL0[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXCHARDISPVAL0_delay[1]);
	$setuphold (posedge TXUSRCLK20, posedge TXCHARDISPVAL0[2], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXCHARDISPVAL0_delay[2]);
	$setuphold (posedge TXUSRCLK20, posedge TXCHARDISPVAL0[3], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXCHARDISPVAL0_delay[3]);
	$setuphold (posedge TXUSRCLK20, posedge TXCHARISK0[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXCHARISK0_delay[0]);
	$setuphold (posedge TXUSRCLK20, posedge TXCHARISK0[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXCHARISK0_delay[1]);
	$setuphold (posedge TXUSRCLK20, posedge TXCHARISK0[2], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXCHARISK0_delay[2]);
	$setuphold (posedge TXUSRCLK20, posedge TXCHARISK0[3], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXCHARISK0_delay[3]);
	$setuphold (posedge TXUSRCLK20, posedge TXCOMSTART0, 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXCOMSTART0_delay);
	$setuphold (posedge TXUSRCLK20, posedge TXCOMTYPE0, 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXCOMTYPE0_delay);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[0]);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[10], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[10]);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[11], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[11]);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[12], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[12]);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[13], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[13]);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[14], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[14]);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[15], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[15]);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[16], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[16]);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[17], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[17]);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[18], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[18]);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[19], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[19]);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[1]);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[20], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[20]);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[21], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[21]);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[22], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[22]);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[23], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[23]);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[24], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[24]);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[25], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[25]);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[26], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[26]);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[27], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[27]);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[28], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[28]);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[29], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[29]);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[2], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[2]);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[30], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[30]);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[31], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[31]);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[3], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[3]);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[4], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[4]);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[5], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[5]);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[6], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[6]);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[7], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[7]);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[8], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[8]);
	$setuphold (posedge TXUSRCLK20, posedge TXDATA0[9], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDATA0_delay[9]);
	$setuphold (posedge TXUSRCLK20, posedge TXDETECTRX0, 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXDETECTRX0_delay);
	$setuphold (posedge TXUSRCLK20, posedge TXENC8B10BUSE0, 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXENC8B10BUSE0_delay);
	$setuphold (posedge TXUSRCLK20, posedge TXENPRBSTST0[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXENPRBSTST0_delay[0]);
	$setuphold (posedge TXUSRCLK20, posedge TXENPRBSTST0[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXENPRBSTST0_delay[1]);
	$setuphold (posedge TXUSRCLK20, posedge TXHEADER0[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXHEADER0_delay[0]);
	$setuphold (posedge TXUSRCLK20, posedge TXHEADER0[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXHEADER0_delay[1]);
	$setuphold (posedge TXUSRCLK20, posedge TXHEADER0[2], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXHEADER0_delay[2]);
	$setuphold (posedge TXUSRCLK20, posedge TXINHIBIT0, 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXINHIBIT0_delay);
	$setuphold (posedge TXUSRCLK20, posedge TXPOLARITY0, 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXPOLARITY0_delay);
   $setuphold (posedge TXUSRCLK20, posedge TXSEQUENCE0[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXSEQUENCE0_delay[0]);
	$setuphold (posedge TXUSRCLK20, posedge TXSEQUENCE0[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXSEQUENCE0_delay[1]);
	$setuphold (posedge TXUSRCLK20, posedge TXSEQUENCE0[2], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXSEQUENCE0_delay[2]);
	$setuphold (posedge TXUSRCLK20, posedge TXSEQUENCE0[3], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXSEQUENCE0_delay[3]);
	$setuphold (posedge TXUSRCLK20, posedge TXSEQUENCE0[4], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXSEQUENCE0_delay[4]);
	$setuphold (posedge TXUSRCLK20, posedge TXSEQUENCE0[5], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXSEQUENCE0_delay[5]);
	$setuphold (posedge TXUSRCLK20, posedge TXSEQUENCE0[6], 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXSEQUENCE0_delay[6]);
	$setuphold (posedge TXUSRCLK20, posedge TXSTARTSEQ0, 0:0:0, 0:0:0, notifier,,,TXUSRCLK20_delay,TXSTARTSEQ0_delay);

//Added in K.35
 	$setuphold (posedge TXUSRCLK21, negedge TXELECIDLE1, 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay, TXELECIDLE1_delay);
 	$setuphold (posedge TXUSRCLK21, posedge TXELECIDLE1, 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay, TXELECIDLE1_delay);
 	$setuphold (posedge TXUSRCLK21, negedge TXHEADER1[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay, TXHEADER1_delay[0] );
 	$setuphold (posedge TXUSRCLK21, negedge TXHEADER1[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay, TXHEADER1_delay[1]);
 	$setuphold (posedge TXUSRCLK21, negedge TXHEADER1[2], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay, TXHEADER1_delay[2]);
 	$setuphold (posedge TXUSRCLK21, posedge TXHEADER1[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay, TXHEADER1_delay[0]);
 	$setuphold (posedge TXUSRCLK21, posedge TXHEADER1[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay, TXHEADER1_delay[1]);
 	$setuphold (posedge TXUSRCLK21, posedge TXHEADER1[2], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay, TXHEADER1_delay[2]);
 	$setuphold (posedge TXUSRCLK21, negedge TXSEQUENCE1[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay, TXSEQUENCE1_delay[0]);
 	$setuphold (posedge TXUSRCLK21, negedge TXSEQUENCE1[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay, TXSEQUENCE1_delay[1]);
 	$setuphold (posedge TXUSRCLK21, negedge TXSEQUENCE1[2], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay, TXSEQUENCE1_delay[2]);
 	$setuphold (posedge TXUSRCLK21, negedge TXSEQUENCE1[3], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay, TXSEQUENCE1_delay[3]);
 	$setuphold (posedge TXUSRCLK21, negedge TXSEQUENCE1[4], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay, TXSEQUENCE1_delay[4]);
 	$setuphold (posedge TXUSRCLK21, negedge TXSEQUENCE1[5], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay, TXSEQUENCE1_delay[5]);
 	$setuphold (posedge TXUSRCLK21, negedge TXSEQUENCE1[6], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay, TXSEQUENCE1_delay[6]);
 	$setuphold (posedge TXUSRCLK21, posedge TXSEQUENCE1[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay, TXSEQUENCE1_delay[0]);
 	$setuphold (posedge TXUSRCLK21, posedge TXSEQUENCE1[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay, TXSEQUENCE1_delay[1]);
 	$setuphold (posedge TXUSRCLK21, posedge TXSEQUENCE1[2], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay, TXSEQUENCE1_delay[2]);
 	$setuphold (posedge TXUSRCLK21, posedge TXSEQUENCE1[3], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay, TXSEQUENCE1_delay[3]);
 	$setuphold (posedge TXUSRCLK21, posedge TXSEQUENCE1[4], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay, TXSEQUENCE1_delay[4]);
 	$setuphold (posedge TXUSRCLK21, posedge TXSEQUENCE1[5], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay, TXSEQUENCE1_delay[5]);
 	$setuphold (posedge TXUSRCLK21, posedge TXSEQUENCE1[6], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay, TXSEQUENCE1_delay[6]);
 	$setuphold (posedge TXUSRCLK21, negedge TXSTARTSEQ1, 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay, TXSTARTSEQ1_delay);
 	$setuphold (posedge TXUSRCLK21, posedge TXSTARTSEQ1, 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay, TXSTARTSEQ1_delay);



//	$setuphold (posedge TXUSRCLK21, negedge RXENSAMPLEALIGN1, 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,RXENSAMPLEALIGN1_delay);
	$setuphold (posedge TXUSRCLK21, negedge TXBYPASS8B10B1[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXBYPASS8B10B1_delay[0]);
	$setuphold (posedge TXUSRCLK21, negedge TXBYPASS8B10B1[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXBYPASS8B10B1_delay[1]);
	$setuphold (posedge TXUSRCLK21, negedge TXBYPASS8B10B1[2], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXBYPASS8B10B1_delay[2]);
	$setuphold (posedge TXUSRCLK21, negedge TXBYPASS8B10B1[3], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXBYPASS8B10B1_delay[3]);
	$setuphold (posedge TXUSRCLK21, negedge TXCHARDISPMODE1[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXCHARDISPMODE1_delay[0]);
	$setuphold (posedge TXUSRCLK21, negedge TXCHARDISPMODE1[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXCHARDISPMODE1_delay[1]);
	$setuphold (posedge TXUSRCLK21, negedge TXCHARDISPMODE1[2], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXCHARDISPMODE1_delay[2]);
	$setuphold (posedge TXUSRCLK21, negedge TXCHARDISPMODE1[3], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXCHARDISPMODE1_delay[3]);
	$setuphold (posedge TXUSRCLK21, negedge TXCHARDISPVAL1[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXCHARDISPVAL1_delay[0]);
	$setuphold (posedge TXUSRCLK21, negedge TXCHARDISPVAL1[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXCHARDISPVAL1_delay[1]);
	$setuphold (posedge TXUSRCLK21, negedge TXCHARDISPVAL1[2], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXCHARDISPVAL1_delay[2]);
	$setuphold (posedge TXUSRCLK21, negedge TXCHARDISPVAL1[3], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXCHARDISPVAL1_delay[3]);
	$setuphold (posedge TXUSRCLK21, negedge TXCHARISK1[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXCHARISK1_delay[0]);
	$setuphold (posedge TXUSRCLK21, negedge TXCHARISK1[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXCHARISK1_delay[1]);
	$setuphold (posedge TXUSRCLK21, negedge TXCHARISK1[2], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXCHARISK1_delay[2]);
	$setuphold (posedge TXUSRCLK21, negedge TXCHARISK1[3], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXCHARISK1_delay[3]);
	$setuphold (posedge TXUSRCLK21, negedge TXCOMSTART1, 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXCOMSTART1_delay);
	$setuphold (posedge TXUSRCLK21, negedge TXCOMTYPE1, 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXCOMTYPE1_delay);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[0]);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[10], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[10]);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[11], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[11]);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[12], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[12]);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[13], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[13]);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[14], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[14]);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[15], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[15]);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[16], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[16]);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[17], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[17]);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[18], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[18]);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[19], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[19]);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[1]);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[20], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[20]);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[21], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[21]);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[22], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[22]);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[23], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[23]);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[24], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[24]);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[25], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[25]);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[26], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[26]);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[27], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[27]);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[28], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[28]);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[29], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[29]);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[2], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[2]);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[30], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[30]);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[31], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[31]);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[3], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[3]);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[4], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[4]);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[5], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[5]);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[6], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[6]);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[7], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[7]);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[8], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[8]);
	$setuphold (posedge TXUSRCLK21, negedge TXDATA1[9], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[9]);
	$setuphold (posedge TXUSRCLK21, negedge TXDETECTRX1, 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDETECTRX1_delay);
	$setuphold (posedge TXUSRCLK21, negedge TXENC8B10BUSE1, 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXENC8B10BUSE1_delay);
	$setuphold (posedge TXUSRCLK21, negedge TXENPRBSTST1[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXENPRBSTST1_delay[0]);
	$setuphold (posedge TXUSRCLK21, negedge TXENPRBSTST1[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXENPRBSTST1_delay[1]);
	$setuphold (posedge TXUSRCLK21, negedge TXINHIBIT1, 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXINHIBIT1_delay);
	$setuphold (posedge TXUSRCLK21, negedge TXPOLARITY1, 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXPOLARITY1_delay);

//	$setuphold (posedge TXUSRCLK21, posedge RXENSAMPLEALIGN1, 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,RXENSAMPLEALIGN1_delay);
	$setuphold (posedge TXUSRCLK21, posedge TXBYPASS8B10B1[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXBYPASS8B10B1_delay[0]);
	$setuphold (posedge TXUSRCLK21, posedge TXBYPASS8B10B1[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXBYPASS8B10B1_delay[1]);
	$setuphold (posedge TXUSRCLK21, posedge TXBYPASS8B10B1[2], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXBYPASS8B10B1_delay[2]);
	$setuphold (posedge TXUSRCLK21, posedge TXBYPASS8B10B1[3], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXBYPASS8B10B1_delay[3]);
	$setuphold (posedge TXUSRCLK21, posedge TXCHARDISPMODE1[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXCHARDISPMODE1_delay[0]);
	$setuphold (posedge TXUSRCLK21, posedge TXCHARDISPMODE1[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXCHARDISPMODE1_delay[1]);
	$setuphold (posedge TXUSRCLK21, posedge TXCHARDISPMODE1[2], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXCHARDISPMODE1_delay[2]);
	$setuphold (posedge TXUSRCLK21, posedge TXCHARDISPMODE1[3], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXCHARDISPMODE1_delay[3]);
	$setuphold (posedge TXUSRCLK21, posedge TXCHARDISPVAL1[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXCHARDISPVAL1_delay[0]);
	$setuphold (posedge TXUSRCLK21, posedge TXCHARDISPVAL1[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXCHARDISPVAL1_delay[1]);
	$setuphold (posedge TXUSRCLK21, posedge TXCHARDISPVAL1[2], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXCHARDISPVAL1_delay[2]);
	$setuphold (posedge TXUSRCLK21, posedge TXCHARDISPVAL1[3], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXCHARDISPVAL1_delay[3]);
	$setuphold (posedge TXUSRCLK21, posedge TXCHARISK1[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXCHARISK1_delay[0]);
	$setuphold (posedge TXUSRCLK21, posedge TXCHARISK1[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXCHARISK1_delay[1]);
	$setuphold (posedge TXUSRCLK21, posedge TXCHARISK1[2], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXCHARISK1_delay[2]);
	$setuphold (posedge TXUSRCLK21, posedge TXCHARISK1[3], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXCHARISK1_delay[3]);
	$setuphold (posedge TXUSRCLK21, posedge TXCOMSTART1, 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXCOMSTART1_delay);
	$setuphold (posedge TXUSRCLK21, posedge TXCOMTYPE1, 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXCOMTYPE1_delay);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[0]);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[10], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[10]);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[11], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[11]);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[12], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[12]);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[13], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[13]);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[14], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[14]);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[15], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[15]);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[16], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[16]);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[17], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[17]);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[18], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[18]);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[19], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[19]);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[1]);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[20], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[20]);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[21], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[21]);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[22], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[22]);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[23], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[23]);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[24], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[24]);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[25], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[25]);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[26], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[26]);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[27], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[27]);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[28], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[28]);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[29], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[29]);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[2], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[2]);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[30], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[30]);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[31], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[31]);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[3], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[3]);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[4], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[4]);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[5], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[5]);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[6], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[6]);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[7], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[7]);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[8], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[8]);
	$setuphold (posedge TXUSRCLK21, posedge TXDATA1[9], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDATA1_delay[9]);
	$setuphold (posedge TXUSRCLK21, posedge TXDETECTRX1, 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXDETECTRX1_delay);
	$setuphold (posedge TXUSRCLK21, posedge TXENC8B10BUSE1, 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXENC8B10BUSE1_delay);
	$setuphold (posedge TXUSRCLK21, posedge TXENPRBSTST1[0], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXENPRBSTST1_delay[0]);
	$setuphold (posedge TXUSRCLK21, posedge TXENPRBSTST1[1], 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXENPRBSTST1_delay[1]);
	$setuphold (posedge TXUSRCLK21, posedge TXINHIBIT1, 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXINHIBIT1_delay);
	$setuphold (posedge TXUSRCLK21, posedge TXPOLARITY1, 0:0:0, 0:0:0, notifier,,,TXUSRCLK21_delay,TXPOLARITY1_delay);

	(CLKIN => REFCLKOUT) = (0:0:0, 0:0:0);
	(DCLK => DO[0]) = (100:100:100, 100:100:100);
	(DCLK => DO[10]) = (100:100:100, 100:100:100);
	(DCLK => DO[1]) = (100:100:100, 100:100:100);
	(DCLK => DO[11]) = (100:100:100, 100:100:100);
	(DCLK => DO[12]) = (100:100:100, 100:100:100);
	(DCLK => DO[13]) = (100:100:100, 100:100:100);
	(DCLK => DO[14]) = (100:100:100, 100:100:100);
	(DCLK => DO[15]) = (100:100:100, 100:100:100);
	(DCLK => DO[2]) = (100:100:100, 100:100:100);
	(DCLK => DO[3]) = (100:100:100, 100:100:100);
	(DCLK => DO[4]) = (100:100:100, 100:100:100);
	(DCLK => DO[5]) = (100:100:100, 100:100:100);
	(DCLK => DO[6]) = (100:100:100, 100:100:100);
	(DCLK => DO[7]) = (100:100:100, 100:100:100);
	(DCLK => DO[8]) = (100:100:100, 100:100:100);
	(DCLK => DO[9]) = (100:100:100, 100:100:100);
	(DCLK => DRDY) = (100:100:100, 100:100:100);
	(RXUSRCLK0 => RXCHBONDO0[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK0 => RXCHBONDO0[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK0 => RXCHBONDO0[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK0 => RXCHBONDO0[3]) = (100:100:100, 100:100:100);
	(RXUSRCLK1 => RXCHBONDO1[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK1 => RXCHBONDO1[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK1 => RXCHBONDO1[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK1 => RXCHBONDO1[3]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFECLKDLYADJMONITOR0[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFECLKDLYADJMONITOR0[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFECLKDLYADJMONITOR0[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFECLKDLYADJMONITOR0[3]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFECLKDLYADJMONITOR0[4]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFECLKDLYADJMONITOR0[5]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFEEYEDACMONITOR0[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFEEYEDACMONITOR0[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFEEYEDACMONITOR0[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFEEYEDACMONITOR0[3]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFEEYEDACMONITOR0[4]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFESENSCAL0[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFESENSCAL0[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFESENSCAL0[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFETAP1MONITOR0[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFETAP1MONITOR0[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFETAP1MONITOR0[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFETAP1MONITOR0[3]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFETAP1MONITOR0[4]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFETAP2MONITOR0[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFETAP2MONITOR0[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFETAP2MONITOR0[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFETAP2MONITOR0[3]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFETAP2MONITOR0[4]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFETAP3MONITOR0[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFETAP3MONITOR0[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFETAP3MONITOR0[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFETAP3MONITOR0[3]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFETAP4MONITOR0[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFETAP4MONITOR0[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFETAP4MONITOR0[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => DFETAP4MONITOR0[3]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => PHYSTATUS0) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXBUFSTATUS0[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXBUFSTATUS0[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXBUFSTATUS0[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXBYTEISALIGNED0) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXBYTEREALIGN0) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXCHANBONDSEQ0) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXCHANISALIGNED0) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXCHANREALIGN0) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXCHARISCOMMA0[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXCHARISCOMMA0[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXCHARISCOMMA0[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXCHARISCOMMA0[3]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXCHARISK0[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXCHARISK0[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXCHARISK0[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXCHARISK0[3]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXCLKCORCNT0[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXCLKCORCNT0[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXCLKCORCNT0[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXCOMMADET0) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[10]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[11]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[12]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[13]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[14]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[15]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[16]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[17]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[18]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[19]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[20]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[21]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[22]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[23]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[24]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[25]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[26]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[27]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[28]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[29]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[30]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[3]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[31]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[4]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[5]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[6]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[7]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[8]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATA0[9]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDATAVALID0) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDISPERR0[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDISPERR0[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDISPERR0[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXDISPERR0[3]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXHEADER0[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXHEADER0[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXHEADER0[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXHEADERVALID0) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXLOSSOFSYNC0[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXLOSSOFSYNC0[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXNOTINTABLE0[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXNOTINTABLE0[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXNOTINTABLE0[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXNOTINTABLE0[3]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXOVERSAMPLEERR0) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXPRBSERR0) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXRUNDISP0[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXRUNDISP0[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXRUNDISP0[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXRUNDISP0[3]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXSTARTOFSEQ0) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXSTATUS0[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXSTATUS0[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXSTATUS0[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK20 => RXVALID0) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFECLKDLYADJMONITOR1[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFECLKDLYADJMONITOR1[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFECLKDLYADJMONITOR1[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFECLKDLYADJMONITOR1[3]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFECLKDLYADJMONITOR1[4]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFECLKDLYADJMONITOR1[5]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFEEYEDACMONITOR1[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFEEYEDACMONITOR1[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFEEYEDACMONITOR1[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFEEYEDACMONITOR1[3]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFEEYEDACMONITOR1[4]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFESENSCAL1[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFESENSCAL1[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFESENSCAL1[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFETAP1MONITOR1[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFETAP1MONITOR1[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFETAP1MONITOR1[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFETAP1MONITOR1[3]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFETAP1MONITOR1[4]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFETAP2MONITOR1[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFETAP2MONITOR1[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFETAP2MONITOR1[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFETAP2MONITOR1[3]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFETAP2MONITOR1[4]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFETAP3MONITOR1[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFETAP3MONITOR1[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFETAP3MONITOR1[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFETAP3MONITOR1[3]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFETAP4MONITOR1[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFETAP4MONITOR1[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFETAP4MONITOR1[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => DFETAP4MONITOR1[3]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => PHYSTATUS1) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXBUFSTATUS1[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXBUFSTATUS1[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXBUFSTATUS1[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXBYTEISALIGNED1) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXBYTEREALIGN1) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXCHANBONDSEQ1) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXCHANISALIGNED1) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXCHANREALIGN1) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXCHARISCOMMA1[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXCHARISCOMMA1[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXCHARISCOMMA1[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXCHARISCOMMA1[3]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXCHARISK1[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXCHARISK1[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXCHARISK1[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXCHARISK1[3]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXCLKCORCNT1[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXCLKCORCNT1[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXCLKCORCNT1[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXCOMMADET1) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[10]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[11]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[12]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[13]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[14]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[15]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[16]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[17]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[18]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[19]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[20]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[21]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[22]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[23]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[24]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[25]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[26]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[27]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[28]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[29]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[30]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[3]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[31]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[4]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[5]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[6]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[7]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[8]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATA1[9]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDATAVALID1) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDISPERR1[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDISPERR1[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDISPERR1[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXDISPERR1[3]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXHEADER1[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXHEADER1[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXHEADER1[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXHEADERVALID1) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXLOSSOFSYNC1[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXLOSSOFSYNC1[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXNOTINTABLE1[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXNOTINTABLE1[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXNOTINTABLE1[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXNOTINTABLE1[3]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXOVERSAMPLEERR1) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXPRBSERR1) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXRUNDISP1[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXRUNDISP1[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXRUNDISP1[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXRUNDISP1[3]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXSTARTOFSEQ1) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXSTATUS1[0]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXSTATUS1[1]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXSTATUS1[2]) = (100:100:100, 100:100:100);
	(RXUSRCLK21 => RXVALID1) = (100:100:100, 100:100:100);
	(TXUSRCLK20 => TXBUFSTATUS0[0]) = (100:100:100, 100:100:100);
	(TXUSRCLK20 => TXBUFSTATUS0[1]) = (100:100:100, 100:100:100);
	(TXUSRCLK20 => TXGEARBOXREADY0) = (100:100:100, 100:100:100);
	(TXUSRCLK20 => TXKERR0[0]) = (100:100:100, 100:100:100);
	(TXUSRCLK20 => TXKERR0[1]) = (100:100:100, 100:100:100);
	(TXUSRCLK20 => TXKERR0[2]) = (100:100:100, 100:100:100);
	(TXUSRCLK20 => TXKERR0[3]) = (100:100:100, 100:100:100);
	(TXUSRCLK20 => TXRUNDISP0[0]) = (100:100:100, 100:100:100);
	(TXUSRCLK20 => TXRUNDISP0[1]) = (100:100:100, 100:100:100);
	(TXUSRCLK20 => TXRUNDISP0[2]) = (100:100:100, 100:100:100);
	(TXUSRCLK20 => TXRUNDISP0[3]) = (100:100:100, 100:100:100);
	(TXUSRCLK21 => TXBUFSTATUS1[0]) = (100:100:100, 100:100:100);
	(TXUSRCLK21 => TXBUFSTATUS1[1]) = (100:100:100, 100:100:100);
	(TXUSRCLK21 => TXGEARBOXREADY1) = (100:100:100, 100:100:100);
	(TXUSRCLK21 => TXKERR1[0]) = (100:100:100, 100:100:100);
	(TXUSRCLK21 => TXKERR1[1]) = (100:100:100, 100:100:100);
	(TXUSRCLK21 => TXKERR1[2]) = (100:100:100, 100:100:100);
	(TXUSRCLK21 => TXKERR1[3]) = (100:100:100, 100:100:100);
	(TXUSRCLK21 => TXRUNDISP1[0]) = (100:100:100, 100:100:100);
	(TXUSRCLK21 => TXRUNDISP1[1]) = (100:100:100, 100:100:100);
	(TXUSRCLK21 => TXRUNDISP1[2]) = (100:100:100, 100:100:100);
	(TXUSRCLK21 => TXRUNDISP1[3]) = (100:100:100, 100:100:100);

	specparam PATHPULSE$ = 0;
endspecify
endmodule

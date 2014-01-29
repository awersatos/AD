//////////////////////////////////////////////////////
//  Copyright (c) 2010 Xilinx Inc.
//  All Right Reserved.
///////////////////////////////////////////////////////
//
//   ____   ___
//  /   /\/   / 
// /___/  \  /     Vendor      : Xilinx 
// \  \    \/      Version     : 12.1i 
//  \  \           Description : Xilinx Functional Simulation Library Component
//  /  /                       : Gigabit Transceiver
// /__/   /\       Filename    : X_GTXE1.v
// \  \  /  \ 
//  \__\/\__ \                    
//                                 
//  Revision:		1.0
//  10/24/08 - CR495047 - Initial version
//  11/04/08 - CR495046 - replace case with if for parameter type integer - writer enhancement
//  11/05/08 - CR494078 - SIM_VERSION real to string
//  11/05/08 - CR495047 - Add DRC checks to simprim wrapper
//  11/19/08 - CR497301 - YML update for parameter default value 
//  12/23/08 - CR1014 - YML update for period checks 
//  01/07/08 - IR502336 - Fixed connectivity issue 
//  01/27/09 - CR505569 - Writer update
//  02/01/09 - CR505584 - Add Pathdelays for bused clock ports
//  02/11/09 - CR507680 - GTXE1 Attribute default changes
//  03/11/09 - CR511750 - Update attribute value to upper case
//  03/24/09 - CR514739 - PMA attribute default update
//  03/24/09 - CR513999 - Replace buf section with assign to pass Z value for SIM_TX_ELEC_IDLE_LEVEL 
//  05/05/09 - CR520565 - Update specify block from 100ps to 0ps
//  05/13/09 - CR521563 - Attribute POWER_SAVE default change
//  07/28/09 - CR528324 - Default Attribute YML updates
//  09/21/09 - CR532191 - YML update to add RXPRBSERR_LOOPBACK, SIM_VERSION updated to "2.0", add input RXDLYALIGNMONENB/TXDLYALIGNMONENB
//  03/04/10 - CR552249 - Attribute updates - YML & RTL updated
// ///////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps 

module X_GTXE1 (
  COMFINISH,
  COMINITDET,
  COMSASDET,
  COMWAKEDET,
  DFECLKDLYADJMON,
  DFEEYEDACMON,
  DFESENSCAL,
  DFETAP1MONITOR,
  DFETAP2MONITOR,
  DFETAP3MONITOR,
  DFETAP4MONITOR,
  DRDY,
  DRPDO,
  MGTREFCLKFAB,
  PHYSTATUS,
  RXBUFSTATUS,
  RXBYTEISALIGNED,
  RXBYTEREALIGN,
  RXCHANBONDSEQ,
  RXCHANISALIGNED,
  RXCHANREALIGN,
  RXCHARISCOMMA,
  RXCHARISK,
  RXCHBONDO,
  RXCLKCORCNT,
  RXCOMMADET,
  RXDATA,
  RXDATAVALID,
  RXDISPERR,
  RXDLYALIGNMONITOR,
  RXELECIDLE,
  RXHEADER,
  RXHEADERVALID,
  RXLOSSOFSYNC,
  RXNOTINTABLE,
  RXOVERSAMPLEERR,
  RXPLLLKDET,
  RXPRBSERR,
  RXRATEDONE,
  RXRECCLK,
  RXRECCLKPCS,
  RXRESETDONE,
  RXRUNDISP,
  RXSTARTOFSEQ,
  RXSTATUS,
  RXVALID,
  TSTOUT,
  TXBUFSTATUS,
  TXDLYALIGNMONITOR,
  TXGEARBOXREADY,
  TXKERR,
  TXN,
  TXOUTCLK,
  TXOUTCLKPCS,
  TXP,
  TXPLLLKDET,
  TXRATEDONE,
  TXRESETDONE,
  TXRUNDISP,
  DADDR,
  DCLK,
  DEN,
  DFECLKDLYADJ,
  DFEDLYOVRD,
  DFETAP1,
  DFETAP2,
  DFETAP3,
  DFETAP4,
  DFETAPOVRD,
  DI,
  DWE,
  GATERXELECIDLE,
  GREFCLKRX,
  GREFCLKTX,
  GTXRXRESET,
  GTXTEST,
  GTXTXRESET,
  IGNORESIGDET,
  LOOPBACK,
  MGTREFCLKRX,
  MGTREFCLKTX,
  NORTHREFCLKRX,
  NORTHREFCLKTX,
  PERFCLKRX,
  PERFCLKTX,
  PLLRXRESET,
  PLLTXRESET,
  PRBSCNTRESET,
  RXBUFRESET,
  RXCDRRESET,
  RXCHBONDI,
  RXCHBONDLEVEL,
  RXCHBONDMASTER,
  RXCHBONDSLAVE,
  RXCOMMADETUSE,
  RXDEC8B10BUSE,
  RXDLYALIGNDISABLE,
  RXDLYALIGNMONENB,		
  RXDLYALIGNOVERRIDE,
  RXDLYALIGNRESET,
  RXDLYALIGNSWPPRECURB,
  RXDLYALIGNUPDSW,
  RXENCHANSYNC,
  RXENMCOMMAALIGN,
  RXENPCOMMAALIGN,
  RXENPMAPHASEALIGN,
  RXENPRBSTST,
  RXENSAMPLEALIGN,
  RXEQMIX,
  RXGEARBOXSLIP,
  RXN,
  RXP,
  RXPLLLKDETEN,
  RXPLLPOWERDOWN,
  RXPLLREFSELDY,
  RXPMASETPHASE,
  RXPOLARITY,
  RXPOWERDOWN,
  RXRATE,
  RXRESET,
  RXSLIDE,
  RXUSRCLK,
  RXUSRCLK2,
  SOUTHREFCLKRX,
  SOUTHREFCLKTX,
  TSTCLK0,
  TSTCLK1,
  TSTIN,
  TXBUFDIFFCTRL,
  TXBYPASS8B10B,
  TXCHARDISPMODE,
  TXCHARDISPVAL,
  TXCHARISK,
  TXCOMINIT,
  TXCOMSAS,
  TXCOMWAKE,
  TXDATA,
  TXDEEMPH,
  TXDETECTRX,
  TXDIFFCTRL,
  TXDLYALIGNDISABLE,
  TXDLYALIGNMONENB,		
  TXDLYALIGNOVERRIDE,
  TXDLYALIGNRESET,
  TXDLYALIGNUPDSW,
  TXELECIDLE,
  TXENC8B10BUSE,
  TXENPMAPHASEALIGN,
  TXENPRBSTST,
  TXHEADER,
  TXINHIBIT,
  TXMARGIN,
  TXPDOWNASYNCH,
  TXPLLLKDETEN,
  TXPLLPOWERDOWN,
  TXPLLREFSELDY,
  TXPMASETPHASE,
  TXPOLARITY,
  TXPOSTEMPHASIS,
  TXPOWERDOWN,
  TXPRBSFORCEERR,
  TXPREEMPHASIS,
  TXRATE,
  TXRESET,
  TXSEQUENCE,
  TXSTARTSEQ,
  TXSWING,
  TXUSRCLK,
  TXUSRCLK2,
  USRCODEERR
);

  parameter LOC = "UNPLACED";
  parameter AC_CAP_DIS = "TRUE";
  parameter integer ALIGN_COMMA_WORD = 1;
  parameter [1:0] BGTEST_CFG = 2'b00;
  parameter [16:0] BIAS_CFG = 17'h00000;
  parameter [4:0] CDR_PH_ADJ_TIME = 5'b10100;
  parameter integer CHAN_BOND_1_MAX_SKEW = 7;
  parameter integer CHAN_BOND_2_MAX_SKEW = 1;
  parameter CHAN_BOND_KEEP_ALIGN = "FALSE";
  parameter [9:0] CHAN_BOND_SEQ_1_1 = 10'b0101111100;
  parameter [9:0] CHAN_BOND_SEQ_1_2 = 10'b0001001010;
  parameter [9:0] CHAN_BOND_SEQ_1_3 = 10'b0001001010;
  parameter [9:0] CHAN_BOND_SEQ_1_4 = 10'b0110111100;
  parameter [3:0] CHAN_BOND_SEQ_1_ENABLE = 4'b1111;
  parameter [9:0] CHAN_BOND_SEQ_2_1 = 10'b0100111100;
  parameter [9:0] CHAN_BOND_SEQ_2_2 = 10'b0100111100;
  parameter [9:0] CHAN_BOND_SEQ_2_3 = 10'b0110111100;
  parameter [9:0] CHAN_BOND_SEQ_2_4 = 10'b0100111100;
  parameter [4:0] CHAN_BOND_SEQ_2_CFG = 5'b00000;
  parameter [3:0] CHAN_BOND_SEQ_2_ENABLE = 4'b1111;
  parameter CHAN_BOND_SEQ_2_USE = "FALSE";
  parameter integer CHAN_BOND_SEQ_LEN = 1;
  parameter CLK_CORRECT_USE = "TRUE";
  parameter integer CLK_COR_ADJ_LEN = 1;
  parameter integer CLK_COR_DET_LEN = 1;
  parameter CLK_COR_INSERT_IDLE_FLAG = "FALSE";
  parameter CLK_COR_KEEP_IDLE = "FALSE";
  parameter integer CLK_COR_MAX_LAT = 20;
  parameter integer CLK_COR_MIN_LAT = 18;
  parameter CLK_COR_PRECEDENCE = "TRUE";
  parameter integer CLK_COR_REPEAT_WAIT = 0;
  parameter [9:0] CLK_COR_SEQ_1_1 = 10'b0100011100;
  parameter [9:0] CLK_COR_SEQ_1_2 = 10'b0000000000;
  parameter [9:0] CLK_COR_SEQ_1_3 = 10'b0000000000;
  parameter [9:0] CLK_COR_SEQ_1_4 = 10'b0000000000;
  parameter [3:0] CLK_COR_SEQ_1_ENABLE = 4'b1111;
  parameter [9:0] CLK_COR_SEQ_2_1 = 10'b0000000000;
  parameter [9:0] CLK_COR_SEQ_2_2 = 10'b0000000000;
  parameter [9:0] CLK_COR_SEQ_2_3 = 10'b0000000000;
  parameter [9:0] CLK_COR_SEQ_2_4 = 10'b0000000000;
  parameter [3:0] CLK_COR_SEQ_2_ENABLE = 4'b1111;
  parameter CLK_COR_SEQ_2_USE = "FALSE";
  parameter [1:0] CM_TRIM = 2'b01;
  parameter [9:0] COMMA_10B_ENABLE = 10'b1111111111;
  parameter COMMA_DOUBLE = "FALSE";
  parameter [3:0] COM_BURST_VAL = 4'b1111;
  parameter DEC_MCOMMA_DETECT = "TRUE";
  parameter DEC_PCOMMA_DETECT = "TRUE";
  parameter DEC_VALID_COMMA_ONLY = "TRUE";
  parameter [4:0] DFE_CAL_TIME = 5'b01100;
  parameter [7:0] DFE_CFG = 8'b00011011;
  parameter [2:0] GEARBOX_ENDEC = 3'b000;
  parameter GEN_RXUSRCLK = "TRUE";
  parameter GEN_TXUSRCLK = "TRUE";
  parameter GTX_CFG_PWRUP = "TRUE";
  parameter [9:0] MCOMMA_10B_VALUE = 10'b1010000011;
  parameter MCOMMA_DETECT = "TRUE";
  parameter [2:0] OOBDETECT_THRESHOLD = 3'b011;
  parameter PCI_EXPRESS_MODE = "FALSE";
  parameter [9:0] PCOMMA_10B_VALUE = 10'b0101111100;
  parameter PCOMMA_DETECT = "TRUE";
  parameter PMA_CAS_CLK_EN = "FALSE";
  parameter [26:0] PMA_CDR_SCAN = 27'h640404C;
  parameter [75:0] PMA_CFG = 76'h0040000040000000003;
  parameter [6:0] PMA_RXSYNC_CFG = 7'h00;
  parameter [24:0] PMA_RX_CFG = 25'h05CE048;
  parameter [19:0] PMA_TX_CFG = 20'h00082;
  parameter [9:0] POWER_SAVE = 10'b0000110100;
  parameter RCV_TERM_GND = "FALSE";
  parameter RCV_TERM_VTTRX = "TRUE";
  parameter RXGEARBOX_USE = "FALSE";
  parameter [23:0] RXPLL_COM_CFG = 24'h21680A;
  parameter [7:0] RXPLL_CP_CFG = 8'h00;
  parameter integer RXPLL_DIVSEL45_FB = 5;
  parameter integer RXPLL_DIVSEL_FB = 2;
  parameter integer RXPLL_DIVSEL_OUT = 1;
  parameter integer RXPLL_DIVSEL_REF = 1;
  parameter [2:0] RXPLL_LKDET_CFG = 3'b111;
  parameter [0:0] RXPRBSERR_LOOPBACK = 1'b0;
  parameter RXRECCLK_CTRL = "RXRECCLKPCS";
  parameter [9:0] RXRECCLK_DLY = 10'b0000000000;
  parameter [15:0] RXUSRCLK_DLY = 16'h0000;
  parameter RX_BUFFER_USE = "TRUE";
  parameter integer RX_CLK25_DIVIDER = 6;
  parameter integer RX_DATA_WIDTH = 20;
  parameter RX_DECODE_SEQ_MATCH = "TRUE";
  parameter [3:0] RX_DLYALIGN_CTRINC = 4'b0100;
  parameter [4:0] RX_DLYALIGN_EDGESET = 5'b00110;
  parameter [3:0] RX_DLYALIGN_LPFINC = 4'b0111;
  parameter [2:0] RX_DLYALIGN_MONSEL = 3'b000;
  parameter [7:0] RX_DLYALIGN_OVRDSETTING = 8'b00000000;
  parameter RX_EN_IDLE_HOLD_CDR = "FALSE";
  parameter RX_EN_IDLE_HOLD_DFE = "TRUE";
  parameter RX_EN_IDLE_RESET_BUF = "TRUE";
  parameter RX_EN_IDLE_RESET_FR = "TRUE";
  parameter RX_EN_IDLE_RESET_PH = "TRUE";
  parameter RX_EN_MODE_RESET_BUF = "TRUE";
  parameter RX_EN_RATE_RESET_BUF = "TRUE";
  parameter RX_EN_REALIGN_RESET_BUF = "FALSE";
  parameter RX_EN_REALIGN_RESET_BUF2 = "FALSE";
  parameter [7:0] RX_EYE_OFFSET = 8'h4C;
  parameter [1:0] RX_EYE_SCANMODE = 2'b00;
  parameter RX_FIFO_ADDR_MODE = "FULL";
  parameter [3:0] RX_IDLE_HI_CNT = 4'b1000;
  parameter [3:0] RX_IDLE_LO_CNT = 4'b0000;
  parameter RX_LOSS_OF_SYNC_FSM = "FALSE";
  parameter integer RX_LOS_INVALID_INCR = 1;
  parameter integer RX_LOS_THRESHOLD = 4;
  parameter RX_OVERSAMPLE_MODE = "FALSE";
  parameter integer RX_SLIDE_AUTO_WAIT = 5;
  parameter RX_SLIDE_MODE = "OFF";
  parameter RX_XCLK_SEL = "RXREC";
  parameter integer SAS_MAX_COMSAS = 52;
  parameter integer SAS_MIN_COMSAS = 40;
  parameter [2:0] SATA_BURST_VAL = 3'b100;
  parameter [2:0] SATA_IDLE_VAL = 3'b100;
  parameter integer SATA_MAX_BURST = 7;
  parameter integer SATA_MAX_INIT = 22;
  parameter integer SATA_MAX_WAKE = 7;
  parameter integer SATA_MIN_BURST = 4;
  parameter integer SATA_MIN_INIT = 12;
  parameter integer SATA_MIN_WAKE = 4;
  parameter SHOW_REALIGN_COMMA = "TRUE";
  parameter integer SIM_GTXRESET_SPEEDUP = 1;
  parameter SIM_RECEIVER_DETECT_PASS = "TRUE";
  parameter [2:0] SIM_RXREFCLK_SOURCE = 3'b000;
  parameter [2:0] SIM_TXREFCLK_SOURCE = 3'b000;
  parameter SIM_TX_ELEC_IDLE_LEVEL = "X";
  parameter SIM_VERSION = "2.0";
  parameter [4:0] TERMINATION_CTRL = 5'b10100;
  parameter TERMINATION_OVRD = "FALSE";
  parameter [11:0] TRANS_TIME_FROM_P2 = 12'h03C;
  parameter [7:0] TRANS_TIME_NON_P2 = 8'h19;
  parameter [7:0] TRANS_TIME_RATE = 8'h0E;
  parameter [9:0] TRANS_TIME_TO_P2 = 10'h064;
  parameter [31:0] TST_ATTR = 32'h00000000;
  parameter TXDRIVE_LOOPBACK_HIZ = "FALSE";
  parameter TXDRIVE_LOOPBACK_PD = "FALSE";
  parameter TXGEARBOX_USE = "FALSE";
  parameter TXOUTCLK_CTRL = "TXOUTCLKPCS";
  parameter [9:0] TXOUTCLK_DLY = 10'b0000000000;
  parameter [23:0] TXPLL_COM_CFG = 24'h21680A;
  parameter [7:0] TXPLL_CP_CFG = 8'h00;
  parameter integer TXPLL_DIVSEL45_FB = 5;
  parameter integer TXPLL_DIVSEL_FB = 2;
  parameter integer TXPLL_DIVSEL_OUT = 1;
  parameter integer TXPLL_DIVSEL_REF = 1;
  parameter [2:0] TXPLL_LKDET_CFG = 3'b111;
  parameter [1:0] TXPLL_SATA = 2'b00;
  parameter TX_BUFFER_USE = "TRUE";
  parameter [5:0] TX_BYTECLK_CFG = 6'h00;
  parameter integer TX_CLK25_DIVIDER = 6;
  parameter TX_CLK_SOURCE = "RXPLL";
  parameter integer TX_DATA_WIDTH = 20;
  parameter [4:0] TX_DEEMPH_0 = 5'b11010;
  parameter [4:0] TX_DEEMPH_1 = 5'b10000;
  parameter [13:0] TX_DETECT_RX_CFG = 14'h1832;
  parameter [3:0] TX_DLYALIGN_CTRINC = 4'b0100;
  parameter [3:0] TX_DLYALIGN_LPFINC = 4'b0110;
  parameter [2:0] TX_DLYALIGN_MONSEL = 3'b000;
  parameter [7:0] TX_DLYALIGN_OVRDSETTING = 8'b10000000;
  parameter TX_DRIVE_MODE = "DIRECT";
  parameter TX_EN_RATE_RESET_BUF = "TRUE";
  parameter [2:0] TX_IDLE_ASSERT_DELAY = 3'b100;
  parameter [2:0] TX_IDLE_DEASSERT_DELAY = 3'b010;
  parameter [6:0] TX_MARGIN_FULL_0 = 7'b1001110;
  parameter [6:0] TX_MARGIN_FULL_1 = 7'b1001001;
  parameter [6:0] TX_MARGIN_FULL_2 = 7'b1000101;
  parameter [6:0] TX_MARGIN_FULL_3 = 7'b1000010;
  parameter [6:0] TX_MARGIN_FULL_4 = 7'b1000000;
  parameter [6:0] TX_MARGIN_LOW_0 = 7'b1000110;
  parameter [6:0] TX_MARGIN_LOW_1 = 7'b1000100;
  parameter [6:0] TX_MARGIN_LOW_2 = 7'b1000010;
  parameter [6:0] TX_MARGIN_LOW_3 = 7'b1000000;
  parameter [6:0] TX_MARGIN_LOW_4 = 7'b1000000;
  parameter TX_OVERSAMPLE_MODE = "FALSE";
  parameter [0:0] TX_PMADATA_OPT = 1'b0;
  parameter [1:0] TX_TDCC_CFG = 2'b11;
  parameter [5:0] TX_USRCLK_CFG = 6'h00;
  parameter TX_XCLK_SEL = "TXUSR";

  localparam in_delay = 0;
  localparam out_delay = 0;
  localparam INCLK_DELAY = 0;
  localparam OUTCLK_DELAY = 0;
   
  output COMFINISH;
  output COMINITDET;
  output COMSASDET;
  output COMWAKEDET;
  output DRDY;
  output PHYSTATUS;
  output RXBYTEISALIGNED;
  output RXBYTEREALIGN;
  output RXCHANBONDSEQ;
  output RXCHANISALIGNED;
  output RXCHANREALIGN;
  output RXCOMMADET;
  output RXDATAVALID;
  output RXELECIDLE;
  output RXHEADERVALID;
  output RXOVERSAMPLEERR;
  output RXPLLLKDET;
  output RXPRBSERR;
  output RXRATEDONE;
  output RXRECCLK;
  output RXRECCLKPCS;
  output RXRESETDONE;
  output RXSTARTOFSEQ;
  output RXVALID;
  output TXGEARBOXREADY;
  output TXN;
  output TXOUTCLK;
  output TXOUTCLKPCS;
  output TXP;
  output TXPLLLKDET;
  output TXRATEDONE;
  output TXRESETDONE;
  output [15:0] DRPDO;
  output [1:0] MGTREFCLKFAB;
  output [1:0] RXLOSSOFSYNC;
  output [1:0] TXBUFSTATUS;
  output [2:0] DFESENSCAL;
  output [2:0] RXBUFSTATUS;
  output [2:0] RXCLKCORCNT;
  output [2:0] RXHEADER;
  output [2:0] RXSTATUS;
  output [31:0] RXDATA;
  output [3:0] DFETAP3MONITOR;
  output [3:0] DFETAP4MONITOR;
  output [3:0] RXCHARISCOMMA;
  output [3:0] RXCHARISK;
  output [3:0] RXCHBONDO;
  output [3:0] RXDISPERR;
  output [3:0] RXNOTINTABLE;
  output [3:0] RXRUNDISP;
  output [3:0] TXKERR;
  output [3:0] TXRUNDISP;
  output [4:0] DFEEYEDACMON;
  output [4:0] DFETAP1MONITOR;
  output [4:0] DFETAP2MONITOR;
  output [5:0] DFECLKDLYADJMON;
  output [7:0] RXDLYALIGNMONITOR;
  output [7:0] TXDLYALIGNMONITOR;
  output [9:0] TSTOUT;

  input DCLK;
  input DEN;
  input DFEDLYOVRD;
  input DFETAPOVRD;
  input DWE;
  input GATERXELECIDLE;
  input GREFCLKRX;
  input GREFCLKTX;
  input GTXRXRESET;
  input GTXTXRESET;
  input IGNORESIGDET;
  input PERFCLKRX;
  input PERFCLKTX;
  input PLLRXRESET;
  input PLLTXRESET;
  input PRBSCNTRESET;
  input RXBUFRESET;
  input RXCDRRESET;
  input RXCHBONDMASTER;
  input RXCHBONDSLAVE;
  input RXCOMMADETUSE;
  input RXDEC8B10BUSE;
  input RXDLYALIGNDISABLE;
  input RXDLYALIGNMONENB;
  input RXDLYALIGNOVERRIDE;
  input RXDLYALIGNRESET;
  input RXDLYALIGNSWPPRECURB;
  input RXDLYALIGNUPDSW;
  input RXENCHANSYNC;
  input RXENMCOMMAALIGN;
  input RXENPCOMMAALIGN;
  input RXENPMAPHASEALIGN;
  input RXENSAMPLEALIGN;
  input RXGEARBOXSLIP;
  input RXN;
  input RXP;
  input RXPLLLKDETEN;
  input RXPLLPOWERDOWN;
  input RXPMASETPHASE;
  input RXPOLARITY;
  input RXRESET;
  input RXSLIDE;
  input RXUSRCLK2;
  input RXUSRCLK;
  input TSTCLK0;
  input TSTCLK1;
  input TXCOMINIT;
  input TXCOMSAS;
  input TXCOMWAKE;
  input TXDEEMPH;
  input TXDETECTRX;
  input TXDLYALIGNDISABLE;
  input TXDLYALIGNMONENB;
  input TXDLYALIGNOVERRIDE;
  input TXDLYALIGNRESET;
  input TXDLYALIGNUPDSW;
  input TXELECIDLE;
  input TXENC8B10BUSE;
  input TXENPMAPHASEALIGN;
  input TXINHIBIT;
  input TXPDOWNASYNCH;
  input TXPLLLKDETEN;
  input TXPLLPOWERDOWN;
  input TXPMASETPHASE;
  input TXPOLARITY;
  input TXPRBSFORCEERR;
  input TXRESET;
  input TXSTARTSEQ;
  input TXSWING;
  input TXUSRCLK2;
  input TXUSRCLK;
  input USRCODEERR;
  input [12:0] GTXTEST;
  input [15:0] DI;
  input [19:0] TSTIN;
  input [1:0] MGTREFCLKRX;
  input [1:0] MGTREFCLKTX;
  input [1:0] NORTHREFCLKRX;
  input [1:0] NORTHREFCLKTX;
  input [1:0] RXPOWERDOWN;
  input [1:0] RXRATE;
  input [1:0] SOUTHREFCLKRX;
  input [1:0] SOUTHREFCLKTX;
  input [1:0] TXPOWERDOWN;
  input [1:0] TXRATE;
  input [2:0] LOOPBACK;
  input [2:0] RXCHBONDLEVEL;
  input [2:0] RXENPRBSTST;
  input [2:0] RXPLLREFSELDY;
  input [2:0] TXBUFDIFFCTRL;
  input [2:0] TXENPRBSTST;
  input [2:0] TXHEADER;
  input [2:0] TXMARGIN;
  input [2:0] TXPLLREFSELDY;
  input [31:0] TXDATA;
  input [3:0] DFETAP3;
  input [3:0] DFETAP4;
  input [3:0] RXCHBONDI;
  input [3:0] TXBYPASS8B10B;
  input [3:0] TXCHARDISPMODE;
  input [3:0] TXCHARDISPVAL;
  input [3:0] TXCHARISK;
  input [3:0] TXDIFFCTRL;
  input [3:0] TXPREEMPHASIS;
  input [4:0] DFETAP1;
  input [4:0] DFETAP2;
  input [4:0] TXPOSTEMPHASIS;
  input [5:0] DFECLKDLYADJ;
  input [6:0] TXSEQUENCE;
  input [7:0] DADDR;
  input [9:0] RXEQMIX;

  reg AC_CAP_DIS_BINARY;
  reg ALIGN_COMMA_WORD_BINARY;
  reg CHAN_BOND_KEEP_ALIGN_BINARY;
  reg CHAN_BOND_SEQ_2_USE_BINARY;
  reg CLK_CORRECT_USE_BINARY;
  reg CLK_COR_INSERT_IDLE_FLAG_BINARY;
  reg CLK_COR_KEEP_IDLE_BINARY;
  reg CLK_COR_PRECEDENCE_BINARY;
  reg CLK_COR_SEQ_2_USE_BINARY;
  reg COMMA_DOUBLE_BINARY;
  reg DEC_MCOMMA_DETECT_BINARY;
  reg DEC_PCOMMA_DETECT_BINARY;
  reg DEC_VALID_COMMA_ONLY_BINARY;
  reg GEN_RXUSRCLK_BINARY;
  reg GEN_TXUSRCLK_BINARY;
  reg GTX_CFG_PWRUP_BINARY;
  reg MCOMMA_DETECT_BINARY;
  reg PCI_EXPRESS_MODE_BINARY;
  reg PCOMMA_DETECT_BINARY;
  reg PMA_CAS_CLK_EN_BINARY;
  reg RCV_TERM_GND_BINARY;
  reg RCV_TERM_VTTRX_BINARY;
  reg RXGEARBOX_USE_BINARY;
  reg RXPLL_DIVSEL45_FB_BINARY;
  reg RXPRBSERR_LOOPBACK_BINARY;
  reg RX_BUFFER_USE_BINARY;
  reg RX_DECODE_SEQ_MATCH_BINARY;
  reg RX_EN_IDLE_HOLD_CDR_BINARY;
  reg RX_EN_IDLE_HOLD_DFE_BINARY;
  reg RX_EN_IDLE_RESET_BUF_BINARY;
  reg RX_EN_IDLE_RESET_FR_BINARY;
  reg RX_EN_IDLE_RESET_PH_BINARY;
  reg RX_EN_MODE_RESET_BUF_BINARY;
  reg RX_EN_RATE_RESET_BUF_BINARY;
  reg RX_EN_REALIGN_RESET_BUF2_BINARY;
  reg RX_EN_REALIGN_RESET_BUF_BINARY;
  reg RX_FIFO_ADDR_MODE_BINARY;
  reg RX_LOSS_OF_SYNC_FSM_BINARY;
  reg RX_OVERSAMPLE_MODE_BINARY;
  reg RX_XCLK_SEL_BINARY;
  reg SHOW_REALIGN_COMMA_BINARY;
  reg SIM_GTXRESET_SPEEDUP_BINARY;
  reg SIM_RECEIVER_DETECT_PASS_BINARY;
  reg SIM_TX_ELEC_IDLE_LEVEL_BINARY;
  reg SIM_VERSION_BINARY;
  reg TERMINATION_OVRD_BINARY;
  reg TXDRIVE_LOOPBACK_HIZ_BINARY;
  reg TXDRIVE_LOOPBACK_PD_BINARY;
  reg TXGEARBOX_USE_BINARY;
  reg TXPLL_DIVSEL45_FB_BINARY;
  reg TX_BUFFER_USE_BINARY;
  reg TX_CLK_SOURCE_BINARY;
  reg TX_DRIVE_MODE_BINARY;
  reg TX_EN_RATE_RESET_BUF_BINARY;
  reg TX_OVERSAMPLE_MODE_BINARY;
  reg TX_PMADATA_OPT_BINARY;
  reg TX_XCLK_SEL_BINARY;
  reg [1:0] BGTEST_CFG_BINARY;
  reg [1:0] CHAN_BOND_SEQ_LEN_BINARY;
  reg [1:0] CLK_COR_ADJ_LEN_BINARY;
  reg [1:0] CLK_COR_DET_LEN_BINARY;
  reg [1:0] CM_TRIM_BINARY;
  reg [1:0] RXPLL_DIVSEL_OUT_BINARY;
  reg [1:0] RX_EYE_SCANMODE_BINARY;
  reg [1:0] RX_SLIDE_MODE_BINARY;
  reg [1:0] TXPLL_DIVSEL_OUT_BINARY;
  reg [1:0] TXPLL_SATA_BINARY;
  reg [1:0] TX_TDCC_CFG_BINARY;
  reg [2:0] GEARBOX_ENDEC_BINARY;
  reg [2:0] OOBDETECT_THRESHOLD_BINARY;
  reg [2:0] RXPLL_LKDET_CFG_BINARY;
  reg [2:0] RXRECCLK_CTRL_BINARY;
  reg [2:0] RX_DATA_WIDTH_BINARY;
  reg [2:0] RX_DLYALIGN_MONSEL_BINARY;
  reg [2:0] RX_LOS_INVALID_INCR_BINARY;
  reg [2:0] RX_LOS_THRESHOLD_BINARY;
  reg [2:0] SATA_BURST_VAL_BINARY;
  reg [2:0] SATA_IDLE_VAL_BINARY;
  reg [2:0] SIM_RXREFCLK_SOURCE_BINARY;
  reg [2:0] SIM_TXREFCLK_SOURCE_BINARY;
  reg [2:0] TXOUTCLK_CTRL_BINARY;
  reg [2:0] TXPLL_LKDET_CFG_BINARY;
  reg [2:0] TX_DATA_WIDTH_BINARY;
  reg [2:0] TX_DLYALIGN_MONSEL_BINARY;
  reg [2:0] TX_IDLE_ASSERT_DELAY_BINARY;
  reg [2:0] TX_IDLE_DEASSERT_DELAY_BINARY;
  reg [3:0] CHAN_BOND_1_MAX_SKEW_BINARY;
  reg [3:0] CHAN_BOND_2_MAX_SKEW_BINARY;
  reg [3:0] CHAN_BOND_SEQ_1_ENABLE_BINARY;
  reg [3:0] CHAN_BOND_SEQ_2_ENABLE_BINARY;
  reg [3:0] CLK_COR_SEQ_1_ENABLE_BINARY;
  reg [3:0] CLK_COR_SEQ_2_ENABLE_BINARY;
  reg [3:0] COM_BURST_VAL_BINARY;
  reg [3:0] RX_DLYALIGN_CTRINC_BINARY;
  reg [3:0] RX_DLYALIGN_LPFINC_BINARY;
  reg [3:0] RX_IDLE_HI_CNT_BINARY;
  reg [3:0] RX_IDLE_LO_CNT_BINARY;
  reg [3:0] RX_SLIDE_AUTO_WAIT_BINARY;
  reg [3:0] TX_DLYALIGN_CTRINC_BINARY;
  reg [3:0] TX_DLYALIGN_LPFINC_BINARY;
  reg [4:0] CDR_PH_ADJ_TIME_BINARY;
  reg [4:0] CHAN_BOND_SEQ_2_CFG_BINARY;
  reg [4:0] CLK_COR_REPEAT_WAIT_BINARY;
  reg [4:0] DFE_CAL_TIME_BINARY;
  reg [4:0] RXPLL_DIVSEL_FB_BINARY;
  reg [4:0] RXPLL_DIVSEL_REF_BINARY;
  reg [4:0] RX_CLK25_DIVIDER_BINARY;
  reg [4:0] RX_DLYALIGN_EDGESET_BINARY;
  reg [4:0] TERMINATION_CTRL_BINARY;
  reg [4:0] TXPLL_DIVSEL_FB_BINARY;
  reg [4:0] TXPLL_DIVSEL_REF_BINARY;
  reg [4:0] TX_CLK25_DIVIDER_BINARY;
  reg [4:0] TX_DEEMPH_0_BINARY;
  reg [4:0] TX_DEEMPH_1_BINARY;
  reg [5:0] CLK_COR_MAX_LAT_BINARY;
  reg [5:0] CLK_COR_MIN_LAT_BINARY;
  reg [5:0] SAS_MAX_COMSAS_BINARY;
  reg [5:0] SAS_MIN_COMSAS_BINARY;
  reg [5:0] SATA_MAX_BURST_BINARY;
  reg [5:0] SATA_MAX_INIT_BINARY;
  reg [5:0] SATA_MAX_WAKE_BINARY;
  reg [5:0] SATA_MIN_BURST_BINARY;
  reg [5:0] SATA_MIN_INIT_BINARY;
  reg [5:0] SATA_MIN_WAKE_BINARY;
  reg [6:0] TX_MARGIN_FULL_0_BINARY;
  reg [6:0] TX_MARGIN_FULL_1_BINARY;
  reg [6:0] TX_MARGIN_FULL_2_BINARY;
  reg [6:0] TX_MARGIN_FULL_3_BINARY;
  reg [6:0] TX_MARGIN_FULL_4_BINARY;
  reg [6:0] TX_MARGIN_LOW_0_BINARY;
  reg [6:0] TX_MARGIN_LOW_1_BINARY;
  reg [6:0] TX_MARGIN_LOW_2_BINARY;
  reg [6:0] TX_MARGIN_LOW_3_BINARY;
  reg [6:0] TX_MARGIN_LOW_4_BINARY;
  reg [7:0] DFE_CFG_BINARY;
  reg [7:0] RX_DLYALIGN_OVRDSETTING_BINARY;
  reg [7:0] TX_DLYALIGN_OVRDSETTING_BINARY;
  reg [9:0] CHAN_BOND_SEQ_1_1_BINARY;
  reg [9:0] CHAN_BOND_SEQ_1_2_BINARY;
  reg [9:0] CHAN_BOND_SEQ_1_3_BINARY;
  reg [9:0] CHAN_BOND_SEQ_1_4_BINARY;
  reg [9:0] CHAN_BOND_SEQ_2_1_BINARY;
  reg [9:0] CHAN_BOND_SEQ_2_2_BINARY;
  reg [9:0] CHAN_BOND_SEQ_2_3_BINARY;
  reg [9:0] CHAN_BOND_SEQ_2_4_BINARY;
  reg [9:0] CLK_COR_SEQ_1_1_BINARY;
  reg [9:0] CLK_COR_SEQ_1_2_BINARY;
  reg [9:0] CLK_COR_SEQ_1_3_BINARY;
  reg [9:0] CLK_COR_SEQ_1_4_BINARY;
  reg [9:0] CLK_COR_SEQ_2_1_BINARY;
  reg [9:0] CLK_COR_SEQ_2_2_BINARY;
  reg [9:0] CLK_COR_SEQ_2_3_BINARY;
  reg [9:0] CLK_COR_SEQ_2_4_BINARY;
  reg [9:0] COMMA_10B_ENABLE_BINARY;
  reg [9:0] MCOMMA_10B_VALUE_BINARY;
  reg [9:0] PCOMMA_10B_VALUE_BINARY;
  reg [9:0] POWER_SAVE_BINARY;
  reg [9:0] RXRECCLK_DLY_BINARY;
  reg [9:0] TXOUTCLK_DLY_BINARY;

  tri0 GSR = glbl.GSR;
  reg notifier;

  wire COMFINISH_OUT;
  wire COMINITDET_OUT;
  wire COMSASDET_OUT;
  wire COMWAKEDET_OUT;
  wire DRDY_OUT;
  wire PHYSTATUS_OUT;
  wire RXBYTEISALIGNED_OUT;
  wire RXBYTEREALIGN_OUT;
  wire RXCHANBONDSEQ_OUT;
  wire RXCHANISALIGNED_OUT;
  wire RXCHANREALIGN_OUT;
  wire RXCOMMADET_OUT;
  wire RXDATAVALID_OUT;
  wire RXELECIDLE_OUT;
  wire RXHEADERVALID_OUT;
  wire RXOVERSAMPLEERR_OUT;
  wire RXPLLLKDET_OUT;
  wire RXPRBSERR_OUT;
  wire RXRATEDONE_OUT;
  wire RXRECCLKPCS_OUT;
  wire RXRECCLK_OUT;
  wire RXRESETDONE_OUT;
  wire RXSTARTOFSEQ_OUT;
  wire RXVALID_OUT;
  wire TXGEARBOXREADY_OUT;
  wire TXN_OUT;
  wire TXOUTCLKPCS_OUT;
  wire TXOUTCLK_OUT;
  wire TXPLLLKDET_OUT;
  wire TXP_OUT;
  wire TXRATEDONE_OUT;
  wire TXRESETDONE_OUT;
  wire [15:0] DRPDO_OUT;
  wire [1:0] MGTREFCLKFAB_OUT;
  wire [1:0] RXLOSSOFSYNC_OUT;
  wire [1:0] TXBUFSTATUS_OUT;
  wire [2:0] DFESENSCAL_OUT;
  wire [2:0] RXBUFSTATUS_OUT;
  wire [2:0] RXCLKCORCNT_OUT;
  wire [2:0] RXHEADER_OUT;
  wire [2:0] RXSTATUS_OUT;
  wire [31:0] RXDATA_OUT;
  wire [3:0] DFETAP3MONITOR_OUT;
  wire [3:0] DFETAP4MONITOR_OUT;
  wire [3:0] RXCHARISCOMMA_OUT;
  wire [3:0] RXCHARISK_OUT;
  wire [3:0] RXCHBONDO_OUT;
  wire [3:0] RXDISPERR_OUT;
  wire [3:0] RXNOTINTABLE_OUT;
  wire [3:0] RXRUNDISP_OUT;
  wire [3:0] TXKERR_OUT;
  wire [3:0] TXRUNDISP_OUT;
  wire [4:0] DFEEYEDACMON_OUT;
  wire [4:0] DFETAP1MONITOR_OUT;
  wire [4:0] DFETAP2MONITOR_OUT;
  wire [5:0] DFECLKDLYADJMON_OUT;
  wire [7:0] RXDLYALIGNMONITOR_OUT;
  wire [7:0] TXDLYALIGNMONITOR_OUT;
  wire [9:0] TSTOUT_OUT;

  wire DCLK_IN;
  wire DEN_IN;
  wire DFEDLYOVRD_IN;
  wire DFETAPOVRD_IN;
  wire DWE_IN;
  wire GATERXELECIDLE_IN;
  wire GREFCLKRX_IN;
  wire GREFCLKTX_IN;
  wire GTXRXRESET_IN;
  wire GTXTXRESET_IN;
  wire IGNORESIGDET_IN;
  wire PERFCLKRX_IN;
  wire PERFCLKTX_IN;
  wire PLLRXRESET_IN;
  wire PLLTXRESET_IN;
  wire PRBSCNTRESET_IN;
  wire RXBUFRESET_IN;
  wire RXCDRRESET_IN;
  wire RXCHBONDMASTER_IN;
  wire RXCHBONDSLAVE_IN;
  wire RXCOMMADETUSE_IN;
  wire RXDEC8B10BUSE_IN;
  wire RXDLYALIGNDISABLE_IN;
  wire RXDLYALIGNMONENB_IN;
  wire RXDLYALIGNOVERRIDE_IN;
  wire RXDLYALIGNRESET_IN;
  wire RXDLYALIGNSWPPRECURB_IN;
  wire RXDLYALIGNUPDSW_IN;
  wire RXENCHANSYNC_IN;
  wire RXENMCOMMAALIGN_IN;
  wire RXENPCOMMAALIGN_IN;
  wire RXENPMAPHASEALIGN_IN;
  wire RXENSAMPLEALIGN_IN;
  wire RXGEARBOXSLIP_IN;
  wire RXN_IN;
  wire RXPLLLKDETEN_IN;
  wire RXPLLPOWERDOWN_IN;
  wire RXPMASETPHASE_IN;
  wire RXPOLARITY_IN;
  wire RXP_IN;
  wire RXRESET_IN;
  wire RXSLIDE_IN;
  wire RXUSRCLK2_IN;
  wire RXUSRCLK_IN;
  wire TSTCLK0_IN;
  wire TSTCLK1_IN;
  wire TXCOMINIT_IN;
  wire TXCOMSAS_IN;
  wire TXCOMWAKE_IN;
  wire TXDEEMPH_IN;
  wire TXDETECTRX_IN;
  wire TXDLYALIGNDISABLE_IN;
  wire TXDLYALIGNMONENB_IN;
  wire TXDLYALIGNOVERRIDE_IN;
  wire TXDLYALIGNRESET_IN;
  wire TXDLYALIGNUPDSW_IN;
  wire TXELECIDLE_IN;
  wire TXENC8B10BUSE_IN;
  wire TXENPMAPHASEALIGN_IN;
  wire TXINHIBIT_IN;
  wire TXPDOWNASYNCH_IN;
  wire TXPLLLKDETEN_IN;
  wire TXPLLPOWERDOWN_IN;
  wire TXPMASETPHASE_IN;
  wire TXPOLARITY_IN;
  wire TXPRBSFORCEERR_IN;
  wire TXRESET_IN;
  wire TXSTARTSEQ_IN;
  wire TXSWING_IN;
  wire TXUSRCLK2_IN;
  wire TXUSRCLK_IN;
  wire USRCODEERR_IN;
  wire [12:0] GTXTEST_IN;
  wire [15:0] DI_IN;
  wire [19:0] TSTIN_IN;
  wire [1:0] MGTREFCLKRX_IN;
  wire [1:0] MGTREFCLKTX_IN;
  wire [1:0] NORTHREFCLKRX_IN;
  wire [1:0] NORTHREFCLKTX_IN;
  wire [1:0] RXPOWERDOWN_IN;
  wire [1:0] RXRATE_IN;
  wire [1:0] SOUTHREFCLKRX_IN;
  wire [1:0] SOUTHREFCLKTX_IN;
  wire [1:0] TXPOWERDOWN_IN;
  wire [1:0] TXRATE_IN;
  wire [2:0] LOOPBACK_IN;
  wire [2:0] RXCHBONDLEVEL_IN;
  wire [2:0] RXENPRBSTST_IN;
  wire [2:0] RXPLLREFSELDY_IN;
  wire [2:0] TXBUFDIFFCTRL_IN;
  wire [2:0] TXENPRBSTST_IN;
  wire [2:0] TXHEADER_IN;
  wire [2:0] TXMARGIN_IN;
  wire [2:0] TXPLLREFSELDY_IN;
  wire [31:0] TXDATA_IN;
  wire [3:0] DFETAP3_IN;
  wire [3:0] DFETAP4_IN;
  wire [3:0] RXCHBONDI_IN;
  wire [3:0] TXBYPASS8B10B_IN;
  wire [3:0] TXCHARDISPMODE_IN;
  wire [3:0] TXCHARDISPVAL_IN;
  wire [3:0] TXCHARISK_IN;
  wire [3:0] TXDIFFCTRL_IN;
  wire [3:0] TXPREEMPHASIS_IN;
  wire [4:0] DFETAP1_IN;
  wire [4:0] DFETAP2_IN;
  wire [4:0] TXPOSTEMPHASIS_IN;
  wire [5:0] DFECLKDLYADJ_IN;
  wire [6:0] TXSEQUENCE_IN;
  wire [7:0] DADDR_IN;
  wire [9:0] RXEQMIX_IN;
  wire DCLK_INDELAY;
  wire DEN_INDELAY;
  wire DFEDLYOVRD_INDELAY;
  wire DFETAPOVRD_INDELAY;
  wire DWE_INDELAY;
  wire GATERXELECIDLE_INDELAY;
  wire GREFCLKRX_INDELAY;
  wire GREFCLKTX_INDELAY;
  wire GTXRXRESET_INDELAY;
  wire GTXTXRESET_INDELAY;
  wire IGNORESIGDET_INDELAY;
  wire PERFCLKRX_INDELAY;
  wire PERFCLKTX_INDELAY;
  wire PLLRXRESET_INDELAY;
  wire PLLTXRESET_INDELAY;
  wire PRBSCNTRESET_INDELAY;
  wire RXBUFRESET_INDELAY;
  wire RXCDRRESET_INDELAY;
  wire RXCHBONDMASTER_INDELAY;
  wire RXCHBONDSLAVE_INDELAY;
  wire RXCOMMADETUSE_INDELAY;
  wire RXDEC8B10BUSE_INDELAY;
  wire RXDLYALIGNDISABLE_INDELAY;
  wire RXDLYALIGNMONENB_INDELAY;
  wire RXDLYALIGNOVERRIDE_INDELAY;
  wire RXDLYALIGNRESET_INDELAY;
  wire RXDLYALIGNSWPPRECURB_INDELAY;
  wire RXDLYALIGNUPDSW_INDELAY;
  wire RXENCHANSYNC_INDELAY;
  wire RXENMCOMMAALIGN_INDELAY;
  wire RXENPCOMMAALIGN_INDELAY;
  wire RXENPMAPHASEALIGN_INDELAY;
  wire RXENSAMPLEALIGN_INDELAY;
  wire RXGEARBOXSLIP_INDELAY;
  wire RXN_INDELAY;
  wire RXPLLLKDETEN_INDELAY;
  wire RXPLLPOWERDOWN_INDELAY;
  wire RXPMASETPHASE_INDELAY;
  wire RXPOLARITY_INDELAY;
  wire RXP_INDELAY;
  wire RXRESET_INDELAY;
  wire RXSLIDE_INDELAY;
  wire RXUSRCLK2_INDELAY;
  wire RXUSRCLK_INDELAY;
  wire TSTCLK0_INDELAY;
  wire TSTCLK1_INDELAY;
  wire TXCOMINIT_INDELAY;
  wire TXCOMSAS_INDELAY;
  wire TXCOMWAKE_INDELAY;
  wire TXDEEMPH_INDELAY;
  wire TXDETECTRX_INDELAY;
  wire TXDLYALIGNDISABLE_INDELAY;
  wire TXDLYALIGNMONENB_INDELAY;
  wire TXDLYALIGNOVERRIDE_INDELAY;
  wire TXDLYALIGNRESET_INDELAY;
  wire TXDLYALIGNUPDSW_INDELAY;
  wire TXELECIDLE_INDELAY;
  wire TXENC8B10BUSE_INDELAY;
  wire TXENPMAPHASEALIGN_INDELAY;
  wire TXINHIBIT_INDELAY;
  wire TXPDOWNASYNCH_INDELAY;
  wire TXPLLLKDETEN_INDELAY;
  wire TXPLLPOWERDOWN_INDELAY;
  wire TXPMASETPHASE_INDELAY;
  wire TXPOLARITY_INDELAY;
  wire TXPRBSFORCEERR_INDELAY;
  wire TXRESET_INDELAY;
  wire TXSTARTSEQ_INDELAY;
  wire TXSWING_INDELAY;
  wire TXUSRCLK2_INDELAY;
  wire TXUSRCLK_INDELAY;
  wire USRCODEERR_INDELAY;
  wire [12:0] GTXTEST_INDELAY;
  wire [15:0] DI_INDELAY;
  wire [19:0] TSTIN_INDELAY;
  wire [1:0] MGTREFCLKRX_INDELAY;
  wire [1:0] MGTREFCLKTX_INDELAY;
  wire [1:0] NORTHREFCLKRX_INDELAY;
  wire [1:0] NORTHREFCLKTX_INDELAY;
  wire [1:0] RXPOWERDOWN_INDELAY;
  wire [1:0] RXRATE_INDELAY;
  wire [1:0] SOUTHREFCLKRX_INDELAY;
  wire [1:0] SOUTHREFCLKTX_INDELAY;
  wire [1:0] TXPOWERDOWN_INDELAY;
  wire [1:0] TXRATE_INDELAY;
  wire [2:0] LOOPBACK_INDELAY;
  wire [2:0] RXCHBONDLEVEL_INDELAY;
  wire [2:0] RXENPRBSTST_INDELAY;
  wire [2:0] RXPLLREFSELDY_INDELAY;
  wire [2:0] TXBUFDIFFCTRL_INDELAY;
  wire [2:0] TXENPRBSTST_INDELAY;
  wire [2:0] TXHEADER_INDELAY;
  wire [2:0] TXMARGIN_INDELAY;
  wire [2:0] TXPLLREFSELDY_INDELAY;
  wire [31:0] TXDATA_INDELAY;
  wire [3:0] DFETAP3_INDELAY;
  wire [3:0] DFETAP4_INDELAY;
  wire [3:0] RXCHBONDI_INDELAY;
  wire [3:0] TXBYPASS8B10B_INDELAY;
  wire [3:0] TXCHARDISPMODE_INDELAY;
  wire [3:0] TXCHARDISPVAL_INDELAY;
  wire [3:0] TXCHARISK_INDELAY;
  wire [3:0] TXDIFFCTRL_INDELAY;
  wire [3:0] TXPREEMPHASIS_INDELAY;
  wire [4:0] DFETAP1_INDELAY;
  wire [4:0] DFETAP2_INDELAY;
  wire [4:0] TXPOSTEMPHASIS_INDELAY;
  wire [5:0] DFECLKDLYADJ_INDELAY;
  wire [6:0] TXSEQUENCE_INDELAY;
  wire [7:0] DADDR_INDELAY;
  wire [9:0] RXEQMIX_INDELAY;

   initial begin

    // Start DRC checks

     if (CHAN_BOND_2_MAX_SKEW > CHAN_BOND_1_MAX_SKEW) begin
	$display("DRC Error : The value of CHAN_BOND_2_MAX_SKEW is set to %d. This value must be less than or equal to the value of CHAN_BOND_1_MAX_SKEW %d for instance %m of GTXE1.",CHAN_BOND_2_MAX_SKEW, CHAN_BOND_1_MAX_SKEW);
	    $finish;
     end
     
     if (CLK_COR_MIN_LAT > CLK_COR_MAX_LAT) begin
	    $display("DRC Error :  The value of CLK_COR_MIN_LAT is set to %d. This value must be less than or equal to the value of CLK_COR_MAX_LAT %d for instance %m of GTXE1.",CLK_COR_MIN_LAT, CLK_COR_MAX_LAT);
	    $finish;
     end

     if (SATA_MIN_BURST > SATA_MAX_BURST) begin
	    $display("DRC Error : The value of SATA_MIN_BURST is set to %d. This value must be less than or equal to the value of SATA_MAX_BURST %d for instance %m of GTXE1.",SATA_MIN_BURST, SATA_MAX_BURST);
	    $finish;
     end

     if (SATA_MIN_INIT > SATA_MAX_INIT) begin
	    $display("DRC Error : The value of SATA_MIN_INIT is set to %d. This value must be less than or equal to the value of SATA_MAX_INIT %d for instance %m of GTXE1.",SATA_MIN_INIT, SATA_MAX_INIT);
	    $finish;
     end
     
     if (SATA_MIN_WAKE > SATA_MAX_WAKE) begin
	    $display("DRC Error : The value of SATA_MIN_WAKE is set to %d. This value must be less than or equal to the value of SATA_MAX_WAKE %d for instance %m of GTXE1.",SATA_MIN_WAKE, SATA_MAX_WAKE);
	    $finish;
     end

     if (SAS_MIN_COMSAS > SAS_MAX_COMSAS) begin
	    $display("DRC Error : The value of SAS_MIN_COMSAS is set to %d. This value must be less than or equal to the value of SAS_MAX_COMSAS %d for instance %m of GTXE1.",SAS_MIN_COMSAS, SAS_MAX_COMSAS);
	    $finish;
     end

     if ((RX_DATA_WIDTH == 16 &&  GEN_RXUSRCLK == "FALSE") || (RX_DATA_WIDTH == 20 &&  GEN_RXUSRCLK == "FALSE")) begin
	    $display("DRC Error : The following attribute condition must be satisfied for instance %m of GTXE1 : If RX_DATA_WIDTH is 8 or 10 (and channel bonding is not used) or if RX_DATA_WIDTH is 16 or 20 then set GEN_RXUSRCLK to TRUE.");
	    $finish;
     end
     
     if ((RX_DATA_WIDTH == 32 &&  GEN_RXUSRCLK == "TRUE") || (RX_DATA_WIDTH == 40 &&  GEN_RXUSRCLK == "TRUE")) begin
	    $display("DRC Error : The following attribute condition must be satisfied for instance %m of GTXE1 : If RX_DATA_WIDTH is 32 or 40 then set GEN_RXUSRCLK to FALSE.");
	    $finish;
     end

     if ((TX_DATA_WIDTH == 16 &&  GEN_TXUSRCLK == "FALSE") || (TX_DATA_WIDTH == 20 &&  GEN_TXUSRCLK == "FALSE")) begin
	    $display("DRC Error : The following attribute condition must be satisfied for instance %m of GTXE1 : If TX_DATA_WIDTH is 8 or 10 (and channel bonding is not used) or if TX_DATA_WIDTH is 16 or 20 then set GEN_TXUSRCLK to TRUE.");
	    $finish;
     end
     
     if ((TX_DATA_WIDTH == 32 &&  GEN_TXUSRCLK == "TRUE") || (TX_DATA_WIDTH == 40 &&  GEN_TXUSRCLK == "TRUE")) begin
	    $display("DRC Error : The following attribute condition must be satisfied for instance %m of GTXE1 : If TX_DATA_WIDTH is 32 or 40 then set GEN_TXUSRCLK to FALSE.");
	    $finish;
     end

     if (CLK_CORRECT_USE == "TRUE" && RX_FIFO_ADDR_MODE == "FAST") begin
	    $display("DRC Error : The following attribute condition must be satisfied for instance %m of GTXE1 : If CLK_CORRECT_USE is TRUE then set RX_FIFO_ADDR_MODE to FULL.");
	    $finish;
     end

     if ((RX_SLIDE_MODE == "PMA" && SHOW_REALIGN_COMMA == "TRUE") || (RX_SLIDE_MODE == "AUTO" && SHOW_REALIGN_COMMA == "TRUE")) begin
	    $display("DRC Error : The following attribute condition must be satisfied for instance %m of GTXE1 : If RX_SLIDE_MODE is PMA or AUTO then set SHOW_REALIGN_COMMA to FALSE.");
	    $finish;
     end

     
    // End DRC checks
     
    case (AC_CAP_DIS)
      "FALSE" : AC_CAP_DIS_BINARY = 1'b0;
      "TRUE" : AC_CAP_DIS_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute AC_CAP_DIS on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", AC_CAP_DIS);
        $finish;
      end
    endcase

    case (ALIGN_COMMA_WORD)
      1 : ALIGN_COMMA_WORD_BINARY = 1'b0;
      2 : ALIGN_COMMA_WORD_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute ALIGN_COMMA_WORD on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are 1 to 2.", ALIGN_COMMA_WORD, 1);
        $finish;
      end
    endcase

    case (CHAN_BOND_KEEP_ALIGN)
      "FALSE" : CHAN_BOND_KEEP_ALIGN_BINARY = 1'b0;
      "TRUE" : CHAN_BOND_KEEP_ALIGN_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute CHAN_BOND_KEEP_ALIGN on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", CHAN_BOND_KEEP_ALIGN);
        $finish;
      end
    endcase

    case (CHAN_BOND_SEQ_2_USE)
      "FALSE" : CHAN_BOND_SEQ_2_USE_BINARY = 1'b0;
      "TRUE" : CHAN_BOND_SEQ_2_USE_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute CHAN_BOND_SEQ_2_USE on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", CHAN_BOND_SEQ_2_USE);
        $finish;
      end
    endcase

    case (CHAN_BOND_SEQ_LEN)
      1 : CHAN_BOND_SEQ_LEN_BINARY = 2'b00;
      2 : CHAN_BOND_SEQ_LEN_BINARY = 2'b01;
      4 : CHAN_BOND_SEQ_LEN_BINARY = 2'b11;
      default : begin
        $display("Attribute Syntax Error : The Attribute CHAN_BOND_SEQ_LEN on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are 1 to 4.", CHAN_BOND_SEQ_LEN, 1);
        $finish;
      end
    endcase

    case (CLK_CORRECT_USE)
      "FALSE" : CLK_CORRECT_USE_BINARY = 1'b0;
      "TRUE" : CLK_CORRECT_USE_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute CLK_CORRECT_USE on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", CLK_CORRECT_USE);
        $finish;
      end
    endcase

    case (CLK_COR_ADJ_LEN)
      1 : CLK_COR_ADJ_LEN_BINARY = 2'b00;
      2 : CLK_COR_ADJ_LEN_BINARY = 2'b01;
      4 : CLK_COR_ADJ_LEN_BINARY = 2'b11;
      default : begin
        $display("Attribute Syntax Error : The Attribute CLK_COR_ADJ_LEN on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are 1 to 4.", CLK_COR_ADJ_LEN, 1);
        $finish;
      end
    endcase

    case (CLK_COR_DET_LEN)
      1 : CLK_COR_DET_LEN_BINARY = 2'b00;
      2 : CLK_COR_DET_LEN_BINARY = 2'b01;
      4 : CLK_COR_DET_LEN_BINARY = 2'b11;
      default : begin
        $display("Attribute Syntax Error : The Attribute CLK_COR_DET_LEN on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are 1 to 4.", CLK_COR_DET_LEN, 1);
        $finish;
      end
    endcase

    case (CLK_COR_INSERT_IDLE_FLAG)
      "FALSE" : CLK_COR_INSERT_IDLE_FLAG_BINARY = 1'b0;
      "TRUE" : CLK_COR_INSERT_IDLE_FLAG_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute CLK_COR_INSERT_IDLE_FLAG on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", CLK_COR_INSERT_IDLE_FLAG);
        $finish;
      end
    endcase

    case (CLK_COR_KEEP_IDLE)
      "FALSE" : CLK_COR_KEEP_IDLE_BINARY = 1'b0;
      "TRUE" : CLK_COR_KEEP_IDLE_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute CLK_COR_KEEP_IDLE on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", CLK_COR_KEEP_IDLE);
        $finish;
      end
    endcase

    case (CLK_COR_PRECEDENCE)
      "FALSE" : CLK_COR_PRECEDENCE_BINARY = 1'b0;
      "TRUE" : CLK_COR_PRECEDENCE_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute CLK_COR_PRECEDENCE on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", CLK_COR_PRECEDENCE);
        $finish;
      end
    endcase

    case (CLK_COR_SEQ_2_USE)
      "FALSE" : CLK_COR_SEQ_2_USE_BINARY = 1'b0;
      "TRUE" : CLK_COR_SEQ_2_USE_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute CLK_COR_SEQ_2_USE on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", CLK_COR_SEQ_2_USE);
        $finish;
      end
    endcase

    case (COMMA_DOUBLE)
      "FALSE" : COMMA_DOUBLE_BINARY = 1'b0;
      "TRUE" : COMMA_DOUBLE_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute COMMA_DOUBLE on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", COMMA_DOUBLE);
        $finish;
      end
    endcase

    case (DEC_MCOMMA_DETECT)
      "FALSE" : DEC_MCOMMA_DETECT_BINARY = 1'b0;
      "TRUE" : DEC_MCOMMA_DETECT_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute DEC_MCOMMA_DETECT on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", DEC_MCOMMA_DETECT);
        $finish;
      end
    endcase

    case (DEC_PCOMMA_DETECT)
      "FALSE" : DEC_PCOMMA_DETECT_BINARY = 1'b0;
      "TRUE" : DEC_PCOMMA_DETECT_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute DEC_PCOMMA_DETECT on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", DEC_PCOMMA_DETECT);
        $finish;
      end
    endcase

    case (DEC_VALID_COMMA_ONLY)
      "FALSE" : DEC_VALID_COMMA_ONLY_BINARY = 1'b0;
      "TRUE" : DEC_VALID_COMMA_ONLY_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute DEC_VALID_COMMA_ONLY on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", DEC_VALID_COMMA_ONLY);
        $finish;
      end
    endcase

    case (GEN_RXUSRCLK)
      "FALSE" : GEN_RXUSRCLK_BINARY = 1'b0;
      "TRUE" : GEN_RXUSRCLK_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute GEN_RXUSRCLK on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", GEN_RXUSRCLK);
        $finish;
      end
    endcase

    case (GEN_TXUSRCLK)
      "FALSE" : GEN_TXUSRCLK_BINARY = 1'b0;
      "TRUE" : GEN_TXUSRCLK_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute GEN_TXUSRCLK on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", GEN_TXUSRCLK);
        $finish;
      end
    endcase

    case (GTX_CFG_PWRUP)
      "FALSE" : GTX_CFG_PWRUP_BINARY = 1'b0;
      "TRUE" : GTX_CFG_PWRUP_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute GTX_CFG_PWRUP on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", GTX_CFG_PWRUP);
        $finish;
      end
    endcase

    case (MCOMMA_DETECT)
      "FALSE" : MCOMMA_DETECT_BINARY = 1'b0;
      "TRUE" : MCOMMA_DETECT_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute MCOMMA_DETECT on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", MCOMMA_DETECT);
        $finish;
      end
    endcase

    case (PCI_EXPRESS_MODE)
      "FALSE" : PCI_EXPRESS_MODE_BINARY = 1'b0;
      "TRUE" : PCI_EXPRESS_MODE_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute PCI_EXPRESS_MODE on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", PCI_EXPRESS_MODE);
        $finish;
      end
    endcase

    case (PCOMMA_DETECT)
      "FALSE" : PCOMMA_DETECT_BINARY = 1'b0;
      "TRUE" : PCOMMA_DETECT_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute PCOMMA_DETECT on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", PCOMMA_DETECT);
        $finish;
      end
    endcase

    case (PMA_CAS_CLK_EN)
      "FALSE" : PMA_CAS_CLK_EN_BINARY = 1'b0;
      "TRUE" : PMA_CAS_CLK_EN_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute PMA_CAS_CLK_EN on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", PMA_CAS_CLK_EN);
        $finish;
      end
    endcase

    case (RCV_TERM_GND)
      "FALSE" : RCV_TERM_GND_BINARY = 1'b0;
      "TRUE" : RCV_TERM_GND_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute RCV_TERM_GND on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RCV_TERM_GND);
        $finish;
      end
    endcase

    case (RCV_TERM_VTTRX)
      "FALSE" : RCV_TERM_VTTRX_BINARY = 1'b0;
      "TRUE" : RCV_TERM_VTTRX_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute RCV_TERM_VTTRX on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RCV_TERM_VTTRX);
        $finish;
      end
    endcase

    case (RXGEARBOX_USE)
      "FALSE" : RXGEARBOX_USE_BINARY = 1'b0;
      "TRUE" : RXGEARBOX_USE_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute RXGEARBOX_USE on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RXGEARBOX_USE);
        $finish;
      end
    endcase

    case (RXPLL_DIVSEL45_FB)
      5 : RXPLL_DIVSEL45_FB_BINARY = 1'b1;
      4 : RXPLL_DIVSEL45_FB_BINARY = 1'b0;
      default : begin
        $display("Attribute Syntax Error : The Attribute RXPLL_DIVSEL45_FB on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are 4 to 5.", RXPLL_DIVSEL45_FB, 5);
        $finish;
      end
    endcase

    case (RXPLL_DIVSEL_FB)
      2 : RXPLL_DIVSEL_FB_BINARY = 5'b00000;
      1 : RXPLL_DIVSEL_FB_BINARY = 5'b10000;
      3 : RXPLL_DIVSEL_FB_BINARY = 5'b00001;
      4 : RXPLL_DIVSEL_FB_BINARY = 5'b00010;
      5 : RXPLL_DIVSEL_FB_BINARY = 5'b00011;
      6 : RXPLL_DIVSEL_FB_BINARY = 5'b00101;
      8 : RXPLL_DIVSEL_FB_BINARY = 5'b00110;
      10 : RXPLL_DIVSEL_FB_BINARY = 5'b00111;
      12 : RXPLL_DIVSEL_FB_BINARY = 5'b01101;
      16 : RXPLL_DIVSEL_FB_BINARY = 5'b01110;
      20 : RXPLL_DIVSEL_FB_BINARY = 5'b01111;
      default : begin
        $display("Attribute Syntax Error : The Attribute RXPLL_DIVSEL_FB on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are 1 to 20.", RXPLL_DIVSEL_FB, 2);
        $finish;
      end
    endcase

    case (RXPLL_DIVSEL_OUT)
      1 : RXPLL_DIVSEL_OUT_BINARY = 2'b00;
      2 : RXPLL_DIVSEL_OUT_BINARY = 2'b01;
      4 : RXPLL_DIVSEL_OUT_BINARY = 2'b10;
      default : begin
        $display("Attribute Syntax Error : The Attribute RXPLL_DIVSEL_OUT on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are 1 to 4.", RXPLL_DIVSEL_OUT, 1);
        $finish;
      end
    endcase

    case (RXPLL_DIVSEL_REF)
      1 : RXPLL_DIVSEL_REF_BINARY = 5'b10000;
      2 : RXPLL_DIVSEL_REF_BINARY = 5'b00000;
      3 : RXPLL_DIVSEL_REF_BINARY = 5'b00001;
      4 : RXPLL_DIVSEL_REF_BINARY = 5'b00010;
      5 : RXPLL_DIVSEL_REF_BINARY = 5'b00011;
      6 : RXPLL_DIVSEL_REF_BINARY = 5'b00101;
      8 : RXPLL_DIVSEL_REF_BINARY = 5'b00110;
      10 : RXPLL_DIVSEL_REF_BINARY = 5'b00111;
      12 : RXPLL_DIVSEL_REF_BINARY = 5'b01101;
      16 : RXPLL_DIVSEL_REF_BINARY = 5'b01110;
      20 : RXPLL_DIVSEL_REF_BINARY = 5'b01111;
      default : begin
        $display("Attribute Syntax Error : The Attribute RXPLL_DIVSEL_REF on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are 1 to 20.", RXPLL_DIVSEL_REF, 1);
        $finish;
      end
    endcase

    case (RXRECCLK_CTRL)
      "RXRECCLKPCS" : RXRECCLK_CTRL_BINARY = 3'b000;
      "RXPLLREFCLK_DIV1" : RXRECCLK_CTRL_BINARY = 3'b011;
      "RXPLLREFCLK_DIV2" : RXRECCLK_CTRL_BINARY = 3'b100;
      "RXRECCLKPMA_DIV1" : RXRECCLK_CTRL_BINARY = 3'b001;
      "RXRECCLKPMA_DIV2" : RXRECCLK_CTRL_BINARY = 3'b010;
      "CLKTESTSIG1"      : RXRECCLK_CTRL_BINARY = 3'b111;
      default : begin
        $display("Attribute Syntax Error : The Attribute RXRECCLK_CTRL on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are RXRECCLKPCS, RXPLLREFCLK_DIV1, RXPLLREFCLK_DIV2, RXRECCLKPMA_DIV1, RXRECCLKPMA_DIV2 or CLKTESTSIG1.", RXRECCLK_CTRL);
        $finish;
      end
    endcase

    case (RX_BUFFER_USE)
      "FALSE" : RX_BUFFER_USE_BINARY = 1'b0;
      "TRUE" : RX_BUFFER_USE_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute RX_BUFFER_USE on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RX_BUFFER_USE);
        $finish;
      end
    endcase

    case (RX_CLK25_DIVIDER)
      6 : RX_CLK25_DIVIDER_BINARY = 5'b00101;
      1 : RX_CLK25_DIVIDER_BINARY = 5'b00000;
      2 : RX_CLK25_DIVIDER_BINARY = 5'b00001;
      3 : RX_CLK25_DIVIDER_BINARY = 5'b00010;
      4 : RX_CLK25_DIVIDER_BINARY = 5'b00011;
      5 : RX_CLK25_DIVIDER_BINARY = 5'b00100;
      7 : RX_CLK25_DIVIDER_BINARY = 5'b00110;
      8 : RX_CLK25_DIVIDER_BINARY = 5'b00111;
      9 : RX_CLK25_DIVIDER_BINARY = 5'b01000;
      10 : RX_CLK25_DIVIDER_BINARY = 5'b01001;
      11 : RX_CLK25_DIVIDER_BINARY = 5'b01010;
      12 : RX_CLK25_DIVIDER_BINARY = 5'b01011;
      13 : RX_CLK25_DIVIDER_BINARY = 5'b01100;
      14 : RX_CLK25_DIVIDER_BINARY = 5'b01101;
      15 : RX_CLK25_DIVIDER_BINARY = 5'b01110;
      16 : RX_CLK25_DIVIDER_BINARY = 5'b01111;
      17 : RX_CLK25_DIVIDER_BINARY = 5'b10000;
      18 : RX_CLK25_DIVIDER_BINARY = 5'b10001;
      19 : RX_CLK25_DIVIDER_BINARY = 5'b10010;
      20 : RX_CLK25_DIVIDER_BINARY = 5'b10011;
      21 : RX_CLK25_DIVIDER_BINARY = 5'b10100;
      22 : RX_CLK25_DIVIDER_BINARY = 5'b10101;
      23 : RX_CLK25_DIVIDER_BINARY = 5'b10110;
      24 : RX_CLK25_DIVIDER_BINARY = 5'b10111;
      25 : RX_CLK25_DIVIDER_BINARY = 5'b11000;
      26 : RX_CLK25_DIVIDER_BINARY = 5'b11001;
      27 : RX_CLK25_DIVIDER_BINARY = 5'b11010;
      28 : RX_CLK25_DIVIDER_BINARY = 5'b11011;
      29 : RX_CLK25_DIVIDER_BINARY = 5'b11100;
      30 : RX_CLK25_DIVIDER_BINARY = 5'b11101;
      31 : RX_CLK25_DIVIDER_BINARY = 5'b11110;
      32 : RX_CLK25_DIVIDER_BINARY = 5'b11111;
      default : begin
        $display("Attribute Syntax Error : The Attribute RX_CLK25_DIVIDER on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are 1 to 32.", RX_CLK25_DIVIDER, 6);
        $finish;
      end
    endcase

    case (RX_DATA_WIDTH)
      20 : RX_DATA_WIDTH_BINARY = 3'b011;
      8 : RX_DATA_WIDTH_BINARY = 3'b000;
      10 : RX_DATA_WIDTH_BINARY = 3'b001;
      16 : RX_DATA_WIDTH_BINARY = 3'b010;
      32 : RX_DATA_WIDTH_BINARY = 3'b100;
      40 : RX_DATA_WIDTH_BINARY = 3'b101;
      default : begin
        $display("Attribute Syntax Error : The Attribute RX_DATA_WIDTH on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are 8 to 40.", RX_DATA_WIDTH, 20);
        $finish;
      end
    endcase

    case (RX_DECODE_SEQ_MATCH)
      "FALSE" : RX_DECODE_SEQ_MATCH_BINARY = 1'b0;
      "TRUE" : RX_DECODE_SEQ_MATCH_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute RX_DECODE_SEQ_MATCH on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RX_DECODE_SEQ_MATCH);
        $finish;
      end
    endcase

    case (RX_EN_IDLE_HOLD_CDR)
      "FALSE" : RX_EN_IDLE_HOLD_CDR_BINARY = 1'b0;
      "TRUE" : RX_EN_IDLE_HOLD_CDR_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute RX_EN_IDLE_HOLD_CDR on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RX_EN_IDLE_HOLD_CDR);
        $finish;
      end
    endcase

    case (RX_EN_IDLE_HOLD_DFE)
      "FALSE" : RX_EN_IDLE_HOLD_DFE_BINARY = 1'b0;
      "TRUE" : RX_EN_IDLE_HOLD_DFE_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute RX_EN_IDLE_HOLD_DFE on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RX_EN_IDLE_HOLD_DFE);
        $finish;
      end
    endcase

    case (RX_EN_IDLE_RESET_BUF)
      "FALSE" : RX_EN_IDLE_RESET_BUF_BINARY = 1'b0;
      "TRUE" : RX_EN_IDLE_RESET_BUF_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute RX_EN_IDLE_RESET_BUF on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RX_EN_IDLE_RESET_BUF);
        $finish;
      end
    endcase

    case (RX_EN_IDLE_RESET_FR)
      "FALSE" : RX_EN_IDLE_RESET_FR_BINARY = 1'b0;
      "TRUE" : RX_EN_IDLE_RESET_FR_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute RX_EN_IDLE_RESET_FR on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RX_EN_IDLE_RESET_FR);
        $finish;
      end
    endcase

    case (RX_EN_IDLE_RESET_PH)
      "FALSE" : RX_EN_IDLE_RESET_PH_BINARY = 1'b0;
      "TRUE" : RX_EN_IDLE_RESET_PH_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute RX_EN_IDLE_RESET_PH on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RX_EN_IDLE_RESET_PH);
        $finish;
      end
    endcase

    case (RX_EN_MODE_RESET_BUF)
      "FALSE" : RX_EN_MODE_RESET_BUF_BINARY = 1'b0;
      "TRUE" : RX_EN_MODE_RESET_BUF_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute RX_EN_MODE_RESET_BUF on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RX_EN_MODE_RESET_BUF);
        $finish;
      end
    endcase

    case (RX_EN_RATE_RESET_BUF)
      "FALSE" : RX_EN_RATE_RESET_BUF_BINARY = 1'b0;
      "TRUE" : RX_EN_RATE_RESET_BUF_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute RX_EN_RATE_RESET_BUF on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RX_EN_RATE_RESET_BUF);
        $finish;
      end
    endcase

    case (RX_EN_REALIGN_RESET_BUF)
      "FALSE" : RX_EN_REALIGN_RESET_BUF_BINARY = 1'b0;
      "TRUE" : RX_EN_REALIGN_RESET_BUF_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute RX_EN_REALIGN_RESET_BUF on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RX_EN_REALIGN_RESET_BUF);
        $finish;
      end
    endcase

    case (RX_EN_REALIGN_RESET_BUF2)
      "FALSE" : RX_EN_REALIGN_RESET_BUF2_BINARY = 1'b0;
      "TRUE" : RX_EN_REALIGN_RESET_BUF2_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute RX_EN_REALIGN_RESET_BUF2 on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RX_EN_REALIGN_RESET_BUF2);
        $finish;
      end
    endcase

    case (RX_FIFO_ADDR_MODE)
      "FULL" : RX_FIFO_ADDR_MODE_BINARY = 1'b0;
      "FAST" : RX_FIFO_ADDR_MODE_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute RX_FIFO_ADDR_MODE on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are FULL, or FAST.", RX_FIFO_ADDR_MODE);
        $finish;
      end
    endcase

    case (RX_LOSS_OF_SYNC_FSM)
      "FALSE" : RX_LOSS_OF_SYNC_FSM_BINARY = 1'b0;
      "TRUE" : RX_LOSS_OF_SYNC_FSM_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute RX_LOSS_OF_SYNC_FSM on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RX_LOSS_OF_SYNC_FSM);
        $finish;
      end
    endcase

    case (RX_LOS_INVALID_INCR)
      1 : RX_LOS_INVALID_INCR_BINARY = 3'b000;
      2 : RX_LOS_INVALID_INCR_BINARY = 3'b001;
      4 : RX_LOS_INVALID_INCR_BINARY = 3'b010;
      8 : RX_LOS_INVALID_INCR_BINARY = 3'b011;
      16 : RX_LOS_INVALID_INCR_BINARY = 3'b100;
      32 : RX_LOS_INVALID_INCR_BINARY = 3'b101;
      64 : RX_LOS_INVALID_INCR_BINARY = 3'b110;
      128 : RX_LOS_INVALID_INCR_BINARY = 3'b111;
      default : begin
        $display("Attribute Syntax Error : The Attribute RX_LOS_INVALID_INCR on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are 1 to 128.", RX_LOS_INVALID_INCR, 1);
        $finish;
      end
    endcase

    case (RX_LOS_THRESHOLD)
      4 : RX_LOS_THRESHOLD_BINARY = 3'b000;
      8 : RX_LOS_THRESHOLD_BINARY = 3'b001;
      16 : RX_LOS_THRESHOLD_BINARY = 3'b010;
      32 : RX_LOS_THRESHOLD_BINARY = 3'b011;
      64 : RX_LOS_THRESHOLD_BINARY = 3'b100;
      128 : RX_LOS_THRESHOLD_BINARY = 3'b101;
      256 : RX_LOS_THRESHOLD_BINARY = 3'b110;
      512 : RX_LOS_THRESHOLD_BINARY = 3'b111;
      default : begin
        $display("Attribute Syntax Error : The Attribute RX_LOS_THRESHOLD on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are 4 to 512.", RX_LOS_THRESHOLD, 4);
        $finish;
      end
    endcase

    case (RX_OVERSAMPLE_MODE)
      "FALSE" : RX_OVERSAMPLE_MODE_BINARY = 1'b0;
      "TRUE" : RX_OVERSAMPLE_MODE_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute RX_OVERSAMPLE_MODE on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", RX_OVERSAMPLE_MODE);
        $finish;
      end
    endcase

    case (RX_SLIDE_MODE)
      "OFF" : RX_SLIDE_MODE_BINARY = 2'b00;
      "AUTO" : RX_SLIDE_MODE_BINARY = 2'b01;
      "PCS" : RX_SLIDE_MODE_BINARY = 2'b10;
      "PMA" : RX_SLIDE_MODE_BINARY = 2'b11;
      default : begin
        $display("Attribute Syntax Error : The Attribute RX_SLIDE_MODE on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are OFF, AUTO, PCS, or PMA.", RX_SLIDE_MODE);
        $finish;
      end
    endcase

    case (RX_XCLK_SEL)
      "RXREC" : RX_XCLK_SEL_BINARY = 1'b0;
      "RXUSR" : RX_XCLK_SEL_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute RX_XCLK_SEL on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are RXREC, or RXUSR.", RX_XCLK_SEL);
        $finish;
      end
    endcase

    case (SHOW_REALIGN_COMMA)
      "FALSE" : SHOW_REALIGN_COMMA_BINARY = 1'b0;
      "TRUE" : SHOW_REALIGN_COMMA_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute SHOW_REALIGN_COMMA on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", SHOW_REALIGN_COMMA);
        $finish;
      end
    endcase

    case (SIM_GTXRESET_SPEEDUP)
      1 : SIM_GTXRESET_SPEEDUP_BINARY =  1;
      0 : SIM_GTXRESET_SPEEDUP_BINARY =  0;
      default : begin
        $display("Attribute Syntax Error : The Attribute SIM_GTXRESET_SPEEDUP on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are 0 to 1.", SIM_GTXRESET_SPEEDUP, 1);
        $finish;
      end
    endcase

    case (SIM_RECEIVER_DETECT_PASS)
      "FALSE" : SIM_RECEIVER_DETECT_PASS_BINARY = 1'b0;
      "TRUE" : SIM_RECEIVER_DETECT_PASS_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute SIM_RECEIVER_DETECT_PASS on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", SIM_RECEIVER_DETECT_PASS);
        $finish;
      end
    endcase

/*    case (SIM_TX_ELEC_IDLE_LEVEL)
      "X" : SIM_TX_ELEC_IDLE_LEVEL_BINARY = 0;
      "0" : SIM_TX_ELEC_IDLE_LEVEL_BINARY = 0;
      "1" : SIM_TX_ELEC_IDLE_LEVEL_BINARY = 0;
      "Z" : SIM_TX_ELEC_IDLE_LEVEL_BINARY = 0;
      default : begin
        $display("Attribute Syntax Error : The Attribute SIM_TX_ELEC_IDLE_LEVEL on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are X, 0, 1, or Z.", SIM_TX_ELEC_IDLE_LEVEL);
        $finish;
      end
    endcase

    case (SIM_VERSION)
      "1.0" : SIM_VERSION_BINARY = 0;
      "0.0" : SIM_VERSION_BINARY = 0;
      default : begin
        $display("Attribute Syntax Error : The Attribute SIM_VERSION on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are 1.0, or 0.0.", SIM_VERSION);
        $finish;
      end
    endcase
*/
    case (TERMINATION_OVRD)
      "FALSE" : TERMINATION_OVRD_BINARY = 1'b0;
      "TRUE" : TERMINATION_OVRD_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute TERMINATION_OVRD on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", TERMINATION_OVRD);
        $finish;
      end
    endcase

    case (TXDRIVE_LOOPBACK_HIZ)
      "FALSE" : TXDRIVE_LOOPBACK_HIZ_BINARY = 1'b0;
      "TRUE" : TXDRIVE_LOOPBACK_HIZ_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute TXDRIVE_LOOPBACK_HIZ on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", TXDRIVE_LOOPBACK_HIZ);
        $finish;
      end
    endcase

    case (TXDRIVE_LOOPBACK_PD)
      "FALSE" : TXDRIVE_LOOPBACK_PD_BINARY = 1'b0;
      "TRUE" : TXDRIVE_LOOPBACK_PD_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute TXDRIVE_LOOPBACK_PD on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", TXDRIVE_LOOPBACK_PD);
        $finish;
      end
    endcase

    case (TXGEARBOX_USE)
      "FALSE" : TXGEARBOX_USE_BINARY = 1'b0;
      "TRUE" : TXGEARBOX_USE_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute TXGEARBOX_USE on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", TXGEARBOX_USE);
        $finish;
      end
    endcase

    case (TXOUTCLK_CTRL)
      "TXOUTCLKPCS" : TXOUTCLK_CTRL_BINARY = 3'b000;
      "TXOUTCLKPMA_DIV1" : TXOUTCLK_CTRL_BINARY = 3'b001;
      "TXOUTCLKPMA_DIV2" : TXOUTCLK_CTRL_BINARY = 3'b010;
      "TXPLLREFCLK_DIV1" : TXOUTCLK_CTRL_BINARY = 3'b011;
      "TXPLLREFCLK_DIV2" : TXOUTCLK_CTRL_BINARY = 3'b100;
      "CLKTESTSIG0"      : TXOUTCLK_CTRL_BINARY = 3'b111;
	default : begin
        $display("Attribute Syntax Error : The Attribute TXOUTCLK_CTRL on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TXOUTCLKPCS, TXOUTCLKPMA_DIV1, TXOUTCLKPMA_DIV2, TXPLLREFCLK_DIV1, TXPLLREFCLK_DIV2 or CLKTESTSIG0.", TXOUTCLK_CTRL);
        $finish;
      end
    endcase

    case (TXPLL_DIVSEL45_FB)
      5 : TXPLL_DIVSEL45_FB_BINARY = 1'b1;
      4 : TXPLL_DIVSEL45_FB_BINARY = 1'b0;
      default : begin
        $display("Attribute Syntax Error : The Attribute TXPLL_DIVSEL45_FB on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are 4 to 5.", TXPLL_DIVSEL45_FB, 5);
        $finish;
      end
    endcase

    case (TXPLL_DIVSEL_FB)
      2 : TXPLL_DIVSEL_FB_BINARY = 5'b00000;
      1 : TXPLL_DIVSEL_FB_BINARY = 5'b10000;
      3 : TXPLL_DIVSEL_FB_BINARY = 5'b00001;
      4 : TXPLL_DIVSEL_FB_BINARY = 5'b00010;
      5 : TXPLL_DIVSEL_FB_BINARY = 5'b00011;
      6 : TXPLL_DIVSEL_FB_BINARY = 5'b00101;
      8 : TXPLL_DIVSEL_FB_BINARY = 5'b00110;
      10 : TXPLL_DIVSEL_FB_BINARY = 5'b00111;
      12 : TXPLL_DIVSEL_FB_BINARY = 5'b01101;
      16 : TXPLL_DIVSEL_FB_BINARY = 5'b01110;
      20 : TXPLL_DIVSEL_FB_BINARY = 5'b01111;
      default : begin
        $display("Attribute Syntax Error : The Attribute TXPLL_DIVSEL_FB on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are 1 to 20.", TXPLL_DIVSEL_FB, 2);
        $finish;
      end
    endcase

    case (TXPLL_DIVSEL_OUT)
      1 : TXPLL_DIVSEL_OUT_BINARY = 2'b00;
      2 : TXPLL_DIVSEL_OUT_BINARY = 2'b01;
      4 : TXPLL_DIVSEL_OUT_BINARY = 2'b10;
      default : begin
        $display("Attribute Syntax Error : The Attribute TXPLL_DIVSEL_OUT on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are 1 to 4.", TXPLL_DIVSEL_OUT, 1);
        $finish;
      end
    endcase

    case (TXPLL_DIVSEL_REF)
      1 : TXPLL_DIVSEL_REF_BINARY = 5'b10000;
      2 : TXPLL_DIVSEL_REF_BINARY = 5'b00000;
      3 : TXPLL_DIVSEL_REF_BINARY = 5'b00001;
      4 : TXPLL_DIVSEL_REF_BINARY = 5'b00010;
      5 : TXPLL_DIVSEL_REF_BINARY = 5'b00011;
      6 : TXPLL_DIVSEL_REF_BINARY = 5'b00101;
      8 : TXPLL_DIVSEL_REF_BINARY = 5'b00110;
      10 : TXPLL_DIVSEL_REF_BINARY = 5'b00111;
      12 : TXPLL_DIVSEL_REF_BINARY = 5'b01101;
      16 : TXPLL_DIVSEL_REF_BINARY = 5'b01110;
      20 : TXPLL_DIVSEL_REF_BINARY = 5'b01111;
      default : begin
        $display("Attribute Syntax Error : The Attribute TXPLL_DIVSEL_REF on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are 1 to 20.", TXPLL_DIVSEL_REF, 1);
        $finish;
      end
    endcase

    case (TX_BUFFER_USE)
      "FALSE" : TX_BUFFER_USE_BINARY = 1'b0;
      "TRUE" : TX_BUFFER_USE_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute TX_BUFFER_USE on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", TX_BUFFER_USE);
        $finish;
      end
    endcase

    case (TX_CLK25_DIVIDER)
      6 : TX_CLK25_DIVIDER_BINARY = 5'b00101;
      1 : TX_CLK25_DIVIDER_BINARY = 5'b00000;
      2 : TX_CLK25_DIVIDER_BINARY = 5'b00001;
      3 : TX_CLK25_DIVIDER_BINARY = 5'b00010;
      4 : TX_CLK25_DIVIDER_BINARY = 5'b00011;
      5 : TX_CLK25_DIVIDER_BINARY = 5'b00100;
      7 : TX_CLK25_DIVIDER_BINARY = 5'b00110;
      8 : TX_CLK25_DIVIDER_BINARY = 5'b00111;
      9 : TX_CLK25_DIVIDER_BINARY = 5'b01000;
      10 : TX_CLK25_DIVIDER_BINARY = 5'b01001;
      11 : TX_CLK25_DIVIDER_BINARY = 5'b01010;
      12 : TX_CLK25_DIVIDER_BINARY = 5'b01011;
      13 : TX_CLK25_DIVIDER_BINARY = 5'b01100;
      14 : TX_CLK25_DIVIDER_BINARY = 5'b01101;
      15 : TX_CLK25_DIVIDER_BINARY = 5'b01110;
      16 : TX_CLK25_DIVIDER_BINARY = 5'b01111;
      17 : TX_CLK25_DIVIDER_BINARY = 5'b10000;
      18 : TX_CLK25_DIVIDER_BINARY = 5'b10001;
      19 : TX_CLK25_DIVIDER_BINARY = 5'b10010;
      20 : TX_CLK25_DIVIDER_BINARY = 5'b10011;
      21 : TX_CLK25_DIVIDER_BINARY = 5'b10100;
      22 : TX_CLK25_DIVIDER_BINARY = 5'b10101;
      23 : TX_CLK25_DIVIDER_BINARY = 5'b10110;
      24 : TX_CLK25_DIVIDER_BINARY = 5'b10111;
      25 : TX_CLK25_DIVIDER_BINARY = 5'b11000;
      26 : TX_CLK25_DIVIDER_BINARY = 5'b11001;
      27 : TX_CLK25_DIVIDER_BINARY = 5'b11010;
      28 : TX_CLK25_DIVIDER_BINARY = 5'b11011;
      29 : TX_CLK25_DIVIDER_BINARY = 5'b11100;
      30 : TX_CLK25_DIVIDER_BINARY = 5'b11101;
      31 : TX_CLK25_DIVIDER_BINARY = 5'b11110;
      32 : TX_CLK25_DIVIDER_BINARY = 5'b11111;
      default : begin
        $display("Attribute Syntax Error : The Attribute TX_CLK25_DIVIDER on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are 1 to 32.", TX_CLK25_DIVIDER, 6);
        $finish;
      end
    endcase

    case (TX_CLK_SOURCE)
      "RXPLL" : TX_CLK_SOURCE_BINARY = 1'b1;
      "TXPLL" : TX_CLK_SOURCE_BINARY = 1'b0;
      default : begin
	 $display("Attribute Syntax Error : The Attribute TX_CLK_SOURCE on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are RXPLL, or TXPLL.", TX_CLK_SOURCE);
        $finish;
      end
    endcase

    case (TX_DATA_WIDTH)
      20 : TX_DATA_WIDTH_BINARY = 3'b011;
      8 : TX_DATA_WIDTH_BINARY = 3'b000;
      10 : TX_DATA_WIDTH_BINARY = 3'b001;
      16 : TX_DATA_WIDTH_BINARY = 3'b010;
      32 : TX_DATA_WIDTH_BINARY = 3'b100;
      40 : TX_DATA_WIDTH_BINARY = 3'b101;
      default : begin
        $display("Attribute Syntax Error : The Attribute TX_DATA_WIDTH on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are 8 to 40.", TX_DATA_WIDTH, 20);
        $finish;
      end
    endcase

    case (TX_DRIVE_MODE)
      "DIRECT" : TX_DRIVE_MODE_BINARY = 1'b0;
      "PIPE" : TX_DRIVE_MODE_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute TX_DRIVE_MODE on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are DIRECT, or PIPE.", TX_DRIVE_MODE);
        $finish;
      end
    endcase

    case (TX_EN_RATE_RESET_BUF)
      "FALSE" : TX_EN_RATE_RESET_BUF_BINARY = 1'b0;
      "TRUE" : TX_EN_RATE_RESET_BUF_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute TX_EN_RATE_RESET_BUF on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", TX_EN_RATE_RESET_BUF);
        $finish;
      end
    endcase

    case (TX_OVERSAMPLE_MODE)
      "FALSE" : TX_OVERSAMPLE_MODE_BINARY = 1'b0;
      "TRUE" : TX_OVERSAMPLE_MODE_BINARY = 1'b1;
      default : begin
        $display("Attribute Syntax Error : The Attribute TX_OVERSAMPLE_MODE on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TRUE or FALSE.", TX_OVERSAMPLE_MODE);
        $finish;
      end
    endcase

    case (TX_XCLK_SEL)
      "TXUSR" : TX_XCLK_SEL_BINARY = 1'b1;
      "TXOUT" : TX_XCLK_SEL_BINARY = 1'b0;
      default : begin
        $display("Attribute Syntax Error : The Attribute TX_XCLK_SEL on X_GTXE1 instance %m is set to %s.  Legal values for this attribute are TXUSR, or TXOUT.", TX_XCLK_SEL);
        $finish;
      end
    endcase

    if ((BGTEST_CFG >= 0) && (BGTEST_CFG <= 3))
      BGTEST_CFG_BINARY = BGTEST_CFG;
    else begin
      $display("Attribute Syntax Error : The Attribute BGTEST_CFG on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 3.", BGTEST_CFG);
      $finish;
    end

    if ((CDR_PH_ADJ_TIME >= 0) && (CDR_PH_ADJ_TIME <= 31))
      CDR_PH_ADJ_TIME_BINARY = CDR_PH_ADJ_TIME;
    else begin
      $display("Attribute Syntax Error : The Attribute CDR_PH_ADJ_TIME on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 31.", CDR_PH_ADJ_TIME);
      $finish;
    end

    if ((CHAN_BOND_1_MAX_SKEW >= 1) && (CHAN_BOND_1_MAX_SKEW <= 14))
      CHAN_BOND_1_MAX_SKEW_BINARY = CHAN_BOND_1_MAX_SKEW;
    else begin
      $display("Attribute Syntax Error : The Attribute CHAN_BOND_1_MAX_SKEW on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  1 to 14.", CHAN_BOND_1_MAX_SKEW);
      $finish;
    end

    if ((CHAN_BOND_2_MAX_SKEW >= 1) && (CHAN_BOND_2_MAX_SKEW <= 14))
      CHAN_BOND_2_MAX_SKEW_BINARY = CHAN_BOND_2_MAX_SKEW;
    else begin
      $display("Attribute Syntax Error : The Attribute CHAN_BOND_2_MAX_SKEW on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  1 to 14.", CHAN_BOND_2_MAX_SKEW);
      $finish;
    end

    if ((CHAN_BOND_SEQ_1_1 >= 0) && (CHAN_BOND_SEQ_1_1 <= 1023))
      CHAN_BOND_SEQ_1_1_BINARY = CHAN_BOND_SEQ_1_1;
    else begin
      $display("Attribute Syntax Error : The Attribute CHAN_BOND_SEQ_1_1 on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 1023.", CHAN_BOND_SEQ_1_1);
      $finish;
    end

    if ((CHAN_BOND_SEQ_1_2 >= 0) && (CHAN_BOND_SEQ_1_2 <= 1023))
      CHAN_BOND_SEQ_1_2_BINARY = CHAN_BOND_SEQ_1_2;
    else begin
      $display("Attribute Syntax Error : The Attribute CHAN_BOND_SEQ_1_2 on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 1023.", CHAN_BOND_SEQ_1_2);
      $finish;
    end

    if ((CHAN_BOND_SEQ_1_3 >= 0) && (CHAN_BOND_SEQ_1_3 <= 1023))
      CHAN_BOND_SEQ_1_3_BINARY = CHAN_BOND_SEQ_1_3;
    else begin
      $display("Attribute Syntax Error : The Attribute CHAN_BOND_SEQ_1_3 on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 1023.", CHAN_BOND_SEQ_1_3);
      $finish;
    end

    if ((CHAN_BOND_SEQ_1_4 >= 0) && (CHAN_BOND_SEQ_1_4 <= 1023))
      CHAN_BOND_SEQ_1_4_BINARY = CHAN_BOND_SEQ_1_4;
    else begin
      $display("Attribute Syntax Error : The Attribute CHAN_BOND_SEQ_1_4 on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 1023.", CHAN_BOND_SEQ_1_4);
      $finish;
    end

    if ((CHAN_BOND_SEQ_1_ENABLE >= 0) && (CHAN_BOND_SEQ_1_ENABLE <= 15))
      CHAN_BOND_SEQ_1_ENABLE_BINARY = CHAN_BOND_SEQ_1_ENABLE;
    else begin
      $display("Attribute Syntax Error : The Attribute CHAN_BOND_SEQ_1_ENABLE on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 15.", CHAN_BOND_SEQ_1_ENABLE);
      $finish;
    end

    if ((CHAN_BOND_SEQ_2_1 >= 0) && (CHAN_BOND_SEQ_2_1 <= 1023))
      CHAN_BOND_SEQ_2_1_BINARY = CHAN_BOND_SEQ_2_1;
    else begin
      $display("Attribute Syntax Error : The Attribute CHAN_BOND_SEQ_2_1 on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 1023.", CHAN_BOND_SEQ_2_1);
      $finish;
    end

    if ((CHAN_BOND_SEQ_2_2 >= 0) && (CHAN_BOND_SEQ_2_2 <= 1023))
      CHAN_BOND_SEQ_2_2_BINARY = CHAN_BOND_SEQ_2_2;
    else begin
      $display("Attribute Syntax Error : The Attribute CHAN_BOND_SEQ_2_2 on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 1023.", CHAN_BOND_SEQ_2_2);
      $finish;
    end

    if ((CHAN_BOND_SEQ_2_3 >= 0) && (CHAN_BOND_SEQ_2_3 <= 1023))
      CHAN_BOND_SEQ_2_3_BINARY = CHAN_BOND_SEQ_2_3;
    else begin
      $display("Attribute Syntax Error : The Attribute CHAN_BOND_SEQ_2_3 on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 1023.", CHAN_BOND_SEQ_2_3);
      $finish;
    end

    if ((CHAN_BOND_SEQ_2_4 >= 0) && (CHAN_BOND_SEQ_2_4 <= 1023))
      CHAN_BOND_SEQ_2_4_BINARY = CHAN_BOND_SEQ_2_4;
    else begin
      $display("Attribute Syntax Error : The Attribute CHAN_BOND_SEQ_2_4 on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 1023.", CHAN_BOND_SEQ_2_4);
      $finish;
    end

    if ((CHAN_BOND_SEQ_2_CFG >= 0) && (CHAN_BOND_SEQ_2_CFG <= 31))
      CHAN_BOND_SEQ_2_CFG_BINARY = CHAN_BOND_SEQ_2_CFG;
    else begin
      $display("Attribute Syntax Error : The Attribute CHAN_BOND_SEQ_2_CFG on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 31.", CHAN_BOND_SEQ_2_CFG);
      $finish;
    end

    if ((CHAN_BOND_SEQ_2_ENABLE >= 0) && (CHAN_BOND_SEQ_2_ENABLE <= 15))
      CHAN_BOND_SEQ_2_ENABLE_BINARY = CHAN_BOND_SEQ_2_ENABLE;
    else begin
      $display("Attribute Syntax Error : The Attribute CHAN_BOND_SEQ_2_ENABLE on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 15.", CHAN_BOND_SEQ_2_ENABLE);
      $finish;
    end

    if ((CLK_COR_MAX_LAT >= 3) && (CLK_COR_MAX_LAT <= 48))
      CLK_COR_MAX_LAT_BINARY = CLK_COR_MAX_LAT;
    else begin
      $display("Attribute Syntax Error : The Attribute CLK_COR_MAX_LAT on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  3 to 48.", CLK_COR_MAX_LAT);
      $finish;
    end

    if ((CLK_COR_MIN_LAT >= 3) && (CLK_COR_MIN_LAT <= 48))
      CLK_COR_MIN_LAT_BINARY = CLK_COR_MIN_LAT;
    else begin
      $display("Attribute Syntax Error : The Attribute CLK_COR_MIN_LAT on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  3 to 48.", CLK_COR_MIN_LAT);
      $finish;
    end

    if ((CLK_COR_REPEAT_WAIT >= 0) && (CLK_COR_REPEAT_WAIT <= 31))
      CLK_COR_REPEAT_WAIT_BINARY = CLK_COR_REPEAT_WAIT;
    else begin
      $display("Attribute Syntax Error : The Attribute CLK_COR_REPEAT_WAIT on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 31.", CLK_COR_REPEAT_WAIT);
      $finish;
    end

    if ((CLK_COR_SEQ_1_1 >= 0) && (CLK_COR_SEQ_1_1 <= 1023))
      CLK_COR_SEQ_1_1_BINARY = CLK_COR_SEQ_1_1;
    else begin
      $display("Attribute Syntax Error : The Attribute CLK_COR_SEQ_1_1 on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 1023.", CLK_COR_SEQ_1_1);
      $finish;
    end

    if ((CLK_COR_SEQ_1_2 >= 0) && (CLK_COR_SEQ_1_2 <= 1023))
      CLK_COR_SEQ_1_2_BINARY = CLK_COR_SEQ_1_2;
    else begin
      $display("Attribute Syntax Error : The Attribute CLK_COR_SEQ_1_2 on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 1023.", CLK_COR_SEQ_1_2);
      $finish;
    end

    if ((CLK_COR_SEQ_1_3 >= 0) && (CLK_COR_SEQ_1_3 <= 1023))
      CLK_COR_SEQ_1_3_BINARY = CLK_COR_SEQ_1_3;
    else begin
      $display("Attribute Syntax Error : The Attribute CLK_COR_SEQ_1_3 on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 1023.", CLK_COR_SEQ_1_3);
      $finish;
    end

    if ((CLK_COR_SEQ_1_4 >= 0) && (CLK_COR_SEQ_1_4 <= 1023))
      CLK_COR_SEQ_1_4_BINARY = CLK_COR_SEQ_1_4;
    else begin
      $display("Attribute Syntax Error : The Attribute CLK_COR_SEQ_1_4 on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 1023.", CLK_COR_SEQ_1_4);
      $finish;
    end

    if ((CLK_COR_SEQ_1_ENABLE >= 0) && (CLK_COR_SEQ_1_ENABLE <= 15))
      CLK_COR_SEQ_1_ENABLE_BINARY = CLK_COR_SEQ_1_ENABLE;
    else begin
      $display("Attribute Syntax Error : The Attribute CLK_COR_SEQ_1_ENABLE on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 15.", CLK_COR_SEQ_1_ENABLE);
      $finish;
    end

    if ((CLK_COR_SEQ_2_1 >= 0) && (CLK_COR_SEQ_2_1 <= 1023))
      CLK_COR_SEQ_2_1_BINARY = CLK_COR_SEQ_2_1;
    else begin
      $display("Attribute Syntax Error : The Attribute CLK_COR_SEQ_2_1 on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 1023.", CLK_COR_SEQ_2_1);
      $finish;
    end

    if ((CLK_COR_SEQ_2_2 >= 0) && (CLK_COR_SEQ_2_2 <= 1023))
      CLK_COR_SEQ_2_2_BINARY = CLK_COR_SEQ_2_2;
    else begin
      $display("Attribute Syntax Error : The Attribute CLK_COR_SEQ_2_2 on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 1023.", CLK_COR_SEQ_2_2);
      $finish;
    end

    if ((CLK_COR_SEQ_2_3 >= 0) && (CLK_COR_SEQ_2_3 <= 1023))
      CLK_COR_SEQ_2_3_BINARY = CLK_COR_SEQ_2_3;
    else begin
      $display("Attribute Syntax Error : The Attribute CLK_COR_SEQ_2_3 on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 1023.", CLK_COR_SEQ_2_3);
      $finish;
    end

    if ((CLK_COR_SEQ_2_4 >= 0) && (CLK_COR_SEQ_2_4 <= 1023))
      CLK_COR_SEQ_2_4_BINARY = CLK_COR_SEQ_2_4;
    else begin
      $display("Attribute Syntax Error : The Attribute CLK_COR_SEQ_2_4 on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 1023.", CLK_COR_SEQ_2_4);
      $finish;
    end

    if ((CLK_COR_SEQ_2_ENABLE >= 0) && (CLK_COR_SEQ_2_ENABLE <= 15))
      CLK_COR_SEQ_2_ENABLE_BINARY = CLK_COR_SEQ_2_ENABLE;
    else begin
      $display("Attribute Syntax Error : The Attribute CLK_COR_SEQ_2_ENABLE on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 15.", CLK_COR_SEQ_2_ENABLE);
      $finish;
    end

    if ((CM_TRIM >= 0) && (CM_TRIM <= 3))
      CM_TRIM_BINARY = CM_TRIM;
    else begin
      $display("Attribute Syntax Error : The Attribute CM_TRIM on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 3.", CM_TRIM);
      $finish;
    end

    if ((COMMA_10B_ENABLE >= 0) && (COMMA_10B_ENABLE <= 1023))
      COMMA_10B_ENABLE_BINARY = COMMA_10B_ENABLE;
    else begin
      $display("Attribute Syntax Error : The Attribute COMMA_10B_ENABLE on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 1023.", COMMA_10B_ENABLE);
      $finish;
    end

    if ((COM_BURST_VAL >= 0) && (COM_BURST_VAL <= 15))
      COM_BURST_VAL_BINARY = COM_BURST_VAL;
    else begin
      $display("Attribute Syntax Error : The Attribute COM_BURST_VAL on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 15.", COM_BURST_VAL);
      $finish;
    end

    if ((DFE_CAL_TIME >= 0) && (DFE_CAL_TIME <= 31))
      DFE_CAL_TIME_BINARY = DFE_CAL_TIME;
    else begin
      $display("Attribute Syntax Error : The Attribute DFE_CAL_TIME on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 31.", DFE_CAL_TIME);
      $finish;
    end

    if ((DFE_CFG >= 0) && (DFE_CFG <= 255))
      DFE_CFG_BINARY = DFE_CFG;
    else begin
      $display("Attribute Syntax Error : The Attribute DFE_CFG on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 255.", DFE_CFG);
      $finish;
    end

    if ((GEARBOX_ENDEC >= 0) && (GEARBOX_ENDEC <= 7))
      GEARBOX_ENDEC_BINARY = GEARBOX_ENDEC;
    else begin
      $display("Attribute Syntax Error : The Attribute GEARBOX_ENDEC on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 7.", GEARBOX_ENDEC);
      $finish;
    end

    if ((MCOMMA_10B_VALUE >= 0) && (MCOMMA_10B_VALUE <= 1023))
      MCOMMA_10B_VALUE_BINARY = MCOMMA_10B_VALUE;
    else begin
      $display("Attribute Syntax Error : The Attribute MCOMMA_10B_VALUE on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 1023.", MCOMMA_10B_VALUE);
      $finish;
    end

    if ((OOBDETECT_THRESHOLD >= 0) && (OOBDETECT_THRESHOLD <= 7))
      OOBDETECT_THRESHOLD_BINARY = OOBDETECT_THRESHOLD;
    else begin
      $display("Attribute Syntax Error : The Attribute OOBDETECT_THRESHOLD on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 7.", OOBDETECT_THRESHOLD);
      $finish;
    end

    if ((PCOMMA_10B_VALUE >= 0) && (PCOMMA_10B_VALUE <= 1023))
      PCOMMA_10B_VALUE_BINARY = PCOMMA_10B_VALUE;
    else begin
      $display("Attribute Syntax Error : The Attribute PCOMMA_10B_VALUE on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 1023.", PCOMMA_10B_VALUE);
      $finish;
    end

    if ((POWER_SAVE >= 0) && (POWER_SAVE <= 1023))
      POWER_SAVE_BINARY = POWER_SAVE;
    else begin
      $display("Attribute Syntax Error : The Attribute POWER_SAVE on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 1023.", POWER_SAVE);
      $finish;
    end

    if ((RXPLL_LKDET_CFG >= 0) && (RXPLL_LKDET_CFG <= 7))
      RXPLL_LKDET_CFG_BINARY = RXPLL_LKDET_CFG;
    else begin
      $display("Attribute Syntax Error : The Attribute RXPLL_LKDET_CFG on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 7.", RXPLL_LKDET_CFG);
      $finish;
    end
    
    if ((RXPRBSERR_LOOPBACK >= 0) && (RXPRBSERR_LOOPBACK <= 1))
      RXPRBSERR_LOOPBACK_BINARY = RXPRBSERR_LOOPBACK;
    else begin
      $display("Attribute Syntax Error : The Attribute RXPRBSERR_LOOPBACK on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 1.", RXPRBSERR_LOOPBACK);
      $finish;
    end
      
    if ((RXRECCLK_DLY >= 0) && (RXRECCLK_DLY <= 1023))
      RXRECCLK_DLY_BINARY = RXRECCLK_DLY;
    else begin
      $display("Attribute Syntax Error : The Attribute RXRECCLK_DLY on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 1023.", RXRECCLK_DLY);
      $finish;
    end

    if ((RX_DLYALIGN_CTRINC >= 0) && (RX_DLYALIGN_CTRINC <= 15))
      RX_DLYALIGN_CTRINC_BINARY = RX_DLYALIGN_CTRINC;
    else begin
      $display("Attribute Syntax Error : The Attribute RX_DLYALIGN_CTRINC on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 15.", RX_DLYALIGN_CTRINC);
      $finish;
    end

    if ((RX_DLYALIGN_EDGESET >= 0) && (RX_DLYALIGN_EDGESET <= 31))
      RX_DLYALIGN_EDGESET_BINARY = RX_DLYALIGN_EDGESET;
    else begin
      $display("Attribute Syntax Error : The Attribute RX_DLYALIGN_EDGESET on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 31.", RX_DLYALIGN_EDGESET);
      $finish;
    end

    if ((RX_DLYALIGN_LPFINC >= 0) && (RX_DLYALIGN_LPFINC <= 15))
      RX_DLYALIGN_LPFINC_BINARY = RX_DLYALIGN_LPFINC;
    else begin
      $display("Attribute Syntax Error : The Attribute RX_DLYALIGN_LPFINC on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 15.", RX_DLYALIGN_LPFINC);
      $finish;
    end

    if ((RX_DLYALIGN_MONSEL >= 0) && (RX_DLYALIGN_MONSEL <= 7))
      RX_DLYALIGN_MONSEL_BINARY = RX_DLYALIGN_MONSEL;
    else begin
      $display("Attribute Syntax Error : The Attribute RX_DLYALIGN_MONSEL on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 7.", RX_DLYALIGN_MONSEL);
      $finish;
    end

    if ((RX_DLYALIGN_OVRDSETTING >= 0) && (RX_DLYALIGN_OVRDSETTING <= 255))
      RX_DLYALIGN_OVRDSETTING_BINARY = RX_DLYALIGN_OVRDSETTING;
    else begin
      $display("Attribute Syntax Error : The Attribute RX_DLYALIGN_OVRDSETTING on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 255.", RX_DLYALIGN_OVRDSETTING);
      $finish;
    end

    if ((RX_EYE_SCANMODE >= 0) && (RX_EYE_SCANMODE <= 3))
      RX_EYE_SCANMODE_BINARY = RX_EYE_SCANMODE;
    else begin
      $display("Attribute Syntax Error : The Attribute RX_EYE_SCANMODE on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 3.", RX_EYE_SCANMODE);
      $finish;
    end

    if ((RX_IDLE_HI_CNT >= 0) && (RX_IDLE_HI_CNT <= 15))
      RX_IDLE_HI_CNT_BINARY = RX_IDLE_HI_CNT;
    else begin
      $display("Attribute Syntax Error : The Attribute RX_IDLE_HI_CNT on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 15.", RX_IDLE_HI_CNT);
      $finish;
    end

    if ((RX_IDLE_LO_CNT >= 0) && (RX_IDLE_LO_CNT <= 15))
      RX_IDLE_LO_CNT_BINARY = RX_IDLE_LO_CNT;
    else begin
      $display("Attribute Syntax Error : The Attribute RX_IDLE_LO_CNT on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 15.", RX_IDLE_LO_CNT);
      $finish;
    end

    if ((RX_SLIDE_AUTO_WAIT >= 0) && (RX_SLIDE_AUTO_WAIT <= 15))
      RX_SLIDE_AUTO_WAIT_BINARY = RX_SLIDE_AUTO_WAIT;
    else begin
      $display("Attribute Syntax Error : The Attribute RX_SLIDE_AUTO_WAIT on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 15.", RX_SLIDE_AUTO_WAIT);
      $finish;
    end

    if ((SAS_MAX_COMSAS >= 1) && (SAS_MAX_COMSAS <= 61))
      SAS_MAX_COMSAS_BINARY = SAS_MAX_COMSAS;
    else begin
      $display("Attribute Syntax Error : The Attribute SAS_MAX_COMSAS on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  1 to 61.", SAS_MAX_COMSAS);
      $finish;
    end

    if ((SAS_MIN_COMSAS >= 1) && (SAS_MIN_COMSAS <= 61))
      SAS_MIN_COMSAS_BINARY = SAS_MIN_COMSAS;
    else begin
      $display("Attribute Syntax Error : The Attribute SAS_MIN_COMSAS on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  1 to 61.", SAS_MIN_COMSAS);
      $finish;
    end

    if ((SATA_BURST_VAL >= 0) && (SATA_BURST_VAL <= 7))
      SATA_BURST_VAL_BINARY = SATA_BURST_VAL;
    else begin
      $display("Attribute Syntax Error : The Attribute SATA_BURST_VAL on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 7.", SATA_BURST_VAL);
      $finish;
    end

    if ((SATA_IDLE_VAL >= 0) && (SATA_IDLE_VAL <= 7))
      SATA_IDLE_VAL_BINARY = SATA_IDLE_VAL;
    else begin
      $display("Attribute Syntax Error : The Attribute SATA_IDLE_VAL on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 7.", SATA_IDLE_VAL);
      $finish;
    end

    if ((SATA_MAX_BURST >= 1) && (SATA_MAX_BURST <= 61))
      SATA_MAX_BURST_BINARY = SATA_MAX_BURST;
    else begin
      $display("Attribute Syntax Error : The Attribute SATA_MAX_BURST on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  1 to 61.", SATA_MAX_BURST);
      $finish;
    end

    if ((SATA_MAX_INIT >= 1) && (SATA_MAX_INIT <= 61))
      SATA_MAX_INIT_BINARY = SATA_MAX_INIT;
    else begin
      $display("Attribute Syntax Error : The Attribute SATA_MAX_INIT on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  1 to 61.", SATA_MAX_INIT);
      $finish;
    end

    if ((SATA_MAX_WAKE >= 1) && (SATA_MAX_WAKE <= 61))
      SATA_MAX_WAKE_BINARY = SATA_MAX_WAKE;
    else begin
      $display("Attribute Syntax Error : The Attribute SATA_MAX_WAKE on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  1 to 61.", SATA_MAX_WAKE);
      $finish;
    end

    if ((SATA_MIN_BURST >= 1) && (SATA_MIN_BURST <= 61))
      SATA_MIN_BURST_BINARY = SATA_MIN_BURST;
    else begin
      $display("Attribute Syntax Error : The Attribute SATA_MIN_BURST on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  1 to 61.", SATA_MIN_BURST);
      $finish;
    end

    if ((SATA_MIN_INIT >= 1) && (SATA_MIN_INIT <= 61))
      SATA_MIN_INIT_BINARY = SATA_MIN_INIT;
    else begin
      $display("Attribute Syntax Error : The Attribute SATA_MIN_INIT on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  1 to 61.", SATA_MIN_INIT);
      $finish;
    end

    if ((SATA_MIN_WAKE >= 1) && (SATA_MIN_WAKE <= 61))
      SATA_MIN_WAKE_BINARY = SATA_MIN_WAKE;
    else begin
      $display("Attribute Syntax Error : The Attribute SATA_MIN_WAKE on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  1 to 61.", SATA_MIN_WAKE);
      $finish;
    end

    if ((SIM_RXREFCLK_SOURCE >= 0) && (SIM_RXREFCLK_SOURCE <= 7))
      SIM_RXREFCLK_SOURCE_BINARY = SIM_RXREFCLK_SOURCE;
    else begin
      $display("Attribute Syntax Error : The Attribute SIM_RXREFCLK_SOURCE on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 7.", SIM_RXREFCLK_SOURCE);
      $finish;
    end

    if ((SIM_TXREFCLK_SOURCE >= 0) && (SIM_TXREFCLK_SOURCE <= 7))
      SIM_TXREFCLK_SOURCE_BINARY = SIM_TXREFCLK_SOURCE;
    else begin
      $display("Attribute Syntax Error : The Attribute SIM_TXREFCLK_SOURCE on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 7.", SIM_TXREFCLK_SOURCE);
      $finish;
    end

    if ((TERMINATION_CTRL >= 0) && (TERMINATION_CTRL <= 31))
      TERMINATION_CTRL_BINARY = TERMINATION_CTRL;
    else begin
      $display("Attribute Syntax Error : The Attribute TERMINATION_CTRL on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 31.", TERMINATION_CTRL);
      $finish;
    end

    if ((TXOUTCLK_DLY >= 0) && (TXOUTCLK_DLY <= 1023))
      TXOUTCLK_DLY_BINARY = TXOUTCLK_DLY;
    else begin
      $display("Attribute Syntax Error : The Attribute TXOUTCLK_DLY on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 1023.", TXOUTCLK_DLY);
      $finish;
    end

    if ((TXPLL_LKDET_CFG >= 0) && (TXPLL_LKDET_CFG <= 7))
      TXPLL_LKDET_CFG_BINARY = TXPLL_LKDET_CFG;
    else begin
      $display("Attribute Syntax Error : The Attribute TXPLL_LKDET_CFG on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 7.", TXPLL_LKDET_CFG);
      $finish;
    end

    if ((TXPLL_SATA >= 0) && (TXPLL_SATA <= 3))
      TXPLL_SATA_BINARY = TXPLL_SATA;
    else begin
      $display("Attribute Syntax Error : The Attribute TXPLL_SATA on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 3.", TXPLL_SATA);
      $finish;
    end

    if ((TX_DEEMPH_0 >= 0) && (TX_DEEMPH_0 <= 31))
      TX_DEEMPH_0_BINARY = TX_DEEMPH_0;
    else begin
      $display("Attribute Syntax Error : The Attribute TX_DEEMPH_0 on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 31.", TX_DEEMPH_0);
      $finish;
    end

    if ((TX_DEEMPH_1 >= 0) && (TX_DEEMPH_1 <= 31))
      TX_DEEMPH_1_BINARY = TX_DEEMPH_1;
    else begin
      $display("Attribute Syntax Error : The Attribute TX_DEEMPH_1 on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 31.", TX_DEEMPH_1);
      $finish;
    end

    if ((TX_DLYALIGN_CTRINC >= 0) && (TX_DLYALIGN_CTRINC <= 15))
      TX_DLYALIGN_CTRINC_BINARY = TX_DLYALIGN_CTRINC;
    else begin
      $display("Attribute Syntax Error : The Attribute TX_DLYALIGN_CTRINC on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 15.", TX_DLYALIGN_CTRINC);
      $finish;
    end

    if ((TX_DLYALIGN_LPFINC >= 0) && (TX_DLYALIGN_LPFINC <= 15))
      TX_DLYALIGN_LPFINC_BINARY = TX_DLYALIGN_LPFINC;
    else begin
      $display("Attribute Syntax Error : The Attribute TX_DLYALIGN_LPFINC on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 15.", TX_DLYALIGN_LPFINC);
      $finish;
    end

    if ((TX_DLYALIGN_MONSEL >= 0) && (TX_DLYALIGN_MONSEL <= 7))
      TX_DLYALIGN_MONSEL_BINARY = TX_DLYALIGN_MONSEL;
    else begin
      $display("Attribute Syntax Error : The Attribute TX_DLYALIGN_MONSEL on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 7.", TX_DLYALIGN_MONSEL);
      $finish;
    end

    if ((TX_DLYALIGN_OVRDSETTING >= 0) && (TX_DLYALIGN_OVRDSETTING <= 255))
      TX_DLYALIGN_OVRDSETTING_BINARY = TX_DLYALIGN_OVRDSETTING;
    else begin
      $display("Attribute Syntax Error : The Attribute TX_DLYALIGN_OVRDSETTING on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 255.", TX_DLYALIGN_OVRDSETTING);
      $finish;
    end

    if ((TX_IDLE_ASSERT_DELAY >= 0) && (TX_IDLE_ASSERT_DELAY <= 7))
      TX_IDLE_ASSERT_DELAY_BINARY = TX_IDLE_ASSERT_DELAY;
    else begin
      $display("Attribute Syntax Error : The Attribute TX_IDLE_ASSERT_DELAY on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 7.", TX_IDLE_ASSERT_DELAY);
      $finish;
    end

    if ((TX_IDLE_DEASSERT_DELAY >= 0) && (TX_IDLE_DEASSERT_DELAY <= 7))
      TX_IDLE_DEASSERT_DELAY_BINARY = TX_IDLE_DEASSERT_DELAY;
    else begin
      $display("Attribute Syntax Error : The Attribute TX_IDLE_DEASSERT_DELAY on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 7.", TX_IDLE_DEASSERT_DELAY);
      $finish;
    end

    if ((TX_MARGIN_FULL_0 >= 0) && (TX_MARGIN_FULL_0 <= 127))
      TX_MARGIN_FULL_0_BINARY = TX_MARGIN_FULL_0;
    else begin
      $display("Attribute Syntax Error : The Attribute TX_MARGIN_FULL_0 on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 127.", TX_MARGIN_FULL_0);
      $finish;
    end

    if ((TX_MARGIN_FULL_1 >= 0) && (TX_MARGIN_FULL_1 <= 127))
      TX_MARGIN_FULL_1_BINARY = TX_MARGIN_FULL_1;
    else begin
      $display("Attribute Syntax Error : The Attribute TX_MARGIN_FULL_1 on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 127.", TX_MARGIN_FULL_1);
      $finish;
    end

    if ((TX_MARGIN_FULL_2 >= 0) && (TX_MARGIN_FULL_2 <= 127))
      TX_MARGIN_FULL_2_BINARY = TX_MARGIN_FULL_2;
    else begin
      $display("Attribute Syntax Error : The Attribute TX_MARGIN_FULL_2 on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 127.", TX_MARGIN_FULL_2);
      $finish;
    end

    if ((TX_MARGIN_FULL_3 >= 0) && (TX_MARGIN_FULL_3 <= 127))
      TX_MARGIN_FULL_3_BINARY = TX_MARGIN_FULL_3;
    else begin
      $display("Attribute Syntax Error : The Attribute TX_MARGIN_FULL_3 on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 127.", TX_MARGIN_FULL_3);
      $finish;
    end

    if ((TX_MARGIN_FULL_4 >= 0) && (TX_MARGIN_FULL_4 <= 127))
      TX_MARGIN_FULL_4_BINARY = TX_MARGIN_FULL_4;
    else begin
      $display("Attribute Syntax Error : The Attribute TX_MARGIN_FULL_4 on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 127.", TX_MARGIN_FULL_4);
      $finish;
    end

    if ((TX_MARGIN_LOW_0 >= 0) && (TX_MARGIN_LOW_0 <= 127))
      TX_MARGIN_LOW_0_BINARY = TX_MARGIN_LOW_0;
    else begin
      $display("Attribute Syntax Error : The Attribute TX_MARGIN_LOW_0 on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 127.", TX_MARGIN_LOW_0);
      $finish;
    end

    if ((TX_MARGIN_LOW_1 >= 0) && (TX_MARGIN_LOW_1 <= 127))
      TX_MARGIN_LOW_1_BINARY = TX_MARGIN_LOW_1;
    else begin
      $display("Attribute Syntax Error : The Attribute TX_MARGIN_LOW_1 on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 127.", TX_MARGIN_LOW_1);
      $finish;
    end

    if ((TX_MARGIN_LOW_2 >= 0) && (TX_MARGIN_LOW_2 <= 127))
      TX_MARGIN_LOW_2_BINARY = TX_MARGIN_LOW_2;
    else begin
      $display("Attribute Syntax Error : The Attribute TX_MARGIN_LOW_2 on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 127.", TX_MARGIN_LOW_2);
      $finish;
    end

    if ((TX_MARGIN_LOW_3 >= 0) && (TX_MARGIN_LOW_3 <= 127))
      TX_MARGIN_LOW_3_BINARY = TX_MARGIN_LOW_3;
    else begin
      $display("Attribute Syntax Error : The Attribute TX_MARGIN_LOW_3 on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 127.", TX_MARGIN_LOW_3);
      $finish;
    end

    if ((TX_MARGIN_LOW_4 >= 0) && (TX_MARGIN_LOW_4 <= 127))
      TX_MARGIN_LOW_4_BINARY = TX_MARGIN_LOW_4;
    else begin
      $display("Attribute Syntax Error : The Attribute TX_MARGIN_LOW_4 on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 127.", TX_MARGIN_LOW_4);
      $finish;
    end

    if ((TX_PMADATA_OPT >= 0) && (TX_PMADATA_OPT <= 1))
      TX_PMADATA_OPT_BINARY = TX_PMADATA_OPT;
    else begin
      $display("Attribute Syntax Error : The Attribute TX_PMADATA_OPT on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 1.", TX_PMADATA_OPT);
      $finish;
    end

    if ((TX_TDCC_CFG >= 0) && (TX_TDCC_CFG <= 3))
      TX_TDCC_CFG_BINARY = TX_TDCC_CFG;
    else begin
      $display("Attribute Syntax Error : The Attribute TX_TDCC_CFG on X_GTXE1 instance %m is set to %d.  Legal values for this attribute are  0 to 3.", TX_TDCC_CFG);
      $finish;
    end

  end
/*
  buf B_COMFINISH (COMFINISH, COMFINISH_OUT);
  buf B_COMINITDET (COMINITDET, COMINITDET_OUT);
  buf B_COMSASDET (COMSASDET, COMSASDET_OUT);
  buf B_COMWAKEDET (COMWAKEDET, COMWAKEDET_OUT);
  buf B_DFECLKDLYADJMON0 (DFECLKDLYADJMON[0], DFECLKDLYADJMON_OUT[0]);
  buf B_DFECLKDLYADJMON1 (DFECLKDLYADJMON[1], DFECLKDLYADJMON_OUT[1]);
  buf B_DFECLKDLYADJMON2 (DFECLKDLYADJMON[2], DFECLKDLYADJMON_OUT[2]);
  buf B_DFECLKDLYADJMON3 (DFECLKDLYADJMON[3], DFECLKDLYADJMON_OUT[3]);
  buf B_DFECLKDLYADJMON4 (DFECLKDLYADJMON[4], DFECLKDLYADJMON_OUT[4]);
  buf B_DFECLKDLYADJMON5 (DFECLKDLYADJMON[5], DFECLKDLYADJMON_OUT[5]);
  buf B_DFEEYEDACMON0 (DFEEYEDACMON[0], DFEEYEDACMON_OUT[0]);
  buf B_DFEEYEDACMON1 (DFEEYEDACMON[1], DFEEYEDACMON_OUT[1]);
  buf B_DFEEYEDACMON2 (DFEEYEDACMON[2], DFEEYEDACMON_OUT[2]);
  buf B_DFEEYEDACMON3 (DFEEYEDACMON[3], DFEEYEDACMON_OUT[3]);
  buf B_DFEEYEDACMON4 (DFEEYEDACMON[4], DFEEYEDACMON_OUT[4]);
  buf B_DFESENSCAL0 (DFESENSCAL[0], DFESENSCAL_OUT[0]);
  buf B_DFESENSCAL1 (DFESENSCAL[1], DFESENSCAL_OUT[1]);
  buf B_DFESENSCAL2 (DFESENSCAL[2], DFESENSCAL_OUT[2]);
  buf B_DFETAP1MONITOR0 (DFETAP1MONITOR[0], DFETAP1MONITOR_OUT[0]);
  buf B_DFETAP1MONITOR1 (DFETAP1MONITOR[1], DFETAP1MONITOR_OUT[1]);
  buf B_DFETAP1MONITOR2 (DFETAP1MONITOR[2], DFETAP1MONITOR_OUT[2]);
  buf B_DFETAP1MONITOR3 (DFETAP1MONITOR[3], DFETAP1MONITOR_OUT[3]);
  buf B_DFETAP1MONITOR4 (DFETAP1MONITOR[4], DFETAP1MONITOR_OUT[4]);
  buf B_DFETAP2MONITOR0 (DFETAP2MONITOR[0], DFETAP2MONITOR_OUT[0]);
  buf B_DFETAP2MONITOR1 (DFETAP2MONITOR[1], DFETAP2MONITOR_OUT[1]);
  buf B_DFETAP2MONITOR2 (DFETAP2MONITOR[2], DFETAP2MONITOR_OUT[2]);
  buf B_DFETAP2MONITOR3 (DFETAP2MONITOR[3], DFETAP2MONITOR_OUT[3]);
  buf B_DFETAP2MONITOR4 (DFETAP2MONITOR[4], DFETAP2MONITOR_OUT[4]);
  buf B_DFETAP3MONITOR0 (DFETAP3MONITOR[0], DFETAP3MONITOR_OUT[0]);
  buf B_DFETAP3MONITOR1 (DFETAP3MONITOR[1], DFETAP3MONITOR_OUT[1]);
  buf B_DFETAP3MONITOR2 (DFETAP3MONITOR[2], DFETAP3MONITOR_OUT[2]);
  buf B_DFETAP3MONITOR3 (DFETAP3MONITOR[3], DFETAP3MONITOR_OUT[3]);
  buf B_DFETAP4MONITOR0 (DFETAP4MONITOR[0], DFETAP4MONITOR_OUT[0]);
  buf B_DFETAP4MONITOR1 (DFETAP4MONITOR[1], DFETAP4MONITOR_OUT[1]);
  buf B_DFETAP4MONITOR2 (DFETAP4MONITOR[2], DFETAP4MONITOR_OUT[2]);
  buf B_DFETAP4MONITOR3 (DFETAP4MONITOR[3], DFETAP4MONITOR_OUT[3]);
  buf B_DRDY (DRDY, DRDY_OUT);
  buf B_DRPDO0 (DRPDO[0], DRPDO_OUT[0]);
  buf B_DRPDO1 (DRPDO[1], DRPDO_OUT[1]);
  buf B_DRPDO10 (DRPDO[10], DRPDO_OUT[10]);
  buf B_DRPDO11 (DRPDO[11], DRPDO_OUT[11]);
  buf B_DRPDO12 (DRPDO[12], DRPDO_OUT[12]);
  buf B_DRPDO13 (DRPDO[13], DRPDO_OUT[13]);
  buf B_DRPDO14 (DRPDO[14], DRPDO_OUT[14]);
  buf B_DRPDO15 (DRPDO[15], DRPDO_OUT[15]);
  buf B_DRPDO2 (DRPDO[2], DRPDO_OUT[2]);
  buf B_DRPDO3 (DRPDO[3], DRPDO_OUT[3]);
  buf B_DRPDO4 (DRPDO[4], DRPDO_OUT[4]);
  buf B_DRPDO5 (DRPDO[5], DRPDO_OUT[5]);
  buf B_DRPDO6 (DRPDO[6], DRPDO_OUT[6]);
  buf B_DRPDO7 (DRPDO[7], DRPDO_OUT[7]);
  buf B_DRPDO8 (DRPDO[8], DRPDO_OUT[8]);
  buf B_DRPDO9 (DRPDO[9], DRPDO_OUT[9]);
  buf B_MGTREFCLKFAB0 (MGTREFCLKFAB[0], MGTREFCLKFAB_OUT[0]);
  buf B_MGTREFCLKFAB1 (MGTREFCLKFAB[1], MGTREFCLKFAB_OUT[1]);
  buf B_PHYSTATUS (PHYSTATUS, PHYSTATUS_OUT);
  buf B_RXBUFSTATUS0 (RXBUFSTATUS[0], RXBUFSTATUS_OUT[0]);
  buf B_RXBUFSTATUS1 (RXBUFSTATUS[1], RXBUFSTATUS_OUT[1]);
  buf B_RXBUFSTATUS2 (RXBUFSTATUS[2], RXBUFSTATUS_OUT[2]);
  buf B_RXBYTEISALIGNED (RXBYTEISALIGNED, RXBYTEISALIGNED_OUT);
  buf B_RXBYTEREALIGN (RXBYTEREALIGN, RXBYTEREALIGN_OUT);
  buf B_RXCHANBONDSEQ (RXCHANBONDSEQ, RXCHANBONDSEQ_OUT);
  buf B_RXCHANISALIGNED (RXCHANISALIGNED, RXCHANISALIGNED_OUT);
  buf B_RXCHANREALIGN (RXCHANREALIGN, RXCHANREALIGN_OUT);
  buf B_RXCHARISCOMMA0 (RXCHARISCOMMA[0], RXCHARISCOMMA_OUT[0]);
  buf B_RXCHARISCOMMA1 (RXCHARISCOMMA[1], RXCHARISCOMMA_OUT[1]);
  buf B_RXCHARISCOMMA2 (RXCHARISCOMMA[2], RXCHARISCOMMA_OUT[2]);
  buf B_RXCHARISCOMMA3 (RXCHARISCOMMA[3], RXCHARISCOMMA_OUT[3]);
  buf B_RXCHARISK0 (RXCHARISK[0], RXCHARISK_OUT[0]);
  buf B_RXCHARISK1 (RXCHARISK[1], RXCHARISK_OUT[1]);
  buf B_RXCHARISK2 (RXCHARISK[2], RXCHARISK_OUT[2]);
  buf B_RXCHARISK3 (RXCHARISK[3], RXCHARISK_OUT[3]);
  buf B_RXCHBONDO0 (RXCHBONDO[0], RXCHBONDO_OUT[0]);
  buf B_RXCHBONDO1 (RXCHBONDO[1], RXCHBONDO_OUT[1]);
  buf B_RXCHBONDO2 (RXCHBONDO[2], RXCHBONDO_OUT[2]);
  buf B_RXCHBONDO3 (RXCHBONDO[3], RXCHBONDO_OUT[3]);
  buf B_RXCLKCORCNT0 (RXCLKCORCNT[0], RXCLKCORCNT_OUT[0]);
  buf B_RXCLKCORCNT1 (RXCLKCORCNT[1], RXCLKCORCNT_OUT[1]);
  buf B_RXCLKCORCNT2 (RXCLKCORCNT[2], RXCLKCORCNT_OUT[2]);
  buf B_RXCOMMADET (RXCOMMADET, RXCOMMADET_OUT);
  buf B_RXDATA0 (RXDATA[0], RXDATA_OUT[0]);
  buf B_RXDATA1 (RXDATA[1], RXDATA_OUT[1]);
  buf B_RXDATA10 (RXDATA[10], RXDATA_OUT[10]);
  buf B_RXDATA11 (RXDATA[11], RXDATA_OUT[11]);
  buf B_RXDATA12 (RXDATA[12], RXDATA_OUT[12]);
  buf B_RXDATA13 (RXDATA[13], RXDATA_OUT[13]);
  buf B_RXDATA14 (RXDATA[14], RXDATA_OUT[14]);
  buf B_RXDATA15 (RXDATA[15], RXDATA_OUT[15]);
  buf B_RXDATA16 (RXDATA[16], RXDATA_OUT[16]);
  buf B_RXDATA17 (RXDATA[17], RXDATA_OUT[17]);
  buf B_RXDATA18 (RXDATA[18], RXDATA_OUT[18]);
  buf B_RXDATA19 (RXDATA[19], RXDATA_OUT[19]);
  buf B_RXDATA2 (RXDATA[2], RXDATA_OUT[2]);
  buf B_RXDATA20 (RXDATA[20], RXDATA_OUT[20]);
  buf B_RXDATA21 (RXDATA[21], RXDATA_OUT[21]);
  buf B_RXDATA22 (RXDATA[22], RXDATA_OUT[22]);
  buf B_RXDATA23 (RXDATA[23], RXDATA_OUT[23]);
  buf B_RXDATA24 (RXDATA[24], RXDATA_OUT[24]);
  buf B_RXDATA25 (RXDATA[25], RXDATA_OUT[25]);
  buf B_RXDATA26 (RXDATA[26], RXDATA_OUT[26]);
  buf B_RXDATA27 (RXDATA[27], RXDATA_OUT[27]);
  buf B_RXDATA28 (RXDATA[28], RXDATA_OUT[28]);
  buf B_RXDATA29 (RXDATA[29], RXDATA_OUT[29]);
  buf B_RXDATA3 (RXDATA[3], RXDATA_OUT[3]);
  buf B_RXDATA30 (RXDATA[30], RXDATA_OUT[30]);
  buf B_RXDATA31 (RXDATA[31], RXDATA_OUT[31]);
  buf B_RXDATA4 (RXDATA[4], RXDATA_OUT[4]);
  buf B_RXDATA5 (RXDATA[5], RXDATA_OUT[5]);
  buf B_RXDATA6 (RXDATA[6], RXDATA_OUT[6]);
  buf B_RXDATA7 (RXDATA[7], RXDATA_OUT[7]);
  buf B_RXDATA8 (RXDATA[8], RXDATA_OUT[8]);
  buf B_RXDATA9 (RXDATA[9], RXDATA_OUT[9]);
  buf B_RXDATAVALID (RXDATAVALID, RXDATAVALID_OUT);
  buf B_RXDISPERR0 (RXDISPERR[0], RXDISPERR_OUT[0]);
  buf B_RXDISPERR1 (RXDISPERR[1], RXDISPERR_OUT[1]);
  buf B_RXDISPERR2 (RXDISPERR[2], RXDISPERR_OUT[2]);
  buf B_RXDISPERR3 (RXDISPERR[3], RXDISPERR_OUT[3]);
  buf B_RXDLYALIGNMONITOR0 (RXDLYALIGNMONITOR[0], RXDLYALIGNMONITOR_OUT[0]);
  buf B_RXDLYALIGNMONITOR1 (RXDLYALIGNMONITOR[1], RXDLYALIGNMONITOR_OUT[1]);
  buf B_RXDLYALIGNMONITOR2 (RXDLYALIGNMONITOR[2], RXDLYALIGNMONITOR_OUT[2]);
  buf B_RXDLYALIGNMONITOR3 (RXDLYALIGNMONITOR[3], RXDLYALIGNMONITOR_OUT[3]);
  buf B_RXDLYALIGNMONITOR4 (RXDLYALIGNMONITOR[4], RXDLYALIGNMONITOR_OUT[4]);
  buf B_RXDLYALIGNMONITOR5 (RXDLYALIGNMONITOR[5], RXDLYALIGNMONITOR_OUT[5]);
  buf B_RXDLYALIGNMONITOR6 (RXDLYALIGNMONITOR[6], RXDLYALIGNMONITOR_OUT[6]);
  buf B_RXDLYALIGNMONITOR7 (RXDLYALIGNMONITOR[7], RXDLYALIGNMONITOR_OUT[7]);
  buf B_RXELECIDLE (RXELECIDLE, RXELECIDLE_OUT);
  buf B_RXHEADER0 (RXHEADER[0], RXHEADER_OUT[0]);
  buf B_RXHEADER1 (RXHEADER[1], RXHEADER_OUT[1]);
  buf B_RXHEADER2 (RXHEADER[2], RXHEADER_OUT[2]);
  buf B_RXHEADERVALID (RXHEADERVALID, RXHEADERVALID_OUT);
  buf B_RXLOSSOFSYNC0 (RXLOSSOFSYNC[0], RXLOSSOFSYNC_OUT[0]);
  buf B_RXLOSSOFSYNC1 (RXLOSSOFSYNC[1], RXLOSSOFSYNC_OUT[1]);
  buf B_RXNOTINTABLE0 (RXNOTINTABLE[0], RXNOTINTABLE_OUT[0]);
  buf B_RXNOTINTABLE1 (RXNOTINTABLE[1], RXNOTINTABLE_OUT[1]);
  buf B_RXNOTINTABLE2 (RXNOTINTABLE[2], RXNOTINTABLE_OUT[2]);
  buf B_RXNOTINTABLE3 (RXNOTINTABLE[3], RXNOTINTABLE_OUT[3]);
  buf B_RXOVERSAMPLEERR (RXOVERSAMPLEERR, RXOVERSAMPLEERR_OUT);
  buf B_RXPLLLKDET (RXPLLLKDET, RXPLLLKDET_OUT);
  buf B_RXPRBSERR (RXPRBSERR, RXPRBSERR_OUT);
  buf B_RXRATEDONE (RXRATEDONE, RXRATEDONE_OUT);
  buf B_RXRECCLK (RXRECCLK, RXRECCLK_OUT);
  buf B_RXRECCLKPCS (RXRECCLKPCS, RXRECCLKPCS_OUT);
  buf B_RXRESETDONE (RXRESETDONE, RXRESETDONE_OUT);
  buf B_RXRUNDISP0 (RXRUNDISP[0], RXRUNDISP_OUT[0]);
  buf B_RXRUNDISP1 (RXRUNDISP[1], RXRUNDISP_OUT[1]);
  buf B_RXRUNDISP2 (RXRUNDISP[2], RXRUNDISP_OUT[2]);
  buf B_RXRUNDISP3 (RXRUNDISP[3], RXRUNDISP_OUT[3]);
  buf B_RXSTARTOFSEQ (RXSTARTOFSEQ, RXSTARTOFSEQ_OUT);
  buf B_RXSTATUS0 (RXSTATUS[0], RXSTATUS_OUT[0]);
  buf B_RXSTATUS1 (RXSTATUS[1], RXSTATUS_OUT[1]);
  buf B_RXSTATUS2 (RXSTATUS[2], RXSTATUS_OUT[2]);
  buf B_RXVALID (RXVALID, RXVALID_OUT);
  buf B_TSTOUT0 (TSTOUT[0], TSTOUT_OUT[0]);
  buf B_TSTOUT1 (TSTOUT[1], TSTOUT_OUT[1]);
  buf B_TSTOUT2 (TSTOUT[2], TSTOUT_OUT[2]);
  buf B_TSTOUT3 (TSTOUT[3], TSTOUT_OUT[3]);
  buf B_TSTOUT4 (TSTOUT[4], TSTOUT_OUT[4]);
  buf B_TSTOUT5 (TSTOUT[5], TSTOUT_OUT[5]);
  buf B_TSTOUT6 (TSTOUT[6], TSTOUT_OUT[6]);
  buf B_TSTOUT7 (TSTOUT[7], TSTOUT_OUT[7]);
  buf B_TSTOUT8 (TSTOUT[8], TSTOUT_OUT[8]);
  buf B_TSTOUT9 (TSTOUT[9], TSTOUT_OUT[9]);
  buf B_TXBUFSTATUS0 (TXBUFSTATUS[0], TXBUFSTATUS_OUT[0]);
  buf B_TXBUFSTATUS1 (TXBUFSTATUS[1], TXBUFSTATUS_OUT[1]);
  buf B_TXDLYALIGNMONITOR0 (TXDLYALIGNMONITOR[0], TXDLYALIGNMONITOR_OUT[0]);
  buf B_TXDLYALIGNMONITOR1 (TXDLYALIGNMONITOR[1], TXDLYALIGNMONITOR_OUT[1]);
  buf B_TXDLYALIGNMONITOR2 (TXDLYALIGNMONITOR[2], TXDLYALIGNMONITOR_OUT[2]);
  buf B_TXDLYALIGNMONITOR3 (TXDLYALIGNMONITOR[3], TXDLYALIGNMONITOR_OUT[3]);
  buf B_TXDLYALIGNMONITOR4 (TXDLYALIGNMONITOR[4], TXDLYALIGNMONITOR_OUT[4]);
  buf B_TXDLYALIGNMONITOR5 (TXDLYALIGNMONITOR[5], TXDLYALIGNMONITOR_OUT[5]);
  buf B_TXDLYALIGNMONITOR6 (TXDLYALIGNMONITOR[6], TXDLYALIGNMONITOR_OUT[6]);
  buf B_TXDLYALIGNMONITOR7 (TXDLYALIGNMONITOR[7], TXDLYALIGNMONITOR_OUT[7]);
  buf B_TXGEARBOXREADY (TXGEARBOXREADY, TXGEARBOXREADY_OUT);
  buf B_TXKERR0 (TXKERR[0], TXKERR_OUT[0]);
  buf B_TXKERR1 (TXKERR[1], TXKERR_OUT[1]);
  buf B_TXKERR2 (TXKERR[2], TXKERR_OUT[2]);
  buf B_TXKERR3 (TXKERR[3], TXKERR_OUT[3]);
  buf B_TXN (TXN, TXN_OUT);
  buf B_TXOUTCLK (TXOUTCLK, TXOUTCLK_OUT);
  buf B_TXOUTCLKPCS (TXOUTCLKPCS, TXOUTCLKPCS_OUT);
  buf B_TXP (TXP, TXP_OUT);
  buf B_TXPLLLKDET (TXPLLLKDET, TXPLLLKDET_OUT);
  buf B_TXRATEDONE (TXRATEDONE, TXRATEDONE_OUT);
  buf B_TXRESETDONE (TXRESETDONE, TXRESETDONE_OUT);
  buf B_TXRUNDISP0 (TXRUNDISP[0], TXRUNDISP_OUT[0]);
  buf B_TXRUNDISP1 (TXRUNDISP[1], TXRUNDISP_OUT[1]);
  buf B_TXRUNDISP2 (TXRUNDISP[2], TXRUNDISP_OUT[2]);
  buf B_TXRUNDISP3 (TXRUNDISP[3], TXRUNDISP_OUT[3]);

  buf B_DADDR0 (DADDR_IN[0], DADDR[0]);
  buf B_DADDR1 (DADDR_IN[1], DADDR[1]);
  buf B_DADDR2 (DADDR_IN[2], DADDR[2]);
  buf B_DADDR3 (DADDR_IN[3], DADDR[3]);
  buf B_DADDR4 (DADDR_IN[4], DADDR[4]);
  buf B_DADDR5 (DADDR_IN[5], DADDR[5]);
  buf B_DADDR6 (DADDR_IN[6], DADDR[6]);
  buf B_DADDR7 (DADDR_IN[7], DADDR[7]);
  buf B_DCLK (DCLK_IN, DCLK);
  buf B_DEN (DEN_IN, DEN);
  buf B_DFECLKDLYADJ0 (DFECLKDLYADJ_IN[0], DFECLKDLYADJ[0]);
  buf B_DFECLKDLYADJ1 (DFECLKDLYADJ_IN[1], DFECLKDLYADJ[1]);
  buf B_DFECLKDLYADJ2 (DFECLKDLYADJ_IN[2], DFECLKDLYADJ[2]);
  buf B_DFECLKDLYADJ3 (DFECLKDLYADJ_IN[3], DFECLKDLYADJ[3]);
  buf B_DFECLKDLYADJ4 (DFECLKDLYADJ_IN[4], DFECLKDLYADJ[4]);
  buf B_DFECLKDLYADJ5 (DFECLKDLYADJ_IN[5], DFECLKDLYADJ[5]);
  buf B_DFEDLYOVRD (DFEDLYOVRD_IN, DFEDLYOVRD);
  buf B_DFETAP10 (DFETAP1_IN[0], DFETAP1[0]);
  buf B_DFETAP11 (DFETAP1_IN[1], DFETAP1[1]);
  buf B_DFETAP12 (DFETAP1_IN[2], DFETAP1[2]);
  buf B_DFETAP13 (DFETAP1_IN[3], DFETAP1[3]);
  buf B_DFETAP14 (DFETAP1_IN[4], DFETAP1[4]);
  buf B_DFETAP20 (DFETAP2_IN[0], DFETAP2[0]);
  buf B_DFETAP21 (DFETAP2_IN[1], DFETAP2[1]);
  buf B_DFETAP22 (DFETAP2_IN[2], DFETAP2[2]);
  buf B_DFETAP23 (DFETAP2_IN[3], DFETAP2[3]);
  buf B_DFETAP24 (DFETAP2_IN[4], DFETAP2[4]);
  buf B_DFETAP30 (DFETAP3_IN[0], DFETAP3[0]);
  buf B_DFETAP31 (DFETAP3_IN[1], DFETAP3[1]);
  buf B_DFETAP32 (DFETAP3_IN[2], DFETAP3[2]);
  buf B_DFETAP33 (DFETAP3_IN[3], DFETAP3[3]);
  buf B_DFETAP40 (DFETAP4_IN[0], DFETAP4[0]);
  buf B_DFETAP41 (DFETAP4_IN[1], DFETAP4[1]);
  buf B_DFETAP42 (DFETAP4_IN[2], DFETAP4[2]);
  buf B_DFETAP43 (DFETAP4_IN[3], DFETAP4[3]);
  buf B_DFETAPOVRD (DFETAPOVRD_IN, DFETAPOVRD);
  buf B_DI0 (DI_IN[0], DI[0]);
  buf B_DI1 (DI_IN[1], DI[1]);
  buf B_DI10 (DI_IN[10], DI[10]);
  buf B_DI11 (DI_IN[11], DI[11]);
  buf B_DI12 (DI_IN[12], DI[12]);
  buf B_DI13 (DI_IN[13], DI[13]);
  buf B_DI14 (DI_IN[14], DI[14]);
  buf B_DI15 (DI_IN[15], DI[15]);
  buf B_DI2 (DI_IN[2], DI[2]);
  buf B_DI3 (DI_IN[3], DI[3]);
  buf B_DI4 (DI_IN[4], DI[4]);
  buf B_DI5 (DI_IN[5], DI[5]);
  buf B_DI6 (DI_IN[6], DI[6]);
  buf B_DI7 (DI_IN[7], DI[7]);
  buf B_DI8 (DI_IN[8], DI[8]);
  buf B_DI9 (DI_IN[9], DI[9]);
  buf B_DWE (DWE_IN, DWE);
  buf B_GATERXELECIDLE (GATERXELECIDLE_IN, GATERXELECIDLE);
  buf B_GREFCLKRX (GREFCLKRX_IN, GREFCLKRX);
  buf B_GREFCLKTX (GREFCLKTX_IN, GREFCLKTX);
  buf B_GTXRXRESET (GTXRXRESET_IN, GTXRXRESET);
  buf B_GTXTEST0 (GTXTEST_IN[0], GTXTEST[0]);
  buf B_GTXTEST1 (GTXTEST_IN[1], GTXTEST[1]);
  buf B_GTXTEST10 (GTXTEST_IN[10], GTXTEST[10]);
  buf B_GTXTEST11 (GTXTEST_IN[11], GTXTEST[11]);
  buf B_GTXTEST12 (GTXTEST_IN[12], GTXTEST[12]);
  buf B_GTXTEST2 (GTXTEST_IN[2], GTXTEST[2]);
  buf B_GTXTEST3 (GTXTEST_IN[3], GTXTEST[3]);
  buf B_GTXTEST4 (GTXTEST_IN[4], GTXTEST[4]);
  buf B_GTXTEST5 (GTXTEST_IN[5], GTXTEST[5]);
  buf B_GTXTEST6 (GTXTEST_IN[6], GTXTEST[6]);
  buf B_GTXTEST7 (GTXTEST_IN[7], GTXTEST[7]);
  buf B_GTXTEST8 (GTXTEST_IN[8], GTXTEST[8]);
  buf B_GTXTEST9 (GTXTEST_IN[9], GTXTEST[9]);
  buf B_GTXTXRESET (GTXTXRESET_IN, GTXTXRESET);
  buf B_IGNORESIGDET (IGNORESIGDET_IN, IGNORESIGDET);
  buf B_LOOPBACK0 (LOOPBACK_IN[0], LOOPBACK[0]);
  buf B_LOOPBACK1 (LOOPBACK_IN[1], LOOPBACK[1]);
  buf B_LOOPBACK2 (LOOPBACK_IN[2], LOOPBACK[2]);
  buf B_MGTREFCLKRX0 (MGTREFCLKRX_IN[0], MGTREFCLKRX[0]);
  buf B_MGTREFCLKRX1 (MGTREFCLKRX_IN[1], MGTREFCLKRX[1]);
  buf B_MGTREFCLKTX0 (MGTREFCLKTX_IN[0], MGTREFCLKTX[0]);
  buf B_MGTREFCLKTX1 (MGTREFCLKTX_IN[1], MGTREFCLKTX[1]);
  buf B_NORTHREFCLKRX0 (NORTHREFCLKRX_IN[0], NORTHREFCLKRX[0]);
  buf B_NORTHREFCLKRX1 (NORTHREFCLKRX_IN[1], NORTHREFCLKRX[1]);
  buf B_NORTHREFCLKTX0 (NORTHREFCLKTX_IN[0], NORTHREFCLKTX[0]);
  buf B_NORTHREFCLKTX1 (NORTHREFCLKTX_IN[1], NORTHREFCLKTX[1]);
  buf B_PERFCLKRX (PERFCLKRX_IN, PERFCLKRX);
  buf B_PERFCLKTX (PERFCLKTX_IN, PERFCLKTX);
  buf B_PLLRXRESET (PLLRXRESET_IN, PLLRXRESET);
  buf B_PLLTXRESET (PLLTXRESET_IN, PLLTXRESET);
  buf B_PRBSCNTRESET (PRBSCNTRESET_IN, PRBSCNTRESET);
  buf B_RXBUFRESET (RXBUFRESET_IN, RXBUFRESET);
  buf B_RXCDRRESET (RXCDRRESET_IN, RXCDRRESET);
  buf B_RXCHBONDI0 (RXCHBONDI_IN[0], RXCHBONDI[0]);
  buf B_RXCHBONDI1 (RXCHBONDI_IN[1], RXCHBONDI[1]);
  buf B_RXCHBONDI2 (RXCHBONDI_IN[2], RXCHBONDI[2]);
  buf B_RXCHBONDI3 (RXCHBONDI_IN[3], RXCHBONDI[3]);
  buf B_RXCHBONDLEVEL0 (RXCHBONDLEVEL_IN[0], RXCHBONDLEVEL[0]);
  buf B_RXCHBONDLEVEL1 (RXCHBONDLEVEL_IN[1], RXCHBONDLEVEL[1]);
  buf B_RXCHBONDLEVEL2 (RXCHBONDLEVEL_IN[2], RXCHBONDLEVEL[2]);
  buf B_RXCHBONDMASTER (RXCHBONDMASTER_IN, RXCHBONDMASTER);
  buf B_RXCHBONDSLAVE (RXCHBONDSLAVE_IN, RXCHBONDSLAVE);
  buf B_RXCOMMADETUSE (RXCOMMADETUSE_IN, RXCOMMADETUSE);
  buf B_RXDEC8B10BUSE (RXDEC8B10BUSE_IN, RXDEC8B10BUSE);
  buf B_RXDLYALIGNDISABLE (RXDLYALIGNDISABLE_IN, RXDLYALIGNDISABLE);
  buf B_RXDLYALIGNMONENB (RXDLYALIGNMONENB_IN, RXDLYALIGNMONENB);
  buf B_RXDLYALIGNOVERRIDE (RXDLYALIGNOVERRIDE_IN, RXDLYALIGNOVERRIDE);
  buf B_RXDLYALIGNRESET (RXDLYALIGNRESET_IN, RXDLYALIGNRESET);
  buf B_RXDLYALIGNSWPPRECURB (RXDLYALIGNSWPPRECURB_IN, RXDLYALIGNSWPPRECURB);
  buf B_RXDLYALIGNUPDSW (RXDLYALIGNUPDSW_IN, RXDLYALIGNUPDSW);
  buf B_RXENCHANSYNC (RXENCHANSYNC_IN, RXENCHANSYNC);
  buf B_RXENMCOMMAALIGN (RXENMCOMMAALIGN_IN, RXENMCOMMAALIGN);
  buf B_RXENPCOMMAALIGN (RXENPCOMMAALIGN_IN, RXENPCOMMAALIGN);
  buf B_RXENPMAPHASEALIGN (RXENPMAPHASEALIGN_IN, RXENPMAPHASEALIGN);
  buf B_RXENPRBSTST0 (RXENPRBSTST_IN[0], RXENPRBSTST[0]);
  buf B_RXENPRBSTST1 (RXENPRBSTST_IN[1], RXENPRBSTST[1]);
  buf B_RXENPRBSTST2 (RXENPRBSTST_IN[2], RXENPRBSTST[2]);
  buf B_RXENSAMPLEALIGN (RXENSAMPLEALIGN_IN, RXENSAMPLEALIGN);
  buf B_RXEQMIX0 (RXEQMIX_IN[0], RXEQMIX[0]);
  buf B_RXEQMIX1 (RXEQMIX_IN[1], RXEQMIX[1]);
  buf B_RXEQMIX2 (RXEQMIX_IN[2], RXEQMIX[2]);
  buf B_RXEQMIX3 (RXEQMIX_IN[3], RXEQMIX[3]);
  buf B_RXEQMIX4 (RXEQMIX_IN[4], RXEQMIX[4]);
  buf B_RXEQMIX5 (RXEQMIX_IN[5], RXEQMIX[5]);
  buf B_RXEQMIX6 (RXEQMIX_IN[6], RXEQMIX[6]);
  buf B_RXEQMIX7 (RXEQMIX_IN[7], RXEQMIX[7]);
  buf B_RXEQMIX8 (RXEQMIX_IN[8], RXEQMIX[8]);
  buf B_RXEQMIX9 (RXEQMIX_IN[9], RXEQMIX[9]);
  buf B_RXGEARBOXSLIP (RXGEARBOXSLIP_IN, RXGEARBOXSLIP);
  buf B_RXN (RXN_IN, RXN);
  buf B_RXP (RXP_IN, RXP);
  buf B_RXPLLLKDETEN (RXPLLLKDETEN_IN, RXPLLLKDETEN);
  buf B_RXPLLPOWERDOWN (RXPLLPOWERDOWN_IN, RXPLLPOWERDOWN);
  buf B_RXPLLREFSELDY0 (RXPLLREFSELDY_IN[0], RXPLLREFSELDY[0]);
  buf B_RXPLLREFSELDY1 (RXPLLREFSELDY_IN[1], RXPLLREFSELDY[1]);
  buf B_RXPLLREFSELDY2 (RXPLLREFSELDY_IN[2], RXPLLREFSELDY[2]);
  buf B_RXPMASETPHASE (RXPMASETPHASE_IN, RXPMASETPHASE);
  buf B_RXPOLARITY (RXPOLARITY_IN, RXPOLARITY);
  buf B_RXPOWERDOWN0 (RXPOWERDOWN_IN[0], RXPOWERDOWN[0]);
  buf B_RXPOWERDOWN1 (RXPOWERDOWN_IN[1], RXPOWERDOWN[1]);
  buf B_RXRATE0 (RXRATE_IN[0], RXRATE[0]);
  buf B_RXRATE1 (RXRATE_IN[1], RXRATE[1]);
  buf B_RXRESET (RXRESET_IN, RXRESET);
  buf B_RXSLIDE (RXSLIDE_IN, RXSLIDE);
  buf B_RXUSRCLK (RXUSRCLK_IN, RXUSRCLK);
  buf B_RXUSRCLK2 (RXUSRCLK2_IN, RXUSRCLK2);
  buf B_SOUTHREFCLKRX0 (SOUTHREFCLKRX_IN[0], SOUTHREFCLKRX[0]);
  buf B_SOUTHREFCLKRX1 (SOUTHREFCLKRX_IN[1], SOUTHREFCLKRX[1]);
  buf B_SOUTHREFCLKTX0 (SOUTHREFCLKTX_IN[0], SOUTHREFCLKTX[0]);
  buf B_SOUTHREFCLKTX1 (SOUTHREFCLKTX_IN[1], SOUTHREFCLKTX[1]);
  buf B_TSTCLK0 (TSTCLK0_IN, TSTCLK0);
  buf B_TSTCLK1 (TSTCLK1_IN, TSTCLK1);
  buf B_TSTIN0 (TSTIN_IN[0], TSTIN[0]);
  buf B_TSTIN1 (TSTIN_IN[1], TSTIN[1]);
  buf B_TSTIN10 (TSTIN_IN[10], TSTIN[10]);
  buf B_TSTIN11 (TSTIN_IN[11], TSTIN[11]);
  buf B_TSTIN12 (TSTIN_IN[12], TSTIN[12]);
  buf B_TSTIN13 (TSTIN_IN[13], TSTIN[13]);
  buf B_TSTIN14 (TSTIN_IN[14], TSTIN[14]);
  buf B_TSTIN15 (TSTIN_IN[15], TSTIN[15]);
  buf B_TSTIN16 (TSTIN_IN[16], TSTIN[16]);
  buf B_TSTIN17 (TSTIN_IN[17], TSTIN[17]);
  buf B_TSTIN18 (TSTIN_IN[18], TSTIN[18]);
  buf B_TSTIN19 (TSTIN_IN[19], TSTIN[19]);
  buf B_TSTIN2 (TSTIN_IN[2], TSTIN[2]);
  buf B_TSTIN3 (TSTIN_IN[3], TSTIN[3]);
  buf B_TSTIN4 (TSTIN_IN[4], TSTIN[4]);
  buf B_TSTIN5 (TSTIN_IN[5], TSTIN[5]);
  buf B_TSTIN6 (TSTIN_IN[6], TSTIN[6]);
  buf B_TSTIN7 (TSTIN_IN[7], TSTIN[7]);
  buf B_TSTIN8 (TSTIN_IN[8], TSTIN[8]);
  buf B_TSTIN9 (TSTIN_IN[9], TSTIN[9]);
  buf B_TXBUFDIFFCTRL0 (TXBUFDIFFCTRL_IN[0], TXBUFDIFFCTRL[0]);
  buf B_TXBUFDIFFCTRL1 (TXBUFDIFFCTRL_IN[1], TXBUFDIFFCTRL[1]);
  buf B_TXBUFDIFFCTRL2 (TXBUFDIFFCTRL_IN[2], TXBUFDIFFCTRL[2]);
  buf B_TXBYPASS8B10B0 (TXBYPASS8B10B_IN[0], TXBYPASS8B10B[0]);
  buf B_TXBYPASS8B10B1 (TXBYPASS8B10B_IN[1], TXBYPASS8B10B[1]);
  buf B_TXBYPASS8B10B2 (TXBYPASS8B10B_IN[2], TXBYPASS8B10B[2]);
  buf B_TXBYPASS8B10B3 (TXBYPASS8B10B_IN[3], TXBYPASS8B10B[3]);
  buf B_TXCHARDISPMODE0 (TXCHARDISPMODE_IN[0], TXCHARDISPMODE[0]);
  buf B_TXCHARDISPMODE1 (TXCHARDISPMODE_IN[1], TXCHARDISPMODE[1]);
  buf B_TXCHARDISPMODE2 (TXCHARDISPMODE_IN[2], TXCHARDISPMODE[2]);
  buf B_TXCHARDISPMODE3 (TXCHARDISPMODE_IN[3], TXCHARDISPMODE[3]);
  buf B_TXCHARDISPVAL0 (TXCHARDISPVAL_IN[0], TXCHARDISPVAL[0]);
  buf B_TXCHARDISPVAL1 (TXCHARDISPVAL_IN[1], TXCHARDISPVAL[1]);
  buf B_TXCHARDISPVAL2 (TXCHARDISPVAL_IN[2], TXCHARDISPVAL[2]);
  buf B_TXCHARDISPVAL3 (TXCHARDISPVAL_IN[3], TXCHARDISPVAL[3]);
  buf B_TXCHARISK0 (TXCHARISK_IN[0], TXCHARISK[0]);
  buf B_TXCHARISK1 (TXCHARISK_IN[1], TXCHARISK[1]);
  buf B_TXCHARISK2 (TXCHARISK_IN[2], TXCHARISK[2]);
  buf B_TXCHARISK3 (TXCHARISK_IN[3], TXCHARISK[3]);
  buf B_TXCOMINIT (TXCOMINIT_IN, TXCOMINIT);
  buf B_TXCOMSAS (TXCOMSAS_IN, TXCOMSAS);
  buf B_TXCOMWAKE (TXCOMWAKE_IN, TXCOMWAKE);
  buf B_TXDATA0 (TXDATA_IN[0], TXDATA[0]);
  buf B_TXDATA1 (TXDATA_IN[1], TXDATA[1]);
  buf B_TXDATA10 (TXDATA_IN[10], TXDATA[10]);
  buf B_TXDATA11 (TXDATA_IN[11], TXDATA[11]);
  buf B_TXDATA12 (TXDATA_IN[12], TXDATA[12]);
  buf B_TXDATA13 (TXDATA_IN[13], TXDATA[13]);
  buf B_TXDATA14 (TXDATA_IN[14], TXDATA[14]);
  buf B_TXDATA15 (TXDATA_IN[15], TXDATA[15]);
  buf B_TXDATA16 (TXDATA_IN[16], TXDATA[16]);
  buf B_TXDATA17 (TXDATA_IN[17], TXDATA[17]);
  buf B_TXDATA18 (TXDATA_IN[18], TXDATA[18]);
  buf B_TXDATA19 (TXDATA_IN[19], TXDATA[19]);
  buf B_TXDATA2 (TXDATA_IN[2], TXDATA[2]);
  buf B_TXDATA20 (TXDATA_IN[20], TXDATA[20]);
  buf B_TXDATA21 (TXDATA_IN[21], TXDATA[21]);
  buf B_TXDATA22 (TXDATA_IN[22], TXDATA[22]);
  buf B_TXDATA23 (TXDATA_IN[23], TXDATA[23]);
  buf B_TXDATA24 (TXDATA_IN[24], TXDATA[24]);
  buf B_TXDATA25 (TXDATA_IN[25], TXDATA[25]);
  buf B_TXDATA26 (TXDATA_IN[26], TXDATA[26]);
  buf B_TXDATA27 (TXDATA_IN[27], TXDATA[27]);
  buf B_TXDATA28 (TXDATA_IN[28], TXDATA[28]);
  buf B_TXDATA29 (TXDATA_IN[29], TXDATA[29]);
  buf B_TXDATA3 (TXDATA_IN[3], TXDATA[3]);
  buf B_TXDATA30 (TXDATA_IN[30], TXDATA[30]);
  buf B_TXDATA31 (TXDATA_IN[31], TXDATA[31]);
  buf B_TXDATA4 (TXDATA_IN[4], TXDATA[4]);
  buf B_TXDATA5 (TXDATA_IN[5], TXDATA[5]);
  buf B_TXDATA6 (TXDATA_IN[6], TXDATA[6]);
  buf B_TXDATA7 (TXDATA_IN[7], TXDATA[7]);
  buf B_TXDATA8 (TXDATA_IN[8], TXDATA[8]);
  buf B_TXDATA9 (TXDATA_IN[9], TXDATA[9]);
  buf B_TXDEEMPH (TXDEEMPH_IN, TXDEEMPH);
  buf B_TXDETECTRX (TXDETECTRX_IN, TXDETECTRX);
  buf B_TXDIFFCTRL0 (TXDIFFCTRL_IN[0], TXDIFFCTRL[0]);
  buf B_TXDIFFCTRL1 (TXDIFFCTRL_IN[1], TXDIFFCTRL[1]);
  buf B_TXDIFFCTRL2 (TXDIFFCTRL_IN[2], TXDIFFCTRL[2]);
  buf B_TXDIFFCTRL3 (TXDIFFCTRL_IN[3], TXDIFFCTRL[3]);
  buf B_TXDLYALIGNDISABLE (TXDLYALIGNDISABLE_IN, TXDLYALIGNDISABLE);
  buf B_TXDLYALIGNMONENB (TXDLYALIGNMONENB_IN, TXDLYALIGNMONENB);
  buf B_TXDLYALIGNOVERRIDE (TXDLYALIGNOVERRIDE_IN, TXDLYALIGNOVERRIDE);
  buf B_TXDLYALIGNRESET (TXDLYALIGNRESET_IN, TXDLYALIGNRESET);
  buf B_TXDLYALIGNUPDSW (TXDLYALIGNUPDSW_IN, TXDLYALIGNUPDSW);
  buf B_TXELECIDLE (TXELECIDLE_IN, TXELECIDLE);
  buf B_TXENC8B10BUSE (TXENC8B10BUSE_IN, TXENC8B10BUSE);
  buf B_TXENPMAPHASEALIGN (TXENPMAPHASEALIGN_IN, TXENPMAPHASEALIGN);
  buf B_TXENPRBSTST0 (TXENPRBSTST_IN[0], TXENPRBSTST[0]);
  buf B_TXENPRBSTST1 (TXENPRBSTST_IN[1], TXENPRBSTST[1]);
  buf B_TXENPRBSTST2 (TXENPRBSTST_IN[2], TXENPRBSTST[2]);
  buf B_TXHEADER0 (TXHEADER_IN[0], TXHEADER[0]);
  buf B_TXHEADER1 (TXHEADER_IN[1], TXHEADER[1]);
  buf B_TXHEADER2 (TXHEADER_IN[2], TXHEADER[2]);
  buf B_TXINHIBIT (TXINHIBIT_IN, TXINHIBIT);
  buf B_TXMARGIN0 (TXMARGIN_IN[0], TXMARGIN[0]);
  buf B_TXMARGIN1 (TXMARGIN_IN[1], TXMARGIN[1]);
  buf B_TXMARGIN2 (TXMARGIN_IN[2], TXMARGIN[2]);
  buf B_TXPDOWNASYNCH (TXPDOWNASYNCH_IN, TXPDOWNASYNCH);
  buf B_TXPLLLKDETEN (TXPLLLKDETEN_IN, TXPLLLKDETEN);
  buf B_TXPLLPOWERDOWN (TXPLLPOWERDOWN_IN, TXPLLPOWERDOWN);
  buf B_TXPLLREFSELDY0 (TXPLLREFSELDY_IN[0], TXPLLREFSELDY[0]);
  buf B_TXPLLREFSELDY1 (TXPLLREFSELDY_IN[1], TXPLLREFSELDY[1]);
  buf B_TXPLLREFSELDY2 (TXPLLREFSELDY_IN[2], TXPLLREFSELDY[2]);
  buf B_TXPMASETPHASE (TXPMASETPHASE_IN, TXPMASETPHASE);
  buf B_TXPOLARITY (TXPOLARITY_IN, TXPOLARITY);
  buf B_TXPOSTEMPHASIS0 (TXPOSTEMPHASIS_IN[0], TXPOSTEMPHASIS[0]);
  buf B_TXPOSTEMPHASIS1 (TXPOSTEMPHASIS_IN[1], TXPOSTEMPHASIS[1]);
  buf B_TXPOSTEMPHASIS2 (TXPOSTEMPHASIS_IN[2], TXPOSTEMPHASIS[2]);
  buf B_TXPOSTEMPHASIS3 (TXPOSTEMPHASIS_IN[3], TXPOSTEMPHASIS[3]);
  buf B_TXPOSTEMPHASIS4 (TXPOSTEMPHASIS_IN[4], TXPOSTEMPHASIS[4]);
  buf B_TXPOWERDOWN0 (TXPOWERDOWN_IN[0], TXPOWERDOWN[0]);
  buf B_TXPOWERDOWN1 (TXPOWERDOWN_IN[1], TXPOWERDOWN[1]);
  buf B_TXPRBSFORCEERR (TXPRBSFORCEERR_IN, TXPRBSFORCEERR);
  buf B_TXPREEMPHASIS0 (TXPREEMPHASIS_IN[0], TXPREEMPHASIS[0]);
  buf B_TXPREEMPHASIS1 (TXPREEMPHASIS_IN[1], TXPREEMPHASIS[1]);
  buf B_TXPREEMPHASIS2 (TXPREEMPHASIS_IN[2], TXPREEMPHASIS[2]);
  buf B_TXPREEMPHASIS3 (TXPREEMPHASIS_IN[3], TXPREEMPHASIS[3]);
  buf B_TXRATE0 (TXRATE_IN[0], TXRATE[0]);
  buf B_TXRATE1 (TXRATE_IN[1], TXRATE[1]);
  buf B_TXRESET (TXRESET_IN, TXRESET);
  buf B_TXSEQUENCE0 (TXSEQUENCE_IN[0], TXSEQUENCE[0]);
  buf B_TXSEQUENCE1 (TXSEQUENCE_IN[1], TXSEQUENCE[1]);
  buf B_TXSEQUENCE2 (TXSEQUENCE_IN[2], TXSEQUENCE[2]);
  buf B_TXSEQUENCE3 (TXSEQUENCE_IN[3], TXSEQUENCE[3]);
  buf B_TXSEQUENCE4 (TXSEQUENCE_IN[4], TXSEQUENCE[4]);
  buf B_TXSEQUENCE5 (TXSEQUENCE_IN[5], TXSEQUENCE[5]);
  buf B_TXSEQUENCE6 (TXSEQUENCE_IN[6], TXSEQUENCE[6]);
  buf B_TXSTARTSEQ (TXSTARTSEQ_IN, TXSTARTSEQ);
  buf B_TXSWING (TXSWING_IN, TXSWING);
  buf B_TXUSRCLK (TXUSRCLK_IN, TXUSRCLK);
  buf B_TXUSRCLK2 (TXUSRCLK2_IN, TXUSRCLK2);
  buf B_USRCODEERR (USRCODEERR_IN, USRCODEERR);
*/
   
  wire [15:0] delay_DRPDO;
  wire [1:0] delay_MGTREFCLKFAB;
  wire [1:0] delay_RXLOSSOFSYNC;
  wire [1:0] delay_TXBUFSTATUS;
  wire [2:0] delay_DFESENSCAL;
  wire [2:0] delay_RXBUFSTATUS;
  wire [2:0] delay_RXCLKCORCNT;
  wire [2:0] delay_RXHEADER;
  wire [2:0] delay_RXSTATUS;
  wire [31:0] delay_RXDATA;
  wire [3:0] delay_DFETAP3MONITOR;
  wire [3:0] delay_DFETAP4MONITOR;
  wire [3:0] delay_RXCHARISCOMMA;
  wire [3:0] delay_RXCHARISK;
  wire [3:0] delay_RXCHBONDO;
  wire [3:0] delay_RXDISPERR;
  wire [3:0] delay_RXNOTINTABLE;
  wire [3:0] delay_RXRUNDISP;
  wire [3:0] delay_TXKERR;
  wire [3:0] delay_TXRUNDISP;
  wire [4:0] delay_DFEEYEDACMON;
  wire [4:0] delay_DFETAP1MONITOR;
  wire [4:0] delay_DFETAP2MONITOR;
  wire [5:0] delay_DFECLKDLYADJMON;
  wire [7:0] delay_RXDLYALIGNMONITOR;
  wire [7:0] delay_TXDLYALIGNMONITOR;
  wire [9:0] delay_TSTOUT;
  wire delay_COMFINISH;
  wire delay_COMINITDET;
  wire delay_COMSASDET;
  wire delay_COMWAKEDET;
  wire delay_DRDY;
  wire delay_PHYSTATUS;
  wire delay_RXBYTEISALIGNED;
  wire delay_RXBYTEREALIGN;
  wire delay_RXCHANBONDSEQ;
  wire delay_RXCHANISALIGNED;
  wire delay_RXCHANREALIGN;
  wire delay_RXCOMMADET;
  wire delay_RXDATAVALID;
  wire delay_RXELECIDLE;
  wire delay_RXHEADERVALID;
  wire delay_RXOVERSAMPLEERR;
  wire delay_RXPLLLKDET;
  wire delay_RXPRBSERR;
  wire delay_RXRATEDONE;
  wire delay_RXRECCLK;
  wire delay_RXRECCLKPCS;
  wire delay_RXRESETDONE;
  wire delay_RXSTARTOFSEQ;
  wire delay_RXVALID;
  wire delay_TXGEARBOXREADY;
  wire delay_TXN;
  wire delay_TXOUTCLK;
  wire delay_TXOUTCLKPCS;
  wire delay_TXP;
  wire delay_TXPLLLKDET;
  wire delay_TXRATEDONE;
  wire delay_TXRESETDONE;

  wire [12:0] delay_GTXTEST;
  wire [15:0] delay_DI;
  wire [19:0] delay_TSTIN;
  wire [1:0] delay_MGTREFCLKRX;
  wire [1:0] delay_MGTREFCLKTX;
  wire [1:0] delay_NORTHREFCLKRX;
  wire [1:0] delay_NORTHREFCLKTX;
  wire [1:0] delay_RXPOWERDOWN;
  wire [1:0] delay_RXRATE;
  wire [1:0] delay_SOUTHREFCLKRX;
  wire [1:0] delay_SOUTHREFCLKTX;
  wire [1:0] delay_TXPOWERDOWN;
  wire [1:0] delay_TXRATE;
  wire [2:0] delay_LOOPBACK;
  wire [2:0] delay_RXCHBONDLEVEL;
  wire [2:0] delay_RXENPRBSTST;
  wire [2:0] delay_RXPLLREFSELDY;
  wire [2:0] delay_TXBUFDIFFCTRL;
  wire [2:0] delay_TXENPRBSTST;
  wire [2:0] delay_TXHEADER;
  wire [2:0] delay_TXMARGIN;
  wire [2:0] delay_TXPLLREFSELDY;
  wire [31:0] delay_TXDATA;
  wire [3:0] delay_DFETAP3;
  wire [3:0] delay_DFETAP4;
  wire [3:0] delay_RXCHBONDI;
  wire [3:0] delay_TXBYPASS8B10B;
  wire [3:0] delay_TXCHARDISPMODE;
  wire [3:0] delay_TXCHARDISPVAL;
  wire [3:0] delay_TXCHARISK;
  wire [3:0] delay_TXDIFFCTRL;
  wire [3:0] delay_TXPREEMPHASIS;
  wire [4:0] delay_DFETAP1;
  wire [4:0] delay_DFETAP2;
  wire [4:0] delay_TXPOSTEMPHASIS;
  wire [5:0] delay_DFECLKDLYADJ;
  wire [6:0] delay_TXSEQUENCE;
  wire [7:0] delay_DADDR;
  wire [9:0] delay_RXEQMIX;
  wire delay_DCLK;
  wire delay_DEN;
  wire delay_DFEDLYOVRD;
  wire delay_DFETAPOVRD;
  wire delay_DWE;
  wire delay_GATERXELECIDLE;
  wire delay_GREFCLKRX;
  wire delay_GREFCLKTX;
  wire delay_GTXRXRESET;
  wire delay_GTXTXRESET;
  wire delay_IGNORESIGDET;
  wire delay_PERFCLKRX;
  wire delay_PERFCLKTX;
  wire delay_PLLRXRESET;
  wire delay_PLLTXRESET;
  wire delay_PRBSCNTRESET;
  wire delay_RXBUFRESET;
  wire delay_RXCDRRESET;
  wire delay_RXCHBONDMASTER;
  wire delay_RXCHBONDSLAVE;
  wire delay_RXCOMMADETUSE;
  wire delay_RXDEC8B10BUSE;
  wire delay_RXDLYALIGNDISABLE;
  wire delay_RXDLYALIGNMONENB;
  wire delay_RXDLYALIGNOVERRIDE;
  wire delay_RXDLYALIGNRESET;
  wire delay_RXDLYALIGNSWPPRECURB;
  wire delay_RXDLYALIGNUPDSW;
  wire delay_RXENCHANSYNC;
  wire delay_RXENMCOMMAALIGN;
  wire delay_RXENPCOMMAALIGN;
  wire delay_RXENPMAPHASEALIGN;
  wire delay_RXENSAMPLEALIGN;
  wire delay_RXGEARBOXSLIP;
  wire delay_RXN;
  wire delay_RXP;
  wire delay_RXPLLLKDETEN;
  wire delay_RXPLLPOWERDOWN;
  wire delay_RXPMASETPHASE;
  wire delay_RXPOLARITY;
  wire delay_RXRESET;
  wire delay_RXSLIDE;
  wire delay_RXUSRCLK2;
  wire delay_RXUSRCLK;
  wire delay_TSTCLK0;
  wire delay_TSTCLK1;
  wire delay_TXCOMINIT;
  wire delay_TXCOMSAS;
  wire delay_TXCOMWAKE;
  wire delay_TXDEEMPH;
  wire delay_TXDETECTRX;
  wire delay_TXDLYALIGNDISABLE;
  wire delay_TXDLYALIGNMONENB;
  wire delay_TXDLYALIGNOVERRIDE;
  wire delay_TXDLYALIGNRESET;
  wire delay_TXDLYALIGNUPDSW;
  wire delay_TXELECIDLE;
  wire delay_TXENC8B10BUSE;
  wire delay_TXENPMAPHASEALIGN;
  wire delay_TXINHIBIT;
  wire delay_TXPDOWNASYNCH;
  wire delay_TXPLLLKDETEN;
  wire delay_TXPLLPOWERDOWN;
  wire delay_TXPMASETPHASE;
  wire delay_TXPOLARITY;
  wire delay_TXPRBSFORCEERR;
  wire delay_TXRESET;
  wire delay_TXSTARTSEQ;
  wire delay_TXSWING;
  wire delay_TXUSRCLK2;
  wire delay_TXUSRCLK;
  wire delay_USRCODEERR;

  assign #(OUTCLK_DELAY) MGTREFCLKFAB_OUT = delay_MGTREFCLKFAB;
  assign #(OUTCLK_DELAY) RXRECCLKPCS_OUT = delay_RXRECCLKPCS;
  assign #(OUTCLK_DELAY) RXRECCLK_OUT = delay_RXRECCLK;
  assign #(OUTCLK_DELAY) TXOUTCLKPCS_OUT = delay_TXOUTCLKPCS;
  assign #(OUTCLK_DELAY) TXOUTCLK_OUT = delay_TXOUTCLK;

  assign #(out_delay) COMFINISH= COMFINISH_OUT;
  assign #(out_delay) COMINITDET= COMINITDET_OUT;
  assign #(out_delay) COMSASDET= COMSASDET_OUT;
  assign #(out_delay) COMWAKEDET= COMWAKEDET_OUT;
  assign #(out_delay) DFECLKDLYADJMON= DFECLKDLYADJMON_OUT;
  assign #(out_delay) DFEEYEDACMON= DFEEYEDACMON_OUT;
  assign #(out_delay) DFESENSCAL= DFESENSCAL_OUT;
  assign #(out_delay) DFETAP1MONITOR= DFETAP1MONITOR_OUT;
  assign #(out_delay) DFETAP2MONITOR= DFETAP2MONITOR_OUT;
  assign #(out_delay) DFETAP3MONITOR= DFETAP3MONITOR_OUT;
  assign #(out_delay) DFETAP4MONITOR= DFETAP4MONITOR_OUT;
  assign #(out_delay) DRDY= DRDY_OUT;
  assign #(out_delay) DRPDO= DRPDO_OUT;
  assign #(out_delay) MGTREFCLKFAB= MGTREFCLKFAB_OUT;
  assign #(out_delay) PHYSTATUS= PHYSTATUS_OUT;
  assign #(out_delay) RXBUFSTATUS= RXBUFSTATUS_OUT;
  assign #(out_delay) RXBYTEISALIGNED= RXBYTEISALIGNED_OUT;
  assign #(out_delay) RXBYTEREALIGN= RXBYTEREALIGN_OUT;
  assign #(out_delay) RXCHANBONDSEQ= RXCHANBONDSEQ_OUT;
  assign #(out_delay) RXCHANISALIGNED= RXCHANISALIGNED_OUT;
  assign #(out_delay) RXCHANREALIGN= RXCHANREALIGN_OUT;
  assign #(out_delay) RXCHARISCOMMA= RXCHARISCOMMA_OUT;
  assign #(out_delay) RXCHARISK= RXCHARISK_OUT;
  assign #(out_delay) RXCHBONDO= RXCHBONDO_OUT;
  assign #(out_delay) RXCLKCORCNT= RXCLKCORCNT_OUT;
  assign #(out_delay) RXCOMMADET= RXCOMMADET_OUT;
  assign #(out_delay) RXDATA= RXDATA_OUT;
  assign #(out_delay) RXDATAVALID= RXDATAVALID_OUT;
  assign #(out_delay) RXDISPERR= RXDISPERR_OUT;
  assign #(out_delay) RXDLYALIGNMONITOR= RXDLYALIGNMONITOR_OUT;
  assign #(out_delay) RXELECIDLE= RXELECIDLE_OUT;
  assign #(out_delay) RXHEADER= RXHEADER_OUT;
  assign #(out_delay) RXHEADERVALID= RXHEADERVALID_OUT;
  assign #(out_delay) RXLOSSOFSYNC= RXLOSSOFSYNC_OUT;
  assign #(out_delay) RXNOTINTABLE= RXNOTINTABLE_OUT;
  assign #(out_delay) RXOVERSAMPLEERR= RXOVERSAMPLEERR_OUT;
  assign #(out_delay) RXPLLLKDET= RXPLLLKDET_OUT;
  assign #(out_delay) RXPRBSERR= RXPRBSERR_OUT;
  assign #(out_delay) RXRATEDONE= RXRATEDONE_OUT;
  assign #(out_delay) RXRECCLK= RXRECCLK_OUT;
  assign #(out_delay) RXRECCLKPCS= RXRECCLKPCS_OUT;
  assign #(out_delay) RXRESETDONE= RXRESETDONE_OUT;
  assign #(out_delay) RXRUNDISP= RXRUNDISP_OUT;
  assign #(out_delay) RXSTARTOFSEQ= RXSTARTOFSEQ_OUT;
  assign #(out_delay) RXSTATUS= RXSTATUS_OUT;
  assign #(out_delay) RXVALID= RXVALID_OUT;
  assign #(out_delay) TSTOUT= TSTOUT_OUT;
  assign #(out_delay) TXBUFSTATUS= TXBUFSTATUS_OUT;
  assign #(out_delay) TXDLYALIGNMONITOR= TXDLYALIGNMONITOR_OUT;
  assign #(out_delay) TXGEARBOXREADY= TXGEARBOXREADY_OUT;
  assign #(out_delay) TXKERR= TXKERR_OUT;
  assign #(out_delay) TXN= TXN_OUT;
  assign #(out_delay) TXOUTCLK= TXOUTCLK_OUT;
  assign #(out_delay) TXOUTCLKPCS= TXOUTCLKPCS_OUT;
  assign #(out_delay) TXP= TXP_OUT;
  assign #(out_delay) TXPLLLKDET= TXPLLLKDET_OUT;
  assign #(out_delay) TXRATEDONE= TXRATEDONE_OUT;
  assign #(out_delay) TXRESETDONE= TXRESETDONE_OUT;
  assign #(out_delay) TXRUNDISP= TXRUNDISP_OUT;

  assign #(in_delay) DADDR_IN= DADDR;
  assign #(in_delay) DCLK_IN= DCLK;
  assign #(in_delay) DEN_IN= DEN;
  assign #(in_delay) DFECLKDLYADJ_IN= DFECLKDLYADJ;
  assign #(in_delay) DFEDLYOVRD_IN= DFEDLYOVRD;
  assign #(in_delay) DFETAP1_IN= DFETAP1;
  assign #(in_delay) DFETAPOVRD_IN= DFETAPOVRD;
  assign #(in_delay) DI_IN= DI;
  assign #(in_delay) DWE_IN= DWE;
  assign #(in_delay) GATERXELECIDLE_IN= GATERXELECIDLE;
  assign #(in_delay) GREFCLKRX_IN= GREFCLKRX;
  assign #(in_delay) GREFCLKTX_IN= GREFCLKTX;
  assign #(in_delay) GTXRXRESET_IN= GTXRXRESET;
  assign #(in_delay) GTXTEST_IN= GTXTEST;
  assign #(in_delay) GTXTXRESET_IN= GTXTXRESET;
  assign #(in_delay) IGNORESIGDET_IN= IGNORESIGDET;
  assign #(in_delay) LOOPBACK_IN= LOOPBACK;
  assign #(in_delay) MGTREFCLKRX_IN = MGTREFCLKRX;
  assign #(in_delay) MGTREFCLKTX_IN = MGTREFCLKTX;
  assign #(in_delay) NORTHREFCLKRX_IN= NORTHREFCLKRX;
  assign #(in_delay) NORTHREFCLKTX_IN= NORTHREFCLKTX;
  assign #(in_delay) PERFCLKRX_IN= PERFCLKRX;
  assign #(in_delay) PERFCLKTX_IN= PERFCLKTX;
  assign #(in_delay) PLLRXRESET_IN= PLLRXRESET;
  assign #(in_delay) PLLTXRESET_IN= PLLTXRESET;
  assign #(in_delay) PRBSCNTRESET_IN= PRBSCNTRESET;
  assign #(in_delay) RXBUFRESET_IN= RXBUFRESET;
  assign #(in_delay) RXCDRRESET_IN= RXCDRRESET;
  assign #(in_delay) RXCHBONDI_IN= RXCHBONDI;
  assign #(in_delay) RXCHBONDLEVEL_IN= RXCHBONDLEVEL;
  assign #(in_delay) RXCHBONDMASTER_IN= RXCHBONDMASTER;
  assign #(in_delay) RXCHBONDSLAVE_IN= RXCHBONDSLAVE;
  assign #(in_delay) RXCOMMADETUSE_IN= RXCOMMADETUSE;
  assign #(in_delay) RXDEC8B10BUSE_IN= RXDEC8B10BUSE;
  assign #(in_delay) RXDLYALIGNDISABLE_IN= RXDLYALIGNDISABLE;
  assign #(in_delay) RXDLYALIGNMONENB_IN = RXDLYALIGNMONENB;
  assign #(in_delay) RXDLYALIGNOVERRIDE_IN= RXDLYALIGNOVERRIDE;
  assign #(in_delay) RXDLYALIGNRESET_IN= RXDLYALIGNRESET;
  assign #(in_delay) RXDLYALIGNSWPPRECURB_IN= RXDLYALIGNSWPPRECURB;
  assign #(in_delay) RXDLYALIGNUPDSW_IN= RXDLYALIGNUPDSW;
  assign #(in_delay) RXENCHANSYNC_IN= RXENCHANSYNC;
  assign #(in_delay) RXENMCOMMAALIGN_IN= RXENMCOMMAALIGN;
  assign #(in_delay) RXENPCOMMAALIGN_IN= RXENPCOMMAALIGN;
  assign #(in_delay) RXENPMAPHASEALIGN_IN= RXENPMAPHASEALIGN;
  assign #(in_delay) RXENPRBSTST_IN= RXENPRBSTST;
  assign #(in_delay) RXENSAMPLEALIGN_IN= RXENSAMPLEALIGN;
  assign #(in_delay) RXEQMIX_IN= RXEQMIX;
  assign #(in_delay) RXGEARBOXSLIP_IN= RXGEARBOXSLIP;
  assign #(in_delay) RXN_IN= RXN;
  assign #(in_delay) RXP_IN= RXP;
  assign #(in_delay) RXPLLLKDETEN_IN= RXPLLLKDETEN;
  assign #(in_delay) RXPLLPOWERDOWN_IN= RXPLLPOWERDOWN;
  assign #(in_delay) RXPLLREFSELDY_IN= RXPLLREFSELDY;
  assign #(in_delay) RXPMASETPHASE_IN= RXPMASETPHASE;
  assign #(in_delay) RXPOLARITY_IN= RXPOLARITY;
  assign #(in_delay) RXPOWERDOWN_IN= RXPOWERDOWN;
  assign #(in_delay) RXRATE_IN= RXRATE;
  assign #(in_delay) RXRESET_IN= RXRESET;
  assign #(in_delay) RXSLIDE_IN= RXSLIDE;
  assign #(in_delay) RXUSRCLK_IN= RXUSRCLK;
  assign #(in_delay) RXUSRCLK2_IN= RXUSRCLK2;
  assign #(in_delay) SOUTHREFCLKRX_IN= SOUTHREFCLKRX;
  assign #(in_delay) SOUTHREFCLKTX_IN= SOUTHREFCLKTX;
  assign #(in_delay) SOUTHREFCLKTX_IN= SOUTHREFCLKTX;
  assign #(in_delay) TSTCLK0_IN= TSTCLK0;
  assign #(in_delay) TSTCLK1_IN= TSTCLK1;
  assign #(in_delay) TSTIN_IN= TSTIN;
  assign #(in_delay) TXBUFDIFFCTRL_IN = TXBUFDIFFCTRL;
  assign #(in_delay) TXBYPASS8B10B_IN= TXBYPASS8B10B;
  assign #(in_delay) TXCHARDISPMODE_IN= TXCHARDISPMODE;
  assign #(in_delay) TXCHARDISPVAL_IN= TXCHARDISPVAL;
  assign #(in_delay) TXCHARISK_IN= TXCHARISK;
  assign #(in_delay) TXCOMINIT_IN= TXCOMINIT;
  assign #(in_delay) TXCOMSAS_IN= TXCOMSAS;
  assign #(in_delay) TXCOMWAKE_IN= TXCOMWAKE;
  assign #(in_delay) TXDATA_IN= TXDATA;
  assign #(in_delay) TXDATA_IN= TXDATA;
  assign #(in_delay) TXDEEMPH_IN= TXDEEMPH;
  assign #(in_delay) TXDETECTRX_IN= TXDETECTRX;
  assign #(in_delay) TXDIFFCTRL_IN= TXDIFFCTRL;
  assign #(in_delay) TXDLYALIGNDISABLE_IN= TXDLYALIGNDISABLE;
  assign #(in_delay) TXDLYALIGNMONENB_IN = TXDLYALIGNMONENB;
  assign #(in_delay) TXDLYALIGNOVERRIDE_IN= TXDLYALIGNOVERRIDE;
  assign #(in_delay) TXDLYALIGNRESET_IN= TXDLYALIGNRESET;
  assign #(in_delay) TXDLYALIGNUPDSW_IN= TXDLYALIGNUPDSW;
  assign #(in_delay) TXELECIDLE_IN= TXELECIDLE;
  assign #(in_delay) TXENC8B10BUSE_IN= TXENC8B10BUSE;
  assign #(in_delay) TXENPMAPHASEALIGN_IN= TXENPMAPHASEALIGN;
  assign #(in_delay) TXENPRBSTST_IN= TXENPRBSTST;
  assign #(in_delay) TXHEADER_IN= TXHEADER;
  assign #(in_delay) TXINHIBIT_IN= TXINHIBIT;
  assign #(in_delay) TXMARGIN_IN= TXMARGIN;
  assign #(in_delay) TXPDOWNASYNCH_IN= TXPDOWNASYNCH;
  assign #(in_delay) TXPLLLKDETEN_IN= TXPLLLKDETEN;
  assign #(in_delay) TXPLLPOWERDOWN_IN= TXPLLPOWERDOWN;
  assign #(in_delay) TXPLLREFSELDY_IN= TXPLLREFSELDY;
  assign #(in_delay) TXPMASETPHASE_IN= TXPMASETPHASE;
  assign #(in_delay) TXPOLARITY_IN= TXPOLARITY;
  assign #(in_delay) TXPOSTEMPHASIS_IN= TXPOSTEMPHASIS;
  assign #(in_delay) TXPOWERDOWN_IN= TXPOWERDOWN;
  assign #(in_delay) TXPRBSFORCEERR_IN= TXPRBSFORCEERR;
  assign #(in_delay) TXPREEMPHASIS_IN= TXPREEMPHASIS;
  assign #(in_delay) TXRATE_IN= TXRATE;
  assign #(in_delay) TXRESET_IN= TXRESET;
  assign #(in_delay) TXSEQUENCE_IN= TXSEQUENCE;
  assign #(in_delay) TXSTARTSEQ_IN= TXSTARTSEQ;
  assign #(in_delay) TXSWING_IN= TXSWING;
  assign #(in_delay) TXUSRCLK_IN= TXUSRCLK;
  assign #(in_delay) TXUSRCLK2_IN= TXUSRCLK2;
  assign #(in_delay) USRCODEERR_IN= USRCODEERR;

  assign #(out_delay) COMFINISH_OUT = delay_COMFINISH;
  assign #(out_delay) COMINITDET_OUT = delay_COMINITDET;
  assign #(out_delay) COMSASDET_OUT = delay_COMSASDET;
  assign #(out_delay) COMWAKEDET_OUT = delay_COMWAKEDET;
  assign #(out_delay) DFECLKDLYADJMON_OUT = delay_DFECLKDLYADJMON;
  assign #(out_delay) DFEEYEDACMON_OUT = delay_DFEEYEDACMON;
  assign #(out_delay) DFESENSCAL_OUT = delay_DFESENSCAL;
  assign #(out_delay) DFETAP1MONITOR_OUT = delay_DFETAP1MONITOR;
  assign #(out_delay) DFETAP2MONITOR_OUT = delay_DFETAP2MONITOR;
  assign #(out_delay) DFETAP3MONITOR_OUT = delay_DFETAP3MONITOR;
  assign #(out_delay) DFETAP4MONITOR_OUT = delay_DFETAP4MONITOR;
  assign #(out_delay) DRDY_OUT = delay_DRDY;
  assign #(out_delay) DRPDO_OUT = delay_DRPDO;
  assign #(out_delay) PHYSTATUS_OUT = delay_PHYSTATUS;
  assign #(out_delay) RXBUFSTATUS_OUT = delay_RXBUFSTATUS;
  assign #(out_delay) RXBYTEISALIGNED_OUT = delay_RXBYTEISALIGNED;
  assign #(out_delay) RXBYTEREALIGN_OUT = delay_RXBYTEREALIGN;
  assign #(out_delay) RXCHANBONDSEQ_OUT = delay_RXCHANBONDSEQ;
  assign #(out_delay) RXCHANISALIGNED_OUT = delay_RXCHANISALIGNED;
  assign #(out_delay) RXCHANREALIGN_OUT = delay_RXCHANREALIGN;
  assign #(out_delay) RXCHARISCOMMA_OUT = delay_RXCHARISCOMMA;
  assign #(out_delay) RXCHARISK_OUT = delay_RXCHARISK;
  assign #(out_delay) RXCHBONDO_OUT = delay_RXCHBONDO;
  assign #(out_delay) RXCLKCORCNT_OUT = delay_RXCLKCORCNT;
  assign #(out_delay) RXCOMMADET_OUT = delay_RXCOMMADET;
  assign #(out_delay) RXDATAVALID_OUT = delay_RXDATAVALID;
  assign #(out_delay) RXDATA_OUT = delay_RXDATA;
  assign #(out_delay) RXDISPERR_OUT = delay_RXDISPERR;
  assign #(out_delay) RXDLYALIGNMONITOR_OUT = delay_RXDLYALIGNMONITOR;
  assign #(out_delay) RXELECIDLE_OUT = delay_RXELECIDLE;
  assign #(out_delay) RXHEADERVALID_OUT = delay_RXHEADERVALID;
  assign #(out_delay) RXHEADER_OUT = delay_RXHEADER;
  assign #(out_delay) RXLOSSOFSYNC_OUT = delay_RXLOSSOFSYNC;
  assign #(out_delay) RXNOTINTABLE_OUT = delay_RXNOTINTABLE;
  assign #(out_delay) RXOVERSAMPLEERR_OUT = delay_RXOVERSAMPLEERR;
  assign #(out_delay) RXPLLLKDET_OUT = delay_RXPLLLKDET;
  assign #(out_delay) RXPRBSERR_OUT = delay_RXPRBSERR;
  assign #(out_delay) RXRATEDONE_OUT = delay_RXRATEDONE;
  assign #(out_delay) RXRESETDONE_OUT = delay_RXRESETDONE;
  assign #(out_delay) RXRUNDISP_OUT = delay_RXRUNDISP;
  assign #(out_delay) RXSTARTOFSEQ_OUT = delay_RXSTARTOFSEQ;
  assign #(out_delay) RXSTATUS_OUT = delay_RXSTATUS;
  assign #(out_delay) RXVALID_OUT = delay_RXVALID;
  assign #(out_delay) TSTOUT_OUT = delay_TSTOUT;
  assign #(out_delay) TXBUFSTATUS_OUT = delay_TXBUFSTATUS;
  assign #(out_delay) TXDLYALIGNMONITOR_OUT = delay_TXDLYALIGNMONITOR;
  assign #(out_delay) TXGEARBOXREADY_OUT = delay_TXGEARBOXREADY;
  assign #(out_delay) TXKERR_OUT = delay_TXKERR;
  assign #(out_delay) TXN_OUT = delay_TXN;
  assign #(out_delay) TXPLLLKDET_OUT = delay_TXPLLLKDET;
  assign #(out_delay) TXP_OUT = delay_TXP;
  assign #(out_delay) TXRATEDONE_OUT = delay_TXRATEDONE;
  assign #(out_delay) TXRESETDONE_OUT = delay_TXRESETDONE;
  assign #(out_delay) TXRUNDISP_OUT = delay_TXRUNDISP;

  assign #(INCLK_DELAY) DCLK_INDELAY = DCLK_IN;
  assign #(INCLK_DELAY) GREFCLKRX_INDELAY = GREFCLKRX_IN;
  assign #(INCLK_DELAY) GREFCLKTX_INDELAY = GREFCLKTX_IN;
  assign #(INCLK_DELAY) MGTREFCLKRX_INDELAY = MGTREFCLKRX_IN;
  assign #(INCLK_DELAY) MGTREFCLKTX_INDELAY = MGTREFCLKTX_IN;
  assign #(INCLK_DELAY) NORTHREFCLKRX_INDELAY = NORTHREFCLKRX_IN;
  assign #(INCLK_DELAY) NORTHREFCLKTX_INDELAY = NORTHREFCLKTX_IN;
  assign #(INCLK_DELAY) PERFCLKRX_INDELAY = PERFCLKRX_IN;
  assign #(INCLK_DELAY) PERFCLKTX_INDELAY = PERFCLKTX_IN;
  assign #(INCLK_DELAY) RXUSRCLK2_INDELAY = RXUSRCLK2_IN;
  assign #(INCLK_DELAY) RXUSRCLK_INDELAY = RXUSRCLK_IN;
  assign #(INCLK_DELAY) SOUTHREFCLKRX_INDELAY = SOUTHREFCLKRX_IN;
  assign #(INCLK_DELAY) SOUTHREFCLKTX_INDELAY = SOUTHREFCLKTX_IN;
  assign #(INCLK_DELAY) TSTCLK0_INDELAY = TSTCLK0_IN;
  assign #(INCLK_DELAY) TSTCLK1_INDELAY = TSTCLK1_IN;
  assign #(INCLK_DELAY) TXUSRCLK2_INDELAY = TXUSRCLK2_IN;
  assign #(INCLK_DELAY) TXUSRCLK_INDELAY = TXUSRCLK_IN;

  assign #(in_delay) DADDR_INDELAY = DADDR_IN;
  assign #(in_delay) DEN_INDELAY = DEN_IN;
  assign #(in_delay) DFECLKDLYADJ_INDELAY = DFECLKDLYADJ_IN;
  assign #(in_delay) DFEDLYOVRD_INDELAY = DFEDLYOVRD_IN;
  assign #(in_delay) DFETAP1_INDELAY = DFETAP1_IN;
  assign #(in_delay) DFETAP2_INDELAY = DFETAP2_IN;
  assign #(in_delay) DFETAP3_INDELAY = DFETAP3_IN;
  assign #(in_delay) DFETAP4_INDELAY = DFETAP4_IN;
  assign #(in_delay) DFETAPOVRD_INDELAY = DFETAPOVRD_IN;
  assign #(in_delay) DI_INDELAY = DI_IN;
  assign #(in_delay) DWE_INDELAY = DWE_IN;
  assign #(in_delay) GATERXELECIDLE_INDELAY = GATERXELECIDLE_IN;
  assign #(in_delay) GTXRXRESET_INDELAY = GTXRXRESET_IN;
  assign #(in_delay) GTXTEST_INDELAY = GTXTEST_IN;
  assign #(in_delay) GTXTXRESET_INDELAY = GTXTXRESET_IN;
  assign #(in_delay) IGNORESIGDET_INDELAY = IGNORESIGDET_IN;
  assign #(in_delay) LOOPBACK_INDELAY = LOOPBACK_IN;
  assign #(in_delay) PLLRXRESET_INDELAY = PLLRXRESET_IN;
  assign #(in_delay) PLLTXRESET_INDELAY = PLLTXRESET_IN;
  assign #(in_delay) PRBSCNTRESET_INDELAY = PRBSCNTRESET_IN;
  assign #(in_delay) RXBUFRESET_INDELAY = RXBUFRESET_IN;
  assign #(in_delay) RXCDRRESET_INDELAY = RXCDRRESET_IN;
  assign #(in_delay) RXCHBONDI_INDELAY = RXCHBONDI_IN;
  assign #(in_delay) RXCHBONDLEVEL_INDELAY = RXCHBONDLEVEL_IN;
  assign #(in_delay) RXCHBONDMASTER_INDELAY = RXCHBONDMASTER_IN;
  assign #(in_delay) RXCHBONDSLAVE_INDELAY = RXCHBONDSLAVE_IN;
  assign #(in_delay) RXCOMMADETUSE_INDELAY = RXCOMMADETUSE_IN;
  assign #(in_delay) RXDEC8B10BUSE_INDELAY = RXDEC8B10BUSE_IN;
  assign #(in_delay) RXDLYALIGNDISABLE_INDELAY = RXDLYALIGNDISABLE_IN;
  assign #(in_delay) RXDLYALIGNMONENB_INDELAY = RXDLYALIGNMONENB_IN;
  assign #(in_delay) RXDLYALIGNOVERRIDE_INDELAY = RXDLYALIGNOVERRIDE_IN;
  assign #(in_delay) RXDLYALIGNRESET_INDELAY = RXDLYALIGNRESET_IN;
  assign #(in_delay) RXDLYALIGNSWPPRECURB_INDELAY = RXDLYALIGNSWPPRECURB_IN;
  assign #(in_delay) RXDLYALIGNUPDSW_INDELAY = RXDLYALIGNUPDSW_IN;
  assign #(in_delay) RXENCHANSYNC_INDELAY = RXENCHANSYNC_IN;
  assign #(in_delay) RXENMCOMMAALIGN_INDELAY = RXENMCOMMAALIGN_IN;
  assign #(in_delay) RXENPCOMMAALIGN_INDELAY = RXENPCOMMAALIGN_IN;
  assign #(in_delay) RXENPMAPHASEALIGN_INDELAY = RXENPMAPHASEALIGN_IN;
  assign #(in_delay) RXENPRBSTST_INDELAY = RXENPRBSTST_IN;
  assign #(in_delay) RXENSAMPLEALIGN_INDELAY = RXENSAMPLEALIGN_IN;
  assign #(in_delay) RXEQMIX_INDELAY = RXEQMIX_IN;
  assign #(in_delay) RXGEARBOXSLIP_INDELAY = RXGEARBOXSLIP_IN;
  assign #(in_delay) RXN_INDELAY = RXN_IN;
  assign #(in_delay) RXPLLLKDETEN_INDELAY = RXPLLLKDETEN_IN;
  assign #(in_delay) RXPLLPOWERDOWN_INDELAY = RXPLLPOWERDOWN_IN;
  assign #(in_delay) RXPLLREFSELDY_INDELAY = RXPLLREFSELDY_IN;
  assign #(in_delay) RXPMASETPHASE_INDELAY = RXPMASETPHASE_IN;
  assign #(in_delay) RXPOLARITY_INDELAY = RXPOLARITY_IN;
  assign #(in_delay) RXPOWERDOWN_INDELAY = RXPOWERDOWN_IN;
  assign #(in_delay) RXP_INDELAY = RXP_IN;
  assign #(in_delay) RXRATE_INDELAY = RXRATE_IN;
  assign #(in_delay) RXRESET_INDELAY = RXRESET_IN;
  assign #(in_delay) RXSLIDE_INDELAY = RXSLIDE_IN;
  assign #(in_delay) TSTIN_INDELAY = TSTIN_IN;
  assign #(in_delay) TXBUFDIFFCTRL_INDELAY = TXBUFDIFFCTRL_IN;
  assign #(in_delay) TXBYPASS8B10B_INDELAY = TXBYPASS8B10B_IN;
  assign #(in_delay) TXCHARDISPMODE_INDELAY = TXCHARDISPMODE_IN;
  assign #(in_delay) TXCHARDISPVAL_INDELAY = TXCHARDISPVAL_IN;
  assign #(in_delay) TXCHARISK_INDELAY = TXCHARISK_IN;
  assign #(in_delay) TXCOMINIT_INDELAY = TXCOMINIT_IN;
  assign #(in_delay) TXCOMSAS_INDELAY = TXCOMSAS_IN;
  assign #(in_delay) TXCOMWAKE_INDELAY = TXCOMWAKE_IN;
  assign #(in_delay) TXDATA_INDELAY = TXDATA_IN;
  assign #(in_delay) TXDEEMPH_INDELAY = TXDEEMPH_IN;
  assign #(in_delay) TXDETECTRX_INDELAY = TXDETECTRX_IN;
  assign #(in_delay) TXDIFFCTRL_INDELAY = TXDIFFCTRL_IN;
  assign #(in_delay) TXDLYALIGNDISABLE_INDELAY = TXDLYALIGNDISABLE_IN;
  assign #(in_delay) TXDLYALIGNMONENB_IN = TXDLYALIGNMONENB;
  assign #(in_delay) TXDLYALIGNOVERRIDE_INDELAY = TXDLYALIGNOVERRIDE_IN;
  assign #(in_delay) TXDLYALIGNRESET_INDELAY = TXDLYALIGNRESET_IN;
  assign #(in_delay) TXDLYALIGNUPDSW_INDELAY = TXDLYALIGNUPDSW_IN;
  assign #(in_delay) TXELECIDLE_INDELAY = TXELECIDLE_IN;
  assign #(in_delay) TXENC8B10BUSE_INDELAY = TXENC8B10BUSE_IN;
  assign #(in_delay) TXENPMAPHASEALIGN_INDELAY = TXENPMAPHASEALIGN_IN;
  assign #(in_delay) TXENPRBSTST_INDELAY = TXENPRBSTST_IN;
  assign #(in_delay) TXHEADER_INDELAY = TXHEADER_IN;
  assign #(in_delay) TXINHIBIT_INDELAY = TXINHIBIT_IN;
  assign #(in_delay) TXMARGIN_INDELAY = TXMARGIN_IN;
  assign #(in_delay) TXPDOWNASYNCH_INDELAY = TXPDOWNASYNCH_IN;
  assign #(in_delay) TXPLLLKDETEN_INDELAY = TXPLLLKDETEN_IN;
  assign #(in_delay) TXPLLPOWERDOWN_INDELAY = TXPLLPOWERDOWN_IN;
  assign #(in_delay) TXPLLREFSELDY_INDELAY = TXPLLREFSELDY_IN;
  assign #(in_delay) TXPMASETPHASE_INDELAY = TXPMASETPHASE_IN;
  assign #(in_delay) TXPOLARITY_INDELAY = TXPOLARITY_IN;
  assign #(in_delay) TXPOSTEMPHASIS_INDELAY = TXPOSTEMPHASIS_IN;
  assign #(in_delay) TXPOWERDOWN_INDELAY = TXPOWERDOWN_IN;
  assign #(in_delay) TXPRBSFORCEERR_INDELAY = TXPRBSFORCEERR_IN;
  assign #(in_delay) TXPREEMPHASIS_INDELAY = TXPREEMPHASIS_IN;
  assign #(in_delay) TXRATE_INDELAY = TXRATE_IN;
  assign #(in_delay) TXRESET_INDELAY = TXRESET_IN;
  assign #(in_delay) TXSEQUENCE_INDELAY = TXSEQUENCE_IN;
  assign #(in_delay) TXSTARTSEQ_INDELAY = TXSTARTSEQ_IN;
  assign #(in_delay) TXSWING_INDELAY = TXSWING_IN;
  assign #(in_delay) USRCODEERR_INDELAY = USRCODEERR_IN;
  assign delay_GATERXELECIDLE = GATERXELECIDLE_INDELAY;
  assign delay_GREFCLKRX = GREFCLKRX_INDELAY;
  assign delay_GREFCLKTX = GREFCLKTX_INDELAY;
  assign delay_GTXRXRESET = GTXRXRESET_INDELAY;
  assign delay_GTXTEST = GTXTEST_INDELAY;
  assign delay_GTXTXRESET = GTXTXRESET_INDELAY;
  assign delay_IGNORESIGDET = IGNORESIGDET_INDELAY;
  assign delay_LOOPBACK = LOOPBACK_INDELAY;
  assign delay_MGTREFCLKRX = MGTREFCLKRX_INDELAY;
  assign delay_MGTREFCLKTX = MGTREFCLKTX_INDELAY;
  assign delay_NORTHREFCLKRX = NORTHREFCLKRX_INDELAY;
  assign delay_NORTHREFCLKTX = NORTHREFCLKTX_INDELAY;
  assign delay_PERFCLKRX = PERFCLKRX_INDELAY;
  assign delay_PERFCLKTX = PERFCLKTX_INDELAY;
  assign delay_PLLRXRESET = PLLRXRESET_INDELAY;
  assign delay_PLLTXRESET = PLLTXRESET_INDELAY;
  assign delay_RXBUFRESET = RXBUFRESET_INDELAY;
  assign delay_RXCDRRESET = RXCDRRESET_INDELAY;
  assign delay_RXDLYALIGNDISABLE = RXDLYALIGNDISABLE_INDELAY;
  assign delay_RXDLYALIGNMONENB = RXDLYALIGNMONENB_INDELAY;
  assign delay_RXDLYALIGNOVERRIDE = RXDLYALIGNOVERRIDE_INDELAY;
  assign delay_RXDLYALIGNRESET = RXDLYALIGNRESET_INDELAY;
  assign delay_RXDLYALIGNSWPPRECURB = RXDLYALIGNSWPPRECURB_INDELAY;
  assign delay_RXDLYALIGNUPDSW = RXDLYALIGNUPDSW_INDELAY;
  assign delay_RXENPMAPHASEALIGN = RXENPMAPHASEALIGN_INDELAY;
  assign delay_RXEQMIX = RXEQMIX_INDELAY;
  assign delay_RXN = RXN_INDELAY;
  assign delay_RXP = RXP_INDELAY;
  assign delay_RXPLLLKDETEN = RXPLLLKDETEN_INDELAY;
  assign delay_RXPLLPOWERDOWN = RXPLLPOWERDOWN_INDELAY;
  assign delay_RXPLLREFSELDY = RXPLLREFSELDY_INDELAY;
  assign delay_RXPMASETPHASE = RXPMASETPHASE_INDELAY;
  assign delay_RXPOWERDOWN = RXPOWERDOWN_INDELAY;
  assign delay_RXRESET = RXRESET_INDELAY;
  assign delay_SOUTHREFCLKRX = SOUTHREFCLKRX_INDELAY;
  assign delay_SOUTHREFCLKTX = SOUTHREFCLKTX_INDELAY;
  assign delay_TSTCLK0 = TSTCLK0_INDELAY;
  assign delay_TSTCLK1 = TSTCLK1_INDELAY;
  assign delay_TSTIN = TSTIN_INDELAY;
  assign delay_TXBUFDIFFCTRL = TXBUFDIFFCTRL_INDELAY;
  assign delay_TXDEEMPH = TXDEEMPH_INDELAY;
  assign delay_TXDIFFCTRL = TXDIFFCTRL_INDELAY;
  assign delay_TXDLYALIGNDISABLE = TXDLYALIGNDISABLE_INDELAY;
  assign delay_TXDLYALIGNMONENB = TXDLYALIGNMONENB_INDELAY;
  assign delay_TXDLYALIGNOVERRIDE = TXDLYALIGNOVERRIDE_INDELAY;
  assign delay_TXDLYALIGNRESET = TXDLYALIGNRESET_INDELAY;
  assign delay_TXDLYALIGNUPDSW = TXDLYALIGNUPDSW_INDELAY;
  assign delay_TXENPMAPHASEALIGN = TXENPMAPHASEALIGN_INDELAY;
  assign delay_TXMARGIN = TXMARGIN_INDELAY;
  assign delay_TXPDOWNASYNCH = TXPDOWNASYNCH_INDELAY;
  assign delay_TXPLLLKDETEN = TXPLLLKDETEN_INDELAY;
  assign delay_TXPLLPOWERDOWN = TXPLLPOWERDOWN_INDELAY;
  assign delay_TXPLLREFSELDY = TXPLLREFSELDY_INDELAY;
  assign delay_TXPMASETPHASE = TXPMASETPHASE_INDELAY;
  assign delay_TXPOSTEMPHASIS = TXPOSTEMPHASIS_INDELAY;
  assign delay_TXPREEMPHASIS = TXPREEMPHASIS_INDELAY;
  assign delay_TXRESET = TXRESET_INDELAY;
  assign delay_TXSWING = TXSWING_INDELAY;
  assign delay_TXUSRCLK = TXUSRCLK_INDELAY;

  B_GTXE1 #(
    .AC_CAP_DIS (AC_CAP_DIS),
    .ALIGN_COMMA_WORD (ALIGN_COMMA_WORD),
    .BGTEST_CFG (BGTEST_CFG),
    .BIAS_CFG (BIAS_CFG),
    .CDR_PH_ADJ_TIME (CDR_PH_ADJ_TIME),
    .CHAN_BOND_1_MAX_SKEW (CHAN_BOND_1_MAX_SKEW),
    .CHAN_BOND_2_MAX_SKEW (CHAN_BOND_2_MAX_SKEW),
    .CHAN_BOND_KEEP_ALIGN (CHAN_BOND_KEEP_ALIGN),
    .CHAN_BOND_SEQ_1_1 (CHAN_BOND_SEQ_1_1),
    .CHAN_BOND_SEQ_1_2 (CHAN_BOND_SEQ_1_2),
    .CHAN_BOND_SEQ_1_3 (CHAN_BOND_SEQ_1_3),
    .CHAN_BOND_SEQ_1_4 (CHAN_BOND_SEQ_1_4),
    .CHAN_BOND_SEQ_1_ENABLE (CHAN_BOND_SEQ_1_ENABLE),
    .CHAN_BOND_SEQ_2_1 (CHAN_BOND_SEQ_2_1),
    .CHAN_BOND_SEQ_2_2 (CHAN_BOND_SEQ_2_2),
    .CHAN_BOND_SEQ_2_3 (CHAN_BOND_SEQ_2_3),
    .CHAN_BOND_SEQ_2_4 (CHAN_BOND_SEQ_2_4),
    .CHAN_BOND_SEQ_2_CFG (CHAN_BOND_SEQ_2_CFG),
    .CHAN_BOND_SEQ_2_ENABLE (CHAN_BOND_SEQ_2_ENABLE),
    .CHAN_BOND_SEQ_2_USE (CHAN_BOND_SEQ_2_USE),
    .CHAN_BOND_SEQ_LEN (CHAN_BOND_SEQ_LEN),
    .CLK_CORRECT_USE (CLK_CORRECT_USE),
    .CLK_COR_ADJ_LEN (CLK_COR_ADJ_LEN),
    .CLK_COR_DET_LEN (CLK_COR_DET_LEN),
    .CLK_COR_INSERT_IDLE_FLAG (CLK_COR_INSERT_IDLE_FLAG),
    .CLK_COR_KEEP_IDLE (CLK_COR_KEEP_IDLE),
    .CLK_COR_MAX_LAT (CLK_COR_MAX_LAT),
    .CLK_COR_MIN_LAT (CLK_COR_MIN_LAT),
    .CLK_COR_PRECEDENCE (CLK_COR_PRECEDENCE),
    .CLK_COR_REPEAT_WAIT (CLK_COR_REPEAT_WAIT),
    .CLK_COR_SEQ_1_1 (CLK_COR_SEQ_1_1),
    .CLK_COR_SEQ_1_2 (CLK_COR_SEQ_1_2),
    .CLK_COR_SEQ_1_3 (CLK_COR_SEQ_1_3),
    .CLK_COR_SEQ_1_4 (CLK_COR_SEQ_1_4),
    .CLK_COR_SEQ_1_ENABLE (CLK_COR_SEQ_1_ENABLE),
    .CLK_COR_SEQ_2_1 (CLK_COR_SEQ_2_1),
    .CLK_COR_SEQ_2_2 (CLK_COR_SEQ_2_2),
    .CLK_COR_SEQ_2_3 (CLK_COR_SEQ_2_3),
    .CLK_COR_SEQ_2_4 (CLK_COR_SEQ_2_4),
    .CLK_COR_SEQ_2_ENABLE (CLK_COR_SEQ_2_ENABLE),
    .CLK_COR_SEQ_2_USE (CLK_COR_SEQ_2_USE),
    .CM_TRIM (CM_TRIM),
    .COMMA_10B_ENABLE (COMMA_10B_ENABLE),
    .COMMA_DOUBLE (COMMA_DOUBLE),
    .COM_BURST_VAL (COM_BURST_VAL),
    .DEC_MCOMMA_DETECT (DEC_MCOMMA_DETECT),
    .DEC_PCOMMA_DETECT (DEC_PCOMMA_DETECT),
    .DEC_VALID_COMMA_ONLY (DEC_VALID_COMMA_ONLY),
    .DFE_CAL_TIME (DFE_CAL_TIME),
    .DFE_CFG (DFE_CFG),
    .GEARBOX_ENDEC (GEARBOX_ENDEC),
    .GEN_RXUSRCLK (GEN_RXUSRCLK),
    .GEN_TXUSRCLK (GEN_TXUSRCLK),
    .GTX_CFG_PWRUP (GTX_CFG_PWRUP),
    .MCOMMA_10B_VALUE (MCOMMA_10B_VALUE),
    .MCOMMA_DETECT (MCOMMA_DETECT),
    .OOBDETECT_THRESHOLD (OOBDETECT_THRESHOLD),
    .PCI_EXPRESS_MODE (PCI_EXPRESS_MODE),
    .PCOMMA_10B_VALUE (PCOMMA_10B_VALUE),
    .PCOMMA_DETECT (PCOMMA_DETECT),
    .PMA_CAS_CLK_EN (PMA_CAS_CLK_EN),
    .PMA_CDR_SCAN (PMA_CDR_SCAN),
    .PMA_CFG (PMA_CFG),
    .PMA_RXSYNC_CFG (PMA_RXSYNC_CFG),
    .PMA_RX_CFG (PMA_RX_CFG),
    .PMA_TX_CFG (PMA_TX_CFG),
    .POWER_SAVE (POWER_SAVE),
    .RCV_TERM_GND (RCV_TERM_GND),
    .RCV_TERM_VTTRX (RCV_TERM_VTTRX),
    .RXGEARBOX_USE (RXGEARBOX_USE),
    .RXPLL_COM_CFG (RXPLL_COM_CFG),
    .RXPLL_CP_CFG (RXPLL_CP_CFG),
    .RXPLL_DIVSEL45_FB (RXPLL_DIVSEL45_FB),
    .RXPLL_DIVSEL_FB (RXPLL_DIVSEL_FB),
    .RXPLL_DIVSEL_OUT (RXPLL_DIVSEL_OUT),
    .RXPLL_DIVSEL_REF (RXPLL_DIVSEL_REF),
    .RXPLL_LKDET_CFG (RXPLL_LKDET_CFG),
    .RXPRBSERR_LOOPBACK (RXPRBSERR_LOOPBACK),
    .RXRECCLK_CTRL (RXRECCLK_CTRL),
    .RXRECCLK_DLY (RXRECCLK_DLY),
    .RXUSRCLK_DLY (RXUSRCLK_DLY),
    .RX_BUFFER_USE (RX_BUFFER_USE),
    .RX_CLK25_DIVIDER (RX_CLK25_DIVIDER),
    .RX_DATA_WIDTH (RX_DATA_WIDTH),
    .RX_DECODE_SEQ_MATCH (RX_DECODE_SEQ_MATCH),
    .RX_DLYALIGN_CTRINC (RX_DLYALIGN_CTRINC),
    .RX_DLYALIGN_EDGESET (RX_DLYALIGN_EDGESET),
    .RX_DLYALIGN_LPFINC (RX_DLYALIGN_LPFINC),
    .RX_DLYALIGN_MONSEL (RX_DLYALIGN_MONSEL),
    .RX_DLYALIGN_OVRDSETTING (RX_DLYALIGN_OVRDSETTING),
    .RX_EN_IDLE_HOLD_CDR (RX_EN_IDLE_HOLD_CDR),
    .RX_EN_IDLE_HOLD_DFE (RX_EN_IDLE_HOLD_DFE),
    .RX_EN_IDLE_RESET_BUF (RX_EN_IDLE_RESET_BUF),
    .RX_EN_IDLE_RESET_FR (RX_EN_IDLE_RESET_FR),
    .RX_EN_IDLE_RESET_PH (RX_EN_IDLE_RESET_PH),
    .RX_EN_MODE_RESET_BUF (RX_EN_MODE_RESET_BUF),
    .RX_EN_RATE_RESET_BUF (RX_EN_RATE_RESET_BUF),
    .RX_EN_REALIGN_RESET_BUF (RX_EN_REALIGN_RESET_BUF),
    .RX_EN_REALIGN_RESET_BUF2 (RX_EN_REALIGN_RESET_BUF2),
    .RX_EYE_OFFSET (RX_EYE_OFFSET),
    .RX_EYE_SCANMODE (RX_EYE_SCANMODE),
    .RX_FIFO_ADDR_MODE (RX_FIFO_ADDR_MODE),
    .RX_IDLE_HI_CNT (RX_IDLE_HI_CNT),
    .RX_IDLE_LO_CNT (RX_IDLE_LO_CNT),
    .RX_LOSS_OF_SYNC_FSM (RX_LOSS_OF_SYNC_FSM),
    .RX_LOS_INVALID_INCR (RX_LOS_INVALID_INCR),
    .RX_LOS_THRESHOLD (RX_LOS_THRESHOLD),
    .RX_OVERSAMPLE_MODE (RX_OVERSAMPLE_MODE),
    .RX_SLIDE_AUTO_WAIT (RX_SLIDE_AUTO_WAIT),
    .RX_SLIDE_MODE (RX_SLIDE_MODE),
    .RX_XCLK_SEL (RX_XCLK_SEL),
    .SAS_MAX_COMSAS (SAS_MAX_COMSAS),
    .SAS_MIN_COMSAS (SAS_MIN_COMSAS),
    .SATA_BURST_VAL (SATA_BURST_VAL),
    .SATA_IDLE_VAL (SATA_IDLE_VAL),
    .SATA_MAX_BURST (SATA_MAX_BURST),
    .SATA_MAX_INIT (SATA_MAX_INIT),
    .SATA_MAX_WAKE (SATA_MAX_WAKE),
    .SATA_MIN_BURST (SATA_MIN_BURST),
    .SATA_MIN_INIT (SATA_MIN_INIT),
    .SATA_MIN_WAKE (SATA_MIN_WAKE),
    .SHOW_REALIGN_COMMA (SHOW_REALIGN_COMMA),
    .SIM_GTXRESET_SPEEDUP (SIM_GTXRESET_SPEEDUP),
    .SIM_RECEIVER_DETECT_PASS (SIM_RECEIVER_DETECT_PASS),
    .SIM_RXREFCLK_SOURCE (SIM_RXREFCLK_SOURCE),
    .SIM_TXREFCLK_SOURCE (SIM_TXREFCLK_SOURCE),
    .SIM_TX_ELEC_IDLE_LEVEL (SIM_TX_ELEC_IDLE_LEVEL),
    .SIM_VERSION (SIM_VERSION),	     
    .TERMINATION_CTRL (TERMINATION_CTRL),
    .TERMINATION_OVRD (TERMINATION_OVRD),
    .TRANS_TIME_FROM_P2 (TRANS_TIME_FROM_P2),
    .TRANS_TIME_NON_P2 (TRANS_TIME_NON_P2),
    .TRANS_TIME_RATE (TRANS_TIME_RATE),
    .TRANS_TIME_TO_P2 (TRANS_TIME_TO_P2),
    .TST_ATTR (TST_ATTR),
    .TXDRIVE_LOOPBACK_HIZ (TXDRIVE_LOOPBACK_HIZ),
    .TXDRIVE_LOOPBACK_PD (TXDRIVE_LOOPBACK_PD),
    .TXGEARBOX_USE (TXGEARBOX_USE),
    .TXOUTCLK_CTRL (TXOUTCLK_CTRL),
    .TXOUTCLK_DLY (TXOUTCLK_DLY),
    .TXPLL_COM_CFG (TXPLL_COM_CFG),
    .TXPLL_CP_CFG (TXPLL_CP_CFG),
    .TXPLL_DIVSEL45_FB (TXPLL_DIVSEL45_FB),
    .TXPLL_DIVSEL_FB (TXPLL_DIVSEL_FB),
    .TXPLL_DIVSEL_OUT (TXPLL_DIVSEL_OUT),
    .TXPLL_DIVSEL_REF (TXPLL_DIVSEL_REF),
    .TXPLL_LKDET_CFG (TXPLL_LKDET_CFG),
    .TXPLL_SATA (TXPLL_SATA),
    .TX_BUFFER_USE (TX_BUFFER_USE),
    .TX_BYTECLK_CFG (TX_BYTECLK_CFG),
    .TX_CLK25_DIVIDER (TX_CLK25_DIVIDER),
    .TX_CLK_SOURCE (TX_CLK_SOURCE),
    .TX_DATA_WIDTH (TX_DATA_WIDTH),
    .TX_DEEMPH_0 (TX_DEEMPH_0),
    .TX_DEEMPH_1 (TX_DEEMPH_1),
    .TX_DETECT_RX_CFG (TX_DETECT_RX_CFG),
    .TX_DLYALIGN_CTRINC (TX_DLYALIGN_CTRINC),
    .TX_DLYALIGN_LPFINC (TX_DLYALIGN_LPFINC),
    .TX_DLYALIGN_MONSEL (TX_DLYALIGN_MONSEL),
    .TX_DLYALIGN_OVRDSETTING (TX_DLYALIGN_OVRDSETTING),
    .TX_DRIVE_MODE (TX_DRIVE_MODE),
    .TX_EN_RATE_RESET_BUF (TX_EN_RATE_RESET_BUF),
    .TX_IDLE_ASSERT_DELAY (TX_IDLE_ASSERT_DELAY),
    .TX_IDLE_DEASSERT_DELAY (TX_IDLE_DEASSERT_DELAY),
    .TX_MARGIN_FULL_0 (TX_MARGIN_FULL_0),
    .TX_MARGIN_FULL_1 (TX_MARGIN_FULL_1),
    .TX_MARGIN_FULL_2 (TX_MARGIN_FULL_2),
    .TX_MARGIN_FULL_3 (TX_MARGIN_FULL_3),
    .TX_MARGIN_FULL_4 (TX_MARGIN_FULL_4),
    .TX_MARGIN_LOW_0 (TX_MARGIN_LOW_0),
    .TX_MARGIN_LOW_1 (TX_MARGIN_LOW_1),
    .TX_MARGIN_LOW_2 (TX_MARGIN_LOW_2),
    .TX_MARGIN_LOW_3 (TX_MARGIN_LOW_3),
    .TX_MARGIN_LOW_4 (TX_MARGIN_LOW_4),
    .TX_OVERSAMPLE_MODE (TX_OVERSAMPLE_MODE),
    .TX_PMADATA_OPT (TX_PMADATA_OPT),
    .TX_TDCC_CFG (TX_TDCC_CFG),
    .TX_USRCLK_CFG (TX_USRCLK_CFG),
    .TX_XCLK_SEL (TX_XCLK_SEL))

   B_GTXE1_INST(
    .COMFINISH (delay_COMFINISH),
    .COMINITDET (delay_COMINITDET),
    .COMSASDET (delay_COMSASDET),
    .COMWAKEDET (delay_COMWAKEDET),
    .DFECLKDLYADJMON (delay_DFECLKDLYADJMON),
    .DFEEYEDACMON (delay_DFEEYEDACMON),
    .DFESENSCAL (delay_DFESENSCAL),
    .DFETAP1MONITOR (delay_DFETAP1MONITOR),
    .DFETAP2MONITOR (delay_DFETAP2MONITOR),
    .DFETAP3MONITOR (delay_DFETAP3MONITOR),
    .DFETAP4MONITOR (delay_DFETAP4MONITOR),
    .DRDY (delay_DRDY),
    .DRPDO (delay_DRPDO),
    .MGTREFCLKFAB (delay_MGTREFCLKFAB),
    .PHYSTATUS (delay_PHYSTATUS),
    .RXBUFSTATUS (delay_RXBUFSTATUS),
    .RXBYTEISALIGNED (delay_RXBYTEISALIGNED),
    .RXBYTEREALIGN (delay_RXBYTEREALIGN),
    .RXCHANBONDSEQ (delay_RXCHANBONDSEQ),
    .RXCHANISALIGNED (delay_RXCHANISALIGNED),
    .RXCHANREALIGN (delay_RXCHANREALIGN),
    .RXCHARISCOMMA (delay_RXCHARISCOMMA),
    .RXCHARISK (delay_RXCHARISK),
    .RXCHBONDO (delay_RXCHBONDO),
    .RXCLKCORCNT (delay_RXCLKCORCNT),
    .RXCOMMADET (delay_RXCOMMADET),
    .RXDATA (delay_RXDATA),
    .RXDATAVALID (delay_RXDATAVALID),
    .RXDISPERR (delay_RXDISPERR),
    .RXDLYALIGNMONITOR (delay_RXDLYALIGNMONITOR),
    .RXELECIDLE (delay_RXELECIDLE),
    .RXHEADER (delay_RXHEADER),
    .RXHEADERVALID (delay_RXHEADERVALID),
    .RXLOSSOFSYNC (delay_RXLOSSOFSYNC),
    .RXNOTINTABLE (delay_RXNOTINTABLE),
    .RXOVERSAMPLEERR (delay_RXOVERSAMPLEERR),
    .RXPLLLKDET (delay_RXPLLLKDET),
    .RXPRBSERR (delay_RXPRBSERR),
    .RXRATEDONE (delay_RXRATEDONE),
    .RXRECCLK (delay_RXRECCLK),
    .RXRECCLKPCS (delay_RXRECCLKPCS),
    .RXRESETDONE (delay_RXRESETDONE),
    .RXRUNDISP (delay_RXRUNDISP),
    .RXSTARTOFSEQ (delay_RXSTARTOFSEQ),
    .RXSTATUS (delay_RXSTATUS),
    .RXVALID (delay_RXVALID),
    .TSTOUT (delay_TSTOUT),
    .TXBUFSTATUS (delay_TXBUFSTATUS),
    .TXDLYALIGNMONITOR (delay_TXDLYALIGNMONITOR),
    .TXGEARBOXREADY (delay_TXGEARBOXREADY),
    .TXKERR (delay_TXKERR),
    .TXN (delay_TXN),
    .TXOUTCLK (delay_TXOUTCLK),
    .TXOUTCLKPCS (delay_TXOUTCLKPCS),
    .TXP (delay_TXP),
    .TXPLLLKDET (delay_TXPLLLKDET),
    .TXRATEDONE (delay_TXRATEDONE),
    .TXRESETDONE (delay_TXRESETDONE),
    .TXRUNDISP (delay_TXRUNDISP),
    .DADDR (delay_DADDR),
    .DCLK (delay_DCLK),
    .DEN (delay_DEN),
    .DFECLKDLYADJ (delay_DFECLKDLYADJ),
    .DFEDLYOVRD (delay_DFEDLYOVRD),
    .DFETAP1 (delay_DFETAP1),
    .DFETAP2 (delay_DFETAP2),
    .DFETAP3 (delay_DFETAP3),
    .DFETAP4 (delay_DFETAP4),
    .DFETAPOVRD (delay_DFETAPOVRD),
    .DI (delay_DI),
    .DWE (delay_DWE),
    .GATERXELECIDLE (delay_GATERXELECIDLE), 
    .GREFCLKRX (delay_GREFCLKRX),
    .GREFCLKTX (delay_GREFCLKTX),
    .GTXRXRESET (delay_GTXRXRESET), 
    .GTXTEST (delay_GTXTEST), 
    .GTXTXRESET (delay_GTXTXRESET),
    .IGNORESIGDET (delay_IGNORESIGDET), 
    .LOOPBACK (delay_LOOPBACK), 
    .MGTREFCLKRX (delay_MGTREFCLKRX),
    .MGTREFCLKTX (delay_MGTREFCLKTX),
    .NORTHREFCLKRX (delay_NORTHREFCLKRX),
    .NORTHREFCLKTX (delay_NORTHREFCLKTX),
    .PERFCLKRX (delay_PERFCLKRX),
    .PERFCLKTX (delay_PERFCLKTX),
    .PLLRXRESET (delay_PLLRXRESET), 
    .PLLTXRESET (delay_PLLTXRESET), 
    .PRBSCNTRESET (delay_PRBSCNTRESET),
    .RXBUFRESET (delay_RXBUFRESET), 
    .RXCDRRESET (delay_RXCDRRESET), 
    .RXCHBONDI (delay_RXCHBONDI),
    .RXCHBONDLEVEL (delay_RXCHBONDLEVEL),
    .RXCHBONDMASTER (delay_RXCHBONDMASTER),
    .RXCHBONDSLAVE (delay_RXCHBONDSLAVE),
    .RXCOMMADETUSE (delay_RXCOMMADETUSE),
    .RXDEC8B10BUSE (delay_RXDEC8B10BUSE),
    .RXDLYALIGNDISABLE (delay_RXDLYALIGNDISABLE),
    .RXDLYALIGNMONENB (delay_RXDLYALIGNMONENB),	
    .RXDLYALIGNOVERRIDE (delay_RXDLYALIGNOVERRIDE), 
    .RXDLYALIGNRESET (delay_RXDLYALIGNRESET), 
    .RXDLYALIGNSWPPRECURB (delay_RXDLYALIGNSWPPRECURB), 
    .RXDLYALIGNUPDSW (delay_RXDLYALIGNUPDSW), 
    .RXENCHANSYNC (delay_RXENCHANSYNC),
    .RXENMCOMMAALIGN (delay_RXENMCOMMAALIGN),
    .RXENPCOMMAALIGN (delay_RXENPCOMMAALIGN),
    .RXENPMAPHASEALIGN (delay_RXENPMAPHASEALIGN), 
    .RXENPRBSTST (delay_RXENPRBSTST),
    .RXENSAMPLEALIGN (delay_RXENSAMPLEALIGN),
    .RXEQMIX (delay_RXEQMIX), 
    .RXGEARBOXSLIP (delay_RXGEARBOXSLIP),
    .RXN (delay_RXN),
    .RXP (delay_RXP),
    .RXPLLLKDETEN (delay_RXPLLLKDETEN), 
    .RXPLLPOWERDOWN (delay_RXPLLPOWERDOWN), 
    .RXPLLREFSELDY (delay_RXPLLREFSELDY), 
    .RXPMASETPHASE (delay_RXPMASETPHASE), 
    .RXPOLARITY (delay_RXPOLARITY),
    .RXPOWERDOWN (delay_RXPOWERDOWN), 
    .RXRATE (delay_RXRATE),
    .RXRESET (delay_RXRESET), 
    .RXSLIDE (delay_RXSLIDE),
    .RXUSRCLK (delay_RXUSRCLK),
    .RXUSRCLK2 (delay_RXUSRCLK2),
    .SOUTHREFCLKRX (delay_SOUTHREFCLKRX),
    .SOUTHREFCLKTX (delay_SOUTHREFCLKTX),
    .TSTCLK0 (delay_TSTCLK0),
    .TSTCLK1 (delay_TSTCLK1),
    .TSTIN (delay_TSTIN), 
    .TXBUFDIFFCTRL (delay_TXBUFDIFFCTRL), 
    .TXBYPASS8B10B (delay_TXBYPASS8B10B),
    .TXCHARDISPMODE (delay_TXCHARDISPMODE),
    .TXCHARDISPVAL (delay_TXCHARDISPVAL),
    .TXCHARISK (delay_TXCHARISK),
    .TXCOMINIT (delay_TXCOMINIT),
    .TXCOMSAS (delay_TXCOMSAS),
    .TXCOMWAKE (delay_TXCOMWAKE),
    .TXDATA (delay_TXDATA),
    .TXDEEMPH (delay_TXDEEMPH), 
    .TXDETECTRX (delay_TXDETECTRX),
    .TXDIFFCTRL (delay_TXDIFFCTRL),
    .TXDLYALIGNDISABLE (delay_TXDLYALIGNDISABLE),
    .TXDLYALIGNMONENB (delay_TXDLYALIGNMONENB),	
    .TXDLYALIGNOVERRIDE (delay_TXDLYALIGNOVERRIDE), 
    .TXDLYALIGNRESET (delay_TXDLYALIGNRESET), 
    .TXDLYALIGNUPDSW (delay_TXDLYALIGNUPDSW) ,
    .TXELECIDLE (delay_TXELECIDLE),
    .TXENC8B10BUSE (delay_TXENC8B10BUSE),
    .TXENPMAPHASEALIGN (delay_TXENPMAPHASEALIGN), 
    .TXENPRBSTST (delay_TXENPRBSTST),
    .TXHEADER (delay_TXHEADER),
    .TXINHIBIT (delay_TXINHIBIT),
    .TXMARGIN (delay_TXMARGIN),
    .TXPDOWNASYNCH (delay_TXPDOWNASYNCH),
    .TXPLLLKDETEN (delay_TXPLLLKDETEN), 
    .TXPLLPOWERDOWN (delay_TXPLLPOWERDOWN), 
    .TXPLLREFSELDY (delay_TXPLLREFSELDY), 
    .TXPMASETPHASE (delay_TXPMASETPHASE), 
    .TXPOLARITY (delay_TXPOLARITY),
    .TXPOSTEMPHASIS (delay_TXPOSTEMPHASIS),
    .TXPOWERDOWN (delay_TXPOWERDOWN),
    .TXPRBSFORCEERR (delay_TXPRBSFORCEERR),
    .TXPREEMPHASIS (delay_TXPREEMPHASIS),
    .TXRATE (delay_TXRATE),
    .TXRESET (delay_TXRESET),
    .TXSEQUENCE (delay_TXSEQUENCE),
    .TXSTARTSEQ (delay_TXSTARTSEQ),
    .TXSWING (delay_TXSWING),
    .TXUSRCLK (delay_TXUSRCLK),
    .TXUSRCLK2 (delay_TXUSRCLK2),
    .USRCODEERR (delay_USRCODEERR),
    .GSR(GSR)
  );

  specify
    $period (posedge DCLK, 0:0:0, notifier);
    $period (posedge GREFCLKRX, 0:0:0, notifier);
    $period (posedge GREFCLKTX, 0:0:0, notifier);
    $period (posedge MGTREFCLKRX[0], 0:0:0, notifier);
    $period (posedge MGTREFCLKRX[1], 0:0:0, notifier);
    $period (posedge MGTREFCLKTX[0], 0:0:0, notifier);
    $period (posedge MGTREFCLKTX[1], 0:0:0, notifier);
    $period (posedge NORTHREFCLKRX[0], 0:0:0, notifier);
    $period (posedge NORTHREFCLKRX[1], 0:0:0, notifier);
    $period (posedge NORTHREFCLKTX[0], 0:0:0, notifier);
    $period (posedge NORTHREFCLKTX[1], 0:0:0, notifier);
    $period (posedge PERFCLKRX, 0:0:0, notifier);
    $period (posedge PERFCLKTX, 0:0:0, notifier);
    $period (posedge RXUSRCLK, 0:0:0, notifier);
    $period (posedge RXUSRCLK2, 0:0:0, notifier);
    $period (posedge SOUTHREFCLKRX[0], 0:0:0, notifier);
    $period (posedge SOUTHREFCLKRX[1], 0:0:0, notifier);
    $period (posedge SOUTHREFCLKTX[0], 0:0:0, notifier);
    $period (posedge SOUTHREFCLKTX[1], 0:0:0, notifier);
    $period (posedge TSTCLK0, 0:0:0, notifier);
    $period (posedge TSTCLK1, 0:0:0, notifier);
    $period (posedge TXUSRCLK, 0:0:0, notifier);
    $period (posedge TXUSRCLK2, 0:0:0, notifier);
    $setuphold (posedge DCLK, negedge DADDR[0], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DADDR[0]);
    $setuphold (posedge DCLK, negedge DADDR[1], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DADDR[1]);
    $setuphold (posedge DCLK, negedge DADDR[2], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DADDR[2]);
    $setuphold (posedge DCLK, negedge DADDR[3], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DADDR[3]);
    $setuphold (posedge DCLK, negedge DADDR[4], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DADDR[4]);
    $setuphold (posedge DCLK, negedge DADDR[5], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DADDR[5]);
    $setuphold (posedge DCLK, negedge DADDR[6], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DADDR[6]);
    $setuphold (posedge DCLK, negedge DADDR[7], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DADDR[7]);
    $setuphold (posedge DCLK, negedge DEN, 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DEN);
    $setuphold (posedge DCLK, negedge DI[0], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[0]);
    $setuphold (posedge DCLK, negedge DI[10], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[10]);
    $setuphold (posedge DCLK, negedge DI[11], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[11]);
    $setuphold (posedge DCLK, negedge DI[12], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[12]);
    $setuphold (posedge DCLK, negedge DI[13], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[13]);
    $setuphold (posedge DCLK, negedge DI[14], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[14]);
    $setuphold (posedge DCLK, negedge DI[15], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[15]);
    $setuphold (posedge DCLK, negedge DI[1], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[1]);
    $setuphold (posedge DCLK, negedge DI[2], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[2]);
    $setuphold (posedge DCLK, negedge DI[3], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[3]);
    $setuphold (posedge DCLK, negedge DI[4], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[4]);
    $setuphold (posedge DCLK, negedge DI[5], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[5]);
    $setuphold (posedge DCLK, negedge DI[6], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[6]);
    $setuphold (posedge DCLK, negedge DI[7], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[7]);
    $setuphold (posedge DCLK, negedge DI[8], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[8]);
    $setuphold (posedge DCLK, negedge DI[9], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[9]);
    $setuphold (posedge DCLK, negedge DWE, 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DWE);
    $setuphold (posedge DCLK, posedge DADDR[0], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DADDR[0]);
    $setuphold (posedge DCLK, posedge DADDR[1], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DADDR[1]);
    $setuphold (posedge DCLK, posedge DADDR[2], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DADDR[2]);
    $setuphold (posedge DCLK, posedge DADDR[3], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DADDR[3]);
    $setuphold (posedge DCLK, posedge DADDR[4], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DADDR[4]);
    $setuphold (posedge DCLK, posedge DADDR[5], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DADDR[5]);
    $setuphold (posedge DCLK, posedge DADDR[6], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DADDR[6]);
    $setuphold (posedge DCLK, posedge DADDR[7], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DADDR[7]);
    $setuphold (posedge DCLK, posedge DEN, 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DEN);
    $setuphold (posedge DCLK, posedge DI[0], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[0]);
    $setuphold (posedge DCLK, posedge DI[10], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[10]);
    $setuphold (posedge DCLK, posedge DI[11], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[11]);
    $setuphold (posedge DCLK, posedge DI[12], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[12]);
    $setuphold (posedge DCLK, posedge DI[13], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[13]);
    $setuphold (posedge DCLK, posedge DI[14], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[14]);
    $setuphold (posedge DCLK, posedge DI[15], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[15]);
    $setuphold (posedge DCLK, posedge DI[1], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[1]);
    $setuphold (posedge DCLK, posedge DI[2], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[2]);
    $setuphold (posedge DCLK, posedge DI[3], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[3]);
    $setuphold (posedge DCLK, posedge DI[4], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[4]);
    $setuphold (posedge DCLK, posedge DI[5], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[5]);
    $setuphold (posedge DCLK, posedge DI[6], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[6]);
    $setuphold (posedge DCLK, posedge DI[7], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[7]);
    $setuphold (posedge DCLK, posedge DI[8], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[8]);
    $setuphold (posedge DCLK, posedge DI[9], 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DI[9]);
    $setuphold (posedge DCLK, posedge DWE, 0:0:0, 0:0:0, notifier,,, delay_DCLK, delay_DWE);
    $setuphold (posedge RXUSRCLK, negedge RXCHBONDI[0], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK, delay_RXCHBONDI[0]);
    $setuphold (posedge RXUSRCLK, negedge RXCHBONDI[1], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK, delay_RXCHBONDI[1]);
    $setuphold (posedge RXUSRCLK, negedge RXCHBONDI[2], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK, delay_RXCHBONDI[2]);
    $setuphold (posedge RXUSRCLK, negedge RXCHBONDI[3], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK, delay_RXCHBONDI[3]);
    $setuphold (posedge RXUSRCLK, posedge RXCHBONDI[0], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK, delay_RXCHBONDI[0]);
    $setuphold (posedge RXUSRCLK, posedge RXCHBONDI[1], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK, delay_RXCHBONDI[1]);
    $setuphold (posedge RXUSRCLK, posedge RXCHBONDI[2], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK, delay_RXCHBONDI[2]);
    $setuphold (posedge RXUSRCLK, posedge RXCHBONDI[3], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK, delay_RXCHBONDI[3]);
    $setuphold (posedge RXUSRCLK2, negedge DFECLKDLYADJ[0], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFECLKDLYADJ[0]);
    $setuphold (posedge RXUSRCLK2, negedge DFECLKDLYADJ[1], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFECLKDLYADJ[1]);
    $setuphold (posedge RXUSRCLK2, negedge DFECLKDLYADJ[2], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFECLKDLYADJ[2]);
    $setuphold (posedge RXUSRCLK2, negedge DFECLKDLYADJ[3], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFECLKDLYADJ[3]);
    $setuphold (posedge RXUSRCLK2, negedge DFECLKDLYADJ[4], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFECLKDLYADJ[4]);
    $setuphold (posedge RXUSRCLK2, negedge DFECLKDLYADJ[5], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFECLKDLYADJ[5]);
    $setuphold (posedge RXUSRCLK2, negedge DFEDLYOVRD, 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFEDLYOVRD);
    $setuphold (posedge RXUSRCLK2, negedge DFETAP1[0], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP1[0]);
    $setuphold (posedge RXUSRCLK2, negedge DFETAP1[1], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP1[1]);
    $setuphold (posedge RXUSRCLK2, negedge DFETAP1[2], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP1[2]);
    $setuphold (posedge RXUSRCLK2, negedge DFETAP1[3], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP1[3]);
    $setuphold (posedge RXUSRCLK2, negedge DFETAP1[4], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP1[4]);
    $setuphold (posedge RXUSRCLK2, negedge DFETAP2[0], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP2[0]);
    $setuphold (posedge RXUSRCLK2, negedge DFETAP2[1], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP2[1]);
    $setuphold (posedge RXUSRCLK2, negedge DFETAP2[2], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP2[2]);
    $setuphold (posedge RXUSRCLK2, negedge DFETAP2[3], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP2[3]);
    $setuphold (posedge RXUSRCLK2, negedge DFETAP2[4], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP2[4]);
    $setuphold (posedge RXUSRCLK2, negedge DFETAP3[0], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP3[0]);
    $setuphold (posedge RXUSRCLK2, negedge DFETAP3[1], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP3[1]);
    $setuphold (posedge RXUSRCLK2, negedge DFETAP3[2], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP3[2]);
    $setuphold (posedge RXUSRCLK2, negedge DFETAP3[3], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP3[3]);
    $setuphold (posedge RXUSRCLK2, negedge DFETAP4[0], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP4[0]);
    $setuphold (posedge RXUSRCLK2, negedge DFETAP4[1], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP4[1]);
    $setuphold (posedge RXUSRCLK2, negedge DFETAP4[2], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP4[2]);
    $setuphold (posedge RXUSRCLK2, negedge DFETAP4[3], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP4[3]);
    $setuphold (posedge RXUSRCLK2, negedge DFETAPOVRD, 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAPOVRD);
    $setuphold (posedge RXUSRCLK2, negedge PRBSCNTRESET, 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_PRBSCNTRESET);
    $setuphold (posedge RXUSRCLK2, negedge RXCHBONDI[0], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXCHBONDI[0]);
    $setuphold (posedge RXUSRCLK2, negedge RXCHBONDI[1], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXCHBONDI[1]);
    $setuphold (posedge RXUSRCLK2, negedge RXCHBONDI[2], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXCHBONDI[2]);
    $setuphold (posedge RXUSRCLK2, negedge RXCHBONDI[3], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXCHBONDI[3]);
    $setuphold (posedge RXUSRCLK2, negedge RXCHBONDLEVEL[0], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXCHBONDLEVEL[0]);
    $setuphold (posedge RXUSRCLK2, negedge RXCHBONDLEVEL[1], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXCHBONDLEVEL[1]);
    $setuphold (posedge RXUSRCLK2, negedge RXCHBONDLEVEL[2], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXCHBONDLEVEL[2]);
    $setuphold (posedge RXUSRCLK2, negedge RXCHBONDMASTER, 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXCHBONDMASTER);
    $setuphold (posedge RXUSRCLK2, negedge RXCHBONDSLAVE, 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXCHBONDSLAVE);
    $setuphold (posedge RXUSRCLK2, negedge RXCOMMADETUSE, 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXCOMMADETUSE);
    $setuphold (posedge RXUSRCLK2, negedge RXDEC8B10BUSE, 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXDEC8B10BUSE);
    $setuphold (posedge RXUSRCLK2, negedge RXENCHANSYNC, 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXENCHANSYNC);
    $setuphold (posedge RXUSRCLK2, negedge RXENMCOMMAALIGN, 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXENMCOMMAALIGN);
    $setuphold (posedge RXUSRCLK2, negedge RXENPCOMMAALIGN, 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXENPCOMMAALIGN);
    $setuphold (posedge RXUSRCLK2, negedge RXENPRBSTST[0], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXENPRBSTST[0]);
    $setuphold (posedge RXUSRCLK2, negedge RXENPRBSTST[1], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXENPRBSTST[1]);
    $setuphold (posedge RXUSRCLK2, negedge RXENPRBSTST[2], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXENPRBSTST[2]);
    $setuphold (posedge RXUSRCLK2, negedge RXENSAMPLEALIGN, 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXENSAMPLEALIGN);
    $setuphold (posedge RXUSRCLK2, negedge RXGEARBOXSLIP, 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXGEARBOXSLIP);
    $setuphold (posedge RXUSRCLK2, negedge RXPOLARITY, 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXPOLARITY);
    $setuphold (posedge RXUSRCLK2, negedge RXRATE[0], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXRATE[0]);
    $setuphold (posedge RXUSRCLK2, negedge RXRATE[1], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXRATE[1]);
    $setuphold (posedge RXUSRCLK2, negedge RXSLIDE, 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXSLIDE);
    $setuphold (posedge RXUSRCLK2, negedge USRCODEERR, 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_USRCODEERR);
    $setuphold (posedge RXUSRCLK2, posedge DFECLKDLYADJ[0], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFECLKDLYADJ[0]);
    $setuphold (posedge RXUSRCLK2, posedge DFECLKDLYADJ[1], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFECLKDLYADJ[1]);
    $setuphold (posedge RXUSRCLK2, posedge DFECLKDLYADJ[2], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFECLKDLYADJ[2]);
    $setuphold (posedge RXUSRCLK2, posedge DFECLKDLYADJ[3], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFECLKDLYADJ[3]);
    $setuphold (posedge RXUSRCLK2, posedge DFECLKDLYADJ[4], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFECLKDLYADJ[4]);
    $setuphold (posedge RXUSRCLK2, posedge DFECLKDLYADJ[5], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFECLKDLYADJ[5]);
    $setuphold (posedge RXUSRCLK2, posedge DFEDLYOVRD, 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFEDLYOVRD);
    $setuphold (posedge RXUSRCLK2, posedge DFETAP1[0], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP1[0]);
    $setuphold (posedge RXUSRCLK2, posedge DFETAP1[1], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP1[1]);
    $setuphold (posedge RXUSRCLK2, posedge DFETAP1[2], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP1[2]);
    $setuphold (posedge RXUSRCLK2, posedge DFETAP1[3], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP1[3]);
    $setuphold (posedge RXUSRCLK2, posedge DFETAP1[4], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP1[4]);
    $setuphold (posedge RXUSRCLK2, posedge DFETAP2[0], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP2[0]);
    $setuphold (posedge RXUSRCLK2, posedge DFETAP2[1], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP2[1]);
    $setuphold (posedge RXUSRCLK2, posedge DFETAP2[2], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP2[2]);
    $setuphold (posedge RXUSRCLK2, posedge DFETAP2[3], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP2[3]);
    $setuphold (posedge RXUSRCLK2, posedge DFETAP2[4], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP2[4]);
    $setuphold (posedge RXUSRCLK2, posedge DFETAP3[0], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP3[0]);
    $setuphold (posedge RXUSRCLK2, posedge DFETAP3[1], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP3[1]);
    $setuphold (posedge RXUSRCLK2, posedge DFETAP3[2], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP3[2]);
    $setuphold (posedge RXUSRCLK2, posedge DFETAP3[3], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP3[3]);
    $setuphold (posedge RXUSRCLK2, posedge DFETAP4[0], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP4[0]);
    $setuphold (posedge RXUSRCLK2, posedge DFETAP4[1], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP4[1]);
    $setuphold (posedge RXUSRCLK2, posedge DFETAP4[2], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP4[2]);
    $setuphold (posedge RXUSRCLK2, posedge DFETAP4[3], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAP4[3]);
    $setuphold (posedge RXUSRCLK2, posedge DFETAPOVRD, 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_DFETAPOVRD);
    $setuphold (posedge RXUSRCLK2, posedge PRBSCNTRESET, 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_PRBSCNTRESET);
    $setuphold (posedge RXUSRCLK2, posedge RXCHBONDI[0], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXCHBONDI[0]);
    $setuphold (posedge RXUSRCLK2, posedge RXCHBONDI[1], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXCHBONDI[1]);
    $setuphold (posedge RXUSRCLK2, posedge RXCHBONDI[2], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXCHBONDI[2]);
    $setuphold (posedge RXUSRCLK2, posedge RXCHBONDI[3], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXCHBONDI[3]);
    $setuphold (posedge RXUSRCLK2, posedge RXCHBONDLEVEL[0], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXCHBONDLEVEL[0]);
    $setuphold (posedge RXUSRCLK2, posedge RXCHBONDLEVEL[1], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXCHBONDLEVEL[1]);
    $setuphold (posedge RXUSRCLK2, posedge RXCHBONDLEVEL[2], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXCHBONDLEVEL[2]);
    $setuphold (posedge RXUSRCLK2, posedge RXCHBONDMASTER, 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXCHBONDMASTER);
    $setuphold (posedge RXUSRCLK2, posedge RXCHBONDSLAVE, 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXCHBONDSLAVE);
    $setuphold (posedge RXUSRCLK2, posedge RXCOMMADETUSE, 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXCOMMADETUSE);
    $setuphold (posedge RXUSRCLK2, posedge RXDEC8B10BUSE, 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXDEC8B10BUSE);
    $setuphold (posedge RXUSRCLK2, posedge RXENCHANSYNC, 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXENCHANSYNC);
    $setuphold (posedge RXUSRCLK2, posedge RXENMCOMMAALIGN, 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXENMCOMMAALIGN);
    $setuphold (posedge RXUSRCLK2, posedge RXENPCOMMAALIGN, 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXENPCOMMAALIGN);
    $setuphold (posedge RXUSRCLK2, posedge RXENPRBSTST[0], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXENPRBSTST[0]);
    $setuphold (posedge RXUSRCLK2, posedge RXENPRBSTST[1], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXENPRBSTST[1]);
    $setuphold (posedge RXUSRCLK2, posedge RXENPRBSTST[2], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXENPRBSTST[2]);
    $setuphold (posedge RXUSRCLK2, posedge RXENSAMPLEALIGN, 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXENSAMPLEALIGN);
    $setuphold (posedge RXUSRCLK2, posedge RXGEARBOXSLIP, 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXGEARBOXSLIP);
    $setuphold (posedge RXUSRCLK2, posedge RXPOLARITY, 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXPOLARITY);
    $setuphold (posedge RXUSRCLK2, posedge RXRATE[0], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXRATE[0]);
    $setuphold (posedge RXUSRCLK2, posedge RXRATE[1], 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXRATE[1]);
    $setuphold (posedge RXUSRCLK2, posedge RXSLIDE, 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_RXSLIDE);
    $setuphold (posedge RXUSRCLK2, posedge USRCODEERR, 0:0:0, 0:0:0, notifier,,, delay_RXUSRCLK2, delay_USRCODEERR);
    $setuphold (posedge TXUSRCLK2, negedge TXBYPASS8B10B[0], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXBYPASS8B10B[0]);
    $setuphold (posedge TXUSRCLK2, negedge TXBYPASS8B10B[1], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXBYPASS8B10B[1]);
    $setuphold (posedge TXUSRCLK2, negedge TXBYPASS8B10B[2], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXBYPASS8B10B[2]);
    $setuphold (posedge TXUSRCLK2, negedge TXBYPASS8B10B[3], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXBYPASS8B10B[3]);
    $setuphold (posedge TXUSRCLK2, negedge TXCHARDISPMODE[0], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXCHARDISPMODE[0]);
    $setuphold (posedge TXUSRCLK2, negedge TXCHARDISPMODE[1], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXCHARDISPMODE[1]);
    $setuphold (posedge TXUSRCLK2, negedge TXCHARDISPMODE[2], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXCHARDISPMODE[2]);
    $setuphold (posedge TXUSRCLK2, negedge TXCHARDISPMODE[3], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXCHARDISPMODE[3]);
    $setuphold (posedge TXUSRCLK2, negedge TXCHARDISPVAL[0], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXCHARDISPVAL[0]);
    $setuphold (posedge TXUSRCLK2, negedge TXCHARDISPVAL[1], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXCHARDISPVAL[1]);
    $setuphold (posedge TXUSRCLK2, negedge TXCHARDISPVAL[2], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXCHARDISPVAL[2]);
    $setuphold (posedge TXUSRCLK2, negedge TXCHARDISPVAL[3], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXCHARDISPVAL[3]);
    $setuphold (posedge TXUSRCLK2, negedge TXCHARISK[0], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXCHARISK[0]);
    $setuphold (posedge TXUSRCLK2, negedge TXCHARISK[1], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXCHARISK[1]);
    $setuphold (posedge TXUSRCLK2, negedge TXCHARISK[2], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXCHARISK[2]);
    $setuphold (posedge TXUSRCLK2, negedge TXCHARISK[3], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXCHARISK[3]);
    $setuphold (posedge TXUSRCLK2, negedge TXCOMINIT, 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXCOMINIT);
    $setuphold (posedge TXUSRCLK2, negedge TXCOMSAS, 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXCOMSAS);
    $setuphold (posedge TXUSRCLK2, negedge TXCOMWAKE, 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXCOMWAKE);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[0], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[0]);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[10], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[10]);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[11], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[11]);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[12], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[12]);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[13], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[13]);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[14], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[14]);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[15], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[15]);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[16], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[16]);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[17], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[17]);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[18], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[18]);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[19], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[19]);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[1], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[1]);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[20], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[20]);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[21], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[21]);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[22], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[22]);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[23], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[23]);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[24], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[24]);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[25], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[25]);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[26], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[26]);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[27], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[27]);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[28], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[28]);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[29], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[29]);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[2], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[2]);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[30], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[30]);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[31], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[31]);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[3], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[3]);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[4], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[4]);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[5], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[5]);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[6], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[6]);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[7], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[7]);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[8], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[8]);
    $setuphold (posedge TXUSRCLK2, negedge TXDATA[9], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[9]);
    $setuphold (posedge TXUSRCLK2, negedge TXDETECTRX, 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDETECTRX);
    $setuphold (posedge TXUSRCLK2, negedge TXELECIDLE, 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXELECIDLE);
    $setuphold (posedge TXUSRCLK2, negedge TXENC8B10BUSE, 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXENC8B10BUSE);
    $setuphold (posedge TXUSRCLK2, negedge TXENPRBSTST[0], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXENPRBSTST[0]);
    $setuphold (posedge TXUSRCLK2, negedge TXENPRBSTST[1], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXENPRBSTST[1]);
    $setuphold (posedge TXUSRCLK2, negedge TXENPRBSTST[2], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXENPRBSTST[2]);
    $setuphold (posedge TXUSRCLK2, negedge TXHEADER[0], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXHEADER[0]);
    $setuphold (posedge TXUSRCLK2, negedge TXHEADER[1], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXHEADER[1]);
    $setuphold (posedge TXUSRCLK2, negedge TXHEADER[2], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXHEADER[2]);
    $setuphold (posedge TXUSRCLK2, negedge TXINHIBIT, 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXINHIBIT);
    $setuphold (posedge TXUSRCLK2, negedge TXPOLARITY, 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXPOLARITY);
    $setuphold (posedge TXUSRCLK2, negedge TXPOWERDOWN[0], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXPOWERDOWN[0]);
    $setuphold (posedge TXUSRCLK2, negedge TXPOWERDOWN[1], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXPOWERDOWN[1]);
    $setuphold (posedge TXUSRCLK2, negedge TXPRBSFORCEERR, 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXPRBSFORCEERR);
    $setuphold (posedge TXUSRCLK2, negedge TXRATE[0], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXRATE[0]);
    $setuphold (posedge TXUSRCLK2, negedge TXRATE[1], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXRATE[1]);
    $setuphold (posedge TXUSRCLK2, negedge TXSEQUENCE[0], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXSEQUENCE[0]);
    $setuphold (posedge TXUSRCLK2, negedge TXSEQUENCE[1], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXSEQUENCE[1]);
    $setuphold (posedge TXUSRCLK2, negedge TXSEQUENCE[2], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXSEQUENCE[2]);
    $setuphold (posedge TXUSRCLK2, negedge TXSEQUENCE[3], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXSEQUENCE[3]);
    $setuphold (posedge TXUSRCLK2, negedge TXSEQUENCE[4], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXSEQUENCE[4]);
    $setuphold (posedge TXUSRCLK2, negedge TXSEQUENCE[5], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXSEQUENCE[5]);
    $setuphold (posedge TXUSRCLK2, negedge TXSEQUENCE[6], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXSEQUENCE[6]);
    $setuphold (posedge TXUSRCLK2, negedge TXSTARTSEQ, 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXSTARTSEQ);
    $setuphold (posedge TXUSRCLK2, posedge TXBYPASS8B10B[0], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXBYPASS8B10B[0]);
    $setuphold (posedge TXUSRCLK2, posedge TXBYPASS8B10B[1], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXBYPASS8B10B[1]);
    $setuphold (posedge TXUSRCLK2, posedge TXBYPASS8B10B[2], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXBYPASS8B10B[2]);
    $setuphold (posedge TXUSRCLK2, posedge TXBYPASS8B10B[3], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXBYPASS8B10B[3]);
    $setuphold (posedge TXUSRCLK2, posedge TXCHARDISPMODE[0], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXCHARDISPMODE[0]);
    $setuphold (posedge TXUSRCLK2, posedge TXCHARDISPMODE[1], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXCHARDISPMODE[1]);
    $setuphold (posedge TXUSRCLK2, posedge TXCHARDISPMODE[2], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXCHARDISPMODE[2]);
    $setuphold (posedge TXUSRCLK2, posedge TXCHARDISPMODE[3], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXCHARDISPMODE[3]);
    $setuphold (posedge TXUSRCLK2, posedge TXCHARDISPVAL[0], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXCHARDISPVAL[0]);
    $setuphold (posedge TXUSRCLK2, posedge TXCHARDISPVAL[1], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXCHARDISPVAL[1]);
    $setuphold (posedge TXUSRCLK2, posedge TXCHARDISPVAL[2], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXCHARDISPVAL[2]);
    $setuphold (posedge TXUSRCLK2, posedge TXCHARDISPVAL[3], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXCHARDISPVAL[3]);
    $setuphold (posedge TXUSRCLK2, posedge TXCHARISK[0], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXCHARISK[0]);
    $setuphold (posedge TXUSRCLK2, posedge TXCHARISK[1], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXCHARISK[1]);
    $setuphold (posedge TXUSRCLK2, posedge TXCHARISK[2], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXCHARISK[2]);
    $setuphold (posedge TXUSRCLK2, posedge TXCHARISK[3], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXCHARISK[3]);
    $setuphold (posedge TXUSRCLK2, posedge TXCOMINIT, 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXCOMINIT);
    $setuphold (posedge TXUSRCLK2, posedge TXCOMSAS, 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXCOMSAS);
    $setuphold (posedge TXUSRCLK2, posedge TXCOMWAKE, 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXCOMWAKE);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[0], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[0]);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[10], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[10]);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[11], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[11]);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[12], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[12]);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[13], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[13]);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[14], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[14]);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[15], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[15]);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[16], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[16]);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[17], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[17]);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[18], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[18]);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[19], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[19]);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[1], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[1]);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[20], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[20]);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[21], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[21]);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[22], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[22]);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[23], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[23]);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[24], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[24]);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[25], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[25]);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[26], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[26]);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[27], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[27]);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[28], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[28]);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[29], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[29]);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[2], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[2]);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[30], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[30]);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[31], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[31]);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[3], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[3]);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[4], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[4]);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[5], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[5]);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[6], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[6]);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[7], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[7]);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[8], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[8]);
    $setuphold (posedge TXUSRCLK2, posedge TXDATA[9], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDATA[9]);
    $setuphold (posedge TXUSRCLK2, posedge TXDETECTRX, 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXDETECTRX);
    $setuphold (posedge TXUSRCLK2, posedge TXELECIDLE, 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXELECIDLE);
    $setuphold (posedge TXUSRCLK2, posedge TXENC8B10BUSE, 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXENC8B10BUSE);
    $setuphold (posedge TXUSRCLK2, posedge TXENPRBSTST[0], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXENPRBSTST[0]);
    $setuphold (posedge TXUSRCLK2, posedge TXENPRBSTST[1], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXENPRBSTST[1]);
    $setuphold (posedge TXUSRCLK2, posedge TXENPRBSTST[2], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXENPRBSTST[2]);
    $setuphold (posedge TXUSRCLK2, posedge TXHEADER[0], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXHEADER[0]);
    $setuphold (posedge TXUSRCLK2, posedge TXHEADER[1], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXHEADER[1]);
    $setuphold (posedge TXUSRCLK2, posedge TXHEADER[2], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXHEADER[2]);
    $setuphold (posedge TXUSRCLK2, posedge TXINHIBIT, 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXINHIBIT);
    $setuphold (posedge TXUSRCLK2, posedge TXPOLARITY, 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXPOLARITY);
    $setuphold (posedge TXUSRCLK2, posedge TXPOWERDOWN[0], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXPOWERDOWN[0]);
    $setuphold (posedge TXUSRCLK2, posedge TXPOWERDOWN[1], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXPOWERDOWN[1]);
    $setuphold (posedge TXUSRCLK2, posedge TXPRBSFORCEERR, 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXPRBSFORCEERR);
    $setuphold (posedge TXUSRCLK2, posedge TXRATE[0], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXRATE[0]);
    $setuphold (posedge TXUSRCLK2, posedge TXRATE[1], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXRATE[1]);
    $setuphold (posedge TXUSRCLK2, posedge TXSEQUENCE[0], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXSEQUENCE[0]);
    $setuphold (posedge TXUSRCLK2, posedge TXSEQUENCE[1], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXSEQUENCE[1]);
    $setuphold (posedge TXUSRCLK2, posedge TXSEQUENCE[2], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXSEQUENCE[2]);
    $setuphold (posedge TXUSRCLK2, posedge TXSEQUENCE[3], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXSEQUENCE[3]);
    $setuphold (posedge TXUSRCLK2, posedge TXSEQUENCE[4], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXSEQUENCE[4]);
    $setuphold (posedge TXUSRCLK2, posedge TXSEQUENCE[5], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXSEQUENCE[5]);
    $setuphold (posedge TXUSRCLK2, posedge TXSEQUENCE[6], 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXSEQUENCE[6]);
    $setuphold (posedge TXUSRCLK2, posedge TXSTARTSEQ, 0:0:0, 0:0:0, notifier,,, delay_TXUSRCLK2, delay_TXSTARTSEQ);
    ( DCLK => DRDY) = (0:0:0, 0:0:0);
    ( DCLK => DRPDO[0]) = (0:0:0, 0:0:0);
    ( DCLK => DRPDO[10]) = (0:0:0, 0:0:0);
    ( DCLK => DRPDO[11]) = (0:0:0, 0:0:0);
    ( DCLK => DRPDO[12]) = (0:0:0, 0:0:0);
    ( DCLK => DRPDO[13]) = (0:0:0, 0:0:0);
    ( DCLK => DRPDO[14]) = (0:0:0, 0:0:0);
    ( DCLK => DRPDO[15]) = (0:0:0, 0:0:0);
    ( DCLK => DRPDO[1]) = (0:0:0, 0:0:0);
    ( DCLK => DRPDO[2]) = (0:0:0, 0:0:0);
    ( DCLK => DRPDO[3]) = (0:0:0, 0:0:0);
    ( DCLK => DRPDO[4]) = (0:0:0, 0:0:0);
    ( DCLK => DRPDO[5]) = (0:0:0, 0:0:0);
    ( DCLK => DRPDO[6]) = (0:0:0, 0:0:0);
    ( DCLK => DRPDO[7]) = (0:0:0, 0:0:0);
    ( DCLK => DRPDO[8]) = (0:0:0, 0:0:0);
    ( DCLK => DRPDO[9]) = (0:0:0, 0:0:0);
    ( MGTREFCLKRX[0] => MGTREFCLKFAB[0]) = (0:0:0, 0:0:0);
    ( MGTREFCLKRX[0] => MGTREFCLKFAB[1]) = (0:0:0, 0:0:0);
    ( MGTREFCLKRX[1] => MGTREFCLKFAB[0]) = (0:0:0, 0:0:0);
    ( MGTREFCLKRX[1] => MGTREFCLKFAB[1]) = (0:0:0, 0:0:0);
    ( MGTREFCLKTX[0] => MGTREFCLKFAB[0]) = (0:0:0, 0:0:0);
    ( MGTREFCLKTX[0] => MGTREFCLKFAB[1]) = (0:0:0, 0:0:0);
    ( MGTREFCLKTX[1] => MGTREFCLKFAB[0]) = (0:0:0, 0:0:0);
    ( MGTREFCLKTX[1] => MGTREFCLKFAB[1]) = (0:0:0, 0:0:0);
    ( NORTHREFCLKRX[0] => MGTREFCLKFAB[0]) = (0:0:0, 0:0:0);
    ( NORTHREFCLKRX[0] => MGTREFCLKFAB[1]) = (0:0:0, 0:0:0);
    ( NORTHREFCLKRX[1] => MGTREFCLKFAB[0]) = (0:0:0, 0:0:0);
    ( NORTHREFCLKRX[1] => MGTREFCLKFAB[1]) = (0:0:0, 0:0:0);
    ( NORTHREFCLKTX[0] => MGTREFCLKFAB[0]) = (0:0:0, 0:0:0);
    ( NORTHREFCLKTX[0] => MGTREFCLKFAB[1]) = (0:0:0, 0:0:0);
    ( NORTHREFCLKTX[1] => MGTREFCLKFAB[0]) = (0:0:0, 0:0:0);
    ( NORTHREFCLKTX[1] => MGTREFCLKFAB[1]) = (0:0:0, 0:0:0);
    ( RXUSRCLK => RXCHBONDO[0]) = (0:0:0, 0:0:0);
    ( RXUSRCLK => RXCHBONDO[1]) = (0:0:0, 0:0:0);
    ( RXUSRCLK => RXCHBONDO[2]) = (0:0:0, 0:0:0);
    ( RXUSRCLK => RXCHBONDO[3]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => COMINITDET) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => COMSASDET) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => COMWAKEDET) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFECLKDLYADJMON[0]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFECLKDLYADJMON[1]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFECLKDLYADJMON[2]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFECLKDLYADJMON[3]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFECLKDLYADJMON[4]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFECLKDLYADJMON[5]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFEEYEDACMON[0]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFEEYEDACMON[1]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFEEYEDACMON[2]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFEEYEDACMON[3]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFEEYEDACMON[4]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFESENSCAL[0]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFESENSCAL[1]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFESENSCAL[2]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFETAP1MONITOR[0]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFETAP1MONITOR[1]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFETAP1MONITOR[2]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFETAP1MONITOR[3]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFETAP1MONITOR[4]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFETAP2MONITOR[0]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFETAP2MONITOR[1]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFETAP2MONITOR[2]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFETAP2MONITOR[3]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFETAP2MONITOR[4]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFETAP3MONITOR[0]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFETAP3MONITOR[1]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFETAP3MONITOR[2]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFETAP3MONITOR[3]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFETAP4MONITOR[0]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFETAP4MONITOR[1]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFETAP4MONITOR[2]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => DFETAP4MONITOR[3]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => PHYSTATUS) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXBUFSTATUS[0]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXBUFSTATUS[1]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXBUFSTATUS[2]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXBYTEISALIGNED) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXBYTEREALIGN) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXCHANBONDSEQ) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXCHANISALIGNED) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXCHANREALIGN) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXCHARISCOMMA[0]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXCHARISCOMMA[1]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXCHARISCOMMA[2]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXCHARISCOMMA[3]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXCHARISK[0]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXCHARISK[1]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXCHARISK[2]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXCHARISK[3]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXCHBONDO[0]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXCHBONDO[1]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXCHBONDO[2]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXCHBONDO[3]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXCLKCORCNT[0]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXCLKCORCNT[1]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXCLKCORCNT[2]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXCOMMADET) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATAVALID) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[0]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[10]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[11]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[12]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[13]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[14]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[15]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[16]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[17]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[18]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[19]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[1]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[20]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[21]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[22]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[23]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[24]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[25]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[26]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[27]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[28]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[29]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[2]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[30]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[31]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[3]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[4]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[5]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[6]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[7]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[8]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDATA[9]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDISPERR[0]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDISPERR[1]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDISPERR[2]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXDISPERR[3]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXHEADERVALID) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXHEADER[0]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXHEADER[1]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXHEADER[2]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXLOSSOFSYNC[0]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXLOSSOFSYNC[1]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXNOTINTABLE[0]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXNOTINTABLE[1]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXNOTINTABLE[2]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXNOTINTABLE[3]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXOVERSAMPLEERR) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXPRBSERR) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXRATEDONE) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXRESETDONE) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXRUNDISP[0]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXRUNDISP[1]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXRUNDISP[2]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXRUNDISP[3]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXSTARTOFSEQ) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXSTATUS[0]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXSTATUS[1]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXSTATUS[2]) = (0:0:0, 0:0:0);
    ( RXUSRCLK2 => RXVALID) = (0:0:0, 0:0:0);
    ( SOUTHREFCLKRX[0] => MGTREFCLKFAB[0]) = (0:0:0, 0:0:0);
    ( SOUTHREFCLKRX[0] => MGTREFCLKFAB[1]) = (0:0:0, 0:0:0);
    ( SOUTHREFCLKRX[1] => MGTREFCLKFAB[0]) = (0:0:0, 0:0:0);
    ( SOUTHREFCLKRX[1] => MGTREFCLKFAB[1]) = (0:0:0, 0:0:0);
    ( SOUTHREFCLKTX[0] => MGTREFCLKFAB[0]) = (0:0:0, 0:0:0);
    ( SOUTHREFCLKTX[0] => MGTREFCLKFAB[1]) = (0:0:0, 0:0:0);
    ( SOUTHREFCLKTX[1] => MGTREFCLKFAB[0]) = (0:0:0, 0:0:0);
    ( SOUTHREFCLKTX[1] => MGTREFCLKFAB[1]) = (0:0:0, 0:0:0);
    ( TXUSRCLK2 => COMFINISH) = (0:0:0, 0:0:0);
    ( TXUSRCLK2 => TXBUFSTATUS[0]) = (0:0:0, 0:0:0);
    ( TXUSRCLK2 => TXBUFSTATUS[1]) = (0:0:0, 0:0:0);
    ( TXUSRCLK2 => TXGEARBOXREADY) = (0:0:0, 0:0:0);
    ( TXUSRCLK2 => TXKERR[0]) = (0:0:0, 0:0:0);
    ( TXUSRCLK2 => TXKERR[1]) = (0:0:0, 0:0:0);
    ( TXUSRCLK2 => TXKERR[2]) = (0:0:0, 0:0:0);
    ( TXUSRCLK2 => TXKERR[3]) = (0:0:0, 0:0:0);
    ( TXUSRCLK2 => TXRATEDONE) = (0:0:0, 0:0:0);
    ( TXUSRCLK2 => TXRESETDONE) = (0:0:0, 0:0:0);
    ( TXUSRCLK2 => TXRUNDISP[0]) = (0:0:0, 0:0:0);
    ( TXUSRCLK2 => TXRUNDISP[1]) = (0:0:0, 0:0:0);
    ( TXUSRCLK2 => TXRUNDISP[2]) = (0:0:0, 0:0:0);
    ( TXUSRCLK2 => TXRUNDISP[3]) = (0:0:0, 0:0:0);

    specparam PATHPULSE$ = 0;
  endspecify
endmodule

-------------------------------------------------------
--  Copyright (c) 1995/2006 Xilinx Inc.
--  All Right Reserved.
-------------------------------------------------------
--
--   ____  ____
--  /   /\/   / 
-- /___/  \  /     Vendor      : Xilinx 
-- \   \   \/      Version : 11.1
--  \   \          Description : Xilinx Functional Simulation Library Component
--  /   /                        Multi-Gigabit Transceiver
-- /___/   /\      Filename    : X_GTX_DUAL.vhd
-- \   \  /  \     Timestamp   : Tue Jan  9 10:05:23 2007
--  \__ \/\__ \                   
--                                 
--  Revision:
--  09/12/06 - CR#423671 - Initial version.
--  12/05/06 - CR#426138 - J.31 spreadsheet update
--  01/23/07 - CR#430426 - J.32 pinTime added
--  02/20/07 - CR#434096 - Parameter default value update PLL_RXDIVSEL_OUT_0/1
--  02/20/07 - CR#433804 - VITAL library update, timing checks update- writer bug
--  06/18/07 - CR#441601 - BT1445 - Test attributes made visible 
--  06/18/07 - CR#441576 - BT1488 - Add STEPPING attribute
--  08/01/07 - CR#445080 - Added LEVEL0 constructs to support negative setuphold timing checks
--  08/23/07 - CR#447152 - Connect TXUSRCLK0 & TXUSRCLK1
--  10/05/07 - CR#451343 - BT1514 - Add ES1 (ES1 mapped to 0) as STEPPING value
--  11/05/07 - CR#452590 - BT1514 - Remove STEPPING attribute from unisim/simprim wrapper
--  02/05/08 - CR#459742 - Attribute default changes
--  03/14/08 - CR#468285 - Updated timing checks
--  03/17/08 - CR#467692 - Add SIM_MODE attribute with values LEGACY & FAST model
--  04/24/08 - CR#472011 - OOBDETECT_THRESHOLD_0/1 default from 001 to 110, range changes from 000-111 to 110-111
--  04/29/08 - CR#444072 - Add clock port to tisd in declaration & Vitalsetuphold section
--  05/13/08 - CR#472931 - OOBDETECT_THRESHOLD_0/1 case statement updates
--  05/19/08 - CR#472395 - Remove LEGACY model
--  05/27/08 - CR#472395 - Set SIM_MODE to FAST, Add DRC checks
----------------------------------------------------------------------------------------------

----- CELL X_GTX_DUAL -----

library IEEE;
use IEEE.STD_LOGIC_1164.all;

library IEEE;
use IEEE.VITAL_Timing.all;

library simprim;
use simprim.VCOMPONENTS.all; 

library secureip; 
use secureip.all; 

entity X_GTX_DUAL is
generic (
	TimingChecksOn : boolean := TRUE;
	InstancePath   : string  := "*";
	Xon            : boolean := TRUE;
	MsgOn          : boolean := FALSE;

	LOC             : string  := "UNPLACED";

       	AC_CAP_DIS_0 : boolean := TRUE;
	AC_CAP_DIS_1 : boolean := TRUE;
	ALIGN_COMMA_WORD_0 : integer := 1;
	ALIGN_COMMA_WORD_1 : integer := 1;
	CB2_INH_CC_PERIOD_0 : integer := 8;
	CB2_INH_CC_PERIOD_1 : integer := 8;
	CDR_PH_ADJ_TIME : bit_vector := "01010";
	CHAN_BOND_1_MAX_SKEW_0 : integer := 7;
	CHAN_BOND_1_MAX_SKEW_1 : integer := 7;
	CHAN_BOND_2_MAX_SKEW_0 : integer := 7;
	CHAN_BOND_2_MAX_SKEW_1 : integer := 7;
	CHAN_BOND_KEEP_ALIGN_0 : boolean := FALSE;
	CHAN_BOND_KEEP_ALIGN_1 : boolean := FALSE;
	CHAN_BOND_LEVEL_0 : integer := 0;
	CHAN_BOND_LEVEL_1 : integer := 0;
	CHAN_BOND_MODE_0 : string := "OFF";
	CHAN_BOND_MODE_1 : string := "OFF";
	CHAN_BOND_SEQ_1_1_0 : bit_vector := "0101111100";
	CHAN_BOND_SEQ_1_1_1 : bit_vector := "0101111100";
	CHAN_BOND_SEQ_1_2_0 : bit_vector := "0000000000";
	CHAN_BOND_SEQ_1_2_1 : bit_vector := "0000000000";
	CHAN_BOND_SEQ_1_3_0 : bit_vector := "0000000000";
	CHAN_BOND_SEQ_1_3_1 : bit_vector := "0000000000";
	CHAN_BOND_SEQ_1_4_0 : bit_vector := "0000000000";
	CHAN_BOND_SEQ_1_4_1 : bit_vector := "0000000000";
	CHAN_BOND_SEQ_1_ENABLE_0 : bit_vector := "0001";
	CHAN_BOND_SEQ_1_ENABLE_1 : bit_vector := "0001";
	CHAN_BOND_SEQ_2_1_0 : bit_vector := "0000000000";
	CHAN_BOND_SEQ_2_1_1 : bit_vector := "0000000000";
	CHAN_BOND_SEQ_2_2_0 : bit_vector := "0000000000";
	CHAN_BOND_SEQ_2_2_1 : bit_vector := "0000000000";
	CHAN_BOND_SEQ_2_3_0 : bit_vector := "0000000000";
	CHAN_BOND_SEQ_2_3_1 : bit_vector := "0000000000";
	CHAN_BOND_SEQ_2_4_0 : bit_vector := "0000000000";
	CHAN_BOND_SEQ_2_4_1 : bit_vector := "0000000000";
	CHAN_BOND_SEQ_2_ENABLE_0 : bit_vector := "0000";
	CHAN_BOND_SEQ_2_ENABLE_1 : bit_vector := "0000";
	CHAN_BOND_SEQ_2_USE_0 : boolean := FALSE;
	CHAN_BOND_SEQ_2_USE_1 : boolean := FALSE;
	CHAN_BOND_SEQ_LEN_0 : integer := 1;
	CHAN_BOND_SEQ_LEN_1 : integer := 1;
	CLK25_DIVIDER : integer := 10;
	CLKINDC_B : boolean := TRUE;
	CLKRCV_TRST : boolean := TRUE;
	CLK_CORRECT_USE_0 : boolean := TRUE;
	CLK_CORRECT_USE_1 : boolean := TRUE;
	CLK_COR_ADJ_LEN_0 : integer := 1;
	CLK_COR_ADJ_LEN_1 : integer := 1;
	CLK_COR_DET_LEN_0 : integer := 1;
	CLK_COR_DET_LEN_1 : integer := 1;
	CLK_COR_INSERT_IDLE_FLAG_0 : boolean := FALSE;
	CLK_COR_INSERT_IDLE_FLAG_1 : boolean := FALSE;
	CLK_COR_KEEP_IDLE_0 : boolean := FALSE;
	CLK_COR_KEEP_IDLE_1 : boolean := FALSE;
	CLK_COR_MAX_LAT_0 : integer := 20;
	CLK_COR_MAX_LAT_1 : integer := 20;
	CLK_COR_MIN_LAT_0 : integer := 18;
	CLK_COR_MIN_LAT_1 : integer := 18;
	CLK_COR_PRECEDENCE_0 : boolean := TRUE;
	CLK_COR_PRECEDENCE_1 : boolean := TRUE;
	CLK_COR_REPEAT_WAIT_0 : integer := 0;
	CLK_COR_REPEAT_WAIT_1 : integer := 0;
	CLK_COR_SEQ_1_1_0 : bit_vector := "0100011100";
	CLK_COR_SEQ_1_1_1 : bit_vector := "0100011100";
	CLK_COR_SEQ_1_2_0 : bit_vector := "0000000000";
	CLK_COR_SEQ_1_2_1 : bit_vector := "0000000000";
	CLK_COR_SEQ_1_3_0 : bit_vector := "0000000000";
	CLK_COR_SEQ_1_3_1 : bit_vector := "0000000000";
	CLK_COR_SEQ_1_4_0 : bit_vector := "0000000000";
	CLK_COR_SEQ_1_4_1 : bit_vector := "0000000000";
	CLK_COR_SEQ_1_ENABLE_0 : bit_vector := "0001";
	CLK_COR_SEQ_1_ENABLE_1 : bit_vector := "0001";
	CLK_COR_SEQ_2_1_0 : bit_vector := "0000000000";
	CLK_COR_SEQ_2_1_1 : bit_vector := "0000000000";
	CLK_COR_SEQ_2_2_0 : bit_vector := "0000000000";
	CLK_COR_SEQ_2_2_1 : bit_vector := "0000000000";
	CLK_COR_SEQ_2_3_0 : bit_vector := "0000000000";
	CLK_COR_SEQ_2_3_1 : bit_vector := "0000000000";
	CLK_COR_SEQ_2_4_0 : bit_vector := "0000000000";
	CLK_COR_SEQ_2_4_1 : bit_vector := "0000000000";
	CLK_COR_SEQ_2_ENABLE_0 : bit_vector := "0000";
	CLK_COR_SEQ_2_ENABLE_1 : bit_vector := "0000";
	CLK_COR_SEQ_2_USE_0 : boolean := FALSE;
	CLK_COR_SEQ_2_USE_1 : boolean := FALSE;
	CM_TRIM_0 : bit_vector := "10";
	CM_TRIM_1 : bit_vector := "10";
	COMMA_10B_ENABLE_0 : bit_vector := "0001111111";
	COMMA_10B_ENABLE_1 : bit_vector := "0001111111";
	COMMA_DOUBLE_0 : boolean := FALSE;
	COMMA_DOUBLE_1 : boolean := FALSE;
	COM_BURST_VAL_0 : bit_vector := "1111";
	COM_BURST_VAL_1 : bit_vector := "1111";
	DEC_MCOMMA_DETECT_0 : boolean := TRUE;
	DEC_MCOMMA_DETECT_1 : boolean := TRUE;
	DEC_PCOMMA_DETECT_0 : boolean := TRUE;
	DEC_PCOMMA_DETECT_1 : boolean := TRUE;
	DEC_VALID_COMMA_ONLY_0 : boolean := TRUE;
	DEC_VALID_COMMA_ONLY_1 : boolean := TRUE;
	DFE_CAL_TIME : bit_vector := "00110";
	DFE_CFG_0 : bit_vector := "1101111011";
	DFE_CFG_1 : bit_vector := "1101111011";
	GEARBOX_ENDEC_0 : bit_vector := "000";
	GEARBOX_ENDEC_1 : bit_vector := "000";
	MCOMMA_10B_VALUE_0 : bit_vector := "1010000011";
	MCOMMA_10B_VALUE_1 : bit_vector := "1010000011";
	MCOMMA_DETECT_0 : boolean := TRUE;
	MCOMMA_DETECT_1 : boolean := TRUE;
	OOBDETECT_THRESHOLD_0 : bit_vector := "110";
	OOBDETECT_THRESHOLD_1 : bit_vector := "110";
	OOB_CLK_DIVIDER : integer := 6;
	OVERSAMPLE_MODE : boolean := FALSE;
	PCI_EXPRESS_MODE_0 : boolean := FALSE;
	PCI_EXPRESS_MODE_1 : boolean := FALSE;
	PCOMMA_10B_VALUE_0 : bit_vector := "0101111100";
	PCOMMA_10B_VALUE_1 : bit_vector := "0101111100";
	PCOMMA_DETECT_0 : boolean := TRUE;
	PCOMMA_DETECT_1 : boolean := TRUE;
	PLL_COM_CFG : bit_vector := X"21680a";
	PLL_CP_CFG : bit_vector := X"00";
	PLL_DIVSEL_FB : integer := 2;
	PLL_DIVSEL_REF : integer := 1;
	PLL_FB_DCCEN : boolean := FALSE;
	PLL_LKDET_CFG : bit_vector := "101";
	PLL_RXDIVSEL_OUT_0 : integer := 1;
	PLL_RXDIVSEL_OUT_1 : integer := 1;
	PLL_SATA_0 : boolean := FALSE;
	PLL_SATA_1 : boolean := FALSE;
	PLL_TDCC_CFG : bit_vector := "000";
	PLL_TXDIVSEL_OUT_0 : integer := 1;
	PLL_TXDIVSEL_OUT_1 : integer := 1;
	PMA_CDR_SCAN_0 : bit_vector := X"6404035";
	PMA_CDR_SCAN_1 : bit_vector := X"6404035";
	PMA_COM_CFG : bit_vector := X"000000000000000000";
	PMA_RXSYNC_CFG_0 : bit_vector := X"00";
	PMA_RXSYNC_CFG_1 : bit_vector := X"00";
	PMA_RX_CFG_0 : bit_vector := X"0f44089";
	PMA_RX_CFG_1 : bit_vector := X"0f44089";
	PMA_TX_CFG_0 : bit_vector := X"80082";
	PMA_TX_CFG_1 : bit_vector := X"80082";
	PRBS_ERR_THRESHOLD_0 : bit_vector := X"00000001";
	PRBS_ERR_THRESHOLD_1 : bit_vector := X"00000001";
	RCV_TERM_GND_0 : boolean := FALSE;
	RCV_TERM_GND_1 : boolean := FALSE;
	RCV_TERM_VTTRX_0 : boolean := FALSE;
	RCV_TERM_VTTRX_1 : boolean := FALSE;
	RXGEARBOX_USE_0 : boolean := FALSE;
	RXGEARBOX_USE_1 : boolean := FALSE;
	RX_BUFFER_USE_0 : boolean := TRUE;
	RX_BUFFER_USE_1 : boolean := TRUE;
	RX_DECODE_SEQ_MATCH_0 : boolean := TRUE;
	RX_DECODE_SEQ_MATCH_1 : boolean := TRUE;
	RX_EN_IDLE_HOLD_CDR : boolean := FALSE;
	RX_EN_IDLE_HOLD_DFE_0 : boolean := TRUE;
	RX_EN_IDLE_HOLD_DFE_1 : boolean := TRUE;
	RX_EN_IDLE_RESET_BUF_0 : boolean := TRUE;
	RX_EN_IDLE_RESET_BUF_1 : boolean := TRUE;
	RX_EN_IDLE_RESET_FR : boolean := TRUE;
	RX_EN_IDLE_RESET_PH : boolean := TRUE;
	RX_IDLE_HI_CNT_0 : bit_vector := "1000";
	RX_IDLE_HI_CNT_1 : bit_vector := "1000";
	RX_IDLE_LO_CNT_0 : bit_vector := "0000";
	RX_IDLE_LO_CNT_1 : bit_vector := "0000";
	RX_LOSS_OF_SYNC_FSM_0 : boolean := FALSE;
	RX_LOSS_OF_SYNC_FSM_1 : boolean := FALSE;
	RX_LOS_INVALID_INCR_0 : integer := 1;
	RX_LOS_INVALID_INCR_1 : integer := 1;
	RX_LOS_THRESHOLD_0 : integer := 4;
	RX_LOS_THRESHOLD_1 : integer := 4;
	RX_SLIDE_MODE_0 : string := "PCS";
	RX_SLIDE_MODE_1 : string := "PCS";
	RX_STATUS_FMT_0 : string := "PCIE";
	RX_STATUS_FMT_1 : string := "PCIE";
	RX_XCLK_SEL_0 : string := "RXREC";
	RX_XCLK_SEL_1 : string := "RXREC";
	SATA_BURST_VAL_0 : bit_vector := "100";
	SATA_BURST_VAL_1 : bit_vector := "100";
	SATA_IDLE_VAL_0 : bit_vector := "100";
	SATA_IDLE_VAL_1 : bit_vector := "100";
	SATA_MAX_BURST_0 : integer := 7;
	SATA_MAX_BURST_1 : integer := 7;
	SATA_MAX_INIT_0 : integer := 22;
	SATA_MAX_INIT_1 : integer := 22;
	SATA_MAX_WAKE_0 : integer := 7;
	SATA_MAX_WAKE_1 : integer := 7;
	SATA_MIN_BURST_0 : integer := 4;
	SATA_MIN_BURST_1 : integer := 4;
	SATA_MIN_INIT_0 : integer := 12;
	SATA_MIN_INIT_1 : integer := 12;
	SATA_MIN_WAKE_0 : integer := 4;
	SATA_MIN_WAKE_1 : integer := 4;
	SIM_GTXRESET_SPEEDUP : integer := 1;
        SIM_MODE : string := "FAST";
	SIM_PLL_PERDIV2 : bit_vector := X"140";
	SIM_RECEIVER_DETECT_PASS_0 : boolean := TRUE;
	SIM_RECEIVER_DETECT_PASS_1 : boolean := TRUE;
	TERMINATION_CTRL : bit_vector := "10100";
	TERMINATION_IMP_0 : integer := 50;
	TERMINATION_IMP_1 : integer := 50;
	TERMINATION_OVRD : boolean := FALSE;
	TRANS_TIME_FROM_P2_0 : bit_vector := X"03c";
	TRANS_TIME_FROM_P2_1 : bit_vector := X"03c";
	TRANS_TIME_NON_P2_0 : bit_vector := X"19";
	TRANS_TIME_NON_P2_1 : bit_vector := X"19";
	TRANS_TIME_TO_P2_0 : bit_vector := X"064";
	TRANS_TIME_TO_P2_1 : bit_vector := X"064";
	TXGEARBOX_USE_0 : boolean := FALSE;
	TXGEARBOX_USE_1 : boolean := FALSE;
	TXRX_INVERT_0 : bit_vector := "011";
	TXRX_INVERT_1 : bit_vector := "011";
	TX_BUFFER_USE_0 : boolean := TRUE;
	TX_BUFFER_USE_1 : boolean := TRUE;
	TX_DETECT_RX_CFG_0 : bit_vector := X"1832";
	TX_DETECT_RX_CFG_1 : bit_vector := X"1832";
	TX_IDLE_DELAY_0 : bit_vector := "010";
	TX_IDLE_DELAY_1 : bit_vector := "010";
	TX_XCLK_SEL_0 : string := "TXOUT";
	TX_XCLK_SEL_1 : string := "TXOUT";

	tipd_CLKIN : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_DADDR : VitalDelayArrayType01 (6 downto 0) := (others => (0 ps, 0 ps));
	tipd_DCLK : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_DEN : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_DFECLKDLYADJ0 : VitalDelayArrayType01 (5 downto 0) := (others => (0 ps, 0 ps));
	tipd_DFECLKDLYADJ1 : VitalDelayArrayType01 (5 downto 0) := (others => (0 ps, 0 ps));
	tipd_DFETAP10 : VitalDelayArrayType01 (4 downto 0) := (others => (0 ps, 0 ps));
	tipd_DFETAP11 : VitalDelayArrayType01 (4 downto 0) := (others => (0 ps, 0 ps));
	tipd_DFETAP20 : VitalDelayArrayType01 (4 downto 0) := (others => (0 ps, 0 ps));
	tipd_DFETAP21 : VitalDelayArrayType01 (4 downto 0) := (others => (0 ps, 0 ps));
	tipd_DFETAP30 : VitalDelayArrayType01 (3 downto 0) := (others => (0 ps, 0 ps));
	tipd_DFETAP31 : VitalDelayArrayType01 (3 downto 0) := (others => (0 ps, 0 ps));
	tipd_DFETAP40 : VitalDelayArrayType01 (3 downto 0) := (others => (0 ps, 0 ps));
	tipd_DFETAP41 : VitalDelayArrayType01 (3 downto 0) := (others => (0 ps, 0 ps));
	tipd_DI : VitalDelayArrayType01 (15 downto 0) := (others => (0 ps, 0 ps));
	tipd_DWE : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_GTXRESET : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_GTXTEST : VitalDelayArrayType01 (13 downto 0) := (others => (0 ps, 0 ps));
	tipd_INTDATAWIDTH : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_LOOPBACK0 : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
	tipd_LOOPBACK1 : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
	tipd_PLLLKDETEN : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_PLLPOWERDOWN : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_PRBSCNTRESET0 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_PRBSCNTRESET1 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_REFCLKPWRDNB : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXBUFRESET0 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXBUFRESET1 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXCDRRESET0 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXCDRRESET1 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXCHBONDI0 : VitalDelayArrayType01 (3 downto 0) := (others => (0 ps, 0 ps));
	tipd_RXCHBONDI1 : VitalDelayArrayType01 (3 downto 0) := (others => (0 ps, 0 ps));
	tipd_RXCOMMADETUSE0 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXCOMMADETUSE1 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXDATAWIDTH0 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
	tipd_RXDATAWIDTH1 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
	tipd_RXDEC8B10BUSE0 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXDEC8B10BUSE1 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXENCHANSYNC0 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXENCHANSYNC1 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXENEQB0 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXENEQB1 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXENMCOMMAALIGN0 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXENMCOMMAALIGN1 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXENPCOMMAALIGN0 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXENPCOMMAALIGN1 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXENPMAPHASEALIGN0 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXENPMAPHASEALIGN1 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXENPRBSTST0 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
	tipd_RXENPRBSTST1 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
	tipd_RXENSAMPLEALIGN0 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXENSAMPLEALIGN1 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXEQMIX0 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
	tipd_RXEQMIX1 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
	tipd_RXEQPOLE0 : VitalDelayArrayType01 (3 downto 0) := (others => (0 ps, 0 ps));
	tipd_RXEQPOLE1 : VitalDelayArrayType01 (3 downto 0) := (others => (0 ps, 0 ps));
	tipd_RXGEARBOXSLIP0 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXGEARBOXSLIP1 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXN0 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXN1 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXP0 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXP1 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXPMASETPHASE0 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXPMASETPHASE1 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXPOLARITY0 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXPOLARITY1 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXPOWERDOWN0 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
	tipd_RXPOWERDOWN1 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
	tipd_RXRESET0 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXRESET1 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXSLIDE0 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXSLIDE1 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXUSRCLK0 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXUSRCLK1 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXUSRCLK20 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_RXUSRCLK21 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_TXBUFDIFFCTRL0 : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
	tipd_TXBUFDIFFCTRL1 : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
	tipd_TXBYPASS8B10B0 : VitalDelayArrayType01 (3 downto 0) := (others => (0 ps, 0 ps));
	tipd_TXBYPASS8B10B1 : VitalDelayArrayType01 (3 downto 0) := (others => (0 ps, 0 ps));
	tipd_TXCHARDISPMODE0 : VitalDelayArrayType01 (3 downto 0) := (others => (0 ps, 0 ps));
	tipd_TXCHARDISPMODE1 : VitalDelayArrayType01 (3 downto 0) := (others => (0 ps, 0 ps));
	tipd_TXCHARDISPVAL0 : VitalDelayArrayType01 (3 downto 0) := (others => (0 ps, 0 ps));
	tipd_TXCHARDISPVAL1 : VitalDelayArrayType01 (3 downto 0) := (others => (0 ps, 0 ps));
	tipd_TXCHARISK0 : VitalDelayArrayType01 (3 downto 0) := (others => (0 ps, 0 ps));
	tipd_TXCHARISK1 : VitalDelayArrayType01 (3 downto 0) := (others => (0 ps, 0 ps));
	tipd_TXCOMSTART0 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_TXCOMSTART1 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_TXCOMTYPE0 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_TXCOMTYPE1 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_TXDATA0 : VitalDelayArrayType01 (31 downto 0) := (others => (0 ps, 0 ps));
	tipd_TXDATA1 : VitalDelayArrayType01 (31 downto 0) := (others => (0 ps, 0 ps));
	tipd_TXDATAWIDTH0 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
	tipd_TXDATAWIDTH1 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
	tipd_TXDETECTRX0 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_TXDETECTRX1 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_TXDIFFCTRL0 : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
	tipd_TXDIFFCTRL1 : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
	tipd_TXELECIDLE0 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_TXELECIDLE1 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_TXENC8B10BUSE0 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_TXENC8B10BUSE1 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_TXENPMAPHASEALIGN0 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_TXENPMAPHASEALIGN1 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_TXENPRBSTST0 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
	tipd_TXENPRBSTST1 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
	tipd_TXHEADER0 : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
	tipd_TXHEADER1 : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
	tipd_TXINHIBIT0 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_TXINHIBIT1 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_TXPMASETPHASE0 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_TXPMASETPHASE1 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_TXPOLARITY0 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_TXPOLARITY1 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_TXPOWERDOWN0 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
	tipd_TXPOWERDOWN1 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
	tipd_TXPREEMPHASIS0 : VitalDelayArrayType01 (3 downto 0) := (others => (0 ps, 0 ps));
	tipd_TXPREEMPHASIS1 : VitalDelayArrayType01 (3 downto 0) := (others => (0 ps, 0 ps));
	tipd_TXRESET0 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_TXRESET1 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_TXSEQUENCE0 : VitalDelayArrayType01 (6 downto 0) := (others => (0 ps, 0 ps));
	tipd_TXSEQUENCE1 : VitalDelayArrayType01 (6 downto 0) := (others => (0 ps, 0 ps));
	tipd_TXSTARTSEQ0 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_TXSTARTSEQ1 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_TXUSRCLK0 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_TXUSRCLK1 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_TXUSRCLK20 : VitalDelayType01 :=  (0 ps, 0 ps);
	tipd_TXUSRCLK21 : VitalDelayType01 :=  (0 ps, 0 ps);
	tpd_CLKIN_REFCLKOUT : VitalDelayType01 := (0 ps, 0 ps);
	tpd_DCLK_DO : VitalDelayArrayType01(15 downto 0) := (others => (0 ps, 0 ps));
	tpd_DCLK_DRDY : VitalDelayType01 := (0 ps, 0 ps);
	tpd_RXUSRCLK0_RXCHBONDO0 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK1_RXCHBONDO1 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK20_DFECLKDLYADJMONITOR0 : VitalDelayArrayType01(5 downto 0) := (others => (0 ps, 0 ps));
--	tpd_RXUSRCLK20_DFECLKDLYADJMONITOR1 : VitalDelayArrayType01(5 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK20_DFEEYEDACMONITOR0 : VitalDelayArrayType01(4 downto 0) := (others => (0 ps, 0 ps));
--	tpd_RXUSRCLK20_DFEEYEDACMONITOR1 : VitalDelayArrayType01(4 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK20_DFESENSCAL0 : VitalDelayArrayType01(2 downto 0) := (others => (0 ps, 0 ps));
--	tpd_RXUSRCLK20_DFESENSCAL1 : VitalDelayArrayType01(2 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK20_DFETAP1MONITOR0 : VitalDelayArrayType01(4 downto 0) := (others => (0 ps, 0 ps));
--	tpd_RXUSRCLK20_DFETAP1MONITOR1 : VitalDelayArrayType01(4 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK20_DFETAP2MONITOR0 : VitalDelayArrayType01(4 downto 0) := (others => (0 ps, 0 ps));
--	tpd_RXUSRCLK20_DFETAP2MONITOR1 : VitalDelayArrayType01(4 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK20_DFETAP3MONITOR0 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
--	tpd_RXUSRCLK20_DFETAP3MONITOR1 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK20_DFETAP4MONITOR0 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
--	tpd_RXUSRCLK20_DFETAP4MONITOR1 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
        tpd_RXUSRCLK20_PHYSTATUS0 : VitalDelayType01 := (0 ps, 0 ps);
	tpd_RXUSRCLK20_RXBUFSTATUS0 : VitalDelayArrayType01(2 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK20_RXBYTEISALIGNED0 : VitalDelayType01 := (0 ps, 0 ps);
	tpd_RXUSRCLK20_RXBYTEREALIGN0 : VitalDelayType01 := (0 ps, 0 ps);
	tpd_RXUSRCLK20_RXCHANBONDSEQ0 : VitalDelayType01 := (0 ps, 0 ps);
	tpd_RXUSRCLK20_RXCHANISALIGNED0 : VitalDelayType01 := (0 ps, 0 ps);
	tpd_RXUSRCLK20_RXCHANREALIGN0 : VitalDelayType01 := (0 ps, 0 ps);
	tpd_RXUSRCLK20_RXCHARISCOMMA0 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK20_RXCHARISK0 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK20_RXCLKCORCNT0 : VitalDelayArrayType01(2 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK20_RXCOMMADET0 : VitalDelayType01 := (0 ps, 0 ps);
	tpd_RXUSRCLK20_RXDATA0 : VitalDelayArrayType01(31 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK20_RXDATAVALID0 : VitalDelayType01 := (0 ps, 0 ps);
	tpd_RXUSRCLK20_RXDISPERR0 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK20_RXHEADER0 : VitalDelayArrayType01(2 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK20_RXHEADERVALID0 : VitalDelayType01 := (0 ps, 0 ps);
	tpd_RXUSRCLK20_RXLOSSOFSYNC0 : VitalDelayArrayType01(1 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK20_RXNOTINTABLE0 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
        tpd_RXUSRCLK20_RXOVERSAMPLEERR0 : VitalDelayType01 := (0 ps, 0 ps);
	tpd_RXUSRCLK20_RXPRBSERR0 : VitalDelayType01 := (0 ps, 0 ps);
	tpd_RXUSRCLK20_RXRUNDISP0 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK20_RXSTARTOFSEQ0 : VitalDelayType01 := (0 ps, 0 ps);
	tpd_RXUSRCLK20_RXSTATUS0 : VitalDelayArrayType01(2 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK20_RXVALID0 : VitalDelayType01 := (0 ps, 0 ps);
        tpd_RXUSRCLK21_DFECLKDLYADJMONITOR1 : VitalDelayArrayType01(5 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK21_DFEEYEDACMONITOR1 : VitalDelayArrayType01(4 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK21_DFESENSCAL1 : VitalDelayArrayType01(2 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK21_DFETAP1MONITOR1 : VitalDelayArrayType01(4 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK21_DFETAP2MONITOR1 : VitalDelayArrayType01(4 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK21_DFETAP3MONITOR1 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK21_DFETAP4MONITOR1 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK21_PHYSTATUS1 : VitalDelayType01 := (0 ps, 0 ps);
	tpd_RXUSRCLK21_RXBUFSTATUS1 : VitalDelayArrayType01(2 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK21_RXBYTEISALIGNED1 : VitalDelayType01 := (0 ps, 0 ps);
	tpd_RXUSRCLK21_RXBYTEREALIGN1 : VitalDelayType01 := (0 ps, 0 ps);
	tpd_RXUSRCLK21_RXCHANBONDSEQ1 : VitalDelayType01 := (0 ps, 0 ps);
	tpd_RXUSRCLK21_RXCHANISALIGNED1 : VitalDelayType01 := (0 ps, 0 ps);
	tpd_RXUSRCLK21_RXCHANREALIGN1 : VitalDelayType01 := (0 ps, 0 ps);
	tpd_RXUSRCLK21_RXCHARISCOMMA1 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK21_RXCHARISK1 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK21_RXCLKCORCNT1 : VitalDelayArrayType01(2 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK21_RXCOMMADET1 : VitalDelayType01 := (0 ps, 0 ps);
	tpd_RXUSRCLK21_RXDATA1 : VitalDelayArrayType01(31 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK21_RXDATAVALID1 : VitalDelayType01 := (0 ps, 0 ps);
	tpd_RXUSRCLK21_RXDISPERR1 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK21_RXHEADER1 : VitalDelayArrayType01(2 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK21_RXHEADERVALID1 : VitalDelayType01 := (0 ps, 0 ps);
	tpd_RXUSRCLK21_RXLOSSOFSYNC1 : VitalDelayArrayType01(1 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK21_RXNOTINTABLE1 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
        tpd_RXUSRCLK21_RXOVERSAMPLEERR1 : VitalDelayType01 := (0 ps, 0 ps);
	tpd_RXUSRCLK21_RXPRBSERR1 : VitalDelayType01 := (0 ps, 0 ps);
	tpd_RXUSRCLK21_RXRUNDISP1 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK21_RXSTARTOFSEQ1 : VitalDelayType01 := (0 ps, 0 ps);
	tpd_RXUSRCLK21_RXSTATUS1 : VitalDelayArrayType01(2 downto 0) := (others => (0 ps, 0 ps));
	tpd_RXUSRCLK21_RXVALID1 : VitalDelayType01 := (0 ps, 0 ps);
--	tpd_RXUSRCLK21_TXGEARBOXREADY1 : VitalDelayType01 := (0 ps, 0 ps);
--	tpd_TXUSRCLK20_RXOVERSAMPLEERR0 : VitalDelayType01 := (0 ps, 0 ps);
	tpd_TXUSRCLK20_TXBUFSTATUS0 : VitalDelayArrayType01(1 downto 0) := (others => (0 ps, 0 ps));
	tpd_TXUSRCLK20_TXGEARBOXREADY0 : VitalDelayType01 := (0 ps, 0 ps);
	tpd_TXUSRCLK20_TXKERR0 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
	tpd_TXUSRCLK20_TXRUNDISP0 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
--	tpd_TXUSRCLK21_RXOVERSAMPLEERR1 : VitalDelayType01 := (0 ps, 0 ps);
	tpd_TXUSRCLK21_TXBUFSTATUS1 : VitalDelayArrayType01(1 downto 0) := (others => (0 ps, 0 ps));
        tpd_TXUSRCLK21_TXGEARBOXREADY1 : VitalDelayType01 := (0 ps, 0 ps);
	tpd_TXUSRCLK21_TXKERR1 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
	tpd_TXUSRCLK21_TXRUNDISP1 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));


	thold_DADDR_DCLK_negedge_posedge : VitalDelayArrayType(6 downto 0) := (others => 0 ps);
	thold_DADDR_DCLK_posedge_posedge : VitalDelayArrayType(6 downto 0) := (others => 0 ps);
	thold_DEN_DCLK_negedge_posedge : VitalDelayType := 0 ps;
	thold_DEN_DCLK_posedge_posedge : VitalDelayType := 0 ps;
	thold_DFECLKDLYADJ0_RXUSRCLK20_negedge_posedge : VitalDelayArrayType(5 downto 0) := (others => 0 ps);
	thold_DFECLKDLYADJ0_RXUSRCLK20_posedge_posedge : VitalDelayArrayType(5 downto 0) := (others => 0 ps);
	thold_DFECLKDLYADJ1_RXUSRCLK21_negedge_posedge : VitalDelayArrayType(5 downto 0) := (others => 0 ps);
	thold_DFECLKDLYADJ1_RXUSRCLK21_posedge_posedge : VitalDelayArrayType(5 downto 0) := (others => 0 ps);
	thold_DFETAP10_RXUSRCLK20_negedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
	thold_DFETAP10_RXUSRCLK20_posedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
	thold_DFETAP11_RXUSRCLK21_negedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
	thold_DFETAP11_RXUSRCLK21_posedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
	thold_DFETAP20_RXUSRCLK20_negedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
	thold_DFETAP20_RXUSRCLK20_posedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
	thold_DFETAP21_RXUSRCLK21_negedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
	thold_DFETAP21_RXUSRCLK21_posedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
	thold_DFETAP30_RXUSRCLK20_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	thold_DFETAP30_RXUSRCLK20_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	thold_DFETAP31_RXUSRCLK21_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	thold_DFETAP31_RXUSRCLK21_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	thold_DFETAP40_RXUSRCLK20_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	thold_DFETAP40_RXUSRCLK20_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	thold_DFETAP41_RXUSRCLK21_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	thold_DFETAP41_RXUSRCLK21_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	thold_DI_DCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
	thold_DI_DCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
	thold_DWE_DCLK_negedge_posedge : VitalDelayType := 0 ps;
	thold_DWE_DCLK_posedge_posedge : VitalDelayType := 0 ps;
	thold_PRBSCNTRESET0_RXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	thold_PRBSCNTRESET0_RXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	thold_PRBSCNTRESET1_RXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	thold_PRBSCNTRESET1_RXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	thold_RXCHBONDI0_RXUSRCLK0_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	thold_RXCHBONDI0_RXUSRCLK0_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	thold_RXCHBONDI1_RXUSRCLK1_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	thold_RXCHBONDI1_RXUSRCLK1_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	thold_RXCOMMADETUSE0_RXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	thold_RXCOMMADETUSE0_RXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	thold_RXCOMMADETUSE1_RXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	thold_RXCOMMADETUSE1_RXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	thold_RXDEC8B10BUSE0_RXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	thold_RXDEC8B10BUSE0_RXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	thold_RXDEC8B10BUSE1_RXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	thold_RXDEC8B10BUSE1_RXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	thold_RXENCHANSYNC0_RXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	thold_RXENCHANSYNC0_RXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	thold_RXENCHANSYNC1_RXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	thold_RXENCHANSYNC1_RXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	thold_RXENMCOMMAALIGN0_RXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	thold_RXENMCOMMAALIGN0_RXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	thold_RXENMCOMMAALIGN1_RXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	thold_RXENMCOMMAALIGN1_RXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	thold_RXENPCOMMAALIGN0_RXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	thold_RXENPCOMMAALIGN0_RXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	thold_RXENPCOMMAALIGN1_RXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	thold_RXENPCOMMAALIGN1_RXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	thold_RXENPRBSTST0_RXUSRCLK20_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
	thold_RXENPRBSTST0_RXUSRCLK20_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
	thold_RXENPRBSTST1_RXUSRCLK21_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
	thold_RXENPRBSTST1_RXUSRCLK21_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
	thold_RXENSAMPLEALIGN0_RXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	thold_RXENSAMPLEALIGN0_RXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	thold_RXENSAMPLEALIGN1_RXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	thold_RXENSAMPLEALIGN1_RXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	thold_RXGEARBOXSLIP0_RXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	thold_RXGEARBOXSLIP0_RXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	thold_RXGEARBOXSLIP1_RXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	thold_RXGEARBOXSLIP1_RXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	thold_RXPOLARITY0_RXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	thold_RXPOLARITY0_RXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	thold_RXPOLARITY1_RXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	thold_RXPOLARITY1_RXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	thold_RXSLIDE0_RXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	thold_RXSLIDE0_RXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	thold_RXSLIDE1_RXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	thold_RXSLIDE1_RXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	thold_TXBYPASS8B10B0_TXUSRCLK20_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	thold_TXBYPASS8B10B0_TXUSRCLK20_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	thold_TXBYPASS8B10B1_TXUSRCLK21_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	thold_TXBYPASS8B10B1_TXUSRCLK21_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	thold_TXCHARDISPMODE0_TXUSRCLK20_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	thold_TXCHARDISPMODE0_TXUSRCLK20_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	thold_TXCHARDISPMODE1_TXUSRCLK21_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	thold_TXCHARDISPMODE1_TXUSRCLK21_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	thold_TXCHARDISPVAL0_TXUSRCLK20_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	thold_TXCHARDISPVAL0_TXUSRCLK20_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	thold_TXCHARDISPVAL1_TXUSRCLK21_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	thold_TXCHARDISPVAL1_TXUSRCLK21_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	thold_TXCHARISK0_TXUSRCLK20_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	thold_TXCHARISK0_TXUSRCLK20_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	thold_TXCHARISK1_TXUSRCLK21_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	thold_TXCHARISK1_TXUSRCLK21_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	thold_TXCOMSTART0_TXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	thold_TXCOMSTART0_TXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	thold_TXCOMSTART1_TXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	thold_TXCOMSTART1_TXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	thold_TXCOMTYPE0_TXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	thold_TXCOMTYPE0_TXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	thold_TXCOMTYPE1_TXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	thold_TXCOMTYPE1_TXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	thold_TXDATA0_TXUSRCLK20_negedge_posedge : VitalDelayArrayType(31 downto 0) := (others => 0 ps);
	thold_TXDATA0_TXUSRCLK20_posedge_posedge : VitalDelayArrayType(31 downto 0) := (others => 0 ps);
	thold_TXDATA1_TXUSRCLK21_negedge_posedge : VitalDelayArrayType(31 downto 0) := (others => 0 ps);
	thold_TXDATA1_TXUSRCLK21_posedge_posedge : VitalDelayArrayType(31 downto 0) := (others => 0 ps);
	thold_TXDETECTRX0_TXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	thold_TXDETECTRX0_TXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	thold_TXDETECTRX1_TXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	thold_TXDETECTRX1_TXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
        thold_TXELECIDLE0_TXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	thold_TXELECIDLE0_TXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	thold_TXELECIDLE1_TXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	thold_TXELECIDLE1_TXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	thold_TXENC8B10BUSE0_TXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	thold_TXENC8B10BUSE0_TXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	thold_TXENC8B10BUSE1_TXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	thold_TXENC8B10BUSE1_TXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	thold_TXENPRBSTST0_TXUSRCLK20_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
	thold_TXENPRBSTST0_TXUSRCLK20_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
	thold_TXENPRBSTST1_TXUSRCLK21_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
	thold_TXENPRBSTST1_TXUSRCLK21_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
	thold_TXHEADER0_TXUSRCLK20_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
	thold_TXHEADER0_TXUSRCLK20_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
	thold_TXHEADER1_TXUSRCLK21_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
	thold_TXHEADER1_TXUSRCLK21_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
	thold_TXINHIBIT0_TXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	thold_TXINHIBIT0_TXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	thold_TXINHIBIT1_TXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	thold_TXINHIBIT1_TXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	thold_TXPOLARITY0_TXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	thold_TXPOLARITY0_TXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	thold_TXPOLARITY1_TXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	thold_TXPOLARITY1_TXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	thold_TXSEQUENCE0_TXUSRCLK20_negedge_posedge : VitalDelayArrayType(6 downto 0) := (others => 0 ps);
	thold_TXSEQUENCE0_TXUSRCLK20_posedge_posedge : VitalDelayArrayType(6 downto 0) := (others => 0 ps);
	thold_TXSEQUENCE1_TXUSRCLK21_negedge_posedge : VitalDelayArrayType(6 downto 0) := (others => 0 ps);
	thold_TXSEQUENCE1_TXUSRCLK21_posedge_posedge : VitalDelayArrayType(6 downto 0) := (others => 0 ps);
	thold_TXSTARTSEQ0_TXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	thold_TXSTARTSEQ0_TXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	thold_TXSTARTSEQ1_TXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	thold_TXSTARTSEQ1_TXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_DADDR_DCLK_negedge_posedge : VitalDelayArrayType(6 downto 0) := (others => 0 ps);
	tsetup_DADDR_DCLK_posedge_posedge : VitalDelayArrayType(6 downto 0) := (others => 0 ps);
	tsetup_DEN_DCLK_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_DEN_DCLK_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_DFECLKDLYADJ0_RXUSRCLK20_negedge_posedge : VitalDelayArrayType(5 downto 0) := (others => 0 ps);
	tsetup_DFECLKDLYADJ0_RXUSRCLK20_posedge_posedge : VitalDelayArrayType(5 downto 0) := (others => 0 ps);
	tsetup_DFECLKDLYADJ1_RXUSRCLK21_negedge_posedge : VitalDelayArrayType(5 downto 0) := (others => 0 ps);
	tsetup_DFECLKDLYADJ1_RXUSRCLK21_posedge_posedge : VitalDelayArrayType(5 downto 0) := (others => 0 ps);
	tsetup_DFETAP10_RXUSRCLK20_negedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
	tsetup_DFETAP10_RXUSRCLK20_posedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
	tsetup_DFETAP11_RXUSRCLK21_negedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
	tsetup_DFETAP11_RXUSRCLK21_posedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
	tsetup_DFETAP20_RXUSRCLK20_negedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
	tsetup_DFETAP20_RXUSRCLK20_posedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
	tsetup_DFETAP21_RXUSRCLK21_negedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
	tsetup_DFETAP21_RXUSRCLK21_posedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
	tsetup_DFETAP30_RXUSRCLK20_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tsetup_DFETAP30_RXUSRCLK20_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tsetup_DFETAP31_RXUSRCLK21_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tsetup_DFETAP31_RXUSRCLK21_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tsetup_DFETAP40_RXUSRCLK20_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tsetup_DFETAP40_RXUSRCLK20_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tsetup_DFETAP41_RXUSRCLK21_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tsetup_DFETAP41_RXUSRCLK21_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tsetup_DI_DCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
	tsetup_DI_DCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
	tsetup_DWE_DCLK_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_DWE_DCLK_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_PRBSCNTRESET0_RXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_PRBSCNTRESET0_RXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_PRBSCNTRESET1_RXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_PRBSCNTRESET1_RXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXCHBONDI0_RXUSRCLK0_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tsetup_RXCHBONDI0_RXUSRCLK0_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tsetup_RXCHBONDI1_RXUSRCLK1_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tsetup_RXCHBONDI1_RXUSRCLK1_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tsetup_RXCOMMADETUSE0_RXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXCOMMADETUSE0_RXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXCOMMADETUSE1_RXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXCOMMADETUSE1_RXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXDEC8B10BUSE0_RXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXDEC8B10BUSE0_RXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXDEC8B10BUSE1_RXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXDEC8B10BUSE1_RXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXENCHANSYNC0_RXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXENCHANSYNC0_RXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXENCHANSYNC1_RXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXENCHANSYNC1_RXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXENMCOMMAALIGN0_RXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXENMCOMMAALIGN0_RXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXENMCOMMAALIGN1_RXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXENMCOMMAALIGN1_RXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXENPCOMMAALIGN0_RXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXENPCOMMAALIGN0_RXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXENPCOMMAALIGN1_RXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXENPCOMMAALIGN1_RXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXENPRBSTST0_RXUSRCLK20_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
	tsetup_RXENPRBSTST0_RXUSRCLK20_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
	tsetup_RXENPRBSTST1_RXUSRCLK21_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
	tsetup_RXENPRBSTST1_RXUSRCLK21_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
	tsetup_RXENSAMPLEALIGN0_RXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXENSAMPLEALIGN0_RXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXENSAMPLEALIGN1_RXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXENSAMPLEALIGN1_RXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXGEARBOXSLIP0_RXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXGEARBOXSLIP0_RXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXGEARBOXSLIP1_RXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXGEARBOXSLIP1_RXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXPOLARITY0_RXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXPOLARITY0_RXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXPOLARITY1_RXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXPOLARITY1_RXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXSLIDE0_RXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXSLIDE0_RXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXSLIDE1_RXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_RXSLIDE1_RXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_TXBYPASS8B10B0_TXUSRCLK20_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tsetup_TXBYPASS8B10B0_TXUSRCLK20_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tsetup_TXBYPASS8B10B1_TXUSRCLK21_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tsetup_TXBYPASS8B10B1_TXUSRCLK21_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tsetup_TXCHARDISPMODE0_TXUSRCLK20_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tsetup_TXCHARDISPMODE0_TXUSRCLK20_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tsetup_TXCHARDISPMODE1_TXUSRCLK21_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tsetup_TXCHARDISPMODE1_TXUSRCLK21_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tsetup_TXCHARDISPVAL0_TXUSRCLK20_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tsetup_TXCHARDISPVAL0_TXUSRCLK20_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tsetup_TXCHARDISPVAL1_TXUSRCLK21_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tsetup_TXCHARDISPVAL1_TXUSRCLK21_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tsetup_TXCHARISK0_TXUSRCLK20_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tsetup_TXCHARISK0_TXUSRCLK20_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tsetup_TXCHARISK1_TXUSRCLK21_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tsetup_TXCHARISK1_TXUSRCLK21_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tsetup_TXCOMSTART0_TXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_TXCOMSTART0_TXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_TXCOMSTART1_TXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_TXCOMSTART1_TXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_TXCOMTYPE0_TXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_TXCOMTYPE0_TXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_TXCOMTYPE1_TXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_TXCOMTYPE1_TXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_TXDATA0_TXUSRCLK20_negedge_posedge : VitalDelayArrayType(31 downto 0) := (others => 0 ps);
	tsetup_TXDATA0_TXUSRCLK20_posedge_posedge : VitalDelayArrayType(31 downto 0) := (others => 0 ps);
	tsetup_TXDATA1_TXUSRCLK21_negedge_posedge : VitalDelayArrayType(31 downto 0) := (others => 0 ps);
	tsetup_TXDATA1_TXUSRCLK21_posedge_posedge : VitalDelayArrayType(31 downto 0) := (others => 0 ps);
	tsetup_TXDETECTRX0_TXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_TXDETECTRX0_TXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_TXDETECTRX1_TXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_TXDETECTRX1_TXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
        tsetup_TXELECIDLE0_TXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_TXELECIDLE0_TXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_TXELECIDLE1_TXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_TXELECIDLE1_TXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_TXENC8B10BUSE0_TXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_TXENC8B10BUSE0_TXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_TXENC8B10BUSE1_TXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_TXENC8B10BUSE1_TXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_TXENPRBSTST0_TXUSRCLK20_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
	tsetup_TXENPRBSTST0_TXUSRCLK20_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
	tsetup_TXENPRBSTST1_TXUSRCLK21_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
	tsetup_TXENPRBSTST1_TXUSRCLK21_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
	tsetup_TXHEADER0_TXUSRCLK20_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
	tsetup_TXHEADER0_TXUSRCLK20_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
	tsetup_TXHEADER1_TXUSRCLK21_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
	tsetup_TXHEADER1_TXUSRCLK21_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
	tsetup_TXINHIBIT0_TXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_TXINHIBIT0_TXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_TXINHIBIT1_TXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_TXINHIBIT1_TXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_TXPOLARITY0_TXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_TXPOLARITY0_TXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_TXPOLARITY1_TXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_TXPOLARITY1_TXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_TXSEQUENCE0_TXUSRCLK20_negedge_posedge : VitalDelayArrayType(6 downto 0) := (others => 0 ps);
	tsetup_TXSEQUENCE0_TXUSRCLK20_posedge_posedge : VitalDelayArrayType(6 downto 0) := (others => 0 ps);
	tsetup_TXSEQUENCE1_TXUSRCLK21_negedge_posedge : VitalDelayArrayType(6 downto 0) := (others => 0 ps);
	tsetup_TXSEQUENCE1_TXUSRCLK21_posedge_posedge : VitalDelayArrayType(6 downto 0) := (others => 0 ps);
	tsetup_TXSTARTSEQ0_TXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_TXSTARTSEQ0_TXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
	tsetup_TXSTARTSEQ1_TXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
	tsetup_TXSTARTSEQ1_TXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;


	ticd_DCLK : VitalDelayType := 0 ps;
	ticd_RXUSRCLK0 : VitalDelayType := 0 ps;
	ticd_RXUSRCLK1 : VitalDelayType := 0 ps;
	ticd_RXUSRCLK20 : VitalDelayType := 0 ps;
	ticd_RXUSRCLK21 : VitalDelayType := 0 ps;
	ticd_TXUSRCLK20 : VitalDelayType := 0 ps;
	ticd_TXUSRCLK21 : VitalDelayType := 0 ps;

	tisd_DADDR_DCLK : VitalDelayArrayType(6 downto 0) := (others => 0 ps);
	tisd_DEN_DCLK : VitalDelayType := 0 ps;
	tisd_DFECLKDLYADJ0_RXUSRCLK20 : VitalDelayArrayType(5 downto 0) := (others => 0 ps);
	tisd_DFECLKDLYADJ1_RXUSRCLK21 : VitalDelayArrayType(5 downto 0) := (others => 0 ps);
	tisd_DFETAP10_RXUSRCLK20 : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
	tisd_DFETAP11_RXUSRCLK21 : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
	tisd_DFETAP20_RXUSRCLK20 : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
	tisd_DFETAP21_RXUSRCLK21 : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
	tisd_DFETAP30_RXUSRCLK20 : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tisd_DFETAP31_RXUSRCLK21 : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tisd_DFETAP40_RXUSRCLK20 : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tisd_DFETAP41_RXUSRCLK21 : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tisd_DI_DCLK : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
	tisd_DWE_DCLK : VitalDelayType := 0 ps;
	tisd_PRBSCNTRESET0_RXUSRCLK20 : VitalDelayType := 0 ps;
	tisd_PRBSCNTRESET1_RXUSRCLK21 : VitalDelayType := 0 ps;
	tisd_RXCHBONDI0_RXUSRCLK0 : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tisd_RXCHBONDI1_RXUSRCLK1 : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tisd_RXCOMMADETUSE0_RXUSRCLK20 : VitalDelayType := 0 ps;
	tisd_RXCOMMADETUSE1_RXUSRCLK21 : VitalDelayType := 0 ps;
	tisd_RXDEC8B10BUSE0_RXUSRCLK20 : VitalDelayType := 0 ps;
	tisd_RXDEC8B10BUSE1_RXUSRCLK21 : VitalDelayType := 0 ps;
	tisd_RXENCHANSYNC0_RXUSRCLK20 : VitalDelayType := 0 ps;
	tisd_RXENCHANSYNC1_RXUSRCLK21 : VitalDelayType := 0 ps;
	tisd_RXENMCOMMAALIGN0_RXUSRCLK20 : VitalDelayType := 0 ps;
	tisd_RXENMCOMMAALIGN1_RXUSRCLK21 : VitalDelayType := 0 ps;
	tisd_RXENPCOMMAALIGN0_RXUSRCLK20 : VitalDelayType := 0 ps;
	tisd_RXENPCOMMAALIGN1_RXUSRCLK21 : VitalDelayType := 0 ps;
	tisd_RXENPRBSTST0_RXUSRCLK20 : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
	tisd_RXENPRBSTST1_RXUSRCLK21 : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
	tisd_RXENSAMPLEALIGN0_RXUSRCLK20 : VitalDelayType := 0 ps;
	tisd_RXENSAMPLEALIGN1_RXUSRCLK21 : VitalDelayType := 0 ps;
	tisd_RXGEARBOXSLIP0_RXUSRCLK20 : VitalDelayType := 0 ps;
	tisd_RXGEARBOXSLIP1_RXUSRCLK21 : VitalDelayType := 0 ps;
	tisd_RXPOLARITY0_RXUSRCLK20 : VitalDelayType := 0 ps;
	tisd_RXPOLARITY1_RXUSRCLK21 : VitalDelayType := 0 ps;
	tisd_RXSLIDE0_RXUSRCLK20 : VitalDelayType := 0 ps;
	tisd_RXSLIDE1_RXUSRCLK21 : VitalDelayType := 0 ps;
	tisd_TXBYPASS8B10B0_TXUSRCLK20 : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tisd_TXBYPASS8B10B1_TXUSRCLK21 : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tisd_TXCHARDISPMODE0_TXUSRCLK20 : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tisd_TXCHARDISPMODE1_TXUSRCLK21 : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tisd_TXCHARDISPVAL0_TXUSRCLK20 : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tisd_TXCHARDISPVAL1_TXUSRCLK21 : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tisd_TXCHARISK0_TXUSRCLK20 : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tisd_TXCHARISK1_TXUSRCLK21 : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
	tisd_TXCOMSTART0_TXUSRCLK20 : VitalDelayType := 0 ps;
	tisd_TXCOMSTART1_TXUSRCLK21 : VitalDelayType := 0 ps;
	tisd_TXCOMTYPE0_TXUSRCLK20 : VitalDelayType := 0 ps;
	tisd_TXCOMTYPE1_TXUSRCLK21 : VitalDelayType := 0 ps;
	tisd_TXDATA0_TXUSRCLK20 : VitalDelayArrayType(31 downto 0) := (others => 0 ps);
	tisd_TXDATA1_TXUSRCLK21 : VitalDelayArrayType(31 downto 0) := (others => 0 ps);
	tisd_TXDETECTRX0_TXUSRCLK20 : VitalDelayType := 0 ps;
	tisd_TXDETECTRX1_TXUSRCLK21 : VitalDelayType := 0 ps;
        tisd_TXELECIDLE0_TXUSRCLK20 : VitalDelayType := 0 ps;
	tisd_TXELECIDLE1_TXUSRCLK21 : VitalDelayType := 0 ps;
	tisd_TXENC8B10BUSE0_TXUSRCLK20 : VitalDelayType := 0 ps;
	tisd_TXENC8B10BUSE1_TXUSRCLK21 : VitalDelayType := 0 ps;
	tisd_TXENPRBSTST0_TXUSRCLK20 : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
	tisd_TXENPRBSTST1_TXUSRCLK21 : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
	tisd_TXHEADER0_TXUSRCLK20 : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
	tisd_TXHEADER1_TXUSRCLK21 : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
	tisd_TXINHIBIT0_TXUSRCLK20 : VitalDelayType := 0 ps;
	tisd_TXINHIBIT1_TXUSRCLK21 : VitalDelayType := 0 ps;
	tisd_TXPOLARITY0_TXUSRCLK20 : VitalDelayType := 0 ps;
	tisd_TXPOLARITY1_TXUSRCLK21 : VitalDelayType := 0 ps;
	tisd_TXSEQUENCE0_TXUSRCLK20 : VitalDelayArrayType(6 downto 0) := (others => 0 ps);
	tisd_TXSEQUENCE1_TXUSRCLK21 : VitalDelayArrayType(6 downto 0) := (others => 0 ps);
	tisd_TXSTARTSEQ0_TXUSRCLK20 : VitalDelayType := 0 ps;
	tisd_TXSTARTSEQ1_TXUSRCLK21 : VitalDelayType := 0 ps 


  );

port (
		DFECLKDLYADJMONITOR0 : out std_logic_vector(5 downto 0);
		DFECLKDLYADJMONITOR1 : out std_logic_vector(5 downto 0);
		DFEEYEDACMONITOR0 : out std_logic_vector(4 downto 0);
		DFEEYEDACMONITOR1 : out std_logic_vector(4 downto 0);
		DFESENSCAL0 : out std_logic_vector(2 downto 0);
		DFESENSCAL1 : out std_logic_vector(2 downto 0);
		DFETAP1MONITOR0 : out std_logic_vector(4 downto 0);
		DFETAP1MONITOR1 : out std_logic_vector(4 downto 0);
		DFETAP2MONITOR0 : out std_logic_vector(4 downto 0);
		DFETAP2MONITOR1 : out std_logic_vector(4 downto 0);
		DFETAP3MONITOR0 : out std_logic_vector(3 downto 0);
		DFETAP3MONITOR1 : out std_logic_vector(3 downto 0);
		DFETAP4MONITOR0 : out std_logic_vector(3 downto 0);
		DFETAP4MONITOR1 : out std_logic_vector(3 downto 0);
		DO : out std_logic_vector(15 downto 0);
		DRDY : out std_ulogic;
		PHYSTATUS0 : out std_ulogic;
		PHYSTATUS1 : out std_ulogic;
		PLLLKDET : out std_ulogic;
		REFCLKOUT : out std_ulogic;
		RESETDONE0 : out std_ulogic;
		RESETDONE1 : out std_ulogic;
		RXBUFSTATUS0 : out std_logic_vector(2 downto 0);
		RXBUFSTATUS1 : out std_logic_vector(2 downto 0);
		RXBYTEISALIGNED0 : out std_ulogic;
		RXBYTEISALIGNED1 : out std_ulogic;
		RXBYTEREALIGN0 : out std_ulogic;
		RXBYTEREALIGN1 : out std_ulogic;
		RXCHANBONDSEQ0 : out std_ulogic;
		RXCHANBONDSEQ1 : out std_ulogic;
		RXCHANISALIGNED0 : out std_ulogic;
		RXCHANISALIGNED1 : out std_ulogic;
		RXCHANREALIGN0 : out std_ulogic;
		RXCHANREALIGN1 : out std_ulogic;
		RXCHARISCOMMA0 : out std_logic_vector(3 downto 0);
		RXCHARISCOMMA1 : out std_logic_vector(3 downto 0);
		RXCHARISK0 : out std_logic_vector(3 downto 0);
		RXCHARISK1 : out std_logic_vector(3 downto 0);
		RXCHBONDO0 : out std_logic_vector(3 downto 0);
		RXCHBONDO1 : out std_logic_vector(3 downto 0);
		RXCLKCORCNT0 : out std_logic_vector(2 downto 0);
		RXCLKCORCNT1 : out std_logic_vector(2 downto 0);
		RXCOMMADET0 : out std_ulogic;
		RXCOMMADET1 : out std_ulogic;
		RXDATA0 : out std_logic_vector(31 downto 0);
		RXDATA1 : out std_logic_vector(31 downto 0);
		RXDATAVALID0 : out std_ulogic;
		RXDATAVALID1 : out std_ulogic;
		RXDISPERR0 : out std_logic_vector(3 downto 0);
		RXDISPERR1 : out std_logic_vector(3 downto 0);
		RXELECIDLE0 : out std_ulogic;
		RXELECIDLE1 : out std_ulogic;
		RXHEADER0 : out std_logic_vector(2 downto 0);
		RXHEADER1 : out std_logic_vector(2 downto 0);
		RXHEADERVALID0 : out std_ulogic;
		RXHEADERVALID1 : out std_ulogic;
		RXLOSSOFSYNC0 : out std_logic_vector(1 downto 0);
		RXLOSSOFSYNC1 : out std_logic_vector(1 downto 0);
		RXNOTINTABLE0 : out std_logic_vector(3 downto 0);
		RXNOTINTABLE1 : out std_logic_vector(3 downto 0);
		RXOVERSAMPLEERR0 : out std_ulogic;
		RXOVERSAMPLEERR1 : out std_ulogic;
		RXPRBSERR0 : out std_ulogic;
		RXPRBSERR1 : out std_ulogic;
		RXRECCLK0 : out std_ulogic;
		RXRECCLK1 : out std_ulogic;
		RXRUNDISP0 : out std_logic_vector(3 downto 0);
		RXRUNDISP1 : out std_logic_vector(3 downto 0);
		RXSTARTOFSEQ0 : out std_ulogic;
		RXSTARTOFSEQ1 : out std_ulogic;
		RXSTATUS0 : out std_logic_vector(2 downto 0);
		RXSTATUS1 : out std_logic_vector(2 downto 0);
		RXVALID0 : out std_ulogic;
		RXVALID1 : out std_ulogic;
		TXBUFSTATUS0 : out std_logic_vector(1 downto 0);
		TXBUFSTATUS1 : out std_logic_vector(1 downto 0);
		TXGEARBOXREADY0 : out std_ulogic;
		TXGEARBOXREADY1 : out std_ulogic;
		TXKERR0 : out std_logic_vector(3 downto 0);
		TXKERR1 : out std_logic_vector(3 downto 0);
		TXN0 : out std_ulogic;
		TXN1 : out std_ulogic;
		TXOUTCLK0 : out std_ulogic;
		TXOUTCLK1 : out std_ulogic;
		TXP0 : out std_ulogic;
		TXP1 : out std_ulogic;
		TXRUNDISP0 : out std_logic_vector(3 downto 0);
		TXRUNDISP1 : out std_logic_vector(3 downto 0);

		CLKIN : in std_ulogic;
		DADDR : in std_logic_vector(6 downto 0);
		DCLK : in std_ulogic;
		DEN : in std_ulogic;
		DFECLKDLYADJ0 : in std_logic_vector(5 downto 0);
		DFECLKDLYADJ1 : in std_logic_vector(5 downto 0);
		DFETAP10 : in std_logic_vector(4 downto 0);
		DFETAP11 : in std_logic_vector(4 downto 0);
		DFETAP20 : in std_logic_vector(4 downto 0);
		DFETAP21 : in std_logic_vector(4 downto 0);
		DFETAP30 : in std_logic_vector(3 downto 0);
		DFETAP31 : in std_logic_vector(3 downto 0);
		DFETAP40 : in std_logic_vector(3 downto 0);
		DFETAP41 : in std_logic_vector(3 downto 0);
		DI : in std_logic_vector(15 downto 0);
		DWE : in std_ulogic;
		GTXRESET : in std_ulogic;
		GTXTEST : in std_logic_vector(13 downto 0);
		INTDATAWIDTH : in std_ulogic;
		LOOPBACK0 : in std_logic_vector(2 downto 0);
		LOOPBACK1 : in std_logic_vector(2 downto 0);
		PLLLKDETEN : in std_ulogic;
		PLLPOWERDOWN : in std_ulogic;
		PRBSCNTRESET0 : in std_ulogic;
		PRBSCNTRESET1 : in std_ulogic;
		REFCLKPWRDNB : in std_ulogic;
		RXBUFRESET0 : in std_ulogic;
		RXBUFRESET1 : in std_ulogic;
		RXCDRRESET0 : in std_ulogic;
		RXCDRRESET1 : in std_ulogic;
		RXCHBONDI0 : in std_logic_vector(3 downto 0);
		RXCHBONDI1 : in std_logic_vector(3 downto 0);
		RXCOMMADETUSE0 : in std_ulogic;
		RXCOMMADETUSE1 : in std_ulogic;
		RXDATAWIDTH0 : in std_logic_vector(1 downto 0);
		RXDATAWIDTH1 : in std_logic_vector(1 downto 0);
		RXDEC8B10BUSE0 : in std_ulogic;
		RXDEC8B10BUSE1 : in std_ulogic;
		RXENCHANSYNC0 : in std_ulogic;
		RXENCHANSYNC1 : in std_ulogic;
		RXENEQB0 : in std_ulogic;
		RXENEQB1 : in std_ulogic;
		RXENMCOMMAALIGN0 : in std_ulogic;
		RXENMCOMMAALIGN1 : in std_ulogic;
		RXENPCOMMAALIGN0 : in std_ulogic;
		RXENPCOMMAALIGN1 : in std_ulogic;
		RXENPMAPHASEALIGN0 : in std_ulogic;
		RXENPMAPHASEALIGN1 : in std_ulogic;
		RXENPRBSTST0 : in std_logic_vector(1 downto 0);
		RXENPRBSTST1 : in std_logic_vector(1 downto 0);
		RXENSAMPLEALIGN0 : in std_ulogic;
		RXENSAMPLEALIGN1 : in std_ulogic;
		RXEQMIX0 : in std_logic_vector(1 downto 0);
		RXEQMIX1 : in std_logic_vector(1 downto 0);
		RXEQPOLE0 : in std_logic_vector(3 downto 0);
		RXEQPOLE1 : in std_logic_vector(3 downto 0);
		RXGEARBOXSLIP0 : in std_ulogic;
		RXGEARBOXSLIP1 : in std_ulogic;
		RXN0 : in std_ulogic;
		RXN1 : in std_ulogic;
		RXP0 : in std_ulogic;
		RXP1 : in std_ulogic;
		RXPMASETPHASE0 : in std_ulogic;
		RXPMASETPHASE1 : in std_ulogic;
		RXPOLARITY0 : in std_ulogic;
		RXPOLARITY1 : in std_ulogic;
		RXPOWERDOWN0 : in std_logic_vector(1 downto 0);
		RXPOWERDOWN1 : in std_logic_vector(1 downto 0);
		RXRESET0 : in std_ulogic;
		RXRESET1 : in std_ulogic;
		RXSLIDE0 : in std_ulogic;
		RXSLIDE1 : in std_ulogic;
		RXUSRCLK0 : in std_ulogic;
		RXUSRCLK1 : in std_ulogic;
		RXUSRCLK20 : in std_ulogic;
		RXUSRCLK21 : in std_ulogic;
		TXBUFDIFFCTRL0 : in std_logic_vector(2 downto 0);
		TXBUFDIFFCTRL1 : in std_logic_vector(2 downto 0);
		TXBYPASS8B10B0 : in std_logic_vector(3 downto 0);
		TXBYPASS8B10B1 : in std_logic_vector(3 downto 0);
		TXCHARDISPMODE0 : in std_logic_vector(3 downto 0);
		TXCHARDISPMODE1 : in std_logic_vector(3 downto 0);
		TXCHARDISPVAL0 : in std_logic_vector(3 downto 0);
		TXCHARDISPVAL1 : in std_logic_vector(3 downto 0);
		TXCHARISK0 : in std_logic_vector(3 downto 0);
		TXCHARISK1 : in std_logic_vector(3 downto 0);
		TXCOMSTART0 : in std_ulogic;
		TXCOMSTART1 : in std_ulogic;
		TXCOMTYPE0 : in std_ulogic;
		TXCOMTYPE1 : in std_ulogic;
		TXDATA0 : in std_logic_vector(31 downto 0);
		TXDATA1 : in std_logic_vector(31 downto 0);
		TXDATAWIDTH0 : in std_logic_vector(1 downto 0);
		TXDATAWIDTH1 : in std_logic_vector(1 downto 0);
		TXDETECTRX0 : in std_ulogic;
		TXDETECTRX1 : in std_ulogic;
		TXDIFFCTRL0 : in std_logic_vector(2 downto 0);
		TXDIFFCTRL1 : in std_logic_vector(2 downto 0);
		TXELECIDLE0 : in std_ulogic;
		TXELECIDLE1 : in std_ulogic;
		TXENC8B10BUSE0 : in std_ulogic;
		TXENC8B10BUSE1 : in std_ulogic;
		TXENPMAPHASEALIGN0 : in std_ulogic;
		TXENPMAPHASEALIGN1 : in std_ulogic;
		TXENPRBSTST0 : in std_logic_vector(1 downto 0);
		TXENPRBSTST1 : in std_logic_vector(1 downto 0);
		TXHEADER0 : in std_logic_vector(2 downto 0);
		TXHEADER1 : in std_logic_vector(2 downto 0);
		TXINHIBIT0 : in std_ulogic;
		TXINHIBIT1 : in std_ulogic;
		TXPMASETPHASE0 : in std_ulogic;
		TXPMASETPHASE1 : in std_ulogic;
		TXPOLARITY0 : in std_ulogic;
		TXPOLARITY1 : in std_ulogic;
		TXPOWERDOWN0 : in std_logic_vector(1 downto 0);
		TXPOWERDOWN1 : in std_logic_vector(1 downto 0);
		TXPREEMPHASIS0 : in std_logic_vector(3 downto 0);
		TXPREEMPHASIS1 : in std_logic_vector(3 downto 0);
		TXRESET0 : in std_ulogic;
		TXRESET1 : in std_ulogic;
		TXSEQUENCE0 : in std_logic_vector(6 downto 0);
		TXSEQUENCE1 : in std_logic_vector(6 downto 0);
		TXSTARTSEQ0 : in std_ulogic;
		TXSTARTSEQ1 : in std_ulogic;
		TXUSRCLK0 : in std_ulogic;
		TXUSRCLK1 : in std_ulogic;
		TXUSRCLK20 : in std_ulogic;
		TXUSRCLK21 : in std_ulogic
     );
attribute VITAL_LEVEL0 of X_GTX_DUAL :     entity is true;

end X_GTX_DUAL;

architecture X_GTX_DUAL_V of X_GTX_DUAL is

  component GTX_DUAL_FAST
    port (
      DFECLKDLYADJMONITOR0 : out std_logic_vector(5 downto 0);
      DFECLKDLYADJMONITOR1 : out std_logic_vector(5 downto 0);
      DFEEYEDACMONITOR0    : out std_logic_vector(4 downto 0);
      DFEEYEDACMONITOR1    : out std_logic_vector(4 downto 0);
      DFESENSCAL0          : out std_logic_vector(2 downto 0);
      DFESENSCAL1          : out std_logic_vector(2 downto 0);
      DFETAP1MONITOR0      : out std_logic_vector(4 downto 0);
      DFETAP1MONITOR1      : out std_logic_vector(4 downto 0);
      DFETAP2MONITOR0      : out std_logic_vector(4 downto 0);
      DFETAP2MONITOR1      : out std_logic_vector(4 downto 0);
      DFETAP3MONITOR0      : out std_logic_vector(3 downto 0);
      DFETAP3MONITOR1      : out std_logic_vector(3 downto 0);
      DFETAP4MONITOR0      : out std_logic_vector(3 downto 0);
      DFETAP4MONITOR1      : out std_logic_vector(3 downto 0);
      DO                   : out std_logic_vector(15 downto 0);
      DRDY                 : out std_ulogic;
      PHYSTATUS0           : out std_ulogic;
      PHYSTATUS1           : out std_ulogic;
      PLLLKDET             : out std_ulogic;
      REFCLKOUT            : out std_ulogic;
      RESETDONE0           : out std_ulogic;
      RESETDONE1           : out std_ulogic;
      RXBUFSTATUS0         : out std_logic_vector(2 downto 0);
      RXBUFSTATUS1         : out std_logic_vector(2 downto 0);
      RXBYTEISALIGNED0     : out std_ulogic;
      RXBYTEISALIGNED1     : out std_ulogic;
      RXBYTEREALIGN0       : out std_ulogic;
      RXBYTEREALIGN1       : out std_ulogic;
      RXCHANBONDSEQ0       : out std_ulogic;
      RXCHANBONDSEQ1       : out std_ulogic;
      RXCHANISALIGNED0     : out std_ulogic;
      RXCHANISALIGNED1     : out std_ulogic;
      RXCHANREALIGN0       : out std_ulogic;
      RXCHANREALIGN1       : out std_ulogic;
      RXCHARISCOMMA0       : out std_logic_vector(3 downto 0);
      RXCHARISCOMMA1       : out std_logic_vector(3 downto 0);
      RXCHARISK0           : out std_logic_vector(3 downto 0);
      RXCHARISK1           : out std_logic_vector(3 downto 0);
      RXCHBONDO0           : out std_logic_vector(3 downto 0);
      RXCHBONDO1           : out std_logic_vector(3 downto 0);
      RXCLKCORCNT0         : out std_logic_vector(2 downto 0);
      RXCLKCORCNT1         : out std_logic_vector(2 downto 0);
      RXCOMMADET0          : out std_ulogic;
      RXCOMMADET1          : out std_ulogic;
      RXDATA0              : out std_logic_vector(31 downto 0);
      RXDATA1              : out std_logic_vector(31 downto 0);
      RXDATAVALID0         : out std_ulogic;
      RXDATAVALID1         : out std_ulogic;
      RXDISPERR0           : out std_logic_vector(3 downto 0);
      RXDISPERR1           : out std_logic_vector(3 downto 0);
      RXELECIDLE0          : out std_ulogic;
      RXELECIDLE1          : out std_ulogic;
      RXHEADER0            : out std_logic_vector(2 downto 0);
      RXHEADER1            : out std_logic_vector(2 downto 0);
      RXHEADERVALID0       : out std_ulogic;
      RXHEADERVALID1       : out std_ulogic;
      RXLOSSOFSYNC0        : out std_logic_vector(1 downto 0);
      RXLOSSOFSYNC1        : out std_logic_vector(1 downto 0);
      RXNOTINTABLE0        : out std_logic_vector(3 downto 0);
      RXNOTINTABLE1        : out std_logic_vector(3 downto 0);
      RXOVERSAMPLEERR0     : out std_ulogic;
      RXOVERSAMPLEERR1     : out std_ulogic;
      RXPRBSERR0           : out std_ulogic;
      RXPRBSERR1           : out std_ulogic;
      RXRECCLK0            : out std_ulogic;
      RXRECCLK1            : out std_ulogic;
      RXRUNDISP0           : out std_logic_vector(3 downto 0);
      RXRUNDISP1           : out std_logic_vector(3 downto 0);
      RXSTARTOFSEQ0        : out std_ulogic;
      RXSTARTOFSEQ1        : out std_ulogic;
      RXSTATUS0            : out std_logic_vector(2 downto 0);
      RXSTATUS1            : out std_logic_vector(2 downto 0);
      RXVALID0             : out std_ulogic;
      RXVALID1             : out std_ulogic;
      TXBUFSTATUS0         : out std_logic_vector(1 downto 0);
      TXBUFSTATUS1         : out std_logic_vector(1 downto 0);
      TXGEARBOXREADY0      : out std_ulogic;
      TXGEARBOXREADY1      : out std_ulogic;
      TXKERR0              : out std_logic_vector(3 downto 0);
      TXKERR1              : out std_logic_vector(3 downto 0);
      TXN0                 : out std_ulogic;
      TXN1                 : out std_ulogic;
      TXOUTCLK0            : out std_ulogic;
      TXOUTCLK1            : out std_ulogic;
      TXP0                 : out std_ulogic;
      TXP1                 : out std_ulogic;
      TXRUNDISP0           : out std_logic_vector(3 downto 0);
      TXRUNDISP1           : out std_logic_vector(3 downto 0);

      CLKIN                : in std_ulogic;
      DADDR                : in std_logic_vector(6 downto 0);
      DCLK                 : in std_ulogic;
      DEN                  : in std_ulogic;
      DFECLKDLYADJ0        : in std_logic_vector(5 downto 0);
      DFECLKDLYADJ1        : in std_logic_vector(5 downto 0);
      DFETAP10             : in std_logic_vector(4 downto 0);
      DFETAP11             : in std_logic_vector(4 downto 0);
      DFETAP20             : in std_logic_vector(4 downto 0);
      DFETAP21             : in std_logic_vector(4 downto 0);
      DFETAP30             : in std_logic_vector(3 downto 0);
      DFETAP31             : in std_logic_vector(3 downto 0);
      DFETAP40             : in std_logic_vector(3 downto 0);
      DFETAP41             : in std_logic_vector(3 downto 0);
      DI                   : in std_logic_vector(15 downto 0);
      DWE                  : in std_ulogic;
      GSR                  : in std_ulogic;
      GTXRESET             : in std_ulogic;
      GTXTEST              : in std_logic_vector(13 downto 0);
      INTDATAWIDTH         : in std_ulogic;
      LOOPBACK0            : in std_logic_vector(2 downto 0);
      LOOPBACK1            : in std_logic_vector(2 downto 0);
      PLLLKDETEN           : in std_ulogic;
      PLLPOWERDOWN         : in std_ulogic;
      PRBSCNTRESET0        : in std_ulogic;
      PRBSCNTRESET1        : in std_ulogic;
      REFCLKPWRDNB         : in std_ulogic;
      RXBUFRESET0          : in std_ulogic;
      RXBUFRESET1          : in std_ulogic;
      RXCDRRESET0          : in std_ulogic;
      RXCDRRESET1          : in std_ulogic;
      RXCHBONDI0           : in std_logic_vector(3 downto 0);
      RXCHBONDI1           : in std_logic_vector(3 downto 0);
      RXCOMMADETUSE0       : in std_ulogic;
      RXCOMMADETUSE1       : in std_ulogic;
      RXDATAWIDTH0         : in std_logic_vector(1 downto 0);
      RXDATAWIDTH1         : in std_logic_vector(1 downto 0);
      RXDEC8B10BUSE0       : in std_ulogic;
      RXDEC8B10BUSE1       : in std_ulogic;
      RXENCHANSYNC0        : in std_ulogic;
      RXENCHANSYNC1        : in std_ulogic;
      RXENEQB0             : in std_ulogic;
      RXENEQB1             : in std_ulogic;
      RXENMCOMMAALIGN0     : in std_ulogic;
      RXENMCOMMAALIGN1     : in std_ulogic;
      RXENPCOMMAALIGN0     : in std_ulogic;
      RXENPCOMMAALIGN1     : in std_ulogic;
      RXENPMAPHASEALIGN0   : in std_ulogic;
      RXENPMAPHASEALIGN1   : in std_ulogic;
      RXENPRBSTST0         : in std_logic_vector(1 downto 0);
      RXENPRBSTST1         : in std_logic_vector(1 downto 0);
      RXENSAMPLEALIGN0     : in std_ulogic;
      RXENSAMPLEALIGN1     : in std_ulogic;
      RXEQMIX0             : in std_logic_vector(1 downto 0);
      RXEQMIX1             : in std_logic_vector(1 downto 0);
      RXEQPOLE0            : in std_logic_vector(3 downto 0);
      RXEQPOLE1            : in std_logic_vector(3 downto 0);
      RXGEARBOXSLIP0       : in std_ulogic;
      RXGEARBOXSLIP1       : in std_ulogic;
      RXN0                 : in std_ulogic;
      RXN1                 : in std_ulogic;
      RXP0                 : in std_ulogic;
      RXP1                 : in std_ulogic;
      RXPMASETPHASE0       : in std_ulogic;
      RXPMASETPHASE1       : in std_ulogic;
      RXPOLARITY0          : in std_ulogic;
      RXPOLARITY1          : in std_ulogic;
      RXPOWERDOWN0         : in std_logic_vector(1 downto 0);
      RXPOWERDOWN1         : in std_logic_vector(1 downto 0);
      RXRESET0             : in std_ulogic;
      RXRESET1             : in std_ulogic;
      RXSLIDE0             : in std_ulogic;
      RXSLIDE1             : in std_ulogic;
      RXUSRCLK0            : in std_ulogic;
      RXUSRCLK1            : in std_ulogic;
      RXUSRCLK20           : in std_ulogic;
      RXUSRCLK21           : in std_ulogic;
      TXBUFDIFFCTRL0       : in std_logic_vector(2 downto 0);
      TXBUFDIFFCTRL1       : in std_logic_vector(2 downto 0);
      TXBYPASS8B10B0       : in std_logic_vector(3 downto 0);
      TXBYPASS8B10B1       : in std_logic_vector(3 downto 0);
      TXCHARDISPMODE0      : in std_logic_vector(3 downto 0);
      TXCHARDISPMODE1      : in std_logic_vector(3 downto 0);
      TXCHARDISPVAL0       : in std_logic_vector(3 downto 0);
      TXCHARDISPVAL1       : in std_logic_vector(3 downto 0);
      TXCHARISK0           : in std_logic_vector(3 downto 0);
      TXCHARISK1           : in std_logic_vector(3 downto 0);
      TXCOMSTART0          : in std_ulogic;
      TXCOMSTART1          : in std_ulogic;
      TXCOMTYPE0           : in std_ulogic;
      TXCOMTYPE1           : in std_ulogic;
      TXDATA0              : in std_logic_vector(31 downto 0);
      TXDATA1              : in std_logic_vector(31 downto 0);
      TXDATAWIDTH0         : in std_logic_vector(1 downto 0);
      TXDATAWIDTH1         : in std_logic_vector(1 downto 0);
      TXDETECTRX0          : in std_ulogic;
      TXDETECTRX1          : in std_ulogic;
      TXDIFFCTRL0          : in std_logic_vector(2 downto 0);
      TXDIFFCTRL1          : in std_logic_vector(2 downto 0);
      TXELECIDLE0          : in std_ulogic;
      TXELECIDLE1          : in std_ulogic;
      TXENC8B10BUSE0       : in std_ulogic;
      TXENC8B10BUSE1       : in std_ulogic;
      TXENPMAPHASEALIGN0   : in std_ulogic;
      TXENPMAPHASEALIGN1   : in std_ulogic;
      TXENPRBSTST0         : in std_logic_vector(1 downto 0);
      TXENPRBSTST1         : in std_logic_vector(1 downto 0);
      TXHEADER0            : in std_logic_vector(2 downto 0);
      TXHEADER1            : in std_logic_vector(2 downto 0);
      TXINHIBIT0           : in std_ulogic;
      TXINHIBIT1           : in std_ulogic;
      TXPMASETPHASE0       : in std_ulogic;
      TXPMASETPHASE1       : in std_ulogic;
      TXPOLARITY0          : in std_ulogic;
      TXPOLARITY1          : in std_ulogic;
      TXPOWERDOWN0         : in std_logic_vector(1 downto 0);
      TXPOWERDOWN1         : in std_logic_vector(1 downto 0);
      TXPREEMPHASIS0       : in std_logic_vector(3 downto 0);
      TXPREEMPHASIS1       : in std_logic_vector(3 downto 0);
      TXRESET0             : in std_ulogic;
      TXRESET1             : in std_ulogic;
      TXSEQUENCE0          : in std_logic_vector(6 downto 0);
      TXSEQUENCE1          : in std_logic_vector(6 downto 0);
      TXSTARTSEQ0          : in std_ulogic;
      TXSTARTSEQ1          : in std_ulogic;
      TXUSRCLK0            : in std_ulogic;
      TXUSRCLK1            : in std_ulogic;
      TXUSRCLK20           : in std_ulogic;
      TXUSRCLK21           : in std_ulogic;

      STEPPING                  : in std_ulogic;
      AC_CAP_DIS_0              : in std_ulogic;
      AC_CAP_DIS_1              : in std_ulogic;
      ALIGN_COMMA_WORD_0        : in std_ulogic;
      ALIGN_COMMA_WORD_1        : in std_ulogic;
      CB2_INH_CC_PERIOD_0       : in std_logic_vector(3 downto 0);
      CB2_INH_CC_PERIOD_1       : in std_logic_vector(3 downto 0);
      CDR_PH_ADJ_TIME           : in std_logic_vector(4 downto 0);
      CHAN_BOND_1_MAX_SKEW_0    : in std_logic_vector(3 downto 0);
      CHAN_BOND_1_MAX_SKEW_1    : in std_logic_vector(3 downto 0);
      CHAN_BOND_2_MAX_SKEW_0    : in std_logic_vector(3 downto 0);
      CHAN_BOND_2_MAX_SKEW_1    : in std_logic_vector(3 downto 0);
      CHAN_BOND_KEEP_ALIGN_0    : in std_ulogic;
      CHAN_BOND_KEEP_ALIGN_1    : in std_ulogic;
      CHAN_BOND_LEVEL_0         : in std_logic_vector(2 downto 0);
      CHAN_BOND_LEVEL_1         : in std_logic_vector(2 downto 0);
      CHAN_BOND_MODE_0          : in std_logic_vector(1 downto 0);
      CHAN_BOND_MODE_1          : in std_logic_vector(1 downto 0);
      CHAN_BOND_SEQ_1_1_0       : in std_logic_vector(9 downto 0);
      CHAN_BOND_SEQ_1_1_1       : in std_logic_vector(9 downto 0);
      CHAN_BOND_SEQ_1_2_0       : in std_logic_vector(9 downto 0);
      CHAN_BOND_SEQ_1_2_1       : in std_logic_vector(9 downto 0);
      CHAN_BOND_SEQ_1_3_0       : in std_logic_vector(9 downto 0);
      CHAN_BOND_SEQ_1_3_1       : in std_logic_vector(9 downto 0);
      CHAN_BOND_SEQ_1_4_0       : in std_logic_vector(9 downto 0);
      CHAN_BOND_SEQ_1_4_1       : in std_logic_vector(9 downto 0);
      CHAN_BOND_SEQ_1_ENABLE_0  : in std_logic_vector(3 downto 0);
      CHAN_BOND_SEQ_1_ENABLE_1  : in std_logic_vector(3 downto 0);
      CHAN_BOND_SEQ_2_1_0       : in std_logic_vector(9 downto 0);
      CHAN_BOND_SEQ_2_1_1       : in std_logic_vector(9 downto 0);
      CHAN_BOND_SEQ_2_2_0       : in std_logic_vector(9 downto 0);
      CHAN_BOND_SEQ_2_2_1       : in std_logic_vector(9 downto 0);
      CHAN_BOND_SEQ_2_3_0       : in std_logic_vector(9 downto 0);
      CHAN_BOND_SEQ_2_3_1       : in std_logic_vector(9 downto 0);
      CHAN_BOND_SEQ_2_4_0       : in std_logic_vector(9 downto 0);
      CHAN_BOND_SEQ_2_4_1       : in std_logic_vector(9 downto 0);
      CHAN_BOND_SEQ_2_ENABLE_0  : in std_logic_vector(3 downto 0);
      CHAN_BOND_SEQ_2_ENABLE_1  : in std_logic_vector(3 downto 0);
      CHAN_BOND_SEQ_2_USE_0     : in std_ulogic;
      CHAN_BOND_SEQ_2_USE_1     : in std_ulogic;
      CHAN_BOND_SEQ_LEN_0       : in std_logic_vector(1 downto 0);
      CHAN_BOND_SEQ_LEN_1       : in std_logic_vector(1 downto 0);
      CLK25_DIVIDER             : in std_logic_vector(2 downto 0);
      CLKINDC_B                 : in std_ulogic;
      CLKRCV_TRST               : in std_ulogic;
      CLK_CORRECT_USE_0         : in std_ulogic;
      CLK_CORRECT_USE_1         : in std_ulogic;
      CLK_COR_ADJ_LEN_0         : in std_logic_vector(1 downto 0);
      CLK_COR_ADJ_LEN_1         : in std_logic_vector(1 downto 0);
      CLK_COR_DET_LEN_0         : in std_logic_vector(1 downto 0);
      CLK_COR_DET_LEN_1         : in std_logic_vector(1 downto 0);
      CLK_COR_INSERT_IDLE_FLAG_0 : in std_ulogic;
      CLK_COR_INSERT_IDLE_FLAG_1 : in std_ulogic;
      CLK_COR_KEEP_IDLE_0       : in std_ulogic;
      CLK_COR_KEEP_IDLE_1       : in std_ulogic;
      CLK_COR_MAX_LAT_0         : in std_logic_vector(5 downto 0);
      CLK_COR_MAX_LAT_1         : in std_logic_vector(5 downto 0);
      CLK_COR_MIN_LAT_0         : in std_logic_vector(5 downto 0);
      CLK_COR_MIN_LAT_1         : in std_logic_vector(5 downto 0);
      CLK_COR_PRECEDENCE_0      : in std_ulogic;
      CLK_COR_PRECEDENCE_1      : in std_ulogic;
      CLK_COR_REPEAT_WAIT_0     : in std_logic_vector(4 downto 0);
      CLK_COR_REPEAT_WAIT_1     : in std_logic_vector(4 downto 0);
      CLK_COR_SEQ_1_1_0         : in std_logic_vector(9 downto 0);
      CLK_COR_SEQ_1_1_1         : in std_logic_vector(9 downto 0);
      CLK_COR_SEQ_1_2_0         : in std_logic_vector(9 downto 0);
      CLK_COR_SEQ_1_2_1         : in std_logic_vector(9 downto 0);
      CLK_COR_SEQ_1_3_0         : in std_logic_vector(9 downto 0);
      CLK_COR_SEQ_1_3_1         : in std_logic_vector(9 downto 0);
      CLK_COR_SEQ_1_4_0         : in std_logic_vector(9 downto 0);
      CLK_COR_SEQ_1_4_1         : in std_logic_vector(9 downto 0);
      CLK_COR_SEQ_1_ENABLE_0    : in std_logic_vector(3 downto 0);
      CLK_COR_SEQ_1_ENABLE_1    : in std_logic_vector(3 downto 0);
      CLK_COR_SEQ_2_1_0         : in std_logic_vector(9 downto 0);
      CLK_COR_SEQ_2_1_1         : in std_logic_vector(9 downto 0);
      CLK_COR_SEQ_2_2_0         : in std_logic_vector(9 downto 0);
      CLK_COR_SEQ_2_2_1         : in std_logic_vector(9 downto 0);
      CLK_COR_SEQ_2_3_0         : in std_logic_vector(9 downto 0);
      CLK_COR_SEQ_2_3_1         : in std_logic_vector(9 downto 0);
      CLK_COR_SEQ_2_4_0         : in std_logic_vector(9 downto 0);
      CLK_COR_SEQ_2_4_1         : in std_logic_vector(9 downto 0);
      CLK_COR_SEQ_2_ENABLE_0    : in std_logic_vector(3 downto 0);
      CLK_COR_SEQ_2_ENABLE_1    : in std_logic_vector(3 downto 0);
      CLK_COR_SEQ_2_USE_0       : in std_ulogic;
      CLK_COR_SEQ_2_USE_1       : in std_ulogic;
      CM_TRIM_0                 : in std_logic_vector(1 downto 0);
      CM_TRIM_1                 : in std_logic_vector(1 downto 0);
      COMMA_10B_ENABLE_0        : in std_logic_vector(9 downto 0);
      COMMA_10B_ENABLE_1        : in std_logic_vector(9 downto 0);
      COMMA_DOUBLE_0            : in std_ulogic;
      COMMA_DOUBLE_1            : in std_ulogic;
      COM_BURST_VAL_0           : in std_logic_vector(3 downto 0);
      COM_BURST_VAL_1           : in std_logic_vector(3 downto 0);
      DEC_MCOMMA_DETECT_0       : in std_ulogic;
      DEC_MCOMMA_DETECT_1       : in std_ulogic;
      DEC_PCOMMA_DETECT_0       : in std_ulogic;
      DEC_PCOMMA_DETECT_1       : in std_ulogic;
      DEC_VALID_COMMA_ONLY_0    : in std_ulogic;
      DEC_VALID_COMMA_ONLY_1    : in std_ulogic;
      DFE_CAL_TIME              : in std_logic_vector(4 downto 0);
      DFE_CFG_0                 : in std_logic_vector(9 downto 0);
      DFE_CFG_1                 : in std_logic_vector(9 downto 0);
      GEARBOX_ENDEC_0           : in std_logic_vector(2 downto 0);
      GEARBOX_ENDEC_1           : in std_logic_vector(2 downto 0);
      MCOMMA_10B_VALUE_0        : in std_logic_vector(9 downto 0);
      MCOMMA_10B_VALUE_1        : in std_logic_vector(9 downto 0);
      MCOMMA_DETECT_0           : in std_ulogic;
      MCOMMA_DETECT_1           : in std_ulogic;
      OOBDETECT_THRESHOLD_0     : in std_logic_vector(2 downto 0);
      OOBDETECT_THRESHOLD_1     : in std_logic_vector(2 downto 0);
      OOB_CLK_DIVIDER           : in std_logic_vector(2 downto 0);
      OVERSAMPLE_MODE           : in std_ulogic;
      PCI_EXPRESS_MODE_0        : in std_ulogic;
      PCI_EXPRESS_MODE_1        : in std_ulogic;
      PCOMMA_10B_VALUE_0        : in std_logic_vector(9 downto 0);
      PCOMMA_10B_VALUE_1        : in std_logic_vector(9 downto 0);
      PCOMMA_DETECT_0           : in std_ulogic;
      PCOMMA_DETECT_1           : in std_ulogic;
      PLL_COM_CFG               : in std_logic_vector(23 downto 0);
      PLL_CP_CFG                : in std_logic_vector(7 downto 0);
      PLL_DIVSEL_FB             : in std_logic_vector(4 downto 0);
      PLL_DIVSEL_REF            : in std_logic_vector(5 downto 0);
      PLL_FB_DCCEN              : in std_ulogic;
      PLL_LKDET_CFG             : in std_logic_vector(2 downto 0);
      PLL_RXDIVSEL_OUT_0        : in std_logic_vector(1 downto 0);
      PLL_RXDIVSEL_OUT_1        : in std_logic_vector(1 downto 0);
      PLL_SATA_0                : in std_ulogic;
      PLL_SATA_1                : in std_ulogic;
      PLL_TDCC_CFG              : in std_logic_vector(2 downto 0);
      PLL_TXDIVSEL_OUT_0        : in std_logic_vector(1 downto 0);
      PLL_TXDIVSEL_OUT_1        : in std_logic_vector(1 downto 0);
      PMA_CDR_SCAN_0            : in std_logic_vector(26 downto 0);
      PMA_CDR_SCAN_1            : in std_logic_vector(26 downto 0);
      PMA_COM_CFG               : in std_logic_vector(68 downto 0);
      PMA_RXSYNC_CFG_0          : in std_logic_vector(6 downto 0);
      PMA_RXSYNC_CFG_1          : in std_logic_vector(6 downto 0);
      PMA_RX_CFG_0              : in std_logic_vector(24 downto 0);
      PMA_RX_CFG_1              : in std_logic_vector(24 downto 0);
      PMA_TX_CFG_0              : in std_logic_vector(19 downto 0);
      PMA_TX_CFG_1              : in std_logic_vector(19 downto 0);
      PRBS_ERR_THRESHOLD_0      : in std_logic_vector(31 downto 0);
      PRBS_ERR_THRESHOLD_1      : in std_logic_vector(31 downto 0);
      RCV_TERM_GND_0            : in std_ulogic;
      RCV_TERM_GND_1            : in std_ulogic;
      RCV_TERM_VTTRX_0          : in std_ulogic;
      RCV_TERM_VTTRX_1          : in std_ulogic;
      RXGEARBOX_USE_0           : in std_ulogic;
      RXGEARBOX_USE_1           : in std_ulogic;
      RX_BUFFER_USE_0           : in std_ulogic;
      RX_BUFFER_USE_1           : in std_ulogic;
      RX_DECODE_SEQ_MATCH_0     : in std_ulogic;
      RX_DECODE_SEQ_MATCH_1     : in std_ulogic;
      RX_EN_IDLE_HOLD_CDR       : in std_ulogic;
      RX_EN_IDLE_HOLD_DFE_0     : in std_ulogic;
      RX_EN_IDLE_HOLD_DFE_1     : in std_ulogic;
      RX_EN_IDLE_RESET_BUF_0    : in std_ulogic;
      RX_EN_IDLE_RESET_BUF_1    : in std_ulogic;
      RX_EN_IDLE_RESET_FR       : in std_ulogic;
      RX_EN_IDLE_RESET_PH       : in std_ulogic;
      RX_IDLE_HI_CNT_0          : in std_logic_vector(3 downto 0);
      RX_IDLE_HI_CNT_1          : in std_logic_vector(3 downto 0);
      RX_IDLE_LO_CNT_0          : in std_logic_vector(3 downto 0);
      RX_IDLE_LO_CNT_1          : in std_logic_vector(3 downto 0);
      RX_LOSS_OF_SYNC_FSM_0     : in std_ulogic;
      RX_LOSS_OF_SYNC_FSM_1     : in std_ulogic;
      RX_LOS_INVALID_INCR_0     : in std_logic_vector(2 downto 0);
      RX_LOS_INVALID_INCR_1     : in std_logic_vector(2 downto 0);
      RX_LOS_THRESHOLD_0        : in std_logic_vector(2 downto 0);
      RX_LOS_THRESHOLD_1        : in std_logic_vector(2 downto 0);
      RX_SLIDE_MODE_0           : in std_ulogic;
      RX_SLIDE_MODE_1           : in std_ulogic;
      RX_STATUS_FMT_0           : in std_ulogic;
      RX_STATUS_FMT_1           : in std_ulogic;
      RX_XCLK_SEL_0             : in std_ulogic;
      RX_XCLK_SEL_1             : in std_ulogic;
      SATA_BURST_VAL_0          : in std_logic_vector(2 downto 0);
      SATA_BURST_VAL_1          : in std_logic_vector(2 downto 0);
      SATA_IDLE_VAL_0           : in std_logic_vector(2 downto 0);
      SATA_IDLE_VAL_1           : in std_logic_vector(2 downto 0);
      SATA_MAX_BURST_0          : in std_logic_vector(5 downto 0);
      SATA_MAX_BURST_1          : in std_logic_vector(5 downto 0);
      SATA_MAX_INIT_0           : in std_logic_vector(5 downto 0);
      SATA_MAX_INIT_1           : in std_logic_vector(5 downto 0);
      SATA_MAX_WAKE_0           : in std_logic_vector(5 downto 0);
      SATA_MAX_WAKE_1           : in std_logic_vector(5 downto 0);
      SATA_MIN_BURST_0          : in std_logic_vector(5 downto 0);
      SATA_MIN_BURST_1          : in std_logic_vector(5 downto 0);
      SATA_MIN_INIT_0           : in std_logic_vector(5 downto 0);
      SATA_MIN_INIT_1           : in std_logic_vector(5 downto 0);
      SATA_MIN_WAKE_0           : in std_logic_vector(5 downto 0);
      SATA_MIN_WAKE_1           : in std_logic_vector(5 downto 0);
      SIM_GTXRESET_SPEEDUP      : in std_ulogic;
      SIM_PLL_PERDIV2           : in std_logic_vector(8 downto 0);
      SIM_RECEIVER_DETECT_PASS_0 : in std_ulogic;
      SIM_RECEIVER_DETECT_PASS_1 : in std_ulogic;
      TERMINATION_CTRL          : in std_logic_vector(4 downto 0);
      TERMINATION_IMP_0         : in std_ulogic;
      TERMINATION_IMP_1         : in std_ulogic;
      TERMINATION_OVRD          : in std_ulogic;
      TRANS_TIME_FROM_P2_0      : in std_logic_vector(11 downto 0);
      TRANS_TIME_FROM_P2_1      : in std_logic_vector(11 downto 0);
      TRANS_TIME_NON_P2_0       : in std_logic_vector(7 downto 0);
      TRANS_TIME_NON_P2_1       : in std_logic_vector(7 downto 0);
      TRANS_TIME_TO_P2_0        : in std_logic_vector(9 downto 0);
      TRANS_TIME_TO_P2_1        : in std_logic_vector(9 downto 0);
      TXGEARBOX_USE_0           : in std_ulogic;
      TXGEARBOX_USE_1           : in std_ulogic;
      TXRX_INVERT_0             : in std_logic_vector(2 downto 0);
      TXRX_INVERT_1             : in std_logic_vector(2 downto 0);
      TX_BUFFER_USE_0           : in std_ulogic;
      TX_BUFFER_USE_1           : in std_ulogic;
      TX_DETECT_RX_CFG_0        : in std_logic_vector(13 downto 0);
      TX_DETECT_RX_CFG_1        : in std_logic_vector(13 downto 0);
      TX_IDLE_DELAY_0           : in std_logic_vector(2 downto 0);
      TX_IDLE_DELAY_1           : in std_logic_vector(2 downto 0);
      TX_XCLK_SEL_0             : in std_ulogic;
      TX_XCLK_SEL_1             : in std_ulogic
    );
  end component;

	constant IN_DELAY : time := 0 ps;
	constant OUT_DELAY : time := 0 ps;
	constant CLK_DELAY : time := 0 ps;


	signal   PLL_TXDIVSEL_OUT_0_BINARY  :  std_logic_vector(1 downto 0);
	signal   PLL_RXDIVSEL_OUT_0_BINARY  :  std_logic_vector(1 downto 0);
	signal   PLL_TXDIVSEL_OUT_1_BINARY  :  std_logic_vector(1 downto 0);
	signal   PLL_RXDIVSEL_OUT_1_BINARY  :  std_logic_vector(1 downto 0);
	signal   PLL_DIVSEL_FB_BINARY  :  std_logic_vector(4 downto 0);
	signal   PLL_DIVSEL_REF_BINARY  :  std_logic_vector(5 downto 0);
	signal   PLL_SATA_0_BINARY  :  std_ulogic;
	signal   PLL_SATA_1_BINARY  :  std_ulogic;
	signal   OOBDETECT_THRESHOLD_0_BINARY  :  std_logic_vector(2 downto 0) := To_StdLogicVector(OOBDETECT_THRESHOLD_0);
	signal   OOBDETECT_THRESHOLD_1_BINARY  :  std_logic_vector(2 downto 0) := To_StdLogicVector(OOBDETECT_THRESHOLD_1);
	signal   PMA_CDR_SCAN_0_BINARY  :  std_logic_vector(26 downto 0) := To_StdLogicVector(PMA_CDR_SCAN_0)(26 downto 0);
	signal   PMA_CDR_SCAN_1_BINARY  :  std_logic_vector(26 downto 0) := To_StdLogicVector(PMA_CDR_SCAN_1)(26 downto 0);
	signal   PMA_RX_CFG_0_BINARY  :  std_logic_vector(24 downto 0) := To_StdLogicVector(PMA_RX_CFG_0)(24 downto 0);
	signal   PMA_RX_CFG_1_BINARY  :  std_logic_vector(24 downto 0) := To_StdLogicVector(PMA_RX_CFG_1)(24 downto 0);
	signal   PLL_TDCC_CFG_BINARY  :  std_logic_vector(2 downto 0) := To_StdLogicVector(PLL_TDCC_CFG);
	signal   PMA_COM_CFG_BINARY  :  std_logic_vector(68 downto 0) := To_StdLogicVector(PMA_COM_CFG)(68 downto 0);
        signal   PMA_RXSYNC_CFG_0_BINARY  :  std_logic_vector(6 downto 0) := To_StdLogicVector(PMA_RXSYNC_CFG_0)(6 downto 0);
	signal   PMA_RXSYNC_CFG_1_BINARY  :  std_logic_vector(6 downto 0) := To_StdLogicVector(PMA_RXSYNC_CFG_1)(6 downto 0);
        signal   OOB_CLK_DIVIDER_BINARY  :  std_logic_vector(2 downto 0);
        signal   STEPPING_BINARY : std_ulogic := '0';
        signal   AC_CAP_DIS_0_BINARY  :  std_ulogic;
	signal   AC_CAP_DIS_1_BINARY  :  std_ulogic;
	signal   RCV_TERM_GND_0_BINARY  :  std_ulogic;
	signal   RCV_TERM_GND_1_BINARY  :  std_ulogic;
	signal   TERMINATION_IMP_0_BINARY  :  std_ulogic;
	signal   TERMINATION_IMP_1_BINARY  :  std_ulogic;
	signal   TERMINATION_OVRD_BINARY  :  std_ulogic;
	signal   TERMINATION_CTRL_BINARY  :  std_logic_vector(4 downto 0) := To_StdLogicVector(TERMINATION_CTRL);
	signal   RCV_TERM_VTTRX_0_BINARY  :  std_ulogic;
	signal   RCV_TERM_VTTRX_1_BINARY  :  std_ulogic;
  	signal   PLL_LKDET_CFG_BINARY  :  std_logic_vector(2 downto 0) := To_StdLogicVector(PLL_LKDET_CFG);
	signal   TXRX_INVERT_0_BINARY  :  std_logic_vector(2 downto 0) := To_StdLogicVector(TXRX_INVERT_0);
	signal   TXRX_INVERT_1_BINARY  :  std_logic_vector(2 downto 0) := To_StdLogicVector(TXRX_INVERT_1);
	signal   CLKINDC_B_BINARY  :  std_ulogic;
	signal   PCOMMA_DETECT_0_BINARY  :  std_ulogic;
	signal   MCOMMA_DETECT_0_BINARY  :  std_ulogic;
	signal   PCOMMA_10B_VALUE_0_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(PCOMMA_10B_VALUE_0);
	signal   MCOMMA_10B_VALUE_0_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(MCOMMA_10B_VALUE_0);
	signal   COMMA_10B_ENABLE_0_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(COMMA_10B_ENABLE_0);
	signal   COMMA_DOUBLE_0_BINARY  :  std_ulogic;
	signal   ALIGN_COMMA_WORD_0_BINARY  :  std_ulogic;
	signal   DEC_PCOMMA_DETECT_0_BINARY  :  std_ulogic;
	signal   DEC_MCOMMA_DETECT_0_BINARY  :  std_ulogic;
	signal   DEC_VALID_COMMA_ONLY_0_BINARY  :  std_ulogic;
	signal   PCOMMA_DETECT_1_BINARY  :  std_ulogic;
	signal   MCOMMA_DETECT_1_BINARY  :  std_ulogic;
	signal   PCOMMA_10B_VALUE_1_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(PCOMMA_10B_VALUE_1);
	signal   MCOMMA_10B_VALUE_1_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(MCOMMA_10B_VALUE_1);
	signal   COMMA_10B_ENABLE_1_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(COMMA_10B_ENABLE_1);
	signal   COMMA_DOUBLE_1_BINARY  :  std_ulogic;
	signal   ALIGN_COMMA_WORD_1_BINARY  :  std_ulogic;
	signal   DEC_PCOMMA_DETECT_1_BINARY  :  std_ulogic;
	signal   DEC_MCOMMA_DETECT_1_BINARY  :  std_ulogic;
	signal   DEC_VALID_COMMA_ONLY_1_BINARY  :  std_ulogic;
	signal   RX_LOSS_OF_SYNC_FSM_0_BINARY  :  std_ulogic;
	signal   RX_LOS_INVALID_INCR_0_BINARY  :  std_logic_vector(2 downto 0);
	signal   RX_LOS_THRESHOLD_0_BINARY  :  std_logic_vector(2 downto 0);
	signal   RX_LOSS_OF_SYNC_FSM_1_BINARY  :  std_ulogic;
	signal   RX_LOS_INVALID_INCR_1_BINARY  :  std_logic_vector(2 downto 0);
	signal   RX_LOS_THRESHOLD_1_BINARY  :  std_logic_vector(2 downto 0);
	signal   RX_BUFFER_USE_0_BINARY  :  std_ulogic;
	signal   RX_DECODE_SEQ_MATCH_0_BINARY  :  std_ulogic;
	signal   RX_BUFFER_USE_1_BINARY  :  std_ulogic;
	signal   RX_DECODE_SEQ_MATCH_1_BINARY  :  std_ulogic;
	signal   CLK_COR_MIN_LAT_0_BINARY  :  std_logic_vector(5 downto 0);
	signal   CLK_COR_MAX_LAT_0_BINARY  :  std_logic_vector(5 downto 0);
	signal   CLK_CORRECT_USE_0_BINARY  :  std_ulogic;
	signal   CLK_COR_PRECEDENCE_0_BINARY  :  std_ulogic;
	signal   CLK_COR_DET_LEN_0_BINARY  :  std_logic_vector(1 downto 0);
	signal   CLK_COR_ADJ_LEN_0_BINARY  :  std_logic_vector(1 downto 0);
	signal   CLK_COR_KEEP_IDLE_0_BINARY  :  std_ulogic;
	signal   CLK_COR_INSERT_IDLE_FLAG_0_BINARY  :  std_ulogic;
	signal   CLK_COR_REPEAT_WAIT_0_BINARY  :  std_logic_vector(4 downto 0);
	signal   CLK_COR_SEQ_2_USE_0_BINARY  :  std_ulogic;
	signal   CLK_COR_SEQ_1_1_0_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_1_1_0);
	signal   CLK_COR_SEQ_1_2_0_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_1_2_0);
	signal   CLK_COR_SEQ_1_3_0_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_1_3_0);
	signal   CLK_COR_SEQ_1_4_0_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_1_4_0);
	signal   CLK_COR_SEQ_2_1_0_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_2_1_0);
	signal   CLK_COR_SEQ_2_2_0_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_2_2_0);
	signal   CLK_COR_SEQ_2_3_0_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_2_3_0);
	signal   CLK_COR_SEQ_2_4_0_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_2_4_0);
	signal   CLK_COR_SEQ_1_ENABLE_0_BINARY  :  std_logic_vector(3 downto 0) := To_StdLogicVector(CLK_COR_SEQ_1_ENABLE_0);
	signal   CLK_COR_SEQ_2_ENABLE_0_BINARY  :  std_logic_vector(3 downto 0) := To_StdLogicVector(CLK_COR_SEQ_2_ENABLE_0);
	signal   CLK_COR_MIN_LAT_1_BINARY  :  std_logic_vector(5 downto 0);
	signal   CLK_COR_MAX_LAT_1_BINARY  :  std_logic_vector(5 downto 0);
	signal   CLK_CORRECT_USE_1_BINARY  :  std_ulogic;
	signal   CLK_COR_PRECEDENCE_1_BINARY  :  std_ulogic;
	signal   CLK_COR_DET_LEN_1_BINARY  :  std_logic_vector(1 downto 0);
	signal   CLK_COR_ADJ_LEN_1_BINARY  :  std_logic_vector(1 downto 0);
	signal   CLK_COR_KEEP_IDLE_1_BINARY  :  std_ulogic;
	signal   CLK_COR_INSERT_IDLE_FLAG_1_BINARY  :  std_ulogic;
	signal   CLK_COR_REPEAT_WAIT_1_BINARY  :  std_logic_vector(4 downto 0);
	signal   CLK_COR_SEQ_2_USE_1_BINARY  :  std_ulogic;
	signal   CLK_COR_SEQ_1_1_1_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_1_1_1);
	signal   CLK_COR_SEQ_1_2_1_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_1_2_1);
	signal   CLK_COR_SEQ_1_3_1_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_1_3_1);
	signal   CLK_COR_SEQ_1_4_1_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_1_4_1);
	signal   CLK_COR_SEQ_2_1_1_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_2_1_1);
	signal   CLK_COR_SEQ_2_2_1_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_2_2_1);
	signal   CLK_COR_SEQ_2_3_1_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_2_3_1);
	signal   CLK_COR_SEQ_2_4_1_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_2_4_1);
	signal   CLK_COR_SEQ_1_ENABLE_1_BINARY  :  std_logic_vector(3 downto 0) := To_StdLogicVector(CLK_COR_SEQ_1_ENABLE_1);
	signal   CLK_COR_SEQ_2_ENABLE_1_BINARY  :  std_logic_vector(3 downto 0) := To_StdLogicVector(CLK_COR_SEQ_2_ENABLE_1);
	signal   CHAN_BOND_MODE_0_BINARY  :  std_logic_vector(1 downto 0);
	signal   CHAN_BOND_LEVEL_0_BINARY  :  std_logic_vector(2 downto 0);
	signal   CHAN_BOND_SEQ_LEN_0_BINARY  :  std_logic_vector(1 downto 0);
	signal   CHAN_BOND_SEQ_2_USE_0_BINARY  :  std_ulogic;
	signal   CHAN_BOND_SEQ_1_1_0_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_1_1_0);
	signal   CHAN_BOND_SEQ_1_2_0_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_1_2_0);
	signal   CHAN_BOND_SEQ_1_3_0_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_1_3_0);
	signal   CHAN_BOND_SEQ_1_4_0_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_1_4_0);
	signal   CHAN_BOND_SEQ_2_1_0_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_2_1_0);
	signal   CHAN_BOND_SEQ_2_2_0_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_2_2_0);
	signal   CHAN_BOND_SEQ_2_3_0_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_2_3_0);
	signal   CHAN_BOND_SEQ_2_4_0_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_2_4_0);
	signal   CHAN_BOND_SEQ_1_ENABLE_0_BINARY  :  std_logic_vector(3 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_1_ENABLE_0);
	signal   CHAN_BOND_SEQ_2_ENABLE_0_BINARY  :  std_logic_vector(3 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_2_ENABLE_0);
	signal   CHAN_BOND_1_MAX_SKEW_0_BINARY  :  std_logic_vector(3 downto 0);
	signal   CHAN_BOND_2_MAX_SKEW_0_BINARY  :  std_logic_vector(3 downto 0);
	signal   CHAN_BOND_KEEP_ALIGN_0_BINARY  :  std_ulogic;
	signal   CB2_INH_CC_PERIOD_0_BINARY  :  std_logic_vector(3 downto 0);
	signal   CHAN_BOND_MODE_1_BINARY  :  std_logic_vector(1 downto 0);
	signal   CHAN_BOND_LEVEL_1_BINARY  :  std_logic_vector(2 downto 0);
	signal   CHAN_BOND_SEQ_LEN_1_BINARY  :  std_logic_vector(1 downto 0);
	signal   CHAN_BOND_SEQ_2_USE_1_BINARY  :  std_ulogic;
	signal   CHAN_BOND_SEQ_1_1_1_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_1_1_1);
	signal   CHAN_BOND_SEQ_1_2_1_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_1_2_1);
	signal   CHAN_BOND_SEQ_1_3_1_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_1_3_1);
	signal   CHAN_BOND_SEQ_1_4_1_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_1_4_1);
	signal   CHAN_BOND_SEQ_2_1_1_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_2_1_1);
	signal   CHAN_BOND_SEQ_2_2_1_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_2_2_1);
	signal   CHAN_BOND_SEQ_2_3_1_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_2_3_1);
	signal   CHAN_BOND_SEQ_2_4_1_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_2_4_1);
	signal   CHAN_BOND_SEQ_1_ENABLE_1_BINARY  :  std_logic_vector(3 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_1_ENABLE_1);
	signal   CHAN_BOND_SEQ_2_ENABLE_1_BINARY  :  std_logic_vector(3 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_2_ENABLE_1);
	signal   CHAN_BOND_1_MAX_SKEW_1_BINARY  :  std_logic_vector(3 downto 0);
	signal   CHAN_BOND_2_MAX_SKEW_1_BINARY  :  std_logic_vector(3 downto 0);
	signal   CHAN_BOND_KEEP_ALIGN_1_BINARY  :  std_ulogic;
	signal   CB2_INH_CC_PERIOD_1_BINARY  :  std_logic_vector(3 downto 0);
	signal   PCI_EXPRESS_MODE_0_BINARY  :  std_ulogic;
	signal   TRANS_TIME_FROM_P2_0_BINARY  :  std_logic_vector(11 downto 0) := To_StdLogicVector(TRANS_TIME_FROM_P2_0);
	signal   TRANS_TIME_NON_P2_0_BINARY  :  std_logic_vector(7 downto 0) := To_StdLogicVector(TRANS_TIME_NON_P2_0);
	signal   TRANS_TIME_TO_P2_0_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(TRANS_TIME_TO_P2_0)(9 downto 0);
	signal   PCI_EXPRESS_MODE_1_BINARY  :  std_ulogic;
	signal   TRANS_TIME_FROM_P2_1_BINARY  :  std_logic_vector(11 downto 0) := To_StdLogicVector(TRANS_TIME_FROM_P2_1);
	signal   TRANS_TIME_NON_P2_1_BINARY  :  std_logic_vector(7 downto 0) := To_StdLogicVector(TRANS_TIME_NON_P2_1);
	signal   TRANS_TIME_TO_P2_1_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(TRANS_TIME_TO_P2_1)(9 downto 0);
	signal   RX_STATUS_FMT_0_BINARY  :  std_ulogic;
	signal   TX_BUFFER_USE_0_BINARY  :  std_ulogic;
	signal   TX_XCLK_SEL_0_BINARY  :  std_ulogic;
	signal   RX_XCLK_SEL_0_BINARY  :  std_ulogic;
	signal   RX_STATUS_FMT_1_BINARY  :  std_ulogic;
	signal   TX_BUFFER_USE_1_BINARY  :  std_ulogic;
	signal   TX_XCLK_SEL_1_BINARY  :  std_ulogic;
	signal   RX_XCLK_SEL_1_BINARY  :  std_ulogic;
	signal   PRBS_ERR_THRESHOLD_0_BINARY  :  std_logic_vector(31 downto 0) := To_StdLogicVector(PRBS_ERR_THRESHOLD_0);
	signal   RX_SLIDE_MODE_0_BINARY  :  std_ulogic;
	signal   PRBS_ERR_THRESHOLD_1_BINARY  :  std_logic_vector(31 downto 0) := To_StdLogicVector(PRBS_ERR_THRESHOLD_1);
	signal   RX_SLIDE_MODE_1_BINARY  :  std_ulogic;
	signal   SATA_MIN_BURST_0_BINARY  :  std_logic_vector(5 downto 0);
	signal   SATA_MAX_BURST_0_BINARY  :  std_logic_vector(5 downto 0);
	signal   SATA_MIN_INIT_0_BINARY  :  std_logic_vector(5 downto 0);
	signal   SATA_MAX_INIT_0_BINARY  :  std_logic_vector(5 downto 0);
	signal   SATA_MIN_WAKE_0_BINARY  :  std_logic_vector(5 downto 0);
	signal   SATA_MAX_WAKE_0_BINARY  :  std_logic_vector(5 downto 0);
        signal   TX_DETECT_RX_CFG_0_BINARY  :  std_logic_vector(13 downto 0) := To_StdLogicVector(TX_DETECT_RX_CFG_0)(13 downto 0);
        signal   SATA_BURST_VAL_0_BINARY  :  std_logic_vector(2 downto 0) := To_StdLogicVector(SATA_BURST_VAL_0);
	signal   SATA_IDLE_VAL_0_BINARY  :  std_logic_vector(2 downto 0) := To_StdLogicVector(SATA_IDLE_VAL_0);
	signal   COM_BURST_VAL_0_BINARY  :  std_logic_vector(3 downto 0) := To_StdLogicVector(COM_BURST_VAL_0);
	signal   SATA_MIN_BURST_1_BINARY  :  std_logic_vector(5 downto 0);
	signal   SATA_MAX_BURST_1_BINARY  :  std_logic_vector(5 downto 0);
	signal   SATA_MIN_INIT_1_BINARY  :  std_logic_vector(5 downto 0);
	signal   SATA_MAX_INIT_1_BINARY  :  std_logic_vector(5 downto 0);
	signal   SATA_MIN_WAKE_1_BINARY  :  std_logic_vector(5 downto 0);
	signal   SATA_MAX_WAKE_1_BINARY  :  std_logic_vector(5 downto 0);
	signal   TX_DETECT_RX_CFG_1_BINARY  :  std_logic_vector(13 downto 0) := To_StdLogicVector(TX_DETECT_RX_CFG_1)(13 downto 0);
        signal   SATA_BURST_VAL_1_BINARY  :  std_logic_vector(2 downto 0) := To_StdLogicVector(SATA_BURST_VAL_1);
	signal   SATA_IDLE_VAL_1_BINARY  :  std_logic_vector(2 downto 0) := To_StdLogicVector(SATA_IDLE_VAL_1);
	signal   COM_BURST_VAL_1_BINARY  :  std_logic_vector(3 downto 0) := To_StdLogicVector(COM_BURST_VAL_1);
	signal   CLK25_DIVIDER_BINARY  :  std_logic_vector(2 downto 0);
	signal   PLL_COM_CFG_BINARY  :  std_logic_vector(23 downto 0) := To_StdLogicVector(PLL_COM_CFG);
	signal   PLL_CP_CFG_BINARY  :  std_logic_vector(7 downto 0) := To_StdLogicVector(PLL_CP_CFG);
        signal   OVERSAMPLE_MODE_BINARY  :  std_ulogic;
	signal   TXGEARBOX_USE_0_BINARY  :  std_ulogic;
	signal   RXGEARBOX_USE_0_BINARY  :  std_ulogic;
	signal   GEARBOX_ENDEC_0_BINARY  :  std_logic_vector(2 downto 0) := To_StdLogicVector(GEARBOX_ENDEC_0)(2 downto 0);
	signal   TXGEARBOX_USE_1_BINARY  :  std_ulogic;
	signal   RXGEARBOX_USE_1_BINARY  :  std_ulogic;
	signal   GEARBOX_ENDEC_1_BINARY  :  std_logic_vector(2 downto 0) := To_StdLogicVector(GEARBOX_ENDEC_1)(2 downto 0);
	signal   DFE_CFG_0_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(DFE_CFG_0);
	signal   DFE_CFG_1_BINARY  :  std_logic_vector(9 downto 0) := To_StdLogicVector(DFE_CFG_1);
	signal   PMA_TX_CFG_0_BINARY  :  std_logic_vector(19 downto 0) := To_StdLogicVector(PMA_TX_CFG_0)(19 downto 0);
	signal   CM_TRIM_0_BINARY  :  std_logic_vector(1 downto 0) := To_StdLogicVector(CM_TRIM_0)(1 downto 0);
	signal   PMA_TX_CFG_1_BINARY  :  std_logic_vector(19 downto 0) := To_StdLogicVector(PMA_TX_CFG_1)(19 downto 0);
	signal   CM_TRIM_1_BINARY  :  std_logic_vector(1 downto 0) := To_StdLogicVector(CM_TRIM_1)(1 downto 0);
	signal   PLL_FB_DCCEN_BINARY  :  std_ulogic;
	signal   CLKRCV_TRST_BINARY  :  std_ulogic;
	signal   TX_IDLE_DELAY_0_BINARY  :  std_logic_vector(2 downto 0) := To_StdLogicVector(TX_IDLE_DELAY_0)(2 downto 0);
	signal   RX_EN_IDLE_HOLD_DFE_0_BINARY  :  std_ulogic;
	signal   RX_EN_IDLE_RESET_BUF_0_BINARY  :  std_ulogic;
	signal   RX_IDLE_HI_CNT_0_BINARY  :  std_logic_vector(3 downto 0) := To_StdLogicVector(RX_IDLE_HI_CNT_0);
	signal   RX_IDLE_LO_CNT_0_BINARY  :  std_logic_vector(3 downto 0) := To_StdLogicVector(RX_IDLE_LO_CNT_0);
	signal   TX_IDLE_DELAY_1_BINARY  :  std_logic_vector(2 downto 0) := To_StdLogicVector(TX_IDLE_DELAY_1)(2 downto 0);
	signal   RX_EN_IDLE_HOLD_DFE_1_BINARY  :  std_ulogic;
	signal   RX_EN_IDLE_RESET_BUF_1_BINARY  :  std_ulogic;
	signal   RX_IDLE_HI_CNT_1_BINARY  :  std_logic_vector(3 downto 0) := To_StdLogicVector(RX_IDLE_HI_CNT_1);
	signal   RX_IDLE_LO_CNT_1_BINARY  :  std_logic_vector(3 downto 0) := To_StdLogicVector(RX_IDLE_LO_CNT_1);
	signal   RX_EN_IDLE_HOLD_CDR_BINARY  :  std_ulogic;
	signal   RX_EN_IDLE_RESET_PH_BINARY  :  std_ulogic;
	signal   RX_EN_IDLE_RESET_FR_BINARY  :  std_ulogic;
	signal   DFE_CAL_TIME_BINARY  :  std_logic_vector(4 downto 0) := To_StdLogicVector(DFE_CAL_TIME)(4 downto 0);
	signal   CDR_PH_ADJ_TIME_BINARY  :  std_logic_vector(4 downto 0) := To_StdLogicVector(CDR_PH_ADJ_TIME)(4 downto 0);
	signal   SIM_GTXRESET_SPEEDUP_BINARY  :  std_ulogic;
        signal   SIM_MODE_BINARY  :  std_ulogic;
        signal   SIM_PLL_PERDIV2_BINARY  :  std_logic_vector(8 downto 0) := To_StdLogicVector(SIM_PLL_PERDIV2)(8 downto 0);
	signal   SIM_RECEIVER_DETECT_PASS_0_BINARY  :  std_ulogic;
	signal   SIM_RECEIVER_DETECT_PASS_1_BINARY  :  std_ulogic;


	signal   REFCLKOUT_out  :  std_ulogic;
	signal   RXRECCLK0_out  :  std_ulogic;
	signal   TXOUTCLK0_out  :  std_ulogic;
	signal   RXRECCLK1_out  :  std_ulogic;
	signal   TXOUTCLK1_out  :  std_ulogic;
	signal   TXP0_out  :  std_ulogic;
	signal   TXN0_out  :  std_ulogic;
	signal   TXP1_out  :  std_ulogic;
	signal   TXN1_out  :  std_ulogic;
	signal   RXDATA0_out  :  std_logic_vector(31 downto 0);
	signal   RXNOTINTABLE0_out  :  std_logic_vector(3 downto 0);
	signal   RXDISPERR0_out  :  std_logic_vector(3 downto 0);
	signal   RXCHARISK0_out  :  std_logic_vector(3 downto 0);
	signal   RXRUNDISP0_out  :  std_logic_vector(3 downto 0);
	signal   RXCHARISCOMMA0_out  :  std_logic_vector(3 downto 0);
	signal   RXVALID0_out  :  std_ulogic;
	signal   RXDATA1_out  :  std_logic_vector(31 downto 0);
	signal   RXNOTINTABLE1_out  :  std_logic_vector(3 downto 0);
	signal   RXDISPERR1_out  :  std_logic_vector(3 downto 0);
	signal   RXCHARISK1_out  :  std_logic_vector(3 downto 0);
	signal   RXRUNDISP1_out  :  std_logic_vector(3 downto 0);
	signal   RXCHARISCOMMA1_out  :  std_logic_vector(3 downto 0);
	signal   RXVALID1_out  :  std_ulogic;
	signal   RESETDONE0_out  :  std_ulogic;
	signal   RESETDONE1_out  :  std_ulogic;
	signal   TXKERR0_out  :  std_logic_vector(3 downto 0);
	signal   TXRUNDISP0_out  :  std_logic_vector(3 downto 0);
	signal   TXBUFSTATUS0_out  :  std_logic_vector(1 downto 0);
	signal   TXKERR1_out  :  std_logic_vector(3 downto 0);
	signal   TXRUNDISP1_out  :  std_logic_vector(3 downto 0);
	signal   TXBUFSTATUS1_out  :  std_logic_vector(1 downto 0);
	signal   RXCOMMADET0_out  :  std_ulogic;
	signal   RXBYTEREALIGN0_out  :  std_ulogic;
	signal   RXBYTEISALIGNED0_out  :  std_ulogic;
	signal   RXLOSSOFSYNC0_out  :  std_logic_vector(1 downto 0);
	signal   RXCHBONDO0_out  :  std_logic_vector(3 downto 0);
	signal   RXCHANBONDSEQ0_out  :  std_ulogic;
	signal   RXCHANREALIGN0_out  :  std_ulogic;
	signal   RXCHANISALIGNED0_out  :  std_ulogic;
	signal   RXBUFSTATUS0_out  :  std_logic_vector(2 downto 0);
	signal   RXCOMMADET1_out  :  std_ulogic;
	signal   RXBYTEREALIGN1_out  :  std_ulogic;
	signal   RXBYTEISALIGNED1_out  :  std_ulogic;
	signal   RXLOSSOFSYNC1_out  :  std_logic_vector(1 downto 0);
	signal   RXCHBONDO1_out  :  std_logic_vector(3 downto 0);
	signal   RXCHANBONDSEQ1_out  :  std_ulogic;
	signal   RXCHANREALIGN1_out  :  std_ulogic;
	signal   RXCHANISALIGNED1_out  :  std_ulogic;
	signal   RXBUFSTATUS1_out  :  std_logic_vector(2 downto 0);
	signal   PHYSTATUS0_out  :  std_ulogic;
	signal   PHYSTATUS1_out  :  std_ulogic;
	signal   RXELECIDLE0_out  :  std_ulogic;
	signal   RXSTATUS0_out  :  std_logic_vector(2 downto 0);
	signal   RXCLKCORCNT0_out  :  std_logic_vector(2 downto 0);
	signal   RXELECIDLE1_out  :  std_ulogic;
	signal   RXSTATUS1_out  :  std_logic_vector(2 downto 0);
	signal   RXCLKCORCNT1_out  :  std_logic_vector(2 downto 0);
	signal   PLLLKDET_out  :  std_ulogic;
	signal   RXPRBSERR0_out  :  std_ulogic;
	signal   RXPRBSERR1_out  :  std_ulogic;
	signal   DO_out  :  std_logic_vector(15 downto 0);
	signal   DRDY_out  :  std_ulogic;
	signal   RXOVERSAMPLEERR0_out  :  std_ulogic;
	signal   RXOVERSAMPLEERR1_out  :  std_ulogic;
	signal   TXGEARBOXREADY0_out  :  std_ulogic;
	signal   RXHEADER0_out  :  std_logic_vector(2 downto 0);
	signal   RXHEADERVALID0_out  :  std_ulogic;
	signal   RXDATAVALID0_out  :  std_ulogic;
	signal   RXSTARTOFSEQ0_out  :  std_ulogic;
	signal   TXGEARBOXREADY1_out  :  std_ulogic;
	signal   RXHEADER1_out  :  std_logic_vector(2 downto 0);
	signal   RXHEADERVALID1_out  :  std_ulogic;
	signal   RXDATAVALID1_out  :  std_ulogic;
	signal   RXSTARTOFSEQ1_out  :  std_ulogic;
	signal   DFECLKDLYADJMONITOR0_out  :  std_logic_vector(5 downto 0);
	signal   DFEEYEDACMONITOR0_out  :  std_logic_vector(4 downto 0);
	signal   DFETAP1MONITOR0_out  :  std_logic_vector(4 downto 0);
	signal   DFETAP2MONITOR0_out  :  std_logic_vector(4 downto 0);
	signal   DFETAP3MONITOR0_out  :  std_logic_vector(3 downto 0);
	signal   DFETAP4MONITOR0_out  :  std_logic_vector(3 downto 0);
	signal   DFECLKDLYADJMONITOR1_out  :  std_logic_vector(5 downto 0);
	signal   DFEEYEDACMONITOR1_out  :  std_logic_vector(4 downto 0);
	signal   DFETAP1MONITOR1_out  :  std_logic_vector(4 downto 0);
	signal   DFETAP2MONITOR1_out  :  std_logic_vector(4 downto 0);
	signal   DFETAP3MONITOR1_out  :  std_logic_vector(3 downto 0);
	signal   DFETAP4MONITOR1_out  :  std_logic_vector(3 downto 0);
	signal   DFESENSCAL0_out  :  std_logic_vector(2 downto 0);
	signal   DFESENSCAL1_out  :  std_logic_vector(2 downto 0);

	signal   REFCLKOUT_outdelay  :  std_logic;
	signal   RXRECCLK0_outdelay  :  std_logic;
	signal   TXOUTCLK0_outdelay  :  std_logic;
	signal   RXRECCLK1_outdelay  :  std_logic;
	signal   TXOUTCLK1_outdelay  :  std_logic;
	signal   RXCLKCORCNT0_outdelay  :  std_logic_vector(2 downto 0);
	signal   RXCLKCORCNT1_outdelay  :  std_logic_vector(2 downto 0);
	signal   DFECLKDLYADJMONITOR0_outdelay  :  std_logic_vector(5 downto 0);
	signal   DFECLKDLYADJMONITOR1_outdelay  :  std_logic_vector(5 downto 0);

	signal   TXP0_outdelay  :  std_logic;
	signal   TXN0_outdelay  :  std_logic;
	signal   TXP1_outdelay  :  std_logic;
	signal   TXN1_outdelay  :  std_logic;
	signal   RXDATA0_outdelay  :  std_logic_vector(31 downto 0);
	signal   RXNOTINTABLE0_outdelay  :  std_logic_vector(3 downto 0);
	signal   RXDISPERR0_outdelay  :  std_logic_vector(3 downto 0);
	signal   RXCHARISK0_outdelay  :  std_logic_vector(3 downto 0);
	signal   RXRUNDISP0_outdelay  :  std_logic_vector(3 downto 0);
	signal   RXCHARISCOMMA0_outdelay  :  std_logic_vector(3 downto 0);
	signal   RXVALID0_outdelay  :  std_logic;
	signal   RXDATA1_outdelay  :  std_logic_vector(31 downto 0);
	signal   RXNOTINTABLE1_outdelay  :  std_logic_vector(3 downto 0);
	signal   RXDISPERR1_outdelay  :  std_logic_vector(3 downto 0);
	signal   RXCHARISK1_outdelay  :  std_logic_vector(3 downto 0);
	signal   RXRUNDISP1_outdelay  :  std_logic_vector(3 downto 0);
	signal   RXCHARISCOMMA1_outdelay  :  std_logic_vector(3 downto 0);
	signal   RXVALID1_outdelay  :  std_logic;
	signal   RESETDONE0_outdelay  :  std_logic;
	signal   RESETDONE1_outdelay  :  std_logic;
	signal   TXKERR0_outdelay  :  std_logic_vector(3 downto 0);
	signal   TXRUNDISP0_outdelay  :  std_logic_vector(3 downto 0);
	signal   TXBUFSTATUS0_outdelay  :  std_logic_vector(1 downto 0);
	signal   TXKERR1_outdelay  :  std_logic_vector(3 downto 0);
	signal   TXRUNDISP1_outdelay  :  std_logic_vector(3 downto 0);
	signal   TXBUFSTATUS1_outdelay  :  std_logic_vector(1 downto 0);
	signal   RXCOMMADET0_outdelay  :  std_logic;
	signal   RXBYTEREALIGN0_outdelay  :  std_logic;
	signal   RXBYTEISALIGNED0_outdelay  :  std_logic;
	signal   RXLOSSOFSYNC0_outdelay  :  std_logic_vector(1 downto 0);
	signal   RXCHBONDO0_outdelay  :  std_logic_vector(3 downto 0);
	signal   RXCHANBONDSEQ0_outdelay  :  std_logic;
	signal   RXCHANREALIGN0_outdelay  :  std_logic;
	signal   RXCHANISALIGNED0_outdelay  :  std_logic;
	signal   RXBUFSTATUS0_outdelay  :  std_logic_vector(2 downto 0);
	signal   RXCOMMADET1_outdelay  :  std_logic;
	signal   RXBYTEREALIGN1_outdelay  :  std_logic;
	signal   RXBYTEISALIGNED1_outdelay  :  std_logic;
	signal   RXLOSSOFSYNC1_outdelay  :  std_logic_vector(1 downto 0);
	signal   RXCHBONDO1_outdelay  :  std_logic_vector(3 downto 0);
	signal   RXCHANBONDSEQ1_outdelay  :  std_logic;
	signal   RXCHANREALIGN1_outdelay  :  std_logic;
	signal   RXCHANISALIGNED1_outdelay  :  std_logic;
	signal   RXBUFSTATUS1_outdelay  :  std_logic_vector(2 downto 0);
	signal   PHYSTATUS0_outdelay  :  std_logic;
	signal   PHYSTATUS1_outdelay  :  std_logic;
	signal   RXELECIDLE0_outdelay  :  std_logic;
	signal   RXSTATUS0_outdelay  :  std_logic_vector(2 downto 0);
	signal   RXELECIDLE1_outdelay  :  std_logic;
	signal   RXSTATUS1_outdelay  :  std_logic_vector(2 downto 0);
	signal   PLLLKDET_outdelay  :  std_logic;
	signal   RXPRBSERR0_outdelay  :  std_logic;
	signal   RXPRBSERR1_outdelay  :  std_logic;
	signal   DO_outdelay  :  std_logic_vector(15 downto 0);
	signal   DRDY_outdelay  :  std_logic;
	signal   RXOVERSAMPLEERR0_outdelay  :  std_logic;
	signal   RXOVERSAMPLEERR1_outdelay  :  std_logic;
	signal   TXGEARBOXREADY0_outdelay  :  std_logic;
	signal   RXHEADER0_outdelay  :  std_logic_vector(2 downto 0);
	signal   RXHEADERVALID0_outdelay  :  std_logic;
	signal   RXDATAVALID0_outdelay  :  std_logic;
	signal   RXSTARTOFSEQ0_outdelay  :  std_logic;
	signal   TXGEARBOXREADY1_outdelay  :  std_logic;
	signal   RXHEADER1_outdelay  :  std_logic_vector(2 downto 0);
	signal   RXHEADERVALID1_outdelay  :  std_logic;
	signal   RXDATAVALID1_outdelay  :  std_logic;
	signal   RXSTARTOFSEQ1_outdelay  :  std_logic;
	signal   DFEEYEDACMONITOR0_outdelay  :  std_logic_vector(4 downto 0);
	signal   DFETAP1MONITOR0_outdelay  :  std_logic_vector(4 downto 0);
	signal   DFETAP2MONITOR0_outdelay  :  std_logic_vector(4 downto 0);
	signal   DFETAP3MONITOR0_outdelay  :  std_logic_vector(3 downto 0);
	signal   DFETAP4MONITOR0_outdelay  :  std_logic_vector(3 downto 0);
	signal   DFEEYEDACMONITOR1_outdelay  :  std_logic_vector(4 downto 0);
	signal   DFETAP1MONITOR1_outdelay  :  std_logic_vector(4 downto 0);
	signal   DFETAP2MONITOR1_outdelay  :  std_logic_vector(4 downto 0);
	signal   DFETAP3MONITOR1_outdelay  :  std_logic_vector(3 downto 0);
	signal   DFETAP4MONITOR1_outdelay  :  std_logic_vector(3 downto 0);
	signal   DFESENSCAL0_outdelay  :  std_logic_vector(2 downto 0);
	signal   DFESENSCAL1_outdelay  :  std_logic_vector(2 downto 0);

	signal   CLKIN_ipd  :  std_ulogic;
	signal   TXUSRCLK0_ipd  :  std_ulogic;
	signal   TXUSRCLK20_ipd  :  std_ulogic;
	signal   RXUSRCLK0_ipd  :  std_ulogic;
	signal   RXUSRCLK20_ipd  :  std_ulogic;
	signal   TXUSRCLK1_ipd  :  std_ulogic;
	signal   TXUSRCLK21_ipd  :  std_ulogic;
	signal   RXUSRCLK1_ipd  :  std_ulogic;
	signal   RXUSRCLK21_ipd  :  std_ulogic;
	signal   RXP0_ipd  :  std_ulogic;
	signal   RXN0_ipd  :  std_ulogic;
	signal   TXDATA0_ipd  :  std_logic_vector(31 downto 0);
	signal   TXBYPASS8B10B0_ipd  :  std_logic_vector(3 downto 0);
	signal   TXCHARISK0_ipd  :  std_logic_vector(3 downto 0);
	signal   TXCHARDISPMODE0_ipd  :  std_logic_vector(3 downto 0);
	signal   TXCHARDISPVAL0_ipd  :  std_logic_vector(3 downto 0);
	signal   RXP1_ipd  :  std_ulogic;
	signal   RXN1_ipd  :  std_ulogic;
	signal   TXDATA1_ipd  :  std_logic_vector(31 downto 0);
	signal   TXBYPASS8B10B1_ipd  :  std_logic_vector(3 downto 0);
	signal   TXCHARISK1_ipd  :  std_logic_vector(3 downto 0);
	signal   TXCHARDISPMODE1_ipd  :  std_logic_vector(3 downto 0);
	signal   TXCHARDISPVAL1_ipd  :  std_logic_vector(3 downto 0);
	signal   GTXRESET_ipd  :  std_ulogic;
	signal   RXCDRRESET0_ipd  :  std_ulogic;
	signal   TXRESET0_ipd  :  std_ulogic;
	signal   RXRESET0_ipd  :  std_ulogic;
	signal   RXBUFRESET0_ipd  :  std_ulogic;
	signal   RXCDRRESET1_ipd  :  std_ulogic;
	signal   TXRESET1_ipd  :  std_ulogic;
	signal   RXRESET1_ipd  :  std_ulogic;
	signal   RXBUFRESET1_ipd  :  std_ulogic;
	signal   TXPOWERDOWN0_ipd  :  std_logic_vector(1 downto 0);
	signal   RXPOWERDOWN0_ipd  :  std_logic_vector(1 downto 0);
	signal   TXPOWERDOWN1_ipd  :  std_logic_vector(1 downto 0);
	signal   RXPOWERDOWN1_ipd  :  std_logic_vector(1 downto 0);
	signal   PLLPOWERDOWN_ipd  :  std_ulogic;
	signal   REFCLKPWRDNB_ipd  :  std_ulogic;
	signal   LOOPBACK0_ipd  :  std_logic_vector(2 downto 0);
	signal   LOOPBACK1_ipd  :  std_logic_vector(2 downto 0);
	signal   TXDIFFCTRL0_ipd  :  std_logic_vector(2 downto 0);
	signal   TXBUFDIFFCTRL0_ipd  :  std_logic_vector(2 downto 0);
	signal   TXPREEMPHASIS0_ipd  :  std_logic_vector(3 downto 0);
	signal   TXDIFFCTRL1_ipd  :  std_logic_vector(2 downto 0);
	signal   TXBUFDIFFCTRL1_ipd  :  std_logic_vector(2 downto 0);
	signal   TXPREEMPHASIS1_ipd  :  std_logic_vector(3 downto 0);
	signal   RXENEQB0_ipd  :  std_ulogic;
	signal   RXEQMIX0_ipd  :  std_logic_vector(1 downto 0);
	signal   RXEQPOLE0_ipd  :  std_logic_vector(3 downto 0);
	signal   RXENEQB1_ipd  :  std_ulogic;
	signal   RXEQMIX1_ipd  :  std_logic_vector(1 downto 0);
	signal   RXEQPOLE1_ipd  :  std_logic_vector(3 downto 0);
	signal   INTDATAWIDTH_ipd  :  std_ulogic;
	signal   TXDATAWIDTH0_ipd  :  std_logic_vector(1 downto 0);
	signal   TXDATAWIDTH1_ipd  :  std_logic_vector(1 downto 0);
	signal   TXENPMAPHASEALIGN0_ipd  :  std_ulogic;
	signal   TXPMASETPHASE0_ipd  :  std_ulogic;
	signal   RXENPMAPHASEALIGN0_ipd  :  std_ulogic;
	signal   RXPMASETPHASE0_ipd  :  std_ulogic;
	signal   TXENPMAPHASEALIGN1_ipd  :  std_ulogic;
	signal   TXPMASETPHASE1_ipd  :  std_ulogic;
	signal   RXENPMAPHASEALIGN1_ipd  :  std_ulogic;
	signal   RXPMASETPHASE1_ipd  :  std_ulogic;
	signal   TXENC8B10BUSE0_ipd  :  std_ulogic;
	signal   TXPOLARITY0_ipd  :  std_ulogic;
	signal   TXINHIBIT0_ipd  :  std_ulogic;
	signal   TXENC8B10BUSE1_ipd  :  std_ulogic;
	signal   TXPOLARITY1_ipd  :  std_ulogic;
	signal   TXINHIBIT1_ipd  :  std_ulogic;
	signal   RXPOLARITY0_ipd  :  std_ulogic;
	signal   RXENPCOMMAALIGN0_ipd  :  std_ulogic;
	signal   RXENMCOMMAALIGN0_ipd  :  std_ulogic;
	signal   RXSLIDE0_ipd  :  std_ulogic;
	signal   RXCOMMADETUSE0_ipd  :  std_ulogic;
	signal   RXDEC8B10BUSE0_ipd  :  std_ulogic;
	signal   RXENCHANSYNC0_ipd  :  std_ulogic;
	signal   RXCHBONDI0_ipd  :  std_logic_vector(3 downto 0);
	signal   RXDATAWIDTH0_ipd  :  std_logic_vector(1 downto 0);
	signal   RXPOLARITY1_ipd  :  std_ulogic;
	signal   RXENPCOMMAALIGN1_ipd  :  std_ulogic;
	signal   RXENMCOMMAALIGN1_ipd  :  std_ulogic;
	signal   RXSLIDE1_ipd  :  std_ulogic;
	signal   RXCOMMADETUSE1_ipd  :  std_ulogic;
	signal   RXDEC8B10BUSE1_ipd  :  std_ulogic;
	signal   RXENCHANSYNC1_ipd  :  std_ulogic;
	signal   RXCHBONDI1_ipd  :  std_logic_vector(3 downto 0);
	signal   RXDATAWIDTH1_ipd  :  std_logic_vector(1 downto 0);
	signal   TXELECIDLE0_ipd  :  std_ulogic;
	signal   TXDETECTRX0_ipd  :  std_ulogic;
	signal   TXELECIDLE1_ipd  :  std_ulogic;
	signal   TXDETECTRX1_ipd  :  std_ulogic;
	signal   TXCOMSTART0_ipd  :  std_ulogic;
	signal   TXCOMTYPE0_ipd  :  std_ulogic;
	signal   TXCOMSTART1_ipd  :  std_ulogic;
	signal   TXCOMTYPE1_ipd  :  std_ulogic;
	signal   PLLLKDETEN_ipd  :  std_ulogic;
	signal   TXENPRBSTST0_ipd  :  std_logic_vector(1 downto 0);
	signal   RXENPRBSTST0_ipd  :  std_logic_vector(1 downto 0);
	signal   PRBSCNTRESET0_ipd  :  std_ulogic;
	signal   TXENPRBSTST1_ipd  :  std_logic_vector(1 downto 0);
	signal   RXENPRBSTST1_ipd  :  std_logic_vector(1 downto 0);
	signal   PRBSCNTRESET1_ipd  :  std_ulogic;
	signal   DCLK_ipd  :  std_ulogic;
	signal   DADDR_ipd  :  std_logic_vector(6 downto 0);
	signal   DI_ipd  :  std_logic_vector(15 downto 0);
	signal   DEN_ipd  :  std_ulogic;
	signal   DWE_ipd  :  std_ulogic;
	signal   RXENSAMPLEALIGN0_ipd  :  std_ulogic;
	signal   RXENSAMPLEALIGN1_ipd  :  std_ulogic;
	signal   GTXTEST_ipd  :  std_logic_vector(13 downto 0);
	signal   TXHEADER0_ipd  :  std_logic_vector(2 downto 0);
	signal   TXSEQUENCE0_ipd  :  std_logic_vector(6 downto 0);
	signal   TXSTARTSEQ0_ipd  :  std_ulogic;
	signal   RXGEARBOXSLIP0_ipd  :  std_ulogic;
	signal   TXHEADER1_ipd  :  std_logic_vector(2 downto 0);
	signal   TXSEQUENCE1_ipd  :  std_logic_vector(6 downto 0);
	signal   TXSTARTSEQ1_ipd  :  std_ulogic;
	signal   RXGEARBOXSLIP1_ipd  :  std_ulogic;
	signal   DFECLKDLYADJ0_ipd  :  std_logic_vector(5 downto 0);
	signal   DFETAP10_ipd  :  std_logic_vector(4 downto 0);
	signal   DFETAP20_ipd  :  std_logic_vector(4 downto 0);
	signal   DFETAP30_ipd  :  std_logic_vector(3 downto 0);
	signal   DFETAP40_ipd  :  std_logic_vector(3 downto 0);
	signal   DFECLKDLYADJ1_ipd  :  std_logic_vector(5 downto 0);
	signal   DFETAP11_ipd  :  std_logic_vector(4 downto 0);
	signal   DFETAP21_ipd  :  std_logic_vector(4 downto 0);
	signal   DFETAP31_ipd  :  std_logic_vector(3 downto 0);
	signal   DFETAP41_ipd  :  std_logic_vector(3 downto 0);

	signal   CLKIN_dly  :  std_ulogic;
	signal   TXUSRCLK0_dly  :  std_ulogic;
	signal   TXUSRCLK20_dly  :  std_ulogic;
	signal   RXUSRCLK0_dly  :  std_ulogic;
	signal   RXUSRCLK20_dly  :  std_ulogic;
	signal   TXUSRCLK1_dly  :  std_ulogic;
	signal   TXUSRCLK21_dly  :  std_ulogic;
	signal   RXUSRCLK1_dly  :  std_ulogic;
	signal   RXUSRCLK21_dly  :  std_ulogic;
	signal   RXP0_dly  :  std_ulogic;
	signal   RXN0_dly  :  std_ulogic;
	signal   TXDATA0_dly  :  std_logic_vector(31 downto 0);
	signal   TXBYPASS8B10B0_dly  :  std_logic_vector(3 downto 0);
	signal   TXCHARISK0_dly  :  std_logic_vector(3 downto 0);
	signal   TXCHARDISPMODE0_dly  :  std_logic_vector(3 downto 0);
	signal   TXCHARDISPVAL0_dly  :  std_logic_vector(3 downto 0);
	signal   RXP1_dly  :  std_ulogic;
	signal   RXN1_dly  :  std_ulogic;
	signal   TXDATA1_dly  :  std_logic_vector(31 downto 0);
	signal   TXBYPASS8B10B1_dly  :  std_logic_vector(3 downto 0);
	signal   TXCHARISK1_dly  :  std_logic_vector(3 downto 0);
	signal   TXCHARDISPMODE1_dly  :  std_logic_vector(3 downto 0);
	signal   TXCHARDISPVAL1_dly  :  std_logic_vector(3 downto 0);
	signal   GTXRESET_dly  :  std_ulogic;
	signal   RXCDRRESET0_dly  :  std_ulogic;
	signal   TXRESET0_dly  :  std_ulogic;
	signal   RXRESET0_dly  :  std_ulogic;
	signal   RXBUFRESET0_dly  :  std_ulogic;
	signal   RXCDRRESET1_dly  :  std_ulogic;
	signal   TXRESET1_dly  :  std_ulogic;
	signal   RXRESET1_dly  :  std_ulogic;
	signal   RXBUFRESET1_dly  :  std_ulogic;
	signal   TXPOWERDOWN0_dly  :  std_logic_vector(1 downto 0);
	signal   RXPOWERDOWN0_dly  :  std_logic_vector(1 downto 0);
	signal   TXPOWERDOWN1_dly  :  std_logic_vector(1 downto 0);
	signal   RXPOWERDOWN1_dly  :  std_logic_vector(1 downto 0);
	signal   PLLPOWERDOWN_dly  :  std_ulogic;
	signal   REFCLKPWRDNB_dly  :  std_ulogic;
	signal   LOOPBACK0_dly  :  std_logic_vector(2 downto 0);
	signal   LOOPBACK1_dly  :  std_logic_vector(2 downto 0);
	signal   TXDIFFCTRL0_dly  :  std_logic_vector(2 downto 0);
	signal   TXBUFDIFFCTRL0_dly  :  std_logic_vector(2 downto 0);
	signal   TXPREEMPHASIS0_dly  :  std_logic_vector(3 downto 0);
	signal   TXDIFFCTRL1_dly  :  std_logic_vector(2 downto 0);
	signal   TXBUFDIFFCTRL1_dly  :  std_logic_vector(2 downto 0);
	signal   TXPREEMPHASIS1_dly  :  std_logic_vector(3 downto 0);
	signal   RXENEQB0_dly  :  std_ulogic;
	signal   RXEQMIX0_dly  :  std_logic_vector(1 downto 0);
	signal   RXEQPOLE0_dly  :  std_logic_vector(3 downto 0);
	signal   RXENEQB1_dly  :  std_ulogic;
	signal   RXEQMIX1_dly  :  std_logic_vector(1 downto 0);
	signal   RXEQPOLE1_dly  :  std_logic_vector(3 downto 0);
	signal   INTDATAWIDTH_dly  :  std_ulogic;
	signal   TXDATAWIDTH0_dly  :  std_logic_vector(1 downto 0);
	signal   TXDATAWIDTH1_dly  :  std_logic_vector(1 downto 0);
	signal   TXENPMAPHASEALIGN0_dly  :  std_ulogic;
	signal   TXPMASETPHASE0_dly  :  std_ulogic;
	signal   RXENPMAPHASEALIGN0_dly  :  std_ulogic;
	signal   RXPMASETPHASE0_dly  :  std_ulogic;
	signal   TXENPMAPHASEALIGN1_dly  :  std_ulogic;
	signal   TXPMASETPHASE1_dly  :  std_ulogic;
	signal   RXENPMAPHASEALIGN1_dly  :  std_ulogic;
	signal   RXPMASETPHASE1_dly  :  std_ulogic;
	signal   TXENC8B10BUSE0_dly  :  std_ulogic;
	signal   TXPOLARITY0_dly  :  std_ulogic;
	signal   TXINHIBIT0_dly  :  std_ulogic;
	signal   TXENC8B10BUSE1_dly  :  std_ulogic;
	signal   TXPOLARITY1_dly  :  std_ulogic;
	signal   TXINHIBIT1_dly  :  std_ulogic;
	signal   RXPOLARITY0_dly  :  std_ulogic;
	signal   RXENPCOMMAALIGN0_dly  :  std_ulogic;
	signal   RXENMCOMMAALIGN0_dly  :  std_ulogic;
	signal   RXSLIDE0_dly  :  std_ulogic;
	signal   RXCOMMADETUSE0_dly  :  std_ulogic;
	signal   RXDEC8B10BUSE0_dly  :  std_ulogic;
	signal   RXENCHANSYNC0_dly  :  std_ulogic;
	signal   RXCHBONDI0_dly  :  std_logic_vector(3 downto 0);
	signal   RXDATAWIDTH0_dly  :  std_logic_vector(1 downto 0);
	signal   RXPOLARITY1_dly  :  std_ulogic;
	signal   RXENPCOMMAALIGN1_dly  :  std_ulogic;
	signal   RXENMCOMMAALIGN1_dly  :  std_ulogic;
	signal   RXSLIDE1_dly  :  std_ulogic;
	signal   RXCOMMADETUSE1_dly  :  std_ulogic;
	signal   RXDEC8B10BUSE1_dly  :  std_ulogic;
	signal   RXENCHANSYNC1_dly  :  std_ulogic;
	signal   RXCHBONDI1_dly  :  std_logic_vector(3 downto 0);
	signal   RXDATAWIDTH1_dly  :  std_logic_vector(1 downto 0);
	signal   TXELECIDLE0_dly  :  std_ulogic;
	signal   TXDETECTRX0_dly  :  std_ulogic;
	signal   TXELECIDLE1_dly  :  std_ulogic;
	signal   TXDETECTRX1_dly  :  std_ulogic;
	signal   TXCOMSTART0_dly  :  std_ulogic;
	signal   TXCOMTYPE0_dly  :  std_ulogic;
	signal   TXCOMSTART1_dly  :  std_ulogic;
	signal   TXCOMTYPE1_dly  :  std_ulogic;
	signal   PLLLKDETEN_dly  :  std_ulogic;
	signal   TXENPRBSTST0_dly  :  std_logic_vector(1 downto 0);
	signal   RXENPRBSTST0_dly  :  std_logic_vector(1 downto 0);
	signal   PRBSCNTRESET0_dly  :  std_ulogic;
	signal   TXENPRBSTST1_dly  :  std_logic_vector(1 downto 0);
	signal   RXENPRBSTST1_dly  :  std_logic_vector(1 downto 0);
	signal   PRBSCNTRESET1_dly  :  std_ulogic;
	signal   DCLK_dly  :  std_ulogic;
	signal   DADDR_dly  :  std_logic_vector(6 downto 0);
	signal   DI_dly  :  std_logic_vector(15 downto 0);
	signal   DEN_dly  :  std_ulogic;
	signal   DWE_dly  :  std_ulogic;
	signal   RXENSAMPLEALIGN0_dly  :  std_ulogic;
	signal   RXENSAMPLEALIGN1_dly  :  std_ulogic;
	signal   GTXTEST_dly  :  std_logic_vector(13 downto 0);
	signal   TXHEADER0_dly  :  std_logic_vector(2 downto 0);
	signal   TXSEQUENCE0_dly  :  std_logic_vector(6 downto 0);
	signal   TXSTARTSEQ0_dly  :  std_ulogic;
	signal   RXGEARBOXSLIP0_dly  :  std_ulogic;
	signal   TXHEADER1_dly  :  std_logic_vector(2 downto 0);
	signal   TXSEQUENCE1_dly  :  std_logic_vector(6 downto 0);
	signal   TXSTARTSEQ1_dly  :  std_ulogic;
	signal   RXGEARBOXSLIP1_dly  :  std_ulogic;
	signal   DFECLKDLYADJ0_dly  :  std_logic_vector(5 downto 0);
	signal   DFETAP10_dly  :  std_logic_vector(4 downto 0);
	signal   DFETAP20_dly  :  std_logic_vector(4 downto 0);
	signal   DFETAP30_dly  :  std_logic_vector(3 downto 0);
	signal   DFETAP40_dly  :  std_logic_vector(3 downto 0);
	signal   DFECLKDLYADJ1_dly  :  std_logic_vector(5 downto 0);
	signal   DFETAP11_dly  :  std_logic_vector(4 downto 0);
	signal   DFETAP21_dly  :  std_logic_vector(4 downto 0);
	signal   DFETAP31_dly  :  std_logic_vector(3 downto 0);
	signal   DFETAP41_dly  :  std_logic_vector(3 downto 0);

	signal   CLKIN_indelay  :  std_ulogic;
	signal   TXUSRCLK0_indelay  :  std_ulogic;
	signal   TXUSRCLK20_indelay  :  std_ulogic;
	signal   RXUSRCLK0_indelay  :  std_ulogic;
	signal   RXUSRCLK20_indelay  :  std_ulogic;
	signal   TXUSRCLK1_indelay  :  std_ulogic;
	signal   TXUSRCLK21_indelay  :  std_ulogic;
	signal   RXUSRCLK1_indelay  :  std_ulogic;
	signal   RXUSRCLK21_indelay  :  std_ulogic;
	signal   RXP0_indelay  :  std_ulogic;
	signal   RXN0_indelay  :  std_ulogic;
	signal   TXDATA0_indelay  :  std_logic_vector(31 downto 0);
	signal   TXBYPASS8B10B0_indelay  :  std_logic_vector(3 downto 0);
	signal   TXCHARISK0_indelay  :  std_logic_vector(3 downto 0);
	signal   TXCHARDISPMODE0_indelay  :  std_logic_vector(3 downto 0);
	signal   TXCHARDISPVAL0_indelay  :  std_logic_vector(3 downto 0);
	signal   RXP1_indelay  :  std_ulogic;
	signal   RXN1_indelay  :  std_ulogic;
	signal   TXDATA1_indelay  :  std_logic_vector(31 downto 0);
	signal   TXBYPASS8B10B1_indelay  :  std_logic_vector(3 downto 0);
	signal   TXCHARISK1_indelay  :  std_logic_vector(3 downto 0);
	signal   TXCHARDISPMODE1_indelay  :  std_logic_vector(3 downto 0);
	signal   TXCHARDISPVAL1_indelay  :  std_logic_vector(3 downto 0);
	signal   GTXRESET_indelay  :  std_ulogic;
	signal   RXCDRRESET0_indelay  :  std_ulogic;
	signal   TXRESET0_indelay  :  std_ulogic;
	signal   RXRESET0_indelay  :  std_ulogic;
	signal   RXBUFRESET0_indelay  :  std_ulogic;
	signal   RXCDRRESET1_indelay  :  std_ulogic;
	signal   TXRESET1_indelay  :  std_ulogic;
	signal   RXRESET1_indelay  :  std_ulogic;
	signal   RXBUFRESET1_indelay  :  std_ulogic;
	signal   TXPOWERDOWN0_indelay  :  std_logic_vector(1 downto 0);
	signal   RXPOWERDOWN0_indelay  :  std_logic_vector(1 downto 0);
	signal   TXPOWERDOWN1_indelay  :  std_logic_vector(1 downto 0);
	signal   RXPOWERDOWN1_indelay  :  std_logic_vector(1 downto 0);
	signal   PLLPOWERDOWN_indelay  :  std_ulogic;
	signal   REFCLKPWRDNB_indelay  :  std_ulogic;
	signal   LOOPBACK0_indelay  :  std_logic_vector(2 downto 0);
	signal   LOOPBACK1_indelay  :  std_logic_vector(2 downto 0);
	signal   TXDIFFCTRL0_indelay  :  std_logic_vector(2 downto 0);
	signal   TXBUFDIFFCTRL0_indelay  :  std_logic_vector(2 downto 0);
	signal   TXPREEMPHASIS0_indelay  :  std_logic_vector(3 downto 0);
	signal   TXDIFFCTRL1_indelay  :  std_logic_vector(2 downto 0);
	signal   TXBUFDIFFCTRL1_indelay  :  std_logic_vector(2 downto 0);
	signal   TXPREEMPHASIS1_indelay  :  std_logic_vector(3 downto 0);
	signal   RXENEQB0_indelay  :  std_ulogic;
	signal   RXEQMIX0_indelay  :  std_logic_vector(1 downto 0);
	signal   RXEQPOLE0_indelay  :  std_logic_vector(3 downto 0);
	signal   RXENEQB1_indelay  :  std_ulogic;
	signal   RXEQMIX1_indelay  :  std_logic_vector(1 downto 0);
	signal   RXEQPOLE1_indelay  :  std_logic_vector(3 downto 0);
	signal   INTDATAWIDTH_indelay  :  std_ulogic;
	signal   TXDATAWIDTH0_indelay  :  std_logic_vector(1 downto 0);
	signal   TXDATAWIDTH1_indelay  :  std_logic_vector(1 downto 0);
	signal   TXENPMAPHASEALIGN0_indelay  :  std_ulogic;
	signal   TXPMASETPHASE0_indelay  :  std_ulogic;
	signal   RXENPMAPHASEALIGN0_indelay  :  std_ulogic;
	signal   RXPMASETPHASE0_indelay  :  std_ulogic;
	signal   TXENPMAPHASEALIGN1_indelay  :  std_ulogic;
	signal   TXPMASETPHASE1_indelay  :  std_ulogic;
	signal   RXENPMAPHASEALIGN1_indelay  :  std_ulogic;
	signal   RXPMASETPHASE1_indelay  :  std_ulogic;
	signal   TXENC8B10BUSE0_indelay  :  std_ulogic;
	signal   TXPOLARITY0_indelay  :  std_ulogic;
	signal   TXINHIBIT0_indelay  :  std_ulogic;
	signal   TXENC8B10BUSE1_indelay  :  std_ulogic;
	signal   TXPOLARITY1_indelay  :  std_ulogic;
	signal   TXINHIBIT1_indelay  :  std_ulogic;
	signal   RXPOLARITY0_indelay  :  std_ulogic;
	signal   RXENPCOMMAALIGN0_indelay  :  std_ulogic;
	signal   RXENMCOMMAALIGN0_indelay  :  std_ulogic;
	signal   RXSLIDE0_indelay  :  std_ulogic;
	signal   RXCOMMADETUSE0_indelay  :  std_ulogic;
	signal   RXDEC8B10BUSE0_indelay  :  std_ulogic;
	signal   RXENCHANSYNC0_indelay  :  std_ulogic;
	signal   RXCHBONDI0_indelay  :  std_logic_vector(3 downto 0);
	signal   RXDATAWIDTH0_indelay  :  std_logic_vector(1 downto 0);
	signal   RXPOLARITY1_indelay  :  std_ulogic;
	signal   RXENPCOMMAALIGN1_indelay  :  std_ulogic;
	signal   RXENMCOMMAALIGN1_indelay  :  std_ulogic;
	signal   RXSLIDE1_indelay  :  std_ulogic;
	signal   RXCOMMADETUSE1_indelay  :  std_ulogic;
	signal   RXDEC8B10BUSE1_indelay  :  std_ulogic;
	signal   RXENCHANSYNC1_indelay  :  std_ulogic;
	signal   RXCHBONDI1_indelay  :  std_logic_vector(3 downto 0);
	signal   RXDATAWIDTH1_indelay  :  std_logic_vector(1 downto 0);
	signal   TXELECIDLE0_indelay  :  std_ulogic;
	signal   TXDETECTRX0_indelay  :  std_ulogic;
	signal   TXELECIDLE1_indelay  :  std_ulogic;
	signal   TXDETECTRX1_indelay  :  std_ulogic;
	signal   TXCOMSTART0_indelay  :  std_ulogic;
	signal   TXCOMTYPE0_indelay  :  std_ulogic;
	signal   TXCOMSTART1_indelay  :  std_ulogic;
	signal   TXCOMTYPE1_indelay  :  std_ulogic;
	signal   PLLLKDETEN_indelay  :  std_ulogic;
	signal   TXENPRBSTST0_indelay  :  std_logic_vector(1 downto 0);
	signal   RXENPRBSTST0_indelay  :  std_logic_vector(1 downto 0);
	signal   PRBSCNTRESET0_indelay  :  std_ulogic;
	signal   TXENPRBSTST1_indelay  :  std_logic_vector(1 downto 0);
	signal   RXENPRBSTST1_indelay  :  std_logic_vector(1 downto 0);
	signal   PRBSCNTRESET1_indelay  :  std_ulogic;
	signal   DCLK_indelay  :  std_ulogic;
	signal   DADDR_indelay  :  std_logic_vector(6 downto 0);
	signal   DI_indelay  :  std_logic_vector(15 downto 0);
	signal   DEN_indelay  :  std_ulogic;
	signal   DWE_indelay  :  std_ulogic;
	signal   RXENSAMPLEALIGN0_indelay  :  std_ulogic;
	signal   RXENSAMPLEALIGN1_indelay  :  std_ulogic;
	signal   GTXTEST_indelay  :  std_logic_vector(13 downto 0);
	signal   TXHEADER0_indelay  :  std_logic_vector(2 downto 0);
	signal   TXSEQUENCE0_indelay  :  std_logic_vector(6 downto 0);
	signal   TXSTARTSEQ0_indelay  :  std_ulogic;
	signal   RXGEARBOXSLIP0_indelay  :  std_ulogic;
	signal   TXHEADER1_indelay  :  std_logic_vector(2 downto 0);
	signal   TXSEQUENCE1_indelay  :  std_logic_vector(6 downto 0);
	signal   TXSTARTSEQ1_indelay  :  std_ulogic;
	signal   RXGEARBOXSLIP1_indelay  :  std_ulogic;
	signal   DFECLKDLYADJ0_indelay  :  std_logic_vector(5 downto 0);
	signal   DFETAP10_indelay  :  std_logic_vector(4 downto 0);
	signal   DFETAP20_indelay  :  std_logic_vector(4 downto 0);
	signal   DFETAP30_indelay  :  std_logic_vector(3 downto 0);
	signal   DFETAP40_indelay  :  std_logic_vector(3 downto 0);
	signal   DFECLKDLYADJ1_indelay  :  std_logic_vector(5 downto 0);
	signal   DFETAP11_indelay  :  std_logic_vector(4 downto 0);
	signal   DFETAP21_indelay  :  std_logic_vector(4 downto 0);
	signal   DFETAP31_indelay  :  std_logic_vector(3 downto 0);
	signal   DFETAP41_indelay  :  std_logic_vector(3 downto 0);

-- <!--Aldec correction start
	signal GSR_local : std_ulogic;
-- Aldec correction end -->

begin
	WireDelay : block
	begin
              VitalWireDelay (CLKIN_ipd,CLKIN,tipd_CLKIN);
              VitalWireDelay (TXUSRCLK0_ipd,TXUSRCLK0,tipd_TXUSRCLK0);
              VitalWireDelay (TXUSRCLK20_ipd,TXUSRCLK20,tipd_TXUSRCLK20);
              VitalWireDelay (RXUSRCLK0_ipd,RXUSRCLK0,tipd_RXUSRCLK0);
              VitalWireDelay (RXUSRCLK20_ipd,RXUSRCLK20,tipd_RXUSRCLK20);
              VitalWireDelay (TXUSRCLK1_ipd,TXUSRCLK1,tipd_TXUSRCLK1);
              VitalWireDelay (TXUSRCLK21_ipd,TXUSRCLK21,tipd_TXUSRCLK21);
              VitalWireDelay (RXUSRCLK1_ipd,RXUSRCLK1,tipd_RXUSRCLK1);
              VitalWireDelay (RXUSRCLK21_ipd,RXUSRCLK21,tipd_RXUSRCLK21);
              VitalWireDelay (RXP0_ipd,RXP0,tipd_RXP0);
              VitalWireDelay (RXN0_ipd,RXN0,tipd_RXN0);
           TXDATA0_DELAY : for i in 31 downto 0 generate
              VitalWireDelay (TXDATA0_ipd(i),TXDATA0(i),tipd_TXDATA0(i));
           end generate TXDATA0_DELAY;
           TXBYPASS8B10B0_DELAY : for i in 3 downto 0 generate
              VitalWireDelay (TXBYPASS8B10B0_ipd(i),TXBYPASS8B10B0(i),tipd_TXBYPASS8B10B0(i));
           end generate TXBYPASS8B10B0_DELAY;
           TXCHARISK0_DELAY : for i in 3 downto 0 generate
              VitalWireDelay (TXCHARISK0_ipd(i),TXCHARISK0(i),tipd_TXCHARISK0(i));
           end generate TXCHARISK0_DELAY;
           TXCHARDISPMODE0_DELAY : for i in 3 downto 0 generate
              VitalWireDelay (TXCHARDISPMODE0_ipd(i),TXCHARDISPMODE0(i),tipd_TXCHARDISPMODE0(i));
           end generate TXCHARDISPMODE0_DELAY;
           TXCHARDISPVAL0_DELAY : for i in 3 downto 0 generate
              VitalWireDelay (TXCHARDISPVAL0_ipd(i),TXCHARDISPVAL0(i),tipd_TXCHARDISPVAL0(i));
           end generate TXCHARDISPVAL0_DELAY;
              VitalWireDelay (RXP1_ipd,RXP1,tipd_RXP1);
              VitalWireDelay (RXN1_ipd,RXN1,tipd_RXN1);
           TXDATA1_DELAY : for i in 31 downto 0 generate
              VitalWireDelay (TXDATA1_ipd(i),TXDATA1(i),tipd_TXDATA1(i));
           end generate TXDATA1_DELAY;
           TXBYPASS8B10B1_DELAY : for i in 3 downto 0 generate
              VitalWireDelay (TXBYPASS8B10B1_ipd(i),TXBYPASS8B10B1(i),tipd_TXBYPASS8B10B1(i));
           end generate TXBYPASS8B10B1_DELAY;
           TXCHARISK1_DELAY : for i in 3 downto 0 generate
              VitalWireDelay (TXCHARISK1_ipd(i),TXCHARISK1(i),tipd_TXCHARISK1(i));
           end generate TXCHARISK1_DELAY;
           TXCHARDISPMODE1_DELAY : for i in 3 downto 0 generate
              VitalWireDelay (TXCHARDISPMODE1_ipd(i),TXCHARDISPMODE1(i),tipd_TXCHARDISPMODE1(i));
           end generate TXCHARDISPMODE1_DELAY;
           TXCHARDISPVAL1_DELAY : for i in 3 downto 0 generate
              VitalWireDelay (TXCHARDISPVAL1_ipd(i),TXCHARDISPVAL1(i),tipd_TXCHARDISPVAL1(i));
           end generate TXCHARDISPVAL1_DELAY;
              VitalWireDelay (GTXRESET_ipd,GTXRESET,tipd_GTXRESET);
              VitalWireDelay (RXCDRRESET0_ipd,RXCDRRESET0,tipd_RXCDRRESET0);
              VitalWireDelay (TXRESET0_ipd,TXRESET0,tipd_TXRESET0);
              VitalWireDelay (RXRESET0_ipd,RXRESET0,tipd_RXRESET0);
              VitalWireDelay (RXBUFRESET0_ipd,RXBUFRESET0,tipd_RXBUFRESET0);
              VitalWireDelay (RXCDRRESET1_ipd,RXCDRRESET1,tipd_RXCDRRESET1);
              VitalWireDelay (TXRESET1_ipd,TXRESET1,tipd_TXRESET1);
              VitalWireDelay (RXRESET1_ipd,RXRESET1,tipd_RXRESET1);
              VitalWireDelay (RXBUFRESET1_ipd,RXBUFRESET1,tipd_RXBUFRESET1);
           TXPOWERDOWN0_DELAY : for i in 1 downto 0 generate
              VitalWireDelay (TXPOWERDOWN0_ipd(i),TXPOWERDOWN0(i),tipd_TXPOWERDOWN0(i));
           end generate TXPOWERDOWN0_DELAY;
           RXPOWERDOWN0_DELAY : for i in 1 downto 0 generate
              VitalWireDelay (RXPOWERDOWN0_ipd(i),RXPOWERDOWN0(i),tipd_RXPOWERDOWN0(i));
           end generate RXPOWERDOWN0_DELAY;
           TXPOWERDOWN1_DELAY : for i in 1 downto 0 generate
              VitalWireDelay (TXPOWERDOWN1_ipd(i),TXPOWERDOWN1(i),tipd_TXPOWERDOWN1(i));
           end generate TXPOWERDOWN1_DELAY;
           RXPOWERDOWN1_DELAY : for i in 1 downto 0 generate
              VitalWireDelay (RXPOWERDOWN1_ipd(i),RXPOWERDOWN1(i),tipd_RXPOWERDOWN1(i));
           end generate RXPOWERDOWN1_DELAY;
              VitalWireDelay (PLLPOWERDOWN_ipd,PLLPOWERDOWN,tipd_PLLPOWERDOWN);
              VitalWireDelay (REFCLKPWRDNB_ipd,REFCLKPWRDNB,tipd_REFCLKPWRDNB);
           LOOPBACK0_DELAY : for i in 2 downto 0 generate
              VitalWireDelay (LOOPBACK0_ipd(i),LOOPBACK0(i),tipd_LOOPBACK0(i));
           end generate LOOPBACK0_DELAY;
           LOOPBACK1_DELAY : for i in 2 downto 0 generate
              VitalWireDelay (LOOPBACK1_ipd(i),LOOPBACK1(i),tipd_LOOPBACK1(i));
           end generate LOOPBACK1_DELAY;
           TXDIFFCTRL0_DELAY : for i in 2 downto 0 generate
              VitalWireDelay (TXDIFFCTRL0_ipd(i),TXDIFFCTRL0(i),tipd_TXDIFFCTRL0(i));
           end generate TXDIFFCTRL0_DELAY;
           TXBUFDIFFCTRL0_DELAY : for i in 2 downto 0 generate
              VitalWireDelay (TXBUFDIFFCTRL0_ipd(i),TXBUFDIFFCTRL0(i),tipd_TXBUFDIFFCTRL0(i));
           end generate TXBUFDIFFCTRL0_DELAY;
           TXPREEMPHASIS0_DELAY : for i in 3 downto 0 generate
              VitalWireDelay (TXPREEMPHASIS0_ipd(i),TXPREEMPHASIS0(i),tipd_TXPREEMPHASIS0(i));
           end generate TXPREEMPHASIS0_DELAY;
           TXDIFFCTRL1_DELAY : for i in 2 downto 0 generate
              VitalWireDelay (TXDIFFCTRL1_ipd(i),TXDIFFCTRL1(i),tipd_TXDIFFCTRL1(i));
           end generate TXDIFFCTRL1_DELAY;
           TXBUFDIFFCTRL1_DELAY : for i in 2 downto 0 generate
              VitalWireDelay (TXBUFDIFFCTRL1_ipd(i),TXBUFDIFFCTRL1(i),tipd_TXBUFDIFFCTRL1(i));
           end generate TXBUFDIFFCTRL1_DELAY;
           TXPREEMPHASIS1_DELAY : for i in 3 downto 0 generate
              VitalWireDelay (TXPREEMPHASIS1_ipd(i),TXPREEMPHASIS1(i),tipd_TXPREEMPHASIS1(i));
           end generate TXPREEMPHASIS1_DELAY;
              VitalWireDelay (RXENEQB0_ipd,RXENEQB0,tipd_RXENEQB0);
           RXEQMIX0_DELAY : for i in 1 downto 0 generate
              VitalWireDelay (RXEQMIX0_ipd(i),RXEQMIX0(i),tipd_RXEQMIX0(i));
           end generate RXEQMIX0_DELAY;
           RXEQPOLE0_DELAY : for i in 3 downto 0 generate
              VitalWireDelay (RXEQPOLE0_ipd(i),RXEQPOLE0(i),tipd_RXEQPOLE0(i));
           end generate RXEQPOLE0_DELAY;
              VitalWireDelay (RXENEQB1_ipd,RXENEQB1,tipd_RXENEQB1);
           RXEQMIX1_DELAY : for i in 1 downto 0 generate
              VitalWireDelay (RXEQMIX1_ipd(i),RXEQMIX1(i),tipd_RXEQMIX1(i));
           end generate RXEQMIX1_DELAY;
           RXEQPOLE1_DELAY : for i in 3 downto 0 generate
              VitalWireDelay (RXEQPOLE1_ipd(i),RXEQPOLE1(i),tipd_RXEQPOLE1(i));
           end generate RXEQPOLE1_DELAY;
              VitalWireDelay (INTDATAWIDTH_ipd,INTDATAWIDTH,tipd_INTDATAWIDTH);
           TXDATAWIDTH0_DELAY : for i in 1 downto 0 generate
              VitalWireDelay (TXDATAWIDTH0_ipd(i),TXDATAWIDTH0(i),tipd_TXDATAWIDTH0(i));
           end generate TXDATAWIDTH0_DELAY;
           TXDATAWIDTH1_DELAY : for i in 1 downto 0 generate
              VitalWireDelay (TXDATAWIDTH1_ipd(i),TXDATAWIDTH1(i),tipd_TXDATAWIDTH1(i));
           end generate TXDATAWIDTH1_DELAY;
              VitalWireDelay (TXENPMAPHASEALIGN0_ipd,TXENPMAPHASEALIGN0,tipd_TXENPMAPHASEALIGN0);
              VitalWireDelay (TXPMASETPHASE0_ipd,TXPMASETPHASE0,tipd_TXPMASETPHASE0);
              VitalWireDelay (RXENPMAPHASEALIGN0_ipd,RXENPMAPHASEALIGN0,tipd_RXENPMAPHASEALIGN0);
              VitalWireDelay (RXPMASETPHASE0_ipd,RXPMASETPHASE0,tipd_RXPMASETPHASE0);
              VitalWireDelay (TXENPMAPHASEALIGN1_ipd,TXENPMAPHASEALIGN1,tipd_TXENPMAPHASEALIGN1);
              VitalWireDelay (TXPMASETPHASE1_ipd,TXPMASETPHASE1,tipd_TXPMASETPHASE1);
              VitalWireDelay (RXENPMAPHASEALIGN1_ipd,RXENPMAPHASEALIGN1,tipd_RXENPMAPHASEALIGN1);
              VitalWireDelay (RXPMASETPHASE1_ipd,RXPMASETPHASE1,tipd_RXPMASETPHASE1);
              VitalWireDelay (TXENC8B10BUSE0_ipd,TXENC8B10BUSE0,tipd_TXENC8B10BUSE0);
              VitalWireDelay (TXPOLARITY0_ipd,TXPOLARITY0,tipd_TXPOLARITY0);
              VitalWireDelay (TXINHIBIT0_ipd,TXINHIBIT0,tipd_TXINHIBIT0);
              VitalWireDelay (TXENC8B10BUSE1_ipd,TXENC8B10BUSE1,tipd_TXENC8B10BUSE1);
              VitalWireDelay (TXPOLARITY1_ipd,TXPOLARITY1,tipd_TXPOLARITY1);
              VitalWireDelay (TXINHIBIT1_ipd,TXINHIBIT1,tipd_TXINHIBIT1);
              VitalWireDelay (RXPOLARITY0_ipd,RXPOLARITY0,tipd_RXPOLARITY0);
              VitalWireDelay (RXENPCOMMAALIGN0_ipd,RXENPCOMMAALIGN0,tipd_RXENPCOMMAALIGN0);
              VitalWireDelay (RXENMCOMMAALIGN0_ipd,RXENMCOMMAALIGN0,tipd_RXENMCOMMAALIGN0);
              VitalWireDelay (RXSLIDE0_ipd,RXSLIDE0,tipd_RXSLIDE0);
              VitalWireDelay (RXCOMMADETUSE0_ipd,RXCOMMADETUSE0,tipd_RXCOMMADETUSE0);
              VitalWireDelay (RXDEC8B10BUSE0_ipd,RXDEC8B10BUSE0,tipd_RXDEC8B10BUSE0);
              VitalWireDelay (RXENCHANSYNC0_ipd,RXENCHANSYNC0,tipd_RXENCHANSYNC0);
           RXCHBONDI0_DELAY : for i in 3 downto 0 generate
              VitalWireDelay (RXCHBONDI0_ipd(i),RXCHBONDI0(i),tipd_RXCHBONDI0(i));
           end generate RXCHBONDI0_DELAY;
           RXDATAWIDTH0_DELAY : for i in 1 downto 0 generate
              VitalWireDelay (RXDATAWIDTH0_ipd(i),RXDATAWIDTH0(i),tipd_RXDATAWIDTH0(i));
           end generate RXDATAWIDTH0_DELAY;
              VitalWireDelay (RXPOLARITY1_ipd,RXPOLARITY1,tipd_RXPOLARITY1);
              VitalWireDelay (RXENPCOMMAALIGN1_ipd,RXENPCOMMAALIGN1,tipd_RXENPCOMMAALIGN1);
              VitalWireDelay (RXENMCOMMAALIGN1_ipd,RXENMCOMMAALIGN1,tipd_RXENMCOMMAALIGN1);
              VitalWireDelay (RXSLIDE1_ipd,RXSLIDE1,tipd_RXSLIDE1);
              VitalWireDelay (RXCOMMADETUSE1_ipd,RXCOMMADETUSE1,tipd_RXCOMMADETUSE1);
              VitalWireDelay (RXDEC8B10BUSE1_ipd,RXDEC8B10BUSE1,tipd_RXDEC8B10BUSE1);
              VitalWireDelay (RXENCHANSYNC1_ipd,RXENCHANSYNC1,tipd_RXENCHANSYNC1);
           RXCHBONDI1_DELAY : for i in 3 downto 0 generate
              VitalWireDelay (RXCHBONDI1_ipd(i),RXCHBONDI1(i),tipd_RXCHBONDI1(i));
           end generate RXCHBONDI1_DELAY;
           RXDATAWIDTH1_DELAY : for i in 1 downto 0 generate
              VitalWireDelay (RXDATAWIDTH1_ipd(i),RXDATAWIDTH1(i),tipd_RXDATAWIDTH1(i));
           end generate RXDATAWIDTH1_DELAY;
              VitalWireDelay (TXELECIDLE0_ipd,TXELECIDLE0,tipd_TXELECIDLE0);
              VitalWireDelay (TXDETECTRX0_ipd,TXDETECTRX0,tipd_TXDETECTRX0);
              VitalWireDelay (TXELECIDLE1_ipd,TXELECIDLE1,tipd_TXELECIDLE1);
              VitalWireDelay (TXDETECTRX1_ipd,TXDETECTRX1,tipd_TXDETECTRX1);
              VitalWireDelay (TXCOMSTART0_ipd,TXCOMSTART0,tipd_TXCOMSTART0);
              VitalWireDelay (TXCOMTYPE0_ipd,TXCOMTYPE0,tipd_TXCOMTYPE0);
              VitalWireDelay (TXCOMSTART1_ipd,TXCOMSTART1,tipd_TXCOMSTART1);
              VitalWireDelay (TXCOMTYPE1_ipd,TXCOMTYPE1,tipd_TXCOMTYPE1);
              VitalWireDelay (PLLLKDETEN_ipd,PLLLKDETEN,tipd_PLLLKDETEN);
           TXENPRBSTST0_DELAY : for i in 1 downto 0 generate
              VitalWireDelay (TXENPRBSTST0_ipd(i),TXENPRBSTST0(i),tipd_TXENPRBSTST0(i));
           end generate TXENPRBSTST0_DELAY;
           RXENPRBSTST0_DELAY : for i in 1 downto 0 generate
              VitalWireDelay (RXENPRBSTST0_ipd(i),RXENPRBSTST0(i),tipd_RXENPRBSTST0(i));
           end generate RXENPRBSTST0_DELAY;
              VitalWireDelay (PRBSCNTRESET0_ipd,PRBSCNTRESET0,tipd_PRBSCNTRESET0);
           TXENPRBSTST1_DELAY : for i in 1 downto 0 generate
              VitalWireDelay (TXENPRBSTST1_ipd(i),TXENPRBSTST1(i),tipd_TXENPRBSTST1(i));
           end generate TXENPRBSTST1_DELAY;
           RXENPRBSTST1_DELAY : for i in 1 downto 0 generate
              VitalWireDelay (RXENPRBSTST1_ipd(i),RXENPRBSTST1(i),tipd_RXENPRBSTST1(i));
           end generate RXENPRBSTST1_DELAY;
              VitalWireDelay (PRBSCNTRESET1_ipd,PRBSCNTRESET1,tipd_PRBSCNTRESET1);
              VitalWireDelay (DCLK_ipd,DCLK,tipd_DCLK);
           DADDR_DELAY : for i in 6 downto 0 generate
              VitalWireDelay (DADDR_ipd(i),DADDR(i),tipd_DADDR(i));
           end generate DADDR_DELAY;
           DI_DELAY : for i in 15 downto 0 generate
              VitalWireDelay (DI_ipd(i),DI(i),tipd_DI(i));
           end generate DI_DELAY;
              VitalWireDelay (DEN_ipd,DEN,tipd_DEN);
              VitalWireDelay (DWE_ipd,DWE,tipd_DWE);
              VitalWireDelay (RXENSAMPLEALIGN0_ipd,RXENSAMPLEALIGN0,tipd_RXENSAMPLEALIGN0);
              VitalWireDelay (RXENSAMPLEALIGN1_ipd,RXENSAMPLEALIGN1,tipd_RXENSAMPLEALIGN1);
           GTXTEST_DELAY : for i in 13 downto 0 generate
              VitalWireDelay (GTXTEST_ipd(i),GTXTEST(i),tipd_GTXTEST(i));
           end generate GTXTEST_DELAY;
           TXHEADER0_DELAY : for i in 2 downto 0 generate
              VitalWireDelay (TXHEADER0_ipd(i),TXHEADER0(i),tipd_TXHEADER0(i));
           end generate TXHEADER0_DELAY;
           TXSEQUENCE0_DELAY : for i in 6 downto 0 generate
              VitalWireDelay (TXSEQUENCE0_ipd(i),TXSEQUENCE0(i),tipd_TXSEQUENCE0(i));
           end generate TXSEQUENCE0_DELAY;
              VitalWireDelay (TXSTARTSEQ0_ipd,TXSTARTSEQ0,tipd_TXSTARTSEQ0);
              VitalWireDelay (RXGEARBOXSLIP0_ipd,RXGEARBOXSLIP0,tipd_RXGEARBOXSLIP0);
           TXHEADER1_DELAY : for i in 2 downto 0 generate
              VitalWireDelay (TXHEADER1_ipd(i),TXHEADER1(i),tipd_TXHEADER1(i));
           end generate TXHEADER1_DELAY;
           TXSEQUENCE1_DELAY : for i in 6 downto 0 generate
              VitalWireDelay (TXSEQUENCE1_ipd(i),TXSEQUENCE1(i),tipd_TXSEQUENCE1(i));
           end generate TXSEQUENCE1_DELAY;
              VitalWireDelay (TXSTARTSEQ1_ipd,TXSTARTSEQ1,tipd_TXSTARTSEQ1);
              VitalWireDelay (RXGEARBOXSLIP1_ipd,RXGEARBOXSLIP1,tipd_RXGEARBOXSLIP1);
           DFECLKDLYADJ0_DELAY : for i in 5 downto 0 generate
              VitalWireDelay (DFECLKDLYADJ0_ipd(i),DFECLKDLYADJ0(i),tipd_DFECLKDLYADJ0(i));
           end generate DFECLKDLYADJ0_DELAY;
           DFETAP10_DELAY : for i in 4 downto 0 generate
              VitalWireDelay (DFETAP10_ipd(i),DFETAP10(i),tipd_DFETAP10(i));
           end generate DFETAP10_DELAY;
           DFETAP20_DELAY : for i in 4 downto 0 generate
              VitalWireDelay (DFETAP20_ipd(i),DFETAP20(i),tipd_DFETAP20(i));
           end generate DFETAP20_DELAY;
           DFETAP30_DELAY : for i in 3 downto 0 generate
              VitalWireDelay (DFETAP30_ipd(i),DFETAP30(i),tipd_DFETAP30(i));
           end generate DFETAP30_DELAY;
           DFETAP40_DELAY : for i in 3 downto 0 generate
              VitalWireDelay (DFETAP40_ipd(i),DFETAP40(i),tipd_DFETAP40(i));
           end generate DFETAP40_DELAY;
           DFECLKDLYADJ1_DELAY : for i in 5 downto 0 generate
              VitalWireDelay (DFECLKDLYADJ1_ipd(i),DFECLKDLYADJ1(i),tipd_DFECLKDLYADJ1(i));
           end generate DFECLKDLYADJ1_DELAY;
           DFETAP11_DELAY : for i in 4 downto 0 generate
              VitalWireDelay (DFETAP11_ipd(i),DFETAP11(i),tipd_DFETAP11(i));
           end generate DFETAP11_DELAY;
           DFETAP21_DELAY : for i in 4 downto 0 generate
              VitalWireDelay (DFETAP21_ipd(i),DFETAP21(i),tipd_DFETAP21(i));
           end generate DFETAP21_DELAY;
           DFETAP31_DELAY : for i in 3 downto 0 generate
              VitalWireDelay (DFETAP31_ipd(i),DFETAP31(i),tipd_DFETAP31(i));
           end generate DFETAP31_DELAY;
           DFETAP41_DELAY : for i in 3 downto 0 generate
              VitalWireDelay (DFETAP41_ipd(i),DFETAP41(i),tipd_DFETAP41(i));
           end generate DFETAP41_DELAY;
	end block;

	SignalDelay : block
	begin
	TXDATA0_DELAY : for i in 31 downto 0 generate
	VitalSignalDelay (TXDATA0_dly(i),TXDATA0_ipd(i),tisd_TXDATA0_TXUSRCLK20(i));
	end generate TXDATA0_DELAY;
	TXBYPASS8B10B0_DELAY : for i in 3 downto 0 generate
	VitalSignalDelay (TXBYPASS8B10B0_dly(i),TXBYPASS8B10B0_ipd(i),tisd_TXBYPASS8B10B0_TXUSRCLK20(i));
	end generate TXBYPASS8B10B0_DELAY;
	TXCHARISK0_DELAY : for i in 3 downto 0 generate
	VitalSignalDelay (TXCHARISK0_dly(i),TXCHARISK0_ipd(i),tisd_TXCHARISK0_TXUSRCLK20(i));
	end generate TXCHARISK0_DELAY;
	TXCHARDISPMODE0_DELAY : for i in 3 downto 0 generate
	VitalSignalDelay (TXCHARDISPMODE0_dly(i),TXCHARDISPMODE0_ipd(i),tisd_TXCHARDISPMODE0_TXUSRCLK20(i));
	end generate TXCHARDISPMODE0_DELAY;
	TXCHARDISPVAL0_DELAY : for i in 3 downto 0 generate
	VitalSignalDelay (TXCHARDISPVAL0_dly(i),TXCHARDISPVAL0_ipd(i),tisd_TXCHARDISPVAL0_TXUSRCLK20(i));
	end generate TXCHARDISPVAL0_DELAY;
	TXDATA1_DELAY : for i in 31 downto 0 generate
	VitalSignalDelay (TXDATA1_dly(i),TXDATA1_ipd(i),tisd_TXDATA1_TXUSRCLK21(i));
	end generate TXDATA1_DELAY;
	TXBYPASS8B10B1_DELAY : for i in 3 downto 0 generate
	VitalSignalDelay (TXBYPASS8B10B1_dly(i),TXBYPASS8B10B1_ipd(i),tisd_TXBYPASS8B10B1_TXUSRCLK21(i));
	end generate TXBYPASS8B10B1_DELAY;
	TXCHARISK1_DELAY : for i in 3 downto 0 generate
	VitalSignalDelay (TXCHARISK1_dly(i),TXCHARISK1_ipd(i),tisd_TXCHARISK1_TXUSRCLK21(i));
	end generate TXCHARISK1_DELAY;
	TXCHARDISPMODE1_DELAY : for i in 3 downto 0 generate
	VitalSignalDelay (TXCHARDISPMODE1_dly(i),TXCHARDISPMODE1_ipd(i),tisd_TXCHARDISPMODE1_TXUSRCLK21(i));
	end generate TXCHARDISPMODE1_DELAY;
	TXCHARDISPVAL1_DELAY : for i in 3 downto 0 generate
	VitalSignalDelay (TXCHARDISPVAL1_dly(i),TXCHARDISPVAL1_ipd(i),tisd_TXCHARDISPVAL1_TXUSRCLK21(i));
	end generate TXCHARDISPVAL1_DELAY;
	VitalSignalDelay (TXENC8B10BUSE0_dly,TXENC8B10BUSE0_ipd,tisd_TXENC8B10BUSE0_TXUSRCLK20);
	VitalSignalDelay (TXPOLARITY0_dly,TXPOLARITY0_ipd,tisd_TXPOLARITY0_TXUSRCLK20);
	VitalSignalDelay (TXINHIBIT0_dly,TXINHIBIT0_ipd,tisd_TXINHIBIT0_TXUSRCLK20);
	VitalSignalDelay (TXENC8B10BUSE1_dly,TXENC8B10BUSE1_ipd,tisd_TXENC8B10BUSE1_TXUSRCLK21);
	VitalSignalDelay (TXPOLARITY1_dly,TXPOLARITY1_ipd,tisd_TXPOLARITY1_TXUSRCLK21);
	VitalSignalDelay (TXINHIBIT1_dly,TXINHIBIT1_ipd,tisd_TXINHIBIT1_TXUSRCLK21);
	VitalSignalDelay (RXPOLARITY0_dly,RXPOLARITY0_ipd,tisd_RXPOLARITY0_RXUSRCLK20);
	VitalSignalDelay (RXENPCOMMAALIGN0_dly,RXENPCOMMAALIGN0_ipd,tisd_RXENPCOMMAALIGN0_RXUSRCLK20);
	VitalSignalDelay (RXENMCOMMAALIGN0_dly,RXENMCOMMAALIGN0_ipd,tisd_RXENMCOMMAALIGN0_RXUSRCLK20);
	VitalSignalDelay (RXSLIDE0_dly,RXSLIDE0_ipd,tisd_RXSLIDE0_RXUSRCLK20);
	VitalSignalDelay (RXCOMMADETUSE0_dly,RXCOMMADETUSE0_ipd,tisd_RXCOMMADETUSE0_RXUSRCLK20);
	VitalSignalDelay (RXDEC8B10BUSE0_dly,RXDEC8B10BUSE0_ipd,tisd_RXDEC8B10BUSE0_RXUSRCLK20);
	VitalSignalDelay (RXENCHANSYNC0_dly,RXENCHANSYNC0_ipd,tisd_RXENCHANSYNC0_RXUSRCLK20);
	RXCHBONDI0_DELAY : for i in 3 downto 0 generate
	VitalSignalDelay (RXCHBONDI0_dly(i),RXCHBONDI0_ipd(i),tisd_RXCHBONDI0_RXUSRCLK0(i));
	end generate RXCHBONDI0_DELAY;
	VitalSignalDelay (RXPOLARITY1_dly,RXPOLARITY1_ipd,tisd_RXPOLARITY1_RXUSRCLK21);
	VitalSignalDelay (RXENPCOMMAALIGN1_dly,RXENPCOMMAALIGN1_ipd,tisd_RXENPCOMMAALIGN1_RXUSRCLK21);
	VitalSignalDelay (RXENMCOMMAALIGN1_dly,RXENMCOMMAALIGN1_ipd,tisd_RXENMCOMMAALIGN1_RXUSRCLK21);
	VitalSignalDelay (RXSLIDE1_dly,RXSLIDE1_ipd,tisd_RXSLIDE1_RXUSRCLK21);
	VitalSignalDelay (RXCOMMADETUSE1_dly,RXCOMMADETUSE1_ipd,tisd_RXCOMMADETUSE1_RXUSRCLK21);
	VitalSignalDelay (RXDEC8B10BUSE1_dly,RXDEC8B10BUSE1_ipd,tisd_RXDEC8B10BUSE1_RXUSRCLK21);
	VitalSignalDelay (RXENCHANSYNC1_dly,RXENCHANSYNC1_ipd,tisd_RXENCHANSYNC1_RXUSRCLK21);
	RXCHBONDI1_DELAY : for i in 3 downto 0 generate
	VitalSignalDelay (RXCHBONDI1_dly(i),RXCHBONDI1_ipd(i),tisd_RXCHBONDI1_RXUSRCLK1(i));
	end generate RXCHBONDI1_DELAY;
        VitalSignalDelay (TXELECIDLE0_dly,TXELECIDLE0_ipd,tisd_TXELECIDLE0_TXUSRCLK20);
	VitalSignalDelay (TXDETECTRX0_dly,TXDETECTRX0_ipd,tisd_TXDETECTRX0_TXUSRCLK20);
        VitalSignalDelay (TXELECIDLE1_dly,TXELECIDLE1_ipd,tisd_TXELECIDLE1_TXUSRCLK21);
	VitalSignalDelay (TXDETECTRX1_dly,TXDETECTRX1_ipd,tisd_TXDETECTRX1_TXUSRCLK21);
	VitalSignalDelay (TXCOMSTART0_dly,TXCOMSTART0_ipd,tisd_TXCOMSTART0_TXUSRCLK20);
	VitalSignalDelay (TXCOMTYPE0_dly,TXCOMTYPE0_ipd,tisd_TXCOMTYPE0_TXUSRCLK20);
	VitalSignalDelay (TXCOMSTART1_dly,TXCOMSTART1_ipd,tisd_TXCOMSTART1_TXUSRCLK21);
	VitalSignalDelay (TXCOMTYPE1_dly,TXCOMTYPE1_ipd,tisd_TXCOMTYPE1_TXUSRCLK21);
	TXENPRBSTST0_DELAY : for i in 1 downto 0 generate
	VitalSignalDelay (TXENPRBSTST0_dly(i),TXENPRBSTST0_ipd(i),tisd_TXENPRBSTST0_TXUSRCLK20(i));
	end generate TXENPRBSTST0_DELAY;
	RXENPRBSTST0_DELAY : for i in 1 downto 0 generate
	VitalSignalDelay (RXENPRBSTST0_dly(i),RXENPRBSTST0_ipd(i),tisd_RXENPRBSTST0_RXUSRCLK20(i));
	end generate RXENPRBSTST0_DELAY;
	VitalSignalDelay (PRBSCNTRESET0_dly,PRBSCNTRESET0_ipd,tisd_PRBSCNTRESET0_RXUSRCLK20);
	TXENPRBSTST1_DELAY : for i in 1 downto 0 generate
	VitalSignalDelay (TXENPRBSTST1_dly(i),TXENPRBSTST1_ipd(i),tisd_TXENPRBSTST1_TXUSRCLK21(i));
	end generate TXENPRBSTST1_DELAY;
	RXENPRBSTST1_DELAY : for i in 1 downto 0 generate
	VitalSignalDelay (RXENPRBSTST1_dly(i),RXENPRBSTST1_ipd(i),tisd_RXENPRBSTST1_RXUSRCLK21(i));
	end generate RXENPRBSTST1_DELAY;
	VitalSignalDelay (PRBSCNTRESET1_dly,PRBSCNTRESET1_ipd,tisd_PRBSCNTRESET1_RXUSRCLK21);
	DADDR_DELAY : for i in 6 downto 0 generate
	VitalSignalDelay (DADDR_dly(i),DADDR_ipd(i),tisd_DADDR_DCLK(i));
	end generate DADDR_DELAY;
	DI_DELAY : for i in 15 downto 0 generate
	VitalSignalDelay (DI_dly(i),DI_ipd(i),tisd_DI_DCLK(i));
	end generate DI_DELAY;
	VitalSignalDelay (DEN_dly,DEN_ipd,tisd_DEN_DCLK);
	VitalSignalDelay (DWE_dly,DWE_ipd,tisd_DWE_DCLK);
	VitalSignalDelay (RXENSAMPLEALIGN0_dly,RXENSAMPLEALIGN0_ipd,tisd_RXENSAMPLEALIGN0_RXUSRCLK20);
	VitalSignalDelay (RXENSAMPLEALIGN1_dly,RXENSAMPLEALIGN1_ipd,tisd_RXENSAMPLEALIGN1_RXUSRCLK21);
	TXHEADER0_DELAY : for i in 2 downto 0 generate
	VitalSignalDelay (TXHEADER0_dly(i),TXHEADER0_ipd(i),tisd_TXHEADER0_TXUSRCLK20(i));
	end generate TXHEADER0_DELAY;
	TXSEQUENCE0_DELAY : for i in 6 downto 0 generate
	VitalSignalDelay (TXSEQUENCE0_dly(i),TXSEQUENCE0_ipd(i),tisd_TXSEQUENCE0_TXUSRCLK20(i));
	end generate TXSEQUENCE0_DELAY;
	VitalSignalDelay (TXSTARTSEQ0_dly,TXSTARTSEQ0_ipd,tisd_TXSTARTSEQ0_TXUSRCLK20);
	VitalSignalDelay (RXGEARBOXSLIP0_dly,RXGEARBOXSLIP0_ipd,tisd_RXGEARBOXSLIP0_RXUSRCLK20);
	TXHEADER1_DELAY : for i in 2 downto 0 generate
	VitalSignalDelay (TXHEADER1_dly(i),TXHEADER1_ipd(i),tisd_TXHEADER1_TXUSRCLK21(i));
	end generate TXHEADER1_DELAY;
	TXSEQUENCE1_DELAY : for i in 6 downto 0 generate
	VitalSignalDelay (TXSEQUENCE1_dly(i),TXSEQUENCE1_ipd(i),tisd_TXSEQUENCE1_TXUSRCLK21(i));
	end generate TXSEQUENCE1_DELAY;
	VitalSignalDelay (TXSTARTSEQ1_dly,TXSTARTSEQ1_ipd,tisd_TXSTARTSEQ1_TXUSRCLK21);
	VitalSignalDelay (RXGEARBOXSLIP1_dly,RXGEARBOXSLIP1_ipd,tisd_RXGEARBOXSLIP1_RXUSRCLK21);
	DFECLKDLYADJ0_DELAY : for i in 5 downto 0 generate
	VitalSignalDelay (DFECLKDLYADJ0_dly(i),DFECLKDLYADJ0_ipd(i),tisd_DFECLKDLYADJ0_RXUSRCLK20(i));
	end generate DFECLKDLYADJ0_DELAY;
	DFETAP10_DELAY : for i in 4 downto 0 generate
	VitalSignalDelay (DFETAP10_dly(i),DFETAP10_ipd(i),tisd_DFETAP10_RXUSRCLK20(i));
	end generate DFETAP10_DELAY;
	DFETAP20_DELAY : for i in 4 downto 0 generate
	VitalSignalDelay (DFETAP20_dly(i),DFETAP20_ipd(i),tisd_DFETAP20_RXUSRCLK20(i));
	end generate DFETAP20_DELAY;
	DFETAP30_DELAY : for i in 3 downto 0 generate
	VitalSignalDelay (DFETAP30_dly(i),DFETAP30_ipd(i),tisd_DFETAP30_RXUSRCLK20(i));
	end generate DFETAP30_DELAY;
	DFETAP40_DELAY : for i in 3 downto 0 generate
	VitalSignalDelay (DFETAP40_dly(i),DFETAP40_ipd(i),tisd_DFETAP40_RXUSRCLK20(i));
	end generate DFETAP40_DELAY;
	DFECLKDLYADJ1_DELAY : for i in 5 downto 0 generate
	VitalSignalDelay (DFECLKDLYADJ1_dly(i),DFECLKDLYADJ1_ipd(i),tisd_DFECLKDLYADJ1_RXUSRCLK21(i));
	end generate DFECLKDLYADJ1_DELAY;
	DFETAP11_DELAY : for i in 4 downto 0 generate
	VitalSignalDelay (DFETAP11_dly(i),DFETAP11_ipd(i),tisd_DFETAP11_RXUSRCLK21(i));
	end generate DFETAP11_DELAY;
	DFETAP21_DELAY : for i in 4 downto 0 generate
	VitalSignalDelay (DFETAP21_dly(i),DFETAP21_ipd(i),tisd_DFETAP21_RXUSRCLK21(i));
	end generate DFETAP21_DELAY;
	DFETAP31_DELAY : for i in 3 downto 0 generate
	VitalSignalDelay (DFETAP31_dly(i),DFETAP31_ipd(i),tisd_DFETAP31_RXUSRCLK21(i));
	end generate DFETAP31_DELAY;
	DFETAP41_DELAY : for i in 3 downto 0 generate
	VitalSignalDelay (DFETAP41_dly(i),DFETAP41_ipd(i),tisd_DFETAP41_RXUSRCLK21(i));
	end generate DFETAP41_DELAY;

	VitalSignalDelay (TXUSRCLK20_dly,TXUSRCLK20_ipd,ticd_TXUSRCLK20);
	VitalSignalDelay (TXUSRCLK21_dly,TXUSRCLK21_ipd,ticd_TXUSRCLK21);
	VitalSignalDelay (RXUSRCLK20_dly,RXUSRCLK20_ipd,ticd_RXUSRCLK20);
	VitalSignalDelay (RXUSRCLK0_dly,RXUSRCLK0_ipd,ticd_RXUSRCLK0);
	VitalSignalDelay (RXUSRCLK21_dly,RXUSRCLK21_ipd,ticd_RXUSRCLK21);
	VitalSignalDelay (RXUSRCLK1_dly,RXUSRCLK1_ipd,ticd_RXUSRCLK1);
	VitalSignalDelay (DCLK_dly,DCLK_ipd,ticd_DCLK);
	end block;

	CLKIN_dly <= CLKIN_ipd;
        TXUSRCLK0_dly <= TXUSRCLK0_ipd;
        TXUSRCLK1_dly <= TXUSRCLK1_ipd;
	GTXRESET_dly <= GTXRESET_ipd;
	GTXTEST_dly <= GTXTEST_ipd;
	INTDATAWIDTH_dly <= INTDATAWIDTH_ipd;
	LOOPBACK0_dly <= LOOPBACK0_ipd;
	LOOPBACK1_dly <= LOOPBACK1_ipd;
	PLLLKDETEN_dly <= PLLLKDETEN_ipd;
	PLLPOWERDOWN_dly <= PLLPOWERDOWN_ipd;
	REFCLKPWRDNB_dly <= REFCLKPWRDNB_ipd;
	RXBUFRESET0_dly <= RXBUFRESET0_ipd;
	RXBUFRESET1_dly <= RXBUFRESET1_ipd;
	RXCDRRESET0_dly <= RXCDRRESET0_ipd;
	RXCDRRESET1_dly <= RXCDRRESET1_ipd;
	RXDATAWIDTH0_dly <= RXDATAWIDTH0_ipd;
	RXDATAWIDTH1_dly <= RXDATAWIDTH1_ipd;
	RXENEQB0_dly <= RXENEQB0_ipd;
	RXENEQB1_dly <= RXENEQB1_ipd;
	RXENPMAPHASEALIGN0_dly <= RXENPMAPHASEALIGN0_ipd;
	RXENPMAPHASEALIGN1_dly <= RXENPMAPHASEALIGN1_ipd;
	RXEQMIX0_dly <= RXEQMIX0_ipd;
	RXEQMIX1_dly <= RXEQMIX1_ipd;
	RXEQPOLE0_dly <= RXEQPOLE0_ipd;
	RXEQPOLE1_dly <= RXEQPOLE1_ipd;
	RXN0_dly <= RXN0_ipd;
	RXN1_dly <= RXN1_ipd;
	RXP0_dly <= RXP0_ipd;
	RXP1_dly <= RXP1_ipd;
	RXPMASETPHASE0_dly <= RXPMASETPHASE0_ipd;
	RXPMASETPHASE1_dly <= RXPMASETPHASE1_ipd;
	RXPOWERDOWN0_dly <= RXPOWERDOWN0_ipd;
	RXPOWERDOWN1_dly <= RXPOWERDOWN1_ipd;
	RXRESET0_dly <= RXRESET0_ipd;
	RXRESET1_dly <= RXRESET1_ipd;
	TXBUFDIFFCTRL0_dly <= TXBUFDIFFCTRL0_ipd;
	TXBUFDIFFCTRL1_dly <= TXBUFDIFFCTRL1_ipd;
	TXDATAWIDTH0_dly <= TXDATAWIDTH0_ipd;
	TXDATAWIDTH1_dly <= TXDATAWIDTH1_ipd;
	TXDIFFCTRL0_dly <= TXDIFFCTRL0_ipd;
	TXDIFFCTRL1_dly <= TXDIFFCTRL1_ipd;
--	TXELECIDLE0_dly <= TXELECIDLE0_ipd;
--	TXELECIDLE1_dly <= TXELECIDLE1_ipd;
	TXENPMAPHASEALIGN0_dly <= TXENPMAPHASEALIGN0_ipd;
	TXENPMAPHASEALIGN1_dly <= TXENPMAPHASEALIGN1_ipd;
	TXPMASETPHASE0_dly <= TXPMASETPHASE0_ipd;
	TXPMASETPHASE1_dly <= TXPMASETPHASE1_ipd;
	TXPOWERDOWN0_dly <= TXPOWERDOWN0_ipd;
	TXPOWERDOWN1_dly <= TXPOWERDOWN1_ipd;
	TXPREEMPHASIS0_dly <= TXPREEMPHASIS0_ipd;
	TXPREEMPHASIS1_dly <= TXPREEMPHASIS1_ipd;
	TXRESET0_dly <= TXRESET0_ipd;
	TXRESET1_dly <= TXRESET1_ipd;

	DFECLKDLYADJMONITOR0_out <= DFECLKDLYADJMONITOR0_outdelay after CLK_DELAY;
	DFECLKDLYADJMONITOR1_out <= DFECLKDLYADJMONITOR1_outdelay after CLK_DELAY;
	REFCLKOUT_out <= REFCLKOUT_outdelay after CLK_DELAY;
	RXCLKCORCNT0_out <= RXCLKCORCNT0_outdelay after CLK_DELAY;
	RXCLKCORCNT1_out <= RXCLKCORCNT1_outdelay after CLK_DELAY;
	RXRECCLK0_out <= RXRECCLK0_outdelay after CLK_DELAY;
	RXRECCLK1_out <= RXRECCLK1_outdelay after CLK_DELAY;
	TXOUTCLK0_out <= TXOUTCLK0_outdelay after CLK_DELAY;
	TXOUTCLK1_out <= TXOUTCLK1_outdelay after CLK_DELAY;

	DFEEYEDACMONITOR0_out <= DFEEYEDACMONITOR0_outdelay after OUT_DELAY;
	DFEEYEDACMONITOR1_out <= DFEEYEDACMONITOR1_outdelay after OUT_DELAY;
	DFESENSCAL0_out <= DFESENSCAL0_outdelay after OUT_DELAY;
	DFESENSCAL1_out <= DFESENSCAL1_outdelay after OUT_DELAY;
	DFETAP1MONITOR0_out <= DFETAP1MONITOR0_outdelay after OUT_DELAY;
	DFETAP1MONITOR1_out <= DFETAP1MONITOR1_outdelay after OUT_DELAY;
	DFETAP2MONITOR0_out <= DFETAP2MONITOR0_outdelay after OUT_DELAY;
	DFETAP2MONITOR1_out <= DFETAP2MONITOR1_outdelay after OUT_DELAY;
	DFETAP3MONITOR0_out <= DFETAP3MONITOR0_outdelay after OUT_DELAY;
	DFETAP3MONITOR1_out <= DFETAP3MONITOR1_outdelay after OUT_DELAY;
	DFETAP4MONITOR0_out <= DFETAP4MONITOR0_outdelay after OUT_DELAY;
	DFETAP4MONITOR1_out <= DFETAP4MONITOR1_outdelay after OUT_DELAY;
	DO_out <= DO_outdelay after OUT_DELAY;
	DRDY_out <= DRDY_outdelay after OUT_DELAY;
	PHYSTATUS0_out <= PHYSTATUS0_outdelay after OUT_DELAY;
	PHYSTATUS1_out <= PHYSTATUS1_outdelay after OUT_DELAY;
	PLLLKDET_out <= PLLLKDET_outdelay after OUT_DELAY;
	RESETDONE0_out <= RESETDONE0_outdelay after OUT_DELAY;
	RESETDONE1_out <= RESETDONE1_outdelay after OUT_DELAY;
	RXBUFSTATUS0_out <= RXBUFSTATUS0_outdelay after OUT_DELAY;
	RXBUFSTATUS1_out <= RXBUFSTATUS1_outdelay after OUT_DELAY;
	RXBYTEISALIGNED0_out <= RXBYTEISALIGNED0_outdelay after OUT_DELAY;
	RXBYTEISALIGNED1_out <= RXBYTEISALIGNED1_outdelay after OUT_DELAY;
	RXBYTEREALIGN0_out <= RXBYTEREALIGN0_outdelay after OUT_DELAY;
	RXBYTEREALIGN1_out <= RXBYTEREALIGN1_outdelay after OUT_DELAY;
	RXCHANBONDSEQ0_out <= RXCHANBONDSEQ0_outdelay after OUT_DELAY;
	RXCHANBONDSEQ1_out <= RXCHANBONDSEQ1_outdelay after OUT_DELAY;
	RXCHANISALIGNED0_out <= RXCHANISALIGNED0_outdelay after OUT_DELAY;
	RXCHANISALIGNED1_out <= RXCHANISALIGNED1_outdelay after OUT_DELAY;
	RXCHANREALIGN0_out <= RXCHANREALIGN0_outdelay after OUT_DELAY;
	RXCHANREALIGN1_out <= RXCHANREALIGN1_outdelay after OUT_DELAY;
	RXCHARISCOMMA0_out <= RXCHARISCOMMA0_outdelay after OUT_DELAY;
	RXCHARISCOMMA1_out <= RXCHARISCOMMA1_outdelay after OUT_DELAY;
	RXCHARISK0_out <= RXCHARISK0_outdelay after OUT_DELAY;
	RXCHARISK1_out <= RXCHARISK1_outdelay after OUT_DELAY;
	RXCHBONDO0_out <= RXCHBONDO0_outdelay after OUT_DELAY;
	RXCHBONDO1_out <= RXCHBONDO1_outdelay after OUT_DELAY;
	RXCOMMADET0_out <= RXCOMMADET0_outdelay after OUT_DELAY;
	RXCOMMADET1_out <= RXCOMMADET1_outdelay after OUT_DELAY;
	RXDATA0_out <= RXDATA0_outdelay after OUT_DELAY;
	RXDATA1_out <= RXDATA1_outdelay after OUT_DELAY;
	RXDATAVALID0_out <= RXDATAVALID0_outdelay after OUT_DELAY;
	RXDATAVALID1_out <= RXDATAVALID1_outdelay after OUT_DELAY;
	RXDISPERR0_out <= RXDISPERR0_outdelay after OUT_DELAY;
	RXDISPERR1_out <= RXDISPERR1_outdelay after OUT_DELAY;
	RXELECIDLE0_out <= RXELECIDLE0_outdelay after OUT_DELAY;
	RXELECIDLE1_out <= RXELECIDLE1_outdelay after OUT_DELAY;
	RXHEADER0_out <= RXHEADER0_outdelay after OUT_DELAY;
	RXHEADER1_out <= RXHEADER1_outdelay after OUT_DELAY;
	RXHEADERVALID0_out <= RXHEADERVALID0_outdelay after OUT_DELAY;
	RXHEADERVALID1_out <= RXHEADERVALID1_outdelay after OUT_DELAY;
	RXLOSSOFSYNC0_out <= RXLOSSOFSYNC0_outdelay after OUT_DELAY;
	RXLOSSOFSYNC1_out <= RXLOSSOFSYNC1_outdelay after OUT_DELAY;
	RXNOTINTABLE0_out <= RXNOTINTABLE0_outdelay after OUT_DELAY;
	RXNOTINTABLE1_out <= RXNOTINTABLE1_outdelay after OUT_DELAY;
	RXOVERSAMPLEERR0_out <= RXOVERSAMPLEERR0_outdelay after OUT_DELAY;
	RXOVERSAMPLEERR1_out <= RXOVERSAMPLEERR1_outdelay after OUT_DELAY;
	RXPRBSERR0_out <= RXPRBSERR0_outdelay after OUT_DELAY;
	RXPRBSERR1_out <= RXPRBSERR1_outdelay after OUT_DELAY;
	RXRUNDISP0_out <= RXRUNDISP0_outdelay after OUT_DELAY;
	RXRUNDISP1_out <= RXRUNDISP1_outdelay after OUT_DELAY;
	RXSTARTOFSEQ0_out <= RXSTARTOFSEQ0_outdelay after OUT_DELAY;
	RXSTARTOFSEQ1_out <= RXSTARTOFSEQ1_outdelay after OUT_DELAY;
	RXSTATUS0_out <= RXSTATUS0_outdelay after OUT_DELAY;
	RXSTATUS1_out <= RXSTATUS1_outdelay after OUT_DELAY;
	RXVALID0_out <= RXVALID0_outdelay after OUT_DELAY;
	RXVALID1_out <= RXVALID1_outdelay after OUT_DELAY;
	TXBUFSTATUS0_out <= TXBUFSTATUS0_outdelay after OUT_DELAY;
	TXBUFSTATUS1_out <= TXBUFSTATUS1_outdelay after OUT_DELAY;
	TXGEARBOXREADY0_out <= TXGEARBOXREADY0_outdelay after OUT_DELAY;
	TXGEARBOXREADY1_out <= TXGEARBOXREADY1_outdelay after OUT_DELAY;
	TXKERR0_out <= TXKERR0_outdelay after OUT_DELAY;
	TXKERR1_out <= TXKERR1_outdelay after OUT_DELAY;
	TXN0_out <= TXN0_outdelay after OUT_DELAY;
	TXN1_out <= TXN1_outdelay after OUT_DELAY;
	TXP0_out <= TXP0_outdelay after OUT_DELAY;
	TXP1_out <= TXP1_outdelay after OUT_DELAY;
	TXRUNDISP0_out <= TXRUNDISP0_outdelay after OUT_DELAY;
	TXRUNDISP1_out <= TXRUNDISP1_outdelay after OUT_DELAY;

        CLKIN_indelay <= CLKIN_dly after CLK_DELAY;
	DCLK_indelay <= DCLK_dly after CLK_DELAY;
	RXUSRCLK0_indelay <= RXUSRCLK0_dly after CLK_DELAY;
	RXUSRCLK1_indelay <= RXUSRCLK1_dly after CLK_DELAY;
	RXUSRCLK20_indelay <= RXUSRCLK20_dly after CLK_DELAY;
	RXUSRCLK21_indelay <= RXUSRCLK21_dly after CLK_DELAY;
	TXUSRCLK0_indelay <= TXUSRCLK0_dly after CLK_DELAY;
	TXUSRCLK1_indelay <= TXUSRCLK1_dly after CLK_DELAY;
	TXUSRCLK20_indelay <= TXUSRCLK20_dly after CLK_DELAY;
	TXUSRCLK21_indelay <= TXUSRCLK21_dly after CLK_DELAY;

	
	DADDR_indelay <= DADDR_dly after IN_DELAY;
	DEN_indelay <= DEN_dly after IN_DELAY;
	DFECLKDLYADJ0_indelay <= DFECLKDLYADJ0_dly after IN_DELAY;
	DFECLKDLYADJ1_indelay <= DFECLKDLYADJ1_dly after IN_DELAY;
	DFETAP10_indelay <= DFETAP10_dly after IN_DELAY;
	DFETAP11_indelay <= DFETAP11_dly after IN_DELAY;
	DFETAP20_indelay <= DFETAP20_dly after IN_DELAY;
	DFETAP21_indelay <= DFETAP21_dly after IN_DELAY;
	DFETAP30_indelay <= DFETAP30_dly after IN_DELAY;
	DFETAP31_indelay <= DFETAP31_dly after IN_DELAY;
	DFETAP40_indelay <= DFETAP40_dly after IN_DELAY;
	DFETAP41_indelay <= DFETAP41_dly after IN_DELAY;
	DI_indelay <= DI_dly after IN_DELAY;
	DWE_indelay <= DWE_dly after IN_DELAY;
	GTXRESET_indelay <= GTXRESET_dly after IN_DELAY;
	GTXTEST_indelay <= GTXTEST_dly after IN_DELAY;
	INTDATAWIDTH_indelay <= INTDATAWIDTH_dly after IN_DELAY;
	LOOPBACK0_indelay <= LOOPBACK0_dly after IN_DELAY;
	LOOPBACK1_indelay <= LOOPBACK1_dly after IN_DELAY;
	PLLLKDETEN_indelay <= PLLLKDETEN_dly after IN_DELAY;
	PLLPOWERDOWN_indelay <= PLLPOWERDOWN_dly after IN_DELAY;
	PRBSCNTRESET0_indelay <= PRBSCNTRESET0_dly after IN_DELAY;
	PRBSCNTRESET1_indelay <= PRBSCNTRESET1_dly after IN_DELAY;
	REFCLKPWRDNB_indelay <= REFCLKPWRDNB_dly after IN_DELAY;
	RXBUFRESET0_indelay <= RXBUFRESET0_dly after IN_DELAY;
	RXBUFRESET1_indelay <= RXBUFRESET1_dly after IN_DELAY;
	RXCDRRESET0_indelay <= RXCDRRESET0_dly after IN_DELAY;
	RXCDRRESET1_indelay <= RXCDRRESET1_dly after IN_DELAY;
	RXCHBONDI0_indelay <= RXCHBONDI0_dly after IN_DELAY;
	RXCHBONDI1_indelay <= RXCHBONDI1_dly after IN_DELAY;
	RXCOMMADETUSE0_indelay <= RXCOMMADETUSE0_dly after IN_DELAY;
	RXCOMMADETUSE1_indelay <= RXCOMMADETUSE1_dly after IN_DELAY;
	RXDATAWIDTH0_indelay <= RXDATAWIDTH0_dly after IN_DELAY;
	RXDATAWIDTH1_indelay <= RXDATAWIDTH1_dly after IN_DELAY;
	RXDEC8B10BUSE0_indelay <= RXDEC8B10BUSE0_dly after IN_DELAY;
	RXDEC8B10BUSE1_indelay <= RXDEC8B10BUSE1_dly after IN_DELAY;
	RXENCHANSYNC0_indelay <= RXENCHANSYNC0_dly after IN_DELAY;
	RXENCHANSYNC1_indelay <= RXENCHANSYNC1_dly after IN_DELAY;
	RXENEQB0_indelay <= RXENEQB0_dly after IN_DELAY;
	RXENEQB1_indelay <= RXENEQB1_dly after IN_DELAY;
	RXENMCOMMAALIGN0_indelay <= RXENMCOMMAALIGN0_dly after IN_DELAY;
	RXENMCOMMAALIGN1_indelay <= RXENMCOMMAALIGN1_dly after IN_DELAY;
	RXENPCOMMAALIGN0_indelay <= RXENPCOMMAALIGN0_dly after IN_DELAY;
	RXENPCOMMAALIGN1_indelay <= RXENPCOMMAALIGN1_dly after IN_DELAY;
	RXENPMAPHASEALIGN0_indelay <= RXENPMAPHASEALIGN0_dly after IN_DELAY;
	RXENPMAPHASEALIGN1_indelay <= RXENPMAPHASEALIGN1_dly after IN_DELAY;
	RXENPRBSTST0_indelay <= RXENPRBSTST0_dly after IN_DELAY;
	RXENPRBSTST1_indelay <= RXENPRBSTST1_dly after IN_DELAY;
	RXENSAMPLEALIGN0_indelay <= RXENSAMPLEALIGN0_dly after IN_DELAY;
	RXENSAMPLEALIGN1_indelay <= RXENSAMPLEALIGN1_dly after IN_DELAY;
	RXEQMIX0_indelay <= RXEQMIX0_dly after IN_DELAY;
	RXEQMIX1_indelay <= RXEQMIX1_dly after IN_DELAY;
	RXEQPOLE0_indelay <= RXEQPOLE0_dly after IN_DELAY;
	RXEQPOLE1_indelay <= RXEQPOLE1_dly after IN_DELAY;
	RXGEARBOXSLIP0_indelay <= RXGEARBOXSLIP0_dly after IN_DELAY;
	RXGEARBOXSLIP1_indelay <= RXGEARBOXSLIP1_dly after IN_DELAY;
	RXN0_indelay <= RXN0_dly after IN_DELAY;
	RXN1_indelay <= RXN1_dly after IN_DELAY;
	RXP0_indelay <= RXP0_dly after IN_DELAY;
	RXP1_indelay <= RXP1_dly after IN_DELAY;
	RXPMASETPHASE0_indelay <= RXPMASETPHASE0_dly after IN_DELAY;
	RXPMASETPHASE1_indelay <= RXPMASETPHASE1_dly after IN_DELAY;
	RXPOLARITY0_indelay <= RXPOLARITY0_dly after IN_DELAY;
	RXPOLARITY1_indelay <= RXPOLARITY1_dly after IN_DELAY;
	RXPOWERDOWN0_indelay <= RXPOWERDOWN0_dly after IN_DELAY;
	RXPOWERDOWN1_indelay <= RXPOWERDOWN1_dly after IN_DELAY;
	RXRESET0_indelay <= RXRESET0_dly after IN_DELAY;
	RXRESET1_indelay <= RXRESET1_dly after IN_DELAY;
	RXSLIDE0_indelay <= RXSLIDE0_dly after IN_DELAY;
	RXSLIDE1_indelay <= RXSLIDE1_dly after IN_DELAY;
	TXBUFDIFFCTRL0_indelay <= TXBUFDIFFCTRL0_dly after IN_DELAY;
	TXBUFDIFFCTRL1_indelay <= TXBUFDIFFCTRL1_dly after IN_DELAY;
	TXBYPASS8B10B0_indelay <= TXBYPASS8B10B0_dly after IN_DELAY;
	TXBYPASS8B10B1_indelay <= TXBYPASS8B10B1_dly after IN_DELAY;
	TXCHARDISPMODE0_indelay <= TXCHARDISPMODE0_dly after IN_DELAY;
	TXCHARDISPMODE1_indelay <= TXCHARDISPMODE1_dly after IN_DELAY;
	TXCHARDISPVAL0_indelay <= TXCHARDISPVAL0_dly after IN_DELAY;
	TXCHARDISPVAL1_indelay <= TXCHARDISPVAL1_dly after IN_DELAY;
	TXCHARISK0_indelay <= TXCHARISK0_dly after IN_DELAY;
	TXCHARISK1_indelay <= TXCHARISK1_dly after IN_DELAY;
	TXCOMSTART0_indelay <= TXCOMSTART0_dly after IN_DELAY;
	TXCOMSTART1_indelay <= TXCOMSTART1_dly after IN_DELAY;
	TXCOMTYPE0_indelay <= TXCOMTYPE0_dly after IN_DELAY;
	TXCOMTYPE1_indelay <= TXCOMTYPE1_dly after IN_DELAY;
	TXDATA0_indelay <= TXDATA0_dly after IN_DELAY;
	TXDATA1_indelay <= TXDATA1_dly after IN_DELAY;
	TXDATAWIDTH0_indelay <= TXDATAWIDTH0_dly after IN_DELAY;
	TXDATAWIDTH1_indelay <= TXDATAWIDTH1_dly after IN_DELAY;
	TXDETECTRX0_indelay <= TXDETECTRX0_dly after IN_DELAY;
	TXDETECTRX1_indelay <= TXDETECTRX1_dly after IN_DELAY;
	TXDIFFCTRL0_indelay <= TXDIFFCTRL0_dly after IN_DELAY;
	TXDIFFCTRL1_indelay <= TXDIFFCTRL1_dly after IN_DELAY;
	TXELECIDLE0_indelay <= TXELECIDLE0_dly after IN_DELAY;
	TXELECIDLE1_indelay <= TXELECIDLE1_dly after IN_DELAY;
	TXENC8B10BUSE0_indelay <= TXENC8B10BUSE0_dly after IN_DELAY;
	TXENC8B10BUSE1_indelay <= TXENC8B10BUSE1_dly after IN_DELAY;
	TXENPMAPHASEALIGN0_indelay <= TXENPMAPHASEALIGN0_dly after IN_DELAY;
	TXENPMAPHASEALIGN1_indelay <= TXENPMAPHASEALIGN1_dly after IN_DELAY;
	TXENPRBSTST0_indelay <= TXENPRBSTST0_dly after IN_DELAY;
	TXENPRBSTST1_indelay <= TXENPRBSTST1_dly after IN_DELAY;
	TXHEADER0_indelay <= TXHEADER0_dly after IN_DELAY;
	TXHEADER1_indelay <= TXHEADER1_dly after IN_DELAY;
	TXINHIBIT0_indelay <= TXINHIBIT0_dly after IN_DELAY;
	TXINHIBIT1_indelay <= TXINHIBIT1_dly after IN_DELAY;
	TXPMASETPHASE0_indelay <= TXPMASETPHASE0_dly after IN_DELAY;
	TXPMASETPHASE1_indelay <= TXPMASETPHASE1_dly after IN_DELAY;
	TXPOLARITY0_indelay <= TXPOLARITY0_dly after IN_DELAY;
	TXPOLARITY1_indelay <= TXPOLARITY1_dly after IN_DELAY;
	TXPOWERDOWN0_indelay <= TXPOWERDOWN0_dly after IN_DELAY;
	TXPOWERDOWN1_indelay <= TXPOWERDOWN1_dly after IN_DELAY;
	TXPREEMPHASIS0_indelay <= TXPREEMPHASIS0_dly after IN_DELAY;
	TXPREEMPHASIS1_indelay <= TXPREEMPHASIS1_dly after IN_DELAY;
	TXRESET0_indelay <= TXRESET0_dly after IN_DELAY;
	TXRESET1_indelay <= TXRESET1_dly after IN_DELAY;
	TXSEQUENCE0_indelay <= TXSEQUENCE0_dly after IN_DELAY;
	TXSEQUENCE1_indelay <= TXSEQUENCE1_dly after IN_DELAY;
	TXSTARTSEQ0_indelay <= TXSTARTSEQ0_dly after IN_DELAY;
	TXSTARTSEQ1_indelay <= TXSTARTSEQ1_dly after IN_DELAY;

-- <!--Aldec correction start
	GSR_local <= GSR;
-- Aldec correction end -->

	gtx_dual_fast_bw_1 : GTX_DUAL_FAST
        port map (
        STEPPING   => STEPPING_BINARY,
        AC_CAP_DIS_0  =>  AC_CAP_DIS_0_BINARY,
	AC_CAP_DIS_1  =>  AC_CAP_DIS_1_BINARY,
	ALIGN_COMMA_WORD_0  =>  ALIGN_COMMA_WORD_0_BINARY,
	ALIGN_COMMA_WORD_1  =>  ALIGN_COMMA_WORD_1_BINARY,
	CB2_INH_CC_PERIOD_0  =>  CB2_INH_CC_PERIOD_0_BINARY,
	CB2_INH_CC_PERIOD_1  =>  CB2_INH_CC_PERIOD_1_BINARY,
	CDR_PH_ADJ_TIME  =>  CDR_PH_ADJ_TIME_BINARY,
	CHAN_BOND_1_MAX_SKEW_0  =>  CHAN_BOND_1_MAX_SKEW_0_BINARY,
	CHAN_BOND_1_MAX_SKEW_1  =>  CHAN_BOND_1_MAX_SKEW_1_BINARY,
	CHAN_BOND_2_MAX_SKEW_0  =>  CHAN_BOND_2_MAX_SKEW_0_BINARY,
	CHAN_BOND_2_MAX_SKEW_1  =>  CHAN_BOND_2_MAX_SKEW_1_BINARY,
	CHAN_BOND_KEEP_ALIGN_0  =>  CHAN_BOND_KEEP_ALIGN_0_BINARY,
	CHAN_BOND_KEEP_ALIGN_1  =>  CHAN_BOND_KEEP_ALIGN_1_BINARY,
	CHAN_BOND_LEVEL_0  =>  CHAN_BOND_LEVEL_0_BINARY,
	CHAN_BOND_LEVEL_1  =>  CHAN_BOND_LEVEL_1_BINARY,
	CHAN_BOND_MODE_0  =>  CHAN_BOND_MODE_0_BINARY,
	CHAN_BOND_MODE_1  =>  CHAN_BOND_MODE_1_BINARY,
	CHAN_BOND_SEQ_1_1_0  =>  CHAN_BOND_SEQ_1_1_0_BINARY,
	CHAN_BOND_SEQ_1_1_1  =>  CHAN_BOND_SEQ_1_1_1_BINARY,
	CHAN_BOND_SEQ_1_2_0  =>  CHAN_BOND_SEQ_1_2_0_BINARY,
	CHAN_BOND_SEQ_1_2_1  =>  CHAN_BOND_SEQ_1_2_1_BINARY,
	CHAN_BOND_SEQ_1_3_0  =>  CHAN_BOND_SEQ_1_3_0_BINARY,
	CHAN_BOND_SEQ_1_3_1  =>  CHAN_BOND_SEQ_1_3_1_BINARY,
	CHAN_BOND_SEQ_1_4_0  =>  CHAN_BOND_SEQ_1_4_0_BINARY,
	CHAN_BOND_SEQ_1_4_1  =>  CHAN_BOND_SEQ_1_4_1_BINARY,
	CHAN_BOND_SEQ_1_ENABLE_0  =>  CHAN_BOND_SEQ_1_ENABLE_0_BINARY,
	CHAN_BOND_SEQ_1_ENABLE_1  =>  CHAN_BOND_SEQ_1_ENABLE_1_BINARY,
	CHAN_BOND_SEQ_2_1_0  =>  CHAN_BOND_SEQ_2_1_0_BINARY,
	CHAN_BOND_SEQ_2_1_1  =>  CHAN_BOND_SEQ_2_1_1_BINARY,
	CHAN_BOND_SEQ_2_2_0  =>  CHAN_BOND_SEQ_2_2_0_BINARY,
	CHAN_BOND_SEQ_2_2_1  =>  CHAN_BOND_SEQ_2_2_1_BINARY,
	CHAN_BOND_SEQ_2_3_0  =>  CHAN_BOND_SEQ_2_3_0_BINARY,
	CHAN_BOND_SEQ_2_3_1  =>  CHAN_BOND_SEQ_2_3_1_BINARY,
	CHAN_BOND_SEQ_2_4_0  =>  CHAN_BOND_SEQ_2_4_0_BINARY,
	CHAN_BOND_SEQ_2_4_1  =>  CHAN_BOND_SEQ_2_4_1_BINARY,
	CHAN_BOND_SEQ_2_ENABLE_0  =>  CHAN_BOND_SEQ_2_ENABLE_0_BINARY,
	CHAN_BOND_SEQ_2_ENABLE_1  =>  CHAN_BOND_SEQ_2_ENABLE_1_BINARY,
	CHAN_BOND_SEQ_2_USE_0  =>  CHAN_BOND_SEQ_2_USE_0_BINARY,
	CHAN_BOND_SEQ_2_USE_1  =>  CHAN_BOND_SEQ_2_USE_1_BINARY,
	CHAN_BOND_SEQ_LEN_0  =>  CHAN_BOND_SEQ_LEN_0_BINARY,
	CHAN_BOND_SEQ_LEN_1  =>  CHAN_BOND_SEQ_LEN_1_BINARY,
	CLK25_DIVIDER  =>  CLK25_DIVIDER_BINARY,
	CLKINDC_B  =>  CLKINDC_B_BINARY,
	CLKRCV_TRST  =>  CLKRCV_TRST_BINARY,
	CLK_CORRECT_USE_0  =>  CLK_CORRECT_USE_0_BINARY,
	CLK_CORRECT_USE_1  =>  CLK_CORRECT_USE_1_BINARY,
	CLK_COR_ADJ_LEN_0  =>  CLK_COR_ADJ_LEN_0_BINARY,
	CLK_COR_ADJ_LEN_1  =>  CLK_COR_ADJ_LEN_1_BINARY,
	CLK_COR_DET_LEN_0  =>  CLK_COR_DET_LEN_0_BINARY,
	CLK_COR_DET_LEN_1  =>  CLK_COR_DET_LEN_1_BINARY,
	CLK_COR_INSERT_IDLE_FLAG_0  =>  CLK_COR_INSERT_IDLE_FLAG_0_BINARY,
	CLK_COR_INSERT_IDLE_FLAG_1  =>  CLK_COR_INSERT_IDLE_FLAG_1_BINARY,
	CLK_COR_KEEP_IDLE_0  =>  CLK_COR_KEEP_IDLE_0_BINARY,
	CLK_COR_KEEP_IDLE_1  =>  CLK_COR_KEEP_IDLE_1_BINARY,
	CLK_COR_MAX_LAT_0  =>  CLK_COR_MAX_LAT_0_BINARY,
	CLK_COR_MAX_LAT_1  =>  CLK_COR_MAX_LAT_1_BINARY,
	CLK_COR_MIN_LAT_0  =>  CLK_COR_MIN_LAT_0_BINARY,
	CLK_COR_MIN_LAT_1  =>  CLK_COR_MIN_LAT_1_BINARY,
	CLK_COR_PRECEDENCE_0  =>  CLK_COR_PRECEDENCE_0_BINARY,
	CLK_COR_PRECEDENCE_1  =>  CLK_COR_PRECEDENCE_1_BINARY,
	CLK_COR_REPEAT_WAIT_0  =>  CLK_COR_REPEAT_WAIT_0_BINARY,
	CLK_COR_REPEAT_WAIT_1  =>  CLK_COR_REPEAT_WAIT_1_BINARY,
	CLK_COR_SEQ_1_1_0  =>  CLK_COR_SEQ_1_1_0_BINARY,
	CLK_COR_SEQ_1_1_1  =>  CLK_COR_SEQ_1_1_1_BINARY,
	CLK_COR_SEQ_1_2_0  =>  CLK_COR_SEQ_1_2_0_BINARY,
	CLK_COR_SEQ_1_2_1  =>  CLK_COR_SEQ_1_2_1_BINARY,
	CLK_COR_SEQ_1_3_0  =>  CLK_COR_SEQ_1_3_0_BINARY,
	CLK_COR_SEQ_1_3_1  =>  CLK_COR_SEQ_1_3_1_BINARY,
	CLK_COR_SEQ_1_4_0  =>  CLK_COR_SEQ_1_4_0_BINARY,
	CLK_COR_SEQ_1_4_1  =>  CLK_COR_SEQ_1_4_1_BINARY,
	CLK_COR_SEQ_1_ENABLE_0  =>  CLK_COR_SEQ_1_ENABLE_0_BINARY,
	CLK_COR_SEQ_1_ENABLE_1  =>  CLK_COR_SEQ_1_ENABLE_1_BINARY,
	CLK_COR_SEQ_2_1_0  =>  CLK_COR_SEQ_2_1_0_BINARY,
	CLK_COR_SEQ_2_1_1  =>  CLK_COR_SEQ_2_1_1_BINARY,
	CLK_COR_SEQ_2_2_0  =>  CLK_COR_SEQ_2_2_0_BINARY,
	CLK_COR_SEQ_2_2_1  =>  CLK_COR_SEQ_2_2_1_BINARY,
	CLK_COR_SEQ_2_3_0  =>  CLK_COR_SEQ_2_3_0_BINARY,
	CLK_COR_SEQ_2_3_1  =>  CLK_COR_SEQ_2_3_1_BINARY,
	CLK_COR_SEQ_2_4_0  =>  CLK_COR_SEQ_2_4_0_BINARY,
	CLK_COR_SEQ_2_4_1  =>  CLK_COR_SEQ_2_4_1_BINARY,
	CLK_COR_SEQ_2_ENABLE_0  =>  CLK_COR_SEQ_2_ENABLE_0_BINARY,
	CLK_COR_SEQ_2_ENABLE_1  =>  CLK_COR_SEQ_2_ENABLE_1_BINARY,
	CLK_COR_SEQ_2_USE_0  =>  CLK_COR_SEQ_2_USE_0_BINARY,
	CLK_COR_SEQ_2_USE_1  =>  CLK_COR_SEQ_2_USE_1_BINARY,
	CM_TRIM_0  =>  CM_TRIM_0_BINARY,
	CM_TRIM_1  =>  CM_TRIM_1_BINARY,
	COMMA_10B_ENABLE_0  =>  COMMA_10B_ENABLE_0_BINARY,
	COMMA_10B_ENABLE_1  =>  COMMA_10B_ENABLE_1_BINARY,
	COMMA_DOUBLE_0  =>  COMMA_DOUBLE_0_BINARY,
	COMMA_DOUBLE_1  =>  COMMA_DOUBLE_1_BINARY,
	COM_BURST_VAL_0  =>  COM_BURST_VAL_0_BINARY,
	COM_BURST_VAL_1  =>  COM_BURST_VAL_1_BINARY,
	DEC_MCOMMA_DETECT_0  =>  DEC_MCOMMA_DETECT_0_BINARY,
	DEC_MCOMMA_DETECT_1  =>  DEC_MCOMMA_DETECT_1_BINARY,
	DEC_PCOMMA_DETECT_0  =>  DEC_PCOMMA_DETECT_0_BINARY,
	DEC_PCOMMA_DETECT_1  =>  DEC_PCOMMA_DETECT_1_BINARY,
	DEC_VALID_COMMA_ONLY_0  =>  DEC_VALID_COMMA_ONLY_0_BINARY,
	DEC_VALID_COMMA_ONLY_1  =>  DEC_VALID_COMMA_ONLY_1_BINARY,
	DFE_CAL_TIME  =>  DFE_CAL_TIME_BINARY,
	DFE_CFG_0  =>  DFE_CFG_0_BINARY,
	DFE_CFG_1  =>  DFE_CFG_1_BINARY,
	GEARBOX_ENDEC_0  =>  GEARBOX_ENDEC_0_BINARY,
	GEARBOX_ENDEC_1  =>  GEARBOX_ENDEC_1_BINARY,
	MCOMMA_10B_VALUE_0  =>  MCOMMA_10B_VALUE_0_BINARY,
	MCOMMA_10B_VALUE_1  =>  MCOMMA_10B_VALUE_1_BINARY,
	MCOMMA_DETECT_0  =>  MCOMMA_DETECT_0_BINARY,
	MCOMMA_DETECT_1  =>  MCOMMA_DETECT_1_BINARY,
	OOBDETECT_THRESHOLD_0  =>  OOBDETECT_THRESHOLD_0_BINARY,
	OOBDETECT_THRESHOLD_1  =>  OOBDETECT_THRESHOLD_1_BINARY,
	OOB_CLK_DIVIDER  =>  OOB_CLK_DIVIDER_BINARY,
	OVERSAMPLE_MODE  =>  OVERSAMPLE_MODE_BINARY,
	PCI_EXPRESS_MODE_0  =>  PCI_EXPRESS_MODE_0_BINARY,
	PCI_EXPRESS_MODE_1  =>  PCI_EXPRESS_MODE_1_BINARY,
	PCOMMA_10B_VALUE_0  =>  PCOMMA_10B_VALUE_0_BINARY,
	PCOMMA_10B_VALUE_1  =>  PCOMMA_10B_VALUE_1_BINARY,
	PCOMMA_DETECT_0  =>  PCOMMA_DETECT_0_BINARY,
	PCOMMA_DETECT_1  =>  PCOMMA_DETECT_1_BINARY,
        PLL_COM_CFG  =>  PLL_COM_CFG_BINARY,
       	PLL_CP_CFG  =>  PLL_CP_CFG_BINARY,
	PLL_DIVSEL_FB  =>  PLL_DIVSEL_FB_BINARY,
	PLL_DIVSEL_REF  =>  PLL_DIVSEL_REF_BINARY,
	PLL_FB_DCCEN  =>  PLL_FB_DCCEN_BINARY,
       	PLL_LKDET_CFG  =>  PLL_LKDET_CFG_BINARY,
	PLL_RXDIVSEL_OUT_0  =>  PLL_RXDIVSEL_OUT_0_BINARY,
	PLL_RXDIVSEL_OUT_1  =>  PLL_RXDIVSEL_OUT_1_BINARY,
	PLL_SATA_0  =>  PLL_SATA_0_BINARY,
	PLL_SATA_1  =>  PLL_SATA_1_BINARY,
       	PLL_TDCC_CFG  =>  PLL_TDCC_CFG_BINARY,
	PLL_TXDIVSEL_OUT_0  =>  PLL_TXDIVSEL_OUT_0_BINARY,
	PLL_TXDIVSEL_OUT_1  =>  PLL_TXDIVSEL_OUT_1_BINARY,
	PMA_CDR_SCAN_0  =>  PMA_CDR_SCAN_0_BINARY,
	PMA_CDR_SCAN_1  =>  PMA_CDR_SCAN_1_BINARY,
       	PMA_COM_CFG  =>  PMA_COM_CFG_BINARY,
	PMA_RXSYNC_CFG_0  =>  PMA_RXSYNC_CFG_0_BINARY,
	PMA_RXSYNC_CFG_1  =>  PMA_RXSYNC_CFG_1_BINARY,
	PMA_RX_CFG_0  =>  PMA_RX_CFG_0_BINARY,
	PMA_RX_CFG_1  =>  PMA_RX_CFG_1_BINARY,
	PMA_TX_CFG_0  =>  PMA_TX_CFG_0_BINARY,
	PMA_TX_CFG_1  =>  PMA_TX_CFG_1_BINARY,
	PRBS_ERR_THRESHOLD_0  =>  PRBS_ERR_THRESHOLD_0_BINARY,
	PRBS_ERR_THRESHOLD_1  =>  PRBS_ERR_THRESHOLD_1_BINARY,
	RCV_TERM_GND_0  =>  RCV_TERM_GND_0_BINARY,
	RCV_TERM_GND_1  =>  RCV_TERM_GND_1_BINARY,
	RCV_TERM_VTTRX_0  =>  RCV_TERM_VTTRX_0_BINARY,
	RCV_TERM_VTTRX_1  =>  RCV_TERM_VTTRX_1_BINARY,
	RXGEARBOX_USE_0  =>  RXGEARBOX_USE_0_BINARY,
	RXGEARBOX_USE_1  =>  RXGEARBOX_USE_1_BINARY,
	RX_BUFFER_USE_0  =>  RX_BUFFER_USE_0_BINARY,
	RX_BUFFER_USE_1  =>  RX_BUFFER_USE_1_BINARY,
	RX_DECODE_SEQ_MATCH_0  =>  RX_DECODE_SEQ_MATCH_0_BINARY,
	RX_DECODE_SEQ_MATCH_1  =>  RX_DECODE_SEQ_MATCH_1_BINARY,
	RX_EN_IDLE_HOLD_CDR  =>  RX_EN_IDLE_HOLD_CDR_BINARY,
	RX_EN_IDLE_HOLD_DFE_0  =>  RX_EN_IDLE_HOLD_DFE_0_BINARY,
	RX_EN_IDLE_HOLD_DFE_1  =>  RX_EN_IDLE_HOLD_DFE_1_BINARY,
	RX_EN_IDLE_RESET_BUF_0  =>  RX_EN_IDLE_RESET_BUF_0_BINARY,
	RX_EN_IDLE_RESET_BUF_1  =>  RX_EN_IDLE_RESET_BUF_1_BINARY,
	RX_EN_IDLE_RESET_FR  =>  RX_EN_IDLE_RESET_FR_BINARY,
	RX_EN_IDLE_RESET_PH  =>  RX_EN_IDLE_RESET_PH_BINARY,
	RX_IDLE_HI_CNT_0  =>  RX_IDLE_HI_CNT_0_BINARY,
	RX_IDLE_HI_CNT_1  =>  RX_IDLE_HI_CNT_1_BINARY,
	RX_IDLE_LO_CNT_0  =>  RX_IDLE_LO_CNT_0_BINARY,
	RX_IDLE_LO_CNT_1  =>  RX_IDLE_LO_CNT_1_BINARY,
	RX_LOSS_OF_SYNC_FSM_0  =>  RX_LOSS_OF_SYNC_FSM_0_BINARY,
	RX_LOSS_OF_SYNC_FSM_1  =>  RX_LOSS_OF_SYNC_FSM_1_BINARY,
	RX_LOS_INVALID_INCR_0  =>  RX_LOS_INVALID_INCR_0_BINARY,
	RX_LOS_INVALID_INCR_1  =>  RX_LOS_INVALID_INCR_1_BINARY,
	RX_LOS_THRESHOLD_0  =>  RX_LOS_THRESHOLD_0_BINARY,
	RX_LOS_THRESHOLD_1  =>  RX_LOS_THRESHOLD_1_BINARY,
	RX_SLIDE_MODE_0  =>  RX_SLIDE_MODE_0_BINARY,
	RX_SLIDE_MODE_1  =>  RX_SLIDE_MODE_1_BINARY,
	RX_STATUS_FMT_0  =>  RX_STATUS_FMT_0_BINARY,
	RX_STATUS_FMT_1  =>  RX_STATUS_FMT_1_BINARY,
	RX_XCLK_SEL_0  =>  RX_XCLK_SEL_0_BINARY,
	RX_XCLK_SEL_1  =>  RX_XCLK_SEL_1_BINARY,
	SATA_BURST_VAL_0  =>  SATA_BURST_VAL_0_BINARY,
	SATA_BURST_VAL_1  =>  SATA_BURST_VAL_1_BINARY,
	SATA_IDLE_VAL_0  =>  SATA_IDLE_VAL_0_BINARY,
	SATA_IDLE_VAL_1  =>  SATA_IDLE_VAL_1_BINARY,
	SATA_MAX_BURST_0  =>  SATA_MAX_BURST_0_BINARY,
	SATA_MAX_BURST_1  =>  SATA_MAX_BURST_1_BINARY,
	SATA_MAX_INIT_0  =>  SATA_MAX_INIT_0_BINARY,
	SATA_MAX_INIT_1  =>  SATA_MAX_INIT_1_BINARY,
	SATA_MAX_WAKE_0  =>  SATA_MAX_WAKE_0_BINARY,
	SATA_MAX_WAKE_1  =>  SATA_MAX_WAKE_1_BINARY,
	SATA_MIN_BURST_0  =>  SATA_MIN_BURST_0_BINARY,
	SATA_MIN_BURST_1  =>  SATA_MIN_BURST_1_BINARY,
	SATA_MIN_INIT_0  =>  SATA_MIN_INIT_0_BINARY,
	SATA_MIN_INIT_1  =>  SATA_MIN_INIT_1_BINARY,
	SATA_MIN_WAKE_0  =>  SATA_MIN_WAKE_0_BINARY,
	SATA_MIN_WAKE_1  =>  SATA_MIN_WAKE_1_BINARY,
	SIM_GTXRESET_SPEEDUP  =>  SIM_GTXRESET_SPEEDUP_BINARY,
	SIM_PLL_PERDIV2  =>  SIM_PLL_PERDIV2_BINARY,
	SIM_RECEIVER_DETECT_PASS_0  =>  SIM_RECEIVER_DETECT_PASS_0_BINARY,
	SIM_RECEIVER_DETECT_PASS_1  =>  SIM_RECEIVER_DETECT_PASS_1_BINARY,
	TERMINATION_CTRL  =>  TERMINATION_CTRL_BINARY,
	TERMINATION_IMP_0  =>  TERMINATION_IMP_0_BINARY,
	TERMINATION_IMP_1  =>  TERMINATION_IMP_1_BINARY,
	TERMINATION_OVRD  =>  TERMINATION_OVRD_BINARY,
	TRANS_TIME_FROM_P2_0  =>  TRANS_TIME_FROM_P2_0_BINARY,
	TRANS_TIME_FROM_P2_1  =>  TRANS_TIME_FROM_P2_1_BINARY,
	TRANS_TIME_NON_P2_0  =>  TRANS_TIME_NON_P2_0_BINARY,
	TRANS_TIME_NON_P2_1  =>  TRANS_TIME_NON_P2_1_BINARY,
	TRANS_TIME_TO_P2_0  =>  TRANS_TIME_TO_P2_0_BINARY,
	TRANS_TIME_TO_P2_1  =>  TRANS_TIME_TO_P2_1_BINARY,
	TXGEARBOX_USE_0  =>  TXGEARBOX_USE_0_BINARY,
	TXGEARBOX_USE_1  =>  TXGEARBOX_USE_1_BINARY,
	TXRX_INVERT_0  =>  TXRX_INVERT_0_BINARY,
	TXRX_INVERT_1  =>  TXRX_INVERT_1_BINARY,
	TX_BUFFER_USE_0  =>  TX_BUFFER_USE_0_BINARY,
	TX_BUFFER_USE_1  =>  TX_BUFFER_USE_1_BINARY,
       	TX_DETECT_RX_CFG_0  =>  TX_DETECT_RX_CFG_0_BINARY,
	TX_DETECT_RX_CFG_1  =>  TX_DETECT_RX_CFG_1_BINARY,
	TX_IDLE_DELAY_0  =>  TX_IDLE_DELAY_0_BINARY,
	TX_IDLE_DELAY_1  =>  TX_IDLE_DELAY_1_BINARY,
	TX_XCLK_SEL_0  =>  TX_XCLK_SEL_0_BINARY,
	TX_XCLK_SEL_1  =>  TX_XCLK_SEL_1_BINARY,

	DFECLKDLYADJMONITOR0  =>  DFECLKDLYADJMONITOR0_outdelay,
	DFECLKDLYADJMONITOR1  =>  DFECLKDLYADJMONITOR1_outdelay,
	DFEEYEDACMONITOR0  =>  DFEEYEDACMONITOR0_outdelay,
	DFEEYEDACMONITOR1  =>  DFEEYEDACMONITOR1_outdelay,
	DFESENSCAL0  =>  DFESENSCAL0_outdelay,
	DFESENSCAL1  =>  DFESENSCAL1_outdelay,
	DFETAP1MONITOR0  =>  DFETAP1MONITOR0_outdelay,
	DFETAP1MONITOR1  =>  DFETAP1MONITOR1_outdelay,
	DFETAP2MONITOR0  =>  DFETAP2MONITOR0_outdelay,
	DFETAP2MONITOR1  =>  DFETAP2MONITOR1_outdelay,
	DFETAP3MONITOR0  =>  DFETAP3MONITOR0_outdelay,
	DFETAP3MONITOR1  =>  DFETAP3MONITOR1_outdelay,
	DFETAP4MONITOR0  =>  DFETAP4MONITOR0_outdelay,
	DFETAP4MONITOR1  =>  DFETAP4MONITOR1_outdelay,
	DO  =>  DO_outdelay,
	DRDY  =>  DRDY_outdelay,
	PHYSTATUS0  =>  PHYSTATUS0_outdelay,
	PHYSTATUS1  =>  PHYSTATUS1_outdelay,
	PLLLKDET  =>  PLLLKDET_outdelay,
	REFCLKOUT  =>  REFCLKOUT_outdelay,
	RESETDONE0  =>  RESETDONE0_outdelay,
	RESETDONE1  =>  RESETDONE1_outdelay,
	RXBUFSTATUS0  =>  RXBUFSTATUS0_outdelay,
	RXBUFSTATUS1  =>  RXBUFSTATUS1_outdelay,
	RXBYTEISALIGNED0  =>  RXBYTEISALIGNED0_outdelay,
	RXBYTEISALIGNED1  =>  RXBYTEISALIGNED1_outdelay,
	RXBYTEREALIGN0  =>  RXBYTEREALIGN0_outdelay,
	RXBYTEREALIGN1  =>  RXBYTEREALIGN1_outdelay,
	RXCHANBONDSEQ0  =>  RXCHANBONDSEQ0_outdelay,
	RXCHANBONDSEQ1  =>  RXCHANBONDSEQ1_outdelay,
	RXCHANISALIGNED0  =>  RXCHANISALIGNED0_outdelay,
	RXCHANISALIGNED1  =>  RXCHANISALIGNED1_outdelay,
	RXCHANREALIGN0  =>  RXCHANREALIGN0_outdelay,
	RXCHANREALIGN1  =>  RXCHANREALIGN1_outdelay,
	RXCHARISCOMMA0  =>  RXCHARISCOMMA0_outdelay,
	RXCHARISCOMMA1  =>  RXCHARISCOMMA1_outdelay,
	RXCHARISK0  =>  RXCHARISK0_outdelay,
	RXCHARISK1  =>  RXCHARISK1_outdelay,
	RXCHBONDO0  =>  RXCHBONDO0_outdelay,
	RXCHBONDO1  =>  RXCHBONDO1_outdelay,
	RXCLKCORCNT0  =>  RXCLKCORCNT0_outdelay,
	RXCLKCORCNT1  =>  RXCLKCORCNT1_outdelay,
	RXCOMMADET0  =>  RXCOMMADET0_outdelay,
	RXCOMMADET1  =>  RXCOMMADET1_outdelay,
	RXDATA0  =>  RXDATA0_outdelay,
	RXDATA1  =>  RXDATA1_outdelay,
	RXDATAVALID0  =>  RXDATAVALID0_outdelay,
	RXDATAVALID1  =>  RXDATAVALID1_outdelay,
	RXDISPERR0  =>  RXDISPERR0_outdelay,
	RXDISPERR1  =>  RXDISPERR1_outdelay,
	RXELECIDLE0  =>  RXELECIDLE0_outdelay,
	RXELECIDLE1  =>  RXELECIDLE1_outdelay,
	RXHEADER0  =>  RXHEADER0_outdelay,
	RXHEADER1  =>  RXHEADER1_outdelay,
	RXHEADERVALID0  =>  RXHEADERVALID0_outdelay,
	RXHEADERVALID1  =>  RXHEADERVALID1_outdelay,
	RXLOSSOFSYNC0  =>  RXLOSSOFSYNC0_outdelay,
	RXLOSSOFSYNC1  =>  RXLOSSOFSYNC1_outdelay,
	RXNOTINTABLE0  =>  RXNOTINTABLE0_outdelay,
	RXNOTINTABLE1  =>  RXNOTINTABLE1_outdelay,
	RXOVERSAMPLEERR0  =>  RXOVERSAMPLEERR0_outdelay,
	RXOVERSAMPLEERR1  =>  RXOVERSAMPLEERR1_outdelay,
	RXPRBSERR0  =>  RXPRBSERR0_outdelay,
	RXPRBSERR1  =>  RXPRBSERR1_outdelay,
	RXRECCLK0  =>  RXRECCLK0_outdelay,
	RXRECCLK1  =>  RXRECCLK1_outdelay,
	RXRUNDISP0  =>  RXRUNDISP0_outdelay,
	RXRUNDISP1  =>  RXRUNDISP1_outdelay,
	RXSTARTOFSEQ0  =>  RXSTARTOFSEQ0_outdelay,
	RXSTARTOFSEQ1  =>  RXSTARTOFSEQ1_outdelay,
	RXSTATUS0  =>  RXSTATUS0_outdelay,
	RXSTATUS1  =>  RXSTATUS1_outdelay,
	RXVALID0  =>  RXVALID0_outdelay,
	RXVALID1  =>  RXVALID1_outdelay,
	TXBUFSTATUS0  =>  TXBUFSTATUS0_outdelay,
	TXBUFSTATUS1  =>  TXBUFSTATUS1_outdelay,
	TXGEARBOXREADY0  =>  TXGEARBOXREADY0_outdelay,
	TXGEARBOXREADY1  =>  TXGEARBOXREADY1_outdelay,
	TXKERR0  =>  TXKERR0_outdelay,
	TXKERR1  =>  TXKERR1_outdelay,
	TXN0  =>  TXN0_outdelay,
	TXN1  =>  TXN1_outdelay,
	TXOUTCLK0  =>  TXOUTCLK0_outdelay,
	TXOUTCLK1  =>  TXOUTCLK1_outdelay,
	TXP0  =>  TXP0_outdelay,
	TXP1  =>  TXP1_outdelay,
	TXRUNDISP0  =>  TXRUNDISP0_outdelay,
	TXRUNDISP1  =>  TXRUNDISP1_outdelay,

	CLKIN  =>  CLKIN_indelay,
	DADDR  =>  DADDR_indelay,
	DCLK  =>  DCLK_indelay,
	DEN  =>  DEN_indelay,
	DFECLKDLYADJ0  =>  DFECLKDLYADJ0_indelay,
	DFECLKDLYADJ1  =>  DFECLKDLYADJ1_indelay,
	DFETAP10  =>  DFETAP10_indelay,
	DFETAP11  =>  DFETAP11_indelay,
	DFETAP20  =>  DFETAP20_indelay,
	DFETAP21  =>  DFETAP21_indelay,
	DFETAP30  =>  DFETAP30_indelay,
	DFETAP31  =>  DFETAP31_indelay,
	DFETAP40  =>  DFETAP40_indelay,
	DFETAP41  =>  DFETAP41_indelay,
	DI  =>  DI_indelay,
	DWE  =>  DWE_indelay,
-- <!--Aldec correction start
	GSR  =>  GSR_local,
-- Aldec correction end -->
	GTXRESET  =>  GTXRESET_indelay,
	GTXTEST  =>  GTXTEST_indelay,
	INTDATAWIDTH  =>  INTDATAWIDTH_indelay,
	LOOPBACK0  =>  LOOPBACK0_indelay,
	LOOPBACK1  =>  LOOPBACK1_indelay,
	PLLLKDETEN  =>  PLLLKDETEN_indelay,
	PLLPOWERDOWN  =>  PLLPOWERDOWN_indelay,
	PRBSCNTRESET0  =>  PRBSCNTRESET0_indelay,
	PRBSCNTRESET1  =>  PRBSCNTRESET1_indelay,
	REFCLKPWRDNB  =>  REFCLKPWRDNB_indelay,
	RXBUFRESET0  =>  RXBUFRESET0_indelay,
	RXBUFRESET1  =>  RXBUFRESET1_indelay,
	RXCDRRESET0  =>  RXCDRRESET0_indelay,
	RXCDRRESET1  =>  RXCDRRESET1_indelay,
	RXCHBONDI0  =>  RXCHBONDI0_indelay,
	RXCHBONDI1  =>  RXCHBONDI1_indelay,
	RXCOMMADETUSE0  =>  RXCOMMADETUSE0_indelay,
	RXCOMMADETUSE1  =>  RXCOMMADETUSE1_indelay,
	RXDATAWIDTH0  =>  RXDATAWIDTH0_indelay,
	RXDATAWIDTH1  =>  RXDATAWIDTH1_indelay,
	RXDEC8B10BUSE0  =>  RXDEC8B10BUSE0_indelay,
	RXDEC8B10BUSE1  =>  RXDEC8B10BUSE1_indelay,
	RXENCHANSYNC0  =>  RXENCHANSYNC0_indelay,
	RXENCHANSYNC1  =>  RXENCHANSYNC1_indelay,
	RXENEQB0  =>  RXENEQB0_indelay,
	RXENEQB1  =>  RXENEQB1_indelay,
	RXENMCOMMAALIGN0  =>  RXENMCOMMAALIGN0_indelay,
	RXENMCOMMAALIGN1  =>  RXENMCOMMAALIGN1_indelay,
	RXENPCOMMAALIGN0  =>  RXENPCOMMAALIGN0_indelay,
	RXENPCOMMAALIGN1  =>  RXENPCOMMAALIGN1_indelay,
	RXENPMAPHASEALIGN0  =>  RXENPMAPHASEALIGN0_indelay,
	RXENPMAPHASEALIGN1  =>  RXENPMAPHASEALIGN1_indelay,
	RXENPRBSTST0  =>  RXENPRBSTST0_indelay,
	RXENPRBSTST1  =>  RXENPRBSTST1_indelay,
	RXENSAMPLEALIGN0  =>  RXENSAMPLEALIGN0_indelay,
	RXENSAMPLEALIGN1  =>  RXENSAMPLEALIGN1_indelay,
	RXEQMIX0  =>  RXEQMIX0_indelay,
	RXEQMIX1  =>  RXEQMIX1_indelay,
	RXEQPOLE0  =>  RXEQPOLE0_indelay,
	RXEQPOLE1  =>  RXEQPOLE1_indelay,
	RXGEARBOXSLIP0  =>  RXGEARBOXSLIP0_indelay,
	RXGEARBOXSLIP1  =>  RXGEARBOXSLIP1_indelay,
	RXN0  =>  RXN0_indelay,
	RXN1  =>  RXN1_indelay,
	RXP0  =>  RXP0_indelay,
	RXP1  =>  RXP1_indelay,
	RXPMASETPHASE0  =>  RXPMASETPHASE0_indelay,
	RXPMASETPHASE1  =>  RXPMASETPHASE1_indelay,
	RXPOLARITY0  =>  RXPOLARITY0_indelay,
	RXPOLARITY1  =>  RXPOLARITY1_indelay,
	RXPOWERDOWN0  =>  RXPOWERDOWN0_indelay,
	RXPOWERDOWN1  =>  RXPOWERDOWN1_indelay,
	RXRESET0  =>  RXRESET0_indelay,
	RXRESET1  =>  RXRESET1_indelay,
	RXSLIDE0  =>  RXSLIDE0_indelay,
	RXSLIDE1  =>  RXSLIDE1_indelay,
	RXUSRCLK0  =>  RXUSRCLK0_indelay,
	RXUSRCLK1  =>  RXUSRCLK1_indelay,
	RXUSRCLK20  =>  RXUSRCLK20_indelay,
	RXUSRCLK21  =>  RXUSRCLK21_indelay,
	TXBUFDIFFCTRL0  =>  TXBUFDIFFCTRL0_indelay,
	TXBUFDIFFCTRL1  =>  TXBUFDIFFCTRL1_indelay,
	TXBYPASS8B10B0  =>  TXBYPASS8B10B0_indelay,
	TXBYPASS8B10B1  =>  TXBYPASS8B10B1_indelay,
	TXCHARDISPMODE0  =>  TXCHARDISPMODE0_indelay,
	TXCHARDISPMODE1  =>  TXCHARDISPMODE1_indelay,
	TXCHARDISPVAL0  =>  TXCHARDISPVAL0_indelay,
	TXCHARDISPVAL1  =>  TXCHARDISPVAL1_indelay,
	TXCHARISK0  =>  TXCHARISK0_indelay,
	TXCHARISK1  =>  TXCHARISK1_indelay,
	TXCOMSTART0  =>  TXCOMSTART0_indelay,
	TXCOMSTART1  =>  TXCOMSTART1_indelay,
	TXCOMTYPE0  =>  TXCOMTYPE0_indelay,
	TXCOMTYPE1  =>  TXCOMTYPE1_indelay,
	TXDATA0  =>  TXDATA0_indelay,
	TXDATA1  =>  TXDATA1_indelay,
	TXDATAWIDTH0  =>  TXDATAWIDTH0_indelay,
	TXDATAWIDTH1  =>  TXDATAWIDTH1_indelay,
	TXDETECTRX0  =>  TXDETECTRX0_indelay,
	TXDETECTRX1  =>  TXDETECTRX1_indelay,
	TXDIFFCTRL0  =>  TXDIFFCTRL0_indelay,
	TXDIFFCTRL1  =>  TXDIFFCTRL1_indelay,
	TXELECIDLE0  =>  TXELECIDLE0_indelay,
	TXELECIDLE1  =>  TXELECIDLE1_indelay,
	TXENC8B10BUSE0  =>  TXENC8B10BUSE0_indelay,
	TXENC8B10BUSE1  =>  TXENC8B10BUSE1_indelay,
	TXENPMAPHASEALIGN0  =>  TXENPMAPHASEALIGN0_indelay,
	TXENPMAPHASEALIGN1  =>  TXENPMAPHASEALIGN1_indelay,
	TXENPRBSTST0  =>  TXENPRBSTST0_indelay,
	TXENPRBSTST1  =>  TXENPRBSTST1_indelay,
	TXHEADER0  =>  TXHEADER0_indelay,
	TXHEADER1  =>  TXHEADER1_indelay,
	TXINHIBIT0  =>  TXINHIBIT0_indelay,
	TXINHIBIT1  =>  TXINHIBIT1_indelay,
	TXPMASETPHASE0  =>  TXPMASETPHASE0_indelay,
	TXPMASETPHASE1  =>  TXPMASETPHASE1_indelay,
	TXPOLARITY0  =>  TXPOLARITY0_indelay,
	TXPOLARITY1  =>  TXPOLARITY1_indelay,
	TXPOWERDOWN0  =>  TXPOWERDOWN0_indelay,
	TXPOWERDOWN1  =>  TXPOWERDOWN1_indelay,
	TXPREEMPHASIS0  =>  TXPREEMPHASIS0_indelay,
	TXPREEMPHASIS1  =>  TXPREEMPHASIS1_indelay,
	TXRESET0  =>  TXRESET0_indelay,
	TXRESET1  =>  TXRESET1_indelay,
	TXSEQUENCE0  =>  TXSEQUENCE0_indelay,
	TXSEQUENCE1  =>  TXSEQUENCE1_indelay,
	TXSTARTSEQ0  =>  TXSTARTSEQ0_indelay,
	TXSTARTSEQ1  =>  TXSTARTSEQ1_indelay,
	TXUSRCLK0  =>  TXUSRCLK0_indelay,
	TXUSRCLK1  =>  TXUSRCLK1_indelay,
	TXUSRCLK20  =>  TXUSRCLK20_indelay,
	TXUSRCLK21  =>  TXUSRCLK21_indelay
	);

        
	INIPROC : process
	begin
       case PLL_TXDIVSEL_OUT_0 is
           when   1  =>  PLL_TXDIVSEL_OUT_0_BINARY <= "00";
           when   2  =>  PLL_TXDIVSEL_OUT_0_BINARY <= "01";
           when   4  =>  PLL_TXDIVSEL_OUT_0_BINARY <= "10";
           when others  =>  assert FALSE report "Error : PLL_TXDIVSEL_OUT_0 is not in 1, 2, 4." severity error;
       end case;
       case PLL_RXDIVSEL_OUT_0 is
           when   1  =>  PLL_RXDIVSEL_OUT_0_BINARY <= "00";
           when   2  =>  PLL_RXDIVSEL_OUT_0_BINARY <= "01";
           when   4  =>  PLL_RXDIVSEL_OUT_0_BINARY <= "10";
           when others  =>  assert FALSE report "Error : PLL_RXDIVSEL_OUT_0 is not in 1, 2, 4." severity error;
       end case;
       case PLL_TXDIVSEL_OUT_1 is
           when   1  =>  PLL_TXDIVSEL_OUT_1_BINARY <= "00";
           when   2  =>  PLL_TXDIVSEL_OUT_1_BINARY <= "01";
           when   4  =>  PLL_TXDIVSEL_OUT_1_BINARY <= "10";
           when others  =>  assert FALSE report "Error : PLL_TXDIVSEL_OUT_1 is not in 1, 2, 4." severity error;
       end case;
       case PLL_RXDIVSEL_OUT_1 is
           when   1  =>  PLL_RXDIVSEL_OUT_1_BINARY <= "00";
           when   2  =>  PLL_RXDIVSEL_OUT_1_BINARY <= "01";
           when   4  =>  PLL_RXDIVSEL_OUT_1_BINARY <= "10";
           when others  =>  assert FALSE report "Error : PLL_RXDIVSEL_OUT_1 is not in 1, 2, 4." severity error;
       end case;
       case PLL_DIVSEL_FB is
           when   1  =>  PLL_DIVSEL_FB_BINARY <= "10000";
           when   2  =>  PLL_DIVSEL_FB_BINARY <= "00000";
           when   3  =>  PLL_DIVSEL_FB_BINARY <= "00001";
           when   4  =>  PLL_DIVSEL_FB_BINARY <= "00010";
           when   5  =>  PLL_DIVSEL_FB_BINARY <= "00011";
           when   8  =>  PLL_DIVSEL_FB_BINARY <= "00110";
           when   10  =>  PLL_DIVSEL_FB_BINARY <= "00111";
           when others  =>  assert FALSE report "Error : PLL_DIVSEL_FB is not in 1, 2, 3, 4, 5, 8, 10." severity error;
       end case;
       case PLL_DIVSEL_REF is
           when   1  =>  PLL_DIVSEL_REF_BINARY <= "010000";
           when   2  =>  PLL_DIVSEL_REF_BINARY <= "000000";
           when   3  =>  PLL_DIVSEL_REF_BINARY <= "000001";
           when   4  =>  PLL_DIVSEL_REF_BINARY <= "000010";
           when   5  =>  PLL_DIVSEL_REF_BINARY <= "000011";
           when   6  =>  PLL_DIVSEL_REF_BINARY <= "000101";
           when   8  =>  PLL_DIVSEL_REF_BINARY <= "000110";
           when   10  =>  PLL_DIVSEL_REF_BINARY <= "000111";
           when   12  =>  PLL_DIVSEL_REF_BINARY <= "001101";
           when   16  =>  PLL_DIVSEL_REF_BINARY <= "001110";
           when   20  =>  PLL_DIVSEL_REF_BINARY <= "001111";
           when others  =>  assert FALSE report "Error : PLL_DIVSEL_REF is not in 1, 2, 3, 4, 5, 6, 8, 10, 12, 16, 20." severity error;
       end case;
       case PLL_SATA_0 is
           when FALSE   =>  PLL_SATA_0_BINARY <= '0';
           when TRUE    =>  PLL_SATA_0_BINARY <= '1';
           when others  =>  assert FALSE report "Error : PLL_SATA_0 is neither TRUE nor FALSE." severity error;
       end case;
       case PLL_SATA_1 is
           when FALSE   =>  PLL_SATA_1_BINARY <= '0';
           when TRUE    =>  PLL_SATA_1_BINARY <= '1';
           when others  =>  assert FALSE report "Error : PLL_SATA_1 is neither TRUE nor FALSE." severity error;
       end case;
       case OOB_CLK_DIVIDER is
           when   1  =>  OOB_CLK_DIVIDER_BINARY <= "000";
           when   2  =>  OOB_CLK_DIVIDER_BINARY <= "001";
           when   4  =>  OOB_CLK_DIVIDER_BINARY <= "010";
           when   6  =>  OOB_CLK_DIVIDER_BINARY <= "011";
           when   8  =>  OOB_CLK_DIVIDER_BINARY <= "100";
           when   10  =>  OOB_CLK_DIVIDER_BINARY <= "101";
           when   12  =>  OOB_CLK_DIVIDER_BINARY <= "110";
           when   14  =>  OOB_CLK_DIVIDER_BINARY <= "111";
           when others  =>  assert FALSE report "Error : OOB_CLK_DIVIDER is not in 1, 2, 4, 6, 8, 10, 12, 14." severity error;
       end case;

        if (OOBDETECT_THRESHOLD_0 = "110") then
           OOBDETECT_THRESHOLD_0_BINARY <= "110";
        elsif (OOBDETECT_THRESHOLD_0 = "111") then
           OOBDETECT_THRESHOLD_0_BINARY <= "111";
        else
           assert FALSE report "Warning : OOBDETECT_THRESHOLD_0 is not in 110, 111." severity warning;
        end if;

        if (OOBDETECT_THRESHOLD_1 = "110") then
           OOBDETECT_THRESHOLD_1_BINARY <= "110";
        elsif (OOBDETECT_THRESHOLD_1 = "111") then
           OOBDETECT_THRESHOLD_1_BINARY <= "111";
        else
           assert FALSE report "Warning : OOBDETECT_THRESHOLD_1 is not in 110, 111." severity warning;
        end if;
           
       case AC_CAP_DIS_0 is
           when FALSE   =>  AC_CAP_DIS_0_BINARY <= '0';
           when TRUE    =>  AC_CAP_DIS_0_BINARY <= '1';
           when others  =>  assert FALSE report "Error : AC_CAP_DIS_0 is neither TRUE nor FALSE." severity error;
       end case;
       case AC_CAP_DIS_1 is
           when FALSE   =>  AC_CAP_DIS_1_BINARY <= '0';
           when TRUE    =>  AC_CAP_DIS_1_BINARY <= '1';
           when others  =>  assert FALSE report "Error : AC_CAP_DIS_1 is neither TRUE nor FALSE." severity error;
       end case;
       case RCV_TERM_GND_0 is
           when FALSE   =>  RCV_TERM_GND_0_BINARY <= '0';
           when TRUE    =>  RCV_TERM_GND_0_BINARY <= '1';
           when others  =>  assert FALSE report "Error : RCV_TERM_GND_0 is neither TRUE nor FALSE." severity error;
       end case;
       case RCV_TERM_GND_1 is
           when FALSE   =>  RCV_TERM_GND_1_BINARY <= '0';
           when TRUE    =>  RCV_TERM_GND_1_BINARY <= '1';
           when others  =>  assert FALSE report "Error : RCV_TERM_GND_1 is neither TRUE nor FALSE." severity error;
       end case;
       case TERMINATION_IMP_0 is
           when   50  =>  TERMINATION_IMP_0_BINARY <= '0';
           when   75  =>  TERMINATION_IMP_0_BINARY <= '1';
           when others  =>  assert FALSE report "Error : TERMINATION_IMP_0 is not in 50, 75." severity error;
       end case;
       case TERMINATION_IMP_1 is
           when   50  =>  TERMINATION_IMP_1_BINARY <= '0';
           when   75  =>  TERMINATION_IMP_1_BINARY <= '1';
           when others  =>  assert FALSE report "Error : TERMINATION_IMP_1 is not in 50, 75." severity error;
       end case;
       case TERMINATION_OVRD is
           when FALSE   =>  TERMINATION_OVRD_BINARY <= '0';
           when TRUE    =>  TERMINATION_OVRD_BINARY <= '1';
           when others  =>  assert FALSE report "Error : TERMINATION_OVRD is neither TRUE nor FALSE." severity error;
       end case;
       case RCV_TERM_VTTRX_0 is
           when FALSE   =>  RCV_TERM_VTTRX_0_BINARY <= '0';
           when TRUE    =>  RCV_TERM_VTTRX_0_BINARY <= '1';
           when others  =>  assert FALSE report "Error : RCV_TERM_VTTRX_0 is neither TRUE nor FALSE." severity error;
       end case;
       case RCV_TERM_VTTRX_1 is
           when FALSE   =>  RCV_TERM_VTTRX_1_BINARY <= '0';
           when TRUE    =>  RCV_TERM_VTTRX_1_BINARY <= '1';
           when others  =>  assert FALSE report "Error : RCV_TERM_VTTRX_1 is neither TRUE nor FALSE." severity error;
       end case;
       case CLKINDC_B is
           when FALSE   =>  CLKINDC_B_BINARY <= '0';
           when TRUE    =>  CLKINDC_B_BINARY <= '1';
           when others  =>  assert FALSE report "Error : CLKINDC_B is neither TRUE nor FALSE." severity error;
       end case;
       case PCOMMA_DETECT_0 is
           when FALSE   =>  PCOMMA_DETECT_0_BINARY <= '0';
           when TRUE    =>  PCOMMA_DETECT_0_BINARY <= '1';
           when others  =>  assert FALSE report "Error : PCOMMA_DETECT_0 is neither TRUE nor FALSE." severity error;
       end case;
       case MCOMMA_DETECT_0 is
           when FALSE   =>  MCOMMA_DETECT_0_BINARY <= '0';
           when TRUE    =>  MCOMMA_DETECT_0_BINARY <= '1';
           when others  =>  assert FALSE report "Error : MCOMMA_DETECT_0 is neither TRUE nor FALSE." severity error;
       end case;
       case COMMA_DOUBLE_0 is
           when FALSE   =>  COMMA_DOUBLE_0_BINARY <= '0';
           when TRUE    =>  COMMA_DOUBLE_0_BINARY <= '1';
           when others  =>  assert FALSE report "Error : COMMA_DOUBLE_0 is neither TRUE nor FALSE." severity error;
       end case;
       case ALIGN_COMMA_WORD_0 is
           when   1  =>  ALIGN_COMMA_WORD_0_BINARY <= '0';
           when   2  =>  ALIGN_COMMA_WORD_0_BINARY <= '1';
           when others  =>  assert FALSE report "Error : ALIGN_COMMA_WORD_0 is not in 1, 2." severity error;
       end case;
       case DEC_PCOMMA_DETECT_0 is
           when FALSE   =>  DEC_PCOMMA_DETECT_0_BINARY <= '0';
           when TRUE    =>  DEC_PCOMMA_DETECT_0_BINARY <= '1';
           when others  =>  assert FALSE report "Error : DEC_PCOMMA_DETECT_0 is neither TRUE nor FALSE." severity error;
       end case;
       case DEC_MCOMMA_DETECT_0 is
           when FALSE   =>  DEC_MCOMMA_DETECT_0_BINARY <= '0';
           when TRUE    =>  DEC_MCOMMA_DETECT_0_BINARY <= '1';
           when others  =>  assert FALSE report "Error : DEC_MCOMMA_DETECT_0 is neither TRUE nor FALSE." severity error;
       end case;
       case DEC_VALID_COMMA_ONLY_0 is
           when FALSE   =>  DEC_VALID_COMMA_ONLY_0_BINARY <= '0';
           when TRUE    =>  DEC_VALID_COMMA_ONLY_0_BINARY <= '1';
           when others  =>  assert FALSE report "Error : DEC_VALID_COMMA_ONLY_0 is neither TRUE nor FALSE." severity error;
       end case;
       case PCOMMA_DETECT_1 is
           when FALSE   =>  PCOMMA_DETECT_1_BINARY <= '0';
           when TRUE    =>  PCOMMA_DETECT_1_BINARY <= '1';
           when others  =>  assert FALSE report "Error : PCOMMA_DETECT_1 is neither TRUE nor FALSE." severity error;
       end case;
       case MCOMMA_DETECT_1 is
           when FALSE   =>  MCOMMA_DETECT_1_BINARY <= '0';
           when TRUE    =>  MCOMMA_DETECT_1_BINARY <= '1';
           when others  =>  assert FALSE report "Error : MCOMMA_DETECT_1 is neither TRUE nor FALSE." severity error;
       end case;
       case COMMA_DOUBLE_1 is
           when FALSE   =>  COMMA_DOUBLE_1_BINARY <= '0';
           when TRUE    =>  COMMA_DOUBLE_1_BINARY <= '1';
           when others  =>  assert FALSE report "Error : COMMA_DOUBLE_1 is neither TRUE nor FALSE." severity error;
       end case;
       case ALIGN_COMMA_WORD_1 is
           when   1  =>  ALIGN_COMMA_WORD_1_BINARY <= '0';
           when   2  =>  ALIGN_COMMA_WORD_1_BINARY <= '1';
           when others  =>  assert FALSE report "Error : ALIGN_COMMA_WORD_1 is not in 1, 2." severity error;
       end case;
       case DEC_PCOMMA_DETECT_1 is
           when FALSE   =>  DEC_PCOMMA_DETECT_1_BINARY <= '0';
           when TRUE    =>  DEC_PCOMMA_DETECT_1_BINARY <= '1';
           when others  =>  assert FALSE report "Error : DEC_PCOMMA_DETECT_1 is neither TRUE nor FALSE." severity error;
       end case;
       case DEC_MCOMMA_DETECT_1 is
           when FALSE   =>  DEC_MCOMMA_DETECT_1_BINARY <= '0';
           when TRUE    =>  DEC_MCOMMA_DETECT_1_BINARY <= '1';
           when others  =>  assert FALSE report "Error : DEC_MCOMMA_DETECT_1 is neither TRUE nor FALSE." severity error;
       end case;
       case DEC_VALID_COMMA_ONLY_1 is
           when FALSE   =>  DEC_VALID_COMMA_ONLY_1_BINARY <= '0';
           when TRUE    =>  DEC_VALID_COMMA_ONLY_1_BINARY <= '1';
           when others  =>  assert FALSE report "Error : DEC_VALID_COMMA_ONLY_1 is neither TRUE nor FALSE." severity error;
       end case;
       case RX_LOSS_OF_SYNC_FSM_0 is
           when FALSE   =>  RX_LOSS_OF_SYNC_FSM_0_BINARY <= '0';
           when TRUE    =>  RX_LOSS_OF_SYNC_FSM_0_BINARY <= '1';
           when others  =>  assert FALSE report "Error : RX_LOSS_OF_SYNC_FSM_0 is neither TRUE nor FALSE." severity error;
       end case;
       case RX_LOS_INVALID_INCR_0 is
           when   1  =>  RX_LOS_INVALID_INCR_0_BINARY <= "000";
           when   2  =>  RX_LOS_INVALID_INCR_0_BINARY <= "001";
           when   4  =>  RX_LOS_INVALID_INCR_0_BINARY <= "010";
           when   8  =>  RX_LOS_INVALID_INCR_0_BINARY <= "011";
           when   16  =>  RX_LOS_INVALID_INCR_0_BINARY <= "100";
           when   32  =>  RX_LOS_INVALID_INCR_0_BINARY <= "101";
           when   64  =>  RX_LOS_INVALID_INCR_0_BINARY <= "110";
           when   128  =>  RX_LOS_INVALID_INCR_0_BINARY <= "111";
           when others  =>  assert FALSE report "Error : RX_LOS_INVALID_INCR_0 is not in 1, 2, 4, 8, 16, 32, 64, 128." severity error;
       end case;
       case RX_LOS_THRESHOLD_0 is
           when   4  =>  RX_LOS_THRESHOLD_0_BINARY <= "000";
           when   8  =>  RX_LOS_THRESHOLD_0_BINARY <= "001";
           when   16  =>  RX_LOS_THRESHOLD_0_BINARY <= "010";
           when   32  =>  RX_LOS_THRESHOLD_0_BINARY <= "011";
           when   64  =>  RX_LOS_THRESHOLD_0_BINARY <= "100";
           when   128  =>  RX_LOS_THRESHOLD_0_BINARY <= "101";
           when   256  =>  RX_LOS_THRESHOLD_0_BINARY <= "110";
           when   512  =>  RX_LOS_THRESHOLD_0_BINARY <= "111";
           when others  =>  assert FALSE report "Error : RX_LOS_THRESHOLD_0 is not in 4, 8, 16, 32, 64, 128, 256, 512." severity error;
       end case;
       case RX_LOSS_OF_SYNC_FSM_1 is
           when FALSE   =>  RX_LOSS_OF_SYNC_FSM_1_BINARY <= '0';
           when TRUE    =>  RX_LOSS_OF_SYNC_FSM_1_BINARY <= '1';
           when others  =>  assert FALSE report "Error : RX_LOSS_OF_SYNC_FSM_1 is neither TRUE nor FALSE." severity error;
       end case;
       case RX_LOS_INVALID_INCR_1 is
           when   1  =>  RX_LOS_INVALID_INCR_1_BINARY <= "000";
           when   2  =>  RX_LOS_INVALID_INCR_1_BINARY <= "001";
           when   4  =>  RX_LOS_INVALID_INCR_1_BINARY <= "010";
           when   8  =>  RX_LOS_INVALID_INCR_1_BINARY <= "011";
           when   16  =>  RX_LOS_INVALID_INCR_1_BINARY <= "100";
           when   32  =>  RX_LOS_INVALID_INCR_1_BINARY <= "101";
           when   64  =>  RX_LOS_INVALID_INCR_1_BINARY <= "110";
           when   128  =>  RX_LOS_INVALID_INCR_1_BINARY <= "111";
           when others  =>  assert FALSE report "Error : RX_LOS_INVALID_INCR_1 is not in 1, 2, 4, 8, 16, 32, 64, 128." severity error;
       end case;
       case RX_LOS_THRESHOLD_1 is
           when   4  =>  RX_LOS_THRESHOLD_1_BINARY <= "000";
           when   8  =>  RX_LOS_THRESHOLD_1_BINARY <= "001";
           when   16  =>  RX_LOS_THRESHOLD_1_BINARY <= "010";
           when   32  =>  RX_LOS_THRESHOLD_1_BINARY <= "011";
           when   64  =>  RX_LOS_THRESHOLD_1_BINARY <= "100";
           when   128  =>  RX_LOS_THRESHOLD_1_BINARY <= "101";
           when   256  =>  RX_LOS_THRESHOLD_1_BINARY <= "110";
           when   512  =>  RX_LOS_THRESHOLD_1_BINARY <= "111";
           when others  =>  assert FALSE report "Error : RX_LOS_THRESHOLD_1 is not in 4, 8, 16, 32, 64, 128, 256, 512." severity error;
       end case;
       case RX_BUFFER_USE_0 is
           when FALSE   =>  RX_BUFFER_USE_0_BINARY <= '0';
           when TRUE    =>  RX_BUFFER_USE_0_BINARY <= '1';
           when others  =>  assert FALSE report "Error : RX_BUFFER_USE_0 is neither TRUE nor FALSE." severity error;
       end case;
       case RX_DECODE_SEQ_MATCH_0 is
           when FALSE   =>  RX_DECODE_SEQ_MATCH_0_BINARY <= '0';
           when TRUE    =>  RX_DECODE_SEQ_MATCH_0_BINARY <= '1';
           when others  =>  assert FALSE report "Error : RX_DECODE_SEQ_MATCH_0 is neither TRUE nor FALSE." severity error;
       end case;
       case RX_BUFFER_USE_1 is
           when FALSE   =>  RX_BUFFER_USE_1_BINARY <= '0';
           when TRUE    =>  RX_BUFFER_USE_1_BINARY <= '1';
           when others  =>  assert FALSE report "Error : RX_BUFFER_USE_1 is neither TRUE nor FALSE." severity error;
       end case;
       case RX_DECODE_SEQ_MATCH_1 is
           when FALSE   =>  RX_DECODE_SEQ_MATCH_1_BINARY <= '0';
           when TRUE    =>  RX_DECODE_SEQ_MATCH_1_BINARY <= '1';
           when others  =>  assert FALSE report "Error : RX_DECODE_SEQ_MATCH_1 is neither TRUE nor FALSE." severity error;
       end case;
       case CLK_COR_MIN_LAT_0 is
           when   3  =>  CLK_COR_MIN_LAT_0_BINARY <= "000011";
           when   4  =>  CLK_COR_MIN_LAT_0_BINARY <= "000100";
           when   5  =>  CLK_COR_MIN_LAT_0_BINARY <= "000101";
           when   6  =>  CLK_COR_MIN_LAT_0_BINARY <= "000110";
           when   7  =>  CLK_COR_MIN_LAT_0_BINARY <= "000111";
           when   8  =>  CLK_COR_MIN_LAT_0_BINARY <= "001000";
           when   9  =>  CLK_COR_MIN_LAT_0_BINARY <= "001001";
           when   10  =>  CLK_COR_MIN_LAT_0_BINARY <= "001010";
           when   11  =>  CLK_COR_MIN_LAT_0_BINARY <= "001011";
           when   12  =>  CLK_COR_MIN_LAT_0_BINARY <= "001100";
           when   13  =>  CLK_COR_MIN_LAT_0_BINARY <= "001101";
           when   14  =>  CLK_COR_MIN_LAT_0_BINARY <= "001110";
           when   15  =>  CLK_COR_MIN_LAT_0_BINARY <= "001111";
           when   16  =>  CLK_COR_MIN_LAT_0_BINARY <= "010000";
           when   17  =>  CLK_COR_MIN_LAT_0_BINARY <= "010001";
           when   18  =>  CLK_COR_MIN_LAT_0_BINARY <= "010010";
           when   19  =>  CLK_COR_MIN_LAT_0_BINARY <= "010011";
           when   20  =>  CLK_COR_MIN_LAT_0_BINARY <= "010100";
           when   21  =>  CLK_COR_MIN_LAT_0_BINARY <= "010101";
           when   22  =>  CLK_COR_MIN_LAT_0_BINARY <= "010110";
           when   23  =>  CLK_COR_MIN_LAT_0_BINARY <= "010111";
           when   24  =>  CLK_COR_MIN_LAT_0_BINARY <= "011000";
           when   25  =>  CLK_COR_MIN_LAT_0_BINARY <= "011001";
           when   26  =>  CLK_COR_MIN_LAT_0_BINARY <= "011010";
           when   27  =>  CLK_COR_MIN_LAT_0_BINARY <= "011011";
           when   28  =>  CLK_COR_MIN_LAT_0_BINARY <= "011100";
           when   29  =>  CLK_COR_MIN_LAT_0_BINARY <= "011101";
           when   30  =>  CLK_COR_MIN_LAT_0_BINARY <= "011110";
           when   31  =>  CLK_COR_MIN_LAT_0_BINARY <= "011111";
           when   32  =>  CLK_COR_MIN_LAT_0_BINARY <= "100000";
           when   33  =>  CLK_COR_MIN_LAT_0_BINARY <= "100001";
           when   34  =>  CLK_COR_MIN_LAT_0_BINARY <= "100010";
           when   35  =>  CLK_COR_MIN_LAT_0_BINARY <= "100011";
           when   36  =>  CLK_COR_MIN_LAT_0_BINARY <= "100100";
           when   37  =>  CLK_COR_MIN_LAT_0_BINARY <= "100101";
           when   38  =>  CLK_COR_MIN_LAT_0_BINARY <= "100110";
           when   39  =>  CLK_COR_MIN_LAT_0_BINARY <= "100111";
           when   40  =>  CLK_COR_MIN_LAT_0_BINARY <= "101000";
           when   41  =>  CLK_COR_MIN_LAT_0_BINARY <= "101001";
           when   42  =>  CLK_COR_MIN_LAT_0_BINARY <= "101010";
           when   43  =>  CLK_COR_MIN_LAT_0_BINARY <= "101011";
           when   44  =>  CLK_COR_MIN_LAT_0_BINARY <= "101100";
           when   45  =>  CLK_COR_MIN_LAT_0_BINARY <= "101101";
           when   46  =>  CLK_COR_MIN_LAT_0_BINARY <= "101110";
           when   47  =>  CLK_COR_MIN_LAT_0_BINARY <= "101111";
           when   48  =>  CLK_COR_MIN_LAT_0_BINARY <= "110000";
           when others  =>  assert FALSE report "Error : CLK_COR_MIN_LAT_0 is not in range 3...48." severity error;
       end case;
       case CLK_COR_MAX_LAT_0 is
           when   3  =>  CLK_COR_MAX_LAT_0_BINARY <= "000011";
           when   4  =>  CLK_COR_MAX_LAT_0_BINARY <= "000100";
           when   5  =>  CLK_COR_MAX_LAT_0_BINARY <= "000101";
           when   6  =>  CLK_COR_MAX_LAT_0_BINARY <= "000110";
           when   7  =>  CLK_COR_MAX_LAT_0_BINARY <= "000111";
           when   8  =>  CLK_COR_MAX_LAT_0_BINARY <= "001000";
           when   9  =>  CLK_COR_MAX_LAT_0_BINARY <= "001001";
           when   10  =>  CLK_COR_MAX_LAT_0_BINARY <= "001010";
           when   11  =>  CLK_COR_MAX_LAT_0_BINARY <= "001011";
           when   12  =>  CLK_COR_MAX_LAT_0_BINARY <= "001100";
           when   13  =>  CLK_COR_MAX_LAT_0_BINARY <= "001101";
           when   14  =>  CLK_COR_MAX_LAT_0_BINARY <= "001110";
           when   15  =>  CLK_COR_MAX_LAT_0_BINARY <= "001111";
           when   16  =>  CLK_COR_MAX_LAT_0_BINARY <= "010000";
           when   17  =>  CLK_COR_MAX_LAT_0_BINARY <= "010001";
           when   18  =>  CLK_COR_MAX_LAT_0_BINARY <= "010010";
           when   19  =>  CLK_COR_MAX_LAT_0_BINARY <= "010011";
           when   20  =>  CLK_COR_MAX_LAT_0_BINARY <= "010100";
           when   21  =>  CLK_COR_MAX_LAT_0_BINARY <= "010101";
           when   22  =>  CLK_COR_MAX_LAT_0_BINARY <= "010110";
           when   23  =>  CLK_COR_MAX_LAT_0_BINARY <= "010111";
           when   24  =>  CLK_COR_MAX_LAT_0_BINARY <= "011000";
           when   25  =>  CLK_COR_MAX_LAT_0_BINARY <= "011001";
           when   26  =>  CLK_COR_MAX_LAT_0_BINARY <= "011010";
           when   27  =>  CLK_COR_MAX_LAT_0_BINARY <= "011011";
           when   28  =>  CLK_COR_MAX_LAT_0_BINARY <= "011100";
           when   29  =>  CLK_COR_MAX_LAT_0_BINARY <= "011101";
           when   30  =>  CLK_COR_MAX_LAT_0_BINARY <= "011110";
           when   31  =>  CLK_COR_MAX_LAT_0_BINARY <= "011111";
           when   32  =>  CLK_COR_MAX_LAT_0_BINARY <= "100000";
           when   33  =>  CLK_COR_MAX_LAT_0_BINARY <= "100001";
           when   34  =>  CLK_COR_MAX_LAT_0_BINARY <= "100010";
           when   35  =>  CLK_COR_MAX_LAT_0_BINARY <= "100011";
           when   36  =>  CLK_COR_MAX_LAT_0_BINARY <= "100100";
           when   37  =>  CLK_COR_MAX_LAT_0_BINARY <= "100101";
           when   38  =>  CLK_COR_MAX_LAT_0_BINARY <= "100110";
           when   39  =>  CLK_COR_MAX_LAT_0_BINARY <= "100111";
           when   40  =>  CLK_COR_MAX_LAT_0_BINARY <= "101000";
           when   41  =>  CLK_COR_MAX_LAT_0_BINARY <= "101001";
           when   42  =>  CLK_COR_MAX_LAT_0_BINARY <= "101010";
           when   43  =>  CLK_COR_MAX_LAT_0_BINARY <= "101011";
           when   44  =>  CLK_COR_MAX_LAT_0_BINARY <= "101100";
           when   45  =>  CLK_COR_MAX_LAT_0_BINARY <= "101101";
           when   46  =>  CLK_COR_MAX_LAT_0_BINARY <= "101110";
           when   47  =>  CLK_COR_MAX_LAT_0_BINARY <= "101111";
           when   48  =>  CLK_COR_MAX_LAT_0_BINARY <= "110000";
           when others  =>  assert FALSE report "Error : CLK_COR_MAX_LAT_0 is not in range 3...48." severity error;
       end case;
       case CLK_CORRECT_USE_0 is
           when FALSE   =>  CLK_CORRECT_USE_0_BINARY <= '0';
           when TRUE    =>  CLK_CORRECT_USE_0_BINARY <= '1';
           when others  =>  assert FALSE report "Error : CLK_CORRECT_USE_0 is neither TRUE nor FALSE." severity error;
       end case;
       case CLK_COR_PRECEDENCE_0 is
           when FALSE   =>  CLK_COR_PRECEDENCE_0_BINARY <= '0';
           when TRUE    =>  CLK_COR_PRECEDENCE_0_BINARY <= '1';
           when others  =>  assert FALSE report "Error : CLK_COR_PRECEDENCE_0 is neither TRUE nor FALSE." severity error;
       end case;
       case CLK_COR_DET_LEN_0 is
           when   1  =>  CLK_COR_DET_LEN_0_BINARY <= "00";
           when   2  =>  CLK_COR_DET_LEN_0_BINARY <= "01";
           when   3  =>  CLK_COR_DET_LEN_0_BINARY <= "10";
           when   4  =>  CLK_COR_DET_LEN_0_BINARY <= "11";
           when others  =>  assert FALSE report "Error : CLK_COR_DET_LEN_0 is not in 1, 2, 3, 4." severity error;
       end case;
       case CLK_COR_ADJ_LEN_0 is
           when   1  =>  CLK_COR_ADJ_LEN_0_BINARY <= "00";
           when   2  =>  CLK_COR_ADJ_LEN_0_BINARY <= "01";
           when   3  =>  CLK_COR_ADJ_LEN_0_BINARY <= "10";
           when   4  =>  CLK_COR_ADJ_LEN_0_BINARY <= "11";
           when others  =>  assert FALSE report "Error : CLK_COR_ADJ_LEN_0 is not in 1, 2, 3, 4." severity error;
       end case;
       case CLK_COR_KEEP_IDLE_0 is
           when FALSE   =>  CLK_COR_KEEP_IDLE_0_BINARY <= '0';
           when TRUE    =>  CLK_COR_KEEP_IDLE_0_BINARY <= '1';
           when others  =>  assert FALSE report "Error : CLK_COR_KEEP_IDLE_0 is neither TRUE nor FALSE." severity error;
       end case;
       case CLK_COR_INSERT_IDLE_FLAG_0 is
           when FALSE   =>  CLK_COR_INSERT_IDLE_FLAG_0_BINARY <= '0';
           when TRUE    =>  CLK_COR_INSERT_IDLE_FLAG_0_BINARY <= '1';
           when others  =>  assert FALSE report "Error : CLK_COR_INSERT_IDLE_FLAG_0 is neither TRUE nor FALSE." severity error;
       end case;
       case CLK_COR_REPEAT_WAIT_0 is
           when   0  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "00000";
           when   1  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "00001";
           when   2  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "00010";
           when   3  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "00011";
           when   4  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "00100";
           when   5  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "00101";
           when   6  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "00110";
           when   7  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "00111";
           when   8  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "01000";
           when   9  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "01001";
           when   10  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "01010";
           when   11  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "01011";
           when   12  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "01100";
           when   13  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "01101";
           when   14  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "01110";
           when   15  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "01111";
           when   16  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "10000";
           when   17  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "10001";
           when   18  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "10010";
           when   19  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "10011";
           when   20  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "10100";
           when   21  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "10101";
           when   22  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "10110";
           when   23  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "10111";
           when   24  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "11000";
           when   25  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "11001";
           when   26  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "11010";
           when   27  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "11011";
           when   28  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "11100";
           when   29  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "11101";
           when   30  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "11110";
           when   31  =>  CLK_COR_REPEAT_WAIT_0_BINARY <= "11111";
           when others  =>  assert FALSE report "Error : CLK_COR_REPEAT_WAIT_0 is not in range 0...31." severity error;
       end case;
       case CLK_COR_SEQ_2_USE_0 is
           when FALSE   =>  CLK_COR_SEQ_2_USE_0_BINARY <= '0';
           when TRUE    =>  CLK_COR_SEQ_2_USE_0_BINARY <= '1';
           when others  =>  assert FALSE report "Error : CLK_COR_SEQ_2_USE_0 is neither TRUE nor FALSE." severity error;
       end case;
       case CLK_COR_MIN_LAT_1 is
           when   3  =>  CLK_COR_MIN_LAT_1_BINARY <= "000011";
           when   4  =>  CLK_COR_MIN_LAT_1_BINARY <= "000100";
           when   5  =>  CLK_COR_MIN_LAT_1_BINARY <= "000101";
           when   6  =>  CLK_COR_MIN_LAT_1_BINARY <= "000110";
           when   7  =>  CLK_COR_MIN_LAT_1_BINARY <= "000111";
           when   8  =>  CLK_COR_MIN_LAT_1_BINARY <= "001000";
           when   9  =>  CLK_COR_MIN_LAT_1_BINARY <= "001001";
           when   10  =>  CLK_COR_MIN_LAT_1_BINARY <= "001010";
           when   11  =>  CLK_COR_MIN_LAT_1_BINARY <= "001011";
           when   12  =>  CLK_COR_MIN_LAT_1_BINARY <= "001100";
           when   13  =>  CLK_COR_MIN_LAT_1_BINARY <= "001101";
           when   14  =>  CLK_COR_MIN_LAT_1_BINARY <= "001110";
           when   15  =>  CLK_COR_MIN_LAT_1_BINARY <= "001111";
           when   16  =>  CLK_COR_MIN_LAT_1_BINARY <= "010000";
           when   17  =>  CLK_COR_MIN_LAT_1_BINARY <= "010001";
           when   18  =>  CLK_COR_MIN_LAT_1_BINARY <= "010010";
           when   19  =>  CLK_COR_MIN_LAT_1_BINARY <= "010011";
           when   20  =>  CLK_COR_MIN_LAT_1_BINARY <= "010100";
           when   21  =>  CLK_COR_MIN_LAT_1_BINARY <= "010101";
           when   22  =>  CLK_COR_MIN_LAT_1_BINARY <= "010110";
           when   23  =>  CLK_COR_MIN_LAT_1_BINARY <= "010111";
           when   24  =>  CLK_COR_MIN_LAT_1_BINARY <= "011000";
           when   25  =>  CLK_COR_MIN_LAT_1_BINARY <= "011001";
           when   26  =>  CLK_COR_MIN_LAT_1_BINARY <= "011010";
           when   27  =>  CLK_COR_MIN_LAT_1_BINARY <= "011011";
           when   28  =>  CLK_COR_MIN_LAT_1_BINARY <= "011100";
           when   29  =>  CLK_COR_MIN_LAT_1_BINARY <= "011101";
           when   30  =>  CLK_COR_MIN_LAT_1_BINARY <= "011110";
           when   31  =>  CLK_COR_MIN_LAT_1_BINARY <= "011111";
           when   32  =>  CLK_COR_MIN_LAT_1_BINARY <= "100000";
           when   33  =>  CLK_COR_MIN_LAT_1_BINARY <= "100001";
           when   34  =>  CLK_COR_MIN_LAT_1_BINARY <= "100010";
           when   35  =>  CLK_COR_MIN_LAT_1_BINARY <= "100011";
           when   36  =>  CLK_COR_MIN_LAT_1_BINARY <= "100100";
           when   37  =>  CLK_COR_MIN_LAT_1_BINARY <= "100101";
           when   38  =>  CLK_COR_MIN_LAT_1_BINARY <= "100110";
           when   39  =>  CLK_COR_MIN_LAT_1_BINARY <= "100111";
           when   40  =>  CLK_COR_MIN_LAT_1_BINARY <= "101000";
           when   41  =>  CLK_COR_MIN_LAT_1_BINARY <= "101001";
           when   42  =>  CLK_COR_MIN_LAT_1_BINARY <= "101010";
           when   43  =>  CLK_COR_MIN_LAT_1_BINARY <= "101011";
           when   44  =>  CLK_COR_MIN_LAT_1_BINARY <= "101100";
           when   45  =>  CLK_COR_MIN_LAT_1_BINARY <= "101101";
           when   46  =>  CLK_COR_MIN_LAT_1_BINARY <= "101110";
           when   47  =>  CLK_COR_MIN_LAT_1_BINARY <= "101111";
           when   48  =>  CLK_COR_MIN_LAT_1_BINARY <= "110000";
           when others  =>  assert FALSE report "Error : CLK_COR_MIN_LAT_1 is not in range 3...48." severity error;
       end case;
       case CLK_COR_MAX_LAT_1 is
           when   3  =>  CLK_COR_MAX_LAT_1_BINARY <= "000011";
           when   4  =>  CLK_COR_MAX_LAT_1_BINARY <= "000100";
           when   5  =>  CLK_COR_MAX_LAT_1_BINARY <= "000101";
           when   6  =>  CLK_COR_MAX_LAT_1_BINARY <= "000110";
           when   7  =>  CLK_COR_MAX_LAT_1_BINARY <= "000111";
           when   8  =>  CLK_COR_MAX_LAT_1_BINARY <= "001000";
           when   9  =>  CLK_COR_MAX_LAT_1_BINARY <= "001001";
           when   10  =>  CLK_COR_MAX_LAT_1_BINARY <= "001010";
           when   11  =>  CLK_COR_MAX_LAT_1_BINARY <= "001011";
           when   12  =>  CLK_COR_MAX_LAT_1_BINARY <= "001100";
           when   13  =>  CLK_COR_MAX_LAT_1_BINARY <= "001101";
           when   14  =>  CLK_COR_MAX_LAT_1_BINARY <= "001110";
           when   15  =>  CLK_COR_MAX_LAT_1_BINARY <= "001111";
           when   16  =>  CLK_COR_MAX_LAT_1_BINARY <= "010000";
           when   17  =>  CLK_COR_MAX_LAT_1_BINARY <= "010001";
           when   18  =>  CLK_COR_MAX_LAT_1_BINARY <= "010010";
           when   19  =>  CLK_COR_MAX_LAT_1_BINARY <= "010011";
           when   20  =>  CLK_COR_MAX_LAT_1_BINARY <= "010100";
           when   21  =>  CLK_COR_MAX_LAT_1_BINARY <= "010101";
           when   22  =>  CLK_COR_MAX_LAT_1_BINARY <= "010110";
           when   23  =>  CLK_COR_MAX_LAT_1_BINARY <= "010111";
           when   24  =>  CLK_COR_MAX_LAT_1_BINARY <= "011000";
           when   25  =>  CLK_COR_MAX_LAT_1_BINARY <= "011001";
           when   26  =>  CLK_COR_MAX_LAT_1_BINARY <= "011010";
           when   27  =>  CLK_COR_MAX_LAT_1_BINARY <= "011011";
           when   28  =>  CLK_COR_MAX_LAT_1_BINARY <= "011100";
           when   29  =>  CLK_COR_MAX_LAT_1_BINARY <= "011101";
           when   30  =>  CLK_COR_MAX_LAT_1_BINARY <= "011110";
           when   31  =>  CLK_COR_MAX_LAT_1_BINARY <= "011111";
           when   32  =>  CLK_COR_MAX_LAT_1_BINARY <= "100000";
           when   33  =>  CLK_COR_MAX_LAT_1_BINARY <= "100001";
           when   34  =>  CLK_COR_MAX_LAT_1_BINARY <= "100010";
           when   35  =>  CLK_COR_MAX_LAT_1_BINARY <= "100011";
           when   36  =>  CLK_COR_MAX_LAT_1_BINARY <= "100100";
           when   37  =>  CLK_COR_MAX_LAT_1_BINARY <= "100101";
           when   38  =>  CLK_COR_MAX_LAT_1_BINARY <= "100110";
           when   39  =>  CLK_COR_MAX_LAT_1_BINARY <= "100111";
           when   40  =>  CLK_COR_MAX_LAT_1_BINARY <= "101000";
           when   41  =>  CLK_COR_MAX_LAT_1_BINARY <= "101001";
           when   42  =>  CLK_COR_MAX_LAT_1_BINARY <= "101010";
           when   43  =>  CLK_COR_MAX_LAT_1_BINARY <= "101011";
           when   44  =>  CLK_COR_MAX_LAT_1_BINARY <= "101100";
           when   45  =>  CLK_COR_MAX_LAT_1_BINARY <= "101101";
           when   46  =>  CLK_COR_MAX_LAT_1_BINARY <= "101110";
           when   47  =>  CLK_COR_MAX_LAT_1_BINARY <= "101111";
           when   48  =>  CLK_COR_MAX_LAT_1_BINARY <= "110000";
           when others  =>  assert FALSE report "Error : CLK_COR_MAX_LAT_1 is not in range 3...48." severity error;
       end case;
       case CLK_CORRECT_USE_1 is
           when FALSE   =>  CLK_CORRECT_USE_1_BINARY <= '0';
           when TRUE    =>  CLK_CORRECT_USE_1_BINARY <= '1';
           when others  =>  assert FALSE report "Error : CLK_CORRECT_USE_1 is neither TRUE nor FALSE." severity error;
       end case;
       case CLK_COR_PRECEDENCE_1 is
           when FALSE   =>  CLK_COR_PRECEDENCE_1_BINARY <= '0';
           when TRUE    =>  CLK_COR_PRECEDENCE_1_BINARY <= '1';
           when others  =>  assert FALSE report "Error : CLK_COR_PRECEDENCE_1 is neither TRUE nor FALSE." severity error;
       end case;
       case CLK_COR_DET_LEN_1 is
           when   1  =>  CLK_COR_DET_LEN_1_BINARY <= "00";
           when   2  =>  CLK_COR_DET_LEN_1_BINARY <= "01";
           when   3  =>  CLK_COR_DET_LEN_1_BINARY <= "10";
           when   4  =>  CLK_COR_DET_LEN_1_BINARY <= "11";
           when others  =>  assert FALSE report "Error : CLK_COR_DET_LEN_1 is not in 1, 2, 3, 4." severity error;
       end case;
       case CLK_COR_ADJ_LEN_1 is
           when   1  =>  CLK_COR_ADJ_LEN_1_BINARY <= "00";
           when   2  =>  CLK_COR_ADJ_LEN_1_BINARY <= "01";
           when   3  =>  CLK_COR_ADJ_LEN_1_BINARY <= "10";
           when   4  =>  CLK_COR_ADJ_LEN_1_BINARY <= "11";
           when others  =>  assert FALSE report "Error : CLK_COR_ADJ_LEN_1 is not in 1, 2, 3, 4." severity error;
       end case;
       case CLK_COR_KEEP_IDLE_1 is
           when FALSE   =>  CLK_COR_KEEP_IDLE_1_BINARY <= '0';
           when TRUE    =>  CLK_COR_KEEP_IDLE_1_BINARY <= '1';
           when others  =>  assert FALSE report "Error : CLK_COR_KEEP_IDLE_1 is neither TRUE nor FALSE." severity error;
       end case;
       case CLK_COR_INSERT_IDLE_FLAG_1 is
           when FALSE   =>  CLK_COR_INSERT_IDLE_FLAG_1_BINARY <= '0';
           when TRUE    =>  CLK_COR_INSERT_IDLE_FLAG_1_BINARY <= '1';
           when others  =>  assert FALSE report "Error : CLK_COR_INSERT_IDLE_FLAG_1 is neither TRUE nor FALSE." severity error;
       end case;
       case CLK_COR_REPEAT_WAIT_1 is
           when   0  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "00000";
           when   1  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "00001";
           when   2  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "00010";
           when   3  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "00011";
           when   4  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "00100";
           when   5  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "00101";
           when   6  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "00110";
           when   7  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "00111";
           when   8  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "01000";
           when   9  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "01001";
           when   10  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "01010";
           when   11  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "01011";
           when   12  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "01100";
           when   13  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "01101";
           when   14  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "01110";
           when   15  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "01111";
           when   16  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "10000";
           when   17  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "10001";
           when   18  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "10010";
           when   19  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "10011";
           when   20  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "10100";
           when   21  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "10101";
           when   22  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "10110";
           when   23  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "10111";
           when   24  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "11000";
           when   25  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "11001";
           when   26  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "11010";
           when   27  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "11011";
           when   28  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "11100";
           when   29  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "11101";
           when   30  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "11110";
           when   31  =>  CLK_COR_REPEAT_WAIT_1_BINARY <= "11111";
           when others  =>  assert FALSE report "Error : CLK_COR_REPEAT_WAIT_1 is not in range 0...31." severity error;
       end case;
       case CLK_COR_SEQ_2_USE_1 is
           when FALSE   =>  CLK_COR_SEQ_2_USE_1_BINARY <= '0';
           when TRUE    =>  CLK_COR_SEQ_2_USE_1_BINARY <= '1';
           when others  =>  assert FALSE report "Error : CLK_COR_SEQ_2_USE_1 is neither TRUE nor FALSE." severity error;
       end case;
--     case CHAN_BOND_MODE_0 is
           if((CHAN_BOND_MODE_0 = "OFF") or (CHAN_BOND_MODE_0 = "off")) then
               CHAN_BOND_MODE_0_BINARY <= "00";
           elsif((CHAN_BOND_MODE_0 = "MASTER") or (CHAN_BOND_MODE_0 = "master")) then
               CHAN_BOND_MODE_0_BINARY <= "01";
           elsif((CHAN_BOND_MODE_0 = "SLAVE") or (CHAN_BOND_MODE_0 = "slave")) then
               CHAN_BOND_MODE_0_BINARY <= "10";
           else
             assert FALSE report "Error : CHAN_BOND_MODE_0 = is not OFF, MASTER, SLAVE." severity error;
            end if;
--     end case;
       case CHAN_BOND_LEVEL_0 is
           when   0  =>  CHAN_BOND_LEVEL_0_BINARY <= "000";
           when   1  =>  CHAN_BOND_LEVEL_0_BINARY <= "001";
           when   2  =>  CHAN_BOND_LEVEL_0_BINARY <= "010";
           when   3  =>  CHAN_BOND_LEVEL_0_BINARY <= "011";
           when   4  =>  CHAN_BOND_LEVEL_0_BINARY <= "100";
           when   5  =>  CHAN_BOND_LEVEL_0_BINARY <= "101";
           when   6  =>  CHAN_BOND_LEVEL_0_BINARY <= "110";
           when   7  =>  CHAN_BOND_LEVEL_0_BINARY <= "111";
           when others  =>  assert FALSE report "Error : CHAN_BOND_LEVEL_0 is not in range 0...7." severity error;
       end case;
       case CHAN_BOND_SEQ_LEN_0 is
           when   1  =>  CHAN_BOND_SEQ_LEN_0_BINARY <= "00";
           when   2  =>  CHAN_BOND_SEQ_LEN_0_BINARY <= "01";
           when   3  =>  CHAN_BOND_SEQ_LEN_0_BINARY <= "10";
           when   4  =>  CHAN_BOND_SEQ_LEN_0_BINARY <= "11";
           when others  =>  assert FALSE report "Error : CHAN_BOND_SEQ_LEN_0 is not in 1, 2, 3, 4." severity error;
       end case;
       case CHAN_BOND_SEQ_2_USE_0 is
           when FALSE   =>  CHAN_BOND_SEQ_2_USE_0_BINARY <= '0';
           when TRUE    =>  CHAN_BOND_SEQ_2_USE_0_BINARY <= '1';
           when others  =>  assert FALSE report "Error : CHAN_BOND_SEQ_2_USE_0 is neither TRUE nor FALSE." severity error;
       end case;
       case CHAN_BOND_1_MAX_SKEW_0 is
           when   1  =>  CHAN_BOND_1_MAX_SKEW_0_BINARY <= "0001";
           when   2  =>  CHAN_BOND_1_MAX_SKEW_0_BINARY <= "0010";
           when   3  =>  CHAN_BOND_1_MAX_SKEW_0_BINARY <= "0011";
           when   4  =>  CHAN_BOND_1_MAX_SKEW_0_BINARY <= "0100";
           when   5  =>  CHAN_BOND_1_MAX_SKEW_0_BINARY <= "0101";
           when   6  =>  CHAN_BOND_1_MAX_SKEW_0_BINARY <= "0110";
           when   7  =>  CHAN_BOND_1_MAX_SKEW_0_BINARY <= "0111";
           when   8  =>  CHAN_BOND_1_MAX_SKEW_0_BINARY <= "1000";
           when   9  =>  CHAN_BOND_1_MAX_SKEW_0_BINARY <= "1001";
           when   10  =>  CHAN_BOND_1_MAX_SKEW_0_BINARY <= "1010";
           when   11  =>  CHAN_BOND_1_MAX_SKEW_0_BINARY <= "1011";
           when   12  =>  CHAN_BOND_1_MAX_SKEW_0_BINARY <= "1100";
           when   13  =>  CHAN_BOND_1_MAX_SKEW_0_BINARY <= "1101";
           when   14  =>  CHAN_BOND_1_MAX_SKEW_0_BINARY <= "1110";
           when others  =>  assert FALSE report "Error : CHAN_BOND_1_MAX_SKEW_0 is not in range 1...14." severity error;
       end case;
       case CHAN_BOND_2_MAX_SKEW_0 is
           when   1  =>  CHAN_BOND_2_MAX_SKEW_0_BINARY <= "0001";
           when   2  =>  CHAN_BOND_2_MAX_SKEW_0_BINARY <= "0010";
           when   3  =>  CHAN_BOND_2_MAX_SKEW_0_BINARY <= "0011";
           when   4  =>  CHAN_BOND_2_MAX_SKEW_0_BINARY <= "0100";
           when   5  =>  CHAN_BOND_2_MAX_SKEW_0_BINARY <= "0101";
           when   6  =>  CHAN_BOND_2_MAX_SKEW_0_BINARY <= "0110";
           when   7  =>  CHAN_BOND_2_MAX_SKEW_0_BINARY <= "0111";
           when   8  =>  CHAN_BOND_2_MAX_SKEW_0_BINARY <= "1000";
           when   9  =>  CHAN_BOND_2_MAX_SKEW_0_BINARY <= "1001";
           when   10  =>  CHAN_BOND_2_MAX_SKEW_0_BINARY <= "1010";
           when   11  =>  CHAN_BOND_2_MAX_SKEW_0_BINARY <= "1011";
           when   12  =>  CHAN_BOND_2_MAX_SKEW_0_BINARY <= "1100";
           when   13  =>  CHAN_BOND_2_MAX_SKEW_0_BINARY <= "1101";
           when   14  =>  CHAN_BOND_2_MAX_SKEW_0_BINARY <= "1110";
           when others  =>  assert FALSE report "Error : CHAN_BOND_2_MAX_SKEW_0 is not in range 1...14." severity error;
       end case;
       case CHAN_BOND_KEEP_ALIGN_0 is
           when FALSE   =>  CHAN_BOND_KEEP_ALIGN_0_BINARY <= '0';
           when TRUE    =>  CHAN_BOND_KEEP_ALIGN_0_BINARY <= '1';
           when others  =>  assert FALSE report "Error : CHAN_BOND_KEEP_ALIGN_0 is neither TRUE nor FALSE." severity error;
       end case;
       case CB2_INH_CC_PERIOD_0 is
           when   0  =>  CB2_INH_CC_PERIOD_0_BINARY <= "0000";
           when   1  =>  CB2_INH_CC_PERIOD_0_BINARY <= "0001";
           when   2  =>  CB2_INH_CC_PERIOD_0_BINARY <= "0010";
           when   3  =>  CB2_INH_CC_PERIOD_0_BINARY <= "0011";
           when   4  =>  CB2_INH_CC_PERIOD_0_BINARY <= "0100";
           when   5  =>  CB2_INH_CC_PERIOD_0_BINARY <= "0101";
           when   6  =>  CB2_INH_CC_PERIOD_0_BINARY <= "0110";
           when   7  =>  CB2_INH_CC_PERIOD_0_BINARY <= "0111";
           when   8  =>  CB2_INH_CC_PERIOD_0_BINARY <= "1000";
           when   9  =>  CB2_INH_CC_PERIOD_0_BINARY <= "1001";
           when   10  =>  CB2_INH_CC_PERIOD_0_BINARY <= "1010";
           when   11  =>  CB2_INH_CC_PERIOD_0_BINARY <= "1011";
           when   12  =>  CB2_INH_CC_PERIOD_0_BINARY <= "1100";
           when   13  =>  CB2_INH_CC_PERIOD_0_BINARY <= "1101";
           when   14  =>  CB2_INH_CC_PERIOD_0_BINARY <= "1110";
           when   15  =>  CB2_INH_CC_PERIOD_0_BINARY <= "1111";
           when others  =>  assert FALSE report "Error : CB2_INH_CC_PERIOD_0 is not in range 0...15." severity error;
       end case;
--     case CHAN_BOND_MODE_1 is
           if((CHAN_BOND_MODE_1 = "OFF") or (CHAN_BOND_MODE_1 = "off")) then
               CHAN_BOND_MODE_1_BINARY <= "00";
           elsif((CHAN_BOND_MODE_1 = "MASTER") or (CHAN_BOND_MODE_1 = "master")) then
               CHAN_BOND_MODE_1_BINARY <= "01";
           elsif((CHAN_BOND_MODE_1 = "SLAVE") or (CHAN_BOND_MODE_1 = "slave")) then
               CHAN_BOND_MODE_1_BINARY <= "10";
           else
             assert FALSE report "Error : CHAN_BOND_MODE_1 = is not OFF, MASTER, SLAVE." severity error;
            end if;
--     end case;
       case CHAN_BOND_LEVEL_1 is
           when   0  =>  CHAN_BOND_LEVEL_1_BINARY <= "000";
           when   1  =>  CHAN_BOND_LEVEL_1_BINARY <= "001";
           when   2  =>  CHAN_BOND_LEVEL_1_BINARY <= "010";
           when   3  =>  CHAN_BOND_LEVEL_1_BINARY <= "011";
           when   4  =>  CHAN_BOND_LEVEL_1_BINARY <= "100";
           when   5  =>  CHAN_BOND_LEVEL_1_BINARY <= "101";
           when   6  =>  CHAN_BOND_LEVEL_1_BINARY <= "110";
           when   7  =>  CHAN_BOND_LEVEL_1_BINARY <= "111";
           when others  =>  assert FALSE report "Error : CHAN_BOND_LEVEL_1 is not in range 0...7." severity error;
       end case;
       case CHAN_BOND_SEQ_LEN_1 is
           when   1  =>  CHAN_BOND_SEQ_LEN_1_BINARY <= "00";
           when   2  =>  CHAN_BOND_SEQ_LEN_1_BINARY <= "01";
           when   3  =>  CHAN_BOND_SEQ_LEN_1_BINARY <= "10";
           when   4  =>  CHAN_BOND_SEQ_LEN_1_BINARY <= "11";
           when others  =>  assert FALSE report "Error : CHAN_BOND_SEQ_LEN_1 is not in 1, 2, 3, 4." severity error;
       end case;
       case CHAN_BOND_SEQ_2_USE_1 is
           when FALSE   =>  CHAN_BOND_SEQ_2_USE_1_BINARY <= '0';
           when TRUE    =>  CHAN_BOND_SEQ_2_USE_1_BINARY <= '1';
           when others  =>  assert FALSE report "Error : CHAN_BOND_SEQ_2_USE_1 is neither TRUE nor FALSE." severity error;
       end case;
       case CHAN_BOND_1_MAX_SKEW_1 is
           when   1  =>  CHAN_BOND_1_MAX_SKEW_1_BINARY <= "0001";
           when   2  =>  CHAN_BOND_1_MAX_SKEW_1_BINARY <= "0010";
           when   3  =>  CHAN_BOND_1_MAX_SKEW_1_BINARY <= "0011";
           when   4  =>  CHAN_BOND_1_MAX_SKEW_1_BINARY <= "0100";
           when   5  =>  CHAN_BOND_1_MAX_SKEW_1_BINARY <= "0101";
           when   6  =>  CHAN_BOND_1_MAX_SKEW_1_BINARY <= "0110";
           when   7  =>  CHAN_BOND_1_MAX_SKEW_1_BINARY <= "0111";
           when   8  =>  CHAN_BOND_1_MAX_SKEW_1_BINARY <= "1000";
           when   9  =>  CHAN_BOND_1_MAX_SKEW_1_BINARY <= "1001";
           when   10  =>  CHAN_BOND_1_MAX_SKEW_1_BINARY <= "1010";
           when   11  =>  CHAN_BOND_1_MAX_SKEW_1_BINARY <= "1011";
           when   12  =>  CHAN_BOND_1_MAX_SKEW_1_BINARY <= "1100";
           when   13  =>  CHAN_BOND_1_MAX_SKEW_1_BINARY <= "1101";
           when   14  =>  CHAN_BOND_1_MAX_SKEW_1_BINARY <= "1110";
           when others  =>  assert FALSE report "Error : CHAN_BOND_1_MAX_SKEW_1 is not in range 1...14." severity error;
       end case;
       case CHAN_BOND_2_MAX_SKEW_1 is
           when   1  =>  CHAN_BOND_2_MAX_SKEW_1_BINARY <= "0001";
           when   2  =>  CHAN_BOND_2_MAX_SKEW_1_BINARY <= "0010";
           when   3  =>  CHAN_BOND_2_MAX_SKEW_1_BINARY <= "0011";
           when   4  =>  CHAN_BOND_2_MAX_SKEW_1_BINARY <= "0100";
           when   5  =>  CHAN_BOND_2_MAX_SKEW_1_BINARY <= "0101";
           when   6  =>  CHAN_BOND_2_MAX_SKEW_1_BINARY <= "0110";
           when   7  =>  CHAN_BOND_2_MAX_SKEW_1_BINARY <= "0111";
           when   8  =>  CHAN_BOND_2_MAX_SKEW_1_BINARY <= "1000";
           when   9  =>  CHAN_BOND_2_MAX_SKEW_1_BINARY <= "1001";
           when   10  =>  CHAN_BOND_2_MAX_SKEW_1_BINARY <= "1010";
           when   11  =>  CHAN_BOND_2_MAX_SKEW_1_BINARY <= "1011";
           when   12  =>  CHAN_BOND_2_MAX_SKEW_1_BINARY <= "1100";
           when   13  =>  CHAN_BOND_2_MAX_SKEW_1_BINARY <= "1101";
           when   14  =>  CHAN_BOND_2_MAX_SKEW_1_BINARY <= "1110";
           when others  =>  assert FALSE report "Error : CHAN_BOND_2_MAX_SKEW_1 is not in range 1...14." severity error;
       end case;
       case CHAN_BOND_KEEP_ALIGN_1 is
           when FALSE   =>  CHAN_BOND_KEEP_ALIGN_1_BINARY <= '0';
           when TRUE    =>  CHAN_BOND_KEEP_ALIGN_1_BINARY <= '1';
           when others  =>  assert FALSE report "Error : CHAN_BOND_KEEP_ALIGN_1 is neither TRUE nor FALSE." severity error;
       end case;
       case CB2_INH_CC_PERIOD_1 is
           when   0  =>  CB2_INH_CC_PERIOD_1_BINARY <= "0000";
           when   1  =>  CB2_INH_CC_PERIOD_1_BINARY <= "0001";
           when   2  =>  CB2_INH_CC_PERIOD_1_BINARY <= "0010";
           when   3  =>  CB2_INH_CC_PERIOD_1_BINARY <= "0011";
           when   4  =>  CB2_INH_CC_PERIOD_1_BINARY <= "0100";
           when   5  =>  CB2_INH_CC_PERIOD_1_BINARY <= "0101";
           when   6  =>  CB2_INH_CC_PERIOD_1_BINARY <= "0110";
           when   7  =>  CB2_INH_CC_PERIOD_1_BINARY <= "0111";
           when   8  =>  CB2_INH_CC_PERIOD_1_BINARY <= "1000";
           when   9  =>  CB2_INH_CC_PERIOD_1_BINARY <= "1001";
           when   10  =>  CB2_INH_CC_PERIOD_1_BINARY <= "1010";
           when   11  =>  CB2_INH_CC_PERIOD_1_BINARY <= "1011";
           when   12  =>  CB2_INH_CC_PERIOD_1_BINARY <= "1100";
           when   13  =>  CB2_INH_CC_PERIOD_1_BINARY <= "1101";
           when   14  =>  CB2_INH_CC_PERIOD_1_BINARY <= "1110";
           when   15  =>  CB2_INH_CC_PERIOD_1_BINARY <= "1111";
           when others  =>  assert FALSE report "Error : CB2_INH_CC_PERIOD_1 is not in range 0...15." severity error;
       end case;
       case PCI_EXPRESS_MODE_0 is
           when FALSE   =>  PCI_EXPRESS_MODE_0_BINARY <= '0';
           when TRUE    =>  PCI_EXPRESS_MODE_0_BINARY <= '1';
           when others  =>  assert FALSE report "Error : PCI_EXPRESS_MODE_0 is neither TRUE nor FALSE." severity error;
       end case;
       case PCI_EXPRESS_MODE_1 is
           when FALSE   =>  PCI_EXPRESS_MODE_1_BINARY <= '0';
           when TRUE    =>  PCI_EXPRESS_MODE_1_BINARY <= '1';
           when others  =>  assert FALSE report "Error : PCI_EXPRESS_MODE_1 is neither TRUE nor FALSE." severity error;
       end case;
--     case RX_STATUS_FMT_0 is
           if((RX_STATUS_FMT_0 = "PCIE") or (RX_STATUS_FMT_0 = "pcie")) then
               RX_STATUS_FMT_0_BINARY <= '0';
           elsif((RX_STATUS_FMT_0 = "SATA") or (RX_STATUS_FMT_0 = "sata")) then
               RX_STATUS_FMT_0_BINARY <= '1';
           else
             assert FALSE report "Error : RX_STATUS_FMT_0 = is not PCIE, SATA." severity error;
            end if;
--     end case;
       case TX_BUFFER_USE_0 is
           when FALSE   =>  TX_BUFFER_USE_0_BINARY <= '0';
           when TRUE    =>  TX_BUFFER_USE_0_BINARY <= '1';
           when others  =>  assert FALSE report "Error : TX_BUFFER_USE_0 is neither TRUE nor FALSE." severity error;
       end case;
--     case TX_XCLK_SEL_0 is
           if((TX_XCLK_SEL_0 = "TXUSR") or (TX_XCLK_SEL_0 = "txusr")) then
               TX_XCLK_SEL_0_BINARY <= '1';
           elsif((TX_XCLK_SEL_0 = "TXOUT") or (TX_XCLK_SEL_0 = "txout")) then
               TX_XCLK_SEL_0_BINARY <= '0';
           else
             assert FALSE report "Error : TX_XCLK_SEL_0 = is not TXUSR, TXOUT." severity error;
            end if;
--     end case;
--     case RX_XCLK_SEL_0 is
           if((RX_XCLK_SEL_0 = "RXREC") or (RX_XCLK_SEL_0 = "rxrec")) then
               RX_XCLK_SEL_0_BINARY <= '0';
           elsif((RX_XCLK_SEL_0 = "RXUSR") or (RX_XCLK_SEL_0 = "rxusr")) then
               RX_XCLK_SEL_0_BINARY <= '1';
           else
             assert FALSE report "Error : RX_XCLK_SEL_0 = is not RXREC, RXUSR." severity error;
            end if;
--     end case;
--     case RX_STATUS_FMT_1 is
           if((RX_STATUS_FMT_1 = "PCIE") or (RX_STATUS_FMT_1 = "pcie")) then
               RX_STATUS_FMT_1_BINARY <= '0';
           elsif((RX_STATUS_FMT_1 = "SATA") or (RX_STATUS_FMT_1 = "sata")) then
               RX_STATUS_FMT_1_BINARY <= '1';
           else
             assert FALSE report "Error : RX_STATUS_FMT_1 = is not PCIE, SATA." severity error;
            end if;
--     end case;
       case TX_BUFFER_USE_1 is
           when FALSE   =>  TX_BUFFER_USE_1_BINARY <= '0';
           when TRUE    =>  TX_BUFFER_USE_1_BINARY <= '1';
           when others  =>  assert FALSE report "Error : TX_BUFFER_USE_1 is neither TRUE nor FALSE." severity error;
       end case;
--     case TX_XCLK_SEL_1 is
           if((TX_XCLK_SEL_1 = "TXUSR") or (TX_XCLK_SEL_1 = "txusr")) then
               TX_XCLK_SEL_1_BINARY <= '1';
           elsif((TX_XCLK_SEL_1 = "TXOUT") or (TX_XCLK_SEL_1 = "txout")) then
               TX_XCLK_SEL_1_BINARY <= '0';
           else
             assert FALSE report "Error : TX_XCLK_SEL_1 = is not TXUSR, TXOUT." severity error;
            end if;
--     end case;
--     case RX_XCLK_SEL_1 is
           if((RX_XCLK_SEL_1 = "RXREC") or (RX_XCLK_SEL_1 = "rxrec")) then
               RX_XCLK_SEL_1_BINARY <= '0';
           elsif((RX_XCLK_SEL_1 = "RXUSR") or (RX_XCLK_SEL_1 = "rxusr")) then
               RX_XCLK_SEL_1_BINARY <= '1';
           else
             assert FALSE report "Error : RX_XCLK_SEL_1 = is not RXREC, RXUSR." severity error;
            end if;
--     end case;
--     case RX_SLIDE_MODE_0 is
           if((RX_SLIDE_MODE_0 = "PCS") or (RX_SLIDE_MODE_0 = "pcs")) then
               RX_SLIDE_MODE_0_BINARY <= '0';
           elsif((RX_SLIDE_MODE_0 = "PMA") or (RX_SLIDE_MODE_0 = "pma")) then
               RX_SLIDE_MODE_0_BINARY <= '1';
           else
             assert FALSE report "Error : RX_SLIDE_MODE_0 = is not PCS, PMA." severity error;
            end if;
--     end case;
--     case RX_SLIDE_MODE_1 is
           if((RX_SLIDE_MODE_1 = "PCS") or (RX_SLIDE_MODE_1 = "pcs")) then
               RX_SLIDE_MODE_1_BINARY <= '0';
           elsif((RX_SLIDE_MODE_1 = "PMA") or (RX_SLIDE_MODE_1 = "pma")) then
               RX_SLIDE_MODE_1_BINARY <= '1';
           else
             assert FALSE report "Error : RX_SLIDE_MODE_1 = is not PCS, PMA." severity error;
            end if;
--     end case;
       case SATA_MIN_BURST_0 is
           when   1  =>  SATA_MIN_BURST_0_BINARY <= "000001";
           when   2  =>  SATA_MIN_BURST_0_BINARY <= "000010";
           when   3  =>  SATA_MIN_BURST_0_BINARY <= "000011";
           when   4  =>  SATA_MIN_BURST_0_BINARY <= "000100";
           when   5  =>  SATA_MIN_BURST_0_BINARY <= "000101";
           when   6  =>  SATA_MIN_BURST_0_BINARY <= "000110";
           when   7  =>  SATA_MIN_BURST_0_BINARY <= "000111";
           when   8  =>  SATA_MIN_BURST_0_BINARY <= "001000";
           when   9  =>  SATA_MIN_BURST_0_BINARY <= "001001";
           when   10  =>  SATA_MIN_BURST_0_BINARY <= "001010";
           when   11  =>  SATA_MIN_BURST_0_BINARY <= "001011";
           when   12  =>  SATA_MIN_BURST_0_BINARY <= "001100";
           when   13  =>  SATA_MIN_BURST_0_BINARY <= "001101";
           when   14  =>  SATA_MIN_BURST_0_BINARY <= "001110";
           when   15  =>  SATA_MIN_BURST_0_BINARY <= "001111";
           when   16  =>  SATA_MIN_BURST_0_BINARY <= "010000";
           when   17  =>  SATA_MIN_BURST_0_BINARY <= "010001";
           when   18  =>  SATA_MIN_BURST_0_BINARY <= "010010";
           when   19  =>  SATA_MIN_BURST_0_BINARY <= "010011";
           when   20  =>  SATA_MIN_BURST_0_BINARY <= "010100";
           when   21  =>  SATA_MIN_BURST_0_BINARY <= "010101";
           when   22  =>  SATA_MIN_BURST_0_BINARY <= "010110";
           when   23  =>  SATA_MIN_BURST_0_BINARY <= "010111";
           when   24  =>  SATA_MIN_BURST_0_BINARY <= "011000";
           when   25  =>  SATA_MIN_BURST_0_BINARY <= "011001";
           when   26  =>  SATA_MIN_BURST_0_BINARY <= "011010";
           when   27  =>  SATA_MIN_BURST_0_BINARY <= "011011";
           when   28  =>  SATA_MIN_BURST_0_BINARY <= "011100";
           when   29  =>  SATA_MIN_BURST_0_BINARY <= "011101";
           when   30  =>  SATA_MIN_BURST_0_BINARY <= "011110";
           when   31  =>  SATA_MIN_BURST_0_BINARY <= "011111";
           when   32  =>  SATA_MIN_BURST_0_BINARY <= "100000";
           when   33  =>  SATA_MIN_BURST_0_BINARY <= "100001";
           when   34  =>  SATA_MIN_BURST_0_BINARY <= "100010";
           when   35  =>  SATA_MIN_BURST_0_BINARY <= "100011";
           when   36  =>  SATA_MIN_BURST_0_BINARY <= "100100";
           when   37  =>  SATA_MIN_BURST_0_BINARY <= "100101";
           when   38  =>  SATA_MIN_BURST_0_BINARY <= "100110";
           when   39  =>  SATA_MIN_BURST_0_BINARY <= "100111";
           when   40  =>  SATA_MIN_BURST_0_BINARY <= "101000";
           when   41  =>  SATA_MIN_BURST_0_BINARY <= "101001";
           when   42  =>  SATA_MIN_BURST_0_BINARY <= "101010";
           when   43  =>  SATA_MIN_BURST_0_BINARY <= "101011";
           when   44  =>  SATA_MIN_BURST_0_BINARY <= "101100";
           when   45  =>  SATA_MIN_BURST_0_BINARY <= "101101";
           when   46  =>  SATA_MIN_BURST_0_BINARY <= "101110";
           when   47  =>  SATA_MIN_BURST_0_BINARY <= "101111";
           when   48  =>  SATA_MIN_BURST_0_BINARY <= "110000";
           when   49  =>  SATA_MIN_BURST_0_BINARY <= "110001";
           when   50  =>  SATA_MIN_BURST_0_BINARY <= "110010";
           when   51  =>  SATA_MIN_BURST_0_BINARY <= "110011";
           when   52  =>  SATA_MIN_BURST_0_BINARY <= "110100";
           when   53  =>  SATA_MIN_BURST_0_BINARY <= "110101";
           when   54  =>  SATA_MIN_BURST_0_BINARY <= "110110";
           when   55  =>  SATA_MIN_BURST_0_BINARY <= "110111";
           when   56  =>  SATA_MIN_BURST_0_BINARY <= "111000";
           when   57  =>  SATA_MIN_BURST_0_BINARY <= "111001";
           when   58  =>  SATA_MIN_BURST_0_BINARY <= "111010";
           when   59  =>  SATA_MIN_BURST_0_BINARY <= "111011";
           when   60  =>  SATA_MIN_BURST_0_BINARY <= "111100";
           when   61  =>  SATA_MIN_BURST_0_BINARY <= "111101";
           when others  =>  assert FALSE report "Error : SATA_MIN_BURST_0 is not in range 1...61." severity error;
       end case;
       case SATA_MAX_BURST_0 is
           when   1  =>  SATA_MAX_BURST_0_BINARY <= "000001";
           when   2  =>  SATA_MAX_BURST_0_BINARY <= "000010";
           when   3  =>  SATA_MAX_BURST_0_BINARY <= "000011";
           when   4  =>  SATA_MAX_BURST_0_BINARY <= "000100";
           when   5  =>  SATA_MAX_BURST_0_BINARY <= "000101";
           when   6  =>  SATA_MAX_BURST_0_BINARY <= "000110";
           when   7  =>  SATA_MAX_BURST_0_BINARY <= "000111";
           when   8  =>  SATA_MAX_BURST_0_BINARY <= "001000";
           when   9  =>  SATA_MAX_BURST_0_BINARY <= "001001";
           when   10  =>  SATA_MAX_BURST_0_BINARY <= "001010";
           when   11  =>  SATA_MAX_BURST_0_BINARY <= "001011";
           when   12  =>  SATA_MAX_BURST_0_BINARY <= "001100";
           when   13  =>  SATA_MAX_BURST_0_BINARY <= "001101";
           when   14  =>  SATA_MAX_BURST_0_BINARY <= "001110";
           when   15  =>  SATA_MAX_BURST_0_BINARY <= "001111";
           when   16  =>  SATA_MAX_BURST_0_BINARY <= "010000";
           when   17  =>  SATA_MAX_BURST_0_BINARY <= "010001";
           when   18  =>  SATA_MAX_BURST_0_BINARY <= "010010";
           when   19  =>  SATA_MAX_BURST_0_BINARY <= "010011";
           when   20  =>  SATA_MAX_BURST_0_BINARY <= "010100";
           when   21  =>  SATA_MAX_BURST_0_BINARY <= "010101";
           when   22  =>  SATA_MAX_BURST_0_BINARY <= "010110";
           when   23  =>  SATA_MAX_BURST_0_BINARY <= "010111";
           when   24  =>  SATA_MAX_BURST_0_BINARY <= "011000";
           when   25  =>  SATA_MAX_BURST_0_BINARY <= "011001";
           when   26  =>  SATA_MAX_BURST_0_BINARY <= "011010";
           when   27  =>  SATA_MAX_BURST_0_BINARY <= "011011";
           when   28  =>  SATA_MAX_BURST_0_BINARY <= "011100";
           when   29  =>  SATA_MAX_BURST_0_BINARY <= "011101";
           when   30  =>  SATA_MAX_BURST_0_BINARY <= "011110";
           when   31  =>  SATA_MAX_BURST_0_BINARY <= "011111";
           when   32  =>  SATA_MAX_BURST_0_BINARY <= "100000";
           when   33  =>  SATA_MAX_BURST_0_BINARY <= "100001";
           when   34  =>  SATA_MAX_BURST_0_BINARY <= "100010";
           when   35  =>  SATA_MAX_BURST_0_BINARY <= "100011";
           when   36  =>  SATA_MAX_BURST_0_BINARY <= "100100";
           when   37  =>  SATA_MAX_BURST_0_BINARY <= "100101";
           when   38  =>  SATA_MAX_BURST_0_BINARY <= "100110";
           when   39  =>  SATA_MAX_BURST_0_BINARY <= "100111";
           when   40  =>  SATA_MAX_BURST_0_BINARY <= "101000";
           when   41  =>  SATA_MAX_BURST_0_BINARY <= "101001";
           when   42  =>  SATA_MAX_BURST_0_BINARY <= "101010";
           when   43  =>  SATA_MAX_BURST_0_BINARY <= "101011";
           when   44  =>  SATA_MAX_BURST_0_BINARY <= "101100";
           when   45  =>  SATA_MAX_BURST_0_BINARY <= "101101";
           when   46  =>  SATA_MAX_BURST_0_BINARY <= "101110";
           when   47  =>  SATA_MAX_BURST_0_BINARY <= "101111";
           when   48  =>  SATA_MAX_BURST_0_BINARY <= "110000";
           when   49  =>  SATA_MAX_BURST_0_BINARY <= "110001";
           when   50  =>  SATA_MAX_BURST_0_BINARY <= "110010";
           when   51  =>  SATA_MAX_BURST_0_BINARY <= "110011";
           when   52  =>  SATA_MAX_BURST_0_BINARY <= "110100";
           when   53  =>  SATA_MAX_BURST_0_BINARY <= "110101";
           when   54  =>  SATA_MAX_BURST_0_BINARY <= "110110";
           when   55  =>  SATA_MAX_BURST_0_BINARY <= "110111";
           when   56  =>  SATA_MAX_BURST_0_BINARY <= "111000";
           when   57  =>  SATA_MAX_BURST_0_BINARY <= "111001";
           when   58  =>  SATA_MAX_BURST_0_BINARY <= "111010";
           when   59  =>  SATA_MAX_BURST_0_BINARY <= "111011";
           when   60  =>  SATA_MAX_BURST_0_BINARY <= "111100";
           when   61  =>  SATA_MAX_BURST_0_BINARY <= "111101";
           when others  =>  assert FALSE report "Error : SATA_MAX_BURST_0 is not in range 1...61." severity error;
       end case;
       case SATA_MIN_INIT_0 is
           when   1  =>  SATA_MIN_INIT_0_BINARY <= "000001";
           when   2  =>  SATA_MIN_INIT_0_BINARY <= "000010";
           when   3  =>  SATA_MIN_INIT_0_BINARY <= "000011";
           when   4  =>  SATA_MIN_INIT_0_BINARY <= "000100";
           when   5  =>  SATA_MIN_INIT_0_BINARY <= "000101";
           when   6  =>  SATA_MIN_INIT_0_BINARY <= "000110";
           when   7  =>  SATA_MIN_INIT_0_BINARY <= "000111";
           when   8  =>  SATA_MIN_INIT_0_BINARY <= "001000";
           when   9  =>  SATA_MIN_INIT_0_BINARY <= "001001";
           when   10  =>  SATA_MIN_INIT_0_BINARY <= "001010";
           when   11  =>  SATA_MIN_INIT_0_BINARY <= "001011";
           when   12  =>  SATA_MIN_INIT_0_BINARY <= "001100";
           when   13  =>  SATA_MIN_INIT_0_BINARY <= "001101";
           when   14  =>  SATA_MIN_INIT_0_BINARY <= "001110";
           when   15  =>  SATA_MIN_INIT_0_BINARY <= "001111";
           when   16  =>  SATA_MIN_INIT_0_BINARY <= "010000";
           when   17  =>  SATA_MIN_INIT_0_BINARY <= "010001";
           when   18  =>  SATA_MIN_INIT_0_BINARY <= "010010";
           when   19  =>  SATA_MIN_INIT_0_BINARY <= "010011";
           when   20  =>  SATA_MIN_INIT_0_BINARY <= "010100";
           when   21  =>  SATA_MIN_INIT_0_BINARY <= "010101";
           when   22  =>  SATA_MIN_INIT_0_BINARY <= "010110";
           when   23  =>  SATA_MIN_INIT_0_BINARY <= "010111";
           when   24  =>  SATA_MIN_INIT_0_BINARY <= "011000";
           when   25  =>  SATA_MIN_INIT_0_BINARY <= "011001";
           when   26  =>  SATA_MIN_INIT_0_BINARY <= "011010";
           when   27  =>  SATA_MIN_INIT_0_BINARY <= "011011";
           when   28  =>  SATA_MIN_INIT_0_BINARY <= "011100";
           when   29  =>  SATA_MIN_INIT_0_BINARY <= "011101";
           when   30  =>  SATA_MIN_INIT_0_BINARY <= "011110";
           when   31  =>  SATA_MIN_INIT_0_BINARY <= "011111";
           when   32  =>  SATA_MIN_INIT_0_BINARY <= "100000";
           when   33  =>  SATA_MIN_INIT_0_BINARY <= "100001";
           when   34  =>  SATA_MIN_INIT_0_BINARY <= "100010";
           when   35  =>  SATA_MIN_INIT_0_BINARY <= "100011";
           when   36  =>  SATA_MIN_INIT_0_BINARY <= "100100";
           when   37  =>  SATA_MIN_INIT_0_BINARY <= "100101";
           when   38  =>  SATA_MIN_INIT_0_BINARY <= "100110";
           when   39  =>  SATA_MIN_INIT_0_BINARY <= "100111";
           when   40  =>  SATA_MIN_INIT_0_BINARY <= "101000";
           when   41  =>  SATA_MIN_INIT_0_BINARY <= "101001";
           when   42  =>  SATA_MIN_INIT_0_BINARY <= "101010";
           when   43  =>  SATA_MIN_INIT_0_BINARY <= "101011";
           when   44  =>  SATA_MIN_INIT_0_BINARY <= "101100";
           when   45  =>  SATA_MIN_INIT_0_BINARY <= "101101";
           when   46  =>  SATA_MIN_INIT_0_BINARY <= "101110";
           when   47  =>  SATA_MIN_INIT_0_BINARY <= "101111";
           when   48  =>  SATA_MIN_INIT_0_BINARY <= "110000";
           when   49  =>  SATA_MIN_INIT_0_BINARY <= "110001";
           when   50  =>  SATA_MIN_INIT_0_BINARY <= "110010";
           when   51  =>  SATA_MIN_INIT_0_BINARY <= "110011";
           when   52  =>  SATA_MIN_INIT_0_BINARY <= "110100";
           when   53  =>  SATA_MIN_INIT_0_BINARY <= "110101";
           when   54  =>  SATA_MIN_INIT_0_BINARY <= "110110";
           when   55  =>  SATA_MIN_INIT_0_BINARY <= "110111";
           when   56  =>  SATA_MIN_INIT_0_BINARY <= "111000";
           when   57  =>  SATA_MIN_INIT_0_BINARY <= "111001";
           when   58  =>  SATA_MIN_INIT_0_BINARY <= "111010";
           when   59  =>  SATA_MIN_INIT_0_BINARY <= "111011";
           when   60  =>  SATA_MIN_INIT_0_BINARY <= "111100";
           when   61  =>  SATA_MIN_INIT_0_BINARY <= "111101";
           when others  =>  assert FALSE report "Error : SATA_MIN_INIT_0 is not in range 1...61." severity error;
       end case;
       case SATA_MAX_INIT_0 is
           when   1  =>  SATA_MAX_INIT_0_BINARY <= "000001";
           when   2  =>  SATA_MAX_INIT_0_BINARY <= "000010";
           when   3  =>  SATA_MAX_INIT_0_BINARY <= "000011";
           when   4  =>  SATA_MAX_INIT_0_BINARY <= "000100";
           when   5  =>  SATA_MAX_INIT_0_BINARY <= "000101";
           when   6  =>  SATA_MAX_INIT_0_BINARY <= "000110";
           when   7  =>  SATA_MAX_INIT_0_BINARY <= "000111";
           when   8  =>  SATA_MAX_INIT_0_BINARY <= "001000";
           when   9  =>  SATA_MAX_INIT_0_BINARY <= "001001";
           when   10  =>  SATA_MAX_INIT_0_BINARY <= "001010";
           when   11  =>  SATA_MAX_INIT_0_BINARY <= "001011";
           when   12  =>  SATA_MAX_INIT_0_BINARY <= "001100";
           when   13  =>  SATA_MAX_INIT_0_BINARY <= "001101";
           when   14  =>  SATA_MAX_INIT_0_BINARY <= "001110";
           when   15  =>  SATA_MAX_INIT_0_BINARY <= "001111";
           when   16  =>  SATA_MAX_INIT_0_BINARY <= "010000";
           when   17  =>  SATA_MAX_INIT_0_BINARY <= "010001";
           when   18  =>  SATA_MAX_INIT_0_BINARY <= "010010";
           when   19  =>  SATA_MAX_INIT_0_BINARY <= "010011";
           when   20  =>  SATA_MAX_INIT_0_BINARY <= "010100";
           when   21  =>  SATA_MAX_INIT_0_BINARY <= "010101";
           when   22  =>  SATA_MAX_INIT_0_BINARY <= "010110";
           when   23  =>  SATA_MAX_INIT_0_BINARY <= "010111";
           when   24  =>  SATA_MAX_INIT_0_BINARY <= "011000";
           when   25  =>  SATA_MAX_INIT_0_BINARY <= "011001";
           when   26  =>  SATA_MAX_INIT_0_BINARY <= "011010";
           when   27  =>  SATA_MAX_INIT_0_BINARY <= "011011";
           when   28  =>  SATA_MAX_INIT_0_BINARY <= "011100";
           when   29  =>  SATA_MAX_INIT_0_BINARY <= "011101";
           when   30  =>  SATA_MAX_INIT_0_BINARY <= "011110";
           when   31  =>  SATA_MAX_INIT_0_BINARY <= "011111";
           when   32  =>  SATA_MAX_INIT_0_BINARY <= "100000";
           when   33  =>  SATA_MAX_INIT_0_BINARY <= "100001";
           when   34  =>  SATA_MAX_INIT_0_BINARY <= "100010";
           when   35  =>  SATA_MAX_INIT_0_BINARY <= "100011";
           when   36  =>  SATA_MAX_INIT_0_BINARY <= "100100";
           when   37  =>  SATA_MAX_INIT_0_BINARY <= "100101";
           when   38  =>  SATA_MAX_INIT_0_BINARY <= "100110";
           when   39  =>  SATA_MAX_INIT_0_BINARY <= "100111";
           when   40  =>  SATA_MAX_INIT_0_BINARY <= "101000";
           when   41  =>  SATA_MAX_INIT_0_BINARY <= "101001";
           when   42  =>  SATA_MAX_INIT_0_BINARY <= "101010";
           when   43  =>  SATA_MAX_INIT_0_BINARY <= "101011";
           when   44  =>  SATA_MAX_INIT_0_BINARY <= "101100";
           when   45  =>  SATA_MAX_INIT_0_BINARY <= "101101";
           when   46  =>  SATA_MAX_INIT_0_BINARY <= "101110";
           when   47  =>  SATA_MAX_INIT_0_BINARY <= "101111";
           when   48  =>  SATA_MAX_INIT_0_BINARY <= "110000";
           when   49  =>  SATA_MAX_INIT_0_BINARY <= "110001";
           when   50  =>  SATA_MAX_INIT_0_BINARY <= "110010";
           when   51  =>  SATA_MAX_INIT_0_BINARY <= "110011";
           when   52  =>  SATA_MAX_INIT_0_BINARY <= "110100";
           when   53  =>  SATA_MAX_INIT_0_BINARY <= "110101";
           when   54  =>  SATA_MAX_INIT_0_BINARY <= "110110";
           when   55  =>  SATA_MAX_INIT_0_BINARY <= "110111";
           when   56  =>  SATA_MAX_INIT_0_BINARY <= "111000";
           when   57  =>  SATA_MAX_INIT_0_BINARY <= "111001";
           when   58  =>  SATA_MAX_INIT_0_BINARY <= "111010";
           when   59  =>  SATA_MAX_INIT_0_BINARY <= "111011";
           when   60  =>  SATA_MAX_INIT_0_BINARY <= "111100";
           when   61  =>  SATA_MAX_INIT_0_BINARY <= "111101";
           when others  =>  assert FALSE report "Error : SATA_MAX_INIT_0 is not in range 1...61." severity error;
       end case;
       case SATA_MIN_WAKE_0 is
           when   1  =>  SATA_MIN_WAKE_0_BINARY <= "000001";
           when   2  =>  SATA_MIN_WAKE_0_BINARY <= "000010";
           when   3  =>  SATA_MIN_WAKE_0_BINARY <= "000011";
           when   4  =>  SATA_MIN_WAKE_0_BINARY <= "000100";
           when   5  =>  SATA_MIN_WAKE_0_BINARY <= "000101";
           when   6  =>  SATA_MIN_WAKE_0_BINARY <= "000110";
           when   7  =>  SATA_MIN_WAKE_0_BINARY <= "000111";
           when   8  =>  SATA_MIN_WAKE_0_BINARY <= "001000";
           when   9  =>  SATA_MIN_WAKE_0_BINARY <= "001001";
           when   10  =>  SATA_MIN_WAKE_0_BINARY <= "001010";
           when   11  =>  SATA_MIN_WAKE_0_BINARY <= "001011";
           when   12  =>  SATA_MIN_WAKE_0_BINARY <= "001100";
           when   13  =>  SATA_MIN_WAKE_0_BINARY <= "001101";
           when   14  =>  SATA_MIN_WAKE_0_BINARY <= "001110";
           when   15  =>  SATA_MIN_WAKE_0_BINARY <= "001111";
           when   16  =>  SATA_MIN_WAKE_0_BINARY <= "010000";
           when   17  =>  SATA_MIN_WAKE_0_BINARY <= "010001";
           when   18  =>  SATA_MIN_WAKE_0_BINARY <= "010010";
           when   19  =>  SATA_MIN_WAKE_0_BINARY <= "010011";
           when   20  =>  SATA_MIN_WAKE_0_BINARY <= "010100";
           when   21  =>  SATA_MIN_WAKE_0_BINARY <= "010101";
           when   22  =>  SATA_MIN_WAKE_0_BINARY <= "010110";
           when   23  =>  SATA_MIN_WAKE_0_BINARY <= "010111";
           when   24  =>  SATA_MIN_WAKE_0_BINARY <= "011000";
           when   25  =>  SATA_MIN_WAKE_0_BINARY <= "011001";
           when   26  =>  SATA_MIN_WAKE_0_BINARY <= "011010";
           when   27  =>  SATA_MIN_WAKE_0_BINARY <= "011011";
           when   28  =>  SATA_MIN_WAKE_0_BINARY <= "011100";
           when   29  =>  SATA_MIN_WAKE_0_BINARY <= "011101";
           when   30  =>  SATA_MIN_WAKE_0_BINARY <= "011110";
           when   31  =>  SATA_MIN_WAKE_0_BINARY <= "011111";
           when   32  =>  SATA_MIN_WAKE_0_BINARY <= "100000";
           when   33  =>  SATA_MIN_WAKE_0_BINARY <= "100001";
           when   34  =>  SATA_MIN_WAKE_0_BINARY <= "100010";
           when   35  =>  SATA_MIN_WAKE_0_BINARY <= "100011";
           when   36  =>  SATA_MIN_WAKE_0_BINARY <= "100100";
           when   37  =>  SATA_MIN_WAKE_0_BINARY <= "100101";
           when   38  =>  SATA_MIN_WAKE_0_BINARY <= "100110";
           when   39  =>  SATA_MIN_WAKE_0_BINARY <= "100111";
           when   40  =>  SATA_MIN_WAKE_0_BINARY <= "101000";
           when   41  =>  SATA_MIN_WAKE_0_BINARY <= "101001";
           when   42  =>  SATA_MIN_WAKE_0_BINARY <= "101010";
           when   43  =>  SATA_MIN_WAKE_0_BINARY <= "101011";
           when   44  =>  SATA_MIN_WAKE_0_BINARY <= "101100";
           when   45  =>  SATA_MIN_WAKE_0_BINARY <= "101101";
           when   46  =>  SATA_MIN_WAKE_0_BINARY <= "101110";
           when   47  =>  SATA_MIN_WAKE_0_BINARY <= "101111";
           when   48  =>  SATA_MIN_WAKE_0_BINARY <= "110000";
           when   49  =>  SATA_MIN_WAKE_0_BINARY <= "110001";
           when   50  =>  SATA_MIN_WAKE_0_BINARY <= "110010";
           when   51  =>  SATA_MIN_WAKE_0_BINARY <= "110011";
           when   52  =>  SATA_MIN_WAKE_0_BINARY <= "110100";
           when   53  =>  SATA_MIN_WAKE_0_BINARY <= "110101";
           when   54  =>  SATA_MIN_WAKE_0_BINARY <= "110110";
           when   55  =>  SATA_MIN_WAKE_0_BINARY <= "110111";
           when   56  =>  SATA_MIN_WAKE_0_BINARY <= "111000";
           when   57  =>  SATA_MIN_WAKE_0_BINARY <= "111001";
           when   58  =>  SATA_MIN_WAKE_0_BINARY <= "111010";
           when   59  =>  SATA_MIN_WAKE_0_BINARY <= "111011";
           when   60  =>  SATA_MIN_WAKE_0_BINARY <= "111100";
           when   61  =>  SATA_MIN_WAKE_0_BINARY <= "111101";
           when others  =>  assert FALSE report "Error : SATA_MIN_WAKE_0 is not in range 1...61." severity error;
       end case;
       case SATA_MAX_WAKE_0 is
           when   1  =>  SATA_MAX_WAKE_0_BINARY <= "000001";
           when   2  =>  SATA_MAX_WAKE_0_BINARY <= "000010";
           when   3  =>  SATA_MAX_WAKE_0_BINARY <= "000011";
           when   4  =>  SATA_MAX_WAKE_0_BINARY <= "000100";
           when   5  =>  SATA_MAX_WAKE_0_BINARY <= "000101";
           when   6  =>  SATA_MAX_WAKE_0_BINARY <= "000110";
           when   7  =>  SATA_MAX_WAKE_0_BINARY <= "000111";
           when   8  =>  SATA_MAX_WAKE_0_BINARY <= "001000";
           when   9  =>  SATA_MAX_WAKE_0_BINARY <= "001001";
           when   10  =>  SATA_MAX_WAKE_0_BINARY <= "001010";
           when   11  =>  SATA_MAX_WAKE_0_BINARY <= "001011";
           when   12  =>  SATA_MAX_WAKE_0_BINARY <= "001100";
           when   13  =>  SATA_MAX_WAKE_0_BINARY <= "001101";
           when   14  =>  SATA_MAX_WAKE_0_BINARY <= "001110";
           when   15  =>  SATA_MAX_WAKE_0_BINARY <= "001111";
           when   16  =>  SATA_MAX_WAKE_0_BINARY <= "010000";
           when   17  =>  SATA_MAX_WAKE_0_BINARY <= "010001";
           when   18  =>  SATA_MAX_WAKE_0_BINARY <= "010010";
           when   19  =>  SATA_MAX_WAKE_0_BINARY <= "010011";
           when   20  =>  SATA_MAX_WAKE_0_BINARY <= "010100";
           when   21  =>  SATA_MAX_WAKE_0_BINARY <= "010101";
           when   22  =>  SATA_MAX_WAKE_0_BINARY <= "010110";
           when   23  =>  SATA_MAX_WAKE_0_BINARY <= "010111";
           when   24  =>  SATA_MAX_WAKE_0_BINARY <= "011000";
           when   25  =>  SATA_MAX_WAKE_0_BINARY <= "011001";
           when   26  =>  SATA_MAX_WAKE_0_BINARY <= "011010";
           when   27  =>  SATA_MAX_WAKE_0_BINARY <= "011011";
           when   28  =>  SATA_MAX_WAKE_0_BINARY <= "011100";
           when   29  =>  SATA_MAX_WAKE_0_BINARY <= "011101";
           when   30  =>  SATA_MAX_WAKE_0_BINARY <= "011110";
           when   31  =>  SATA_MAX_WAKE_0_BINARY <= "011111";
           when   32  =>  SATA_MAX_WAKE_0_BINARY <= "100000";
           when   33  =>  SATA_MAX_WAKE_0_BINARY <= "100001";
           when   34  =>  SATA_MAX_WAKE_0_BINARY <= "100010";
           when   35  =>  SATA_MAX_WAKE_0_BINARY <= "100011";
           when   36  =>  SATA_MAX_WAKE_0_BINARY <= "100100";
           when   37  =>  SATA_MAX_WAKE_0_BINARY <= "100101";
           when   38  =>  SATA_MAX_WAKE_0_BINARY <= "100110";
           when   39  =>  SATA_MAX_WAKE_0_BINARY <= "100111";
           when   40  =>  SATA_MAX_WAKE_0_BINARY <= "101000";
           when   41  =>  SATA_MAX_WAKE_0_BINARY <= "101001";
           when   42  =>  SATA_MAX_WAKE_0_BINARY <= "101010";
           when   43  =>  SATA_MAX_WAKE_0_BINARY <= "101011";
           when   44  =>  SATA_MAX_WAKE_0_BINARY <= "101100";
           when   45  =>  SATA_MAX_WAKE_0_BINARY <= "101101";
           when   46  =>  SATA_MAX_WAKE_0_BINARY <= "101110";
           when   47  =>  SATA_MAX_WAKE_0_BINARY <= "101111";
           when   48  =>  SATA_MAX_WAKE_0_BINARY <= "110000";
           when   49  =>  SATA_MAX_WAKE_0_BINARY <= "110001";
           when   50  =>  SATA_MAX_WAKE_0_BINARY <= "110010";
           when   51  =>  SATA_MAX_WAKE_0_BINARY <= "110011";
           when   52  =>  SATA_MAX_WAKE_0_BINARY <= "110100";
           when   53  =>  SATA_MAX_WAKE_0_BINARY <= "110101";
           when   54  =>  SATA_MAX_WAKE_0_BINARY <= "110110";
           when   55  =>  SATA_MAX_WAKE_0_BINARY <= "110111";
           when   56  =>  SATA_MAX_WAKE_0_BINARY <= "111000";
           when   57  =>  SATA_MAX_WAKE_0_BINARY <= "111001";
           when   58  =>  SATA_MAX_WAKE_0_BINARY <= "111010";
           when   59  =>  SATA_MAX_WAKE_0_BINARY <= "111011";
           when   60  =>  SATA_MAX_WAKE_0_BINARY <= "111100";
           when   61  =>  SATA_MAX_WAKE_0_BINARY <= "111101";
           when others  =>  assert FALSE report "Error : SATA_MAX_WAKE_0 is not in range 1...61." severity error;
       end case;
       case SATA_MIN_BURST_1 is
           when   1  =>  SATA_MIN_BURST_1_BINARY <= "000001";
           when   2  =>  SATA_MIN_BURST_1_BINARY <= "000010";
           when   3  =>  SATA_MIN_BURST_1_BINARY <= "000011";
           when   4  =>  SATA_MIN_BURST_1_BINARY <= "000100";
           when   5  =>  SATA_MIN_BURST_1_BINARY <= "000101";
           when   6  =>  SATA_MIN_BURST_1_BINARY <= "000110";
           when   7  =>  SATA_MIN_BURST_1_BINARY <= "000111";
           when   8  =>  SATA_MIN_BURST_1_BINARY <= "001000";
           when   9  =>  SATA_MIN_BURST_1_BINARY <= "001001";
           when   10  =>  SATA_MIN_BURST_1_BINARY <= "001010";
           when   11  =>  SATA_MIN_BURST_1_BINARY <= "001011";
           when   12  =>  SATA_MIN_BURST_1_BINARY <= "001100";
           when   13  =>  SATA_MIN_BURST_1_BINARY <= "001101";
           when   14  =>  SATA_MIN_BURST_1_BINARY <= "001110";
           when   15  =>  SATA_MIN_BURST_1_BINARY <= "001111";
           when   16  =>  SATA_MIN_BURST_1_BINARY <= "010000";
           when   17  =>  SATA_MIN_BURST_1_BINARY <= "010001";
           when   18  =>  SATA_MIN_BURST_1_BINARY <= "010010";
           when   19  =>  SATA_MIN_BURST_1_BINARY <= "010011";
           when   20  =>  SATA_MIN_BURST_1_BINARY <= "010100";
           when   21  =>  SATA_MIN_BURST_1_BINARY <= "010101";
           when   22  =>  SATA_MIN_BURST_1_BINARY <= "010110";
           when   23  =>  SATA_MIN_BURST_1_BINARY <= "010111";
           when   24  =>  SATA_MIN_BURST_1_BINARY <= "011000";
           when   25  =>  SATA_MIN_BURST_1_BINARY <= "011001";
           when   26  =>  SATA_MIN_BURST_1_BINARY <= "011010";
           when   27  =>  SATA_MIN_BURST_1_BINARY <= "011011";
           when   28  =>  SATA_MIN_BURST_1_BINARY <= "011100";
           when   29  =>  SATA_MIN_BURST_1_BINARY <= "011101";
           when   30  =>  SATA_MIN_BURST_1_BINARY <= "011110";
           when   31  =>  SATA_MIN_BURST_1_BINARY <= "011111";
           when   32  =>  SATA_MIN_BURST_1_BINARY <= "100000";
           when   33  =>  SATA_MIN_BURST_1_BINARY <= "100001";
           when   34  =>  SATA_MIN_BURST_1_BINARY <= "100010";
           when   35  =>  SATA_MIN_BURST_1_BINARY <= "100011";
           when   36  =>  SATA_MIN_BURST_1_BINARY <= "100100";
           when   37  =>  SATA_MIN_BURST_1_BINARY <= "100101";
           when   38  =>  SATA_MIN_BURST_1_BINARY <= "100110";
           when   39  =>  SATA_MIN_BURST_1_BINARY <= "100111";
           when   40  =>  SATA_MIN_BURST_1_BINARY <= "101000";
           when   41  =>  SATA_MIN_BURST_1_BINARY <= "101001";
           when   42  =>  SATA_MIN_BURST_1_BINARY <= "101010";
           when   43  =>  SATA_MIN_BURST_1_BINARY <= "101011";
           when   44  =>  SATA_MIN_BURST_1_BINARY <= "101100";
           when   45  =>  SATA_MIN_BURST_1_BINARY <= "101101";
           when   46  =>  SATA_MIN_BURST_1_BINARY <= "101110";
           when   47  =>  SATA_MIN_BURST_1_BINARY <= "101111";
           when   48  =>  SATA_MIN_BURST_1_BINARY <= "110000";
           when   49  =>  SATA_MIN_BURST_1_BINARY <= "110001";
           when   50  =>  SATA_MIN_BURST_1_BINARY <= "110010";
           when   51  =>  SATA_MIN_BURST_1_BINARY <= "110011";
           when   52  =>  SATA_MIN_BURST_1_BINARY <= "110100";
           when   53  =>  SATA_MIN_BURST_1_BINARY <= "110101";
           when   54  =>  SATA_MIN_BURST_1_BINARY <= "110110";
           when   55  =>  SATA_MIN_BURST_1_BINARY <= "110111";
           when   56  =>  SATA_MIN_BURST_1_BINARY <= "111000";
           when   57  =>  SATA_MIN_BURST_1_BINARY <= "111001";
           when   58  =>  SATA_MIN_BURST_1_BINARY <= "111010";
           when   59  =>  SATA_MIN_BURST_1_BINARY <= "111011";
           when   60  =>  SATA_MIN_BURST_1_BINARY <= "111100";
           when   61  =>  SATA_MIN_BURST_1_BINARY <= "111101";
           when others  =>  assert FALSE report "Error : SATA_MIN_BURST_1 is not in range 1...61." severity error;
       end case;
       case SATA_MAX_BURST_1 is
           when   1  =>  SATA_MAX_BURST_1_BINARY <= "000001";
           when   2  =>  SATA_MAX_BURST_1_BINARY <= "000010";
           when   3  =>  SATA_MAX_BURST_1_BINARY <= "000011";
           when   4  =>  SATA_MAX_BURST_1_BINARY <= "000100";
           when   5  =>  SATA_MAX_BURST_1_BINARY <= "000101";
           when   6  =>  SATA_MAX_BURST_1_BINARY <= "000110";
           when   7  =>  SATA_MAX_BURST_1_BINARY <= "000111";
           when   8  =>  SATA_MAX_BURST_1_BINARY <= "001000";
           when   9  =>  SATA_MAX_BURST_1_BINARY <= "001001";
           when   10  =>  SATA_MAX_BURST_1_BINARY <= "001010";
           when   11  =>  SATA_MAX_BURST_1_BINARY <= "001011";
           when   12  =>  SATA_MAX_BURST_1_BINARY <= "001100";
           when   13  =>  SATA_MAX_BURST_1_BINARY <= "001101";
           when   14  =>  SATA_MAX_BURST_1_BINARY <= "001110";
           when   15  =>  SATA_MAX_BURST_1_BINARY <= "001111";
           when   16  =>  SATA_MAX_BURST_1_BINARY <= "010000";
           when   17  =>  SATA_MAX_BURST_1_BINARY <= "010001";
           when   18  =>  SATA_MAX_BURST_1_BINARY <= "010010";
           when   19  =>  SATA_MAX_BURST_1_BINARY <= "010011";
           when   20  =>  SATA_MAX_BURST_1_BINARY <= "010100";
           when   21  =>  SATA_MAX_BURST_1_BINARY <= "010101";
           when   22  =>  SATA_MAX_BURST_1_BINARY <= "010110";
           when   23  =>  SATA_MAX_BURST_1_BINARY <= "010111";
           when   24  =>  SATA_MAX_BURST_1_BINARY <= "011000";
           when   25  =>  SATA_MAX_BURST_1_BINARY <= "011001";
           when   26  =>  SATA_MAX_BURST_1_BINARY <= "011010";
           when   27  =>  SATA_MAX_BURST_1_BINARY <= "011011";
           when   28  =>  SATA_MAX_BURST_1_BINARY <= "011100";
           when   29  =>  SATA_MAX_BURST_1_BINARY <= "011101";
           when   30  =>  SATA_MAX_BURST_1_BINARY <= "011110";
           when   31  =>  SATA_MAX_BURST_1_BINARY <= "011111";
           when   32  =>  SATA_MAX_BURST_1_BINARY <= "100000";
           when   33  =>  SATA_MAX_BURST_1_BINARY <= "100001";
           when   34  =>  SATA_MAX_BURST_1_BINARY <= "100010";
           when   35  =>  SATA_MAX_BURST_1_BINARY <= "100011";
           when   36  =>  SATA_MAX_BURST_1_BINARY <= "100100";
           when   37  =>  SATA_MAX_BURST_1_BINARY <= "100101";
           when   38  =>  SATA_MAX_BURST_1_BINARY <= "100110";
           when   39  =>  SATA_MAX_BURST_1_BINARY <= "100111";
           when   40  =>  SATA_MAX_BURST_1_BINARY <= "101000";
           when   41  =>  SATA_MAX_BURST_1_BINARY <= "101001";
           when   42  =>  SATA_MAX_BURST_1_BINARY <= "101010";
           when   43  =>  SATA_MAX_BURST_1_BINARY <= "101011";
           when   44  =>  SATA_MAX_BURST_1_BINARY <= "101100";
           when   45  =>  SATA_MAX_BURST_1_BINARY <= "101101";
           when   46  =>  SATA_MAX_BURST_1_BINARY <= "101110";
           when   47  =>  SATA_MAX_BURST_1_BINARY <= "101111";
           when   48  =>  SATA_MAX_BURST_1_BINARY <= "110000";
           when   49  =>  SATA_MAX_BURST_1_BINARY <= "110001";
           when   50  =>  SATA_MAX_BURST_1_BINARY <= "110010";
           when   51  =>  SATA_MAX_BURST_1_BINARY <= "110011";
           when   52  =>  SATA_MAX_BURST_1_BINARY <= "110100";
           when   53  =>  SATA_MAX_BURST_1_BINARY <= "110101";
           when   54  =>  SATA_MAX_BURST_1_BINARY <= "110110";
           when   55  =>  SATA_MAX_BURST_1_BINARY <= "110111";
           when   56  =>  SATA_MAX_BURST_1_BINARY <= "111000";
           when   57  =>  SATA_MAX_BURST_1_BINARY <= "111001";
           when   58  =>  SATA_MAX_BURST_1_BINARY <= "111010";
           when   59  =>  SATA_MAX_BURST_1_BINARY <= "111011";
           when   60  =>  SATA_MAX_BURST_1_BINARY <= "111100";
           when   61  =>  SATA_MAX_BURST_1_BINARY <= "111101";
           when others  =>  assert FALSE report "Error : SATA_MAX_BURST_1 is not in range 1...61." severity error;
       end case;
       case SATA_MIN_INIT_1 is
           when   1  =>  SATA_MIN_INIT_1_BINARY <= "000001";
           when   2  =>  SATA_MIN_INIT_1_BINARY <= "000010";
           when   3  =>  SATA_MIN_INIT_1_BINARY <= "000011";
           when   4  =>  SATA_MIN_INIT_1_BINARY <= "000100";
           when   5  =>  SATA_MIN_INIT_1_BINARY <= "000101";
           when   6  =>  SATA_MIN_INIT_1_BINARY <= "000110";
           when   7  =>  SATA_MIN_INIT_1_BINARY <= "000111";
           when   8  =>  SATA_MIN_INIT_1_BINARY <= "001000";
           when   9  =>  SATA_MIN_INIT_1_BINARY <= "001001";
           when   10  =>  SATA_MIN_INIT_1_BINARY <= "001010";
           when   11  =>  SATA_MIN_INIT_1_BINARY <= "001011";
           when   12  =>  SATA_MIN_INIT_1_BINARY <= "001100";
           when   13  =>  SATA_MIN_INIT_1_BINARY <= "001101";
           when   14  =>  SATA_MIN_INIT_1_BINARY <= "001110";
           when   15  =>  SATA_MIN_INIT_1_BINARY <= "001111";
           when   16  =>  SATA_MIN_INIT_1_BINARY <= "010000";
           when   17  =>  SATA_MIN_INIT_1_BINARY <= "010001";
           when   18  =>  SATA_MIN_INIT_1_BINARY <= "010010";
           when   19  =>  SATA_MIN_INIT_1_BINARY <= "010011";
           when   20  =>  SATA_MIN_INIT_1_BINARY <= "010100";
           when   21  =>  SATA_MIN_INIT_1_BINARY <= "010101";
           when   22  =>  SATA_MIN_INIT_1_BINARY <= "010110";
           when   23  =>  SATA_MIN_INIT_1_BINARY <= "010111";
           when   24  =>  SATA_MIN_INIT_1_BINARY <= "011000";
           when   25  =>  SATA_MIN_INIT_1_BINARY <= "011001";
           when   26  =>  SATA_MIN_INIT_1_BINARY <= "011010";
           when   27  =>  SATA_MIN_INIT_1_BINARY <= "011011";
           when   28  =>  SATA_MIN_INIT_1_BINARY <= "011100";
           when   29  =>  SATA_MIN_INIT_1_BINARY <= "011101";
           when   30  =>  SATA_MIN_INIT_1_BINARY <= "011110";
           when   31  =>  SATA_MIN_INIT_1_BINARY <= "011111";
           when   32  =>  SATA_MIN_INIT_1_BINARY <= "100000";
           when   33  =>  SATA_MIN_INIT_1_BINARY <= "100001";
           when   34  =>  SATA_MIN_INIT_1_BINARY <= "100010";
           when   35  =>  SATA_MIN_INIT_1_BINARY <= "100011";
           when   36  =>  SATA_MIN_INIT_1_BINARY <= "100100";
           when   37  =>  SATA_MIN_INIT_1_BINARY <= "100101";
           when   38  =>  SATA_MIN_INIT_1_BINARY <= "100110";
           when   39  =>  SATA_MIN_INIT_1_BINARY <= "100111";
           when   40  =>  SATA_MIN_INIT_1_BINARY <= "101000";
           when   41  =>  SATA_MIN_INIT_1_BINARY <= "101001";
           when   42  =>  SATA_MIN_INIT_1_BINARY <= "101010";
           when   43  =>  SATA_MIN_INIT_1_BINARY <= "101011";
           when   44  =>  SATA_MIN_INIT_1_BINARY <= "101100";
           when   45  =>  SATA_MIN_INIT_1_BINARY <= "101101";
           when   46  =>  SATA_MIN_INIT_1_BINARY <= "101110";
           when   47  =>  SATA_MIN_INIT_1_BINARY <= "101111";
           when   48  =>  SATA_MIN_INIT_1_BINARY <= "110000";
           when   49  =>  SATA_MIN_INIT_1_BINARY <= "110001";
           when   50  =>  SATA_MIN_INIT_1_BINARY <= "110010";
           when   51  =>  SATA_MIN_INIT_1_BINARY <= "110011";
           when   52  =>  SATA_MIN_INIT_1_BINARY <= "110100";
           when   53  =>  SATA_MIN_INIT_1_BINARY <= "110101";
           when   54  =>  SATA_MIN_INIT_1_BINARY <= "110110";
           when   55  =>  SATA_MIN_INIT_1_BINARY <= "110111";
           when   56  =>  SATA_MIN_INIT_1_BINARY <= "111000";
           when   57  =>  SATA_MIN_INIT_1_BINARY <= "111001";
           when   58  =>  SATA_MIN_INIT_1_BINARY <= "111010";
           when   59  =>  SATA_MIN_INIT_1_BINARY <= "111011";
           when   60  =>  SATA_MIN_INIT_1_BINARY <= "111100";
           when   61  =>  SATA_MIN_INIT_1_BINARY <= "111101";
           when others  =>  assert FALSE report "Error : SATA_MIN_INIT_1 is not in range 1...61." severity error;
       end case;
       case SATA_MAX_INIT_1 is
           when   1  =>  SATA_MAX_INIT_1_BINARY <= "000001";
           when   2  =>  SATA_MAX_INIT_1_BINARY <= "000010";
           when   3  =>  SATA_MAX_INIT_1_BINARY <= "000011";
           when   4  =>  SATA_MAX_INIT_1_BINARY <= "000100";
           when   5  =>  SATA_MAX_INIT_1_BINARY <= "000101";
           when   6  =>  SATA_MAX_INIT_1_BINARY <= "000110";
           when   7  =>  SATA_MAX_INIT_1_BINARY <= "000111";
           when   8  =>  SATA_MAX_INIT_1_BINARY <= "001000";
           when   9  =>  SATA_MAX_INIT_1_BINARY <= "001001";
           when   10  =>  SATA_MAX_INIT_1_BINARY <= "001010";
           when   11  =>  SATA_MAX_INIT_1_BINARY <= "001011";
           when   12  =>  SATA_MAX_INIT_1_BINARY <= "001100";
           when   13  =>  SATA_MAX_INIT_1_BINARY <= "001101";
           when   14  =>  SATA_MAX_INIT_1_BINARY <= "001110";
           when   15  =>  SATA_MAX_INIT_1_BINARY <= "001111";
           when   16  =>  SATA_MAX_INIT_1_BINARY <= "010000";
           when   17  =>  SATA_MAX_INIT_1_BINARY <= "010001";
           when   18  =>  SATA_MAX_INIT_1_BINARY <= "010010";
           when   19  =>  SATA_MAX_INIT_1_BINARY <= "010011";
           when   20  =>  SATA_MAX_INIT_1_BINARY <= "010100";
           when   21  =>  SATA_MAX_INIT_1_BINARY <= "010101";
           when   22  =>  SATA_MAX_INIT_1_BINARY <= "010110";
           when   23  =>  SATA_MAX_INIT_1_BINARY <= "010111";
           when   24  =>  SATA_MAX_INIT_1_BINARY <= "011000";
           when   25  =>  SATA_MAX_INIT_1_BINARY <= "011001";
           when   26  =>  SATA_MAX_INIT_1_BINARY <= "011010";
           when   27  =>  SATA_MAX_INIT_1_BINARY <= "011011";
           when   28  =>  SATA_MAX_INIT_1_BINARY <= "011100";
           when   29  =>  SATA_MAX_INIT_1_BINARY <= "011101";
           when   30  =>  SATA_MAX_INIT_1_BINARY <= "011110";
           when   31  =>  SATA_MAX_INIT_1_BINARY <= "011111";
           when   32  =>  SATA_MAX_INIT_1_BINARY <= "100000";
           when   33  =>  SATA_MAX_INIT_1_BINARY <= "100001";
           when   34  =>  SATA_MAX_INIT_1_BINARY <= "100010";
           when   35  =>  SATA_MAX_INIT_1_BINARY <= "100011";
           when   36  =>  SATA_MAX_INIT_1_BINARY <= "100100";
           when   37  =>  SATA_MAX_INIT_1_BINARY <= "100101";
           when   38  =>  SATA_MAX_INIT_1_BINARY <= "100110";
           when   39  =>  SATA_MAX_INIT_1_BINARY <= "100111";
           when   40  =>  SATA_MAX_INIT_1_BINARY <= "101000";
           when   41  =>  SATA_MAX_INIT_1_BINARY <= "101001";
           when   42  =>  SATA_MAX_INIT_1_BINARY <= "101010";
           when   43  =>  SATA_MAX_INIT_1_BINARY <= "101011";
           when   44  =>  SATA_MAX_INIT_1_BINARY <= "101100";
           when   45  =>  SATA_MAX_INIT_1_BINARY <= "101101";
           when   46  =>  SATA_MAX_INIT_1_BINARY <= "101110";
           when   47  =>  SATA_MAX_INIT_1_BINARY <= "101111";
           when   48  =>  SATA_MAX_INIT_1_BINARY <= "110000";
           when   49  =>  SATA_MAX_INIT_1_BINARY <= "110001";
           when   50  =>  SATA_MAX_INIT_1_BINARY <= "110010";
           when   51  =>  SATA_MAX_INIT_1_BINARY <= "110011";
           when   52  =>  SATA_MAX_INIT_1_BINARY <= "110100";
           when   53  =>  SATA_MAX_INIT_1_BINARY <= "110101";
           when   54  =>  SATA_MAX_INIT_1_BINARY <= "110110";
           when   55  =>  SATA_MAX_INIT_1_BINARY <= "110111";
           when   56  =>  SATA_MAX_INIT_1_BINARY <= "111000";
           when   57  =>  SATA_MAX_INIT_1_BINARY <= "111001";
           when   58  =>  SATA_MAX_INIT_1_BINARY <= "111010";
           when   59  =>  SATA_MAX_INIT_1_BINARY <= "111011";
           when   60  =>  SATA_MAX_INIT_1_BINARY <= "111100";
           when   61  =>  SATA_MAX_INIT_1_BINARY <= "111101";
           when others  =>  assert FALSE report "Error : SATA_MAX_INIT_1 is not in range 1...61." severity error;
       end case;
       case SATA_MIN_WAKE_1 is
           when   1  =>  SATA_MIN_WAKE_1_BINARY <= "000001";
           when   2  =>  SATA_MIN_WAKE_1_BINARY <= "000010";
           when   3  =>  SATA_MIN_WAKE_1_BINARY <= "000011";
           when   4  =>  SATA_MIN_WAKE_1_BINARY <= "000100";
           when   5  =>  SATA_MIN_WAKE_1_BINARY <= "000101";
           when   6  =>  SATA_MIN_WAKE_1_BINARY <= "000110";
           when   7  =>  SATA_MIN_WAKE_1_BINARY <= "000111";
           when   8  =>  SATA_MIN_WAKE_1_BINARY <= "001000";
           when   9  =>  SATA_MIN_WAKE_1_BINARY <= "001001";
           when   10  =>  SATA_MIN_WAKE_1_BINARY <= "001010";
           when   11  =>  SATA_MIN_WAKE_1_BINARY <= "001011";
           when   12  =>  SATA_MIN_WAKE_1_BINARY <= "001100";
           when   13  =>  SATA_MIN_WAKE_1_BINARY <= "001101";
           when   14  =>  SATA_MIN_WAKE_1_BINARY <= "001110";
           when   15  =>  SATA_MIN_WAKE_1_BINARY <= "001111";
           when   16  =>  SATA_MIN_WAKE_1_BINARY <= "010000";
           when   17  =>  SATA_MIN_WAKE_1_BINARY <= "010001";
           when   18  =>  SATA_MIN_WAKE_1_BINARY <= "010010";
           when   19  =>  SATA_MIN_WAKE_1_BINARY <= "010011";
           when   20  =>  SATA_MIN_WAKE_1_BINARY <= "010100";
           when   21  =>  SATA_MIN_WAKE_1_BINARY <= "010101";
           when   22  =>  SATA_MIN_WAKE_1_BINARY <= "010110";
           when   23  =>  SATA_MIN_WAKE_1_BINARY <= "010111";
           when   24  =>  SATA_MIN_WAKE_1_BINARY <= "011000";
           when   25  =>  SATA_MIN_WAKE_1_BINARY <= "011001";
           when   26  =>  SATA_MIN_WAKE_1_BINARY <= "011010";
           when   27  =>  SATA_MIN_WAKE_1_BINARY <= "011011";
           when   28  =>  SATA_MIN_WAKE_1_BINARY <= "011100";
           when   29  =>  SATA_MIN_WAKE_1_BINARY <= "011101";
           when   30  =>  SATA_MIN_WAKE_1_BINARY <= "011110";
           when   31  =>  SATA_MIN_WAKE_1_BINARY <= "011111";
           when   32  =>  SATA_MIN_WAKE_1_BINARY <= "100000";
           when   33  =>  SATA_MIN_WAKE_1_BINARY <= "100001";
           when   34  =>  SATA_MIN_WAKE_1_BINARY <= "100010";
           when   35  =>  SATA_MIN_WAKE_1_BINARY <= "100011";
           when   36  =>  SATA_MIN_WAKE_1_BINARY <= "100100";
           when   37  =>  SATA_MIN_WAKE_1_BINARY <= "100101";
           when   38  =>  SATA_MIN_WAKE_1_BINARY <= "100110";
           when   39  =>  SATA_MIN_WAKE_1_BINARY <= "100111";
           when   40  =>  SATA_MIN_WAKE_1_BINARY <= "101000";
           when   41  =>  SATA_MIN_WAKE_1_BINARY <= "101001";
           when   42  =>  SATA_MIN_WAKE_1_BINARY <= "101010";
           when   43  =>  SATA_MIN_WAKE_1_BINARY <= "101011";
           when   44  =>  SATA_MIN_WAKE_1_BINARY <= "101100";
           when   45  =>  SATA_MIN_WAKE_1_BINARY <= "101101";
           when   46  =>  SATA_MIN_WAKE_1_BINARY <= "101110";
           when   47  =>  SATA_MIN_WAKE_1_BINARY <= "101111";
           when   48  =>  SATA_MIN_WAKE_1_BINARY <= "110000";
           when   49  =>  SATA_MIN_WAKE_1_BINARY <= "110001";
           when   50  =>  SATA_MIN_WAKE_1_BINARY <= "110010";
           when   51  =>  SATA_MIN_WAKE_1_BINARY <= "110011";
           when   52  =>  SATA_MIN_WAKE_1_BINARY <= "110100";
           when   53  =>  SATA_MIN_WAKE_1_BINARY <= "110101";
           when   54  =>  SATA_MIN_WAKE_1_BINARY <= "110110";
           when   55  =>  SATA_MIN_WAKE_1_BINARY <= "110111";
           when   56  =>  SATA_MIN_WAKE_1_BINARY <= "111000";
           when   57  =>  SATA_MIN_WAKE_1_BINARY <= "111001";
           when   58  =>  SATA_MIN_WAKE_1_BINARY <= "111010";
           when   59  =>  SATA_MIN_WAKE_1_BINARY <= "111011";
           when   60  =>  SATA_MIN_WAKE_1_BINARY <= "111100";
           when   61  =>  SATA_MIN_WAKE_1_BINARY <= "111101";
           when others  =>  assert FALSE report "Error : SATA_MIN_WAKE_1 is not in range 1...61." severity error;
       end case;
       case SATA_MAX_WAKE_1 is
           when   1  =>  SATA_MAX_WAKE_1_BINARY <= "000001";
           when   2  =>  SATA_MAX_WAKE_1_BINARY <= "000010";
           when   3  =>  SATA_MAX_WAKE_1_BINARY <= "000011";
           when   4  =>  SATA_MAX_WAKE_1_BINARY <= "000100";
           when   5  =>  SATA_MAX_WAKE_1_BINARY <= "000101";
           when   6  =>  SATA_MAX_WAKE_1_BINARY <= "000110";
           when   7  =>  SATA_MAX_WAKE_1_BINARY <= "000111";
           when   8  =>  SATA_MAX_WAKE_1_BINARY <= "001000";
           when   9  =>  SATA_MAX_WAKE_1_BINARY <= "001001";
           when   10  =>  SATA_MAX_WAKE_1_BINARY <= "001010";
           when   11  =>  SATA_MAX_WAKE_1_BINARY <= "001011";
           when   12  =>  SATA_MAX_WAKE_1_BINARY <= "001100";
           when   13  =>  SATA_MAX_WAKE_1_BINARY <= "001101";
           when   14  =>  SATA_MAX_WAKE_1_BINARY <= "001110";
           when   15  =>  SATA_MAX_WAKE_1_BINARY <= "001111";
           when   16  =>  SATA_MAX_WAKE_1_BINARY <= "010000";
           when   17  =>  SATA_MAX_WAKE_1_BINARY <= "010001";
           when   18  =>  SATA_MAX_WAKE_1_BINARY <= "010010";
           when   19  =>  SATA_MAX_WAKE_1_BINARY <= "010011";
           when   20  =>  SATA_MAX_WAKE_1_BINARY <= "010100";
           when   21  =>  SATA_MAX_WAKE_1_BINARY <= "010101";
           when   22  =>  SATA_MAX_WAKE_1_BINARY <= "010110";
           when   23  =>  SATA_MAX_WAKE_1_BINARY <= "010111";
           when   24  =>  SATA_MAX_WAKE_1_BINARY <= "011000";
           when   25  =>  SATA_MAX_WAKE_1_BINARY <= "011001";
           when   26  =>  SATA_MAX_WAKE_1_BINARY <= "011010";
           when   27  =>  SATA_MAX_WAKE_1_BINARY <= "011011";
           when   28  =>  SATA_MAX_WAKE_1_BINARY <= "011100";
           when   29  =>  SATA_MAX_WAKE_1_BINARY <= "011101";
           when   30  =>  SATA_MAX_WAKE_1_BINARY <= "011110";
           when   31  =>  SATA_MAX_WAKE_1_BINARY <= "011111";
           when   32  =>  SATA_MAX_WAKE_1_BINARY <= "100000";
           when   33  =>  SATA_MAX_WAKE_1_BINARY <= "100001";
           when   34  =>  SATA_MAX_WAKE_1_BINARY <= "100010";
           when   35  =>  SATA_MAX_WAKE_1_BINARY <= "100011";
           when   36  =>  SATA_MAX_WAKE_1_BINARY <= "100100";
           when   37  =>  SATA_MAX_WAKE_1_BINARY <= "100101";
           when   38  =>  SATA_MAX_WAKE_1_BINARY <= "100110";
           when   39  =>  SATA_MAX_WAKE_1_BINARY <= "100111";
           when   40  =>  SATA_MAX_WAKE_1_BINARY <= "101000";
           when   41  =>  SATA_MAX_WAKE_1_BINARY <= "101001";
           when   42  =>  SATA_MAX_WAKE_1_BINARY <= "101010";
           when   43  =>  SATA_MAX_WAKE_1_BINARY <= "101011";
           when   44  =>  SATA_MAX_WAKE_1_BINARY <= "101100";
           when   45  =>  SATA_MAX_WAKE_1_BINARY <= "101101";
           when   46  =>  SATA_MAX_WAKE_1_BINARY <= "101110";
           when   47  =>  SATA_MAX_WAKE_1_BINARY <= "101111";
           when   48  =>  SATA_MAX_WAKE_1_BINARY <= "110000";
           when   49  =>  SATA_MAX_WAKE_1_BINARY <= "110001";
           when   50  =>  SATA_MAX_WAKE_1_BINARY <= "110010";
           when   51  =>  SATA_MAX_WAKE_1_BINARY <= "110011";
           when   52  =>  SATA_MAX_WAKE_1_BINARY <= "110100";
           when   53  =>  SATA_MAX_WAKE_1_BINARY <= "110101";
           when   54  =>  SATA_MAX_WAKE_1_BINARY <= "110110";
           when   55  =>  SATA_MAX_WAKE_1_BINARY <= "110111";
           when   56  =>  SATA_MAX_WAKE_1_BINARY <= "111000";
           when   57  =>  SATA_MAX_WAKE_1_BINARY <= "111001";
           when   58  =>  SATA_MAX_WAKE_1_BINARY <= "111010";
           when   59  =>  SATA_MAX_WAKE_1_BINARY <= "111011";
           when   60  =>  SATA_MAX_WAKE_1_BINARY <= "111100";
           when   61  =>  SATA_MAX_WAKE_1_BINARY <= "111101";
           when others  =>  assert FALSE report "Error : SATA_MAX_WAKE_1 is not in range 1...61." severity error;
       end case;
       case CLK25_DIVIDER is
           when   1  =>  CLK25_DIVIDER_BINARY <= "000";
           when   2  =>  CLK25_DIVIDER_BINARY <= "001";
           when   3  =>  CLK25_DIVIDER_BINARY <= "010";
           when   4  =>  CLK25_DIVIDER_BINARY <= "011";
           when   5  =>  CLK25_DIVIDER_BINARY <= "100";
           when   6  =>  CLK25_DIVIDER_BINARY <= "101";
           when   10  =>  CLK25_DIVIDER_BINARY <= "110";
           when   12  =>  CLK25_DIVIDER_BINARY <= "111";
           when others  =>  assert FALSE report "Error : CLK25_DIVIDER is not in 1, 2, 3, 4, 5, 6, 10, 12." severity error;
       end case;
       case OVERSAMPLE_MODE is
           when FALSE   =>  OVERSAMPLE_MODE_BINARY <= '0';
           when TRUE    =>  OVERSAMPLE_MODE_BINARY <= '1';
           when others  =>  assert FALSE report "Error : OVERSAMPLE_MODE is neither TRUE nor FALSE." severity error;
       end case;
       case TXGEARBOX_USE_0 is
           when FALSE   =>  TXGEARBOX_USE_0_BINARY <= '0';
           when TRUE    =>  TXGEARBOX_USE_0_BINARY <= '1';
           when others  =>  assert FALSE report "Error : TXGEARBOX_USE_0 is neither TRUE nor FALSE." severity error;
       end case;
       case RXGEARBOX_USE_0 is
           when FALSE   =>  RXGEARBOX_USE_0_BINARY <= '0';
           when TRUE    =>  RXGEARBOX_USE_0_BINARY <= '1';
           when others  =>  assert FALSE report "Error : RXGEARBOX_USE_0 is neither TRUE nor FALSE." severity error;
       end case;
       case TXGEARBOX_USE_1 is
           when FALSE   =>  TXGEARBOX_USE_1_BINARY <= '0';
           when TRUE    =>  TXGEARBOX_USE_1_BINARY <= '1';
           when others  =>  assert FALSE report "Error : TXGEARBOX_USE_1 is neither TRUE nor FALSE." severity error;
       end case;
       case RXGEARBOX_USE_1 is
           when FALSE   =>  RXGEARBOX_USE_1_BINARY <= '0';
           when TRUE    =>  RXGEARBOX_USE_1_BINARY <= '1';
           when others  =>  assert FALSE report "Error : RXGEARBOX_USE_1 is neither TRUE nor FALSE." severity error;
       end case;
       case PLL_FB_DCCEN is
           when FALSE   =>  PLL_FB_DCCEN_BINARY <= '0';
           when TRUE    =>  PLL_FB_DCCEN_BINARY <= '1';
           when others  =>  assert FALSE report "Error : PLL_FB_DCCEN is neither TRUE nor FALSE." severity error;
       end case;
       case CLKRCV_TRST is
           when FALSE   =>  CLKRCV_TRST_BINARY <= '0';
           when TRUE    =>  CLKRCV_TRST_BINARY <= '1';
           when others  =>  assert FALSE report "Error : CLKRCV_TRST is neither TRUE nor FALSE." severity error;
       end case;
       case RX_EN_IDLE_HOLD_DFE_0 is
           when FALSE   =>  RX_EN_IDLE_HOLD_DFE_0_BINARY <= '0';
           when TRUE    =>  RX_EN_IDLE_HOLD_DFE_0_BINARY <= '1';
           when others  =>  assert FALSE report "Error : RX_EN_IDLE_HOLD_DFE_0 is neither TRUE nor FALSE." severity error;
       end case;
       case RX_EN_IDLE_RESET_BUF_0 is
           when FALSE   =>  RX_EN_IDLE_RESET_BUF_0_BINARY <= '0';
           when TRUE    =>  RX_EN_IDLE_RESET_BUF_0_BINARY <= '1';
           when others  =>  assert FALSE report "Error : RX_EN_IDLE_RESET_BUF_0 is neither TRUE nor FALSE." severity error;
       end case;
       case RX_EN_IDLE_HOLD_DFE_1 is
           when FALSE   =>  RX_EN_IDLE_HOLD_DFE_1_BINARY <= '0';
           when TRUE    =>  RX_EN_IDLE_HOLD_DFE_1_BINARY <= '1';
           when others  =>  assert FALSE report "Error : RX_EN_IDLE_HOLD_DFE_1 is neither TRUE nor FALSE." severity error;
       end case;
       case RX_EN_IDLE_RESET_BUF_1 is
           when FALSE   =>  RX_EN_IDLE_RESET_BUF_1_BINARY <= '0';
           when TRUE    =>  RX_EN_IDLE_RESET_BUF_1_BINARY <= '1';
           when others  =>  assert FALSE report "Error : RX_EN_IDLE_RESET_BUF_1 is neither TRUE nor FALSE." severity error;
       end case;
       case RX_EN_IDLE_HOLD_CDR is
           when FALSE   =>  RX_EN_IDLE_HOLD_CDR_BINARY <= '0';
           when TRUE    =>  RX_EN_IDLE_HOLD_CDR_BINARY <= '1';
           when others  =>  assert FALSE report "Error : RX_EN_IDLE_HOLD_CDR is neither TRUE nor FALSE." severity error;
       end case;
       case RX_EN_IDLE_RESET_PH is
           when FALSE   =>  RX_EN_IDLE_RESET_PH_BINARY <= '0';
           when TRUE    =>  RX_EN_IDLE_RESET_PH_BINARY <= '1';
           when others  =>  assert FALSE report "Error : RX_EN_IDLE_RESET_PH is neither TRUE nor FALSE." severity error;
       end case;
       case RX_EN_IDLE_RESET_FR is
           when FALSE   =>  RX_EN_IDLE_RESET_FR_BINARY <= '0';
           when TRUE    =>  RX_EN_IDLE_RESET_FR_BINARY <= '1';
           when others  =>  assert FALSE report "Error : RX_EN_IDLE_RESET_FR is neither TRUE nor FALSE." severity error;
       end case;
       case SIM_GTXRESET_SPEEDUP is
           when   0  =>  SIM_GTXRESET_SPEEDUP_BINARY <= '0';
           when   1  =>  SIM_GTXRESET_SPEEDUP_BINARY <= '1';
           when others  =>  assert FALSE report "Error : SIM_GTXRESET_SPEEDUP is not in 0, 1." severity error;
       end case;
--     case SIM_MODE is
           if((SIM_MODE = "FAST") or (SIM_MODE = "fast")) then
               SIM_MODE_BINARY <= '1';
           elsif ((SIM_MODE = "LEGACY") or (SIM_MODE = "legacy")) then 
             assert FALSE report "Warning : The Attribute SIM_MODE on X_GTX_DUAL instance is set to LEGACY. The Legacy model is not supported from ISE 11.1 onwards. X_GTX_DUAL defaults to FAST model. There are no functionality differences between X_GTX_DUAL LEGACY and X_GTX_DUAL FAST simulation models. Although, if you want to use the X_GTX_DUAL LEGACY model, please use an earlier ISE build." severity warning;
            else
              assert FALSE report "Warning : The Attribute SIM_MODE on X_GTX_DUAL instance is not set to FAST." severity warning;
           end if;
--     end case;
       case SIM_RECEIVER_DETECT_PASS_0 is
           when FALSE   =>  SIM_RECEIVER_DETECT_PASS_0_BINARY <= '0';
           when TRUE    =>  SIM_RECEIVER_DETECT_PASS_0_BINARY <= '1';
           when others  =>  assert FALSE report "Error : SIM_RECEIVER_DETECT_PASS_0 is neither TRUE nor FALSE." severity error;
       end case;
       case SIM_RECEIVER_DETECT_PASS_1 is
           when FALSE   =>  SIM_RECEIVER_DETECT_PASS_1_BINARY <= '0';
           when TRUE    =>  SIM_RECEIVER_DETECT_PASS_1_BINARY <= '1';
           when others  =>  assert FALSE report "Error : SIM_RECEIVER_DETECT_PASS_1 is neither TRUE nor FALSE." severity error;
       end case;
	wait;
	end process INIPROC;

	TIMING : process


	variable Tmkr_DADDR0_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DADDR1_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DADDR2_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DADDR3_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DADDR4_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DADDR5_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DADDR6_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DEN_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFECLKDLYADJ00_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFECLKDLYADJ01_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFECLKDLYADJ02_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFECLKDLYADJ03_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFECLKDLYADJ04_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFECLKDLYADJ05_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFECLKDLYADJ10_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFECLKDLYADJ11_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFECLKDLYADJ12_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFECLKDLYADJ13_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFECLKDLYADJ14_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFECLKDLYADJ15_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP100_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP101_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP102_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP103_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP104_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP110_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP111_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP112_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP113_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP114_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP200_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP201_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP202_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP203_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP204_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP210_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP211_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP212_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP213_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP214_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP300_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP301_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP302_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP303_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP310_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP311_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP312_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP313_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP400_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP401_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP402_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP403_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP410_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP411_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP412_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DFETAP413_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DI0_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DI10_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DI11_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DI12_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DI13_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DI14_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DI15_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DI1_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DI2_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DI3_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DI4_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DI5_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DI6_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DI7_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DI8_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DI9_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_DWE_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_PRBSCNTRESET0_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_PRBSCNTRESET1_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_RXCHBONDI00_RXUSRCLK0_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_RXCHBONDI01_RXUSRCLK0_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_RXCHBONDI02_RXUSRCLK0_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_RXCHBONDI03_RXUSRCLK0_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_RXCHBONDI10_RXUSRCLK1_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_RXCHBONDI11_RXUSRCLK1_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_RXCHBONDI12_RXUSRCLK1_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_RXCHBONDI13_RXUSRCLK1_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_RXCOMMADETUSE0_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_RXCOMMADETUSE1_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_RXDEC8B10BUSE0_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_RXDEC8B10BUSE1_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_RXENCHANSYNC0_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_RXENCHANSYNC1_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_RXENMCOMMAALIGN0_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_RXENMCOMMAALIGN1_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_RXENPCOMMAALIGN0_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_RXENPCOMMAALIGN1_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_RXENPRBSTST00_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_RXENPRBSTST01_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_RXENPRBSTST10_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_RXENPRBSTST11_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_RXENSAMPLEALIGN0_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_RXENSAMPLEALIGN1_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_RXGEARBOXSLIP0_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_RXGEARBOXSLIP1_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_RXPOLARITY0_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_RXPOLARITY1_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_RXSLIDE0_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_RXSLIDE1_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXBYPASS8B10B00_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXBYPASS8B10B01_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXBYPASS8B10B02_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXBYPASS8B10B03_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXBYPASS8B10B10_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXBYPASS8B10B11_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXBYPASS8B10B12_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXBYPASS8B10B13_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXCHARDISPMODE00_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXCHARDISPMODE01_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXCHARDISPMODE02_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXCHARDISPMODE03_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXCHARDISPMODE10_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXCHARDISPMODE11_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXCHARDISPMODE12_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXCHARDISPMODE13_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXCHARDISPVAL00_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXCHARDISPVAL01_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXCHARDISPVAL02_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXCHARDISPVAL03_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXCHARDISPVAL10_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXCHARDISPVAL11_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXCHARDISPVAL12_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXCHARDISPVAL13_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXCHARISK00_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXCHARISK01_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXCHARISK02_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXCHARISK03_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXCHARISK10_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXCHARISK11_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXCHARISK12_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXCHARISK13_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXCOMSTART0_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXCOMSTART1_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXCOMTYPE0_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXCOMTYPE1_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA00_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA010_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA011_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA012_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA013_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA014_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA015_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA016_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA017_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA018_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA019_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA01_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA020_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA021_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA022_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA023_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA024_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA025_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA026_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA027_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA028_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA029_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA02_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA030_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA031_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA03_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA04_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA05_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA06_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA07_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA08_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA09_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA10_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA110_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA111_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA112_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA113_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA114_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA115_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA116_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA117_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA118_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA119_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA11_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA120_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA121_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA122_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA123_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA124_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA125_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA126_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA127_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA128_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA129_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA12_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA130_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA131_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA13_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA14_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA15_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA16_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA17_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA18_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDATA19_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDETECTRX0_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXDETECTRX1_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
        variable Tmkr_TXELECIDLE0_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXELECIDLE1_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXENC8B10BUSE0_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXENC8B10BUSE1_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXENPRBSTST00_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXENPRBSTST01_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXENPRBSTST10_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXENPRBSTST11_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXHEADER00_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXHEADER01_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXHEADER02_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXHEADER10_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXHEADER11_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXHEADER12_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXINHIBIT0_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXINHIBIT1_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXPOLARITY0_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXPOLARITY1_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXSEQUENCE00_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXSEQUENCE01_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXSEQUENCE02_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXSEQUENCE03_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXSEQUENCE04_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXSEQUENCE05_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXSEQUENCE06_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXSEQUENCE10_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXSEQUENCE11_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXSEQUENCE12_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXSEQUENCE13_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXSEQUENCE14_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXSEQUENCE15_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXSEQUENCE16_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXSTARTSEQ0_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tmkr_TXSTARTSEQ1_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
	variable Tviol_DADDR0_DCLK_posedge : STD_ULOGIC := '0';
	variable Tviol_DADDR1_DCLK_posedge : STD_ULOGIC := '0';
	variable Tviol_DADDR2_DCLK_posedge : STD_ULOGIC := '0';
	variable Tviol_DADDR3_DCLK_posedge : STD_ULOGIC := '0';
	variable Tviol_DADDR4_DCLK_posedge : STD_ULOGIC := '0';
	variable Tviol_DADDR5_DCLK_posedge : STD_ULOGIC := '0';
	variable Tviol_DADDR6_DCLK_posedge : STD_ULOGIC := '0';
	variable Tviol_DEN_DCLK_posedge : STD_ULOGIC := '0';
	variable Tviol_DFECLKDLYADJ00_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_DFECLKDLYADJ01_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_DFECLKDLYADJ02_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_DFECLKDLYADJ03_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_DFECLKDLYADJ04_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_DFECLKDLYADJ05_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_DFECLKDLYADJ10_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_DFECLKDLYADJ11_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_DFECLKDLYADJ12_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_DFECLKDLYADJ13_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_DFECLKDLYADJ14_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_DFECLKDLYADJ15_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP100_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP101_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP102_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP103_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP104_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP110_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP111_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP112_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP113_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP114_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP200_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP201_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP202_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP203_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP204_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP210_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP211_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP212_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP213_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP214_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP300_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP301_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP302_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP303_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP310_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP311_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP312_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP313_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP400_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP401_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP402_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP403_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP410_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP411_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP412_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_DFETAP413_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_DI0_DCLK_posedge : STD_ULOGIC := '0';
	variable Tviol_DI10_DCLK_posedge : STD_ULOGIC := '0';
	variable Tviol_DI11_DCLK_posedge : STD_ULOGIC := '0';
	variable Tviol_DI12_DCLK_posedge : STD_ULOGIC := '0';
	variable Tviol_DI13_DCLK_posedge : STD_ULOGIC := '0';
	variable Tviol_DI14_DCLK_posedge : STD_ULOGIC := '0';
	variable Tviol_DI15_DCLK_posedge : STD_ULOGIC := '0';
	variable Tviol_DI1_DCLK_posedge : STD_ULOGIC := '0';
	variable Tviol_DI2_DCLK_posedge : STD_ULOGIC := '0';
	variable Tviol_DI3_DCLK_posedge : STD_ULOGIC := '0';
	variable Tviol_DI4_DCLK_posedge : STD_ULOGIC := '0';
	variable Tviol_DI5_DCLK_posedge : STD_ULOGIC := '0';
	variable Tviol_DI6_DCLK_posedge : STD_ULOGIC := '0';
	variable Tviol_DI7_DCLK_posedge : STD_ULOGIC := '0';
	variable Tviol_DI8_DCLK_posedge : STD_ULOGIC := '0';
	variable Tviol_DI9_DCLK_posedge : STD_ULOGIC := '0';
	variable Tviol_DWE_DCLK_posedge : STD_ULOGIC := '0';
	variable Tviol_PRBSCNTRESET0_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_PRBSCNTRESET1_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_RXCHBONDI00_RXUSRCLK0_posedge : STD_ULOGIC := '0';
	variable Tviol_RXCHBONDI01_RXUSRCLK0_posedge : STD_ULOGIC := '0';
	variable Tviol_RXCHBONDI02_RXUSRCLK0_posedge : STD_ULOGIC := '0';
	variable Tviol_RXCHBONDI03_RXUSRCLK0_posedge : STD_ULOGIC := '0';
	variable Tviol_RXCHBONDI10_RXUSRCLK1_posedge : STD_ULOGIC := '0';
	variable Tviol_RXCHBONDI11_RXUSRCLK1_posedge : STD_ULOGIC := '0';
	variable Tviol_RXCHBONDI12_RXUSRCLK1_posedge : STD_ULOGIC := '0';
	variable Tviol_RXCHBONDI13_RXUSRCLK1_posedge : STD_ULOGIC := '0';
	variable Tviol_RXCOMMADETUSE0_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_RXCOMMADETUSE1_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_RXDEC8B10BUSE0_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_RXDEC8B10BUSE1_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_RXENCHANSYNC0_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_RXENCHANSYNC1_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_RXENMCOMMAALIGN0_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_RXENMCOMMAALIGN1_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_RXENPCOMMAALIGN0_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_RXENPCOMMAALIGN1_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_RXENPRBSTST00_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_RXENPRBSTST01_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_RXENPRBSTST10_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_RXENPRBSTST11_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_RXENSAMPLEALIGN0_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_RXENSAMPLEALIGN1_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_RXGEARBOXSLIP0_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_RXGEARBOXSLIP1_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_RXPOLARITY0_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_RXPOLARITY1_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_RXSLIDE0_RXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_RXSLIDE1_RXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXBYPASS8B10B00_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXBYPASS8B10B01_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXBYPASS8B10B02_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXBYPASS8B10B03_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXBYPASS8B10B10_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXBYPASS8B10B11_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXBYPASS8B10B12_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXBYPASS8B10B13_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXCHARDISPMODE00_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXCHARDISPMODE01_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXCHARDISPMODE02_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXCHARDISPMODE03_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXCHARDISPMODE10_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXCHARDISPMODE11_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXCHARDISPMODE12_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXCHARDISPMODE13_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXCHARDISPVAL00_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXCHARDISPVAL01_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXCHARDISPVAL02_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXCHARDISPVAL03_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXCHARDISPVAL10_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXCHARDISPVAL11_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXCHARDISPVAL12_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXCHARDISPVAL13_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXCHARISK00_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXCHARISK01_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXCHARISK02_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXCHARISK03_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXCHARISK10_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXCHARISK11_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXCHARISK12_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXCHARISK13_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXCOMSTART0_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXCOMSTART1_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXCOMTYPE0_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXCOMTYPE1_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA00_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA010_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA011_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA012_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA013_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA014_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA015_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA016_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA017_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA018_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA019_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA01_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA020_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA021_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA022_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA023_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA024_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA025_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA026_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA027_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA028_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA029_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA02_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA030_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA031_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA03_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA04_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA05_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA06_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA07_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA08_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA09_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA10_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA110_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA111_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA112_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA113_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA114_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA115_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA116_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA117_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA118_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA119_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA11_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA120_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA121_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA122_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA123_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA124_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA125_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA126_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA127_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA128_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA129_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA12_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA130_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA131_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA13_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA14_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA15_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA16_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA17_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA18_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDATA19_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDETECTRX0_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXDETECTRX1_TXUSRCLK21_posedge : STD_ULOGIC := '0';
        variable Tviol_TXELECIDLE0_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXELECIDLE1_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXENC8B10BUSE0_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXENC8B10BUSE1_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXENPRBSTST00_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXENPRBSTST01_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXENPRBSTST10_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXENPRBSTST11_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXHEADER00_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXHEADER01_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXHEADER02_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXHEADER10_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXHEADER11_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXHEADER12_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXINHIBIT0_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXINHIBIT1_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXPOLARITY0_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXPOLARITY1_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXSEQUENCE00_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXSEQUENCE01_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXSEQUENCE02_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXSEQUENCE03_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXSEQUENCE04_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXSEQUENCE05_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXSEQUENCE06_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXSEQUENCE10_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXSEQUENCE11_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXSEQUENCE12_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXSEQUENCE13_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXSEQUENCE14_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXSEQUENCE15_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXSEQUENCE16_TXUSRCLK21_posedge : STD_ULOGIC := '0';
	variable Tviol_TXSTARTSEQ0_TXUSRCLK20_posedge : STD_ULOGIC := '0';
	variable Tviol_TXSTARTSEQ1_TXUSRCLK21_posedge : STD_ULOGIC := '0';

	variable  REFCLKOUT_GlitchData : VitalGlitchDataType;
	variable  RXRECCLK0_GlitchData : VitalGlitchDataType;
	variable  TXOUTCLK0_GlitchData : VitalGlitchDataType;
	variable  RXRECCLK1_GlitchData : VitalGlitchDataType;
	variable  TXOUTCLK1_GlitchData : VitalGlitchDataType;
	variable  TXP0_GlitchData : VitalGlitchDataType;
	variable  TXN0_GlitchData : VitalGlitchDataType;
	variable  TXP1_GlitchData : VitalGlitchDataType;
	variable  TXN1_GlitchData : VitalGlitchDataType;
	variable  RXDATA00_GlitchData : VitalGlitchDataType;
	variable  RXDATA01_GlitchData : VitalGlitchDataType;
	variable  RXDATA02_GlitchData : VitalGlitchDataType;
	variable  RXDATA03_GlitchData : VitalGlitchDataType;
	variable  RXDATA04_GlitchData : VitalGlitchDataType;
	variable  RXDATA05_GlitchData : VitalGlitchDataType;
	variable  RXDATA06_GlitchData : VitalGlitchDataType;
	variable  RXDATA07_GlitchData : VitalGlitchDataType;
	variable  RXDATA08_GlitchData : VitalGlitchDataType;
	variable  RXDATA09_GlitchData : VitalGlitchDataType;
	variable  RXDATA010_GlitchData : VitalGlitchDataType;
	variable  RXDATA011_GlitchData : VitalGlitchDataType;
	variable  RXDATA012_GlitchData : VitalGlitchDataType;
	variable  RXDATA013_GlitchData : VitalGlitchDataType;
	variable  RXDATA014_GlitchData : VitalGlitchDataType;
	variable  RXDATA015_GlitchData : VitalGlitchDataType;
	variable  RXDATA016_GlitchData : VitalGlitchDataType;
	variable  RXDATA017_GlitchData : VitalGlitchDataType;
	variable  RXDATA018_GlitchData : VitalGlitchDataType;
	variable  RXDATA019_GlitchData : VitalGlitchDataType;
	variable  RXDATA020_GlitchData : VitalGlitchDataType;
	variable  RXDATA021_GlitchData : VitalGlitchDataType;
	variable  RXDATA022_GlitchData : VitalGlitchDataType;
	variable  RXDATA023_GlitchData : VitalGlitchDataType;
	variable  RXDATA024_GlitchData : VitalGlitchDataType;
	variable  RXDATA025_GlitchData : VitalGlitchDataType;
	variable  RXDATA026_GlitchData : VitalGlitchDataType;
	variable  RXDATA027_GlitchData : VitalGlitchDataType;
	variable  RXDATA028_GlitchData : VitalGlitchDataType;
	variable  RXDATA029_GlitchData : VitalGlitchDataType;
	variable  RXDATA030_GlitchData : VitalGlitchDataType;
	variable  RXDATA031_GlitchData : VitalGlitchDataType;
	variable  RXNOTINTABLE00_GlitchData : VitalGlitchDataType;
	variable  RXNOTINTABLE01_GlitchData : VitalGlitchDataType;
	variable  RXNOTINTABLE02_GlitchData : VitalGlitchDataType;
	variable  RXNOTINTABLE03_GlitchData : VitalGlitchDataType;
	variable  RXDISPERR00_GlitchData : VitalGlitchDataType;
	variable  RXDISPERR01_GlitchData : VitalGlitchDataType;
	variable  RXDISPERR02_GlitchData : VitalGlitchDataType;
	variable  RXDISPERR03_GlitchData : VitalGlitchDataType;
	variable  RXCHARISK00_GlitchData : VitalGlitchDataType;
	variable  RXCHARISK01_GlitchData : VitalGlitchDataType;
	variable  RXCHARISK02_GlitchData : VitalGlitchDataType;
	variable  RXCHARISK03_GlitchData : VitalGlitchDataType;
	variable  RXRUNDISP00_GlitchData : VitalGlitchDataType;
	variable  RXRUNDISP01_GlitchData : VitalGlitchDataType;
	variable  RXRUNDISP02_GlitchData : VitalGlitchDataType;
	variable  RXRUNDISP03_GlitchData : VitalGlitchDataType;
	variable  RXCHARISCOMMA00_GlitchData : VitalGlitchDataType;
	variable  RXCHARISCOMMA01_GlitchData : VitalGlitchDataType;
	variable  RXCHARISCOMMA02_GlitchData : VitalGlitchDataType;
	variable  RXCHARISCOMMA03_GlitchData : VitalGlitchDataType;
	variable  RXVALID0_GlitchData : VitalGlitchDataType;
	variable  RXDATA10_GlitchData : VitalGlitchDataType;
	variable  RXDATA11_GlitchData : VitalGlitchDataType;
	variable  RXDATA12_GlitchData : VitalGlitchDataType;
	variable  RXDATA13_GlitchData : VitalGlitchDataType;
	variable  RXDATA14_GlitchData : VitalGlitchDataType;
	variable  RXDATA15_GlitchData : VitalGlitchDataType;
	variable  RXDATA16_GlitchData : VitalGlitchDataType;
	variable  RXDATA17_GlitchData : VitalGlitchDataType;
	variable  RXDATA18_GlitchData : VitalGlitchDataType;
	variable  RXDATA19_GlitchData : VitalGlitchDataType;
	variable  RXDATA110_GlitchData : VitalGlitchDataType;
	variable  RXDATA111_GlitchData : VitalGlitchDataType;
	variable  RXDATA112_GlitchData : VitalGlitchDataType;
	variable  RXDATA113_GlitchData : VitalGlitchDataType;
	variable  RXDATA114_GlitchData : VitalGlitchDataType;
	variable  RXDATA115_GlitchData : VitalGlitchDataType;
	variable  RXDATA116_GlitchData : VitalGlitchDataType;
	variable  RXDATA117_GlitchData : VitalGlitchDataType;
	variable  RXDATA118_GlitchData : VitalGlitchDataType;
	variable  RXDATA119_GlitchData : VitalGlitchDataType;
	variable  RXDATA120_GlitchData : VitalGlitchDataType;
	variable  RXDATA121_GlitchData : VitalGlitchDataType;
	variable  RXDATA122_GlitchData : VitalGlitchDataType;
	variable  RXDATA123_GlitchData : VitalGlitchDataType;
	variable  RXDATA124_GlitchData : VitalGlitchDataType;
	variable  RXDATA125_GlitchData : VitalGlitchDataType;
	variable  RXDATA126_GlitchData : VitalGlitchDataType;
	variable  RXDATA127_GlitchData : VitalGlitchDataType;
	variable  RXDATA128_GlitchData : VitalGlitchDataType;
	variable  RXDATA129_GlitchData : VitalGlitchDataType;
	variable  RXDATA130_GlitchData : VitalGlitchDataType;
	variable  RXDATA131_GlitchData : VitalGlitchDataType;
	variable  RXNOTINTABLE10_GlitchData : VitalGlitchDataType;
	variable  RXNOTINTABLE11_GlitchData : VitalGlitchDataType;
	variable  RXNOTINTABLE12_GlitchData : VitalGlitchDataType;
	variable  RXNOTINTABLE13_GlitchData : VitalGlitchDataType;
	variable  RXDISPERR10_GlitchData : VitalGlitchDataType;
	variable  RXDISPERR11_GlitchData : VitalGlitchDataType;
	variable  RXDISPERR12_GlitchData : VitalGlitchDataType;
	variable  RXDISPERR13_GlitchData : VitalGlitchDataType;
	variable  RXCHARISK10_GlitchData : VitalGlitchDataType;
	variable  RXCHARISK11_GlitchData : VitalGlitchDataType;
	variable  RXCHARISK12_GlitchData : VitalGlitchDataType;
	variable  RXCHARISK13_GlitchData : VitalGlitchDataType;
	variable  RXRUNDISP10_GlitchData : VitalGlitchDataType;
	variable  RXRUNDISP11_GlitchData : VitalGlitchDataType;
	variable  RXRUNDISP12_GlitchData : VitalGlitchDataType;
	variable  RXRUNDISP13_GlitchData : VitalGlitchDataType;
	variable  RXCHARISCOMMA10_GlitchData : VitalGlitchDataType;
	variable  RXCHARISCOMMA11_GlitchData : VitalGlitchDataType;
	variable  RXCHARISCOMMA12_GlitchData : VitalGlitchDataType;
	variable  RXCHARISCOMMA13_GlitchData : VitalGlitchDataType;
	variable  RXVALID1_GlitchData : VitalGlitchDataType;
	variable  RESETDONE0_GlitchData : VitalGlitchDataType;
	variable  RESETDONE1_GlitchData : VitalGlitchDataType;
	variable  TXKERR00_GlitchData : VitalGlitchDataType;
	variable  TXKERR01_GlitchData : VitalGlitchDataType;
	variable  TXKERR02_GlitchData : VitalGlitchDataType;
	variable  TXKERR03_GlitchData : VitalGlitchDataType;
	variable  TXRUNDISP00_GlitchData : VitalGlitchDataType;
	variable  TXRUNDISP01_GlitchData : VitalGlitchDataType;
	variable  TXRUNDISP02_GlitchData : VitalGlitchDataType;
	variable  TXRUNDISP03_GlitchData : VitalGlitchDataType;
	variable  TXBUFSTATUS00_GlitchData : VitalGlitchDataType;
	variable  TXBUFSTATUS01_GlitchData : VitalGlitchDataType;
	variable  TXKERR10_GlitchData : VitalGlitchDataType;
	variable  TXKERR11_GlitchData : VitalGlitchDataType;
	variable  TXKERR12_GlitchData : VitalGlitchDataType;
	variable  TXKERR13_GlitchData : VitalGlitchDataType;
	variable  TXRUNDISP10_GlitchData : VitalGlitchDataType;
	variable  TXRUNDISP11_GlitchData : VitalGlitchDataType;
	variable  TXRUNDISP12_GlitchData : VitalGlitchDataType;
	variable  TXRUNDISP13_GlitchData : VitalGlitchDataType;
	variable  TXBUFSTATUS10_GlitchData : VitalGlitchDataType;
	variable  TXBUFSTATUS11_GlitchData : VitalGlitchDataType;
	variable  RXCOMMADET0_GlitchData : VitalGlitchDataType;
	variable  RXBYTEREALIGN0_GlitchData : VitalGlitchDataType;
	variable  RXBYTEISALIGNED0_GlitchData : VitalGlitchDataType;
	variable  RXLOSSOFSYNC00_GlitchData : VitalGlitchDataType;
	variable  RXLOSSOFSYNC01_GlitchData : VitalGlitchDataType;
	variable  RXCHBONDO00_GlitchData : VitalGlitchDataType;
	variable  RXCHBONDO01_GlitchData : VitalGlitchDataType;
	variable  RXCHBONDO02_GlitchData : VitalGlitchDataType;
	variable  RXCHBONDO03_GlitchData : VitalGlitchDataType;
	variable  RXCHANBONDSEQ0_GlitchData : VitalGlitchDataType;
	variable  RXCHANREALIGN0_GlitchData : VitalGlitchDataType;
	variable  RXCHANISALIGNED0_GlitchData : VitalGlitchDataType;
	variable  RXBUFSTATUS00_GlitchData : VitalGlitchDataType;
	variable  RXBUFSTATUS01_GlitchData : VitalGlitchDataType;
	variable  RXBUFSTATUS02_GlitchData : VitalGlitchDataType;
	variable  RXCOMMADET1_GlitchData : VitalGlitchDataType;
	variable  RXBYTEREALIGN1_GlitchData : VitalGlitchDataType;
	variable  RXBYTEISALIGNED1_GlitchData : VitalGlitchDataType;
	variable  RXLOSSOFSYNC10_GlitchData : VitalGlitchDataType;
	variable  RXLOSSOFSYNC11_GlitchData : VitalGlitchDataType;
	variable  RXCHBONDO10_GlitchData : VitalGlitchDataType;
	variable  RXCHBONDO11_GlitchData : VitalGlitchDataType;
	variable  RXCHBONDO12_GlitchData : VitalGlitchDataType;
	variable  RXCHBONDO13_GlitchData : VitalGlitchDataType;
	variable  RXCHANBONDSEQ1_GlitchData : VitalGlitchDataType;
	variable  RXCHANREALIGN1_GlitchData : VitalGlitchDataType;
	variable  RXCHANISALIGNED1_GlitchData : VitalGlitchDataType;
	variable  RXBUFSTATUS10_GlitchData : VitalGlitchDataType;
	variable  RXBUFSTATUS11_GlitchData : VitalGlitchDataType;
	variable  RXBUFSTATUS12_GlitchData : VitalGlitchDataType;
	variable  PHYSTATUS0_GlitchData : VitalGlitchDataType;
	variable  PHYSTATUS1_GlitchData : VitalGlitchDataType;
	variable  RXELECIDLE0_GlitchData : VitalGlitchDataType;
	variable  RXSTATUS00_GlitchData : VitalGlitchDataType;
	variable  RXSTATUS01_GlitchData : VitalGlitchDataType;
	variable  RXSTATUS02_GlitchData : VitalGlitchDataType;
	variable  RXCLKCORCNT00_GlitchData : VitalGlitchDataType;
	variable  RXCLKCORCNT01_GlitchData : VitalGlitchDataType;
	variable  RXCLKCORCNT02_GlitchData : VitalGlitchDataType;
	variable  RXELECIDLE1_GlitchData : VitalGlitchDataType;
	variable  RXSTATUS10_GlitchData : VitalGlitchDataType;
	variable  RXSTATUS11_GlitchData : VitalGlitchDataType;
	variable  RXSTATUS12_GlitchData : VitalGlitchDataType;
	variable  RXCLKCORCNT10_GlitchData : VitalGlitchDataType;
	variable  RXCLKCORCNT11_GlitchData : VitalGlitchDataType;
	variable  RXCLKCORCNT12_GlitchData : VitalGlitchDataType;
	variable  PLLLKDET_GlitchData : VitalGlitchDataType;
	variable  RXPRBSERR0_GlitchData : VitalGlitchDataType;
	variable  RXPRBSERR1_GlitchData : VitalGlitchDataType;
	variable  DO0_GlitchData : VitalGlitchDataType;
	variable  DO1_GlitchData : VitalGlitchDataType;
	variable  DO2_GlitchData : VitalGlitchDataType;
	variable  DO3_GlitchData : VitalGlitchDataType;
	variable  DO4_GlitchData : VitalGlitchDataType;
	variable  DO5_GlitchData : VitalGlitchDataType;
	variable  DO6_GlitchData : VitalGlitchDataType;
	variable  DO7_GlitchData : VitalGlitchDataType;
	variable  DO8_GlitchData : VitalGlitchDataType;
	variable  DO9_GlitchData : VitalGlitchDataType;
	variable  DO10_GlitchData : VitalGlitchDataType;
	variable  DO11_GlitchData : VitalGlitchDataType;
	variable  DO12_GlitchData : VitalGlitchDataType;
	variable  DO13_GlitchData : VitalGlitchDataType;
	variable  DO14_GlitchData : VitalGlitchDataType;
	variable  DO15_GlitchData : VitalGlitchDataType;
	variable  DRDY_GlitchData : VitalGlitchDataType;
	variable  RXOVERSAMPLEERR0_GlitchData : VitalGlitchDataType;
	variable  RXOVERSAMPLEERR1_GlitchData : VitalGlitchDataType;
	variable  TXGEARBOXREADY0_GlitchData : VitalGlitchDataType;
	variable  RXHEADER00_GlitchData : VitalGlitchDataType;
	variable  RXHEADER01_GlitchData : VitalGlitchDataType;
	variable  RXHEADER02_GlitchData : VitalGlitchDataType;
	variable  RXHEADERVALID0_GlitchData : VitalGlitchDataType;
	variable  RXDATAVALID0_GlitchData : VitalGlitchDataType;
	variable  RXSTARTOFSEQ0_GlitchData : VitalGlitchDataType;
	variable  TXGEARBOXREADY1_GlitchData : VitalGlitchDataType;
	variable  RXHEADER10_GlitchData : VitalGlitchDataType;
	variable  RXHEADER11_GlitchData : VitalGlitchDataType;
	variable  RXHEADER12_GlitchData : VitalGlitchDataType;
	variable  RXHEADERVALID1_GlitchData : VitalGlitchDataType;
	variable  RXDATAVALID1_GlitchData : VitalGlitchDataType;
	variable  RXSTARTOFSEQ1_GlitchData : VitalGlitchDataType;
	variable  DFECLKDLYADJMONITOR00_GlitchData : VitalGlitchDataType;
	variable  DFECLKDLYADJMONITOR01_GlitchData : VitalGlitchDataType;
	variable  DFECLKDLYADJMONITOR02_GlitchData : VitalGlitchDataType;
	variable  DFECLKDLYADJMONITOR03_GlitchData : VitalGlitchDataType;
	variable  DFECLKDLYADJMONITOR04_GlitchData : VitalGlitchDataType;
	variable  DFECLKDLYADJMONITOR05_GlitchData : VitalGlitchDataType;
	variable  DFEEYEDACMONITOR00_GlitchData : VitalGlitchDataType;
	variable  DFEEYEDACMONITOR01_GlitchData : VitalGlitchDataType;
	variable  DFEEYEDACMONITOR02_GlitchData : VitalGlitchDataType;
	variable  DFEEYEDACMONITOR03_GlitchData : VitalGlitchDataType;
	variable  DFEEYEDACMONITOR04_GlitchData : VitalGlitchDataType;
	variable  DFETAP1MONITOR00_GlitchData : VitalGlitchDataType;
	variable  DFETAP1MONITOR01_GlitchData : VitalGlitchDataType;
	variable  DFETAP1MONITOR02_GlitchData : VitalGlitchDataType;
	variable  DFETAP1MONITOR03_GlitchData : VitalGlitchDataType;
	variable  DFETAP1MONITOR04_GlitchData : VitalGlitchDataType;
	variable  DFETAP2MONITOR00_GlitchData : VitalGlitchDataType;
	variable  DFETAP2MONITOR01_GlitchData : VitalGlitchDataType;
	variable  DFETAP2MONITOR02_GlitchData : VitalGlitchDataType;
	variable  DFETAP2MONITOR03_GlitchData : VitalGlitchDataType;
	variable  DFETAP2MONITOR04_GlitchData : VitalGlitchDataType;
	variable  DFETAP3MONITOR00_GlitchData : VitalGlitchDataType;
	variable  DFETAP3MONITOR01_GlitchData : VitalGlitchDataType;
	variable  DFETAP3MONITOR02_GlitchData : VitalGlitchDataType;
	variable  DFETAP3MONITOR03_GlitchData : VitalGlitchDataType;
	variable  DFETAP4MONITOR00_GlitchData : VitalGlitchDataType;
	variable  DFETAP4MONITOR01_GlitchData : VitalGlitchDataType;
	variable  DFETAP4MONITOR02_GlitchData : VitalGlitchDataType;
	variable  DFETAP4MONITOR03_GlitchData : VitalGlitchDataType;
	variable  DFECLKDLYADJMONITOR10_GlitchData : VitalGlitchDataType;
	variable  DFECLKDLYADJMONITOR11_GlitchData : VitalGlitchDataType;
	variable  DFECLKDLYADJMONITOR12_GlitchData : VitalGlitchDataType;
	variable  DFECLKDLYADJMONITOR13_GlitchData : VitalGlitchDataType;
	variable  DFECLKDLYADJMONITOR14_GlitchData : VitalGlitchDataType;
	variable  DFECLKDLYADJMONITOR15_GlitchData : VitalGlitchDataType;
	variable  DFEEYEDACMONITOR10_GlitchData : VitalGlitchDataType;
	variable  DFEEYEDACMONITOR11_GlitchData : VitalGlitchDataType;
	variable  DFEEYEDACMONITOR12_GlitchData : VitalGlitchDataType;
	variable  DFEEYEDACMONITOR13_GlitchData : VitalGlitchDataType;
	variable  DFEEYEDACMONITOR14_GlitchData : VitalGlitchDataType;
	variable  DFETAP1MONITOR10_GlitchData : VitalGlitchDataType;
	variable  DFETAP1MONITOR11_GlitchData : VitalGlitchDataType;
	variable  DFETAP1MONITOR12_GlitchData : VitalGlitchDataType;
	variable  DFETAP1MONITOR13_GlitchData : VitalGlitchDataType;
	variable  DFETAP1MONITOR14_GlitchData : VitalGlitchDataType;
	variable  DFETAP2MONITOR10_GlitchData : VitalGlitchDataType;
	variable  DFETAP2MONITOR11_GlitchData : VitalGlitchDataType;
	variable  DFETAP2MONITOR12_GlitchData : VitalGlitchDataType;
	variable  DFETAP2MONITOR13_GlitchData : VitalGlitchDataType;
	variable  DFETAP2MONITOR14_GlitchData : VitalGlitchDataType;
	variable  DFETAP3MONITOR10_GlitchData : VitalGlitchDataType;
	variable  DFETAP3MONITOR11_GlitchData : VitalGlitchDataType;
	variable  DFETAP3MONITOR12_GlitchData : VitalGlitchDataType;
	variable  DFETAP3MONITOR13_GlitchData : VitalGlitchDataType;
	variable  DFETAP4MONITOR10_GlitchData : VitalGlitchDataType;
	variable  DFETAP4MONITOR11_GlitchData : VitalGlitchDataType;
	variable  DFETAP4MONITOR12_GlitchData : VitalGlitchDataType;
	variable  DFETAP4MONITOR13_GlitchData : VitalGlitchDataType;
	variable  DFESENSCAL00_GlitchData : VitalGlitchDataType;
	variable  DFESENSCAL01_GlitchData : VitalGlitchDataType;
	variable  DFESENSCAL02_GlitchData : VitalGlitchDataType;
	variable  DFESENSCAL10_GlitchData : VitalGlitchDataType;
	variable  DFESENSCAL11_GlitchData : VitalGlitchDataType;
	variable  DFESENSCAL12_GlitchData : VitalGlitchDataType;
begin

     if (TimingChecksOn) then
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA00_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA00_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(0),
	TestSignalName => "TXDATA0(0)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(0),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(0),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(0),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(0),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA01_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA01_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(1),
	TestSignalName => "TXDATA0(1)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(1),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(1),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(1),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(1),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA02_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA02_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(2),
	TestSignalName => "TXDATA0(2)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(2),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(2),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(2),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(2),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(2),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA03_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA03_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(3),
	TestSignalName => "TXDATA0(3)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(3),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(3),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(3),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(3),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(3),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA04_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA04_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(4),
	TestSignalName => "TXDATA0(4)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(4),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(4),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(4),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(4),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(4),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA05_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA05_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(5),
	TestSignalName => "TXDATA0(5)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(5),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(5),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(5),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(5),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(5),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA06_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA06_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(6),
	TestSignalName => "TXDATA0(6)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(6),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(6),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(6),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(6),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(6),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA07_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA07_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(7),
	TestSignalName => "TXDATA0(7)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(7),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(7),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(7),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(7),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(7),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA08_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA08_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(8),
	TestSignalName => "TXDATA0(8)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(8),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(8),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(8),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(8),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(8),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA09_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA09_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(9),
	TestSignalName => "TXDATA0(9)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(9),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(9),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(9),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(9),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(9),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA010_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA010_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(10),
	TestSignalName => "TXDATA0(10)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(10),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(10),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(10),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(10),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(10),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA011_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA011_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(11),
	TestSignalName => "TXDATA0(11)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(11),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(11),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(11),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(11),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(11),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA012_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA012_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(12),
	TestSignalName => "TXDATA0(12)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(12),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(12),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(12),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(12),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(12),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA013_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA013_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(13),
	TestSignalName => "TXDATA0(13)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(13),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(13),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(13),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(13),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(13),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA014_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA014_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(14),
	TestSignalName => "TXDATA0(14)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(14),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(14),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(14),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(14),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(14),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA015_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA015_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(15),
	TestSignalName => "TXDATA0(15)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(15),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(15),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(15),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(15),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(15),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA016_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA016_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(16),
	TestSignalName => "TXDATA0(16)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(16),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(16),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(16),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(16),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(16),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA017_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA017_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(17),
	TestSignalName => "TXDATA0(17)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(17),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(17),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(17),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(17),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(17),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA018_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA018_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(18),
	TestSignalName => "TXDATA0(18)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(18),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(18),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(18),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(18),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(18),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA019_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA019_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(19),
	TestSignalName => "TXDATA0(19)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(19),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(19),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(19),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(19),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(19),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA020_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA020_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(20),
	TestSignalName => "TXDATA0(20)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(20),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(20),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(20),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(20),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(20),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA021_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA021_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(21),
	TestSignalName => "TXDATA0(21)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(21),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(21),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(21),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(21),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(21),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA022_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA022_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(22),
	TestSignalName => "TXDATA0(22)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(22),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(22),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(22),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(22),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(22),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA023_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA023_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(23),
	TestSignalName => "TXDATA0(23)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(23),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(23),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(23),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(23),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(23),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA024_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA024_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(24),
	TestSignalName => "TXDATA0(24)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(24),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(24),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(24),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(24),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(24),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA025_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA025_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(25),
	TestSignalName => "TXDATA0(25)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(25),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(25),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(25),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(25),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(25),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA026_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA026_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(26),
	TestSignalName => "TXDATA0(26)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(26),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(26),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(26),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(26),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(26),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA027_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA027_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(27),
	TestSignalName => "TXDATA0(27)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(27),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(27),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(27),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(27),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(27),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA028_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA028_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(28),
	TestSignalName => "TXDATA0(28)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(28),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(28),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(28),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(28),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(28),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA029_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA029_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(29),
	TestSignalName => "TXDATA0(29)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(29),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(29),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(29),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(29),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(29),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA030_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA030_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(30),
	TestSignalName => "TXDATA0(30)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(30),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(30),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(30),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(30),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(30),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA031_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXDATA031_TXUSRCLK20_posedge,
	TestSignal => TXDATA0_dly(31),
	TestSignalName => "TXDATA0(31)",
	TestDelay => tisd_TXDATA0_TXUSRCLK20(31),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(31),
	SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(31),
	HoldLow => thold_TXDATA0_TXUSRCLK20_posedge_posedge(31),
	HoldHigh => thold_TXDATA0_TXUSRCLK20_negedge_posedge(31),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXBYPASS8B10B00_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXBYPASS8B10B00_TXUSRCLK20_posedge,
	TestSignal => TXBYPASS8B10B0_dly(0),
	TestSignalName => "TXBYPASS8B10B0(0)",
	TestDelay => tisd_TXBYPASS8B10B0_TXUSRCLK20(0),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXBYPASS8B10B0_TXUSRCLK20_posedge_posedge(0),
	SetupLow => tsetup_TXBYPASS8B10B0_TXUSRCLK20_negedge_posedge(0),
	HoldLow => thold_TXBYPASS8B10B0_TXUSRCLK20_posedge_posedge(0),
	HoldHigh => thold_TXBYPASS8B10B0_TXUSRCLK20_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXBYPASS8B10B01_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXBYPASS8B10B01_TXUSRCLK20_posedge,
	TestSignal => TXBYPASS8B10B0_dly(1),
	TestSignalName => "TXBYPASS8B10B0(1)",
	TestDelay => tisd_TXBYPASS8B10B0_TXUSRCLK20(1),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXBYPASS8B10B0_TXUSRCLK20_posedge_posedge(1),
	SetupLow => tsetup_TXBYPASS8B10B0_TXUSRCLK20_negedge_posedge(1),
	HoldLow => thold_TXBYPASS8B10B0_TXUSRCLK20_posedge_posedge(1),
	HoldHigh => thold_TXBYPASS8B10B0_TXUSRCLK20_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXBYPASS8B10B02_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXBYPASS8B10B02_TXUSRCLK20_posedge,
	TestSignal => TXBYPASS8B10B0_dly(2),
	TestSignalName => "TXBYPASS8B10B0(2)",
	TestDelay => tisd_TXBYPASS8B10B0_TXUSRCLK20(2),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXBYPASS8B10B0_TXUSRCLK20_posedge_posedge(2),
	SetupLow => tsetup_TXBYPASS8B10B0_TXUSRCLK20_negedge_posedge(2),
	HoldLow => thold_TXBYPASS8B10B0_TXUSRCLK20_posedge_posedge(2),
	HoldHigh => thold_TXBYPASS8B10B0_TXUSRCLK20_negedge_posedge(2),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXBYPASS8B10B03_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXBYPASS8B10B03_TXUSRCLK20_posedge,
	TestSignal => TXBYPASS8B10B0_dly(3),
	TestSignalName => "TXBYPASS8B10B0(3)",
	TestDelay => tisd_TXBYPASS8B10B0_TXUSRCLK20(3),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXBYPASS8B10B0_TXUSRCLK20_posedge_posedge(3),
	SetupLow => tsetup_TXBYPASS8B10B0_TXUSRCLK20_negedge_posedge(3),
	HoldLow => thold_TXBYPASS8B10B0_TXUSRCLK20_posedge_posedge(3),
	HoldHigh => thold_TXBYPASS8B10B0_TXUSRCLK20_negedge_posedge(3),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXCHARISK00_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXCHARISK00_TXUSRCLK20_posedge,
	TestSignal => TXCHARISK0_dly(0),
	TestSignalName => "TXCHARISK0(0)",
	TestDelay => tisd_TXCHARISK0_TXUSRCLK20(0),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXCHARISK0_TXUSRCLK20_posedge_posedge(0),
	SetupLow => tsetup_TXCHARISK0_TXUSRCLK20_negedge_posedge(0),
	HoldLow => thold_TXCHARISK0_TXUSRCLK20_posedge_posedge(0),
	HoldHigh => thold_TXCHARISK0_TXUSRCLK20_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXCHARISK01_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXCHARISK01_TXUSRCLK20_posedge,
	TestSignal => TXCHARISK0_dly(1),
	TestSignalName => "TXCHARISK0(1)",
	TestDelay => tisd_TXCHARISK0_TXUSRCLK20(1),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXCHARISK0_TXUSRCLK20_posedge_posedge(1),
	SetupLow => tsetup_TXCHARISK0_TXUSRCLK20_negedge_posedge(1),
	HoldLow => thold_TXCHARISK0_TXUSRCLK20_posedge_posedge(1),
	HoldHigh => thold_TXCHARISK0_TXUSRCLK20_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXCHARISK02_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXCHARISK02_TXUSRCLK20_posedge,
	TestSignal => TXCHARISK0_dly(2),
	TestSignalName => "TXCHARISK0(2)",
	TestDelay => tisd_TXCHARISK0_TXUSRCLK20(2),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXCHARISK0_TXUSRCLK20_posedge_posedge(2),
	SetupLow => tsetup_TXCHARISK0_TXUSRCLK20_negedge_posedge(2),
	HoldLow => thold_TXCHARISK0_TXUSRCLK20_posedge_posedge(2),
	HoldHigh => thold_TXCHARISK0_TXUSRCLK20_negedge_posedge(2),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXCHARISK03_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXCHARISK03_TXUSRCLK20_posedge,
	TestSignal => TXCHARISK0_dly(3),
	TestSignalName => "TXCHARISK0(3)",
	TestDelay => tisd_TXCHARISK0_TXUSRCLK20(3),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXCHARISK0_TXUSRCLK20_posedge_posedge(3),
	SetupLow => tsetup_TXCHARISK0_TXUSRCLK20_negedge_posedge(3),
	HoldLow => thold_TXCHARISK0_TXUSRCLK20_posedge_posedge(3),
	HoldHigh => thold_TXCHARISK0_TXUSRCLK20_negedge_posedge(3),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXCHARDISPMODE00_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXCHARDISPMODE00_TXUSRCLK20_posedge,
	TestSignal => TXCHARDISPMODE0_dly(0),
	TestSignalName => "TXCHARDISPMODE0(0)",
	TestDelay => tisd_TXCHARDISPMODE0_TXUSRCLK20(0),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXCHARDISPMODE0_TXUSRCLK20_posedge_posedge(0),
	SetupLow => tsetup_TXCHARDISPMODE0_TXUSRCLK20_negedge_posedge(0),
	HoldLow => thold_TXCHARDISPMODE0_TXUSRCLK20_posedge_posedge(0),
	HoldHigh => thold_TXCHARDISPMODE0_TXUSRCLK20_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXCHARDISPMODE01_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXCHARDISPMODE01_TXUSRCLK20_posedge,
	TestSignal => TXCHARDISPMODE0_dly(1),
	TestSignalName => "TXCHARDISPMODE0(1)",
	TestDelay => tisd_TXCHARDISPMODE0_TXUSRCLK20(1),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXCHARDISPMODE0_TXUSRCLK20_posedge_posedge(1),
	SetupLow => tsetup_TXCHARDISPMODE0_TXUSRCLK20_negedge_posedge(1),
	HoldLow => thold_TXCHARDISPMODE0_TXUSRCLK20_posedge_posedge(1),
	HoldHigh => thold_TXCHARDISPMODE0_TXUSRCLK20_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXCHARDISPMODE02_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXCHARDISPMODE02_TXUSRCLK20_posedge,
	TestSignal => TXCHARDISPMODE0_dly(2),
	TestSignalName => "TXCHARDISPMODE0(2)",
	TestDelay => tisd_TXCHARDISPMODE0_TXUSRCLK20(2),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXCHARDISPMODE0_TXUSRCLK20_posedge_posedge(2),
	SetupLow => tsetup_TXCHARDISPMODE0_TXUSRCLK20_negedge_posedge(2),
	HoldLow => thold_TXCHARDISPMODE0_TXUSRCLK20_posedge_posedge(2),
	HoldHigh => thold_TXCHARDISPMODE0_TXUSRCLK20_negedge_posedge(2),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXCHARDISPMODE03_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXCHARDISPMODE03_TXUSRCLK20_posedge,
	TestSignal => TXCHARDISPMODE0_dly(3),
	TestSignalName => "TXCHARDISPMODE0(3)",
	TestDelay => tisd_TXCHARDISPMODE0_TXUSRCLK20(3),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXCHARDISPMODE0_TXUSRCLK20_posedge_posedge(3),
	SetupLow => tsetup_TXCHARDISPMODE0_TXUSRCLK20_negedge_posedge(3),
	HoldLow => thold_TXCHARDISPMODE0_TXUSRCLK20_posedge_posedge(3),
	HoldHigh => thold_TXCHARDISPMODE0_TXUSRCLK20_negedge_posedge(3),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXCHARDISPVAL00_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXCHARDISPVAL00_TXUSRCLK20_posedge,
	TestSignal => TXCHARDISPVAL0_dly(0),
	TestSignalName => "TXCHARDISPVAL0(0)",
	TestDelay => tisd_TXCHARDISPVAL0_TXUSRCLK20(0),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXCHARDISPVAL0_TXUSRCLK20_posedge_posedge(0),
	SetupLow => tsetup_TXCHARDISPVAL0_TXUSRCLK20_negedge_posedge(0),
	HoldLow => thold_TXCHARDISPVAL0_TXUSRCLK20_posedge_posedge(0),
	HoldHigh => thold_TXCHARDISPVAL0_TXUSRCLK20_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXCHARDISPVAL01_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXCHARDISPVAL01_TXUSRCLK20_posedge,
	TestSignal => TXCHARDISPVAL0_dly(1),
	TestSignalName => "TXCHARDISPVAL0(1)",
	TestDelay => tisd_TXCHARDISPVAL0_TXUSRCLK20(1),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXCHARDISPVAL0_TXUSRCLK20_posedge_posedge(1),
	SetupLow => tsetup_TXCHARDISPVAL0_TXUSRCLK20_negedge_posedge(1),
	HoldLow => thold_TXCHARDISPVAL0_TXUSRCLK20_posedge_posedge(1),
	HoldHigh => thold_TXCHARDISPVAL0_TXUSRCLK20_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXCHARDISPVAL02_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXCHARDISPVAL02_TXUSRCLK20_posedge,
	TestSignal => TXCHARDISPVAL0_dly(2),
	TestSignalName => "TXCHARDISPVAL0(2)",
	TestDelay => tisd_TXCHARDISPVAL0_TXUSRCLK20(2),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXCHARDISPVAL0_TXUSRCLK20_posedge_posedge(2),
	SetupLow => tsetup_TXCHARDISPVAL0_TXUSRCLK20_negedge_posedge(2),
	HoldLow => thold_TXCHARDISPVAL0_TXUSRCLK20_posedge_posedge(2),
	HoldHigh => thold_TXCHARDISPVAL0_TXUSRCLK20_negedge_posedge(2),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXCHARDISPVAL03_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXCHARDISPVAL03_TXUSRCLK20_posedge,
	TestSignal => TXCHARDISPVAL0_dly(3),
	TestSignalName => "TXCHARDISPVAL0(3)",
	TestDelay => tisd_TXCHARDISPVAL0_TXUSRCLK20(3),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXCHARDISPVAL0_TXUSRCLK20_posedge_posedge(3),
	SetupLow => tsetup_TXCHARDISPVAL0_TXUSRCLK20_negedge_posedge(3),
	HoldLow => thold_TXCHARDISPVAL0_TXUSRCLK20_posedge_posedge(3),
	HoldHigh => thold_TXCHARDISPVAL0_TXUSRCLK20_negedge_posedge(3),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA10_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA10_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(0),
	TestSignalName => "TXDATA1(0)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(0),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(0),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(0),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(0),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA11_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA11_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(1),
	TestSignalName => "TXDATA1(1)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(1),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(1),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(1),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(1),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA12_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA12_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(2),
	TestSignalName => "TXDATA1(2)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(2),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(2),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(2),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(2),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(2),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA13_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA13_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(3),
	TestSignalName => "TXDATA1(3)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(3),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(3),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(3),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(3),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(3),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA14_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA14_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(4),
	TestSignalName => "TXDATA1(4)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(4),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(4),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(4),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(4),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(4),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA15_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA15_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(5),
	TestSignalName => "TXDATA1(5)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(5),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(5),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(5),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(5),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(5),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA16_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA16_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(6),
	TestSignalName => "TXDATA1(6)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(6),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(6),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(6),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(6),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(6),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA17_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA17_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(7),
	TestSignalName => "TXDATA1(7)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(7),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(7),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(7),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(7),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(7),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA18_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA18_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(8),
	TestSignalName => "TXDATA1(8)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(8),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(8),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(8),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(8),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(8),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA19_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA19_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(9),
	TestSignalName => "TXDATA1(9)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(9),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(9),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(9),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(9),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(9),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA110_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA110_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(10),
	TestSignalName => "TXDATA1(10)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(10),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(10),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(10),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(10),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(10),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA111_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA111_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(11),
	TestSignalName => "TXDATA1(11)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(11),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(11),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(11),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(11),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(11),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA112_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA112_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(12),
	TestSignalName => "TXDATA1(12)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(12),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(12),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(12),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(12),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(12),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA113_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA113_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(13),
	TestSignalName => "TXDATA1(13)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(13),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(13),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(13),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(13),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(13),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA114_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA114_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(14),
	TestSignalName => "TXDATA1(14)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(14),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(14),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(14),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(14),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(14),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA115_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA115_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(15),
	TestSignalName => "TXDATA1(15)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(15),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(15),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(15),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(15),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(15),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA116_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA116_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(16),
	TestSignalName => "TXDATA1(16)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(16),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(16),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(16),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(16),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(16),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA117_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA117_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(17),
	TestSignalName => "TXDATA1(17)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(17),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(17),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(17),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(17),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(17),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA118_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA118_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(18),
	TestSignalName => "TXDATA1(18)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(18),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(18),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(18),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(18),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(18),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA119_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA119_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(19),
	TestSignalName => "TXDATA1(19)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(19),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(19),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(19),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(19),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(19),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA120_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA120_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(20),
	TestSignalName => "TXDATA1(20)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(20),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(20),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(20),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(20),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(20),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA121_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA121_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(21),
	TestSignalName => "TXDATA1(21)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(21),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(21),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(21),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(21),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(21),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA122_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA122_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(22),
	TestSignalName => "TXDATA1(22)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(22),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(22),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(22),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(22),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(22),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA123_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA123_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(23),
	TestSignalName => "TXDATA1(23)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(23),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(23),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(23),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(23),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(23),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA124_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA124_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(24),
	TestSignalName => "TXDATA1(24)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(24),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(24),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(24),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(24),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(24),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA125_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA125_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(25),
	TestSignalName => "TXDATA1(25)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(25),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(25),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(25),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(25),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(25),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA126_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA126_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(26),
	TestSignalName => "TXDATA1(26)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(26),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(26),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(26),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(26),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(26),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA127_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA127_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(27),
	TestSignalName => "TXDATA1(27)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(27),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(27),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(27),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(27),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(27),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA128_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA128_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(28),
	TestSignalName => "TXDATA1(28)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(28),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(28),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(28),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(28),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(28),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA129_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA129_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(29),
	TestSignalName => "TXDATA1(29)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(29),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(29),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(29),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(29),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(29),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA130_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA130_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(30),
	TestSignalName => "TXDATA1(30)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(30),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(30),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(30),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(30),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(30),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXDATA131_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXDATA131_TXUSRCLK21_posedge,
	TestSignal => TXDATA1_dly(31),
	TestSignalName => "TXDATA1(31)",
	TestDelay => tisd_TXDATA1_TXUSRCLK21(31),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(31),
	SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(31),
	HoldLow => thold_TXDATA1_TXUSRCLK21_posedge_posedge(31),
	HoldHigh => thold_TXDATA1_TXUSRCLK21_negedge_posedge(31),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXBYPASS8B10B10_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXBYPASS8B10B10_TXUSRCLK21_posedge,
	TestSignal => TXBYPASS8B10B1_dly(0),
	TestSignalName => "TXBYPASS8B10B1(0)",
	TestDelay => tisd_TXBYPASS8B10B1_TXUSRCLK21(0),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXBYPASS8B10B1_TXUSRCLK21_posedge_posedge(0),
	SetupLow => tsetup_TXBYPASS8B10B1_TXUSRCLK21_negedge_posedge(0),
	HoldLow => thold_TXBYPASS8B10B1_TXUSRCLK21_posedge_posedge(0),
	HoldHigh => thold_TXBYPASS8B10B1_TXUSRCLK21_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXBYPASS8B10B11_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXBYPASS8B10B11_TXUSRCLK21_posedge,
	TestSignal => TXBYPASS8B10B1_dly(1),
	TestSignalName => "TXBYPASS8B10B1(1)",
	TestDelay => tisd_TXBYPASS8B10B1_TXUSRCLK21(1),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXBYPASS8B10B1_TXUSRCLK21_posedge_posedge(1),
	SetupLow => tsetup_TXBYPASS8B10B1_TXUSRCLK21_negedge_posedge(1),
	HoldLow => thold_TXBYPASS8B10B1_TXUSRCLK21_posedge_posedge(1),
	HoldHigh => thold_TXBYPASS8B10B1_TXUSRCLK21_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXBYPASS8B10B12_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXBYPASS8B10B12_TXUSRCLK21_posedge,
	TestSignal => TXBYPASS8B10B1_dly(2),
	TestSignalName => "TXBYPASS8B10B1(2)",
	TestDelay => tisd_TXBYPASS8B10B1_TXUSRCLK21(2),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXBYPASS8B10B1_TXUSRCLK21_posedge_posedge(2),
	SetupLow => tsetup_TXBYPASS8B10B1_TXUSRCLK21_negedge_posedge(2),
	HoldLow => thold_TXBYPASS8B10B1_TXUSRCLK21_posedge_posedge(2),
	HoldHigh => thold_TXBYPASS8B10B1_TXUSRCLK21_negedge_posedge(2),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXBYPASS8B10B13_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXBYPASS8B10B13_TXUSRCLK21_posedge,
	TestSignal => TXBYPASS8B10B1_dly(3),
	TestSignalName => "TXBYPASS8B10B1(3)",
	TestDelay => tisd_TXBYPASS8B10B1_TXUSRCLK21(3),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXBYPASS8B10B1_TXUSRCLK21_posedge_posedge(3),
	SetupLow => tsetup_TXBYPASS8B10B1_TXUSRCLK21_negedge_posedge(3),
	HoldLow => thold_TXBYPASS8B10B1_TXUSRCLK21_posedge_posedge(3),
	HoldHigh => thold_TXBYPASS8B10B1_TXUSRCLK21_negedge_posedge(3),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXCHARISK10_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXCHARISK10_TXUSRCLK21_posedge,
	TestSignal => TXCHARISK1_dly(0),
	TestSignalName => "TXCHARISK1(0)",
	TestDelay => tisd_TXCHARISK1_TXUSRCLK21(0),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXCHARISK1_TXUSRCLK21_posedge_posedge(0),
	SetupLow => tsetup_TXCHARISK1_TXUSRCLK21_negedge_posedge(0),
	HoldLow => thold_TXCHARISK1_TXUSRCLK21_posedge_posedge(0),
	HoldHigh => thold_TXCHARISK1_TXUSRCLK21_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXCHARISK11_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXCHARISK11_TXUSRCLK21_posedge,
	TestSignal => TXCHARISK1_dly(1),
	TestSignalName => "TXCHARISK1(1)",
	TestDelay => tisd_TXCHARISK1_TXUSRCLK21(1),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXCHARISK1_TXUSRCLK21_posedge_posedge(1),
	SetupLow => tsetup_TXCHARISK1_TXUSRCLK21_negedge_posedge(1),
	HoldLow => thold_TXCHARISK1_TXUSRCLK21_posedge_posedge(1),
	HoldHigh => thold_TXCHARISK1_TXUSRCLK21_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXCHARISK12_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXCHARISK12_TXUSRCLK21_posedge,
	TestSignal => TXCHARISK1_dly(2),
	TestSignalName => "TXCHARISK1(2)",
	TestDelay => tisd_TXCHARISK1_TXUSRCLK21(2),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXCHARISK1_TXUSRCLK21_posedge_posedge(2),
	SetupLow => tsetup_TXCHARISK1_TXUSRCLK21_negedge_posedge(2),
	HoldLow => thold_TXCHARISK1_TXUSRCLK21_posedge_posedge(2),
	HoldHigh => thold_TXCHARISK1_TXUSRCLK21_negedge_posedge(2),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXCHARISK13_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXCHARISK13_TXUSRCLK21_posedge,
	TestSignal => TXCHARISK1_dly(3),
	TestSignalName => "TXCHARISK1(3)",
	TestDelay => tisd_TXCHARISK1_TXUSRCLK21(3),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXCHARISK1_TXUSRCLK21_posedge_posedge(3),
	SetupLow => tsetup_TXCHARISK1_TXUSRCLK21_negedge_posedge(3),
	HoldLow => thold_TXCHARISK1_TXUSRCLK21_posedge_posedge(3),
	HoldHigh => thold_TXCHARISK1_TXUSRCLK21_negedge_posedge(3),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXCHARDISPMODE10_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXCHARDISPMODE10_TXUSRCLK21_posedge,
	TestSignal => TXCHARDISPMODE1_dly(0),
	TestSignalName => "TXCHARDISPMODE1(0)",
	TestDelay => tisd_TXCHARDISPMODE1_TXUSRCLK21(0),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXCHARDISPMODE1_TXUSRCLK21_posedge_posedge(0),
	SetupLow => tsetup_TXCHARDISPMODE1_TXUSRCLK21_negedge_posedge(0),
	HoldLow => thold_TXCHARDISPMODE1_TXUSRCLK21_posedge_posedge(0),
	HoldHigh => thold_TXCHARDISPMODE1_TXUSRCLK21_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXCHARDISPMODE11_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXCHARDISPMODE11_TXUSRCLK21_posedge,
	TestSignal => TXCHARDISPMODE1_dly(1),
	TestSignalName => "TXCHARDISPMODE1(1)",
	TestDelay => tisd_TXCHARDISPMODE1_TXUSRCLK21(1),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXCHARDISPMODE1_TXUSRCLK21_posedge_posedge(1),
	SetupLow => tsetup_TXCHARDISPMODE1_TXUSRCLK21_negedge_posedge(1),
	HoldLow => thold_TXCHARDISPMODE1_TXUSRCLK21_posedge_posedge(1),
	HoldHigh => thold_TXCHARDISPMODE1_TXUSRCLK21_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXCHARDISPMODE12_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXCHARDISPMODE12_TXUSRCLK21_posedge,
	TestSignal => TXCHARDISPMODE1_dly(2),
	TestSignalName => "TXCHARDISPMODE1(2)",
	TestDelay => tisd_TXCHARDISPMODE1_TXUSRCLK21(2),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXCHARDISPMODE1_TXUSRCLK21_posedge_posedge(2),
	SetupLow => tsetup_TXCHARDISPMODE1_TXUSRCLK21_negedge_posedge(2),
	HoldLow => thold_TXCHARDISPMODE1_TXUSRCLK21_posedge_posedge(2),
	HoldHigh => thold_TXCHARDISPMODE1_TXUSRCLK21_negedge_posedge(2),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXCHARDISPMODE13_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXCHARDISPMODE13_TXUSRCLK21_posedge,
	TestSignal => TXCHARDISPMODE1_dly(3),
	TestSignalName => "TXCHARDISPMODE1(3)",
	TestDelay => tisd_TXCHARDISPMODE1_TXUSRCLK21(3),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXCHARDISPMODE1_TXUSRCLK21_posedge_posedge(3),
	SetupLow => tsetup_TXCHARDISPMODE1_TXUSRCLK21_negedge_posedge(3),
	HoldLow => thold_TXCHARDISPMODE1_TXUSRCLK21_posedge_posedge(3),
	HoldHigh => thold_TXCHARDISPMODE1_TXUSRCLK21_negedge_posedge(3),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXCHARDISPVAL10_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXCHARDISPVAL10_TXUSRCLK21_posedge,
	TestSignal => TXCHARDISPVAL1_dly(0),
	TestSignalName => "TXCHARDISPVAL1(0)",
	TestDelay => tisd_TXCHARDISPVAL1_TXUSRCLK21(0),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXCHARDISPVAL1_TXUSRCLK21_posedge_posedge(0),
	SetupLow => tsetup_TXCHARDISPVAL1_TXUSRCLK21_negedge_posedge(0),
	HoldLow => thold_TXCHARDISPVAL1_TXUSRCLK21_posedge_posedge(0),
	HoldHigh => thold_TXCHARDISPVAL1_TXUSRCLK21_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXCHARDISPVAL11_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXCHARDISPVAL11_TXUSRCLK21_posedge,
	TestSignal => TXCHARDISPVAL1_dly(1),
	TestSignalName => "TXCHARDISPVAL1(1)",
	TestDelay => tisd_TXCHARDISPVAL1_TXUSRCLK21(1),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXCHARDISPVAL1_TXUSRCLK21_posedge_posedge(1),
	SetupLow => tsetup_TXCHARDISPVAL1_TXUSRCLK21_negedge_posedge(1),
	HoldLow => thold_TXCHARDISPVAL1_TXUSRCLK21_posedge_posedge(1),
	HoldHigh => thold_TXCHARDISPVAL1_TXUSRCLK21_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXCHARDISPVAL12_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXCHARDISPVAL12_TXUSRCLK21_posedge,
	TestSignal => TXCHARDISPVAL1_dly(2),
	TestSignalName => "TXCHARDISPVAL1(2)",
	TestDelay => tisd_TXCHARDISPVAL1_TXUSRCLK21(2),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXCHARDISPVAL1_TXUSRCLK21_posedge_posedge(2),
	SetupLow => tsetup_TXCHARDISPVAL1_TXUSRCLK21_negedge_posedge(2),
	HoldLow => thold_TXCHARDISPVAL1_TXUSRCLK21_posedge_posedge(2),
	HoldHigh => thold_TXCHARDISPVAL1_TXUSRCLK21_negedge_posedge(2),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXCHARDISPVAL13_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXCHARDISPVAL13_TXUSRCLK21_posedge,
	TestSignal => TXCHARDISPVAL1_dly(3),
	TestSignalName => "TXCHARDISPVAL1(3)",
	TestDelay => tisd_TXCHARDISPVAL1_TXUSRCLK21(3),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXCHARDISPVAL1_TXUSRCLK21_posedge_posedge(3),
	SetupLow => tsetup_TXCHARDISPVAL1_TXUSRCLK21_negedge_posedge(3),
	HoldLow => thold_TXCHARDISPVAL1_TXUSRCLK21_posedge_posedge(3),
	HoldHigh => thold_TXCHARDISPVAL1_TXUSRCLK21_negedge_posedge(3),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_TXENC8B10BUSE0_TXUSRCLK20_posedge,
	TimingData     => Tmkr_TXENC8B10BUSE0_TXUSRCLK20_posedge,
	TestSignal     => TXENC8B10BUSE0,
	TestSignalName => "TXENC8B10BUSE0",
	TestDelay      => 0 ps,
	RefSignal => TXUSRCLK20_dly,
	RefSignalName  => "TXUSRCLK20",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_TXENC8B10BUSE0_TXUSRCLK20_posedge_posedge,
	SetupLow       => tsetup_TXENC8B10BUSE0_TXUSRCLK20_negedge_posedge,
	HoldLow        => thold_TXENC8B10BUSE0_TXUSRCLK20_posedge_posedge,
	HoldHigh       => thold_TXENC8B10BUSE0_TXUSRCLK20_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_TXPOLARITY0_TXUSRCLK20_posedge,
	TimingData     => Tmkr_TXPOLARITY0_TXUSRCLK20_posedge,
	TestSignal     => TXPOLARITY0,
	TestSignalName => "TXPOLARITY0",
	TestDelay      => 0 ps,
	RefSignal => TXUSRCLK20_dly,
	RefSignalName  => "TXUSRCLK20",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_TXPOLARITY0_TXUSRCLK20_posedge_posedge,
	SetupLow       => tsetup_TXPOLARITY0_TXUSRCLK20_negedge_posedge,
	HoldLow        => thold_TXPOLARITY0_TXUSRCLK20_posedge_posedge,
	HoldHigh       => thold_TXPOLARITY0_TXUSRCLK20_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_TXINHIBIT0_TXUSRCLK20_posedge,
	TimingData     => Tmkr_TXINHIBIT0_TXUSRCLK20_posedge,
	TestSignal     => TXINHIBIT0,
	TestSignalName => "TXINHIBIT0",
	TestDelay      => 0 ps,
	RefSignal => TXUSRCLK20_dly,
	RefSignalName  => "TXUSRCLK20",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_TXINHIBIT0_TXUSRCLK20_posedge_posedge,
	SetupLow       => tsetup_TXINHIBIT0_TXUSRCLK20_negedge_posedge,
	HoldLow        => thold_TXINHIBIT0_TXUSRCLK20_posedge_posedge,
	HoldHigh       => thold_TXINHIBIT0_TXUSRCLK20_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_TXENC8B10BUSE1_TXUSRCLK21_posedge,
	TimingData     => Tmkr_TXENC8B10BUSE1_TXUSRCLK21_posedge,
	TestSignal     => TXENC8B10BUSE1,
	TestSignalName => "TXENC8B10BUSE1",
	TestDelay      => 0 ps,
	RefSignal => TXUSRCLK21_dly,
	RefSignalName  => "TXUSRCLK21",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_TXENC8B10BUSE1_TXUSRCLK21_posedge_posedge,
	SetupLow       => tsetup_TXENC8B10BUSE1_TXUSRCLK21_negedge_posedge,
	HoldLow        => thold_TXENC8B10BUSE1_TXUSRCLK21_posedge_posedge,
	HoldHigh       => thold_TXENC8B10BUSE1_TXUSRCLK21_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_TXPOLARITY1_TXUSRCLK21_posedge,
	TimingData     => Tmkr_TXPOLARITY1_TXUSRCLK21_posedge,
	TestSignal     => TXPOLARITY1,
	TestSignalName => "TXPOLARITY1",
	TestDelay      => 0 ps,
	RefSignal => TXUSRCLK21_dly,
	RefSignalName  => "TXUSRCLK21",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_TXPOLARITY1_TXUSRCLK21_posedge_posedge,
	SetupLow       => tsetup_TXPOLARITY1_TXUSRCLK21_negedge_posedge,
	HoldLow        => thold_TXPOLARITY1_TXUSRCLK21_posedge_posedge,
	HoldHigh       => thold_TXPOLARITY1_TXUSRCLK21_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_TXINHIBIT1_TXUSRCLK21_posedge,
	TimingData     => Tmkr_TXINHIBIT1_TXUSRCLK21_posedge,
	TestSignal     => TXINHIBIT1,
	TestSignalName => "TXINHIBIT1",
	TestDelay      => 0 ps,
	RefSignal => TXUSRCLK21_dly,
	RefSignalName  => "TXUSRCLK21",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_TXINHIBIT1_TXUSRCLK21_posedge_posedge,
	SetupLow       => tsetup_TXINHIBIT1_TXUSRCLK21_negedge_posedge,
	HoldLow        => thold_TXINHIBIT1_TXUSRCLK21_posedge_posedge,
	HoldHigh       => thold_TXINHIBIT1_TXUSRCLK21_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_RXPOLARITY0_RXUSRCLK20_posedge,
	TimingData     => Tmkr_RXPOLARITY0_RXUSRCLK20_posedge,
	TestSignal     => RXPOLARITY0,
	TestSignalName => "RXPOLARITY0",
	TestDelay      => 0 ps,
	RefSignal => RXUSRCLK20_dly,
	RefSignalName  => "RXUSRCLK20",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_RXPOLARITY0_RXUSRCLK20_posedge_posedge,
	SetupLow       => tsetup_RXPOLARITY0_RXUSRCLK20_negedge_posedge,
	HoldLow        => thold_RXPOLARITY0_RXUSRCLK20_posedge_posedge,
	HoldHigh       => thold_RXPOLARITY0_RXUSRCLK20_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_RXENPCOMMAALIGN0_RXUSRCLK20_posedge,
	TimingData     => Tmkr_RXENPCOMMAALIGN0_RXUSRCLK20_posedge,
	TestSignal     => RXENPCOMMAALIGN0,
	TestSignalName => "RXENPCOMMAALIGN0",
	TestDelay      => 0 ps,
	RefSignal => RXUSRCLK20_dly,
	RefSignalName  => "RXUSRCLK20",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_RXENPCOMMAALIGN0_RXUSRCLK20_posedge_posedge,
	SetupLow       => tsetup_RXENPCOMMAALIGN0_RXUSRCLK20_negedge_posedge,
	HoldLow        => thold_RXENPCOMMAALIGN0_RXUSRCLK20_posedge_posedge,
	HoldHigh       => thold_RXENPCOMMAALIGN0_RXUSRCLK20_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_RXENMCOMMAALIGN0_RXUSRCLK20_posedge,
	TimingData     => Tmkr_RXENMCOMMAALIGN0_RXUSRCLK20_posedge,
	TestSignal     => RXENMCOMMAALIGN0,
	TestSignalName => "RXENMCOMMAALIGN0",
	TestDelay      => 0 ps,
	RefSignal => RXUSRCLK20_dly,
	RefSignalName  => "RXUSRCLK20",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_RXENMCOMMAALIGN0_RXUSRCLK20_posedge_posedge,
	SetupLow       => tsetup_RXENMCOMMAALIGN0_RXUSRCLK20_negedge_posedge,
	HoldLow        => thold_RXENMCOMMAALIGN0_RXUSRCLK20_posedge_posedge,
	HoldHigh       => thold_RXENMCOMMAALIGN0_RXUSRCLK20_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_RXSLIDE0_RXUSRCLK20_posedge,
	TimingData     => Tmkr_RXSLIDE0_RXUSRCLK20_posedge,
	TestSignal     => RXSLIDE0,
	TestSignalName => "RXSLIDE0",
	TestDelay      => 0 ps,
	RefSignal => RXUSRCLK20_dly,
	RefSignalName  => "RXUSRCLK20",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_RXSLIDE0_RXUSRCLK20_posedge_posedge,
	SetupLow       => tsetup_RXSLIDE0_RXUSRCLK20_negedge_posedge,
	HoldLow        => thold_RXSLIDE0_RXUSRCLK20_posedge_posedge,
	HoldHigh       => thold_RXSLIDE0_RXUSRCLK20_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_RXCOMMADETUSE0_RXUSRCLK20_posedge,
	TimingData     => Tmkr_RXCOMMADETUSE0_RXUSRCLK20_posedge,
	TestSignal     => RXCOMMADETUSE0,
	TestSignalName => "RXCOMMADETUSE0",
	TestDelay      => 0 ps,
	RefSignal => RXUSRCLK20_dly,
	RefSignalName  => "RXUSRCLK20",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_RXCOMMADETUSE0_RXUSRCLK20_posedge_posedge,
	SetupLow       => tsetup_RXCOMMADETUSE0_RXUSRCLK20_negedge_posedge,
	HoldLow        => thold_RXCOMMADETUSE0_RXUSRCLK20_posedge_posedge,
	HoldHigh       => thold_RXCOMMADETUSE0_RXUSRCLK20_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_RXDEC8B10BUSE0_RXUSRCLK20_posedge,
	TimingData     => Tmkr_RXDEC8B10BUSE0_RXUSRCLK20_posedge,
	TestSignal     => RXDEC8B10BUSE0,
	TestSignalName => "RXDEC8B10BUSE0",
	TestDelay      => 0 ps,
	RefSignal => RXUSRCLK20_dly,
	RefSignalName  => "RXUSRCLK20",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_RXDEC8B10BUSE0_RXUSRCLK20_posedge_posedge,
	SetupLow       => tsetup_RXDEC8B10BUSE0_RXUSRCLK20_negedge_posedge,
	HoldLow        => thold_RXDEC8B10BUSE0_RXUSRCLK20_posedge_posedge,
	HoldHigh       => thold_RXDEC8B10BUSE0_RXUSRCLK20_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_RXENCHANSYNC0_RXUSRCLK20_posedge,
	TimingData     => Tmkr_RXENCHANSYNC0_RXUSRCLK20_posedge,
	TestSignal     => RXENCHANSYNC0,
	TestSignalName => "RXENCHANSYNC0",
	TestDelay      => 0 ps,
	RefSignal => RXUSRCLK20_dly,
	RefSignalName  => "RXUSRCLK20",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_RXENCHANSYNC0_RXUSRCLK20_posedge_posedge,
	SetupLow       => tsetup_RXENCHANSYNC0_RXUSRCLK20_negedge_posedge,
	HoldLow        => thold_RXENCHANSYNC0_RXUSRCLK20_posedge_posedge,
	HoldHigh       => thold_RXENCHANSYNC0_RXUSRCLK20_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_RXCHBONDI00_RXUSRCLK0_posedge,
	TimingData => Tmkr_RXCHBONDI00_RXUSRCLK0_posedge,
	TestSignal => RXCHBONDI0_dly(0),
	TestSignalName => "RXCHBONDI0(0)",
	TestDelay => tisd_RXCHBONDI0_RXUSRCLK0(0),
	RefSignal => RXUSRCLK0_dly,
	RefSignalName => "RXUSRCLK0",
	RefDelay => ticd_RXUSRCLK0,
	SetupHigh => tsetup_RXCHBONDI0_RXUSRCLK0_posedge_posedge(0),
	SetupLow => tsetup_RXCHBONDI0_RXUSRCLK0_negedge_posedge(0),
	HoldLow => thold_RXCHBONDI0_RXUSRCLK0_posedge_posedge(0),
	HoldHigh => thold_RXCHBONDI0_RXUSRCLK0_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_RXCHBONDI01_RXUSRCLK0_posedge,
	TimingData => Tmkr_RXCHBONDI01_RXUSRCLK0_posedge,
	TestSignal => RXCHBONDI0_dly(1),
	TestSignalName => "RXCHBONDI0(1)",
	TestDelay => tisd_RXCHBONDI0_RXUSRCLK0(1),
	RefSignal => RXUSRCLK0_dly,
	RefSignalName => "RXUSRCLK0",
	RefDelay => ticd_RXUSRCLK0,
	SetupHigh => tsetup_RXCHBONDI0_RXUSRCLK0_posedge_posedge(1),
	SetupLow => tsetup_RXCHBONDI0_RXUSRCLK0_negedge_posedge(1),
	HoldLow => thold_RXCHBONDI0_RXUSRCLK0_posedge_posedge(1),
	HoldHigh => thold_RXCHBONDI0_RXUSRCLK0_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_RXCHBONDI02_RXUSRCLK0_posedge,
	TimingData => Tmkr_RXCHBONDI02_RXUSRCLK0_posedge,
	TestSignal => RXCHBONDI0_dly(2),
	TestSignalName => "RXCHBONDI0(2)",
	TestDelay => tisd_RXCHBONDI0_RXUSRCLK0(2),
	RefSignal => RXUSRCLK0_dly,
	RefSignalName => "RXUSRCLK0",
	RefDelay => ticd_RXUSRCLK0,
	SetupHigh => tsetup_RXCHBONDI0_RXUSRCLK0_posedge_posedge(2),
	SetupLow => tsetup_RXCHBONDI0_RXUSRCLK0_negedge_posedge(2),
	HoldLow => thold_RXCHBONDI0_RXUSRCLK0_posedge_posedge(2),
	HoldHigh => thold_RXCHBONDI0_RXUSRCLK0_negedge_posedge(2),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_RXCHBONDI03_RXUSRCLK0_posedge,
	TimingData => Tmkr_RXCHBONDI03_RXUSRCLK0_posedge,
	TestSignal => RXCHBONDI0_dly(3),
	TestSignalName => "RXCHBONDI0(3)",
	TestDelay => tisd_RXCHBONDI0_RXUSRCLK0(3),
	RefSignal => RXUSRCLK0_dly,
	RefSignalName => "RXUSRCLK0",
	RefDelay => ticd_RXUSRCLK0,
	SetupHigh => tsetup_RXCHBONDI0_RXUSRCLK0_posedge_posedge(3),
	SetupLow => tsetup_RXCHBONDI0_RXUSRCLK0_negedge_posedge(3),
	HoldLow => thold_RXCHBONDI0_RXUSRCLK0_posedge_posedge(3),
	HoldHigh => thold_RXCHBONDI0_RXUSRCLK0_negedge_posedge(3),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_RXPOLARITY1_RXUSRCLK21_posedge,
	TimingData     => Tmkr_RXPOLARITY1_RXUSRCLK21_posedge,
	TestSignal     => RXPOLARITY1,
	TestSignalName => "RXPOLARITY1",
	TestDelay      => 0 ps,
	RefSignal => RXUSRCLK21_dly,
	RefSignalName  => "RXUSRCLK21",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_RXPOLARITY1_RXUSRCLK21_posedge_posedge,
	SetupLow       => tsetup_RXPOLARITY1_RXUSRCLK21_negedge_posedge,
	HoldLow        => thold_RXPOLARITY1_RXUSRCLK21_posedge_posedge,
	HoldHigh       => thold_RXPOLARITY1_RXUSRCLK21_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_RXENPCOMMAALIGN1_RXUSRCLK21_posedge,
	TimingData     => Tmkr_RXENPCOMMAALIGN1_RXUSRCLK21_posedge,
	TestSignal     => RXENPCOMMAALIGN1,
	TestSignalName => "RXENPCOMMAALIGN1",
	TestDelay      => 0 ps,
	RefSignal => RXUSRCLK21_dly,
	RefSignalName  => "RXUSRCLK21",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_RXENPCOMMAALIGN1_RXUSRCLK21_posedge_posedge,
	SetupLow       => tsetup_RXENPCOMMAALIGN1_RXUSRCLK21_negedge_posedge,
	HoldLow        => thold_RXENPCOMMAALIGN1_RXUSRCLK21_posedge_posedge,
	HoldHigh       => thold_RXENPCOMMAALIGN1_RXUSRCLK21_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_RXENMCOMMAALIGN1_RXUSRCLK21_posedge,
	TimingData     => Tmkr_RXENMCOMMAALIGN1_RXUSRCLK21_posedge,
	TestSignal     => RXENMCOMMAALIGN1,
	TestSignalName => "RXENMCOMMAALIGN1",
	TestDelay      => 0 ps,
	RefSignal => RXUSRCLK21_dly,
	RefSignalName  => "RXUSRCLK21",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_RXENMCOMMAALIGN1_RXUSRCLK21_posedge_posedge,
	SetupLow       => tsetup_RXENMCOMMAALIGN1_RXUSRCLK21_negedge_posedge,
	HoldLow        => thold_RXENMCOMMAALIGN1_RXUSRCLK21_posedge_posedge,
	HoldHigh       => thold_RXENMCOMMAALIGN1_RXUSRCLK21_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_RXSLIDE1_RXUSRCLK21_posedge,
	TimingData     => Tmkr_RXSLIDE1_RXUSRCLK21_posedge,
	TestSignal     => RXSLIDE1,
	TestSignalName => "RXSLIDE1",
	TestDelay      => 0 ps,
	RefSignal => RXUSRCLK21_dly,
	RefSignalName  => "RXUSRCLK21",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_RXSLIDE1_RXUSRCLK21_posedge_posedge,
	SetupLow       => tsetup_RXSLIDE1_RXUSRCLK21_negedge_posedge,
	HoldLow        => thold_RXSLIDE1_RXUSRCLK21_posedge_posedge,
	HoldHigh       => thold_RXSLIDE1_RXUSRCLK21_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_RXCOMMADETUSE1_RXUSRCLK21_posedge,
	TimingData     => Tmkr_RXCOMMADETUSE1_RXUSRCLK21_posedge,
	TestSignal     => RXCOMMADETUSE1,
	TestSignalName => "RXCOMMADETUSE1",
	TestDelay      => 0 ps,
	RefSignal => RXUSRCLK21_dly,
	RefSignalName  => "RXUSRCLK21",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_RXCOMMADETUSE1_RXUSRCLK21_posedge_posedge,
	SetupLow       => tsetup_RXCOMMADETUSE1_RXUSRCLK21_negedge_posedge,
	HoldLow        => thold_RXCOMMADETUSE1_RXUSRCLK21_posedge_posedge,
	HoldHigh       => thold_RXCOMMADETUSE1_RXUSRCLK21_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_RXDEC8B10BUSE1_RXUSRCLK21_posedge,
	TimingData     => Tmkr_RXDEC8B10BUSE1_RXUSRCLK21_posedge,
	TestSignal     => RXDEC8B10BUSE1,
	TestSignalName => "RXDEC8B10BUSE1",
	TestDelay      => 0 ps,
	RefSignal => RXUSRCLK21_dly,
	RefSignalName  => "RXUSRCLK21",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_RXDEC8B10BUSE1_RXUSRCLK21_posedge_posedge,
	SetupLow       => tsetup_RXDEC8B10BUSE1_RXUSRCLK21_negedge_posedge,
	HoldLow        => thold_RXDEC8B10BUSE1_RXUSRCLK21_posedge_posedge,
	HoldHigh       => thold_RXDEC8B10BUSE1_RXUSRCLK21_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_RXENCHANSYNC1_RXUSRCLK21_posedge,
	TimingData     => Tmkr_RXENCHANSYNC1_RXUSRCLK21_posedge,
	TestSignal     => RXENCHANSYNC1,
	TestSignalName => "RXENCHANSYNC1",
	TestDelay      => 0 ps,
	RefSignal => RXUSRCLK21_dly,
	RefSignalName  => "RXUSRCLK21",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_RXENCHANSYNC1_RXUSRCLK21_posedge_posedge,
	SetupLow       => tsetup_RXENCHANSYNC1_RXUSRCLK21_negedge_posedge,
	HoldLow        => thold_RXENCHANSYNC1_RXUSRCLK21_posedge_posedge,
	HoldHigh       => thold_RXENCHANSYNC1_RXUSRCLK21_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_RXCHBONDI10_RXUSRCLK1_posedge,
	TimingData => Tmkr_RXCHBONDI10_RXUSRCLK1_posedge,
	TestSignal => RXCHBONDI1_dly(0),
	TestSignalName => "RXCHBONDI1(0)",
	TestDelay => tisd_RXCHBONDI1_RXUSRCLK1(0),
	RefSignal => RXUSRCLK1_dly,
	RefSignalName => "RXUSRCLK1",
	RefDelay => ticd_RXUSRCLK1,
	SetupHigh => tsetup_RXCHBONDI1_RXUSRCLK1_posedge_posedge(0),
	SetupLow => tsetup_RXCHBONDI1_RXUSRCLK1_negedge_posedge(0),
	HoldLow => thold_RXCHBONDI1_RXUSRCLK1_posedge_posedge(0),
	HoldHigh => thold_RXCHBONDI1_RXUSRCLK1_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_RXCHBONDI11_RXUSRCLK1_posedge,
	TimingData => Tmkr_RXCHBONDI11_RXUSRCLK1_posedge,
	TestSignal => RXCHBONDI1_dly(1),
	TestSignalName => "RXCHBONDI1(1)",
	TestDelay => tisd_RXCHBONDI1_RXUSRCLK1(1),
	RefSignal => RXUSRCLK1_dly,
	RefSignalName => "RXUSRCLK1",
	RefDelay => ticd_RXUSRCLK1,
	SetupHigh => tsetup_RXCHBONDI1_RXUSRCLK1_posedge_posedge(1),
	SetupLow => tsetup_RXCHBONDI1_RXUSRCLK1_negedge_posedge(1),
	HoldLow => thold_RXCHBONDI1_RXUSRCLK1_posedge_posedge(1),
	HoldHigh => thold_RXCHBONDI1_RXUSRCLK1_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_RXCHBONDI12_RXUSRCLK1_posedge,
	TimingData => Tmkr_RXCHBONDI12_RXUSRCLK1_posedge,
	TestSignal => RXCHBONDI1_dly(2),
	TestSignalName => "RXCHBONDI1(2)",
	TestDelay => tisd_RXCHBONDI1_RXUSRCLK1(2),
	RefSignal => RXUSRCLK1_dly,
	RefSignalName => "RXUSRCLK1",
	RefDelay => ticd_RXUSRCLK1,
	SetupHigh => tsetup_RXCHBONDI1_RXUSRCLK1_posedge_posedge(2),
	SetupLow => tsetup_RXCHBONDI1_RXUSRCLK1_negedge_posedge(2),
	HoldLow => thold_RXCHBONDI1_RXUSRCLK1_posedge_posedge(2),
	HoldHigh => thold_RXCHBONDI1_RXUSRCLK1_negedge_posedge(2),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_RXCHBONDI13_RXUSRCLK1_posedge,
	TimingData => Tmkr_RXCHBONDI13_RXUSRCLK1_posedge,
	TestSignal => RXCHBONDI1_dly(3),
	TestSignalName => "RXCHBONDI1(3)",
	TestDelay => tisd_RXCHBONDI1_RXUSRCLK1(3),
	RefSignal => RXUSRCLK1_dly,
	RefSignalName => "RXUSRCLK1",
	RefDelay => ticd_RXUSRCLK1,
	SetupHigh => tsetup_RXCHBONDI1_RXUSRCLK1_posedge_posedge(3),
	SetupLow => tsetup_RXCHBONDI1_RXUSRCLK1_negedge_posedge(3),
	HoldLow => thold_RXCHBONDI1_RXUSRCLK1_posedge_posedge(3),
	HoldHigh => thold_RXCHBONDI1_RXUSRCLK1_negedge_posedge(3),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
        Violation      => Tviol_TXELECIDLE0_TXUSRCLK20_posedge,
	TimingData     => Tmkr_TXELECIDLE0_TXUSRCLK20_posedge,
	TestSignal     => TXELECIDLE0,
	TestSignalName => "TXELECIDLE0",
	TestDelay      => 0 ps,
	RefSignal => TXUSRCLK20_dly,
	RefSignalName  => "TXUSRCLK20",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_TXELECIDLE0_TXUSRCLK20_posedge_posedge,
	SetupLow       => tsetup_TXELECIDLE0_TXUSRCLK20_negedge_posedge,
	HoldLow        => thold_TXELECIDLE0_TXUSRCLK20_posedge_posedge,
	HoldHigh       => thold_TXELECIDLE0_TXUSRCLK20_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_TXDETECTRX0_TXUSRCLK20_posedge,
	TimingData     => Tmkr_TXDETECTRX0_TXUSRCLK20_posedge,
	TestSignal     => TXDETECTRX0,
	TestSignalName => "TXDETECTRX0",
	TestDelay      => 0 ps,
	RefSignal => TXUSRCLK20_dly,
	RefSignalName  => "TXUSRCLK20",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_TXDETECTRX0_TXUSRCLK20_posedge_posedge,
	SetupLow       => tsetup_TXDETECTRX0_TXUSRCLK20_negedge_posedge,
	HoldLow        => thold_TXDETECTRX0_TXUSRCLK20_posedge_posedge,
	HoldHigh       => thold_TXDETECTRX0_TXUSRCLK20_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
        Violation      => Tviol_TXELECIDLE1_TXUSRCLK21_posedge,
	TimingData     => Tmkr_TXELECIDLE1_TXUSRCLK21_posedge,
	TestSignal     => TXELECIDLE1,
	TestSignalName => "TXELECIDLE1",
	TestDelay      => 0 ps,
	RefSignal => TXUSRCLK21_dly,
	RefSignalName  => "TXUSRCLK21",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_TXELECIDLE1_TXUSRCLK21_posedge_posedge,
	SetupLow       => tsetup_TXELECIDLE1_TXUSRCLK21_negedge_posedge,
	HoldLow        => thold_TXELECIDLE1_TXUSRCLK21_posedge_posedge,
	HoldHigh       => thold_TXELECIDLE1_TXUSRCLK21_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
        Violation      => Tviol_TXDETECTRX1_TXUSRCLK21_posedge,
	TimingData     => Tmkr_TXDETECTRX1_TXUSRCLK21_posedge,
	TestSignal     => TXDETECTRX1,
	TestSignalName => "TXDETECTRX1",
	TestDelay      => 0 ps,
	RefSignal => TXUSRCLK21_dly,
	RefSignalName  => "TXUSRCLK21",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_TXDETECTRX1_TXUSRCLK21_posedge_posedge,
	SetupLow       => tsetup_TXDETECTRX1_TXUSRCLK21_negedge_posedge,
	HoldLow        => thold_TXDETECTRX1_TXUSRCLK21_posedge_posedge,
	HoldHigh       => thold_TXDETECTRX1_TXUSRCLK21_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_TXCOMSTART0_TXUSRCLK20_posedge,
	TimingData     => Tmkr_TXCOMSTART0_TXUSRCLK20_posedge,
	TestSignal     => TXCOMSTART0,
	TestSignalName => "TXCOMSTART0",
	TestDelay      => 0 ps,
	RefSignal => TXUSRCLK20_dly,
	RefSignalName  => "TXUSRCLK20",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_TXCOMSTART0_TXUSRCLK20_posedge_posedge,
	SetupLow       => tsetup_TXCOMSTART0_TXUSRCLK20_negedge_posedge,
	HoldLow        => thold_TXCOMSTART0_TXUSRCLK20_posedge_posedge,
	HoldHigh       => thold_TXCOMSTART0_TXUSRCLK20_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_TXCOMTYPE0_TXUSRCLK20_posedge,
	TimingData     => Tmkr_TXCOMTYPE0_TXUSRCLK20_posedge,
	TestSignal     => TXCOMTYPE0,
	TestSignalName => "TXCOMTYPE0",
	TestDelay      => 0 ps,
	RefSignal => TXUSRCLK20_dly,
	RefSignalName  => "TXUSRCLK20",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_TXCOMTYPE0_TXUSRCLK20_posedge_posedge,
	SetupLow       => tsetup_TXCOMTYPE0_TXUSRCLK20_negedge_posedge,
	HoldLow        => thold_TXCOMTYPE0_TXUSRCLK20_posedge_posedge,
	HoldHigh       => thold_TXCOMTYPE0_TXUSRCLK20_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_TXCOMSTART1_TXUSRCLK21_posedge,
	TimingData     => Tmkr_TXCOMSTART1_TXUSRCLK21_posedge,
	TestSignal     => TXCOMSTART1,
	TestSignalName => "TXCOMSTART1",
	TestDelay      => 0 ps,
	RefSignal => TXUSRCLK21_dly,
	RefSignalName  => "TXUSRCLK21",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_TXCOMSTART1_TXUSRCLK21_posedge_posedge,
	SetupLow       => tsetup_TXCOMSTART1_TXUSRCLK21_negedge_posedge,
	HoldLow        => thold_TXCOMSTART1_TXUSRCLK21_posedge_posedge,
	HoldHigh       => thold_TXCOMSTART1_TXUSRCLK21_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_TXCOMTYPE1_TXUSRCLK21_posedge,
	TimingData     => Tmkr_TXCOMTYPE1_TXUSRCLK21_posedge,
	TestSignal     => TXCOMTYPE1,
	TestSignalName => "TXCOMTYPE1",
	TestDelay      => 0 ps,
	RefSignal => TXUSRCLK21_dly,
	RefSignalName  => "TXUSRCLK21",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_TXCOMTYPE1_TXUSRCLK21_posedge_posedge,
	SetupLow       => tsetup_TXCOMTYPE1_TXUSRCLK21_negedge_posedge,
	HoldLow        => thold_TXCOMTYPE1_TXUSRCLK21_posedge_posedge,
	HoldHigh       => thold_TXCOMTYPE1_TXUSRCLK21_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXENPRBSTST00_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXENPRBSTST00_TXUSRCLK20_posedge,
	TestSignal => TXENPRBSTST0_dly(0),
	TestSignalName => "TXENPRBSTST0(0)",
	TestDelay => tisd_TXENPRBSTST0_TXUSRCLK20(0),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXENPRBSTST0_TXUSRCLK20_posedge_posedge(0),
	SetupLow => tsetup_TXENPRBSTST0_TXUSRCLK20_negedge_posedge(0),
	HoldLow => thold_TXENPRBSTST0_TXUSRCLK20_posedge_posedge(0),
	HoldHigh => thold_TXENPRBSTST0_TXUSRCLK20_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXENPRBSTST01_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXENPRBSTST01_TXUSRCLK20_posedge,
	TestSignal => TXENPRBSTST0_dly(1),
	TestSignalName => "TXENPRBSTST0(1)",
	TestDelay => tisd_TXENPRBSTST0_TXUSRCLK20(1),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXENPRBSTST0_TXUSRCLK20_posedge_posedge(1),
	SetupLow => tsetup_TXENPRBSTST0_TXUSRCLK20_negedge_posedge(1),
	HoldLow => thold_TXENPRBSTST0_TXUSRCLK20_posedge_posedge(1),
	HoldHigh => thold_TXENPRBSTST0_TXUSRCLK20_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_RXENPRBSTST00_RXUSRCLK20_posedge,
	TimingData => Tmkr_RXENPRBSTST00_RXUSRCLK20_posedge,
	TestSignal => RXENPRBSTST0_dly(0),
	TestSignalName => "RXENPRBSTST0(0)",
	TestDelay => tisd_RXENPRBSTST0_RXUSRCLK20(0),
	RefSignal => RXUSRCLK20_dly,
	RefSignalName => "RXUSRCLK20",
	RefDelay => ticd_RXUSRCLK20,
	SetupHigh => tsetup_RXENPRBSTST0_RXUSRCLK20_posedge_posedge(0),
	SetupLow => tsetup_RXENPRBSTST0_RXUSRCLK20_negedge_posedge(0),
	HoldLow => thold_RXENPRBSTST0_RXUSRCLK20_posedge_posedge(0),
	HoldHigh => thold_RXENPRBSTST0_RXUSRCLK20_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_RXENPRBSTST01_RXUSRCLK20_posedge,
	TimingData => Tmkr_RXENPRBSTST01_RXUSRCLK20_posedge,
	TestSignal => RXENPRBSTST0_dly(1),
	TestSignalName => "RXENPRBSTST0(1)",
	TestDelay => tisd_RXENPRBSTST0_RXUSRCLK20(1),
	RefSignal => RXUSRCLK20_dly,
	RefSignalName => "RXUSRCLK20",
	RefDelay => ticd_RXUSRCLK20,
	SetupHigh => tsetup_RXENPRBSTST0_RXUSRCLK20_posedge_posedge(1),
	SetupLow => tsetup_RXENPRBSTST0_RXUSRCLK20_negedge_posedge(1),
	HoldLow => thold_RXENPRBSTST0_RXUSRCLK20_posedge_posedge(1),
	HoldHigh => thold_RXENPRBSTST0_RXUSRCLK20_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_PRBSCNTRESET0_RXUSRCLK20_posedge,
	TimingData     => Tmkr_PRBSCNTRESET0_RXUSRCLK20_posedge,
	TestSignal     => PRBSCNTRESET0,
	TestSignalName => "PRBSCNTRESET0",
	TestDelay      => 0 ps,
	RefSignal => RXUSRCLK20_dly,
	RefSignalName  => "RXUSRCLK20",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_PRBSCNTRESET0_RXUSRCLK20_posedge_posedge,
	SetupLow       => tsetup_PRBSCNTRESET0_RXUSRCLK20_negedge_posedge,
	HoldLow        => thold_PRBSCNTRESET0_RXUSRCLK20_posedge_posedge,
	HoldHigh       => thold_PRBSCNTRESET0_RXUSRCLK20_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXENPRBSTST10_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXENPRBSTST10_TXUSRCLK21_posedge,
	TestSignal => TXENPRBSTST1_dly(0),
	TestSignalName => "TXENPRBSTST1(0)",
	TestDelay => tisd_TXENPRBSTST1_TXUSRCLK21(0),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXENPRBSTST1_TXUSRCLK21_posedge_posedge(0),
	SetupLow => tsetup_TXENPRBSTST1_TXUSRCLK21_negedge_posedge(0),
	HoldLow => thold_TXENPRBSTST1_TXUSRCLK21_posedge_posedge(0),
	HoldHigh => thold_TXENPRBSTST1_TXUSRCLK21_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXENPRBSTST11_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXENPRBSTST11_TXUSRCLK21_posedge,
	TestSignal => TXENPRBSTST1_dly(1),
	TestSignalName => "TXENPRBSTST1(1)",
	TestDelay => tisd_TXENPRBSTST1_TXUSRCLK21(1),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXENPRBSTST1_TXUSRCLK21_posedge_posedge(1),
	SetupLow => tsetup_TXENPRBSTST1_TXUSRCLK21_negedge_posedge(1),
	HoldLow => thold_TXENPRBSTST1_TXUSRCLK21_posedge_posedge(1),
	HoldHigh => thold_TXENPRBSTST1_TXUSRCLK21_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_RXENPRBSTST10_RXUSRCLK21_posedge,
	TimingData => Tmkr_RXENPRBSTST10_RXUSRCLK21_posedge,
	TestSignal => RXENPRBSTST1_dly(0),
	TestSignalName => "RXENPRBSTST1(0)",
	TestDelay => tisd_RXENPRBSTST1_RXUSRCLK21(0),
	RefSignal => RXUSRCLK21_dly,
	RefSignalName => "RXUSRCLK21",
	RefDelay => ticd_RXUSRCLK21,
	SetupHigh => tsetup_RXENPRBSTST1_RXUSRCLK21_posedge_posedge(0),
	SetupLow => tsetup_RXENPRBSTST1_RXUSRCLK21_negedge_posedge(0),
	HoldLow => thold_RXENPRBSTST1_RXUSRCLK21_posedge_posedge(0),
	HoldHigh => thold_RXENPRBSTST1_RXUSRCLK21_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_RXENPRBSTST11_RXUSRCLK21_posedge,
	TimingData => Tmkr_RXENPRBSTST11_RXUSRCLK21_posedge,
	TestSignal => RXENPRBSTST1_dly(1),
	TestSignalName => "RXENPRBSTST1(1)",
	TestDelay => tisd_RXENPRBSTST1_RXUSRCLK21(1),
	RefSignal => RXUSRCLK21_dly,
	RefSignalName => "RXUSRCLK21",
	RefDelay => ticd_RXUSRCLK21,
	SetupHigh => tsetup_RXENPRBSTST1_RXUSRCLK21_posedge_posedge(1),
	SetupLow => tsetup_RXENPRBSTST1_RXUSRCLK21_negedge_posedge(1),
	HoldLow => thold_RXENPRBSTST1_RXUSRCLK21_posedge_posedge(1),
	HoldHigh => thold_RXENPRBSTST1_RXUSRCLK21_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_PRBSCNTRESET1_RXUSRCLK21_posedge,
	TimingData     => Tmkr_PRBSCNTRESET1_RXUSRCLK21_posedge,
	TestSignal     => PRBSCNTRESET1,
	TestSignalName => "PRBSCNTRESET1",
	TestDelay      => 0 ps,
	RefSignal => RXUSRCLK21_dly,
	RefSignalName  => "RXUSRCLK21",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_PRBSCNTRESET1_RXUSRCLK21_posedge_posedge,
	SetupLow       => tsetup_PRBSCNTRESET1_RXUSRCLK21_negedge_posedge,
	HoldLow        => thold_PRBSCNTRESET1_RXUSRCLK21_posedge_posedge,
	HoldHigh       => thold_PRBSCNTRESET1_RXUSRCLK21_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DADDR0_DCLK_posedge,
	TimingData => Tmkr_DADDR0_DCLK_posedge,
	TestSignal => DADDR_dly(0),
	TestSignalName => "DADDR(0)",
	TestDelay => tisd_DADDR_DCLK(0),
	RefSignal => DCLK_dly,
	RefSignalName => "DCLK",
	RefDelay => ticd_DCLK,
	SetupHigh => tsetup_DADDR_DCLK_posedge_posedge(0),
	SetupLow => tsetup_DADDR_DCLK_negedge_posedge(0),
	HoldLow => thold_DADDR_DCLK_posedge_posedge(0),
	HoldHigh => thold_DADDR_DCLK_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DADDR1_DCLK_posedge,
	TimingData => Tmkr_DADDR1_DCLK_posedge,
	TestSignal => DADDR_dly(1),
	TestSignalName => "DADDR(1)",
	TestDelay => tisd_DADDR_DCLK(1),
	RefSignal => DCLK_dly,
	RefSignalName => "DCLK",
	RefDelay => ticd_DCLK,
	SetupHigh => tsetup_DADDR_DCLK_posedge_posedge(1),
	SetupLow => tsetup_DADDR_DCLK_negedge_posedge(1),
	HoldLow => thold_DADDR_DCLK_posedge_posedge(1),
	HoldHigh => thold_DADDR_DCLK_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DADDR2_DCLK_posedge,
	TimingData => Tmkr_DADDR2_DCLK_posedge,
	TestSignal => DADDR_dly(2),
	TestSignalName => "DADDR(2)",
	TestDelay => tisd_DADDR_DCLK(2),
	RefSignal => DCLK_dly,
	RefSignalName => "DCLK",
	RefDelay => ticd_DCLK,
	SetupHigh => tsetup_DADDR_DCLK_posedge_posedge(2),
	SetupLow => tsetup_DADDR_DCLK_negedge_posedge(2),
	HoldLow => thold_DADDR_DCLK_posedge_posedge(2),
	HoldHigh => thold_DADDR_DCLK_negedge_posedge(2),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DADDR3_DCLK_posedge,
	TimingData => Tmkr_DADDR3_DCLK_posedge,
	TestSignal => DADDR_dly(3),
	TestSignalName => "DADDR(3)",
	TestDelay => tisd_DADDR_DCLK(3),
	RefSignal => DCLK_dly,
	RefSignalName => "DCLK",
	RefDelay => ticd_DCLK,
	SetupHigh => tsetup_DADDR_DCLK_posedge_posedge(3),
	SetupLow => tsetup_DADDR_DCLK_negedge_posedge(3),
	HoldLow => thold_DADDR_DCLK_posedge_posedge(3),
	HoldHigh => thold_DADDR_DCLK_negedge_posedge(3),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DADDR4_DCLK_posedge,
	TimingData => Tmkr_DADDR4_DCLK_posedge,
	TestSignal => DADDR_dly(4),
	TestSignalName => "DADDR(4)",
	TestDelay => tisd_DADDR_DCLK(4),
	RefSignal => DCLK_dly,
	RefSignalName => "DCLK",
	RefDelay => ticd_DCLK,
	SetupHigh => tsetup_DADDR_DCLK_posedge_posedge(4),
	SetupLow => tsetup_DADDR_DCLK_negedge_posedge(4),
	HoldLow => thold_DADDR_DCLK_posedge_posedge(4),
	HoldHigh => thold_DADDR_DCLK_negedge_posedge(4),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DADDR5_DCLK_posedge,
	TimingData => Tmkr_DADDR5_DCLK_posedge,
	TestSignal => DADDR_dly(5),
	TestSignalName => "DADDR(5)",
	TestDelay => tisd_DADDR_DCLK(5),
	RefSignal => DCLK_dly,
	RefSignalName => "DCLK",
	RefDelay => ticd_DCLK,
	SetupHigh => tsetup_DADDR_DCLK_posedge_posedge(5),
	SetupLow => tsetup_DADDR_DCLK_negedge_posedge(5),
	HoldLow => thold_DADDR_DCLK_posedge_posedge(5),
	HoldHigh => thold_DADDR_DCLK_negedge_posedge(5),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DADDR6_DCLK_posedge,
	TimingData => Tmkr_DADDR6_DCLK_posedge,
	TestSignal => DADDR_dly(6),
	TestSignalName => "DADDR(6)",
	TestDelay => tisd_DADDR_DCLK(6),
	RefSignal => DCLK_dly,
	RefSignalName => "DCLK",
	RefDelay => ticd_DCLK,
	SetupHigh => tsetup_DADDR_DCLK_posedge_posedge(6),
	SetupLow => tsetup_DADDR_DCLK_negedge_posedge(6),
	HoldLow => thold_DADDR_DCLK_posedge_posedge(6),
	HoldHigh => thold_DADDR_DCLK_negedge_posedge(6),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DI0_DCLK_posedge,
	TimingData => Tmkr_DI0_DCLK_posedge,
	TestSignal => DI_dly(0),
	TestSignalName => "DI(0)",
	TestDelay => tisd_DI_DCLK(0),
	RefSignal => DCLK_dly,
	RefSignalName => "DCLK",
	RefDelay => ticd_DCLK,
	SetupHigh => tsetup_DI_DCLK_posedge_posedge(0),
	SetupLow => tsetup_DI_DCLK_negedge_posedge(0),
	HoldLow => thold_DI_DCLK_posedge_posedge(0),
	HoldHigh => thold_DI_DCLK_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DI1_DCLK_posedge,
	TimingData => Tmkr_DI1_DCLK_posedge,
	TestSignal => DI_dly(1),
	TestSignalName => "DI(1)",
	TestDelay => tisd_DI_DCLK(1),
	RefSignal => DCLK_dly,
	RefSignalName => "DCLK",
	RefDelay => ticd_DCLK,
	SetupHigh => tsetup_DI_DCLK_posedge_posedge(1),
	SetupLow => tsetup_DI_DCLK_negedge_posedge(1),
	HoldLow => thold_DI_DCLK_posedge_posedge(1),
	HoldHigh => thold_DI_DCLK_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DI2_DCLK_posedge,
	TimingData => Tmkr_DI2_DCLK_posedge,
	TestSignal => DI_dly(2),
	TestSignalName => "DI(2)",
	TestDelay => tisd_DI_DCLK(2),
	RefSignal => DCLK_dly,
	RefSignalName => "DCLK",
	RefDelay => ticd_DCLK,
	SetupHigh => tsetup_DI_DCLK_posedge_posedge(2),
	SetupLow => tsetup_DI_DCLK_negedge_posedge(2),
	HoldLow => thold_DI_DCLK_posedge_posedge(2),
	HoldHigh => thold_DI_DCLK_negedge_posedge(2),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DI3_DCLK_posedge,
	TimingData => Tmkr_DI3_DCLK_posedge,
	TestSignal => DI_dly(3),
	TestSignalName => "DI(3)",
	TestDelay => tisd_DI_DCLK(3),
	RefSignal => DCLK_dly,
	RefSignalName => "DCLK",
	RefDelay => ticd_DCLK,
	SetupHigh => tsetup_DI_DCLK_posedge_posedge(3),
	SetupLow => tsetup_DI_DCLK_negedge_posedge(3),
	HoldLow => thold_DI_DCLK_posedge_posedge(3),
	HoldHigh => thold_DI_DCLK_negedge_posedge(3),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DI4_DCLK_posedge,
	TimingData => Tmkr_DI4_DCLK_posedge,
	TestSignal => DI_dly(4),
	TestSignalName => "DI(4)",
	TestDelay => tisd_DI_DCLK(4),
	RefSignal => DCLK_dly,
	RefSignalName => "DCLK",
	RefDelay => ticd_DCLK,
	SetupHigh => tsetup_DI_DCLK_posedge_posedge(4),
	SetupLow => tsetup_DI_DCLK_negedge_posedge(4),
	HoldLow => thold_DI_DCLK_posedge_posedge(4),
	HoldHigh => thold_DI_DCLK_negedge_posedge(4),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DI5_DCLK_posedge,
	TimingData => Tmkr_DI5_DCLK_posedge,
	TestSignal => DI_dly(5),
	TestSignalName => "DI(5)",
	TestDelay => tisd_DI_DCLK(5),
	RefSignal => DCLK_dly,
	RefSignalName => "DCLK",
	RefDelay => ticd_DCLK,
	SetupHigh => tsetup_DI_DCLK_posedge_posedge(5),
	SetupLow => tsetup_DI_DCLK_negedge_posedge(5),
	HoldLow => thold_DI_DCLK_posedge_posedge(5),
	HoldHigh => thold_DI_DCLK_negedge_posedge(5),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DI6_DCLK_posedge,
	TimingData => Tmkr_DI6_DCLK_posedge,
	TestSignal => DI_dly(6),
	TestSignalName => "DI(6)",
	TestDelay => tisd_DI_DCLK(6),
	RefSignal => DCLK_dly,
	RefSignalName => "DCLK",
	RefDelay => ticd_DCLK,
	SetupHigh => tsetup_DI_DCLK_posedge_posedge(6),
	SetupLow => tsetup_DI_DCLK_negedge_posedge(6),
	HoldLow => thold_DI_DCLK_posedge_posedge(6),
	HoldHigh => thold_DI_DCLK_negedge_posedge(6),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DI7_DCLK_posedge,
	TimingData => Tmkr_DI7_DCLK_posedge,
	TestSignal => DI_dly(7),
	TestSignalName => "DI(7)",
	TestDelay => tisd_DI_DCLK(7),
	RefSignal => DCLK_dly,
	RefSignalName => "DCLK",
	RefDelay => ticd_DCLK,
	SetupHigh => tsetup_DI_DCLK_posedge_posedge(7),
	SetupLow => tsetup_DI_DCLK_negedge_posedge(7),
	HoldLow => thold_DI_DCLK_posedge_posedge(7),
	HoldHigh => thold_DI_DCLK_negedge_posedge(7),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DI8_DCLK_posedge,
	TimingData => Tmkr_DI8_DCLK_posedge,
	TestSignal => DI_dly(8),
	TestSignalName => "DI(8)",
	TestDelay => tisd_DI_DCLK(8),
	RefSignal => DCLK_dly,
	RefSignalName => "DCLK",
	RefDelay => ticd_DCLK,
	SetupHigh => tsetup_DI_DCLK_posedge_posedge(8),
	SetupLow => tsetup_DI_DCLK_negedge_posedge(8),
	HoldLow => thold_DI_DCLK_posedge_posedge(8),
	HoldHigh => thold_DI_DCLK_negedge_posedge(8),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DI9_DCLK_posedge,
	TimingData => Tmkr_DI9_DCLK_posedge,
	TestSignal => DI_dly(9),
	TestSignalName => "DI(9)",
	TestDelay => tisd_DI_DCLK(9),
	RefSignal => DCLK_dly,
	RefSignalName => "DCLK",
	RefDelay => ticd_DCLK,
	SetupHigh => tsetup_DI_DCLK_posedge_posedge(9),
	SetupLow => tsetup_DI_DCLK_negedge_posedge(9),
	HoldLow => thold_DI_DCLK_posedge_posedge(9),
	HoldHigh => thold_DI_DCLK_negedge_posedge(9),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DI10_DCLK_posedge,
	TimingData => Tmkr_DI10_DCLK_posedge,
	TestSignal => DI_dly(10),
	TestSignalName => "DI(10)",
	TestDelay => tisd_DI_DCLK(10),
	RefSignal => DCLK_dly,
	RefSignalName => "DCLK",
	RefDelay => ticd_DCLK,
	SetupHigh => tsetup_DI_DCLK_posedge_posedge(10),
	SetupLow => tsetup_DI_DCLK_negedge_posedge(10),
	HoldLow => thold_DI_DCLK_posedge_posedge(10),
	HoldHigh => thold_DI_DCLK_negedge_posedge(10),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DI11_DCLK_posedge,
	TimingData => Tmkr_DI11_DCLK_posedge,
	TestSignal => DI_dly(11),
	TestSignalName => "DI(11)",
	TestDelay => tisd_DI_DCLK(11),
	RefSignal => DCLK_dly,
	RefSignalName => "DCLK",
	RefDelay => ticd_DCLK,
	SetupHigh => tsetup_DI_DCLK_posedge_posedge(11),
	SetupLow => tsetup_DI_DCLK_negedge_posedge(11),
	HoldLow => thold_DI_DCLK_posedge_posedge(11),
	HoldHigh => thold_DI_DCLK_negedge_posedge(11),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DI12_DCLK_posedge,
	TimingData => Tmkr_DI12_DCLK_posedge,
	TestSignal => DI_dly(12),
	TestSignalName => "DI(12)",
	TestDelay => tisd_DI_DCLK(12),
	RefSignal => DCLK_dly,
	RefSignalName => "DCLK",
	RefDelay => ticd_DCLK,
	SetupHigh => tsetup_DI_DCLK_posedge_posedge(12),
	SetupLow => tsetup_DI_DCLK_negedge_posedge(12),
	HoldLow => thold_DI_DCLK_posedge_posedge(12),
	HoldHigh => thold_DI_DCLK_negedge_posedge(12),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DI13_DCLK_posedge,
	TimingData => Tmkr_DI13_DCLK_posedge,
	TestSignal => DI_dly(13),
	TestSignalName => "DI(13)",
	TestDelay => tisd_DI_DCLK(13),
	RefSignal => DCLK_dly,
	RefSignalName => "DCLK",
	RefDelay => ticd_DCLK,
	SetupHigh => tsetup_DI_DCLK_posedge_posedge(13),
	SetupLow => tsetup_DI_DCLK_negedge_posedge(13),
	HoldLow => thold_DI_DCLK_posedge_posedge(13),
	HoldHigh => thold_DI_DCLK_negedge_posedge(13),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DI14_DCLK_posedge,
	TimingData => Tmkr_DI14_DCLK_posedge,
	TestSignal => DI_dly(14),
	TestSignalName => "DI(14)",
	TestDelay => tisd_DI_DCLK(14),
	RefSignal => DCLK_dly,
	RefSignalName => "DCLK",
	RefDelay => ticd_DCLK,
	SetupHigh => tsetup_DI_DCLK_posedge_posedge(14),
	SetupLow => tsetup_DI_DCLK_negedge_posedge(14),
	HoldLow => thold_DI_DCLK_posedge_posedge(14),
	HoldHigh => thold_DI_DCLK_negedge_posedge(14),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DI15_DCLK_posedge,
	TimingData => Tmkr_DI15_DCLK_posedge,
	TestSignal => DI_dly(15),
	TestSignalName => "DI(15)",
	TestDelay => tisd_DI_DCLK(15),
	RefSignal => DCLK_dly,
	RefSignalName => "DCLK",
	RefDelay => ticd_DCLK,
	SetupHigh => tsetup_DI_DCLK_posedge_posedge(15),
	SetupLow => tsetup_DI_DCLK_negedge_posedge(15),
	HoldLow => thold_DI_DCLK_posedge_posedge(15),
	HoldHigh => thold_DI_DCLK_negedge_posedge(15),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_DEN_DCLK_posedge,
	TimingData     => Tmkr_DEN_DCLK_posedge,
	TestSignal     => DEN,
	TestSignalName => "DEN",
	TestDelay      => 0 ps,
	RefSignal => DCLK_dly,
	RefSignalName  => "DCLK",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_DEN_DCLK_posedge_posedge,
	SetupLow       => tsetup_DEN_DCLK_negedge_posedge,
	HoldLow        => thold_DEN_DCLK_posedge_posedge,
	HoldHigh       => thold_DEN_DCLK_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_DWE_DCLK_posedge,
	TimingData     => Tmkr_DWE_DCLK_posedge,
	TestSignal     => DWE,
	TestSignalName => "DWE",
	TestDelay      => 0 ps,
	RefSignal => DCLK_dly,
	RefSignalName  => "DCLK",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_DWE_DCLK_posedge_posedge,
	SetupLow       => tsetup_DWE_DCLK_negedge_posedge,
	HoldLow        => thold_DWE_DCLK_posedge_posedge,
	HoldHigh       => thold_DWE_DCLK_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_RXENSAMPLEALIGN0_RXUSRCLK20_posedge,
	TimingData     => Tmkr_RXENSAMPLEALIGN0_RXUSRCLK20_posedge,
	TestSignal     => RXENSAMPLEALIGN0,
	TestSignalName => "RXENSAMPLEALIGN0",
	TestDelay      => 0 ps,
	RefSignal => RXUSRCLK20_dly,
	RefSignalName  => "RXUSRCLK20",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_RXENSAMPLEALIGN0_RXUSRCLK20_posedge_posedge,
	SetupLow       => tsetup_RXENSAMPLEALIGN0_RXUSRCLK20_negedge_posedge,
	HoldLow        => thold_RXENSAMPLEALIGN0_RXUSRCLK20_posedge_posedge,
	HoldHigh       => thold_RXENSAMPLEALIGN0_RXUSRCLK20_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_RXENSAMPLEALIGN1_RXUSRCLK21_posedge,
	TimingData     => Tmkr_RXENSAMPLEALIGN1_RXUSRCLK21_posedge,
	TestSignal     => RXENSAMPLEALIGN1,
	TestSignalName => "RXENSAMPLEALIGN1",
	TestDelay      => 0 ps,
	RefSignal => RXUSRCLK21_dly,
	RefSignalName  => "RXUSRCLK21",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_RXENSAMPLEALIGN1_RXUSRCLK21_posedge_posedge,
	SetupLow       => tsetup_RXENSAMPLEALIGN1_RXUSRCLK21_negedge_posedge,
	HoldLow        => thold_RXENSAMPLEALIGN1_RXUSRCLK21_posedge_posedge,
	HoldHigh       => thold_RXENSAMPLEALIGN1_RXUSRCLK21_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXHEADER00_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXHEADER00_TXUSRCLK20_posedge,
	TestSignal => TXHEADER0_dly(0),
	TestSignalName => "TXHEADER0(0)",
	TestDelay => tisd_TXHEADER0_TXUSRCLK20(0),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXHEADER0_TXUSRCLK20_posedge_posedge(0),
	SetupLow => tsetup_TXHEADER0_TXUSRCLK20_negedge_posedge(0),
	HoldLow => thold_TXHEADER0_TXUSRCLK20_posedge_posedge(0),
	HoldHigh => thold_TXHEADER0_TXUSRCLK20_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXHEADER01_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXHEADER01_TXUSRCLK20_posedge,
	TestSignal => TXHEADER0_dly(1),
	TestSignalName => "TXHEADER0(1)",
	TestDelay => tisd_TXHEADER0_TXUSRCLK20(1),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXHEADER0_TXUSRCLK20_posedge_posedge(1),
	SetupLow => tsetup_TXHEADER0_TXUSRCLK20_negedge_posedge(1),
	HoldLow => thold_TXHEADER0_TXUSRCLK20_posedge_posedge(1),
	HoldHigh => thold_TXHEADER0_TXUSRCLK20_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXHEADER02_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXHEADER02_TXUSRCLK20_posedge,
	TestSignal => TXHEADER0_dly(2),
	TestSignalName => "TXHEADER0(2)",
	TestDelay => tisd_TXHEADER0_TXUSRCLK20(2),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXHEADER0_TXUSRCLK20_posedge_posedge(2),
	SetupLow => tsetup_TXHEADER0_TXUSRCLK20_negedge_posedge(2),
	HoldLow => thold_TXHEADER0_TXUSRCLK20_posedge_posedge(2),
	HoldHigh => thold_TXHEADER0_TXUSRCLK20_negedge_posedge(2),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXSEQUENCE00_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXSEQUENCE00_TXUSRCLK20_posedge,
	TestSignal => TXSEQUENCE0_dly(0),
	TestSignalName => "TXSEQUENCE0(0)",
	TestDelay => tisd_TXSEQUENCE0_TXUSRCLK20(0),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXSEQUENCE0_TXUSRCLK20_posedge_posedge(0),
	SetupLow => tsetup_TXSEQUENCE0_TXUSRCLK20_negedge_posedge(0),
	HoldLow => thold_TXSEQUENCE0_TXUSRCLK20_posedge_posedge(0),
	HoldHigh => thold_TXSEQUENCE0_TXUSRCLK20_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXSEQUENCE01_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXSEQUENCE01_TXUSRCLK20_posedge,
	TestSignal => TXSEQUENCE0_dly(1),
	TestSignalName => "TXSEQUENCE0(1)",
	TestDelay => tisd_TXSEQUENCE0_TXUSRCLK20(1),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXSEQUENCE0_TXUSRCLK20_posedge_posedge(1),
	SetupLow => tsetup_TXSEQUENCE0_TXUSRCLK20_negedge_posedge(1),
	HoldLow => thold_TXSEQUENCE0_TXUSRCLK20_posedge_posedge(1),
	HoldHigh => thold_TXSEQUENCE0_TXUSRCLK20_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXSEQUENCE02_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXSEQUENCE02_TXUSRCLK20_posedge,
	TestSignal => TXSEQUENCE0_dly(2),
	TestSignalName => "TXSEQUENCE0(2)",
	TestDelay => tisd_TXSEQUENCE0_TXUSRCLK20(2),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXSEQUENCE0_TXUSRCLK20_posedge_posedge(2),
	SetupLow => tsetup_TXSEQUENCE0_TXUSRCLK20_negedge_posedge(2),
	HoldLow => thold_TXSEQUENCE0_TXUSRCLK20_posedge_posedge(2),
	HoldHigh => thold_TXSEQUENCE0_TXUSRCLK20_negedge_posedge(2),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXSEQUENCE03_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXSEQUENCE03_TXUSRCLK20_posedge,
	TestSignal => TXSEQUENCE0_dly(3),
	TestSignalName => "TXSEQUENCE0(3)",
	TestDelay => tisd_TXSEQUENCE0_TXUSRCLK20(3),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXSEQUENCE0_TXUSRCLK20_posedge_posedge(3),
	SetupLow => tsetup_TXSEQUENCE0_TXUSRCLK20_negedge_posedge(3),
	HoldLow => thold_TXSEQUENCE0_TXUSRCLK20_posedge_posedge(3),
	HoldHigh => thold_TXSEQUENCE0_TXUSRCLK20_negedge_posedge(3),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXSEQUENCE04_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXSEQUENCE04_TXUSRCLK20_posedge,
	TestSignal => TXSEQUENCE0_dly(4),
	TestSignalName => "TXSEQUENCE0(4)",
	TestDelay => tisd_TXSEQUENCE0_TXUSRCLK20(4),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXSEQUENCE0_TXUSRCLK20_posedge_posedge(4),
	SetupLow => tsetup_TXSEQUENCE0_TXUSRCLK20_negedge_posedge(4),
	HoldLow => thold_TXSEQUENCE0_TXUSRCLK20_posedge_posedge(4),
	HoldHigh => thold_TXSEQUENCE0_TXUSRCLK20_negedge_posedge(4),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXSEQUENCE05_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXSEQUENCE05_TXUSRCLK20_posedge,
	TestSignal => TXSEQUENCE0_dly(5),
	TestSignalName => "TXSEQUENCE0(5)",
	TestDelay => tisd_TXSEQUENCE0_TXUSRCLK20(5),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXSEQUENCE0_TXUSRCLK20_posedge_posedge(5),
	SetupLow => tsetup_TXSEQUENCE0_TXUSRCLK20_negedge_posedge(5),
	HoldLow => thold_TXSEQUENCE0_TXUSRCLK20_posedge_posedge(5),
	HoldHigh => thold_TXSEQUENCE0_TXUSRCLK20_negedge_posedge(5),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXSEQUENCE06_TXUSRCLK20_posedge,
	TimingData => Tmkr_TXSEQUENCE06_TXUSRCLK20_posedge,
	TestSignal => TXSEQUENCE0_dly(6),
	TestSignalName => "TXSEQUENCE0(6)",
	TestDelay => tisd_TXSEQUENCE0_TXUSRCLK20(6),
	RefSignal => TXUSRCLK20_dly,
	RefSignalName => "TXUSRCLK20",
	RefDelay => ticd_TXUSRCLK20,
	SetupHigh => tsetup_TXSEQUENCE0_TXUSRCLK20_posedge_posedge(6),
	SetupLow => tsetup_TXSEQUENCE0_TXUSRCLK20_negedge_posedge(6),
	HoldLow => thold_TXSEQUENCE0_TXUSRCLK20_posedge_posedge(6),
	HoldHigh => thold_TXSEQUENCE0_TXUSRCLK20_negedge_posedge(6),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_TXSTARTSEQ0_TXUSRCLK20_posedge,
	TimingData     => Tmkr_TXSTARTSEQ0_TXUSRCLK20_posedge,
	TestSignal     => TXSTARTSEQ0,
	TestSignalName => "TXSTARTSEQ0",
	TestDelay      => 0 ps,
	RefSignal => TXUSRCLK20_dly,
	RefSignalName  => "TXUSRCLK20",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_TXSTARTSEQ0_TXUSRCLK20_posedge_posedge,
	SetupLow       => tsetup_TXSTARTSEQ0_TXUSRCLK20_negedge_posedge,
	HoldLow        => thold_TXSTARTSEQ0_TXUSRCLK20_posedge_posedge,
	HoldHigh       => thold_TXSTARTSEQ0_TXUSRCLK20_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_RXGEARBOXSLIP0_RXUSRCLK20_posedge,
	TimingData     => Tmkr_RXGEARBOXSLIP0_RXUSRCLK20_posedge,
	TestSignal     => RXGEARBOXSLIP0,
	TestSignalName => "RXGEARBOXSLIP0",
	TestDelay      => 0 ps,
	RefSignal => RXUSRCLK20_dly,
	RefSignalName  => "RXUSRCLK20",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_RXGEARBOXSLIP0_RXUSRCLK20_posedge_posedge,
	SetupLow       => tsetup_RXGEARBOXSLIP0_RXUSRCLK20_negedge_posedge,
	HoldLow        => thold_RXGEARBOXSLIP0_RXUSRCLK20_posedge_posedge,
	HoldHigh       => thold_RXGEARBOXSLIP0_RXUSRCLK20_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXHEADER10_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXHEADER10_TXUSRCLK21_posedge,
	TestSignal => TXHEADER1_dly(0),
	TestSignalName => "TXHEADER1(0)",
	TestDelay => tisd_TXHEADER1_TXUSRCLK21(0),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXHEADER1_TXUSRCLK21_posedge_posedge(0),
	SetupLow => tsetup_TXHEADER1_TXUSRCLK21_negedge_posedge(0),
	HoldLow => thold_TXHEADER1_TXUSRCLK21_posedge_posedge(0),
	HoldHigh => thold_TXHEADER1_TXUSRCLK21_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXHEADER11_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXHEADER11_TXUSRCLK21_posedge,
	TestSignal => TXHEADER1_dly(1),
	TestSignalName => "TXHEADER1(1)",
	TestDelay => tisd_TXHEADER1_TXUSRCLK21(1),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXHEADER1_TXUSRCLK21_posedge_posedge(1),
	SetupLow => tsetup_TXHEADER1_TXUSRCLK21_negedge_posedge(1),
	HoldLow => thold_TXHEADER1_TXUSRCLK21_posedge_posedge(1),
	HoldHigh => thold_TXHEADER1_TXUSRCLK21_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXHEADER12_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXHEADER12_TXUSRCLK21_posedge,
	TestSignal => TXHEADER1_dly(2),
	TestSignalName => "TXHEADER1(2)",
	TestDelay => tisd_TXHEADER1_TXUSRCLK21(2),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXHEADER1_TXUSRCLK21_posedge_posedge(2),
	SetupLow => tsetup_TXHEADER1_TXUSRCLK21_negedge_posedge(2),
	HoldLow => thold_TXHEADER1_TXUSRCLK21_posedge_posedge(2),
	HoldHigh => thold_TXHEADER1_TXUSRCLK21_negedge_posedge(2),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXSEQUENCE10_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXSEQUENCE10_TXUSRCLK21_posedge,
	TestSignal => TXSEQUENCE1_dly(0),
	TestSignalName => "TXSEQUENCE1(0)",
	TestDelay => tisd_TXSEQUENCE1_TXUSRCLK21(0),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXSEQUENCE1_TXUSRCLK21_posedge_posedge(0),
	SetupLow => tsetup_TXSEQUENCE1_TXUSRCLK21_negedge_posedge(0),
	HoldLow => thold_TXSEQUENCE1_TXUSRCLK21_posedge_posedge(0),
	HoldHigh => thold_TXSEQUENCE1_TXUSRCLK21_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXSEQUENCE11_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXSEQUENCE11_TXUSRCLK21_posedge,
	TestSignal => TXSEQUENCE1_dly(1),
	TestSignalName => "TXSEQUENCE1(1)",
	TestDelay => tisd_TXSEQUENCE1_TXUSRCLK21(1),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXSEQUENCE1_TXUSRCLK21_posedge_posedge(1),
	SetupLow => tsetup_TXSEQUENCE1_TXUSRCLK21_negedge_posedge(1),
	HoldLow => thold_TXSEQUENCE1_TXUSRCLK21_posedge_posedge(1),
	HoldHigh => thold_TXSEQUENCE1_TXUSRCLK21_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXSEQUENCE12_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXSEQUENCE12_TXUSRCLK21_posedge,
	TestSignal => TXSEQUENCE1_dly(2),
	TestSignalName => "TXSEQUENCE1(2)",
	TestDelay => tisd_TXSEQUENCE1_TXUSRCLK21(2),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXSEQUENCE1_TXUSRCLK21_posedge_posedge(2),
	SetupLow => tsetup_TXSEQUENCE1_TXUSRCLK21_negedge_posedge(2),
	HoldLow => thold_TXSEQUENCE1_TXUSRCLK21_posedge_posedge(2),
	HoldHigh => thold_TXSEQUENCE1_TXUSRCLK21_negedge_posedge(2),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXSEQUENCE13_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXSEQUENCE13_TXUSRCLK21_posedge,
	TestSignal => TXSEQUENCE1_dly(3),
	TestSignalName => "TXSEQUENCE1(3)",
	TestDelay => tisd_TXSEQUENCE1_TXUSRCLK21(3),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXSEQUENCE1_TXUSRCLK21_posedge_posedge(3),
	SetupLow => tsetup_TXSEQUENCE1_TXUSRCLK21_negedge_posedge(3),
	HoldLow => thold_TXSEQUENCE1_TXUSRCLK21_posedge_posedge(3),
	HoldHigh => thold_TXSEQUENCE1_TXUSRCLK21_negedge_posedge(3),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXSEQUENCE14_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXSEQUENCE14_TXUSRCLK21_posedge,
	TestSignal => TXSEQUENCE1_dly(4),
	TestSignalName => "TXSEQUENCE1(4)",
	TestDelay => tisd_TXSEQUENCE1_TXUSRCLK21(4),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXSEQUENCE1_TXUSRCLK21_posedge_posedge(4),
	SetupLow => tsetup_TXSEQUENCE1_TXUSRCLK21_negedge_posedge(4),
	HoldLow => thold_TXSEQUENCE1_TXUSRCLK21_posedge_posedge(4),
	HoldHigh => thold_TXSEQUENCE1_TXUSRCLK21_negedge_posedge(4),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXSEQUENCE15_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXSEQUENCE15_TXUSRCLK21_posedge,
	TestSignal => TXSEQUENCE1_dly(5),
	TestSignalName => "TXSEQUENCE1(5)",
	TestDelay => tisd_TXSEQUENCE1_TXUSRCLK21(5),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXSEQUENCE1_TXUSRCLK21_posedge_posedge(5),
	SetupLow => tsetup_TXSEQUENCE1_TXUSRCLK21_negedge_posedge(5),
	HoldLow => thold_TXSEQUENCE1_TXUSRCLK21_posedge_posedge(5),
	HoldHigh => thold_TXSEQUENCE1_TXUSRCLK21_negedge_posedge(5),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_TXSEQUENCE16_TXUSRCLK21_posedge,
	TimingData => Tmkr_TXSEQUENCE16_TXUSRCLK21_posedge,
	TestSignal => TXSEQUENCE1_dly(6),
	TestSignalName => "TXSEQUENCE1(6)",
	TestDelay => tisd_TXSEQUENCE1_TXUSRCLK21(6),
	RefSignal => TXUSRCLK21_dly,
	RefSignalName => "TXUSRCLK21",
	RefDelay => ticd_TXUSRCLK21,
	SetupHigh => tsetup_TXSEQUENCE1_TXUSRCLK21_posedge_posedge(6),
	SetupLow => tsetup_TXSEQUENCE1_TXUSRCLK21_negedge_posedge(6),
	HoldLow => thold_TXSEQUENCE1_TXUSRCLK21_posedge_posedge(6),
	HoldHigh => thold_TXSEQUENCE1_TXUSRCLK21_negedge_posedge(6),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_TXSTARTSEQ1_TXUSRCLK21_posedge,
	TimingData     => Tmkr_TXSTARTSEQ1_TXUSRCLK21_posedge,
	TestSignal     => TXSTARTSEQ1,
	TestSignalName => "TXSTARTSEQ1",
	TestDelay      => 0 ps,
	RefSignal => TXUSRCLK21_dly,
	RefSignalName  => "TXUSRCLK21",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_TXSTARTSEQ1_TXUSRCLK21_posedge_posedge,
	SetupLow       => tsetup_TXSTARTSEQ1_TXUSRCLK21_negedge_posedge,
	HoldLow        => thold_TXSTARTSEQ1_TXUSRCLK21_posedge_posedge,
	HoldHigh       => thold_TXSTARTSEQ1_TXUSRCLK21_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation      => Tviol_RXGEARBOXSLIP1_RXUSRCLK21_posedge,
	TimingData     => Tmkr_RXGEARBOXSLIP1_RXUSRCLK21_posedge,
	TestSignal     => RXGEARBOXSLIP1,
	TestSignalName => "RXGEARBOXSLIP1",
	TestDelay      => 0 ps,
	RefSignal => RXUSRCLK21_dly,
	RefSignalName  => "RXUSRCLK21",
	RefDelay       => 0 ps,
	SetupHigh      => tsetup_RXGEARBOXSLIP1_RXUSRCLK21_posedge_posedge,
	SetupLow       => tsetup_RXGEARBOXSLIP1_RXUSRCLK21_negedge_posedge,
	HoldLow        => thold_RXGEARBOXSLIP1_RXUSRCLK21_posedge_posedge,
	HoldHigh       => thold_RXGEARBOXSLIP1_RXUSRCLK21_negedge_posedge,
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFECLKDLYADJ00_RXUSRCLK20_posedge,
	TimingData => Tmkr_DFECLKDLYADJ00_RXUSRCLK20_posedge,
	TestSignal => DFECLKDLYADJ0_dly(0),
	TestSignalName => "DFECLKDLYADJ0(0)",
	TestDelay => tisd_DFECLKDLYADJ0_RXUSRCLK20(0),
	RefSignal => RXUSRCLK20_dly,
	RefSignalName => "RXUSRCLK20",
	RefDelay => ticd_RXUSRCLK20,
	SetupHigh => tsetup_DFECLKDLYADJ0_RXUSRCLK20_posedge_posedge(0),
	SetupLow => tsetup_DFECLKDLYADJ0_RXUSRCLK20_negedge_posedge(0),
	HoldLow => thold_DFECLKDLYADJ0_RXUSRCLK20_posedge_posedge(0),
	HoldHigh => thold_DFECLKDLYADJ0_RXUSRCLK20_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFECLKDLYADJ01_RXUSRCLK20_posedge,
	TimingData => Tmkr_DFECLKDLYADJ01_RXUSRCLK20_posedge,
	TestSignal => DFECLKDLYADJ0_dly(1),
	TestSignalName => "DFECLKDLYADJ0(1)",
	TestDelay => tisd_DFECLKDLYADJ0_RXUSRCLK20(1),
	RefSignal => RXUSRCLK20_dly,
	RefSignalName => "RXUSRCLK20",
	RefDelay => ticd_RXUSRCLK20,
	SetupHigh => tsetup_DFECLKDLYADJ0_RXUSRCLK20_posedge_posedge(1),
	SetupLow => tsetup_DFECLKDLYADJ0_RXUSRCLK20_negedge_posedge(1),
	HoldLow => thold_DFECLKDLYADJ0_RXUSRCLK20_posedge_posedge(1),
	HoldHigh => thold_DFECLKDLYADJ0_RXUSRCLK20_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFECLKDLYADJ02_RXUSRCLK20_posedge,
	TimingData => Tmkr_DFECLKDLYADJ02_RXUSRCLK20_posedge,
	TestSignal => DFECLKDLYADJ0_dly(2),
	TestSignalName => "DFECLKDLYADJ0(2)",
	TestDelay => tisd_DFECLKDLYADJ0_RXUSRCLK20(2),
	RefSignal => RXUSRCLK20_dly,
	RefSignalName => "RXUSRCLK20",
	RefDelay => ticd_RXUSRCLK20,
	SetupHigh => tsetup_DFECLKDLYADJ0_RXUSRCLK20_posedge_posedge(2),
	SetupLow => tsetup_DFECLKDLYADJ0_RXUSRCLK20_negedge_posedge(2),
	HoldLow => thold_DFECLKDLYADJ0_RXUSRCLK20_posedge_posedge(2),
	HoldHigh => thold_DFECLKDLYADJ0_RXUSRCLK20_negedge_posedge(2),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFECLKDLYADJ03_RXUSRCLK20_posedge,
	TimingData => Tmkr_DFECLKDLYADJ03_RXUSRCLK20_posedge,
	TestSignal => DFECLKDLYADJ0_dly(3),
	TestSignalName => "DFECLKDLYADJ0(3)",
	TestDelay => tisd_DFECLKDLYADJ0_RXUSRCLK20(3),
	RefSignal => RXUSRCLK20_dly,
	RefSignalName => "RXUSRCLK20",
	RefDelay => ticd_RXUSRCLK20,
	SetupHigh => tsetup_DFECLKDLYADJ0_RXUSRCLK20_posedge_posedge(3),
	SetupLow => tsetup_DFECLKDLYADJ0_RXUSRCLK20_negedge_posedge(3),
	HoldLow => thold_DFECLKDLYADJ0_RXUSRCLK20_posedge_posedge(3),
	HoldHigh => thold_DFECLKDLYADJ0_RXUSRCLK20_negedge_posedge(3),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFECLKDLYADJ04_RXUSRCLK20_posedge,
	TimingData => Tmkr_DFECLKDLYADJ04_RXUSRCLK20_posedge,
	TestSignal => DFECLKDLYADJ0_dly(4),
	TestSignalName => "DFECLKDLYADJ0(4)",
	TestDelay => tisd_DFECLKDLYADJ0_RXUSRCLK20(4),
	RefSignal => RXUSRCLK20_dly,
	RefSignalName => "RXUSRCLK20",
	RefDelay => ticd_RXUSRCLK20,
	SetupHigh => tsetup_DFECLKDLYADJ0_RXUSRCLK20_posedge_posedge(4),
	SetupLow => tsetup_DFECLKDLYADJ0_RXUSRCLK20_negedge_posedge(4),
	HoldLow => thold_DFECLKDLYADJ0_RXUSRCLK20_posedge_posedge(4),
	HoldHigh => thold_DFECLKDLYADJ0_RXUSRCLK20_negedge_posedge(4),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFECLKDLYADJ05_RXUSRCLK20_posedge,
	TimingData => Tmkr_DFECLKDLYADJ05_RXUSRCLK20_posedge,
	TestSignal => DFECLKDLYADJ0_dly(5),
	TestSignalName => "DFECLKDLYADJ0(5)",
	TestDelay => tisd_DFECLKDLYADJ0_RXUSRCLK20(5),
	RefSignal => RXUSRCLK20_dly,
	RefSignalName => "RXUSRCLK20",
	RefDelay => ticd_RXUSRCLK20,
	SetupHigh => tsetup_DFECLKDLYADJ0_RXUSRCLK20_posedge_posedge(5),
	SetupLow => tsetup_DFECLKDLYADJ0_RXUSRCLK20_negedge_posedge(5),
	HoldLow => thold_DFECLKDLYADJ0_RXUSRCLK20_posedge_posedge(5),
	HoldHigh => thold_DFECLKDLYADJ0_RXUSRCLK20_negedge_posedge(5),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP100_RXUSRCLK20_posedge,
	TimingData => Tmkr_DFETAP100_RXUSRCLK20_posedge,
	TestSignal => DFETAP10_dly(0),
	TestSignalName => "DFETAP10(0)",
	TestDelay => tisd_DFETAP10_RXUSRCLK20(0),
	RefSignal => RXUSRCLK20_dly,
	RefSignalName => "RXUSRCLK20",
	RefDelay => ticd_RXUSRCLK20,
	SetupHigh => tsetup_DFETAP10_RXUSRCLK20_posedge_posedge(0),
	SetupLow => tsetup_DFETAP10_RXUSRCLK20_negedge_posedge(0),
	HoldLow => thold_DFETAP10_RXUSRCLK20_posedge_posedge(0),
	HoldHigh => thold_DFETAP10_RXUSRCLK20_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP101_RXUSRCLK20_posedge,
	TimingData => Tmkr_DFETAP101_RXUSRCLK20_posedge,
	TestSignal => DFETAP10_dly(1),
	TestSignalName => "DFETAP10(1)",
	TestDelay => tisd_DFETAP10_RXUSRCLK20(1),
	RefSignal => RXUSRCLK20_dly,
	RefSignalName => "RXUSRCLK20",
	RefDelay => ticd_RXUSRCLK20,
	SetupHigh => tsetup_DFETAP10_RXUSRCLK20_posedge_posedge(1),
	SetupLow => tsetup_DFETAP10_RXUSRCLK20_negedge_posedge(1),
	HoldLow => thold_DFETAP10_RXUSRCLK20_posedge_posedge(1),
	HoldHigh => thold_DFETAP10_RXUSRCLK20_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP102_RXUSRCLK20_posedge,
	TimingData => Tmkr_DFETAP102_RXUSRCLK20_posedge,
	TestSignal => DFETAP10_dly(2),
	TestSignalName => "DFETAP10(2)",
	TestDelay => tisd_DFETAP10_RXUSRCLK20(2),
	RefSignal => RXUSRCLK20_dly,
	RefSignalName => "RXUSRCLK20",
	RefDelay => ticd_RXUSRCLK20,
	SetupHigh => tsetup_DFETAP10_RXUSRCLK20_posedge_posedge(2),
	SetupLow => tsetup_DFETAP10_RXUSRCLK20_negedge_posedge(2),
	HoldLow => thold_DFETAP10_RXUSRCLK20_posedge_posedge(2),
	HoldHigh => thold_DFETAP10_RXUSRCLK20_negedge_posedge(2),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP103_RXUSRCLK20_posedge,
	TimingData => Tmkr_DFETAP103_RXUSRCLK20_posedge,
	TestSignal => DFETAP10_dly(3),
	TestSignalName => "DFETAP10(3)",
	TestDelay => tisd_DFETAP10_RXUSRCLK20(3),
	RefSignal => RXUSRCLK20_dly,
	RefSignalName => "RXUSRCLK20",
	RefDelay => ticd_RXUSRCLK20,
	SetupHigh => tsetup_DFETAP10_RXUSRCLK20_posedge_posedge(3),
	SetupLow => tsetup_DFETAP10_RXUSRCLK20_negedge_posedge(3),
	HoldLow => thold_DFETAP10_RXUSRCLK20_posedge_posedge(3),
	HoldHigh => thold_DFETAP10_RXUSRCLK20_negedge_posedge(3),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP104_RXUSRCLK20_posedge,
	TimingData => Tmkr_DFETAP104_RXUSRCLK20_posedge,
	TestSignal => DFETAP10_dly(4),
	TestSignalName => "DFETAP10(4)",
	TestDelay => tisd_DFETAP10_RXUSRCLK20(4),
	RefSignal => RXUSRCLK20_dly,
	RefSignalName => "RXUSRCLK20",
	RefDelay => ticd_RXUSRCLK20,
	SetupHigh => tsetup_DFETAP10_RXUSRCLK20_posedge_posedge(4),
	SetupLow => tsetup_DFETAP10_RXUSRCLK20_negedge_posedge(4),
	HoldLow => thold_DFETAP10_RXUSRCLK20_posedge_posedge(4),
	HoldHigh => thold_DFETAP10_RXUSRCLK20_negedge_posedge(4),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP200_RXUSRCLK20_posedge,
	TimingData => Tmkr_DFETAP200_RXUSRCLK20_posedge,
	TestSignal => DFETAP20_dly(0),
	TestSignalName => "DFETAP20(0)",
	TestDelay => tisd_DFETAP20_RXUSRCLK20(0),
	RefSignal => RXUSRCLK20_dly,
	RefSignalName => "RXUSRCLK20",
	RefDelay => ticd_RXUSRCLK20,
	SetupHigh => tsetup_DFETAP20_RXUSRCLK20_posedge_posedge(0),
	SetupLow => tsetup_DFETAP20_RXUSRCLK20_negedge_posedge(0),
	HoldLow => thold_DFETAP20_RXUSRCLK20_posedge_posedge(0),
	HoldHigh => thold_DFETAP20_RXUSRCLK20_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP201_RXUSRCLK20_posedge,
	TimingData => Tmkr_DFETAP201_RXUSRCLK20_posedge,
	TestSignal => DFETAP20_dly(1),
	TestSignalName => "DFETAP20(1)",
	TestDelay => tisd_DFETAP20_RXUSRCLK20(1),
	RefSignal => RXUSRCLK20_dly,
	RefSignalName => "RXUSRCLK20",
	RefDelay => ticd_RXUSRCLK20,
	SetupHigh => tsetup_DFETAP20_RXUSRCLK20_posedge_posedge(1),
	SetupLow => tsetup_DFETAP20_RXUSRCLK20_negedge_posedge(1),
	HoldLow => thold_DFETAP20_RXUSRCLK20_posedge_posedge(1),
	HoldHigh => thold_DFETAP20_RXUSRCLK20_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP202_RXUSRCLK20_posedge,
	TimingData => Tmkr_DFETAP202_RXUSRCLK20_posedge,
	TestSignal => DFETAP20_dly(2),
	TestSignalName => "DFETAP20(2)",
	TestDelay => tisd_DFETAP20_RXUSRCLK20(2),
	RefSignal => RXUSRCLK20_dly,
	RefSignalName => "RXUSRCLK20",
	RefDelay => ticd_RXUSRCLK20,
	SetupHigh => tsetup_DFETAP20_RXUSRCLK20_posedge_posedge(2),
	SetupLow => tsetup_DFETAP20_RXUSRCLK20_negedge_posedge(2),
	HoldLow => thold_DFETAP20_RXUSRCLK20_posedge_posedge(2),
	HoldHigh => thold_DFETAP20_RXUSRCLK20_negedge_posedge(2),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP203_RXUSRCLK20_posedge,
	TimingData => Tmkr_DFETAP203_RXUSRCLK20_posedge,
	TestSignal => DFETAP20_dly(3),
	TestSignalName => "DFETAP20(3)",
	TestDelay => tisd_DFETAP20_RXUSRCLK20(3),
	RefSignal => RXUSRCLK20_dly,
	RefSignalName => "RXUSRCLK20",
	RefDelay => ticd_RXUSRCLK20,
	SetupHigh => tsetup_DFETAP20_RXUSRCLK20_posedge_posedge(3),
	SetupLow => tsetup_DFETAP20_RXUSRCLK20_negedge_posedge(3),
	HoldLow => thold_DFETAP20_RXUSRCLK20_posedge_posedge(3),
	HoldHigh => thold_DFETAP20_RXUSRCLK20_negedge_posedge(3),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP204_RXUSRCLK20_posedge,
	TimingData => Tmkr_DFETAP204_RXUSRCLK20_posedge,
	TestSignal => DFETAP20_dly(4),
	TestSignalName => "DFETAP20(4)",
	TestDelay => tisd_DFETAP20_RXUSRCLK20(4),
	RefSignal => RXUSRCLK20_dly,
	RefSignalName => "RXUSRCLK20",
	RefDelay => ticd_RXUSRCLK20,
	SetupHigh => tsetup_DFETAP20_RXUSRCLK20_posedge_posedge(4),
	SetupLow => tsetup_DFETAP20_RXUSRCLK20_negedge_posedge(4),
	HoldLow => thold_DFETAP20_RXUSRCLK20_posedge_posedge(4),
	HoldHigh => thold_DFETAP20_RXUSRCLK20_negedge_posedge(4),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP300_RXUSRCLK20_posedge,
	TimingData => Tmkr_DFETAP300_RXUSRCLK20_posedge,
	TestSignal => DFETAP30_dly(0),
	TestSignalName => "DFETAP30(0)",
	TestDelay => tisd_DFETAP30_RXUSRCLK20(0),
	RefSignal => RXUSRCLK20_dly,
	RefSignalName => "RXUSRCLK20",
	RefDelay => ticd_RXUSRCLK20,
	SetupHigh => tsetup_DFETAP30_RXUSRCLK20_posedge_posedge(0),
	SetupLow => tsetup_DFETAP30_RXUSRCLK20_negedge_posedge(0),
	HoldLow => thold_DFETAP30_RXUSRCLK20_posedge_posedge(0),
	HoldHigh => thold_DFETAP30_RXUSRCLK20_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP301_RXUSRCLK20_posedge,
	TimingData => Tmkr_DFETAP301_RXUSRCLK20_posedge,
	TestSignal => DFETAP30_dly(1),
	TestSignalName => "DFETAP30(1)",
	TestDelay => tisd_DFETAP30_RXUSRCLK20(1),
	RefSignal => RXUSRCLK20_dly,
	RefSignalName => "RXUSRCLK20",
	RefDelay => ticd_RXUSRCLK20,
	SetupHigh => tsetup_DFETAP30_RXUSRCLK20_posedge_posedge(1),
	SetupLow => tsetup_DFETAP30_RXUSRCLK20_negedge_posedge(1),
	HoldLow => thold_DFETAP30_RXUSRCLK20_posedge_posedge(1),
	HoldHigh => thold_DFETAP30_RXUSRCLK20_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP302_RXUSRCLK20_posedge,
	TimingData => Tmkr_DFETAP302_RXUSRCLK20_posedge,
	TestSignal => DFETAP30_dly(2),
	TestSignalName => "DFETAP30(2)",
	TestDelay => tisd_DFETAP30_RXUSRCLK20(2),
	RefSignal => RXUSRCLK20_dly,
	RefSignalName => "RXUSRCLK20",
	RefDelay => ticd_RXUSRCLK20,
	SetupHigh => tsetup_DFETAP30_RXUSRCLK20_posedge_posedge(2),
	SetupLow => tsetup_DFETAP30_RXUSRCLK20_negedge_posedge(2),
	HoldLow => thold_DFETAP30_RXUSRCLK20_posedge_posedge(2),
	HoldHigh => thold_DFETAP30_RXUSRCLK20_negedge_posedge(2),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP303_RXUSRCLK20_posedge,
	TimingData => Tmkr_DFETAP303_RXUSRCLK20_posedge,
	TestSignal => DFETAP30_dly(3),
	TestSignalName => "DFETAP30(3)",
	TestDelay => tisd_DFETAP30_RXUSRCLK20(3),
	RefSignal => RXUSRCLK20_dly,
	RefSignalName => "RXUSRCLK20",
	RefDelay => ticd_RXUSRCLK20,
	SetupHigh => tsetup_DFETAP30_RXUSRCLK20_posedge_posedge(3),
	SetupLow => tsetup_DFETAP30_RXUSRCLK20_negedge_posedge(3),
	HoldLow => thold_DFETAP30_RXUSRCLK20_posedge_posedge(3),
	HoldHigh => thold_DFETAP30_RXUSRCLK20_negedge_posedge(3),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP400_RXUSRCLK20_posedge,
	TimingData => Tmkr_DFETAP400_RXUSRCLK20_posedge,
	TestSignal => DFETAP40_dly(0),
	TestSignalName => "DFETAP40(0)",
	TestDelay => tisd_DFETAP40_RXUSRCLK20(0),
	RefSignal => RXUSRCLK20_dly,
	RefSignalName => "RXUSRCLK20",
	RefDelay => ticd_RXUSRCLK20,
	SetupHigh => tsetup_DFETAP40_RXUSRCLK20_posedge_posedge(0),
	SetupLow => tsetup_DFETAP40_RXUSRCLK20_negedge_posedge(0),
	HoldLow => thold_DFETAP40_RXUSRCLK20_posedge_posedge(0),
	HoldHigh => thold_DFETAP40_RXUSRCLK20_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP401_RXUSRCLK20_posedge,
	TimingData => Tmkr_DFETAP401_RXUSRCLK20_posedge,
	TestSignal => DFETAP40_dly(1),
	TestSignalName => "DFETAP40(1)",
	TestDelay => tisd_DFETAP40_RXUSRCLK20(1),
	RefSignal => RXUSRCLK20_dly,
	RefSignalName => "RXUSRCLK20",
	RefDelay => ticd_RXUSRCLK20,
	SetupHigh => tsetup_DFETAP40_RXUSRCLK20_posedge_posedge(1),
	SetupLow => tsetup_DFETAP40_RXUSRCLK20_negedge_posedge(1),
	HoldLow => thold_DFETAP40_RXUSRCLK20_posedge_posedge(1),
	HoldHigh => thold_DFETAP40_RXUSRCLK20_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP402_RXUSRCLK20_posedge,
	TimingData => Tmkr_DFETAP402_RXUSRCLK20_posedge,
	TestSignal => DFETAP40_dly(2),
	TestSignalName => "DFETAP40(2)",
	TestDelay => tisd_DFETAP40_RXUSRCLK20(2),
	RefSignal => RXUSRCLK20_dly,
	RefSignalName => "RXUSRCLK20",
	RefDelay => ticd_RXUSRCLK20,
	SetupHigh => tsetup_DFETAP40_RXUSRCLK20_posedge_posedge(2),
	SetupLow => tsetup_DFETAP40_RXUSRCLK20_negedge_posedge(2),
	HoldLow => thold_DFETAP40_RXUSRCLK20_posedge_posedge(2),
	HoldHigh => thold_DFETAP40_RXUSRCLK20_negedge_posedge(2),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP403_RXUSRCLK20_posedge,
	TimingData => Tmkr_DFETAP403_RXUSRCLK20_posedge,
	TestSignal => DFETAP40_dly(3),
	TestSignalName => "DFETAP40(3)",
	TestDelay => tisd_DFETAP40_RXUSRCLK20(3),
	RefSignal => RXUSRCLK20_dly,
	RefSignalName => "RXUSRCLK20",
	RefDelay => ticd_RXUSRCLK20,
	SetupHigh => tsetup_DFETAP40_RXUSRCLK20_posedge_posedge(3),
	SetupLow => tsetup_DFETAP40_RXUSRCLK20_negedge_posedge(3),
	HoldLow => thold_DFETAP40_RXUSRCLK20_posedge_posedge(3),
	HoldHigh => thold_DFETAP40_RXUSRCLK20_negedge_posedge(3),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFECLKDLYADJ10_RXUSRCLK21_posedge,
	TimingData => Tmkr_DFECLKDLYADJ10_RXUSRCLK21_posedge,
	TestSignal => DFECLKDLYADJ1_dly(0),
	TestSignalName => "DFECLKDLYADJ1(0)",
	TestDelay => tisd_DFECLKDLYADJ1_RXUSRCLK21(0),
	RefSignal => RXUSRCLK21_dly,
	RefSignalName => "RXUSRCLK21",
	RefDelay => ticd_RXUSRCLK21,
	SetupHigh => tsetup_DFECLKDLYADJ1_RXUSRCLK21_posedge_posedge(0),
	SetupLow => tsetup_DFECLKDLYADJ1_RXUSRCLK21_negedge_posedge(0),
	HoldLow => thold_DFECLKDLYADJ1_RXUSRCLK21_posedge_posedge(0),
	HoldHigh => thold_DFECLKDLYADJ1_RXUSRCLK21_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFECLKDLYADJ11_RXUSRCLK21_posedge,
	TimingData => Tmkr_DFECLKDLYADJ11_RXUSRCLK21_posedge,
	TestSignal => DFECLKDLYADJ1_dly(1),
	TestSignalName => "DFECLKDLYADJ1(1)",
	TestDelay => tisd_DFECLKDLYADJ1_RXUSRCLK21(1),
	RefSignal => RXUSRCLK21_dly,
	RefSignalName => "RXUSRCLK21",
	RefDelay => ticd_RXUSRCLK21,
	SetupHigh => tsetup_DFECLKDLYADJ1_RXUSRCLK21_posedge_posedge(1),
	SetupLow => tsetup_DFECLKDLYADJ1_RXUSRCLK21_negedge_posedge(1),
	HoldLow => thold_DFECLKDLYADJ1_RXUSRCLK21_posedge_posedge(1),
	HoldHigh => thold_DFECLKDLYADJ1_RXUSRCLK21_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFECLKDLYADJ12_RXUSRCLK21_posedge,
	TimingData => Tmkr_DFECLKDLYADJ12_RXUSRCLK21_posedge,
	TestSignal => DFECLKDLYADJ1_dly(2),
	TestSignalName => "DFECLKDLYADJ1(2)",
	TestDelay => tisd_DFECLKDLYADJ1_RXUSRCLK21(2),
	RefSignal => RXUSRCLK21_dly,
	RefSignalName => "RXUSRCLK21",
	RefDelay => ticd_RXUSRCLK21,
	SetupHigh => tsetup_DFECLKDLYADJ1_RXUSRCLK21_posedge_posedge(2),
	SetupLow => tsetup_DFECLKDLYADJ1_RXUSRCLK21_negedge_posedge(2),
	HoldLow => thold_DFECLKDLYADJ1_RXUSRCLK21_posedge_posedge(2),
	HoldHigh => thold_DFECLKDLYADJ1_RXUSRCLK21_negedge_posedge(2),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFECLKDLYADJ13_RXUSRCLK21_posedge,
	TimingData => Tmkr_DFECLKDLYADJ13_RXUSRCLK21_posedge,
	TestSignal => DFECLKDLYADJ1_dly(3),
	TestSignalName => "DFECLKDLYADJ1(3)",
	TestDelay => tisd_DFECLKDLYADJ1_RXUSRCLK21(3),
	RefSignal => RXUSRCLK21_dly,
	RefSignalName => "RXUSRCLK21",
	RefDelay => ticd_RXUSRCLK21,
	SetupHigh => tsetup_DFECLKDLYADJ1_RXUSRCLK21_posedge_posedge(3),
	SetupLow => tsetup_DFECLKDLYADJ1_RXUSRCLK21_negedge_posedge(3),
	HoldLow => thold_DFECLKDLYADJ1_RXUSRCLK21_posedge_posedge(3),
	HoldHigh => thold_DFECLKDLYADJ1_RXUSRCLK21_negedge_posedge(3),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFECLKDLYADJ14_RXUSRCLK21_posedge,
	TimingData => Tmkr_DFECLKDLYADJ14_RXUSRCLK21_posedge,
	TestSignal => DFECLKDLYADJ1_dly(4),
	TestSignalName => "DFECLKDLYADJ1(4)",
	TestDelay => tisd_DFECLKDLYADJ1_RXUSRCLK21(4),
	RefSignal => RXUSRCLK21_dly,
	RefSignalName => "RXUSRCLK21",
	RefDelay => ticd_RXUSRCLK21,
	SetupHigh => tsetup_DFECLKDLYADJ1_RXUSRCLK21_posedge_posedge(4),
	SetupLow => tsetup_DFECLKDLYADJ1_RXUSRCLK21_negedge_posedge(4),
	HoldLow => thold_DFECLKDLYADJ1_RXUSRCLK21_posedge_posedge(4),
	HoldHigh => thold_DFECLKDLYADJ1_RXUSRCLK21_negedge_posedge(4),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFECLKDLYADJ15_RXUSRCLK21_posedge,
	TimingData => Tmkr_DFECLKDLYADJ15_RXUSRCLK21_posedge,
	TestSignal => DFECLKDLYADJ1_dly(5),
	TestSignalName => "DFECLKDLYADJ1(5)",
	TestDelay => tisd_DFECLKDLYADJ1_RXUSRCLK21(5),
	RefSignal => RXUSRCLK21_dly,
	RefSignalName => "RXUSRCLK21",
	RefDelay => ticd_RXUSRCLK21,
	SetupHigh => tsetup_DFECLKDLYADJ1_RXUSRCLK21_posedge_posedge(5),
	SetupLow => tsetup_DFECLKDLYADJ1_RXUSRCLK21_negedge_posedge(5),
	HoldLow => thold_DFECLKDLYADJ1_RXUSRCLK21_posedge_posedge(5),
	HoldHigh => thold_DFECLKDLYADJ1_RXUSRCLK21_negedge_posedge(5),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP110_RXUSRCLK21_posedge,
	TimingData => Tmkr_DFETAP110_RXUSRCLK21_posedge,
	TestSignal => DFETAP11_dly(0),
	TestSignalName => "DFETAP11(0)",
	TestDelay => tisd_DFETAP11_RXUSRCLK21(0),
	RefSignal => RXUSRCLK21_dly,
	RefSignalName => "RXUSRCLK21",
	RefDelay => ticd_RXUSRCLK21,
	SetupHigh => tsetup_DFETAP11_RXUSRCLK21_posedge_posedge(0),
	SetupLow => tsetup_DFETAP11_RXUSRCLK21_negedge_posedge(0),
	HoldLow => thold_DFETAP11_RXUSRCLK21_posedge_posedge(0),
	HoldHigh => thold_DFETAP11_RXUSRCLK21_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP111_RXUSRCLK21_posedge,
	TimingData => Tmkr_DFETAP111_RXUSRCLK21_posedge,
	TestSignal => DFETAP11_dly(1),
	TestSignalName => "DFETAP11(1)",
	TestDelay => tisd_DFETAP11_RXUSRCLK21(1),
	RefSignal => RXUSRCLK21_dly,
	RefSignalName => "RXUSRCLK21",
	RefDelay => ticd_RXUSRCLK21,
	SetupHigh => tsetup_DFETAP11_RXUSRCLK21_posedge_posedge(1),
	SetupLow => tsetup_DFETAP11_RXUSRCLK21_negedge_posedge(1),
	HoldLow => thold_DFETAP11_RXUSRCLK21_posedge_posedge(1),
	HoldHigh => thold_DFETAP11_RXUSRCLK21_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP112_RXUSRCLK21_posedge,
	TimingData => Tmkr_DFETAP112_RXUSRCLK21_posedge,
	TestSignal => DFETAP11_dly(2),
	TestSignalName => "DFETAP11(2)",
	TestDelay => tisd_DFETAP11_RXUSRCLK21(2),
	RefSignal => RXUSRCLK21_dly,
	RefSignalName => "RXUSRCLK21",
	RefDelay => ticd_RXUSRCLK21,
	SetupHigh => tsetup_DFETAP11_RXUSRCLK21_posedge_posedge(2),
	SetupLow => tsetup_DFETAP11_RXUSRCLK21_negedge_posedge(2),
	HoldLow => thold_DFETAP11_RXUSRCLK21_posedge_posedge(2),
	HoldHigh => thold_DFETAP11_RXUSRCLK21_negedge_posedge(2),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP113_RXUSRCLK21_posedge,
	TimingData => Tmkr_DFETAP113_RXUSRCLK21_posedge,
	TestSignal => DFETAP11_dly(3),
	TestSignalName => "DFETAP11(3)",
	TestDelay => tisd_DFETAP11_RXUSRCLK21(3),
	RefSignal => RXUSRCLK21_dly,
	RefSignalName => "RXUSRCLK21",
	RefDelay => ticd_RXUSRCLK21,
	SetupHigh => tsetup_DFETAP11_RXUSRCLK21_posedge_posedge(3),
	SetupLow => tsetup_DFETAP11_RXUSRCLK21_negedge_posedge(3),
	HoldLow => thold_DFETAP11_RXUSRCLK21_posedge_posedge(3),
	HoldHigh => thold_DFETAP11_RXUSRCLK21_negedge_posedge(3),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP114_RXUSRCLK21_posedge,
	TimingData => Tmkr_DFETAP114_RXUSRCLK21_posedge,
	TestSignal => DFETAP11_dly(4),
	TestSignalName => "DFETAP11(4)",
	TestDelay => tisd_DFETAP11_RXUSRCLK21(4),
	RefSignal => RXUSRCLK21_dly,
	RefSignalName => "RXUSRCLK21",
	RefDelay => ticd_RXUSRCLK21,
	SetupHigh => tsetup_DFETAP11_RXUSRCLK21_posedge_posedge(4),
	SetupLow => tsetup_DFETAP11_RXUSRCLK21_negedge_posedge(4),
	HoldLow => thold_DFETAP11_RXUSRCLK21_posedge_posedge(4),
	HoldHigh => thold_DFETAP11_RXUSRCLK21_negedge_posedge(4),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP210_RXUSRCLK21_posedge,
	TimingData => Tmkr_DFETAP210_RXUSRCLK21_posedge,
	TestSignal => DFETAP21_dly(0),
	TestSignalName => "DFETAP21(0)",
	TestDelay => tisd_DFETAP21_RXUSRCLK21(0),
	RefSignal => RXUSRCLK21_dly,
	RefSignalName => "RXUSRCLK21",
	RefDelay => ticd_RXUSRCLK21,
	SetupHigh => tsetup_DFETAP21_RXUSRCLK21_posedge_posedge(0),
	SetupLow => tsetup_DFETAP21_RXUSRCLK21_negedge_posedge(0),
	HoldLow => thold_DFETAP21_RXUSRCLK21_posedge_posedge(0),
	HoldHigh => thold_DFETAP21_RXUSRCLK21_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP211_RXUSRCLK21_posedge,
	TimingData => Tmkr_DFETAP211_RXUSRCLK21_posedge,
	TestSignal => DFETAP21_dly(1),
	TestSignalName => "DFETAP21(1)",
	TestDelay => tisd_DFETAP21_RXUSRCLK21(1),
	RefSignal => RXUSRCLK21_dly,
	RefSignalName => "RXUSRCLK21",
	RefDelay => ticd_RXUSRCLK21,
	SetupHigh => tsetup_DFETAP21_RXUSRCLK21_posedge_posedge(1),
	SetupLow => tsetup_DFETAP21_RXUSRCLK21_negedge_posedge(1),
	HoldLow => thold_DFETAP21_RXUSRCLK21_posedge_posedge(1),
	HoldHigh => thold_DFETAP21_RXUSRCLK21_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP212_RXUSRCLK21_posedge,
	TimingData => Tmkr_DFETAP212_RXUSRCLK21_posedge,
	TestSignal => DFETAP21_dly(2),
	TestSignalName => "DFETAP21(2)",
	TestDelay => tisd_DFETAP21_RXUSRCLK21(2),
	RefSignal => RXUSRCLK21_dly,
	RefSignalName => "RXUSRCLK21",
	RefDelay => ticd_RXUSRCLK21,
	SetupHigh => tsetup_DFETAP21_RXUSRCLK21_posedge_posedge(2),
	SetupLow => tsetup_DFETAP21_RXUSRCLK21_negedge_posedge(2),
	HoldLow => thold_DFETAP21_RXUSRCLK21_posedge_posedge(2),
	HoldHigh => thold_DFETAP21_RXUSRCLK21_negedge_posedge(2),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP213_RXUSRCLK21_posedge,
	TimingData => Tmkr_DFETAP213_RXUSRCLK21_posedge,
	TestSignal => DFETAP21_dly(3),
	TestSignalName => "DFETAP21(3)",
	TestDelay => tisd_DFETAP21_RXUSRCLK21(3),
	RefSignal => RXUSRCLK21_dly,
	RefSignalName => "RXUSRCLK21",
	RefDelay => ticd_RXUSRCLK21,
	SetupHigh => tsetup_DFETAP21_RXUSRCLK21_posedge_posedge(3),
	SetupLow => tsetup_DFETAP21_RXUSRCLK21_negedge_posedge(3),
	HoldLow => thold_DFETAP21_RXUSRCLK21_posedge_posedge(3),
	HoldHigh => thold_DFETAP21_RXUSRCLK21_negedge_posedge(3),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP214_RXUSRCLK21_posedge,
	TimingData => Tmkr_DFETAP214_RXUSRCLK21_posedge,
	TestSignal => DFETAP21_dly(4),
	TestSignalName => "DFETAP21(4)",
	TestDelay => tisd_DFETAP21_RXUSRCLK21(4),
	RefSignal => RXUSRCLK21_dly,
	RefSignalName => "RXUSRCLK21",
	RefDelay => ticd_RXUSRCLK21,
	SetupHigh => tsetup_DFETAP21_RXUSRCLK21_posedge_posedge(4),
	SetupLow => tsetup_DFETAP21_RXUSRCLK21_negedge_posedge(4),
	HoldLow => thold_DFETAP21_RXUSRCLK21_posedge_posedge(4),
	HoldHigh => thold_DFETAP21_RXUSRCLK21_negedge_posedge(4),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP310_RXUSRCLK21_posedge,
	TimingData => Tmkr_DFETAP310_RXUSRCLK21_posedge,
	TestSignal => DFETAP31_dly(0),
	TestSignalName => "DFETAP31(0)",
	TestDelay => tisd_DFETAP31_RXUSRCLK21(0),
	RefSignal => RXUSRCLK21_dly,
	RefSignalName => "RXUSRCLK21",
	RefDelay => ticd_RXUSRCLK21,
	SetupHigh => tsetup_DFETAP31_RXUSRCLK21_posedge_posedge(0),
	SetupLow => tsetup_DFETAP31_RXUSRCLK21_negedge_posedge(0),
	HoldLow => thold_DFETAP31_RXUSRCLK21_posedge_posedge(0),
	HoldHigh => thold_DFETAP31_RXUSRCLK21_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP311_RXUSRCLK21_posedge,
	TimingData => Tmkr_DFETAP311_RXUSRCLK21_posedge,
	TestSignal => DFETAP31_dly(1),
	TestSignalName => "DFETAP31(1)",
	TestDelay => tisd_DFETAP31_RXUSRCLK21(1),
	RefSignal => RXUSRCLK21_dly,
	RefSignalName => "RXUSRCLK21",
	RefDelay => ticd_RXUSRCLK21,
	SetupHigh => tsetup_DFETAP31_RXUSRCLK21_posedge_posedge(1),
	SetupLow => tsetup_DFETAP31_RXUSRCLK21_negedge_posedge(1),
	HoldLow => thold_DFETAP31_RXUSRCLK21_posedge_posedge(1),
	HoldHigh => thold_DFETAP31_RXUSRCLK21_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP312_RXUSRCLK21_posedge,
	TimingData => Tmkr_DFETAP312_RXUSRCLK21_posedge,
	TestSignal => DFETAP31_dly(2),
	TestSignalName => "DFETAP31(2)",
	TestDelay => tisd_DFETAP31_RXUSRCLK21(2),
	RefSignal => RXUSRCLK21_dly,
	RefSignalName => "RXUSRCLK21",
	RefDelay => ticd_RXUSRCLK21,
	SetupHigh => tsetup_DFETAP31_RXUSRCLK21_posedge_posedge(2),
	SetupLow => tsetup_DFETAP31_RXUSRCLK21_negedge_posedge(2),
	HoldLow => thold_DFETAP31_RXUSRCLK21_posedge_posedge(2),
	HoldHigh => thold_DFETAP31_RXUSRCLK21_negedge_posedge(2),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP313_RXUSRCLK21_posedge,
	TimingData => Tmkr_DFETAP313_RXUSRCLK21_posedge,
	TestSignal => DFETAP31_dly(3),
	TestSignalName => "DFETAP31(3)",
	TestDelay => tisd_DFETAP31_RXUSRCLK21(3),
	RefSignal => RXUSRCLK21_dly,
	RefSignalName => "RXUSRCLK21",
	RefDelay => ticd_RXUSRCLK21,
	SetupHigh => tsetup_DFETAP31_RXUSRCLK21_posedge_posedge(3),
	SetupLow => tsetup_DFETAP31_RXUSRCLK21_negedge_posedge(3),
	HoldLow => thold_DFETAP31_RXUSRCLK21_posedge_posedge(3),
	HoldHigh => thold_DFETAP31_RXUSRCLK21_negedge_posedge(3),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP410_RXUSRCLK21_posedge,
	TimingData => Tmkr_DFETAP410_RXUSRCLK21_posedge,
	TestSignal => DFETAP41_dly(0),
	TestSignalName => "DFETAP41(0)",
	TestDelay => tisd_DFETAP41_RXUSRCLK21(0),
	RefSignal => RXUSRCLK21_dly,
	RefSignalName => "RXUSRCLK21",
	RefDelay => ticd_RXUSRCLK21,
	SetupHigh => tsetup_DFETAP41_RXUSRCLK21_posedge_posedge(0),
	SetupLow => tsetup_DFETAP41_RXUSRCLK21_negedge_posedge(0),
	HoldLow => thold_DFETAP41_RXUSRCLK21_posedge_posedge(0),
	HoldHigh => thold_DFETAP41_RXUSRCLK21_negedge_posedge(0),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP411_RXUSRCLK21_posedge,
	TimingData => Tmkr_DFETAP411_RXUSRCLK21_posedge,
	TestSignal => DFETAP41_dly(1),
	TestSignalName => "DFETAP41(1)",
	TestDelay => tisd_DFETAP41_RXUSRCLK21(1),
	RefSignal => RXUSRCLK21_dly,
	RefSignalName => "RXUSRCLK21",
	RefDelay => ticd_RXUSRCLK21,
	SetupHigh => tsetup_DFETAP41_RXUSRCLK21_posedge_posedge(1),
	SetupLow => tsetup_DFETAP41_RXUSRCLK21_negedge_posedge(1),
	HoldLow => thold_DFETAP41_RXUSRCLK21_posedge_posedge(1),
	HoldHigh => thold_DFETAP41_RXUSRCLK21_negedge_posedge(1),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP412_RXUSRCLK21_posedge,
	TimingData => Tmkr_DFETAP412_RXUSRCLK21_posedge,
	TestSignal => DFETAP41_dly(2),
	TestSignalName => "DFETAP41(2)",
	TestDelay => tisd_DFETAP41_RXUSRCLK21(2),
	RefSignal => RXUSRCLK21_dly,
	RefSignalName => "RXUSRCLK21",
	RefDelay => ticd_RXUSRCLK21,
	SetupHigh => tsetup_DFETAP41_RXUSRCLK21_posedge_posedge(2),
	SetupLow => tsetup_DFETAP41_RXUSRCLK21_negedge_posedge(2),
	HoldLow => thold_DFETAP41_RXUSRCLK21_posedge_posedge(2),
	HoldHigh => thold_DFETAP41_RXUSRCLK21_negedge_posedge(2),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
	VitalSetupHoldCheck
	(
	Violation => Tviol_DFETAP413_RXUSRCLK21_posedge,
	TimingData => Tmkr_DFETAP413_RXUSRCLK21_posedge,
	TestSignal => DFETAP41_dly(3),
	TestSignalName => "DFETAP41(3)",
	TestDelay => tisd_DFETAP41_RXUSRCLK21(3),
	RefSignal => RXUSRCLK21_dly,
	RefSignalName => "RXUSRCLK21",
	RefDelay => ticd_RXUSRCLK21,
	SetupHigh => tsetup_DFETAP41_RXUSRCLK21_posedge_posedge(3),
	SetupLow => tsetup_DFETAP41_RXUSRCLK21_negedge_posedge(3),
	HoldLow => thold_DFETAP41_RXUSRCLK21_posedge_posedge(3),
	HoldHigh => thold_DFETAP41_RXUSRCLK21_negedge_posedge(3),
	CheckEnabled   => TRUE,
	RefTransition  => 'R',
	HeaderMsg      => InstancePath & "/X_GTX_DUAL",
	Xon            => Xon,
	MsgOn          => MsgOn,
	MsgSeverity    => WARNING
	);
     end if;
	VitalPathDelay01
	(
	OutSignal     => REFCLKOUT,
	GlitchData    => REFCLKOUT_GlitchData,
	OutSignalName => "REFCLKOUT",
	OutTemp       => REFCLKOUT_OUT,
	Paths         => (0 => (CLKIN_dly'last_event, tpd_CLKIN_REFCLKOUT,TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(0),
	GlitchData    => RXDATA00_GlitchData,
	OutSignalName => "RXDATA0(0)",
	OutTemp       => RXDATA0_OUT(0),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(1),
	GlitchData    => RXDATA01_GlitchData,
	OutSignalName => "RXDATA0(1)",
	OutTemp       => RXDATA0_OUT(1),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(2),
	GlitchData    => RXDATA02_GlitchData,
	OutSignalName => "RXDATA0(2)",
	OutTemp       => RXDATA0_OUT(2),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(3),
	GlitchData    => RXDATA03_GlitchData,
	OutSignalName => "RXDATA0(3)",
	OutTemp       => RXDATA0_OUT(3),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(3),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(4),
	GlitchData    => RXDATA04_GlitchData,
	OutSignalName => "RXDATA0(4)",
	OutTemp       => RXDATA0_OUT(4),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(4),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(5),
	GlitchData    => RXDATA05_GlitchData,
	OutSignalName => "RXDATA0(5)",
	OutTemp       => RXDATA0_OUT(5),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(5),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(6),
	GlitchData    => RXDATA06_GlitchData,
	OutSignalName => "RXDATA0(6)",
	OutTemp       => RXDATA0_OUT(6),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(6),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(7),
	GlitchData    => RXDATA07_GlitchData,
	OutSignalName => "RXDATA0(7)",
	OutTemp       => RXDATA0_OUT(7),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(7),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(8),
	GlitchData    => RXDATA08_GlitchData,
	OutSignalName => "RXDATA0(8)",
	OutTemp       => RXDATA0_OUT(8),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(8),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(9),
	GlitchData    => RXDATA09_GlitchData,
	OutSignalName => "RXDATA0(9)",
	OutTemp       => RXDATA0_OUT(9),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(9),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(10),
	GlitchData    => RXDATA010_GlitchData,
	OutSignalName => "RXDATA0(10)",
	OutTemp       => RXDATA0_OUT(10),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(10),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(11),
	GlitchData    => RXDATA011_GlitchData,
	OutSignalName => "RXDATA0(11)",
	OutTemp       => RXDATA0_OUT(11),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(11),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(12),
	GlitchData    => RXDATA012_GlitchData,
	OutSignalName => "RXDATA0(12)",
	OutTemp       => RXDATA0_OUT(12),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(12),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(13),
	GlitchData    => RXDATA013_GlitchData,
	OutSignalName => "RXDATA0(13)",
	OutTemp       => RXDATA0_OUT(13),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(13),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(14),
	GlitchData    => RXDATA014_GlitchData,
	OutSignalName => "RXDATA0(14)",
	OutTemp       => RXDATA0_OUT(14),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(14),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(15),
	GlitchData    => RXDATA015_GlitchData,
	OutSignalName => "RXDATA0(15)",
	OutTemp       => RXDATA0_OUT(15),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(15),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(16),
	GlitchData    => RXDATA016_GlitchData,
	OutSignalName => "RXDATA0(16)",
	OutTemp       => RXDATA0_OUT(16),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(16),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(17),
	GlitchData    => RXDATA017_GlitchData,
	OutSignalName => "RXDATA0(17)",
	OutTemp       => RXDATA0_OUT(17),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(17),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(18),
	GlitchData    => RXDATA018_GlitchData,
	OutSignalName => "RXDATA0(18)",
	OutTemp       => RXDATA0_OUT(18),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(18),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(19),
	GlitchData    => RXDATA019_GlitchData,
	OutSignalName => "RXDATA0(19)",
	OutTemp       => RXDATA0_OUT(19),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(19),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(20),
	GlitchData    => RXDATA020_GlitchData,
	OutSignalName => "RXDATA0(20)",
	OutTemp       => RXDATA0_OUT(20),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(20),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(21),
	GlitchData    => RXDATA021_GlitchData,
	OutSignalName => "RXDATA0(21)",
	OutTemp       => RXDATA0_OUT(21),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(21),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(22),
	GlitchData    => RXDATA022_GlitchData,
	OutSignalName => "RXDATA0(22)",
	OutTemp       => RXDATA0_OUT(22),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(22),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(23),
	GlitchData    => RXDATA023_GlitchData,
	OutSignalName => "RXDATA0(23)",
	OutTemp       => RXDATA0_OUT(23),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(23),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(24),
	GlitchData    => RXDATA024_GlitchData,
	OutSignalName => "RXDATA0(24)",
	OutTemp       => RXDATA0_OUT(24),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(24),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(25),
	GlitchData    => RXDATA025_GlitchData,
	OutSignalName => "RXDATA0(25)",
	OutTemp       => RXDATA0_OUT(25),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(25),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(26),
	GlitchData    => RXDATA026_GlitchData,
	OutSignalName => "RXDATA0(26)",
	OutTemp       => RXDATA0_OUT(26),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(26),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(27),
	GlitchData    => RXDATA027_GlitchData,
	OutSignalName => "RXDATA0(27)",
	OutTemp       => RXDATA0_OUT(27),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(27),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(28),
	GlitchData    => RXDATA028_GlitchData,
	OutSignalName => "RXDATA0(28)",
	OutTemp       => RXDATA0_OUT(28),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(28),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(29),
	GlitchData    => RXDATA029_GlitchData,
	OutSignalName => "RXDATA0(29)",
	OutTemp       => RXDATA0_OUT(29),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(29),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(30),
	GlitchData    => RXDATA030_GlitchData,
	OutSignalName => "RXDATA0(30)",
	OutTemp       => RXDATA0_OUT(30),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(30),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA0(31),
	GlitchData    => RXDATA031_GlitchData,
	OutSignalName => "RXDATA0(31)",
	OutTemp       => RXDATA0_OUT(31),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(31),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXNOTINTABLE0(0),
	GlitchData    => RXNOTINTABLE00_GlitchData,
	OutSignalName => "RXNOTINTABLE0(0)",
	OutTemp       => RXNOTINTABLE0_OUT(0),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXNOTINTABLE0(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXNOTINTABLE0(1),
	GlitchData    => RXNOTINTABLE01_GlitchData,
	OutSignalName => "RXNOTINTABLE0(1)",
	OutTemp       => RXNOTINTABLE0_OUT(1),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXNOTINTABLE0(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXNOTINTABLE0(2),
	GlitchData    => RXNOTINTABLE02_GlitchData,
	OutSignalName => "RXNOTINTABLE0(2)",
	OutTemp       => RXNOTINTABLE0_OUT(2),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXNOTINTABLE0(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXNOTINTABLE0(3),
	GlitchData    => RXNOTINTABLE03_GlitchData,
	OutSignalName => "RXNOTINTABLE0(3)",
	OutTemp       => RXNOTINTABLE0_OUT(3),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXNOTINTABLE0(3),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDISPERR0(0),
	GlitchData    => RXDISPERR00_GlitchData,
	OutSignalName => "RXDISPERR0(0)",
	OutTemp       => RXDISPERR0_OUT(0),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDISPERR0(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDISPERR0(1),
	GlitchData    => RXDISPERR01_GlitchData,
	OutSignalName => "RXDISPERR0(1)",
	OutTemp       => RXDISPERR0_OUT(1),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDISPERR0(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDISPERR0(2),
	GlitchData    => RXDISPERR02_GlitchData,
	OutSignalName => "RXDISPERR0(2)",
	OutTemp       => RXDISPERR0_OUT(2),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDISPERR0(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDISPERR0(3),
	GlitchData    => RXDISPERR03_GlitchData,
	OutSignalName => "RXDISPERR0(3)",
	OutTemp       => RXDISPERR0_OUT(3),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDISPERR0(3),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCHARISK0(0),
	GlitchData    => RXCHARISK00_GlitchData,
	OutSignalName => "RXCHARISK0(0)",
	OutTemp       => RXCHARISK0_OUT(0),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXCHARISK0(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCHARISK0(1),
	GlitchData    => RXCHARISK01_GlitchData,
	OutSignalName => "RXCHARISK0(1)",
	OutTemp       => RXCHARISK0_OUT(1),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXCHARISK0(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCHARISK0(2),
	GlitchData    => RXCHARISK02_GlitchData,
	OutSignalName => "RXCHARISK0(2)",
	OutTemp       => RXCHARISK0_OUT(2),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXCHARISK0(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCHARISK0(3),
	GlitchData    => RXCHARISK03_GlitchData,
	OutSignalName => "RXCHARISK0(3)",
	OutTemp       => RXCHARISK0_OUT(3),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXCHARISK0(3),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXRUNDISP0(0),
	GlitchData    => RXRUNDISP00_GlitchData,
	OutSignalName => "RXRUNDISP0(0)",
	OutTemp       => RXRUNDISP0_OUT(0),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXRUNDISP0(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXRUNDISP0(1),
	GlitchData    => RXRUNDISP01_GlitchData,
	OutSignalName => "RXRUNDISP0(1)",
	OutTemp       => RXRUNDISP0_OUT(1),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXRUNDISP0(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXRUNDISP0(2),
	GlitchData    => RXRUNDISP02_GlitchData,
	OutSignalName => "RXRUNDISP0(2)",
	OutTemp       => RXRUNDISP0_OUT(2),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXRUNDISP0(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXRUNDISP0(3),
	GlitchData    => RXRUNDISP03_GlitchData,
	OutSignalName => "RXRUNDISP0(3)",
	OutTemp       => RXRUNDISP0_OUT(3),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXRUNDISP0(3),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCHARISCOMMA0(0),
	GlitchData    => RXCHARISCOMMA00_GlitchData,
	OutSignalName => "RXCHARISCOMMA0(0)",
	OutTemp       => RXCHARISCOMMA0_OUT(0),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXCHARISCOMMA0(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCHARISCOMMA0(1),
	GlitchData    => RXCHARISCOMMA01_GlitchData,
	OutSignalName => "RXCHARISCOMMA0(1)",
	OutTemp       => RXCHARISCOMMA0_OUT(1),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXCHARISCOMMA0(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCHARISCOMMA0(2),
	GlitchData    => RXCHARISCOMMA02_GlitchData,
	OutSignalName => "RXCHARISCOMMA0(2)",
	OutTemp       => RXCHARISCOMMA0_OUT(2),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXCHARISCOMMA0(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCHARISCOMMA0(3),
	GlitchData    => RXCHARISCOMMA03_GlitchData,
	OutSignalName => "RXCHARISCOMMA0(3)",
	OutTemp       => RXCHARISCOMMA0_OUT(3),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXCHARISCOMMA0(3),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXVALID0,
	GlitchData    => RXVALID0_GlitchData,
	OutSignalName => "RXVALID0",
	OutTemp       => RXVALID0_OUT,
	Paths         => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXVALID0,TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(0),
	GlitchData    => RXDATA10_GlitchData,
	OutSignalName => "RXDATA1(0)",
	OutTemp       => RXDATA1_OUT(0),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(1),
	GlitchData    => RXDATA11_GlitchData,
	OutSignalName => "RXDATA1(1)",
	OutTemp       => RXDATA1_OUT(1),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(2),
	GlitchData    => RXDATA12_GlitchData,
	OutSignalName => "RXDATA1(2)",
	OutTemp       => RXDATA1_OUT(2),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(3),
	GlitchData    => RXDATA13_GlitchData,
	OutSignalName => "RXDATA1(3)",
	OutTemp       => RXDATA1_OUT(3),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(3),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(4),
	GlitchData    => RXDATA14_GlitchData,
	OutSignalName => "RXDATA1(4)",
	OutTemp       => RXDATA1_OUT(4),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(4),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(5),
	GlitchData    => RXDATA15_GlitchData,
	OutSignalName => "RXDATA1(5)",
	OutTemp       => RXDATA1_OUT(5),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(5),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(6),
	GlitchData    => RXDATA16_GlitchData,
	OutSignalName => "RXDATA1(6)",
	OutTemp       => RXDATA1_OUT(6),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(6),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(7),
	GlitchData    => RXDATA17_GlitchData,
	OutSignalName => "RXDATA1(7)",
	OutTemp       => RXDATA1_OUT(7),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(7),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(8),
	GlitchData    => RXDATA18_GlitchData,
	OutSignalName => "RXDATA1(8)",
	OutTemp       => RXDATA1_OUT(8),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(8),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(9),
	GlitchData    => RXDATA19_GlitchData,
	OutSignalName => "RXDATA1(9)",
	OutTemp       => RXDATA1_OUT(9),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(9),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(10),
	GlitchData    => RXDATA110_GlitchData,
	OutSignalName => "RXDATA1(10)",
	OutTemp       => RXDATA1_OUT(10),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(10),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(11),
	GlitchData    => RXDATA111_GlitchData,
	OutSignalName => "RXDATA1(11)",
	OutTemp       => RXDATA1_OUT(11),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(11),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(12),
	GlitchData    => RXDATA112_GlitchData,
	OutSignalName => "RXDATA1(12)",
	OutTemp       => RXDATA1_OUT(12),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(12),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(13),
	GlitchData    => RXDATA113_GlitchData,
	OutSignalName => "RXDATA1(13)",
	OutTemp       => RXDATA1_OUT(13),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(13),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(14),
	GlitchData    => RXDATA114_GlitchData,
	OutSignalName => "RXDATA1(14)",
	OutTemp       => RXDATA1_OUT(14),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(14),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(15),
	GlitchData    => RXDATA115_GlitchData,
	OutSignalName => "RXDATA1(15)",
	OutTemp       => RXDATA1_OUT(15),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(15),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(16),
	GlitchData    => RXDATA116_GlitchData,
	OutSignalName => "RXDATA1(16)",
	OutTemp       => RXDATA1_OUT(16),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(16),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(17),
	GlitchData    => RXDATA117_GlitchData,
	OutSignalName => "RXDATA1(17)",
	OutTemp       => RXDATA1_OUT(17),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(17),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(18),
	GlitchData    => RXDATA118_GlitchData,
	OutSignalName => "RXDATA1(18)",
	OutTemp       => RXDATA1_OUT(18),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(18),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(19),
	GlitchData    => RXDATA119_GlitchData,
	OutSignalName => "RXDATA1(19)",
	OutTemp       => RXDATA1_OUT(19),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(19),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(20),
	GlitchData    => RXDATA120_GlitchData,
	OutSignalName => "RXDATA1(20)",
	OutTemp       => RXDATA1_OUT(20),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(20),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(21),
	GlitchData    => RXDATA121_GlitchData,
	OutSignalName => "RXDATA1(21)",
	OutTemp       => RXDATA1_OUT(21),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(21),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(22),
	GlitchData    => RXDATA122_GlitchData,
	OutSignalName => "RXDATA1(22)",
	OutTemp       => RXDATA1_OUT(22),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(22),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(23),
	GlitchData    => RXDATA123_GlitchData,
	OutSignalName => "RXDATA1(23)",
	OutTemp       => RXDATA1_OUT(23),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(23),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(24),
	GlitchData    => RXDATA124_GlitchData,
	OutSignalName => "RXDATA1(24)",
	OutTemp       => RXDATA1_OUT(24),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(24),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(25),
	GlitchData    => RXDATA125_GlitchData,
	OutSignalName => "RXDATA1(25)",
	OutTemp       => RXDATA1_OUT(25),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(25),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(26),
	GlitchData    => RXDATA126_GlitchData,
	OutSignalName => "RXDATA1(26)",
	OutTemp       => RXDATA1_OUT(26),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(26),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(27),
	GlitchData    => RXDATA127_GlitchData,
	OutSignalName => "RXDATA1(27)",
	OutTemp       => RXDATA1_OUT(27),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(27),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(28),
	GlitchData    => RXDATA128_GlitchData,
	OutSignalName => "RXDATA1(28)",
	OutTemp       => RXDATA1_OUT(28),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(28),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(29),
	GlitchData    => RXDATA129_GlitchData,
	OutSignalName => "RXDATA1(29)",
	OutTemp       => RXDATA1_OUT(29),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(29),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(30),
	GlitchData    => RXDATA130_GlitchData,
	OutSignalName => "RXDATA1(30)",
	OutTemp       => RXDATA1_OUT(30),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(30),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATA1(31),
	GlitchData    => RXDATA131_GlitchData,
	OutSignalName => "RXDATA1(31)",
	OutTemp       => RXDATA1_OUT(31),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(31),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXNOTINTABLE1(0),
	GlitchData    => RXNOTINTABLE10_GlitchData,
	OutSignalName => "RXNOTINTABLE1(0)",
	OutTemp       => RXNOTINTABLE1_OUT(0),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXNOTINTABLE1(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXNOTINTABLE1(1),
	GlitchData    => RXNOTINTABLE11_GlitchData,
	OutSignalName => "RXNOTINTABLE1(1)",
	OutTemp       => RXNOTINTABLE1_OUT(1),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXNOTINTABLE1(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXNOTINTABLE1(2),
	GlitchData    => RXNOTINTABLE12_GlitchData,
	OutSignalName => "RXNOTINTABLE1(2)",
	OutTemp       => RXNOTINTABLE1_OUT(2),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXNOTINTABLE1(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXNOTINTABLE1(3),
	GlitchData    => RXNOTINTABLE13_GlitchData,
	OutSignalName => "RXNOTINTABLE1(3)",
	OutTemp       => RXNOTINTABLE1_OUT(3),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXNOTINTABLE1(3),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDISPERR1(0),
	GlitchData    => RXDISPERR10_GlitchData,
	OutSignalName => "RXDISPERR1(0)",
	OutTemp       => RXDISPERR1_OUT(0),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDISPERR1(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDISPERR1(1),
	GlitchData    => RXDISPERR11_GlitchData,
	OutSignalName => "RXDISPERR1(1)",
	OutTemp       => RXDISPERR1_OUT(1),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDISPERR1(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDISPERR1(2),
	GlitchData    => RXDISPERR12_GlitchData,
	OutSignalName => "RXDISPERR1(2)",
	OutTemp       => RXDISPERR1_OUT(2),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDISPERR1(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDISPERR1(3),
	GlitchData    => RXDISPERR13_GlitchData,
	OutSignalName => "RXDISPERR1(3)",
	OutTemp       => RXDISPERR1_OUT(3),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDISPERR1(3),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCHARISK1(0),
	GlitchData    => RXCHARISK10_GlitchData,
	OutSignalName => "RXCHARISK1(0)",
	OutTemp       => RXCHARISK1_OUT(0),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXCHARISK1(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCHARISK1(1),
	GlitchData    => RXCHARISK11_GlitchData,
	OutSignalName => "RXCHARISK1(1)",
	OutTemp       => RXCHARISK1_OUT(1),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXCHARISK1(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCHARISK1(2),
	GlitchData    => RXCHARISK12_GlitchData,
	OutSignalName => "RXCHARISK1(2)",
	OutTemp       => RXCHARISK1_OUT(2),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXCHARISK1(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCHARISK1(3),
	GlitchData    => RXCHARISK13_GlitchData,
	OutSignalName => "RXCHARISK1(3)",
	OutTemp       => RXCHARISK1_OUT(3),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXCHARISK1(3),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXRUNDISP1(0),
	GlitchData    => RXRUNDISP10_GlitchData,
	OutSignalName => "RXRUNDISP1(0)",
	OutTemp       => RXRUNDISP1_OUT(0),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXRUNDISP1(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXRUNDISP1(1),
	GlitchData    => RXRUNDISP11_GlitchData,
	OutSignalName => "RXRUNDISP1(1)",
	OutTemp       => RXRUNDISP1_OUT(1),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXRUNDISP1(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXRUNDISP1(2),
	GlitchData    => RXRUNDISP12_GlitchData,
	OutSignalName => "RXRUNDISP1(2)",
	OutTemp       => RXRUNDISP1_OUT(2),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXRUNDISP1(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXRUNDISP1(3),
	GlitchData    => RXRUNDISP13_GlitchData,
	OutSignalName => "RXRUNDISP1(3)",
	OutTemp       => RXRUNDISP1_OUT(3),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXRUNDISP1(3),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCHARISCOMMA1(0),
	GlitchData    => RXCHARISCOMMA10_GlitchData,
	OutSignalName => "RXCHARISCOMMA1(0)",
	OutTemp       => RXCHARISCOMMA1_OUT(0),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXCHARISCOMMA1(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCHARISCOMMA1(1),
	GlitchData    => RXCHARISCOMMA11_GlitchData,
	OutSignalName => "RXCHARISCOMMA1(1)",
	OutTemp       => RXCHARISCOMMA1_OUT(1),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXCHARISCOMMA1(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCHARISCOMMA1(2),
	GlitchData    => RXCHARISCOMMA12_GlitchData,
	OutSignalName => "RXCHARISCOMMA1(2)",
	OutTemp       => RXCHARISCOMMA1_OUT(2),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXCHARISCOMMA1(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCHARISCOMMA1(3),
	GlitchData    => RXCHARISCOMMA13_GlitchData,
	OutSignalName => "RXCHARISCOMMA1(3)",
	OutTemp       => RXCHARISCOMMA1_OUT(3),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXCHARISCOMMA1(3),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXVALID1,
	GlitchData    => RXVALID1_GlitchData,
	OutSignalName => "RXVALID1",
	OutTemp       => RXVALID1_OUT,
	Paths         => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXVALID1,TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => TXKERR0(0),
	GlitchData    => TXKERR00_GlitchData,
	OutSignalName => "TXKERR0(0)",
	OutTemp       => TXKERR0_OUT(0),
	Paths       => (0 => (TXUSRCLK20_dly'last_event, tpd_TXUSRCLK20_TXKERR0(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => TXKERR0(1),
	GlitchData    => TXKERR01_GlitchData,
	OutSignalName => "TXKERR0(1)",
	OutTemp       => TXKERR0_OUT(1),
	Paths       => (0 => (TXUSRCLK20_dly'last_event, tpd_TXUSRCLK20_TXKERR0(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => TXKERR0(2),
	GlitchData    => TXKERR02_GlitchData,
	OutSignalName => "TXKERR0(2)",
	OutTemp       => TXKERR0_OUT(2),
	Paths       => (0 => (TXUSRCLK20_dly'last_event, tpd_TXUSRCLK20_TXKERR0(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => TXKERR0(3),
	GlitchData    => TXKERR03_GlitchData,
	OutSignalName => "TXKERR0(3)",
	OutTemp       => TXKERR0_OUT(3),
	Paths       => (0 => (TXUSRCLK20_dly'last_event, tpd_TXUSRCLK20_TXKERR0(3),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => TXRUNDISP0(0),
	GlitchData    => TXRUNDISP00_GlitchData,
	OutSignalName => "TXRUNDISP0(0)",
	OutTemp       => TXRUNDISP0_OUT(0),
	Paths       => (0 => (TXUSRCLK20_dly'last_event, tpd_TXUSRCLK20_TXRUNDISP0(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => TXRUNDISP0(1),
	GlitchData    => TXRUNDISP01_GlitchData,
	OutSignalName => "TXRUNDISP0(1)",
	OutTemp       => TXRUNDISP0_OUT(1),
	Paths       => (0 => (TXUSRCLK20_dly'last_event, tpd_TXUSRCLK20_TXRUNDISP0(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => TXRUNDISP0(2),
	GlitchData    => TXRUNDISP02_GlitchData,
	OutSignalName => "TXRUNDISP0(2)",
	OutTemp       => TXRUNDISP0_OUT(2),
	Paths       => (0 => (TXUSRCLK20_dly'last_event, tpd_TXUSRCLK20_TXRUNDISP0(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => TXRUNDISP0(3),
	GlitchData    => TXRUNDISP03_GlitchData,
	OutSignalName => "TXRUNDISP0(3)",
	OutTemp       => TXRUNDISP0_OUT(3),
	Paths       => (0 => (TXUSRCLK20_dly'last_event, tpd_TXUSRCLK20_TXRUNDISP0(3),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => TXBUFSTATUS0(0),
	GlitchData    => TXBUFSTATUS00_GlitchData,
	OutSignalName => "TXBUFSTATUS0(0)",
	OutTemp       => TXBUFSTATUS0_OUT(0),
	Paths       => (0 => (TXUSRCLK20_dly'last_event, tpd_TXUSRCLK20_TXBUFSTATUS0(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => TXBUFSTATUS0(1),
	GlitchData    => TXBUFSTATUS01_GlitchData,
	OutSignalName => "TXBUFSTATUS0(1)",
	OutTemp       => TXBUFSTATUS0_OUT(1),
	Paths       => (0 => (TXUSRCLK20_dly'last_event, tpd_TXUSRCLK20_TXBUFSTATUS0(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => TXKERR1(0),
	GlitchData    => TXKERR10_GlitchData,
	OutSignalName => "TXKERR1(0)",
	OutTemp       => TXKERR1_OUT(0),
	Paths       => (0 => (TXUSRCLK21_dly'last_event, tpd_TXUSRCLK21_TXKERR1(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => TXKERR1(1),
	GlitchData    => TXKERR11_GlitchData,
	OutSignalName => "TXKERR1(1)",
	OutTemp       => TXKERR1_OUT(1),
	Paths       => (0 => (TXUSRCLK21_dly'last_event, tpd_TXUSRCLK21_TXKERR1(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => TXKERR1(2),
	GlitchData    => TXKERR12_GlitchData,
	OutSignalName => "TXKERR1(2)",
	OutTemp       => TXKERR1_OUT(2),
	Paths       => (0 => (TXUSRCLK21_dly'last_event, tpd_TXUSRCLK21_TXKERR1(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => TXKERR1(3),
	GlitchData    => TXKERR13_GlitchData,
	OutSignalName => "TXKERR1(3)",
	OutTemp       => TXKERR1_OUT(3),
	Paths       => (0 => (TXUSRCLK21_dly'last_event, tpd_TXUSRCLK21_TXKERR1(3),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => TXRUNDISP1(0),
	GlitchData    => TXRUNDISP10_GlitchData,
	OutSignalName => "TXRUNDISP1(0)",
	OutTemp       => TXRUNDISP1_OUT(0),
	Paths       => (0 => (TXUSRCLK21_dly'last_event, tpd_TXUSRCLK21_TXRUNDISP1(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => TXRUNDISP1(1),
	GlitchData    => TXRUNDISP11_GlitchData,
	OutSignalName => "TXRUNDISP1(1)",
	OutTemp       => TXRUNDISP1_OUT(1),
	Paths       => (0 => (TXUSRCLK21_dly'last_event, tpd_TXUSRCLK21_TXRUNDISP1(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => TXRUNDISP1(2),
	GlitchData    => TXRUNDISP12_GlitchData,
	OutSignalName => "TXRUNDISP1(2)",
	OutTemp       => TXRUNDISP1_OUT(2),
	Paths       => (0 => (TXUSRCLK21_dly'last_event, tpd_TXUSRCLK21_TXRUNDISP1(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => TXRUNDISP1(3),
	GlitchData    => TXRUNDISP13_GlitchData,
	OutSignalName => "TXRUNDISP1(3)",
	OutTemp       => TXRUNDISP1_OUT(3),
	Paths       => (0 => (TXUSRCLK21_dly'last_event, tpd_TXUSRCLK21_TXRUNDISP1(3),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => TXBUFSTATUS1(0),
	GlitchData    => TXBUFSTATUS10_GlitchData,
	OutSignalName => "TXBUFSTATUS1(0)",
	OutTemp       => TXBUFSTATUS1_OUT(0),
	Paths       => (0 => (TXUSRCLK21_dly'last_event, tpd_TXUSRCLK21_TXBUFSTATUS1(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => TXBUFSTATUS1(1),
	GlitchData    => TXBUFSTATUS11_GlitchData,
	OutSignalName => "TXBUFSTATUS1(1)",
	OutTemp       => TXBUFSTATUS1_OUT(1),
	Paths       => (0 => (TXUSRCLK21_dly'last_event, tpd_TXUSRCLK21_TXBUFSTATUS1(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCOMMADET0,
	GlitchData    => RXCOMMADET0_GlitchData,
	OutSignalName => "RXCOMMADET0",
	OutTemp       => RXCOMMADET0_OUT,
	Paths         => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXCOMMADET0,TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXBYTEREALIGN0,
	GlitchData    => RXBYTEREALIGN0_GlitchData,
	OutSignalName => "RXBYTEREALIGN0",
	OutTemp       => RXBYTEREALIGN0_OUT,
	Paths         => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXBYTEREALIGN0,TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXBYTEISALIGNED0,
	GlitchData    => RXBYTEISALIGNED0_GlitchData,
	OutSignalName => "RXBYTEISALIGNED0",
	OutTemp       => RXBYTEISALIGNED0_OUT,
	Paths         => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXBYTEISALIGNED0,TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXLOSSOFSYNC0(0),
	GlitchData    => RXLOSSOFSYNC00_GlitchData,
	OutSignalName => "RXLOSSOFSYNC0(0)",
	OutTemp       => RXLOSSOFSYNC0_OUT(0),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXLOSSOFSYNC0(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXLOSSOFSYNC0(1),
	GlitchData    => RXLOSSOFSYNC01_GlitchData,
	OutSignalName => "RXLOSSOFSYNC0(1)",
	OutTemp       => RXLOSSOFSYNC0_OUT(1),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXLOSSOFSYNC0(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCHBONDO0(0),
	GlitchData    => RXCHBONDO00_GlitchData,
	OutSignalName => "RXCHBONDO0(0)",
	OutTemp       => RXCHBONDO0_OUT(0),
	Paths       => (0 => (RXUSRCLK0_dly'last_event, tpd_RXUSRCLK0_RXCHBONDO0(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCHBONDO0(1),
	GlitchData    => RXCHBONDO01_GlitchData,
	OutSignalName => "RXCHBONDO0(1)",
	OutTemp       => RXCHBONDO0_OUT(1),
	Paths       => (0 => (RXUSRCLK0_dly'last_event, tpd_RXUSRCLK0_RXCHBONDO0(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCHBONDO0(2),
	GlitchData    => RXCHBONDO02_GlitchData,
	OutSignalName => "RXCHBONDO0(2)",
	OutTemp       => RXCHBONDO0_OUT(2),
	Paths       => (0 => (RXUSRCLK0_dly'last_event, tpd_RXUSRCLK0_RXCHBONDO0(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCHBONDO0(3),
	GlitchData    => RXCHBONDO03_GlitchData,
	OutSignalName => "RXCHBONDO0(3)",
	OutTemp       => RXCHBONDO0_OUT(3),
	Paths       => (0 => (RXUSRCLK0_dly'last_event, tpd_RXUSRCLK0_RXCHBONDO0(3),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCHANBONDSEQ0,
	GlitchData    => RXCHANBONDSEQ0_GlitchData,
	OutSignalName => "RXCHANBONDSEQ0",
	OutTemp       => RXCHANBONDSEQ0_OUT,
	Paths         => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXCHANBONDSEQ0,TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCHANREALIGN0,
	GlitchData    => RXCHANREALIGN0_GlitchData,
	OutSignalName => "RXCHANREALIGN0",
	OutTemp       => RXCHANREALIGN0_OUT,
	Paths         => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXCHANREALIGN0,TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCHANISALIGNED0,
	GlitchData    => RXCHANISALIGNED0_GlitchData,
	OutSignalName => "RXCHANISALIGNED0",
	OutTemp       => RXCHANISALIGNED0_OUT,
	Paths         => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXCHANISALIGNED0,TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXBUFSTATUS0(0),
	GlitchData    => RXBUFSTATUS00_GlitchData,
	OutSignalName => "RXBUFSTATUS0(0)",
	OutTemp       => RXBUFSTATUS0_OUT(0),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXBUFSTATUS0(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXBUFSTATUS0(1),
	GlitchData    => RXBUFSTATUS01_GlitchData,
	OutSignalName => "RXBUFSTATUS0(1)",
	OutTemp       => RXBUFSTATUS0_OUT(1),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXBUFSTATUS0(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXBUFSTATUS0(2),
	GlitchData    => RXBUFSTATUS02_GlitchData,
	OutSignalName => "RXBUFSTATUS0(2)",
	OutTemp       => RXBUFSTATUS0_OUT(2),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXBUFSTATUS0(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCOMMADET1,
	GlitchData    => RXCOMMADET1_GlitchData,
	OutSignalName => "RXCOMMADET1",
	OutTemp       => RXCOMMADET1_OUT,
	Paths         => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXCOMMADET1,TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXBYTEREALIGN1,
	GlitchData    => RXBYTEREALIGN1_GlitchData,
	OutSignalName => "RXBYTEREALIGN1",
	OutTemp       => RXBYTEREALIGN1_OUT,
	Paths         => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXBYTEREALIGN1,TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXBYTEISALIGNED1,
	GlitchData    => RXBYTEISALIGNED1_GlitchData,
	OutSignalName => "RXBYTEISALIGNED1",
	OutTemp       => RXBYTEISALIGNED1_OUT,
	Paths         => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXBYTEISALIGNED1,TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXLOSSOFSYNC1(0),
	GlitchData    => RXLOSSOFSYNC10_GlitchData,
	OutSignalName => "RXLOSSOFSYNC1(0)",
	OutTemp       => RXLOSSOFSYNC1_OUT(0),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXLOSSOFSYNC1(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXLOSSOFSYNC1(1),
	GlitchData    => RXLOSSOFSYNC11_GlitchData,
	OutSignalName => "RXLOSSOFSYNC1(1)",
	OutTemp       => RXLOSSOFSYNC1_OUT(1),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXLOSSOFSYNC1(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCHBONDO1(0),
	GlitchData    => RXCHBONDO10_GlitchData,
	OutSignalName => "RXCHBONDO1(0)",
	OutTemp       => RXCHBONDO1_OUT(0),
	Paths       => (0 => (RXUSRCLK1_dly'last_event, tpd_RXUSRCLK1_RXCHBONDO1(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCHBONDO1(1),
	GlitchData    => RXCHBONDO11_GlitchData,
	OutSignalName => "RXCHBONDO1(1)",
	OutTemp       => RXCHBONDO1_OUT(1),
	Paths       => (0 => (RXUSRCLK1_dly'last_event, tpd_RXUSRCLK1_RXCHBONDO1(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCHBONDO1(2),
	GlitchData    => RXCHBONDO12_GlitchData,
	OutSignalName => "RXCHBONDO1(2)",
	OutTemp       => RXCHBONDO1_OUT(2),
	Paths       => (0 => (RXUSRCLK1_dly'last_event, tpd_RXUSRCLK1_RXCHBONDO1(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCHBONDO1(3),
	GlitchData    => RXCHBONDO13_GlitchData,
	OutSignalName => "RXCHBONDO1(3)",
	OutTemp       => RXCHBONDO1_OUT(3),
	Paths       => (0 => (RXUSRCLK1_dly'last_event, tpd_RXUSRCLK1_RXCHBONDO1(3),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCHANBONDSEQ1,
	GlitchData    => RXCHANBONDSEQ1_GlitchData,
	OutSignalName => "RXCHANBONDSEQ1",
	OutTemp       => RXCHANBONDSEQ1_OUT,
	Paths         => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXCHANBONDSEQ1,TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCHANREALIGN1,
	GlitchData    => RXCHANREALIGN1_GlitchData,
	OutSignalName => "RXCHANREALIGN1",
	OutTemp       => RXCHANREALIGN1_OUT,
	Paths         => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXCHANREALIGN1,TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCHANISALIGNED1,
	GlitchData    => RXCHANISALIGNED1_GlitchData,
	OutSignalName => "RXCHANISALIGNED1",
	OutTemp       => RXCHANISALIGNED1_OUT,
	Paths         => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXCHANISALIGNED1,TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXBUFSTATUS1(0),
	GlitchData    => RXBUFSTATUS10_GlitchData,
	OutSignalName => "RXBUFSTATUS1(0)",
	OutTemp       => RXBUFSTATUS1_OUT(0),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXBUFSTATUS1(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXBUFSTATUS1(1),
	GlitchData    => RXBUFSTATUS11_GlitchData,
	OutSignalName => "RXBUFSTATUS1(1)",
	OutTemp       => RXBUFSTATUS1_OUT(1),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXBUFSTATUS1(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXBUFSTATUS1(2),
	GlitchData    => RXBUFSTATUS12_GlitchData,
	OutSignalName => "RXBUFSTATUS1(2)",
	OutTemp       => RXBUFSTATUS1_OUT(2),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXBUFSTATUS1(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
        OutSignal     => PHYSTATUS0,
	GlitchData    => PHYSTATUS0_GlitchData,
	OutSignalName => "PHYSTATUS0",
	OutTemp       => PHYSTATUS0_OUT,
	Paths         => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_PHYSTATUS0,TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => PHYSTATUS1,
	GlitchData    => PHYSTATUS1_GlitchData,
	OutSignalName => "PHYSTATUS1",
	OutTemp       => PHYSTATUS1_OUT,
	Paths         => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_PHYSTATUS1,TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(  
	OutSignal     => RXSTATUS0(0),
	GlitchData    => RXSTATUS00_GlitchData,
	OutSignalName => "RXSTATUS0(0)",
	OutTemp       => RXSTATUS0_OUT(0),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXSTATUS0(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXSTATUS0(1),
	GlitchData    => RXSTATUS01_GlitchData,
	OutSignalName => "RXSTATUS0(1)",
	OutTemp       => RXSTATUS0_OUT(1),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXSTATUS0(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXSTATUS0(2),
	GlitchData    => RXSTATUS02_GlitchData,
	OutSignalName => "RXSTATUS0(2)",
	OutTemp       => RXSTATUS0_OUT(2),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXSTATUS0(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCLKCORCNT0(0),
	GlitchData    => RXCLKCORCNT00_GlitchData,
	OutSignalName => "RXCLKCORCNT0(0)",
	OutTemp       => RXCLKCORCNT0_OUT(0),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXCLKCORCNT0(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCLKCORCNT0(1),
	GlitchData    => RXCLKCORCNT01_GlitchData,
	OutSignalName => "RXCLKCORCNT0(1)",
	OutTemp       => RXCLKCORCNT0_OUT(1),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXCLKCORCNT0(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCLKCORCNT0(2),
	GlitchData    => RXCLKCORCNT02_GlitchData,
	OutSignalName => "RXCLKCORCNT0(2)",
	OutTemp       => RXCLKCORCNT0_OUT(2),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXCLKCORCNT0(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXSTATUS1(0),
	GlitchData    => RXSTATUS10_GlitchData,
	OutSignalName => "RXSTATUS1(0)",
	OutTemp       => RXSTATUS1_OUT(0),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXSTATUS1(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXSTATUS1(1),
	GlitchData    => RXSTATUS11_GlitchData,
	OutSignalName => "RXSTATUS1(1)",
	OutTemp       => RXSTATUS1_OUT(1),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXSTATUS1(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXSTATUS1(2),
	GlitchData    => RXSTATUS12_GlitchData,
	OutSignalName => "RXSTATUS1(2)",
	OutTemp       => RXSTATUS1_OUT(2),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXSTATUS1(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCLKCORCNT1(0),
	GlitchData    => RXCLKCORCNT10_GlitchData,
	OutSignalName => "RXCLKCORCNT1(0)",
	OutTemp       => RXCLKCORCNT1_OUT(0),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXCLKCORCNT1(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCLKCORCNT1(1),
	GlitchData    => RXCLKCORCNT11_GlitchData,
	OutSignalName => "RXCLKCORCNT1(1)",
	OutTemp       => RXCLKCORCNT1_OUT(1),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXCLKCORCNT1(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXCLKCORCNT1(2),
	GlitchData    => RXCLKCORCNT12_GlitchData,
	OutSignalName => "RXCLKCORCNT1(2)",
	OutTemp       => RXCLKCORCNT1_OUT(2),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXCLKCORCNT1(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXPRBSERR0,
	GlitchData    => RXPRBSERR0_GlitchData,
	OutSignalName => "RXPRBSERR0",
	OutTemp       => RXPRBSERR0_OUT,
	Paths         => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXPRBSERR0,TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXPRBSERR1,
	GlitchData    => RXPRBSERR1_GlitchData,
	OutSignalName => "RXPRBSERR1",
	OutTemp       => RXPRBSERR1_OUT,
	Paths         => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXPRBSERR1,TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DO(0),
	GlitchData    => DO0_GlitchData,
	OutSignalName => "DO(0)",
	OutTemp       => DO_OUT(0),
	Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DO(1),
	GlitchData    => DO1_GlitchData,
	OutSignalName => "DO(1)",
	OutTemp       => DO_OUT(1),
	Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DO(2),
	GlitchData    => DO2_GlitchData,
	OutSignalName => "DO(2)",
	OutTemp       => DO_OUT(2),
	Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DO(3),
	GlitchData    => DO3_GlitchData,
	OutSignalName => "DO(3)",
	OutTemp       => DO_OUT(3),
	Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(3),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DO(4),
	GlitchData    => DO4_GlitchData,
	OutSignalName => "DO(4)",
	OutTemp       => DO_OUT(4),
	Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(4),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DO(5),
	GlitchData    => DO5_GlitchData,
	OutSignalName => "DO(5)",
	OutTemp       => DO_OUT(5),
	Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(5),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DO(6),
	GlitchData    => DO6_GlitchData,
	OutSignalName => "DO(6)",
	OutTemp       => DO_OUT(6),
	Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(6),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DO(7),
	GlitchData    => DO7_GlitchData,
	OutSignalName => "DO(7)",
	OutTemp       => DO_OUT(7),
	Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(7),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DO(8),
	GlitchData    => DO8_GlitchData,
	OutSignalName => "DO(8)",
	OutTemp       => DO_OUT(8),
	Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(8),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DO(9),
	GlitchData    => DO9_GlitchData,
	OutSignalName => "DO(9)",
	OutTemp       => DO_OUT(9),
	Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(9),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DO(10),
	GlitchData    => DO10_GlitchData,
	OutSignalName => "DO(10)",
	OutTemp       => DO_OUT(10),
	Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(10),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DO(11),
	GlitchData    => DO11_GlitchData,
	OutSignalName => "DO(11)",
	OutTemp       => DO_OUT(11),
	Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(11),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DO(12),
	GlitchData    => DO12_GlitchData,
	OutSignalName => "DO(12)",
	OutTemp       => DO_OUT(12),
	Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(12),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DO(13),
	GlitchData    => DO13_GlitchData,
	OutSignalName => "DO(13)",
	OutTemp       => DO_OUT(13),
	Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(13),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DO(14),
	GlitchData    => DO14_GlitchData,
	OutSignalName => "DO(14)",
	OutTemp       => DO_OUT(14),
	Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(14),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DO(15),
	GlitchData    => DO15_GlitchData,
	OutSignalName => "DO(15)",
	OutTemp       => DO_OUT(15),
	Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DO(15),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DRDY,
	GlitchData    => DRDY_GlitchData,
	OutSignalName => "DRDY",
	OutTemp       => DRDY_OUT,
	Paths         => (0 => (DCLK_dly'last_event, tpd_DCLK_DRDY,TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXOVERSAMPLEERR0,
	GlitchData    => RXOVERSAMPLEERR0_GlitchData,
	OutSignalName => "RXOVERSAMPLEERR0",
	OutTemp       => RXOVERSAMPLEERR0_OUT,
	Paths         => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXOVERSAMPLEERR0,TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXOVERSAMPLEERR1,
	GlitchData    => RXOVERSAMPLEERR1_GlitchData,
	OutSignalName => "RXOVERSAMPLEERR1",
	OutTemp       => RXOVERSAMPLEERR1_OUT,
	Paths         => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXOVERSAMPLEERR1,TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => TXGEARBOXREADY0,
	GlitchData    => TXGEARBOXREADY0_GlitchData,
	OutSignalName => "TXGEARBOXREADY0",
	OutTemp       => TXGEARBOXREADY0_OUT,
	Paths         => (0 => (TXUSRCLK20_dly'last_event, tpd_TXUSRCLK20_TXGEARBOXREADY0,TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXHEADER0(0),
	GlitchData    => RXHEADER00_GlitchData,
	OutSignalName => "RXHEADER0(0)",
	OutTemp       => RXHEADER0_OUT(0),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXHEADER0(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXHEADER0(1),
	GlitchData    => RXHEADER01_GlitchData,
	OutSignalName => "RXHEADER0(1)",
	OutTemp       => RXHEADER0_OUT(1),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXHEADER0(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXHEADER0(2),
	GlitchData    => RXHEADER02_GlitchData,
	OutSignalName => "RXHEADER0(2)",
	OutTemp       => RXHEADER0_OUT(2),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXHEADER0(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXHEADERVALID0,
	GlitchData    => RXHEADERVALID0_GlitchData,
	OutSignalName => "RXHEADERVALID0",
	OutTemp       => RXHEADERVALID0_OUT,
	Paths         => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXHEADERVALID0,TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATAVALID0,
	GlitchData    => RXDATAVALID0_GlitchData,
	OutSignalName => "RXDATAVALID0",
	OutTemp       => RXDATAVALID0_OUT,
	Paths         => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATAVALID0,TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXSTARTOFSEQ0,
	GlitchData    => RXSTARTOFSEQ0_GlitchData,
	OutSignalName => "RXSTARTOFSEQ0",
	OutTemp       => RXSTARTOFSEQ0_OUT,
	Paths         => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXSTARTOFSEQ0,TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => TXGEARBOXREADY1,
	GlitchData    => TXGEARBOXREADY1_GlitchData,
	OutSignalName => "TXGEARBOXREADY1",
	OutTemp       => TXGEARBOXREADY1_OUT,
	Paths         => (0 => (TXUSRCLK21_dly'last_event, tpd_TXUSRCLK21_TXGEARBOXREADY1,TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXHEADER1(0),
	GlitchData    => RXHEADER10_GlitchData,
	OutSignalName => "RXHEADER1(0)",
	OutTemp       => RXHEADER1_OUT(0),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXHEADER1(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXHEADER1(1),
	GlitchData    => RXHEADER11_GlitchData,
	OutSignalName => "RXHEADER1(1)",
	OutTemp       => RXHEADER1_OUT(1),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXHEADER1(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXHEADER1(2),
	GlitchData    => RXHEADER12_GlitchData,
	OutSignalName => "RXHEADER1(2)",
	OutTemp       => RXHEADER1_OUT(2),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXHEADER1(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXHEADERVALID1,
	GlitchData    => RXHEADERVALID1_GlitchData,
	OutSignalName => "RXHEADERVALID1",
	OutTemp       => RXHEADERVALID1_OUT,
	Paths         => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXHEADERVALID1,TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXDATAVALID1,
	GlitchData    => RXDATAVALID1_GlitchData,
	OutSignalName => "RXDATAVALID1",
	OutTemp       => RXDATAVALID1_OUT,
	Paths         => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATAVALID1,TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => RXSTARTOFSEQ1,
	GlitchData    => RXSTARTOFSEQ1_GlitchData,
	OutSignalName => "RXSTARTOFSEQ1",
	OutTemp       => RXSTARTOFSEQ1_OUT,
	Paths         => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXSTARTOFSEQ1,TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFECLKDLYADJMONITOR0(0),
	GlitchData    => DFECLKDLYADJMONITOR00_GlitchData,
	OutSignalName => "DFECLKDLYADJMONITOR0(0)",
	OutTemp       => DFECLKDLYADJMONITOR0_OUT(0),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFECLKDLYADJMONITOR0(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFECLKDLYADJMONITOR0(1),
	GlitchData    => DFECLKDLYADJMONITOR01_GlitchData,
	OutSignalName => "DFECLKDLYADJMONITOR0(1)",
	OutTemp       => DFECLKDLYADJMONITOR0_OUT(1),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFECLKDLYADJMONITOR0(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFECLKDLYADJMONITOR0(2),
	GlitchData    => DFECLKDLYADJMONITOR02_GlitchData,
	OutSignalName => "DFECLKDLYADJMONITOR0(2)",
	OutTemp       => DFECLKDLYADJMONITOR0_OUT(2),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFECLKDLYADJMONITOR0(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFECLKDLYADJMONITOR0(3),
	GlitchData    => DFECLKDLYADJMONITOR03_GlitchData,
	OutSignalName => "DFECLKDLYADJMONITOR0(3)",
	OutTemp       => DFECLKDLYADJMONITOR0_OUT(3),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFECLKDLYADJMONITOR0(3),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFECLKDLYADJMONITOR0(4),
	GlitchData    => DFECLKDLYADJMONITOR04_GlitchData,
	OutSignalName => "DFECLKDLYADJMONITOR0(4)",
	OutTemp       => DFECLKDLYADJMONITOR0_OUT(4),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFECLKDLYADJMONITOR0(4),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFECLKDLYADJMONITOR0(5),
	GlitchData    => DFECLKDLYADJMONITOR05_GlitchData,
	OutSignalName => "DFECLKDLYADJMONITOR0(5)",
	OutTemp       => DFECLKDLYADJMONITOR0_OUT(5),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFECLKDLYADJMONITOR0(5),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFEEYEDACMONITOR0(0),
	GlitchData    => DFEEYEDACMONITOR00_GlitchData,
	OutSignalName => "DFEEYEDACMONITOR0(0)",
	OutTemp       => DFEEYEDACMONITOR0_OUT(0),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFEEYEDACMONITOR0(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFEEYEDACMONITOR0(1),
	GlitchData    => DFEEYEDACMONITOR01_GlitchData,
	OutSignalName => "DFEEYEDACMONITOR0(1)",
	OutTemp       => DFEEYEDACMONITOR0_OUT(1),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFEEYEDACMONITOR0(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFEEYEDACMONITOR0(2),
	GlitchData    => DFEEYEDACMONITOR02_GlitchData,
	OutSignalName => "DFEEYEDACMONITOR0(2)",
	OutTemp       => DFEEYEDACMONITOR0_OUT(2),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFEEYEDACMONITOR0(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFEEYEDACMONITOR0(3),
	GlitchData    => DFEEYEDACMONITOR03_GlitchData,
	OutSignalName => "DFEEYEDACMONITOR0(3)",
	OutTemp       => DFEEYEDACMONITOR0_OUT(3),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFEEYEDACMONITOR0(3),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFEEYEDACMONITOR0(4),
	GlitchData    => DFEEYEDACMONITOR04_GlitchData,
	OutSignalName => "DFEEYEDACMONITOR0(4)",
	OutTemp       => DFEEYEDACMONITOR0_OUT(4),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFEEYEDACMONITOR0(4),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP1MONITOR0(0),
	GlitchData    => DFETAP1MONITOR00_GlitchData,
	OutSignalName => "DFETAP1MONITOR0(0)",
	OutTemp       => DFETAP1MONITOR0_OUT(0),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFETAP1MONITOR0(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP1MONITOR0(1),
	GlitchData    => DFETAP1MONITOR01_GlitchData,
	OutSignalName => "DFETAP1MONITOR0(1)",
	OutTemp       => DFETAP1MONITOR0_OUT(1),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFETAP1MONITOR0(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP1MONITOR0(2),
	GlitchData    => DFETAP1MONITOR02_GlitchData,
	OutSignalName => "DFETAP1MONITOR0(2)",
	OutTemp       => DFETAP1MONITOR0_OUT(2),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFETAP1MONITOR0(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP1MONITOR0(3),
	GlitchData    => DFETAP1MONITOR03_GlitchData,
	OutSignalName => "DFETAP1MONITOR0(3)",
	OutTemp       => DFETAP1MONITOR0_OUT(3),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFETAP1MONITOR0(3),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP1MONITOR0(4),
	GlitchData    => DFETAP1MONITOR04_GlitchData,
	OutSignalName => "DFETAP1MONITOR0(4)",
	OutTemp       => DFETAP1MONITOR0_OUT(4),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFETAP1MONITOR0(4),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP2MONITOR0(0),
	GlitchData    => DFETAP2MONITOR00_GlitchData,
	OutSignalName => "DFETAP2MONITOR0(0)",
	OutTemp       => DFETAP2MONITOR0_OUT(0),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFETAP2MONITOR0(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP2MONITOR0(1),
	GlitchData    => DFETAP2MONITOR01_GlitchData,
	OutSignalName => "DFETAP2MONITOR0(1)",
	OutTemp       => DFETAP2MONITOR0_OUT(1),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFETAP2MONITOR0(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP2MONITOR0(2),
	GlitchData    => DFETAP2MONITOR02_GlitchData,
	OutSignalName => "DFETAP2MONITOR0(2)",
	OutTemp       => DFETAP2MONITOR0_OUT(2),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFETAP2MONITOR0(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP2MONITOR0(3),
	GlitchData    => DFETAP2MONITOR03_GlitchData,
	OutSignalName => "DFETAP2MONITOR0(3)",
	OutTemp       => DFETAP2MONITOR0_OUT(3),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFETAP2MONITOR0(3),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP2MONITOR0(4),
	GlitchData    => DFETAP2MONITOR04_GlitchData,
	OutSignalName => "DFETAP2MONITOR0(4)",
	OutTemp       => DFETAP2MONITOR0_OUT(4),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFETAP2MONITOR0(4),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP3MONITOR0(0),
	GlitchData    => DFETAP3MONITOR00_GlitchData,
	OutSignalName => "DFETAP3MONITOR0(0)",
	OutTemp       => DFETAP3MONITOR0_OUT(0),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFETAP3MONITOR0(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP3MONITOR0(1),
	GlitchData    => DFETAP3MONITOR01_GlitchData,
	OutSignalName => "DFETAP3MONITOR0(1)",
	OutTemp       => DFETAP3MONITOR0_OUT(1),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFETAP3MONITOR0(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP3MONITOR0(2),
	GlitchData    => DFETAP3MONITOR02_GlitchData,
	OutSignalName => "DFETAP3MONITOR0(2)",
	OutTemp       => DFETAP3MONITOR0_OUT(2),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFETAP3MONITOR0(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP3MONITOR0(3),
	GlitchData    => DFETAP3MONITOR03_GlitchData,
	OutSignalName => "DFETAP3MONITOR0(3)",
	OutTemp       => DFETAP3MONITOR0_OUT(3),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFETAP3MONITOR0(3),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP4MONITOR0(0),
	GlitchData    => DFETAP4MONITOR00_GlitchData,
	OutSignalName => "DFETAP4MONITOR0(0)",
	OutTemp       => DFETAP4MONITOR0_OUT(0),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFETAP4MONITOR0(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP4MONITOR0(1),
	GlitchData    => DFETAP4MONITOR01_GlitchData,
	OutSignalName => "DFETAP4MONITOR0(1)",
	OutTemp       => DFETAP4MONITOR0_OUT(1),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFETAP4MONITOR0(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP4MONITOR0(2),
	GlitchData    => DFETAP4MONITOR02_GlitchData,
	OutSignalName => "DFETAP4MONITOR0(2)",
	OutTemp       => DFETAP4MONITOR0_OUT(2),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFETAP4MONITOR0(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP4MONITOR0(3),
	GlitchData    => DFETAP4MONITOR03_GlitchData,
	OutSignalName => "DFETAP4MONITOR0(3)",
	OutTemp       => DFETAP4MONITOR0_OUT(3),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFETAP4MONITOR0(3),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFECLKDLYADJMONITOR1(0),
	GlitchData    => DFECLKDLYADJMONITOR10_GlitchData,
	OutSignalName => "DFECLKDLYADJMONITOR1(0)",
	OutTemp       => DFECLKDLYADJMONITOR1_OUT(0),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_DFECLKDLYADJMONITOR1(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFECLKDLYADJMONITOR1(1),
	GlitchData    => DFECLKDLYADJMONITOR11_GlitchData,
	OutSignalName => "DFECLKDLYADJMONITOR1(1)",
	OutTemp       => DFECLKDLYADJMONITOR1_OUT(1),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_DFECLKDLYADJMONITOR1(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFECLKDLYADJMONITOR1(2),
	GlitchData    => DFECLKDLYADJMONITOR12_GlitchData,
	OutSignalName => "DFECLKDLYADJMONITOR1(2)",
	OutTemp       => DFECLKDLYADJMONITOR1_OUT(2),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_DFECLKDLYADJMONITOR1(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFECLKDLYADJMONITOR1(3),
	GlitchData    => DFECLKDLYADJMONITOR13_GlitchData,
	OutSignalName => "DFECLKDLYADJMONITOR1(3)",
	OutTemp       => DFECLKDLYADJMONITOR1_OUT(3),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_DFECLKDLYADJMONITOR1(3),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFECLKDLYADJMONITOR1(4),
	GlitchData    => DFECLKDLYADJMONITOR14_GlitchData,
	OutSignalName => "DFECLKDLYADJMONITOR1(4)",
	OutTemp       => DFECLKDLYADJMONITOR1_OUT(4),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_DFECLKDLYADJMONITOR1(4),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFECLKDLYADJMONITOR1(5),
	GlitchData    => DFECLKDLYADJMONITOR15_GlitchData,
	OutSignalName => "DFECLKDLYADJMONITOR1(5)",
	OutTemp       => DFECLKDLYADJMONITOR1_OUT(5),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_DFECLKDLYADJMONITOR1(5),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFEEYEDACMONITOR1(0),
	GlitchData    => DFEEYEDACMONITOR10_GlitchData,
	OutSignalName => "DFEEYEDACMONITOR1(0)",
	OutTemp       => DFEEYEDACMONITOR1_OUT(0),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_DFEEYEDACMONITOR1(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFEEYEDACMONITOR1(1),
	GlitchData    => DFEEYEDACMONITOR11_GlitchData,
	OutSignalName => "DFEEYEDACMONITOR1(1)",
	OutTemp       => DFEEYEDACMONITOR1_OUT(1),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_DFEEYEDACMONITOR1(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFEEYEDACMONITOR1(2),
	GlitchData    => DFEEYEDACMONITOR12_GlitchData,
	OutSignalName => "DFEEYEDACMONITOR1(2)",
	OutTemp       => DFEEYEDACMONITOR1_OUT(2),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_DFEEYEDACMONITOR1(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFEEYEDACMONITOR1(3),
	GlitchData    => DFEEYEDACMONITOR13_GlitchData,
	OutSignalName => "DFEEYEDACMONITOR1(3)",
	OutTemp       => DFEEYEDACMONITOR1_OUT(3),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_DFEEYEDACMONITOR1(3),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFEEYEDACMONITOR1(4),
	GlitchData    => DFEEYEDACMONITOR14_GlitchData,
	OutSignalName => "DFEEYEDACMONITOR1(4)",
	OutTemp       => DFEEYEDACMONITOR1_OUT(4),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_DFEEYEDACMONITOR1(4),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP1MONITOR1(0),
	GlitchData    => DFETAP1MONITOR10_GlitchData,
	OutSignalName => "DFETAP1MONITOR1(0)",
	OutTemp       => DFETAP1MONITOR1_OUT(0),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_DFETAP1MONITOR1(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP1MONITOR1(1),
	GlitchData    => DFETAP1MONITOR11_GlitchData,
	OutSignalName => "DFETAP1MONITOR1(1)",
	OutTemp       => DFETAP1MONITOR1_OUT(1),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_DFETAP1MONITOR1(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP1MONITOR1(2),
	GlitchData    => DFETAP1MONITOR12_GlitchData,
	OutSignalName => "DFETAP1MONITOR1(2)",
	OutTemp       => DFETAP1MONITOR1_OUT(2),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_DFETAP1MONITOR1(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP1MONITOR1(3),
	GlitchData    => DFETAP1MONITOR13_GlitchData,
	OutSignalName => "DFETAP1MONITOR1(3)",
	OutTemp       => DFETAP1MONITOR1_OUT(3),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_DFETAP1MONITOR1(3),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP1MONITOR1(4),
	GlitchData    => DFETAP1MONITOR14_GlitchData,
	OutSignalName => "DFETAP1MONITOR1(4)",
	OutTemp       => DFETAP1MONITOR1_OUT(4),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_DFETAP1MONITOR1(4),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP2MONITOR1(0),
	GlitchData    => DFETAP2MONITOR10_GlitchData,
	OutSignalName => "DFETAP2MONITOR1(0)",
	OutTemp       => DFETAP2MONITOR1_OUT(0),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_DFETAP2MONITOR1(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP2MONITOR1(1),
	GlitchData    => DFETAP2MONITOR11_GlitchData,
	OutSignalName => "DFETAP2MONITOR1(1)",
	OutTemp       => DFETAP2MONITOR1_OUT(1),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_DFETAP2MONITOR1(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP2MONITOR1(2),
	GlitchData    => DFETAP2MONITOR12_GlitchData,
	OutSignalName => "DFETAP2MONITOR1(2)",
	OutTemp       => DFETAP2MONITOR1_OUT(2),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_DFETAP2MONITOR1(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP2MONITOR1(3),
	GlitchData    => DFETAP2MONITOR13_GlitchData,
	OutSignalName => "DFETAP2MONITOR1(3)",
	OutTemp       => DFETAP2MONITOR1_OUT(3),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_DFETAP2MONITOR1(3),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP2MONITOR1(4),
	GlitchData    => DFETAP2MONITOR14_GlitchData,
	OutSignalName => "DFETAP2MONITOR1(4)",
	OutTemp       => DFETAP2MONITOR1_OUT(4),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_DFETAP2MONITOR1(4),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP3MONITOR1(0),
	GlitchData    => DFETAP3MONITOR10_GlitchData,
	OutSignalName => "DFETAP3MONITOR1(0)",
	OutTemp       => DFETAP3MONITOR1_OUT(0),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_DFETAP3MONITOR1(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP3MONITOR1(1),
	GlitchData    => DFETAP3MONITOR11_GlitchData,
	OutSignalName => "DFETAP3MONITOR1(1)",
	OutTemp       => DFETAP3MONITOR1_OUT(1),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_DFETAP3MONITOR1(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP3MONITOR1(2),
	GlitchData    => DFETAP3MONITOR12_GlitchData,
	OutSignalName => "DFETAP3MONITOR1(2)",
	OutTemp       => DFETAP3MONITOR1_OUT(2),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_DFETAP3MONITOR1(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP3MONITOR1(3),
	GlitchData    => DFETAP3MONITOR13_GlitchData,
	OutSignalName => "DFETAP3MONITOR1(3)",
	OutTemp       => DFETAP3MONITOR1_OUT(3),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_DFETAP3MONITOR1(3),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP4MONITOR1(0),
	GlitchData    => DFETAP4MONITOR10_GlitchData,
	OutSignalName => "DFETAP4MONITOR1(0)",
	OutTemp       => DFETAP4MONITOR1_OUT(0),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_DFETAP4MONITOR1(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP4MONITOR1(1),
	GlitchData    => DFETAP4MONITOR11_GlitchData,
	OutSignalName => "DFETAP4MONITOR1(1)",
	OutTemp       => DFETAP4MONITOR1_OUT(1),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_DFETAP4MONITOR1(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP4MONITOR1(2),
	GlitchData    => DFETAP4MONITOR12_GlitchData,
	OutSignalName => "DFETAP4MONITOR1(2)",
	OutTemp       => DFETAP4MONITOR1_OUT(2),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_DFETAP4MONITOR1(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFETAP4MONITOR1(3),
	GlitchData    => DFETAP4MONITOR13_GlitchData,
	OutSignalName => "DFETAP4MONITOR1(3)",
	OutTemp       => DFETAP4MONITOR1_OUT(3),
	Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_DFETAP4MONITOR1(3),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFESENSCAL0(0),
	GlitchData    => DFESENSCAL00_GlitchData,
	OutSignalName => "DFESENSCAL0(0)",
	OutTemp       => DFESENSCAL0_OUT(0),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFESENSCAL0(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFESENSCAL0(1),
	GlitchData    => DFESENSCAL01_GlitchData,
	OutSignalName => "DFESENSCAL0(1)",
	OutTemp       => DFESENSCAL0_OUT(1),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFESENSCAL0(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFESENSCAL0(2),
	GlitchData    => DFESENSCAL02_GlitchData,
	OutSignalName => "DFESENSCAL0(2)",
	OutTemp       => DFESENSCAL0_OUT(2),
	Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_DFESENSCAL0(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFESENSCAL1(0),
	GlitchData    => DFESENSCAL10_GlitchData,
	OutSignalName => "DFESENSCAL1(0)",
	OutTemp       => DFESENSCAL1_OUT(0),
	Paths       => (0 => (RXUSRCLk21_dly'last_event, tpd_RXUSRCLk21_DFESENSCAL1(0),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFESENSCAL1(1),
	GlitchData    => DFESENSCAL11_GlitchData,
	OutSignalName => "DFESENSCAL1(1)",
	OutTemp       => DFESENSCAL1_OUT(1),
	Paths       => (0 => (RXUSRCLk21_dly'last_event, tpd_RXUSRCLk21_DFESENSCAL1(1),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);
	VitalPathDelay01
	(
	OutSignal     => DFESENSCAL1(2),
	GlitchData    => DFESENSCAL12_GlitchData,
	OutSignalName => "DFESENSCAL1(2)",
	OutTemp       => DFESENSCAL1_OUT(2),
	Paths       => (0 => (RXUSRCLk21_dly'last_event, tpd_RXUSRCLk21_DFESENSCAL1(2),TRUE)),
	Mode          => VitalTransport,
	Xon           => false,
	MsgOn         => false,
	MsgSeverity   => WARNING
	);

   wait on
	DFECLKDLYADJMONITOR0_out,
	DFECLKDLYADJMONITOR1_out,
	DFEEYEDACMONITOR0_out,
	DFEEYEDACMONITOR1_out,
	DFESENSCAL0_out,
	DFESENSCAL1_out,
	DFETAP1MONITOR0_out,
	DFETAP1MONITOR1_out,
	DFETAP2MONITOR0_out,
	DFETAP2MONITOR1_out,
	DFETAP3MONITOR0_out,
	DFETAP3MONITOR1_out,
	DFETAP4MONITOR0_out,
	DFETAP4MONITOR1_out,
	DO_out,
	DRDY_out,
        PHYSTATUS0_out,
	PHYSTATUS1_out,
        REFCLKOUT_out,
	RXBUFSTATUS0_out,
	RXBUFSTATUS1_out,
	RXBYTEISALIGNED0_out,
	RXBYTEISALIGNED1_out,
	RXBYTEREALIGN0_out,
	RXBYTEREALIGN1_out,
	RXCHANBONDSEQ0_out,
	RXCHANBONDSEQ1_out,
	RXCHANISALIGNED0_out,
	RXCHANISALIGNED1_out,
	RXCHANREALIGN0_out,
	RXCHANREALIGN1_out,
	RXCHARISCOMMA0_out,
	RXCHARISCOMMA1_out,
	RXCHARISK0_out,
	RXCHARISK1_out,
	RXCHBONDO0_out,
	RXCHBONDO1_out,
	RXCLKCORCNT0_out,
	RXCLKCORCNT1_out,
	RXCOMMADET0_out,
	RXCOMMADET1_out,
	RXDATA0_out,
	RXDATA1_out,
	RXDATAVALID0_out,
	RXDATAVALID1_out,
	RXDISPERR0_out,
	RXDISPERR1_out,
	RXHEADER0_out,
	RXHEADER1_out,
	RXHEADERVALID0_out,
	RXHEADERVALID1_out,
	RXLOSSOFSYNC0_out,
	RXLOSSOFSYNC1_out,
	RXNOTINTABLE0_out,
	RXNOTINTABLE1_out,
	RXOVERSAMPLEERR0_out,
	RXOVERSAMPLEERR1_out,
	RXPRBSERR0_out,
	RXPRBSERR1_out,
	RXRUNDISP0_out,
	RXRUNDISP1_out,
	RXSTARTOFSEQ0_out,
	RXSTARTOFSEQ1_out,
	RXSTATUS0_out,
	RXSTATUS1_out,
	RXVALID0_out,
	RXVALID1_out,
	TXBUFSTATUS0_out,
	TXBUFSTATUS1_out,
	TXGEARBOXREADY0_out,
	TXGEARBOXREADY1_out,
	TXKERR0_out,
	TXKERR1_out,
	TXRUNDISP0_out,
	TXRUNDISP1_out,

	DADDR_dly,
	DEN_dly,
	DFECLKDLYADJ0_dly,
	DFECLKDLYADJ1_dly,
	DFETAP10_dly,
	DFETAP11_dly,
	DFETAP20_dly,
	DFETAP21_dly,
	DFETAP30_dly,
	DFETAP31_dly,
	DFETAP40_dly,
	DFETAP41_dly,
	DI_dly,
	DWE_dly,
	PRBSCNTRESET0_dly,
	PRBSCNTRESET1_dly,
	RXCHBONDI0_dly,
	RXCHBONDI1_dly,
	RXCOMMADETUSE0_dly,
	RXCOMMADETUSE1_dly,
	RXDEC8B10BUSE0_dly,
	RXDEC8B10BUSE1_dly,
	RXENCHANSYNC0_dly,
	RXENCHANSYNC1_dly,
	RXENMCOMMAALIGN0_dly,
	RXENMCOMMAALIGN1_dly,
	RXENPCOMMAALIGN0_dly,
	RXENPCOMMAALIGN1_dly,
	RXENPRBSTST0_dly,
	RXENPRBSTST1_dly,
	RXENSAMPLEALIGN0_dly,
	RXENSAMPLEALIGN1_dly,
	RXGEARBOXSLIP0_dly,
	RXGEARBOXSLIP1_dly,
	RXPOLARITY0_dly,
	RXPOLARITY1_dly,
	RXSLIDE0_dly,
	RXSLIDE1_dly,
	TXBYPASS8B10B0_dly,
	TXBYPASS8B10B1_dly,
	TXCHARDISPMODE0_dly,
	TXCHARDISPMODE1_dly,
	TXCHARDISPVAL0_dly,
	TXCHARDISPVAL1_dly,
	TXCHARISK0_dly,
	TXCHARISK1_dly,
	TXCOMSTART0_dly,
	TXCOMSTART1_dly,
	TXCOMTYPE0_dly,
	TXCOMTYPE1_dly,
	TXDATA0_dly,
	TXDATA1_dly,
	TXDETECTRX0_dly,
	TXDETECTRX1_dly,
        TXELECIDLE0_dly,
	TXELECIDLE1_dly,
        TXENC8B10BUSE0_dly,
	TXENC8B10BUSE1_dly,
	TXENPRBSTST0_dly,
	TXENPRBSTST1_dly,
	TXHEADER0_dly,
	TXHEADER1_dly,
	TXINHIBIT0_dly,
	TXINHIBIT1_dly,
	TXPOLARITY0_dly,
	TXPOLARITY1_dly,
	TXSEQUENCE0_dly,
	TXSEQUENCE1_dly,
	TXSTARTSEQ0_dly,
	TXSTARTSEQ1_dly;

	end process TIMING;

--	PHYSTATUS0 <= PHYSTATUS0_out;
--	PHYSTATUS1 <= PHYSTATUS1_out;
	PLLLKDET <= PLLLKDET_out;
	RESETDONE0 <= RESETDONE0_out;
	RESETDONE1 <= RESETDONE1_out;
	RXELECIDLE0 <= RXELECIDLE0_out;
	RXELECIDLE1 <= RXELECIDLE1_out;
	RXRECCLK0 <= RXRECCLK0_out;
	RXRECCLK1 <= RXRECCLK1_out;
	TXN0 <= TXN0_out;
	TXN1 <= TXN1_out;
	TXOUTCLK0 <= TXOUTCLK0_out;
	TXOUTCLK1 <= TXOUTCLK1_out;
	TXP0 <= TXP0_out;
	TXP1 <= TXP1_out;

end X_GTX_DUAL_V;

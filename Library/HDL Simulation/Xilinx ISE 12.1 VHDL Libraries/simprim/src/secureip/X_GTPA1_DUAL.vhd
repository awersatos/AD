-- $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/vhdsclibs/data/simprims/stan/SMODEL/X_GTPA1_DUAL.vhd,v 1.19 2009/10/22 16:59:49 robh Exp $
-------------------------------------------------------
--  Copyright (c) 2009 Xilinx Inc.
--  All Right Reserved.
-------------------------------------------------------
--
--   ____  ____
--  /   /\/   / 
-- /___/  \  /     Vendor      : Xilinx 
-- \   \   \/      Version : 11.1
--  \   \          Description : Multi-Gigabit Tranceiver Port Secure IP
--  /   /                        Timing Wrapper
-- /___/   /\      Filename    : X_GTPA1_DUAL.vhd
-- \   \  /  \      
--  \__ \/\__ \                   
--                                 
-- Revision:
--       1.0:  08/18/08 - Initial version.
--       1.1:  11/25/08 - Update to include secureip call
--       1.2   12/01/08 - parameter conversion width mismatch
--       1.3   01/22/09 - updates for VCS, NCSIM
--       1.4   01/29/09 - remove commented code
--       1.5   03/12/09 - CR511750 upper case parameter defaults
--       1.6   04/09/09 - CR516873 - yml, rtl update
--       1.7   09/02/09 - CR532550 - yml update
--       1.8:  10/01/09:  CR533370 - yml update
--       1.9:  10/20/09:  CR536553 - RXPRBSERR_LOOPBACK_* type bit not bit_vector

-- End Revision
-------------------------------------------------------

----- CELL X_GTPA1_DUAL -----

library IEEE;
use IEEE.STD_LOGIC_arith.all;
use IEEE.STD_LOGIC_1164.all;

library secureip;
use secureip.all;
library IEEE;
use IEEE.VITAL_Timing.all;

library simprim;
use simprim.VCOMPONENTS.all; 

library secureip; 
use secureip.all; 
use simprim.VPACKAGE.all;

  entity X_GTPA1_DUAL is
    generic (
      AC_CAP_DIS_0 : boolean := TRUE;
      AC_CAP_DIS_1 : boolean := TRUE;
      ALIGN_COMMA_WORD_0 : integer := 1;
      ALIGN_COMMA_WORD_1 : integer := 1;
      CB2_INH_CC_PERIOD_0 : integer := 8;
      CB2_INH_CC_PERIOD_1 : integer := 8;
      CDR_PH_ADJ_TIME_0 : bit_vector := "01010";
      CDR_PH_ADJ_TIME_1 : bit_vector := "01010";
      CHAN_BOND_1_MAX_SKEW_0 : integer := 7;
      CHAN_BOND_1_MAX_SKEW_1 : integer := 7;
      CHAN_BOND_2_MAX_SKEW_0 : integer := 1;
      CHAN_BOND_2_MAX_SKEW_1 : integer := 1;
      CHAN_BOND_KEEP_ALIGN_0 : boolean := FALSE;
      CHAN_BOND_KEEP_ALIGN_1 : boolean := FALSE;
      CHAN_BOND_SEQ_1_1_0 : bit_vector := "0101111100";
      CHAN_BOND_SEQ_1_1_1 : bit_vector := "0101111100";
      CHAN_BOND_SEQ_1_2_0 : bit_vector := "0001001010";
      CHAN_BOND_SEQ_1_2_1 : bit_vector := "0001001010";
      CHAN_BOND_SEQ_1_3_0 : bit_vector := "0001001010";
      CHAN_BOND_SEQ_1_3_1 : bit_vector := "0001001010";
      CHAN_BOND_SEQ_1_4_0 : bit_vector := "0110111100";
      CHAN_BOND_SEQ_1_4_1 : bit_vector := "0110111100";
      CHAN_BOND_SEQ_1_ENABLE_0 : bit_vector := "1111";
      CHAN_BOND_SEQ_1_ENABLE_1 : bit_vector := "1111";
      CHAN_BOND_SEQ_2_1_0 : bit_vector := "0110111100";
      CHAN_BOND_SEQ_2_1_1 : bit_vector := "0110111100";
      CHAN_BOND_SEQ_2_2_0 : bit_vector := "0100111100";
      CHAN_BOND_SEQ_2_2_1 : bit_vector := "0100111100";
      CHAN_BOND_SEQ_2_3_0 : bit_vector := "0100111100";
      CHAN_BOND_SEQ_2_3_1 : bit_vector := "0100111100";
      CHAN_BOND_SEQ_2_4_0 : bit_vector := "0100111100";
      CHAN_BOND_SEQ_2_4_1 : bit_vector := "0100111100";
      CHAN_BOND_SEQ_2_ENABLE_0 : bit_vector := "1111";
      CHAN_BOND_SEQ_2_ENABLE_1 : bit_vector := "1111";
      CHAN_BOND_SEQ_2_USE_0 : boolean := FALSE;
      CHAN_BOND_SEQ_2_USE_1 : boolean := FALSE;
      CHAN_BOND_SEQ_LEN_0 : integer := 1;
      CHAN_BOND_SEQ_LEN_1 : integer := 1;
      CLK25_DIVIDER_0 : integer := 4;
      CLK25_DIVIDER_1 : integer := 4;
      CLKINDC_B_0 : boolean := TRUE;
      CLKINDC_B_1 : boolean := TRUE;
      CLKRCV_TRST_0 : boolean := TRUE;
      CLKRCV_TRST_1 : boolean := TRUE;
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
      CLK_COR_SEQ_1_ENABLE_0 : bit_vector := "1111";
      CLK_COR_SEQ_1_ENABLE_1 : bit_vector := "1111";
      CLK_COR_SEQ_2_1_0 : bit_vector := "0000000000";
      CLK_COR_SEQ_2_1_1 : bit_vector := "0000000000";
      CLK_COR_SEQ_2_2_0 : bit_vector := "0000000000";
      CLK_COR_SEQ_2_2_1 : bit_vector := "0000000000";
      CLK_COR_SEQ_2_3_0 : bit_vector := "0000000000";
      CLK_COR_SEQ_2_3_1 : bit_vector := "0000000000";
      CLK_COR_SEQ_2_4_0 : bit_vector := "0000000000";
      CLK_COR_SEQ_2_4_1 : bit_vector := "0000000000";
      CLK_COR_SEQ_2_ENABLE_0 : bit_vector := "1111";
      CLK_COR_SEQ_2_ENABLE_1 : bit_vector := "1111";
      CLK_COR_SEQ_2_USE_0 : boolean := FALSE;
      CLK_COR_SEQ_2_USE_1 : boolean := FALSE;
      CLK_OUT_GTP_SEL_0 : string := "REFCLKPLL0";
      CLK_OUT_GTP_SEL_1 : string := "REFCLKPLL1";
      CM_TRIM_0 : bit_vector := "00";
      CM_TRIM_1 : bit_vector := "00";
      COMMA_10B_ENABLE_0 : bit_vector := "1111111111";
      COMMA_10B_ENABLE_1 : bit_vector := "1111111111";
      COM_BURST_VAL_0 : bit_vector := "1111";
      COM_BURST_VAL_1 : bit_vector := "1111";
      DEC_MCOMMA_DETECT_0 : boolean := TRUE;
      DEC_MCOMMA_DETECT_1 : boolean := TRUE;
      DEC_PCOMMA_DETECT_0 : boolean := TRUE;
      DEC_PCOMMA_DETECT_1 : boolean := TRUE;
      DEC_VALID_COMMA_ONLY_0 : boolean := TRUE;
      DEC_VALID_COMMA_ONLY_1 : boolean := TRUE;
      GTP_CFG_PWRUP_0 : boolean := TRUE;
      GTP_CFG_PWRUP_1 : boolean := TRUE;
      MCOMMA_10B_VALUE_0 : bit_vector := "1010000011";
      MCOMMA_10B_VALUE_1 : bit_vector := "1010000011";
      MCOMMA_DETECT_0 : boolean := TRUE;
      MCOMMA_DETECT_1 : boolean := TRUE;
      OOBDETECT_THRESHOLD_0 : bit_vector := "110";
      OOBDETECT_THRESHOLD_1 : bit_vector := "110";
      OOB_CLK_DIVIDER_0 : integer := 4;
      OOB_CLK_DIVIDER_1 : integer := 4;
      PCI_EXPRESS_MODE_0 : boolean := FALSE;
      PCI_EXPRESS_MODE_1 : boolean := FALSE;
      PCOMMA_10B_VALUE_0 : bit_vector := "0101111100";
      PCOMMA_10B_VALUE_1 : bit_vector := "0101111100";
      PCOMMA_DETECT_0 : boolean := TRUE;
      PCOMMA_DETECT_1 : boolean := TRUE;
      PLLLKDET_CFG_0 : bit_vector := "101";
      PLLLKDET_CFG_1 : bit_vector := "101";
      PLL_COM_CFG_0 : bit_vector := X"21680A";
      PLL_COM_CFG_1 : bit_vector := X"21680A";
      PLL_CP_CFG_0 : bit_vector := X"00";
      PLL_CP_CFG_1 : bit_vector := X"00";
      PLL_DIVSEL_FB_0 : integer := 5;
      PLL_DIVSEL_FB_1 : integer := 5;
      PLL_DIVSEL_REF_0 : integer := 2;
      PLL_DIVSEL_REF_1 : integer := 2;
      PLL_RXDIVSEL_OUT_0 : integer := 1;
      PLL_RXDIVSEL_OUT_1 : integer := 1;
      PLL_SATA_0 : boolean := FALSE;
      PLL_SATA_1 : boolean := FALSE;
      PLL_SOURCE_0 : string := "PLL0";
      PLL_SOURCE_1 : string := "PLL0";
      PLL_TXDIVSEL_OUT_0 : integer := 1;
      PLL_TXDIVSEL_OUT_1 : integer := 1;
      PMA_CDR_SCAN_0 : bit_vector := X"6404040";
      PMA_CDR_SCAN_1 : bit_vector := X"6404040";
      PMA_COM_CFG_EAST : bit_vector := X"000008000";
      PMA_COM_CFG_WEST : bit_vector := X"000008000";
      PMA_RXSYNC_CFG_0 : bit_vector := X"00";
      PMA_RXSYNC_CFG_1 : bit_vector := X"00";
      PMA_RX_CFG_0 : bit_vector := X"05CE048";
      PMA_RX_CFG_1 : bit_vector := X"05CE048";
      PMA_TX_CFG_0 : bit_vector := X"00082";
      PMA_TX_CFG_1 : bit_vector := X"00082";
      RCV_TERM_GND_0 : boolean := FALSE;
      RCV_TERM_GND_1 : boolean := FALSE;
      RCV_TERM_VTTRX_0 : boolean := TRUE;
      RCV_TERM_VTTRX_1 : boolean := TRUE;
      RXEQ_CFG_0 : bit_vector := "01111011";
      RXEQ_CFG_1 : bit_vector := "01111011";
      RXPRBSERR_LOOPBACK_0 : bit := '0';
      RXPRBSERR_LOOPBACK_1 : bit := '0';
      RX_BUFFER_USE_0 : boolean := TRUE;
      RX_BUFFER_USE_1 : boolean := TRUE;
      RX_DECODE_SEQ_MATCH_0 : boolean := TRUE;
      RX_DECODE_SEQ_MATCH_1 : boolean := TRUE;
      RX_EN_IDLE_HOLD_CDR_0 : boolean := FALSE;
      RX_EN_IDLE_HOLD_CDR_1 : boolean := FALSE;
      RX_EN_IDLE_RESET_BUF_0 : boolean := TRUE;
      RX_EN_IDLE_RESET_BUF_1 : boolean := TRUE;
      RX_EN_IDLE_RESET_FR_0 : boolean := TRUE;
      RX_EN_IDLE_RESET_FR_1 : boolean := TRUE;
      RX_EN_IDLE_RESET_PH_0 : boolean := TRUE;
      RX_EN_IDLE_RESET_PH_1 : boolean := TRUE;
      RX_EN_MODE_RESET_BUF_0 : boolean := TRUE;
      RX_EN_MODE_RESET_BUF_1 : boolean := TRUE;
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
      SATA_IDLE_VAL_0 : bit_vector := "011";
      SATA_IDLE_VAL_1 : bit_vector := "011";
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
      SIM_GTPRESET_SPEEDUP : integer := 1;
      SIM_RECEIVER_DETECT_PASS : boolean := TRUE;
      SIM_REFCLK0_SOURCE : bit_vector := "000";
      SIM_REFCLK1_SOURCE : bit_vector := "000";
      SIM_TX_ELEC_IDLE_LEVEL : string := "X";
      SIM_VERSION : string := "2.0";
      TERMINATION_CTRL_0 : bit_vector := "10100";
      TERMINATION_CTRL_1 : bit_vector := "10100";
      TERMINATION_OVRD_0 : boolean := FALSE;
      TERMINATION_OVRD_1 : boolean := FALSE;
      TRANS_TIME_FROM_P2_0 : bit_vector := X"03C";
      TRANS_TIME_FROM_P2_1 : bit_vector := X"03C";
      TRANS_TIME_NON_P2_0 : bit_vector := X"19";
      TRANS_TIME_NON_P2_1 : bit_vector := X"19";
      TRANS_TIME_TO_P2_0 : bit_vector := X"064";
      TRANS_TIME_TO_P2_1 : bit_vector := X"064";
      TST_ATTR_0 : bit_vector := X"00000000";
      TST_ATTR_1 : bit_vector := X"00000000";
      TXRX_INVERT_0 : bit_vector := "011";
      TXRX_INVERT_1 : bit_vector := "011";
      TX_BUFFER_USE_0 : boolean := FALSE;
      TX_BUFFER_USE_1 : boolean := FALSE;
      TX_DETECT_RX_CFG_0 : bit_vector := X"1832";
      TX_DETECT_RX_CFG_1 : bit_vector := X"1832";
      TX_IDLE_DELAY_0 : bit_vector := "011";
      TX_IDLE_DELAY_1 : bit_vector := "011";
      TX_TDCC_CFG_0 : bit_vector := "00";
      TX_TDCC_CFG_1 : bit_vector := "00";
      TX_XCLK_SEL_0 : string := "TXUSR";
      TX_XCLK_SEL_1 : string := "TXUSR";
      TimingChecksOn : boolean := TRUE;
      InstancePath   : string  := "*";
      Xon            : boolean := TRUE;
      MsgOn          : boolean := FALSE;
      LOC            : string  := "UNPLACED";
-- VITAL input Pin path delay variables
      tipd_CLK00 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_CLK01 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_CLK10 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_CLK11 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_CLKINEAST0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_CLKINEAST1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_CLKINWEST0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_CLKINWEST1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_DADDR : VitalDelayArrayType01 (7 downto 0) := (others => (0 ps, 0 ps));
      tipd_DCLK : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_DEN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_DI : VitalDelayArrayType01 (15 downto 0) := (others => (0 ps, 0 ps));
      tipd_DWE : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_GATERXELECIDLE0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_GATERXELECIDLE1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_GCLK00 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_GCLK01 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_GCLK10 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_GCLK11 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_GTPCLKFBSEL0EAST : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_GTPCLKFBSEL0WEST : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_GTPCLKFBSEL1EAST : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_GTPCLKFBSEL1WEST : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_GTPRESET0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_GTPRESET1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_GTPTEST0 : VitalDelayArrayType01 (7 downto 0) := (others => (0 ps, 0 ps));
      tipd_GTPTEST1 : VitalDelayArrayType01 (7 downto 0) := (others => (0 ps, 0 ps));
      tipd_IGNORESIGDET0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_IGNORESIGDET1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_INTDATAWIDTH0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_INTDATAWIDTH1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_LOOPBACK0 : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_LOOPBACK1 : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_PLLCLK00 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PLLCLK01 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PLLCLK10 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PLLCLK11 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PLLLKDETEN0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PLLLKDETEN1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PLLPOWERDOWN0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PLLPOWERDOWN1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PRBSCNTRESET0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PRBSCNTRESET1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RCALINEAST : VitalDelayArrayType01 (4 downto 0) := (others => (0 ps, 0 ps));
      tipd_RCALINWEST : VitalDelayArrayType01 (4 downto 0) := (others => (0 ps, 0 ps));
      tipd_REFCLKPWRDNB0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_REFCLKPWRDNB1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_REFSELDYPLL0 : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_REFSELDYPLL1 : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_RXBUFRESET0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXBUFRESET1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXCDRRESET0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXCDRRESET1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXCHBONDI : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_RXCHBONDMASTER0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXCHBONDMASTER1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXCHBONDSLAVE0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXCHBONDSLAVE1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXCOMMADETUSE0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXCOMMADETUSE1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXDATAWIDTH0 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_RXDATAWIDTH1 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_RXDEC8B10BUSE0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXDEC8B10BUSE1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXENCHANSYNC0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXENCHANSYNC1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXENMCOMMAALIGN0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXENMCOMMAALIGN1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXENPCOMMAALIGN0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXENPCOMMAALIGN1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXENPMAPHASEALIGN0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXENPMAPHASEALIGN1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXENPRBSTST0 : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_RXENPRBSTST1 : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_RXEQMIX0 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_RXEQMIX1 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
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
      tipd_TSTCLK0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TSTCLK1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TSTIN0 : VitalDelayArrayType01 (11 downto 0) := (others => (0 ps, 0 ps));
      tipd_TSTIN1 : VitalDelayArrayType01 (11 downto 0) := (others => (0 ps, 0 ps));
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
      tipd_TXDIFFCTRL0 : VitalDelayArrayType01 (3 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXDIFFCTRL1 : VitalDelayArrayType01 (3 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXELECIDLE0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXELECIDLE1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXENC8B10BUSE0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXENC8B10BUSE1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXENPMAPHASEALIGN0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXENPMAPHASEALIGN1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXENPRBSTST0 : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXENPRBSTST1 : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXINHIBIT0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXINHIBIT1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXPDOWNASYNCH0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXPDOWNASYNCH1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXPMASETPHASE0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXPMASETPHASE1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXPOLARITY0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXPOLARITY1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXPOWERDOWN0 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXPOWERDOWN1 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXPRBSFORCEERR0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXPRBSFORCEERR1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXPREEMPHASIS0 : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXPREEMPHASIS1 : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXRESET0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXRESET1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXUSRCLK0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXUSRCLK1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXUSRCLK20 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXUSRCLK21 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_USRCODEERR0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_USRCODEERR1 : VitalDelayType01 :=  (0 ps, 0 ps);
-- VITAL clk-to-output path delay variables
      tpd_CLK00_REFCLKPLL0 : VitalDelayType01 := (0 ps, 0 ps);
      tpd_CLK01_REFCLKPLL1 : VitalDelayType01 := (0 ps, 0 ps);
      tpd_CLK10_REFCLKPLL0 : VitalDelayType01 := (0 ps, 0 ps);
      tpd_CLK11_REFCLKPLL1 : VitalDelayType01 := (0 ps, 0 ps);
      tpd_CLKINEAST0_REFCLKPLL0 : VitalDelayType01 := (0 ps, 0 ps);
      tpd_CLKINEAST1_REFCLKPLL1 : VitalDelayType01 := (0 ps, 0 ps);
      tpd_CLKINWEST0_REFCLKPLL0 : VitalDelayType01 := (0 ps, 0 ps);
      tpd_CLKINWEST1_REFCLKPLL1 : VitalDelayType01 := (0 ps, 0 ps);
      tpd_DCLK_DRDY : VitalDelayType01 := (0 ps, 0 ps);
      tpd_DCLK_DRPDO : VitalDelayArrayType01(15 downto 0) := (others => (0 ps, 0 ps));
      tpd_GCLK00_REFCLKPLL0 : VitalDelayType01 := (0 ps, 0 ps);
      tpd_GCLK01_REFCLKPLL1 : VitalDelayType01 := (0 ps, 0 ps);
      tpd_GCLK10_REFCLKPLL0 : VitalDelayType01 := (0 ps, 0 ps);
      tpd_GCLK11_REFCLKPLL1 : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PLLCLK00_REFCLKPLL0 : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PLLCLK01_REFCLKPLL1 : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PLLCLK10_REFCLKPLL0 : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PLLCLK11_REFCLKPLL1 : VitalDelayType01 := (0 ps, 0 ps);
      tpd_RXUSRCLK0_RXCHBONDO : VitalDelayArrayType01(2 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSRCLK1_RXCHBONDO : VitalDelayArrayType01(2 downto 0) := (others => (0 ps, 0 ps));
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
      tpd_RXUSRCLK20_RXDISPERR0 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSRCLK20_RXLOSSOFSYNC0 : VitalDelayArrayType01(1 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSRCLK20_RXNOTINTABLE0 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSRCLK20_RXPRBSERR0 : VitalDelayType01 := (0 ps, 0 ps);
      tpd_RXUSRCLK20_RXRUNDISP0 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSRCLK20_RXSTATUS0 : VitalDelayArrayType01(2 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSRCLK20_RXVALID0 : VitalDelayType01 := (0 ps, 0 ps);
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
      tpd_RXUSRCLK21_RXDISPERR1 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSRCLK21_RXLOSSOFSYNC1 : VitalDelayArrayType01(1 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSRCLK21_RXNOTINTABLE1 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSRCLK21_RXPRBSERR1 : VitalDelayType01 := (0 ps, 0 ps);
      tpd_RXUSRCLK21_RXRUNDISP1 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSRCLK21_RXSTATUS1 : VitalDelayArrayType01(2 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSRCLK21_RXVALID1 : VitalDelayType01 := (0 ps, 0 ps);
      tpd_TXUSRCLK20_TXBUFSTATUS0 : VitalDelayArrayType01(1 downto 0) := (others => (0 ps, 0 ps));
      tpd_TXUSRCLK20_TXKERR0 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
      tpd_TXUSRCLK20_TXRUNDISP0 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
      tpd_TXUSRCLK21_TXBUFSTATUS1 : VitalDelayArrayType01(1 downto 0) := (others => (0 ps, 0 ps));
      tpd_TXUSRCLK21_TXKERR1 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
      tpd_TXUSRCLK21_TXRUNDISP1 : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
-- VITAL Hold delay variables
      thold_DADDR_DCLK_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_DADDR_DCLK_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_DEN_DCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_DEN_DCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_DI_DCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_DI_DCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_DWE_DCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_DWE_DCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_PRBSCNTRESET0_RXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
      thold_PRBSCNTRESET0_RXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
      thold_PRBSCNTRESET1_RXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
      thold_PRBSCNTRESET1_RXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
      thold_RXCHBONDI_RXUSRCLK0_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_RXCHBONDI_RXUSRCLK0_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_RXCHBONDI_RXUSRCLK1_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_RXCHBONDI_RXUSRCLK1_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_RXCHBONDMASTER0_RXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
      thold_RXCHBONDMASTER0_RXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
      thold_RXCHBONDMASTER1_RXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
      thold_RXCHBONDMASTER1_RXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
      thold_RXCHBONDSLAVE0_RXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
      thold_RXCHBONDSLAVE0_RXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
      thold_RXCHBONDSLAVE1_RXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
      thold_RXCHBONDSLAVE1_RXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
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
      thold_RXENPRBSTST0_RXUSRCLK20_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_RXENPRBSTST0_RXUSRCLK20_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_RXENPRBSTST1_RXUSRCLK21_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_RXENPRBSTST1_RXUSRCLK21_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
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
      thold_TXENPRBSTST0_TXUSRCLK20_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_TXENPRBSTST0_TXUSRCLK20_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_TXENPRBSTST1_TXUSRCLK21_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_TXENPRBSTST1_TXUSRCLK21_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_TXINHIBIT0_TXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
      thold_TXINHIBIT0_TXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
      thold_TXINHIBIT1_TXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
      thold_TXINHIBIT1_TXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
      thold_TXPOLARITY0_TXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
      thold_TXPOLARITY0_TXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
      thold_TXPOLARITY1_TXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
      thold_TXPOLARITY1_TXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
      thold_TXPOWERDOWN0_TXUSRCLK20_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_TXPOWERDOWN0_TXUSRCLK20_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_TXPOWERDOWN1_TXUSRCLK21_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_TXPOWERDOWN1_TXUSRCLK21_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_TXPRBSFORCEERR0_TXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
      thold_TXPRBSFORCEERR0_TXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
      thold_TXPRBSFORCEERR1_TXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
      thold_TXPRBSFORCEERR1_TXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
      thold_USRCODEERR0_RXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
      thold_USRCODEERR0_RXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
      thold_USRCODEERR1_RXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
      thold_USRCODEERR1_RXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
-- VITAL async rest-to-output path delay variables
-- VITAL async set-to-output path delay variables
-- VITAL pulse width variables
-- VITAL Setup delay variables
      tsetup_DADDR_DCLK_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_DADDR_DCLK_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_DEN_DCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_DEN_DCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_DI_DCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_DI_DCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_DWE_DCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_DWE_DCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PRBSCNTRESET0_RXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PRBSCNTRESET0_RXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PRBSCNTRESET1_RXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PRBSCNTRESET1_RXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXCHBONDI_RXUSRCLK0_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_RXCHBONDI_RXUSRCLK0_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_RXCHBONDI_RXUSRCLK1_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_RXCHBONDI_RXUSRCLK1_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_RXCHBONDMASTER0_RXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXCHBONDMASTER0_RXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXCHBONDMASTER1_RXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXCHBONDMASTER1_RXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXCHBONDSLAVE0_RXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXCHBONDSLAVE0_RXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXCHBONDSLAVE1_RXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXCHBONDSLAVE1_RXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
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
      tsetup_RXENPRBSTST0_RXUSRCLK20_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_RXENPRBSTST0_RXUSRCLK20_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_RXENPRBSTST1_RXUSRCLK21_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_RXENPRBSTST1_RXUSRCLK21_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
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
      tsetup_TXENPRBSTST0_TXUSRCLK20_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_TXENPRBSTST0_TXUSRCLK20_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_TXENPRBSTST1_TXUSRCLK21_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_TXENPRBSTST1_TXUSRCLK21_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_TXINHIBIT0_TXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXINHIBIT0_TXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXINHIBIT1_TXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXINHIBIT1_TXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXPOLARITY0_TXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXPOLARITY0_TXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXPOLARITY1_TXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXPOLARITY1_TXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXPOWERDOWN0_TXUSRCLK20_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_TXPOWERDOWN0_TXUSRCLK20_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_TXPOWERDOWN1_TXUSRCLK21_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_TXPOWERDOWN1_TXUSRCLK21_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_TXPRBSFORCEERR0_TXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXPRBSFORCEERR0_TXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXPRBSFORCEERR1_TXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXPRBSFORCEERR1_TXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_USRCODEERR0_RXUSRCLK20_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_USRCODEERR0_RXUSRCLK20_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_USRCODEERR1_RXUSRCLK21_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_USRCODEERR1_RXUSRCLK21_posedge_posedge : VitalDelayType := 0 ps;
-- VITAL ticd & tisd variables
      tisd_DADDR_DCLK : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tisd_DEN_DCLK : VitalDelayType := 0 ps;
      tisd_DI_DCLK : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tisd_DWE_DCLK : VitalDelayType := 0 ps;
      tisd_PRBSCNTRESET0_RXUSRCLK20 : VitalDelayType := 0 ps;
      tisd_PRBSCNTRESET1_RXUSRCLK21 : VitalDelayType := 0 ps;
      tisd_RXCHBONDI_RXUSRCLK0 : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tisd_RXCHBONDI_RXUSRCLK1 : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tisd_RXCHBONDMASTER0_RXUSRCLK20 : VitalDelayType := 0 ps;
      tisd_RXCHBONDMASTER1_RXUSRCLK21 : VitalDelayType := 0 ps;
      tisd_RXCHBONDSLAVE0_RXUSRCLK20 : VitalDelayType := 0 ps;
      tisd_RXCHBONDSLAVE1_RXUSRCLK21 : VitalDelayType := 0 ps;
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
      tisd_RXENPRBSTST0_RXUSRCLK20 : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tisd_RXENPRBSTST1_RXUSRCLK21 : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
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
      tisd_TXENPRBSTST0_TXUSRCLK20 : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tisd_TXENPRBSTST1_TXUSRCLK21 : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tisd_TXINHIBIT0_TXUSRCLK20 : VitalDelayType := 0 ps;
      tisd_TXINHIBIT1_TXUSRCLK21 : VitalDelayType := 0 ps;
      tisd_TXPOLARITY0_TXUSRCLK20 : VitalDelayType := 0 ps;
      tisd_TXPOLARITY1_TXUSRCLK21 : VitalDelayType := 0 ps;
      tisd_TXPOWERDOWN0_TXUSRCLK20 : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tisd_TXPOWERDOWN1_TXUSRCLK21 : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tisd_TXPRBSFORCEERR0_TXUSRCLK20 : VitalDelayType := 0 ps;
      tisd_TXPRBSFORCEERR1_TXUSRCLK21 : VitalDelayType := 0 ps;
      tisd_USRCODEERR0_RXUSRCLK20 : VitalDelayType := 0 ps;
      tisd_USRCODEERR1_RXUSRCLK21 : VitalDelayType := 0 ps;
-- VITAL ticd variables
      ticd_CLK00 : VitalDelayType := 0 ps;
      ticd_CLK01 : VitalDelayType := 0 ps;
      ticd_CLK10 : VitalDelayType := 0 ps;
      ticd_CLK11 : VitalDelayType := 0 ps;
      ticd_CLKINEAST0 : VitalDelayType := 0 ps;
      ticd_CLKINEAST1 : VitalDelayType := 0 ps;
      ticd_CLKINWEST0 : VitalDelayType := 0 ps;
      ticd_CLKINWEST1 : VitalDelayType := 0 ps;
      ticd_DCLK : VitalDelayType := 0 ps;
      ticd_GCLK00 : VitalDelayType := 0 ps;
      ticd_GCLK01 : VitalDelayType := 0 ps;
      ticd_GCLK10 : VitalDelayType := 0 ps;
      ticd_GCLK11 : VitalDelayType := 0 ps;
      ticd_PLLCLK00 : VitalDelayType := 0 ps;
      ticd_PLLCLK01 : VitalDelayType := 0 ps;
      ticd_PLLCLK10 : VitalDelayType := 0 ps;
      ticd_PLLCLK11 : VitalDelayType := 0 ps;
      ticd_RXUSRCLK0 : VitalDelayType := 0 ps;
      ticd_RXUSRCLK1 : VitalDelayType := 0 ps;
      ticd_RXUSRCLK20 : VitalDelayType := 0 ps;
      ticd_RXUSRCLK21 : VitalDelayType := 0 ps;
      ticd_TXUSRCLK20 : VitalDelayType := 0 ps;
      ticd_TXUSRCLK21 : VitalDelayType := 0 ps;
-- VITAL period variables
      tperiod_CLK00_posedge : VitalDelayType := 0 ps;
      tperiod_CLK01_posedge : VitalDelayType := 0 ps;
      tperiod_CLK10_posedge : VitalDelayType := 0 ps;
      tperiod_CLK11_posedge : VitalDelayType := 0 ps;
      tperiod_CLKINEAST0_posedge : VitalDelayType := 0 ps;
      tperiod_CLKINEAST1_posedge : VitalDelayType := 0 ps;
      tperiod_CLKINWEST0_posedge : VitalDelayType := 0 ps;
      tperiod_CLKINWEST1_posedge : VitalDelayType := 0 ps;
      tperiod_DCLK_posedge : VitalDelayType := 0 ps;
      tperiod_GCLK00_posedge : VitalDelayType := 0 ps;
      tperiod_GCLK01_posedge : VitalDelayType := 0 ps;
      tperiod_GCLK10_posedge : VitalDelayType := 0 ps;
      tperiod_GCLK11_posedge : VitalDelayType := 0 ps;
      tperiod_PLLCLK00_posedge : VitalDelayType := 0 ps;
      tperiod_PLLCLK01_posedge : VitalDelayType := 0 ps;
      tperiod_PLLCLK10_posedge : VitalDelayType := 0 ps;
      tperiod_PLLCLK11_posedge : VitalDelayType := 0 ps;
      tperiod_RXUSRCLK0_posedge : VitalDelayType := 0 ps;
      tperiod_RXUSRCLK1_posedge : VitalDelayType := 0 ps;
      tperiod_RXUSRCLK20_posedge : VitalDelayType := 0 ps;
      tperiod_RXUSRCLK21_posedge : VitalDelayType := 0 ps;
      tperiod_TSTCLK0_posedge : VitalDelayType := 0 ps;
      tperiod_TSTCLK1_posedge : VitalDelayType := 0 ps;
      tperiod_TXUSRCLK0_posedge : VitalDelayType := 0 ps;
      tperiod_TXUSRCLK1_posedge : VitalDelayType := 0 ps;
      tperiod_TXUSRCLK20_posedge : VitalDelayType := 0 ps;
      tperiod_TXUSRCLK21_posedge : VitalDelayType := 0 ps
-- VITAL recovery time variables
-- VITAL removal time variables
    );

    port (
      DRDY                 : out std_ulogic;
      DRPDO                : out std_logic_vector(15 downto 0);
      GTPCLKFBEAST         : out std_logic_vector(1 downto 0);
      GTPCLKFBWEST         : out std_logic_vector(1 downto 0);
      GTPCLKOUT0           : out std_logic_vector(1 downto 0);
      GTPCLKOUT1           : out std_logic_vector(1 downto 0);
      PHYSTATUS0           : out std_ulogic;
      PHYSTATUS1           : out std_ulogic;
      PLLLKDET0            : out std_ulogic;
      PLLLKDET1            : out std_ulogic;
      RCALOUTEAST          : out std_logic_vector(4 downto 0);
      RCALOUTWEST          : out std_logic_vector(4 downto 0);
      REFCLKOUT0           : out std_ulogic;
      REFCLKOUT1           : out std_ulogic;
      REFCLKPLL0           : out std_ulogic;
      REFCLKPLL1           : out std_ulogic;
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
      RXCHBONDO            : out std_logic_vector(2 downto 0);
      RXCLKCORCNT0         : out std_logic_vector(2 downto 0);
      RXCLKCORCNT1         : out std_logic_vector(2 downto 0);
      RXCOMMADET0          : out std_ulogic;
      RXCOMMADET1          : out std_ulogic;
      RXDATA0              : out std_logic_vector(31 downto 0);
      RXDATA1              : out std_logic_vector(31 downto 0);
      RXDISPERR0           : out std_logic_vector(3 downto 0);
      RXDISPERR1           : out std_logic_vector(3 downto 0);
      RXELECIDLE0          : out std_ulogic;
      RXELECIDLE1          : out std_ulogic;
      RXLOSSOFSYNC0        : out std_logic_vector(1 downto 0);
      RXLOSSOFSYNC1        : out std_logic_vector(1 downto 0);
      RXNOTINTABLE0        : out std_logic_vector(3 downto 0);
      RXNOTINTABLE1        : out std_logic_vector(3 downto 0);
      RXPRBSERR0           : out std_ulogic;
      RXPRBSERR1           : out std_ulogic;
      RXRECCLK0            : out std_ulogic;
      RXRECCLK1            : out std_ulogic;
      RXRUNDISP0           : out std_logic_vector(3 downto 0);
      RXRUNDISP1           : out std_logic_vector(3 downto 0);
      RXSTATUS0            : out std_logic_vector(2 downto 0);
      RXSTATUS1            : out std_logic_vector(2 downto 0);
      RXVALID0             : out std_ulogic;
      RXVALID1             : out std_ulogic;
      TSTOUT0              : out std_logic_vector(4 downto 0);
      TSTOUT1              : out std_logic_vector(4 downto 0);
      TXBUFSTATUS0         : out std_logic_vector(1 downto 0);
      TXBUFSTATUS1         : out std_logic_vector(1 downto 0);
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
      CLK00                : in std_ulogic;
      CLK01                : in std_ulogic;
      CLK10                : in std_ulogic;
      CLK11                : in std_ulogic;
      CLKINEAST0           : in std_ulogic;
      CLKINEAST1           : in std_ulogic;
      CLKINWEST0           : in std_ulogic;
      CLKINWEST1           : in std_ulogic;
      DADDR                : in std_logic_vector(7 downto 0);
      DCLK                 : in std_ulogic := 'L';
      DEN                  : in std_ulogic := 'L';
      DI                   : in std_logic_vector(15 downto 0);
      DWE                  : in std_ulogic := 'L';
      GATERXELECIDLE0      : in std_ulogic := 'L';
      GATERXELECIDLE1      : in std_ulogic := 'L';
      GCLK00               : in std_ulogic;
      GCLK01               : in std_ulogic;
      GCLK10               : in std_ulogic;
      GCLK11               : in std_ulogic;
      GTPCLKFBSEL0EAST     : in std_logic_vector(1 downto 0);
      GTPCLKFBSEL0WEST     : in std_logic_vector(1 downto 0);
      GTPCLKFBSEL1EAST     : in std_logic_vector(1 downto 0);
      GTPCLKFBSEL1WEST     : in std_logic_vector(1 downto 0);
      GTPRESET0            : in std_ulogic := 'L';
      GTPRESET1            : in std_ulogic := 'L';
      GTPTEST0             : in std_logic_vector(7 downto 0);
      GTPTEST1             : in std_logic_vector(7 downto 0);
      IGNORESIGDET0        : in std_ulogic := 'L';
      IGNORESIGDET1        : in std_ulogic := 'L';
      INTDATAWIDTH0        : in std_ulogic := 'L';
      INTDATAWIDTH1        : in std_ulogic := 'L';
      LOOPBACK0            : in std_logic_vector(2 downto 0);
      LOOPBACK1            : in std_logic_vector(2 downto 0);
      PLLCLK00             : in std_ulogic;
      PLLCLK01             : in std_ulogic;
      PLLCLK10             : in std_ulogic;
      PLLCLK11             : in std_ulogic;
      PLLLKDETEN0          : in std_ulogic := 'L';
      PLLLKDETEN1          : in std_ulogic := 'L';
      PLLPOWERDOWN0        : in std_ulogic := 'L';
      PLLPOWERDOWN1        : in std_ulogic := 'L';
      PRBSCNTRESET0        : in std_ulogic := 'L';
      PRBSCNTRESET1        : in std_ulogic := 'L';
      RCALINEAST           : in std_logic_vector(4 downto 0);
      RCALINWEST           : in std_logic_vector(4 downto 0);
      REFCLKPWRDNB0        : in std_ulogic := 'H';
      REFCLKPWRDNB1        : in std_ulogic := 'H';
      REFSELDYPLL0         : in std_logic_vector(2 downto 0);
      REFSELDYPLL1         : in std_logic_vector(2 downto 0);
      RXBUFRESET0          : in std_ulogic := 'L';
      RXBUFRESET1          : in std_ulogic := 'L';
      RXCDRRESET0          : in std_ulogic := 'L';
      RXCDRRESET1          : in std_ulogic := 'L';
      RXCHBONDI            : in std_logic_vector(2 downto 0);
      RXCHBONDMASTER0      : in std_ulogic := 'L';
      RXCHBONDMASTER1      : in std_ulogic := 'L';
      RXCHBONDSLAVE0       : in std_ulogic := 'L';
      RXCHBONDSLAVE1       : in std_ulogic := 'L';
      RXCOMMADETUSE0       : in std_ulogic := 'L';
      RXCOMMADETUSE1       : in std_ulogic := 'L';
      RXDATAWIDTH0         : in std_logic_vector(1 downto 0);
      RXDATAWIDTH1         : in std_logic_vector(1 downto 0);
      RXDEC8B10BUSE0       : in std_ulogic := 'L';
      RXDEC8B10BUSE1       : in std_ulogic := 'L';
      RXENCHANSYNC0        : in std_ulogic := 'L';
      RXENCHANSYNC1        : in std_ulogic := 'L';
      RXENMCOMMAALIGN0     : in std_ulogic := 'L';
      RXENMCOMMAALIGN1     : in std_ulogic := 'L';
      RXENPCOMMAALIGN0     : in std_ulogic := 'L';
      RXENPCOMMAALIGN1     : in std_ulogic := 'L';
      RXENPMAPHASEALIGN0   : in std_ulogic := 'L';
      RXENPMAPHASEALIGN1   : in std_ulogic := 'L';
      RXENPRBSTST0         : in std_logic_vector(2 downto 0);
      RXENPRBSTST1         : in std_logic_vector(2 downto 0);
      RXEQMIX0             : in std_logic_vector(1 downto 0);
      RXEQMIX1             : in std_logic_vector(1 downto 0);
      RXN0                 : in std_ulogic;
      RXN1                 : in std_ulogic;
      RXP0                 : in std_ulogic;
      RXP1                 : in std_ulogic;
      RXPMASETPHASE0       : in std_ulogic := 'L';
      RXPMASETPHASE1       : in std_ulogic := 'L';
      RXPOLARITY0          : in std_ulogic := 'L';
      RXPOLARITY1          : in std_ulogic := 'L';
      RXPOWERDOWN0         : in std_logic_vector(1 downto 0);
      RXPOWERDOWN1         : in std_logic_vector(1 downto 0);
      RXRESET0             : in std_ulogic := 'L';
      RXRESET1             : in std_ulogic := 'L';
      RXSLIDE0             : in std_ulogic := 'L';
      RXSLIDE1             : in std_ulogic := 'L';
      RXUSRCLK0            : in std_ulogic := 'L';
      RXUSRCLK1            : in std_ulogic := 'L';
      RXUSRCLK20           : in std_ulogic := 'L';
      RXUSRCLK21           : in std_ulogic := 'L';
      TSTCLK0              : in std_ulogic := 'L';
      TSTCLK1              : in std_ulogic := 'L';
      TSTIN0               : in std_logic_vector(11 downto 0);
      TSTIN1               : in std_logic_vector(11 downto 0);
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
      TXCOMSTART0          : in std_ulogic := 'L';
      TXCOMSTART1          : in std_ulogic := 'L';
      TXCOMTYPE0           : in std_ulogic := 'L';
      TXCOMTYPE1           : in std_ulogic := 'L';
      TXDATA0              : in std_logic_vector(31 downto 0);
      TXDATA1              : in std_logic_vector(31 downto 0);
      TXDATAWIDTH0         : in std_logic_vector(1 downto 0);
      TXDATAWIDTH1         : in std_logic_vector(1 downto 0);
      TXDETECTRX0          : in std_ulogic := 'L';
      TXDETECTRX1          : in std_ulogic := 'L';
      TXDIFFCTRL0          : in std_logic_vector(3 downto 0);
      TXDIFFCTRL1          : in std_logic_vector(3 downto 0);
      TXELECIDLE0          : in std_ulogic := 'L';
      TXELECIDLE1          : in std_ulogic := 'L';
      TXENC8B10BUSE0       : in std_ulogic := 'L';
      TXENC8B10BUSE1       : in std_ulogic := 'L';
      TXENPMAPHASEALIGN0   : in std_ulogic := 'L';
      TXENPMAPHASEALIGN1   : in std_ulogic := 'L';
      TXENPRBSTST0         : in std_logic_vector(2 downto 0);
      TXENPRBSTST1         : in std_logic_vector(2 downto 0);
      TXINHIBIT0           : in std_ulogic := 'L';
      TXINHIBIT1           : in std_ulogic := 'L';
      TXPDOWNASYNCH0       : in std_ulogic := 'L';
      TXPDOWNASYNCH1       : in std_ulogic := 'L';
      TXPMASETPHASE0       : in std_ulogic := 'L';
      TXPMASETPHASE1       : in std_ulogic := 'L';
      TXPOLARITY0          : in std_ulogic := 'L';
      TXPOLARITY1          : in std_ulogic := 'L';
      TXPOWERDOWN0         : in std_logic_vector(1 downto 0);
      TXPOWERDOWN1         : in std_logic_vector(1 downto 0);
      TXPRBSFORCEERR0      : in std_ulogic := 'L';
      TXPRBSFORCEERR1      : in std_ulogic := 'L';
      TXPREEMPHASIS0       : in std_logic_vector(2 downto 0);
      TXPREEMPHASIS1       : in std_logic_vector(2 downto 0);
      TXRESET0             : in std_ulogic := 'L';
      TXRESET1             : in std_ulogic := 'L';
      TXUSRCLK0            : in std_ulogic := 'L';
      TXUSRCLK1            : in std_ulogic := 'L';
      TXUSRCLK20           : in std_ulogic := 'L';
      TXUSRCLK21           : in std_ulogic := 'L';
      USRCODEERR0          : in std_ulogic := 'L';
      USRCODEERR1          : in std_ulogic := 'L'      
    );
    attribute VITAL_LEVEL0 of X_GTPA1_DUAL :     entity is true;
  end X_GTPA1_DUAL;

  architecture X_GTPA1_DUAL_V of X_GTPA1_DUAL is
    TYPE VitalTimingDataArrayType IS ARRAY (NATURAL RANGE <>) OF VitalTimingDataType;
    component GTPA1_DUAL_WRAP
      generic (
        AC_CAP_DIS_0 : string;
        AC_CAP_DIS_1 : string;
        ALIGN_COMMA_WORD_0 : integer;
        ALIGN_COMMA_WORD_1 : integer;
        CB2_INH_CC_PERIOD_0 : integer;
        CB2_INH_CC_PERIOD_1 : integer;
        CDR_PH_ADJ_TIME_0 : string;
        CDR_PH_ADJ_TIME_1 : string;
        CHAN_BOND_1_MAX_SKEW_0 : integer;
        CHAN_BOND_1_MAX_SKEW_1 : integer;
        CHAN_BOND_2_MAX_SKEW_0 : integer;
        CHAN_BOND_2_MAX_SKEW_1 : integer;
        CHAN_BOND_KEEP_ALIGN_0 : string;
        CHAN_BOND_KEEP_ALIGN_1 : string;
        CHAN_BOND_SEQ_1_1_0 : string;
        CHAN_BOND_SEQ_1_1_1 : string;
        CHAN_BOND_SEQ_1_2_0 : string;
        CHAN_BOND_SEQ_1_2_1 : string;
        CHAN_BOND_SEQ_1_3_0 : string;
        CHAN_BOND_SEQ_1_3_1 : string;
        CHAN_BOND_SEQ_1_4_0 : string;
        CHAN_BOND_SEQ_1_4_1 : string;
        CHAN_BOND_SEQ_1_ENABLE_0 : string;
        CHAN_BOND_SEQ_1_ENABLE_1 : string;
        CHAN_BOND_SEQ_2_1_0 : string;
        CHAN_BOND_SEQ_2_1_1 : string;
        CHAN_BOND_SEQ_2_2_0 : string;
        CHAN_BOND_SEQ_2_2_1 : string;
        CHAN_BOND_SEQ_2_3_0 : string;
        CHAN_BOND_SEQ_2_3_1 : string;
        CHAN_BOND_SEQ_2_4_0 : string;
        CHAN_BOND_SEQ_2_4_1 : string;
        CHAN_BOND_SEQ_2_ENABLE_0 : string;
        CHAN_BOND_SEQ_2_ENABLE_1 : string;
        CHAN_BOND_SEQ_2_USE_0 : string;
        CHAN_BOND_SEQ_2_USE_1 : string;
        CHAN_BOND_SEQ_LEN_0 : integer;
        CHAN_BOND_SEQ_LEN_1 : integer;
        CLK25_DIVIDER_0 : integer;
        CLK25_DIVIDER_1 : integer;
        CLKINDC_B_0 : string;
        CLKINDC_B_1 : string;
        CLKRCV_TRST_0 : string;
        CLKRCV_TRST_1 : string;
        CLK_CORRECT_USE_0 : string;
        CLK_CORRECT_USE_1 : string;
        CLK_COR_ADJ_LEN_0 : integer;
        CLK_COR_ADJ_LEN_1 : integer;
        CLK_COR_DET_LEN_0 : integer;
        CLK_COR_DET_LEN_1 : integer;
        CLK_COR_INSERT_IDLE_FLAG_0 : string;
        CLK_COR_INSERT_IDLE_FLAG_1 : string;
        CLK_COR_KEEP_IDLE_0 : string;
        CLK_COR_KEEP_IDLE_1 : string;
        CLK_COR_MAX_LAT_0 : integer;
        CLK_COR_MAX_LAT_1 : integer;
        CLK_COR_MIN_LAT_0 : integer;
        CLK_COR_MIN_LAT_1 : integer;
        CLK_COR_PRECEDENCE_0 : string;
        CLK_COR_PRECEDENCE_1 : string;
        CLK_COR_REPEAT_WAIT_0 : integer;
        CLK_COR_REPEAT_WAIT_1 : integer;
        CLK_COR_SEQ_1_1_0 : string;
        CLK_COR_SEQ_1_1_1 : string;
        CLK_COR_SEQ_1_2_0 : string;
        CLK_COR_SEQ_1_2_1 : string;
        CLK_COR_SEQ_1_3_0 : string;
        CLK_COR_SEQ_1_3_1 : string;
        CLK_COR_SEQ_1_4_0 : string;
        CLK_COR_SEQ_1_4_1 : string;
        CLK_COR_SEQ_1_ENABLE_0 : string;
        CLK_COR_SEQ_1_ENABLE_1 : string;
        CLK_COR_SEQ_2_1_0 : string;
        CLK_COR_SEQ_2_1_1 : string;
        CLK_COR_SEQ_2_2_0 : string;
        CLK_COR_SEQ_2_2_1 : string;
        CLK_COR_SEQ_2_3_0 : string;
        CLK_COR_SEQ_2_3_1 : string;
        CLK_COR_SEQ_2_4_0 : string;
        CLK_COR_SEQ_2_4_1 : string;
        CLK_COR_SEQ_2_ENABLE_0 : string;
        CLK_COR_SEQ_2_ENABLE_1 : string;
        CLK_COR_SEQ_2_USE_0 : string;
        CLK_COR_SEQ_2_USE_1 : string;
        CLK_OUT_GTP_SEL_0 : string;
        CLK_OUT_GTP_SEL_1 : string;
        CM_TRIM_0 : string;
        CM_TRIM_1 : string;
        COMMA_10B_ENABLE_0 : string;
        COMMA_10B_ENABLE_1 : string;
        COM_BURST_VAL_0 : string;
        COM_BURST_VAL_1 : string;
        DEC_MCOMMA_DETECT_0 : string;
        DEC_MCOMMA_DETECT_1 : string;
        DEC_PCOMMA_DETECT_0 : string;
        DEC_PCOMMA_DETECT_1 : string;
        DEC_VALID_COMMA_ONLY_0 : string;
        DEC_VALID_COMMA_ONLY_1 : string;
        GTP_CFG_PWRUP_0 : string;
        GTP_CFG_PWRUP_1 : string;
        MCOMMA_10B_VALUE_0 : string;
        MCOMMA_10B_VALUE_1 : string;
        MCOMMA_DETECT_0 : string;
        MCOMMA_DETECT_1 : string;
        OOBDETECT_THRESHOLD_0 : string;
        OOBDETECT_THRESHOLD_1 : string;
        OOB_CLK_DIVIDER_0 : integer;
        OOB_CLK_DIVIDER_1 : integer;
        PCI_EXPRESS_MODE_0 : string;
        PCI_EXPRESS_MODE_1 : string;
        PCOMMA_10B_VALUE_0 : string;
        PCOMMA_10B_VALUE_1 : string;
        PCOMMA_DETECT_0 : string;
        PCOMMA_DETECT_1 : string;
        PLLLKDET_CFG_0 : string;
        PLLLKDET_CFG_1 : string;
        PLL_COM_CFG_0 : string;
        PLL_COM_CFG_1 : string;
        PLL_CP_CFG_0 : string;
        PLL_CP_CFG_1 : string;
        PLL_DIVSEL_FB_0 : integer;
        PLL_DIVSEL_FB_1 : integer;
        PLL_DIVSEL_REF_0 : integer;
        PLL_DIVSEL_REF_1 : integer;
        PLL_RXDIVSEL_OUT_0 : integer;
        PLL_RXDIVSEL_OUT_1 : integer;
        PLL_SATA_0 : string;
        PLL_SATA_1 : string;
        PLL_SOURCE_0 : string;
        PLL_SOURCE_1 : string;
        PLL_TXDIVSEL_OUT_0 : integer;
        PLL_TXDIVSEL_OUT_1 : integer;
        PMA_CDR_SCAN_0 : string;
        PMA_CDR_SCAN_1 : string;
        PMA_COM_CFG_EAST : string;
        PMA_COM_CFG_WEST : string;
        PMA_RXSYNC_CFG_0 : string;
        PMA_RXSYNC_CFG_1 : string;
        PMA_RX_CFG_0 : string;
        PMA_RX_CFG_1 : string;
        PMA_TX_CFG_0 : string;
        PMA_TX_CFG_1 : string;
        RCV_TERM_GND_0 : string;
        RCV_TERM_GND_1 : string;
        RCV_TERM_VTTRX_0 : string;
        RCV_TERM_VTTRX_1 : string;
        RXEQ_CFG_0 : string;
        RXEQ_CFG_1 : string;
        RXPRBSERR_LOOPBACK_0 : string;
        RXPRBSERR_LOOPBACK_1 : string;
        RX_BUFFER_USE_0 : string;
        RX_BUFFER_USE_1 : string;
        RX_DECODE_SEQ_MATCH_0 : string;
        RX_DECODE_SEQ_MATCH_1 : string;
        RX_EN_IDLE_HOLD_CDR_0 : string;
        RX_EN_IDLE_HOLD_CDR_1 : string;
        RX_EN_IDLE_RESET_BUF_0 : string;
        RX_EN_IDLE_RESET_BUF_1 : string;
        RX_EN_IDLE_RESET_FR_0 : string;
        RX_EN_IDLE_RESET_FR_1 : string;
        RX_EN_IDLE_RESET_PH_0 : string;
        RX_EN_IDLE_RESET_PH_1 : string;
        RX_EN_MODE_RESET_BUF_0 : string;
        RX_EN_MODE_RESET_BUF_1 : string;
        RX_IDLE_HI_CNT_0 : string;
        RX_IDLE_HI_CNT_1 : string;
        RX_IDLE_LO_CNT_0 : string;
        RX_IDLE_LO_CNT_1 : string;
        RX_LOSS_OF_SYNC_FSM_0 : string;
        RX_LOSS_OF_SYNC_FSM_1 : string;
        RX_LOS_INVALID_INCR_0 : integer;
        RX_LOS_INVALID_INCR_1 : integer;
        RX_LOS_THRESHOLD_0 : integer;
        RX_LOS_THRESHOLD_1 : integer;
        RX_SLIDE_MODE_0 : string;
        RX_SLIDE_MODE_1 : string;
        RX_STATUS_FMT_0 : string;
        RX_STATUS_FMT_1 : string;
        RX_XCLK_SEL_0 : string;
        RX_XCLK_SEL_1 : string;
        SATA_BURST_VAL_0 : string;
        SATA_BURST_VAL_1 : string;
        SATA_IDLE_VAL_0 : string;
        SATA_IDLE_VAL_1 : string;
        SATA_MAX_BURST_0 : integer;
        SATA_MAX_BURST_1 : integer;
        SATA_MAX_INIT_0 : integer;
        SATA_MAX_INIT_1 : integer;
        SATA_MAX_WAKE_0 : integer;
        SATA_MAX_WAKE_1 : integer;
        SATA_MIN_BURST_0 : integer;
        SATA_MIN_BURST_1 : integer;
        SATA_MIN_INIT_0 : integer;
        SATA_MIN_INIT_1 : integer;
        SATA_MIN_WAKE_0 : integer;
        SATA_MIN_WAKE_1 : integer;
        SIM_GTPRESET_SPEEDUP : integer;
        SIM_RECEIVER_DETECT_PASS : string;
        SIM_REFCLK0_SOURCE : string;
        SIM_REFCLK1_SOURCE : string;
        SIM_TX_ELEC_IDLE_LEVEL : string;
        SIM_VERSION : string;
        TERMINATION_CTRL_0 : string;
        TERMINATION_CTRL_1 : string;
        TERMINATION_OVRD_0 : string;
        TERMINATION_OVRD_1 : string;
        TRANS_TIME_FROM_P2_0 : string;
        TRANS_TIME_FROM_P2_1 : string;
        TRANS_TIME_NON_P2_0 : string;
        TRANS_TIME_NON_P2_1 : string;
        TRANS_TIME_TO_P2_0 : string;
        TRANS_TIME_TO_P2_1 : string;
        TST_ATTR_0 : string;
        TST_ATTR_1 : string;
        TXRX_INVERT_0 : string;
        TXRX_INVERT_1 : string;
        TX_BUFFER_USE_0 : string;
        TX_BUFFER_USE_1 : string;
        TX_DETECT_RX_CFG_0 : string;
        TX_DETECT_RX_CFG_1 : string;
        TX_IDLE_DELAY_0 : string;
        TX_IDLE_DELAY_1 : string;
        TX_TDCC_CFG_0 : string;
        TX_TDCC_CFG_1 : string;
        TX_XCLK_SEL_0 : string;
        TX_XCLK_SEL_1 : string        
      );
      
      port (
        DRDY                 : out std_ulogic;
        DRPDO                : out std_logic_vector(15 downto 0);
        GTPCLKFBEAST         : out std_logic_vector(1 downto 0);
        GTPCLKFBWEST         : out std_logic_vector(1 downto 0);
        GTPCLKOUT0           : out std_logic_vector(1 downto 0);
        GTPCLKOUT1           : out std_logic_vector(1 downto 0);
        PHYSTATUS0           : out std_ulogic;
        PHYSTATUS1           : out std_ulogic;
        PLLLKDET0            : out std_ulogic;
        PLLLKDET1            : out std_ulogic;
        RCALOUTEAST          : out std_logic_vector(4 downto 0);
        RCALOUTWEST          : out std_logic_vector(4 downto 0);
        REFCLKOUT0           : out std_ulogic;
        REFCLKOUT1           : out std_ulogic;
        REFCLKPLL0           : out std_ulogic;
        REFCLKPLL1           : out std_ulogic;
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
        RXCHBONDO            : out std_logic_vector(2 downto 0);
        RXCLKCORCNT0         : out std_logic_vector(2 downto 0);
        RXCLKCORCNT1         : out std_logic_vector(2 downto 0);
        RXCOMMADET0          : out std_ulogic;
        RXCOMMADET1          : out std_ulogic;
        RXDATA0              : out std_logic_vector(31 downto 0);
        RXDATA1              : out std_logic_vector(31 downto 0);
        RXDISPERR0           : out std_logic_vector(3 downto 0);
        RXDISPERR1           : out std_logic_vector(3 downto 0);
        RXELECIDLE0          : out std_ulogic;
        RXELECIDLE1          : out std_ulogic;
        RXLOSSOFSYNC0        : out std_logic_vector(1 downto 0);
        RXLOSSOFSYNC1        : out std_logic_vector(1 downto 0);
        RXNOTINTABLE0        : out std_logic_vector(3 downto 0);
        RXNOTINTABLE1        : out std_logic_vector(3 downto 0);
        RXPRBSERR0           : out std_ulogic;
        RXPRBSERR1           : out std_ulogic;
        RXRECCLK0            : out std_ulogic;
        RXRECCLK1            : out std_ulogic;
        RXRUNDISP0           : out std_logic_vector(3 downto 0);
        RXRUNDISP1           : out std_logic_vector(3 downto 0);
        RXSTATUS0            : out std_logic_vector(2 downto 0);
        RXSTATUS1            : out std_logic_vector(2 downto 0);
        RXVALID0             : out std_ulogic;
        RXVALID1             : out std_ulogic;
        TSTOUT0              : out std_logic_vector(4 downto 0);
        TSTOUT1              : out std_logic_vector(4 downto 0);
        TXBUFSTATUS0         : out std_logic_vector(1 downto 0);
        TXBUFSTATUS1         : out std_logic_vector(1 downto 0);
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
        GSR                  : in std_ulogic;
        CLK00                : in std_ulogic;
        CLK01                : in std_ulogic;
        CLK10                : in std_ulogic;
        CLK11                : in std_ulogic;
        CLKINEAST0           : in std_ulogic;
        CLKINEAST1           : in std_ulogic;
        CLKINWEST0           : in std_ulogic;
        CLKINWEST1           : in std_ulogic;
        DADDR                : in std_logic_vector(7 downto 0);
        DCLK                 : in std_ulogic;
        DEN                  : in std_ulogic;
        DI                   : in std_logic_vector(15 downto 0);
        DWE                  : in std_ulogic;
        GATERXELECIDLE0      : in std_ulogic;
        GATERXELECIDLE1      : in std_ulogic;
        GCLK00               : in std_ulogic;
        GCLK01               : in std_ulogic;
        GCLK10               : in std_ulogic;
        GCLK11               : in std_ulogic;
        GTPCLKFBSEL0EAST     : in std_logic_vector(1 downto 0);
        GTPCLKFBSEL0WEST     : in std_logic_vector(1 downto 0);
        GTPCLKFBSEL1EAST     : in std_logic_vector(1 downto 0);
        GTPCLKFBSEL1WEST     : in std_logic_vector(1 downto 0);
        GTPRESET0            : in std_ulogic;
        GTPRESET1            : in std_ulogic;
        GTPTEST0             : in std_logic_vector(7 downto 0);
        GTPTEST1             : in std_logic_vector(7 downto 0);
        IGNORESIGDET0        : in std_ulogic;
        IGNORESIGDET1        : in std_ulogic;
        INTDATAWIDTH0        : in std_ulogic;
        INTDATAWIDTH1        : in std_ulogic;
        LOOPBACK0            : in std_logic_vector(2 downto 0);
        LOOPBACK1            : in std_logic_vector(2 downto 0);
        PLLCLK00             : in std_ulogic;
        PLLCLK01             : in std_ulogic;
        PLLCLK10             : in std_ulogic;
        PLLCLK11             : in std_ulogic;
        PLLLKDETEN0          : in std_ulogic;
        PLLLKDETEN1          : in std_ulogic;
        PLLPOWERDOWN0        : in std_ulogic;
        PLLPOWERDOWN1        : in std_ulogic;
        PRBSCNTRESET0        : in std_ulogic;
        PRBSCNTRESET1        : in std_ulogic;
        RCALINEAST           : in std_logic_vector(4 downto 0);
        RCALINWEST           : in std_logic_vector(4 downto 0);
        REFCLKPWRDNB0        : in std_ulogic;
        REFCLKPWRDNB1        : in std_ulogic;
        REFSELDYPLL0         : in std_logic_vector(2 downto 0);
        REFSELDYPLL1         : in std_logic_vector(2 downto 0);
        RXBUFRESET0          : in std_ulogic;
        RXBUFRESET1          : in std_ulogic;
        RXCDRRESET0          : in std_ulogic;
        RXCDRRESET1          : in std_ulogic;
        RXCHBONDI            : in std_logic_vector(2 downto 0);
        RXCHBONDMASTER0      : in std_ulogic;
        RXCHBONDMASTER1      : in std_ulogic;
        RXCHBONDSLAVE0       : in std_ulogic;
        RXCHBONDSLAVE1       : in std_ulogic;
        RXCOMMADETUSE0       : in std_ulogic;
        RXCOMMADETUSE1       : in std_ulogic;
        RXDATAWIDTH0         : in std_logic_vector(1 downto 0);
        RXDATAWIDTH1         : in std_logic_vector(1 downto 0);
        RXDEC8B10BUSE0       : in std_ulogic;
        RXDEC8B10BUSE1       : in std_ulogic;
        RXENCHANSYNC0        : in std_ulogic;
        RXENCHANSYNC1        : in std_ulogic;
        RXENMCOMMAALIGN0     : in std_ulogic;
        RXENMCOMMAALIGN1     : in std_ulogic;
        RXENPCOMMAALIGN0     : in std_ulogic;
        RXENPCOMMAALIGN1     : in std_ulogic;
        RXENPMAPHASEALIGN0   : in std_ulogic;
        RXENPMAPHASEALIGN1   : in std_ulogic;
        RXENPRBSTST0         : in std_logic_vector(2 downto 0);
        RXENPRBSTST1         : in std_logic_vector(2 downto 0);
        RXEQMIX0             : in std_logic_vector(1 downto 0);
        RXEQMIX1             : in std_logic_vector(1 downto 0);
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
        TSTCLK0              : in std_ulogic;
        TSTCLK1              : in std_ulogic;
        TSTIN0               : in std_logic_vector(11 downto 0);
        TSTIN1               : in std_logic_vector(11 downto 0);
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
        TXDIFFCTRL0          : in std_logic_vector(3 downto 0);
        TXDIFFCTRL1          : in std_logic_vector(3 downto 0);
        TXELECIDLE0          : in std_ulogic;
        TXELECIDLE1          : in std_ulogic;
        TXENC8B10BUSE0       : in std_ulogic;
        TXENC8B10BUSE1       : in std_ulogic;
        TXENPMAPHASEALIGN0   : in std_ulogic;
        TXENPMAPHASEALIGN1   : in std_ulogic;
        TXENPRBSTST0         : in std_logic_vector(2 downto 0);
        TXENPRBSTST1         : in std_logic_vector(2 downto 0);
        TXINHIBIT0           : in std_ulogic;
        TXINHIBIT1           : in std_ulogic;
        TXPDOWNASYNCH0       : in std_ulogic;
        TXPDOWNASYNCH1       : in std_ulogic;
        TXPMASETPHASE0       : in std_ulogic;
        TXPMASETPHASE1       : in std_ulogic;
        TXPOLARITY0          : in std_ulogic;
        TXPOLARITY1          : in std_ulogic;
        TXPOWERDOWN0         : in std_logic_vector(1 downto 0);
        TXPOWERDOWN1         : in std_logic_vector(1 downto 0);
        TXPRBSFORCEERR0      : in std_ulogic;
        TXPRBSFORCEERR1      : in std_ulogic;
        TXPREEMPHASIS0       : in std_logic_vector(2 downto 0);
        TXPREEMPHASIS1       : in std_logic_vector(2 downto 0);
        TXRESET0             : in std_ulogic;
        TXRESET1             : in std_ulogic;
        TXUSRCLK0            : in std_ulogic;
        TXUSRCLK1            : in std_ulogic;
        TXUSRCLK20           : in std_ulogic;
        TXUSRCLK21           : in std_ulogic;
        USRCODEERR0          : in std_ulogic;
        USRCODEERR1          : in std_ulogic        
      );
    end component;
    
    constant IN_DELAY : time := 0 ps;
    constant OUT_DELAY : time := 0 ps;
    constant INCLK_DELAY : time := 0 ps;
    constant OUTCLK_DELAY : time := 0 ps;

function SUL_TO_STR (sul : std_ulogic)
    return string is
    begin
    if sul = '0' then
        return "0";
      else
        return "1";
      end if;
    end SUL_TO_STR;


function boolean_to_string(bool: boolean)
    return string is
    begin
      if bool then
        return "TRUE";
      else
        return "FALSE";
      end if;
    end boolean_to_string;

function getstrlength (
           in_vec : std_logic_vector)
    return integer is
     variable string_length : integer;
    begin
     if ((in_vec'length mod 4) = 0) then
      string_length := in_vec'length/4;
    elsif ((in_vec'length mod 4) > 0) then
      string_length := in_vec'length/4 + 1;
    end if;
    return string_length;
    end getstrlength;

    -- Convert bit_vector to std_logic_vector
    constant CDR_PH_ADJ_TIME_0_BINARY : std_logic_vector(4 downto 0) := To_StdLogicVector(CDR_PH_ADJ_TIME_0)(4 downto 0);
    constant CDR_PH_ADJ_TIME_1_BINARY : std_logic_vector(4 downto 0) := To_StdLogicVector(CDR_PH_ADJ_TIME_1)(4 downto 0);
    constant CHAN_BOND_SEQ_1_1_0_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_1_1_0)(9 downto 0);
    constant CHAN_BOND_SEQ_1_1_1_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_1_1_1)(9 downto 0);
    constant CHAN_BOND_SEQ_1_2_0_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_1_2_0)(9 downto 0);
    constant CHAN_BOND_SEQ_1_2_1_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_1_2_1)(9 downto 0);
    constant CHAN_BOND_SEQ_1_3_0_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_1_3_0)(9 downto 0);
    constant CHAN_BOND_SEQ_1_3_1_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_1_3_1)(9 downto 0);
    constant CHAN_BOND_SEQ_1_4_0_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_1_4_0)(9 downto 0);
    constant CHAN_BOND_SEQ_1_4_1_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_1_4_1)(9 downto 0);
    constant CHAN_BOND_SEQ_1_ENABLE_0_BINARY : std_logic_vector(3 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_1_ENABLE_0)(3 downto 0);
    constant CHAN_BOND_SEQ_1_ENABLE_1_BINARY : std_logic_vector(3 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_1_ENABLE_1)(3 downto 0);
    constant CHAN_BOND_SEQ_2_1_0_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_2_1_0)(9 downto 0);
    constant CHAN_BOND_SEQ_2_1_1_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_2_1_1)(9 downto 0);
    constant CHAN_BOND_SEQ_2_2_0_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_2_2_0)(9 downto 0);
    constant CHAN_BOND_SEQ_2_2_1_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_2_2_1)(9 downto 0);
    constant CHAN_BOND_SEQ_2_3_0_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_2_3_0)(9 downto 0);
    constant CHAN_BOND_SEQ_2_3_1_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_2_3_1)(9 downto 0);
    constant CHAN_BOND_SEQ_2_4_0_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_2_4_0)(9 downto 0);
    constant CHAN_BOND_SEQ_2_4_1_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_2_4_1)(9 downto 0);
    constant CHAN_BOND_SEQ_2_ENABLE_0_BINARY : std_logic_vector(3 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_2_ENABLE_0)(3 downto 0);
    constant CHAN_BOND_SEQ_2_ENABLE_1_BINARY : std_logic_vector(3 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_2_ENABLE_1)(3 downto 0);
    constant CLK_COR_SEQ_1_1_0_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_1_1_0)(9 downto 0);
    constant CLK_COR_SEQ_1_1_1_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_1_1_1)(9 downto 0);
    constant CLK_COR_SEQ_1_2_0_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_1_2_0)(9 downto 0);
    constant CLK_COR_SEQ_1_2_1_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_1_2_1)(9 downto 0);
    constant CLK_COR_SEQ_1_3_0_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_1_3_0)(9 downto 0);
    constant CLK_COR_SEQ_1_3_1_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_1_3_1)(9 downto 0);
    constant CLK_COR_SEQ_1_4_0_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_1_4_0)(9 downto 0);
    constant CLK_COR_SEQ_1_4_1_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_1_4_1)(9 downto 0);
    constant CLK_COR_SEQ_1_ENABLE_0_BINARY : std_logic_vector(3 downto 0) := To_StdLogicVector(CLK_COR_SEQ_1_ENABLE_0)(3 downto 0);
    constant CLK_COR_SEQ_1_ENABLE_1_BINARY : std_logic_vector(3 downto 0) := To_StdLogicVector(CLK_COR_SEQ_1_ENABLE_1)(3 downto 0);
    constant CLK_COR_SEQ_2_1_0_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_2_1_0)(9 downto 0);
    constant CLK_COR_SEQ_2_1_1_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_2_1_1)(9 downto 0);
    constant CLK_COR_SEQ_2_2_0_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_2_2_0)(9 downto 0);
    constant CLK_COR_SEQ_2_2_1_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_2_2_1)(9 downto 0);
    constant CLK_COR_SEQ_2_3_0_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_2_3_0)(9 downto 0);
    constant CLK_COR_SEQ_2_3_1_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_2_3_1)(9 downto 0);
    constant CLK_COR_SEQ_2_4_0_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_2_4_0)(9 downto 0);
    constant CLK_COR_SEQ_2_4_1_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_2_4_1)(9 downto 0);
    constant CLK_COR_SEQ_2_ENABLE_0_BINARY : std_logic_vector(3 downto 0) := To_StdLogicVector(CLK_COR_SEQ_2_ENABLE_0)(3 downto 0);
    constant CLK_COR_SEQ_2_ENABLE_1_BINARY : std_logic_vector(3 downto 0) := To_StdLogicVector(CLK_COR_SEQ_2_ENABLE_1)(3 downto 0);
    constant CM_TRIM_0_BINARY : std_logic_vector(1 downto 0) := To_StdLogicVector(CM_TRIM_0)(1 downto 0);
    constant CM_TRIM_1_BINARY : std_logic_vector(1 downto 0) := To_StdLogicVector(CM_TRIM_1)(1 downto 0);
    constant COMMA_10B_ENABLE_0_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(COMMA_10B_ENABLE_0)(9 downto 0);
    constant COMMA_10B_ENABLE_1_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(COMMA_10B_ENABLE_1)(9 downto 0);
    constant COM_BURST_VAL_0_BINARY : std_logic_vector(3 downto 0) := To_StdLogicVector(COM_BURST_VAL_0)(3 downto 0);
    constant COM_BURST_VAL_1_BINARY : std_logic_vector(3 downto 0) := To_StdLogicVector(COM_BURST_VAL_1)(3 downto 0);
    constant MCOMMA_10B_VALUE_0_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(MCOMMA_10B_VALUE_0)(9 downto 0);
    constant MCOMMA_10B_VALUE_1_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(MCOMMA_10B_VALUE_1)(9 downto 0);
    constant OOBDETECT_THRESHOLD_0_BINARY : std_logic_vector(2 downto 0) := To_StdLogicVector(OOBDETECT_THRESHOLD_0)(2 downto 0);
    constant OOBDETECT_THRESHOLD_1_BINARY : std_logic_vector(2 downto 0) := To_StdLogicVector(OOBDETECT_THRESHOLD_1)(2 downto 0);
    constant PCOMMA_10B_VALUE_0_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(PCOMMA_10B_VALUE_0)(9 downto 0);
    constant PCOMMA_10B_VALUE_1_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(PCOMMA_10B_VALUE_1)(9 downto 0);
    constant PLLLKDET_CFG_0_BINARY : std_logic_vector(2 downto 0) := To_StdLogicVector(PLLLKDET_CFG_0)(2 downto 0);
    constant PLLLKDET_CFG_1_BINARY : std_logic_vector(2 downto 0) := To_StdLogicVector(PLLLKDET_CFG_1)(2 downto 0);
    constant PLL_COM_CFG_0_BINARY : std_logic_vector(23 downto 0) := To_StdLogicVector(PLL_COM_CFG_0)(23 downto 0);
    constant PLL_COM_CFG_1_BINARY : std_logic_vector(23 downto 0) := To_StdLogicVector(PLL_COM_CFG_1)(23 downto 0);
    constant PLL_CP_CFG_0_BINARY : std_logic_vector(7 downto 0) := To_StdLogicVector(PLL_CP_CFG_0)(7 downto 0);
    constant PLL_CP_CFG_1_BINARY : std_logic_vector(7 downto 0) := To_StdLogicVector(PLL_CP_CFG_1)(7 downto 0);
    constant PMA_CDR_SCAN_0_BINARY : std_logic_vector(26 downto 0) := To_StdLogicVector(PMA_CDR_SCAN_0)(26 downto 0);
    constant PMA_CDR_SCAN_1_BINARY : std_logic_vector(26 downto 0) := To_StdLogicVector(PMA_CDR_SCAN_1)(26 downto 0);
    constant PMA_COM_CFG_EAST_BINARY : std_logic_vector(35 downto 0) := To_StdLogicVector(PMA_COM_CFG_EAST)(35 downto 0);
    constant PMA_COM_CFG_WEST_BINARY : std_logic_vector(35 downto 0) := To_StdLogicVector(PMA_COM_CFG_WEST)(35 downto 0);
    constant PMA_RXSYNC_CFG_0_BINARY : std_logic_vector(6 downto 0) := To_StdLogicVector(PMA_RXSYNC_CFG_0)(6 downto 0);
    constant PMA_RXSYNC_CFG_1_BINARY : std_logic_vector(6 downto 0) := To_StdLogicVector(PMA_RXSYNC_CFG_1)(6 downto 0);
    constant PMA_RX_CFG_0_BINARY : std_logic_vector(24 downto 0) := To_StdLogicVector(PMA_RX_CFG_0)(24 downto 0);
    constant PMA_RX_CFG_1_BINARY : std_logic_vector(24 downto 0) := To_StdLogicVector(PMA_RX_CFG_1)(24 downto 0);
    constant PMA_TX_CFG_0_BINARY : std_logic_vector(19 downto 0) := To_StdLogicVector(PMA_TX_CFG_0)(19 downto 0);
    constant PMA_TX_CFG_1_BINARY : std_logic_vector(19 downto 0) := To_StdLogicVector(PMA_TX_CFG_1)(19 downto 0);
    constant RXEQ_CFG_0_BINARY : std_logic_vector(7 downto 0) := To_StdLogicVector(RXEQ_CFG_0)(7 downto 0);
    constant RXEQ_CFG_1_BINARY : std_logic_vector(7 downto 0) := To_StdLogicVector(RXEQ_CFG_1)(7 downto 0);
    constant RXPRBSERR_LOOPBACK_0_BINARY : std_ulogic := To_StduLogic(RXPRBSERR_LOOPBACK_0);
    constant RXPRBSERR_LOOPBACK_1_BINARY : std_ulogic := To_StduLogic(RXPRBSERR_LOOPBACK_1);
    constant RX_IDLE_HI_CNT_0_BINARY : std_logic_vector(3 downto 0) := To_StdLogicVector(RX_IDLE_HI_CNT_0)(3 downto 0);
    constant RX_IDLE_HI_CNT_1_BINARY : std_logic_vector(3 downto 0) := To_StdLogicVector(RX_IDLE_HI_CNT_1)(3 downto 0);
    constant RX_IDLE_LO_CNT_0_BINARY : std_logic_vector(3 downto 0) := To_StdLogicVector(RX_IDLE_LO_CNT_0)(3 downto 0);
    constant RX_IDLE_LO_CNT_1_BINARY : std_logic_vector(3 downto 0) := To_StdLogicVector(RX_IDLE_LO_CNT_1)(3 downto 0);
    constant SATA_BURST_VAL_0_BINARY : std_logic_vector(2 downto 0) := To_StdLogicVector(SATA_BURST_VAL_0)(2 downto 0);
    constant SATA_BURST_VAL_1_BINARY : std_logic_vector(2 downto 0) := To_StdLogicVector(SATA_BURST_VAL_1)(2 downto 0);
    constant SATA_IDLE_VAL_0_BINARY : std_logic_vector(2 downto 0) := To_StdLogicVector(SATA_IDLE_VAL_0)(2 downto 0);
    constant SATA_IDLE_VAL_1_BINARY : std_logic_vector(2 downto 0) := To_StdLogicVector(SATA_IDLE_VAL_1)(2 downto 0);
    constant SIM_REFCLK0_SOURCE_BINARY : std_logic_vector(2 downto 0) := To_StdLogicVector(SIM_REFCLK0_SOURCE)(2 downto 0);
    constant SIM_REFCLK1_SOURCE_BINARY : std_logic_vector(2 downto 0) := To_StdLogicVector(SIM_REFCLK1_SOURCE)(2 downto 0);
    constant TERMINATION_CTRL_0_BINARY : std_logic_vector(4 downto 0) := To_StdLogicVector(TERMINATION_CTRL_0)(4 downto 0);
    constant TERMINATION_CTRL_1_BINARY : std_logic_vector(4 downto 0) := To_StdLogicVector(TERMINATION_CTRL_1)(4 downto 0);
    constant TRANS_TIME_FROM_P2_0_BINARY : std_logic_vector(11 downto 0) := To_StdLogicVector(TRANS_TIME_FROM_P2_0)(11 downto 0);
    constant TRANS_TIME_FROM_P2_1_BINARY : std_logic_vector(11 downto 0) := To_StdLogicVector(TRANS_TIME_FROM_P2_1)(11 downto 0);
    constant TRANS_TIME_NON_P2_0_BINARY : std_logic_vector(7 downto 0) := To_StdLogicVector(TRANS_TIME_NON_P2_0)(7 downto 0);
    constant TRANS_TIME_NON_P2_1_BINARY : std_logic_vector(7 downto 0) := To_StdLogicVector(TRANS_TIME_NON_P2_1)(7 downto 0);
    constant TRANS_TIME_TO_P2_0_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(TRANS_TIME_TO_P2_0)(9 downto 0);
    constant TRANS_TIME_TO_P2_1_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(TRANS_TIME_TO_P2_1)(9 downto 0);
    constant TST_ATTR_0_BINARY : std_logic_vector(31 downto 0) := To_StdLogicVector(TST_ATTR_0)(31 downto 0);
    constant TST_ATTR_1_BINARY : std_logic_vector(31 downto 0) := To_StdLogicVector(TST_ATTR_1)(31 downto 0);
    constant TXRX_INVERT_0_BINARY : std_logic_vector(2 downto 0) := To_StdLogicVector(TXRX_INVERT_0)(2 downto 0);
    constant TXRX_INVERT_1_BINARY : std_logic_vector(2 downto 0) := To_StdLogicVector(TXRX_INVERT_1)(2 downto 0);
    constant TX_DETECT_RX_CFG_0_BINARY : std_logic_vector(13 downto 0) := To_StdLogicVector(TX_DETECT_RX_CFG_0)(13 downto 0);
    constant TX_DETECT_RX_CFG_1_BINARY : std_logic_vector(13 downto 0) := To_StdLogicVector(TX_DETECT_RX_CFG_1)(13 downto 0);
    constant TX_IDLE_DELAY_0_BINARY : std_logic_vector(2 downto 0) := To_StdLogicVector(TX_IDLE_DELAY_0)(2 downto 0);
    constant TX_IDLE_DELAY_1_BINARY : std_logic_vector(2 downto 0) := To_StdLogicVector(TX_IDLE_DELAY_1)(2 downto 0);
    constant TX_TDCC_CFG_0_BINARY : std_logic_vector(1 downto 0) := To_StdLogicVector(TX_TDCC_CFG_0)(1 downto 0);
    constant TX_TDCC_CFG_1_BINARY : std_logic_vector(1 downto 0) := To_StdLogicVector(TX_TDCC_CFG_1)(1 downto 0);
    constant CDR_PH_ADJ_TIME_0_STRLEN : integer := getstrlength(CDR_PH_ADJ_TIME_0_BINARY);
    constant CDR_PH_ADJ_TIME_1_STRLEN : integer := getstrlength(CDR_PH_ADJ_TIME_1_BINARY);
    constant CHAN_BOND_SEQ_1_1_0_STRLEN : integer := getstrlength(CHAN_BOND_SEQ_1_1_0_BINARY);
    constant CHAN_BOND_SEQ_1_1_1_STRLEN : integer := getstrlength(CHAN_BOND_SEQ_1_1_1_BINARY);
    constant CHAN_BOND_SEQ_1_2_0_STRLEN : integer := getstrlength(CHAN_BOND_SEQ_1_2_0_BINARY);
    constant CHAN_BOND_SEQ_1_2_1_STRLEN : integer := getstrlength(CHAN_BOND_SEQ_1_2_1_BINARY);
    constant CHAN_BOND_SEQ_1_3_0_STRLEN : integer := getstrlength(CHAN_BOND_SEQ_1_3_0_BINARY);
    constant CHAN_BOND_SEQ_1_3_1_STRLEN : integer := getstrlength(CHAN_BOND_SEQ_1_3_1_BINARY);
    constant CHAN_BOND_SEQ_1_4_0_STRLEN : integer := getstrlength(CHAN_BOND_SEQ_1_4_0_BINARY);
    constant CHAN_BOND_SEQ_1_4_1_STRLEN : integer := getstrlength(CHAN_BOND_SEQ_1_4_1_BINARY);
    constant CHAN_BOND_SEQ_1_ENABLE_0_STRLEN : integer := getstrlength(CHAN_BOND_SEQ_1_ENABLE_0_BINARY);
    constant CHAN_BOND_SEQ_1_ENABLE_1_STRLEN : integer := getstrlength(CHAN_BOND_SEQ_1_ENABLE_1_BINARY);
    constant CHAN_BOND_SEQ_2_1_0_STRLEN : integer := getstrlength(CHAN_BOND_SEQ_2_1_0_BINARY);
    constant CHAN_BOND_SEQ_2_1_1_STRLEN : integer := getstrlength(CHAN_BOND_SEQ_2_1_1_BINARY);
    constant CHAN_BOND_SEQ_2_2_0_STRLEN : integer := getstrlength(CHAN_BOND_SEQ_2_2_0_BINARY);
    constant CHAN_BOND_SEQ_2_2_1_STRLEN : integer := getstrlength(CHAN_BOND_SEQ_2_2_1_BINARY);
    constant CHAN_BOND_SEQ_2_3_0_STRLEN : integer := getstrlength(CHAN_BOND_SEQ_2_3_0_BINARY);
    constant CHAN_BOND_SEQ_2_3_1_STRLEN : integer := getstrlength(CHAN_BOND_SEQ_2_3_1_BINARY);
    constant CHAN_BOND_SEQ_2_4_0_STRLEN : integer := getstrlength(CHAN_BOND_SEQ_2_4_0_BINARY);
    constant CHAN_BOND_SEQ_2_4_1_STRLEN : integer := getstrlength(CHAN_BOND_SEQ_2_4_1_BINARY);
    constant CHAN_BOND_SEQ_2_ENABLE_0_STRLEN : integer := getstrlength(CHAN_BOND_SEQ_2_ENABLE_0_BINARY);
    constant CHAN_BOND_SEQ_2_ENABLE_1_STRLEN : integer := getstrlength(CHAN_BOND_SEQ_2_ENABLE_1_BINARY);
    constant CLK_COR_SEQ_1_1_0_STRLEN : integer := getstrlength(CLK_COR_SEQ_1_1_0_BINARY);
    constant CLK_COR_SEQ_1_1_1_STRLEN : integer := getstrlength(CLK_COR_SEQ_1_1_1_BINARY);
    constant CLK_COR_SEQ_1_2_0_STRLEN : integer := getstrlength(CLK_COR_SEQ_1_2_0_BINARY);
    constant CLK_COR_SEQ_1_2_1_STRLEN : integer := getstrlength(CLK_COR_SEQ_1_2_1_BINARY);
    constant CLK_COR_SEQ_1_3_0_STRLEN : integer := getstrlength(CLK_COR_SEQ_1_3_0_BINARY);
    constant CLK_COR_SEQ_1_3_1_STRLEN : integer := getstrlength(CLK_COR_SEQ_1_3_1_BINARY);
    constant CLK_COR_SEQ_1_4_0_STRLEN : integer := getstrlength(CLK_COR_SEQ_1_4_0_BINARY);
    constant CLK_COR_SEQ_1_4_1_STRLEN : integer := getstrlength(CLK_COR_SEQ_1_4_1_BINARY);
    constant CLK_COR_SEQ_1_ENABLE_0_STRLEN : integer := getstrlength(CLK_COR_SEQ_1_ENABLE_0_BINARY);
    constant CLK_COR_SEQ_1_ENABLE_1_STRLEN : integer := getstrlength(CLK_COR_SEQ_1_ENABLE_1_BINARY);
    constant CLK_COR_SEQ_2_1_0_STRLEN : integer := getstrlength(CLK_COR_SEQ_2_1_0_BINARY);
    constant CLK_COR_SEQ_2_1_1_STRLEN : integer := getstrlength(CLK_COR_SEQ_2_1_1_BINARY);
    constant CLK_COR_SEQ_2_2_0_STRLEN : integer := getstrlength(CLK_COR_SEQ_2_2_0_BINARY);
    constant CLK_COR_SEQ_2_2_1_STRLEN : integer := getstrlength(CLK_COR_SEQ_2_2_1_BINARY);
    constant CLK_COR_SEQ_2_3_0_STRLEN : integer := getstrlength(CLK_COR_SEQ_2_3_0_BINARY);
    constant CLK_COR_SEQ_2_3_1_STRLEN : integer := getstrlength(CLK_COR_SEQ_2_3_1_BINARY);
    constant CLK_COR_SEQ_2_4_0_STRLEN : integer := getstrlength(CLK_COR_SEQ_2_4_0_BINARY);
    constant CLK_COR_SEQ_2_4_1_STRLEN : integer := getstrlength(CLK_COR_SEQ_2_4_1_BINARY);
    constant CLK_COR_SEQ_2_ENABLE_0_STRLEN : integer := getstrlength(CLK_COR_SEQ_2_ENABLE_0_BINARY);
    constant CLK_COR_SEQ_2_ENABLE_1_STRLEN : integer := getstrlength(CLK_COR_SEQ_2_ENABLE_1_BINARY);
    constant CM_TRIM_0_STRLEN : integer := getstrlength(CM_TRIM_0_BINARY);
    constant CM_TRIM_1_STRLEN : integer := getstrlength(CM_TRIM_1_BINARY);
    constant COMMA_10B_ENABLE_0_STRLEN : integer := getstrlength(COMMA_10B_ENABLE_0_BINARY);
    constant COMMA_10B_ENABLE_1_STRLEN : integer := getstrlength(COMMA_10B_ENABLE_1_BINARY);
    constant COM_BURST_VAL_0_STRLEN : integer := getstrlength(COM_BURST_VAL_0_BINARY);
    constant COM_BURST_VAL_1_STRLEN : integer := getstrlength(COM_BURST_VAL_1_BINARY);
    constant MCOMMA_10B_VALUE_0_STRLEN : integer := getstrlength(MCOMMA_10B_VALUE_0_BINARY);
    constant MCOMMA_10B_VALUE_1_STRLEN : integer := getstrlength(MCOMMA_10B_VALUE_1_BINARY);
    constant OOBDETECT_THRESHOLD_0_STRLEN : integer := getstrlength(OOBDETECT_THRESHOLD_0_BINARY);
    constant OOBDETECT_THRESHOLD_1_STRLEN : integer := getstrlength(OOBDETECT_THRESHOLD_1_BINARY);
    constant PCOMMA_10B_VALUE_0_STRLEN : integer := getstrlength(PCOMMA_10B_VALUE_0_BINARY);
    constant PCOMMA_10B_VALUE_1_STRLEN : integer := getstrlength(PCOMMA_10B_VALUE_1_BINARY);
    constant PLLLKDET_CFG_0_STRLEN : integer := getstrlength(PLLLKDET_CFG_0_BINARY);
    constant PLLLKDET_CFG_1_STRLEN : integer := getstrlength(PLLLKDET_CFG_1_BINARY);
    constant PLL_COM_CFG_0_STRLEN : integer := getstrlength(PLL_COM_CFG_0_BINARY);
    constant PLL_COM_CFG_1_STRLEN : integer := getstrlength(PLL_COM_CFG_1_BINARY);
    constant PLL_CP_CFG_0_STRLEN : integer := getstrlength(PLL_CP_CFG_0_BINARY);
    constant PLL_CP_CFG_1_STRLEN : integer := getstrlength(PLL_CP_CFG_1_BINARY);
    constant PMA_CDR_SCAN_0_STRLEN : integer := getstrlength(PMA_CDR_SCAN_0_BINARY);
    constant PMA_CDR_SCAN_1_STRLEN : integer := getstrlength(PMA_CDR_SCAN_1_BINARY);
    constant PMA_COM_CFG_EAST_STRLEN : integer := getstrlength(PMA_COM_CFG_EAST_BINARY);
    constant PMA_COM_CFG_WEST_STRLEN : integer := getstrlength(PMA_COM_CFG_WEST_BINARY);
    constant PMA_RXSYNC_CFG_0_STRLEN : integer := getstrlength(PMA_RXSYNC_CFG_0_BINARY);
    constant PMA_RXSYNC_CFG_1_STRLEN : integer := getstrlength(PMA_RXSYNC_CFG_1_BINARY);
    constant PMA_RX_CFG_0_STRLEN : integer := getstrlength(PMA_RX_CFG_0_BINARY);
    constant PMA_RX_CFG_1_STRLEN : integer := getstrlength(PMA_RX_CFG_1_BINARY);
    constant PMA_TX_CFG_0_STRLEN : integer := getstrlength(PMA_TX_CFG_0_BINARY);
    constant PMA_TX_CFG_1_STRLEN : integer := getstrlength(PMA_TX_CFG_1_BINARY);
    constant RXEQ_CFG_0_STRLEN : integer := getstrlength(RXEQ_CFG_0_BINARY);
    constant RXEQ_CFG_1_STRLEN : integer := getstrlength(RXEQ_CFG_1_BINARY);
--    constant RXPRBSERR_LOOPBACK_0_STRLEN : integer := getstrlength(RXPRBSERR_LOOPBACK_0_BINARY);
--    constant RXPRBSERR_LOOPBACK_1_STRLEN : integer := getstrlength(RXPRBSERR_LOOPBACK_1_BINARY);
    constant RX_IDLE_HI_CNT_0_STRLEN : integer := getstrlength(RX_IDLE_HI_CNT_0_BINARY);
    constant RX_IDLE_HI_CNT_1_STRLEN : integer := getstrlength(RX_IDLE_HI_CNT_1_BINARY);
    constant RX_IDLE_LO_CNT_0_STRLEN : integer := getstrlength(RX_IDLE_LO_CNT_0_BINARY);
    constant RX_IDLE_LO_CNT_1_STRLEN : integer := getstrlength(RX_IDLE_LO_CNT_1_BINARY);
    constant SATA_BURST_VAL_0_STRLEN : integer := getstrlength(SATA_BURST_VAL_0_BINARY);
    constant SATA_BURST_VAL_1_STRLEN : integer := getstrlength(SATA_BURST_VAL_1_BINARY);
    constant SATA_IDLE_VAL_0_STRLEN : integer := getstrlength(SATA_IDLE_VAL_0_BINARY);
    constant SATA_IDLE_VAL_1_STRLEN : integer := getstrlength(SATA_IDLE_VAL_1_BINARY);
    constant SIM_REFCLK0_SOURCE_STRLEN : integer := getstrlength(SIM_REFCLK0_SOURCE_BINARY);
    constant SIM_REFCLK1_SOURCE_STRLEN : integer := getstrlength(SIM_REFCLK1_SOURCE_BINARY);
    constant TERMINATION_CTRL_0_STRLEN : integer := getstrlength(TERMINATION_CTRL_0_BINARY);
    constant TERMINATION_CTRL_1_STRLEN : integer := getstrlength(TERMINATION_CTRL_1_BINARY);
    constant TRANS_TIME_FROM_P2_0_STRLEN : integer := getstrlength(TRANS_TIME_FROM_P2_0_BINARY);
    constant TRANS_TIME_FROM_P2_1_STRLEN : integer := getstrlength(TRANS_TIME_FROM_P2_1_BINARY);
    constant TRANS_TIME_NON_P2_0_STRLEN : integer := getstrlength(TRANS_TIME_NON_P2_0_BINARY);
    constant TRANS_TIME_NON_P2_1_STRLEN : integer := getstrlength(TRANS_TIME_NON_P2_1_BINARY);
    constant TRANS_TIME_TO_P2_0_STRLEN : integer := getstrlength(TRANS_TIME_TO_P2_0_BINARY);
    constant TRANS_TIME_TO_P2_1_STRLEN : integer := getstrlength(TRANS_TIME_TO_P2_1_BINARY);
    constant TST_ATTR_0_STRLEN : integer := getstrlength(TST_ATTR_0_BINARY);
    constant TST_ATTR_1_STRLEN : integer := getstrlength(TST_ATTR_1_BINARY);
    constant TXRX_INVERT_0_STRLEN : integer := getstrlength(TXRX_INVERT_0_BINARY);
    constant TXRX_INVERT_1_STRLEN : integer := getstrlength(TXRX_INVERT_1_BINARY);
    constant TX_DETECT_RX_CFG_0_STRLEN : integer := getstrlength(TX_DETECT_RX_CFG_0_BINARY);
    constant TX_DETECT_RX_CFG_1_STRLEN : integer := getstrlength(TX_DETECT_RX_CFG_1_BINARY);
    constant TX_IDLE_DELAY_0_STRLEN : integer := getstrlength(TX_IDLE_DELAY_0_BINARY);
    constant TX_IDLE_DELAY_1_STRLEN : integer := getstrlength(TX_IDLE_DELAY_1_BINARY);
    constant TX_TDCC_CFG_0_STRLEN : integer := getstrlength(TX_TDCC_CFG_0_BINARY);
    constant TX_TDCC_CFG_1_STRLEN : integer := getstrlength(TX_TDCC_CFG_1_BINARY);
    
    -- Convert std_logic_vector to string
    constant CDR_PH_ADJ_TIME_0_STRING : string := SLV_TO_HEX(CDR_PH_ADJ_TIME_0_BINARY, CDR_PH_ADJ_TIME_0_STRLEN);
    constant CDR_PH_ADJ_TIME_1_STRING : string := SLV_TO_HEX(CDR_PH_ADJ_TIME_1_BINARY, CDR_PH_ADJ_TIME_1_STRLEN);
    constant CHAN_BOND_SEQ_1_1_0_STRING : string := SLV_TO_HEX(CHAN_BOND_SEQ_1_1_0_BINARY, CHAN_BOND_SEQ_1_1_0_STRLEN);
    constant CHAN_BOND_SEQ_1_1_1_STRING : string := SLV_TO_HEX(CHAN_BOND_SEQ_1_1_1_BINARY, CHAN_BOND_SEQ_1_1_1_STRLEN);
    constant CHAN_BOND_SEQ_1_2_0_STRING : string := SLV_TO_HEX(CHAN_BOND_SEQ_1_2_0_BINARY, CHAN_BOND_SEQ_1_2_0_STRLEN);
    constant CHAN_BOND_SEQ_1_2_1_STRING : string := SLV_TO_HEX(CHAN_BOND_SEQ_1_2_1_BINARY, CHAN_BOND_SEQ_1_2_1_STRLEN);
    constant CHAN_BOND_SEQ_1_3_0_STRING : string := SLV_TO_HEX(CHAN_BOND_SEQ_1_3_0_BINARY, CHAN_BOND_SEQ_1_3_0_STRLEN);
    constant CHAN_BOND_SEQ_1_3_1_STRING : string := SLV_TO_HEX(CHAN_BOND_SEQ_1_3_1_BINARY, CHAN_BOND_SEQ_1_3_1_STRLEN);
    constant CHAN_BOND_SEQ_1_4_0_STRING : string := SLV_TO_HEX(CHAN_BOND_SEQ_1_4_0_BINARY, CHAN_BOND_SEQ_1_4_0_STRLEN);
    constant CHAN_BOND_SEQ_1_4_1_STRING : string := SLV_TO_HEX(CHAN_BOND_SEQ_1_4_1_BINARY, CHAN_BOND_SEQ_1_4_1_STRLEN);
    constant CHAN_BOND_SEQ_1_ENABLE_0_STRING : string := SLV_TO_HEX(CHAN_BOND_SEQ_1_ENABLE_0_BINARY, CHAN_BOND_SEQ_1_ENABLE_0_STRLEN);
    constant CHAN_BOND_SEQ_1_ENABLE_1_STRING : string := SLV_TO_HEX(CHAN_BOND_SEQ_1_ENABLE_1_BINARY, CHAN_BOND_SEQ_1_ENABLE_1_STRLEN);
    constant CHAN_BOND_SEQ_2_1_0_STRING : string := SLV_TO_HEX(CHAN_BOND_SEQ_2_1_0_BINARY, CHAN_BOND_SEQ_2_1_0_STRLEN);
    constant CHAN_BOND_SEQ_2_1_1_STRING : string := SLV_TO_HEX(CHAN_BOND_SEQ_2_1_1_BINARY, CHAN_BOND_SEQ_2_1_1_STRLEN);
    constant CHAN_BOND_SEQ_2_2_0_STRING : string := SLV_TO_HEX(CHAN_BOND_SEQ_2_2_0_BINARY, CHAN_BOND_SEQ_2_2_0_STRLEN);
    constant CHAN_BOND_SEQ_2_2_1_STRING : string := SLV_TO_HEX(CHAN_BOND_SEQ_2_2_1_BINARY, CHAN_BOND_SEQ_2_2_1_STRLEN);
    constant CHAN_BOND_SEQ_2_3_0_STRING : string := SLV_TO_HEX(CHAN_BOND_SEQ_2_3_0_BINARY, CHAN_BOND_SEQ_2_3_0_STRLEN);
    constant CHAN_BOND_SEQ_2_3_1_STRING : string := SLV_TO_HEX(CHAN_BOND_SEQ_2_3_1_BINARY, CHAN_BOND_SEQ_2_3_1_STRLEN);
    constant CHAN_BOND_SEQ_2_4_0_STRING : string := SLV_TO_HEX(CHAN_BOND_SEQ_2_4_0_BINARY, CHAN_BOND_SEQ_2_4_0_STRLEN);
    constant CHAN_BOND_SEQ_2_4_1_STRING : string := SLV_TO_HEX(CHAN_BOND_SEQ_2_4_1_BINARY, CHAN_BOND_SEQ_2_4_1_STRLEN);
    constant CHAN_BOND_SEQ_2_ENABLE_0_STRING : string := SLV_TO_HEX(CHAN_BOND_SEQ_2_ENABLE_0_BINARY, CHAN_BOND_SEQ_2_ENABLE_0_STRLEN);
    constant CHAN_BOND_SEQ_2_ENABLE_1_STRING : string := SLV_TO_HEX(CHAN_BOND_SEQ_2_ENABLE_1_BINARY, CHAN_BOND_SEQ_2_ENABLE_1_STRLEN);
    constant CLK_COR_SEQ_1_1_0_STRING : string := SLV_TO_HEX(CLK_COR_SEQ_1_1_0_BINARY, CLK_COR_SEQ_1_1_0_STRLEN);
    constant CLK_COR_SEQ_1_1_1_STRING : string := SLV_TO_HEX(CLK_COR_SEQ_1_1_1_BINARY, CLK_COR_SEQ_1_1_1_STRLEN);
    constant CLK_COR_SEQ_1_2_0_STRING : string := SLV_TO_HEX(CLK_COR_SEQ_1_2_0_BINARY, CLK_COR_SEQ_1_2_0_STRLEN);
    constant CLK_COR_SEQ_1_2_1_STRING : string := SLV_TO_HEX(CLK_COR_SEQ_1_2_1_BINARY, CLK_COR_SEQ_1_2_1_STRLEN);
    constant CLK_COR_SEQ_1_3_0_STRING : string := SLV_TO_HEX(CLK_COR_SEQ_1_3_0_BINARY, CLK_COR_SEQ_1_3_0_STRLEN);
    constant CLK_COR_SEQ_1_3_1_STRING : string := SLV_TO_HEX(CLK_COR_SEQ_1_3_1_BINARY, CLK_COR_SEQ_1_3_1_STRLEN);
    constant CLK_COR_SEQ_1_4_0_STRING : string := SLV_TO_HEX(CLK_COR_SEQ_1_4_0_BINARY, CLK_COR_SEQ_1_4_0_STRLEN);
    constant CLK_COR_SEQ_1_4_1_STRING : string := SLV_TO_HEX(CLK_COR_SEQ_1_4_1_BINARY, CLK_COR_SEQ_1_4_1_STRLEN);
    constant CLK_COR_SEQ_1_ENABLE_0_STRING : string := SLV_TO_HEX(CLK_COR_SEQ_1_ENABLE_0_BINARY, CLK_COR_SEQ_1_ENABLE_0_STRLEN);
    constant CLK_COR_SEQ_1_ENABLE_1_STRING : string := SLV_TO_HEX(CLK_COR_SEQ_1_ENABLE_1_BINARY, CLK_COR_SEQ_1_ENABLE_1_STRLEN);
    constant CLK_COR_SEQ_2_1_0_STRING : string := SLV_TO_HEX(CLK_COR_SEQ_2_1_0_BINARY, CLK_COR_SEQ_2_1_0_STRLEN);
    constant CLK_COR_SEQ_2_1_1_STRING : string := SLV_TO_HEX(CLK_COR_SEQ_2_1_1_BINARY, CLK_COR_SEQ_2_1_1_STRLEN);
    constant CLK_COR_SEQ_2_2_0_STRING : string := SLV_TO_HEX(CLK_COR_SEQ_2_2_0_BINARY, CLK_COR_SEQ_2_2_0_STRLEN);
    constant CLK_COR_SEQ_2_2_1_STRING : string := SLV_TO_HEX(CLK_COR_SEQ_2_2_1_BINARY, CLK_COR_SEQ_2_2_1_STRLEN);
    constant CLK_COR_SEQ_2_3_0_STRING : string := SLV_TO_HEX(CLK_COR_SEQ_2_3_0_BINARY, CLK_COR_SEQ_2_3_0_STRLEN);
    constant CLK_COR_SEQ_2_3_1_STRING : string := SLV_TO_HEX(CLK_COR_SEQ_2_3_1_BINARY, CLK_COR_SEQ_2_3_1_STRLEN);
    constant CLK_COR_SEQ_2_4_0_STRING : string := SLV_TO_HEX(CLK_COR_SEQ_2_4_0_BINARY, CLK_COR_SEQ_2_4_0_STRLEN);
    constant CLK_COR_SEQ_2_4_1_STRING : string := SLV_TO_HEX(CLK_COR_SEQ_2_4_1_BINARY, CLK_COR_SEQ_2_4_1_STRLEN);
    constant CLK_COR_SEQ_2_ENABLE_0_STRING : string := SLV_TO_HEX(CLK_COR_SEQ_2_ENABLE_0_BINARY, CLK_COR_SEQ_2_ENABLE_0_STRLEN);
    constant CLK_COR_SEQ_2_ENABLE_1_STRING : string := SLV_TO_HEX(CLK_COR_SEQ_2_ENABLE_1_BINARY, CLK_COR_SEQ_2_ENABLE_1_STRLEN);
    constant CM_TRIM_0_STRING : string := SLV_TO_HEX(CM_TRIM_0_BINARY, CM_TRIM_0_STRLEN);
    constant CM_TRIM_1_STRING : string := SLV_TO_HEX(CM_TRIM_1_BINARY, CM_TRIM_1_STRLEN);
    constant COMMA_10B_ENABLE_0_STRING : string := SLV_TO_HEX(COMMA_10B_ENABLE_0_BINARY, COMMA_10B_ENABLE_0_STRLEN);
    constant COMMA_10B_ENABLE_1_STRING : string := SLV_TO_HEX(COMMA_10B_ENABLE_1_BINARY, COMMA_10B_ENABLE_1_STRLEN);
    constant COM_BURST_VAL_0_STRING : string := SLV_TO_HEX(COM_BURST_VAL_0_BINARY, COM_BURST_VAL_0_STRLEN);
    constant COM_BURST_VAL_1_STRING : string := SLV_TO_HEX(COM_BURST_VAL_1_BINARY, COM_BURST_VAL_1_STRLEN);
    constant MCOMMA_10B_VALUE_0_STRING : string := SLV_TO_HEX(MCOMMA_10B_VALUE_0_BINARY, MCOMMA_10B_VALUE_0_STRLEN);
    constant MCOMMA_10B_VALUE_1_STRING : string := SLV_TO_HEX(MCOMMA_10B_VALUE_1_BINARY, MCOMMA_10B_VALUE_1_STRLEN);
    constant OOBDETECT_THRESHOLD_0_STRING : string := SLV_TO_HEX(OOBDETECT_THRESHOLD_0_BINARY, OOBDETECT_THRESHOLD_0_STRLEN);
    constant OOBDETECT_THRESHOLD_1_STRING : string := SLV_TO_HEX(OOBDETECT_THRESHOLD_1_BINARY, OOBDETECT_THRESHOLD_1_STRLEN);
    constant PCOMMA_10B_VALUE_0_STRING : string := SLV_TO_HEX(PCOMMA_10B_VALUE_0_BINARY, PCOMMA_10B_VALUE_0_STRLEN);
    constant PCOMMA_10B_VALUE_1_STRING : string := SLV_TO_HEX(PCOMMA_10B_VALUE_1_BINARY, PCOMMA_10B_VALUE_1_STRLEN);
    constant PLLLKDET_CFG_0_STRING : string := SLV_TO_HEX(PLLLKDET_CFG_0_BINARY, PLLLKDET_CFG_0_STRLEN);
    constant PLLLKDET_CFG_1_STRING : string := SLV_TO_HEX(PLLLKDET_CFG_1_BINARY, PLLLKDET_CFG_1_STRLEN);
    constant PLL_COM_CFG_0_STRING : string := SLV_TO_HEX(PLL_COM_CFG_0_BINARY, PLL_COM_CFG_0_STRLEN);
    constant PLL_COM_CFG_1_STRING : string := SLV_TO_HEX(PLL_COM_CFG_1_BINARY, PLL_COM_CFG_1_STRLEN);
    constant PLL_CP_CFG_0_STRING : string := SLV_TO_HEX(PLL_CP_CFG_0_BINARY, PLL_CP_CFG_0_STRLEN);
    constant PLL_CP_CFG_1_STRING : string := SLV_TO_HEX(PLL_CP_CFG_1_BINARY, PLL_CP_CFG_1_STRLEN);
    constant PMA_CDR_SCAN_0_STRING : string := SLV_TO_HEX(PMA_CDR_SCAN_0_BINARY, PMA_CDR_SCAN_0_STRLEN);
    constant PMA_CDR_SCAN_1_STRING : string := SLV_TO_HEX(PMA_CDR_SCAN_1_BINARY, PMA_CDR_SCAN_1_STRLEN);
    constant PMA_COM_CFG_EAST_STRING : string := SLV_TO_HEX(PMA_COM_CFG_EAST_BINARY, PMA_COM_CFG_EAST_STRLEN);
    constant PMA_COM_CFG_WEST_STRING : string := SLV_TO_HEX(PMA_COM_CFG_WEST_BINARY, PMA_COM_CFG_WEST_STRLEN);
    constant PMA_RXSYNC_CFG_0_STRING : string := SLV_TO_HEX(PMA_RXSYNC_CFG_0_BINARY, PMA_RXSYNC_CFG_0_STRLEN);
    constant PMA_RXSYNC_CFG_1_STRING : string := SLV_TO_HEX(PMA_RXSYNC_CFG_1_BINARY, PMA_RXSYNC_CFG_1_STRLEN);
    constant PMA_RX_CFG_0_STRING : string := SLV_TO_HEX(PMA_RX_CFG_0_BINARY, PMA_RX_CFG_0_STRLEN);
    constant PMA_RX_CFG_1_STRING : string := SLV_TO_HEX(PMA_RX_CFG_1_BINARY, PMA_RX_CFG_1_STRLEN);
    constant PMA_TX_CFG_0_STRING : string := SLV_TO_HEX(PMA_TX_CFG_0_BINARY, PMA_TX_CFG_0_STRLEN);
    constant PMA_TX_CFG_1_STRING : string := SLV_TO_HEX(PMA_TX_CFG_1_BINARY, PMA_TX_CFG_1_STRLEN);
    constant RXEQ_CFG_0_STRING : string := SLV_TO_HEX(RXEQ_CFG_0_BINARY, RXEQ_CFG_0_STRLEN);
    constant RXEQ_CFG_1_STRING : string := SLV_TO_HEX(RXEQ_CFG_1_BINARY, RXEQ_CFG_1_STRLEN);
    constant RXPRBSERR_LOOPBACK_0_STRING : string := SUL_TO_STR(RXPRBSERR_LOOPBACK_0_BINARY);
    constant RXPRBSERR_LOOPBACK_1_STRING : string := SUL_TO_STR(RXPRBSERR_LOOPBACK_1_BINARY);
    constant RX_IDLE_HI_CNT_0_STRING : string := SLV_TO_HEX(RX_IDLE_HI_CNT_0_BINARY, RX_IDLE_HI_CNT_0_STRLEN);
    constant RX_IDLE_HI_CNT_1_STRING : string := SLV_TO_HEX(RX_IDLE_HI_CNT_1_BINARY, RX_IDLE_HI_CNT_1_STRLEN);
    constant RX_IDLE_LO_CNT_0_STRING : string := SLV_TO_HEX(RX_IDLE_LO_CNT_0_BINARY, RX_IDLE_LO_CNT_0_STRLEN);
    constant RX_IDLE_LO_CNT_1_STRING : string := SLV_TO_HEX(RX_IDLE_LO_CNT_1_BINARY, RX_IDLE_LO_CNT_1_STRLEN);
    constant SATA_BURST_VAL_0_STRING : string := SLV_TO_HEX(SATA_BURST_VAL_0_BINARY, SATA_BURST_VAL_0_STRLEN);
    constant SATA_BURST_VAL_1_STRING : string := SLV_TO_HEX(SATA_BURST_VAL_1_BINARY, SATA_BURST_VAL_1_STRLEN);
    constant SATA_IDLE_VAL_0_STRING : string := SLV_TO_HEX(SATA_IDLE_VAL_0_BINARY, SATA_IDLE_VAL_0_STRLEN);
    constant SATA_IDLE_VAL_1_STRING : string := SLV_TO_HEX(SATA_IDLE_VAL_1_BINARY, SATA_IDLE_VAL_1_STRLEN);
    constant SIM_REFCLK0_SOURCE_STRING : string := SLV_TO_HEX(SIM_REFCLK0_SOURCE_BINARY, SIM_REFCLK0_SOURCE_STRLEN);
    constant SIM_REFCLK1_SOURCE_STRING : string := SLV_TO_HEX(SIM_REFCLK1_SOURCE_BINARY, SIM_REFCLK1_SOURCE_STRLEN);
    constant TERMINATION_CTRL_0_STRING : string := SLV_TO_HEX(TERMINATION_CTRL_0_BINARY, TERMINATION_CTRL_0_STRLEN);
    constant TERMINATION_CTRL_1_STRING : string := SLV_TO_HEX(TERMINATION_CTRL_1_BINARY, TERMINATION_CTRL_1_STRLEN);
    constant TRANS_TIME_FROM_P2_0_STRING : string := SLV_TO_HEX(TRANS_TIME_FROM_P2_0_BINARY, TRANS_TIME_FROM_P2_0_STRLEN);
    constant TRANS_TIME_FROM_P2_1_STRING : string := SLV_TO_HEX(TRANS_TIME_FROM_P2_1_BINARY, TRANS_TIME_FROM_P2_1_STRLEN);
    constant TRANS_TIME_NON_P2_0_STRING : string := SLV_TO_HEX(TRANS_TIME_NON_P2_0_BINARY, TRANS_TIME_NON_P2_0_STRLEN);
    constant TRANS_TIME_NON_P2_1_STRING : string := SLV_TO_HEX(TRANS_TIME_NON_P2_1_BINARY, TRANS_TIME_NON_P2_1_STRLEN);
    constant TRANS_TIME_TO_P2_0_STRING : string := SLV_TO_HEX(TRANS_TIME_TO_P2_0_BINARY, TRANS_TIME_TO_P2_0_STRLEN);
    constant TRANS_TIME_TO_P2_1_STRING : string := SLV_TO_HEX(TRANS_TIME_TO_P2_1_BINARY, TRANS_TIME_TO_P2_1_STRLEN);
    constant TST_ATTR_0_STRING : string := SLV_TO_HEX(TST_ATTR_0_BINARY, TST_ATTR_0_STRLEN);
    constant TST_ATTR_1_STRING : string := SLV_TO_HEX(TST_ATTR_1_BINARY, TST_ATTR_1_STRLEN);
    constant TXRX_INVERT_0_STRING : string := SLV_TO_HEX(TXRX_INVERT_0_BINARY, TXRX_INVERT_0_STRLEN);
    constant TXRX_INVERT_1_STRING : string := SLV_TO_HEX(TXRX_INVERT_1_BINARY, TXRX_INVERT_1_STRLEN);
    constant TX_DETECT_RX_CFG_0_STRING : string := SLV_TO_HEX(TX_DETECT_RX_CFG_0_BINARY, TX_DETECT_RX_CFG_0_STRLEN);
    constant TX_DETECT_RX_CFG_1_STRING : string := SLV_TO_HEX(TX_DETECT_RX_CFG_1_BINARY, TX_DETECT_RX_CFG_1_STRLEN);
    constant TX_IDLE_DELAY_0_STRING : string := SLV_TO_HEX(TX_IDLE_DELAY_0_BINARY, TX_IDLE_DELAY_0_STRLEN);
    constant TX_IDLE_DELAY_1_STRING : string := SLV_TO_HEX(TX_IDLE_DELAY_1_BINARY, TX_IDLE_DELAY_1_STRLEN);
    constant TX_TDCC_CFG_0_STRING : string := SLV_TO_HEX(TX_TDCC_CFG_0_BINARY, TX_TDCC_CFG_0_STRLEN);
    constant TX_TDCC_CFG_1_STRING : string := SLV_TO_HEX(TX_TDCC_CFG_1_BINARY, TX_TDCC_CFG_1_STRLEN);
    
    -- Convert boolean to string
    constant AC_CAP_DIS_0_STRING : string := boolean_to_string(AC_CAP_DIS_0);
    constant AC_CAP_DIS_1_STRING : string := boolean_to_string(AC_CAP_DIS_1);
    constant CHAN_BOND_KEEP_ALIGN_0_STRING : string := boolean_to_string(CHAN_BOND_KEEP_ALIGN_0);
    constant CHAN_BOND_KEEP_ALIGN_1_STRING : string := boolean_to_string(CHAN_BOND_KEEP_ALIGN_1);
    constant CHAN_BOND_SEQ_2_USE_0_STRING : string := boolean_to_string(CHAN_BOND_SEQ_2_USE_0);
    constant CHAN_BOND_SEQ_2_USE_1_STRING : string := boolean_to_string(CHAN_BOND_SEQ_2_USE_1);
    constant CLKINDC_B_0_STRING : string := boolean_to_string(CLKINDC_B_0);
    constant CLKINDC_B_1_STRING : string := boolean_to_string(CLKINDC_B_1);
    constant CLKRCV_TRST_0_STRING : string := boolean_to_string(CLKRCV_TRST_0);
    constant CLKRCV_TRST_1_STRING : string := boolean_to_string(CLKRCV_TRST_1);
    constant CLK_CORRECT_USE_0_STRING : string := boolean_to_string(CLK_CORRECT_USE_0);
    constant CLK_CORRECT_USE_1_STRING : string := boolean_to_string(CLK_CORRECT_USE_1);
    constant CLK_COR_INSERT_IDLE_FLAG_0_STRING : string := boolean_to_string(CLK_COR_INSERT_IDLE_FLAG_0);
    constant CLK_COR_INSERT_IDLE_FLAG_1_STRING : string := boolean_to_string(CLK_COR_INSERT_IDLE_FLAG_1);
    constant CLK_COR_KEEP_IDLE_0_STRING : string := boolean_to_string(CLK_COR_KEEP_IDLE_0);
    constant CLK_COR_KEEP_IDLE_1_STRING : string := boolean_to_string(CLK_COR_KEEP_IDLE_1);
    constant CLK_COR_PRECEDENCE_0_STRING : string := boolean_to_string(CLK_COR_PRECEDENCE_0);
    constant CLK_COR_PRECEDENCE_1_STRING : string := boolean_to_string(CLK_COR_PRECEDENCE_1);
    constant CLK_COR_SEQ_2_USE_0_STRING : string := boolean_to_string(CLK_COR_SEQ_2_USE_0);
    constant CLK_COR_SEQ_2_USE_1_STRING : string := boolean_to_string(CLK_COR_SEQ_2_USE_1);
    constant DEC_MCOMMA_DETECT_0_STRING : string := boolean_to_string(DEC_MCOMMA_DETECT_0);
    constant DEC_MCOMMA_DETECT_1_STRING : string := boolean_to_string(DEC_MCOMMA_DETECT_1);
    constant DEC_PCOMMA_DETECT_0_STRING : string := boolean_to_string(DEC_PCOMMA_DETECT_0);
    constant DEC_PCOMMA_DETECT_1_STRING : string := boolean_to_string(DEC_PCOMMA_DETECT_1);
    constant DEC_VALID_COMMA_ONLY_0_STRING : string := boolean_to_string(DEC_VALID_COMMA_ONLY_0);
    constant DEC_VALID_COMMA_ONLY_1_STRING : string := boolean_to_string(DEC_VALID_COMMA_ONLY_1);
    constant GTP_CFG_PWRUP_0_STRING : string := boolean_to_string(GTP_CFG_PWRUP_0);
    constant GTP_CFG_PWRUP_1_STRING : string := boolean_to_string(GTP_CFG_PWRUP_1);
    constant MCOMMA_DETECT_0_STRING : string := boolean_to_string(MCOMMA_DETECT_0);
    constant MCOMMA_DETECT_1_STRING : string := boolean_to_string(MCOMMA_DETECT_1);
    constant PCI_EXPRESS_MODE_0_STRING : string := boolean_to_string(PCI_EXPRESS_MODE_0);
    constant PCI_EXPRESS_MODE_1_STRING : string := boolean_to_string(PCI_EXPRESS_MODE_1);
    constant PCOMMA_DETECT_0_STRING : string := boolean_to_string(PCOMMA_DETECT_0);
    constant PCOMMA_DETECT_1_STRING : string := boolean_to_string(PCOMMA_DETECT_1);
    constant PLL_SATA_0_STRING : string := boolean_to_string(PLL_SATA_0);
    constant PLL_SATA_1_STRING : string := boolean_to_string(PLL_SATA_1);
    constant RCV_TERM_GND_0_STRING : string := boolean_to_string(RCV_TERM_GND_0);
    constant RCV_TERM_GND_1_STRING : string := boolean_to_string(RCV_TERM_GND_1);
    constant RCV_TERM_VTTRX_0_STRING : string := boolean_to_string(RCV_TERM_VTTRX_0);
    constant RCV_TERM_VTTRX_1_STRING : string := boolean_to_string(RCV_TERM_VTTRX_1);
    constant RX_BUFFER_USE_0_STRING : string := boolean_to_string(RX_BUFFER_USE_0);
    constant RX_BUFFER_USE_1_STRING : string := boolean_to_string(RX_BUFFER_USE_1);
    constant RX_DECODE_SEQ_MATCH_0_STRING : string := boolean_to_string(RX_DECODE_SEQ_MATCH_0);
    constant RX_DECODE_SEQ_MATCH_1_STRING : string := boolean_to_string(RX_DECODE_SEQ_MATCH_1);
    constant RX_EN_IDLE_HOLD_CDR_0_STRING : string := boolean_to_string(RX_EN_IDLE_HOLD_CDR_0);
    constant RX_EN_IDLE_HOLD_CDR_1_STRING : string := boolean_to_string(RX_EN_IDLE_HOLD_CDR_1);
    constant RX_EN_IDLE_RESET_BUF_0_STRING : string := boolean_to_string(RX_EN_IDLE_RESET_BUF_0);
    constant RX_EN_IDLE_RESET_BUF_1_STRING : string := boolean_to_string(RX_EN_IDLE_RESET_BUF_1);
    constant RX_EN_IDLE_RESET_FR_0_STRING : string := boolean_to_string(RX_EN_IDLE_RESET_FR_0);
    constant RX_EN_IDLE_RESET_FR_1_STRING : string := boolean_to_string(RX_EN_IDLE_RESET_FR_1);
    constant RX_EN_IDLE_RESET_PH_0_STRING : string := boolean_to_string(RX_EN_IDLE_RESET_PH_0);
    constant RX_EN_IDLE_RESET_PH_1_STRING : string := boolean_to_string(RX_EN_IDLE_RESET_PH_1);
    constant RX_EN_MODE_RESET_BUF_0_STRING : string := boolean_to_string(RX_EN_MODE_RESET_BUF_0);
    constant RX_EN_MODE_RESET_BUF_1_STRING : string := boolean_to_string(RX_EN_MODE_RESET_BUF_1);
    constant RX_LOSS_OF_SYNC_FSM_0_STRING : string := boolean_to_string(RX_LOSS_OF_SYNC_FSM_0);
    constant RX_LOSS_OF_SYNC_FSM_1_STRING : string := boolean_to_string(RX_LOSS_OF_SYNC_FSM_1);
    constant SIM_RECEIVER_DETECT_PASS_STRING : string := boolean_to_string(SIM_RECEIVER_DETECT_PASS);
    constant TERMINATION_OVRD_0_STRING : string := boolean_to_string(TERMINATION_OVRD_0);
    constant TERMINATION_OVRD_1_STRING : string := boolean_to_string(TERMINATION_OVRD_1);
    constant TX_BUFFER_USE_0_STRING : string := boolean_to_string(TX_BUFFER_USE_0);
    constant TX_BUFFER_USE_1_STRING : string := boolean_to_string(TX_BUFFER_USE_1);
    
    signal AC_CAP_DIS_0_BINARY : std_ulogic;
    signal AC_CAP_DIS_1_BINARY : std_ulogic;
    signal ALIGN_COMMA_WORD_0_BINARY : std_ulogic;
    signal ALIGN_COMMA_WORD_1_BINARY : std_ulogic;
    signal CB2_INH_CC_PERIOD_0_BINARY : std_logic_vector(3 downto 0);
    signal CB2_INH_CC_PERIOD_1_BINARY : std_logic_vector(3 downto 0);
    signal CHAN_BOND_1_MAX_SKEW_0_BINARY : std_logic_vector(3 downto 0);
    signal CHAN_BOND_1_MAX_SKEW_1_BINARY : std_logic_vector(3 downto 0);
    signal CHAN_BOND_2_MAX_SKEW_0_BINARY : std_logic_vector(3 downto 0);
    signal CHAN_BOND_2_MAX_SKEW_1_BINARY : std_logic_vector(3 downto 0);
    signal CHAN_BOND_KEEP_ALIGN_0_BINARY : std_ulogic;
    signal CHAN_BOND_KEEP_ALIGN_1_BINARY : std_ulogic;
    signal CHAN_BOND_SEQ_2_USE_0_BINARY : std_ulogic;
    signal CHAN_BOND_SEQ_2_USE_1_BINARY : std_ulogic;
    signal CHAN_BOND_SEQ_LEN_0_BINARY : std_logic_vector(1 downto 0);
    signal CHAN_BOND_SEQ_LEN_1_BINARY : std_logic_vector(1 downto 0);
    signal CLK25_DIVIDER_0_BINARY : std_logic_vector(2 downto 0);
    signal CLK25_DIVIDER_1_BINARY : std_logic_vector(2 downto 0);
    signal CLKINDC_B_0_BINARY : std_ulogic;
    signal CLKINDC_B_1_BINARY : std_ulogic;
    signal CLKRCV_TRST_0_BINARY : std_ulogic;
    signal CLKRCV_TRST_1_BINARY : std_ulogic;
    signal CLK_CORRECT_USE_0_BINARY : std_ulogic;
    signal CLK_CORRECT_USE_1_BINARY : std_ulogic;
    signal CLK_COR_ADJ_LEN_0_BINARY : std_logic_vector(1 downto 0);
    signal CLK_COR_ADJ_LEN_1_BINARY : std_logic_vector(1 downto 0);
    signal CLK_COR_DET_LEN_0_BINARY : std_logic_vector(1 downto 0);
    signal CLK_COR_DET_LEN_1_BINARY : std_logic_vector(1 downto 0);
    signal CLK_COR_INSERT_IDLE_FLAG_0_BINARY : std_ulogic;
    signal CLK_COR_INSERT_IDLE_FLAG_1_BINARY : std_ulogic;
    signal CLK_COR_KEEP_IDLE_0_BINARY : std_ulogic;
    signal CLK_COR_KEEP_IDLE_1_BINARY : std_ulogic;
    signal CLK_COR_MAX_LAT_0_BINARY : std_logic_vector(5 downto 0);
    signal CLK_COR_MAX_LAT_1_BINARY : std_logic_vector(5 downto 0);
    signal CLK_COR_MIN_LAT_0_BINARY : std_logic_vector(5 downto 0);
    signal CLK_COR_MIN_LAT_1_BINARY : std_logic_vector(5 downto 0);
    signal CLK_COR_PRECEDENCE_0_BINARY : std_ulogic;
    signal CLK_COR_PRECEDENCE_1_BINARY : std_ulogic;
    signal CLK_COR_REPEAT_WAIT_0_BINARY : std_logic_vector(4 downto 0);
    signal CLK_COR_REPEAT_WAIT_1_BINARY : std_logic_vector(4 downto 0);
    signal CLK_COR_SEQ_2_USE_0_BINARY : std_ulogic;
    signal CLK_COR_SEQ_2_USE_1_BINARY : std_ulogic;
    signal CLK_OUT_GTP_SEL_0_BINARY : std_ulogic;
    signal CLK_OUT_GTP_SEL_1_BINARY : std_ulogic;
    signal DEC_MCOMMA_DETECT_0_BINARY : std_ulogic;
    signal DEC_MCOMMA_DETECT_1_BINARY : std_ulogic;
    signal DEC_PCOMMA_DETECT_0_BINARY : std_ulogic;
    signal DEC_PCOMMA_DETECT_1_BINARY : std_ulogic;
    signal DEC_VALID_COMMA_ONLY_0_BINARY : std_ulogic;
    signal DEC_VALID_COMMA_ONLY_1_BINARY : std_ulogic;
    signal GTP_CFG_PWRUP_0_BINARY : std_ulogic;
    signal GTP_CFG_PWRUP_1_BINARY : std_ulogic;
    signal MCOMMA_DETECT_0_BINARY : std_ulogic;
    signal MCOMMA_DETECT_1_BINARY : std_ulogic;
    signal OOB_CLK_DIVIDER_0_BINARY : std_logic_vector(2 downto 0);
    signal OOB_CLK_DIVIDER_1_BINARY : std_logic_vector(2 downto 0);
    signal PCI_EXPRESS_MODE_0_BINARY : std_ulogic;
    signal PCI_EXPRESS_MODE_1_BINARY : std_ulogic;
    signal PCOMMA_DETECT_0_BINARY : std_ulogic;
    signal PCOMMA_DETECT_1_BINARY : std_ulogic;
    signal PLL_DIVSEL_FB_0_BINARY : std_logic_vector(4 downto 0);
    signal PLL_DIVSEL_FB_1_BINARY : std_logic_vector(4 downto 0);
    signal PLL_DIVSEL_REF_0_BINARY : std_logic_vector(5 downto 0);
    signal PLL_DIVSEL_REF_1_BINARY : std_logic_vector(5 downto 0);
    signal PLL_RXDIVSEL_OUT_0_BINARY : std_logic_vector(1 downto 0);
    signal PLL_RXDIVSEL_OUT_1_BINARY : std_logic_vector(1 downto 0);
    signal PLL_SATA_0_BINARY : std_ulogic;
    signal PLL_SATA_1_BINARY : std_ulogic;
    signal PLL_SOURCE_0_BINARY : std_ulogic;
    signal PLL_SOURCE_1_BINARY : std_ulogic;
    signal PLL_TXDIVSEL_OUT_0_BINARY : std_logic_vector(1 downto 0);
    signal PLL_TXDIVSEL_OUT_1_BINARY : std_logic_vector(1 downto 0);
    signal RCV_TERM_GND_0_BINARY : std_ulogic;
    signal RCV_TERM_GND_1_BINARY : std_ulogic;
    signal RCV_TERM_VTTRX_0_BINARY : std_ulogic;
    signal RCV_TERM_VTTRX_1_BINARY : std_ulogic;
    signal RX_BUFFER_USE_0_BINARY : std_ulogic;
    signal RX_BUFFER_USE_1_BINARY : std_ulogic;
    signal RX_DECODE_SEQ_MATCH_0_BINARY : std_ulogic;
    signal RX_DECODE_SEQ_MATCH_1_BINARY : std_ulogic;
    signal RX_EN_IDLE_HOLD_CDR_0_BINARY : std_ulogic;
    signal RX_EN_IDLE_HOLD_CDR_1_BINARY : std_ulogic;
    signal RX_EN_IDLE_RESET_BUF_0_BINARY : std_ulogic;
    signal RX_EN_IDLE_RESET_BUF_1_BINARY : std_ulogic;
    signal RX_EN_IDLE_RESET_FR_0_BINARY : std_ulogic;
    signal RX_EN_IDLE_RESET_FR_1_BINARY : std_ulogic;
    signal RX_EN_IDLE_RESET_PH_0_BINARY : std_ulogic;
    signal RX_EN_IDLE_RESET_PH_1_BINARY : std_ulogic;
    signal RX_EN_MODE_RESET_BUF_0_BINARY : std_ulogic;
    signal RX_EN_MODE_RESET_BUF_1_BINARY : std_ulogic;
    signal RX_LOSS_OF_SYNC_FSM_0_BINARY : std_ulogic;
    signal RX_LOSS_OF_SYNC_FSM_1_BINARY : std_ulogic;
    signal RX_LOS_INVALID_INCR_0_BINARY : std_logic_vector(2 downto 0);
    signal RX_LOS_INVALID_INCR_1_BINARY : std_logic_vector(2 downto 0);
    signal RX_LOS_THRESHOLD_0_BINARY : std_logic_vector(2 downto 0);
    signal RX_LOS_THRESHOLD_1_BINARY : std_logic_vector(2 downto 0);
    signal RX_SLIDE_MODE_0_BINARY : std_ulogic;
    signal RX_SLIDE_MODE_1_BINARY : std_ulogic;
    signal RX_STATUS_FMT_0_BINARY : std_ulogic;
    signal RX_STATUS_FMT_1_BINARY : std_ulogic;
    signal RX_XCLK_SEL_0_BINARY : std_ulogic;
    signal RX_XCLK_SEL_1_BINARY : std_ulogic;
    signal SATA_MAX_BURST_0_BINARY : std_logic_vector(5 downto 0);
    signal SATA_MAX_BURST_1_BINARY : std_logic_vector(5 downto 0);
    signal SATA_MAX_INIT_0_BINARY : std_logic_vector(5 downto 0);
    signal SATA_MAX_INIT_1_BINARY : std_logic_vector(5 downto 0);
    signal SATA_MAX_WAKE_0_BINARY : std_logic_vector(5 downto 0);
    signal SATA_MAX_WAKE_1_BINARY : std_logic_vector(5 downto 0);
    signal SATA_MIN_BURST_0_BINARY : std_logic_vector(5 downto 0);
    signal SATA_MIN_BURST_1_BINARY : std_logic_vector(5 downto 0);
    signal SATA_MIN_INIT_0_BINARY : std_logic_vector(5 downto 0);
    signal SATA_MIN_INIT_1_BINARY : std_logic_vector(5 downto 0);
    signal SATA_MIN_WAKE_0_BINARY : std_logic_vector(5 downto 0);
    signal SATA_MIN_WAKE_1_BINARY : std_logic_vector(5 downto 0);
    signal SIM_GTPRESET_SPEEDUP_BINARY : std_ulogic;
    signal SIM_RECEIVER_DETECT_PASS_BINARY : std_ulogic;
    signal SIM_TX_ELEC_IDLE_LEVEL_BINARY : std_ulogic;
    signal SIM_VERSION_BINARY : std_ulogic;
    signal TERMINATION_OVRD_0_BINARY : std_ulogic;
    signal TERMINATION_OVRD_1_BINARY : std_ulogic;
    signal TX_BUFFER_USE_0_BINARY : std_ulogic;
    signal TX_BUFFER_USE_1_BINARY : std_ulogic;
    signal TX_XCLK_SEL_0_BINARY : std_ulogic;
    signal TX_XCLK_SEL_1_BINARY : std_ulogic;
    
    signal DRDY_out : std_ulogic;
    signal DRPDO_out : std_logic_vector(15 downto 0);
    signal GTPCLKFBEAST_out : std_logic_vector(1 downto 0);
    signal GTPCLKFBWEST_out : std_logic_vector(1 downto 0);
    signal GTPCLKOUT0_out : std_logic_vector(1 downto 0);
    signal GTPCLKOUT1_out : std_logic_vector(1 downto 0);
    signal PHYSTATUS0_out : std_ulogic;
    signal PHYSTATUS1_out : std_ulogic;
    signal PLLLKDET0_out : std_ulogic;
    signal PLLLKDET1_out : std_ulogic;
    signal RCALOUTEAST_out : std_logic_vector(4 downto 0);
    signal RCALOUTWEST_out : std_logic_vector(4 downto 0);
    signal REFCLKOUT0_out : std_ulogic;
    signal REFCLKOUT1_out : std_ulogic;
    signal REFCLKPLL0_out : std_ulogic;
    signal REFCLKPLL1_out : std_ulogic;
    signal RESETDONE0_out : std_ulogic;
    signal RESETDONE1_out : std_ulogic;
    signal RXBUFSTATUS0_out : std_logic_vector(2 downto 0);
    signal RXBUFSTATUS1_out : std_logic_vector(2 downto 0);
    signal RXBYTEISALIGNED0_out : std_ulogic;
    signal RXBYTEISALIGNED1_out : std_ulogic;
    signal RXBYTEREALIGN0_out : std_ulogic;
    signal RXBYTEREALIGN1_out : std_ulogic;
    signal RXCHANBONDSEQ0_out : std_ulogic;
    signal RXCHANBONDSEQ1_out : std_ulogic;
    signal RXCHANISALIGNED0_out : std_ulogic;
    signal RXCHANISALIGNED1_out : std_ulogic;
    signal RXCHANREALIGN0_out : std_ulogic;
    signal RXCHANREALIGN1_out : std_ulogic;
    signal RXCHARISCOMMA0_out : std_logic_vector(3 downto 0);
    signal RXCHARISCOMMA1_out : std_logic_vector(3 downto 0);
    signal RXCHARISK0_out : std_logic_vector(3 downto 0);
    signal RXCHARISK1_out : std_logic_vector(3 downto 0);
    signal RXCHBONDO_out : std_logic_vector(2 downto 0);
    signal RXCLKCORCNT0_out : std_logic_vector(2 downto 0);
    signal RXCLKCORCNT1_out : std_logic_vector(2 downto 0);
    signal RXCOMMADET0_out : std_ulogic;
    signal RXCOMMADET1_out : std_ulogic;
    signal RXDATA0_out : std_logic_vector(31 downto 0);
    signal RXDATA1_out : std_logic_vector(31 downto 0);
    signal RXDISPERR0_out : std_logic_vector(3 downto 0);
    signal RXDISPERR1_out : std_logic_vector(3 downto 0);
    signal RXELECIDLE0_out : std_ulogic;
    signal RXELECIDLE1_out : std_ulogic;
    signal RXLOSSOFSYNC0_out : std_logic_vector(1 downto 0);
    signal RXLOSSOFSYNC1_out : std_logic_vector(1 downto 0);
    signal RXNOTINTABLE0_out : std_logic_vector(3 downto 0);
    signal RXNOTINTABLE1_out : std_logic_vector(3 downto 0);
    signal RXPRBSERR0_out : std_ulogic;
    signal RXPRBSERR1_out : std_ulogic;
    signal RXRECCLK0_out : std_ulogic;
    signal RXRECCLK1_out : std_ulogic;
    signal RXRUNDISP0_out : std_logic_vector(3 downto 0);
    signal RXRUNDISP1_out : std_logic_vector(3 downto 0);
    signal RXSTATUS0_out : std_logic_vector(2 downto 0);
    signal RXSTATUS1_out : std_logic_vector(2 downto 0);
    signal RXVALID0_out : std_ulogic;
    signal RXVALID1_out : std_ulogic;
    signal TSTOUT0_out : std_logic_vector(4 downto 0);
    signal TSTOUT1_out : std_logic_vector(4 downto 0);
    signal TXBUFSTATUS0_out : std_logic_vector(1 downto 0);
    signal TXBUFSTATUS1_out : std_logic_vector(1 downto 0);
    signal TXKERR0_out : std_logic_vector(3 downto 0);
    signal TXKERR1_out : std_logic_vector(3 downto 0);
    signal TXN0_out : std_ulogic;
    signal TXN1_out : std_ulogic;
    signal TXOUTCLK0_out : std_ulogic;
    signal TXOUTCLK1_out : std_ulogic;
    signal TXP0_out : std_ulogic;
    signal TXP1_out : std_ulogic;
    signal TXRUNDISP0_out : std_logic_vector(3 downto 0);
    signal TXRUNDISP1_out : std_logic_vector(3 downto 0);
    
    signal DRDY_outdelay : std_ulogic;
    signal DRPDO_outdelay : std_logic_vector(15 downto 0);
    signal GTPCLKFBEAST_outdelay : std_logic_vector(1 downto 0);
    signal GTPCLKFBWEST_outdelay : std_logic_vector(1 downto 0);
    signal GTPCLKOUT0_outdelay : std_logic_vector(1 downto 0);
    signal GTPCLKOUT1_outdelay : std_logic_vector(1 downto 0);
    signal PHYSTATUS0_outdelay : std_ulogic;
    signal PHYSTATUS1_outdelay : std_ulogic;
    signal PLLLKDET0_outdelay : std_ulogic;
    signal PLLLKDET1_outdelay : std_ulogic;
    signal RCALOUTEAST_outdelay : std_logic_vector(4 downto 0);
    signal RCALOUTWEST_outdelay : std_logic_vector(4 downto 0);
    signal REFCLKOUT0_outdelay : std_ulogic;
    signal REFCLKOUT1_outdelay : std_ulogic;
    signal REFCLKPLL0_outdelay : std_ulogic;
    signal REFCLKPLL1_outdelay : std_ulogic;
    signal RESETDONE0_outdelay : std_ulogic;
    signal RESETDONE1_outdelay : std_ulogic;
    signal RXBUFSTATUS0_outdelay : std_logic_vector(2 downto 0);
    signal RXBUFSTATUS1_outdelay : std_logic_vector(2 downto 0);
    signal RXBYTEISALIGNED0_outdelay : std_ulogic;
    signal RXBYTEISALIGNED1_outdelay : std_ulogic;
    signal RXBYTEREALIGN0_outdelay : std_ulogic;
    signal RXBYTEREALIGN1_outdelay : std_ulogic;
    signal RXCHANBONDSEQ0_outdelay : std_ulogic;
    signal RXCHANBONDSEQ1_outdelay : std_ulogic;
    signal RXCHANISALIGNED0_outdelay : std_ulogic;
    signal RXCHANISALIGNED1_outdelay : std_ulogic;
    signal RXCHANREALIGN0_outdelay : std_ulogic;
    signal RXCHANREALIGN1_outdelay : std_ulogic;
    signal RXCHARISCOMMA0_outdelay : std_logic_vector(3 downto 0);
    signal RXCHARISCOMMA1_outdelay : std_logic_vector(3 downto 0);
    signal RXCHARISK0_outdelay : std_logic_vector(3 downto 0);
    signal RXCHARISK1_outdelay : std_logic_vector(3 downto 0);
    signal RXCHBONDO_outdelay : std_logic_vector(2 downto 0);
    signal RXCLKCORCNT0_outdelay : std_logic_vector(2 downto 0);
    signal RXCLKCORCNT1_outdelay : std_logic_vector(2 downto 0);
    signal RXCOMMADET0_outdelay : std_ulogic;
    signal RXCOMMADET1_outdelay : std_ulogic;
    signal RXDATA0_outdelay : std_logic_vector(31 downto 0);
    signal RXDATA1_outdelay : std_logic_vector(31 downto 0);
    signal RXDISPERR0_outdelay : std_logic_vector(3 downto 0);
    signal RXDISPERR1_outdelay : std_logic_vector(3 downto 0);
    signal RXELECIDLE0_outdelay : std_ulogic;
    signal RXELECIDLE1_outdelay : std_ulogic;
    signal RXLOSSOFSYNC0_outdelay : std_logic_vector(1 downto 0);
    signal RXLOSSOFSYNC1_outdelay : std_logic_vector(1 downto 0);
    signal RXNOTINTABLE0_outdelay : std_logic_vector(3 downto 0);
    signal RXNOTINTABLE1_outdelay : std_logic_vector(3 downto 0);
    signal RXPRBSERR0_outdelay : std_ulogic;
    signal RXPRBSERR1_outdelay : std_ulogic;
    signal RXRECCLK0_outdelay : std_ulogic;
    signal RXRECCLK1_outdelay : std_ulogic;
    signal RXRUNDISP0_outdelay : std_logic_vector(3 downto 0);
    signal RXRUNDISP1_outdelay : std_logic_vector(3 downto 0);
    signal RXSTATUS0_outdelay : std_logic_vector(2 downto 0);
    signal RXSTATUS1_outdelay : std_logic_vector(2 downto 0);
    signal RXVALID0_outdelay : std_ulogic;
    signal RXVALID1_outdelay : std_ulogic;
    signal TSTOUT0_outdelay : std_logic_vector(4 downto 0);
    signal TSTOUT1_outdelay : std_logic_vector(4 downto 0);
    signal TXBUFSTATUS0_outdelay : std_logic_vector(1 downto 0);
    signal TXBUFSTATUS1_outdelay : std_logic_vector(1 downto 0);
    signal TXKERR0_outdelay : std_logic_vector(3 downto 0);
    signal TXKERR1_outdelay : std_logic_vector(3 downto 0);
    signal TXN0_outdelay : std_ulogic;
    signal TXN1_outdelay : std_ulogic;
    signal TXOUTCLK0_outdelay : std_ulogic;
    signal TXOUTCLK1_outdelay : std_ulogic;
    signal TXP0_outdelay : std_ulogic;
    signal TXP1_outdelay : std_ulogic;
    signal TXRUNDISP0_outdelay : std_logic_vector(3 downto 0);
    signal TXRUNDISP1_outdelay : std_logic_vector(3 downto 0);
    
    signal CLK00_ipd : std_ulogic;
    signal CLK01_ipd : std_ulogic;
    signal CLK10_ipd : std_ulogic;
    signal CLK11_ipd : std_ulogic;
    signal CLKINEAST0_ipd : std_ulogic;
    signal CLKINEAST1_ipd : std_ulogic;
    signal CLKINWEST0_ipd : std_ulogic;
    signal CLKINWEST1_ipd : std_ulogic;
    signal DADDR_ipd : std_logic_vector(7 downto 0);
    signal DCLK_ipd : std_ulogic;
    signal DEN_ipd : std_ulogic;
    signal DI_ipd : std_logic_vector(15 downto 0);
    signal DWE_ipd : std_ulogic;
    signal GATERXELECIDLE0_ipd : std_ulogic;
    signal GATERXELECIDLE1_ipd : std_ulogic;
    signal GCLK00_ipd : std_ulogic;
    signal GCLK01_ipd : std_ulogic;
    signal GCLK10_ipd : std_ulogic;
    signal GCLK11_ipd : std_ulogic;
    signal GTPCLKFBSEL0EAST_ipd : std_logic_vector(1 downto 0);
    signal GTPCLKFBSEL0WEST_ipd : std_logic_vector(1 downto 0);
    signal GTPCLKFBSEL1EAST_ipd : std_logic_vector(1 downto 0);
    signal GTPCLKFBSEL1WEST_ipd : std_logic_vector(1 downto 0);
    signal GTPRESET0_ipd : std_ulogic;
    signal GTPRESET1_ipd : std_ulogic;
    signal GTPTEST0_ipd : std_logic_vector(7 downto 0);
    signal GTPTEST1_ipd : std_logic_vector(7 downto 0);
    signal IGNORESIGDET0_ipd : std_ulogic;
    signal IGNORESIGDET1_ipd : std_ulogic;
    signal INTDATAWIDTH0_ipd : std_ulogic;
    signal INTDATAWIDTH1_ipd : std_ulogic;
    signal LOOPBACK0_ipd : std_logic_vector(2 downto 0);
    signal LOOPBACK1_ipd : std_logic_vector(2 downto 0);
    signal PLLCLK00_ipd : std_ulogic;
    signal PLLCLK01_ipd : std_ulogic;
    signal PLLCLK10_ipd : std_ulogic;
    signal PLLCLK11_ipd : std_ulogic;
    signal PLLLKDETEN0_ipd : std_ulogic;
    signal PLLLKDETEN1_ipd : std_ulogic;
    signal PLLPOWERDOWN0_ipd : std_ulogic;
    signal PLLPOWERDOWN1_ipd : std_ulogic;
    signal PRBSCNTRESET0_ipd : std_ulogic;
    signal PRBSCNTRESET1_ipd : std_ulogic;
    signal RCALINEAST_ipd : std_logic_vector(4 downto 0);
    signal RCALINWEST_ipd : std_logic_vector(4 downto 0);
    signal REFCLKPWRDNB0_ipd : std_ulogic;
    signal REFCLKPWRDNB1_ipd : std_ulogic;
    signal REFSELDYPLL0_ipd : std_logic_vector(2 downto 0);
    signal REFSELDYPLL1_ipd : std_logic_vector(2 downto 0);
    signal RXBUFRESET0_ipd : std_ulogic;
    signal RXBUFRESET1_ipd : std_ulogic;
    signal RXCDRRESET0_ipd : std_ulogic;
    signal RXCDRRESET1_ipd : std_ulogic;
    signal RXCHBONDI_ipd : std_logic_vector(2 downto 0);
    signal RXCHBONDMASTER0_ipd : std_ulogic;
    signal RXCHBONDMASTER1_ipd : std_ulogic;
    signal RXCHBONDSLAVE0_ipd : std_ulogic;
    signal RXCHBONDSLAVE1_ipd : std_ulogic;
    signal RXCOMMADETUSE0_ipd : std_ulogic;
    signal RXCOMMADETUSE1_ipd : std_ulogic;
    signal RXDATAWIDTH0_ipd : std_logic_vector(1 downto 0);
    signal RXDATAWIDTH1_ipd : std_logic_vector(1 downto 0);
    signal RXDEC8B10BUSE0_ipd : std_ulogic;
    signal RXDEC8B10BUSE1_ipd : std_ulogic;
    signal RXENCHANSYNC0_ipd : std_ulogic;
    signal RXENCHANSYNC1_ipd : std_ulogic;
    signal RXENMCOMMAALIGN0_ipd : std_ulogic;
    signal RXENMCOMMAALIGN1_ipd : std_ulogic;
    signal RXENPCOMMAALIGN0_ipd : std_ulogic;
    signal RXENPCOMMAALIGN1_ipd : std_ulogic;
    signal RXENPMAPHASEALIGN0_ipd : std_ulogic;
    signal RXENPMAPHASEALIGN1_ipd : std_ulogic;
    signal RXENPRBSTST0_ipd : std_logic_vector(2 downto 0);
    signal RXENPRBSTST1_ipd : std_logic_vector(2 downto 0);
    signal RXEQMIX0_ipd : std_logic_vector(1 downto 0);
    signal RXEQMIX1_ipd : std_logic_vector(1 downto 0);
    signal RXN0_ipd : std_ulogic;
    signal RXN1_ipd : std_ulogic;
    signal RXP0_ipd : std_ulogic;
    signal RXP1_ipd : std_ulogic;
    signal RXPMASETPHASE0_ipd : std_ulogic;
    signal RXPMASETPHASE1_ipd : std_ulogic;
    signal RXPOLARITY0_ipd : std_ulogic;
    signal RXPOLARITY1_ipd : std_ulogic;
    signal RXPOWERDOWN0_ipd : std_logic_vector(1 downto 0);
    signal RXPOWERDOWN1_ipd : std_logic_vector(1 downto 0);
    signal RXRESET0_ipd : std_ulogic;
    signal RXRESET1_ipd : std_ulogic;
    signal RXSLIDE0_ipd : std_ulogic;
    signal RXSLIDE1_ipd : std_ulogic;
    signal RXUSRCLK0_ipd : std_ulogic;
    signal RXUSRCLK1_ipd : std_ulogic;
    signal RXUSRCLK20_ipd : std_ulogic;
    signal RXUSRCLK21_ipd : std_ulogic;
    signal TSTCLK0_ipd : std_ulogic;
    signal TSTCLK1_ipd : std_ulogic;
    signal TSTIN0_ipd : std_logic_vector(11 downto 0);
    signal TSTIN1_ipd : std_logic_vector(11 downto 0);
    signal TXBUFDIFFCTRL0_ipd : std_logic_vector(2 downto 0);
    signal TXBUFDIFFCTRL1_ipd : std_logic_vector(2 downto 0);
    signal TXBYPASS8B10B0_ipd : std_logic_vector(3 downto 0);
    signal TXBYPASS8B10B1_ipd : std_logic_vector(3 downto 0);
    signal TXCHARDISPMODE0_ipd : std_logic_vector(3 downto 0);
    signal TXCHARDISPMODE1_ipd : std_logic_vector(3 downto 0);
    signal TXCHARDISPVAL0_ipd : std_logic_vector(3 downto 0);
    signal TXCHARDISPVAL1_ipd : std_logic_vector(3 downto 0);
    signal TXCHARISK0_ipd : std_logic_vector(3 downto 0);
    signal TXCHARISK1_ipd : std_logic_vector(3 downto 0);
    signal TXCOMSTART0_ipd : std_ulogic;
    signal TXCOMSTART1_ipd : std_ulogic;
    signal TXCOMTYPE0_ipd : std_ulogic;
    signal TXCOMTYPE1_ipd : std_ulogic;
    signal TXDATA0_ipd : std_logic_vector(31 downto 0);
    signal TXDATA1_ipd : std_logic_vector(31 downto 0);
    signal TXDATAWIDTH0_ipd : std_logic_vector(1 downto 0);
    signal TXDATAWIDTH1_ipd : std_logic_vector(1 downto 0);
    signal TXDETECTRX0_ipd : std_ulogic;
    signal TXDETECTRX1_ipd : std_ulogic;
    signal TXDIFFCTRL0_ipd : std_logic_vector(3 downto 0);
    signal TXDIFFCTRL1_ipd : std_logic_vector(3 downto 0);
    signal TXELECIDLE0_ipd : std_ulogic;
    signal TXELECIDLE1_ipd : std_ulogic;
    signal TXENC8B10BUSE0_ipd : std_ulogic;
    signal TXENC8B10BUSE1_ipd : std_ulogic;
    signal TXENPMAPHASEALIGN0_ipd : std_ulogic;
    signal TXENPMAPHASEALIGN1_ipd : std_ulogic;
    signal TXENPRBSTST0_ipd : std_logic_vector(2 downto 0);
    signal TXENPRBSTST1_ipd : std_logic_vector(2 downto 0);
    signal TXINHIBIT0_ipd : std_ulogic;
    signal TXINHIBIT1_ipd : std_ulogic;
    signal TXPDOWNASYNCH0_ipd : std_ulogic;
    signal TXPDOWNASYNCH1_ipd : std_ulogic;
    signal TXPMASETPHASE0_ipd : std_ulogic;
    signal TXPMASETPHASE1_ipd : std_ulogic;
    signal TXPOLARITY0_ipd : std_ulogic;
    signal TXPOLARITY1_ipd : std_ulogic;
    signal TXPOWERDOWN0_ipd : std_logic_vector(1 downto 0);
    signal TXPOWERDOWN1_ipd : std_logic_vector(1 downto 0);
    signal TXPRBSFORCEERR0_ipd : std_ulogic;
    signal TXPRBSFORCEERR1_ipd : std_ulogic;
    signal TXPREEMPHASIS0_ipd : std_logic_vector(2 downto 0);
    signal TXPREEMPHASIS1_ipd : std_logic_vector(2 downto 0);
    signal TXRESET0_ipd : std_ulogic;
    signal TXRESET1_ipd : std_ulogic;
    signal TXUSRCLK0_ipd : std_ulogic;
    signal TXUSRCLK1_ipd : std_ulogic;
    signal TXUSRCLK20_ipd : std_ulogic;
    signal TXUSRCLK21_ipd : std_ulogic;
    signal USRCODEERR0_ipd : std_ulogic;
    signal USRCODEERR1_ipd : std_ulogic;
    
    signal CLK00_dly : std_ulogic;
    signal CLK01_dly : std_ulogic;
    signal CLK10_dly : std_ulogic;
    signal CLK11_dly : std_ulogic;
    signal CLKINEAST0_dly : std_ulogic;
    signal CLKINEAST1_dly : std_ulogic;
    signal CLKINWEST0_dly : std_ulogic;
    signal CLKINWEST1_dly : std_ulogic;
    signal DADDR_DCLK_dly : std_logic_vector(7 downto 0);
    signal DCLK_dly : std_ulogic;
    signal DEN_DCLK_dly : std_ulogic;
    signal DI_DCLK_dly : std_logic_vector(15 downto 0);
    signal DWE_DCLK_dly : std_ulogic;
    signal GCLK00_dly : std_ulogic;
    signal GCLK01_dly : std_ulogic;
    signal GCLK10_dly : std_ulogic;
    signal GCLK11_dly : std_ulogic;
    signal PLLCLK00_dly : std_ulogic;
    signal PLLCLK01_dly : std_ulogic;
    signal PLLCLK10_dly : std_ulogic;
    signal PLLCLK11_dly : std_ulogic;
    signal PRBSCNTRESET0_RXUSRCLK20_dly : std_ulogic;
    signal PRBSCNTRESET1_RXUSRCLK21_dly : std_ulogic;
    signal RXCHBONDI_RXUSRCLK0_dly : std_logic_vector(2 downto 0);
    signal RXCHBONDI_RXUSRCLK1_dly : std_logic_vector(2 downto 0);
    signal RXCHBONDMASTER0_RXUSRCLK20_dly : std_ulogic;
    signal RXCHBONDMASTER1_RXUSRCLK21_dly : std_ulogic;
    signal RXCHBONDSLAVE0_RXUSRCLK20_dly : std_ulogic;
    signal RXCHBONDSLAVE1_RXUSRCLK21_dly : std_ulogic;
    signal RXCOMMADETUSE0_RXUSRCLK20_dly : std_ulogic;
    signal RXCOMMADETUSE1_RXUSRCLK21_dly : std_ulogic;
    signal RXDEC8B10BUSE0_RXUSRCLK20_dly : std_ulogic;
    signal RXDEC8B10BUSE1_RXUSRCLK21_dly : std_ulogic;
    signal RXENCHANSYNC0_RXUSRCLK20_dly : std_ulogic;
    signal RXENCHANSYNC1_RXUSRCLK21_dly : std_ulogic;
    signal RXENMCOMMAALIGN0_RXUSRCLK20_dly : std_ulogic;
    signal RXENMCOMMAALIGN1_RXUSRCLK21_dly : std_ulogic;
    signal RXENPCOMMAALIGN0_RXUSRCLK20_dly : std_ulogic;
    signal RXENPCOMMAALIGN1_RXUSRCLK21_dly : std_ulogic;
    signal RXENPRBSTST0_RXUSRCLK20_dly : std_logic_vector(2 downto 0);
    signal RXENPRBSTST1_RXUSRCLK21_dly : std_logic_vector(2 downto 0);
    signal RXPOLARITY0_RXUSRCLK20_dly : std_ulogic;
    signal RXPOLARITY1_RXUSRCLK21_dly : std_ulogic;
    signal RXSLIDE0_RXUSRCLK20_dly : std_ulogic;
    signal RXSLIDE1_RXUSRCLK21_dly : std_ulogic;
    signal RXUSRCLK0_dly : std_ulogic;
    signal RXUSRCLK1_dly : std_ulogic;
    signal RXUSRCLK20_dly : std_ulogic;
    signal RXUSRCLK21_dly : std_ulogic;
    signal TSTCLK0_dly : std_ulogic;
    signal TSTCLK1_dly : std_ulogic;
    signal TXBYPASS8B10B0_TXUSRCLK20_dly : std_logic_vector(3 downto 0);
    signal TXBYPASS8B10B1_TXUSRCLK21_dly : std_logic_vector(3 downto 0);
    signal TXCHARDISPMODE0_TXUSRCLK20_dly : std_logic_vector(3 downto 0);
    signal TXCHARDISPMODE1_TXUSRCLK21_dly : std_logic_vector(3 downto 0);
    signal TXCHARDISPVAL0_TXUSRCLK20_dly : std_logic_vector(3 downto 0);
    signal TXCHARDISPVAL1_TXUSRCLK21_dly : std_logic_vector(3 downto 0);
    signal TXCHARISK0_TXUSRCLK20_dly : std_logic_vector(3 downto 0);
    signal TXCHARISK1_TXUSRCLK21_dly : std_logic_vector(3 downto 0);
    signal TXCOMSTART0_TXUSRCLK20_dly : std_ulogic;
    signal TXCOMSTART1_TXUSRCLK21_dly : std_ulogic;
    signal TXCOMTYPE0_TXUSRCLK20_dly : std_ulogic;
    signal TXCOMTYPE1_TXUSRCLK21_dly : std_ulogic;
    signal TXDATA0_TXUSRCLK20_dly : std_logic_vector(31 downto 0);
    signal TXDATA1_TXUSRCLK21_dly : std_logic_vector(31 downto 0);
    signal TXDETECTRX0_TXUSRCLK20_dly : std_ulogic;
    signal TXDETECTRX1_TXUSRCLK21_dly : std_ulogic;
    signal TXELECIDLE0_TXUSRCLK20_dly : std_ulogic;
    signal TXELECIDLE1_TXUSRCLK21_dly : std_ulogic;
    signal TXENC8B10BUSE0_TXUSRCLK20_dly : std_ulogic;
    signal TXENC8B10BUSE1_TXUSRCLK21_dly : std_ulogic;
    signal TXENPRBSTST0_TXUSRCLK20_dly : std_logic_vector(2 downto 0);
    signal TXENPRBSTST1_TXUSRCLK21_dly : std_logic_vector(2 downto 0);
    signal TXINHIBIT0_TXUSRCLK20_dly : std_ulogic;
    signal TXINHIBIT1_TXUSRCLK21_dly : std_ulogic;
    signal TXPOLARITY0_TXUSRCLK20_dly : std_ulogic;
    signal TXPOLARITY1_TXUSRCLK21_dly : std_ulogic;
    signal TXPOWERDOWN0_TXUSRCLK20_dly : std_logic_vector(1 downto 0);
    signal TXPOWERDOWN1_TXUSRCLK21_dly : std_logic_vector(1 downto 0);
    signal TXPRBSFORCEERR0_TXUSRCLK20_dly : std_ulogic;
    signal TXPRBSFORCEERR1_TXUSRCLK21_dly : std_ulogic;
    signal TXUSRCLK0_dly : std_ulogic;
    signal TXUSRCLK1_dly : std_ulogic;
    signal TXUSRCLK20_dly : std_ulogic;
    signal TXUSRCLK21_dly : std_ulogic;
    signal USRCODEERR0_RXUSRCLK20_dly : std_ulogic;
    signal USRCODEERR1_RXUSRCLK21_dly : std_ulogic;
    
    signal CLK00_indelay : std_ulogic;
    signal CLK01_indelay : std_ulogic;
    signal CLK10_indelay : std_ulogic;
    signal CLK11_indelay : std_ulogic;
    signal CLKINEAST0_indelay : std_ulogic;
    signal CLKINEAST1_indelay : std_ulogic;
    signal CLKINWEST0_indelay : std_ulogic;
    signal CLKINWEST1_indelay : std_ulogic;
    signal DADDR_indelay : std_logic_vector(7 downto 0);
    signal DCLK_indelay : std_ulogic;
    signal DEN_indelay : std_ulogic;
    signal DI_indelay : std_logic_vector(15 downto 0);
    signal DWE_indelay : std_ulogic;
    signal GATERXELECIDLE0_indelay : std_ulogic;
    signal GATERXELECIDLE1_indelay : std_ulogic;
    signal GCLK00_indelay : std_ulogic;
    signal GCLK01_indelay : std_ulogic;
    signal GCLK10_indelay : std_ulogic;
    signal GCLK11_indelay : std_ulogic;
    signal GTPCLKFBSEL0EAST_indelay : std_logic_vector(1 downto 0);
    signal GTPCLKFBSEL0WEST_indelay : std_logic_vector(1 downto 0);
    signal GTPCLKFBSEL1EAST_indelay : std_logic_vector(1 downto 0);
    signal GTPCLKFBSEL1WEST_indelay : std_logic_vector(1 downto 0);
    signal GTPRESET0_indelay : std_ulogic;
    signal GTPRESET1_indelay : std_ulogic;
    signal GTPTEST0_indelay : std_logic_vector(7 downto 0);
    signal GTPTEST1_indelay : std_logic_vector(7 downto 0);
    signal IGNORESIGDET0_indelay : std_ulogic;
    signal IGNORESIGDET1_indelay : std_ulogic;
    signal INTDATAWIDTH0_indelay : std_ulogic;
    signal INTDATAWIDTH1_indelay : std_ulogic;
    signal LOOPBACK0_indelay : std_logic_vector(2 downto 0);
    signal LOOPBACK1_indelay : std_logic_vector(2 downto 0);
    signal PLLCLK00_indelay : std_ulogic;
    signal PLLCLK01_indelay : std_ulogic;
    signal PLLCLK10_indelay : std_ulogic;
    signal PLLCLK11_indelay : std_ulogic;
    signal PLLLKDETEN0_indelay : std_ulogic;
    signal PLLLKDETEN1_indelay : std_ulogic;
    signal PLLPOWERDOWN0_indelay : std_ulogic;
    signal PLLPOWERDOWN1_indelay : std_ulogic;
    signal PRBSCNTRESET0_indelay : std_ulogic;
    signal PRBSCNTRESET1_indelay : std_ulogic;
    signal RCALINEAST_indelay : std_logic_vector(4 downto 0);
    signal RCALINWEST_indelay : std_logic_vector(4 downto 0);
    signal REFCLKPWRDNB0_indelay : std_ulogic;
    signal REFCLKPWRDNB1_indelay : std_ulogic;
    signal REFSELDYPLL0_indelay : std_logic_vector(2 downto 0);
    signal REFSELDYPLL1_indelay : std_logic_vector(2 downto 0);
    signal RXBUFRESET0_indelay : std_ulogic;
    signal RXBUFRESET1_indelay : std_ulogic;
    signal RXCDRRESET0_indelay : std_ulogic;
    signal RXCDRRESET1_indelay : std_ulogic;
    signal RXCHBONDI_indelay : std_logic_vector(2 downto 0);
    signal RXCHBONDMASTER0_indelay : std_ulogic;
    signal RXCHBONDMASTER1_indelay : std_ulogic;
    signal RXCHBONDSLAVE0_indelay : std_ulogic;
    signal RXCHBONDSLAVE1_indelay : std_ulogic;
    signal RXCOMMADETUSE0_indelay : std_ulogic;
    signal RXCOMMADETUSE1_indelay : std_ulogic;
    signal RXDATAWIDTH0_indelay : std_logic_vector(1 downto 0);
    signal RXDATAWIDTH1_indelay : std_logic_vector(1 downto 0);
    signal RXDEC8B10BUSE0_indelay : std_ulogic;
    signal RXDEC8B10BUSE1_indelay : std_ulogic;
    signal RXENCHANSYNC0_indelay : std_ulogic;
    signal RXENCHANSYNC1_indelay : std_ulogic;
    signal RXENMCOMMAALIGN0_indelay : std_ulogic;
    signal RXENMCOMMAALIGN1_indelay : std_ulogic;
    signal RXENPCOMMAALIGN0_indelay : std_ulogic;
    signal RXENPCOMMAALIGN1_indelay : std_ulogic;
    signal RXENPMAPHASEALIGN0_indelay : std_ulogic;
    signal RXENPMAPHASEALIGN1_indelay : std_ulogic;
    signal RXENPRBSTST0_indelay : std_logic_vector(2 downto 0);
    signal RXENPRBSTST1_indelay : std_logic_vector(2 downto 0);
    signal RXEQMIX0_indelay : std_logic_vector(1 downto 0);
    signal RXEQMIX1_indelay : std_logic_vector(1 downto 0);
    signal RXN0_indelay : std_ulogic;
    signal RXN1_indelay : std_ulogic;
    signal RXP0_indelay : std_ulogic;
    signal RXP1_indelay : std_ulogic;
    signal RXPMASETPHASE0_indelay : std_ulogic;
    signal RXPMASETPHASE1_indelay : std_ulogic;
    signal RXPOLARITY0_indelay : std_ulogic;
    signal RXPOLARITY1_indelay : std_ulogic;
    signal RXPOWERDOWN0_indelay : std_logic_vector(1 downto 0);
    signal RXPOWERDOWN1_indelay : std_logic_vector(1 downto 0);
    signal RXRESET0_indelay : std_ulogic;
    signal RXRESET1_indelay : std_ulogic;
    signal RXSLIDE0_indelay : std_ulogic;
    signal RXSLIDE1_indelay : std_ulogic;
    signal RXUSRCLK0_indelay : std_ulogic;
    signal RXUSRCLK1_indelay : std_ulogic;
    signal RXUSRCLK20_indelay : std_ulogic;
    signal RXUSRCLK21_indelay : std_ulogic;
    signal TSTCLK0_indelay : std_ulogic;
    signal TSTCLK1_indelay : std_ulogic;
    signal TSTIN0_indelay : std_logic_vector(11 downto 0);
    signal TSTIN1_indelay : std_logic_vector(11 downto 0);
    signal TXBUFDIFFCTRL0_indelay : std_logic_vector(2 downto 0);
    signal TXBUFDIFFCTRL1_indelay : std_logic_vector(2 downto 0);
    signal TXBYPASS8B10B0_indelay : std_logic_vector(3 downto 0);
    signal TXBYPASS8B10B1_indelay : std_logic_vector(3 downto 0);
    signal TXCHARDISPMODE0_indelay : std_logic_vector(3 downto 0);
    signal TXCHARDISPMODE1_indelay : std_logic_vector(3 downto 0);
    signal TXCHARDISPVAL0_indelay : std_logic_vector(3 downto 0);
    signal TXCHARDISPVAL1_indelay : std_logic_vector(3 downto 0);
    signal TXCHARISK0_indelay : std_logic_vector(3 downto 0);
    signal TXCHARISK1_indelay : std_logic_vector(3 downto 0);
    signal TXCOMSTART0_indelay : std_ulogic;
    signal TXCOMSTART1_indelay : std_ulogic;
    signal TXCOMTYPE0_indelay : std_ulogic;
    signal TXCOMTYPE1_indelay : std_ulogic;
    signal TXDATA0_indelay : std_logic_vector(31 downto 0);
    signal TXDATA1_indelay : std_logic_vector(31 downto 0);
    signal TXDATAWIDTH0_indelay : std_logic_vector(1 downto 0);
    signal TXDATAWIDTH1_indelay : std_logic_vector(1 downto 0);
    signal TXDETECTRX0_indelay : std_ulogic;
    signal TXDETECTRX1_indelay : std_ulogic;
    signal TXDIFFCTRL0_indelay : std_logic_vector(3 downto 0);
    signal TXDIFFCTRL1_indelay : std_logic_vector(3 downto 0);
    signal TXELECIDLE0_indelay : std_ulogic;
    signal TXELECIDLE1_indelay : std_ulogic;
    signal TXENC8B10BUSE0_indelay : std_ulogic;
    signal TXENC8B10BUSE1_indelay : std_ulogic;
    signal TXENPMAPHASEALIGN0_indelay : std_ulogic;
    signal TXENPMAPHASEALIGN1_indelay : std_ulogic;
    signal TXENPRBSTST0_indelay : std_logic_vector(2 downto 0);
    signal TXENPRBSTST1_indelay : std_logic_vector(2 downto 0);
    signal TXINHIBIT0_indelay : std_ulogic;
    signal TXINHIBIT1_indelay : std_ulogic;
    signal TXPDOWNASYNCH0_indelay : std_ulogic;
    signal TXPDOWNASYNCH1_indelay : std_ulogic;
    signal TXPMASETPHASE0_indelay : std_ulogic;
    signal TXPMASETPHASE1_indelay : std_ulogic;
    signal TXPOLARITY0_indelay : std_ulogic;
    signal TXPOLARITY1_indelay : std_ulogic;
    signal TXPOWERDOWN0_indelay : std_logic_vector(1 downto 0);
    signal TXPOWERDOWN1_indelay : std_logic_vector(1 downto 0);
    signal TXPRBSFORCEERR0_indelay : std_ulogic;
    signal TXPRBSFORCEERR1_indelay : std_ulogic;
    signal TXPREEMPHASIS0_indelay : std_logic_vector(2 downto 0);
    signal TXPREEMPHASIS1_indelay : std_logic_vector(2 downto 0);
    signal TXRESET0_indelay : std_ulogic;
    signal TXRESET1_indelay : std_ulogic;
    signal TXUSRCLK0_indelay : std_ulogic;
    signal TXUSRCLK1_indelay : std_ulogic;
    signal TXUSRCLK20_indelay : std_ulogic;
    signal TXUSRCLK21_indelay : std_ulogic;
    signal USRCODEERR0_indelay : std_ulogic;
    signal USRCODEERR1_indelay : std_ulogic;
    
    signal CLK00_indly : std_ulogic;
    signal CLK01_indly : std_ulogic;
    signal CLK10_indly : std_ulogic;
    signal CLK11_indly : std_ulogic;
    signal CLKINEAST0_indly : std_ulogic;
    signal CLKINEAST1_indly : std_ulogic;
    signal CLKINWEST0_indly : std_ulogic;
    signal CLKINWEST1_indly : std_ulogic;
    signal DADDR_indly : std_logic_vector(7 downto 0);
    signal DCLK_indly : std_ulogic;
    signal DEN_indly : std_ulogic;
    signal DI_indly : std_logic_vector(15 downto 0);
    signal DWE_indly : std_ulogic;
    signal GATERXELECIDLE0_indly : std_ulogic;
    signal GATERXELECIDLE1_indly : std_ulogic;
    signal GCLK00_indly : std_ulogic;
    signal GCLK01_indly : std_ulogic;
    signal GCLK10_indly : std_ulogic;
    signal GCLK11_indly : std_ulogic;
    signal GTPCLKFBSEL0EAST_indly : std_logic_vector(1 downto 0);
    signal GTPCLKFBSEL0WEST_indly : std_logic_vector(1 downto 0);
    signal GTPCLKFBSEL1EAST_indly : std_logic_vector(1 downto 0);
    signal GTPCLKFBSEL1WEST_indly : std_logic_vector(1 downto 0);
    signal GTPRESET0_indly : std_ulogic;
    signal GTPRESET1_indly : std_ulogic;
    signal GTPTEST0_indly : std_logic_vector(7 downto 0);
    signal GTPTEST1_indly : std_logic_vector(7 downto 0);
    signal IGNORESIGDET0_indly : std_ulogic;
    signal IGNORESIGDET1_indly : std_ulogic;
    signal INTDATAWIDTH0_indly : std_ulogic;
    signal INTDATAWIDTH1_indly : std_ulogic;
    signal LOOPBACK0_indly : std_logic_vector(2 downto 0);
    signal LOOPBACK1_indly : std_logic_vector(2 downto 0);
    signal PLLCLK00_indly : std_ulogic;
    signal PLLCLK01_indly : std_ulogic;
    signal PLLCLK10_indly : std_ulogic;
    signal PLLCLK11_indly : std_ulogic;
    signal PLLLKDETEN0_indly : std_ulogic;
    signal PLLLKDETEN1_indly : std_ulogic;
    signal PLLPOWERDOWN0_indly : std_ulogic;
    signal PLLPOWERDOWN1_indly : std_ulogic;
    signal PRBSCNTRESET0_indly : std_ulogic;
    signal PRBSCNTRESET1_indly : std_ulogic;
    signal RCALINEAST_indly : std_logic_vector(4 downto 0);
    signal RCALINWEST_indly : std_logic_vector(4 downto 0);
    signal REFCLKPWRDNB0_indly : std_ulogic;
    signal REFCLKPWRDNB1_indly : std_ulogic;
    signal REFSELDYPLL0_indly : std_logic_vector(2 downto 0);
    signal REFSELDYPLL1_indly : std_logic_vector(2 downto 0);
    signal RXBUFRESET0_indly : std_ulogic;
    signal RXBUFRESET1_indly : std_ulogic;
    signal RXCDRRESET0_indly : std_ulogic;
    signal RXCDRRESET1_indly : std_ulogic;
    signal RXCHBONDI_indly : std_logic_vector(2 downto 0);
    signal RXCHBONDMASTER0_indly : std_ulogic;
    signal RXCHBONDMASTER1_indly : std_ulogic;
    signal RXCHBONDSLAVE0_indly : std_ulogic;
    signal RXCHBONDSLAVE1_indly : std_ulogic;
    signal RXCOMMADETUSE0_indly : std_ulogic;
    signal RXCOMMADETUSE1_indly : std_ulogic;
    signal RXDATAWIDTH0_indly : std_logic_vector(1 downto 0);
    signal RXDATAWIDTH1_indly : std_logic_vector(1 downto 0);
    signal RXDEC8B10BUSE0_indly : std_ulogic;
    signal RXDEC8B10BUSE1_indly : std_ulogic;
    signal RXENCHANSYNC0_indly : std_ulogic;
    signal RXENCHANSYNC1_indly : std_ulogic;
    signal RXENMCOMMAALIGN0_indly : std_ulogic;
    signal RXENMCOMMAALIGN1_indly : std_ulogic;
    signal RXENPCOMMAALIGN0_indly : std_ulogic;
    signal RXENPCOMMAALIGN1_indly : std_ulogic;
    signal RXENPMAPHASEALIGN0_indly : std_ulogic;
    signal RXENPMAPHASEALIGN1_indly : std_ulogic;
    signal RXENPRBSTST0_indly : std_logic_vector(2 downto 0);
    signal RXENPRBSTST1_indly : std_logic_vector(2 downto 0);
    signal RXEQMIX0_indly : std_logic_vector(1 downto 0);
    signal RXEQMIX1_indly : std_logic_vector(1 downto 0);
    signal RXN0_indly : std_ulogic;
    signal RXN1_indly : std_ulogic;
    signal RXP0_indly : std_ulogic;
    signal RXP1_indly : std_ulogic;
    signal RXPMASETPHASE0_indly : std_ulogic;
    signal RXPMASETPHASE1_indly : std_ulogic;
    signal RXPOLARITY0_indly : std_ulogic;
    signal RXPOLARITY1_indly : std_ulogic;
    signal RXPOWERDOWN0_indly : std_logic_vector(1 downto 0);
    signal RXPOWERDOWN1_indly : std_logic_vector(1 downto 0);
    signal RXRESET0_indly : std_ulogic;
    signal RXRESET1_indly : std_ulogic;
    signal RXSLIDE0_indly : std_ulogic;
    signal RXSLIDE1_indly : std_ulogic;
    signal RXUSRCLK0_indly : std_ulogic;
    signal RXUSRCLK1_indly : std_ulogic;
    signal RXUSRCLK20_indly : std_ulogic;
    signal RXUSRCLK21_indly : std_ulogic;
    signal TSTCLK0_indly : std_ulogic;
    signal TSTCLK1_indly : std_ulogic;
    signal TSTIN0_indly : std_logic_vector(11 downto 0);
    signal TSTIN1_indly : std_logic_vector(11 downto 0);
    signal TXBUFDIFFCTRL0_indly : std_logic_vector(2 downto 0);
    signal TXBUFDIFFCTRL1_indly : std_logic_vector(2 downto 0);
    signal TXBYPASS8B10B0_indly : std_logic_vector(3 downto 0);
    signal TXBYPASS8B10B1_indly : std_logic_vector(3 downto 0);
    signal TXCHARDISPMODE0_indly : std_logic_vector(3 downto 0);
    signal TXCHARDISPMODE1_indly : std_logic_vector(3 downto 0);
    signal TXCHARDISPVAL0_indly : std_logic_vector(3 downto 0);
    signal TXCHARDISPVAL1_indly : std_logic_vector(3 downto 0);
    signal TXCHARISK0_indly : std_logic_vector(3 downto 0);
    signal TXCHARISK1_indly : std_logic_vector(3 downto 0);
    signal TXCOMSTART0_indly : std_ulogic;
    signal TXCOMSTART1_indly : std_ulogic;
    signal TXCOMTYPE0_indly : std_ulogic;
    signal TXCOMTYPE1_indly : std_ulogic;
    signal TXDATA0_indly : std_logic_vector(31 downto 0);
    signal TXDATA1_indly : std_logic_vector(31 downto 0);
    signal TXDATAWIDTH0_indly : std_logic_vector(1 downto 0);
    signal TXDATAWIDTH1_indly : std_logic_vector(1 downto 0);
    signal TXDETECTRX0_indly : std_ulogic;
    signal TXDETECTRX1_indly : std_ulogic;
    signal TXDIFFCTRL0_indly : std_logic_vector(3 downto 0);
    signal TXDIFFCTRL1_indly : std_logic_vector(3 downto 0);
    signal TXELECIDLE0_indly : std_ulogic;
    signal TXELECIDLE1_indly : std_ulogic;
    signal TXENC8B10BUSE0_indly : std_ulogic;
    signal TXENC8B10BUSE1_indly : std_ulogic;
    signal TXENPMAPHASEALIGN0_indly : std_ulogic;
    signal TXENPMAPHASEALIGN1_indly : std_ulogic;
    signal TXENPRBSTST0_indly : std_logic_vector(2 downto 0);
    signal TXENPRBSTST1_indly : std_logic_vector(2 downto 0);
    signal TXINHIBIT0_indly : std_ulogic;
    signal TXINHIBIT1_indly : std_ulogic;
    signal TXPDOWNASYNCH0_indly : std_ulogic;
    signal TXPDOWNASYNCH1_indly : std_ulogic;
    signal TXPMASETPHASE0_indly : std_ulogic;
    signal TXPMASETPHASE1_indly : std_ulogic;
    signal TXPOLARITY0_indly : std_ulogic;
    signal TXPOLARITY1_indly : std_ulogic;
    signal TXPOWERDOWN0_indly : std_logic_vector(1 downto 0);
    signal TXPOWERDOWN1_indly : std_logic_vector(1 downto 0);
    signal TXPRBSFORCEERR0_indly : std_ulogic;
    signal TXPRBSFORCEERR1_indly : std_ulogic;
    signal TXPREEMPHASIS0_indly : std_logic_vector(2 downto 0);
    signal TXPREEMPHASIS1_indly : std_logic_vector(2 downto 0);
    signal TXRESET0_indly : std_ulogic;
    signal TXRESET1_indly : std_ulogic;
    signal TXUSRCLK0_indly : std_ulogic;
    signal TXUSRCLK1_indly : std_ulogic;
    signal TXUSRCLK20_indly : std_ulogic;
    signal TXUSRCLK21_indly : std_ulogic;
    signal USRCODEERR0_indly : std_ulogic;
    signal USRCODEERR1_indly : std_ulogic;
    signal GSR_dly : std_ulogic := '0';

    begin
    WireDelay : block
    begin
      DADDR_DELAY : for i in 0 to 7 generate
        VitalWireDelay (DADDR_ipd(i),DADDR(i),tipd_DADDR(i));
      end generate DADDR_DELAY;
      DI_DELAY : for i in 0 to 15 generate
        VitalWireDelay (DI_ipd(i),DI(i),tipd_DI(i));
      end generate DI_DELAY;
      GTPCLKFBSEL0EAST_DELAY : for i in 0 to 1 generate
        VitalWireDelay (GTPCLKFBSEL0EAST_ipd(i),GTPCLKFBSEL0EAST(i),tipd_GTPCLKFBSEL0EAST(i));
      end generate GTPCLKFBSEL0EAST_DELAY;
      GTPCLKFBSEL0WEST_DELAY : for i in 0 to 1 generate
        VitalWireDelay (GTPCLKFBSEL0WEST_ipd(i),GTPCLKFBSEL0WEST(i),tipd_GTPCLKFBSEL0WEST(i));
      end generate GTPCLKFBSEL0WEST_DELAY;
      GTPCLKFBSEL1EAST_DELAY : for i in 0 to 1 generate
        VitalWireDelay (GTPCLKFBSEL1EAST_ipd(i),GTPCLKFBSEL1EAST(i),tipd_GTPCLKFBSEL1EAST(i));
      end generate GTPCLKFBSEL1EAST_DELAY;
      GTPCLKFBSEL1WEST_DELAY : for i in 0 to 1 generate
        VitalWireDelay (GTPCLKFBSEL1WEST_ipd(i),GTPCLKFBSEL1WEST(i),tipd_GTPCLKFBSEL1WEST(i));
      end generate GTPCLKFBSEL1WEST_DELAY;
      GTPTEST0_DELAY : for i in 0 to 7 generate
        VitalWireDelay (GTPTEST0_ipd(i),GTPTEST0(i),tipd_GTPTEST0(i));
      end generate GTPTEST0_DELAY;
      GTPTEST1_DELAY : for i in 0 to 7 generate
        VitalWireDelay (GTPTEST1_ipd(i),GTPTEST1(i),tipd_GTPTEST1(i));
      end generate GTPTEST1_DELAY;
      LOOPBACK0_DELAY : for i in 0 to 2 generate
        VitalWireDelay (LOOPBACK0_ipd(i),LOOPBACK0(i),tipd_LOOPBACK0(i));
      end generate LOOPBACK0_DELAY;
      LOOPBACK1_DELAY : for i in 0 to 2 generate
        VitalWireDelay (LOOPBACK1_ipd(i),LOOPBACK1(i),tipd_LOOPBACK1(i));
      end generate LOOPBACK1_DELAY;
      RCALINEAST_DELAY : for i in 0 to 4 generate
        VitalWireDelay (RCALINEAST_ipd(i),RCALINEAST(i),tipd_RCALINEAST(i));
      end generate RCALINEAST_DELAY;
      RCALINWEST_DELAY : for i in 0 to 4 generate
        VitalWireDelay (RCALINWEST_ipd(i),RCALINWEST(i),tipd_RCALINWEST(i));
      end generate RCALINWEST_DELAY;
      REFSELDYPLL0_DELAY : for i in 0 to 2 generate
        VitalWireDelay (REFSELDYPLL0_ipd(i),REFSELDYPLL0(i),tipd_REFSELDYPLL0(i));
      end generate REFSELDYPLL0_DELAY;
      REFSELDYPLL1_DELAY : for i in 0 to 2 generate
        VitalWireDelay (REFSELDYPLL1_ipd(i),REFSELDYPLL1(i),tipd_REFSELDYPLL1(i));
      end generate REFSELDYPLL1_DELAY;
      RXCHBONDI_DELAY : for i in 0 to 2 generate
        VitalWireDelay (RXCHBONDI_ipd(i),RXCHBONDI(i),tipd_RXCHBONDI(i));
      end generate RXCHBONDI_DELAY;
      RXDATAWIDTH0_DELAY : for i in 0 to 1 generate
        VitalWireDelay (RXDATAWIDTH0_ipd(i),RXDATAWIDTH0(i),tipd_RXDATAWIDTH0(i));
      end generate RXDATAWIDTH0_DELAY;
      RXDATAWIDTH1_DELAY : for i in 0 to 1 generate
        VitalWireDelay (RXDATAWIDTH1_ipd(i),RXDATAWIDTH1(i),tipd_RXDATAWIDTH1(i));
      end generate RXDATAWIDTH1_DELAY;
      RXENPRBSTST0_DELAY : for i in 0 to 2 generate
        VitalWireDelay (RXENPRBSTST0_ipd(i),RXENPRBSTST0(i),tipd_RXENPRBSTST0(i));
      end generate RXENPRBSTST0_DELAY;
      RXENPRBSTST1_DELAY : for i in 0 to 2 generate
        VitalWireDelay (RXENPRBSTST1_ipd(i),RXENPRBSTST1(i),tipd_RXENPRBSTST1(i));
      end generate RXENPRBSTST1_DELAY;
      RXEQMIX0_DELAY : for i in 0 to 1 generate
        VitalWireDelay (RXEQMIX0_ipd(i),RXEQMIX0(i),tipd_RXEQMIX0(i));
      end generate RXEQMIX0_DELAY;
      RXEQMIX1_DELAY : for i in 0 to 1 generate
        VitalWireDelay (RXEQMIX1_ipd(i),RXEQMIX1(i),tipd_RXEQMIX1(i));
      end generate RXEQMIX1_DELAY;
      RXPOWERDOWN0_DELAY : for i in 0 to 1 generate
        VitalWireDelay (RXPOWERDOWN0_ipd(i),RXPOWERDOWN0(i),tipd_RXPOWERDOWN0(i));
      end generate RXPOWERDOWN0_DELAY;
      RXPOWERDOWN1_DELAY : for i in 0 to 1 generate
        VitalWireDelay (RXPOWERDOWN1_ipd(i),RXPOWERDOWN1(i),tipd_RXPOWERDOWN1(i));
      end generate RXPOWERDOWN1_DELAY;
      TSTIN0_DELAY : for i in 0 to 11 generate
        VitalWireDelay (TSTIN0_ipd(i),TSTIN0(i),tipd_TSTIN0(i));
      end generate TSTIN0_DELAY;
      TSTIN1_DELAY : for i in 0 to 11 generate
        VitalWireDelay (TSTIN1_ipd(i),TSTIN1(i),tipd_TSTIN1(i));
      end generate TSTIN1_DELAY;
      TXBUFDIFFCTRL0_DELAY : for i in 0 to 2 generate
        VitalWireDelay (TXBUFDIFFCTRL0_ipd(i),TXBUFDIFFCTRL0(i),tipd_TXBUFDIFFCTRL0(i));
      end generate TXBUFDIFFCTRL0_DELAY;
      TXBUFDIFFCTRL1_DELAY : for i in 0 to 2 generate
        VitalWireDelay (TXBUFDIFFCTRL1_ipd(i),TXBUFDIFFCTRL1(i),tipd_TXBUFDIFFCTRL1(i));
      end generate TXBUFDIFFCTRL1_DELAY;
      TXBYPASS8B10B0_DELAY : for i in 0 to 3 generate
        VitalWireDelay (TXBYPASS8B10B0_ipd(i),TXBYPASS8B10B0(i),tipd_TXBYPASS8B10B0(i));
      end generate TXBYPASS8B10B0_DELAY;
      TXBYPASS8B10B1_DELAY : for i in 0 to 3 generate
        VitalWireDelay (TXBYPASS8B10B1_ipd(i),TXBYPASS8B10B1(i),tipd_TXBYPASS8B10B1(i));
      end generate TXBYPASS8B10B1_DELAY;
      TXCHARDISPMODE0_DELAY : for i in 0 to 3 generate
        VitalWireDelay (TXCHARDISPMODE0_ipd(i),TXCHARDISPMODE0(i),tipd_TXCHARDISPMODE0(i));
      end generate TXCHARDISPMODE0_DELAY;
      TXCHARDISPMODE1_DELAY : for i in 0 to 3 generate
        VitalWireDelay (TXCHARDISPMODE1_ipd(i),TXCHARDISPMODE1(i),tipd_TXCHARDISPMODE1(i));
      end generate TXCHARDISPMODE1_DELAY;
      TXCHARDISPVAL0_DELAY : for i in 0 to 3 generate
        VitalWireDelay (TXCHARDISPVAL0_ipd(i),TXCHARDISPVAL0(i),tipd_TXCHARDISPVAL0(i));
      end generate TXCHARDISPVAL0_DELAY;
      TXCHARDISPVAL1_DELAY : for i in 0 to 3 generate
        VitalWireDelay (TXCHARDISPVAL1_ipd(i),TXCHARDISPVAL1(i),tipd_TXCHARDISPVAL1(i));
      end generate TXCHARDISPVAL1_DELAY;
      TXCHARISK0_DELAY : for i in 0 to 3 generate
        VitalWireDelay (TXCHARISK0_ipd(i),TXCHARISK0(i),tipd_TXCHARISK0(i));
      end generate TXCHARISK0_DELAY;
      TXCHARISK1_DELAY : for i in 0 to 3 generate
        VitalWireDelay (TXCHARISK1_ipd(i),TXCHARISK1(i),tipd_TXCHARISK1(i));
      end generate TXCHARISK1_DELAY;
      TXDATA0_DELAY : for i in 0 to 31 generate
        VitalWireDelay (TXDATA0_ipd(i),TXDATA0(i),tipd_TXDATA0(i));
      end generate TXDATA0_DELAY;
      TXDATA1_DELAY : for i in 0 to 31 generate
        VitalWireDelay (TXDATA1_ipd(i),TXDATA1(i),tipd_TXDATA1(i));
      end generate TXDATA1_DELAY;
      TXDATAWIDTH0_DELAY : for i in 0 to 1 generate
        VitalWireDelay (TXDATAWIDTH0_ipd(i),TXDATAWIDTH0(i),tipd_TXDATAWIDTH0(i));
      end generate TXDATAWIDTH0_DELAY;
      TXDATAWIDTH1_DELAY : for i in 0 to 1 generate
        VitalWireDelay (TXDATAWIDTH1_ipd(i),TXDATAWIDTH1(i),tipd_TXDATAWIDTH1(i));
      end generate TXDATAWIDTH1_DELAY;
      TXDIFFCTRL0_DELAY : for i in 0 to 3 generate
        VitalWireDelay (TXDIFFCTRL0_ipd(i),TXDIFFCTRL0(i),tipd_TXDIFFCTRL0(i));
      end generate TXDIFFCTRL0_DELAY;
      TXDIFFCTRL1_DELAY : for i in 0 to 3 generate
        VitalWireDelay (TXDIFFCTRL1_ipd(i),TXDIFFCTRL1(i),tipd_TXDIFFCTRL1(i));
      end generate TXDIFFCTRL1_DELAY;
      TXENPRBSTST0_DELAY : for i in 0 to 2 generate
        VitalWireDelay (TXENPRBSTST0_ipd(i),TXENPRBSTST0(i),tipd_TXENPRBSTST0(i));
      end generate TXENPRBSTST0_DELAY;
      TXENPRBSTST1_DELAY : for i in 0 to 2 generate
        VitalWireDelay (TXENPRBSTST1_ipd(i),TXENPRBSTST1(i),tipd_TXENPRBSTST1(i));
      end generate TXENPRBSTST1_DELAY;
      TXPOWERDOWN0_DELAY : for i in 0 to 1 generate
        VitalWireDelay (TXPOWERDOWN0_ipd(i),TXPOWERDOWN0(i),tipd_TXPOWERDOWN0(i));
      end generate TXPOWERDOWN0_DELAY;
      TXPOWERDOWN1_DELAY : for i in 0 to 1 generate
        VitalWireDelay (TXPOWERDOWN1_ipd(i),TXPOWERDOWN1(i),tipd_TXPOWERDOWN1(i));
      end generate TXPOWERDOWN1_DELAY;
      TXPREEMPHASIS0_DELAY : for i in 0 to 2 generate
        VitalWireDelay (TXPREEMPHASIS0_ipd(i),TXPREEMPHASIS0(i),tipd_TXPREEMPHASIS0(i));
      end generate TXPREEMPHASIS0_DELAY;
      TXPREEMPHASIS1_DELAY : for i in 0 to 2 generate
        VitalWireDelay (TXPREEMPHASIS1_ipd(i),TXPREEMPHASIS1(i),tipd_TXPREEMPHASIS1(i));
      end generate TXPREEMPHASIS1_DELAY;
      VitalWireDelay (CLK00_ipd,CLK00,tipd_CLK00);
      VitalWireDelay (CLK01_ipd,CLK01,tipd_CLK01);
      VitalWireDelay (CLK10_ipd,CLK10,tipd_CLK10);
      VitalWireDelay (CLK11_ipd,CLK11,tipd_CLK11);
      VitalWireDelay (CLKINEAST0_ipd,CLKINEAST0,tipd_CLKINEAST0);
      VitalWireDelay (CLKINEAST1_ipd,CLKINEAST1,tipd_CLKINEAST1);
      VitalWireDelay (CLKINWEST0_ipd,CLKINWEST0,tipd_CLKINWEST0);
      VitalWireDelay (CLKINWEST1_ipd,CLKINWEST1,tipd_CLKINWEST1);
      VitalWireDelay (DCLK_ipd,DCLK,tipd_DCLK);
      VitalWireDelay (DEN_ipd,DEN,tipd_DEN);
      VitalWireDelay (DWE_ipd,DWE,tipd_DWE);
      VitalWireDelay (GATERXELECIDLE0_ipd,GATERXELECIDLE0,tipd_GATERXELECIDLE0);
      VitalWireDelay (GATERXELECIDLE1_ipd,GATERXELECIDLE1,tipd_GATERXELECIDLE1);
      VitalWireDelay (GCLK00_ipd,GCLK00,tipd_GCLK00);
      VitalWireDelay (GCLK01_ipd,GCLK01,tipd_GCLK01);
      VitalWireDelay (GCLK10_ipd,GCLK10,tipd_GCLK10);
      VitalWireDelay (GCLK11_ipd,GCLK11,tipd_GCLK11);
      VitalWireDelay (GTPRESET0_ipd,GTPRESET0,tipd_GTPRESET0);
      VitalWireDelay (GTPRESET1_ipd,GTPRESET1,tipd_GTPRESET1);
      VitalWireDelay (IGNORESIGDET0_ipd,IGNORESIGDET0,tipd_IGNORESIGDET0);
      VitalWireDelay (IGNORESIGDET1_ipd,IGNORESIGDET1,tipd_IGNORESIGDET1);
      VitalWireDelay (INTDATAWIDTH0_ipd,INTDATAWIDTH0,tipd_INTDATAWIDTH0);
      VitalWireDelay (INTDATAWIDTH1_ipd,INTDATAWIDTH1,tipd_INTDATAWIDTH1);
      VitalWireDelay (PLLCLK00_ipd,PLLCLK00,tipd_PLLCLK00);
      VitalWireDelay (PLLCLK01_ipd,PLLCLK01,tipd_PLLCLK01);
      VitalWireDelay (PLLCLK10_ipd,PLLCLK10,tipd_PLLCLK10);
      VitalWireDelay (PLLCLK11_ipd,PLLCLK11,tipd_PLLCLK11);
      VitalWireDelay (PLLLKDETEN0_ipd,PLLLKDETEN0,tipd_PLLLKDETEN0);
      VitalWireDelay (PLLLKDETEN1_ipd,PLLLKDETEN1,tipd_PLLLKDETEN1);
      VitalWireDelay (PLLPOWERDOWN0_ipd,PLLPOWERDOWN0,tipd_PLLPOWERDOWN0);
      VitalWireDelay (PLLPOWERDOWN1_ipd,PLLPOWERDOWN1,tipd_PLLPOWERDOWN1);
      VitalWireDelay (PRBSCNTRESET0_ipd,PRBSCNTRESET0,tipd_PRBSCNTRESET0);
      VitalWireDelay (PRBSCNTRESET1_ipd,PRBSCNTRESET1,tipd_PRBSCNTRESET1);
      VitalWireDelay (REFCLKPWRDNB0_ipd,REFCLKPWRDNB0,tipd_REFCLKPWRDNB0);
      VitalWireDelay (REFCLKPWRDNB1_ipd,REFCLKPWRDNB1,tipd_REFCLKPWRDNB1);
      VitalWireDelay (RXBUFRESET0_ipd,RXBUFRESET0,tipd_RXBUFRESET0);
      VitalWireDelay (RXBUFRESET1_ipd,RXBUFRESET1,tipd_RXBUFRESET1);
      VitalWireDelay (RXCDRRESET0_ipd,RXCDRRESET0,tipd_RXCDRRESET0);
      VitalWireDelay (RXCDRRESET1_ipd,RXCDRRESET1,tipd_RXCDRRESET1);
      VitalWireDelay (RXCHBONDMASTER0_ipd,RXCHBONDMASTER0,tipd_RXCHBONDMASTER0);
      VitalWireDelay (RXCHBONDMASTER1_ipd,RXCHBONDMASTER1,tipd_RXCHBONDMASTER1);
      VitalWireDelay (RXCHBONDSLAVE0_ipd,RXCHBONDSLAVE0,tipd_RXCHBONDSLAVE0);
      VitalWireDelay (RXCHBONDSLAVE1_ipd,RXCHBONDSLAVE1,tipd_RXCHBONDSLAVE1);
      VitalWireDelay (RXCOMMADETUSE0_ipd,RXCOMMADETUSE0,tipd_RXCOMMADETUSE0);
      VitalWireDelay (RXCOMMADETUSE1_ipd,RXCOMMADETUSE1,tipd_RXCOMMADETUSE1);
      VitalWireDelay (RXDEC8B10BUSE0_ipd,RXDEC8B10BUSE0,tipd_RXDEC8B10BUSE0);
      VitalWireDelay (RXDEC8B10BUSE1_ipd,RXDEC8B10BUSE1,tipd_RXDEC8B10BUSE1);
      VitalWireDelay (RXENCHANSYNC0_ipd,RXENCHANSYNC0,tipd_RXENCHANSYNC0);
      VitalWireDelay (RXENCHANSYNC1_ipd,RXENCHANSYNC1,tipd_RXENCHANSYNC1);
      VitalWireDelay (RXENMCOMMAALIGN0_ipd,RXENMCOMMAALIGN0,tipd_RXENMCOMMAALIGN0);
      VitalWireDelay (RXENMCOMMAALIGN1_ipd,RXENMCOMMAALIGN1,tipd_RXENMCOMMAALIGN1);
      VitalWireDelay (RXENPCOMMAALIGN0_ipd,RXENPCOMMAALIGN0,tipd_RXENPCOMMAALIGN0);
      VitalWireDelay (RXENPCOMMAALIGN1_ipd,RXENPCOMMAALIGN1,tipd_RXENPCOMMAALIGN1);
      VitalWireDelay (RXENPMAPHASEALIGN0_ipd,RXENPMAPHASEALIGN0,tipd_RXENPMAPHASEALIGN0);
      VitalWireDelay (RXENPMAPHASEALIGN1_ipd,RXENPMAPHASEALIGN1,tipd_RXENPMAPHASEALIGN1);
      VitalWireDelay (RXN0_ipd,RXN0,tipd_RXN0);
      VitalWireDelay (RXN1_ipd,RXN1,tipd_RXN1);
      VitalWireDelay (RXP0_ipd,RXP0,tipd_RXP0);
      VitalWireDelay (RXP1_ipd,RXP1,tipd_RXP1);
      VitalWireDelay (RXPMASETPHASE0_ipd,RXPMASETPHASE0,tipd_RXPMASETPHASE0);
      VitalWireDelay (RXPMASETPHASE1_ipd,RXPMASETPHASE1,tipd_RXPMASETPHASE1);
      VitalWireDelay (RXPOLARITY0_ipd,RXPOLARITY0,tipd_RXPOLARITY0);
      VitalWireDelay (RXPOLARITY1_ipd,RXPOLARITY1,tipd_RXPOLARITY1);
      VitalWireDelay (RXRESET0_ipd,RXRESET0,tipd_RXRESET0);
      VitalWireDelay (RXRESET1_ipd,RXRESET1,tipd_RXRESET1);
      VitalWireDelay (RXSLIDE0_ipd,RXSLIDE0,tipd_RXSLIDE0);
      VitalWireDelay (RXSLIDE1_ipd,RXSLIDE1,tipd_RXSLIDE1);
      VitalWireDelay (RXUSRCLK0_ipd,RXUSRCLK0,tipd_RXUSRCLK0);
      VitalWireDelay (RXUSRCLK1_ipd,RXUSRCLK1,tipd_RXUSRCLK1);
      VitalWireDelay (RXUSRCLK20_ipd,RXUSRCLK20,tipd_RXUSRCLK20);
      VitalWireDelay (RXUSRCLK21_ipd,RXUSRCLK21,tipd_RXUSRCLK21);
      VitalWireDelay (TSTCLK0_ipd,TSTCLK0,tipd_TSTCLK0);
      VitalWireDelay (TSTCLK1_ipd,TSTCLK1,tipd_TSTCLK1);
      VitalWireDelay (TXCOMSTART0_ipd,TXCOMSTART0,tipd_TXCOMSTART0);
      VitalWireDelay (TXCOMSTART1_ipd,TXCOMSTART1,tipd_TXCOMSTART1);
      VitalWireDelay (TXCOMTYPE0_ipd,TXCOMTYPE0,tipd_TXCOMTYPE0);
      VitalWireDelay (TXCOMTYPE1_ipd,TXCOMTYPE1,tipd_TXCOMTYPE1);
      VitalWireDelay (TXDETECTRX0_ipd,TXDETECTRX0,tipd_TXDETECTRX0);
      VitalWireDelay (TXDETECTRX1_ipd,TXDETECTRX1,tipd_TXDETECTRX1);
      VitalWireDelay (TXELECIDLE0_ipd,TXELECIDLE0,tipd_TXELECIDLE0);
      VitalWireDelay (TXELECIDLE1_ipd,TXELECIDLE1,tipd_TXELECIDLE1);
      VitalWireDelay (TXENC8B10BUSE0_ipd,TXENC8B10BUSE0,tipd_TXENC8B10BUSE0);
      VitalWireDelay (TXENC8B10BUSE1_ipd,TXENC8B10BUSE1,tipd_TXENC8B10BUSE1);
      VitalWireDelay (TXENPMAPHASEALIGN0_ipd,TXENPMAPHASEALIGN0,tipd_TXENPMAPHASEALIGN0);
      VitalWireDelay (TXENPMAPHASEALIGN1_ipd,TXENPMAPHASEALIGN1,tipd_TXENPMAPHASEALIGN1);
      VitalWireDelay (TXINHIBIT0_ipd,TXINHIBIT0,tipd_TXINHIBIT0);
      VitalWireDelay (TXINHIBIT1_ipd,TXINHIBIT1,tipd_TXINHIBIT1);
      VitalWireDelay (TXPDOWNASYNCH0_ipd,TXPDOWNASYNCH0,tipd_TXPDOWNASYNCH0);
      VitalWireDelay (TXPDOWNASYNCH1_ipd,TXPDOWNASYNCH1,tipd_TXPDOWNASYNCH1);
      VitalWireDelay (TXPMASETPHASE0_ipd,TXPMASETPHASE0,tipd_TXPMASETPHASE0);
      VitalWireDelay (TXPMASETPHASE1_ipd,TXPMASETPHASE1,tipd_TXPMASETPHASE1);
      VitalWireDelay (TXPOLARITY0_ipd,TXPOLARITY0,tipd_TXPOLARITY0);
      VitalWireDelay (TXPOLARITY1_ipd,TXPOLARITY1,tipd_TXPOLARITY1);
      VitalWireDelay (TXPRBSFORCEERR0_ipd,TXPRBSFORCEERR0,tipd_TXPRBSFORCEERR0);
      VitalWireDelay (TXPRBSFORCEERR1_ipd,TXPRBSFORCEERR1,tipd_TXPRBSFORCEERR1);
      VitalWireDelay (TXRESET0_ipd,TXRESET0,tipd_TXRESET0);
      VitalWireDelay (TXRESET1_ipd,TXRESET1,tipd_TXRESET1);
      VitalWireDelay (TXUSRCLK0_ipd,TXUSRCLK0,tipd_TXUSRCLK0);
      VitalWireDelay (TXUSRCLK1_ipd,TXUSRCLK1,tipd_TXUSRCLK1);
      VitalWireDelay (TXUSRCLK20_ipd,TXUSRCLK20,tipd_TXUSRCLK20);
      VitalWireDelay (TXUSRCLK21_ipd,TXUSRCLK21,tipd_TXUSRCLK21);
      VitalWireDelay (USRCODEERR0_ipd,USRCODEERR0,tipd_USRCODEERR0);
      VitalWireDelay (USRCODEERR1_ipd,USRCODEERR1,tipd_USRCODEERR1);
    end block;
    
    SignalDelay : block
    begin
      DADDR_DCLK_DELAY : for i in 7 downto 0 generate
        VitalSignalDelay (DADDR_DCLK_dly(i),DADDR_ipd(i),tisd_DADDR_DCLK(i));
      end generate DADDR_DCLK_DELAY;
      DI_DCLK_DELAY : for i in 15 downto 0 generate
        VitalSignalDelay (DI_DCLK_dly(i),DI_ipd(i),tisd_DI_DCLK(i));
      end generate DI_DCLK_DELAY;
      RXCHBONDI_RXUSRCLK0_DELAY : for i in 2 downto 0 generate
        VitalSignalDelay (RXCHBONDI_RXUSRCLK0_dly(i),RXCHBONDI_ipd(i),tisd_RXCHBONDI_RXUSRCLK0(i));
      end generate RXCHBONDI_RXUSRCLK0_DELAY;
      RXCHBONDI_RXUSRCLK1_DELAY : for i in 2 downto 0 generate
        VitalSignalDelay (RXCHBONDI_RXUSRCLK1_dly(i),RXCHBONDI_ipd(i),tisd_RXCHBONDI_RXUSRCLK1(i));
      end generate RXCHBONDI_RXUSRCLK1_DELAY;
      RXENPRBSTST0_RXUSRCLK20_DELAY : for i in 2 downto 0 generate
        VitalSignalDelay (RXENPRBSTST0_RXUSRCLK20_dly(i),RXENPRBSTST0_ipd(i),tisd_RXENPRBSTST0_RXUSRCLK20(i));
      end generate RXENPRBSTST0_RXUSRCLK20_DELAY;
      RXENPRBSTST1_RXUSRCLK21_DELAY : for i in 2 downto 0 generate
        VitalSignalDelay (RXENPRBSTST1_RXUSRCLK21_dly(i),RXENPRBSTST1_ipd(i),tisd_RXENPRBSTST1_RXUSRCLK21(i));
      end generate RXENPRBSTST1_RXUSRCLK21_DELAY;
      TXBYPASS8B10B0_TXUSRCLK20_DELAY : for i in 3 downto 0 generate
        VitalSignalDelay (TXBYPASS8B10B0_TXUSRCLK20_dly(i),TXBYPASS8B10B0_ipd(i),tisd_TXBYPASS8B10B0_TXUSRCLK20(i));
      end generate TXBYPASS8B10B0_TXUSRCLK20_DELAY;
      TXBYPASS8B10B1_TXUSRCLK21_DELAY : for i in 3 downto 0 generate
        VitalSignalDelay (TXBYPASS8B10B1_TXUSRCLK21_dly(i),TXBYPASS8B10B1_ipd(i),tisd_TXBYPASS8B10B1_TXUSRCLK21(i));
      end generate TXBYPASS8B10B1_TXUSRCLK21_DELAY;
      TXCHARDISPMODE0_TXUSRCLK20_DELAY : for i in 3 downto 0 generate
        VitalSignalDelay (TXCHARDISPMODE0_TXUSRCLK20_dly(i),TXCHARDISPMODE0_ipd(i),tisd_TXCHARDISPMODE0_TXUSRCLK20(i));
      end generate TXCHARDISPMODE0_TXUSRCLK20_DELAY;
      TXCHARDISPMODE1_TXUSRCLK21_DELAY : for i in 3 downto 0 generate
        VitalSignalDelay (TXCHARDISPMODE1_TXUSRCLK21_dly(i),TXCHARDISPMODE1_ipd(i),tisd_TXCHARDISPMODE1_TXUSRCLK21(i));
      end generate TXCHARDISPMODE1_TXUSRCLK21_DELAY;
      TXCHARDISPVAL0_TXUSRCLK20_DELAY : for i in 3 downto 0 generate
        VitalSignalDelay (TXCHARDISPVAL0_TXUSRCLK20_dly(i),TXCHARDISPVAL0_ipd(i),tisd_TXCHARDISPVAL0_TXUSRCLK20(i));
      end generate TXCHARDISPVAL0_TXUSRCLK20_DELAY;
      TXCHARDISPVAL1_TXUSRCLK21_DELAY : for i in 3 downto 0 generate
        VitalSignalDelay (TXCHARDISPVAL1_TXUSRCLK21_dly(i),TXCHARDISPVAL1_ipd(i),tisd_TXCHARDISPVAL1_TXUSRCLK21(i));
      end generate TXCHARDISPVAL1_TXUSRCLK21_DELAY;
      TXCHARISK0_TXUSRCLK20_DELAY : for i in 3 downto 0 generate
        VitalSignalDelay (TXCHARISK0_TXUSRCLK20_dly(i),TXCHARISK0_ipd(i),tisd_TXCHARISK0_TXUSRCLK20(i));
      end generate TXCHARISK0_TXUSRCLK20_DELAY;
      TXCHARISK1_TXUSRCLK21_DELAY : for i in 3 downto 0 generate
        VitalSignalDelay (TXCHARISK1_TXUSRCLK21_dly(i),TXCHARISK1_ipd(i),tisd_TXCHARISK1_TXUSRCLK21(i));
      end generate TXCHARISK1_TXUSRCLK21_DELAY;
      TXDATA0_TXUSRCLK20_DELAY : for i in 31 downto 0 generate
        VitalSignalDelay (TXDATA0_TXUSRCLK20_dly(i),TXDATA0_ipd(i),tisd_TXDATA0_TXUSRCLK20(i));
      end generate TXDATA0_TXUSRCLK20_DELAY;
      TXDATA1_TXUSRCLK21_DELAY : for i in 31 downto 0 generate
        VitalSignalDelay (TXDATA1_TXUSRCLK21_dly(i),TXDATA1_ipd(i),tisd_TXDATA1_TXUSRCLK21(i));
      end generate TXDATA1_TXUSRCLK21_DELAY;
      TXENPRBSTST0_TXUSRCLK20_DELAY : for i in 2 downto 0 generate
        VitalSignalDelay (TXENPRBSTST0_TXUSRCLK20_dly(i),TXENPRBSTST0_ipd(i),tisd_TXENPRBSTST0_TXUSRCLK20(i));
      end generate TXENPRBSTST0_TXUSRCLK20_DELAY;
      TXENPRBSTST1_TXUSRCLK21_DELAY : for i in 2 downto 0 generate
        VitalSignalDelay (TXENPRBSTST1_TXUSRCLK21_dly(i),TXENPRBSTST1_ipd(i),tisd_TXENPRBSTST1_TXUSRCLK21(i));
      end generate TXENPRBSTST1_TXUSRCLK21_DELAY;
      TXPOWERDOWN0_TXUSRCLK20_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (TXPOWERDOWN0_TXUSRCLK20_dly(i),TXPOWERDOWN0_ipd(i),tisd_TXPOWERDOWN0_TXUSRCLK20(i));
      end generate TXPOWERDOWN0_TXUSRCLK20_DELAY;
      TXPOWERDOWN1_TXUSRCLK21_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (TXPOWERDOWN1_TXUSRCLK21_dly(i),TXPOWERDOWN1_ipd(i),tisd_TXPOWERDOWN1_TXUSRCLK21(i));
      end generate TXPOWERDOWN1_TXUSRCLK21_DELAY;
      VitalSignalDelay (DEN_DCLK_dly,DEN_ipd,tisd_DEN_DCLK);
      VitalSignalDelay (DWE_DCLK_dly,DWE_ipd,tisd_DWE_DCLK);
      VitalSignalDelay (PRBSCNTRESET0_RXUSRCLK20_dly,PRBSCNTRESET0_ipd,tisd_PRBSCNTRESET0_RXUSRCLK20);
      VitalSignalDelay (PRBSCNTRESET1_RXUSRCLK21_dly,PRBSCNTRESET1_ipd,tisd_PRBSCNTRESET1_RXUSRCLK21);
      VitalSignalDelay (RXCHBONDMASTER0_RXUSRCLK20_dly,RXCHBONDMASTER0_ipd,tisd_RXCHBONDMASTER0_RXUSRCLK20);
      VitalSignalDelay (RXCHBONDMASTER1_RXUSRCLK21_dly,RXCHBONDMASTER1_ipd,tisd_RXCHBONDMASTER1_RXUSRCLK21);
      VitalSignalDelay (RXCHBONDSLAVE0_RXUSRCLK20_dly,RXCHBONDSLAVE0_ipd,tisd_RXCHBONDSLAVE0_RXUSRCLK20);
      VitalSignalDelay (RXCHBONDSLAVE1_RXUSRCLK21_dly,RXCHBONDSLAVE1_ipd,tisd_RXCHBONDSLAVE1_RXUSRCLK21);
      VitalSignalDelay (RXCOMMADETUSE0_RXUSRCLK20_dly,RXCOMMADETUSE0_ipd,tisd_RXCOMMADETUSE0_RXUSRCLK20);
      VitalSignalDelay (RXCOMMADETUSE1_RXUSRCLK21_dly,RXCOMMADETUSE1_ipd,tisd_RXCOMMADETUSE1_RXUSRCLK21);
      VitalSignalDelay (RXDEC8B10BUSE0_RXUSRCLK20_dly,RXDEC8B10BUSE0_ipd,tisd_RXDEC8B10BUSE0_RXUSRCLK20);
      VitalSignalDelay (RXDEC8B10BUSE1_RXUSRCLK21_dly,RXDEC8B10BUSE1_ipd,tisd_RXDEC8B10BUSE1_RXUSRCLK21);
      VitalSignalDelay (RXENCHANSYNC0_RXUSRCLK20_dly,RXENCHANSYNC0_ipd,tisd_RXENCHANSYNC0_RXUSRCLK20);
      VitalSignalDelay (RXENCHANSYNC1_RXUSRCLK21_dly,RXENCHANSYNC1_ipd,tisd_RXENCHANSYNC1_RXUSRCLK21);
      VitalSignalDelay (RXENMCOMMAALIGN0_RXUSRCLK20_dly,RXENMCOMMAALIGN0_ipd,tisd_RXENMCOMMAALIGN0_RXUSRCLK20);
      VitalSignalDelay (RXENMCOMMAALIGN1_RXUSRCLK21_dly,RXENMCOMMAALIGN1_ipd,tisd_RXENMCOMMAALIGN1_RXUSRCLK21);
      VitalSignalDelay (RXENPCOMMAALIGN0_RXUSRCLK20_dly,RXENPCOMMAALIGN0_ipd,tisd_RXENPCOMMAALIGN0_RXUSRCLK20);
      VitalSignalDelay (RXENPCOMMAALIGN1_RXUSRCLK21_dly,RXENPCOMMAALIGN1_ipd,tisd_RXENPCOMMAALIGN1_RXUSRCLK21);
      VitalSignalDelay (RXPOLARITY0_RXUSRCLK20_dly,RXPOLARITY0_ipd,tisd_RXPOLARITY0_RXUSRCLK20);
      VitalSignalDelay (RXPOLARITY1_RXUSRCLK21_dly,RXPOLARITY1_ipd,tisd_RXPOLARITY1_RXUSRCLK21);
      VitalSignalDelay (RXSLIDE0_RXUSRCLK20_dly,RXSLIDE0_ipd,tisd_RXSLIDE0_RXUSRCLK20);
      VitalSignalDelay (RXSLIDE1_RXUSRCLK21_dly,RXSLIDE1_ipd,tisd_RXSLIDE1_RXUSRCLK21);
      VitalSignalDelay (TXCOMSTART0_TXUSRCLK20_dly,TXCOMSTART0_ipd,tisd_TXCOMSTART0_TXUSRCLK20);
      VitalSignalDelay (TXCOMSTART1_TXUSRCLK21_dly,TXCOMSTART1_ipd,tisd_TXCOMSTART1_TXUSRCLK21);
      VitalSignalDelay (TXCOMTYPE0_TXUSRCLK20_dly,TXCOMTYPE0_ipd,tisd_TXCOMTYPE0_TXUSRCLK20);
      VitalSignalDelay (TXCOMTYPE1_TXUSRCLK21_dly,TXCOMTYPE1_ipd,tisd_TXCOMTYPE1_TXUSRCLK21);
      VitalSignalDelay (TXDETECTRX0_TXUSRCLK20_dly,TXDETECTRX0_ipd,tisd_TXDETECTRX0_TXUSRCLK20);
      VitalSignalDelay (TXDETECTRX1_TXUSRCLK21_dly,TXDETECTRX1_ipd,tisd_TXDETECTRX1_TXUSRCLK21);
      VitalSignalDelay (TXELECIDLE0_TXUSRCLK20_dly,TXELECIDLE0_ipd,tisd_TXELECIDLE0_TXUSRCLK20);
      VitalSignalDelay (TXELECIDLE1_TXUSRCLK21_dly,TXELECIDLE1_ipd,tisd_TXELECIDLE1_TXUSRCLK21);
      VitalSignalDelay (TXENC8B10BUSE0_TXUSRCLK20_dly,TXENC8B10BUSE0_ipd,tisd_TXENC8B10BUSE0_TXUSRCLK20);
      VitalSignalDelay (TXENC8B10BUSE1_TXUSRCLK21_dly,TXENC8B10BUSE1_ipd,tisd_TXENC8B10BUSE1_TXUSRCLK21);
      VitalSignalDelay (TXINHIBIT0_TXUSRCLK20_dly,TXINHIBIT0_ipd,tisd_TXINHIBIT0_TXUSRCLK20);
      VitalSignalDelay (TXINHIBIT1_TXUSRCLK21_dly,TXINHIBIT1_ipd,tisd_TXINHIBIT1_TXUSRCLK21);
      VitalSignalDelay (TXPOLARITY0_TXUSRCLK20_dly,TXPOLARITY0_ipd,tisd_TXPOLARITY0_TXUSRCLK20);
      VitalSignalDelay (TXPOLARITY1_TXUSRCLK21_dly,TXPOLARITY1_ipd,tisd_TXPOLARITY1_TXUSRCLK21);
      VitalSignalDelay (TXPRBSFORCEERR0_TXUSRCLK20_dly,TXPRBSFORCEERR0_ipd,tisd_TXPRBSFORCEERR0_TXUSRCLK20);
      VitalSignalDelay (TXPRBSFORCEERR1_TXUSRCLK21_dly,TXPRBSFORCEERR1_ipd,tisd_TXPRBSFORCEERR1_TXUSRCLK21);
      VitalSignalDelay (USRCODEERR0_RXUSRCLK20_dly,USRCODEERR0_ipd,tisd_USRCODEERR0_RXUSRCLK20);
      VitalSignalDelay (USRCODEERR1_RXUSRCLK21_dly,USRCODEERR1_ipd,tisd_USRCODEERR1_RXUSRCLK21);

      VitalSignalDelay (CLK00_dly,CLK00_ipd,ticd_CLK00);
      VitalSignalDelay (CLK01_dly,CLK01_ipd,ticd_CLK01);
      VitalSignalDelay (CLK10_dly,CLK10_ipd,ticd_CLK10);
      VitalSignalDelay (CLK11_dly,CLK11_ipd,ticd_CLK11);
      VitalSignalDelay (CLKINEAST0_dly,CLKINEAST0_ipd,ticd_CLKINEAST0);
      VitalSignalDelay (CLKINEAST1_dly,CLKINEAST1_ipd,ticd_CLKINEAST1);
      VitalSignalDelay (CLKINWEST0_dly,CLKINWEST0_ipd,ticd_CLKINWEST0);
      VitalSignalDelay (CLKINWEST1_dly,CLKINWEST1_ipd,ticd_CLKINWEST1);
      VitalSignalDelay (DCLK_dly,DCLK_ipd,ticd_DCLK);
      VitalSignalDelay (GCLK00_dly,GCLK00_ipd,ticd_GCLK00);
      VitalSignalDelay (GCLK01_dly,GCLK01_ipd,ticd_GCLK01);
      VitalSignalDelay (GCLK10_dly,GCLK10_ipd,ticd_GCLK10);
      VitalSignalDelay (GCLK11_dly,GCLK11_ipd,ticd_GCLK11);
      VitalSignalDelay (PLLCLK00_dly,PLLCLK00_ipd,ticd_PLLCLK00);
      VitalSignalDelay (PLLCLK01_dly,PLLCLK01_ipd,ticd_PLLCLK01);
      VitalSignalDelay (PLLCLK10_dly,PLLCLK10_ipd,ticd_PLLCLK10);
      VitalSignalDelay (PLLCLK11_dly,PLLCLK11_ipd,ticd_PLLCLK11);
      VitalSignalDelay (RXUSRCLK0_dly,RXUSRCLK0_ipd,ticd_RXUSRCLK0);
      VitalSignalDelay (RXUSRCLK1_dly,RXUSRCLK1_ipd,ticd_RXUSRCLK1);
      VitalSignalDelay (RXUSRCLK20_dly,RXUSRCLK20_ipd,ticd_RXUSRCLK20);
      VitalSignalDelay (RXUSRCLK21_dly,RXUSRCLK21_ipd,ticd_RXUSRCLK21);
      VitalSignalDelay (TXUSRCLK20_dly,TXUSRCLK20_ipd,ticd_TXUSRCLK20);
      VitalSignalDelay (TXUSRCLK21_dly,TXUSRCLK21_ipd,ticd_TXUSRCLK21);
    end block;
    SELECTPROC: process (
      RXCHBONDI_RXUSRCLK0_dly,
      RXCHBONDI_RXUSRCLK1_dly)
    begin
      RXCHBONDI_FOR: for i in 2 downto 0 loop
        RXCHBONDI_IF : if(abs(tisd_RXCHBONDI_RXUSRCLK0(i))> abs(tisd_RXCHBONDI_RXUSRCLK1(i))) then
          RXCHBONDI_indly(i) <= RXCHBONDI_RXUSRCLK0_dly(i);
        else
          RXCHBONDI_indly(i) <= RXCHBONDI_RXUSRCLK1_dly(i);
        end if;
      end loop;
      end process SELECTPROC;

      --Input ports sensitive to single clock
    DADDR_indly <= DADDR_DCLK_dly;
    DEN_indly <= DEN_DCLK_dly;
    DI_indly <= DI_DCLK_dly;
    DWE_indly <= DWE_DCLK_dly;
    PRBSCNTRESET0_indly <= PRBSCNTRESET0_RXUSRCLK20_dly;
    PRBSCNTRESET1_indly <= PRBSCNTRESET1_RXUSRCLK21_dly;
    RXCHBONDMASTER0_indly <= RXCHBONDMASTER0_RXUSRCLK20_dly;
    RXCHBONDMASTER1_indly <= RXCHBONDMASTER1_RXUSRCLK21_dly;
    RXCHBONDSLAVE0_indly <= RXCHBONDSLAVE0_RXUSRCLK20_dly;
    RXCHBONDSLAVE1_indly <= RXCHBONDSLAVE1_RXUSRCLK21_dly;
    RXCOMMADETUSE0_indly <= RXCOMMADETUSE0_RXUSRCLK20_dly;
    RXCOMMADETUSE1_indly <= RXCOMMADETUSE1_RXUSRCLK21_dly;
    RXDEC8B10BUSE0_indly <= RXDEC8B10BUSE0_RXUSRCLK20_dly;
    RXDEC8B10BUSE1_indly <= RXDEC8B10BUSE1_RXUSRCLK21_dly;
    RXENCHANSYNC0_indly <= RXENCHANSYNC0_RXUSRCLK20_dly;
    RXENCHANSYNC1_indly <= RXENCHANSYNC1_RXUSRCLK21_dly;
    RXENMCOMMAALIGN0_indly <= RXENMCOMMAALIGN0_RXUSRCLK20_dly;
    RXENMCOMMAALIGN1_indly <= RXENMCOMMAALIGN1_RXUSRCLK21_dly;
    RXENPCOMMAALIGN0_indly <= RXENPCOMMAALIGN0_RXUSRCLK20_dly;
    RXENPCOMMAALIGN1_indly <= RXENPCOMMAALIGN1_RXUSRCLK21_dly;
    RXENPRBSTST0_indly <= RXENPRBSTST0_RXUSRCLK20_dly;
    RXENPRBSTST1_indly <= RXENPRBSTST1_RXUSRCLK21_dly;
    RXPOLARITY0_indly <= RXPOLARITY0_RXUSRCLK20_dly;
    RXPOLARITY1_indly <= RXPOLARITY1_RXUSRCLK21_dly;
    RXSLIDE0_indly <= RXSLIDE0_RXUSRCLK20_dly;
    RXSLIDE1_indly <= RXSLIDE1_RXUSRCLK21_dly;
    TXBYPASS8B10B0_indly <= TXBYPASS8B10B0_TXUSRCLK20_dly;
    TXBYPASS8B10B1_indly <= TXBYPASS8B10B1_TXUSRCLK21_dly;
    TXCHARDISPMODE0_indly <= TXCHARDISPMODE0_TXUSRCLK20_dly;
    TXCHARDISPMODE1_indly <= TXCHARDISPMODE1_TXUSRCLK21_dly;
    TXCHARDISPVAL0_indly <= TXCHARDISPVAL0_TXUSRCLK20_dly;
    TXCHARDISPVAL1_indly <= TXCHARDISPVAL1_TXUSRCLK21_dly;
    TXCHARISK0_indly <= TXCHARISK0_TXUSRCLK20_dly;
    TXCHARISK1_indly <= TXCHARISK1_TXUSRCLK21_dly;
    TXCOMSTART0_indly <= TXCOMSTART0_TXUSRCLK20_dly;
    TXCOMSTART1_indly <= TXCOMSTART1_TXUSRCLK21_dly;
    TXCOMTYPE0_indly <= TXCOMTYPE0_TXUSRCLK20_dly;
    TXCOMTYPE1_indly <= TXCOMTYPE1_TXUSRCLK21_dly;
    TXDATA0_indly <= TXDATA0_TXUSRCLK20_dly;
    TXDATA1_indly <= TXDATA1_TXUSRCLK21_dly;
    TXDETECTRX0_indly <= TXDETECTRX0_TXUSRCLK20_dly;
    TXDETECTRX1_indly <= TXDETECTRX1_TXUSRCLK21_dly;
    TXELECIDLE0_indly <= TXELECIDLE0_TXUSRCLK20_dly;
    TXELECIDLE1_indly <= TXELECIDLE1_TXUSRCLK21_dly;
    TXENC8B10BUSE0_indly <= TXENC8B10BUSE0_TXUSRCLK20_dly;
    TXENC8B10BUSE1_indly <= TXENC8B10BUSE1_TXUSRCLK21_dly;
    TXENPRBSTST0_indly <= TXENPRBSTST0_TXUSRCLK20_dly;
    TXENPRBSTST1_indly <= TXENPRBSTST1_TXUSRCLK21_dly;
    TXINHIBIT0_indly <= TXINHIBIT0_TXUSRCLK20_dly;
    TXINHIBIT1_indly <= TXINHIBIT1_TXUSRCLK21_dly;
    TXPOLARITY0_indly <= TXPOLARITY0_TXUSRCLK20_dly;
    TXPOLARITY1_indly <= TXPOLARITY1_TXUSRCLK21_dly;
    TXPOWERDOWN0_indly <= TXPOWERDOWN0_TXUSRCLK20_dly;
    TXPOWERDOWN1_indly <= TXPOWERDOWN1_TXUSRCLK21_dly;
    TXPRBSFORCEERR0_indly <= TXPRBSFORCEERR0_TXUSRCLK20_dly;
    TXPRBSFORCEERR1_indly <= TXPRBSFORCEERR1_TXUSRCLK21_dly;
    USRCODEERR0_indly <= USRCODEERR0_RXUSRCLK20_dly;
    USRCODEERR1_indly <= USRCODEERR1_RXUSRCLK21_dly;
    
    --Input ports sensitive to more than two clocks
    GATERXELECIDLE0_indly <= GATERXELECIDLE0_ipd;
    GATERXELECIDLE1_indly <= GATERXELECIDLE1_ipd;
    GTPCLKFBSEL0EAST_indly <= GTPCLKFBSEL0EAST_ipd;
    GTPCLKFBSEL0WEST_indly <= GTPCLKFBSEL0WEST_ipd;
    GTPCLKFBSEL1EAST_indly <= GTPCLKFBSEL1EAST_ipd;
    GTPCLKFBSEL1WEST_indly <= GTPCLKFBSEL1WEST_ipd;
    GTPRESET0_indly <= GTPRESET0_ipd;
    GTPRESET1_indly <= GTPRESET1_ipd;
    GTPTEST0_indly <= GTPTEST0_ipd;
    GTPTEST1_indly <= GTPTEST1_ipd;
    IGNORESIGDET0_indly <= IGNORESIGDET0_ipd;
    IGNORESIGDET1_indly <= IGNORESIGDET1_ipd;
    INTDATAWIDTH0_indly <= INTDATAWIDTH0_ipd;
    INTDATAWIDTH1_indly <= INTDATAWIDTH1_ipd;
    LOOPBACK0_indly <= LOOPBACK0_ipd;
    LOOPBACK1_indly <= LOOPBACK1_ipd;
    PLLLKDETEN0_indly <= PLLLKDETEN0_ipd;
    PLLLKDETEN1_indly <= PLLLKDETEN1_ipd;
    PLLPOWERDOWN0_indly <= PLLPOWERDOWN0_ipd;
    PLLPOWERDOWN1_indly <= PLLPOWERDOWN1_ipd;
    RCALINEAST_indly <= RCALINEAST_ipd;
    RCALINWEST_indly <= RCALINWEST_ipd;
    REFCLKPWRDNB0_indly <= REFCLKPWRDNB0_ipd;
    REFCLKPWRDNB1_indly <= REFCLKPWRDNB1_ipd;
    REFSELDYPLL0_indly <= REFSELDYPLL0_ipd;
    REFSELDYPLL1_indly <= REFSELDYPLL1_ipd;
    RXBUFRESET0_indly <= RXBUFRESET0_ipd;
    RXBUFRESET1_indly <= RXBUFRESET1_ipd;
    RXCDRRESET0_indly <= RXCDRRESET0_ipd;
    RXCDRRESET1_indly <= RXCDRRESET1_ipd;
    RXDATAWIDTH0_indly <= RXDATAWIDTH0_ipd;
    RXDATAWIDTH1_indly <= RXDATAWIDTH1_ipd;
    RXENPMAPHASEALIGN0_indly <= RXENPMAPHASEALIGN0_ipd;
    RXENPMAPHASEALIGN1_indly <= RXENPMAPHASEALIGN1_ipd;
    RXEQMIX0_indly <= RXEQMIX0_ipd;
    RXEQMIX1_indly <= RXEQMIX1_ipd;
    RXN0_indly <= RXN0_ipd;
    RXN1_indly <= RXN1_ipd;
    RXP0_indly <= RXP0_ipd;
    RXP1_indly <= RXP1_ipd;
    RXPMASETPHASE0_indly <= RXPMASETPHASE0_ipd;
    RXPMASETPHASE1_indly <= RXPMASETPHASE1_ipd;
    RXPOWERDOWN0_indly <= RXPOWERDOWN0_ipd;
    RXPOWERDOWN1_indly <= RXPOWERDOWN1_ipd;
    RXRESET0_indly <= RXRESET0_ipd;
    RXRESET1_indly <= RXRESET1_ipd;
    TSTCLK0_indly <= TSTCLK0_ipd;
    TSTCLK1_indly <= TSTCLK1_ipd;
    TSTIN0_indly <= TSTIN0_ipd;
    TSTIN1_indly <= TSTIN1_ipd;
    TXBUFDIFFCTRL0_indly <= TXBUFDIFFCTRL0_ipd;
    TXBUFDIFFCTRL1_indly <= TXBUFDIFFCTRL1_ipd;
    TXDATAWIDTH0_indly <= TXDATAWIDTH0_ipd;
    TXDATAWIDTH1_indly <= TXDATAWIDTH1_ipd;
    TXDIFFCTRL0_indly <= TXDIFFCTRL0_ipd;
    TXDIFFCTRL1_indly <= TXDIFFCTRL1_ipd;
    TXENPMAPHASEALIGN0_indly <= TXENPMAPHASEALIGN0_ipd;
    TXENPMAPHASEALIGN1_indly <= TXENPMAPHASEALIGN1_ipd;
    TXPDOWNASYNCH0_indly <= TXPDOWNASYNCH0_ipd;
    TXPDOWNASYNCH1_indly <= TXPDOWNASYNCH1_ipd;
    TXPMASETPHASE0_indly <= TXPMASETPHASE0_ipd;
    TXPMASETPHASE1_indly <= TXPMASETPHASE1_ipd;
    TXPREEMPHASIS0_indly <= TXPREEMPHASIS0_ipd;
    TXPREEMPHASIS1_indly <= TXPREEMPHASIS1_ipd;
    TXRESET0_indly <= TXRESET0_ipd;
    TXRESET1_indly <= TXRESET1_ipd;
    TXUSRCLK0_indly <= TXUSRCLK0_ipd;
    TXUSRCLK1_indly <= TXUSRCLK1_ipd;
    
    CLK00_indly <= CLK00_dly;
    CLK01_indly <= CLK01_dly;
    CLK10_indly <= CLK10_dly;
    CLK11_indly <= CLK11_dly;
    CLKINEAST0_indly <= CLKINEAST0_dly;
    CLKINEAST1_indly <= CLKINEAST1_dly;
    CLKINWEST0_indly <= CLKINWEST0_dly;
    CLKINWEST1_indly <= CLKINWEST1_dly;
    DCLK_indly <= DCLK_dly;
    GCLK00_indly <= GCLK00_dly;
    GCLK01_indly <= GCLK01_dly;
    GCLK10_indly <= GCLK10_dly;
    GCLK11_indly <= GCLK11_dly;
    PLLCLK00_indly <= PLLCLK00_dly;
    PLLCLK01_indly <= PLLCLK01_dly;
    PLLCLK10_indly <= PLLCLK10_dly;
    PLLCLK11_indly <= PLLCLK11_dly;
    RXUSRCLK0_indly <= RXUSRCLK0_dly;
    RXUSRCLK1_indly <= RXUSRCLK1_dly;
    RXUSRCLK20_indly <= RXUSRCLK20_dly;
    RXUSRCLK21_indly <= RXUSRCLK21_dly;
    TXUSRCLK20_indly <= TXUSRCLK20_dly;
    TXUSRCLK21_indly <= TXUSRCLK21_dly;

      GTPCLKOUT0_out <= GTPCLKOUT0_outdelay after OUTCLK_DELAY;
      GTPCLKOUT1_out <= GTPCLKOUT1_outdelay after OUTCLK_DELAY;
      REFCLKPLL0_out <= REFCLKPLL0_outdelay after OUTCLK_DELAY;
      REFCLKPLL1_out <= REFCLKPLL1_outdelay after OUTCLK_DELAY;
      
      DRDY_out <= DRDY_outdelay after OUT_DELAY;
      DRPDO_out <= DRPDO_outdelay after OUT_DELAY;
      GTPCLKFBEAST_out <= GTPCLKFBEAST_outdelay after OUT_DELAY;
      GTPCLKFBWEST_out <= GTPCLKFBWEST_outdelay after OUT_DELAY;
      PHYSTATUS0_out <= PHYSTATUS0_outdelay after OUT_DELAY;
      PHYSTATUS1_out <= PHYSTATUS1_outdelay after OUT_DELAY;
      PLLLKDET0_out <= PLLLKDET0_outdelay after OUT_DELAY;
      PLLLKDET1_out <= PLLLKDET1_outdelay after OUT_DELAY;
      RCALOUTEAST_out <= RCALOUTEAST_outdelay after OUT_DELAY;
      RCALOUTWEST_out <= RCALOUTWEST_outdelay after OUT_DELAY;
      REFCLKOUT0_out <= REFCLKOUT0_outdelay after OUT_DELAY;
      REFCLKOUT1_out <= REFCLKOUT1_outdelay after OUT_DELAY;
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
      RXCHBONDO_out <= RXCHBONDO_outdelay after OUT_DELAY;
      RXCLKCORCNT0_out <= RXCLKCORCNT0_outdelay after OUT_DELAY;
      RXCLKCORCNT1_out <= RXCLKCORCNT1_outdelay after OUT_DELAY;
      RXCOMMADET0_out <= RXCOMMADET0_outdelay after OUT_DELAY;
      RXCOMMADET1_out <= RXCOMMADET1_outdelay after OUT_DELAY;
      RXDATA0_out <= RXDATA0_outdelay after OUT_DELAY;
      RXDATA1_out <= RXDATA1_outdelay after OUT_DELAY;
      RXDISPERR0_out <= RXDISPERR0_outdelay after OUT_DELAY;
      RXDISPERR1_out <= RXDISPERR1_outdelay after OUT_DELAY;
      RXELECIDLE0_out <= RXELECIDLE0_outdelay after OUT_DELAY;
      RXELECIDLE1_out <= RXELECIDLE1_outdelay after OUT_DELAY;
      RXLOSSOFSYNC0_out <= RXLOSSOFSYNC0_outdelay after OUT_DELAY;
      RXLOSSOFSYNC1_out <= RXLOSSOFSYNC1_outdelay after OUT_DELAY;
      RXNOTINTABLE0_out <= RXNOTINTABLE0_outdelay after OUT_DELAY;
      RXNOTINTABLE1_out <= RXNOTINTABLE1_outdelay after OUT_DELAY;
      RXPRBSERR0_out <= RXPRBSERR0_outdelay after OUT_DELAY;
      RXPRBSERR1_out <= RXPRBSERR1_outdelay after OUT_DELAY;
      RXRECCLK0_out <= RXRECCLK0_outdelay after OUT_DELAY;
      RXRECCLK1_out <= RXRECCLK1_outdelay after OUT_DELAY;
      RXRUNDISP0_out <= RXRUNDISP0_outdelay after OUT_DELAY;
      RXRUNDISP1_out <= RXRUNDISP1_outdelay after OUT_DELAY;
      RXSTATUS0_out <= RXSTATUS0_outdelay after OUT_DELAY;
      RXSTATUS1_out <= RXSTATUS1_outdelay after OUT_DELAY;
      RXVALID0_out <= RXVALID0_outdelay after OUT_DELAY;
      RXVALID1_out <= RXVALID1_outdelay after OUT_DELAY;
      TSTOUT0_out <= TSTOUT0_outdelay after OUT_DELAY;
      TSTOUT1_out <= TSTOUT1_outdelay after OUT_DELAY;
      TXBUFSTATUS0_out <= TXBUFSTATUS0_outdelay after OUT_DELAY;
      TXBUFSTATUS1_out <= TXBUFSTATUS1_outdelay after OUT_DELAY;
      TXKERR0_out <= TXKERR0_outdelay after OUT_DELAY;
      TXKERR1_out <= TXKERR1_outdelay after OUT_DELAY;
      TXN0_out <= TXN0_outdelay after OUT_DELAY;
      TXN1_out <= TXN1_outdelay after OUT_DELAY;
      TXOUTCLK0_out <= TXOUTCLK0_outdelay after OUT_DELAY;
      TXOUTCLK1_out <= TXOUTCLK1_outdelay after OUT_DELAY;
      TXP0_out <= TXP0_outdelay after OUT_DELAY;
      TXP1_out <= TXP1_outdelay after OUT_DELAY;
      TXRUNDISP0_out <= TXRUNDISP0_outdelay after OUT_DELAY;
      TXRUNDISP1_out <= TXRUNDISP1_outdelay after OUT_DELAY;
      
    CLK00_indelay <= CLK00_indly after INCLK_DELAY;
    CLK01_indelay <= CLK01_indly after INCLK_DELAY;
    CLK10_indelay <= CLK10_indly after INCLK_DELAY;
    CLK11_indelay <= CLK11_indly after INCLK_DELAY;
    CLKINEAST0_indelay <= CLKINEAST0_indly after INCLK_DELAY;
    CLKINEAST1_indelay <= CLKINEAST1_indly after INCLK_DELAY;
    CLKINWEST0_indelay <= CLKINWEST0_indly after INCLK_DELAY;
    CLKINWEST1_indelay <= CLKINWEST1_indly after INCLK_DELAY;
    DCLK_indelay <= DCLK_indly after INCLK_DELAY;
    GCLK00_indelay <= GCLK00_indly after INCLK_DELAY;
    GCLK01_indelay <= GCLK01_indly after INCLK_DELAY;
    GCLK10_indelay <= GCLK10_indly after INCLK_DELAY;
    GCLK11_indelay <= GCLK11_indly after INCLK_DELAY;
    PLLCLK00_indelay <= PLLCLK00_indly after INCLK_DELAY;
    PLLCLK01_indelay <= PLLCLK01_indly after INCLK_DELAY;
    PLLCLK10_indelay <= PLLCLK10_indly after INCLK_DELAY;
    PLLCLK11_indelay <= PLLCLK11_indly after INCLK_DELAY;
    RXUSRCLK0_indelay <= RXUSRCLK0_indly after INCLK_DELAY;
    RXUSRCLK1_indelay <= RXUSRCLK1_indly after INCLK_DELAY;
    RXUSRCLK20_indelay <= RXUSRCLK20_indly after INCLK_DELAY;
    RXUSRCLK21_indelay <= RXUSRCLK21_indly after INCLK_DELAY;
    TSTCLK0_indelay <= TSTCLK0_indly after INCLK_DELAY;
    TSTCLK1_indelay <= TSTCLK1_indly after INCLK_DELAY;
    TXUSRCLK0_indelay <= TXUSRCLK0_indly after INCLK_DELAY;
    TXUSRCLK1_indelay <= TXUSRCLK1_indly after INCLK_DELAY;
    TXUSRCLK20_indelay <= TXUSRCLK20_indly after INCLK_DELAY;
    TXUSRCLK21_indelay <= TXUSRCLK21_indly after INCLK_DELAY;
    
    DADDR_indelay <= DADDR_indly after IN_DELAY;
    DEN_indelay <= DEN_indly after IN_DELAY;
    DI_indelay <= DI_indly after IN_DELAY;
    DWE_indelay <= DWE_indly after IN_DELAY;
    GATERXELECIDLE0_indelay <= GATERXELECIDLE0_indly after IN_DELAY;
    GATERXELECIDLE1_indelay <= GATERXELECIDLE1_indly after IN_DELAY;
    GTPCLKFBSEL0EAST_indelay <= GTPCLKFBSEL0EAST_indly after IN_DELAY;
    GTPCLKFBSEL0WEST_indelay <= GTPCLKFBSEL0WEST_indly after IN_DELAY;
    GTPCLKFBSEL1EAST_indelay <= GTPCLKFBSEL1EAST_indly after IN_DELAY;
    GTPCLKFBSEL1WEST_indelay <= GTPCLKFBSEL1WEST_indly after IN_DELAY;
    GTPRESET0_indelay <= GTPRESET0_indly after IN_DELAY;
    GTPRESET1_indelay <= GTPRESET1_indly after IN_DELAY;
    GTPTEST0_indelay <= GTPTEST0_indly after IN_DELAY;
    GTPTEST1_indelay <= GTPTEST1_indly after IN_DELAY;
    IGNORESIGDET0_indelay <= IGNORESIGDET0_indly after IN_DELAY;
    IGNORESIGDET1_indelay <= IGNORESIGDET1_indly after IN_DELAY;
    INTDATAWIDTH0_indelay <= INTDATAWIDTH0_indly after IN_DELAY;
    INTDATAWIDTH1_indelay <= INTDATAWIDTH1_indly after IN_DELAY;
    LOOPBACK0_indelay <= LOOPBACK0_indly after IN_DELAY;
    LOOPBACK1_indelay <= LOOPBACK1_indly after IN_DELAY;
    PLLLKDETEN0_indelay <= PLLLKDETEN0_indly after IN_DELAY;
    PLLLKDETEN1_indelay <= PLLLKDETEN1_indly after IN_DELAY;
    PLLPOWERDOWN0_indelay <= PLLPOWERDOWN0_indly after IN_DELAY;
    PLLPOWERDOWN1_indelay <= PLLPOWERDOWN1_indly after IN_DELAY;
    PRBSCNTRESET0_indelay <= PRBSCNTRESET0_indly after IN_DELAY;
    PRBSCNTRESET1_indelay <= PRBSCNTRESET1_indly after IN_DELAY;
    RCALINEAST_indelay <= RCALINEAST_indly after IN_DELAY;
    RCALINWEST_indelay <= RCALINWEST_indly after IN_DELAY;
    REFCLKPWRDNB0_indelay <= REFCLKPWRDNB0_indly after IN_DELAY;
    REFCLKPWRDNB1_indelay <= REFCLKPWRDNB1_indly after IN_DELAY;
    REFSELDYPLL0_indelay <= REFSELDYPLL0_indly after IN_DELAY;
    REFSELDYPLL1_indelay <= REFSELDYPLL1_indly after IN_DELAY;
    RXBUFRESET0_indelay <= RXBUFRESET0_indly after IN_DELAY;
    RXBUFRESET1_indelay <= RXBUFRESET1_indly after IN_DELAY;
    RXCDRRESET0_indelay <= RXCDRRESET0_indly after IN_DELAY;
    RXCDRRESET1_indelay <= RXCDRRESET1_indly after IN_DELAY;
    RXCHBONDI_indelay <= RXCHBONDI_indly after IN_DELAY;
    RXCHBONDMASTER0_indelay <= RXCHBONDMASTER0_indly after IN_DELAY;
    RXCHBONDMASTER1_indelay <= RXCHBONDMASTER1_indly after IN_DELAY;
    RXCHBONDSLAVE0_indelay <= RXCHBONDSLAVE0_indly after IN_DELAY;
    RXCHBONDSLAVE1_indelay <= RXCHBONDSLAVE1_indly after IN_DELAY;
    RXCOMMADETUSE0_indelay <= RXCOMMADETUSE0_indly after IN_DELAY;
    RXCOMMADETUSE1_indelay <= RXCOMMADETUSE1_indly after IN_DELAY;
    RXDATAWIDTH0_indelay <= RXDATAWIDTH0_indly after IN_DELAY;
    RXDATAWIDTH1_indelay <= RXDATAWIDTH1_indly after IN_DELAY;
    RXDEC8B10BUSE0_indelay <= RXDEC8B10BUSE0_indly after IN_DELAY;
    RXDEC8B10BUSE1_indelay <= RXDEC8B10BUSE1_indly after IN_DELAY;
    RXENCHANSYNC0_indelay <= RXENCHANSYNC0_indly after IN_DELAY;
    RXENCHANSYNC1_indelay <= RXENCHANSYNC1_indly after IN_DELAY;
    RXENMCOMMAALIGN0_indelay <= RXENMCOMMAALIGN0_indly after IN_DELAY;
    RXENMCOMMAALIGN1_indelay <= RXENMCOMMAALIGN1_indly after IN_DELAY;
    RXENPCOMMAALIGN0_indelay <= RXENPCOMMAALIGN0_indly after IN_DELAY;
    RXENPCOMMAALIGN1_indelay <= RXENPCOMMAALIGN1_indly after IN_DELAY;
    RXENPMAPHASEALIGN0_indelay <= RXENPMAPHASEALIGN0_indly after IN_DELAY;
    RXENPMAPHASEALIGN1_indelay <= RXENPMAPHASEALIGN1_indly after IN_DELAY;
    RXENPRBSTST0_indelay <= RXENPRBSTST0_indly after IN_DELAY;
    RXENPRBSTST1_indelay <= RXENPRBSTST1_indly after IN_DELAY;
    RXEQMIX0_indelay <= RXEQMIX0_indly after IN_DELAY;
    RXEQMIX1_indelay <= RXEQMIX1_indly after IN_DELAY;
    RXN0_indelay <= RXN0_indly after IN_DELAY;
    RXN1_indelay <= RXN1_indly after IN_DELAY;
    RXP0_indelay <= RXP0_indly after IN_DELAY;
    RXP1_indelay <= RXP1_indly after IN_DELAY;
    RXPMASETPHASE0_indelay <= RXPMASETPHASE0_indly after IN_DELAY;
    RXPMASETPHASE1_indelay <= RXPMASETPHASE1_indly after IN_DELAY;
    RXPOLARITY0_indelay <= RXPOLARITY0_indly after IN_DELAY;
    RXPOLARITY1_indelay <= RXPOLARITY1_indly after IN_DELAY;
    RXPOWERDOWN0_indelay <= RXPOWERDOWN0_indly after IN_DELAY;
    RXPOWERDOWN1_indelay <= RXPOWERDOWN1_indly after IN_DELAY;
    RXRESET0_indelay <= RXRESET0_indly after IN_DELAY;
    RXRESET1_indelay <= RXRESET1_indly after IN_DELAY;
    RXSLIDE0_indelay <= RXSLIDE0_indly after IN_DELAY;
    RXSLIDE1_indelay <= RXSLIDE1_indly after IN_DELAY;
    TSTIN0_indelay <= TSTIN0_indly after IN_DELAY;
    TSTIN1_indelay <= TSTIN1_indly after IN_DELAY;
    TXBUFDIFFCTRL0_indelay <= TXBUFDIFFCTRL0_indly after IN_DELAY;
    TXBUFDIFFCTRL1_indelay <= TXBUFDIFFCTRL1_indly after IN_DELAY;
    TXBYPASS8B10B0_indelay <= TXBYPASS8B10B0_indly after IN_DELAY;
    TXBYPASS8B10B1_indelay <= TXBYPASS8B10B1_indly after IN_DELAY;
    TXCHARDISPMODE0_indelay <= TXCHARDISPMODE0_indly after IN_DELAY;
    TXCHARDISPMODE1_indelay <= TXCHARDISPMODE1_indly after IN_DELAY;
    TXCHARDISPVAL0_indelay <= TXCHARDISPVAL0_indly after IN_DELAY;
    TXCHARDISPVAL1_indelay <= TXCHARDISPVAL1_indly after IN_DELAY;
    TXCHARISK0_indelay <= TXCHARISK0_indly after IN_DELAY;
    TXCHARISK1_indelay <= TXCHARISK1_indly after IN_DELAY;
    TXCOMSTART0_indelay <= TXCOMSTART0_indly after IN_DELAY;
    TXCOMSTART1_indelay <= TXCOMSTART1_indly after IN_DELAY;
    TXCOMTYPE0_indelay <= TXCOMTYPE0_indly after IN_DELAY;
    TXCOMTYPE1_indelay <= TXCOMTYPE1_indly after IN_DELAY;
    TXDATA0_indelay <= TXDATA0_indly after IN_DELAY;
    TXDATA1_indelay <= TXDATA1_indly after IN_DELAY;
    TXDATAWIDTH0_indelay <= TXDATAWIDTH0_indly after IN_DELAY;
    TXDATAWIDTH1_indelay <= TXDATAWIDTH1_indly after IN_DELAY;
    TXDETECTRX0_indelay <= TXDETECTRX0_indly after IN_DELAY;
    TXDETECTRX1_indelay <= TXDETECTRX1_indly after IN_DELAY;
    TXDIFFCTRL0_indelay <= TXDIFFCTRL0_indly after IN_DELAY;
    TXDIFFCTRL1_indelay <= TXDIFFCTRL1_indly after IN_DELAY;
    TXELECIDLE0_indelay <= TXELECIDLE0_indly after IN_DELAY;
    TXELECIDLE1_indelay <= TXELECIDLE1_indly after IN_DELAY;
    TXENC8B10BUSE0_indelay <= TXENC8B10BUSE0_indly after IN_DELAY;
    TXENC8B10BUSE1_indelay <= TXENC8B10BUSE1_indly after IN_DELAY;
    TXENPMAPHASEALIGN0_indelay <= TXENPMAPHASEALIGN0_indly after IN_DELAY;
    TXENPMAPHASEALIGN1_indelay <= TXENPMAPHASEALIGN1_indly after IN_DELAY;
    TXENPRBSTST0_indelay <= TXENPRBSTST0_indly after IN_DELAY;
    TXENPRBSTST1_indelay <= TXENPRBSTST1_indly after IN_DELAY;
    TXINHIBIT0_indelay <= TXINHIBIT0_indly after IN_DELAY;
    TXINHIBIT1_indelay <= TXINHIBIT1_indly after IN_DELAY;
    TXPDOWNASYNCH0_indelay <= TXPDOWNASYNCH0_indly after IN_DELAY;
    TXPDOWNASYNCH1_indelay <= TXPDOWNASYNCH1_indly after IN_DELAY;
    TXPMASETPHASE0_indelay <= TXPMASETPHASE0_indly after IN_DELAY;
    TXPMASETPHASE1_indelay <= TXPMASETPHASE1_indly after IN_DELAY;
    TXPOLARITY0_indelay <= TXPOLARITY0_indly after IN_DELAY;
    TXPOLARITY1_indelay <= TXPOLARITY1_indly after IN_DELAY;
    TXPOWERDOWN0_indelay <= TXPOWERDOWN0_indly after IN_DELAY;
    TXPOWERDOWN1_indelay <= TXPOWERDOWN1_indly after IN_DELAY;
    TXPRBSFORCEERR0_indelay <= TXPRBSFORCEERR0_indly after IN_DELAY;
    TXPRBSFORCEERR1_indelay <= TXPRBSFORCEERR1_indly after IN_DELAY;
    TXPREEMPHASIS0_indelay <= TXPREEMPHASIS0_indly after IN_DELAY;
    TXPREEMPHASIS1_indelay <= TXPREEMPHASIS1_indly after IN_DELAY;
    TXRESET0_indelay <= TXRESET0_indly after IN_DELAY;
    TXRESET1_indelay <= TXRESET1_indly after IN_DELAY;
    USRCODEERR0_indelay <= USRCODEERR0_indly after IN_DELAY;
    USRCODEERR1_indelay <= USRCODEERR1_indly after IN_DELAY;

      GSR_dly <= GSR;
    
      GTPA1_DUAL_WRAP_INST : GTPA1_DUAL_WRAP
        generic map (
          AC_CAP_DIS_0         => AC_CAP_DIS_0_STRING,
          AC_CAP_DIS_1         => AC_CAP_DIS_1_STRING,
          ALIGN_COMMA_WORD_0   => ALIGN_COMMA_WORD_0,
          ALIGN_COMMA_WORD_1   => ALIGN_COMMA_WORD_1,
          CB2_INH_CC_PERIOD_0  => CB2_INH_CC_PERIOD_0,
          CB2_INH_CC_PERIOD_1  => CB2_INH_CC_PERIOD_1,
          CDR_PH_ADJ_TIME_0    => CDR_PH_ADJ_TIME_0_STRING,
          CDR_PH_ADJ_TIME_1    => CDR_PH_ADJ_TIME_1_STRING,
          CHAN_BOND_1_MAX_SKEW_0 => CHAN_BOND_1_MAX_SKEW_0,
          CHAN_BOND_1_MAX_SKEW_1 => CHAN_BOND_1_MAX_SKEW_1,
          CHAN_BOND_2_MAX_SKEW_0 => CHAN_BOND_2_MAX_SKEW_0,
          CHAN_BOND_2_MAX_SKEW_1 => CHAN_BOND_2_MAX_SKEW_1,
          CHAN_BOND_KEEP_ALIGN_0 => CHAN_BOND_KEEP_ALIGN_0_STRING,
          CHAN_BOND_KEEP_ALIGN_1 => CHAN_BOND_KEEP_ALIGN_1_STRING,
          CHAN_BOND_SEQ_1_1_0  => CHAN_BOND_SEQ_1_1_0_STRING,
          CHAN_BOND_SEQ_1_1_1  => CHAN_BOND_SEQ_1_1_1_STRING,
          CHAN_BOND_SEQ_1_2_0  => CHAN_BOND_SEQ_1_2_0_STRING,
          CHAN_BOND_SEQ_1_2_1  => CHAN_BOND_SEQ_1_2_1_STRING,
          CHAN_BOND_SEQ_1_3_0  => CHAN_BOND_SEQ_1_3_0_STRING,
          CHAN_BOND_SEQ_1_3_1  => CHAN_BOND_SEQ_1_3_1_STRING,
          CHAN_BOND_SEQ_1_4_0  => CHAN_BOND_SEQ_1_4_0_STRING,
          CHAN_BOND_SEQ_1_4_1  => CHAN_BOND_SEQ_1_4_1_STRING,
          CHAN_BOND_SEQ_1_ENABLE_0 => CHAN_BOND_SEQ_1_ENABLE_0_STRING,
          CHAN_BOND_SEQ_1_ENABLE_1 => CHAN_BOND_SEQ_1_ENABLE_1_STRING,
          CHAN_BOND_SEQ_2_1_0  => CHAN_BOND_SEQ_2_1_0_STRING,
          CHAN_BOND_SEQ_2_1_1  => CHAN_BOND_SEQ_2_1_1_STRING,
          CHAN_BOND_SEQ_2_2_0  => CHAN_BOND_SEQ_2_2_0_STRING,
          CHAN_BOND_SEQ_2_2_1  => CHAN_BOND_SEQ_2_2_1_STRING,
          CHAN_BOND_SEQ_2_3_0  => CHAN_BOND_SEQ_2_3_0_STRING,
          CHAN_BOND_SEQ_2_3_1  => CHAN_BOND_SEQ_2_3_1_STRING,
          CHAN_BOND_SEQ_2_4_0  => CHAN_BOND_SEQ_2_4_0_STRING,
          CHAN_BOND_SEQ_2_4_1  => CHAN_BOND_SEQ_2_4_1_STRING,
          CHAN_BOND_SEQ_2_ENABLE_0 => CHAN_BOND_SEQ_2_ENABLE_0_STRING,
          CHAN_BOND_SEQ_2_ENABLE_1 => CHAN_BOND_SEQ_2_ENABLE_1_STRING,
          CHAN_BOND_SEQ_2_USE_0 => CHAN_BOND_SEQ_2_USE_0_STRING,
          CHAN_BOND_SEQ_2_USE_1 => CHAN_BOND_SEQ_2_USE_1_STRING,
          CHAN_BOND_SEQ_LEN_0  => CHAN_BOND_SEQ_LEN_0,
          CHAN_BOND_SEQ_LEN_1  => CHAN_BOND_SEQ_LEN_1,
          CLK25_DIVIDER_0      => CLK25_DIVIDER_0,
          CLK25_DIVIDER_1      => CLK25_DIVIDER_1,
          CLKINDC_B_0          => CLKINDC_B_0_STRING,
          CLKINDC_B_1          => CLKINDC_B_1_STRING,
          CLKRCV_TRST_0        => CLKRCV_TRST_0_STRING,
          CLKRCV_TRST_1        => CLKRCV_TRST_1_STRING,
          CLK_CORRECT_USE_0    => CLK_CORRECT_USE_0_STRING,
          CLK_CORRECT_USE_1    => CLK_CORRECT_USE_1_STRING,
          CLK_COR_ADJ_LEN_0    => CLK_COR_ADJ_LEN_0,
          CLK_COR_ADJ_LEN_1    => CLK_COR_ADJ_LEN_1,
          CLK_COR_DET_LEN_0    => CLK_COR_DET_LEN_0,
          CLK_COR_DET_LEN_1    => CLK_COR_DET_LEN_1,
          CLK_COR_INSERT_IDLE_FLAG_0 => CLK_COR_INSERT_IDLE_FLAG_0_STRING,
          CLK_COR_INSERT_IDLE_FLAG_1 => CLK_COR_INSERT_IDLE_FLAG_1_STRING,
          CLK_COR_KEEP_IDLE_0  => CLK_COR_KEEP_IDLE_0_STRING,
          CLK_COR_KEEP_IDLE_1  => CLK_COR_KEEP_IDLE_1_STRING,
          CLK_COR_MAX_LAT_0    => CLK_COR_MAX_LAT_0,
          CLK_COR_MAX_LAT_1    => CLK_COR_MAX_LAT_1,
          CLK_COR_MIN_LAT_0    => CLK_COR_MIN_LAT_0,
          CLK_COR_MIN_LAT_1    => CLK_COR_MIN_LAT_1,
          CLK_COR_PRECEDENCE_0 => CLK_COR_PRECEDENCE_0_STRING,
          CLK_COR_PRECEDENCE_1 => CLK_COR_PRECEDENCE_1_STRING,
          CLK_COR_REPEAT_WAIT_0 => CLK_COR_REPEAT_WAIT_0,
          CLK_COR_REPEAT_WAIT_1 => CLK_COR_REPEAT_WAIT_1,
          CLK_COR_SEQ_1_1_0    => CLK_COR_SEQ_1_1_0_STRING,
          CLK_COR_SEQ_1_1_1    => CLK_COR_SEQ_1_1_1_STRING,
          CLK_COR_SEQ_1_2_0    => CLK_COR_SEQ_1_2_0_STRING,
          CLK_COR_SEQ_1_2_1    => CLK_COR_SEQ_1_2_1_STRING,
          CLK_COR_SEQ_1_3_0    => CLK_COR_SEQ_1_3_0_STRING,
          CLK_COR_SEQ_1_3_1    => CLK_COR_SEQ_1_3_1_STRING,
          CLK_COR_SEQ_1_4_0    => CLK_COR_SEQ_1_4_0_STRING,
          CLK_COR_SEQ_1_4_1    => CLK_COR_SEQ_1_4_1_STRING,
          CLK_COR_SEQ_1_ENABLE_0 => CLK_COR_SEQ_1_ENABLE_0_STRING,
          CLK_COR_SEQ_1_ENABLE_1 => CLK_COR_SEQ_1_ENABLE_1_STRING,
          CLK_COR_SEQ_2_1_0    => CLK_COR_SEQ_2_1_0_STRING,
          CLK_COR_SEQ_2_1_1    => CLK_COR_SEQ_2_1_1_STRING,
          CLK_COR_SEQ_2_2_0    => CLK_COR_SEQ_2_2_0_STRING,
          CLK_COR_SEQ_2_2_1    => CLK_COR_SEQ_2_2_1_STRING,
          CLK_COR_SEQ_2_3_0    => CLK_COR_SEQ_2_3_0_STRING,
          CLK_COR_SEQ_2_3_1    => CLK_COR_SEQ_2_3_1_STRING,
          CLK_COR_SEQ_2_4_0    => CLK_COR_SEQ_2_4_0_STRING,
          CLK_COR_SEQ_2_4_1    => CLK_COR_SEQ_2_4_1_STRING,
          CLK_COR_SEQ_2_ENABLE_0 => CLK_COR_SEQ_2_ENABLE_0_STRING,
          CLK_COR_SEQ_2_ENABLE_1 => CLK_COR_SEQ_2_ENABLE_1_STRING,
          CLK_COR_SEQ_2_USE_0  => CLK_COR_SEQ_2_USE_0_STRING,
          CLK_COR_SEQ_2_USE_1  => CLK_COR_SEQ_2_USE_1_STRING,
          CLK_OUT_GTP_SEL_0    => CLK_OUT_GTP_SEL_0,
          CLK_OUT_GTP_SEL_1    => CLK_OUT_GTP_SEL_1,
          CM_TRIM_0            => CM_TRIM_0_STRING,
          CM_TRIM_1            => CM_TRIM_1_STRING,
          COMMA_10B_ENABLE_0   => COMMA_10B_ENABLE_0_STRING,
          COMMA_10B_ENABLE_1   => COMMA_10B_ENABLE_1_STRING,
          COM_BURST_VAL_0      => COM_BURST_VAL_0_STRING,
          COM_BURST_VAL_1      => COM_BURST_VAL_1_STRING,
          DEC_MCOMMA_DETECT_0  => DEC_MCOMMA_DETECT_0_STRING,
          DEC_MCOMMA_DETECT_1  => DEC_MCOMMA_DETECT_1_STRING,
          DEC_PCOMMA_DETECT_0  => DEC_PCOMMA_DETECT_0_STRING,
          DEC_PCOMMA_DETECT_1  => DEC_PCOMMA_DETECT_1_STRING,
          DEC_VALID_COMMA_ONLY_0 => DEC_VALID_COMMA_ONLY_0_STRING,
          DEC_VALID_COMMA_ONLY_1 => DEC_VALID_COMMA_ONLY_1_STRING,
          GTP_CFG_PWRUP_0      => GTP_CFG_PWRUP_0_STRING,
          GTP_CFG_PWRUP_1      => GTP_CFG_PWRUP_1_STRING,
          MCOMMA_10B_VALUE_0   => MCOMMA_10B_VALUE_0_STRING,
          MCOMMA_10B_VALUE_1   => MCOMMA_10B_VALUE_1_STRING,
          MCOMMA_DETECT_0      => MCOMMA_DETECT_0_STRING,
          MCOMMA_DETECT_1      => MCOMMA_DETECT_1_STRING,
          OOBDETECT_THRESHOLD_0 => OOBDETECT_THRESHOLD_0_STRING,
          OOBDETECT_THRESHOLD_1 => OOBDETECT_THRESHOLD_1_STRING,
          OOB_CLK_DIVIDER_0    => OOB_CLK_DIVIDER_0,
          OOB_CLK_DIVIDER_1    => OOB_CLK_DIVIDER_1,
          PCI_EXPRESS_MODE_0   => PCI_EXPRESS_MODE_0_STRING,
          PCI_EXPRESS_MODE_1   => PCI_EXPRESS_MODE_1_STRING,
          PCOMMA_10B_VALUE_0   => PCOMMA_10B_VALUE_0_STRING,
          PCOMMA_10B_VALUE_1   => PCOMMA_10B_VALUE_1_STRING,
          PCOMMA_DETECT_0      => PCOMMA_DETECT_0_STRING,
          PCOMMA_DETECT_1      => PCOMMA_DETECT_1_STRING,
          PLLLKDET_CFG_0       => PLLLKDET_CFG_0_STRING,
          PLLLKDET_CFG_1       => PLLLKDET_CFG_1_STRING,
          PLL_COM_CFG_0        => PLL_COM_CFG_0_STRING,
          PLL_COM_CFG_1        => PLL_COM_CFG_1_STRING,
          PLL_CP_CFG_0         => PLL_CP_CFG_0_STRING,
          PLL_CP_CFG_1         => PLL_CP_CFG_1_STRING,
          PLL_DIVSEL_FB_0      => PLL_DIVSEL_FB_0,
          PLL_DIVSEL_FB_1      => PLL_DIVSEL_FB_1,
          PLL_DIVSEL_REF_0     => PLL_DIVSEL_REF_0,
          PLL_DIVSEL_REF_1     => PLL_DIVSEL_REF_1,
          PLL_RXDIVSEL_OUT_0   => PLL_RXDIVSEL_OUT_0,
          PLL_RXDIVSEL_OUT_1   => PLL_RXDIVSEL_OUT_1,
          PLL_SATA_0           => PLL_SATA_0_STRING,
          PLL_SATA_1           => PLL_SATA_1_STRING,
          PLL_SOURCE_0         => PLL_SOURCE_0,
          PLL_SOURCE_1         => PLL_SOURCE_1,
          PLL_TXDIVSEL_OUT_0   => PLL_TXDIVSEL_OUT_0,
          PLL_TXDIVSEL_OUT_1   => PLL_TXDIVSEL_OUT_1,
          PMA_CDR_SCAN_0       => PMA_CDR_SCAN_0_STRING,
          PMA_CDR_SCAN_1       => PMA_CDR_SCAN_1_STRING,
          PMA_COM_CFG_EAST     => PMA_COM_CFG_EAST_STRING,
          PMA_COM_CFG_WEST     => PMA_COM_CFG_WEST_STRING,
          PMA_RXSYNC_CFG_0     => PMA_RXSYNC_CFG_0_STRING,
          PMA_RXSYNC_CFG_1     => PMA_RXSYNC_CFG_1_STRING,
          PMA_RX_CFG_0         => PMA_RX_CFG_0_STRING,
          PMA_RX_CFG_1         => PMA_RX_CFG_1_STRING,
          PMA_TX_CFG_0         => PMA_TX_CFG_0_STRING,
          PMA_TX_CFG_1         => PMA_TX_CFG_1_STRING,
          RCV_TERM_GND_0       => RCV_TERM_GND_0_STRING,
          RCV_TERM_GND_1       => RCV_TERM_GND_1_STRING,
          RCV_TERM_VTTRX_0     => RCV_TERM_VTTRX_0_STRING,
          RCV_TERM_VTTRX_1     => RCV_TERM_VTTRX_1_STRING,
          RXEQ_CFG_0           => RXEQ_CFG_0_STRING,
          RXEQ_CFG_1           => RXEQ_CFG_1_STRING,
          RXPRBSERR_LOOPBACK_0 => RXPRBSERR_LOOPBACK_0_STRING,
          RXPRBSERR_LOOPBACK_1 => RXPRBSERR_LOOPBACK_1_STRING,
          RX_BUFFER_USE_0      => RX_BUFFER_USE_0_STRING,
          RX_BUFFER_USE_1      => RX_BUFFER_USE_1_STRING,
          RX_DECODE_SEQ_MATCH_0 => RX_DECODE_SEQ_MATCH_0_STRING,
          RX_DECODE_SEQ_MATCH_1 => RX_DECODE_SEQ_MATCH_1_STRING,
          RX_EN_IDLE_HOLD_CDR_0 => RX_EN_IDLE_HOLD_CDR_0_STRING,
          RX_EN_IDLE_HOLD_CDR_1 => RX_EN_IDLE_HOLD_CDR_1_STRING,
          RX_EN_IDLE_RESET_BUF_0 => RX_EN_IDLE_RESET_BUF_0_STRING,
          RX_EN_IDLE_RESET_BUF_1 => RX_EN_IDLE_RESET_BUF_1_STRING,
          RX_EN_IDLE_RESET_FR_0 => RX_EN_IDLE_RESET_FR_0_STRING,
          RX_EN_IDLE_RESET_FR_1 => RX_EN_IDLE_RESET_FR_1_STRING,
          RX_EN_IDLE_RESET_PH_0 => RX_EN_IDLE_RESET_PH_0_STRING,
          RX_EN_IDLE_RESET_PH_1 => RX_EN_IDLE_RESET_PH_1_STRING,
          RX_EN_MODE_RESET_BUF_0 => RX_EN_MODE_RESET_BUF_0_STRING,
          RX_EN_MODE_RESET_BUF_1 => RX_EN_MODE_RESET_BUF_1_STRING,
          RX_IDLE_HI_CNT_0     => RX_IDLE_HI_CNT_0_STRING,
          RX_IDLE_HI_CNT_1     => RX_IDLE_HI_CNT_1_STRING,
          RX_IDLE_LO_CNT_0     => RX_IDLE_LO_CNT_0_STRING,
          RX_IDLE_LO_CNT_1     => RX_IDLE_LO_CNT_1_STRING,
          RX_LOSS_OF_SYNC_FSM_0 => RX_LOSS_OF_SYNC_FSM_0_STRING,
          RX_LOSS_OF_SYNC_FSM_1 => RX_LOSS_OF_SYNC_FSM_1_STRING,
          RX_LOS_INVALID_INCR_0 => RX_LOS_INVALID_INCR_0,
          RX_LOS_INVALID_INCR_1 => RX_LOS_INVALID_INCR_1,
          RX_LOS_THRESHOLD_0   => RX_LOS_THRESHOLD_0,
          RX_LOS_THRESHOLD_1   => RX_LOS_THRESHOLD_1,
          RX_SLIDE_MODE_0      => RX_SLIDE_MODE_0,
          RX_SLIDE_MODE_1      => RX_SLIDE_MODE_1,
          RX_STATUS_FMT_0      => RX_STATUS_FMT_0,
          RX_STATUS_FMT_1      => RX_STATUS_FMT_1,
          RX_XCLK_SEL_0        => RX_XCLK_SEL_0,
          RX_XCLK_SEL_1        => RX_XCLK_SEL_1,
          SATA_BURST_VAL_0     => SATA_BURST_VAL_0_STRING,
          SATA_BURST_VAL_1     => SATA_BURST_VAL_1_STRING,
          SATA_IDLE_VAL_0      => SATA_IDLE_VAL_0_STRING,
          SATA_IDLE_VAL_1      => SATA_IDLE_VAL_1_STRING,
          SATA_MAX_BURST_0     => SATA_MAX_BURST_0,
          SATA_MAX_BURST_1     => SATA_MAX_BURST_1,
          SATA_MAX_INIT_0      => SATA_MAX_INIT_0,
          SATA_MAX_INIT_1      => SATA_MAX_INIT_1,
          SATA_MAX_WAKE_0      => SATA_MAX_WAKE_0,
          SATA_MAX_WAKE_1      => SATA_MAX_WAKE_1,
          SATA_MIN_BURST_0     => SATA_MIN_BURST_0,
          SATA_MIN_BURST_1     => SATA_MIN_BURST_1,
          SATA_MIN_INIT_0      => SATA_MIN_INIT_0,
          SATA_MIN_INIT_1      => SATA_MIN_INIT_1,
          SATA_MIN_WAKE_0      => SATA_MIN_WAKE_0,
          SATA_MIN_WAKE_1      => SATA_MIN_WAKE_1,
          SIM_GTPRESET_SPEEDUP => SIM_GTPRESET_SPEEDUP,
          SIM_RECEIVER_DETECT_PASS => SIM_RECEIVER_DETECT_PASS_STRING,
          SIM_REFCLK0_SOURCE   => SIM_REFCLK0_SOURCE_STRING,
          SIM_REFCLK1_SOURCE   => SIM_REFCLK1_SOURCE_STRING,
          SIM_TX_ELEC_IDLE_LEVEL => SIM_TX_ELEC_IDLE_LEVEL,
          SIM_VERSION          => SIM_VERSION,
          TERMINATION_CTRL_0   => TERMINATION_CTRL_0_STRING,
          TERMINATION_CTRL_1   => TERMINATION_CTRL_1_STRING,
          TERMINATION_OVRD_0   => TERMINATION_OVRD_0_STRING,
          TERMINATION_OVRD_1   => TERMINATION_OVRD_1_STRING,
          TRANS_TIME_FROM_P2_0 => TRANS_TIME_FROM_P2_0_STRING,
          TRANS_TIME_FROM_P2_1 => TRANS_TIME_FROM_P2_1_STRING,
          TRANS_TIME_NON_P2_0  => TRANS_TIME_NON_P2_0_STRING,
          TRANS_TIME_NON_P2_1  => TRANS_TIME_NON_P2_1_STRING,
          TRANS_TIME_TO_P2_0   => TRANS_TIME_TO_P2_0_STRING,
          TRANS_TIME_TO_P2_1   => TRANS_TIME_TO_P2_1_STRING,
          TST_ATTR_0           => TST_ATTR_0_STRING,
          TST_ATTR_1           => TST_ATTR_1_STRING,
          TXRX_INVERT_0        => TXRX_INVERT_0_STRING,
          TXRX_INVERT_1        => TXRX_INVERT_1_STRING,
          TX_BUFFER_USE_0      => TX_BUFFER_USE_0_STRING,
          TX_BUFFER_USE_1      => TX_BUFFER_USE_1_STRING,
          TX_DETECT_RX_CFG_0   => TX_DETECT_RX_CFG_0_STRING,
          TX_DETECT_RX_CFG_1   => TX_DETECT_RX_CFG_1_STRING,
          TX_IDLE_DELAY_0      => TX_IDLE_DELAY_0_STRING,
          TX_IDLE_DELAY_1      => TX_IDLE_DELAY_1_STRING,
          TX_TDCC_CFG_0        => TX_TDCC_CFG_0_STRING,
          TX_TDCC_CFG_1        => TX_TDCC_CFG_1_STRING,
          TX_XCLK_SEL_0        => TX_XCLK_SEL_0,
          TX_XCLK_SEL_1        => TX_XCLK_SEL_1
        )
      
      port map (
          DRDY                 => DRDY_outdelay,
          DRPDO                => DRPDO_outdelay,
          GTPCLKFBEAST         => GTPCLKFBEAST_outdelay,
          GTPCLKFBWEST         => GTPCLKFBWEST_outdelay,
          GTPCLKOUT0           => GTPCLKOUT0_outdelay,
          GTPCLKOUT1           => GTPCLKOUT1_outdelay,
          PHYSTATUS0           => PHYSTATUS0_outdelay,
          PHYSTATUS1           => PHYSTATUS1_outdelay,
          PLLLKDET0            => PLLLKDET0_outdelay,
          PLLLKDET1            => PLLLKDET1_outdelay,
          RCALOUTEAST          => RCALOUTEAST_outdelay,
          RCALOUTWEST          => RCALOUTWEST_outdelay,
          REFCLKOUT0           => REFCLKOUT0_outdelay,
          REFCLKOUT1           => REFCLKOUT1_outdelay,
          REFCLKPLL0           => REFCLKPLL0_outdelay,
          REFCLKPLL1           => REFCLKPLL1_outdelay,
          RESETDONE0           => RESETDONE0_outdelay,
          RESETDONE1           => RESETDONE1_outdelay,
          RXBUFSTATUS0         => RXBUFSTATUS0_outdelay,
          RXBUFSTATUS1         => RXBUFSTATUS1_outdelay,
          RXBYTEISALIGNED0     => RXBYTEISALIGNED0_outdelay,
          RXBYTEISALIGNED1     => RXBYTEISALIGNED1_outdelay,
          RXBYTEREALIGN0       => RXBYTEREALIGN0_outdelay,
          RXBYTEREALIGN1       => RXBYTEREALIGN1_outdelay,
          RXCHANBONDSEQ0       => RXCHANBONDSEQ0_outdelay,
          RXCHANBONDSEQ1       => RXCHANBONDSEQ1_outdelay,
          RXCHANISALIGNED0     => RXCHANISALIGNED0_outdelay,
          RXCHANISALIGNED1     => RXCHANISALIGNED1_outdelay,
          RXCHANREALIGN0       => RXCHANREALIGN0_outdelay,
          RXCHANREALIGN1       => RXCHANREALIGN1_outdelay,
          RXCHARISCOMMA0       => RXCHARISCOMMA0_outdelay,
          RXCHARISCOMMA1       => RXCHARISCOMMA1_outdelay,
          RXCHARISK0           => RXCHARISK0_outdelay,
          RXCHARISK1           => RXCHARISK1_outdelay,
          RXCHBONDO            => RXCHBONDO_outdelay,
          RXCLKCORCNT0         => RXCLKCORCNT0_outdelay,
          RXCLKCORCNT1         => RXCLKCORCNT1_outdelay,
          RXCOMMADET0          => RXCOMMADET0_outdelay,
          RXCOMMADET1          => RXCOMMADET1_outdelay,
          RXDATA0              => RXDATA0_outdelay,
          RXDATA1              => RXDATA1_outdelay,
          RXDISPERR0           => RXDISPERR0_outdelay,
          RXDISPERR1           => RXDISPERR1_outdelay,
          RXELECIDLE0          => RXELECIDLE0_outdelay,
          RXELECIDLE1          => RXELECIDLE1_outdelay,
          RXLOSSOFSYNC0        => RXLOSSOFSYNC0_outdelay,
          RXLOSSOFSYNC1        => RXLOSSOFSYNC1_outdelay,
          RXNOTINTABLE0        => RXNOTINTABLE0_outdelay,
          RXNOTINTABLE1        => RXNOTINTABLE1_outdelay,
          RXPRBSERR0           => RXPRBSERR0_outdelay,
          RXPRBSERR1           => RXPRBSERR1_outdelay,
          RXRECCLK0            => RXRECCLK0_outdelay,
          RXRECCLK1            => RXRECCLK1_outdelay,
          RXRUNDISP0           => RXRUNDISP0_outdelay,
          RXRUNDISP1           => RXRUNDISP1_outdelay,
          RXSTATUS0            => RXSTATUS0_outdelay,
          RXSTATUS1            => RXSTATUS1_outdelay,
          RXVALID0             => RXVALID0_outdelay,
          RXVALID1             => RXVALID1_outdelay,
          TSTOUT0              => TSTOUT0_outdelay,
          TSTOUT1              => TSTOUT1_outdelay,
          TXBUFSTATUS0         => TXBUFSTATUS0_outdelay,
          TXBUFSTATUS1         => TXBUFSTATUS1_outdelay,
          TXKERR0              => TXKERR0_outdelay,
          TXKERR1              => TXKERR1_outdelay,
          TXN0                 => TXN0_outdelay,
          TXN1                 => TXN1_outdelay,
          TXOUTCLK0            => TXOUTCLK0_outdelay,
          TXOUTCLK1            => TXOUTCLK1_outdelay,
          TXP0                 => TXP0_outdelay,
          TXP1                 => TXP1_outdelay,
          TXRUNDISP0           => TXRUNDISP0_outdelay,
          TXRUNDISP1           => TXRUNDISP1_outdelay,
          CLK00                => CLK00_indelay,
          CLK01                => CLK01_indelay,
          CLK10                => CLK10_indelay,
          CLK11                => CLK11_indelay,
          CLKINEAST0           => CLKINEAST0_indelay,
          CLKINEAST1           => CLKINEAST1_indelay,
          CLKINWEST0           => CLKINWEST0_indelay,
          CLKINWEST1           => CLKINWEST1_indelay,
          DADDR                => DADDR_indelay,
          DCLK                 => DCLK_indelay,
          DEN                  => DEN_indelay,
          DI                   => DI_indelay,
          DWE                  => DWE_indelay,
          GATERXELECIDLE0      => GATERXELECIDLE0_indelay,
          GATERXELECIDLE1      => GATERXELECIDLE1_indelay,
          GCLK00               => GCLK00_indelay,
          GCLK01               => GCLK01_indelay,
          GCLK10               => GCLK10_indelay,
          GCLK11               => GCLK11_indelay,
          GTPCLKFBSEL0EAST     => GTPCLKFBSEL0EAST_indelay,
          GTPCLKFBSEL0WEST     => GTPCLKFBSEL0WEST_indelay,
          GTPCLKFBSEL1EAST     => GTPCLKFBSEL1EAST_indelay,
          GTPCLKFBSEL1WEST     => GTPCLKFBSEL1WEST_indelay,
          GTPRESET0            => GTPRESET0_indelay,
          GTPRESET1            => GTPRESET1_indelay,
          GTPTEST0             => GTPTEST0_indelay,
          GTPTEST1             => GTPTEST1_indelay,
          IGNORESIGDET0        => IGNORESIGDET0_indelay,
          IGNORESIGDET1        => IGNORESIGDET1_indelay,
          INTDATAWIDTH0        => INTDATAWIDTH0_indelay,
          INTDATAWIDTH1        => INTDATAWIDTH1_indelay,
          LOOPBACK0            => LOOPBACK0_indelay,
          LOOPBACK1            => LOOPBACK1_indelay,
          PLLCLK00             => PLLCLK00_indelay,
          PLLCLK01             => PLLCLK01_indelay,
          PLLCLK10             => PLLCLK10_indelay,
          PLLCLK11             => PLLCLK11_indelay,
          PLLLKDETEN0          => PLLLKDETEN0_indelay,
          PLLLKDETEN1          => PLLLKDETEN1_indelay,
          PLLPOWERDOWN0        => PLLPOWERDOWN0_indelay,
          PLLPOWERDOWN1        => PLLPOWERDOWN1_indelay,
          PRBSCNTRESET0        => PRBSCNTRESET0_indelay,
          PRBSCNTRESET1        => PRBSCNTRESET1_indelay,
          RCALINEAST           => RCALINEAST_indelay,
          RCALINWEST           => RCALINWEST_indelay,
          REFCLKPWRDNB0        => REFCLKPWRDNB0_indelay,
          REFCLKPWRDNB1        => REFCLKPWRDNB1_indelay,
          REFSELDYPLL0         => REFSELDYPLL0_indelay,
          REFSELDYPLL1         => REFSELDYPLL1_indelay,
          RXBUFRESET0          => RXBUFRESET0_indelay,
          RXBUFRESET1          => RXBUFRESET1_indelay,
          RXCDRRESET0          => RXCDRRESET0_indelay,
          RXCDRRESET1          => RXCDRRESET1_indelay,
          RXCHBONDI            => RXCHBONDI_indelay,
          RXCHBONDMASTER0      => RXCHBONDMASTER0_indelay,
          RXCHBONDMASTER1      => RXCHBONDMASTER1_indelay,
          RXCHBONDSLAVE0       => RXCHBONDSLAVE0_indelay,
          RXCHBONDSLAVE1       => RXCHBONDSLAVE1_indelay,
          RXCOMMADETUSE0       => RXCOMMADETUSE0_indelay,
          RXCOMMADETUSE1       => RXCOMMADETUSE1_indelay,
          RXDATAWIDTH0         => RXDATAWIDTH0_indelay,
          RXDATAWIDTH1         => RXDATAWIDTH1_indelay,
          RXDEC8B10BUSE0       => RXDEC8B10BUSE0_indelay,
          RXDEC8B10BUSE1       => RXDEC8B10BUSE1_indelay,
          RXENCHANSYNC0        => RXENCHANSYNC0_indelay,
          RXENCHANSYNC1        => RXENCHANSYNC1_indelay,
          RXENMCOMMAALIGN0     => RXENMCOMMAALIGN0_indelay,
          RXENMCOMMAALIGN1     => RXENMCOMMAALIGN1_indelay,
          RXENPCOMMAALIGN0     => RXENPCOMMAALIGN0_indelay,
          RXENPCOMMAALIGN1     => RXENPCOMMAALIGN1_indelay,
          RXENPMAPHASEALIGN0   => RXENPMAPHASEALIGN0_indelay,
          RXENPMAPHASEALIGN1   => RXENPMAPHASEALIGN1_indelay,
          RXENPRBSTST0         => RXENPRBSTST0_indelay,
          RXENPRBSTST1         => RXENPRBSTST1_indelay,
          RXEQMIX0             => RXEQMIX0_indelay,
          RXEQMIX1             => RXEQMIX1_indelay,
          RXN0                 => RXN0_indelay,
          RXN1                 => RXN1_indelay,
          RXP0                 => RXP0_indelay,
          RXP1                 => RXP1_indelay,
          RXPMASETPHASE0       => RXPMASETPHASE0_indelay,
          RXPMASETPHASE1       => RXPMASETPHASE1_indelay,
          RXPOLARITY0          => RXPOLARITY0_indelay,
          RXPOLARITY1          => RXPOLARITY1_indelay,
          RXPOWERDOWN0         => RXPOWERDOWN0_indelay,
          RXPOWERDOWN1         => RXPOWERDOWN1_indelay,
          RXRESET0             => RXRESET0_indelay,
          RXRESET1             => RXRESET1_indelay,
          RXSLIDE0             => RXSLIDE0_indelay,
          RXSLIDE1             => RXSLIDE1_indelay,
          RXUSRCLK0            => RXUSRCLK0_indelay,
          RXUSRCLK1            => RXUSRCLK1_indelay,
          RXUSRCLK20           => RXUSRCLK20_indelay,
          RXUSRCLK21           => RXUSRCLK21_indelay,
          TSTCLK0              => TSTCLK0_indelay,
          TSTCLK1              => TSTCLK1_indelay,
          TSTIN0               => TSTIN0_indelay,
          TSTIN1               => TSTIN1_indelay,
          TXBUFDIFFCTRL0       => TXBUFDIFFCTRL0_indelay,
          TXBUFDIFFCTRL1       => TXBUFDIFFCTRL1_indelay,
          TXBYPASS8B10B0       => TXBYPASS8B10B0_indelay,
          TXBYPASS8B10B1       => TXBYPASS8B10B1_indelay,
          TXCHARDISPMODE0      => TXCHARDISPMODE0_indelay,
          TXCHARDISPMODE1      => TXCHARDISPMODE1_indelay,
          TXCHARDISPVAL0       => TXCHARDISPVAL0_indelay,
          TXCHARDISPVAL1       => TXCHARDISPVAL1_indelay,
          TXCHARISK0           => TXCHARISK0_indelay,
          TXCHARISK1           => TXCHARISK1_indelay,
          TXCOMSTART0          => TXCOMSTART0_indelay,
          TXCOMSTART1          => TXCOMSTART1_indelay,
          TXCOMTYPE0           => TXCOMTYPE0_indelay,
          TXCOMTYPE1           => TXCOMTYPE1_indelay,
          TXDATA0              => TXDATA0_indelay,
          TXDATA1              => TXDATA1_indelay,
          TXDATAWIDTH0         => TXDATAWIDTH0_indelay,
          TXDATAWIDTH1         => TXDATAWIDTH1_indelay,
          TXDETECTRX0          => TXDETECTRX0_indelay,
          TXDETECTRX1          => TXDETECTRX1_indelay,
          TXDIFFCTRL0          => TXDIFFCTRL0_indelay,
          TXDIFFCTRL1          => TXDIFFCTRL1_indelay,
          TXELECIDLE0          => TXELECIDLE0_indelay,
          TXELECIDLE1          => TXELECIDLE1_indelay,
          TXENC8B10BUSE0       => TXENC8B10BUSE0_indelay,
          TXENC8B10BUSE1       => TXENC8B10BUSE1_indelay,
          TXENPMAPHASEALIGN0   => TXENPMAPHASEALIGN0_indelay,
          TXENPMAPHASEALIGN1   => TXENPMAPHASEALIGN1_indelay,
          TXENPRBSTST0         => TXENPRBSTST0_indelay,
          TXENPRBSTST1         => TXENPRBSTST1_indelay,
          TXINHIBIT0           => TXINHIBIT0_indelay,
          TXINHIBIT1           => TXINHIBIT1_indelay,
          TXPDOWNASYNCH0       => TXPDOWNASYNCH0_indelay,
          TXPDOWNASYNCH1       => TXPDOWNASYNCH1_indelay,
          TXPMASETPHASE0       => TXPMASETPHASE0_indelay,
          TXPMASETPHASE1       => TXPMASETPHASE1_indelay,
          TXPOLARITY0          => TXPOLARITY0_indelay,
          TXPOLARITY1          => TXPOLARITY1_indelay,
          TXPOWERDOWN0         => TXPOWERDOWN0_indelay,
          TXPOWERDOWN1         => TXPOWERDOWN1_indelay,
          TXPRBSFORCEERR0      => TXPRBSFORCEERR0_indelay,
          TXPRBSFORCEERR1      => TXPRBSFORCEERR1_indelay,
          TXPREEMPHASIS0       => TXPREEMPHASIS0_indelay,
          TXPREEMPHASIS1       => TXPREEMPHASIS1_indelay,
          TXRESET0             => TXRESET0_indelay,
          TXRESET1             => TXRESET1_indelay,
          TXUSRCLK0            => TXUSRCLK0_indelay,
          TXUSRCLK1            => TXUSRCLK1_indelay,
          TXUSRCLK20           => TXUSRCLK20_indelay,
          TXUSRCLK21           => TXUSRCLK21_indelay,
          USRCODEERR0          => USRCODEERR0_indelay,
          USRCODEERR1          => USRCODEERR1_indelay,
          GSR                  => GSR_dly
        );
--####################################################################
--#####                     Initialize                           #####
--####################################################################
      
      INIPROC : process
      begin
      -- case CLK_OUT_GTP_SEL_0 is
      if((CLK_OUT_GTP_SEL_0 = "REFCLKPLL0") or (CLK_OUT_GTP_SEL_0 = "refclkpll0")) then
          CLK_OUT_GTP_SEL_0_BINARY <= '1';
      elsif((CLK_OUT_GTP_SEL_0 = "TXOUTCLK0") or (CLK_OUT_GTP_SEL_0= "txoutclk0")) then
        CLK_OUT_GTP_SEL_0_BINARY <= '0';
        else
        assert FALSE report "Error : CLK_OUT_GTP_SEL_0 = is not REFCLKPLL0, TXOUTCLK0." severity error;
        end if;
      -- end case;
      -- case CLK_OUT_GTP_SEL_1 is
      if((CLK_OUT_GTP_SEL_1 = "REFCLKPLL1") or (CLK_OUT_GTP_SEL_1 = "refclkpll1")) then
          CLK_OUT_GTP_SEL_1_BINARY <= '1';
      elsif((CLK_OUT_GTP_SEL_1 = "TXOUTCLK1") or (CLK_OUT_GTP_SEL_1= "txoutclk1")) then
        CLK_OUT_GTP_SEL_1_BINARY <= '0';
        else
        assert FALSE report "Error : CLK_OUT_GTP_SEL_1 = is not REFCLKPLL1, TXOUTCLK1." severity error;
        end if;
      -- end case;
      -- case PLL_SOURCE_0 is
        if((PLL_SOURCE_0 = "PLL0") or (PLL_SOURCE_0 = "pll0")) then
          PLL_SOURCE_0_BINARY <= '0';
        elsif((PLL_SOURCE_0 = "PLL1") or (PLL_SOURCE_0= "pll1")) then
          PLL_SOURCE_0_BINARY <= '1';
        else
          assert FALSE report "Error : PLL_SOURCE_0 = is not PLL0, PLL1." severity error;
        end if;
      -- end case;
      -- case PLL_SOURCE_1 is
      if((PLL_SOURCE_1 = "PLL0") or (PLL_SOURCE_1 = "pll0")) then
          PLL_SOURCE_1_BINARY <= '0';
      elsif((PLL_SOURCE_1 = "PLL1") or (PLL_SOURCE_1= "pll1")) then
        PLL_SOURCE_1_BINARY <= '1';
        else
        assert FALSE report "Error : PLL_SOURCE_1 = is not PLL0, PLL1." severity error;
        end if;
      -- end case;
      -- case RX_SLIDE_MODE_0 is
        if((RX_SLIDE_MODE_0 = "PCS") or (RX_SLIDE_MODE_0 = "pcs")) then
          RX_SLIDE_MODE_0_BINARY <= '0';
        elsif((RX_SLIDE_MODE_0 = "PMA") or (RX_SLIDE_MODE_0= "pma")) then
          RX_SLIDE_MODE_0_BINARY <= '1';
        else
          assert FALSE report "Error : RX_SLIDE_MODE_0 = is not PCS, PMA." severity error;
        end if;
      -- end case;
      -- case RX_SLIDE_MODE_1 is
        if((RX_SLIDE_MODE_1 = "PCS") or (RX_SLIDE_MODE_1 = "pcs")) then
          RX_SLIDE_MODE_1_BINARY <= '0';
        elsif((RX_SLIDE_MODE_1 = "PMA") or (RX_SLIDE_MODE_1= "pma")) then
          RX_SLIDE_MODE_1_BINARY <= '1';
        else
          assert FALSE report "Error : RX_SLIDE_MODE_1 = is not PCS, PMA." severity error;
        end if;
      -- end case;
      -- case RX_STATUS_FMT_0 is
        if((RX_STATUS_FMT_0 = "PCIE") or (RX_STATUS_FMT_0 = "pcie")) then
          RX_STATUS_FMT_0_BINARY <= '0';
        elsif((RX_STATUS_FMT_0 = "SATA") or (RX_STATUS_FMT_0= "sata")) then
          RX_STATUS_FMT_0_BINARY <= '1';
        else
          assert FALSE report "Error : RX_STATUS_FMT_0 = is not PCIE, SATA." severity error;
        end if;
      -- end case;
      -- case RX_STATUS_FMT_1 is
        if((RX_STATUS_FMT_1 = "PCIE") or (RX_STATUS_FMT_1 = "pcie")) then
          RX_STATUS_FMT_1_BINARY <= '0';
        elsif((RX_STATUS_FMT_1 = "SATA") or (RX_STATUS_FMT_1= "sata")) then
          RX_STATUS_FMT_1_BINARY <= '1';
        else
          assert FALSE report "Error : RX_STATUS_FMT_1 = is not PCIE, SATA." severity error;
        end if;
      -- end case;
      -- case RX_XCLK_SEL_0 is
        if((RX_XCLK_SEL_0 = "RXREC") or (RX_XCLK_SEL_0 = "rxrec")) then
          RX_XCLK_SEL_0_BINARY <= '0';
        elsif((RX_XCLK_SEL_0 = "RXUSR") or (RX_XCLK_SEL_0= "rxusr")) then
          RX_XCLK_SEL_0_BINARY <= '1';
        else
          assert FALSE report "Error : RX_XCLK_SEL_0 = is not RXREC, RXUSR." severity error;
        end if;
      -- end case;
      -- case RX_XCLK_SEL_1 is
        if((RX_XCLK_SEL_1 = "RXREC") or (RX_XCLK_SEL_1 = "rxrec")) then
          RX_XCLK_SEL_1_BINARY <= '0';
        elsif((RX_XCLK_SEL_1 = "RXUSR") or (RX_XCLK_SEL_1= "rxusr")) then
          RX_XCLK_SEL_1_BINARY <= '1';
        else
          assert FALSE report "Error : RX_XCLK_SEL_1 = is not RXREC, RXUSR." severity error;
        end if;
      -- end case;
    -- case SIM_TX_ELEC_IDLE_LEVEL is
      if((SIM_TX_ELEC_IDLE_LEVEL = "X") or (SIM_TX_ELEC_IDLE_LEVEL = "x")) then
        SIM_TX_ELEC_IDLE_LEVEL_BINARY <= '0';
      elsif((SIM_TX_ELEC_IDLE_LEVEL = "0") or (SIM_TX_ELEC_IDLE_LEVEL= "0")) then
        SIM_TX_ELEC_IDLE_LEVEL_BINARY <= '0';
      elsif((SIM_TX_ELEC_IDLE_LEVEL = "1") or (SIM_TX_ELEC_IDLE_LEVEL= "1")) then
        SIM_TX_ELEC_IDLE_LEVEL_BINARY <= '0';
      elsif((SIM_TX_ELEC_IDLE_LEVEL = "Z") or (SIM_TX_ELEC_IDLE_LEVEL= "z")) then
        SIM_TX_ELEC_IDLE_LEVEL_BINARY <= '0';
      else
        assert FALSE report "Error : SIM_TX_ELEC_IDLE_LEVEL = is not X, 0, 1, Z." severity error;
      end if;
    -- end case;
    -- case SIM_VERSION is
      if(SIM_VERSION = "2.0") then
        SIM_VERSION_BINARY <= '1';
      elsif(SIM_VERSION = "1.0") then
        SIM_VERSION_BINARY <= '0';
      else
        assert FALSE report "Error : SIM_VERSION = is not 2.0 or 1.0." severity error;
      end if;
    -- end case;
      -- case TX_XCLK_SEL_0 is
      if((TX_XCLK_SEL_0 = "TXUSR") or (TX_XCLK_SEL_0 = "txusr")) then
        TX_XCLK_SEL_0_BINARY <= '1';
      elsif((TX_XCLK_SEL_0 = "TXOUT") or (TX_XCLK_SEL_0= "txout")) then
        TX_XCLK_SEL_0_BINARY <= '0';
      else
        assert FALSE report "Error : TX_XCLK_SEL_0 = is not TXUSR, TXOUT." severity error;
      end if;
    -- end case;
    -- case TX_XCLK_SEL_1 is
      if((TX_XCLK_SEL_1 = "TXUSR") or (TX_XCLK_SEL_1 = "txusr")) then
        TX_XCLK_SEL_1_BINARY <= '1';
      elsif((TX_XCLK_SEL_1 = "TXOUT") or (TX_XCLK_SEL_1= "txout")) then
        TX_XCLK_SEL_1_BINARY <= '0';
      else
        assert FALSE report "Error : TX_XCLK_SEL_1 = is not TXUSR, TXOUT." severity error;
      end if;
      -- end case;
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
      case ALIGN_COMMA_WORD_0 is
        when  1   =>  ALIGN_COMMA_WORD_0_BINARY <= '0';
        when  2   =>  ALIGN_COMMA_WORD_0_BINARY <= '1';
        when others  =>  assert FALSE report "Error : ALIGN_COMMA_WORD_0 is not in range 1 .. 2." severity error;
      end case;
      case ALIGN_COMMA_WORD_1 is
        when  1   =>  ALIGN_COMMA_WORD_1_BINARY <= '0';
        when  2   =>  ALIGN_COMMA_WORD_1_BINARY <= '1';
        when others  =>  assert FALSE report "Error : ALIGN_COMMA_WORD_1 is not in range 1 .. 2." severity error;
      end case;
      case CHAN_BOND_KEEP_ALIGN_0 is
        when FALSE   =>  CHAN_BOND_KEEP_ALIGN_0_BINARY <= '0';
        when TRUE    =>  CHAN_BOND_KEEP_ALIGN_0_BINARY <= '1';
        when others  =>  assert FALSE report "Error : CHAN_BOND_KEEP_ALIGN_0 is neither TRUE nor FALSE." severity error;
      end case;
      case CHAN_BOND_KEEP_ALIGN_1 is
        when FALSE   =>  CHAN_BOND_KEEP_ALIGN_1_BINARY <= '0';
        when TRUE    =>  CHAN_BOND_KEEP_ALIGN_1_BINARY <= '1';
        when others  =>  assert FALSE report "Error : CHAN_BOND_KEEP_ALIGN_1 is neither TRUE nor FALSE." severity error;
      end case;
      case CHAN_BOND_SEQ_2_USE_0 is
        when FALSE   =>  CHAN_BOND_SEQ_2_USE_0_BINARY <= '0';
        when TRUE    =>  CHAN_BOND_SEQ_2_USE_0_BINARY <= '1';
        when others  =>  assert FALSE report "Error : CHAN_BOND_SEQ_2_USE_0 is neither TRUE nor FALSE." severity error;
      end case;
      case CHAN_BOND_SEQ_2_USE_1 is
        when FALSE   =>  CHAN_BOND_SEQ_2_USE_1_BINARY <= '0';
        when TRUE    =>  CHAN_BOND_SEQ_2_USE_1_BINARY <= '1';
        when others  =>  assert FALSE report "Error : CHAN_BOND_SEQ_2_USE_1 is neither TRUE nor FALSE." severity error;
      end case;
      case CLKINDC_B_0 is
        when FALSE   =>  CLKINDC_B_0_BINARY <= '0';
        when TRUE    =>  CLKINDC_B_0_BINARY <= '1';
        when others  =>  assert FALSE report "Error : CLKINDC_B_0 is neither TRUE nor FALSE." severity error;
      end case;
      case CLKINDC_B_1 is
        when FALSE   =>  CLKINDC_B_1_BINARY <= '0';
        when TRUE    =>  CLKINDC_B_1_BINARY <= '1';
        when others  =>  assert FALSE report "Error : CLKINDC_B_1 is neither TRUE nor FALSE." severity error;
      end case;
      case CLKRCV_TRST_0 is
        when FALSE   =>  CLKRCV_TRST_0_BINARY <= '0';
        when TRUE    =>  CLKRCV_TRST_0_BINARY <= '1';
        when others  =>  assert FALSE report "Error : CLKRCV_TRST_0 is neither TRUE nor FALSE." severity error;
      end case;
      case CLKRCV_TRST_1 is
        when FALSE   =>  CLKRCV_TRST_1_BINARY <= '0';
        when TRUE    =>  CLKRCV_TRST_1_BINARY <= '1';
        when others  =>  assert FALSE report "Error : CLKRCV_TRST_1 is neither TRUE nor FALSE." severity error;
      end case;
      case CLK_CORRECT_USE_0 is
        when FALSE   =>  CLK_CORRECT_USE_0_BINARY <= '0';
        when TRUE    =>  CLK_CORRECT_USE_0_BINARY <= '1';
        when others  =>  assert FALSE report "Error : CLK_CORRECT_USE_0 is neither TRUE nor FALSE." severity error;
      end case;
      case CLK_CORRECT_USE_1 is
        when FALSE   =>  CLK_CORRECT_USE_1_BINARY <= '0';
        when TRUE    =>  CLK_CORRECT_USE_1_BINARY <= '1';
        when others  =>  assert FALSE report "Error : CLK_CORRECT_USE_1 is neither TRUE nor FALSE." severity error;
      end case;
      case CLK_COR_INSERT_IDLE_FLAG_0 is
        when FALSE   =>  CLK_COR_INSERT_IDLE_FLAG_0_BINARY <= '0';
        when TRUE    =>  CLK_COR_INSERT_IDLE_FLAG_0_BINARY <= '1';
        when others  =>  assert FALSE report "Error : CLK_COR_INSERT_IDLE_FLAG_0 is neither TRUE nor FALSE." severity error;
      end case;
      case CLK_COR_INSERT_IDLE_FLAG_1 is
        when FALSE   =>  CLK_COR_INSERT_IDLE_FLAG_1_BINARY <= '0';
        when TRUE    =>  CLK_COR_INSERT_IDLE_FLAG_1_BINARY <= '1';
        when others  =>  assert FALSE report "Error : CLK_COR_INSERT_IDLE_FLAG_1 is neither TRUE nor FALSE." severity error;
      end case;
      case CLK_COR_KEEP_IDLE_0 is
        when FALSE   =>  CLK_COR_KEEP_IDLE_0_BINARY <= '0';
        when TRUE    =>  CLK_COR_KEEP_IDLE_0_BINARY <= '1';
        when others  =>  assert FALSE report "Error : CLK_COR_KEEP_IDLE_0 is neither TRUE nor FALSE." severity error;
      end case;
      case CLK_COR_KEEP_IDLE_1 is
        when FALSE   =>  CLK_COR_KEEP_IDLE_1_BINARY <= '0';
        when TRUE    =>  CLK_COR_KEEP_IDLE_1_BINARY <= '1';
        when others  =>  assert FALSE report "Error : CLK_COR_KEEP_IDLE_1 is neither TRUE nor FALSE." severity error;
      end case;
      case CLK_COR_PRECEDENCE_0 is
        when FALSE   =>  CLK_COR_PRECEDENCE_0_BINARY <= '0';
        when TRUE    =>  CLK_COR_PRECEDENCE_0_BINARY <= '1';
        when others  =>  assert FALSE report "Error : CLK_COR_PRECEDENCE_0 is neither TRUE nor FALSE." severity error;
      end case;
      case CLK_COR_PRECEDENCE_1 is
        when FALSE   =>  CLK_COR_PRECEDENCE_1_BINARY <= '0';
        when TRUE    =>  CLK_COR_PRECEDENCE_1_BINARY <= '1';
        when others  =>  assert FALSE report "Error : CLK_COR_PRECEDENCE_1 is neither TRUE nor FALSE." severity error;
      end case;
      case CLK_COR_SEQ_2_USE_0 is
        when FALSE   =>  CLK_COR_SEQ_2_USE_0_BINARY <= '0';
        when TRUE    =>  CLK_COR_SEQ_2_USE_0_BINARY <= '1';
        when others  =>  assert FALSE report "Error : CLK_COR_SEQ_2_USE_0 is neither TRUE nor FALSE." severity error;
      end case;
      case CLK_COR_SEQ_2_USE_1 is
        when FALSE   =>  CLK_COR_SEQ_2_USE_1_BINARY <= '0';
        when TRUE    =>  CLK_COR_SEQ_2_USE_1_BINARY <= '1';
        when others  =>  assert FALSE report "Error : CLK_COR_SEQ_2_USE_1 is neither TRUE nor FALSE." severity error;
      end case;
      case DEC_MCOMMA_DETECT_0 is
        when FALSE   =>  DEC_MCOMMA_DETECT_0_BINARY <= '0';
        when TRUE    =>  DEC_MCOMMA_DETECT_0_BINARY <= '1';
        when others  =>  assert FALSE report "Error : DEC_MCOMMA_DETECT_0 is neither TRUE nor FALSE." severity error;
      end case;
      case DEC_MCOMMA_DETECT_1 is
        when FALSE   =>  DEC_MCOMMA_DETECT_1_BINARY <= '0';
        when TRUE    =>  DEC_MCOMMA_DETECT_1_BINARY <= '1';
        when others  =>  assert FALSE report "Error : DEC_MCOMMA_DETECT_1 is neither TRUE nor FALSE." severity error;
      end case;
      case DEC_PCOMMA_DETECT_0 is
        when FALSE   =>  DEC_PCOMMA_DETECT_0_BINARY <= '0';
        when TRUE    =>  DEC_PCOMMA_DETECT_0_BINARY <= '1';
        when others  =>  assert FALSE report "Error : DEC_PCOMMA_DETECT_0 is neither TRUE nor FALSE." severity error;
      end case;
      case DEC_PCOMMA_DETECT_1 is
        when FALSE   =>  DEC_PCOMMA_DETECT_1_BINARY <= '0';
        when TRUE    =>  DEC_PCOMMA_DETECT_1_BINARY <= '1';
        when others  =>  assert FALSE report "Error : DEC_PCOMMA_DETECT_1 is neither TRUE nor FALSE." severity error;
      end case;
      case DEC_VALID_COMMA_ONLY_0 is
        when FALSE   =>  DEC_VALID_COMMA_ONLY_0_BINARY <= '0';
        when TRUE    =>  DEC_VALID_COMMA_ONLY_0_BINARY <= '1';
        when others  =>  assert FALSE report "Error : DEC_VALID_COMMA_ONLY_0 is neither TRUE nor FALSE." severity error;
      end case;
      case DEC_VALID_COMMA_ONLY_1 is
        when FALSE   =>  DEC_VALID_COMMA_ONLY_1_BINARY <= '0';
        when TRUE    =>  DEC_VALID_COMMA_ONLY_1_BINARY <= '1';
        when others  =>  assert FALSE report "Error : DEC_VALID_COMMA_ONLY_1 is neither TRUE nor FALSE." severity error;
      end case;
      case GTP_CFG_PWRUP_0 is
        when FALSE   =>  GTP_CFG_PWRUP_0_BINARY <= '0';
        when TRUE    =>  GTP_CFG_PWRUP_0_BINARY <= '1';
        when others  =>  assert FALSE report "Error : GTP_CFG_PWRUP_0 is neither TRUE nor FALSE." severity error;
      end case;
      case GTP_CFG_PWRUP_1 is
        when FALSE   =>  GTP_CFG_PWRUP_1_BINARY <= '0';
        when TRUE    =>  GTP_CFG_PWRUP_1_BINARY <= '1';
        when others  =>  assert FALSE report "Error : GTP_CFG_PWRUP_1 is neither TRUE nor FALSE." severity error;
      end case;
      case MCOMMA_DETECT_0 is
        when FALSE   =>  MCOMMA_DETECT_0_BINARY <= '0';
        when TRUE    =>  MCOMMA_DETECT_0_BINARY <= '1';
        when others  =>  assert FALSE report "Error : MCOMMA_DETECT_0 is neither TRUE nor FALSE." severity error;
      end case;
      case MCOMMA_DETECT_1 is
        when FALSE   =>  MCOMMA_DETECT_1_BINARY <= '0';
        when TRUE    =>  MCOMMA_DETECT_1_BINARY <= '1';
        when others  =>  assert FALSE report "Error : MCOMMA_DETECT_1 is neither TRUE nor FALSE." severity error;
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
      case PCOMMA_DETECT_0 is
        when FALSE   =>  PCOMMA_DETECT_0_BINARY <= '0';
        when TRUE    =>  PCOMMA_DETECT_0_BINARY <= '1';
        when others  =>  assert FALSE report "Error : PCOMMA_DETECT_0 is neither TRUE nor FALSE." severity error;
      end case;
      case PCOMMA_DETECT_1 is
        when FALSE   =>  PCOMMA_DETECT_1_BINARY <= '0';
        when TRUE    =>  PCOMMA_DETECT_1_BINARY <= '1';
        when others  =>  assert FALSE report "Error : PCOMMA_DETECT_1 is neither TRUE nor FALSE." severity error;
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
      if ((RXPRBSERR_LOOPBACK_0 /= '0') and (RXPRBSERR_LOOPBACK_0 /= '1')) then
        assert FALSE report "Error : RXPRBSERR_LOOPBACK_0 is neither 0 or 1." severity error;
      end if;
      if ((RXPRBSERR_LOOPBACK_1 /= '0') and (RXPRBSERR_LOOPBACK_1 /= '1')) then
        assert FALSE report "Error : RXPRBSERR_LOOPBACK_1 is neither 0 or 1." severity error;
      end if;
      case RX_BUFFER_USE_0 is
        when FALSE   =>  RX_BUFFER_USE_0_BINARY <= '0';
        when TRUE    =>  RX_BUFFER_USE_0_BINARY <= '1';
        when others  =>  assert FALSE report "Error : RX_BUFFER_USE_0 is neither TRUE nor FALSE." severity error;
      end case;
      case RX_BUFFER_USE_1 is
        when FALSE   =>  RX_BUFFER_USE_1_BINARY <= '0';
        when TRUE    =>  RX_BUFFER_USE_1_BINARY <= '1';
        when others  =>  assert FALSE report "Error : RX_BUFFER_USE_1 is neither TRUE nor FALSE." severity error;
      end case;
      case RX_DECODE_SEQ_MATCH_0 is
        when FALSE   =>  RX_DECODE_SEQ_MATCH_0_BINARY <= '0';
        when TRUE    =>  RX_DECODE_SEQ_MATCH_0_BINARY <= '1';
        when others  =>  assert FALSE report "Error : RX_DECODE_SEQ_MATCH_0 is neither TRUE nor FALSE." severity error;
      end case;
      case RX_DECODE_SEQ_MATCH_1 is
        when FALSE   =>  RX_DECODE_SEQ_MATCH_1_BINARY <= '0';
        when TRUE    =>  RX_DECODE_SEQ_MATCH_1_BINARY <= '1';
        when others  =>  assert FALSE report "Error : RX_DECODE_SEQ_MATCH_1 is neither TRUE nor FALSE." severity error;
      end case;
      case RX_EN_IDLE_HOLD_CDR_0 is
        when FALSE   =>  RX_EN_IDLE_HOLD_CDR_0_BINARY <= '0';
        when TRUE    =>  RX_EN_IDLE_HOLD_CDR_0_BINARY <= '1';
        when others  =>  assert FALSE report "Error : RX_EN_IDLE_HOLD_CDR_0 is neither TRUE nor FALSE." severity error;
      end case;
      case RX_EN_IDLE_HOLD_CDR_1 is
        when FALSE   =>  RX_EN_IDLE_HOLD_CDR_1_BINARY <= '0';
        when TRUE    =>  RX_EN_IDLE_HOLD_CDR_1_BINARY <= '1';
        when others  =>  assert FALSE report "Error : RX_EN_IDLE_HOLD_CDR_1 is neither TRUE nor FALSE." severity error;
      end case;
      case RX_EN_IDLE_RESET_BUF_0 is
        when FALSE   =>  RX_EN_IDLE_RESET_BUF_0_BINARY <= '0';
        when TRUE    =>  RX_EN_IDLE_RESET_BUF_0_BINARY <= '1';
        when others  =>  assert FALSE report "Error : RX_EN_IDLE_RESET_BUF_0 is neither TRUE nor FALSE." severity error;
      end case;
      case RX_EN_IDLE_RESET_BUF_1 is
        when FALSE   =>  RX_EN_IDLE_RESET_BUF_1_BINARY <= '0';
        when TRUE    =>  RX_EN_IDLE_RESET_BUF_1_BINARY <= '1';
        when others  =>  assert FALSE report "Error : RX_EN_IDLE_RESET_BUF_1 is neither TRUE nor FALSE." severity error;
      end case;
      case RX_EN_IDLE_RESET_FR_0 is
        when FALSE   =>  RX_EN_IDLE_RESET_FR_0_BINARY <= '0';
        when TRUE    =>  RX_EN_IDLE_RESET_FR_0_BINARY <= '1';
        when others  =>  assert FALSE report "Error : RX_EN_IDLE_RESET_FR_0 is neither TRUE nor FALSE." severity error;
      end case;
      case RX_EN_IDLE_RESET_FR_1 is
        when FALSE   =>  RX_EN_IDLE_RESET_FR_1_BINARY <= '0';
        when TRUE    =>  RX_EN_IDLE_RESET_FR_1_BINARY <= '1';
        when others  =>  assert FALSE report "Error : RX_EN_IDLE_RESET_FR_1 is neither TRUE nor FALSE." severity error;
      end case;
      case RX_EN_IDLE_RESET_PH_0 is
        when FALSE   =>  RX_EN_IDLE_RESET_PH_0_BINARY <= '0';
        when TRUE    =>  RX_EN_IDLE_RESET_PH_0_BINARY <= '1';
        when others  =>  assert FALSE report "Error : RX_EN_IDLE_RESET_PH_0 is neither TRUE nor FALSE." severity error;
      end case;
      case RX_EN_IDLE_RESET_PH_1 is
        when FALSE   =>  RX_EN_IDLE_RESET_PH_1_BINARY <= '0';
        when TRUE    =>  RX_EN_IDLE_RESET_PH_1_BINARY <= '1';
        when others  =>  assert FALSE report "Error : RX_EN_IDLE_RESET_PH_1 is neither TRUE nor FALSE." severity error;
      end case;
      case RX_EN_MODE_RESET_BUF_0 is
        when FALSE   =>  RX_EN_MODE_RESET_BUF_0_BINARY <= '0';
        when TRUE    =>  RX_EN_MODE_RESET_BUF_0_BINARY <= '1';
        when others  =>  assert FALSE report "Error : RX_EN_MODE_RESET_BUF_0 is neither TRUE nor FALSE." severity error;
      end case;
      case RX_EN_MODE_RESET_BUF_1 is
        when FALSE   =>  RX_EN_MODE_RESET_BUF_1_BINARY <= '0';
        when TRUE    =>  RX_EN_MODE_RESET_BUF_1_BINARY <= '1';
        when others  =>  assert FALSE report "Error : RX_EN_MODE_RESET_BUF_1 is neither TRUE nor FALSE." severity error;
      end case;
      case RX_LOSS_OF_SYNC_FSM_0 is
        when FALSE   =>  RX_LOSS_OF_SYNC_FSM_0_BINARY <= '0';
        when TRUE    =>  RX_LOSS_OF_SYNC_FSM_0_BINARY <= '1';
        when others  =>  assert FALSE report "Error : RX_LOSS_OF_SYNC_FSM_0 is neither TRUE nor FALSE." severity error;
      end case;
      case RX_LOSS_OF_SYNC_FSM_1 is
        when FALSE   =>  RX_LOSS_OF_SYNC_FSM_1_BINARY <= '0';
        when TRUE    =>  RX_LOSS_OF_SYNC_FSM_1_BINARY <= '1';
        when others  =>  assert FALSE report "Error : RX_LOSS_OF_SYNC_FSM_1 is neither TRUE nor FALSE." severity error;
      end case;
    case SIM_GTPRESET_SPEEDUP is
      when  0   =>  SIM_GTPRESET_SPEEDUP_BINARY <= '0';
      when  1   =>  SIM_GTPRESET_SPEEDUP_BINARY <= '1';
      when others  =>  assert FALSE report "Error : SIM_GTPRESET_SPEEDUP is not in range 0 .. 1." severity error;
    end case;
    case SIM_RECEIVER_DETECT_PASS is
      when FALSE   =>  SIM_RECEIVER_DETECT_PASS_BINARY <= '0';
      when TRUE    =>  SIM_RECEIVER_DETECT_PASS_BINARY <= '1';
      when others  =>  assert FALSE report "Error : SIM_RECEIVER_DETECT_PASS is neither TRUE nor FALSE." severity error;
    end case;
      case TERMINATION_OVRD_0 is
        when FALSE   =>  TERMINATION_OVRD_0_BINARY <= '0';
        when TRUE    =>  TERMINATION_OVRD_0_BINARY <= '1';
        when others  =>  assert FALSE report "Error : TERMINATION_OVRD_0 is neither TRUE nor FALSE." severity error;
      end case;
      case TERMINATION_OVRD_1 is
        when FALSE   =>  TERMINATION_OVRD_1_BINARY <= '0';
        when TRUE    =>  TERMINATION_OVRD_1_BINARY <= '1';
        when others  =>  assert FALSE report "Error : TERMINATION_OVRD_1 is neither TRUE nor FALSE." severity error;
      end case;
      case TX_BUFFER_USE_0 is
        when FALSE   =>  TX_BUFFER_USE_0_BINARY <= '0';
        when TRUE    =>  TX_BUFFER_USE_0_BINARY <= '1';
        when others  =>  assert FALSE report "Error : TX_BUFFER_USE_0 is neither TRUE nor FALSE." severity error;
      end case;
      case TX_BUFFER_USE_1 is
        when FALSE   =>  TX_BUFFER_USE_1_BINARY <= '0';
        when TRUE    =>  TX_BUFFER_USE_1_BINARY <= '1';
        when others  =>  assert FALSE report "Error : TX_BUFFER_USE_1 is neither TRUE nor FALSE." severity error;
      end case;
      if ((CB2_INH_CC_PERIOD_0 >= 0) and (CB2_INH_CC_PERIOD_0 <= 15)) then
        CB2_INH_CC_PERIOD_0_BINARY <= CONV_STD_LOGIC_VECTOR(CB2_INH_CC_PERIOD_0, 4);
      else
        assert FALSE report "Error : CB2_INH_CC_PERIOD_0 is not in range 0 .. 15." severity error;
      end if;
      if ((CB2_INH_CC_PERIOD_1 >= 0) and (CB2_INH_CC_PERIOD_1 <= 15)) then
        CB2_INH_CC_PERIOD_1_BINARY <= CONV_STD_LOGIC_VECTOR(CB2_INH_CC_PERIOD_1, 4);
      else
        assert FALSE report "Error : CB2_INH_CC_PERIOD_1 is not in range 0 .. 15." severity error;
      end if;
    if ((CDR_PH_ADJ_TIME_0 < "00000") or (CDR_PH_ADJ_TIME_0 > "11111")) then
      assert FALSE report "Error : CDR_PH_ADJ_TIME_0 is not in range 0 .. 31." severity error;
    end if;
    if ((CDR_PH_ADJ_TIME_1 < "00000") or (CDR_PH_ADJ_TIME_1 > "11111")) then
      assert FALSE report "Error : CDR_PH_ADJ_TIME_1 is not in range 0 .. 31." severity error;
    end if;
      if ((CHAN_BOND_1_MAX_SKEW_0 >= 1) and (CHAN_BOND_1_MAX_SKEW_0 <= 14)) then
        CHAN_BOND_1_MAX_SKEW_0_BINARY <= CONV_STD_LOGIC_VECTOR(CHAN_BOND_1_MAX_SKEW_0, 4);
      else
        assert FALSE report "Error : CHAN_BOND_1_MAX_SKEW_0 is not in range 1 .. 14." severity error;
      end if;
      if ((CHAN_BOND_1_MAX_SKEW_1 >= 1) and (CHAN_BOND_1_MAX_SKEW_1 <= 14)) then
        CHAN_BOND_1_MAX_SKEW_1_BINARY <= CONV_STD_LOGIC_VECTOR(CHAN_BOND_1_MAX_SKEW_1, 4);
      else
        assert FALSE report "Error : CHAN_BOND_1_MAX_SKEW_1 is not in range 1 .. 14." severity error;
      end if;
      if ((CHAN_BOND_2_MAX_SKEW_0 >= 1) and (CHAN_BOND_2_MAX_SKEW_0 <= 14)) then
        CHAN_BOND_2_MAX_SKEW_0_BINARY <= CONV_STD_LOGIC_VECTOR(CHAN_BOND_2_MAX_SKEW_0, 4);
      else
        assert FALSE report "Error : CHAN_BOND_2_MAX_SKEW_0 is not in range 1 .. 14." severity error;
      end if;
      if ((CHAN_BOND_2_MAX_SKEW_1 >= 1) and (CHAN_BOND_2_MAX_SKEW_1 <= 14)) then
        CHAN_BOND_2_MAX_SKEW_1_BINARY <= CONV_STD_LOGIC_VECTOR(CHAN_BOND_2_MAX_SKEW_1, 4);
      else
        assert FALSE report "Error : CHAN_BOND_2_MAX_SKEW_1 is not in range 1 .. 14." severity error;
      end if;
      if (CHAN_BOND_2_MAX_SKEW_0 > CHAN_BOND_1_MAX_SKEW_0) then
        assert FALSE report "Error : CHAN_BOND_2_MAX_SKEW_0 must be less than or equal to CHAN_BOND_1_MAX_SKEW_0 ." severity error;
      end if;
      if (CHAN_BOND_2_MAX_SKEW_1 > CHAN_BOND_1_MAX_SKEW_1) then
        assert FALSE report "Error : CHAN_BOND_2_MAX_SKEW_1 must be less than or equal to CHAN_BOND_1_MAX_SKEW_0 ." severity error;
      end if;
    if ((CHAN_BOND_SEQ_1_1_0 < "0000000000") or (CHAN_BOND_SEQ_1_1_0 > "1111111111")) then
      assert FALSE report "Error : CHAN_BOND_SEQ_1_1_0 is not in range 0 .. 1023." severity error;
    end if;
    if ((CHAN_BOND_SEQ_1_1_1 < "0000000000") or (CHAN_BOND_SEQ_1_1_1 > "1111111111")) then
      assert FALSE report "Error : CHAN_BOND_SEQ_1_1_1 is not in range 0 .. 1023." severity error;
    end if;
    if ((CHAN_BOND_SEQ_1_2_0 < "0000000000") or (CHAN_BOND_SEQ_1_2_0 > "1111111111")) then
      assert FALSE report "Error : CHAN_BOND_SEQ_1_2_0 is not in range 0 .. 1023." severity error;
    end if;
    if ((CHAN_BOND_SEQ_1_2_1 < "0000000000") or (CHAN_BOND_SEQ_1_2_1 > "1111111111")) then
      assert FALSE report "Error : CHAN_BOND_SEQ_1_2_1 is not in range 0 .. 1023." severity error;
    end if;
    if ((CHAN_BOND_SEQ_1_3_0 < "0000000000") or (CHAN_BOND_SEQ_1_3_0 > "1111111111")) then
      assert FALSE report "Error : CHAN_BOND_SEQ_1_3_0 is not in range 0 .. 1023." severity error;
    end if;
    if ((CHAN_BOND_SEQ_1_3_1 < "0000000000") or (CHAN_BOND_SEQ_1_3_1 > "1111111111")) then
      assert FALSE report "Error : CHAN_BOND_SEQ_1_3_1 is not in range 0 .. 1023." severity error;
    end if;
    if ((CHAN_BOND_SEQ_1_4_0 < "0000000000") or (CHAN_BOND_SEQ_1_4_0 > "1111111111")) then
      assert FALSE report "Error : CHAN_BOND_SEQ_1_4_0 is not in range 0 .. 1023." severity error;
    end if;
    if ((CHAN_BOND_SEQ_1_4_1 < "0000000000") or (CHAN_BOND_SEQ_1_4_1 > "1111111111")) then
      assert FALSE report "Error : CHAN_BOND_SEQ_1_4_1 is not in range 0 .. 1023." severity error;
    end if;
    if ((CHAN_BOND_SEQ_1_ENABLE_0 < "0000") or (CHAN_BOND_SEQ_1_ENABLE_0 > "1111")) then
      assert FALSE report "Error : CHAN_BOND_SEQ_1_ENABLE_0 is not in range 0 .. 15." severity error;
    end if;
    if ((CHAN_BOND_SEQ_1_ENABLE_1 < "0000") or (CHAN_BOND_SEQ_1_ENABLE_1 > "1111")) then
      assert FALSE report "Error : CHAN_BOND_SEQ_1_ENABLE_1 is not in range 0 .. 15." severity error;
    end if;
    if ((CHAN_BOND_SEQ_2_1_0 < "0000000000") or (CHAN_BOND_SEQ_2_1_0 > "1111111111")) then
      assert FALSE report "Error : CHAN_BOND_SEQ_2_1_0 is not in range 0 .. 1023." severity error;
    end if;
    if ((CHAN_BOND_SEQ_2_1_1 < "0000000000") or (CHAN_BOND_SEQ_2_1_1 > "1111111111")) then
      assert FALSE report "Error : CHAN_BOND_SEQ_2_1_1 is not in range 0 .. 1023." severity error;
    end if;
    if ((CHAN_BOND_SEQ_2_2_0 < "0000000000") or (CHAN_BOND_SEQ_2_2_0 > "1111111111")) then
      assert FALSE report "Error : CHAN_BOND_SEQ_2_2_0 is not in range 0 .. 1023." severity error;
    end if;
    if ((CHAN_BOND_SEQ_2_2_1 < "0000000000") or (CHAN_BOND_SEQ_2_2_1 > "1111111111")) then
      assert FALSE report "Error : CHAN_BOND_SEQ_2_2_1 is not in range 0 .. 1023." severity error;
    end if;
    if ((CHAN_BOND_SEQ_2_3_0 < "0000000000") or (CHAN_BOND_SEQ_2_3_0 > "1111111111")) then
      assert FALSE report "Error : CHAN_BOND_SEQ_2_3_0 is not in range 0 .. 1023." severity error;
    end if;
    if ((CHAN_BOND_SEQ_2_3_1 < "0000000000") or (CHAN_BOND_SEQ_2_3_1 > "1111111111")) then
      assert FALSE report "Error : CHAN_BOND_SEQ_2_3_1 is not in range 0 .. 1023." severity error;
    end if;
    if ((CHAN_BOND_SEQ_2_4_0 < "0000000000") or (CHAN_BOND_SEQ_2_4_0 > "1111111111")) then
      assert FALSE report "Error : CHAN_BOND_SEQ_2_4_0 is not in range 0 .. 1023." severity error;
    end if;
    if ((CHAN_BOND_SEQ_2_4_1 < "0000000000") or (CHAN_BOND_SEQ_2_4_1 > "1111111111")) then
      assert FALSE report "Error : CHAN_BOND_SEQ_2_4_1 is not in range 0 .. 1023." severity error;
    end if;
    if ((CHAN_BOND_SEQ_2_ENABLE_0 < "0000") or (CHAN_BOND_SEQ_2_ENABLE_0 > "1111")) then
      assert FALSE report "Error : CHAN_BOND_SEQ_2_ENABLE_0 is not in range 0 .. 15." severity error;
    end if;
    if ((CHAN_BOND_SEQ_2_ENABLE_1 < "0000") or (CHAN_BOND_SEQ_2_ENABLE_1 > "1111")) then
      assert FALSE report "Error : CHAN_BOND_SEQ_2_ENABLE_1 is not in range 0 .. 15." severity error;
      end if;
      if ((CHAN_BOND_SEQ_LEN_0 >= 1) and (CHAN_BOND_SEQ_LEN_0 <= 4)) then
        CHAN_BOND_SEQ_LEN_0_BINARY <= CONV_STD_LOGIC_VECTOR(CHAN_BOND_SEQ_LEN_0 - 1, 2);
      else
        assert FALSE report "Error : CHAN_BOND_SEQ_LEN_0 is not in range 1 .. 4." severity error;
      end if;
      if ((CHAN_BOND_SEQ_LEN_1 >= 1) and (CHAN_BOND_SEQ_LEN_1 <= 4)) then
        CHAN_BOND_SEQ_LEN_1_BINARY <= CONV_STD_LOGIC_VECTOR(CHAN_BOND_SEQ_LEN_1 - 1, 2);
      else
        assert FALSE report "Error : CHAN_BOND_SEQ_LEN_1 is not in range 1 .. 4." severity error;
      end if;
      case CLK25_DIVIDER_0 is
        when  1   =>  CLK25_DIVIDER_0_BINARY <= "000";
        when  2   =>  CLK25_DIVIDER_0_BINARY <= "001";
        when  3   =>  CLK25_DIVIDER_0_BINARY <= "010";
        when  4   =>  CLK25_DIVIDER_0_BINARY <= "011";
        when  5   =>  CLK25_DIVIDER_0_BINARY <= "100";
        when  6   =>  CLK25_DIVIDER_0_BINARY <= "101";
        when  10  =>  CLK25_DIVIDER_0_BINARY <= "110";
        when  12  =>  CLK25_DIVIDER_0_BINARY <= "111";
        when others  =>  assert FALSE report "Error : CLK25_DIVIDER_0 is not 1, 2, 3, 4, 5, 6, 10 or 12." severity error;
      end case;
      case CLK25_DIVIDER_1 is
        when  1   =>  CLK25_DIVIDER_1_BINARY <= "000";
        when  2   =>  CLK25_DIVIDER_1_BINARY <= "001";
        when  3   =>  CLK25_DIVIDER_1_BINARY <= "010";
        when  4   =>  CLK25_DIVIDER_1_BINARY <= "011";
        when  5   =>  CLK25_DIVIDER_1_BINARY <= "100";
        when  6   =>  CLK25_DIVIDER_1_BINARY <= "101";
        when  10  =>  CLK25_DIVIDER_1_BINARY <= "110";
        when  12  =>  CLK25_DIVIDER_1_BINARY <= "111";
        when others  =>  assert FALSE report "Error : CLK25_DIVIDER_1 is not 1, 2, 3, 4, 5, 6, 10 or 12." severity error;
      end case;
      if ((CLK_COR_ADJ_LEN_0 >= 1) and (CLK_COR_ADJ_LEN_0 <= 4)) then
        CLK_COR_ADJ_LEN_0_BINARY <= CONV_STD_LOGIC_VECTOR(CLK_COR_ADJ_LEN_0 - 1, 2);
      else
        assert FALSE report "Error : CLK_COR_ADJ_LEN_0 is not in range 1 .. 4." severity error;
      end if;
      if ((CLK_COR_ADJ_LEN_1 >= 1) and (CLK_COR_ADJ_LEN_1 <= 4)) then
        CLK_COR_ADJ_LEN_1_BINARY <= CONV_STD_LOGIC_VECTOR(CLK_COR_ADJ_LEN_1 - 1, 2);
      else
        assert FALSE report "Error : CLK_COR_ADJ_LEN_1 is not in range 1 .. 4." severity error;
      end if;
      if ((CLK_COR_DET_LEN_0 >= 1) and (CLK_COR_DET_LEN_0 <= 4)) then
        CLK_COR_DET_LEN_0_BINARY <= CONV_STD_LOGIC_VECTOR(CLK_COR_DET_LEN_0 - 1, 2);
      else
        assert FALSE report "Error : CLK_COR_DET_LEN_0 is not in range 1 .. 4." severity error;
      end if;
      if ((CLK_COR_DET_LEN_1 >= 1) and (CLK_COR_DET_LEN_1 <= 4)) then
        CLK_COR_DET_LEN_1_BINARY <= CONV_STD_LOGIC_VECTOR(CLK_COR_DET_LEN_1 - 1, 2);
      else
        assert FALSE report "Error : CLK_COR_DET_LEN_1 is not in range 1 .. 4." severity error;
      end if;
      if ((CLK_COR_MAX_LAT_0 >= 3) and (CLK_COR_MAX_LAT_0 <= 48)) then
        CLK_COR_MAX_LAT_0_BINARY <= CONV_STD_LOGIC_VECTOR(CLK_COR_MAX_LAT_0, 6);
      else
        assert FALSE report "Error : CLK_COR_MAX_LAT_0 is not in range 3 .. 48." severity error;
      end if;
      if ((CLK_COR_MAX_LAT_1 >= 3) and (CLK_COR_MAX_LAT_1 <= 48)) then
        CLK_COR_MAX_LAT_1_BINARY <= CONV_STD_LOGIC_VECTOR(CLK_COR_MAX_LAT_1, 6);
      else
        assert FALSE report "Error : CLK_COR_MAX_LAT_1 is not in range 3 .. 48." severity error;
      end if;
      if ((CLK_COR_MIN_LAT_0 >= 3) and (CLK_COR_MIN_LAT_0 <= 48)) then
        CLK_COR_MIN_LAT_0_BINARY <= CONV_STD_LOGIC_VECTOR(CLK_COR_MIN_LAT_0, 6);
      else
        assert FALSE report "Error : CLK_COR_MIN_LAT_0 is not in range 3 .. 48." severity error;
      end if;
      if ((CLK_COR_MIN_LAT_1 >= 3) and (CLK_COR_MIN_LAT_1 <= 48)) then
        CLK_COR_MIN_LAT_1_BINARY <= CONV_STD_LOGIC_VECTOR(CLK_COR_MIN_LAT_1, 6);
      else
        assert FALSE report "Error : CLK_COR_MIN_LAT_1 is not in range 3 .. 48." severity error;
      end if;
      if ((CLK_COR_REPEAT_WAIT_0 >= 0) and (CLK_COR_REPEAT_WAIT_0 <= 31)) then
        CLK_COR_REPEAT_WAIT_0_BINARY <= CONV_STD_LOGIC_VECTOR(CLK_COR_REPEAT_WAIT_0, 5);
      else
        assert FALSE report "Error : CLK_COR_REPEAT_WAIT_0 is not in range 0 .. 31." severity error;
      end if;
      if ((CLK_COR_REPEAT_WAIT_1 >= 0) and (CLK_COR_REPEAT_WAIT_1 <= 31)) then
        CLK_COR_REPEAT_WAIT_1_BINARY <= CONV_STD_LOGIC_VECTOR(CLK_COR_REPEAT_WAIT_1, 5);
      else
        assert FALSE report "Error : CLK_COR_REPEAT_WAIT_1 is not in range 0 .. 31." severity error;
      end if;
    if ((CLK_COR_SEQ_1_1_0 < "0000000000") or (CLK_COR_SEQ_1_1_0 > "1111111111")) then
      assert FALSE report "Error : CLK_COR_SEQ_1_1_0 is not in range 0 .. 1023." severity error;
    end if;
    if ((CLK_COR_SEQ_1_1_1 < "0000000000") or (CLK_COR_SEQ_1_1_1 > "1111111111")) then
      assert FALSE report "Error : CLK_COR_SEQ_1_1_1 is not in range 0 .. 1023." severity error;
    end if;
    if ((CLK_COR_SEQ_1_2_0 < "0000000000") or (CLK_COR_SEQ_1_2_0 > "1111111111")) then
      assert FALSE report "Error : CLK_COR_SEQ_1_2_0 is not in range 0 .. 1023." severity error;
    end if;
    if ((CLK_COR_SEQ_1_2_1 < "0000000000") or (CLK_COR_SEQ_1_2_1 > "1111111111")) then
      assert FALSE report "Error : CLK_COR_SEQ_1_2_1 is not in range 0 .. 1023." severity error;
    end if;
    if ((CLK_COR_SEQ_1_3_0 < "0000000000") or (CLK_COR_SEQ_1_3_0 > "1111111111")) then
      assert FALSE report "Error : CLK_COR_SEQ_1_3_0 is not in range 0 .. 1023." severity error;
    end if;
    if ((CLK_COR_SEQ_1_3_1 < "0000000000") or (CLK_COR_SEQ_1_3_1 > "1111111111")) then
      assert FALSE report "Error : CLK_COR_SEQ_1_3_1 is not in range 0 .. 1023." severity error;
    end if;
    if ((CLK_COR_SEQ_1_4_0 < "0000000000") or (CLK_COR_SEQ_1_4_0 > "1111111111")) then
      assert FALSE report "Error : CLK_COR_SEQ_1_4_0 is not in range 0 .. 1023." severity error;
    end if;
    if ((CLK_COR_SEQ_1_4_1 < "0000000000") or (CLK_COR_SEQ_1_4_1 > "1111111111")) then
      assert FALSE report "Error : CLK_COR_SEQ_1_4_1 is not in range 0 .. 1023." severity error;
    end if;
    if ((CLK_COR_SEQ_1_ENABLE_0 < "0000") or (CLK_COR_SEQ_1_ENABLE_0 > "1111")) then
      assert FALSE report "Error : CLK_COR_SEQ_1_ENABLE_0 is not in range 0 .. 15." severity error;
    end if;
    if ((CLK_COR_SEQ_1_ENABLE_1 < "0000") or (CLK_COR_SEQ_1_ENABLE_1 > "1111")) then
      assert FALSE report "Error : CLK_COR_SEQ_1_ENABLE_1 is not in range 0 .. 15." severity error;
    end if;
    if ((CLK_COR_SEQ_2_1_0 < "0000000000") or (CLK_COR_SEQ_2_1_0 > "1111111111")) then
      assert FALSE report "Error : CLK_COR_SEQ_2_1_0 is not in range 0 .. 1023." severity error;
    end if;
    if ((CLK_COR_SEQ_2_1_1 < "0000000000") or (CLK_COR_SEQ_2_1_1 > "1111111111")) then
      assert FALSE report "Error : CLK_COR_SEQ_2_1_1 is not in range 0 .. 1023." severity error;
    end if;
    if ((CLK_COR_SEQ_2_2_0 < "0000000000") or (CLK_COR_SEQ_2_2_0 > "1111111111")) then
      assert FALSE report "Error : CLK_COR_SEQ_2_2_0 is not in range 0 .. 1023." severity error;
    end if;
    if ((CLK_COR_SEQ_2_2_1 < "0000000000") or (CLK_COR_SEQ_2_2_1 > "1111111111")) then
      assert FALSE report "Error : CLK_COR_SEQ_2_2_1 is not in range 0 .. 1023." severity error;
    end if;
    if ((CLK_COR_SEQ_2_3_0 < "0000000000") or (CLK_COR_SEQ_2_3_0 > "1111111111")) then
      assert FALSE report "Error : CLK_COR_SEQ_2_3_0 is not in range 0 .. 1023." severity error;
    end if;
    if ((CLK_COR_SEQ_2_3_1 < "0000000000") or (CLK_COR_SEQ_2_3_1 > "1111111111")) then
      assert FALSE report "Error : CLK_COR_SEQ_2_3_1 is not in range 0 .. 1023." severity error;
    end if;
    if ((CLK_COR_SEQ_2_4_0 < "0000000000") or (CLK_COR_SEQ_2_4_0 > "1111111111")) then
      assert FALSE report "Error : CLK_COR_SEQ_2_4_0 is not in range 0 .. 1023." severity error;
    end if;
    if ((CLK_COR_SEQ_2_4_1 < "0000000000") or (CLK_COR_SEQ_2_4_1 > "1111111111")) then
      assert FALSE report "Error : CLK_COR_SEQ_2_4_1 is not in range 0 .. 1023." severity error;
    end if;
    if ((CLK_COR_SEQ_2_ENABLE_0 < "0000") or (CLK_COR_SEQ_2_ENABLE_0 > "1111")) then
      assert FALSE report "Error : CLK_COR_SEQ_2_ENABLE_0 is not in range 0 .. 15." severity error;
    end if;
    if ((CLK_COR_SEQ_2_ENABLE_1 < "0000") or (CLK_COR_SEQ_2_ENABLE_1 > "1111")) then
      assert FALSE report "Error : CLK_COR_SEQ_2_ENABLE_1 is not in range 0 .. 15." severity error;
    end if;
    if ((CM_TRIM_0 < "00") or (CM_TRIM_0 > "11")) then
      assert FALSE report "Error : CM_TRIM_0 is not in range 0 .. 3." severity error;
    end if;
    if ((CM_TRIM_1 < "00") or (CM_TRIM_1 > "11")) then
      assert FALSE report "Error : CM_TRIM_1 is not in range 0 .. 3." severity error;
    end if;
    if ((COMMA_10B_ENABLE_0 < "0000000000") or (COMMA_10B_ENABLE_0 > "1111111111")) then
      assert FALSE report "Error : COMMA_10B_ENABLE_0 is not in range 0 .. 1023." severity error;
    end if;
    if ((COMMA_10B_ENABLE_1 < "0000000000") or (COMMA_10B_ENABLE_1 > "1111111111")) then
      assert FALSE report "Error : COMMA_10B_ENABLE_1 is not in range 0 .. 1023." severity error;
    end if;
    if ((COM_BURST_VAL_0 < "0000") or (COM_BURST_VAL_0 > "1111")) then
      assert FALSE report "Error : COM_BURST_VAL_0 is not in range 0 .. 15." severity error;
    end if;
    if ((COM_BURST_VAL_1 < "0000") or (COM_BURST_VAL_1 > "1111")) then
      assert FALSE report "Error : COM_BURST_VAL_1 is not in range 0 .. 15." severity error;
    end if;
    if ((MCOMMA_10B_VALUE_0 < "0000000000") or (MCOMMA_10B_VALUE_0 > "1111111111")) then
      assert FALSE report "Error : MCOMMA_10B_VALUE_0 is not in range 0 .. 1023." severity error;
    end if;
    if ((MCOMMA_10B_VALUE_1 < "0000000000") or (MCOMMA_10B_VALUE_1 > "1111111111")) then
      assert FALSE report "Error : MCOMMA_10B_VALUE_1 is not in range 0 .. 1023." severity error;
    end if;
    if ((OOBDETECT_THRESHOLD_0 < "000") or (OOBDETECT_THRESHOLD_0 > "111")) then
      assert FALSE report "Error : OOBDETECT_THRESHOLD_0 is not in range 0 .. 7." severity error;
    end if;
    if ((OOBDETECT_THRESHOLD_1 < "000") or (OOBDETECT_THRESHOLD_1 > "111")) then
      assert FALSE report "Error : OOBDETECT_THRESHOLD_1 is not in range 0 .. 7." severity error;
    end if;
      case OOB_CLK_DIVIDER_0 is
        when  1   =>  OOB_CLK_DIVIDER_0_BINARY <= "000";
        when  2   =>  OOB_CLK_DIVIDER_0_BINARY <= "001";
        when  4   =>  OOB_CLK_DIVIDER_0_BINARY <= "010";
        when  6   =>  OOB_CLK_DIVIDER_0_BINARY <= "011";
        when  8   =>  OOB_CLK_DIVIDER_0_BINARY <= "100";
        when  10   =>  OOB_CLK_DIVIDER_0_BINARY <= "101";
        when  12   =>  OOB_CLK_DIVIDER_0_BINARY <= "110";
        when  14   =>  OOB_CLK_DIVIDER_0_BINARY <= "111";
        when others  =>  assert FALSE report "Error : OOB_CLK_DIVIDER_0 is not in range 1, 2, 4, 6, 8, 10, 12 or 14." severity error;
      end case;
      case OOB_CLK_DIVIDER_1 is
        when  1   =>  OOB_CLK_DIVIDER_1_BINARY <= "000";
        when  2   =>  OOB_CLK_DIVIDER_1_BINARY <= "001";
        when  4   =>  OOB_CLK_DIVIDER_1_BINARY <= "010";
        when  6   =>  OOB_CLK_DIVIDER_1_BINARY <= "011";
        when  8   =>  OOB_CLK_DIVIDER_1_BINARY <= "100";
        when  10   =>  OOB_CLK_DIVIDER_1_BINARY <= "101";
        when  12   =>  OOB_CLK_DIVIDER_1_BINARY <= "110";
        when  14   =>  OOB_CLK_DIVIDER_1_BINARY <= "111";
        when others  =>  assert FALSE report "Error : OOB_CLK_DIVIDER_1 is not 1, 2, 4, 6, 8, 10, 12 or 14." severity error;
      end case;
    if ((PCOMMA_10B_VALUE_0 < "0000000000") or (PCOMMA_10B_VALUE_0 > "1111111111")) then
      assert FALSE report "Error : PCOMMA_10B_VALUE_0 is not in range 0 .. 1023." severity error;
    end if;
    if ((PCOMMA_10B_VALUE_1 < "0000000000") or (PCOMMA_10B_VALUE_1 > "1111111111")) then
      assert FALSE report "Error : PCOMMA_10B_VALUE_1 is not in range 0 .. 1023." severity error;
    end if;
    if ((PLLLKDET_CFG_0 < "000") or (PLLLKDET_CFG_0 > "111")) then
      assert FALSE report "Error : PLLLKDET_CFG_0 is not in range 0 .. 7." severity error;
    end if;
    if ((PLLLKDET_CFG_1 < "000") or (PLLLKDET_CFG_1 > "111")) then
      assert FALSE report "Error : PLLLKDET_CFG_1 is not in range 0 .. 7." severity error;
    end if;
      case PLL_DIVSEL_FB_0 is
        when  1   =>  PLL_DIVSEL_FB_0_BINARY <= "10000";
        when  2   =>  PLL_DIVSEL_FB_0_BINARY <= "00000";
        when  3   =>  PLL_DIVSEL_FB_0_BINARY <= "00001";
        when  4   =>  PLL_DIVSEL_FB_0_BINARY <= "00010";
        when  5   =>  PLL_DIVSEL_FB_0_BINARY <= "00011";
        when  8   =>  PLL_DIVSEL_FB_0_BINARY <= "00110";
        when  10   =>  PLL_DIVSEL_FB_0_BINARY <= "00111";
        when others  =>  assert FALSE report "Error : PLL_DIVSEL_FB_0 is not in range 1 to 5 or 8 or 10." severity error;
      end case;
      case PLL_DIVSEL_FB_1 is
        when  1   =>  PLL_DIVSEL_FB_1_BINARY <= "10000";
        when  2   =>  PLL_DIVSEL_FB_1_BINARY <= "00000";
        when  3   =>  PLL_DIVSEL_FB_1_BINARY <= "00001";
        when  4   =>  PLL_DIVSEL_FB_1_BINARY <= "00010";
        when  5   =>  PLL_DIVSEL_FB_1_BINARY <= "00011";
        when  8   =>  PLL_DIVSEL_FB_1_BINARY <= "00110";
        when  10   =>  PLL_DIVSEL_FB_1_BINARY <= "00111";
        when others  =>  assert FALSE report "Error : PLL_DIVSEL_FB_1 is not in range 1 to 5 or 8 or 10." severity error;
      end case;
      case PLL_DIVSEL_REF_0 is
        when  1   =>  PLL_DIVSEL_REF_0_BINARY <= "010000";
        when  2   =>  PLL_DIVSEL_REF_0_BINARY <= "000000";
        when  3   =>  PLL_DIVSEL_REF_0_BINARY <= "000001";
        when  4   =>  PLL_DIVSEL_REF_0_BINARY <= "000010";
        when  5   =>  PLL_DIVSEL_REF_0_BINARY <= "000011";
        when  6   =>  PLL_DIVSEL_REF_0_BINARY <= "000101";
        when  8   =>  PLL_DIVSEL_REF_0_BINARY <= "000110";
        when  10   =>  PLL_DIVSEL_REF_0_BINARY <= "000111";
        when  12   =>  PLL_DIVSEL_REF_0_BINARY <= "001101";
        when  16   =>  PLL_DIVSEL_REF_0_BINARY <= "001110";
        when  20   =>  PLL_DIVSEL_REF_0_BINARY <= "001111";
        when others  =>  assert FALSE report "Error : PLL_DIVSEL_REF_0 is not in range 1 to 6 or 8, 10 ,12, 16 or 20." severity error;
      end case;
      case PLL_DIVSEL_REF_1 is
        when  1   =>  PLL_DIVSEL_REF_1_BINARY <= "010000";
        when  2   =>  PLL_DIVSEL_REF_1_BINARY <= "000000";
        when  3   =>  PLL_DIVSEL_REF_1_BINARY <= "000001";
        when  4   =>  PLL_DIVSEL_REF_1_BINARY <= "000010";
        when  5   =>  PLL_DIVSEL_REF_1_BINARY <= "000011";
        when  6   =>  PLL_DIVSEL_REF_1_BINARY <= "000101";
        when  8   =>  PLL_DIVSEL_REF_1_BINARY <= "000110";
        when  10   =>  PLL_DIVSEL_REF_1_BINARY <= "000111";
        when  12   =>  PLL_DIVSEL_REF_1_BINARY <= "001101";
        when  16   =>  PLL_DIVSEL_REF_1_BINARY <= "001110";
        when  20   =>  PLL_DIVSEL_REF_1_BINARY <= "001111";
        when others  =>  assert FALSE report "Error : PLL_DIVSEL_REF_1 is not in range 1 to 6 or 8, 10 ,12, 16 or 20." severity error;
      end case;
      case PLL_RXDIVSEL_OUT_0 is
        when  1   =>  PLL_RXDIVSEL_OUT_0_BINARY <= "00";
        when  2   =>  PLL_RXDIVSEL_OUT_0_BINARY <= "01";
        when  4   =>  PLL_RXDIVSEL_OUT_0_BINARY <= "10";
        when others  =>  assert FALSE report "Error : PLL_RXDIVSEL_OUT_0 is not in range 1, 2 or 4." severity error;
      end case;
      case PLL_RXDIVSEL_OUT_1 is
        when  1   =>  PLL_RXDIVSEL_OUT_1_BINARY <= "00";
        when  2   =>  PLL_RXDIVSEL_OUT_1_BINARY <= "01";
        when  4   =>  PLL_RXDIVSEL_OUT_1_BINARY <= "10";
        when others  =>  assert FALSE report "Error : PLL_RXDIVSEL_OUT_1 is not in range 1, 2 or 4." severity error;
      end case;
      case PLL_TXDIVSEL_OUT_0 is
        when  1   =>  PLL_TXDIVSEL_OUT_0_BINARY <= "00";
        when  2   =>  PLL_TXDIVSEL_OUT_0_BINARY <= "01";
        when  4   =>  PLL_TXDIVSEL_OUT_0_BINARY <= "10";
        when others  =>  assert FALSE report "Error : PLL_TXDIVSEL_OUT_0 is not in range 1, 2 or 4." severity error;
      end case;
      case PLL_TXDIVSEL_OUT_1 is
        when  1   =>  PLL_TXDIVSEL_OUT_1_BINARY <= "00";
        when  2   =>  PLL_TXDIVSEL_OUT_1_BINARY <= "01";
        when  4   =>  PLL_TXDIVSEL_OUT_1_BINARY <= "10";
        when others  =>  assert FALSE report "Error : PLL_TXDIVSEL_OUT_1 is not in range 1, 2 or 4." severity error;
      end case;
    if ((RXEQ_CFG_0 < "00000000") or (RXEQ_CFG_0 > "11111111")) then
      assert FALSE report "Error : RXEQ_CFG_0 is not in range 0 .. 255." severity error;
    end if;
    if ((RXEQ_CFG_1 < "00000000") or (RXEQ_CFG_1 > "11111111")) then
      assert FALSE report "Error : RXEQ_CFG_1 is not in range 0 .. 255." severity error;
    end if;
    if ((RX_IDLE_HI_CNT_0 < "0000") or (RX_IDLE_HI_CNT_0 > "1111")) then
      assert FALSE report "Error : RX_IDLE_HI_CNT_0 is not in range 0 .. 15." severity error;
    end if;
    if ((RX_IDLE_HI_CNT_1 < "0000") or (RX_IDLE_HI_CNT_1 > "1111")) then
      assert FALSE report "Error : RX_IDLE_HI_CNT_1 is not in range 0 .. 15." severity error;
    end if;
    if ((RX_IDLE_LO_CNT_0 < "0000") or (RX_IDLE_LO_CNT_0 > "1111")) then
      assert FALSE report "Error : RX_IDLE_LO_CNT_0 is not in range 0 .. 15." severity error;
    end if;
    if ((RX_IDLE_LO_CNT_1 < "0000") or (RX_IDLE_LO_CNT_1 > "1111")) then
      assert FALSE report "Error : RX_IDLE_LO_CNT_1 is not in range 0 .. 15." severity error;
    end if;
      case RX_LOS_INVALID_INCR_0 is
        when  1   =>  RX_LOS_INVALID_INCR_0_BINARY <= "000";
        when  2   =>  RX_LOS_INVALID_INCR_0_BINARY <= "001";
        when  4   =>  RX_LOS_INVALID_INCR_0_BINARY <= "010";
        when  8   =>  RX_LOS_INVALID_INCR_0_BINARY <= "011";
        when  16   =>  RX_LOS_INVALID_INCR_0_BINARY <= "100";
        when  32   =>  RX_LOS_INVALID_INCR_0_BINARY <= "101";
        when  64   =>  RX_LOS_INVALID_INCR_0_BINARY <= "110";
        when  128   =>  RX_LOS_INVALID_INCR_0_BINARY <= "111";
        when others  =>  assert FALSE report "Error : RX_LOS_INVALID_INCR_0 is not 1, 2, 4, 8, 16, 32, 64 or 128." severity error;
      end case;
      case RX_LOS_INVALID_INCR_1 is
        when  1   =>  RX_LOS_INVALID_INCR_1_BINARY <= "000";
        when  2   =>  RX_LOS_INVALID_INCR_1_BINARY <= "001";
        when  4   =>  RX_LOS_INVALID_INCR_1_BINARY <= "010";
        when  8   =>  RX_LOS_INVALID_INCR_1_BINARY <= "011";
        when  16   =>  RX_LOS_INVALID_INCR_1_BINARY <= "100";
        when  32   =>  RX_LOS_INVALID_INCR_1_BINARY <= "101";
        when  64   =>  RX_LOS_INVALID_INCR_1_BINARY <= "110";
        when  128   =>  RX_LOS_INVALID_INCR_1_BINARY <= "111";
        when others  =>  assert FALSE report "Error : RX_LOS_INVALID_INCR_1 is not 1, 2, 4, 8, 16, 32, 64 or 128." severity error;
      end case;
      case RX_LOS_THRESHOLD_0 is
        when  4   =>  RX_LOS_THRESHOLD_0_BINARY <= "000";
        when  8   =>  RX_LOS_THRESHOLD_0_BINARY <= "001";
        when  16   =>  RX_LOS_THRESHOLD_0_BINARY <= "010";
        when  32   =>  RX_LOS_THRESHOLD_0_BINARY <= "011";
        when  64   =>  RX_LOS_THRESHOLD_0_BINARY <= "100";
        when  128   =>  RX_LOS_THRESHOLD_0_BINARY <= "101";
        when  256   =>  RX_LOS_THRESHOLD_0_BINARY <= "110";
        when  512   =>  RX_LOS_THRESHOLD_0_BINARY <= "111";
        when others  =>  assert FALSE report "Error : RX_LOS_THRESHOLD_0 is not 4, 8, 16, 32, 64, 128, 256 or 512." severity error;
      end case;
      case RX_LOS_THRESHOLD_1 is
        when  4   =>  RX_LOS_THRESHOLD_1_BINARY <= "000";
        when  8   =>  RX_LOS_THRESHOLD_1_BINARY <= "001";
        when  16   =>  RX_LOS_THRESHOLD_1_BINARY <= "010";
        when  32   =>  RX_LOS_THRESHOLD_1_BINARY <= "011";
        when  64   =>  RX_LOS_THRESHOLD_1_BINARY <= "100";
        when  128   =>  RX_LOS_THRESHOLD_1_BINARY <= "101";
        when  256   =>  RX_LOS_THRESHOLD_1_BINARY <= "110";
        when  512   =>  RX_LOS_THRESHOLD_1_BINARY <= "111";
        when others  =>  assert FALSE report "Error : RX_LOS_THRESHOLD_1 is not 4, 8, 16, 32, 64, 128, 256 or 512." severity error;
        end case;
    if ((SATA_BURST_VAL_0 < "000") or (SATA_BURST_VAL_0 > "111")) then
      assert FALSE report "Error : SATA_BURST_VAL_0 is not in range 0 .. 7." severity error;
    end if;
    if ((SATA_BURST_VAL_1 < "000") or (SATA_BURST_VAL_1 > "111")) then
      assert FALSE report "Error : SATA_BURST_VAL_1 is not in range 0 .. 7." severity error;
    end if;
    if ((SATA_IDLE_VAL_0 < "000") or (SATA_IDLE_VAL_0 > "111")) then
      assert FALSE report "Error : SATA_IDLE_VAL_0 is not in range 0 .. 7." severity error;
    end if;
    if ((SATA_IDLE_VAL_1 < "000") or (SATA_IDLE_VAL_1 > "111")) then
      assert FALSE report "Error : SATA_IDLE_VAL_1 is not in range 0 .. 7." severity error;
    end if;
      if ((SATA_MAX_BURST_0 >= 1) and (SATA_MAX_BURST_0 <= 61)) then
        SATA_MAX_BURST_0_BINARY <= CONV_STD_LOGIC_VECTOR(SATA_MAX_BURST_0, 6);
      else
        assert FALSE report "Error : SATA_MAX_BURST_0 is not in range 1 .. 61." severity error;
      end if;
      if ((SATA_MAX_BURST_1 >= 1) and (SATA_MAX_BURST_1 <= 61)) then
        SATA_MAX_BURST_1_BINARY <= CONV_STD_LOGIC_VECTOR(SATA_MAX_BURST_1, 6);
      else
        assert FALSE report "Error : SATA_MAX_BURST_1 is not in range 1 .. 61." severity error;
      end if;
      if ((SATA_MAX_INIT_0 >= 1) and (SATA_MAX_INIT_0 <= 61)) then
        SATA_MAX_INIT_0_BINARY <= CONV_STD_LOGIC_VECTOR(SATA_MAX_INIT_0, 6);
      else
        assert FALSE report "Error : SATA_MAX_INIT_0 is not in range 1 .. 61." severity error;
      end if;
      if ((SATA_MAX_INIT_1 >= 1) and (SATA_MAX_INIT_1 <= 61)) then
        SATA_MAX_INIT_1_BINARY <= CONV_STD_LOGIC_VECTOR(SATA_MAX_INIT_1, 6);
      else
        assert FALSE report "Error : SATA_MAX_INIT_1 is not in range 1 .. 61." severity error;
      end if;
      if ((SATA_MAX_WAKE_0 >= 1) and (SATA_MAX_WAKE_0 <= 61)) then
        SATA_MAX_WAKE_0_BINARY <= CONV_STD_LOGIC_VECTOR(SATA_MAX_WAKE_0, 6);
      else
        assert FALSE report "Error : SATA_MAX_WAKE_0 is not in range 1 .. 61." severity error;
      end if;
      if ((SATA_MAX_WAKE_1 >= 1) and (SATA_MAX_WAKE_1 <= 61)) then
        SATA_MAX_WAKE_1_BINARY <= CONV_STD_LOGIC_VECTOR(SATA_MAX_WAKE_1, 6);
      else
        assert FALSE report "Error : SATA_MAX_WAKE_1 is not in range 1 .. 61." severity error;
      end if;
      if ((SATA_MIN_BURST_0 >= 1) and (SATA_MIN_BURST_0 <= 61)) then
        SATA_MIN_BURST_0_BINARY <= CONV_STD_LOGIC_VECTOR(SATA_MIN_BURST_0, 6);
      else
        assert FALSE report "Error : SATA_MIN_BURST_0 is not in range 1 .. 61." severity error;
      end if;
      if ((SATA_MIN_BURST_1 >= 1) and (SATA_MIN_BURST_1 <= 61)) then
        SATA_MIN_BURST_1_BINARY <= CONV_STD_LOGIC_VECTOR(SATA_MIN_BURST_1, 6);
      else
        assert FALSE report "Error : SATA_MIN_BURST_1 is not in range 1 .. 61." severity error;
      end if;
      if ((SATA_MIN_INIT_0 >= 1) and (SATA_MIN_INIT_0 <= 61)) then
        SATA_MIN_INIT_0_BINARY <= CONV_STD_LOGIC_VECTOR(SATA_MIN_INIT_0, 6);
      else
        assert FALSE report "Error : SATA_MIN_INIT_0 is not in range 1 .. 61." severity error;
      end if;
      if ((SATA_MIN_INIT_1 >= 1) and (SATA_MIN_INIT_1 <= 61)) then
        SATA_MIN_INIT_1_BINARY <= CONV_STD_LOGIC_VECTOR(SATA_MIN_INIT_1, 6);
      else
        assert FALSE report "Error : SATA_MIN_INIT_1 is not in range 1 .. 61." severity error;
      end if;
      if ((SATA_MIN_WAKE_0 >= 1) and (SATA_MIN_WAKE_0 <= 61)) then
        SATA_MIN_WAKE_0_BINARY <= CONV_STD_LOGIC_VECTOR(SATA_MIN_WAKE_0, 6);
      else
        assert FALSE report "Error : SATA_MIN_WAKE_0 is not in range 1 .. 61." severity error;
      end if;
      if ((SATA_MIN_WAKE_1 >= 1) and (SATA_MIN_WAKE_1 <= 61)) then
        SATA_MIN_WAKE_1_BINARY <= CONV_STD_LOGIC_VECTOR(SATA_MIN_WAKE_1, 6);
      else
        assert FALSE report "Error : SATA_MIN_WAKE_1 is not in range 1 .. 61." severity error;
      end if;
    if ((SIM_REFCLK0_SOURCE < "000") or (SIM_REFCLK0_SOURCE > "111")) then
      assert FALSE report "Error : SIM_REFCLK0_SOURCE is not in range 0 .. 7." severity error;
    end if;
    if ((SIM_REFCLK1_SOURCE < "000") or (SIM_REFCLK1_SOURCE > "111")) then
      assert FALSE report "Error : SIM_REFCLK1_SOURCE is not in range 0 .. 7." severity error;
    end if;
    if ((TERMINATION_CTRL_0 < "00000") or (TERMINATION_CTRL_0 > "11111")) then
      assert FALSE report "Error : TERMINATION_CTRL_0 is not in range 0 .. 31." severity error;
    end if;
    if ((TERMINATION_CTRL_1 < "00000") or (TERMINATION_CTRL_1 > "11111")) then
      assert FALSE report "Error : TERMINATION_CTRL_1 is not in range 0 .. 31." severity error;
    end if;
    if ((TXRX_INVERT_0 < "000") or (TXRX_INVERT_0 > "111")) then
      assert FALSE report "Error : TXRX_INVERT_0 is not in range 0 .. 7." severity error;
    end if;
    if ((TXRX_INVERT_1 < "000") or (TXRX_INVERT_1 > "111")) then
      assert FALSE report "Error : TXRX_INVERT_1 is not in range 0 .. 7." severity error;
    end if;
    if ((TX_IDLE_DELAY_0 < "000") or (TX_IDLE_DELAY_0 > "111")) then
      assert FALSE report "Error : TX_IDLE_DELAY_0 is not in range 0 .. 7." severity error;
    end if;
    if ((TX_IDLE_DELAY_1 < "000") or (TX_IDLE_DELAY_1 > "111")) then
      assert FALSE report "Error : TX_IDLE_DELAY_1 is not in range 0 .. 7." severity error;
    end if;
    if ((TX_TDCC_CFG_0 < "00") or (TX_TDCC_CFG_0 > "11")) then
      assert FALSE report "Error : TX_TDCC_CFG_0 is not in range 0 .. 3." severity error;
    end if;
    if ((TX_TDCC_CFG_1 < "00") or (TX_TDCC_CFG_1 > "11")) then
      assert FALSE report "Error : TX_TDCC_CFG_1 is not in range 0 .. 3." severity error;
    end if;
      wait;
      end process INIPROC;
      
--####################################################################
--#####                   TIMING CHECKS & OUTPUT                 #####
--####################################################################
    
    TIMING : process
      variable Tmkr_DADDR_DCLK_posedge : VitalTimingDataArrayType(7 downto 0);
      variable Tmkr_DEN_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_DI_DCLK_posedge : VitalTimingDataArrayType(15 downto 0);
      variable Tmkr_DWE_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PRBSCNTRESET0_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PRBSCNTRESET1_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_RXCHBONDI_RXUSRCLK0_posedge : VitalTimingDataArrayType(2 downto 0);
      variable Tmkr_RXCHBONDI_RXUSRCLK1_posedge : VitalTimingDataArrayType(2 downto 0);
      variable Tmkr_RXCHBONDMASTER0_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_RXCHBONDMASTER1_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_RXCHBONDSLAVE0_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_RXCHBONDSLAVE1_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
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
      variable Tmkr_RXENPRBSTST0_RXUSRCLK20_posedge : VitalTimingDataArrayType(2 downto 0);
      variable Tmkr_RXENPRBSTST1_RXUSRCLK21_posedge : VitalTimingDataArrayType(2 downto 0);
      variable Tmkr_RXPOLARITY0_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_RXPOLARITY1_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_RXSLIDE0_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_RXSLIDE1_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_TXBYPASS8B10B0_TXUSRCLK20_posedge : VitalTimingDataArrayType(3 downto 0);
      variable Tmkr_TXBYPASS8B10B1_TXUSRCLK21_posedge : VitalTimingDataArrayType(3 downto 0);
      variable Tmkr_TXCHARDISPMODE0_TXUSRCLK20_posedge : VitalTimingDataArrayType(3 downto 0);
      variable Tmkr_TXCHARDISPMODE1_TXUSRCLK21_posedge : VitalTimingDataArrayType(3 downto 0);
      variable Tmkr_TXCHARDISPVAL0_TXUSRCLK20_posedge : VitalTimingDataArrayType(3 downto 0);
      variable Tmkr_TXCHARDISPVAL1_TXUSRCLK21_posedge : VitalTimingDataArrayType(3 downto 0);
      variable Tmkr_TXCHARISK0_TXUSRCLK20_posedge : VitalTimingDataArrayType(3 downto 0);
      variable Tmkr_TXCHARISK1_TXUSRCLK21_posedge : VitalTimingDataArrayType(3 downto 0);
      variable Tmkr_TXCOMSTART0_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_TXCOMSTART1_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_TXCOMTYPE0_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_TXCOMTYPE1_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_TXDATA0_TXUSRCLK20_posedge : VitalTimingDataArrayType(31 downto 0);
      variable Tmkr_TXDATA1_TXUSRCLK21_posedge : VitalTimingDataArrayType(31 downto 0);
      variable Tmkr_TXDETECTRX0_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_TXDETECTRX1_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_TXELECIDLE0_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_TXELECIDLE1_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_TXENC8B10BUSE0_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_TXENC8B10BUSE1_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_TXENPRBSTST0_TXUSRCLK20_posedge : VitalTimingDataArrayType(2 downto 0);
      variable Tmkr_TXENPRBSTST1_TXUSRCLK21_posedge : VitalTimingDataArrayType(2 downto 0);
      variable Tmkr_TXINHIBIT0_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_TXINHIBIT1_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_TXPOLARITY0_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_TXPOLARITY1_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_TXPOWERDOWN0_TXUSRCLK20_posedge : VitalTimingDataArrayType(1 downto 0);
      variable Tmkr_TXPOWERDOWN1_TXUSRCLK21_posedge : VitalTimingDataArrayType(1 downto 0);
      variable Tmkr_TXPRBSFORCEERR0_TXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_TXPRBSFORCEERR1_TXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_USRCODEERR0_RXUSRCLK20_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_USRCODEERR1_RXUSRCLK21_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tviol_DADDR_DCLK_posedge : std_logic_vector(7 downto 0) := (others => '0');
      variable Tviol_DEN_DCLK_posedge :  std_ulogic := '0';
      variable Tviol_DI_DCLK_posedge : std_logic_vector(15 downto 0) := (others => '0');
      variable Tviol_DWE_DCLK_posedge :  std_ulogic := '0';
      variable Tviol_PRBSCNTRESET0_RXUSRCLK20_posedge :  std_ulogic := '0';
      variable Tviol_PRBSCNTRESET1_RXUSRCLK21_posedge :  std_ulogic := '0';
      variable Tviol_RXCHBONDI_RXUSRCLK0_posedge : std_logic_vector(2 downto 0) := (others => '0');
      variable Tviol_RXCHBONDI_RXUSRCLK1_posedge : std_logic_vector(2 downto 0) := (others => '0');
      variable Tviol_RXCHBONDMASTER0_RXUSRCLK20_posedge :  std_ulogic := '0';
      variable Tviol_RXCHBONDMASTER1_RXUSRCLK21_posedge :  std_ulogic := '0';
      variable Tviol_RXCHBONDSLAVE0_RXUSRCLK20_posedge :  std_ulogic := '0';
      variable Tviol_RXCHBONDSLAVE1_RXUSRCLK21_posedge :  std_ulogic := '0';
      variable Tviol_RXCOMMADETUSE0_RXUSRCLK20_posedge :  std_ulogic := '0';
      variable Tviol_RXCOMMADETUSE1_RXUSRCLK21_posedge :  std_ulogic := '0';
      variable Tviol_RXDEC8B10BUSE0_RXUSRCLK20_posedge :  std_ulogic := '0';
      variable Tviol_RXDEC8B10BUSE1_RXUSRCLK21_posedge :  std_ulogic := '0';
      variable Tviol_RXENCHANSYNC0_RXUSRCLK20_posedge :  std_ulogic := '0';
      variable Tviol_RXENCHANSYNC1_RXUSRCLK21_posedge :  std_ulogic := '0';
      variable Tviol_RXENMCOMMAALIGN0_RXUSRCLK20_posedge :  std_ulogic := '0';
      variable Tviol_RXENMCOMMAALIGN1_RXUSRCLK21_posedge :  std_ulogic := '0';
      variable Tviol_RXENPCOMMAALIGN0_RXUSRCLK20_posedge :  std_ulogic := '0';
      variable Tviol_RXENPCOMMAALIGN1_RXUSRCLK21_posedge :  std_ulogic := '0';
      variable Tviol_RXENPRBSTST0_RXUSRCLK20_posedge : std_logic_vector(2 downto 0) := (others => '0');
      variable Tviol_RXENPRBSTST1_RXUSRCLK21_posedge : std_logic_vector(2 downto 0) := (others => '0');
      variable Tviol_RXPOLARITY0_RXUSRCLK20_posedge :  std_ulogic := '0';
      variable Tviol_RXPOLARITY1_RXUSRCLK21_posedge :  std_ulogic := '0';
      variable Tviol_RXSLIDE0_RXUSRCLK20_posedge :  std_ulogic := '0';
      variable Tviol_RXSLIDE1_RXUSRCLK21_posedge :  std_ulogic := '0';
      variable Tviol_TXBYPASS8B10B0_TXUSRCLK20_posedge : std_logic_vector(3 downto 0) := (others => '0');
      variable Tviol_TXBYPASS8B10B1_TXUSRCLK21_posedge : std_logic_vector(3 downto 0) := (others => '0');
      variable Tviol_TXCHARDISPMODE0_TXUSRCLK20_posedge : std_logic_vector(3 downto 0) := (others => '0');
      variable Tviol_TXCHARDISPMODE1_TXUSRCLK21_posedge : std_logic_vector(3 downto 0) := (others => '0');
      variable Tviol_TXCHARDISPVAL0_TXUSRCLK20_posedge : std_logic_vector(3 downto 0) := (others => '0');
      variable Tviol_TXCHARDISPVAL1_TXUSRCLK21_posedge : std_logic_vector(3 downto 0) := (others => '0');
      variable Tviol_TXCHARISK0_TXUSRCLK20_posedge : std_logic_vector(3 downto 0) := (others => '0');
      variable Tviol_TXCHARISK1_TXUSRCLK21_posedge : std_logic_vector(3 downto 0) := (others => '0');
      variable Tviol_TXCOMSTART0_TXUSRCLK20_posedge :  std_ulogic := '0';
      variable Tviol_TXCOMSTART1_TXUSRCLK21_posedge :  std_ulogic := '0';
      variable Tviol_TXCOMTYPE0_TXUSRCLK20_posedge :  std_ulogic := '0';
      variable Tviol_TXCOMTYPE1_TXUSRCLK21_posedge :  std_ulogic := '0';
      variable Tviol_TXDATA0_TXUSRCLK20_posedge : std_logic_vector(31 downto 0) := (others => '0');
      variable Tviol_TXDATA1_TXUSRCLK21_posedge : std_logic_vector(31 downto 0) := (others => '0');
      variable Tviol_TXDETECTRX0_TXUSRCLK20_posedge :  std_ulogic := '0';
      variable Tviol_TXDETECTRX1_TXUSRCLK21_posedge :  std_ulogic := '0';
      variable Tviol_TXELECIDLE0_TXUSRCLK20_posedge :  std_ulogic := '0';
      variable Tviol_TXELECIDLE1_TXUSRCLK21_posedge :  std_ulogic := '0';
      variable Tviol_TXENC8B10BUSE0_TXUSRCLK20_posedge :  std_ulogic := '0';
      variable Tviol_TXENC8B10BUSE1_TXUSRCLK21_posedge :  std_ulogic := '0';
      variable Tviol_TXENPRBSTST0_TXUSRCLK20_posedge : std_logic_vector(2 downto 0) := (others => '0');
      variable Tviol_TXENPRBSTST1_TXUSRCLK21_posedge : std_logic_vector(2 downto 0) := (others => '0');
      variable Tviol_TXINHIBIT0_TXUSRCLK20_posedge :  std_ulogic := '0';
      variable Tviol_TXINHIBIT1_TXUSRCLK21_posedge :  std_ulogic := '0';
      variable Tviol_TXPOLARITY0_TXUSRCLK20_posedge :  std_ulogic := '0';
      variable Tviol_TXPOLARITY1_TXUSRCLK21_posedge :  std_ulogic := '0';
      variable Tviol_TXPOWERDOWN0_TXUSRCLK20_posedge : std_logic_vector(1 downto 0) := (others => '0');
      variable Tviol_TXPOWERDOWN1_TXUSRCLK21_posedge : std_logic_vector(1 downto 0) := (others => '0');
      variable Tviol_TXPRBSFORCEERR0_TXUSRCLK20_posedge :  std_ulogic := '0';
      variable Tviol_TXPRBSFORCEERR1_TXUSRCLK21_posedge :  std_ulogic := '0';
      variable Tviol_USRCODEERR0_RXUSRCLK20_posedge :  std_ulogic := '0';
      variable Tviol_USRCODEERR1_RXUSRCLK21_posedge :  std_ulogic := '0';
      variable DRDY_GlitchData : VitalGlitchDataType;
      variable DRPDO0_GlitchData : VitalGlitchDataType;
      variable DRPDO10_GlitchData : VitalGlitchDataType;
      variable DRPDO11_GlitchData : VitalGlitchDataType;
      variable DRPDO12_GlitchData : VitalGlitchDataType;
      variable DRPDO13_GlitchData : VitalGlitchDataType;
      variable DRPDO14_GlitchData : VitalGlitchDataType;
      variable DRPDO15_GlitchData : VitalGlitchDataType;
      variable DRPDO1_GlitchData : VitalGlitchDataType;
      variable DRPDO2_GlitchData : VitalGlitchDataType;
      variable DRPDO3_GlitchData : VitalGlitchDataType;
      variable DRPDO4_GlitchData : VitalGlitchDataType;
      variable DRPDO5_GlitchData : VitalGlitchDataType;
      variable DRPDO6_GlitchData : VitalGlitchDataType;
      variable DRPDO7_GlitchData : VitalGlitchDataType;
      variable DRPDO8_GlitchData : VitalGlitchDataType;
      variable DRPDO9_GlitchData : VitalGlitchDataType;
      variable PHYSTATUS0_GlitchData : VitalGlitchDataType;
      variable PHYSTATUS1_GlitchData : VitalGlitchDataType;
      variable REFCLKPLL0_GlitchData : VitalGlitchDataType;
      variable REFCLKPLL1_GlitchData : VitalGlitchDataType;
      variable RXBUFSTATUS00_GlitchData : VitalGlitchDataType;
      variable RXBUFSTATUS01_GlitchData : VitalGlitchDataType;
      variable RXBUFSTATUS02_GlitchData : VitalGlitchDataType;
      variable RXBUFSTATUS10_GlitchData : VitalGlitchDataType;
      variable RXBUFSTATUS11_GlitchData : VitalGlitchDataType;
      variable RXBUFSTATUS12_GlitchData : VitalGlitchDataType;
      variable RXBYTEISALIGNED0_GlitchData : VitalGlitchDataType;
      variable RXBYTEISALIGNED1_GlitchData : VitalGlitchDataType;
      variable RXBYTEREALIGN0_GlitchData : VitalGlitchDataType;
      variable RXBYTEREALIGN1_GlitchData : VitalGlitchDataType;
      variable RXCHANBONDSEQ0_GlitchData : VitalGlitchDataType;
      variable RXCHANBONDSEQ1_GlitchData : VitalGlitchDataType;
      variable RXCHANISALIGNED0_GlitchData : VitalGlitchDataType;
      variable RXCHANISALIGNED1_GlitchData : VitalGlitchDataType;
      variable RXCHANREALIGN0_GlitchData : VitalGlitchDataType;
      variable RXCHANREALIGN1_GlitchData : VitalGlitchDataType;
      variable RXCHARISCOMMA00_GlitchData : VitalGlitchDataType;
      variable RXCHARISCOMMA01_GlitchData : VitalGlitchDataType;
      variable RXCHARISCOMMA02_GlitchData : VitalGlitchDataType;
      variable RXCHARISCOMMA03_GlitchData : VitalGlitchDataType;
      variable RXCHARISCOMMA10_GlitchData : VitalGlitchDataType;
      variable RXCHARISCOMMA11_GlitchData : VitalGlitchDataType;
      variable RXCHARISCOMMA12_GlitchData : VitalGlitchDataType;
      variable RXCHARISCOMMA13_GlitchData : VitalGlitchDataType;
      variable RXCHARISK00_GlitchData : VitalGlitchDataType;
      variable RXCHARISK01_GlitchData : VitalGlitchDataType;
      variable RXCHARISK02_GlitchData : VitalGlitchDataType;
      variable RXCHARISK03_GlitchData : VitalGlitchDataType;
      variable RXCHARISK10_GlitchData : VitalGlitchDataType;
      variable RXCHARISK11_GlitchData : VitalGlitchDataType;
      variable RXCHARISK12_GlitchData : VitalGlitchDataType;
      variable RXCHARISK13_GlitchData : VitalGlitchDataType;
      variable RXCHBONDO0_GlitchData : VitalGlitchDataType;
      variable RXCHBONDO1_GlitchData : VitalGlitchDataType;
      variable RXCHBONDO2_GlitchData : VitalGlitchDataType;
      variable RXCLKCORCNT00_GlitchData : VitalGlitchDataType;
      variable RXCLKCORCNT01_GlitchData : VitalGlitchDataType;
      variable RXCLKCORCNT02_GlitchData : VitalGlitchDataType;
      variable RXCLKCORCNT10_GlitchData : VitalGlitchDataType;
      variable RXCLKCORCNT11_GlitchData : VitalGlitchDataType;
      variable RXCLKCORCNT12_GlitchData : VitalGlitchDataType;
      variable RXCOMMADET0_GlitchData : VitalGlitchDataType;
      variable RXCOMMADET1_GlitchData : VitalGlitchDataType;
      variable RXDATA00_GlitchData : VitalGlitchDataType;
      variable RXDATA010_GlitchData : VitalGlitchDataType;
      variable RXDATA011_GlitchData : VitalGlitchDataType;
      variable RXDATA012_GlitchData : VitalGlitchDataType;
      variable RXDATA013_GlitchData : VitalGlitchDataType;
      variable RXDATA014_GlitchData : VitalGlitchDataType;
      variable RXDATA015_GlitchData : VitalGlitchDataType;
      variable RXDATA016_GlitchData : VitalGlitchDataType;
      variable RXDATA017_GlitchData : VitalGlitchDataType;
      variable RXDATA018_GlitchData : VitalGlitchDataType;
      variable RXDATA019_GlitchData : VitalGlitchDataType;
      variable RXDATA01_GlitchData : VitalGlitchDataType;
      variable RXDATA020_GlitchData : VitalGlitchDataType;
      variable RXDATA021_GlitchData : VitalGlitchDataType;
      variable RXDATA022_GlitchData : VitalGlitchDataType;
      variable RXDATA023_GlitchData : VitalGlitchDataType;
      variable RXDATA024_GlitchData : VitalGlitchDataType;
      variable RXDATA025_GlitchData : VitalGlitchDataType;
      variable RXDATA026_GlitchData : VitalGlitchDataType;
      variable RXDATA027_GlitchData : VitalGlitchDataType;
      variable RXDATA028_GlitchData : VitalGlitchDataType;
      variable RXDATA029_GlitchData : VitalGlitchDataType;
      variable RXDATA02_GlitchData : VitalGlitchDataType;
      variable RXDATA030_GlitchData : VitalGlitchDataType;
      variable RXDATA031_GlitchData : VitalGlitchDataType;
      variable RXDATA03_GlitchData : VitalGlitchDataType;
      variable RXDATA04_GlitchData : VitalGlitchDataType;
      variable RXDATA05_GlitchData : VitalGlitchDataType;
      variable RXDATA06_GlitchData : VitalGlitchDataType;
      variable RXDATA07_GlitchData : VitalGlitchDataType;
      variable RXDATA08_GlitchData : VitalGlitchDataType;
      variable RXDATA09_GlitchData : VitalGlitchDataType;
      variable RXDATA10_GlitchData : VitalGlitchDataType;
      variable RXDATA110_GlitchData : VitalGlitchDataType;
      variable RXDATA111_GlitchData : VitalGlitchDataType;
      variable RXDATA112_GlitchData : VitalGlitchDataType;
      variable RXDATA113_GlitchData : VitalGlitchDataType;
      variable RXDATA114_GlitchData : VitalGlitchDataType;
      variable RXDATA115_GlitchData : VitalGlitchDataType;
      variable RXDATA116_GlitchData : VitalGlitchDataType;
      variable RXDATA117_GlitchData : VitalGlitchDataType;
      variable RXDATA118_GlitchData : VitalGlitchDataType;
      variable RXDATA119_GlitchData : VitalGlitchDataType;
      variable RXDATA11_GlitchData : VitalGlitchDataType;
      variable RXDATA120_GlitchData : VitalGlitchDataType;
      variable RXDATA121_GlitchData : VitalGlitchDataType;
      variable RXDATA122_GlitchData : VitalGlitchDataType;
      variable RXDATA123_GlitchData : VitalGlitchDataType;
      variable RXDATA124_GlitchData : VitalGlitchDataType;
      variable RXDATA125_GlitchData : VitalGlitchDataType;
      variable RXDATA126_GlitchData : VitalGlitchDataType;
      variable RXDATA127_GlitchData : VitalGlitchDataType;
      variable RXDATA128_GlitchData : VitalGlitchDataType;
      variable RXDATA129_GlitchData : VitalGlitchDataType;
      variable RXDATA12_GlitchData : VitalGlitchDataType;
      variable RXDATA130_GlitchData : VitalGlitchDataType;
      variable RXDATA131_GlitchData : VitalGlitchDataType;
      variable RXDATA13_GlitchData : VitalGlitchDataType;
      variable RXDATA14_GlitchData : VitalGlitchDataType;
      variable RXDATA15_GlitchData : VitalGlitchDataType;
      variable RXDATA16_GlitchData : VitalGlitchDataType;
      variable RXDATA17_GlitchData : VitalGlitchDataType;
      variable RXDATA18_GlitchData : VitalGlitchDataType;
      variable RXDATA19_GlitchData : VitalGlitchDataType;
      variable RXDISPERR00_GlitchData : VitalGlitchDataType;
      variable RXDISPERR01_GlitchData : VitalGlitchDataType;
      variable RXDISPERR02_GlitchData : VitalGlitchDataType;
      variable RXDISPERR03_GlitchData : VitalGlitchDataType;
      variable RXDISPERR10_GlitchData : VitalGlitchDataType;
      variable RXDISPERR11_GlitchData : VitalGlitchDataType;
      variable RXDISPERR12_GlitchData : VitalGlitchDataType;
      variable RXDISPERR13_GlitchData : VitalGlitchDataType;
      variable RXLOSSOFSYNC00_GlitchData : VitalGlitchDataType;
      variable RXLOSSOFSYNC01_GlitchData : VitalGlitchDataType;
      variable RXLOSSOFSYNC10_GlitchData : VitalGlitchDataType;
      variable RXLOSSOFSYNC11_GlitchData : VitalGlitchDataType;
      variable RXNOTINTABLE00_GlitchData : VitalGlitchDataType;
      variable RXNOTINTABLE01_GlitchData : VitalGlitchDataType;
      variable RXNOTINTABLE02_GlitchData : VitalGlitchDataType;
      variable RXNOTINTABLE03_GlitchData : VitalGlitchDataType;
      variable RXNOTINTABLE10_GlitchData : VitalGlitchDataType;
      variable RXNOTINTABLE11_GlitchData : VitalGlitchDataType;
      variable RXNOTINTABLE12_GlitchData : VitalGlitchDataType;
      variable RXNOTINTABLE13_GlitchData : VitalGlitchDataType;
      variable RXPRBSERR0_GlitchData : VitalGlitchDataType;
      variable RXPRBSERR1_GlitchData : VitalGlitchDataType;
      variable RXRUNDISP00_GlitchData : VitalGlitchDataType;
      variable RXRUNDISP01_GlitchData : VitalGlitchDataType;
      variable RXRUNDISP02_GlitchData : VitalGlitchDataType;
      variable RXRUNDISP03_GlitchData : VitalGlitchDataType;
      variable RXRUNDISP10_GlitchData : VitalGlitchDataType;
      variable RXRUNDISP11_GlitchData : VitalGlitchDataType;
      variable RXRUNDISP12_GlitchData : VitalGlitchDataType;
      variable RXRUNDISP13_GlitchData : VitalGlitchDataType;
      variable RXSTATUS00_GlitchData : VitalGlitchDataType;
      variable RXSTATUS01_GlitchData : VitalGlitchDataType;
      variable RXSTATUS02_GlitchData : VitalGlitchDataType;
      variable RXSTATUS10_GlitchData : VitalGlitchDataType;
      variable RXSTATUS11_GlitchData : VitalGlitchDataType;
      variable RXSTATUS12_GlitchData : VitalGlitchDataType;
      variable RXVALID0_GlitchData : VitalGlitchDataType;
      variable RXVALID1_GlitchData : VitalGlitchDataType;
      variable TXBUFSTATUS00_GlitchData : VitalGlitchDataType;
      variable TXBUFSTATUS01_GlitchData : VitalGlitchDataType;
      variable TXBUFSTATUS10_GlitchData : VitalGlitchDataType;
      variable TXBUFSTATUS11_GlitchData : VitalGlitchDataType;
      variable TXKERR00_GlitchData : VitalGlitchDataType;
      variable TXKERR01_GlitchData : VitalGlitchDataType;
      variable TXKERR02_GlitchData : VitalGlitchDataType;
      variable TXKERR03_GlitchData : VitalGlitchDataType;
      variable TXKERR10_GlitchData : VitalGlitchDataType;
      variable TXKERR11_GlitchData : VitalGlitchDataType;
      variable TXKERR12_GlitchData : VitalGlitchDataType;
      variable TXKERR13_GlitchData : VitalGlitchDataType;
      variable TXRUNDISP00_GlitchData : VitalGlitchDataType;
      variable TXRUNDISP01_GlitchData : VitalGlitchDataType;
      variable TXRUNDISP02_GlitchData : VitalGlitchDataType;
      variable TXRUNDISP03_GlitchData : VitalGlitchDataType;
      variable TXRUNDISP10_GlitchData : VitalGlitchDataType;
      variable TXRUNDISP11_GlitchData : VitalGlitchDataType;
      variable TXRUNDISP12_GlitchData : VitalGlitchDataType;
      variable TXRUNDISP13_GlitchData : VitalGlitchDataType;
      variable Pviol_CLK00 : STD_ULOGIC := '0';
      variable Pviol_CLK01 : STD_ULOGIC := '0';
      variable Pviol_CLK10 : STD_ULOGIC := '0';
      variable Pviol_CLK11 : STD_ULOGIC := '0';
      variable Pviol_CLKINEAST0 : STD_ULOGIC := '0';
      variable Pviol_CLKINEAST1 : STD_ULOGIC := '0';
      variable Pviol_CLKINWEST0 : STD_ULOGIC := '0';
      variable Pviol_CLKINWEST1 : STD_ULOGIC := '0';
      variable Pviol_DCLK : STD_ULOGIC := '0';
      variable Pviol_GCLK00 : STD_ULOGIC := '0';
      variable Pviol_GCLK01 : STD_ULOGIC := '0';
      variable Pviol_GCLK10 : STD_ULOGIC := '0';
      variable Pviol_GCLK11 : STD_ULOGIC := '0';
      variable Pviol_PLLCLK00 : STD_ULOGIC := '0';
      variable Pviol_PLLCLK01 : STD_ULOGIC := '0';
      variable Pviol_PLLCLK10 : STD_ULOGIC := '0';
      variable Pviol_PLLCLK11 : STD_ULOGIC := '0';
      variable Pviol_RXUSRCLK0 : STD_ULOGIC := '0';
      variable Pviol_RXUSRCLK1 : STD_ULOGIC := '0';
      variable Pviol_RXUSRCLK20 : STD_ULOGIC := '0';
      variable Pviol_RXUSRCLK21 : STD_ULOGIC := '0';
      variable Pviol_TSTCLK0 : STD_ULOGIC := '0';
      variable Pviol_TSTCLK1 : STD_ULOGIC := '0';
      variable Pviol_TXUSRCLK0 : STD_ULOGIC := '0';
      variable Pviol_TXUSRCLK1 : STD_ULOGIC := '0';
      variable Pviol_TXUSRCLK20 : STD_ULOGIC := '0';
      variable Pviol_TXUSRCLK21 : STD_ULOGIC := '0';
      variable PInfo_CLK00 : VitalPeriodDataType := VitalPeriodDataInit;
      variable PInfo_CLK01 : VitalPeriodDataType := VitalPeriodDataInit;
      variable PInfo_CLK10 : VitalPeriodDataType := VitalPeriodDataInit;
      variable PInfo_CLK11 : VitalPeriodDataType := VitalPeriodDataInit;
      variable PInfo_CLKINEAST0 : VitalPeriodDataType := VitalPeriodDataInit;
      variable PInfo_CLKINEAST1 : VitalPeriodDataType := VitalPeriodDataInit;
      variable PInfo_CLKINWEST0 : VitalPeriodDataType := VitalPeriodDataInit;
      variable PInfo_CLKINWEST1 : VitalPeriodDataType := VitalPeriodDataInit;
      variable PInfo_DCLK : VitalPeriodDataType := VitalPeriodDataInit;
      variable PInfo_GCLK00 : VitalPeriodDataType := VitalPeriodDataInit;
      variable PInfo_GCLK01 : VitalPeriodDataType := VitalPeriodDataInit;
      variable PInfo_GCLK10 : VitalPeriodDataType := VitalPeriodDataInit;
      variable PInfo_GCLK11 : VitalPeriodDataType := VitalPeriodDataInit;
      variable PInfo_PLLCLK00 : VitalPeriodDataType := VitalPeriodDataInit;
      variable PInfo_PLLCLK01 : VitalPeriodDataType := VitalPeriodDataInit;
      variable PInfo_PLLCLK10 : VitalPeriodDataType := VitalPeriodDataInit;
      variable PInfo_PLLCLK11 : VitalPeriodDataType := VitalPeriodDataInit;
      variable PInfo_RXUSRCLK0 : VitalPeriodDataType := VitalPeriodDataInit;
      variable PInfo_RXUSRCLK1 : VitalPeriodDataType := VitalPeriodDataInit;
      variable PInfo_RXUSRCLK20 : VitalPeriodDataType := VitalPeriodDataInit;
      variable PInfo_RXUSRCLK21 : VitalPeriodDataType := VitalPeriodDataInit;
      variable PInfo_TSTCLK0 : VitalPeriodDataType := VitalPeriodDataInit;
      variable PInfo_TSTCLK1 : VitalPeriodDataType := VitalPeriodDataInit;
      variable PInfo_TXUSRCLK0 : VitalPeriodDataType := VitalPeriodDataInit;
      variable PInfo_TXUSRCLK1 : VitalPeriodDataType := VitalPeriodDataInit;
      variable PInfo_TXUSRCLK20 : VitalPeriodDataType := VitalPeriodDataInit;
      variable PInfo_TXUSRCLK21 : VitalPeriodDataType := VitalPeriodDataInit;

      begin

      if (TimingChecksOn) then
        VitalSetupHoldCheck
        (
          Violation => Tviol_DADDR_DCLK_posedge(0),
          TimingData => Tmkr_DADDR_DCLK_posedge(0),
          TestSignal => DADDR_DCLK_dly(0),
          TestSignalName => "DADDR(0)",
          TestDelay => tisd_DADDR_DCLK(0),
          RefSignal => DCLK_dly,
          RefSignalName => "DCLK",
          RefDelay => ticd_DCLK,
          SetupHigh => tsetup_DADDR_DCLK_posedge_posedge(0),
          HoldHigh => thold_DADDR_DCLK_posedge_posedge(0),
          SetupLow => tsetup_DADDR_DCLK_negedge_posedge(0),
          HoldLow => thold_DADDR_DCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
          (
            Violation => Tviol_DADDR_DCLK_posedge(1),
            TimingData => Tmkr_DADDR_DCLK_posedge(1),
            TestSignal => DADDR_DCLK_dly(1),
            TestSignalName => "DADDR(1)",
            TestDelay => tisd_DADDR_DCLK(1),
            RefSignal => DCLK_dly,
            RefSignalName => "DCLK",
            RefDelay => ticd_DCLK,
            SetupHigh => tsetup_DADDR_DCLK_posedge_posedge(1),
            HoldHigh => thold_DADDR_DCLK_posedge_posedge(1),
            SetupLow => tsetup_DADDR_DCLK_negedge_posedge(1),
            HoldLow => thold_DADDR_DCLK_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DADDR_DCLK_posedge(2),
            TimingData => Tmkr_DADDR_DCLK_posedge(2),
            TestSignal => DADDR_DCLK_dly(2),
            TestSignalName => "DADDR(2)",
            TestDelay => tisd_DADDR_DCLK(2),
            RefSignal => DCLK_dly,
            RefSignalName => "DCLK",
            RefDelay => ticd_DCLK,
            SetupHigh => tsetup_DADDR_DCLK_posedge_posedge(2),
            HoldHigh => thold_DADDR_DCLK_posedge_posedge(2),
            SetupLow => tsetup_DADDR_DCLK_negedge_posedge(2),
            HoldLow => thold_DADDR_DCLK_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DADDR_DCLK_posedge(3),
            TimingData => Tmkr_DADDR_DCLK_posedge(3),
            TestSignal => DADDR_DCLK_dly(3),
            TestSignalName => "DADDR(3)",
            TestDelay => tisd_DADDR_DCLK(3),
            RefSignal => DCLK_dly,
            RefSignalName => "DCLK",
            RefDelay => ticd_DCLK,
            SetupHigh => tsetup_DADDR_DCLK_posedge_posedge(3),
            HoldHigh => thold_DADDR_DCLK_posedge_posedge(3),
            SetupLow => tsetup_DADDR_DCLK_negedge_posedge(3),
            HoldLow => thold_DADDR_DCLK_negedge_posedge(3),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DADDR_DCLK_posedge(4),
            TimingData => Tmkr_DADDR_DCLK_posedge(4),
            TestSignal => DADDR_DCLK_dly(4),
            TestSignalName => "DADDR(4)",
            TestDelay => tisd_DADDR_DCLK(4),
            RefSignal => DCLK_dly,
            RefSignalName => "DCLK",
            RefDelay => ticd_DCLK,
            SetupHigh => tsetup_DADDR_DCLK_posedge_posedge(4),
            HoldHigh => thold_DADDR_DCLK_posedge_posedge(4),
            SetupLow => tsetup_DADDR_DCLK_negedge_posedge(4),
            HoldLow => thold_DADDR_DCLK_negedge_posedge(4),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DADDR_DCLK_posedge(5),
            TimingData => Tmkr_DADDR_DCLK_posedge(5),
            TestSignal => DADDR_DCLK_dly(5),
            TestSignalName => "DADDR(5)",
            TestDelay => tisd_DADDR_DCLK(5),
            RefSignal => DCLK_dly,
            RefSignalName => "DCLK",
            RefDelay => ticd_DCLK,
            SetupHigh => tsetup_DADDR_DCLK_posedge_posedge(5),
            HoldHigh => thold_DADDR_DCLK_posedge_posedge(5),
            SetupLow => tsetup_DADDR_DCLK_negedge_posedge(5),
            HoldLow => thold_DADDR_DCLK_negedge_posedge(5),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DADDR_DCLK_posedge(6),
            TimingData => Tmkr_DADDR_DCLK_posedge(6),
            TestSignal => DADDR_DCLK_dly(6),
            TestSignalName => "DADDR(6)",
            TestDelay => tisd_DADDR_DCLK(6),
            RefSignal => DCLK_dly,
            RefSignalName => "DCLK",
            RefDelay => ticd_DCLK,
            SetupHigh => tsetup_DADDR_DCLK_posedge_posedge(6),
            HoldHigh => thold_DADDR_DCLK_posedge_posedge(6),
            SetupLow => tsetup_DADDR_DCLK_negedge_posedge(6),
            HoldLow => thold_DADDR_DCLK_negedge_posedge(6),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DADDR_DCLK_posedge(7),
            TimingData => Tmkr_DADDR_DCLK_posedge(7),
            TestSignal => DADDR_DCLK_dly(7),
            TestSignalName => "DADDR(7)",
            TestDelay => tisd_DADDR_DCLK(7),
            RefSignal => DCLK_dly,
            RefSignalName => "DCLK",
            RefDelay => ticd_DCLK,
            SetupHigh => tsetup_DADDR_DCLK_posedge_posedge(7),
            HoldHigh => thold_DADDR_DCLK_posedge_posedge(7),
            SetupLow => tsetup_DADDR_DCLK_negedge_posedge(7),
            HoldLow => thold_DADDR_DCLK_negedge_posedge(7),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DEN_DCLK_posedge,
            TimingData => Tmkr_DEN_DCLK_posedge,
            TestSignal => DEN_DCLK_dly,
            TestSignalName => "DEN",
            TestDelay => tisd_DEN_DCLK,
            RefSignal => DCLK_dly,
            RefSignalName => "DCLK",
            RefDelay => ticd_DCLK,
            SetupHigh => tsetup_DEN_DCLK_posedge_posedge,
            HoldHigh => thold_DEN_DCLK_posedge_posedge,
            SetupLow => tsetup_DEN_DCLK_negedge_posedge,
            HoldLow => thold_DEN_DCLK_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DI_DCLK_posedge(0),
            TimingData => Tmkr_DI_DCLK_posedge(0),
            TestSignal => DI_DCLK_dly(0),
            TestSignalName => "DI(0)",
            TestDelay => tisd_DI_DCLK(0),
            RefSignal => DCLK_dly,
            RefSignalName => "DCLK",
            RefDelay => ticd_DCLK,
            SetupHigh => tsetup_DI_DCLK_posedge_posedge(0),
            HoldHigh => thold_DI_DCLK_posedge_posedge(0),
            SetupLow => tsetup_DI_DCLK_negedge_posedge(0),
            HoldLow => thold_DI_DCLK_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DI_DCLK_posedge(1),
            TimingData => Tmkr_DI_DCLK_posedge(1),
            TestSignal => DI_DCLK_dly(1),
            TestSignalName => "DI(1)",
            TestDelay => tisd_DI_DCLK(1),
            RefSignal => DCLK_dly,
            RefSignalName => "DCLK",
            RefDelay => ticd_DCLK,
            SetupHigh => tsetup_DI_DCLK_posedge_posedge(1),
            HoldHigh => thold_DI_DCLK_posedge_posedge(1),
            SetupLow => tsetup_DI_DCLK_negedge_posedge(1),
            HoldLow => thold_DI_DCLK_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DI_DCLK_posedge(10),
            TimingData => Tmkr_DI_DCLK_posedge(10),
            TestSignal => DI_DCLK_dly(10),
            TestSignalName => "DI(10)",
            TestDelay => tisd_DI_DCLK(10),
            RefSignal => DCLK_dly,
            RefSignalName => "DCLK",
            RefDelay => ticd_DCLK,
            SetupHigh => tsetup_DI_DCLK_posedge_posedge(10),
            HoldHigh => thold_DI_DCLK_posedge_posedge(10),
            SetupLow => tsetup_DI_DCLK_negedge_posedge(10),
            HoldLow => thold_DI_DCLK_negedge_posedge(10),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DI_DCLK_posedge(11),
            TimingData => Tmkr_DI_DCLK_posedge(11),
            TestSignal => DI_DCLK_dly(11),
            TestSignalName => "DI(11)",
            TestDelay => tisd_DI_DCLK(11),
            RefSignal => DCLK_dly,
            RefSignalName => "DCLK",
            RefDelay => ticd_DCLK,
            SetupHigh => tsetup_DI_DCLK_posedge_posedge(11),
            HoldHigh => thold_DI_DCLK_posedge_posedge(11),
            SetupLow => tsetup_DI_DCLK_negedge_posedge(11),
            HoldLow => thold_DI_DCLK_negedge_posedge(11),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DI_DCLK_posedge(12),
            TimingData => Tmkr_DI_DCLK_posedge(12),
            TestSignal => DI_DCLK_dly(12),
            TestSignalName => "DI(12)",
            TestDelay => tisd_DI_DCLK(12),
            RefSignal => DCLK_dly,
            RefSignalName => "DCLK",
            RefDelay => ticd_DCLK,
            SetupHigh => tsetup_DI_DCLK_posedge_posedge(12),
            HoldHigh => thold_DI_DCLK_posedge_posedge(12),
            SetupLow => tsetup_DI_DCLK_negedge_posedge(12),
            HoldLow => thold_DI_DCLK_negedge_posedge(12),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DI_DCLK_posedge(13),
            TimingData => Tmkr_DI_DCLK_posedge(13),
            TestSignal => DI_DCLK_dly(13),
            TestSignalName => "DI(13)",
            TestDelay => tisd_DI_DCLK(13),
            RefSignal => DCLK_dly,
            RefSignalName => "DCLK",
            RefDelay => ticd_DCLK,
            SetupHigh => tsetup_DI_DCLK_posedge_posedge(13),
            HoldHigh => thold_DI_DCLK_posedge_posedge(13),
            SetupLow => tsetup_DI_DCLK_negedge_posedge(13),
            HoldLow => thold_DI_DCLK_negedge_posedge(13),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DI_DCLK_posedge(14),
            TimingData => Tmkr_DI_DCLK_posedge(14),
            TestSignal => DI_DCLK_dly(14),
            TestSignalName => "DI(14)",
            TestDelay => tisd_DI_DCLK(14),
            RefSignal => DCLK_dly,
            RefSignalName => "DCLK",
            RefDelay => ticd_DCLK,
            SetupHigh => tsetup_DI_DCLK_posedge_posedge(14),
            HoldHigh => thold_DI_DCLK_posedge_posedge(14),
            SetupLow => tsetup_DI_DCLK_negedge_posedge(14),
            HoldLow => thold_DI_DCLK_negedge_posedge(14),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DI_DCLK_posedge(15),
            TimingData => Tmkr_DI_DCLK_posedge(15),
            TestSignal => DI_DCLK_dly(15),
            TestSignalName => "DI(15)",
            TestDelay => tisd_DI_DCLK(15),
            RefSignal => DCLK_dly,
            RefSignalName => "DCLK",
            RefDelay => ticd_DCLK,
            SetupHigh => tsetup_DI_DCLK_posedge_posedge(15),
            HoldHigh => thold_DI_DCLK_posedge_posedge(15),
            SetupLow => tsetup_DI_DCLK_negedge_posedge(15),
            HoldLow => thold_DI_DCLK_negedge_posedge(15),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DI_DCLK_posedge(2),
            TimingData => Tmkr_DI_DCLK_posedge(2),
            TestSignal => DI_DCLK_dly(2),
            TestSignalName => "DI(2)",
            TestDelay => tisd_DI_DCLK(2),
            RefSignal => DCLK_dly,
            RefSignalName => "DCLK",
            RefDelay => ticd_DCLK,
            SetupHigh => tsetup_DI_DCLK_posedge_posedge(2),
            HoldHigh => thold_DI_DCLK_posedge_posedge(2),
            SetupLow => tsetup_DI_DCLK_negedge_posedge(2),
            HoldLow => thold_DI_DCLK_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DI_DCLK_posedge(3),
            TimingData => Tmkr_DI_DCLK_posedge(3),
            TestSignal => DI_DCLK_dly(3),
            TestSignalName => "DI(3)",
            TestDelay => tisd_DI_DCLK(3),
            RefSignal => DCLK_dly,
            RefSignalName => "DCLK",
            RefDelay => ticd_DCLK,
            SetupHigh => tsetup_DI_DCLK_posedge_posedge(3),
            HoldHigh => thold_DI_DCLK_posedge_posedge(3),
            SetupLow => tsetup_DI_DCLK_negedge_posedge(3),
            HoldLow => thold_DI_DCLK_negedge_posedge(3),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DI_DCLK_posedge(4),
            TimingData => Tmkr_DI_DCLK_posedge(4),
            TestSignal => DI_DCLK_dly(4),
            TestSignalName => "DI(4)",
            TestDelay => tisd_DI_DCLK(4),
            RefSignal => DCLK_dly,
            RefSignalName => "DCLK",
            RefDelay => ticd_DCLK,
            SetupHigh => tsetup_DI_DCLK_posedge_posedge(4),
            HoldHigh => thold_DI_DCLK_posedge_posedge(4),
            SetupLow => tsetup_DI_DCLK_negedge_posedge(4),
            HoldLow => thold_DI_DCLK_negedge_posedge(4),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DI_DCLK_posedge(5),
            TimingData => Tmkr_DI_DCLK_posedge(5),
            TestSignal => DI_DCLK_dly(5),
            TestSignalName => "DI(5)",
            TestDelay => tisd_DI_DCLK(5),
            RefSignal => DCLK_dly,
            RefSignalName => "DCLK",
            RefDelay => ticd_DCLK,
            SetupHigh => tsetup_DI_DCLK_posedge_posedge(5),
            HoldHigh => thold_DI_DCLK_posedge_posedge(5),
            SetupLow => tsetup_DI_DCLK_negedge_posedge(5),
            HoldLow => thold_DI_DCLK_negedge_posedge(5),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DI_DCLK_posedge(6),
            TimingData => Tmkr_DI_DCLK_posedge(6),
            TestSignal => DI_DCLK_dly(6),
            TestSignalName => "DI(6)",
            TestDelay => tisd_DI_DCLK(6),
            RefSignal => DCLK_dly,
            RefSignalName => "DCLK",
            RefDelay => ticd_DCLK,
            SetupHigh => tsetup_DI_DCLK_posedge_posedge(6),
            HoldHigh => thold_DI_DCLK_posedge_posedge(6),
            SetupLow => tsetup_DI_DCLK_negedge_posedge(6),
            HoldLow => thold_DI_DCLK_negedge_posedge(6),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DI_DCLK_posedge(7),
            TimingData => Tmkr_DI_DCLK_posedge(7),
            TestSignal => DI_DCLK_dly(7),
            TestSignalName => "DI(7)",
            TestDelay => tisd_DI_DCLK(7),
            RefSignal => DCLK_dly,
            RefSignalName => "DCLK",
            RefDelay => ticd_DCLK,
            SetupHigh => tsetup_DI_DCLK_posedge_posedge(7),
            HoldHigh => thold_DI_DCLK_posedge_posedge(7),
            SetupLow => tsetup_DI_DCLK_negedge_posedge(7),
            HoldLow => thold_DI_DCLK_negedge_posedge(7),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DI_DCLK_posedge(8),
            TimingData => Tmkr_DI_DCLK_posedge(8),
            TestSignal => DI_DCLK_dly(8),
            TestSignalName => "DI(8)",
            TestDelay => tisd_DI_DCLK(8),
            RefSignal => DCLK_dly,
            RefSignalName => "DCLK",
            RefDelay => ticd_DCLK,
            SetupHigh => tsetup_DI_DCLK_posedge_posedge(8),
            HoldHigh => thold_DI_DCLK_posedge_posedge(8),
            SetupLow => tsetup_DI_DCLK_negedge_posedge(8),
            HoldLow => thold_DI_DCLK_negedge_posedge(8),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DI_DCLK_posedge(9),
            TimingData => Tmkr_DI_DCLK_posedge(9),
            TestSignal => DI_DCLK_dly(9),
            TestSignalName => "DI(9)",
            TestDelay => tisd_DI_DCLK(9),
            RefSignal => DCLK_dly,
            RefSignalName => "DCLK",
            RefDelay => ticd_DCLK,
            SetupHigh => tsetup_DI_DCLK_posedge_posedge(9),
            HoldHigh => thold_DI_DCLK_posedge_posedge(9),
            SetupLow => tsetup_DI_DCLK_negedge_posedge(9),
            HoldLow => thold_DI_DCLK_negedge_posedge(9),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DWE_DCLK_posedge,
            TimingData => Tmkr_DWE_DCLK_posedge,
            TestSignal => DWE_DCLK_dly,
            TestSignalName => "DWE",
            TestDelay => tisd_DWE_DCLK,
            RefSignal => DCLK_dly,
            RefSignalName => "DCLK",
            RefDelay => ticd_DCLK,
            SetupHigh => tsetup_DWE_DCLK_posedge_posedge,
            HoldHigh => thold_DWE_DCLK_posedge_posedge,
            SetupLow => tsetup_DWE_DCLK_negedge_posedge,
            HoldLow => thold_DWE_DCLK_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_PRBSCNTRESET0_RXUSRCLK20_posedge,
            TimingData => Tmkr_PRBSCNTRESET0_RXUSRCLK20_posedge,
            TestSignal => PRBSCNTRESET0_RXUSRCLK20_dly,
            TestSignalName => "PRBSCNTRESET0",
            TestDelay => tisd_PRBSCNTRESET0_RXUSRCLK20,
            RefSignal => RXUSRCLK20_dly,
            RefSignalName => "RXUSRCLK20",
            RefDelay => ticd_RXUSRCLK20,
            SetupHigh => tsetup_PRBSCNTRESET0_RXUSRCLK20_posedge_posedge,
            HoldHigh => thold_PRBSCNTRESET0_RXUSRCLK20_posedge_posedge,
            SetupLow => tsetup_PRBSCNTRESET0_RXUSRCLK20_negedge_posedge,
            HoldLow => thold_PRBSCNTRESET0_RXUSRCLK20_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_PRBSCNTRESET1_RXUSRCLK21_posedge,
            TimingData => Tmkr_PRBSCNTRESET1_RXUSRCLK21_posedge,
            TestSignal => PRBSCNTRESET1_RXUSRCLK21_dly,
            TestSignalName => "PRBSCNTRESET1",
            TestDelay => tisd_PRBSCNTRESET1_RXUSRCLK21,
            RefSignal => RXUSRCLK21_dly,
            RefSignalName => "RXUSRCLK21",
            RefDelay => ticd_RXUSRCLK21,
            SetupHigh => tsetup_PRBSCNTRESET1_RXUSRCLK21_posedge_posedge,
            HoldHigh => thold_PRBSCNTRESET1_RXUSRCLK21_posedge_posedge,
            SetupLow => tsetup_PRBSCNTRESET1_RXUSRCLK21_negedge_posedge,
            HoldLow => thold_PRBSCNTRESET1_RXUSRCLK21_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXCHBONDI_RXUSRCLK0_posedge(0),
            TimingData => Tmkr_RXCHBONDI_RXUSRCLK0_posedge(0),
            TestSignal => RXCHBONDI_RXUSRCLK0_dly(0),
            TestSignalName => "RXCHBONDI(0)",
            TestDelay => tisd_RXCHBONDI_RXUSRCLK0(0),
            RefSignal => RXUSRCLK0_dly,
            RefSignalName => "RXUSRCLK0",
            RefDelay => ticd_RXUSRCLK0,
            SetupHigh => tsetup_RXCHBONDI_RXUSRCLK0_posedge_posedge(0),
            HoldHigh => thold_RXCHBONDI_RXUSRCLK0_posedge_posedge(0),
            SetupLow => tsetup_RXCHBONDI_RXUSRCLK0_negedge_posedge(0),
            HoldLow => thold_RXCHBONDI_RXUSRCLK0_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXCHBONDI_RXUSRCLK0_posedge(1),
            TimingData => Tmkr_RXCHBONDI_RXUSRCLK0_posedge(1),
            TestSignal => RXCHBONDI_RXUSRCLK0_dly(1),
            TestSignalName => "RXCHBONDI(1)",
            TestDelay => tisd_RXCHBONDI_RXUSRCLK0(1),
            RefSignal => RXUSRCLK0_dly,
            RefSignalName => "RXUSRCLK0",
            RefDelay => ticd_RXUSRCLK0,
            SetupHigh => tsetup_RXCHBONDI_RXUSRCLK0_posedge_posedge(1),
            HoldHigh => thold_RXCHBONDI_RXUSRCLK0_posedge_posedge(1),
            SetupLow => tsetup_RXCHBONDI_RXUSRCLK0_negedge_posedge(1),
            HoldLow => thold_RXCHBONDI_RXUSRCLK0_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXCHBONDI_RXUSRCLK0_posedge(2),
            TimingData => Tmkr_RXCHBONDI_RXUSRCLK0_posedge(2),
            TestSignal => RXCHBONDI_RXUSRCLK0_dly(2),
            TestSignalName => "RXCHBONDI(2)",
            TestDelay => tisd_RXCHBONDI_RXUSRCLK0(2),
            RefSignal => RXUSRCLK0_dly,
            RefSignalName => "RXUSRCLK0",
            RefDelay => ticd_RXUSRCLK0,
            SetupHigh => tsetup_RXCHBONDI_RXUSRCLK0_posedge_posedge(2),
            HoldHigh => thold_RXCHBONDI_RXUSRCLK0_posedge_posedge(2),
            SetupLow => tsetup_RXCHBONDI_RXUSRCLK0_negedge_posedge(2),
            HoldLow => thold_RXCHBONDI_RXUSRCLK0_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXCHBONDI_RXUSRCLK1_posedge(0),
            TimingData => Tmkr_RXCHBONDI_RXUSRCLK1_posedge(0),
            TestSignal => RXCHBONDI_RXUSRCLK1_dly(0),
            TestSignalName => "RXCHBONDI(0)",
            TestDelay => tisd_RXCHBONDI_RXUSRCLK1(0),
            RefSignal => RXUSRCLK1_dly,
            RefSignalName => "RXUSRCLK1",
            RefDelay => ticd_RXUSRCLK1,
            SetupHigh => tsetup_RXCHBONDI_RXUSRCLK1_posedge_posedge(0),
            HoldHigh => thold_RXCHBONDI_RXUSRCLK1_posedge_posedge(0),
            SetupLow => tsetup_RXCHBONDI_RXUSRCLK1_negedge_posedge(0),
            HoldLow => thold_RXCHBONDI_RXUSRCLK1_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXCHBONDI_RXUSRCLK1_posedge(1),
            TimingData => Tmkr_RXCHBONDI_RXUSRCLK1_posedge(1),
            TestSignal => RXCHBONDI_RXUSRCLK1_dly(1),
            TestSignalName => "RXCHBONDI(1)",
            TestDelay => tisd_RXCHBONDI_RXUSRCLK1(1),
            RefSignal => RXUSRCLK1_dly,
            RefSignalName => "RXUSRCLK1",
            RefDelay => ticd_RXUSRCLK1,
            SetupHigh => tsetup_RXCHBONDI_RXUSRCLK1_posedge_posedge(1),
            HoldHigh => thold_RXCHBONDI_RXUSRCLK1_posedge_posedge(1),
            SetupLow => tsetup_RXCHBONDI_RXUSRCLK1_negedge_posedge(1),
            HoldLow => thold_RXCHBONDI_RXUSRCLK1_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXCHBONDI_RXUSRCLK1_posedge(2),
            TimingData => Tmkr_RXCHBONDI_RXUSRCLK1_posedge(2),
            TestSignal => RXCHBONDI_RXUSRCLK1_dly(2),
            TestSignalName => "RXCHBONDI(2)",
            TestDelay => tisd_RXCHBONDI_RXUSRCLK1(2),
            RefSignal => RXUSRCLK1_dly,
            RefSignalName => "RXUSRCLK1",
            RefDelay => ticd_RXUSRCLK1,
            SetupHigh => tsetup_RXCHBONDI_RXUSRCLK1_posedge_posedge(2),
            HoldHigh => thold_RXCHBONDI_RXUSRCLK1_posedge_posedge(2),
            SetupLow => tsetup_RXCHBONDI_RXUSRCLK1_negedge_posedge(2),
            HoldLow => thold_RXCHBONDI_RXUSRCLK1_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXCHBONDMASTER0_RXUSRCLK20_posedge,
            TimingData => Tmkr_RXCHBONDMASTER0_RXUSRCLK20_posedge,
            TestSignal => RXCHBONDMASTER0_RXUSRCLK20_dly,
            TestSignalName => "RXCHBONDMASTER0",
            TestDelay => tisd_RXCHBONDMASTER0_RXUSRCLK20,
            RefSignal => RXUSRCLK20_dly,
            RefSignalName => "RXUSRCLK20",
            RefDelay => ticd_RXUSRCLK20,
            SetupHigh => tsetup_RXCHBONDMASTER0_RXUSRCLK20_posedge_posedge,
            HoldHigh => thold_RXCHBONDMASTER0_RXUSRCLK20_posedge_posedge,
            SetupLow => tsetup_RXCHBONDMASTER0_RXUSRCLK20_negedge_posedge,
            HoldLow => thold_RXCHBONDMASTER0_RXUSRCLK20_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXCHBONDMASTER1_RXUSRCLK21_posedge,
            TimingData => Tmkr_RXCHBONDMASTER1_RXUSRCLK21_posedge,
            TestSignal => RXCHBONDMASTER1_RXUSRCLK21_dly,
            TestSignalName => "RXCHBONDMASTER1",
            TestDelay => tisd_RXCHBONDMASTER1_RXUSRCLK21,
            RefSignal => RXUSRCLK21_dly,
            RefSignalName => "RXUSRCLK21",
            RefDelay => ticd_RXUSRCLK21,
            SetupHigh => tsetup_RXCHBONDMASTER1_RXUSRCLK21_posedge_posedge,
            HoldHigh => thold_RXCHBONDMASTER1_RXUSRCLK21_posedge_posedge,
            SetupLow => tsetup_RXCHBONDMASTER1_RXUSRCLK21_negedge_posedge,
            HoldLow => thold_RXCHBONDMASTER1_RXUSRCLK21_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXCHBONDSLAVE0_RXUSRCLK20_posedge,
            TimingData => Tmkr_RXCHBONDSLAVE0_RXUSRCLK20_posedge,
            TestSignal => RXCHBONDSLAVE0_RXUSRCLK20_dly,
            TestSignalName => "RXCHBONDSLAVE0",
            TestDelay => tisd_RXCHBONDSLAVE0_RXUSRCLK20,
            RefSignal => RXUSRCLK20_dly,
            RefSignalName => "RXUSRCLK20",
            RefDelay => ticd_RXUSRCLK20,
            SetupHigh => tsetup_RXCHBONDSLAVE0_RXUSRCLK20_posedge_posedge,
            HoldHigh => thold_RXCHBONDSLAVE0_RXUSRCLK20_posedge_posedge,
            SetupLow => tsetup_RXCHBONDSLAVE0_RXUSRCLK20_negedge_posedge,
            HoldLow => thold_RXCHBONDSLAVE0_RXUSRCLK20_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXCHBONDSLAVE1_RXUSRCLK21_posedge,
            TimingData => Tmkr_RXCHBONDSLAVE1_RXUSRCLK21_posedge,
            TestSignal => RXCHBONDSLAVE1_RXUSRCLK21_dly,
            TestSignalName => "RXCHBONDSLAVE1",
            TestDelay => tisd_RXCHBONDSLAVE1_RXUSRCLK21,
            RefSignal => RXUSRCLK21_dly,
            RefSignalName => "RXUSRCLK21",
            RefDelay => ticd_RXUSRCLK21,
            SetupHigh => tsetup_RXCHBONDSLAVE1_RXUSRCLK21_posedge_posedge,
            HoldHigh => thold_RXCHBONDSLAVE1_RXUSRCLK21_posedge_posedge,
            SetupLow => tsetup_RXCHBONDSLAVE1_RXUSRCLK21_negedge_posedge,
            HoldLow => thold_RXCHBONDSLAVE1_RXUSRCLK21_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXCOMMADETUSE0_RXUSRCLK20_posedge,
            TimingData => Tmkr_RXCOMMADETUSE0_RXUSRCLK20_posedge,
            TestSignal => RXCOMMADETUSE0_RXUSRCLK20_dly,
            TestSignalName => "RXCOMMADETUSE0",
            TestDelay => tisd_RXCOMMADETUSE0_RXUSRCLK20,
            RefSignal => RXUSRCLK20_dly,
            RefSignalName => "RXUSRCLK20",
            RefDelay => ticd_RXUSRCLK20,
            SetupHigh => tsetup_RXCOMMADETUSE0_RXUSRCLK20_posedge_posedge,
            HoldHigh => thold_RXCOMMADETUSE0_RXUSRCLK20_posedge_posedge,
            SetupLow => tsetup_RXCOMMADETUSE0_RXUSRCLK20_negedge_posedge,
            HoldLow => thold_RXCOMMADETUSE0_RXUSRCLK20_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXCOMMADETUSE1_RXUSRCLK21_posedge,
            TimingData => Tmkr_RXCOMMADETUSE1_RXUSRCLK21_posedge,
            TestSignal => RXCOMMADETUSE1_RXUSRCLK21_dly,
            TestSignalName => "RXCOMMADETUSE1",
            TestDelay => tisd_RXCOMMADETUSE1_RXUSRCLK21,
            RefSignal => RXUSRCLK21_dly,
            RefSignalName => "RXUSRCLK21",
            RefDelay => ticd_RXUSRCLK21,
            SetupHigh => tsetup_RXCOMMADETUSE1_RXUSRCLK21_posedge_posedge,
            HoldHigh => thold_RXCOMMADETUSE1_RXUSRCLK21_posedge_posedge,
            SetupLow => tsetup_RXCOMMADETUSE1_RXUSRCLK21_negedge_posedge,
            HoldLow => thold_RXCOMMADETUSE1_RXUSRCLK21_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXDEC8B10BUSE0_RXUSRCLK20_posedge,
            TimingData => Tmkr_RXDEC8B10BUSE0_RXUSRCLK20_posedge,
            TestSignal => RXDEC8B10BUSE0_RXUSRCLK20_dly,
            TestSignalName => "RXDEC8B10BUSE0",
            TestDelay => tisd_RXDEC8B10BUSE0_RXUSRCLK20,
            RefSignal => RXUSRCLK20_dly,
            RefSignalName => "RXUSRCLK20",
            RefDelay => ticd_RXUSRCLK20,
            SetupHigh => tsetup_RXDEC8B10BUSE0_RXUSRCLK20_posedge_posedge,
            HoldHigh => thold_RXDEC8B10BUSE0_RXUSRCLK20_posedge_posedge,
            SetupLow => tsetup_RXDEC8B10BUSE0_RXUSRCLK20_negedge_posedge,
            HoldLow => thold_RXDEC8B10BUSE0_RXUSRCLK20_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXDEC8B10BUSE1_RXUSRCLK21_posedge,
            TimingData => Tmkr_RXDEC8B10BUSE1_RXUSRCLK21_posedge,
            TestSignal => RXDEC8B10BUSE1_RXUSRCLK21_dly,
            TestSignalName => "RXDEC8B10BUSE1",
            TestDelay => tisd_RXDEC8B10BUSE1_RXUSRCLK21,
            RefSignal => RXUSRCLK21_dly,
            RefSignalName => "RXUSRCLK21",
            RefDelay => ticd_RXUSRCLK21,
            SetupHigh => tsetup_RXDEC8B10BUSE1_RXUSRCLK21_posedge_posedge,
            HoldHigh => thold_RXDEC8B10BUSE1_RXUSRCLK21_posedge_posedge,
            SetupLow => tsetup_RXDEC8B10BUSE1_RXUSRCLK21_negedge_posedge,
            HoldLow => thold_RXDEC8B10BUSE1_RXUSRCLK21_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXENCHANSYNC0_RXUSRCLK20_posedge,
            TimingData => Tmkr_RXENCHANSYNC0_RXUSRCLK20_posedge,
            TestSignal => RXENCHANSYNC0_RXUSRCLK20_dly,
            TestSignalName => "RXENCHANSYNC0",
            TestDelay => tisd_RXENCHANSYNC0_RXUSRCLK20,
            RefSignal => RXUSRCLK20_dly,
            RefSignalName => "RXUSRCLK20",
            RefDelay => ticd_RXUSRCLK20,
            SetupHigh => tsetup_RXENCHANSYNC0_RXUSRCLK20_posedge_posedge,
            HoldHigh => thold_RXENCHANSYNC0_RXUSRCLK20_posedge_posedge,
            SetupLow => tsetup_RXENCHANSYNC0_RXUSRCLK20_negedge_posedge,
            HoldLow => thold_RXENCHANSYNC0_RXUSRCLK20_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXENCHANSYNC1_RXUSRCLK21_posedge,
            TimingData => Tmkr_RXENCHANSYNC1_RXUSRCLK21_posedge,
            TestSignal => RXENCHANSYNC1_RXUSRCLK21_dly,
            TestSignalName => "RXENCHANSYNC1",
            TestDelay => tisd_RXENCHANSYNC1_RXUSRCLK21,
            RefSignal => RXUSRCLK21_dly,
            RefSignalName => "RXUSRCLK21",
            RefDelay => ticd_RXUSRCLK21,
            SetupHigh => tsetup_RXENCHANSYNC1_RXUSRCLK21_posedge_posedge,
            HoldHigh => thold_RXENCHANSYNC1_RXUSRCLK21_posedge_posedge,
            SetupLow => tsetup_RXENCHANSYNC1_RXUSRCLK21_negedge_posedge,
            HoldLow => thold_RXENCHANSYNC1_RXUSRCLK21_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXENMCOMMAALIGN0_RXUSRCLK20_posedge,
            TimingData => Tmkr_RXENMCOMMAALIGN0_RXUSRCLK20_posedge,
            TestSignal => RXENMCOMMAALIGN0_RXUSRCLK20_dly,
            TestSignalName => "RXENMCOMMAALIGN0",
            TestDelay => tisd_RXENMCOMMAALIGN0_RXUSRCLK20,
            RefSignal => RXUSRCLK20_dly,
            RefSignalName => "RXUSRCLK20",
            RefDelay => ticd_RXUSRCLK20,
            SetupHigh => tsetup_RXENMCOMMAALIGN0_RXUSRCLK20_posedge_posedge,
            HoldHigh => thold_RXENMCOMMAALIGN0_RXUSRCLK20_posedge_posedge,
            SetupLow => tsetup_RXENMCOMMAALIGN0_RXUSRCLK20_negedge_posedge,
            HoldLow => thold_RXENMCOMMAALIGN0_RXUSRCLK20_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXENMCOMMAALIGN1_RXUSRCLK21_posedge,
            TimingData => Tmkr_RXENMCOMMAALIGN1_RXUSRCLK21_posedge,
            TestSignal => RXENMCOMMAALIGN1_RXUSRCLK21_dly,
            TestSignalName => "RXENMCOMMAALIGN1",
            TestDelay => tisd_RXENMCOMMAALIGN1_RXUSRCLK21,
            RefSignal => RXUSRCLK21_dly,
            RefSignalName => "RXUSRCLK21",
            RefDelay => ticd_RXUSRCLK21,
            SetupHigh => tsetup_RXENMCOMMAALIGN1_RXUSRCLK21_posedge_posedge,
            HoldHigh => thold_RXENMCOMMAALIGN1_RXUSRCLK21_posedge_posedge,
            SetupLow => tsetup_RXENMCOMMAALIGN1_RXUSRCLK21_negedge_posedge,
            HoldLow => thold_RXENMCOMMAALIGN1_RXUSRCLK21_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXENPCOMMAALIGN0_RXUSRCLK20_posedge,
            TimingData => Tmkr_RXENPCOMMAALIGN0_RXUSRCLK20_posedge,
            TestSignal => RXENPCOMMAALIGN0_RXUSRCLK20_dly,
            TestSignalName => "RXENPCOMMAALIGN0",
            TestDelay => tisd_RXENPCOMMAALIGN0_RXUSRCLK20,
            RefSignal => RXUSRCLK20_dly,
            RefSignalName => "RXUSRCLK20",
            RefDelay => ticd_RXUSRCLK20,
            SetupHigh => tsetup_RXENPCOMMAALIGN0_RXUSRCLK20_posedge_posedge,
            HoldHigh => thold_RXENPCOMMAALIGN0_RXUSRCLK20_posedge_posedge,
            SetupLow => tsetup_RXENPCOMMAALIGN0_RXUSRCLK20_negedge_posedge,
            HoldLow => thold_RXENPCOMMAALIGN0_RXUSRCLK20_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXENPCOMMAALIGN1_RXUSRCLK21_posedge,
            TimingData => Tmkr_RXENPCOMMAALIGN1_RXUSRCLK21_posedge,
            TestSignal => RXENPCOMMAALIGN1_RXUSRCLK21_dly,
            TestSignalName => "RXENPCOMMAALIGN1",
            TestDelay => tisd_RXENPCOMMAALIGN1_RXUSRCLK21,
            RefSignal => RXUSRCLK21_dly,
            RefSignalName => "RXUSRCLK21",
            RefDelay => ticd_RXUSRCLK21,
            SetupHigh => tsetup_RXENPCOMMAALIGN1_RXUSRCLK21_posedge_posedge,
            HoldHigh => thold_RXENPCOMMAALIGN1_RXUSRCLK21_posedge_posedge,
            SetupLow => tsetup_RXENPCOMMAALIGN1_RXUSRCLK21_negedge_posedge,
            HoldLow => thold_RXENPCOMMAALIGN1_RXUSRCLK21_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXENPRBSTST0_RXUSRCLK20_posedge(0),
            TimingData => Tmkr_RXENPRBSTST0_RXUSRCLK20_posedge(0),
            TestSignal => RXENPRBSTST0_RXUSRCLK20_dly(0),
            TestSignalName => "RXENPRBSTST0(0)",
            TestDelay => tisd_RXENPRBSTST0_RXUSRCLK20(0),
            RefSignal => RXUSRCLK20_dly,
            RefSignalName => "RXUSRCLK20",
            RefDelay => ticd_RXUSRCLK20,
            SetupHigh => tsetup_RXENPRBSTST0_RXUSRCLK20_posedge_posedge(0),
            HoldHigh => thold_RXENPRBSTST0_RXUSRCLK20_posedge_posedge(0),
            SetupLow => tsetup_RXENPRBSTST0_RXUSRCLK20_negedge_posedge(0),
            HoldLow => thold_RXENPRBSTST0_RXUSRCLK20_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXENPRBSTST0_RXUSRCLK20_posedge(1),
            TimingData => Tmkr_RXENPRBSTST0_RXUSRCLK20_posedge(1),
            TestSignal => RXENPRBSTST0_RXUSRCLK20_dly(1),
            TestSignalName => "RXENPRBSTST0(1)",
            TestDelay => tisd_RXENPRBSTST0_RXUSRCLK20(1),
            RefSignal => RXUSRCLK20_dly,
            RefSignalName => "RXUSRCLK20",
            RefDelay => ticd_RXUSRCLK20,
            SetupHigh => tsetup_RXENPRBSTST0_RXUSRCLK20_posedge_posedge(1),
            HoldHigh => thold_RXENPRBSTST0_RXUSRCLK20_posedge_posedge(1),
            SetupLow => tsetup_RXENPRBSTST0_RXUSRCLK20_negedge_posedge(1),
            HoldLow => thold_RXENPRBSTST0_RXUSRCLK20_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXENPRBSTST0_RXUSRCLK20_posedge(2),
            TimingData => Tmkr_RXENPRBSTST0_RXUSRCLK20_posedge(2),
            TestSignal => RXENPRBSTST0_RXUSRCLK20_dly(2),
            TestSignalName => "RXENPRBSTST0(2)",
            TestDelay => tisd_RXENPRBSTST0_RXUSRCLK20(2),
            RefSignal => RXUSRCLK20_dly,
            RefSignalName => "RXUSRCLK20",
            RefDelay => ticd_RXUSRCLK20,
            SetupHigh => tsetup_RXENPRBSTST0_RXUSRCLK20_posedge_posedge(2),
            HoldHigh => thold_RXENPRBSTST0_RXUSRCLK20_posedge_posedge(2),
            SetupLow => tsetup_RXENPRBSTST0_RXUSRCLK20_negedge_posedge(2),
            HoldLow => thold_RXENPRBSTST0_RXUSRCLK20_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXENPRBSTST1_RXUSRCLK21_posedge(0),
            TimingData => Tmkr_RXENPRBSTST1_RXUSRCLK21_posedge(0),
            TestSignal => RXENPRBSTST1_RXUSRCLK21_dly(0),
            TestSignalName => "RXENPRBSTST1(0)",
            TestDelay => tisd_RXENPRBSTST1_RXUSRCLK21(0),
            RefSignal => RXUSRCLK21_dly,
            RefSignalName => "RXUSRCLK21",
            RefDelay => ticd_RXUSRCLK21,
            SetupHigh => tsetup_RXENPRBSTST1_RXUSRCLK21_posedge_posedge(0),
            HoldHigh => thold_RXENPRBSTST1_RXUSRCLK21_posedge_posedge(0),
            SetupLow => tsetup_RXENPRBSTST1_RXUSRCLK21_negedge_posedge(0),
            HoldLow => thold_RXENPRBSTST1_RXUSRCLK21_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXENPRBSTST1_RXUSRCLK21_posedge(1),
            TimingData => Tmkr_RXENPRBSTST1_RXUSRCLK21_posedge(1),
            TestSignal => RXENPRBSTST1_RXUSRCLK21_dly(1),
            TestSignalName => "RXENPRBSTST1(1)",
            TestDelay => tisd_RXENPRBSTST1_RXUSRCLK21(1),
            RefSignal => RXUSRCLK21_dly,
            RefSignalName => "RXUSRCLK21",
            RefDelay => ticd_RXUSRCLK21,
            SetupHigh => tsetup_RXENPRBSTST1_RXUSRCLK21_posedge_posedge(1),
            HoldHigh => thold_RXENPRBSTST1_RXUSRCLK21_posedge_posedge(1),
            SetupLow => tsetup_RXENPRBSTST1_RXUSRCLK21_negedge_posedge(1),
            HoldLow => thold_RXENPRBSTST1_RXUSRCLK21_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXENPRBSTST1_RXUSRCLK21_posedge(2),
            TimingData => Tmkr_RXENPRBSTST1_RXUSRCLK21_posedge(2),
            TestSignal => RXENPRBSTST1_RXUSRCLK21_dly(2),
            TestSignalName => "RXENPRBSTST1(2)",
            TestDelay => tisd_RXENPRBSTST1_RXUSRCLK21(2),
            RefSignal => RXUSRCLK21_dly,
            RefSignalName => "RXUSRCLK21",
            RefDelay => ticd_RXUSRCLK21,
            SetupHigh => tsetup_RXENPRBSTST1_RXUSRCLK21_posedge_posedge(2),
            HoldHigh => thold_RXENPRBSTST1_RXUSRCLK21_posedge_posedge(2),
            SetupLow => tsetup_RXENPRBSTST1_RXUSRCLK21_negedge_posedge(2),
            HoldLow => thold_RXENPRBSTST1_RXUSRCLK21_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXPOLARITY0_RXUSRCLK20_posedge,
            TimingData => Tmkr_RXPOLARITY0_RXUSRCLK20_posedge,
            TestSignal => RXPOLARITY0_RXUSRCLK20_dly,
            TestSignalName => "RXPOLARITY0",
            TestDelay => tisd_RXPOLARITY0_RXUSRCLK20,
            RefSignal => RXUSRCLK20_dly,
            RefSignalName => "RXUSRCLK20",
            RefDelay => ticd_RXUSRCLK20,
            SetupHigh => tsetup_RXPOLARITY0_RXUSRCLK20_posedge_posedge,
            HoldHigh => thold_RXPOLARITY0_RXUSRCLK20_posedge_posedge,
            SetupLow => tsetup_RXPOLARITY0_RXUSRCLK20_negedge_posedge,
            HoldLow => thold_RXPOLARITY0_RXUSRCLK20_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXPOLARITY1_RXUSRCLK21_posedge,
            TimingData => Tmkr_RXPOLARITY1_RXUSRCLK21_posedge,
            TestSignal => RXPOLARITY1_RXUSRCLK21_dly,
            TestSignalName => "RXPOLARITY1",
            TestDelay => tisd_RXPOLARITY1_RXUSRCLK21,
            RefSignal => RXUSRCLK21_dly,
            RefSignalName => "RXUSRCLK21",
            RefDelay => ticd_RXUSRCLK21,
            SetupHigh => tsetup_RXPOLARITY1_RXUSRCLK21_posedge_posedge,
            HoldHigh => thold_RXPOLARITY1_RXUSRCLK21_posedge_posedge,
            SetupLow => tsetup_RXPOLARITY1_RXUSRCLK21_negedge_posedge,
            HoldLow => thold_RXPOLARITY1_RXUSRCLK21_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXSLIDE0_RXUSRCLK20_posedge,
            TimingData => Tmkr_RXSLIDE0_RXUSRCLK20_posedge,
            TestSignal => RXSLIDE0_RXUSRCLK20_dly,
            TestSignalName => "RXSLIDE0",
            TestDelay => tisd_RXSLIDE0_RXUSRCLK20,
            RefSignal => RXUSRCLK20_dly,
            RefSignalName => "RXUSRCLK20",
            RefDelay => ticd_RXUSRCLK20,
            SetupHigh => tsetup_RXSLIDE0_RXUSRCLK20_posedge_posedge,
            HoldHigh => thold_RXSLIDE0_RXUSRCLK20_posedge_posedge,
            SetupLow => tsetup_RXSLIDE0_RXUSRCLK20_negedge_posedge,
            HoldLow => thold_RXSLIDE0_RXUSRCLK20_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXSLIDE1_RXUSRCLK21_posedge,
            TimingData => Tmkr_RXSLIDE1_RXUSRCLK21_posedge,
            TestSignal => RXSLIDE1_RXUSRCLK21_dly,
            TestSignalName => "RXSLIDE1",
            TestDelay => tisd_RXSLIDE1_RXUSRCLK21,
            RefSignal => RXUSRCLK21_dly,
            RefSignalName => "RXUSRCLK21",
            RefDelay => ticd_RXUSRCLK21,
            SetupHigh => tsetup_RXSLIDE1_RXUSRCLK21_posedge_posedge,
            HoldHigh => thold_RXSLIDE1_RXUSRCLK21_posedge_posedge,
            SetupLow => tsetup_RXSLIDE1_RXUSRCLK21_negedge_posedge,
            HoldLow => thold_RXSLIDE1_RXUSRCLK21_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXBYPASS8B10B0_TXUSRCLK20_posedge(0),
            TimingData => Tmkr_TXBYPASS8B10B0_TXUSRCLK20_posedge(0),
            TestSignal => TXBYPASS8B10B0_TXUSRCLK20_dly(0),
            TestSignalName => "TXBYPASS8B10B0(0)",
            TestDelay => tisd_TXBYPASS8B10B0_TXUSRCLK20(0),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXBYPASS8B10B0_TXUSRCLK20_posedge_posedge(0),
            HoldHigh => thold_TXBYPASS8B10B0_TXUSRCLK20_posedge_posedge(0),
            SetupLow => tsetup_TXBYPASS8B10B0_TXUSRCLK20_negedge_posedge(0),
            HoldLow => thold_TXBYPASS8B10B0_TXUSRCLK20_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXBYPASS8B10B0_TXUSRCLK20_posedge(1),
            TimingData => Tmkr_TXBYPASS8B10B0_TXUSRCLK20_posedge(1),
            TestSignal => TXBYPASS8B10B0_TXUSRCLK20_dly(1),
            TestSignalName => "TXBYPASS8B10B0(1)",
            TestDelay => tisd_TXBYPASS8B10B0_TXUSRCLK20(1),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXBYPASS8B10B0_TXUSRCLK20_posedge_posedge(1),
            HoldHigh => thold_TXBYPASS8B10B0_TXUSRCLK20_posedge_posedge(1),
            SetupLow => tsetup_TXBYPASS8B10B0_TXUSRCLK20_negedge_posedge(1),
            HoldLow => thold_TXBYPASS8B10B0_TXUSRCLK20_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXBYPASS8B10B0_TXUSRCLK20_posedge(2),
            TimingData => Tmkr_TXBYPASS8B10B0_TXUSRCLK20_posedge(2),
            TestSignal => TXBYPASS8B10B0_TXUSRCLK20_dly(2),
            TestSignalName => "TXBYPASS8B10B0(2)",
            TestDelay => tisd_TXBYPASS8B10B0_TXUSRCLK20(2),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXBYPASS8B10B0_TXUSRCLK20_posedge_posedge(2),
            HoldHigh => thold_TXBYPASS8B10B0_TXUSRCLK20_posedge_posedge(2),
            SetupLow => tsetup_TXBYPASS8B10B0_TXUSRCLK20_negedge_posedge(2),
            HoldLow => thold_TXBYPASS8B10B0_TXUSRCLK20_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXBYPASS8B10B0_TXUSRCLK20_posedge(3),
            TimingData => Tmkr_TXBYPASS8B10B0_TXUSRCLK20_posedge(3),
            TestSignal => TXBYPASS8B10B0_TXUSRCLK20_dly(3),
            TestSignalName => "TXBYPASS8B10B0(3)",
            TestDelay => tisd_TXBYPASS8B10B0_TXUSRCLK20(3),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXBYPASS8B10B0_TXUSRCLK20_posedge_posedge(3),
            HoldHigh => thold_TXBYPASS8B10B0_TXUSRCLK20_posedge_posedge(3),
            SetupLow => tsetup_TXBYPASS8B10B0_TXUSRCLK20_negedge_posedge(3),
            HoldLow => thold_TXBYPASS8B10B0_TXUSRCLK20_negedge_posedge(3),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXBYPASS8B10B1_TXUSRCLK21_posedge(0),
            TimingData => Tmkr_TXBYPASS8B10B1_TXUSRCLK21_posedge(0),
            TestSignal => TXBYPASS8B10B1_TXUSRCLK21_dly(0),
            TestSignalName => "TXBYPASS8B10B1(0)",
            TestDelay => tisd_TXBYPASS8B10B1_TXUSRCLK21(0),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXBYPASS8B10B1_TXUSRCLK21_posedge_posedge(0),
            HoldHigh => thold_TXBYPASS8B10B1_TXUSRCLK21_posedge_posedge(0),
            SetupLow => tsetup_TXBYPASS8B10B1_TXUSRCLK21_negedge_posedge(0),
            HoldLow => thold_TXBYPASS8B10B1_TXUSRCLK21_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXBYPASS8B10B1_TXUSRCLK21_posedge(1),
            TimingData => Tmkr_TXBYPASS8B10B1_TXUSRCLK21_posedge(1),
            TestSignal => TXBYPASS8B10B1_TXUSRCLK21_dly(1),
            TestSignalName => "TXBYPASS8B10B1(1)",
            TestDelay => tisd_TXBYPASS8B10B1_TXUSRCLK21(1),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXBYPASS8B10B1_TXUSRCLK21_posedge_posedge(1),
            HoldHigh => thold_TXBYPASS8B10B1_TXUSRCLK21_posedge_posedge(1),
            SetupLow => tsetup_TXBYPASS8B10B1_TXUSRCLK21_negedge_posedge(1),
            HoldLow => thold_TXBYPASS8B10B1_TXUSRCLK21_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXBYPASS8B10B1_TXUSRCLK21_posedge(2),
            TimingData => Tmkr_TXBYPASS8B10B1_TXUSRCLK21_posedge(2),
            TestSignal => TXBYPASS8B10B1_TXUSRCLK21_dly(2),
            TestSignalName => "TXBYPASS8B10B1(2)",
            TestDelay => tisd_TXBYPASS8B10B1_TXUSRCLK21(2),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXBYPASS8B10B1_TXUSRCLK21_posedge_posedge(2),
            HoldHigh => thold_TXBYPASS8B10B1_TXUSRCLK21_posedge_posedge(2),
            SetupLow => tsetup_TXBYPASS8B10B1_TXUSRCLK21_negedge_posedge(2),
            HoldLow => thold_TXBYPASS8B10B1_TXUSRCLK21_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXBYPASS8B10B1_TXUSRCLK21_posedge(3),
            TimingData => Tmkr_TXBYPASS8B10B1_TXUSRCLK21_posedge(3),
            TestSignal => TXBYPASS8B10B1_TXUSRCLK21_dly(3),
            TestSignalName => "TXBYPASS8B10B1(3)",
            TestDelay => tisd_TXBYPASS8B10B1_TXUSRCLK21(3),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXBYPASS8B10B1_TXUSRCLK21_posedge_posedge(3),
            HoldHigh => thold_TXBYPASS8B10B1_TXUSRCLK21_posedge_posedge(3),
            SetupLow => tsetup_TXBYPASS8B10B1_TXUSRCLK21_negedge_posedge(3),
            HoldLow => thold_TXBYPASS8B10B1_TXUSRCLK21_negedge_posedge(3),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARDISPMODE0_TXUSRCLK20_posedge(0),
            TimingData => Tmkr_TXCHARDISPMODE0_TXUSRCLK20_posedge(0),
            TestSignal => TXCHARDISPMODE0_TXUSRCLK20_dly(0),
            TestSignalName => "TXCHARDISPMODE0(0)",
            TestDelay => tisd_TXCHARDISPMODE0_TXUSRCLK20(0),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXCHARDISPMODE0_TXUSRCLK20_posedge_posedge(0),
            HoldHigh => thold_TXCHARDISPMODE0_TXUSRCLK20_posedge_posedge(0),
            SetupLow => tsetup_TXCHARDISPMODE0_TXUSRCLK20_negedge_posedge(0),
            HoldLow => thold_TXCHARDISPMODE0_TXUSRCLK20_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARDISPMODE0_TXUSRCLK20_posedge(1),
            TimingData => Tmkr_TXCHARDISPMODE0_TXUSRCLK20_posedge(1),
            TestSignal => TXCHARDISPMODE0_TXUSRCLK20_dly(1),
            TestSignalName => "TXCHARDISPMODE0(1)",
            TestDelay => tisd_TXCHARDISPMODE0_TXUSRCLK20(1),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXCHARDISPMODE0_TXUSRCLK20_posedge_posedge(1),
            HoldHigh => thold_TXCHARDISPMODE0_TXUSRCLK20_posedge_posedge(1),
            SetupLow => tsetup_TXCHARDISPMODE0_TXUSRCLK20_negedge_posedge(1),
            HoldLow => thold_TXCHARDISPMODE0_TXUSRCLK20_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARDISPMODE0_TXUSRCLK20_posedge(2),
            TimingData => Tmkr_TXCHARDISPMODE0_TXUSRCLK20_posedge(2),
            TestSignal => TXCHARDISPMODE0_TXUSRCLK20_dly(2),
            TestSignalName => "TXCHARDISPMODE0(2)",
            TestDelay => tisd_TXCHARDISPMODE0_TXUSRCLK20(2),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXCHARDISPMODE0_TXUSRCLK20_posedge_posedge(2),
            HoldHigh => thold_TXCHARDISPMODE0_TXUSRCLK20_posedge_posedge(2),
            SetupLow => tsetup_TXCHARDISPMODE0_TXUSRCLK20_negedge_posedge(2),
            HoldLow => thold_TXCHARDISPMODE0_TXUSRCLK20_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARDISPMODE0_TXUSRCLK20_posedge(3),
            TimingData => Tmkr_TXCHARDISPMODE0_TXUSRCLK20_posedge(3),
            TestSignal => TXCHARDISPMODE0_TXUSRCLK20_dly(3),
            TestSignalName => "TXCHARDISPMODE0(3)",
            TestDelay => tisd_TXCHARDISPMODE0_TXUSRCLK20(3),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXCHARDISPMODE0_TXUSRCLK20_posedge_posedge(3),
            HoldHigh => thold_TXCHARDISPMODE0_TXUSRCLK20_posedge_posedge(3),
            SetupLow => tsetup_TXCHARDISPMODE0_TXUSRCLK20_negedge_posedge(3),
            HoldLow => thold_TXCHARDISPMODE0_TXUSRCLK20_negedge_posedge(3),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARDISPMODE1_TXUSRCLK21_posedge(0),
            TimingData => Tmkr_TXCHARDISPMODE1_TXUSRCLK21_posedge(0),
            TestSignal => TXCHARDISPMODE1_TXUSRCLK21_dly(0),
            TestSignalName => "TXCHARDISPMODE1(0)",
            TestDelay => tisd_TXCHARDISPMODE1_TXUSRCLK21(0),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXCHARDISPMODE1_TXUSRCLK21_posedge_posedge(0),
            HoldHigh => thold_TXCHARDISPMODE1_TXUSRCLK21_posedge_posedge(0),
            SetupLow => tsetup_TXCHARDISPMODE1_TXUSRCLK21_negedge_posedge(0),
            HoldLow => thold_TXCHARDISPMODE1_TXUSRCLK21_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARDISPMODE1_TXUSRCLK21_posedge(1),
            TimingData => Tmkr_TXCHARDISPMODE1_TXUSRCLK21_posedge(1),
            TestSignal => TXCHARDISPMODE1_TXUSRCLK21_dly(1),
            TestSignalName => "TXCHARDISPMODE1(1)",
            TestDelay => tisd_TXCHARDISPMODE1_TXUSRCLK21(1),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXCHARDISPMODE1_TXUSRCLK21_posedge_posedge(1),
            HoldHigh => thold_TXCHARDISPMODE1_TXUSRCLK21_posedge_posedge(1),
            SetupLow => tsetup_TXCHARDISPMODE1_TXUSRCLK21_negedge_posedge(1),
            HoldLow => thold_TXCHARDISPMODE1_TXUSRCLK21_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARDISPMODE1_TXUSRCLK21_posedge(2),
            TimingData => Tmkr_TXCHARDISPMODE1_TXUSRCLK21_posedge(2),
            TestSignal => TXCHARDISPMODE1_TXUSRCLK21_dly(2),
            TestSignalName => "TXCHARDISPMODE1(2)",
            TestDelay => tisd_TXCHARDISPMODE1_TXUSRCLK21(2),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXCHARDISPMODE1_TXUSRCLK21_posedge_posedge(2),
            HoldHigh => thold_TXCHARDISPMODE1_TXUSRCLK21_posedge_posedge(2),
            SetupLow => tsetup_TXCHARDISPMODE1_TXUSRCLK21_negedge_posedge(2),
            HoldLow => thold_TXCHARDISPMODE1_TXUSRCLK21_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARDISPMODE1_TXUSRCLK21_posedge(3),
            TimingData => Tmkr_TXCHARDISPMODE1_TXUSRCLK21_posedge(3),
            TestSignal => TXCHARDISPMODE1_TXUSRCLK21_dly(3),
            TestSignalName => "TXCHARDISPMODE1(3)",
            TestDelay => tisd_TXCHARDISPMODE1_TXUSRCLK21(3),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXCHARDISPMODE1_TXUSRCLK21_posedge_posedge(3),
            HoldHigh => thold_TXCHARDISPMODE1_TXUSRCLK21_posedge_posedge(3),
            SetupLow => tsetup_TXCHARDISPMODE1_TXUSRCLK21_negedge_posedge(3),
            HoldLow => thold_TXCHARDISPMODE1_TXUSRCLK21_negedge_posedge(3),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARDISPVAL0_TXUSRCLK20_posedge(0),
            TimingData => Tmkr_TXCHARDISPVAL0_TXUSRCLK20_posedge(0),
            TestSignal => TXCHARDISPVAL0_TXUSRCLK20_dly(0),
            TestSignalName => "TXCHARDISPVAL0(0)",
            TestDelay => tisd_TXCHARDISPVAL0_TXUSRCLK20(0),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXCHARDISPVAL0_TXUSRCLK20_posedge_posedge(0),
            HoldHigh => thold_TXCHARDISPVAL0_TXUSRCLK20_posedge_posedge(0),
            SetupLow => tsetup_TXCHARDISPVAL0_TXUSRCLK20_negedge_posedge(0),
            HoldLow => thold_TXCHARDISPVAL0_TXUSRCLK20_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARDISPVAL0_TXUSRCLK20_posedge(1),
            TimingData => Tmkr_TXCHARDISPVAL0_TXUSRCLK20_posedge(1),
            TestSignal => TXCHARDISPVAL0_TXUSRCLK20_dly(1),
            TestSignalName => "TXCHARDISPVAL0(1)",
            TestDelay => tisd_TXCHARDISPVAL0_TXUSRCLK20(1),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXCHARDISPVAL0_TXUSRCLK20_posedge_posedge(1),
            HoldHigh => thold_TXCHARDISPVAL0_TXUSRCLK20_posedge_posedge(1),
            SetupLow => tsetup_TXCHARDISPVAL0_TXUSRCLK20_negedge_posedge(1),
            HoldLow => thold_TXCHARDISPVAL0_TXUSRCLK20_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARDISPVAL0_TXUSRCLK20_posedge(2),
            TimingData => Tmkr_TXCHARDISPVAL0_TXUSRCLK20_posedge(2),
            TestSignal => TXCHARDISPVAL0_TXUSRCLK20_dly(2),
            TestSignalName => "TXCHARDISPVAL0(2)",
            TestDelay => tisd_TXCHARDISPVAL0_TXUSRCLK20(2),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXCHARDISPVAL0_TXUSRCLK20_posedge_posedge(2),
            HoldHigh => thold_TXCHARDISPVAL0_TXUSRCLK20_posedge_posedge(2),
            SetupLow => tsetup_TXCHARDISPVAL0_TXUSRCLK20_negedge_posedge(2),
            HoldLow => thold_TXCHARDISPVAL0_TXUSRCLK20_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARDISPVAL0_TXUSRCLK20_posedge(3),
            TimingData => Tmkr_TXCHARDISPVAL0_TXUSRCLK20_posedge(3),
            TestSignal => TXCHARDISPVAL0_TXUSRCLK20_dly(3),
            TestSignalName => "TXCHARDISPVAL0(3)",
            TestDelay => tisd_TXCHARDISPVAL0_TXUSRCLK20(3),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXCHARDISPVAL0_TXUSRCLK20_posedge_posedge(3),
            HoldHigh => thold_TXCHARDISPVAL0_TXUSRCLK20_posedge_posedge(3),
            SetupLow => tsetup_TXCHARDISPVAL0_TXUSRCLK20_negedge_posedge(3),
            HoldLow => thold_TXCHARDISPVAL0_TXUSRCLK20_negedge_posedge(3),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARDISPVAL1_TXUSRCLK21_posedge(0),
            TimingData => Tmkr_TXCHARDISPVAL1_TXUSRCLK21_posedge(0),
            TestSignal => TXCHARDISPVAL1_TXUSRCLK21_dly(0),
            TestSignalName => "TXCHARDISPVAL1(0)",
            TestDelay => tisd_TXCHARDISPVAL1_TXUSRCLK21(0),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXCHARDISPVAL1_TXUSRCLK21_posedge_posedge(0),
            HoldHigh => thold_TXCHARDISPVAL1_TXUSRCLK21_posedge_posedge(0),
            SetupLow => tsetup_TXCHARDISPVAL1_TXUSRCLK21_negedge_posedge(0),
            HoldLow => thold_TXCHARDISPVAL1_TXUSRCLK21_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARDISPVAL1_TXUSRCLK21_posedge(1),
            TimingData => Tmkr_TXCHARDISPVAL1_TXUSRCLK21_posedge(1),
            TestSignal => TXCHARDISPVAL1_TXUSRCLK21_dly(1),
            TestSignalName => "TXCHARDISPVAL1(1)",
            TestDelay => tisd_TXCHARDISPVAL1_TXUSRCLK21(1),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXCHARDISPVAL1_TXUSRCLK21_posedge_posedge(1),
            HoldHigh => thold_TXCHARDISPVAL1_TXUSRCLK21_posedge_posedge(1),
            SetupLow => tsetup_TXCHARDISPVAL1_TXUSRCLK21_negedge_posedge(1),
            HoldLow => thold_TXCHARDISPVAL1_TXUSRCLK21_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARDISPVAL1_TXUSRCLK21_posedge(2),
            TimingData => Tmkr_TXCHARDISPVAL1_TXUSRCLK21_posedge(2),
            TestSignal => TXCHARDISPVAL1_TXUSRCLK21_dly(2),
            TestSignalName => "TXCHARDISPVAL1(2)",
            TestDelay => tisd_TXCHARDISPVAL1_TXUSRCLK21(2),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXCHARDISPVAL1_TXUSRCLK21_posedge_posedge(2),
            HoldHigh => thold_TXCHARDISPVAL1_TXUSRCLK21_posedge_posedge(2),
            SetupLow => tsetup_TXCHARDISPVAL1_TXUSRCLK21_negedge_posedge(2),
            HoldLow => thold_TXCHARDISPVAL1_TXUSRCLK21_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARDISPVAL1_TXUSRCLK21_posedge(3),
            TimingData => Tmkr_TXCHARDISPVAL1_TXUSRCLK21_posedge(3),
            TestSignal => TXCHARDISPVAL1_TXUSRCLK21_dly(3),
            TestSignalName => "TXCHARDISPVAL1(3)",
            TestDelay => tisd_TXCHARDISPVAL1_TXUSRCLK21(3),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXCHARDISPVAL1_TXUSRCLK21_posedge_posedge(3),
            HoldHigh => thold_TXCHARDISPVAL1_TXUSRCLK21_posedge_posedge(3),
            SetupLow => tsetup_TXCHARDISPVAL1_TXUSRCLK21_negedge_posedge(3),
            HoldLow => thold_TXCHARDISPVAL1_TXUSRCLK21_negedge_posedge(3),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARISK0_TXUSRCLK20_posedge(0),
            TimingData => Tmkr_TXCHARISK0_TXUSRCLK20_posedge(0),
            TestSignal => TXCHARISK0_TXUSRCLK20_dly(0),
            TestSignalName => "TXCHARISK0(0)",
            TestDelay => tisd_TXCHARISK0_TXUSRCLK20(0),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXCHARISK0_TXUSRCLK20_posedge_posedge(0),
            HoldHigh => thold_TXCHARISK0_TXUSRCLK20_posedge_posedge(0),
            SetupLow => tsetup_TXCHARISK0_TXUSRCLK20_negedge_posedge(0),
            HoldLow => thold_TXCHARISK0_TXUSRCLK20_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARISK0_TXUSRCLK20_posedge(1),
            TimingData => Tmkr_TXCHARISK0_TXUSRCLK20_posedge(1),
            TestSignal => TXCHARISK0_TXUSRCLK20_dly(1),
            TestSignalName => "TXCHARISK0(1)",
            TestDelay => tisd_TXCHARISK0_TXUSRCLK20(1),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXCHARISK0_TXUSRCLK20_posedge_posedge(1),
            HoldHigh => thold_TXCHARISK0_TXUSRCLK20_posedge_posedge(1),
            SetupLow => tsetup_TXCHARISK0_TXUSRCLK20_negedge_posedge(1),
            HoldLow => thold_TXCHARISK0_TXUSRCLK20_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARISK0_TXUSRCLK20_posedge(2),
            TimingData => Tmkr_TXCHARISK0_TXUSRCLK20_posedge(2),
            TestSignal => TXCHARISK0_TXUSRCLK20_dly(2),
            TestSignalName => "TXCHARISK0(2)",
            TestDelay => tisd_TXCHARISK0_TXUSRCLK20(2),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXCHARISK0_TXUSRCLK20_posedge_posedge(2),
            HoldHigh => thold_TXCHARISK0_TXUSRCLK20_posedge_posedge(2),
            SetupLow => tsetup_TXCHARISK0_TXUSRCLK20_negedge_posedge(2),
            HoldLow => thold_TXCHARISK0_TXUSRCLK20_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARISK0_TXUSRCLK20_posedge(3),
            TimingData => Tmkr_TXCHARISK0_TXUSRCLK20_posedge(3),
            TestSignal => TXCHARISK0_TXUSRCLK20_dly(3),
            TestSignalName => "TXCHARISK0(3)",
            TestDelay => tisd_TXCHARISK0_TXUSRCLK20(3),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXCHARISK0_TXUSRCLK20_posedge_posedge(3),
            HoldHigh => thold_TXCHARISK0_TXUSRCLK20_posedge_posedge(3),
            SetupLow => tsetup_TXCHARISK0_TXUSRCLK20_negedge_posedge(3),
            HoldLow => thold_TXCHARISK0_TXUSRCLK20_negedge_posedge(3),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARISK1_TXUSRCLK21_posedge(0),
            TimingData => Tmkr_TXCHARISK1_TXUSRCLK21_posedge(0),
            TestSignal => TXCHARISK1_TXUSRCLK21_dly(0),
            TestSignalName => "TXCHARISK1(0)",
            TestDelay => tisd_TXCHARISK1_TXUSRCLK21(0),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXCHARISK1_TXUSRCLK21_posedge_posedge(0),
            HoldHigh => thold_TXCHARISK1_TXUSRCLK21_posedge_posedge(0),
            SetupLow => tsetup_TXCHARISK1_TXUSRCLK21_negedge_posedge(0),
            HoldLow => thold_TXCHARISK1_TXUSRCLK21_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARISK1_TXUSRCLK21_posedge(1),
            TimingData => Tmkr_TXCHARISK1_TXUSRCLK21_posedge(1),
            TestSignal => TXCHARISK1_TXUSRCLK21_dly(1),
            TestSignalName => "TXCHARISK1(1)",
            TestDelay => tisd_TXCHARISK1_TXUSRCLK21(1),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXCHARISK1_TXUSRCLK21_posedge_posedge(1),
            HoldHigh => thold_TXCHARISK1_TXUSRCLK21_posedge_posedge(1),
            SetupLow => tsetup_TXCHARISK1_TXUSRCLK21_negedge_posedge(1),
            HoldLow => thold_TXCHARISK1_TXUSRCLK21_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARISK1_TXUSRCLK21_posedge(2),
            TimingData => Tmkr_TXCHARISK1_TXUSRCLK21_posedge(2),
            TestSignal => TXCHARISK1_TXUSRCLK21_dly(2),
            TestSignalName => "TXCHARISK1(2)",
            TestDelay => tisd_TXCHARISK1_TXUSRCLK21(2),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXCHARISK1_TXUSRCLK21_posedge_posedge(2),
            HoldHigh => thold_TXCHARISK1_TXUSRCLK21_posedge_posedge(2),
            SetupLow => tsetup_TXCHARISK1_TXUSRCLK21_negedge_posedge(2),
            HoldLow => thold_TXCHARISK1_TXUSRCLK21_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARISK1_TXUSRCLK21_posedge(3),
            TimingData => Tmkr_TXCHARISK1_TXUSRCLK21_posedge(3),
            TestSignal => TXCHARISK1_TXUSRCLK21_dly(3),
            TestSignalName => "TXCHARISK1(3)",
            TestDelay => tisd_TXCHARISK1_TXUSRCLK21(3),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXCHARISK1_TXUSRCLK21_posedge_posedge(3),
            HoldHigh => thold_TXCHARISK1_TXUSRCLK21_posedge_posedge(3),
            SetupLow => tsetup_TXCHARISK1_TXUSRCLK21_negedge_posedge(3),
            HoldLow => thold_TXCHARISK1_TXUSRCLK21_negedge_posedge(3),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCOMSTART0_TXUSRCLK20_posedge,
            TimingData => Tmkr_TXCOMSTART0_TXUSRCLK20_posedge,
            TestSignal => TXCOMSTART0_TXUSRCLK20_dly,
            TestSignalName => "TXCOMSTART0",
            TestDelay => tisd_TXCOMSTART0_TXUSRCLK20,
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXCOMSTART0_TXUSRCLK20_posedge_posedge,
            HoldHigh => thold_TXCOMSTART0_TXUSRCLK20_posedge_posedge,
            SetupLow => tsetup_TXCOMSTART0_TXUSRCLK20_negedge_posedge,
            HoldLow => thold_TXCOMSTART0_TXUSRCLK20_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCOMSTART1_TXUSRCLK21_posedge,
            TimingData => Tmkr_TXCOMSTART1_TXUSRCLK21_posedge,
            TestSignal => TXCOMSTART1_TXUSRCLK21_dly,
            TestSignalName => "TXCOMSTART1",
            TestDelay => tisd_TXCOMSTART1_TXUSRCLK21,
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXCOMSTART1_TXUSRCLK21_posedge_posedge,
            HoldHigh => thold_TXCOMSTART1_TXUSRCLK21_posedge_posedge,
            SetupLow => tsetup_TXCOMSTART1_TXUSRCLK21_negedge_posedge,
            HoldLow => thold_TXCOMSTART1_TXUSRCLK21_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCOMTYPE0_TXUSRCLK20_posedge,
            TimingData => Tmkr_TXCOMTYPE0_TXUSRCLK20_posedge,
            TestSignal => TXCOMTYPE0_TXUSRCLK20_dly,
            TestSignalName => "TXCOMTYPE0",
            TestDelay => tisd_TXCOMTYPE0_TXUSRCLK20,
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXCOMTYPE0_TXUSRCLK20_posedge_posedge,
            HoldHigh => thold_TXCOMTYPE0_TXUSRCLK20_posedge_posedge,
            SetupLow => tsetup_TXCOMTYPE0_TXUSRCLK20_negedge_posedge,
            HoldLow => thold_TXCOMTYPE0_TXUSRCLK20_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCOMTYPE1_TXUSRCLK21_posedge,
            TimingData => Tmkr_TXCOMTYPE1_TXUSRCLK21_posedge,
            TestSignal => TXCOMTYPE1_TXUSRCLK21_dly,
            TestSignalName => "TXCOMTYPE1",
            TestDelay => tisd_TXCOMTYPE1_TXUSRCLK21,
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXCOMTYPE1_TXUSRCLK21_posedge_posedge,
            HoldHigh => thold_TXCOMTYPE1_TXUSRCLK21_posedge_posedge,
            SetupLow => tsetup_TXCOMTYPE1_TXUSRCLK21_negedge_posedge,
            HoldLow => thold_TXCOMTYPE1_TXUSRCLK21_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(0),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(0),
            TestSignal => TXDATA0_TXUSRCLK20_dly(0),
            TestSignalName => "TXDATA0(0)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(0),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(0),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(0),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(0),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(1),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(1),
            TestSignal => TXDATA0_TXUSRCLK20_dly(1),
            TestSignalName => "TXDATA0(1)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(1),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(1),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(1),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(1),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(10),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(10),
            TestSignal => TXDATA0_TXUSRCLK20_dly(10),
            TestSignalName => "TXDATA0(10)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(10),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(10),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(10),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(10),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(10),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(11),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(11),
            TestSignal => TXDATA0_TXUSRCLK20_dly(11),
            TestSignalName => "TXDATA0(11)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(11),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(11),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(11),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(11),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(11),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(12),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(12),
            TestSignal => TXDATA0_TXUSRCLK20_dly(12),
            TestSignalName => "TXDATA0(12)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(12),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(12),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(12),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(12),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(12),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(13),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(13),
            TestSignal => TXDATA0_TXUSRCLK20_dly(13),
            TestSignalName => "TXDATA0(13)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(13),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(13),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(13),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(13),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(13),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(14),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(14),
            TestSignal => TXDATA0_TXUSRCLK20_dly(14),
            TestSignalName => "TXDATA0(14)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(14),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(14),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(14),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(14),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(14),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(15),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(15),
            TestSignal => TXDATA0_TXUSRCLK20_dly(15),
            TestSignalName => "TXDATA0(15)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(15),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(15),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(15),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(15),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(15),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(16),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(16),
            TestSignal => TXDATA0_TXUSRCLK20_dly(16),
            TestSignalName => "TXDATA0(16)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(16),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(16),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(16),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(16),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(16),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(17),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(17),
            TestSignal => TXDATA0_TXUSRCLK20_dly(17),
            TestSignalName => "TXDATA0(17)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(17),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(17),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(17),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(17),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(17),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(18),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(18),
            TestSignal => TXDATA0_TXUSRCLK20_dly(18),
            TestSignalName => "TXDATA0(18)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(18),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(18),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(18),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(18),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(18),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(19),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(19),
            TestSignal => TXDATA0_TXUSRCLK20_dly(19),
            TestSignalName => "TXDATA0(19)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(19),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(19),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(19),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(19),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(19),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(2),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(2),
            TestSignal => TXDATA0_TXUSRCLK20_dly(2),
            TestSignalName => "TXDATA0(2)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(2),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(2),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(2),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(2),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(20),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(20),
            TestSignal => TXDATA0_TXUSRCLK20_dly(20),
            TestSignalName => "TXDATA0(20)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(20),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(20),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(20),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(20),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(20),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(21),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(21),
            TestSignal => TXDATA0_TXUSRCLK20_dly(21),
            TestSignalName => "TXDATA0(21)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(21),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(21),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(21),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(21),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(21),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(22),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(22),
            TestSignal => TXDATA0_TXUSRCLK20_dly(22),
            TestSignalName => "TXDATA0(22)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(22),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(22),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(22),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(22),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(22),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(23),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(23),
            TestSignal => TXDATA0_TXUSRCLK20_dly(23),
            TestSignalName => "TXDATA0(23)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(23),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(23),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(23),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(23),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(23),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(24),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(24),
            TestSignal => TXDATA0_TXUSRCLK20_dly(24),
            TestSignalName => "TXDATA0(24)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(24),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(24),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(24),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(24),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(24),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(25),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(25),
            TestSignal => TXDATA0_TXUSRCLK20_dly(25),
            TestSignalName => "TXDATA0(25)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(25),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(25),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(25),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(25),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(25),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(26),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(26),
            TestSignal => TXDATA0_TXUSRCLK20_dly(26),
            TestSignalName => "TXDATA0(26)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(26),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(26),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(26),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(26),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(26),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(27),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(27),
            TestSignal => TXDATA0_TXUSRCLK20_dly(27),
            TestSignalName => "TXDATA0(27)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(27),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(27),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(27),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(27),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(27),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(28),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(28),
            TestSignal => TXDATA0_TXUSRCLK20_dly(28),
            TestSignalName => "TXDATA0(28)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(28),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(28),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(28),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(28),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(28),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(29),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(29),
            TestSignal => TXDATA0_TXUSRCLK20_dly(29),
            TestSignalName => "TXDATA0(29)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(29),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(29),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(29),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(29),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(29),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(3),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(3),
            TestSignal => TXDATA0_TXUSRCLK20_dly(3),
            TestSignalName => "TXDATA0(3)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(3),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(3),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(3),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(3),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(3),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(30),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(30),
            TestSignal => TXDATA0_TXUSRCLK20_dly(30),
            TestSignalName => "TXDATA0(30)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(30),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(30),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(30),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(30),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(30),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(31),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(31),
            TestSignal => TXDATA0_TXUSRCLK20_dly(31),
            TestSignalName => "TXDATA0(31)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(31),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(31),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(31),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(31),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(31),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(4),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(4),
            TestSignal => TXDATA0_TXUSRCLK20_dly(4),
            TestSignalName => "TXDATA0(4)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(4),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(4),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(4),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(4),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(4),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(5),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(5),
            TestSignal => TXDATA0_TXUSRCLK20_dly(5),
            TestSignalName => "TXDATA0(5)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(5),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(5),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(5),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(5),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(5),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(6),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(6),
            TestSignal => TXDATA0_TXUSRCLK20_dly(6),
            TestSignalName => "TXDATA0(6)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(6),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(6),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(6),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(6),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(6),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(7),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(7),
            TestSignal => TXDATA0_TXUSRCLK20_dly(7),
            TestSignalName => "TXDATA0(7)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(7),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(7),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(7),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(7),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(7),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(8),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(8),
            TestSignal => TXDATA0_TXUSRCLK20_dly(8),
            TestSignalName => "TXDATA0(8)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(8),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(8),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(8),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(8),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(8),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA0_TXUSRCLK20_posedge(9),
            TimingData => Tmkr_TXDATA0_TXUSRCLK20_posedge(9),
            TestSignal => TXDATA0_TXUSRCLK20_dly(9),
            TestSignalName => "TXDATA0(9)",
            TestDelay => tisd_TXDATA0_TXUSRCLK20(9),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDATA0_TXUSRCLK20_posedge_posedge(9),
            HoldHigh => thold_TXDATA0_TXUSRCLK20_posedge_posedge(9),
            SetupLow => tsetup_TXDATA0_TXUSRCLK20_negedge_posedge(9),
            HoldLow => thold_TXDATA0_TXUSRCLK20_negedge_posedge(9),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(0),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(0),
            TestSignal => TXDATA1_TXUSRCLK21_dly(0),
            TestSignalName => "TXDATA1(0)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(0),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(0),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(0),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(0),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(1),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(1),
            TestSignal => TXDATA1_TXUSRCLK21_dly(1),
            TestSignalName => "TXDATA1(1)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(1),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(1),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(1),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(1),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(10),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(10),
            TestSignal => TXDATA1_TXUSRCLK21_dly(10),
            TestSignalName => "TXDATA1(10)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(10),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(10),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(10),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(10),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(10),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(11),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(11),
            TestSignal => TXDATA1_TXUSRCLK21_dly(11),
            TestSignalName => "TXDATA1(11)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(11),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(11),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(11),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(11),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(11),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(12),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(12),
            TestSignal => TXDATA1_TXUSRCLK21_dly(12),
            TestSignalName => "TXDATA1(12)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(12),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(12),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(12),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(12),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(12),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(13),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(13),
            TestSignal => TXDATA1_TXUSRCLK21_dly(13),
            TestSignalName => "TXDATA1(13)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(13),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(13),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(13),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(13),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(13),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(14),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(14),
            TestSignal => TXDATA1_TXUSRCLK21_dly(14),
            TestSignalName => "TXDATA1(14)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(14),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(14),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(14),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(14),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(14),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(15),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(15),
            TestSignal => TXDATA1_TXUSRCLK21_dly(15),
            TestSignalName => "TXDATA1(15)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(15),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(15),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(15),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(15),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(15),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(16),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(16),
            TestSignal => TXDATA1_TXUSRCLK21_dly(16),
            TestSignalName => "TXDATA1(16)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(16),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(16),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(16),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(16),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(16),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(17),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(17),
            TestSignal => TXDATA1_TXUSRCLK21_dly(17),
            TestSignalName => "TXDATA1(17)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(17),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(17),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(17),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(17),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(17),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(18),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(18),
            TestSignal => TXDATA1_TXUSRCLK21_dly(18),
            TestSignalName => "TXDATA1(18)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(18),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(18),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(18),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(18),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(18),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(19),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(19),
            TestSignal => TXDATA1_TXUSRCLK21_dly(19),
            TestSignalName => "TXDATA1(19)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(19),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(19),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(19),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(19),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(19),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(2),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(2),
            TestSignal => TXDATA1_TXUSRCLK21_dly(2),
            TestSignalName => "TXDATA1(2)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(2),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(2),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(2),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(2),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(20),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(20),
            TestSignal => TXDATA1_TXUSRCLK21_dly(20),
            TestSignalName => "TXDATA1(20)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(20),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(20),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(20),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(20),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(20),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(21),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(21),
            TestSignal => TXDATA1_TXUSRCLK21_dly(21),
            TestSignalName => "TXDATA1(21)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(21),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(21),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(21),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(21),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(21),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(22),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(22),
            TestSignal => TXDATA1_TXUSRCLK21_dly(22),
            TestSignalName => "TXDATA1(22)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(22),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(22),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(22),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(22),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(22),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(23),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(23),
            TestSignal => TXDATA1_TXUSRCLK21_dly(23),
            TestSignalName => "TXDATA1(23)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(23),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(23),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(23),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(23),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(23),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(24),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(24),
            TestSignal => TXDATA1_TXUSRCLK21_dly(24),
            TestSignalName => "TXDATA1(24)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(24),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(24),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(24),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(24),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(24),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(25),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(25),
            TestSignal => TXDATA1_TXUSRCLK21_dly(25),
            TestSignalName => "TXDATA1(25)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(25),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(25),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(25),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(25),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(25),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(26),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(26),
            TestSignal => TXDATA1_TXUSRCLK21_dly(26),
            TestSignalName => "TXDATA1(26)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(26),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(26),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(26),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(26),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(26),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(27),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(27),
            TestSignal => TXDATA1_TXUSRCLK21_dly(27),
            TestSignalName => "TXDATA1(27)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(27),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(27),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(27),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(27),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(27),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(28),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(28),
            TestSignal => TXDATA1_TXUSRCLK21_dly(28),
            TestSignalName => "TXDATA1(28)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(28),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(28),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(28),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(28),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(28),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(29),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(29),
            TestSignal => TXDATA1_TXUSRCLK21_dly(29),
            TestSignalName => "TXDATA1(29)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(29),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(29),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(29),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(29),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(29),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(3),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(3),
            TestSignal => TXDATA1_TXUSRCLK21_dly(3),
            TestSignalName => "TXDATA1(3)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(3),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(3),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(3),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(3),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(3),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(30),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(30),
            TestSignal => TXDATA1_TXUSRCLK21_dly(30),
            TestSignalName => "TXDATA1(30)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(30),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(30),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(30),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(30),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(30),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(31),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(31),
            TestSignal => TXDATA1_TXUSRCLK21_dly(31),
            TestSignalName => "TXDATA1(31)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(31),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(31),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(31),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(31),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(31),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(4),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(4),
            TestSignal => TXDATA1_TXUSRCLK21_dly(4),
            TestSignalName => "TXDATA1(4)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(4),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(4),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(4),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(4),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(4),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(5),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(5),
            TestSignal => TXDATA1_TXUSRCLK21_dly(5),
            TestSignalName => "TXDATA1(5)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(5),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(5),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(5),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(5),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(5),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(6),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(6),
            TestSignal => TXDATA1_TXUSRCLK21_dly(6),
            TestSignalName => "TXDATA1(6)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(6),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(6),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(6),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(6),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(6),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(7),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(7),
            TestSignal => TXDATA1_TXUSRCLK21_dly(7),
            TestSignalName => "TXDATA1(7)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(7),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(7),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(7),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(7),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(7),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(8),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(8),
            TestSignal => TXDATA1_TXUSRCLK21_dly(8),
            TestSignalName => "TXDATA1(8)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(8),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(8),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(8),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(8),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(8),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA1_TXUSRCLK21_posedge(9),
            TimingData => Tmkr_TXDATA1_TXUSRCLK21_posedge(9),
            TestSignal => TXDATA1_TXUSRCLK21_dly(9),
            TestSignalName => "TXDATA1(9)",
            TestDelay => tisd_TXDATA1_TXUSRCLK21(9),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDATA1_TXUSRCLK21_posedge_posedge(9),
            HoldHigh => thold_TXDATA1_TXUSRCLK21_posedge_posedge(9),
            SetupLow => tsetup_TXDATA1_TXUSRCLK21_negedge_posedge(9),
            HoldLow => thold_TXDATA1_TXUSRCLK21_negedge_posedge(9),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDETECTRX0_TXUSRCLK20_posedge,
            TimingData => Tmkr_TXDETECTRX0_TXUSRCLK20_posedge,
            TestSignal => TXDETECTRX0_TXUSRCLK20_dly,
            TestSignalName => "TXDETECTRX0",
            TestDelay => tisd_TXDETECTRX0_TXUSRCLK20,
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXDETECTRX0_TXUSRCLK20_posedge_posedge,
            HoldHigh => thold_TXDETECTRX0_TXUSRCLK20_posedge_posedge,
            SetupLow => tsetup_TXDETECTRX0_TXUSRCLK20_negedge_posedge,
            HoldLow => thold_TXDETECTRX0_TXUSRCLK20_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDETECTRX1_TXUSRCLK21_posedge,
            TimingData => Tmkr_TXDETECTRX1_TXUSRCLK21_posedge,
            TestSignal => TXDETECTRX1_TXUSRCLK21_dly,
            TestSignalName => "TXDETECTRX1",
            TestDelay => tisd_TXDETECTRX1_TXUSRCLK21,
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXDETECTRX1_TXUSRCLK21_posedge_posedge,
            HoldHigh => thold_TXDETECTRX1_TXUSRCLK21_posedge_posedge,
            SetupLow => tsetup_TXDETECTRX1_TXUSRCLK21_negedge_posedge,
            HoldLow => thold_TXDETECTRX1_TXUSRCLK21_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXELECIDLE0_TXUSRCLK20_posedge,
            TimingData => Tmkr_TXELECIDLE0_TXUSRCLK20_posedge,
            TestSignal => TXELECIDLE0_TXUSRCLK20_dly,
            TestSignalName => "TXELECIDLE0",
            TestDelay => tisd_TXELECIDLE0_TXUSRCLK20,
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXELECIDLE0_TXUSRCLK20_posedge_posedge,
            HoldHigh => thold_TXELECIDLE0_TXUSRCLK20_posedge_posedge,
            SetupLow => tsetup_TXELECIDLE0_TXUSRCLK20_negedge_posedge,
            HoldLow => thold_TXELECIDLE0_TXUSRCLK20_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXELECIDLE1_TXUSRCLK21_posedge,
            TimingData => Tmkr_TXELECIDLE1_TXUSRCLK21_posedge,
            TestSignal => TXELECIDLE1_TXUSRCLK21_dly,
            TestSignalName => "TXELECIDLE1",
            TestDelay => tisd_TXELECIDLE1_TXUSRCLK21,
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXELECIDLE1_TXUSRCLK21_posedge_posedge,
            HoldHigh => thold_TXELECIDLE1_TXUSRCLK21_posedge_posedge,
            SetupLow => tsetup_TXELECIDLE1_TXUSRCLK21_negedge_posedge,
            HoldLow => thold_TXELECIDLE1_TXUSRCLK21_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXENC8B10BUSE0_TXUSRCLK20_posedge,
            TimingData => Tmkr_TXENC8B10BUSE0_TXUSRCLK20_posedge,
            TestSignal => TXENC8B10BUSE0_TXUSRCLK20_dly,
            TestSignalName => "TXENC8B10BUSE0",
            TestDelay => tisd_TXENC8B10BUSE0_TXUSRCLK20,
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXENC8B10BUSE0_TXUSRCLK20_posedge_posedge,
            HoldHigh => thold_TXENC8B10BUSE0_TXUSRCLK20_posedge_posedge,
            SetupLow => tsetup_TXENC8B10BUSE0_TXUSRCLK20_negedge_posedge,
            HoldLow => thold_TXENC8B10BUSE0_TXUSRCLK20_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXENC8B10BUSE1_TXUSRCLK21_posedge,
            TimingData => Tmkr_TXENC8B10BUSE1_TXUSRCLK21_posedge,
            TestSignal => TXENC8B10BUSE1_TXUSRCLK21_dly,
            TestSignalName => "TXENC8B10BUSE1",
            TestDelay => tisd_TXENC8B10BUSE1_TXUSRCLK21,
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXENC8B10BUSE1_TXUSRCLK21_posedge_posedge,
            HoldHigh => thold_TXENC8B10BUSE1_TXUSRCLK21_posedge_posedge,
            SetupLow => tsetup_TXENC8B10BUSE1_TXUSRCLK21_negedge_posedge,
            HoldLow => thold_TXENC8B10BUSE1_TXUSRCLK21_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXENPRBSTST0_TXUSRCLK20_posedge(0),
            TimingData => Tmkr_TXENPRBSTST0_TXUSRCLK20_posedge(0),
            TestSignal => TXENPRBSTST0_TXUSRCLK20_dly(0),
            TestSignalName => "TXENPRBSTST0(0)",
            TestDelay => tisd_TXENPRBSTST0_TXUSRCLK20(0),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXENPRBSTST0_TXUSRCLK20_posedge_posedge(0),
            HoldHigh => thold_TXENPRBSTST0_TXUSRCLK20_posedge_posedge(0),
            SetupLow => tsetup_TXENPRBSTST0_TXUSRCLK20_negedge_posedge(0),
            HoldLow => thold_TXENPRBSTST0_TXUSRCLK20_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXENPRBSTST0_TXUSRCLK20_posedge(1),
            TimingData => Tmkr_TXENPRBSTST0_TXUSRCLK20_posedge(1),
            TestSignal => TXENPRBSTST0_TXUSRCLK20_dly(1),
            TestSignalName => "TXENPRBSTST0(1)",
            TestDelay => tisd_TXENPRBSTST0_TXUSRCLK20(1),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXENPRBSTST0_TXUSRCLK20_posedge_posedge(1),
            HoldHigh => thold_TXENPRBSTST0_TXUSRCLK20_posedge_posedge(1),
            SetupLow => tsetup_TXENPRBSTST0_TXUSRCLK20_negedge_posedge(1),
            HoldLow => thold_TXENPRBSTST0_TXUSRCLK20_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXENPRBSTST0_TXUSRCLK20_posedge(2),
            TimingData => Tmkr_TXENPRBSTST0_TXUSRCLK20_posedge(2),
            TestSignal => TXENPRBSTST0_TXUSRCLK20_dly(2),
            TestSignalName => "TXENPRBSTST0(2)",
            TestDelay => tisd_TXENPRBSTST0_TXUSRCLK20(2),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXENPRBSTST0_TXUSRCLK20_posedge_posedge(2),
            HoldHigh => thold_TXENPRBSTST0_TXUSRCLK20_posedge_posedge(2),
            SetupLow => tsetup_TXENPRBSTST0_TXUSRCLK20_negedge_posedge(2),
            HoldLow => thold_TXENPRBSTST0_TXUSRCLK20_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXENPRBSTST1_TXUSRCLK21_posedge(0),
            TimingData => Tmkr_TXENPRBSTST1_TXUSRCLK21_posedge(0),
            TestSignal => TXENPRBSTST1_TXUSRCLK21_dly(0),
            TestSignalName => "TXENPRBSTST1(0)",
            TestDelay => tisd_TXENPRBSTST1_TXUSRCLK21(0),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXENPRBSTST1_TXUSRCLK21_posedge_posedge(0),
            HoldHigh => thold_TXENPRBSTST1_TXUSRCLK21_posedge_posedge(0),
            SetupLow => tsetup_TXENPRBSTST1_TXUSRCLK21_negedge_posedge(0),
            HoldLow => thold_TXENPRBSTST1_TXUSRCLK21_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXENPRBSTST1_TXUSRCLK21_posedge(1),
            TimingData => Tmkr_TXENPRBSTST1_TXUSRCLK21_posedge(1),
            TestSignal => TXENPRBSTST1_TXUSRCLK21_dly(1),
            TestSignalName => "TXENPRBSTST1(1)",
            TestDelay => tisd_TXENPRBSTST1_TXUSRCLK21(1),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXENPRBSTST1_TXUSRCLK21_posedge_posedge(1),
            HoldHigh => thold_TXENPRBSTST1_TXUSRCLK21_posedge_posedge(1),
            SetupLow => tsetup_TXENPRBSTST1_TXUSRCLK21_negedge_posedge(1),
            HoldLow => thold_TXENPRBSTST1_TXUSRCLK21_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXENPRBSTST1_TXUSRCLK21_posedge(2),
            TimingData => Tmkr_TXENPRBSTST1_TXUSRCLK21_posedge(2),
            TestSignal => TXENPRBSTST1_TXUSRCLK21_dly(2),
            TestSignalName => "TXENPRBSTST1(2)",
            TestDelay => tisd_TXENPRBSTST1_TXUSRCLK21(2),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXENPRBSTST1_TXUSRCLK21_posedge_posedge(2),
            HoldHigh => thold_TXENPRBSTST1_TXUSRCLK21_posedge_posedge(2),
            SetupLow => tsetup_TXENPRBSTST1_TXUSRCLK21_negedge_posedge(2),
            HoldLow => thold_TXENPRBSTST1_TXUSRCLK21_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXINHIBIT0_TXUSRCLK20_posedge,
            TimingData => Tmkr_TXINHIBIT0_TXUSRCLK20_posedge,
            TestSignal => TXINHIBIT0_TXUSRCLK20_dly,
            TestSignalName => "TXINHIBIT0",
            TestDelay => tisd_TXINHIBIT0_TXUSRCLK20,
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXINHIBIT0_TXUSRCLK20_posedge_posedge,
            HoldHigh => thold_TXINHIBIT0_TXUSRCLK20_posedge_posedge,
            SetupLow => tsetup_TXINHIBIT0_TXUSRCLK20_negedge_posedge,
            HoldLow => thold_TXINHIBIT0_TXUSRCLK20_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXINHIBIT1_TXUSRCLK21_posedge,
            TimingData => Tmkr_TXINHIBIT1_TXUSRCLK21_posedge,
            TestSignal => TXINHIBIT1_TXUSRCLK21_dly,
            TestSignalName => "TXINHIBIT1",
            TestDelay => tisd_TXINHIBIT1_TXUSRCLK21,
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXINHIBIT1_TXUSRCLK21_posedge_posedge,
            HoldHigh => thold_TXINHIBIT1_TXUSRCLK21_posedge_posedge,
            SetupLow => tsetup_TXINHIBIT1_TXUSRCLK21_negedge_posedge,
            HoldLow => thold_TXINHIBIT1_TXUSRCLK21_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXPOLARITY0_TXUSRCLK20_posedge,
            TimingData => Tmkr_TXPOLARITY0_TXUSRCLK20_posedge,
            TestSignal => TXPOLARITY0_TXUSRCLK20_dly,
            TestSignalName => "TXPOLARITY0",
            TestDelay => tisd_TXPOLARITY0_TXUSRCLK20,
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXPOLARITY0_TXUSRCLK20_posedge_posedge,
            HoldHigh => thold_TXPOLARITY0_TXUSRCLK20_posedge_posedge,
            SetupLow => tsetup_TXPOLARITY0_TXUSRCLK20_negedge_posedge,
            HoldLow => thold_TXPOLARITY0_TXUSRCLK20_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXPOLARITY1_TXUSRCLK21_posedge,
            TimingData => Tmkr_TXPOLARITY1_TXUSRCLK21_posedge,
            TestSignal => TXPOLARITY1_TXUSRCLK21_dly,
            TestSignalName => "TXPOLARITY1",
            TestDelay => tisd_TXPOLARITY1_TXUSRCLK21,
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXPOLARITY1_TXUSRCLK21_posedge_posedge,
            HoldHigh => thold_TXPOLARITY1_TXUSRCLK21_posedge_posedge,
            SetupLow => tsetup_TXPOLARITY1_TXUSRCLK21_negedge_posedge,
            HoldLow => thold_TXPOLARITY1_TXUSRCLK21_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXPOWERDOWN0_TXUSRCLK20_posedge(0),
            TimingData => Tmkr_TXPOWERDOWN0_TXUSRCLK20_posedge(0),
            TestSignal => TXPOWERDOWN0_TXUSRCLK20_dly(0),
            TestSignalName => "TXPOWERDOWN0(0)",
            TestDelay => tisd_TXPOWERDOWN0_TXUSRCLK20(0),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXPOWERDOWN0_TXUSRCLK20_posedge_posedge(0),
            HoldHigh => thold_TXPOWERDOWN0_TXUSRCLK20_posedge_posedge(0),
            SetupLow => tsetup_TXPOWERDOWN0_TXUSRCLK20_negedge_posedge(0),
            HoldLow => thold_TXPOWERDOWN0_TXUSRCLK20_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXPOWERDOWN0_TXUSRCLK20_posedge(1),
            TimingData => Tmkr_TXPOWERDOWN0_TXUSRCLK20_posedge(1),
            TestSignal => TXPOWERDOWN0_TXUSRCLK20_dly(1),
            TestSignalName => "TXPOWERDOWN0(1)",
            TestDelay => tisd_TXPOWERDOWN0_TXUSRCLK20(1),
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXPOWERDOWN0_TXUSRCLK20_posedge_posedge(1),
            HoldHigh => thold_TXPOWERDOWN0_TXUSRCLK20_posedge_posedge(1),
            SetupLow => tsetup_TXPOWERDOWN0_TXUSRCLK20_negedge_posedge(1),
            HoldLow => thold_TXPOWERDOWN0_TXUSRCLK20_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXPOWERDOWN1_TXUSRCLK21_posedge(0),
            TimingData => Tmkr_TXPOWERDOWN1_TXUSRCLK21_posedge(0),
            TestSignal => TXPOWERDOWN1_TXUSRCLK21_dly(0),
            TestSignalName => "TXPOWERDOWN1(0)",
            TestDelay => tisd_TXPOWERDOWN1_TXUSRCLK21(0),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXPOWERDOWN1_TXUSRCLK21_posedge_posedge(0),
            HoldHigh => thold_TXPOWERDOWN1_TXUSRCLK21_posedge_posedge(0),
            SetupLow => tsetup_TXPOWERDOWN1_TXUSRCLK21_negedge_posedge(0),
            HoldLow => thold_TXPOWERDOWN1_TXUSRCLK21_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXPOWERDOWN1_TXUSRCLK21_posedge(1),
            TimingData => Tmkr_TXPOWERDOWN1_TXUSRCLK21_posedge(1),
            TestSignal => TXPOWERDOWN1_TXUSRCLK21_dly(1),
            TestSignalName => "TXPOWERDOWN1(1)",
            TestDelay => tisd_TXPOWERDOWN1_TXUSRCLK21(1),
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXPOWERDOWN1_TXUSRCLK21_posedge_posedge(1),
            HoldHigh => thold_TXPOWERDOWN1_TXUSRCLK21_posedge_posedge(1),
            SetupLow => tsetup_TXPOWERDOWN1_TXUSRCLK21_negedge_posedge(1),
            HoldLow => thold_TXPOWERDOWN1_TXUSRCLK21_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXPRBSFORCEERR0_TXUSRCLK20_posedge,
            TimingData => Tmkr_TXPRBSFORCEERR0_TXUSRCLK20_posedge,
            TestSignal => TXPRBSFORCEERR0_TXUSRCLK20_dly,
            TestSignalName => "TXPRBSFORCEERR0",
            TestDelay => tisd_TXPRBSFORCEERR0_TXUSRCLK20,
            RefSignal => TXUSRCLK20_dly,
            RefSignalName => "TXUSRCLK20",
            RefDelay => ticd_TXUSRCLK20,
            SetupHigh => tsetup_TXPRBSFORCEERR0_TXUSRCLK20_posedge_posedge,
            HoldHigh => thold_TXPRBSFORCEERR0_TXUSRCLK20_posedge_posedge,
            SetupLow => tsetup_TXPRBSFORCEERR0_TXUSRCLK20_negedge_posedge,
            HoldLow => thold_TXPRBSFORCEERR0_TXUSRCLK20_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXPRBSFORCEERR1_TXUSRCLK21_posedge,
            TimingData => Tmkr_TXPRBSFORCEERR1_TXUSRCLK21_posedge,
            TestSignal => TXPRBSFORCEERR1_TXUSRCLK21_dly,
            TestSignalName => "TXPRBSFORCEERR1",
            TestDelay => tisd_TXPRBSFORCEERR1_TXUSRCLK21,
            RefSignal => TXUSRCLK21_dly,
            RefSignalName => "TXUSRCLK21",
            RefDelay => ticd_TXUSRCLK21,
            SetupHigh => tsetup_TXPRBSFORCEERR1_TXUSRCLK21_posedge_posedge,
            HoldHigh => thold_TXPRBSFORCEERR1_TXUSRCLK21_posedge_posedge,
            SetupLow => tsetup_TXPRBSFORCEERR1_TXUSRCLK21_negedge_posedge,
            HoldLow => thold_TXPRBSFORCEERR1_TXUSRCLK21_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_USRCODEERR0_RXUSRCLK20_posedge,
            TimingData => Tmkr_USRCODEERR0_RXUSRCLK20_posedge,
            TestSignal => USRCODEERR0_RXUSRCLK20_dly,
            TestSignalName => "USRCODEERR0",
            TestDelay => tisd_USRCODEERR0_RXUSRCLK20,
            RefSignal => RXUSRCLK20_dly,
            RefSignalName => "RXUSRCLK20",
            RefDelay => ticd_RXUSRCLK20,
            SetupHigh => tsetup_USRCODEERR0_RXUSRCLK20_posedge_posedge,
            HoldHigh => thold_USRCODEERR0_RXUSRCLK20_posedge_posedge,
            SetupLow => tsetup_USRCODEERR0_RXUSRCLK20_negedge_posedge,
            HoldLow => thold_USRCODEERR0_RXUSRCLK20_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_USRCODEERR1_RXUSRCLK21_posedge,
            TimingData => Tmkr_USRCODEERR1_RXUSRCLK21_posedge,
            TestSignal => USRCODEERR1_RXUSRCLK21_dly,
            TestSignalName => "USRCODEERR1",
            TestDelay => tisd_USRCODEERR1_RXUSRCLK21,
            RefSignal => RXUSRCLK21_dly,
            RefSignalName => "RXUSRCLK21",
            RefDelay => ticd_RXUSRCLK21,
            SetupHigh => tsetup_USRCODEERR1_RXUSRCLK21_posedge_posedge,
            HoldHigh => thold_USRCODEERR1_RXUSRCLK21_posedge_posedge,
            SetupLow => tsetup_USRCODEERR1_RXUSRCLK21_negedge_posedge,
            HoldLow => thold_USRCODEERR1_RXUSRCLK21_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
        end if;
          VitalPathDelay01
          (
            OutSignal     => DRDY,
            GlitchData    => DRDY_GlitchData,
            OutSignalName => "DRDY",
            OutTemp       => DRDY_out,
            Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DRDY,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DRPDO(0),
            GlitchData    => DRPDO0_GlitchData,
            OutSignalName => "DRPDO(0)",
            OutTemp       => DRPDO_out(0),
            Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DRPDO(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DRPDO(1),
            GlitchData    => DRPDO1_GlitchData,
            OutSignalName => "DRPDO(1)",
            OutTemp       => DRPDO_out(1),
            Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DRPDO(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DRPDO(10),
            GlitchData    => DRPDO10_GlitchData,
            OutSignalName => "DRPDO(10)",
            OutTemp       => DRPDO_out(10),
            Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DRPDO(10),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DRPDO(11),
            GlitchData    => DRPDO11_GlitchData,
            OutSignalName => "DRPDO(11)",
            OutTemp       => DRPDO_out(11),
            Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DRPDO(11),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DRPDO(12),
            GlitchData    => DRPDO12_GlitchData,
            OutSignalName => "DRPDO(12)",
            OutTemp       => DRPDO_out(12),
            Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DRPDO(12),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DRPDO(13),
            GlitchData    => DRPDO13_GlitchData,
            OutSignalName => "DRPDO(13)",
            OutTemp       => DRPDO_out(13),
            Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DRPDO(13),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DRPDO(14),
            GlitchData    => DRPDO14_GlitchData,
            OutSignalName => "DRPDO(14)",
            OutTemp       => DRPDO_out(14),
            Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DRPDO(14),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DRPDO(15),
            GlitchData    => DRPDO15_GlitchData,
            OutSignalName => "DRPDO(15)",
            OutTemp       => DRPDO_out(15),
            Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DRPDO(15),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DRPDO(2),
            GlitchData    => DRPDO2_GlitchData,
            OutSignalName => "DRPDO(2)",
            OutTemp       => DRPDO_out(2),
            Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DRPDO(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DRPDO(3),
            GlitchData    => DRPDO3_GlitchData,
            OutSignalName => "DRPDO(3)",
            OutTemp       => DRPDO_out(3),
            Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DRPDO(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DRPDO(4),
            GlitchData    => DRPDO4_GlitchData,
            OutSignalName => "DRPDO(4)",
            OutTemp       => DRPDO_out(4),
            Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DRPDO(4),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DRPDO(5),
            GlitchData    => DRPDO5_GlitchData,
            OutSignalName => "DRPDO(5)",
            OutTemp       => DRPDO_out(5),
            Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DRPDO(5),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DRPDO(6),
            GlitchData    => DRPDO6_GlitchData,
            OutSignalName => "DRPDO(6)",
            OutTemp       => DRPDO_out(6),
            Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DRPDO(6),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DRPDO(7),
            GlitchData    => DRPDO7_GlitchData,
            OutSignalName => "DRPDO(7)",
            OutTemp       => DRPDO_out(7),
            Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DRPDO(7),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DRPDO(8),
            GlitchData    => DRPDO8_GlitchData,
            OutSignalName => "DRPDO(8)",
            OutTemp       => DRPDO_out(8),
            Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DRPDO(8),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DRPDO(9),
            GlitchData    => DRPDO9_GlitchData,
            OutSignalName => "DRPDO(9)",
            OutTemp       => DRPDO_out(9),
            Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_DRPDO(9),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => PHYSTATUS0,
            GlitchData    => PHYSTATUS0_GlitchData,
            OutSignalName => "PHYSTATUS0",
            OutTemp       => PHYSTATUS0_out,
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_PHYSTATUS0,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => PHYSTATUS1,
            GlitchData    => PHYSTATUS1_GlitchData,
            OutSignalName => "PHYSTATUS1",
            OutTemp       => PHYSTATUS1_out,
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_PHYSTATUS1,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => REFCLKPLL0,
            GlitchData    => REFCLKPLL0_GlitchData,
            OutSignalName => "REFCLKPLL0",
            OutTemp       => REFCLKPLL0_out,
            Paths       => (0 => (CLK00_dly'last_event, tpd_CLK00_REFCLKPLL0,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => REFCLKPLL0,
            GlitchData    => REFCLKPLL0_GlitchData,
            OutSignalName => "REFCLKPLL0",
            OutTemp       => REFCLKPLL0_out,
            Paths       => (0 => (CLK10_dly'last_event, tpd_CLK10_REFCLKPLL0,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => REFCLKPLL0,
            GlitchData    => REFCLKPLL0_GlitchData,
            OutSignalName => "REFCLKPLL0",
            OutTemp       => REFCLKPLL0_out,
            Paths       => (0 => (CLKINEAST0_dly'last_event, tpd_CLKINEAST0_REFCLKPLL0,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => REFCLKPLL0,
            GlitchData    => REFCLKPLL0_GlitchData,
            OutSignalName => "REFCLKPLL0",
            OutTemp       => REFCLKPLL0_out,
            Paths       => (0 => (CLKINWEST0_dly'last_event, tpd_CLKINWEST0_REFCLKPLL0,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => REFCLKPLL0,
            GlitchData    => REFCLKPLL0_GlitchData,
            OutSignalName => "REFCLKPLL0",
            OutTemp       => REFCLKPLL0_out,
            Paths       => (0 => (GCLK00_dly'last_event, tpd_GCLK00_REFCLKPLL0,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => REFCLKPLL0,
            GlitchData    => REFCLKPLL0_GlitchData,
            OutSignalName => "REFCLKPLL0",
            OutTemp       => REFCLKPLL0_out,
            Paths       => (0 => (GCLK10_dly'last_event, tpd_GCLK10_REFCLKPLL0,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => REFCLKPLL0,
            GlitchData    => REFCLKPLL0_GlitchData,
            OutSignalName => "REFCLKPLL0",
            OutTemp       => REFCLKPLL0_out,
            Paths       => (0 => (PLLCLK00_dly'last_event, tpd_PLLCLK00_REFCLKPLL0,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => REFCLKPLL0,
            GlitchData    => REFCLKPLL0_GlitchData,
            OutSignalName => "REFCLKPLL0",
            OutTemp       => REFCLKPLL0_out,
            Paths       => (0 => (PLLCLK10_dly'last_event, tpd_PLLCLK10_REFCLKPLL0,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => REFCLKPLL1,
            GlitchData    => REFCLKPLL1_GlitchData,
            OutSignalName => "REFCLKPLL1",
            OutTemp       => REFCLKPLL1_out,
            Paths       => (0 => (CLK01_dly'last_event, tpd_CLK01_REFCLKPLL1,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => REFCLKPLL1,
            GlitchData    => REFCLKPLL1_GlitchData,
            OutSignalName => "REFCLKPLL1",
            OutTemp       => REFCLKPLL1_out,
            Paths       => (0 => (CLK11_dly'last_event, tpd_CLK11_REFCLKPLL1,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => REFCLKPLL1,
            GlitchData    => REFCLKPLL1_GlitchData,
            OutSignalName => "REFCLKPLL1",
            OutTemp       => REFCLKPLL1_out,
            Paths       => (0 => (CLKINEAST1_dly'last_event, tpd_CLKINEAST1_REFCLKPLL1,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => REFCLKPLL1,
            GlitchData    => REFCLKPLL1_GlitchData,
            OutSignalName => "REFCLKPLL1",
            OutTemp       => REFCLKPLL1_out,
            Paths       => (0 => (CLKINWEST1_dly'last_event, tpd_CLKINWEST1_REFCLKPLL1,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => REFCLKPLL1,
            GlitchData    => REFCLKPLL1_GlitchData,
            OutSignalName => "REFCLKPLL1",
            OutTemp       => REFCLKPLL1_out,
            Paths       => (0 => (GCLK01_dly'last_event, tpd_GCLK01_REFCLKPLL1,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => REFCLKPLL1,
            GlitchData    => REFCLKPLL1_GlitchData,
            OutSignalName => "REFCLKPLL1",
            OutTemp       => REFCLKPLL1_out,
            Paths       => (0 => (GCLK11_dly'last_event, tpd_GCLK11_REFCLKPLL1,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => REFCLKPLL1,
            GlitchData    => REFCLKPLL1_GlitchData,
            OutSignalName => "REFCLKPLL1",
            OutTemp       => REFCLKPLL1_out,
            Paths       => (0 => (PLLCLK01_dly'last_event, tpd_PLLCLK01_REFCLKPLL1,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => REFCLKPLL1,
            GlitchData    => REFCLKPLL1_GlitchData,
            OutSignalName => "REFCLKPLL1",
            OutTemp       => REFCLKPLL1_out,
            Paths       => (0 => (PLLCLK11_dly'last_event, tpd_PLLCLK11_REFCLKPLL1,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXBUFSTATUS0(0),
            GlitchData    => RXBUFSTATUS00_GlitchData,
            OutSignalName => "RXBUFSTATUS0(0)",
            OutTemp       => RXBUFSTATUS0_out(0),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXBUFSTATUS0(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXBUFSTATUS0(1),
            GlitchData    => RXBUFSTATUS01_GlitchData,
            OutSignalName => "RXBUFSTATUS0(1)",
            OutTemp       => RXBUFSTATUS0_out(1),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXBUFSTATUS0(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXBUFSTATUS0(2),
            GlitchData    => RXBUFSTATUS02_GlitchData,
            OutSignalName => "RXBUFSTATUS0(2)",
            OutTemp       => RXBUFSTATUS0_out(2),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXBUFSTATUS0(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXBUFSTATUS1(0),
            GlitchData    => RXBUFSTATUS10_GlitchData,
            OutSignalName => "RXBUFSTATUS1(0)",
            OutTemp       => RXBUFSTATUS1_out(0),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXBUFSTATUS1(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXBUFSTATUS1(1),
            GlitchData    => RXBUFSTATUS11_GlitchData,
            OutSignalName => "RXBUFSTATUS1(1)",
            OutTemp       => RXBUFSTATUS1_out(1),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXBUFSTATUS1(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXBUFSTATUS1(2),
            GlitchData    => RXBUFSTATUS12_GlitchData,
            OutSignalName => "RXBUFSTATUS1(2)",
            OutTemp       => RXBUFSTATUS1_out(2),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXBUFSTATUS1(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXBYTEISALIGNED0,
            GlitchData    => RXBYTEISALIGNED0_GlitchData,
            OutSignalName => "RXBYTEISALIGNED0",
            OutTemp       => RXBYTEISALIGNED0_out,
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXBYTEISALIGNED0,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXBYTEISALIGNED1,
            GlitchData    => RXBYTEISALIGNED1_GlitchData,
            OutSignalName => "RXBYTEISALIGNED1",
            OutTemp       => RXBYTEISALIGNED1_out,
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXBYTEISALIGNED1,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXBYTEREALIGN0,
            GlitchData    => RXBYTEREALIGN0_GlitchData,
            OutSignalName => "RXBYTEREALIGN0",
            OutTemp       => RXBYTEREALIGN0_out,
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXBYTEREALIGN0,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXBYTEREALIGN1,
            GlitchData    => RXBYTEREALIGN1_GlitchData,
            OutSignalName => "RXBYTEREALIGN1",
            OutTemp       => RXBYTEREALIGN1_out,
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXBYTEREALIGN1,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHANBONDSEQ0,
            GlitchData    => RXCHANBONDSEQ0_GlitchData,
            OutSignalName => "RXCHANBONDSEQ0",
            OutTemp       => RXCHANBONDSEQ0_out,
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXCHANBONDSEQ0,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHANBONDSEQ1,
            GlitchData    => RXCHANBONDSEQ1_GlitchData,
            OutSignalName => "RXCHANBONDSEQ1",
            OutTemp       => RXCHANBONDSEQ1_out,
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXCHANBONDSEQ1,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHANISALIGNED0,
            GlitchData    => RXCHANISALIGNED0_GlitchData,
            OutSignalName => "RXCHANISALIGNED0",
            OutTemp       => RXCHANISALIGNED0_out,
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXCHANISALIGNED0,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHANISALIGNED1,
            GlitchData    => RXCHANISALIGNED1_GlitchData,
            OutSignalName => "RXCHANISALIGNED1",
            OutTemp       => RXCHANISALIGNED1_out,
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXCHANISALIGNED1,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHANREALIGN0,
            GlitchData    => RXCHANREALIGN0_GlitchData,
            OutSignalName => "RXCHANREALIGN0",
            OutTemp       => RXCHANREALIGN0_out,
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXCHANREALIGN0,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHANREALIGN1,
            GlitchData    => RXCHANREALIGN1_GlitchData,
            OutSignalName => "RXCHANREALIGN1",
            OutTemp       => RXCHANREALIGN1_out,
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXCHANREALIGN1,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHARISCOMMA0(0),
            GlitchData    => RXCHARISCOMMA00_GlitchData,
            OutSignalName => "RXCHARISCOMMA0(0)",
            OutTemp       => RXCHARISCOMMA0_out(0),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXCHARISCOMMA0(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHARISCOMMA0(1),
            GlitchData    => RXCHARISCOMMA01_GlitchData,
            OutSignalName => "RXCHARISCOMMA0(1)",
            OutTemp       => RXCHARISCOMMA0_out(1),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXCHARISCOMMA0(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHARISCOMMA0(2),
            GlitchData    => RXCHARISCOMMA02_GlitchData,
            OutSignalName => "RXCHARISCOMMA0(2)",
            OutTemp       => RXCHARISCOMMA0_out(2),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXCHARISCOMMA0(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHARISCOMMA0(3),
            GlitchData    => RXCHARISCOMMA03_GlitchData,
            OutSignalName => "RXCHARISCOMMA0(3)",
            OutTemp       => RXCHARISCOMMA0_out(3),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXCHARISCOMMA0(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHARISCOMMA1(0),
            GlitchData    => RXCHARISCOMMA10_GlitchData,
            OutSignalName => "RXCHARISCOMMA1(0)",
            OutTemp       => RXCHARISCOMMA1_out(0),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXCHARISCOMMA1(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHARISCOMMA1(1),
            GlitchData    => RXCHARISCOMMA11_GlitchData,
            OutSignalName => "RXCHARISCOMMA1(1)",
            OutTemp       => RXCHARISCOMMA1_out(1),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXCHARISCOMMA1(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHARISCOMMA1(2),
            GlitchData    => RXCHARISCOMMA12_GlitchData,
            OutSignalName => "RXCHARISCOMMA1(2)",
            OutTemp       => RXCHARISCOMMA1_out(2),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXCHARISCOMMA1(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHARISCOMMA1(3),
            GlitchData    => RXCHARISCOMMA13_GlitchData,
            OutSignalName => "RXCHARISCOMMA1(3)",
            OutTemp       => RXCHARISCOMMA1_out(3),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXCHARISCOMMA1(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHARISK0(0),
            GlitchData    => RXCHARISK00_GlitchData,
            OutSignalName => "RXCHARISK0(0)",
            OutTemp       => RXCHARISK0_out(0),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXCHARISK0(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHARISK0(1),
            GlitchData    => RXCHARISK01_GlitchData,
            OutSignalName => "RXCHARISK0(1)",
            OutTemp       => RXCHARISK0_out(1),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXCHARISK0(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHARISK0(2),
            GlitchData    => RXCHARISK02_GlitchData,
            OutSignalName => "RXCHARISK0(2)",
            OutTemp       => RXCHARISK0_out(2),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXCHARISK0(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHARISK0(3),
            GlitchData    => RXCHARISK03_GlitchData,
            OutSignalName => "RXCHARISK0(3)",
            OutTemp       => RXCHARISK0_out(3),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXCHARISK0(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHARISK1(0),
            GlitchData    => RXCHARISK10_GlitchData,
            OutSignalName => "RXCHARISK1(0)",
            OutTemp       => RXCHARISK1_out(0),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXCHARISK1(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHARISK1(1),
            GlitchData    => RXCHARISK11_GlitchData,
            OutSignalName => "RXCHARISK1(1)",
            OutTemp       => RXCHARISK1_out(1),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXCHARISK1(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHARISK1(2),
            GlitchData    => RXCHARISK12_GlitchData,
            OutSignalName => "RXCHARISK1(2)",
            OutTemp       => RXCHARISK1_out(2),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXCHARISK1(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHARISK1(3),
            GlitchData    => RXCHARISK13_GlitchData,
            OutSignalName => "RXCHARISK1(3)",
            OutTemp       => RXCHARISK1_out(3),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXCHARISK1(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHBONDO(0),
            GlitchData    => RXCHBONDO0_GlitchData,
            OutSignalName => "RXCHBONDO(0)",
            OutTemp       => RXCHBONDO_out(0),
            Paths       => (0 => (RXUSRCLK0_dly'last_event, tpd_RXUSRCLK0_RXCHBONDO(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHBONDO(0),
            GlitchData    => RXCHBONDO0_GlitchData,
            OutSignalName => "RXCHBONDO(0)",
            OutTemp       => RXCHBONDO_out(0),
            Paths       => (0 => (RXUSRCLK1_dly'last_event, tpd_RXUSRCLK1_RXCHBONDO(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHBONDO(1),
            GlitchData    => RXCHBONDO1_GlitchData,
            OutSignalName => "RXCHBONDO(1)",
            OutTemp       => RXCHBONDO_out(1),
            Paths       => (0 => (RXUSRCLK0_dly'last_event, tpd_RXUSRCLK0_RXCHBONDO(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHBONDO(1),
            GlitchData    => RXCHBONDO1_GlitchData,
            OutSignalName => "RXCHBONDO(1)",
            OutTemp       => RXCHBONDO_out(1),
            Paths       => (0 => (RXUSRCLK1_dly'last_event, tpd_RXUSRCLK1_RXCHBONDO(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHBONDO(2),
            GlitchData    => RXCHBONDO2_GlitchData,
            OutSignalName => "RXCHBONDO(2)",
            OutTemp       => RXCHBONDO_out(2),
            Paths       => (0 => (RXUSRCLK0_dly'last_event, tpd_RXUSRCLK0_RXCHBONDO(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHBONDO(2),
            GlitchData    => RXCHBONDO2_GlitchData,
            OutSignalName => "RXCHBONDO(2)",
            OutTemp       => RXCHBONDO_out(2),
            Paths       => (0 => (RXUSRCLK1_dly'last_event, tpd_RXUSRCLK1_RXCHBONDO(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCLKCORCNT0(0),
            GlitchData    => RXCLKCORCNT00_GlitchData,
            OutSignalName => "RXCLKCORCNT0(0)",
            OutTemp       => RXCLKCORCNT0_out(0),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXCLKCORCNT0(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCLKCORCNT0(1),
            GlitchData    => RXCLKCORCNT01_GlitchData,
            OutSignalName => "RXCLKCORCNT0(1)",
            OutTemp       => RXCLKCORCNT0_out(1),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXCLKCORCNT0(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCLKCORCNT0(2),
            GlitchData    => RXCLKCORCNT02_GlitchData,
            OutSignalName => "RXCLKCORCNT0(2)",
            OutTemp       => RXCLKCORCNT0_out(2),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXCLKCORCNT0(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCLKCORCNT1(0),
            GlitchData    => RXCLKCORCNT10_GlitchData,
            OutSignalName => "RXCLKCORCNT1(0)",
            OutTemp       => RXCLKCORCNT1_out(0),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXCLKCORCNT1(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCLKCORCNT1(1),
            GlitchData    => RXCLKCORCNT11_GlitchData,
            OutSignalName => "RXCLKCORCNT1(1)",
            OutTemp       => RXCLKCORCNT1_out(1),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXCLKCORCNT1(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCLKCORCNT1(2),
            GlitchData    => RXCLKCORCNT12_GlitchData,
            OutSignalName => "RXCLKCORCNT1(2)",
            OutTemp       => RXCLKCORCNT1_out(2),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXCLKCORCNT1(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCOMMADET0,
            GlitchData    => RXCOMMADET0_GlitchData,
            OutSignalName => "RXCOMMADET0",
            OutTemp       => RXCOMMADET0_out,
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXCOMMADET0,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCOMMADET1,
            GlitchData    => RXCOMMADET1_GlitchData,
            OutSignalName => "RXCOMMADET1",
            OutTemp       => RXCOMMADET1_out,
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXCOMMADET1,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(0),
            GlitchData    => RXDATA00_GlitchData,
            OutSignalName => "RXDATA0(0)",
            OutTemp       => RXDATA0_out(0),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(1),
            GlitchData    => RXDATA01_GlitchData,
            OutSignalName => "RXDATA0(1)",
            OutTemp       => RXDATA0_out(1),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(10),
            GlitchData    => RXDATA010_GlitchData,
            OutSignalName => "RXDATA0(10)",
            OutTemp       => RXDATA0_out(10),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(10),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(11),
            GlitchData    => RXDATA011_GlitchData,
            OutSignalName => "RXDATA0(11)",
            OutTemp       => RXDATA0_out(11),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(11),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(12),
            GlitchData    => RXDATA012_GlitchData,
            OutSignalName => "RXDATA0(12)",
            OutTemp       => RXDATA0_out(12),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(12),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(13),
            GlitchData    => RXDATA013_GlitchData,
            OutSignalName => "RXDATA0(13)",
            OutTemp       => RXDATA0_out(13),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(13),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(14),
            GlitchData    => RXDATA014_GlitchData,
            OutSignalName => "RXDATA0(14)",
            OutTemp       => RXDATA0_out(14),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(14),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(15),
            GlitchData    => RXDATA015_GlitchData,
            OutSignalName => "RXDATA0(15)",
            OutTemp       => RXDATA0_out(15),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(15),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(16),
            GlitchData    => RXDATA016_GlitchData,
            OutSignalName => "RXDATA0(16)",
            OutTemp       => RXDATA0_out(16),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(16),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(17),
            GlitchData    => RXDATA017_GlitchData,
            OutSignalName => "RXDATA0(17)",
            OutTemp       => RXDATA0_out(17),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(17),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(18),
            GlitchData    => RXDATA018_GlitchData,
            OutSignalName => "RXDATA0(18)",
            OutTemp       => RXDATA0_out(18),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(18),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(19),
            GlitchData    => RXDATA019_GlitchData,
            OutSignalName => "RXDATA0(19)",
            OutTemp       => RXDATA0_out(19),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(19),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(2),
            GlitchData    => RXDATA02_GlitchData,
            OutSignalName => "RXDATA0(2)",
            OutTemp       => RXDATA0_out(2),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(20),
            GlitchData    => RXDATA020_GlitchData,
            OutSignalName => "RXDATA0(20)",
            OutTemp       => RXDATA0_out(20),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(20),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(21),
            GlitchData    => RXDATA021_GlitchData,
            OutSignalName => "RXDATA0(21)",
            OutTemp       => RXDATA0_out(21),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(21),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(22),
            GlitchData    => RXDATA022_GlitchData,
            OutSignalName => "RXDATA0(22)",
            OutTemp       => RXDATA0_out(22),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(22),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(23),
            GlitchData    => RXDATA023_GlitchData,
            OutSignalName => "RXDATA0(23)",
            OutTemp       => RXDATA0_out(23),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(23),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(24),
            GlitchData    => RXDATA024_GlitchData,
            OutSignalName => "RXDATA0(24)",
            OutTemp       => RXDATA0_out(24),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(24),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(25),
            GlitchData    => RXDATA025_GlitchData,
            OutSignalName => "RXDATA0(25)",
            OutTemp       => RXDATA0_out(25),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(25),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(26),
            GlitchData    => RXDATA026_GlitchData,
            OutSignalName => "RXDATA0(26)",
            OutTemp       => RXDATA0_out(26),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(26),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(27),
            GlitchData    => RXDATA027_GlitchData,
            OutSignalName => "RXDATA0(27)",
            OutTemp       => RXDATA0_out(27),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(27),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(28),
            GlitchData    => RXDATA028_GlitchData,
            OutSignalName => "RXDATA0(28)",
            OutTemp       => RXDATA0_out(28),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(28),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(29),
            GlitchData    => RXDATA029_GlitchData,
            OutSignalName => "RXDATA0(29)",
            OutTemp       => RXDATA0_out(29),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(29),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(3),
            GlitchData    => RXDATA03_GlitchData,
            OutSignalName => "RXDATA0(3)",
            OutTemp       => RXDATA0_out(3),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(30),
            GlitchData    => RXDATA030_GlitchData,
            OutSignalName => "RXDATA0(30)",
            OutTemp       => RXDATA0_out(30),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(30),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(31),
            GlitchData    => RXDATA031_GlitchData,
            OutSignalName => "RXDATA0(31)",
            OutTemp       => RXDATA0_out(31),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(31),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(4),
            GlitchData    => RXDATA04_GlitchData,
            OutSignalName => "RXDATA0(4)",
            OutTemp       => RXDATA0_out(4),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(4),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(5),
            GlitchData    => RXDATA05_GlitchData,
            OutSignalName => "RXDATA0(5)",
            OutTemp       => RXDATA0_out(5),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(5),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(6),
            GlitchData    => RXDATA06_GlitchData,
            OutSignalName => "RXDATA0(6)",
            OutTemp       => RXDATA0_out(6),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(6),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(7),
            GlitchData    => RXDATA07_GlitchData,
            OutSignalName => "RXDATA0(7)",
            OutTemp       => RXDATA0_out(7),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(7),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(8),
            GlitchData    => RXDATA08_GlitchData,
            OutSignalName => "RXDATA0(8)",
            OutTemp       => RXDATA0_out(8),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(8),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA0(9),
            GlitchData    => RXDATA09_GlitchData,
            OutSignalName => "RXDATA0(9)",
            OutTemp       => RXDATA0_out(9),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDATA0(9),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(0),
            GlitchData    => RXDATA10_GlitchData,
            OutSignalName => "RXDATA1(0)",
            OutTemp       => RXDATA1_out(0),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(1),
            GlitchData    => RXDATA11_GlitchData,
            OutSignalName => "RXDATA1(1)",
            OutTemp       => RXDATA1_out(1),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(10),
            GlitchData    => RXDATA110_GlitchData,
            OutSignalName => "RXDATA1(10)",
            OutTemp       => RXDATA1_out(10),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(10),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(11),
            GlitchData    => RXDATA111_GlitchData,
            OutSignalName => "RXDATA1(11)",
            OutTemp       => RXDATA1_out(11),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(11),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(12),
            GlitchData    => RXDATA112_GlitchData,
            OutSignalName => "RXDATA1(12)",
            OutTemp       => RXDATA1_out(12),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(12),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(13),
            GlitchData    => RXDATA113_GlitchData,
            OutSignalName => "RXDATA1(13)",
            OutTemp       => RXDATA1_out(13),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(13),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(14),
            GlitchData    => RXDATA114_GlitchData,
            OutSignalName => "RXDATA1(14)",
            OutTemp       => RXDATA1_out(14),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(14),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(15),
            GlitchData    => RXDATA115_GlitchData,
            OutSignalName => "RXDATA1(15)",
            OutTemp       => RXDATA1_out(15),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(15),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(16),
            GlitchData    => RXDATA116_GlitchData,
            OutSignalName => "RXDATA1(16)",
            OutTemp       => RXDATA1_out(16),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(16),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(17),
            GlitchData    => RXDATA117_GlitchData,
            OutSignalName => "RXDATA1(17)",
            OutTemp       => RXDATA1_out(17),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(17),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(18),
            GlitchData    => RXDATA118_GlitchData,
            OutSignalName => "RXDATA1(18)",
            OutTemp       => RXDATA1_out(18),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(18),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(19),
            GlitchData    => RXDATA119_GlitchData,
            OutSignalName => "RXDATA1(19)",
            OutTemp       => RXDATA1_out(19),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(19),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(2),
            GlitchData    => RXDATA12_GlitchData,
            OutSignalName => "RXDATA1(2)",
            OutTemp       => RXDATA1_out(2),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(20),
            GlitchData    => RXDATA120_GlitchData,
            OutSignalName => "RXDATA1(20)",
            OutTemp       => RXDATA1_out(20),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(20),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(21),
            GlitchData    => RXDATA121_GlitchData,
            OutSignalName => "RXDATA1(21)",
            OutTemp       => RXDATA1_out(21),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(21),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(22),
            GlitchData    => RXDATA122_GlitchData,
            OutSignalName => "RXDATA1(22)",
            OutTemp       => RXDATA1_out(22),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(22),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(23),
            GlitchData    => RXDATA123_GlitchData,
            OutSignalName => "RXDATA1(23)",
            OutTemp       => RXDATA1_out(23),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(23),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(24),
            GlitchData    => RXDATA124_GlitchData,
            OutSignalName => "RXDATA1(24)",
            OutTemp       => RXDATA1_out(24),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(24),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(25),
            GlitchData    => RXDATA125_GlitchData,
            OutSignalName => "RXDATA1(25)",
            OutTemp       => RXDATA1_out(25),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(25),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(26),
            GlitchData    => RXDATA126_GlitchData,
            OutSignalName => "RXDATA1(26)",
            OutTemp       => RXDATA1_out(26),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(26),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(27),
            GlitchData    => RXDATA127_GlitchData,
            OutSignalName => "RXDATA1(27)",
            OutTemp       => RXDATA1_out(27),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(27),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(28),
            GlitchData    => RXDATA128_GlitchData,
            OutSignalName => "RXDATA1(28)",
            OutTemp       => RXDATA1_out(28),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(28),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(29),
            GlitchData    => RXDATA129_GlitchData,
            OutSignalName => "RXDATA1(29)",
            OutTemp       => RXDATA1_out(29),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(29),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(3),
            GlitchData    => RXDATA13_GlitchData,
            OutSignalName => "RXDATA1(3)",
            OutTemp       => RXDATA1_out(3),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(30),
            GlitchData    => RXDATA130_GlitchData,
            OutSignalName => "RXDATA1(30)",
            OutTemp       => RXDATA1_out(30),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(30),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(31),
            GlitchData    => RXDATA131_GlitchData,
            OutSignalName => "RXDATA1(31)",
            OutTemp       => RXDATA1_out(31),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(31),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(4),
            GlitchData    => RXDATA14_GlitchData,
            OutSignalName => "RXDATA1(4)",
            OutTemp       => RXDATA1_out(4),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(4),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(5),
            GlitchData    => RXDATA15_GlitchData,
            OutSignalName => "RXDATA1(5)",
            OutTemp       => RXDATA1_out(5),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(5),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(6),
            GlitchData    => RXDATA16_GlitchData,
            OutSignalName => "RXDATA1(6)",
            OutTemp       => RXDATA1_out(6),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(6),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(7),
            GlitchData    => RXDATA17_GlitchData,
            OutSignalName => "RXDATA1(7)",
            OutTemp       => RXDATA1_out(7),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(7),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(8),
            GlitchData    => RXDATA18_GlitchData,
            OutSignalName => "RXDATA1(8)",
            OutTemp       => RXDATA1_out(8),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(8),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA1(9),
            GlitchData    => RXDATA19_GlitchData,
            OutSignalName => "RXDATA1(9)",
            OutTemp       => RXDATA1_out(9),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDATA1(9),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDISPERR0(0),
            GlitchData    => RXDISPERR00_GlitchData,
            OutSignalName => "RXDISPERR0(0)",
            OutTemp       => RXDISPERR0_out(0),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDISPERR0(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDISPERR0(1),
            GlitchData    => RXDISPERR01_GlitchData,
            OutSignalName => "RXDISPERR0(1)",
            OutTemp       => RXDISPERR0_out(1),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDISPERR0(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDISPERR0(2),
            GlitchData    => RXDISPERR02_GlitchData,
            OutSignalName => "RXDISPERR0(2)",
            OutTemp       => RXDISPERR0_out(2),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDISPERR0(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDISPERR0(3),
            GlitchData    => RXDISPERR03_GlitchData,
            OutSignalName => "RXDISPERR0(3)",
            OutTemp       => RXDISPERR0_out(3),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXDISPERR0(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDISPERR1(0),
            GlitchData    => RXDISPERR10_GlitchData,
            OutSignalName => "RXDISPERR1(0)",
            OutTemp       => RXDISPERR1_out(0),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDISPERR1(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDISPERR1(1),
            GlitchData    => RXDISPERR11_GlitchData,
            OutSignalName => "RXDISPERR1(1)",
            OutTemp       => RXDISPERR1_out(1),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDISPERR1(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDISPERR1(2),
            GlitchData    => RXDISPERR12_GlitchData,
            OutSignalName => "RXDISPERR1(2)",
            OutTemp       => RXDISPERR1_out(2),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDISPERR1(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDISPERR1(3),
            GlitchData    => RXDISPERR13_GlitchData,
            OutSignalName => "RXDISPERR1(3)",
            OutTemp       => RXDISPERR1_out(3),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXDISPERR1(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXLOSSOFSYNC0(0),
            GlitchData    => RXLOSSOFSYNC00_GlitchData,
            OutSignalName => "RXLOSSOFSYNC0(0)",
            OutTemp       => RXLOSSOFSYNC0_out(0),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXLOSSOFSYNC0(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXLOSSOFSYNC0(1),
            GlitchData    => RXLOSSOFSYNC01_GlitchData,
            OutSignalName => "RXLOSSOFSYNC0(1)",
            OutTemp       => RXLOSSOFSYNC0_out(1),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXLOSSOFSYNC0(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXLOSSOFSYNC1(0),
            GlitchData    => RXLOSSOFSYNC10_GlitchData,
            OutSignalName => "RXLOSSOFSYNC1(0)",
            OutTemp       => RXLOSSOFSYNC1_out(0),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXLOSSOFSYNC1(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXLOSSOFSYNC1(1),
            GlitchData    => RXLOSSOFSYNC11_GlitchData,
            OutSignalName => "RXLOSSOFSYNC1(1)",
            OutTemp       => RXLOSSOFSYNC1_out(1),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXLOSSOFSYNC1(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXNOTINTABLE0(0),
            GlitchData    => RXNOTINTABLE00_GlitchData,
            OutSignalName => "RXNOTINTABLE0(0)",
            OutTemp       => RXNOTINTABLE0_out(0),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXNOTINTABLE0(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXNOTINTABLE0(1),
            GlitchData    => RXNOTINTABLE01_GlitchData,
            OutSignalName => "RXNOTINTABLE0(1)",
            OutTemp       => RXNOTINTABLE0_out(1),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXNOTINTABLE0(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXNOTINTABLE0(2),
            GlitchData    => RXNOTINTABLE02_GlitchData,
            OutSignalName => "RXNOTINTABLE0(2)",
            OutTemp       => RXNOTINTABLE0_out(2),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXNOTINTABLE0(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXNOTINTABLE0(3),
            GlitchData    => RXNOTINTABLE03_GlitchData,
            OutSignalName => "RXNOTINTABLE0(3)",
            OutTemp       => RXNOTINTABLE0_out(3),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXNOTINTABLE0(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXNOTINTABLE1(0),
            GlitchData    => RXNOTINTABLE10_GlitchData,
            OutSignalName => "RXNOTINTABLE1(0)",
            OutTemp       => RXNOTINTABLE1_out(0),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXNOTINTABLE1(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXNOTINTABLE1(1),
            GlitchData    => RXNOTINTABLE11_GlitchData,
            OutSignalName => "RXNOTINTABLE1(1)",
            OutTemp       => RXNOTINTABLE1_out(1),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXNOTINTABLE1(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXNOTINTABLE1(2),
            GlitchData    => RXNOTINTABLE12_GlitchData,
            OutSignalName => "RXNOTINTABLE1(2)",
            OutTemp       => RXNOTINTABLE1_out(2),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXNOTINTABLE1(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXNOTINTABLE1(3),
            GlitchData    => RXNOTINTABLE13_GlitchData,
            OutSignalName => "RXNOTINTABLE1(3)",
            OutTemp       => RXNOTINTABLE1_out(3),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXNOTINTABLE1(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXPRBSERR0,
            GlitchData    => RXPRBSERR0_GlitchData,
            OutSignalName => "RXPRBSERR0",
            OutTemp       => RXPRBSERR0_out,
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXPRBSERR0,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXPRBSERR1,
            GlitchData    => RXPRBSERR1_GlitchData,
            OutSignalName => "RXPRBSERR1",
            OutTemp       => RXPRBSERR1_out,
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXPRBSERR1,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXRUNDISP0(0),
            GlitchData    => RXRUNDISP00_GlitchData,
            OutSignalName => "RXRUNDISP0(0)",
            OutTemp       => RXRUNDISP0_out(0),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXRUNDISP0(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXRUNDISP0(1),
            GlitchData    => RXRUNDISP01_GlitchData,
            OutSignalName => "RXRUNDISP0(1)",
            OutTemp       => RXRUNDISP0_out(1),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXRUNDISP0(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXRUNDISP0(2),
            GlitchData    => RXRUNDISP02_GlitchData,
            OutSignalName => "RXRUNDISP0(2)",
            OutTemp       => RXRUNDISP0_out(2),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXRUNDISP0(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXRUNDISP0(3),
            GlitchData    => RXRUNDISP03_GlitchData,
            OutSignalName => "RXRUNDISP0(3)",
            OutTemp       => RXRUNDISP0_out(3),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXRUNDISP0(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXRUNDISP1(0),
            GlitchData    => RXRUNDISP10_GlitchData,
            OutSignalName => "RXRUNDISP1(0)",
            OutTemp       => RXRUNDISP1_out(0),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXRUNDISP1(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXRUNDISP1(1),
            GlitchData    => RXRUNDISP11_GlitchData,
            OutSignalName => "RXRUNDISP1(1)",
            OutTemp       => RXRUNDISP1_out(1),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXRUNDISP1(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXRUNDISP1(2),
            GlitchData    => RXRUNDISP12_GlitchData,
            OutSignalName => "RXRUNDISP1(2)",
            OutTemp       => RXRUNDISP1_out(2),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXRUNDISP1(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXRUNDISP1(3),
            GlitchData    => RXRUNDISP13_GlitchData,
            OutSignalName => "RXRUNDISP1(3)",
            OutTemp       => RXRUNDISP1_out(3),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXRUNDISP1(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXSTATUS0(0),
            GlitchData    => RXSTATUS00_GlitchData,
            OutSignalName => "RXSTATUS0(0)",
            OutTemp       => RXSTATUS0_out(0),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXSTATUS0(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXSTATUS0(1),
            GlitchData    => RXSTATUS01_GlitchData,
            OutSignalName => "RXSTATUS0(1)",
            OutTemp       => RXSTATUS0_out(1),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXSTATUS0(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXSTATUS0(2),
            GlitchData    => RXSTATUS02_GlitchData,
            OutSignalName => "RXSTATUS0(2)",
            OutTemp       => RXSTATUS0_out(2),
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXSTATUS0(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXSTATUS1(0),
            GlitchData    => RXSTATUS10_GlitchData,
            OutSignalName => "RXSTATUS1(0)",
            OutTemp       => RXSTATUS1_out(0),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXSTATUS1(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXSTATUS1(1),
            GlitchData    => RXSTATUS11_GlitchData,
            OutSignalName => "RXSTATUS1(1)",
            OutTemp       => RXSTATUS1_out(1),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXSTATUS1(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXSTATUS1(2),
            GlitchData    => RXSTATUS12_GlitchData,
            OutSignalName => "RXSTATUS1(2)",
            OutTemp       => RXSTATUS1_out(2),
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXSTATUS1(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXVALID0,
            GlitchData    => RXVALID0_GlitchData,
            OutSignalName => "RXVALID0",
            OutTemp       => RXVALID0_out,
            Paths       => (0 => (RXUSRCLK20_dly'last_event, tpd_RXUSRCLK20_RXVALID0,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXVALID1,
            GlitchData    => RXVALID1_GlitchData,
            OutSignalName => "RXVALID1",
            OutTemp       => RXVALID1_out,
            Paths       => (0 => (RXUSRCLK21_dly'last_event, tpd_RXUSRCLK21_RXVALID1,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXBUFSTATUS0(0),
            GlitchData    => TXBUFSTATUS00_GlitchData,
            OutSignalName => "TXBUFSTATUS0(0)",
            OutTemp       => TXBUFSTATUS0_out(0),
            Paths       => (0 => (TXUSRCLK20_dly'last_event, tpd_TXUSRCLK20_TXBUFSTATUS0(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXBUFSTATUS0(1),
            GlitchData    => TXBUFSTATUS01_GlitchData,
            OutSignalName => "TXBUFSTATUS0(1)",
            OutTemp       => TXBUFSTATUS0_out(1),
            Paths       => (0 => (TXUSRCLK20_dly'last_event, tpd_TXUSRCLK20_TXBUFSTATUS0(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXBUFSTATUS1(0),
            GlitchData    => TXBUFSTATUS10_GlitchData,
            OutSignalName => "TXBUFSTATUS1(0)",
            OutTemp       => TXBUFSTATUS1_out(0),
            Paths       => (0 => (TXUSRCLK21_dly'last_event, tpd_TXUSRCLK21_TXBUFSTATUS1(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXBUFSTATUS1(1),
            GlitchData    => TXBUFSTATUS11_GlitchData,
            OutSignalName => "TXBUFSTATUS1(1)",
            OutTemp       => TXBUFSTATUS1_out(1),
            Paths       => (0 => (TXUSRCLK21_dly'last_event, tpd_TXUSRCLK21_TXBUFSTATUS1(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXKERR0(0),
            GlitchData    => TXKERR00_GlitchData,
            OutSignalName => "TXKERR0(0)",
            OutTemp       => TXKERR0_out(0),
            Paths       => (0 => (TXUSRCLK20_dly'last_event, tpd_TXUSRCLK20_TXKERR0(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXKERR0(1),
            GlitchData    => TXKERR01_GlitchData,
            OutSignalName => "TXKERR0(1)",
            OutTemp       => TXKERR0_out(1),
            Paths       => (0 => (TXUSRCLK20_dly'last_event, tpd_TXUSRCLK20_TXKERR0(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXKERR0(2),
            GlitchData    => TXKERR02_GlitchData,
            OutSignalName => "TXKERR0(2)",
            OutTemp       => TXKERR0_out(2),
            Paths       => (0 => (TXUSRCLK20_dly'last_event, tpd_TXUSRCLK20_TXKERR0(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXKERR0(3),
            GlitchData    => TXKERR03_GlitchData,
            OutSignalName => "TXKERR0(3)",
            OutTemp       => TXKERR0_out(3),
            Paths       => (0 => (TXUSRCLK20_dly'last_event, tpd_TXUSRCLK20_TXKERR0(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXKERR1(0),
            GlitchData    => TXKERR10_GlitchData,
            OutSignalName => "TXKERR1(0)",
            OutTemp       => TXKERR1_out(0),
            Paths       => (0 => (TXUSRCLK21_dly'last_event, tpd_TXUSRCLK21_TXKERR1(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXKERR1(1),
            GlitchData    => TXKERR11_GlitchData,
            OutSignalName => "TXKERR1(1)",
            OutTemp       => TXKERR1_out(1),
            Paths       => (0 => (TXUSRCLK21_dly'last_event, tpd_TXUSRCLK21_TXKERR1(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXKERR1(2),
            GlitchData    => TXKERR12_GlitchData,
            OutSignalName => "TXKERR1(2)",
            OutTemp       => TXKERR1_out(2),
            Paths       => (0 => (TXUSRCLK21_dly'last_event, tpd_TXUSRCLK21_TXKERR1(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXKERR1(3),
            GlitchData    => TXKERR13_GlitchData,
            OutSignalName => "TXKERR1(3)",
            OutTemp       => TXKERR1_out(3),
            Paths       => (0 => (TXUSRCLK21_dly'last_event, tpd_TXUSRCLK21_TXKERR1(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXRUNDISP0(0),
            GlitchData    => TXRUNDISP00_GlitchData,
            OutSignalName => "TXRUNDISP0(0)",
            OutTemp       => TXRUNDISP0_out(0),
            Paths       => (0 => (TXUSRCLK20_dly'last_event, tpd_TXUSRCLK20_TXRUNDISP0(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXRUNDISP0(1),
            GlitchData    => TXRUNDISP01_GlitchData,
            OutSignalName => "TXRUNDISP0(1)",
            OutTemp       => TXRUNDISP0_out(1),
            Paths       => (0 => (TXUSRCLK20_dly'last_event, tpd_TXUSRCLK20_TXRUNDISP0(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXRUNDISP0(2),
            GlitchData    => TXRUNDISP02_GlitchData,
            OutSignalName => "TXRUNDISP0(2)",
            OutTemp       => TXRUNDISP0_out(2),
            Paths       => (0 => (TXUSRCLK20_dly'last_event, tpd_TXUSRCLK20_TXRUNDISP0(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXRUNDISP0(3),
            GlitchData    => TXRUNDISP03_GlitchData,
            OutSignalName => "TXRUNDISP0(3)",
            OutTemp       => TXRUNDISP0_out(3),
            Paths       => (0 => (TXUSRCLK20_dly'last_event, tpd_TXUSRCLK20_TXRUNDISP0(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXRUNDISP1(0),
            GlitchData    => TXRUNDISP10_GlitchData,
            OutSignalName => "TXRUNDISP1(0)",
            OutTemp       => TXRUNDISP1_out(0),
            Paths       => (0 => (TXUSRCLK21_dly'last_event, tpd_TXUSRCLK21_TXRUNDISP1(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXRUNDISP1(1),
            GlitchData    => TXRUNDISP11_GlitchData,
            OutSignalName => "TXRUNDISP1(1)",
            OutTemp       => TXRUNDISP1_out(1),
            Paths       => (0 => (TXUSRCLK21_dly'last_event, tpd_TXUSRCLK21_TXRUNDISP1(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXRUNDISP1(2),
            GlitchData    => TXRUNDISP12_GlitchData,
            OutSignalName => "TXRUNDISP1(2)",
            OutTemp       => TXRUNDISP1_out(2),
            Paths       => (0 => (TXUSRCLK21_dly'last_event, tpd_TXUSRCLK21_TXRUNDISP1(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXRUNDISP1(3),
            GlitchData    => TXRUNDISP13_GlitchData,
            OutSignalName => "TXRUNDISP1(3)",
            OutTemp       => TXRUNDISP1_out(3),
            Paths       => (0 => (TXUSRCLK21_dly'last_event, tpd_TXUSRCLK21_TXRUNDISP1(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_CLK00,
            PeriodData     => PInfo_CLK00,
            TestSignal     => CLK00_dly,
            TestSignalName => "CLK00",
            TestDelay      => 0 ps,
            Period         => tperiod_CLK00_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_CLK01,
            PeriodData     => PInfo_CLK01,
            TestSignal     => CLK01_dly,
            TestSignalName => "CLK01",
            TestDelay      => 0 ps,
            Period         => tperiod_CLK01_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_CLK10,
            PeriodData     => PInfo_CLK10,
            TestSignal     => CLK10_dly,
            TestSignalName => "CLK10",
            TestDelay      => 0 ps,
            Period         => tperiod_CLK10_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_CLK11,
            PeriodData     => PInfo_CLK11,
            TestSignal     => CLK11_dly,
            TestSignalName => "CLK11",
            TestDelay      => 0 ps,
            Period         => tperiod_CLK11_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_CLKINEAST0,
            PeriodData     => PInfo_CLKINEAST0,
            TestSignal     => CLKINEAST0_dly,
            TestSignalName => "CLKINEAST0",
            TestDelay      => 0 ps,
            Period         => tperiod_CLKINEAST0_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_CLKINEAST1,
            PeriodData     => PInfo_CLKINEAST1,
            TestSignal     => CLKINEAST1_dly,
            TestSignalName => "CLKINEAST1",
            TestDelay      => 0 ps,
            Period         => tperiod_CLKINEAST1_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_CLKINWEST0,
            PeriodData     => PInfo_CLKINWEST0,
            TestSignal     => CLKINWEST0_dly,
            TestSignalName => "CLKINWEST0",
            TestDelay      => 0 ps,
            Period         => tperiod_CLKINWEST0_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_CLKINWEST1,
            PeriodData     => PInfo_CLKINWEST1,
            TestSignal     => CLKINWEST1_dly,
            TestSignalName => "CLKINWEST1",
            TestDelay      => 0 ps,
            Period         => tperiod_CLKINWEST1_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_DCLK,
            PeriodData     => PInfo_DCLK,
            TestSignal     => DCLK_dly,
            TestSignalName => "DCLK",
            TestDelay      => 0 ps,
            Period         => tperiod_DCLK_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_GCLK00,
            PeriodData     => PInfo_GCLK00,
            TestSignal     => GCLK00_dly,
            TestSignalName => "GCLK00",
            TestDelay      => 0 ps,
            Period         => tperiod_GCLK00_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_GCLK01,
            PeriodData     => PInfo_GCLK01,
            TestSignal     => GCLK01_dly,
            TestSignalName => "GCLK01",
            TestDelay      => 0 ps,
            Period         => tperiod_GCLK01_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_GCLK10,
            PeriodData     => PInfo_GCLK10,
            TestSignal     => GCLK10_dly,
            TestSignalName => "GCLK10",
            TestDelay      => 0 ps,
            Period         => tperiod_GCLK10_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_GCLK11,
            PeriodData     => PInfo_GCLK11,
            TestSignal     => GCLK11_dly,
            TestSignalName => "GCLK11",
            TestDelay      => 0 ps,
            Period         => tperiod_GCLK11_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_PLLCLK00,
            PeriodData     => PInfo_PLLCLK00,
            TestSignal     => PLLCLK00_dly,
            TestSignalName => "PLLCLK00",
            TestDelay      => 0 ps,
            Period         => tperiod_PLLCLK00_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_PLLCLK01,
            PeriodData     => PInfo_PLLCLK01,
            TestSignal     => PLLCLK01_dly,
            TestSignalName => "PLLCLK01",
            TestDelay      => 0 ps,
            Period         => tperiod_PLLCLK01_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_PLLCLK10,
            PeriodData     => PInfo_PLLCLK10,
            TestSignal     => PLLCLK10_dly,
            TestSignalName => "PLLCLK10",
            TestDelay      => 0 ps,
            Period         => tperiod_PLLCLK10_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_PLLCLK11,
            PeriodData     => PInfo_PLLCLK11,
            TestSignal     => PLLCLK11_dly,
            TestSignalName => "PLLCLK11",
            TestDelay      => 0 ps,
            Period         => tperiod_PLLCLK11_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_RXUSRCLK0,
            PeriodData     => PInfo_RXUSRCLK0,
            TestSignal     => RXUSRCLK0_dly,
            TestSignalName => "RXUSRCLK0",
            TestDelay      => 0 ps,
            Period         => tperiod_RXUSRCLK0_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_RXUSRCLK1,
            PeriodData     => PInfo_RXUSRCLK1,
            TestSignal     => RXUSRCLK1_dly,
            TestSignalName => "RXUSRCLK1",
            TestDelay      => 0 ps,
            Period         => tperiod_RXUSRCLK1_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_RXUSRCLK20,
            PeriodData     => PInfo_RXUSRCLK20,
            TestSignal     => RXUSRCLK20_dly,
            TestSignalName => "RXUSRCLK20",
            TestDelay      => 0 ps,
            Period         => tperiod_RXUSRCLK20_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_RXUSRCLK21,
            PeriodData     => PInfo_RXUSRCLK21,
            TestSignal     => RXUSRCLK21_dly,
            TestSignalName => "RXUSRCLK21",
            TestDelay      => 0 ps,
            Period         => tperiod_RXUSRCLK21_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_TSTCLK0,
            PeriodData     => PInfo_TSTCLK0,
            TestSignal     => TSTCLK0_dly,
            TestSignalName => "TSTCLK0",
            TestDelay      => 0 ps,
            Period         => tperiod_TSTCLK0_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_TSTCLK1,
            PeriodData     => PInfo_TSTCLK1,
            TestSignal     => TSTCLK1_dly,
            TestSignalName => "TSTCLK1",
            TestDelay      => 0 ps,
            Period         => tperiod_TSTCLK1_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_TXUSRCLK0,
            PeriodData     => PInfo_TXUSRCLK0,
            TestSignal     => TXUSRCLK0_dly,
            TestSignalName => "TXUSRCLK0",
            TestDelay      => 0 ps,
            Period         => tperiod_TXUSRCLK0_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_TXUSRCLK1,
            PeriodData     => PInfo_TXUSRCLK1,
            TestSignal     => TXUSRCLK1_dly,
            TestSignalName => "TXUSRCLK1",
            TestDelay      => 0 ps,
            Period         => tperiod_TXUSRCLK1_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_TXUSRCLK20,
            PeriodData     => PInfo_TXUSRCLK20,
            TestSignal     => TXUSRCLK20_dly,
            TestSignalName => "TXUSRCLK20",
            TestDelay      => 0 ps,
            Period         => tperiod_TXUSRCLK20_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_TXUSRCLK21,
            PeriodData     => PInfo_TXUSRCLK21,
            TestSignal     => TXUSRCLK21_dly,
            TestSignalName => "TXUSRCLK21",
            TestDelay      => 0 ps,
            Period         => tperiod_TXUSRCLK21_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTPA1_DUAL",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
        wait on
        DRDY_out,
        DRPDO_out,
        GTPCLKFBEAST_out,
        GTPCLKFBWEST_out,
        GTPCLKOUT0_out,
        GTPCLKOUT1_out,
        PHYSTATUS0_out,
        PHYSTATUS1_out,
        PLLLKDET0_out,
        PLLLKDET1_out,
        RCALOUTEAST_out,
        RCALOUTWEST_out,
        REFCLKOUT0_out,
        REFCLKOUT1_out,
        REFCLKPLL0_out,
        REFCLKPLL1_out,
        RESETDONE0_out,
        RESETDONE1_out,
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
        RXCHBONDO_out,
        RXCLKCORCNT0_out,
        RXCLKCORCNT1_out,
        RXCOMMADET0_out,
        RXCOMMADET1_out,
        RXDATA0_out,
        RXDATA1_out,
        RXDISPERR0_out,
        RXDISPERR1_out,
        RXELECIDLE0_out,
        RXELECIDLE1_out,
        RXLOSSOFSYNC0_out,
        RXLOSSOFSYNC1_out,
        RXNOTINTABLE0_out,
        RXNOTINTABLE1_out,
        RXPRBSERR0_out,
        RXPRBSERR1_out,
        RXRECCLK0_out,
        RXRECCLK1_out,
        RXRUNDISP0_out,
        RXRUNDISP1_out,
        RXSTATUS0_out,
        RXSTATUS1_out,
        RXVALID0_out,
        RXVALID1_out,
        TSTOUT0_out,
        TSTOUT1_out,
        TXBUFSTATUS0_out,
        TXBUFSTATUS1_out,
        TXKERR0_out,
        TXKERR1_out,
        TXN0_out,
        TXN1_out,
        TXOUTCLK0_out,
        TXOUTCLK1_out,
        TXP0_out,
        TXP1_out,
        TXRUNDISP0_out,
        TXRUNDISP1_out,
        DADDR_DCLK_dly,
        DEN_DCLK_dly,
        DI_DCLK_dly,
        DWE_DCLK_dly,
        PRBSCNTRESET0_RXUSRCLK20_dly,
        PRBSCNTRESET1_RXUSRCLK21_dly,
        RXCHBONDI_RXUSRCLK0_dly,
        RXCHBONDI_RXUSRCLK1_dly,
        RXCHBONDMASTER0_RXUSRCLK20_dly,
        RXCHBONDMASTER1_RXUSRCLK21_dly,
        RXCHBONDSLAVE0_RXUSRCLK20_dly,
        RXCHBONDSLAVE1_RXUSRCLK21_dly,
        RXCOMMADETUSE0_RXUSRCLK20_dly,
        RXCOMMADETUSE1_RXUSRCLK21_dly,
        RXDEC8B10BUSE0_RXUSRCLK20_dly,
        RXDEC8B10BUSE1_RXUSRCLK21_dly,
        RXENCHANSYNC0_RXUSRCLK20_dly,
        RXENCHANSYNC1_RXUSRCLK21_dly,
        RXENMCOMMAALIGN0_RXUSRCLK20_dly,
        RXENMCOMMAALIGN1_RXUSRCLK21_dly,
        RXENPCOMMAALIGN0_RXUSRCLK20_dly,
        RXENPCOMMAALIGN1_RXUSRCLK21_dly,
        RXENPRBSTST0_RXUSRCLK20_dly,
        RXENPRBSTST1_RXUSRCLK21_dly,
        RXPOLARITY0_RXUSRCLK20_dly,
        RXPOLARITY1_RXUSRCLK21_dly,
        RXSLIDE0_RXUSRCLK20_dly,
        RXSLIDE1_RXUSRCLK21_dly,
        TXBYPASS8B10B0_TXUSRCLK20_dly,
        TXBYPASS8B10B1_TXUSRCLK21_dly,
        TXCHARDISPMODE0_TXUSRCLK20_dly,
        TXCHARDISPMODE1_TXUSRCLK21_dly,
        TXCHARDISPVAL0_TXUSRCLK20_dly,
        TXCHARDISPVAL1_TXUSRCLK21_dly,
        TXCHARISK0_TXUSRCLK20_dly,
        TXCHARISK1_TXUSRCLK21_dly,
        TXCOMSTART0_TXUSRCLK20_dly,
        TXCOMSTART1_TXUSRCLK21_dly,
        TXCOMTYPE0_TXUSRCLK20_dly,
        TXCOMTYPE1_TXUSRCLK21_dly,
        TXDATA0_TXUSRCLK20_dly,
        TXDATA1_TXUSRCLK21_dly,
        TXDETECTRX0_TXUSRCLK20_dly,
        TXDETECTRX1_TXUSRCLK21_dly,
        TXELECIDLE0_TXUSRCLK20_dly,
        TXELECIDLE1_TXUSRCLK21_dly,
        TXENC8B10BUSE0_TXUSRCLK20_dly,
        TXENC8B10BUSE1_TXUSRCLK21_dly,
        TXENPRBSTST0_TXUSRCLK20_dly,
        TXENPRBSTST1_TXUSRCLK21_dly,
        TXINHIBIT0_TXUSRCLK20_dly,
        TXINHIBIT1_TXUSRCLK21_dly,
        TXPOLARITY0_TXUSRCLK20_dly,
        TXPOLARITY1_TXUSRCLK21_dly,
        TXPOWERDOWN0_TXUSRCLK20_dly,
        TXPOWERDOWN1_TXUSRCLK21_dly,
        TXPRBSFORCEERR0_TXUSRCLK20_dly,
        TXPRBSFORCEERR1_TXUSRCLK21_dly,
        USRCODEERR0_RXUSRCLK20_dly,
        USRCODEERR1_RXUSRCLK21_dly;
    end process TIMING;
    GTPCLKFBEAST <= GTPCLKFBEAST_out;
    GTPCLKFBWEST <= GTPCLKFBWEST_out;
    GTPCLKOUT0 <= GTPCLKOUT0_out;
    GTPCLKOUT1 <= GTPCLKOUT1_out;
    PLLLKDET0 <= PLLLKDET0_out;
    PLLLKDET1 <= PLLLKDET1_out;
    RCALOUTEAST <= RCALOUTEAST_out;
    RCALOUTWEST <= RCALOUTWEST_out;
    REFCLKOUT0 <= REFCLKOUT0_out;
    REFCLKOUT1 <= REFCLKOUT1_out;
    RESETDONE0 <= RESETDONE0_out;
    RESETDONE1 <= RESETDONE1_out;
    RXELECIDLE0 <= RXELECIDLE0_out;
    RXELECIDLE1 <= RXELECIDLE1_out;
    RXRECCLK0 <= RXRECCLK0_out;
    RXRECCLK1 <= RXRECCLK1_out;
    TSTOUT0 <= TSTOUT0_out;
    TSTOUT1 <= TSTOUT1_out;
    TXN0 <= TXN0_out;
    TXN1 <= TXN1_out;
    TXOUTCLK0 <= TXOUTCLK0_out;
    TXOUTCLK1 <= TXOUTCLK1_out;
    TXP0 <= TXP0_out;
    TXP1 <= TXP1_out;
  end X_GTPA1_DUAL_V;

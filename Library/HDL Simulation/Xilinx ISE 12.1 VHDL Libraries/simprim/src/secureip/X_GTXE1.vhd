-------------------------------------------------------
--  Copyright (c) 2010 Xilinx Inc.
--  All Right Reserved.
-------------------------------------------------------
--
--   ____  ____
--  /   /\/   / 
-- /___/  \  /     Vendor      : Xilinx 
-- \   \   \/      Version : 11.1
--  \   \          Description :  Xilinx Simulation Library Component
--  /   /                      : Gigabit Transceiver
-- /___/   /\      Filename    : X_GTXE1.vhd
-- \   \  /  \      
--  \__ \/\__ \                   
--                                 
--  Revision: 1.0
--  10/24/08 - CR1014 - Initial version
--  11/14/08 - CR495047 - Add DRC checks
--  11/17/08 - CR496607 - convert bit_vector to string for VHDL simulation
--  11/19/08 - CR497301 - YML update for parameter default value 
--  12/23/08 - 1014 - YML update for period checks 
--  01/07/09 - 1014 - Work around for period checks (2 bit clocks) 
--  02/01/09 - CR505584 - Add Pathdelays for bused clock ports
--  02/11/09 - CR507680 - GTXE1 Attribute default changes
--  03/11/09 - CR511750 - Update attribute value to upper case
--  03/24/09 - CR514739 - PMA attribute default update
--  05/05/09 - CR520565 - TXUSRCLK connectivity added
--  05/13/09 - CR521563 - Attribute POWER_SAVE default change
--  07/28/09 - CR528324 - Default Attribute YML updates
--  08/13/09 - CR530897 - writer bug, update TX_PMADATA_OPT bit_vector to bit
--  09/22/09 - CR532191 - YML update to add RXPRBSERR_LOOPBACK, SIM_VERSION updated to "2.0", add input RXDLYALIGNMONENB/TXDLYALIGNMONENB
--  10/13/09 - CR535495 - Add default value for new pins RXDLYALIGNMONENB/TXDLYALIGNMONENB
--  03/04/10 - CR552249 - Attribute updates - YML & RTL updated
-------------------------------------------------------

----- CELL X_GTXE1 -----

library IEEE;
use IEEE.STD_LOGIC_arith.all;
use IEEE.STD_LOGIC_1164.all;
library IEEE;
use IEEE.VITAL_Timing.all;

library simprim;
use simprim.VCOMPONENTS.all; 

library secureip; 
use secureip.all; 
use simprim.VPACKAGE.all;

  entity X_GTXE1 is
    generic (
      TimingChecksOn : boolean := TRUE;
      InstancePath   : string  := "*";
      Xon            : boolean := TRUE;
      MsgOn          : boolean := FALSE;
      LOC            : string  := "UNPLACED";

      AC_CAP_DIS : boolean := TRUE;
      ALIGN_COMMA_WORD : integer := 1;
      BGTEST_CFG : bit_vector := "00";
      BIAS_CFG : bit_vector := X"00000";
      CDR_PH_ADJ_TIME : bit_vector := "10100";
      CHAN_BOND_1_MAX_SKEW : integer := 7;
      CHAN_BOND_2_MAX_SKEW : integer := 1;
      CHAN_BOND_KEEP_ALIGN : boolean := FALSE;
      CHAN_BOND_SEQ_1_1 : bit_vector := "0101111100";
      CHAN_BOND_SEQ_1_2 : bit_vector := "0001001010";
      CHAN_BOND_SEQ_1_3 : bit_vector := "0001001010";
      CHAN_BOND_SEQ_1_4 : bit_vector := "0110111100";
      CHAN_BOND_SEQ_1_ENABLE : bit_vector := "1111";
      CHAN_BOND_SEQ_2_1 : bit_vector := "0100111100";
      CHAN_BOND_SEQ_2_2 : bit_vector := "0100111100";
      CHAN_BOND_SEQ_2_3 : bit_vector := "0110111100";
      CHAN_BOND_SEQ_2_4 : bit_vector := "0100111100";
      CHAN_BOND_SEQ_2_CFG : bit_vector := "00000";
      CHAN_BOND_SEQ_2_ENABLE : bit_vector := "1111";
      CHAN_BOND_SEQ_2_USE : boolean := FALSE;
      CHAN_BOND_SEQ_LEN : integer := 1;
      CLK_CORRECT_USE : boolean := TRUE;
      CLK_COR_ADJ_LEN : integer := 1;
      CLK_COR_DET_LEN : integer := 1;
      CLK_COR_INSERT_IDLE_FLAG : boolean := FALSE;
      CLK_COR_KEEP_IDLE : boolean := FALSE;
      CLK_COR_MAX_LAT : integer := 20;
      CLK_COR_MIN_LAT : integer := 18;
      CLK_COR_PRECEDENCE : boolean := TRUE;
      CLK_COR_REPEAT_WAIT : integer := 0;
      CLK_COR_SEQ_1_1 : bit_vector := "0100011100";
      CLK_COR_SEQ_1_2 : bit_vector := "0000000000";
      CLK_COR_SEQ_1_3 : bit_vector := "0000000000";
      CLK_COR_SEQ_1_4 : bit_vector := "0000000000";
      CLK_COR_SEQ_1_ENABLE : bit_vector := "1111";
      CLK_COR_SEQ_2_1 : bit_vector := "0000000000";
      CLK_COR_SEQ_2_2 : bit_vector := "0000000000";
      CLK_COR_SEQ_2_3 : bit_vector := "0000000000";
      CLK_COR_SEQ_2_4 : bit_vector := "0000000000";
      CLK_COR_SEQ_2_ENABLE : bit_vector := "1111";
      CLK_COR_SEQ_2_USE : boolean := FALSE;
      CM_TRIM : bit_vector := "01";
      COMMA_10B_ENABLE : bit_vector := "1111111111";
      COMMA_DOUBLE : boolean := FALSE;
      COM_BURST_VAL : bit_vector := "1111";
      DEC_MCOMMA_DETECT : boolean := TRUE;
      DEC_PCOMMA_DETECT : boolean := TRUE;
      DEC_VALID_COMMA_ONLY : boolean := TRUE;
      DFE_CAL_TIME : bit_vector := "01100";
      DFE_CFG : bit_vector := "00011011";
      GEARBOX_ENDEC : bit_vector := "000";
      GEN_RXUSRCLK : boolean := TRUE;
      GEN_TXUSRCLK : boolean := TRUE;
      GTX_CFG_PWRUP : boolean := TRUE;
      MCOMMA_10B_VALUE : bit_vector := "1010000011";
      MCOMMA_DETECT : boolean := TRUE;
      OOBDETECT_THRESHOLD : bit_vector := "011";
      PCI_EXPRESS_MODE : boolean := FALSE;
      PCOMMA_10B_VALUE : bit_vector := "0101111100";
      PCOMMA_DETECT : boolean := TRUE;
      PMA_CAS_CLK_EN : boolean := FALSE;
      PMA_CDR_SCAN : bit_vector := X"640404C";
      PMA_CFG : bit_vector :=  X"0040000040000000003";
      PMA_RXSYNC_CFG : bit_vector := X"00";
      PMA_RX_CFG : bit_vector := X"05CE048";
      PMA_TX_CFG : bit_vector := X"00082";
      POWER_SAVE : bit_vector := "0000110100";
      RCV_TERM_GND : boolean := FALSE;
      RCV_TERM_VTTRX : boolean := TRUE;
      RXGEARBOX_USE : boolean := FALSE;
      RXPLL_COM_CFG : bit_vector := X"21680A";
      RXPLL_CP_CFG : bit_vector := X"00";
      RXPLL_DIVSEL45_FB : integer := 5;
      RXPLL_DIVSEL_FB : integer := 2;
      RXPLL_DIVSEL_OUT : integer := 1;
      RXPLL_DIVSEL_REF : integer := 1;
      RXPLL_LKDET_CFG : bit_vector := "111";
      RXPRBSERR_LOOPBACK : bit := '0';
      RXRECCLK_CTRL : string := "RXRECCLKPCS";
      RXRECCLK_DLY : bit_vector := "0000000000";
      RXUSRCLK_DLY : bit_vector := X"0000";
      RX_BUFFER_USE : boolean := TRUE;
      RX_CLK25_DIVIDER : integer := 6;
      RX_DATA_WIDTH : integer := 20;
      RX_DECODE_SEQ_MATCH : boolean := TRUE;
      RX_DLYALIGN_CTRINC : bit_vector := "0100";
      RX_DLYALIGN_EDGESET : bit_vector := "00110";
      RX_DLYALIGN_LPFINC : bit_vector := "0111";
      RX_DLYALIGN_MONSEL : bit_vector := "000";
      RX_DLYALIGN_OVRDSETTING : bit_vector := "00000000";
      RX_EN_IDLE_HOLD_CDR : boolean := FALSE;
      RX_EN_IDLE_HOLD_DFE : boolean := TRUE;
      RX_EN_IDLE_RESET_BUF : boolean := TRUE;
      RX_EN_IDLE_RESET_FR : boolean := TRUE;
      RX_EN_IDLE_RESET_PH : boolean := TRUE;
      RX_EN_MODE_RESET_BUF : boolean := TRUE;
      RX_EN_RATE_RESET_BUF : boolean := TRUE;
      RX_EN_REALIGN_RESET_BUF : boolean := FALSE;
      RX_EN_REALIGN_RESET_BUF2 : boolean := FALSE;
      RX_EYE_OFFSET : bit_vector := X"4C";
      RX_EYE_SCANMODE : bit_vector := "00";
      RX_FIFO_ADDR_MODE : string := "FULL";
      RX_IDLE_HI_CNT : bit_vector := "1000";
      RX_IDLE_LO_CNT : bit_vector := "0000";
      RX_LOSS_OF_SYNC_FSM : boolean := FALSE;
      RX_LOS_INVALID_INCR : integer := 1;
      RX_LOS_THRESHOLD : integer := 4;
      RX_OVERSAMPLE_MODE : boolean := FALSE;
      RX_SLIDE_AUTO_WAIT : integer := 5;
      RX_SLIDE_MODE : string := "OFF";
      RX_XCLK_SEL : string := "RXREC";
      SAS_MAX_COMSAS : integer := 52;
      SAS_MIN_COMSAS : integer := 40;
      SATA_BURST_VAL : bit_vector := "100";
      SATA_IDLE_VAL : bit_vector := "100";
      SATA_MAX_BURST : integer := 7;
      SATA_MAX_INIT : integer := 22;
      SATA_MAX_WAKE : integer := 7;
      SATA_MIN_BURST : integer := 4;
      SATA_MIN_INIT : integer := 12;
      SATA_MIN_WAKE : integer := 4;
      SHOW_REALIGN_COMMA : boolean := TRUE;
      SIM_GTXRESET_SPEEDUP : integer := 1;
      SIM_RECEIVER_DETECT_PASS : boolean := TRUE;
      SIM_RXREFCLK_SOURCE : bit_vector := "000";
      SIM_TXREFCLK_SOURCE : bit_vector := "000";
      SIM_TX_ELEC_IDLE_LEVEL : string := "X";
      SIM_VERSION : string := "2.0";
      TERMINATION_CTRL : bit_vector := "10100";
      TERMINATION_OVRD : boolean := FALSE;
      TRANS_TIME_FROM_P2 : bit_vector := X"03C";
      TRANS_TIME_NON_P2 : bit_vector := X"19";
      TRANS_TIME_RATE : bit_vector := X"0E";
      TRANS_TIME_TO_P2 : bit_vector := X"064";
      TST_ATTR : bit_vector := X"00000000";
      TXDRIVE_LOOPBACK_HIZ : boolean := FALSE;
      TXDRIVE_LOOPBACK_PD : boolean := FALSE;
      TXGEARBOX_USE : boolean := FALSE;
      TXOUTCLK_CTRL : string := "TXOUTCLKPCS";
      TXOUTCLK_DLY : bit_vector := "0000000000";
      TXPLL_COM_CFG : bit_vector := X"21680A";
      TXPLL_CP_CFG : bit_vector := X"00";
      TXPLL_DIVSEL45_FB : integer := 5;
      TXPLL_DIVSEL_FB : integer := 2;
      TXPLL_DIVSEL_OUT : integer := 1;
      TXPLL_DIVSEL_REF : integer := 1;
      TXPLL_LKDET_CFG : bit_vector := "111";
      TXPLL_SATA : bit_vector := "00";
      TX_BUFFER_USE : boolean := TRUE;
      TX_BYTECLK_CFG : bit_vector := X"00";
      TX_CLK25_DIVIDER : integer := 6;
      TX_CLK_SOURCE : string := "RXPLL";
      TX_DATA_WIDTH : integer := 20;
      TX_DEEMPH_0 : bit_vector := "11010";
      TX_DEEMPH_1 : bit_vector := "10000";
      TX_DETECT_RX_CFG : bit_vector := X"1832";
      TX_DLYALIGN_CTRINC : bit_vector := "0100";
      TX_DLYALIGN_LPFINC : bit_vector := "0110";
      TX_DLYALIGN_MONSEL : bit_vector := "000";
      TX_DLYALIGN_OVRDSETTING : bit_vector := "10000000";
      TX_DRIVE_MODE : string := "DIRECT";
      TX_EN_RATE_RESET_BUF : boolean := TRUE;
      TX_IDLE_ASSERT_DELAY : bit_vector := "100";
      TX_IDLE_DEASSERT_DELAY : bit_vector := "010";
      TX_MARGIN_FULL_0 : bit_vector := "1001110";
      TX_MARGIN_FULL_1 : bit_vector := "1001001";
      TX_MARGIN_FULL_2 : bit_vector := "1000101";
      TX_MARGIN_FULL_3 : bit_vector := "1000010";
      TX_MARGIN_FULL_4 : bit_vector := "1000000";
      TX_MARGIN_LOW_0 : bit_vector := "1000110";
      TX_MARGIN_LOW_1 : bit_vector := "1000100";
      TX_MARGIN_LOW_2 : bit_vector := "1000010";
      TX_MARGIN_LOW_3 : bit_vector := "1000000";
      TX_MARGIN_LOW_4 : bit_vector := "1000000";
      TX_OVERSAMPLE_MODE : boolean := FALSE;
      TX_PMADATA_OPT : bit := '0';
      TX_TDCC_CFG : bit_vector := "11";
      TX_USRCLK_CFG : bit_vector := X"00";
      TX_XCLK_SEL : string := "TXUSR";

      tipd_DADDR : VitalDelayArrayType01 (7 downto 0) := (others => (0 ps, 0 ps));
      tipd_DCLK : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_DEN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_DFECLKDLYADJ : VitalDelayArrayType01 (5 downto 0) := (others => (0 ps, 0 ps));
      tipd_DFEDLYOVRD : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_DFETAP1 : VitalDelayArrayType01 (4 downto 0) := (others => (0 ps, 0 ps));
      tipd_DFETAP2 : VitalDelayArrayType01 (4 downto 0) := (others => (0 ps, 0 ps));
      tipd_DFETAP3 : VitalDelayArrayType01 (3 downto 0) := (others => (0 ps, 0 ps));
      tipd_DFETAP4 : VitalDelayArrayType01 (3 downto 0) := (others => (0 ps, 0 ps));
      tipd_DFETAPOVRD : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_DI : VitalDelayArrayType01 (15 downto 0) := (others => (0 ps, 0 ps));
      tipd_DWE : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_GATERXELECIDLE : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_GREFCLKRX : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_GREFCLKTX : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_GTXRXRESET : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_GTXTEST : VitalDelayArrayType01 (12 downto 0) := (others => (0 ps, 0 ps));
      tipd_GTXTXRESET : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_IGNORESIGDET : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_LOOPBACK : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_MGTREFCLKRX : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_MGTREFCLKTX : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_NORTHREFCLKRX : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_NORTHREFCLKTX : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_PERFCLKRX : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PERFCLKTX : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PLLRXRESET : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PLLTXRESET : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PRBSCNTRESET : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXBUFRESET : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXCDRRESET : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXCHBONDI : VitalDelayArrayType01 (3 downto 0) := (others => (0 ps, 0 ps));
      tipd_RXCHBONDLEVEL : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_RXCHBONDMASTER : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXCHBONDSLAVE : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXCOMMADETUSE : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXDEC8B10BUSE : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXDLYALIGNDISABLE : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXDLYALIGNMONENB : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXDLYALIGNOVERRIDE : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXDLYALIGNRESET : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXDLYALIGNSWPPRECURB : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXDLYALIGNUPDSW : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXENCHANSYNC : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXENMCOMMAALIGN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXENPCOMMAALIGN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXENPMAPHASEALIGN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXENPRBSTST : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_RXENSAMPLEALIGN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXEQMIX : VitalDelayArrayType01 (9 downto 0) := (others => (0 ps, 0 ps));
      tipd_RXGEARBOXSLIP : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXP : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXPLLLKDETEN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXPLLPOWERDOWN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXPLLREFSELDY : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_RXPMASETPHASE : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXPOLARITY : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXPOWERDOWN : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_RXRATE : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_RXRESET : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXSLIDE : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXUSRCLK : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXUSRCLK2 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_SOUTHREFCLKRX : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_SOUTHREFCLKTX : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_TSTCLK0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TSTCLK1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TSTIN : VitalDelayArrayType01 (19 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXBUFDIFFCTRL : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXBYPASS8B10B : VitalDelayArrayType01 (3 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXCHARDISPMODE : VitalDelayArrayType01 (3 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXCHARDISPVAL : VitalDelayArrayType01 (3 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXCHARISK : VitalDelayArrayType01 (3 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXCOMINIT : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXCOMSAS : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXCOMWAKE : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXDATA : VitalDelayArrayType01 (31 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXDEEMPH : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXDETECTRX : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXDIFFCTRL : VitalDelayArrayType01 (3 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXDLYALIGNDISABLE : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXDLYALIGNMONENB : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXDLYALIGNOVERRIDE : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXDLYALIGNRESET : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXDLYALIGNUPDSW : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXELECIDLE : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXENC8B10BUSE : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXENPMAPHASEALIGN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXENPRBSTST : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXHEADER : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXINHIBIT : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXMARGIN : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXPDOWNASYNCH : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXPLLLKDETEN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXPLLPOWERDOWN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXPLLREFSELDY : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXPMASETPHASE : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXPOLARITY : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXPOSTEMPHASIS : VitalDelayArrayType01 (4 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXPOWERDOWN : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXPRBSFORCEERR : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXPREEMPHASIS : VitalDelayArrayType01 (3 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXRATE : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXRESET : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXSEQUENCE : VitalDelayArrayType01 (6 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXSTARTSEQ : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXSWING : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXUSRCLK : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXUSRCLK2 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_USRCODEERR : VitalDelayType01 :=  (0 ps, 0 ps);
      tpd_DCLK_DRDY : VitalDelayType01 := (0 ps, 0 ps);
      tpd_DCLK_DRPDO : VitalDelayArrayType01(15 downto 0) := (others => (0 ps, 0 ps));
--      tpd_MGTREFCLKRX_MGTREFCLKFAB : VitalDelayArrayType01(1 downto 0) := (others => (0 ps, 0 ps));
--      tpd_MGTREFCLKTX_MGTREFCLKFAB : VitalDelayArrayType01(1 downto 0) := (others => (0 ps, 0 ps));
--      tpd_NORTHREFCLKRX_MGTREFCLKFAB : VitalDelayArrayType01(1 downto 0) := (others => (0 ps, 0 ps));
--      tpd_NORTHREFCLKTX_MGTREFCLKFAB : VitalDelayArrayType01(1 downto 0) := (others => (0 ps, 0 ps));
      tpd_MGTREFCLKRX_MGTREFCLKFAB : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
      tpd_MGTREFCLKTX_MGTREFCLKFAB : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
      tpd_NORTHREFCLKRX_MGTREFCLKFAB : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
      tpd_NORTHREFCLKTX_MGTREFCLKFAB : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSRCLK2_COMINITDET : VitalDelayType01 := (0 ps, 0 ps);
      tpd_RXUSRCLK2_COMSASDET : VitalDelayType01 := (0 ps, 0 ps);
      tpd_RXUSRCLK2_COMWAKEDET : VitalDelayType01 := (0 ps, 0 ps);
      tpd_RXUSRCLK2_DFECLKDLYADJMON : VitalDelayArrayType01(5 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSRCLK2_DFEEYEDACMON : VitalDelayArrayType01(4 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSRCLK2_DFESENSCAL : VitalDelayArrayType01(2 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSRCLK2_DFETAP1MONITOR : VitalDelayArrayType01(4 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSRCLK2_DFETAP2MONITOR : VitalDelayArrayType01(4 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSRCLK2_DFETAP3MONITOR : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSRCLK2_DFETAP4MONITOR : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSRCLK2_PHYSTATUS : VitalDelayType01 := (0 ps, 0 ps);
      tpd_RXUSRCLK2_RXBUFSTATUS : VitalDelayArrayType01(2 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSRCLK2_RXBYTEISALIGNED : VitalDelayType01 := (0 ps, 0 ps);
      tpd_RXUSRCLK2_RXBYTEREALIGN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_RXUSRCLK2_RXCHANBONDSEQ : VitalDelayType01 := (0 ps, 0 ps);
      tpd_RXUSRCLK2_RXCHANISALIGNED : VitalDelayType01 := (0 ps, 0 ps);
      tpd_RXUSRCLK2_RXCHANREALIGN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_RXUSRCLK2_RXCHARISCOMMA : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSRCLK2_RXCHARISK : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSRCLK2_RXCHBONDO : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSRCLK2_RXCLKCORCNT : VitalDelayArrayType01(2 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSRCLK2_RXCOMMADET : VitalDelayType01 := (0 ps, 0 ps);
      tpd_RXUSRCLK2_RXDATA : VitalDelayArrayType01(31 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSRCLK2_RXDATAVALID : VitalDelayType01 := (0 ps, 0 ps);
      tpd_RXUSRCLK2_RXDISPERR : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSRCLK2_RXHEADER : VitalDelayArrayType01(2 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSRCLK2_RXHEADERVALID : VitalDelayType01 := (0 ps, 0 ps);
      tpd_RXUSRCLK2_RXLOSSOFSYNC : VitalDelayArrayType01(1 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSRCLK2_RXNOTINTABLE : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSRCLK2_RXOVERSAMPLEERR : VitalDelayType01 := (0 ps, 0 ps);
      tpd_RXUSRCLK2_RXPRBSERR : VitalDelayType01 := (0 ps, 0 ps);
      tpd_RXUSRCLK2_RXRATEDONE : VitalDelayType01 := (0 ps, 0 ps);
      tpd_RXUSRCLK2_RXRESETDONE : VitalDelayType01 := (0 ps, 0 ps);
      tpd_RXUSRCLK2_RXRUNDISP : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSRCLK2_RXSTARTOFSEQ : VitalDelayType01 := (0 ps, 0 ps);
      tpd_RXUSRCLK2_RXSTATUS : VitalDelayArrayType01(2 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSRCLK2_RXVALID : VitalDelayType01 := (0 ps, 0 ps);
      tpd_RXUSRCLK_RXCHBONDO : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
--      tpd_SOUTHREFCLKRX_MGTREFCLKFAB : VitalDelayArrayType01(1 downto 0) := (others => (0 ps, 0 ps));
--      tpd_SOUTHREFCLKTX_MGTREFCLKFAB : VitalDelayArrayType01(1 downto 0) := (others => (0 ps, 0 ps));
      tpd_SOUTHREFCLKRX_MGTREFCLKFAB : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
      tpd_SOUTHREFCLKTX_MGTREFCLKFAB : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps)); 
      tpd_TXUSRCLK2_COMFINISH : VitalDelayType01 := (0 ps, 0 ps);
      tpd_TXUSRCLK2_TXBUFSTATUS : VitalDelayArrayType01(1 downto 0) := (others => (0 ps, 0 ps));
      tpd_TXUSRCLK2_TXGEARBOXREADY : VitalDelayType01 := (0 ps, 0 ps);
      tpd_TXUSRCLK2_TXKERR : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
      tpd_TXUSRCLK2_TXRATEDONE : VitalDelayType01 := (0 ps, 0 ps);
      tpd_TXUSRCLK2_TXRESETDONE : VitalDelayType01 := (0 ps, 0 ps);
      tpd_TXUSRCLK2_TXRUNDISP : VitalDelayArrayType01(3 downto 0) := (others => (0 ps, 0 ps));
      thold_DADDR_DCLK_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_DADDR_DCLK_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_DEN_DCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_DEN_DCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_DFECLKDLYADJ_RXUSRCLK2_negedge_posedge : VitalDelayArrayType(5 downto 0) := (others => 0 ps);
      thold_DFECLKDLYADJ_RXUSRCLK2_posedge_posedge : VitalDelayArrayType(5 downto 0) := (others => 0 ps);
      thold_DFEDLYOVRD_RXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      thold_DFEDLYOVRD_RXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      thold_DFETAP1_RXUSRCLK2_negedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
      thold_DFETAP1_RXUSRCLK2_posedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
      thold_DFETAP2_RXUSRCLK2_negedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
      thold_DFETAP2_RXUSRCLK2_posedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
      thold_DFETAP3_RXUSRCLK2_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      thold_DFETAP3_RXUSRCLK2_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      thold_DFETAP4_RXUSRCLK2_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      thold_DFETAP4_RXUSRCLK2_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      thold_DFETAPOVRD_RXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      thold_DFETAPOVRD_RXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      thold_DI_DCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_DI_DCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_DWE_DCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_DWE_DCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_PRBSCNTRESET_RXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      thold_PRBSCNTRESET_RXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      thold_RXCHBONDI_RXUSRCLK2_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      thold_RXCHBONDI_RXUSRCLK2_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      thold_RXCHBONDI_RXUSRCLK_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      thold_RXCHBONDI_RXUSRCLK_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      thold_RXCHBONDLEVEL_RXUSRCLK2_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_RXCHBONDLEVEL_RXUSRCLK2_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_RXCHBONDMASTER_RXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      thold_RXCHBONDMASTER_RXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      thold_RXCHBONDSLAVE_RXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      thold_RXCHBONDSLAVE_RXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      thold_RXCOMMADETUSE_RXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      thold_RXCOMMADETUSE_RXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      thold_RXDEC8B10BUSE_RXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      thold_RXDEC8B10BUSE_RXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      thold_RXENCHANSYNC_RXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      thold_RXENCHANSYNC_RXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      thold_RXENMCOMMAALIGN_RXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      thold_RXENMCOMMAALIGN_RXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      thold_RXENPCOMMAALIGN_RXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      thold_RXENPCOMMAALIGN_RXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      thold_RXENPRBSTST_RXUSRCLK2_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_RXENPRBSTST_RXUSRCLK2_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_RXENSAMPLEALIGN_RXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      thold_RXENSAMPLEALIGN_RXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      thold_RXGEARBOXSLIP_RXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      thold_RXGEARBOXSLIP_RXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      thold_RXPOLARITY_RXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      thold_RXPOLARITY_RXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      thold_RXRATE_RXUSRCLK2_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_RXRATE_RXUSRCLK2_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_RXSLIDE_RXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      thold_RXSLIDE_RXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      thold_TXBYPASS8B10B_TXUSRCLK2_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      thold_TXBYPASS8B10B_TXUSRCLK2_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      thold_TXCHARDISPMODE_TXUSRCLK2_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      thold_TXCHARDISPMODE_TXUSRCLK2_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      thold_TXCHARDISPVAL_TXUSRCLK2_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      thold_TXCHARDISPVAL_TXUSRCLK2_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      thold_TXCHARISK_TXUSRCLK2_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      thold_TXCHARISK_TXUSRCLK2_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      thold_TXCOMINIT_TXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      thold_TXCOMINIT_TXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      thold_TXCOMSAS_TXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      thold_TXCOMSAS_TXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      thold_TXCOMWAKE_TXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      thold_TXCOMWAKE_TXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      thold_TXDATA_TXUSRCLK2_negedge_posedge : VitalDelayArrayType(31 downto 0) := (others => 0 ps);
      thold_TXDATA_TXUSRCLK2_posedge_posedge : VitalDelayArrayType(31 downto 0) := (others => 0 ps);
      thold_TXDETECTRX_TXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      thold_TXDETECTRX_TXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      thold_TXELECIDLE_TXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      thold_TXELECIDLE_TXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      thold_TXENC8B10BUSE_TXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      thold_TXENC8B10BUSE_TXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      thold_TXENPRBSTST_TXUSRCLK2_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_TXENPRBSTST_TXUSRCLK2_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_TXHEADER_TXUSRCLK2_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_TXHEADER_TXUSRCLK2_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_TXINHIBIT_TXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      thold_TXINHIBIT_TXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      thold_TXPOLARITY_TXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      thold_TXPOLARITY_TXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      thold_TXPOWERDOWN_TXUSRCLK2_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_TXPOWERDOWN_TXUSRCLK2_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_TXPRBSFORCEERR_TXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      thold_TXPRBSFORCEERR_TXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      thold_TXRATE_TXUSRCLK2_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_TXRATE_TXUSRCLK2_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_TXSEQUENCE_TXUSRCLK2_negedge_posedge : VitalDelayArrayType(6 downto 0) := (others => 0 ps);
      thold_TXSEQUENCE_TXUSRCLK2_posedge_posedge : VitalDelayArrayType(6 downto 0) := (others => 0 ps);
      thold_TXSTARTSEQ_TXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      thold_TXSTARTSEQ_TXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      thold_USRCODEERR_RXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      thold_USRCODEERR_RXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_DADDR_DCLK_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_DADDR_DCLK_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_DEN_DCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_DEN_DCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_DFECLKDLYADJ_RXUSRCLK2_negedge_posedge : VitalDelayArrayType(5 downto 0) := (others => 0 ps);
      tsetup_DFECLKDLYADJ_RXUSRCLK2_posedge_posedge : VitalDelayArrayType(5 downto 0) := (others => 0 ps);
      tsetup_DFEDLYOVRD_RXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_DFEDLYOVRD_RXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_DFETAP1_RXUSRCLK2_negedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
      tsetup_DFETAP1_RXUSRCLK2_posedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
      tsetup_DFETAP2_RXUSRCLK2_negedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
      tsetup_DFETAP2_RXUSRCLK2_posedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
      tsetup_DFETAP3_RXUSRCLK2_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      tsetup_DFETAP3_RXUSRCLK2_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      tsetup_DFETAP4_RXUSRCLK2_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      tsetup_DFETAP4_RXUSRCLK2_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      tsetup_DFETAPOVRD_RXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_DFETAPOVRD_RXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_DI_DCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_DI_DCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_DWE_DCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_DWE_DCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PRBSCNTRESET_RXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PRBSCNTRESET_RXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXCHBONDI_RXUSRCLK2_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      tsetup_RXCHBONDI_RXUSRCLK2_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      tsetup_RXCHBONDI_RXUSRCLK_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      tsetup_RXCHBONDI_RXUSRCLK_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      tsetup_RXCHBONDLEVEL_RXUSRCLK2_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_RXCHBONDLEVEL_RXUSRCLK2_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_RXCHBONDMASTER_RXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXCHBONDMASTER_RXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXCHBONDSLAVE_RXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXCHBONDSLAVE_RXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXCOMMADETUSE_RXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXCOMMADETUSE_RXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXDEC8B10BUSE_RXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXDEC8B10BUSE_RXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXENCHANSYNC_RXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXENCHANSYNC_RXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXENMCOMMAALIGN_RXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXENMCOMMAALIGN_RXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXENPCOMMAALIGN_RXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXENPCOMMAALIGN_RXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXENPRBSTST_RXUSRCLK2_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_RXENPRBSTST_RXUSRCLK2_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_RXENSAMPLEALIGN_RXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXENSAMPLEALIGN_RXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXGEARBOXSLIP_RXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXGEARBOXSLIP_RXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXPOLARITY_RXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXPOLARITY_RXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXRATE_RXUSRCLK2_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_RXRATE_RXUSRCLK2_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_RXSLIDE_RXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXSLIDE_RXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXBYPASS8B10B_TXUSRCLK2_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      tsetup_TXBYPASS8B10B_TXUSRCLK2_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      tsetup_TXCHARDISPMODE_TXUSRCLK2_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      tsetup_TXCHARDISPMODE_TXUSRCLK2_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      tsetup_TXCHARDISPVAL_TXUSRCLK2_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      tsetup_TXCHARDISPVAL_TXUSRCLK2_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      tsetup_TXCHARISK_TXUSRCLK2_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      tsetup_TXCHARISK_TXUSRCLK2_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      tsetup_TXCOMINIT_TXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXCOMINIT_TXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXCOMSAS_TXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXCOMSAS_TXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXCOMWAKE_TXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXCOMWAKE_TXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXDATA_TXUSRCLK2_negedge_posedge : VitalDelayArrayType(31 downto 0) := (others => 0 ps);
      tsetup_TXDATA_TXUSRCLK2_posedge_posedge : VitalDelayArrayType(31 downto 0) := (others => 0 ps);
      tsetup_TXDETECTRX_TXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXDETECTRX_TXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXELECIDLE_TXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXELECIDLE_TXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXENC8B10BUSE_TXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXENC8B10BUSE_TXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXENPRBSTST_TXUSRCLK2_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_TXENPRBSTST_TXUSRCLK2_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_TXHEADER_TXUSRCLK2_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_TXHEADER_TXUSRCLK2_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_TXINHIBIT_TXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXINHIBIT_TXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXPOLARITY_TXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXPOLARITY_TXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXPOWERDOWN_TXUSRCLK2_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_TXPOWERDOWN_TXUSRCLK2_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_TXPRBSFORCEERR_TXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXPRBSFORCEERR_TXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXRATE_TXUSRCLK2_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_TXRATE_TXUSRCLK2_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_TXSEQUENCE_TXUSRCLK2_negedge_posedge : VitalDelayArrayType(6 downto 0) := (others => 0 ps);
      tsetup_TXSEQUENCE_TXUSRCLK2_posedge_posedge : VitalDelayArrayType(6 downto 0) := (others => 0 ps);
      tsetup_TXSTARTSEQ_TXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXSTARTSEQ_TXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_USRCODEERR_RXUSRCLK2_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_USRCODEERR_RXUSRCLK2_posedge_posedge : VitalDelayType := 0 ps;
      tisd_DADDR_DCLK : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tisd_DEN_DCLK : VitalDelayType := 0 ps;
      tisd_DFECLKDLYADJ_RXUSRCLK2 : VitalDelayArrayType(5 downto 0) := (others => 0 ps);
      tisd_DFEDLYOVRD_RXUSRCLK2 : VitalDelayType := 0 ps;
      tisd_DFETAP1_RXUSRCLK2 : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
      tisd_DFETAP2_RXUSRCLK2 : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
      tisd_DFETAP3_RXUSRCLK2 : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      tisd_DFETAP4_RXUSRCLK2 : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      tisd_DFETAPOVRD_RXUSRCLK2 : VitalDelayType := 0 ps;
      tisd_DI_DCLK : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tisd_DWE_DCLK : VitalDelayType := 0 ps;
      tisd_PRBSCNTRESET_RXUSRCLK2 : VitalDelayType := 0 ps;
      tisd_RXCHBONDI_RXUSRCLK : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      tisd_RXCHBONDI_RXUSRCLK2 : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      tisd_RXCHBONDLEVEL_RXUSRCLK2 : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tisd_RXCHBONDMASTER_RXUSRCLK2 : VitalDelayType := 0 ps;
      tisd_RXCHBONDSLAVE_RXUSRCLK2 : VitalDelayType := 0 ps;
      tisd_RXCOMMADETUSE_RXUSRCLK2 : VitalDelayType := 0 ps;
      tisd_RXDEC8B10BUSE_RXUSRCLK2 : VitalDelayType := 0 ps;
      tisd_RXENCHANSYNC_RXUSRCLK2 : VitalDelayType := 0 ps;
      tisd_RXENMCOMMAALIGN_RXUSRCLK2 : VitalDelayType := 0 ps;
      tisd_RXENPCOMMAALIGN_RXUSRCLK2 : VitalDelayType := 0 ps;
      tisd_RXENPRBSTST_RXUSRCLK2 : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tisd_RXENSAMPLEALIGN_RXUSRCLK2 : VitalDelayType := 0 ps;
      tisd_RXGEARBOXSLIP_RXUSRCLK2 : VitalDelayType := 0 ps;
      tisd_RXPOLARITY_RXUSRCLK2 : VitalDelayType := 0 ps;
      tisd_RXRATE_RXUSRCLK2 : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tisd_RXSLIDE_RXUSRCLK2 : VitalDelayType := 0 ps;
      tisd_TXBYPASS8B10B_TXUSRCLK2 : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      tisd_TXCHARDISPMODE_TXUSRCLK2 : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      tisd_TXCHARDISPVAL_TXUSRCLK2 : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      tisd_TXCHARISK_TXUSRCLK2 : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      tisd_TXCOMINIT_TXUSRCLK2 : VitalDelayType := 0 ps;
      tisd_TXCOMSAS_TXUSRCLK2 : VitalDelayType := 0 ps;
      tisd_TXCOMWAKE_TXUSRCLK2 : VitalDelayType := 0 ps;
      tisd_TXDATA_TXUSRCLK2 : VitalDelayArrayType(31 downto 0) := (others => 0 ps);
      tisd_TXDETECTRX_TXUSRCLK2 : VitalDelayType := 0 ps;
      tisd_TXELECIDLE_TXUSRCLK2 : VitalDelayType := 0 ps;
      tisd_TXENC8B10BUSE_TXUSRCLK2 : VitalDelayType := 0 ps;
      tisd_TXENPRBSTST_TXUSRCLK2 : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tisd_TXHEADER_TXUSRCLK2 : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tisd_TXINHIBIT_TXUSRCLK2 : VitalDelayType := 0 ps;
      tisd_TXPOLARITY_TXUSRCLK2 : VitalDelayType := 0 ps;
      tisd_TXPOWERDOWN_TXUSRCLK2 : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tisd_TXPRBSFORCEERR_TXUSRCLK2 : VitalDelayType := 0 ps;
      tisd_TXRATE_TXUSRCLK2 : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tisd_TXSEQUENCE_TXUSRCLK2 : VitalDelayArrayType(6 downto 0) := (others => 0 ps);
      tisd_TXSTARTSEQ_TXUSRCLK2 : VitalDelayType := 0 ps;
      tisd_USRCODEERR_RXUSRCLK2 : VitalDelayType := 0 ps;
      ticd_DCLK : VitalDelayType := 0 ps;
      ticd_MGTREFCLKRX : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      ticd_MGTREFCLKTX : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      ticd_NORTHREFCLKRX : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      ticd_NORTHREFCLKTX : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      ticd_RXUSRCLK : VitalDelayType := 0 ps;
      ticd_RXUSRCLK2 : VitalDelayType := 0 ps;
      ticd_SOUTHREFCLKRX : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      ticd_SOUTHREFCLKTX : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      ticd_TXUSRCLK2 : VitalDelayType := 0 ps;
      ticd_TXUSRCLK : VitalDelayType := 0 ps;
      tperiod_DCLK_posedge : VitalDelayType := 0 ps;
      tperiod_GREFCLKRX_posedge : VitalDelayType := 0 ps;
      tperiod_GREFCLKTX_posedge : VitalDelayType := 0 ps;
      tperiod_MGTREFCLKRX_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tperiod_MGTREFCLKTX_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tperiod_NORTHREFCLKRX_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tperiod_NORTHREFCLKTX_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tperiod_PERFCLKRX_posedge : VitalDelayType := 0 ps;
      tperiod_PERFCLKTX_posedge : VitalDelayType := 0 ps;
      tperiod_RXUSRCLK2_posedge : VitalDelayType := 0 ps;
      tperiod_RXUSRCLK_posedge : VitalDelayType := 0 ps;
      tperiod_SOUTHREFCLKRX_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tperiod_SOUTHREFCLKTX_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tperiod_TSTCLK0_posedge : VitalDelayType := 0 ps;
      tperiod_TSTCLK1_posedge : VitalDelayType := 0 ps;
      tperiod_TXUSRCLK2_posedge : VitalDelayType := 0 ps;
      tperiod_TXUSRCLK_posedge : VitalDelayType := 0 ps
    );

    port (
      COMFINISH            : out std_ulogic;
      COMINITDET           : out std_ulogic;
      COMSASDET            : out std_ulogic;
      COMWAKEDET           : out std_ulogic;
      DFECLKDLYADJMON      : out std_logic_vector(5 downto 0);
      DFEEYEDACMON         : out std_logic_vector(4 downto 0);
      DFESENSCAL           : out std_logic_vector(2 downto 0);
      DFETAP1MONITOR       : out std_logic_vector(4 downto 0);
      DFETAP2MONITOR       : out std_logic_vector(4 downto 0);
      DFETAP3MONITOR       : out std_logic_vector(3 downto 0);
      DFETAP4MONITOR       : out std_logic_vector(3 downto 0);
      DRDY                 : out std_ulogic;
      DRPDO                : out std_logic_vector(15 downto 0);
      MGTREFCLKFAB         : out std_logic_vector(1 downto 0);
      PHYSTATUS            : out std_ulogic;
      RXBUFSTATUS          : out std_logic_vector(2 downto 0);
      RXBYTEISALIGNED      : out std_ulogic;
      RXBYTEREALIGN        : out std_ulogic;
      RXCHANBONDSEQ        : out std_ulogic;
      RXCHANISALIGNED      : out std_ulogic;
      RXCHANREALIGN        : out std_ulogic;
      RXCHARISCOMMA        : out std_logic_vector(3 downto 0);
      RXCHARISK            : out std_logic_vector(3 downto 0);
      RXCHBONDO            : out std_logic_vector(3 downto 0);
      RXCLKCORCNT          : out std_logic_vector(2 downto 0);
      RXCOMMADET           : out std_ulogic;
      RXDATA               : out std_logic_vector(31 downto 0);
      RXDATAVALID          : out std_ulogic;
      RXDISPERR            : out std_logic_vector(3 downto 0);
      RXDLYALIGNMONITOR    : out std_logic_vector(7 downto 0);
      RXELECIDLE           : out std_ulogic;
      RXHEADER             : out std_logic_vector(2 downto 0);
      RXHEADERVALID        : out std_ulogic;
      RXLOSSOFSYNC         : out std_logic_vector(1 downto 0);
      RXNOTINTABLE         : out std_logic_vector(3 downto 0);
      RXOVERSAMPLEERR      : out std_ulogic;
      RXPLLLKDET           : out std_ulogic;
      RXPRBSERR            : out std_ulogic;
      RXRATEDONE           : out std_ulogic;
      RXRECCLK             : out std_ulogic;
      RXRECCLKPCS          : out std_ulogic;
      RXRESETDONE          : out std_ulogic;
      RXRUNDISP            : out std_logic_vector(3 downto 0);
      RXSTARTOFSEQ         : out std_ulogic;
      RXSTATUS             : out std_logic_vector(2 downto 0);
      RXVALID              : out std_ulogic;
      TSTOUT               : out std_logic_vector(9 downto 0);
      TXBUFSTATUS          : out std_logic_vector(1 downto 0);
      TXDLYALIGNMONITOR    : out std_logic_vector(7 downto 0);
      TXGEARBOXREADY       : out std_ulogic;
      TXKERR               : out std_logic_vector(3 downto 0);
      TXN                  : out std_ulogic;
      TXOUTCLK             : out std_ulogic;
      TXOUTCLKPCS          : out std_ulogic;
      TXP                  : out std_ulogic;
      TXPLLLKDET           : out std_ulogic;
      TXRATEDONE           : out std_ulogic;
      TXRESETDONE          : out std_ulogic;
      TXRUNDISP            : out std_logic_vector(3 downto 0);
      DADDR                : in std_logic_vector(7 downto 0);
      DCLK                 : in std_ulogic;
      DEN                  : in std_ulogic;
      DFECLKDLYADJ         : in std_logic_vector(5 downto 0);
      DFEDLYOVRD           : in std_ulogic;
      DFETAP1              : in std_logic_vector(4 downto 0);
      DFETAP2              : in std_logic_vector(4 downto 0);
      DFETAP3              : in std_logic_vector(3 downto 0);
      DFETAP4              : in std_logic_vector(3 downto 0);
      DFETAPOVRD           : in std_ulogic;
      DI                   : in std_logic_vector(15 downto 0);
      DWE                  : in std_ulogic;
      GATERXELECIDLE       : in std_ulogic;
      GREFCLKRX            : in std_ulogic;
      GREFCLKTX            : in std_ulogic;
      GTXRXRESET           : in std_ulogic;
      GTXTEST              : in std_logic_vector(12 downto 0);
      GTXTXRESET           : in std_ulogic;
      IGNORESIGDET         : in std_ulogic;
      LOOPBACK             : in std_logic_vector(2 downto 0);
      MGTREFCLKRX          : in std_logic_vector(1 downto 0);
      MGTREFCLKTX          : in std_logic_vector(1 downto 0);
      NORTHREFCLKRX        : in std_logic_vector(1 downto 0);
      NORTHREFCLKTX        : in std_logic_vector(1 downto 0);
      PERFCLKRX            : in std_ulogic;
      PERFCLKTX            : in std_ulogic;
      PLLRXRESET           : in std_ulogic;
      PLLTXRESET           : in std_ulogic;
      PRBSCNTRESET         : in std_ulogic;
      RXBUFRESET           : in std_ulogic;
      RXCDRRESET           : in std_ulogic;
      RXCHBONDI            : in std_logic_vector(3 downto 0);
      RXCHBONDLEVEL        : in std_logic_vector(2 downto 0);
      RXCHBONDMASTER       : in std_ulogic;
      RXCHBONDSLAVE        : in std_ulogic;
      RXCOMMADETUSE        : in std_ulogic;
      RXDEC8B10BUSE        : in std_ulogic;
      RXDLYALIGNDISABLE    : in std_ulogic;
      RXDLYALIGNMONENB     : in std_ulogic := 'H';
      RXDLYALIGNOVERRIDE   : in std_ulogic;
      RXDLYALIGNRESET      : in std_ulogic;
      RXDLYALIGNSWPPRECURB : in std_ulogic;
      RXDLYALIGNUPDSW      : in std_ulogic;
      RXENCHANSYNC         : in std_ulogic;
      RXENMCOMMAALIGN      : in std_ulogic;
      RXENPCOMMAALIGN      : in std_ulogic;
      RXENPMAPHASEALIGN    : in std_ulogic;
      RXENPRBSTST          : in std_logic_vector(2 downto 0);
      RXENSAMPLEALIGN      : in std_ulogic;
      RXEQMIX              : in std_logic_vector(9 downto 0);
      RXGEARBOXSLIP        : in std_ulogic;
      RXN                  : in std_ulogic;
      RXP                  : in std_ulogic;
      RXPLLLKDETEN         : in std_ulogic;
      RXPLLPOWERDOWN       : in std_ulogic;
      RXPLLREFSELDY        : in std_logic_vector(2 downto 0);
      RXPMASETPHASE        : in std_ulogic;
      RXPOLARITY           : in std_ulogic;
      RXPOWERDOWN          : in std_logic_vector(1 downto 0);
      RXRATE               : in std_logic_vector(1 downto 0);
      RXRESET              : in std_ulogic;
      RXSLIDE              : in std_ulogic;
      RXUSRCLK             : in std_ulogic;
      RXUSRCLK2            : in std_ulogic;
      SOUTHREFCLKRX        : in std_logic_vector(1 downto 0);
      SOUTHREFCLKTX        : in std_logic_vector(1 downto 0);
      TSTCLK0              : in std_ulogic;
      TSTCLK1              : in std_ulogic;
      TSTIN                : in std_logic_vector(19 downto 0);
      TXBUFDIFFCTRL        : in std_logic_vector(2 downto 0);
      TXBYPASS8B10B        : in std_logic_vector(3 downto 0);
      TXCHARDISPMODE       : in std_logic_vector(3 downto 0);
      TXCHARDISPVAL        : in std_logic_vector(3 downto 0);
      TXCHARISK            : in std_logic_vector(3 downto 0);
      TXCOMINIT            : in std_ulogic;
      TXCOMSAS             : in std_ulogic;
      TXCOMWAKE            : in std_ulogic;
      TXDATA               : in std_logic_vector(31 downto 0);
      TXDEEMPH             : in std_ulogic;
      TXDETECTRX           : in std_ulogic;
      TXDIFFCTRL           : in std_logic_vector(3 downto 0);
      TXDLYALIGNDISABLE    : in std_ulogic;
      TXDLYALIGNMONENB     : in std_ulogic := 'H';
      TXDLYALIGNOVERRIDE   : in std_ulogic;
      TXDLYALIGNRESET      : in std_ulogic;
      TXDLYALIGNUPDSW      : in std_ulogic;
      TXELECIDLE           : in std_ulogic;
      TXENC8B10BUSE        : in std_ulogic;
      TXENPMAPHASEALIGN    : in std_ulogic;
      TXENPRBSTST          : in std_logic_vector(2 downto 0);
      TXHEADER             : in std_logic_vector(2 downto 0);
      TXINHIBIT            : in std_ulogic;
      TXMARGIN             : in std_logic_vector(2 downto 0);
      TXPDOWNASYNCH        : in std_ulogic;
      TXPLLLKDETEN         : in std_ulogic;
      TXPLLPOWERDOWN       : in std_ulogic;
      TXPLLREFSELDY        : in std_logic_vector(2 downto 0);
      TXPMASETPHASE        : in std_ulogic;
      TXPOLARITY           : in std_ulogic;
      TXPOSTEMPHASIS       : in std_logic_vector(4 downto 0);
      TXPOWERDOWN          : in std_logic_vector(1 downto 0);
      TXPRBSFORCEERR       : in std_ulogic;
      TXPREEMPHASIS        : in std_logic_vector(3 downto 0);
      TXRATE               : in std_logic_vector(1 downto 0);
      TXRESET              : in std_ulogic;
      TXSEQUENCE           : in std_logic_vector(6 downto 0);
      TXSTARTSEQ           : in std_ulogic;
      TXSWING              : in std_ulogic;
      TXUSRCLK             : in std_ulogic;
      TXUSRCLK2            : in std_ulogic;
      USRCODEERR           : in std_ulogic      
    );
    attribute VITAL_LEVEL0 of X_GTXE1 :     entity is true;
  end X_GTXE1;

  architecture X_GTXE1_V of X_GTXE1 is
    TYPE VitalTimingDataArrayType IS ARRAY (NATURAL RANGE <>) OF VitalTimingDataType;
    component GTXE1_WRAP
      generic (
        AC_CAP_DIS : string;
        ALIGN_COMMA_WORD : integer;
        BGTEST_CFG : string;
        BIAS_CFG : string;
        CDR_PH_ADJ_TIME : string;
        CHAN_BOND_1_MAX_SKEW : integer;
        CHAN_BOND_2_MAX_SKEW : integer;
        CHAN_BOND_KEEP_ALIGN : string;
        CHAN_BOND_SEQ_1_1 : string;
        CHAN_BOND_SEQ_1_2 : string;
        CHAN_BOND_SEQ_1_3 : string;
        CHAN_BOND_SEQ_1_4 : string;
        CHAN_BOND_SEQ_1_ENABLE : string;
        CHAN_BOND_SEQ_2_1 : string;
        CHAN_BOND_SEQ_2_2 : string;
        CHAN_BOND_SEQ_2_3 : string;
        CHAN_BOND_SEQ_2_4 : string;
        CHAN_BOND_SEQ_2_CFG :string;
        CHAN_BOND_SEQ_2_ENABLE : string;
        CHAN_BOND_SEQ_2_USE : string;
        CHAN_BOND_SEQ_LEN : integer;
        CLK_CORRECT_USE : string;
        CLK_COR_ADJ_LEN : integer;
        CLK_COR_DET_LEN : integer;
        CLK_COR_INSERT_IDLE_FLAG : string;
        CLK_COR_KEEP_IDLE : string;
        CLK_COR_MAX_LAT : integer;
        CLK_COR_MIN_LAT : integer;
        CLK_COR_PRECEDENCE :  string;
        CLK_COR_REPEAT_WAIT : integer;
        CLK_COR_SEQ_1_1 : string;
        CLK_COR_SEQ_1_2 : string;
        CLK_COR_SEQ_1_3 : string;
        CLK_COR_SEQ_1_4 : string;
        CLK_COR_SEQ_1_ENABLE : string;
        CLK_COR_SEQ_2_1 : string;
        CLK_COR_SEQ_2_2 : string;
        CLK_COR_SEQ_2_3 : string;
        CLK_COR_SEQ_2_4 : string;
        CLK_COR_SEQ_2_ENABLE : string;
        CLK_COR_SEQ_2_USE : string;
        CM_TRIM : string;
        COMMA_10B_ENABLE : string; 
        COMMA_DOUBLE : string;
        COM_BURST_VAL : string;
        DEC_MCOMMA_DETECT : string;
        DEC_PCOMMA_DETECT : string;
        DEC_VALID_COMMA_ONLY : string;
        DFE_CAL_TIME : string;
        DFE_CFG : string;
        GEARBOX_ENDEC : string;
        GEN_RXUSRCLK : string;
        GEN_TXUSRCLK : string;
        GTX_CFG_PWRUP : string;
        MCOMMA_10B_VALUE : string;
        MCOMMA_DETECT : string;
        OOBDETECT_THRESHOLD : string;
        PCI_EXPRESS_MODE : string;
        PCOMMA_10B_VALUE :string;
        PCOMMA_DETECT : string;
        PMA_CAS_CLK_EN : string;
        PMA_CDR_SCAN : string;
        PMA_CFG : string;
        PMA_RXSYNC_CFG : string;
        PMA_RX_CFG : string;
        PMA_TX_CFG : string;
        POWER_SAVE : string;
        RCV_TERM_GND : string;
        RCV_TERM_VTTRX : string;
        RXGEARBOX_USE : string;
        RXPLL_COM_CFG : string;
        RXPLL_CP_CFG : string;
        RXPLL_DIVSEL45_FB : integer;
        RXPLL_DIVSEL_FB : integer;
        RXPLL_DIVSEL_OUT : integer;
        RXPLL_DIVSEL_REF : integer;
        RXPLL_LKDET_CFG :string;
        RXPRBSERR_LOOPBACK : string;
        RXRECCLK_CTRL : string;
        RXRECCLK_DLY : string;
        RXUSRCLK_DLY : string;
        RX_BUFFER_USE : string;
        RX_CLK25_DIVIDER : integer;
        RX_DATA_WIDTH : integer;
        RX_DECODE_SEQ_MATCH : string;
        RX_DLYALIGN_CTRINC : string;
        RX_DLYALIGN_EDGESET : string;
        RX_DLYALIGN_LPFINC : string;
        RX_DLYALIGN_MONSEL : string;
        RX_DLYALIGN_OVRDSETTING : string;
        RX_EN_IDLE_HOLD_CDR : string;
        RX_EN_IDLE_HOLD_DFE : string;
        RX_EN_IDLE_RESET_BUF : string;
        RX_EN_IDLE_RESET_FR : string;
        RX_EN_IDLE_RESET_PH : string;
        RX_EN_MODE_RESET_BUF : string;
        RX_EN_RATE_RESET_BUF : string;
        RX_EN_REALIGN_RESET_BUF : string;
        RX_EN_REALIGN_RESET_BUF2 : string;
        RX_EYE_OFFSET : string;
        RX_EYE_SCANMODE : string;
        RX_FIFO_ADDR_MODE : string;
        RX_IDLE_HI_CNT : string;
        RX_IDLE_LO_CNT : string;
        RX_LOSS_OF_SYNC_FSM : string;
        RX_LOS_INVALID_INCR : integer;
        RX_LOS_THRESHOLD : integer;
        RX_OVERSAMPLE_MODE : string;
        RX_SLIDE_AUTO_WAIT : integer;
        RX_SLIDE_MODE : string;
        RX_XCLK_SEL : string;
        SAS_MAX_COMSAS : integer;
        SAS_MIN_COMSAS : integer;
        SATA_BURST_VAL : string;
        SATA_IDLE_VAL : string;
        SATA_MAX_BURST : integer;
        SATA_MAX_INIT : integer;
        SATA_MAX_WAKE : integer;
        SATA_MIN_BURST : integer;
        SATA_MIN_INIT : integer;
        SATA_MIN_WAKE : integer;
        SHOW_REALIGN_COMMA : string;
        SIM_GTXRESET_SPEEDUP : integer;
        SIM_RECEIVER_DETECT_PASS : string;
        SIM_RXREFCLK_SOURCE : string;
        SIM_TXREFCLK_SOURCE : string;
        SIM_TX_ELEC_IDLE_LEVEL : string;
        SIM_VERSION : string;
        TERMINATION_CTRL : string;
        TERMINATION_OVRD : string;
        TRANS_TIME_FROM_P2 : string;
        TRANS_TIME_NON_P2 : string;
        TRANS_TIME_RATE : string;
        TRANS_TIME_TO_P2 : string;
        TST_ATTR : string;
        TXDRIVE_LOOPBACK_HIZ : string;
        TXDRIVE_LOOPBACK_PD : string;
        TXGEARBOX_USE : string;
        TXOUTCLK_CTRL : string;
        TXOUTCLK_DLY : string;
        TXPLL_COM_CFG : string;
        TXPLL_CP_CFG : string;
        TXPLL_DIVSEL45_FB : integer;
        TXPLL_DIVSEL_FB : integer;
        TXPLL_DIVSEL_OUT : integer;
        TXPLL_DIVSEL_REF : integer;
        TXPLL_LKDET_CFG : string;
        TXPLL_SATA :string;
        TX_BUFFER_USE : string;
        TX_BYTECLK_CFG : string;
        TX_CLK25_DIVIDER : integer;
        TX_CLK_SOURCE : string;
        TX_DATA_WIDTH : integer;
        TX_DEEMPH_0 : string;
        TX_DEEMPH_1 : string;
        TX_DETECT_RX_CFG : string;
        TX_DLYALIGN_CTRINC : string;
        TX_DLYALIGN_LPFINC : string;
        TX_DLYALIGN_MONSEL : string;
        TX_DLYALIGN_OVRDSETTING :string;
        TX_DRIVE_MODE : string;
        TX_EN_RATE_RESET_BUF : string;
        TX_IDLE_ASSERT_DELAY : string;
        TX_IDLE_DEASSERT_DELAY : string;
        TX_MARGIN_FULL_0 : string;
        TX_MARGIN_FULL_1 : string;
        TX_MARGIN_FULL_2 : string;
        TX_MARGIN_FULL_3 : string;
        TX_MARGIN_FULL_4 : string;
        TX_MARGIN_LOW_0 : string;
        TX_MARGIN_LOW_1 : string;
        TX_MARGIN_LOW_2 : string;
        TX_MARGIN_LOW_3 : string;
        TX_MARGIN_LOW_4 : string;
        TX_OVERSAMPLE_MODE : string;
        TX_PMADATA_OPT : string;
        TX_TDCC_CFG : string;
        TX_USRCLK_CFG : string;
        TX_XCLK_SEL : string        
      );
      port (
        COMFINISH            : out std_ulogic;
        COMINITDET           : out std_ulogic;
        COMSASDET            : out std_ulogic;
        COMWAKEDET           : out std_ulogic;
        DFECLKDLYADJMON      : out std_logic_vector(5 downto 0);
        DFEEYEDACMON         : out std_logic_vector(4 downto 0);
        DFESENSCAL           : out std_logic_vector(2 downto 0);
        DFETAP1MONITOR       : out std_logic_vector(4 downto 0);
        DFETAP2MONITOR       : out std_logic_vector(4 downto 0);
        DFETAP3MONITOR       : out std_logic_vector(3 downto 0);
        DFETAP4MONITOR       : out std_logic_vector(3 downto 0);
        DRDY                 : out std_ulogic;
        DRPDO                : out std_logic_vector(15 downto 0);
        MGTREFCLKFAB         : out std_logic_vector(1 downto 0);
        PHYSTATUS            : out std_ulogic;
        RXBUFSTATUS          : out std_logic_vector(2 downto 0);
        RXBYTEISALIGNED      : out std_ulogic;
        RXBYTEREALIGN        : out std_ulogic;
        RXCHANBONDSEQ        : out std_ulogic;
        RXCHANISALIGNED      : out std_ulogic;
        RXCHANREALIGN        : out std_ulogic;
        RXCHARISCOMMA        : out std_logic_vector(3 downto 0);
        RXCHARISK            : out std_logic_vector(3 downto 0);
        RXCHBONDO            : out std_logic_vector(3 downto 0);
        RXCLKCORCNT          : out std_logic_vector(2 downto 0);
        RXCOMMADET           : out std_ulogic;
        RXDATA               : out std_logic_vector(31 downto 0);
        RXDATAVALID          : out std_ulogic;
        RXDISPERR            : out std_logic_vector(3 downto 0);
        RXDLYALIGNMONITOR    : out std_logic_vector(7 downto 0);
        RXELECIDLE           : out std_ulogic;
        RXHEADER             : out std_logic_vector(2 downto 0);
        RXHEADERVALID        : out std_ulogic;
        RXLOSSOFSYNC         : out std_logic_vector(1 downto 0);
        RXNOTINTABLE         : out std_logic_vector(3 downto 0);
        RXOVERSAMPLEERR      : out std_ulogic;
        RXPLLLKDET           : out std_ulogic;
        RXPRBSERR            : out std_ulogic;
        RXRATEDONE           : out std_ulogic;
        RXRECCLK             : out std_ulogic;
        RXRECCLKPCS          : out std_ulogic;
        RXRESETDONE          : out std_ulogic;
        RXRUNDISP            : out std_logic_vector(3 downto 0);
        RXSTARTOFSEQ         : out std_ulogic;
        RXSTATUS             : out std_logic_vector(2 downto 0);
        RXVALID              : out std_ulogic;
        TSTOUT               : out std_logic_vector(9 downto 0);
        TXBUFSTATUS          : out std_logic_vector(1 downto 0);
        TXDLYALIGNMONITOR    : out std_logic_vector(7 downto 0);
        TXGEARBOXREADY       : out std_ulogic;
        TXKERR               : out std_logic_vector(3 downto 0);
        TXN                  : out std_ulogic;
        TXOUTCLK             : out std_ulogic;
        TXOUTCLKPCS          : out std_ulogic;
        TXP                  : out std_ulogic;
        TXPLLLKDET           : out std_ulogic;
        TXRATEDONE           : out std_ulogic;
        TXRESETDONE          : out std_ulogic;
        TXRUNDISP            : out std_logic_vector(3 downto 0);

        GSR                  : in std_ulogic;
        DADDR                : in std_logic_vector(7 downto 0);
        DCLK                 : in std_ulogic;
        DEN                  : in std_ulogic;
        DFECLKDLYADJ         : in std_logic_vector(5 downto 0);
        DFEDLYOVRD           : in std_ulogic;
        DFETAP1              : in std_logic_vector(4 downto 0);
        DFETAP2              : in std_logic_vector(4 downto 0);
        DFETAP3              : in std_logic_vector(3 downto 0);
        DFETAP4              : in std_logic_vector(3 downto 0);
        DFETAPOVRD           : in std_ulogic;
        DI                   : in std_logic_vector(15 downto 0);
        DWE                  : in std_ulogic;
        GATERXELECIDLE       : in std_ulogic;
        GREFCLKRX            : in std_ulogic;
        GREFCLKTX            : in std_ulogic;
        GTXRXRESET           : in std_ulogic;
        GTXTEST              : in std_logic_vector(12 downto 0);
        GTXTXRESET           : in std_ulogic;
        IGNORESIGDET         : in std_ulogic;
        LOOPBACK             : in std_logic_vector(2 downto 0);
        MGTREFCLKRX          : in std_logic_vector(1 downto 0);
        MGTREFCLKTX          : in std_logic_vector(1 downto 0);
        NORTHREFCLKRX        : in std_logic_vector(1 downto 0);
        NORTHREFCLKTX        : in std_logic_vector(1 downto 0);
        PERFCLKRX            : in std_ulogic;
        PERFCLKTX            : in std_ulogic;
        PLLRXRESET           : in std_ulogic;
        PLLTXRESET           : in std_ulogic;
        PRBSCNTRESET         : in std_ulogic;
        RXBUFRESET           : in std_ulogic;
        RXCDRRESET           : in std_ulogic;
        RXCHBONDI            : in std_logic_vector(3 downto 0);
        RXCHBONDLEVEL        : in std_logic_vector(2 downto 0);
        RXCHBONDMASTER       : in std_ulogic;
        RXCHBONDSLAVE        : in std_ulogic;
        RXCOMMADETUSE        : in std_ulogic;
        RXDEC8B10BUSE        : in std_ulogic;
        RXDLYALIGNDISABLE    : in std_ulogic;
        RXDLYALIGNMONENB     : in std_ulogic;
        RXDLYALIGNOVERRIDE   : in std_ulogic;
        RXDLYALIGNRESET      : in std_ulogic;
        RXDLYALIGNSWPPRECURB : in std_ulogic;
        RXDLYALIGNUPDSW      : in std_ulogic;
        RXENCHANSYNC         : in std_ulogic;
        RXENMCOMMAALIGN      : in std_ulogic;
        RXENPCOMMAALIGN      : in std_ulogic;
        RXENPMAPHASEALIGN    : in std_ulogic;
        RXENPRBSTST          : in std_logic_vector(2 downto 0);
        RXENSAMPLEALIGN      : in std_ulogic;
        RXEQMIX              : in std_logic_vector(9 downto 0);
        RXGEARBOXSLIP        : in std_ulogic;
        RXN                  : in std_ulogic;
        RXP                  : in std_ulogic;
        RXPLLLKDETEN         : in std_ulogic;
        RXPLLPOWERDOWN       : in std_ulogic;
        RXPLLREFSELDY        : in std_logic_vector(2 downto 0);
        RXPMASETPHASE        : in std_ulogic;
        RXPOLARITY           : in std_ulogic;
        RXPOWERDOWN          : in std_logic_vector(1 downto 0);
        RXRATE               : in std_logic_vector(1 downto 0);
        RXRESET              : in std_ulogic;
        RXSLIDE              : in std_ulogic;
        RXUSRCLK             : in std_ulogic;
        RXUSRCLK2            : in std_ulogic;
        SOUTHREFCLKRX        : in std_logic_vector(1 downto 0);
        SOUTHREFCLKTX        : in std_logic_vector(1 downto 0);
        TSTCLK0              : in std_ulogic;
        TSTCLK1              : in std_ulogic;
        TSTIN                : in std_logic_vector(19 downto 0);
        TXBUFDIFFCTRL        : in std_logic_vector(2 downto 0);
        TXBYPASS8B10B        : in std_logic_vector(3 downto 0);
        TXCHARDISPMODE       : in std_logic_vector(3 downto 0);
        TXCHARDISPVAL        : in std_logic_vector(3 downto 0);
        TXCHARISK            : in std_logic_vector(3 downto 0);
        TXCOMINIT            : in std_ulogic;
        TXCOMSAS             : in std_ulogic;
        TXCOMWAKE            : in std_ulogic;
        TXDATA               : in std_logic_vector(31 downto 0);
        TXDEEMPH             : in std_ulogic;
        TXDETECTRX           : in std_ulogic;
        TXDIFFCTRL           : in std_logic_vector(3 downto 0);
        TXDLYALIGNDISABLE    : in std_ulogic;
        TXDLYALIGNMONENB     : in std_ulogic;
        TXDLYALIGNOVERRIDE   : in std_ulogic;
        TXDLYALIGNRESET      : in std_ulogic;
        TXDLYALIGNUPDSW      : in std_ulogic;
        TXELECIDLE           : in std_ulogic;
        TXENC8B10BUSE        : in std_ulogic;
        TXENPMAPHASEALIGN    : in std_ulogic;
        TXENPRBSTST          : in std_logic_vector(2 downto 0);
        TXHEADER             : in std_logic_vector(2 downto 0);
        TXINHIBIT            : in std_ulogic;
        TXMARGIN             : in std_logic_vector(2 downto 0);
        TXPDOWNASYNCH        : in std_ulogic;
        TXPLLLKDETEN         : in std_ulogic;
        TXPLLPOWERDOWN       : in std_ulogic;
        TXPLLREFSELDY        : in std_logic_vector(2 downto 0);
        TXPMASETPHASE        : in std_ulogic;
        TXPOLARITY           : in std_ulogic;
        TXPOSTEMPHASIS       : in std_logic_vector(4 downto 0);
        TXPOWERDOWN          : in std_logic_vector(1 downto 0);
        TXPRBSFORCEERR       : in std_ulogic;
        TXPREEMPHASIS        : in std_logic_vector(3 downto 0);
        TXRATE               : in std_logic_vector(1 downto 0);
        TXRESET              : in std_ulogic;
        TXSEQUENCE           : in std_logic_vector(6 downto 0);
        TXSTARTSEQ           : in std_ulogic;
        TXSWING              : in std_ulogic;
        TXUSRCLK             : in std_ulogic;
        TXUSRCLK2            : in std_ulogic;
        USRCODEERR           : in std_ulogic        
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
    constant BGTEST_CFG_BINARY : std_logic_vector(1 downto 0) := To_StdLogicVector(BGTEST_CFG)(1 downto 0);
    constant BIAS_CFG_BINARY : std_logic_vector(16 downto 0) := To_StdLogicVector(BIAS_CFG)(16 downto 0);
    constant CDR_PH_ADJ_TIME_BINARY : std_logic_vector(4 downto 0) := To_StdLogicVector(CDR_PH_ADJ_TIME)(4 downto 0);
    constant CHAN_BOND_SEQ_1_1_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_1_1)(9 downto 0);
    constant CHAN_BOND_SEQ_1_2_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_1_2)(9 downto 0);
    constant CHAN_BOND_SEQ_1_3_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_1_3)(9 downto 0);
    constant CHAN_BOND_SEQ_1_4_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_1_4)(9 downto 0);
    constant CHAN_BOND_SEQ_1_ENABLE_BINARY : std_logic_vector(3 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_1_ENABLE)(3 downto 0);
    constant CHAN_BOND_SEQ_2_1_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_2_1)(9 downto 0);
    constant CHAN_BOND_SEQ_2_2_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_2_2)(9 downto 0);
    constant CHAN_BOND_SEQ_2_3_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_2_3)(9 downto 0);
    constant CHAN_BOND_SEQ_2_4_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_2_4)(9 downto 0);
    constant CHAN_BOND_SEQ_2_CFG_BINARY : std_logic_vector(4 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_2_CFG)(4 downto 0);
    constant CHAN_BOND_SEQ_2_ENABLE_BINARY : std_logic_vector(3 downto 0) := To_StdLogicVector(CHAN_BOND_SEQ_2_ENABLE)(3 downto 0);
    constant CLK_COR_SEQ_1_1_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_1_1)(9 downto 0);
    constant CLK_COR_SEQ_1_2_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_1_2)(9 downto 0);
    constant CLK_COR_SEQ_1_3_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_1_3)(9 downto 0);
    constant CLK_COR_SEQ_1_4_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_1_4)(9 downto 0);
    constant CLK_COR_SEQ_1_ENABLE_BINARY : std_logic_vector(3 downto 0) := To_StdLogicVector(CLK_COR_SEQ_1_ENABLE)(3 downto 0);
    constant CLK_COR_SEQ_2_1_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_2_1)(9 downto 0);
    constant CLK_COR_SEQ_2_2_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_2_2)(9 downto 0);
    constant CLK_COR_SEQ_2_3_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_2_3)(9 downto 0);
    constant CLK_COR_SEQ_2_4_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(CLK_COR_SEQ_2_4)(9 downto 0);
    constant CLK_COR_SEQ_2_ENABLE_BINARY : std_logic_vector(3 downto 0) := To_StdLogicVector(CLK_COR_SEQ_2_ENABLE)(3 downto 0);
    constant CM_TRIM_BINARY : std_logic_vector(1 downto 0) := To_StdLogicVector(CM_TRIM)(1 downto 0);
    constant COMMA_10B_ENABLE_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(COMMA_10B_ENABLE)(9 downto 0);
    constant COM_BURST_VAL_BINARY : std_logic_vector(3 downto 0) := To_StdLogicVector(COM_BURST_VAL)(3 downto 0);
    constant DFE_CAL_TIME_BINARY : std_logic_vector(4 downto 0) := To_StdLogicVector(DFE_CAL_TIME)(4 downto 0);
    constant DFE_CFG_BINARY : std_logic_vector(7 downto 0) := To_StdLogicVector(DFE_CFG)(7 downto 0);
    constant GEARBOX_ENDEC_BINARY : std_logic_vector(2 downto 0) := To_StdLogicVector(GEARBOX_ENDEC)(2 downto 0);
    constant MCOMMA_10B_VALUE_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(MCOMMA_10B_VALUE)(9 downto 0) ;
    constant OOBDETECT_THRESHOLD_BINARY : std_logic_vector(2 downto 0) := To_StdLogicVector(OOBDETECT_THRESHOLD)(2 downto 0);
    constant PCOMMA_10B_VALUE_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(PCOMMA_10B_VALUE)(9 downto 0);
    constant PMA_CDR_SCAN_BINARY : std_logic_vector(26 downto 0) := To_StdLogicVector(PMA_CDR_SCAN)(26 downto 0);
    constant PMA_CFG_BINARY : std_logic_vector(75 downto 0) := To_StdLogicVector(PMA_CFG)(75 downto 0) ;
    constant PMA_RXSYNC_CFG_BINARY : std_logic_vector(6 downto 0) := To_StdLogicVector(PMA_RXSYNC_CFG)(6 downto 0);
    constant PMA_RX_CFG_BINARY : std_logic_vector(24 downto 0) := To_StdLogicVector(PMA_RX_CFG)(24 downto 0);
    constant PMA_TX_CFG_BINARY : std_logic_vector(19 downto 0) := To_StdLogicVector(PMA_TX_CFG)(19 downto 0);
    constant POWER_SAVE_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(POWER_SAVE)(9 downto 0) ;
    constant RXPLL_COM_CFG_BINARY : std_logic_vector(23 downto 0) := To_StdLogicVector(RXPLL_COM_CFG)(23 downto 0);
    constant RXPLL_CP_CFG_BINARY : std_logic_vector(7 downto 0) := To_StdLogicVector(RXPLL_CP_CFG)(7 downto 0);
    constant RXPLL_LKDET_CFG_BINARY : std_logic_vector(2 downto 0) := To_StdLogicVector(RXPLL_LKDET_CFG)(2 downto 0);
    constant RXPRBSERR_LOOPBACK_BINARY : std_ulogic := To_StduLogic(RXPRBSERR_LOOPBACK);
    constant RXRECCLK_DLY_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(RXRECCLK_DLY)(9 downto 0);
    constant RXUSRCLK_DLY_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RXUSRCLK_DLY)(15 downto 0);
    constant RX_DLYALIGN_CTRINC_BINARY : std_logic_vector(3 downto 0) := To_StdLogicVector(RX_DLYALIGN_CTRINC)(3 downto 0);
    constant RX_DLYALIGN_EDGESET_BINARY : std_logic_vector(4 downto 0) := To_StdLogicVector(RX_DLYALIGN_EDGESET)(4 downto 0);
    constant RX_DLYALIGN_LPFINC_BINARY : std_logic_vector(3 downto 0) := To_StdLogicVector(RX_DLYALIGN_LPFINC)(3 downto 0);
    constant RX_DLYALIGN_MONSEL_BINARY : std_logic_vector(2 downto 0) := To_StdLogicVector(RX_DLYALIGN_MONSEL)(2 downto 0);
    constant RX_DLYALIGN_OVRDSETTING_BINARY : std_logic_vector(7 downto 0) := To_StdLogicVector(RX_DLYALIGN_OVRDSETTING)(7 downto 0);
    constant RX_EYE_OFFSET_BINARY : std_logic_vector(7 downto 0) := To_StdLogicVector(RX_EYE_OFFSET)(7 downto 0);
    constant RX_EYE_SCANMODE_BINARY : std_logic_vector(1 downto 0) := To_StdLogicVector(RX_EYE_SCANMODE)(1 downto 0);
    constant RX_IDLE_HI_CNT_BINARY : std_logic_vector(3 downto 0) := To_StdLogicVector(RX_IDLE_HI_CNT)(3 downto 0);
    constant RX_IDLE_LO_CNT_BINARY : std_logic_vector(3 downto 0) := To_StdLogicVector(RX_IDLE_LO_CNT)(3 downto 0);
    constant SATA_BURST_VAL_BINARY : std_logic_vector(2 downto 0) := To_StdLogicVector(SATA_BURST_VAL)(2 downto 0);
    constant SATA_IDLE_VAL_BINARY : std_logic_vector(2 downto 0) := To_StdLogicVector(SATA_IDLE_VAL)(2 downto 0);
    constant SIM_RXREFCLK_SOURCE_BINARY : std_logic_vector(2 downto 0) := To_StdLogicVector(SIM_RXREFCLK_SOURCE)(2 downto 0);
    constant SIM_TXREFCLK_SOURCE_BINARY : std_logic_vector(2 downto 0) := To_StdLogicVector(SIM_TXREFCLK_SOURCE)(2 downto 0);
    constant TERMINATION_CTRL_BINARY : std_logic_vector(4 downto 0) := To_StdLogicVector(TERMINATION_CTRL)(4 downto 0);
    constant TRANS_TIME_FROM_P2_BINARY : std_logic_vector(11 downto 0) := To_StdLogicVector(TRANS_TIME_FROM_P2)(11 downto 0);
    constant TRANS_TIME_NON_P2_BINARY : std_logic_vector(7 downto 0) := To_StdLogicVector(TRANS_TIME_NON_P2)(7 downto 0);
    constant TRANS_TIME_RATE_BINARY : std_logic_vector(7 downto 0) := To_StdLogicVector(TRANS_TIME_RATE)(7 downto 0);
    constant TRANS_TIME_TO_P2_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(TRANS_TIME_TO_P2)(9 downto 0);
    constant TST_ATTR_BINARY : std_logic_vector(31 downto 0) := To_StdLogicVector(TST_ATTR)(31 downto 0);
    constant TXOUTCLK_DLY_BINARY : std_logic_vector(9 downto 0) := To_StdLogicVector(TXOUTCLK_DLY)(9 downto 0);
    constant TXPLL_COM_CFG_BINARY : std_logic_vector(23 downto 0) := To_StdLogicVector(TXPLL_COM_CFG)(23 downto 0);
    constant TXPLL_CP_CFG_BINARY : std_logic_vector(7 downto 0) := To_StdLogicVector(TXPLL_CP_CFG)(7 downto 0);
    constant TXPLL_LKDET_CFG_BINARY : std_logic_vector(2 downto 0) := To_StdLogicVector(TXPLL_LKDET_CFG)(2 downto 0);
    constant TXPLL_SATA_BINARY : std_logic_vector(1 downto 0) := To_StdLogicVector(TXPLL_SATA)(1 downto 0);
    constant TX_BYTECLK_CFG_BINARY : std_logic_vector(5 downto 0) := To_StdLogicVector(TX_BYTECLK_CFG)(5 downto 0);
    constant TX_DEEMPH_0_BINARY : std_logic_vector(4 downto 0) := To_StdLogicVector(TX_DEEMPH_0)(4 downto 0);
    constant TX_DEEMPH_1_BINARY : std_logic_vector(4 downto 0) := To_StdLogicVector(TX_DEEMPH_1)(4 downto 0);
    constant TX_DETECT_RX_CFG_BINARY : std_logic_vector(13 downto 0) := To_StdLogicVector(TX_DETECT_RX_CFG)(13 downto 0);
    constant TX_DLYALIGN_CTRINC_BINARY : std_logic_vector(3 downto 0) := To_StdLogicVector(TX_DLYALIGN_CTRINC)(3 downto 0);
    constant TX_DLYALIGN_LPFINC_BINARY : std_logic_vector(3 downto 0) := To_StdLogicVector(TX_DLYALIGN_LPFINC)(3 downto 0);
    constant TX_DLYALIGN_MONSEL_BINARY : std_logic_vector(2 downto 0) := To_StdLogicVector(TX_DLYALIGN_MONSEL)(2 downto 0);
    constant TX_DLYALIGN_OVRDSETTING_BINARY : std_logic_vector(7 downto 0) := To_StdLogicVector(TX_DLYALIGN_OVRDSETTING)(7 downto 0);
    constant TX_IDLE_ASSERT_DELAY_BINARY : std_logic_vector(2 downto 0) := To_StdLogicVector(TX_IDLE_ASSERT_DELAY)(2 downto 0);
    constant TX_IDLE_DEASSERT_DELAY_BINARY : std_logic_vector(2 downto 0) := To_StdLogicVector(TX_IDLE_DEASSERT_DELAY)(2 downto 0);
    constant TX_MARGIN_FULL_0_BINARY : std_logic_vector(6 downto 0) := To_StdLogicVector(TX_MARGIN_FULL_0)(6 downto 0);
    constant TX_MARGIN_FULL_1_BINARY : std_logic_vector(6 downto 0) := To_StdLogicVector(TX_MARGIN_FULL_1)(6 downto 0);
    constant TX_MARGIN_FULL_2_BINARY : std_logic_vector(6 downto 0) := To_StdLogicVector(TX_MARGIN_FULL_2)(6 downto 0);
    constant TX_MARGIN_FULL_3_BINARY : std_logic_vector(6 downto 0) := To_StdLogicVector(TX_MARGIN_FULL_3)(6 downto 0);
    constant TX_MARGIN_FULL_4_BINARY : std_logic_vector(6 downto 0) := To_StdLogicVector(TX_MARGIN_FULL_4)(6 downto 0);
    constant TX_MARGIN_LOW_0_BINARY : std_logic_vector(6 downto 0) := To_StdLogicVector(TX_MARGIN_LOW_0)(6 downto 0);
    constant TX_MARGIN_LOW_1_BINARY : std_logic_vector(6 downto 0) := To_StdLogicVector(TX_MARGIN_LOW_1)(6 downto 0);
    constant TX_MARGIN_LOW_2_BINARY : std_logic_vector(6 downto 0) := To_StdLogicVector(TX_MARGIN_LOW_2)(6 downto 0);
    constant TX_MARGIN_LOW_3_BINARY : std_logic_vector(6 downto 0) := To_StdLogicVector(TX_MARGIN_LOW_3)(6 downto 0);
    constant TX_MARGIN_LOW_4_BINARY : std_logic_vector(6 downto 0) := To_StdLogicVector(TX_MARGIN_LOW_4)(6 downto 0);
    constant TX_PMADATA_OPT_BINARY : std_ulogic := To_StduLogic(TX_PMADATA_OPT);
    constant TX_TDCC_CFG_BINARY : std_logic_vector(1 downto 0) := To_StdLogicVector(TX_TDCC_CFG)(1 downto 0) ;
    constant TX_USRCLK_CFG_BINARY : std_logic_vector(5 downto 0) := To_StdLogicVector(TX_USRCLK_CFG)(5 downto 0) ;

     -- Get String Length 
    constant BIAS_CFG_STRLEN : integer := getstrlength(BIAS_CFG_BINARY);
    constant PMA_CDR_SCAN_STRLEN : integer := getstrlength(PMA_CDR_SCAN_BINARY);
    constant PMA_CFG_STRLEN : integer := getstrlength(PMA_CFG_BINARY);
    constant PMA_RXSYNC_CFG_STRLEN : integer := getstrlength(PMA_RXSYNC_CFG_BINARY);
    constant PMA_RX_CFG_STRLEN : integer := getstrlength(PMA_RX_CFG_BINARY);
    constant PMA_TX_CFG_STRLEN : integer := getstrlength(PMA_TX_CFG_BINARY);
    constant RXPLL_COM_CFG_STRLEN : integer := getstrlength(RXPLL_COM_CFG_BINARY);
    constant RXPLL_CP_CFG_STRLEN : integer := getstrlength(RXPLL_CP_CFG_BINARY);
    constant RXUSRCLK_DLY_STRLEN : integer := getstrlength(RXUSRCLK_DLY_BINARY);
    constant RX_EYE_OFFSET_STRLEN : integer := getstrlength(RX_EYE_OFFSET_BINARY);
    constant TRANS_TIME_FROM_P2_STRLEN : integer := getstrlength(TRANS_TIME_FROM_P2_BINARY);
    constant TRANS_TIME_NON_P2_STRLEN : integer := getstrlength(TRANS_TIME_NON_P2_BINARY);
    constant TRANS_TIME_RATE_STRLEN : integer := getstrlength(TRANS_TIME_RATE_BINARY);
    constant TRANS_TIME_TO_P2_STRLEN : integer := getstrlength(TRANS_TIME_TO_P2_BINARY);
    constant TST_ATTR_STRLEN : integer := getstrlength(TST_ATTR_BINARY);
    constant TXPLL_COM_CFG_STRLEN : integer := getstrlength(TXPLL_COM_CFG_BINARY);
    constant TXPLL_CP_CFG_STRLEN : integer := getstrlength(TXPLL_CP_CFG_BINARY);
    constant TX_BYTECLK_CFG_STRLEN : integer := getstrlength(TX_BYTECLK_CFG_BINARY);
    constant TX_DETECT_RX_CFG_STRLEN : integer := getstrlength(TX_DETECT_RX_CFG_BINARY);
    constant TX_USRCLK_CFG_STRLEN : integer := getstrlength(TX_USRCLK_CFG_BINARY);

    -- Convert std_logic_vector to string
    constant BGTEST_CFG_STRING : string := SLV_TO_STR(BGTEST_CFG_BINARY);
    constant BIAS_CFG_STRING : string := SLV_TO_HEX(BIAS_CFG_BINARY, BIAS_CFG_STRLEN);
    constant CDR_PH_ADJ_TIME_STRING : string := SLV_TO_STR(CDR_PH_ADJ_TIME_BINARY);
    constant CHAN_BOND_SEQ_1_1_STRING : string := SLV_TO_STR(CHAN_BOND_SEQ_1_1_BINARY);
    constant CHAN_BOND_SEQ_1_2_STRING : string := SLV_TO_STR(CHAN_BOND_SEQ_1_2_BINARY);
    constant CHAN_BOND_SEQ_1_3_STRING : string := SLV_TO_STR(CHAN_BOND_SEQ_1_3_BINARY);
    constant CHAN_BOND_SEQ_1_4_STRING : string := SLV_TO_STR(CHAN_BOND_SEQ_1_4_BINARY);
    constant CHAN_BOND_SEQ_1_ENABLE_STRING : string := SLV_TO_STR(CHAN_BOND_SEQ_1_ENABLE_BINARY);
    constant CHAN_BOND_SEQ_2_1_STRING : string := SLV_TO_STR(CHAN_BOND_SEQ_2_1_BINARY);
    constant CHAN_BOND_SEQ_2_2_STRING : string := SLV_TO_STR(CHAN_BOND_SEQ_2_2_BINARY);
    constant CHAN_BOND_SEQ_2_3_STRING : string := SLV_TO_STR(CHAN_BOND_SEQ_2_3_BINARY);
    constant CHAN_BOND_SEQ_2_4_STRING : string := SLV_TO_STR(CHAN_BOND_SEQ_2_4_BINARY);
    constant CHAN_BOND_SEQ_2_CFG_STRING : string := SLV_TO_STR(CHAN_BOND_SEQ_2_CFG_BINARY);
    constant CHAN_BOND_SEQ_2_ENABLE_STRING : string := SLV_TO_STR(CHAN_BOND_SEQ_2_ENABLE_BINARY);
    constant CLK_COR_SEQ_1_1_STRING : string := SLV_TO_STR(CLK_COR_SEQ_1_1_BINARY);
    constant CLK_COR_SEQ_1_2_STRING : string := SLV_TO_STR(CLK_COR_SEQ_1_2_BINARY);
    constant CLK_COR_SEQ_1_3_STRING : string := SLV_TO_STR(CLK_COR_SEQ_1_3_BINARY);
    constant CLK_COR_SEQ_1_4_STRING : string := SLV_TO_STR(CLK_COR_SEQ_1_4_BINARY);
    constant CLK_COR_SEQ_1_ENABLE_STRING : string := SLV_TO_STR(CLK_COR_SEQ_1_ENABLE_BINARY);
    constant CLK_COR_SEQ_2_1_STRING : string := SLV_TO_STR(CLK_COR_SEQ_2_1_BINARY);
    constant CLK_COR_SEQ_2_2_STRING : string := SLV_TO_STR(CLK_COR_SEQ_2_2_BINARY);
    constant CLK_COR_SEQ_2_3_STRING : string := SLV_TO_STR(CLK_COR_SEQ_2_3_BINARY);
    constant CLK_COR_SEQ_2_4_STRING : string := SLV_TO_STR(CLK_COR_SEQ_2_4_BINARY);
    constant CLK_COR_SEQ_2_ENABLE_STRING : string := SLV_TO_STR(CLK_COR_SEQ_2_ENABLE_BINARY);
    constant CM_TRIM_STRING : string := SLV_TO_STR(CM_TRIM_BINARY);
    constant COMMA_10B_ENABLE_STRING : string := SLV_TO_STR(COMMA_10B_ENABLE_BINARY);
    constant COM_BURST_VAL_STRING : string := SLV_TO_STR(COM_BURST_VAL_BINARY);
    constant DFE_CAL_TIME_STRING : string := SLV_TO_STR(DFE_CAL_TIME_BINARY);
    constant DFE_CFG_STRING : string := SLV_TO_STR(DFE_CFG_BINARY);
    constant GEARBOX_ENDEC_STRING : string := SLV_TO_STR(GEARBOX_ENDEC_BINARY);
    constant MCOMMA_10B_VALUE_STRING : string := SLV_TO_STR(MCOMMA_10B_VALUE_BINARY);
    constant OOBDETECT_THRESHOLD_STRING : string := SLV_TO_STR(OOBDETECT_THRESHOLD_BINARY);
    constant PCOMMA_10B_VALUE_STRING : string := SLV_TO_STR(PCOMMA_10B_VALUE_BINARY);
    constant PMA_CDR_SCAN_STRING : string := SLV_TO_HEX(PMA_CDR_SCAN_BINARY,PMA_CDR_SCAN_STRLEN);
    constant PMA_CFG_STRING : string := SLV_TO_HEX(PMA_CFG_BINARY,PMA_CFG_STRLEN);
    constant PMA_RXSYNC_CFG_STRING : string := SLV_TO_HEX(PMA_RXSYNC_CFG_BINARY,PMA_RXSYNC_CFG_STRLEN);
    constant PMA_RX_CFG_STRING : string := SLV_TO_HEX(PMA_RX_CFG_BINARY,PMA_RX_CFG_STRLEN);
    constant PMA_TX_CFG_STRING : string := SLV_TO_HEX(PMA_TX_CFG_BINARY,PMA_TX_CFG_STRLEN);
    constant POWER_SAVE_STRING : string := SLV_TO_STR(POWER_SAVE_BINARY);
    constant RXPLL_COM_CFG_STRING : string := SLV_TO_HEX(RXPLL_COM_CFG_BINARY,RXPLL_COM_CFG_STRLEN);
    constant RXPLL_CP_CFG_STRING : string := SLV_TO_HEX(RXPLL_CP_CFG_BINARY,RXPLL_CP_CFG_STRLEN);
    constant RXPLL_LKDET_CFG_STRING : string := SLV_TO_STR(RXPLL_LKDET_CFG_BINARY);
    constant RXPRBSERR_LOOPBACK_STRING : string := SUL_TO_STR(RXPRBSERR_LOOPBACK_BINARY);
    constant RXRECCLK_DLY_STRING : string := SLV_TO_STR(RXRECCLK_DLY_BINARY);
    constant RXUSRCLK_DLY_STRING : string := SLV_TO_HEX(RXUSRCLK_DLY_BINARY,RXUSRCLK_DLY_STRLEN);
    constant RX_DLYALIGN_CTRINC_STRING : string := SLV_TO_STR(RX_DLYALIGN_CTRINC_BINARY);
    constant RX_DLYALIGN_EDGESET_STRING : string := SLV_TO_STR(RX_DLYALIGN_EDGESET_BINARY);
    constant RX_DLYALIGN_LPFINC_STRING : string := SLV_TO_STR(RX_DLYALIGN_LPFINC_BINARY);
    constant RX_DLYALIGN_MONSEL_STRING : string := SLV_TO_STR(RX_DLYALIGN_MONSEL_BINARY);
    constant RX_DLYALIGN_OVRDSETTING_STRING : string := SLV_TO_STR(RX_DLYALIGN_OVRDSETTING_BINARY);
    constant RX_EYE_OFFSET_STRING : string := SLV_TO_HEX(RX_EYE_OFFSET_BINARY,RX_EYE_OFFSET_STRLEN);
    constant RX_EYE_SCANMODE_STRING : string := SLV_TO_STR(RX_EYE_SCANMODE_BINARY);
    constant RX_IDLE_HI_CNT_STRING : string := SLV_TO_STR(RX_IDLE_HI_CNT_BINARY);
    constant RX_IDLE_LO_CNT_STRING : string := SLV_TO_STR(RX_IDLE_LO_CNT_BINARY);
    constant SATA_BURST_VAL_STRING : string := SLV_TO_STR(SATA_BURST_VAL_BINARY);
    constant SATA_IDLE_VAL_STRING : string := SLV_TO_STR(SATA_IDLE_VAL_BINARY);
    constant SIM_RXREFCLK_SOURCE_STRING : string := SLV_TO_STR(SIM_RXREFCLK_SOURCE_BINARY);
    constant SIM_TXREFCLK_SOURCE_STRING : string := SLV_TO_STR(SIM_TXREFCLK_SOURCE_BINARY);
    constant TERMINATION_CTRL_STRING : string := SLV_TO_STR(TERMINATION_CTRL_BINARY);
    constant TRANS_TIME_FROM_P2_STRING : string := SLV_TO_HEX(TRANS_TIME_FROM_P2_BINARY,TRANS_TIME_FROM_P2_STRLEN);
    constant TRANS_TIME_NON_P2_STRING : string := SLV_TO_HEX(TRANS_TIME_NON_P2_BINARY,TRANS_TIME_NON_P2_STRLEN);
    constant TRANS_TIME_RATE_STRING : string := SLV_TO_HEX(TRANS_TIME_RATE_BINARY,TRANS_TIME_RATE_STRLEN);
    constant TRANS_TIME_TO_P2_STRING : string := SLV_TO_HEX(TRANS_TIME_TO_P2_BINARY,TRANS_TIME_TO_P2_STRLEN);
    constant TST_ATTR_STRING : string := SLV_TO_HEX(TST_ATTR_BINARY,TST_ATTR_STRLEN);
    constant TXOUTCLK_DLY_STRING : string := SLV_TO_STR(TXOUTCLK_DLY_BINARY);
    constant TXPLL_COM_CFG_STRING : string := SLV_TO_HEX(TXPLL_COM_CFG_BINARY,TXPLL_COM_CFG_STRLEN);
    constant TXPLL_CP_CFG_STRING : string := SLV_TO_HEX(TXPLL_CP_CFG_BINARY,TXPLL_CP_CFG_STRLEN);
    constant TXPLL_LKDET_CFG_STRING : string := SLV_TO_STR(TXPLL_LKDET_CFG_BINARY);
    constant TXPLL_SATA_STRING : string := SLV_TO_STR(TXPLL_SATA_BINARY);
    constant TX_BYTECLK_CFG_STRING : string := SLV_TO_HEX(TX_BYTECLK_CFG_BINARY,TX_BYTECLK_CFG_STRLEN);
    constant TX_DEEMPH_0_STRING : string := SLV_TO_STR(TX_DEEMPH_0_BINARY);
    constant TX_DEEMPH_1_STRING : string := SLV_TO_STR(TX_DEEMPH_1_BINARY);
    constant TX_DETECT_RX_CFG_STRING : string := SLV_TO_HEX(TX_DETECT_RX_CFG_BINARY, TX_DETECT_RX_CFG_STRLEN);
    constant TX_DLYALIGN_CTRINC_STRING : string := SLV_TO_STR(TX_DLYALIGN_CTRINC_BINARY);
    constant TX_DLYALIGN_LPFINC_STRING : string := SLV_TO_STR(TX_DLYALIGN_LPFINC_BINARY);
    constant TX_DLYALIGN_MONSEL_STRING : string := SLV_TO_STR(TX_DLYALIGN_MONSEL_BINARY);
    constant TX_DLYALIGN_OVRDSETTING_STRING : string := SLV_TO_STR(TX_DLYALIGN_OVRDSETTING_BINARY);
    constant TX_IDLE_ASSERT_DELAY_STRING : string := SLV_TO_STR(TX_IDLE_ASSERT_DELAY_BINARY);
    constant TX_IDLE_DEASSERT_DELAY_STRING : string := SLV_TO_STR(TX_IDLE_DEASSERT_DELAY_BINARY);
    constant TX_MARGIN_FULL_0_STRING : string := SLV_TO_STR(TX_MARGIN_FULL_0_BINARY);
    constant TX_MARGIN_FULL_1_STRING : string := SLV_TO_STR(TX_MARGIN_FULL_1_BINARY);
    constant TX_MARGIN_FULL_2_STRING : string := SLV_TO_STR(TX_MARGIN_FULL_2_BINARY);
    constant TX_MARGIN_FULL_3_STRING : string := SLV_TO_STR(TX_MARGIN_FULL_3_BINARY);
    constant TX_MARGIN_FULL_4_STRING : string := SLV_TO_STR(TX_MARGIN_FULL_4_BINARY);
    constant TX_MARGIN_LOW_0_STRING : string := SLV_TO_STR(TX_MARGIN_LOW_0_BINARY);
    constant TX_MARGIN_LOW_1_STRING : string := SLV_TO_STR(TX_MARGIN_LOW_1_BINARY);
    constant TX_MARGIN_LOW_2_STRING : string := SLV_TO_STR(TX_MARGIN_LOW_2_BINARY);
    constant TX_MARGIN_LOW_3_STRING : string := SLV_TO_STR(TX_MARGIN_LOW_3_BINARY);
    constant TX_MARGIN_LOW_4_STRING : string := SLV_TO_STR(TX_MARGIN_LOW_4_BINARY);
    constant TX_PMADATA_OPT_STRING : string := SUL_TO_STR(TX_PMADATA_OPT_BINARY);
    constant TX_TDCC_CFG_STRING : string := SLV_TO_STR(TX_TDCC_CFG_BINARY);
    constant TX_USRCLK_CFG_STRING : string := SLV_TO_HEX(TX_USRCLK_CFG_BINARY,TX_USRCLK_CFG_STRLEN);
    
    -- Convert boolean to string
    constant AC_CAP_DIS_STRING : string := boolean_to_string(AC_CAP_DIS);
    constant CHAN_BOND_KEEP_ALIGN_STRING : string := boolean_to_string(CHAN_BOND_KEEP_ALIGN);
    constant CHAN_BOND_SEQ_2_USE_STRING : string := boolean_to_string(CHAN_BOND_SEQ_2_USE);
    constant CLK_CORRECT_USE_STRING : string := boolean_to_string(CLK_CORRECT_USE);
    constant CLK_COR_INSERT_IDLE_FLAG_STRING : string := boolean_to_string(CLK_COR_INSERT_IDLE_FLAG);
    constant CLK_COR_KEEP_IDLE_STRING : string := boolean_to_string(CLK_COR_KEEP_IDLE);
    constant CLK_COR_PRECEDENCE_STRING : string := boolean_to_string(CLK_COR_PRECEDENCE);
    constant CLK_COR_SEQ_2_USE_STRING : string := boolean_to_string(CLK_COR_SEQ_2_USE);
    constant COMMA_DOUBLE_STRING : string := boolean_to_string(COMMA_DOUBLE);
    constant DEC_MCOMMA_DETECT_STRING : string := boolean_to_string(DEC_MCOMMA_DETECT);
    constant DEC_PCOMMA_DETECT_STRING : string := boolean_to_string(DEC_PCOMMA_DETECT);
    constant DEC_VALID_COMMA_ONLY_STRING : string := boolean_to_string(DEC_VALID_COMMA_ONLY);
    constant GEN_RXUSRCLK_STRING : string := boolean_to_string(GEN_RXUSRCLK);
    constant GEN_TXUSRCLK_STRING : string := boolean_to_string(GEN_TXUSRCLK);
    constant GTX_CFG_PWRUP_STRING : string := boolean_to_string(GTX_CFG_PWRUP);
    constant MCOMMA_DETECT_STRING : string := boolean_to_string(MCOMMA_DETECT);
    constant PCI_EXPRESS_MODE_STRING : string := boolean_to_string(PCI_EXPRESS_MODE);
    constant PCOMMA_DETECT_STRING : string := boolean_to_string(PCOMMA_DETECT);
    constant PMA_CAS_CLK_EN_STRING : string := boolean_to_string(PMA_CAS_CLK_EN);
    constant RCV_TERM_GND_STRING : string := boolean_to_string(RCV_TERM_GND);
    constant RCV_TERM_VTTRX_STRING : string := boolean_to_string(RCV_TERM_VTTRX);
    constant RXGEARBOX_USE_STRING : string := boolean_to_string(RXGEARBOX_USE);
    constant RX_BUFFER_USE_STRING : string := boolean_to_string(RX_BUFFER_USE);
    constant RX_DECODE_SEQ_MATCH_STRING : string := boolean_to_string(RX_DECODE_SEQ_MATCH);
    constant RX_EN_IDLE_HOLD_CDR_STRING : string := boolean_to_string(RX_EN_IDLE_HOLD_CDR);
    constant RX_EN_IDLE_HOLD_DFE_STRING : string := boolean_to_string(RX_EN_IDLE_HOLD_DFE);
    constant RX_EN_IDLE_RESET_BUF_STRING : string := boolean_to_string(RX_EN_IDLE_RESET_BUF);
    constant RX_EN_IDLE_RESET_FR_STRING : string := boolean_to_string(RX_EN_IDLE_RESET_FR);
    constant RX_EN_IDLE_RESET_PH_STRING : string := boolean_to_string(RX_EN_IDLE_RESET_PH);
    constant RX_EN_MODE_RESET_BUF_STRING : string := boolean_to_string(RX_EN_MODE_RESET_BUF);
    constant RX_EN_RATE_RESET_BUF_STRING : string := boolean_to_string(RX_EN_RATE_RESET_BUF);
    constant RX_EN_REALIGN_RESET_BUF2_STRING : string := boolean_to_string(RX_EN_REALIGN_RESET_BUF2);
    constant RX_EN_REALIGN_RESET_BUF_STRING : string := boolean_to_string(RX_EN_REALIGN_RESET_BUF);
    constant RX_LOSS_OF_SYNC_FSM_STRING : string := boolean_to_string(RX_LOSS_OF_SYNC_FSM);
    constant RX_OVERSAMPLE_MODE_STRING : string := boolean_to_string(RX_OVERSAMPLE_MODE);
    constant SHOW_REALIGN_COMMA_STRING : string := boolean_to_string(SHOW_REALIGN_COMMA);
    constant SIM_RECEIVER_DETECT_PASS_STRING : string := boolean_to_string(SIM_RECEIVER_DETECT_PASS);
    constant TERMINATION_OVRD_STRING : string := boolean_to_string(TERMINATION_OVRD);
    constant TXDRIVE_LOOPBACK_HIZ_STRING : string := boolean_to_string(TXDRIVE_LOOPBACK_HIZ);
    constant TXDRIVE_LOOPBACK_PD_STRING : string := boolean_to_string(TXDRIVE_LOOPBACK_PD);
    constant TXGEARBOX_USE_STRING : string := boolean_to_string(TXGEARBOX_USE);
    constant TX_BUFFER_USE_STRING : string := boolean_to_string(TX_BUFFER_USE);
    constant TX_EN_RATE_RESET_BUF_STRING : string := boolean_to_string(TX_EN_RATE_RESET_BUF);
    constant TX_OVERSAMPLE_MODE_STRING : string := boolean_to_string(TX_OVERSAMPLE_MODE);
    
    signal AC_CAP_DIS_BINARY : std_ulogic;
    signal ALIGN_COMMA_WORD_BINARY : std_ulogic;
    signal CHAN_BOND_1_MAX_SKEW_BINARY : std_logic_vector(3 downto 0);
    signal CHAN_BOND_2_MAX_SKEW_BINARY : std_logic_vector(3 downto 0);
    signal CHAN_BOND_KEEP_ALIGN_BINARY : std_ulogic;
    signal CHAN_BOND_SEQ_2_USE_BINARY : std_ulogic;
    signal CHAN_BOND_SEQ_LEN_BINARY : std_logic_vector(1 downto 0);
    signal CLK_CORRECT_USE_BINARY : std_ulogic;
    signal CLK_COR_ADJ_LEN_BINARY : std_logic_vector(1 downto 0);
    signal CLK_COR_DET_LEN_BINARY : std_logic_vector(1 downto 0);
    signal CLK_COR_INSERT_IDLE_FLAG_BINARY : std_ulogic;
    signal CLK_COR_KEEP_IDLE_BINARY : std_ulogic;
    signal CLK_COR_MAX_LAT_BINARY : std_logic_vector(5 downto 0);
    signal CLK_COR_MIN_LAT_BINARY : std_logic_vector(5 downto 0);
    signal CLK_COR_PRECEDENCE_BINARY : std_ulogic;
    signal CLK_COR_REPEAT_WAIT_BINARY : std_logic_vector(4 downto 0);
    signal CLK_COR_SEQ_2_USE_BINARY : std_ulogic;
    signal COMMA_DOUBLE_BINARY : std_ulogic;
    signal DEC_MCOMMA_DETECT_BINARY : std_ulogic;
    signal DEC_PCOMMA_DETECT_BINARY : std_ulogic;
    signal DEC_VALID_COMMA_ONLY_BINARY : std_ulogic;
    signal GEN_RXUSRCLK_BINARY : std_ulogic;
    signal GEN_TXUSRCLK_BINARY : std_ulogic;
    signal GTX_CFG_PWRUP_BINARY : std_ulogic;
    signal MCOMMA_DETECT_BINARY : std_ulogic;
    signal PCI_EXPRESS_MODE_BINARY : std_ulogic;
    signal PCOMMA_DETECT_BINARY : std_ulogic;
    signal PMA_CAS_CLK_EN_BINARY : std_ulogic;
    signal RCV_TERM_GND_BINARY : std_ulogic;
    signal RCV_TERM_VTTRX_BINARY : std_ulogic;
    signal RXGEARBOX_USE_BINARY : std_ulogic;
    signal RXPLL_DIVSEL45_FB_BINARY : std_ulogic;
    signal RXPLL_DIVSEL_FB_BINARY : std_logic_vector(4 downto 0);
    signal RXPLL_DIVSEL_OUT_BINARY : std_logic_vector(1 downto 0);
    signal RXPLL_DIVSEL_REF_BINARY : std_logic_vector(4 downto 0);
    signal RXRECCLK_CTRL_BINARY : std_logic_vector(2 downto 0);
    signal RX_BUFFER_USE_BINARY : std_ulogic;
    signal RX_CLK25_DIVIDER_BINARY : std_logic_vector(4 downto 0);
    signal RX_DATA_WIDTH_BINARY : std_logic_vector(2 downto 0);
    signal RX_DECODE_SEQ_MATCH_BINARY : std_ulogic;
    signal RX_EN_IDLE_HOLD_CDR_BINARY : std_ulogic;
    signal RX_EN_IDLE_HOLD_DFE_BINARY : std_ulogic;
    signal RX_EN_IDLE_RESET_BUF_BINARY : std_ulogic;
    signal RX_EN_IDLE_RESET_FR_BINARY : std_ulogic;
    signal RX_EN_IDLE_RESET_PH_BINARY : std_ulogic;
    signal RX_EN_MODE_RESET_BUF_BINARY : std_ulogic;
    signal RX_EN_RATE_RESET_BUF_BINARY : std_ulogic;
    signal RX_EN_REALIGN_RESET_BUF2_BINARY : std_ulogic;
    signal RX_EN_REALIGN_RESET_BUF_BINARY : std_ulogic;
    signal RX_FIFO_ADDR_MODE_BINARY : std_ulogic;
    signal RX_LOSS_OF_SYNC_FSM_BINARY : std_ulogic;
    signal RX_LOS_INVALID_INCR_BINARY : std_logic_vector(2 downto 0);
    signal RX_LOS_THRESHOLD_BINARY : std_logic_vector(2 downto 0);
    signal RX_OVERSAMPLE_MODE_BINARY : std_ulogic;
    signal RX_SLIDE_AUTO_WAIT_BINARY : std_logic_vector(3 downto 0);
    signal RX_SLIDE_MODE_BINARY : std_logic_vector(1 downto 0);
    signal RX_XCLK_SEL_BINARY : std_ulogic;
    signal SAS_MAX_COMSAS_BINARY : std_logic_vector(5 downto 0);
    signal SAS_MIN_COMSAS_BINARY : std_logic_vector(5 downto 0);
    signal SATA_MAX_BURST_BINARY : std_logic_vector(5 downto 0);
    signal SATA_MAX_INIT_BINARY : std_logic_vector(5 downto 0);
    signal SATA_MAX_WAKE_BINARY : std_logic_vector(5 downto 0);
    signal SATA_MIN_BURST_BINARY : std_logic_vector(5 downto 0);
    signal SATA_MIN_INIT_BINARY : std_logic_vector(5 downto 0);
    signal SATA_MIN_WAKE_BINARY : std_logic_vector(5 downto 0);
    signal SHOW_REALIGN_COMMA_BINARY : std_ulogic;
    signal SIM_GTXRESET_SPEEDUP_BINARY : std_ulogic;
    signal SIM_RECEIVER_DETECT_PASS_BINARY : std_ulogic;
    signal SIM_TX_ELEC_IDLE_LEVEL_BINARY : std_ulogic;
    signal SIM_VERSION_BINARY : std_ulogic;
    signal TERMINATION_OVRD_BINARY : std_ulogic;
    signal TXDRIVE_LOOPBACK_HIZ_BINARY : std_ulogic;
    signal TXDRIVE_LOOPBACK_PD_BINARY : std_ulogic;
    signal TXGEARBOX_USE_BINARY : std_ulogic;
    signal TXOUTCLK_CTRL_BINARY : std_logic_vector(2 downto 0);
    signal TXPLL_DIVSEL45_FB_BINARY : std_ulogic;
    signal TXPLL_DIVSEL_FB_BINARY : std_logic_vector(4 downto 0);
    signal TXPLL_DIVSEL_OUT_BINARY : std_logic_vector(1 downto 0);
    signal TXPLL_DIVSEL_REF_BINARY : std_logic_vector(4 downto 0);
    signal TX_BUFFER_USE_BINARY : std_ulogic;
    signal TX_CLK25_DIVIDER_BINARY : std_logic_vector(4 downto 0);
    signal TX_CLK_SOURCE_BINARY : std_ulogic;
    signal TX_DATA_WIDTH_BINARY : std_logic_vector(2 downto 0);
    signal TX_DRIVE_MODE_BINARY : std_ulogic;
    signal TX_EN_RATE_RESET_BUF_BINARY : std_ulogic;
    signal TX_OVERSAMPLE_MODE_BINARY : std_ulogic;
    signal TX_XCLK_SEL_BINARY : std_ulogic;
    
    signal COMFINISH_out : std_ulogic;
    signal COMINITDET_out : std_ulogic;
    signal COMSASDET_out : std_ulogic;
    signal COMWAKEDET_out : std_ulogic;
    signal DFECLKDLYADJMON_out : std_logic_vector(5 downto 0);
    signal DFEEYEDACMON_out : std_logic_vector(4 downto 0);
    signal DFESENSCAL_out : std_logic_vector(2 downto 0);
    signal DFETAP1MONITOR_out : std_logic_vector(4 downto 0);
    signal DFETAP2MONITOR_out : std_logic_vector(4 downto 0);
    signal DFETAP3MONITOR_out : std_logic_vector(3 downto 0);
    signal DFETAP4MONITOR_out : std_logic_vector(3 downto 0);
    signal DRDY_out : std_ulogic;
    signal DRPDO_out : std_logic_vector(15 downto 0);
    signal MGTREFCLKFAB_out : std_logic_vector(1 downto 0);
    signal PHYSTATUS_out : std_ulogic;
    signal RXBUFSTATUS_out : std_logic_vector(2 downto 0);
    signal RXBYTEISALIGNED_out : std_ulogic;
    signal RXBYTEREALIGN_out : std_ulogic;
    signal RXCHANBONDSEQ_out : std_ulogic;
    signal RXCHANISALIGNED_out : std_ulogic;
    signal RXCHANREALIGN_out : std_ulogic;
    signal RXCHARISCOMMA_out : std_logic_vector(3 downto 0);
    signal RXCHARISK_out : std_logic_vector(3 downto 0);
    signal RXCHBONDO_out : std_logic_vector(3 downto 0);
    signal RXCLKCORCNT_out : std_logic_vector(2 downto 0);
    signal RXCOMMADET_out : std_ulogic;
    signal RXDATAVALID_out : std_ulogic;
    signal RXDATA_out : std_logic_vector(31 downto 0);
    signal RXDISPERR_out : std_logic_vector(3 downto 0);
    signal RXDLYALIGNMONITOR_out : std_logic_vector(7 downto 0);
    signal RXELECIDLE_out : std_ulogic;
    signal RXHEADERVALID_out : std_ulogic;
    signal RXHEADER_out : std_logic_vector(2 downto 0);
    signal RXLOSSOFSYNC_out : std_logic_vector(1 downto 0);
    signal RXNOTINTABLE_out : std_logic_vector(3 downto 0);
    signal RXOVERSAMPLEERR_out : std_ulogic;
    signal RXPLLLKDET_out : std_ulogic;
    signal RXPRBSERR_out : std_ulogic;
    signal RXRATEDONE_out : std_ulogic;
    signal RXRECCLKPCS_out : std_ulogic;
    signal RXRECCLK_out : std_ulogic;
    signal RXRESETDONE_out : std_ulogic;
    signal RXRUNDISP_out : std_logic_vector(3 downto 0);
    signal RXSTARTOFSEQ_out : std_ulogic;
    signal RXSTATUS_out : std_logic_vector(2 downto 0);
    signal RXVALID_out : std_ulogic;
    signal TSTOUT_out : std_logic_vector(9 downto 0);
    signal TXBUFSTATUS_out : std_logic_vector(1 downto 0);
    signal TXDLYALIGNMONITOR_out : std_logic_vector(7 downto 0);
    signal TXGEARBOXREADY_out : std_ulogic;
    signal TXKERR_out : std_logic_vector(3 downto 0);
    signal TXN_out : std_ulogic;
    signal TXOUTCLKPCS_out : std_ulogic;
    signal TXOUTCLK_out : std_ulogic;
    signal TXPLLLKDET_out : std_ulogic;
    signal TXP_out : std_ulogic;
    signal TXRATEDONE_out : std_ulogic;
    signal TXRESETDONE_out : std_ulogic;
    signal TXRUNDISP_out : std_logic_vector(3 downto 0);
    
    signal COMFINISH_outdelay : std_ulogic;
    signal COMINITDET_outdelay : std_ulogic;
    signal COMSASDET_outdelay : std_ulogic;
    signal COMWAKEDET_outdelay : std_ulogic;
    signal DFECLKDLYADJMON_outdelay : std_logic_vector(5 downto 0);
    signal DFEEYEDACMON_outdelay : std_logic_vector(4 downto 0);
    signal DFESENSCAL_outdelay : std_logic_vector(2 downto 0);
    signal DFETAP1MONITOR_outdelay : std_logic_vector(4 downto 0);
    signal DFETAP2MONITOR_outdelay : std_logic_vector(4 downto 0);
    signal DFETAP3MONITOR_outdelay : std_logic_vector(3 downto 0);
    signal DFETAP4MONITOR_outdelay : std_logic_vector(3 downto 0);
    signal DRDY_outdelay : std_ulogic;
    signal DRPDO_outdelay : std_logic_vector(15 downto 0);
    signal MGTREFCLKFAB_outdelay : std_logic_vector(1 downto 0);
    signal PHYSTATUS_outdelay : std_ulogic;
    signal RXBUFSTATUS_outdelay : std_logic_vector(2 downto 0);
    signal RXBYTEISALIGNED_outdelay : std_ulogic;
    signal RXBYTEREALIGN_outdelay : std_ulogic;
    signal RXCHANBONDSEQ_outdelay : std_ulogic;
    signal RXCHANISALIGNED_outdelay : std_ulogic;
    signal RXCHANREALIGN_outdelay : std_ulogic;
    signal RXCHARISCOMMA_outdelay : std_logic_vector(3 downto 0);
    signal RXCHARISK_outdelay : std_logic_vector(3 downto 0);
    signal RXCHBONDO_outdelay : std_logic_vector(3 downto 0);
    signal RXCLKCORCNT_outdelay : std_logic_vector(2 downto 0);
    signal RXCOMMADET_outdelay : std_ulogic;
    signal RXDATAVALID_outdelay : std_ulogic;
    signal RXDATA_outdelay : std_logic_vector(31 downto 0);
    signal RXDISPERR_outdelay : std_logic_vector(3 downto 0);
    signal RXDLYALIGNMONITOR_outdelay : std_logic_vector(7 downto 0);
    signal RXELECIDLE_outdelay : std_ulogic;
    signal RXHEADERVALID_outdelay : std_ulogic;
    signal RXHEADER_outdelay : std_logic_vector(2 downto 0);
    signal RXLOSSOFSYNC_outdelay : std_logic_vector(1 downto 0);
    signal RXNOTINTABLE_outdelay : std_logic_vector(3 downto 0);
    signal RXOVERSAMPLEERR_outdelay : std_ulogic;
    signal RXPLLLKDET_outdelay : std_ulogic;
    signal RXPRBSERR_outdelay : std_ulogic;
    signal RXRATEDONE_outdelay : std_ulogic;
    signal RXRECCLKPCS_outdelay : std_ulogic;
    signal RXRECCLK_outdelay : std_ulogic;
    signal RXRESETDONE_outdelay : std_ulogic;
    signal RXRUNDISP_outdelay : std_logic_vector(3 downto 0);
    signal RXSTARTOFSEQ_outdelay : std_ulogic;
    signal RXSTATUS_outdelay : std_logic_vector(2 downto 0);
    signal RXVALID_outdelay : std_ulogic;
    signal TSTOUT_outdelay : std_logic_vector(9 downto 0);
    signal TXBUFSTATUS_outdelay : std_logic_vector(1 downto 0);
    signal TXDLYALIGNMONITOR_outdelay : std_logic_vector(7 downto 0);
    signal TXGEARBOXREADY_outdelay : std_ulogic;
    signal TXKERR_outdelay : std_logic_vector(3 downto 0);
    signal TXN_outdelay : std_ulogic;
    signal TXOUTCLKPCS_outdelay : std_ulogic;
    signal TXOUTCLK_outdelay : std_ulogic;
    signal TXPLLLKDET_outdelay : std_ulogic;
    signal TXP_outdelay : std_ulogic;
    signal TXRATEDONE_outdelay : std_ulogic;
    signal TXRESETDONE_outdelay : std_ulogic;
    signal TXRUNDISP_outdelay : std_logic_vector(3 downto 0);
    
    signal DADDR_ipd : std_logic_vector(7 downto 0);
    signal DCLK_ipd : std_ulogic;
    signal DEN_ipd : std_ulogic;
    signal DFECLKDLYADJ_ipd : std_logic_vector(5 downto 0);
    signal DFEDLYOVRD_ipd : std_ulogic;
    signal DFETAP1_ipd : std_logic_vector(4 downto 0);
    signal DFETAP2_ipd : std_logic_vector(4 downto 0);
    signal DFETAP3_ipd : std_logic_vector(3 downto 0);
    signal DFETAP4_ipd : std_logic_vector(3 downto 0);
    signal DFETAPOVRD_ipd : std_ulogic;
    signal DI_ipd : std_logic_vector(15 downto 0);
    signal DWE_ipd : std_ulogic;
    signal GATERXELECIDLE_ipd : std_ulogic;
    signal GREFCLKRX_ipd : std_ulogic;
    signal GREFCLKTX_ipd : std_ulogic;
    signal GTXRXRESET_ipd : std_ulogic;
    signal GTXTEST_ipd : std_logic_vector(12 downto 0);
    signal GTXTXRESET_ipd : std_ulogic;
    signal IGNORESIGDET_ipd : std_ulogic;
    signal LOOPBACK_ipd : std_logic_vector(2 downto 0);
    signal MGTREFCLKRX_ipd : std_logic_vector(1 downto 0);
    signal MGTREFCLKTX_ipd : std_logic_vector(1 downto 0);
    signal NORTHREFCLKRX_ipd : std_logic_vector(1 downto 0);
    signal NORTHREFCLKTX_ipd : std_logic_vector(1 downto 0);
    signal PERFCLKRX_ipd : std_ulogic;
    signal PERFCLKTX_ipd : std_ulogic;
    signal PLLRXRESET_ipd : std_ulogic;
    signal PLLTXRESET_ipd : std_ulogic;
    signal PRBSCNTRESET_ipd : std_ulogic;
    signal RXBUFRESET_ipd : std_ulogic;
    signal RXCDRRESET_ipd : std_ulogic;
    signal RXCHBONDI_ipd : std_logic_vector(3 downto 0);
    signal RXCHBONDLEVEL_ipd : std_logic_vector(2 downto 0);
    signal RXCHBONDMASTER_ipd : std_ulogic;
    signal RXCHBONDSLAVE_ipd : std_ulogic;
    signal RXCOMMADETUSE_ipd : std_ulogic;
    signal RXDEC8B10BUSE_ipd : std_ulogic;
    signal RXDLYALIGNDISABLE_ipd : std_ulogic;
    signal RXDLYALIGNMONENB_ipd : std_ulogic;
    signal RXDLYALIGNOVERRIDE_ipd : std_ulogic;
    signal RXDLYALIGNRESET_ipd : std_ulogic;
    signal RXDLYALIGNSWPPRECURB_ipd : std_ulogic;
    signal RXDLYALIGNUPDSW_ipd : std_ulogic;
    signal RXENCHANSYNC_ipd : std_ulogic;
    signal RXENMCOMMAALIGN_ipd : std_ulogic;
    signal RXENPCOMMAALIGN_ipd : std_ulogic;
    signal RXENPMAPHASEALIGN_ipd : std_ulogic;
    signal RXENPRBSTST_ipd : std_logic_vector(2 downto 0);
    signal RXENSAMPLEALIGN_ipd : std_ulogic;
    signal RXEQMIX_ipd : std_logic_vector(9 downto 0);
    signal RXGEARBOXSLIP_ipd : std_ulogic;
    signal RXN_ipd : std_ulogic;
    signal RXPLLLKDETEN_ipd : std_ulogic;
    signal RXPLLPOWERDOWN_ipd : std_ulogic;
    signal RXPLLREFSELDY_ipd : std_logic_vector(2 downto 0);
    signal RXPMASETPHASE_ipd : std_ulogic;
    signal RXPOLARITY_ipd : std_ulogic;
    signal RXPOWERDOWN_ipd : std_logic_vector(1 downto 0);
    signal RXP_ipd : std_ulogic;
    signal RXRATE_ipd : std_logic_vector(1 downto 0);
    signal RXRESET_ipd : std_ulogic;
    signal RXSLIDE_ipd : std_ulogic;
    signal RXUSRCLK2_ipd : std_ulogic;
    signal RXUSRCLK_ipd : std_ulogic;
    signal SOUTHREFCLKRX_ipd : std_logic_vector(1 downto 0);
    signal SOUTHREFCLKTX_ipd : std_logic_vector(1 downto 0);
    signal TSTCLK0_ipd : std_ulogic;
    signal TSTCLK1_ipd : std_ulogic;
    signal TSTIN_ipd : std_logic_vector(19 downto 0);
    signal TXBUFDIFFCTRL_ipd : std_logic_vector(2 downto 0);
    signal TXBYPASS8B10B_ipd : std_logic_vector(3 downto 0);
    signal TXCHARDISPMODE_ipd : std_logic_vector(3 downto 0);
    signal TXCHARDISPVAL_ipd : std_logic_vector(3 downto 0);
    signal TXCHARISK_ipd : std_logic_vector(3 downto 0);
    signal TXCOMINIT_ipd : std_ulogic;
    signal TXCOMSAS_ipd : std_ulogic;
    signal TXCOMWAKE_ipd : std_ulogic;
    signal TXDATA_ipd : std_logic_vector(31 downto 0);
    signal TXDEEMPH_ipd : std_ulogic;
    signal TXDETECTRX_ipd : std_ulogic;
    signal TXDIFFCTRL_ipd : std_logic_vector(3 downto 0);
    signal TXDLYALIGNDISABLE_ipd : std_ulogic;
    signal TXDLYALIGNMONENB_ipd : std_ulogic;
    signal TXDLYALIGNOVERRIDE_ipd : std_ulogic;
    signal TXDLYALIGNRESET_ipd : std_ulogic;
    signal TXDLYALIGNUPDSW_ipd : std_ulogic;
    signal TXELECIDLE_ipd : std_ulogic;
    signal TXENC8B10BUSE_ipd : std_ulogic;
    signal TXENPMAPHASEALIGN_ipd : std_ulogic;
    signal TXENPRBSTST_ipd : std_logic_vector(2 downto 0);
    signal TXHEADER_ipd : std_logic_vector(2 downto 0);
    signal TXINHIBIT_ipd : std_ulogic;
    signal TXMARGIN_ipd : std_logic_vector(2 downto 0);
    signal TXPDOWNASYNCH_ipd : std_ulogic;
    signal TXPLLLKDETEN_ipd : std_ulogic;
    signal TXPLLPOWERDOWN_ipd : std_ulogic;
    signal TXPLLREFSELDY_ipd : std_logic_vector(2 downto 0);
    signal TXPMASETPHASE_ipd : std_ulogic;
    signal TXPOLARITY_ipd : std_ulogic;
    signal TXPOSTEMPHASIS_ipd : std_logic_vector(4 downto 0);
    signal TXPOWERDOWN_ipd : std_logic_vector(1 downto 0);
    signal TXPRBSFORCEERR_ipd : std_ulogic;
    signal TXPREEMPHASIS_ipd : std_logic_vector(3 downto 0);
    signal TXRATE_ipd : std_logic_vector(1 downto 0);
    signal TXRESET_ipd : std_ulogic;
    signal TXSEQUENCE_ipd : std_logic_vector(6 downto 0);
    signal TXSTARTSEQ_ipd : std_ulogic;
    signal TXSWING_ipd : std_ulogic;
    signal TXUSRCLK2_ipd : std_ulogic;
    signal TXUSRCLK_ipd : std_ulogic;
    signal USRCODEERR_ipd : std_ulogic;
    
    signal DADDR_DCLK_dly : std_logic_vector(7 downto 0);
    signal DCLK_dly : std_ulogic;
    signal DEN_DCLK_dly : std_ulogic;
    signal DFECLKDLYADJ_RXUSRCLK2_dly : std_logic_vector(5 downto 0);
    signal DFEDLYOVRD_RXUSRCLK2_dly : std_ulogic;
    signal DFETAP1_RXUSRCLK2_dly : std_logic_vector(4 downto 0);
    signal DFETAP2_RXUSRCLK2_dly : std_logic_vector(4 downto 0);
    signal DFETAP3_RXUSRCLK2_dly : std_logic_vector(3 downto 0);
    signal DFETAP4_RXUSRCLK2_dly : std_logic_vector(3 downto 0);
    signal DFETAPOVRD_RXUSRCLK2_dly : std_ulogic;
    signal DI_DCLK_dly : std_logic_vector(15 downto 0);
    signal DWE_DCLK_dly : std_ulogic;
    signal GATERXELECIDLE_dly : std_ulogic;
    signal GREFCLKRX_dly : std_ulogic;
    signal GREFCLKTX_dly : std_ulogic;
    signal GTXRXRESET_dly : std_ulogic;
    signal GTXTEST_dly : std_logic_vector(12 downto 0);
    signal GTXTXRESET_dly : std_ulogic;
    signal IGNORESIGDET_dly : std_ulogic;
    signal LOOPBACK_dly : std_logic_vector(2 downto 0);
    signal MGTREFCLKRX_dly : std_logic_vector(1 downto 0);
    signal MGTREFCLKTX_dly : std_logic_vector(1 downto 0);
    signal NORTHREFCLKRX_dly : std_logic_vector(1 downto 0);
    signal NORTHREFCLKTX_dly : std_logic_vector(1 downto 0);
    signal PERFCLKRX_dly : std_ulogic;
    signal PERFCLKTX_dly : std_ulogic;
    signal PLLRXRESET_dly : std_ulogic;
    signal PLLTXRESET_dly : std_ulogic;
    signal PRBSCNTRESET_RXUSRCLK2_dly : std_ulogic;
    signal RXBUFRESET_dly : std_ulogic;
    signal RXCDRRESET_dly : std_ulogic;
    signal RXCHBONDI_RXUSRCLK2_dly : std_logic_vector(3 downto 0);
    signal RXCHBONDI_RXUSRCLK_dly : std_logic_vector(3 downto 0);
    signal RXCHBONDLEVEL_RXUSRCLK2_dly : std_logic_vector(2 downto 0);
    signal RXCHBONDMASTER_RXUSRCLK2_dly : std_ulogic;
    signal RXCHBONDSLAVE_RXUSRCLK2_dly : std_ulogic;
    signal RXCOMMADETUSE_RXUSRCLK2_dly : std_ulogic;
    signal RXDEC8B10BUSE_RXUSRCLK2_dly : std_ulogic;
    signal RXDLYALIGNDISABLE_dly : std_ulogic;
    signal RXDLYALIGNMONENB_indelay : std_ulogic;
    signal RXDLYALIGNOVERRIDE_dly : std_ulogic;
    signal RXDLYALIGNRESET_dly : std_ulogic;
    signal RXDLYALIGNSWPPRECURB_dly : std_ulogic;
    signal RXDLYALIGNUPDSW_dly : std_ulogic;
    signal RXENCHANSYNC_RXUSRCLK2_dly : std_ulogic;
    signal RXENMCOMMAALIGN_RXUSRCLK2_dly : std_ulogic;
    signal RXENPCOMMAALIGN_RXUSRCLK2_dly : std_ulogic;
    signal RXENPMAPHASEALIGN_dly : std_ulogic;
    signal RXENPRBSTST_RXUSRCLK2_dly : std_logic_vector(2 downto 0);
    signal RXENSAMPLEALIGN_RXUSRCLK2_dly : std_ulogic;
    signal RXEQMIX_dly : std_logic_vector(9 downto 0);
    signal RXGEARBOXSLIP_RXUSRCLK2_dly : std_ulogic;
    signal RXN_dly : std_ulogic;
    signal RXPLLLKDETEN_dly : std_ulogic;
    signal RXPLLPOWERDOWN_dly : std_ulogic;
    signal RXPLLREFSELDY_dly : std_logic_vector(2 downto 0);
    signal RXPMASETPHASE_dly : std_ulogic;
    signal RXPOLARITY_RXUSRCLK2_dly : std_ulogic;
    signal RXPOWERDOWN_dly : std_logic_vector(1 downto 0);
    signal RXP_dly : std_ulogic;
    signal RXRATE_RXUSRCLK2_dly : std_logic_vector(1 downto 0);
    signal RXRESET_dly : std_ulogic;
    signal RXSLIDE_RXUSRCLK2_dly : std_ulogic;
    signal RXUSRCLK2_dly : std_ulogic;
    signal RXUSRCLK_dly_1 : std_ulogic;
    signal SOUTHREFCLKRX_dly : std_logic_vector(1 downto 0);
    signal SOUTHREFCLKTX_dly : std_logic_vector(1 downto 0);
    signal TSTCLK0_dly : std_ulogic;
    signal TSTCLK1_dly : std_ulogic;
    signal TSTIN_dly : std_logic_vector(19 downto 0);
    signal TXBUFDIFFCTRL_dly : std_logic_vector(2 downto 0);
    signal TXBYPASS8B10B_TXUSRCLK2_dly : std_logic_vector(3 downto 0);
    signal TXCHARDISPMODE_TXUSRCLK2_dly : std_logic_vector(3 downto 0);
    signal TXCHARDISPVAL_TXUSRCLK2_dly : std_logic_vector(3 downto 0);
    signal TXCHARISK_TXUSRCLK2_dly : std_logic_vector(3 downto 0);
    signal TXCOMINIT_TXUSRCLK2_dly : std_ulogic;
    signal TXCOMSAS_TXUSRCLK2_dly : std_ulogic;
    signal TXCOMWAKE_TXUSRCLK2_dly : std_ulogic;
    signal TXDATA_TXUSRCLK2_dly : std_logic_vector(31 downto 0);
    signal TXDEEMPH_dly : std_ulogic;
    signal TXDETECTRX_TXUSRCLK2_dly : std_ulogic;
    signal TXDIFFCTRL_dly : std_logic_vector(3 downto 0);
    signal TXDLYALIGNDISABLE_dly : std_ulogic;
    signal TXDLYALIGNMONENB_indelay : std_ulogic;
    signal TXDLYALIGNOVERRIDE_dly : std_ulogic;
    signal TXDLYALIGNRESET_dly : std_ulogic;
    signal TXDLYALIGNUPDSW_dly : std_ulogic;
    signal TXELECIDLE_TXUSRCLK2_dly : std_ulogic;
    signal TXENC8B10BUSE_TXUSRCLK2_dly : std_ulogic;
    signal TXENPMAPHASEALIGN_dly : std_ulogic;
    signal TXENPRBSTST_TXUSRCLK2_dly : std_logic_vector(2 downto 0);
    signal TXHEADER_TXUSRCLK2_dly : std_logic_vector(2 downto 0);
    signal TXINHIBIT_TXUSRCLK2_dly : std_ulogic;
    signal TXMARGIN_dly : std_logic_vector(2 downto 0);
    signal TXPDOWNASYNCH_dly : std_ulogic;
    signal TXPLLLKDETEN_dly : std_ulogic;
    signal TXPLLPOWERDOWN_dly : std_ulogic;
    signal TXPLLREFSELDY_dly : std_logic_vector(2 downto 0);
    signal TXPMASETPHASE_dly : std_ulogic;
    signal TXPOLARITY_TXUSRCLK2_dly : std_ulogic;
    signal TXPOSTEMPHASIS_dly : std_logic_vector(4 downto 0);
    signal TXPOWERDOWN_TXUSRCLK2_dly : std_logic_vector(1 downto 0);
    signal TXPRBSFORCEERR_TXUSRCLK2_dly : std_ulogic;
    signal TXPREEMPHASIS_dly : std_logic_vector(3 downto 0);
    signal TXRATE_TXUSRCLK2_dly : std_logic_vector(1 downto 0);
    signal TXRESET_dly : std_ulogic;
    signal TXSEQUENCE_TXUSRCLK2_dly : std_logic_vector(6 downto 0);
    signal TXSTARTSEQ_TXUSRCLK2_dly : std_ulogic;
    signal TXSWING_dly : std_ulogic;
    signal TXUSRCLK2_dly : std_ulogic;
    signal TXUSRCLK_dly : std_ulogic;
    signal USRCODEERR_RXUSRCLK2_dly : std_ulogic;
    
    signal DADDR_indelay : std_logic_vector(7 downto 0);
    signal DCLK_indelay : std_ulogic;
    signal DEN_indelay : std_ulogic;
    signal DFECLKDLYADJ_indelay : std_logic_vector(5 downto 0);
    signal DFEDLYOVRD_indelay : std_ulogic;
    signal DFETAP1_indelay : std_logic_vector(4 downto 0);
    signal DFETAP2_indelay : std_logic_vector(4 downto 0);
    signal DFETAP3_indelay : std_logic_vector(3 downto 0);
    signal DFETAP4_indelay : std_logic_vector(3 downto 0);
    signal DFETAPOVRD_indelay : std_ulogic;
    signal DI_indelay : std_logic_vector(15 downto 0);
    signal DWE_indelay : std_ulogic;
    signal GATERXELECIDLE_indelay : std_ulogic;
    signal GREFCLKRX_indelay : std_ulogic;
    signal GREFCLKTX_indelay : std_ulogic;
    signal GTXRXRESET_indelay : std_ulogic;
    signal GTXTEST_indelay : std_logic_vector(12 downto 0);
    signal GTXTXRESET_indelay : std_ulogic;
    signal IGNORESIGDET_indelay : std_ulogic;
    signal LOOPBACK_indelay : std_logic_vector(2 downto 0);
    signal MGTREFCLKRX_indelay : std_logic_vector(1 downto 0);
    signal MGTREFCLKTX_indelay : std_logic_vector(1 downto 0);
    signal NORTHREFCLKRX_indelay : std_logic_vector(1 downto 0);
    signal NORTHREFCLKTX_indelay : std_logic_vector(1 downto 0);
    signal PERFCLKRX_indelay : std_ulogic;
    signal PERFCLKTX_indelay : std_ulogic;
    signal PLLRXRESET_indelay : std_ulogic;
    signal PLLTXRESET_indelay : std_ulogic;
    signal PRBSCNTRESET_indelay : std_ulogic;
    signal RXBUFRESET_indelay : std_ulogic;
    signal RXCDRRESET_indelay : std_ulogic;
    signal RXCHBONDI_indelay : std_logic_vector(3 downto 0);
    signal RXCHBONDLEVEL_indelay : std_logic_vector(2 downto 0);
    signal RXCHBONDMASTER_indelay : std_ulogic;
    signal RXCHBONDSLAVE_indelay : std_ulogic;
    signal RXCOMMADETUSE_indelay : std_ulogic;
    signal RXDEC8B10BUSE_indelay : std_ulogic;
    signal RXDLYALIGNDISABLE_indelay : std_ulogic;
    signal RXDLYALIGNMONENB_indly : std_ulogic;
    signal RXDLYALIGNOVERRIDE_indelay : std_ulogic;
    signal RXDLYALIGNRESET_indelay : std_ulogic;
    signal RXDLYALIGNSWPPRECURB_indelay : std_ulogic;
    signal RXDLYALIGNUPDSW_indelay : std_ulogic;
    signal RXENCHANSYNC_indelay : std_ulogic;
    signal RXENMCOMMAALIGN_indelay : std_ulogic;
    signal RXENPCOMMAALIGN_indelay : std_ulogic;
    signal RXENPMAPHASEALIGN_indelay : std_ulogic;
    signal RXENPRBSTST_indelay : std_logic_vector(2 downto 0);
    signal RXENSAMPLEALIGN_indelay : std_ulogic;
    signal RXEQMIX_indelay : std_logic_vector(9 downto 0);
    signal RXGEARBOXSLIP_indelay : std_ulogic;
    signal RXN_indelay : std_ulogic;
    signal RXPLLLKDETEN_indelay : std_ulogic;
    signal RXPLLPOWERDOWN_indelay : std_ulogic;
    signal RXPLLREFSELDY_indelay : std_logic_vector(2 downto 0);
    signal RXPMASETPHASE_indelay : std_ulogic;
    signal RXPOLARITY_indelay : std_ulogic;
    signal RXPOWERDOWN_indelay : std_logic_vector(1 downto 0);
    signal RXP_indelay : std_ulogic;
    signal RXRATE_indelay : std_logic_vector(1 downto 0);
    signal RXRESET_indelay : std_ulogic;
    signal RXSLIDE_indelay : std_ulogic;
    signal RXUSRCLK2_indelay : std_ulogic;
    signal RXUSRCLK_indelay : std_ulogic;
    signal SOUTHREFCLKRX_indelay : std_logic_vector(1 downto 0);
    signal SOUTHREFCLKTX_indelay : std_logic_vector(1 downto 0);
    signal TSTCLK0_indelay : std_ulogic;
    signal TSTCLK1_indelay : std_ulogic;
    signal TSTIN_indelay : std_logic_vector(19 downto 0);
    signal TXBUFDIFFCTRL_indelay : std_logic_vector(2 downto 0);
    signal TXBYPASS8B10B_indelay : std_logic_vector(3 downto 0);
    signal TXCHARDISPMODE_indelay : std_logic_vector(3 downto 0);
    signal TXCHARDISPVAL_indelay : std_logic_vector(3 downto 0);
    signal TXCHARISK_indelay : std_logic_vector(3 downto 0);
    signal TXCOMINIT_indelay : std_ulogic;
    signal TXCOMSAS_indelay : std_ulogic;
    signal TXCOMWAKE_indelay : std_ulogic;
    signal TXDATA_indelay : std_logic_vector(31 downto 0);
    signal TXDEEMPH_indelay : std_ulogic;
    signal TXDETECTRX_indelay : std_ulogic;
    signal TXDIFFCTRL_indelay : std_logic_vector(3 downto 0);
    signal TXDLYALIGNDISABLE_indelay : std_ulogic;
    signal TXDLYALIGNMONENB_indly : std_ulogic;
    signal TXDLYALIGNOVERRIDE_indelay : std_ulogic;
    signal TXDLYALIGNRESET_indelay : std_ulogic;
    signal TXDLYALIGNUPDSW_indelay : std_ulogic;
    signal TXELECIDLE_indelay : std_ulogic;
    signal TXENC8B10BUSE_indelay : std_ulogic;
    signal TXENPMAPHASEALIGN_indelay : std_ulogic;
    signal TXENPRBSTST_indelay : std_logic_vector(2 downto 0);
    signal TXHEADER_indelay : std_logic_vector(2 downto 0);
    signal TXINHIBIT_indelay : std_ulogic;
    signal TXMARGIN_indelay : std_logic_vector(2 downto 0);
    signal TXPDOWNASYNCH_indelay : std_ulogic;
    signal TXPLLLKDETEN_indelay : std_ulogic;
    signal TXPLLPOWERDOWN_indelay : std_ulogic;
    signal TXPLLREFSELDY_indelay : std_logic_vector(2 downto 0);
    signal TXPMASETPHASE_indelay : std_ulogic;
    signal TXPOLARITY_indelay : std_ulogic;
    signal TXPOSTEMPHASIS_indelay : std_logic_vector(4 downto 0);
    signal TXPOWERDOWN_indelay : std_logic_vector(1 downto 0);
    signal TXPRBSFORCEERR_indelay : std_ulogic;
    signal TXPREEMPHASIS_indelay : std_logic_vector(3 downto 0);
    signal TXRATE_indelay : std_logic_vector(1 downto 0);
    signal TXRESET_indelay : std_ulogic;
    signal TXSEQUENCE_indelay : std_logic_vector(6 downto 0);
    signal TXSTARTSEQ_indelay : std_ulogic;
    signal TXSWING_indelay : std_ulogic;
    signal TXUSRCLK2_indelay : std_ulogic;
    signal TXUSRCLK_indelay : std_ulogic;
    signal USRCODEERR_indelay : std_ulogic;

    signal DADDR_indly : std_logic_vector(7 downto 0);
    signal DCLK_indly : std_ulogic;
    signal DEN_indly : std_ulogic;
    signal DFECLKDLYADJ_indly : std_logic_vector(5 downto 0);
    signal DFEDLYOVRD_indly : std_ulogic;
    signal DFETAP1_indly : std_logic_vector(4 downto 0);
    signal DFETAP2_indly : std_logic_vector(4 downto 0);
    signal DFETAP3_indly : std_logic_vector(3 downto 0);
    signal DFETAP4_indly : std_logic_vector(3 downto 0);
    signal DFETAPOVRD_indly : std_ulogic;
    signal DI_indly : std_logic_vector(15 downto 0);
    signal DWE_indly : std_ulogic;
    signal GATERXELECIDLE_indly : std_ulogic;
    signal GREFCLKRX_indly : std_ulogic;
    signal GREFCLKTX_indly : std_ulogic;
    signal GTXRXRESET_indly : std_ulogic;
    signal GTXTEST_indly : std_logic_vector(12 downto 0);
    signal GTXTXRESET_indly : std_ulogic;
    signal IGNORESIGDET_indly : std_ulogic;
    signal LOOPBACK_indly : std_logic_vector(2 downto 0);
    signal MGTREFCLKRX_indly : std_logic_vector(1 downto 0);
    signal MGTREFCLKTX_indly : std_logic_vector(1 downto 0);
    signal NORTHREFCLKRX_indly : std_logic_vector(1 downto 0);
    signal NORTHREFCLKTX_indly : std_logic_vector(1 downto 0);
    signal PERFCLKRX_indly : std_ulogic;
    signal PERFCLKTX_indly : std_ulogic;
    signal PLLRXRESET_indly : std_ulogic;
    signal PLLTXRESET_indly : std_ulogic;
    signal PRBSCNTRESET_indly : std_ulogic;
    signal RXBUFRESET_indly : std_ulogic;
    signal RXCDRRESET_indly : std_ulogic;
    signal RXCHBONDI_indly : std_logic_vector(3 downto 0);
    signal RXCHBONDLEVEL_indly : std_logic_vector(2 downto 0);
    signal RXCHBONDMASTER_indly : std_ulogic;
    signal RXCHBONDSLAVE_indly : std_ulogic;
    signal RXCOMMADETUSE_indly : std_ulogic;
    signal RXDEC8B10BUSE_indly : std_ulogic;
    signal RXDLYALIGNDISABLE_indly : std_ulogic;
    signal RXDLYALIGNOVERRIDE_indly : std_ulogic;
    signal RXDLYALIGNRESET_indly : std_ulogic;
    signal RXDLYALIGNSWPPRECURB_indly : std_ulogic;
    signal RXDLYALIGNUPDSW_indly : std_ulogic;
    signal RXENCHANSYNC_indly : std_ulogic;
    signal RXENMCOMMAALIGN_indly : std_ulogic;
    signal RXENPCOMMAALIGN_indly : std_ulogic;
    signal RXENPMAPHASEALIGN_indly : std_ulogic;
    signal RXENPRBSTST_indly : std_logic_vector(2 downto 0);
    signal RXENSAMPLEALIGN_indly : std_ulogic;
    signal RXEQMIX_indly : std_logic_vector(9 downto 0);
    signal RXGEARBOXSLIP_indly : std_ulogic;
    signal RXN_indly : std_ulogic;
    signal RXPLLLKDETEN_indly : std_ulogic;
    signal RXPLLPOWERDOWN_indly : std_ulogic;
    signal RXPLLREFSELDY_indly : std_logic_vector(2 downto 0);
    signal RXPMASETPHASE_indly : std_ulogic;
    signal RXPOLARITY_indly : std_ulogic;
    signal RXPOWERDOWN_indly : std_logic_vector(1 downto 0);
    signal RXP_indly : std_ulogic;
    signal RXRATE_indly : std_logic_vector(1 downto 0);
    signal RXRESET_indly : std_ulogic;
    signal RXSLIDE_indly : std_ulogic;
    signal RXUSRCLK2_indly : std_ulogic;
    signal RXUSRCLK_indly : std_ulogic;
    signal SOUTHREFCLKRX_indly : std_logic_vector(1 downto 0);
    signal SOUTHREFCLKTX_indly : std_logic_vector(1 downto 0);
    signal TSTCLK0_indly : std_ulogic;
    signal TSTCLK1_indly : std_ulogic;
    signal TSTIN_indly : std_logic_vector(19 downto 0);
    signal TXBUFDIFFCTRL_indly : std_logic_vector(2 downto 0);
    signal TXBYPASS8B10B_indly : std_logic_vector(3 downto 0);
    signal TXCHARDISPMODE_indly : std_logic_vector(3 downto 0);
    signal TXCHARDISPVAL_indly : std_logic_vector(3 downto 0);
    signal TXCHARISK_indly : std_logic_vector(3 downto 0);
    signal TXCOMINIT_indly : std_ulogic;
    signal TXCOMSAS_indly : std_ulogic;
    signal TXCOMWAKE_indly : std_ulogic;
    signal TXDATA_indly : std_logic_vector(31 downto 0);
    signal TXDEEMPH_indly : std_ulogic;
    signal TXDETECTRX_indly : std_ulogic;
    signal TXDIFFCTRL_indly : std_logic_vector(3 downto 0);
    signal TXDLYALIGNDISABLE_indly : std_ulogic;
    signal TXDLYALIGNOVERRIDE_indly : std_ulogic;
    signal TXDLYALIGNRESET_indly : std_ulogic;
    signal TXDLYALIGNUPDSW_indly : std_ulogic;
    signal TXELECIDLE_indly : std_ulogic;
    signal TXENC8B10BUSE_indly : std_ulogic;
    signal TXENPMAPHASEALIGN_indly : std_ulogic;
    signal TXENPRBSTST_indly : std_logic_vector(2 downto 0);
    signal TXHEADER_indly : std_logic_vector(2 downto 0);
    signal TXINHIBIT_indly : std_ulogic;
    signal TXMARGIN_indly : std_logic_vector(2 downto 0);
    signal TXPDOWNASYNCH_indly : std_ulogic;
    signal TXPLLLKDETEN_indly : std_ulogic;
    signal TXPLLPOWERDOWN_indly : std_ulogic;
    signal TXPLLREFSELDY_indly : std_logic_vector(2 downto 0);
    signal TXPMASETPHASE_indly : std_ulogic;
    signal TXPOLARITY_indly : std_ulogic;
    signal TXPOSTEMPHASIS_indly : std_logic_vector(4 downto 0);
    signal TXPOWERDOWN_indly : std_logic_vector(1 downto 0);
    signal TXPRBSFORCEERR_indly : std_ulogic;
    signal TXPREEMPHASIS_indly : std_logic_vector(3 downto 0);
    signal TXRATE_indly : std_logic_vector(1 downto 0);
    signal TXRESET_indly : std_ulogic;
    signal TXSEQUENCE_indly : std_logic_vector(6 downto 0);
    signal TXSTARTSEQ_indly : std_ulogic;
    signal TXSWING_indly : std_ulogic;
    signal TXUSRCLK2_indly : std_ulogic;
    signal TXUSRCLK_indly : std_ulogic;
    signal USRCODEERR_indly : std_ulogic;

-- <!--Aldec correction start
	signal GSR_local : std_ulogic;
-- Aldec correction end -->    

    begin
    
    WireDelay : block
    begin
      DADDR_DELAY : for i in 0 to 7 generate
        VitalWireDelay (DADDR_ipd(i),DADDR(i),tipd_DADDR(i));
      end generate DADDR_DELAY;
      DFECLKDLYADJ_DELAY : for i in 0 to 5 generate
        VitalWireDelay (DFECLKDLYADJ_ipd(i),DFECLKDLYADJ(i),tipd_DFECLKDLYADJ(i));
      end generate DFECLKDLYADJ_DELAY;
      DFETAP1_DELAY : for i in 0 to 4 generate
        VitalWireDelay (DFETAP1_ipd(i),DFETAP1(i),tipd_DFETAP1(i));
      end generate DFETAP1_DELAY;
      DFETAP2_DELAY : for i in 0 to 4 generate
        VitalWireDelay (DFETAP2_ipd(i),DFETAP2(i),tipd_DFETAP2(i));
      end generate DFETAP2_DELAY;
      DFETAP3_DELAY : for i in 0 to 3 generate
        VitalWireDelay (DFETAP3_ipd(i),DFETAP3(i),tipd_DFETAP3(i));
      end generate DFETAP3_DELAY;
      DFETAP4_DELAY : for i in 0 to 3 generate
        VitalWireDelay (DFETAP4_ipd(i),DFETAP4(i),tipd_DFETAP4(i));
      end generate DFETAP4_DELAY;
      DI_DELAY : for i in 0 to 15 generate
        VitalWireDelay (DI_ipd(i),DI(i),tipd_DI(i));
      end generate DI_DELAY;
      GTXTEST_DELAY : for i in 0 to 12 generate
        VitalWireDelay (GTXTEST_ipd(i),GTXTEST(i),tipd_GTXTEST(i));
      end generate GTXTEST_DELAY;
      LOOPBACK_DELAY : for i in 0 to 2 generate
        VitalWireDelay (LOOPBACK_ipd(i),LOOPBACK(i),tipd_LOOPBACK(i));
      end generate LOOPBACK_DELAY;
      MGTREFCLKRX_DELAY : for i in 0 to 1 generate
        VitalWireDelay (MGTREFCLKRX_ipd(i),MGTREFCLKRX(i),tipd_MGTREFCLKRX(i));
      end generate MGTREFCLKRX_DELAY;
      MGTREFCLKTX_DELAY : for i in 0 to 1 generate
        VitalWireDelay (MGTREFCLKTX_ipd(i),MGTREFCLKTX(i),tipd_MGTREFCLKTX(i));
      end generate MGTREFCLKTX_DELAY;
      NORTHREFCLKRX_DELAY : for i in 0 to 1 generate
        VitalWireDelay (NORTHREFCLKRX_ipd(i),NORTHREFCLKRX(i),tipd_NORTHREFCLKRX(i));
      end generate NORTHREFCLKRX_DELAY;
      NORTHREFCLKTX_DELAY : for i in 0 to 1 generate
        VitalWireDelay (NORTHREFCLKTX_ipd(i),NORTHREFCLKTX(i),tipd_NORTHREFCLKTX(i));
      end generate NORTHREFCLKTX_DELAY;
      RXCHBONDI_DELAY : for i in 0 to 3 generate
        VitalWireDelay (RXCHBONDI_ipd(i),RXCHBONDI(i),tipd_RXCHBONDI(i));
      end generate RXCHBONDI_DELAY;
      RXCHBONDLEVEL_DELAY : for i in 0 to 2 generate
        VitalWireDelay (RXCHBONDLEVEL_ipd(i),RXCHBONDLEVEL(i),tipd_RXCHBONDLEVEL(i));
      end generate RXCHBONDLEVEL_DELAY;
      RXENPRBSTST_DELAY : for i in 0 to 2 generate
        VitalWireDelay (RXENPRBSTST_ipd(i),RXENPRBSTST(i),tipd_RXENPRBSTST(i));
      end generate RXENPRBSTST_DELAY;
      RXEQMIX_DELAY : for i in 0 to 9 generate
        VitalWireDelay (RXEQMIX_ipd(i),RXEQMIX(i),tipd_RXEQMIX(i));
      end generate RXEQMIX_DELAY;
      RXPLLREFSELDY_DELAY : for i in 0 to 2 generate
        VitalWireDelay (RXPLLREFSELDY_ipd(i),RXPLLREFSELDY(i),tipd_RXPLLREFSELDY(i));
      end generate RXPLLREFSELDY_DELAY;
      RXPOWERDOWN_DELAY : for i in 0 to 1 generate
        VitalWireDelay (RXPOWERDOWN_ipd(i),RXPOWERDOWN(i),tipd_RXPOWERDOWN(i));
      end generate RXPOWERDOWN_DELAY;
      RXRATE_DELAY : for i in 0 to 1 generate
        VitalWireDelay (RXRATE_ipd(i),RXRATE(i),tipd_RXRATE(i));
      end generate RXRATE_DELAY;
      SOUTHREFCLKRX_DELAY : for i in 0 to 1 generate
        VitalWireDelay (SOUTHREFCLKRX_ipd(i),SOUTHREFCLKRX(i),tipd_SOUTHREFCLKRX(i));
      end generate SOUTHREFCLKRX_DELAY;
      SOUTHREFCLKTX_DELAY : for i in 0 to 1 generate
        VitalWireDelay (SOUTHREFCLKTX_ipd(i),SOUTHREFCLKTX(i),tipd_SOUTHREFCLKTX(i));
      end generate SOUTHREFCLKTX_DELAY;
      TSTIN_DELAY : for i in 0 to 19 generate
        VitalWireDelay (TSTIN_ipd(i),TSTIN(i),tipd_TSTIN(i));
      end generate TSTIN_DELAY;
      TXBUFDIFFCTRL_DELAY : for i in 0 to 2 generate
        VitalWireDelay (TXBUFDIFFCTRL_ipd(i),TXBUFDIFFCTRL(i),tipd_TXBUFDIFFCTRL(i));
      end generate TXBUFDIFFCTRL_DELAY;
      TXBYPASS8B10B_DELAY : for i in 0 to 3 generate
        VitalWireDelay (TXBYPASS8B10B_ipd(i),TXBYPASS8B10B(i),tipd_TXBYPASS8B10B(i));
      end generate TXBYPASS8B10B_DELAY;
      TXCHARDISPMODE_DELAY : for i in 0 to 3 generate
        VitalWireDelay (TXCHARDISPMODE_ipd(i),TXCHARDISPMODE(i),tipd_TXCHARDISPMODE(i));
      end generate TXCHARDISPMODE_DELAY;
      TXCHARDISPVAL_DELAY : for i in 0 to 3 generate
        VitalWireDelay (TXCHARDISPVAL_ipd(i),TXCHARDISPVAL(i),tipd_TXCHARDISPVAL(i));
      end generate TXCHARDISPVAL_DELAY;
      TXCHARISK_DELAY : for i in 0 to 3 generate
        VitalWireDelay (TXCHARISK_ipd(i),TXCHARISK(i),tipd_TXCHARISK(i));
      end generate TXCHARISK_DELAY;
      TXDATA_DELAY : for i in 0 to 31 generate
        VitalWireDelay (TXDATA_ipd(i),TXDATA(i),tipd_TXDATA(i));
      end generate TXDATA_DELAY;
      TXDIFFCTRL_DELAY : for i in 0 to 3 generate
        VitalWireDelay (TXDIFFCTRL_ipd(i),TXDIFFCTRL(i),tipd_TXDIFFCTRL(i));
      end generate TXDIFFCTRL_DELAY;
      TXENPRBSTST_DELAY : for i in 0 to 2 generate
        VitalWireDelay (TXENPRBSTST_ipd(i),TXENPRBSTST(i),tipd_TXENPRBSTST(i));
      end generate TXENPRBSTST_DELAY;
      TXHEADER_DELAY : for i in 0 to 2 generate
        VitalWireDelay (TXHEADER_ipd(i),TXHEADER(i),tipd_TXHEADER(i));
      end generate TXHEADER_DELAY;
      TXMARGIN_DELAY : for i in 0 to 2 generate
        VitalWireDelay (TXMARGIN_ipd(i),TXMARGIN(i),tipd_TXMARGIN(i));
      end generate TXMARGIN_DELAY;
      TXPLLREFSELDY_DELAY : for i in 0 to 2 generate
        VitalWireDelay (TXPLLREFSELDY_ipd(i),TXPLLREFSELDY(i),tipd_TXPLLREFSELDY(i));
      end generate TXPLLREFSELDY_DELAY;
      TXPOSTEMPHASIS_DELAY : for i in 0 to 4 generate
        VitalWireDelay (TXPOSTEMPHASIS_ipd(i),TXPOSTEMPHASIS(i),tipd_TXPOSTEMPHASIS(i));
      end generate TXPOSTEMPHASIS_DELAY;
      TXPOWERDOWN_DELAY : for i in 0 to 1 generate
        VitalWireDelay (TXPOWERDOWN_ipd(i),TXPOWERDOWN(i),tipd_TXPOWERDOWN(i));
      end generate TXPOWERDOWN_DELAY;
      TXPREEMPHASIS_DELAY : for i in 0 to 3 generate
        VitalWireDelay (TXPREEMPHASIS_ipd(i),TXPREEMPHASIS(i),tipd_TXPREEMPHASIS(i));
      end generate TXPREEMPHASIS_DELAY;
      TXRATE_DELAY : for i in 0 to 1 generate
        VitalWireDelay (TXRATE_ipd(i),TXRATE(i),tipd_TXRATE(i));
      end generate TXRATE_DELAY;
      TXSEQUENCE_DELAY : for i in 0 to 6 generate
        VitalWireDelay (TXSEQUENCE_ipd(i),TXSEQUENCE(i),tipd_TXSEQUENCE(i));
      end generate TXSEQUENCE_DELAY;
      VitalWireDelay (DCLK_ipd,DCLK,tipd_DCLK);
      VitalWireDelay (DEN_ipd,DEN,tipd_DEN);
      VitalWireDelay (DFEDLYOVRD_ipd,DFEDLYOVRD,tipd_DFEDLYOVRD);
      VitalWireDelay (DFETAPOVRD_ipd,DFETAPOVRD,tipd_DFETAPOVRD);
      VitalWireDelay (DWE_ipd,DWE,tipd_DWE);
      VitalWireDelay (GATERXELECIDLE_ipd,GATERXELECIDLE,tipd_GATERXELECIDLE);
      VitalWireDelay (GREFCLKRX_ipd,GREFCLKRX,tipd_GREFCLKRX);
      VitalWireDelay (GREFCLKTX_ipd,GREFCLKTX,tipd_GREFCLKTX);
      VitalWireDelay (GTXRXRESET_ipd,GTXRXRESET,tipd_GTXRXRESET);
      VitalWireDelay (GTXTXRESET_ipd,GTXTXRESET,tipd_GTXTXRESET);
      VitalWireDelay (IGNORESIGDET_ipd,IGNORESIGDET,tipd_IGNORESIGDET);
      VitalWireDelay (PERFCLKRX_ipd,PERFCLKRX,tipd_PERFCLKRX);
      VitalWireDelay (PERFCLKTX_ipd,PERFCLKTX,tipd_PERFCLKTX);
      VitalWireDelay (PLLRXRESET_ipd,PLLRXRESET,tipd_PLLRXRESET);
      VitalWireDelay (PLLTXRESET_ipd,PLLTXRESET,tipd_PLLTXRESET);
      VitalWireDelay (PRBSCNTRESET_ipd,PRBSCNTRESET,tipd_PRBSCNTRESET);
      VitalWireDelay (RXBUFRESET_ipd,RXBUFRESET,tipd_RXBUFRESET);
      VitalWireDelay (RXCDRRESET_ipd,RXCDRRESET,tipd_RXCDRRESET);
      VitalWireDelay (RXCHBONDMASTER_ipd,RXCHBONDMASTER,tipd_RXCHBONDMASTER);
      VitalWireDelay (RXCHBONDSLAVE_ipd,RXCHBONDSLAVE,tipd_RXCHBONDSLAVE);
      VitalWireDelay (RXCOMMADETUSE_ipd,RXCOMMADETUSE,tipd_RXCOMMADETUSE);
      VitalWireDelay (RXDEC8B10BUSE_ipd,RXDEC8B10BUSE,tipd_RXDEC8B10BUSE);
      VitalWireDelay (RXDLYALIGNDISABLE_ipd,RXDLYALIGNDISABLE,tipd_RXDLYALIGNDISABLE);
      VitalWireDelay (RXDLYALIGNMONENB_ipd,RXDLYALIGNMONENB,tipd_RXDLYALIGNMONENB);
      VitalWireDelay (RXDLYALIGNOVERRIDE_ipd,RXDLYALIGNOVERRIDE,tipd_RXDLYALIGNOVERRIDE);
      VitalWireDelay (RXDLYALIGNRESET_ipd,RXDLYALIGNRESET,tipd_RXDLYALIGNRESET);
      VitalWireDelay (RXDLYALIGNSWPPRECURB_ipd,RXDLYALIGNSWPPRECURB,tipd_RXDLYALIGNSWPPRECURB);
      VitalWireDelay (RXDLYALIGNUPDSW_ipd,RXDLYALIGNUPDSW,tipd_RXDLYALIGNUPDSW);
      VitalWireDelay (RXENCHANSYNC_ipd,RXENCHANSYNC,tipd_RXENCHANSYNC);
      VitalWireDelay (RXENMCOMMAALIGN_ipd,RXENMCOMMAALIGN,tipd_RXENMCOMMAALIGN);
      VitalWireDelay (RXENPCOMMAALIGN_ipd,RXENPCOMMAALIGN,tipd_RXENPCOMMAALIGN);
      VitalWireDelay (RXENPMAPHASEALIGN_ipd,RXENPMAPHASEALIGN,tipd_RXENPMAPHASEALIGN);
      VitalWireDelay (RXENSAMPLEALIGN_ipd,RXENSAMPLEALIGN,tipd_RXENSAMPLEALIGN);
      VitalWireDelay (RXGEARBOXSLIP_ipd,RXGEARBOXSLIP,tipd_RXGEARBOXSLIP);
      VitalWireDelay (RXN_ipd,RXN,tipd_RXN);
      VitalWireDelay (RXPLLLKDETEN_ipd,RXPLLLKDETEN,tipd_RXPLLLKDETEN);
      VitalWireDelay (RXPLLPOWERDOWN_ipd,RXPLLPOWERDOWN,tipd_RXPLLPOWERDOWN);
      VitalWireDelay (RXPMASETPHASE_ipd,RXPMASETPHASE,tipd_RXPMASETPHASE);
      VitalWireDelay (RXPOLARITY_ipd,RXPOLARITY,tipd_RXPOLARITY);
      VitalWireDelay (RXP_ipd,RXP,tipd_RXP);
      VitalWireDelay (RXRESET_ipd,RXRESET,tipd_RXRESET);
      VitalWireDelay (RXSLIDE_ipd,RXSLIDE,tipd_RXSLIDE);
      VitalWireDelay (RXUSRCLK2_ipd,RXUSRCLK2,tipd_RXUSRCLK2);
      VitalWireDelay (RXUSRCLK_ipd,RXUSRCLK,tipd_RXUSRCLK);
      VitalWireDelay (TSTCLK0_ipd,TSTCLK0,tipd_TSTCLK0);
      VitalWireDelay (TSTCLK1_ipd,TSTCLK1,tipd_TSTCLK1);
      VitalWireDelay (TXCOMINIT_ipd,TXCOMINIT,tipd_TXCOMINIT);
      VitalWireDelay (TXCOMSAS_ipd,TXCOMSAS,tipd_TXCOMSAS);
      VitalWireDelay (TXCOMWAKE_ipd,TXCOMWAKE,tipd_TXCOMWAKE);
      VitalWireDelay (TXDEEMPH_ipd,TXDEEMPH,tipd_TXDEEMPH);
      VitalWireDelay (TXDETECTRX_ipd,TXDETECTRX,tipd_TXDETECTRX);
      VitalWireDelay (TXDLYALIGNDISABLE_ipd,TXDLYALIGNDISABLE,tipd_TXDLYALIGNDISABLE);
      VitalWireDelay (TXDLYALIGNMONENB_ipd,TXDLYALIGNMONENB,tipd_TXDLYALIGNMONENB);
      VitalWireDelay (TXDLYALIGNOVERRIDE_ipd,TXDLYALIGNOVERRIDE,tipd_TXDLYALIGNOVERRIDE);
      VitalWireDelay (TXDLYALIGNRESET_ipd,TXDLYALIGNRESET,tipd_TXDLYALIGNRESET);
      VitalWireDelay (TXDLYALIGNUPDSW_ipd,TXDLYALIGNUPDSW,tipd_TXDLYALIGNUPDSW);
      VitalWireDelay (TXELECIDLE_ipd,TXELECIDLE,tipd_TXELECIDLE);
      VitalWireDelay (TXENC8B10BUSE_ipd,TXENC8B10BUSE,tipd_TXENC8B10BUSE);
      VitalWireDelay (TXENPMAPHASEALIGN_ipd,TXENPMAPHASEALIGN,tipd_TXENPMAPHASEALIGN);
      VitalWireDelay (TXINHIBIT_ipd,TXINHIBIT,tipd_TXINHIBIT);
      VitalWireDelay (TXPDOWNASYNCH_ipd,TXPDOWNASYNCH,tipd_TXPDOWNASYNCH);
      VitalWireDelay (TXPLLLKDETEN_ipd,TXPLLLKDETEN,tipd_TXPLLLKDETEN);
      VitalWireDelay (TXPLLPOWERDOWN_ipd,TXPLLPOWERDOWN,tipd_TXPLLPOWERDOWN);
      VitalWireDelay (TXPMASETPHASE_ipd,TXPMASETPHASE,tipd_TXPMASETPHASE);
      VitalWireDelay (TXPOLARITY_ipd,TXPOLARITY,tipd_TXPOLARITY);
      VitalWireDelay (TXPRBSFORCEERR_ipd,TXPRBSFORCEERR,tipd_TXPRBSFORCEERR);
      VitalWireDelay (TXRESET_ipd,TXRESET,tipd_TXRESET);
      VitalWireDelay (TXSTARTSEQ_ipd,TXSTARTSEQ,tipd_TXSTARTSEQ);
      VitalWireDelay (TXSWING_ipd,TXSWING,tipd_TXSWING);
      VitalWireDelay (TXUSRCLK2_ipd,TXUSRCLK2,tipd_TXUSRCLK2);
      VitalWireDelay (TXUSRCLK_ipd,TXUSRCLK,tipd_TXUSRCLK);
      VitalWireDelay (USRCODEERR_ipd,USRCODEERR,tipd_USRCODEERR);
    end block;
    
    SignalDelay : block
    begin
      DADDR_DCLK_DELAY : for i in 7 downto 0 generate
        VitalSignalDelay (DADDR_DCLK_dly(i),DADDR_ipd(i),tisd_DADDR_DCLK(i));
      end generate DADDR_DCLK_DELAY;
      DFECLKDLYADJ_RXUSRCLK2_DELAY : for i in 5 downto 0 generate
        VitalSignalDelay (DFECLKDLYADJ_RXUSRCLK2_dly(i),DFECLKDLYADJ_ipd(i),tisd_DFECLKDLYADJ_RXUSRCLK2(i));
      end generate DFECLKDLYADJ_RXUSRCLK2_DELAY;
      DFETAP1_RXUSRCLK2_DELAY : for i in 4 downto 0 generate
        VitalSignalDelay (DFETAP1_RXUSRCLK2_dly(i),DFETAP1_ipd(i),tisd_DFETAP1_RXUSRCLK2(i));
      end generate DFETAP1_RXUSRCLK2_DELAY;
      DFETAP2_RXUSRCLK2_DELAY : for i in 4 downto 0 generate
        VitalSignalDelay (DFETAP2_RXUSRCLK2_dly(i),DFETAP2_ipd(i),tisd_DFETAP2_RXUSRCLK2(i));
      end generate DFETAP2_RXUSRCLK2_DELAY;
      DFETAP3_RXUSRCLK2_DELAY : for i in 3 downto 0 generate
        VitalSignalDelay (DFETAP3_RXUSRCLK2_dly(i),DFETAP3_ipd(i),tisd_DFETAP3_RXUSRCLK2(i));
      end generate DFETAP3_RXUSRCLK2_DELAY;
      DFETAP4_RXUSRCLK2_DELAY : for i in 3 downto 0 generate
        VitalSignalDelay (DFETAP4_RXUSRCLK2_dly(i),DFETAP4_ipd(i),tisd_DFETAP4_RXUSRCLK2(i));
      end generate DFETAP4_RXUSRCLK2_DELAY;
      DI_DCLK_DELAY : for i in 15 downto 0 generate
        VitalSignalDelay (DI_DCLK_dly(i),DI_ipd(i),tisd_DI_DCLK(i));
      end generate DI_DCLK_DELAY;
      MGTREFCLKRX_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (MGTREFCLKRX_dly(i),MGTREFCLKRX_ipd(i),ticd_MGTREFCLKRX(i));
      end generate MGTREFCLKRX_DELAY;
      MGTREFCLKTX_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (MGTREFCLKTX_dly(i),MGTREFCLKTX_ipd(i),ticd_MGTREFCLKTX(i));
      end generate MGTREFCLKTX_DELAY;
      NORTHREFCLKRX_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (NORTHREFCLKRX_dly(i),NORTHREFCLKRX_ipd(i),ticd_NORTHREFCLKRX(i));
      end generate NORTHREFCLKRX_DELAY;
      NORTHREFCLKTX_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (NORTHREFCLKTX_dly(i),NORTHREFCLKTX_ipd(i),ticd_NORTHREFCLKTX(i));
      end generate NORTHREFCLKTX_DELAY;
      RXCHBONDI_RXUSRCLK2_DELAY : for i in 3 downto 0 generate
        VitalSignalDelay (RXCHBONDI_RXUSRCLK2_dly(i),RXCHBONDI_ipd(i),tisd_RXCHBONDI_RXUSRCLK2(i));
      end generate RXCHBONDI_RXUSRCLK2_DELAY;
      RXCHBONDI_RXUSRCLK_DELAY : for i in 3 downto 0 generate
        VitalSignalDelay (RXCHBONDI_RXUSRCLK_dly(i),RXCHBONDI_ipd(i),tisd_RXCHBONDI_RXUSRCLK(i));
      end generate RXCHBONDI_RXUSRCLK_DELAY;
      RXCHBONDLEVEL_RXUSRCLK2_DELAY : for i in 2 downto 0 generate
        VitalSignalDelay (RXCHBONDLEVEL_RXUSRCLK2_dly(i),RXCHBONDLEVEL_ipd(i),tisd_RXCHBONDLEVEL_RXUSRCLK2(i));
      end generate RXCHBONDLEVEL_RXUSRCLK2_DELAY;
      RXENPRBSTST_RXUSRCLK2_DELAY : for i in 2 downto 0 generate
        VitalSignalDelay (RXENPRBSTST_RXUSRCLK2_dly(i),RXENPRBSTST_ipd(i),tisd_RXENPRBSTST_RXUSRCLK2(i));
      end generate RXENPRBSTST_RXUSRCLK2_DELAY;
      RXRATE_RXUSRCLK2_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (RXRATE_RXUSRCLK2_dly(i),RXRATE_ipd(i),tisd_RXRATE_RXUSRCLK2(i));
      end generate RXRATE_RXUSRCLK2_DELAY;
      SOUTHREFCLKRX_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (SOUTHREFCLKRX_dly(i),SOUTHREFCLKRX_ipd(i),ticd_SOUTHREFCLKRX(i));
      end generate SOUTHREFCLKRX_DELAY;
      SOUTHREFCLKTX_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (SOUTHREFCLKTX_dly(i),SOUTHREFCLKTX_ipd(i),ticd_SOUTHREFCLKTX(i));
      end generate SOUTHREFCLKTX_DELAY;
      TXBYPASS8B10B_TXUSRCLK2_DELAY : for i in 3 downto 0 generate
        VitalSignalDelay (TXBYPASS8B10B_TXUSRCLK2_dly(i),TXBYPASS8B10B_ipd(i),tisd_TXBYPASS8B10B_TXUSRCLK2(i));
      end generate TXBYPASS8B10B_TXUSRCLK2_DELAY;
      TXCHARDISPMODE_TXUSRCLK2_DELAY : for i in 3 downto 0 generate
        VitalSignalDelay (TXCHARDISPMODE_TXUSRCLK2_dly(i),TXCHARDISPMODE_ipd(i),tisd_TXCHARDISPMODE_TXUSRCLK2(i));
      end generate TXCHARDISPMODE_TXUSRCLK2_DELAY;
      TXCHARDISPVAL_TXUSRCLK2_DELAY : for i in 3 downto 0 generate
        VitalSignalDelay (TXCHARDISPVAL_TXUSRCLK2_dly(i),TXCHARDISPVAL_ipd(i),tisd_TXCHARDISPVAL_TXUSRCLK2(i));
      end generate TXCHARDISPVAL_TXUSRCLK2_DELAY;
      TXCHARISK_TXUSRCLK2_DELAY : for i in 3 downto 0 generate
        VitalSignalDelay (TXCHARISK_TXUSRCLK2_dly(i),TXCHARISK_ipd(i),tisd_TXCHARISK_TXUSRCLK2(i));
      end generate TXCHARISK_TXUSRCLK2_DELAY;
      TXDATA_TXUSRCLK2_DELAY : for i in 31 downto 0 generate
        VitalSignalDelay (TXDATA_TXUSRCLK2_dly(i),TXDATA_ipd(i),tisd_TXDATA_TXUSRCLK2(i));
      end generate TXDATA_TXUSRCLK2_DELAY;
      TXENPRBSTST_TXUSRCLK2_DELAY : for i in 2 downto 0 generate
        VitalSignalDelay (TXENPRBSTST_TXUSRCLK2_dly(i),TXENPRBSTST_ipd(i),tisd_TXENPRBSTST_TXUSRCLK2(i));
      end generate TXENPRBSTST_TXUSRCLK2_DELAY;
      TXHEADER_TXUSRCLK2_DELAY : for i in 2 downto 0 generate
        VitalSignalDelay (TXHEADER_TXUSRCLK2_dly(i),TXHEADER_ipd(i),tisd_TXHEADER_TXUSRCLK2(i));
      end generate TXHEADER_TXUSRCLK2_DELAY;
      TXPOWERDOWN_TXUSRCLK2_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (TXPOWERDOWN_TXUSRCLK2_dly(i),TXPOWERDOWN_ipd(i),tisd_TXPOWERDOWN_TXUSRCLK2(i));
      end generate TXPOWERDOWN_TXUSRCLK2_DELAY;
      TXRATE_TXUSRCLK2_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (TXRATE_TXUSRCLK2_dly(i),TXRATE_ipd(i),tisd_TXRATE_TXUSRCLK2(i));
      end generate TXRATE_TXUSRCLK2_DELAY;
      TXSEQUENCE_TXUSRCLK2_DELAY : for i in 6 downto 0 generate
        VitalSignalDelay (TXSEQUENCE_TXUSRCLK2_dly(i),TXSEQUENCE_ipd(i),tisd_TXSEQUENCE_TXUSRCLK2(i));
      end generate TXSEQUENCE_TXUSRCLK2_DELAY;
      VitalSignalDelay (DEN_DCLK_dly,DEN_ipd,tisd_DEN_DCLK);
      VitalSignalDelay (DFEDLYOVRD_RXUSRCLK2_dly,DFEDLYOVRD_ipd,tisd_DFEDLYOVRD_RXUSRCLK2);
      VitalSignalDelay (DFETAPOVRD_RXUSRCLK2_dly,DFETAPOVRD_ipd,tisd_DFETAPOVRD_RXUSRCLK2);
      VitalSignalDelay (DWE_DCLK_dly,DWE_ipd,tisd_DWE_DCLK);
      VitalSignalDelay (PRBSCNTRESET_RXUSRCLK2_dly,PRBSCNTRESET_ipd,tisd_PRBSCNTRESET_RXUSRCLK2);
      VitalSignalDelay (RXCHBONDMASTER_RXUSRCLK2_dly,RXCHBONDMASTER_ipd,tisd_RXCHBONDMASTER_RXUSRCLK2);
      VitalSignalDelay (RXCHBONDSLAVE_RXUSRCLK2_dly,RXCHBONDSLAVE_ipd,tisd_RXCHBONDSLAVE_RXUSRCLK2);
      VitalSignalDelay (RXCOMMADETUSE_RXUSRCLK2_dly,RXCOMMADETUSE_ipd,tisd_RXCOMMADETUSE_RXUSRCLK2);
      VitalSignalDelay (RXDEC8B10BUSE_RXUSRCLK2_dly,RXDEC8B10BUSE_ipd,tisd_RXDEC8B10BUSE_RXUSRCLK2);
      VitalSignalDelay (RXENCHANSYNC_RXUSRCLK2_dly,RXENCHANSYNC_ipd,tisd_RXENCHANSYNC_RXUSRCLK2);
      VitalSignalDelay (RXENMCOMMAALIGN_RXUSRCLK2_dly,RXENMCOMMAALIGN_ipd,tisd_RXENMCOMMAALIGN_RXUSRCLK2);
      VitalSignalDelay (RXENPCOMMAALIGN_RXUSRCLK2_dly,RXENPCOMMAALIGN_ipd,tisd_RXENPCOMMAALIGN_RXUSRCLK2);
      VitalSignalDelay (RXENSAMPLEALIGN_RXUSRCLK2_dly,RXENSAMPLEALIGN_ipd,tisd_RXENSAMPLEALIGN_RXUSRCLK2);
      VitalSignalDelay (RXGEARBOXSLIP_RXUSRCLK2_dly,RXGEARBOXSLIP_ipd,tisd_RXGEARBOXSLIP_RXUSRCLK2);
      VitalSignalDelay (RXPOLARITY_RXUSRCLK2_dly,RXPOLARITY_ipd,tisd_RXPOLARITY_RXUSRCLK2);
      VitalSignalDelay (RXSLIDE_RXUSRCLK2_dly,RXSLIDE_ipd,tisd_RXSLIDE_RXUSRCLK2);
      VitalSignalDelay (TXCOMINIT_TXUSRCLK2_dly,TXCOMINIT_ipd,tisd_TXCOMINIT_TXUSRCLK2);
      VitalSignalDelay (TXCOMSAS_TXUSRCLK2_dly,TXCOMSAS_ipd,tisd_TXCOMSAS_TXUSRCLK2);
      VitalSignalDelay (TXCOMWAKE_TXUSRCLK2_dly,TXCOMWAKE_ipd,tisd_TXCOMWAKE_TXUSRCLK2);
      VitalSignalDelay (TXDETECTRX_TXUSRCLK2_dly,TXDETECTRX_ipd,tisd_TXDETECTRX_TXUSRCLK2);
      VitalSignalDelay (TXELECIDLE_TXUSRCLK2_dly,TXELECIDLE_ipd,tisd_TXELECIDLE_TXUSRCLK2);
      VitalSignalDelay (TXENC8B10BUSE_TXUSRCLK2_dly,TXENC8B10BUSE_ipd,tisd_TXENC8B10BUSE_TXUSRCLK2);
      VitalSignalDelay (TXINHIBIT_TXUSRCLK2_dly,TXINHIBIT_ipd,tisd_TXINHIBIT_TXUSRCLK2);
      VitalSignalDelay (TXPOLARITY_TXUSRCLK2_dly,TXPOLARITY_ipd,tisd_TXPOLARITY_TXUSRCLK2);
      VitalSignalDelay (TXPRBSFORCEERR_TXUSRCLK2_dly,TXPRBSFORCEERR_ipd,tisd_TXPRBSFORCEERR_TXUSRCLK2);
      VitalSignalDelay (TXSTARTSEQ_TXUSRCLK2_dly,TXSTARTSEQ_ipd,tisd_TXSTARTSEQ_TXUSRCLK2);
      VitalSignalDelay (USRCODEERR_RXUSRCLK2_dly,USRCODEERR_ipd,tisd_USRCODEERR_RXUSRCLK2);

      VitalSignalDelay (DCLK_dly,DCLK_ipd,ticd_DCLK);
      VitalSignalDelay (RXUSRCLK2_dly,RXUSRCLK2_ipd,ticd_RXUSRCLK2);
      VitalSignalDelay (RXUSRCLK_dly_1,RXUSRCLK_ipd,ticd_RXUSRCLK);
      VitalSignalDelay (TXUSRCLK2_dly,TXUSRCLK2_ipd,ticd_TXUSRCLK2);
      VitalSignalDelay (TXUSRCLK_dly,TXUSRCLK_ipd,ticd_TXUSRCLK);
      
    end block;
    SELECTPROC: process (
      RXCHBONDI_RXUSRCLK2_dly,
      RXCHBONDI_RXUSRCLK_dly)
    begin
      RXCHBONDI_FOR: for i in 3 downto 0 loop
        RXCHBONDI_IF : if(abs(tisd_RXCHBONDI_RXUSRCLK2(i))> abs(tisd_RXCHBONDI_RXUSRCLK(i))) then
          RXCHBONDI_indelay(i) <= RXCHBONDI_RXUSRCLK2_dly(i);
        else
          RXCHBONDI_indelay(i) <= RXCHBONDI_RXUSRCLK_dly(i);
        end if;
      end loop;
      end process SELECTPROC;

      --Input ports sensitive to single clock
      DADDR_indelay <= DADDR_DCLK_dly;
      DEN_indelay <= DEN_DCLK_dly;
      DFECLKDLYADJ_indelay <= DFECLKDLYADJ_RXUSRCLK2_dly;
      DFEDLYOVRD_indelay <= DFEDLYOVRD_RXUSRCLK2_dly;
      DFETAP1_indelay <= DFETAP1_RXUSRCLK2_dly;
      DFETAP2_indelay <= DFETAP2_RXUSRCLK2_dly;
      DFETAP3_indelay <= DFETAP3_RXUSRCLK2_dly;
      DFETAP4_indelay <= DFETAP4_RXUSRCLK2_dly;
      DFETAPOVRD_indelay <= DFETAPOVRD_RXUSRCLK2_dly;
      DI_indelay <= DI_DCLK_dly;
      DWE_indelay <= DWE_DCLK_dly;
      PRBSCNTRESET_indelay <= PRBSCNTRESET_RXUSRCLK2_dly;
      RXCHBONDLEVEL_indelay <= RXCHBONDLEVEL_RXUSRCLK2_dly;
      RXCHBONDMASTER_indelay <= RXCHBONDMASTER_RXUSRCLK2_dly;
      RXCHBONDSLAVE_indelay <= RXCHBONDSLAVE_RXUSRCLK2_dly;
      RXCOMMADETUSE_indelay <= RXCOMMADETUSE_RXUSRCLK2_dly;
      RXDEC8B10BUSE_indelay <= RXDEC8B10BUSE_RXUSRCLK2_dly;
      RXENCHANSYNC_indelay <= RXENCHANSYNC_RXUSRCLK2_dly;
      RXENMCOMMAALIGN_indelay <= RXENMCOMMAALIGN_RXUSRCLK2_dly;
      RXENPCOMMAALIGN_indelay <= RXENPCOMMAALIGN_RXUSRCLK2_dly;
      RXENPRBSTST_indelay <= RXENPRBSTST_RXUSRCLK2_dly;
      RXENSAMPLEALIGN_indelay <= RXENSAMPLEALIGN_RXUSRCLK2_dly;
      RXGEARBOXSLIP_indelay <= RXGEARBOXSLIP_RXUSRCLK2_dly;
      RXPOLARITY_indelay <= RXPOLARITY_RXUSRCLK2_dly;
      RXRATE_indelay <= RXRATE_RXUSRCLK2_dly;
      RXSLIDE_indelay <= RXSLIDE_RXUSRCLK2_dly;
      TXBYPASS8B10B_indelay <= TXBYPASS8B10B_TXUSRCLK2_dly;
      TXCHARDISPMODE_indelay <= TXCHARDISPMODE_TXUSRCLK2_dly;
      TXCHARDISPVAL_indelay <= TXCHARDISPVAL_TXUSRCLK2_dly;
      TXCHARISK_indelay <= TXCHARISK_TXUSRCLK2_dly;
      TXCOMINIT_indelay <= TXCOMINIT_TXUSRCLK2_dly;
      TXCOMSAS_indelay <= TXCOMSAS_TXUSRCLK2_dly;
      TXCOMWAKE_indelay <= TXCOMWAKE_TXUSRCLK2_dly;
      TXDATA_indelay <= TXDATA_TXUSRCLK2_dly;
      TXDETECTRX_indelay <= TXDETECTRX_TXUSRCLK2_dly;
      TXELECIDLE_indelay <= TXELECIDLE_TXUSRCLK2_dly;
      TXENC8B10BUSE_indelay <= TXENC8B10BUSE_TXUSRCLK2_dly;
      TXENPRBSTST_indelay <= TXENPRBSTST_TXUSRCLK2_dly;
      TXHEADER_indelay <= TXHEADER_TXUSRCLK2_dly;
      TXINHIBIT_indelay <= TXINHIBIT_TXUSRCLK2_dly;
      TXPOLARITY_indelay <= TXPOLARITY_TXUSRCLK2_dly;
      TXPOWERDOWN_indelay <= TXPOWERDOWN_TXUSRCLK2_dly;
      TXPRBSFORCEERR_indelay <= TXPRBSFORCEERR_TXUSRCLK2_dly;
      TXRATE_indelay <= TXRATE_TXUSRCLK2_dly;
      TXSEQUENCE_indelay <= TXSEQUENCE_TXUSRCLK2_dly;
      TXSTARTSEQ_indelay <= TXSTARTSEQ_TXUSRCLK2_dly;
      USRCODEERR_indelay <= USRCODEERR_RXUSRCLK2_dly;
      
      --Input ports sensitive to more than two clocks
      GATERXELECIDLE_indelay <= GATERXELECIDLE_ipd;
      GREFCLKRX_indelay <= GREFCLKRX_ipd;
      GREFCLKTX_indelay <= GREFCLKTX_ipd;
      GTXRXRESET_indelay <= GTXRXRESET_ipd;
      GTXTEST_indelay <= GTXTEST_ipd;
      GTXTXRESET_indelay <= GTXTXRESET_ipd;
      IGNORESIGDET_indelay <= IGNORESIGDET_ipd;
      LOOPBACK_indelay <= LOOPBACK_ipd;
      PERFCLKRX_indelay <= PERFCLKRX_ipd;
      PERFCLKTX_indelay <= PERFCLKTX_ipd;
      PLLRXRESET_indelay <= PLLRXRESET_ipd;
      PLLTXRESET_indelay <= PLLTXRESET_ipd;
      RXBUFRESET_indelay <= RXBUFRESET_ipd;
      RXCDRRESET_indelay <= RXCDRRESET_ipd;
      RXDLYALIGNDISABLE_indelay <= RXDLYALIGNDISABLE_ipd;
      RXDLYALIGNMONENB_indelay <= RXDLYALIGNMONENB_ipd;
      RXDLYALIGNOVERRIDE_indelay <= RXDLYALIGNOVERRIDE_ipd;
      RXDLYALIGNRESET_indelay <= RXDLYALIGNRESET_ipd;
      RXDLYALIGNSWPPRECURB_indelay <= RXDLYALIGNSWPPRECURB_ipd;
      RXDLYALIGNUPDSW_indelay <= RXDLYALIGNUPDSW_ipd;
      RXENPMAPHASEALIGN_indelay <= RXENPMAPHASEALIGN_ipd;
      RXEQMIX_indelay <= RXEQMIX_ipd;
      RXN_indelay <= RXN_ipd;
      RXPLLLKDETEN_indelay <= RXPLLLKDETEN_ipd;
      RXPLLPOWERDOWN_indelay <= RXPLLPOWERDOWN_ipd;
      RXPLLREFSELDY_indelay <= RXPLLREFSELDY_ipd;
      RXPMASETPHASE_indelay <= RXPMASETPHASE_ipd;
      RXPOWERDOWN_indelay <= RXPOWERDOWN_ipd;
      RXP_indelay <= RXP_ipd;
      RXRESET_indelay <= RXRESET_ipd;
      TSTCLK0_indelay <= TSTCLK0_ipd;
      TSTCLK1_indelay <= TSTCLK1_ipd;
      TSTIN_indelay <= TSTIN_ipd;
      TXBUFDIFFCTRL_indelay <= TXBUFDIFFCTRL_ipd;
      TXDEEMPH_indelay <= TXDEEMPH_ipd;
      TXDIFFCTRL_indelay <= TXDIFFCTRL_ipd;
      TXDLYALIGNDISABLE_indelay <= TXDLYALIGNDISABLE_ipd;
      TXDLYALIGNMONENB_indelay <= TXDLYALIGNMONENB_ipd;
      TXDLYALIGNOVERRIDE_indelay <= TXDLYALIGNOVERRIDE_ipd;
      TXDLYALIGNRESET_indelay <= TXDLYALIGNRESET_ipd;
      TXDLYALIGNUPDSW_indelay <= TXDLYALIGNUPDSW_ipd;
      TXENPMAPHASEALIGN_indelay <= TXENPMAPHASEALIGN_ipd;
      TXMARGIN_indelay <= TXMARGIN_ipd;
      TXPDOWNASYNCH_indelay <= TXPDOWNASYNCH_ipd;
      TXPLLLKDETEN_indelay <= TXPLLLKDETEN_ipd;
      TXPLLPOWERDOWN_indelay <= TXPLLPOWERDOWN_ipd;
      TXPLLREFSELDY_indelay <= TXPLLREFSELDY_ipd;
      TXPMASETPHASE_indelay <= TXPMASETPHASE_ipd;
      TXPOSTEMPHASIS_indelay <= TXPOSTEMPHASIS_ipd;
      TXPREEMPHASIS_indelay <= TXPREEMPHASIS_ipd;
      TXRESET_indelay <= TXRESET_ipd;
      TXSWING_indelay <= TXSWING_ipd;
      
      DCLK_indelay <= DCLK_dly;
      MGTREFCLKRX_indelay <= MGTREFCLKRX_dly;
      MGTREFCLKTX_indelay <= MGTREFCLKTX_dly;
      NORTHREFCLKRX_indelay <= NORTHREFCLKRX_dly;
      NORTHREFCLKTX_indelay <= NORTHREFCLKTX_dly;
      RXUSRCLK2_indelay <= RXUSRCLK2_dly;
      RXUSRCLK_indelay <= RXUSRCLK_dly_1;
      SOUTHREFCLKRX_indelay <= SOUTHREFCLKRX_dly;
      SOUTHREFCLKTX_indelay <= SOUTHREFCLKTX_dly;
      TXUSRCLK2_indelay <= TXUSRCLK2_dly;
      TXUSRCLK_indelay <= TXUSRCLK_dly;

      MGTREFCLKFAB_out <= MGTREFCLKFAB_outdelay after OUTCLK_DELAY;
      RXRECCLKPCS_out <= RXRECCLKPCS_outdelay after OUTCLK_DELAY;
      RXRECCLK_out <= RXRECCLK_outdelay after OUTCLK_DELAY;
      TXOUTCLKPCS_out <= TXOUTCLKPCS_outdelay after OUTCLK_DELAY;
      TXOUTCLK_out <= TXOUTCLK_outdelay after OUTCLK_DELAY;
      
      COMFINISH_out <= COMFINISH_outdelay after OUT_DELAY;
      COMINITDET_out <= COMINITDET_outdelay after OUT_DELAY;
      COMSASDET_out <= COMSASDET_outdelay after OUT_DELAY;
      COMWAKEDET_out <= COMWAKEDET_outdelay after OUT_DELAY;
      DFECLKDLYADJMON_out <= DFECLKDLYADJMON_outdelay after OUT_DELAY;
      DFEEYEDACMON_out <= DFEEYEDACMON_outdelay after OUT_DELAY;
      DFESENSCAL_out <= DFESENSCAL_outdelay after OUT_DELAY;
      DFETAP1MONITOR_out <= DFETAP1MONITOR_outdelay after OUT_DELAY;
      DFETAP2MONITOR_out <= DFETAP2MONITOR_outdelay after OUT_DELAY;
      DFETAP3MONITOR_out <= DFETAP3MONITOR_outdelay after OUT_DELAY;
      DFETAP4MONITOR_out <= DFETAP4MONITOR_outdelay after OUT_DELAY;
      DRDY_out <= DRDY_outdelay after OUT_DELAY;
      DRPDO_out <= DRPDO_outdelay after OUT_DELAY;
      PHYSTATUS_out <= PHYSTATUS_outdelay after OUT_DELAY;
      RXBUFSTATUS_out <= RXBUFSTATUS_outdelay after OUT_DELAY;
      RXBYTEISALIGNED_out <= RXBYTEISALIGNED_outdelay after OUT_DELAY;
      RXBYTEREALIGN_out <= RXBYTEREALIGN_outdelay after OUT_DELAY;
      RXCHANBONDSEQ_out <= RXCHANBONDSEQ_outdelay after OUT_DELAY;
      RXCHANISALIGNED_out <= RXCHANISALIGNED_outdelay after OUT_DELAY;
      RXCHANREALIGN_out <= RXCHANREALIGN_outdelay after OUT_DELAY;
      RXCHARISCOMMA_out <= RXCHARISCOMMA_outdelay after OUT_DELAY;
      RXCHARISK_out <= RXCHARISK_outdelay after OUT_DELAY;
      RXCHBONDO_out <= RXCHBONDO_outdelay after OUT_DELAY;
      RXCLKCORCNT_out <= RXCLKCORCNT_outdelay after OUT_DELAY;
      RXCOMMADET_out <= RXCOMMADET_outdelay after OUT_DELAY;
      RXDATAVALID_out <= RXDATAVALID_outdelay after OUT_DELAY;
      RXDATA_out <= RXDATA_outdelay after OUT_DELAY;
      RXDISPERR_out <= RXDISPERR_outdelay after OUT_DELAY;
      RXDLYALIGNMONITOR_out <= RXDLYALIGNMONITOR_outdelay after OUT_DELAY;
      RXELECIDLE_out <= RXELECIDLE_outdelay after OUT_DELAY;
      RXHEADERVALID_out <= RXHEADERVALID_outdelay after OUT_DELAY;
      RXHEADER_out <= RXHEADER_outdelay after OUT_DELAY;
      RXLOSSOFSYNC_out <= RXLOSSOFSYNC_outdelay after OUT_DELAY;
      RXNOTINTABLE_out <= RXNOTINTABLE_outdelay after OUT_DELAY;
      RXOVERSAMPLEERR_out <= RXOVERSAMPLEERR_outdelay after OUT_DELAY;
      RXPLLLKDET_out <= RXPLLLKDET_outdelay after OUT_DELAY;
      RXPRBSERR_out <= RXPRBSERR_outdelay after OUT_DELAY;
      RXRATEDONE_out <= RXRATEDONE_outdelay after OUT_DELAY;
      RXRESETDONE_out <= RXRESETDONE_outdelay after OUT_DELAY;
      RXRUNDISP_out <= RXRUNDISP_outdelay after OUT_DELAY;
      RXSTARTOFSEQ_out <= RXSTARTOFSEQ_outdelay after OUT_DELAY;
      RXSTATUS_out <= RXSTATUS_outdelay after OUT_DELAY;
      RXVALID_out <= RXVALID_outdelay after OUT_DELAY;
      TSTOUT_out <= TSTOUT_outdelay after OUT_DELAY;
      TXBUFSTATUS_out <= TXBUFSTATUS_outdelay after OUT_DELAY;
      TXDLYALIGNMONITOR_out <= TXDLYALIGNMONITOR_outdelay after OUT_DELAY;
      TXGEARBOXREADY_out <= TXGEARBOXREADY_outdelay after OUT_DELAY;
      TXKERR_out <= TXKERR_outdelay after OUT_DELAY;
      TXN_out <= TXN_outdelay after OUT_DELAY;
      TXPLLLKDET_out <= TXPLLLKDET_outdelay after OUT_DELAY;
      TXP_out <= TXP_outdelay after OUT_DELAY;
      TXRATEDONE_out <= TXRATEDONE_outdelay after OUT_DELAY;
      TXRESETDONE_out <= TXRESETDONE_outdelay after OUT_DELAY;
      TXRUNDISP_out <= TXRUNDISP_outdelay after OUT_DELAY;
      
      DCLK_indly <= DCLK_indelay after INCLK_DELAY;
      GREFCLKRX_indly <= GREFCLKRX_indelay after INCLK_DELAY;
      GREFCLKTX_indly <= GREFCLKTX_indelay after INCLK_DELAY;
      MGTREFCLKRX_indly <= MGTREFCLKRX_indelay after INCLK_DELAY;
      MGTREFCLKTX_indly <= MGTREFCLKTX_indelay after INCLK_DELAY;
      NORTHREFCLKRX_indly <= NORTHREFCLKRX_indelay after INCLK_DELAY;
      NORTHREFCLKTX_indly <= NORTHREFCLKTX_indelay after INCLK_DELAY;
      PERFCLKRX_indly <= PERFCLKRX_indelay after INCLK_DELAY;
      PERFCLKTX_indly <= PERFCLKTX_indelay after INCLK_DELAY;
      RXUSRCLK2_indly <= RXUSRCLK2_indelay after INCLK_DELAY;
      RXUSRCLK_indly <= RXUSRCLK_indelay after INCLK_DELAY;
      SOUTHREFCLKRX_indly <= SOUTHREFCLKRX_indelay after INCLK_DELAY;
      SOUTHREFCLKTX_indly <= SOUTHREFCLKTX_indelay after INCLK_DELAY;
      TSTCLK0_indly <= TSTCLK0_indelay after INCLK_DELAY;
      TSTCLK1_indly <= TSTCLK1_indelay after INCLK_DELAY;
      TXUSRCLK2_indly <= TXUSRCLK2_indelay after INCLK_DELAY;
      TXUSRCLK_indly <= TXUSRCLK_indelay after INCLK_DELAY;
      
      DADDR_indly <= DADDR_indelay after IN_DELAY;
      DEN_indly <= DEN_indelay after IN_DELAY;
      DFECLKDLYADJ_indly <= DFECLKDLYADJ_indelay after IN_DELAY;
      DFEDLYOVRD_indly <= DFEDLYOVRD_indelay after IN_DELAY;
      DFETAP1_indly <= DFETAP1_indelay after IN_DELAY;
      DFETAP2_indly <= DFETAP2_indelay after IN_DELAY;
      DFETAP3_indly <= DFETAP3_indelay after IN_DELAY;
      DFETAP4_indly <= DFETAP4_indelay after IN_DELAY;
      DFETAPOVRD_indly <= DFETAPOVRD_indelay after IN_DELAY;
      DI_indly <= DI_indelay after IN_DELAY;
      DWE_indly <= DWE_indelay after IN_DELAY;
      GATERXELECIDLE_indly <= GATERXELECIDLE_indelay after IN_DELAY;
      GTXRXRESET_indly <= GTXRXRESET_indelay after IN_DELAY;
      GTXTEST_indly <= GTXTEST_indelay after IN_DELAY;
      GTXTXRESET_indly <= GTXTXRESET_indelay after IN_DELAY;
      IGNORESIGDET_indly <= IGNORESIGDET_indelay after IN_DELAY;
      LOOPBACK_indly <= LOOPBACK_indelay after IN_DELAY;
      PLLRXRESET_indly <= PLLRXRESET_indelay after IN_DELAY;
      PLLTXRESET_indly <= PLLTXRESET_indelay after IN_DELAY;
      PRBSCNTRESET_indly <= PRBSCNTRESET_indelay after IN_DELAY;
      RXBUFRESET_indly <= RXBUFRESET_indelay after IN_DELAY;
      RXCDRRESET_indly <= RXCDRRESET_indelay after IN_DELAY;
      RXCHBONDI_indly <= RXCHBONDI_indelay after IN_DELAY;
      RXCHBONDLEVEL_indly <= RXCHBONDLEVEL_indelay after IN_DELAY;
      RXCHBONDMASTER_indly <= RXCHBONDMASTER_indelay after IN_DELAY;
      RXCHBONDSLAVE_indly <= RXCHBONDSLAVE_indelay after IN_DELAY;
      RXCOMMADETUSE_indly <= RXCOMMADETUSE_indelay after IN_DELAY;
      RXDEC8B10BUSE_indly <= RXDEC8B10BUSE_indelay after IN_DELAY;
      RXDLYALIGNDISABLE_indly <= RXDLYALIGNDISABLE_indelay after IN_DELAY;
      RXDLYALIGNMONENB_indly <= RXDLYALIGNMONENB_indelay after IN_DELAY;
      RXDLYALIGNOVERRIDE_indly <= RXDLYALIGNOVERRIDE_indelay after IN_DELAY;
      RXDLYALIGNRESET_indly <= RXDLYALIGNRESET_indelay after IN_DELAY;
      RXDLYALIGNSWPPRECURB_indly <= RXDLYALIGNSWPPRECURB_indelay after IN_DELAY;
      RXDLYALIGNUPDSW_indly <= RXDLYALIGNUPDSW_indelay after IN_DELAY;
      RXENCHANSYNC_indly <= RXENCHANSYNC_indelay after IN_DELAY;
      RXENMCOMMAALIGN_indly <= RXENMCOMMAALIGN_indelay after IN_DELAY;
      RXENPCOMMAALIGN_indly <= RXENPCOMMAALIGN_indelay after IN_DELAY;
      RXENPMAPHASEALIGN_indly <= RXENPMAPHASEALIGN_indelay after IN_DELAY;
      RXENPRBSTST_indly <= RXENPRBSTST_indelay after IN_DELAY;
      RXENSAMPLEALIGN_indly <= RXENSAMPLEALIGN_indelay after IN_DELAY;
      RXEQMIX_indly <= RXEQMIX_indelay after IN_DELAY;
      RXGEARBOXSLIP_indly <= RXGEARBOXSLIP_indelay after IN_DELAY;
      RXN_indly <= RXN_indelay after IN_DELAY;
      RXPLLLKDETEN_indly <= RXPLLLKDETEN_indelay after IN_DELAY;
      RXPLLPOWERDOWN_indly <= RXPLLPOWERDOWN_indelay after IN_DELAY;
      RXPLLREFSELDY_indly <= RXPLLREFSELDY_indelay after IN_DELAY;
      RXPMASETPHASE_indly <= RXPMASETPHASE_indelay after IN_DELAY;
      RXPOLARITY_indly <= RXPOLARITY_indelay after IN_DELAY;
      RXPOWERDOWN_indly <= RXPOWERDOWN_indelay after IN_DELAY;
      RXP_indly <= RXP_indelay after IN_DELAY;
      RXRATE_indly <= RXRATE_indelay after IN_DELAY;
      RXRESET_indly <= RXRESET_indelay after IN_DELAY;
      RXSLIDE_indly <= RXSLIDE_indelay after IN_DELAY;
      TSTIN_indly <= TSTIN_indelay after IN_DELAY;
      TXBUFDIFFCTRL_indly <= TXBUFDIFFCTRL_indelay after IN_DELAY;
      TXBYPASS8B10B_indly <= TXBYPASS8B10B_indelay after IN_DELAY;
      TXCHARDISPMODE_indly <= TXCHARDISPMODE_indelay after IN_DELAY;
      TXCHARDISPVAL_indly <= TXCHARDISPVAL_indelay after IN_DELAY;
      TXCHARISK_indly <= TXCHARISK_indelay after IN_DELAY;
      TXCOMINIT_indly <= TXCOMINIT_indelay after IN_DELAY;
      TXCOMSAS_indly <= TXCOMSAS_indelay after IN_DELAY;
      TXCOMWAKE_indly <= TXCOMWAKE_indelay after IN_DELAY;
      TXDATA_indly <= TXDATA_indelay after IN_DELAY;
      TXDEEMPH_indly <= TXDEEMPH_indelay after IN_DELAY;
      TXDETECTRX_indly <= TXDETECTRX_indelay after IN_DELAY;
      TXDIFFCTRL_indly <= TXDIFFCTRL_indelay after IN_DELAY;
      TXDLYALIGNDISABLE_indly <= TXDLYALIGNDISABLE_indelay after IN_DELAY;
      TXDLYALIGNMONENB_indly <= TXDLYALIGNMONENB_indelay after IN_DELAY;
      TXDLYALIGNOVERRIDE_indly <= TXDLYALIGNOVERRIDE_indelay after IN_DELAY;
      TXDLYALIGNRESET_indly <= TXDLYALIGNRESET_indelay after IN_DELAY;
      TXDLYALIGNUPDSW_indly <= TXDLYALIGNUPDSW_indelay after IN_DELAY;
      TXELECIDLE_indly <= TXELECIDLE_indelay after IN_DELAY;
      TXENC8B10BUSE_indly <= TXENC8B10BUSE_indelay after IN_DELAY;
      TXENPMAPHASEALIGN_indly <= TXENPMAPHASEALIGN_indelay after IN_DELAY;
      TXENPRBSTST_indly <= TXENPRBSTST_indelay after IN_DELAY;
      TXHEADER_indly <= TXHEADER_indelay after IN_DELAY;
      TXINHIBIT_indly <= TXINHIBIT_indelay after IN_DELAY;
      TXMARGIN_indly <= TXMARGIN_indelay after IN_DELAY;
      TXPDOWNASYNCH_indly <= TXPDOWNASYNCH_indelay after IN_DELAY;
      TXPLLLKDETEN_indly <= TXPLLLKDETEN_indelay after IN_DELAY;
      TXPLLPOWERDOWN_indly <= TXPLLPOWERDOWN_indelay after IN_DELAY;
      TXPLLREFSELDY_indly <= TXPLLREFSELDY_indelay after IN_DELAY;
      TXPMASETPHASE_indly <= TXPMASETPHASE_indelay after IN_DELAY;
      TXPOLARITY_indly <= TXPOLARITY_indelay after IN_DELAY;
      TXPOSTEMPHASIS_indly <= TXPOSTEMPHASIS_indelay after IN_DELAY;
      TXPOWERDOWN_indly <= TXPOWERDOWN_indelay after IN_DELAY;
      TXPRBSFORCEERR_indly <= TXPRBSFORCEERR_indelay after IN_DELAY;
      TXPREEMPHASIS_indly <= TXPREEMPHASIS_indelay after IN_DELAY;
      TXRATE_indly <= TXRATE_indelay after IN_DELAY;
      TXRESET_indly <= TXRESET_indelay after IN_DELAY;
      TXSEQUENCE_indly <= TXSEQUENCE_indelay after IN_DELAY;
      TXSTARTSEQ_indly <= TXSTARTSEQ_indelay after IN_DELAY;
      TXSWING_indly <= TXSWING_indelay after IN_DELAY;
      USRCODEERR_indly <= USRCODEERR_indelay after IN_DELAY;

-- <!--Aldec correction start
          GSR_local <= GSR;
-- Aldec correction end -->
      
      GTXE1_WRAP_INST : GTXE1_WRAP
       generic map (
        AC_CAP_DIS           => AC_CAP_DIS_STRING,
        ALIGN_COMMA_WORD     => ALIGN_COMMA_WORD,
        BGTEST_CFG           => BGTEST_CFG_STRING,
        BIAS_CFG             => BIAS_CFG_STRING,
        CDR_PH_ADJ_TIME      => CDR_PH_ADJ_TIME_STRING,
        CHAN_BOND_1_MAX_SKEW => CHAN_BOND_1_MAX_SKEW,
        CHAN_BOND_2_MAX_SKEW => CHAN_BOND_2_MAX_SKEW,
        CHAN_BOND_KEEP_ALIGN => CHAN_BOND_KEEP_ALIGN_STRING,
        CHAN_BOND_SEQ_1_1    => CHAN_BOND_SEQ_1_1_STRING,
        CHAN_BOND_SEQ_1_2    => CHAN_BOND_SEQ_1_2_STRING,
        CHAN_BOND_SEQ_1_3    => CHAN_BOND_SEQ_1_3_STRING,
        CHAN_BOND_SEQ_1_4    => CHAN_BOND_SEQ_1_4_STRING,
        CHAN_BOND_SEQ_1_ENABLE => CHAN_BOND_SEQ_1_ENABLE_STRING,
        CHAN_BOND_SEQ_2_1    => CHAN_BOND_SEQ_2_1_STRING,
        CHAN_BOND_SEQ_2_2    => CHAN_BOND_SEQ_2_2_STRING,
        CHAN_BOND_SEQ_2_3    => CHAN_BOND_SEQ_2_3_STRING,
        CHAN_BOND_SEQ_2_4    => CHAN_BOND_SEQ_2_4_STRING,
        CHAN_BOND_SEQ_2_CFG  => CHAN_BOND_SEQ_2_CFG_STRING,
        CHAN_BOND_SEQ_2_ENABLE => CHAN_BOND_SEQ_2_ENABLE_STRING,
        CHAN_BOND_SEQ_2_USE  => CHAN_BOND_SEQ_2_USE_STRING,
        CHAN_BOND_SEQ_LEN    => CHAN_BOND_SEQ_LEN,
        CLK_CORRECT_USE      => CLK_CORRECT_USE_STRING,
        CLK_COR_ADJ_LEN      => CLK_COR_ADJ_LEN,
        CLK_COR_DET_LEN      => CLK_COR_DET_LEN,
        CLK_COR_INSERT_IDLE_FLAG => CLK_COR_INSERT_IDLE_FLAG_STRING,
        CLK_COR_KEEP_IDLE    => CLK_COR_KEEP_IDLE_STRING,
        CLK_COR_MAX_LAT      => CLK_COR_MAX_LAT,
        CLK_COR_MIN_LAT      => CLK_COR_MIN_LAT,
        CLK_COR_PRECEDENCE   => CLK_COR_PRECEDENCE_STRING,
        CLK_COR_REPEAT_WAIT  => CLK_COR_REPEAT_WAIT,
        CLK_COR_SEQ_1_1      => CLK_COR_SEQ_1_1_STRING,
        CLK_COR_SEQ_1_2      => CLK_COR_SEQ_1_2_STRING,
        CLK_COR_SEQ_1_3      => CLK_COR_SEQ_1_3_STRING,
        CLK_COR_SEQ_1_4      => CLK_COR_SEQ_1_4_STRING,
        CLK_COR_SEQ_1_ENABLE => CLK_COR_SEQ_1_ENABLE_STRING,
        CLK_COR_SEQ_2_1      => CLK_COR_SEQ_2_1_STRING,
        CLK_COR_SEQ_2_2      => CLK_COR_SEQ_2_2_STRING,
        CLK_COR_SEQ_2_3      => CLK_COR_SEQ_2_3_STRING,
        CLK_COR_SEQ_2_4      => CLK_COR_SEQ_2_4_STRING,
        CLK_COR_SEQ_2_ENABLE => CLK_COR_SEQ_2_ENABLE_STRING,
        CLK_COR_SEQ_2_USE    => CLK_COR_SEQ_2_USE_STRING,
        CM_TRIM              => CM_TRIM_STRING,
        COMMA_10B_ENABLE     => COMMA_10B_ENABLE_STRING,
        COMMA_DOUBLE         => COMMA_DOUBLE_STRING,
        COM_BURST_VAL        => COM_BURST_VAL_STRING,
        DEC_MCOMMA_DETECT    => DEC_MCOMMA_DETECT_STRING,
        DEC_PCOMMA_DETECT    => DEC_PCOMMA_DETECT_STRING,
        DEC_VALID_COMMA_ONLY => DEC_VALID_COMMA_ONLY_STRING,
        DFE_CAL_TIME         => DFE_CAL_TIME_STRING,
        DFE_CFG              => DFE_CFG_STRING,
        GEARBOX_ENDEC        => GEARBOX_ENDEC_STRING,
        GEN_RXUSRCLK         => GEN_RXUSRCLK_STRING,
        GEN_TXUSRCLK         => GEN_TXUSRCLK_STRING,
        GTX_CFG_PWRUP        => GTX_CFG_PWRUP_STRING,
        MCOMMA_10B_VALUE     => MCOMMA_10B_VALUE_STRING,
        MCOMMA_DETECT        => MCOMMA_DETECT_STRING,
        OOBDETECT_THRESHOLD  => OOBDETECT_THRESHOLD_STRING,
        PCI_EXPRESS_MODE     => PCI_EXPRESS_MODE_STRING,
        PCOMMA_10B_VALUE     => PCOMMA_10B_VALUE_STRING,
        PCOMMA_DETECT        => PCOMMA_DETECT_STRING,
        PMA_CAS_CLK_EN       => PMA_CAS_CLK_EN_STRING,
        PMA_CDR_SCAN         => PMA_CDR_SCAN_STRING,
        PMA_CFG              => PMA_CFG_STRING,
        PMA_RXSYNC_CFG       => PMA_RXSYNC_CFG_STRING,
        PMA_RX_CFG           => PMA_RX_CFG_STRING,
        PMA_TX_CFG           => PMA_TX_CFG_STRING,
        POWER_SAVE           => POWER_SAVE_STRING,
        RCV_TERM_GND         => RCV_TERM_GND_STRING,
        RCV_TERM_VTTRX       => RCV_TERM_VTTRX_STRING,
        RXGEARBOX_USE        => RXGEARBOX_USE_STRING,
        RXPLL_COM_CFG        => RXPLL_COM_CFG_STRING,
        RXPLL_CP_CFG         => RXPLL_CP_CFG_STRING,
        RXPLL_DIVSEL45_FB    => RXPLL_DIVSEL45_FB,
        RXPLL_DIVSEL_FB      => RXPLL_DIVSEL_FB,
        RXPLL_DIVSEL_OUT     => RXPLL_DIVSEL_OUT,
        RXPLL_DIVSEL_REF     => RXPLL_DIVSEL_REF,
        RXPLL_LKDET_CFG      => RXPLL_LKDET_CFG_STRING,
        RXPRBSERR_LOOPBACK   => RXPRBSERR_LOOPBACK_STRING,
        RXRECCLK_CTRL        => RXRECCLK_CTRL,
        RXRECCLK_DLY         => RXRECCLK_DLY_STRING,
        RXUSRCLK_DLY         => RXUSRCLK_DLY_STRING,
        RX_BUFFER_USE        => RX_BUFFER_USE_STRING,
        RX_CLK25_DIVIDER     => RX_CLK25_DIVIDER,
        RX_DATA_WIDTH        => RX_DATA_WIDTH,
        RX_DECODE_SEQ_MATCH  => RX_DECODE_SEQ_MATCH_STRING,
        RX_DLYALIGN_CTRINC   => RX_DLYALIGN_CTRINC_STRING,
        RX_DLYALIGN_EDGESET  => RX_DLYALIGN_EDGESET_STRING,
        RX_DLYALIGN_LPFINC   => RX_DLYALIGN_LPFINC_STRING,
        RX_DLYALIGN_MONSEL   => RX_DLYALIGN_MONSEL_STRING,
        RX_DLYALIGN_OVRDSETTING => RX_DLYALIGN_OVRDSETTING_STRING,
        RX_EN_IDLE_HOLD_CDR  => RX_EN_IDLE_HOLD_CDR_STRING,
        RX_EN_IDLE_HOLD_DFE  => RX_EN_IDLE_HOLD_DFE_STRING,
        RX_EN_IDLE_RESET_BUF => RX_EN_IDLE_RESET_BUF_STRING,
        RX_EN_IDLE_RESET_FR  => RX_EN_IDLE_RESET_FR_STRING,
        RX_EN_IDLE_RESET_PH  => RX_EN_IDLE_RESET_PH_STRING,
        RX_EN_MODE_RESET_BUF => RX_EN_MODE_RESET_BUF_STRING,
        RX_EN_RATE_RESET_BUF => RX_EN_RATE_RESET_BUF_STRING,
        RX_EN_REALIGN_RESET_BUF => RX_EN_REALIGN_RESET_BUF_STRING,
        RX_EN_REALIGN_RESET_BUF2 => RX_EN_REALIGN_RESET_BUF2_STRING,
        RX_EYE_OFFSET        => RX_EYE_OFFSET_STRING,
        RX_EYE_SCANMODE      => RX_EYE_SCANMODE_STRING,
        RX_FIFO_ADDR_MODE    => RX_FIFO_ADDR_MODE,
        RX_IDLE_HI_CNT       => RX_IDLE_HI_CNT_STRING,
        RX_IDLE_LO_CNT       => RX_IDLE_LO_CNT_STRING,
        RX_LOSS_OF_SYNC_FSM  => RX_LOSS_OF_SYNC_FSM_STRING,
        RX_LOS_INVALID_INCR  => RX_LOS_INVALID_INCR,
        RX_LOS_THRESHOLD     => RX_LOS_THRESHOLD,
        RX_OVERSAMPLE_MODE   => RX_OVERSAMPLE_MODE_STRING,
        RX_SLIDE_AUTO_WAIT   => RX_SLIDE_AUTO_WAIT,
        RX_SLIDE_MODE        => RX_SLIDE_MODE,
        RX_XCLK_SEL          => RX_XCLK_SEL,
        SAS_MAX_COMSAS       => SAS_MAX_COMSAS,
        SAS_MIN_COMSAS       => SAS_MIN_COMSAS,
        SATA_BURST_VAL       => SATA_BURST_VAL_STRING,
        SATA_IDLE_VAL        => SATA_IDLE_VAL_STRING,
        SATA_MAX_BURST       => SATA_MAX_BURST,
        SATA_MAX_INIT        => SATA_MAX_INIT,
        SATA_MAX_WAKE        => SATA_MAX_WAKE,
        SATA_MIN_BURST       => SATA_MIN_BURST,
        SATA_MIN_INIT        => SATA_MIN_INIT,
        SATA_MIN_WAKE        => SATA_MIN_WAKE,
        SHOW_REALIGN_COMMA   => SHOW_REALIGN_COMMA_STRING,
        SIM_GTXRESET_SPEEDUP => SIM_GTXRESET_SPEEDUP,
        SIM_RECEIVER_DETECT_PASS => SIM_RECEIVER_DETECT_PASS_STRING,
        SIM_RXREFCLK_SOURCE  => SIM_RXREFCLK_SOURCE_STRING,
        SIM_TXREFCLK_SOURCE  => SIM_TXREFCLK_SOURCE_STRING,
        SIM_TX_ELEC_IDLE_LEVEL => SIM_TX_ELEC_IDLE_LEVEL,
        SIM_VERSION          => SIM_VERSION,
        TERMINATION_CTRL     => TERMINATION_CTRL_STRING,
        TERMINATION_OVRD     => TERMINATION_OVRD_STRING,
        TRANS_TIME_FROM_P2   => TRANS_TIME_FROM_P2_STRING,
        TRANS_TIME_NON_P2    => TRANS_TIME_NON_P2_STRING,
        TRANS_TIME_RATE      => TRANS_TIME_RATE_STRING,
        TRANS_TIME_TO_P2     => TRANS_TIME_TO_P2_STRING,
        TST_ATTR             => TST_ATTR_STRING,
        TXDRIVE_LOOPBACK_HIZ => TXDRIVE_LOOPBACK_HIZ_STRING,
        TXDRIVE_LOOPBACK_PD  => TXDRIVE_LOOPBACK_PD_STRING,
        TXGEARBOX_USE        => TXGEARBOX_USE_STRING,
        TXOUTCLK_CTRL        => TXOUTCLK_CTRL,
        TXOUTCLK_DLY         => TXOUTCLK_DLY_STRING,
        TXPLL_COM_CFG        => TXPLL_COM_CFG_STRING,
        TXPLL_CP_CFG         => TXPLL_CP_CFG_STRING,
        TXPLL_DIVSEL45_FB    => TXPLL_DIVSEL45_FB,
        TXPLL_DIVSEL_FB      => TXPLL_DIVSEL_FB,
        TXPLL_DIVSEL_OUT     => TXPLL_DIVSEL_OUT,
        TXPLL_DIVSEL_REF     => TXPLL_DIVSEL_REF,
        TXPLL_LKDET_CFG      => TXPLL_LKDET_CFG_STRING,
        TXPLL_SATA           => TXPLL_SATA_STRING,
        TX_BUFFER_USE        => TX_BUFFER_USE_STRING,
        TX_BYTECLK_CFG       => TX_BYTECLK_CFG_STRING,
        TX_CLK25_DIVIDER     => TX_CLK25_DIVIDER,
        TX_CLK_SOURCE        => TX_CLK_SOURCE,
        TX_DATA_WIDTH        => TX_DATA_WIDTH,
        TX_DEEMPH_0          => TX_DEEMPH_0_STRING,
        TX_DEEMPH_1          => TX_DEEMPH_1_STRING,
        TX_DETECT_RX_CFG     => TX_DETECT_RX_CFG_STRING,
        TX_DLYALIGN_CTRINC   => TX_DLYALIGN_CTRINC_STRING,
        TX_DLYALIGN_LPFINC   => TX_DLYALIGN_LPFINC_STRING,
        TX_DLYALIGN_MONSEL   => TX_DLYALIGN_MONSEL_STRING,
        TX_DLYALIGN_OVRDSETTING => TX_DLYALIGN_OVRDSETTING_STRING,
        TX_DRIVE_MODE        => TX_DRIVE_MODE,
        TX_EN_RATE_RESET_BUF => TX_EN_RATE_RESET_BUF_STRING,
        TX_IDLE_ASSERT_DELAY => TX_IDLE_ASSERT_DELAY_STRING,
        TX_IDLE_DEASSERT_DELAY => TX_IDLE_DEASSERT_DELAY_STRING,
        TX_MARGIN_FULL_0     => TX_MARGIN_FULL_0_STRING,
        TX_MARGIN_FULL_1     => TX_MARGIN_FULL_1_STRING,
        TX_MARGIN_FULL_2     => TX_MARGIN_FULL_2_STRING,
        TX_MARGIN_FULL_3     => TX_MARGIN_FULL_3_STRING,
        TX_MARGIN_FULL_4     => TX_MARGIN_FULL_4_STRING,
        TX_MARGIN_LOW_0      => TX_MARGIN_LOW_0_STRING,
        TX_MARGIN_LOW_1      => TX_MARGIN_LOW_1_STRING,
        TX_MARGIN_LOW_2      => TX_MARGIN_LOW_2_STRING,
        TX_MARGIN_LOW_3      => TX_MARGIN_LOW_3_STRING,
        TX_MARGIN_LOW_4      => TX_MARGIN_LOW_4_STRING,
        TX_OVERSAMPLE_MODE   => TX_OVERSAMPLE_MODE_STRING,
        TX_PMADATA_OPT       => TX_PMADATA_OPT_STRING,
        TX_TDCC_CFG          => TX_TDCC_CFG_STRING,
        TX_USRCLK_CFG        => TX_USRCLK_CFG_STRING,
        TX_XCLK_SEL          => TX_XCLK_SEL
      )
      
        port map (
-- <!--Aldec correction start        
        GSR => GSR_local,
-- Aldec correction end --> 
          COMFINISH            => COMFINISH_outdelay,
          COMINITDET           => COMINITDET_outdelay,
          COMSASDET            => COMSASDET_outdelay,
          COMWAKEDET           => COMWAKEDET_outdelay,
          DFECLKDLYADJMON      => DFECLKDLYADJMON_outdelay,
          DFEEYEDACMON         => DFEEYEDACMON_outdelay,
          DFESENSCAL           => DFESENSCAL_outdelay,
          DFETAP1MONITOR       => DFETAP1MONITOR_outdelay,
          DFETAP2MONITOR       => DFETAP2MONITOR_outdelay,
          DFETAP3MONITOR       => DFETAP3MONITOR_outdelay,
          DFETAP4MONITOR       => DFETAP4MONITOR_outdelay,
          DRDY                 => DRDY_outdelay,
          DRPDO                => DRPDO_outdelay,
          MGTREFCLKFAB         => MGTREFCLKFAB_outdelay,
          PHYSTATUS            => PHYSTATUS_outdelay,
          RXBUFSTATUS          => RXBUFSTATUS_outdelay,
          RXBYTEISALIGNED      => RXBYTEISALIGNED_outdelay,
          RXBYTEREALIGN        => RXBYTEREALIGN_outdelay,
          RXCHANBONDSEQ        => RXCHANBONDSEQ_outdelay,
          RXCHANISALIGNED      => RXCHANISALIGNED_outdelay,
          RXCHANREALIGN        => RXCHANREALIGN_outdelay,
          RXCHARISCOMMA        => RXCHARISCOMMA_outdelay,
          RXCHARISK            => RXCHARISK_outdelay,
          RXCHBONDO            => RXCHBONDO_outdelay,
          RXCLKCORCNT          => RXCLKCORCNT_outdelay,
          RXCOMMADET           => RXCOMMADET_outdelay,
          RXDATA               => RXDATA_outdelay,
          RXDATAVALID          => RXDATAVALID_outdelay,
          RXDISPERR            => RXDISPERR_outdelay,
          RXDLYALIGNMONITOR    => RXDLYALIGNMONITOR_outdelay,
          RXELECIDLE           => RXELECIDLE_outdelay,
          RXHEADER             => RXHEADER_outdelay,
          RXHEADERVALID        => RXHEADERVALID_outdelay,
          RXLOSSOFSYNC         => RXLOSSOFSYNC_outdelay,
          RXNOTINTABLE         => RXNOTINTABLE_outdelay,
          RXOVERSAMPLEERR      => RXOVERSAMPLEERR_outdelay,
          RXPLLLKDET           => RXPLLLKDET_outdelay,
          RXPRBSERR            => RXPRBSERR_outdelay,
          RXRATEDONE           => RXRATEDONE_outdelay,
          RXRECCLK             => RXRECCLK_outdelay,
          RXRECCLKPCS          => RXRECCLKPCS_outdelay,
          RXRESETDONE          => RXRESETDONE_outdelay,
          RXRUNDISP            => RXRUNDISP_outdelay,
          RXSTARTOFSEQ         => RXSTARTOFSEQ_outdelay,
          RXSTATUS             => RXSTATUS_outdelay,
          RXVALID              => RXVALID_outdelay,
          TSTOUT               => TSTOUT_outdelay,
          TXBUFSTATUS          => TXBUFSTATUS_outdelay,
          TXDLYALIGNMONITOR    => TXDLYALIGNMONITOR_outdelay,
          TXGEARBOXREADY       => TXGEARBOXREADY_outdelay,
          TXKERR               => TXKERR_outdelay,
          TXN                  => TXN_outdelay,
          TXOUTCLK             => TXOUTCLK_outdelay,
          TXOUTCLKPCS          => TXOUTCLKPCS_outdelay,
          TXP                  => TXP_outdelay,
          TXPLLLKDET           => TXPLLLKDET_outdelay,
          TXRATEDONE           => TXRATEDONE_outdelay,
          TXRESETDONE          => TXRESETDONE_outdelay,
          TXRUNDISP            => TXRUNDISP_outdelay,
          DADDR                => DADDR_indly,
          DCLK                 => DCLK_indly,
          DEN                  => DEN_indly,
          DFECLKDLYADJ         => DFECLKDLYADJ_indly,
          DFEDLYOVRD           => DFEDLYOVRD_indly,
          DFETAP1              => DFETAP1_indly,
          DFETAP2              => DFETAP2_indly,
          DFETAP3              => DFETAP3_indly,
          DFETAP4              => DFETAP4_indly,
          DFETAPOVRD           => DFETAPOVRD_indly,
          DI                   => DI_indly,
          DWE                  => DWE_indly,
          GATERXELECIDLE       => GATERXELECIDLE_indly,
          GREFCLKRX            => GREFCLKRX_indly,
          GREFCLKTX            => GREFCLKTX_indly,
          GTXRXRESET           => GTXRXRESET_indly,
          GTXTEST              => GTXTEST_indly,
          GTXTXRESET           => GTXTXRESET_indly,
          IGNORESIGDET         => IGNORESIGDET_indly,
          LOOPBACK             => LOOPBACK_indly,
          MGTREFCLKRX          => MGTREFCLKRX_indly,
          MGTREFCLKTX          => MGTREFCLKTX_indly,
          NORTHREFCLKRX        => NORTHREFCLKRX_indly,
          NORTHREFCLKTX        => NORTHREFCLKTX_indly,
          PERFCLKRX            => PERFCLKRX_indly,
          PERFCLKTX            => PERFCLKTX_indly,
          PLLRXRESET           => PLLRXRESET_indly,
          PLLTXRESET           => PLLTXRESET_indly,
          PRBSCNTRESET         => PRBSCNTRESET_indly,
          RXBUFRESET           => RXBUFRESET_indly,
          RXCDRRESET           => RXCDRRESET_indly,
          RXCHBONDI            => RXCHBONDI_indly,
          RXCHBONDLEVEL        => RXCHBONDLEVEL_indly,
          RXCHBONDMASTER       => RXCHBONDMASTER_indly,
          RXCHBONDSLAVE        => RXCHBONDSLAVE_indly,
          RXCOMMADETUSE        => RXCOMMADETUSE_indly,
          RXDEC8B10BUSE        => RXDEC8B10BUSE_indly,
          RXDLYALIGNDISABLE    => RXDLYALIGNDISABLE_indly,
          RXDLYALIGNMONENB     => RXDLYALIGNMONENB_indly,
          RXDLYALIGNOVERRIDE   => RXDLYALIGNOVERRIDE_indly,
          RXDLYALIGNRESET      => RXDLYALIGNRESET_indly,
          RXDLYALIGNSWPPRECURB => RXDLYALIGNSWPPRECURB_indly,
          RXDLYALIGNUPDSW      => RXDLYALIGNUPDSW_indly,
          RXENCHANSYNC         => RXENCHANSYNC_indly,
          RXENMCOMMAALIGN      => RXENMCOMMAALIGN_indly,
          RXENPCOMMAALIGN      => RXENPCOMMAALIGN_indly,
          RXENPMAPHASEALIGN    => RXENPMAPHASEALIGN_indly,
          RXENPRBSTST          => RXENPRBSTST_indly,
          RXENSAMPLEALIGN      => RXENSAMPLEALIGN_indly,
          RXEQMIX              => RXEQMIX_indly,
          RXGEARBOXSLIP        => RXGEARBOXSLIP_indly,
          RXN                  => RXN_indly,
          RXP                  => RXP_indly,
          RXPLLLKDETEN         => RXPLLLKDETEN_indly,
          RXPLLPOWERDOWN       => RXPLLPOWERDOWN_indly,
          RXPLLREFSELDY        => RXPLLREFSELDY_indly,
          RXPMASETPHASE        => RXPMASETPHASE_indly,
          RXPOLARITY           => RXPOLARITY_indly,
          RXPOWERDOWN          => RXPOWERDOWN_indly,
          RXRATE               => RXRATE_indly,
          RXRESET              => RXRESET_indly,
          RXSLIDE              => RXSLIDE_indly,
          RXUSRCLK             => RXUSRCLK_indly,
          RXUSRCLK2            => RXUSRCLK2_indly,
          SOUTHREFCLKRX        => SOUTHREFCLKRX_indly,
          SOUTHREFCLKTX        => SOUTHREFCLKTX_indly,
          TSTCLK0              => TSTCLK0_indly,
          TSTCLK1              => TSTCLK1_indly,
          TSTIN                => TSTIN_indly,
          TXBUFDIFFCTRL        => TXBUFDIFFCTRL_indly,
          TXBYPASS8B10B        => TXBYPASS8B10B_indly,
          TXCHARDISPMODE       => TXCHARDISPMODE_indly,
          TXCHARDISPVAL        => TXCHARDISPVAL_indly,
          TXCHARISK            => TXCHARISK_indly,
          TXCOMINIT            => TXCOMINIT_indly,
          TXCOMSAS             => TXCOMSAS_indly,
          TXCOMWAKE            => TXCOMWAKE_indly,
          TXDATA               => TXDATA_indly,
          TXDEEMPH             => TXDEEMPH_indly,
          TXDETECTRX           => TXDETECTRX_indly,
          TXDIFFCTRL           => TXDIFFCTRL_indly,
          TXDLYALIGNDISABLE    => TXDLYALIGNDISABLE_indly,
          TXDLYALIGNMONENB     => TXDLYALIGNMONENB_indly,
          TXDLYALIGNOVERRIDE   => TXDLYALIGNOVERRIDE_indly,
          TXDLYALIGNRESET      => TXDLYALIGNRESET_indly,
          TXDLYALIGNUPDSW      => TXDLYALIGNUPDSW_indly,
          TXELECIDLE           => TXELECIDLE_indly,
          TXENC8B10BUSE        => TXENC8B10BUSE_indly,
          TXENPMAPHASEALIGN    => TXENPMAPHASEALIGN_indly,
          TXENPRBSTST          => TXENPRBSTST_indly,
          TXHEADER             => TXHEADER_indly,
          TXINHIBIT            => TXINHIBIT_indly,
          TXMARGIN             => TXMARGIN_indly,
          TXPDOWNASYNCH        => TXPDOWNASYNCH_indly,
          TXPLLLKDETEN         => TXPLLLKDETEN_indly,
          TXPLLPOWERDOWN       => TXPLLPOWERDOWN_indly,
          TXPLLREFSELDY        => TXPLLREFSELDY_indly,
          TXPMASETPHASE        => TXPMASETPHASE_indly,
          TXPOLARITY           => TXPOLARITY_indly,
          TXPOSTEMPHASIS       => TXPOSTEMPHASIS_indly,
          TXPOWERDOWN          => TXPOWERDOWN_indly,
          TXPRBSFORCEERR       => TXPRBSFORCEERR_indly,
          TXPREEMPHASIS        => TXPREEMPHASIS_indly,
          TXRATE               => TXRATE_indly,
          TXRESET              => TXRESET_indly,
          TXSEQUENCE           => TXSEQUENCE_indly,
          TXSTARTSEQ           => TXSTARTSEQ_indly,
          TXSWING              => TXSWING_indly,
          TXUSRCLK             => TXUSRCLK_indly,
          TXUSRCLK2            => TXUSRCLK2_indly,
          USRCODEERR           => USRCODEERR_indly
        );
      
      INIPROC : process
      begin

        -- Start DRC Checks

        if (CHAN_BOND_2_MAX_SKEW > CHAN_BOND_1_MAX_SKEW) then
        assert false
          report "DRC Error : The value of CHAN_BOND_2_MAX_SKEW must be less than or equal to the value of CHAN_BOND_1_MAX_SKEW for instance GTXE1."
          severity failure;
        end if;

        if (CLK_COR_MIN_LAT > CLK_COR_MAX_LAT) then
        assert false
          report "DRC Error : The value of CLK_COR_MIN_LAT must be less than or equal to the value of CLK_COR_MAX_LAT for instance GTXE1."
          severity failure;
        end if;

        if (SATA_MIN_BURST > SATA_MAX_BURST) then
        assert false
          report "DRC Error : The value of SATA_MIN_BURST must be less than or equal to the value of SATA_MAX_BURST for instance GTXE1."
          severity failure;
        end if;

        if (SATA_MIN_INIT > SATA_MAX_INIT) then
        assert false
          report "DRC Error : The value of SATA_MIN_INIT must be less than or equal to the value of SATA_MAX_INIT for instance GTXE1."
          severity failure;
        end if;

        
        if (SATA_MIN_WAKE > SATA_MAX_WAKE) then
        assert false
          report "DRC Error : The value of SATA_MIN_WAKE must be less than or equal to the value of SATA_MAX_WAKE for instance GTXE1."
          severity failure;
        end if;

        if (SAS_MIN_COMSAS > SAS_MAX_COMSAS) then
        assert false
          report "DRC Error : The value of SAS_MIN_COMSAS must be less than or equal to the value of SAS_MAX_COMSAS for instance GTXE1."
          severity failure;
        end if;

        if (RX_DATA_WIDTH = 16 and GEN_RXUSRCLK = FALSE) or (RX_DATA_WIDTH = 20 and GEN_RXUSRCLK = FALSE) then
        assert false
          report "DRC Error : If RX_DATA_WIDTH is set to 8 or 10 (and channel bonding is not used) or if RX_DATA_WIDTH is set to 16 or 20 then set GEN_RXUSRCLK to TRUE for instance GTXE1."
          severity failure;
        end if;

        if (RX_DATA_WIDTH = 32 and GEN_RXUSRCLK = TRUE) or (RX_DATA_WIDTH = 40 and GEN_RXUSRCLK = TRUE) then
        assert false
          report "DRC Error : If RX_DATA_WIDTH is set 32 or 40 then set GEN_RXUSRCLK to FALSE for instance GTXE1."
          severity failure;
        end if;

        if (TX_DATA_WIDTH = 16 and GEN_TXUSRCLK = FALSE) or (TX_DATA_WIDTH = 20 and GEN_TXUSRCLK = FALSE) then
        assert false
          report "DRC Error : If TX_DATA_WIDTH is set to 8 or 10 (and channel bonding is not used) or if TX_DATA_WIDTH is set to 16 or 20 then set GEN_TXUSRCLK to TRUE for instance GTXE1."
          severity failure;
        end if;

        if (TX_DATA_WIDTH = 32 and GEN_TXUSRCLK = TRUE) or (TX_DATA_WIDTH = 40 and GEN_TXUSRCLK = TRUE) then
        assert false
          report "DRC Error : If TX_DATA_WIDTH is set 32 or 40 then set GEN_TXUSRCLK to FALSE for instance GTXE1."
          severity failure;
        end if;

        if (CLK_CORRECT_USE = TRUE) and (RX_FIFO_ADDR_MODE = "FAST") then
        assert false
          report "DRC Error : If CLK_CORRECT_USE is set to TRUE then set RX_FIFO_ADDR_MODE to FULL for instance GTXE1."
          severity failure;
        end if;

        if ((RX_SLIDE_MODE = "PMA") and (SHOW_REALIGN_COMMA = TRUE)) or ((RX_SLIDE_MODE = "AUTO") and (SHOW_REALIGN_COMMA = TRUE)) then
        assert false
          report "DRC Error : If RX_SLIDE_MODE is set to PMA or AUTO then set SHOW_REALIGN_COMMA to FALSE for instance GTXE1."
          severity failure;
        end if;
          
      -- End DRC Checks

      -- case RXRECCLK_CTRL is
      if((RXRECCLK_CTRL = "RXRECCLKPCS") or (RXRECCLK_CTRL = "rxrecclkpcs")) then
        RXRECCLK_CTRL_BINARY <= "000";
      elsif((RXRECCLK_CTRL = "RXPLLREFCLK_DIV1") or (RXRECCLK_CTRL= "rxpllrefclk_div1")) then
        RXRECCLK_CTRL_BINARY <= "011";
      elsif((RXRECCLK_CTRL = "RXPLLREFCLK_DIV2") or (RXRECCLK_CTRL= "rxpllrefclk_div2")) then
        RXRECCLK_CTRL_BINARY <= "100";
      elsif((RXRECCLK_CTRL = "RXRECCLKPMA_DIV1") or (RXRECCLK_CTRL= "rxrecclkpma_div1")) then
        RXRECCLK_CTRL_BINARY <= "001";
      elsif((RXRECCLK_CTRL = "RXRECCLKPMA_DIV2") or (RXRECCLK_CTRL= "rxrecclkpma_div2")) then
        RXRECCLK_CTRL_BINARY <= "010";
      elsif((RXRECCLK_CTRL = "CLKTESTSIG1") or (RXRECCLK_CTRL= "clktestsig1")) then
        RXRECCLK_CTRL_BINARY <= "111";
      else
        assert FALSE report "Error : RXRECCLK_CTRL = is not RXRECCLKPCS, RXPLLREFCLK_DIV1, RXPLLREFCLK_DIV2, RXRECCLKPMA_DIV1, RXRECCLKPMA_DIV2, CLKTESTSIG1." severity error;
      end if;
    -- end case;
    -- case RX_FIFO_ADDR_MODE is
      if((RX_FIFO_ADDR_MODE = "FULL") or (RX_FIFO_ADDR_MODE = "full")) then
        RX_FIFO_ADDR_MODE_BINARY <= '0';
      elsif((RX_FIFO_ADDR_MODE = "FAST") or (RX_FIFO_ADDR_MODE= "fast")) then
        RX_FIFO_ADDR_MODE_BINARY <= '1';
      else
        assert FALSE report "Error : RX_FIFO_ADDR_MODE = is not FULL, FAST." severity error;
      end if;
    -- end case;
    -- case RX_SLIDE_MODE is
      if((RX_SLIDE_MODE = "OFF") or (RX_SLIDE_MODE = "off")) then
        RX_SLIDE_MODE_BINARY <= "00";
      elsif((RX_SLIDE_MODE = "AUTO") or (RX_SLIDE_MODE= "auto")) then
        RX_SLIDE_MODE_BINARY <= "01";
      elsif((RX_SLIDE_MODE = "PCS") or (RX_SLIDE_MODE= "pcs")) then
        RX_SLIDE_MODE_BINARY <= "10";
      elsif((RX_SLIDE_MODE = "PMA") or (RX_SLIDE_MODE= "pma")) then
        RX_SLIDE_MODE_BINARY <= "11";
      else
        assert FALSE report "Error : RX_SLIDE_MODE = is not OFF, AUTO, PCS, PMA." severity error;
      end if;
    -- end case;
    -- case RX_XCLK_SEL is
      if((RX_XCLK_SEL = "RXREC") or (RX_XCLK_SEL = "rxrec")) then
        RX_XCLK_SEL_BINARY <= '0';
      elsif((RX_XCLK_SEL = "RXUSR") or (RX_XCLK_SEL= "rxusr")) then
        RX_XCLK_SEL_BINARY <= '1';
      else
        assert FALSE report "Error : RX_XCLK_SEL = is not RXREC, RXUSR." severity error;
      end if;
    -- end case;
    -- case TXOUTCLK_CTRL is
      if((TXOUTCLK_CTRL = "TXOUTCLKPCS") or (TXOUTCLK_CTRL = "txoutclkpcs")) then
        TXOUTCLK_CTRL_BINARY <= "000";
      elsif((TXOUTCLK_CTRL = "TXOUTCLKPMA_DIV1") or (TXOUTCLK_CTRL= "txoutclkpma_div1")) then
        TXOUTCLK_CTRL_BINARY <= "001";
      elsif((TXOUTCLK_CTRL = "TXOUTCLKPMA_DIV2") or (TXOUTCLK_CTRL= "txoutclkpma_div2")) then
        TXOUTCLK_CTRL_BINARY <= "010";
      elsif((TXOUTCLK_CTRL = "TXPLLREFCLK_DIV1") or (TXOUTCLK_CTRL= "txpllrefclk_div1")) then
        TXOUTCLK_CTRL_BINARY <= "011";
      elsif((TXOUTCLK_CTRL = "TXPLLREFCLK_DIV2") or (TXOUTCLK_CTRL= "txpllrefclk_div2")) then
        TXOUTCLK_CTRL_BINARY <= "100";
      elsif((TXOUTCLK_CTRL = "CLKTESTSIG0") or (TXOUTCLK_CTRL= "clktestsig0")) then
        TXOUTCLK_CTRL_BINARY <= "111";
      else
        assert FALSE report "Error : TXOUTCLK_CTRL = is not TXOUTCLKPCS, TXOUTCLKPMA_DIV1, TXOUTCLKPMA_DIV2, TXPLLREFCLK_DIV1, TXPLLREFCLK_DIV2, CLKTESTSIG0." severity error;
      end if;
    -- end case;
    -- case TX_CLK_SOURCE is
      if((TX_CLK_SOURCE = "RXPLL") or (TX_CLK_SOURCE = "rxpll")) then
        TX_CLK_SOURCE_BINARY <= '1';
      elsif((TX_CLK_SOURCE = "TXPLL") or (TX_CLK_SOURCE= "txpll")) then
        TX_CLK_SOURCE_BINARY <= '0';
      else
        assert FALSE report "Error : TX_CLK_SOURCE = is not RXPLL, TXPLL." severity error;
      end if;
    -- end case;
    -- case TX_DRIVE_MODE is
      if((TX_DRIVE_MODE = "DIRECT") or (TX_DRIVE_MODE = "direct")) then
        TX_DRIVE_MODE_BINARY <= '0';
      elsif((TX_DRIVE_MODE = "PIPE") or (TX_DRIVE_MODE= "pipe")) then
        TX_DRIVE_MODE_BINARY <= '1';
      else
        assert FALSE report "Error : TX_DRIVE_MODE = is not DIRECT, PIPE." severity error;
      end if;
    -- end case;
    -- case TX_XCLK_SEL is
      if((TX_XCLK_SEL = "TXUSR") or (TX_XCLK_SEL = "txusr")) then
        TX_XCLK_SEL_BINARY <= '1';
      elsif((TX_XCLK_SEL = "TXOUT") or (TX_XCLK_SEL= "txout")) then
        TX_XCLK_SEL_BINARY <= '0';
      else
        assert FALSE report "Error : TX_XCLK_SEL = is not TXUSR, TXOUT." severity error;
      end if;
    -- end case;
    case AC_CAP_DIS is
      when FALSE   =>  AC_CAP_DIS_BINARY <= '0';
      when TRUE    =>  AC_CAP_DIS_BINARY <= '1';
      when others  =>  assert FALSE report "Error : AC_CAP_DIS is neither TRUE nor FALSE." severity error;
    end case;
    case ALIGN_COMMA_WORD is
      when  1   =>  ALIGN_COMMA_WORD_BINARY <= '0';
      when  2   =>  ALIGN_COMMA_WORD_BINARY <= '1';
      when others  =>  assert FALSE report "Error : ALIGN_COMMA_WORD is not in range 1 .. 2." severity error;
    end case;
    case CHAN_BOND_KEEP_ALIGN is
      when FALSE   =>  CHAN_BOND_KEEP_ALIGN_BINARY <= '0';
      when TRUE    =>  CHAN_BOND_KEEP_ALIGN_BINARY <= '1';
      when others  =>  assert FALSE report "Error : CHAN_BOND_KEEP_ALIGN is neither TRUE nor FALSE." severity error;
    end case;
    case CHAN_BOND_SEQ_2_USE is
      when FALSE   =>  CHAN_BOND_SEQ_2_USE_BINARY <= '0';
      when TRUE    =>  CHAN_BOND_SEQ_2_USE_BINARY <= '1';
      when others  =>  assert FALSE report "Error : CHAN_BOND_SEQ_2_USE is neither TRUE nor FALSE." severity error;
    end case;
    case CLK_CORRECT_USE is
      when FALSE   =>  CLK_CORRECT_USE_BINARY <= '0';
      when TRUE    =>  CLK_CORRECT_USE_BINARY <= '1';
      when others  =>  assert FALSE report "Error : CLK_CORRECT_USE is neither TRUE nor FALSE." severity error;
    end case;
    case CLK_COR_INSERT_IDLE_FLAG is
      when FALSE   =>  CLK_COR_INSERT_IDLE_FLAG_BINARY <= '0';
      when TRUE    =>  CLK_COR_INSERT_IDLE_FLAG_BINARY <= '1';
      when others  =>  assert FALSE report "Error : CLK_COR_INSERT_IDLE_FLAG is neither TRUE nor FALSE." severity error;
    end case;
    case CLK_COR_KEEP_IDLE is
      when FALSE   =>  CLK_COR_KEEP_IDLE_BINARY <= '0';
      when TRUE    =>  CLK_COR_KEEP_IDLE_BINARY <= '1';
      when others  =>  assert FALSE report "Error : CLK_COR_KEEP_IDLE is neither TRUE nor FALSE." severity error;
    end case;
    case CLK_COR_PRECEDENCE is
      when FALSE   =>  CLK_COR_PRECEDENCE_BINARY <= '0';
      when TRUE    =>  CLK_COR_PRECEDENCE_BINARY <= '1';
      when others  =>  assert FALSE report "Error : CLK_COR_PRECEDENCE is neither TRUE nor FALSE." severity error;
    end case;
    case CLK_COR_SEQ_2_USE is
      when FALSE   =>  CLK_COR_SEQ_2_USE_BINARY <= '0';
      when TRUE    =>  CLK_COR_SEQ_2_USE_BINARY <= '1';
      when others  =>  assert FALSE report "Error : CLK_COR_SEQ_2_USE is neither TRUE nor FALSE." severity error;
    end case;
    case COMMA_DOUBLE is
      when FALSE   =>  COMMA_DOUBLE_BINARY <= '0';
      when TRUE    =>  COMMA_DOUBLE_BINARY <= '1';
      when others  =>  assert FALSE report "Error : COMMA_DOUBLE is neither TRUE nor FALSE." severity error;
    end case;
    case DEC_MCOMMA_DETECT is
      when FALSE   =>  DEC_MCOMMA_DETECT_BINARY <= '0';
      when TRUE    =>  DEC_MCOMMA_DETECT_BINARY <= '1';
      when others  =>  assert FALSE report "Error : DEC_MCOMMA_DETECT is neither TRUE nor FALSE." severity error;
    end case;
    case DEC_PCOMMA_DETECT is
      when FALSE   =>  DEC_PCOMMA_DETECT_BINARY <= '0';
      when TRUE    =>  DEC_PCOMMA_DETECT_BINARY <= '1';
      when others  =>  assert FALSE report "Error : DEC_PCOMMA_DETECT is neither TRUE nor FALSE." severity error;
    end case;
    case DEC_VALID_COMMA_ONLY is
      when FALSE   =>  DEC_VALID_COMMA_ONLY_BINARY <= '0';
      when TRUE    =>  DEC_VALID_COMMA_ONLY_BINARY <= '1';
      when others  =>  assert FALSE report "Error : DEC_VALID_COMMA_ONLY is neither TRUE nor FALSE." severity error;
    end case;
    case GEN_RXUSRCLK is
      when FALSE   =>  GEN_RXUSRCLK_BINARY <= '0';
      when TRUE    =>  GEN_RXUSRCLK_BINARY <= '1';
      when others  =>  assert FALSE report "Error : GEN_RXUSRCLK is neither TRUE nor FALSE." severity error;
    end case;
    case GEN_TXUSRCLK is
      when FALSE   =>  GEN_TXUSRCLK_BINARY <= '0';
      when TRUE    =>  GEN_TXUSRCLK_BINARY <= '1';
      when others  =>  assert FALSE report "Error : GEN_TXUSRCLK is neither TRUE nor FALSE." severity error;
    end case;
    case GTX_CFG_PWRUP is
      when FALSE   =>  GTX_CFG_PWRUP_BINARY <= '0';
      when TRUE    =>  GTX_CFG_PWRUP_BINARY <= '1';
      when others  =>  assert FALSE report "Error : GTX_CFG_PWRUP is neither TRUE nor FALSE." severity error;
    end case;
    case MCOMMA_DETECT is
      when FALSE   =>  MCOMMA_DETECT_BINARY <= '0';
      when TRUE    =>  MCOMMA_DETECT_BINARY <= '1';
      when others  =>  assert FALSE report "Error : MCOMMA_DETECT is neither TRUE nor FALSE." severity error;
    end case;
    case PCI_EXPRESS_MODE is
      when FALSE   =>  PCI_EXPRESS_MODE_BINARY <= '0';
      when TRUE    =>  PCI_EXPRESS_MODE_BINARY <= '1';
      when others  =>  assert FALSE report "Error : PCI_EXPRESS_MODE is neither TRUE nor FALSE." severity error;
    end case;
    case PCOMMA_DETECT is
      when FALSE   =>  PCOMMA_DETECT_BINARY <= '0';
      when TRUE    =>  PCOMMA_DETECT_BINARY <= '1';
      when others  =>  assert FALSE report "Error : PCOMMA_DETECT is neither TRUE nor FALSE." severity error;
    end case;
    case PMA_CAS_CLK_EN is
      when FALSE   =>  PMA_CAS_CLK_EN_BINARY <= '0';
      when TRUE    =>  PMA_CAS_CLK_EN_BINARY <= '1';
      when others  =>  assert FALSE report "Error : PMA_CAS_CLK_EN is neither TRUE nor FALSE." severity error;
    end case;
    case RCV_TERM_GND is
      when FALSE   =>  RCV_TERM_GND_BINARY <= '0';
      when TRUE    =>  RCV_TERM_GND_BINARY <= '1';
      when others  =>  assert FALSE report "Error : RCV_TERM_GND is neither TRUE nor FALSE." severity error;
    end case;
    case RCV_TERM_VTTRX is
      when FALSE   =>  RCV_TERM_VTTRX_BINARY <= '0';
      when TRUE    =>  RCV_TERM_VTTRX_BINARY <= '1';
      when others  =>  assert FALSE report "Error : RCV_TERM_VTTRX is neither TRUE nor FALSE." severity error;
    end case;
    case RXGEARBOX_USE is
      when FALSE   =>  RXGEARBOX_USE_BINARY <= '0';
      when TRUE    =>  RXGEARBOX_USE_BINARY <= '1';
      when others  =>  assert FALSE report "Error : RXGEARBOX_USE is neither TRUE nor FALSE." severity error;
    end case;
    case RXPLL_DIVSEL45_FB is
      when  5   =>  RXPLL_DIVSEL45_FB_BINARY <= '1';
      when  4   =>  RXPLL_DIVSEL45_FB_BINARY <= '0';
      when others  =>  assert FALSE report "Error : RXPLL_DIVSEL45_FB is not in range 5 .. 4." severity error;
    end case;
    case RX_BUFFER_USE is
      when FALSE   =>  RX_BUFFER_USE_BINARY <= '0';
      when TRUE    =>  RX_BUFFER_USE_BINARY <= '1';
      when others  =>  assert FALSE report "Error : RX_BUFFER_USE is neither TRUE nor FALSE." severity error;
    end case;
    case RX_DECODE_SEQ_MATCH is
      when FALSE   =>  RX_DECODE_SEQ_MATCH_BINARY <= '0';
      when TRUE    =>  RX_DECODE_SEQ_MATCH_BINARY <= '1';
      when others  =>  assert FALSE report "Error : RX_DECODE_SEQ_MATCH is neither TRUE nor FALSE." severity error;
    end case;
    case RX_EN_IDLE_HOLD_CDR is
      when FALSE   =>  RX_EN_IDLE_HOLD_CDR_BINARY <= '0';
      when TRUE    =>  RX_EN_IDLE_HOLD_CDR_BINARY <= '1';
      when others  =>  assert FALSE report "Error : RX_EN_IDLE_HOLD_CDR is neither TRUE nor FALSE." severity error;
    end case;
    case RX_EN_IDLE_HOLD_DFE is
      when FALSE   =>  RX_EN_IDLE_HOLD_DFE_BINARY <= '0';
      when TRUE    =>  RX_EN_IDLE_HOLD_DFE_BINARY <= '1';
      when others  =>  assert FALSE report "Error : RX_EN_IDLE_HOLD_DFE is neither TRUE nor FALSE." severity error;
    end case;
    case RX_EN_IDLE_RESET_BUF is
      when FALSE   =>  RX_EN_IDLE_RESET_BUF_BINARY <= '0';
      when TRUE    =>  RX_EN_IDLE_RESET_BUF_BINARY <= '1';
      when others  =>  assert FALSE report "Error : RX_EN_IDLE_RESET_BUF is neither TRUE nor FALSE." severity error;
    end case;
    case RX_EN_IDLE_RESET_FR is
      when FALSE   =>  RX_EN_IDLE_RESET_FR_BINARY <= '0';
      when TRUE    =>  RX_EN_IDLE_RESET_FR_BINARY <= '1';
      when others  =>  assert FALSE report "Error : RX_EN_IDLE_RESET_FR is neither TRUE nor FALSE." severity error;
    end case;
    case RX_EN_IDLE_RESET_PH is
      when FALSE   =>  RX_EN_IDLE_RESET_PH_BINARY <= '0';
      when TRUE    =>  RX_EN_IDLE_RESET_PH_BINARY <= '1';
      when others  =>  assert FALSE report "Error : RX_EN_IDLE_RESET_PH is neither TRUE nor FALSE." severity error;
    end case;
    case RX_EN_MODE_RESET_BUF is
      when FALSE   =>  RX_EN_MODE_RESET_BUF_BINARY <= '0';
      when TRUE    =>  RX_EN_MODE_RESET_BUF_BINARY <= '1';
      when others  =>  assert FALSE report "Error : RX_EN_MODE_RESET_BUF is neither TRUE nor FALSE." severity error;
    end case;
    case RX_EN_RATE_RESET_BUF is
      when FALSE   =>  RX_EN_RATE_RESET_BUF_BINARY <= '0';
      when TRUE    =>  RX_EN_RATE_RESET_BUF_BINARY <= '1';
      when others  =>  assert FALSE report "Error : RX_EN_RATE_RESET_BUF is neither TRUE nor FALSE." severity error;
    end case;
    case RX_EN_REALIGN_RESET_BUF is
      when FALSE   =>  RX_EN_REALIGN_RESET_BUF_BINARY <= '0';
      when TRUE    =>  RX_EN_REALIGN_RESET_BUF_BINARY <= '1';
      when others  =>  assert FALSE report "Error : RX_EN_REALIGN_RESET_BUF is neither TRUE nor FALSE." severity error;
    end case;
    case RX_EN_REALIGN_RESET_BUF2 is
      when FALSE   =>  RX_EN_REALIGN_RESET_BUF2_BINARY <= '0';
      when TRUE    =>  RX_EN_REALIGN_RESET_BUF2_BINARY <= '1';
      when others  =>  assert FALSE report "Error : RX_EN_REALIGN_RESET_BUF2 is neither TRUE nor FALSE." severity error;
    end case;
    case RX_LOSS_OF_SYNC_FSM is
      when FALSE   =>  RX_LOSS_OF_SYNC_FSM_BINARY <= '0';
      when TRUE    =>  RX_LOSS_OF_SYNC_FSM_BINARY <= '1';
      when others  =>  assert FALSE report "Error : RX_LOSS_OF_SYNC_FSM is neither TRUE nor FALSE." severity error;
    end case;
    case RX_OVERSAMPLE_MODE is
      when FALSE   =>  RX_OVERSAMPLE_MODE_BINARY <= '0';
      when TRUE    =>  RX_OVERSAMPLE_MODE_BINARY <= '1';
      when others  =>  assert FALSE report "Error : RX_OVERSAMPLE_MODE is neither TRUE nor FALSE." severity error;
    end case;
    case SHOW_REALIGN_COMMA is
      when FALSE   =>  SHOW_REALIGN_COMMA_BINARY <= '0';
      when TRUE    =>  SHOW_REALIGN_COMMA_BINARY <= '1';
      when others  =>  assert FALSE report "Error : SHOW_REALIGN_COMMA is neither TRUE nor FALSE." severity error;
    end case;
    case SIM_GTXRESET_SPEEDUP is
      when  1   =>  SIM_GTXRESET_SPEEDUP_BINARY <= '1';
      when  0   =>  SIM_GTXRESET_SPEEDUP_BINARY <= '0';
      when others  =>  assert FALSE report "Error : SIM_GTXRESET_SPEEDUP is not in range 0 .. 1." severity error;
    end case;
    case SIM_RECEIVER_DETECT_PASS is
      when FALSE   =>  SIM_RECEIVER_DETECT_PASS_BINARY <= '0';
      when TRUE    =>  SIM_RECEIVER_DETECT_PASS_BINARY <= '1';
      when others  =>  assert FALSE report "Error : SIM_RECEIVER_DETECT_PASS is neither TRUE nor FALSE." severity error;
    end case; 
    case TERMINATION_OVRD is
      when FALSE   =>  TERMINATION_OVRD_BINARY <= '0';
      when TRUE    =>  TERMINATION_OVRD_BINARY <= '1';
      when others  =>  assert FALSE report "Error : TERMINATION_OVRD is neither TRUE nor FALSE." severity error;
    end case;
    case TXDRIVE_LOOPBACK_HIZ is
      when FALSE   =>  TXDRIVE_LOOPBACK_HIZ_BINARY <= '0';
      when TRUE    =>  TXDRIVE_LOOPBACK_HIZ_BINARY <= '1';
      when others  =>  assert FALSE report "Error : TXDRIVE_LOOPBACK_HIZ is neither TRUE nor FALSE." severity error;
    end case;
    case TXDRIVE_LOOPBACK_PD is
      when FALSE   =>  TXDRIVE_LOOPBACK_PD_BINARY <= '0';
      when TRUE    =>  TXDRIVE_LOOPBACK_PD_BINARY <= '1';
      when others  =>  assert FALSE report "Error : TXDRIVE_LOOPBACK_PD is neither TRUE nor FALSE." severity error;
    end case;
    case TXGEARBOX_USE is
      when FALSE   =>  TXGEARBOX_USE_BINARY <= '0';
      when TRUE    =>  TXGEARBOX_USE_BINARY <= '1';
      when others  =>  assert FALSE report "Error : TXGEARBOX_USE is neither TRUE nor FALSE." severity error;
    end case;
    case TXPLL_DIVSEL45_FB is
      when  5   =>  TXPLL_DIVSEL45_FB_BINARY <= '1';
      when  4   =>  TXPLL_DIVSEL45_FB_BINARY <= '0';
      when others  =>  assert FALSE report "Error : TXPLL_DIVSEL45_FB is not in range 5 .. 4." severity error;
    end case;
    case TX_BUFFER_USE is
      when FALSE   =>  TX_BUFFER_USE_BINARY <= '0';
      when TRUE    =>  TX_BUFFER_USE_BINARY <= '1';
      when others  =>  assert FALSE report "Error : TX_BUFFER_USE is neither TRUE nor FALSE." severity error;
    end case;
    case TX_EN_RATE_RESET_BUF is
      when FALSE   =>  TX_EN_RATE_RESET_BUF_BINARY <= '0';
      when TRUE    =>  TX_EN_RATE_RESET_BUF_BINARY <= '1';
      when others  =>  assert FALSE report "Error : TX_EN_RATE_RESET_BUF is neither TRUE nor FALSE." severity error;
    end case;
    case TX_OVERSAMPLE_MODE is
      when FALSE   =>  TX_OVERSAMPLE_MODE_BINARY <= '0';
      when TRUE    =>  TX_OVERSAMPLE_MODE_BINARY <= '1';
      when others  =>  assert FALSE report "Error : TX_OVERSAMPLE_MODE is neither TRUE nor FALSE." severity error;
    end case;
    if ((CHAN_BOND_1_MAX_SKEW >= 1) and (CHAN_BOND_1_MAX_SKEW <= 14)) then
      CHAN_BOND_1_MAX_SKEW_BINARY <= CONV_STD_LOGIC_VECTOR(CHAN_BOND_1_MAX_SKEW, 4);
    else
      assert FALSE report "Error : CHAN_BOND_1_MAX_SKEW is not in range 1 .. 14." severity error;
    end if;
    if ((CHAN_BOND_2_MAX_SKEW >= 1) and (CHAN_BOND_2_MAX_SKEW <= 14)) then
      CHAN_BOND_2_MAX_SKEW_BINARY <= CONV_STD_LOGIC_VECTOR(CHAN_BOND_2_MAX_SKEW, 4);
    else
      assert FALSE report "Error : CHAN_BOND_2_MAX_SKEW is not in range 1 .. 14." severity error;
    end if;
    if ((CHAN_BOND_SEQ_LEN >= 1) and (CHAN_BOND_SEQ_LEN <= 4)) then
      CHAN_BOND_SEQ_LEN_BINARY <= CONV_STD_LOGIC_VECTOR(CHAN_BOND_SEQ_LEN, 2);
    else
      assert FALSE report "Error : CHAN_BOND_SEQ_LEN is not in range 1 .. 4." severity error;
    end if;
    if ((CLK_COR_ADJ_LEN >= 1) and (CLK_COR_ADJ_LEN <= 4)) then
      CLK_COR_ADJ_LEN_BINARY <= CONV_STD_LOGIC_VECTOR(CLK_COR_ADJ_LEN, 2);
    else
      assert FALSE report "Error : CLK_COR_ADJ_LEN is not in range 1 .. 4." severity error;
    end if;
    if ((CLK_COR_DET_LEN >= 1) and (CLK_COR_DET_LEN <= 4)) then
      CLK_COR_DET_LEN_BINARY <= CONV_STD_LOGIC_VECTOR(CLK_COR_DET_LEN, 2);
    else
      assert FALSE report "Error : CLK_COR_DET_LEN is not in range 1 .. 4." severity error;
    end if;
    if ((CLK_COR_MAX_LAT >= 3) and (CLK_COR_MAX_LAT <= 48)) then
      CLK_COR_MAX_LAT_BINARY <= CONV_STD_LOGIC_VECTOR(CLK_COR_MAX_LAT, 6);
    else
      assert FALSE report "Error : CLK_COR_MAX_LAT is not in range 3 .. 48." severity error;
    end if;
    if ((CLK_COR_MIN_LAT >= 3) and (CLK_COR_MIN_LAT <= 48)) then
      CLK_COR_MIN_LAT_BINARY <= CONV_STD_LOGIC_VECTOR(CLK_COR_MIN_LAT, 6);
    else
      assert FALSE report "Error : CLK_COR_MIN_LAT is not in range 3 .. 48." severity error;
    end if;
    if ((CLK_COR_REPEAT_WAIT >= 0) and (CLK_COR_REPEAT_WAIT <= 31)) then
      CLK_COR_REPEAT_WAIT_BINARY <= CONV_STD_LOGIC_VECTOR(CLK_COR_REPEAT_WAIT, 5);
    else
      assert FALSE report "Error : CLK_COR_REPEAT_WAIT is not in range 0 .. 31." severity error;
    end if;
    if ((RXPLL_DIVSEL_FB >= 1) and (RXPLL_DIVSEL_FB <= 20)) then
      RXPLL_DIVSEL_FB_BINARY <= CONV_STD_LOGIC_VECTOR(RXPLL_DIVSEL_FB, 5);
    else
      assert FALSE report "Error : RXPLL_DIVSEL_FB is not in range 1 .. 20." severity error;
    end if;
    if ((RXPLL_DIVSEL_OUT >= 1) and (RXPLL_DIVSEL_OUT <= 4)) then
      RXPLL_DIVSEL_OUT_BINARY <= CONV_STD_LOGIC_VECTOR(RXPLL_DIVSEL_OUT, 2);
    else
      assert FALSE report "Error : RXPLL_DIVSEL_OUT is not in range 1 .. 4." severity error;
    end if;
    if ((RXPLL_DIVSEL_REF >= 1) and (RXPLL_DIVSEL_REF <= 20)) then
      RXPLL_DIVSEL_REF_BINARY <= CONV_STD_LOGIC_VECTOR(RXPLL_DIVSEL_REF, 5);
    else
      assert FALSE report "Error : RXPLL_DIVSEL_REF is not in range 1 .. 20." severity error;
    end if;
    if ((RX_CLK25_DIVIDER >= 1) and (RX_CLK25_DIVIDER <= 32)) then
      RX_CLK25_DIVIDER_BINARY <= CONV_STD_LOGIC_VECTOR(RX_CLK25_DIVIDER, 5);
    else
      assert FALSE report "Error : RX_CLK25_DIVIDER is not in range 1 .. 32." severity error;
    end if;
    if ((RX_DATA_WIDTH >= 8) and (RX_DATA_WIDTH <= 40)) then
      RX_DATA_WIDTH_BINARY <= CONV_STD_LOGIC_VECTOR(RX_DATA_WIDTH, 3);
    else
      assert FALSE report "Error : RX_DATA_WIDTH is not in range 8 .. 40." severity error;
    end if;
    if ((RX_LOS_INVALID_INCR >= 1) and (RX_LOS_INVALID_INCR <= 128)) then
      RX_LOS_INVALID_INCR_BINARY <= CONV_STD_LOGIC_VECTOR(RX_LOS_INVALID_INCR, 3);
    else
      assert FALSE report "Error : RX_LOS_INVALID_INCR is not in range 1 .. 128." severity error;
    end if;
    if ((RX_LOS_THRESHOLD >= 4) and (RX_LOS_THRESHOLD <= 512)) then
      RX_LOS_THRESHOLD_BINARY <= CONV_STD_LOGIC_VECTOR(RX_LOS_THRESHOLD, 3);
    else
      assert FALSE report "Error : RX_LOS_THRESHOLD is not in range 4 .. 512." severity error;
    end if;
    if ((RX_SLIDE_AUTO_WAIT >= 0) and (RX_SLIDE_AUTO_WAIT <= 15)) then
      RX_SLIDE_AUTO_WAIT_BINARY <= CONV_STD_LOGIC_VECTOR(RX_SLIDE_AUTO_WAIT, 4);
    else
      assert FALSE report "Error : RX_SLIDE_AUTO_WAIT is not in range 0 .. 15." severity error;
    end if;
    if ((SAS_MAX_COMSAS >= 1) and (SAS_MAX_COMSAS <= 61)) then
      SAS_MAX_COMSAS_BINARY <= CONV_STD_LOGIC_VECTOR(SAS_MAX_COMSAS, 6);
    else
      assert FALSE report "Error : SAS_MAX_COMSAS is not in range 1 .. 61." severity error;
    end if;
    if ((SAS_MIN_COMSAS >= 1) and (SAS_MIN_COMSAS <= 61)) then
      SAS_MIN_COMSAS_BINARY <= CONV_STD_LOGIC_VECTOR(SAS_MIN_COMSAS, 6);
    else
      assert FALSE report "Error : SAS_MIN_COMSAS is not in range 1 .. 61." severity error;
    end if;
    if ((SATA_MAX_BURST >= 1) and (SATA_MAX_BURST <= 61)) then
      SATA_MAX_BURST_BINARY <= CONV_STD_LOGIC_VECTOR(SATA_MAX_BURST, 6);
    else
      assert FALSE report "Error : SATA_MAX_BURST is not in range 1 .. 61." severity error;
    end if;
    if ((SATA_MAX_INIT >= 1) and (SATA_MAX_INIT <= 61)) then
      SATA_MAX_INIT_BINARY <= CONV_STD_LOGIC_VECTOR(SATA_MAX_INIT, 6);
    else
      assert FALSE report "Error : SATA_MAX_INIT is not in range 1 .. 61." severity error;
    end if;
    if ((SATA_MAX_WAKE >= 1) and (SATA_MAX_WAKE <= 61)) then
      SATA_MAX_WAKE_BINARY <= CONV_STD_LOGIC_VECTOR(SATA_MAX_WAKE, 6);
    else
      assert FALSE report "Error : SATA_MAX_WAKE is not in range 1 .. 61." severity error;
    end if;
    if ((SATA_MIN_BURST >= 1) and (SATA_MIN_BURST <= 61)) then
      SATA_MIN_BURST_BINARY <= CONV_STD_LOGIC_VECTOR(SATA_MIN_BURST, 6);
    else
      assert FALSE report "Error : SATA_MIN_BURST is not in range 1 .. 61." severity error;
    end if;
    if ((SATA_MIN_INIT >= 1) and (SATA_MIN_INIT <= 61)) then
      SATA_MIN_INIT_BINARY <= CONV_STD_LOGIC_VECTOR(SATA_MIN_INIT, 6);
    else
      assert FALSE report "Error : SATA_MIN_INIT is not in range 1 .. 61." severity error;
    end if;
    if ((SATA_MIN_WAKE >= 1) and (SATA_MIN_WAKE <= 61)) then
      SATA_MIN_WAKE_BINARY <= CONV_STD_LOGIC_VECTOR(SATA_MIN_WAKE, 6);
    else
      assert FALSE report "Error : SATA_MIN_WAKE is not in range 1 .. 61." severity error;
    end if;
    if ((TXPLL_DIVSEL_FB >= 1) and (TXPLL_DIVSEL_FB <= 20)) then
      TXPLL_DIVSEL_FB_BINARY <= CONV_STD_LOGIC_VECTOR(TXPLL_DIVSEL_FB, 5);
    else
      assert FALSE report "Error : TXPLL_DIVSEL_FB is not in range 1 .. 20." severity error;
    end if;
    if ((TXPLL_DIVSEL_OUT >= 1) and (TXPLL_DIVSEL_OUT <= 4)) then
      TXPLL_DIVSEL_OUT_BINARY <= CONV_STD_LOGIC_VECTOR(TXPLL_DIVSEL_OUT, 2);
    else
      assert FALSE report "Error : TXPLL_DIVSEL_OUT is not in range 1 .. 4." severity error;
    end if;
    if ((TXPLL_DIVSEL_REF >= 1) and (TXPLL_DIVSEL_REF <= 20)) then
      TXPLL_DIVSEL_REF_BINARY <= CONV_STD_LOGIC_VECTOR(TXPLL_DIVSEL_REF, 5);
    else
      assert FALSE report "Error : TXPLL_DIVSEL_REF is not in range 1 .. 20." severity error;
    end if;
    if ((TX_CLK25_DIVIDER >= 1) and (TX_CLK25_DIVIDER <= 32)) then
      TX_CLK25_DIVIDER_BINARY <= CONV_STD_LOGIC_VECTOR(TX_CLK25_DIVIDER, 5);
    else
      assert FALSE report "Error : TX_CLK25_DIVIDER is not in range 1 .. 32." severity error;
    end if;
    if ((TX_DATA_WIDTH >= 8) and (TX_DATA_WIDTH <= 40)) then
      TX_DATA_WIDTH_BINARY <= CONV_STD_LOGIC_VECTOR(TX_DATA_WIDTH, 3);
    else
      assert FALSE report "Error : TX_DATA_WIDTH is not in range 8 .. 40." severity error;
    end if;
    wait;
    end process INIPROC;

      TIMING : process
        variable Tmkr_DADDR_DCLK_posedge : VitalTimingDataArrayType(7 downto 0);
        variable Tmkr_DEN_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
        variable Tmkr_DFECLKDLYADJ_RXUSRCLK2_posedge : VitalTimingDataArrayType(5 downto 0);
        variable Tmkr_DFEDLYOVRD_RXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
        variable Tmkr_DFETAP1_RXUSRCLK2_posedge : VitalTimingDataArrayType(4 downto 0);
        variable Tmkr_DFETAP2_RXUSRCLK2_posedge : VitalTimingDataArrayType(4 downto 0);
        variable Tmkr_DFETAP3_RXUSRCLK2_posedge : VitalTimingDataArrayType(3 downto 0);
        variable Tmkr_DFETAP4_RXUSRCLK2_posedge : VitalTimingDataArrayType(3 downto 0);
        variable Tmkr_DFETAPOVRD_RXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
        variable Tmkr_DI_DCLK_posedge : VitalTimingDataArrayType(15 downto 0);
        variable Tmkr_DWE_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
        variable Tmkr_PRBSCNTRESET_RXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
        variable Tmkr_RXCHBONDI_RXUSRCLK2_posedge : VitalTimingDataArrayType(3 downto 0);
        variable Tmkr_RXCHBONDI_RXUSRCLK_posedge : VitalTimingDataArrayType(3 downto 0);
        variable Tmkr_RXCHBONDLEVEL_RXUSRCLK2_posedge : VitalTimingDataArrayType(2 downto 0);
        variable Tmkr_RXCHBONDMASTER_RXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
        variable Tmkr_RXCHBONDSLAVE_RXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
        variable Tmkr_RXCOMMADETUSE_RXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
        variable Tmkr_RXDEC8B10BUSE_RXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
        variable Tmkr_RXENCHANSYNC_RXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
        variable Tmkr_RXENMCOMMAALIGN_RXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
        variable Tmkr_RXENPCOMMAALIGN_RXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
        variable Tmkr_RXENPRBSTST_RXUSRCLK2_posedge : VitalTimingDataArrayType(2 downto 0);
        variable Tmkr_RXENSAMPLEALIGN_RXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
        variable Tmkr_RXGEARBOXSLIP_RXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
        variable Tmkr_RXPOLARITY_RXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
        variable Tmkr_RXRATE_RXUSRCLK2_posedge : VitalTimingDataArrayType(1 downto 0);
        variable Tmkr_RXSLIDE_RXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
        variable Tmkr_TXBYPASS8B10B_TXUSRCLK2_posedge : VitalTimingDataArrayType(3 downto 0);
        variable Tmkr_TXCHARDISPMODE_TXUSRCLK2_posedge : VitalTimingDataArrayType(3 downto 0);
        variable Tmkr_TXCHARDISPVAL_TXUSRCLK2_posedge : VitalTimingDataArrayType(3 downto 0);
        variable Tmkr_TXCHARISK_TXUSRCLK2_posedge : VitalTimingDataArrayType(3 downto 0);
        variable Tmkr_TXCOMINIT_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
        variable Tmkr_TXCOMSAS_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
        variable Tmkr_TXCOMWAKE_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
        variable Tmkr_TXDATA_TXUSRCLK2_posedge : VitalTimingDataArrayType(31 downto 0);
        variable Tmkr_TXDETECTRX_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
        variable Tmkr_TXELECIDLE_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
        variable Tmkr_TXENC8B10BUSE_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
        variable Tmkr_TXENPRBSTST_TXUSRCLK2_posedge : VitalTimingDataArrayType(2 downto 0);
        variable Tmkr_TXHEADER_TXUSRCLK2_posedge : VitalTimingDataArrayType(2 downto 0);
        variable Tmkr_TXINHIBIT_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
        variable Tmkr_TXPOLARITY_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
        variable Tmkr_TXPOWERDOWN_TXUSRCLK2_posedge : VitalTimingDataArrayType(1 downto 0);
        variable Tmkr_TXPRBSFORCEERR_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
        variable Tmkr_TXRATE_TXUSRCLK2_posedge : VitalTimingDataArrayType(1 downto 0);
        variable Tmkr_TXSEQUENCE_TXUSRCLK2_posedge : VitalTimingDataArrayType(6 downto 0);
        variable Tmkr_TXSTARTSEQ_TXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
        variable Tmkr_USRCODEERR_RXUSRCLK2_posedge : VitalTimingDataType := VitalTimingDataInit;
        variable Pviol_MGTREFCLKRX : std_logic_vector(1 downto 0) := (others => '0');
        variable Pviol_MGTREFCLKTX : std_logic_vector(1 downto 0) := (others => '0');
        variable Pviol_NORTHREFCLKRX : std_logic_vector(1 downto 0) := (others => '0');
        variable Pviol_NORTHREFCLKTX : std_logic_vector(1 downto 0) := (others => '0');
        variable Pviol_SOUTHREFCLKRX : std_logic_vector(1 downto 0) := (others => '0');
        variable Pviol_SOUTHREFCLKTX : std_logic_vector(1 downto 0) := (others => '0');
        variable Tviol_DADDR_DCLK_posedge : std_logic_vector(7 downto 0) := (others => '0');
        variable Tviol_DEN_DCLK_posedge :  std_ulogic := '0';
        variable Tviol_DFECLKDLYADJ_RXUSRCLK2_posedge : std_logic_vector(5 downto 0) := (others => '0');
        variable Tviol_DFEDLYOVRD_RXUSRCLK2_posedge :  std_ulogic := '0';
        variable Tviol_DFETAP1_RXUSRCLK2_posedge : std_logic_vector(4 downto 0) := (others => '0');
        variable Tviol_DFETAP2_RXUSRCLK2_posedge : std_logic_vector(4 downto 0) := (others => '0');
        variable Tviol_DFETAP3_RXUSRCLK2_posedge : std_logic_vector(3 downto 0) := (others => '0');
        variable Tviol_DFETAP4_RXUSRCLK2_posedge : std_logic_vector(3 downto 0) := (others => '0');
        variable Tviol_DFETAPOVRD_RXUSRCLK2_posedge :  std_ulogic := '0';
        variable Tviol_DI_DCLK_posedge : std_logic_vector(15 downto 0) := (others => '0');
        variable Tviol_DWE_DCLK_posedge :  std_ulogic := '0';
        variable Tviol_PRBSCNTRESET_RXUSRCLK2_posedge :  std_ulogic := '0';
        variable Tviol_RXCHBONDI_RXUSRCLK2_posedge : std_logic_vector(3 downto 0) := (others => '0');
        variable Tviol_RXCHBONDI_RXUSRCLK_posedge : std_logic_vector(3 downto 0) := (others => '0');
        variable Tviol_RXCHBONDLEVEL_RXUSRCLK2_posedge : std_logic_vector(2 downto 0) := (others => '0');
        variable Tviol_RXCHBONDMASTER_RXUSRCLK2_posedge :  std_ulogic := '0';
        variable Tviol_RXCHBONDSLAVE_RXUSRCLK2_posedge :  std_ulogic := '0';
        variable Tviol_RXCOMMADETUSE_RXUSRCLK2_posedge :  std_ulogic := '0';
        variable Tviol_RXDEC8B10BUSE_RXUSRCLK2_posedge :  std_ulogic := '0';
        variable Tviol_RXENCHANSYNC_RXUSRCLK2_posedge :  std_ulogic := '0';
        variable Tviol_RXENMCOMMAALIGN_RXUSRCLK2_posedge :  std_ulogic := '0';
        variable Tviol_RXENPCOMMAALIGN_RXUSRCLK2_posedge :  std_ulogic := '0';
        variable Tviol_RXENPRBSTST_RXUSRCLK2_posedge : std_logic_vector(2 downto 0) := (others => '0');
        variable Tviol_RXENSAMPLEALIGN_RXUSRCLK2_posedge :  std_ulogic := '0';
        variable Tviol_RXGEARBOXSLIP_RXUSRCLK2_posedge :  std_ulogic := '0';
        variable Tviol_RXPOLARITY_RXUSRCLK2_posedge :  std_ulogic := '0';
        variable Tviol_RXRATE_RXUSRCLK2_posedge : std_logic_vector(1 downto 0) := (others => '0');
        variable Tviol_RXSLIDE_RXUSRCLK2_posedge :  std_ulogic := '0';
        variable Tviol_TXBYPASS8B10B_TXUSRCLK2_posedge : std_logic_vector(3 downto 0) := (others => '0');
        variable Tviol_TXCHARDISPMODE_TXUSRCLK2_posedge : std_logic_vector(3 downto 0) := (others => '0');
        variable Tviol_TXCHARDISPVAL_TXUSRCLK2_posedge : std_logic_vector(3 downto 0) := (others => '0');
        variable Tviol_TXCHARISK_TXUSRCLK2_posedge : std_logic_vector(3 downto 0) := (others => '0');
        variable Tviol_TXCOMINIT_TXUSRCLK2_posedge :  std_ulogic := '0';
        variable Tviol_TXCOMSAS_TXUSRCLK2_posedge :  std_ulogic := '0';
        variable Tviol_TXCOMWAKE_TXUSRCLK2_posedge :  std_ulogic := '0';
        variable Tviol_TXDATA_TXUSRCLK2_posedge : std_logic_vector(31 downto 0) := (others => '0');
        variable Tviol_TXDETECTRX_TXUSRCLK2_posedge :  std_ulogic := '0';
        variable Tviol_TXELECIDLE_TXUSRCLK2_posedge :  std_ulogic := '0';
        variable Tviol_TXENC8B10BUSE_TXUSRCLK2_posedge :  std_ulogic := '0';
        variable Tviol_TXENPRBSTST_TXUSRCLK2_posedge : std_logic_vector(2 downto 0) := (others => '0');
        variable Tviol_TXHEADER_TXUSRCLK2_posedge : std_logic_vector(2 downto 0) := (others => '0');
        variable Tviol_TXINHIBIT_TXUSRCLK2_posedge :  std_ulogic := '0';
        variable Tviol_TXPOLARITY_TXUSRCLK2_posedge :  std_ulogic := '0';
        variable Tviol_TXPOWERDOWN_TXUSRCLK2_posedge : std_logic_vector(1 downto 0) := (others => '0');
        variable Tviol_TXPRBSFORCEERR_TXUSRCLK2_posedge :  std_ulogic := '0';
        variable Tviol_TXRATE_TXUSRCLK2_posedge : std_logic_vector(1 downto 0) := (others => '0');
        variable Tviol_TXSEQUENCE_TXUSRCLK2_posedge : std_logic_vector(6 downto 0) := (others => '0');
        variable Tviol_TXSTARTSEQ_TXUSRCLK2_posedge :  std_ulogic := '0';
        variable Tviol_USRCODEERR_RXUSRCLK2_posedge :  std_ulogic := '0';
        variable COMFINISH_GlitchData : VitalGlitchDataType;
        variable COMINITDET_GlitchData : VitalGlitchDataType;
        variable COMSASDET_GlitchData : VitalGlitchDataType;
        variable COMWAKEDET_GlitchData : VitalGlitchDataType;
        variable DFECLKDLYADJMON0_GlitchData : VitalGlitchDataType;
        variable DFECLKDLYADJMON1_GlitchData : VitalGlitchDataType;
        variable DFECLKDLYADJMON2_GlitchData : VitalGlitchDataType;
        variable DFECLKDLYADJMON3_GlitchData : VitalGlitchDataType;
        variable DFECLKDLYADJMON4_GlitchData : VitalGlitchDataType;
        variable DFECLKDLYADJMON5_GlitchData : VitalGlitchDataType;
        variable DFEEYEDACMON0_GlitchData : VitalGlitchDataType;
        variable DFEEYEDACMON1_GlitchData : VitalGlitchDataType;
        variable DFEEYEDACMON2_GlitchData : VitalGlitchDataType;
        variable DFEEYEDACMON3_GlitchData : VitalGlitchDataType;
        variable DFEEYEDACMON4_GlitchData : VitalGlitchDataType;
        variable DFESENSCAL0_GlitchData : VitalGlitchDataType;
        variable DFESENSCAL1_GlitchData : VitalGlitchDataType;
        variable DFESENSCAL2_GlitchData : VitalGlitchDataType;
        variable DFETAP1MONITOR0_GlitchData : VitalGlitchDataType;
        variable DFETAP1MONITOR1_GlitchData : VitalGlitchDataType;
        variable DFETAP1MONITOR2_GlitchData : VitalGlitchDataType;
        variable DFETAP1MONITOR3_GlitchData : VitalGlitchDataType;
        variable DFETAP1MONITOR4_GlitchData : VitalGlitchDataType;
        variable DFETAP2MONITOR0_GlitchData : VitalGlitchDataType;
        variable DFETAP2MONITOR1_GlitchData : VitalGlitchDataType;
        variable DFETAP2MONITOR2_GlitchData : VitalGlitchDataType;
        variable DFETAP2MONITOR3_GlitchData : VitalGlitchDataType;
        variable DFETAP2MONITOR4_GlitchData : VitalGlitchDataType;
        variable DFETAP3MONITOR0_GlitchData : VitalGlitchDataType;
        variable DFETAP3MONITOR1_GlitchData : VitalGlitchDataType;
        variable DFETAP3MONITOR2_GlitchData : VitalGlitchDataType;
        variable DFETAP3MONITOR3_GlitchData : VitalGlitchDataType;
        variable DFETAP4MONITOR0_GlitchData : VitalGlitchDataType;
        variable DFETAP4MONITOR1_GlitchData : VitalGlitchDataType;
        variable DFETAP4MONITOR2_GlitchData : VitalGlitchDataType;
        variable DFETAP4MONITOR3_GlitchData : VitalGlitchDataType;
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
        variable MGTREFCLKFAB0_GlitchData : VitalGlitchDataType;
        variable MGTREFCLKFAB1_GlitchData : VitalGlitchDataType;
        variable PHYSTATUS_GlitchData : VitalGlitchDataType;
        variable RXBUFSTATUS0_GlitchData : VitalGlitchDataType;
        variable RXBUFSTATUS1_GlitchData : VitalGlitchDataType;
        variable RXBUFSTATUS2_GlitchData : VitalGlitchDataType;
        variable RXBYTEISALIGNED_GlitchData : VitalGlitchDataType;
        variable RXBYTEREALIGN_GlitchData : VitalGlitchDataType;
        variable RXCHANBONDSEQ_GlitchData : VitalGlitchDataType;
        variable RXCHANISALIGNED_GlitchData : VitalGlitchDataType;
        variable RXCHANREALIGN_GlitchData : VitalGlitchDataType;
        variable RXCHARISCOMMA0_GlitchData : VitalGlitchDataType;
        variable RXCHARISCOMMA1_GlitchData : VitalGlitchDataType;
        variable RXCHARISCOMMA2_GlitchData : VitalGlitchDataType;
        variable RXCHARISCOMMA3_GlitchData : VitalGlitchDataType;
        variable RXCHARISK0_GlitchData : VitalGlitchDataType;
        variable RXCHARISK1_GlitchData : VitalGlitchDataType;
        variable RXCHARISK2_GlitchData : VitalGlitchDataType;
        variable RXCHARISK3_GlitchData : VitalGlitchDataType;
        variable RXCHBONDO0_GlitchData : VitalGlitchDataType;
        variable RXCHBONDO1_GlitchData : VitalGlitchDataType;
        variable RXCHBONDO2_GlitchData : VitalGlitchDataType;
        variable RXCHBONDO3_GlitchData : VitalGlitchDataType;
        variable RXCLKCORCNT0_GlitchData : VitalGlitchDataType;
        variable RXCLKCORCNT1_GlitchData : VitalGlitchDataType;
        variable RXCLKCORCNT2_GlitchData : VitalGlitchDataType;
        variable RXCOMMADET_GlitchData : VitalGlitchDataType;
        variable RXDATA0_GlitchData : VitalGlitchDataType;
        variable RXDATA10_GlitchData : VitalGlitchDataType;
        variable RXDATA11_GlitchData : VitalGlitchDataType;
        variable RXDATA12_GlitchData : VitalGlitchDataType;
        variable RXDATA13_GlitchData : VitalGlitchDataType;
        variable RXDATA14_GlitchData : VitalGlitchDataType;
        variable RXDATA15_GlitchData : VitalGlitchDataType;
        variable RXDATA16_GlitchData : VitalGlitchDataType;
        variable RXDATA17_GlitchData : VitalGlitchDataType;
        variable RXDATA18_GlitchData : VitalGlitchDataType;
        variable RXDATA19_GlitchData : VitalGlitchDataType;
        variable RXDATA1_GlitchData : VitalGlitchDataType;
        variable RXDATA20_GlitchData : VitalGlitchDataType;
        variable RXDATA21_GlitchData : VitalGlitchDataType;
        variable RXDATA22_GlitchData : VitalGlitchDataType;
        variable RXDATA23_GlitchData : VitalGlitchDataType;
        variable RXDATA24_GlitchData : VitalGlitchDataType;
        variable RXDATA25_GlitchData : VitalGlitchDataType;
        variable RXDATA26_GlitchData : VitalGlitchDataType;
        variable RXDATA27_GlitchData : VitalGlitchDataType;
        variable RXDATA28_GlitchData : VitalGlitchDataType;
        variable RXDATA29_GlitchData : VitalGlitchDataType;
        variable RXDATA2_GlitchData : VitalGlitchDataType;
        variable RXDATA30_GlitchData : VitalGlitchDataType;
        variable RXDATA31_GlitchData : VitalGlitchDataType;
        variable RXDATA3_GlitchData : VitalGlitchDataType;
        variable RXDATA4_GlitchData : VitalGlitchDataType;
        variable RXDATA5_GlitchData : VitalGlitchDataType;
        variable RXDATA6_GlitchData : VitalGlitchDataType;
        variable RXDATA7_GlitchData : VitalGlitchDataType;
        variable RXDATA8_GlitchData : VitalGlitchDataType;
        variable RXDATA9_GlitchData : VitalGlitchDataType;
        variable RXDATAVALID_GlitchData : VitalGlitchDataType;
        variable RXDISPERR0_GlitchData : VitalGlitchDataType;
        variable RXDISPERR1_GlitchData : VitalGlitchDataType;
        variable RXDISPERR2_GlitchData : VitalGlitchDataType;
        variable RXDISPERR3_GlitchData : VitalGlitchDataType;
        variable RXHEADER0_GlitchData : VitalGlitchDataType;
        variable RXHEADER1_GlitchData : VitalGlitchDataType;
        variable RXHEADER2_GlitchData : VitalGlitchDataType;
        variable RXHEADERVALID_GlitchData : VitalGlitchDataType;
        variable RXLOSSOFSYNC0_GlitchData : VitalGlitchDataType;
        variable RXLOSSOFSYNC1_GlitchData : VitalGlitchDataType;
        variable RXNOTINTABLE0_GlitchData : VitalGlitchDataType;
        variable RXNOTINTABLE1_GlitchData : VitalGlitchDataType;
        variable RXNOTINTABLE2_GlitchData : VitalGlitchDataType;
        variable RXNOTINTABLE3_GlitchData : VitalGlitchDataType;
        variable RXOVERSAMPLEERR_GlitchData : VitalGlitchDataType;
        variable RXPRBSERR_GlitchData : VitalGlitchDataType;
        variable RXRATEDONE_GlitchData : VitalGlitchDataType;
        variable RXRESETDONE_GlitchData : VitalGlitchDataType;
        variable RXRUNDISP0_GlitchData : VitalGlitchDataType;
        variable RXRUNDISP1_GlitchData : VitalGlitchDataType;
        variable RXRUNDISP2_GlitchData : VitalGlitchDataType;
        variable RXRUNDISP3_GlitchData : VitalGlitchDataType;
        variable RXSTARTOFSEQ_GlitchData : VitalGlitchDataType;
        variable RXSTATUS0_GlitchData : VitalGlitchDataType;
        variable RXSTATUS1_GlitchData : VitalGlitchDataType;
        variable RXSTATUS2_GlitchData : VitalGlitchDataType;
        variable RXVALID_GlitchData : VitalGlitchDataType;
        variable TXBUFSTATUS0_GlitchData : VitalGlitchDataType;
        variable TXBUFSTATUS1_GlitchData : VitalGlitchDataType;
        variable TXGEARBOXREADY_GlitchData : VitalGlitchDataType;
        variable TXKERR0_GlitchData : VitalGlitchDataType;
        variable TXKERR1_GlitchData : VitalGlitchDataType;
        variable TXKERR2_GlitchData : VitalGlitchDataType;
        variable TXKERR3_GlitchData : VitalGlitchDataType;
        variable TXRATEDONE_GlitchData : VitalGlitchDataType;
        variable TXRESETDONE_GlitchData : VitalGlitchDataType;
        variable TXRUNDISP0_GlitchData : VitalGlitchDataType;
        variable TXRUNDISP1_GlitchData : VitalGlitchDataType;
        variable TXRUNDISP2_GlitchData : VitalGlitchDataType;
        variable TXRUNDISP3_GlitchData : VitalGlitchDataType;
        variable Pviol_DCLK : STD_ULOGIC := '0';
        variable Pviol_GREFCLKRX : STD_ULOGIC := '0';
        variable Pviol_GREFCLKTX : STD_ULOGIC := '0';
        variable Pviol_PERFCLKRX : STD_ULOGIC := '0';
        variable Pviol_PERFCLKTX : STD_ULOGIC := '0';
        variable Pviol_RXUSRCLK : STD_ULOGIC := '0';
        variable Pviol_RXUSRCLK2 : STD_ULOGIC := '0';
        variable Pviol_TSTCLK0 : STD_ULOGIC := '0';
        variable Pviol_TSTCLK1 : STD_ULOGIC := '0';
        variable Pviol_TXUSRCLK : STD_ULOGIC := '0';
        variable Pviol_TXUSRCLK2 : STD_ULOGIC := '0';
        variable PInfo_DCLK : VitalPeriodDataType := VitalPeriodDataInit;
        variable PInfo_GREFCLKRX : VitalPeriodDataType := VitalPeriodDataInit;
        variable PInfo_GREFCLKTX : VitalPeriodDataType := VitalPeriodDataInit;
        variable PInfo_PERFCLKRX : VitalPeriodDataType := VitalPeriodDataInit;
        variable PInfo_PERFCLKTX : VitalPeriodDataType := VitalPeriodDataInit;
        variable PInfo_RXUSRCLK : VitalPeriodDataType := VitalPeriodDataInit;
        variable PInfo_RXUSRCLK2 : VitalPeriodDataType := VitalPeriodDataInit;
        variable PInfo_TSTCLK0 : VitalPeriodDataType := VitalPeriodDataInit;
        variable PInfo_TSTCLK1 : VitalPeriodDataType := VitalPeriodDataInit;
        variable PInfo_TXUSRCLK : VitalPeriodDataType := VitalPeriodDataInit;
        variable PInfo_TXUSRCLK2 : VitalPeriodDataType := VitalPeriodDataInit;
        variable PInfo_MGTREFCLKRX : VitalPeriodDataType := VitalPeriodDataInit;
--        variable PInfo_MGTREFCLKRX_1 : VitalPeriodDataType := VitalPeriodDataInit;
        variable PInfo_MGTREFCLKTX : VitalPeriodDataType := VitalPeriodDataInit;
--        variable PInfo_MGTREFCLKTX_1 : VitalPeriodDataType := VitalPeriodDataInit;
        variable PInfo_NORTHREFCLKRX : VitalPeriodDataType := VitalPeriodDataInit;
--        variable PInfo_NORTHREFCLKRX_1 : VitalPeriodDataType := VitalPeriodDataInit;
        variable PInfo_NORTHREFCLKTX : VitalPeriodDataType := VitalPeriodDataInit;
--        variable PInfo_NORTHREFCLKTX_1 : VitalPeriodDataType := VitalPeriodDataInit;
        variable PInfo_SOUTHREFCLKRX : VitalPeriodDataType := VitalPeriodDataInit;
--        variable PInfo_SOUTHREFCLKRX_1 : VitalPeriodDataType := VitalPeriodDataInit;
        variable PInfo_SOUTHREFCLKTX : VitalPeriodDataType := VitalPeriodDataInit;
--        variable PInfo_SOUTHREFCLKTX_1 : VitalPeriodDataType := VitalPeriodDataInit;

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
            HeaderMsg      => InstancePath & "/X_GTXE1",
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
            HeaderMsg      => InstancePath & "/X_GTXE1",
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
            HeaderMsg      => InstancePath & "/X_GTXE1",
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
            HeaderMsg      => InstancePath & "/X_GTXE1",
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
            HeaderMsg      => InstancePath & "/X_GTXE1",
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
            HeaderMsg      => InstancePath & "/X_GTXE1",
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
            HeaderMsg      => InstancePath & "/X_GTXE1",
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
            HeaderMsg      => InstancePath & "/X_GTXE1",
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
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DFECLKDLYADJ_RXUSRCLK2_posedge(0),
            TimingData => Tmkr_DFECLKDLYADJ_RXUSRCLK2_posedge(0),
            TestSignal => DFECLKDLYADJ_RXUSRCLK2_dly(0),
            TestSignalName => "DFECLKDLYADJ(0)",
            TestDelay => tisd_DFECLKDLYADJ_RXUSRCLK2(0),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_DFECLKDLYADJ_RXUSRCLK2_posedge_posedge(0),
            HoldHigh => thold_DFECLKDLYADJ_RXUSRCLK2_posedge_posedge(0),
            SetupLow => tsetup_DFECLKDLYADJ_RXUSRCLK2_negedge_posedge(0),
            HoldLow => thold_DFECLKDLYADJ_RXUSRCLK2_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DFECLKDLYADJ_RXUSRCLK2_posedge(1),
            TimingData => Tmkr_DFECLKDLYADJ_RXUSRCLK2_posedge(1),
            TestSignal => DFECLKDLYADJ_RXUSRCLK2_dly(1),
            TestSignalName => "DFECLKDLYADJ(1)",
            TestDelay => tisd_DFECLKDLYADJ_RXUSRCLK2(1),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_DFECLKDLYADJ_RXUSRCLK2_posedge_posedge(1),
            HoldHigh => thold_DFECLKDLYADJ_RXUSRCLK2_posedge_posedge(1),
            SetupLow => tsetup_DFECLKDLYADJ_RXUSRCLK2_negedge_posedge(1),
            HoldLow => thold_DFECLKDLYADJ_RXUSRCLK2_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DFECLKDLYADJ_RXUSRCLK2_posedge(2),
            TimingData => Tmkr_DFECLKDLYADJ_RXUSRCLK2_posedge(2),
            TestSignal => DFECLKDLYADJ_RXUSRCLK2_dly(2),
            TestSignalName => "DFECLKDLYADJ(2)",
            TestDelay => tisd_DFECLKDLYADJ_RXUSRCLK2(2),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_DFECLKDLYADJ_RXUSRCLK2_posedge_posedge(2),
            HoldHigh => thold_DFECLKDLYADJ_RXUSRCLK2_posedge_posedge(2),
            SetupLow => tsetup_DFECLKDLYADJ_RXUSRCLK2_negedge_posedge(2),
            HoldLow => thold_DFECLKDLYADJ_RXUSRCLK2_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DFECLKDLYADJ_RXUSRCLK2_posedge(3),
            TimingData => Tmkr_DFECLKDLYADJ_RXUSRCLK2_posedge(3),
            TestSignal => DFECLKDLYADJ_RXUSRCLK2_dly(3),
            TestSignalName => "DFECLKDLYADJ(3)",
            TestDelay => tisd_DFECLKDLYADJ_RXUSRCLK2(3),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_DFECLKDLYADJ_RXUSRCLK2_posedge_posedge(3),
            HoldHigh => thold_DFECLKDLYADJ_RXUSRCLK2_posedge_posedge(3),
            SetupLow => tsetup_DFECLKDLYADJ_RXUSRCLK2_negedge_posedge(3),
            HoldLow => thold_DFECLKDLYADJ_RXUSRCLK2_negedge_posedge(3),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DFECLKDLYADJ_RXUSRCLK2_posedge(4),
            TimingData => Tmkr_DFECLKDLYADJ_RXUSRCLK2_posedge(4),
            TestSignal => DFECLKDLYADJ_RXUSRCLK2_dly(4),
            TestSignalName => "DFECLKDLYADJ(4)",
            TestDelay => tisd_DFECLKDLYADJ_RXUSRCLK2(4),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_DFECLKDLYADJ_RXUSRCLK2_posedge_posedge(4),
            HoldHigh => thold_DFECLKDLYADJ_RXUSRCLK2_posedge_posedge(4),
            SetupLow => tsetup_DFECLKDLYADJ_RXUSRCLK2_negedge_posedge(4),
            HoldLow => thold_DFECLKDLYADJ_RXUSRCLK2_negedge_posedge(4),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DFECLKDLYADJ_RXUSRCLK2_posedge(5),
            TimingData => Tmkr_DFECLKDLYADJ_RXUSRCLK2_posedge(5),
            TestSignal => DFECLKDLYADJ_RXUSRCLK2_dly(5),
            TestSignalName => "DFECLKDLYADJ(5)",
            TestDelay => tisd_DFECLKDLYADJ_RXUSRCLK2(5),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_DFECLKDLYADJ_RXUSRCLK2_posedge_posedge(5),
            HoldHigh => thold_DFECLKDLYADJ_RXUSRCLK2_posedge_posedge(5),
            SetupLow => tsetup_DFECLKDLYADJ_RXUSRCLK2_negedge_posedge(5),
            HoldLow => thold_DFECLKDLYADJ_RXUSRCLK2_negedge_posedge(5),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DFEDLYOVRD_RXUSRCLK2_posedge,
            TimingData => Tmkr_DFEDLYOVRD_RXUSRCLK2_posedge,
            TestSignal => DFEDLYOVRD_RXUSRCLK2_dly,
            TestSignalName => "DFEDLYOVRD",
            TestDelay => tisd_DFEDLYOVRD_RXUSRCLK2,
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_DFEDLYOVRD_RXUSRCLK2_posedge_posedge,
            HoldHigh => thold_DFEDLYOVRD_RXUSRCLK2_posedge_posedge,
            SetupLow => tsetup_DFEDLYOVRD_RXUSRCLK2_negedge_posedge,
            HoldLow => thold_DFEDLYOVRD_RXUSRCLK2_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DFETAP1_RXUSRCLK2_posedge(0),
            TimingData => Tmkr_DFETAP1_RXUSRCLK2_posedge(0),
            TestSignal => DFETAP1_RXUSRCLK2_dly(0),
            TestSignalName => "DFETAP1(0)",
            TestDelay => tisd_DFETAP1_RXUSRCLK2(0),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_DFETAP1_RXUSRCLK2_posedge_posedge(0),
            HoldHigh => thold_DFETAP1_RXUSRCLK2_posedge_posedge(0),
            SetupLow => tsetup_DFETAP1_RXUSRCLK2_negedge_posedge(0),
            HoldLow => thold_DFETAP1_RXUSRCLK2_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DFETAP1_RXUSRCLK2_posedge(1),
            TimingData => Tmkr_DFETAP1_RXUSRCLK2_posedge(1),
            TestSignal => DFETAP1_RXUSRCLK2_dly(1),
            TestSignalName => "DFETAP1(1)",
            TestDelay => tisd_DFETAP1_RXUSRCLK2(1),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_DFETAP1_RXUSRCLK2_posedge_posedge(1),
            HoldHigh => thold_DFETAP1_RXUSRCLK2_posedge_posedge(1),
            SetupLow => tsetup_DFETAP1_RXUSRCLK2_negedge_posedge(1),
            HoldLow => thold_DFETAP1_RXUSRCLK2_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DFETAP1_RXUSRCLK2_posedge(2),
            TimingData => Tmkr_DFETAP1_RXUSRCLK2_posedge(2),
            TestSignal => DFETAP1_RXUSRCLK2_dly(2),
            TestSignalName => "DFETAP1(2)",
            TestDelay => tisd_DFETAP1_RXUSRCLK2(2),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_DFETAP1_RXUSRCLK2_posedge_posedge(2),
            HoldHigh => thold_DFETAP1_RXUSRCLK2_posedge_posedge(2),
            SetupLow => tsetup_DFETAP1_RXUSRCLK2_negedge_posedge(2),
            HoldLow => thold_DFETAP1_RXUSRCLK2_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DFETAP1_RXUSRCLK2_posedge(3),
            TimingData => Tmkr_DFETAP1_RXUSRCLK2_posedge(3),
            TestSignal => DFETAP1_RXUSRCLK2_dly(3),
            TestSignalName => "DFETAP1(3)",
            TestDelay => tisd_DFETAP1_RXUSRCLK2(3),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_DFETAP1_RXUSRCLK2_posedge_posedge(3),
            HoldHigh => thold_DFETAP1_RXUSRCLK2_posedge_posedge(3),
            SetupLow => tsetup_DFETAP1_RXUSRCLK2_negedge_posedge(3),
            HoldLow => thold_DFETAP1_RXUSRCLK2_negedge_posedge(3),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DFETAP1_RXUSRCLK2_posedge(4),
            TimingData => Tmkr_DFETAP1_RXUSRCLK2_posedge(4),
            TestSignal => DFETAP1_RXUSRCLK2_dly(4),
            TestSignalName => "DFETAP1(4)",
            TestDelay => tisd_DFETAP1_RXUSRCLK2(4),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_DFETAP1_RXUSRCLK2_posedge_posedge(4),
            HoldHigh => thold_DFETAP1_RXUSRCLK2_posedge_posedge(4),
            SetupLow => tsetup_DFETAP1_RXUSRCLK2_negedge_posedge(4),
            HoldLow => thold_DFETAP1_RXUSRCLK2_negedge_posedge(4),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DFETAP2_RXUSRCLK2_posedge(0),
            TimingData => Tmkr_DFETAP2_RXUSRCLK2_posedge(0),
            TestSignal => DFETAP2_RXUSRCLK2_dly(0),
            TestSignalName => "DFETAP2(0)",
            TestDelay => tisd_DFETAP2_RXUSRCLK2(0),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_DFETAP2_RXUSRCLK2_posedge_posedge(0),
            HoldHigh => thold_DFETAP2_RXUSRCLK2_posedge_posedge(0),
            SetupLow => tsetup_DFETAP2_RXUSRCLK2_negedge_posedge(0),
            HoldLow => thold_DFETAP2_RXUSRCLK2_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DFETAP2_RXUSRCLK2_posedge(1),
            TimingData => Tmkr_DFETAP2_RXUSRCLK2_posedge(1),
            TestSignal => DFETAP2_RXUSRCLK2_dly(1),
            TestSignalName => "DFETAP2(1)",
            TestDelay => tisd_DFETAP2_RXUSRCLK2(1),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_DFETAP2_RXUSRCLK2_posedge_posedge(1),
            HoldHigh => thold_DFETAP2_RXUSRCLK2_posedge_posedge(1),
            SetupLow => tsetup_DFETAP2_RXUSRCLK2_negedge_posedge(1),
            HoldLow => thold_DFETAP2_RXUSRCLK2_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DFETAP2_RXUSRCLK2_posedge(2),
            TimingData => Tmkr_DFETAP2_RXUSRCLK2_posedge(2),
            TestSignal => DFETAP2_RXUSRCLK2_dly(2),
            TestSignalName => "DFETAP2(2)",
            TestDelay => tisd_DFETAP2_RXUSRCLK2(2),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_DFETAP2_RXUSRCLK2_posedge_posedge(2),
            HoldHigh => thold_DFETAP2_RXUSRCLK2_posedge_posedge(2),
            SetupLow => tsetup_DFETAP2_RXUSRCLK2_negedge_posedge(2),
            HoldLow => thold_DFETAP2_RXUSRCLK2_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DFETAP2_RXUSRCLK2_posedge(3),
            TimingData => Tmkr_DFETAP2_RXUSRCLK2_posedge(3),
            TestSignal => DFETAP2_RXUSRCLK2_dly(3),
            TestSignalName => "DFETAP2(3)",
            TestDelay => tisd_DFETAP2_RXUSRCLK2(3),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_DFETAP2_RXUSRCLK2_posedge_posedge(3),
            HoldHigh => thold_DFETAP2_RXUSRCLK2_posedge_posedge(3),
            SetupLow => tsetup_DFETAP2_RXUSRCLK2_negedge_posedge(3),
            HoldLow => thold_DFETAP2_RXUSRCLK2_negedge_posedge(3),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DFETAP2_RXUSRCLK2_posedge(4),
            TimingData => Tmkr_DFETAP2_RXUSRCLK2_posedge(4),
            TestSignal => DFETAP2_RXUSRCLK2_dly(4),
            TestSignalName => "DFETAP2(4)",
            TestDelay => tisd_DFETAP2_RXUSRCLK2(4),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_DFETAP2_RXUSRCLK2_posedge_posedge(4),
            HoldHigh => thold_DFETAP2_RXUSRCLK2_posedge_posedge(4),
            SetupLow => tsetup_DFETAP2_RXUSRCLK2_negedge_posedge(4),
            HoldLow => thold_DFETAP2_RXUSRCLK2_negedge_posedge(4),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DFETAP3_RXUSRCLK2_posedge(0),
            TimingData => Tmkr_DFETAP3_RXUSRCLK2_posedge(0),
            TestSignal => DFETAP3_RXUSRCLK2_dly(0),
            TestSignalName => "DFETAP3(0)",
            TestDelay => tisd_DFETAP3_RXUSRCLK2(0),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_DFETAP3_RXUSRCLK2_posedge_posedge(0),
            HoldHigh => thold_DFETAP3_RXUSRCLK2_posedge_posedge(0),
            SetupLow => tsetup_DFETAP3_RXUSRCLK2_negedge_posedge(0),
            HoldLow => thold_DFETAP3_RXUSRCLK2_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DFETAP3_RXUSRCLK2_posedge(1),
            TimingData => Tmkr_DFETAP3_RXUSRCLK2_posedge(1),
            TestSignal => DFETAP3_RXUSRCLK2_dly(1),
            TestSignalName => "DFETAP3(1)",
            TestDelay => tisd_DFETAP3_RXUSRCLK2(1),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_DFETAP3_RXUSRCLK2_posedge_posedge(1),
            HoldHigh => thold_DFETAP3_RXUSRCLK2_posedge_posedge(1),
            SetupLow => tsetup_DFETAP3_RXUSRCLK2_negedge_posedge(1),
            HoldLow => thold_DFETAP3_RXUSRCLK2_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DFETAP3_RXUSRCLK2_posedge(2),
            TimingData => Tmkr_DFETAP3_RXUSRCLK2_posedge(2),
            TestSignal => DFETAP3_RXUSRCLK2_dly(2),
            TestSignalName => "DFETAP3(2)",
            TestDelay => tisd_DFETAP3_RXUSRCLK2(2),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_DFETAP3_RXUSRCLK2_posedge_posedge(2),
            HoldHigh => thold_DFETAP3_RXUSRCLK2_posedge_posedge(2),
            SetupLow => tsetup_DFETAP3_RXUSRCLK2_negedge_posedge(2),
            HoldLow => thold_DFETAP3_RXUSRCLK2_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DFETAP3_RXUSRCLK2_posedge(3),
            TimingData => Tmkr_DFETAP3_RXUSRCLK2_posedge(3),
            TestSignal => DFETAP3_RXUSRCLK2_dly(3),
            TestSignalName => "DFETAP3(3)",
            TestDelay => tisd_DFETAP3_RXUSRCLK2(3),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_DFETAP3_RXUSRCLK2_posedge_posedge(3),
            HoldHigh => thold_DFETAP3_RXUSRCLK2_posedge_posedge(3),
            SetupLow => tsetup_DFETAP3_RXUSRCLK2_negedge_posedge(3),
            HoldLow => thold_DFETAP3_RXUSRCLK2_negedge_posedge(3),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DFETAP4_RXUSRCLK2_posedge(0),
            TimingData => Tmkr_DFETAP4_RXUSRCLK2_posedge(0),
            TestSignal => DFETAP4_RXUSRCLK2_dly(0),
            TestSignalName => "DFETAP4(0)",
            TestDelay => tisd_DFETAP4_RXUSRCLK2(0),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_DFETAP4_RXUSRCLK2_posedge_posedge(0),
            HoldHigh => thold_DFETAP4_RXUSRCLK2_posedge_posedge(0),
            SetupLow => tsetup_DFETAP4_RXUSRCLK2_negedge_posedge(0),
            HoldLow => thold_DFETAP4_RXUSRCLK2_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DFETAP4_RXUSRCLK2_posedge(1),
            TimingData => Tmkr_DFETAP4_RXUSRCLK2_posedge(1),
            TestSignal => DFETAP4_RXUSRCLK2_dly(1),
            TestSignalName => "DFETAP4(1)",
            TestDelay => tisd_DFETAP4_RXUSRCLK2(1),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_DFETAP4_RXUSRCLK2_posedge_posedge(1),
            HoldHigh => thold_DFETAP4_RXUSRCLK2_posedge_posedge(1),
            SetupLow => tsetup_DFETAP4_RXUSRCLK2_negedge_posedge(1),
            HoldLow => thold_DFETAP4_RXUSRCLK2_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DFETAP4_RXUSRCLK2_posedge(2),
            TimingData => Tmkr_DFETAP4_RXUSRCLK2_posedge(2),
            TestSignal => DFETAP4_RXUSRCLK2_dly(2),
            TestSignalName => "DFETAP4(2)",
            TestDelay => tisd_DFETAP4_RXUSRCLK2(2),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_DFETAP4_RXUSRCLK2_posedge_posedge(2),
            HoldHigh => thold_DFETAP4_RXUSRCLK2_posedge_posedge(2),
            SetupLow => tsetup_DFETAP4_RXUSRCLK2_negedge_posedge(2),
            HoldLow => thold_DFETAP4_RXUSRCLK2_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DFETAP4_RXUSRCLK2_posedge(3),
            TimingData => Tmkr_DFETAP4_RXUSRCLK2_posedge(3),
            TestSignal => DFETAP4_RXUSRCLK2_dly(3),
            TestSignalName => "DFETAP4(3)",
            TestDelay => tisd_DFETAP4_RXUSRCLK2(3),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_DFETAP4_RXUSRCLK2_posedge_posedge(3),
            HoldHigh => thold_DFETAP4_RXUSRCLK2_posedge_posedge(3),
            SetupLow => tsetup_DFETAP4_RXUSRCLK2_negedge_posedge(3),
            HoldLow => thold_DFETAP4_RXUSRCLK2_negedge_posedge(3),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_DFETAPOVRD_RXUSRCLK2_posedge,
            TimingData => Tmkr_DFETAPOVRD_RXUSRCLK2_posedge,
            TestSignal => DFETAPOVRD_RXUSRCLK2_dly,
            TestSignalName => "DFETAPOVRD",
            TestDelay => tisd_DFETAPOVRD_RXUSRCLK2,
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_DFETAPOVRD_RXUSRCLK2_posedge_posedge,
            HoldHigh => thold_DFETAPOVRD_RXUSRCLK2_posedge_posedge,
            SetupLow => tsetup_DFETAPOVRD_RXUSRCLK2_negedge_posedge,
            HoldLow => thold_DFETAPOVRD_RXUSRCLK2_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
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
            HeaderMsg      => InstancePath & "/X_GTXE1",
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
            HeaderMsg      => InstancePath & "/X_GTXE1",
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
            HeaderMsg      => InstancePath & "/X_GTXE1",
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
            HeaderMsg      => InstancePath & "/X_GTXE1",
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
            HeaderMsg      => InstancePath & "/X_GTXE1",
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
            HeaderMsg      => InstancePath & "/X_GTXE1",
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
            HeaderMsg      => InstancePath & "/X_GTXE1",
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
            HeaderMsg      => InstancePath & "/X_GTXE1",
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
            HeaderMsg      => InstancePath & "/X_GTXE1",
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
            HeaderMsg      => InstancePath & "/X_GTXE1",
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
            HeaderMsg      => InstancePath & "/X_GTXE1",
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
            HeaderMsg      => InstancePath & "/X_GTXE1",
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
            HeaderMsg      => InstancePath & "/X_GTXE1",
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
            HeaderMsg      => InstancePath & "/X_GTXE1",
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
            HeaderMsg      => InstancePath & "/X_GTXE1",
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
            HeaderMsg      => InstancePath & "/X_GTXE1",
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
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_PRBSCNTRESET_RXUSRCLK2_posedge,
            TimingData => Tmkr_PRBSCNTRESET_RXUSRCLK2_posedge,
            TestSignal => PRBSCNTRESET_RXUSRCLK2_dly,
            TestSignalName => "PRBSCNTRESET",
            TestDelay => tisd_PRBSCNTRESET_RXUSRCLK2,
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_PRBSCNTRESET_RXUSRCLK2_posedge_posedge,
            HoldHigh => thold_PRBSCNTRESET_RXUSRCLK2_posedge_posedge,
            SetupLow => tsetup_PRBSCNTRESET_RXUSRCLK2_negedge_posedge,
            HoldLow => thold_PRBSCNTRESET_RXUSRCLK2_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXCHBONDI_RXUSRCLK2_posedge(0),
            TimingData => Tmkr_RXCHBONDI_RXUSRCLK2_posedge(0),
            TestSignal => RXCHBONDI_RXUSRCLK2_dly(0),
            TestSignalName => "RXCHBONDI(0)",
            TestDelay => tisd_RXCHBONDI_RXUSRCLK2(0),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_RXCHBONDI_RXUSRCLK2_posedge_posedge(0),
            HoldHigh => thold_RXCHBONDI_RXUSRCLK2_posedge_posedge(0),
            SetupLow => tsetup_RXCHBONDI_RXUSRCLK2_negedge_posedge(0),
            HoldLow => thold_RXCHBONDI_RXUSRCLK2_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXCHBONDI_RXUSRCLK2_posedge(1),
            TimingData => Tmkr_RXCHBONDI_RXUSRCLK2_posedge(1),
            TestSignal => RXCHBONDI_RXUSRCLK2_dly(1),
            TestSignalName => "RXCHBONDI(1)",
            TestDelay => tisd_RXCHBONDI_RXUSRCLK2(1),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_RXCHBONDI_RXUSRCLK2_posedge_posedge(1),
            HoldHigh => thold_RXCHBONDI_RXUSRCLK2_posedge_posedge(1),
            SetupLow => tsetup_RXCHBONDI_RXUSRCLK2_negedge_posedge(1),
            HoldLow => thold_RXCHBONDI_RXUSRCLK2_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXCHBONDI_RXUSRCLK2_posedge(2),
            TimingData => Tmkr_RXCHBONDI_RXUSRCLK2_posedge(2),
            TestSignal => RXCHBONDI_RXUSRCLK2_dly(2),
            TestSignalName => "RXCHBONDI(2)",
            TestDelay => tisd_RXCHBONDI_RXUSRCLK2(2),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_RXCHBONDI_RXUSRCLK2_posedge_posedge(2),
            HoldHigh => thold_RXCHBONDI_RXUSRCLK2_posedge_posedge(2),
            SetupLow => tsetup_RXCHBONDI_RXUSRCLK2_negedge_posedge(2),
            HoldLow => thold_RXCHBONDI_RXUSRCLK2_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXCHBONDI_RXUSRCLK2_posedge(3),
            TimingData => Tmkr_RXCHBONDI_RXUSRCLK2_posedge(3),
            TestSignal => RXCHBONDI_RXUSRCLK2_dly(3),
            TestSignalName => "RXCHBONDI(3)",
            TestDelay => tisd_RXCHBONDI_RXUSRCLK2(3),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_RXCHBONDI_RXUSRCLK2_posedge_posedge(3),
            HoldHigh => thold_RXCHBONDI_RXUSRCLK2_posedge_posedge(3),
            SetupLow => tsetup_RXCHBONDI_RXUSRCLK2_negedge_posedge(3),
            HoldLow => thold_RXCHBONDI_RXUSRCLK2_negedge_posedge(3),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXCHBONDI_RXUSRCLK_posedge(0),
            TimingData => Tmkr_RXCHBONDI_RXUSRCLK_posedge(0),
            TestSignal => RXCHBONDI_RXUSRCLK_dly(0),
            TestSignalName => "RXCHBONDI(0)",
            TestDelay => tisd_RXCHBONDI_RXUSRCLK(0),
            RefSignal => RXUSRCLK_dly_1,
            RefSignalName => "RXUSRCLK",
            RefDelay => ticd_RXUSRCLK,
            SetupHigh => tsetup_RXCHBONDI_RXUSRCLK_posedge_posedge(0),
            HoldHigh => thold_RXCHBONDI_RXUSRCLK_posedge_posedge(0),
            SetupLow => tsetup_RXCHBONDI_RXUSRCLK_negedge_posedge(0),
            HoldLow => thold_RXCHBONDI_RXUSRCLK_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXCHBONDI_RXUSRCLK_posedge(1),
            TimingData => Tmkr_RXCHBONDI_RXUSRCLK_posedge(1),
            TestSignal => RXCHBONDI_RXUSRCLK_dly(1),
            TestSignalName => "RXCHBONDI(1)",
            TestDelay => tisd_RXCHBONDI_RXUSRCLK(1),
            RefSignal => RXUSRCLK_dly_1,
            RefSignalName => "RXUSRCLK",
            RefDelay => ticd_RXUSRCLK,
            SetupHigh => tsetup_RXCHBONDI_RXUSRCLK_posedge_posedge(1),
            HoldHigh => thold_RXCHBONDI_RXUSRCLK_posedge_posedge(1),
            SetupLow => tsetup_RXCHBONDI_RXUSRCLK_negedge_posedge(1),
            HoldLow => thold_RXCHBONDI_RXUSRCLK_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXCHBONDI_RXUSRCLK_posedge(2),
            TimingData => Tmkr_RXCHBONDI_RXUSRCLK_posedge(2),
            TestSignal => RXCHBONDI_RXUSRCLK_dly(2),
            TestSignalName => "RXCHBONDI(2)",
            TestDelay => tisd_RXCHBONDI_RXUSRCLK(2),
            RefSignal => RXUSRCLK_dly_1,
            RefSignalName => "RXUSRCLK",
            RefDelay => ticd_RXUSRCLK,
            SetupHigh => tsetup_RXCHBONDI_RXUSRCLK_posedge_posedge(2),
            HoldHigh => thold_RXCHBONDI_RXUSRCLK_posedge_posedge(2),
            SetupLow => tsetup_RXCHBONDI_RXUSRCLK_negedge_posedge(2),
            HoldLow => thold_RXCHBONDI_RXUSRCLK_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXCHBONDI_RXUSRCLK_posedge(3),
            TimingData => Tmkr_RXCHBONDI_RXUSRCLK_posedge(3),
            TestSignal => RXCHBONDI_RXUSRCLK_dly(3),
            TestSignalName => "RXCHBONDI(3)",
            TestDelay => tisd_RXCHBONDI_RXUSRCLK(3),
            RefSignal => RXUSRCLK_dly_1,
            RefSignalName => "RXUSRCLK",
            RefDelay => ticd_RXUSRCLK,
            SetupHigh => tsetup_RXCHBONDI_RXUSRCLK_posedge_posedge(3),
            HoldHigh => thold_RXCHBONDI_RXUSRCLK_posedge_posedge(3),
            SetupLow => tsetup_RXCHBONDI_RXUSRCLK_negedge_posedge(3),
            HoldLow => thold_RXCHBONDI_RXUSRCLK_negedge_posedge(3),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXCHBONDLEVEL_RXUSRCLK2_posedge(0),
            TimingData => Tmkr_RXCHBONDLEVEL_RXUSRCLK2_posedge(0),
            TestSignal => RXCHBONDLEVEL_RXUSRCLK2_dly(0),
            TestSignalName => "RXCHBONDLEVEL(0)",
            TestDelay => tisd_RXCHBONDLEVEL_RXUSRCLK2(0),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_RXCHBONDLEVEL_RXUSRCLK2_posedge_posedge(0),
            HoldHigh => thold_RXCHBONDLEVEL_RXUSRCLK2_posedge_posedge(0),
            SetupLow => tsetup_RXCHBONDLEVEL_RXUSRCLK2_negedge_posedge(0),
            HoldLow => thold_RXCHBONDLEVEL_RXUSRCLK2_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXCHBONDLEVEL_RXUSRCLK2_posedge(1),
            TimingData => Tmkr_RXCHBONDLEVEL_RXUSRCLK2_posedge(1),
            TestSignal => RXCHBONDLEVEL_RXUSRCLK2_dly(1),
            TestSignalName => "RXCHBONDLEVEL(1)",
            TestDelay => tisd_RXCHBONDLEVEL_RXUSRCLK2(1),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_RXCHBONDLEVEL_RXUSRCLK2_posedge_posedge(1),
            HoldHigh => thold_RXCHBONDLEVEL_RXUSRCLK2_posedge_posedge(1),
            SetupLow => tsetup_RXCHBONDLEVEL_RXUSRCLK2_negedge_posedge(1),
            HoldLow => thold_RXCHBONDLEVEL_RXUSRCLK2_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXCHBONDLEVEL_RXUSRCLK2_posedge(2),
            TimingData => Tmkr_RXCHBONDLEVEL_RXUSRCLK2_posedge(2),
            TestSignal => RXCHBONDLEVEL_RXUSRCLK2_dly(2),
            TestSignalName => "RXCHBONDLEVEL(2)",
            TestDelay => tisd_RXCHBONDLEVEL_RXUSRCLK2(2),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_RXCHBONDLEVEL_RXUSRCLK2_posedge_posedge(2),
            HoldHigh => thold_RXCHBONDLEVEL_RXUSRCLK2_posedge_posedge(2),
            SetupLow => tsetup_RXCHBONDLEVEL_RXUSRCLK2_negedge_posedge(2),
            HoldLow => thold_RXCHBONDLEVEL_RXUSRCLK2_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXCHBONDMASTER_RXUSRCLK2_posedge,
            TimingData => Tmkr_RXCHBONDMASTER_RXUSRCLK2_posedge,
            TestSignal => RXCHBONDMASTER_RXUSRCLK2_dly,
            TestSignalName => "RXCHBONDMASTER",
            TestDelay => tisd_RXCHBONDMASTER_RXUSRCLK2,
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_RXCHBONDMASTER_RXUSRCLK2_posedge_posedge,
            HoldHigh => thold_RXCHBONDMASTER_RXUSRCLK2_posedge_posedge,
            SetupLow => tsetup_RXCHBONDMASTER_RXUSRCLK2_negedge_posedge,
            HoldLow => thold_RXCHBONDMASTER_RXUSRCLK2_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXCHBONDSLAVE_RXUSRCLK2_posedge,
            TimingData => Tmkr_RXCHBONDSLAVE_RXUSRCLK2_posedge,
            TestSignal => RXCHBONDSLAVE_RXUSRCLK2_dly,
            TestSignalName => "RXCHBONDSLAVE",
            TestDelay => tisd_RXCHBONDSLAVE_RXUSRCLK2,
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_RXCHBONDSLAVE_RXUSRCLK2_posedge_posedge,
            HoldHigh => thold_RXCHBONDSLAVE_RXUSRCLK2_posedge_posedge,
            SetupLow => tsetup_RXCHBONDSLAVE_RXUSRCLK2_negedge_posedge,
            HoldLow => thold_RXCHBONDSLAVE_RXUSRCLK2_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXCOMMADETUSE_RXUSRCLK2_posedge,
            TimingData => Tmkr_RXCOMMADETUSE_RXUSRCLK2_posedge,
            TestSignal => RXCOMMADETUSE_RXUSRCLK2_dly,
            TestSignalName => "RXCOMMADETUSE",
            TestDelay => tisd_RXCOMMADETUSE_RXUSRCLK2,
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_RXCOMMADETUSE_RXUSRCLK2_posedge_posedge,
            HoldHigh => thold_RXCOMMADETUSE_RXUSRCLK2_posedge_posedge,
            SetupLow => tsetup_RXCOMMADETUSE_RXUSRCLK2_negedge_posedge,
            HoldLow => thold_RXCOMMADETUSE_RXUSRCLK2_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXDEC8B10BUSE_RXUSRCLK2_posedge,
            TimingData => Tmkr_RXDEC8B10BUSE_RXUSRCLK2_posedge,
            TestSignal => RXDEC8B10BUSE_RXUSRCLK2_dly,
            TestSignalName => "RXDEC8B10BUSE",
            TestDelay => tisd_RXDEC8B10BUSE_RXUSRCLK2,
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_RXDEC8B10BUSE_RXUSRCLK2_posedge_posedge,
            HoldHigh => thold_RXDEC8B10BUSE_RXUSRCLK2_posedge_posedge,
            SetupLow => tsetup_RXDEC8B10BUSE_RXUSRCLK2_negedge_posedge,
            HoldLow => thold_RXDEC8B10BUSE_RXUSRCLK2_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXENCHANSYNC_RXUSRCLK2_posedge,
            TimingData => Tmkr_RXENCHANSYNC_RXUSRCLK2_posedge,
            TestSignal => RXENCHANSYNC_RXUSRCLK2_dly,
            TestSignalName => "RXENCHANSYNC",
            TestDelay => tisd_RXENCHANSYNC_RXUSRCLK2,
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_RXENCHANSYNC_RXUSRCLK2_posedge_posedge,
            HoldHigh => thold_RXENCHANSYNC_RXUSRCLK2_posedge_posedge,
            SetupLow => tsetup_RXENCHANSYNC_RXUSRCLK2_negedge_posedge,
            HoldLow => thold_RXENCHANSYNC_RXUSRCLK2_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXENMCOMMAALIGN_RXUSRCLK2_posedge,
            TimingData => Tmkr_RXENMCOMMAALIGN_RXUSRCLK2_posedge,
            TestSignal => RXENMCOMMAALIGN_RXUSRCLK2_dly,
            TestSignalName => "RXENMCOMMAALIGN",
            TestDelay => tisd_RXENMCOMMAALIGN_RXUSRCLK2,
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_RXENMCOMMAALIGN_RXUSRCLK2_posedge_posedge,
            HoldHigh => thold_RXENMCOMMAALIGN_RXUSRCLK2_posedge_posedge,
            SetupLow => tsetup_RXENMCOMMAALIGN_RXUSRCLK2_negedge_posedge,
            HoldLow => thold_RXENMCOMMAALIGN_RXUSRCLK2_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXENPCOMMAALIGN_RXUSRCLK2_posedge,
            TimingData => Tmkr_RXENPCOMMAALIGN_RXUSRCLK2_posedge,
            TestSignal => RXENPCOMMAALIGN_RXUSRCLK2_dly,
            TestSignalName => "RXENPCOMMAALIGN",
            TestDelay => tisd_RXENPCOMMAALIGN_RXUSRCLK2,
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_RXENPCOMMAALIGN_RXUSRCLK2_posedge_posedge,
            HoldHigh => thold_RXENPCOMMAALIGN_RXUSRCLK2_posedge_posedge,
            SetupLow => tsetup_RXENPCOMMAALIGN_RXUSRCLK2_negedge_posedge,
            HoldLow => thold_RXENPCOMMAALIGN_RXUSRCLK2_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXENPRBSTST_RXUSRCLK2_posedge(0),
            TimingData => Tmkr_RXENPRBSTST_RXUSRCLK2_posedge(0),
            TestSignal => RXENPRBSTST_RXUSRCLK2_dly(0),
            TestSignalName => "RXENPRBSTST(0)",
            TestDelay => tisd_RXENPRBSTST_RXUSRCLK2(0),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_RXENPRBSTST_RXUSRCLK2_posedge_posedge(0),
            HoldHigh => thold_RXENPRBSTST_RXUSRCLK2_posedge_posedge(0),
            SetupLow => tsetup_RXENPRBSTST_RXUSRCLK2_negedge_posedge(0),
            HoldLow => thold_RXENPRBSTST_RXUSRCLK2_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXENPRBSTST_RXUSRCLK2_posedge(1),
            TimingData => Tmkr_RXENPRBSTST_RXUSRCLK2_posedge(1),
            TestSignal => RXENPRBSTST_RXUSRCLK2_dly(1),
            TestSignalName => "RXENPRBSTST(1)",
            TestDelay => tisd_RXENPRBSTST_RXUSRCLK2(1),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_RXENPRBSTST_RXUSRCLK2_posedge_posedge(1),
            HoldHigh => thold_RXENPRBSTST_RXUSRCLK2_posedge_posedge(1),
            SetupLow => tsetup_RXENPRBSTST_RXUSRCLK2_negedge_posedge(1),
            HoldLow => thold_RXENPRBSTST_RXUSRCLK2_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXENPRBSTST_RXUSRCLK2_posedge(2),
            TimingData => Tmkr_RXENPRBSTST_RXUSRCLK2_posedge(2),
            TestSignal => RXENPRBSTST_RXUSRCLK2_dly(2),
            TestSignalName => "RXENPRBSTST(2)",
            TestDelay => tisd_RXENPRBSTST_RXUSRCLK2(2),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_RXENPRBSTST_RXUSRCLK2_posedge_posedge(2),
            HoldHigh => thold_RXENPRBSTST_RXUSRCLK2_posedge_posedge(2),
            SetupLow => tsetup_RXENPRBSTST_RXUSRCLK2_negedge_posedge(2),
            HoldLow => thold_RXENPRBSTST_RXUSRCLK2_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXENSAMPLEALIGN_RXUSRCLK2_posedge,
            TimingData => Tmkr_RXENSAMPLEALIGN_RXUSRCLK2_posedge,
            TestSignal => RXENSAMPLEALIGN_RXUSRCLK2_dly,
            TestSignalName => "RXENSAMPLEALIGN",
            TestDelay => tisd_RXENSAMPLEALIGN_RXUSRCLK2,
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_RXENSAMPLEALIGN_RXUSRCLK2_posedge_posedge,
            HoldHigh => thold_RXENSAMPLEALIGN_RXUSRCLK2_posedge_posedge,
            SetupLow => tsetup_RXENSAMPLEALIGN_RXUSRCLK2_negedge_posedge,
            HoldLow => thold_RXENSAMPLEALIGN_RXUSRCLK2_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXGEARBOXSLIP_RXUSRCLK2_posedge,
            TimingData => Tmkr_RXGEARBOXSLIP_RXUSRCLK2_posedge,
            TestSignal => RXGEARBOXSLIP_RXUSRCLK2_dly,
            TestSignalName => "RXGEARBOXSLIP",
            TestDelay => tisd_RXGEARBOXSLIP_RXUSRCLK2,
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_RXGEARBOXSLIP_RXUSRCLK2_posedge_posedge,
            HoldHigh => thold_RXGEARBOXSLIP_RXUSRCLK2_posedge_posedge,
            SetupLow => tsetup_RXGEARBOXSLIP_RXUSRCLK2_negedge_posedge,
            HoldLow => thold_RXGEARBOXSLIP_RXUSRCLK2_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXPOLARITY_RXUSRCLK2_posedge,
            TimingData => Tmkr_RXPOLARITY_RXUSRCLK2_posedge,
            TestSignal => RXPOLARITY_RXUSRCLK2_dly,
            TestSignalName => "RXPOLARITY",
            TestDelay => tisd_RXPOLARITY_RXUSRCLK2,
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_RXPOLARITY_RXUSRCLK2_posedge_posedge,
            HoldHigh => thold_RXPOLARITY_RXUSRCLK2_posedge_posedge,
            SetupLow => tsetup_RXPOLARITY_RXUSRCLK2_negedge_posedge,
            HoldLow => thold_RXPOLARITY_RXUSRCLK2_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXRATE_RXUSRCLK2_posedge(0),
            TimingData => Tmkr_RXRATE_RXUSRCLK2_posedge(0),
            TestSignal => RXRATE_RXUSRCLK2_dly(0),
            TestSignalName => "RXRATE(0)",
            TestDelay => tisd_RXRATE_RXUSRCLK2(0),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_RXRATE_RXUSRCLK2_posedge_posedge(0),
            HoldHigh => thold_RXRATE_RXUSRCLK2_posedge_posedge(0),
            SetupLow => tsetup_RXRATE_RXUSRCLK2_negedge_posedge(0),
            HoldLow => thold_RXRATE_RXUSRCLK2_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXRATE_RXUSRCLK2_posedge(1),
            TimingData => Tmkr_RXRATE_RXUSRCLK2_posedge(1),
            TestSignal => RXRATE_RXUSRCLK2_dly(1),
            TestSignalName => "RXRATE(1)",
            TestDelay => tisd_RXRATE_RXUSRCLK2(1),
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_RXRATE_RXUSRCLK2_posedge_posedge(1),
            HoldHigh => thold_RXRATE_RXUSRCLK2_posedge_posedge(1),
            SetupLow => tsetup_RXRATE_RXUSRCLK2_negedge_posedge(1),
            HoldLow => thold_RXRATE_RXUSRCLK2_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_RXSLIDE_RXUSRCLK2_posedge,
            TimingData => Tmkr_RXSLIDE_RXUSRCLK2_posedge,
            TestSignal => RXSLIDE_RXUSRCLK2_dly,
            TestSignalName => "RXSLIDE",
            TestDelay => tisd_RXSLIDE_RXUSRCLK2,
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_RXSLIDE_RXUSRCLK2_posedge_posedge,
            HoldHigh => thold_RXSLIDE_RXUSRCLK2_posedge_posedge,
            SetupLow => tsetup_RXSLIDE_RXUSRCLK2_negedge_posedge,
            HoldLow => thold_RXSLIDE_RXUSRCLK2_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXBYPASS8B10B_TXUSRCLK2_posedge(0),
            TimingData => Tmkr_TXBYPASS8B10B_TXUSRCLK2_posedge(0),
            TestSignal => TXBYPASS8B10B_TXUSRCLK2_dly(0),
            TestSignalName => "TXBYPASS8B10B(0)",
            TestDelay => tisd_TXBYPASS8B10B_TXUSRCLK2(0),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXBYPASS8B10B_TXUSRCLK2_posedge_posedge(0),
            HoldHigh => thold_TXBYPASS8B10B_TXUSRCLK2_posedge_posedge(0),
            SetupLow => tsetup_TXBYPASS8B10B_TXUSRCLK2_negedge_posedge(0),
            HoldLow => thold_TXBYPASS8B10B_TXUSRCLK2_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXBYPASS8B10B_TXUSRCLK2_posedge(1),
            TimingData => Tmkr_TXBYPASS8B10B_TXUSRCLK2_posedge(1),
            TestSignal => TXBYPASS8B10B_TXUSRCLK2_dly(1),
            TestSignalName => "TXBYPASS8B10B(1)",
            TestDelay => tisd_TXBYPASS8B10B_TXUSRCLK2(1),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXBYPASS8B10B_TXUSRCLK2_posedge_posedge(1),
            HoldHigh => thold_TXBYPASS8B10B_TXUSRCLK2_posedge_posedge(1),
            SetupLow => tsetup_TXBYPASS8B10B_TXUSRCLK2_negedge_posedge(1),
            HoldLow => thold_TXBYPASS8B10B_TXUSRCLK2_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXBYPASS8B10B_TXUSRCLK2_posedge(2),
            TimingData => Tmkr_TXBYPASS8B10B_TXUSRCLK2_posedge(2),
            TestSignal => TXBYPASS8B10B_TXUSRCLK2_dly(2),
            TestSignalName => "TXBYPASS8B10B(2)",
            TestDelay => tisd_TXBYPASS8B10B_TXUSRCLK2(2),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXBYPASS8B10B_TXUSRCLK2_posedge_posedge(2),
            HoldHigh => thold_TXBYPASS8B10B_TXUSRCLK2_posedge_posedge(2),
            SetupLow => tsetup_TXBYPASS8B10B_TXUSRCLK2_negedge_posedge(2),
            HoldLow => thold_TXBYPASS8B10B_TXUSRCLK2_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXBYPASS8B10B_TXUSRCLK2_posedge(3),
            TimingData => Tmkr_TXBYPASS8B10B_TXUSRCLK2_posedge(3),
            TestSignal => TXBYPASS8B10B_TXUSRCLK2_dly(3),
            TestSignalName => "TXBYPASS8B10B(3)",
            TestDelay => tisd_TXBYPASS8B10B_TXUSRCLK2(3),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXBYPASS8B10B_TXUSRCLK2_posedge_posedge(3),
            HoldHigh => thold_TXBYPASS8B10B_TXUSRCLK2_posedge_posedge(3),
            SetupLow => tsetup_TXBYPASS8B10B_TXUSRCLK2_negedge_posedge(3),
            HoldLow => thold_TXBYPASS8B10B_TXUSRCLK2_negedge_posedge(3),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARDISPMODE_TXUSRCLK2_posedge(0),
            TimingData => Tmkr_TXCHARDISPMODE_TXUSRCLK2_posedge(0),
            TestSignal => TXCHARDISPMODE_TXUSRCLK2_dly(0),
            TestSignalName => "TXCHARDISPMODE(0)",
            TestDelay => tisd_TXCHARDISPMODE_TXUSRCLK2(0),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXCHARDISPMODE_TXUSRCLK2_posedge_posedge(0),
            HoldHigh => thold_TXCHARDISPMODE_TXUSRCLK2_posedge_posedge(0),
            SetupLow => tsetup_TXCHARDISPMODE_TXUSRCLK2_negedge_posedge(0),
            HoldLow => thold_TXCHARDISPMODE_TXUSRCLK2_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARDISPMODE_TXUSRCLK2_posedge(1),
            TimingData => Tmkr_TXCHARDISPMODE_TXUSRCLK2_posedge(1),
            TestSignal => TXCHARDISPMODE_TXUSRCLK2_dly(1),
            TestSignalName => "TXCHARDISPMODE(1)",
            TestDelay => tisd_TXCHARDISPMODE_TXUSRCLK2(1),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXCHARDISPMODE_TXUSRCLK2_posedge_posedge(1),
            HoldHigh => thold_TXCHARDISPMODE_TXUSRCLK2_posedge_posedge(1),
            SetupLow => tsetup_TXCHARDISPMODE_TXUSRCLK2_negedge_posedge(1),
            HoldLow => thold_TXCHARDISPMODE_TXUSRCLK2_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARDISPMODE_TXUSRCLK2_posedge(2),
            TimingData => Tmkr_TXCHARDISPMODE_TXUSRCLK2_posedge(2),
            TestSignal => TXCHARDISPMODE_TXUSRCLK2_dly(2),
            TestSignalName => "TXCHARDISPMODE(2)",
            TestDelay => tisd_TXCHARDISPMODE_TXUSRCLK2(2),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXCHARDISPMODE_TXUSRCLK2_posedge_posedge(2),
            HoldHigh => thold_TXCHARDISPMODE_TXUSRCLK2_posedge_posedge(2),
            SetupLow => tsetup_TXCHARDISPMODE_TXUSRCLK2_negedge_posedge(2),
            HoldLow => thold_TXCHARDISPMODE_TXUSRCLK2_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARDISPMODE_TXUSRCLK2_posedge(3),
            TimingData => Tmkr_TXCHARDISPMODE_TXUSRCLK2_posedge(3),
            TestSignal => TXCHARDISPMODE_TXUSRCLK2_dly(3),
            TestSignalName => "TXCHARDISPMODE(3)",
            TestDelay => tisd_TXCHARDISPMODE_TXUSRCLK2(3),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXCHARDISPMODE_TXUSRCLK2_posedge_posedge(3),
            HoldHigh => thold_TXCHARDISPMODE_TXUSRCLK2_posedge_posedge(3),
            SetupLow => tsetup_TXCHARDISPMODE_TXUSRCLK2_negedge_posedge(3),
            HoldLow => thold_TXCHARDISPMODE_TXUSRCLK2_negedge_posedge(3),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARDISPVAL_TXUSRCLK2_posedge(0),
            TimingData => Tmkr_TXCHARDISPVAL_TXUSRCLK2_posedge(0),
            TestSignal => TXCHARDISPVAL_TXUSRCLK2_dly(0),
            TestSignalName => "TXCHARDISPVAL(0)",
            TestDelay => tisd_TXCHARDISPVAL_TXUSRCLK2(0),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXCHARDISPVAL_TXUSRCLK2_posedge_posedge(0),
            HoldHigh => thold_TXCHARDISPVAL_TXUSRCLK2_posedge_posedge(0),
            SetupLow => tsetup_TXCHARDISPVAL_TXUSRCLK2_negedge_posedge(0),
            HoldLow => thold_TXCHARDISPVAL_TXUSRCLK2_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARDISPVAL_TXUSRCLK2_posedge(1),
            TimingData => Tmkr_TXCHARDISPVAL_TXUSRCLK2_posedge(1),
            TestSignal => TXCHARDISPVAL_TXUSRCLK2_dly(1),
            TestSignalName => "TXCHARDISPVAL(1)",
            TestDelay => tisd_TXCHARDISPVAL_TXUSRCLK2(1),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXCHARDISPVAL_TXUSRCLK2_posedge_posedge(1),
            HoldHigh => thold_TXCHARDISPVAL_TXUSRCLK2_posedge_posedge(1),
            SetupLow => tsetup_TXCHARDISPVAL_TXUSRCLK2_negedge_posedge(1),
            HoldLow => thold_TXCHARDISPVAL_TXUSRCLK2_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARDISPVAL_TXUSRCLK2_posedge(2),
            TimingData => Tmkr_TXCHARDISPVAL_TXUSRCLK2_posedge(2),
            TestSignal => TXCHARDISPVAL_TXUSRCLK2_dly(2),
            TestSignalName => "TXCHARDISPVAL(2)",
            TestDelay => tisd_TXCHARDISPVAL_TXUSRCLK2(2),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXCHARDISPVAL_TXUSRCLK2_posedge_posedge(2),
            HoldHigh => thold_TXCHARDISPVAL_TXUSRCLK2_posedge_posedge(2),
            SetupLow => tsetup_TXCHARDISPVAL_TXUSRCLK2_negedge_posedge(2),
            HoldLow => thold_TXCHARDISPVAL_TXUSRCLK2_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARDISPVAL_TXUSRCLK2_posedge(3),
            TimingData => Tmkr_TXCHARDISPVAL_TXUSRCLK2_posedge(3),
            TestSignal => TXCHARDISPVAL_TXUSRCLK2_dly(3),
            TestSignalName => "TXCHARDISPVAL(3)",
            TestDelay => tisd_TXCHARDISPVAL_TXUSRCLK2(3),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXCHARDISPVAL_TXUSRCLK2_posedge_posedge(3),
            HoldHigh => thold_TXCHARDISPVAL_TXUSRCLK2_posedge_posedge(3),
            SetupLow => tsetup_TXCHARDISPVAL_TXUSRCLK2_negedge_posedge(3),
            HoldLow => thold_TXCHARDISPVAL_TXUSRCLK2_negedge_posedge(3),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARISK_TXUSRCLK2_posedge(0),
            TimingData => Tmkr_TXCHARISK_TXUSRCLK2_posedge(0),
            TestSignal => TXCHARISK_TXUSRCLK2_dly(0),
            TestSignalName => "TXCHARISK(0)",
            TestDelay => tisd_TXCHARISK_TXUSRCLK2(0),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXCHARISK_TXUSRCLK2_posedge_posedge(0),
            HoldHigh => thold_TXCHARISK_TXUSRCLK2_posedge_posedge(0),
            SetupLow => tsetup_TXCHARISK_TXUSRCLK2_negedge_posedge(0),
            HoldLow => thold_TXCHARISK_TXUSRCLK2_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARISK_TXUSRCLK2_posedge(1),
            TimingData => Tmkr_TXCHARISK_TXUSRCLK2_posedge(1),
            TestSignal => TXCHARISK_TXUSRCLK2_dly(1),
            TestSignalName => "TXCHARISK(1)",
            TestDelay => tisd_TXCHARISK_TXUSRCLK2(1),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXCHARISK_TXUSRCLK2_posedge_posedge(1),
            HoldHigh => thold_TXCHARISK_TXUSRCLK2_posedge_posedge(1),
            SetupLow => tsetup_TXCHARISK_TXUSRCLK2_negedge_posedge(1),
            HoldLow => thold_TXCHARISK_TXUSRCLK2_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARISK_TXUSRCLK2_posedge(2),
            TimingData => Tmkr_TXCHARISK_TXUSRCLK2_posedge(2),
            TestSignal => TXCHARISK_TXUSRCLK2_dly(2),
            TestSignalName => "TXCHARISK(2)",
            TestDelay => tisd_TXCHARISK_TXUSRCLK2(2),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXCHARISK_TXUSRCLK2_posedge_posedge(2),
            HoldHigh => thold_TXCHARISK_TXUSRCLK2_posedge_posedge(2),
            SetupLow => tsetup_TXCHARISK_TXUSRCLK2_negedge_posedge(2),
            HoldLow => thold_TXCHARISK_TXUSRCLK2_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCHARISK_TXUSRCLK2_posedge(3),
            TimingData => Tmkr_TXCHARISK_TXUSRCLK2_posedge(3),
            TestSignal => TXCHARISK_TXUSRCLK2_dly(3),
            TestSignalName => "TXCHARISK(3)",
            TestDelay => tisd_TXCHARISK_TXUSRCLK2(3),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXCHARISK_TXUSRCLK2_posedge_posedge(3),
            HoldHigh => thold_TXCHARISK_TXUSRCLK2_posedge_posedge(3),
            SetupLow => tsetup_TXCHARISK_TXUSRCLK2_negedge_posedge(3),
            HoldLow => thold_TXCHARISK_TXUSRCLK2_negedge_posedge(3),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCOMINIT_TXUSRCLK2_posedge,
            TimingData => Tmkr_TXCOMINIT_TXUSRCLK2_posedge,
            TestSignal => TXCOMINIT_TXUSRCLK2_dly,
            TestSignalName => "TXCOMINIT",
            TestDelay => tisd_TXCOMINIT_TXUSRCLK2,
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXCOMINIT_TXUSRCLK2_posedge_posedge,
            HoldHigh => thold_TXCOMINIT_TXUSRCLK2_posedge_posedge,
            SetupLow => tsetup_TXCOMINIT_TXUSRCLK2_negedge_posedge,
            HoldLow => thold_TXCOMINIT_TXUSRCLK2_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCOMSAS_TXUSRCLK2_posedge,
            TimingData => Tmkr_TXCOMSAS_TXUSRCLK2_posedge,
            TestSignal => TXCOMSAS_TXUSRCLK2_dly,
            TestSignalName => "TXCOMSAS",
            TestDelay => tisd_TXCOMSAS_TXUSRCLK2,
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXCOMSAS_TXUSRCLK2_posedge_posedge,
            HoldHigh => thold_TXCOMSAS_TXUSRCLK2_posedge_posedge,
            SetupLow => tsetup_TXCOMSAS_TXUSRCLK2_negedge_posedge,
            HoldLow => thold_TXCOMSAS_TXUSRCLK2_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXCOMWAKE_TXUSRCLK2_posedge,
            TimingData => Tmkr_TXCOMWAKE_TXUSRCLK2_posedge,
            TestSignal => TXCOMWAKE_TXUSRCLK2_dly,
            TestSignalName => "TXCOMWAKE",
            TestDelay => tisd_TXCOMWAKE_TXUSRCLK2,
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXCOMWAKE_TXUSRCLK2_posedge_posedge,
            HoldHigh => thold_TXCOMWAKE_TXUSRCLK2_posedge_posedge,
            SetupLow => tsetup_TXCOMWAKE_TXUSRCLK2_negedge_posedge,
            HoldLow => thold_TXCOMWAKE_TXUSRCLK2_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(0),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(0),
            TestSignal => TXDATA_TXUSRCLK2_dly(0),
            TestSignalName => "TXDATA(0)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(0),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(0),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(0),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(0),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(1),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(1),
            TestSignal => TXDATA_TXUSRCLK2_dly(1),
            TestSignalName => "TXDATA(1)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(1),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(1),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(1),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(1),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(10),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(10),
            TestSignal => TXDATA_TXUSRCLK2_dly(10),
            TestSignalName => "TXDATA(10)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(10),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(10),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(10),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(10),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(10),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(11),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(11),
            TestSignal => TXDATA_TXUSRCLK2_dly(11),
            TestSignalName => "TXDATA(11)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(11),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(11),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(11),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(11),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(11),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(12),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(12),
            TestSignal => TXDATA_TXUSRCLK2_dly(12),
            TestSignalName => "TXDATA(12)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(12),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(12),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(12),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(12),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(12),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(13),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(13),
            TestSignal => TXDATA_TXUSRCLK2_dly(13),
            TestSignalName => "TXDATA(13)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(13),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(13),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(13),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(13),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(13),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(14),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(14),
            TestSignal => TXDATA_TXUSRCLK2_dly(14),
            TestSignalName => "TXDATA(14)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(14),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(14),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(14),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(14),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(14),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(15),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(15),
            TestSignal => TXDATA_TXUSRCLK2_dly(15),
            TestSignalName => "TXDATA(15)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(15),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(15),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(15),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(15),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(15),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(16),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(16),
            TestSignal => TXDATA_TXUSRCLK2_dly(16),
            TestSignalName => "TXDATA(16)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(16),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(16),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(16),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(16),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(16),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(17),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(17),
            TestSignal => TXDATA_TXUSRCLK2_dly(17),
            TestSignalName => "TXDATA(17)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(17),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(17),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(17),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(17),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(17),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(18),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(18),
            TestSignal => TXDATA_TXUSRCLK2_dly(18),
            TestSignalName => "TXDATA(18)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(18),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(18),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(18),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(18),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(18),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(19),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(19),
            TestSignal => TXDATA_TXUSRCLK2_dly(19),
            TestSignalName => "TXDATA(19)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(19),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(19),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(19),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(19),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(19),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(2),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(2),
            TestSignal => TXDATA_TXUSRCLK2_dly(2),
            TestSignalName => "TXDATA(2)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(2),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(2),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(2),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(2),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(20),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(20),
            TestSignal => TXDATA_TXUSRCLK2_dly(20),
            TestSignalName => "TXDATA(20)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(20),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(20),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(20),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(20),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(20),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(21),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(21),
            TestSignal => TXDATA_TXUSRCLK2_dly(21),
            TestSignalName => "TXDATA(21)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(21),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(21),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(21),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(21),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(21),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(22),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(22),
            TestSignal => TXDATA_TXUSRCLK2_dly(22),
            TestSignalName => "TXDATA(22)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(22),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(22),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(22),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(22),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(22),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(23),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(23),
            TestSignal => TXDATA_TXUSRCLK2_dly(23),
            TestSignalName => "TXDATA(23)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(23),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(23),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(23),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(23),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(23),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(24),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(24),
            TestSignal => TXDATA_TXUSRCLK2_dly(24),
            TestSignalName => "TXDATA(24)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(24),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(24),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(24),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(24),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(24),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(25),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(25),
            TestSignal => TXDATA_TXUSRCLK2_dly(25),
            TestSignalName => "TXDATA(25)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(25),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(25),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(25),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(25),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(25),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(26),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(26),
            TestSignal => TXDATA_TXUSRCLK2_dly(26),
            TestSignalName => "TXDATA(26)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(26),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(26),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(26),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(26),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(26),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(27),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(27),
            TestSignal => TXDATA_TXUSRCLK2_dly(27),
            TestSignalName => "TXDATA(27)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(27),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(27),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(27),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(27),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(27),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(28),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(28),
            TestSignal => TXDATA_TXUSRCLK2_dly(28),
            TestSignalName => "TXDATA(28)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(28),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(28),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(28),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(28),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(28),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(29),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(29),
            TestSignal => TXDATA_TXUSRCLK2_dly(29),
            TestSignalName => "TXDATA(29)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(29),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(29),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(29),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(29),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(29),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(3),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(3),
            TestSignal => TXDATA_TXUSRCLK2_dly(3),
            TestSignalName => "TXDATA(3)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(3),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(3),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(3),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(3),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(3),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(30),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(30),
            TestSignal => TXDATA_TXUSRCLK2_dly(30),
            TestSignalName => "TXDATA(30)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(30),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(30),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(30),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(30),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(30),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(31),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(31),
            TestSignal => TXDATA_TXUSRCLK2_dly(31),
            TestSignalName => "TXDATA(31)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(31),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(31),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(31),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(31),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(31),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(4),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(4),
            TestSignal => TXDATA_TXUSRCLK2_dly(4),
            TestSignalName => "TXDATA(4)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(4),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(4),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(4),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(4),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(4),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(5),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(5),
            TestSignal => TXDATA_TXUSRCLK2_dly(5),
            TestSignalName => "TXDATA(5)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(5),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(5),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(5),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(5),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(5),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(6),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(6),
            TestSignal => TXDATA_TXUSRCLK2_dly(6),
            TestSignalName => "TXDATA(6)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(6),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(6),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(6),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(6),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(6),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(7),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(7),
            TestSignal => TXDATA_TXUSRCLK2_dly(7),
            TestSignalName => "TXDATA(7)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(7),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(7),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(7),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(7),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(7),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(8),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(8),
            TestSignal => TXDATA_TXUSRCLK2_dly(8),
            TestSignalName => "TXDATA(8)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(8),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(8),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(8),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(8),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(8),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDATA_TXUSRCLK2_posedge(9),
            TimingData => Tmkr_TXDATA_TXUSRCLK2_posedge(9),
            TestSignal => TXDATA_TXUSRCLK2_dly(9),
            TestSignalName => "TXDATA(9)",
            TestDelay => tisd_TXDATA_TXUSRCLK2(9),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDATA_TXUSRCLK2_posedge_posedge(9),
            HoldHigh => thold_TXDATA_TXUSRCLK2_posedge_posedge(9),
            SetupLow => tsetup_TXDATA_TXUSRCLK2_negedge_posedge(9),
            HoldLow => thold_TXDATA_TXUSRCLK2_negedge_posedge(9),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXDETECTRX_TXUSRCLK2_posedge,
            TimingData => Tmkr_TXDETECTRX_TXUSRCLK2_posedge,
            TestSignal => TXDETECTRX_TXUSRCLK2_dly,
            TestSignalName => "TXDETECTRX",
            TestDelay => tisd_TXDETECTRX_TXUSRCLK2,
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXDETECTRX_TXUSRCLK2_posedge_posedge,
            HoldHigh => thold_TXDETECTRX_TXUSRCLK2_posedge_posedge,
            SetupLow => tsetup_TXDETECTRX_TXUSRCLK2_negedge_posedge,
            HoldLow => thold_TXDETECTRX_TXUSRCLK2_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXELECIDLE_TXUSRCLK2_posedge,
            TimingData => Tmkr_TXELECIDLE_TXUSRCLK2_posedge,
            TestSignal => TXELECIDLE_TXUSRCLK2_dly,
            TestSignalName => "TXELECIDLE",
            TestDelay => tisd_TXELECIDLE_TXUSRCLK2,
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXELECIDLE_TXUSRCLK2_posedge_posedge,
            HoldHigh => thold_TXELECIDLE_TXUSRCLK2_posedge_posedge,
            SetupLow => tsetup_TXELECIDLE_TXUSRCLK2_negedge_posedge,
            HoldLow => thold_TXELECIDLE_TXUSRCLK2_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXENC8B10BUSE_TXUSRCLK2_posedge,
            TimingData => Tmkr_TXENC8B10BUSE_TXUSRCLK2_posedge,
            TestSignal => TXENC8B10BUSE_TXUSRCLK2_dly,
            TestSignalName => "TXENC8B10BUSE",
            TestDelay => tisd_TXENC8B10BUSE_TXUSRCLK2,
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXENC8B10BUSE_TXUSRCLK2_posedge_posedge,
            HoldHigh => thold_TXENC8B10BUSE_TXUSRCLK2_posedge_posedge,
            SetupLow => tsetup_TXENC8B10BUSE_TXUSRCLK2_negedge_posedge,
            HoldLow => thold_TXENC8B10BUSE_TXUSRCLK2_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXENPRBSTST_TXUSRCLK2_posedge(0),
            TimingData => Tmkr_TXENPRBSTST_TXUSRCLK2_posedge(0),
            TestSignal => TXENPRBSTST_TXUSRCLK2_dly(0),
            TestSignalName => "TXENPRBSTST(0)",
            TestDelay => tisd_TXENPRBSTST_TXUSRCLK2(0),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXENPRBSTST_TXUSRCLK2_posedge_posedge(0),
            HoldHigh => thold_TXENPRBSTST_TXUSRCLK2_posedge_posedge(0),
            SetupLow => tsetup_TXENPRBSTST_TXUSRCLK2_negedge_posedge(0),
            HoldLow => thold_TXENPRBSTST_TXUSRCLK2_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXENPRBSTST_TXUSRCLK2_posedge(1),
            TimingData => Tmkr_TXENPRBSTST_TXUSRCLK2_posedge(1),
            TestSignal => TXENPRBSTST_TXUSRCLK2_dly(1),
            TestSignalName => "TXENPRBSTST(1)",
            TestDelay => tisd_TXENPRBSTST_TXUSRCLK2(1),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXENPRBSTST_TXUSRCLK2_posedge_posedge(1),
            HoldHigh => thold_TXENPRBSTST_TXUSRCLK2_posedge_posedge(1),
            SetupLow => tsetup_TXENPRBSTST_TXUSRCLK2_negedge_posedge(1),
            HoldLow => thold_TXENPRBSTST_TXUSRCLK2_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXENPRBSTST_TXUSRCLK2_posedge(2),
            TimingData => Tmkr_TXENPRBSTST_TXUSRCLK2_posedge(2),
            TestSignal => TXENPRBSTST_TXUSRCLK2_dly(2),
            TestSignalName => "TXENPRBSTST(2)",
            TestDelay => tisd_TXENPRBSTST_TXUSRCLK2(2),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXENPRBSTST_TXUSRCLK2_posedge_posedge(2),
            HoldHigh => thold_TXENPRBSTST_TXUSRCLK2_posedge_posedge(2),
            SetupLow => tsetup_TXENPRBSTST_TXUSRCLK2_negedge_posedge(2),
            HoldLow => thold_TXENPRBSTST_TXUSRCLK2_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXHEADER_TXUSRCLK2_posedge(0),
            TimingData => Tmkr_TXHEADER_TXUSRCLK2_posedge(0),
            TestSignal => TXHEADER_TXUSRCLK2_dly(0),
            TestSignalName => "TXHEADER(0)",
            TestDelay => tisd_TXHEADER_TXUSRCLK2(0),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXHEADER_TXUSRCLK2_posedge_posedge(0),
            HoldHigh => thold_TXHEADER_TXUSRCLK2_posedge_posedge(0),
            SetupLow => tsetup_TXHEADER_TXUSRCLK2_negedge_posedge(0),
            HoldLow => thold_TXHEADER_TXUSRCLK2_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXHEADER_TXUSRCLK2_posedge(1),
            TimingData => Tmkr_TXHEADER_TXUSRCLK2_posedge(1),
            TestSignal => TXHEADER_TXUSRCLK2_dly(1),
            TestSignalName => "TXHEADER(1)",
            TestDelay => tisd_TXHEADER_TXUSRCLK2(1),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXHEADER_TXUSRCLK2_posedge_posedge(1),
            HoldHigh => thold_TXHEADER_TXUSRCLK2_posedge_posedge(1),
            SetupLow => tsetup_TXHEADER_TXUSRCLK2_negedge_posedge(1),
            HoldLow => thold_TXHEADER_TXUSRCLK2_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXHEADER_TXUSRCLK2_posedge(2),
            TimingData => Tmkr_TXHEADER_TXUSRCLK2_posedge(2),
            TestSignal => TXHEADER_TXUSRCLK2_dly(2),
            TestSignalName => "TXHEADER(2)",
            TestDelay => tisd_TXHEADER_TXUSRCLK2(2),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXHEADER_TXUSRCLK2_posedge_posedge(2),
            HoldHigh => thold_TXHEADER_TXUSRCLK2_posedge_posedge(2),
            SetupLow => tsetup_TXHEADER_TXUSRCLK2_negedge_posedge(2),
            HoldLow => thold_TXHEADER_TXUSRCLK2_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXINHIBIT_TXUSRCLK2_posedge,
            TimingData => Tmkr_TXINHIBIT_TXUSRCLK2_posedge,
            TestSignal => TXINHIBIT_TXUSRCLK2_dly,
            TestSignalName => "TXINHIBIT",
            TestDelay => tisd_TXINHIBIT_TXUSRCLK2,
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXINHIBIT_TXUSRCLK2_posedge_posedge,
            HoldHigh => thold_TXINHIBIT_TXUSRCLK2_posedge_posedge,
            SetupLow => tsetup_TXINHIBIT_TXUSRCLK2_negedge_posedge,
            HoldLow => thold_TXINHIBIT_TXUSRCLK2_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXPOLARITY_TXUSRCLK2_posedge,
            TimingData => Tmkr_TXPOLARITY_TXUSRCLK2_posedge,
            TestSignal => TXPOLARITY_TXUSRCLK2_dly,
            TestSignalName => "TXPOLARITY",
            TestDelay => tisd_TXPOLARITY_TXUSRCLK2,
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXPOLARITY_TXUSRCLK2_posedge_posedge,
            HoldHigh => thold_TXPOLARITY_TXUSRCLK2_posedge_posedge,
            SetupLow => tsetup_TXPOLARITY_TXUSRCLK2_negedge_posedge,
            HoldLow => thold_TXPOLARITY_TXUSRCLK2_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXPOWERDOWN_TXUSRCLK2_posedge(0),
            TimingData => Tmkr_TXPOWERDOWN_TXUSRCLK2_posedge(0),
            TestSignal => TXPOWERDOWN_TXUSRCLK2_dly(0),
            TestSignalName => "TXPOWERDOWN(0)",
            TestDelay => tisd_TXPOWERDOWN_TXUSRCLK2(0),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXPOWERDOWN_TXUSRCLK2_posedge_posedge(0),
            HoldHigh => thold_TXPOWERDOWN_TXUSRCLK2_posedge_posedge(0),
            SetupLow => tsetup_TXPOWERDOWN_TXUSRCLK2_negedge_posedge(0),
            HoldLow => thold_TXPOWERDOWN_TXUSRCLK2_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXPOWERDOWN_TXUSRCLK2_posedge(1),
            TimingData => Tmkr_TXPOWERDOWN_TXUSRCLK2_posedge(1),
            TestSignal => TXPOWERDOWN_TXUSRCLK2_dly(1),
            TestSignalName => "TXPOWERDOWN(1)",
            TestDelay => tisd_TXPOWERDOWN_TXUSRCLK2(1),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXPOWERDOWN_TXUSRCLK2_posedge_posedge(1),
            HoldHigh => thold_TXPOWERDOWN_TXUSRCLK2_posedge_posedge(1),
            SetupLow => tsetup_TXPOWERDOWN_TXUSRCLK2_negedge_posedge(1),
            HoldLow => thold_TXPOWERDOWN_TXUSRCLK2_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXPRBSFORCEERR_TXUSRCLK2_posedge,
            TimingData => Tmkr_TXPRBSFORCEERR_TXUSRCLK2_posedge,
            TestSignal => TXPRBSFORCEERR_TXUSRCLK2_dly,
            TestSignalName => "TXPRBSFORCEERR",
            TestDelay => tisd_TXPRBSFORCEERR_TXUSRCLK2,
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXPRBSFORCEERR_TXUSRCLK2_posedge_posedge,
            HoldHigh => thold_TXPRBSFORCEERR_TXUSRCLK2_posedge_posedge,
            SetupLow => tsetup_TXPRBSFORCEERR_TXUSRCLK2_negedge_posedge,
            HoldLow => thold_TXPRBSFORCEERR_TXUSRCLK2_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXRATE_TXUSRCLK2_posedge(0),
            TimingData => Tmkr_TXRATE_TXUSRCLK2_posedge(0),
            TestSignal => TXRATE_TXUSRCLK2_dly(0),
            TestSignalName => "TXRATE(0)",
            TestDelay => tisd_TXRATE_TXUSRCLK2(0),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXRATE_TXUSRCLK2_posedge_posedge(0),
            HoldHigh => thold_TXRATE_TXUSRCLK2_posedge_posedge(0),
            SetupLow => tsetup_TXRATE_TXUSRCLK2_negedge_posedge(0),
            HoldLow => thold_TXRATE_TXUSRCLK2_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXRATE_TXUSRCLK2_posedge(1),
            TimingData => Tmkr_TXRATE_TXUSRCLK2_posedge(1),
            TestSignal => TXRATE_TXUSRCLK2_dly(1),
            TestSignalName => "TXRATE(1)",
            TestDelay => tisd_TXRATE_TXUSRCLK2(1),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXRATE_TXUSRCLK2_posedge_posedge(1),
            HoldHigh => thold_TXRATE_TXUSRCLK2_posedge_posedge(1),
            SetupLow => tsetup_TXRATE_TXUSRCLK2_negedge_posedge(1),
            HoldLow => thold_TXRATE_TXUSRCLK2_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXSEQUENCE_TXUSRCLK2_posedge(0),
            TimingData => Tmkr_TXSEQUENCE_TXUSRCLK2_posedge(0),
            TestSignal => TXSEQUENCE_TXUSRCLK2_dly(0),
            TestSignalName => "TXSEQUENCE(0)",
            TestDelay => tisd_TXSEQUENCE_TXUSRCLK2(0),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXSEQUENCE_TXUSRCLK2_posedge_posedge(0),
            HoldHigh => thold_TXSEQUENCE_TXUSRCLK2_posedge_posedge(0),
            SetupLow => tsetup_TXSEQUENCE_TXUSRCLK2_negedge_posedge(0),
            HoldLow => thold_TXSEQUENCE_TXUSRCLK2_negedge_posedge(0),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXSEQUENCE_TXUSRCLK2_posedge(1),
            TimingData => Tmkr_TXSEQUENCE_TXUSRCLK2_posedge(1),
            TestSignal => TXSEQUENCE_TXUSRCLK2_dly(1),
            TestSignalName => "TXSEQUENCE(1)",
            TestDelay => tisd_TXSEQUENCE_TXUSRCLK2(1),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXSEQUENCE_TXUSRCLK2_posedge_posedge(1),
            HoldHigh => thold_TXSEQUENCE_TXUSRCLK2_posedge_posedge(1),
            SetupLow => tsetup_TXSEQUENCE_TXUSRCLK2_negedge_posedge(1),
            HoldLow => thold_TXSEQUENCE_TXUSRCLK2_negedge_posedge(1),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXSEQUENCE_TXUSRCLK2_posedge(2),
            TimingData => Tmkr_TXSEQUENCE_TXUSRCLK2_posedge(2),
            TestSignal => TXSEQUENCE_TXUSRCLK2_dly(2),
            TestSignalName => "TXSEQUENCE(2)",
            TestDelay => tisd_TXSEQUENCE_TXUSRCLK2(2),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXSEQUENCE_TXUSRCLK2_posedge_posedge(2),
            HoldHigh => thold_TXSEQUENCE_TXUSRCLK2_posedge_posedge(2),
            SetupLow => tsetup_TXSEQUENCE_TXUSRCLK2_negedge_posedge(2),
            HoldLow => thold_TXSEQUENCE_TXUSRCLK2_negedge_posedge(2),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXSEQUENCE_TXUSRCLK2_posedge(3),
            TimingData => Tmkr_TXSEQUENCE_TXUSRCLK2_posedge(3),
            TestSignal => TXSEQUENCE_TXUSRCLK2_dly(3),
            TestSignalName => "TXSEQUENCE(3)",
            TestDelay => tisd_TXSEQUENCE_TXUSRCLK2(3),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXSEQUENCE_TXUSRCLK2_posedge_posedge(3),
            HoldHigh => thold_TXSEQUENCE_TXUSRCLK2_posedge_posedge(3),
            SetupLow => tsetup_TXSEQUENCE_TXUSRCLK2_negedge_posedge(3),
            HoldLow => thold_TXSEQUENCE_TXUSRCLK2_negedge_posedge(3),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXSEQUENCE_TXUSRCLK2_posedge(4),
            TimingData => Tmkr_TXSEQUENCE_TXUSRCLK2_posedge(4),
            TestSignal => TXSEQUENCE_TXUSRCLK2_dly(4),
            TestSignalName => "TXSEQUENCE(4)",
            TestDelay => tisd_TXSEQUENCE_TXUSRCLK2(4),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXSEQUENCE_TXUSRCLK2_posedge_posedge(4),
            HoldHigh => thold_TXSEQUENCE_TXUSRCLK2_posedge_posedge(4),
            SetupLow => tsetup_TXSEQUENCE_TXUSRCLK2_negedge_posedge(4),
            HoldLow => thold_TXSEQUENCE_TXUSRCLK2_negedge_posedge(4),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXSEQUENCE_TXUSRCLK2_posedge(5),
            TimingData => Tmkr_TXSEQUENCE_TXUSRCLK2_posedge(5),
            TestSignal => TXSEQUENCE_TXUSRCLK2_dly(5),
            TestSignalName => "TXSEQUENCE(5)",
            TestDelay => tisd_TXSEQUENCE_TXUSRCLK2(5),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXSEQUENCE_TXUSRCLK2_posedge_posedge(5),
            HoldHigh => thold_TXSEQUENCE_TXUSRCLK2_posedge_posedge(5),
            SetupLow => tsetup_TXSEQUENCE_TXUSRCLK2_negedge_posedge(5),
            HoldLow => thold_TXSEQUENCE_TXUSRCLK2_negedge_posedge(5),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXSEQUENCE_TXUSRCLK2_posedge(6),
            TimingData => Tmkr_TXSEQUENCE_TXUSRCLK2_posedge(6),
            TestSignal => TXSEQUENCE_TXUSRCLK2_dly(6),
            TestSignalName => "TXSEQUENCE(6)",
            TestDelay => tisd_TXSEQUENCE_TXUSRCLK2(6),
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXSEQUENCE_TXUSRCLK2_posedge_posedge(6),
            HoldHigh => thold_TXSEQUENCE_TXUSRCLK2_posedge_posedge(6),
            SetupLow => tsetup_TXSEQUENCE_TXUSRCLK2_negedge_posedge(6),
            HoldLow => thold_TXSEQUENCE_TXUSRCLK2_negedge_posedge(6),
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_TXSTARTSEQ_TXUSRCLK2_posedge,
            TimingData => Tmkr_TXSTARTSEQ_TXUSRCLK2_posedge,
            TestSignal => TXSTARTSEQ_TXUSRCLK2_dly,
            TestSignalName => "TXSTARTSEQ",
            TestDelay => tisd_TXSTARTSEQ_TXUSRCLK2,
            RefSignal => TXUSRCLK2_dly,
            RefSignalName => "TXUSRCLK2",
            RefDelay => ticd_TXUSRCLK2,
            SetupHigh => tsetup_TXSTARTSEQ_TXUSRCLK2_posedge_posedge,
            HoldHigh => thold_TXSTARTSEQ_TXUSRCLK2_posedge_posedge,
            SetupLow => tsetup_TXSTARTSEQ_TXUSRCLK2_negedge_posedge,
            HoldLow => thold_TXSTARTSEQ_TXUSRCLK2_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalSetupHoldCheck
          (
            Violation => Tviol_USRCODEERR_RXUSRCLK2_posedge,
            TimingData => Tmkr_USRCODEERR_RXUSRCLK2_posedge,
            TestSignal => USRCODEERR_RXUSRCLK2_dly,
            TestSignalName => "USRCODEERR",
            TestDelay => tisd_USRCODEERR_RXUSRCLK2,
            RefSignal => RXUSRCLK2_dly,
            RefSignalName => "RXUSRCLK2",
            RefDelay => ticd_RXUSRCLK2,
            SetupHigh => tsetup_USRCODEERR_RXUSRCLK2_posedge_posedge,
            HoldHigh => thold_USRCODEERR_RXUSRCLK2_posedge_posedge,
            SetupLow => tsetup_USRCODEERR_RXUSRCLK2_negedge_posedge,
            HoldLow => thold_USRCODEERR_RXUSRCLK2_negedge_posedge,
            CheckEnabled   => TRUE,
            RefTransition  => 'R',
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
        end if;
          VitalPathDelay01
          (
            OutSignal     => COMFINISH,
            GlitchData    => COMFINISH_GlitchData,
            OutSignalName => "COMFINISH",
            OutTemp       => COMFINISH_out,
            Paths       => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_COMFINISH,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => COMINITDET,
            GlitchData    => COMINITDET_GlitchData,
            OutSignalName => "COMINITDET",
            OutTemp       => COMINITDET_out,
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_COMINITDET,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => COMSASDET,
            GlitchData    => COMSASDET_GlitchData,
            OutSignalName => "COMSASDET",
            OutTemp       => COMSASDET_out,
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_COMSASDET,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => COMWAKEDET,
            GlitchData    => COMWAKEDET_GlitchData,
            OutSignalName => "COMWAKEDET",
            OutTemp       => COMWAKEDET_out,
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_COMWAKEDET,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFECLKDLYADJMON(0),
            GlitchData    => DFECLKDLYADJMON0_GlitchData,
            OutSignalName => "DFECLKDLYADJMON(0)",
            OutTemp       => DFECLKDLYADJMON_out(0),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFECLKDLYADJMON(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFECLKDLYADJMON(1),
            GlitchData    => DFECLKDLYADJMON1_GlitchData,
            OutSignalName => "DFECLKDLYADJMON(1)",
            OutTemp       => DFECLKDLYADJMON_out(1),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFECLKDLYADJMON(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFECLKDLYADJMON(2),
            GlitchData    => DFECLKDLYADJMON2_GlitchData,
            OutSignalName => "DFECLKDLYADJMON(2)",
            OutTemp       => DFECLKDLYADJMON_out(2),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFECLKDLYADJMON(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFECLKDLYADJMON(3),
            GlitchData    => DFECLKDLYADJMON3_GlitchData,
            OutSignalName => "DFECLKDLYADJMON(3)",
            OutTemp       => DFECLKDLYADJMON_out(3),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFECLKDLYADJMON(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFECLKDLYADJMON(4),
            GlitchData    => DFECLKDLYADJMON4_GlitchData,
            OutSignalName => "DFECLKDLYADJMON(4)",
            OutTemp       => DFECLKDLYADJMON_out(4),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFECLKDLYADJMON(4),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFECLKDLYADJMON(5),
            GlitchData    => DFECLKDLYADJMON5_GlitchData,
            OutSignalName => "DFECLKDLYADJMON(5)",
            OutTemp       => DFECLKDLYADJMON_out(5),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFECLKDLYADJMON(5),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFEEYEDACMON(0),
            GlitchData    => DFEEYEDACMON0_GlitchData,
            OutSignalName => "DFEEYEDACMON(0)",
            OutTemp       => DFEEYEDACMON_out(0),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFEEYEDACMON(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFEEYEDACMON(1),
            GlitchData    => DFEEYEDACMON1_GlitchData,
            OutSignalName => "DFEEYEDACMON(1)",
            OutTemp       => DFEEYEDACMON_out(1),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFEEYEDACMON(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFEEYEDACMON(2),
            GlitchData    => DFEEYEDACMON2_GlitchData,
            OutSignalName => "DFEEYEDACMON(2)",
            OutTemp       => DFEEYEDACMON_out(2),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFEEYEDACMON(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFEEYEDACMON(3),
            GlitchData    => DFEEYEDACMON3_GlitchData,
            OutSignalName => "DFEEYEDACMON(3)",
            OutTemp       => DFEEYEDACMON_out(3),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFEEYEDACMON(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFEEYEDACMON(4),
            GlitchData    => DFEEYEDACMON4_GlitchData,
            OutSignalName => "DFEEYEDACMON(4)",
            OutTemp       => DFEEYEDACMON_out(4),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFEEYEDACMON(4),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFESENSCAL(0),
            GlitchData    => DFESENSCAL0_GlitchData,
            OutSignalName => "DFESENSCAL(0)",
            OutTemp       => DFESENSCAL_out(0),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFESENSCAL(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFESENSCAL(1),
            GlitchData    => DFESENSCAL1_GlitchData,
            OutSignalName => "DFESENSCAL(1)",
            OutTemp       => DFESENSCAL_out(1),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFESENSCAL(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFESENSCAL(2),
            GlitchData    => DFESENSCAL2_GlitchData,
            OutSignalName => "DFESENSCAL(2)",
            OutTemp       => DFESENSCAL_out(2),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFESENSCAL(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFETAP1MONITOR(0),
            GlitchData    => DFETAP1MONITOR0_GlitchData,
            OutSignalName => "DFETAP1MONITOR(0)",
            OutTemp       => DFETAP1MONITOR_out(0),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFETAP1MONITOR(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFETAP1MONITOR(1),
            GlitchData    => DFETAP1MONITOR1_GlitchData,
            OutSignalName => "DFETAP1MONITOR(1)",
            OutTemp       => DFETAP1MONITOR_out(1),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFETAP1MONITOR(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFETAP1MONITOR(2),
            GlitchData    => DFETAP1MONITOR2_GlitchData,
            OutSignalName => "DFETAP1MONITOR(2)",
            OutTemp       => DFETAP1MONITOR_out(2),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFETAP1MONITOR(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFETAP1MONITOR(3),
            GlitchData    => DFETAP1MONITOR3_GlitchData,
            OutSignalName => "DFETAP1MONITOR(3)",
            OutTemp       => DFETAP1MONITOR_out(3),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFETAP1MONITOR(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFETAP1MONITOR(4),
            GlitchData    => DFETAP1MONITOR4_GlitchData,
            OutSignalName => "DFETAP1MONITOR(4)",
            OutTemp       => DFETAP1MONITOR_out(4),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFETAP1MONITOR(4),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFETAP2MONITOR(0),
            GlitchData    => DFETAP2MONITOR0_GlitchData,
            OutSignalName => "DFETAP2MONITOR(0)",
            OutTemp       => DFETAP2MONITOR_out(0),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFETAP2MONITOR(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFETAP2MONITOR(1),
            GlitchData    => DFETAP2MONITOR1_GlitchData,
            OutSignalName => "DFETAP2MONITOR(1)",
            OutTemp       => DFETAP2MONITOR_out(1),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFETAP2MONITOR(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFETAP2MONITOR(2),
            GlitchData    => DFETAP2MONITOR2_GlitchData,
            OutSignalName => "DFETAP2MONITOR(2)",
            OutTemp       => DFETAP2MONITOR_out(2),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFETAP2MONITOR(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFETAP2MONITOR(3),
            GlitchData    => DFETAP2MONITOR3_GlitchData,
            OutSignalName => "DFETAP2MONITOR(3)",
            OutTemp       => DFETAP2MONITOR_out(3),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFETAP2MONITOR(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFETAP2MONITOR(4),
            GlitchData    => DFETAP2MONITOR4_GlitchData,
            OutSignalName => "DFETAP2MONITOR(4)",
            OutTemp       => DFETAP2MONITOR_out(4),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFETAP2MONITOR(4),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFETAP3MONITOR(0),
            GlitchData    => DFETAP3MONITOR0_GlitchData,
            OutSignalName => "DFETAP3MONITOR(0)",
            OutTemp       => DFETAP3MONITOR_out(0),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFETAP3MONITOR(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFETAP3MONITOR(1),
            GlitchData    => DFETAP3MONITOR1_GlitchData,
            OutSignalName => "DFETAP3MONITOR(1)",
            OutTemp       => DFETAP3MONITOR_out(1),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFETAP3MONITOR(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFETAP3MONITOR(2),
            GlitchData    => DFETAP3MONITOR2_GlitchData,
            OutSignalName => "DFETAP3MONITOR(2)",
            OutTemp       => DFETAP3MONITOR_out(2),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFETAP3MONITOR(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFETAP3MONITOR(3),
            GlitchData    => DFETAP3MONITOR3_GlitchData,
            OutSignalName => "DFETAP3MONITOR(3)",
            OutTemp       => DFETAP3MONITOR_out(3),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFETAP3MONITOR(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFETAP4MONITOR(0),
            GlitchData    => DFETAP4MONITOR0_GlitchData,
            OutSignalName => "DFETAP4MONITOR(0)",
            OutTemp       => DFETAP4MONITOR_out(0),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFETAP4MONITOR(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFETAP4MONITOR(1),
            GlitchData    => DFETAP4MONITOR1_GlitchData,
            OutSignalName => "DFETAP4MONITOR(1)",
            OutTemp       => DFETAP4MONITOR_out(1),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFETAP4MONITOR(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFETAP4MONITOR(2),
            GlitchData    => DFETAP4MONITOR2_GlitchData,
            OutSignalName => "DFETAP4MONITOR(2)",
            OutTemp       => DFETAP4MONITOR_out(2),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFETAP4MONITOR(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => DFETAP4MONITOR(3),
            GlitchData    => DFETAP4MONITOR3_GlitchData,
            OutSignalName => "DFETAP4MONITOR(3)",
            OutTemp       => DFETAP4MONITOR_out(3),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_DFETAP4MONITOR(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
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
            OutSignal     => MGTREFCLKFAB(0),
            GlitchData    => MGTREFCLKFAB0_GlitchData,
            OutSignalName => "MGTREFCLKFAB(0)",
            OutTemp       => MGTREFCLKFAB_out(0),
            Paths       => (0 => (MGTREFCLKRX_dly(0)'last_event, tpd_MGTREFCLKRX_MGTREFCLKFAB(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
        VitalPathDelay01
          (
            OutSignal     => MGTREFCLKFAB(1),
            GlitchData    => MGTREFCLKFAB1_GlitchData,
            OutSignalName => "MGTREFCLKFAB(1)",
            OutTemp       => MGTREFCLKFAB_out(1),
            Paths       => (0 => (MGTREFCLKRX_dly(0)'last_event, tpd_MGTREFCLKRX_MGTREFCLKFAB(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
        VitalPathDelay01
          (
            OutSignal     => MGTREFCLKFAB(0),
            GlitchData    => MGTREFCLKFAB0_GlitchData,
            OutSignalName => "MGTREFCLKFAB(0)",
            OutTemp       => MGTREFCLKFAB_out(0),
            Paths       => (0 => (MGTREFCLKRX_dly(1)'last_event, tpd_MGTREFCLKRX_MGTREFCLKFAB(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
        VitalPathDelay01
          (
            OutSignal     => MGTREFCLKFAB(1),
            GlitchData    => MGTREFCLKFAB1_GlitchData,
            OutSignalName => "MGTREFCLKFAB(1)",
            OutTemp       => MGTREFCLKFAB_out(1),
            Paths       => (0 => (MGTREFCLKRX_dly(1)'last_event, tpd_MGTREFCLKRX_MGTREFCLKFAB(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => MGTREFCLKFAB(0),
            GlitchData    => MGTREFCLKFAB0_GlitchData,
            OutSignalName => "MGTREFCLKFAB(0)",
            OutTemp       => MGTREFCLKFAB_out(0),
            Paths       => (0 => (MGTREFCLKTX_dly(0)'last_event, tpd_MGTREFCLKTX_MGTREFCLKFAB(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
         VitalPathDelay01
          (
            OutSignal     => MGTREFCLKFAB(1),
            GlitchData    => MGTREFCLKFAB1_GlitchData,
            OutSignalName => "MGTREFCLKFAB(1)",
            OutTemp       => MGTREFCLKFAB_out(1),
            Paths       => (0 => (MGTREFCLKTX_dly(0)'last_event, tpd_MGTREFCLKTX_MGTREFCLKFAB(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
         VitalPathDelay01
          (
            OutSignal     => MGTREFCLKFAB(0),
            GlitchData    => MGTREFCLKFAB0_GlitchData,
            OutSignalName => "MGTREFCLKFAB(0)",
            OutTemp       => MGTREFCLKFAB_out(0),
            Paths       => (0 => (MGTREFCLKTX_dly(1)'last_event, tpd_MGTREFCLKTX_MGTREFCLKFAB(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
         VitalPathDelay01
          (
            OutSignal     => MGTREFCLKFAB(1),
            GlitchData    => MGTREFCLKFAB1_GlitchData,
            OutSignalName => "MGTREFCLKFAB(1)",
            OutTemp       => MGTREFCLKFAB_out(1),
            Paths       => (0 => (MGTREFCLKTX_dly(1)'last_event, tpd_MGTREFCLKTX_MGTREFCLKFAB(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => MGTREFCLKFAB(0),
            GlitchData    => MGTREFCLKFAB0_GlitchData,
            OutSignalName => "MGTREFCLKFAB(0)",
            OutTemp       => MGTREFCLKFAB_out(0),
            Paths       => (0 => (NORTHREFCLKRX_dly(0)'last_event, tpd_NORTHREFCLKRX_MGTREFCLKFAB(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
        VitalPathDelay01
          (
            OutSignal     => MGTREFCLKFAB(1),
            GlitchData    => MGTREFCLKFAB1_GlitchData,
            OutSignalName => "MGTREFCLKFAB(1)",
            OutTemp       => MGTREFCLKFAB_out(1),
            Paths       => (0 => (NORTHREFCLKRX_dly(0)'last_event, tpd_NORTHREFCLKRX_MGTREFCLKFAB(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
        VitalPathDelay01
          (
            OutSignal     => MGTREFCLKFAB(0),
            GlitchData    => MGTREFCLKFAB0_GlitchData,
            OutSignalName => "MGTREFCLKFAB(0)",
            OutTemp       => MGTREFCLKFAB_out(0),
            Paths       => (0 => (NORTHREFCLKRX_dly(1)'last_event, tpd_NORTHREFCLKRX_MGTREFCLKFAB(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
        VitalPathDelay01
          (
            OutSignal     => MGTREFCLKFAB(1),
            GlitchData    => MGTREFCLKFAB1_GlitchData,
            OutSignalName => "MGTREFCLKFAB(1)",
            OutTemp       => MGTREFCLKFAB_out(1),
            Paths       => (0 => (NORTHREFCLKRX_dly(1)'last_event, tpd_NORTHREFCLKRX_MGTREFCLKFAB(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => MGTREFCLKFAB(0),
            GlitchData    => MGTREFCLKFAB0_GlitchData,
            OutSignalName => "MGTREFCLKFAB(0)",
            OutTemp       => MGTREFCLKFAB_out(0),
            Paths       => (0 => (NORTHREFCLKTX_dly(0)'last_event, tpd_NORTHREFCLKTX_MGTREFCLKFAB(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
         VitalPathDelay01
          (
            OutSignal     => MGTREFCLKFAB(1),
            GlitchData    => MGTREFCLKFAB1_GlitchData,
            OutSignalName => "MGTREFCLKFAB(1)",
            OutTemp       => MGTREFCLKFAB_out(1),
            Paths       => (0 => (NORTHREFCLKTX_dly(0)'last_event, tpd_NORTHREFCLKTX_MGTREFCLKFAB(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
         VitalPathDelay01
          (
            OutSignal     => MGTREFCLKFAB(0),
            GlitchData    => MGTREFCLKFAB0_GlitchData,
            OutSignalName => "MGTREFCLKFAB(0)",
            OutTemp       => MGTREFCLKFAB_out(0),
            Paths       => (0 => (NORTHREFCLKTX_dly(1)'last_event, tpd_NORTHREFCLKTX_MGTREFCLKFAB(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
         VitalPathDelay01
          (
            OutSignal     => MGTREFCLKFAB(1),
            GlitchData    => MGTREFCLKFAB1_GlitchData,
            OutSignalName => "MGTREFCLKFAB(1)",
            OutTemp       => MGTREFCLKFAB_out(1),
            Paths       => (0 => (NORTHREFCLKTX_dly(1)'last_event, tpd_NORTHREFCLKTX_MGTREFCLKFAB(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => MGTREFCLKFAB(0),
            GlitchData    => MGTREFCLKFAB0_GlitchData,
            OutSignalName => "MGTREFCLKFAB(0)",
            OutTemp       => MGTREFCLKFAB_out(0),
            Paths       => (0 => (SOUTHREFCLKRX_dly(0)'last_event, tpd_SOUTHREFCLKRX_MGTREFCLKFAB(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
        VitalPathDelay01
          (
            OutSignal     => MGTREFCLKFAB(1),
            GlitchData    => MGTREFCLKFAB1_GlitchData,
            OutSignalName => "MGTREFCLKFAB(1)",
            OutTemp       => MGTREFCLKFAB_out(1),
            Paths       => (0 => (SOUTHREFCLKRX_dly(0)'last_event, tpd_SOUTHREFCLKRX_MGTREFCLKFAB(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
        VitalPathDelay01
          (
            OutSignal     => MGTREFCLKFAB(0),
            GlitchData    => MGTREFCLKFAB0_GlitchData,
            OutSignalName => "MGTREFCLKFAB(0)",
            OutTemp       => MGTREFCLKFAB_out(0),
            Paths       => (0 => (SOUTHREFCLKRX_dly(1)'last_event, tpd_SOUTHREFCLKRX_MGTREFCLKFAB(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
        VitalPathDelay01
          (
            OutSignal     => MGTREFCLKFAB(1),
            GlitchData    => MGTREFCLKFAB1_GlitchData,
            OutSignalName => "MGTREFCLKFAB(1)",
            OutTemp       => MGTREFCLKFAB_out(1),
            Paths       => (0 => (SOUTHREFCLKRX_dly(1)'last_event, tpd_SOUTHREFCLKRX_MGTREFCLKFAB(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => MGTREFCLKFAB(0),
            GlitchData    => MGTREFCLKFAB0_GlitchData,
            OutSignalName => "MGTREFCLKFAB(0)",
            OutTemp       => MGTREFCLKFAB_out(0),
            Paths       => (0 => (SOUTHREFCLKTX_dly(0)'last_event, tpd_SOUTHREFCLKTX_MGTREFCLKFAB(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
        VitalPathDelay01
          (
            OutSignal     => MGTREFCLKFAB(1),
            GlitchData    => MGTREFCLKFAB1_GlitchData,
            OutSignalName => "MGTREFCLKFAB(1)",
            OutTemp       => MGTREFCLKFAB_out(1),
            Paths       => (0 => (SOUTHREFCLKTX_dly(0)'last_event, tpd_SOUTHREFCLKTX_MGTREFCLKFAB(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
        VitalPathDelay01
          (
            OutSignal     => MGTREFCLKFAB(0),
            GlitchData    => MGTREFCLKFAB0_GlitchData,
            OutSignalName => "MGTREFCLKFAB(0)",
            OutTemp       => MGTREFCLKFAB_out(0),
            Paths       => (0 => (SOUTHREFCLKTX_dly(1)'last_event, tpd_SOUTHREFCLKTX_MGTREFCLKFAB(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
        VitalPathDelay01
          (
            OutSignal     => MGTREFCLKFAB(1),
            GlitchData    => MGTREFCLKFAB1_GlitchData,
            OutSignalName => "MGTREFCLKFAB(1)",
            OutTemp       => MGTREFCLKFAB_out(1),
            Paths       => (0 => (SOUTHREFCLKTX_dly(1)'last_event, tpd_SOUTHREFCLKTX_MGTREFCLKFAB(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
        VitalPathDelay01
          (
            OutSignal     => PHYSTATUS,
            GlitchData    => PHYSTATUS_GlitchData,
            OutSignalName => "PHYSTATUS",
            OutTemp       => PHYSTATUS_out,
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_PHYSTATUS,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXBUFSTATUS(0),
            GlitchData    => RXBUFSTATUS0_GlitchData,
            OutSignalName => "RXBUFSTATUS(0)",
            OutTemp       => RXBUFSTATUS_out(0),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXBUFSTATUS(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXBUFSTATUS(1),
            GlitchData    => RXBUFSTATUS1_GlitchData,
            OutSignalName => "RXBUFSTATUS(1)",
            OutTemp       => RXBUFSTATUS_out(1),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXBUFSTATUS(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXBUFSTATUS(2),
            GlitchData    => RXBUFSTATUS2_GlitchData,
            OutSignalName => "RXBUFSTATUS(2)",
            OutTemp       => RXBUFSTATUS_out(2),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXBUFSTATUS(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXBYTEISALIGNED,
            GlitchData    => RXBYTEISALIGNED_GlitchData,
            OutSignalName => "RXBYTEISALIGNED",
            OutTemp       => RXBYTEISALIGNED_out,
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXBYTEISALIGNED,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXBYTEREALIGN,
            GlitchData    => RXBYTEREALIGN_GlitchData,
            OutSignalName => "RXBYTEREALIGN",
            OutTemp       => RXBYTEREALIGN_out,
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXBYTEREALIGN,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHANBONDSEQ,
            GlitchData    => RXCHANBONDSEQ_GlitchData,
            OutSignalName => "RXCHANBONDSEQ",
            OutTemp       => RXCHANBONDSEQ_out,
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCHANBONDSEQ,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHANISALIGNED,
            GlitchData    => RXCHANISALIGNED_GlitchData,
            OutSignalName => "RXCHANISALIGNED",
            OutTemp       => RXCHANISALIGNED_out,
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCHANISALIGNED,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHANREALIGN,
            GlitchData    => RXCHANREALIGN_GlitchData,
            OutSignalName => "RXCHANREALIGN",
            OutTemp       => RXCHANREALIGN_out,
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCHANREALIGN,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHARISCOMMA(0),
            GlitchData    => RXCHARISCOMMA0_GlitchData,
            OutSignalName => "RXCHARISCOMMA(0)",
            OutTemp       => RXCHARISCOMMA_out(0),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCHARISCOMMA(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHARISCOMMA(1),
            GlitchData    => RXCHARISCOMMA1_GlitchData,
            OutSignalName => "RXCHARISCOMMA(1)",
            OutTemp       => RXCHARISCOMMA_out(1),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCHARISCOMMA(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHARISCOMMA(2),
            GlitchData    => RXCHARISCOMMA2_GlitchData,
            OutSignalName => "RXCHARISCOMMA(2)",
            OutTemp       => RXCHARISCOMMA_out(2),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCHARISCOMMA(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHARISCOMMA(3),
            GlitchData    => RXCHARISCOMMA3_GlitchData,
            OutSignalName => "RXCHARISCOMMA(3)",
            OutTemp       => RXCHARISCOMMA_out(3),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCHARISCOMMA(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHARISK(0),
            GlitchData    => RXCHARISK0_GlitchData,
            OutSignalName => "RXCHARISK(0)",
            OutTemp       => RXCHARISK_out(0),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCHARISK(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHARISK(1),
            GlitchData    => RXCHARISK1_GlitchData,
            OutSignalName => "RXCHARISK(1)",
            OutTemp       => RXCHARISK_out(1),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCHARISK(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHARISK(2),
            GlitchData    => RXCHARISK2_GlitchData,
            OutSignalName => "RXCHARISK(2)",
            OutTemp       => RXCHARISK_out(2),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCHARISK(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHARISK(3),
            GlitchData    => RXCHARISK3_GlitchData,
            OutSignalName => "RXCHARISK(3)",
            OutTemp       => RXCHARISK_out(3),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCHARISK(3),TRUE)),
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
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCHBONDO(0),TRUE)),
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
            Paths       => (0 => (RXUSRCLK_dly_1'last_event, tpd_RXUSRCLK_RXCHBONDO(0),TRUE)),
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
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCHBONDO(1),TRUE)),
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
            Paths       => (0 => (RXUSRCLK_dly_1'last_event, tpd_RXUSRCLK_RXCHBONDO(1),TRUE)),
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
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCHBONDO(2),TRUE)),
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
            Paths       => (0 => (RXUSRCLK_dly_1'last_event, tpd_RXUSRCLK_RXCHBONDO(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHBONDO(3),
            GlitchData    => RXCHBONDO3_GlitchData,
            OutSignalName => "RXCHBONDO(3)",
            OutTemp       => RXCHBONDO_out(3),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCHBONDO(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCHBONDO(3),
            GlitchData    => RXCHBONDO3_GlitchData,
            OutSignalName => "RXCHBONDO(3)",
            OutTemp       => RXCHBONDO_out(3),
            Paths       => (0 => (RXUSRCLK_dly_1'last_event, tpd_RXUSRCLK_RXCHBONDO(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCLKCORCNT(0),
            GlitchData    => RXCLKCORCNT0_GlitchData,
            OutSignalName => "RXCLKCORCNT(0)",
            OutTemp       => RXCLKCORCNT_out(0),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCLKCORCNT(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCLKCORCNT(1),
            GlitchData    => RXCLKCORCNT1_GlitchData,
            OutSignalName => "RXCLKCORCNT(1)",
            OutTemp       => RXCLKCORCNT_out(1),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCLKCORCNT(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCLKCORCNT(2),
            GlitchData    => RXCLKCORCNT2_GlitchData,
            OutSignalName => "RXCLKCORCNT(2)",
            OutTemp       => RXCLKCORCNT_out(2),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCLKCORCNT(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXCOMMADET,
            GlitchData    => RXCOMMADET_GlitchData,
            OutSignalName => "RXCOMMADET",
            OutTemp       => RXCOMMADET_out,
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXCOMMADET,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(0),
            GlitchData    => RXDATA0_GlitchData,
            OutSignalName => "RXDATA(0)",
            OutTemp       => RXDATA_out(0),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(1),
            GlitchData    => RXDATA1_GlitchData,
            OutSignalName => "RXDATA(1)",
            OutTemp       => RXDATA_out(1),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(10),
            GlitchData    => RXDATA10_GlitchData,
            OutSignalName => "RXDATA(10)",
            OutTemp       => RXDATA_out(10),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(10),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(11),
            GlitchData    => RXDATA11_GlitchData,
            OutSignalName => "RXDATA(11)",
            OutTemp       => RXDATA_out(11),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(11),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(12),
            GlitchData    => RXDATA12_GlitchData,
            OutSignalName => "RXDATA(12)",
            OutTemp       => RXDATA_out(12),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(12),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(13),
            GlitchData    => RXDATA13_GlitchData,
            OutSignalName => "RXDATA(13)",
            OutTemp       => RXDATA_out(13),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(13),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(14),
            GlitchData    => RXDATA14_GlitchData,
            OutSignalName => "RXDATA(14)",
            OutTemp       => RXDATA_out(14),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(14),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(15),
            GlitchData    => RXDATA15_GlitchData,
            OutSignalName => "RXDATA(15)",
            OutTemp       => RXDATA_out(15),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(15),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(16),
            GlitchData    => RXDATA16_GlitchData,
            OutSignalName => "RXDATA(16)",
            OutTemp       => RXDATA_out(16),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(16),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(17),
            GlitchData    => RXDATA17_GlitchData,
            OutSignalName => "RXDATA(17)",
            OutTemp       => RXDATA_out(17),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(17),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(18),
            GlitchData    => RXDATA18_GlitchData,
            OutSignalName => "RXDATA(18)",
            OutTemp       => RXDATA_out(18),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(18),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(19),
            GlitchData    => RXDATA19_GlitchData,
            OutSignalName => "RXDATA(19)",
            OutTemp       => RXDATA_out(19),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(19),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(2),
            GlitchData    => RXDATA2_GlitchData,
            OutSignalName => "RXDATA(2)",
            OutTemp       => RXDATA_out(2),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(20),
            GlitchData    => RXDATA20_GlitchData,
            OutSignalName => "RXDATA(20)",
            OutTemp       => RXDATA_out(20),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(20),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(21),
            GlitchData    => RXDATA21_GlitchData,
            OutSignalName => "RXDATA(21)",
            OutTemp       => RXDATA_out(21),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(21),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(22),
            GlitchData    => RXDATA22_GlitchData,
            OutSignalName => "RXDATA(22)",
            OutTemp       => RXDATA_out(22),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(22),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(23),
            GlitchData    => RXDATA23_GlitchData,
            OutSignalName => "RXDATA(23)",
            OutTemp       => RXDATA_out(23),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(23),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(24),
            GlitchData    => RXDATA24_GlitchData,
            OutSignalName => "RXDATA(24)",
            OutTemp       => RXDATA_out(24),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(24),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(25),
            GlitchData    => RXDATA25_GlitchData,
            OutSignalName => "RXDATA(25)",
            OutTemp       => RXDATA_out(25),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(25),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(26),
            GlitchData    => RXDATA26_GlitchData,
            OutSignalName => "RXDATA(26)",
            OutTemp       => RXDATA_out(26),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(26),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(27),
            GlitchData    => RXDATA27_GlitchData,
            OutSignalName => "RXDATA(27)",
            OutTemp       => RXDATA_out(27),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(27),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(28),
            GlitchData    => RXDATA28_GlitchData,
            OutSignalName => "RXDATA(28)",
            OutTemp       => RXDATA_out(28),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(28),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(29),
            GlitchData    => RXDATA29_GlitchData,
            OutSignalName => "RXDATA(29)",
            OutTemp       => RXDATA_out(29),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(29),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(3),
            GlitchData    => RXDATA3_GlitchData,
            OutSignalName => "RXDATA(3)",
            OutTemp       => RXDATA_out(3),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(30),
            GlitchData    => RXDATA30_GlitchData,
            OutSignalName => "RXDATA(30)",
            OutTemp       => RXDATA_out(30),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(30),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(31),
            GlitchData    => RXDATA31_GlitchData,
            OutSignalName => "RXDATA(31)",
            OutTemp       => RXDATA_out(31),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(31),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(4),
            GlitchData    => RXDATA4_GlitchData,
            OutSignalName => "RXDATA(4)",
            OutTemp       => RXDATA_out(4),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(4),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(5),
            GlitchData    => RXDATA5_GlitchData,
            OutSignalName => "RXDATA(5)",
            OutTemp       => RXDATA_out(5),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(5),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(6),
            GlitchData    => RXDATA6_GlitchData,
            OutSignalName => "RXDATA(6)",
            OutTemp       => RXDATA_out(6),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(6),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(7),
            GlitchData    => RXDATA7_GlitchData,
            OutSignalName => "RXDATA(7)",
            OutTemp       => RXDATA_out(7),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(7),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(8),
            GlitchData    => RXDATA8_GlitchData,
            OutSignalName => "RXDATA(8)",
            OutTemp       => RXDATA_out(8),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(8),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATA(9),
            GlitchData    => RXDATA9_GlitchData,
            OutSignalName => "RXDATA(9)",
            OutTemp       => RXDATA_out(9),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATA(9),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDATAVALID,
            GlitchData    => RXDATAVALID_GlitchData,
            OutSignalName => "RXDATAVALID",
            OutTemp       => RXDATAVALID_out,
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDATAVALID,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDISPERR(0),
            GlitchData    => RXDISPERR0_GlitchData,
            OutSignalName => "RXDISPERR(0)",
            OutTemp       => RXDISPERR_out(0),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDISPERR(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDISPERR(1),
            GlitchData    => RXDISPERR1_GlitchData,
            OutSignalName => "RXDISPERR(1)",
            OutTemp       => RXDISPERR_out(1),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDISPERR(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDISPERR(2),
            GlitchData    => RXDISPERR2_GlitchData,
            OutSignalName => "RXDISPERR(2)",
            OutTemp       => RXDISPERR_out(2),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDISPERR(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXDISPERR(3),
            GlitchData    => RXDISPERR3_GlitchData,
            OutSignalName => "RXDISPERR(3)",
            OutTemp       => RXDISPERR_out(3),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXDISPERR(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXHEADER(0),
            GlitchData    => RXHEADER0_GlitchData,
            OutSignalName => "RXHEADER(0)",
            OutTemp       => RXHEADER_out(0),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXHEADER(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXHEADER(1),
            GlitchData    => RXHEADER1_GlitchData,
            OutSignalName => "RXHEADER(1)",
            OutTemp       => RXHEADER_out(1),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXHEADER(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXHEADER(2),
            GlitchData    => RXHEADER2_GlitchData,
            OutSignalName => "RXHEADER(2)",
            OutTemp       => RXHEADER_out(2),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXHEADER(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXHEADERVALID,
            GlitchData    => RXHEADERVALID_GlitchData,
            OutSignalName => "RXHEADERVALID",
            OutTemp       => RXHEADERVALID_out,
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXHEADERVALID,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXLOSSOFSYNC(0),
            GlitchData    => RXLOSSOFSYNC0_GlitchData,
            OutSignalName => "RXLOSSOFSYNC(0)",
            OutTemp       => RXLOSSOFSYNC_out(0),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXLOSSOFSYNC(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXLOSSOFSYNC(1),
            GlitchData    => RXLOSSOFSYNC1_GlitchData,
            OutSignalName => "RXLOSSOFSYNC(1)",
            OutTemp       => RXLOSSOFSYNC_out(1),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXLOSSOFSYNC(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXNOTINTABLE(0),
            GlitchData    => RXNOTINTABLE0_GlitchData,
            OutSignalName => "RXNOTINTABLE(0)",
            OutTemp       => RXNOTINTABLE_out(0),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXNOTINTABLE(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXNOTINTABLE(1),
            GlitchData    => RXNOTINTABLE1_GlitchData,
            OutSignalName => "RXNOTINTABLE(1)",
            OutTemp       => RXNOTINTABLE_out(1),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXNOTINTABLE(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXNOTINTABLE(2),
            GlitchData    => RXNOTINTABLE2_GlitchData,
            OutSignalName => "RXNOTINTABLE(2)",
            OutTemp       => RXNOTINTABLE_out(2),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXNOTINTABLE(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXNOTINTABLE(3),
            GlitchData    => RXNOTINTABLE3_GlitchData,
            OutSignalName => "RXNOTINTABLE(3)",
            OutTemp       => RXNOTINTABLE_out(3),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXNOTINTABLE(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXOVERSAMPLEERR,
            GlitchData    => RXOVERSAMPLEERR_GlitchData,
            OutSignalName => "RXOVERSAMPLEERR",
            OutTemp       => RXOVERSAMPLEERR_out,
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXOVERSAMPLEERR,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXPRBSERR,
            GlitchData    => RXPRBSERR_GlitchData,
            OutSignalName => "RXPRBSERR",
            OutTemp       => RXPRBSERR_out,
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXPRBSERR,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXRATEDONE,
            GlitchData    => RXRATEDONE_GlitchData,
            OutSignalName => "RXRATEDONE",
            OutTemp       => RXRATEDONE_out,
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXRATEDONE,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXRESETDONE,
            GlitchData    => RXRESETDONE_GlitchData,
            OutSignalName => "RXRESETDONE",
            OutTemp       => RXRESETDONE_out,
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXRESETDONE,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXRUNDISP(0),
            GlitchData    => RXRUNDISP0_GlitchData,
            OutSignalName => "RXRUNDISP(0)",
            OutTemp       => RXRUNDISP_out(0),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXRUNDISP(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXRUNDISP(1),
            GlitchData    => RXRUNDISP1_GlitchData,
            OutSignalName => "RXRUNDISP(1)",
            OutTemp       => RXRUNDISP_out(1),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXRUNDISP(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXRUNDISP(2),
            GlitchData    => RXRUNDISP2_GlitchData,
            OutSignalName => "RXRUNDISP(2)",
            OutTemp       => RXRUNDISP_out(2),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXRUNDISP(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXRUNDISP(3),
            GlitchData    => RXRUNDISP3_GlitchData,
            OutSignalName => "RXRUNDISP(3)",
            OutTemp       => RXRUNDISP_out(3),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXRUNDISP(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXSTARTOFSEQ,
            GlitchData    => RXSTARTOFSEQ_GlitchData,
            OutSignalName => "RXSTARTOFSEQ",
            OutTemp       => RXSTARTOFSEQ_out,
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXSTARTOFSEQ,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXSTATUS(0),
            GlitchData    => RXSTATUS0_GlitchData,
            OutSignalName => "RXSTATUS(0)",
            OutTemp       => RXSTATUS_out(0),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXSTATUS(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXSTATUS(1),
            GlitchData    => RXSTATUS1_GlitchData,
            OutSignalName => "RXSTATUS(1)",
            OutTemp       => RXSTATUS_out(1),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXSTATUS(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXSTATUS(2),
            GlitchData    => RXSTATUS2_GlitchData,
            OutSignalName => "RXSTATUS(2)",
            OutTemp       => RXSTATUS_out(2),
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXSTATUS(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => RXVALID,
            GlitchData    => RXVALID_GlitchData,
            OutSignalName => "RXVALID",
            OutTemp       => RXVALID_out,
            Paths       => (0 => (RXUSRCLK2_dly'last_event, tpd_RXUSRCLK2_RXVALID,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXBUFSTATUS(0),
            GlitchData    => TXBUFSTATUS0_GlitchData,
            OutSignalName => "TXBUFSTATUS(0)",
            OutTemp       => TXBUFSTATUS_out(0),
            Paths       => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXBUFSTATUS(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXBUFSTATUS(1),
            GlitchData    => TXBUFSTATUS1_GlitchData,
            OutSignalName => "TXBUFSTATUS(1)",
            OutTemp       => TXBUFSTATUS_out(1),
            Paths       => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXBUFSTATUS(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXGEARBOXREADY,
            GlitchData    => TXGEARBOXREADY_GlitchData,
            OutSignalName => "TXGEARBOXREADY",
            OutTemp       => TXGEARBOXREADY_out,
            Paths       => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXGEARBOXREADY,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXKERR(0),
            GlitchData    => TXKERR0_GlitchData,
            OutSignalName => "TXKERR(0)",
            OutTemp       => TXKERR_out(0),
            Paths       => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXKERR(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXKERR(1),
            GlitchData    => TXKERR1_GlitchData,
            OutSignalName => "TXKERR(1)",
            OutTemp       => TXKERR_out(1),
            Paths       => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXKERR(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXKERR(2),
            GlitchData    => TXKERR2_GlitchData,
            OutSignalName => "TXKERR(2)",
            OutTemp       => TXKERR_out(2),
            Paths       => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXKERR(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXKERR(3),
            GlitchData    => TXKERR3_GlitchData,
            OutSignalName => "TXKERR(3)",
            OutTemp       => TXKERR_out(3),
            Paths       => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXKERR(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXRATEDONE,
            GlitchData    => TXRATEDONE_GlitchData,
            OutSignalName => "TXRATEDONE",
            OutTemp       => TXRATEDONE_out,
            Paths       => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXRATEDONE,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXRESETDONE,
            GlitchData    => TXRESETDONE_GlitchData,
            OutSignalName => "TXRESETDONE",
            OutTemp       => TXRESETDONE_out,
            Paths       => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXRESETDONE,TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXRUNDISP(0),
            GlitchData    => TXRUNDISP0_GlitchData,
            OutSignalName => "TXRUNDISP(0)",
            OutTemp       => TXRUNDISP_out(0),
            Paths       => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXRUNDISP(0),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXRUNDISP(1),
            GlitchData    => TXRUNDISP1_GlitchData,
            OutSignalName => "TXRUNDISP(1)",
            OutTemp       => TXRUNDISP_out(1),
            Paths       => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXRUNDISP(1),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXRUNDISP(2),
            GlitchData    => TXRUNDISP2_GlitchData,
            OutSignalName => "TXRUNDISP(2)",
            OutTemp       => TXRUNDISP_out(2),
            Paths       => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXRUNDISP(2),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
            MsgSeverity    => WARNING
          );
          VitalPathDelay01
          (
            OutSignal     => TXRUNDISP(3),
            GlitchData    => TXRUNDISP3_GlitchData,
            OutSignalName => "TXRUNDISP(3)",
            OutTemp       => TXRUNDISP_out(3),
            Paths       => (0 => (TXUSRCLK2_dly'last_event, tpd_TXUSRCLK2_TXRUNDISP(3),TRUE)),
            Mode          => VitalTransport,
            Xon           => false,
            MsgOn          => false,
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
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_GREFCLKRX,
            PeriodData     => PInfo_GREFCLKRX,
            TestSignal     => GREFCLKRX_dly,
            TestSignalName => "GREFCLKRX",
            TestDelay      => 0 ps,
            Period         => tperiod_GREFCLKRX_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_GREFCLKTX,
            PeriodData     => PInfo_GREFCLKTX,
            TestSignal     => GREFCLKTX_dly,
            TestSignalName => "GREFCLKTX",
            TestDelay      => 0 ps,
            Period         => tperiod_GREFCLKTX_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_MGTREFCLKRX(0),
            PeriodData     => PInfo_MGTREFCLKRX,
            TestSignal     => MGTREFCLKRX_dly(0),
            TestSignalName => "MGTREFCLKRX(0)",
            TestDelay      => 0 ps,
            Period         => tperiod_MGTREFCLKRX_posedge(0),
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_MGTREFCLKRX(1),
            PeriodData     => PInfo_MGTREFCLKRX,
            TestSignal     => MGTREFCLKRX_dly(1),
            TestSignalName => "MGTREFCLKRX(1)",
            TestDelay      => 0 ps,
            Period         => tperiod_MGTREFCLKRX_posedge(1),
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
         VitalPeriodPulseCheck
          (
            Violation      => Pviol_MGTREFCLKTX(0),
            PeriodData     => PInfo_MGTREFCLKTX,
            TestSignal     => MGTREFCLKTX_dly(0),
            TestSignalName => "MGTREFCLKTX(0)",
            TestDelay      => 0 ps,
            Period         => tperiod_MGTREFCLKTX_posedge(0),
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_MGTREFCLKTX(1),
            PeriodData     => PInfo_MGTREFCLKTX,
            TestSignal     => MGTREFCLKTX_dly(1),
            TestSignalName => "MGTREFCLKTX(1)",
            TestDelay      => 0 ps,
            Period         => tperiod_MGTREFCLKTX_posedge(1),
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_NORTHREFCLKRX(0),
            PeriodData     => PInfo_NORTHREFCLKRX,
            TestSignal     => NORTHREFCLKRX_dly(0),
            TestSignalName => "NORTHREFCLKRX(0)",
            TestDelay      => 0 ps,
            Period         => tperiod_NORTHREFCLKRX_posedge(0),
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_NORTHREFCLKRX(1),
            PeriodData     => PInfo_NORTHREFCLKRX,
            TestSignal     => NORTHREFCLKRX_dly(1),
            TestSignalName => "NORTHREFCLKRX(1)",
            TestDelay      => 0 ps,
            Period         => tperiod_NORTHREFCLKRX_posedge(1),
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_NORTHREFCLKTX(0),
            PeriodData     => PInfo_NORTHREFCLKTX,
            TestSignal     => NORTHREFCLKTX_dly(0),
            TestSignalName => "NORTHREFCLKTX(0)",
            TestDelay      => 0 ps,
            Period         => tperiod_NORTHREFCLKTX_posedge(0),
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_NORTHREFCLKTX(1),
            PeriodData     => PInfo_NORTHREFCLKTX,
            TestSignal     => NORTHREFCLKTX_dly(1),
            TestSignalName => "NORTHREFCLKTX(1)",
            TestDelay      => 0 ps,
            Period         => tperiod_NORTHREFCLKTX_posedge(1),
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );

          VitalPeriodPulseCheck
          (
            Violation      => Pviol_PERFCLKRX,
            PeriodData     => PInfo_PERFCLKRX,
            TestSignal     => PERFCLKRX_dly,
            TestSignalName => "PERFCLKRX",
            TestDelay      => 0 ps,
            Period         => tperiod_PERFCLKRX_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_PERFCLKTX,
            PeriodData     => PInfo_PERFCLKTX,
            TestSignal     => PERFCLKTX_dly,
            TestSignalName => "PERFCLKTX",
            TestDelay      => 0 ps,
            Period         => tperiod_PERFCLKTX_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_RXUSRCLK,
            PeriodData     => PInfo_RXUSRCLK,
            TestSignal     => RXUSRCLK_dly_1,
            TestSignalName => "RXUSRCLK",
            TestDelay      => 0 ps,
            Period         => tperiod_RXUSRCLK_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_RXUSRCLK2,
            PeriodData     => PInfo_RXUSRCLK2,
            TestSignal     => RXUSRCLK2_dly,
            TestSignalName => "RXUSRCLK2",
            TestDelay      => 0 ps,
            Period         => tperiod_RXUSRCLK2_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
           VitalPeriodPulseCheck
          (
            Violation      => Pviol_SOUTHREFCLKRX(0),
            PeriodData     => PInfo_SOUTHREFCLKRX,
            TestSignal     => SOUTHREFCLKRX_dly(0),
            TestSignalName => "SOUTHREFCLKRX(0)",
            TestDelay      => 0 ps,
            Period         => tperiod_SOUTHREFCLKRX_posedge(0),
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_SOUTHREFCLKRX(1),
            PeriodData     => PInfo_SOUTHREFCLKRX,
            TestSignal     => SOUTHREFCLKRX_dly(1),
            TestSignalName => "SOUTHREFCLKRX(1)",
            TestDelay      => 0 ps,
            Period         => tperiod_SOUTHREFCLKRX_posedge(1),
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_SOUTHREFCLKTX(0),
            PeriodData     => PInfo_SOUTHREFCLKTX,
            TestSignal     => SOUTHREFCLKTX_dly(0),
            TestSignalName => "SOUTHREFCLKTX(0)",
            TestDelay      => 0 ps,
            Period         => tperiod_SOUTHREFCLKTX_posedge(0),
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_SOUTHREFCLKTX(1),
            PeriodData     => PInfo_SOUTHREFCLKTX,
            TestSignal     => SOUTHREFCLKTX_dly(1),
            TestSignalName => "SOUTHREFCLKTX(1)",
            TestDelay      => 0 ps,
            Period         => tperiod_SOUTHREFCLKTX_posedge(1),
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTXE1",
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
            HeaderMsg      => InstancePath & "/X_GTXE1",
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
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_TXUSRCLK,
            PeriodData     => PInfo_TXUSRCLK,
            TestSignal     => TXUSRCLK_dly,
            TestSignalName => "TXUSRCLK",
            TestDelay      => 0 ps,
            Period         => tperiod_TXUSRCLK_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );
          VitalPeriodPulseCheck
          (
            Violation      => Pviol_TXUSRCLK2,
            PeriodData     => PInfo_TXUSRCLK2,
            TestSignal     => TXUSRCLK2_dly,
            TestSignalName => "TXUSRCLK2",
            TestDelay      => 0 ps,
            Period         => tperiod_TXUSRCLK2_posedge,
            PulseWidthHigh => 0 ps,
            PulseWidthLow  => 0 ps,
            CheckEnabled   => TRUE,
            HeaderMsg      => InstancePath & "/X_GTXE1",
            Xon            => Xon,
            MsgOn          => MsgOn,
            MsgSeverity    => WARNING
          );

        wait on
          COMFINISH_out,
          COMINITDET_out,
          COMSASDET_out,
          COMWAKEDET_out,
          DFECLKDLYADJMON_out,
          DFEEYEDACMON_out,
          DFESENSCAL_out,
          DFETAP1MONITOR_out,
          DFETAP2MONITOR_out,
          DFETAP3MONITOR_out,
          DFETAP4MONITOR_out,
          DRDY_out,
          DRPDO_out,
          MGTREFCLKFAB_out,
          PHYSTATUS_out,
          RXBUFSTATUS_out,
          RXBYTEISALIGNED_out,
          RXBYTEREALIGN_out,
          RXCHANBONDSEQ_out,
          RXCHANISALIGNED_out,
          RXCHANREALIGN_out,
          RXCHARISCOMMA_out,
          RXCHARISK_out,
          RXCHBONDO_out,
          RXCLKCORCNT_out,
          RXCOMMADET_out,
          RXDATAVALID_out,
          RXDATA_out,
          RXDISPERR_out,
          RXDLYALIGNMONITOR_out,
          RXELECIDLE_out,
          RXHEADERVALID_out,
          RXHEADER_out,
          RXLOSSOFSYNC_out,
          RXNOTINTABLE_out,
          RXOVERSAMPLEERR_out,
          RXPLLLKDET_out,
          RXPRBSERR_out,
          RXRATEDONE_out,
          RXRECCLKPCS_out,
          RXRECCLK_out,
          RXRESETDONE_out,
          RXRUNDISP_out,
          RXSTARTOFSEQ_out,
          RXSTATUS_out,
          RXVALID_out,
          TSTOUT_out,
          TXBUFSTATUS_out,
          TXDLYALIGNMONITOR_out,
          TXGEARBOXREADY_out,
          TXKERR_out,
          TXN_out,
          TXOUTCLKPCS_out,
          TXOUTCLK_out,
          TXPLLLKDET_out,
          TXP_out,
          TXRATEDONE_out,
          TXRESETDONE_out,
          TXRUNDISP_out,
          DADDR_DCLK_dly,
          DEN_DCLK_dly,
          DFECLKDLYADJ_RXUSRCLK2_dly,
          DFEDLYOVRD_RXUSRCLK2_dly,
          DFETAP1_RXUSRCLK2_dly,
          DFETAP2_RXUSRCLK2_dly,
          DFETAP3_RXUSRCLK2_dly,
          DFETAP4_RXUSRCLK2_dly,
          DFETAPOVRD_RXUSRCLK2_dly,
          DI_DCLK_dly,
          DWE_DCLK_dly,
          PRBSCNTRESET_RXUSRCLK2_dly,
          RXCHBONDI_RXUSRCLK2_dly,
          RXCHBONDI_RXUSRCLK_dly,
          RXCHBONDLEVEL_RXUSRCLK2_dly,
          RXCHBONDMASTER_RXUSRCLK2_dly,
          RXCHBONDSLAVE_RXUSRCLK2_dly,
          RXCOMMADETUSE_RXUSRCLK2_dly,
          RXDEC8B10BUSE_RXUSRCLK2_dly,
          RXENCHANSYNC_RXUSRCLK2_dly,
          RXENMCOMMAALIGN_RXUSRCLK2_dly,
          RXENPCOMMAALIGN_RXUSRCLK2_dly,
          RXENPRBSTST_RXUSRCLK2_dly,
          RXENSAMPLEALIGN_RXUSRCLK2_dly,
          RXGEARBOXSLIP_RXUSRCLK2_dly,
          RXPOLARITY_RXUSRCLK2_dly,
          RXRATE_RXUSRCLK2_dly,
          RXSLIDE_RXUSRCLK2_dly,
          TXBYPASS8B10B_TXUSRCLK2_dly,
          TXCHARDISPMODE_TXUSRCLK2_dly,
          TXCHARDISPVAL_TXUSRCLK2_dly,
          TXCHARISK_TXUSRCLK2_dly,
          TXCOMINIT_TXUSRCLK2_dly,
          TXCOMSAS_TXUSRCLK2_dly,
          TXCOMWAKE_TXUSRCLK2_dly,
          TXDATA_TXUSRCLK2_dly,
          TXDETECTRX_TXUSRCLK2_dly,
          TXELECIDLE_TXUSRCLK2_dly,
          TXENC8B10BUSE_TXUSRCLK2_dly,
          TXENPRBSTST_TXUSRCLK2_dly,
          TXHEADER_TXUSRCLK2_dly,
          TXINHIBIT_TXUSRCLK2_dly,
          TXPOLARITY_TXUSRCLK2_dly,
          TXPOWERDOWN_TXUSRCLK2_dly,
          TXPRBSFORCEERR_TXUSRCLK2_dly,
          TXRATE_TXUSRCLK2_dly,
          TXSEQUENCE_TXUSRCLK2_dly,
          TXSTARTSEQ_TXUSRCLK2_dly,
          USRCODEERR_RXUSRCLK2_dly;

      end process TIMING;

      RXDLYALIGNMONITOR <= RXDLYALIGNMONITOR_out;
      RXELECIDLE <= RXELECIDLE_out;
      RXPLLLKDET <= RXPLLLKDET_out;
      RXRECCLK <= RXRECCLK_out;
      RXRECCLKPCS <= RXRECCLKPCS_out;
      TSTOUT <= TSTOUT_out;
      TXDLYALIGNMONITOR <= TXDLYALIGNMONITOR_out;
      TXN <= TXN_out;
      TXOUTCLK <= TXOUTCLK_out;
      TXOUTCLKPCS <= TXOUTCLKPCS_out;
      TXP <= TXP_out;
      TXPLLLKDET <= TXPLLLKDET_out;

    end X_GTXE1_V;


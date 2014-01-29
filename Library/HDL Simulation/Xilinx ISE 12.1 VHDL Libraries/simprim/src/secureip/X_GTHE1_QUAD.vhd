-------------------------------------------------------
--  Copyright (c) 2009 Xilinx Inc.
--  All Right Reserved.
-------------------------------------------------------
--
--   ____  ____
--  /   /\/   / 
-- /___/  \  /     Vendor      : Xilinx 
-- \   \   \/      Version : 11.1
--  \   \          Description : Xilinx Functional Simulation Library Component
--  /   /                        Gigabit Transceiver
-- /___/   /\      Filename    : X_GTHE1_QUAD.vhd
-- \   \  /  \      
--  \__ \/\__ \                   
--                                 
--  Revision: 1.0
--  05/29/09 - CR523112 - Initial version
--  06/16/09 - CR523112 - Parameter update in YML
--  06/24/09 - CR523112 - YML update
--  07/14/09 - CR527136 - Complete simprim wrapper 
--  08/13/09 - CR530821 - writer bug - update GTH_CFG_PWRUP_LANE_* bit_vector to bit
--  09/01/09 - CR532172 - Delay YML update
--  10/01/09 - CR534680 - YML Attribute updates
--  01/26/10 - CR546178 - YML new output pins & parameter default update
--  02/10/10 - CR543263 - Add new output pin connections in B_GTHE1_QUAD_INST'
-------------------------------------------------------

----- CELL X_GTHE1_QUAD -----

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

  entity X_GTHE1_QUAD is
    generic (
      TimingChecksOn : boolean := TRUE;
      InstancePath   : string  := "*";
      Xon            : boolean := TRUE;
      MsgOn          : boolean := FALSE;
      LOC            : string  := "UNPLACED";
      BER_CONST_PTRN0 : bit_vector := X"0000";
      BER_CONST_PTRN1 : bit_vector := X"0000";
      BUFFER_CONFIG_LANE0 : bit_vector := X"4004";
      BUFFER_CONFIG_LANE1 : bit_vector := X"4004";
      BUFFER_CONFIG_LANE2 : bit_vector := X"4004";
      BUFFER_CONFIG_LANE3 : bit_vector := X"4004";
      DFE_TRAIN_CTRL_LANE0 : bit_vector := X"0000";
      DFE_TRAIN_CTRL_LANE1 : bit_vector := X"0000";
      DFE_TRAIN_CTRL_LANE2 : bit_vector := X"0000";
      DFE_TRAIN_CTRL_LANE3 : bit_vector := X"0000";
      DLL_CFG0 : bit_vector := X"4201";
      DLL_CFG1 : bit_vector := X"0000";
      E10GBASEKR_LD_COEFF_UPD_LANE0 : bit_vector := X"0000";
      E10GBASEKR_LD_COEFF_UPD_LANE1 : bit_vector := X"0000";
      E10GBASEKR_LD_COEFF_UPD_LANE2 : bit_vector := X"0000";
      E10GBASEKR_LD_COEFF_UPD_LANE3 : bit_vector := X"0000";
      E10GBASEKR_LP_COEFF_UPD_LANE0 : bit_vector := X"0000";
      E10GBASEKR_LP_COEFF_UPD_LANE1 : bit_vector := X"0000";
      E10GBASEKR_LP_COEFF_UPD_LANE2 : bit_vector := X"0000";
      E10GBASEKR_LP_COEFF_UPD_LANE3 : bit_vector := X"0000";
      E10GBASEKR_PMA_CTRL_LANE0 : bit_vector := X"0002";
      E10GBASEKR_PMA_CTRL_LANE1 : bit_vector := X"0002";
      E10GBASEKR_PMA_CTRL_LANE2 : bit_vector := X"0002";
      E10GBASEKR_PMA_CTRL_LANE3 : bit_vector := X"0002";
      E10GBASEKX_CTRL_LANE0 : bit_vector := X"0000";
      E10GBASEKX_CTRL_LANE1 : bit_vector := X"0000";
      E10GBASEKX_CTRL_LANE2 : bit_vector := X"0000";
      E10GBASEKX_CTRL_LANE3 : bit_vector := X"0000";
      E10GBASER_PCS_CFG_LANE0 : bit_vector := X"070C";
      E10GBASER_PCS_CFG_LANE1 : bit_vector := X"070C";
      E10GBASER_PCS_CFG_LANE2 : bit_vector := X"070C";
      E10GBASER_PCS_CFG_LANE3 : bit_vector := X"070C";
      E10GBASER_PCS_SEEDA0_LANE0 : bit_vector := X"0001";
      E10GBASER_PCS_SEEDA0_LANE1 : bit_vector := X"0001";
      E10GBASER_PCS_SEEDA0_LANE2 : bit_vector := X"0001";
      E10GBASER_PCS_SEEDA0_LANE3 : bit_vector := X"0001";
      E10GBASER_PCS_SEEDA1_LANE0 : bit_vector := X"0000";
      E10GBASER_PCS_SEEDA1_LANE1 : bit_vector := X"0000";
      E10GBASER_PCS_SEEDA1_LANE2 : bit_vector := X"0000";
      E10GBASER_PCS_SEEDA1_LANE3 : bit_vector := X"0000";
      E10GBASER_PCS_SEEDA2_LANE0 : bit_vector := X"0000";
      E10GBASER_PCS_SEEDA2_LANE1 : bit_vector := X"0000";
      E10GBASER_PCS_SEEDA2_LANE2 : bit_vector := X"0000";
      E10GBASER_PCS_SEEDA2_LANE3 : bit_vector := X"0000";
      E10GBASER_PCS_SEEDA3_LANE0 : bit_vector := X"0000";
      E10GBASER_PCS_SEEDA3_LANE1 : bit_vector := X"0000";
      E10GBASER_PCS_SEEDA3_LANE2 : bit_vector := X"0000";
      E10GBASER_PCS_SEEDA3_LANE3 : bit_vector := X"0000";
      E10GBASER_PCS_SEEDB0_LANE0 : bit_vector := X"0001";
      E10GBASER_PCS_SEEDB0_LANE1 : bit_vector := X"0001";
      E10GBASER_PCS_SEEDB0_LANE2 : bit_vector := X"0001";
      E10GBASER_PCS_SEEDB0_LANE3 : bit_vector := X"0001";
      E10GBASER_PCS_SEEDB1_LANE0 : bit_vector := X"0000";
      E10GBASER_PCS_SEEDB1_LANE1 : bit_vector := X"0000";
      E10GBASER_PCS_SEEDB1_LANE2 : bit_vector := X"0000";
      E10GBASER_PCS_SEEDB1_LANE3 : bit_vector := X"0000";
      E10GBASER_PCS_SEEDB2_LANE0 : bit_vector := X"0000";
      E10GBASER_PCS_SEEDB2_LANE1 : bit_vector := X"0000";
      E10GBASER_PCS_SEEDB2_LANE2 : bit_vector := X"0000";
      E10GBASER_PCS_SEEDB2_LANE3 : bit_vector := X"0000";
      E10GBASER_PCS_SEEDB3_LANE0 : bit_vector := X"0000";
      E10GBASER_PCS_SEEDB3_LANE1 : bit_vector := X"0000";
      E10GBASER_PCS_SEEDB3_LANE2 : bit_vector := X"0000";
      E10GBASER_PCS_SEEDB3_LANE3 : bit_vector := X"0000";
      E10GBASER_PCS_TEST_CTRL_LANE0 : bit_vector := X"0000";
      E10GBASER_PCS_TEST_CTRL_LANE1 : bit_vector := X"0000";
      E10GBASER_PCS_TEST_CTRL_LANE2 : bit_vector := X"0000";
      E10GBASER_PCS_TEST_CTRL_LANE3 : bit_vector := X"0000";
      E10GBASEX_PCS_TSTCTRL_LANE0 : bit_vector := X"0000";
      E10GBASEX_PCS_TSTCTRL_LANE1 : bit_vector := X"0000";
      E10GBASEX_PCS_TSTCTRL_LANE2 : bit_vector := X"0000";
      E10GBASEX_PCS_TSTCTRL_LANE3 : bit_vector := X"0000";
      GLBL0_NOISE_CTRL : bit_vector := X"F0B8";
      GLBL_AMON_SEL : bit_vector := X"0000";
      GLBL_DMON_SEL : bit_vector := X"0200";
      GLBL_PWR_CTRL : bit_vector := X"0000";
      GTH_CFG_PWRUP_LANE0 : bit := '1';
      GTH_CFG_PWRUP_LANE1 : bit := '1';
      GTH_CFG_PWRUP_LANE2 : bit := '1';
      GTH_CFG_PWRUP_LANE3 : bit := '1';
      LANE_AMON_SEL : bit_vector := X"00F0";
      LANE_DMON_SEL : bit_vector := X"0000";
      LANE_LNK_CFGOVRD : bit_vector := X"0000";
      LANE_PWR_CTRL_LANE0 : bit_vector := X"0400";
      LANE_PWR_CTRL_LANE1 : bit_vector := X"0400";
      LANE_PWR_CTRL_LANE2 : bit_vector := X"0400";
      LANE_PWR_CTRL_LANE3 : bit_vector := X"0400";
      LNK_TRN_CFG_LANE0 : bit_vector := X"0000";
      LNK_TRN_CFG_LANE1 : bit_vector := X"0000";
      LNK_TRN_CFG_LANE2 : bit_vector := X"0000";
      LNK_TRN_CFG_LANE3 : bit_vector := X"0000";
      LNK_TRN_COEFF_REQ_LANE0 : bit_vector := X"0000";
      LNK_TRN_COEFF_REQ_LANE1 : bit_vector := X"0000";
      LNK_TRN_COEFF_REQ_LANE2 : bit_vector := X"0000";
      LNK_TRN_COEFF_REQ_LANE3 : bit_vector := X"0000";
      MISC_CFG : bit_vector := X"0004";
      MODE_CFG1 : bit_vector := X"0000";
      MODE_CFG2 : bit_vector := X"0000";
      MODE_CFG3 : bit_vector := X"0000";
      MODE_CFG4 : bit_vector := X"0000";
      MODE_CFG5 : bit_vector := X"0000";
      MODE_CFG6 : bit_vector := X"0000";
      MODE_CFG7 : bit_vector := X"0000";
      PCS_ABILITY_LANE0 : bit_vector := X"0010";
      PCS_ABILITY_LANE1 : bit_vector := X"0010";
      PCS_ABILITY_LANE2 : bit_vector := X"0010";
      PCS_ABILITY_LANE3 : bit_vector := X"0010";
      PCS_CTRL1_LANE0 : bit_vector := X"2040";
      PCS_CTRL1_LANE1 : bit_vector := X"2040";
      PCS_CTRL1_LANE2 : bit_vector := X"2040";
      PCS_CTRL1_LANE3 : bit_vector := X"2040";
      PCS_CTRL2_LANE0 : bit_vector := X"0000";
      PCS_CTRL2_LANE1 : bit_vector := X"0000";
      PCS_CTRL2_LANE2 : bit_vector := X"0000";
      PCS_CTRL2_LANE3 : bit_vector := X"0000";
      PCS_MISC_CFG_0_LANE0 : bit_vector := X"1117";
      PCS_MISC_CFG_0_LANE1 : bit_vector := X"1117";
      PCS_MISC_CFG_0_LANE2 : bit_vector := X"1117";
      PCS_MISC_CFG_0_LANE3 : bit_vector := X"1117";
      PCS_MISC_CFG_1_LANE0 : bit_vector := X"0000";
      PCS_MISC_CFG_1_LANE1 : bit_vector := X"0000";
      PCS_MISC_CFG_1_LANE2 : bit_vector := X"0000";
      PCS_MISC_CFG_1_LANE3 : bit_vector := X"0000";
      PCS_MODE_LANE0 : bit_vector := X"0000";
      PCS_MODE_LANE1 : bit_vector := X"0000";
      PCS_MODE_LANE2 : bit_vector := X"0000";
      PCS_MODE_LANE3 : bit_vector := X"0000";
      PCS_RESET_1_LANE0 : bit_vector := X"0002";
      PCS_RESET_1_LANE1 : bit_vector := X"0002";
      PCS_RESET_1_LANE2 : bit_vector := X"0002";
      PCS_RESET_1_LANE3 : bit_vector := X"0002";
      PCS_RESET_LANE0 : bit_vector := X"0000";
      PCS_RESET_LANE1 : bit_vector := X"0000";
      PCS_RESET_LANE2 : bit_vector := X"0000";
      PCS_RESET_LANE3 : bit_vector := X"0000";
      PCS_TYPE_LANE0 : bit_vector := X"002C";
      PCS_TYPE_LANE1 : bit_vector := X"002C";
      PCS_TYPE_LANE2 : bit_vector := X"002C";
      PCS_TYPE_LANE3 : bit_vector := X"002C";
      PLL_CFG0 : bit_vector := X"58C0";
      PLL_CFG1 : bit_vector := X"8440";
      PLL_CFG2 : bit_vector := X"0424";
      PMA_CTRL1_LANE0 : bit_vector := X"0000";
      PMA_CTRL1_LANE1 : bit_vector := X"0000";
      PMA_CTRL1_LANE2 : bit_vector := X"0000";
      PMA_CTRL1_LANE3 : bit_vector := X"0000";
      PMA_CTRL2_LANE0 : bit_vector := X"000B";
      PMA_CTRL2_LANE1 : bit_vector := X"000B";
      PMA_CTRL2_LANE2 : bit_vector := X"000B";
      PMA_CTRL2_LANE3 : bit_vector := X"000B";
      PMA_LPBK_CTRL_LANE0 : bit_vector := X"0004";
      PMA_LPBK_CTRL_LANE1 : bit_vector := X"0004";
      PMA_LPBK_CTRL_LANE2 : bit_vector := X"0004";
      PMA_LPBK_CTRL_LANE3 : bit_vector := X"0004";
      PRBS_BER_CFG0_LANE0 : bit_vector := X"0000";
      PRBS_BER_CFG0_LANE1 : bit_vector := X"0000";
      PRBS_BER_CFG0_LANE2 : bit_vector := X"0000";
      PRBS_BER_CFG0_LANE3 : bit_vector := X"0000";
      PRBS_BER_CFG1_LANE0 : bit_vector := X"0000";
      PRBS_BER_CFG1_LANE1 : bit_vector := X"0000";
      PRBS_BER_CFG1_LANE2 : bit_vector := X"0000";
      PRBS_BER_CFG1_LANE3 : bit_vector := X"0000";
      PRBS_CFG_LANE0 : bit_vector := X"000A";
      PRBS_CFG_LANE1 : bit_vector := X"000A";
      PRBS_CFG_LANE2 : bit_vector := X"000A";
      PRBS_CFG_LANE3 : bit_vector := X"000A";
      PTRN_CFG0_LSB : bit_vector := X"5555";
      PTRN_CFG0_MSB : bit_vector := X"5555";
      PTRN_LEN_CFG : bit_vector := X"001F";
      PWRUP_DLY : bit_vector := X"0000";
      RX_AEQ_VAL0_LANE0 : bit_vector := X"0100";
      RX_AEQ_VAL0_LANE1 : bit_vector := X"0100";
      RX_AEQ_VAL0_LANE2 : bit_vector := X"0100";
      RX_AEQ_VAL0_LANE3 : bit_vector := X"0100";
      RX_AEQ_VAL1_LANE0 : bit_vector := X"0000";
      RX_AEQ_VAL1_LANE1 : bit_vector := X"0000";
      RX_AEQ_VAL1_LANE2 : bit_vector := X"0000";
      RX_AEQ_VAL1_LANE3 : bit_vector := X"0000";
      RX_AGC_CTRL_LANE0 : bit_vector := X"0000";
      RX_AGC_CTRL_LANE1 : bit_vector := X"0000";
      RX_AGC_CTRL_LANE2 : bit_vector := X"0000";
      RX_AGC_CTRL_LANE3 : bit_vector := X"0000";
      RX_CDR_CTRL0_LANE0 : bit_vector := X"0005";
      RX_CDR_CTRL0_LANE1 : bit_vector := X"0005";
      RX_CDR_CTRL0_LANE2 : bit_vector := X"0005";
      RX_CDR_CTRL0_LANE3 : bit_vector := X"0005";
      RX_CDR_CTRL1_LANE0 : bit_vector := X"4300";
      RX_CDR_CTRL1_LANE1 : bit_vector := X"4300";
      RX_CDR_CTRL1_LANE2 : bit_vector := X"4300";
      RX_CDR_CTRL1_LANE3 : bit_vector := X"4300";
      RX_CDR_CTRL2_LANE0 : bit_vector := X"2000";
      RX_CDR_CTRL2_LANE1 : bit_vector := X"2000";
      RX_CDR_CTRL2_LANE2 : bit_vector := X"2000";
      RX_CDR_CTRL2_LANE3 : bit_vector := X"2000";
      RX_CFG0_LANE0 : bit_vector := X"0B06";
      RX_CFG0_LANE1 : bit_vector := X"0B06";
      RX_CFG0_LANE2 : bit_vector := X"0B06";
      RX_CFG0_LANE3 : bit_vector := X"0B06";
      RX_CFG1_LANE0 : bit_vector := X"817F";
      RX_CFG1_LANE1 : bit_vector := X"817F";
      RX_CFG1_LANE2 : bit_vector := X"817F";
      RX_CFG1_LANE3 : bit_vector := X"817F";
      RX_CFG2_LANE0 : bit_vector := X"1000";
      RX_CFG2_LANE1 : bit_vector := X"1000";
      RX_CFG2_LANE2 : bit_vector := X"1000";
      RX_CFG2_LANE3 : bit_vector := X"1000";
      RX_CTLE_CTRL_LANE0 : bit_vector := X"007F";
      RX_CTLE_CTRL_LANE1 : bit_vector := X"007F";
      RX_CTLE_CTRL_LANE2 : bit_vector := X"007F";
      RX_CTLE_CTRL_LANE3 : bit_vector := X"007F";
      RX_CTRL_OVRD_LANE0 : bit_vector := X"000C";
      RX_CTRL_OVRD_LANE1 : bit_vector := X"000C";
      RX_CTRL_OVRD_LANE2 : bit_vector := X"000C";
      RX_CTRL_OVRD_LANE3 : bit_vector := X"000C";
      RX_FABRIC_WIDTH0 : integer := 6466;
      RX_FABRIC_WIDTH1 : integer := 6466;
      RX_FABRIC_WIDTH2 : integer := 6466;
      RX_FABRIC_WIDTH3 : integer := 6466;
      RX_LOOP_CTRL_LANE0 : bit_vector := X"0070";
      RX_LOOP_CTRL_LANE1 : bit_vector := X"0070";
      RX_LOOP_CTRL_LANE2 : bit_vector := X"0070";
      RX_LOOP_CTRL_LANE3 : bit_vector := X"0070";
      RX_MVAL0_LANE0 : bit_vector := X"0000";
      RX_MVAL0_LANE1 : bit_vector := X"0000";
      RX_MVAL0_LANE2 : bit_vector := X"0000";
      RX_MVAL0_LANE3 : bit_vector := X"0000";
      RX_MVAL1_LANE0 : bit_vector := X"0000";
      RX_MVAL1_LANE1 : bit_vector := X"0000";
      RX_MVAL1_LANE2 : bit_vector := X"0000";
      RX_MVAL1_LANE3 : bit_vector := X"0000";
      RX_P0S_CTRL : bit_vector := X"1206";
      RX_P0_CTRL : bit_vector := X"11F0";
      RX_P1_CTRL : bit_vector := X"120F";
      RX_P2_CTRL : bit_vector := X"0E0F";
      RX_PI_CTRL0 : bit_vector := X"B2F2";
      RX_PI_CTRL1 : bit_vector := X"0080";
      SIM_GTHRESET_SPEEDUP : integer := 1;
      SIM_VERSION : string := "1.0";
      SLICE_CFG : bit_vector := X"0000";
      SLICE_NOISE_CTRL_0_LANE01 : bit_vector := X"0000";
      SLICE_NOISE_CTRL_0_LANE23 : bit_vector := X"0000";
      SLICE_NOISE_CTRL_1_LANE01 : bit_vector := X"0000";
      SLICE_NOISE_CTRL_1_LANE23 : bit_vector := X"0000";
      SLICE_NOISE_CTRL_2_LANE01 : bit_vector := X"EFFF";
      SLICE_NOISE_CTRL_2_LANE23 : bit_vector := X"EFFF";
      SLICE_TX_RESET_LANE01 : bit_vector := X"0000";
      SLICE_TX_RESET_LANE23 : bit_vector := X"0000";
      TERM_CTRL_LANE0 : bit_vector := X"0000";
      TERM_CTRL_LANE1 : bit_vector := X"0000";
      TERM_CTRL_LANE2 : bit_vector := X"0000";
      TERM_CTRL_LANE3 : bit_vector := X"0000";
      TX_CFG0_LANE0 : bit_vector := X"203D";
      TX_CFG0_LANE1 : bit_vector := X"203D";
      TX_CFG0_LANE2 : bit_vector := X"203D";
      TX_CFG0_LANE3 : bit_vector := X"203D";
      TX_CFG1_LANE0 : bit_vector := X"0C83";
      TX_CFG1_LANE1 : bit_vector := X"0C83";
      TX_CFG1_LANE2 : bit_vector := X"0C83";
      TX_CFG1_LANE3 : bit_vector := X"0C83";
      TX_CFG2_LANE0 : bit_vector := X"0001";
      TX_CFG2_LANE1 : bit_vector := X"0001";
      TX_CFG2_LANE2 : bit_vector := X"0001";
      TX_CFG2_LANE3 : bit_vector := X"0001";
      TX_CLK_SEL0_LANE0 : bit_vector := X"2F2F";
      TX_CLK_SEL0_LANE1 : bit_vector := X"2F2F";
      TX_CLK_SEL0_LANE2 : bit_vector := X"2F2F";
      TX_CLK_SEL0_LANE3 : bit_vector := X"2F2F";
      TX_CLK_SEL1_LANE0 : bit_vector := X"2F2F";
      TX_CLK_SEL1_LANE1 : bit_vector := X"2F2F";
      TX_CLK_SEL1_LANE2 : bit_vector := X"2F2F";
      TX_CLK_SEL1_LANE3 : bit_vector := X"2F2F";
      TX_DISABLE_LANE0 : bit_vector := X"0000";
      TX_DISABLE_LANE1 : bit_vector := X"0000";
      TX_DISABLE_LANE2 : bit_vector := X"0000";
      TX_DISABLE_LANE3 : bit_vector := X"0000";
      TX_FABRIC_WIDTH0 : integer := 6466;
      TX_FABRIC_WIDTH1 : integer := 6466;
      TX_FABRIC_WIDTH2 : integer := 6466;
      TX_FABRIC_WIDTH3 : integer := 6466;
      TX_P0P0S_CTRL : bit_vector := X"060C";
      TX_P1P2_CTRL : bit_vector := X"0C39";
      TX_PREEMPH_LANE0 : bit_vector := X"A0F0";
      TX_PREEMPH_LANE1 : bit_vector := X"A0F0";
      TX_PREEMPH_LANE2 : bit_vector := X"A0F0";
      TX_PREEMPH_LANE3 : bit_vector := X"A0F0";
      TX_PWR_RATE_OVRD_LANE0 : bit_vector := X"0060";
      TX_PWR_RATE_OVRD_LANE1 : bit_vector := X"0060";
      TX_PWR_RATE_OVRD_LANE2 : bit_vector := X"0060";
      TX_PWR_RATE_OVRD_LANE3 : bit_vector := X"0060";
      tipd_DADDR : VitalDelayArrayType01 (15 downto 0) := (others => (0 ps, 0 ps));
      tipd_DCLK : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_DEN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_DFETRAINCTRL0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_DFETRAINCTRL1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_DFETRAINCTRL2 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_DFETRAINCTRL3 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_DI : VitalDelayArrayType01 (15 downto 0) := (others => (0 ps, 0 ps));
      tipd_DISABLEDRP : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_DWE : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_GTHINIT : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_GTHRESET : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_GTHX2LANE01 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_GTHX2LANE23 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_GTHX4LANE : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_MGMTPCSLANESEL : VitalDelayArrayType01 (3 downto 0) := (others => (0 ps, 0 ps));
      tipd_MGMTPCSMMDADDR : VitalDelayArrayType01 (4 downto 0) := (others => (0 ps, 0 ps));
      tipd_MGMTPCSREGADDR : VitalDelayArrayType01 (15 downto 0) := (others => (0 ps, 0 ps));
      tipd_MGMTPCSREGRD : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_MGMTPCSREGWR : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_MGMTPCSWRDATA : VitalDelayArrayType01 (15 downto 0) := (others => (0 ps, 0 ps));
      tipd_PLLPCSCLKDIV : VitalDelayArrayType01 (5 downto 0) := (others => (0 ps, 0 ps));
      tipd_PLLREFCLKSEL : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_POWERDOWN0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_POWERDOWN1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_POWERDOWN2 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_POWERDOWN3 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_REFCLK : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXBUFRESET0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXBUFRESET1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXBUFRESET2 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXBUFRESET3 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXENCOMMADET0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXENCOMMADET1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXENCOMMADET2 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXENCOMMADET3 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXN0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXN1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXN2 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXN3 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXP0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXP1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXP2 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXP3 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXPOLARITY0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXPOLARITY1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXPOLARITY2 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXPOLARITY3 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXPOWERDOWN0 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_RXPOWERDOWN1 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_RXPOWERDOWN2 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_RXPOWERDOWN3 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_RXRATE0 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_RXRATE1 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_RXRATE2 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_RXRATE3 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_RXSLIP0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXSLIP1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXSLIP2 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXSLIP3 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXUSERCLKIN0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXUSERCLKIN1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXUSERCLKIN2 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RXUSERCLKIN3 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_SAMPLERATE0 : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_SAMPLERATE1 : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_SAMPLERATE2 : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_SAMPLERATE3 : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXBUFRESET0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXBUFRESET1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXBUFRESET2 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXBUFRESET3 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXCTRL0 : VitalDelayArrayType01 (7 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXCTRL1 : VitalDelayArrayType01 (7 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXCTRL2 : VitalDelayArrayType01 (7 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXCTRL3 : VitalDelayArrayType01 (7 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXDATA0 : VitalDelayArrayType01 (63 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXDATA1 : VitalDelayArrayType01 (63 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXDATA2 : VitalDelayArrayType01 (63 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXDATA3 : VitalDelayArrayType01 (63 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXDATAMSB0 : VitalDelayArrayType01 (7 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXDATAMSB1 : VitalDelayArrayType01 (7 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXDATAMSB2 : VitalDelayArrayType01 (7 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXDATAMSB3 : VitalDelayArrayType01 (7 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXDEEMPH0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXDEEMPH1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXDEEMPH2 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXDEEMPH3 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXMARGIN0 : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXMARGIN1 : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXMARGIN2 : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXMARGIN3 : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXPOWERDOWN0 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXPOWERDOWN1 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXPOWERDOWN2 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXPOWERDOWN3 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXRATE0 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXRATE1 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXRATE2 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXRATE3 : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_TXUSERCLKIN0 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXUSERCLKIN1 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXUSERCLKIN2 : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TXUSERCLKIN3 : VitalDelayType01 :=  (0 ps, 0 ps);
      tpd_DCLK_DRDY : VitalDelayType01 := (0 ps, 0 ps);
      tpd_DCLK_DRPDO : VitalDelayArrayType01(15 downto 0) := (others => (0 ps, 0 ps));
      tpd_DCLK_GTHINITDONE : VitalDelayType01 := (0 ps, 0 ps);
      tpd_DCLK_MGMTPCSRDACK : VitalDelayType01 := (0 ps, 0 ps);
      tpd_DCLK_MGMTPCSRDDATA : VitalDelayArrayType01(15 downto 0) := (others => (0 ps, 0 ps));
      tpd_REFCLK_TSTREFCLKFAB : VitalDelayType01 := (0 ps, 0 ps);
      tpd_REFCLK_TSTREFCLKOUT : VitalDelayType01 := (0 ps, 0 ps);
      tpd_RXUSERCLKIN0_RXCODEERR0 : VitalDelayArrayType01(7 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSERCLKIN0_RXCTRL0 : VitalDelayArrayType01(7 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSERCLKIN0_RXDATA0 : VitalDelayArrayType01(63 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSERCLKIN0_RXDISPERR0 : VitalDelayArrayType01(7 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSERCLKIN0_RXVALID0 : VitalDelayArrayType01(7 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSERCLKIN1_RXCODEERR1 : VitalDelayArrayType01(7 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSERCLKIN1_RXCTRL1 : VitalDelayArrayType01(7 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSERCLKIN1_RXDATA1 : VitalDelayArrayType01(63 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSERCLKIN1_RXDISPERR1 : VitalDelayArrayType01(7 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSERCLKIN1_RXVALID1 : VitalDelayArrayType01(7 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSERCLKIN2_RXCODEERR2 : VitalDelayArrayType01(7 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSERCLKIN2_RXCTRL2 : VitalDelayArrayType01(7 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSERCLKIN2_RXDATA2 : VitalDelayArrayType01(63 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSERCLKIN2_RXDISPERR2 : VitalDelayArrayType01(7 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSERCLKIN2_RXVALID2 : VitalDelayArrayType01(7 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSERCLKIN3_RXCODEERR3 : VitalDelayArrayType01(7 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSERCLKIN3_RXCTRL3 : VitalDelayArrayType01(7 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSERCLKIN3_RXDATA3 : VitalDelayArrayType01(63 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSERCLKIN3_RXDISPERR3 : VitalDelayArrayType01(7 downto 0) := (others => (0 ps, 0 ps));
      tpd_RXUSERCLKIN3_RXVALID3 : VitalDelayArrayType01(7 downto 0) := (others => (0 ps, 0 ps));
      tpd_TXUSERCLKIN0_RXCTRLACK0 : VitalDelayType01 := (0 ps, 0 ps);
      tpd_TXUSERCLKIN0_TXCTRLACK0 : VitalDelayType01 := (0 ps, 0 ps);
      tpd_TXUSERCLKIN1_RXCTRLACK1 : VitalDelayType01 := (0 ps, 0 ps);
      tpd_TXUSERCLKIN1_TXCTRLACK1 : VitalDelayType01 := (0 ps, 0 ps);
      tpd_TXUSERCLKIN2_RXCTRLACK2 : VitalDelayType01 := (0 ps, 0 ps);
      tpd_TXUSERCLKIN2_TXCTRLACK2 : VitalDelayType01 := (0 ps, 0 ps);
      tpd_TXUSERCLKIN3_RXCTRLACK3 : VitalDelayType01 := (0 ps, 0 ps);
      tpd_TXUSERCLKIN3_TXCTRLACK3 : VitalDelayType01 := (0 ps, 0 ps);
      thold_DADDR_DCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_DADDR_DCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_DEN_DCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_DEN_DCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_DFETRAINCTRL0_DCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_DFETRAINCTRL0_DCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_DFETRAINCTRL1_DCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_DFETRAINCTRL1_DCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_DFETRAINCTRL2_DCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_DFETRAINCTRL2_DCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_DFETRAINCTRL3_DCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_DFETRAINCTRL3_DCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_DISABLEDRP_DCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_DISABLEDRP_DCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_DI_DCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_DI_DCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_DWE_DCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_DWE_DCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_GTHINIT_DCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_GTHINIT_DCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_MGMTPCSLANESEL_DCLK_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      thold_MGMTPCSLANESEL_DCLK_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      thold_MGMTPCSMMDADDR_DCLK_negedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
      thold_MGMTPCSMMDADDR_DCLK_posedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
      thold_MGMTPCSREGADDR_DCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_MGMTPCSREGADDR_DCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_MGMTPCSREGRD_DCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_MGMTPCSREGRD_DCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_MGMTPCSREGWR_DCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_MGMTPCSREGWR_DCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_MGMTPCSWRDATA_DCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_MGMTPCSWRDATA_DCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_PLLPCSCLKDIV_DCLK_negedge_posedge : VitalDelayArrayType(5 downto 0) := (others => 0 ps);
      thold_PLLPCSCLKDIV_DCLK_posedge_posedge : VitalDelayArrayType(5 downto 0) := (others => 0 ps);
      thold_RXBUFRESET0_RXUSERCLKIN0_negedge_posedge : VitalDelayType := 0 ps;
      thold_RXBUFRESET0_RXUSERCLKIN0_posedge_posedge : VitalDelayType := 0 ps;
      thold_RXBUFRESET1_RXUSERCLKIN1_negedge_posedge : VitalDelayType := 0 ps;
      thold_RXBUFRESET1_RXUSERCLKIN1_posedge_posedge : VitalDelayType := 0 ps;
      thold_RXBUFRESET2_RXUSERCLKIN2_negedge_posedge : VitalDelayType := 0 ps;
      thold_RXBUFRESET2_RXUSERCLKIN2_posedge_posedge : VitalDelayType := 0 ps;
      thold_RXBUFRESET3_RXUSERCLKIN3_negedge_posedge : VitalDelayType := 0 ps;
      thold_RXBUFRESET3_RXUSERCLKIN3_posedge_posedge : VitalDelayType := 0 ps;
      thold_RXENCOMMADET0_RXUSERCLKIN0_negedge_posedge : VitalDelayType := 0 ps;
      thold_RXENCOMMADET0_RXUSERCLKIN0_posedge_posedge : VitalDelayType := 0 ps;
      thold_RXENCOMMADET1_RXUSERCLKIN1_negedge_posedge : VitalDelayType := 0 ps;
      thold_RXENCOMMADET1_RXUSERCLKIN1_posedge_posedge : VitalDelayType := 0 ps;
      thold_RXENCOMMADET2_RXUSERCLKIN2_negedge_posedge : VitalDelayType := 0 ps;
      thold_RXENCOMMADET2_RXUSERCLKIN2_posedge_posedge : VitalDelayType := 0 ps;
      thold_RXENCOMMADET3_RXUSERCLKIN3_negedge_posedge : VitalDelayType := 0 ps;
      thold_RXENCOMMADET3_RXUSERCLKIN3_posedge_posedge : VitalDelayType := 0 ps;
      thold_RXPOLARITY0_RXUSERCLKIN0_negedge_posedge : VitalDelayType := 0 ps;
      thold_RXPOLARITY0_RXUSERCLKIN0_posedge_posedge : VitalDelayType := 0 ps;
      thold_RXPOLARITY1_RXUSERCLKIN1_negedge_posedge : VitalDelayType := 0 ps;
      thold_RXPOLARITY1_RXUSERCLKIN1_posedge_posedge : VitalDelayType := 0 ps;
      thold_RXPOLARITY2_RXUSERCLKIN2_negedge_posedge : VitalDelayType := 0 ps;
      thold_RXPOLARITY2_RXUSERCLKIN2_posedge_posedge : VitalDelayType := 0 ps;
      thold_RXPOLARITY3_RXUSERCLKIN3_negedge_posedge : VitalDelayType := 0 ps;
      thold_RXPOLARITY3_RXUSERCLKIN3_posedge_posedge : VitalDelayType := 0 ps;
      thold_RXPOWERDOWN0_TXUSERCLKIN0_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_RXPOWERDOWN0_TXUSERCLKIN0_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_RXPOWERDOWN1_TXUSERCLKIN1_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_RXPOWERDOWN1_TXUSERCLKIN1_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_RXPOWERDOWN2_TXUSERCLKIN2_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_RXPOWERDOWN2_TXUSERCLKIN2_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_RXPOWERDOWN3_TXUSERCLKIN3_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_RXPOWERDOWN3_TXUSERCLKIN3_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_RXRATE0_TXUSERCLKIN0_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_RXRATE0_TXUSERCLKIN0_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_RXRATE1_TXUSERCLKIN1_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_RXRATE1_TXUSERCLKIN1_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_RXRATE2_TXUSERCLKIN2_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_RXRATE2_TXUSERCLKIN2_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_RXRATE3_TXUSERCLKIN3_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_RXRATE3_TXUSERCLKIN3_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_SAMPLERATE0_TXUSERCLKIN0_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_SAMPLERATE0_TXUSERCLKIN0_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_SAMPLERATE1_TXUSERCLKIN1_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_SAMPLERATE1_TXUSERCLKIN1_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_SAMPLERATE2_TXUSERCLKIN2_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_SAMPLERATE2_TXUSERCLKIN2_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_SAMPLERATE3_TXUSERCLKIN3_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_SAMPLERATE3_TXUSERCLKIN3_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_TXBUFRESET0_TXUSERCLKIN0_negedge_posedge : VitalDelayType := 0 ps;
      thold_TXBUFRESET0_TXUSERCLKIN0_posedge_posedge : VitalDelayType := 0 ps;
      thold_TXBUFRESET1_TXUSERCLKIN1_negedge_posedge : VitalDelayType := 0 ps;
      thold_TXBUFRESET1_TXUSERCLKIN1_posedge_posedge : VitalDelayType := 0 ps;
      thold_TXBUFRESET2_TXUSERCLKIN2_negedge_posedge : VitalDelayType := 0 ps;
      thold_TXBUFRESET2_TXUSERCLKIN2_posedge_posedge : VitalDelayType := 0 ps;
      thold_TXBUFRESET3_TXUSERCLKIN3_negedge_posedge : VitalDelayType := 0 ps;
      thold_TXBUFRESET3_TXUSERCLKIN3_posedge_posedge : VitalDelayType := 0 ps;
      thold_TXCTRL0_TXUSERCLKIN0_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_TXCTRL0_TXUSERCLKIN0_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_TXCTRL1_TXUSERCLKIN1_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_TXCTRL1_TXUSERCLKIN1_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_TXCTRL2_TXUSERCLKIN2_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_TXCTRL2_TXUSERCLKIN2_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_TXCTRL3_TXUSERCLKIN3_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_TXCTRL3_TXUSERCLKIN3_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_TXDATA0_TXUSERCLKIN0_negedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0 ps);
      thold_TXDATA0_TXUSERCLKIN0_posedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0 ps);
      thold_TXDATA1_TXUSERCLKIN1_negedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0 ps);
      thold_TXDATA1_TXUSERCLKIN1_posedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0 ps);
      thold_TXDATA2_TXUSERCLKIN2_negedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0 ps);
      thold_TXDATA2_TXUSERCLKIN2_posedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0 ps);
      thold_TXDATA3_TXUSERCLKIN3_negedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0 ps);
      thold_TXDATA3_TXUSERCLKIN3_posedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0 ps);
      thold_TXDATAMSB0_TXUSERCLKIN0_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_TXDATAMSB0_TXUSERCLKIN0_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_TXDATAMSB1_TXUSERCLKIN1_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_TXDATAMSB1_TXUSERCLKIN1_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_TXDATAMSB2_TXUSERCLKIN2_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_TXDATAMSB2_TXUSERCLKIN2_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_TXDATAMSB3_TXUSERCLKIN3_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_TXDATAMSB3_TXUSERCLKIN3_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_TXDEEMPH0_TXUSERCLKIN0_negedge_posedge : VitalDelayType := 0 ps;
      thold_TXDEEMPH0_TXUSERCLKIN0_posedge_posedge : VitalDelayType := 0 ps;
      thold_TXDEEMPH1_TXUSERCLKIN1_negedge_posedge : VitalDelayType := 0 ps;
      thold_TXDEEMPH1_TXUSERCLKIN1_posedge_posedge : VitalDelayType := 0 ps;
      thold_TXDEEMPH2_TXUSERCLKIN2_negedge_posedge : VitalDelayType := 0 ps;
      thold_TXDEEMPH2_TXUSERCLKIN2_posedge_posedge : VitalDelayType := 0 ps;
      thold_TXDEEMPH3_TXUSERCLKIN3_negedge_posedge : VitalDelayType := 0 ps;
      thold_TXDEEMPH3_TXUSERCLKIN3_posedge_posedge : VitalDelayType := 0 ps;
      thold_TXMARGIN0_TXUSERCLKIN0_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_TXMARGIN0_TXUSERCLKIN0_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_TXMARGIN1_TXUSERCLKIN1_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_TXMARGIN1_TXUSERCLKIN1_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_TXMARGIN2_TXUSERCLKIN2_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_TXMARGIN2_TXUSERCLKIN2_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_TXMARGIN3_TXUSERCLKIN3_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_TXMARGIN3_TXUSERCLKIN3_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_TXPOWERDOWN0_TXUSERCLKIN0_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_TXPOWERDOWN0_TXUSERCLKIN0_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_TXPOWERDOWN1_TXUSERCLKIN1_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_TXPOWERDOWN1_TXUSERCLKIN1_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_TXPOWERDOWN2_TXUSERCLKIN2_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_TXPOWERDOWN2_TXUSERCLKIN2_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_TXPOWERDOWN3_TXUSERCLKIN3_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_TXPOWERDOWN3_TXUSERCLKIN3_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_TXRATE0_TXUSERCLKIN0_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_TXRATE0_TXUSERCLKIN0_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_TXRATE1_TXUSERCLKIN1_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_TXRATE1_TXUSERCLKIN1_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_TXRATE2_TXUSERCLKIN2_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_TXRATE2_TXUSERCLKIN2_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_TXRATE3_TXUSERCLKIN3_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_TXRATE3_TXUSERCLKIN3_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_DADDR_DCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_DADDR_DCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_DEN_DCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_DEN_DCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_DFETRAINCTRL0_DCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_DFETRAINCTRL0_DCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_DFETRAINCTRL1_DCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_DFETRAINCTRL1_DCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_DFETRAINCTRL2_DCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_DFETRAINCTRL2_DCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_DFETRAINCTRL3_DCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_DFETRAINCTRL3_DCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_DISABLEDRP_DCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_DISABLEDRP_DCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_DI_DCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_DI_DCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_DWE_DCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_DWE_DCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_GTHINIT_DCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_GTHINIT_DCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_MGMTPCSLANESEL_DCLK_negedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      tsetup_MGMTPCSLANESEL_DCLK_posedge_posedge : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      tsetup_MGMTPCSMMDADDR_DCLK_negedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
      tsetup_MGMTPCSMMDADDR_DCLK_posedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
      tsetup_MGMTPCSREGADDR_DCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_MGMTPCSREGADDR_DCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_MGMTPCSREGRD_DCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_MGMTPCSREGRD_DCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_MGMTPCSREGWR_DCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_MGMTPCSREGWR_DCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_MGMTPCSWRDATA_DCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_MGMTPCSWRDATA_DCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_PLLPCSCLKDIV_DCLK_negedge_posedge : VitalDelayArrayType(5 downto 0) := (others => 0 ps);
      tsetup_PLLPCSCLKDIV_DCLK_posedge_posedge : VitalDelayArrayType(5 downto 0) := (others => 0 ps);
      tsetup_RXBUFRESET0_RXUSERCLKIN0_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXBUFRESET0_RXUSERCLKIN0_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXBUFRESET1_RXUSERCLKIN1_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXBUFRESET1_RXUSERCLKIN1_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXBUFRESET2_RXUSERCLKIN2_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXBUFRESET2_RXUSERCLKIN2_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXBUFRESET3_RXUSERCLKIN3_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXBUFRESET3_RXUSERCLKIN3_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXENCOMMADET0_RXUSERCLKIN0_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXENCOMMADET0_RXUSERCLKIN0_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXENCOMMADET1_RXUSERCLKIN1_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXENCOMMADET1_RXUSERCLKIN1_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXENCOMMADET2_RXUSERCLKIN2_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXENCOMMADET2_RXUSERCLKIN2_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXENCOMMADET3_RXUSERCLKIN3_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXENCOMMADET3_RXUSERCLKIN3_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXPOLARITY0_RXUSERCLKIN0_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXPOLARITY0_RXUSERCLKIN0_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXPOLARITY1_RXUSERCLKIN1_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXPOLARITY1_RXUSERCLKIN1_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXPOLARITY2_RXUSERCLKIN2_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXPOLARITY2_RXUSERCLKIN2_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXPOLARITY3_RXUSERCLKIN3_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXPOLARITY3_RXUSERCLKIN3_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_RXPOWERDOWN0_TXUSERCLKIN0_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_RXPOWERDOWN0_TXUSERCLKIN0_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_RXPOWERDOWN1_TXUSERCLKIN1_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_RXPOWERDOWN1_TXUSERCLKIN1_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_RXPOWERDOWN2_TXUSERCLKIN2_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_RXPOWERDOWN2_TXUSERCLKIN2_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_RXPOWERDOWN3_TXUSERCLKIN3_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_RXPOWERDOWN3_TXUSERCLKIN3_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_RXRATE0_TXUSERCLKIN0_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_RXRATE0_TXUSERCLKIN0_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_RXRATE1_TXUSERCLKIN1_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_RXRATE1_TXUSERCLKIN1_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_RXRATE2_TXUSERCLKIN2_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_RXRATE2_TXUSERCLKIN2_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_RXRATE3_TXUSERCLKIN3_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_RXRATE3_TXUSERCLKIN3_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_SAMPLERATE0_TXUSERCLKIN0_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_SAMPLERATE0_TXUSERCLKIN0_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_SAMPLERATE1_TXUSERCLKIN1_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_SAMPLERATE1_TXUSERCLKIN1_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_SAMPLERATE2_TXUSERCLKIN2_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_SAMPLERATE2_TXUSERCLKIN2_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_SAMPLERATE3_TXUSERCLKIN3_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_SAMPLERATE3_TXUSERCLKIN3_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_TXBUFRESET0_TXUSERCLKIN0_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXBUFRESET0_TXUSERCLKIN0_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXBUFRESET1_TXUSERCLKIN1_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXBUFRESET1_TXUSERCLKIN1_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXBUFRESET2_TXUSERCLKIN2_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXBUFRESET2_TXUSERCLKIN2_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXBUFRESET3_TXUSERCLKIN3_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXBUFRESET3_TXUSERCLKIN3_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXCTRL0_TXUSERCLKIN0_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_TXCTRL0_TXUSERCLKIN0_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_TXCTRL1_TXUSERCLKIN1_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_TXCTRL1_TXUSERCLKIN1_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_TXCTRL2_TXUSERCLKIN2_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_TXCTRL2_TXUSERCLKIN2_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_TXCTRL3_TXUSERCLKIN3_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_TXCTRL3_TXUSERCLKIN3_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0 ps);
      tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0 ps);
      tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0 ps);
      tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0 ps);
      tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0 ps);
      tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0 ps);
      tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0 ps);
      tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0 ps);
      tsetup_TXDATAMSB0_TXUSERCLKIN0_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_TXDATAMSB0_TXUSERCLKIN0_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_TXDATAMSB1_TXUSERCLKIN1_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_TXDATAMSB1_TXUSERCLKIN1_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_TXDATAMSB2_TXUSERCLKIN2_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_TXDATAMSB2_TXUSERCLKIN2_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_TXDATAMSB3_TXUSERCLKIN3_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_TXDATAMSB3_TXUSERCLKIN3_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_TXDEEMPH0_TXUSERCLKIN0_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXDEEMPH0_TXUSERCLKIN0_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXDEEMPH1_TXUSERCLKIN1_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXDEEMPH1_TXUSERCLKIN1_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXDEEMPH2_TXUSERCLKIN2_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXDEEMPH2_TXUSERCLKIN2_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXDEEMPH3_TXUSERCLKIN3_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXDEEMPH3_TXUSERCLKIN3_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_TXMARGIN0_TXUSERCLKIN0_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_TXMARGIN0_TXUSERCLKIN0_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_TXMARGIN1_TXUSERCLKIN1_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_TXMARGIN1_TXUSERCLKIN1_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_TXMARGIN2_TXUSERCLKIN2_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_TXMARGIN2_TXUSERCLKIN2_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_TXMARGIN3_TXUSERCLKIN3_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_TXMARGIN3_TXUSERCLKIN3_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_TXPOWERDOWN0_TXUSERCLKIN0_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_TXPOWERDOWN0_TXUSERCLKIN0_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_TXPOWERDOWN1_TXUSERCLKIN1_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_TXPOWERDOWN1_TXUSERCLKIN1_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_TXPOWERDOWN2_TXUSERCLKIN2_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_TXPOWERDOWN2_TXUSERCLKIN2_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_TXPOWERDOWN3_TXUSERCLKIN3_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_TXPOWERDOWN3_TXUSERCLKIN3_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_TXRATE0_TXUSERCLKIN0_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_TXRATE0_TXUSERCLKIN0_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_TXRATE1_TXUSERCLKIN1_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_TXRATE1_TXUSERCLKIN1_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_TXRATE2_TXUSERCLKIN2_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_TXRATE2_TXUSERCLKIN2_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_TXRATE3_TXUSERCLKIN3_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_TXRATE3_TXUSERCLKIN3_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tisd_DADDR_DCLK : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tisd_DEN_DCLK : VitalDelayType := 0 ps;
      tisd_DFETRAINCTRL0_DCLK : VitalDelayType := 0 ps;
      tisd_DFETRAINCTRL1_DCLK : VitalDelayType := 0 ps;
      tisd_DFETRAINCTRL2_DCLK : VitalDelayType := 0 ps;
      tisd_DFETRAINCTRL3_DCLK : VitalDelayType := 0 ps;
      tisd_DISABLEDRP_DCLK : VitalDelayType := 0 ps;
      tisd_DI_DCLK : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tisd_DWE_DCLK : VitalDelayType := 0 ps;
      tisd_GTHINIT_DCLK : VitalDelayType := 0 ps;
      tisd_MGMTPCSLANESEL_DCLK : VitalDelayArrayType(3 downto 0) := (others => 0 ps);
      tisd_MGMTPCSMMDADDR_DCLK : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
      tisd_MGMTPCSREGADDR_DCLK : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tisd_MGMTPCSREGRD_DCLK : VitalDelayType := 0 ps;
      tisd_MGMTPCSREGWR_DCLK : VitalDelayType := 0 ps;
      tisd_MGMTPCSWRDATA_DCLK : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tisd_PLLPCSCLKDIV_DCLK : VitalDelayArrayType(5 downto 0) := (others => 0 ps);
      tisd_RXBUFRESET0_RXUSERCLKIN0 : VitalDelayType := 0 ps;
      tisd_RXBUFRESET1_RXUSERCLKIN1 : VitalDelayType := 0 ps;
      tisd_RXBUFRESET2_RXUSERCLKIN2 : VitalDelayType := 0 ps;
      tisd_RXBUFRESET3_RXUSERCLKIN3 : VitalDelayType := 0 ps;
      tisd_RXENCOMMADET0_RXUSERCLKIN0 : VitalDelayType := 0 ps;
      tisd_RXENCOMMADET1_RXUSERCLKIN1 : VitalDelayType := 0 ps;
      tisd_RXENCOMMADET2_RXUSERCLKIN2 : VitalDelayType := 0 ps;
      tisd_RXENCOMMADET3_RXUSERCLKIN3 : VitalDelayType := 0 ps;
      tisd_RXPOLARITY0_RXUSERCLKIN0 : VitalDelayType := 0 ps;
      tisd_RXPOLARITY1_RXUSERCLKIN1 : VitalDelayType := 0 ps;
      tisd_RXPOLARITY2_RXUSERCLKIN2 : VitalDelayType := 0 ps;
      tisd_RXPOLARITY3_RXUSERCLKIN3 : VitalDelayType := 0 ps;
      tisd_RXPOWERDOWN0_TXUSERCLKIN0 : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tisd_RXPOWERDOWN1_TXUSERCLKIN1 : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tisd_RXPOWERDOWN2_TXUSERCLKIN2 : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tisd_RXPOWERDOWN3_TXUSERCLKIN3 : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tisd_RXRATE0_TXUSERCLKIN0 : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tisd_RXRATE1_TXUSERCLKIN1 : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tisd_RXRATE2_TXUSERCLKIN2 : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tisd_RXRATE3_TXUSERCLKIN3 : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tisd_SAMPLERATE0_TXUSERCLKIN0 : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tisd_SAMPLERATE1_TXUSERCLKIN1 : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tisd_SAMPLERATE2_TXUSERCLKIN2 : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tisd_SAMPLERATE3_TXUSERCLKIN3 : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tisd_TXBUFRESET0_TXUSERCLKIN0 : VitalDelayType := 0 ps;
      tisd_TXBUFRESET1_TXUSERCLKIN1 : VitalDelayType := 0 ps;
      tisd_TXBUFRESET2_TXUSERCLKIN2 : VitalDelayType := 0 ps;
      tisd_TXBUFRESET3_TXUSERCLKIN3 : VitalDelayType := 0 ps;
      tisd_TXCTRL0_TXUSERCLKIN0 : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tisd_TXCTRL1_TXUSERCLKIN1 : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tisd_TXCTRL2_TXUSERCLKIN2 : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tisd_TXCTRL3_TXUSERCLKIN3 : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tisd_TXDATA0_TXUSERCLKIN0 : VitalDelayArrayType(63 downto 0) := (others => 0 ps);
      tisd_TXDATA1_TXUSERCLKIN1 : VitalDelayArrayType(63 downto 0) := (others => 0 ps);
      tisd_TXDATA2_TXUSERCLKIN2 : VitalDelayArrayType(63 downto 0) := (others => 0 ps);
      tisd_TXDATA3_TXUSERCLKIN3 : VitalDelayArrayType(63 downto 0) := (others => 0 ps);
      tisd_TXDATAMSB0_TXUSERCLKIN0 : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tisd_TXDATAMSB1_TXUSERCLKIN1 : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tisd_TXDATAMSB2_TXUSERCLKIN2 : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tisd_TXDATAMSB3_TXUSERCLKIN3 : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tisd_TXDEEMPH0_TXUSERCLKIN0 : VitalDelayType := 0 ps;
      tisd_TXDEEMPH1_TXUSERCLKIN1 : VitalDelayType := 0 ps;
      tisd_TXDEEMPH2_TXUSERCLKIN2 : VitalDelayType := 0 ps;
      tisd_TXDEEMPH3_TXUSERCLKIN3 : VitalDelayType := 0 ps;
      tisd_TXMARGIN0_TXUSERCLKIN0 : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tisd_TXMARGIN1_TXUSERCLKIN1 : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tisd_TXMARGIN2_TXUSERCLKIN2 : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tisd_TXMARGIN3_TXUSERCLKIN3 : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tisd_TXPOWERDOWN0_TXUSERCLKIN0 : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tisd_TXPOWERDOWN1_TXUSERCLKIN1 : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tisd_TXPOWERDOWN2_TXUSERCLKIN2 : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tisd_TXPOWERDOWN3_TXUSERCLKIN3 : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tisd_TXRATE0_TXUSERCLKIN0 : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tisd_TXRATE1_TXUSERCLKIN1 : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tisd_TXRATE2_TXUSERCLKIN2 : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tisd_TXRATE3_TXUSERCLKIN3 : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      ticd_DCLK : VitalDelayType := 0 ps;
      ticd_REFCLK : VitalDelayType := 0 ps;
      ticd_RXUSERCLKIN0 : VitalDelayType := 0 ps;
      ticd_RXUSERCLKIN1 : VitalDelayType := 0 ps;
      ticd_RXUSERCLKIN2 : VitalDelayType := 0 ps;
      ticd_RXUSERCLKIN3 : VitalDelayType := 0 ps;
      ticd_TXUSERCLKIN0 : VitalDelayType := 0 ps;
      ticd_TXUSERCLKIN1 : VitalDelayType := 0 ps;
      ticd_TXUSERCLKIN2 : VitalDelayType := 0 ps;
      ticd_TXUSERCLKIN3 : VitalDelayType := 0 ps;
      tperiod_DCLK_posedge : VitalDelayType := 0 ps;
      tperiod_REFCLK_posedge : VitalDelayType := 0 ps;
      tperiod_RXUSERCLKIN0_posedge : VitalDelayType := 0 ps;
      tperiod_RXUSERCLKIN1_posedge : VitalDelayType := 0 ps;
      tperiod_RXUSERCLKIN2_posedge : VitalDelayType := 0 ps;
      tperiod_RXUSERCLKIN3_posedge : VitalDelayType := 0 ps;
      tperiod_TXUSERCLKIN0_posedge : VitalDelayType := 0 ps;
      tperiod_TXUSERCLKIN1_posedge : VitalDelayType := 0 ps;
      tperiod_TXUSERCLKIN2_posedge : VitalDelayType := 0 ps;
      tperiod_TXUSERCLKIN3_posedge : VitalDelayType := 0 ps
    );

    port (
      DRDY                 : out std_ulogic;
      DRPDO                : out std_logic_vector(15 downto 0);
      GTHINITDONE          : out std_ulogic;
      MGMTPCSRDACK         : out std_ulogic;
      MGMTPCSRDDATA        : out std_logic_vector(15 downto 0);
      RXCODEERR0           : out std_logic_vector(7 downto 0);
      RXCODEERR1           : out std_logic_vector(7 downto 0);
      RXCODEERR2           : out std_logic_vector(7 downto 0);
      RXCODEERR3           : out std_logic_vector(7 downto 0);
      RXCTRL0              : out std_logic_vector(7 downto 0);
      RXCTRL1              : out std_logic_vector(7 downto 0);
      RXCTRL2              : out std_logic_vector(7 downto 0);
      RXCTRL3              : out std_logic_vector(7 downto 0);
      RXCTRLACK0           : out std_ulogic;
      RXCTRLACK1           : out std_ulogic;
      RXCTRLACK2           : out std_ulogic;
      RXCTRLACK3           : out std_ulogic;
      RXDATA0              : out std_logic_vector(63 downto 0);
      RXDATA1              : out std_logic_vector(63 downto 0);
      RXDATA2              : out std_logic_vector(63 downto 0);
      RXDATA3              : out std_logic_vector(63 downto 0);
      RXDATATAP0           : out std_ulogic;
      RXDATATAP1           : out std_ulogic;
      RXDATATAP2           : out std_ulogic;
      RXDATATAP3           : out std_ulogic;
      RXDISPERR0           : out std_logic_vector(7 downto 0);
      RXDISPERR1           : out std_logic_vector(7 downto 0);
      RXDISPERR2           : out std_logic_vector(7 downto 0);
      RXDISPERR3           : out std_logic_vector(7 downto 0);
      RXPCSCLKSMPL0        : out std_ulogic;
      RXPCSCLKSMPL1        : out std_ulogic;
      RXPCSCLKSMPL2        : out std_ulogic;
      RXPCSCLKSMPL3        : out std_ulogic;
      RXUSERCLKOUT0        : out std_ulogic;
      RXUSERCLKOUT1        : out std_ulogic;
      RXUSERCLKOUT2        : out std_ulogic;
      RXUSERCLKOUT3        : out std_ulogic;
      RXVALID0             : out std_logic_vector(7 downto 0);
      RXVALID1             : out std_logic_vector(7 downto 0);
      RXVALID2             : out std_logic_vector(7 downto 0);
      RXVALID3             : out std_logic_vector(7 downto 0);
      TSTPATH              : out std_ulogic;
      TSTREFCLKFAB         : out std_ulogic;
      TSTREFCLKOUT         : out std_ulogic;
      TXCTRLACK0           : out std_ulogic;
      TXCTRLACK1           : out std_ulogic;
      TXCTRLACK2           : out std_ulogic;
      TXCTRLACK3           : out std_ulogic;
      TXDATATAP10          : out std_ulogic;
      TXDATATAP11          : out std_ulogic;
      TXDATATAP12          : out std_ulogic;
      TXDATATAP13          : out std_ulogic;
      TXDATATAP20          : out std_ulogic;
      TXDATATAP21          : out std_ulogic;
      TXDATATAP22          : out std_ulogic;
      TXDATATAP23          : out std_ulogic;
      TXN0                 : out std_ulogic;
      TXN1                 : out std_ulogic;
      TXN2                 : out std_ulogic;
      TXN3                 : out std_ulogic;
      TXP0                 : out std_ulogic;
      TXP1                 : out std_ulogic;
      TXP2                 : out std_ulogic;
      TXP3                 : out std_ulogic;
      TXPCSCLKSMPL0        : out std_ulogic;
      TXPCSCLKSMPL1        : out std_ulogic;
      TXPCSCLKSMPL2        : out std_ulogic;
      TXPCSCLKSMPL3        : out std_ulogic;
      TXUSERCLKOUT0        : out std_ulogic;
      TXUSERCLKOUT1        : out std_ulogic;
      TXUSERCLKOUT2        : out std_ulogic;
      TXUSERCLKOUT3        : out std_ulogic;
      DADDR                : in std_logic_vector(15 downto 0);
      DCLK                 : in std_ulogic;
      DEN                  : in std_ulogic;
      DFETRAINCTRL0        : in std_ulogic;
      DFETRAINCTRL1        : in std_ulogic;
      DFETRAINCTRL2        : in std_ulogic;
      DFETRAINCTRL3        : in std_ulogic;
      DI                   : in std_logic_vector(15 downto 0);
      DISABLEDRP           : in std_ulogic;
      DWE                  : in std_ulogic;
      GTHINIT              : in std_ulogic;
      GTHRESET             : in std_ulogic;
      GTHX2LANE01          : in std_ulogic;
      GTHX2LANE23          : in std_ulogic;
      GTHX4LANE            : in std_ulogic;
      MGMTPCSLANESEL       : in std_logic_vector(3 downto 0);
      MGMTPCSMMDADDR       : in std_logic_vector(4 downto 0);
      MGMTPCSREGADDR       : in std_logic_vector(15 downto 0);
      MGMTPCSREGRD         : in std_ulogic;
      MGMTPCSREGWR         : in std_ulogic;
      MGMTPCSWRDATA        : in std_logic_vector(15 downto 0);
      PLLPCSCLKDIV         : in std_logic_vector(5 downto 0);
      PLLREFCLKSEL         : in std_logic_vector(2 downto 0);
      POWERDOWN0           : in std_ulogic;
      POWERDOWN1           : in std_ulogic;
      POWERDOWN2           : in std_ulogic;
      POWERDOWN3           : in std_ulogic;
      REFCLK               : in std_ulogic;
      RXBUFRESET0          : in std_ulogic;
      RXBUFRESET1          : in std_ulogic;
      RXBUFRESET2          : in std_ulogic;
      RXBUFRESET3          : in std_ulogic;
      RXENCOMMADET0        : in std_ulogic;
      RXENCOMMADET1        : in std_ulogic;
      RXENCOMMADET2        : in std_ulogic;
      RXENCOMMADET3        : in std_ulogic;
      RXN0                 : in std_ulogic;
      RXN1                 : in std_ulogic;
      RXN2                 : in std_ulogic;
      RXN3                 : in std_ulogic;
      RXP0                 : in std_ulogic;
      RXP1                 : in std_ulogic;
      RXP2                 : in std_ulogic;
      RXP3                 : in std_ulogic;
      RXPOLARITY0          : in std_ulogic;
      RXPOLARITY1          : in std_ulogic;
      RXPOLARITY2          : in std_ulogic;
      RXPOLARITY3          : in std_ulogic;
      RXPOWERDOWN0         : in std_logic_vector(1 downto 0);
      RXPOWERDOWN1         : in std_logic_vector(1 downto 0);
      RXPOWERDOWN2         : in std_logic_vector(1 downto 0);
      RXPOWERDOWN3         : in std_logic_vector(1 downto 0);
      RXRATE0              : in std_logic_vector(1 downto 0);
      RXRATE1              : in std_logic_vector(1 downto 0);
      RXRATE2              : in std_logic_vector(1 downto 0);
      RXRATE3              : in std_logic_vector(1 downto 0);
      RXSLIP0              : in std_ulogic;
      RXSLIP1              : in std_ulogic;
      RXSLIP2              : in std_ulogic;
      RXSLIP3              : in std_ulogic;
      RXUSERCLKIN0         : in std_ulogic;
      RXUSERCLKIN1         : in std_ulogic;
      RXUSERCLKIN2         : in std_ulogic;
      RXUSERCLKIN3         : in std_ulogic;
      SAMPLERATE0          : in std_logic_vector(2 downto 0);
      SAMPLERATE1          : in std_logic_vector(2 downto 0);
      SAMPLERATE2          : in std_logic_vector(2 downto 0);
      SAMPLERATE3          : in std_logic_vector(2 downto 0);
      TXBUFRESET0          : in std_ulogic;
      TXBUFRESET1          : in std_ulogic;
      TXBUFRESET2          : in std_ulogic;
      TXBUFRESET3          : in std_ulogic;
      TXCTRL0              : in std_logic_vector(7 downto 0);
      TXCTRL1              : in std_logic_vector(7 downto 0);
      TXCTRL2              : in std_logic_vector(7 downto 0);
      TXCTRL3              : in std_logic_vector(7 downto 0);
      TXDATA0              : in std_logic_vector(63 downto 0);
      TXDATA1              : in std_logic_vector(63 downto 0);
      TXDATA2              : in std_logic_vector(63 downto 0);
      TXDATA3              : in std_logic_vector(63 downto 0);
      TXDATAMSB0           : in std_logic_vector(7 downto 0);
      TXDATAMSB1           : in std_logic_vector(7 downto 0);
      TXDATAMSB2           : in std_logic_vector(7 downto 0);
      TXDATAMSB3           : in std_logic_vector(7 downto 0);
      TXDEEMPH0            : in std_ulogic;
      TXDEEMPH1            : in std_ulogic;
      TXDEEMPH2            : in std_ulogic;
      TXDEEMPH3            : in std_ulogic;
      TXMARGIN0            : in std_logic_vector(2 downto 0);
      TXMARGIN1            : in std_logic_vector(2 downto 0);
      TXMARGIN2            : in std_logic_vector(2 downto 0);
      TXMARGIN3            : in std_logic_vector(2 downto 0);
      TXPOWERDOWN0         : in std_logic_vector(1 downto 0);
      TXPOWERDOWN1         : in std_logic_vector(1 downto 0);
      TXPOWERDOWN2         : in std_logic_vector(1 downto 0);
      TXPOWERDOWN3         : in std_logic_vector(1 downto 0);
      TXRATE0              : in std_logic_vector(1 downto 0);
      TXRATE1              : in std_logic_vector(1 downto 0);
      TXRATE2              : in std_logic_vector(1 downto 0);
      TXRATE3              : in std_logic_vector(1 downto 0);
      TXUSERCLKIN0         : in std_ulogic;
      TXUSERCLKIN1         : in std_ulogic;
      TXUSERCLKIN2         : in std_ulogic;
      TXUSERCLKIN3         : in std_ulogic      
    );
    attribute VITAL_LEVEL0 of X_GTHE1_QUAD :     entity is true;
  end X_GTHE1_QUAD;

  architecture X_GTHE1_QUAD_V of X_GTHE1_QUAD is
    TYPE VitalTimingDataArrayType IS ARRAY (NATURAL RANGE <>) OF VitalTimingDataType;
    component GTHE1_QUAD_WRAP
      generic (
        BER_CONST_PTRN0 : string;
        BER_CONST_PTRN1 : string;
        BUFFER_CONFIG_LANE0 : string;
        BUFFER_CONFIG_LANE1 : string;
        BUFFER_CONFIG_LANE2 : string;
        BUFFER_CONFIG_LANE3 : string;
        DFE_TRAIN_CTRL_LANE0 : string;
        DFE_TRAIN_CTRL_LANE1 : string;
        DFE_TRAIN_CTRL_LANE2 : string;
        DFE_TRAIN_CTRL_LANE3 : string;
        DLL_CFG0 : string;
        DLL_CFG1 : string;
        E10GBASEKR_LD_COEFF_UPD_LANE0 : string;
        E10GBASEKR_LD_COEFF_UPD_LANE1 : string;
        E10GBASEKR_LD_COEFF_UPD_LANE2 : string;
        E10GBASEKR_LD_COEFF_UPD_LANE3 : string;
        E10GBASEKR_LP_COEFF_UPD_LANE0 : string;
        E10GBASEKR_LP_COEFF_UPD_LANE1 : string;
        E10GBASEKR_LP_COEFF_UPD_LANE2 : string;
        E10GBASEKR_LP_COEFF_UPD_LANE3 : string;
        E10GBASEKR_PMA_CTRL_LANE0 : string;
        E10GBASEKR_PMA_CTRL_LANE1 : string;
        E10GBASEKR_PMA_CTRL_LANE2 : string;
        E10GBASEKR_PMA_CTRL_LANE3 : string;
        E10GBASEKX_CTRL_LANE0 : string;
        E10GBASEKX_CTRL_LANE1 : string;
        E10GBASEKX_CTRL_LANE2 : string;
        E10GBASEKX_CTRL_LANE3 : string;
        E10GBASER_PCS_CFG_LANE0 : string;
        E10GBASER_PCS_CFG_LANE1 : string;
        E10GBASER_PCS_CFG_LANE2 : string;
        E10GBASER_PCS_CFG_LANE3 : string;
        E10GBASER_PCS_SEEDA0_LANE0 : string;
        E10GBASER_PCS_SEEDA0_LANE1 : string;
        E10GBASER_PCS_SEEDA0_LANE2 : string;
        E10GBASER_PCS_SEEDA0_LANE3 : string;
        E10GBASER_PCS_SEEDA1_LANE0 : string;
        E10GBASER_PCS_SEEDA1_LANE1 : string;
        E10GBASER_PCS_SEEDA1_LANE2 : string;
        E10GBASER_PCS_SEEDA1_LANE3 : string;
        E10GBASER_PCS_SEEDA2_LANE0 : string;
        E10GBASER_PCS_SEEDA2_LANE1 : string;
        E10GBASER_PCS_SEEDA2_LANE2 : string;
        E10GBASER_PCS_SEEDA2_LANE3 : string;
        E10GBASER_PCS_SEEDA3_LANE0 : string;
        E10GBASER_PCS_SEEDA3_LANE1 : string;
        E10GBASER_PCS_SEEDA3_LANE2 : string;
        E10GBASER_PCS_SEEDA3_LANE3 : string;
        E10GBASER_PCS_SEEDB0_LANE0 : string;
        E10GBASER_PCS_SEEDB0_LANE1 : string;
        E10GBASER_PCS_SEEDB0_LANE2 : string;
        E10GBASER_PCS_SEEDB0_LANE3 : string;
        E10GBASER_PCS_SEEDB1_LANE0 : string;
        E10GBASER_PCS_SEEDB1_LANE1 : string;
        E10GBASER_PCS_SEEDB1_LANE2 : string;
        E10GBASER_PCS_SEEDB1_LANE3 : string;
        E10GBASER_PCS_SEEDB2_LANE0 : string;
        E10GBASER_PCS_SEEDB2_LANE1 : string;
        E10GBASER_PCS_SEEDB2_LANE2 : string;
        E10GBASER_PCS_SEEDB2_LANE3 : string;
        E10GBASER_PCS_SEEDB3_LANE0 : string;
        E10GBASER_PCS_SEEDB3_LANE1 : string;
        E10GBASER_PCS_SEEDB3_LANE2 : string;
        E10GBASER_PCS_SEEDB3_LANE3 : string;
        E10GBASER_PCS_TEST_CTRL_LANE0 : string;
        E10GBASER_PCS_TEST_CTRL_LANE1 : string;
        E10GBASER_PCS_TEST_CTRL_LANE2 : string;
        E10GBASER_PCS_TEST_CTRL_LANE3 : string;
        E10GBASEX_PCS_TSTCTRL_LANE0 : string;
        E10GBASEX_PCS_TSTCTRL_LANE1 : string;
        E10GBASEX_PCS_TSTCTRL_LANE2 : string;
        E10GBASEX_PCS_TSTCTRL_LANE3 : string;
        GLBL0_NOISE_CTRL : string;
        GLBL_AMON_SEL : string;
        GLBL_DMON_SEL : string;
        GLBL_PWR_CTRL : string;
        GTH_CFG_PWRUP_LANE0 : string;
        GTH_CFG_PWRUP_LANE1 : string;
        GTH_CFG_PWRUP_LANE2 : string;
        GTH_CFG_PWRUP_LANE3 : string;
        LANE_AMON_SEL : string;
        LANE_DMON_SEL : string;
        LANE_LNK_CFGOVRD : string;
        LANE_PWR_CTRL_LANE0 : string;
        LANE_PWR_CTRL_LANE1 : string;
        LANE_PWR_CTRL_LANE2 : string;
        LANE_PWR_CTRL_LANE3 : string;
        LNK_TRN_CFG_LANE0 : string;
        LNK_TRN_CFG_LANE1 : string;
        LNK_TRN_CFG_LANE2 : string;
        LNK_TRN_CFG_LANE3 : string;
        LNK_TRN_COEFF_REQ_LANE0 : string;
        LNK_TRN_COEFF_REQ_LANE1 : string;
        LNK_TRN_COEFF_REQ_LANE2 : string;
        LNK_TRN_COEFF_REQ_LANE3 : string;
        MISC_CFG : string;
        MODE_CFG1 : string;
        MODE_CFG2 : string;
        MODE_CFG3 : string;
        MODE_CFG4 : string;
        MODE_CFG5 : string;
        MODE_CFG6 : string;
        MODE_CFG7 : string;
        PCS_ABILITY_LANE0 : string;
        PCS_ABILITY_LANE1 : string;
        PCS_ABILITY_LANE2 : string;
        PCS_ABILITY_LANE3 : string;
        PCS_CTRL1_LANE0 : string;
        PCS_CTRL1_LANE1 : string;
        PCS_CTRL1_LANE2 : string;
        PCS_CTRL1_LANE3 : string;
        PCS_CTRL2_LANE0 : string;
        PCS_CTRL2_LANE1 : string;
        PCS_CTRL2_LANE2 : string;
        PCS_CTRL2_LANE3 : string;
        PCS_MISC_CFG_0_LANE0 : string;
        PCS_MISC_CFG_0_LANE1 : string;
        PCS_MISC_CFG_0_LANE2 : string;
        PCS_MISC_CFG_0_LANE3 : string;
        PCS_MISC_CFG_1_LANE0 : string;
        PCS_MISC_CFG_1_LANE1 : string;
        PCS_MISC_CFG_1_LANE2 : string;
        PCS_MISC_CFG_1_LANE3 : string;
        PCS_MODE_LANE0 : string;
        PCS_MODE_LANE1 : string;
        PCS_MODE_LANE2 : string;
        PCS_MODE_LANE3 : string;
        PCS_RESET_1_LANE0 : string;
        PCS_RESET_1_LANE1 : string;
        PCS_RESET_1_LANE2 : string;
        PCS_RESET_1_LANE3 : string;
        PCS_RESET_LANE0 : string;
        PCS_RESET_LANE1 : string;
        PCS_RESET_LANE2 : string;
        PCS_RESET_LANE3 : string;
        PCS_TYPE_LANE0 : string;
        PCS_TYPE_LANE1 : string;
        PCS_TYPE_LANE2 : string;
        PCS_TYPE_LANE3 : string;
        PLL_CFG0 : string;
        PLL_CFG1 : string;
        PLL_CFG2 : string;
        PMA_CTRL1_LANE0 : string;
        PMA_CTRL1_LANE1 : string;
        PMA_CTRL1_LANE2 : string;
        PMA_CTRL1_LANE3 : string;
        PMA_CTRL2_LANE0 : string;
        PMA_CTRL2_LANE1 : string;
        PMA_CTRL2_LANE2 : string;
        PMA_CTRL2_LANE3 : string;
        PMA_LPBK_CTRL_LANE0 : string;
        PMA_LPBK_CTRL_LANE1 : string;
        PMA_LPBK_CTRL_LANE2 : string;
        PMA_LPBK_CTRL_LANE3 : string;
        PRBS_BER_CFG0_LANE0 : string;
        PRBS_BER_CFG0_LANE1 : string;
        PRBS_BER_CFG0_LANE2 : string;
        PRBS_BER_CFG0_LANE3 : string;
        PRBS_BER_CFG1_LANE0 : string;
        PRBS_BER_CFG1_LANE1 : string;
        PRBS_BER_CFG1_LANE2 : string;
        PRBS_BER_CFG1_LANE3 : string;
        PRBS_CFG_LANE0 : string;
        PRBS_CFG_LANE1 : string;
        PRBS_CFG_LANE2 : string;
        PRBS_CFG_LANE3 : string;
        PTRN_CFG0_LSB : string;
        PTRN_CFG0_MSB : string;
        PTRN_LEN_CFG : string;
        PWRUP_DLY : string;
        RX_AEQ_VAL0_LANE0 : string;
        RX_AEQ_VAL0_LANE1 : string;
        RX_AEQ_VAL0_LANE2 : string;
        RX_AEQ_VAL0_LANE3 : string;
        RX_AEQ_VAL1_LANE0 : string;
        RX_AEQ_VAL1_LANE1 : string;
        RX_AEQ_VAL1_LANE2 : string;
        RX_AEQ_VAL1_LANE3 : string;
        RX_AGC_CTRL_LANE0 : string;
        RX_AGC_CTRL_LANE1 : string;
        RX_AGC_CTRL_LANE2 : string;
        RX_AGC_CTRL_LANE3 : string;
        RX_CDR_CTRL0_LANE0 : string;
        RX_CDR_CTRL0_LANE1 : string;
        RX_CDR_CTRL0_LANE2 : string;
        RX_CDR_CTRL0_LANE3 : string;
        RX_CDR_CTRL1_LANE0 : string;
        RX_CDR_CTRL1_LANE1 : string;
        RX_CDR_CTRL1_LANE2 : string;
        RX_CDR_CTRL1_LANE3 : string;
        RX_CDR_CTRL2_LANE0 : string;
        RX_CDR_CTRL2_LANE1 : string;
        RX_CDR_CTRL2_LANE2 : string;
        RX_CDR_CTRL2_LANE3 : string;
        RX_CFG0_LANE0 : string;
        RX_CFG0_LANE1 : string;
        RX_CFG0_LANE2 : string;
        RX_CFG0_LANE3 : string;
        RX_CFG1_LANE0 : string;
        RX_CFG1_LANE1 : string;
        RX_CFG1_LANE2 : string;
        RX_CFG1_LANE3 : string;
        RX_CFG2_LANE0 : string;
        RX_CFG2_LANE1 : string;
        RX_CFG2_LANE2 : string;
        RX_CFG2_LANE3 : string;
        RX_CTLE_CTRL_LANE0 : string;
        RX_CTLE_CTRL_LANE1 : string;
        RX_CTLE_CTRL_LANE2 : string;
        RX_CTLE_CTRL_LANE3 : string;
        RX_CTRL_OVRD_LANE0 : string;
        RX_CTRL_OVRD_LANE1 : string;
        RX_CTRL_OVRD_LANE2 : string;
        RX_CTRL_OVRD_LANE3 : string;
        RX_FABRIC_WIDTH0 : integer;
        RX_FABRIC_WIDTH1 : integer;
        RX_FABRIC_WIDTH2 : integer;
        RX_FABRIC_WIDTH3 : integer;
        RX_LOOP_CTRL_LANE0 : string;
        RX_LOOP_CTRL_LANE1 : string;
        RX_LOOP_CTRL_LANE2 : string;
        RX_LOOP_CTRL_LANE3 : string;
        RX_MVAL0_LANE0 : string;
        RX_MVAL0_LANE1 : string;
        RX_MVAL0_LANE2 : string;
        RX_MVAL0_LANE3 : string;
        RX_MVAL1_LANE0 : string;
        RX_MVAL1_LANE1 : string;
        RX_MVAL1_LANE2 : string;
        RX_MVAL1_LANE3 : string;
        RX_P0S_CTRL : string;
        RX_P0_CTRL : string;
        RX_P1_CTRL : string;
        RX_P2_CTRL : string;
        RX_PI_CTRL0 : string;
        RX_PI_CTRL1 : string;
        SIM_GTHRESET_SPEEDUP : integer;
        SIM_VERSION : string;
        SLICE_CFG : string;
        SLICE_NOISE_CTRL_0_LANE01 : string;
        SLICE_NOISE_CTRL_0_LANE23 : string;
        SLICE_NOISE_CTRL_1_LANE01 : string;
        SLICE_NOISE_CTRL_1_LANE23 : string;
        SLICE_NOISE_CTRL_2_LANE01 : string;
        SLICE_NOISE_CTRL_2_LANE23 : string;
        SLICE_TX_RESET_LANE01 : string;
        SLICE_TX_RESET_LANE23 : string;
        TERM_CTRL_LANE0 : string;
        TERM_CTRL_LANE1 : string;
        TERM_CTRL_LANE2 : string;
        TERM_CTRL_LANE3 : string;
        TX_CFG0_LANE0 : string;
        TX_CFG0_LANE1 : string;
        TX_CFG0_LANE2 : string;
        TX_CFG0_LANE3 : string;
        TX_CFG1_LANE0 : string;
        TX_CFG1_LANE1 : string;
        TX_CFG1_LANE2 : string;
        TX_CFG1_LANE3 : string;
        TX_CFG2_LANE0 : string;
        TX_CFG2_LANE1 : string;
        TX_CFG2_LANE2 : string;
        TX_CFG2_LANE3 : string;
        TX_CLK_SEL0_LANE0 : string;
        TX_CLK_SEL0_LANE1 : string;
        TX_CLK_SEL0_LANE2 : string;
        TX_CLK_SEL0_LANE3 : string;
        TX_CLK_SEL1_LANE0 : string;
        TX_CLK_SEL1_LANE1 : string;
        TX_CLK_SEL1_LANE2 : string;
        TX_CLK_SEL1_LANE3 : string;
        TX_DISABLE_LANE0 : string;
        TX_DISABLE_LANE1 : string;
        TX_DISABLE_LANE2 : string;
        TX_DISABLE_LANE3 : string;
        TX_FABRIC_WIDTH0 : integer;
        TX_FABRIC_WIDTH1 : integer;
        TX_FABRIC_WIDTH2 : integer;
        TX_FABRIC_WIDTH3 : integer;
        TX_P0P0S_CTRL : string;
        TX_P1P2_CTRL : string;
        TX_PREEMPH_LANE0 : string;
        TX_PREEMPH_LANE1 : string;
        TX_PREEMPH_LANE2 : string;
        TX_PREEMPH_LANE3 : string;
        TX_PWR_RATE_OVRD_LANE0 : string;
        TX_PWR_RATE_OVRD_LANE1 : string;
        TX_PWR_RATE_OVRD_LANE2 : string;
        TX_PWR_RATE_OVRD_LANE3 : string        
      );
      
      port (
        DRDY                 : out std_ulogic;
        DRPDO                : out std_logic_vector(15 downto 0);
        GTHINITDONE          : out std_ulogic;
        MGMTPCSRDACK         : out std_ulogic;
        MGMTPCSRDDATA        : out std_logic_vector(15 downto 0);
        RXCODEERR0           : out std_logic_vector(7 downto 0);
        RXCODEERR1           : out std_logic_vector(7 downto 0);
        RXCODEERR2           : out std_logic_vector(7 downto 0);
        RXCODEERR3           : out std_logic_vector(7 downto 0);
        RXCTRL0              : out std_logic_vector(7 downto 0);
        RXCTRL1              : out std_logic_vector(7 downto 0);
        RXCTRL2              : out std_logic_vector(7 downto 0);
        RXCTRL3              : out std_logic_vector(7 downto 0);
        RXCTRLACK0           : out std_ulogic;
        RXCTRLACK1           : out std_ulogic;
        RXCTRLACK2           : out std_ulogic;
        RXCTRLACK3           : out std_ulogic;
        RXDATA0              : out std_logic_vector(63 downto 0);
        RXDATA1              : out std_logic_vector(63 downto 0);
        RXDATA2              : out std_logic_vector(63 downto 0);
        RXDATA3              : out std_logic_vector(63 downto 0);
        RXDATATAP0           : out std_ulogic;
        RXDATATAP1           : out std_ulogic;
        RXDATATAP2           : out std_ulogic;
        RXDATATAP3           : out std_ulogic;
        RXDISPERR0           : out std_logic_vector(7 downto 0);
        RXDISPERR1           : out std_logic_vector(7 downto 0);
        RXDISPERR2           : out std_logic_vector(7 downto 0);
        RXDISPERR3           : out std_logic_vector(7 downto 0);
        RXPCSCLKSMPL0        : out std_ulogic;
        RXPCSCLKSMPL1        : out std_ulogic;
        RXPCSCLKSMPL2        : out std_ulogic;
        RXPCSCLKSMPL3        : out std_ulogic;
        RXUSERCLKOUT0        : out std_ulogic;
        RXUSERCLKOUT1        : out std_ulogic;
        RXUSERCLKOUT2        : out std_ulogic;
        RXUSERCLKOUT3        : out std_ulogic;
        RXVALID0             : out std_logic_vector(7 downto 0);
        RXVALID1             : out std_logic_vector(7 downto 0);
        RXVALID2             : out std_logic_vector(7 downto 0);
        RXVALID3             : out std_logic_vector(7 downto 0);
        TSTPATH              : out std_ulogic;
        TSTREFCLKFAB         : out std_ulogic;
        TSTREFCLKOUT         : out std_ulogic;
        TXCTRLACK0           : out std_ulogic;
        TXCTRLACK1           : out std_ulogic;
        TXCTRLACK2           : out std_ulogic;
        TXCTRLACK3           : out std_ulogic;
        TXDATATAP10          : out std_ulogic;
        TXDATATAP11          : out std_ulogic;
        TXDATATAP12          : out std_ulogic;
        TXDATATAP13          : out std_ulogic;
        TXDATATAP20          : out std_ulogic;
        TXDATATAP21          : out std_ulogic;
        TXDATATAP22          : out std_ulogic;
        TXDATATAP23          : out std_ulogic;
        TXN0                 : out std_ulogic;
        TXN1                 : out std_ulogic;
        TXN2                 : out std_ulogic;
        TXN3                 : out std_ulogic;
        TXP0                 : out std_ulogic;
        TXP1                 : out std_ulogic;
        TXP2                 : out std_ulogic;
        TXP3                 : out std_ulogic;
        TXPCSCLKSMPL0        : out std_ulogic;
        TXPCSCLKSMPL1        : out std_ulogic;
        TXPCSCLKSMPL2        : out std_ulogic;
        TXPCSCLKSMPL3        : out std_ulogic;
        TXUSERCLKOUT0        : out std_ulogic;
        TXUSERCLKOUT1        : out std_ulogic;
        TXUSERCLKOUT2        : out std_ulogic;
        TXUSERCLKOUT3        : out std_ulogic;

        GSR                  : in std_ulogic;
        DADDR                : in std_logic_vector(15 downto 0);
        DCLK                 : in std_ulogic;
        DEN                  : in std_ulogic;
        DFETRAINCTRL0        : in std_ulogic;
        DFETRAINCTRL1        : in std_ulogic;
        DFETRAINCTRL2        : in std_ulogic;
        DFETRAINCTRL3        : in std_ulogic;
        DI                   : in std_logic_vector(15 downto 0);
        DISABLEDRP           : in std_ulogic;
        DWE                  : in std_ulogic;
        GTHINIT              : in std_ulogic;
        GTHRESET             : in std_ulogic;
        GTHX2LANE01          : in std_ulogic;
        GTHX2LANE23          : in std_ulogic;
        GTHX4LANE            : in std_ulogic;
        MGMTPCSLANESEL       : in std_logic_vector(3 downto 0);
        MGMTPCSMMDADDR       : in std_logic_vector(4 downto 0);
        MGMTPCSREGADDR       : in std_logic_vector(15 downto 0);
        MGMTPCSREGRD         : in std_ulogic;
        MGMTPCSREGWR         : in std_ulogic;
        MGMTPCSWRDATA        : in std_logic_vector(15 downto 0);
        PLLPCSCLKDIV         : in std_logic_vector(5 downto 0);
        PLLREFCLKSEL         : in std_logic_vector(2 downto 0);
        POWERDOWN0           : in std_ulogic;
        POWERDOWN1           : in std_ulogic;
        POWERDOWN2           : in std_ulogic;
        POWERDOWN3           : in std_ulogic;
        REFCLK               : in std_ulogic;
        RXBUFRESET0          : in std_ulogic;
        RXBUFRESET1          : in std_ulogic;
        RXBUFRESET2          : in std_ulogic;
        RXBUFRESET3          : in std_ulogic;
        RXENCOMMADET0        : in std_ulogic;
        RXENCOMMADET1        : in std_ulogic;
        RXENCOMMADET2        : in std_ulogic;
        RXENCOMMADET3        : in std_ulogic;
        RXN0                 : in std_ulogic;
        RXN1                 : in std_ulogic;
        RXN2                 : in std_ulogic;
        RXN3                 : in std_ulogic;
        RXP0                 : in std_ulogic;
        RXP1                 : in std_ulogic;
        RXP2                 : in std_ulogic;
        RXP3                 : in std_ulogic;
        RXPOLARITY0          : in std_ulogic;
        RXPOLARITY1          : in std_ulogic;
        RXPOLARITY2          : in std_ulogic;
        RXPOLARITY3          : in std_ulogic;
        RXPOWERDOWN0         : in std_logic_vector(1 downto 0);
        RXPOWERDOWN1         : in std_logic_vector(1 downto 0);
        RXPOWERDOWN2         : in std_logic_vector(1 downto 0);
        RXPOWERDOWN3         : in std_logic_vector(1 downto 0);
        RXRATE0              : in std_logic_vector(1 downto 0);
        RXRATE1              : in std_logic_vector(1 downto 0);
        RXRATE2              : in std_logic_vector(1 downto 0);
        RXRATE3              : in std_logic_vector(1 downto 0);
        RXSLIP0              : in std_ulogic;
        RXSLIP1              : in std_ulogic;
        RXSLIP2              : in std_ulogic;
        RXSLIP3              : in std_ulogic;
        RXUSERCLKIN0         : in std_ulogic;
        RXUSERCLKIN1         : in std_ulogic;
        RXUSERCLKIN2         : in std_ulogic;
        RXUSERCLKIN3         : in std_ulogic;
        SAMPLERATE0          : in std_logic_vector(2 downto 0);
        SAMPLERATE1          : in std_logic_vector(2 downto 0);
        SAMPLERATE2          : in std_logic_vector(2 downto 0);
        SAMPLERATE3          : in std_logic_vector(2 downto 0);
        TXBUFRESET0          : in std_ulogic;
        TXBUFRESET1          : in std_ulogic;
        TXBUFRESET2          : in std_ulogic;
        TXBUFRESET3          : in std_ulogic;
        TXCTRL0              : in std_logic_vector(7 downto 0);
        TXCTRL1              : in std_logic_vector(7 downto 0);
        TXCTRL2              : in std_logic_vector(7 downto 0);
        TXCTRL3              : in std_logic_vector(7 downto 0);
        TXDATA0              : in std_logic_vector(63 downto 0);
        TXDATA1              : in std_logic_vector(63 downto 0);
        TXDATA2              : in std_logic_vector(63 downto 0);
        TXDATA3              : in std_logic_vector(63 downto 0);
        TXDATAMSB0           : in std_logic_vector(7 downto 0);
        TXDATAMSB1           : in std_logic_vector(7 downto 0);
        TXDATAMSB2           : in std_logic_vector(7 downto 0);
        TXDATAMSB3           : in std_logic_vector(7 downto 0);
        TXDEEMPH0            : in std_ulogic;
        TXDEEMPH1            : in std_ulogic;
        TXDEEMPH2            : in std_ulogic;
        TXDEEMPH3            : in std_ulogic;
        TXMARGIN0            : in std_logic_vector(2 downto 0);
        TXMARGIN1            : in std_logic_vector(2 downto 0);
        TXMARGIN2            : in std_logic_vector(2 downto 0);
        TXMARGIN3            : in std_logic_vector(2 downto 0);
        TXPOWERDOWN0         : in std_logic_vector(1 downto 0);
        TXPOWERDOWN1         : in std_logic_vector(1 downto 0);
        TXPOWERDOWN2         : in std_logic_vector(1 downto 0);
        TXPOWERDOWN3         : in std_logic_vector(1 downto 0);
        TXRATE0              : in std_logic_vector(1 downto 0);
        TXRATE1              : in std_logic_vector(1 downto 0);
        TXRATE2              : in std_logic_vector(1 downto 0);
        TXRATE3              : in std_logic_vector(1 downto 0);
        TXUSERCLKIN0         : in std_ulogic;
        TXUSERCLKIN1         : in std_ulogic;
        TXUSERCLKIN2         : in std_ulogic;
        TXUSERCLKIN3         : in std_ulogic        
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

    function getstrlength(in_vec : std_logic_vector)
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
    constant BER_CONST_PTRN0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(BER_CONST_PTRN0)(15 downto 0);
    constant BER_CONST_PTRN1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(BER_CONST_PTRN1)(15 downto 0);
    constant BUFFER_CONFIG_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(BUFFER_CONFIG_LANE0)(15 downto 0);
    constant BUFFER_CONFIG_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(BUFFER_CONFIG_LANE1)(15 downto 0);
    constant BUFFER_CONFIG_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(BUFFER_CONFIG_LANE2)(15 downto 0);
    constant BUFFER_CONFIG_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(BUFFER_CONFIG_LANE3)(15 downto 0);
    constant DFE_TRAIN_CTRL_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(DFE_TRAIN_CTRL_LANE0)(15 downto 0);
    constant DFE_TRAIN_CTRL_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(DFE_TRAIN_CTRL_LANE1)(15 downto 0);
    constant DFE_TRAIN_CTRL_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(DFE_TRAIN_CTRL_LANE2)(15 downto 0);
    constant DFE_TRAIN_CTRL_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(DFE_TRAIN_CTRL_LANE3)(15 downto 0);
    constant DLL_CFG0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(DLL_CFG0)(15 downto 0);
    constant DLL_CFG1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(DLL_CFG1)(15 downto 0);
    constant E10GBASEKR_LD_COEFF_UPD_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASEKR_LD_COEFF_UPD_LANE0)(15 downto 0);
    constant E10GBASEKR_LD_COEFF_UPD_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASEKR_LD_COEFF_UPD_LANE1)(15 downto 0);
    constant E10GBASEKR_LD_COEFF_UPD_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASEKR_LD_COEFF_UPD_LANE2)(15 downto 0);
    constant E10GBASEKR_LD_COEFF_UPD_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASEKR_LD_COEFF_UPD_LANE3)(15 downto 0);
    constant E10GBASEKR_LP_COEFF_UPD_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASEKR_LP_COEFF_UPD_LANE0)(15 downto 0);
    constant E10GBASEKR_LP_COEFF_UPD_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASEKR_LP_COEFF_UPD_LANE1)(15 downto 0);
    constant E10GBASEKR_LP_COEFF_UPD_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASEKR_LP_COEFF_UPD_LANE2)(15 downto 0);
    constant E10GBASEKR_LP_COEFF_UPD_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASEKR_LP_COEFF_UPD_LANE3)(15 downto 0);
    constant E10GBASEKR_PMA_CTRL_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASEKR_PMA_CTRL_LANE0)(15 downto 0);
    constant E10GBASEKR_PMA_CTRL_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASEKR_PMA_CTRL_LANE1)(15 downto 0);
    constant E10GBASEKR_PMA_CTRL_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASEKR_PMA_CTRL_LANE2)(15 downto 0);
    constant E10GBASEKR_PMA_CTRL_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASEKR_PMA_CTRL_LANE3)(15 downto 0);
    constant E10GBASEKX_CTRL_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASEKX_CTRL_LANE0)(15 downto 0);
    constant E10GBASEKX_CTRL_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASEKX_CTRL_LANE1)(15 downto 0);
    constant E10GBASEKX_CTRL_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASEKX_CTRL_LANE2)(15 downto 0);
    constant E10GBASEKX_CTRL_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASEKX_CTRL_LANE3)(15 downto 0);
    constant E10GBASER_PCS_CFG_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_CFG_LANE0)(15 downto 0);
    constant E10GBASER_PCS_CFG_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_CFG_LANE1)(15 downto 0);
    constant E10GBASER_PCS_CFG_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_CFG_LANE2)(15 downto 0);
    constant E10GBASER_PCS_CFG_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_CFG_LANE3)(15 downto 0);
    constant E10GBASER_PCS_SEEDA0_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDA0_LANE0)(15 downto 0);
    constant E10GBASER_PCS_SEEDA0_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDA0_LANE1)(15 downto 0);
    constant E10GBASER_PCS_SEEDA0_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDA0_LANE2)(15 downto 0);
    constant E10GBASER_PCS_SEEDA0_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDA0_LANE3)(15 downto 0);
    constant E10GBASER_PCS_SEEDA1_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDA1_LANE0)(15 downto 0);
    constant E10GBASER_PCS_SEEDA1_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDA1_LANE1)(15 downto 0);
    constant E10GBASER_PCS_SEEDA1_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDA1_LANE2)(15 downto 0);
    constant E10GBASER_PCS_SEEDA1_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDA1_LANE3)(15 downto 0);
    constant E10GBASER_PCS_SEEDA2_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDA2_LANE0)(15 downto 0);
    constant E10GBASER_PCS_SEEDA2_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDA2_LANE1)(15 downto 0);
    constant E10GBASER_PCS_SEEDA2_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDA2_LANE2)(15 downto 0);
    constant E10GBASER_PCS_SEEDA2_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDA2_LANE3)(15 downto 0);
    constant E10GBASER_PCS_SEEDA3_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDA3_LANE0)(15 downto 0);
    constant E10GBASER_PCS_SEEDA3_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDA3_LANE1)(15 downto 0);
    constant E10GBASER_PCS_SEEDA3_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDA3_LANE2)(15 downto 0);
    constant E10GBASER_PCS_SEEDA3_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDA3_LANE3)(15 downto 0);
    constant E10GBASER_PCS_SEEDB0_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDB0_LANE0)(15 downto 0);
    constant E10GBASER_PCS_SEEDB0_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDB0_LANE1)(15 downto 0);
    constant E10GBASER_PCS_SEEDB0_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDB0_LANE2)(15 downto 0);
    constant E10GBASER_PCS_SEEDB0_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDB0_LANE3)(15 downto 0);
    constant E10GBASER_PCS_SEEDB1_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDB1_LANE0)(15 downto 0);
    constant E10GBASER_PCS_SEEDB1_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDB1_LANE1)(15 downto 0);
    constant E10GBASER_PCS_SEEDB1_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDB1_LANE2)(15 downto 0);
    constant E10GBASER_PCS_SEEDB1_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDB1_LANE3)(15 downto 0);
    constant E10GBASER_PCS_SEEDB2_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDB2_LANE0)(15 downto 0);
    constant E10GBASER_PCS_SEEDB2_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDB2_LANE1)(15 downto 0);
    constant E10GBASER_PCS_SEEDB2_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDB2_LANE2)(15 downto 0);
    constant E10GBASER_PCS_SEEDB2_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDB2_LANE3)(15 downto 0);
    constant E10GBASER_PCS_SEEDB3_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDB3_LANE0)(15 downto 0);
    constant E10GBASER_PCS_SEEDB3_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDB3_LANE1)(15 downto 0);
    constant E10GBASER_PCS_SEEDB3_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDB3_LANE2)(15 downto 0);
    constant E10GBASER_PCS_SEEDB3_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_SEEDB3_LANE3)(15 downto 0);
    constant E10GBASER_PCS_TEST_CTRL_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_TEST_CTRL_LANE0)(15 downto 0);
    constant E10GBASER_PCS_TEST_CTRL_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_TEST_CTRL_LANE1)(15 downto 0);
    constant E10GBASER_PCS_TEST_CTRL_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_TEST_CTRL_LANE2)(15 downto 0);
    constant E10GBASER_PCS_TEST_CTRL_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASER_PCS_TEST_CTRL_LANE3)(15 downto 0);
    constant E10GBASEX_PCS_TSTCTRL_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASEX_PCS_TSTCTRL_LANE0)(15 downto 0);
    constant E10GBASEX_PCS_TSTCTRL_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASEX_PCS_TSTCTRL_LANE1)(15 downto 0);
    constant E10GBASEX_PCS_TSTCTRL_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASEX_PCS_TSTCTRL_LANE2)(15 downto 0);
    constant E10GBASEX_PCS_TSTCTRL_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(E10GBASEX_PCS_TSTCTRL_LANE3)(15 downto 0);
    constant GLBL0_NOISE_CTRL_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(GLBL0_NOISE_CTRL)(15 downto 0);
    constant GLBL_AMON_SEL_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(GLBL_AMON_SEL)(15 downto 0);
    constant GLBL_DMON_SEL_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(GLBL_DMON_SEL)(15 downto 0);
    constant GLBL_PWR_CTRL_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(GLBL_PWR_CTRL)(15 downto 0);
    constant GTH_CFG_PWRUP_LANE0_BINARY : std_ulogic := To_StduLogic(GTH_CFG_PWRUP_LANE0);
    constant GTH_CFG_PWRUP_LANE1_BINARY : std_ulogic := To_StduLogic(GTH_CFG_PWRUP_LANE1);
    constant GTH_CFG_PWRUP_LANE2_BINARY : std_ulogic := To_StduLogic(GTH_CFG_PWRUP_LANE2);
    constant GTH_CFG_PWRUP_LANE3_BINARY : std_ulogic := To_StduLogic(GTH_CFG_PWRUP_LANE3);
    constant LANE_AMON_SEL_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(LANE_AMON_SEL)(15 downto 0);
    constant LANE_DMON_SEL_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(LANE_DMON_SEL)(15 downto 0);
    constant LANE_LNK_CFGOVRD_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(LANE_LNK_CFGOVRD)(15 downto 0);
    constant LANE_PWR_CTRL_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(LANE_PWR_CTRL_LANE0)(15 downto 0);
    constant LANE_PWR_CTRL_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(LANE_PWR_CTRL_LANE1)(15 downto 0);
    constant LANE_PWR_CTRL_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(LANE_PWR_CTRL_LANE2)(15 downto 0);
    constant LANE_PWR_CTRL_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(LANE_PWR_CTRL_LANE3)(15 downto 0);
    constant LNK_TRN_CFG_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(LNK_TRN_CFG_LANE0)(15 downto 0);
    constant LNK_TRN_CFG_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(LNK_TRN_CFG_LANE1)(15 downto 0);
    constant LNK_TRN_CFG_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(LNK_TRN_CFG_LANE2)(15 downto 0);
    constant LNK_TRN_CFG_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(LNK_TRN_CFG_LANE3)(15 downto 0);
    constant LNK_TRN_COEFF_REQ_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(LNK_TRN_COEFF_REQ_LANE0)(15 downto 0);
    constant LNK_TRN_COEFF_REQ_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(LNK_TRN_COEFF_REQ_LANE1)(15 downto 0);
    constant LNK_TRN_COEFF_REQ_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(LNK_TRN_COEFF_REQ_LANE2)(15 downto 0);
    constant LNK_TRN_COEFF_REQ_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(LNK_TRN_COEFF_REQ_LANE3)(15 downto 0);
    constant MISC_CFG_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(MISC_CFG)(15 downto 0);
    constant MODE_CFG1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(MODE_CFG1)(15 downto 0);
    constant MODE_CFG2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(MODE_CFG2)(15 downto 0);
    constant MODE_CFG3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(MODE_CFG3)(15 downto 0);
    constant MODE_CFG4_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(MODE_CFG4)(15 downto 0);
    constant MODE_CFG5_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(MODE_CFG5)(15 downto 0);
    constant MODE_CFG6_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(MODE_CFG6)(15 downto 0);
    constant MODE_CFG7_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(MODE_CFG7)(15 downto 0);
    constant PCS_ABILITY_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_ABILITY_LANE0)(15 downto 0);
    constant PCS_ABILITY_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_ABILITY_LANE1)(15 downto 0);
    constant PCS_ABILITY_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_ABILITY_LANE2)(15 downto 0);
    constant PCS_ABILITY_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_ABILITY_LANE3)(15 downto 0);
    constant PCS_CTRL1_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_CTRL1_LANE0)(15 downto 0);
    constant PCS_CTRL1_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_CTRL1_LANE1)(15 downto 0);
    constant PCS_CTRL1_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_CTRL1_LANE2)(15 downto 0);
    constant PCS_CTRL1_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_CTRL1_LANE3)(15 downto 0);
    constant PCS_CTRL2_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_CTRL2_LANE0)(15 downto 0);
    constant PCS_CTRL2_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_CTRL2_LANE1)(15 downto 0);
    constant PCS_CTRL2_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_CTRL2_LANE2)(15 downto 0);
    constant PCS_CTRL2_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_CTRL2_LANE3)(15 downto 0);
    constant PCS_MISC_CFG_0_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_MISC_CFG_0_LANE0)(15 downto 0);
    constant PCS_MISC_CFG_0_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_MISC_CFG_0_LANE1)(15 downto 0);
    constant PCS_MISC_CFG_0_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_MISC_CFG_0_LANE2)(15 downto 0);
    constant PCS_MISC_CFG_0_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_MISC_CFG_0_LANE3)(15 downto 0);
    constant PCS_MISC_CFG_1_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_MISC_CFG_1_LANE0)(15 downto 0);
    constant PCS_MISC_CFG_1_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_MISC_CFG_1_LANE1)(15 downto 0);
    constant PCS_MISC_CFG_1_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_MISC_CFG_1_LANE2)(15 downto 0);
    constant PCS_MISC_CFG_1_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_MISC_CFG_1_LANE3)(15 downto 0);
    constant PCS_MODE_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_MODE_LANE0)(15 downto 0);
    constant PCS_MODE_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_MODE_LANE1)(15 downto 0);
    constant PCS_MODE_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_MODE_LANE2)(15 downto 0);
    constant PCS_MODE_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_MODE_LANE3)(15 downto 0);
    constant PCS_RESET_1_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_RESET_1_LANE0)(15 downto 0);
    constant PCS_RESET_1_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_RESET_1_LANE1)(15 downto 0);
    constant PCS_RESET_1_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_RESET_1_LANE2)(15 downto 0);
    constant PCS_RESET_1_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_RESET_1_LANE3)(15 downto 0);
    constant PCS_RESET_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_RESET_LANE0)(15 downto 0);
    constant PCS_RESET_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_RESET_LANE1)(15 downto 0);
    constant PCS_RESET_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_RESET_LANE2)(15 downto 0);
    constant PCS_RESET_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_RESET_LANE3)(15 downto 0);
    constant PCS_TYPE_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_TYPE_LANE0)(15 downto 0);
    constant PCS_TYPE_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_TYPE_LANE1)(15 downto 0);
    constant PCS_TYPE_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_TYPE_LANE2)(15 downto 0);
    constant PCS_TYPE_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PCS_TYPE_LANE3)(15 downto 0);
    constant PLL_CFG0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PLL_CFG0)(15 downto 0);
    constant PLL_CFG1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PLL_CFG1)(15 downto 0);
    constant PLL_CFG2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PLL_CFG2)(15 downto 0);
    constant PMA_CTRL1_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PMA_CTRL1_LANE0)(15 downto 0);
    constant PMA_CTRL1_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PMA_CTRL1_LANE1)(15 downto 0);
    constant PMA_CTRL1_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PMA_CTRL1_LANE2)(15 downto 0);
    constant PMA_CTRL1_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PMA_CTRL1_LANE3)(15 downto 0);
    constant PMA_CTRL2_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PMA_CTRL2_LANE0)(15 downto 0);
    constant PMA_CTRL2_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PMA_CTRL2_LANE1)(15 downto 0);
    constant PMA_CTRL2_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PMA_CTRL2_LANE2)(15 downto 0);
    constant PMA_CTRL2_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PMA_CTRL2_LANE3)(15 downto 0);
    constant PMA_LPBK_CTRL_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PMA_LPBK_CTRL_LANE0)(15 downto 0);
    constant PMA_LPBK_CTRL_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PMA_LPBK_CTRL_LANE1)(15 downto 0);
    constant PMA_LPBK_CTRL_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PMA_LPBK_CTRL_LANE2)(15 downto 0);
    constant PMA_LPBK_CTRL_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PMA_LPBK_CTRL_LANE3)(15 downto 0);
    constant PRBS_BER_CFG0_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PRBS_BER_CFG0_LANE0)(15 downto 0);
    constant PRBS_BER_CFG0_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PRBS_BER_CFG0_LANE1)(15 downto 0);
    constant PRBS_BER_CFG0_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PRBS_BER_CFG0_LANE2)(15 downto 0);
    constant PRBS_BER_CFG0_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PRBS_BER_CFG0_LANE3)(15 downto 0);
    constant PRBS_BER_CFG1_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PRBS_BER_CFG1_LANE0)(15 downto 0);
    constant PRBS_BER_CFG1_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PRBS_BER_CFG1_LANE1)(15 downto 0);
    constant PRBS_BER_CFG1_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PRBS_BER_CFG1_LANE2)(15 downto 0);
    constant PRBS_BER_CFG1_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PRBS_BER_CFG1_LANE3)(15 downto 0);
    constant PRBS_CFG_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PRBS_CFG_LANE0)(15 downto 0);
    constant PRBS_CFG_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PRBS_CFG_LANE1)(15 downto 0);
    constant PRBS_CFG_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PRBS_CFG_LANE2)(15 downto 0);
    constant PRBS_CFG_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PRBS_CFG_LANE3)(15 downto 0);
    constant PTRN_CFG0_LSB_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PTRN_CFG0_LSB)(15 downto 0);
    constant PTRN_CFG0_MSB_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PTRN_CFG0_MSB)(15 downto 0);
    constant PTRN_LEN_CFG_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PTRN_LEN_CFG)(15 downto 0);
    constant PWRUP_DLY_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(PWRUP_DLY)(15 downto 0);
    constant RX_AEQ_VAL0_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_AEQ_VAL0_LANE0)(15 downto 0);
    constant RX_AEQ_VAL0_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_AEQ_VAL0_LANE1)(15 downto 0);
    constant RX_AEQ_VAL0_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_AEQ_VAL0_LANE2)(15 downto 0);
    constant RX_AEQ_VAL0_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_AEQ_VAL0_LANE3)(15 downto 0);
    constant RX_AEQ_VAL1_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_AEQ_VAL1_LANE0)(15 downto 0);
    constant RX_AEQ_VAL1_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_AEQ_VAL1_LANE1)(15 downto 0);
    constant RX_AEQ_VAL1_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_AEQ_VAL1_LANE2)(15 downto 0);
    constant RX_AEQ_VAL1_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_AEQ_VAL1_LANE3)(15 downto 0);
    constant RX_AGC_CTRL_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_AGC_CTRL_LANE0)(15 downto 0);
    constant RX_AGC_CTRL_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_AGC_CTRL_LANE1)(15 downto 0);
    constant RX_AGC_CTRL_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_AGC_CTRL_LANE2)(15 downto 0);
    constant RX_AGC_CTRL_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_AGC_CTRL_LANE3)(15 downto 0);
    constant RX_CDR_CTRL0_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CDR_CTRL0_LANE0)(15 downto 0);
    constant RX_CDR_CTRL0_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CDR_CTRL0_LANE1)(15 downto 0);
    constant RX_CDR_CTRL0_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CDR_CTRL0_LANE2)(15 downto 0);
    constant RX_CDR_CTRL0_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CDR_CTRL0_LANE3)(15 downto 0);
    constant RX_CDR_CTRL1_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CDR_CTRL1_LANE0)(15 downto 0);
    constant RX_CDR_CTRL1_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CDR_CTRL1_LANE1)(15 downto 0);
    constant RX_CDR_CTRL1_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CDR_CTRL1_LANE2)(15 downto 0);
    constant RX_CDR_CTRL1_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CDR_CTRL1_LANE3)(15 downto 0);
    constant RX_CDR_CTRL2_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CDR_CTRL2_LANE0)(15 downto 0);
    constant RX_CDR_CTRL2_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CDR_CTRL2_LANE1)(15 downto 0);
    constant RX_CDR_CTRL2_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CDR_CTRL2_LANE2)(15 downto 0);
    constant RX_CDR_CTRL2_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CDR_CTRL2_LANE3)(15 downto 0);
    constant RX_CFG0_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CFG0_LANE0)(15 downto 0);
    constant RX_CFG0_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CFG0_LANE1)(15 downto 0);
    constant RX_CFG0_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CFG0_LANE2)(15 downto 0);
    constant RX_CFG0_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CFG0_LANE3)(15 downto 0);
    constant RX_CFG1_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CFG1_LANE0)(15 downto 0);
    constant RX_CFG1_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CFG1_LANE1)(15 downto 0);
    constant RX_CFG1_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CFG1_LANE2)(15 downto 0);
    constant RX_CFG1_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CFG1_LANE3)(15 downto 0);
    constant RX_CFG2_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CFG2_LANE0)(15 downto 0);
    constant RX_CFG2_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CFG2_LANE1)(15 downto 0);
    constant RX_CFG2_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CFG2_LANE2)(15 downto 0);
    constant RX_CFG2_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CFG2_LANE3)(15 downto 0);
    constant RX_CTLE_CTRL_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CTLE_CTRL_LANE0)(15 downto 0);
    constant RX_CTLE_CTRL_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CTLE_CTRL_LANE1)(15 downto 0);
    constant RX_CTLE_CTRL_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CTLE_CTRL_LANE2)(15 downto 0);
    constant RX_CTLE_CTRL_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CTLE_CTRL_LANE3)(15 downto 0);
    constant RX_CTRL_OVRD_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CTRL_OVRD_LANE0)(15 downto 0);
    constant RX_CTRL_OVRD_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CTRL_OVRD_LANE1)(15 downto 0);
    constant RX_CTRL_OVRD_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CTRL_OVRD_LANE2)(15 downto 0);
    constant RX_CTRL_OVRD_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_CTRL_OVRD_LANE3)(15 downto 0);
    constant RX_LOOP_CTRL_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_LOOP_CTRL_LANE0)(15 downto 0);
    constant RX_LOOP_CTRL_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_LOOP_CTRL_LANE1)(15 downto 0);
    constant RX_LOOP_CTRL_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_LOOP_CTRL_LANE2)(15 downto 0);
    constant RX_LOOP_CTRL_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_LOOP_CTRL_LANE3)(15 downto 0);
    constant RX_MVAL0_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_MVAL0_LANE0)(15 downto 0);
    constant RX_MVAL0_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_MVAL0_LANE1)(15 downto 0);
    constant RX_MVAL0_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_MVAL0_LANE2)(15 downto 0);
    constant RX_MVAL0_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_MVAL0_LANE3)(15 downto 0);
    constant RX_MVAL1_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_MVAL1_LANE0)(15 downto 0);
    constant RX_MVAL1_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_MVAL1_LANE1)(15 downto 0);
    constant RX_MVAL1_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_MVAL1_LANE2)(15 downto 0);
    constant RX_MVAL1_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_MVAL1_LANE3)(15 downto 0);
    constant RX_P0S_CTRL_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_P0S_CTRL)(15 downto 0);
    constant RX_P0_CTRL_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_P0_CTRL)(15 downto 0);
    constant RX_P1_CTRL_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_P1_CTRL)(15 downto 0);
    constant RX_P2_CTRL_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_P2_CTRL)(15 downto 0);
    constant RX_PI_CTRL0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_PI_CTRL0)(15 downto 0);
    constant RX_PI_CTRL1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(RX_PI_CTRL1)(15 downto 0);
    constant SLICE_CFG_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(SLICE_CFG)(15 downto 0);
    constant SLICE_NOISE_CTRL_0_LANE01_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(SLICE_NOISE_CTRL_0_LANE01)(15 downto 0);
    constant SLICE_NOISE_CTRL_0_LANE23_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(SLICE_NOISE_CTRL_0_LANE23)(15 downto 0);
    constant SLICE_NOISE_CTRL_1_LANE01_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(SLICE_NOISE_CTRL_1_LANE01)(15 downto 0);
    constant SLICE_NOISE_CTRL_1_LANE23_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(SLICE_NOISE_CTRL_1_LANE23)(15 downto 0);
    constant SLICE_NOISE_CTRL_2_LANE01_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(SLICE_NOISE_CTRL_2_LANE01)(15 downto 0);
    constant SLICE_NOISE_CTRL_2_LANE23_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(SLICE_NOISE_CTRL_2_LANE23)(15 downto 0);
    constant SLICE_TX_RESET_LANE01_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(SLICE_TX_RESET_LANE01)(15 downto 0);
    constant SLICE_TX_RESET_LANE23_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(SLICE_TX_RESET_LANE23)(15 downto 0);
    constant TERM_CTRL_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TERM_CTRL_LANE0)(15 downto 0);
    constant TERM_CTRL_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TERM_CTRL_LANE1)(15 downto 0);
    constant TERM_CTRL_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TERM_CTRL_LANE2)(15 downto 0);
    constant TERM_CTRL_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TERM_CTRL_LANE3)(15 downto 0);
    constant TX_CFG0_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_CFG0_LANE0)(15 downto 0);
    constant TX_CFG0_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_CFG0_LANE1)(15 downto 0);
    constant TX_CFG0_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_CFG0_LANE2)(15 downto 0);
    constant TX_CFG0_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_CFG0_LANE3)(15 downto 0);
    constant TX_CFG1_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_CFG1_LANE0)(15 downto 0);
    constant TX_CFG1_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_CFG1_LANE1)(15 downto 0);
    constant TX_CFG1_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_CFG1_LANE2)(15 downto 0);
    constant TX_CFG1_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_CFG1_LANE3)(15 downto 0);
    constant TX_CFG2_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_CFG2_LANE0)(15 downto 0);
    constant TX_CFG2_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_CFG2_LANE1)(15 downto 0);
    constant TX_CFG2_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_CFG2_LANE2)(15 downto 0);
    constant TX_CFG2_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_CFG2_LANE3)(15 downto 0);
    constant TX_CLK_SEL0_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_CLK_SEL0_LANE0)(15 downto 0);
    constant TX_CLK_SEL0_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_CLK_SEL0_LANE1)(15 downto 0);
    constant TX_CLK_SEL0_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_CLK_SEL0_LANE2)(15 downto 0);
    constant TX_CLK_SEL0_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_CLK_SEL0_LANE3)(15 downto 0);
    constant TX_CLK_SEL1_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_CLK_SEL1_LANE0)(15 downto 0);
    constant TX_CLK_SEL1_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_CLK_SEL1_LANE1)(15 downto 0);
    constant TX_CLK_SEL1_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_CLK_SEL1_LANE2)(15 downto 0);
    constant TX_CLK_SEL1_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_CLK_SEL1_LANE3)(15 downto 0);
    constant TX_DISABLE_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_DISABLE_LANE0)(15 downto 0);
    constant TX_DISABLE_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_DISABLE_LANE1)(15 downto 0);
    constant TX_DISABLE_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_DISABLE_LANE2)(15 downto 0);
    constant TX_DISABLE_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_DISABLE_LANE3)(15 downto 0);
    constant TX_P0P0S_CTRL_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_P0P0S_CTRL)(15 downto 0);
    constant TX_P1P2_CTRL_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_P1P2_CTRL)(15 downto 0);
    constant TX_PREEMPH_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_PREEMPH_LANE0)(15 downto 0);
    constant TX_PREEMPH_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_PREEMPH_LANE1)(15 downto 0);
    constant TX_PREEMPH_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_PREEMPH_LANE2)(15 downto 0);
    constant TX_PREEMPH_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_PREEMPH_LANE3)(15 downto 0);
    constant TX_PWR_RATE_OVRD_LANE0_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_PWR_RATE_OVRD_LANE0)(15 downto 0);
    constant TX_PWR_RATE_OVRD_LANE1_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_PWR_RATE_OVRD_LANE1)(15 downto 0);
    constant TX_PWR_RATE_OVRD_LANE2_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_PWR_RATE_OVRD_LANE2)(15 downto 0);
    constant TX_PWR_RATE_OVRD_LANE3_BINARY : std_logic_vector(15 downto 0) := To_StdLogicVector(TX_PWR_RATE_OVRD_LANE3)(15 downto 0);
    
    -- Get String Length
    constant BER_CONST_PTRN0_STRLEN : integer := getstrlength(BER_CONST_PTRN0_BINARY);
    constant BER_CONST_PTRN1_STRLEN : integer := getstrlength(BER_CONST_PTRN1_BINARY);
    constant BUFFER_CONFIG_LANE0_STRLEN : integer := getstrlength(BUFFER_CONFIG_LANE0_BINARY);
    constant BUFFER_CONFIG_LANE1_STRLEN : integer := getstrlength(BUFFER_CONFIG_LANE1_BINARY);
    constant BUFFER_CONFIG_LANE2_STRLEN : integer := getstrlength(BUFFER_CONFIG_LANE2_BINARY);
    constant BUFFER_CONFIG_LANE3_STRLEN : integer := getstrlength(BUFFER_CONFIG_LANE3_BINARY);
    constant DFE_TRAIN_CTRL_LANE0_STRLEN : integer := getstrlength(DFE_TRAIN_CTRL_LANE0_BINARY);
    constant DFE_TRAIN_CTRL_LANE1_STRLEN : integer := getstrlength(DFE_TRAIN_CTRL_LANE1_BINARY);
    constant DFE_TRAIN_CTRL_LANE2_STRLEN : integer := getstrlength(DFE_TRAIN_CTRL_LANE2_BINARY);
    constant DFE_TRAIN_CTRL_LANE3_STRLEN : integer := getstrlength(DFE_TRAIN_CTRL_LANE3_BINARY);
    constant DLL_CFG0_STRLEN : integer := getstrlength(DLL_CFG0_BINARY);
    constant DLL_CFG1_STRLEN : integer := getstrlength(DLL_CFG1_BINARY);
    constant E10GBASEKR_LD_COEFF_UPD_LANE0_STRLEN : integer := getstrlength(E10GBASEKR_LD_COEFF_UPD_LANE0_BINARY);
    constant E10GBASEKR_LD_COEFF_UPD_LANE1_STRLEN : integer := getstrlength(E10GBASEKR_LD_COEFF_UPD_LANE1_BINARY);
    constant E10GBASEKR_LD_COEFF_UPD_LANE2_STRLEN : integer := getstrlength(E10GBASEKR_LD_COEFF_UPD_LANE2_BINARY);
    constant E10GBASEKR_LD_COEFF_UPD_LANE3_STRLEN : integer := getstrlength(E10GBASEKR_LD_COEFF_UPD_LANE3_BINARY);
    constant E10GBASEKR_LP_COEFF_UPD_LANE0_STRLEN : integer := getstrlength(E10GBASEKR_LP_COEFF_UPD_LANE0_BINARY);
    constant E10GBASEKR_LP_COEFF_UPD_LANE1_STRLEN : integer := getstrlength(E10GBASEKR_LP_COEFF_UPD_LANE1_BINARY);
    constant E10GBASEKR_LP_COEFF_UPD_LANE2_STRLEN : integer := getstrlength(E10GBASEKR_LP_COEFF_UPD_LANE2_BINARY);
    constant E10GBASEKR_LP_COEFF_UPD_LANE3_STRLEN : integer := getstrlength(E10GBASEKR_LP_COEFF_UPD_LANE3_BINARY);
    constant E10GBASEKR_PMA_CTRL_LANE0_STRLEN : integer := getstrlength(E10GBASEKR_PMA_CTRL_LANE0_BINARY);
    constant E10GBASEKR_PMA_CTRL_LANE1_STRLEN : integer := getstrlength(E10GBASEKR_PMA_CTRL_LANE1_BINARY);
    constant E10GBASEKR_PMA_CTRL_LANE2_STRLEN : integer := getstrlength(E10GBASEKR_PMA_CTRL_LANE2_BINARY);
    constant E10GBASEKR_PMA_CTRL_LANE3_STRLEN : integer := getstrlength(E10GBASEKR_PMA_CTRL_LANE3_BINARY);
    constant E10GBASEKX_CTRL_LANE0_STRLEN : integer := getstrlength(E10GBASEKX_CTRL_LANE0_BINARY);
    constant E10GBASEKX_CTRL_LANE1_STRLEN : integer := getstrlength(E10GBASEKX_CTRL_LANE1_BINARY);
    constant E10GBASEKX_CTRL_LANE2_STRLEN : integer := getstrlength(E10GBASEKX_CTRL_LANE2_BINARY);
    constant E10GBASEKX_CTRL_LANE3_STRLEN : integer := getstrlength(E10GBASEKX_CTRL_LANE3_BINARY);
    constant E10GBASER_PCS_CFG_LANE0_STRLEN : integer := getstrlength(E10GBASER_PCS_CFG_LANE0_BINARY);
    constant E10GBASER_PCS_CFG_LANE1_STRLEN : integer := getstrlength(E10GBASER_PCS_CFG_LANE1_BINARY);
    constant E10GBASER_PCS_CFG_LANE2_STRLEN : integer := getstrlength(E10GBASER_PCS_CFG_LANE2_BINARY);
    constant E10GBASER_PCS_CFG_LANE3_STRLEN : integer := getstrlength(E10GBASER_PCS_CFG_LANE3_BINARY);
    constant E10GBASER_PCS_SEEDA0_LANE0_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDA0_LANE0_BINARY);
    constant E10GBASER_PCS_SEEDA0_LANE1_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDA0_LANE1_BINARY);
    constant E10GBASER_PCS_SEEDA0_LANE2_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDA0_LANE2_BINARY);
    constant E10GBASER_PCS_SEEDA0_LANE3_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDA0_LANE3_BINARY);
    constant E10GBASER_PCS_SEEDA1_LANE0_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDA1_LANE0_BINARY);
    constant E10GBASER_PCS_SEEDA1_LANE1_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDA1_LANE1_BINARY);
    constant E10GBASER_PCS_SEEDA1_LANE2_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDA1_LANE2_BINARY);
    constant E10GBASER_PCS_SEEDA1_LANE3_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDA1_LANE3_BINARY);
    constant E10GBASER_PCS_SEEDA2_LANE0_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDA2_LANE0_BINARY);
    constant E10GBASER_PCS_SEEDA2_LANE1_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDA2_LANE1_BINARY);
    constant E10GBASER_PCS_SEEDA2_LANE2_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDA2_LANE2_BINARY);
    constant E10GBASER_PCS_SEEDA2_LANE3_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDA2_LANE3_BINARY);
    constant E10GBASER_PCS_SEEDA3_LANE0_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDA3_LANE0_BINARY);
    constant E10GBASER_PCS_SEEDA3_LANE1_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDA3_LANE1_BINARY);
    constant E10GBASER_PCS_SEEDA3_LANE2_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDA3_LANE2_BINARY);
    constant E10GBASER_PCS_SEEDA3_LANE3_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDA3_LANE3_BINARY);
    constant E10GBASER_PCS_SEEDB0_LANE0_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDB0_LANE0_BINARY);
    constant E10GBASER_PCS_SEEDB0_LANE1_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDB0_LANE1_BINARY);
    constant E10GBASER_PCS_SEEDB0_LANE2_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDB0_LANE2_BINARY);
    constant E10GBASER_PCS_SEEDB0_LANE3_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDB0_LANE3_BINARY);
    constant E10GBASER_PCS_SEEDB1_LANE0_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDB1_LANE0_BINARY);
    constant E10GBASER_PCS_SEEDB1_LANE1_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDB1_LANE1_BINARY);
    constant E10GBASER_PCS_SEEDB1_LANE2_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDB1_LANE2_BINARY);
    constant E10GBASER_PCS_SEEDB1_LANE3_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDB1_LANE3_BINARY);
    constant E10GBASER_PCS_SEEDB2_LANE0_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDB2_LANE0_BINARY);
    constant E10GBASER_PCS_SEEDB2_LANE1_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDB2_LANE1_BINARY);
    constant E10GBASER_PCS_SEEDB2_LANE2_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDB2_LANE2_BINARY);
    constant E10GBASER_PCS_SEEDB2_LANE3_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDB2_LANE3_BINARY);
    constant E10GBASER_PCS_SEEDB3_LANE0_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDB3_LANE0_BINARY);
    constant E10GBASER_PCS_SEEDB3_LANE1_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDB3_LANE1_BINARY);
    constant E10GBASER_PCS_SEEDB3_LANE2_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDB3_LANE2_BINARY);
    constant E10GBASER_PCS_SEEDB3_LANE3_STRLEN : integer := getstrlength(E10GBASER_PCS_SEEDB3_LANE3_BINARY);
    constant E10GBASER_PCS_TEST_CTRL_LANE0_STRLEN : integer := getstrlength(E10GBASER_PCS_TEST_CTRL_LANE0_BINARY);
    constant E10GBASER_PCS_TEST_CTRL_LANE1_STRLEN : integer := getstrlength(E10GBASER_PCS_TEST_CTRL_LANE1_BINARY);
    constant E10GBASER_PCS_TEST_CTRL_LANE2_STRLEN : integer := getstrlength(E10GBASER_PCS_TEST_CTRL_LANE2_BINARY);
    constant E10GBASER_PCS_TEST_CTRL_LANE3_STRLEN : integer := getstrlength(E10GBASER_PCS_TEST_CTRL_LANE3_BINARY);
    constant E10GBASEX_PCS_TSTCTRL_LANE0_STRLEN : integer := getstrlength(E10GBASEX_PCS_TSTCTRL_LANE0_BINARY);
    constant E10GBASEX_PCS_TSTCTRL_LANE1_STRLEN : integer := getstrlength(E10GBASEX_PCS_TSTCTRL_LANE1_BINARY);
    constant E10GBASEX_PCS_TSTCTRL_LANE2_STRLEN : integer := getstrlength(E10GBASEX_PCS_TSTCTRL_LANE2_BINARY);
    constant E10GBASEX_PCS_TSTCTRL_LANE3_STRLEN : integer := getstrlength(E10GBASEX_PCS_TSTCTRL_LANE3_BINARY);
    constant GLBL0_NOISE_CTRL_STRLEN : integer := getstrlength(GLBL0_NOISE_CTRL_BINARY);
    constant GLBL_AMON_SEL_STRLEN : integer := getstrlength(GLBL_AMON_SEL_BINARY);
    constant GLBL_DMON_SEL_STRLEN : integer := getstrlength(GLBL_DMON_SEL_BINARY);
    constant GLBL_PWR_CTRL_STRLEN : integer := getstrlength(GLBL_PWR_CTRL_BINARY);
    constant LANE_AMON_SEL_STRLEN : integer := getstrlength(LANE_AMON_SEL_BINARY);
    constant LANE_DMON_SEL_STRLEN : integer := getstrlength(LANE_DMON_SEL_BINARY);
    constant LANE_LNK_CFGOVRD_STRLEN : integer := getstrlength(LANE_LNK_CFGOVRD_BINARY);
    constant LANE_PWR_CTRL_LANE0_STRLEN : integer := getstrlength(LANE_PWR_CTRL_LANE0_BINARY);
    constant LANE_PWR_CTRL_LANE1_STRLEN : integer := getstrlength(LANE_PWR_CTRL_LANE1_BINARY);
    constant LANE_PWR_CTRL_LANE2_STRLEN : integer := getstrlength(LANE_PWR_CTRL_LANE2_BINARY);
    constant LANE_PWR_CTRL_LANE3_STRLEN : integer := getstrlength(LANE_PWR_CTRL_LANE3_BINARY);
    constant LNK_TRN_CFG_LANE0_STRLEN : integer := getstrlength(LNK_TRN_CFG_LANE0_BINARY);
    constant LNK_TRN_CFG_LANE1_STRLEN : integer := getstrlength(LNK_TRN_CFG_LANE1_BINARY);
    constant LNK_TRN_CFG_LANE2_STRLEN : integer := getstrlength(LNK_TRN_CFG_LANE2_BINARY);
    constant LNK_TRN_CFG_LANE3_STRLEN : integer := getstrlength(LNK_TRN_CFG_LANE3_BINARY);
    constant LNK_TRN_COEFF_REQ_LANE0_STRLEN : integer := getstrlength(LNK_TRN_COEFF_REQ_LANE0_BINARY);
    constant LNK_TRN_COEFF_REQ_LANE1_STRLEN : integer := getstrlength(LNK_TRN_COEFF_REQ_LANE1_BINARY);
    constant LNK_TRN_COEFF_REQ_LANE2_STRLEN : integer := getstrlength(LNK_TRN_COEFF_REQ_LANE2_BINARY);
    constant LNK_TRN_COEFF_REQ_LANE3_STRLEN : integer := getstrlength(LNK_TRN_COEFF_REQ_LANE3_BINARY);
    constant MISC_CFG_STRLEN : integer := getstrlength(MISC_CFG_BINARY);
    constant MODE_CFG1_STRLEN : integer := getstrlength(MODE_CFG1_BINARY);
    constant MODE_CFG2_STRLEN : integer := getstrlength(MODE_CFG2_BINARY);
    constant MODE_CFG3_STRLEN : integer := getstrlength(MODE_CFG3_BINARY);
    constant MODE_CFG4_STRLEN : integer := getstrlength(MODE_CFG4_BINARY);
    constant MODE_CFG5_STRLEN : integer := getstrlength(MODE_CFG5_BINARY);
    constant MODE_CFG6_STRLEN : integer := getstrlength(MODE_CFG6_BINARY);
    constant MODE_CFG7_STRLEN : integer := getstrlength(MODE_CFG7_BINARY);
    constant PCS_ABILITY_LANE0_STRLEN : integer := getstrlength(PCS_ABILITY_LANE0_BINARY);
    constant PCS_ABILITY_LANE1_STRLEN : integer := getstrlength(PCS_ABILITY_LANE1_BINARY);
    constant PCS_ABILITY_LANE2_STRLEN : integer := getstrlength(PCS_ABILITY_LANE2_BINARY);
    constant PCS_ABILITY_LANE3_STRLEN : integer := getstrlength(PCS_ABILITY_LANE3_BINARY);
    constant PCS_CTRL1_LANE0_STRLEN : integer := getstrlength(PCS_CTRL1_LANE0_BINARY);
    constant PCS_CTRL1_LANE1_STRLEN : integer := getstrlength(PCS_CTRL1_LANE1_BINARY);
    constant PCS_CTRL1_LANE2_STRLEN : integer := getstrlength(PCS_CTRL1_LANE2_BINARY);
    constant PCS_CTRL1_LANE3_STRLEN : integer := getstrlength(PCS_CTRL1_LANE3_BINARY);
    constant PCS_CTRL2_LANE0_STRLEN : integer := getstrlength(PCS_CTRL2_LANE0_BINARY);
    constant PCS_CTRL2_LANE1_STRLEN : integer := getstrlength(PCS_CTRL2_LANE1_BINARY);
    constant PCS_CTRL2_LANE2_STRLEN : integer := getstrlength(PCS_CTRL2_LANE2_BINARY);
    constant PCS_CTRL2_LANE3_STRLEN : integer := getstrlength(PCS_CTRL2_LANE3_BINARY);
    constant PCS_MISC_CFG_0_LANE0_STRLEN : integer := getstrlength(PCS_MISC_CFG_0_LANE0_BINARY);
    constant PCS_MISC_CFG_0_LANE1_STRLEN : integer := getstrlength(PCS_MISC_CFG_0_LANE1_BINARY);
    constant PCS_MISC_CFG_0_LANE2_STRLEN : integer := getstrlength(PCS_MISC_CFG_0_LANE2_BINARY);
    constant PCS_MISC_CFG_0_LANE3_STRLEN : integer := getstrlength(PCS_MISC_CFG_0_LANE3_BINARY);
    constant PCS_MISC_CFG_1_LANE0_STRLEN : integer := getstrlength(PCS_MISC_CFG_1_LANE0_BINARY);
    constant PCS_MISC_CFG_1_LANE1_STRLEN : integer := getstrlength(PCS_MISC_CFG_1_LANE1_BINARY);
    constant PCS_MISC_CFG_1_LANE2_STRLEN : integer := getstrlength(PCS_MISC_CFG_1_LANE2_BINARY);
    constant PCS_MISC_CFG_1_LANE3_STRLEN : integer := getstrlength(PCS_MISC_CFG_1_LANE3_BINARY);
    constant PCS_MODE_LANE0_STRLEN : integer := getstrlength(PCS_MODE_LANE0_BINARY);
    constant PCS_MODE_LANE1_STRLEN : integer := getstrlength(PCS_MODE_LANE1_BINARY);
    constant PCS_MODE_LANE2_STRLEN : integer := getstrlength(PCS_MODE_LANE2_BINARY);
    constant PCS_MODE_LANE3_STRLEN : integer := getstrlength(PCS_MODE_LANE3_BINARY);
    constant PCS_RESET_1_LANE0_STRLEN : integer := getstrlength(PCS_RESET_1_LANE0_BINARY);
    constant PCS_RESET_1_LANE1_STRLEN : integer := getstrlength(PCS_RESET_1_LANE1_BINARY);
    constant PCS_RESET_1_LANE2_STRLEN : integer := getstrlength(PCS_RESET_1_LANE2_BINARY);
    constant PCS_RESET_1_LANE3_STRLEN : integer := getstrlength(PCS_RESET_1_LANE3_BINARY);
    constant PCS_RESET_LANE0_STRLEN : integer := getstrlength(PCS_RESET_LANE0_BINARY);
    constant PCS_RESET_LANE1_STRLEN : integer := getstrlength(PCS_RESET_LANE1_BINARY);
    constant PCS_RESET_LANE2_STRLEN : integer := getstrlength(PCS_RESET_LANE2_BINARY);
    constant PCS_RESET_LANE3_STRLEN : integer := getstrlength(PCS_RESET_LANE3_BINARY);
    constant PCS_TYPE_LANE0_STRLEN : integer := getstrlength(PCS_TYPE_LANE0_BINARY);
    constant PCS_TYPE_LANE1_STRLEN : integer := getstrlength(PCS_TYPE_LANE1_BINARY);
    constant PCS_TYPE_LANE2_STRLEN : integer := getstrlength(PCS_TYPE_LANE2_BINARY);
    constant PCS_TYPE_LANE3_STRLEN : integer := getstrlength(PCS_TYPE_LANE3_BINARY);
    constant PLL_CFG0_STRLEN : integer := getstrlength(PLL_CFG0_BINARY);
    constant PLL_CFG1_STRLEN : integer := getstrlength(PLL_CFG1_BINARY);
    constant PLL_CFG2_STRLEN : integer := getstrlength(PLL_CFG2_BINARY);
    constant PMA_CTRL1_LANE0_STRLEN : integer := getstrlength(PMA_CTRL1_LANE0_BINARY);
    constant PMA_CTRL1_LANE1_STRLEN : integer := getstrlength(PMA_CTRL1_LANE1_BINARY);
    constant PMA_CTRL1_LANE2_STRLEN : integer := getstrlength(PMA_CTRL1_LANE2_BINARY);
    constant PMA_CTRL1_LANE3_STRLEN : integer := getstrlength(PMA_CTRL1_LANE3_BINARY);
    constant PMA_CTRL2_LANE0_STRLEN : integer := getstrlength(PMA_CTRL2_LANE0_BINARY);
    constant PMA_CTRL2_LANE1_STRLEN : integer := getstrlength(PMA_CTRL2_LANE1_BINARY);
    constant PMA_CTRL2_LANE2_STRLEN : integer := getstrlength(PMA_CTRL2_LANE2_BINARY);
    constant PMA_CTRL2_LANE3_STRLEN : integer := getstrlength(PMA_CTRL2_LANE3_BINARY);
    constant PMA_LPBK_CTRL_LANE0_STRLEN : integer := getstrlength(PMA_LPBK_CTRL_LANE0_BINARY);
    constant PMA_LPBK_CTRL_LANE1_STRLEN : integer := getstrlength(PMA_LPBK_CTRL_LANE1_BINARY);
    constant PMA_LPBK_CTRL_LANE2_STRLEN : integer := getstrlength(PMA_LPBK_CTRL_LANE2_BINARY);
    constant PMA_LPBK_CTRL_LANE3_STRLEN : integer := getstrlength(PMA_LPBK_CTRL_LANE3_BINARY);
    constant PRBS_BER_CFG0_LANE0_STRLEN : integer := getstrlength(PRBS_BER_CFG0_LANE0_BINARY);
    constant PRBS_BER_CFG0_LANE1_STRLEN : integer := getstrlength(PRBS_BER_CFG0_LANE1_BINARY);
    constant PRBS_BER_CFG0_LANE2_STRLEN : integer := getstrlength(PRBS_BER_CFG0_LANE2_BINARY);
    constant PRBS_BER_CFG0_LANE3_STRLEN : integer := getstrlength(PRBS_BER_CFG0_LANE3_BINARY);
    constant PRBS_BER_CFG1_LANE0_STRLEN : integer := getstrlength(PRBS_BER_CFG1_LANE0_BINARY);
    constant PRBS_BER_CFG1_LANE1_STRLEN : integer := getstrlength(PRBS_BER_CFG1_LANE1_BINARY);
    constant PRBS_BER_CFG1_LANE2_STRLEN : integer := getstrlength(PRBS_BER_CFG1_LANE2_BINARY);
    constant PRBS_BER_CFG1_LANE3_STRLEN : integer := getstrlength(PRBS_BER_CFG1_LANE3_BINARY);
    constant PRBS_CFG_LANE0_STRLEN : integer := getstrlength(PRBS_CFG_LANE0_BINARY);
    constant PRBS_CFG_LANE1_STRLEN : integer := getstrlength(PRBS_CFG_LANE1_BINARY);
    constant PRBS_CFG_LANE2_STRLEN : integer := getstrlength(PRBS_CFG_LANE2_BINARY);
    constant PRBS_CFG_LANE3_STRLEN : integer := getstrlength(PRBS_CFG_LANE3_BINARY);
    constant PTRN_CFG0_LSB_STRLEN : integer := getstrlength(PTRN_CFG0_LSB_BINARY);
    constant PTRN_CFG0_MSB_STRLEN : integer := getstrlength(PTRN_CFG0_MSB_BINARY);
    constant PTRN_LEN_CFG_STRLEN : integer := getstrlength(PTRN_LEN_CFG_BINARY);
    constant PWRUP_DLY_STRLEN : integer := getstrlength(PWRUP_DLY_BINARY);
    constant RX_AEQ_VAL0_LANE0_STRLEN : integer := getstrlength(RX_AEQ_VAL0_LANE0_BINARY);
    constant RX_AEQ_VAL0_LANE1_STRLEN : integer := getstrlength(RX_AEQ_VAL0_LANE1_BINARY);
    constant RX_AEQ_VAL0_LANE2_STRLEN : integer := getstrlength(RX_AEQ_VAL0_LANE2_BINARY);
    constant RX_AEQ_VAL0_LANE3_STRLEN : integer := getstrlength(RX_AEQ_VAL0_LANE3_BINARY);
    constant RX_AEQ_VAL1_LANE0_STRLEN : integer := getstrlength(RX_AEQ_VAL1_LANE0_BINARY);
    constant RX_AEQ_VAL1_LANE1_STRLEN : integer := getstrlength(RX_AEQ_VAL1_LANE1_BINARY);
    constant RX_AEQ_VAL1_LANE2_STRLEN : integer := getstrlength(RX_AEQ_VAL1_LANE2_BINARY);
    constant RX_AEQ_VAL1_LANE3_STRLEN : integer := getstrlength(RX_AEQ_VAL1_LANE3_BINARY);
    constant RX_AGC_CTRL_LANE0_STRLEN : integer := getstrlength(RX_AGC_CTRL_LANE0_BINARY);
    constant RX_AGC_CTRL_LANE1_STRLEN : integer := getstrlength(RX_AGC_CTRL_LANE1_BINARY);
    constant RX_AGC_CTRL_LANE2_STRLEN : integer := getstrlength(RX_AGC_CTRL_LANE2_BINARY);
    constant RX_AGC_CTRL_LANE3_STRLEN : integer := getstrlength(RX_AGC_CTRL_LANE3_BINARY);
    constant RX_CDR_CTRL0_LANE0_STRLEN : integer := getstrlength(RX_CDR_CTRL0_LANE0_BINARY);
    constant RX_CDR_CTRL0_LANE1_STRLEN : integer := getstrlength(RX_CDR_CTRL0_LANE1_BINARY);
    constant RX_CDR_CTRL0_LANE2_STRLEN : integer := getstrlength(RX_CDR_CTRL0_LANE2_BINARY);
    constant RX_CDR_CTRL0_LANE3_STRLEN : integer := getstrlength(RX_CDR_CTRL0_LANE3_BINARY);
    constant RX_CDR_CTRL1_LANE0_STRLEN : integer := getstrlength(RX_CDR_CTRL1_LANE0_BINARY);
    constant RX_CDR_CTRL1_LANE1_STRLEN : integer := getstrlength(RX_CDR_CTRL1_LANE1_BINARY);
    constant RX_CDR_CTRL1_LANE2_STRLEN : integer := getstrlength(RX_CDR_CTRL1_LANE2_BINARY);
    constant RX_CDR_CTRL1_LANE3_STRLEN : integer := getstrlength(RX_CDR_CTRL1_LANE3_BINARY);
    constant RX_CDR_CTRL2_LANE0_STRLEN : integer := getstrlength(RX_CDR_CTRL2_LANE0_BINARY);
    constant RX_CDR_CTRL2_LANE1_STRLEN : integer := getstrlength(RX_CDR_CTRL2_LANE1_BINARY);
    constant RX_CDR_CTRL2_LANE2_STRLEN : integer := getstrlength(RX_CDR_CTRL2_LANE2_BINARY);
    constant RX_CDR_CTRL2_LANE3_STRLEN : integer := getstrlength(RX_CDR_CTRL2_LANE3_BINARY);
    constant RX_CFG0_LANE0_STRLEN : integer := getstrlength(RX_CFG0_LANE0_BINARY);
    constant RX_CFG0_LANE1_STRLEN : integer := getstrlength(RX_CFG0_LANE1_BINARY);
    constant RX_CFG0_LANE2_STRLEN : integer := getstrlength(RX_CFG0_LANE2_BINARY);
    constant RX_CFG0_LANE3_STRLEN : integer := getstrlength(RX_CFG0_LANE3_BINARY);
    constant RX_CFG1_LANE0_STRLEN : integer := getstrlength(RX_CFG1_LANE0_BINARY);
    constant RX_CFG1_LANE1_STRLEN : integer := getstrlength(RX_CFG1_LANE1_BINARY);
    constant RX_CFG1_LANE2_STRLEN : integer := getstrlength(RX_CFG1_LANE2_BINARY);
    constant RX_CFG1_LANE3_STRLEN : integer := getstrlength(RX_CFG1_LANE3_BINARY);
    constant RX_CFG2_LANE0_STRLEN : integer := getstrlength(RX_CFG2_LANE0_BINARY);
    constant RX_CFG2_LANE1_STRLEN : integer := getstrlength(RX_CFG2_LANE1_BINARY);
    constant RX_CFG2_LANE2_STRLEN : integer := getstrlength(RX_CFG2_LANE2_BINARY);
    constant RX_CFG2_LANE3_STRLEN : integer := getstrlength(RX_CFG2_LANE3_BINARY);
    constant RX_CTLE_CTRL_LANE0_STRLEN : integer := getstrlength(RX_CTLE_CTRL_LANE0_BINARY);
    constant RX_CTLE_CTRL_LANE1_STRLEN : integer := getstrlength(RX_CTLE_CTRL_LANE1_BINARY);
    constant RX_CTLE_CTRL_LANE2_STRLEN : integer := getstrlength(RX_CTLE_CTRL_LANE2_BINARY);
    constant RX_CTLE_CTRL_LANE3_STRLEN : integer := getstrlength(RX_CTLE_CTRL_LANE3_BINARY);
    constant RX_CTRL_OVRD_LANE0_STRLEN : integer := getstrlength(RX_CTRL_OVRD_LANE0_BINARY);
    constant RX_CTRL_OVRD_LANE1_STRLEN : integer := getstrlength(RX_CTRL_OVRD_LANE1_BINARY);
    constant RX_CTRL_OVRD_LANE2_STRLEN : integer := getstrlength(RX_CTRL_OVRD_LANE2_BINARY);
    constant RX_CTRL_OVRD_LANE3_STRLEN : integer := getstrlength(RX_CTRL_OVRD_LANE3_BINARY);
    constant RX_LOOP_CTRL_LANE0_STRLEN : integer := getstrlength(RX_LOOP_CTRL_LANE0_BINARY);
    constant RX_LOOP_CTRL_LANE1_STRLEN : integer := getstrlength(RX_LOOP_CTRL_LANE1_BINARY);
    constant RX_LOOP_CTRL_LANE2_STRLEN : integer := getstrlength(RX_LOOP_CTRL_LANE2_BINARY);
    constant RX_LOOP_CTRL_LANE3_STRLEN : integer := getstrlength(RX_LOOP_CTRL_LANE3_BINARY);
    constant RX_MVAL0_LANE0_STRLEN : integer := getstrlength(RX_MVAL0_LANE0_BINARY);
    constant RX_MVAL0_LANE1_STRLEN : integer := getstrlength(RX_MVAL0_LANE1_BINARY);
    constant RX_MVAL0_LANE2_STRLEN : integer := getstrlength(RX_MVAL0_LANE2_BINARY);
    constant RX_MVAL0_LANE3_STRLEN : integer := getstrlength(RX_MVAL0_LANE3_BINARY);
    constant RX_MVAL1_LANE0_STRLEN : integer := getstrlength(RX_MVAL1_LANE0_BINARY);
    constant RX_MVAL1_LANE1_STRLEN : integer := getstrlength(RX_MVAL1_LANE1_BINARY);
    constant RX_MVAL1_LANE2_STRLEN : integer := getstrlength(RX_MVAL1_LANE2_BINARY);
    constant RX_MVAL1_LANE3_STRLEN : integer := getstrlength(RX_MVAL1_LANE3_BINARY);
    constant RX_P0S_CTRL_STRLEN : integer := getstrlength(RX_P0S_CTRL_BINARY);
    constant RX_P0_CTRL_STRLEN : integer := getstrlength(RX_P0_CTRL_BINARY);
    constant RX_P1_CTRL_STRLEN : integer := getstrlength(RX_P1_CTRL_BINARY);
    constant RX_P2_CTRL_STRLEN : integer := getstrlength(RX_P2_CTRL_BINARY);
    constant RX_PI_CTRL0_STRLEN : integer := getstrlength(RX_PI_CTRL0_BINARY);
    constant RX_PI_CTRL1_STRLEN : integer := getstrlength(RX_PI_CTRL1_BINARY);
    constant SLICE_CFG_STRLEN : integer := getstrlength(SLICE_CFG_BINARY);
    constant SLICE_NOISE_CTRL_0_LANE01_STRLEN : integer := getstrlength(SLICE_NOISE_CTRL_0_LANE01_BINARY);
    constant SLICE_NOISE_CTRL_0_LANE23_STRLEN : integer := getstrlength(SLICE_NOISE_CTRL_0_LANE23_BINARY);
    constant SLICE_NOISE_CTRL_1_LANE01_STRLEN : integer := getstrlength(SLICE_NOISE_CTRL_1_LANE01_BINARY);
    constant SLICE_NOISE_CTRL_1_LANE23_STRLEN : integer := getstrlength(SLICE_NOISE_CTRL_1_LANE23_BINARY);
    constant SLICE_NOISE_CTRL_2_LANE01_STRLEN : integer := getstrlength(SLICE_NOISE_CTRL_2_LANE01_BINARY);
    constant SLICE_NOISE_CTRL_2_LANE23_STRLEN : integer := getstrlength(SLICE_NOISE_CTRL_2_LANE23_BINARY);
    constant SLICE_TX_RESET_LANE01_STRLEN : integer := getstrlength(SLICE_TX_RESET_LANE01_BINARY);
    constant SLICE_TX_RESET_LANE23_STRLEN : integer := getstrlength(SLICE_TX_RESET_LANE23_BINARY);
    constant TERM_CTRL_LANE0_STRLEN : integer := getstrlength(TERM_CTRL_LANE0_BINARY);
    constant TERM_CTRL_LANE1_STRLEN : integer := getstrlength(TERM_CTRL_LANE1_BINARY);
    constant TERM_CTRL_LANE2_STRLEN : integer := getstrlength(TERM_CTRL_LANE2_BINARY);
    constant TERM_CTRL_LANE3_STRLEN : integer := getstrlength(TERM_CTRL_LANE3_BINARY);
    constant TX_CFG0_LANE0_STRLEN : integer := getstrlength(TX_CFG0_LANE0_BINARY);
    constant TX_CFG0_LANE1_STRLEN : integer := getstrlength(TX_CFG0_LANE1_BINARY);
    constant TX_CFG0_LANE2_STRLEN : integer := getstrlength(TX_CFG0_LANE2_BINARY);
    constant TX_CFG0_LANE3_STRLEN : integer := getstrlength(TX_CFG0_LANE3_BINARY);
    constant TX_CFG1_LANE0_STRLEN : integer := getstrlength(TX_CFG1_LANE0_BINARY);
    constant TX_CFG1_LANE1_STRLEN : integer := getstrlength(TX_CFG1_LANE1_BINARY);
    constant TX_CFG1_LANE2_STRLEN : integer := getstrlength(TX_CFG1_LANE2_BINARY);
    constant TX_CFG1_LANE3_STRLEN : integer := getstrlength(TX_CFG1_LANE3_BINARY);
    constant TX_CFG2_LANE0_STRLEN : integer := getstrlength(TX_CFG2_LANE0_BINARY);
    constant TX_CFG2_LANE1_STRLEN : integer := getstrlength(TX_CFG2_LANE1_BINARY);
    constant TX_CFG2_LANE2_STRLEN : integer := getstrlength(TX_CFG2_LANE2_BINARY);
    constant TX_CFG2_LANE3_STRLEN : integer := getstrlength(TX_CFG2_LANE3_BINARY);
    constant TX_CLK_SEL0_LANE0_STRLEN : integer := getstrlength(TX_CLK_SEL0_LANE0_BINARY);
    constant TX_CLK_SEL0_LANE1_STRLEN : integer := getstrlength(TX_CLK_SEL0_LANE1_BINARY);
    constant TX_CLK_SEL0_LANE2_STRLEN : integer := getstrlength(TX_CLK_SEL0_LANE2_BINARY);
    constant TX_CLK_SEL0_LANE3_STRLEN : integer := getstrlength(TX_CLK_SEL0_LANE3_BINARY);
    constant TX_CLK_SEL1_LANE0_STRLEN : integer := getstrlength(TX_CLK_SEL1_LANE0_BINARY);
    constant TX_CLK_SEL1_LANE1_STRLEN : integer := getstrlength(TX_CLK_SEL1_LANE1_BINARY);
    constant TX_CLK_SEL1_LANE2_STRLEN : integer := getstrlength(TX_CLK_SEL1_LANE2_BINARY);
    constant TX_CLK_SEL1_LANE3_STRLEN : integer := getstrlength(TX_CLK_SEL1_LANE3_BINARY);
    constant TX_DISABLE_LANE0_STRLEN : integer := getstrlength(TX_DISABLE_LANE0_BINARY);
    constant TX_DISABLE_LANE1_STRLEN : integer := getstrlength(TX_DISABLE_LANE1_BINARY);
    constant TX_DISABLE_LANE2_STRLEN : integer := getstrlength(TX_DISABLE_LANE2_BINARY);
    constant TX_DISABLE_LANE3_STRLEN : integer := getstrlength(TX_DISABLE_LANE3_BINARY);
    constant TX_P0P0S_CTRL_STRLEN : integer := getstrlength(TX_P0P0S_CTRL_BINARY);
    constant TX_P1P2_CTRL_STRLEN : integer := getstrlength(TX_P1P2_CTRL_BINARY);
    constant TX_PREEMPH_LANE0_STRLEN : integer := getstrlength(TX_PREEMPH_LANE0_BINARY);
    constant TX_PREEMPH_LANE1_STRLEN : integer := getstrlength(TX_PREEMPH_LANE1_BINARY);
    constant TX_PREEMPH_LANE2_STRLEN : integer := getstrlength(TX_PREEMPH_LANE2_BINARY);
    constant TX_PREEMPH_LANE3_STRLEN : integer := getstrlength(TX_PREEMPH_LANE3_BINARY);
    constant TX_PWR_RATE_OVRD_LANE0_STRLEN : integer := getstrlength(TX_PWR_RATE_OVRD_LANE0_BINARY);
    constant TX_PWR_RATE_OVRD_LANE1_STRLEN : integer := getstrlength(TX_PWR_RATE_OVRD_LANE1_BINARY);
    constant TX_PWR_RATE_OVRD_LANE2_STRLEN : integer := getstrlength(TX_PWR_RATE_OVRD_LANE2_BINARY);
    constant TX_PWR_RATE_OVRD_LANE3_STRLEN : integer := getstrlength(TX_PWR_RATE_OVRD_LANE3_BINARY);
    
    -- Convert std_logic_vector to string
    constant BER_CONST_PTRN0_STRING : string := SLV_TO_HEX(BER_CONST_PTRN0_BINARY, BER_CONST_PTRN0_STRLEN);
    constant BER_CONST_PTRN1_STRING : string := SLV_TO_HEX(BER_CONST_PTRN1_BINARY, BER_CONST_PTRN1_STRLEN);
    constant BUFFER_CONFIG_LANE0_STRING : string := SLV_TO_HEX(BUFFER_CONFIG_LANE0_BINARY, BUFFER_CONFIG_LANE0_STRLEN);
    constant BUFFER_CONFIG_LANE1_STRING : string := SLV_TO_HEX(BUFFER_CONFIG_LANE1_BINARY, BUFFER_CONFIG_LANE1_STRLEN);
    constant BUFFER_CONFIG_LANE2_STRING : string := SLV_TO_HEX(BUFFER_CONFIG_LANE2_BINARY, BUFFER_CONFIG_LANE2_STRLEN);
    constant BUFFER_CONFIG_LANE3_STRING : string := SLV_TO_HEX(BUFFER_CONFIG_LANE3_BINARY, BUFFER_CONFIG_LANE3_STRLEN);
    constant DFE_TRAIN_CTRL_LANE0_STRING : string := SLV_TO_HEX(DFE_TRAIN_CTRL_LANE0_BINARY, DFE_TRAIN_CTRL_LANE0_STRLEN);
    constant DFE_TRAIN_CTRL_LANE1_STRING : string := SLV_TO_HEX(DFE_TRAIN_CTRL_LANE1_BINARY, DFE_TRAIN_CTRL_LANE1_STRLEN);
    constant DFE_TRAIN_CTRL_LANE2_STRING : string := SLV_TO_HEX(DFE_TRAIN_CTRL_LANE2_BINARY, DFE_TRAIN_CTRL_LANE2_STRLEN);
    constant DFE_TRAIN_CTRL_LANE3_STRING : string := SLV_TO_HEX(DFE_TRAIN_CTRL_LANE3_BINARY, DFE_TRAIN_CTRL_LANE3_STRLEN);
    constant DLL_CFG0_STRING : string := SLV_TO_HEX(DLL_CFG0_BINARY, DLL_CFG0_STRLEN);
    constant DLL_CFG1_STRING : string := SLV_TO_HEX(DLL_CFG1_BINARY, DLL_CFG1_STRLEN);
    constant E10GBASEKR_LD_COEFF_UPD_LANE0_STRING : string := SLV_TO_HEX(E10GBASEKR_LD_COEFF_UPD_LANE0_BINARY, E10GBASEKR_LD_COEFF_UPD_LANE0_STRLEN);
    constant E10GBASEKR_LD_COEFF_UPD_LANE1_STRING : string := SLV_TO_HEX(E10GBASEKR_LD_COEFF_UPD_LANE1_BINARY, E10GBASEKR_LD_COEFF_UPD_LANE1_STRLEN);
    constant E10GBASEKR_LD_COEFF_UPD_LANE2_STRING : string := SLV_TO_HEX(E10GBASEKR_LD_COEFF_UPD_LANE2_BINARY, E10GBASEKR_LD_COEFF_UPD_LANE2_STRLEN);
    constant E10GBASEKR_LD_COEFF_UPD_LANE3_STRING : string := SLV_TO_HEX(E10GBASEKR_LD_COEFF_UPD_LANE3_BINARY, E10GBASEKR_LD_COEFF_UPD_LANE3_STRLEN);
    constant E10GBASEKR_LP_COEFF_UPD_LANE0_STRING : string := SLV_TO_HEX(E10GBASEKR_LP_COEFF_UPD_LANE0_BINARY, E10GBASEKR_LP_COEFF_UPD_LANE0_STRLEN);
    constant E10GBASEKR_LP_COEFF_UPD_LANE1_STRING : string := SLV_TO_HEX(E10GBASEKR_LP_COEFF_UPD_LANE1_BINARY, E10GBASEKR_LP_COEFF_UPD_LANE1_STRLEN);
    constant E10GBASEKR_LP_COEFF_UPD_LANE2_STRING : string := SLV_TO_HEX(E10GBASEKR_LP_COEFF_UPD_LANE2_BINARY, E10GBASEKR_LP_COEFF_UPD_LANE2_STRLEN);
    constant E10GBASEKR_LP_COEFF_UPD_LANE3_STRING : string := SLV_TO_HEX(E10GBASEKR_LP_COEFF_UPD_LANE3_BINARY, E10GBASEKR_LP_COEFF_UPD_LANE3_STRLEN);
    constant E10GBASEKR_PMA_CTRL_LANE0_STRING : string := SLV_TO_HEX(E10GBASEKR_PMA_CTRL_LANE0_BINARY, E10GBASEKR_PMA_CTRL_LANE0_STRLEN);
    constant E10GBASEKR_PMA_CTRL_LANE1_STRING : string := SLV_TO_HEX(E10GBASEKR_PMA_CTRL_LANE1_BINARY, E10GBASEKR_PMA_CTRL_LANE1_STRLEN);
    constant E10GBASEKR_PMA_CTRL_LANE2_STRING : string := SLV_TO_HEX(E10GBASEKR_PMA_CTRL_LANE2_BINARY, E10GBASEKR_PMA_CTRL_LANE2_STRLEN);
    constant E10GBASEKR_PMA_CTRL_LANE3_STRING : string := SLV_TO_HEX(E10GBASEKR_PMA_CTRL_LANE3_BINARY, E10GBASEKR_PMA_CTRL_LANE3_STRLEN);
    constant E10GBASEKX_CTRL_LANE0_STRING : string := SLV_TO_HEX(E10GBASEKX_CTRL_LANE0_BINARY, E10GBASEKX_CTRL_LANE0_STRLEN);
    constant E10GBASEKX_CTRL_LANE1_STRING : string := SLV_TO_HEX(E10GBASEKX_CTRL_LANE1_BINARY, E10GBASEKX_CTRL_LANE1_STRLEN);
    constant E10GBASEKX_CTRL_LANE2_STRING : string := SLV_TO_HEX(E10GBASEKX_CTRL_LANE2_BINARY, E10GBASEKX_CTRL_LANE2_STRLEN);
    constant E10GBASEKX_CTRL_LANE3_STRING : string := SLV_TO_HEX(E10GBASEKX_CTRL_LANE3_BINARY, E10GBASEKX_CTRL_LANE3_STRLEN);
    constant E10GBASER_PCS_CFG_LANE0_STRING : string := SLV_TO_HEX(E10GBASER_PCS_CFG_LANE0_BINARY, E10GBASER_PCS_CFG_LANE0_STRLEN);
    constant E10GBASER_PCS_CFG_LANE1_STRING : string := SLV_TO_HEX(E10GBASER_PCS_CFG_LANE1_BINARY, E10GBASER_PCS_CFG_LANE1_STRLEN);
    constant E10GBASER_PCS_CFG_LANE2_STRING : string := SLV_TO_HEX(E10GBASER_PCS_CFG_LANE2_BINARY, E10GBASER_PCS_CFG_LANE2_STRLEN);
    constant E10GBASER_PCS_CFG_LANE3_STRING : string := SLV_TO_HEX(E10GBASER_PCS_CFG_LANE3_BINARY, E10GBASER_PCS_CFG_LANE3_STRLEN);
    constant E10GBASER_PCS_SEEDA0_LANE0_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDA0_LANE0_BINARY, E10GBASER_PCS_SEEDA0_LANE0_STRLEN);
    constant E10GBASER_PCS_SEEDA0_LANE1_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDA0_LANE1_BINARY, E10GBASER_PCS_SEEDA0_LANE1_STRLEN);
    constant E10GBASER_PCS_SEEDA0_LANE2_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDA0_LANE2_BINARY, E10GBASER_PCS_SEEDA0_LANE2_STRLEN);
    constant E10GBASER_PCS_SEEDA0_LANE3_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDA0_LANE3_BINARY, E10GBASER_PCS_SEEDA0_LANE3_STRLEN);
    constant E10GBASER_PCS_SEEDA1_LANE0_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDA1_LANE0_BINARY, E10GBASER_PCS_SEEDA1_LANE0_STRLEN);
    constant E10GBASER_PCS_SEEDA1_LANE1_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDA1_LANE1_BINARY, E10GBASER_PCS_SEEDA1_LANE1_STRLEN);
    constant E10GBASER_PCS_SEEDA1_LANE2_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDA1_LANE2_BINARY, E10GBASER_PCS_SEEDA1_LANE2_STRLEN);
    constant E10GBASER_PCS_SEEDA1_LANE3_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDA1_LANE3_BINARY, E10GBASER_PCS_SEEDA1_LANE3_STRLEN);
    constant E10GBASER_PCS_SEEDA2_LANE0_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDA2_LANE0_BINARY, E10GBASER_PCS_SEEDA2_LANE0_STRLEN);
    constant E10GBASER_PCS_SEEDA2_LANE1_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDA2_LANE1_BINARY, E10GBASER_PCS_SEEDA2_LANE1_STRLEN);
    constant E10GBASER_PCS_SEEDA2_LANE2_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDA2_LANE2_BINARY, E10GBASER_PCS_SEEDA2_LANE2_STRLEN);
    constant E10GBASER_PCS_SEEDA2_LANE3_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDA2_LANE3_BINARY, E10GBASER_PCS_SEEDA2_LANE3_STRLEN);
    constant E10GBASER_PCS_SEEDA3_LANE0_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDA3_LANE0_BINARY, E10GBASER_PCS_SEEDA3_LANE0_STRLEN);
    constant E10GBASER_PCS_SEEDA3_LANE1_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDA3_LANE1_BINARY, E10GBASER_PCS_SEEDA3_LANE1_STRLEN);
    constant E10GBASER_PCS_SEEDA3_LANE2_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDA3_LANE2_BINARY, E10GBASER_PCS_SEEDA3_LANE2_STRLEN);
    constant E10GBASER_PCS_SEEDA3_LANE3_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDA3_LANE3_BINARY, E10GBASER_PCS_SEEDA3_LANE3_STRLEN);
    constant E10GBASER_PCS_SEEDB0_LANE0_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDB0_LANE0_BINARY, E10GBASER_PCS_SEEDB0_LANE0_STRLEN);
    constant E10GBASER_PCS_SEEDB0_LANE1_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDB0_LANE1_BINARY, E10GBASER_PCS_SEEDB0_LANE1_STRLEN);
    constant E10GBASER_PCS_SEEDB0_LANE2_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDB0_LANE2_BINARY, E10GBASER_PCS_SEEDB0_LANE2_STRLEN);
    constant E10GBASER_PCS_SEEDB0_LANE3_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDB0_LANE3_BINARY, E10GBASER_PCS_SEEDB0_LANE3_STRLEN);
    constant E10GBASER_PCS_SEEDB1_LANE0_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDB1_LANE0_BINARY, E10GBASER_PCS_SEEDB1_LANE0_STRLEN);
    constant E10GBASER_PCS_SEEDB1_LANE1_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDB1_LANE1_BINARY, E10GBASER_PCS_SEEDB1_LANE1_STRLEN);
    constant E10GBASER_PCS_SEEDB1_LANE2_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDB1_LANE2_BINARY, E10GBASER_PCS_SEEDB1_LANE2_STRLEN);
    constant E10GBASER_PCS_SEEDB1_LANE3_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDB1_LANE3_BINARY, E10GBASER_PCS_SEEDB1_LANE3_STRLEN);
    constant E10GBASER_PCS_SEEDB2_LANE0_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDB2_LANE0_BINARY, E10GBASER_PCS_SEEDB2_LANE0_STRLEN);
    constant E10GBASER_PCS_SEEDB2_LANE1_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDB2_LANE1_BINARY, E10GBASER_PCS_SEEDB2_LANE1_STRLEN);
    constant E10GBASER_PCS_SEEDB2_LANE2_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDB2_LANE2_BINARY, E10GBASER_PCS_SEEDB2_LANE2_STRLEN);
    constant E10GBASER_PCS_SEEDB2_LANE3_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDB2_LANE3_BINARY, E10GBASER_PCS_SEEDB2_LANE3_STRLEN);
    constant E10GBASER_PCS_SEEDB3_LANE0_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDB3_LANE0_BINARY, E10GBASER_PCS_SEEDB3_LANE0_STRLEN);
    constant E10GBASER_PCS_SEEDB3_LANE1_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDB3_LANE1_BINARY, E10GBASER_PCS_SEEDB3_LANE1_STRLEN);
    constant E10GBASER_PCS_SEEDB3_LANE2_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDB3_LANE2_BINARY, E10GBASER_PCS_SEEDB3_LANE2_STRLEN);
    constant E10GBASER_PCS_SEEDB3_LANE3_STRING : string := SLV_TO_HEX(E10GBASER_PCS_SEEDB3_LANE3_BINARY, E10GBASER_PCS_SEEDB3_LANE3_STRLEN);
    constant E10GBASER_PCS_TEST_CTRL_LANE0_STRING : string := SLV_TO_HEX(E10GBASER_PCS_TEST_CTRL_LANE0_BINARY, E10GBASER_PCS_TEST_CTRL_LANE0_STRLEN);
    constant E10GBASER_PCS_TEST_CTRL_LANE1_STRING : string := SLV_TO_HEX(E10GBASER_PCS_TEST_CTRL_LANE1_BINARY, E10GBASER_PCS_TEST_CTRL_LANE1_STRLEN);
    constant E10GBASER_PCS_TEST_CTRL_LANE2_STRING : string := SLV_TO_HEX(E10GBASER_PCS_TEST_CTRL_LANE2_BINARY, E10GBASER_PCS_TEST_CTRL_LANE2_STRLEN);
    constant E10GBASER_PCS_TEST_CTRL_LANE3_STRING : string := SLV_TO_HEX(E10GBASER_PCS_TEST_CTRL_LANE3_BINARY, E10GBASER_PCS_TEST_CTRL_LANE3_STRLEN);
    constant E10GBASEX_PCS_TSTCTRL_LANE0_STRING : string := SLV_TO_HEX(E10GBASEX_PCS_TSTCTRL_LANE0_BINARY, E10GBASEX_PCS_TSTCTRL_LANE0_STRLEN);
    constant E10GBASEX_PCS_TSTCTRL_LANE1_STRING : string := SLV_TO_HEX(E10GBASEX_PCS_TSTCTRL_LANE1_BINARY, E10GBASEX_PCS_TSTCTRL_LANE1_STRLEN);
    constant E10GBASEX_PCS_TSTCTRL_LANE2_STRING : string := SLV_TO_HEX(E10GBASEX_PCS_TSTCTRL_LANE2_BINARY, E10GBASEX_PCS_TSTCTRL_LANE2_STRLEN);
    constant E10GBASEX_PCS_TSTCTRL_LANE3_STRING : string := SLV_TO_HEX(E10GBASEX_PCS_TSTCTRL_LANE3_BINARY, E10GBASEX_PCS_TSTCTRL_LANE3_STRLEN);
    constant GLBL0_NOISE_CTRL_STRING : string := SLV_TO_HEX(GLBL0_NOISE_CTRL_BINARY, GLBL0_NOISE_CTRL_STRLEN);
    constant GLBL_AMON_SEL_STRING : string := SLV_TO_HEX(GLBL_AMON_SEL_BINARY, GLBL_AMON_SEL_STRLEN);
    constant GLBL_DMON_SEL_STRING : string := SLV_TO_HEX(GLBL_DMON_SEL_BINARY, GLBL_DMON_SEL_STRLEN);
    constant GLBL_PWR_CTRL_STRING : string := SLV_TO_HEX(GLBL_PWR_CTRL_BINARY, GLBL_PWR_CTRL_STRLEN);
    constant GTH_CFG_PWRUP_LANE0_STRING : string := SUL_TO_STR(GTH_CFG_PWRUP_LANE0_BINARY);
    constant GTH_CFG_PWRUP_LANE1_STRING : string := SUL_TO_STR(GTH_CFG_PWRUP_LANE1_BINARY);
    constant GTH_CFG_PWRUP_LANE2_STRING : string := SUL_TO_STR(GTH_CFG_PWRUP_LANE2_BINARY);
    constant GTH_CFG_PWRUP_LANE3_STRING : string := SUL_TO_STR(GTH_CFG_PWRUP_LANE3_BINARY);
    constant LANE_AMON_SEL_STRING : string := SLV_TO_HEX(LANE_AMON_SEL_BINARY, LANE_AMON_SEL_STRLEN);
    constant LANE_DMON_SEL_STRING : string := SLV_TO_HEX(LANE_DMON_SEL_BINARY, LANE_DMON_SEL_STRLEN);
    constant LANE_LNK_CFGOVRD_STRING : string := SLV_TO_HEX(LANE_LNK_CFGOVRD_BINARY, LANE_LNK_CFGOVRD_STRLEN);
    constant LANE_PWR_CTRL_LANE0_STRING : string := SLV_TO_HEX(LANE_PWR_CTRL_LANE0_BINARY, LANE_PWR_CTRL_LANE0_STRLEN);
    constant LANE_PWR_CTRL_LANE1_STRING : string := SLV_TO_HEX(LANE_PWR_CTRL_LANE1_BINARY, LANE_PWR_CTRL_LANE1_STRLEN);
    constant LANE_PWR_CTRL_LANE2_STRING : string := SLV_TO_HEX(LANE_PWR_CTRL_LANE2_BINARY, LANE_PWR_CTRL_LANE2_STRLEN);
    constant LANE_PWR_CTRL_LANE3_STRING : string := SLV_TO_HEX(LANE_PWR_CTRL_LANE3_BINARY, LANE_PWR_CTRL_LANE3_STRLEN);
    constant LNK_TRN_CFG_LANE0_STRING : string := SLV_TO_HEX(LNK_TRN_CFG_LANE0_BINARY, LNK_TRN_CFG_LANE0_STRLEN);
    constant LNK_TRN_CFG_LANE1_STRING : string := SLV_TO_HEX(LNK_TRN_CFG_LANE1_BINARY, LNK_TRN_CFG_LANE1_STRLEN);
    constant LNK_TRN_CFG_LANE2_STRING : string := SLV_TO_HEX(LNK_TRN_CFG_LANE2_BINARY, LNK_TRN_CFG_LANE2_STRLEN);
    constant LNK_TRN_CFG_LANE3_STRING : string := SLV_TO_HEX(LNK_TRN_CFG_LANE3_BINARY, LNK_TRN_CFG_LANE3_STRLEN);
    constant LNK_TRN_COEFF_REQ_LANE0_STRING : string := SLV_TO_HEX(LNK_TRN_COEFF_REQ_LANE0_BINARY, LNK_TRN_COEFF_REQ_LANE0_STRLEN);
    constant LNK_TRN_COEFF_REQ_LANE1_STRING : string := SLV_TO_HEX(LNK_TRN_COEFF_REQ_LANE1_BINARY, LNK_TRN_COEFF_REQ_LANE1_STRLEN);
    constant LNK_TRN_COEFF_REQ_LANE2_STRING : string := SLV_TO_HEX(LNK_TRN_COEFF_REQ_LANE2_BINARY, LNK_TRN_COEFF_REQ_LANE2_STRLEN);
    constant LNK_TRN_COEFF_REQ_LANE3_STRING : string := SLV_TO_HEX(LNK_TRN_COEFF_REQ_LANE3_BINARY, LNK_TRN_COEFF_REQ_LANE3_STRLEN);
    constant MISC_CFG_STRING : string := SLV_TO_HEX(MISC_CFG_BINARY, MISC_CFG_STRLEN);
    constant MODE_CFG1_STRING : string := SLV_TO_HEX(MODE_CFG1_BINARY, MODE_CFG1_STRLEN);
    constant MODE_CFG2_STRING : string := SLV_TO_HEX(MODE_CFG2_BINARY, MODE_CFG2_STRLEN);
    constant MODE_CFG3_STRING : string := SLV_TO_HEX(MODE_CFG3_BINARY, MODE_CFG3_STRLEN);
    constant MODE_CFG4_STRING : string := SLV_TO_HEX(MODE_CFG4_BINARY, MODE_CFG4_STRLEN);
    constant MODE_CFG5_STRING : string := SLV_TO_HEX(MODE_CFG5_BINARY, MODE_CFG5_STRLEN);
    constant MODE_CFG6_STRING : string := SLV_TO_HEX(MODE_CFG6_BINARY, MODE_CFG6_STRLEN);
    constant MODE_CFG7_STRING : string := SLV_TO_HEX(MODE_CFG7_BINARY, MODE_CFG7_STRLEN);
    constant PCS_ABILITY_LANE0_STRING : string := SLV_TO_HEX(PCS_ABILITY_LANE0_BINARY, PCS_ABILITY_LANE0_STRLEN);
    constant PCS_ABILITY_LANE1_STRING : string := SLV_TO_HEX(PCS_ABILITY_LANE1_BINARY, PCS_ABILITY_LANE1_STRLEN);
    constant PCS_ABILITY_LANE2_STRING : string := SLV_TO_HEX(PCS_ABILITY_LANE2_BINARY, PCS_ABILITY_LANE2_STRLEN);
    constant PCS_ABILITY_LANE3_STRING : string := SLV_TO_HEX(PCS_ABILITY_LANE3_BINARY, PCS_ABILITY_LANE3_STRLEN);
    constant PCS_CTRL1_LANE0_STRING : string := SLV_TO_HEX(PCS_CTRL1_LANE0_BINARY, PCS_CTRL1_LANE0_STRLEN);
    constant PCS_CTRL1_LANE1_STRING : string := SLV_TO_HEX(PCS_CTRL1_LANE1_BINARY, PCS_CTRL1_LANE1_STRLEN);
    constant PCS_CTRL1_LANE2_STRING : string := SLV_TO_HEX(PCS_CTRL1_LANE2_BINARY, PCS_CTRL1_LANE2_STRLEN);
    constant PCS_CTRL1_LANE3_STRING : string := SLV_TO_HEX(PCS_CTRL1_LANE3_BINARY, PCS_CTRL1_LANE3_STRLEN);
    constant PCS_CTRL2_LANE0_STRING : string := SLV_TO_HEX(PCS_CTRL2_LANE0_BINARY, PCS_CTRL2_LANE0_STRLEN);
    constant PCS_CTRL2_LANE1_STRING : string := SLV_TO_HEX(PCS_CTRL2_LANE1_BINARY, PCS_CTRL2_LANE1_STRLEN);
    constant PCS_CTRL2_LANE2_STRING : string := SLV_TO_HEX(PCS_CTRL2_LANE2_BINARY, PCS_CTRL2_LANE2_STRLEN);
    constant PCS_CTRL2_LANE3_STRING : string := SLV_TO_HEX(PCS_CTRL2_LANE3_BINARY, PCS_CTRL2_LANE3_STRLEN);
    constant PCS_MISC_CFG_0_LANE0_STRING : string := SLV_TO_HEX(PCS_MISC_CFG_0_LANE0_BINARY, PCS_MISC_CFG_0_LANE0_STRLEN);
    constant PCS_MISC_CFG_0_LANE1_STRING : string := SLV_TO_HEX(PCS_MISC_CFG_0_LANE1_BINARY, PCS_MISC_CFG_0_LANE1_STRLEN);
    constant PCS_MISC_CFG_0_LANE2_STRING : string := SLV_TO_HEX(PCS_MISC_CFG_0_LANE2_BINARY, PCS_MISC_CFG_0_LANE2_STRLEN);
    constant PCS_MISC_CFG_0_LANE3_STRING : string := SLV_TO_HEX(PCS_MISC_CFG_0_LANE3_BINARY, PCS_MISC_CFG_0_LANE3_STRLEN);
    constant PCS_MISC_CFG_1_LANE0_STRING : string := SLV_TO_HEX(PCS_MISC_CFG_1_LANE0_BINARY, PCS_MISC_CFG_1_LANE0_STRLEN);
    constant PCS_MISC_CFG_1_LANE1_STRING : string := SLV_TO_HEX(PCS_MISC_CFG_1_LANE1_BINARY, PCS_MISC_CFG_1_LANE1_STRLEN);
    constant PCS_MISC_CFG_1_LANE2_STRING : string := SLV_TO_HEX(PCS_MISC_CFG_1_LANE2_BINARY, PCS_MISC_CFG_1_LANE2_STRLEN);
    constant PCS_MISC_CFG_1_LANE3_STRING : string := SLV_TO_HEX(PCS_MISC_CFG_1_LANE3_BINARY, PCS_MISC_CFG_1_LANE3_STRLEN);
    constant PCS_MODE_LANE0_STRING : string := SLV_TO_HEX(PCS_MODE_LANE0_BINARY, PCS_MODE_LANE0_STRLEN);
    constant PCS_MODE_LANE1_STRING : string := SLV_TO_HEX(PCS_MODE_LANE1_BINARY, PCS_MODE_LANE1_STRLEN);
    constant PCS_MODE_LANE2_STRING : string := SLV_TO_HEX(PCS_MODE_LANE2_BINARY, PCS_MODE_LANE2_STRLEN);
    constant PCS_MODE_LANE3_STRING : string := SLV_TO_HEX(PCS_MODE_LANE3_BINARY, PCS_MODE_LANE3_STRLEN);
    constant PCS_RESET_1_LANE0_STRING : string := SLV_TO_HEX(PCS_RESET_1_LANE0_BINARY, PCS_RESET_1_LANE0_STRLEN);
    constant PCS_RESET_1_LANE1_STRING : string := SLV_TO_HEX(PCS_RESET_1_LANE1_BINARY, PCS_RESET_1_LANE1_STRLEN);
    constant PCS_RESET_1_LANE2_STRING : string := SLV_TO_HEX(PCS_RESET_1_LANE2_BINARY, PCS_RESET_1_LANE2_STRLEN);
    constant PCS_RESET_1_LANE3_STRING : string := SLV_TO_HEX(PCS_RESET_1_LANE3_BINARY, PCS_RESET_1_LANE3_STRLEN);
    constant PCS_RESET_LANE0_STRING : string := SLV_TO_HEX(PCS_RESET_LANE0_BINARY, PCS_RESET_LANE0_STRLEN);
    constant PCS_RESET_LANE1_STRING : string := SLV_TO_HEX(PCS_RESET_LANE1_BINARY, PCS_RESET_LANE1_STRLEN);
    constant PCS_RESET_LANE2_STRING : string := SLV_TO_HEX(PCS_RESET_LANE2_BINARY, PCS_RESET_LANE2_STRLEN);
    constant PCS_RESET_LANE3_STRING : string := SLV_TO_HEX(PCS_RESET_LANE3_BINARY, PCS_RESET_LANE3_STRLEN);
    constant PCS_TYPE_LANE0_STRING : string := SLV_TO_HEX(PCS_TYPE_LANE0_BINARY, PCS_TYPE_LANE0_STRLEN);
    constant PCS_TYPE_LANE1_STRING : string := SLV_TO_HEX(PCS_TYPE_LANE1_BINARY, PCS_TYPE_LANE1_STRLEN);
    constant PCS_TYPE_LANE2_STRING : string := SLV_TO_HEX(PCS_TYPE_LANE2_BINARY, PCS_TYPE_LANE2_STRLEN);
    constant PCS_TYPE_LANE3_STRING : string := SLV_TO_HEX(PCS_TYPE_LANE3_BINARY, PCS_TYPE_LANE3_STRLEN);
    constant PLL_CFG0_STRING : string := SLV_TO_HEX(PLL_CFG0_BINARY, PLL_CFG0_STRLEN);
    constant PLL_CFG1_STRING : string := SLV_TO_HEX(PLL_CFG1_BINARY, PLL_CFG1_STRLEN);
    constant PLL_CFG2_STRING : string := SLV_TO_HEX(PLL_CFG2_BINARY, PLL_CFG2_STRLEN);
    constant PMA_CTRL1_LANE0_STRING : string := SLV_TO_HEX(PMA_CTRL1_LANE0_BINARY, PMA_CTRL1_LANE0_STRLEN);
    constant PMA_CTRL1_LANE1_STRING : string := SLV_TO_HEX(PMA_CTRL1_LANE1_BINARY, PMA_CTRL1_LANE1_STRLEN);
    constant PMA_CTRL1_LANE2_STRING : string := SLV_TO_HEX(PMA_CTRL1_LANE2_BINARY, PMA_CTRL1_LANE2_STRLEN);
    constant PMA_CTRL1_LANE3_STRING : string := SLV_TO_HEX(PMA_CTRL1_LANE3_BINARY, PMA_CTRL1_LANE3_STRLEN);
    constant PMA_CTRL2_LANE0_STRING : string := SLV_TO_HEX(PMA_CTRL2_LANE0_BINARY, PMA_CTRL2_LANE0_STRLEN);
    constant PMA_CTRL2_LANE1_STRING : string := SLV_TO_HEX(PMA_CTRL2_LANE1_BINARY, PMA_CTRL2_LANE1_STRLEN);
    constant PMA_CTRL2_LANE2_STRING : string := SLV_TO_HEX(PMA_CTRL2_LANE2_BINARY, PMA_CTRL2_LANE2_STRLEN);
    constant PMA_CTRL2_LANE3_STRING : string := SLV_TO_HEX(PMA_CTRL2_LANE3_BINARY, PMA_CTRL2_LANE3_STRLEN);
    constant PMA_LPBK_CTRL_LANE0_STRING : string := SLV_TO_HEX(PMA_LPBK_CTRL_LANE0_BINARY, PMA_LPBK_CTRL_LANE0_STRLEN);
    constant PMA_LPBK_CTRL_LANE1_STRING : string := SLV_TO_HEX(PMA_LPBK_CTRL_LANE1_BINARY, PMA_LPBK_CTRL_LANE1_STRLEN);
    constant PMA_LPBK_CTRL_LANE2_STRING : string := SLV_TO_HEX(PMA_LPBK_CTRL_LANE2_BINARY, PMA_LPBK_CTRL_LANE2_STRLEN);
    constant PMA_LPBK_CTRL_LANE3_STRING : string := SLV_TO_HEX(PMA_LPBK_CTRL_LANE3_BINARY, PMA_LPBK_CTRL_LANE3_STRLEN);
    constant PRBS_BER_CFG0_LANE0_STRING : string := SLV_TO_HEX(PRBS_BER_CFG0_LANE0_BINARY, PRBS_BER_CFG0_LANE0_STRLEN);
    constant PRBS_BER_CFG0_LANE1_STRING : string := SLV_TO_HEX(PRBS_BER_CFG0_LANE1_BINARY, PRBS_BER_CFG0_LANE1_STRLEN);
    constant PRBS_BER_CFG0_LANE2_STRING : string := SLV_TO_HEX(PRBS_BER_CFG0_LANE2_BINARY, PRBS_BER_CFG0_LANE2_STRLEN);
    constant PRBS_BER_CFG0_LANE3_STRING : string := SLV_TO_HEX(PRBS_BER_CFG0_LANE3_BINARY, PRBS_BER_CFG0_LANE3_STRLEN);
    constant PRBS_BER_CFG1_LANE0_STRING : string := SLV_TO_HEX(PRBS_BER_CFG1_LANE0_BINARY, PRBS_BER_CFG1_LANE0_STRLEN);
    constant PRBS_BER_CFG1_LANE1_STRING : string := SLV_TO_HEX(PRBS_BER_CFG1_LANE1_BINARY, PRBS_BER_CFG1_LANE1_STRLEN);
    constant PRBS_BER_CFG1_LANE2_STRING : string := SLV_TO_HEX(PRBS_BER_CFG1_LANE2_BINARY, PRBS_BER_CFG1_LANE2_STRLEN);
    constant PRBS_BER_CFG1_LANE3_STRING : string := SLV_TO_HEX(PRBS_BER_CFG1_LANE3_BINARY, PRBS_BER_CFG1_LANE3_STRLEN);
    constant PRBS_CFG_LANE0_STRING : string := SLV_TO_HEX(PRBS_CFG_LANE0_BINARY, PRBS_CFG_LANE0_STRLEN);
    constant PRBS_CFG_LANE1_STRING : string := SLV_TO_HEX(PRBS_CFG_LANE1_BINARY, PRBS_CFG_LANE1_STRLEN);
    constant PRBS_CFG_LANE2_STRING : string := SLV_TO_HEX(PRBS_CFG_LANE2_BINARY, PRBS_CFG_LANE2_STRLEN);
    constant PRBS_CFG_LANE3_STRING : string := SLV_TO_HEX(PRBS_CFG_LANE3_BINARY, PRBS_CFG_LANE3_STRLEN);
    constant PTRN_CFG0_LSB_STRING : string := SLV_TO_HEX(PTRN_CFG0_LSB_BINARY, PTRN_CFG0_LSB_STRLEN);
    constant PTRN_CFG0_MSB_STRING : string := SLV_TO_HEX(PTRN_CFG0_MSB_BINARY, PTRN_CFG0_MSB_STRLEN);
    constant PTRN_LEN_CFG_STRING : string := SLV_TO_HEX(PTRN_LEN_CFG_BINARY, PTRN_LEN_CFG_STRLEN);
    constant PWRUP_DLY_STRING : string := SLV_TO_HEX(PWRUP_DLY_BINARY, PWRUP_DLY_STRLEN);
    constant RX_AEQ_VAL0_LANE0_STRING : string := SLV_TO_HEX(RX_AEQ_VAL0_LANE0_BINARY, RX_AEQ_VAL0_LANE0_STRLEN);
    constant RX_AEQ_VAL0_LANE1_STRING : string := SLV_TO_HEX(RX_AEQ_VAL0_LANE1_BINARY, RX_AEQ_VAL0_LANE1_STRLEN);
    constant RX_AEQ_VAL0_LANE2_STRING : string := SLV_TO_HEX(RX_AEQ_VAL0_LANE2_BINARY, RX_AEQ_VAL0_LANE2_STRLEN);
    constant RX_AEQ_VAL0_LANE3_STRING : string := SLV_TO_HEX(RX_AEQ_VAL0_LANE3_BINARY, RX_AEQ_VAL0_LANE3_STRLEN);
    constant RX_AEQ_VAL1_LANE0_STRING : string := SLV_TO_HEX(RX_AEQ_VAL1_LANE0_BINARY, RX_AEQ_VAL1_LANE0_STRLEN);
    constant RX_AEQ_VAL1_LANE1_STRING : string := SLV_TO_HEX(RX_AEQ_VAL1_LANE1_BINARY, RX_AEQ_VAL1_LANE1_STRLEN);
    constant RX_AEQ_VAL1_LANE2_STRING : string := SLV_TO_HEX(RX_AEQ_VAL1_LANE2_BINARY, RX_AEQ_VAL1_LANE2_STRLEN);
    constant RX_AEQ_VAL1_LANE3_STRING : string := SLV_TO_HEX(RX_AEQ_VAL1_LANE3_BINARY, RX_AEQ_VAL1_LANE3_STRLEN);
    constant RX_AGC_CTRL_LANE0_STRING : string := SLV_TO_HEX(RX_AGC_CTRL_LANE0_BINARY, RX_AGC_CTRL_LANE0_STRLEN);
    constant RX_AGC_CTRL_LANE1_STRING : string := SLV_TO_HEX(RX_AGC_CTRL_LANE1_BINARY, RX_AGC_CTRL_LANE1_STRLEN);
    constant RX_AGC_CTRL_LANE2_STRING : string := SLV_TO_HEX(RX_AGC_CTRL_LANE2_BINARY, RX_AGC_CTRL_LANE2_STRLEN);
    constant RX_AGC_CTRL_LANE3_STRING : string := SLV_TO_HEX(RX_AGC_CTRL_LANE3_BINARY, RX_AGC_CTRL_LANE3_STRLEN);
    constant RX_CDR_CTRL0_LANE0_STRING : string := SLV_TO_HEX(RX_CDR_CTRL0_LANE0_BINARY, RX_CDR_CTRL0_LANE0_STRLEN);
    constant RX_CDR_CTRL0_LANE1_STRING : string := SLV_TO_HEX(RX_CDR_CTRL0_LANE1_BINARY, RX_CDR_CTRL0_LANE1_STRLEN);
    constant RX_CDR_CTRL0_LANE2_STRING : string := SLV_TO_HEX(RX_CDR_CTRL0_LANE2_BINARY, RX_CDR_CTRL0_LANE2_STRLEN);
    constant RX_CDR_CTRL0_LANE3_STRING : string := SLV_TO_HEX(RX_CDR_CTRL0_LANE3_BINARY, RX_CDR_CTRL0_LANE3_STRLEN);
    constant RX_CDR_CTRL1_LANE0_STRING : string := SLV_TO_HEX(RX_CDR_CTRL1_LANE0_BINARY, RX_CDR_CTRL1_LANE0_STRLEN);
    constant RX_CDR_CTRL1_LANE1_STRING : string := SLV_TO_HEX(RX_CDR_CTRL1_LANE1_BINARY, RX_CDR_CTRL1_LANE1_STRLEN);
    constant RX_CDR_CTRL1_LANE2_STRING : string := SLV_TO_HEX(RX_CDR_CTRL1_LANE2_BINARY, RX_CDR_CTRL1_LANE2_STRLEN);
    constant RX_CDR_CTRL1_LANE3_STRING : string := SLV_TO_HEX(RX_CDR_CTRL1_LANE3_BINARY, RX_CDR_CTRL1_LANE3_STRLEN);
    constant RX_CDR_CTRL2_LANE0_STRING : string := SLV_TO_HEX(RX_CDR_CTRL2_LANE0_BINARY, RX_CDR_CTRL2_LANE0_STRLEN);
    constant RX_CDR_CTRL2_LANE1_STRING : string := SLV_TO_HEX(RX_CDR_CTRL2_LANE1_BINARY, RX_CDR_CTRL2_LANE1_STRLEN);
    constant RX_CDR_CTRL2_LANE2_STRING : string := SLV_TO_HEX(RX_CDR_CTRL2_LANE2_BINARY, RX_CDR_CTRL2_LANE2_STRLEN);
    constant RX_CDR_CTRL2_LANE3_STRING : string := SLV_TO_HEX(RX_CDR_CTRL2_LANE3_BINARY, RX_CDR_CTRL2_LANE3_STRLEN);
    constant RX_CFG0_LANE0_STRING : string := SLV_TO_HEX(RX_CFG0_LANE0_BINARY, RX_CFG0_LANE0_STRLEN);
    constant RX_CFG0_LANE1_STRING : string := SLV_TO_HEX(RX_CFG0_LANE1_BINARY, RX_CFG0_LANE1_STRLEN);
    constant RX_CFG0_LANE2_STRING : string := SLV_TO_HEX(RX_CFG0_LANE2_BINARY, RX_CFG0_LANE2_STRLEN);
    constant RX_CFG0_LANE3_STRING : string := SLV_TO_HEX(RX_CFG0_LANE3_BINARY, RX_CFG0_LANE3_STRLEN);
    constant RX_CFG1_LANE0_STRING : string := SLV_TO_HEX(RX_CFG1_LANE0_BINARY, RX_CFG1_LANE0_STRLEN);
    constant RX_CFG1_LANE1_STRING : string := SLV_TO_HEX(RX_CFG1_LANE1_BINARY, RX_CFG1_LANE1_STRLEN);
    constant RX_CFG1_LANE2_STRING : string := SLV_TO_HEX(RX_CFG1_LANE2_BINARY, RX_CFG1_LANE2_STRLEN);
    constant RX_CFG1_LANE3_STRING : string := SLV_TO_HEX(RX_CFG1_LANE3_BINARY, RX_CFG1_LANE3_STRLEN);
    constant RX_CFG2_LANE0_STRING : string := SLV_TO_HEX(RX_CFG2_LANE0_BINARY, RX_CFG2_LANE0_STRLEN);
    constant RX_CFG2_LANE1_STRING : string := SLV_TO_HEX(RX_CFG2_LANE1_BINARY, RX_CFG2_LANE1_STRLEN);
    constant RX_CFG2_LANE2_STRING : string := SLV_TO_HEX(RX_CFG2_LANE2_BINARY, RX_CFG2_LANE2_STRLEN);
    constant RX_CFG2_LANE3_STRING : string := SLV_TO_HEX(RX_CFG2_LANE3_BINARY, RX_CFG2_LANE3_STRLEN);
    constant RX_CTLE_CTRL_LANE0_STRING : string := SLV_TO_HEX(RX_CTLE_CTRL_LANE0_BINARY, RX_CTLE_CTRL_LANE0_STRLEN);
    constant RX_CTLE_CTRL_LANE1_STRING : string := SLV_TO_HEX(RX_CTLE_CTRL_LANE1_BINARY, RX_CTLE_CTRL_LANE1_STRLEN);
    constant RX_CTLE_CTRL_LANE2_STRING : string := SLV_TO_HEX(RX_CTLE_CTRL_LANE2_BINARY, RX_CTLE_CTRL_LANE2_STRLEN);
    constant RX_CTLE_CTRL_LANE3_STRING : string := SLV_TO_HEX(RX_CTLE_CTRL_LANE3_BINARY, RX_CTLE_CTRL_LANE3_STRLEN);
    constant RX_CTRL_OVRD_LANE0_STRING : string := SLV_TO_HEX(RX_CTRL_OVRD_LANE0_BINARY, RX_CTRL_OVRD_LANE0_STRLEN);
    constant RX_CTRL_OVRD_LANE1_STRING : string := SLV_TO_HEX(RX_CTRL_OVRD_LANE1_BINARY, RX_CTRL_OVRD_LANE1_STRLEN);
    constant RX_CTRL_OVRD_LANE2_STRING : string := SLV_TO_HEX(RX_CTRL_OVRD_LANE2_BINARY, RX_CTRL_OVRD_LANE2_STRLEN);
    constant RX_CTRL_OVRD_LANE3_STRING : string := SLV_TO_HEX(RX_CTRL_OVRD_LANE3_BINARY, RX_CTRL_OVRD_LANE3_STRLEN);
    constant RX_LOOP_CTRL_LANE0_STRING : string := SLV_TO_HEX(RX_LOOP_CTRL_LANE0_BINARY, RX_LOOP_CTRL_LANE0_STRLEN);
    constant RX_LOOP_CTRL_LANE1_STRING : string := SLV_TO_HEX(RX_LOOP_CTRL_LANE1_BINARY, RX_LOOP_CTRL_LANE1_STRLEN);
    constant RX_LOOP_CTRL_LANE2_STRING : string := SLV_TO_HEX(RX_LOOP_CTRL_LANE2_BINARY, RX_LOOP_CTRL_LANE2_STRLEN);
    constant RX_LOOP_CTRL_LANE3_STRING : string := SLV_TO_HEX(RX_LOOP_CTRL_LANE3_BINARY, RX_LOOP_CTRL_LANE3_STRLEN);
    constant RX_MVAL0_LANE0_STRING : string := SLV_TO_HEX(RX_MVAL0_LANE0_BINARY, RX_MVAL0_LANE0_STRLEN);
    constant RX_MVAL0_LANE1_STRING : string := SLV_TO_HEX(RX_MVAL0_LANE1_BINARY, RX_MVAL0_LANE1_STRLEN);
    constant RX_MVAL0_LANE2_STRING : string := SLV_TO_HEX(RX_MVAL0_LANE2_BINARY, RX_MVAL0_LANE2_STRLEN);
    constant RX_MVAL0_LANE3_STRING : string := SLV_TO_HEX(RX_MVAL0_LANE3_BINARY, RX_MVAL0_LANE3_STRLEN);
    constant RX_MVAL1_LANE0_STRING : string := SLV_TO_HEX(RX_MVAL1_LANE0_BINARY, RX_MVAL1_LANE0_STRLEN);
    constant RX_MVAL1_LANE1_STRING : string := SLV_TO_HEX(RX_MVAL1_LANE1_BINARY, RX_MVAL1_LANE1_STRLEN);
    constant RX_MVAL1_LANE2_STRING : string := SLV_TO_HEX(RX_MVAL1_LANE2_BINARY, RX_MVAL1_LANE2_STRLEN);
    constant RX_MVAL1_LANE3_STRING : string := SLV_TO_HEX(RX_MVAL1_LANE3_BINARY, RX_MVAL1_LANE3_STRLEN);
    constant RX_P0S_CTRL_STRING : string := SLV_TO_HEX(RX_P0S_CTRL_BINARY, RX_P0S_CTRL_STRLEN);
    constant RX_P0_CTRL_STRING : string := SLV_TO_HEX(RX_P0_CTRL_BINARY, RX_P0_CTRL_STRLEN);
    constant RX_P1_CTRL_STRING : string := SLV_TO_HEX(RX_P1_CTRL_BINARY, RX_P1_CTRL_STRLEN);
    constant RX_P2_CTRL_STRING : string := SLV_TO_HEX(RX_P2_CTRL_BINARY, RX_P2_CTRL_STRLEN);
    constant RX_PI_CTRL0_STRING : string := SLV_TO_HEX(RX_PI_CTRL0_BINARY, RX_PI_CTRL0_STRLEN);
    constant RX_PI_CTRL1_STRING : string := SLV_TO_HEX(RX_PI_CTRL1_BINARY, RX_PI_CTRL1_STRLEN);
    constant SLICE_CFG_STRING : string := SLV_TO_HEX(SLICE_CFG_BINARY, SLICE_CFG_STRLEN);
    constant SLICE_NOISE_CTRL_0_LANE01_STRING : string := SLV_TO_HEX(SLICE_NOISE_CTRL_0_LANE01_BINARY, SLICE_NOISE_CTRL_0_LANE01_STRLEN);
    constant SLICE_NOISE_CTRL_0_LANE23_STRING : string := SLV_TO_HEX(SLICE_NOISE_CTRL_0_LANE23_BINARY, SLICE_NOISE_CTRL_0_LANE23_STRLEN);
    constant SLICE_NOISE_CTRL_1_LANE01_STRING : string := SLV_TO_HEX(SLICE_NOISE_CTRL_1_LANE01_BINARY, SLICE_NOISE_CTRL_1_LANE01_STRLEN);
    constant SLICE_NOISE_CTRL_1_LANE23_STRING : string := SLV_TO_HEX(SLICE_NOISE_CTRL_1_LANE23_BINARY, SLICE_NOISE_CTRL_1_LANE23_STRLEN);
    constant SLICE_NOISE_CTRL_2_LANE01_STRING : string := SLV_TO_HEX(SLICE_NOISE_CTRL_2_LANE01_BINARY, SLICE_NOISE_CTRL_2_LANE01_STRLEN);
    constant SLICE_NOISE_CTRL_2_LANE23_STRING : string := SLV_TO_HEX(SLICE_NOISE_CTRL_2_LANE23_BINARY, SLICE_NOISE_CTRL_2_LANE23_STRLEN);
    constant SLICE_TX_RESET_LANE01_STRING : string := SLV_TO_HEX(SLICE_TX_RESET_LANE01_BINARY, SLICE_TX_RESET_LANE01_STRLEN);
    constant SLICE_TX_RESET_LANE23_STRING : string := SLV_TO_HEX(SLICE_TX_RESET_LANE23_BINARY, SLICE_TX_RESET_LANE23_STRLEN);
    constant TERM_CTRL_LANE0_STRING : string := SLV_TO_HEX(TERM_CTRL_LANE0_BINARY, TERM_CTRL_LANE0_STRLEN);
    constant TERM_CTRL_LANE1_STRING : string := SLV_TO_HEX(TERM_CTRL_LANE1_BINARY, TERM_CTRL_LANE1_STRLEN);
    constant TERM_CTRL_LANE2_STRING : string := SLV_TO_HEX(TERM_CTRL_LANE2_BINARY, TERM_CTRL_LANE2_STRLEN);
    constant TERM_CTRL_LANE3_STRING : string := SLV_TO_HEX(TERM_CTRL_LANE3_BINARY, TERM_CTRL_LANE3_STRLEN);
    constant TX_CFG0_LANE0_STRING : string := SLV_TO_HEX(TX_CFG0_LANE0_BINARY, TX_CFG0_LANE0_STRLEN);
    constant TX_CFG0_LANE1_STRING : string := SLV_TO_HEX(TX_CFG0_LANE1_BINARY, TX_CFG0_LANE1_STRLEN);
    constant TX_CFG0_LANE2_STRING : string := SLV_TO_HEX(TX_CFG0_LANE2_BINARY, TX_CFG0_LANE2_STRLEN);
    constant TX_CFG0_LANE3_STRING : string := SLV_TO_HEX(TX_CFG0_LANE3_BINARY, TX_CFG0_LANE3_STRLEN);
    constant TX_CFG1_LANE0_STRING : string := SLV_TO_HEX(TX_CFG1_LANE0_BINARY, TX_CFG1_LANE0_STRLEN);
    constant TX_CFG1_LANE1_STRING : string := SLV_TO_HEX(TX_CFG1_LANE1_BINARY, TX_CFG1_LANE1_STRLEN);
    constant TX_CFG1_LANE2_STRING : string := SLV_TO_HEX(TX_CFG1_LANE2_BINARY, TX_CFG1_LANE2_STRLEN);
    constant TX_CFG1_LANE3_STRING : string := SLV_TO_HEX(TX_CFG1_LANE3_BINARY, TX_CFG1_LANE3_STRLEN);
    constant TX_CFG2_LANE0_STRING : string := SLV_TO_HEX(TX_CFG2_LANE0_BINARY, TX_CFG2_LANE0_STRLEN);
    constant TX_CFG2_LANE1_STRING : string := SLV_TO_HEX(TX_CFG2_LANE1_BINARY, TX_CFG2_LANE1_STRLEN);
    constant TX_CFG2_LANE2_STRING : string := SLV_TO_HEX(TX_CFG2_LANE2_BINARY, TX_CFG2_LANE2_STRLEN);
    constant TX_CFG2_LANE3_STRING : string := SLV_TO_HEX(TX_CFG2_LANE3_BINARY, TX_CFG2_LANE3_STRLEN);
    constant TX_CLK_SEL0_LANE0_STRING : string := SLV_TO_HEX(TX_CLK_SEL0_LANE0_BINARY, TX_CLK_SEL0_LANE0_STRLEN);
    constant TX_CLK_SEL0_LANE1_STRING : string := SLV_TO_HEX(TX_CLK_SEL0_LANE1_BINARY, TX_CLK_SEL0_LANE1_STRLEN);
    constant TX_CLK_SEL0_LANE2_STRING : string := SLV_TO_HEX(TX_CLK_SEL0_LANE2_BINARY, TX_CLK_SEL0_LANE2_STRLEN);
    constant TX_CLK_SEL0_LANE3_STRING : string := SLV_TO_HEX(TX_CLK_SEL0_LANE3_BINARY, TX_CLK_SEL0_LANE3_STRLEN);
    constant TX_CLK_SEL1_LANE0_STRING : string := SLV_TO_HEX(TX_CLK_SEL1_LANE0_BINARY, TX_CLK_SEL1_LANE0_STRLEN);
    constant TX_CLK_SEL1_LANE1_STRING : string := SLV_TO_HEX(TX_CLK_SEL1_LANE1_BINARY, TX_CLK_SEL1_LANE1_STRLEN);
    constant TX_CLK_SEL1_LANE2_STRING : string := SLV_TO_HEX(TX_CLK_SEL1_LANE2_BINARY, TX_CLK_SEL1_LANE2_STRLEN);
    constant TX_CLK_SEL1_LANE3_STRING : string := SLV_TO_HEX(TX_CLK_SEL1_LANE3_BINARY, TX_CLK_SEL1_LANE3_STRLEN);
    constant TX_DISABLE_LANE0_STRING : string := SLV_TO_HEX(TX_DISABLE_LANE0_BINARY, TX_DISABLE_LANE0_STRLEN);
    constant TX_DISABLE_LANE1_STRING : string := SLV_TO_HEX(TX_DISABLE_LANE1_BINARY, TX_DISABLE_LANE1_STRLEN);
    constant TX_DISABLE_LANE2_STRING : string := SLV_TO_HEX(TX_DISABLE_LANE2_BINARY, TX_DISABLE_LANE2_STRLEN);
    constant TX_DISABLE_LANE3_STRING : string := SLV_TO_HEX(TX_DISABLE_LANE3_BINARY, TX_DISABLE_LANE3_STRLEN);
    constant TX_P0P0S_CTRL_STRING : string := SLV_TO_HEX(TX_P0P0S_CTRL_BINARY, TX_P0P0S_CTRL_STRLEN);
    constant TX_P1P2_CTRL_STRING : string := SLV_TO_HEX(TX_P1P2_CTRL_BINARY, TX_P1P2_CTRL_STRLEN);
    constant TX_PREEMPH_LANE0_STRING : string := SLV_TO_HEX(TX_PREEMPH_LANE0_BINARY, TX_PREEMPH_LANE0_STRLEN);
    constant TX_PREEMPH_LANE1_STRING : string := SLV_TO_HEX(TX_PREEMPH_LANE1_BINARY, TX_PREEMPH_LANE1_STRLEN);
    constant TX_PREEMPH_LANE2_STRING : string := SLV_TO_HEX(TX_PREEMPH_LANE2_BINARY, TX_PREEMPH_LANE2_STRLEN);
    constant TX_PREEMPH_LANE3_STRING : string := SLV_TO_HEX(TX_PREEMPH_LANE3_BINARY, TX_PREEMPH_LANE3_STRLEN);
    constant TX_PWR_RATE_OVRD_LANE0_STRING : string := SLV_TO_HEX(TX_PWR_RATE_OVRD_LANE0_BINARY, TX_PWR_RATE_OVRD_LANE0_STRLEN);
    constant TX_PWR_RATE_OVRD_LANE1_STRING : string := SLV_TO_HEX(TX_PWR_RATE_OVRD_LANE1_BINARY, TX_PWR_RATE_OVRD_LANE1_STRLEN);
    constant TX_PWR_RATE_OVRD_LANE2_STRING : string := SLV_TO_HEX(TX_PWR_RATE_OVRD_LANE2_BINARY, TX_PWR_RATE_OVRD_LANE2_STRLEN);
    constant TX_PWR_RATE_OVRD_LANE3_STRING : string := SLV_TO_HEX(TX_PWR_RATE_OVRD_LANE3_BINARY, TX_PWR_RATE_OVRD_LANE3_STRLEN);
    
    signal RX_FABRIC_WIDTH0_BINARY : std_logic_vector(2 downto 0);
    signal RX_FABRIC_WIDTH1_BINARY : std_logic_vector(2 downto 0);
    signal RX_FABRIC_WIDTH2_BINARY : std_logic_vector(2 downto 0);
    signal RX_FABRIC_WIDTH3_BINARY : std_logic_vector(2 downto 0);
    signal SIM_GTHRESET_SPEEDUP_BINARY : std_ulogic;
    signal SIM_VERSION_BINARY : std_ulogic;
    signal TX_FABRIC_WIDTH0_BINARY : std_logic_vector(2 downto 0);
    signal TX_FABRIC_WIDTH1_BINARY : std_logic_vector(2 downto 0);
    signal TX_FABRIC_WIDTH2_BINARY : std_logic_vector(2 downto 0);
    signal TX_FABRIC_WIDTH3_BINARY : std_logic_vector(2 downto 0);
    
    signal DRDY_out : std_ulogic;
    signal DRPDO_out : std_logic_vector(15 downto 0);
    signal GTHINITDONE_out : std_ulogic;
    signal MGMTPCSRDACK_out : std_ulogic;
    signal MGMTPCSRDDATA_out : std_logic_vector(15 downto 0);
    signal RXCODEERR0_out : std_logic_vector(7 downto 0);
    signal RXCODEERR1_out : std_logic_vector(7 downto 0);
    signal RXCODEERR2_out : std_logic_vector(7 downto 0);
    signal RXCODEERR3_out : std_logic_vector(7 downto 0);
    signal RXCTRL0_out : std_logic_vector(7 downto 0);
    signal RXCTRL1_out : std_logic_vector(7 downto 0);
    signal RXCTRL2_out : std_logic_vector(7 downto 0);
    signal RXCTRL3_out : std_logic_vector(7 downto 0);
    signal RXCTRLACK0_out : std_ulogic;
    signal RXCTRLACK1_out : std_ulogic;
    signal RXCTRLACK2_out : std_ulogic;
    signal RXCTRLACK3_out : std_ulogic;
    signal RXDATA0_out : std_logic_vector(63 downto 0);
    signal RXDATA1_out : std_logic_vector(63 downto 0);
    signal RXDATA2_out : std_logic_vector(63 downto 0);
    signal RXDATA3_out : std_logic_vector(63 downto 0);
    signal RXDATATAP0_out : std_ulogic;
    signal RXDATATAP1_out : std_ulogic;
    signal RXDATATAP2_out : std_ulogic;
    signal RXDATATAP3_out : std_ulogic;
    signal RXDISPERR0_out : std_logic_vector(7 downto 0);
    signal RXDISPERR1_out : std_logic_vector(7 downto 0);
    signal RXDISPERR2_out : std_logic_vector(7 downto 0);
    signal RXDISPERR3_out : std_logic_vector(7 downto 0);
    signal RXPCSCLKSMPL0_out : std_ulogic;
    signal RXPCSCLKSMPL1_out : std_ulogic;
    signal RXPCSCLKSMPL2_out : std_ulogic;
    signal RXPCSCLKSMPL3_out : std_ulogic;
    signal RXUSERCLKOUT0_out : std_ulogic;
    signal RXUSERCLKOUT1_out : std_ulogic;
    signal RXUSERCLKOUT2_out : std_ulogic;
    signal RXUSERCLKOUT3_out : std_ulogic;
    signal RXVALID0_out : std_logic_vector(7 downto 0);
    signal RXVALID1_out : std_logic_vector(7 downto 0);
    signal RXVALID2_out : std_logic_vector(7 downto 0);
    signal RXVALID3_out : std_logic_vector(7 downto 0);
    signal TSTPATH_out : std_ulogic;
    signal TSTREFCLKFAB_out : std_ulogic;
    signal TSTREFCLKOUT_out : std_ulogic;
    signal TXCTRLACK0_out : std_ulogic;
    signal TXCTRLACK1_out : std_ulogic;
    signal TXCTRLACK2_out : std_ulogic;
    signal TXCTRLACK3_out : std_ulogic;
    signal TXDATATAP10_out : std_ulogic;
    signal TXDATATAP11_out : std_ulogic;
    signal TXDATATAP12_out : std_ulogic;
    signal TXDATATAP13_out : std_ulogic;
    signal TXDATATAP20_out : std_ulogic;
    signal TXDATATAP21_out : std_ulogic;
    signal TXDATATAP22_out : std_ulogic;
    signal TXDATATAP23_out : std_ulogic;
    signal TXN0_out : std_ulogic;
    signal TXN1_out : std_ulogic;
    signal TXN2_out : std_ulogic;
    signal TXN3_out : std_ulogic;
    signal TXP0_out : std_ulogic;
    signal TXP1_out : std_ulogic;
    signal TXP2_out : std_ulogic;
    signal TXP3_out : std_ulogic;
    signal TXPCSCLKSMPL0_out : std_ulogic;
    signal TXPCSCLKSMPL1_out : std_ulogic;
    signal TXPCSCLKSMPL2_out : std_ulogic;
    signal TXPCSCLKSMPL3_out : std_ulogic;
    signal TXUSERCLKOUT0_out : std_ulogic;
    signal TXUSERCLKOUT1_out : std_ulogic;
    signal TXUSERCLKOUT2_out : std_ulogic;
    signal TXUSERCLKOUT3_out : std_ulogic;

    signal DRDY_outdelay : std_ulogic;
    signal DRPDO_outdelay : std_logic_vector(15 downto 0);
    signal GTHINITDONE_outdelay : std_ulogic;
    signal MGMTPCSRDACK_outdelay : std_ulogic;
    signal MGMTPCSRDDATA_outdelay : std_logic_vector(15 downto 0);
    signal RXCODEERR0_outdelay : std_logic_vector(7 downto 0);
    signal RXCODEERR1_outdelay : std_logic_vector(7 downto 0);
    signal RXCODEERR2_outdelay : std_logic_vector(7 downto 0);
    signal RXCODEERR3_outdelay : std_logic_vector(7 downto 0);
    signal RXCTRL0_outdelay : std_logic_vector(7 downto 0);
    signal RXCTRL1_outdelay : std_logic_vector(7 downto 0);
    signal RXCTRL2_outdelay : std_logic_vector(7 downto 0);
    signal RXCTRL3_outdelay : std_logic_vector(7 downto 0);
    signal RXCTRLACK0_outdelay : std_ulogic;
    signal RXCTRLACK1_outdelay : std_ulogic;
    signal RXCTRLACK2_outdelay : std_ulogic;
    signal RXCTRLACK3_outdelay : std_ulogic;
    signal RXDATA0_outdelay : std_logic_vector(63 downto 0);
    signal RXDATA1_outdelay : std_logic_vector(63 downto 0);
    signal RXDATA2_outdelay : std_logic_vector(63 downto 0);
    signal RXDATA3_outdelay : std_logic_vector(63 downto 0);
    signal RXDATATAP0_outdelay : std_ulogic;
    signal RXDATATAP1_outdelay : std_ulogic;
    signal RXDATATAP2_outdelay : std_ulogic;
    signal RXDATATAP3_outdelay : std_ulogic;
    signal RXDISPERR0_outdelay : std_logic_vector(7 downto 0);
    signal RXDISPERR1_outdelay : std_logic_vector(7 downto 0);
    signal RXDISPERR2_outdelay : std_logic_vector(7 downto 0);
    signal RXDISPERR3_outdelay : std_logic_vector(7 downto 0);
    signal RXPCSCLKSMPL0_outdelay : std_ulogic;
    signal RXPCSCLKSMPL1_outdelay : std_ulogic;
    signal RXPCSCLKSMPL2_outdelay : std_ulogic;
    signal RXPCSCLKSMPL3_outdelay : std_ulogic;
    signal RXUSERCLKOUT0_outdelay : std_ulogic;
    signal RXUSERCLKOUT1_outdelay : std_ulogic;
    signal RXUSERCLKOUT2_outdelay : std_ulogic;
    signal RXUSERCLKOUT3_outdelay : std_ulogic;
    signal RXVALID0_outdelay : std_logic_vector(7 downto 0);
    signal RXVALID1_outdelay : std_logic_vector(7 downto 0);
    signal RXVALID2_outdelay : std_logic_vector(7 downto 0);
    signal RXVALID3_outdelay : std_logic_vector(7 downto 0);
    signal TSTPATH_outdelay : std_ulogic;
    signal TSTREFCLKFAB_outdelay : std_ulogic;
    signal TSTREFCLKOUT_outdelay : std_ulogic;
    signal TXCTRLACK0_outdelay : std_ulogic;
    signal TXCTRLACK1_outdelay : std_ulogic;
    signal TXCTRLACK2_outdelay : std_ulogic;
    signal TXCTRLACK3_outdelay : std_ulogic;
    signal TXDATATAP10_outdelay : std_ulogic;
    signal TXDATATAP11_outdelay : std_ulogic;
    signal TXDATATAP12_outdelay : std_ulogic;
    signal TXDATATAP13_outdelay : std_ulogic;
    signal TXDATATAP20_outdelay : std_ulogic;
    signal TXDATATAP21_outdelay : std_ulogic;
    signal TXDATATAP22_outdelay : std_ulogic;
    signal TXDATATAP23_outdelay : std_ulogic;
    signal TXN0_outdelay : std_ulogic;
    signal TXN1_outdelay : std_ulogic;
    signal TXN2_outdelay : std_ulogic;
    signal TXN3_outdelay : std_ulogic;
    signal TXP0_outdelay : std_ulogic;
    signal TXP1_outdelay : std_ulogic;
    signal TXP2_outdelay : std_ulogic;
    signal TXP3_outdelay : std_ulogic;
    signal TXPCSCLKSMPL0_outdelay : std_ulogic;
    signal TXPCSCLKSMPL1_outdelay : std_ulogic;
    signal TXPCSCLKSMPL2_outdelay : std_ulogic;
    signal TXPCSCLKSMPL3_outdelay : std_ulogic;
    signal TXUSERCLKOUT0_outdelay : std_ulogic;
    signal TXUSERCLKOUT1_outdelay : std_ulogic;
    signal TXUSERCLKOUT2_outdelay : std_ulogic;
    signal TXUSERCLKOUT3_outdelay : std_ulogic;
    
    signal DADDR_ipd : std_logic_vector(15 downto 0);
    signal DCLK_ipd : std_ulogic;
    signal DEN_ipd : std_ulogic;
    signal DFETRAINCTRL0_ipd : std_ulogic;
    signal DFETRAINCTRL1_ipd : std_ulogic;
    signal DFETRAINCTRL2_ipd : std_ulogic;
    signal DFETRAINCTRL3_ipd : std_ulogic;
    signal DISABLEDRP_ipd : std_ulogic;
    signal DI_ipd : std_logic_vector(15 downto 0);
    signal DWE_ipd : std_ulogic;
    signal GTHINIT_ipd : std_ulogic;
    signal GTHRESET_ipd : std_ulogic;
    signal GTHX2LANE01_ipd : std_ulogic;
    signal GTHX2LANE23_ipd : std_ulogic;
    signal GTHX4LANE_ipd : std_ulogic;
    signal MGMTPCSLANESEL_ipd : std_logic_vector(3 downto 0);
    signal MGMTPCSMMDADDR_ipd : std_logic_vector(4 downto 0);
    signal MGMTPCSREGADDR_ipd : std_logic_vector(15 downto 0);
    signal MGMTPCSREGRD_ipd : std_ulogic;
    signal MGMTPCSREGWR_ipd : std_ulogic;
    signal MGMTPCSWRDATA_ipd : std_logic_vector(15 downto 0);
    signal PLLPCSCLKDIV_ipd : std_logic_vector(5 downto 0);
    signal PLLREFCLKSEL_ipd : std_logic_vector(2 downto 0);
    signal POWERDOWN0_ipd : std_ulogic;
    signal POWERDOWN1_ipd : std_ulogic;
    signal POWERDOWN2_ipd : std_ulogic;
    signal POWERDOWN3_ipd : std_ulogic;
    signal REFCLK_ipd : std_ulogic;
    signal RXBUFRESET0_ipd : std_ulogic;
    signal RXBUFRESET1_ipd : std_ulogic;
    signal RXBUFRESET2_ipd : std_ulogic;
    signal RXBUFRESET3_ipd : std_ulogic;
    signal RXENCOMMADET0_ipd : std_ulogic;
    signal RXENCOMMADET1_ipd : std_ulogic;
    signal RXENCOMMADET2_ipd : std_ulogic;
    signal RXENCOMMADET3_ipd : std_ulogic;
    signal RXN0_ipd : std_ulogic;
    signal RXN1_ipd : std_ulogic;
    signal RXN2_ipd : std_ulogic;
    signal RXN3_ipd : std_ulogic;
    signal RXP0_ipd : std_ulogic;
    signal RXP1_ipd : std_ulogic;
    signal RXP2_ipd : std_ulogic;
    signal RXP3_ipd : std_ulogic;
    signal RXPOLARITY0_ipd : std_ulogic;
    signal RXPOLARITY1_ipd : std_ulogic;
    signal RXPOLARITY2_ipd : std_ulogic;
    signal RXPOLARITY3_ipd : std_ulogic;
    signal RXPOWERDOWN0_ipd : std_logic_vector(1 downto 0);
    signal RXPOWERDOWN1_ipd : std_logic_vector(1 downto 0);
    signal RXPOWERDOWN2_ipd : std_logic_vector(1 downto 0);
    signal RXPOWERDOWN3_ipd : std_logic_vector(1 downto 0);
    signal RXRATE0_ipd : std_logic_vector(1 downto 0);
    signal RXRATE1_ipd : std_logic_vector(1 downto 0);
    signal RXRATE2_ipd : std_logic_vector(1 downto 0);
    signal RXRATE3_ipd : std_logic_vector(1 downto 0);
    signal RXSLIP0_ipd : std_ulogic;
    signal RXSLIP1_ipd : std_ulogic;
    signal RXSLIP2_ipd : std_ulogic;
    signal RXSLIP3_ipd : std_ulogic;
    signal RXUSERCLKIN0_ipd : std_ulogic;
    signal RXUSERCLKIN1_ipd : std_ulogic;
    signal RXUSERCLKIN2_ipd : std_ulogic;
    signal RXUSERCLKIN3_ipd : std_ulogic;
    signal SAMPLERATE0_ipd : std_logic_vector(2 downto 0);
    signal SAMPLERATE1_ipd : std_logic_vector(2 downto 0);
    signal SAMPLERATE2_ipd : std_logic_vector(2 downto 0);
    signal SAMPLERATE3_ipd : std_logic_vector(2 downto 0);
    signal TXBUFRESET0_ipd : std_ulogic;
    signal TXBUFRESET1_ipd : std_ulogic;
    signal TXBUFRESET2_ipd : std_ulogic;
    signal TXBUFRESET3_ipd : std_ulogic;
    signal TXCTRL0_ipd : std_logic_vector(7 downto 0);
    signal TXCTRL1_ipd : std_logic_vector(7 downto 0);
    signal TXCTRL2_ipd : std_logic_vector(7 downto 0);
    signal TXCTRL3_ipd : std_logic_vector(7 downto 0);
    signal TXDATA0_ipd : std_logic_vector(63 downto 0);
    signal TXDATA1_ipd : std_logic_vector(63 downto 0);
    signal TXDATA2_ipd : std_logic_vector(63 downto 0);
    signal TXDATA3_ipd : std_logic_vector(63 downto 0);
    signal TXDATAMSB0_ipd : std_logic_vector(7 downto 0);
    signal TXDATAMSB1_ipd : std_logic_vector(7 downto 0);
    signal TXDATAMSB2_ipd : std_logic_vector(7 downto 0);
    signal TXDATAMSB3_ipd : std_logic_vector(7 downto 0);
    signal TXDEEMPH0_ipd : std_ulogic;
    signal TXDEEMPH1_ipd : std_ulogic;
    signal TXDEEMPH2_ipd : std_ulogic;
    signal TXDEEMPH3_ipd : std_ulogic;
    signal TXMARGIN0_ipd : std_logic_vector(2 downto 0);
    signal TXMARGIN1_ipd : std_logic_vector(2 downto 0);
    signal TXMARGIN2_ipd : std_logic_vector(2 downto 0);
    signal TXMARGIN3_ipd : std_logic_vector(2 downto 0);
    signal TXPOWERDOWN0_ipd : std_logic_vector(1 downto 0);
    signal TXPOWERDOWN1_ipd : std_logic_vector(1 downto 0);
    signal TXPOWERDOWN2_ipd : std_logic_vector(1 downto 0);
    signal TXPOWERDOWN3_ipd : std_logic_vector(1 downto 0);
    signal TXRATE0_ipd : std_logic_vector(1 downto 0);
    signal TXRATE1_ipd : std_logic_vector(1 downto 0);
    signal TXRATE2_ipd : std_logic_vector(1 downto 0);
    signal TXRATE3_ipd : std_logic_vector(1 downto 0);
    signal TXUSERCLKIN0_ipd : std_ulogic;
    signal TXUSERCLKIN1_ipd : std_ulogic;
    signal TXUSERCLKIN2_ipd : std_ulogic;
    signal TXUSERCLKIN3_ipd : std_ulogic;

        signal DADDR_DCLK_dly : std_logic_vector(15 downto 0);
    signal DCLK_dly : std_ulogic;
    signal DEN_DCLK_dly : std_ulogic;
    signal DFETRAINCTRL0_DCLK_dly : std_ulogic;
    signal DFETRAINCTRL1_DCLK_dly : std_ulogic;
    signal DFETRAINCTRL2_DCLK_dly : std_ulogic;
    signal DFETRAINCTRL3_DCLK_dly : std_ulogic;
    signal DISABLEDRP_DCLK_dly : std_ulogic;
    signal DI_DCLK_dly : std_logic_vector(15 downto 0);
    signal DWE_DCLK_dly : std_ulogic;
    signal GTHINIT_DCLK_dly : std_ulogic;
    signal MGMTPCSLANESEL_DCLK_dly : std_logic_vector(3 downto 0);
    signal MGMTPCSMMDADDR_DCLK_dly : std_logic_vector(4 downto 0);
    signal MGMTPCSREGADDR_DCLK_dly : std_logic_vector(15 downto 0);
    signal MGMTPCSREGRD_DCLK_dly : std_ulogic;
    signal MGMTPCSREGWR_DCLK_dly : std_ulogic;
    signal MGMTPCSWRDATA_DCLK_dly : std_logic_vector(15 downto 0);
    signal PLLPCSCLKDIV_DCLK_dly : std_logic_vector(5 downto 0);
    signal REFCLK_dly : std_ulogic;
    signal RXBUFRESET0_RXUSERCLKIN0_dly : std_ulogic;
    signal RXBUFRESET1_RXUSERCLKIN1_dly : std_ulogic;
    signal RXBUFRESET2_RXUSERCLKIN2_dly : std_ulogic;
    signal RXBUFRESET3_RXUSERCLKIN3_dly : std_ulogic;
    signal RXENCOMMADET0_RXUSERCLKIN0_dly : std_ulogic;
    signal RXENCOMMADET1_RXUSERCLKIN1_dly : std_ulogic;
    signal RXENCOMMADET2_RXUSERCLKIN2_dly : std_ulogic;
    signal RXENCOMMADET3_RXUSERCLKIN3_dly : std_ulogic;
    signal RXPOLARITY0_RXUSERCLKIN0_dly : std_ulogic;
    signal RXPOLARITY1_RXUSERCLKIN1_dly : std_ulogic;
    signal RXPOLARITY2_RXUSERCLKIN2_dly : std_ulogic;
    signal RXPOLARITY3_RXUSERCLKIN3_dly : std_ulogic;
    signal RXPOWERDOWN0_TXUSERCLKIN0_dly : std_logic_vector(1 downto 0);
    signal RXPOWERDOWN1_TXUSERCLKIN1_dly : std_logic_vector(1 downto 0);
    signal RXPOWERDOWN2_TXUSERCLKIN2_dly : std_logic_vector(1 downto 0);
    signal RXPOWERDOWN3_TXUSERCLKIN3_dly : std_logic_vector(1 downto 0);
    signal RXRATE0_TXUSERCLKIN0_dly : std_logic_vector(1 downto 0);
    signal RXRATE1_TXUSERCLKIN1_dly : std_logic_vector(1 downto 0);
    signal RXRATE2_TXUSERCLKIN2_dly : std_logic_vector(1 downto 0);
    signal RXRATE3_TXUSERCLKIN3_dly : std_logic_vector(1 downto 0);
    signal RXUSERCLKIN0_dly : std_ulogic;
    signal RXUSERCLKIN1_dly : std_ulogic;
    signal RXUSERCLKIN2_dly : std_ulogic;
    signal RXUSERCLKIN3_dly : std_ulogic;
    signal SAMPLERATE0_TXUSERCLKIN0_dly : std_logic_vector(2 downto 0);
    signal SAMPLERATE1_TXUSERCLKIN1_dly : std_logic_vector(2 downto 0);
    signal SAMPLERATE2_TXUSERCLKIN2_dly : std_logic_vector(2 downto 0);
    signal SAMPLERATE3_TXUSERCLKIN3_dly : std_logic_vector(2 downto 0);
    signal TXBUFRESET0_TXUSERCLKIN0_dly : std_ulogic;
    signal TXBUFRESET1_TXUSERCLKIN1_dly : std_ulogic;
    signal TXBUFRESET2_TXUSERCLKIN2_dly : std_ulogic;
    signal TXBUFRESET3_TXUSERCLKIN3_dly : std_ulogic;
    signal TXCTRL0_TXUSERCLKIN0_dly : std_logic_vector(7 downto 0);
    signal TXCTRL1_TXUSERCLKIN1_dly : std_logic_vector(7 downto 0);
    signal TXCTRL2_TXUSERCLKIN2_dly : std_logic_vector(7 downto 0);
    signal TXCTRL3_TXUSERCLKIN3_dly : std_logic_vector(7 downto 0);
    signal TXDATA0_TXUSERCLKIN0_dly : std_logic_vector(63 downto 0);
    signal TXDATA1_TXUSERCLKIN1_dly : std_logic_vector(63 downto 0);
    signal TXDATA2_TXUSERCLKIN2_dly : std_logic_vector(63 downto 0);
    signal TXDATA3_TXUSERCLKIN3_dly : std_logic_vector(63 downto 0);
    signal TXDATAMSB0_TXUSERCLKIN0_dly : std_logic_vector(7 downto 0);
    signal TXDATAMSB1_TXUSERCLKIN1_dly : std_logic_vector(7 downto 0);
    signal TXDATAMSB2_TXUSERCLKIN2_dly : std_logic_vector(7 downto 0);
    signal TXDATAMSB3_TXUSERCLKIN3_dly : std_logic_vector(7 downto 0);
    signal TXDEEMPH0_TXUSERCLKIN0_dly : std_ulogic;
    signal TXDEEMPH1_TXUSERCLKIN1_dly : std_ulogic;
    signal TXDEEMPH2_TXUSERCLKIN2_dly : std_ulogic;
    signal TXDEEMPH3_TXUSERCLKIN3_dly : std_ulogic;
    signal TXMARGIN0_TXUSERCLKIN0_dly : std_logic_vector(2 downto 0);
    signal TXMARGIN1_TXUSERCLKIN1_dly : std_logic_vector(2 downto 0);
    signal TXMARGIN2_TXUSERCLKIN2_dly : std_logic_vector(2 downto 0);
    signal TXMARGIN3_TXUSERCLKIN3_dly : std_logic_vector(2 downto 0);
    signal TXPOWERDOWN0_TXUSERCLKIN0_dly : std_logic_vector(1 downto 0);
    signal TXPOWERDOWN1_TXUSERCLKIN1_dly : std_logic_vector(1 downto 0);
    signal TXPOWERDOWN2_TXUSERCLKIN2_dly : std_logic_vector(1 downto 0);
    signal TXPOWERDOWN3_TXUSERCLKIN3_dly : std_logic_vector(1 downto 0);
    signal TXRATE0_TXUSERCLKIN0_dly : std_logic_vector(1 downto 0);
    signal TXRATE1_TXUSERCLKIN1_dly : std_logic_vector(1 downto 0);
    signal TXRATE2_TXUSERCLKIN2_dly : std_logic_vector(1 downto 0);
    signal TXRATE3_TXUSERCLKIN3_dly : std_logic_vector(1 downto 0);
    signal TXUSERCLKIN0_dly : std_ulogic;
    signal TXUSERCLKIN1_dly : std_ulogic;
    signal TXUSERCLKIN2_dly : std_ulogic;
    signal TXUSERCLKIN3_dly : std_ulogic;
    
    signal DADDR_indelay : std_logic_vector(15 downto 0);
    signal DCLK_indelay : std_ulogic;
    signal DEN_indelay : std_ulogic;
    signal DFETRAINCTRL0_indelay : std_ulogic;
    signal DFETRAINCTRL1_indelay : std_ulogic;
    signal DFETRAINCTRL2_indelay : std_ulogic;
    signal DFETRAINCTRL3_indelay : std_ulogic;
    signal DISABLEDRP_indelay : std_ulogic;
    signal DI_indelay : std_logic_vector(15 downto 0);
    signal DWE_indelay : std_ulogic;
    signal GTHINIT_indelay : std_ulogic;
    signal GTHRESET_indelay : std_ulogic;
    signal GTHX2LANE01_indelay : std_ulogic;
    signal GTHX2LANE23_indelay : std_ulogic;
    signal GTHX4LANE_indelay : std_ulogic;
    signal MGMTPCSLANESEL_indelay : std_logic_vector(3 downto 0);
    signal MGMTPCSMMDADDR_indelay : std_logic_vector(4 downto 0);
    signal MGMTPCSREGADDR_indelay : std_logic_vector(15 downto 0);
    signal MGMTPCSREGRD_indelay : std_ulogic;
    signal MGMTPCSREGWR_indelay : std_ulogic;
    signal MGMTPCSWRDATA_indelay : std_logic_vector(15 downto 0);
    signal PLLPCSCLKDIV_indelay : std_logic_vector(5 downto 0);
    signal PLLREFCLKSEL_indelay : std_logic_vector(2 downto 0);
    signal POWERDOWN0_indelay : std_ulogic;
    signal POWERDOWN1_indelay : std_ulogic;
    signal POWERDOWN2_indelay : std_ulogic;
    signal POWERDOWN3_indelay : std_ulogic;
    signal REFCLK_indelay : std_ulogic;
    signal RXBUFRESET0_indelay : std_ulogic;
    signal RXBUFRESET1_indelay : std_ulogic;
    signal RXBUFRESET2_indelay : std_ulogic;
    signal RXBUFRESET3_indelay : std_ulogic;
    signal RXENCOMMADET0_indelay : std_ulogic;
    signal RXENCOMMADET1_indelay : std_ulogic;
    signal RXENCOMMADET2_indelay : std_ulogic;
    signal RXENCOMMADET3_indelay : std_ulogic;
    signal RXN0_indelay : std_ulogic;
    signal RXN1_indelay : std_ulogic;
    signal RXN2_indelay : std_ulogic;
    signal RXN3_indelay : std_ulogic;
    signal RXP0_indelay : std_ulogic;
    signal RXP1_indelay : std_ulogic;
    signal RXP2_indelay : std_ulogic;
    signal RXP3_indelay : std_ulogic;
    signal RXPOLARITY0_indelay : std_ulogic;
    signal RXPOLARITY1_indelay : std_ulogic;
    signal RXPOLARITY2_indelay : std_ulogic;
    signal RXPOLARITY3_indelay : std_ulogic;
    signal RXPOWERDOWN0_indelay : std_logic_vector(1 downto 0);
    signal RXPOWERDOWN1_indelay : std_logic_vector(1 downto 0);
    signal RXPOWERDOWN2_indelay : std_logic_vector(1 downto 0);
    signal RXPOWERDOWN3_indelay : std_logic_vector(1 downto 0);
    signal RXRATE0_indelay : std_logic_vector(1 downto 0);
    signal RXRATE1_indelay : std_logic_vector(1 downto 0);
    signal RXRATE2_indelay : std_logic_vector(1 downto 0);
    signal RXRATE3_indelay : std_logic_vector(1 downto 0);
    signal RXSLIP0_indelay : std_ulogic;
    signal RXSLIP1_indelay : std_ulogic;
    signal RXSLIP2_indelay : std_ulogic;
    signal RXSLIP3_indelay : std_ulogic;
    signal RXUSERCLKIN0_indelay : std_ulogic;
    signal RXUSERCLKIN1_indelay : std_ulogic;
    signal RXUSERCLKIN2_indelay : std_ulogic;
    signal RXUSERCLKIN3_indelay : std_ulogic;
    signal SAMPLERATE0_indelay : std_logic_vector(2 downto 0);
    signal SAMPLERATE1_indelay : std_logic_vector(2 downto 0);
    signal SAMPLERATE2_indelay : std_logic_vector(2 downto 0);
    signal SAMPLERATE3_indelay : std_logic_vector(2 downto 0);
    signal TXBUFRESET0_indelay : std_ulogic;
    signal TXBUFRESET1_indelay : std_ulogic;
    signal TXBUFRESET2_indelay : std_ulogic;
    signal TXBUFRESET3_indelay : std_ulogic;
    signal TXCTRL0_indelay : std_logic_vector(7 downto 0);
    signal TXCTRL1_indelay : std_logic_vector(7 downto 0);
    signal TXCTRL2_indelay : std_logic_vector(7 downto 0);
    signal TXCTRL3_indelay : std_logic_vector(7 downto 0);
    signal TXDATA0_indelay : std_logic_vector(63 downto 0);
    signal TXDATA1_indelay : std_logic_vector(63 downto 0);
    signal TXDATA2_indelay : std_logic_vector(63 downto 0);
    signal TXDATA3_indelay : std_logic_vector(63 downto 0);
    signal TXDATAMSB0_indelay : std_logic_vector(7 downto 0);
    signal TXDATAMSB1_indelay : std_logic_vector(7 downto 0);
    signal TXDATAMSB2_indelay : std_logic_vector(7 downto 0);
    signal TXDATAMSB3_indelay : std_logic_vector(7 downto 0);
    signal TXDEEMPH0_indelay : std_ulogic;
    signal TXDEEMPH1_indelay : std_ulogic;
    signal TXDEEMPH2_indelay : std_ulogic;
    signal TXDEEMPH3_indelay : std_ulogic;
    signal TXMARGIN0_indelay : std_logic_vector(2 downto 0);
    signal TXMARGIN1_indelay : std_logic_vector(2 downto 0);
    signal TXMARGIN2_indelay : std_logic_vector(2 downto 0);
    signal TXMARGIN3_indelay : std_logic_vector(2 downto 0);
    signal TXPOWERDOWN0_indelay : std_logic_vector(1 downto 0);
    signal TXPOWERDOWN1_indelay : std_logic_vector(1 downto 0);
    signal TXPOWERDOWN2_indelay : std_logic_vector(1 downto 0);
    signal TXPOWERDOWN3_indelay : std_logic_vector(1 downto 0);
    signal TXRATE0_indelay : std_logic_vector(1 downto 0);
    signal TXRATE1_indelay : std_logic_vector(1 downto 0);
    signal TXRATE2_indelay : std_logic_vector(1 downto 0);
    signal TXRATE3_indelay : std_logic_vector(1 downto 0);
    signal TXUSERCLKIN0_indelay : std_ulogic;
    signal TXUSERCLKIN1_indelay : std_ulogic;
    signal TXUSERCLKIN2_indelay : std_ulogic;
    signal TXUSERCLKIN3_indelay : std_ulogic;
    
    signal DADDR_indly : std_logic_vector(15 downto 0);
    signal DCLK_indly : std_ulogic;
    signal DEN_indly : std_ulogic;
    signal DFETRAINCTRL0_indly : std_ulogic;
    signal DFETRAINCTRL1_indly : std_ulogic;
    signal DFETRAINCTRL2_indly : std_ulogic;
    signal DFETRAINCTRL3_indly : std_ulogic;
    signal DISABLEDRP_indly : std_ulogic;
    signal DI_indly : std_logic_vector(15 downto 0);
    signal DWE_indly : std_ulogic;
    signal GTHINIT_indly : std_ulogic;
    signal GTHRESET_indly : std_ulogic;
    signal GTHX2LANE01_indly : std_ulogic;
    signal GTHX2LANE23_indly : std_ulogic;
    signal GTHX4LANE_indly : std_ulogic;
    signal MGMTPCSLANESEL_indly : std_logic_vector(3 downto 0);
    signal MGMTPCSMMDADDR_indly : std_logic_vector(4 downto 0);
    signal MGMTPCSREGADDR_indly : std_logic_vector(15 downto 0);
    signal MGMTPCSREGRD_indly : std_ulogic;
    signal MGMTPCSREGWR_indly : std_ulogic;
    signal MGMTPCSWRDATA_indly : std_logic_vector(15 downto 0);
    signal PLLPCSCLKDIV_indly : std_logic_vector(5 downto 0);
    signal PLLREFCLKSEL_indly : std_logic_vector(2 downto 0);
    signal POWERDOWN0_indly : std_ulogic;
    signal POWERDOWN1_indly : std_ulogic;
    signal POWERDOWN2_indly : std_ulogic;
    signal POWERDOWN3_indly : std_ulogic;
    signal REFCLK_indly : std_ulogic;
    signal RXBUFRESET0_indly : std_ulogic;
    signal RXBUFRESET1_indly : std_ulogic;
    signal RXBUFRESET2_indly : std_ulogic;
    signal RXBUFRESET3_indly : std_ulogic;
    signal RXENCOMMADET0_indly : std_ulogic;
    signal RXENCOMMADET1_indly : std_ulogic;
    signal RXENCOMMADET2_indly : std_ulogic;
    signal RXENCOMMADET3_indly : std_ulogic;
    signal RXN0_indly : std_ulogic;
    signal RXN1_indly : std_ulogic;
    signal RXN2_indly : std_ulogic;
    signal RXN3_indly : std_ulogic;
    signal RXP0_indly : std_ulogic;
    signal RXP1_indly : std_ulogic;
    signal RXP2_indly : std_ulogic;
    signal RXP3_indly : std_ulogic;
    signal RXPOLARITY0_indly : std_ulogic;
    signal RXPOLARITY1_indly : std_ulogic;
    signal RXPOLARITY2_indly : std_ulogic;
    signal RXPOLARITY3_indly : std_ulogic;
    signal RXPOWERDOWN0_indly : std_logic_vector(1 downto 0);
    signal RXPOWERDOWN1_indly : std_logic_vector(1 downto 0);
    signal RXPOWERDOWN2_indly : std_logic_vector(1 downto 0);
    signal RXPOWERDOWN3_indly : std_logic_vector(1 downto 0);
    signal RXRATE0_indly : std_logic_vector(1 downto 0);
    signal RXRATE1_indly : std_logic_vector(1 downto 0);
    signal RXRATE2_indly : std_logic_vector(1 downto 0);
    signal RXRATE3_indly : std_logic_vector(1 downto 0);
    signal RXSLIP0_indly : std_ulogic;
    signal RXSLIP1_indly : std_ulogic;
    signal RXSLIP2_indly : std_ulogic;
    signal RXSLIP3_indly : std_ulogic;
    signal RXUSERCLKIN0_indly : std_ulogic;
    signal RXUSERCLKIN1_indly : std_ulogic;
    signal RXUSERCLKIN2_indly : std_ulogic;
    signal RXUSERCLKIN3_indly : std_ulogic;
    signal SAMPLERATE0_indly : std_logic_vector(2 downto 0);
    signal SAMPLERATE1_indly : std_logic_vector(2 downto 0);
    signal SAMPLERATE2_indly : std_logic_vector(2 downto 0);
    signal SAMPLERATE3_indly : std_logic_vector(2 downto 0);
    signal TXBUFRESET0_indly : std_ulogic;
    signal TXBUFRESET1_indly : std_ulogic;
    signal TXBUFRESET2_indly : std_ulogic;
    signal TXBUFRESET3_indly : std_ulogic;
    signal TXCTRL0_indly : std_logic_vector(7 downto 0);
    signal TXCTRL1_indly : std_logic_vector(7 downto 0);
    signal TXCTRL2_indly : std_logic_vector(7 downto 0);
    signal TXCTRL3_indly : std_logic_vector(7 downto 0);
    signal TXDATA0_indly : std_logic_vector(63 downto 0);
    signal TXDATA1_indly : std_logic_vector(63 downto 0);
    signal TXDATA2_indly : std_logic_vector(63 downto 0);
    signal TXDATA3_indly : std_logic_vector(63 downto 0);
    signal TXDATAMSB0_indly : std_logic_vector(7 downto 0);
    signal TXDATAMSB1_indly : std_logic_vector(7 downto 0);
    signal TXDATAMSB2_indly : std_logic_vector(7 downto 0);
    signal TXDATAMSB3_indly : std_logic_vector(7 downto 0);
    signal TXDEEMPH0_indly : std_ulogic;
    signal TXDEEMPH1_indly : std_ulogic;
    signal TXDEEMPH2_indly : std_ulogic;
    signal TXDEEMPH3_indly : std_ulogic;
    signal TXMARGIN0_indly : std_logic_vector(2 downto 0);
    signal TXMARGIN1_indly : std_logic_vector(2 downto 0);
    signal TXMARGIN2_indly : std_logic_vector(2 downto 0);
    signal TXMARGIN3_indly : std_logic_vector(2 downto 0);
    signal TXPOWERDOWN0_indly : std_logic_vector(1 downto 0);
    signal TXPOWERDOWN1_indly : std_logic_vector(1 downto 0);
    signal TXPOWERDOWN2_indly : std_logic_vector(1 downto 0);
    signal TXPOWERDOWN3_indly : std_logic_vector(1 downto 0);
    signal TXRATE0_indly : std_logic_vector(1 downto 0);
    signal TXRATE1_indly : std_logic_vector(1 downto 0);
    signal TXRATE2_indly : std_logic_vector(1 downto 0);
    signal TXRATE3_indly : std_logic_vector(1 downto 0);
    signal TXUSERCLKIN0_indly : std_ulogic;
    signal TXUSERCLKIN1_indly : std_ulogic;
    signal TXUSERCLKIN2_indly : std_ulogic;
    signal TXUSERCLKIN3_indly : std_ulogic;
    
-- <!--Aldec correction start
	signal GSR_local : std_ulogic;
-- Aldec correction end -->

    begin
    
    WireDelay : block
    begin
      DADDR_DELAY : for i in 0 to 15 generate
        VitalWireDelay (DADDR_ipd(i),DADDR(i),tipd_DADDR(i));
      end generate DADDR_DELAY;
      DI_DELAY : for i in 0 to 15 generate
        VitalWireDelay (DI_ipd(i),DI(i),tipd_DI(i));
      end generate DI_DELAY;
      MGMTPCSLANESEL_DELAY : for i in 0 to 3 generate
        VitalWireDelay (MGMTPCSLANESEL_ipd(i),MGMTPCSLANESEL(i),tipd_MGMTPCSLANESEL(i));
      end generate MGMTPCSLANESEL_DELAY;
      MGMTPCSMMDADDR_DELAY : for i in 0 to 4 generate
        VitalWireDelay (MGMTPCSMMDADDR_ipd(i),MGMTPCSMMDADDR(i),tipd_MGMTPCSMMDADDR(i));
      end generate MGMTPCSMMDADDR_DELAY;
      MGMTPCSREGADDR_DELAY : for i in 0 to 15 generate
        VitalWireDelay (MGMTPCSREGADDR_ipd(i),MGMTPCSREGADDR(i),tipd_MGMTPCSREGADDR(i));
      end generate MGMTPCSREGADDR_DELAY;
      MGMTPCSWRDATA_DELAY : for i in 0 to 15 generate
        VitalWireDelay (MGMTPCSWRDATA_ipd(i),MGMTPCSWRDATA(i),tipd_MGMTPCSWRDATA(i));
      end generate MGMTPCSWRDATA_DELAY;
      PLLPCSCLKDIV_DELAY : for i in 0 to 5 generate
        VitalWireDelay (PLLPCSCLKDIV_ipd(i),PLLPCSCLKDIV(i),tipd_PLLPCSCLKDIV(i));
      end generate PLLPCSCLKDIV_DELAY;
      PLLREFCLKSEL_DELAY : for i in 0 to 2 generate
        VitalWireDelay (PLLREFCLKSEL_ipd(i),PLLREFCLKSEL(i),tipd_PLLREFCLKSEL(i));
      end generate PLLREFCLKSEL_DELAY;
      RXPOWERDOWN0_DELAY : for i in 0 to 1 generate
        VitalWireDelay (RXPOWERDOWN0_ipd(i),RXPOWERDOWN0(i),tipd_RXPOWERDOWN0(i));
      end generate RXPOWERDOWN0_DELAY;
      RXPOWERDOWN1_DELAY : for i in 0 to 1 generate
        VitalWireDelay (RXPOWERDOWN1_ipd(i),RXPOWERDOWN1(i),tipd_RXPOWERDOWN1(i));
      end generate RXPOWERDOWN1_DELAY;
      RXPOWERDOWN2_DELAY : for i in 0 to 1 generate
        VitalWireDelay (RXPOWERDOWN2_ipd(i),RXPOWERDOWN2(i),tipd_RXPOWERDOWN2(i));
      end generate RXPOWERDOWN2_DELAY;
      RXPOWERDOWN3_DELAY : for i in 0 to 1 generate
        VitalWireDelay (RXPOWERDOWN3_ipd(i),RXPOWERDOWN3(i),tipd_RXPOWERDOWN3(i));
      end generate RXPOWERDOWN3_DELAY;
      RXRATE0_DELAY : for i in 0 to 1 generate
        VitalWireDelay (RXRATE0_ipd(i),RXRATE0(i),tipd_RXRATE0(i));
      end generate RXRATE0_DELAY;
      RXRATE1_DELAY : for i in 0 to 1 generate
        VitalWireDelay (RXRATE1_ipd(i),RXRATE1(i),tipd_RXRATE1(i));
      end generate RXRATE1_DELAY;
      RXRATE2_DELAY : for i in 0 to 1 generate
        VitalWireDelay (RXRATE2_ipd(i),RXRATE2(i),tipd_RXRATE2(i));
      end generate RXRATE2_DELAY;
      RXRATE3_DELAY : for i in 0 to 1 generate
        VitalWireDelay (RXRATE3_ipd(i),RXRATE3(i),tipd_RXRATE3(i));
      end generate RXRATE3_DELAY;
      SAMPLERATE0_DELAY : for i in 0 to 2 generate
        VitalWireDelay (SAMPLERATE0_ipd(i),SAMPLERATE0(i),tipd_SAMPLERATE0(i));
      end generate SAMPLERATE0_DELAY;
      SAMPLERATE1_DELAY : for i in 0 to 2 generate
        VitalWireDelay (SAMPLERATE1_ipd(i),SAMPLERATE1(i),tipd_SAMPLERATE1(i));
      end generate SAMPLERATE1_DELAY;
      SAMPLERATE2_DELAY : for i in 0 to 2 generate
        VitalWireDelay (SAMPLERATE2_ipd(i),SAMPLERATE2(i),tipd_SAMPLERATE2(i));
      end generate SAMPLERATE2_DELAY;
      SAMPLERATE3_DELAY : for i in 0 to 2 generate
        VitalWireDelay (SAMPLERATE3_ipd(i),SAMPLERATE3(i),tipd_SAMPLERATE3(i));
      end generate SAMPLERATE3_DELAY;
      TXCTRL0_DELAY : for i in 0 to 7 generate
        VitalWireDelay (TXCTRL0_ipd(i),TXCTRL0(i),tipd_TXCTRL0(i));
      end generate TXCTRL0_DELAY;
      TXCTRL1_DELAY : for i in 0 to 7 generate
        VitalWireDelay (TXCTRL1_ipd(i),TXCTRL1(i),tipd_TXCTRL1(i));
      end generate TXCTRL1_DELAY;
      TXCTRL2_DELAY : for i in 0 to 7 generate
        VitalWireDelay (TXCTRL2_ipd(i),TXCTRL2(i),tipd_TXCTRL2(i));
      end generate TXCTRL2_DELAY;
      TXCTRL3_DELAY : for i in 0 to 7 generate
        VitalWireDelay (TXCTRL3_ipd(i),TXCTRL3(i),tipd_TXCTRL3(i));
      end generate TXCTRL3_DELAY;
      TXDATA0_DELAY : for i in 0 to 63 generate
        VitalWireDelay (TXDATA0_ipd(i),TXDATA0(i),tipd_TXDATA0(i));
      end generate TXDATA0_DELAY;
      TXDATA1_DELAY : for i in 0 to 63 generate
        VitalWireDelay (TXDATA1_ipd(i),TXDATA1(i),tipd_TXDATA1(i));
      end generate TXDATA1_DELAY;
      TXDATA2_DELAY : for i in 0 to 63 generate
        VitalWireDelay (TXDATA2_ipd(i),TXDATA2(i),tipd_TXDATA2(i));
      end generate TXDATA2_DELAY;
      TXDATA3_DELAY : for i in 0 to 63 generate
        VitalWireDelay (TXDATA3_ipd(i),TXDATA3(i),tipd_TXDATA3(i));
      end generate TXDATA3_DELAY;
      TXDATAMSB0_DELAY : for i in 0 to 7 generate
        VitalWireDelay (TXDATAMSB0_ipd(i),TXDATAMSB0(i),tipd_TXDATAMSB0(i));
      end generate TXDATAMSB0_DELAY;
      TXDATAMSB1_DELAY : for i in 0 to 7 generate
        VitalWireDelay (TXDATAMSB1_ipd(i),TXDATAMSB1(i),tipd_TXDATAMSB1(i));
      end generate TXDATAMSB1_DELAY;
      TXDATAMSB2_DELAY : for i in 0 to 7 generate
        VitalWireDelay (TXDATAMSB2_ipd(i),TXDATAMSB2(i),tipd_TXDATAMSB2(i));
      end generate TXDATAMSB2_DELAY;
      TXDATAMSB3_DELAY : for i in 0 to 7 generate
        VitalWireDelay (TXDATAMSB3_ipd(i),TXDATAMSB3(i),tipd_TXDATAMSB3(i));
      end generate TXDATAMSB3_DELAY;
      TXMARGIN0_DELAY : for i in 0 to 2 generate
        VitalWireDelay (TXMARGIN0_ipd(i),TXMARGIN0(i),tipd_TXMARGIN0(i));
      end generate TXMARGIN0_DELAY;
      TXMARGIN1_DELAY : for i in 0 to 2 generate
        VitalWireDelay (TXMARGIN1_ipd(i),TXMARGIN1(i),tipd_TXMARGIN1(i));
      end generate TXMARGIN1_DELAY;
      TXMARGIN2_DELAY : for i in 0 to 2 generate
        VitalWireDelay (TXMARGIN2_ipd(i),TXMARGIN2(i),tipd_TXMARGIN2(i));
      end generate TXMARGIN2_DELAY;
      TXMARGIN3_DELAY : for i in 0 to 2 generate
        VitalWireDelay (TXMARGIN3_ipd(i),TXMARGIN3(i),tipd_TXMARGIN3(i));
      end generate TXMARGIN3_DELAY;
      TXPOWERDOWN0_DELAY : for i in 0 to 1 generate
        VitalWireDelay (TXPOWERDOWN0_ipd(i),TXPOWERDOWN0(i),tipd_TXPOWERDOWN0(i));
      end generate TXPOWERDOWN0_DELAY;
      TXPOWERDOWN1_DELAY : for i in 0 to 1 generate
        VitalWireDelay (TXPOWERDOWN1_ipd(i),TXPOWERDOWN1(i),tipd_TXPOWERDOWN1(i));
      end generate TXPOWERDOWN1_DELAY;
      TXPOWERDOWN2_DELAY : for i in 0 to 1 generate
        VitalWireDelay (TXPOWERDOWN2_ipd(i),TXPOWERDOWN2(i),tipd_TXPOWERDOWN2(i));
      end generate TXPOWERDOWN2_DELAY;
      TXPOWERDOWN3_DELAY : for i in 0 to 1 generate
        VitalWireDelay (TXPOWERDOWN3_ipd(i),TXPOWERDOWN3(i),tipd_TXPOWERDOWN3(i));
      end generate TXPOWERDOWN3_DELAY;
      TXRATE0_DELAY : for i in 0 to 1 generate
        VitalWireDelay (TXRATE0_ipd(i),TXRATE0(i),tipd_TXRATE0(i));
      end generate TXRATE0_DELAY;
      TXRATE1_DELAY : for i in 0 to 1 generate
        VitalWireDelay (TXRATE1_ipd(i),TXRATE1(i),tipd_TXRATE1(i));
      end generate TXRATE1_DELAY;
      TXRATE2_DELAY : for i in 0 to 1 generate
        VitalWireDelay (TXRATE2_ipd(i),TXRATE2(i),tipd_TXRATE2(i));
      end generate TXRATE2_DELAY;
      TXRATE3_DELAY : for i in 0 to 1 generate
        VitalWireDelay (TXRATE3_ipd(i),TXRATE3(i),tipd_TXRATE3(i));
      end generate TXRATE3_DELAY;
      VitalWireDelay (DCLK_ipd,DCLK,tipd_DCLK);
      VitalWireDelay (DEN_ipd,DEN,tipd_DEN);
      VitalWireDelay (DFETRAINCTRL0_ipd,DFETRAINCTRL0,tipd_DFETRAINCTRL0);
      VitalWireDelay (DFETRAINCTRL1_ipd,DFETRAINCTRL1,tipd_DFETRAINCTRL1);
      VitalWireDelay (DFETRAINCTRL2_ipd,DFETRAINCTRL2,tipd_DFETRAINCTRL2);
      VitalWireDelay (DFETRAINCTRL3_ipd,DFETRAINCTRL3,tipd_DFETRAINCTRL3);
      VitalWireDelay (DISABLEDRP_ipd,DISABLEDRP,tipd_DISABLEDRP);
      VitalWireDelay (DWE_ipd,DWE,tipd_DWE);
      VitalWireDelay (GTHINIT_ipd,GTHINIT,tipd_GTHINIT);
      VitalWireDelay (GTHRESET_ipd,GTHRESET,tipd_GTHRESET);
      VitalWireDelay (GTHX2LANE01_ipd,GTHX2LANE01,tipd_GTHX2LANE01);
      VitalWireDelay (GTHX2LANE23_ipd,GTHX2LANE23,tipd_GTHX2LANE23);
      VitalWireDelay (GTHX4LANE_ipd,GTHX4LANE,tipd_GTHX4LANE);
      VitalWireDelay (MGMTPCSREGRD_ipd,MGMTPCSREGRD,tipd_MGMTPCSREGRD);
      VitalWireDelay (MGMTPCSREGWR_ipd,MGMTPCSREGWR,tipd_MGMTPCSREGWR);
      VitalWireDelay (POWERDOWN0_ipd,POWERDOWN0,tipd_POWERDOWN0);
      VitalWireDelay (POWERDOWN1_ipd,POWERDOWN1,tipd_POWERDOWN1);
      VitalWireDelay (POWERDOWN2_ipd,POWERDOWN2,tipd_POWERDOWN2);
      VitalWireDelay (POWERDOWN3_ipd,POWERDOWN3,tipd_POWERDOWN3);
      VitalWireDelay (REFCLK_ipd,REFCLK,tipd_REFCLK);
      VitalWireDelay (RXBUFRESET0_ipd,RXBUFRESET0,tipd_RXBUFRESET0);
      VitalWireDelay (RXBUFRESET1_ipd,RXBUFRESET1,tipd_RXBUFRESET1);
      VitalWireDelay (RXBUFRESET2_ipd,RXBUFRESET2,tipd_RXBUFRESET2);
      VitalWireDelay (RXBUFRESET3_ipd,RXBUFRESET3,tipd_RXBUFRESET3);
      VitalWireDelay (RXENCOMMADET0_ipd,RXENCOMMADET0,tipd_RXENCOMMADET0);
      VitalWireDelay (RXENCOMMADET1_ipd,RXENCOMMADET1,tipd_RXENCOMMADET1);
      VitalWireDelay (RXENCOMMADET2_ipd,RXENCOMMADET2,tipd_RXENCOMMADET2);
      VitalWireDelay (RXENCOMMADET3_ipd,RXENCOMMADET3,tipd_RXENCOMMADET3);
      VitalWireDelay (RXN0_ipd,RXN0,tipd_RXN0);
      VitalWireDelay (RXN1_ipd,RXN1,tipd_RXN1);
      VitalWireDelay (RXN2_ipd,RXN2,tipd_RXN2);
      VitalWireDelay (RXN3_ipd,RXN3,tipd_RXN3);
      VitalWireDelay (RXP0_ipd,RXP0,tipd_RXP0);
      VitalWireDelay (RXP1_ipd,RXP1,tipd_RXP1);
      VitalWireDelay (RXP2_ipd,RXP2,tipd_RXP2);
      VitalWireDelay (RXP3_ipd,RXP3,tipd_RXP3);
      VitalWireDelay (RXPOLARITY0_ipd,RXPOLARITY0,tipd_RXPOLARITY0);
      VitalWireDelay (RXPOLARITY1_ipd,RXPOLARITY1,tipd_RXPOLARITY1);
      VitalWireDelay (RXPOLARITY2_ipd,RXPOLARITY2,tipd_RXPOLARITY2);
      VitalWireDelay (RXPOLARITY3_ipd,RXPOLARITY3,tipd_RXPOLARITY3);
      VitalWireDelay (RXSLIP0_ipd,RXSLIP0,tipd_RXSLIP0);
      VitalWireDelay (RXSLIP1_ipd,RXSLIP1,tipd_RXSLIP1);
      VitalWireDelay (RXSLIP2_ipd,RXSLIP2,tipd_RXSLIP2);
      VitalWireDelay (RXSLIP3_ipd,RXSLIP3,tipd_RXSLIP3);
      VitalWireDelay (RXUSERCLKIN0_ipd,RXUSERCLKIN0,tipd_RXUSERCLKIN0);
      VitalWireDelay (RXUSERCLKIN1_ipd,RXUSERCLKIN1,tipd_RXUSERCLKIN1);
      VitalWireDelay (RXUSERCLKIN2_ipd,RXUSERCLKIN2,tipd_RXUSERCLKIN2);
      VitalWireDelay (RXUSERCLKIN3_ipd,RXUSERCLKIN3,tipd_RXUSERCLKIN3);
      VitalWireDelay (TXBUFRESET0_ipd,TXBUFRESET0,tipd_TXBUFRESET0);
      VitalWireDelay (TXBUFRESET1_ipd,TXBUFRESET1,tipd_TXBUFRESET1);
      VitalWireDelay (TXBUFRESET2_ipd,TXBUFRESET2,tipd_TXBUFRESET2);
      VitalWireDelay (TXBUFRESET3_ipd,TXBUFRESET3,tipd_TXBUFRESET3);
      VitalWireDelay (TXDEEMPH0_ipd,TXDEEMPH0,tipd_TXDEEMPH0);
      VitalWireDelay (TXDEEMPH1_ipd,TXDEEMPH1,tipd_TXDEEMPH1);
      VitalWireDelay (TXDEEMPH2_ipd,TXDEEMPH2,tipd_TXDEEMPH2);
      VitalWireDelay (TXDEEMPH3_ipd,TXDEEMPH3,tipd_TXDEEMPH3);
      VitalWireDelay (TXUSERCLKIN0_ipd,TXUSERCLKIN0,tipd_TXUSERCLKIN0);
      VitalWireDelay (TXUSERCLKIN1_ipd,TXUSERCLKIN1,tipd_TXUSERCLKIN1);
      VitalWireDelay (TXUSERCLKIN2_ipd,TXUSERCLKIN2,tipd_TXUSERCLKIN2);
      VitalWireDelay (TXUSERCLKIN3_ipd,TXUSERCLKIN3,tipd_TXUSERCLKIN3);
    end block;
    
    SignalDelay : block
    begin
      DADDR_DCLK_DELAY : for i in 15 downto 0 generate
        VitalSignalDelay (DADDR_DCLK_dly(i),DADDR_ipd(i),tisd_DADDR_DCLK(i));
      end generate DADDR_DCLK_DELAY;
      DI_DCLK_DELAY : for i in 15 downto 0 generate
        VitalSignalDelay (DI_DCLK_dly(i),DI_ipd(i),tisd_DI_DCLK(i));
      end generate DI_DCLK_DELAY;
      MGMTPCSLANESEL_DCLK_DELAY : for i in 3 downto 0 generate
        VitalSignalDelay (MGMTPCSLANESEL_DCLK_dly(i),MGMTPCSLANESEL_ipd(i),tisd_MGMTPCSLANESEL_DCLK(i));
      end generate MGMTPCSLANESEL_DCLK_DELAY;
      MGMTPCSMMDADDR_DCLK_DELAY : for i in 4 downto 0 generate
        VitalSignalDelay (MGMTPCSMMDADDR_DCLK_dly(i),MGMTPCSMMDADDR_ipd(i),tisd_MGMTPCSMMDADDR_DCLK(i));
      end generate MGMTPCSMMDADDR_DCLK_DELAY;
      MGMTPCSREGADDR_DCLK_DELAY : for i in 15 downto 0 generate
        VitalSignalDelay (MGMTPCSREGADDR_DCLK_dly(i),MGMTPCSREGADDR_ipd(i),tisd_MGMTPCSREGADDR_DCLK(i));
      end generate MGMTPCSREGADDR_DCLK_DELAY;
      MGMTPCSWRDATA_DCLK_DELAY : for i in 15 downto 0 generate
        VitalSignalDelay (MGMTPCSWRDATA_DCLK_dly(i),MGMTPCSWRDATA_ipd(i),tisd_MGMTPCSWRDATA_DCLK(i));
      end generate MGMTPCSWRDATA_DCLK_DELAY;
      PLLPCSCLKDIV_DCLK_DELAY : for i in 5 downto 0 generate
        VitalSignalDelay (PLLPCSCLKDIV_DCLK_dly(i),PLLPCSCLKDIV_ipd(i),tisd_PLLPCSCLKDIV_DCLK(i));
      end generate PLLPCSCLKDIV_DCLK_DELAY;
      RXPOWERDOWN0_TXUSERCLKIN0_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (RXPOWERDOWN0_TXUSERCLKIN0_dly(i),RXPOWERDOWN0_ipd(i),tisd_RXPOWERDOWN0_TXUSERCLKIN0(i));
      end generate RXPOWERDOWN0_TXUSERCLKIN0_DELAY;
      RXPOWERDOWN1_TXUSERCLKIN1_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (RXPOWERDOWN1_TXUSERCLKIN1_dly(i),RXPOWERDOWN1_ipd(i),tisd_RXPOWERDOWN1_TXUSERCLKIN1(i));
      end generate RXPOWERDOWN1_TXUSERCLKIN1_DELAY;
      RXPOWERDOWN2_TXUSERCLKIN2_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (RXPOWERDOWN2_TXUSERCLKIN2_dly(i),RXPOWERDOWN2_ipd(i),tisd_RXPOWERDOWN2_TXUSERCLKIN2(i));
      end generate RXPOWERDOWN2_TXUSERCLKIN2_DELAY;
      RXPOWERDOWN3_TXUSERCLKIN3_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (RXPOWERDOWN3_TXUSERCLKIN3_dly(i),RXPOWERDOWN3_ipd(i),tisd_RXPOWERDOWN3_TXUSERCLKIN3(i));
      end generate RXPOWERDOWN3_TXUSERCLKIN3_DELAY;
      RXRATE0_TXUSERCLKIN0_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (RXRATE0_TXUSERCLKIN0_dly(i),RXRATE0_ipd(i),tisd_RXRATE0_TXUSERCLKIN0(i));
      end generate RXRATE0_TXUSERCLKIN0_DELAY;
      RXRATE1_TXUSERCLKIN1_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (RXRATE1_TXUSERCLKIN1_dly(i),RXRATE1_ipd(i),tisd_RXRATE1_TXUSERCLKIN1(i));
      end generate RXRATE1_TXUSERCLKIN1_DELAY;
      RXRATE2_TXUSERCLKIN2_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (RXRATE2_TXUSERCLKIN2_dly(i),RXRATE2_ipd(i),tisd_RXRATE2_TXUSERCLKIN2(i));
      end generate RXRATE2_TXUSERCLKIN2_DELAY;
      RXRATE3_TXUSERCLKIN3_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (RXRATE3_TXUSERCLKIN3_dly(i),RXRATE3_ipd(i),tisd_RXRATE3_TXUSERCLKIN3(i));
      end generate RXRATE3_TXUSERCLKIN3_DELAY;
      SAMPLERATE0_TXUSERCLKIN0_DELAY : for i in 2 downto 0 generate
        VitalSignalDelay (SAMPLERATE0_TXUSERCLKIN0_dly(i),SAMPLERATE0_ipd(i),tisd_SAMPLERATE0_TXUSERCLKIN0(i));
      end generate SAMPLERATE0_TXUSERCLKIN0_DELAY;
      SAMPLERATE1_TXUSERCLKIN1_DELAY : for i in 2 downto 0 generate
        VitalSignalDelay (SAMPLERATE1_TXUSERCLKIN1_dly(i),SAMPLERATE1_ipd(i),tisd_SAMPLERATE1_TXUSERCLKIN1(i));
      end generate SAMPLERATE1_TXUSERCLKIN1_DELAY;
      SAMPLERATE2_TXUSERCLKIN2_DELAY : for i in 2 downto 0 generate
        VitalSignalDelay (SAMPLERATE2_TXUSERCLKIN2_dly(i),SAMPLERATE2_ipd(i),tisd_SAMPLERATE2_TXUSERCLKIN2(i));
      end generate SAMPLERATE2_TXUSERCLKIN2_DELAY;
      SAMPLERATE3_TXUSERCLKIN3_DELAY : for i in 2 downto 0 generate
        VitalSignalDelay (SAMPLERATE3_TXUSERCLKIN3_dly(i),SAMPLERATE3_ipd(i),tisd_SAMPLERATE3_TXUSERCLKIN3(i));
      end generate SAMPLERATE3_TXUSERCLKIN3_DELAY;
      TXCTRL0_TXUSERCLKIN0_DELAY : for i in 7 downto 0 generate
        VitalSignalDelay (TXCTRL0_TXUSERCLKIN0_dly(i),TXCTRL0_ipd(i),tisd_TXCTRL0_TXUSERCLKIN0(i));
      end generate TXCTRL0_TXUSERCLKIN0_DELAY;
      TXCTRL1_TXUSERCLKIN1_DELAY : for i in 7 downto 0 generate
        VitalSignalDelay (TXCTRL1_TXUSERCLKIN1_dly(i),TXCTRL1_ipd(i),tisd_TXCTRL1_TXUSERCLKIN1(i));
      end generate TXCTRL1_TXUSERCLKIN1_DELAY;
      TXCTRL2_TXUSERCLKIN2_DELAY : for i in 7 downto 0 generate
        VitalSignalDelay (TXCTRL2_TXUSERCLKIN2_dly(i),TXCTRL2_ipd(i),tisd_TXCTRL2_TXUSERCLKIN2(i));
      end generate TXCTRL2_TXUSERCLKIN2_DELAY;
      TXCTRL3_TXUSERCLKIN3_DELAY : for i in 7 downto 0 generate
        VitalSignalDelay (TXCTRL3_TXUSERCLKIN3_dly(i),TXCTRL3_ipd(i),tisd_TXCTRL3_TXUSERCLKIN3(i));
      end generate TXCTRL3_TXUSERCLKIN3_DELAY;
      TXDATA0_TXUSERCLKIN0_DELAY : for i in 63 downto 0 generate
        VitalSignalDelay (TXDATA0_TXUSERCLKIN0_dly(i),TXDATA0_ipd(i),tisd_TXDATA0_TXUSERCLKIN0(i));
      end generate TXDATA0_TXUSERCLKIN0_DELAY;
      TXDATA1_TXUSERCLKIN1_DELAY : for i in 63 downto 0 generate
        VitalSignalDelay (TXDATA1_TXUSERCLKIN1_dly(i),TXDATA1_ipd(i),tisd_TXDATA1_TXUSERCLKIN1(i));
      end generate TXDATA1_TXUSERCLKIN1_DELAY;
      TXDATA2_TXUSERCLKIN2_DELAY : for i in 63 downto 0 generate
        VitalSignalDelay (TXDATA2_TXUSERCLKIN2_dly(i),TXDATA2_ipd(i),tisd_TXDATA2_TXUSERCLKIN2(i));
      end generate TXDATA2_TXUSERCLKIN2_DELAY;
      TXDATA3_TXUSERCLKIN3_DELAY : for i in 63 downto 0 generate
        VitalSignalDelay (TXDATA3_TXUSERCLKIN3_dly(i),TXDATA3_ipd(i),tisd_TXDATA3_TXUSERCLKIN3(i));
      end generate TXDATA3_TXUSERCLKIN3_DELAY;
      TXDATAMSB0_TXUSERCLKIN0_DELAY : for i in 7 downto 0 generate
        VitalSignalDelay (TXDATAMSB0_TXUSERCLKIN0_dly(i),TXDATAMSB0_ipd(i),tisd_TXDATAMSB0_TXUSERCLKIN0(i));
      end generate TXDATAMSB0_TXUSERCLKIN0_DELAY;
      TXDATAMSB1_TXUSERCLKIN1_DELAY : for i in 7 downto 0 generate
        VitalSignalDelay (TXDATAMSB1_TXUSERCLKIN1_dly(i),TXDATAMSB1_ipd(i),tisd_TXDATAMSB1_TXUSERCLKIN1(i));
      end generate TXDATAMSB1_TXUSERCLKIN1_DELAY;
      TXDATAMSB2_TXUSERCLKIN2_DELAY : for i in 7 downto 0 generate
        VitalSignalDelay (TXDATAMSB2_TXUSERCLKIN2_dly(i),TXDATAMSB2_ipd(i),tisd_TXDATAMSB2_TXUSERCLKIN2(i));
      end generate TXDATAMSB2_TXUSERCLKIN2_DELAY;
      TXDATAMSB3_TXUSERCLKIN3_DELAY : for i in 7 downto 0 generate
        VitalSignalDelay (TXDATAMSB3_TXUSERCLKIN3_dly(i),TXDATAMSB3_ipd(i),tisd_TXDATAMSB3_TXUSERCLKIN3(i));
      end generate TXDATAMSB3_TXUSERCLKIN3_DELAY;
      TXMARGIN0_TXUSERCLKIN0_DELAY : for i in 2 downto 0 generate
        VitalSignalDelay (TXMARGIN0_TXUSERCLKIN0_dly(i),TXMARGIN0_ipd(i),tisd_TXMARGIN0_TXUSERCLKIN0(i));
      end generate TXMARGIN0_TXUSERCLKIN0_DELAY;
      TXMARGIN1_TXUSERCLKIN1_DELAY : for i in 2 downto 0 generate
        VitalSignalDelay (TXMARGIN1_TXUSERCLKIN1_dly(i),TXMARGIN1_ipd(i),tisd_TXMARGIN1_TXUSERCLKIN1(i));
      end generate TXMARGIN1_TXUSERCLKIN1_DELAY;
      TXMARGIN2_TXUSERCLKIN2_DELAY : for i in 2 downto 0 generate
        VitalSignalDelay (TXMARGIN2_TXUSERCLKIN2_dly(i),TXMARGIN2_ipd(i),tisd_TXMARGIN2_TXUSERCLKIN2(i));
      end generate TXMARGIN2_TXUSERCLKIN2_DELAY;
      TXMARGIN3_TXUSERCLKIN3_DELAY : for i in 2 downto 0 generate
        VitalSignalDelay (TXMARGIN3_TXUSERCLKIN3_dly(i),TXMARGIN3_ipd(i),tisd_TXMARGIN3_TXUSERCLKIN3(i));
      end generate TXMARGIN3_TXUSERCLKIN3_DELAY;
      TXPOWERDOWN0_TXUSERCLKIN0_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (TXPOWERDOWN0_TXUSERCLKIN0_dly(i),TXPOWERDOWN0_ipd(i),tisd_TXPOWERDOWN0_TXUSERCLKIN0(i));
      end generate TXPOWERDOWN0_TXUSERCLKIN0_DELAY;
      TXPOWERDOWN1_TXUSERCLKIN1_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (TXPOWERDOWN1_TXUSERCLKIN1_dly(i),TXPOWERDOWN1_ipd(i),tisd_TXPOWERDOWN1_TXUSERCLKIN1(i));
      end generate TXPOWERDOWN1_TXUSERCLKIN1_DELAY;
      TXPOWERDOWN2_TXUSERCLKIN2_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (TXPOWERDOWN2_TXUSERCLKIN2_dly(i),TXPOWERDOWN2_ipd(i),tisd_TXPOWERDOWN2_TXUSERCLKIN2(i));
      end generate TXPOWERDOWN2_TXUSERCLKIN2_DELAY;
      TXPOWERDOWN3_TXUSERCLKIN3_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (TXPOWERDOWN3_TXUSERCLKIN3_dly(i),TXPOWERDOWN3_ipd(i),tisd_TXPOWERDOWN3_TXUSERCLKIN3(i));
      end generate TXPOWERDOWN3_TXUSERCLKIN3_DELAY;
      TXRATE0_TXUSERCLKIN0_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (TXRATE0_TXUSERCLKIN0_dly(i),TXRATE0_ipd(i),tisd_TXRATE0_TXUSERCLKIN0(i));
      end generate TXRATE0_TXUSERCLKIN0_DELAY;
      TXRATE1_TXUSERCLKIN1_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (TXRATE1_TXUSERCLKIN1_dly(i),TXRATE1_ipd(i),tisd_TXRATE1_TXUSERCLKIN1(i));
      end generate TXRATE1_TXUSERCLKIN1_DELAY;
      TXRATE2_TXUSERCLKIN2_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (TXRATE2_TXUSERCLKIN2_dly(i),TXRATE2_ipd(i),tisd_TXRATE2_TXUSERCLKIN2(i));
      end generate TXRATE2_TXUSERCLKIN2_DELAY;
      TXRATE3_TXUSERCLKIN3_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (TXRATE3_TXUSERCLKIN3_dly(i),TXRATE3_ipd(i),tisd_TXRATE3_TXUSERCLKIN3(i));
      end generate TXRATE3_TXUSERCLKIN3_DELAY;
      VitalSignalDelay (DEN_DCLK_dly,DEN_ipd,tisd_DEN_DCLK);
      VitalSignalDelay (DFETRAINCTRL0_DCLK_dly,DFETRAINCTRL0_ipd,tisd_DFETRAINCTRL0_DCLK);
      VitalSignalDelay (DFETRAINCTRL1_DCLK_dly,DFETRAINCTRL1_ipd,tisd_DFETRAINCTRL1_DCLK);
      VitalSignalDelay (DFETRAINCTRL2_DCLK_dly,DFETRAINCTRL2_ipd,tisd_DFETRAINCTRL2_DCLK);
      VitalSignalDelay (DFETRAINCTRL3_DCLK_dly,DFETRAINCTRL3_ipd,tisd_DFETRAINCTRL3_DCLK);
      VitalSignalDelay (DISABLEDRP_DCLK_dly,DISABLEDRP_ipd,tisd_DISABLEDRP_DCLK);
      VitalSignalDelay (DWE_DCLK_dly,DWE_ipd,tisd_DWE_DCLK);
      VitalSignalDelay (GTHINIT_DCLK_dly,GTHINIT_ipd,tisd_GTHINIT_DCLK);
      VitalSignalDelay (MGMTPCSREGRD_DCLK_dly,MGMTPCSREGRD_ipd,tisd_MGMTPCSREGRD_DCLK);
      VitalSignalDelay (MGMTPCSREGWR_DCLK_dly,MGMTPCSREGWR_ipd,tisd_MGMTPCSREGWR_DCLK);
      VitalSignalDelay (RXBUFRESET0_RXUSERCLKIN0_dly,RXBUFRESET0_ipd,tisd_RXBUFRESET0_RXUSERCLKIN0);
      VitalSignalDelay (RXBUFRESET1_RXUSERCLKIN1_dly,RXBUFRESET1_ipd,tisd_RXBUFRESET1_RXUSERCLKIN1);
      VitalSignalDelay (RXBUFRESET2_RXUSERCLKIN2_dly,RXBUFRESET2_ipd,tisd_RXBUFRESET2_RXUSERCLKIN2);
      VitalSignalDelay (RXBUFRESET3_RXUSERCLKIN3_dly,RXBUFRESET3_ipd,tisd_RXBUFRESET3_RXUSERCLKIN3);
      VitalSignalDelay (RXENCOMMADET0_RXUSERCLKIN0_dly,RXENCOMMADET0_ipd,tisd_RXENCOMMADET0_RXUSERCLKIN0);
      VitalSignalDelay (RXENCOMMADET1_RXUSERCLKIN1_dly,RXENCOMMADET1_ipd,tisd_RXENCOMMADET1_RXUSERCLKIN1);
      VitalSignalDelay (RXENCOMMADET2_RXUSERCLKIN2_dly,RXENCOMMADET2_ipd,tisd_RXENCOMMADET2_RXUSERCLKIN2);
      VitalSignalDelay (RXENCOMMADET3_RXUSERCLKIN3_dly,RXENCOMMADET3_ipd,tisd_RXENCOMMADET3_RXUSERCLKIN3);
      VitalSignalDelay (RXPOLARITY0_RXUSERCLKIN0_dly,RXPOLARITY0_ipd,tisd_RXPOLARITY0_RXUSERCLKIN0);
      VitalSignalDelay (RXPOLARITY1_RXUSERCLKIN1_dly,RXPOLARITY1_ipd,tisd_RXPOLARITY1_RXUSERCLKIN1);
      VitalSignalDelay (RXPOLARITY2_RXUSERCLKIN2_dly,RXPOLARITY2_ipd,tisd_RXPOLARITY2_RXUSERCLKIN2);
      VitalSignalDelay (RXPOLARITY3_RXUSERCLKIN3_dly,RXPOLARITY3_ipd,tisd_RXPOLARITY3_RXUSERCLKIN3);
      VitalSignalDelay (TXBUFRESET0_TXUSERCLKIN0_dly,TXBUFRESET0_ipd,tisd_TXBUFRESET0_TXUSERCLKIN0);
      VitalSignalDelay (TXBUFRESET1_TXUSERCLKIN1_dly,TXBUFRESET1_ipd,tisd_TXBUFRESET1_TXUSERCLKIN1);
      VitalSignalDelay (TXBUFRESET2_TXUSERCLKIN2_dly,TXBUFRESET2_ipd,tisd_TXBUFRESET2_TXUSERCLKIN2);
      VitalSignalDelay (TXBUFRESET3_TXUSERCLKIN3_dly,TXBUFRESET3_ipd,tisd_TXBUFRESET3_TXUSERCLKIN3);
      VitalSignalDelay (TXDEEMPH0_TXUSERCLKIN0_dly,TXDEEMPH0_ipd,tisd_TXDEEMPH0_TXUSERCLKIN0);
      VitalSignalDelay (TXDEEMPH1_TXUSERCLKIN1_dly,TXDEEMPH1_ipd,tisd_TXDEEMPH1_TXUSERCLKIN1);
      VitalSignalDelay (TXDEEMPH2_TXUSERCLKIN2_dly,TXDEEMPH2_ipd,tisd_TXDEEMPH2_TXUSERCLKIN2);
      VitalSignalDelay (TXDEEMPH3_TXUSERCLKIN3_dly,TXDEEMPH3_ipd,tisd_TXDEEMPH3_TXUSERCLKIN3);

      VitalSignalDelay (DCLK_dly,DCLK_ipd,ticd_DCLK);
      VitalSignalDelay (REFCLK_dly,REFCLK_ipd,ticd_REFCLK);
      VitalSignalDelay (RXUSERCLKIN0_dly,RXUSERCLKIN0_ipd,ticd_RXUSERCLKIN0);
      VitalSignalDelay (RXUSERCLKIN1_dly,RXUSERCLKIN1_ipd,ticd_RXUSERCLKIN1);
      VitalSignalDelay (RXUSERCLKIN2_dly,RXUSERCLKIN2_ipd,ticd_RXUSERCLKIN2);
      VitalSignalDelay (RXUSERCLKIN3_dly,RXUSERCLKIN3_ipd,ticd_RXUSERCLKIN3);
      VitalSignalDelay (TXUSERCLKIN0_dly,TXUSERCLKIN0_ipd,ticd_TXUSERCLKIN0);
      VitalSignalDelay (TXUSERCLKIN1_dly,TXUSERCLKIN1_ipd,ticd_TXUSERCLKIN1);
      VitalSignalDelay (TXUSERCLKIN2_dly,TXUSERCLKIN2_ipd,ticd_TXUSERCLKIN2);
      VitalSignalDelay (TXUSERCLKIN3_dly,TXUSERCLKIN3_ipd,ticd_TXUSERCLKIN3);
    end block;
  --Input ports sensitive to single clock
  DADDR_indelay <= DADDR_DCLK_dly;
  DEN_indelay <= DEN_DCLK_dly;
  DFETRAINCTRL0_indelay <= DFETRAINCTRL0_DCLK_dly;
  DFETRAINCTRL1_indelay <= DFETRAINCTRL1_DCLK_dly;
  DFETRAINCTRL2_indelay <= DFETRAINCTRL2_DCLK_dly;
  DFETRAINCTRL3_indelay <= DFETRAINCTRL3_DCLK_dly;
  DISABLEDRP_indelay <= DISABLEDRP_DCLK_dly;
  DI_indelay <= DI_DCLK_dly;
  DWE_indelay <= DWE_DCLK_dly;
  GTHINIT_indelay <= GTHINIT_DCLK_dly;
  MGMTPCSLANESEL_indelay <= MGMTPCSLANESEL_DCLK_dly;
  MGMTPCSMMDADDR_indelay <= MGMTPCSMMDADDR_DCLK_dly;
  MGMTPCSREGADDR_indelay <= MGMTPCSREGADDR_DCLK_dly;
  MGMTPCSREGRD_indelay <= MGMTPCSREGRD_DCLK_dly;
  MGMTPCSREGWR_indelay <= MGMTPCSREGWR_DCLK_dly;
  MGMTPCSWRDATA_indelay <= MGMTPCSWRDATA_DCLK_dly;
  PLLPCSCLKDIV_indelay <= PLLPCSCLKDIV_DCLK_dly;
  RXBUFRESET0_indelay <= RXBUFRESET0_RXUSERCLKIN0_dly;
  RXBUFRESET1_indelay <= RXBUFRESET1_RXUSERCLKIN1_dly;
  RXBUFRESET2_indelay <= RXBUFRESET2_RXUSERCLKIN2_dly;
  RXBUFRESET3_indelay <= RXBUFRESET3_RXUSERCLKIN3_dly;
  RXENCOMMADET0_indelay <= RXENCOMMADET0_RXUSERCLKIN0_dly;
  RXENCOMMADET1_indelay <= RXENCOMMADET1_RXUSERCLKIN1_dly;
  RXENCOMMADET2_indelay <= RXENCOMMADET2_RXUSERCLKIN2_dly;
  RXENCOMMADET3_indelay <= RXENCOMMADET3_RXUSERCLKIN3_dly;
  RXPOLARITY0_indelay <= RXPOLARITY0_RXUSERCLKIN0_dly;
  RXPOLARITY1_indelay <= RXPOLARITY1_RXUSERCLKIN1_dly;
  RXPOLARITY2_indelay <= RXPOLARITY2_RXUSERCLKIN2_dly;
  RXPOLARITY3_indelay <= RXPOLARITY3_RXUSERCLKIN3_dly;
  RXPOWERDOWN0_indelay <= RXPOWERDOWN0_TXUSERCLKIN0_dly;
  RXPOWERDOWN1_indelay <= RXPOWERDOWN1_TXUSERCLKIN1_dly;
  RXPOWERDOWN2_indelay <= RXPOWERDOWN2_TXUSERCLKIN2_dly;
  RXPOWERDOWN3_indelay <= RXPOWERDOWN3_TXUSERCLKIN3_dly;
  RXRATE0_indelay <= RXRATE0_TXUSERCLKIN0_dly;
  RXRATE1_indelay <= RXRATE1_TXUSERCLKIN1_dly;
  RXRATE2_indelay <= RXRATE2_TXUSERCLKIN2_dly;
  RXRATE3_indelay <= RXRATE3_TXUSERCLKIN3_dly;
  SAMPLERATE0_indelay <= SAMPLERATE0_TXUSERCLKIN0_dly;
  SAMPLERATE1_indelay <= SAMPLERATE1_TXUSERCLKIN1_dly;
  SAMPLERATE2_indelay <= SAMPLERATE2_TXUSERCLKIN2_dly;
  SAMPLERATE3_indelay <= SAMPLERATE3_TXUSERCLKIN3_dly;
  TXBUFRESET0_indelay <= TXBUFRESET0_TXUSERCLKIN0_dly;
  TXBUFRESET1_indelay <= TXBUFRESET1_TXUSERCLKIN1_dly;
  TXBUFRESET2_indelay <= TXBUFRESET2_TXUSERCLKIN2_dly;
  TXBUFRESET3_indelay <= TXBUFRESET3_TXUSERCLKIN3_dly;
  TXCTRL0_indelay <= TXCTRL0_TXUSERCLKIN0_dly;
  TXCTRL1_indelay <= TXCTRL1_TXUSERCLKIN1_dly;
  TXCTRL2_indelay <= TXCTRL2_TXUSERCLKIN2_dly;
  TXCTRL3_indelay <= TXCTRL3_TXUSERCLKIN3_dly;
  TXDATA0_indelay <= TXDATA0_TXUSERCLKIN0_dly;
  TXDATA1_indelay <= TXDATA1_TXUSERCLKIN1_dly;
  TXDATA2_indelay <= TXDATA2_TXUSERCLKIN2_dly;
  TXDATA3_indelay <= TXDATA3_TXUSERCLKIN3_dly;
  TXDATAMSB0_indelay <= TXDATAMSB0_TXUSERCLKIN0_dly;
  TXDATAMSB1_indelay <= TXDATAMSB1_TXUSERCLKIN1_dly;
  TXDATAMSB2_indelay <= TXDATAMSB2_TXUSERCLKIN2_dly;
  TXDATAMSB3_indelay <= TXDATAMSB3_TXUSERCLKIN3_dly;
  TXDEEMPH0_indelay <= TXDEEMPH0_TXUSERCLKIN0_dly;
  TXDEEMPH1_indelay <= TXDEEMPH1_TXUSERCLKIN1_dly;
  TXDEEMPH2_indelay <= TXDEEMPH2_TXUSERCLKIN2_dly;
  TXDEEMPH3_indelay <= TXDEEMPH3_TXUSERCLKIN3_dly;
  TXMARGIN0_indelay <= TXMARGIN0_TXUSERCLKIN0_dly;
  TXMARGIN1_indelay <= TXMARGIN1_TXUSERCLKIN1_dly;
  TXMARGIN2_indelay <= TXMARGIN2_TXUSERCLKIN2_dly;
  TXMARGIN3_indelay <= TXMARGIN3_TXUSERCLKIN3_dly;
  TXPOWERDOWN0_indelay <= TXPOWERDOWN0_TXUSERCLKIN0_dly;
  TXPOWERDOWN1_indelay <= TXPOWERDOWN1_TXUSERCLKIN1_dly;
  TXPOWERDOWN2_indelay <= TXPOWERDOWN2_TXUSERCLKIN2_dly;
  TXPOWERDOWN3_indelay <= TXPOWERDOWN3_TXUSERCLKIN3_dly;
  TXRATE0_indelay <= TXRATE0_TXUSERCLKIN0_dly;
  TXRATE1_indelay <= TXRATE1_TXUSERCLKIN1_dly;
  TXRATE2_indelay <= TXRATE2_TXUSERCLKIN2_dly;
  TXRATE3_indelay <= TXRATE3_TXUSERCLKIN3_dly;
  
  --Input ports sensitive to more than two clocks
  GTHRESET_indelay <= GTHRESET_ipd;
  GTHX2LANE01_indelay <= GTHX2LANE01_ipd;
  GTHX2LANE23_indelay <= GTHX2LANE23_ipd;
  GTHX4LANE_indelay <= GTHX4LANE_ipd;
  PLLREFCLKSEL_indelay <= PLLREFCLKSEL_ipd; 
  POWERDOWN0_indelay <= POWERDOWN0_ipd;
  POWERDOWN1_indelay <= POWERDOWN1_ipd;
  POWERDOWN2_indelay <= POWERDOWN2_ipd;
  POWERDOWN3_indelay <= POWERDOWN3_ipd;
  RXN0_indelay <= RXN0_ipd;
  RXN1_indelay <= RXN1_ipd;
  RXN2_indelay <= RXN2_ipd;
  RXN3_indelay <= RXN3_ipd;
  RXP0_indelay <= RXP0_ipd;
  RXP1_indelay <= RXP1_ipd;
  RXP2_indelay <= RXP2_ipd;
  RXP3_indelay <= RXP3_ipd;
  RXSLIP0_indelay <= RXSLIP0_ipd;
  RXSLIP1_indelay <= RXSLIP1_ipd;
  RXSLIP2_indelay <= RXSLIP2_ipd;
  RXSLIP3_indelay <= RXSLIP3_ipd;
      
  DCLK_indelay <= DCLK_dly;
  REFCLK_indelay <= REFCLK_dly;
  RXUSERCLKIN0_indelay <= RXUSERCLKIN0_dly;
  RXUSERCLKIN1_indelay <= RXUSERCLKIN1_dly;
  RXUSERCLKIN2_indelay <= RXUSERCLKIN2_dly;
  RXUSERCLKIN3_indelay <= RXUSERCLKIN3_dly;
  TXUSERCLKIN0_indelay <= TXUSERCLKIN0_dly;
  TXUSERCLKIN1_indelay <= TXUSERCLKIN1_dly;
  TXUSERCLKIN2_indelay <= TXUSERCLKIN2_dly;
  TXUSERCLKIN3_indelay <= TXUSERCLKIN3_dly;
  
  RXUSERCLKOUT0_out <= RXUSERCLKOUT0_outdelay after OUTCLK_DELAY;
  RXUSERCLKOUT1_out <= RXUSERCLKOUT1_outdelay after OUTCLK_DELAY;
  RXUSERCLKOUT2_out <= RXUSERCLKOUT2_outdelay after OUTCLK_DELAY;
  RXUSERCLKOUT3_out <= RXUSERCLKOUT3_outdelay after OUTCLK_DELAY;
  TSTPATH_out <= TSTPATH_outdelay after OUTCLK_DELAY;
  TSTREFCLKFAB_out <= TSTREFCLKFAB_outdelay after OUTCLK_DELAY;
  TSTREFCLKOUT_out <= TSTREFCLKOUT_outdelay after OUTCLK_DELAY;
  TXUSERCLKOUT0_out <= TXUSERCLKOUT0_outdelay after OUTCLK_DELAY;
  TXUSERCLKOUT1_out <= TXUSERCLKOUT1_outdelay after OUTCLK_DELAY;
  TXUSERCLKOUT2_out <= TXUSERCLKOUT2_outdelay after OUTCLK_DELAY;
  TXUSERCLKOUT3_out <= TXUSERCLKOUT3_outdelay after OUTCLK_DELAY;

  DRDY_out <= DRDY_outdelay after OUT_DELAY;
  DRPDO_out <= DRPDO_outdelay after OUT_DELAY;
  GTHINITDONE_out <= GTHINITDONE_outdelay after OUT_DELAY;
  MGMTPCSRDACK_out <= MGMTPCSRDACK_outdelay after OUT_DELAY;
  MGMTPCSRDDATA_out <= MGMTPCSRDDATA_outdelay after OUT_DELAY;
  RXCODEERR0_out <= RXCODEERR0_outdelay after OUT_DELAY;
  RXCODEERR1_out <= RXCODEERR1_outdelay after OUT_DELAY;
  RXCODEERR2_out <= RXCODEERR2_outdelay after OUT_DELAY;
  RXCODEERR3_out <= RXCODEERR3_outdelay after OUT_DELAY;
  RXCTRL0_out <= RXCTRL0_outdelay after OUT_DELAY;
  RXCTRL1_out <= RXCTRL1_outdelay after OUT_DELAY;
  RXCTRL2_out <= RXCTRL2_outdelay after OUT_DELAY;
  RXCTRL3_out <= RXCTRL3_outdelay after OUT_DELAY;
  RXCTRLACK0_out <= RXCTRLACK0_outdelay after OUT_DELAY;
  RXCTRLACK1_out <= RXCTRLACK1_outdelay after OUT_DELAY;
  RXCTRLACK2_out <= RXCTRLACK2_outdelay after OUT_DELAY;
  RXCTRLACK3_out <= RXCTRLACK3_outdelay after OUT_DELAY;
  RXDATA0_out <= RXDATA0_outdelay after OUT_DELAY;
  RXDATA1_out <= RXDATA1_outdelay after OUT_DELAY;
  RXDATA2_out <= RXDATA2_outdelay after OUT_DELAY;
  RXDATA3_out <= RXDATA3_outdelay after OUT_DELAY;
  RXDATATAP0_out <= RXDATATAP0_outdelay after OUT_DELAY;
  RXDATATAP1_out <= RXDATATAP1_outdelay after OUT_DELAY;
  RXDATATAP2_out <= RXDATATAP2_outdelay after OUT_DELAY;
  RXDATATAP3_out <= RXDATATAP3_outdelay after OUT_DELAY;
  RXDISPERR0_out <= RXDISPERR0_outdelay after OUT_DELAY;
  RXDISPERR1_out <= RXDISPERR1_outdelay after OUT_DELAY;
  RXDISPERR2_out <= RXDISPERR2_outdelay after OUT_DELAY;
  RXDISPERR3_out <= RXDISPERR3_outdelay after OUT_DELAY;
  RXPCSCLKSMPL0_out <= RXPCSCLKSMPL0_outdelay after OUT_DELAY;
  RXPCSCLKSMPL1_out <= RXPCSCLKSMPL1_outdelay after OUT_DELAY;
  RXPCSCLKSMPL2_out <= RXPCSCLKSMPL2_outdelay after OUT_DELAY;
  RXPCSCLKSMPL3_out <= RXPCSCLKSMPL3_outdelay after OUT_DELAY;
  RXVALID0_out <= RXVALID0_outdelay after OUT_DELAY;
  RXVALID1_out <= RXVALID1_outdelay after OUT_DELAY;
  RXVALID2_out <= RXVALID2_outdelay after OUT_DELAY;
  RXVALID3_out <= RXVALID3_outdelay after OUT_DELAY;
  TXCTRLACK0_out <= TXCTRLACK0_outdelay after OUT_DELAY;
  TXCTRLACK1_out <= TXCTRLACK1_outdelay after OUT_DELAY;
  TXCTRLACK2_out <= TXCTRLACK2_outdelay after OUT_DELAY;
  TXCTRLACK3_out <= TXCTRLACK3_outdelay after OUT_DELAY;
  TXDATATAP10_out <= TXDATATAP10_outdelay after OUT_DELAY;
  TXDATATAP11_out <= TXDATATAP11_outdelay after OUT_DELAY;
  TXDATATAP12_out <= TXDATATAP12_outdelay after OUT_DELAY;
  TXDATATAP13_out <= TXDATATAP13_outdelay after OUT_DELAY;
  TXDATATAP20_out <= TXDATATAP20_outdelay after OUT_DELAY;
  TXDATATAP21_out <= TXDATATAP21_outdelay after OUT_DELAY;
  TXDATATAP22_out <= TXDATATAP22_outdelay after OUT_DELAY;
  TXDATATAP23_out <= TXDATATAP23_outdelay after OUT_DELAY;
  TXN0_out <= TXN0_outdelay after OUT_DELAY;
  TXN1_out <= TXN1_outdelay after OUT_DELAY;
  TXN2_out <= TXN2_outdelay after OUT_DELAY;
  TXN3_out <= TXN3_outdelay after OUT_DELAY;
  TXP0_out <= TXP0_outdelay after OUT_DELAY;
  TXP1_out <= TXP1_outdelay after OUT_DELAY;
  TXP2_out <= TXP2_outdelay after OUT_DELAY;
  TXP3_out <= TXP3_outdelay after OUT_DELAY;
  TXPCSCLKSMPL0_out <= TXPCSCLKSMPL0_outdelay after OUT_DELAY;
  TXPCSCLKSMPL1_out <= TXPCSCLKSMPL1_outdelay after OUT_DELAY;
  TXPCSCLKSMPL2_out <= TXPCSCLKSMPL2_outdelay after OUT_DELAY;
  TXPCSCLKSMPL3_out <= TXPCSCLKSMPL3_outdelay after OUT_DELAY;
    
  DCLK_indly <= DCLK_indelay after INCLK_DELAY;
  REFCLK_indly <= REFCLK_indelay after INCLK_DELAY;
  RXUSERCLKIN0_indly <= RXUSERCLKIN0_indelay after INCLK_DELAY;
  RXUSERCLKIN1_indly <= RXUSERCLKIN1_indelay after INCLK_DELAY;
  RXUSERCLKIN2_indly <= RXUSERCLKIN2_indelay after INCLK_DELAY;
  RXUSERCLKIN3_indly <= RXUSERCLKIN3_indelay after INCLK_DELAY;
  TXUSERCLKIN0_indly <= TXUSERCLKIN0_indelay after INCLK_DELAY;
  TXUSERCLKIN1_indly <= TXUSERCLKIN1_indelay after INCLK_DELAY;
  TXUSERCLKIN2_indly <= TXUSERCLKIN2_indelay after INCLK_DELAY;
  TXUSERCLKIN3_indly <= TXUSERCLKIN3_indelay after INCLK_DELAY;
  
  DADDR_indly <= DADDR_indelay after IN_DELAY;
  DEN_indly <= DEN_indelay after IN_DELAY;
  DFETRAINCTRL0_indly <= DFETRAINCTRL0_indelay after IN_DELAY;
  DFETRAINCTRL1_indly <= DFETRAINCTRL1_indelay after IN_DELAY;
  DFETRAINCTRL2_indly <= DFETRAINCTRL2_indelay after IN_DELAY;
  DFETRAINCTRL3_indly <= DFETRAINCTRL3_indelay after IN_DELAY;
  DISABLEDRP_indly <= DISABLEDRP_indelay after IN_DELAY;
  DI_indly <= DI_indelay after IN_DELAY;
  DWE_indly <= DWE_indelay after IN_DELAY;
  GTHINIT_indly <= GTHINIT_indelay after IN_DELAY;
  GTHRESET_indly <= GTHRESET_indelay after IN_DELAY;
  GTHX2LANE01_indly <= GTHX2LANE01_indelay after IN_DELAY;
  GTHX2LANE23_indly <= GTHX2LANE23_indelay after IN_DELAY;
  GTHX4LANE_indly <= GTHX4LANE_indelay after IN_DELAY;
  MGMTPCSLANESEL_indly <= MGMTPCSLANESEL_indelay after IN_DELAY;
  MGMTPCSMMDADDR_indly <= MGMTPCSMMDADDR_indelay after IN_DELAY;
  MGMTPCSREGADDR_indly <= MGMTPCSREGADDR_indelay after IN_DELAY;
  MGMTPCSREGRD_indly <= MGMTPCSREGRD_indelay after IN_DELAY;
  MGMTPCSREGWR_indly <= MGMTPCSREGWR_indelay after IN_DELAY;
  MGMTPCSWRDATA_indly <= MGMTPCSWRDATA_indelay after IN_DELAY;
  PLLPCSCLKDIV_indly <= PLLPCSCLKDIV_indelay after IN_DELAY;
  PLLREFCLKSEL_indly <= PLLREFCLKSEL_indelay after IN_DELAY;
  POWERDOWN0_indly <= POWERDOWN0_indelay after IN_DELAY;
  POWERDOWN1_indly <= POWERDOWN1_indelay after IN_DELAY;
  POWERDOWN2_indly <= POWERDOWN2_indelay after IN_DELAY;
  POWERDOWN3_indly <= POWERDOWN3_indelay after IN_DELAY;
  RXBUFRESET0_indly <= RXBUFRESET0_indelay after IN_DELAY;
  RXBUFRESET1_indly <= RXBUFRESET1_indelay after IN_DELAY;
  RXBUFRESET2_indly <= RXBUFRESET2_indelay after IN_DELAY;
  RXBUFRESET3_indly <= RXBUFRESET3_indelay after IN_DELAY;
  RXENCOMMADET0_indly <= RXENCOMMADET0_indelay after IN_DELAY;
  RXENCOMMADET1_indly <= RXENCOMMADET1_indelay after IN_DELAY;
  RXENCOMMADET2_indly <= RXENCOMMADET2_indelay after IN_DELAY;
  RXENCOMMADET3_indly <= RXENCOMMADET3_indelay after IN_DELAY;
  RXN0_indly <= RXN0_indelay after IN_DELAY;
  RXN1_indly <= RXN1_indelay after IN_DELAY;
  RXN2_indly <= RXN2_indelay after IN_DELAY;
  RXN3_indly <= RXN3_indelay after IN_DELAY;
  RXP0_indly <= RXP0_indelay after IN_DELAY;
  RXP1_indly <= RXP1_indelay after IN_DELAY;
  RXP2_indly <= RXP2_indelay after IN_DELAY;
  RXP3_indly <= RXP3_indelay after IN_DELAY;
  RXPOLARITY0_indly <= RXPOLARITY0_indelay after IN_DELAY;
  RXPOLARITY1_indly <= RXPOLARITY1_indelay after IN_DELAY;
  RXPOLARITY2_indly <= RXPOLARITY2_indelay after IN_DELAY;
  RXPOLARITY3_indly <= RXPOLARITY3_indelay after IN_DELAY;
  RXPOWERDOWN0_indly <= RXPOWERDOWN0_indelay after IN_DELAY;
  RXPOWERDOWN1_indly <= RXPOWERDOWN1_indelay after IN_DELAY;
  RXPOWERDOWN2_indly <= RXPOWERDOWN2_indelay after IN_DELAY;
  RXPOWERDOWN3_indly <= RXPOWERDOWN3_indelay after IN_DELAY;
  RXRATE0_indly <= RXRATE0_indelay after IN_DELAY;
  RXRATE1_indly <= RXRATE1_indelay after IN_DELAY;
  RXRATE2_indly <= RXRATE2_indelay after IN_DELAY;
  RXRATE3_indly <= RXRATE3_indelay after IN_DELAY;
  RXSLIP0_indly <= RXSLIP0_indelay after IN_DELAY;
  RXSLIP1_indly <= RXSLIP1_indelay after IN_DELAY;
  RXSLIP2_indly <= RXSLIP2_indelay after IN_DELAY;
  RXSLIP3_indly <= RXSLIP3_indelay after IN_DELAY;
  SAMPLERATE0_indly <= SAMPLERATE0_indelay after IN_DELAY;
  SAMPLERATE1_indly <= SAMPLERATE1_indelay after IN_DELAY;
  SAMPLERATE2_indly <= SAMPLERATE2_indelay after IN_DELAY;
  SAMPLERATE3_indly <= SAMPLERATE3_indelay after IN_DELAY;
  TXBUFRESET0_indly <= TXBUFRESET0_indelay after IN_DELAY;
  TXBUFRESET1_indly <= TXBUFRESET1_indelay after IN_DELAY;
  TXBUFRESET2_indly <= TXBUFRESET2_indelay after IN_DELAY;
  TXBUFRESET3_indly <= TXBUFRESET3_indelay after IN_DELAY;
  TXCTRL0_indly <= TXCTRL0_indelay after IN_DELAY;
  TXCTRL1_indly <= TXCTRL1_indelay after IN_DELAY;
  TXCTRL2_indly <= TXCTRL2_indelay after IN_DELAY;
  TXCTRL3_indly <= TXCTRL3_indelay after IN_DELAY;
  TXDATA0_indly <= TXDATA0_indelay after IN_DELAY;
  TXDATA1_indly <= TXDATA1_indelay after IN_DELAY;
  TXDATA2_indly <= TXDATA2_indelay after IN_DELAY;
  TXDATA3_indly <= TXDATA3_indelay after IN_DELAY;
  TXDATAMSB0_indly <= TXDATAMSB0_indelay after IN_DELAY;
  TXDATAMSB1_indly <= TXDATAMSB1_indelay after IN_DELAY;
  TXDATAMSB2_indly <= TXDATAMSB2_indelay after IN_DELAY;
  TXDATAMSB3_indly <= TXDATAMSB3_indelay after IN_DELAY;
  TXDEEMPH0_indly <= TXDEEMPH0_indelay after IN_DELAY;
  TXDEEMPH1_indly <= TXDEEMPH1_indelay after IN_DELAY;
  TXDEEMPH2_indly <= TXDEEMPH2_indelay after IN_DELAY;
  TXDEEMPH3_indly <= TXDEEMPH3_indelay after IN_DELAY;
  TXMARGIN0_indly <= TXMARGIN0_indelay after IN_DELAY;
  TXMARGIN1_indly <= TXMARGIN1_indelay after IN_DELAY;
  TXMARGIN2_indly <= TXMARGIN2_indelay after IN_DELAY;
  TXMARGIN3_indly <= TXMARGIN3_indelay after IN_DELAY;
  TXPOWERDOWN0_indly <= TXPOWERDOWN0_indelay after IN_DELAY;
  TXPOWERDOWN1_indly <= TXPOWERDOWN1_indelay after IN_DELAY;
  TXPOWERDOWN2_indly <= TXPOWERDOWN2_indelay after IN_DELAY;
  TXPOWERDOWN3_indly <= TXPOWERDOWN3_indelay after IN_DELAY;
  TXRATE0_indly <= TXRATE0_indelay after IN_DELAY;
  TXRATE1_indly <= TXRATE1_indelay after IN_DELAY;
  TXRATE2_indly <= TXRATE2_indelay after IN_DELAY;
  TXRATE3_indly <= TXRATE3_indelay after IN_DELAY;
  
  -- <!--Aldec correction start
	GSR_local <= GSR;
-- Aldec correction end -->

  GTHE1_QUAD_INST : GTHE1_QUAD_WRAP
    generic map (
      BER_CONST_PTRN0      => BER_CONST_PTRN0_STRING,
      BER_CONST_PTRN1      => BER_CONST_PTRN1_STRING,
      BUFFER_CONFIG_LANE0  => BUFFER_CONFIG_LANE0_STRING,
      BUFFER_CONFIG_LANE1  => BUFFER_CONFIG_LANE1_STRING,
      BUFFER_CONFIG_LANE2  => BUFFER_CONFIG_LANE2_STRING,
      BUFFER_CONFIG_LANE3  => BUFFER_CONFIG_LANE3_STRING,
      DFE_TRAIN_CTRL_LANE0 => DFE_TRAIN_CTRL_LANE0_STRING,
      DFE_TRAIN_CTRL_LANE1 => DFE_TRAIN_CTRL_LANE1_STRING,
      DFE_TRAIN_CTRL_LANE2 => DFE_TRAIN_CTRL_LANE2_STRING,
      DFE_TRAIN_CTRL_LANE3 => DFE_TRAIN_CTRL_LANE3_STRING,
      DLL_CFG0             => DLL_CFG0_STRING,
      DLL_CFG1             => DLL_CFG1_STRING,
      E10GBASEKR_LD_COEFF_UPD_LANE0 => E10GBASEKR_LD_COEFF_UPD_LANE0_STRING,
      E10GBASEKR_LD_COEFF_UPD_LANE1 => E10GBASEKR_LD_COEFF_UPD_LANE1_STRING,
      E10GBASEKR_LD_COEFF_UPD_LANE2 => E10GBASEKR_LD_COEFF_UPD_LANE2_STRING,
      E10GBASEKR_LD_COEFF_UPD_LANE3 => E10GBASEKR_LD_COEFF_UPD_LANE3_STRING,
      E10GBASEKR_LP_COEFF_UPD_LANE0 => E10GBASEKR_LP_COEFF_UPD_LANE0_STRING,
      E10GBASEKR_LP_COEFF_UPD_LANE1 => E10GBASEKR_LP_COEFF_UPD_LANE1_STRING,
      E10GBASEKR_LP_COEFF_UPD_LANE2 => E10GBASEKR_LP_COEFF_UPD_LANE2_STRING,
      E10GBASEKR_LP_COEFF_UPD_LANE3 => E10GBASEKR_LP_COEFF_UPD_LANE3_STRING,
      E10GBASEKR_PMA_CTRL_LANE0 => E10GBASEKR_PMA_CTRL_LANE0_STRING,
      E10GBASEKR_PMA_CTRL_LANE1 => E10GBASEKR_PMA_CTRL_LANE1_STRING,
      E10GBASEKR_PMA_CTRL_LANE2 => E10GBASEKR_PMA_CTRL_LANE2_STRING,
      E10GBASEKR_PMA_CTRL_LANE3 => E10GBASEKR_PMA_CTRL_LANE3_STRING,
      E10GBASEKX_CTRL_LANE0 => E10GBASEKX_CTRL_LANE0_STRING,
      E10GBASEKX_CTRL_LANE1 => E10GBASEKX_CTRL_LANE1_STRING,
      E10GBASEKX_CTRL_LANE2 => E10GBASEKX_CTRL_LANE2_STRING,
      E10GBASEKX_CTRL_LANE3 => E10GBASEKX_CTRL_LANE3_STRING,
      E10GBASER_PCS_CFG_LANE0 => E10GBASER_PCS_CFG_LANE0_STRING,
      E10GBASER_PCS_CFG_LANE1 => E10GBASER_PCS_CFG_LANE1_STRING,
      E10GBASER_PCS_CFG_LANE2 => E10GBASER_PCS_CFG_LANE2_STRING,
      E10GBASER_PCS_CFG_LANE3 => E10GBASER_PCS_CFG_LANE3_STRING,
      E10GBASER_PCS_SEEDA0_LANE0 => E10GBASER_PCS_SEEDA0_LANE0_STRING,
      E10GBASER_PCS_SEEDA0_LANE1 => E10GBASER_PCS_SEEDA0_LANE1_STRING,
      E10GBASER_PCS_SEEDA0_LANE2 => E10GBASER_PCS_SEEDA0_LANE2_STRING,
      E10GBASER_PCS_SEEDA0_LANE3 => E10GBASER_PCS_SEEDA0_LANE3_STRING,
      E10GBASER_PCS_SEEDA1_LANE0 => E10GBASER_PCS_SEEDA1_LANE0_STRING,
      E10GBASER_PCS_SEEDA1_LANE1 => E10GBASER_PCS_SEEDA1_LANE1_STRING,
      E10GBASER_PCS_SEEDA1_LANE2 => E10GBASER_PCS_SEEDA1_LANE2_STRING,
      E10GBASER_PCS_SEEDA1_LANE3 => E10GBASER_PCS_SEEDA1_LANE3_STRING,
      E10GBASER_PCS_SEEDA2_LANE0 => E10GBASER_PCS_SEEDA2_LANE0_STRING,
      E10GBASER_PCS_SEEDA2_LANE1 => E10GBASER_PCS_SEEDA2_LANE1_STRING,
      E10GBASER_PCS_SEEDA2_LANE2 => E10GBASER_PCS_SEEDA2_LANE2_STRING,
      E10GBASER_PCS_SEEDA2_LANE3 => E10GBASER_PCS_SEEDA2_LANE3_STRING,
      E10GBASER_PCS_SEEDA3_LANE0 => E10GBASER_PCS_SEEDA3_LANE0_STRING,
      E10GBASER_PCS_SEEDA3_LANE1 => E10GBASER_PCS_SEEDA3_LANE1_STRING,
      E10GBASER_PCS_SEEDA3_LANE2 => E10GBASER_PCS_SEEDA3_LANE2_STRING,
      E10GBASER_PCS_SEEDA3_LANE3 => E10GBASER_PCS_SEEDA3_LANE3_STRING,
      E10GBASER_PCS_SEEDB0_LANE0 => E10GBASER_PCS_SEEDB0_LANE0_STRING,
      E10GBASER_PCS_SEEDB0_LANE1 => E10GBASER_PCS_SEEDB0_LANE1_STRING,
      E10GBASER_PCS_SEEDB0_LANE2 => E10GBASER_PCS_SEEDB0_LANE2_STRING,
      E10GBASER_PCS_SEEDB0_LANE3 => E10GBASER_PCS_SEEDB0_LANE3_STRING,
      E10GBASER_PCS_SEEDB1_LANE0 => E10GBASER_PCS_SEEDB1_LANE0_STRING,
      E10GBASER_PCS_SEEDB1_LANE1 => E10GBASER_PCS_SEEDB1_LANE1_STRING,
      E10GBASER_PCS_SEEDB1_LANE2 => E10GBASER_PCS_SEEDB1_LANE2_STRING,
      E10GBASER_PCS_SEEDB1_LANE3 => E10GBASER_PCS_SEEDB1_LANE3_STRING,
      E10GBASER_PCS_SEEDB2_LANE0 => E10GBASER_PCS_SEEDB2_LANE0_STRING,
      E10GBASER_PCS_SEEDB2_LANE1 => E10GBASER_PCS_SEEDB2_LANE1_STRING,
      E10GBASER_PCS_SEEDB2_LANE2 => E10GBASER_PCS_SEEDB2_LANE2_STRING,
      E10GBASER_PCS_SEEDB2_LANE3 => E10GBASER_PCS_SEEDB2_LANE3_STRING,
      E10GBASER_PCS_SEEDB3_LANE0 => E10GBASER_PCS_SEEDB3_LANE0_STRING,
      E10GBASER_PCS_SEEDB3_LANE1 => E10GBASER_PCS_SEEDB3_LANE1_STRING,
      E10GBASER_PCS_SEEDB3_LANE2 => E10GBASER_PCS_SEEDB3_LANE2_STRING,
      E10GBASER_PCS_SEEDB3_LANE3 => E10GBASER_PCS_SEEDB3_LANE3_STRING,
      E10GBASER_PCS_TEST_CTRL_LANE0 => E10GBASER_PCS_TEST_CTRL_LANE0_STRING,
      E10GBASER_PCS_TEST_CTRL_LANE1 => E10GBASER_PCS_TEST_CTRL_LANE1_STRING,
      E10GBASER_PCS_TEST_CTRL_LANE2 => E10GBASER_PCS_TEST_CTRL_LANE2_STRING,
      E10GBASER_PCS_TEST_CTRL_LANE3 => E10GBASER_PCS_TEST_CTRL_LANE3_STRING,
      E10GBASEX_PCS_TSTCTRL_LANE0 => E10GBASEX_PCS_TSTCTRL_LANE0_STRING,
      E10GBASEX_PCS_TSTCTRL_LANE1 => E10GBASEX_PCS_TSTCTRL_LANE1_STRING,
      E10GBASEX_PCS_TSTCTRL_LANE2 => E10GBASEX_PCS_TSTCTRL_LANE2_STRING,
      E10GBASEX_PCS_TSTCTRL_LANE3 => E10GBASEX_PCS_TSTCTRL_LANE3_STRING,
      GLBL0_NOISE_CTRL     => GLBL0_NOISE_CTRL_STRING,
      GLBL_AMON_SEL        => GLBL_AMON_SEL_STRING,
      GLBL_DMON_SEL        => GLBL_DMON_SEL_STRING,
      GLBL_PWR_CTRL        => GLBL_PWR_CTRL_STRING,
      GTH_CFG_PWRUP_LANE0  => GTH_CFG_PWRUP_LANE0_STRING,
      GTH_CFG_PWRUP_LANE1  => GTH_CFG_PWRUP_LANE1_STRING,
      GTH_CFG_PWRUP_LANE2  => GTH_CFG_PWRUP_LANE2_STRING,
      GTH_CFG_PWRUP_LANE3  => GTH_CFG_PWRUP_LANE3_STRING,
      LANE_AMON_SEL        => LANE_AMON_SEL_STRING,
      LANE_DMON_SEL        => LANE_DMON_SEL_STRING,
      LANE_LNK_CFGOVRD     => LANE_LNK_CFGOVRD_STRING,
      LANE_PWR_CTRL_LANE0  => LANE_PWR_CTRL_LANE0_STRING,
      LANE_PWR_CTRL_LANE1  => LANE_PWR_CTRL_LANE1_STRING,
      LANE_PWR_CTRL_LANE2  => LANE_PWR_CTRL_LANE2_STRING,
      LANE_PWR_CTRL_LANE3  => LANE_PWR_CTRL_LANE3_STRING,
      LNK_TRN_CFG_LANE0    => LNK_TRN_CFG_LANE0_STRING,
      LNK_TRN_CFG_LANE1    => LNK_TRN_CFG_LANE1_STRING,
      LNK_TRN_CFG_LANE2    => LNK_TRN_CFG_LANE2_STRING,
      LNK_TRN_CFG_LANE3    => LNK_TRN_CFG_LANE3_STRING,
      LNK_TRN_COEFF_REQ_LANE0 => LNK_TRN_COEFF_REQ_LANE0_STRING,
      LNK_TRN_COEFF_REQ_LANE1 => LNK_TRN_COEFF_REQ_LANE1_STRING,
      LNK_TRN_COEFF_REQ_LANE2 => LNK_TRN_COEFF_REQ_LANE2_STRING,
      LNK_TRN_COEFF_REQ_LANE3 => LNK_TRN_COEFF_REQ_LANE3_STRING,
      MISC_CFG             => MISC_CFG_STRING,
      MODE_CFG1            => MODE_CFG1_STRING,
      MODE_CFG2            => MODE_CFG2_STRING,
      MODE_CFG3            => MODE_CFG3_STRING,
      MODE_CFG4            => MODE_CFG4_STRING,
      MODE_CFG5            => MODE_CFG5_STRING,
      MODE_CFG6            => MODE_CFG6_STRING,
      MODE_CFG7            => MODE_CFG7_STRING,
      PCS_ABILITY_LANE0    => PCS_ABILITY_LANE0_STRING,
      PCS_ABILITY_LANE1    => PCS_ABILITY_LANE1_STRING,
      PCS_ABILITY_LANE2    => PCS_ABILITY_LANE2_STRING,
      PCS_ABILITY_LANE3    => PCS_ABILITY_LANE3_STRING,
      PCS_CTRL1_LANE0      => PCS_CTRL1_LANE0_STRING,
      PCS_CTRL1_LANE1      => PCS_CTRL1_LANE1_STRING,
      PCS_CTRL1_LANE2      => PCS_CTRL1_LANE2_STRING,
      PCS_CTRL1_LANE3      => PCS_CTRL1_LANE3_STRING,
      PCS_CTRL2_LANE0      => PCS_CTRL2_LANE0_STRING,
      PCS_CTRL2_LANE1      => PCS_CTRL2_LANE1_STRING,
      PCS_CTRL2_LANE2      => PCS_CTRL2_LANE2_STRING,
      PCS_CTRL2_LANE3      => PCS_CTRL2_LANE3_STRING,
      PCS_MISC_CFG_0_LANE0 => PCS_MISC_CFG_0_LANE0_STRING,
      PCS_MISC_CFG_0_LANE1 => PCS_MISC_CFG_0_LANE1_STRING,
      PCS_MISC_CFG_0_LANE2 => PCS_MISC_CFG_0_LANE2_STRING,
      PCS_MISC_CFG_0_LANE3 => PCS_MISC_CFG_0_LANE3_STRING,
      PCS_MISC_CFG_1_LANE0 => PCS_MISC_CFG_1_LANE0_STRING,
      PCS_MISC_CFG_1_LANE1 => PCS_MISC_CFG_1_LANE1_STRING,
      PCS_MISC_CFG_1_LANE2 => PCS_MISC_CFG_1_LANE2_STRING,
      PCS_MISC_CFG_1_LANE3 => PCS_MISC_CFG_1_LANE3_STRING,
      PCS_MODE_LANE0       => PCS_MODE_LANE0_STRING,
      PCS_MODE_LANE1       => PCS_MODE_LANE1_STRING,
      PCS_MODE_LANE2       => PCS_MODE_LANE2_STRING,
      PCS_MODE_LANE3       => PCS_MODE_LANE3_STRING,
      PCS_RESET_1_LANE0    => PCS_RESET_1_LANE0_STRING,
      PCS_RESET_1_LANE1    => PCS_RESET_1_LANE1_STRING,
      PCS_RESET_1_LANE2    => PCS_RESET_1_LANE2_STRING,
      PCS_RESET_1_LANE3    => PCS_RESET_1_LANE3_STRING,
      PCS_RESET_LANE0      => PCS_RESET_LANE0_STRING,
      PCS_RESET_LANE1      => PCS_RESET_LANE1_STRING,
      PCS_RESET_LANE2      => PCS_RESET_LANE2_STRING,
      PCS_RESET_LANE3      => PCS_RESET_LANE3_STRING,
      PCS_TYPE_LANE0       => PCS_TYPE_LANE0_STRING,
      PCS_TYPE_LANE1       => PCS_TYPE_LANE1_STRING,
      PCS_TYPE_LANE2       => PCS_TYPE_LANE2_STRING,
      PCS_TYPE_LANE3       => PCS_TYPE_LANE3_STRING,
      PLL_CFG0             => PLL_CFG0_STRING,
      PLL_CFG1             => PLL_CFG1_STRING,
      PLL_CFG2             => PLL_CFG2_STRING,
      PMA_CTRL1_LANE0      => PMA_CTRL1_LANE0_STRING,
      PMA_CTRL1_LANE1      => PMA_CTRL1_LANE1_STRING,
      PMA_CTRL1_LANE2      => PMA_CTRL1_LANE2_STRING,
      PMA_CTRL1_LANE3      => PMA_CTRL1_LANE3_STRING,
      PMA_CTRL2_LANE0      => PMA_CTRL2_LANE0_STRING,
      PMA_CTRL2_LANE1      => PMA_CTRL2_LANE1_STRING,
      PMA_CTRL2_LANE2      => PMA_CTRL2_LANE2_STRING,
      PMA_CTRL2_LANE3      => PMA_CTRL2_LANE3_STRING,
      PMA_LPBK_CTRL_LANE0  => PMA_LPBK_CTRL_LANE0_STRING,
      PMA_LPBK_CTRL_LANE1  => PMA_LPBK_CTRL_LANE1_STRING,
      PMA_LPBK_CTRL_LANE2  => PMA_LPBK_CTRL_LANE2_STRING,
      PMA_LPBK_CTRL_LANE3  => PMA_LPBK_CTRL_LANE3_STRING,
      PRBS_BER_CFG0_LANE0  => PRBS_BER_CFG0_LANE0_STRING,
      PRBS_BER_CFG0_LANE1  => PRBS_BER_CFG0_LANE1_STRING,
      PRBS_BER_CFG0_LANE2  => PRBS_BER_CFG0_LANE2_STRING,
      PRBS_BER_CFG0_LANE3  => PRBS_BER_CFG0_LANE3_STRING,
      PRBS_BER_CFG1_LANE0  => PRBS_BER_CFG1_LANE0_STRING,
      PRBS_BER_CFG1_LANE1  => PRBS_BER_CFG1_LANE1_STRING,
      PRBS_BER_CFG1_LANE2  => PRBS_BER_CFG1_LANE2_STRING,
      PRBS_BER_CFG1_LANE3  => PRBS_BER_CFG1_LANE3_STRING,
      PRBS_CFG_LANE0       => PRBS_CFG_LANE0_STRING,
      PRBS_CFG_LANE1       => PRBS_CFG_LANE1_STRING,
      PRBS_CFG_LANE2       => PRBS_CFG_LANE2_STRING,
      PRBS_CFG_LANE3       => PRBS_CFG_LANE3_STRING,
      PTRN_CFG0_LSB        => PTRN_CFG0_LSB_STRING,
      PTRN_CFG0_MSB        => PTRN_CFG0_MSB_STRING,
      PTRN_LEN_CFG         => PTRN_LEN_CFG_STRING,
      PWRUP_DLY            => PWRUP_DLY_STRING,
      RX_AEQ_VAL0_LANE0    => RX_AEQ_VAL0_LANE0_STRING,
      RX_AEQ_VAL0_LANE1    => RX_AEQ_VAL0_LANE1_STRING,
      RX_AEQ_VAL0_LANE2    => RX_AEQ_VAL0_LANE2_STRING,
      RX_AEQ_VAL0_LANE3    => RX_AEQ_VAL0_LANE3_STRING,
      RX_AEQ_VAL1_LANE0    => RX_AEQ_VAL1_LANE0_STRING,
      RX_AEQ_VAL1_LANE1    => RX_AEQ_VAL1_LANE1_STRING,
      RX_AEQ_VAL1_LANE2    => RX_AEQ_VAL1_LANE2_STRING,
      RX_AEQ_VAL1_LANE3    => RX_AEQ_VAL1_LANE3_STRING,
      RX_AGC_CTRL_LANE0    => RX_AGC_CTRL_LANE0_STRING,
      RX_AGC_CTRL_LANE1    => RX_AGC_CTRL_LANE1_STRING,
      RX_AGC_CTRL_LANE2    => RX_AGC_CTRL_LANE2_STRING,
      RX_AGC_CTRL_LANE3    => RX_AGC_CTRL_LANE3_STRING,
      RX_CDR_CTRL0_LANE0   => RX_CDR_CTRL0_LANE0_STRING,
      RX_CDR_CTRL0_LANE1   => RX_CDR_CTRL0_LANE1_STRING,
      RX_CDR_CTRL0_LANE2   => RX_CDR_CTRL0_LANE2_STRING,
      RX_CDR_CTRL0_LANE3   => RX_CDR_CTRL0_LANE3_STRING,
      RX_CDR_CTRL1_LANE0   => RX_CDR_CTRL1_LANE0_STRING,
      RX_CDR_CTRL1_LANE1   => RX_CDR_CTRL1_LANE1_STRING,
      RX_CDR_CTRL1_LANE2   => RX_CDR_CTRL1_LANE2_STRING,
      RX_CDR_CTRL1_LANE3   => RX_CDR_CTRL1_LANE3_STRING,
      RX_CDR_CTRL2_LANE0   => RX_CDR_CTRL2_LANE0_STRING,
      RX_CDR_CTRL2_LANE1   => RX_CDR_CTRL2_LANE1_STRING,
      RX_CDR_CTRL2_LANE2   => RX_CDR_CTRL2_LANE2_STRING,
      RX_CDR_CTRL2_LANE3   => RX_CDR_CTRL2_LANE3_STRING,
      RX_CFG0_LANE0        => RX_CFG0_LANE0_STRING,
      RX_CFG0_LANE1        => RX_CFG0_LANE1_STRING,
      RX_CFG0_LANE2        => RX_CFG0_LANE2_STRING,
      RX_CFG0_LANE3        => RX_CFG0_LANE3_STRING,
      RX_CFG1_LANE0        => RX_CFG1_LANE0_STRING,
      RX_CFG1_LANE1        => RX_CFG1_LANE1_STRING,
      RX_CFG1_LANE2        => RX_CFG1_LANE2_STRING,
      RX_CFG1_LANE3        => RX_CFG1_LANE3_STRING,
      RX_CFG2_LANE0        => RX_CFG2_LANE0_STRING,
      RX_CFG2_LANE1        => RX_CFG2_LANE1_STRING,
      RX_CFG2_LANE2        => RX_CFG2_LANE2_STRING,
      RX_CFG2_LANE3        => RX_CFG2_LANE3_STRING,
      RX_CTLE_CTRL_LANE0   => RX_CTLE_CTRL_LANE0_STRING,
      RX_CTLE_CTRL_LANE1   => RX_CTLE_CTRL_LANE1_STRING,
      RX_CTLE_CTRL_LANE2   => RX_CTLE_CTRL_LANE2_STRING,
      RX_CTLE_CTRL_LANE3   => RX_CTLE_CTRL_LANE3_STRING,
      RX_CTRL_OVRD_LANE0   => RX_CTRL_OVRD_LANE0_STRING,
      RX_CTRL_OVRD_LANE1   => RX_CTRL_OVRD_LANE1_STRING,
      RX_CTRL_OVRD_LANE2   => RX_CTRL_OVRD_LANE2_STRING,
      RX_CTRL_OVRD_LANE3   => RX_CTRL_OVRD_LANE3_STRING,
      RX_FABRIC_WIDTH0     => RX_FABRIC_WIDTH0,
      RX_FABRIC_WIDTH1     => RX_FABRIC_WIDTH1,
      RX_FABRIC_WIDTH2     => RX_FABRIC_WIDTH2,
      RX_FABRIC_WIDTH3     => RX_FABRIC_WIDTH3,
      RX_LOOP_CTRL_LANE0   => RX_LOOP_CTRL_LANE0_STRING,
      RX_LOOP_CTRL_LANE1   => RX_LOOP_CTRL_LANE1_STRING,
      RX_LOOP_CTRL_LANE2   => RX_LOOP_CTRL_LANE2_STRING,
      RX_LOOP_CTRL_LANE3   => RX_LOOP_CTRL_LANE3_STRING,
      RX_MVAL0_LANE0       => RX_MVAL0_LANE0_STRING,
      RX_MVAL0_LANE1       => RX_MVAL0_LANE1_STRING,
      RX_MVAL0_LANE2       => RX_MVAL0_LANE2_STRING,
      RX_MVAL0_LANE3       => RX_MVAL0_LANE3_STRING,
      RX_MVAL1_LANE0       => RX_MVAL1_LANE0_STRING,
      RX_MVAL1_LANE1       => RX_MVAL1_LANE1_STRING,
      RX_MVAL1_LANE2       => RX_MVAL1_LANE2_STRING,
      RX_MVAL1_LANE3       => RX_MVAL1_LANE3_STRING,
      RX_P0S_CTRL          => RX_P0S_CTRL_STRING,
      RX_P0_CTRL           => RX_P0_CTRL_STRING,
      RX_P1_CTRL           => RX_P1_CTRL_STRING,
      RX_P2_CTRL           => RX_P2_CTRL_STRING,
      RX_PI_CTRL0          => RX_PI_CTRL0_STRING,
      RX_PI_CTRL1          => RX_PI_CTRL1_STRING,
      SIM_GTHRESET_SPEEDUP => SIM_GTHRESET_SPEEDUP,
      SIM_VERSION          => SIM_VERSION,
      SLICE_CFG            => SLICE_CFG_STRING,
      SLICE_NOISE_CTRL_0_LANE01 => SLICE_NOISE_CTRL_0_LANE01_STRING,
      SLICE_NOISE_CTRL_0_LANE23 => SLICE_NOISE_CTRL_0_LANE23_STRING,
      SLICE_NOISE_CTRL_1_LANE01 => SLICE_NOISE_CTRL_1_LANE01_STRING,
      SLICE_NOISE_CTRL_1_LANE23 => SLICE_NOISE_CTRL_1_LANE23_STRING,
      SLICE_NOISE_CTRL_2_LANE01 => SLICE_NOISE_CTRL_2_LANE01_STRING,
      SLICE_NOISE_CTRL_2_LANE23 => SLICE_NOISE_CTRL_2_LANE23_STRING,
      SLICE_TX_RESET_LANE01 => SLICE_TX_RESET_LANE01_STRING,
      SLICE_TX_RESET_LANE23 => SLICE_TX_RESET_LANE23_STRING,
      TERM_CTRL_LANE0      => TERM_CTRL_LANE0_STRING,
      TERM_CTRL_LANE1      => TERM_CTRL_LANE1_STRING,
      TERM_CTRL_LANE2      => TERM_CTRL_LANE2_STRING,
      TERM_CTRL_LANE3      => TERM_CTRL_LANE3_STRING,
      TX_CFG0_LANE0        => TX_CFG0_LANE0_STRING,
      TX_CFG0_LANE1        => TX_CFG0_LANE1_STRING,
      TX_CFG0_LANE2        => TX_CFG0_LANE2_STRING,
      TX_CFG0_LANE3        => TX_CFG0_LANE3_STRING,
      TX_CFG1_LANE0        => TX_CFG1_LANE0_STRING,
      TX_CFG1_LANE1        => TX_CFG1_LANE1_STRING,
      TX_CFG1_LANE2        => TX_CFG1_LANE2_STRING,
      TX_CFG1_LANE3        => TX_CFG1_LANE3_STRING,
      TX_CFG2_LANE0        => TX_CFG2_LANE0_STRING,
      TX_CFG2_LANE1        => TX_CFG2_LANE1_STRING,
      TX_CFG2_LANE2        => TX_CFG2_LANE2_STRING,
      TX_CFG2_LANE3        => TX_CFG2_LANE3_STRING,
      TX_CLK_SEL0_LANE0    => TX_CLK_SEL0_LANE0_STRING,
      TX_CLK_SEL0_LANE1    => TX_CLK_SEL0_LANE1_STRING,
      TX_CLK_SEL0_LANE2    => TX_CLK_SEL0_LANE2_STRING,
      TX_CLK_SEL0_LANE3    => TX_CLK_SEL0_LANE3_STRING,
      TX_CLK_SEL1_LANE0    => TX_CLK_SEL1_LANE0_STRING,
      TX_CLK_SEL1_LANE1    => TX_CLK_SEL1_LANE1_STRING,
      TX_CLK_SEL1_LANE2    => TX_CLK_SEL1_LANE2_STRING,
      TX_CLK_SEL1_LANE3    => TX_CLK_SEL1_LANE3_STRING,
      TX_DISABLE_LANE0     => TX_DISABLE_LANE0_STRING,
      TX_DISABLE_LANE1     => TX_DISABLE_LANE1_STRING,
      TX_DISABLE_LANE2     => TX_DISABLE_LANE2_STRING,
      TX_DISABLE_LANE3     => TX_DISABLE_LANE3_STRING,
      TX_FABRIC_WIDTH0     => TX_FABRIC_WIDTH0,
      TX_FABRIC_WIDTH1     => TX_FABRIC_WIDTH1,
      TX_FABRIC_WIDTH2     => TX_FABRIC_WIDTH2,
      TX_FABRIC_WIDTH3     => TX_FABRIC_WIDTH3,
      TX_P0P0S_CTRL        => TX_P0P0S_CTRL_STRING,
      TX_P1P2_CTRL         => TX_P1P2_CTRL_STRING,
      TX_PREEMPH_LANE0     => TX_PREEMPH_LANE0_STRING,
      TX_PREEMPH_LANE1     => TX_PREEMPH_LANE1_STRING,
      TX_PREEMPH_LANE2     => TX_PREEMPH_LANE2_STRING,
      TX_PREEMPH_LANE3     => TX_PREEMPH_LANE3_STRING,
      TX_PWR_RATE_OVRD_LANE0 => TX_PWR_RATE_OVRD_LANE0_STRING,
      TX_PWR_RATE_OVRD_LANE1 => TX_PWR_RATE_OVRD_LANE1_STRING,
      TX_PWR_RATE_OVRD_LANE2 => TX_PWR_RATE_OVRD_LANE2_STRING,
      TX_PWR_RATE_OVRD_LANE3 => TX_PWR_RATE_OVRD_LANE3_STRING
    )
    
    port map (
-- <!--Aldec correction start        
        GSR => GSR_local,
-- Aldec correction end --> 
      DRDY                 => DRDY_outdelay,
      DRPDO                => DRPDO_outdelay,
      GTHINITDONE          => GTHINITDONE_outdelay,
      MGMTPCSRDACK         => MGMTPCSRDACK_outdelay,
      MGMTPCSRDDATA        => MGMTPCSRDDATA_outdelay,
      RXCODEERR0           => RXCODEERR0_outdelay,
      RXCODEERR1           => RXCODEERR1_outdelay,
      RXCODEERR2           => RXCODEERR2_outdelay,
      RXCODEERR3           => RXCODEERR3_outdelay,
      RXCTRL0              => RXCTRL0_outdelay,
      RXCTRL1              => RXCTRL1_outdelay,
      RXCTRL2              => RXCTRL2_outdelay,
      RXCTRL3              => RXCTRL3_outdelay,
      RXCTRLACK0           => RXCTRLACK0_outdelay,
      RXCTRLACK1           => RXCTRLACK1_outdelay,
      RXCTRLACK2           => RXCTRLACK2_outdelay,
      RXCTRLACK3           => RXCTRLACK3_outdelay,
      RXDATA0              => RXDATA0_outdelay,
      RXDATA1              => RXDATA1_outdelay,
      RXDATA2              => RXDATA2_outdelay,
      RXDATA3              => RXDATA3_outdelay,
      RXDATATAP0           => RXDATATAP0_outdelay,
      RXDATATAP1           => RXDATATAP1_outdelay,
      RXDATATAP2           => RXDATATAP2_outdelay,
      RXDATATAP3           => RXDATATAP3_outdelay,
      RXDISPERR0           => RXDISPERR0_outdelay,
      RXDISPERR1           => RXDISPERR1_outdelay,
      RXDISPERR2           => RXDISPERR2_outdelay,
      RXDISPERR3           => RXDISPERR3_outdelay,
      RXPCSCLKSMPL0        => RXPCSCLKSMPL0_outdelay,
      RXPCSCLKSMPL1        => RXPCSCLKSMPL1_outdelay,
      RXPCSCLKSMPL2        => RXPCSCLKSMPL2_outdelay,
      RXPCSCLKSMPL3        => RXPCSCLKSMPL3_outdelay,
      RXUSERCLKOUT0        => RXUSERCLKOUT0_outdelay,
      RXUSERCLKOUT1        => RXUSERCLKOUT1_outdelay,
      RXUSERCLKOUT2        => RXUSERCLKOUT2_outdelay,
      RXUSERCLKOUT3        => RXUSERCLKOUT3_outdelay,
      RXVALID0             => RXVALID0_outdelay,
      RXVALID1             => RXVALID1_outdelay,
      RXVALID2             => RXVALID2_outdelay,
      RXVALID3             => RXVALID3_outdelay,
      TSTPATH              => TSTPATH_outdelay,
      TSTREFCLKFAB         => TSTREFCLKFAB_outdelay,
      TSTREFCLKOUT         => TSTREFCLKOUT_outdelay,
      TXCTRLACK0           => TXCTRLACK0_outdelay,
      TXCTRLACK1           => TXCTRLACK1_outdelay,
      TXCTRLACK2           => TXCTRLACK2_outdelay,
      TXCTRLACK3           => TXCTRLACK3_outdelay,
      TXDATATAP10          => TXDATATAP10_outdelay,
      TXDATATAP11          => TXDATATAP11_outdelay,
      TXDATATAP12          => TXDATATAP12_outdelay,
      TXDATATAP13          => TXDATATAP13_outdelay,
      TXDATATAP20          => TXDATATAP20_outdelay,
      TXDATATAP21          => TXDATATAP21_outdelay,
      TXDATATAP22          => TXDATATAP22_outdelay,
      TXDATATAP23          => TXDATATAP23_outdelay,
      TXN0                 => TXN0_outdelay,
      TXN1                 => TXN1_outdelay,
      TXN2                 => TXN2_outdelay,
      TXN3                 => TXN3_outdelay,
      TXP0                 => TXP0_outdelay,
      TXP1                 => TXP1_outdelay,
      TXP2                 => TXP2_outdelay,
      TXP3                 => TXP3_outdelay,
      TXPCSCLKSMPL0        => TXPCSCLKSMPL0_outdelay,
      TXPCSCLKSMPL1        => TXPCSCLKSMPL1_outdelay,
      TXPCSCLKSMPL2        => TXPCSCLKSMPL2_outdelay,
      TXPCSCLKSMPL3        => TXPCSCLKSMPL3_outdelay,
      TXUSERCLKOUT0        => TXUSERCLKOUT0_outdelay,
      TXUSERCLKOUT1        => TXUSERCLKOUT1_outdelay,
      TXUSERCLKOUT2        => TXUSERCLKOUT2_outdelay,
      TXUSERCLKOUT3        => TXUSERCLKOUT3_outdelay,
      DADDR                => DADDR_indly,
      DCLK                 => DCLK_indly,
      DEN                  => DEN_indly,
      DFETRAINCTRL0        => DFETRAINCTRL0_indly,
      DFETRAINCTRL1        => DFETRAINCTRL1_indly,
      DFETRAINCTRL2        => DFETRAINCTRL2_indly,
      DFETRAINCTRL3        => DFETRAINCTRL3_indly,
      DI                   => DI_indly,
      DISABLEDRP           => DISABLEDRP_indly,
      DWE                  => DWE_indly,
      GTHINIT              => GTHINIT_indly,
      GTHRESET             => GTHRESET_indly,
      GTHX2LANE01          => GTHX2LANE01_indly,
      GTHX2LANE23          => GTHX2LANE23_indly,
      GTHX4LANE            => GTHX4LANE_indly,
      MGMTPCSLANESEL       => MGMTPCSLANESEL_indly,
      MGMTPCSMMDADDR       => MGMTPCSMMDADDR_indly,
      MGMTPCSREGADDR       => MGMTPCSREGADDR_indly,
      MGMTPCSREGRD         => MGMTPCSREGRD_indly,
      MGMTPCSREGWR         => MGMTPCSREGWR_indly,
      MGMTPCSWRDATA        => MGMTPCSWRDATA_indly,
      PLLPCSCLKDIV         => PLLPCSCLKDIV_indly,
      PLLREFCLKSEL         => PLLREFCLKSEL_indly,
      POWERDOWN0           => POWERDOWN0_indly,
      POWERDOWN1           => POWERDOWN1_indly,
      POWERDOWN2           => POWERDOWN2_indly,
      POWERDOWN3           => POWERDOWN3_indly,
      REFCLK               => REFCLK_indly,
      RXBUFRESET0          => RXBUFRESET0_indly,
      RXBUFRESET1          => RXBUFRESET1_indly,
      RXBUFRESET2          => RXBUFRESET2_indly,
      RXBUFRESET3          => RXBUFRESET3_indly,
      RXENCOMMADET0        => RXENCOMMADET0_indly,
      RXENCOMMADET1        => RXENCOMMADET1_indly,
      RXENCOMMADET2        => RXENCOMMADET2_indly,
      RXENCOMMADET3        => RXENCOMMADET3_indly,
      RXN0                 => RXN0_indly,
      RXN1                 => RXN1_indly,
      RXN2                 => RXN2_indly,
      RXN3                 => RXN3_indly,
      RXP0                 => RXP0_indly,
      RXP1                 => RXP1_indly,
      RXP2                 => RXP2_indly,
      RXP3                 => RXP3_indly,
      RXPOLARITY0          => RXPOLARITY0_indly,
      RXPOLARITY1          => RXPOLARITY1_indly,
      RXPOLARITY2          => RXPOLARITY2_indly,
      RXPOLARITY3          => RXPOLARITY3_indly,
      RXPOWERDOWN0         => RXPOWERDOWN0_indly,
      RXPOWERDOWN1         => RXPOWERDOWN1_indly,
      RXPOWERDOWN2         => RXPOWERDOWN2_indly,
      RXPOWERDOWN3         => RXPOWERDOWN3_indly,
      RXRATE0              => RXRATE0_indly,
      RXRATE1              => RXRATE1_indly,
      RXRATE2              => RXRATE2_indly,
      RXRATE3              => RXRATE3_indly,
      RXSLIP0              => RXSLIP0_indly,
      RXSLIP1              => RXSLIP1_indly,
      RXSLIP2              => RXSLIP2_indly,
      RXSLIP3              => RXSLIP3_indly,
      RXUSERCLKIN0         => RXUSERCLKIN0_indly,
      RXUSERCLKIN1         => RXUSERCLKIN1_indly,
      RXUSERCLKIN2         => RXUSERCLKIN2_indly,
      RXUSERCLKIN3         => RXUSERCLKIN3_indly,
      SAMPLERATE0          => SAMPLERATE0_indly,
      SAMPLERATE1          => SAMPLERATE1_indly,
      SAMPLERATE2          => SAMPLERATE2_indly,
      SAMPLERATE3          => SAMPLERATE3_indly,
      TXBUFRESET0          => TXBUFRESET0_indly,
      TXBUFRESET1          => TXBUFRESET1_indly,
      TXBUFRESET2          => TXBUFRESET2_indly,
      TXBUFRESET3          => TXBUFRESET3_indly,
      TXCTRL0              => TXCTRL0_indly,
      TXCTRL1              => TXCTRL1_indly,
      TXCTRL2              => TXCTRL2_indly,
      TXCTRL3              => TXCTRL3_indly,
      TXDATA0              => TXDATA0_indly,
      TXDATA1              => TXDATA1_indly,
      TXDATA2              => TXDATA2_indly,
      TXDATA3              => TXDATA3_indly,
      TXDATAMSB0           => TXDATAMSB0_indly,
      TXDATAMSB1           => TXDATAMSB1_indly,
      TXDATAMSB2           => TXDATAMSB2_indly,
      TXDATAMSB3           => TXDATAMSB3_indly,
      TXDEEMPH0            => TXDEEMPH0_indly,
      TXDEEMPH1            => TXDEEMPH1_indly,
      TXDEEMPH2            => TXDEEMPH2_indly,
      TXDEEMPH3            => TXDEEMPH3_indly,
      TXMARGIN0            => TXMARGIN0_indly,
      TXMARGIN1            => TXMARGIN1_indly,
      TXMARGIN2            => TXMARGIN2_indly,
      TXMARGIN3            => TXMARGIN3_indly,
      TXPOWERDOWN0         => TXPOWERDOWN0_indly,
      TXPOWERDOWN1         => TXPOWERDOWN1_indly,
      TXPOWERDOWN2         => TXPOWERDOWN2_indly,
      TXPOWERDOWN3         => TXPOWERDOWN3_indly,
      TXRATE0              => TXRATE0_indly,
      TXRATE1              => TXRATE1_indly,
      TXRATE2              => TXRATE2_indly,
      TXRATE3              => TXRATE3_indly,
      TXUSERCLKIN0         => TXUSERCLKIN0_indly,
      TXUSERCLKIN1         => TXUSERCLKIN1_indly,
      TXUSERCLKIN2         => TXUSERCLKIN2_indly,
      TXUSERCLKIN3         => TXUSERCLKIN3_indly      
    );
  
  INIPROC : process
  begin
  if ((RX_FABRIC_WIDTH0 >= 8) and (RX_FABRIC_WIDTH0 <= 6466)) then
    RX_FABRIC_WIDTH0_BINARY <= CONV_STD_LOGIC_VECTOR(RX_FABRIC_WIDTH0, 3);
  else
    assert FALSE report "Error : RX_FABRIC_WIDTH0 is not in range 8 .. 6466." severity error;
  end if;
  if ((RX_FABRIC_WIDTH1 >= 8) and (RX_FABRIC_WIDTH1 <= 6466)) then
    RX_FABRIC_WIDTH1_BINARY <= CONV_STD_LOGIC_VECTOR(RX_FABRIC_WIDTH1, 3);
  else
    assert FALSE report "Error : RX_FABRIC_WIDTH1 is not in range 8 .. 6466." severity error;
  end if;
  if ((RX_FABRIC_WIDTH2 >= 8) and (RX_FABRIC_WIDTH2 <= 6466)) then
    RX_FABRIC_WIDTH2_BINARY <= CONV_STD_LOGIC_VECTOR(RX_FABRIC_WIDTH2, 3);
  else
    assert FALSE report "Error : RX_FABRIC_WIDTH2 is not in range 8 .. 6466." severity error;
  end if;
  if ((RX_FABRIC_WIDTH3 >= 8) and (RX_FABRIC_WIDTH3 <= 6466)) then
    RX_FABRIC_WIDTH3_BINARY <= CONV_STD_LOGIC_VECTOR(RX_FABRIC_WIDTH3, 3);
  else
    assert FALSE report "Error : RX_FABRIC_WIDTH3 is not in range 8 .. 6466." severity error;
  end if;
  if ((TX_FABRIC_WIDTH0 >= 8) and (TX_FABRIC_WIDTH0 <= 6466)) then
    TX_FABRIC_WIDTH0_BINARY <= CONV_STD_LOGIC_VECTOR(TX_FABRIC_WIDTH0, 3);
  else
    assert FALSE report "Error : TX_FABRIC_WIDTH0 is not in range 8 .. 6466." severity error;
  end if;
  if ((TX_FABRIC_WIDTH1 >= 8) and (TX_FABRIC_WIDTH1 <= 6466)) then
    TX_FABRIC_WIDTH1_BINARY <= CONV_STD_LOGIC_VECTOR(TX_FABRIC_WIDTH1, 3);
  else
    assert FALSE report "Error : TX_FABRIC_WIDTH1 is not in range 8 .. 6466." severity error;
  end if;
  if ((TX_FABRIC_WIDTH2 >= 8) and (TX_FABRIC_WIDTH2 <= 6466)) then
    TX_FABRIC_WIDTH2_BINARY <= CONV_STD_LOGIC_VECTOR(TX_FABRIC_WIDTH2, 3);
  else
    assert FALSE report "Error : TX_FABRIC_WIDTH2 is not in range 8 .. 6466." severity error;
  end if;
  if ((TX_FABRIC_WIDTH3 >= 8) and (TX_FABRIC_WIDTH3 <= 6466)) then
    TX_FABRIC_WIDTH3_BINARY <= CONV_STD_LOGIC_VECTOR(TX_FABRIC_WIDTH3, 3);
  else
    assert FALSE report "Error : TX_FABRIC_WIDTH3 is not in range 8 .. 6466." severity error;
  end if;
  wait;
  end process INIPROC;
  
  TIMING : process
    variable Tmkr_DADDR_DCLK_posedge : VitalTimingDataArrayType(15 downto 0);
    variable Tmkr_DEN_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
    variable Tmkr_DFETRAINCTRL0_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
    variable Tmkr_DFETRAINCTRL1_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
    variable Tmkr_DFETRAINCTRL2_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
    variable Tmkr_DFETRAINCTRL3_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
    variable Tmkr_DISABLEDRP_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
    variable Tmkr_DI_DCLK_posedge : VitalTimingDataArrayType(15 downto 0);
    variable Tmkr_DWE_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
    variable Tmkr_GTHINIT_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
    variable Tmkr_MGMTPCSLANESEL_DCLK_posedge : VitalTimingDataArrayType(3 downto 0);
    variable Tmkr_MGMTPCSMMDADDR_DCLK_posedge : VitalTimingDataArrayType(4 downto 0);
    variable Tmkr_MGMTPCSREGADDR_DCLK_posedge : VitalTimingDataArrayType(15 downto 0);
    variable Tmkr_MGMTPCSREGRD_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
    variable Tmkr_MGMTPCSREGWR_DCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
    variable Tmkr_MGMTPCSWRDATA_DCLK_posedge : VitalTimingDataArrayType(15 downto 0);
    variable Tmkr_PLLPCSCLKDIV_DCLK_posedge : VitalTimingDataArrayType(5 downto 0);
    variable Tmkr_RXBUFRESET0_RXUSERCLKIN0_posedge : VitalTimingDataType := VitalTimingDataInit;
    variable Tmkr_RXBUFRESET1_RXUSERCLKIN1_posedge : VitalTimingDataType := VitalTimingDataInit;
    variable Tmkr_RXBUFRESET2_RXUSERCLKIN2_posedge : VitalTimingDataType := VitalTimingDataInit;
    variable Tmkr_RXBUFRESET3_RXUSERCLKIN3_posedge : VitalTimingDataType := VitalTimingDataInit;
    variable Tmkr_RXENCOMMADET0_RXUSERCLKIN0_posedge : VitalTimingDataType := VitalTimingDataInit;
    variable Tmkr_RXENCOMMADET1_RXUSERCLKIN1_posedge : VitalTimingDataType := VitalTimingDataInit;
    variable Tmkr_RXENCOMMADET2_RXUSERCLKIN2_posedge : VitalTimingDataType := VitalTimingDataInit;
    variable Tmkr_RXENCOMMADET3_RXUSERCLKIN3_posedge : VitalTimingDataType := VitalTimingDataInit;
    variable Tmkr_RXPOLARITY0_RXUSERCLKIN0_posedge : VitalTimingDataType := VitalTimingDataInit;
    variable Tmkr_RXPOLARITY1_RXUSERCLKIN1_posedge : VitalTimingDataType := VitalTimingDataInit;
    variable Tmkr_RXPOLARITY2_RXUSERCLKIN2_posedge : VitalTimingDataType := VitalTimingDataInit;
    variable Tmkr_RXPOLARITY3_RXUSERCLKIN3_posedge : VitalTimingDataType := VitalTimingDataInit;
    variable Tmkr_RXPOWERDOWN0_TXUSERCLKIN0_posedge : VitalTimingDataArrayType(1 downto 0);
    variable Tmkr_RXPOWERDOWN1_TXUSERCLKIN1_posedge : VitalTimingDataArrayType(1 downto 0);
    variable Tmkr_RXPOWERDOWN2_TXUSERCLKIN2_posedge : VitalTimingDataArrayType(1 downto 0);
    variable Tmkr_RXPOWERDOWN3_TXUSERCLKIN3_posedge : VitalTimingDataArrayType(1 downto 0);
    variable Tmkr_RXRATE0_TXUSERCLKIN0_posedge : VitalTimingDataArrayType(1 downto 0);
    variable Tmkr_RXRATE1_TXUSERCLKIN1_posedge : VitalTimingDataArrayType(1 downto 0);
    variable Tmkr_RXRATE2_TXUSERCLKIN2_posedge : VitalTimingDataArrayType(1 downto 0);
    variable Tmkr_RXRATE3_TXUSERCLKIN3_posedge : VitalTimingDataArrayType(1 downto 0);
    variable Tmkr_SAMPLERATE0_TXUSERCLKIN0_posedge : VitalTimingDataArrayType(2 downto 0);
    variable Tmkr_SAMPLERATE1_TXUSERCLKIN1_posedge : VitalTimingDataArrayType(2 downto 0);
    variable Tmkr_SAMPLERATE2_TXUSERCLKIN2_posedge : VitalTimingDataArrayType(2 downto 0);
    variable Tmkr_SAMPLERATE3_TXUSERCLKIN3_posedge : VitalTimingDataArrayType(2 downto 0);
    variable Tmkr_TXBUFRESET0_TXUSERCLKIN0_posedge : VitalTimingDataType := VitalTimingDataInit;
    variable Tmkr_TXBUFRESET1_TXUSERCLKIN1_posedge : VitalTimingDataType := VitalTimingDataInit;
    variable Tmkr_TXBUFRESET2_TXUSERCLKIN2_posedge : VitalTimingDataType := VitalTimingDataInit;
    variable Tmkr_TXBUFRESET3_TXUSERCLKIN3_posedge : VitalTimingDataType := VitalTimingDataInit;
    variable Tmkr_TXCTRL0_TXUSERCLKIN0_posedge : VitalTimingDataArrayType(7 downto 0);
    variable Tmkr_TXCTRL1_TXUSERCLKIN1_posedge : VitalTimingDataArrayType(7 downto 0);
    variable Tmkr_TXCTRL2_TXUSERCLKIN2_posedge : VitalTimingDataArrayType(7 downto 0);
    variable Tmkr_TXCTRL3_TXUSERCLKIN3_posedge : VitalTimingDataArrayType(7 downto 0);
    variable Tmkr_TXDATA0_TXUSERCLKIN0_posedge : VitalTimingDataArrayType(63 downto 0);
    variable Tmkr_TXDATA1_TXUSERCLKIN1_posedge : VitalTimingDataArrayType(63 downto 0);
    variable Tmkr_TXDATA2_TXUSERCLKIN2_posedge : VitalTimingDataArrayType(63 downto 0);
    variable Tmkr_TXDATA3_TXUSERCLKIN3_posedge : VitalTimingDataArrayType(63 downto 0);
    variable Tmkr_TXDATAMSB0_TXUSERCLKIN0_posedge : VitalTimingDataArrayType(7 downto 0);
    variable Tmkr_TXDATAMSB1_TXUSERCLKIN1_posedge : VitalTimingDataArrayType(7 downto 0);
    variable Tmkr_TXDATAMSB2_TXUSERCLKIN2_posedge : VitalTimingDataArrayType(7 downto 0);
    variable Tmkr_TXDATAMSB3_TXUSERCLKIN3_posedge : VitalTimingDataArrayType(7 downto 0);
    variable Tmkr_TXDEEMPH0_TXUSERCLKIN0_posedge : VitalTimingDataType := VitalTimingDataInit;
    variable Tmkr_TXDEEMPH1_TXUSERCLKIN1_posedge : VitalTimingDataType := VitalTimingDataInit;
    variable Tmkr_TXDEEMPH2_TXUSERCLKIN2_posedge : VitalTimingDataType := VitalTimingDataInit;
    variable Tmkr_TXDEEMPH3_TXUSERCLKIN3_posedge : VitalTimingDataType := VitalTimingDataInit;
    variable Tmkr_TXMARGIN0_TXUSERCLKIN0_posedge : VitalTimingDataArrayType(2 downto 0);
    variable Tmkr_TXMARGIN1_TXUSERCLKIN1_posedge : VitalTimingDataArrayType(2 downto 0);
    variable Tmkr_TXMARGIN2_TXUSERCLKIN2_posedge : VitalTimingDataArrayType(2 downto 0);
    variable Tmkr_TXMARGIN3_TXUSERCLKIN3_posedge : VitalTimingDataArrayType(2 downto 0);
    variable Tmkr_TXPOWERDOWN0_TXUSERCLKIN0_posedge : VitalTimingDataArrayType(1 downto 0);
    variable Tmkr_TXPOWERDOWN1_TXUSERCLKIN1_posedge : VitalTimingDataArrayType(1 downto 0);
    variable Tmkr_TXPOWERDOWN2_TXUSERCLKIN2_posedge : VitalTimingDataArrayType(1 downto 0);
    variable Tmkr_TXPOWERDOWN3_TXUSERCLKIN3_posedge : VitalTimingDataArrayType(1 downto 0);
    variable Tmkr_TXRATE0_TXUSERCLKIN0_posedge : VitalTimingDataArrayType(1 downto 0);
    variable Tmkr_TXRATE1_TXUSERCLKIN1_posedge : VitalTimingDataArrayType(1 downto 0);
    variable Tmkr_TXRATE2_TXUSERCLKIN2_posedge : VitalTimingDataArrayType(1 downto 0);
    variable Tmkr_TXRATE3_TXUSERCLKIN3_posedge : VitalTimingDataArrayType(1 downto 0);
    variable Tviol_DADDR_DCLK_posedge : std_logic_vector(15 downto 0) := (others => '0');
    variable Tviol_DEN_DCLK_posedge :  std_ulogic := '0';
    variable Tviol_DFETRAINCTRL0_DCLK_posedge :  std_ulogic := '0';
    variable Tviol_DFETRAINCTRL1_DCLK_posedge :  std_ulogic := '0';
    variable Tviol_DFETRAINCTRL2_DCLK_posedge :  std_ulogic := '0';
    variable Tviol_DFETRAINCTRL3_DCLK_posedge :  std_ulogic := '0';
    variable Tviol_DISABLEDRP_DCLK_posedge :  std_ulogic := '0';
    variable Tviol_DI_DCLK_posedge : std_logic_vector(15 downto 0) := (others => '0');
    variable Tviol_DWE_DCLK_posedge :  std_ulogic := '0';
    variable Tviol_GTHINIT_DCLK_posedge :  std_ulogic := '0';
    variable Tviol_MGMTPCSLANESEL_DCLK_posedge : std_logic_vector(3 downto 0) := (others => '0');
    variable Tviol_MGMTPCSMMDADDR_DCLK_posedge : std_logic_vector(4 downto 0) := (others => '0');
    variable Tviol_MGMTPCSREGADDR_DCLK_posedge : std_logic_vector(15 downto 0) := (others => '0');
    variable Tviol_MGMTPCSREGRD_DCLK_posedge :  std_ulogic := '0';
    variable Tviol_MGMTPCSREGWR_DCLK_posedge :  std_ulogic := '0';
    variable Tviol_MGMTPCSWRDATA_DCLK_posedge : std_logic_vector(15 downto 0) := (others => '0');
    variable Tviol_PLLPCSCLKDIV_DCLK_posedge : std_logic_vector(5 downto 0) := (others => '0');
    variable Tviol_RXBUFRESET0_RXUSERCLKIN0_posedge :  std_ulogic := '0';
    variable Tviol_RXBUFRESET1_RXUSERCLKIN1_posedge :  std_ulogic := '0';
    variable Tviol_RXBUFRESET2_RXUSERCLKIN2_posedge :  std_ulogic := '0';
    variable Tviol_RXBUFRESET3_RXUSERCLKIN3_posedge :  std_ulogic := '0';
    variable Tviol_RXENCOMMADET0_RXUSERCLKIN0_posedge :  std_ulogic := '0';
    variable Tviol_RXENCOMMADET1_RXUSERCLKIN1_posedge :  std_ulogic := '0';
    variable Tviol_RXENCOMMADET2_RXUSERCLKIN2_posedge :  std_ulogic := '0';
    variable Tviol_RXENCOMMADET3_RXUSERCLKIN3_posedge :  std_ulogic := '0';
    variable Tviol_RXPOLARITY0_RXUSERCLKIN0_posedge :  std_ulogic := '0';
    variable Tviol_RXPOLARITY1_RXUSERCLKIN1_posedge :  std_ulogic := '0';
    variable Tviol_RXPOLARITY2_RXUSERCLKIN2_posedge :  std_ulogic := '0';
    variable Tviol_RXPOLARITY3_RXUSERCLKIN3_posedge :  std_ulogic := '0';
    variable Tviol_RXPOWERDOWN0_TXUSERCLKIN0_posedge : std_logic_vector(1 downto 0) := (others => '0');
    variable Tviol_RXPOWERDOWN1_TXUSERCLKIN1_posedge : std_logic_vector(1 downto 0) := (others => '0');
    variable Tviol_RXPOWERDOWN2_TXUSERCLKIN2_posedge : std_logic_vector(1 downto 0) := (others => '0');
    variable Tviol_RXPOWERDOWN3_TXUSERCLKIN3_posedge : std_logic_vector(1 downto 0) := (others => '0');
    variable Tviol_RXRATE0_TXUSERCLKIN0_posedge : std_logic_vector(1 downto 0) := (others => '0');
    variable Tviol_RXRATE1_TXUSERCLKIN1_posedge : std_logic_vector(1 downto 0) := (others => '0');
    variable Tviol_RXRATE2_TXUSERCLKIN2_posedge : std_logic_vector(1 downto 0) := (others => '0');
    variable Tviol_RXRATE3_TXUSERCLKIN3_posedge : std_logic_vector(1 downto 0) := (others => '0');
    variable Tviol_SAMPLERATE0_TXUSERCLKIN0_posedge : std_logic_vector(2 downto 0) := (others => '0');
    variable Tviol_SAMPLERATE1_TXUSERCLKIN1_posedge : std_logic_vector(2 downto 0) := (others => '0');
    variable Tviol_SAMPLERATE2_TXUSERCLKIN2_posedge : std_logic_vector(2 downto 0) := (others => '0');
    variable Tviol_SAMPLERATE3_TXUSERCLKIN3_posedge : std_logic_vector(2 downto 0) := (others => '0');
    variable Tviol_TXBUFRESET0_TXUSERCLKIN0_posedge :  std_ulogic := '0';
    variable Tviol_TXBUFRESET1_TXUSERCLKIN1_posedge :  std_ulogic := '0';
    variable Tviol_TXBUFRESET2_TXUSERCLKIN2_posedge :  std_ulogic := '0';
    variable Tviol_TXBUFRESET3_TXUSERCLKIN3_posedge :  std_ulogic := '0';
    variable Tviol_TXCTRL0_TXUSERCLKIN0_posedge : std_logic_vector(7 downto 0) := (others => '0');
    variable Tviol_TXCTRL1_TXUSERCLKIN1_posedge : std_logic_vector(7 downto 0) := (others => '0');
    variable Tviol_TXCTRL2_TXUSERCLKIN2_posedge : std_logic_vector(7 downto 0) := (others => '0');
    variable Tviol_TXCTRL3_TXUSERCLKIN3_posedge : std_logic_vector(7 downto 0) := (others => '0');
    variable Tviol_TXDATA0_TXUSERCLKIN0_posedge : std_logic_vector(63 downto 0) := (others => '0');
    variable Tviol_TXDATA1_TXUSERCLKIN1_posedge : std_logic_vector(63 downto 0) := (others => '0');
    variable Tviol_TXDATA2_TXUSERCLKIN2_posedge : std_logic_vector(63 downto 0) := (others => '0');
    variable Tviol_TXDATA3_TXUSERCLKIN3_posedge : std_logic_vector(63 downto 0) := (others => '0');
    variable Tviol_TXDATAMSB0_TXUSERCLKIN0_posedge : std_logic_vector(7 downto 0) := (others => '0');
    variable Tviol_TXDATAMSB1_TXUSERCLKIN1_posedge : std_logic_vector(7 downto 0) := (others => '0');
    variable Tviol_TXDATAMSB2_TXUSERCLKIN2_posedge : std_logic_vector(7 downto 0) := (others => '0');
    variable Tviol_TXDATAMSB3_TXUSERCLKIN3_posedge : std_logic_vector(7 downto 0) := (others => '0');
    variable Tviol_TXDEEMPH0_TXUSERCLKIN0_posedge :  std_ulogic := '0';
    variable Tviol_TXDEEMPH1_TXUSERCLKIN1_posedge :  std_ulogic := '0';
    variable Tviol_TXDEEMPH2_TXUSERCLKIN2_posedge :  std_ulogic := '0';
    variable Tviol_TXDEEMPH3_TXUSERCLKIN3_posedge :  std_ulogic := '0';
    variable Tviol_TXMARGIN0_TXUSERCLKIN0_posedge : std_logic_vector(2 downto 0) := (others => '0');
    variable Tviol_TXMARGIN1_TXUSERCLKIN1_posedge : std_logic_vector(2 downto 0) := (others => '0');
    variable Tviol_TXMARGIN2_TXUSERCLKIN2_posedge : std_logic_vector(2 downto 0) := (others => '0');
    variable Tviol_TXMARGIN3_TXUSERCLKIN3_posedge : std_logic_vector(2 downto 0) := (others => '0');
    variable Tviol_TXPOWERDOWN0_TXUSERCLKIN0_posedge : std_logic_vector(1 downto 0) := (others => '0');
    variable Tviol_TXPOWERDOWN1_TXUSERCLKIN1_posedge : std_logic_vector(1 downto 0) := (others => '0');
    variable Tviol_TXPOWERDOWN2_TXUSERCLKIN2_posedge : std_logic_vector(1 downto 0) := (others => '0');
    variable Tviol_TXPOWERDOWN3_TXUSERCLKIN3_posedge : std_logic_vector(1 downto 0) := (others => '0');
    variable Tviol_TXRATE0_TXUSERCLKIN0_posedge : std_logic_vector(1 downto 0) := (others => '0');
    variable Tviol_TXRATE1_TXUSERCLKIN1_posedge : std_logic_vector(1 downto 0) := (others => '0');
    variable Tviol_TXRATE2_TXUSERCLKIN2_posedge : std_logic_vector(1 downto 0) := (others => '0');
    variable Tviol_TXRATE3_TXUSERCLKIN3_posedge : std_logic_vector(1 downto 0) := (others => '0');
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
    variable GTHINITDONE_GlitchData : VitalGlitchDataType;
    variable MGMTPCSRDACK_GlitchData : VitalGlitchDataType;
    variable MGMTPCSRDDATA0_GlitchData : VitalGlitchDataType;
    variable MGMTPCSRDDATA10_GlitchData : VitalGlitchDataType;
    variable MGMTPCSRDDATA11_GlitchData : VitalGlitchDataType;
    variable MGMTPCSRDDATA12_GlitchData : VitalGlitchDataType;
    variable MGMTPCSRDDATA13_GlitchData : VitalGlitchDataType;
    variable MGMTPCSRDDATA14_GlitchData : VitalGlitchDataType;
    variable MGMTPCSRDDATA15_GlitchData : VitalGlitchDataType;
    variable MGMTPCSRDDATA1_GlitchData : VitalGlitchDataType;
    variable MGMTPCSRDDATA2_GlitchData : VitalGlitchDataType;
    variable MGMTPCSRDDATA3_GlitchData : VitalGlitchDataType;
    variable MGMTPCSRDDATA4_GlitchData : VitalGlitchDataType;
    variable MGMTPCSRDDATA5_GlitchData : VitalGlitchDataType;
    variable MGMTPCSRDDATA6_GlitchData : VitalGlitchDataType;
    variable MGMTPCSRDDATA7_GlitchData : VitalGlitchDataType;
    variable MGMTPCSRDDATA8_GlitchData : VitalGlitchDataType;
    variable MGMTPCSRDDATA9_GlitchData : VitalGlitchDataType;
    variable RXCODEERR00_GlitchData : VitalGlitchDataType;
    variable RXCODEERR01_GlitchData : VitalGlitchDataType;
    variable RXCODEERR02_GlitchData : VitalGlitchDataType;
    variable RXCODEERR03_GlitchData : VitalGlitchDataType;
    variable RXCODEERR04_GlitchData : VitalGlitchDataType;
    variable RXCODEERR05_GlitchData : VitalGlitchDataType;
    variable RXCODEERR06_GlitchData : VitalGlitchDataType;
    variable RXCODEERR07_GlitchData : VitalGlitchDataType;
    variable RXCODEERR10_GlitchData : VitalGlitchDataType;
    variable RXCODEERR11_GlitchData : VitalGlitchDataType;
    variable RXCODEERR12_GlitchData : VitalGlitchDataType;
    variable RXCODEERR13_GlitchData : VitalGlitchDataType;
    variable RXCODEERR14_GlitchData : VitalGlitchDataType;
    variable RXCODEERR15_GlitchData : VitalGlitchDataType;
    variable RXCODEERR16_GlitchData : VitalGlitchDataType;
    variable RXCODEERR17_GlitchData : VitalGlitchDataType;
    variable RXCODEERR20_GlitchData : VitalGlitchDataType;
    variable RXCODEERR21_GlitchData : VitalGlitchDataType;
    variable RXCODEERR22_GlitchData : VitalGlitchDataType;
    variable RXCODEERR23_GlitchData : VitalGlitchDataType;
    variable RXCODEERR24_GlitchData : VitalGlitchDataType;
    variable RXCODEERR25_GlitchData : VitalGlitchDataType;
    variable RXCODEERR26_GlitchData : VitalGlitchDataType;
    variable RXCODEERR27_GlitchData : VitalGlitchDataType;
    variable RXCODEERR30_GlitchData : VitalGlitchDataType;
    variable RXCODEERR31_GlitchData : VitalGlitchDataType;
    variable RXCODEERR32_GlitchData : VitalGlitchDataType;
    variable RXCODEERR33_GlitchData : VitalGlitchDataType;
    variable RXCODEERR34_GlitchData : VitalGlitchDataType;
    variable RXCODEERR35_GlitchData : VitalGlitchDataType;
    variable RXCODEERR36_GlitchData : VitalGlitchDataType;
    variable RXCODEERR37_GlitchData : VitalGlitchDataType;
    variable RXCTRL00_GlitchData : VitalGlitchDataType;
    variable RXCTRL01_GlitchData : VitalGlitchDataType;
    variable RXCTRL02_GlitchData : VitalGlitchDataType;
    variable RXCTRL03_GlitchData : VitalGlitchDataType;
    variable RXCTRL04_GlitchData : VitalGlitchDataType;
    variable RXCTRL05_GlitchData : VitalGlitchDataType;
    variable RXCTRL06_GlitchData : VitalGlitchDataType;
    variable RXCTRL07_GlitchData : VitalGlitchDataType;
    variable RXCTRL10_GlitchData : VitalGlitchDataType;
    variable RXCTRL11_GlitchData : VitalGlitchDataType;
    variable RXCTRL12_GlitchData : VitalGlitchDataType;
    variable RXCTRL13_GlitchData : VitalGlitchDataType;
    variable RXCTRL14_GlitchData : VitalGlitchDataType;
    variable RXCTRL15_GlitchData : VitalGlitchDataType;
    variable RXCTRL16_GlitchData : VitalGlitchDataType;
    variable RXCTRL17_GlitchData : VitalGlitchDataType;
    variable RXCTRL20_GlitchData : VitalGlitchDataType;
    variable RXCTRL21_GlitchData : VitalGlitchDataType;
    variable RXCTRL22_GlitchData : VitalGlitchDataType;
    variable RXCTRL23_GlitchData : VitalGlitchDataType;
    variable RXCTRL24_GlitchData : VitalGlitchDataType;
    variable RXCTRL25_GlitchData : VitalGlitchDataType;
    variable RXCTRL26_GlitchData : VitalGlitchDataType;
    variable RXCTRL27_GlitchData : VitalGlitchDataType;
    variable RXCTRL30_GlitchData : VitalGlitchDataType;
    variable RXCTRL31_GlitchData : VitalGlitchDataType;
    variable RXCTRL32_GlitchData : VitalGlitchDataType;
    variable RXCTRL33_GlitchData : VitalGlitchDataType;
    variable RXCTRL34_GlitchData : VitalGlitchDataType;
    variable RXCTRL35_GlitchData : VitalGlitchDataType;
    variable RXCTRL36_GlitchData : VitalGlitchDataType;
    variable RXCTRL37_GlitchData : VitalGlitchDataType;
    variable RXCTRLACK0_GlitchData : VitalGlitchDataType;
    variable RXCTRLACK1_GlitchData : VitalGlitchDataType;
    variable RXCTRLACK2_GlitchData : VitalGlitchDataType;
    variable RXCTRLACK3_GlitchData : VitalGlitchDataType;
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
    variable RXDATA032_GlitchData : VitalGlitchDataType;
    variable RXDATA033_GlitchData : VitalGlitchDataType;
    variable RXDATA034_GlitchData : VitalGlitchDataType;
    variable RXDATA035_GlitchData : VitalGlitchDataType;
    variable RXDATA036_GlitchData : VitalGlitchDataType;
    variable RXDATA037_GlitchData : VitalGlitchDataType;
    variable RXDATA038_GlitchData : VitalGlitchDataType;
    variable RXDATA039_GlitchData : VitalGlitchDataType;
    variable RXDATA03_GlitchData : VitalGlitchDataType;
    variable RXDATA040_GlitchData : VitalGlitchDataType;
    variable RXDATA041_GlitchData : VitalGlitchDataType;
    variable RXDATA042_GlitchData : VitalGlitchDataType;
    variable RXDATA043_GlitchData : VitalGlitchDataType;
    variable RXDATA044_GlitchData : VitalGlitchDataType;
    variable RXDATA045_GlitchData : VitalGlitchDataType;
    variable RXDATA046_GlitchData : VitalGlitchDataType;
    variable RXDATA047_GlitchData : VitalGlitchDataType;
    variable RXDATA048_GlitchData : VitalGlitchDataType;
    variable RXDATA049_GlitchData : VitalGlitchDataType;
    variable RXDATA04_GlitchData : VitalGlitchDataType;
    variable RXDATA050_GlitchData : VitalGlitchDataType;
    variable RXDATA051_GlitchData : VitalGlitchDataType;
    variable RXDATA052_GlitchData : VitalGlitchDataType;
    variable RXDATA053_GlitchData : VitalGlitchDataType;
    variable RXDATA054_GlitchData : VitalGlitchDataType;
    variable RXDATA055_GlitchData : VitalGlitchDataType;
    variable RXDATA056_GlitchData : VitalGlitchDataType;
    variable RXDATA057_GlitchData : VitalGlitchDataType;
    variable RXDATA058_GlitchData : VitalGlitchDataType;
    variable RXDATA059_GlitchData : VitalGlitchDataType;
    variable RXDATA05_GlitchData : VitalGlitchDataType;
    variable RXDATA060_GlitchData : VitalGlitchDataType;
    variable RXDATA061_GlitchData : VitalGlitchDataType;
    variable RXDATA062_GlitchData : VitalGlitchDataType;
    variable RXDATA063_GlitchData : VitalGlitchDataType;
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
    variable RXDATA132_GlitchData : VitalGlitchDataType;
    variable RXDATA133_GlitchData : VitalGlitchDataType;
    variable RXDATA134_GlitchData : VitalGlitchDataType;
    variable RXDATA135_GlitchData : VitalGlitchDataType;
    variable RXDATA136_GlitchData : VitalGlitchDataType;
    variable RXDATA137_GlitchData : VitalGlitchDataType;
    variable RXDATA138_GlitchData : VitalGlitchDataType;
    variable RXDATA139_GlitchData : VitalGlitchDataType;
    variable RXDATA13_GlitchData : VitalGlitchDataType;
    variable RXDATA140_GlitchData : VitalGlitchDataType;
    variable RXDATA141_GlitchData : VitalGlitchDataType;
    variable RXDATA142_GlitchData : VitalGlitchDataType;
    variable RXDATA143_GlitchData : VitalGlitchDataType;
    variable RXDATA144_GlitchData : VitalGlitchDataType;
    variable RXDATA145_GlitchData : VitalGlitchDataType;
    variable RXDATA146_GlitchData : VitalGlitchDataType;
    variable RXDATA147_GlitchData : VitalGlitchDataType;
    variable RXDATA148_GlitchData : VitalGlitchDataType;
    variable RXDATA149_GlitchData : VitalGlitchDataType;
    variable RXDATA14_GlitchData : VitalGlitchDataType;
    variable RXDATA150_GlitchData : VitalGlitchDataType;
    variable RXDATA151_GlitchData : VitalGlitchDataType;
    variable RXDATA152_GlitchData : VitalGlitchDataType;
    variable RXDATA153_GlitchData : VitalGlitchDataType;
    variable RXDATA154_GlitchData : VitalGlitchDataType;
    variable RXDATA155_GlitchData : VitalGlitchDataType;
    variable RXDATA156_GlitchData : VitalGlitchDataType;
    variable RXDATA157_GlitchData : VitalGlitchDataType;
    variable RXDATA158_GlitchData : VitalGlitchDataType;
    variable RXDATA159_GlitchData : VitalGlitchDataType;
    variable RXDATA15_GlitchData : VitalGlitchDataType;
    variable RXDATA160_GlitchData : VitalGlitchDataType;
    variable RXDATA161_GlitchData : VitalGlitchDataType;
    variable RXDATA162_GlitchData : VitalGlitchDataType;
    variable RXDATA163_GlitchData : VitalGlitchDataType;
    variable RXDATA16_GlitchData : VitalGlitchDataType;
    variable RXDATA17_GlitchData : VitalGlitchDataType;
    variable RXDATA18_GlitchData : VitalGlitchDataType;
    variable RXDATA19_GlitchData : VitalGlitchDataType;
    variable RXDATA20_GlitchData : VitalGlitchDataType;
    variable RXDATA210_GlitchData : VitalGlitchDataType;
    variable RXDATA211_GlitchData : VitalGlitchDataType;
    variable RXDATA212_GlitchData : VitalGlitchDataType;
    variable RXDATA213_GlitchData : VitalGlitchDataType;
    variable RXDATA214_GlitchData : VitalGlitchDataType;
    variable RXDATA215_GlitchData : VitalGlitchDataType;
    variable RXDATA216_GlitchData : VitalGlitchDataType;
    variable RXDATA217_GlitchData : VitalGlitchDataType;
    variable RXDATA218_GlitchData : VitalGlitchDataType;
    variable RXDATA219_GlitchData : VitalGlitchDataType;
    variable RXDATA21_GlitchData : VitalGlitchDataType;
    variable RXDATA220_GlitchData : VitalGlitchDataType;
    variable RXDATA221_GlitchData : VitalGlitchDataType;
    variable RXDATA222_GlitchData : VitalGlitchDataType;
    variable RXDATA223_GlitchData : VitalGlitchDataType;
    variable RXDATA224_GlitchData : VitalGlitchDataType;
    variable RXDATA225_GlitchData : VitalGlitchDataType;
    variable RXDATA226_GlitchData : VitalGlitchDataType;
    variable RXDATA227_GlitchData : VitalGlitchDataType;
    variable RXDATA228_GlitchData : VitalGlitchDataType;
    variable RXDATA229_GlitchData : VitalGlitchDataType;
    variable RXDATA22_GlitchData : VitalGlitchDataType;
    variable RXDATA230_GlitchData : VitalGlitchDataType;
    variable RXDATA231_GlitchData : VitalGlitchDataType;
    variable RXDATA232_GlitchData : VitalGlitchDataType;
    variable RXDATA233_GlitchData : VitalGlitchDataType;
    variable RXDATA234_GlitchData : VitalGlitchDataType;
    variable RXDATA235_GlitchData : VitalGlitchDataType;
    variable RXDATA236_GlitchData : VitalGlitchDataType;
    variable RXDATA237_GlitchData : VitalGlitchDataType;
    variable RXDATA238_GlitchData : VitalGlitchDataType;
    variable RXDATA239_GlitchData : VitalGlitchDataType;
    variable RXDATA23_GlitchData : VitalGlitchDataType;
    variable RXDATA240_GlitchData : VitalGlitchDataType;
    variable RXDATA241_GlitchData : VitalGlitchDataType;
    variable RXDATA242_GlitchData : VitalGlitchDataType;
    variable RXDATA243_GlitchData : VitalGlitchDataType;
    variable RXDATA244_GlitchData : VitalGlitchDataType;
    variable RXDATA245_GlitchData : VitalGlitchDataType;
    variable RXDATA246_GlitchData : VitalGlitchDataType;
    variable RXDATA247_GlitchData : VitalGlitchDataType;
    variable RXDATA248_GlitchData : VitalGlitchDataType;
    variable RXDATA249_GlitchData : VitalGlitchDataType;
    variable RXDATA24_GlitchData : VitalGlitchDataType;
    variable RXDATA250_GlitchData : VitalGlitchDataType;
    variable RXDATA251_GlitchData : VitalGlitchDataType;
    variable RXDATA252_GlitchData : VitalGlitchDataType;
    variable RXDATA253_GlitchData : VitalGlitchDataType;
    variable RXDATA254_GlitchData : VitalGlitchDataType;
    variable RXDATA255_GlitchData : VitalGlitchDataType;
    variable RXDATA256_GlitchData : VitalGlitchDataType;
    variable RXDATA257_GlitchData : VitalGlitchDataType;
    variable RXDATA258_GlitchData : VitalGlitchDataType;
    variable RXDATA259_GlitchData : VitalGlitchDataType;
    variable RXDATA25_GlitchData : VitalGlitchDataType;
    variable RXDATA260_GlitchData : VitalGlitchDataType;
    variable RXDATA261_GlitchData : VitalGlitchDataType;
    variable RXDATA262_GlitchData : VitalGlitchDataType;
    variable RXDATA263_GlitchData : VitalGlitchDataType;
    variable RXDATA26_GlitchData : VitalGlitchDataType;
    variable RXDATA27_GlitchData : VitalGlitchDataType;
    variable RXDATA28_GlitchData : VitalGlitchDataType;
    variable RXDATA29_GlitchData : VitalGlitchDataType;
    variable RXDATA30_GlitchData : VitalGlitchDataType;
    variable RXDATA310_GlitchData : VitalGlitchDataType;
    variable RXDATA311_GlitchData : VitalGlitchDataType;
    variable RXDATA312_GlitchData : VitalGlitchDataType;
    variable RXDATA313_GlitchData : VitalGlitchDataType;
    variable RXDATA314_GlitchData : VitalGlitchDataType;
    variable RXDATA315_GlitchData : VitalGlitchDataType;
    variable RXDATA316_GlitchData : VitalGlitchDataType;
    variable RXDATA317_GlitchData : VitalGlitchDataType;
    variable RXDATA318_GlitchData : VitalGlitchDataType;
    variable RXDATA319_GlitchData : VitalGlitchDataType;
    variable RXDATA31_GlitchData : VitalGlitchDataType;
    variable RXDATA320_GlitchData : VitalGlitchDataType;
    variable RXDATA321_GlitchData : VitalGlitchDataType;
    variable RXDATA322_GlitchData : VitalGlitchDataType;
    variable RXDATA323_GlitchData : VitalGlitchDataType;
    variable RXDATA324_GlitchData : VitalGlitchDataType;
    variable RXDATA325_GlitchData : VitalGlitchDataType;
    variable RXDATA326_GlitchData : VitalGlitchDataType;
    variable RXDATA327_GlitchData : VitalGlitchDataType;
    variable RXDATA328_GlitchData : VitalGlitchDataType;
    variable RXDATA329_GlitchData : VitalGlitchDataType;
    variable RXDATA32_GlitchData : VitalGlitchDataType;
    variable RXDATA330_GlitchData : VitalGlitchDataType;
    variable RXDATA331_GlitchData : VitalGlitchDataType;
    variable RXDATA332_GlitchData : VitalGlitchDataType;
    variable RXDATA333_GlitchData : VitalGlitchDataType;
    variable RXDATA334_GlitchData : VitalGlitchDataType;
    variable RXDATA335_GlitchData : VitalGlitchDataType;
    variable RXDATA336_GlitchData : VitalGlitchDataType;
    variable RXDATA337_GlitchData : VitalGlitchDataType;
    variable RXDATA338_GlitchData : VitalGlitchDataType;
    variable RXDATA339_GlitchData : VitalGlitchDataType;
    variable RXDATA33_GlitchData : VitalGlitchDataType;
    variable RXDATA340_GlitchData : VitalGlitchDataType;
    variable RXDATA341_GlitchData : VitalGlitchDataType;
    variable RXDATA342_GlitchData : VitalGlitchDataType;
    variable RXDATA343_GlitchData : VitalGlitchDataType;
    variable RXDATA344_GlitchData : VitalGlitchDataType;
    variable RXDATA345_GlitchData : VitalGlitchDataType;
    variable RXDATA346_GlitchData : VitalGlitchDataType;
    variable RXDATA347_GlitchData : VitalGlitchDataType;
    variable RXDATA348_GlitchData : VitalGlitchDataType;
    variable RXDATA349_GlitchData : VitalGlitchDataType;
    variable RXDATA34_GlitchData : VitalGlitchDataType;
    variable RXDATA350_GlitchData : VitalGlitchDataType;
    variable RXDATA351_GlitchData : VitalGlitchDataType;
    variable RXDATA352_GlitchData : VitalGlitchDataType;
    variable RXDATA353_GlitchData : VitalGlitchDataType;
    variable RXDATA354_GlitchData : VitalGlitchDataType;
    variable RXDATA355_GlitchData : VitalGlitchDataType;
    variable RXDATA356_GlitchData : VitalGlitchDataType;
    variable RXDATA357_GlitchData : VitalGlitchDataType;
    variable RXDATA358_GlitchData : VitalGlitchDataType;
    variable RXDATA359_GlitchData : VitalGlitchDataType;
    variable RXDATA35_GlitchData : VitalGlitchDataType;
    variable RXDATA360_GlitchData : VitalGlitchDataType;
    variable RXDATA361_GlitchData : VitalGlitchDataType;
    variable RXDATA362_GlitchData : VitalGlitchDataType;
    variable RXDATA363_GlitchData : VitalGlitchDataType;
    variable RXDATA36_GlitchData : VitalGlitchDataType;
    variable RXDATA37_GlitchData : VitalGlitchDataType;
    variable RXDATA38_GlitchData : VitalGlitchDataType;
    variable RXDATA39_GlitchData : VitalGlitchDataType;
    variable RXDISPERR00_GlitchData : VitalGlitchDataType;
    variable RXDISPERR01_GlitchData : VitalGlitchDataType;
    variable RXDISPERR02_GlitchData : VitalGlitchDataType;
    variable RXDISPERR03_GlitchData : VitalGlitchDataType;
    variable RXDISPERR04_GlitchData : VitalGlitchDataType;
    variable RXDISPERR05_GlitchData : VitalGlitchDataType;
    variable RXDISPERR06_GlitchData : VitalGlitchDataType;
    variable RXDISPERR07_GlitchData : VitalGlitchDataType;
    variable RXDISPERR10_GlitchData : VitalGlitchDataType;
    variable RXDISPERR11_GlitchData : VitalGlitchDataType;
    variable RXDISPERR12_GlitchData : VitalGlitchDataType;
    variable RXDISPERR13_GlitchData : VitalGlitchDataType;
    variable RXDISPERR14_GlitchData : VitalGlitchDataType;
    variable RXDISPERR15_GlitchData : VitalGlitchDataType;
    variable RXDISPERR16_GlitchData : VitalGlitchDataType;
    variable RXDISPERR17_GlitchData : VitalGlitchDataType;
    variable RXDISPERR20_GlitchData : VitalGlitchDataType;
    variable RXDISPERR21_GlitchData : VitalGlitchDataType;
    variable RXDISPERR22_GlitchData : VitalGlitchDataType;
    variable RXDISPERR23_GlitchData : VitalGlitchDataType;
    variable RXDISPERR24_GlitchData : VitalGlitchDataType;
    variable RXDISPERR25_GlitchData : VitalGlitchDataType;
    variable RXDISPERR26_GlitchData : VitalGlitchDataType;
    variable RXDISPERR27_GlitchData : VitalGlitchDataType;
    variable RXDISPERR30_GlitchData : VitalGlitchDataType;
    variable RXDISPERR31_GlitchData : VitalGlitchDataType;
    variable RXDISPERR32_GlitchData : VitalGlitchDataType;
    variable RXDISPERR33_GlitchData : VitalGlitchDataType;
    variable RXDISPERR34_GlitchData : VitalGlitchDataType;
    variable RXDISPERR35_GlitchData : VitalGlitchDataType;
    variable RXDISPERR36_GlitchData : VitalGlitchDataType;
    variable RXDISPERR37_GlitchData : VitalGlitchDataType;
    variable RXVALID00_GlitchData : VitalGlitchDataType;
    variable RXVALID01_GlitchData : VitalGlitchDataType;
    variable RXVALID02_GlitchData : VitalGlitchDataType;
    variable RXVALID03_GlitchData : VitalGlitchDataType;
    variable RXVALID04_GlitchData : VitalGlitchDataType;
    variable RXVALID05_GlitchData : VitalGlitchDataType;
    variable RXVALID06_GlitchData : VitalGlitchDataType;
    variable RXVALID07_GlitchData : VitalGlitchDataType;
    variable RXVALID10_GlitchData : VitalGlitchDataType;
    variable RXVALID11_GlitchData : VitalGlitchDataType;
    variable RXVALID12_GlitchData : VitalGlitchDataType;
    variable RXVALID13_GlitchData : VitalGlitchDataType;
    variable RXVALID14_GlitchData : VitalGlitchDataType;
    variable RXVALID15_GlitchData : VitalGlitchDataType;
    variable RXVALID16_GlitchData : VitalGlitchDataType;
    variable RXVALID17_GlitchData : VitalGlitchDataType;
    variable RXVALID20_GlitchData : VitalGlitchDataType;
    variable RXVALID21_GlitchData : VitalGlitchDataType;
    variable RXVALID22_GlitchData : VitalGlitchDataType;
    variable RXVALID23_GlitchData : VitalGlitchDataType;
    variable RXVALID24_GlitchData : VitalGlitchDataType;
    variable RXVALID25_GlitchData : VitalGlitchDataType;
    variable RXVALID26_GlitchData : VitalGlitchDataType;
    variable RXVALID27_GlitchData : VitalGlitchDataType;
    variable RXVALID30_GlitchData : VitalGlitchDataType;
    variable RXVALID31_GlitchData : VitalGlitchDataType;
    variable RXVALID32_GlitchData : VitalGlitchDataType;
    variable RXVALID33_GlitchData : VitalGlitchDataType;
    variable RXVALID34_GlitchData : VitalGlitchDataType;
    variable RXVALID35_GlitchData : VitalGlitchDataType;
    variable RXVALID36_GlitchData : VitalGlitchDataType;
    variable RXVALID37_GlitchData : VitalGlitchDataType;
    variable TSTREFCLKFAB_GlitchData : VitalGlitchDataType;
    variable TSTREFCLKOUT_GlitchData : VitalGlitchDataType;
    variable TXCTRLACK0_GlitchData : VitalGlitchDataType;
    variable TXCTRLACK1_GlitchData : VitalGlitchDataType;
    variable TXCTRLACK2_GlitchData : VitalGlitchDataType;
    variable TXCTRLACK3_GlitchData : VitalGlitchDataType;
    variable Pviol_DCLK : STD_ULOGIC := '0';
    variable Pviol_REFCLK : STD_ULOGIC := '0';
    variable Pviol_RXUSERCLKIN0 : STD_ULOGIC := '0';
    variable Pviol_RXUSERCLKIN1 : STD_ULOGIC := '0';
    variable Pviol_RXUSERCLKIN2 : STD_ULOGIC := '0';
    variable Pviol_RXUSERCLKIN3 : STD_ULOGIC := '0';
    variable Pviol_TXUSERCLKIN0 : STD_ULOGIC := '0';
    variable Pviol_TXUSERCLKIN1 : STD_ULOGIC := '0';
    variable Pviol_TXUSERCLKIN2 : STD_ULOGIC := '0';
    variable Pviol_TXUSERCLKIN3 : STD_ULOGIC := '0';
    variable PInfo_DCLK : VitalPeriodDataType := VitalPeriodDataInit;
    variable PInfo_REFCLK : VitalPeriodDataType := VitalPeriodDataInit;
    variable PInfo_RXUSERCLKIN0 : VitalPeriodDataType := VitalPeriodDataInit;
    variable PInfo_RXUSERCLKIN1 : VitalPeriodDataType := VitalPeriodDataInit;
    variable PInfo_RXUSERCLKIN2 : VitalPeriodDataType := VitalPeriodDataInit;
    variable PInfo_RXUSERCLKIN3 : VitalPeriodDataType := VitalPeriodDataInit;
    variable PInfo_TXUSERCLKIN0 : VitalPeriodDataType := VitalPeriodDataInit;
    variable PInfo_TXUSERCLKIN1 : VitalPeriodDataType := VitalPeriodDataInit;
    variable PInfo_TXUSERCLKIN2 : VitalPeriodDataType := VitalPeriodDataInit;
    variable PInfo_TXUSERCLKIN3 : VitalPeriodDataType := VitalPeriodDataInit;

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
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
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
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_DADDR_DCLK_posedge(10),
        TimingData => Tmkr_DADDR_DCLK_posedge(10),
        TestSignal => DADDR_DCLK_dly(10),
        TestSignalName => "DADDR(10)",
        TestDelay => tisd_DADDR_DCLK(10),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_DADDR_DCLK_posedge_posedge(10),
        HoldHigh => thold_DADDR_DCLK_posedge_posedge(10),
        SetupLow => tsetup_DADDR_DCLK_negedge_posedge(10),
        HoldLow => thold_DADDR_DCLK_negedge_posedge(10),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_DADDR_DCLK_posedge(11),
        TimingData => Tmkr_DADDR_DCLK_posedge(11),
        TestSignal => DADDR_DCLK_dly(11),
        TestSignalName => "DADDR(11)",
        TestDelay => tisd_DADDR_DCLK(11),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_DADDR_DCLK_posedge_posedge(11),
        HoldHigh => thold_DADDR_DCLK_posedge_posedge(11),
        SetupLow => tsetup_DADDR_DCLK_negedge_posedge(11),
        HoldLow => thold_DADDR_DCLK_negedge_posedge(11),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_DADDR_DCLK_posedge(12),
        TimingData => Tmkr_DADDR_DCLK_posedge(12),
        TestSignal => DADDR_DCLK_dly(12),
        TestSignalName => "DADDR(12)",
        TestDelay => tisd_DADDR_DCLK(12),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_DADDR_DCLK_posedge_posedge(12),
        HoldHigh => thold_DADDR_DCLK_posedge_posedge(12),
        SetupLow => tsetup_DADDR_DCLK_negedge_posedge(12),
        HoldLow => thold_DADDR_DCLK_negedge_posedge(12),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_DADDR_DCLK_posedge(13),
        TimingData => Tmkr_DADDR_DCLK_posedge(13),
        TestSignal => DADDR_DCLK_dly(13),
        TestSignalName => "DADDR(13)",
        TestDelay => tisd_DADDR_DCLK(13),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_DADDR_DCLK_posedge_posedge(13),
        HoldHigh => thold_DADDR_DCLK_posedge_posedge(13),
        SetupLow => tsetup_DADDR_DCLK_negedge_posedge(13),
        HoldLow => thold_DADDR_DCLK_negedge_posedge(13),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_DADDR_DCLK_posedge(14),
        TimingData => Tmkr_DADDR_DCLK_posedge(14),
        TestSignal => DADDR_DCLK_dly(14),
        TestSignalName => "DADDR(14)",
        TestDelay => tisd_DADDR_DCLK(14),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_DADDR_DCLK_posedge_posedge(14),
        HoldHigh => thold_DADDR_DCLK_posedge_posedge(14),
        SetupLow => tsetup_DADDR_DCLK_negedge_posedge(14),
        HoldLow => thold_DADDR_DCLK_negedge_posedge(14),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_DADDR_DCLK_posedge(15),
        TimingData => Tmkr_DADDR_DCLK_posedge(15),
        TestSignal => DADDR_DCLK_dly(15),
        TestSignalName => "DADDR(15)",
        TestDelay => tisd_DADDR_DCLK(15),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_DADDR_DCLK_posedge_posedge(15),
        HoldHigh => thold_DADDR_DCLK_posedge_posedge(15),
        SetupLow => tsetup_DADDR_DCLK_negedge_posedge(15),
        HoldLow => thold_DADDR_DCLK_negedge_posedge(15),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
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
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
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
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
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
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
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
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
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
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
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
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_DADDR_DCLK_posedge(8),
        TimingData => Tmkr_DADDR_DCLK_posedge(8),
        TestSignal => DADDR_DCLK_dly(8),
        TestSignalName => "DADDR(8)",
        TestDelay => tisd_DADDR_DCLK(8),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_DADDR_DCLK_posedge_posedge(8),
        HoldHigh => thold_DADDR_DCLK_posedge_posedge(8),
        SetupLow => tsetup_DADDR_DCLK_negedge_posedge(8),
        HoldLow => thold_DADDR_DCLK_negedge_posedge(8),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_DADDR_DCLK_posedge(9),
        TimingData => Tmkr_DADDR_DCLK_posedge(9),
        TestSignal => DADDR_DCLK_dly(9),
        TestSignalName => "DADDR(9)",
        TestDelay => tisd_DADDR_DCLK(9),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_DADDR_DCLK_posedge_posedge(9),
        HoldHigh => thold_DADDR_DCLK_posedge_posedge(9),
        SetupLow => tsetup_DADDR_DCLK_negedge_posedge(9),
        HoldLow => thold_DADDR_DCLK_negedge_posedge(9),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
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
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_DFETRAINCTRL0_DCLK_posedge,
        TimingData => Tmkr_DFETRAINCTRL0_DCLK_posedge,
        TestSignal => DFETRAINCTRL0_DCLK_dly,
        TestSignalName => "DFETRAINCTRL0",
        TestDelay => tisd_DFETRAINCTRL0_DCLK,
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_DFETRAINCTRL0_DCLK_posedge_posedge,
        HoldHigh => thold_DFETRAINCTRL0_DCLK_posedge_posedge,
        SetupLow => tsetup_DFETRAINCTRL0_DCLK_negedge_posedge,
        HoldLow => thold_DFETRAINCTRL0_DCLK_negedge_posedge,
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_DFETRAINCTRL1_DCLK_posedge,
        TimingData => Tmkr_DFETRAINCTRL1_DCLK_posedge,
        TestSignal => DFETRAINCTRL1_DCLK_dly,
        TestSignalName => "DFETRAINCTRL1",
        TestDelay => tisd_DFETRAINCTRL1_DCLK,
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_DFETRAINCTRL1_DCLK_posedge_posedge,
        HoldHigh => thold_DFETRAINCTRL1_DCLK_posedge_posedge,
        SetupLow => tsetup_DFETRAINCTRL1_DCLK_negedge_posedge,
        HoldLow => thold_DFETRAINCTRL1_DCLK_negedge_posedge,
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_DFETRAINCTRL2_DCLK_posedge,
        TimingData => Tmkr_DFETRAINCTRL2_DCLK_posedge,
        TestSignal => DFETRAINCTRL2_DCLK_dly,
        TestSignalName => "DFETRAINCTRL2",
        TestDelay => tisd_DFETRAINCTRL2_DCLK,
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_DFETRAINCTRL2_DCLK_posedge_posedge,
        HoldHigh => thold_DFETRAINCTRL2_DCLK_posedge_posedge,
        SetupLow => tsetup_DFETRAINCTRL2_DCLK_negedge_posedge,
        HoldLow => thold_DFETRAINCTRL2_DCLK_negedge_posedge,
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_DFETRAINCTRL3_DCLK_posedge,
        TimingData => Tmkr_DFETRAINCTRL3_DCLK_posedge,
        TestSignal => DFETRAINCTRL3_DCLK_dly,
        TestSignalName => "DFETRAINCTRL3",
        TestDelay => tisd_DFETRAINCTRL3_DCLK,
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_DFETRAINCTRL3_DCLK_posedge_posedge,
        HoldHigh => thold_DFETRAINCTRL3_DCLK_posedge_posedge,
        SetupLow => tsetup_DFETRAINCTRL3_DCLK_negedge_posedge,
        HoldLow => thold_DFETRAINCTRL3_DCLK_negedge_posedge,
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_DISABLEDRP_DCLK_posedge,
        TimingData => Tmkr_DISABLEDRP_DCLK_posedge,
        TestSignal => DISABLEDRP_DCLK_dly,
        TestSignalName => "DISABLEDRP",
        TestDelay => tisd_DISABLEDRP_DCLK,
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_DISABLEDRP_DCLK_posedge_posedge,
        HoldHigh => thold_DISABLEDRP_DCLK_posedge_posedge,
        SetupLow => tsetup_DISABLEDRP_DCLK_negedge_posedge,
        HoldLow => thold_DISABLEDRP_DCLK_negedge_posedge,
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
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
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
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
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
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
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
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
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
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
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
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
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
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
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
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
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
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
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
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
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
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
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
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
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
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
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
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
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
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
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
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
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
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
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_GTHINIT_DCLK_posedge,
        TimingData => Tmkr_GTHINIT_DCLK_posedge,
        TestSignal => GTHINIT_DCLK_dly,
        TestSignalName => "GTHINIT",
        TestDelay => tisd_GTHINIT_DCLK,
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_GTHINIT_DCLK_posedge_posedge,
        HoldHigh => thold_GTHINIT_DCLK_posedge_posedge,
        SetupLow => tsetup_GTHINIT_DCLK_negedge_posedge,
        HoldLow => thold_GTHINIT_DCLK_negedge_posedge,
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSLANESEL_DCLK_posedge(0),
        TimingData => Tmkr_MGMTPCSLANESEL_DCLK_posedge(0),
        TestSignal => MGMTPCSLANESEL_DCLK_dly(0),
        TestSignalName => "MGMTPCSLANESEL(0)",
        TestDelay => tisd_MGMTPCSLANESEL_DCLK(0),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSLANESEL_DCLK_posedge_posedge(0),
        HoldHigh => thold_MGMTPCSLANESEL_DCLK_posedge_posedge(0),
        SetupLow => tsetup_MGMTPCSLANESEL_DCLK_negedge_posedge(0),
        HoldLow => thold_MGMTPCSLANESEL_DCLK_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSLANESEL_DCLK_posedge(1),
        TimingData => Tmkr_MGMTPCSLANESEL_DCLK_posedge(1),
        TestSignal => MGMTPCSLANESEL_DCLK_dly(1),
        TestSignalName => "MGMTPCSLANESEL(1)",
        TestDelay => tisd_MGMTPCSLANESEL_DCLK(1),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSLANESEL_DCLK_posedge_posedge(1),
        HoldHigh => thold_MGMTPCSLANESEL_DCLK_posedge_posedge(1),
        SetupLow => tsetup_MGMTPCSLANESEL_DCLK_negedge_posedge(1),
        HoldLow => thold_MGMTPCSLANESEL_DCLK_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSLANESEL_DCLK_posedge(2),
        TimingData => Tmkr_MGMTPCSLANESEL_DCLK_posedge(2),
        TestSignal => MGMTPCSLANESEL_DCLK_dly(2),
        TestSignalName => "MGMTPCSLANESEL(2)",
        TestDelay => tisd_MGMTPCSLANESEL_DCLK(2),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSLANESEL_DCLK_posedge_posedge(2),
        HoldHigh => thold_MGMTPCSLANESEL_DCLK_posedge_posedge(2),
        SetupLow => tsetup_MGMTPCSLANESEL_DCLK_negedge_posedge(2),
        HoldLow => thold_MGMTPCSLANESEL_DCLK_negedge_posedge(2),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSLANESEL_DCLK_posedge(3),
        TimingData => Tmkr_MGMTPCSLANESEL_DCLK_posedge(3),
        TestSignal => MGMTPCSLANESEL_DCLK_dly(3),
        TestSignalName => "MGMTPCSLANESEL(3)",
        TestDelay => tisd_MGMTPCSLANESEL_DCLK(3),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSLANESEL_DCLK_posedge_posedge(3),
        HoldHigh => thold_MGMTPCSLANESEL_DCLK_posedge_posedge(3),
        SetupLow => tsetup_MGMTPCSLANESEL_DCLK_negedge_posedge(3),
        HoldLow => thold_MGMTPCSLANESEL_DCLK_negedge_posedge(3),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSMMDADDR_DCLK_posedge(0),
        TimingData => Tmkr_MGMTPCSMMDADDR_DCLK_posedge(0),
        TestSignal => MGMTPCSMMDADDR_DCLK_dly(0),
        TestSignalName => "MGMTPCSMMDADDR(0)",
        TestDelay => tisd_MGMTPCSMMDADDR_DCLK(0),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSMMDADDR_DCLK_posedge_posedge(0),
        HoldHigh => thold_MGMTPCSMMDADDR_DCLK_posedge_posedge(0),
        SetupLow => tsetup_MGMTPCSMMDADDR_DCLK_negedge_posedge(0),
        HoldLow => thold_MGMTPCSMMDADDR_DCLK_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSMMDADDR_DCLK_posedge(1),
        TimingData => Tmkr_MGMTPCSMMDADDR_DCLK_posedge(1),
        TestSignal => MGMTPCSMMDADDR_DCLK_dly(1),
        TestSignalName => "MGMTPCSMMDADDR(1)",
        TestDelay => tisd_MGMTPCSMMDADDR_DCLK(1),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSMMDADDR_DCLK_posedge_posedge(1),
        HoldHigh => thold_MGMTPCSMMDADDR_DCLK_posedge_posedge(1),
        SetupLow => tsetup_MGMTPCSMMDADDR_DCLK_negedge_posedge(1),
        HoldLow => thold_MGMTPCSMMDADDR_DCLK_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSMMDADDR_DCLK_posedge(2),
        TimingData => Tmkr_MGMTPCSMMDADDR_DCLK_posedge(2),
        TestSignal => MGMTPCSMMDADDR_DCLK_dly(2),
        TestSignalName => "MGMTPCSMMDADDR(2)",
        TestDelay => tisd_MGMTPCSMMDADDR_DCLK(2),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSMMDADDR_DCLK_posedge_posedge(2),
        HoldHigh => thold_MGMTPCSMMDADDR_DCLK_posedge_posedge(2),
        SetupLow => tsetup_MGMTPCSMMDADDR_DCLK_negedge_posedge(2),
        HoldLow => thold_MGMTPCSMMDADDR_DCLK_negedge_posedge(2),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSMMDADDR_DCLK_posedge(3),
        TimingData => Tmkr_MGMTPCSMMDADDR_DCLK_posedge(3),
        TestSignal => MGMTPCSMMDADDR_DCLK_dly(3),
        TestSignalName => "MGMTPCSMMDADDR(3)",
        TestDelay => tisd_MGMTPCSMMDADDR_DCLK(3),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSMMDADDR_DCLK_posedge_posedge(3),
        HoldHigh => thold_MGMTPCSMMDADDR_DCLK_posedge_posedge(3),
        SetupLow => tsetup_MGMTPCSMMDADDR_DCLK_negedge_posedge(3),
        HoldLow => thold_MGMTPCSMMDADDR_DCLK_negedge_posedge(3),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSMMDADDR_DCLK_posedge(4),
        TimingData => Tmkr_MGMTPCSMMDADDR_DCLK_posedge(4),
        TestSignal => MGMTPCSMMDADDR_DCLK_dly(4),
        TestSignalName => "MGMTPCSMMDADDR(4)",
        TestDelay => tisd_MGMTPCSMMDADDR_DCLK(4),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSMMDADDR_DCLK_posedge_posedge(4),
        HoldHigh => thold_MGMTPCSMMDADDR_DCLK_posedge_posedge(4),
        SetupLow => tsetup_MGMTPCSMMDADDR_DCLK_negedge_posedge(4),
        HoldLow => thold_MGMTPCSMMDADDR_DCLK_negedge_posedge(4),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSREGADDR_DCLK_posedge(0),
        TimingData => Tmkr_MGMTPCSREGADDR_DCLK_posedge(0),
        TestSignal => MGMTPCSREGADDR_DCLK_dly(0),
        TestSignalName => "MGMTPCSREGADDR(0)",
        TestDelay => tisd_MGMTPCSREGADDR_DCLK(0),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSREGADDR_DCLK_posedge_posedge(0),
        HoldHigh => thold_MGMTPCSREGADDR_DCLK_posedge_posedge(0),
        SetupLow => tsetup_MGMTPCSREGADDR_DCLK_negedge_posedge(0),
        HoldLow => thold_MGMTPCSREGADDR_DCLK_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSREGADDR_DCLK_posedge(1),
        TimingData => Tmkr_MGMTPCSREGADDR_DCLK_posedge(1),
        TestSignal => MGMTPCSREGADDR_DCLK_dly(1),
        TestSignalName => "MGMTPCSREGADDR(1)",
        TestDelay => tisd_MGMTPCSREGADDR_DCLK(1),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSREGADDR_DCLK_posedge_posedge(1),
        HoldHigh => thold_MGMTPCSREGADDR_DCLK_posedge_posedge(1),
        SetupLow => tsetup_MGMTPCSREGADDR_DCLK_negedge_posedge(1),
        HoldLow => thold_MGMTPCSREGADDR_DCLK_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSREGADDR_DCLK_posedge(10),
        TimingData => Tmkr_MGMTPCSREGADDR_DCLK_posedge(10),
        TestSignal => MGMTPCSREGADDR_DCLK_dly(10),
        TestSignalName => "MGMTPCSREGADDR(10)",
        TestDelay => tisd_MGMTPCSREGADDR_DCLK(10),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSREGADDR_DCLK_posedge_posedge(10),
        HoldHigh => thold_MGMTPCSREGADDR_DCLK_posedge_posedge(10),
        SetupLow => tsetup_MGMTPCSREGADDR_DCLK_negedge_posedge(10),
        HoldLow => thold_MGMTPCSREGADDR_DCLK_negedge_posedge(10),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSREGADDR_DCLK_posedge(11),
        TimingData => Tmkr_MGMTPCSREGADDR_DCLK_posedge(11),
        TestSignal => MGMTPCSREGADDR_DCLK_dly(11),
        TestSignalName => "MGMTPCSREGADDR(11)",
        TestDelay => tisd_MGMTPCSREGADDR_DCLK(11),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSREGADDR_DCLK_posedge_posedge(11),
        HoldHigh => thold_MGMTPCSREGADDR_DCLK_posedge_posedge(11),
        SetupLow => tsetup_MGMTPCSREGADDR_DCLK_negedge_posedge(11),
        HoldLow => thold_MGMTPCSREGADDR_DCLK_negedge_posedge(11),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSREGADDR_DCLK_posedge(12),
        TimingData => Tmkr_MGMTPCSREGADDR_DCLK_posedge(12),
        TestSignal => MGMTPCSREGADDR_DCLK_dly(12),
        TestSignalName => "MGMTPCSREGADDR(12)",
        TestDelay => tisd_MGMTPCSREGADDR_DCLK(12),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSREGADDR_DCLK_posedge_posedge(12),
        HoldHigh => thold_MGMTPCSREGADDR_DCLK_posedge_posedge(12),
        SetupLow => tsetup_MGMTPCSREGADDR_DCLK_negedge_posedge(12),
        HoldLow => thold_MGMTPCSREGADDR_DCLK_negedge_posedge(12),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSREGADDR_DCLK_posedge(13),
        TimingData => Tmkr_MGMTPCSREGADDR_DCLK_posedge(13),
        TestSignal => MGMTPCSREGADDR_DCLK_dly(13),
        TestSignalName => "MGMTPCSREGADDR(13)",
        TestDelay => tisd_MGMTPCSREGADDR_DCLK(13),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSREGADDR_DCLK_posedge_posedge(13),
        HoldHigh => thold_MGMTPCSREGADDR_DCLK_posedge_posedge(13),
        SetupLow => tsetup_MGMTPCSREGADDR_DCLK_negedge_posedge(13),
        HoldLow => thold_MGMTPCSREGADDR_DCLK_negedge_posedge(13),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSREGADDR_DCLK_posedge(14),
        TimingData => Tmkr_MGMTPCSREGADDR_DCLK_posedge(14),
        TestSignal => MGMTPCSREGADDR_DCLK_dly(14),
        TestSignalName => "MGMTPCSREGADDR(14)",
        TestDelay => tisd_MGMTPCSREGADDR_DCLK(14),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSREGADDR_DCLK_posedge_posedge(14),
        HoldHigh => thold_MGMTPCSREGADDR_DCLK_posedge_posedge(14),
        SetupLow => tsetup_MGMTPCSREGADDR_DCLK_negedge_posedge(14),
        HoldLow => thold_MGMTPCSREGADDR_DCLK_negedge_posedge(14),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSREGADDR_DCLK_posedge(15),
        TimingData => Tmkr_MGMTPCSREGADDR_DCLK_posedge(15),
        TestSignal => MGMTPCSREGADDR_DCLK_dly(15),
        TestSignalName => "MGMTPCSREGADDR(15)",
        TestDelay => tisd_MGMTPCSREGADDR_DCLK(15),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSREGADDR_DCLK_posedge_posedge(15),
        HoldHigh => thold_MGMTPCSREGADDR_DCLK_posedge_posedge(15),
        SetupLow => tsetup_MGMTPCSREGADDR_DCLK_negedge_posedge(15),
        HoldLow => thold_MGMTPCSREGADDR_DCLK_negedge_posedge(15),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSREGADDR_DCLK_posedge(2),
        TimingData => Tmkr_MGMTPCSREGADDR_DCLK_posedge(2),
        TestSignal => MGMTPCSREGADDR_DCLK_dly(2),
        TestSignalName => "MGMTPCSREGADDR(2)",
        TestDelay => tisd_MGMTPCSREGADDR_DCLK(2),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSREGADDR_DCLK_posedge_posedge(2),
        HoldHigh => thold_MGMTPCSREGADDR_DCLK_posedge_posedge(2),
        SetupLow => tsetup_MGMTPCSREGADDR_DCLK_negedge_posedge(2),
        HoldLow => thold_MGMTPCSREGADDR_DCLK_negedge_posedge(2),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSREGADDR_DCLK_posedge(3),
        TimingData => Tmkr_MGMTPCSREGADDR_DCLK_posedge(3),
        TestSignal => MGMTPCSREGADDR_DCLK_dly(3),
        TestSignalName => "MGMTPCSREGADDR(3)",
        TestDelay => tisd_MGMTPCSREGADDR_DCLK(3),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSREGADDR_DCLK_posedge_posedge(3),
        HoldHigh => thold_MGMTPCSREGADDR_DCLK_posedge_posedge(3),
        SetupLow => tsetup_MGMTPCSREGADDR_DCLK_negedge_posedge(3),
        HoldLow => thold_MGMTPCSREGADDR_DCLK_negedge_posedge(3),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSREGADDR_DCLK_posedge(4),
        TimingData => Tmkr_MGMTPCSREGADDR_DCLK_posedge(4),
        TestSignal => MGMTPCSREGADDR_DCLK_dly(4),
        TestSignalName => "MGMTPCSREGADDR(4)",
        TestDelay => tisd_MGMTPCSREGADDR_DCLK(4),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSREGADDR_DCLK_posedge_posedge(4),
        HoldHigh => thold_MGMTPCSREGADDR_DCLK_posedge_posedge(4),
        SetupLow => tsetup_MGMTPCSREGADDR_DCLK_negedge_posedge(4),
        HoldLow => thold_MGMTPCSREGADDR_DCLK_negedge_posedge(4),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSREGADDR_DCLK_posedge(5),
        TimingData => Tmkr_MGMTPCSREGADDR_DCLK_posedge(5),
        TestSignal => MGMTPCSREGADDR_DCLK_dly(5),
        TestSignalName => "MGMTPCSREGADDR(5)",
        TestDelay => tisd_MGMTPCSREGADDR_DCLK(5),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSREGADDR_DCLK_posedge_posedge(5),
        HoldHigh => thold_MGMTPCSREGADDR_DCLK_posedge_posedge(5),
        SetupLow => tsetup_MGMTPCSREGADDR_DCLK_negedge_posedge(5),
        HoldLow => thold_MGMTPCSREGADDR_DCLK_negedge_posedge(5),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSREGADDR_DCLK_posedge(6),
        TimingData => Tmkr_MGMTPCSREGADDR_DCLK_posedge(6),
        TestSignal => MGMTPCSREGADDR_DCLK_dly(6),
        TestSignalName => "MGMTPCSREGADDR(6)",
        TestDelay => tisd_MGMTPCSREGADDR_DCLK(6),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSREGADDR_DCLK_posedge_posedge(6),
        HoldHigh => thold_MGMTPCSREGADDR_DCLK_posedge_posedge(6),
        SetupLow => tsetup_MGMTPCSREGADDR_DCLK_negedge_posedge(6),
        HoldLow => thold_MGMTPCSREGADDR_DCLK_negedge_posedge(6),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSREGADDR_DCLK_posedge(7),
        TimingData => Tmkr_MGMTPCSREGADDR_DCLK_posedge(7),
        TestSignal => MGMTPCSREGADDR_DCLK_dly(7),
        TestSignalName => "MGMTPCSREGADDR(7)",
        TestDelay => tisd_MGMTPCSREGADDR_DCLK(7),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSREGADDR_DCLK_posedge_posedge(7),
        HoldHigh => thold_MGMTPCSREGADDR_DCLK_posedge_posedge(7),
        SetupLow => tsetup_MGMTPCSREGADDR_DCLK_negedge_posedge(7),
        HoldLow => thold_MGMTPCSREGADDR_DCLK_negedge_posedge(7),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSREGADDR_DCLK_posedge(8),
        TimingData => Tmkr_MGMTPCSREGADDR_DCLK_posedge(8),
        TestSignal => MGMTPCSREGADDR_DCLK_dly(8),
        TestSignalName => "MGMTPCSREGADDR(8)",
        TestDelay => tisd_MGMTPCSREGADDR_DCLK(8),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSREGADDR_DCLK_posedge_posedge(8),
        HoldHigh => thold_MGMTPCSREGADDR_DCLK_posedge_posedge(8),
        SetupLow => tsetup_MGMTPCSREGADDR_DCLK_negedge_posedge(8),
        HoldLow => thold_MGMTPCSREGADDR_DCLK_negedge_posedge(8),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSREGADDR_DCLK_posedge(9),
        TimingData => Tmkr_MGMTPCSREGADDR_DCLK_posedge(9),
        TestSignal => MGMTPCSREGADDR_DCLK_dly(9),
        TestSignalName => "MGMTPCSREGADDR(9)",
        TestDelay => tisd_MGMTPCSREGADDR_DCLK(9),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSREGADDR_DCLK_posedge_posedge(9),
        HoldHigh => thold_MGMTPCSREGADDR_DCLK_posedge_posedge(9),
        SetupLow => tsetup_MGMTPCSREGADDR_DCLK_negedge_posedge(9),
        HoldLow => thold_MGMTPCSREGADDR_DCLK_negedge_posedge(9),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSREGRD_DCLK_posedge,
        TimingData => Tmkr_MGMTPCSREGRD_DCLK_posedge,
        TestSignal => MGMTPCSREGRD_DCLK_dly,
        TestSignalName => "MGMTPCSREGRD",
        TestDelay => tisd_MGMTPCSREGRD_DCLK,
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSREGRD_DCLK_posedge_posedge,
        HoldHigh => thold_MGMTPCSREGRD_DCLK_posedge_posedge,
        SetupLow => tsetup_MGMTPCSREGRD_DCLK_negedge_posedge,
        HoldLow => thold_MGMTPCSREGRD_DCLK_negedge_posedge,
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSREGWR_DCLK_posedge,
        TimingData => Tmkr_MGMTPCSREGWR_DCLK_posedge,
        TestSignal => MGMTPCSREGWR_DCLK_dly,
        TestSignalName => "MGMTPCSREGWR",
        TestDelay => tisd_MGMTPCSREGWR_DCLK,
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSREGWR_DCLK_posedge_posedge,
        HoldHigh => thold_MGMTPCSREGWR_DCLK_posedge_posedge,
        SetupLow => tsetup_MGMTPCSREGWR_DCLK_negedge_posedge,
        HoldLow => thold_MGMTPCSREGWR_DCLK_negedge_posedge,
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSWRDATA_DCLK_posedge(0),
        TimingData => Tmkr_MGMTPCSWRDATA_DCLK_posedge(0),
        TestSignal => MGMTPCSWRDATA_DCLK_dly(0),
        TestSignalName => "MGMTPCSWRDATA(0)",
        TestDelay => tisd_MGMTPCSWRDATA_DCLK(0),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSWRDATA_DCLK_posedge_posedge(0),
        HoldHigh => thold_MGMTPCSWRDATA_DCLK_posedge_posedge(0),
        SetupLow => tsetup_MGMTPCSWRDATA_DCLK_negedge_posedge(0),
        HoldLow => thold_MGMTPCSWRDATA_DCLK_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSWRDATA_DCLK_posedge(1),
        TimingData => Tmkr_MGMTPCSWRDATA_DCLK_posedge(1),
        TestSignal => MGMTPCSWRDATA_DCLK_dly(1),
        TestSignalName => "MGMTPCSWRDATA(1)",
        TestDelay => tisd_MGMTPCSWRDATA_DCLK(1),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSWRDATA_DCLK_posedge_posedge(1),
        HoldHigh => thold_MGMTPCSWRDATA_DCLK_posedge_posedge(1),
        SetupLow => tsetup_MGMTPCSWRDATA_DCLK_negedge_posedge(1),
        HoldLow => thold_MGMTPCSWRDATA_DCLK_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSWRDATA_DCLK_posedge(10),
        TimingData => Tmkr_MGMTPCSWRDATA_DCLK_posedge(10),
        TestSignal => MGMTPCSWRDATA_DCLK_dly(10),
        TestSignalName => "MGMTPCSWRDATA(10)",
        TestDelay => tisd_MGMTPCSWRDATA_DCLK(10),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSWRDATA_DCLK_posedge_posedge(10),
        HoldHigh => thold_MGMTPCSWRDATA_DCLK_posedge_posedge(10),
        SetupLow => tsetup_MGMTPCSWRDATA_DCLK_negedge_posedge(10),
        HoldLow => thold_MGMTPCSWRDATA_DCLK_negedge_posedge(10),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSWRDATA_DCLK_posedge(11),
        TimingData => Tmkr_MGMTPCSWRDATA_DCLK_posedge(11),
        TestSignal => MGMTPCSWRDATA_DCLK_dly(11),
        TestSignalName => "MGMTPCSWRDATA(11)",
        TestDelay => tisd_MGMTPCSWRDATA_DCLK(11),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSWRDATA_DCLK_posedge_posedge(11),
        HoldHigh => thold_MGMTPCSWRDATA_DCLK_posedge_posedge(11),
        SetupLow => tsetup_MGMTPCSWRDATA_DCLK_negedge_posedge(11),
        HoldLow => thold_MGMTPCSWRDATA_DCLK_negedge_posedge(11),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSWRDATA_DCLK_posedge(12),
        TimingData => Tmkr_MGMTPCSWRDATA_DCLK_posedge(12),
        TestSignal => MGMTPCSWRDATA_DCLK_dly(12),
        TestSignalName => "MGMTPCSWRDATA(12)",
        TestDelay => tisd_MGMTPCSWRDATA_DCLK(12),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSWRDATA_DCLK_posedge_posedge(12),
        HoldHigh => thold_MGMTPCSWRDATA_DCLK_posedge_posedge(12),
        SetupLow => tsetup_MGMTPCSWRDATA_DCLK_negedge_posedge(12),
        HoldLow => thold_MGMTPCSWRDATA_DCLK_negedge_posedge(12),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSWRDATA_DCLK_posedge(13),
        TimingData => Tmkr_MGMTPCSWRDATA_DCLK_posedge(13),
        TestSignal => MGMTPCSWRDATA_DCLK_dly(13),
        TestSignalName => "MGMTPCSWRDATA(13)",
        TestDelay => tisd_MGMTPCSWRDATA_DCLK(13),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSWRDATA_DCLK_posedge_posedge(13),
        HoldHigh => thold_MGMTPCSWRDATA_DCLK_posedge_posedge(13),
        SetupLow => tsetup_MGMTPCSWRDATA_DCLK_negedge_posedge(13),
        HoldLow => thold_MGMTPCSWRDATA_DCLK_negedge_posedge(13),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSWRDATA_DCLK_posedge(14),
        TimingData => Tmkr_MGMTPCSWRDATA_DCLK_posedge(14),
        TestSignal => MGMTPCSWRDATA_DCLK_dly(14),
        TestSignalName => "MGMTPCSWRDATA(14)",
        TestDelay => tisd_MGMTPCSWRDATA_DCLK(14),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSWRDATA_DCLK_posedge_posedge(14),
        HoldHigh => thold_MGMTPCSWRDATA_DCLK_posedge_posedge(14),
        SetupLow => tsetup_MGMTPCSWRDATA_DCLK_negedge_posedge(14),
        HoldLow => thold_MGMTPCSWRDATA_DCLK_negedge_posedge(14),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSWRDATA_DCLK_posedge(15),
        TimingData => Tmkr_MGMTPCSWRDATA_DCLK_posedge(15),
        TestSignal => MGMTPCSWRDATA_DCLK_dly(15),
        TestSignalName => "MGMTPCSWRDATA(15)",
        TestDelay => tisd_MGMTPCSWRDATA_DCLK(15),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSWRDATA_DCLK_posedge_posedge(15),
        HoldHigh => thold_MGMTPCSWRDATA_DCLK_posedge_posedge(15),
        SetupLow => tsetup_MGMTPCSWRDATA_DCLK_negedge_posedge(15),
        HoldLow => thold_MGMTPCSWRDATA_DCLK_negedge_posedge(15),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSWRDATA_DCLK_posedge(2),
        TimingData => Tmkr_MGMTPCSWRDATA_DCLK_posedge(2),
        TestSignal => MGMTPCSWRDATA_DCLK_dly(2),
        TestSignalName => "MGMTPCSWRDATA(2)",
        TestDelay => tisd_MGMTPCSWRDATA_DCLK(2),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSWRDATA_DCLK_posedge_posedge(2),
        HoldHigh => thold_MGMTPCSWRDATA_DCLK_posedge_posedge(2),
        SetupLow => tsetup_MGMTPCSWRDATA_DCLK_negedge_posedge(2),
        HoldLow => thold_MGMTPCSWRDATA_DCLK_negedge_posedge(2),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSWRDATA_DCLK_posedge(3),
        TimingData => Tmkr_MGMTPCSWRDATA_DCLK_posedge(3),
        TestSignal => MGMTPCSWRDATA_DCLK_dly(3),
        TestSignalName => "MGMTPCSWRDATA(3)",
        TestDelay => tisd_MGMTPCSWRDATA_DCLK(3),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSWRDATA_DCLK_posedge_posedge(3),
        HoldHigh => thold_MGMTPCSWRDATA_DCLK_posedge_posedge(3),
        SetupLow => tsetup_MGMTPCSWRDATA_DCLK_negedge_posedge(3),
        HoldLow => thold_MGMTPCSWRDATA_DCLK_negedge_posedge(3),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSWRDATA_DCLK_posedge(4),
        TimingData => Tmkr_MGMTPCSWRDATA_DCLK_posedge(4),
        TestSignal => MGMTPCSWRDATA_DCLK_dly(4),
        TestSignalName => "MGMTPCSWRDATA(4)",
        TestDelay => tisd_MGMTPCSWRDATA_DCLK(4),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSWRDATA_DCLK_posedge_posedge(4),
        HoldHigh => thold_MGMTPCSWRDATA_DCLK_posedge_posedge(4),
        SetupLow => tsetup_MGMTPCSWRDATA_DCLK_negedge_posedge(4),
        HoldLow => thold_MGMTPCSWRDATA_DCLK_negedge_posedge(4),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSWRDATA_DCLK_posedge(5),
        TimingData => Tmkr_MGMTPCSWRDATA_DCLK_posedge(5),
        TestSignal => MGMTPCSWRDATA_DCLK_dly(5),
        TestSignalName => "MGMTPCSWRDATA(5)",
        TestDelay => tisd_MGMTPCSWRDATA_DCLK(5),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSWRDATA_DCLK_posedge_posedge(5),
        HoldHigh => thold_MGMTPCSWRDATA_DCLK_posedge_posedge(5),
        SetupLow => tsetup_MGMTPCSWRDATA_DCLK_negedge_posedge(5),
        HoldLow => thold_MGMTPCSWRDATA_DCLK_negedge_posedge(5),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSWRDATA_DCLK_posedge(6),
        TimingData => Tmkr_MGMTPCSWRDATA_DCLK_posedge(6),
        TestSignal => MGMTPCSWRDATA_DCLK_dly(6),
        TestSignalName => "MGMTPCSWRDATA(6)",
        TestDelay => tisd_MGMTPCSWRDATA_DCLK(6),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSWRDATA_DCLK_posedge_posedge(6),
        HoldHigh => thold_MGMTPCSWRDATA_DCLK_posedge_posedge(6),
        SetupLow => tsetup_MGMTPCSWRDATA_DCLK_negedge_posedge(6),
        HoldLow => thold_MGMTPCSWRDATA_DCLK_negedge_posedge(6),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSWRDATA_DCLK_posedge(7),
        TimingData => Tmkr_MGMTPCSWRDATA_DCLK_posedge(7),
        TestSignal => MGMTPCSWRDATA_DCLK_dly(7),
        TestSignalName => "MGMTPCSWRDATA(7)",
        TestDelay => tisd_MGMTPCSWRDATA_DCLK(7),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSWRDATA_DCLK_posedge_posedge(7),
        HoldHigh => thold_MGMTPCSWRDATA_DCLK_posedge_posedge(7),
        SetupLow => tsetup_MGMTPCSWRDATA_DCLK_negedge_posedge(7),
        HoldLow => thold_MGMTPCSWRDATA_DCLK_negedge_posedge(7),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSWRDATA_DCLK_posedge(8),
        TimingData => Tmkr_MGMTPCSWRDATA_DCLK_posedge(8),
        TestSignal => MGMTPCSWRDATA_DCLK_dly(8),
        TestSignalName => "MGMTPCSWRDATA(8)",
        TestDelay => tisd_MGMTPCSWRDATA_DCLK(8),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSWRDATA_DCLK_posedge_posedge(8),
        HoldHigh => thold_MGMTPCSWRDATA_DCLK_posedge_posedge(8),
        SetupLow => tsetup_MGMTPCSWRDATA_DCLK_negedge_posedge(8),
        HoldLow => thold_MGMTPCSWRDATA_DCLK_negedge_posedge(8),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_MGMTPCSWRDATA_DCLK_posedge(9),
        TimingData => Tmkr_MGMTPCSWRDATA_DCLK_posedge(9),
        TestSignal => MGMTPCSWRDATA_DCLK_dly(9),
        TestSignalName => "MGMTPCSWRDATA(9)",
        TestDelay => tisd_MGMTPCSWRDATA_DCLK(9),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_MGMTPCSWRDATA_DCLK_posedge_posedge(9),
        HoldHigh => thold_MGMTPCSWRDATA_DCLK_posedge_posedge(9),
        SetupLow => tsetup_MGMTPCSWRDATA_DCLK_negedge_posedge(9),
        HoldLow => thold_MGMTPCSWRDATA_DCLK_negedge_posedge(9),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_PLLPCSCLKDIV_DCLK_posedge(0),
        TimingData => Tmkr_PLLPCSCLKDIV_DCLK_posedge(0),
        TestSignal => PLLPCSCLKDIV_DCLK_dly(0),
        TestSignalName => "PLLPCSCLKDIV(0)",
        TestDelay => tisd_PLLPCSCLKDIV_DCLK(0),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_PLLPCSCLKDIV_DCLK_posedge_posedge(0),
        HoldHigh => thold_PLLPCSCLKDIV_DCLK_posedge_posedge(0),
        SetupLow => tsetup_PLLPCSCLKDIV_DCLK_negedge_posedge(0),
        HoldLow => thold_PLLPCSCLKDIV_DCLK_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_PLLPCSCLKDIV_DCLK_posedge(1),
        TimingData => Tmkr_PLLPCSCLKDIV_DCLK_posedge(1),
        TestSignal => PLLPCSCLKDIV_DCLK_dly(1),
        TestSignalName => "PLLPCSCLKDIV(1)",
        TestDelay => tisd_PLLPCSCLKDIV_DCLK(1),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_PLLPCSCLKDIV_DCLK_posedge_posedge(1),
        HoldHigh => thold_PLLPCSCLKDIV_DCLK_posedge_posedge(1),
        SetupLow => tsetup_PLLPCSCLKDIV_DCLK_negedge_posedge(1),
        HoldLow => thold_PLLPCSCLKDIV_DCLK_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_PLLPCSCLKDIV_DCLK_posedge(2),
        TimingData => Tmkr_PLLPCSCLKDIV_DCLK_posedge(2),
        TestSignal => PLLPCSCLKDIV_DCLK_dly(2),
        TestSignalName => "PLLPCSCLKDIV(2)",
        TestDelay => tisd_PLLPCSCLKDIV_DCLK(2),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_PLLPCSCLKDIV_DCLK_posedge_posedge(2),
        HoldHigh => thold_PLLPCSCLKDIV_DCLK_posedge_posedge(2),
        SetupLow => tsetup_PLLPCSCLKDIV_DCLK_negedge_posedge(2),
        HoldLow => thold_PLLPCSCLKDIV_DCLK_negedge_posedge(2),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_PLLPCSCLKDIV_DCLK_posedge(3),
        TimingData => Tmkr_PLLPCSCLKDIV_DCLK_posedge(3),
        TestSignal => PLLPCSCLKDIV_DCLK_dly(3),
        TestSignalName => "PLLPCSCLKDIV(3)",
        TestDelay => tisd_PLLPCSCLKDIV_DCLK(3),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_PLLPCSCLKDIV_DCLK_posedge_posedge(3),
        HoldHigh => thold_PLLPCSCLKDIV_DCLK_posedge_posedge(3),
        SetupLow => tsetup_PLLPCSCLKDIV_DCLK_negedge_posedge(3),
        HoldLow => thold_PLLPCSCLKDIV_DCLK_negedge_posedge(3),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_PLLPCSCLKDIV_DCLK_posedge(4),
        TimingData => Tmkr_PLLPCSCLKDIV_DCLK_posedge(4),
        TestSignal => PLLPCSCLKDIV_DCLK_dly(4),
        TestSignalName => "PLLPCSCLKDIV(4)",
        TestDelay => tisd_PLLPCSCLKDIV_DCLK(4),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_PLLPCSCLKDIV_DCLK_posedge_posedge(4),
        HoldHigh => thold_PLLPCSCLKDIV_DCLK_posedge_posedge(4),
        SetupLow => tsetup_PLLPCSCLKDIV_DCLK_negedge_posedge(4),
        HoldLow => thold_PLLPCSCLKDIV_DCLK_negedge_posedge(4),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_PLLPCSCLKDIV_DCLK_posedge(5),
        TimingData => Tmkr_PLLPCSCLKDIV_DCLK_posedge(5),
        TestSignal => PLLPCSCLKDIV_DCLK_dly(5),
        TestSignalName => "PLLPCSCLKDIV(5)",
        TestDelay => tisd_PLLPCSCLKDIV_DCLK(5),
        RefSignal => DCLK_dly,
        RefSignalName => "DCLK",
        RefDelay => ticd_DCLK,
        SetupHigh => tsetup_PLLPCSCLKDIV_DCLK_posedge_posedge(5),
        HoldHigh => thold_PLLPCSCLKDIV_DCLK_posedge_posedge(5),
        SetupLow => tsetup_PLLPCSCLKDIV_DCLK_negedge_posedge(5),
        HoldLow => thold_PLLPCSCLKDIV_DCLK_negedge_posedge(5),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_RXBUFRESET0_RXUSERCLKIN0_posedge,
        TimingData => Tmkr_RXBUFRESET0_RXUSERCLKIN0_posedge,
        TestSignal => RXBUFRESET0_RXUSERCLKIN0_dly,
        TestSignalName => "RXBUFRESET0",
        TestDelay => tisd_RXBUFRESET0_RXUSERCLKIN0,
        RefSignal => RXUSERCLKIN0_dly,
        RefSignalName => "RXUSERCLKIN0",
        RefDelay => ticd_RXUSERCLKIN0,
        SetupHigh => tsetup_RXBUFRESET0_RXUSERCLKIN0_posedge_posedge,
        HoldHigh => thold_RXBUFRESET0_RXUSERCLKIN0_posedge_posedge,
        SetupLow => tsetup_RXBUFRESET0_RXUSERCLKIN0_negedge_posedge,
        HoldLow => thold_RXBUFRESET0_RXUSERCLKIN0_negedge_posedge,
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_RXBUFRESET1_RXUSERCLKIN1_posedge,
        TimingData => Tmkr_RXBUFRESET1_RXUSERCLKIN1_posedge,
        TestSignal => RXBUFRESET1_RXUSERCLKIN1_dly,
        TestSignalName => "RXBUFRESET1",
        TestDelay => tisd_RXBUFRESET1_RXUSERCLKIN1,
        RefSignal => RXUSERCLKIN1_dly,
        RefSignalName => "RXUSERCLKIN1",
        RefDelay => ticd_RXUSERCLKIN1,
        SetupHigh => tsetup_RXBUFRESET1_RXUSERCLKIN1_posedge_posedge,
        HoldHigh => thold_RXBUFRESET1_RXUSERCLKIN1_posedge_posedge,
        SetupLow => tsetup_RXBUFRESET1_RXUSERCLKIN1_negedge_posedge,
        HoldLow => thold_RXBUFRESET1_RXUSERCLKIN1_negedge_posedge,
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_RXBUFRESET2_RXUSERCLKIN2_posedge,
        TimingData => Tmkr_RXBUFRESET2_RXUSERCLKIN2_posedge,
        TestSignal => RXBUFRESET2_RXUSERCLKIN2_dly,
        TestSignalName => "RXBUFRESET2",
        TestDelay => tisd_RXBUFRESET2_RXUSERCLKIN2,
        RefSignal => RXUSERCLKIN2_dly,
        RefSignalName => "RXUSERCLKIN2",
        RefDelay => ticd_RXUSERCLKIN2,
        SetupHigh => tsetup_RXBUFRESET2_RXUSERCLKIN2_posedge_posedge,
        HoldHigh => thold_RXBUFRESET2_RXUSERCLKIN2_posedge_posedge,
        SetupLow => tsetup_RXBUFRESET2_RXUSERCLKIN2_negedge_posedge,
        HoldLow => thold_RXBUFRESET2_RXUSERCLKIN2_negedge_posedge,
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_RXBUFRESET3_RXUSERCLKIN3_posedge,
        TimingData => Tmkr_RXBUFRESET3_RXUSERCLKIN3_posedge,
        TestSignal => RXBUFRESET3_RXUSERCLKIN3_dly,
        TestSignalName => "RXBUFRESET3",
        TestDelay => tisd_RXBUFRESET3_RXUSERCLKIN3,
        RefSignal => RXUSERCLKIN3_dly,
        RefSignalName => "RXUSERCLKIN3",
        RefDelay => ticd_RXUSERCLKIN3,
        SetupHigh => tsetup_RXBUFRESET3_RXUSERCLKIN3_posedge_posedge,
        HoldHigh => thold_RXBUFRESET3_RXUSERCLKIN3_posedge_posedge,
        SetupLow => tsetup_RXBUFRESET3_RXUSERCLKIN3_negedge_posedge,
        HoldLow => thold_RXBUFRESET3_RXUSERCLKIN3_negedge_posedge,
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_RXENCOMMADET0_RXUSERCLKIN0_posedge,
        TimingData => Tmkr_RXENCOMMADET0_RXUSERCLKIN0_posedge,
        TestSignal => RXENCOMMADET0_RXUSERCLKIN0_dly,
        TestSignalName => "RXENCOMMADET0",
        TestDelay => tisd_RXENCOMMADET0_RXUSERCLKIN0,
        RefSignal => RXUSERCLKIN0_dly,
        RefSignalName => "RXUSERCLKIN0",
        RefDelay => ticd_RXUSERCLKIN0,
        SetupHigh => tsetup_RXENCOMMADET0_RXUSERCLKIN0_posedge_posedge,
        HoldHigh => thold_RXENCOMMADET0_RXUSERCLKIN0_posedge_posedge,
        SetupLow => tsetup_RXENCOMMADET0_RXUSERCLKIN0_negedge_posedge,
        HoldLow => thold_RXENCOMMADET0_RXUSERCLKIN0_negedge_posedge,
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_RXENCOMMADET1_RXUSERCLKIN1_posedge,
        TimingData => Tmkr_RXENCOMMADET1_RXUSERCLKIN1_posedge,
        TestSignal => RXENCOMMADET1_RXUSERCLKIN1_dly,
        TestSignalName => "RXENCOMMADET1",
        TestDelay => tisd_RXENCOMMADET1_RXUSERCLKIN1,
        RefSignal => RXUSERCLKIN1_dly,
        RefSignalName => "RXUSERCLKIN1",
        RefDelay => ticd_RXUSERCLKIN1,
        SetupHigh => tsetup_RXENCOMMADET1_RXUSERCLKIN1_posedge_posedge,
        HoldHigh => thold_RXENCOMMADET1_RXUSERCLKIN1_posedge_posedge,
        SetupLow => tsetup_RXENCOMMADET1_RXUSERCLKIN1_negedge_posedge,
        HoldLow => thold_RXENCOMMADET1_RXUSERCLKIN1_negedge_posedge,
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_RXENCOMMADET2_RXUSERCLKIN2_posedge,
        TimingData => Tmkr_RXENCOMMADET2_RXUSERCLKIN2_posedge,
        TestSignal => RXENCOMMADET2_RXUSERCLKIN2_dly,
        TestSignalName => "RXENCOMMADET2",
        TestDelay => tisd_RXENCOMMADET2_RXUSERCLKIN2,
        RefSignal => RXUSERCLKIN2_dly,
        RefSignalName => "RXUSERCLKIN2",
        RefDelay => ticd_RXUSERCLKIN2,
        SetupHigh => tsetup_RXENCOMMADET2_RXUSERCLKIN2_posedge_posedge,
        HoldHigh => thold_RXENCOMMADET2_RXUSERCLKIN2_posedge_posedge,
        SetupLow => tsetup_RXENCOMMADET2_RXUSERCLKIN2_negedge_posedge,
        HoldLow => thold_RXENCOMMADET2_RXUSERCLKIN2_negedge_posedge,
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_RXENCOMMADET3_RXUSERCLKIN3_posedge,
        TimingData => Tmkr_RXENCOMMADET3_RXUSERCLKIN3_posedge,
        TestSignal => RXENCOMMADET3_RXUSERCLKIN3_dly,
        TestSignalName => "RXENCOMMADET3",
        TestDelay => tisd_RXENCOMMADET3_RXUSERCLKIN3,
        RefSignal => RXUSERCLKIN3_dly,
        RefSignalName => "RXUSERCLKIN3",
        RefDelay => ticd_RXUSERCLKIN3,
        SetupHigh => tsetup_RXENCOMMADET3_RXUSERCLKIN3_posedge_posedge,
        HoldHigh => thold_RXENCOMMADET3_RXUSERCLKIN3_posedge_posedge,
        SetupLow => tsetup_RXENCOMMADET3_RXUSERCLKIN3_negedge_posedge,
        HoldLow => thold_RXENCOMMADET3_RXUSERCLKIN3_negedge_posedge,
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_RXPOLARITY0_RXUSERCLKIN0_posedge,
        TimingData => Tmkr_RXPOLARITY0_RXUSERCLKIN0_posedge,
        TestSignal => RXPOLARITY0_RXUSERCLKIN0_dly,
        TestSignalName => "RXPOLARITY0",
        TestDelay => tisd_RXPOLARITY0_RXUSERCLKIN0,
        RefSignal => RXUSERCLKIN0_dly,
        RefSignalName => "RXUSERCLKIN0",
        RefDelay => ticd_RXUSERCLKIN0,
        SetupHigh => tsetup_RXPOLARITY0_RXUSERCLKIN0_posedge_posedge,
        HoldHigh => thold_RXPOLARITY0_RXUSERCLKIN0_posedge_posedge,
        SetupLow => tsetup_RXPOLARITY0_RXUSERCLKIN0_negedge_posedge,
        HoldLow => thold_RXPOLARITY0_RXUSERCLKIN0_negedge_posedge,
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_RXPOLARITY1_RXUSERCLKIN1_posedge,
        TimingData => Tmkr_RXPOLARITY1_RXUSERCLKIN1_posedge,
        TestSignal => RXPOLARITY1_RXUSERCLKIN1_dly,
        TestSignalName => "RXPOLARITY1",
        TestDelay => tisd_RXPOLARITY1_RXUSERCLKIN1,
        RefSignal => RXUSERCLKIN1_dly,
        RefSignalName => "RXUSERCLKIN1",
        RefDelay => ticd_RXUSERCLKIN1,
        SetupHigh => tsetup_RXPOLARITY1_RXUSERCLKIN1_posedge_posedge,
        HoldHigh => thold_RXPOLARITY1_RXUSERCLKIN1_posedge_posedge,
        SetupLow => tsetup_RXPOLARITY1_RXUSERCLKIN1_negedge_posedge,
        HoldLow => thold_RXPOLARITY1_RXUSERCLKIN1_negedge_posedge,
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_RXPOLARITY2_RXUSERCLKIN2_posedge,
        TimingData => Tmkr_RXPOLARITY2_RXUSERCLKIN2_posedge,
        TestSignal => RXPOLARITY2_RXUSERCLKIN2_dly,
        TestSignalName => "RXPOLARITY2",
        TestDelay => tisd_RXPOLARITY2_RXUSERCLKIN2,
        RefSignal => RXUSERCLKIN2_dly,
        RefSignalName => "RXUSERCLKIN2",
        RefDelay => ticd_RXUSERCLKIN2,
        SetupHigh => tsetup_RXPOLARITY2_RXUSERCLKIN2_posedge_posedge,
        HoldHigh => thold_RXPOLARITY2_RXUSERCLKIN2_posedge_posedge,
        SetupLow => tsetup_RXPOLARITY2_RXUSERCLKIN2_negedge_posedge,
        HoldLow => thold_RXPOLARITY2_RXUSERCLKIN2_negedge_posedge,
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_RXPOLARITY3_RXUSERCLKIN3_posedge,
        TimingData => Tmkr_RXPOLARITY3_RXUSERCLKIN3_posedge,
        TestSignal => RXPOLARITY3_RXUSERCLKIN3_dly,
        TestSignalName => "RXPOLARITY3",
        TestDelay => tisd_RXPOLARITY3_RXUSERCLKIN3,
        RefSignal => RXUSERCLKIN3_dly,
        RefSignalName => "RXUSERCLKIN3",
        RefDelay => ticd_RXUSERCLKIN3,
        SetupHigh => tsetup_RXPOLARITY3_RXUSERCLKIN3_posedge_posedge,
        HoldHigh => thold_RXPOLARITY3_RXUSERCLKIN3_posedge_posedge,
        SetupLow => tsetup_RXPOLARITY3_RXUSERCLKIN3_negedge_posedge,
        HoldLow => thold_RXPOLARITY3_RXUSERCLKIN3_negedge_posedge,
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_RXPOWERDOWN0_TXUSERCLKIN0_posedge(0),
        TimingData => Tmkr_RXPOWERDOWN0_TXUSERCLKIN0_posedge(0),
        TestSignal => RXPOWERDOWN0_TXUSERCLKIN0_dly(0),
        TestSignalName => "RXPOWERDOWN0(0)",
        TestDelay => tisd_RXPOWERDOWN0_TXUSERCLKIN0(0),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_RXPOWERDOWN0_TXUSERCLKIN0_posedge_posedge(0),
        HoldHigh => thold_RXPOWERDOWN0_TXUSERCLKIN0_posedge_posedge(0),
        SetupLow => tsetup_RXPOWERDOWN0_TXUSERCLKIN0_negedge_posedge(0),
        HoldLow => thold_RXPOWERDOWN0_TXUSERCLKIN0_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_RXPOWERDOWN0_TXUSERCLKIN0_posedge(1),
        TimingData => Tmkr_RXPOWERDOWN0_TXUSERCLKIN0_posedge(1),
        TestSignal => RXPOWERDOWN0_TXUSERCLKIN0_dly(1),
        TestSignalName => "RXPOWERDOWN0(1)",
        TestDelay => tisd_RXPOWERDOWN0_TXUSERCLKIN0(1),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_RXPOWERDOWN0_TXUSERCLKIN0_posedge_posedge(1),
        HoldHigh => thold_RXPOWERDOWN0_TXUSERCLKIN0_posedge_posedge(1),
        SetupLow => tsetup_RXPOWERDOWN0_TXUSERCLKIN0_negedge_posedge(1),
        HoldLow => thold_RXPOWERDOWN0_TXUSERCLKIN0_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_RXPOWERDOWN1_TXUSERCLKIN1_posedge(0),
        TimingData => Tmkr_RXPOWERDOWN1_TXUSERCLKIN1_posedge(0),
        TestSignal => RXPOWERDOWN1_TXUSERCLKIN1_dly(0),
        TestSignalName => "RXPOWERDOWN1(0)",
        TestDelay => tisd_RXPOWERDOWN1_TXUSERCLKIN1(0),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_RXPOWERDOWN1_TXUSERCLKIN1_posedge_posedge(0),
        HoldHigh => thold_RXPOWERDOWN1_TXUSERCLKIN1_posedge_posedge(0),
        SetupLow => tsetup_RXPOWERDOWN1_TXUSERCLKIN1_negedge_posedge(0),
        HoldLow => thold_RXPOWERDOWN1_TXUSERCLKIN1_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_RXPOWERDOWN1_TXUSERCLKIN1_posedge(1),
        TimingData => Tmkr_RXPOWERDOWN1_TXUSERCLKIN1_posedge(1),
        TestSignal => RXPOWERDOWN1_TXUSERCLKIN1_dly(1),
        TestSignalName => "RXPOWERDOWN1(1)",
        TestDelay => tisd_RXPOWERDOWN1_TXUSERCLKIN1(1),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_RXPOWERDOWN1_TXUSERCLKIN1_posedge_posedge(1),
        HoldHigh => thold_RXPOWERDOWN1_TXUSERCLKIN1_posedge_posedge(1),
        SetupLow => tsetup_RXPOWERDOWN1_TXUSERCLKIN1_negedge_posedge(1),
        HoldLow => thold_RXPOWERDOWN1_TXUSERCLKIN1_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_RXPOWERDOWN2_TXUSERCLKIN2_posedge(0),
        TimingData => Tmkr_RXPOWERDOWN2_TXUSERCLKIN2_posedge(0),
        TestSignal => RXPOWERDOWN2_TXUSERCLKIN2_dly(0),
        TestSignalName => "RXPOWERDOWN2(0)",
        TestDelay => tisd_RXPOWERDOWN2_TXUSERCLKIN2(0),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_RXPOWERDOWN2_TXUSERCLKIN2_posedge_posedge(0),
        HoldHigh => thold_RXPOWERDOWN2_TXUSERCLKIN2_posedge_posedge(0),
        SetupLow => tsetup_RXPOWERDOWN2_TXUSERCLKIN2_negedge_posedge(0),
        HoldLow => thold_RXPOWERDOWN2_TXUSERCLKIN2_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_RXPOWERDOWN2_TXUSERCLKIN2_posedge(1),
        TimingData => Tmkr_RXPOWERDOWN2_TXUSERCLKIN2_posedge(1),
        TestSignal => RXPOWERDOWN2_TXUSERCLKIN2_dly(1),
        TestSignalName => "RXPOWERDOWN2(1)",
        TestDelay => tisd_RXPOWERDOWN2_TXUSERCLKIN2(1),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_RXPOWERDOWN2_TXUSERCLKIN2_posedge_posedge(1),
        HoldHigh => thold_RXPOWERDOWN2_TXUSERCLKIN2_posedge_posedge(1),
        SetupLow => tsetup_RXPOWERDOWN2_TXUSERCLKIN2_negedge_posedge(1),
        HoldLow => thold_RXPOWERDOWN2_TXUSERCLKIN2_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_RXPOWERDOWN3_TXUSERCLKIN3_posedge(0),
        TimingData => Tmkr_RXPOWERDOWN3_TXUSERCLKIN3_posedge(0),
        TestSignal => RXPOWERDOWN3_TXUSERCLKIN3_dly(0),
        TestSignalName => "RXPOWERDOWN3(0)",
        TestDelay => tisd_RXPOWERDOWN3_TXUSERCLKIN3(0),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_RXPOWERDOWN3_TXUSERCLKIN3_posedge_posedge(0),
        HoldHigh => thold_RXPOWERDOWN3_TXUSERCLKIN3_posedge_posedge(0),
        SetupLow => tsetup_RXPOWERDOWN3_TXUSERCLKIN3_negedge_posedge(0),
        HoldLow => thold_RXPOWERDOWN3_TXUSERCLKIN3_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_RXPOWERDOWN3_TXUSERCLKIN3_posedge(1),
        TimingData => Tmkr_RXPOWERDOWN3_TXUSERCLKIN3_posedge(1),
        TestSignal => RXPOWERDOWN3_TXUSERCLKIN3_dly(1),
        TestSignalName => "RXPOWERDOWN3(1)",
        TestDelay => tisd_RXPOWERDOWN3_TXUSERCLKIN3(1),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_RXPOWERDOWN3_TXUSERCLKIN3_posedge_posedge(1),
        HoldHigh => thold_RXPOWERDOWN3_TXUSERCLKIN3_posedge_posedge(1),
        SetupLow => tsetup_RXPOWERDOWN3_TXUSERCLKIN3_negedge_posedge(1),
        HoldLow => thold_RXPOWERDOWN3_TXUSERCLKIN3_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_RXRATE0_TXUSERCLKIN0_posedge(0),
        TimingData => Tmkr_RXRATE0_TXUSERCLKIN0_posedge(0),
        TestSignal => RXRATE0_TXUSERCLKIN0_dly(0),
        TestSignalName => "RXRATE0(0)",
        TestDelay => tisd_RXRATE0_TXUSERCLKIN0(0),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_RXRATE0_TXUSERCLKIN0_posedge_posedge(0),
        HoldHigh => thold_RXRATE0_TXUSERCLKIN0_posedge_posedge(0),
        SetupLow => tsetup_RXRATE0_TXUSERCLKIN0_negedge_posedge(0),
        HoldLow => thold_RXRATE0_TXUSERCLKIN0_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_RXRATE0_TXUSERCLKIN0_posedge(1),
        TimingData => Tmkr_RXRATE0_TXUSERCLKIN0_posedge(1),
        TestSignal => RXRATE0_TXUSERCLKIN0_dly(1),
        TestSignalName => "RXRATE0(1)",
        TestDelay => tisd_RXRATE0_TXUSERCLKIN0(1),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_RXRATE0_TXUSERCLKIN0_posedge_posedge(1),
        HoldHigh => thold_RXRATE0_TXUSERCLKIN0_posedge_posedge(1),
        SetupLow => tsetup_RXRATE0_TXUSERCLKIN0_negedge_posedge(1),
        HoldLow => thold_RXRATE0_TXUSERCLKIN0_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_RXRATE1_TXUSERCLKIN1_posedge(0),
        TimingData => Tmkr_RXRATE1_TXUSERCLKIN1_posedge(0),
        TestSignal => RXRATE1_TXUSERCLKIN1_dly(0),
        TestSignalName => "RXRATE1(0)",
        TestDelay => tisd_RXRATE1_TXUSERCLKIN1(0),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_RXRATE1_TXUSERCLKIN1_posedge_posedge(0),
        HoldHigh => thold_RXRATE1_TXUSERCLKIN1_posedge_posedge(0),
        SetupLow => tsetup_RXRATE1_TXUSERCLKIN1_negedge_posedge(0),
        HoldLow => thold_RXRATE1_TXUSERCLKIN1_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_RXRATE1_TXUSERCLKIN1_posedge(1),
        TimingData => Tmkr_RXRATE1_TXUSERCLKIN1_posedge(1),
        TestSignal => RXRATE1_TXUSERCLKIN1_dly(1),
        TestSignalName => "RXRATE1(1)",
        TestDelay => tisd_RXRATE1_TXUSERCLKIN1(1),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_RXRATE1_TXUSERCLKIN1_posedge_posedge(1),
        HoldHigh => thold_RXRATE1_TXUSERCLKIN1_posedge_posedge(1),
        SetupLow => tsetup_RXRATE1_TXUSERCLKIN1_negedge_posedge(1),
        HoldLow => thold_RXRATE1_TXUSERCLKIN1_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_RXRATE2_TXUSERCLKIN2_posedge(0),
        TimingData => Tmkr_RXRATE2_TXUSERCLKIN2_posedge(0),
        TestSignal => RXRATE2_TXUSERCLKIN2_dly(0),
        TestSignalName => "RXRATE2(0)",
        TestDelay => tisd_RXRATE2_TXUSERCLKIN2(0),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_RXRATE2_TXUSERCLKIN2_posedge_posedge(0),
        HoldHigh => thold_RXRATE2_TXUSERCLKIN2_posedge_posedge(0),
        SetupLow => tsetup_RXRATE2_TXUSERCLKIN2_negedge_posedge(0),
        HoldLow => thold_RXRATE2_TXUSERCLKIN2_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_RXRATE2_TXUSERCLKIN2_posedge(1),
        TimingData => Tmkr_RXRATE2_TXUSERCLKIN2_posedge(1),
        TestSignal => RXRATE2_TXUSERCLKIN2_dly(1),
        TestSignalName => "RXRATE2(1)",
        TestDelay => tisd_RXRATE2_TXUSERCLKIN2(1),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_RXRATE2_TXUSERCLKIN2_posedge_posedge(1),
        HoldHigh => thold_RXRATE2_TXUSERCLKIN2_posedge_posedge(1),
        SetupLow => tsetup_RXRATE2_TXUSERCLKIN2_negedge_posedge(1),
        HoldLow => thold_RXRATE2_TXUSERCLKIN2_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_RXRATE3_TXUSERCLKIN3_posedge(0),
        TimingData => Tmkr_RXRATE3_TXUSERCLKIN3_posedge(0),
        TestSignal => RXRATE3_TXUSERCLKIN3_dly(0),
        TestSignalName => "RXRATE3(0)",
        TestDelay => tisd_RXRATE3_TXUSERCLKIN3(0),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_RXRATE3_TXUSERCLKIN3_posedge_posedge(0),
        HoldHigh => thold_RXRATE3_TXUSERCLKIN3_posedge_posedge(0),
        SetupLow => tsetup_RXRATE3_TXUSERCLKIN3_negedge_posedge(0),
        HoldLow => thold_RXRATE3_TXUSERCLKIN3_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_RXRATE3_TXUSERCLKIN3_posedge(1),
        TimingData => Tmkr_RXRATE3_TXUSERCLKIN3_posedge(1),
        TestSignal => RXRATE3_TXUSERCLKIN3_dly(1),
        TestSignalName => "RXRATE3(1)",
        TestDelay => tisd_RXRATE3_TXUSERCLKIN3(1),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_RXRATE3_TXUSERCLKIN3_posedge_posedge(1),
        HoldHigh => thold_RXRATE3_TXUSERCLKIN3_posedge_posedge(1),
        SetupLow => tsetup_RXRATE3_TXUSERCLKIN3_negedge_posedge(1),
        HoldLow => thold_RXRATE3_TXUSERCLKIN3_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_SAMPLERATE0_TXUSERCLKIN0_posedge(0),
        TimingData => Tmkr_SAMPLERATE0_TXUSERCLKIN0_posedge(0),
        TestSignal => SAMPLERATE0_TXUSERCLKIN0_dly(0),
        TestSignalName => "SAMPLERATE0(0)",
        TestDelay => tisd_SAMPLERATE0_TXUSERCLKIN0(0),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_SAMPLERATE0_TXUSERCLKIN0_posedge_posedge(0),
        HoldHigh => thold_SAMPLERATE0_TXUSERCLKIN0_posedge_posedge(0),
        SetupLow => tsetup_SAMPLERATE0_TXUSERCLKIN0_negedge_posedge(0),
        HoldLow => thold_SAMPLERATE0_TXUSERCLKIN0_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_SAMPLERATE0_TXUSERCLKIN0_posedge(1),
        TimingData => Tmkr_SAMPLERATE0_TXUSERCLKIN0_posedge(1),
        TestSignal => SAMPLERATE0_TXUSERCLKIN0_dly(1),
        TestSignalName => "SAMPLERATE0(1)",
        TestDelay => tisd_SAMPLERATE0_TXUSERCLKIN0(1),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_SAMPLERATE0_TXUSERCLKIN0_posedge_posedge(1),
        HoldHigh => thold_SAMPLERATE0_TXUSERCLKIN0_posedge_posedge(1),
        SetupLow => tsetup_SAMPLERATE0_TXUSERCLKIN0_negedge_posedge(1),
        HoldLow => thold_SAMPLERATE0_TXUSERCLKIN0_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_SAMPLERATE0_TXUSERCLKIN0_posedge(2),
        TimingData => Tmkr_SAMPLERATE0_TXUSERCLKIN0_posedge(2),
        TestSignal => SAMPLERATE0_TXUSERCLKIN0_dly(2),
        TestSignalName => "SAMPLERATE0(2)",
        TestDelay => tisd_SAMPLERATE0_TXUSERCLKIN0(2),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_SAMPLERATE0_TXUSERCLKIN0_posedge_posedge(2),
        HoldHigh => thold_SAMPLERATE0_TXUSERCLKIN0_posedge_posedge(2),
        SetupLow => tsetup_SAMPLERATE0_TXUSERCLKIN0_negedge_posedge(2),
        HoldLow => thold_SAMPLERATE0_TXUSERCLKIN0_negedge_posedge(2),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_SAMPLERATE1_TXUSERCLKIN1_posedge(0),
        TimingData => Tmkr_SAMPLERATE1_TXUSERCLKIN1_posedge(0),
        TestSignal => SAMPLERATE1_TXUSERCLKIN1_dly(0),
        TestSignalName => "SAMPLERATE1(0)",
        TestDelay => tisd_SAMPLERATE1_TXUSERCLKIN1(0),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_SAMPLERATE1_TXUSERCLKIN1_posedge_posedge(0),
        HoldHigh => thold_SAMPLERATE1_TXUSERCLKIN1_posedge_posedge(0),
        SetupLow => tsetup_SAMPLERATE1_TXUSERCLKIN1_negedge_posedge(0),
        HoldLow => thold_SAMPLERATE1_TXUSERCLKIN1_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_SAMPLERATE1_TXUSERCLKIN1_posedge(1),
        TimingData => Tmkr_SAMPLERATE1_TXUSERCLKIN1_posedge(1),
        TestSignal => SAMPLERATE1_TXUSERCLKIN1_dly(1),
        TestSignalName => "SAMPLERATE1(1)",
        TestDelay => tisd_SAMPLERATE1_TXUSERCLKIN1(1),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_SAMPLERATE1_TXUSERCLKIN1_posedge_posedge(1),
        HoldHigh => thold_SAMPLERATE1_TXUSERCLKIN1_posedge_posedge(1),
        SetupLow => tsetup_SAMPLERATE1_TXUSERCLKIN1_negedge_posedge(1),
        HoldLow => thold_SAMPLERATE1_TXUSERCLKIN1_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_SAMPLERATE1_TXUSERCLKIN1_posedge(2),
        TimingData => Tmkr_SAMPLERATE1_TXUSERCLKIN1_posedge(2),
        TestSignal => SAMPLERATE1_TXUSERCLKIN1_dly(2),
        TestSignalName => "SAMPLERATE1(2)",
        TestDelay => tisd_SAMPLERATE1_TXUSERCLKIN1(2),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_SAMPLERATE1_TXUSERCLKIN1_posedge_posedge(2),
        HoldHigh => thold_SAMPLERATE1_TXUSERCLKIN1_posedge_posedge(2),
        SetupLow => tsetup_SAMPLERATE1_TXUSERCLKIN1_negedge_posedge(2),
        HoldLow => thold_SAMPLERATE1_TXUSERCLKIN1_negedge_posedge(2),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_SAMPLERATE2_TXUSERCLKIN2_posedge(0),
        TimingData => Tmkr_SAMPLERATE2_TXUSERCLKIN2_posedge(0),
        TestSignal => SAMPLERATE2_TXUSERCLKIN2_dly(0),
        TestSignalName => "SAMPLERATE2(0)",
        TestDelay => tisd_SAMPLERATE2_TXUSERCLKIN2(0),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_SAMPLERATE2_TXUSERCLKIN2_posedge_posedge(0),
        HoldHigh => thold_SAMPLERATE2_TXUSERCLKIN2_posedge_posedge(0),
        SetupLow => tsetup_SAMPLERATE2_TXUSERCLKIN2_negedge_posedge(0),
        HoldLow => thold_SAMPLERATE2_TXUSERCLKIN2_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_SAMPLERATE2_TXUSERCLKIN2_posedge(1),
        TimingData => Tmkr_SAMPLERATE2_TXUSERCLKIN2_posedge(1),
        TestSignal => SAMPLERATE2_TXUSERCLKIN2_dly(1),
        TestSignalName => "SAMPLERATE2(1)",
        TestDelay => tisd_SAMPLERATE2_TXUSERCLKIN2(1),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_SAMPLERATE2_TXUSERCLKIN2_posedge_posedge(1),
        HoldHigh => thold_SAMPLERATE2_TXUSERCLKIN2_posedge_posedge(1),
        SetupLow => tsetup_SAMPLERATE2_TXUSERCLKIN2_negedge_posedge(1),
        HoldLow => thold_SAMPLERATE2_TXUSERCLKIN2_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_SAMPLERATE2_TXUSERCLKIN2_posedge(2),
        TimingData => Tmkr_SAMPLERATE2_TXUSERCLKIN2_posedge(2),
        TestSignal => SAMPLERATE2_TXUSERCLKIN2_dly(2),
        TestSignalName => "SAMPLERATE2(2)",
        TestDelay => tisd_SAMPLERATE2_TXUSERCLKIN2(2),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_SAMPLERATE2_TXUSERCLKIN2_posedge_posedge(2),
        HoldHigh => thold_SAMPLERATE2_TXUSERCLKIN2_posedge_posedge(2),
        SetupLow => tsetup_SAMPLERATE2_TXUSERCLKIN2_negedge_posedge(2),
        HoldLow => thold_SAMPLERATE2_TXUSERCLKIN2_negedge_posedge(2),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_SAMPLERATE3_TXUSERCLKIN3_posedge(0),
        TimingData => Tmkr_SAMPLERATE3_TXUSERCLKIN3_posedge(0),
        TestSignal => SAMPLERATE3_TXUSERCLKIN3_dly(0),
        TestSignalName => "SAMPLERATE3(0)",
        TestDelay => tisd_SAMPLERATE3_TXUSERCLKIN3(0),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_SAMPLERATE3_TXUSERCLKIN3_posedge_posedge(0),
        HoldHigh => thold_SAMPLERATE3_TXUSERCLKIN3_posedge_posedge(0),
        SetupLow => tsetup_SAMPLERATE3_TXUSERCLKIN3_negedge_posedge(0),
        HoldLow => thold_SAMPLERATE3_TXUSERCLKIN3_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_SAMPLERATE3_TXUSERCLKIN3_posedge(1),
        TimingData => Tmkr_SAMPLERATE3_TXUSERCLKIN3_posedge(1),
        TestSignal => SAMPLERATE3_TXUSERCLKIN3_dly(1),
        TestSignalName => "SAMPLERATE3(1)",
        TestDelay => tisd_SAMPLERATE3_TXUSERCLKIN3(1),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_SAMPLERATE3_TXUSERCLKIN3_posedge_posedge(1),
        HoldHigh => thold_SAMPLERATE3_TXUSERCLKIN3_posedge_posedge(1),
        SetupLow => tsetup_SAMPLERATE3_TXUSERCLKIN3_negedge_posedge(1),
        HoldLow => thold_SAMPLERATE3_TXUSERCLKIN3_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_SAMPLERATE3_TXUSERCLKIN3_posedge(2),
        TimingData => Tmkr_SAMPLERATE3_TXUSERCLKIN3_posedge(2),
        TestSignal => SAMPLERATE3_TXUSERCLKIN3_dly(2),
        TestSignalName => "SAMPLERATE3(2)",
        TestDelay => tisd_SAMPLERATE3_TXUSERCLKIN3(2),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_SAMPLERATE3_TXUSERCLKIN3_posedge_posedge(2),
        HoldHigh => thold_SAMPLERATE3_TXUSERCLKIN3_posedge_posedge(2),
        SetupLow => tsetup_SAMPLERATE3_TXUSERCLKIN3_negedge_posedge(2),
        HoldLow => thold_SAMPLERATE3_TXUSERCLKIN3_negedge_posedge(2),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXBUFRESET0_TXUSERCLKIN0_posedge,
        TimingData => Tmkr_TXBUFRESET0_TXUSERCLKIN0_posedge,
        TestSignal => TXBUFRESET0_TXUSERCLKIN0_dly,
        TestSignalName => "TXBUFRESET0",
        TestDelay => tisd_TXBUFRESET0_TXUSERCLKIN0,
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXBUFRESET0_TXUSERCLKIN0_posedge_posedge,
        HoldHigh => thold_TXBUFRESET0_TXUSERCLKIN0_posedge_posedge,
        SetupLow => tsetup_TXBUFRESET0_TXUSERCLKIN0_negedge_posedge,
        HoldLow => thold_TXBUFRESET0_TXUSERCLKIN0_negedge_posedge,
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXBUFRESET1_TXUSERCLKIN1_posedge,
        TimingData => Tmkr_TXBUFRESET1_TXUSERCLKIN1_posedge,
        TestSignal => TXBUFRESET1_TXUSERCLKIN1_dly,
        TestSignalName => "TXBUFRESET1",
        TestDelay => tisd_TXBUFRESET1_TXUSERCLKIN1,
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXBUFRESET1_TXUSERCLKIN1_posedge_posedge,
        HoldHigh => thold_TXBUFRESET1_TXUSERCLKIN1_posedge_posedge,
        SetupLow => tsetup_TXBUFRESET1_TXUSERCLKIN1_negedge_posedge,
        HoldLow => thold_TXBUFRESET1_TXUSERCLKIN1_negedge_posedge,
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXBUFRESET2_TXUSERCLKIN2_posedge,
        TimingData => Tmkr_TXBUFRESET2_TXUSERCLKIN2_posedge,
        TestSignal => TXBUFRESET2_TXUSERCLKIN2_dly,
        TestSignalName => "TXBUFRESET2",
        TestDelay => tisd_TXBUFRESET2_TXUSERCLKIN2,
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXBUFRESET2_TXUSERCLKIN2_posedge_posedge,
        HoldHigh => thold_TXBUFRESET2_TXUSERCLKIN2_posedge_posedge,
        SetupLow => tsetup_TXBUFRESET2_TXUSERCLKIN2_negedge_posedge,
        HoldLow => thold_TXBUFRESET2_TXUSERCLKIN2_negedge_posedge,
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXBUFRESET3_TXUSERCLKIN3_posedge,
        TimingData => Tmkr_TXBUFRESET3_TXUSERCLKIN3_posedge,
        TestSignal => TXBUFRESET3_TXUSERCLKIN3_dly,
        TestSignalName => "TXBUFRESET3",
        TestDelay => tisd_TXBUFRESET3_TXUSERCLKIN3,
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXBUFRESET3_TXUSERCLKIN3_posedge_posedge,
        HoldHigh => thold_TXBUFRESET3_TXUSERCLKIN3_posedge_posedge,
        SetupLow => tsetup_TXBUFRESET3_TXUSERCLKIN3_negedge_posedge,
        HoldLow => thold_TXBUFRESET3_TXUSERCLKIN3_negedge_posedge,
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL0_TXUSERCLKIN0_posedge(0),
        TimingData => Tmkr_TXCTRL0_TXUSERCLKIN0_posedge(0),
        TestSignal => TXCTRL0_TXUSERCLKIN0_dly(0),
        TestSignalName => "TXCTRL0(0)",
        TestDelay => tisd_TXCTRL0_TXUSERCLKIN0(0),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXCTRL0_TXUSERCLKIN0_posedge_posedge(0),
        HoldHigh => thold_TXCTRL0_TXUSERCLKIN0_posedge_posedge(0),
        SetupLow => tsetup_TXCTRL0_TXUSERCLKIN0_negedge_posedge(0),
        HoldLow => thold_TXCTRL0_TXUSERCLKIN0_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL0_TXUSERCLKIN0_posedge(1),
        TimingData => Tmkr_TXCTRL0_TXUSERCLKIN0_posedge(1),
        TestSignal => TXCTRL0_TXUSERCLKIN0_dly(1),
        TestSignalName => "TXCTRL0(1)",
        TestDelay => tisd_TXCTRL0_TXUSERCLKIN0(1),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXCTRL0_TXUSERCLKIN0_posedge_posedge(1),
        HoldHigh => thold_TXCTRL0_TXUSERCLKIN0_posedge_posedge(1),
        SetupLow => tsetup_TXCTRL0_TXUSERCLKIN0_negedge_posedge(1),
        HoldLow => thold_TXCTRL0_TXUSERCLKIN0_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL0_TXUSERCLKIN0_posedge(2),
        TimingData => Tmkr_TXCTRL0_TXUSERCLKIN0_posedge(2),
        TestSignal => TXCTRL0_TXUSERCLKIN0_dly(2),
        TestSignalName => "TXCTRL0(2)",
        TestDelay => tisd_TXCTRL0_TXUSERCLKIN0(2),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXCTRL0_TXUSERCLKIN0_posedge_posedge(2),
        HoldHigh => thold_TXCTRL0_TXUSERCLKIN0_posedge_posedge(2),
        SetupLow => tsetup_TXCTRL0_TXUSERCLKIN0_negedge_posedge(2),
        HoldLow => thold_TXCTRL0_TXUSERCLKIN0_negedge_posedge(2),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL0_TXUSERCLKIN0_posedge(3),
        TimingData => Tmkr_TXCTRL0_TXUSERCLKIN0_posedge(3),
        TestSignal => TXCTRL0_TXUSERCLKIN0_dly(3),
        TestSignalName => "TXCTRL0(3)",
        TestDelay => tisd_TXCTRL0_TXUSERCLKIN0(3),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXCTRL0_TXUSERCLKIN0_posedge_posedge(3),
        HoldHigh => thold_TXCTRL0_TXUSERCLKIN0_posedge_posedge(3),
        SetupLow => tsetup_TXCTRL0_TXUSERCLKIN0_negedge_posedge(3),
        HoldLow => thold_TXCTRL0_TXUSERCLKIN0_negedge_posedge(3),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL0_TXUSERCLKIN0_posedge(4),
        TimingData => Tmkr_TXCTRL0_TXUSERCLKIN0_posedge(4),
        TestSignal => TXCTRL0_TXUSERCLKIN0_dly(4),
        TestSignalName => "TXCTRL0(4)",
        TestDelay => tisd_TXCTRL0_TXUSERCLKIN0(4),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXCTRL0_TXUSERCLKIN0_posedge_posedge(4),
        HoldHigh => thold_TXCTRL0_TXUSERCLKIN0_posedge_posedge(4),
        SetupLow => tsetup_TXCTRL0_TXUSERCLKIN0_negedge_posedge(4),
        HoldLow => thold_TXCTRL0_TXUSERCLKIN0_negedge_posedge(4),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL0_TXUSERCLKIN0_posedge(5),
        TimingData => Tmkr_TXCTRL0_TXUSERCLKIN0_posedge(5),
        TestSignal => TXCTRL0_TXUSERCLKIN0_dly(5),
        TestSignalName => "TXCTRL0(5)",
        TestDelay => tisd_TXCTRL0_TXUSERCLKIN0(5),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXCTRL0_TXUSERCLKIN0_posedge_posedge(5),
        HoldHigh => thold_TXCTRL0_TXUSERCLKIN0_posedge_posedge(5),
        SetupLow => tsetup_TXCTRL0_TXUSERCLKIN0_negedge_posedge(5),
        HoldLow => thold_TXCTRL0_TXUSERCLKIN0_negedge_posedge(5),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL0_TXUSERCLKIN0_posedge(6),
        TimingData => Tmkr_TXCTRL0_TXUSERCLKIN0_posedge(6),
        TestSignal => TXCTRL0_TXUSERCLKIN0_dly(6),
        TestSignalName => "TXCTRL0(6)",
        TestDelay => tisd_TXCTRL0_TXUSERCLKIN0(6),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXCTRL0_TXUSERCLKIN0_posedge_posedge(6),
        HoldHigh => thold_TXCTRL0_TXUSERCLKIN0_posedge_posedge(6),
        SetupLow => tsetup_TXCTRL0_TXUSERCLKIN0_negedge_posedge(6),
        HoldLow => thold_TXCTRL0_TXUSERCLKIN0_negedge_posedge(6),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL0_TXUSERCLKIN0_posedge(7),
        TimingData => Tmkr_TXCTRL0_TXUSERCLKIN0_posedge(7),
        TestSignal => TXCTRL0_TXUSERCLKIN0_dly(7),
        TestSignalName => "TXCTRL0(7)",
        TestDelay => tisd_TXCTRL0_TXUSERCLKIN0(7),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXCTRL0_TXUSERCLKIN0_posedge_posedge(7),
        HoldHigh => thold_TXCTRL0_TXUSERCLKIN0_posedge_posedge(7),
        SetupLow => tsetup_TXCTRL0_TXUSERCLKIN0_negedge_posedge(7),
        HoldLow => thold_TXCTRL0_TXUSERCLKIN0_negedge_posedge(7),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL1_TXUSERCLKIN1_posedge(0),
        TimingData => Tmkr_TXCTRL1_TXUSERCLKIN1_posedge(0),
        TestSignal => TXCTRL1_TXUSERCLKIN1_dly(0),
        TestSignalName => "TXCTRL1(0)",
        TestDelay => tisd_TXCTRL1_TXUSERCLKIN1(0),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXCTRL1_TXUSERCLKIN1_posedge_posedge(0),
        HoldHigh => thold_TXCTRL1_TXUSERCLKIN1_posedge_posedge(0),
        SetupLow => tsetup_TXCTRL1_TXUSERCLKIN1_negedge_posedge(0),
        HoldLow => thold_TXCTRL1_TXUSERCLKIN1_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL1_TXUSERCLKIN1_posedge(1),
        TimingData => Tmkr_TXCTRL1_TXUSERCLKIN1_posedge(1),
        TestSignal => TXCTRL1_TXUSERCLKIN1_dly(1),
        TestSignalName => "TXCTRL1(1)",
        TestDelay => tisd_TXCTRL1_TXUSERCLKIN1(1),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXCTRL1_TXUSERCLKIN1_posedge_posedge(1),
        HoldHigh => thold_TXCTRL1_TXUSERCLKIN1_posedge_posedge(1),
        SetupLow => tsetup_TXCTRL1_TXUSERCLKIN1_negedge_posedge(1),
        HoldLow => thold_TXCTRL1_TXUSERCLKIN1_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL1_TXUSERCLKIN1_posedge(2),
        TimingData => Tmkr_TXCTRL1_TXUSERCLKIN1_posedge(2),
        TestSignal => TXCTRL1_TXUSERCLKIN1_dly(2),
        TestSignalName => "TXCTRL1(2)",
        TestDelay => tisd_TXCTRL1_TXUSERCLKIN1(2),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXCTRL1_TXUSERCLKIN1_posedge_posedge(2),
        HoldHigh => thold_TXCTRL1_TXUSERCLKIN1_posedge_posedge(2),
        SetupLow => tsetup_TXCTRL1_TXUSERCLKIN1_negedge_posedge(2),
        HoldLow => thold_TXCTRL1_TXUSERCLKIN1_negedge_posedge(2),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL1_TXUSERCLKIN1_posedge(3),
        TimingData => Tmkr_TXCTRL1_TXUSERCLKIN1_posedge(3),
        TestSignal => TXCTRL1_TXUSERCLKIN1_dly(3),
        TestSignalName => "TXCTRL1(3)",
        TestDelay => tisd_TXCTRL1_TXUSERCLKIN1(3),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXCTRL1_TXUSERCLKIN1_posedge_posedge(3),
        HoldHigh => thold_TXCTRL1_TXUSERCLKIN1_posedge_posedge(3),
        SetupLow => tsetup_TXCTRL1_TXUSERCLKIN1_negedge_posedge(3),
        HoldLow => thold_TXCTRL1_TXUSERCLKIN1_negedge_posedge(3),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL1_TXUSERCLKIN1_posedge(4),
        TimingData => Tmkr_TXCTRL1_TXUSERCLKIN1_posedge(4),
        TestSignal => TXCTRL1_TXUSERCLKIN1_dly(4),
        TestSignalName => "TXCTRL1(4)",
        TestDelay => tisd_TXCTRL1_TXUSERCLKIN1(4),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXCTRL1_TXUSERCLKIN1_posedge_posedge(4),
        HoldHigh => thold_TXCTRL1_TXUSERCLKIN1_posedge_posedge(4),
        SetupLow => tsetup_TXCTRL1_TXUSERCLKIN1_negedge_posedge(4),
        HoldLow => thold_TXCTRL1_TXUSERCLKIN1_negedge_posedge(4),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL1_TXUSERCLKIN1_posedge(5),
        TimingData => Tmkr_TXCTRL1_TXUSERCLKIN1_posedge(5),
        TestSignal => TXCTRL1_TXUSERCLKIN1_dly(5),
        TestSignalName => "TXCTRL1(5)",
        TestDelay => tisd_TXCTRL1_TXUSERCLKIN1(5),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXCTRL1_TXUSERCLKIN1_posedge_posedge(5),
        HoldHigh => thold_TXCTRL1_TXUSERCLKIN1_posedge_posedge(5),
        SetupLow => tsetup_TXCTRL1_TXUSERCLKIN1_negedge_posedge(5),
        HoldLow => thold_TXCTRL1_TXUSERCLKIN1_negedge_posedge(5),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL1_TXUSERCLKIN1_posedge(6),
        TimingData => Tmkr_TXCTRL1_TXUSERCLKIN1_posedge(6),
        TestSignal => TXCTRL1_TXUSERCLKIN1_dly(6),
        TestSignalName => "TXCTRL1(6)",
        TestDelay => tisd_TXCTRL1_TXUSERCLKIN1(6),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXCTRL1_TXUSERCLKIN1_posedge_posedge(6),
        HoldHigh => thold_TXCTRL1_TXUSERCLKIN1_posedge_posedge(6),
        SetupLow => tsetup_TXCTRL1_TXUSERCLKIN1_negedge_posedge(6),
        HoldLow => thold_TXCTRL1_TXUSERCLKIN1_negedge_posedge(6),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL1_TXUSERCLKIN1_posedge(7),
        TimingData => Tmkr_TXCTRL1_TXUSERCLKIN1_posedge(7),
        TestSignal => TXCTRL1_TXUSERCLKIN1_dly(7),
        TestSignalName => "TXCTRL1(7)",
        TestDelay => tisd_TXCTRL1_TXUSERCLKIN1(7),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXCTRL1_TXUSERCLKIN1_posedge_posedge(7),
        HoldHigh => thold_TXCTRL1_TXUSERCLKIN1_posedge_posedge(7),
        SetupLow => tsetup_TXCTRL1_TXUSERCLKIN1_negedge_posedge(7),
        HoldLow => thold_TXCTRL1_TXUSERCLKIN1_negedge_posedge(7),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL2_TXUSERCLKIN2_posedge(0),
        TimingData => Tmkr_TXCTRL2_TXUSERCLKIN2_posedge(0),
        TestSignal => TXCTRL2_TXUSERCLKIN2_dly(0),
        TestSignalName => "TXCTRL2(0)",
        TestDelay => tisd_TXCTRL2_TXUSERCLKIN2(0),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXCTRL2_TXUSERCLKIN2_posedge_posedge(0),
        HoldHigh => thold_TXCTRL2_TXUSERCLKIN2_posedge_posedge(0),
        SetupLow => tsetup_TXCTRL2_TXUSERCLKIN2_negedge_posedge(0),
        HoldLow => thold_TXCTRL2_TXUSERCLKIN2_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL2_TXUSERCLKIN2_posedge(1),
        TimingData => Tmkr_TXCTRL2_TXUSERCLKIN2_posedge(1),
        TestSignal => TXCTRL2_TXUSERCLKIN2_dly(1),
        TestSignalName => "TXCTRL2(1)",
        TestDelay => tisd_TXCTRL2_TXUSERCLKIN2(1),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXCTRL2_TXUSERCLKIN2_posedge_posedge(1),
        HoldHigh => thold_TXCTRL2_TXUSERCLKIN2_posedge_posedge(1),
        SetupLow => tsetup_TXCTRL2_TXUSERCLKIN2_negedge_posedge(1),
        HoldLow => thold_TXCTRL2_TXUSERCLKIN2_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL2_TXUSERCLKIN2_posedge(2),
        TimingData => Tmkr_TXCTRL2_TXUSERCLKIN2_posedge(2),
        TestSignal => TXCTRL2_TXUSERCLKIN2_dly(2),
        TestSignalName => "TXCTRL2(2)",
        TestDelay => tisd_TXCTRL2_TXUSERCLKIN2(2),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXCTRL2_TXUSERCLKIN2_posedge_posedge(2),
        HoldHigh => thold_TXCTRL2_TXUSERCLKIN2_posedge_posedge(2),
        SetupLow => tsetup_TXCTRL2_TXUSERCLKIN2_negedge_posedge(2),
        HoldLow => thold_TXCTRL2_TXUSERCLKIN2_negedge_posedge(2),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL2_TXUSERCLKIN2_posedge(3),
        TimingData => Tmkr_TXCTRL2_TXUSERCLKIN2_posedge(3),
        TestSignal => TXCTRL2_TXUSERCLKIN2_dly(3),
        TestSignalName => "TXCTRL2(3)",
        TestDelay => tisd_TXCTRL2_TXUSERCLKIN2(3),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXCTRL2_TXUSERCLKIN2_posedge_posedge(3),
        HoldHigh => thold_TXCTRL2_TXUSERCLKIN2_posedge_posedge(3),
        SetupLow => tsetup_TXCTRL2_TXUSERCLKIN2_negedge_posedge(3),
        HoldLow => thold_TXCTRL2_TXUSERCLKIN2_negedge_posedge(3),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL2_TXUSERCLKIN2_posedge(4),
        TimingData => Tmkr_TXCTRL2_TXUSERCLKIN2_posedge(4),
        TestSignal => TXCTRL2_TXUSERCLKIN2_dly(4),
        TestSignalName => "TXCTRL2(4)",
        TestDelay => tisd_TXCTRL2_TXUSERCLKIN2(4),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXCTRL2_TXUSERCLKIN2_posedge_posedge(4),
        HoldHigh => thold_TXCTRL2_TXUSERCLKIN2_posedge_posedge(4),
        SetupLow => tsetup_TXCTRL2_TXUSERCLKIN2_negedge_posedge(4),
        HoldLow => thold_TXCTRL2_TXUSERCLKIN2_negedge_posedge(4),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL2_TXUSERCLKIN2_posedge(5),
        TimingData => Tmkr_TXCTRL2_TXUSERCLKIN2_posedge(5),
        TestSignal => TXCTRL2_TXUSERCLKIN2_dly(5),
        TestSignalName => "TXCTRL2(5)",
        TestDelay => tisd_TXCTRL2_TXUSERCLKIN2(5),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXCTRL2_TXUSERCLKIN2_posedge_posedge(5),
        HoldHigh => thold_TXCTRL2_TXUSERCLKIN2_posedge_posedge(5),
        SetupLow => tsetup_TXCTRL2_TXUSERCLKIN2_negedge_posedge(5),
        HoldLow => thold_TXCTRL2_TXUSERCLKIN2_negedge_posedge(5),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL2_TXUSERCLKIN2_posedge(6),
        TimingData => Tmkr_TXCTRL2_TXUSERCLKIN2_posedge(6),
        TestSignal => TXCTRL2_TXUSERCLKIN2_dly(6),
        TestSignalName => "TXCTRL2(6)",
        TestDelay => tisd_TXCTRL2_TXUSERCLKIN2(6),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXCTRL2_TXUSERCLKIN2_posedge_posedge(6),
        HoldHigh => thold_TXCTRL2_TXUSERCLKIN2_posedge_posedge(6),
        SetupLow => tsetup_TXCTRL2_TXUSERCLKIN2_negedge_posedge(6),
        HoldLow => thold_TXCTRL2_TXUSERCLKIN2_negedge_posedge(6),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL2_TXUSERCLKIN2_posedge(7),
        TimingData => Tmkr_TXCTRL2_TXUSERCLKIN2_posedge(7),
        TestSignal => TXCTRL2_TXUSERCLKIN2_dly(7),
        TestSignalName => "TXCTRL2(7)",
        TestDelay => tisd_TXCTRL2_TXUSERCLKIN2(7),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXCTRL2_TXUSERCLKIN2_posedge_posedge(7),
        HoldHigh => thold_TXCTRL2_TXUSERCLKIN2_posedge_posedge(7),
        SetupLow => tsetup_TXCTRL2_TXUSERCLKIN2_negedge_posedge(7),
        HoldLow => thold_TXCTRL2_TXUSERCLKIN2_negedge_posedge(7),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL3_TXUSERCLKIN3_posedge(0),
        TimingData => Tmkr_TXCTRL3_TXUSERCLKIN3_posedge(0),
        TestSignal => TXCTRL3_TXUSERCLKIN3_dly(0),
        TestSignalName => "TXCTRL3(0)",
        TestDelay => tisd_TXCTRL3_TXUSERCLKIN3(0),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXCTRL3_TXUSERCLKIN3_posedge_posedge(0),
        HoldHigh => thold_TXCTRL3_TXUSERCLKIN3_posedge_posedge(0),
        SetupLow => tsetup_TXCTRL3_TXUSERCLKIN3_negedge_posedge(0),
        HoldLow => thold_TXCTRL3_TXUSERCLKIN3_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL3_TXUSERCLKIN3_posedge(1),
        TimingData => Tmkr_TXCTRL3_TXUSERCLKIN3_posedge(1),
        TestSignal => TXCTRL3_TXUSERCLKIN3_dly(1),
        TestSignalName => "TXCTRL3(1)",
        TestDelay => tisd_TXCTRL3_TXUSERCLKIN3(1),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXCTRL3_TXUSERCLKIN3_posedge_posedge(1),
        HoldHigh => thold_TXCTRL3_TXUSERCLKIN3_posedge_posedge(1),
        SetupLow => tsetup_TXCTRL3_TXUSERCLKIN3_negedge_posedge(1),
        HoldLow => thold_TXCTRL3_TXUSERCLKIN3_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL3_TXUSERCLKIN3_posedge(2),
        TimingData => Tmkr_TXCTRL3_TXUSERCLKIN3_posedge(2),
        TestSignal => TXCTRL3_TXUSERCLKIN3_dly(2),
        TestSignalName => "TXCTRL3(2)",
        TestDelay => tisd_TXCTRL3_TXUSERCLKIN3(2),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXCTRL3_TXUSERCLKIN3_posedge_posedge(2),
        HoldHigh => thold_TXCTRL3_TXUSERCLKIN3_posedge_posedge(2),
        SetupLow => tsetup_TXCTRL3_TXUSERCLKIN3_negedge_posedge(2),
        HoldLow => thold_TXCTRL3_TXUSERCLKIN3_negedge_posedge(2),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL3_TXUSERCLKIN3_posedge(3),
        TimingData => Tmkr_TXCTRL3_TXUSERCLKIN3_posedge(3),
        TestSignal => TXCTRL3_TXUSERCLKIN3_dly(3),
        TestSignalName => "TXCTRL3(3)",
        TestDelay => tisd_TXCTRL3_TXUSERCLKIN3(3),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXCTRL3_TXUSERCLKIN3_posedge_posedge(3),
        HoldHigh => thold_TXCTRL3_TXUSERCLKIN3_posedge_posedge(3),
        SetupLow => tsetup_TXCTRL3_TXUSERCLKIN3_negedge_posedge(3),
        HoldLow => thold_TXCTRL3_TXUSERCLKIN3_negedge_posedge(3),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL3_TXUSERCLKIN3_posedge(4),
        TimingData => Tmkr_TXCTRL3_TXUSERCLKIN3_posedge(4),
        TestSignal => TXCTRL3_TXUSERCLKIN3_dly(4),
        TestSignalName => "TXCTRL3(4)",
        TestDelay => tisd_TXCTRL3_TXUSERCLKIN3(4),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXCTRL3_TXUSERCLKIN3_posedge_posedge(4),
        HoldHigh => thold_TXCTRL3_TXUSERCLKIN3_posedge_posedge(4),
        SetupLow => tsetup_TXCTRL3_TXUSERCLKIN3_negedge_posedge(4),
        HoldLow => thold_TXCTRL3_TXUSERCLKIN3_negedge_posedge(4),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL3_TXUSERCLKIN3_posedge(5),
        TimingData => Tmkr_TXCTRL3_TXUSERCLKIN3_posedge(5),
        TestSignal => TXCTRL3_TXUSERCLKIN3_dly(5),
        TestSignalName => "TXCTRL3(5)",
        TestDelay => tisd_TXCTRL3_TXUSERCLKIN3(5),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXCTRL3_TXUSERCLKIN3_posedge_posedge(5),
        HoldHigh => thold_TXCTRL3_TXUSERCLKIN3_posedge_posedge(5),
        SetupLow => tsetup_TXCTRL3_TXUSERCLKIN3_negedge_posedge(5),
        HoldLow => thold_TXCTRL3_TXUSERCLKIN3_negedge_posedge(5),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL3_TXUSERCLKIN3_posedge(6),
        TimingData => Tmkr_TXCTRL3_TXUSERCLKIN3_posedge(6),
        TestSignal => TXCTRL3_TXUSERCLKIN3_dly(6),
        TestSignalName => "TXCTRL3(6)",
        TestDelay => tisd_TXCTRL3_TXUSERCLKIN3(6),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXCTRL3_TXUSERCLKIN3_posedge_posedge(6),
        HoldHigh => thold_TXCTRL3_TXUSERCLKIN3_posedge_posedge(6),
        SetupLow => tsetup_TXCTRL3_TXUSERCLKIN3_negedge_posedge(6),
        HoldLow => thold_TXCTRL3_TXUSERCLKIN3_negedge_posedge(6),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXCTRL3_TXUSERCLKIN3_posedge(7),
        TimingData => Tmkr_TXCTRL3_TXUSERCLKIN3_posedge(7),
        TestSignal => TXCTRL3_TXUSERCLKIN3_dly(7),
        TestSignalName => "TXCTRL3(7)",
        TestDelay => tisd_TXCTRL3_TXUSERCLKIN3(7),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXCTRL3_TXUSERCLKIN3_posedge_posedge(7),
        HoldHigh => thold_TXCTRL3_TXUSERCLKIN3_posedge_posedge(7),
        SetupLow => tsetup_TXCTRL3_TXUSERCLKIN3_negedge_posedge(7),
        HoldLow => thold_TXCTRL3_TXUSERCLKIN3_negedge_posedge(7),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(0),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(0),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(0),
        TestSignalName => "TXDATA0(0)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(0),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(0),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(0),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(0),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(1),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(1),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(1),
        TestSignalName => "TXDATA0(1)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(1),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(1),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(1),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(1),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(10),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(10),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(10),
        TestSignalName => "TXDATA0(10)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(10),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(10),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(10),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(10),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(10),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(11),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(11),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(11),
        TestSignalName => "TXDATA0(11)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(11),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(11),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(11),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(11),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(11),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(12),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(12),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(12),
        TestSignalName => "TXDATA0(12)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(12),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(12),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(12),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(12),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(12),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(13),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(13),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(13),
        TestSignalName => "TXDATA0(13)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(13),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(13),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(13),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(13),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(13),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(14),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(14),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(14),
        TestSignalName => "TXDATA0(14)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(14),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(14),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(14),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(14),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(14),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(15),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(15),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(15),
        TestSignalName => "TXDATA0(15)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(15),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(15),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(15),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(15),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(15),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(16),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(16),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(16),
        TestSignalName => "TXDATA0(16)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(16),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(16),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(16),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(16),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(16),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(17),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(17),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(17),
        TestSignalName => "TXDATA0(17)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(17),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(17),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(17),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(17),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(17),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(18),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(18),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(18),
        TestSignalName => "TXDATA0(18)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(18),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(18),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(18),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(18),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(18),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(19),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(19),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(19),
        TestSignalName => "TXDATA0(19)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(19),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(19),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(19),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(19),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(19),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(2),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(2),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(2),
        TestSignalName => "TXDATA0(2)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(2),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(2),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(2),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(2),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(2),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(20),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(20),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(20),
        TestSignalName => "TXDATA0(20)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(20),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(20),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(20),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(20),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(20),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(21),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(21),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(21),
        TestSignalName => "TXDATA0(21)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(21),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(21),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(21),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(21),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(21),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(22),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(22),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(22),
        TestSignalName => "TXDATA0(22)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(22),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(22),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(22),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(22),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(22),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(23),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(23),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(23),
        TestSignalName => "TXDATA0(23)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(23),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(23),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(23),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(23),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(23),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(24),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(24),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(24),
        TestSignalName => "TXDATA0(24)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(24),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(24),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(24),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(24),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(24),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(25),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(25),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(25),
        TestSignalName => "TXDATA0(25)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(25),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(25),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(25),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(25),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(25),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(26),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(26),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(26),
        TestSignalName => "TXDATA0(26)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(26),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(26),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(26),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(26),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(26),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(27),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(27),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(27),
        TestSignalName => "TXDATA0(27)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(27),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(27),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(27),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(27),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(27),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(28),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(28),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(28),
        TestSignalName => "TXDATA0(28)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(28),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(28),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(28),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(28),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(28),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(29),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(29),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(29),
        TestSignalName => "TXDATA0(29)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(29),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(29),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(29),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(29),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(29),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(3),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(3),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(3),
        TestSignalName => "TXDATA0(3)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(3),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(3),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(3),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(3),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(3),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(30),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(30),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(30),
        TestSignalName => "TXDATA0(30)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(30),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(30),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(30),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(30),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(30),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(31),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(31),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(31),
        TestSignalName => "TXDATA0(31)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(31),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(31),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(31),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(31),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(31),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(32),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(32),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(32),
        TestSignalName => "TXDATA0(32)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(32),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(32),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(32),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(32),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(32),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(33),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(33),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(33),
        TestSignalName => "TXDATA0(33)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(33),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(33),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(33),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(33),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(33),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(34),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(34),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(34),
        TestSignalName => "TXDATA0(34)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(34),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(34),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(34),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(34),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(34),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(35),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(35),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(35),
        TestSignalName => "TXDATA0(35)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(35),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(35),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(35),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(35),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(35),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(36),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(36),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(36),
        TestSignalName => "TXDATA0(36)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(36),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(36),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(36),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(36),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(36),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(37),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(37),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(37),
        TestSignalName => "TXDATA0(37)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(37),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(37),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(37),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(37),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(37),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(38),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(38),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(38),
        TestSignalName => "TXDATA0(38)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(38),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(38),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(38),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(38),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(38),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(39),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(39),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(39),
        TestSignalName => "TXDATA0(39)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(39),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(39),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(39),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(39),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(39),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(4),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(4),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(4),
        TestSignalName => "TXDATA0(4)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(4),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(4),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(4),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(4),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(4),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(40),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(40),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(40),
        TestSignalName => "TXDATA0(40)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(40),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(40),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(40),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(40),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(40),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(41),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(41),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(41),
        TestSignalName => "TXDATA0(41)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(41),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(41),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(41),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(41),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(41),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(42),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(42),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(42),
        TestSignalName => "TXDATA0(42)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(42),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(42),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(42),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(42),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(42),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(43),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(43),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(43),
        TestSignalName => "TXDATA0(43)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(43),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(43),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(43),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(43),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(43),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(44),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(44),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(44),
        TestSignalName => "TXDATA0(44)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(44),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(44),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(44),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(44),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(44),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(45),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(45),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(45),
        TestSignalName => "TXDATA0(45)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(45),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(45),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(45),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(45),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(45),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(46),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(46),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(46),
        TestSignalName => "TXDATA0(46)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(46),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(46),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(46),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(46),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(46),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(47),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(47),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(47),
        TestSignalName => "TXDATA0(47)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(47),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(47),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(47),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(47),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(47),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(48),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(48),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(48),
        TestSignalName => "TXDATA0(48)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(48),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(48),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(48),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(48),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(48),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(49),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(49),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(49),
        TestSignalName => "TXDATA0(49)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(49),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(49),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(49),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(49),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(49),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(5),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(5),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(5),
        TestSignalName => "TXDATA0(5)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(5),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(5),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(5),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(5),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(5),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(50),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(50),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(50),
        TestSignalName => "TXDATA0(50)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(50),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(50),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(50),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(50),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(50),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(51),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(51),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(51),
        TestSignalName => "TXDATA0(51)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(51),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(51),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(51),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(51),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(51),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(52),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(52),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(52),
        TestSignalName => "TXDATA0(52)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(52),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(52),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(52),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(52),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(52),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(53),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(53),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(53),
        TestSignalName => "TXDATA0(53)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(53),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(53),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(53),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(53),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(53),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(54),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(54),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(54),
        TestSignalName => "TXDATA0(54)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(54),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(54),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(54),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(54),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(54),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(55),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(55),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(55),
        TestSignalName => "TXDATA0(55)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(55),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(55),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(55),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(55),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(55),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(56),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(56),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(56),
        TestSignalName => "TXDATA0(56)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(56),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(56),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(56),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(56),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(56),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(57),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(57),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(57),
        TestSignalName => "TXDATA0(57)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(57),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(57),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(57),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(57),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(57),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(58),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(58),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(58),
        TestSignalName => "TXDATA0(58)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(58),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(58),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(58),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(58),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(58),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(59),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(59),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(59),
        TestSignalName => "TXDATA0(59)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(59),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(59),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(59),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(59),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(59),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(6),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(6),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(6),
        TestSignalName => "TXDATA0(6)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(6),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(6),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(6),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(6),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(6),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(60),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(60),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(60),
        TestSignalName => "TXDATA0(60)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(60),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(60),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(60),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(60),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(60),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(61),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(61),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(61),
        TestSignalName => "TXDATA0(61)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(61),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(61),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(61),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(61),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(61),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(62),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(62),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(62),
        TestSignalName => "TXDATA0(62)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(62),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(62),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(62),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(62),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(62),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(63),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(63),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(63),
        TestSignalName => "TXDATA0(63)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(63),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(63),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(63),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(63),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(63),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(7),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(7),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(7),
        TestSignalName => "TXDATA0(7)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(7),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(7),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(7),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(7),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(7),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(8),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(8),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(8),
        TestSignalName => "TXDATA0(8)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(8),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(8),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(8),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(8),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(8),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA0_TXUSERCLKIN0_posedge(9),
        TimingData => Tmkr_TXDATA0_TXUSERCLKIN0_posedge(9),
        TestSignal => TXDATA0_TXUSERCLKIN0_dly(9),
        TestSignalName => "TXDATA0(9)",
        TestDelay => tisd_TXDATA0_TXUSERCLKIN0(9),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATA0_TXUSERCLKIN0_posedge_posedge(9),
        HoldHigh => thold_TXDATA0_TXUSERCLKIN0_posedge_posedge(9),
        SetupLow => tsetup_TXDATA0_TXUSERCLKIN0_negedge_posedge(9),
        HoldLow => thold_TXDATA0_TXUSERCLKIN0_negedge_posedge(9),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(0),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(0),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(0),
        TestSignalName => "TXDATA1(0)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(0),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(0),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(0),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(0),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(1),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(1),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(1),
        TestSignalName => "TXDATA1(1)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(1),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(1),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(1),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(1),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(10),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(10),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(10),
        TestSignalName => "TXDATA1(10)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(10),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(10),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(10),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(10),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(10),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(11),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(11),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(11),
        TestSignalName => "TXDATA1(11)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(11),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(11),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(11),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(11),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(11),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(12),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(12),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(12),
        TestSignalName => "TXDATA1(12)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(12),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(12),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(12),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(12),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(12),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(13),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(13),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(13),
        TestSignalName => "TXDATA1(13)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(13),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(13),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(13),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(13),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(13),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(14),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(14),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(14),
        TestSignalName => "TXDATA1(14)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(14),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(14),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(14),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(14),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(14),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(15),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(15),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(15),
        TestSignalName => "TXDATA1(15)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(15),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(15),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(15),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(15),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(15),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(16),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(16),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(16),
        TestSignalName => "TXDATA1(16)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(16),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(16),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(16),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(16),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(16),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(17),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(17),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(17),
        TestSignalName => "TXDATA1(17)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(17),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(17),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(17),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(17),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(17),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(18),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(18),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(18),
        TestSignalName => "TXDATA1(18)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(18),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(18),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(18),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(18),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(18),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(19),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(19),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(19),
        TestSignalName => "TXDATA1(19)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(19),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(19),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(19),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(19),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(19),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(2),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(2),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(2),
        TestSignalName => "TXDATA1(2)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(2),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(2),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(2),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(2),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(2),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(20),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(20),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(20),
        TestSignalName => "TXDATA1(20)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(20),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(20),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(20),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(20),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(20),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(21),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(21),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(21),
        TestSignalName => "TXDATA1(21)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(21),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(21),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(21),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(21),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(21),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(22),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(22),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(22),
        TestSignalName => "TXDATA1(22)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(22),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(22),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(22),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(22),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(22),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(23),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(23),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(23),
        TestSignalName => "TXDATA1(23)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(23),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(23),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(23),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(23),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(23),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(24),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(24),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(24),
        TestSignalName => "TXDATA1(24)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(24),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(24),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(24),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(24),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(24),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(25),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(25),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(25),
        TestSignalName => "TXDATA1(25)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(25),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(25),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(25),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(25),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(25),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(26),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(26),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(26),
        TestSignalName => "TXDATA1(26)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(26),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(26),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(26),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(26),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(26),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(27),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(27),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(27),
        TestSignalName => "TXDATA1(27)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(27),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(27),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(27),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(27),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(27),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(28),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(28),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(28),
        TestSignalName => "TXDATA1(28)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(28),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(28),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(28),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(28),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(28),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(29),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(29),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(29),
        TestSignalName => "TXDATA1(29)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(29),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(29),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(29),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(29),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(29),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(3),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(3),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(3),
        TestSignalName => "TXDATA1(3)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(3),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(3),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(3),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(3),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(3),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(30),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(30),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(30),
        TestSignalName => "TXDATA1(30)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(30),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(30),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(30),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(30),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(30),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(31),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(31),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(31),
        TestSignalName => "TXDATA1(31)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(31),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(31),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(31),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(31),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(31),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(32),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(32),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(32),
        TestSignalName => "TXDATA1(32)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(32),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(32),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(32),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(32),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(32),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(33),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(33),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(33),
        TestSignalName => "TXDATA1(33)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(33),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(33),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(33),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(33),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(33),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(34),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(34),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(34),
        TestSignalName => "TXDATA1(34)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(34),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(34),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(34),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(34),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(34),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(35),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(35),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(35),
        TestSignalName => "TXDATA1(35)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(35),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(35),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(35),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(35),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(35),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(36),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(36),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(36),
        TestSignalName => "TXDATA1(36)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(36),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(36),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(36),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(36),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(36),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(37),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(37),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(37),
        TestSignalName => "TXDATA1(37)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(37),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(37),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(37),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(37),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(37),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(38),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(38),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(38),
        TestSignalName => "TXDATA1(38)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(38),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(38),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(38),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(38),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(38),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(39),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(39),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(39),
        TestSignalName => "TXDATA1(39)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(39),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(39),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(39),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(39),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(39),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(4),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(4),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(4),
        TestSignalName => "TXDATA1(4)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(4),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(4),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(4),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(4),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(4),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(40),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(40),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(40),
        TestSignalName => "TXDATA1(40)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(40),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(40),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(40),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(40),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(40),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(41),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(41),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(41),
        TestSignalName => "TXDATA1(41)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(41),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(41),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(41),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(41),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(41),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(42),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(42),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(42),
        TestSignalName => "TXDATA1(42)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(42),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(42),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(42),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(42),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(42),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(43),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(43),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(43),
        TestSignalName => "TXDATA1(43)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(43),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(43),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(43),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(43),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(43),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(44),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(44),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(44),
        TestSignalName => "TXDATA1(44)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(44),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(44),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(44),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(44),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(44),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(45),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(45),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(45),
        TestSignalName => "TXDATA1(45)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(45),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(45),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(45),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(45),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(45),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(46),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(46),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(46),
        TestSignalName => "TXDATA1(46)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(46),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(46),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(46),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(46),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(46),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(47),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(47),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(47),
        TestSignalName => "TXDATA1(47)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(47),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(47),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(47),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(47),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(47),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(48),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(48),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(48),
        TestSignalName => "TXDATA1(48)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(48),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(48),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(48),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(48),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(48),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(49),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(49),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(49),
        TestSignalName => "TXDATA1(49)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(49),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(49),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(49),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(49),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(49),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(5),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(5),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(5),
        TestSignalName => "TXDATA1(5)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(5),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(5),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(5),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(5),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(5),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(50),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(50),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(50),
        TestSignalName => "TXDATA1(50)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(50),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(50),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(50),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(50),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(50),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(51),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(51),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(51),
        TestSignalName => "TXDATA1(51)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(51),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(51),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(51),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(51),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(51),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(52),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(52),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(52),
        TestSignalName => "TXDATA1(52)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(52),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(52),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(52),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(52),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(52),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(53),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(53),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(53),
        TestSignalName => "TXDATA1(53)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(53),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(53),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(53),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(53),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(53),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(54),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(54),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(54),
        TestSignalName => "TXDATA1(54)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(54),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(54),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(54),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(54),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(54),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(55),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(55),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(55),
        TestSignalName => "TXDATA1(55)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(55),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(55),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(55),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(55),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(55),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(56),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(56),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(56),
        TestSignalName => "TXDATA1(56)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(56),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(56),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(56),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(56),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(56),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(57),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(57),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(57),
        TestSignalName => "TXDATA1(57)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(57),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(57),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(57),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(57),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(57),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(58),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(58),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(58),
        TestSignalName => "TXDATA1(58)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(58),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(58),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(58),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(58),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(58),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(59),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(59),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(59),
        TestSignalName => "TXDATA1(59)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(59),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(59),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(59),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(59),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(59),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(6),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(6),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(6),
        TestSignalName => "TXDATA1(6)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(6),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(6),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(6),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(6),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(6),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(60),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(60),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(60),
        TestSignalName => "TXDATA1(60)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(60),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(60),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(60),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(60),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(60),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(61),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(61),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(61),
        TestSignalName => "TXDATA1(61)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(61),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(61),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(61),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(61),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(61),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(62),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(62),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(62),
        TestSignalName => "TXDATA1(62)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(62),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(62),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(62),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(62),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(62),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(63),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(63),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(63),
        TestSignalName => "TXDATA1(63)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(63),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(63),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(63),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(63),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(63),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(7),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(7),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(7),
        TestSignalName => "TXDATA1(7)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(7),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(7),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(7),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(7),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(7),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(8),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(8),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(8),
        TestSignalName => "TXDATA1(8)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(8),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(8),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(8),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(8),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(8),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA1_TXUSERCLKIN1_posedge(9),
        TimingData => Tmkr_TXDATA1_TXUSERCLKIN1_posedge(9),
        TestSignal => TXDATA1_TXUSERCLKIN1_dly(9),
        TestSignalName => "TXDATA1(9)",
        TestDelay => tisd_TXDATA1_TXUSERCLKIN1(9),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATA1_TXUSERCLKIN1_posedge_posedge(9),
        HoldHigh => thold_TXDATA1_TXUSERCLKIN1_posedge_posedge(9),
        SetupLow => tsetup_TXDATA1_TXUSERCLKIN1_negedge_posedge(9),
        HoldLow => thold_TXDATA1_TXUSERCLKIN1_negedge_posedge(9),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(0),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(0),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(0),
        TestSignalName => "TXDATA2(0)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(0),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(0),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(0),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(0),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(1),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(1),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(1),
        TestSignalName => "TXDATA2(1)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(1),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(1),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(1),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(1),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(10),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(10),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(10),
        TestSignalName => "TXDATA2(10)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(10),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(10),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(10),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(10),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(10),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(11),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(11),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(11),
        TestSignalName => "TXDATA2(11)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(11),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(11),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(11),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(11),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(11),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(12),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(12),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(12),
        TestSignalName => "TXDATA2(12)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(12),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(12),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(12),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(12),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(12),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(13),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(13),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(13),
        TestSignalName => "TXDATA2(13)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(13),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(13),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(13),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(13),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(13),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(14),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(14),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(14),
        TestSignalName => "TXDATA2(14)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(14),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(14),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(14),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(14),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(14),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(15),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(15),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(15),
        TestSignalName => "TXDATA2(15)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(15),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(15),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(15),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(15),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(15),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(16),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(16),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(16),
        TestSignalName => "TXDATA2(16)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(16),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(16),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(16),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(16),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(16),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(17),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(17),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(17),
        TestSignalName => "TXDATA2(17)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(17),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(17),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(17),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(17),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(17),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(18),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(18),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(18),
        TestSignalName => "TXDATA2(18)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(18),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(18),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(18),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(18),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(18),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(19),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(19),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(19),
        TestSignalName => "TXDATA2(19)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(19),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(19),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(19),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(19),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(19),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(2),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(2),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(2),
        TestSignalName => "TXDATA2(2)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(2),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(2),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(2),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(2),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(2),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(20),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(20),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(20),
        TestSignalName => "TXDATA2(20)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(20),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(20),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(20),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(20),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(20),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(21),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(21),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(21),
        TestSignalName => "TXDATA2(21)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(21),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(21),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(21),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(21),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(21),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(22),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(22),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(22),
        TestSignalName => "TXDATA2(22)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(22),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(22),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(22),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(22),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(22),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(23),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(23),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(23),
        TestSignalName => "TXDATA2(23)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(23),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(23),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(23),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(23),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(23),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(24),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(24),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(24),
        TestSignalName => "TXDATA2(24)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(24),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(24),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(24),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(24),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(24),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(25),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(25),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(25),
        TestSignalName => "TXDATA2(25)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(25),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(25),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(25),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(25),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(25),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(26),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(26),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(26),
        TestSignalName => "TXDATA2(26)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(26),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(26),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(26),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(26),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(26),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(27),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(27),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(27),
        TestSignalName => "TXDATA2(27)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(27),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(27),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(27),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(27),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(27),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(28),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(28),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(28),
        TestSignalName => "TXDATA2(28)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(28),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(28),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(28),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(28),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(28),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(29),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(29),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(29),
        TestSignalName => "TXDATA2(29)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(29),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(29),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(29),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(29),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(29),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(3),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(3),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(3),
        TestSignalName => "TXDATA2(3)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(3),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(3),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(3),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(3),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(3),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(30),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(30),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(30),
        TestSignalName => "TXDATA2(30)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(30),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(30),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(30),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(30),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(30),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(31),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(31),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(31),
        TestSignalName => "TXDATA2(31)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(31),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(31),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(31),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(31),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(31),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(32),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(32),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(32),
        TestSignalName => "TXDATA2(32)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(32),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(32),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(32),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(32),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(32),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(33),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(33),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(33),
        TestSignalName => "TXDATA2(33)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(33),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(33),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(33),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(33),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(33),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(34),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(34),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(34),
        TestSignalName => "TXDATA2(34)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(34),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(34),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(34),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(34),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(34),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(35),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(35),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(35),
        TestSignalName => "TXDATA2(35)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(35),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(35),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(35),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(35),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(35),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(36),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(36),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(36),
        TestSignalName => "TXDATA2(36)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(36),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(36),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(36),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(36),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(36),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(37),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(37),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(37),
        TestSignalName => "TXDATA2(37)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(37),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(37),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(37),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(37),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(37),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(38),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(38),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(38),
        TestSignalName => "TXDATA2(38)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(38),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(38),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(38),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(38),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(38),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(39),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(39),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(39),
        TestSignalName => "TXDATA2(39)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(39),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(39),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(39),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(39),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(39),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(4),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(4),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(4),
        TestSignalName => "TXDATA2(4)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(4),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(4),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(4),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(4),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(4),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(40),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(40),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(40),
        TestSignalName => "TXDATA2(40)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(40),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(40),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(40),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(40),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(40),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(41),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(41),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(41),
        TestSignalName => "TXDATA2(41)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(41),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(41),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(41),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(41),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(41),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(42),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(42),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(42),
        TestSignalName => "TXDATA2(42)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(42),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(42),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(42),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(42),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(42),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(43),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(43),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(43),
        TestSignalName => "TXDATA2(43)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(43),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(43),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(43),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(43),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(43),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(44),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(44),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(44),
        TestSignalName => "TXDATA2(44)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(44),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(44),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(44),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(44),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(44),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(45),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(45),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(45),
        TestSignalName => "TXDATA2(45)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(45),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(45),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(45),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(45),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(45),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(46),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(46),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(46),
        TestSignalName => "TXDATA2(46)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(46),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(46),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(46),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(46),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(46),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(47),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(47),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(47),
        TestSignalName => "TXDATA2(47)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(47),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(47),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(47),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(47),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(47),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(48),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(48),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(48),
        TestSignalName => "TXDATA2(48)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(48),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(48),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(48),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(48),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(48),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(49),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(49),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(49),
        TestSignalName => "TXDATA2(49)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(49),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(49),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(49),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(49),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(49),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(5),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(5),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(5),
        TestSignalName => "TXDATA2(5)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(5),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(5),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(5),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(5),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(5),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(50),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(50),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(50),
        TestSignalName => "TXDATA2(50)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(50),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(50),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(50),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(50),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(50),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(51),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(51),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(51),
        TestSignalName => "TXDATA2(51)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(51),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(51),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(51),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(51),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(51),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(52),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(52),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(52),
        TestSignalName => "TXDATA2(52)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(52),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(52),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(52),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(52),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(52),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(53),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(53),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(53),
        TestSignalName => "TXDATA2(53)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(53),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(53),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(53),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(53),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(53),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(54),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(54),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(54),
        TestSignalName => "TXDATA2(54)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(54),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(54),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(54),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(54),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(54),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(55),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(55),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(55),
        TestSignalName => "TXDATA2(55)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(55),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(55),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(55),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(55),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(55),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(56),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(56),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(56),
        TestSignalName => "TXDATA2(56)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(56),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(56),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(56),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(56),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(56),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(57),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(57),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(57),
        TestSignalName => "TXDATA2(57)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(57),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(57),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(57),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(57),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(57),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(58),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(58),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(58),
        TestSignalName => "TXDATA2(58)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(58),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(58),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(58),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(58),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(58),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(59),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(59),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(59),
        TestSignalName => "TXDATA2(59)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(59),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(59),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(59),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(59),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(59),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(6),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(6),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(6),
        TestSignalName => "TXDATA2(6)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(6),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(6),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(6),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(6),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(6),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(60),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(60),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(60),
        TestSignalName => "TXDATA2(60)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(60),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(60),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(60),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(60),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(60),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(61),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(61),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(61),
        TestSignalName => "TXDATA2(61)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(61),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(61),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(61),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(61),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(61),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(62),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(62),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(62),
        TestSignalName => "TXDATA2(62)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(62),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(62),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(62),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(62),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(62),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(63),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(63),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(63),
        TestSignalName => "TXDATA2(63)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(63),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(63),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(63),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(63),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(63),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(7),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(7),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(7),
        TestSignalName => "TXDATA2(7)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(7),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(7),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(7),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(7),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(7),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(8),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(8),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(8),
        TestSignalName => "TXDATA2(8)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(8),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(8),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(8),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(8),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(8),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA2_TXUSERCLKIN2_posedge(9),
        TimingData => Tmkr_TXDATA2_TXUSERCLKIN2_posedge(9),
        TestSignal => TXDATA2_TXUSERCLKIN2_dly(9),
        TestSignalName => "TXDATA2(9)",
        TestDelay => tisd_TXDATA2_TXUSERCLKIN2(9),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATA2_TXUSERCLKIN2_posedge_posedge(9),
        HoldHigh => thold_TXDATA2_TXUSERCLKIN2_posedge_posedge(9),
        SetupLow => tsetup_TXDATA2_TXUSERCLKIN2_negedge_posedge(9),
        HoldLow => thold_TXDATA2_TXUSERCLKIN2_negedge_posedge(9),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(0),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(0),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(0),
        TestSignalName => "TXDATA3(0)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(0),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(0),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(0),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(0),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(1),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(1),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(1),
        TestSignalName => "TXDATA3(1)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(1),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(1),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(1),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(1),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(10),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(10),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(10),
        TestSignalName => "TXDATA3(10)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(10),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(10),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(10),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(10),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(10),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(11),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(11),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(11),
        TestSignalName => "TXDATA3(11)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(11),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(11),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(11),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(11),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(11),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(12),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(12),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(12),
        TestSignalName => "TXDATA3(12)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(12),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(12),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(12),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(12),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(12),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(13),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(13),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(13),
        TestSignalName => "TXDATA3(13)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(13),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(13),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(13),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(13),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(13),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(14),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(14),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(14),
        TestSignalName => "TXDATA3(14)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(14),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(14),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(14),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(14),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(14),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(15),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(15),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(15),
        TestSignalName => "TXDATA3(15)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(15),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(15),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(15),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(15),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(15),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(16),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(16),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(16),
        TestSignalName => "TXDATA3(16)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(16),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(16),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(16),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(16),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(16),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(17),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(17),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(17),
        TestSignalName => "TXDATA3(17)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(17),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(17),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(17),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(17),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(17),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(18),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(18),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(18),
        TestSignalName => "TXDATA3(18)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(18),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(18),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(18),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(18),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(18),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(19),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(19),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(19),
        TestSignalName => "TXDATA3(19)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(19),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(19),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(19),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(19),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(19),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(2),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(2),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(2),
        TestSignalName => "TXDATA3(2)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(2),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(2),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(2),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(2),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(2),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(20),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(20),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(20),
        TestSignalName => "TXDATA3(20)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(20),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(20),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(20),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(20),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(20),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(21),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(21),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(21),
        TestSignalName => "TXDATA3(21)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(21),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(21),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(21),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(21),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(21),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(22),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(22),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(22),
        TestSignalName => "TXDATA3(22)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(22),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(22),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(22),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(22),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(22),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(23),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(23),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(23),
        TestSignalName => "TXDATA3(23)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(23),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(23),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(23),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(23),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(23),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(24),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(24),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(24),
        TestSignalName => "TXDATA3(24)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(24),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(24),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(24),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(24),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(24),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(25),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(25),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(25),
        TestSignalName => "TXDATA3(25)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(25),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(25),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(25),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(25),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(25),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(26),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(26),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(26),
        TestSignalName => "TXDATA3(26)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(26),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(26),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(26),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(26),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(26),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(27),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(27),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(27),
        TestSignalName => "TXDATA3(27)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(27),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(27),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(27),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(27),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(27),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(28),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(28),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(28),
        TestSignalName => "TXDATA3(28)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(28),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(28),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(28),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(28),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(28),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(29),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(29),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(29),
        TestSignalName => "TXDATA3(29)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(29),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(29),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(29),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(29),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(29),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(3),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(3),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(3),
        TestSignalName => "TXDATA3(3)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(3),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(3),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(3),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(3),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(3),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(30),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(30),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(30),
        TestSignalName => "TXDATA3(30)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(30),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(30),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(30),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(30),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(30),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(31),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(31),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(31),
        TestSignalName => "TXDATA3(31)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(31),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(31),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(31),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(31),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(31),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(32),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(32),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(32),
        TestSignalName => "TXDATA3(32)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(32),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(32),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(32),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(32),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(32),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(33),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(33),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(33),
        TestSignalName => "TXDATA3(33)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(33),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(33),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(33),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(33),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(33),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(34),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(34),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(34),
        TestSignalName => "TXDATA3(34)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(34),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(34),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(34),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(34),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(34),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(35),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(35),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(35),
        TestSignalName => "TXDATA3(35)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(35),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(35),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(35),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(35),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(35),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(36),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(36),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(36),
        TestSignalName => "TXDATA3(36)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(36),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(36),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(36),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(36),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(36),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(37),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(37),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(37),
        TestSignalName => "TXDATA3(37)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(37),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(37),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(37),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(37),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(37),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(38),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(38),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(38),
        TestSignalName => "TXDATA3(38)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(38),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(38),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(38),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(38),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(38),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(39),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(39),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(39),
        TestSignalName => "TXDATA3(39)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(39),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(39),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(39),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(39),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(39),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(4),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(4),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(4),
        TestSignalName => "TXDATA3(4)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(4),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(4),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(4),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(4),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(4),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(40),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(40),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(40),
        TestSignalName => "TXDATA3(40)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(40),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(40),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(40),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(40),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(40),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(41),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(41),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(41),
        TestSignalName => "TXDATA3(41)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(41),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(41),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(41),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(41),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(41),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(42),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(42),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(42),
        TestSignalName => "TXDATA3(42)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(42),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(42),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(42),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(42),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(42),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(43),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(43),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(43),
        TestSignalName => "TXDATA3(43)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(43),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(43),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(43),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(43),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(43),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(44),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(44),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(44),
        TestSignalName => "TXDATA3(44)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(44),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(44),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(44),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(44),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(44),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(45),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(45),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(45),
        TestSignalName => "TXDATA3(45)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(45),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(45),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(45),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(45),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(45),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(46),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(46),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(46),
        TestSignalName => "TXDATA3(46)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(46),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(46),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(46),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(46),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(46),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(47),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(47),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(47),
        TestSignalName => "TXDATA3(47)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(47),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(47),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(47),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(47),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(47),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(48),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(48),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(48),
        TestSignalName => "TXDATA3(48)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(48),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(48),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(48),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(48),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(48),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(49),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(49),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(49),
        TestSignalName => "TXDATA3(49)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(49),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(49),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(49),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(49),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(49),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(5),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(5),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(5),
        TestSignalName => "TXDATA3(5)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(5),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(5),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(5),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(5),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(5),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(50),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(50),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(50),
        TestSignalName => "TXDATA3(50)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(50),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(50),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(50),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(50),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(50),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(51),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(51),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(51),
        TestSignalName => "TXDATA3(51)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(51),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(51),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(51),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(51),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(51),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(52),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(52),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(52),
        TestSignalName => "TXDATA3(52)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(52),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(52),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(52),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(52),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(52),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(53),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(53),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(53),
        TestSignalName => "TXDATA3(53)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(53),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(53),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(53),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(53),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(53),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(54),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(54),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(54),
        TestSignalName => "TXDATA3(54)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(54),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(54),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(54),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(54),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(54),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(55),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(55),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(55),
        TestSignalName => "TXDATA3(55)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(55),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(55),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(55),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(55),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(55),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(56),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(56),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(56),
        TestSignalName => "TXDATA3(56)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(56),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(56),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(56),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(56),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(56),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(57),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(57),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(57),
        TestSignalName => "TXDATA3(57)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(57),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(57),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(57),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(57),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(57),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(58),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(58),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(58),
        TestSignalName => "TXDATA3(58)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(58),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(58),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(58),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(58),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(58),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(59),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(59),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(59),
        TestSignalName => "TXDATA3(59)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(59),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(59),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(59),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(59),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(59),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(6),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(6),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(6),
        TestSignalName => "TXDATA3(6)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(6),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(6),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(6),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(6),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(6),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(60),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(60),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(60),
        TestSignalName => "TXDATA3(60)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(60),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(60),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(60),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(60),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(60),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(61),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(61),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(61),
        TestSignalName => "TXDATA3(61)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(61),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(61),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(61),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(61),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(61),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(62),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(62),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(62),
        TestSignalName => "TXDATA3(62)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(62),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(62),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(62),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(62),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(62),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(63),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(63),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(63),
        TestSignalName => "TXDATA3(63)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(63),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(63),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(63),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(63),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(63),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(7),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(7),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(7),
        TestSignalName => "TXDATA3(7)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(7),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(7),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(7),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(7),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(7),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(8),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(8),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(8),
        TestSignalName => "TXDATA3(8)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(8),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(8),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(8),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(8),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(8),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATA3_TXUSERCLKIN3_posedge(9),
        TimingData => Tmkr_TXDATA3_TXUSERCLKIN3_posedge(9),
        TestSignal => TXDATA3_TXUSERCLKIN3_dly(9),
        TestSignalName => "TXDATA3(9)",
        TestDelay => tisd_TXDATA3_TXUSERCLKIN3(9),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATA3_TXUSERCLKIN3_posedge_posedge(9),
        HoldHigh => thold_TXDATA3_TXUSERCLKIN3_posedge_posedge(9),
        SetupLow => tsetup_TXDATA3_TXUSERCLKIN3_negedge_posedge(9),
        HoldLow => thold_TXDATA3_TXUSERCLKIN3_negedge_posedge(9),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB0_TXUSERCLKIN0_posedge(0),
        TimingData => Tmkr_TXDATAMSB0_TXUSERCLKIN0_posedge(0),
        TestSignal => TXDATAMSB0_TXUSERCLKIN0_dly(0),
        TestSignalName => "TXDATAMSB0(0)",
        TestDelay => tisd_TXDATAMSB0_TXUSERCLKIN0(0),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATAMSB0_TXUSERCLKIN0_posedge_posedge(0),
        HoldHigh => thold_TXDATAMSB0_TXUSERCLKIN0_posedge_posedge(0),
        SetupLow => tsetup_TXDATAMSB0_TXUSERCLKIN0_negedge_posedge(0),
        HoldLow => thold_TXDATAMSB0_TXUSERCLKIN0_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB0_TXUSERCLKIN0_posedge(1),
        TimingData => Tmkr_TXDATAMSB0_TXUSERCLKIN0_posedge(1),
        TestSignal => TXDATAMSB0_TXUSERCLKIN0_dly(1),
        TestSignalName => "TXDATAMSB0(1)",
        TestDelay => tisd_TXDATAMSB0_TXUSERCLKIN0(1),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATAMSB0_TXUSERCLKIN0_posedge_posedge(1),
        HoldHigh => thold_TXDATAMSB0_TXUSERCLKIN0_posedge_posedge(1),
        SetupLow => tsetup_TXDATAMSB0_TXUSERCLKIN0_negedge_posedge(1),
        HoldLow => thold_TXDATAMSB0_TXUSERCLKIN0_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB0_TXUSERCLKIN0_posedge(2),
        TimingData => Tmkr_TXDATAMSB0_TXUSERCLKIN0_posedge(2),
        TestSignal => TXDATAMSB0_TXUSERCLKIN0_dly(2),
        TestSignalName => "TXDATAMSB0(2)",
        TestDelay => tisd_TXDATAMSB0_TXUSERCLKIN0(2),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATAMSB0_TXUSERCLKIN0_posedge_posedge(2),
        HoldHigh => thold_TXDATAMSB0_TXUSERCLKIN0_posedge_posedge(2),
        SetupLow => tsetup_TXDATAMSB0_TXUSERCLKIN0_negedge_posedge(2),
        HoldLow => thold_TXDATAMSB0_TXUSERCLKIN0_negedge_posedge(2),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB0_TXUSERCLKIN0_posedge(3),
        TimingData => Tmkr_TXDATAMSB0_TXUSERCLKIN0_posedge(3),
        TestSignal => TXDATAMSB0_TXUSERCLKIN0_dly(3),
        TestSignalName => "TXDATAMSB0(3)",
        TestDelay => tisd_TXDATAMSB0_TXUSERCLKIN0(3),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATAMSB0_TXUSERCLKIN0_posedge_posedge(3),
        HoldHigh => thold_TXDATAMSB0_TXUSERCLKIN0_posedge_posedge(3),
        SetupLow => tsetup_TXDATAMSB0_TXUSERCLKIN0_negedge_posedge(3),
        HoldLow => thold_TXDATAMSB0_TXUSERCLKIN0_negedge_posedge(3),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB0_TXUSERCLKIN0_posedge(4),
        TimingData => Tmkr_TXDATAMSB0_TXUSERCLKIN0_posedge(4),
        TestSignal => TXDATAMSB0_TXUSERCLKIN0_dly(4),
        TestSignalName => "TXDATAMSB0(4)",
        TestDelay => tisd_TXDATAMSB0_TXUSERCLKIN0(4),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATAMSB0_TXUSERCLKIN0_posedge_posedge(4),
        HoldHigh => thold_TXDATAMSB0_TXUSERCLKIN0_posedge_posedge(4),
        SetupLow => tsetup_TXDATAMSB0_TXUSERCLKIN0_negedge_posedge(4),
        HoldLow => thold_TXDATAMSB0_TXUSERCLKIN0_negedge_posedge(4),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB0_TXUSERCLKIN0_posedge(5),
        TimingData => Tmkr_TXDATAMSB0_TXUSERCLKIN0_posedge(5),
        TestSignal => TXDATAMSB0_TXUSERCLKIN0_dly(5),
        TestSignalName => "TXDATAMSB0(5)",
        TestDelay => tisd_TXDATAMSB0_TXUSERCLKIN0(5),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATAMSB0_TXUSERCLKIN0_posedge_posedge(5),
        HoldHigh => thold_TXDATAMSB0_TXUSERCLKIN0_posedge_posedge(5),
        SetupLow => tsetup_TXDATAMSB0_TXUSERCLKIN0_negedge_posedge(5),
        HoldLow => thold_TXDATAMSB0_TXUSERCLKIN0_negedge_posedge(5),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB0_TXUSERCLKIN0_posedge(6),
        TimingData => Tmkr_TXDATAMSB0_TXUSERCLKIN0_posedge(6),
        TestSignal => TXDATAMSB0_TXUSERCLKIN0_dly(6),
        TestSignalName => "TXDATAMSB0(6)",
        TestDelay => tisd_TXDATAMSB0_TXUSERCLKIN0(6),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATAMSB0_TXUSERCLKIN0_posedge_posedge(6),
        HoldHigh => thold_TXDATAMSB0_TXUSERCLKIN0_posedge_posedge(6),
        SetupLow => tsetup_TXDATAMSB0_TXUSERCLKIN0_negedge_posedge(6),
        HoldLow => thold_TXDATAMSB0_TXUSERCLKIN0_negedge_posedge(6),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB0_TXUSERCLKIN0_posedge(7),
        TimingData => Tmkr_TXDATAMSB0_TXUSERCLKIN0_posedge(7),
        TestSignal => TXDATAMSB0_TXUSERCLKIN0_dly(7),
        TestSignalName => "TXDATAMSB0(7)",
        TestDelay => tisd_TXDATAMSB0_TXUSERCLKIN0(7),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDATAMSB0_TXUSERCLKIN0_posedge_posedge(7),
        HoldHigh => thold_TXDATAMSB0_TXUSERCLKIN0_posedge_posedge(7),
        SetupLow => tsetup_TXDATAMSB0_TXUSERCLKIN0_negedge_posedge(7),
        HoldLow => thold_TXDATAMSB0_TXUSERCLKIN0_negedge_posedge(7),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB1_TXUSERCLKIN1_posedge(0),
        TimingData => Tmkr_TXDATAMSB1_TXUSERCLKIN1_posedge(0),
        TestSignal => TXDATAMSB1_TXUSERCLKIN1_dly(0),
        TestSignalName => "TXDATAMSB1(0)",
        TestDelay => tisd_TXDATAMSB1_TXUSERCLKIN1(0),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATAMSB1_TXUSERCLKIN1_posedge_posedge(0),
        HoldHigh => thold_TXDATAMSB1_TXUSERCLKIN1_posedge_posedge(0),
        SetupLow => tsetup_TXDATAMSB1_TXUSERCLKIN1_negedge_posedge(0),
        HoldLow => thold_TXDATAMSB1_TXUSERCLKIN1_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB1_TXUSERCLKIN1_posedge(1),
        TimingData => Tmkr_TXDATAMSB1_TXUSERCLKIN1_posedge(1),
        TestSignal => TXDATAMSB1_TXUSERCLKIN1_dly(1),
        TestSignalName => "TXDATAMSB1(1)",
        TestDelay => tisd_TXDATAMSB1_TXUSERCLKIN1(1),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATAMSB1_TXUSERCLKIN1_posedge_posedge(1),
        HoldHigh => thold_TXDATAMSB1_TXUSERCLKIN1_posedge_posedge(1),
        SetupLow => tsetup_TXDATAMSB1_TXUSERCLKIN1_negedge_posedge(1),
        HoldLow => thold_TXDATAMSB1_TXUSERCLKIN1_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB1_TXUSERCLKIN1_posedge(2),
        TimingData => Tmkr_TXDATAMSB1_TXUSERCLKIN1_posedge(2),
        TestSignal => TXDATAMSB1_TXUSERCLKIN1_dly(2),
        TestSignalName => "TXDATAMSB1(2)",
        TestDelay => tisd_TXDATAMSB1_TXUSERCLKIN1(2),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATAMSB1_TXUSERCLKIN1_posedge_posedge(2),
        HoldHigh => thold_TXDATAMSB1_TXUSERCLKIN1_posedge_posedge(2),
        SetupLow => tsetup_TXDATAMSB1_TXUSERCLKIN1_negedge_posedge(2),
        HoldLow => thold_TXDATAMSB1_TXUSERCLKIN1_negedge_posedge(2),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB1_TXUSERCLKIN1_posedge(3),
        TimingData => Tmkr_TXDATAMSB1_TXUSERCLKIN1_posedge(3),
        TestSignal => TXDATAMSB1_TXUSERCLKIN1_dly(3),
        TestSignalName => "TXDATAMSB1(3)",
        TestDelay => tisd_TXDATAMSB1_TXUSERCLKIN1(3),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATAMSB1_TXUSERCLKIN1_posedge_posedge(3),
        HoldHigh => thold_TXDATAMSB1_TXUSERCLKIN1_posedge_posedge(3),
        SetupLow => tsetup_TXDATAMSB1_TXUSERCLKIN1_negedge_posedge(3),
        HoldLow => thold_TXDATAMSB1_TXUSERCLKIN1_negedge_posedge(3),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB1_TXUSERCLKIN1_posedge(4),
        TimingData => Tmkr_TXDATAMSB1_TXUSERCLKIN1_posedge(4),
        TestSignal => TXDATAMSB1_TXUSERCLKIN1_dly(4),
        TestSignalName => "TXDATAMSB1(4)",
        TestDelay => tisd_TXDATAMSB1_TXUSERCLKIN1(4),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATAMSB1_TXUSERCLKIN1_posedge_posedge(4),
        HoldHigh => thold_TXDATAMSB1_TXUSERCLKIN1_posedge_posedge(4),
        SetupLow => tsetup_TXDATAMSB1_TXUSERCLKIN1_negedge_posedge(4),
        HoldLow => thold_TXDATAMSB1_TXUSERCLKIN1_negedge_posedge(4),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB1_TXUSERCLKIN1_posedge(5),
        TimingData => Tmkr_TXDATAMSB1_TXUSERCLKIN1_posedge(5),
        TestSignal => TXDATAMSB1_TXUSERCLKIN1_dly(5),
        TestSignalName => "TXDATAMSB1(5)",
        TestDelay => tisd_TXDATAMSB1_TXUSERCLKIN1(5),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATAMSB1_TXUSERCLKIN1_posedge_posedge(5),
        HoldHigh => thold_TXDATAMSB1_TXUSERCLKIN1_posedge_posedge(5),
        SetupLow => tsetup_TXDATAMSB1_TXUSERCLKIN1_negedge_posedge(5),
        HoldLow => thold_TXDATAMSB1_TXUSERCLKIN1_negedge_posedge(5),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB1_TXUSERCLKIN1_posedge(6),
        TimingData => Tmkr_TXDATAMSB1_TXUSERCLKIN1_posedge(6),
        TestSignal => TXDATAMSB1_TXUSERCLKIN1_dly(6),
        TestSignalName => "TXDATAMSB1(6)",
        TestDelay => tisd_TXDATAMSB1_TXUSERCLKIN1(6),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATAMSB1_TXUSERCLKIN1_posedge_posedge(6),
        HoldHigh => thold_TXDATAMSB1_TXUSERCLKIN1_posedge_posedge(6),
        SetupLow => tsetup_TXDATAMSB1_TXUSERCLKIN1_negedge_posedge(6),
        HoldLow => thold_TXDATAMSB1_TXUSERCLKIN1_negedge_posedge(6),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB1_TXUSERCLKIN1_posedge(7),
        TimingData => Tmkr_TXDATAMSB1_TXUSERCLKIN1_posedge(7),
        TestSignal => TXDATAMSB1_TXUSERCLKIN1_dly(7),
        TestSignalName => "TXDATAMSB1(7)",
        TestDelay => tisd_TXDATAMSB1_TXUSERCLKIN1(7),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDATAMSB1_TXUSERCLKIN1_posedge_posedge(7),
        HoldHigh => thold_TXDATAMSB1_TXUSERCLKIN1_posedge_posedge(7),
        SetupLow => tsetup_TXDATAMSB1_TXUSERCLKIN1_negedge_posedge(7),
        HoldLow => thold_TXDATAMSB1_TXUSERCLKIN1_negedge_posedge(7),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB2_TXUSERCLKIN2_posedge(0),
        TimingData => Tmkr_TXDATAMSB2_TXUSERCLKIN2_posedge(0),
        TestSignal => TXDATAMSB2_TXUSERCLKIN2_dly(0),
        TestSignalName => "TXDATAMSB2(0)",
        TestDelay => tisd_TXDATAMSB2_TXUSERCLKIN2(0),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATAMSB2_TXUSERCLKIN2_posedge_posedge(0),
        HoldHigh => thold_TXDATAMSB2_TXUSERCLKIN2_posedge_posedge(0),
        SetupLow => tsetup_TXDATAMSB2_TXUSERCLKIN2_negedge_posedge(0),
        HoldLow => thold_TXDATAMSB2_TXUSERCLKIN2_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB2_TXUSERCLKIN2_posedge(1),
        TimingData => Tmkr_TXDATAMSB2_TXUSERCLKIN2_posedge(1),
        TestSignal => TXDATAMSB2_TXUSERCLKIN2_dly(1),
        TestSignalName => "TXDATAMSB2(1)",
        TestDelay => tisd_TXDATAMSB2_TXUSERCLKIN2(1),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATAMSB2_TXUSERCLKIN2_posedge_posedge(1),
        HoldHigh => thold_TXDATAMSB2_TXUSERCLKIN2_posedge_posedge(1),
        SetupLow => tsetup_TXDATAMSB2_TXUSERCLKIN2_negedge_posedge(1),
        HoldLow => thold_TXDATAMSB2_TXUSERCLKIN2_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB2_TXUSERCLKIN2_posedge(2),
        TimingData => Tmkr_TXDATAMSB2_TXUSERCLKIN2_posedge(2),
        TestSignal => TXDATAMSB2_TXUSERCLKIN2_dly(2),
        TestSignalName => "TXDATAMSB2(2)",
        TestDelay => tisd_TXDATAMSB2_TXUSERCLKIN2(2),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATAMSB2_TXUSERCLKIN2_posedge_posedge(2),
        HoldHigh => thold_TXDATAMSB2_TXUSERCLKIN2_posedge_posedge(2),
        SetupLow => tsetup_TXDATAMSB2_TXUSERCLKIN2_negedge_posedge(2),
        HoldLow => thold_TXDATAMSB2_TXUSERCLKIN2_negedge_posedge(2),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB2_TXUSERCLKIN2_posedge(3),
        TimingData => Tmkr_TXDATAMSB2_TXUSERCLKIN2_posedge(3),
        TestSignal => TXDATAMSB2_TXUSERCLKIN2_dly(3),
        TestSignalName => "TXDATAMSB2(3)",
        TestDelay => tisd_TXDATAMSB2_TXUSERCLKIN2(3),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATAMSB2_TXUSERCLKIN2_posedge_posedge(3),
        HoldHigh => thold_TXDATAMSB2_TXUSERCLKIN2_posedge_posedge(3),
        SetupLow => tsetup_TXDATAMSB2_TXUSERCLKIN2_negedge_posedge(3),
        HoldLow => thold_TXDATAMSB2_TXUSERCLKIN2_negedge_posedge(3),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB2_TXUSERCLKIN2_posedge(4),
        TimingData => Tmkr_TXDATAMSB2_TXUSERCLKIN2_posedge(4),
        TestSignal => TXDATAMSB2_TXUSERCLKIN2_dly(4),
        TestSignalName => "TXDATAMSB2(4)",
        TestDelay => tisd_TXDATAMSB2_TXUSERCLKIN2(4),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATAMSB2_TXUSERCLKIN2_posedge_posedge(4),
        HoldHigh => thold_TXDATAMSB2_TXUSERCLKIN2_posedge_posedge(4),
        SetupLow => tsetup_TXDATAMSB2_TXUSERCLKIN2_negedge_posedge(4),
        HoldLow => thold_TXDATAMSB2_TXUSERCLKIN2_negedge_posedge(4),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB2_TXUSERCLKIN2_posedge(5),
        TimingData => Tmkr_TXDATAMSB2_TXUSERCLKIN2_posedge(5),
        TestSignal => TXDATAMSB2_TXUSERCLKIN2_dly(5),
        TestSignalName => "TXDATAMSB2(5)",
        TestDelay => tisd_TXDATAMSB2_TXUSERCLKIN2(5),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATAMSB2_TXUSERCLKIN2_posedge_posedge(5),
        HoldHigh => thold_TXDATAMSB2_TXUSERCLKIN2_posedge_posedge(5),
        SetupLow => tsetup_TXDATAMSB2_TXUSERCLKIN2_negedge_posedge(5),
        HoldLow => thold_TXDATAMSB2_TXUSERCLKIN2_negedge_posedge(5),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB2_TXUSERCLKIN2_posedge(6),
        TimingData => Tmkr_TXDATAMSB2_TXUSERCLKIN2_posedge(6),
        TestSignal => TXDATAMSB2_TXUSERCLKIN2_dly(6),
        TestSignalName => "TXDATAMSB2(6)",
        TestDelay => tisd_TXDATAMSB2_TXUSERCLKIN2(6),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATAMSB2_TXUSERCLKIN2_posedge_posedge(6),
        HoldHigh => thold_TXDATAMSB2_TXUSERCLKIN2_posedge_posedge(6),
        SetupLow => tsetup_TXDATAMSB2_TXUSERCLKIN2_negedge_posedge(6),
        HoldLow => thold_TXDATAMSB2_TXUSERCLKIN2_negedge_posedge(6),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB2_TXUSERCLKIN2_posedge(7),
        TimingData => Tmkr_TXDATAMSB2_TXUSERCLKIN2_posedge(7),
        TestSignal => TXDATAMSB2_TXUSERCLKIN2_dly(7),
        TestSignalName => "TXDATAMSB2(7)",
        TestDelay => tisd_TXDATAMSB2_TXUSERCLKIN2(7),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDATAMSB2_TXUSERCLKIN2_posedge_posedge(7),
        HoldHigh => thold_TXDATAMSB2_TXUSERCLKIN2_posedge_posedge(7),
        SetupLow => tsetup_TXDATAMSB2_TXUSERCLKIN2_negedge_posedge(7),
        HoldLow => thold_TXDATAMSB2_TXUSERCLKIN2_negedge_posedge(7),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB3_TXUSERCLKIN3_posedge(0),
        TimingData => Tmkr_TXDATAMSB3_TXUSERCLKIN3_posedge(0),
        TestSignal => TXDATAMSB3_TXUSERCLKIN3_dly(0),
        TestSignalName => "TXDATAMSB3(0)",
        TestDelay => tisd_TXDATAMSB3_TXUSERCLKIN3(0),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATAMSB3_TXUSERCLKIN3_posedge_posedge(0),
        HoldHigh => thold_TXDATAMSB3_TXUSERCLKIN3_posedge_posedge(0),
        SetupLow => tsetup_TXDATAMSB3_TXUSERCLKIN3_negedge_posedge(0),
        HoldLow => thold_TXDATAMSB3_TXUSERCLKIN3_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB3_TXUSERCLKIN3_posedge(1),
        TimingData => Tmkr_TXDATAMSB3_TXUSERCLKIN3_posedge(1),
        TestSignal => TXDATAMSB3_TXUSERCLKIN3_dly(1),
        TestSignalName => "TXDATAMSB3(1)",
        TestDelay => tisd_TXDATAMSB3_TXUSERCLKIN3(1),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATAMSB3_TXUSERCLKIN3_posedge_posedge(1),
        HoldHigh => thold_TXDATAMSB3_TXUSERCLKIN3_posedge_posedge(1),
        SetupLow => tsetup_TXDATAMSB3_TXUSERCLKIN3_negedge_posedge(1),
        HoldLow => thold_TXDATAMSB3_TXUSERCLKIN3_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB3_TXUSERCLKIN3_posedge(2),
        TimingData => Tmkr_TXDATAMSB3_TXUSERCLKIN3_posedge(2),
        TestSignal => TXDATAMSB3_TXUSERCLKIN3_dly(2),
        TestSignalName => "TXDATAMSB3(2)",
        TestDelay => tisd_TXDATAMSB3_TXUSERCLKIN3(2),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATAMSB3_TXUSERCLKIN3_posedge_posedge(2),
        HoldHigh => thold_TXDATAMSB3_TXUSERCLKIN3_posedge_posedge(2),
        SetupLow => tsetup_TXDATAMSB3_TXUSERCLKIN3_negedge_posedge(2),
        HoldLow => thold_TXDATAMSB3_TXUSERCLKIN3_negedge_posedge(2),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB3_TXUSERCLKIN3_posedge(3),
        TimingData => Tmkr_TXDATAMSB3_TXUSERCLKIN3_posedge(3),
        TestSignal => TXDATAMSB3_TXUSERCLKIN3_dly(3),
        TestSignalName => "TXDATAMSB3(3)",
        TestDelay => tisd_TXDATAMSB3_TXUSERCLKIN3(3),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATAMSB3_TXUSERCLKIN3_posedge_posedge(3),
        HoldHigh => thold_TXDATAMSB3_TXUSERCLKIN3_posedge_posedge(3),
        SetupLow => tsetup_TXDATAMSB3_TXUSERCLKIN3_negedge_posedge(3),
        HoldLow => thold_TXDATAMSB3_TXUSERCLKIN3_negedge_posedge(3),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB3_TXUSERCLKIN3_posedge(4),
        TimingData => Tmkr_TXDATAMSB3_TXUSERCLKIN3_posedge(4),
        TestSignal => TXDATAMSB3_TXUSERCLKIN3_dly(4),
        TestSignalName => "TXDATAMSB3(4)",
        TestDelay => tisd_TXDATAMSB3_TXUSERCLKIN3(4),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATAMSB3_TXUSERCLKIN3_posedge_posedge(4),
        HoldHigh => thold_TXDATAMSB3_TXUSERCLKIN3_posedge_posedge(4),
        SetupLow => tsetup_TXDATAMSB3_TXUSERCLKIN3_negedge_posedge(4),
        HoldLow => thold_TXDATAMSB3_TXUSERCLKIN3_negedge_posedge(4),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB3_TXUSERCLKIN3_posedge(5),
        TimingData => Tmkr_TXDATAMSB3_TXUSERCLKIN3_posedge(5),
        TestSignal => TXDATAMSB3_TXUSERCLKIN3_dly(5),
        TestSignalName => "TXDATAMSB3(5)",
        TestDelay => tisd_TXDATAMSB3_TXUSERCLKIN3(5),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATAMSB3_TXUSERCLKIN3_posedge_posedge(5),
        HoldHigh => thold_TXDATAMSB3_TXUSERCLKIN3_posedge_posedge(5),
        SetupLow => tsetup_TXDATAMSB3_TXUSERCLKIN3_negedge_posedge(5),
        HoldLow => thold_TXDATAMSB3_TXUSERCLKIN3_negedge_posedge(5),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB3_TXUSERCLKIN3_posedge(6),
        TimingData => Tmkr_TXDATAMSB3_TXUSERCLKIN3_posedge(6),
        TestSignal => TXDATAMSB3_TXUSERCLKIN3_dly(6),
        TestSignalName => "TXDATAMSB3(6)",
        TestDelay => tisd_TXDATAMSB3_TXUSERCLKIN3(6),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATAMSB3_TXUSERCLKIN3_posedge_posedge(6),
        HoldHigh => thold_TXDATAMSB3_TXUSERCLKIN3_posedge_posedge(6),
        SetupLow => tsetup_TXDATAMSB3_TXUSERCLKIN3_negedge_posedge(6),
        HoldLow => thold_TXDATAMSB3_TXUSERCLKIN3_negedge_posedge(6),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDATAMSB3_TXUSERCLKIN3_posedge(7),
        TimingData => Tmkr_TXDATAMSB3_TXUSERCLKIN3_posedge(7),
        TestSignal => TXDATAMSB3_TXUSERCLKIN3_dly(7),
        TestSignalName => "TXDATAMSB3(7)",
        TestDelay => tisd_TXDATAMSB3_TXUSERCLKIN3(7),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDATAMSB3_TXUSERCLKIN3_posedge_posedge(7),
        HoldHigh => thold_TXDATAMSB3_TXUSERCLKIN3_posedge_posedge(7),
        SetupLow => tsetup_TXDATAMSB3_TXUSERCLKIN3_negedge_posedge(7),
        HoldLow => thold_TXDATAMSB3_TXUSERCLKIN3_negedge_posedge(7),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDEEMPH0_TXUSERCLKIN0_posedge,
        TimingData => Tmkr_TXDEEMPH0_TXUSERCLKIN0_posedge,
        TestSignal => TXDEEMPH0_TXUSERCLKIN0_dly,
        TestSignalName => "TXDEEMPH0",
        TestDelay => tisd_TXDEEMPH0_TXUSERCLKIN0,
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXDEEMPH0_TXUSERCLKIN0_posedge_posedge,
        HoldHigh => thold_TXDEEMPH0_TXUSERCLKIN0_posedge_posedge,
        SetupLow => tsetup_TXDEEMPH0_TXUSERCLKIN0_negedge_posedge,
        HoldLow => thold_TXDEEMPH0_TXUSERCLKIN0_negedge_posedge,
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDEEMPH1_TXUSERCLKIN1_posedge,
        TimingData => Tmkr_TXDEEMPH1_TXUSERCLKIN1_posedge,
        TestSignal => TXDEEMPH1_TXUSERCLKIN1_dly,
        TestSignalName => "TXDEEMPH1",
        TestDelay => tisd_TXDEEMPH1_TXUSERCLKIN1,
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXDEEMPH1_TXUSERCLKIN1_posedge_posedge,
        HoldHigh => thold_TXDEEMPH1_TXUSERCLKIN1_posedge_posedge,
        SetupLow => tsetup_TXDEEMPH1_TXUSERCLKIN1_negedge_posedge,
        HoldLow => thold_TXDEEMPH1_TXUSERCLKIN1_negedge_posedge,
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDEEMPH2_TXUSERCLKIN2_posedge,
        TimingData => Tmkr_TXDEEMPH2_TXUSERCLKIN2_posedge,
        TestSignal => TXDEEMPH2_TXUSERCLKIN2_dly,
        TestSignalName => "TXDEEMPH2",
        TestDelay => tisd_TXDEEMPH2_TXUSERCLKIN2,
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXDEEMPH2_TXUSERCLKIN2_posedge_posedge,
        HoldHigh => thold_TXDEEMPH2_TXUSERCLKIN2_posedge_posedge,
        SetupLow => tsetup_TXDEEMPH2_TXUSERCLKIN2_negedge_posedge,
        HoldLow => thold_TXDEEMPH2_TXUSERCLKIN2_negedge_posedge,
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXDEEMPH3_TXUSERCLKIN3_posedge,
        TimingData => Tmkr_TXDEEMPH3_TXUSERCLKIN3_posedge,
        TestSignal => TXDEEMPH3_TXUSERCLKIN3_dly,
        TestSignalName => "TXDEEMPH3",
        TestDelay => tisd_TXDEEMPH3_TXUSERCLKIN3,
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXDEEMPH3_TXUSERCLKIN3_posedge_posedge,
        HoldHigh => thold_TXDEEMPH3_TXUSERCLKIN3_posedge_posedge,
        SetupLow => tsetup_TXDEEMPH3_TXUSERCLKIN3_negedge_posedge,
        HoldLow => thold_TXDEEMPH3_TXUSERCLKIN3_negedge_posedge,
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXMARGIN0_TXUSERCLKIN0_posedge(0),
        TimingData => Tmkr_TXMARGIN0_TXUSERCLKIN0_posedge(0),
        TestSignal => TXMARGIN0_TXUSERCLKIN0_dly(0),
        TestSignalName => "TXMARGIN0(0)",
        TestDelay => tisd_TXMARGIN0_TXUSERCLKIN0(0),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXMARGIN0_TXUSERCLKIN0_posedge_posedge(0),
        HoldHigh => thold_TXMARGIN0_TXUSERCLKIN0_posedge_posedge(0),
        SetupLow => tsetup_TXMARGIN0_TXUSERCLKIN0_negedge_posedge(0),
        HoldLow => thold_TXMARGIN0_TXUSERCLKIN0_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXMARGIN0_TXUSERCLKIN0_posedge(1),
        TimingData => Tmkr_TXMARGIN0_TXUSERCLKIN0_posedge(1),
        TestSignal => TXMARGIN0_TXUSERCLKIN0_dly(1),
        TestSignalName => "TXMARGIN0(1)",
        TestDelay => tisd_TXMARGIN0_TXUSERCLKIN0(1),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXMARGIN0_TXUSERCLKIN0_posedge_posedge(1),
        HoldHigh => thold_TXMARGIN0_TXUSERCLKIN0_posedge_posedge(1),
        SetupLow => tsetup_TXMARGIN0_TXUSERCLKIN0_negedge_posedge(1),
        HoldLow => thold_TXMARGIN0_TXUSERCLKIN0_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXMARGIN0_TXUSERCLKIN0_posedge(2),
        TimingData => Tmkr_TXMARGIN0_TXUSERCLKIN0_posedge(2),
        TestSignal => TXMARGIN0_TXUSERCLKIN0_dly(2),
        TestSignalName => "TXMARGIN0(2)",
        TestDelay => tisd_TXMARGIN0_TXUSERCLKIN0(2),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXMARGIN0_TXUSERCLKIN0_posedge_posedge(2),
        HoldHigh => thold_TXMARGIN0_TXUSERCLKIN0_posedge_posedge(2),
        SetupLow => tsetup_TXMARGIN0_TXUSERCLKIN0_negedge_posedge(2),
        HoldLow => thold_TXMARGIN0_TXUSERCLKIN0_negedge_posedge(2),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXMARGIN1_TXUSERCLKIN1_posedge(0),
        TimingData => Tmkr_TXMARGIN1_TXUSERCLKIN1_posedge(0),
        TestSignal => TXMARGIN1_TXUSERCLKIN1_dly(0),
        TestSignalName => "TXMARGIN1(0)",
        TestDelay => tisd_TXMARGIN1_TXUSERCLKIN1(0),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXMARGIN1_TXUSERCLKIN1_posedge_posedge(0),
        HoldHigh => thold_TXMARGIN1_TXUSERCLKIN1_posedge_posedge(0),
        SetupLow => tsetup_TXMARGIN1_TXUSERCLKIN1_negedge_posedge(0),
        HoldLow => thold_TXMARGIN1_TXUSERCLKIN1_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXMARGIN1_TXUSERCLKIN1_posedge(1),
        TimingData => Tmkr_TXMARGIN1_TXUSERCLKIN1_posedge(1),
        TestSignal => TXMARGIN1_TXUSERCLKIN1_dly(1),
        TestSignalName => "TXMARGIN1(1)",
        TestDelay => tisd_TXMARGIN1_TXUSERCLKIN1(1),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXMARGIN1_TXUSERCLKIN1_posedge_posedge(1),
        HoldHigh => thold_TXMARGIN1_TXUSERCLKIN1_posedge_posedge(1),
        SetupLow => tsetup_TXMARGIN1_TXUSERCLKIN1_negedge_posedge(1),
        HoldLow => thold_TXMARGIN1_TXUSERCLKIN1_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXMARGIN1_TXUSERCLKIN1_posedge(2),
        TimingData => Tmkr_TXMARGIN1_TXUSERCLKIN1_posedge(2),
        TestSignal => TXMARGIN1_TXUSERCLKIN1_dly(2),
        TestSignalName => "TXMARGIN1(2)",
        TestDelay => tisd_TXMARGIN1_TXUSERCLKIN1(2),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXMARGIN1_TXUSERCLKIN1_posedge_posedge(2),
        HoldHigh => thold_TXMARGIN1_TXUSERCLKIN1_posedge_posedge(2),
        SetupLow => tsetup_TXMARGIN1_TXUSERCLKIN1_negedge_posedge(2),
        HoldLow => thold_TXMARGIN1_TXUSERCLKIN1_negedge_posedge(2),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXMARGIN2_TXUSERCLKIN2_posedge(0),
        TimingData => Tmkr_TXMARGIN2_TXUSERCLKIN2_posedge(0),
        TestSignal => TXMARGIN2_TXUSERCLKIN2_dly(0),
        TestSignalName => "TXMARGIN2(0)",
        TestDelay => tisd_TXMARGIN2_TXUSERCLKIN2(0),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXMARGIN2_TXUSERCLKIN2_posedge_posedge(0),
        HoldHigh => thold_TXMARGIN2_TXUSERCLKIN2_posedge_posedge(0),
        SetupLow => tsetup_TXMARGIN2_TXUSERCLKIN2_negedge_posedge(0),
        HoldLow => thold_TXMARGIN2_TXUSERCLKIN2_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXMARGIN2_TXUSERCLKIN2_posedge(1),
        TimingData => Tmkr_TXMARGIN2_TXUSERCLKIN2_posedge(1),
        TestSignal => TXMARGIN2_TXUSERCLKIN2_dly(1),
        TestSignalName => "TXMARGIN2(1)",
        TestDelay => tisd_TXMARGIN2_TXUSERCLKIN2(1),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXMARGIN2_TXUSERCLKIN2_posedge_posedge(1),
        HoldHigh => thold_TXMARGIN2_TXUSERCLKIN2_posedge_posedge(1),
        SetupLow => tsetup_TXMARGIN2_TXUSERCLKIN2_negedge_posedge(1),
        HoldLow => thold_TXMARGIN2_TXUSERCLKIN2_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXMARGIN2_TXUSERCLKIN2_posedge(2),
        TimingData => Tmkr_TXMARGIN2_TXUSERCLKIN2_posedge(2),
        TestSignal => TXMARGIN2_TXUSERCLKIN2_dly(2),
        TestSignalName => "TXMARGIN2(2)",
        TestDelay => tisd_TXMARGIN2_TXUSERCLKIN2(2),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXMARGIN2_TXUSERCLKIN2_posedge_posedge(2),
        HoldHigh => thold_TXMARGIN2_TXUSERCLKIN2_posedge_posedge(2),
        SetupLow => tsetup_TXMARGIN2_TXUSERCLKIN2_negedge_posedge(2),
        HoldLow => thold_TXMARGIN2_TXUSERCLKIN2_negedge_posedge(2),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXMARGIN3_TXUSERCLKIN3_posedge(0),
        TimingData => Tmkr_TXMARGIN3_TXUSERCLKIN3_posedge(0),
        TestSignal => TXMARGIN3_TXUSERCLKIN3_dly(0),
        TestSignalName => "TXMARGIN3(0)",
        TestDelay => tisd_TXMARGIN3_TXUSERCLKIN3(0),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXMARGIN3_TXUSERCLKIN3_posedge_posedge(0),
        HoldHigh => thold_TXMARGIN3_TXUSERCLKIN3_posedge_posedge(0),
        SetupLow => tsetup_TXMARGIN3_TXUSERCLKIN3_negedge_posedge(0),
        HoldLow => thold_TXMARGIN3_TXUSERCLKIN3_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXMARGIN3_TXUSERCLKIN3_posedge(1),
        TimingData => Tmkr_TXMARGIN3_TXUSERCLKIN3_posedge(1),
        TestSignal => TXMARGIN3_TXUSERCLKIN3_dly(1),
        TestSignalName => "TXMARGIN3(1)",
        TestDelay => tisd_TXMARGIN3_TXUSERCLKIN3(1),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXMARGIN3_TXUSERCLKIN3_posedge_posedge(1),
        HoldHigh => thold_TXMARGIN3_TXUSERCLKIN3_posedge_posedge(1),
        SetupLow => tsetup_TXMARGIN3_TXUSERCLKIN3_negedge_posedge(1),
        HoldLow => thold_TXMARGIN3_TXUSERCLKIN3_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXMARGIN3_TXUSERCLKIN3_posedge(2),
        TimingData => Tmkr_TXMARGIN3_TXUSERCLKIN3_posedge(2),
        TestSignal => TXMARGIN3_TXUSERCLKIN3_dly(2),
        TestSignalName => "TXMARGIN3(2)",
        TestDelay => tisd_TXMARGIN3_TXUSERCLKIN3(2),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXMARGIN3_TXUSERCLKIN3_posedge_posedge(2),
        HoldHigh => thold_TXMARGIN3_TXUSERCLKIN3_posedge_posedge(2),
        SetupLow => tsetup_TXMARGIN3_TXUSERCLKIN3_negedge_posedge(2),
        HoldLow => thold_TXMARGIN3_TXUSERCLKIN3_negedge_posedge(2),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXPOWERDOWN0_TXUSERCLKIN0_posedge(0),
        TimingData => Tmkr_TXPOWERDOWN0_TXUSERCLKIN0_posedge(0),
        TestSignal => TXPOWERDOWN0_TXUSERCLKIN0_dly(0),
        TestSignalName => "TXPOWERDOWN0(0)",
        TestDelay => tisd_TXPOWERDOWN0_TXUSERCLKIN0(0),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXPOWERDOWN0_TXUSERCLKIN0_posedge_posedge(0),
        HoldHigh => thold_TXPOWERDOWN0_TXUSERCLKIN0_posedge_posedge(0),
        SetupLow => tsetup_TXPOWERDOWN0_TXUSERCLKIN0_negedge_posedge(0),
        HoldLow => thold_TXPOWERDOWN0_TXUSERCLKIN0_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXPOWERDOWN0_TXUSERCLKIN0_posedge(1),
        TimingData => Tmkr_TXPOWERDOWN0_TXUSERCLKIN0_posedge(1),
        TestSignal => TXPOWERDOWN0_TXUSERCLKIN0_dly(1),
        TestSignalName => "TXPOWERDOWN0(1)",
        TestDelay => tisd_TXPOWERDOWN0_TXUSERCLKIN0(1),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXPOWERDOWN0_TXUSERCLKIN0_posedge_posedge(1),
        HoldHigh => thold_TXPOWERDOWN0_TXUSERCLKIN0_posedge_posedge(1),
        SetupLow => tsetup_TXPOWERDOWN0_TXUSERCLKIN0_negedge_posedge(1),
        HoldLow => thold_TXPOWERDOWN0_TXUSERCLKIN0_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXPOWERDOWN1_TXUSERCLKIN1_posedge(0),
        TimingData => Tmkr_TXPOWERDOWN1_TXUSERCLKIN1_posedge(0),
        TestSignal => TXPOWERDOWN1_TXUSERCLKIN1_dly(0),
        TestSignalName => "TXPOWERDOWN1(0)",
        TestDelay => tisd_TXPOWERDOWN1_TXUSERCLKIN1(0),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXPOWERDOWN1_TXUSERCLKIN1_posedge_posedge(0),
        HoldHigh => thold_TXPOWERDOWN1_TXUSERCLKIN1_posedge_posedge(0),
        SetupLow => tsetup_TXPOWERDOWN1_TXUSERCLKIN1_negedge_posedge(0),
        HoldLow => thold_TXPOWERDOWN1_TXUSERCLKIN1_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXPOWERDOWN1_TXUSERCLKIN1_posedge(1),
        TimingData => Tmkr_TXPOWERDOWN1_TXUSERCLKIN1_posedge(1),
        TestSignal => TXPOWERDOWN1_TXUSERCLKIN1_dly(1),
        TestSignalName => "TXPOWERDOWN1(1)",
        TestDelay => tisd_TXPOWERDOWN1_TXUSERCLKIN1(1),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXPOWERDOWN1_TXUSERCLKIN1_posedge_posedge(1),
        HoldHigh => thold_TXPOWERDOWN1_TXUSERCLKIN1_posedge_posedge(1),
        SetupLow => tsetup_TXPOWERDOWN1_TXUSERCLKIN1_negedge_posedge(1),
        HoldLow => thold_TXPOWERDOWN1_TXUSERCLKIN1_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXPOWERDOWN2_TXUSERCLKIN2_posedge(0),
        TimingData => Tmkr_TXPOWERDOWN2_TXUSERCLKIN2_posedge(0),
        TestSignal => TXPOWERDOWN2_TXUSERCLKIN2_dly(0),
        TestSignalName => "TXPOWERDOWN2(0)",
        TestDelay => tisd_TXPOWERDOWN2_TXUSERCLKIN2(0),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXPOWERDOWN2_TXUSERCLKIN2_posedge_posedge(0),
        HoldHigh => thold_TXPOWERDOWN2_TXUSERCLKIN2_posedge_posedge(0),
        SetupLow => tsetup_TXPOWERDOWN2_TXUSERCLKIN2_negedge_posedge(0),
        HoldLow => thold_TXPOWERDOWN2_TXUSERCLKIN2_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXPOWERDOWN2_TXUSERCLKIN2_posedge(1),
        TimingData => Tmkr_TXPOWERDOWN2_TXUSERCLKIN2_posedge(1),
        TestSignal => TXPOWERDOWN2_TXUSERCLKIN2_dly(1),
        TestSignalName => "TXPOWERDOWN2(1)",
        TestDelay => tisd_TXPOWERDOWN2_TXUSERCLKIN2(1),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXPOWERDOWN2_TXUSERCLKIN2_posedge_posedge(1),
        HoldHigh => thold_TXPOWERDOWN2_TXUSERCLKIN2_posedge_posedge(1),
        SetupLow => tsetup_TXPOWERDOWN2_TXUSERCLKIN2_negedge_posedge(1),
        HoldLow => thold_TXPOWERDOWN2_TXUSERCLKIN2_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXPOWERDOWN3_TXUSERCLKIN3_posedge(0),
        TimingData => Tmkr_TXPOWERDOWN3_TXUSERCLKIN3_posedge(0),
        TestSignal => TXPOWERDOWN3_TXUSERCLKIN3_dly(0),
        TestSignalName => "TXPOWERDOWN3(0)",
        TestDelay => tisd_TXPOWERDOWN3_TXUSERCLKIN3(0),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXPOWERDOWN3_TXUSERCLKIN3_posedge_posedge(0),
        HoldHigh => thold_TXPOWERDOWN3_TXUSERCLKIN3_posedge_posedge(0),
        SetupLow => tsetup_TXPOWERDOWN3_TXUSERCLKIN3_negedge_posedge(0),
        HoldLow => thold_TXPOWERDOWN3_TXUSERCLKIN3_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXPOWERDOWN3_TXUSERCLKIN3_posedge(1),
        TimingData => Tmkr_TXPOWERDOWN3_TXUSERCLKIN3_posedge(1),
        TestSignal => TXPOWERDOWN3_TXUSERCLKIN3_dly(1),
        TestSignalName => "TXPOWERDOWN3(1)",
        TestDelay => tisd_TXPOWERDOWN3_TXUSERCLKIN3(1),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXPOWERDOWN3_TXUSERCLKIN3_posedge_posedge(1),
        HoldHigh => thold_TXPOWERDOWN3_TXUSERCLKIN3_posedge_posedge(1),
        SetupLow => tsetup_TXPOWERDOWN3_TXUSERCLKIN3_negedge_posedge(1),
        HoldLow => thold_TXPOWERDOWN3_TXUSERCLKIN3_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXRATE0_TXUSERCLKIN0_posedge(0),
        TimingData => Tmkr_TXRATE0_TXUSERCLKIN0_posedge(0),
        TestSignal => TXRATE0_TXUSERCLKIN0_dly(0),
        TestSignalName => "TXRATE0(0)",
        TestDelay => tisd_TXRATE0_TXUSERCLKIN0(0),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXRATE0_TXUSERCLKIN0_posedge_posedge(0),
        HoldHigh => thold_TXRATE0_TXUSERCLKIN0_posedge_posedge(0),
        SetupLow => tsetup_TXRATE0_TXUSERCLKIN0_negedge_posedge(0),
        HoldLow => thold_TXRATE0_TXUSERCLKIN0_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXRATE0_TXUSERCLKIN0_posedge(1),
        TimingData => Tmkr_TXRATE0_TXUSERCLKIN0_posedge(1),
        TestSignal => TXRATE0_TXUSERCLKIN0_dly(1),
        TestSignalName => "TXRATE0(1)",
        TestDelay => tisd_TXRATE0_TXUSERCLKIN0(1),
        RefSignal => TXUSERCLKIN0_dly,
        RefSignalName => "TXUSERCLKIN0",
        RefDelay => ticd_TXUSERCLKIN0,
        SetupHigh => tsetup_TXRATE0_TXUSERCLKIN0_posedge_posedge(1),
        HoldHigh => thold_TXRATE0_TXUSERCLKIN0_posedge_posedge(1),
        SetupLow => tsetup_TXRATE0_TXUSERCLKIN0_negedge_posedge(1),
        HoldLow => thold_TXRATE0_TXUSERCLKIN0_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXRATE1_TXUSERCLKIN1_posedge(0),
        TimingData => Tmkr_TXRATE1_TXUSERCLKIN1_posedge(0),
        TestSignal => TXRATE1_TXUSERCLKIN1_dly(0),
        TestSignalName => "TXRATE1(0)",
        TestDelay => tisd_TXRATE1_TXUSERCLKIN1(0),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXRATE1_TXUSERCLKIN1_posedge_posedge(0),
        HoldHigh => thold_TXRATE1_TXUSERCLKIN1_posedge_posedge(0),
        SetupLow => tsetup_TXRATE1_TXUSERCLKIN1_negedge_posedge(0),
        HoldLow => thold_TXRATE1_TXUSERCLKIN1_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXRATE1_TXUSERCLKIN1_posedge(1),
        TimingData => Tmkr_TXRATE1_TXUSERCLKIN1_posedge(1),
        TestSignal => TXRATE1_TXUSERCLKIN1_dly(1),
        TestSignalName => "TXRATE1(1)",
        TestDelay => tisd_TXRATE1_TXUSERCLKIN1(1),
        RefSignal => TXUSERCLKIN1_dly,
        RefSignalName => "TXUSERCLKIN1",
        RefDelay => ticd_TXUSERCLKIN1,
        SetupHigh => tsetup_TXRATE1_TXUSERCLKIN1_posedge_posedge(1),
        HoldHigh => thold_TXRATE1_TXUSERCLKIN1_posedge_posedge(1),
        SetupLow => tsetup_TXRATE1_TXUSERCLKIN1_negedge_posedge(1),
        HoldLow => thold_TXRATE1_TXUSERCLKIN1_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXRATE2_TXUSERCLKIN2_posedge(0),
        TimingData => Tmkr_TXRATE2_TXUSERCLKIN2_posedge(0),
        TestSignal => TXRATE2_TXUSERCLKIN2_dly(0),
        TestSignalName => "TXRATE2(0)",
        TestDelay => tisd_TXRATE2_TXUSERCLKIN2(0),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXRATE2_TXUSERCLKIN2_posedge_posedge(0),
        HoldHigh => thold_TXRATE2_TXUSERCLKIN2_posedge_posedge(0),
        SetupLow => tsetup_TXRATE2_TXUSERCLKIN2_negedge_posedge(0),
        HoldLow => thold_TXRATE2_TXUSERCLKIN2_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXRATE2_TXUSERCLKIN2_posedge(1),
        TimingData => Tmkr_TXRATE2_TXUSERCLKIN2_posedge(1),
        TestSignal => TXRATE2_TXUSERCLKIN2_dly(1),
        TestSignalName => "TXRATE2(1)",
        TestDelay => tisd_TXRATE2_TXUSERCLKIN2(1),
        RefSignal => TXUSERCLKIN2_dly,
        RefSignalName => "TXUSERCLKIN2",
        RefDelay => ticd_TXUSERCLKIN2,
        SetupHigh => tsetup_TXRATE2_TXUSERCLKIN2_posedge_posedge(1),
        HoldHigh => thold_TXRATE2_TXUSERCLKIN2_posedge_posedge(1),
        SetupLow => tsetup_TXRATE2_TXUSERCLKIN2_negedge_posedge(1),
        HoldLow => thold_TXRATE2_TXUSERCLKIN2_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXRATE3_TXUSERCLKIN3_posedge(0),
        TimingData => Tmkr_TXRATE3_TXUSERCLKIN3_posedge(0),
        TestSignal => TXRATE3_TXUSERCLKIN3_dly(0),
        TestSignalName => "TXRATE3(0)",
        TestDelay => tisd_TXRATE3_TXUSERCLKIN3(0),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXRATE3_TXUSERCLKIN3_posedge_posedge(0),
        HoldHigh => thold_TXRATE3_TXUSERCLKIN3_posedge_posedge(0),
        SetupLow => tsetup_TXRATE3_TXUSERCLKIN3_negedge_posedge(0),
        HoldLow => thold_TXRATE3_TXUSERCLKIN3_negedge_posedge(0),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalSetupHoldCheck
      (
        Violation => Tviol_TXRATE3_TXUSERCLKIN3_posedge(1),
        TimingData => Tmkr_TXRATE3_TXUSERCLKIN3_posedge(1),
        TestSignal => TXRATE3_TXUSERCLKIN3_dly(1),
        TestSignalName => "TXRATE3(1)",
        TestDelay => tisd_TXRATE3_TXUSERCLKIN3(1),
        RefSignal => TXUSERCLKIN3_dly,
        RefSignalName => "TXUSERCLKIN3",
        RefDelay => ticd_TXUSERCLKIN3,
        SetupHigh => tsetup_TXRATE3_TXUSERCLKIN3_posedge_posedge(1),
        HoldHigh => thold_TXRATE3_TXUSERCLKIN3_posedge_posedge(1),
        SetupLow => tsetup_TXRATE3_TXUSERCLKIN3_negedge_posedge(1),
        HoldLow => thold_TXRATE3_TXUSERCLKIN3_negedge_posedge(1),
        CheckEnabled   => TRUE,
        RefTransition  => 'R',
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
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
        OutSignal     => GTHINITDONE,
        GlitchData    => GTHINITDONE_GlitchData,
        OutSignalName => "GTHINITDONE",
        OutTemp       => GTHINITDONE_out,
        Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_GTHINITDONE,TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => MGMTPCSRDACK,
        GlitchData    => MGMTPCSRDACK_GlitchData,
        OutSignalName => "MGMTPCSRDACK",
        OutTemp       => MGMTPCSRDACK_out,
        Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_MGMTPCSRDACK,TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => MGMTPCSRDDATA(0),
        GlitchData    => MGMTPCSRDDATA0_GlitchData,
        OutSignalName => "MGMTPCSRDDATA(0)",
        OutTemp       => MGMTPCSRDDATA_out(0),
        Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_MGMTPCSRDDATA(0),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => MGMTPCSRDDATA(1),
        GlitchData    => MGMTPCSRDDATA1_GlitchData,
        OutSignalName => "MGMTPCSRDDATA(1)",
        OutTemp       => MGMTPCSRDDATA_out(1),
        Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_MGMTPCSRDDATA(1),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => MGMTPCSRDDATA(10),
        GlitchData    => MGMTPCSRDDATA10_GlitchData,
        OutSignalName => "MGMTPCSRDDATA(10)",
        OutTemp       => MGMTPCSRDDATA_out(10),
        Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_MGMTPCSRDDATA(10),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => MGMTPCSRDDATA(11),
        GlitchData    => MGMTPCSRDDATA11_GlitchData,
        OutSignalName => "MGMTPCSRDDATA(11)",
        OutTemp       => MGMTPCSRDDATA_out(11),
        Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_MGMTPCSRDDATA(11),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => MGMTPCSRDDATA(12),
        GlitchData    => MGMTPCSRDDATA12_GlitchData,
        OutSignalName => "MGMTPCSRDDATA(12)",
        OutTemp       => MGMTPCSRDDATA_out(12),
        Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_MGMTPCSRDDATA(12),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => MGMTPCSRDDATA(13),
        GlitchData    => MGMTPCSRDDATA13_GlitchData,
        OutSignalName => "MGMTPCSRDDATA(13)",
        OutTemp       => MGMTPCSRDDATA_out(13),
        Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_MGMTPCSRDDATA(13),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => MGMTPCSRDDATA(14),
        GlitchData    => MGMTPCSRDDATA14_GlitchData,
        OutSignalName => "MGMTPCSRDDATA(14)",
        OutTemp       => MGMTPCSRDDATA_out(14),
        Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_MGMTPCSRDDATA(14),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => MGMTPCSRDDATA(15),
        GlitchData    => MGMTPCSRDDATA15_GlitchData,
        OutSignalName => "MGMTPCSRDDATA(15)",
        OutTemp       => MGMTPCSRDDATA_out(15),
        Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_MGMTPCSRDDATA(15),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => MGMTPCSRDDATA(2),
        GlitchData    => MGMTPCSRDDATA2_GlitchData,
        OutSignalName => "MGMTPCSRDDATA(2)",
        OutTemp       => MGMTPCSRDDATA_out(2),
        Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_MGMTPCSRDDATA(2),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => MGMTPCSRDDATA(3),
        GlitchData    => MGMTPCSRDDATA3_GlitchData,
        OutSignalName => "MGMTPCSRDDATA(3)",
        OutTemp       => MGMTPCSRDDATA_out(3),
        Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_MGMTPCSRDDATA(3),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => MGMTPCSRDDATA(4),
        GlitchData    => MGMTPCSRDDATA4_GlitchData,
        OutSignalName => "MGMTPCSRDDATA(4)",
        OutTemp       => MGMTPCSRDDATA_out(4),
        Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_MGMTPCSRDDATA(4),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => MGMTPCSRDDATA(5),
        GlitchData    => MGMTPCSRDDATA5_GlitchData,
        OutSignalName => "MGMTPCSRDDATA(5)",
        OutTemp       => MGMTPCSRDDATA_out(5),
        Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_MGMTPCSRDDATA(5),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => MGMTPCSRDDATA(6),
        GlitchData    => MGMTPCSRDDATA6_GlitchData,
        OutSignalName => "MGMTPCSRDDATA(6)",
        OutTemp       => MGMTPCSRDDATA_out(6),
        Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_MGMTPCSRDDATA(6),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => MGMTPCSRDDATA(7),
        GlitchData    => MGMTPCSRDDATA7_GlitchData,
        OutSignalName => "MGMTPCSRDDATA(7)",
        OutTemp       => MGMTPCSRDDATA_out(7),
        Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_MGMTPCSRDDATA(7),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => MGMTPCSRDDATA(8),
        GlitchData    => MGMTPCSRDDATA8_GlitchData,
        OutSignalName => "MGMTPCSRDDATA(8)",
        OutTemp       => MGMTPCSRDDATA_out(8),
        Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_MGMTPCSRDDATA(8),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => MGMTPCSRDDATA(9),
        GlitchData    => MGMTPCSRDDATA9_GlitchData,
        OutSignalName => "MGMTPCSRDDATA(9)",
        OutTemp       => MGMTPCSRDDATA_out(9),
        Paths       => (0 => (DCLK_dly'last_event, tpd_DCLK_MGMTPCSRDDATA(9),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR0(0),
        GlitchData    => RXCODEERR00_GlitchData,
        OutSignalName => "RXCODEERR0(0)",
        OutTemp       => RXCODEERR0_out(0),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXCODEERR0(0),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR0(1),
        GlitchData    => RXCODEERR01_GlitchData,
        OutSignalName => "RXCODEERR0(1)",
        OutTemp       => RXCODEERR0_out(1),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXCODEERR0(1),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR0(2),
        GlitchData    => RXCODEERR02_GlitchData,
        OutSignalName => "RXCODEERR0(2)",
        OutTemp       => RXCODEERR0_out(2),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXCODEERR0(2),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR0(3),
        GlitchData    => RXCODEERR03_GlitchData,
        OutSignalName => "RXCODEERR0(3)",
        OutTemp       => RXCODEERR0_out(3),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXCODEERR0(3),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR0(4),
        GlitchData    => RXCODEERR04_GlitchData,
        OutSignalName => "RXCODEERR0(4)",
        OutTemp       => RXCODEERR0_out(4),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXCODEERR0(4),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR0(5),
        GlitchData    => RXCODEERR05_GlitchData,
        OutSignalName => "RXCODEERR0(5)",
        OutTemp       => RXCODEERR0_out(5),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXCODEERR0(5),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR0(6),
        GlitchData    => RXCODEERR06_GlitchData,
        OutSignalName => "RXCODEERR0(6)",
        OutTemp       => RXCODEERR0_out(6),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXCODEERR0(6),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR0(7),
        GlitchData    => RXCODEERR07_GlitchData,
        OutSignalName => "RXCODEERR0(7)",
        OutTemp       => RXCODEERR0_out(7),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXCODEERR0(7),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR1(0),
        GlitchData    => RXCODEERR10_GlitchData,
        OutSignalName => "RXCODEERR1(0)",
        OutTemp       => RXCODEERR1_out(0),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXCODEERR1(0),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR1(1),
        GlitchData    => RXCODEERR11_GlitchData,
        OutSignalName => "RXCODEERR1(1)",
        OutTemp       => RXCODEERR1_out(1),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXCODEERR1(1),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR1(2),
        GlitchData    => RXCODEERR12_GlitchData,
        OutSignalName => "RXCODEERR1(2)",
        OutTemp       => RXCODEERR1_out(2),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXCODEERR1(2),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR1(3),
        GlitchData    => RXCODEERR13_GlitchData,
        OutSignalName => "RXCODEERR1(3)",
        OutTemp       => RXCODEERR1_out(3),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXCODEERR1(3),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR1(4),
        GlitchData    => RXCODEERR14_GlitchData,
        OutSignalName => "RXCODEERR1(4)",
        OutTemp       => RXCODEERR1_out(4),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXCODEERR1(4),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR1(5),
        GlitchData    => RXCODEERR15_GlitchData,
        OutSignalName => "RXCODEERR1(5)",
        OutTemp       => RXCODEERR1_out(5),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXCODEERR1(5),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR1(6),
        GlitchData    => RXCODEERR16_GlitchData,
        OutSignalName => "RXCODEERR1(6)",
        OutTemp       => RXCODEERR1_out(6),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXCODEERR1(6),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR1(7),
        GlitchData    => RXCODEERR17_GlitchData,
        OutSignalName => "RXCODEERR1(7)",
        OutTemp       => RXCODEERR1_out(7),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXCODEERR1(7),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR2(0),
        GlitchData    => RXCODEERR20_GlitchData,
        OutSignalName => "RXCODEERR2(0)",
        OutTemp       => RXCODEERR2_out(0),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXCODEERR2(0),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR2(1),
        GlitchData    => RXCODEERR21_GlitchData,
        OutSignalName => "RXCODEERR2(1)",
        OutTemp       => RXCODEERR2_out(1),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXCODEERR2(1),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR2(2),
        GlitchData    => RXCODEERR22_GlitchData,
        OutSignalName => "RXCODEERR2(2)",
        OutTemp       => RXCODEERR2_out(2),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXCODEERR2(2),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR2(3),
        GlitchData    => RXCODEERR23_GlitchData,
        OutSignalName => "RXCODEERR2(3)",
        OutTemp       => RXCODEERR2_out(3),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXCODEERR2(3),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR2(4),
        GlitchData    => RXCODEERR24_GlitchData,
        OutSignalName => "RXCODEERR2(4)",
        OutTemp       => RXCODEERR2_out(4),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXCODEERR2(4),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR2(5),
        GlitchData    => RXCODEERR25_GlitchData,
        OutSignalName => "RXCODEERR2(5)",
        OutTemp       => RXCODEERR2_out(5),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXCODEERR2(5),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR2(6),
        GlitchData    => RXCODEERR26_GlitchData,
        OutSignalName => "RXCODEERR2(6)",
        OutTemp       => RXCODEERR2_out(6),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXCODEERR2(6),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR2(7),
        GlitchData    => RXCODEERR27_GlitchData,
        OutSignalName => "RXCODEERR2(7)",
        OutTemp       => RXCODEERR2_out(7),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXCODEERR2(7),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR3(0),
        GlitchData    => RXCODEERR30_GlitchData,
        OutSignalName => "RXCODEERR3(0)",
        OutTemp       => RXCODEERR3_out(0),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXCODEERR3(0),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR3(1),
        GlitchData    => RXCODEERR31_GlitchData,
        OutSignalName => "RXCODEERR3(1)",
        OutTemp       => RXCODEERR3_out(1),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXCODEERR3(1),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR3(2),
        GlitchData    => RXCODEERR32_GlitchData,
        OutSignalName => "RXCODEERR3(2)",
        OutTemp       => RXCODEERR3_out(2),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXCODEERR3(2),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR3(3),
        GlitchData    => RXCODEERR33_GlitchData,
        OutSignalName => "RXCODEERR3(3)",
        OutTemp       => RXCODEERR3_out(3),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXCODEERR3(3),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR3(4),
        GlitchData    => RXCODEERR34_GlitchData,
        OutSignalName => "RXCODEERR3(4)",
        OutTemp       => RXCODEERR3_out(4),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXCODEERR3(4),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR3(5),
        GlitchData    => RXCODEERR35_GlitchData,
        OutSignalName => "RXCODEERR3(5)",
        OutTemp       => RXCODEERR3_out(5),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXCODEERR3(5),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR3(6),
        GlitchData    => RXCODEERR36_GlitchData,
        OutSignalName => "RXCODEERR3(6)",
        OutTemp       => RXCODEERR3_out(6),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXCODEERR3(6),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCODEERR3(7),
        GlitchData    => RXCODEERR37_GlitchData,
        OutSignalName => "RXCODEERR3(7)",
        OutTemp       => RXCODEERR3_out(7),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXCODEERR3(7),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL0(0),
        GlitchData    => RXCTRL00_GlitchData,
        OutSignalName => "RXCTRL0(0)",
        OutTemp       => RXCTRL0_out(0),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXCTRL0(0),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL0(1),
        GlitchData    => RXCTRL01_GlitchData,
        OutSignalName => "RXCTRL0(1)",
        OutTemp       => RXCTRL0_out(1),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXCTRL0(1),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL0(2),
        GlitchData    => RXCTRL02_GlitchData,
        OutSignalName => "RXCTRL0(2)",
        OutTemp       => RXCTRL0_out(2),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXCTRL0(2),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL0(3),
        GlitchData    => RXCTRL03_GlitchData,
        OutSignalName => "RXCTRL0(3)",
        OutTemp       => RXCTRL0_out(3),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXCTRL0(3),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL0(4),
        GlitchData    => RXCTRL04_GlitchData,
        OutSignalName => "RXCTRL0(4)",
        OutTemp       => RXCTRL0_out(4),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXCTRL0(4),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL0(5),
        GlitchData    => RXCTRL05_GlitchData,
        OutSignalName => "RXCTRL0(5)",
        OutTemp       => RXCTRL0_out(5),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXCTRL0(5),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL0(6),
        GlitchData    => RXCTRL06_GlitchData,
        OutSignalName => "RXCTRL0(6)",
        OutTemp       => RXCTRL0_out(6),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXCTRL0(6),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL0(7),
        GlitchData    => RXCTRL07_GlitchData,
        OutSignalName => "RXCTRL0(7)",
        OutTemp       => RXCTRL0_out(7),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXCTRL0(7),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL1(0),
        GlitchData    => RXCTRL10_GlitchData,
        OutSignalName => "RXCTRL1(0)",
        OutTemp       => RXCTRL1_out(0),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXCTRL1(0),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL1(1),
        GlitchData    => RXCTRL11_GlitchData,
        OutSignalName => "RXCTRL1(1)",
        OutTemp       => RXCTRL1_out(1),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXCTRL1(1),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL1(2),
        GlitchData    => RXCTRL12_GlitchData,
        OutSignalName => "RXCTRL1(2)",
        OutTemp       => RXCTRL1_out(2),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXCTRL1(2),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL1(3),
        GlitchData    => RXCTRL13_GlitchData,
        OutSignalName => "RXCTRL1(3)",
        OutTemp       => RXCTRL1_out(3),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXCTRL1(3),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL1(4),
        GlitchData    => RXCTRL14_GlitchData,
        OutSignalName => "RXCTRL1(4)",
        OutTemp       => RXCTRL1_out(4),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXCTRL1(4),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL1(5),
        GlitchData    => RXCTRL15_GlitchData,
        OutSignalName => "RXCTRL1(5)",
        OutTemp       => RXCTRL1_out(5),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXCTRL1(5),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL1(6),
        GlitchData    => RXCTRL16_GlitchData,
        OutSignalName => "RXCTRL1(6)",
        OutTemp       => RXCTRL1_out(6),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXCTRL1(6),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL1(7),
        GlitchData    => RXCTRL17_GlitchData,
        OutSignalName => "RXCTRL1(7)",
        OutTemp       => RXCTRL1_out(7),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXCTRL1(7),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL2(0),
        GlitchData    => RXCTRL20_GlitchData,
        OutSignalName => "RXCTRL2(0)",
        OutTemp       => RXCTRL2_out(0),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXCTRL2(0),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL2(1),
        GlitchData    => RXCTRL21_GlitchData,
        OutSignalName => "RXCTRL2(1)",
        OutTemp       => RXCTRL2_out(1),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXCTRL2(1),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL2(2),
        GlitchData    => RXCTRL22_GlitchData,
        OutSignalName => "RXCTRL2(2)",
        OutTemp       => RXCTRL2_out(2),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXCTRL2(2),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL2(3),
        GlitchData    => RXCTRL23_GlitchData,
        OutSignalName => "RXCTRL2(3)",
        OutTemp       => RXCTRL2_out(3),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXCTRL2(3),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL2(4),
        GlitchData    => RXCTRL24_GlitchData,
        OutSignalName => "RXCTRL2(4)",
        OutTemp       => RXCTRL2_out(4),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXCTRL2(4),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL2(5),
        GlitchData    => RXCTRL25_GlitchData,
        OutSignalName => "RXCTRL2(5)",
        OutTemp       => RXCTRL2_out(5),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXCTRL2(5),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL2(6),
        GlitchData    => RXCTRL26_GlitchData,
        OutSignalName => "RXCTRL2(6)",
        OutTemp       => RXCTRL2_out(6),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXCTRL2(6),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL2(7),
        GlitchData    => RXCTRL27_GlitchData,
        OutSignalName => "RXCTRL2(7)",
        OutTemp       => RXCTRL2_out(7),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXCTRL2(7),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL3(0),
        GlitchData    => RXCTRL30_GlitchData,
        OutSignalName => "RXCTRL3(0)",
        OutTemp       => RXCTRL3_out(0),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXCTRL3(0),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL3(1),
        GlitchData    => RXCTRL31_GlitchData,
        OutSignalName => "RXCTRL3(1)",
        OutTemp       => RXCTRL3_out(1),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXCTRL3(1),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL3(2),
        GlitchData    => RXCTRL32_GlitchData,
        OutSignalName => "RXCTRL3(2)",
        OutTemp       => RXCTRL3_out(2),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXCTRL3(2),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL3(3),
        GlitchData    => RXCTRL33_GlitchData,
        OutSignalName => "RXCTRL3(3)",
        OutTemp       => RXCTRL3_out(3),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXCTRL3(3),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL3(4),
        GlitchData    => RXCTRL34_GlitchData,
        OutSignalName => "RXCTRL3(4)",
        OutTemp       => RXCTRL3_out(4),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXCTRL3(4),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL3(5),
        GlitchData    => RXCTRL35_GlitchData,
        OutSignalName => "RXCTRL3(5)",
        OutTemp       => RXCTRL3_out(5),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXCTRL3(5),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL3(6),
        GlitchData    => RXCTRL36_GlitchData,
        OutSignalName => "RXCTRL3(6)",
        OutTemp       => RXCTRL3_out(6),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXCTRL3(6),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRL3(7),
        GlitchData    => RXCTRL37_GlitchData,
        OutSignalName => "RXCTRL3(7)",
        OutTemp       => RXCTRL3_out(7),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXCTRL3(7),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRLACK0,
        GlitchData    => RXCTRLACK0_GlitchData,
        OutSignalName => "RXCTRLACK0",
        OutTemp       => RXCTRLACK0_out,
        Paths       => (0 => (TXUSERCLKIN0_dly'last_event, tpd_TXUSERCLKIN0_RXCTRLACK0,TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRLACK1,
        GlitchData    => RXCTRLACK1_GlitchData,
        OutSignalName => "RXCTRLACK1",
        OutTemp       => RXCTRLACK1_out,
        Paths       => (0 => (TXUSERCLKIN1_dly'last_event, tpd_TXUSERCLKIN1_RXCTRLACK1,TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRLACK2,
        GlitchData    => RXCTRLACK2_GlitchData,
        OutSignalName => "RXCTRLACK2",
        OutTemp       => RXCTRLACK2_out,
        Paths       => (0 => (TXUSERCLKIN2_dly'last_event, tpd_TXUSERCLKIN2_RXCTRLACK2,TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXCTRLACK3,
        GlitchData    => RXCTRLACK3_GlitchData,
        OutSignalName => "RXCTRLACK3",
        OutTemp       => RXCTRLACK3_out,
        Paths       => (0 => (TXUSERCLKIN3_dly'last_event, tpd_TXUSERCLKIN3_RXCTRLACK3,TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(0),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(1),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(10),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(11),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(12),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(13),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(14),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(15),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(16),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(17),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(18),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(19),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(2),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(20),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(21),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(22),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(23),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(24),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(25),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(26),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(27),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(28),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(29),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(3),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(30),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(31),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(32),
        GlitchData    => RXDATA032_GlitchData,
        OutSignalName => "RXDATA0(32)",
        OutTemp       => RXDATA0_out(32),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(32),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(33),
        GlitchData    => RXDATA033_GlitchData,
        OutSignalName => "RXDATA0(33)",
        OutTemp       => RXDATA0_out(33),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(33),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(34),
        GlitchData    => RXDATA034_GlitchData,
        OutSignalName => "RXDATA0(34)",
        OutTemp       => RXDATA0_out(34),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(34),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(35),
        GlitchData    => RXDATA035_GlitchData,
        OutSignalName => "RXDATA0(35)",
        OutTemp       => RXDATA0_out(35),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(35),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(36),
        GlitchData    => RXDATA036_GlitchData,
        OutSignalName => "RXDATA0(36)",
        OutTemp       => RXDATA0_out(36),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(36),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(37),
        GlitchData    => RXDATA037_GlitchData,
        OutSignalName => "RXDATA0(37)",
        OutTemp       => RXDATA0_out(37),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(37),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(38),
        GlitchData    => RXDATA038_GlitchData,
        OutSignalName => "RXDATA0(38)",
        OutTemp       => RXDATA0_out(38),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(38),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(39),
        GlitchData    => RXDATA039_GlitchData,
        OutSignalName => "RXDATA0(39)",
        OutTemp       => RXDATA0_out(39),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(39),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(4),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(40),
        GlitchData    => RXDATA040_GlitchData,
        OutSignalName => "RXDATA0(40)",
        OutTemp       => RXDATA0_out(40),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(40),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(41),
        GlitchData    => RXDATA041_GlitchData,
        OutSignalName => "RXDATA0(41)",
        OutTemp       => RXDATA0_out(41),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(41),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(42),
        GlitchData    => RXDATA042_GlitchData,
        OutSignalName => "RXDATA0(42)",
        OutTemp       => RXDATA0_out(42),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(42),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(43),
        GlitchData    => RXDATA043_GlitchData,
        OutSignalName => "RXDATA0(43)",
        OutTemp       => RXDATA0_out(43),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(43),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(44),
        GlitchData    => RXDATA044_GlitchData,
        OutSignalName => "RXDATA0(44)",
        OutTemp       => RXDATA0_out(44),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(44),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(45),
        GlitchData    => RXDATA045_GlitchData,
        OutSignalName => "RXDATA0(45)",
        OutTemp       => RXDATA0_out(45),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(45),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(46),
        GlitchData    => RXDATA046_GlitchData,
        OutSignalName => "RXDATA0(46)",
        OutTemp       => RXDATA0_out(46),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(46),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(47),
        GlitchData    => RXDATA047_GlitchData,
        OutSignalName => "RXDATA0(47)",
        OutTemp       => RXDATA0_out(47),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(47),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(48),
        GlitchData    => RXDATA048_GlitchData,
        OutSignalName => "RXDATA0(48)",
        OutTemp       => RXDATA0_out(48),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(48),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(49),
        GlitchData    => RXDATA049_GlitchData,
        OutSignalName => "RXDATA0(49)",
        OutTemp       => RXDATA0_out(49),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(49),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(5),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(50),
        GlitchData    => RXDATA050_GlitchData,
        OutSignalName => "RXDATA0(50)",
        OutTemp       => RXDATA0_out(50),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(50),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(51),
        GlitchData    => RXDATA051_GlitchData,
        OutSignalName => "RXDATA0(51)",
        OutTemp       => RXDATA0_out(51),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(51),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(52),
        GlitchData    => RXDATA052_GlitchData,
        OutSignalName => "RXDATA0(52)",
        OutTemp       => RXDATA0_out(52),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(52),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(53),
        GlitchData    => RXDATA053_GlitchData,
        OutSignalName => "RXDATA0(53)",
        OutTemp       => RXDATA0_out(53),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(53),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(54),
        GlitchData    => RXDATA054_GlitchData,
        OutSignalName => "RXDATA0(54)",
        OutTemp       => RXDATA0_out(54),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(54),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(55),
        GlitchData    => RXDATA055_GlitchData,
        OutSignalName => "RXDATA0(55)",
        OutTemp       => RXDATA0_out(55),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(55),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(56),
        GlitchData    => RXDATA056_GlitchData,
        OutSignalName => "RXDATA0(56)",
        OutTemp       => RXDATA0_out(56),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(56),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(57),
        GlitchData    => RXDATA057_GlitchData,
        OutSignalName => "RXDATA0(57)",
        OutTemp       => RXDATA0_out(57),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(57),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(58),
        GlitchData    => RXDATA058_GlitchData,
        OutSignalName => "RXDATA0(58)",
        OutTemp       => RXDATA0_out(58),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(58),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(59),
        GlitchData    => RXDATA059_GlitchData,
        OutSignalName => "RXDATA0(59)",
        OutTemp       => RXDATA0_out(59),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(59),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(6),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(60),
        GlitchData    => RXDATA060_GlitchData,
        OutSignalName => "RXDATA0(60)",
        OutTemp       => RXDATA0_out(60),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(60),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(61),
        GlitchData    => RXDATA061_GlitchData,
        OutSignalName => "RXDATA0(61)",
        OutTemp       => RXDATA0_out(61),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(61),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(62),
        GlitchData    => RXDATA062_GlitchData,
        OutSignalName => "RXDATA0(62)",
        OutTemp       => RXDATA0_out(62),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(62),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA0(63),
        GlitchData    => RXDATA063_GlitchData,
        OutSignalName => "RXDATA0(63)",
        OutTemp       => RXDATA0_out(63),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(63),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(7),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(8),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDATA0(9),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(0),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(1),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(10),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(11),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(12),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(13),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(14),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(15),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(16),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(17),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(18),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(19),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(2),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(20),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(21),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(22),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(23),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(24),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(25),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(26),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(27),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(28),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(29),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(3),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(30),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(31),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(32),
        GlitchData    => RXDATA132_GlitchData,
        OutSignalName => "RXDATA1(32)",
        OutTemp       => RXDATA1_out(32),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(32),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(33),
        GlitchData    => RXDATA133_GlitchData,
        OutSignalName => "RXDATA1(33)",
        OutTemp       => RXDATA1_out(33),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(33),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(34),
        GlitchData    => RXDATA134_GlitchData,
        OutSignalName => "RXDATA1(34)",
        OutTemp       => RXDATA1_out(34),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(34),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(35),
        GlitchData    => RXDATA135_GlitchData,
        OutSignalName => "RXDATA1(35)",
        OutTemp       => RXDATA1_out(35),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(35),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(36),
        GlitchData    => RXDATA136_GlitchData,
        OutSignalName => "RXDATA1(36)",
        OutTemp       => RXDATA1_out(36),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(36),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(37),
        GlitchData    => RXDATA137_GlitchData,
        OutSignalName => "RXDATA1(37)",
        OutTemp       => RXDATA1_out(37),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(37),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(38),
        GlitchData    => RXDATA138_GlitchData,
        OutSignalName => "RXDATA1(38)",
        OutTemp       => RXDATA1_out(38),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(38),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(39),
        GlitchData    => RXDATA139_GlitchData,
        OutSignalName => "RXDATA1(39)",
        OutTemp       => RXDATA1_out(39),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(39),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(4),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(40),
        GlitchData    => RXDATA140_GlitchData,
        OutSignalName => "RXDATA1(40)",
        OutTemp       => RXDATA1_out(40),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(40),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(41),
        GlitchData    => RXDATA141_GlitchData,
        OutSignalName => "RXDATA1(41)",
        OutTemp       => RXDATA1_out(41),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(41),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(42),
        GlitchData    => RXDATA142_GlitchData,
        OutSignalName => "RXDATA1(42)",
        OutTemp       => RXDATA1_out(42),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(42),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(43),
        GlitchData    => RXDATA143_GlitchData,
        OutSignalName => "RXDATA1(43)",
        OutTemp       => RXDATA1_out(43),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(43),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(44),
        GlitchData    => RXDATA144_GlitchData,
        OutSignalName => "RXDATA1(44)",
        OutTemp       => RXDATA1_out(44),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(44),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(45),
        GlitchData    => RXDATA145_GlitchData,
        OutSignalName => "RXDATA1(45)",
        OutTemp       => RXDATA1_out(45),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(45),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(46),
        GlitchData    => RXDATA146_GlitchData,
        OutSignalName => "RXDATA1(46)",
        OutTemp       => RXDATA1_out(46),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(46),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(47),
        GlitchData    => RXDATA147_GlitchData,
        OutSignalName => "RXDATA1(47)",
        OutTemp       => RXDATA1_out(47),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(47),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(48),
        GlitchData    => RXDATA148_GlitchData,
        OutSignalName => "RXDATA1(48)",
        OutTemp       => RXDATA1_out(48),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(48),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(49),
        GlitchData    => RXDATA149_GlitchData,
        OutSignalName => "RXDATA1(49)",
        OutTemp       => RXDATA1_out(49),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(49),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(5),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(50),
        GlitchData    => RXDATA150_GlitchData,
        OutSignalName => "RXDATA1(50)",
        OutTemp       => RXDATA1_out(50),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(50),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(51),
        GlitchData    => RXDATA151_GlitchData,
        OutSignalName => "RXDATA1(51)",
        OutTemp       => RXDATA1_out(51),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(51),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(52),
        GlitchData    => RXDATA152_GlitchData,
        OutSignalName => "RXDATA1(52)",
        OutTemp       => RXDATA1_out(52),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(52),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(53),
        GlitchData    => RXDATA153_GlitchData,
        OutSignalName => "RXDATA1(53)",
        OutTemp       => RXDATA1_out(53),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(53),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(54),
        GlitchData    => RXDATA154_GlitchData,
        OutSignalName => "RXDATA1(54)",
        OutTemp       => RXDATA1_out(54),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(54),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(55),
        GlitchData    => RXDATA155_GlitchData,
        OutSignalName => "RXDATA1(55)",
        OutTemp       => RXDATA1_out(55),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(55),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(56),
        GlitchData    => RXDATA156_GlitchData,
        OutSignalName => "RXDATA1(56)",
        OutTemp       => RXDATA1_out(56),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(56),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(57),
        GlitchData    => RXDATA157_GlitchData,
        OutSignalName => "RXDATA1(57)",
        OutTemp       => RXDATA1_out(57),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(57),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(58),
        GlitchData    => RXDATA158_GlitchData,
        OutSignalName => "RXDATA1(58)",
        OutTemp       => RXDATA1_out(58),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(58),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(59),
        GlitchData    => RXDATA159_GlitchData,
        OutSignalName => "RXDATA1(59)",
        OutTemp       => RXDATA1_out(59),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(59),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(6),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(60),
        GlitchData    => RXDATA160_GlitchData,
        OutSignalName => "RXDATA1(60)",
        OutTemp       => RXDATA1_out(60),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(60),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(61),
        GlitchData    => RXDATA161_GlitchData,
        OutSignalName => "RXDATA1(61)",
        OutTemp       => RXDATA1_out(61),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(61),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(62),
        GlitchData    => RXDATA162_GlitchData,
        OutSignalName => "RXDATA1(62)",
        OutTemp       => RXDATA1_out(62),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(62),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA1(63),
        GlitchData    => RXDATA163_GlitchData,
        OutSignalName => "RXDATA1(63)",
        OutTemp       => RXDATA1_out(63),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(63),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(7),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(8),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDATA1(9),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(0),
        GlitchData    => RXDATA20_GlitchData,
        OutSignalName => "RXDATA2(0)",
        OutTemp       => RXDATA2_out(0),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(0),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(1),
        GlitchData    => RXDATA21_GlitchData,
        OutSignalName => "RXDATA2(1)",
        OutTemp       => RXDATA2_out(1),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(1),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(10),
        GlitchData    => RXDATA210_GlitchData,
        OutSignalName => "RXDATA2(10)",
        OutTemp       => RXDATA2_out(10),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(10),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(11),
        GlitchData    => RXDATA211_GlitchData,
        OutSignalName => "RXDATA2(11)",
        OutTemp       => RXDATA2_out(11),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(11),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(12),
        GlitchData    => RXDATA212_GlitchData,
        OutSignalName => "RXDATA2(12)",
        OutTemp       => RXDATA2_out(12),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(12),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(13),
        GlitchData    => RXDATA213_GlitchData,
        OutSignalName => "RXDATA2(13)",
        OutTemp       => RXDATA2_out(13),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(13),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(14),
        GlitchData    => RXDATA214_GlitchData,
        OutSignalName => "RXDATA2(14)",
        OutTemp       => RXDATA2_out(14),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(14),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(15),
        GlitchData    => RXDATA215_GlitchData,
        OutSignalName => "RXDATA2(15)",
        OutTemp       => RXDATA2_out(15),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(15),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(16),
        GlitchData    => RXDATA216_GlitchData,
        OutSignalName => "RXDATA2(16)",
        OutTemp       => RXDATA2_out(16),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(16),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(17),
        GlitchData    => RXDATA217_GlitchData,
        OutSignalName => "RXDATA2(17)",
        OutTemp       => RXDATA2_out(17),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(17),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(18),
        GlitchData    => RXDATA218_GlitchData,
        OutSignalName => "RXDATA2(18)",
        OutTemp       => RXDATA2_out(18),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(18),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(19),
        GlitchData    => RXDATA219_GlitchData,
        OutSignalName => "RXDATA2(19)",
        OutTemp       => RXDATA2_out(19),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(19),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(2),
        GlitchData    => RXDATA22_GlitchData,
        OutSignalName => "RXDATA2(2)",
        OutTemp       => RXDATA2_out(2),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(2),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(20),
        GlitchData    => RXDATA220_GlitchData,
        OutSignalName => "RXDATA2(20)",
        OutTemp       => RXDATA2_out(20),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(20),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(21),
        GlitchData    => RXDATA221_GlitchData,
        OutSignalName => "RXDATA2(21)",
        OutTemp       => RXDATA2_out(21),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(21),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(22),
        GlitchData    => RXDATA222_GlitchData,
        OutSignalName => "RXDATA2(22)",
        OutTemp       => RXDATA2_out(22),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(22),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(23),
        GlitchData    => RXDATA223_GlitchData,
        OutSignalName => "RXDATA2(23)",
        OutTemp       => RXDATA2_out(23),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(23),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(24),
        GlitchData    => RXDATA224_GlitchData,
        OutSignalName => "RXDATA2(24)",
        OutTemp       => RXDATA2_out(24),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(24),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(25),
        GlitchData    => RXDATA225_GlitchData,
        OutSignalName => "RXDATA2(25)",
        OutTemp       => RXDATA2_out(25),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(25),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(26),
        GlitchData    => RXDATA226_GlitchData,
        OutSignalName => "RXDATA2(26)",
        OutTemp       => RXDATA2_out(26),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(26),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(27),
        GlitchData    => RXDATA227_GlitchData,
        OutSignalName => "RXDATA2(27)",
        OutTemp       => RXDATA2_out(27),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(27),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(28),
        GlitchData    => RXDATA228_GlitchData,
        OutSignalName => "RXDATA2(28)",
        OutTemp       => RXDATA2_out(28),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(28),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(29),
        GlitchData    => RXDATA229_GlitchData,
        OutSignalName => "RXDATA2(29)",
        OutTemp       => RXDATA2_out(29),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(29),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(3),
        GlitchData    => RXDATA23_GlitchData,
        OutSignalName => "RXDATA2(3)",
        OutTemp       => RXDATA2_out(3),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(3),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(30),
        GlitchData    => RXDATA230_GlitchData,
        OutSignalName => "RXDATA2(30)",
        OutTemp       => RXDATA2_out(30),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(30),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(31),
        GlitchData    => RXDATA231_GlitchData,
        OutSignalName => "RXDATA2(31)",
        OutTemp       => RXDATA2_out(31),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(31),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(32),
        GlitchData    => RXDATA232_GlitchData,
        OutSignalName => "RXDATA2(32)",
        OutTemp       => RXDATA2_out(32),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(32),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(33),
        GlitchData    => RXDATA233_GlitchData,
        OutSignalName => "RXDATA2(33)",
        OutTemp       => RXDATA2_out(33),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(33),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(34),
        GlitchData    => RXDATA234_GlitchData,
        OutSignalName => "RXDATA2(34)",
        OutTemp       => RXDATA2_out(34),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(34),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(35),
        GlitchData    => RXDATA235_GlitchData,
        OutSignalName => "RXDATA2(35)",
        OutTemp       => RXDATA2_out(35),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(35),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(36),
        GlitchData    => RXDATA236_GlitchData,
        OutSignalName => "RXDATA2(36)",
        OutTemp       => RXDATA2_out(36),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(36),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(37),
        GlitchData    => RXDATA237_GlitchData,
        OutSignalName => "RXDATA2(37)",
        OutTemp       => RXDATA2_out(37),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(37),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(38),
        GlitchData    => RXDATA238_GlitchData,
        OutSignalName => "RXDATA2(38)",
        OutTemp       => RXDATA2_out(38),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(38),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(39),
        GlitchData    => RXDATA239_GlitchData,
        OutSignalName => "RXDATA2(39)",
        OutTemp       => RXDATA2_out(39),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(39),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(4),
        GlitchData    => RXDATA24_GlitchData,
        OutSignalName => "RXDATA2(4)",
        OutTemp       => RXDATA2_out(4),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(4),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(40),
        GlitchData    => RXDATA240_GlitchData,
        OutSignalName => "RXDATA2(40)",
        OutTemp       => RXDATA2_out(40),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(40),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(41),
        GlitchData    => RXDATA241_GlitchData,
        OutSignalName => "RXDATA2(41)",
        OutTemp       => RXDATA2_out(41),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(41),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(42),
        GlitchData    => RXDATA242_GlitchData,
        OutSignalName => "RXDATA2(42)",
        OutTemp       => RXDATA2_out(42),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(42),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(43),
        GlitchData    => RXDATA243_GlitchData,
        OutSignalName => "RXDATA2(43)",
        OutTemp       => RXDATA2_out(43),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(43),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(44),
        GlitchData    => RXDATA244_GlitchData,
        OutSignalName => "RXDATA2(44)",
        OutTemp       => RXDATA2_out(44),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(44),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(45),
        GlitchData    => RXDATA245_GlitchData,
        OutSignalName => "RXDATA2(45)",
        OutTemp       => RXDATA2_out(45),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(45),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(46),
        GlitchData    => RXDATA246_GlitchData,
        OutSignalName => "RXDATA2(46)",
        OutTemp       => RXDATA2_out(46),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(46),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(47),
        GlitchData    => RXDATA247_GlitchData,
        OutSignalName => "RXDATA2(47)",
        OutTemp       => RXDATA2_out(47),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(47),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(48),
        GlitchData    => RXDATA248_GlitchData,
        OutSignalName => "RXDATA2(48)",
        OutTemp       => RXDATA2_out(48),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(48),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(49),
        GlitchData    => RXDATA249_GlitchData,
        OutSignalName => "RXDATA2(49)",
        OutTemp       => RXDATA2_out(49),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(49),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(5),
        GlitchData    => RXDATA25_GlitchData,
        OutSignalName => "RXDATA2(5)",
        OutTemp       => RXDATA2_out(5),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(5),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(50),
        GlitchData    => RXDATA250_GlitchData,
        OutSignalName => "RXDATA2(50)",
        OutTemp       => RXDATA2_out(50),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(50),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(51),
        GlitchData    => RXDATA251_GlitchData,
        OutSignalName => "RXDATA2(51)",
        OutTemp       => RXDATA2_out(51),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(51),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(52),
        GlitchData    => RXDATA252_GlitchData,
        OutSignalName => "RXDATA2(52)",
        OutTemp       => RXDATA2_out(52),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(52),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(53),
        GlitchData    => RXDATA253_GlitchData,
        OutSignalName => "RXDATA2(53)",
        OutTemp       => RXDATA2_out(53),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(53),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(54),
        GlitchData    => RXDATA254_GlitchData,
        OutSignalName => "RXDATA2(54)",
        OutTemp       => RXDATA2_out(54),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(54),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(55),
        GlitchData    => RXDATA255_GlitchData,
        OutSignalName => "RXDATA2(55)",
        OutTemp       => RXDATA2_out(55),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(55),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(56),
        GlitchData    => RXDATA256_GlitchData,
        OutSignalName => "RXDATA2(56)",
        OutTemp       => RXDATA2_out(56),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(56),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(57),
        GlitchData    => RXDATA257_GlitchData,
        OutSignalName => "RXDATA2(57)",
        OutTemp       => RXDATA2_out(57),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(57),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(58),
        GlitchData    => RXDATA258_GlitchData,
        OutSignalName => "RXDATA2(58)",
        OutTemp       => RXDATA2_out(58),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(58),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(59),
        GlitchData    => RXDATA259_GlitchData,
        OutSignalName => "RXDATA2(59)",
        OutTemp       => RXDATA2_out(59),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(59),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(6),
        GlitchData    => RXDATA26_GlitchData,
        OutSignalName => "RXDATA2(6)",
        OutTemp       => RXDATA2_out(6),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(6),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(60),
        GlitchData    => RXDATA260_GlitchData,
        OutSignalName => "RXDATA2(60)",
        OutTemp       => RXDATA2_out(60),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(60),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(61),
        GlitchData    => RXDATA261_GlitchData,
        OutSignalName => "RXDATA2(61)",
        OutTemp       => RXDATA2_out(61),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(61),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(62),
        GlitchData    => RXDATA262_GlitchData,
        OutSignalName => "RXDATA2(62)",
        OutTemp       => RXDATA2_out(62),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(62),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(63),
        GlitchData    => RXDATA263_GlitchData,
        OutSignalName => "RXDATA2(63)",
        OutTemp       => RXDATA2_out(63),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(63),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(7),
        GlitchData    => RXDATA27_GlitchData,
        OutSignalName => "RXDATA2(7)",
        OutTemp       => RXDATA2_out(7),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(7),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(8),
        GlitchData    => RXDATA28_GlitchData,
        OutSignalName => "RXDATA2(8)",
        OutTemp       => RXDATA2_out(8),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(8),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA2(9),
        GlitchData    => RXDATA29_GlitchData,
        OutSignalName => "RXDATA2(9)",
        OutTemp       => RXDATA2_out(9),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDATA2(9),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(0),
        GlitchData    => RXDATA30_GlitchData,
        OutSignalName => "RXDATA3(0)",
        OutTemp       => RXDATA3_out(0),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(0),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(1),
        GlitchData    => RXDATA31_GlitchData,
        OutSignalName => "RXDATA3(1)",
        OutTemp       => RXDATA3_out(1),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(1),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(10),
        GlitchData    => RXDATA310_GlitchData,
        OutSignalName => "RXDATA3(10)",
        OutTemp       => RXDATA3_out(10),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(10),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(11),
        GlitchData    => RXDATA311_GlitchData,
        OutSignalName => "RXDATA3(11)",
        OutTemp       => RXDATA3_out(11),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(11),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(12),
        GlitchData    => RXDATA312_GlitchData,
        OutSignalName => "RXDATA3(12)",
        OutTemp       => RXDATA3_out(12),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(12),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(13),
        GlitchData    => RXDATA313_GlitchData,
        OutSignalName => "RXDATA3(13)",
        OutTemp       => RXDATA3_out(13),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(13),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(14),
        GlitchData    => RXDATA314_GlitchData,
        OutSignalName => "RXDATA3(14)",
        OutTemp       => RXDATA3_out(14),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(14),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(15),
        GlitchData    => RXDATA315_GlitchData,
        OutSignalName => "RXDATA3(15)",
        OutTemp       => RXDATA3_out(15),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(15),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(16),
        GlitchData    => RXDATA316_GlitchData,
        OutSignalName => "RXDATA3(16)",
        OutTemp       => RXDATA3_out(16),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(16),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(17),
        GlitchData    => RXDATA317_GlitchData,
        OutSignalName => "RXDATA3(17)",
        OutTemp       => RXDATA3_out(17),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(17),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(18),
        GlitchData    => RXDATA318_GlitchData,
        OutSignalName => "RXDATA3(18)",
        OutTemp       => RXDATA3_out(18),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(18),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(19),
        GlitchData    => RXDATA319_GlitchData,
        OutSignalName => "RXDATA3(19)",
        OutTemp       => RXDATA3_out(19),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(19),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(2),
        GlitchData    => RXDATA32_GlitchData,
        OutSignalName => "RXDATA3(2)",
        OutTemp       => RXDATA3_out(2),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(2),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(20),
        GlitchData    => RXDATA320_GlitchData,
        OutSignalName => "RXDATA3(20)",
        OutTemp       => RXDATA3_out(20),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(20),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(21),
        GlitchData    => RXDATA321_GlitchData,
        OutSignalName => "RXDATA3(21)",
        OutTemp       => RXDATA3_out(21),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(21),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(22),
        GlitchData    => RXDATA322_GlitchData,
        OutSignalName => "RXDATA3(22)",
        OutTemp       => RXDATA3_out(22),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(22),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(23),
        GlitchData    => RXDATA323_GlitchData,
        OutSignalName => "RXDATA3(23)",
        OutTemp       => RXDATA3_out(23),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(23),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(24),
        GlitchData    => RXDATA324_GlitchData,
        OutSignalName => "RXDATA3(24)",
        OutTemp       => RXDATA3_out(24),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(24),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(25),
        GlitchData    => RXDATA325_GlitchData,
        OutSignalName => "RXDATA3(25)",
        OutTemp       => RXDATA3_out(25),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(25),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(26),
        GlitchData    => RXDATA326_GlitchData,
        OutSignalName => "RXDATA3(26)",
        OutTemp       => RXDATA3_out(26),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(26),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(27),
        GlitchData    => RXDATA327_GlitchData,
        OutSignalName => "RXDATA3(27)",
        OutTemp       => RXDATA3_out(27),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(27),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(28),
        GlitchData    => RXDATA328_GlitchData,
        OutSignalName => "RXDATA3(28)",
        OutTemp       => RXDATA3_out(28),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(28),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(29),
        GlitchData    => RXDATA329_GlitchData,
        OutSignalName => "RXDATA3(29)",
        OutTemp       => RXDATA3_out(29),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(29),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(3),
        GlitchData    => RXDATA33_GlitchData,
        OutSignalName => "RXDATA3(3)",
        OutTemp       => RXDATA3_out(3),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(3),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(30),
        GlitchData    => RXDATA330_GlitchData,
        OutSignalName => "RXDATA3(30)",
        OutTemp       => RXDATA3_out(30),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(30),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(31),
        GlitchData    => RXDATA331_GlitchData,
        OutSignalName => "RXDATA3(31)",
        OutTemp       => RXDATA3_out(31),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(31),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(32),
        GlitchData    => RXDATA332_GlitchData,
        OutSignalName => "RXDATA3(32)",
        OutTemp       => RXDATA3_out(32),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(32),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(33),
        GlitchData    => RXDATA333_GlitchData,
        OutSignalName => "RXDATA3(33)",
        OutTemp       => RXDATA3_out(33),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(33),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(34),
        GlitchData    => RXDATA334_GlitchData,
        OutSignalName => "RXDATA3(34)",
        OutTemp       => RXDATA3_out(34),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(34),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(35),
        GlitchData    => RXDATA335_GlitchData,
        OutSignalName => "RXDATA3(35)",
        OutTemp       => RXDATA3_out(35),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(35),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(36),
        GlitchData    => RXDATA336_GlitchData,
        OutSignalName => "RXDATA3(36)",
        OutTemp       => RXDATA3_out(36),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(36),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(37),
        GlitchData    => RXDATA337_GlitchData,
        OutSignalName => "RXDATA3(37)",
        OutTemp       => RXDATA3_out(37),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(37),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(38),
        GlitchData    => RXDATA338_GlitchData,
        OutSignalName => "RXDATA3(38)",
        OutTemp       => RXDATA3_out(38),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(38),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(39),
        GlitchData    => RXDATA339_GlitchData,
        OutSignalName => "RXDATA3(39)",
        OutTemp       => RXDATA3_out(39),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(39),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(4),
        GlitchData    => RXDATA34_GlitchData,
        OutSignalName => "RXDATA3(4)",
        OutTemp       => RXDATA3_out(4),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(4),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(40),
        GlitchData    => RXDATA340_GlitchData,
        OutSignalName => "RXDATA3(40)",
        OutTemp       => RXDATA3_out(40),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(40),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(41),
        GlitchData    => RXDATA341_GlitchData,
        OutSignalName => "RXDATA3(41)",
        OutTemp       => RXDATA3_out(41),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(41),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(42),
        GlitchData    => RXDATA342_GlitchData,
        OutSignalName => "RXDATA3(42)",
        OutTemp       => RXDATA3_out(42),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(42),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(43),
        GlitchData    => RXDATA343_GlitchData,
        OutSignalName => "RXDATA3(43)",
        OutTemp       => RXDATA3_out(43),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(43),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(44),
        GlitchData    => RXDATA344_GlitchData,
        OutSignalName => "RXDATA3(44)",
        OutTemp       => RXDATA3_out(44),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(44),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(45),
        GlitchData    => RXDATA345_GlitchData,
        OutSignalName => "RXDATA3(45)",
        OutTemp       => RXDATA3_out(45),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(45),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(46),
        GlitchData    => RXDATA346_GlitchData,
        OutSignalName => "RXDATA3(46)",
        OutTemp       => RXDATA3_out(46),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(46),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(47),
        GlitchData    => RXDATA347_GlitchData,
        OutSignalName => "RXDATA3(47)",
        OutTemp       => RXDATA3_out(47),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(47),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(48),
        GlitchData    => RXDATA348_GlitchData,
        OutSignalName => "RXDATA3(48)",
        OutTemp       => RXDATA3_out(48),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(48),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(49),
        GlitchData    => RXDATA349_GlitchData,
        OutSignalName => "RXDATA3(49)",
        OutTemp       => RXDATA3_out(49),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(49),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(5),
        GlitchData    => RXDATA35_GlitchData,
        OutSignalName => "RXDATA3(5)",
        OutTemp       => RXDATA3_out(5),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(5),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(50),
        GlitchData    => RXDATA350_GlitchData,
        OutSignalName => "RXDATA3(50)",
        OutTemp       => RXDATA3_out(50),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(50),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(51),
        GlitchData    => RXDATA351_GlitchData,
        OutSignalName => "RXDATA3(51)",
        OutTemp       => RXDATA3_out(51),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(51),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(52),
        GlitchData    => RXDATA352_GlitchData,
        OutSignalName => "RXDATA3(52)",
        OutTemp       => RXDATA3_out(52),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(52),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(53),
        GlitchData    => RXDATA353_GlitchData,
        OutSignalName => "RXDATA3(53)",
        OutTemp       => RXDATA3_out(53),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(53),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(54),
        GlitchData    => RXDATA354_GlitchData,
        OutSignalName => "RXDATA3(54)",
        OutTemp       => RXDATA3_out(54),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(54),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(55),
        GlitchData    => RXDATA355_GlitchData,
        OutSignalName => "RXDATA3(55)",
        OutTemp       => RXDATA3_out(55),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(55),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(56),
        GlitchData    => RXDATA356_GlitchData,
        OutSignalName => "RXDATA3(56)",
        OutTemp       => RXDATA3_out(56),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(56),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(57),
        GlitchData    => RXDATA357_GlitchData,
        OutSignalName => "RXDATA3(57)",
        OutTemp       => RXDATA3_out(57),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(57),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(58),
        GlitchData    => RXDATA358_GlitchData,
        OutSignalName => "RXDATA3(58)",
        OutTemp       => RXDATA3_out(58),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(58),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(59),
        GlitchData    => RXDATA359_GlitchData,
        OutSignalName => "RXDATA3(59)",
        OutTemp       => RXDATA3_out(59),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(59),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(6),
        GlitchData    => RXDATA36_GlitchData,
        OutSignalName => "RXDATA3(6)",
        OutTemp       => RXDATA3_out(6),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(6),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(60),
        GlitchData    => RXDATA360_GlitchData,
        OutSignalName => "RXDATA3(60)",
        OutTemp       => RXDATA3_out(60),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(60),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(61),
        GlitchData    => RXDATA361_GlitchData,
        OutSignalName => "RXDATA3(61)",
        OutTemp       => RXDATA3_out(61),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(61),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(62),
        GlitchData    => RXDATA362_GlitchData,
        OutSignalName => "RXDATA3(62)",
        OutTemp       => RXDATA3_out(62),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(62),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(63),
        GlitchData    => RXDATA363_GlitchData,
        OutSignalName => "RXDATA3(63)",
        OutTemp       => RXDATA3_out(63),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(63),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(7),
        GlitchData    => RXDATA37_GlitchData,
        OutSignalName => "RXDATA3(7)",
        OutTemp       => RXDATA3_out(7),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(7),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(8),
        GlitchData    => RXDATA38_GlitchData,
        OutSignalName => "RXDATA3(8)",
        OutTemp       => RXDATA3_out(8),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(8),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDATA3(9),
        GlitchData    => RXDATA39_GlitchData,
        OutSignalName => "RXDATA3(9)",
        OutTemp       => RXDATA3_out(9),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDATA3(9),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDISPERR0(0),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDISPERR0(1),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDISPERR0(2),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDISPERR0(3),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDISPERR0(4),
        GlitchData    => RXDISPERR04_GlitchData,
        OutSignalName => "RXDISPERR0(4)",
        OutTemp       => RXDISPERR0_out(4),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDISPERR0(4),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDISPERR0(5),
        GlitchData    => RXDISPERR05_GlitchData,
        OutSignalName => "RXDISPERR0(5)",
        OutTemp       => RXDISPERR0_out(5),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDISPERR0(5),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDISPERR0(6),
        GlitchData    => RXDISPERR06_GlitchData,
        OutSignalName => "RXDISPERR0(6)",
        OutTemp       => RXDISPERR0_out(6),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDISPERR0(6),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDISPERR0(7),
        GlitchData    => RXDISPERR07_GlitchData,
        OutSignalName => "RXDISPERR0(7)",
        OutTemp       => RXDISPERR0_out(7),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXDISPERR0(7),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDISPERR1(0),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDISPERR1(1),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDISPERR1(2),TRUE)),
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
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDISPERR1(3),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDISPERR1(4),
        GlitchData    => RXDISPERR14_GlitchData,
        OutSignalName => "RXDISPERR1(4)",
        OutTemp       => RXDISPERR1_out(4),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDISPERR1(4),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDISPERR1(5),
        GlitchData    => RXDISPERR15_GlitchData,
        OutSignalName => "RXDISPERR1(5)",
        OutTemp       => RXDISPERR1_out(5),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDISPERR1(5),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDISPERR1(6),
        GlitchData    => RXDISPERR16_GlitchData,
        OutSignalName => "RXDISPERR1(6)",
        OutTemp       => RXDISPERR1_out(6),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDISPERR1(6),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDISPERR1(7),
        GlitchData    => RXDISPERR17_GlitchData,
        OutSignalName => "RXDISPERR1(7)",
        OutTemp       => RXDISPERR1_out(7),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXDISPERR1(7),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDISPERR2(0),
        GlitchData    => RXDISPERR20_GlitchData,
        OutSignalName => "RXDISPERR2(0)",
        OutTemp       => RXDISPERR2_out(0),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDISPERR2(0),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDISPERR2(1),
        GlitchData    => RXDISPERR21_GlitchData,
        OutSignalName => "RXDISPERR2(1)",
        OutTemp       => RXDISPERR2_out(1),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDISPERR2(1),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDISPERR2(2),
        GlitchData    => RXDISPERR22_GlitchData,
        OutSignalName => "RXDISPERR2(2)",
        OutTemp       => RXDISPERR2_out(2),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDISPERR2(2),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDISPERR2(3),
        GlitchData    => RXDISPERR23_GlitchData,
        OutSignalName => "RXDISPERR2(3)",
        OutTemp       => RXDISPERR2_out(3),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDISPERR2(3),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDISPERR2(4),
        GlitchData    => RXDISPERR24_GlitchData,
        OutSignalName => "RXDISPERR2(4)",
        OutTemp       => RXDISPERR2_out(4),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDISPERR2(4),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDISPERR2(5),
        GlitchData    => RXDISPERR25_GlitchData,
        OutSignalName => "RXDISPERR2(5)",
        OutTemp       => RXDISPERR2_out(5),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDISPERR2(5),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDISPERR2(6),
        GlitchData    => RXDISPERR26_GlitchData,
        OutSignalName => "RXDISPERR2(6)",
        OutTemp       => RXDISPERR2_out(6),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDISPERR2(6),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDISPERR2(7),
        GlitchData    => RXDISPERR27_GlitchData,
        OutSignalName => "RXDISPERR2(7)",
        OutTemp       => RXDISPERR2_out(7),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXDISPERR2(7),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDISPERR3(0),
        GlitchData    => RXDISPERR30_GlitchData,
        OutSignalName => "RXDISPERR3(0)",
        OutTemp       => RXDISPERR3_out(0),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDISPERR3(0),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDISPERR3(1),
        GlitchData    => RXDISPERR31_GlitchData,
        OutSignalName => "RXDISPERR3(1)",
        OutTemp       => RXDISPERR3_out(1),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDISPERR3(1),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDISPERR3(2),
        GlitchData    => RXDISPERR32_GlitchData,
        OutSignalName => "RXDISPERR3(2)",
        OutTemp       => RXDISPERR3_out(2),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDISPERR3(2),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDISPERR3(3),
        GlitchData    => RXDISPERR33_GlitchData,
        OutSignalName => "RXDISPERR3(3)",
        OutTemp       => RXDISPERR3_out(3),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDISPERR3(3),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDISPERR3(4),
        GlitchData    => RXDISPERR34_GlitchData,
        OutSignalName => "RXDISPERR3(4)",
        OutTemp       => RXDISPERR3_out(4),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDISPERR3(4),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDISPERR3(5),
        GlitchData    => RXDISPERR35_GlitchData,
        OutSignalName => "RXDISPERR3(5)",
        OutTemp       => RXDISPERR3_out(5),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDISPERR3(5),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDISPERR3(6),
        GlitchData    => RXDISPERR36_GlitchData,
        OutSignalName => "RXDISPERR3(6)",
        OutTemp       => RXDISPERR3_out(6),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDISPERR3(6),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXDISPERR3(7),
        GlitchData    => RXDISPERR37_GlitchData,
        OutSignalName => "RXDISPERR3(7)",
        OutTemp       => RXDISPERR3_out(7),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXDISPERR3(7),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID0(0),
        GlitchData    => RXVALID00_GlitchData,
        OutSignalName => "RXVALID0(0)",
        OutTemp       => RXVALID0_out(0),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXVALID0(0),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID0(1),
        GlitchData    => RXVALID01_GlitchData,
        OutSignalName => "RXVALID0(1)",
        OutTemp       => RXVALID0_out(1),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXVALID0(1),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID0(2),
        GlitchData    => RXVALID02_GlitchData,
        OutSignalName => "RXVALID0(2)",
        OutTemp       => RXVALID0_out(2),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXVALID0(2),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID0(3),
        GlitchData    => RXVALID03_GlitchData,
        OutSignalName => "RXVALID0(3)",
        OutTemp       => RXVALID0_out(3),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXVALID0(3),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID0(4),
        GlitchData    => RXVALID04_GlitchData,
        OutSignalName => "RXVALID0(4)",
        OutTemp       => RXVALID0_out(4),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXVALID0(4),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID0(5),
        GlitchData    => RXVALID05_GlitchData,
        OutSignalName => "RXVALID0(5)",
        OutTemp       => RXVALID0_out(5),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXVALID0(5),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID0(6),
        GlitchData    => RXVALID06_GlitchData,
        OutSignalName => "RXVALID0(6)",
        OutTemp       => RXVALID0_out(6),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXVALID0(6),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID0(7),
        GlitchData    => RXVALID07_GlitchData,
        OutSignalName => "RXVALID0(7)",
        OutTemp       => RXVALID0_out(7),
        Paths       => (0 => (RXUSERCLKIN0_dly'last_event, tpd_RXUSERCLKIN0_RXVALID0(7),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID1(0),
        GlitchData    => RXVALID10_GlitchData,
        OutSignalName => "RXVALID1(0)",
        OutTemp       => RXVALID1_out(0),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXVALID1(0),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID1(1),
        GlitchData    => RXVALID11_GlitchData,
        OutSignalName => "RXVALID1(1)",
        OutTemp       => RXVALID1_out(1),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXVALID1(1),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID1(2),
        GlitchData    => RXVALID12_GlitchData,
        OutSignalName => "RXVALID1(2)",
        OutTemp       => RXVALID1_out(2),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXVALID1(2),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID1(3),
        GlitchData    => RXVALID13_GlitchData,
        OutSignalName => "RXVALID1(3)",
        OutTemp       => RXVALID1_out(3),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXVALID1(3),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID1(4),
        GlitchData    => RXVALID14_GlitchData,
        OutSignalName => "RXVALID1(4)",
        OutTemp       => RXVALID1_out(4),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXVALID1(4),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID1(5),
        GlitchData    => RXVALID15_GlitchData,
        OutSignalName => "RXVALID1(5)",
        OutTemp       => RXVALID1_out(5),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXVALID1(5),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID1(6),
        GlitchData    => RXVALID16_GlitchData,
        OutSignalName => "RXVALID1(6)",
        OutTemp       => RXVALID1_out(6),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXVALID1(6),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID1(7),
        GlitchData    => RXVALID17_GlitchData,
        OutSignalName => "RXVALID1(7)",
        OutTemp       => RXVALID1_out(7),
        Paths       => (0 => (RXUSERCLKIN1_dly'last_event, tpd_RXUSERCLKIN1_RXVALID1(7),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID2(0),
        GlitchData    => RXVALID20_GlitchData,
        OutSignalName => "RXVALID2(0)",
        OutTemp       => RXVALID2_out(0),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXVALID2(0),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID2(1),
        GlitchData    => RXVALID21_GlitchData,
        OutSignalName => "RXVALID2(1)",
        OutTemp       => RXVALID2_out(1),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXVALID2(1),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID2(2),
        GlitchData    => RXVALID22_GlitchData,
        OutSignalName => "RXVALID2(2)",
        OutTemp       => RXVALID2_out(2),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXVALID2(2),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID2(3),
        GlitchData    => RXVALID23_GlitchData,
        OutSignalName => "RXVALID2(3)",
        OutTemp       => RXVALID2_out(3),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXVALID2(3),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID2(4),
        GlitchData    => RXVALID24_GlitchData,
        OutSignalName => "RXVALID2(4)",
        OutTemp       => RXVALID2_out(4),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXVALID2(4),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID2(5),
        GlitchData    => RXVALID25_GlitchData,
        OutSignalName => "RXVALID2(5)",
        OutTemp       => RXVALID2_out(5),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXVALID2(5),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID2(6),
        GlitchData    => RXVALID26_GlitchData,
        OutSignalName => "RXVALID2(6)",
        OutTemp       => RXVALID2_out(6),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXVALID2(6),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID2(7),
        GlitchData    => RXVALID27_GlitchData,
        OutSignalName => "RXVALID2(7)",
        OutTemp       => RXVALID2_out(7),
        Paths       => (0 => (RXUSERCLKIN2_dly'last_event, tpd_RXUSERCLKIN2_RXVALID2(7),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID3(0),
        GlitchData    => RXVALID30_GlitchData,
        OutSignalName => "RXVALID3(0)",
        OutTemp       => RXVALID3_out(0),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXVALID3(0),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID3(1),
        GlitchData    => RXVALID31_GlitchData,
        OutSignalName => "RXVALID3(1)",
        OutTemp       => RXVALID3_out(1),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXVALID3(1),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID3(2),
        GlitchData    => RXVALID32_GlitchData,
        OutSignalName => "RXVALID3(2)",
        OutTemp       => RXVALID3_out(2),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXVALID3(2),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID3(3),
        GlitchData    => RXVALID33_GlitchData,
        OutSignalName => "RXVALID3(3)",
        OutTemp       => RXVALID3_out(3),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXVALID3(3),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID3(4),
        GlitchData    => RXVALID34_GlitchData,
        OutSignalName => "RXVALID3(4)",
        OutTemp       => RXVALID3_out(4),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXVALID3(4),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID3(5),
        GlitchData    => RXVALID35_GlitchData,
        OutSignalName => "RXVALID3(5)",
        OutTemp       => RXVALID3_out(5),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXVALID3(5),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID3(6),
        GlitchData    => RXVALID36_GlitchData,
        OutSignalName => "RXVALID3(6)",
        OutTemp       => RXVALID3_out(6),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXVALID3(6),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => RXVALID3(7),
        GlitchData    => RXVALID37_GlitchData,
        OutSignalName => "RXVALID3(7)",
        OutTemp       => RXVALID3_out(7),
        Paths       => (0 => (RXUSERCLKIN3_dly'last_event, tpd_RXUSERCLKIN3_RXVALID3(7),TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => TSTREFCLKFAB,
        GlitchData    => TSTREFCLKFAB_GlitchData,
        OutSignalName => "TSTREFCLKFAB",
        OutTemp       => TSTREFCLKFAB_out,
        Paths       => (0 => (REFCLK_dly'last_event, tpd_REFCLK_TSTREFCLKFAB,TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => TSTREFCLKOUT,
        GlitchData    => TSTREFCLKOUT_GlitchData,
        OutSignalName => "TSTREFCLKOUT",
        OutTemp       => TSTREFCLKOUT_out,
        Paths       => (0 => (REFCLK_dly'last_event, tpd_REFCLK_TSTREFCLKOUT,TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => TXCTRLACK0,
        GlitchData    => TXCTRLACK0_GlitchData,
        OutSignalName => "TXCTRLACK0",
        OutTemp       => TXCTRLACK0_out,
        Paths       => (0 => (TXUSERCLKIN0_dly'last_event, tpd_TXUSERCLKIN0_TXCTRLACK0,TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => TXCTRLACK1,
        GlitchData    => TXCTRLACK1_GlitchData,
        OutSignalName => "TXCTRLACK1",
        OutTemp       => TXCTRLACK1_out,
        Paths       => (0 => (TXUSERCLKIN1_dly'last_event, tpd_TXUSERCLKIN1_TXCTRLACK1,TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => TXCTRLACK2,
        GlitchData    => TXCTRLACK2_GlitchData,
        OutSignalName => "TXCTRLACK2",
        OutTemp       => TXCTRLACK2_out,
        Paths       => (0 => (TXUSERCLKIN2_dly'last_event, tpd_TXUSERCLKIN2_TXCTRLACK2,TRUE)),
        Mode          => VitalTransport,
        Xon           => false,
        MsgOn          => false,
        MsgSeverity    => WARNING
      );
      VitalPathDelay01
      (
        OutSignal     => TXCTRLACK3,
        GlitchData    => TXCTRLACK3_GlitchData,
        OutSignalName => "TXCTRLACK3",
        OutTemp       => TXCTRLACK3_out,
        Paths       => (0 => (TXUSERCLKIN3_dly'last_event, tpd_TXUSERCLKIN3_TXCTRLACK3,TRUE)),
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
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalPeriodPulseCheck
      (
        Violation      => Pviol_REFCLK,
        PeriodData     => PInfo_REFCLK,
        TestSignal     => REFCLK_dly,
        TestSignalName => "REFCLK",
        TestDelay      => 0 ps,
        Period         => tperiod_REFCLK_posedge,
        PulseWidthHigh => 0 ps,
        PulseWidthLow  => 0 ps,
        CheckEnabled   => TRUE,
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalPeriodPulseCheck
      (
        Violation      => Pviol_RXUSERCLKIN0,
        PeriodData     => PInfo_RXUSERCLKIN0,
        TestSignal     => RXUSERCLKIN0_dly,
        TestSignalName => "RXUSERCLKIN0",
        TestDelay      => 0 ps,
        Period         => tperiod_RXUSERCLKIN0_posedge,
        PulseWidthHigh => 0 ps,
        PulseWidthLow  => 0 ps,
        CheckEnabled   => TRUE,
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalPeriodPulseCheck
      (
        Violation      => Pviol_RXUSERCLKIN1,
        PeriodData     => PInfo_RXUSERCLKIN1,
        TestSignal     => RXUSERCLKIN1_dly,
        TestSignalName => "RXUSERCLKIN1",
        TestDelay      => 0 ps,
        Period         => tperiod_RXUSERCLKIN1_posedge,
        PulseWidthHigh => 0 ps,
        PulseWidthLow  => 0 ps,
        CheckEnabled   => TRUE,
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalPeriodPulseCheck
      (
        Violation      => Pviol_RXUSERCLKIN2,
        PeriodData     => PInfo_RXUSERCLKIN2,
        TestSignal     => RXUSERCLKIN2_dly,
        TestSignalName => "RXUSERCLKIN2",
        TestDelay      => 0 ps,
        Period         => tperiod_RXUSERCLKIN2_posedge,
        PulseWidthHigh => 0 ps,
        PulseWidthLow  => 0 ps,
        CheckEnabled   => TRUE,
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalPeriodPulseCheck
      (
        Violation      => Pviol_RXUSERCLKIN3,
        PeriodData     => PInfo_RXUSERCLKIN3,
        TestSignal     => RXUSERCLKIN3_dly,
        TestSignalName => "RXUSERCLKIN3",
        TestDelay      => 0 ps,
        Period         => tperiod_RXUSERCLKIN3_posedge,
        PulseWidthHigh => 0 ps,
        PulseWidthLow  => 0 ps,
        CheckEnabled   => TRUE,
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalPeriodPulseCheck
      (
        Violation      => Pviol_TXUSERCLKIN0,
        PeriodData     => PInfo_TXUSERCLKIN0,
        TestSignal     => TXUSERCLKIN0_dly,
        TestSignalName => "TXUSERCLKIN0",
        TestDelay      => 0 ps,
        Period         => tperiod_TXUSERCLKIN0_posedge,
        PulseWidthHigh => 0 ps,
        PulseWidthLow  => 0 ps,
        CheckEnabled   => TRUE,
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalPeriodPulseCheck
      (
        Violation      => Pviol_TXUSERCLKIN1,
        PeriodData     => PInfo_TXUSERCLKIN1,
        TestSignal     => TXUSERCLKIN1_dly,
        TestSignalName => "TXUSERCLKIN1",
        TestDelay      => 0 ps,
        Period         => tperiod_TXUSERCLKIN1_posedge,
        PulseWidthHigh => 0 ps,
        PulseWidthLow  => 0 ps,
        CheckEnabled   => TRUE,
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalPeriodPulseCheck
      (
        Violation      => Pviol_TXUSERCLKIN2,
        PeriodData     => PInfo_TXUSERCLKIN2,
        TestSignal     => TXUSERCLKIN2_dly,
        TestSignalName => "TXUSERCLKIN2",
        TestDelay      => 0 ps,
        Period         => tperiod_TXUSERCLKIN2_posedge,
        PulseWidthHigh => 0 ps,
        PulseWidthLow  => 0 ps,
        CheckEnabled   => TRUE,
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
      VitalPeriodPulseCheck
      (
        Violation      => Pviol_TXUSERCLKIN3,
        PeriodData     => PInfo_TXUSERCLKIN3,
        TestSignal     => TXUSERCLKIN3_dly,
        TestSignalName => "TXUSERCLKIN3",
        TestDelay      => 0 ps,
        Period         => tperiod_TXUSERCLKIN3_posedge,
        PulseWidthHigh => 0 ps,
        PulseWidthLow  => 0 ps,
        CheckEnabled   => TRUE,
        HeaderMsg      => InstancePath & "/X_GTHE1_QUAD",
        Xon            => Xon,
        MsgOn          => MsgOn,
        MsgSeverity    => WARNING
      );
    wait on
      DRDY_out,
      DRPDO_out,
      GTHINITDONE_out,
      MGMTPCSRDACK_out,
      MGMTPCSRDDATA_out,
      RXCODEERR0_out,
      RXCODEERR1_out,
      RXCODEERR2_out,
      RXCODEERR3_out,
      RXCTRL0_out,
      RXCTRL1_out,
      RXCTRL2_out,
      RXCTRL3_out,
      RXCTRLACK0_out,
      RXCTRLACK1_out,
      RXCTRLACK2_out,
      RXCTRLACK3_out,
      RXDATA0_out,
      RXDATA1_out,
      RXDATA2_out,
      RXDATA3_out,
      RXDATATAP0_out,
      RXDATATAP1_out,
      RXDATATAP2_out,
      RXDATATAP3_out,
      RXDISPERR0_out,
      RXDISPERR1_out,
      RXDISPERR2_out,
      RXDISPERR3_out,
      RXPCSCLKSMPL0_out,
      RXPCSCLKSMPL1_out,
      RXPCSCLKSMPL2_out,
      RXPCSCLKSMPL3_out,
      RXUSERCLKOUT0_out,
      RXUSERCLKOUT1_out,
      RXUSERCLKOUT2_out,
      RXUSERCLKOUT3_out,
      RXVALID0_out,
      RXVALID1_out,
      RXVALID2_out,
      RXVALID3_out,
      TSTPATH_out,
      TSTREFCLKFAB_out,
      TSTREFCLKOUT_out,
      TXCTRLACK0_out,
      TXCTRLACK1_out,
      TXCTRLACK2_out,
      TXCTRLACK3_out,
      TXDATATAP10_out,
      TXDATATAP11_out,
      TXDATATAP12_out,
      TXDATATAP13_out,
      TXDATATAP20_out,
      TXDATATAP21_out,
      TXDATATAP22_out,
      TXDATATAP23_out,
      TXN0_out,
      TXN1_out,
      TXN2_out,
      TXN3_out,
      TXP0_out,
      TXP1_out,
      TXP2_out,
      TXP3_out,
      TXPCSCLKSMPL0_out,
      TXPCSCLKSMPL1_out,
      TXPCSCLKSMPL2_out,
      TXPCSCLKSMPL3_out,
      TXUSERCLKOUT0_out,
      TXUSERCLKOUT1_out,
      TXUSERCLKOUT2_out,
      TXUSERCLKOUT3_out,
      DADDR_DCLK_dly,
      DEN_DCLK_dly,
      DFETRAINCTRL0_DCLK_dly,
      DFETRAINCTRL1_DCLK_dly,
      DFETRAINCTRL2_DCLK_dly,
      DFETRAINCTRL3_DCLK_dly,
      DISABLEDRP_DCLK_dly,
      DI_DCLK_dly,
      DWE_DCLK_dly,
      GTHINIT_DCLK_dly,
      MGMTPCSLANESEL_DCLK_dly,
      MGMTPCSMMDADDR_DCLK_dly,
      MGMTPCSREGADDR_DCLK_dly,
      MGMTPCSREGRD_DCLK_dly,
      MGMTPCSREGWR_DCLK_dly,
      MGMTPCSWRDATA_DCLK_dly,
      PLLPCSCLKDIV_DCLK_dly,
      RXBUFRESET0_RXUSERCLKIN0_dly,
      RXBUFRESET1_RXUSERCLKIN1_dly,
      RXBUFRESET2_RXUSERCLKIN2_dly,
      RXBUFRESET3_RXUSERCLKIN3_dly,
      RXENCOMMADET0_RXUSERCLKIN0_dly,
      RXENCOMMADET1_RXUSERCLKIN1_dly,
      RXENCOMMADET2_RXUSERCLKIN2_dly,
      RXENCOMMADET3_RXUSERCLKIN3_dly,
      RXPOLARITY0_RXUSERCLKIN0_dly,
      RXPOLARITY1_RXUSERCLKIN1_dly,
      RXPOLARITY2_RXUSERCLKIN2_dly,
      RXPOLARITY3_RXUSERCLKIN3_dly,
      RXPOWERDOWN0_TXUSERCLKIN0_dly,
      RXPOWERDOWN1_TXUSERCLKIN1_dly,
      RXPOWERDOWN2_TXUSERCLKIN2_dly,
      RXPOWERDOWN3_TXUSERCLKIN3_dly,
      RXRATE0_TXUSERCLKIN0_dly,
      RXRATE1_TXUSERCLKIN1_dly,
      RXRATE2_TXUSERCLKIN2_dly,
      RXRATE3_TXUSERCLKIN3_dly,
      SAMPLERATE0_TXUSERCLKIN0_dly,
      SAMPLERATE1_TXUSERCLKIN1_dly,
      SAMPLERATE2_TXUSERCLKIN2_dly,
      SAMPLERATE3_TXUSERCLKIN3_dly,
      TXBUFRESET0_TXUSERCLKIN0_dly,
      TXBUFRESET1_TXUSERCLKIN1_dly,
      TXBUFRESET2_TXUSERCLKIN2_dly,
      TXBUFRESET3_TXUSERCLKIN3_dly,
      TXCTRL0_TXUSERCLKIN0_dly,
      TXCTRL1_TXUSERCLKIN1_dly,
      TXCTRL2_TXUSERCLKIN2_dly,
      TXCTRL3_TXUSERCLKIN3_dly,
      TXDATA0_TXUSERCLKIN0_dly,
      TXDATA1_TXUSERCLKIN1_dly,
      TXDATA2_TXUSERCLKIN2_dly,
      TXDATA3_TXUSERCLKIN3_dly,
      TXDATAMSB0_TXUSERCLKIN0_dly,
      TXDATAMSB1_TXUSERCLKIN1_dly,
      TXDATAMSB2_TXUSERCLKIN2_dly,
      TXDATAMSB3_TXUSERCLKIN3_dly,
      TXDEEMPH0_TXUSERCLKIN0_dly,
      TXDEEMPH1_TXUSERCLKIN1_dly,
      TXDEEMPH2_TXUSERCLKIN2_dly,
      TXDEEMPH3_TXUSERCLKIN3_dly,
      TXMARGIN0_TXUSERCLKIN0_dly,
      TXMARGIN1_TXUSERCLKIN1_dly,
      TXMARGIN2_TXUSERCLKIN2_dly,
      TXMARGIN3_TXUSERCLKIN3_dly,
      TXPOWERDOWN0_TXUSERCLKIN0_dly,
      TXPOWERDOWN1_TXUSERCLKIN1_dly,
      TXPOWERDOWN2_TXUSERCLKIN2_dly,
      TXPOWERDOWN3_TXUSERCLKIN3_dly,
      TXRATE0_TXUSERCLKIN0_dly,
      TXRATE1_TXUSERCLKIN1_dly,
      TXRATE2_TXUSERCLKIN2_dly,
      TXRATE3_TXUSERCLKIN3_dly;
  end process TIMING;
    RXDATATAP0 <= RXDATATAP0_out;
    RXDATATAP1 <= RXDATATAP1_out;
    RXDATATAP2 <= RXDATATAP2_out;
    RXDATATAP3 <= RXDATATAP3_out;
    RXPCSCLKSMPL0 <= RXPCSCLKSMPL0_out;
    RXPCSCLKSMPL1 <= RXPCSCLKSMPL1_out;
    RXPCSCLKSMPL2 <= RXPCSCLKSMPL2_out;
    RXPCSCLKSMPL3 <= RXPCSCLKSMPL3_out;
    RXUSERCLKOUT0 <= RXUSERCLKOUT0_out;
    RXUSERCLKOUT1 <= RXUSERCLKOUT1_out;
    RXUSERCLKOUT2 <= RXUSERCLKOUT2_out;
    RXUSERCLKOUT3 <= RXUSERCLKOUT3_out;
    TSTPATH <= TSTPATH_out;
    TXDATATAP10 <= TXDATATAP10_out;
    TXDATATAP11 <= TXDATATAP11_out;
    TXDATATAP12 <= TXDATATAP12_out;
    TXDATATAP13 <= TXDATATAP13_out;
    TXDATATAP20 <= TXDATATAP20_out;
    TXDATATAP21 <= TXDATATAP21_out;
    TXDATATAP22 <= TXDATATAP22_out;
    TXDATATAP23 <= TXDATATAP23_out;
    TXN0 <= TXN0_out;
    TXN1 <= TXN1_out;
    TXN2 <= TXN2_out;
    TXN3 <= TXN3_out;
    TXP0 <= TXP0_out;
    TXP1 <= TXP1_out;
    TXP2 <= TXP2_out;
    TXP3 <= TXP3_out;
    TXPCSCLKSMPL0 <= TXPCSCLKSMPL0_out;
    TXPCSCLKSMPL1 <= TXPCSCLKSMPL1_out;
    TXPCSCLKSMPL2 <= TXPCSCLKSMPL2_out;
    TXPCSCLKSMPL3 <= TXPCSCLKSMPL3_out;
    TXUSERCLKOUT0 <= TXUSERCLKOUT0_out;
    TXUSERCLKOUT1 <= TXUSERCLKOUT1_out;
    TXUSERCLKOUT2 <= TXUSERCLKOUT2_out;
    TXUSERCLKOUT3 <= TXUSERCLKOUT3_out;
end X_GTHE1_QUAD_V;

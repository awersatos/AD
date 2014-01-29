-- $Header: /devl/xcs/repo/env/Databases/CAEInterfaces/vhdsclibs/data/simprims/stan/SMODEL/X_PCIE_A1.vhd,v 1.10.22.1 2010/04/01 22:44:10 robh Exp $
-------------------------------------------------------
--  Copyright (c) 2008 Xilinx Inc.
--  All Right Reserved.
-------------------------------------------------------
--
--   ____  ____
--  /   /\/   / 
-- /___/  \  /     Vendor      : Xilinx 
-- \   \   \/      Version : 11.1
--  \   \          Description : PCI Express Secure IP Timing Wrapper
--  /   /                      
-- /___/   /\      Filename    : X_PCIE_A1.vhd
-- \   \  /  \      
--  \__ \/\__ \                   
--                                 
-- Revision:
--       1.0:  08/21/08 - Initial version.
--       1.1:  11/24/08 - Updates to include secureip
--       1.2:  12/01/08 - parameter conversion width mismatch
--       1.3:  02/03/10:  525925 add skew and period checks.
--       1.4:  03/29/10:  555708 remove skew checks.

-- End Revision
-------------------------------------------------------

----- CELL X_PCIE_A1 -----

library IEEE;
use IEEE.numeric_std.all;
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

  entity X_PCIE_A1 is
    generic (
      BAR0 : bit_vector := X"00000000";
      BAR1 : bit_vector := X"00000000";
      BAR2 : bit_vector := X"00000000";
      BAR3 : bit_vector := X"00000000";
      BAR4 : bit_vector := X"00000000";
      BAR5 : bit_vector := X"00000000";
      CARDBUS_CIS_POINTER : bit_vector := X"00000000";
      CLASS_CODE : bit_vector := X"000000";
      DEV_CAP_ENDPOINT_L0S_LATENCY : integer := 7;
      DEV_CAP_ENDPOINT_L1_LATENCY : integer := 7;
      DEV_CAP_EXT_TAG_SUPPORTED : boolean := FALSE;
      DEV_CAP_MAX_PAYLOAD_SUPPORTED : integer := 2;
      DEV_CAP_PHANTOM_FUNCTIONS_SUPPORT : integer := 0;
      DEV_CAP_ROLE_BASED_ERROR : boolean := TRUE;
      DISABLE_BAR_FILTERING : boolean := FALSE;
      DISABLE_ID_CHECK : boolean := FALSE;
      DISABLE_SCRAMBLING : boolean := FALSE;
      ENABLE_RX_TD_ECRC_TRIM : boolean := FALSE;
      EXPANSION_ROM : bit_vector := X"000000";
      FAST_TRAIN : boolean := FALSE;
      GTP_SEL : integer := 0;
      LINK_CAP_ASPM_SUPPORT : integer := 1;
      LINK_CAP_L0S_EXIT_LATENCY : integer := 7;
      LINK_CAP_L1_EXIT_LATENCY : integer := 7;
      LINK_STATUS_SLOT_CLOCK_CONFIG : boolean := FALSE;
      LL_ACK_TIMEOUT : bit_vector := X"0204";
      LL_ACK_TIMEOUT_EN : boolean := FALSE;
      LL_REPLAY_TIMEOUT : bit_vector := X"060D";
      LL_REPLAY_TIMEOUT_EN : boolean := FALSE;
      MSI_CAP_MULTIMSGCAP : integer := 0;
      MSI_CAP_MULTIMSG_EXTENSION : integer := 0;
      PCIE_CAP_CAPABILITY_VERSION : bit_vector := X"1";
      PCIE_CAP_DEVICE_PORT_TYPE : bit_vector := X"0";
      PCIE_CAP_INT_MSG_NUM : bit_vector := "00000";
      PCIE_CAP_SLOT_IMPLEMENTED : boolean := FALSE;
      PCIE_GENERIC : bit_vector := X"000";
      PLM_AUTO_CONFIG : boolean := FALSE;
      PM_CAP_AUXCURRENT : integer := 0;
      PM_CAP_D1SUPPORT : boolean := TRUE;
      PM_CAP_D2SUPPORT : boolean := TRUE;
      PM_CAP_DSI : boolean := FALSE;
      PM_CAP_PMESUPPORT : bit_vector := "01111";
      PM_CAP_PME_CLOCK : boolean := FALSE;
      PM_CAP_VERSION : integer := 3;
      PM_DATA0 : bit_vector := X"1E";
      PM_DATA1 : bit_vector := X"1E";
      PM_DATA2 : bit_vector := X"1E";
      PM_DATA3 : bit_vector := X"1E";
      PM_DATA4 : bit_vector := X"1E";
      PM_DATA5 : bit_vector := X"1E";
      PM_DATA6 : bit_vector := X"1E";
      PM_DATA7 : bit_vector := X"1E";
      PM_DATA_SCALE0 : bit_vector := "01";
      PM_DATA_SCALE1 : bit_vector := "01";
      PM_DATA_SCALE2 : bit_vector := "01";
      PM_DATA_SCALE3 : bit_vector := "01";
      PM_DATA_SCALE4 : bit_vector := "01";
      PM_DATA_SCALE5 : bit_vector := "01";
      PM_DATA_SCALE6 : bit_vector := "01";
      PM_DATA_SCALE7 : bit_vector := "01";
      SIM_VERSION : string := "1.0";
      SLOT_CAP_ATT_BUTTON_PRESENT : boolean := FALSE;
      SLOT_CAP_ATT_INDICATOR_PRESENT : boolean := FALSE;
      SLOT_CAP_POWER_INDICATOR_PRESENT : boolean := FALSE;
      TL_RX_RAM_RADDR_LATENCY : integer := 1;
      TL_RX_RAM_RDATA_LATENCY : integer := 2;
      TL_RX_RAM_WRITE_LATENCY : integer := 0;
      TL_TFC_DISABLE : boolean := FALSE;
      TL_TX_CHECKS_DISABLE : boolean := FALSE;
      TL_TX_RAM_RADDR_LATENCY : integer := 0;
      TL_TX_RAM_RDATA_LATENCY : integer := 2;
      USR_CFG : boolean := FALSE;
      USR_EXT_CFG : boolean := FALSE;
      VC0_CPL_INFINITE : boolean := TRUE;
      VC0_RX_RAM_LIMIT : bit_vector := X"01E";
      VC0_TOTAL_CREDITS_CD : integer := 104;
      VC0_TOTAL_CREDITS_CH : integer := 36;
      VC0_TOTAL_CREDITS_NPH : integer := 8;
      VC0_TOTAL_CREDITS_PD : integer := 288;
      VC0_TOTAL_CREDITS_PH : integer := 32;
      VC0_TX_LASTPACKET : integer := 31;
      TimingChecksOn : boolean := TRUE;
      InstancePath   : string  := "*";
      Xon            : boolean := TRUE;
      MsgOn          : boolean := FALSE;
      LOC            : string  := "UNPLACED";
-- VITAL input Pin path delay variables
      tipd_CFGDEVID : VitalDelayArrayType01 (15 downto 0) := (others => (0 ps, 0 ps));
      tipd_CFGDSN : VitalDelayArrayType01 (63 downto 0) := (others => (0 ps, 0 ps));
      tipd_CFGDWADDR : VitalDelayArrayType01 (9 downto 0) := (others => (0 ps, 0 ps));
      tipd_CFGERRCORN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_CFGERRCPLABORTN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_CFGERRCPLTIMEOUTN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_CFGERRECRCN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_CFGERRLOCKEDN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_CFGERRPOSTEDN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_CFGERRTLPCPLHEADER : VitalDelayArrayType01 (47 downto 0) := (others => (0 ps, 0 ps));
      tipd_CFGERRURN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_CFGINTERRUPTASSERTN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_CFGINTERRUPTDI : VitalDelayArrayType01 (7 downto 0) := (others => (0 ps, 0 ps));
      tipd_CFGINTERRUPTN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_CFGPMWAKEN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_CFGRDENN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_CFGREVID : VitalDelayArrayType01 (7 downto 0) := (others => (0 ps, 0 ps));
      tipd_CFGSUBSYSID : VitalDelayArrayType01 (15 downto 0) := (others => (0 ps, 0 ps));
      tipd_CFGSUBSYSVENID : VitalDelayArrayType01 (15 downto 0) := (others => (0 ps, 0 ps));
      tipd_CFGTRNPENDINGN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_CFGTURNOFFOKN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_CFGVENID : VitalDelayArrayType01 (15 downto 0) := (others => (0 ps, 0 ps));
      tipd_CLOCKLOCKED : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_MGTCLK : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_MIMRXRDATA : VitalDelayArrayType01 (34 downto 0) := (others => (0 ps, 0 ps));
      tipd_MIMTXRDATA : VitalDelayArrayType01 (35 downto 0) := (others => (0 ps, 0 ps));
      tipd_PIPEGTRESETDONEA : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PIPEGTRESETDONEB : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PIPEPHYSTATUSA : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PIPEPHYSTATUSB : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PIPERXCHARISKA : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_PIPERXCHARISKB : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_PIPERXDATAA : VitalDelayArrayType01 (15 downto 0) := (others => (0 ps, 0 ps));
      tipd_PIPERXDATAB : VitalDelayArrayType01 (15 downto 0) := (others => (0 ps, 0 ps));
      tipd_PIPERXENTERELECIDLEA : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PIPERXENTERELECIDLEB : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PIPERXSTATUSA : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_PIPERXSTATUSB : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_SYSRESETN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TRNFCSEL : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_TRNRDSTRDYN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TRNRNPOKN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TRNTCFGGNTN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TRNTD : VitalDelayArrayType01 (31 downto 0) := (others => (0 ps, 0 ps));
      tipd_TRNTEOFN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TRNTERRFWDN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TRNTSOFN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TRNTSRCDSCN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TRNTSRCRDYN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_TRNTSTRN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_USERCLK : VitalDelayType01 :=  (0 ps, 0 ps);
-- VITAL clk-to-output path delay variables
      tpd_MGTCLK_CFGLTSSMSTATE : VitalDelayArrayType01(4 downto 0) := (others => (0 ps, 0 ps));
      tpd_MGTCLK_PIPEGTPOWERDOWNA : VitalDelayArrayType01(1 downto 0) := (others => (0 ps, 0 ps));
      tpd_MGTCLK_PIPEGTPOWERDOWNB : VitalDelayArrayType01(1 downto 0) := (others => (0 ps, 0 ps));
      tpd_MGTCLK_PIPEGTTXELECIDLEA : VitalDelayType01 := (0 ps, 0 ps);
      tpd_MGTCLK_PIPEGTTXELECIDLEB : VitalDelayType01 := (0 ps, 0 ps);
      tpd_MGTCLK_PIPERXPOLARITYA : VitalDelayType01 := (0 ps, 0 ps);
      tpd_MGTCLK_PIPERXPOLARITYB : VitalDelayType01 := (0 ps, 0 ps);
      tpd_MGTCLK_PIPERXRESETA : VitalDelayType01 := (0 ps, 0 ps);
      tpd_MGTCLK_PIPERXRESETB : VitalDelayType01 := (0 ps, 0 ps);
      tpd_MGTCLK_PIPETXCHARDISPMODEA : VitalDelayArrayType01(1 downto 0) := (others => (0 ps, 0 ps));
      tpd_MGTCLK_PIPETXCHARDISPMODEB : VitalDelayArrayType01(1 downto 0) := (others => (0 ps, 0 ps));
      tpd_MGTCLK_PIPETXCHARDISPVALA : VitalDelayArrayType01(1 downto 0) := (others => (0 ps, 0 ps));
      tpd_MGTCLK_PIPETXCHARDISPVALB : VitalDelayArrayType01(1 downto 0) := (others => (0 ps, 0 ps));
      tpd_MGTCLK_PIPETXCHARISKA : VitalDelayArrayType01(1 downto 0) := (others => (0 ps, 0 ps));
      tpd_MGTCLK_PIPETXCHARISKB : VitalDelayArrayType01(1 downto 0) := (others => (0 ps, 0 ps));
      tpd_MGTCLK_PIPETXDATAA : VitalDelayArrayType01(15 downto 0) := (others => (0 ps, 0 ps));
      tpd_MGTCLK_PIPETXDATAB : VitalDelayArrayType01(15 downto 0) := (others => (0 ps, 0 ps));
      tpd_MGTCLK_PIPETXRCVRDETA : VitalDelayType01 := (0 ps, 0 ps);
      tpd_MGTCLK_PIPETXRCVRDETB : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_CFGBUSNUMBER : VitalDelayArrayType01(7 downto 0) := (others => (0 ps, 0 ps));
      tpd_USERCLK_CFGCOMMANDBUSMASTERENABLE : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_CFGCOMMANDINTERRUPTDISABLE : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_CFGCOMMANDIOENABLE : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_CFGCOMMANDMEMENABLE : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_CFGCOMMANDSERREN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_CFGDEVCONTROLAUXPOWEREN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_CFGDEVCONTROLCORRERRREPORTINGEN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_CFGDEVCONTROLENABLERO : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_CFGDEVCONTROLEXTTAGEN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_CFGDEVCONTROLFATALERRREPORTINGEN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_CFGDEVCONTROLMAXPAYLOAD : VitalDelayArrayType01(2 downto 0) := (others => (0 ps, 0 ps));
      tpd_USERCLK_CFGDEVCONTROLMAXREADREQ : VitalDelayArrayType01(2 downto 0) := (others => (0 ps, 0 ps));
      tpd_USERCLK_CFGDEVCONTROLNONFATALREPORTINGEN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_CFGDEVCONTROLNOSNOOPEN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_CFGDEVCONTROLPHANTOMEN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_CFGDEVCONTROLURERRREPORTINGEN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_CFGDEVICENUMBER : VitalDelayArrayType01(4 downto 0) := (others => (0 ps, 0 ps));
      tpd_USERCLK_CFGDEVSTATUSCORRERRDETECTED : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_CFGDEVSTATUSFATALERRDETECTED : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_CFGDEVSTATUSNONFATALERRDETECTED : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_CFGDEVSTATUSURDETECTED : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_CFGDO : VitalDelayArrayType01(31 downto 0) := (others => (0 ps, 0 ps));
      tpd_USERCLK_CFGERRCPLRDYN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_CFGFUNCTIONNUMBER : VitalDelayArrayType01(2 downto 0) := (others => (0 ps, 0 ps));
      tpd_USERCLK_CFGINTERRUPTDO : VitalDelayArrayType01(7 downto 0) := (others => (0 ps, 0 ps));
      tpd_USERCLK_CFGINTERRUPTMMENABLE : VitalDelayArrayType01(2 downto 0) := (others => (0 ps, 0 ps));
      tpd_USERCLK_CFGINTERRUPTMSIENABLE : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_CFGINTERRUPTRDYN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_CFGLINKCONTOLRCB : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_CFGLINKCONTROLASPMCONTROL : VitalDelayArrayType01(1 downto 0) := (others => (0 ps, 0 ps));
      tpd_USERCLK_CFGLINKCONTROLCOMMONCLOCK : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_CFGLINKCONTROLEXTENDEDSYNC : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_CFGPCIELINKSTATEN : VitalDelayArrayType01(2 downto 0) := (others => (0 ps, 0 ps));
      tpd_USERCLK_CFGRDWRDONEN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_CFGTOTURNOFFN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_DBGBADDLLPSTATUS : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_DBGBADTLPLCRC : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_DBGBADTLPSEQNUM : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_DBGBADTLPSTATUS : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_DBGDLPROTOCOLSTATUS : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_DBGFCPROTOCOLERRSTATUS : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_DBGMLFRMDLENGTH : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_DBGMLFRMDMPS : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_DBGMLFRMDTCVC : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_DBGMLFRMDTLPSTATUS : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_DBGMLFRMDUNRECTYPE : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_DBGPOISTLPSTATUS : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_DBGRCVROVERFLOWSTATUS : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_DBGREGDETECTEDCORRECTABLE : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_DBGREGDETECTEDFATAL : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_DBGREGDETECTEDNONFATAL : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_DBGREGDETECTEDUNSUPPORTED : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_DBGRPLYROLLOVERSTATUS : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_DBGRPLYTIMEOUTSTATUS : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_DBGURNOBARHIT : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_DBGURPOISCFGWR : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_DBGURSTATUS : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_DBGURUNSUPMSG : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_MIMRXRADDR : VitalDelayArrayType01(11 downto 0) := (others => (0 ps, 0 ps));
      tpd_USERCLK_MIMRXREN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_MIMRXWADDR : VitalDelayArrayType01(11 downto 0) := (others => (0 ps, 0 ps));
      tpd_USERCLK_MIMRXWDATA : VitalDelayArrayType01(34 downto 0) := (others => (0 ps, 0 ps));
      tpd_USERCLK_MIMRXWEN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_MIMTXRADDR : VitalDelayArrayType01(11 downto 0) := (others => (0 ps, 0 ps));
      tpd_USERCLK_MIMTXREN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_MIMTXWADDR : VitalDelayArrayType01(11 downto 0) := (others => (0 ps, 0 ps));
      tpd_USERCLK_MIMTXWDATA : VitalDelayArrayType01(35 downto 0) := (others => (0 ps, 0 ps));
      tpd_USERCLK_MIMTXWEN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_RECEIVEDHOTRESET : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_TRNFCCPLD : VitalDelayArrayType01(11 downto 0) := (others => (0 ps, 0 ps));
      tpd_USERCLK_TRNFCCPLH : VitalDelayArrayType01(7 downto 0) := (others => (0 ps, 0 ps));
      tpd_USERCLK_TRNFCNPD : VitalDelayArrayType01(11 downto 0) := (others => (0 ps, 0 ps));
      tpd_USERCLK_TRNFCNPH : VitalDelayArrayType01(7 downto 0) := (others => (0 ps, 0 ps));
      tpd_USERCLK_TRNFCPD : VitalDelayArrayType01(11 downto 0) := (others => (0 ps, 0 ps));
      tpd_USERCLK_TRNFCPH : VitalDelayArrayType01(7 downto 0) := (others => (0 ps, 0 ps));
      tpd_USERCLK_TRNLNKUPN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_TRNRBARHITN : VitalDelayArrayType01(6 downto 0) := (others => (0 ps, 0 ps));
      tpd_USERCLK_TRNRD : VitalDelayArrayType01(31 downto 0) := (others => (0 ps, 0 ps));
      tpd_USERCLK_TRNREOFN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_TRNRERRFWDN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_TRNRSOFN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_TRNRSRCDSCN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_TRNRSRCRDYN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_TRNTBUFAV : VitalDelayArrayType01(5 downto 0) := (others => (0 ps, 0 ps));
      tpd_USERCLK_TRNTCFGREQN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_TRNTDSTRDYN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_TRNTERRDROPN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_USERCLK_USERRSTN : VitalDelayType01 := (0 ps, 0 ps);
-- VITAL Hold delay variables
      thold_CFGDEVID_USERCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_CFGDEVID_USERCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_CFGDSN_USERCLK_negedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0 ps);
      thold_CFGDSN_USERCLK_posedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0 ps);
      thold_CFGDWADDR_USERCLK_negedge_posedge : VitalDelayArrayType(9 downto 0) := (others => 0 ps);
      thold_CFGDWADDR_USERCLK_posedge_posedge : VitalDelayArrayType(9 downto 0) := (others => 0 ps);
      thold_CFGERRCORN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_CFGERRCORN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_CFGERRCPLABORTN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_CFGERRCPLABORTN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_CFGERRCPLTIMEOUTN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_CFGERRCPLTIMEOUTN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_CFGERRECRCN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_CFGERRECRCN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_CFGERRLOCKEDN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_CFGERRLOCKEDN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_CFGERRPOSTEDN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_CFGERRPOSTEDN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge : VitalDelayArrayType(47 downto 0) := (others => 0 ps);
      thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge : VitalDelayArrayType(47 downto 0) := (others => 0 ps);
      thold_CFGERRURN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_CFGERRURN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_CFGINTERRUPTASSERTN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_CFGINTERRUPTASSERTN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_CFGINTERRUPTDI_USERCLK_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_CFGINTERRUPTDI_USERCLK_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_CFGINTERRUPTN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_CFGINTERRUPTN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_CFGPMWAKEN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_CFGPMWAKEN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_CFGRDENN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_CFGRDENN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_CFGREVID_USERCLK_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_CFGREVID_USERCLK_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_CFGSUBSYSID_USERCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_CFGSUBSYSID_USERCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_CFGSUBSYSVENID_USERCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_CFGSUBSYSVENID_USERCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_CFGTRNPENDINGN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_CFGTRNPENDINGN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_CFGTURNOFFOKN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_CFGTURNOFFOKN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_CFGVENID_USERCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_CFGVENID_USERCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_MIMRXRDATA_USERCLK_negedge_posedge : VitalDelayArrayType(34 downto 0) := (others => 0 ps);
      thold_MIMRXRDATA_USERCLK_posedge_posedge : VitalDelayArrayType(34 downto 0) := (others => 0 ps);
      thold_MIMTXRDATA_USERCLK_negedge_posedge : VitalDelayArrayType(35 downto 0) := (others => 0 ps);
      thold_MIMTXRDATA_USERCLK_posedge_posedge : VitalDelayArrayType(35 downto 0) := (others => 0 ps);
      thold_PIPEGTRESETDONEA_MGTCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_PIPEGTRESETDONEA_MGTCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_PIPEGTRESETDONEB_MGTCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_PIPEGTRESETDONEB_MGTCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_PIPEPHYSTATUSA_MGTCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_PIPEPHYSTATUSA_MGTCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_PIPEPHYSTATUSB_MGTCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_PIPEPHYSTATUSB_MGTCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_PIPERXCHARISKA_MGTCLK_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_PIPERXCHARISKA_MGTCLK_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_PIPERXCHARISKB_MGTCLK_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_PIPERXCHARISKB_MGTCLK_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_PIPERXDATAA_MGTCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_PIPERXDATAA_MGTCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_PIPERXDATAB_MGTCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_PIPERXDATAB_MGTCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_PIPERXENTERELECIDLEA_MGTCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_PIPERXENTERELECIDLEA_MGTCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_PIPERXENTERELECIDLEB_MGTCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_PIPERXENTERELECIDLEB_MGTCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_PIPERXSTATUSA_MGTCLK_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_PIPERXSTATUSA_MGTCLK_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_PIPERXSTATUSB_MGTCLK_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_PIPERXSTATUSB_MGTCLK_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_TRNFCSEL_USERCLK_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_TRNFCSEL_USERCLK_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_TRNRDSTRDYN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_TRNRDSTRDYN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_TRNRNPOKN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_TRNRNPOKN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_TRNTCFGGNTN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_TRNTCFGGNTN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_TRNTD_USERCLK_negedge_posedge : VitalDelayArrayType(31 downto 0) := (others => 0 ps);
      thold_TRNTD_USERCLK_posedge_posedge : VitalDelayArrayType(31 downto 0) := (others => 0 ps);
      thold_TRNTEOFN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_TRNTEOFN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_TRNTERRFWDN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_TRNTERRFWDN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_TRNTSOFN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_TRNTSOFN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_TRNTSRCDSCN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_TRNTSRCDSCN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_TRNTSRCRDYN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_TRNTSRCRDYN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_TRNTSTRN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_TRNTSTRN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
-- VITAL Setup delay variables
      tsetup_CFGDEVID_USERCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_CFGDEVID_USERCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_CFGDSN_USERCLK_negedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0 ps);
      tsetup_CFGDSN_USERCLK_posedge_posedge : VitalDelayArrayType(63 downto 0) := (others => 0 ps);
      tsetup_CFGDWADDR_USERCLK_negedge_posedge : VitalDelayArrayType(9 downto 0) := (others => 0 ps);
      tsetup_CFGDWADDR_USERCLK_posedge_posedge : VitalDelayArrayType(9 downto 0) := (others => 0 ps);
      tsetup_CFGERRCORN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_CFGERRCORN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_CFGERRCPLABORTN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_CFGERRCPLABORTN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_CFGERRCPLTIMEOUTN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_CFGERRCPLTIMEOUTN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_CFGERRECRCN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_CFGERRECRCN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_CFGERRLOCKEDN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_CFGERRLOCKEDN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_CFGERRPOSTEDN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_CFGERRPOSTEDN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge : VitalDelayArrayType(47 downto 0) := (others => 0 ps);
      tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge : VitalDelayArrayType(47 downto 0) := (others => 0 ps);
      tsetup_CFGERRURN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_CFGERRURN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_CFGINTERRUPTASSERTN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_CFGINTERRUPTASSERTN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_CFGINTERRUPTDI_USERCLK_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_CFGINTERRUPTDI_USERCLK_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_CFGINTERRUPTN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_CFGINTERRUPTN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_CFGPMWAKEN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_CFGPMWAKEN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_CFGRDENN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_CFGRDENN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_CFGREVID_USERCLK_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_CFGREVID_USERCLK_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_CFGSUBSYSID_USERCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_CFGSUBSYSID_USERCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_CFGSUBSYSVENID_USERCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_CFGSUBSYSVENID_USERCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_CFGTRNPENDINGN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_CFGTRNPENDINGN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_CFGTURNOFFOKN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_CFGTURNOFFOKN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_CFGVENID_USERCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_CFGVENID_USERCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_MIMRXRDATA_USERCLK_negedge_posedge : VitalDelayArrayType(34 downto 0) := (others => 0 ps);
      tsetup_MIMRXRDATA_USERCLK_posedge_posedge : VitalDelayArrayType(34 downto 0) := (others => 0 ps);
      tsetup_MIMTXRDATA_USERCLK_negedge_posedge : VitalDelayArrayType(35 downto 0) := (others => 0 ps);
      tsetup_MIMTXRDATA_USERCLK_posedge_posedge : VitalDelayArrayType(35 downto 0) := (others => 0 ps);
      tsetup_PIPEGTRESETDONEA_MGTCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PIPEGTRESETDONEA_MGTCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PIPEGTRESETDONEB_MGTCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PIPEGTRESETDONEB_MGTCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PIPEPHYSTATUSA_MGTCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PIPEPHYSTATUSA_MGTCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PIPEPHYSTATUSB_MGTCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PIPEPHYSTATUSB_MGTCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PIPERXCHARISKA_MGTCLK_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_PIPERXCHARISKA_MGTCLK_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_PIPERXCHARISKB_MGTCLK_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_PIPERXCHARISKB_MGTCLK_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_PIPERXDATAA_MGTCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_PIPERXDATAA_MGTCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_PIPERXDATAB_MGTCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_PIPERXDATAB_MGTCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_PIPERXENTERELECIDLEA_MGTCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PIPERXENTERELECIDLEA_MGTCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PIPERXENTERELECIDLEB_MGTCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PIPERXENTERELECIDLEB_MGTCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PIPERXSTATUSA_MGTCLK_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_PIPERXSTATUSA_MGTCLK_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_PIPERXSTATUSB_MGTCLK_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_PIPERXSTATUSB_MGTCLK_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_TRNFCSEL_USERCLK_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_TRNFCSEL_USERCLK_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_TRNRDSTRDYN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TRNRDSTRDYN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_TRNRNPOKN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TRNRNPOKN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_TRNTCFGGNTN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TRNTCFGGNTN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_TRNTD_USERCLK_negedge_posedge : VitalDelayArrayType(31 downto 0) := (others => 0 ps);
      tsetup_TRNTD_USERCLK_posedge_posedge : VitalDelayArrayType(31 downto 0) := (others => 0 ps);
      tsetup_TRNTEOFN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TRNTEOFN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_TRNTERRFWDN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TRNTERRFWDN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_TRNTSOFN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TRNTSOFN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_TRNTSRCDSCN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TRNTSRCDSCN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_TRNTSRCRDYN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TRNTSRCRDYN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_TRNTSTRN_USERCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_TRNTSTRN_USERCLK_posedge_posedge : VitalDelayType := 0 ps;
-- VITAL tisd variables
      tisd_CFGDEVID_USERCLK : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tisd_CFGDSN_USERCLK : VitalDelayArrayType(63 downto 0) := (others => 0 ps);
      tisd_CFGDWADDR_USERCLK : VitalDelayArrayType(9 downto 0) := (others => 0 ps);
      tisd_CFGERRCORN_USERCLK : VitalDelayType := 0 ps;
      tisd_CFGERRCPLABORTN_USERCLK : VitalDelayType := 0 ps;
      tisd_CFGERRCPLTIMEOUTN_USERCLK : VitalDelayType := 0 ps;
      tisd_CFGERRECRCN_USERCLK : VitalDelayType := 0 ps;
      tisd_CFGERRLOCKEDN_USERCLK : VitalDelayType := 0 ps;
      tisd_CFGERRPOSTEDN_USERCLK : VitalDelayType := 0 ps;
      tisd_CFGERRTLPCPLHEADER_USERCLK : VitalDelayArrayType(47 downto 0) := (others => 0 ps);
      tisd_CFGERRURN_USERCLK : VitalDelayType := 0 ps;
      tisd_CFGINTERRUPTASSERTN_USERCLK : VitalDelayType := 0 ps;
      tisd_CFGINTERRUPTDI_USERCLK : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tisd_CFGINTERRUPTN_USERCLK : VitalDelayType := 0 ps;
      tisd_CFGPMWAKEN_USERCLK : VitalDelayType := 0 ps;
      tisd_CFGRDENN_USERCLK : VitalDelayType := 0 ps;
      tisd_CFGREVID_USERCLK : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tisd_CFGSUBSYSID_USERCLK : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tisd_CFGSUBSYSVENID_USERCLK : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tisd_CFGTRNPENDINGN_USERCLK : VitalDelayType := 0 ps;
      tisd_CFGTURNOFFOKN_USERCLK : VitalDelayType := 0 ps;
      tisd_CFGVENID_USERCLK : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tisd_MIMRXRDATA_USERCLK : VitalDelayArrayType(34 downto 0) := (others => 0 ps);
      tisd_MIMTXRDATA_USERCLK : VitalDelayArrayType(35 downto 0) := (others => 0 ps);
      tisd_PIPEGTRESETDONEA_MGTCLK : VitalDelayType := 0 ps;
      tisd_PIPEGTRESETDONEB_MGTCLK : VitalDelayType := 0 ps;
      tisd_PIPEPHYSTATUSA_MGTCLK : VitalDelayType := 0 ps;
      tisd_PIPEPHYSTATUSB_MGTCLK : VitalDelayType := 0 ps;
      tisd_PIPERXCHARISKA_MGTCLK : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tisd_PIPERXCHARISKB_MGTCLK : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tisd_PIPERXDATAA_MGTCLK : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tisd_PIPERXDATAB_MGTCLK : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tisd_PIPERXENTERELECIDLEA_MGTCLK : VitalDelayType := 0 ps;
      tisd_PIPERXENTERELECIDLEB_MGTCLK : VitalDelayType := 0 ps;
      tisd_PIPERXSTATUSA_MGTCLK : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tisd_PIPERXSTATUSB_MGTCLK : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tisd_TRNFCSEL_USERCLK : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tisd_TRNRDSTRDYN_USERCLK : VitalDelayType := 0 ps;
      tisd_TRNRNPOKN_USERCLK : VitalDelayType := 0 ps;
      tisd_TRNTCFGGNTN_USERCLK : VitalDelayType := 0 ps;
      tisd_TRNTD_USERCLK : VitalDelayArrayType(31 downto 0) := (others => 0 ps);
      tisd_TRNTEOFN_USERCLK : VitalDelayType := 0 ps;
      tisd_TRNTERRFWDN_USERCLK : VitalDelayType := 0 ps;
      tisd_TRNTSOFN_USERCLK : VitalDelayType := 0 ps;
      tisd_TRNTSRCDSCN_USERCLK : VitalDelayType := 0 ps;
      tisd_TRNTSRCRDYN_USERCLK : VitalDelayType := 0 ps;
      tisd_TRNTSTRN_USERCLK : VitalDelayType := 0 ps;
-- VITAL ticd variables
      ticd_MGTCLK : VitalDelayType := 0 ps;
      ticd_USERCLK : VitalDelayType := 0 ps;
-- VITAL tperiod variables
      tperiod_MGTCLK_posedge : VitalDelayType := 0 ps;
      tperiod_USERCLK_posedge : VitalDelayType := 0 ps
    );

    port (
      CFGBUSNUMBER         : out std_logic_vector(7 downto 0);
      CFGCOMMANDBUSMASTERENABLE : out std_ulogic;
      CFGCOMMANDINTERRUPTDISABLE : out std_ulogic;
      CFGCOMMANDIOENABLE   : out std_ulogic;
      CFGCOMMANDMEMENABLE  : out std_ulogic;
      CFGCOMMANDSERREN     : out std_ulogic;
      CFGDEVCONTROLAUXPOWEREN : out std_ulogic;
      CFGDEVCONTROLCORRERRREPORTINGEN : out std_ulogic;
      CFGDEVCONTROLENABLERO : out std_ulogic;
      CFGDEVCONTROLEXTTAGEN : out std_ulogic;
      CFGDEVCONTROLFATALERRREPORTINGEN : out std_ulogic;
      CFGDEVCONTROLMAXPAYLOAD : out std_logic_vector(2 downto 0);
      CFGDEVCONTROLMAXREADREQ : out std_logic_vector(2 downto 0);
      CFGDEVCONTROLNONFATALREPORTINGEN : out std_ulogic;
      CFGDEVCONTROLNOSNOOPEN : out std_ulogic;
      CFGDEVCONTROLPHANTOMEN : out std_ulogic;
      CFGDEVCONTROLURERRREPORTINGEN : out std_ulogic;
      CFGDEVICENUMBER      : out std_logic_vector(4 downto 0);
      CFGDEVSTATUSCORRERRDETECTED : out std_ulogic;
      CFGDEVSTATUSFATALERRDETECTED : out std_ulogic;
      CFGDEVSTATUSNONFATALERRDETECTED : out std_ulogic;
      CFGDEVSTATUSURDETECTED : out std_ulogic;
      CFGDO                : out std_logic_vector(31 downto 0);
      CFGERRCPLRDYN        : out std_ulogic;
      CFGFUNCTIONNUMBER    : out std_logic_vector(2 downto 0);
      CFGINTERRUPTDO       : out std_logic_vector(7 downto 0);
      CFGINTERRUPTMMENABLE : out std_logic_vector(2 downto 0);
      CFGINTERRUPTMSIENABLE : out std_ulogic;
      CFGINTERRUPTRDYN     : out std_ulogic;
      CFGLINKCONTOLRCB     : out std_ulogic;
      CFGLINKCONTROLASPMCONTROL : out std_logic_vector(1 downto 0);
      CFGLINKCONTROLCOMMONCLOCK : out std_ulogic;
      CFGLINKCONTROLEXTENDEDSYNC : out std_ulogic;
      CFGLTSSMSTATE        : out std_logic_vector(4 downto 0);
      CFGPCIELINKSTATEN    : out std_logic_vector(2 downto 0);
      CFGRDWRDONEN         : out std_ulogic;
      CFGTOTURNOFFN        : out std_ulogic;
      DBGBADDLLPSTATUS     : out std_ulogic;
      DBGBADTLPLCRC        : out std_ulogic;
      DBGBADTLPSEQNUM      : out std_ulogic;
      DBGBADTLPSTATUS      : out std_ulogic;
      DBGDLPROTOCOLSTATUS  : out std_ulogic;
      DBGFCPROTOCOLERRSTATUS : out std_ulogic;
      DBGMLFRMDLENGTH      : out std_ulogic;
      DBGMLFRMDMPS         : out std_ulogic;
      DBGMLFRMDTCVC        : out std_ulogic;
      DBGMLFRMDTLPSTATUS   : out std_ulogic;
      DBGMLFRMDUNRECTYPE   : out std_ulogic;
      DBGPOISTLPSTATUS     : out std_ulogic;
      DBGRCVROVERFLOWSTATUS : out std_ulogic;
      DBGREGDETECTEDCORRECTABLE : out std_ulogic;
      DBGREGDETECTEDFATAL  : out std_ulogic;
      DBGREGDETECTEDNONFATAL : out std_ulogic;
      DBGREGDETECTEDUNSUPPORTED : out std_ulogic;
      DBGRPLYROLLOVERSTATUS : out std_ulogic;
      DBGRPLYTIMEOUTSTATUS : out std_ulogic;
      DBGURNOBARHIT        : out std_ulogic;
      DBGURPOISCFGWR       : out std_ulogic;
      DBGURSTATUS          : out std_ulogic;
      DBGURUNSUPMSG        : out std_ulogic;
      MIMRXRADDR           : out std_logic_vector(11 downto 0);
      MIMRXREN             : out std_ulogic;
      MIMRXWADDR           : out std_logic_vector(11 downto 0);
      MIMRXWDATA           : out std_logic_vector(34 downto 0);
      MIMRXWEN             : out std_ulogic;
      MIMTXRADDR           : out std_logic_vector(11 downto 0);
      MIMTXREN             : out std_ulogic;
      MIMTXWADDR           : out std_logic_vector(11 downto 0);
      MIMTXWDATA           : out std_logic_vector(35 downto 0);
      MIMTXWEN             : out std_ulogic;
      PIPEGTPOWERDOWNA     : out std_logic_vector(1 downto 0);
      PIPEGTPOWERDOWNB     : out std_logic_vector(1 downto 0);
      PIPEGTTXELECIDLEA    : out std_ulogic;
      PIPEGTTXELECIDLEB    : out std_ulogic;
      PIPERXPOLARITYA      : out std_ulogic;
      PIPERXPOLARITYB      : out std_ulogic;
      PIPERXRESETA         : out std_ulogic;
      PIPERXRESETB         : out std_ulogic;
      PIPETXCHARDISPMODEA  : out std_logic_vector(1 downto 0);
      PIPETXCHARDISPMODEB  : out std_logic_vector(1 downto 0);
      PIPETXCHARDISPVALA   : out std_logic_vector(1 downto 0);
      PIPETXCHARDISPVALB   : out std_logic_vector(1 downto 0);
      PIPETXCHARISKA       : out std_logic_vector(1 downto 0);
      PIPETXCHARISKB       : out std_logic_vector(1 downto 0);
      PIPETXDATAA          : out std_logic_vector(15 downto 0);
      PIPETXDATAB          : out std_logic_vector(15 downto 0);
      PIPETXRCVRDETA       : out std_ulogic;
      PIPETXRCVRDETB       : out std_ulogic;
      RECEIVEDHOTRESET     : out std_ulogic;
      TRNFCCPLD            : out std_logic_vector(11 downto 0);
      TRNFCCPLH            : out std_logic_vector(7 downto 0);
      TRNFCNPD             : out std_logic_vector(11 downto 0);
      TRNFCNPH             : out std_logic_vector(7 downto 0);
      TRNFCPD              : out std_logic_vector(11 downto 0);
      TRNFCPH              : out std_logic_vector(7 downto 0);
      TRNLNKUPN            : out std_ulogic;
      TRNRBARHITN          : out std_logic_vector(6 downto 0);
      TRNRD                : out std_logic_vector(31 downto 0);
      TRNREOFN             : out std_ulogic;
      TRNRERRFWDN          : out std_ulogic;
      TRNRSOFN             : out std_ulogic;
      TRNRSRCDSCN          : out std_ulogic;
      TRNRSRCRDYN          : out std_ulogic;
      TRNTBUFAV            : out std_logic_vector(5 downto 0);
      TRNTCFGREQN          : out std_ulogic;
      TRNTDSTRDYN          : out std_ulogic;
      TRNTERRDROPN         : out std_ulogic;
      USERRSTN             : out std_ulogic;
      CFGDEVID             : in std_logic_vector(15 downto 0);
      CFGDSN               : in std_logic_vector(63 downto 0);
      CFGDWADDR            : in std_logic_vector(9 downto 0);
      CFGERRCORN           : in std_ulogic := 'L';
      CFGERRCPLABORTN      : in std_ulogic := 'L';
      CFGERRCPLTIMEOUTN    : in std_ulogic := 'L';
      CFGERRECRCN          : in std_ulogic := 'L';
      CFGERRLOCKEDN        : in std_ulogic := 'L';
      CFGERRPOSTEDN        : in std_ulogic := 'L';
      CFGERRTLPCPLHEADER   : in std_logic_vector(47 downto 0);
      CFGERRURN            : in std_ulogic := 'L';
      CFGINTERRUPTASSERTN  : in std_ulogic := 'L';
      CFGINTERRUPTDI       : in std_logic_vector(7 downto 0);
      CFGINTERRUPTN        : in std_ulogic := 'L';
      CFGPMWAKEN           : in std_ulogic := 'L';
      CFGRDENN             : in std_ulogic := 'L';
      CFGREVID             : in std_logic_vector(7 downto 0);
      CFGSUBSYSID          : in std_logic_vector(15 downto 0);
      CFGSUBSYSVENID       : in std_logic_vector(15 downto 0);
      CFGTRNPENDINGN       : in std_ulogic := 'L';
      CFGTURNOFFOKN        : in std_ulogic := 'L';
      CFGVENID             : in std_logic_vector(15 downto 0);
      CLOCKLOCKED          : in std_ulogic := 'L';
      MGTCLK               : in std_ulogic := 'L';
      MIMRXRDATA           : in std_logic_vector(34 downto 0);
      MIMTXRDATA           : in std_logic_vector(35 downto 0);
      PIPEGTRESETDONEA     : in std_ulogic := 'L';
      PIPEGTRESETDONEB     : in std_ulogic := 'L';
      PIPEPHYSTATUSA       : in std_ulogic := 'L';
      PIPEPHYSTATUSB       : in std_ulogic := 'L';
      PIPERXCHARISKA       : in std_logic_vector(1 downto 0);
      PIPERXCHARISKB       : in std_logic_vector(1 downto 0);
      PIPERXDATAA          : in std_logic_vector(15 downto 0);
      PIPERXDATAB          : in std_logic_vector(15 downto 0);
      PIPERXENTERELECIDLEA : in std_ulogic := 'L';
      PIPERXENTERELECIDLEB : in std_ulogic := 'L';
      PIPERXSTATUSA        : in std_logic_vector(2 downto 0);
      PIPERXSTATUSB        : in std_logic_vector(2 downto 0);
      SYSRESETN            : in std_ulogic := 'L';
      TRNFCSEL             : in std_logic_vector(2 downto 0);
      TRNRDSTRDYN          : in std_ulogic := 'L';
      TRNRNPOKN            : in std_ulogic := 'L';
      TRNTCFGGNTN          : in std_ulogic := 'L';
      TRNTD                : in std_logic_vector(31 downto 0);
      TRNTEOFN             : in std_ulogic := 'L';
      TRNTERRFWDN          : in std_ulogic := 'L';
      TRNTSOFN             : in std_ulogic := 'L';
      TRNTSRCDSCN          : in std_ulogic := 'L';
      TRNTSRCRDYN          : in std_ulogic := 'L';
      TRNTSTRN             : in std_ulogic := 'L';
      USERCLK              : in std_ulogic := 'L'      
    );
    attribute VITAL_LEVEL0 of X_PCIE_A1 :     entity is true;
  end X_PCIE_A1;

  architecture X_PCIE_A1_V of X_PCIE_A1 is
    TYPE VitalTimingDataArrayType IS ARRAY (NATURAL RANGE <>) OF VitalTimingDataType;
    component PCIE_A1_WRAP
      generic (
        BAR0 : string;
        BAR1 : string;
        BAR2 : string;
        BAR3 : string;
        BAR4 : string;
        BAR5 : string;
        CARDBUS_CIS_POINTER : string;
        CLASS_CODE : string;
        DEV_CAP_ENDPOINT_L0S_LATENCY : integer;
        DEV_CAP_ENDPOINT_L1_LATENCY : integer;
        DEV_CAP_EXT_TAG_SUPPORTED : string;
        DEV_CAP_MAX_PAYLOAD_SUPPORTED : integer;
        DEV_CAP_PHANTOM_FUNCTIONS_SUPPORT : integer;
        DEV_CAP_ROLE_BASED_ERROR : string;
        DISABLE_BAR_FILTERING : string;
        DISABLE_ID_CHECK : string;
        DISABLE_SCRAMBLING : string;
        ENABLE_RX_TD_ECRC_TRIM : string;
        EXPANSION_ROM : string;
        FAST_TRAIN : string;
        GTP_SEL : integer;
        LINK_CAP_ASPM_SUPPORT : integer;
        LINK_CAP_L0S_EXIT_LATENCY : integer;
        LINK_CAP_L1_EXIT_LATENCY : integer;
        LINK_STATUS_SLOT_CLOCK_CONFIG : string;
        LL_ACK_TIMEOUT : string;
        LL_ACK_TIMEOUT_EN : string;
        LL_REPLAY_TIMEOUT : string;
        LL_REPLAY_TIMEOUT_EN : string;
        MSI_CAP_MULTIMSGCAP : integer;
        MSI_CAP_MULTIMSG_EXTENSION : integer;
        PCIE_CAP_CAPABILITY_VERSION : string;
        PCIE_CAP_DEVICE_PORT_TYPE : string;
        PCIE_CAP_INT_MSG_NUM : string;
        PCIE_CAP_SLOT_IMPLEMENTED : string;
        PCIE_GENERIC : string;
        PLM_AUTO_CONFIG : string;
        PM_CAP_AUXCURRENT : integer;
        PM_CAP_D1SUPPORT : string;
        PM_CAP_D2SUPPORT : string;
        PM_CAP_DSI : string;
        PM_CAP_PMESUPPORT : string;
        PM_CAP_PME_CLOCK : string;
        PM_CAP_VERSION : integer;
        PM_DATA0 : string;
        PM_DATA1 : string;
        PM_DATA2 : string;
        PM_DATA3 : string;
        PM_DATA4 : string;
        PM_DATA5 : string;
        PM_DATA6 : string;
        PM_DATA7 : string;
        PM_DATA_SCALE0 : string;
        PM_DATA_SCALE1 : string;
        PM_DATA_SCALE2 : string;
        PM_DATA_SCALE3 : string;
        PM_DATA_SCALE4 : string;
        PM_DATA_SCALE5 : string;
        PM_DATA_SCALE6 : string;
        PM_DATA_SCALE7 : string;
        SIM_VERSION : string;
        SLOT_CAP_ATT_BUTTON_PRESENT : string;
        SLOT_CAP_ATT_INDICATOR_PRESENT : string;
        SLOT_CAP_POWER_INDICATOR_PRESENT : string;
        TL_RX_RAM_RADDR_LATENCY : integer;
        TL_RX_RAM_RDATA_LATENCY : integer;
        TL_RX_RAM_WRITE_LATENCY : integer;
        TL_TFC_DISABLE : string;
        TL_TX_CHECKS_DISABLE : string;
        TL_TX_RAM_RADDR_LATENCY : integer;
        TL_TX_RAM_RDATA_LATENCY : integer;
        USR_CFG : string;
        USR_EXT_CFG : string;
        VC0_CPL_INFINITE : string;
        VC0_RX_RAM_LIMIT : string;
        VC0_TOTAL_CREDITS_CD : integer;
        VC0_TOTAL_CREDITS_CH : integer;
        VC0_TOTAL_CREDITS_NPH : integer;
        VC0_TOTAL_CREDITS_PD : integer;
        VC0_TOTAL_CREDITS_PH : integer;
        VC0_TX_LASTPACKET : integer        
      );
      
      port (
        CFGBUSNUMBER         : out std_logic_vector(7 downto 0);
        CFGCOMMANDBUSMASTERENABLE : out std_ulogic;
        CFGCOMMANDINTERRUPTDISABLE : out std_ulogic;
        CFGCOMMANDIOENABLE   : out std_ulogic;
        CFGCOMMANDMEMENABLE  : out std_ulogic;
        CFGCOMMANDSERREN     : out std_ulogic;
        CFGDEVCONTROLAUXPOWEREN : out std_ulogic;
        CFGDEVCONTROLCORRERRREPORTINGEN : out std_ulogic;
        CFGDEVCONTROLENABLERO : out std_ulogic;
        CFGDEVCONTROLEXTTAGEN : out std_ulogic;
        CFGDEVCONTROLFATALERRREPORTINGEN : out std_ulogic;
        CFGDEVCONTROLMAXPAYLOAD : out std_logic_vector(2 downto 0);
        CFGDEVCONTROLMAXREADREQ : out std_logic_vector(2 downto 0);
        CFGDEVCONTROLNONFATALREPORTINGEN : out std_ulogic;
        CFGDEVCONTROLNOSNOOPEN : out std_ulogic;
        CFGDEVCONTROLPHANTOMEN : out std_ulogic;
        CFGDEVCONTROLURERRREPORTINGEN : out std_ulogic;
        CFGDEVICENUMBER      : out std_logic_vector(4 downto 0);
        CFGDEVSTATUSCORRERRDETECTED : out std_ulogic;
        CFGDEVSTATUSFATALERRDETECTED : out std_ulogic;
        CFGDEVSTATUSNONFATALERRDETECTED : out std_ulogic;
        CFGDEVSTATUSURDETECTED : out std_ulogic;
        CFGDO                : out std_logic_vector(31 downto 0);
        CFGERRCPLRDYN        : out std_ulogic;
        CFGFUNCTIONNUMBER    : out std_logic_vector(2 downto 0);
        CFGINTERRUPTDO       : out std_logic_vector(7 downto 0);
        CFGINTERRUPTMMENABLE : out std_logic_vector(2 downto 0);
        CFGINTERRUPTMSIENABLE : out std_ulogic;
        CFGINTERRUPTRDYN     : out std_ulogic;
        CFGLINKCONTOLRCB     : out std_ulogic;
        CFGLINKCONTROLASPMCONTROL : out std_logic_vector(1 downto 0);
        CFGLINKCONTROLCOMMONCLOCK : out std_ulogic;
        CFGLINKCONTROLEXTENDEDSYNC : out std_ulogic;
        CFGLTSSMSTATE        : out std_logic_vector(4 downto 0);
        CFGPCIELINKSTATEN    : out std_logic_vector(2 downto 0);
        CFGRDWRDONEN         : out std_ulogic;
        CFGTOTURNOFFN        : out std_ulogic;
        DBGBADDLLPSTATUS     : out std_ulogic;
        DBGBADTLPLCRC        : out std_ulogic;
        DBGBADTLPSEQNUM      : out std_ulogic;
        DBGBADTLPSTATUS      : out std_ulogic;
        DBGDLPROTOCOLSTATUS  : out std_ulogic;
        DBGFCPROTOCOLERRSTATUS : out std_ulogic;
        DBGMLFRMDLENGTH      : out std_ulogic;
        DBGMLFRMDMPS         : out std_ulogic;
        DBGMLFRMDTCVC        : out std_ulogic;
        DBGMLFRMDTLPSTATUS   : out std_ulogic;
        DBGMLFRMDUNRECTYPE   : out std_ulogic;
        DBGPOISTLPSTATUS     : out std_ulogic;
        DBGRCVROVERFLOWSTATUS : out std_ulogic;
        DBGREGDETECTEDCORRECTABLE : out std_ulogic;
        DBGREGDETECTEDFATAL  : out std_ulogic;
        DBGREGDETECTEDNONFATAL : out std_ulogic;
        DBGREGDETECTEDUNSUPPORTED : out std_ulogic;
        DBGRPLYROLLOVERSTATUS : out std_ulogic;
        DBGRPLYTIMEOUTSTATUS : out std_ulogic;
        DBGURNOBARHIT        : out std_ulogic;
        DBGURPOISCFGWR       : out std_ulogic;
        DBGURSTATUS          : out std_ulogic;
        DBGURUNSUPMSG        : out std_ulogic;
        MIMRXRADDR           : out std_logic_vector(11 downto 0);
        MIMRXREN             : out std_ulogic;
        MIMRXWADDR           : out std_logic_vector(11 downto 0);
        MIMRXWDATA           : out std_logic_vector(34 downto 0);
        MIMRXWEN             : out std_ulogic;
        MIMTXRADDR           : out std_logic_vector(11 downto 0);
        MIMTXREN             : out std_ulogic;
        MIMTXWADDR           : out std_logic_vector(11 downto 0);
        MIMTXWDATA           : out std_logic_vector(35 downto 0);
        MIMTXWEN             : out std_ulogic;
        PIPEGTPOWERDOWNA     : out std_logic_vector(1 downto 0);
        PIPEGTPOWERDOWNB     : out std_logic_vector(1 downto 0);
        PIPEGTTXELECIDLEA    : out std_ulogic;
        PIPEGTTXELECIDLEB    : out std_ulogic;
        PIPERXPOLARITYA      : out std_ulogic;
        PIPERXPOLARITYB      : out std_ulogic;
        PIPERXRESETA         : out std_ulogic;
        PIPERXRESETB         : out std_ulogic;
        PIPETXCHARDISPMODEA  : out std_logic_vector(1 downto 0);
        PIPETXCHARDISPMODEB  : out std_logic_vector(1 downto 0);
        PIPETXCHARDISPVALA   : out std_logic_vector(1 downto 0);
        PIPETXCHARDISPVALB   : out std_logic_vector(1 downto 0);
        PIPETXCHARISKA       : out std_logic_vector(1 downto 0);
        PIPETXCHARISKB       : out std_logic_vector(1 downto 0);
        PIPETXDATAA          : out std_logic_vector(15 downto 0);
        PIPETXDATAB          : out std_logic_vector(15 downto 0);
        PIPETXRCVRDETA       : out std_ulogic;
        PIPETXRCVRDETB       : out std_ulogic;
        RECEIVEDHOTRESET     : out std_ulogic;
        TRNFCCPLD            : out std_logic_vector(11 downto 0);
        TRNFCCPLH            : out std_logic_vector(7 downto 0);
        TRNFCNPD             : out std_logic_vector(11 downto 0);
        TRNFCNPH             : out std_logic_vector(7 downto 0);
        TRNFCPD              : out std_logic_vector(11 downto 0);
        TRNFCPH              : out std_logic_vector(7 downto 0);
        TRNLNKUPN            : out std_ulogic;
        TRNRBARHITN          : out std_logic_vector(6 downto 0);
        TRNRD                : out std_logic_vector(31 downto 0);
        TRNREOFN             : out std_ulogic;
        TRNRERRFWDN          : out std_ulogic;
        TRNRSOFN             : out std_ulogic;
        TRNRSRCDSCN          : out std_ulogic;
        TRNRSRCRDYN          : out std_ulogic;
        TRNTBUFAV            : out std_logic_vector(5 downto 0);
        TRNTCFGREQN          : out std_ulogic;
        TRNTDSTRDYN          : out std_ulogic;
        TRNTERRDROPN         : out std_ulogic;
        USERRSTN             : out std_ulogic;
        GSR                  : in std_ulogic;
        CFGDEVID             : in std_logic_vector(15 downto 0);
        CFGDSN               : in std_logic_vector(63 downto 0);
        CFGDWADDR            : in std_logic_vector(9 downto 0);
        CFGERRCORN           : in std_ulogic;
        CFGERRCPLABORTN      : in std_ulogic;
        CFGERRCPLTIMEOUTN    : in std_ulogic;
        CFGERRECRCN          : in std_ulogic;
        CFGERRLOCKEDN        : in std_ulogic;
        CFGERRPOSTEDN        : in std_ulogic;
        CFGERRTLPCPLHEADER   : in std_logic_vector(47 downto 0);
        CFGERRURN            : in std_ulogic;
        CFGINTERRUPTASSERTN  : in std_ulogic;
        CFGINTERRUPTDI       : in std_logic_vector(7 downto 0);
        CFGINTERRUPTN        : in std_ulogic;
        CFGPMWAKEN           : in std_ulogic;
        CFGRDENN             : in std_ulogic;
        CFGREVID             : in std_logic_vector(7 downto 0);
        CFGSUBSYSID          : in std_logic_vector(15 downto 0);
        CFGSUBSYSVENID       : in std_logic_vector(15 downto 0);
        CFGTRNPENDINGN       : in std_ulogic;
        CFGTURNOFFOKN        : in std_ulogic;
        CFGVENID             : in std_logic_vector(15 downto 0);
        CLOCKLOCKED          : in std_ulogic;
        MGTCLK               : in std_ulogic;
        MIMRXRDATA           : in std_logic_vector(34 downto 0);
        MIMTXRDATA           : in std_logic_vector(35 downto 0);
        PIPEGTRESETDONEA     : in std_ulogic;
        PIPEGTRESETDONEB     : in std_ulogic;
        PIPEPHYSTATUSA       : in std_ulogic;
        PIPEPHYSTATUSB       : in std_ulogic;
        PIPERXCHARISKA       : in std_logic_vector(1 downto 0);
        PIPERXCHARISKB       : in std_logic_vector(1 downto 0);
        PIPERXDATAA          : in std_logic_vector(15 downto 0);
        PIPERXDATAB          : in std_logic_vector(15 downto 0);
        PIPERXENTERELECIDLEA : in std_ulogic;
        PIPERXENTERELECIDLEB : in std_ulogic;
        PIPERXSTATUSA        : in std_logic_vector(2 downto 0);
        PIPERXSTATUSB        : in std_logic_vector(2 downto 0);
        SYSRESETN            : in std_ulogic;
        TRNFCSEL             : in std_logic_vector(2 downto 0);
        TRNRDSTRDYN          : in std_ulogic;
        TRNRNPOKN            : in std_ulogic;
        TRNTCFGGNTN          : in std_ulogic;
        TRNTD                : in std_logic_vector(31 downto 0);
        TRNTEOFN             : in std_ulogic;
        TRNTERRFWDN          : in std_ulogic;
        TRNTSOFN             : in std_ulogic;
        TRNTSRCDSCN          : in std_ulogic;
        TRNTSRCRDYN          : in std_ulogic;
        TRNTSTRN             : in std_ulogic;
        USERCLK              : in std_ulogic        
      );
    end component;
    
    constant IN_DELAY : time := 0 ps;
    constant OUT_DELAY : time := 0 ps;
    constant INCLK_DELAY : time := 0 ps;
    constant OUTCLK_DELAY : time := 0 ps;

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
    constant BAR0_BINARY : std_logic_vector(31 downto 0) := To_StdLogicVector(BAR0)(31 downto 0);
    constant BAR1_BINARY : std_logic_vector(31 downto 0) := To_StdLogicVector(BAR1)(31 downto 0);
    constant BAR2_BINARY : std_logic_vector(31 downto 0) := To_StdLogicVector(BAR2)(31 downto 0);
    constant BAR3_BINARY : std_logic_vector(31 downto 0) := To_StdLogicVector(BAR3)(31 downto 0);
    constant BAR4_BINARY : std_logic_vector(31 downto 0) := To_StdLogicVector(BAR4)(31 downto 0);
    constant BAR5_BINARY : std_logic_vector(31 downto 0) := To_StdLogicVector(BAR5)(31 downto 0);
    constant CARDBUS_CIS_POINTER_BINARY : std_logic_vector(31 downto 0) := To_StdLogicVector(CARDBUS_CIS_POINTER)(31 downto 0);
    constant CLASS_CODE_BINARY : std_logic_vector(23 downto 0) := To_StdLogicVector(CLASS_CODE)(23 downto 0);
    constant EXPANSION_ROM_BINARY : std_logic_vector(21 downto 0) := To_StdLogicVector(EXPANSION_ROM)(21 downto 0);
    constant LL_ACK_TIMEOUT_BINARY : std_logic_vector(14 downto 0) := To_StdLogicVector(LL_ACK_TIMEOUT)(14 downto 0);
    constant LL_REPLAY_TIMEOUT_BINARY : std_logic_vector(14 downto 0) := To_StdLogicVector(LL_REPLAY_TIMEOUT)(14 downto 0);
    constant PCIE_CAP_CAPABILITY_VERSION_BINARY : std_logic_vector(3 downto 0) := To_StdLogicVector(PCIE_CAP_CAPABILITY_VERSION)(3 downto 0);
    constant PCIE_CAP_DEVICE_PORT_TYPE_BINARY : std_logic_vector(3 downto 0) := To_StdLogicVector(PCIE_CAP_DEVICE_PORT_TYPE)(3 downto 0);
    constant PCIE_CAP_INT_MSG_NUM_BINARY : std_logic_vector(4 downto 0) := To_StdLogicVector(PCIE_CAP_INT_MSG_NUM)(4 downto 0);
    constant PCIE_GENERIC_BINARY : std_logic_vector(11 downto 0) := To_StdLogicVector(PCIE_GENERIC)(11 downto 0);
    constant PM_CAP_PMESUPPORT_BINARY : std_logic_vector(4 downto 0) := To_StdLogicVector(PM_CAP_PMESUPPORT)(4 downto 0);
    constant PM_DATA0_BINARY : std_logic_vector(7 downto 0) := To_StdLogicVector(PM_DATA0)(7 downto 0);
    constant PM_DATA1_BINARY : std_logic_vector(7 downto 0) := To_StdLogicVector(PM_DATA1)(7 downto 0);
    constant PM_DATA2_BINARY : std_logic_vector(7 downto 0) := To_StdLogicVector(PM_DATA2)(7 downto 0);
    constant PM_DATA3_BINARY : std_logic_vector(7 downto 0) := To_StdLogicVector(PM_DATA3)(7 downto 0);
    constant PM_DATA4_BINARY : std_logic_vector(7 downto 0) := To_StdLogicVector(PM_DATA4)(7 downto 0);
    constant PM_DATA5_BINARY : std_logic_vector(7 downto 0) := To_StdLogicVector(PM_DATA5)(7 downto 0);
    constant PM_DATA6_BINARY : std_logic_vector(7 downto 0) := To_StdLogicVector(PM_DATA6)(7 downto 0);
    constant PM_DATA7_BINARY : std_logic_vector(7 downto 0) := To_StdLogicVector(PM_DATA7)(7 downto 0);
    constant PM_DATA_SCALE0_BINARY : std_logic_vector(1 downto 0) := To_StdLogicVector(PM_DATA_SCALE0)(1 downto 0);
    constant PM_DATA_SCALE1_BINARY : std_logic_vector(1 downto 0) := To_StdLogicVector(PM_DATA_SCALE1)(1 downto 0);
    constant PM_DATA_SCALE2_BINARY : std_logic_vector(1 downto 0) := To_StdLogicVector(PM_DATA_SCALE2)(1 downto 0);
    constant PM_DATA_SCALE3_BINARY : std_logic_vector(1 downto 0) := To_StdLogicVector(PM_DATA_SCALE3)(1 downto 0);
    constant PM_DATA_SCALE4_BINARY : std_logic_vector(1 downto 0) := To_StdLogicVector(PM_DATA_SCALE4)(1 downto 0);
    constant PM_DATA_SCALE5_BINARY : std_logic_vector(1 downto 0) := To_StdLogicVector(PM_DATA_SCALE5)(1 downto 0);
    constant PM_DATA_SCALE6_BINARY : std_logic_vector(1 downto 0) := To_StdLogicVector(PM_DATA_SCALE6)(1 downto 0);
    constant PM_DATA_SCALE7_BINARY : std_logic_vector(1 downto 0) := To_StdLogicVector(PM_DATA_SCALE7)(1 downto 0);
    constant VC0_RX_RAM_LIMIT_BINARY : std_logic_vector(11 downto 0) := To_StdLogicVector(VC0_RX_RAM_LIMIT)(11 downto 0);
    constant BAR0_STRLEN : integer := getstrlength(BAR0_BINARY);
    constant BAR1_STRLEN : integer := getstrlength(BAR1_BINARY);
    constant BAR2_STRLEN : integer := getstrlength(BAR2_BINARY);
    constant BAR3_STRLEN : integer := getstrlength(BAR3_BINARY);
    constant BAR4_STRLEN : integer := getstrlength(BAR4_BINARY);
    constant BAR5_STRLEN : integer := getstrlength(BAR5_BINARY);
    constant CARDBUS_CIS_POINTER_STRLEN : integer := getstrlength(CARDBUS_CIS_POINTER_BINARY);
    constant CLASS_CODE_STRLEN : integer := getstrlength(CLASS_CODE_BINARY);
    constant EXPANSION_ROM_STRLEN : integer := getstrlength(EXPANSION_ROM_BINARY);
    constant LL_ACK_TIMEOUT_STRLEN : integer := getstrlength(LL_ACK_TIMEOUT_BINARY);
    constant LL_REPLAY_TIMEOUT_STRLEN : integer := getstrlength(LL_REPLAY_TIMEOUT_BINARY);
    constant PCIE_CAP_CAPABILITY_VERSION_STRLEN : integer := getstrlength(PCIE_CAP_CAPABILITY_VERSION_BINARY);
    constant PCIE_CAP_DEVICE_PORT_TYPE_STRLEN : integer := getstrlength(PCIE_CAP_DEVICE_PORT_TYPE_BINARY);
    constant PCIE_CAP_INT_MSG_NUM_STRLEN : integer := getstrlength(PCIE_CAP_INT_MSG_NUM_BINARY);
    constant PCIE_GENERIC_STRLEN : integer := getstrlength(PCIE_GENERIC_BINARY);
    constant PM_CAP_PMESUPPORT_STRLEN : integer := getstrlength(PM_CAP_PMESUPPORT_BINARY);
    constant PM_DATA0_STRLEN : integer := getstrlength(PM_DATA0_BINARY);
    constant PM_DATA1_STRLEN : integer := getstrlength(PM_DATA1_BINARY);
    constant PM_DATA2_STRLEN : integer := getstrlength(PM_DATA2_BINARY);
    constant PM_DATA3_STRLEN : integer := getstrlength(PM_DATA3_BINARY);
    constant PM_DATA4_STRLEN : integer := getstrlength(PM_DATA4_BINARY);
    constant PM_DATA5_STRLEN : integer := getstrlength(PM_DATA5_BINARY);
    constant PM_DATA6_STRLEN : integer := getstrlength(PM_DATA6_BINARY);
    constant PM_DATA7_STRLEN : integer := getstrlength(PM_DATA7_BINARY);
    constant PM_DATA_SCALE0_STRLEN : integer := getstrlength(PM_DATA_SCALE0_BINARY);
    constant PM_DATA_SCALE1_STRLEN : integer := getstrlength(PM_DATA_SCALE1_BINARY);
    constant PM_DATA_SCALE2_STRLEN : integer := getstrlength(PM_DATA_SCALE2_BINARY);
    constant PM_DATA_SCALE3_STRLEN : integer := getstrlength(PM_DATA_SCALE3_BINARY);
    constant PM_DATA_SCALE4_STRLEN : integer := getstrlength(PM_DATA_SCALE4_BINARY);
    constant PM_DATA_SCALE5_STRLEN : integer := getstrlength(PM_DATA_SCALE5_BINARY);
    constant PM_DATA_SCALE6_STRLEN : integer := getstrlength(PM_DATA_SCALE6_BINARY);
    constant PM_DATA_SCALE7_STRLEN : integer := getstrlength(PM_DATA_SCALE7_BINARY);
    constant VC0_RX_RAM_LIMIT_STRLEN : integer := getstrlength(VC0_RX_RAM_LIMIT_BINARY);
    -- Convert std_logic_vector to string
    constant BAR0_STRING : string := SLV_TO_HEX(BAR0_BINARY, BAR0_STRLEN);
    constant BAR1_STRING : string := SLV_TO_HEX(BAR1_BINARY, BAR1_STRLEN);
    constant BAR2_STRING : string := SLV_TO_HEX(BAR2_BINARY, BAR2_STRLEN);
    constant BAR3_STRING : string := SLV_TO_HEX(BAR3_BINARY, BAR3_STRLEN);
    constant BAR4_STRING : string := SLV_TO_HEX(BAR4_BINARY, BAR4_STRLEN);
    constant BAR5_STRING : string := SLV_TO_HEX(BAR5_BINARY, BAR5_STRLEN);
    constant CARDBUS_CIS_POINTER_STRING : string := SLV_TO_HEX(CARDBUS_CIS_POINTER_BINARY, CARDBUS_CIS_POINTER_STRLEN);
    constant CLASS_CODE_STRING : string := SLV_TO_HEX(CLASS_CODE_BINARY, CLASS_CODE_STRLEN);
    constant EXPANSION_ROM_STRING : string := SLV_TO_HEX(EXPANSION_ROM_BINARY, EXPANSION_ROM_STRLEN);
    constant LL_ACK_TIMEOUT_STRING : string := SLV_TO_HEX(LL_ACK_TIMEOUT_BINARY, LL_ACK_TIMEOUT_STRLEN);
    constant LL_REPLAY_TIMEOUT_STRING : string := SLV_TO_HEX(LL_REPLAY_TIMEOUT_BINARY, LL_REPLAY_TIMEOUT_STRLEN);
    constant PCIE_CAP_CAPABILITY_VERSION_STRING : string := SLV_TO_HEX(PCIE_CAP_CAPABILITY_VERSION_BINARY, PCIE_CAP_CAPABILITY_VERSION_STRLEN);
    constant PCIE_CAP_DEVICE_PORT_TYPE_STRING : string := SLV_TO_HEX(PCIE_CAP_DEVICE_PORT_TYPE_BINARY, PCIE_CAP_DEVICE_PORT_TYPE_STRLEN);
    constant PCIE_CAP_INT_MSG_NUM_STRING : string := SLV_TO_HEX(PCIE_CAP_INT_MSG_NUM_BINARY, PCIE_CAP_INT_MSG_NUM_STRLEN);
    constant PCIE_GENERIC_STRING : string := SLV_TO_HEX(PCIE_GENERIC_BINARY, PCIE_GENERIC_STRLEN);
    constant PM_CAP_PMESUPPORT_STRING : string := SLV_TO_HEX(PM_CAP_PMESUPPORT_BINARY, PM_CAP_PMESUPPORT_STRLEN);
    constant PM_DATA0_STRING : string := SLV_TO_HEX(PM_DATA0_BINARY, PM_DATA0_STRLEN);
    constant PM_DATA1_STRING : string := SLV_TO_HEX(PM_DATA1_BINARY, PM_DATA1_STRLEN);
    constant PM_DATA2_STRING : string := SLV_TO_HEX(PM_DATA2_BINARY, PM_DATA2_STRLEN);
    constant PM_DATA3_STRING : string := SLV_TO_HEX(PM_DATA3_BINARY, PM_DATA3_STRLEN);
    constant PM_DATA4_STRING : string := SLV_TO_HEX(PM_DATA4_BINARY, PM_DATA4_STRLEN);
    constant PM_DATA5_STRING : string := SLV_TO_HEX(PM_DATA5_BINARY, PM_DATA5_STRLEN);
    constant PM_DATA6_STRING : string := SLV_TO_HEX(PM_DATA6_BINARY, PM_DATA6_STRLEN);
    constant PM_DATA7_STRING : string := SLV_TO_HEX(PM_DATA7_BINARY, PM_DATA7_STRLEN);
    constant PM_DATA_SCALE0_STRING : string := SLV_TO_HEX(PM_DATA_SCALE0_BINARY, PM_DATA_SCALE0_STRLEN);
    constant PM_DATA_SCALE1_STRING : string := SLV_TO_HEX(PM_DATA_SCALE1_BINARY, PM_DATA_SCALE1_STRLEN);
    constant PM_DATA_SCALE2_STRING : string := SLV_TO_HEX(PM_DATA_SCALE2_BINARY, PM_DATA_SCALE2_STRLEN);
    constant PM_DATA_SCALE3_STRING : string := SLV_TO_HEX(PM_DATA_SCALE3_BINARY, PM_DATA_SCALE3_STRLEN);
    constant PM_DATA_SCALE4_STRING : string := SLV_TO_HEX(PM_DATA_SCALE4_BINARY, PM_DATA_SCALE4_STRLEN);
    constant PM_DATA_SCALE5_STRING : string := SLV_TO_HEX(PM_DATA_SCALE5_BINARY, PM_DATA_SCALE5_STRLEN);
    constant PM_DATA_SCALE6_STRING : string := SLV_TO_HEX(PM_DATA_SCALE6_BINARY, PM_DATA_SCALE6_STRLEN);
    constant PM_DATA_SCALE7_STRING : string := SLV_TO_HEX(PM_DATA_SCALE7_BINARY, PM_DATA_SCALE7_STRLEN);
    constant VC0_RX_RAM_LIMIT_STRING : string := SLV_TO_HEX(VC0_RX_RAM_LIMIT_BINARY, VC0_RX_RAM_LIMIT_STRLEN);
    
    -- Convert boolean to string
    constant DEV_CAP_EXT_TAG_SUPPORTED_STRING : string := boolean_to_string(DEV_CAP_EXT_TAG_SUPPORTED);
    constant DEV_CAP_ROLE_BASED_ERROR_STRING : string := boolean_to_string(DEV_CAP_ROLE_BASED_ERROR);
    constant DISABLE_BAR_FILTERING_STRING : string := boolean_to_string(DISABLE_BAR_FILTERING);
    constant DISABLE_ID_CHECK_STRING : string := boolean_to_string(DISABLE_ID_CHECK);
    constant DISABLE_SCRAMBLING_STRING : string := boolean_to_string(DISABLE_SCRAMBLING);
    constant ENABLE_RX_TD_ECRC_TRIM_STRING : string := boolean_to_string(ENABLE_RX_TD_ECRC_TRIM);
    constant FAST_TRAIN_STRING : string := boolean_to_string(FAST_TRAIN);
    constant LINK_STATUS_SLOT_CLOCK_CONFIG_STRING : string := boolean_to_string(LINK_STATUS_SLOT_CLOCK_CONFIG);
    constant LL_ACK_TIMEOUT_EN_STRING : string := boolean_to_string(LL_ACK_TIMEOUT_EN);
    constant LL_REPLAY_TIMEOUT_EN_STRING : string := boolean_to_string(LL_REPLAY_TIMEOUT_EN);
    constant PCIE_CAP_SLOT_IMPLEMENTED_STRING : string := boolean_to_string(PCIE_CAP_SLOT_IMPLEMENTED);
    constant PLM_AUTO_CONFIG_STRING : string := boolean_to_string(PLM_AUTO_CONFIG);
    constant PM_CAP_D1SUPPORT_STRING : string := boolean_to_string(PM_CAP_D1SUPPORT);
    constant PM_CAP_D2SUPPORT_STRING : string := boolean_to_string(PM_CAP_D2SUPPORT);
    constant PM_CAP_DSI_STRING : string := boolean_to_string(PM_CAP_DSI);
    constant PM_CAP_PME_CLOCK_STRING : string := boolean_to_string(PM_CAP_PME_CLOCK);
    constant SLOT_CAP_ATT_BUTTON_PRESENT_STRING : string := boolean_to_string(SLOT_CAP_ATT_BUTTON_PRESENT);
    constant SLOT_CAP_ATT_INDICATOR_PRESENT_STRING : string := boolean_to_string(SLOT_CAP_ATT_INDICATOR_PRESENT);
    constant SLOT_CAP_POWER_INDICATOR_PRESENT_STRING : string := boolean_to_string(SLOT_CAP_POWER_INDICATOR_PRESENT);
    constant TL_TFC_DISABLE_STRING : string := boolean_to_string(TL_TFC_DISABLE);
    constant TL_TX_CHECKS_DISABLE_STRING : string := boolean_to_string(TL_TX_CHECKS_DISABLE);
    constant USR_CFG_STRING : string := boolean_to_string(USR_CFG);
    constant USR_EXT_CFG_STRING : string := boolean_to_string(USR_EXT_CFG);
    constant VC0_CPL_INFINITE_STRING : string := boolean_to_string(VC0_CPL_INFINITE);
    
    signal DEV_CAP_ENDPOINT_L0S_LATENCY_BINARY : std_logic_vector(2 downto 0);
    signal DEV_CAP_ENDPOINT_L1_LATENCY_BINARY : std_logic_vector(2 downto 0);
    signal DEV_CAP_EXT_TAG_SUPPORTED_BINARY : std_ulogic;
    signal DEV_CAP_MAX_PAYLOAD_SUPPORTED_BINARY : std_logic_vector(2 downto 0);
    signal DEV_CAP_PHANTOM_FUNCTIONS_SUPPORT_BINARY : std_logic_vector(1 downto 0);
    signal DEV_CAP_ROLE_BASED_ERROR_BINARY : std_ulogic;
    signal DISABLE_BAR_FILTERING_BINARY : std_ulogic;
    signal DISABLE_ID_CHECK_BINARY : std_ulogic;
    signal DISABLE_SCRAMBLING_BINARY : std_ulogic;
    signal ENABLE_RX_TD_ECRC_TRIM_BINARY : std_ulogic;
    signal FAST_TRAIN_BINARY : std_ulogic;
    signal GTP_SEL_BINARY : std_ulogic;
    signal LINK_CAP_ASPM_SUPPORT_BINARY : std_logic_vector(1 downto 0);
    signal LINK_CAP_L0S_EXIT_LATENCY_BINARY : std_logic_vector(2 downto 0);
    signal LINK_CAP_L1_EXIT_LATENCY_BINARY : std_logic_vector(2 downto 0);
    signal LINK_STATUS_SLOT_CLOCK_CONFIG_BINARY : std_ulogic;
    signal LL_ACK_TIMEOUT_EN_BINARY : std_ulogic;
    signal LL_REPLAY_TIMEOUT_EN_BINARY : std_ulogic;
    signal MSI_CAP_MULTIMSGCAP_BINARY : std_logic_vector(2 downto 0);
    signal MSI_CAP_MULTIMSG_EXTENSION_BINARY : std_ulogic;
    signal PCIE_CAP_SLOT_IMPLEMENTED_BINARY : std_ulogic;
    signal PLM_AUTO_CONFIG_BINARY : std_ulogic;
    signal PM_CAP_AUXCURRENT_BINARY : std_logic_vector(2 downto 0);
    signal PM_CAP_D1SUPPORT_BINARY : std_ulogic;
    signal PM_CAP_D2SUPPORT_BINARY : std_ulogic;
    signal PM_CAP_DSI_BINARY : std_ulogic;
    signal PM_CAP_PME_CLOCK_BINARY : std_ulogic;
    signal PM_CAP_VERSION_BINARY : std_logic_vector(2 downto 0);
    signal SIM_VERSION_BINARY : std_ulogic;
    signal SLOT_CAP_ATT_BUTTON_PRESENT_BINARY : std_ulogic;
    signal SLOT_CAP_ATT_INDICATOR_PRESENT_BINARY : std_ulogic;
    signal SLOT_CAP_POWER_INDICATOR_PRESENT_BINARY : std_ulogic;
    signal TL_RX_RAM_RADDR_LATENCY_BINARY : std_ulogic;
    signal TL_RX_RAM_RDATA_LATENCY_BINARY : std_logic_vector(1 downto 0);
    signal TL_RX_RAM_WRITE_LATENCY_BINARY : std_ulogic;
    signal TL_TFC_DISABLE_BINARY : std_ulogic;
    signal TL_TX_CHECKS_DISABLE_BINARY : std_ulogic;
    signal TL_TX_RAM_RADDR_LATENCY_BINARY : std_ulogic;
    signal TL_TX_RAM_RDATA_LATENCY_BINARY : std_logic_vector(1 downto 0);
    signal USR_CFG_BINARY : std_ulogic;
    signal USR_EXT_CFG_BINARY : std_ulogic;
    signal VC0_CPL_INFINITE_BINARY : std_ulogic;
    signal VC0_TOTAL_CREDITS_CD_BINARY : std_logic_vector(10 downto 0);
    signal VC0_TOTAL_CREDITS_CH_BINARY : std_logic_vector(6 downto 0);
    signal VC0_TOTAL_CREDITS_NPH_BINARY : std_logic_vector(6 downto 0);
    signal VC0_TOTAL_CREDITS_PD_BINARY : std_logic_vector(10 downto 0);
    signal VC0_TOTAL_CREDITS_PH_BINARY : std_logic_vector(6 downto 0);
    signal VC0_TX_LASTPACKET_BINARY : std_logic_vector(4 downto 0);
    
    signal CFGBUSNUMBER_out : std_logic_vector(7 downto 0);
    signal CFGCOMMANDBUSMASTERENABLE_out : std_ulogic;
    signal CFGCOMMANDINTERRUPTDISABLE_out : std_ulogic;
    signal CFGCOMMANDIOENABLE_out : std_ulogic;
    signal CFGCOMMANDMEMENABLE_out : std_ulogic;
    signal CFGCOMMANDSERREN_out : std_ulogic;
    signal CFGDEVCONTROLAUXPOWEREN_out : std_ulogic;
    signal CFGDEVCONTROLCORRERRREPORTINGEN_out : std_ulogic;
    signal CFGDEVCONTROLENABLERO_out : std_ulogic;
    signal CFGDEVCONTROLEXTTAGEN_out : std_ulogic;
    signal CFGDEVCONTROLFATALERRREPORTINGEN_out : std_ulogic;
    signal CFGDEVCONTROLMAXPAYLOAD_out : std_logic_vector(2 downto 0);
    signal CFGDEVCONTROLMAXREADREQ_out : std_logic_vector(2 downto 0);
    signal CFGDEVCONTROLNONFATALREPORTINGEN_out : std_ulogic;
    signal CFGDEVCONTROLNOSNOOPEN_out : std_ulogic;
    signal CFGDEVCONTROLPHANTOMEN_out : std_ulogic;
    signal CFGDEVCONTROLURERRREPORTINGEN_out : std_ulogic;
    signal CFGDEVICENUMBER_out : std_logic_vector(4 downto 0);
    signal CFGDEVSTATUSCORRERRDETECTED_out : std_ulogic;
    signal CFGDEVSTATUSFATALERRDETECTED_out : std_ulogic;
    signal CFGDEVSTATUSNONFATALERRDETECTED_out : std_ulogic;
    signal CFGDEVSTATUSURDETECTED_out : std_ulogic;
    signal CFGDO_out : std_logic_vector(31 downto 0);
    signal CFGERRCPLRDYN_out : std_ulogic;
    signal CFGFUNCTIONNUMBER_out : std_logic_vector(2 downto 0);
    signal CFGINTERRUPTDO_out : std_logic_vector(7 downto 0);
    signal CFGINTERRUPTMMENABLE_out : std_logic_vector(2 downto 0);
    signal CFGINTERRUPTMSIENABLE_out : std_ulogic;
    signal CFGINTERRUPTRDYN_out : std_ulogic;
    signal CFGLINKCONTOLRCB_out : std_ulogic;
    signal CFGLINKCONTROLASPMCONTROL_out : std_logic_vector(1 downto 0);
    signal CFGLINKCONTROLCOMMONCLOCK_out : std_ulogic;
    signal CFGLINKCONTROLEXTENDEDSYNC_out : std_ulogic;
    signal CFGLTSSMSTATE_out : std_logic_vector(4 downto 0);
    signal CFGPCIELINKSTATEN_out : std_logic_vector(2 downto 0);
    signal CFGRDWRDONEN_out : std_ulogic;
    signal CFGTOTURNOFFN_out : std_ulogic;
    signal DBGBADDLLPSTATUS_out : std_ulogic;
    signal DBGBADTLPLCRC_out : std_ulogic;
    signal DBGBADTLPSEQNUM_out : std_ulogic;
    signal DBGBADTLPSTATUS_out : std_ulogic;
    signal DBGDLPROTOCOLSTATUS_out : std_ulogic;
    signal DBGFCPROTOCOLERRSTATUS_out : std_ulogic;
    signal DBGMLFRMDLENGTH_out : std_ulogic;
    signal DBGMLFRMDMPS_out : std_ulogic;
    signal DBGMLFRMDTCVC_out : std_ulogic;
    signal DBGMLFRMDTLPSTATUS_out : std_ulogic;
    signal DBGMLFRMDUNRECTYPE_out : std_ulogic;
    signal DBGPOISTLPSTATUS_out : std_ulogic;
    signal DBGRCVROVERFLOWSTATUS_out : std_ulogic;
    signal DBGREGDETECTEDCORRECTABLE_out : std_ulogic;
    signal DBGREGDETECTEDFATAL_out : std_ulogic;
    signal DBGREGDETECTEDNONFATAL_out : std_ulogic;
    signal DBGREGDETECTEDUNSUPPORTED_out : std_ulogic;
    signal DBGRPLYROLLOVERSTATUS_out : std_ulogic;
    signal DBGRPLYTIMEOUTSTATUS_out : std_ulogic;
    signal DBGURNOBARHIT_out : std_ulogic;
    signal DBGURPOISCFGWR_out : std_ulogic;
    signal DBGURSTATUS_out : std_ulogic;
    signal DBGURUNSUPMSG_out : std_ulogic;
    signal MIMRXRADDR_out : std_logic_vector(11 downto 0);
    signal MIMRXREN_out : std_ulogic;
    signal MIMRXWADDR_out : std_logic_vector(11 downto 0);
    signal MIMRXWDATA_out : std_logic_vector(34 downto 0);
    signal MIMRXWEN_out : std_ulogic;
    signal MIMTXRADDR_out : std_logic_vector(11 downto 0);
    signal MIMTXREN_out : std_ulogic;
    signal MIMTXWADDR_out : std_logic_vector(11 downto 0);
    signal MIMTXWDATA_out : std_logic_vector(35 downto 0);
    signal MIMTXWEN_out : std_ulogic;
    signal PIPEGTPOWERDOWNA_out : std_logic_vector(1 downto 0);
    signal PIPEGTPOWERDOWNB_out : std_logic_vector(1 downto 0);
    signal PIPEGTTXELECIDLEA_out : std_ulogic;
    signal PIPEGTTXELECIDLEB_out : std_ulogic;
    signal PIPERXPOLARITYA_out : std_ulogic;
    signal PIPERXPOLARITYB_out : std_ulogic;
    signal PIPERXRESETA_out : std_ulogic;
    signal PIPERXRESETB_out : std_ulogic;
    signal PIPETXCHARDISPMODEA_out : std_logic_vector(1 downto 0);
    signal PIPETXCHARDISPMODEB_out : std_logic_vector(1 downto 0);
    signal PIPETXCHARDISPVALA_out : std_logic_vector(1 downto 0);
    signal PIPETXCHARDISPVALB_out : std_logic_vector(1 downto 0);
    signal PIPETXCHARISKA_out : std_logic_vector(1 downto 0);
    signal PIPETXCHARISKB_out : std_logic_vector(1 downto 0);
    signal PIPETXDATAA_out : std_logic_vector(15 downto 0);
    signal PIPETXDATAB_out : std_logic_vector(15 downto 0);
    signal PIPETXRCVRDETA_out : std_ulogic;
    signal PIPETXRCVRDETB_out : std_ulogic;
    signal RECEIVEDHOTRESET_out : std_ulogic;
    signal TRNFCCPLD_out : std_logic_vector(11 downto 0);
    signal TRNFCCPLH_out : std_logic_vector(7 downto 0);
    signal TRNFCNPD_out : std_logic_vector(11 downto 0);
    signal TRNFCNPH_out : std_logic_vector(7 downto 0);
    signal TRNFCPD_out : std_logic_vector(11 downto 0);
    signal TRNFCPH_out : std_logic_vector(7 downto 0);
    signal TRNLNKUPN_out : std_ulogic;
    signal TRNRBARHITN_out : std_logic_vector(6 downto 0);
    signal TRNRD_out : std_logic_vector(31 downto 0);
    signal TRNREOFN_out : std_ulogic;
    signal TRNRERRFWDN_out : std_ulogic;
    signal TRNRSOFN_out : std_ulogic;
    signal TRNRSRCDSCN_out : std_ulogic;
    signal TRNRSRCRDYN_out : std_ulogic;
    signal TRNTBUFAV_out : std_logic_vector(5 downto 0);
    signal TRNTCFGREQN_out : std_ulogic;
    signal TRNTDSTRDYN_out : std_ulogic;
    signal TRNTERRDROPN_out : std_ulogic;
    signal USERRSTN_out : std_ulogic;
    
    signal CFGBUSNUMBER_outdelay : std_logic_vector(7 downto 0);
    signal CFGCOMMANDBUSMASTERENABLE_outdelay : std_ulogic;
    signal CFGCOMMANDINTERRUPTDISABLE_outdelay : std_ulogic;
    signal CFGCOMMANDIOENABLE_outdelay : std_ulogic;
    signal CFGCOMMANDMEMENABLE_outdelay : std_ulogic;
    signal CFGCOMMANDSERREN_outdelay : std_ulogic;
    signal CFGDEVCONTROLAUXPOWEREN_outdelay : std_ulogic;
    signal CFGDEVCONTROLCORRERRREPORTINGEN_outdelay : std_ulogic;
    signal CFGDEVCONTROLENABLERO_outdelay : std_ulogic;
    signal CFGDEVCONTROLEXTTAGEN_outdelay : std_ulogic;
    signal CFGDEVCONTROLFATALERRREPORTINGEN_outdelay : std_ulogic;
    signal CFGDEVCONTROLMAXPAYLOAD_outdelay : std_logic_vector(2 downto 0);
    signal CFGDEVCONTROLMAXREADREQ_outdelay : std_logic_vector(2 downto 0);
    signal CFGDEVCONTROLNONFATALREPORTINGEN_outdelay : std_ulogic;
    signal CFGDEVCONTROLNOSNOOPEN_outdelay : std_ulogic;
    signal CFGDEVCONTROLPHANTOMEN_outdelay : std_ulogic;
    signal CFGDEVCONTROLURERRREPORTINGEN_outdelay : std_ulogic;
    signal CFGDEVICENUMBER_outdelay : std_logic_vector(4 downto 0);
    signal CFGDEVSTATUSCORRERRDETECTED_outdelay : std_ulogic;
    signal CFGDEVSTATUSFATALERRDETECTED_outdelay : std_ulogic;
    signal CFGDEVSTATUSNONFATALERRDETECTED_outdelay : std_ulogic;
    signal CFGDEVSTATUSURDETECTED_outdelay : std_ulogic;
    signal CFGDO_outdelay : std_logic_vector(31 downto 0);
    signal CFGERRCPLRDYN_outdelay : std_ulogic;
    signal CFGFUNCTIONNUMBER_outdelay : std_logic_vector(2 downto 0);
    signal CFGINTERRUPTDO_outdelay : std_logic_vector(7 downto 0);
    signal CFGINTERRUPTMMENABLE_outdelay : std_logic_vector(2 downto 0);
    signal CFGINTERRUPTMSIENABLE_outdelay : std_ulogic;
    signal CFGINTERRUPTRDYN_outdelay : std_ulogic;
    signal CFGLINKCONTOLRCB_outdelay : std_ulogic;
    signal CFGLINKCONTROLASPMCONTROL_outdelay : std_logic_vector(1 downto 0);
    signal CFGLINKCONTROLCOMMONCLOCK_outdelay : std_ulogic;
    signal CFGLINKCONTROLEXTENDEDSYNC_outdelay : std_ulogic;
    signal CFGLTSSMSTATE_outdelay : std_logic_vector(4 downto 0);
    signal CFGPCIELINKSTATEN_outdelay : std_logic_vector(2 downto 0);
    signal CFGRDWRDONEN_outdelay : std_ulogic;
    signal CFGTOTURNOFFN_outdelay : std_ulogic;
    signal DBGBADDLLPSTATUS_outdelay : std_ulogic;
    signal DBGBADTLPLCRC_outdelay : std_ulogic;
    signal DBGBADTLPSEQNUM_outdelay : std_ulogic;
    signal DBGBADTLPSTATUS_outdelay : std_ulogic;
    signal DBGDLPROTOCOLSTATUS_outdelay : std_ulogic;
    signal DBGFCPROTOCOLERRSTATUS_outdelay : std_ulogic;
    signal DBGMLFRMDLENGTH_outdelay : std_ulogic;
    signal DBGMLFRMDMPS_outdelay : std_ulogic;
    signal DBGMLFRMDTCVC_outdelay : std_ulogic;
    signal DBGMLFRMDTLPSTATUS_outdelay : std_ulogic;
    signal DBGMLFRMDUNRECTYPE_outdelay : std_ulogic;
    signal DBGPOISTLPSTATUS_outdelay : std_ulogic;
    signal DBGRCVROVERFLOWSTATUS_outdelay : std_ulogic;
    signal DBGREGDETECTEDCORRECTABLE_outdelay : std_ulogic;
    signal DBGREGDETECTEDFATAL_outdelay : std_ulogic;
    signal DBGREGDETECTEDNONFATAL_outdelay : std_ulogic;
    signal DBGREGDETECTEDUNSUPPORTED_outdelay : std_ulogic;
    signal DBGRPLYROLLOVERSTATUS_outdelay : std_ulogic;
    signal DBGRPLYTIMEOUTSTATUS_outdelay : std_ulogic;
    signal DBGURNOBARHIT_outdelay : std_ulogic;
    signal DBGURPOISCFGWR_outdelay : std_ulogic;
    signal DBGURSTATUS_outdelay : std_ulogic;
    signal DBGURUNSUPMSG_outdelay : std_ulogic;
    signal MIMRXRADDR_outdelay : std_logic_vector(11 downto 0);
    signal MIMRXREN_outdelay : std_ulogic;
    signal MIMRXWADDR_outdelay : std_logic_vector(11 downto 0);
    signal MIMRXWDATA_outdelay : std_logic_vector(34 downto 0);
    signal MIMRXWEN_outdelay : std_ulogic;
    signal MIMTXRADDR_outdelay : std_logic_vector(11 downto 0);
    signal MIMTXREN_outdelay : std_ulogic;
    signal MIMTXWADDR_outdelay : std_logic_vector(11 downto 0);
    signal MIMTXWDATA_outdelay : std_logic_vector(35 downto 0);
    signal MIMTXWEN_outdelay : std_ulogic;
    signal PIPEGTPOWERDOWNA_outdelay : std_logic_vector(1 downto 0);
    signal PIPEGTPOWERDOWNB_outdelay : std_logic_vector(1 downto 0);
    signal PIPEGTTXELECIDLEA_outdelay : std_ulogic;
    signal PIPEGTTXELECIDLEB_outdelay : std_ulogic;
    signal PIPERXPOLARITYA_outdelay : std_ulogic;
    signal PIPERXPOLARITYB_outdelay : std_ulogic;
    signal PIPERXRESETA_outdelay : std_ulogic;
    signal PIPERXRESETB_outdelay : std_ulogic;
    signal PIPETXCHARDISPMODEA_outdelay : std_logic_vector(1 downto 0);
    signal PIPETXCHARDISPMODEB_outdelay : std_logic_vector(1 downto 0);
    signal PIPETXCHARDISPVALA_outdelay : std_logic_vector(1 downto 0);
    signal PIPETXCHARDISPVALB_outdelay : std_logic_vector(1 downto 0);
    signal PIPETXCHARISKA_outdelay : std_logic_vector(1 downto 0);
    signal PIPETXCHARISKB_outdelay : std_logic_vector(1 downto 0);
    signal PIPETXDATAA_outdelay : std_logic_vector(15 downto 0);
    signal PIPETXDATAB_outdelay : std_logic_vector(15 downto 0);
    signal PIPETXRCVRDETA_outdelay : std_ulogic;
    signal PIPETXRCVRDETB_outdelay : std_ulogic;
    signal RECEIVEDHOTRESET_outdelay : std_ulogic;
    signal TRNFCCPLD_outdelay : std_logic_vector(11 downto 0);
    signal TRNFCCPLH_outdelay : std_logic_vector(7 downto 0);
    signal TRNFCNPD_outdelay : std_logic_vector(11 downto 0);
    signal TRNFCNPH_outdelay : std_logic_vector(7 downto 0);
    signal TRNFCPD_outdelay : std_logic_vector(11 downto 0);
    signal TRNFCPH_outdelay : std_logic_vector(7 downto 0);
    signal TRNLNKUPN_outdelay : std_ulogic;
    signal TRNRBARHITN_outdelay : std_logic_vector(6 downto 0);
    signal TRNRD_outdelay : std_logic_vector(31 downto 0);
    signal TRNREOFN_outdelay : std_ulogic;
    signal TRNRERRFWDN_outdelay : std_ulogic;
    signal TRNRSOFN_outdelay : std_ulogic;
    signal TRNRSRCDSCN_outdelay : std_ulogic;
    signal TRNRSRCRDYN_outdelay : std_ulogic;
    signal TRNTBUFAV_outdelay : std_logic_vector(5 downto 0);
    signal TRNTCFGREQN_outdelay : std_ulogic;
    signal TRNTDSTRDYN_outdelay : std_ulogic;
    signal TRNTERRDROPN_outdelay : std_ulogic;
    signal USERRSTN_outdelay : std_ulogic;
    
    signal CFGDEVID_ipd : std_logic_vector(15 downto 0);
    signal CFGDSN_ipd : std_logic_vector(63 downto 0);
    signal CFGDWADDR_ipd : std_logic_vector(9 downto 0);
    signal CFGERRCORN_ipd : std_ulogic;
    signal CFGERRCPLABORTN_ipd : std_ulogic;
    signal CFGERRCPLTIMEOUTN_ipd : std_ulogic;
    signal CFGERRECRCN_ipd : std_ulogic;
    signal CFGERRLOCKEDN_ipd : std_ulogic;
    signal CFGERRPOSTEDN_ipd : std_ulogic;
    signal CFGERRTLPCPLHEADER_ipd : std_logic_vector(47 downto 0);
    signal CFGERRURN_ipd : std_ulogic;
    signal CFGINTERRUPTASSERTN_ipd : std_ulogic;
    signal CFGINTERRUPTDI_ipd : std_logic_vector(7 downto 0);
    signal CFGINTERRUPTN_ipd : std_ulogic;
    signal CFGPMWAKEN_ipd : std_ulogic;
    signal CFGRDENN_ipd : std_ulogic;
    signal CFGREVID_ipd : std_logic_vector(7 downto 0);
    signal CFGSUBSYSID_ipd : std_logic_vector(15 downto 0);
    signal CFGSUBSYSVENID_ipd : std_logic_vector(15 downto 0);
    signal CFGTRNPENDINGN_ipd : std_ulogic;
    signal CFGTURNOFFOKN_ipd : std_ulogic;
    signal CFGVENID_ipd : std_logic_vector(15 downto 0);
    signal CLOCKLOCKED_ipd : std_ulogic;
    signal MGTCLK_ipd : std_ulogic;
    signal MIMRXRDATA_ipd : std_logic_vector(34 downto 0);
    signal MIMTXRDATA_ipd : std_logic_vector(35 downto 0);
    signal PIPEGTRESETDONEA_ipd : std_ulogic;
    signal PIPEGTRESETDONEB_ipd : std_ulogic;
    signal PIPEPHYSTATUSA_ipd : std_ulogic;
    signal PIPEPHYSTATUSB_ipd : std_ulogic;
    signal PIPERXCHARISKA_ipd : std_logic_vector(1 downto 0);
    signal PIPERXCHARISKB_ipd : std_logic_vector(1 downto 0);
    signal PIPERXDATAA_ipd : std_logic_vector(15 downto 0);
    signal PIPERXDATAB_ipd : std_logic_vector(15 downto 0);
    signal PIPERXENTERELECIDLEA_ipd : std_ulogic;
    signal PIPERXENTERELECIDLEB_ipd : std_ulogic;
    signal PIPERXSTATUSA_ipd : std_logic_vector(2 downto 0);
    signal PIPERXSTATUSB_ipd : std_logic_vector(2 downto 0);
    signal SYSRESETN_ipd : std_ulogic;
    signal TRNFCSEL_ipd : std_logic_vector(2 downto 0);
    signal TRNRDSTRDYN_ipd : std_ulogic;
    signal TRNRNPOKN_ipd : std_ulogic;
    signal TRNTCFGGNTN_ipd : std_ulogic;
    signal TRNTD_ipd : std_logic_vector(31 downto 0);
    signal TRNTEOFN_ipd : std_ulogic;
    signal TRNTERRFWDN_ipd : std_ulogic;
    signal TRNTSOFN_ipd : std_ulogic;
    signal TRNTSRCDSCN_ipd : std_ulogic;
    signal TRNTSRCRDYN_ipd : std_ulogic;
    signal TRNTSTRN_ipd : std_ulogic;
    signal USERCLK_ipd : std_ulogic;
    
    signal CFGDEVID_USERCLK_dly : std_logic_vector(15 downto 0);
    signal CFGDSN_USERCLK_dly : std_logic_vector(63 downto 0);
    signal CFGDWADDR_USERCLK_dly : std_logic_vector(9 downto 0);
    signal CFGERRCORN_USERCLK_dly : std_ulogic;
    signal CFGERRCPLABORTN_USERCLK_dly : std_ulogic;
    signal CFGERRCPLTIMEOUTN_USERCLK_dly : std_ulogic;
    signal CFGERRECRCN_USERCLK_dly : std_ulogic;
    signal CFGERRLOCKEDN_USERCLK_dly : std_ulogic;
    signal CFGERRPOSTEDN_USERCLK_dly : std_ulogic;
    signal CFGERRTLPCPLHEADER_USERCLK_dly : std_logic_vector(47 downto 0);
    signal CFGERRURN_USERCLK_dly : std_ulogic;
    signal CFGINTERRUPTASSERTN_USERCLK_dly : std_ulogic;
    signal CFGINTERRUPTDI_USERCLK_dly : std_logic_vector(7 downto 0);
    signal CFGINTERRUPTN_USERCLK_dly : std_ulogic;
    signal CFGPMWAKEN_USERCLK_dly : std_ulogic;
    signal CFGRDENN_USERCLK_dly : std_ulogic;
    signal CFGREVID_USERCLK_dly : std_logic_vector(7 downto 0);
    signal CFGSUBSYSID_USERCLK_dly : std_logic_vector(15 downto 0);
    signal CFGSUBSYSVENID_USERCLK_dly : std_logic_vector(15 downto 0);
    signal CFGTRNPENDINGN_USERCLK_dly : std_ulogic;
    signal CFGTURNOFFOKN_USERCLK_dly : std_ulogic;
    signal CFGVENID_USERCLK_dly : std_logic_vector(15 downto 0);
    signal MGTCLK_dly : std_ulogic;
    signal MIMRXRDATA_USERCLK_dly : std_logic_vector(34 downto 0);
    signal MIMTXRDATA_USERCLK_dly : std_logic_vector(35 downto 0);
    signal PIPEGTRESETDONEA_MGTCLK_dly : std_ulogic;
    signal PIPEGTRESETDONEB_MGTCLK_dly : std_ulogic;
    signal PIPEPHYSTATUSA_MGTCLK_dly : std_ulogic;
    signal PIPEPHYSTATUSB_MGTCLK_dly : std_ulogic;
    signal PIPERXCHARISKA_MGTCLK_dly : std_logic_vector(1 downto 0);
    signal PIPERXCHARISKB_MGTCLK_dly : std_logic_vector(1 downto 0);
    signal PIPERXDATAA_MGTCLK_dly : std_logic_vector(15 downto 0);
    signal PIPERXDATAB_MGTCLK_dly : std_logic_vector(15 downto 0);
    signal PIPERXENTERELECIDLEA_MGTCLK_dly : std_ulogic;
    signal PIPERXENTERELECIDLEB_MGTCLK_dly : std_ulogic;
    signal PIPERXSTATUSA_MGTCLK_dly : std_logic_vector(2 downto 0);
    signal PIPERXSTATUSB_MGTCLK_dly : std_logic_vector(2 downto 0);
    signal TRNFCSEL_USERCLK_dly : std_logic_vector(2 downto 0);
    signal TRNRDSTRDYN_USERCLK_dly : std_ulogic;
    signal TRNRNPOKN_USERCLK_dly : std_ulogic;
    signal TRNTCFGGNTN_USERCLK_dly : std_ulogic;
    signal TRNTD_USERCLK_dly : std_logic_vector(31 downto 0);
    signal TRNTEOFN_USERCLK_dly : std_ulogic;
    signal TRNTERRFWDN_USERCLK_dly : std_ulogic;
    signal TRNTSOFN_USERCLK_dly : std_ulogic;
    signal TRNTSRCDSCN_USERCLK_dly : std_ulogic;
    signal TRNTSRCRDYN_USERCLK_dly : std_ulogic;
    signal TRNTSTRN_USERCLK_dly : std_ulogic;
    signal USERCLK_dly : std_ulogic;

    signal CFGDEVID_indelay : std_logic_vector(15 downto 0);
    signal CFGDSN_indelay : std_logic_vector(63 downto 0);
    signal CFGDWADDR_indelay : std_logic_vector(9 downto 0);
    signal CFGERRCORN_indelay : std_ulogic;
    signal CFGERRCPLABORTN_indelay : std_ulogic;
    signal CFGERRCPLTIMEOUTN_indelay : std_ulogic;
    signal CFGERRECRCN_indelay : std_ulogic;
    signal CFGERRLOCKEDN_indelay : std_ulogic;
    signal CFGERRPOSTEDN_indelay : std_ulogic;
    signal CFGERRTLPCPLHEADER_indelay : std_logic_vector(47 downto 0);
    signal CFGERRURN_indelay : std_ulogic;
    signal CFGINTERRUPTASSERTN_indelay : std_ulogic;
    signal CFGINTERRUPTDI_indelay : std_logic_vector(7 downto 0);
    signal CFGINTERRUPTN_indelay : std_ulogic;
    signal CFGPMWAKEN_indelay : std_ulogic;
    signal CFGRDENN_indelay : std_ulogic;
    signal CFGREVID_indelay : std_logic_vector(7 downto 0);
    signal CFGSUBSYSID_indelay : std_logic_vector(15 downto 0);
    signal CFGSUBSYSVENID_indelay : std_logic_vector(15 downto 0);
    signal CFGTRNPENDINGN_indelay : std_ulogic;
    signal CFGTURNOFFOKN_indelay : std_ulogic;
    signal CFGVENID_indelay : std_logic_vector(15 downto 0);
    signal CLOCKLOCKED_indelay : std_ulogic;
    signal MGTCLK_indelay : std_ulogic;
    signal MIMRXRDATA_indelay : std_logic_vector(34 downto 0);
    signal MIMTXRDATA_indelay : std_logic_vector(35 downto 0);
    signal PIPEGTRESETDONEA_indelay : std_ulogic;
    signal PIPEGTRESETDONEB_indelay : std_ulogic;
    signal PIPEPHYSTATUSA_indelay : std_ulogic;
    signal PIPEPHYSTATUSB_indelay : std_ulogic;
    signal PIPERXCHARISKA_indelay : std_logic_vector(1 downto 0);
    signal PIPERXCHARISKB_indelay : std_logic_vector(1 downto 0);
    signal PIPERXDATAA_indelay : std_logic_vector(15 downto 0);
    signal PIPERXDATAB_indelay : std_logic_vector(15 downto 0);
    signal PIPERXENTERELECIDLEA_indelay : std_ulogic;
    signal PIPERXENTERELECIDLEB_indelay : std_ulogic;
    signal PIPERXSTATUSA_indelay : std_logic_vector(2 downto 0);
    signal PIPERXSTATUSB_indelay : std_logic_vector(2 downto 0);
    signal SYSRESETN_indelay : std_ulogic;
    signal TRNFCSEL_indelay : std_logic_vector(2 downto 0);
    signal TRNRDSTRDYN_indelay : std_ulogic;
    signal TRNRNPOKN_indelay : std_ulogic;
    signal TRNTCFGGNTN_indelay : std_ulogic;
    signal TRNTD_indelay : std_logic_vector(31 downto 0);
    signal TRNTEOFN_indelay : std_ulogic;
    signal TRNTERRFWDN_indelay : std_ulogic;
    signal TRNTSOFN_indelay : std_ulogic;
    signal TRNTSRCDSCN_indelay : std_ulogic;
    signal TRNTSRCRDYN_indelay : std_ulogic;
    signal TRNTSTRN_indelay : std_ulogic;
    signal USERCLK_indelay : std_ulogic;
    
    signal GSR_dly : std_ulogic := '0';

    begin
    GSR_dly <= GSR;

    WireDelay : block
    begin
      CFGDEVID_DELAY : for i in 0 to 15 generate
        VitalWireDelay (CFGDEVID_ipd(i),CFGDEVID(i),tipd_CFGDEVID(i));
      end generate CFGDEVID_DELAY;
      CFGDSN_DELAY : for i in 0 to 63 generate
        VitalWireDelay (CFGDSN_ipd(i),CFGDSN(i),tipd_CFGDSN(i));
      end generate CFGDSN_DELAY;
      CFGDWADDR_DELAY : for i in 0 to 9 generate
        VitalWireDelay (CFGDWADDR_ipd(i),CFGDWADDR(i),tipd_CFGDWADDR(i));
      end generate CFGDWADDR_DELAY;
      CFGERRTLPCPLHEADER_DELAY : for i in 0 to 47 generate
        VitalWireDelay (CFGERRTLPCPLHEADER_ipd(i),CFGERRTLPCPLHEADER(i),tipd_CFGERRTLPCPLHEADER(i));
      end generate CFGERRTLPCPLHEADER_DELAY;
      CFGINTERRUPTDI_DELAY : for i in 0 to 7 generate
        VitalWireDelay (CFGINTERRUPTDI_ipd(i),CFGINTERRUPTDI(i),tipd_CFGINTERRUPTDI(i));
      end generate CFGINTERRUPTDI_DELAY;
      CFGREVID_DELAY : for i in 0 to 7 generate
        VitalWireDelay (CFGREVID_ipd(i),CFGREVID(i),tipd_CFGREVID(i));
      end generate CFGREVID_DELAY;
      CFGSUBSYSID_DELAY : for i in 0 to 15 generate
        VitalWireDelay (CFGSUBSYSID_ipd(i),CFGSUBSYSID(i),tipd_CFGSUBSYSID(i));
      end generate CFGSUBSYSID_DELAY;
      CFGSUBSYSVENID_DELAY : for i in 0 to 15 generate
        VitalWireDelay (CFGSUBSYSVENID_ipd(i),CFGSUBSYSVENID(i),tipd_CFGSUBSYSVENID(i));
      end generate CFGSUBSYSVENID_DELAY;
      CFGVENID_DELAY : for i in 0 to 15 generate
        VitalWireDelay (CFGVENID_ipd(i),CFGVENID(i),tipd_CFGVENID(i));
      end generate CFGVENID_DELAY;
      MIMRXRDATA_DELAY : for i in 0 to 34 generate
        VitalWireDelay (MIMRXRDATA_ipd(i),MIMRXRDATA(i),tipd_MIMRXRDATA(i));
      end generate MIMRXRDATA_DELAY;
      MIMTXRDATA_DELAY : for i in 0 to 35 generate
        VitalWireDelay (MIMTXRDATA_ipd(i),MIMTXRDATA(i),tipd_MIMTXRDATA(i));
      end generate MIMTXRDATA_DELAY;
      PIPERXCHARISKA_DELAY : for i in 0 to 1 generate
        VitalWireDelay (PIPERXCHARISKA_ipd(i),PIPERXCHARISKA(i),tipd_PIPERXCHARISKA(i));
      end generate PIPERXCHARISKA_DELAY;
      PIPERXCHARISKB_DELAY : for i in 0 to 1 generate
        VitalWireDelay (PIPERXCHARISKB_ipd(i),PIPERXCHARISKB(i),tipd_PIPERXCHARISKB(i));
      end generate PIPERXCHARISKB_DELAY;
      PIPERXDATAA_DELAY : for i in 0 to 15 generate
        VitalWireDelay (PIPERXDATAA_ipd(i),PIPERXDATAA(i),tipd_PIPERXDATAA(i));
      end generate PIPERXDATAA_DELAY;
      PIPERXDATAB_DELAY : for i in 0 to 15 generate
        VitalWireDelay (PIPERXDATAB_ipd(i),PIPERXDATAB(i),tipd_PIPERXDATAB(i));
      end generate PIPERXDATAB_DELAY;
      PIPERXSTATUSA_DELAY : for i in 0 to 2 generate
        VitalWireDelay (PIPERXSTATUSA_ipd(i),PIPERXSTATUSA(i),tipd_PIPERXSTATUSA(i));
      end generate PIPERXSTATUSA_DELAY;
      PIPERXSTATUSB_DELAY : for i in 0 to 2 generate
        VitalWireDelay (PIPERXSTATUSB_ipd(i),PIPERXSTATUSB(i),tipd_PIPERXSTATUSB(i));
      end generate PIPERXSTATUSB_DELAY;
      TRNFCSEL_DELAY : for i in 0 to 2 generate
        VitalWireDelay (TRNFCSEL_ipd(i),TRNFCSEL(i),tipd_TRNFCSEL(i));
      end generate TRNFCSEL_DELAY;
      TRNTD_DELAY : for i in 0 to 31 generate
        VitalWireDelay (TRNTD_ipd(i),TRNTD(i),tipd_TRNTD(i));
      end generate TRNTD_DELAY;
      VitalWireDelay (CFGERRCORN_ipd,CFGERRCORN,tipd_CFGERRCORN);
      VitalWireDelay (CFGERRCPLABORTN_ipd,CFGERRCPLABORTN,tipd_CFGERRCPLABORTN);
      VitalWireDelay (CFGERRCPLTIMEOUTN_ipd,CFGERRCPLTIMEOUTN,tipd_CFGERRCPLTIMEOUTN);
      VitalWireDelay (CFGERRECRCN_ipd,CFGERRECRCN,tipd_CFGERRECRCN);
      VitalWireDelay (CFGERRLOCKEDN_ipd,CFGERRLOCKEDN,tipd_CFGERRLOCKEDN);
      VitalWireDelay (CFGERRPOSTEDN_ipd,CFGERRPOSTEDN,tipd_CFGERRPOSTEDN);
      VitalWireDelay (CFGERRURN_ipd,CFGERRURN,tipd_CFGERRURN);
      VitalWireDelay (CFGINTERRUPTASSERTN_ipd,CFGINTERRUPTASSERTN,tipd_CFGINTERRUPTASSERTN);
      VitalWireDelay (CFGINTERRUPTN_ipd,CFGINTERRUPTN,tipd_CFGINTERRUPTN);
      VitalWireDelay (CFGPMWAKEN_ipd,CFGPMWAKEN,tipd_CFGPMWAKEN);
      VitalWireDelay (CFGRDENN_ipd,CFGRDENN,tipd_CFGRDENN);
      VitalWireDelay (CFGTRNPENDINGN_ipd,CFGTRNPENDINGN,tipd_CFGTRNPENDINGN);
      VitalWireDelay (CFGTURNOFFOKN_ipd,CFGTURNOFFOKN,tipd_CFGTURNOFFOKN);
      VitalWireDelay (CLOCKLOCKED_ipd,CLOCKLOCKED,tipd_CLOCKLOCKED);
      VitalWireDelay (MGTCLK_ipd,MGTCLK,tipd_MGTCLK);
      VitalWireDelay (PIPEGTRESETDONEA_ipd,PIPEGTRESETDONEA,tipd_PIPEGTRESETDONEA);
      VitalWireDelay (PIPEGTRESETDONEB_ipd,PIPEGTRESETDONEB,tipd_PIPEGTRESETDONEB);
      VitalWireDelay (PIPEPHYSTATUSA_ipd,PIPEPHYSTATUSA,tipd_PIPEPHYSTATUSA);
      VitalWireDelay (PIPEPHYSTATUSB_ipd,PIPEPHYSTATUSB,tipd_PIPEPHYSTATUSB);
      VitalWireDelay (PIPERXENTERELECIDLEA_ipd,PIPERXENTERELECIDLEA,tipd_PIPERXENTERELECIDLEA);
      VitalWireDelay (PIPERXENTERELECIDLEB_ipd,PIPERXENTERELECIDLEB,tipd_PIPERXENTERELECIDLEB);
      VitalWireDelay (SYSRESETN_ipd,SYSRESETN,tipd_SYSRESETN);
      VitalWireDelay (TRNRDSTRDYN_ipd,TRNRDSTRDYN,tipd_TRNRDSTRDYN);
      VitalWireDelay (TRNRNPOKN_ipd,TRNRNPOKN,tipd_TRNRNPOKN);
      VitalWireDelay (TRNTCFGGNTN_ipd,TRNTCFGGNTN,tipd_TRNTCFGGNTN);
      VitalWireDelay (TRNTEOFN_ipd,TRNTEOFN,tipd_TRNTEOFN);
      VitalWireDelay (TRNTERRFWDN_ipd,TRNTERRFWDN,tipd_TRNTERRFWDN);
      VitalWireDelay (TRNTSOFN_ipd,TRNTSOFN,tipd_TRNTSOFN);
      VitalWireDelay (TRNTSRCDSCN_ipd,TRNTSRCDSCN,tipd_TRNTSRCDSCN);
      VitalWireDelay (TRNTSRCRDYN_ipd,TRNTSRCRDYN,tipd_TRNTSRCRDYN);
      VitalWireDelay (TRNTSTRN_ipd,TRNTSTRN,tipd_TRNTSTRN);
      VitalWireDelay (USERCLK_ipd,USERCLK,tipd_USERCLK);
    end block;
    
    SignalDelay : block
    begin
      CFGDEVID_USERCLK_DELAY : for i in 15 downto 0 generate
        VitalSignalDelay (CFGDEVID_USERCLK_dly(i),CFGDEVID_ipd(i),tisd_CFGDEVID_USERCLK(i));
      end generate CFGDEVID_USERCLK_DELAY;
      CFGDSN_USERCLK_DELAY : for i in 63 downto 0 generate
        VitalSignalDelay (CFGDSN_USERCLK_dly(i),CFGDSN_ipd(i),tisd_CFGDSN_USERCLK(i));
      end generate CFGDSN_USERCLK_DELAY;
      CFGDWADDR_USERCLK_DELAY : for i in 9 downto 0 generate
        VitalSignalDelay (CFGDWADDR_USERCLK_dly(i),CFGDWADDR_ipd(i),tisd_CFGDWADDR_USERCLK(i));
      end generate CFGDWADDR_USERCLK_DELAY;
      CFGERRTLPCPLHEADER_USERCLK_DELAY : for i in 47 downto 0 generate
        VitalSignalDelay (CFGERRTLPCPLHEADER_USERCLK_dly(i),CFGERRTLPCPLHEADER_ipd(i),tisd_CFGERRTLPCPLHEADER_USERCLK(i));
      end generate CFGERRTLPCPLHEADER_USERCLK_DELAY;
      CFGINTERRUPTDI_USERCLK_DELAY : for i in 7 downto 0 generate
        VitalSignalDelay (CFGINTERRUPTDI_USERCLK_dly(i),CFGINTERRUPTDI_ipd(i),tisd_CFGINTERRUPTDI_USERCLK(i));
      end generate CFGINTERRUPTDI_USERCLK_DELAY;
      CFGREVID_USERCLK_DELAY : for i in 7 downto 0 generate
        VitalSignalDelay (CFGREVID_USERCLK_dly(i),CFGREVID_ipd(i),tisd_CFGREVID_USERCLK(i));
      end generate CFGREVID_USERCLK_DELAY;
      CFGSUBSYSID_USERCLK_DELAY : for i in 15 downto 0 generate
        VitalSignalDelay (CFGSUBSYSID_USERCLK_dly(i),CFGSUBSYSID_ipd(i),tisd_CFGSUBSYSID_USERCLK(i));
      end generate CFGSUBSYSID_USERCLK_DELAY;
      CFGSUBSYSVENID_USERCLK_DELAY : for i in 15 downto 0 generate
        VitalSignalDelay (CFGSUBSYSVENID_USERCLK_dly(i),CFGSUBSYSVENID_ipd(i),tisd_CFGSUBSYSVENID_USERCLK(i));
      end generate CFGSUBSYSVENID_USERCLK_DELAY;
      CFGVENID_USERCLK_DELAY : for i in 15 downto 0 generate
        VitalSignalDelay (CFGVENID_USERCLK_dly(i),CFGVENID_ipd(i),tisd_CFGVENID_USERCLK(i));
      end generate CFGVENID_USERCLK_DELAY;
      MIMRXRDATA_USERCLK_DELAY : for i in 34 downto 0 generate
        VitalSignalDelay (MIMRXRDATA_USERCLK_dly(i),MIMRXRDATA_ipd(i),tisd_MIMRXRDATA_USERCLK(i));
      end generate MIMRXRDATA_USERCLK_DELAY;
      MIMTXRDATA_USERCLK_DELAY : for i in 35 downto 0 generate
        VitalSignalDelay (MIMTXRDATA_USERCLK_dly(i),MIMTXRDATA_ipd(i),tisd_MIMTXRDATA_USERCLK(i));
      end generate MIMTXRDATA_USERCLK_DELAY;
      PIPERXCHARISKA_MGTCLK_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (PIPERXCHARISKA_MGTCLK_dly(i),PIPERXCHARISKA_ipd(i),tisd_PIPERXCHARISKA_MGTCLK(i));
      end generate PIPERXCHARISKA_MGTCLK_DELAY;
      PIPERXCHARISKB_MGTCLK_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (PIPERXCHARISKB_MGTCLK_dly(i),PIPERXCHARISKB_ipd(i),tisd_PIPERXCHARISKB_MGTCLK(i));
      end generate PIPERXCHARISKB_MGTCLK_DELAY;
      PIPERXDATAA_MGTCLK_DELAY : for i in 15 downto 0 generate
        VitalSignalDelay (PIPERXDATAA_MGTCLK_dly(i),PIPERXDATAA_ipd(i),tisd_PIPERXDATAA_MGTCLK(i));
      end generate PIPERXDATAA_MGTCLK_DELAY;
      PIPERXDATAB_MGTCLK_DELAY : for i in 15 downto 0 generate
        VitalSignalDelay (PIPERXDATAB_MGTCLK_dly(i),PIPERXDATAB_ipd(i),tisd_PIPERXDATAB_MGTCLK(i));
      end generate PIPERXDATAB_MGTCLK_DELAY;
      PIPERXSTATUSA_MGTCLK_DELAY : for i in 2 downto 0 generate
        VitalSignalDelay (PIPERXSTATUSA_MGTCLK_dly(i),PIPERXSTATUSA_ipd(i),tisd_PIPERXSTATUSA_MGTCLK(i));
      end generate PIPERXSTATUSA_MGTCLK_DELAY;
      PIPERXSTATUSB_MGTCLK_DELAY : for i in 2 downto 0 generate
        VitalSignalDelay (PIPERXSTATUSB_MGTCLK_dly(i),PIPERXSTATUSB_ipd(i),tisd_PIPERXSTATUSB_MGTCLK(i));
      end generate PIPERXSTATUSB_MGTCLK_DELAY;
      TRNFCSEL_USERCLK_DELAY : for i in 2 downto 0 generate
        VitalSignalDelay (TRNFCSEL_USERCLK_dly(i),TRNFCSEL_ipd(i),tisd_TRNFCSEL_USERCLK(i));
      end generate TRNFCSEL_USERCLK_DELAY;
      TRNTD_USERCLK_DELAY : for i in 31 downto 0 generate
        VitalSignalDelay (TRNTD_USERCLK_dly(i),TRNTD_ipd(i),tisd_TRNTD_USERCLK(i));
      end generate TRNTD_USERCLK_DELAY;
      VitalSignalDelay (CFGERRCORN_USERCLK_dly,CFGERRCORN_ipd,tisd_CFGERRCORN_USERCLK);
      VitalSignalDelay (CFGERRCPLABORTN_USERCLK_dly,CFGERRCPLABORTN_ipd,tisd_CFGERRCPLABORTN_USERCLK);
      VitalSignalDelay (CFGERRCPLTIMEOUTN_USERCLK_dly,CFGERRCPLTIMEOUTN_ipd,tisd_CFGERRCPLTIMEOUTN_USERCLK);
      VitalSignalDelay (CFGERRECRCN_USERCLK_dly,CFGERRECRCN_ipd,tisd_CFGERRECRCN_USERCLK);
      VitalSignalDelay (CFGERRLOCKEDN_USERCLK_dly,CFGERRLOCKEDN_ipd,tisd_CFGERRLOCKEDN_USERCLK);
      VitalSignalDelay (CFGERRPOSTEDN_USERCLK_dly,CFGERRPOSTEDN_ipd,tisd_CFGERRPOSTEDN_USERCLK);
      VitalSignalDelay (CFGERRURN_USERCLK_dly,CFGERRURN_ipd,tisd_CFGERRURN_USERCLK);
      VitalSignalDelay (CFGINTERRUPTASSERTN_USERCLK_dly,CFGINTERRUPTASSERTN_ipd,tisd_CFGINTERRUPTASSERTN_USERCLK);
      VitalSignalDelay (CFGINTERRUPTN_USERCLK_dly,CFGINTERRUPTN_ipd,tisd_CFGINTERRUPTN_USERCLK);
      VitalSignalDelay (CFGPMWAKEN_USERCLK_dly,CFGPMWAKEN_ipd,tisd_CFGPMWAKEN_USERCLK);
      VitalSignalDelay (CFGRDENN_USERCLK_dly,CFGRDENN_ipd,tisd_CFGRDENN_USERCLK);
      VitalSignalDelay (CFGTRNPENDINGN_USERCLK_dly,CFGTRNPENDINGN_ipd,tisd_CFGTRNPENDINGN_USERCLK);
      VitalSignalDelay (CFGTURNOFFOKN_USERCLK_dly,CFGTURNOFFOKN_ipd,tisd_CFGTURNOFFOKN_USERCLK);
      VitalSignalDelay (PIPEGTRESETDONEA_MGTCLK_dly,PIPEGTRESETDONEA_ipd,tisd_PIPEGTRESETDONEA_MGTCLK);
      VitalSignalDelay (PIPEGTRESETDONEB_MGTCLK_dly,PIPEGTRESETDONEB_ipd,tisd_PIPEGTRESETDONEB_MGTCLK);
      VitalSignalDelay (PIPEPHYSTATUSA_MGTCLK_dly,PIPEPHYSTATUSA_ipd,tisd_PIPEPHYSTATUSA_MGTCLK);
      VitalSignalDelay (PIPEPHYSTATUSB_MGTCLK_dly,PIPEPHYSTATUSB_ipd,tisd_PIPEPHYSTATUSB_MGTCLK);
      VitalSignalDelay (PIPERXENTERELECIDLEA_MGTCLK_dly,PIPERXENTERELECIDLEA_ipd,tisd_PIPERXENTERELECIDLEA_MGTCLK);
      VitalSignalDelay (PIPERXENTERELECIDLEB_MGTCLK_dly,PIPERXENTERELECIDLEB_ipd,tisd_PIPERXENTERELECIDLEB_MGTCLK);
      VitalSignalDelay (TRNRDSTRDYN_USERCLK_dly,TRNRDSTRDYN_ipd,tisd_TRNRDSTRDYN_USERCLK);
      VitalSignalDelay (TRNRNPOKN_USERCLK_dly,TRNRNPOKN_ipd,tisd_TRNRNPOKN_USERCLK);
      VitalSignalDelay (TRNTCFGGNTN_USERCLK_dly,TRNTCFGGNTN_ipd,tisd_TRNTCFGGNTN_USERCLK);
      VitalSignalDelay (TRNTEOFN_USERCLK_dly,TRNTEOFN_ipd,tisd_TRNTEOFN_USERCLK);
      VitalSignalDelay (TRNTERRFWDN_USERCLK_dly,TRNTERRFWDN_ipd,tisd_TRNTERRFWDN_USERCLK);
      VitalSignalDelay (TRNTSOFN_USERCLK_dly,TRNTSOFN_ipd,tisd_TRNTSOFN_USERCLK);
      VitalSignalDelay (TRNTSRCDSCN_USERCLK_dly,TRNTSRCDSCN_ipd,tisd_TRNTSRCDSCN_USERCLK);
      VitalSignalDelay (TRNTSRCRDYN_USERCLK_dly,TRNTSRCRDYN_ipd,tisd_TRNTSRCRDYN_USERCLK);
      VitalSignalDelay (TRNTSTRN_USERCLK_dly,TRNTSTRN_ipd,tisd_TRNTSTRN_USERCLK);

      VitalSignalDelay (MGTCLK_dly,MGTCLK_ipd,ticd_MGTCLK);
      VitalSignalDelay (USERCLK_dly,USERCLK_ipd,ticd_USERCLK);
    end block;
  --Input ports sensitive to single clock
  CFGDEVID_indelay <= CFGDEVID_USERCLK_dly;
  CFGDSN_indelay <= CFGDSN_USERCLK_dly;
  CFGDWADDR_indelay <= CFGDWADDR_USERCLK_dly;
  CFGERRCORN_indelay <= CFGERRCORN_USERCLK_dly;
  CFGERRCPLABORTN_indelay <= CFGERRCPLABORTN_USERCLK_dly;
  CFGERRCPLTIMEOUTN_indelay <= CFGERRCPLTIMEOUTN_USERCLK_dly;
  CFGERRECRCN_indelay <= CFGERRECRCN_USERCLK_dly;
  CFGERRLOCKEDN_indelay <= CFGERRLOCKEDN_USERCLK_dly;
  CFGERRPOSTEDN_indelay <= CFGERRPOSTEDN_USERCLK_dly;
  CFGERRTLPCPLHEADER_indelay <= CFGERRTLPCPLHEADER_USERCLK_dly;
  CFGERRURN_indelay <= CFGERRURN_USERCLK_dly;
  CFGINTERRUPTASSERTN_indelay <= CFGINTERRUPTASSERTN_USERCLK_dly;
  CFGINTERRUPTDI_indelay <= CFGINTERRUPTDI_USERCLK_dly;
  CFGINTERRUPTN_indelay <= CFGINTERRUPTN_USERCLK_dly;
  CFGPMWAKEN_indelay <= CFGPMWAKEN_USERCLK_dly;
  CFGRDENN_indelay <= CFGRDENN_USERCLK_dly;
  CFGREVID_indelay <= CFGREVID_USERCLK_dly;
  CFGSUBSYSID_indelay <= CFGSUBSYSID_USERCLK_dly;
  CFGSUBSYSVENID_indelay <= CFGSUBSYSVENID_USERCLK_dly;
  CFGTRNPENDINGN_indelay <= CFGTRNPENDINGN_USERCLK_dly;
  CFGTURNOFFOKN_indelay <= CFGTURNOFFOKN_USERCLK_dly;
  CFGVENID_indelay <= CFGVENID_USERCLK_dly;
  MIMRXRDATA_indelay <= MIMRXRDATA_USERCLK_dly;
  MIMTXRDATA_indelay <= MIMTXRDATA_USERCLK_dly;
  PIPEGTRESETDONEA_indelay <= PIPEGTRESETDONEA_MGTCLK_dly;
  PIPEGTRESETDONEB_indelay <= PIPEGTRESETDONEB_MGTCLK_dly;
  PIPEPHYSTATUSA_indelay <= PIPEPHYSTATUSA_MGTCLK_dly;
  PIPEPHYSTATUSB_indelay <= PIPEPHYSTATUSB_MGTCLK_dly;
  PIPERXCHARISKA_indelay <= PIPERXCHARISKA_MGTCLK_dly;
  PIPERXCHARISKB_indelay <= PIPERXCHARISKB_MGTCLK_dly;
  PIPERXDATAA_indelay <= PIPERXDATAA_MGTCLK_dly;
  PIPERXDATAB_indelay <= PIPERXDATAB_MGTCLK_dly;
  PIPERXENTERELECIDLEA_indelay <= PIPERXENTERELECIDLEA_MGTCLK_dly;
  PIPERXENTERELECIDLEB_indelay <= PIPERXENTERELECIDLEB_MGTCLK_dly;
  PIPERXSTATUSA_indelay <= PIPERXSTATUSA_MGTCLK_dly;
  PIPERXSTATUSB_indelay <= PIPERXSTATUSB_MGTCLK_dly;
  TRNFCSEL_indelay <= TRNFCSEL_USERCLK_dly;
  TRNRDSTRDYN_indelay <= TRNRDSTRDYN_USERCLK_dly;
  TRNRNPOKN_indelay <= TRNRNPOKN_USERCLK_dly;
  TRNTCFGGNTN_indelay <= TRNTCFGGNTN_USERCLK_dly;
  TRNTD_indelay <= TRNTD_USERCLK_dly;
  TRNTEOFN_indelay <= TRNTEOFN_USERCLK_dly;
  TRNTERRFWDN_indelay <= TRNTERRFWDN_USERCLK_dly;
  TRNTSOFN_indelay <= TRNTSOFN_USERCLK_dly;
  TRNTSRCDSCN_indelay <= TRNTSRCDSCN_USERCLK_dly;
  TRNTSRCRDYN_indelay <= TRNTSRCRDYN_USERCLK_dly;
  TRNTSTRN_indelay <= TRNTSTRN_USERCLK_dly;
  
  --Input ports sensitive to more than two clocks
  CLOCKLOCKED_indelay <= CLOCKLOCKED_ipd;
  SYSRESETN_indelay <= SYSRESETN_ipd;
  
  MGTCLK_indelay <= MGTCLK_dly;
  USERCLK_indelay <= USERCLK_dly;
  
  CFGBUSNUMBER_out <= CFGBUSNUMBER_outdelay after OUT_DELAY;
    CFGCOMMANDBUSMASTERENABLE_out <= CFGCOMMANDBUSMASTERENABLE_outdelay after OUT_DELAY;
    CFGCOMMANDINTERRUPTDISABLE_out <= CFGCOMMANDINTERRUPTDISABLE_outdelay after OUT_DELAY;
    CFGCOMMANDIOENABLE_out <= CFGCOMMANDIOENABLE_outdelay after OUT_DELAY;
    CFGCOMMANDMEMENABLE_out <= CFGCOMMANDMEMENABLE_outdelay after OUT_DELAY;
    CFGCOMMANDSERREN_out <= CFGCOMMANDSERREN_outdelay after OUT_DELAY;
    CFGDEVCONTROLAUXPOWEREN_out <= CFGDEVCONTROLAUXPOWEREN_outdelay after OUT_DELAY;
    CFGDEVCONTROLCORRERRREPORTINGEN_out <= CFGDEVCONTROLCORRERRREPORTINGEN_outdelay after OUT_DELAY;
    CFGDEVCONTROLENABLERO_out <= CFGDEVCONTROLENABLERO_outdelay after OUT_DELAY;
    CFGDEVCONTROLEXTTAGEN_out <= CFGDEVCONTROLEXTTAGEN_outdelay after OUT_DELAY;
    CFGDEVCONTROLFATALERRREPORTINGEN_out <= CFGDEVCONTROLFATALERRREPORTINGEN_outdelay after OUT_DELAY;
    CFGDEVCONTROLMAXPAYLOAD_out <= CFGDEVCONTROLMAXPAYLOAD_outdelay after OUT_DELAY;
    CFGDEVCONTROLMAXREADREQ_out <= CFGDEVCONTROLMAXREADREQ_outdelay after OUT_DELAY;
    CFGDEVCONTROLNONFATALREPORTINGEN_out <= CFGDEVCONTROLNONFATALREPORTINGEN_outdelay after OUT_DELAY;
    CFGDEVCONTROLNOSNOOPEN_out <= CFGDEVCONTROLNOSNOOPEN_outdelay after OUT_DELAY;
    CFGDEVCONTROLPHANTOMEN_out <= CFGDEVCONTROLPHANTOMEN_outdelay after OUT_DELAY;
    CFGDEVCONTROLURERRREPORTINGEN_out <= CFGDEVCONTROLURERRREPORTINGEN_outdelay after OUT_DELAY;
    CFGDEVICENUMBER_out <= CFGDEVICENUMBER_outdelay after OUT_DELAY;
    CFGDEVSTATUSCORRERRDETECTED_out <= CFGDEVSTATUSCORRERRDETECTED_outdelay after OUT_DELAY;
    CFGDEVSTATUSFATALERRDETECTED_out <= CFGDEVSTATUSFATALERRDETECTED_outdelay after OUT_DELAY;
    CFGDEVSTATUSNONFATALERRDETECTED_out <= CFGDEVSTATUSNONFATALERRDETECTED_outdelay after OUT_DELAY;
    CFGDEVSTATUSURDETECTED_out <= CFGDEVSTATUSURDETECTED_outdelay after OUT_DELAY;
    CFGDO_out <= CFGDO_outdelay after OUT_DELAY;
    CFGERRCPLRDYN_out <= CFGERRCPLRDYN_outdelay after OUT_DELAY;
    CFGFUNCTIONNUMBER_out <= CFGFUNCTIONNUMBER_outdelay after OUT_DELAY;
    CFGINTERRUPTDO_out <= CFGINTERRUPTDO_outdelay after OUT_DELAY;
    CFGINTERRUPTMMENABLE_out <= CFGINTERRUPTMMENABLE_outdelay after OUT_DELAY;
    CFGINTERRUPTMSIENABLE_out <= CFGINTERRUPTMSIENABLE_outdelay after OUT_DELAY;
    CFGINTERRUPTRDYN_out <= CFGINTERRUPTRDYN_outdelay after OUT_DELAY;
    CFGLINKCONTOLRCB_out <= CFGLINKCONTOLRCB_outdelay after OUT_DELAY;
    CFGLINKCONTROLASPMCONTROL_out <= CFGLINKCONTROLASPMCONTROL_outdelay after OUT_DELAY;
    CFGLINKCONTROLCOMMONCLOCK_out <= CFGLINKCONTROLCOMMONCLOCK_outdelay after OUT_DELAY;
    CFGLINKCONTROLEXTENDEDSYNC_out <= CFGLINKCONTROLEXTENDEDSYNC_outdelay after OUT_DELAY;
    CFGLTSSMSTATE_out <= CFGLTSSMSTATE_outdelay after OUT_DELAY;
    CFGPCIELINKSTATEN_out <= CFGPCIELINKSTATEN_outdelay after OUT_DELAY;
    CFGRDWRDONEN_out <= CFGRDWRDONEN_outdelay after OUT_DELAY;
    CFGTOTURNOFFN_out <= CFGTOTURNOFFN_outdelay after OUT_DELAY;
    DBGBADDLLPSTATUS_out <= DBGBADDLLPSTATUS_outdelay after OUT_DELAY;
    DBGBADTLPLCRC_out <= DBGBADTLPLCRC_outdelay after OUT_DELAY;
    DBGBADTLPSEQNUM_out <= DBGBADTLPSEQNUM_outdelay after OUT_DELAY;
    DBGBADTLPSTATUS_out <= DBGBADTLPSTATUS_outdelay after OUT_DELAY;
    DBGDLPROTOCOLSTATUS_out <= DBGDLPROTOCOLSTATUS_outdelay after OUT_DELAY;
    DBGFCPROTOCOLERRSTATUS_out <= DBGFCPROTOCOLERRSTATUS_outdelay after OUT_DELAY;
    DBGMLFRMDLENGTH_out <= DBGMLFRMDLENGTH_outdelay after OUT_DELAY;
    DBGMLFRMDMPS_out <= DBGMLFRMDMPS_outdelay after OUT_DELAY;
    DBGMLFRMDTCVC_out <= DBGMLFRMDTCVC_outdelay after OUT_DELAY;
    DBGMLFRMDTLPSTATUS_out <= DBGMLFRMDTLPSTATUS_outdelay after OUT_DELAY;
    DBGMLFRMDUNRECTYPE_out <= DBGMLFRMDUNRECTYPE_outdelay after OUT_DELAY;
    DBGPOISTLPSTATUS_out <= DBGPOISTLPSTATUS_outdelay after OUT_DELAY;
    DBGRCVROVERFLOWSTATUS_out <= DBGRCVROVERFLOWSTATUS_outdelay after OUT_DELAY;
    DBGREGDETECTEDCORRECTABLE_out <= DBGREGDETECTEDCORRECTABLE_outdelay after OUT_DELAY;
    DBGREGDETECTEDFATAL_out <= DBGREGDETECTEDFATAL_outdelay after OUT_DELAY;
    DBGREGDETECTEDNONFATAL_out <= DBGREGDETECTEDNONFATAL_outdelay after OUT_DELAY;
    DBGREGDETECTEDUNSUPPORTED_out <= DBGREGDETECTEDUNSUPPORTED_outdelay after OUT_DELAY;
    DBGRPLYROLLOVERSTATUS_out <= DBGRPLYROLLOVERSTATUS_outdelay after OUT_DELAY;
    DBGRPLYTIMEOUTSTATUS_out <= DBGRPLYTIMEOUTSTATUS_outdelay after OUT_DELAY;
    DBGURNOBARHIT_out <= DBGURNOBARHIT_outdelay after OUT_DELAY;
    DBGURPOISCFGWR_out <= DBGURPOISCFGWR_outdelay after OUT_DELAY;
    DBGURSTATUS_out <= DBGURSTATUS_outdelay after OUT_DELAY;
    DBGURUNSUPMSG_out <= DBGURUNSUPMSG_outdelay after OUT_DELAY;
    MIMRXRADDR_out <= MIMRXRADDR_outdelay after OUT_DELAY;
    MIMRXREN_out <= MIMRXREN_outdelay after OUT_DELAY;
    MIMRXWADDR_out <= MIMRXWADDR_outdelay after OUT_DELAY;
    MIMRXWDATA_out <= MIMRXWDATA_outdelay after OUT_DELAY;
    MIMRXWEN_out <= MIMRXWEN_outdelay after OUT_DELAY;
    MIMTXRADDR_out <= MIMTXRADDR_outdelay after OUT_DELAY;
    MIMTXREN_out <= MIMTXREN_outdelay after OUT_DELAY;
    MIMTXWADDR_out <= MIMTXWADDR_outdelay after OUT_DELAY;
    MIMTXWDATA_out <= MIMTXWDATA_outdelay after OUT_DELAY;
    MIMTXWEN_out <= MIMTXWEN_outdelay after OUT_DELAY;
    PIPEGTPOWERDOWNA_out <= PIPEGTPOWERDOWNA_outdelay after OUT_DELAY;
    PIPEGTPOWERDOWNB_out <= PIPEGTPOWERDOWNB_outdelay after OUT_DELAY;
    PIPEGTTXELECIDLEA_out <= PIPEGTTXELECIDLEA_outdelay after OUT_DELAY;
    PIPEGTTXELECIDLEB_out <= PIPEGTTXELECIDLEB_outdelay after OUT_DELAY;
    PIPERXPOLARITYA_out <= PIPERXPOLARITYA_outdelay after OUT_DELAY;
    PIPERXPOLARITYB_out <= PIPERXPOLARITYB_outdelay after OUT_DELAY;
    PIPERXRESETA_out <= PIPERXRESETA_outdelay after OUT_DELAY;
    PIPERXRESETB_out <= PIPERXRESETB_outdelay after OUT_DELAY;
    PIPETXCHARDISPMODEA_out <= PIPETXCHARDISPMODEA_outdelay after OUT_DELAY;
    PIPETXCHARDISPMODEB_out <= PIPETXCHARDISPMODEB_outdelay after OUT_DELAY;
    PIPETXCHARDISPVALA_out <= PIPETXCHARDISPVALA_outdelay after OUT_DELAY;
    PIPETXCHARDISPVALB_out <= PIPETXCHARDISPVALB_outdelay after OUT_DELAY;
    PIPETXCHARISKA_out <= PIPETXCHARISKA_outdelay after OUT_DELAY;
    PIPETXCHARISKB_out <= PIPETXCHARISKB_outdelay after OUT_DELAY;
    PIPETXDATAA_out <= PIPETXDATAA_outdelay after OUT_DELAY;
    PIPETXDATAB_out <= PIPETXDATAB_outdelay after OUT_DELAY;
    PIPETXRCVRDETA_out <= PIPETXRCVRDETA_outdelay after OUT_DELAY;
    PIPETXRCVRDETB_out <= PIPETXRCVRDETB_outdelay after OUT_DELAY;
    RECEIVEDHOTRESET_out <= RECEIVEDHOTRESET_outdelay after OUT_DELAY;
    TRNFCCPLD_out <= TRNFCCPLD_outdelay after OUT_DELAY;
    TRNFCCPLH_out <= TRNFCCPLH_outdelay after OUT_DELAY;
    TRNFCNPD_out <= TRNFCNPD_outdelay after OUT_DELAY;
    TRNFCNPH_out <= TRNFCNPH_outdelay after OUT_DELAY;
    TRNFCPD_out <= TRNFCPD_outdelay after OUT_DELAY;
    TRNFCPH_out <= TRNFCPH_outdelay after OUT_DELAY;
    TRNLNKUPN_out <= TRNLNKUPN_outdelay after OUT_DELAY;
    TRNRBARHITN_out <= TRNRBARHITN_outdelay after OUT_DELAY;
    TRNRD_out <= TRNRD_outdelay after OUT_DELAY;
    TRNREOFN_out <= TRNREOFN_outdelay after OUT_DELAY;
    TRNRERRFWDN_out <= TRNRERRFWDN_outdelay after OUT_DELAY;
    TRNRSOFN_out <= TRNRSOFN_outdelay after OUT_DELAY;
    TRNRSRCDSCN_out <= TRNRSRCDSCN_outdelay after OUT_DELAY;
    TRNRSRCRDYN_out <= TRNRSRCRDYN_outdelay after OUT_DELAY;
    TRNTBUFAV_out <= TRNTBUFAV_outdelay after OUT_DELAY;
    TRNTCFGREQN_out <= TRNTCFGREQN_outdelay after OUT_DELAY;
    TRNTDSTRDYN_out <= TRNTDSTRDYN_outdelay after OUT_DELAY;
    TRNTERRDROPN_out <= TRNTERRDROPN_outdelay after OUT_DELAY;
    USERRSTN_out <= USERRSTN_outdelay after OUT_DELAY;
    
    
    PCIE_A1_WRAP_INST : PCIE_A1_WRAP
      generic map (
        BAR0                 => BAR0_STRING,
        BAR1                 => BAR1_STRING,
        BAR2                 => BAR2_STRING,
        BAR3                 => BAR3_STRING,
        BAR4                 => BAR4_STRING,
        BAR5                 => BAR5_STRING,
        CARDBUS_CIS_POINTER  => CARDBUS_CIS_POINTER_STRING,
        CLASS_CODE           => CLASS_CODE_STRING,
        DEV_CAP_ENDPOINT_L0S_LATENCY => DEV_CAP_ENDPOINT_L0S_LATENCY,
        DEV_CAP_ENDPOINT_L1_LATENCY => DEV_CAP_ENDPOINT_L1_LATENCY,
        DEV_CAP_EXT_TAG_SUPPORTED => DEV_CAP_EXT_TAG_SUPPORTED_STRING,
        DEV_CAP_MAX_PAYLOAD_SUPPORTED => DEV_CAP_MAX_PAYLOAD_SUPPORTED,
        DEV_CAP_PHANTOM_FUNCTIONS_SUPPORT => DEV_CAP_PHANTOM_FUNCTIONS_SUPPORT,
        DEV_CAP_ROLE_BASED_ERROR => DEV_CAP_ROLE_BASED_ERROR_STRING,
        DISABLE_BAR_FILTERING => DISABLE_BAR_FILTERING_STRING,
        DISABLE_ID_CHECK     => DISABLE_ID_CHECK_STRING,
        DISABLE_SCRAMBLING   => DISABLE_SCRAMBLING_STRING,
        ENABLE_RX_TD_ECRC_TRIM => ENABLE_RX_TD_ECRC_TRIM_STRING,
        EXPANSION_ROM        => EXPANSION_ROM_STRING,
        FAST_TRAIN           => FAST_TRAIN_STRING,
        GTP_SEL              => GTP_SEL,
        LINK_CAP_ASPM_SUPPORT => LINK_CAP_ASPM_SUPPORT,
        LINK_CAP_L0S_EXIT_LATENCY => LINK_CAP_L0S_EXIT_LATENCY,
        LINK_CAP_L1_EXIT_LATENCY => LINK_CAP_L1_EXIT_LATENCY,
        LINK_STATUS_SLOT_CLOCK_CONFIG => LINK_STATUS_SLOT_CLOCK_CONFIG_STRING,
        LL_ACK_TIMEOUT       => LL_ACK_TIMEOUT_STRING,
        LL_ACK_TIMEOUT_EN    => LL_ACK_TIMEOUT_EN_STRING,
        LL_REPLAY_TIMEOUT    => LL_REPLAY_TIMEOUT_STRING,
        LL_REPLAY_TIMEOUT_EN => LL_REPLAY_TIMEOUT_EN_STRING,
        MSI_CAP_MULTIMSGCAP  => MSI_CAP_MULTIMSGCAP,
        MSI_CAP_MULTIMSG_EXTENSION => MSI_CAP_MULTIMSG_EXTENSION,
        PCIE_CAP_CAPABILITY_VERSION => PCIE_CAP_CAPABILITY_VERSION_STRING,
        PCIE_CAP_DEVICE_PORT_TYPE => PCIE_CAP_DEVICE_PORT_TYPE_STRING,
        PCIE_CAP_INT_MSG_NUM => PCIE_CAP_INT_MSG_NUM_STRING,
        PCIE_CAP_SLOT_IMPLEMENTED => PCIE_CAP_SLOT_IMPLEMENTED_STRING,
        PCIE_GENERIC         => PCIE_GENERIC_STRING,
        PLM_AUTO_CONFIG      => PLM_AUTO_CONFIG_STRING,
        PM_CAP_AUXCURRENT    => PM_CAP_AUXCURRENT,
        PM_CAP_D1SUPPORT     => PM_CAP_D1SUPPORT_STRING,
        PM_CAP_D2SUPPORT     => PM_CAP_D2SUPPORT_STRING,
        PM_CAP_DSI           => PM_CAP_DSI_STRING,
        PM_CAP_PMESUPPORT    => PM_CAP_PMESUPPORT_STRING,
        PM_CAP_PME_CLOCK     => PM_CAP_PME_CLOCK_STRING,
        PM_CAP_VERSION       => PM_CAP_VERSION,
        PM_DATA0             => PM_DATA0_STRING,
        PM_DATA1             => PM_DATA1_STRING,
        PM_DATA2             => PM_DATA2_STRING,
        PM_DATA3             => PM_DATA3_STRING,
        PM_DATA4             => PM_DATA4_STRING,
        PM_DATA5             => PM_DATA5_STRING,
        PM_DATA6             => PM_DATA6_STRING,
        PM_DATA7             => PM_DATA7_STRING,
        PM_DATA_SCALE0       => PM_DATA_SCALE0_STRING,
        PM_DATA_SCALE1       => PM_DATA_SCALE1_STRING,
        PM_DATA_SCALE2       => PM_DATA_SCALE2_STRING,
        PM_DATA_SCALE3       => PM_DATA_SCALE3_STRING,
        PM_DATA_SCALE4       => PM_DATA_SCALE4_STRING,
        PM_DATA_SCALE5       => PM_DATA_SCALE5_STRING,
        PM_DATA_SCALE6       => PM_DATA_SCALE6_STRING,
        PM_DATA_SCALE7       => PM_DATA_SCALE7_STRING,
        SIM_VERSION          => SIM_VERSION,
        SLOT_CAP_ATT_BUTTON_PRESENT => SLOT_CAP_ATT_BUTTON_PRESENT_STRING,
        SLOT_CAP_ATT_INDICATOR_PRESENT => SLOT_CAP_ATT_INDICATOR_PRESENT_STRING,
        SLOT_CAP_POWER_INDICATOR_PRESENT => SLOT_CAP_POWER_INDICATOR_PRESENT_STRING,
        TL_RX_RAM_RADDR_LATENCY => TL_RX_RAM_RADDR_LATENCY,
        TL_RX_RAM_RDATA_LATENCY => TL_RX_RAM_RDATA_LATENCY,
        TL_RX_RAM_WRITE_LATENCY => TL_RX_RAM_WRITE_LATENCY,
        TL_TFC_DISABLE       => TL_TFC_DISABLE_STRING,
        TL_TX_CHECKS_DISABLE => TL_TX_CHECKS_DISABLE_STRING,
        TL_TX_RAM_RADDR_LATENCY => TL_TX_RAM_RADDR_LATENCY,
        TL_TX_RAM_RDATA_LATENCY => TL_TX_RAM_RDATA_LATENCY,
        USR_CFG              => USR_CFG_STRING,
        USR_EXT_CFG          => USR_EXT_CFG_STRING,
        VC0_CPL_INFINITE     => VC0_CPL_INFINITE_STRING,
        VC0_RX_RAM_LIMIT     => VC0_RX_RAM_LIMIT_STRING,
        VC0_TOTAL_CREDITS_CD => VC0_TOTAL_CREDITS_CD,
        VC0_TOTAL_CREDITS_CH => VC0_TOTAL_CREDITS_CH,
        VC0_TOTAL_CREDITS_NPH => VC0_TOTAL_CREDITS_NPH,
        VC0_TOTAL_CREDITS_PD => VC0_TOTAL_CREDITS_PD,
        VC0_TOTAL_CREDITS_PH => VC0_TOTAL_CREDITS_PH,
        VC0_TX_LASTPACKET    => VC0_TX_LASTPACKET
      )
      
      port map (
        CFGBUSNUMBER         => CFGBUSNUMBER_outdelay,
        CFGCOMMANDBUSMASTERENABLE => CFGCOMMANDBUSMASTERENABLE_outdelay,
        CFGCOMMANDINTERRUPTDISABLE => CFGCOMMANDINTERRUPTDISABLE_outdelay,
        CFGCOMMANDIOENABLE   => CFGCOMMANDIOENABLE_outdelay,
        CFGCOMMANDMEMENABLE  => CFGCOMMANDMEMENABLE_outdelay,
        CFGCOMMANDSERREN     => CFGCOMMANDSERREN_outdelay,
        CFGDEVCONTROLAUXPOWEREN => CFGDEVCONTROLAUXPOWEREN_outdelay,
        CFGDEVCONTROLCORRERRREPORTINGEN => CFGDEVCONTROLCORRERRREPORTINGEN_outdelay,
        CFGDEVCONTROLENABLERO => CFGDEVCONTROLENABLERO_outdelay,
        CFGDEVCONTROLEXTTAGEN => CFGDEVCONTROLEXTTAGEN_outdelay,
        CFGDEVCONTROLFATALERRREPORTINGEN => CFGDEVCONTROLFATALERRREPORTINGEN_outdelay,
        CFGDEVCONTROLMAXPAYLOAD => CFGDEVCONTROLMAXPAYLOAD_outdelay,
        CFGDEVCONTROLMAXREADREQ => CFGDEVCONTROLMAXREADREQ_outdelay,
        CFGDEVCONTROLNONFATALREPORTINGEN => CFGDEVCONTROLNONFATALREPORTINGEN_outdelay,
        CFGDEVCONTROLNOSNOOPEN => CFGDEVCONTROLNOSNOOPEN_outdelay,
        CFGDEVCONTROLPHANTOMEN => CFGDEVCONTROLPHANTOMEN_outdelay,
        CFGDEVCONTROLURERRREPORTINGEN => CFGDEVCONTROLURERRREPORTINGEN_outdelay,
        CFGDEVICENUMBER      => CFGDEVICENUMBER_outdelay,
        CFGDEVSTATUSCORRERRDETECTED => CFGDEVSTATUSCORRERRDETECTED_outdelay,
        CFGDEVSTATUSFATALERRDETECTED => CFGDEVSTATUSFATALERRDETECTED_outdelay,
        CFGDEVSTATUSNONFATALERRDETECTED => CFGDEVSTATUSNONFATALERRDETECTED_outdelay,
        CFGDEVSTATUSURDETECTED => CFGDEVSTATUSURDETECTED_outdelay,
        CFGDO                => CFGDO_outdelay,
        CFGERRCPLRDYN        => CFGERRCPLRDYN_outdelay,
        CFGFUNCTIONNUMBER    => CFGFUNCTIONNUMBER_outdelay,
        CFGINTERRUPTDO       => CFGINTERRUPTDO_outdelay,
        CFGINTERRUPTMMENABLE => CFGINTERRUPTMMENABLE_outdelay,
        CFGINTERRUPTMSIENABLE => CFGINTERRUPTMSIENABLE_outdelay,
        CFGINTERRUPTRDYN     => CFGINTERRUPTRDYN_outdelay,
        CFGLINKCONTOLRCB     => CFGLINKCONTOLRCB_outdelay,
        CFGLINKCONTROLASPMCONTROL => CFGLINKCONTROLASPMCONTROL_outdelay,
        CFGLINKCONTROLCOMMONCLOCK => CFGLINKCONTROLCOMMONCLOCK_outdelay,
        CFGLINKCONTROLEXTENDEDSYNC => CFGLINKCONTROLEXTENDEDSYNC_outdelay,
        CFGLTSSMSTATE        => CFGLTSSMSTATE_outdelay,
        CFGPCIELINKSTATEN    => CFGPCIELINKSTATEN_outdelay,
        CFGRDWRDONEN         => CFGRDWRDONEN_outdelay,
        CFGTOTURNOFFN        => CFGTOTURNOFFN_outdelay,
        DBGBADDLLPSTATUS     => DBGBADDLLPSTATUS_outdelay,
        DBGBADTLPLCRC        => DBGBADTLPLCRC_outdelay,
        DBGBADTLPSEQNUM      => DBGBADTLPSEQNUM_outdelay,
        DBGBADTLPSTATUS      => DBGBADTLPSTATUS_outdelay,
        DBGDLPROTOCOLSTATUS  => DBGDLPROTOCOLSTATUS_outdelay,
        DBGFCPROTOCOLERRSTATUS => DBGFCPROTOCOLERRSTATUS_outdelay,
        DBGMLFRMDLENGTH      => DBGMLFRMDLENGTH_outdelay,
        DBGMLFRMDMPS         => DBGMLFRMDMPS_outdelay,
        DBGMLFRMDTCVC        => DBGMLFRMDTCVC_outdelay,
        DBGMLFRMDTLPSTATUS   => DBGMLFRMDTLPSTATUS_outdelay,
        DBGMLFRMDUNRECTYPE   => DBGMLFRMDUNRECTYPE_outdelay,
        DBGPOISTLPSTATUS     => DBGPOISTLPSTATUS_outdelay,
        DBGRCVROVERFLOWSTATUS => DBGRCVROVERFLOWSTATUS_outdelay,
        DBGREGDETECTEDCORRECTABLE => DBGREGDETECTEDCORRECTABLE_outdelay,
        DBGREGDETECTEDFATAL  => DBGREGDETECTEDFATAL_outdelay,
        DBGREGDETECTEDNONFATAL => DBGREGDETECTEDNONFATAL_outdelay,
        DBGREGDETECTEDUNSUPPORTED => DBGREGDETECTEDUNSUPPORTED_outdelay,
        DBGRPLYROLLOVERSTATUS => DBGRPLYROLLOVERSTATUS_outdelay,
        DBGRPLYTIMEOUTSTATUS => DBGRPLYTIMEOUTSTATUS_outdelay,
        DBGURNOBARHIT        => DBGURNOBARHIT_outdelay,
        DBGURPOISCFGWR       => DBGURPOISCFGWR_outdelay,
        DBGURSTATUS          => DBGURSTATUS_outdelay,
        DBGURUNSUPMSG        => DBGURUNSUPMSG_outdelay,
        MIMRXRADDR           => MIMRXRADDR_outdelay,
        MIMRXREN             => MIMRXREN_outdelay,
        MIMRXWADDR           => MIMRXWADDR_outdelay,
        MIMRXWDATA           => MIMRXWDATA_outdelay,
        MIMRXWEN             => MIMRXWEN_outdelay,
        MIMTXRADDR           => MIMTXRADDR_outdelay,
        MIMTXREN             => MIMTXREN_outdelay,
        MIMTXWADDR           => MIMTXWADDR_outdelay,
        MIMTXWDATA           => MIMTXWDATA_outdelay,
        MIMTXWEN             => MIMTXWEN_outdelay,
        PIPEGTPOWERDOWNA     => PIPEGTPOWERDOWNA_outdelay,
        PIPEGTPOWERDOWNB     => PIPEGTPOWERDOWNB_outdelay,
        PIPEGTTXELECIDLEA    => PIPEGTTXELECIDLEA_outdelay,
        PIPEGTTXELECIDLEB    => PIPEGTTXELECIDLEB_outdelay,
        PIPERXPOLARITYA      => PIPERXPOLARITYA_outdelay,
        PIPERXPOLARITYB      => PIPERXPOLARITYB_outdelay,
        PIPERXRESETA         => PIPERXRESETA_outdelay,
        PIPERXRESETB         => PIPERXRESETB_outdelay,
        PIPETXCHARDISPMODEA  => PIPETXCHARDISPMODEA_outdelay,
        PIPETXCHARDISPMODEB  => PIPETXCHARDISPMODEB_outdelay,
        PIPETXCHARDISPVALA   => PIPETXCHARDISPVALA_outdelay,
        PIPETXCHARDISPVALB   => PIPETXCHARDISPVALB_outdelay,
        PIPETXCHARISKA       => PIPETXCHARISKA_outdelay,
        PIPETXCHARISKB       => PIPETXCHARISKB_outdelay,
        PIPETXDATAA          => PIPETXDATAA_outdelay,
        PIPETXDATAB          => PIPETXDATAB_outdelay,
        PIPETXRCVRDETA       => PIPETXRCVRDETA_outdelay,
        PIPETXRCVRDETB       => PIPETXRCVRDETB_outdelay,
        RECEIVEDHOTRESET     => RECEIVEDHOTRESET_outdelay,
        TRNFCCPLD            => TRNFCCPLD_outdelay,
        TRNFCCPLH            => TRNFCCPLH_outdelay,
        TRNFCNPD             => TRNFCNPD_outdelay,
        TRNFCNPH             => TRNFCNPH_outdelay,
        TRNFCPD              => TRNFCPD_outdelay,
        TRNFCPH              => TRNFCPH_outdelay,
        TRNLNKUPN            => TRNLNKUPN_outdelay,
        TRNRBARHITN          => TRNRBARHITN_outdelay,
        TRNRD                => TRNRD_outdelay,
        TRNREOFN             => TRNREOFN_outdelay,
        TRNRERRFWDN          => TRNRERRFWDN_outdelay,
        TRNRSOFN             => TRNRSOFN_outdelay,
        TRNRSRCDSCN          => TRNRSRCDSCN_outdelay,
        TRNRSRCRDYN          => TRNRSRCRDYN_outdelay,
        TRNTBUFAV            => TRNTBUFAV_outdelay,
        TRNTCFGREQN          => TRNTCFGREQN_outdelay,
        TRNTDSTRDYN          => TRNTDSTRDYN_outdelay,
        TRNTERRDROPN         => TRNTERRDROPN_outdelay,
        USERRSTN             => USERRSTN_outdelay,
        GSR                  => GSR_dly,
        CFGDEVID             => CFGDEVID_indelay,
        CFGDSN               => CFGDSN_indelay,
        CFGDWADDR            => CFGDWADDR_indelay,
        CFGERRCORN           => CFGERRCORN_indelay,
        CFGERRCPLABORTN      => CFGERRCPLABORTN_indelay,
        CFGERRCPLTIMEOUTN    => CFGERRCPLTIMEOUTN_indelay,
        CFGERRECRCN          => CFGERRECRCN_indelay,
        CFGERRLOCKEDN        => CFGERRLOCKEDN_indelay,
        CFGERRPOSTEDN        => CFGERRPOSTEDN_indelay,
        CFGERRTLPCPLHEADER   => CFGERRTLPCPLHEADER_indelay,
        CFGERRURN            => CFGERRURN_indelay,
        CFGINTERRUPTASSERTN  => CFGINTERRUPTASSERTN_indelay,
        CFGINTERRUPTDI       => CFGINTERRUPTDI_indelay,
        CFGINTERRUPTN        => CFGINTERRUPTN_indelay,
        CFGPMWAKEN           => CFGPMWAKEN_indelay,
        CFGRDENN             => CFGRDENN_indelay,
        CFGREVID             => CFGREVID_indelay,
        CFGSUBSYSID          => CFGSUBSYSID_indelay,
        CFGSUBSYSVENID       => CFGSUBSYSVENID_indelay,
        CFGTRNPENDINGN       => CFGTRNPENDINGN_indelay,
        CFGTURNOFFOKN        => CFGTURNOFFOKN_indelay,
        CFGVENID             => CFGVENID_indelay,
        CLOCKLOCKED          => CLOCKLOCKED_indelay,
        MGTCLK               => MGTCLK_indelay,
        MIMRXRDATA           => MIMRXRDATA_indelay,
        MIMTXRDATA           => MIMTXRDATA_indelay,
        PIPEGTRESETDONEA     => PIPEGTRESETDONEA_indelay,
        PIPEGTRESETDONEB     => PIPEGTRESETDONEB_indelay,
        PIPEPHYSTATUSA       => PIPEPHYSTATUSA_indelay,
        PIPEPHYSTATUSB       => PIPEPHYSTATUSB_indelay,
        PIPERXCHARISKA       => PIPERXCHARISKA_indelay,
        PIPERXCHARISKB       => PIPERXCHARISKB_indelay,
        PIPERXDATAA          => PIPERXDATAA_indelay,
        PIPERXDATAB          => PIPERXDATAB_indelay,
        PIPERXENTERELECIDLEA => PIPERXENTERELECIDLEA_indelay,
        PIPERXENTERELECIDLEB => PIPERXENTERELECIDLEB_indelay,
        PIPERXSTATUSA        => PIPERXSTATUSA_indelay,
        PIPERXSTATUSB        => PIPERXSTATUSB_indelay,
        SYSRESETN            => SYSRESETN_indelay,
        TRNFCSEL             => TRNFCSEL_indelay,
        TRNRDSTRDYN          => TRNRDSTRDYN_indelay,
        TRNRNPOKN            => TRNRNPOKN_indelay,
        TRNTCFGGNTN          => TRNTCFGGNTN_indelay,
        TRNTD                => TRNTD_indelay,
        TRNTEOFN             => TRNTEOFN_indelay,
        TRNTERRFWDN          => TRNTERRFWDN_indelay,
        TRNTSOFN             => TRNTSOFN_indelay,
        TRNTSRCDSCN          => TRNTSRCDSCN_indelay,
        TRNTSRCRDYN          => TRNTSRCRDYN_indelay,
        TRNTSTRN             => TRNTSTRN_indelay,
        USERCLK              => USERCLK_indelay        
      );

  --------------------
  --  BEHAVIOR SECTION
  --------------------
--####################################################################
--#####                     Initialize                           #####
--####################################################################
    INIPROC : process
    begin
  -- case SIM_VERSION is
    if((SIM_VERSION = "1.0") or (SIM_VERSION = "1.0")) then
      SIM_VERSION_BINARY <= '0';
    elsif((SIM_VERSION = "2.0") or (SIM_VERSION= "2.0")) then
      SIM_VERSION_BINARY <= '0';
    elsif((SIM_VERSION = "3.0") or (SIM_VERSION= "3.0")) then
      SIM_VERSION_BINARY <= '0';
    elsif((SIM_VERSION = "4.0") or (SIM_VERSION= "4.0")) then
      SIM_VERSION_BINARY <= '0';
    elsif((SIM_VERSION = "5.0") or (SIM_VERSION= "5.0")) then
      SIM_VERSION_BINARY <= '0';
    elsif((SIM_VERSION = "6.0") or (SIM_VERSION= "6.0")) then
      SIM_VERSION_BINARY <= '0';
    else
      assert FALSE report "Error : SIM_VERSION = is not 1.0, 2.0, 3.0, 4.0, 5.0, 6.0." severity error;
    end if;
  -- end case;
    case DEV_CAP_EXT_TAG_SUPPORTED is
      when FALSE   =>  DEV_CAP_EXT_TAG_SUPPORTED_BINARY <= '0';
      when TRUE    =>  DEV_CAP_EXT_TAG_SUPPORTED_BINARY <= '1';
      when others  =>  assert FALSE report "Error : DEV_CAP_EXT_TAG_SUPPORTED is neither TRUE nor FALSE." severity error;
    end case;
    case DEV_CAP_ROLE_BASED_ERROR is
      when FALSE   =>  DEV_CAP_ROLE_BASED_ERROR_BINARY <= '0';
      when TRUE    =>  DEV_CAP_ROLE_BASED_ERROR_BINARY <= '1';
      when others  =>  assert FALSE report "Error : DEV_CAP_ROLE_BASED_ERROR is neither TRUE nor FALSE." severity error;
    end case;
    case DISABLE_BAR_FILTERING is
      when FALSE   =>  DISABLE_BAR_FILTERING_BINARY <= '0';
      when TRUE    =>  DISABLE_BAR_FILTERING_BINARY <= '1';
      when others  =>  assert FALSE report "Error : DISABLE_BAR_FILTERING is neither TRUE nor FALSE." severity error;
    end case;
    case DISABLE_ID_CHECK is
      when FALSE   =>  DISABLE_ID_CHECK_BINARY <= '0';
      when TRUE    =>  DISABLE_ID_CHECK_BINARY <= '1';
      when others  =>  assert FALSE report "Error : DISABLE_ID_CHECK is neither TRUE nor FALSE." severity error;
    end case;
    case DISABLE_SCRAMBLING is
      when FALSE   =>  DISABLE_SCRAMBLING_BINARY <= '0';
      when TRUE    =>  DISABLE_SCRAMBLING_BINARY <= '1';
      when others  =>  assert FALSE report "Error : DISABLE_SCRAMBLING is neither TRUE nor FALSE." severity error;
    end case;
    case ENABLE_RX_TD_ECRC_TRIM is
      when FALSE   =>  ENABLE_RX_TD_ECRC_TRIM_BINARY <= '0';
      when TRUE    =>  ENABLE_RX_TD_ECRC_TRIM_BINARY <= '1';
      when others  =>  assert FALSE report "Error : ENABLE_RX_TD_ECRC_TRIM is neither TRUE nor FALSE." severity error;
    end case;
    case FAST_TRAIN is
      when FALSE   =>  FAST_TRAIN_BINARY <= '0';
      when TRUE    =>  FAST_TRAIN_BINARY <= '1';
      when others  =>  assert FALSE report "Error : FAST_TRAIN is neither TRUE nor FALSE." severity error;
    end case;
    case GTP_SEL is
      when  0   =>  GTP_SEL_BINARY <= '0';
      when  1   =>  GTP_SEL_BINARY <= '1';
      when others  =>  assert FALSE report "Error : GTP_SEL is not in range 0 .. 1." severity error;
    end case;
    case LINK_STATUS_SLOT_CLOCK_CONFIG is
      when FALSE   =>  LINK_STATUS_SLOT_CLOCK_CONFIG_BINARY <= '0';
      when TRUE    =>  LINK_STATUS_SLOT_CLOCK_CONFIG_BINARY <= '1';
      when others  =>  assert FALSE report "Error : LINK_STATUS_SLOT_CLOCK_CONFIG is neither TRUE nor FALSE." severity error;
    end case;
    case LL_ACK_TIMEOUT_EN is
      when FALSE   =>  LL_ACK_TIMEOUT_EN_BINARY <= '0';
      when TRUE    =>  LL_ACK_TIMEOUT_EN_BINARY <= '1';
      when others  =>  assert FALSE report "Error : LL_ACK_TIMEOUT_EN is neither TRUE nor FALSE." severity error;
    end case;
    case LL_REPLAY_TIMEOUT_EN is
      when FALSE   =>  LL_REPLAY_TIMEOUT_EN_BINARY <= '0';
      when TRUE    =>  LL_REPLAY_TIMEOUT_EN_BINARY <= '1';
      when others  =>  assert FALSE report "Error : LL_REPLAY_TIMEOUT_EN is neither TRUE nor FALSE." severity error;
    end case;
    case MSI_CAP_MULTIMSG_EXTENSION is
      when  0   =>  MSI_CAP_MULTIMSG_EXTENSION_BINARY <= '0';
      when  1   =>  MSI_CAP_MULTIMSG_EXTENSION_BINARY <= '1';
      when others  =>  assert FALSE report "Error : MSI_CAP_MULTIMSG_EXTENSION is not in range 0 .. 1." severity error;
    end case;
    case PCIE_CAP_SLOT_IMPLEMENTED is
      when FALSE   =>  PCIE_CAP_SLOT_IMPLEMENTED_BINARY <= '0';
      when TRUE    =>  PCIE_CAP_SLOT_IMPLEMENTED_BINARY <= '1';
      when others  =>  assert FALSE report "Error : PCIE_CAP_SLOT_IMPLEMENTED is neither TRUE nor FALSE." severity error;
    end case;
    case PLM_AUTO_CONFIG is
      when FALSE   =>  PLM_AUTO_CONFIG_BINARY <= '0';
      when TRUE    =>  PLM_AUTO_CONFIG_BINARY <= '1';
      when others  =>  assert FALSE report "Error : PLM_AUTO_CONFIG is neither TRUE nor FALSE." severity error;
    end case;
    case PM_CAP_D1SUPPORT is
      when FALSE   =>  PM_CAP_D1SUPPORT_BINARY <= '0';
      when TRUE    =>  PM_CAP_D1SUPPORT_BINARY <= '1';
      when others  =>  assert FALSE report "Error : PM_CAP_D1SUPPORT is neither TRUE nor FALSE." severity error;
    end case;
    case PM_CAP_D2SUPPORT is
      when FALSE   =>  PM_CAP_D2SUPPORT_BINARY <= '0';
      when TRUE    =>  PM_CAP_D2SUPPORT_BINARY <= '1';
      when others  =>  assert FALSE report "Error : PM_CAP_D2SUPPORT is neither TRUE nor FALSE." severity error;
    end case;
    case PM_CAP_DSI is
      when FALSE   =>  PM_CAP_DSI_BINARY <= '0';
      when TRUE    =>  PM_CAP_DSI_BINARY <= '1';
      when others  =>  assert FALSE report "Error : PM_CAP_DSI is neither TRUE nor FALSE." severity error;
    end case;
    case PM_CAP_PME_CLOCK is
      when FALSE   =>  PM_CAP_PME_CLOCK_BINARY <= '0';
      when TRUE    =>  PM_CAP_PME_CLOCK_BINARY <= '1';
      when others  =>  assert FALSE report "Error : PM_CAP_PME_CLOCK is neither TRUE nor FALSE." severity error;
    end case;
    case SLOT_CAP_ATT_BUTTON_PRESENT is
      when FALSE   =>  SLOT_CAP_ATT_BUTTON_PRESENT_BINARY <= '0';
      when TRUE    =>  SLOT_CAP_ATT_BUTTON_PRESENT_BINARY <= '1';
      when others  =>  assert FALSE report "Error : SLOT_CAP_ATT_BUTTON_PRESENT is neither TRUE nor FALSE." severity error;
    end case;
    case SLOT_CAP_ATT_INDICATOR_PRESENT is
      when FALSE   =>  SLOT_CAP_ATT_INDICATOR_PRESENT_BINARY <= '0';
      when TRUE    =>  SLOT_CAP_ATT_INDICATOR_PRESENT_BINARY <= '1';
      when others  =>  assert FALSE report "Error : SLOT_CAP_ATT_INDICATOR_PRESENT is neither TRUE nor FALSE." severity error;
    end case;
    case SLOT_CAP_POWER_INDICATOR_PRESENT is
      when FALSE   =>  SLOT_CAP_POWER_INDICATOR_PRESENT_BINARY <= '0';
      when TRUE    =>  SLOT_CAP_POWER_INDICATOR_PRESENT_BINARY <= '1';
      when others  =>  assert FALSE report "Error : SLOT_CAP_POWER_INDICATOR_PRESENT is neither TRUE nor FALSE." severity error;
    end case;
    case TL_RX_RAM_RADDR_LATENCY is
      when  0   =>  TL_RX_RAM_RADDR_LATENCY_BINARY <= '0';
      when  1   =>  TL_RX_RAM_RADDR_LATENCY_BINARY <= '1';
      when others  =>  assert FALSE report "Error : TL_RX_RAM_RADDR_LATENCY is not in range 0 .. 1." severity error;
    end case;
    case TL_RX_RAM_WRITE_LATENCY is
      when  0   =>  TL_RX_RAM_WRITE_LATENCY_BINARY <= '0';
      when  1   =>  TL_RX_RAM_WRITE_LATENCY_BINARY <= '1';
      when others  =>  assert FALSE report "Error : TL_RX_RAM_WRITE_LATENCY is not in range 0 .. 1." severity error;
    end case;
    case TL_TFC_DISABLE is
      when FALSE   =>  TL_TFC_DISABLE_BINARY <= '0';
      when TRUE    =>  TL_TFC_DISABLE_BINARY <= '1';
      when others  =>  assert FALSE report "Error : TL_TFC_DISABLE is neither TRUE nor FALSE." severity error;
    end case;
    case TL_TX_CHECKS_DISABLE is
      when FALSE   =>  TL_TX_CHECKS_DISABLE_BINARY <= '0';
      when TRUE    =>  TL_TX_CHECKS_DISABLE_BINARY <= '1';
      when others  =>  assert FALSE report "Error : TL_TX_CHECKS_DISABLE is neither TRUE nor FALSE." severity error;
    end case;
    case TL_TX_RAM_RADDR_LATENCY is
      when  0   =>  TL_TX_RAM_RADDR_LATENCY_BINARY <= '0';
      when  1   =>  TL_TX_RAM_RADDR_LATENCY_BINARY <= '1';
      when others  =>  assert FALSE report "Error : TL_TX_RAM_RADDR_LATENCY is not in range 0 .. 1." severity error;
    end case;
    case USR_CFG is
      when FALSE   =>  USR_CFG_BINARY <= '0';
      when TRUE    =>  USR_CFG_BINARY <= '1';
      when others  =>  assert FALSE report "Error : USR_CFG is neither TRUE nor FALSE." severity error;
    end case;
    case USR_EXT_CFG is
      when FALSE   =>  USR_EXT_CFG_BINARY <= '0';
      when TRUE    =>  USR_EXT_CFG_BINARY <= '1';
      when others  =>  assert FALSE report "Error : USR_EXT_CFG is neither TRUE nor FALSE." severity error;
    end case;
    case VC0_CPL_INFINITE is
      when FALSE   =>  VC0_CPL_INFINITE_BINARY <= '0';
      when TRUE    =>  VC0_CPL_INFINITE_BINARY <= '1';
      when others  =>  assert FALSE report "Error : VC0_CPL_INFINITE is neither TRUE nor FALSE." severity error;
    end case;
    if ((DEV_CAP_ENDPOINT_L0S_LATENCY >= 0) and (DEV_CAP_ENDPOINT_L0S_LATENCY <= 7)) then
      DEV_CAP_ENDPOINT_L0S_LATENCY_BINARY <= std_logic_vector(to_unsigned(DEV_CAP_ENDPOINT_L0S_LATENCY, 3));
    else
      assert FALSE report "Error : DEV_CAP_ENDPOINT_L0S_LATENCY is not in range 0 .. 7." severity error;
    end if;
    if ((DEV_CAP_ENDPOINT_L1_LATENCY >= 0) and (DEV_CAP_ENDPOINT_L1_LATENCY <= 7)) then
      DEV_CAP_ENDPOINT_L1_LATENCY_BINARY <= std_logic_vector(to_unsigned(DEV_CAP_ENDPOINT_L1_LATENCY, 3));
    else
      assert FALSE report "Error : DEV_CAP_ENDPOINT_L1_LATENCY is not in range 0 .. 7." severity error;
    end if;
    if ((DEV_CAP_MAX_PAYLOAD_SUPPORTED >= 0) and (DEV_CAP_MAX_PAYLOAD_SUPPORTED <= 7)) then
      DEV_CAP_MAX_PAYLOAD_SUPPORTED_BINARY <= std_logic_vector(to_unsigned(DEV_CAP_MAX_PAYLOAD_SUPPORTED, 3));
    else
      assert FALSE report "Error : DEV_CAP_MAX_PAYLOAD_SUPPORTED is not in range 0 .. 7." severity error;
    end if;
    if ((DEV_CAP_PHANTOM_FUNCTIONS_SUPPORT >= 0) and (DEV_CAP_PHANTOM_FUNCTIONS_SUPPORT <= 3)) then
      DEV_CAP_PHANTOM_FUNCTIONS_SUPPORT_BINARY <= std_logic_vector(to_unsigned(DEV_CAP_PHANTOM_FUNCTIONS_SUPPORT, 2));
    else
      assert FALSE report "Error : DEV_CAP_PHANTOM_FUNCTIONS_SUPPORT is not in range 0 .. 3." severity error;
    end if;
    if ((LINK_CAP_ASPM_SUPPORT >= 0) and (LINK_CAP_ASPM_SUPPORT <= 3)) then
      LINK_CAP_ASPM_SUPPORT_BINARY <= std_logic_vector(to_unsigned(LINK_CAP_ASPM_SUPPORT, 2));
    else
      assert FALSE report "Error : LINK_CAP_ASPM_SUPPORT is not in range 0 .. 3." severity error;
    end if;
    if ((LINK_CAP_L0S_EXIT_LATENCY >= 0) and (LINK_CAP_L0S_EXIT_LATENCY <= 7)) then
      LINK_CAP_L0S_EXIT_LATENCY_BINARY <= std_logic_vector(to_unsigned(LINK_CAP_L0S_EXIT_LATENCY, 3));
    else
      assert FALSE report "Error : LINK_CAP_L0S_EXIT_LATENCY is not in range 0 .. 7." severity error;
    end if;
    if ((LINK_CAP_L1_EXIT_LATENCY >= 0) and (LINK_CAP_L1_EXIT_LATENCY <= 7)) then
      LINK_CAP_L1_EXIT_LATENCY_BINARY <= std_logic_vector(to_unsigned(LINK_CAP_L1_EXIT_LATENCY, 3));
    else
      assert FALSE report "Error : LINK_CAP_L1_EXIT_LATENCY is not in range 0 .. 7." severity error;
    end if;
    if ((MSI_CAP_MULTIMSGCAP >= 0) and (MSI_CAP_MULTIMSGCAP <= 7)) then
      MSI_CAP_MULTIMSGCAP_BINARY <= std_logic_vector(to_unsigned(MSI_CAP_MULTIMSGCAP, 3));
    else
      assert FALSE report "Error : MSI_CAP_MULTIMSGCAP is not in range 0 .. 7." severity error;
    end if;
  if ((PCIE_CAP_INT_MSG_NUM >= "00000") and (PCIE_CAP_INT_MSG_NUM <= "11111")) then
--    PCIE_CAP_INT_MSG_NUM_BINARY <= std_logic_vector(to_unsigned(PCIE_CAP_INT_MSG_NUM, 5));
  else
    assert FALSE report "Error : PCIE_CAP_INT_MSG_NUM is not in range 0 .. 31." severity error;
  end if;
    if ((PM_CAP_AUXCURRENT >= 0) and (PM_CAP_AUXCURRENT <= 7)) then
      PM_CAP_AUXCURRENT_BINARY <= std_logic_vector(to_unsigned(PM_CAP_AUXCURRENT, 3));
    else
      assert FALSE report "Error : PM_CAP_AUXCURRENT is not in range 0 .. 7." severity error;
    end if;
  if ((PM_CAP_PMESUPPORT >= "00000") and (PM_CAP_PMESUPPORT <= "11111")) then
--    PM_CAP_PMESUPPORT_BINARY <= std_logic_vector(to_unsigned(PM_CAP_PMESUPPORT, 5));
  else
    assert FALSE report "Error : PM_CAP_PMESUPPORT is not in range 0 .. 31." severity error;
  end if;
    if ((PM_CAP_VERSION >= 0) and (PM_CAP_VERSION <= 7)) then
      PM_CAP_VERSION_BINARY <= std_logic_vector(to_unsigned(PM_CAP_VERSION, 3));
    else
      assert FALSE report "Error : PM_CAP_VERSION is not in range 0 .. 7." severity error;
    end if;
  if ((PM_DATA_SCALE0 >= "00") and (PM_DATA_SCALE0 <= "11")) then
--    PM_DATA_SCALE0_BINARY <= std_logic_vector(to_unsigned(PM_DATA_SCALE0, 2));
  else
    assert FALSE report "Error : PM_DATA_SCALE0 is not in range 0 .. 3." severity error;
  end if;
  if ((PM_DATA_SCALE1 >= "00") and (PM_DATA_SCALE1 <= "11")) then
--    PM_DATA_SCALE1_BINARY <= std_logic_vector(to_unsigned(PM_DATA_SCALE1, 2));
  else
    assert FALSE report "Error : PM_DATA_SCALE1 is not in range 0 .. 3." severity error;
  end if;
  if ((PM_DATA_SCALE2 >= "00") and (PM_DATA_SCALE2 <= "11")) then
--    PM_DATA_SCALE2_BINARY <= std_logic_vector(to_unsigned(PM_DATA_SCALE2, 2));
  else
    assert FALSE report "Error : PM_DATA_SCALE2 is not in range 0 .. 3." severity error;
  end if;
  if ((PM_DATA_SCALE3 >= "00") and (PM_DATA_SCALE3 <= "11")) then
--    PM_DATA_SCALE3_BINARY <= std_logic_vector(to_unsigned(PM_DATA_SCALE3, 2));
  else
    assert FALSE report "Error : PM_DATA_SCALE3 is not in range 0 .. 3." severity error;
  end if;
  if ((PM_DATA_SCALE4 >= "00") and (PM_DATA_SCALE4 <= "11")) then
--    PM_DATA_SCALE4_BINARY <= std_logic_vector(to_unsigned(PM_DATA_SCALE4, 2));
  else
    assert FALSE report "Error : PM_DATA_SCALE4 is not in range 0 .. 3." severity error;
  end if;
  if ((PM_DATA_SCALE5 >= "00") and (PM_DATA_SCALE5 <= "11")) then
--    PM_DATA_SCALE5_BINARY <= std_logic_vector(to_unsigned(PM_DATA_SCALE5, 2));
  else
    assert FALSE report "Error : PM_DATA_SCALE5 is not in range 0 .. 3." severity error;
  end if;
  if ((PM_DATA_SCALE6 >= "00") and (PM_DATA_SCALE6 <= "11")) then
--    PM_DATA_SCALE6_BINARY <= std_logic_vector(to_unsigned(PM_DATA_SCALE6, 2));
  else
    assert FALSE report "Error : PM_DATA_SCALE6 is not in range 0 .. 3." severity error;
  end if;
  if ((PM_DATA_SCALE7 >= "00") and (PM_DATA_SCALE7 <= "11")) then
--    PM_DATA_SCALE7_BINARY <= std_logic_vector(to_unsigned(PM_DATA_SCALE7, 2));
  else
    assert FALSE report "Error : PM_DATA_SCALE7 is not in range 0 .. 3." severity error;
  end if;
    if ((TL_RX_RAM_RDATA_LATENCY >= 0) and (TL_RX_RAM_RDATA_LATENCY <= 3)) then
      TL_RX_RAM_RDATA_LATENCY_BINARY <= std_logic_vector(to_unsigned(TL_RX_RAM_RDATA_LATENCY, 2));
    else
      assert FALSE report "Error : TL_RX_RAM_RDATA_LATENCY is not in range 0 .. 3." severity error;
    end if;
    if ((TL_TX_RAM_RDATA_LATENCY >= 0) and (TL_TX_RAM_RDATA_LATENCY <= 3)) then
      TL_TX_RAM_RDATA_LATENCY_BINARY <= std_logic_vector(to_unsigned(TL_TX_RAM_RDATA_LATENCY, 2));
    else
      assert FALSE report "Error : TL_TX_RAM_RDATA_LATENCY is not in range 0 .. 3." severity error;
    end if;
    if ((VC0_TOTAL_CREDITS_CD >= 0) and (VC0_TOTAL_CREDITS_CD <= 2047)) then
      VC0_TOTAL_CREDITS_CD_BINARY <= std_logic_vector(to_unsigned(VC0_TOTAL_CREDITS_CD, 11));
    else
      assert FALSE report "Error : VC0_TOTAL_CREDITS_CD is not in range 0 .. 2047." severity error;
    end if;
    if ((VC0_TOTAL_CREDITS_CH >= 0) and (VC0_TOTAL_CREDITS_CH <= 127)) then
      VC0_TOTAL_CREDITS_CH_BINARY <= std_logic_vector(to_unsigned(VC0_TOTAL_CREDITS_CH, 7));
    else
      assert FALSE report "Error : VC0_TOTAL_CREDITS_CH is not in range 0 .. 127." severity error;
    end if;
    if ((VC0_TOTAL_CREDITS_NPH >= 0) and (VC0_TOTAL_CREDITS_NPH <= 127)) then
      VC0_TOTAL_CREDITS_NPH_BINARY <= std_logic_vector(to_unsigned(VC0_TOTAL_CREDITS_NPH, 7));
    else
      assert FALSE report "Error : VC0_TOTAL_CREDITS_NPH is not in range 0 .. 127." severity error;
    end if;
    if ((VC0_TOTAL_CREDITS_PD >= 0) and (VC0_TOTAL_CREDITS_PD <= 2047)) then
      VC0_TOTAL_CREDITS_PD_BINARY <= std_logic_vector(to_unsigned(VC0_TOTAL_CREDITS_PD, 11));
    else
      assert FALSE report "Error : VC0_TOTAL_CREDITS_PD is not in range 0 .. 2047." severity error;
    end if;
    if ((VC0_TOTAL_CREDITS_PH >= 0) and (VC0_TOTAL_CREDITS_PH <= 127)) then
      VC0_TOTAL_CREDITS_PH_BINARY <= std_logic_vector(to_unsigned(VC0_TOTAL_CREDITS_PH, 7));
    else
      assert FALSE report "Error : VC0_TOTAL_CREDITS_PH is not in range 0 .. 127." severity error;
    end if;
    if ((VC0_TX_LASTPACKET >= 0) and (VC0_TX_LASTPACKET <= 31)) then
      VC0_TX_LASTPACKET_BINARY <= std_logic_vector(to_unsigned(VC0_TX_LASTPACKET, 5));
    else
      assert FALSE report "Error : VC0_TX_LASTPACKET is not in range 0 .. 31." severity error;
    end if;
    wait;
    end process INIPROC;
--####################################################################
--#####                   TIMING CHECKS & OUTPUT                 #####
--####################################################################
    
    TIMING_CFGDEVID : process
      variable Tmkr_CFGDEVID_USERCLK_posedge : VitalTimingDataArrayType(15 downto 0);
      variable Tviol_CFGDEVID_USERCLK_posedge : std_logic_vector(15 downto 0) := (others => '0');
      begin
      if (TimingChecksOn) then
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDEVID_USERCLK_posedge(0),
          TimingData => Tmkr_CFGDEVID_USERCLK_posedge(0),
          TestSignal => CFGDEVID_USERCLK_dly(0),
          TestSignalName => "CFGDEVID(0)",
          TestDelay => tisd_CFGDEVID_USERCLK(0),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDEVID_USERCLK_posedge_posedge(0),
          HoldHigh => thold_CFGDEVID_USERCLK_posedge_posedge(0),
          SetupLow => tsetup_CFGDEVID_USERCLK_negedge_posedge(0),
          HoldLow => thold_CFGDEVID_USERCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDEVID_USERCLK_posedge(1),
          TimingData => Tmkr_CFGDEVID_USERCLK_posedge(1),
          TestSignal => CFGDEVID_USERCLK_dly(1),
          TestSignalName => "CFGDEVID(1)",
          TestDelay => tisd_CFGDEVID_USERCLK(1),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDEVID_USERCLK_posedge_posedge(1),
          HoldHigh => thold_CFGDEVID_USERCLK_posedge_posedge(1),
          SetupLow => tsetup_CFGDEVID_USERCLK_negedge_posedge(1),
          HoldLow => thold_CFGDEVID_USERCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDEVID_USERCLK_posedge(10),
          TimingData => Tmkr_CFGDEVID_USERCLK_posedge(10),
          TestSignal => CFGDEVID_USERCLK_dly(10),
          TestSignalName => "CFGDEVID(10)",
          TestDelay => tisd_CFGDEVID_USERCLK(10),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDEVID_USERCLK_posedge_posedge(10),
          HoldHigh => thold_CFGDEVID_USERCLK_posedge_posedge(10),
          SetupLow => tsetup_CFGDEVID_USERCLK_negedge_posedge(10),
          HoldLow => thold_CFGDEVID_USERCLK_negedge_posedge(10),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDEVID_USERCLK_posedge(11),
          TimingData => Tmkr_CFGDEVID_USERCLK_posedge(11),
          TestSignal => CFGDEVID_USERCLK_dly(11),
          TestSignalName => "CFGDEVID(11)",
          TestDelay => tisd_CFGDEVID_USERCLK(11),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDEVID_USERCLK_posedge_posedge(11),
          HoldHigh => thold_CFGDEVID_USERCLK_posedge_posedge(11),
          SetupLow => tsetup_CFGDEVID_USERCLK_negedge_posedge(11),
          HoldLow => thold_CFGDEVID_USERCLK_negedge_posedge(11),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDEVID_USERCLK_posedge(12),
          TimingData => Tmkr_CFGDEVID_USERCLK_posedge(12),
          TestSignal => CFGDEVID_USERCLK_dly(12),
          TestSignalName => "CFGDEVID(12)",
          TestDelay => tisd_CFGDEVID_USERCLK(12),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDEVID_USERCLK_posedge_posedge(12),
          HoldHigh => thold_CFGDEVID_USERCLK_posedge_posedge(12),
          SetupLow => tsetup_CFGDEVID_USERCLK_negedge_posedge(12),
          HoldLow => thold_CFGDEVID_USERCLK_negedge_posedge(12),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDEVID_USERCLK_posedge(13),
          TimingData => Tmkr_CFGDEVID_USERCLK_posedge(13),
          TestSignal => CFGDEVID_USERCLK_dly(13),
          TestSignalName => "CFGDEVID(13)",
          TestDelay => tisd_CFGDEVID_USERCLK(13),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDEVID_USERCLK_posedge_posedge(13),
          HoldHigh => thold_CFGDEVID_USERCLK_posedge_posedge(13),
          SetupLow => tsetup_CFGDEVID_USERCLK_negedge_posedge(13),
          HoldLow => thold_CFGDEVID_USERCLK_negedge_posedge(13),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDEVID_USERCLK_posedge(14),
          TimingData => Tmkr_CFGDEVID_USERCLK_posedge(14),
          TestSignal => CFGDEVID_USERCLK_dly(14),
          TestSignalName => "CFGDEVID(14)",
          TestDelay => tisd_CFGDEVID_USERCLK(14),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDEVID_USERCLK_posedge_posedge(14),
          HoldHigh => thold_CFGDEVID_USERCLK_posedge_posedge(14),
          SetupLow => tsetup_CFGDEVID_USERCLK_negedge_posedge(14),
          HoldLow => thold_CFGDEVID_USERCLK_negedge_posedge(14),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDEVID_USERCLK_posedge(15),
          TimingData => Tmkr_CFGDEVID_USERCLK_posedge(15),
          TestSignal => CFGDEVID_USERCLK_dly(15),
          TestSignalName => "CFGDEVID(15)",
          TestDelay => tisd_CFGDEVID_USERCLK(15),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDEVID_USERCLK_posedge_posedge(15),
          HoldHigh => thold_CFGDEVID_USERCLK_posedge_posedge(15),
          SetupLow => tsetup_CFGDEVID_USERCLK_negedge_posedge(15),
          HoldLow => thold_CFGDEVID_USERCLK_negedge_posedge(15),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDEVID_USERCLK_posedge(2),
          TimingData => Tmkr_CFGDEVID_USERCLK_posedge(2),
          TestSignal => CFGDEVID_USERCLK_dly(2),
          TestSignalName => "CFGDEVID(2)",
          TestDelay => tisd_CFGDEVID_USERCLK(2),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDEVID_USERCLK_posedge_posedge(2),
          HoldHigh => thold_CFGDEVID_USERCLK_posedge_posedge(2),
          SetupLow => tsetup_CFGDEVID_USERCLK_negedge_posedge(2),
          HoldLow => thold_CFGDEVID_USERCLK_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDEVID_USERCLK_posedge(3),
          TimingData => Tmkr_CFGDEVID_USERCLK_posedge(3),
          TestSignal => CFGDEVID_USERCLK_dly(3),
          TestSignalName => "CFGDEVID(3)",
          TestDelay => tisd_CFGDEVID_USERCLK(3),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDEVID_USERCLK_posedge_posedge(3),
          HoldHigh => thold_CFGDEVID_USERCLK_posedge_posedge(3),
          SetupLow => tsetup_CFGDEVID_USERCLK_negedge_posedge(3),
          HoldLow => thold_CFGDEVID_USERCLK_negedge_posedge(3),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDEVID_USERCLK_posedge(4),
          TimingData => Tmkr_CFGDEVID_USERCLK_posedge(4),
          TestSignal => CFGDEVID_USERCLK_dly(4),
          TestSignalName => "CFGDEVID(4)",
          TestDelay => tisd_CFGDEVID_USERCLK(4),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDEVID_USERCLK_posedge_posedge(4),
          HoldHigh => thold_CFGDEVID_USERCLK_posedge_posedge(4),
          SetupLow => tsetup_CFGDEVID_USERCLK_negedge_posedge(4),
          HoldLow => thold_CFGDEVID_USERCLK_negedge_posedge(4),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDEVID_USERCLK_posedge(5),
          TimingData => Tmkr_CFGDEVID_USERCLK_posedge(5),
          TestSignal => CFGDEVID_USERCLK_dly(5),
          TestSignalName => "CFGDEVID(5)",
          TestDelay => tisd_CFGDEVID_USERCLK(5),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDEVID_USERCLK_posedge_posedge(5),
          HoldHigh => thold_CFGDEVID_USERCLK_posedge_posedge(5),
          SetupLow => tsetup_CFGDEVID_USERCLK_negedge_posedge(5),
          HoldLow => thold_CFGDEVID_USERCLK_negedge_posedge(5),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDEVID_USERCLK_posedge(6),
          TimingData => Tmkr_CFGDEVID_USERCLK_posedge(6),
          TestSignal => CFGDEVID_USERCLK_dly(6),
          TestSignalName => "CFGDEVID(6)",
          TestDelay => tisd_CFGDEVID_USERCLK(6),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDEVID_USERCLK_posedge_posedge(6),
          HoldHigh => thold_CFGDEVID_USERCLK_posedge_posedge(6),
          SetupLow => tsetup_CFGDEVID_USERCLK_negedge_posedge(6),
          HoldLow => thold_CFGDEVID_USERCLK_negedge_posedge(6),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDEVID_USERCLK_posedge(7),
          TimingData => Tmkr_CFGDEVID_USERCLK_posedge(7),
          TestSignal => CFGDEVID_USERCLK_dly(7),
          TestSignalName => "CFGDEVID(7)",
          TestDelay => tisd_CFGDEVID_USERCLK(7),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDEVID_USERCLK_posedge_posedge(7),
          HoldHigh => thold_CFGDEVID_USERCLK_posedge_posedge(7),
          SetupLow => tsetup_CFGDEVID_USERCLK_negedge_posedge(7),
          HoldLow => thold_CFGDEVID_USERCLK_negedge_posedge(7),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDEVID_USERCLK_posedge(8),
          TimingData => Tmkr_CFGDEVID_USERCLK_posedge(8),
          TestSignal => CFGDEVID_USERCLK_dly(8),
          TestSignalName => "CFGDEVID(8)",
          TestDelay => tisd_CFGDEVID_USERCLK(8),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDEVID_USERCLK_posedge_posedge(8),
          HoldHigh => thold_CFGDEVID_USERCLK_posedge_posedge(8),
          SetupLow => tsetup_CFGDEVID_USERCLK_negedge_posedge(8),
          HoldLow => thold_CFGDEVID_USERCLK_negedge_posedge(8),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDEVID_USERCLK_posedge(9),
          TimingData => Tmkr_CFGDEVID_USERCLK_posedge(9),
          TestSignal => CFGDEVID_USERCLK_dly(9),
          TestSignalName => "CFGDEVID(9)",
          TestDelay => tisd_CFGDEVID_USERCLK(9),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDEVID_USERCLK_posedge_posedge(9),
          HoldHigh => thold_CFGDEVID_USERCLK_posedge_posedge(9),
          SetupLow => tsetup_CFGDEVID_USERCLK_negedge_posedge(9),
          HoldLow => thold_CFGDEVID_USERCLK_negedge_posedge(9),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
      end if;
      wait on
        CFGDEVID_USERCLK_dly;
    end process TIMING_CFGDEVID;
    TIMING_CFGDSN: process
      variable Tmkr_CFGDSN_USERCLK_posedge : VitalTimingDataArrayType(63 downto 0);
      variable Tviol_CFGDSN_USERCLK_posedge : std_logic_vector(63 downto 0) := (others => '0');
      begin
      if (TimingChecksOn) then
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(0),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(0),
          TestSignal => CFGDSN_USERCLK_dly(0),
          TestSignalName => "CFGDSN(0)",
          TestDelay => tisd_CFGDSN_USERCLK(0),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(0),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(0),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(0),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(1),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(1),
          TestSignal => CFGDSN_USERCLK_dly(1),
          TestSignalName => "CFGDSN(1)",
          TestDelay => tisd_CFGDSN_USERCLK(1),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(1),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(1),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(1),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(10),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(10),
          TestSignal => CFGDSN_USERCLK_dly(10),
          TestSignalName => "CFGDSN(10)",
          TestDelay => tisd_CFGDSN_USERCLK(10),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(10),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(10),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(10),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(10),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(11),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(11),
          TestSignal => CFGDSN_USERCLK_dly(11),
          TestSignalName => "CFGDSN(11)",
          TestDelay => tisd_CFGDSN_USERCLK(11),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(11),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(11),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(11),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(11),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(12),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(12),
          TestSignal => CFGDSN_USERCLK_dly(12),
          TestSignalName => "CFGDSN(12)",
          TestDelay => tisd_CFGDSN_USERCLK(12),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(12),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(12),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(12),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(12),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(13),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(13),
          TestSignal => CFGDSN_USERCLK_dly(13),
          TestSignalName => "CFGDSN(13)",
          TestDelay => tisd_CFGDSN_USERCLK(13),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(13),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(13),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(13),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(13),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(14),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(14),
          TestSignal => CFGDSN_USERCLK_dly(14),
          TestSignalName => "CFGDSN(14)",
          TestDelay => tisd_CFGDSN_USERCLK(14),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(14),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(14),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(14),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(14),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(15),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(15),
          TestSignal => CFGDSN_USERCLK_dly(15),
          TestSignalName => "CFGDSN(15)",
          TestDelay => tisd_CFGDSN_USERCLK(15),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(15),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(15),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(15),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(15),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(16),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(16),
          TestSignal => CFGDSN_USERCLK_dly(16),
          TestSignalName => "CFGDSN(16)",
          TestDelay => tisd_CFGDSN_USERCLK(16),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(16),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(16),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(16),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(16),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(17),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(17),
          TestSignal => CFGDSN_USERCLK_dly(17),
          TestSignalName => "CFGDSN(17)",
          TestDelay => tisd_CFGDSN_USERCLK(17),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(17),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(17),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(17),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(17),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(18),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(18),
          TestSignal => CFGDSN_USERCLK_dly(18),
          TestSignalName => "CFGDSN(18)",
          TestDelay => tisd_CFGDSN_USERCLK(18),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(18),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(18),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(18),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(18),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(19),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(19),
          TestSignal => CFGDSN_USERCLK_dly(19),
          TestSignalName => "CFGDSN(19)",
          TestDelay => tisd_CFGDSN_USERCLK(19),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(19),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(19),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(19),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(19),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(2),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(2),
          TestSignal => CFGDSN_USERCLK_dly(2),
          TestSignalName => "CFGDSN(2)",
          TestDelay => tisd_CFGDSN_USERCLK(2),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(2),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(2),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(2),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(20),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(20),
          TestSignal => CFGDSN_USERCLK_dly(20),
          TestSignalName => "CFGDSN(20)",
          TestDelay => tisd_CFGDSN_USERCLK(20),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(20),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(20),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(20),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(20),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(21),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(21),
          TestSignal => CFGDSN_USERCLK_dly(21),
          TestSignalName => "CFGDSN(21)",
          TestDelay => tisd_CFGDSN_USERCLK(21),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(21),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(21),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(21),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(21),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(22),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(22),
          TestSignal => CFGDSN_USERCLK_dly(22),
          TestSignalName => "CFGDSN(22)",
          TestDelay => tisd_CFGDSN_USERCLK(22),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(22),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(22),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(22),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(22),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(23),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(23),
          TestSignal => CFGDSN_USERCLK_dly(23),
          TestSignalName => "CFGDSN(23)",
          TestDelay => tisd_CFGDSN_USERCLK(23),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(23),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(23),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(23),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(23),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(24),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(24),
          TestSignal => CFGDSN_USERCLK_dly(24),
          TestSignalName => "CFGDSN(24)",
          TestDelay => tisd_CFGDSN_USERCLK(24),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(24),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(24),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(24),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(24),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(25),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(25),
          TestSignal => CFGDSN_USERCLK_dly(25),
          TestSignalName => "CFGDSN(25)",
          TestDelay => tisd_CFGDSN_USERCLK(25),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(25),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(25),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(25),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(25),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(26),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(26),
          TestSignal => CFGDSN_USERCLK_dly(26),
          TestSignalName => "CFGDSN(26)",
          TestDelay => tisd_CFGDSN_USERCLK(26),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(26),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(26),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(26),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(26),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(27),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(27),
          TestSignal => CFGDSN_USERCLK_dly(27),
          TestSignalName => "CFGDSN(27)",
          TestDelay => tisd_CFGDSN_USERCLK(27),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(27),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(27),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(27),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(27),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(28),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(28),
          TestSignal => CFGDSN_USERCLK_dly(28),
          TestSignalName => "CFGDSN(28)",
          TestDelay => tisd_CFGDSN_USERCLK(28),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(28),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(28),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(28),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(28),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(29),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(29),
          TestSignal => CFGDSN_USERCLK_dly(29),
          TestSignalName => "CFGDSN(29)",
          TestDelay => tisd_CFGDSN_USERCLK(29),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(29),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(29),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(29),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(29),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(3),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(3),
          TestSignal => CFGDSN_USERCLK_dly(3),
          TestSignalName => "CFGDSN(3)",
          TestDelay => tisd_CFGDSN_USERCLK(3),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(3),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(3),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(3),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(3),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(30),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(30),
          TestSignal => CFGDSN_USERCLK_dly(30),
          TestSignalName => "CFGDSN(30)",
          TestDelay => tisd_CFGDSN_USERCLK(30),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(30),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(30),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(30),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(30),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(31),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(31),
          TestSignal => CFGDSN_USERCLK_dly(31),
          TestSignalName => "CFGDSN(31)",
          TestDelay => tisd_CFGDSN_USERCLK(31),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(31),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(31),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(31),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(31),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(32),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(32),
          TestSignal => CFGDSN_USERCLK_dly(32),
          TestSignalName => "CFGDSN(32)",
          TestDelay => tisd_CFGDSN_USERCLK(32),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(32),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(32),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(32),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(32),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(33),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(33),
          TestSignal => CFGDSN_USERCLK_dly(33),
          TestSignalName => "CFGDSN(33)",
          TestDelay => tisd_CFGDSN_USERCLK(33),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(33),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(33),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(33),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(33),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(34),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(34),
          TestSignal => CFGDSN_USERCLK_dly(34),
          TestSignalName => "CFGDSN(34)",
          TestDelay => tisd_CFGDSN_USERCLK(34),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(34),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(34),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(34),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(34),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(35),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(35),
          TestSignal => CFGDSN_USERCLK_dly(35),
          TestSignalName => "CFGDSN(35)",
          TestDelay => tisd_CFGDSN_USERCLK(35),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(35),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(35),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(35),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(35),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(36),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(36),
          TestSignal => CFGDSN_USERCLK_dly(36),
          TestSignalName => "CFGDSN(36)",
          TestDelay => tisd_CFGDSN_USERCLK(36),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(36),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(36),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(36),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(36),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(37),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(37),
          TestSignal => CFGDSN_USERCLK_dly(37),
          TestSignalName => "CFGDSN(37)",
          TestDelay => tisd_CFGDSN_USERCLK(37),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(37),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(37),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(37),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(37),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(38),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(38),
          TestSignal => CFGDSN_USERCLK_dly(38),
          TestSignalName => "CFGDSN(38)",
          TestDelay => tisd_CFGDSN_USERCLK(38),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(38),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(38),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(38),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(38),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(39),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(39),
          TestSignal => CFGDSN_USERCLK_dly(39),
          TestSignalName => "CFGDSN(39)",
          TestDelay => tisd_CFGDSN_USERCLK(39),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(39),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(39),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(39),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(39),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(4),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(4),
          TestSignal => CFGDSN_USERCLK_dly(4),
          TestSignalName => "CFGDSN(4)",
          TestDelay => tisd_CFGDSN_USERCLK(4),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(4),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(4),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(4),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(4),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(40),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(40),
          TestSignal => CFGDSN_USERCLK_dly(40),
          TestSignalName => "CFGDSN(40)",
          TestDelay => tisd_CFGDSN_USERCLK(40),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(40),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(40),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(40),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(40),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(41),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(41),
          TestSignal => CFGDSN_USERCLK_dly(41),
          TestSignalName => "CFGDSN(41)",
          TestDelay => tisd_CFGDSN_USERCLK(41),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(41),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(41),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(41),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(41),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(42),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(42),
          TestSignal => CFGDSN_USERCLK_dly(42),
          TestSignalName => "CFGDSN(42)",
          TestDelay => tisd_CFGDSN_USERCLK(42),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(42),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(42),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(42),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(42),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(43),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(43),
          TestSignal => CFGDSN_USERCLK_dly(43),
          TestSignalName => "CFGDSN(43)",
          TestDelay => tisd_CFGDSN_USERCLK(43),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(43),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(43),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(43),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(43),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(44),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(44),
          TestSignal => CFGDSN_USERCLK_dly(44),
          TestSignalName => "CFGDSN(44)",
          TestDelay => tisd_CFGDSN_USERCLK(44),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(44),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(44),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(44),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(44),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(45),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(45),
          TestSignal => CFGDSN_USERCLK_dly(45),
          TestSignalName => "CFGDSN(45)",
          TestDelay => tisd_CFGDSN_USERCLK(45),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(45),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(45),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(45),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(45),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(46),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(46),
          TestSignal => CFGDSN_USERCLK_dly(46),
          TestSignalName => "CFGDSN(46)",
          TestDelay => tisd_CFGDSN_USERCLK(46),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(46),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(46),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(46),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(46),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(47),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(47),
          TestSignal => CFGDSN_USERCLK_dly(47),
          TestSignalName => "CFGDSN(47)",
          TestDelay => tisd_CFGDSN_USERCLK(47),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(47),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(47),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(47),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(47),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(48),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(48),
          TestSignal => CFGDSN_USERCLK_dly(48),
          TestSignalName => "CFGDSN(48)",
          TestDelay => tisd_CFGDSN_USERCLK(48),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(48),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(48),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(48),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(48),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(49),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(49),
          TestSignal => CFGDSN_USERCLK_dly(49),
          TestSignalName => "CFGDSN(49)",
          TestDelay => tisd_CFGDSN_USERCLK(49),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(49),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(49),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(49),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(49),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(5),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(5),
          TestSignal => CFGDSN_USERCLK_dly(5),
          TestSignalName => "CFGDSN(5)",
          TestDelay => tisd_CFGDSN_USERCLK(5),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(5),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(5),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(5),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(5),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(50),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(50),
          TestSignal => CFGDSN_USERCLK_dly(50),
          TestSignalName => "CFGDSN(50)",
          TestDelay => tisd_CFGDSN_USERCLK(50),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(50),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(50),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(50),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(50),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(51),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(51),
          TestSignal => CFGDSN_USERCLK_dly(51),
          TestSignalName => "CFGDSN(51)",
          TestDelay => tisd_CFGDSN_USERCLK(51),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(51),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(51),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(51),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(51),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(52),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(52),
          TestSignal => CFGDSN_USERCLK_dly(52),
          TestSignalName => "CFGDSN(52)",
          TestDelay => tisd_CFGDSN_USERCLK(52),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(52),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(52),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(52),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(52),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(53),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(53),
          TestSignal => CFGDSN_USERCLK_dly(53),
          TestSignalName => "CFGDSN(53)",
          TestDelay => tisd_CFGDSN_USERCLK(53),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(53),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(53),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(53),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(53),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(54),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(54),
          TestSignal => CFGDSN_USERCLK_dly(54),
          TestSignalName => "CFGDSN(54)",
          TestDelay => tisd_CFGDSN_USERCLK(54),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(54),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(54),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(54),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(54),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(55),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(55),
          TestSignal => CFGDSN_USERCLK_dly(55),
          TestSignalName => "CFGDSN(55)",
          TestDelay => tisd_CFGDSN_USERCLK(55),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(55),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(55),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(55),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(55),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(56),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(56),
          TestSignal => CFGDSN_USERCLK_dly(56),
          TestSignalName => "CFGDSN(56)",
          TestDelay => tisd_CFGDSN_USERCLK(56),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(56),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(56),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(56),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(56),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(57),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(57),
          TestSignal => CFGDSN_USERCLK_dly(57),
          TestSignalName => "CFGDSN(57)",
          TestDelay => tisd_CFGDSN_USERCLK(57),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(57),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(57),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(57),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(57),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(58),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(58),
          TestSignal => CFGDSN_USERCLK_dly(58),
          TestSignalName => "CFGDSN(58)",
          TestDelay => tisd_CFGDSN_USERCLK(58),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(58),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(58),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(58),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(58),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(59),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(59),
          TestSignal => CFGDSN_USERCLK_dly(59),
          TestSignalName => "CFGDSN(59)",
          TestDelay => tisd_CFGDSN_USERCLK(59),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(59),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(59),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(59),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(59),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(6),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(6),
          TestSignal => CFGDSN_USERCLK_dly(6),
          TestSignalName => "CFGDSN(6)",
          TestDelay => tisd_CFGDSN_USERCLK(6),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(6),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(6),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(6),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(6),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(60),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(60),
          TestSignal => CFGDSN_USERCLK_dly(60),
          TestSignalName => "CFGDSN(60)",
          TestDelay => tisd_CFGDSN_USERCLK(60),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(60),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(60),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(60),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(60),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(61),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(61),
          TestSignal => CFGDSN_USERCLK_dly(61),
          TestSignalName => "CFGDSN(61)",
          TestDelay => tisd_CFGDSN_USERCLK(61),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(61),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(61),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(61),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(61),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(62),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(62),
          TestSignal => CFGDSN_USERCLK_dly(62),
          TestSignalName => "CFGDSN(62)",
          TestDelay => tisd_CFGDSN_USERCLK(62),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(62),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(62),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(62),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(62),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(63),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(63),
          TestSignal => CFGDSN_USERCLK_dly(63),
          TestSignalName => "CFGDSN(63)",
          TestDelay => tisd_CFGDSN_USERCLK(63),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(63),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(63),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(63),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(63),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(7),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(7),
          TestSignal => CFGDSN_USERCLK_dly(7),
          TestSignalName => "CFGDSN(7)",
          TestDelay => tisd_CFGDSN_USERCLK(7),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(7),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(7),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(7),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(7),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(8),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(8),
          TestSignal => CFGDSN_USERCLK_dly(8),
          TestSignalName => "CFGDSN(8)",
          TestDelay => tisd_CFGDSN_USERCLK(8),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(8),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(8),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(8),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(8),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDSN_USERCLK_posedge(9),
          TimingData => Tmkr_CFGDSN_USERCLK_posedge(9),
          TestSignal => CFGDSN_USERCLK_dly(9),
          TestSignalName => "CFGDSN(9)",
          TestDelay => tisd_CFGDSN_USERCLK(9),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDSN_USERCLK_posedge_posedge(9),
          HoldHigh => thold_CFGDSN_USERCLK_posedge_posedge(9),
          SetupLow => tsetup_CFGDSN_USERCLK_negedge_posedge(9),
          HoldLow => thold_CFGDSN_USERCLK_negedge_posedge(9),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
      end if;
      wait on CFGDSN_USERCLK_dly;
    end process TIMING_CFGDSN;
    TIMING_CFGDWADDR: process
      variable Tmkr_CFGDWADDR_USERCLK_posedge : VitalTimingDataArrayType(9 downto 0);
      variable Tviol_CFGDWADDR_USERCLK_posedge : std_logic_vector(9 downto 0) := (others => '0');
      begin
      if (TimingChecksOn) then
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDWADDR_USERCLK_posedge(0),
          TimingData => Tmkr_CFGDWADDR_USERCLK_posedge(0),
          TestSignal => CFGDWADDR_USERCLK_dly(0),
          TestSignalName => "CFGDWADDR(0)",
          TestDelay => tisd_CFGDWADDR_USERCLK(0),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDWADDR_USERCLK_posedge_posedge(0),
          HoldHigh => thold_CFGDWADDR_USERCLK_posedge_posedge(0),
          SetupLow => tsetup_CFGDWADDR_USERCLK_negedge_posedge(0),
          HoldLow => thold_CFGDWADDR_USERCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDWADDR_USERCLK_posedge(1),
          TimingData => Tmkr_CFGDWADDR_USERCLK_posedge(1),
          TestSignal => CFGDWADDR_USERCLK_dly(1),
          TestSignalName => "CFGDWADDR(1)",
          TestDelay => tisd_CFGDWADDR_USERCLK(1),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDWADDR_USERCLK_posedge_posedge(1),
          HoldHigh => thold_CFGDWADDR_USERCLK_posedge_posedge(1),
          SetupLow => tsetup_CFGDWADDR_USERCLK_negedge_posedge(1),
          HoldLow => thold_CFGDWADDR_USERCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDWADDR_USERCLK_posedge(2),
          TimingData => Tmkr_CFGDWADDR_USERCLK_posedge(2),
          TestSignal => CFGDWADDR_USERCLK_dly(2),
          TestSignalName => "CFGDWADDR(2)",
          TestDelay => tisd_CFGDWADDR_USERCLK(2),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDWADDR_USERCLK_posedge_posedge(2),
          HoldHigh => thold_CFGDWADDR_USERCLK_posedge_posedge(2),
          SetupLow => tsetup_CFGDWADDR_USERCLK_negedge_posedge(2),
          HoldLow => thold_CFGDWADDR_USERCLK_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDWADDR_USERCLK_posedge(3),
          TimingData => Tmkr_CFGDWADDR_USERCLK_posedge(3),
          TestSignal => CFGDWADDR_USERCLK_dly(3),
          TestSignalName => "CFGDWADDR(3)",
          TestDelay => tisd_CFGDWADDR_USERCLK(3),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDWADDR_USERCLK_posedge_posedge(3),
          HoldHigh => thold_CFGDWADDR_USERCLK_posedge_posedge(3),
          SetupLow => tsetup_CFGDWADDR_USERCLK_negedge_posedge(3),
          HoldLow => thold_CFGDWADDR_USERCLK_negedge_posedge(3),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDWADDR_USERCLK_posedge(4),
          TimingData => Tmkr_CFGDWADDR_USERCLK_posedge(4),
          TestSignal => CFGDWADDR_USERCLK_dly(4),
          TestSignalName => "CFGDWADDR(4)",
          TestDelay => tisd_CFGDWADDR_USERCLK(4),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDWADDR_USERCLK_posedge_posedge(4),
          HoldHigh => thold_CFGDWADDR_USERCLK_posedge_posedge(4),
          SetupLow => tsetup_CFGDWADDR_USERCLK_negedge_posedge(4),
          HoldLow => thold_CFGDWADDR_USERCLK_negedge_posedge(4),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDWADDR_USERCLK_posedge(5),
          TimingData => Tmkr_CFGDWADDR_USERCLK_posedge(5),
          TestSignal => CFGDWADDR_USERCLK_dly(5),
          TestSignalName => "CFGDWADDR(5)",
          TestDelay => tisd_CFGDWADDR_USERCLK(5),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDWADDR_USERCLK_posedge_posedge(5),
          HoldHigh => thold_CFGDWADDR_USERCLK_posedge_posedge(5),
          SetupLow => tsetup_CFGDWADDR_USERCLK_negedge_posedge(5),
          HoldLow => thold_CFGDWADDR_USERCLK_negedge_posedge(5),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDWADDR_USERCLK_posedge(6),
          TimingData => Tmkr_CFGDWADDR_USERCLK_posedge(6),
          TestSignal => CFGDWADDR_USERCLK_dly(6),
          TestSignalName => "CFGDWADDR(6)",
          TestDelay => tisd_CFGDWADDR_USERCLK(6),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDWADDR_USERCLK_posedge_posedge(6),
          HoldHigh => thold_CFGDWADDR_USERCLK_posedge_posedge(6),
          SetupLow => tsetup_CFGDWADDR_USERCLK_negedge_posedge(6),
          HoldLow => thold_CFGDWADDR_USERCLK_negedge_posedge(6),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDWADDR_USERCLK_posedge(7),
          TimingData => Tmkr_CFGDWADDR_USERCLK_posedge(7),
          TestSignal => CFGDWADDR_USERCLK_dly(7),
          TestSignalName => "CFGDWADDR(7)",
          TestDelay => tisd_CFGDWADDR_USERCLK(7),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDWADDR_USERCLK_posedge_posedge(7),
          HoldHigh => thold_CFGDWADDR_USERCLK_posedge_posedge(7),
          SetupLow => tsetup_CFGDWADDR_USERCLK_negedge_posedge(7),
          HoldLow => thold_CFGDWADDR_USERCLK_negedge_posedge(7),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDWADDR_USERCLK_posedge(8),
          TimingData => Tmkr_CFGDWADDR_USERCLK_posedge(8),
          TestSignal => CFGDWADDR_USERCLK_dly(8),
          TestSignalName => "CFGDWADDR(8)",
          TestDelay => tisd_CFGDWADDR_USERCLK(8),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDWADDR_USERCLK_posedge_posedge(8),
          HoldHigh => thold_CFGDWADDR_USERCLK_posedge_posedge(8),
          SetupLow => tsetup_CFGDWADDR_USERCLK_negedge_posedge(8),
          HoldLow => thold_CFGDWADDR_USERCLK_negedge_posedge(8),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGDWADDR_USERCLK_posedge(9),
          TimingData => Tmkr_CFGDWADDR_USERCLK_posedge(9),
          TestSignal => CFGDWADDR_USERCLK_dly(9),
          TestSignalName => "CFGDWADDR(9)",
          TestDelay => tisd_CFGDWADDR_USERCLK(9),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGDWADDR_USERCLK_posedge_posedge(9),
          HoldHigh => thold_CFGDWADDR_USERCLK_posedge_posedge(9),
          SetupLow => tsetup_CFGDWADDR_USERCLK_negedge_posedge(9),
          HoldLow => thold_CFGDWADDR_USERCLK_negedge_posedge(9),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
      end if;
      wait on CFGDWADDR_USERCLK_dly;
    end process TIMING_CFGDWADDR;
    TIMING_CFGERRTLPCPLHEADER: process
      variable Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge : VitalTimingDataArrayType(47 downto 0);
      variable Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge : std_logic_vector(47 downto 0) := (others => '0');
      begin
      if (TimingChecksOn) then
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(0),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(0),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(0),
          TestSignalName => "CFGERRTLPCPLHEADER(0)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(0),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(0),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(0),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(0),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(1),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(1),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(1),
          TestSignalName => "CFGERRTLPCPLHEADER(1)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(1),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(1),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(1),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(1),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(10),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(10),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(10),
          TestSignalName => "CFGERRTLPCPLHEADER(10)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(10),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(10),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(10),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(10),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(10),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(11),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(11),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(11),
          TestSignalName => "CFGERRTLPCPLHEADER(11)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(11),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(11),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(11),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(11),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(11),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(12),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(12),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(12),
          TestSignalName => "CFGERRTLPCPLHEADER(12)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(12),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(12),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(12),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(12),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(12),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(13),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(13),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(13),
          TestSignalName => "CFGERRTLPCPLHEADER(13)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(13),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(13),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(13),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(13),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(13),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(14),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(14),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(14),
          TestSignalName => "CFGERRTLPCPLHEADER(14)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(14),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(14),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(14),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(14),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(14),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(15),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(15),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(15),
          TestSignalName => "CFGERRTLPCPLHEADER(15)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(15),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(15),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(15),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(15),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(15),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(16),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(16),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(16),
          TestSignalName => "CFGERRTLPCPLHEADER(16)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(16),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(16),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(16),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(16),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(16),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(17),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(17),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(17),
          TestSignalName => "CFGERRTLPCPLHEADER(17)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(17),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(17),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(17),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(17),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(17),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(18),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(18),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(18),
          TestSignalName => "CFGERRTLPCPLHEADER(18)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(18),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(18),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(18),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(18),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(18),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(19),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(19),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(19),
          TestSignalName => "CFGERRTLPCPLHEADER(19)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(19),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(19),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(19),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(19),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(19),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(2),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(2),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(2),
          TestSignalName => "CFGERRTLPCPLHEADER(2)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(2),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(2),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(2),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(2),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(20),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(20),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(20),
          TestSignalName => "CFGERRTLPCPLHEADER(20)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(20),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(20),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(20),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(20),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(20),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(21),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(21),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(21),
          TestSignalName => "CFGERRTLPCPLHEADER(21)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(21),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(21),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(21),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(21),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(21),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(22),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(22),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(22),
          TestSignalName => "CFGERRTLPCPLHEADER(22)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(22),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(22),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(22),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(22),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(22),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(23),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(23),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(23),
          TestSignalName => "CFGERRTLPCPLHEADER(23)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(23),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(23),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(23),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(23),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(23),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(24),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(24),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(24),
          TestSignalName => "CFGERRTLPCPLHEADER(24)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(24),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(24),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(24),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(24),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(24),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(25),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(25),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(25),
          TestSignalName => "CFGERRTLPCPLHEADER(25)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(25),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(25),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(25),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(25),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(25),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(26),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(26),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(26),
          TestSignalName => "CFGERRTLPCPLHEADER(26)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(26),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(26),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(26),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(26),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(26),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(27),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(27),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(27),
          TestSignalName => "CFGERRTLPCPLHEADER(27)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(27),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(27),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(27),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(27),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(27),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(28),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(28),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(28),
          TestSignalName => "CFGERRTLPCPLHEADER(28)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(28),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(28),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(28),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(28),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(28),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(29),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(29),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(29),
          TestSignalName => "CFGERRTLPCPLHEADER(29)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(29),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(29),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(29),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(29),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(29),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(3),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(3),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(3),
          TestSignalName => "CFGERRTLPCPLHEADER(3)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(3),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(3),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(3),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(3),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(3),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(30),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(30),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(30),
          TestSignalName => "CFGERRTLPCPLHEADER(30)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(30),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(30),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(30),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(30),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(30),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(31),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(31),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(31),
          TestSignalName => "CFGERRTLPCPLHEADER(31)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(31),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(31),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(31),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(31),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(31),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(32),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(32),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(32),
          TestSignalName => "CFGERRTLPCPLHEADER(32)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(32),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(32),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(32),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(32),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(32),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(33),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(33),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(33),
          TestSignalName => "CFGERRTLPCPLHEADER(33)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(33),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(33),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(33),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(33),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(33),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(34),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(34),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(34),
          TestSignalName => "CFGERRTLPCPLHEADER(34)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(34),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(34),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(34),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(34),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(34),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(35),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(35),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(35),
          TestSignalName => "CFGERRTLPCPLHEADER(35)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(35),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(35),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(35),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(35),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(35),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(36),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(36),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(36),
          TestSignalName => "CFGERRTLPCPLHEADER(36)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(36),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(36),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(36),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(36),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(36),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(37),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(37),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(37),
          TestSignalName => "CFGERRTLPCPLHEADER(37)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(37),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(37),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(37),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(37),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(37),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(38),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(38),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(38),
          TestSignalName => "CFGERRTLPCPLHEADER(38)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(38),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(38),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(38),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(38),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(38),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(39),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(39),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(39),
          TestSignalName => "CFGERRTLPCPLHEADER(39)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(39),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(39),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(39),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(39),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(39),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(4),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(4),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(4),
          TestSignalName => "CFGERRTLPCPLHEADER(4)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(4),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(4),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(4),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(4),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(4),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(40),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(40),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(40),
          TestSignalName => "CFGERRTLPCPLHEADER(40)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(40),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(40),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(40),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(40),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(40),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(41),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(41),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(41),
          TestSignalName => "CFGERRTLPCPLHEADER(41)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(41),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(41),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(41),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(41),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(41),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(42),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(42),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(42),
          TestSignalName => "CFGERRTLPCPLHEADER(42)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(42),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(42),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(42),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(42),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(42),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(43),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(43),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(43),
          TestSignalName => "CFGERRTLPCPLHEADER(43)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(43),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(43),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(43),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(43),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(43),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(44),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(44),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(44),
          TestSignalName => "CFGERRTLPCPLHEADER(44)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(44),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(44),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(44),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(44),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(44),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(45),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(45),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(45),
          TestSignalName => "CFGERRTLPCPLHEADER(45)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(45),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(45),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(45),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(45),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(45),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(46),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(46),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(46),
          TestSignalName => "CFGERRTLPCPLHEADER(46)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(46),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(46),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(46),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(46),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(46),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(47),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(47),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(47),
          TestSignalName => "CFGERRTLPCPLHEADER(47)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(47),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(47),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(47),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(47),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(47),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(5),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(5),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(5),
          TestSignalName => "CFGERRTLPCPLHEADER(5)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(5),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(5),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(5),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(5),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(5),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(6),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(6),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(6),
          TestSignalName => "CFGERRTLPCPLHEADER(6)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(6),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(6),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(6),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(6),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(6),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(7),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(7),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(7),
          TestSignalName => "CFGERRTLPCPLHEADER(7)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(7),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(7),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(7),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(7),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(7),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(8),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(8),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(8),
          TestSignalName => "CFGERRTLPCPLHEADER(8)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(8),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(8),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(8),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(8),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(8),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRTLPCPLHEADER_USERCLK_posedge(9),
          TimingData => Tmkr_CFGERRTLPCPLHEADER_USERCLK_posedge(9),
          TestSignal => CFGERRTLPCPLHEADER_USERCLK_dly(9),
          TestSignalName => "CFGERRTLPCPLHEADER(9)",
          TestDelay => tisd_CFGERRTLPCPLHEADER_USERCLK(9),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(9),
          HoldHigh => thold_CFGERRTLPCPLHEADER_USERCLK_posedge_posedge(9),
          SetupLow => tsetup_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(9),
          HoldLow => thold_CFGERRTLPCPLHEADER_USERCLK_negedge_posedge(9),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
      end if;
      wait on CFGERRTLPCPLHEADER_USERCLK_dly;
    end process TIMING_CFGERRTLPCPLHEADER;
    TIMING_CFGINTERRUPTDI: process
      variable Tmkr_CFGINTERRUPTDI_USERCLK_posedge : VitalTimingDataArrayType(7 downto 0);
      variable Tviol_CFGINTERRUPTDI_USERCLK_posedge : std_logic_vector(7 downto 0) := (others => '0');
      begin
      if (TimingChecksOn) then
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGINTERRUPTDI_USERCLK_posedge(0),
          TimingData => Tmkr_CFGINTERRUPTDI_USERCLK_posedge(0),
          TestSignal => CFGINTERRUPTDI_USERCLK_dly(0),
          TestSignalName => "CFGINTERRUPTDI(0)",
          TestDelay => tisd_CFGINTERRUPTDI_USERCLK(0),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGINTERRUPTDI_USERCLK_posedge_posedge(0),
          HoldHigh => thold_CFGINTERRUPTDI_USERCLK_posedge_posedge(0),
          SetupLow => tsetup_CFGINTERRUPTDI_USERCLK_negedge_posedge(0),
          HoldLow => thold_CFGINTERRUPTDI_USERCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGINTERRUPTDI_USERCLK_posedge(1),
          TimingData => Tmkr_CFGINTERRUPTDI_USERCLK_posedge(1),
          TestSignal => CFGINTERRUPTDI_USERCLK_dly(1),
          TestSignalName => "CFGINTERRUPTDI(1)",
          TestDelay => tisd_CFGINTERRUPTDI_USERCLK(1),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGINTERRUPTDI_USERCLK_posedge_posedge(1),
          HoldHigh => thold_CFGINTERRUPTDI_USERCLK_posedge_posedge(1),
          SetupLow => tsetup_CFGINTERRUPTDI_USERCLK_negedge_posedge(1),
          HoldLow => thold_CFGINTERRUPTDI_USERCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGINTERRUPTDI_USERCLK_posedge(2),
          TimingData => Tmkr_CFGINTERRUPTDI_USERCLK_posedge(2),
          TestSignal => CFGINTERRUPTDI_USERCLK_dly(2),
          TestSignalName => "CFGINTERRUPTDI(2)",
          TestDelay => tisd_CFGINTERRUPTDI_USERCLK(2),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGINTERRUPTDI_USERCLK_posedge_posedge(2),
          HoldHigh => thold_CFGINTERRUPTDI_USERCLK_posedge_posedge(2),
          SetupLow => tsetup_CFGINTERRUPTDI_USERCLK_negedge_posedge(2),
          HoldLow => thold_CFGINTERRUPTDI_USERCLK_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGINTERRUPTDI_USERCLK_posedge(3),
          TimingData => Tmkr_CFGINTERRUPTDI_USERCLK_posedge(3),
          TestSignal => CFGINTERRUPTDI_USERCLK_dly(3),
          TestSignalName => "CFGINTERRUPTDI(3)",
          TestDelay => tisd_CFGINTERRUPTDI_USERCLK(3),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGINTERRUPTDI_USERCLK_posedge_posedge(3),
          HoldHigh => thold_CFGINTERRUPTDI_USERCLK_posedge_posedge(3),
          SetupLow => tsetup_CFGINTERRUPTDI_USERCLK_negedge_posedge(3),
          HoldLow => thold_CFGINTERRUPTDI_USERCLK_negedge_posedge(3),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGINTERRUPTDI_USERCLK_posedge(4),
          TimingData => Tmkr_CFGINTERRUPTDI_USERCLK_posedge(4),
          TestSignal => CFGINTERRUPTDI_USERCLK_dly(4),
          TestSignalName => "CFGINTERRUPTDI(4)",
          TestDelay => tisd_CFGINTERRUPTDI_USERCLK(4),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGINTERRUPTDI_USERCLK_posedge_posedge(4),
          HoldHigh => thold_CFGINTERRUPTDI_USERCLK_posedge_posedge(4),
          SetupLow => tsetup_CFGINTERRUPTDI_USERCLK_negedge_posedge(4),
          HoldLow => thold_CFGINTERRUPTDI_USERCLK_negedge_posedge(4),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGINTERRUPTDI_USERCLK_posedge(5),
          TimingData => Tmkr_CFGINTERRUPTDI_USERCLK_posedge(5),
          TestSignal => CFGINTERRUPTDI_USERCLK_dly(5),
          TestSignalName => "CFGINTERRUPTDI(5)",
          TestDelay => tisd_CFGINTERRUPTDI_USERCLK(5),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGINTERRUPTDI_USERCLK_posedge_posedge(5),
          HoldHigh => thold_CFGINTERRUPTDI_USERCLK_posedge_posedge(5),
          SetupLow => tsetup_CFGINTERRUPTDI_USERCLK_negedge_posedge(5),
          HoldLow => thold_CFGINTERRUPTDI_USERCLK_negedge_posedge(5),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGINTERRUPTDI_USERCLK_posedge(6),
          TimingData => Tmkr_CFGINTERRUPTDI_USERCLK_posedge(6),
          TestSignal => CFGINTERRUPTDI_USERCLK_dly(6),
          TestSignalName => "CFGINTERRUPTDI(6)",
          TestDelay => tisd_CFGINTERRUPTDI_USERCLK(6),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGINTERRUPTDI_USERCLK_posedge_posedge(6),
          HoldHigh => thold_CFGINTERRUPTDI_USERCLK_posedge_posedge(6),
          SetupLow => tsetup_CFGINTERRUPTDI_USERCLK_negedge_posedge(6),
          HoldLow => thold_CFGINTERRUPTDI_USERCLK_negedge_posedge(6),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGINTERRUPTDI_USERCLK_posedge(7),
          TimingData => Tmkr_CFGINTERRUPTDI_USERCLK_posedge(7),
          TestSignal => CFGINTERRUPTDI_USERCLK_dly(7),
          TestSignalName => "CFGINTERRUPTDI(7)",
          TestDelay => tisd_CFGINTERRUPTDI_USERCLK(7),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGINTERRUPTDI_USERCLK_posedge_posedge(7),
          HoldHigh => thold_CFGINTERRUPTDI_USERCLK_posedge_posedge(7),
          SetupLow => tsetup_CFGINTERRUPTDI_USERCLK_negedge_posedge(7),
          HoldLow => thold_CFGINTERRUPTDI_USERCLK_negedge_posedge(7),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
      end if;
      wait on CFGINTERRUPTDI_USERCLK_dly;
    end process TIMING_CFGINTERRUPTDI;
    TIMING_CFGREVID: process
      variable Tmkr_CFGREVID_USERCLK_posedge : VitalTimingDataArrayType(7 downto 0);
      variable Tviol_CFGREVID_USERCLK_posedge : std_logic_vector(7 downto 0) := (others => '0');
      begin
      if (TimingChecksOn) then
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGREVID_USERCLK_posedge(0),
          TimingData => Tmkr_CFGREVID_USERCLK_posedge(0),
          TestSignal => CFGREVID_USERCLK_dly(0),
          TestSignalName => "CFGREVID(0)",
          TestDelay => tisd_CFGREVID_USERCLK(0),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGREVID_USERCLK_posedge_posedge(0),
          HoldHigh => thold_CFGREVID_USERCLK_posedge_posedge(0),
          SetupLow => tsetup_CFGREVID_USERCLK_negedge_posedge(0),
          HoldLow => thold_CFGREVID_USERCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGREVID_USERCLK_posedge(1),
          TimingData => Tmkr_CFGREVID_USERCLK_posedge(1),
          TestSignal => CFGREVID_USERCLK_dly(1),
          TestSignalName => "CFGREVID(1)",
          TestDelay => tisd_CFGREVID_USERCLK(1),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGREVID_USERCLK_posedge_posedge(1),
          HoldHigh => thold_CFGREVID_USERCLK_posedge_posedge(1),
          SetupLow => tsetup_CFGREVID_USERCLK_negedge_posedge(1),
          HoldLow => thold_CFGREVID_USERCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGREVID_USERCLK_posedge(2),
          TimingData => Tmkr_CFGREVID_USERCLK_posedge(2),
          TestSignal => CFGREVID_USERCLK_dly(2),
          TestSignalName => "CFGREVID(2)",
          TestDelay => tisd_CFGREVID_USERCLK(2),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGREVID_USERCLK_posedge_posedge(2),
          HoldHigh => thold_CFGREVID_USERCLK_posedge_posedge(2),
          SetupLow => tsetup_CFGREVID_USERCLK_negedge_posedge(2),
          HoldLow => thold_CFGREVID_USERCLK_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGREVID_USERCLK_posedge(3),
          TimingData => Tmkr_CFGREVID_USERCLK_posedge(3),
          TestSignal => CFGREVID_USERCLK_dly(3),
          TestSignalName => "CFGREVID(3)",
          TestDelay => tisd_CFGREVID_USERCLK(3),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGREVID_USERCLK_posedge_posedge(3),
          HoldHigh => thold_CFGREVID_USERCLK_posedge_posedge(3),
          SetupLow => tsetup_CFGREVID_USERCLK_negedge_posedge(3),
          HoldLow => thold_CFGREVID_USERCLK_negedge_posedge(3),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGREVID_USERCLK_posedge(4),
          TimingData => Tmkr_CFGREVID_USERCLK_posedge(4),
          TestSignal => CFGREVID_USERCLK_dly(4),
          TestSignalName => "CFGREVID(4)",
          TestDelay => tisd_CFGREVID_USERCLK(4),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGREVID_USERCLK_posedge_posedge(4),
          HoldHigh => thold_CFGREVID_USERCLK_posedge_posedge(4),
          SetupLow => tsetup_CFGREVID_USERCLK_negedge_posedge(4),
          HoldLow => thold_CFGREVID_USERCLK_negedge_posedge(4),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGREVID_USERCLK_posedge(5),
          TimingData => Tmkr_CFGREVID_USERCLK_posedge(5),
          TestSignal => CFGREVID_USERCLK_dly(5),
          TestSignalName => "CFGREVID(5)",
          TestDelay => tisd_CFGREVID_USERCLK(5),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGREVID_USERCLK_posedge_posedge(5),
          HoldHigh => thold_CFGREVID_USERCLK_posedge_posedge(5),
          SetupLow => tsetup_CFGREVID_USERCLK_negedge_posedge(5),
          HoldLow => thold_CFGREVID_USERCLK_negedge_posedge(5),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGREVID_USERCLK_posedge(6),
          TimingData => Tmkr_CFGREVID_USERCLK_posedge(6),
          TestSignal => CFGREVID_USERCLK_dly(6),
          TestSignalName => "CFGREVID(6)",
          TestDelay => tisd_CFGREVID_USERCLK(6),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGREVID_USERCLK_posedge_posedge(6),
          HoldHigh => thold_CFGREVID_USERCLK_posedge_posedge(6),
          SetupLow => tsetup_CFGREVID_USERCLK_negedge_posedge(6),
          HoldLow => thold_CFGREVID_USERCLK_negedge_posedge(6),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGREVID_USERCLK_posedge(7),
          TimingData => Tmkr_CFGREVID_USERCLK_posedge(7),
          TestSignal => CFGREVID_USERCLK_dly(7),
          TestSignalName => "CFGREVID(7)",
          TestDelay => tisd_CFGREVID_USERCLK(7),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGREVID_USERCLK_posedge_posedge(7),
          HoldHigh => thold_CFGREVID_USERCLK_posedge_posedge(7),
          SetupLow => tsetup_CFGREVID_USERCLK_negedge_posedge(7),
          HoldLow => thold_CFGREVID_USERCLK_negedge_posedge(7),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
      end if;
      wait on CFGREVID_USERCLK_dly;
    end process TIMING_CFGREVID;
    TIMING_CFGSUBSYSID: process
      variable Tmkr_CFGSUBSYSID_USERCLK_posedge : VitalTimingDataArrayType(15 downto 0);
      variable Tviol_CFGSUBSYSID_USERCLK_posedge : std_logic_vector(15 downto 0) := (others => '0');
      begin
      if (TimingChecksOn) then
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSID_USERCLK_posedge(0),
          TimingData => Tmkr_CFGSUBSYSID_USERCLK_posedge(0),
          TestSignal => CFGSUBSYSID_USERCLK_dly(0),
          TestSignalName => "CFGSUBSYSID(0)",
          TestDelay => tisd_CFGSUBSYSID_USERCLK(0),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSID_USERCLK_posedge_posedge(0),
          HoldHigh => thold_CFGSUBSYSID_USERCLK_posedge_posedge(0),
          SetupLow => tsetup_CFGSUBSYSID_USERCLK_negedge_posedge(0),
          HoldLow => thold_CFGSUBSYSID_USERCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSID_USERCLK_posedge(1),
          TimingData => Tmkr_CFGSUBSYSID_USERCLK_posedge(1),
          TestSignal => CFGSUBSYSID_USERCLK_dly(1),
          TestSignalName => "CFGSUBSYSID(1)",
          TestDelay => tisd_CFGSUBSYSID_USERCLK(1),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSID_USERCLK_posedge_posedge(1),
          HoldHigh => thold_CFGSUBSYSID_USERCLK_posedge_posedge(1),
          SetupLow => tsetup_CFGSUBSYSID_USERCLK_negedge_posedge(1),
          HoldLow => thold_CFGSUBSYSID_USERCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSID_USERCLK_posedge(10),
          TimingData => Tmkr_CFGSUBSYSID_USERCLK_posedge(10),
          TestSignal => CFGSUBSYSID_USERCLK_dly(10),
          TestSignalName => "CFGSUBSYSID(10)",
          TestDelay => tisd_CFGSUBSYSID_USERCLK(10),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSID_USERCLK_posedge_posedge(10),
          HoldHigh => thold_CFGSUBSYSID_USERCLK_posedge_posedge(10),
          SetupLow => tsetup_CFGSUBSYSID_USERCLK_negedge_posedge(10),
          HoldLow => thold_CFGSUBSYSID_USERCLK_negedge_posedge(10),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSID_USERCLK_posedge(11),
          TimingData => Tmkr_CFGSUBSYSID_USERCLK_posedge(11),
          TestSignal => CFGSUBSYSID_USERCLK_dly(11),
          TestSignalName => "CFGSUBSYSID(11)",
          TestDelay => tisd_CFGSUBSYSID_USERCLK(11),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSID_USERCLK_posedge_posedge(11),
          HoldHigh => thold_CFGSUBSYSID_USERCLK_posedge_posedge(11),
          SetupLow => tsetup_CFGSUBSYSID_USERCLK_negedge_posedge(11),
          HoldLow => thold_CFGSUBSYSID_USERCLK_negedge_posedge(11),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSID_USERCLK_posedge(12),
          TimingData => Tmkr_CFGSUBSYSID_USERCLK_posedge(12),
          TestSignal => CFGSUBSYSID_USERCLK_dly(12),
          TestSignalName => "CFGSUBSYSID(12)",
          TestDelay => tisd_CFGSUBSYSID_USERCLK(12),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSID_USERCLK_posedge_posedge(12),
          HoldHigh => thold_CFGSUBSYSID_USERCLK_posedge_posedge(12),
          SetupLow => tsetup_CFGSUBSYSID_USERCLK_negedge_posedge(12),
          HoldLow => thold_CFGSUBSYSID_USERCLK_negedge_posedge(12),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSID_USERCLK_posedge(13),
          TimingData => Tmkr_CFGSUBSYSID_USERCLK_posedge(13),
          TestSignal => CFGSUBSYSID_USERCLK_dly(13),
          TestSignalName => "CFGSUBSYSID(13)",
          TestDelay => tisd_CFGSUBSYSID_USERCLK(13),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSID_USERCLK_posedge_posedge(13),
          HoldHigh => thold_CFGSUBSYSID_USERCLK_posedge_posedge(13),
          SetupLow => tsetup_CFGSUBSYSID_USERCLK_negedge_posedge(13),
          HoldLow => thold_CFGSUBSYSID_USERCLK_negedge_posedge(13),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSID_USERCLK_posedge(14),
          TimingData => Tmkr_CFGSUBSYSID_USERCLK_posedge(14),
          TestSignal => CFGSUBSYSID_USERCLK_dly(14),
          TestSignalName => "CFGSUBSYSID(14)",
          TestDelay => tisd_CFGSUBSYSID_USERCLK(14),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSID_USERCLK_posedge_posedge(14),
          HoldHigh => thold_CFGSUBSYSID_USERCLK_posedge_posedge(14),
          SetupLow => tsetup_CFGSUBSYSID_USERCLK_negedge_posedge(14),
          HoldLow => thold_CFGSUBSYSID_USERCLK_negedge_posedge(14),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSID_USERCLK_posedge(15),
          TimingData => Tmkr_CFGSUBSYSID_USERCLK_posedge(15),
          TestSignal => CFGSUBSYSID_USERCLK_dly(15),
          TestSignalName => "CFGSUBSYSID(15)",
          TestDelay => tisd_CFGSUBSYSID_USERCLK(15),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSID_USERCLK_posedge_posedge(15),
          HoldHigh => thold_CFGSUBSYSID_USERCLK_posedge_posedge(15),
          SetupLow => tsetup_CFGSUBSYSID_USERCLK_negedge_posedge(15),
          HoldLow => thold_CFGSUBSYSID_USERCLK_negedge_posedge(15),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSID_USERCLK_posedge(2),
          TimingData => Tmkr_CFGSUBSYSID_USERCLK_posedge(2),
          TestSignal => CFGSUBSYSID_USERCLK_dly(2),
          TestSignalName => "CFGSUBSYSID(2)",
          TestDelay => tisd_CFGSUBSYSID_USERCLK(2),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSID_USERCLK_posedge_posedge(2),
          HoldHigh => thold_CFGSUBSYSID_USERCLK_posedge_posedge(2),
          SetupLow => tsetup_CFGSUBSYSID_USERCLK_negedge_posedge(2),
          HoldLow => thold_CFGSUBSYSID_USERCLK_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSID_USERCLK_posedge(3),
          TimingData => Tmkr_CFGSUBSYSID_USERCLK_posedge(3),
          TestSignal => CFGSUBSYSID_USERCLK_dly(3),
          TestSignalName => "CFGSUBSYSID(3)",
          TestDelay => tisd_CFGSUBSYSID_USERCLK(3),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSID_USERCLK_posedge_posedge(3),
          HoldHigh => thold_CFGSUBSYSID_USERCLK_posedge_posedge(3),
          SetupLow => tsetup_CFGSUBSYSID_USERCLK_negedge_posedge(3),
          HoldLow => thold_CFGSUBSYSID_USERCLK_negedge_posedge(3),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSID_USERCLK_posedge(4),
          TimingData => Tmkr_CFGSUBSYSID_USERCLK_posedge(4),
          TestSignal => CFGSUBSYSID_USERCLK_dly(4),
          TestSignalName => "CFGSUBSYSID(4)",
          TestDelay => tisd_CFGSUBSYSID_USERCLK(4),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSID_USERCLK_posedge_posedge(4),
          HoldHigh => thold_CFGSUBSYSID_USERCLK_posedge_posedge(4),
          SetupLow => tsetup_CFGSUBSYSID_USERCLK_negedge_posedge(4),
          HoldLow => thold_CFGSUBSYSID_USERCLK_negedge_posedge(4),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSID_USERCLK_posedge(5),
          TimingData => Tmkr_CFGSUBSYSID_USERCLK_posedge(5),
          TestSignal => CFGSUBSYSID_USERCLK_dly(5),
          TestSignalName => "CFGSUBSYSID(5)",
          TestDelay => tisd_CFGSUBSYSID_USERCLK(5),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSID_USERCLK_posedge_posedge(5),
          HoldHigh => thold_CFGSUBSYSID_USERCLK_posedge_posedge(5),
          SetupLow => tsetup_CFGSUBSYSID_USERCLK_negedge_posedge(5),
          HoldLow => thold_CFGSUBSYSID_USERCLK_negedge_posedge(5),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSID_USERCLK_posedge(6),
          TimingData => Tmkr_CFGSUBSYSID_USERCLK_posedge(6),
          TestSignal => CFGSUBSYSID_USERCLK_dly(6),
          TestSignalName => "CFGSUBSYSID(6)",
          TestDelay => tisd_CFGSUBSYSID_USERCLK(6),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSID_USERCLK_posedge_posedge(6),
          HoldHigh => thold_CFGSUBSYSID_USERCLK_posedge_posedge(6),
          SetupLow => tsetup_CFGSUBSYSID_USERCLK_negedge_posedge(6),
          HoldLow => thold_CFGSUBSYSID_USERCLK_negedge_posedge(6),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSID_USERCLK_posedge(7),
          TimingData => Tmkr_CFGSUBSYSID_USERCLK_posedge(7),
          TestSignal => CFGSUBSYSID_USERCLK_dly(7),
          TestSignalName => "CFGSUBSYSID(7)",
          TestDelay => tisd_CFGSUBSYSID_USERCLK(7),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSID_USERCLK_posedge_posedge(7),
          HoldHigh => thold_CFGSUBSYSID_USERCLK_posedge_posedge(7),
          SetupLow => tsetup_CFGSUBSYSID_USERCLK_negedge_posedge(7),
          HoldLow => thold_CFGSUBSYSID_USERCLK_negedge_posedge(7),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSID_USERCLK_posedge(8),
          TimingData => Tmkr_CFGSUBSYSID_USERCLK_posedge(8),
          TestSignal => CFGSUBSYSID_USERCLK_dly(8),
          TestSignalName => "CFGSUBSYSID(8)",
          TestDelay => tisd_CFGSUBSYSID_USERCLK(8),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSID_USERCLK_posedge_posedge(8),
          HoldHigh => thold_CFGSUBSYSID_USERCLK_posedge_posedge(8),
          SetupLow => tsetup_CFGSUBSYSID_USERCLK_negedge_posedge(8),
          HoldLow => thold_CFGSUBSYSID_USERCLK_negedge_posedge(8),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSID_USERCLK_posedge(9),
          TimingData => Tmkr_CFGSUBSYSID_USERCLK_posedge(9),
          TestSignal => CFGSUBSYSID_USERCLK_dly(9),
          TestSignalName => "CFGSUBSYSID(9)",
          TestDelay => tisd_CFGSUBSYSID_USERCLK(9),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSID_USERCLK_posedge_posedge(9),
          HoldHigh => thold_CFGSUBSYSID_USERCLK_posedge_posedge(9),
          SetupLow => tsetup_CFGSUBSYSID_USERCLK_negedge_posedge(9),
          HoldLow => thold_CFGSUBSYSID_USERCLK_negedge_posedge(9),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
      end if;
      wait on CFGSUBSYSID_USERCLK_dly;
    end process TIMING_CFGSUBSYSID;
    TIMING_CFGSUBSYSVENID: process
      variable Tmkr_CFGSUBSYSVENID_USERCLK_posedge : VitalTimingDataArrayType(15 downto 0);
      variable Tviol_CFGSUBSYSVENID_USERCLK_posedge : std_logic_vector(15 downto 0) := (others => '0');
      begin
      if (TimingChecksOn) then
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSVENID_USERCLK_posedge(0),
          TimingData => Tmkr_CFGSUBSYSVENID_USERCLK_posedge(0),
          TestSignal => CFGSUBSYSVENID_USERCLK_dly(0),
          TestSignalName => "CFGSUBSYSVENID(0)",
          TestDelay => tisd_CFGSUBSYSVENID_USERCLK(0),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSVENID_USERCLK_posedge_posedge(0),
          HoldHigh => thold_CFGSUBSYSVENID_USERCLK_posedge_posedge(0),
          SetupLow => tsetup_CFGSUBSYSVENID_USERCLK_negedge_posedge(0),
          HoldLow => thold_CFGSUBSYSVENID_USERCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSVENID_USERCLK_posedge(1),
          TimingData => Tmkr_CFGSUBSYSVENID_USERCLK_posedge(1),
          TestSignal => CFGSUBSYSVENID_USERCLK_dly(1),
          TestSignalName => "CFGSUBSYSVENID(1)",
          TestDelay => tisd_CFGSUBSYSVENID_USERCLK(1),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSVENID_USERCLK_posedge_posedge(1),
          HoldHigh => thold_CFGSUBSYSVENID_USERCLK_posedge_posedge(1),
          SetupLow => tsetup_CFGSUBSYSVENID_USERCLK_negedge_posedge(1),
          HoldLow => thold_CFGSUBSYSVENID_USERCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSVENID_USERCLK_posedge(10),
          TimingData => Tmkr_CFGSUBSYSVENID_USERCLK_posedge(10),
          TestSignal => CFGSUBSYSVENID_USERCLK_dly(10),
          TestSignalName => "CFGSUBSYSVENID(10)",
          TestDelay => tisd_CFGSUBSYSVENID_USERCLK(10),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSVENID_USERCLK_posedge_posedge(10),
          HoldHigh => thold_CFGSUBSYSVENID_USERCLK_posedge_posedge(10),
          SetupLow => tsetup_CFGSUBSYSVENID_USERCLK_negedge_posedge(10),
          HoldLow => thold_CFGSUBSYSVENID_USERCLK_negedge_posedge(10),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSVENID_USERCLK_posedge(11),
          TimingData => Tmkr_CFGSUBSYSVENID_USERCLK_posedge(11),
          TestSignal => CFGSUBSYSVENID_USERCLK_dly(11),
          TestSignalName => "CFGSUBSYSVENID(11)",
          TestDelay => tisd_CFGSUBSYSVENID_USERCLK(11),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSVENID_USERCLK_posedge_posedge(11),
          HoldHigh => thold_CFGSUBSYSVENID_USERCLK_posedge_posedge(11),
          SetupLow => tsetup_CFGSUBSYSVENID_USERCLK_negedge_posedge(11),
          HoldLow => thold_CFGSUBSYSVENID_USERCLK_negedge_posedge(11),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSVENID_USERCLK_posedge(12),
          TimingData => Tmkr_CFGSUBSYSVENID_USERCLK_posedge(12),
          TestSignal => CFGSUBSYSVENID_USERCLK_dly(12),
          TestSignalName => "CFGSUBSYSVENID(12)",
          TestDelay => tisd_CFGSUBSYSVENID_USERCLK(12),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSVENID_USERCLK_posedge_posedge(12),
          HoldHigh => thold_CFGSUBSYSVENID_USERCLK_posedge_posedge(12),
          SetupLow => tsetup_CFGSUBSYSVENID_USERCLK_negedge_posedge(12),
          HoldLow => thold_CFGSUBSYSVENID_USERCLK_negedge_posedge(12),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSVENID_USERCLK_posedge(13),
          TimingData => Tmkr_CFGSUBSYSVENID_USERCLK_posedge(13),
          TestSignal => CFGSUBSYSVENID_USERCLK_dly(13),
          TestSignalName => "CFGSUBSYSVENID(13)",
          TestDelay => tisd_CFGSUBSYSVENID_USERCLK(13),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSVENID_USERCLK_posedge_posedge(13),
          HoldHigh => thold_CFGSUBSYSVENID_USERCLK_posedge_posedge(13),
          SetupLow => tsetup_CFGSUBSYSVENID_USERCLK_negedge_posedge(13),
          HoldLow => thold_CFGSUBSYSVENID_USERCLK_negedge_posedge(13),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSVENID_USERCLK_posedge(14),
          TimingData => Tmkr_CFGSUBSYSVENID_USERCLK_posedge(14),
          TestSignal => CFGSUBSYSVENID_USERCLK_dly(14),
          TestSignalName => "CFGSUBSYSVENID(14)",
          TestDelay => tisd_CFGSUBSYSVENID_USERCLK(14),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSVENID_USERCLK_posedge_posedge(14),
          HoldHigh => thold_CFGSUBSYSVENID_USERCLK_posedge_posedge(14),
          SetupLow => tsetup_CFGSUBSYSVENID_USERCLK_negedge_posedge(14),
          HoldLow => thold_CFGSUBSYSVENID_USERCLK_negedge_posedge(14),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSVENID_USERCLK_posedge(15),
          TimingData => Tmkr_CFGSUBSYSVENID_USERCLK_posedge(15),
          TestSignal => CFGSUBSYSVENID_USERCLK_dly(15),
          TestSignalName => "CFGSUBSYSVENID(15)",
          TestDelay => tisd_CFGSUBSYSVENID_USERCLK(15),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSVENID_USERCLK_posedge_posedge(15),
          HoldHigh => thold_CFGSUBSYSVENID_USERCLK_posedge_posedge(15),
          SetupLow => tsetup_CFGSUBSYSVENID_USERCLK_negedge_posedge(15),
          HoldLow => thold_CFGSUBSYSVENID_USERCLK_negedge_posedge(15),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSVENID_USERCLK_posedge(2),
          TimingData => Tmkr_CFGSUBSYSVENID_USERCLK_posedge(2),
          TestSignal => CFGSUBSYSVENID_USERCLK_dly(2),
          TestSignalName => "CFGSUBSYSVENID(2)",
          TestDelay => tisd_CFGSUBSYSVENID_USERCLK(2),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSVENID_USERCLK_posedge_posedge(2),
          HoldHigh => thold_CFGSUBSYSVENID_USERCLK_posedge_posedge(2),
          SetupLow => tsetup_CFGSUBSYSVENID_USERCLK_negedge_posedge(2),
          HoldLow => thold_CFGSUBSYSVENID_USERCLK_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSVENID_USERCLK_posedge(3),
          TimingData => Tmkr_CFGSUBSYSVENID_USERCLK_posedge(3),
          TestSignal => CFGSUBSYSVENID_USERCLK_dly(3),
          TestSignalName => "CFGSUBSYSVENID(3)",
          TestDelay => tisd_CFGSUBSYSVENID_USERCLK(3),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSVENID_USERCLK_posedge_posedge(3),
          HoldHigh => thold_CFGSUBSYSVENID_USERCLK_posedge_posedge(3),
          SetupLow => tsetup_CFGSUBSYSVENID_USERCLK_negedge_posedge(3),
          HoldLow => thold_CFGSUBSYSVENID_USERCLK_negedge_posedge(3),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSVENID_USERCLK_posedge(4),
          TimingData => Tmkr_CFGSUBSYSVENID_USERCLK_posedge(4),
          TestSignal => CFGSUBSYSVENID_USERCLK_dly(4),
          TestSignalName => "CFGSUBSYSVENID(4)",
          TestDelay => tisd_CFGSUBSYSVENID_USERCLK(4),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSVENID_USERCLK_posedge_posedge(4),
          HoldHigh => thold_CFGSUBSYSVENID_USERCLK_posedge_posedge(4),
          SetupLow => tsetup_CFGSUBSYSVENID_USERCLK_negedge_posedge(4),
          HoldLow => thold_CFGSUBSYSVENID_USERCLK_negedge_posedge(4),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSVENID_USERCLK_posedge(5),
          TimingData => Tmkr_CFGSUBSYSVENID_USERCLK_posedge(5),
          TestSignal => CFGSUBSYSVENID_USERCLK_dly(5),
          TestSignalName => "CFGSUBSYSVENID(5)",
          TestDelay => tisd_CFGSUBSYSVENID_USERCLK(5),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSVENID_USERCLK_posedge_posedge(5),
          HoldHigh => thold_CFGSUBSYSVENID_USERCLK_posedge_posedge(5),
          SetupLow => tsetup_CFGSUBSYSVENID_USERCLK_negedge_posedge(5),
          HoldLow => thold_CFGSUBSYSVENID_USERCLK_negedge_posedge(5),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSVENID_USERCLK_posedge(6),
          TimingData => Tmkr_CFGSUBSYSVENID_USERCLK_posedge(6),
          TestSignal => CFGSUBSYSVENID_USERCLK_dly(6),
          TestSignalName => "CFGSUBSYSVENID(6)",
          TestDelay => tisd_CFGSUBSYSVENID_USERCLK(6),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSVENID_USERCLK_posedge_posedge(6),
          HoldHigh => thold_CFGSUBSYSVENID_USERCLK_posedge_posedge(6),
          SetupLow => tsetup_CFGSUBSYSVENID_USERCLK_negedge_posedge(6),
          HoldLow => thold_CFGSUBSYSVENID_USERCLK_negedge_posedge(6),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSVENID_USERCLK_posedge(7),
          TimingData => Tmkr_CFGSUBSYSVENID_USERCLK_posedge(7),
          TestSignal => CFGSUBSYSVENID_USERCLK_dly(7),
          TestSignalName => "CFGSUBSYSVENID(7)",
          TestDelay => tisd_CFGSUBSYSVENID_USERCLK(7),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSVENID_USERCLK_posedge_posedge(7),
          HoldHigh => thold_CFGSUBSYSVENID_USERCLK_posedge_posedge(7),
          SetupLow => tsetup_CFGSUBSYSVENID_USERCLK_negedge_posedge(7),
          HoldLow => thold_CFGSUBSYSVENID_USERCLK_negedge_posedge(7),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSVENID_USERCLK_posedge(8),
          TimingData => Tmkr_CFGSUBSYSVENID_USERCLK_posedge(8),
          TestSignal => CFGSUBSYSVENID_USERCLK_dly(8),
          TestSignalName => "CFGSUBSYSVENID(8)",
          TestDelay => tisd_CFGSUBSYSVENID_USERCLK(8),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSVENID_USERCLK_posedge_posedge(8),
          HoldHigh => thold_CFGSUBSYSVENID_USERCLK_posedge_posedge(8),
          SetupLow => tsetup_CFGSUBSYSVENID_USERCLK_negedge_posedge(8),
          HoldLow => thold_CFGSUBSYSVENID_USERCLK_negedge_posedge(8),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGSUBSYSVENID_USERCLK_posedge(9),
          TimingData => Tmkr_CFGSUBSYSVENID_USERCLK_posedge(9),
          TestSignal => CFGSUBSYSVENID_USERCLK_dly(9),
          TestSignalName => "CFGSUBSYSVENID(9)",
          TestDelay => tisd_CFGSUBSYSVENID_USERCLK(9),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGSUBSYSVENID_USERCLK_posedge_posedge(9),
          HoldHigh => thold_CFGSUBSYSVENID_USERCLK_posedge_posedge(9),
          SetupLow => tsetup_CFGSUBSYSVENID_USERCLK_negedge_posedge(9),
          HoldLow => thold_CFGSUBSYSVENID_USERCLK_negedge_posedge(9),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
      end if;
      wait on CFGSUBSYSVENID_USERCLK_dly;
    end process TIMING_CFGSUBSYSVENID;
    TIMING_CFGVENID: process
      variable Tmkr_CFGVENID_USERCLK_posedge : VitalTimingDataArrayType(15 downto 0);
      variable Tviol_CFGVENID_USERCLK_posedge : std_logic_vector(15 downto 0) := (others => '0');
      begin
      if (TimingChecksOn) then
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGVENID_USERCLK_posedge(0),
          TimingData => Tmkr_CFGVENID_USERCLK_posedge(0),
          TestSignal => CFGVENID_USERCLK_dly(0),
          TestSignalName => "CFGVENID(0)",
          TestDelay => tisd_CFGVENID_USERCLK(0),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGVENID_USERCLK_posedge_posedge(0),
          HoldHigh => thold_CFGVENID_USERCLK_posedge_posedge(0),
          SetupLow => tsetup_CFGVENID_USERCLK_negedge_posedge(0),
          HoldLow => thold_CFGVENID_USERCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGVENID_USERCLK_posedge(1),
          TimingData => Tmkr_CFGVENID_USERCLK_posedge(1),
          TestSignal => CFGVENID_USERCLK_dly(1),
          TestSignalName => "CFGVENID(1)",
          TestDelay => tisd_CFGVENID_USERCLK(1),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGVENID_USERCLK_posedge_posedge(1),
          HoldHigh => thold_CFGVENID_USERCLK_posedge_posedge(1),
          SetupLow => tsetup_CFGVENID_USERCLK_negedge_posedge(1),
          HoldLow => thold_CFGVENID_USERCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGVENID_USERCLK_posedge(10),
          TimingData => Tmkr_CFGVENID_USERCLK_posedge(10),
          TestSignal => CFGVENID_USERCLK_dly(10),
          TestSignalName => "CFGVENID(10)",
          TestDelay => tisd_CFGVENID_USERCLK(10),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGVENID_USERCLK_posedge_posedge(10),
          HoldHigh => thold_CFGVENID_USERCLK_posedge_posedge(10),
          SetupLow => tsetup_CFGVENID_USERCLK_negedge_posedge(10),
          HoldLow => thold_CFGVENID_USERCLK_negedge_posedge(10),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGVENID_USERCLK_posedge(11),
          TimingData => Tmkr_CFGVENID_USERCLK_posedge(11),
          TestSignal => CFGVENID_USERCLK_dly(11),
          TestSignalName => "CFGVENID(11)",
          TestDelay => tisd_CFGVENID_USERCLK(11),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGVENID_USERCLK_posedge_posedge(11),
          HoldHigh => thold_CFGVENID_USERCLK_posedge_posedge(11),
          SetupLow => tsetup_CFGVENID_USERCLK_negedge_posedge(11),
          HoldLow => thold_CFGVENID_USERCLK_negedge_posedge(11),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGVENID_USERCLK_posedge(12),
          TimingData => Tmkr_CFGVENID_USERCLK_posedge(12),
          TestSignal => CFGVENID_USERCLK_dly(12),
          TestSignalName => "CFGVENID(12)",
          TestDelay => tisd_CFGVENID_USERCLK(12),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGVENID_USERCLK_posedge_posedge(12),
          HoldHigh => thold_CFGVENID_USERCLK_posedge_posedge(12),
          SetupLow => tsetup_CFGVENID_USERCLK_negedge_posedge(12),
          HoldLow => thold_CFGVENID_USERCLK_negedge_posedge(12),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGVENID_USERCLK_posedge(13),
          TimingData => Tmkr_CFGVENID_USERCLK_posedge(13),
          TestSignal => CFGVENID_USERCLK_dly(13),
          TestSignalName => "CFGVENID(13)",
          TestDelay => tisd_CFGVENID_USERCLK(13),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGVENID_USERCLK_posedge_posedge(13),
          HoldHigh => thold_CFGVENID_USERCLK_posedge_posedge(13),
          SetupLow => tsetup_CFGVENID_USERCLK_negedge_posedge(13),
          HoldLow => thold_CFGVENID_USERCLK_negedge_posedge(13),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGVENID_USERCLK_posedge(14),
          TimingData => Tmkr_CFGVENID_USERCLK_posedge(14),
          TestSignal => CFGVENID_USERCLK_dly(14),
          TestSignalName => "CFGVENID(14)",
          TestDelay => tisd_CFGVENID_USERCLK(14),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGVENID_USERCLK_posedge_posedge(14),
          HoldHigh => thold_CFGVENID_USERCLK_posedge_posedge(14),
          SetupLow => tsetup_CFGVENID_USERCLK_negedge_posedge(14),
          HoldLow => thold_CFGVENID_USERCLK_negedge_posedge(14),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGVENID_USERCLK_posedge(15),
          TimingData => Tmkr_CFGVENID_USERCLK_posedge(15),
          TestSignal => CFGVENID_USERCLK_dly(15),
          TestSignalName => "CFGVENID(15)",
          TestDelay => tisd_CFGVENID_USERCLK(15),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGVENID_USERCLK_posedge_posedge(15),
          HoldHigh => thold_CFGVENID_USERCLK_posedge_posedge(15),
          SetupLow => tsetup_CFGVENID_USERCLK_negedge_posedge(15),
          HoldLow => thold_CFGVENID_USERCLK_negedge_posedge(15),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGVENID_USERCLK_posedge(2),
          TimingData => Tmkr_CFGVENID_USERCLK_posedge(2),
          TestSignal => CFGVENID_USERCLK_dly(2),
          TestSignalName => "CFGVENID(2)",
          TestDelay => tisd_CFGVENID_USERCLK(2),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGVENID_USERCLK_posedge_posedge(2),
          HoldHigh => thold_CFGVENID_USERCLK_posedge_posedge(2),
          SetupLow => tsetup_CFGVENID_USERCLK_negedge_posedge(2),
          HoldLow => thold_CFGVENID_USERCLK_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGVENID_USERCLK_posedge(3),
          TimingData => Tmkr_CFGVENID_USERCLK_posedge(3),
          TestSignal => CFGVENID_USERCLK_dly(3),
          TestSignalName => "CFGVENID(3)",
          TestDelay => tisd_CFGVENID_USERCLK(3),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGVENID_USERCLK_posedge_posedge(3),
          HoldHigh => thold_CFGVENID_USERCLK_posedge_posedge(3),
          SetupLow => tsetup_CFGVENID_USERCLK_negedge_posedge(3),
          HoldLow => thold_CFGVENID_USERCLK_negedge_posedge(3),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGVENID_USERCLK_posedge(4),
          TimingData => Tmkr_CFGVENID_USERCLK_posedge(4),
          TestSignal => CFGVENID_USERCLK_dly(4),
          TestSignalName => "CFGVENID(4)",
          TestDelay => tisd_CFGVENID_USERCLK(4),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGVENID_USERCLK_posedge_posedge(4),
          HoldHigh => thold_CFGVENID_USERCLK_posedge_posedge(4),
          SetupLow => tsetup_CFGVENID_USERCLK_negedge_posedge(4),
          HoldLow => thold_CFGVENID_USERCLK_negedge_posedge(4),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGVENID_USERCLK_posedge(5),
          TimingData => Tmkr_CFGVENID_USERCLK_posedge(5),
          TestSignal => CFGVENID_USERCLK_dly(5),
          TestSignalName => "CFGVENID(5)",
          TestDelay => tisd_CFGVENID_USERCLK(5),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGVENID_USERCLK_posedge_posedge(5),
          HoldHigh => thold_CFGVENID_USERCLK_posedge_posedge(5),
          SetupLow => tsetup_CFGVENID_USERCLK_negedge_posedge(5),
          HoldLow => thold_CFGVENID_USERCLK_negedge_posedge(5),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGVENID_USERCLK_posedge(6),
          TimingData => Tmkr_CFGVENID_USERCLK_posedge(6),
          TestSignal => CFGVENID_USERCLK_dly(6),
          TestSignalName => "CFGVENID(6)",
          TestDelay => tisd_CFGVENID_USERCLK(6),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGVENID_USERCLK_posedge_posedge(6),
          HoldHigh => thold_CFGVENID_USERCLK_posedge_posedge(6),
          SetupLow => tsetup_CFGVENID_USERCLK_negedge_posedge(6),
          HoldLow => thold_CFGVENID_USERCLK_negedge_posedge(6),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGVENID_USERCLK_posedge(7),
          TimingData => Tmkr_CFGVENID_USERCLK_posedge(7),
          TestSignal => CFGVENID_USERCLK_dly(7),
          TestSignalName => "CFGVENID(7)",
          TestDelay => tisd_CFGVENID_USERCLK(7),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGVENID_USERCLK_posedge_posedge(7),
          HoldHigh => thold_CFGVENID_USERCLK_posedge_posedge(7),
          SetupLow => tsetup_CFGVENID_USERCLK_negedge_posedge(7),
          HoldLow => thold_CFGVENID_USERCLK_negedge_posedge(7),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGVENID_USERCLK_posedge(8),
          TimingData => Tmkr_CFGVENID_USERCLK_posedge(8),
          TestSignal => CFGVENID_USERCLK_dly(8),
          TestSignalName => "CFGVENID(8)",
          TestDelay => tisd_CFGVENID_USERCLK(8),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGVENID_USERCLK_posedge_posedge(8),
          HoldHigh => thold_CFGVENID_USERCLK_posedge_posedge(8),
          SetupLow => tsetup_CFGVENID_USERCLK_negedge_posedge(8),
          HoldLow => thold_CFGVENID_USERCLK_negedge_posedge(8),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGVENID_USERCLK_posedge(9),
          TimingData => Tmkr_CFGVENID_USERCLK_posedge(9),
          TestSignal => CFGVENID_USERCLK_dly(9),
          TestSignalName => "CFGVENID(9)",
          TestDelay => tisd_CFGVENID_USERCLK(9),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGVENID_USERCLK_posedge_posedge(9),
          HoldHigh => thold_CFGVENID_USERCLK_posedge_posedge(9),
          SetupLow => tsetup_CFGVENID_USERCLK_negedge_posedge(9),
          HoldLow => thold_CFGVENID_USERCLK_negedge_posedge(9),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
      end if;
      wait on CFGVENID_USERCLK_dly;
    end process TIMING_CFGVENID;
    TIMING_MIMRXRDATA: process
      variable Tmkr_MIMRXRDATA_USERCLK_posedge : VitalTimingDataArrayType(34 downto 0);
      variable Tviol_MIMRXRDATA_USERCLK_posedge : std_logic_vector(34 downto 0) := (others => '0');
      begin
      if (TimingChecksOn) then
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(0),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(0),
          TestSignal => MIMRXRDATA_USERCLK_dly(0),
          TestSignalName => "MIMRXRDATA(0)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(0),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(0),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(0),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(0),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(1),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(1),
          TestSignal => MIMRXRDATA_USERCLK_dly(1),
          TestSignalName => "MIMRXRDATA(1)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(1),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(1),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(1),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(1),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(10),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(10),
          TestSignal => MIMRXRDATA_USERCLK_dly(10),
          TestSignalName => "MIMRXRDATA(10)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(10),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(10),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(10),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(10),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(10),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(11),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(11),
          TestSignal => MIMRXRDATA_USERCLK_dly(11),
          TestSignalName => "MIMRXRDATA(11)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(11),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(11),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(11),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(11),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(11),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(12),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(12),
          TestSignal => MIMRXRDATA_USERCLK_dly(12),
          TestSignalName => "MIMRXRDATA(12)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(12),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(12),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(12),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(12),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(12),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(13),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(13),
          TestSignal => MIMRXRDATA_USERCLK_dly(13),
          TestSignalName => "MIMRXRDATA(13)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(13),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(13),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(13),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(13),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(13),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(14),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(14),
          TestSignal => MIMRXRDATA_USERCLK_dly(14),
          TestSignalName => "MIMRXRDATA(14)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(14),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(14),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(14),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(14),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(14),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(15),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(15),
          TestSignal => MIMRXRDATA_USERCLK_dly(15),
          TestSignalName => "MIMRXRDATA(15)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(15),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(15),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(15),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(15),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(15),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(16),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(16),
          TestSignal => MIMRXRDATA_USERCLK_dly(16),
          TestSignalName => "MIMRXRDATA(16)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(16),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(16),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(16),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(16),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(16),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(17),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(17),
          TestSignal => MIMRXRDATA_USERCLK_dly(17),
          TestSignalName => "MIMRXRDATA(17)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(17),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(17),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(17),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(17),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(17),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(18),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(18),
          TestSignal => MIMRXRDATA_USERCLK_dly(18),
          TestSignalName => "MIMRXRDATA(18)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(18),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(18),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(18),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(18),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(18),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(19),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(19),
          TestSignal => MIMRXRDATA_USERCLK_dly(19),
          TestSignalName => "MIMRXRDATA(19)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(19),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(19),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(19),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(19),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(19),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(2),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(2),
          TestSignal => MIMRXRDATA_USERCLK_dly(2),
          TestSignalName => "MIMRXRDATA(2)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(2),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(2),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(2),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(2),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(20),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(20),
          TestSignal => MIMRXRDATA_USERCLK_dly(20),
          TestSignalName => "MIMRXRDATA(20)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(20),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(20),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(20),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(20),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(20),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(21),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(21),
          TestSignal => MIMRXRDATA_USERCLK_dly(21),
          TestSignalName => "MIMRXRDATA(21)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(21),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(21),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(21),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(21),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(21),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(22),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(22),
          TestSignal => MIMRXRDATA_USERCLK_dly(22),
          TestSignalName => "MIMRXRDATA(22)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(22),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(22),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(22),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(22),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(22),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(23),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(23),
          TestSignal => MIMRXRDATA_USERCLK_dly(23),
          TestSignalName => "MIMRXRDATA(23)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(23),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(23),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(23),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(23),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(23),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(24),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(24),
          TestSignal => MIMRXRDATA_USERCLK_dly(24),
          TestSignalName => "MIMRXRDATA(24)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(24),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(24),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(24),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(24),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(24),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(25),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(25),
          TestSignal => MIMRXRDATA_USERCLK_dly(25),
          TestSignalName => "MIMRXRDATA(25)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(25),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(25),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(25),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(25),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(25),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(26),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(26),
          TestSignal => MIMRXRDATA_USERCLK_dly(26),
          TestSignalName => "MIMRXRDATA(26)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(26),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(26),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(26),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(26),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(26),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(27),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(27),
          TestSignal => MIMRXRDATA_USERCLK_dly(27),
          TestSignalName => "MIMRXRDATA(27)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(27),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(27),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(27),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(27),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(27),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(28),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(28),
          TestSignal => MIMRXRDATA_USERCLK_dly(28),
          TestSignalName => "MIMRXRDATA(28)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(28),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(28),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(28),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(28),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(28),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(29),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(29),
          TestSignal => MIMRXRDATA_USERCLK_dly(29),
          TestSignalName => "MIMRXRDATA(29)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(29),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(29),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(29),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(29),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(29),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(3),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(3),
          TestSignal => MIMRXRDATA_USERCLK_dly(3),
          TestSignalName => "MIMRXRDATA(3)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(3),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(3),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(3),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(3),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(3),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(30),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(30),
          TestSignal => MIMRXRDATA_USERCLK_dly(30),
          TestSignalName => "MIMRXRDATA(30)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(30),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(30),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(30),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(30),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(30),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(31),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(31),
          TestSignal => MIMRXRDATA_USERCLK_dly(31),
          TestSignalName => "MIMRXRDATA(31)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(31),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(31),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(31),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(31),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(31),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(32),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(32),
          TestSignal => MIMRXRDATA_USERCLK_dly(32),
          TestSignalName => "MIMRXRDATA(32)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(32),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(32),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(32),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(32),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(32),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(33),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(33),
          TestSignal => MIMRXRDATA_USERCLK_dly(33),
          TestSignalName => "MIMRXRDATA(33)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(33),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(33),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(33),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(33),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(33),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(34),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(34),
          TestSignal => MIMRXRDATA_USERCLK_dly(34),
          TestSignalName => "MIMRXRDATA(34)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(34),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(34),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(34),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(34),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(34),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(4),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(4),
          TestSignal => MIMRXRDATA_USERCLK_dly(4),
          TestSignalName => "MIMRXRDATA(4)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(4),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(4),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(4),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(4),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(4),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(5),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(5),
          TestSignal => MIMRXRDATA_USERCLK_dly(5),
          TestSignalName => "MIMRXRDATA(5)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(5),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(5),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(5),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(5),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(5),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(6),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(6),
          TestSignal => MIMRXRDATA_USERCLK_dly(6),
          TestSignalName => "MIMRXRDATA(6)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(6),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(6),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(6),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(6),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(6),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(7),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(7),
          TestSignal => MIMRXRDATA_USERCLK_dly(7),
          TestSignalName => "MIMRXRDATA(7)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(7),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(7),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(7),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(7),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(7),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(8),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(8),
          TestSignal => MIMRXRDATA_USERCLK_dly(8),
          TestSignalName => "MIMRXRDATA(8)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(8),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(8),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(8),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(8),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(8),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMRXRDATA_USERCLK_posedge(9),
          TimingData => Tmkr_MIMRXRDATA_USERCLK_posedge(9),
          TestSignal => MIMRXRDATA_USERCLK_dly(9),
          TestSignalName => "MIMRXRDATA(9)",
          TestDelay => tisd_MIMRXRDATA_USERCLK(9),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMRXRDATA_USERCLK_posedge_posedge(9),
          HoldHigh => thold_MIMRXRDATA_USERCLK_posedge_posedge(9),
          SetupLow => tsetup_MIMRXRDATA_USERCLK_negedge_posedge(9),
          HoldLow => thold_MIMRXRDATA_USERCLK_negedge_posedge(9),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
      end if;
      wait on MIMRXRDATA_USERCLK_dly;
    end process TIMING_MIMRXRDATA;
    TIMING_MIMTXRDATA: process
      variable Tmkr_MIMTXRDATA_USERCLK_posedge : VitalTimingDataArrayType(35 downto 0);
      variable Tviol_MIMTXRDATA_USERCLK_posedge : std_logic_vector(35 downto 0) := (others => '0');
      begin
      if (TimingChecksOn) then
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(0),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(0),
          TestSignal => MIMTXRDATA_USERCLK_dly(0),
          TestSignalName => "MIMTXRDATA(0)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(0),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(0),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(0),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(0),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(1),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(1),
          TestSignal => MIMTXRDATA_USERCLK_dly(1),
          TestSignalName => "MIMTXRDATA(1)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(1),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(1),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(1),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(1),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(10),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(10),
          TestSignal => MIMTXRDATA_USERCLK_dly(10),
          TestSignalName => "MIMTXRDATA(10)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(10),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(10),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(10),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(10),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(10),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(11),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(11),
          TestSignal => MIMTXRDATA_USERCLK_dly(11),
          TestSignalName => "MIMTXRDATA(11)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(11),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(11),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(11),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(11),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(11),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(12),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(12),
          TestSignal => MIMTXRDATA_USERCLK_dly(12),
          TestSignalName => "MIMTXRDATA(12)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(12),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(12),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(12),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(12),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(12),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(13),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(13),
          TestSignal => MIMTXRDATA_USERCLK_dly(13),
          TestSignalName => "MIMTXRDATA(13)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(13),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(13),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(13),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(13),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(13),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(14),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(14),
          TestSignal => MIMTXRDATA_USERCLK_dly(14),
          TestSignalName => "MIMTXRDATA(14)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(14),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(14),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(14),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(14),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(14),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(15),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(15),
          TestSignal => MIMTXRDATA_USERCLK_dly(15),
          TestSignalName => "MIMTXRDATA(15)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(15),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(15),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(15),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(15),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(15),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(16),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(16),
          TestSignal => MIMTXRDATA_USERCLK_dly(16),
          TestSignalName => "MIMTXRDATA(16)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(16),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(16),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(16),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(16),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(16),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(17),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(17),
          TestSignal => MIMTXRDATA_USERCLK_dly(17),
          TestSignalName => "MIMTXRDATA(17)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(17),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(17),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(17),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(17),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(17),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(18),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(18),
          TestSignal => MIMTXRDATA_USERCLK_dly(18),
          TestSignalName => "MIMTXRDATA(18)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(18),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(18),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(18),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(18),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(18),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(19),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(19),
          TestSignal => MIMTXRDATA_USERCLK_dly(19),
          TestSignalName => "MIMTXRDATA(19)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(19),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(19),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(19),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(19),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(19),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(2),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(2),
          TestSignal => MIMTXRDATA_USERCLK_dly(2),
          TestSignalName => "MIMTXRDATA(2)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(2),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(2),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(2),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(2),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(20),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(20),
          TestSignal => MIMTXRDATA_USERCLK_dly(20),
          TestSignalName => "MIMTXRDATA(20)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(20),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(20),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(20),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(20),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(20),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(21),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(21),
          TestSignal => MIMTXRDATA_USERCLK_dly(21),
          TestSignalName => "MIMTXRDATA(21)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(21),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(21),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(21),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(21),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(21),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(22),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(22),
          TestSignal => MIMTXRDATA_USERCLK_dly(22),
          TestSignalName => "MIMTXRDATA(22)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(22),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(22),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(22),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(22),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(22),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(23),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(23),
          TestSignal => MIMTXRDATA_USERCLK_dly(23),
          TestSignalName => "MIMTXRDATA(23)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(23),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(23),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(23),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(23),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(23),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(24),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(24),
          TestSignal => MIMTXRDATA_USERCLK_dly(24),
          TestSignalName => "MIMTXRDATA(24)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(24),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(24),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(24),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(24),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(24),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(25),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(25),
          TestSignal => MIMTXRDATA_USERCLK_dly(25),
          TestSignalName => "MIMTXRDATA(25)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(25),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(25),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(25),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(25),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(25),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(26),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(26),
          TestSignal => MIMTXRDATA_USERCLK_dly(26),
          TestSignalName => "MIMTXRDATA(26)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(26),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(26),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(26),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(26),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(26),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(27),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(27),
          TestSignal => MIMTXRDATA_USERCLK_dly(27),
          TestSignalName => "MIMTXRDATA(27)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(27),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(27),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(27),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(27),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(27),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(28),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(28),
          TestSignal => MIMTXRDATA_USERCLK_dly(28),
          TestSignalName => "MIMTXRDATA(28)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(28),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(28),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(28),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(28),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(28),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(29),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(29),
          TestSignal => MIMTXRDATA_USERCLK_dly(29),
          TestSignalName => "MIMTXRDATA(29)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(29),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(29),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(29),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(29),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(29),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(3),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(3),
          TestSignal => MIMTXRDATA_USERCLK_dly(3),
          TestSignalName => "MIMTXRDATA(3)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(3),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(3),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(3),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(3),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(3),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(30),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(30),
          TestSignal => MIMTXRDATA_USERCLK_dly(30),
          TestSignalName => "MIMTXRDATA(30)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(30),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(30),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(30),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(30),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(30),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(31),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(31),
          TestSignal => MIMTXRDATA_USERCLK_dly(31),
          TestSignalName => "MIMTXRDATA(31)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(31),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(31),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(31),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(31),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(31),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(32),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(32),
          TestSignal => MIMTXRDATA_USERCLK_dly(32),
          TestSignalName => "MIMTXRDATA(32)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(32),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(32),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(32),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(32),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(32),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(33),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(33),
          TestSignal => MIMTXRDATA_USERCLK_dly(33),
          TestSignalName => "MIMTXRDATA(33)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(33),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(33),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(33),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(33),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(33),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(34),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(34),
          TestSignal => MIMTXRDATA_USERCLK_dly(34),
          TestSignalName => "MIMTXRDATA(34)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(34),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(34),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(34),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(34),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(34),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(35),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(35),
          TestSignal => MIMTXRDATA_USERCLK_dly(35),
          TestSignalName => "MIMTXRDATA(35)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(35),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(35),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(35),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(35),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(35),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(4),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(4),
          TestSignal => MIMTXRDATA_USERCLK_dly(4),
          TestSignalName => "MIMTXRDATA(4)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(4),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(4),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(4),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(4),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(4),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(5),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(5),
          TestSignal => MIMTXRDATA_USERCLK_dly(5),
          TestSignalName => "MIMTXRDATA(5)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(5),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(5),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(5),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(5),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(5),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(6),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(6),
          TestSignal => MIMTXRDATA_USERCLK_dly(6),
          TestSignalName => "MIMTXRDATA(6)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(6),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(6),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(6),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(6),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(6),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(7),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(7),
          TestSignal => MIMTXRDATA_USERCLK_dly(7),
          TestSignalName => "MIMTXRDATA(7)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(7),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(7),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(7),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(7),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(7),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(8),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(8),
          TestSignal => MIMTXRDATA_USERCLK_dly(8),
          TestSignalName => "MIMTXRDATA(8)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(8),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(8),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(8),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(8),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(8),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_MIMTXRDATA_USERCLK_posedge(9),
          TimingData => Tmkr_MIMTXRDATA_USERCLK_posedge(9),
          TestSignal => MIMTXRDATA_USERCLK_dly(9),
          TestSignalName => "MIMTXRDATA(9)",
          TestDelay => tisd_MIMTXRDATA_USERCLK(9),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_MIMTXRDATA_USERCLK_posedge_posedge(9),
          HoldHigh => thold_MIMTXRDATA_USERCLK_posedge_posedge(9),
          SetupLow => tsetup_MIMTXRDATA_USERCLK_negedge_posedge(9),
          HoldLow => thold_MIMTXRDATA_USERCLK_negedge_posedge(9),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
      end if;
      wait on MIMTXRDATA_USERCLK_dly;
    end process TIMING_MIMTXRDATA;
    TIMING_PIPERXCHARISKA: process
      variable Tmkr_PIPERXCHARISKA_MGTCLK_posedge : VitalTimingDataArrayType(1 downto 0);
      variable Tviol_PIPERXCHARISKA_MGTCLK_posedge : std_logic_vector(1 downto 0) := (others => '0');
      begin
      if (TimingChecksOn) then
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXCHARISKA_MGTCLK_posedge(0),
          TimingData => Tmkr_PIPERXCHARISKA_MGTCLK_posedge(0),
          TestSignal => PIPERXCHARISKA_MGTCLK_dly(0),
          TestSignalName => "PIPERXCHARISKA(0)",
          TestDelay => tisd_PIPERXCHARISKA_MGTCLK(0),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXCHARISKA_MGTCLK_posedge_posedge(0),
          HoldHigh => thold_PIPERXCHARISKA_MGTCLK_posedge_posedge(0),
          SetupLow => tsetup_PIPERXCHARISKA_MGTCLK_negedge_posedge(0),
          HoldLow => thold_PIPERXCHARISKA_MGTCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXCHARISKA_MGTCLK_posedge(1),
          TimingData => Tmkr_PIPERXCHARISKA_MGTCLK_posedge(1),
          TestSignal => PIPERXCHARISKA_MGTCLK_dly(1),
          TestSignalName => "PIPERXCHARISKA(1)",
          TestDelay => tisd_PIPERXCHARISKA_MGTCLK(1),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXCHARISKA_MGTCLK_posedge_posedge(1),
          HoldHigh => thold_PIPERXCHARISKA_MGTCLK_posedge_posedge(1),
          SetupLow => tsetup_PIPERXCHARISKA_MGTCLK_negedge_posedge(1),
          HoldLow => thold_PIPERXCHARISKA_MGTCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
      end if;
      wait on PIPERXCHARISKA_MGTCLK_dly;
    end process TIMING_PIPERXCHARISKA;
    TIMING_PIPERXCHARISKB: process
      variable Tmkr_PIPERXCHARISKB_MGTCLK_posedge : VitalTimingDataArrayType(1 downto 0);
      variable Tviol_PIPERXCHARISKB_MGTCLK_posedge : std_logic_vector(1 downto 0) := (others => '0');
      begin
      if (TimingChecksOn) then
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXCHARISKB_MGTCLK_posedge(0),
          TimingData => Tmkr_PIPERXCHARISKB_MGTCLK_posedge(0),
          TestSignal => PIPERXCHARISKB_MGTCLK_dly(0),
          TestSignalName => "PIPERXCHARISKB(0)",
          TestDelay => tisd_PIPERXCHARISKB_MGTCLK(0),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXCHARISKB_MGTCLK_posedge_posedge(0),
          HoldHigh => thold_PIPERXCHARISKB_MGTCLK_posedge_posedge(0),
          SetupLow => tsetup_PIPERXCHARISKB_MGTCLK_negedge_posedge(0),
          HoldLow => thold_PIPERXCHARISKB_MGTCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXCHARISKB_MGTCLK_posedge(1),
          TimingData => Tmkr_PIPERXCHARISKB_MGTCLK_posedge(1),
          TestSignal => PIPERXCHARISKB_MGTCLK_dly(1),
          TestSignalName => "PIPERXCHARISKB(1)",
          TestDelay => tisd_PIPERXCHARISKB_MGTCLK(1),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXCHARISKB_MGTCLK_posedge_posedge(1),
          HoldHigh => thold_PIPERXCHARISKB_MGTCLK_posedge_posedge(1),
          SetupLow => tsetup_PIPERXCHARISKB_MGTCLK_negedge_posedge(1),
          HoldLow => thold_PIPERXCHARISKB_MGTCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
      end if;
      wait on PIPERXCHARISKB_MGTCLK_dly;
    end process TIMING_PIPERXCHARISKB;
    TIMING_PIPERXDATAA: process
      variable Tmkr_PIPERXDATAA_MGTCLK_posedge : VitalTimingDataArrayType(15 downto 0);
      variable Tviol_PIPERXDATAA_MGTCLK_posedge : std_logic_vector(15 downto 0) := (others => '0');
      begin
      if (TimingChecksOn) then
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAA_MGTCLK_posedge(0),
          TimingData => Tmkr_PIPERXDATAA_MGTCLK_posedge(0),
          TestSignal => PIPERXDATAA_MGTCLK_dly(0),
          TestSignalName => "PIPERXDATAA(0)",
          TestDelay => tisd_PIPERXDATAA_MGTCLK(0),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAA_MGTCLK_posedge_posedge(0),
          HoldHigh => thold_PIPERXDATAA_MGTCLK_posedge_posedge(0),
          SetupLow => tsetup_PIPERXDATAA_MGTCLK_negedge_posedge(0),
          HoldLow => thold_PIPERXDATAA_MGTCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAA_MGTCLK_posedge(1),
          TimingData => Tmkr_PIPERXDATAA_MGTCLK_posedge(1),
          TestSignal => PIPERXDATAA_MGTCLK_dly(1),
          TestSignalName => "PIPERXDATAA(1)",
          TestDelay => tisd_PIPERXDATAA_MGTCLK(1),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAA_MGTCLK_posedge_posedge(1),
          HoldHigh => thold_PIPERXDATAA_MGTCLK_posedge_posedge(1),
          SetupLow => tsetup_PIPERXDATAA_MGTCLK_negedge_posedge(1),
          HoldLow => thold_PIPERXDATAA_MGTCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAA_MGTCLK_posedge(10),
          TimingData => Tmkr_PIPERXDATAA_MGTCLK_posedge(10),
          TestSignal => PIPERXDATAA_MGTCLK_dly(10),
          TestSignalName => "PIPERXDATAA(10)",
          TestDelay => tisd_PIPERXDATAA_MGTCLK(10),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAA_MGTCLK_posedge_posedge(10),
          HoldHigh => thold_PIPERXDATAA_MGTCLK_posedge_posedge(10),
          SetupLow => tsetup_PIPERXDATAA_MGTCLK_negedge_posedge(10),
          HoldLow => thold_PIPERXDATAA_MGTCLK_negedge_posedge(10),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAA_MGTCLK_posedge(11),
          TimingData => Tmkr_PIPERXDATAA_MGTCLK_posedge(11),
          TestSignal => PIPERXDATAA_MGTCLK_dly(11),
          TestSignalName => "PIPERXDATAA(11)",
          TestDelay => tisd_PIPERXDATAA_MGTCLK(11),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAA_MGTCLK_posedge_posedge(11),
          HoldHigh => thold_PIPERXDATAA_MGTCLK_posedge_posedge(11),
          SetupLow => tsetup_PIPERXDATAA_MGTCLK_negedge_posedge(11),
          HoldLow => thold_PIPERXDATAA_MGTCLK_negedge_posedge(11),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAA_MGTCLK_posedge(12),
          TimingData => Tmkr_PIPERXDATAA_MGTCLK_posedge(12),
          TestSignal => PIPERXDATAA_MGTCLK_dly(12),
          TestSignalName => "PIPERXDATAA(12)",
          TestDelay => tisd_PIPERXDATAA_MGTCLK(12),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAA_MGTCLK_posedge_posedge(12),
          HoldHigh => thold_PIPERXDATAA_MGTCLK_posedge_posedge(12),
          SetupLow => tsetup_PIPERXDATAA_MGTCLK_negedge_posedge(12),
          HoldLow => thold_PIPERXDATAA_MGTCLK_negedge_posedge(12),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAA_MGTCLK_posedge(13),
          TimingData => Tmkr_PIPERXDATAA_MGTCLK_posedge(13),
          TestSignal => PIPERXDATAA_MGTCLK_dly(13),
          TestSignalName => "PIPERXDATAA(13)",
          TestDelay => tisd_PIPERXDATAA_MGTCLK(13),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAA_MGTCLK_posedge_posedge(13),
          HoldHigh => thold_PIPERXDATAA_MGTCLK_posedge_posedge(13),
          SetupLow => tsetup_PIPERXDATAA_MGTCLK_negedge_posedge(13),
          HoldLow => thold_PIPERXDATAA_MGTCLK_negedge_posedge(13),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAA_MGTCLK_posedge(14),
          TimingData => Tmkr_PIPERXDATAA_MGTCLK_posedge(14),
          TestSignal => PIPERXDATAA_MGTCLK_dly(14),
          TestSignalName => "PIPERXDATAA(14)",
          TestDelay => tisd_PIPERXDATAA_MGTCLK(14),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAA_MGTCLK_posedge_posedge(14),
          HoldHigh => thold_PIPERXDATAA_MGTCLK_posedge_posedge(14),
          SetupLow => tsetup_PIPERXDATAA_MGTCLK_negedge_posedge(14),
          HoldLow => thold_PIPERXDATAA_MGTCLK_negedge_posedge(14),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAA_MGTCLK_posedge(15),
          TimingData => Tmkr_PIPERXDATAA_MGTCLK_posedge(15),
          TestSignal => PIPERXDATAA_MGTCLK_dly(15),
          TestSignalName => "PIPERXDATAA(15)",
          TestDelay => tisd_PIPERXDATAA_MGTCLK(15),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAA_MGTCLK_posedge_posedge(15),
          HoldHigh => thold_PIPERXDATAA_MGTCLK_posedge_posedge(15),
          SetupLow => tsetup_PIPERXDATAA_MGTCLK_negedge_posedge(15),
          HoldLow => thold_PIPERXDATAA_MGTCLK_negedge_posedge(15),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAA_MGTCLK_posedge(2),
          TimingData => Tmkr_PIPERXDATAA_MGTCLK_posedge(2),
          TestSignal => PIPERXDATAA_MGTCLK_dly(2),
          TestSignalName => "PIPERXDATAA(2)",
          TestDelay => tisd_PIPERXDATAA_MGTCLK(2),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAA_MGTCLK_posedge_posedge(2),
          HoldHigh => thold_PIPERXDATAA_MGTCLK_posedge_posedge(2),
          SetupLow => tsetup_PIPERXDATAA_MGTCLK_negedge_posedge(2),
          HoldLow => thold_PIPERXDATAA_MGTCLK_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAA_MGTCLK_posedge(3),
          TimingData => Tmkr_PIPERXDATAA_MGTCLK_posedge(3),
          TestSignal => PIPERXDATAA_MGTCLK_dly(3),
          TestSignalName => "PIPERXDATAA(3)",
          TestDelay => tisd_PIPERXDATAA_MGTCLK(3),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAA_MGTCLK_posedge_posedge(3),
          HoldHigh => thold_PIPERXDATAA_MGTCLK_posedge_posedge(3),
          SetupLow => tsetup_PIPERXDATAA_MGTCLK_negedge_posedge(3),
          HoldLow => thold_PIPERXDATAA_MGTCLK_negedge_posedge(3),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAA_MGTCLK_posedge(4),
          TimingData => Tmkr_PIPERXDATAA_MGTCLK_posedge(4),
          TestSignal => PIPERXDATAA_MGTCLK_dly(4),
          TestSignalName => "PIPERXDATAA(4)",
          TestDelay => tisd_PIPERXDATAA_MGTCLK(4),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAA_MGTCLK_posedge_posedge(4),
          HoldHigh => thold_PIPERXDATAA_MGTCLK_posedge_posedge(4),
          SetupLow => tsetup_PIPERXDATAA_MGTCLK_negedge_posedge(4),
          HoldLow => thold_PIPERXDATAA_MGTCLK_negedge_posedge(4),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAA_MGTCLK_posedge(5),
          TimingData => Tmkr_PIPERXDATAA_MGTCLK_posedge(5),
          TestSignal => PIPERXDATAA_MGTCLK_dly(5),
          TestSignalName => "PIPERXDATAA(5)",
          TestDelay => tisd_PIPERXDATAA_MGTCLK(5),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAA_MGTCLK_posedge_posedge(5),
          HoldHigh => thold_PIPERXDATAA_MGTCLK_posedge_posedge(5),
          SetupLow => tsetup_PIPERXDATAA_MGTCLK_negedge_posedge(5),
          HoldLow => thold_PIPERXDATAA_MGTCLK_negedge_posedge(5),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAA_MGTCLK_posedge(6),
          TimingData => Tmkr_PIPERXDATAA_MGTCLK_posedge(6),
          TestSignal => PIPERXDATAA_MGTCLK_dly(6),
          TestSignalName => "PIPERXDATAA(6)",
          TestDelay => tisd_PIPERXDATAA_MGTCLK(6),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAA_MGTCLK_posedge_posedge(6),
          HoldHigh => thold_PIPERXDATAA_MGTCLK_posedge_posedge(6),
          SetupLow => tsetup_PIPERXDATAA_MGTCLK_negedge_posedge(6),
          HoldLow => thold_PIPERXDATAA_MGTCLK_negedge_posedge(6),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAA_MGTCLK_posedge(7),
          TimingData => Tmkr_PIPERXDATAA_MGTCLK_posedge(7),
          TestSignal => PIPERXDATAA_MGTCLK_dly(7),
          TestSignalName => "PIPERXDATAA(7)",
          TestDelay => tisd_PIPERXDATAA_MGTCLK(7),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAA_MGTCLK_posedge_posedge(7),
          HoldHigh => thold_PIPERXDATAA_MGTCLK_posedge_posedge(7),
          SetupLow => tsetup_PIPERXDATAA_MGTCLK_negedge_posedge(7),
          HoldLow => thold_PIPERXDATAA_MGTCLK_negedge_posedge(7),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAA_MGTCLK_posedge(8),
          TimingData => Tmkr_PIPERXDATAA_MGTCLK_posedge(8),
          TestSignal => PIPERXDATAA_MGTCLK_dly(8),
          TestSignalName => "PIPERXDATAA(8)",
          TestDelay => tisd_PIPERXDATAA_MGTCLK(8),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAA_MGTCLK_posedge_posedge(8),
          HoldHigh => thold_PIPERXDATAA_MGTCLK_posedge_posedge(8),
          SetupLow => tsetup_PIPERXDATAA_MGTCLK_negedge_posedge(8),
          HoldLow => thold_PIPERXDATAA_MGTCLK_negedge_posedge(8),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAA_MGTCLK_posedge(9),
          TimingData => Tmkr_PIPERXDATAA_MGTCLK_posedge(9),
          TestSignal => PIPERXDATAA_MGTCLK_dly(9),
          TestSignalName => "PIPERXDATAA(9)",
          TestDelay => tisd_PIPERXDATAA_MGTCLK(9),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAA_MGTCLK_posedge_posedge(9),
          HoldHigh => thold_PIPERXDATAA_MGTCLK_posedge_posedge(9),
          SetupLow => tsetup_PIPERXDATAA_MGTCLK_negedge_posedge(9),
          HoldLow => thold_PIPERXDATAA_MGTCLK_negedge_posedge(9),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
      end if;
      wait on PIPERXDATAA_MGTCLK_dly;
    end process TIMING_PIPERXDATAA;
    TIMING_PIPERXDATAB: process
      variable Tmkr_PIPERXDATAB_MGTCLK_posedge : VitalTimingDataArrayType(15 downto 0);
      variable Tviol_PIPERXDATAB_MGTCLK_posedge : std_logic_vector(15 downto 0) := (others => '0');
      begin
      if (TimingChecksOn) then
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAB_MGTCLK_posedge(0),
          TimingData => Tmkr_PIPERXDATAB_MGTCLK_posedge(0),
          TestSignal => PIPERXDATAB_MGTCLK_dly(0),
          TestSignalName => "PIPERXDATAB(0)",
          TestDelay => tisd_PIPERXDATAB_MGTCLK(0),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAB_MGTCLK_posedge_posedge(0),
          HoldHigh => thold_PIPERXDATAB_MGTCLK_posedge_posedge(0),
          SetupLow => tsetup_PIPERXDATAB_MGTCLK_negedge_posedge(0),
          HoldLow => thold_PIPERXDATAB_MGTCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAB_MGTCLK_posedge(1),
          TimingData => Tmkr_PIPERXDATAB_MGTCLK_posedge(1),
          TestSignal => PIPERXDATAB_MGTCLK_dly(1),
          TestSignalName => "PIPERXDATAB(1)",
          TestDelay => tisd_PIPERXDATAB_MGTCLK(1),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAB_MGTCLK_posedge_posedge(1),
          HoldHigh => thold_PIPERXDATAB_MGTCLK_posedge_posedge(1),
          SetupLow => tsetup_PIPERXDATAB_MGTCLK_negedge_posedge(1),
          HoldLow => thold_PIPERXDATAB_MGTCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAB_MGTCLK_posedge(10),
          TimingData => Tmkr_PIPERXDATAB_MGTCLK_posedge(10),
          TestSignal => PIPERXDATAB_MGTCLK_dly(10),
          TestSignalName => "PIPERXDATAB(10)",
          TestDelay => tisd_PIPERXDATAB_MGTCLK(10),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAB_MGTCLK_posedge_posedge(10),
          HoldHigh => thold_PIPERXDATAB_MGTCLK_posedge_posedge(10),
          SetupLow => tsetup_PIPERXDATAB_MGTCLK_negedge_posedge(10),
          HoldLow => thold_PIPERXDATAB_MGTCLK_negedge_posedge(10),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAB_MGTCLK_posedge(11),
          TimingData => Tmkr_PIPERXDATAB_MGTCLK_posedge(11),
          TestSignal => PIPERXDATAB_MGTCLK_dly(11),
          TestSignalName => "PIPERXDATAB(11)",
          TestDelay => tisd_PIPERXDATAB_MGTCLK(11),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAB_MGTCLK_posedge_posedge(11),
          HoldHigh => thold_PIPERXDATAB_MGTCLK_posedge_posedge(11),
          SetupLow => tsetup_PIPERXDATAB_MGTCLK_negedge_posedge(11),
          HoldLow => thold_PIPERXDATAB_MGTCLK_negedge_posedge(11),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAB_MGTCLK_posedge(12),
          TimingData => Tmkr_PIPERXDATAB_MGTCLK_posedge(12),
          TestSignal => PIPERXDATAB_MGTCLK_dly(12),
          TestSignalName => "PIPERXDATAB(12)",
          TestDelay => tisd_PIPERXDATAB_MGTCLK(12),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAB_MGTCLK_posedge_posedge(12),
          HoldHigh => thold_PIPERXDATAB_MGTCLK_posedge_posedge(12),
          SetupLow => tsetup_PIPERXDATAB_MGTCLK_negedge_posedge(12),
          HoldLow => thold_PIPERXDATAB_MGTCLK_negedge_posedge(12),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAB_MGTCLK_posedge(13),
          TimingData => Tmkr_PIPERXDATAB_MGTCLK_posedge(13),
          TestSignal => PIPERXDATAB_MGTCLK_dly(13),
          TestSignalName => "PIPERXDATAB(13)",
          TestDelay => tisd_PIPERXDATAB_MGTCLK(13),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAB_MGTCLK_posedge_posedge(13),
          HoldHigh => thold_PIPERXDATAB_MGTCLK_posedge_posedge(13),
          SetupLow => tsetup_PIPERXDATAB_MGTCLK_negedge_posedge(13),
          HoldLow => thold_PIPERXDATAB_MGTCLK_negedge_posedge(13),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAB_MGTCLK_posedge(14),
          TimingData => Tmkr_PIPERXDATAB_MGTCLK_posedge(14),
          TestSignal => PIPERXDATAB_MGTCLK_dly(14),
          TestSignalName => "PIPERXDATAB(14)",
          TestDelay => tisd_PIPERXDATAB_MGTCLK(14),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAB_MGTCLK_posedge_posedge(14),
          HoldHigh => thold_PIPERXDATAB_MGTCLK_posedge_posedge(14),
          SetupLow => tsetup_PIPERXDATAB_MGTCLK_negedge_posedge(14),
          HoldLow => thold_PIPERXDATAB_MGTCLK_negedge_posedge(14),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAB_MGTCLK_posedge(15),
          TimingData => Tmkr_PIPERXDATAB_MGTCLK_posedge(15),
          TestSignal => PIPERXDATAB_MGTCLK_dly(15),
          TestSignalName => "PIPERXDATAB(15)",
          TestDelay => tisd_PIPERXDATAB_MGTCLK(15),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAB_MGTCLK_posedge_posedge(15),
          HoldHigh => thold_PIPERXDATAB_MGTCLK_posedge_posedge(15),
          SetupLow => tsetup_PIPERXDATAB_MGTCLK_negedge_posedge(15),
          HoldLow => thold_PIPERXDATAB_MGTCLK_negedge_posedge(15),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAB_MGTCLK_posedge(2),
          TimingData => Tmkr_PIPERXDATAB_MGTCLK_posedge(2),
          TestSignal => PIPERXDATAB_MGTCLK_dly(2),
          TestSignalName => "PIPERXDATAB(2)",
          TestDelay => tisd_PIPERXDATAB_MGTCLK(2),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAB_MGTCLK_posedge_posedge(2),
          HoldHigh => thold_PIPERXDATAB_MGTCLK_posedge_posedge(2),
          SetupLow => tsetup_PIPERXDATAB_MGTCLK_negedge_posedge(2),
          HoldLow => thold_PIPERXDATAB_MGTCLK_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAB_MGTCLK_posedge(3),
          TimingData => Tmkr_PIPERXDATAB_MGTCLK_posedge(3),
          TestSignal => PIPERXDATAB_MGTCLK_dly(3),
          TestSignalName => "PIPERXDATAB(3)",
          TestDelay => tisd_PIPERXDATAB_MGTCLK(3),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAB_MGTCLK_posedge_posedge(3),
          HoldHigh => thold_PIPERXDATAB_MGTCLK_posedge_posedge(3),
          SetupLow => tsetup_PIPERXDATAB_MGTCLK_negedge_posedge(3),
          HoldLow => thold_PIPERXDATAB_MGTCLK_negedge_posedge(3),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAB_MGTCLK_posedge(4),
          TimingData => Tmkr_PIPERXDATAB_MGTCLK_posedge(4),
          TestSignal => PIPERXDATAB_MGTCLK_dly(4),
          TestSignalName => "PIPERXDATAB(4)",
          TestDelay => tisd_PIPERXDATAB_MGTCLK(4),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAB_MGTCLK_posedge_posedge(4),
          HoldHigh => thold_PIPERXDATAB_MGTCLK_posedge_posedge(4),
          SetupLow => tsetup_PIPERXDATAB_MGTCLK_negedge_posedge(4),
          HoldLow => thold_PIPERXDATAB_MGTCLK_negedge_posedge(4),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAB_MGTCLK_posedge(5),
          TimingData => Tmkr_PIPERXDATAB_MGTCLK_posedge(5),
          TestSignal => PIPERXDATAB_MGTCLK_dly(5),
          TestSignalName => "PIPERXDATAB(5)",
          TestDelay => tisd_PIPERXDATAB_MGTCLK(5),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAB_MGTCLK_posedge_posedge(5),
          HoldHigh => thold_PIPERXDATAB_MGTCLK_posedge_posedge(5),
          SetupLow => tsetup_PIPERXDATAB_MGTCLK_negedge_posedge(5),
          HoldLow => thold_PIPERXDATAB_MGTCLK_negedge_posedge(5),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAB_MGTCLK_posedge(6),
          TimingData => Tmkr_PIPERXDATAB_MGTCLK_posedge(6),
          TestSignal => PIPERXDATAB_MGTCLK_dly(6),
          TestSignalName => "PIPERXDATAB(6)",
          TestDelay => tisd_PIPERXDATAB_MGTCLK(6),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAB_MGTCLK_posedge_posedge(6),
          HoldHigh => thold_PIPERXDATAB_MGTCLK_posedge_posedge(6),
          SetupLow => tsetup_PIPERXDATAB_MGTCLK_negedge_posedge(6),
          HoldLow => thold_PIPERXDATAB_MGTCLK_negedge_posedge(6),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAB_MGTCLK_posedge(7),
          TimingData => Tmkr_PIPERXDATAB_MGTCLK_posedge(7),
          TestSignal => PIPERXDATAB_MGTCLK_dly(7),
          TestSignalName => "PIPERXDATAB(7)",
          TestDelay => tisd_PIPERXDATAB_MGTCLK(7),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAB_MGTCLK_posedge_posedge(7),
          HoldHigh => thold_PIPERXDATAB_MGTCLK_posedge_posedge(7),
          SetupLow => tsetup_PIPERXDATAB_MGTCLK_negedge_posedge(7),
          HoldLow => thold_PIPERXDATAB_MGTCLK_negedge_posedge(7),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAB_MGTCLK_posedge(8),
          TimingData => Tmkr_PIPERXDATAB_MGTCLK_posedge(8),
          TestSignal => PIPERXDATAB_MGTCLK_dly(8),
          TestSignalName => "PIPERXDATAB(8)",
          TestDelay => tisd_PIPERXDATAB_MGTCLK(8),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAB_MGTCLK_posedge_posedge(8),
          HoldHigh => thold_PIPERXDATAB_MGTCLK_posedge_posedge(8),
          SetupLow => tsetup_PIPERXDATAB_MGTCLK_negedge_posedge(8),
          HoldLow => thold_PIPERXDATAB_MGTCLK_negedge_posedge(8),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXDATAB_MGTCLK_posedge(9),
          TimingData => Tmkr_PIPERXDATAB_MGTCLK_posedge(9),
          TestSignal => PIPERXDATAB_MGTCLK_dly(9),
          TestSignalName => "PIPERXDATAB(9)",
          TestDelay => tisd_PIPERXDATAB_MGTCLK(9),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXDATAB_MGTCLK_posedge_posedge(9),
          HoldHigh => thold_PIPERXDATAB_MGTCLK_posedge_posedge(9),
          SetupLow => tsetup_PIPERXDATAB_MGTCLK_negedge_posedge(9),
          HoldLow => thold_PIPERXDATAB_MGTCLK_negedge_posedge(9),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
      end if;
      wait on PIPERXDATAB_MGTCLK_dly;
    end process TIMING_PIPERXDATAB;
    TIMING_PIPERXSTATUSA: process
      variable Tmkr_PIPERXSTATUSA_MGTCLK_posedge : VitalTimingDataArrayType(2 downto 0);
      variable Tviol_PIPERXSTATUSA_MGTCLK_posedge : std_logic_vector(2 downto 0) := (others => '0');
      begin
      if (TimingChecksOn) then
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXSTATUSA_MGTCLK_posedge(0),
          TimingData => Tmkr_PIPERXSTATUSA_MGTCLK_posedge(0),
          TestSignal => PIPERXSTATUSA_MGTCLK_dly(0),
          TestSignalName => "PIPERXSTATUSA(0)",
          TestDelay => tisd_PIPERXSTATUSA_MGTCLK(0),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXSTATUSA_MGTCLK_posedge_posedge(0),
          HoldHigh => thold_PIPERXSTATUSA_MGTCLK_posedge_posedge(0),
          SetupLow => tsetup_PIPERXSTATUSA_MGTCLK_negedge_posedge(0),
          HoldLow => thold_PIPERXSTATUSA_MGTCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXSTATUSA_MGTCLK_posedge(1),
          TimingData => Tmkr_PIPERXSTATUSA_MGTCLK_posedge(1),
          TestSignal => PIPERXSTATUSA_MGTCLK_dly(1),
          TestSignalName => "PIPERXSTATUSA(1)",
          TestDelay => tisd_PIPERXSTATUSA_MGTCLK(1),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXSTATUSA_MGTCLK_posedge_posedge(1),
          HoldHigh => thold_PIPERXSTATUSA_MGTCLK_posedge_posedge(1),
          SetupLow => tsetup_PIPERXSTATUSA_MGTCLK_negedge_posedge(1),
          HoldLow => thold_PIPERXSTATUSA_MGTCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXSTATUSA_MGTCLK_posedge(2),
          TimingData => Tmkr_PIPERXSTATUSA_MGTCLK_posedge(2),
          TestSignal => PIPERXSTATUSA_MGTCLK_dly(2),
          TestSignalName => "PIPERXSTATUSA(2)",
          TestDelay => tisd_PIPERXSTATUSA_MGTCLK(2),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXSTATUSA_MGTCLK_posedge_posedge(2),
          HoldHigh => thold_PIPERXSTATUSA_MGTCLK_posedge_posedge(2),
          SetupLow => tsetup_PIPERXSTATUSA_MGTCLK_negedge_posedge(2),
          HoldLow => thold_PIPERXSTATUSA_MGTCLK_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
      end if;
      wait on PIPERXSTATUSA_MGTCLK_dly;
    end process TIMING_PIPERXSTATUSA;
    TIMING_PIPERXSTATUSB: process
      variable Tmkr_PIPERXSTATUSB_MGTCLK_posedge : VitalTimingDataArrayType(2 downto 0);
      variable Tviol_PIPERXSTATUSB_MGTCLK_posedge : std_logic_vector(2 downto 0) := (others => '0');
      begin
      if (TimingChecksOn) then
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXSTATUSB_MGTCLK_posedge(0),
          TimingData => Tmkr_PIPERXSTATUSB_MGTCLK_posedge(0),
          TestSignal => PIPERXSTATUSB_MGTCLK_dly(0),
          TestSignalName => "PIPERXSTATUSB(0)",
          TestDelay => tisd_PIPERXSTATUSB_MGTCLK(0),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXSTATUSB_MGTCLK_posedge_posedge(0),
          HoldHigh => thold_PIPERXSTATUSB_MGTCLK_posedge_posedge(0),
          SetupLow => tsetup_PIPERXSTATUSB_MGTCLK_negedge_posedge(0),
          HoldLow => thold_PIPERXSTATUSB_MGTCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXSTATUSB_MGTCLK_posedge(1),
          TimingData => Tmkr_PIPERXSTATUSB_MGTCLK_posedge(1),
          TestSignal => PIPERXSTATUSB_MGTCLK_dly(1),
          TestSignalName => "PIPERXSTATUSB(1)",
          TestDelay => tisd_PIPERXSTATUSB_MGTCLK(1),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXSTATUSB_MGTCLK_posedge_posedge(1),
          HoldHigh => thold_PIPERXSTATUSB_MGTCLK_posedge_posedge(1),
          SetupLow => tsetup_PIPERXSTATUSB_MGTCLK_negedge_posedge(1),
          HoldLow => thold_PIPERXSTATUSB_MGTCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXSTATUSB_MGTCLK_posedge(2),
          TimingData => Tmkr_PIPERXSTATUSB_MGTCLK_posedge(2),
          TestSignal => PIPERXSTATUSB_MGTCLK_dly(2),
          TestSignalName => "PIPERXSTATUSB(2)",
          TestDelay => tisd_PIPERXSTATUSB_MGTCLK(2),
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXSTATUSB_MGTCLK_posedge_posedge(2),
          HoldHigh => thold_PIPERXSTATUSB_MGTCLK_posedge_posedge(2),
          SetupLow => tsetup_PIPERXSTATUSB_MGTCLK_negedge_posedge(2),
          HoldLow => thold_PIPERXSTATUSB_MGTCLK_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
      end if;
      wait on PIPERXSTATUSB_MGTCLK_dly;
    end process TIMING_PIPERXSTATUSB;
    TIMING_TRNFCSEL: process
      variable Tmkr_TRNFCSEL_USERCLK_posedge : VitalTimingDataArrayType(2 downto 0);
      variable Tviol_TRNFCSEL_USERCLK_posedge : std_logic_vector(2 downto 0) := (others => '0');
      begin
      if (TimingChecksOn) then
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNFCSEL_USERCLK_posedge(0),
          TimingData => Tmkr_TRNFCSEL_USERCLK_posedge(0),
          TestSignal => TRNFCSEL_USERCLK_dly(0),
          TestSignalName => "TRNFCSEL(0)",
          TestDelay => tisd_TRNFCSEL_USERCLK(0),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNFCSEL_USERCLK_posedge_posedge(0),
          HoldHigh => thold_TRNFCSEL_USERCLK_posedge_posedge(0),
          SetupLow => tsetup_TRNFCSEL_USERCLK_negedge_posedge(0),
          HoldLow => thold_TRNFCSEL_USERCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNFCSEL_USERCLK_posedge(1),
          TimingData => Tmkr_TRNFCSEL_USERCLK_posedge(1),
          TestSignal => TRNFCSEL_USERCLK_dly(1),
          TestSignalName => "TRNFCSEL(1)",
          TestDelay => tisd_TRNFCSEL_USERCLK(1),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNFCSEL_USERCLK_posedge_posedge(1),
          HoldHigh => thold_TRNFCSEL_USERCLK_posedge_posedge(1),
          SetupLow => tsetup_TRNFCSEL_USERCLK_negedge_posedge(1),
          HoldLow => thold_TRNFCSEL_USERCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNFCSEL_USERCLK_posedge(2),
          TimingData => Tmkr_TRNFCSEL_USERCLK_posedge(2),
          TestSignal => TRNFCSEL_USERCLK_dly(2),
          TestSignalName => "TRNFCSEL(2)",
          TestDelay => tisd_TRNFCSEL_USERCLK(2),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNFCSEL_USERCLK_posedge_posedge(2),
          HoldHigh => thold_TRNFCSEL_USERCLK_posedge_posedge(2),
          SetupLow => tsetup_TRNFCSEL_USERCLK_negedge_posedge(2),
          HoldLow => thold_TRNFCSEL_USERCLK_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
      end if;
      wait on TRNFCSEL_USERCLK_dly;
    end process TIMING_TRNFCSEL;
    TIMING_TRNTD: process
      variable Tmkr_TRNTD_USERCLK_posedge : VitalTimingDataArrayType(31 downto 0);
      variable Tviol_TRNTD_USERCLK_posedge : std_logic_vector(31 downto 0) := (others => '0');
      begin
      if (TimingChecksOn) then
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(0),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(0),
          TestSignal => TRNTD_USERCLK_dly(0),
          TestSignalName => "TRNTD(0)",
          TestDelay => tisd_TRNTD_USERCLK(0),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(0),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(0),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(0),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(1),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(1),
          TestSignal => TRNTD_USERCLK_dly(1),
          TestSignalName => "TRNTD(1)",
          TestDelay => tisd_TRNTD_USERCLK(1),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(1),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(1),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(1),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(10),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(10),
          TestSignal => TRNTD_USERCLK_dly(10),
          TestSignalName => "TRNTD(10)",
          TestDelay => tisd_TRNTD_USERCLK(10),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(10),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(10),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(10),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(10),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(11),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(11),
          TestSignal => TRNTD_USERCLK_dly(11),
          TestSignalName => "TRNTD(11)",
          TestDelay => tisd_TRNTD_USERCLK(11),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(11),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(11),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(11),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(11),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(12),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(12),
          TestSignal => TRNTD_USERCLK_dly(12),
          TestSignalName => "TRNTD(12)",
          TestDelay => tisd_TRNTD_USERCLK(12),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(12),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(12),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(12),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(12),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(13),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(13),
          TestSignal => TRNTD_USERCLK_dly(13),
          TestSignalName => "TRNTD(13)",
          TestDelay => tisd_TRNTD_USERCLK(13),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(13),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(13),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(13),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(13),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(14),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(14),
          TestSignal => TRNTD_USERCLK_dly(14),
          TestSignalName => "TRNTD(14)",
          TestDelay => tisd_TRNTD_USERCLK(14),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(14),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(14),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(14),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(14),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(15),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(15),
          TestSignal => TRNTD_USERCLK_dly(15),
          TestSignalName => "TRNTD(15)",
          TestDelay => tisd_TRNTD_USERCLK(15),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(15),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(15),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(15),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(15),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(16),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(16),
          TestSignal => TRNTD_USERCLK_dly(16),
          TestSignalName => "TRNTD(16)",
          TestDelay => tisd_TRNTD_USERCLK(16),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(16),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(16),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(16),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(16),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(17),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(17),
          TestSignal => TRNTD_USERCLK_dly(17),
          TestSignalName => "TRNTD(17)",
          TestDelay => tisd_TRNTD_USERCLK(17),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(17),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(17),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(17),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(17),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(18),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(18),
          TestSignal => TRNTD_USERCLK_dly(18),
          TestSignalName => "TRNTD(18)",
          TestDelay => tisd_TRNTD_USERCLK(18),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(18),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(18),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(18),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(18),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(19),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(19),
          TestSignal => TRNTD_USERCLK_dly(19),
          TestSignalName => "TRNTD(19)",
          TestDelay => tisd_TRNTD_USERCLK(19),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(19),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(19),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(19),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(19),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(2),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(2),
          TestSignal => TRNTD_USERCLK_dly(2),
          TestSignalName => "TRNTD(2)",
          TestDelay => tisd_TRNTD_USERCLK(2),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(2),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(2),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(2),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(20),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(20),
          TestSignal => TRNTD_USERCLK_dly(20),
          TestSignalName => "TRNTD(20)",
          TestDelay => tisd_TRNTD_USERCLK(20),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(20),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(20),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(20),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(20),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(21),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(21),
          TestSignal => TRNTD_USERCLK_dly(21),
          TestSignalName => "TRNTD(21)",
          TestDelay => tisd_TRNTD_USERCLK(21),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(21),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(21),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(21),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(21),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(22),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(22),
          TestSignal => TRNTD_USERCLK_dly(22),
          TestSignalName => "TRNTD(22)",
          TestDelay => tisd_TRNTD_USERCLK(22),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(22),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(22),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(22),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(22),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(23),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(23),
          TestSignal => TRNTD_USERCLK_dly(23),
          TestSignalName => "TRNTD(23)",
          TestDelay => tisd_TRNTD_USERCLK(23),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(23),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(23),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(23),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(23),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(24),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(24),
          TestSignal => TRNTD_USERCLK_dly(24),
          TestSignalName => "TRNTD(24)",
          TestDelay => tisd_TRNTD_USERCLK(24),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(24),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(24),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(24),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(24),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(25),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(25),
          TestSignal => TRNTD_USERCLK_dly(25),
          TestSignalName => "TRNTD(25)",
          TestDelay => tisd_TRNTD_USERCLK(25),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(25),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(25),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(25),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(25),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(26),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(26),
          TestSignal => TRNTD_USERCLK_dly(26),
          TestSignalName => "TRNTD(26)",
          TestDelay => tisd_TRNTD_USERCLK(26),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(26),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(26),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(26),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(26),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(27),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(27),
          TestSignal => TRNTD_USERCLK_dly(27),
          TestSignalName => "TRNTD(27)",
          TestDelay => tisd_TRNTD_USERCLK(27),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(27),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(27),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(27),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(27),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(28),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(28),
          TestSignal => TRNTD_USERCLK_dly(28),
          TestSignalName => "TRNTD(28)",
          TestDelay => tisd_TRNTD_USERCLK(28),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(28),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(28),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(28),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(28),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(29),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(29),
          TestSignal => TRNTD_USERCLK_dly(29),
          TestSignalName => "TRNTD(29)",
          TestDelay => tisd_TRNTD_USERCLK(29),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(29),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(29),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(29),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(29),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(3),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(3),
          TestSignal => TRNTD_USERCLK_dly(3),
          TestSignalName => "TRNTD(3)",
          TestDelay => tisd_TRNTD_USERCLK(3),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(3),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(3),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(3),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(3),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(30),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(30),
          TestSignal => TRNTD_USERCLK_dly(30),
          TestSignalName => "TRNTD(30)",
          TestDelay => tisd_TRNTD_USERCLK(30),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(30),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(30),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(30),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(30),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(31),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(31),
          TestSignal => TRNTD_USERCLK_dly(31),
          TestSignalName => "TRNTD(31)",
          TestDelay => tisd_TRNTD_USERCLK(31),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(31),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(31),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(31),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(31),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(4),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(4),
          TestSignal => TRNTD_USERCLK_dly(4),
          TestSignalName => "TRNTD(4)",
          TestDelay => tisd_TRNTD_USERCLK(4),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(4),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(4),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(4),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(4),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(5),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(5),
          TestSignal => TRNTD_USERCLK_dly(5),
          TestSignalName => "TRNTD(5)",
          TestDelay => tisd_TRNTD_USERCLK(5),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(5),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(5),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(5),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(5),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(6),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(6),
          TestSignal => TRNTD_USERCLK_dly(6),
          TestSignalName => "TRNTD(6)",
          TestDelay => tisd_TRNTD_USERCLK(6),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(6),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(6),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(6),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(6),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(7),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(7),
          TestSignal => TRNTD_USERCLK_dly(7),
          TestSignalName => "TRNTD(7)",
          TestDelay => tisd_TRNTD_USERCLK(7),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(7),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(7),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(7),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(7),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(8),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(8),
          TestSignal => TRNTD_USERCLK_dly(8),
          TestSignalName => "TRNTD(8)",
          TestDelay => tisd_TRNTD_USERCLK(8),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(8),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(8),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(8),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(8),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTD_USERCLK_posedge(9),
          TimingData => Tmkr_TRNTD_USERCLK_posedge(9),
          TestSignal => TRNTD_USERCLK_dly(9),
          TestSignalName => "TRNTD(9)",
          TestDelay => tisd_TRNTD_USERCLK(9),
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTD_USERCLK_posedge_posedge(9),
          HoldHigh => thold_TRNTD_USERCLK_posedge_posedge(9),
          SetupLow => tsetup_TRNTD_USERCLK_negedge_posedge(9),
          HoldLow => thold_TRNTD_USERCLK_negedge_posedge(9),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
      end if;
      wait on TRNTD_USERCLK_dly;
    end process TIMING_TRNTD;
--    TIMING_: process
--      variable
--      begin
--      if (TimingChecksOn) then
--        VitalSetupHoldCheck
--      end if;
--      wait on
--             ;
--    end process TIMING_;
    TIMING_CHECK : process
      variable Tmkr_CFGERRCORN_USERCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_CFGERRCPLABORTN_USERCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_CFGERRCPLTIMEOUTN_USERCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_CFGERRECRCN_USERCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_CFGERRLOCKEDN_USERCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_CFGERRPOSTEDN_USERCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_CFGERRURN_USERCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_CFGINTERRUPTASSERTN_USERCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_CFGINTERRUPTN_USERCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_CFGPMWAKEN_USERCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_CFGRDENN_USERCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_CFGTRNPENDINGN_USERCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_CFGTURNOFFOKN_USERCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PIPEGTRESETDONEA_MGTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PIPEGTRESETDONEB_MGTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PIPEPHYSTATUSA_MGTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PIPEPHYSTATUSB_MGTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PIPERXENTERELECIDLEA_MGTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PIPERXENTERELECIDLEB_MGTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_TRNRDSTRDYN_USERCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_TRNRNPOKN_USERCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_TRNTCFGGNTN_USERCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_TRNTEOFN_USERCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_TRNTERRFWDN_USERCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_TRNTSOFN_USERCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_TRNTSRCDSCN_USERCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_TRNTSRCRDYN_USERCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_TRNTSTRN_USERCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tviol_CFGERRCORN_USERCLK_posedge :  std_ulogic := '0';
      variable Tviol_CFGERRCPLABORTN_USERCLK_posedge :  std_ulogic := '0';
      variable Tviol_CFGERRCPLTIMEOUTN_USERCLK_posedge :  std_ulogic := '0';
      variable Tviol_CFGERRECRCN_USERCLK_posedge :  std_ulogic := '0';
      variable Tviol_CFGERRLOCKEDN_USERCLK_posedge :  std_ulogic := '0';
      variable Tviol_CFGERRPOSTEDN_USERCLK_posedge :  std_ulogic := '0';
      variable Tviol_CFGERRURN_USERCLK_posedge :  std_ulogic := '0';
      variable Tviol_CFGINTERRUPTASSERTN_USERCLK_posedge :  std_ulogic := '0';
      variable Tviol_CFGINTERRUPTN_USERCLK_posedge :  std_ulogic := '0';
      variable Tviol_CFGPMWAKEN_USERCLK_posedge :  std_ulogic := '0';
      variable Tviol_CFGRDENN_USERCLK_posedge :  std_ulogic := '0';
      variable Tviol_CFGTRNPENDINGN_USERCLK_posedge :  std_ulogic := '0';
      variable Tviol_CFGTURNOFFOKN_USERCLK_posedge :  std_ulogic := '0';
      variable Tviol_PIPEGTRESETDONEA_MGTCLK_posedge :  std_ulogic := '0';
      variable Tviol_PIPEGTRESETDONEB_MGTCLK_posedge :  std_ulogic := '0';
      variable Tviol_PIPEPHYSTATUSA_MGTCLK_posedge :  std_ulogic := '0';
      variable Tviol_PIPEPHYSTATUSB_MGTCLK_posedge :  std_ulogic := '0';
      variable Tviol_PIPERXENTERELECIDLEA_MGTCLK_posedge :  std_ulogic := '0';
      variable Tviol_PIPERXENTERELECIDLEB_MGTCLK_posedge :  std_ulogic := '0';
      variable Tviol_TRNRDSTRDYN_USERCLK_posedge :  std_ulogic := '0';
      variable Tviol_TRNRNPOKN_USERCLK_posedge :  std_ulogic := '0';
      variable Tviol_TRNTCFGGNTN_USERCLK_posedge :  std_ulogic := '0';
      variable Tviol_TRNTEOFN_USERCLK_posedge :  std_ulogic := '0';
      variable Tviol_TRNTERRFWDN_USERCLK_posedge :  std_ulogic := '0';
      variable Tviol_TRNTSOFN_USERCLK_posedge :  std_ulogic := '0';
      variable Tviol_TRNTSRCDSCN_USERCLK_posedge :  std_ulogic := '0';
      variable Tviol_TRNTSRCRDYN_USERCLK_posedge :  std_ulogic := '0';
      variable Tviol_TRNTSTRN_USERCLK_posedge :  std_ulogic := '0';

      begin

      if (TimingChecksOn) then
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRCORN_USERCLK_posedge,
          TimingData => Tmkr_CFGERRCORN_USERCLK_posedge,
          TestSignal => CFGERRCORN_USERCLK_dly,
          TestSignalName => "CFGERRCORN",
          TestDelay => tisd_CFGERRCORN_USERCLK,
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRCORN_USERCLK_posedge_posedge,
          HoldHigh => thold_CFGERRCORN_USERCLK_posedge_posedge,
          SetupLow => tsetup_CFGERRCORN_USERCLK_negedge_posedge,
          HoldLow => thold_CFGERRCORN_USERCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRCPLABORTN_USERCLK_posedge,
          TimingData => Tmkr_CFGERRCPLABORTN_USERCLK_posedge,
          TestSignal => CFGERRCPLABORTN_USERCLK_dly,
          TestSignalName => "CFGERRCPLABORTN",
          TestDelay => tisd_CFGERRCPLABORTN_USERCLK,
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRCPLABORTN_USERCLK_posedge_posedge,
          HoldHigh => thold_CFGERRCPLABORTN_USERCLK_posedge_posedge,
          SetupLow => tsetup_CFGERRCPLABORTN_USERCLK_negedge_posedge,
          HoldLow => thold_CFGERRCPLABORTN_USERCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRCPLTIMEOUTN_USERCLK_posedge,
          TimingData => Tmkr_CFGERRCPLTIMEOUTN_USERCLK_posedge,
          TestSignal => CFGERRCPLTIMEOUTN_USERCLK_dly,
          TestSignalName => "CFGERRCPLTIMEOUTN",
          TestDelay => tisd_CFGERRCPLTIMEOUTN_USERCLK,
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRCPLTIMEOUTN_USERCLK_posedge_posedge,
          HoldHigh => thold_CFGERRCPLTIMEOUTN_USERCLK_posedge_posedge,
          SetupLow => tsetup_CFGERRCPLTIMEOUTN_USERCLK_negedge_posedge,
          HoldLow => thold_CFGERRCPLTIMEOUTN_USERCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRECRCN_USERCLK_posedge,
          TimingData => Tmkr_CFGERRECRCN_USERCLK_posedge,
          TestSignal => CFGERRECRCN_USERCLK_dly,
          TestSignalName => "CFGERRECRCN",
          TestDelay => tisd_CFGERRECRCN_USERCLK,
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRECRCN_USERCLK_posedge_posedge,
          HoldHigh => thold_CFGERRECRCN_USERCLK_posedge_posedge,
          SetupLow => tsetup_CFGERRECRCN_USERCLK_negedge_posedge,
          HoldLow => thold_CFGERRECRCN_USERCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRLOCKEDN_USERCLK_posedge,
          TimingData => Tmkr_CFGERRLOCKEDN_USERCLK_posedge,
          TestSignal => CFGERRLOCKEDN_USERCLK_dly,
          TestSignalName => "CFGERRLOCKEDN",
          TestDelay => tisd_CFGERRLOCKEDN_USERCLK,
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRLOCKEDN_USERCLK_posedge_posedge,
          HoldHigh => thold_CFGERRLOCKEDN_USERCLK_posedge_posedge,
          SetupLow => tsetup_CFGERRLOCKEDN_USERCLK_negedge_posedge,
          HoldLow => thold_CFGERRLOCKEDN_USERCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRPOSTEDN_USERCLK_posedge,
          TimingData => Tmkr_CFGERRPOSTEDN_USERCLK_posedge,
          TestSignal => CFGERRPOSTEDN_USERCLK_dly,
          TestSignalName => "CFGERRPOSTEDN",
          TestDelay => tisd_CFGERRPOSTEDN_USERCLK,
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRPOSTEDN_USERCLK_posedge_posedge,
          HoldHigh => thold_CFGERRPOSTEDN_USERCLK_posedge_posedge,
          SetupLow => tsetup_CFGERRPOSTEDN_USERCLK_negedge_posedge,
          HoldLow => thold_CFGERRPOSTEDN_USERCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGERRURN_USERCLK_posedge,
          TimingData => Tmkr_CFGERRURN_USERCLK_posedge,
          TestSignal => CFGERRURN_USERCLK_dly,
          TestSignalName => "CFGERRURN",
          TestDelay => tisd_CFGERRURN_USERCLK,
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGERRURN_USERCLK_posedge_posedge,
          HoldHigh => thold_CFGERRURN_USERCLK_posedge_posedge,
          SetupLow => tsetup_CFGERRURN_USERCLK_negedge_posedge,
          HoldLow => thold_CFGERRURN_USERCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGINTERRUPTASSERTN_USERCLK_posedge,
          TimingData => Tmkr_CFGINTERRUPTASSERTN_USERCLK_posedge,
          TestSignal => CFGINTERRUPTASSERTN_USERCLK_dly,
          TestSignalName => "CFGINTERRUPTASSERTN",
          TestDelay => tisd_CFGINTERRUPTASSERTN_USERCLK,
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGINTERRUPTASSERTN_USERCLK_posedge_posedge,
          HoldHigh => thold_CFGINTERRUPTASSERTN_USERCLK_posedge_posedge,
          SetupLow => tsetup_CFGINTERRUPTASSERTN_USERCLK_negedge_posedge,
          HoldLow => thold_CFGINTERRUPTASSERTN_USERCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGINTERRUPTN_USERCLK_posedge,
          TimingData => Tmkr_CFGINTERRUPTN_USERCLK_posedge,
          TestSignal => CFGINTERRUPTN_USERCLK_dly,
          TestSignalName => "CFGINTERRUPTN",
          TestDelay => tisd_CFGINTERRUPTN_USERCLK,
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGINTERRUPTN_USERCLK_posedge_posedge,
          HoldHigh => thold_CFGINTERRUPTN_USERCLK_posedge_posedge,
          SetupLow => tsetup_CFGINTERRUPTN_USERCLK_negedge_posedge,
          HoldLow => thold_CFGINTERRUPTN_USERCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGPMWAKEN_USERCLK_posedge,
          TimingData => Tmkr_CFGPMWAKEN_USERCLK_posedge,
          TestSignal => CFGPMWAKEN_USERCLK_dly,
          TestSignalName => "CFGPMWAKEN",
          TestDelay => tisd_CFGPMWAKEN_USERCLK,
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGPMWAKEN_USERCLK_posedge_posedge,
          HoldHigh => thold_CFGPMWAKEN_USERCLK_posedge_posedge,
          SetupLow => tsetup_CFGPMWAKEN_USERCLK_negedge_posedge,
          HoldLow => thold_CFGPMWAKEN_USERCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGRDENN_USERCLK_posedge,
          TimingData => Tmkr_CFGRDENN_USERCLK_posedge,
          TestSignal => CFGRDENN_USERCLK_dly,
          TestSignalName => "CFGRDENN",
          TestDelay => tisd_CFGRDENN_USERCLK,
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGRDENN_USERCLK_posedge_posedge,
          HoldHigh => thold_CFGRDENN_USERCLK_posedge_posedge,
          SetupLow => tsetup_CFGRDENN_USERCLK_negedge_posedge,
          HoldLow => thold_CFGRDENN_USERCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGTRNPENDINGN_USERCLK_posedge,
          TimingData => Tmkr_CFGTRNPENDINGN_USERCLK_posedge,
          TestSignal => CFGTRNPENDINGN_USERCLK_dly,
          TestSignalName => "CFGTRNPENDINGN",
          TestDelay => tisd_CFGTRNPENDINGN_USERCLK,
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGTRNPENDINGN_USERCLK_posedge_posedge,
          HoldHigh => thold_CFGTRNPENDINGN_USERCLK_posedge_posedge,
          SetupLow => tsetup_CFGTRNPENDINGN_USERCLK_negedge_posedge,
          HoldLow => thold_CFGTRNPENDINGN_USERCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CFGTURNOFFOKN_USERCLK_posedge,
          TimingData => Tmkr_CFGTURNOFFOKN_USERCLK_posedge,
          TestSignal => CFGTURNOFFOKN_USERCLK_dly,
          TestSignalName => "CFGTURNOFFOKN",
          TestDelay => tisd_CFGTURNOFFOKN_USERCLK,
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_CFGTURNOFFOKN_USERCLK_posedge_posedge,
          HoldHigh => thold_CFGTURNOFFOKN_USERCLK_posedge_posedge,
          SetupLow => tsetup_CFGTURNOFFOKN_USERCLK_negedge_posedge,
          HoldLow => thold_CFGTURNOFFOKN_USERCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPEGTRESETDONEA_MGTCLK_posedge,
          TimingData => Tmkr_PIPEGTRESETDONEA_MGTCLK_posedge,
          TestSignal => PIPEGTRESETDONEA_MGTCLK_dly,
          TestSignalName => "PIPEGTRESETDONEA",
          TestDelay => tisd_PIPEGTRESETDONEA_MGTCLK,
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPEGTRESETDONEA_MGTCLK_posedge_posedge,
          HoldHigh => thold_PIPEGTRESETDONEA_MGTCLK_posedge_posedge,
          SetupLow => tsetup_PIPEGTRESETDONEA_MGTCLK_negedge_posedge,
          HoldLow => thold_PIPEGTRESETDONEA_MGTCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPEGTRESETDONEB_MGTCLK_posedge,
          TimingData => Tmkr_PIPEGTRESETDONEB_MGTCLK_posedge,
          TestSignal => PIPEGTRESETDONEB_MGTCLK_dly,
          TestSignalName => "PIPEGTRESETDONEB",
          TestDelay => tisd_PIPEGTRESETDONEB_MGTCLK,
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPEGTRESETDONEB_MGTCLK_posedge_posedge,
          HoldHigh => thold_PIPEGTRESETDONEB_MGTCLK_posedge_posedge,
          SetupLow => tsetup_PIPEGTRESETDONEB_MGTCLK_negedge_posedge,
          HoldLow => thold_PIPEGTRESETDONEB_MGTCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPEPHYSTATUSA_MGTCLK_posedge,
          TimingData => Tmkr_PIPEPHYSTATUSA_MGTCLK_posedge,
          TestSignal => PIPEPHYSTATUSA_MGTCLK_dly,
          TestSignalName => "PIPEPHYSTATUSA",
          TestDelay => tisd_PIPEPHYSTATUSA_MGTCLK,
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPEPHYSTATUSA_MGTCLK_posedge_posedge,
          HoldHigh => thold_PIPEPHYSTATUSA_MGTCLK_posedge_posedge,
          SetupLow => tsetup_PIPEPHYSTATUSA_MGTCLK_negedge_posedge,
          HoldLow => thold_PIPEPHYSTATUSA_MGTCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPEPHYSTATUSB_MGTCLK_posedge,
          TimingData => Tmkr_PIPEPHYSTATUSB_MGTCLK_posedge,
          TestSignal => PIPEPHYSTATUSB_MGTCLK_dly,
          TestSignalName => "PIPEPHYSTATUSB",
          TestDelay => tisd_PIPEPHYSTATUSB_MGTCLK,
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPEPHYSTATUSB_MGTCLK_posedge_posedge,
          HoldHigh => thold_PIPEPHYSTATUSB_MGTCLK_posedge_posedge,
          SetupLow => tsetup_PIPEPHYSTATUSB_MGTCLK_negedge_posedge,
          HoldLow => thold_PIPEPHYSTATUSB_MGTCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXENTERELECIDLEA_MGTCLK_posedge,
          TimingData => Tmkr_PIPERXENTERELECIDLEA_MGTCLK_posedge,
          TestSignal => PIPERXENTERELECIDLEA_MGTCLK_dly,
          TestSignalName => "PIPERXENTERELECIDLEA",
          TestDelay => tisd_PIPERXENTERELECIDLEA_MGTCLK,
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXENTERELECIDLEA_MGTCLK_posedge_posedge,
          HoldHigh => thold_PIPERXENTERELECIDLEA_MGTCLK_posedge_posedge,
          SetupLow => tsetup_PIPERXENTERELECIDLEA_MGTCLK_negedge_posedge,
          HoldLow => thold_PIPERXENTERELECIDLEA_MGTCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PIPERXENTERELECIDLEB_MGTCLK_posedge,
          TimingData => Tmkr_PIPERXENTERELECIDLEB_MGTCLK_posedge,
          TestSignal => PIPERXENTERELECIDLEB_MGTCLK_dly,
          TestSignalName => "PIPERXENTERELECIDLEB",
          TestDelay => tisd_PIPERXENTERELECIDLEB_MGTCLK,
          RefSignal => MGTCLK_dly,
          RefSignalName => "MGTCLK",
          RefDelay => ticd_MGTCLK,
          SetupHigh => tsetup_PIPERXENTERELECIDLEB_MGTCLK_posedge_posedge,
          HoldHigh => thold_PIPERXENTERELECIDLEB_MGTCLK_posedge_posedge,
          SetupLow => tsetup_PIPERXENTERELECIDLEB_MGTCLK_negedge_posedge,
          HoldLow => thold_PIPERXENTERELECIDLEB_MGTCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNRDSTRDYN_USERCLK_posedge,
          TimingData => Tmkr_TRNRDSTRDYN_USERCLK_posedge,
          TestSignal => TRNRDSTRDYN_USERCLK_dly,
          TestSignalName => "TRNRDSTRDYN",
          TestDelay => tisd_TRNRDSTRDYN_USERCLK,
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNRDSTRDYN_USERCLK_posedge_posedge,
          HoldHigh => thold_TRNRDSTRDYN_USERCLK_posedge_posedge,
          SetupLow => tsetup_TRNRDSTRDYN_USERCLK_negedge_posedge,
          HoldLow => thold_TRNRDSTRDYN_USERCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNRNPOKN_USERCLK_posedge,
          TimingData => Tmkr_TRNRNPOKN_USERCLK_posedge,
          TestSignal => TRNRNPOKN_USERCLK_dly,
          TestSignalName => "TRNRNPOKN",
          TestDelay => tisd_TRNRNPOKN_USERCLK,
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNRNPOKN_USERCLK_posedge_posedge,
          HoldHigh => thold_TRNRNPOKN_USERCLK_posedge_posedge,
          SetupLow => tsetup_TRNRNPOKN_USERCLK_negedge_posedge,
          HoldLow => thold_TRNRNPOKN_USERCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTCFGGNTN_USERCLK_posedge,
          TimingData => Tmkr_TRNTCFGGNTN_USERCLK_posedge,
          TestSignal => TRNTCFGGNTN_USERCLK_dly,
          TestSignalName => "TRNTCFGGNTN",
          TestDelay => tisd_TRNTCFGGNTN_USERCLK,
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTCFGGNTN_USERCLK_posedge_posedge,
          HoldHigh => thold_TRNTCFGGNTN_USERCLK_posedge_posedge,
          SetupLow => tsetup_TRNTCFGGNTN_USERCLK_negedge_posedge,
          HoldLow => thold_TRNTCFGGNTN_USERCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTEOFN_USERCLK_posedge,
          TimingData => Tmkr_TRNTEOFN_USERCLK_posedge,
          TestSignal => TRNTEOFN_USERCLK_dly,
          TestSignalName => "TRNTEOFN",
          TestDelay => tisd_TRNTEOFN_USERCLK,
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTEOFN_USERCLK_posedge_posedge,
          HoldHigh => thold_TRNTEOFN_USERCLK_posedge_posedge,
          SetupLow => tsetup_TRNTEOFN_USERCLK_negedge_posedge,
          HoldLow => thold_TRNTEOFN_USERCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTERRFWDN_USERCLK_posedge,
          TimingData => Tmkr_TRNTERRFWDN_USERCLK_posedge,
          TestSignal => TRNTERRFWDN_USERCLK_dly,
          TestSignalName => "TRNTERRFWDN",
          TestDelay => tisd_TRNTERRFWDN_USERCLK,
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTERRFWDN_USERCLK_posedge_posedge,
          HoldHigh => thold_TRNTERRFWDN_USERCLK_posedge_posedge,
          SetupLow => tsetup_TRNTERRFWDN_USERCLK_negedge_posedge,
          HoldLow => thold_TRNTERRFWDN_USERCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTSOFN_USERCLK_posedge,
          TimingData => Tmkr_TRNTSOFN_USERCLK_posedge,
          TestSignal => TRNTSOFN_USERCLK_dly,
          TestSignalName => "TRNTSOFN",
          TestDelay => tisd_TRNTSOFN_USERCLK,
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTSOFN_USERCLK_posedge_posedge,
          HoldHigh => thold_TRNTSOFN_USERCLK_posedge_posedge,
          SetupLow => tsetup_TRNTSOFN_USERCLK_negedge_posedge,
          HoldLow => thold_TRNTSOFN_USERCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTSRCDSCN_USERCLK_posedge,
          TimingData => Tmkr_TRNTSRCDSCN_USERCLK_posedge,
          TestSignal => TRNTSRCDSCN_USERCLK_dly,
          TestSignalName => "TRNTSRCDSCN",
          TestDelay => tisd_TRNTSRCDSCN_USERCLK,
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTSRCDSCN_USERCLK_posedge_posedge,
          HoldHigh => thold_TRNTSRCDSCN_USERCLK_posedge_posedge,
          SetupLow => tsetup_TRNTSRCDSCN_USERCLK_negedge_posedge,
          HoldLow => thold_TRNTSRCDSCN_USERCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTSRCRDYN_USERCLK_posedge,
          TimingData => Tmkr_TRNTSRCRDYN_USERCLK_posedge,
          TestSignal => TRNTSRCRDYN_USERCLK_dly,
          TestSignalName => "TRNTSRCRDYN",
          TestDelay => tisd_TRNTSRCRDYN_USERCLK,
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTSRCRDYN_USERCLK_posedge_posedge,
          HoldHigh => thold_TRNTSRCRDYN_USERCLK_posedge_posedge,
          SetupLow => tsetup_TRNTSRCRDYN_USERCLK_negedge_posedge,
          HoldLow => thold_TRNTSRCRDYN_USERCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_TRNTSTRN_USERCLK_posedge,
          TimingData => Tmkr_TRNTSTRN_USERCLK_posedge,
          TestSignal => TRNTSTRN_USERCLK_dly,
          TestSignalName => "TRNTSTRN",
          TestDelay => tisd_TRNTSTRN_USERCLK,
          RefSignal => USERCLK_dly,
          RefSignalName => "USERCLK",
          RefDelay => ticd_USERCLK,
          SetupHigh => tsetup_TRNTSTRN_USERCLK_posedge_posedge,
          HoldHigh => thold_TRNTSTRN_USERCLK_posedge_posedge,
          SetupLow => tsetup_TRNTSTRN_USERCLK_negedge_posedge,
          HoldLow => thold_TRNTSTRN_USERCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
      end if;
      wait on
        CFGERRCORN_USERCLK_dly,
        CFGERRCPLABORTN_USERCLK_dly,
        CFGERRCPLTIMEOUTN_USERCLK_dly,
        CFGERRECRCN_USERCLK_dly,
        CFGERRLOCKEDN_USERCLK_dly,
        CFGERRPOSTEDN_USERCLK_dly,
        CFGERRURN_USERCLK_dly,
        CFGINTERRUPTASSERTN_USERCLK_dly,
        CFGINTERRUPTN_USERCLK_dly,
        CFGPMWAKEN_USERCLK_dly,
        CFGRDENN_USERCLK_dly,
        CFGTRNPENDINGN_USERCLK_dly,
        CFGTURNOFFOKN_USERCLK_dly,
        PIPEGTRESETDONEA_MGTCLK_dly,
        PIPEGTRESETDONEB_MGTCLK_dly,
        PIPEPHYSTATUSA_MGTCLK_dly,
        PIPEPHYSTATUSB_MGTCLK_dly,
        PIPERXENTERELECIDLEA_MGTCLK_dly,
        PIPERXENTERELECIDLEB_MGTCLK_dly,
        TRNRDSTRDYN_USERCLK_dly,
        TRNRNPOKN_USERCLK_dly,
        TRNTCFGGNTN_USERCLK_dly,
        TRNTEOFN_USERCLK_dly,
        TRNTERRFWDN_USERCLK_dly,
        TRNTSOFN_USERCLK_dly,
        TRNTSRCDSCN_USERCLK_dly,
        TRNTSRCRDYN_USERCLK_dly,
        TRNTSTRN_USERCLK_dly;
    end process TIMING_CHECK;

    TIMING_PD_CFGBUSNUMBER : process
      variable CFGBUSNUMBER0_GlitchData : VitalGlitchDataType;
      variable CFGBUSNUMBER1_GlitchData : VitalGlitchDataType;
      variable CFGBUSNUMBER2_GlitchData : VitalGlitchDataType;
      variable CFGBUSNUMBER3_GlitchData : VitalGlitchDataType;
      variable CFGBUSNUMBER4_GlitchData : VitalGlitchDataType;
      variable CFGBUSNUMBER5_GlitchData : VitalGlitchDataType;
      variable CFGBUSNUMBER6_GlitchData : VitalGlitchDataType;
      variable CFGBUSNUMBER7_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => CFGBUSNUMBER(0),
          GlitchData    => CFGBUSNUMBER0_GlitchData,
          OutSignalName => "CFGBUSNUMBER(0)",
          OutTemp       => CFGBUSNUMBER_out(0),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGBUSNUMBER(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGBUSNUMBER(1),
          GlitchData    => CFGBUSNUMBER1_GlitchData,
          OutSignalName => "CFGBUSNUMBER(1)",
          OutTemp       => CFGBUSNUMBER_out(1),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGBUSNUMBER(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGBUSNUMBER(2),
          GlitchData    => CFGBUSNUMBER2_GlitchData,
          OutSignalName => "CFGBUSNUMBER(2)",
          OutTemp       => CFGBUSNUMBER_out(2),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGBUSNUMBER(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGBUSNUMBER(3),
          GlitchData    => CFGBUSNUMBER3_GlitchData,
          OutSignalName => "CFGBUSNUMBER(3)",
          OutTemp       => CFGBUSNUMBER_out(3),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGBUSNUMBER(3),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGBUSNUMBER(4),
          GlitchData    => CFGBUSNUMBER4_GlitchData,
          OutSignalName => "CFGBUSNUMBER(4)",
          OutTemp       => CFGBUSNUMBER_out(4),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGBUSNUMBER(4),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGBUSNUMBER(5),
          GlitchData    => CFGBUSNUMBER5_GlitchData,
          OutSignalName => "CFGBUSNUMBER(5)",
          OutTemp       => CFGBUSNUMBER_out(5),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGBUSNUMBER(5),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGBUSNUMBER(6),
          GlitchData    => CFGBUSNUMBER6_GlitchData,
          OutSignalName => "CFGBUSNUMBER(6)",
          OutTemp       => CFGBUSNUMBER_out(6),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGBUSNUMBER(6),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGBUSNUMBER(7),
          GlitchData    => CFGBUSNUMBER7_GlitchData,
          OutSignalName => "CFGBUSNUMBER(7)",
          OutTemp       => CFGBUSNUMBER_out(7),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGBUSNUMBER(7),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on CFGBUSNUMBER_out;
    end process TIMING_PD_CFGBUSNUMBER;
    TIMING_PD_CFGDEVCONTROLMAXPAYLOAD : process
      variable CFGDEVCONTROLMAXPAYLOAD0_GlitchData : VitalGlitchDataType;
      variable CFGDEVCONTROLMAXPAYLOAD1_GlitchData : VitalGlitchDataType;
      variable CFGDEVCONTROLMAXPAYLOAD2_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => CFGDEVCONTROLMAXPAYLOAD(0),
          GlitchData    => CFGDEVCONTROLMAXPAYLOAD0_GlitchData,
          OutSignalName => "CFGDEVCONTROLMAXPAYLOAD(0)",
          OutTemp       => CFGDEVCONTROLMAXPAYLOAD_out(0),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDEVCONTROLMAXPAYLOAD(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDEVCONTROLMAXPAYLOAD(1),
          GlitchData    => CFGDEVCONTROLMAXPAYLOAD1_GlitchData,
          OutSignalName => "CFGDEVCONTROLMAXPAYLOAD(1)",
          OutTemp       => CFGDEVCONTROLMAXPAYLOAD_out(1),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDEVCONTROLMAXPAYLOAD(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDEVCONTROLMAXPAYLOAD(2),
          GlitchData    => CFGDEVCONTROLMAXPAYLOAD2_GlitchData,
          OutSignalName => "CFGDEVCONTROLMAXPAYLOAD(2)",
          OutTemp       => CFGDEVCONTROLMAXPAYLOAD_out(2),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDEVCONTROLMAXPAYLOAD(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on CFGDEVCONTROLMAXPAYLOAD_out;
    end process TIMING_PD_CFGDEVCONTROLMAXPAYLOAD;
    TIMING_PD_CFGDEVCONTROLMAXREADREQ : process
      variable CFGDEVCONTROLMAXREADREQ0_GlitchData : VitalGlitchDataType;
      variable CFGDEVCONTROLMAXREADREQ1_GlitchData : VitalGlitchDataType;
      variable CFGDEVCONTROLMAXREADREQ2_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => CFGDEVCONTROLMAXREADREQ(0),
          GlitchData    => CFGDEVCONTROLMAXREADREQ0_GlitchData,
          OutSignalName => "CFGDEVCONTROLMAXREADREQ(0)",
          OutTemp       => CFGDEVCONTROLMAXREADREQ_out(0),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDEVCONTROLMAXREADREQ(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDEVCONTROLMAXREADREQ(1),
          GlitchData    => CFGDEVCONTROLMAXREADREQ1_GlitchData,
          OutSignalName => "CFGDEVCONTROLMAXREADREQ(1)",
          OutTemp       => CFGDEVCONTROLMAXREADREQ_out(1),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDEVCONTROLMAXREADREQ(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDEVCONTROLMAXREADREQ(2),
          GlitchData    => CFGDEVCONTROLMAXREADREQ2_GlitchData,
          OutSignalName => "CFGDEVCONTROLMAXREADREQ(2)",
          OutTemp       => CFGDEVCONTROLMAXREADREQ_out(2),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDEVCONTROLMAXREADREQ(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on CFGDEVCONTROLMAXREADREQ_out;
    end process TIMING_PD_CFGDEVCONTROLMAXREADREQ;
    TIMING_PD_CFGDEVICENUMBER : process
      variable CFGDEVICENUMBER0_GlitchData : VitalGlitchDataType;
      variable CFGDEVICENUMBER1_GlitchData : VitalGlitchDataType;
      variable CFGDEVICENUMBER2_GlitchData : VitalGlitchDataType;
      variable CFGDEVICENUMBER3_GlitchData : VitalGlitchDataType;
      variable CFGDEVICENUMBER4_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => CFGDEVICENUMBER(0),
          GlitchData    => CFGDEVICENUMBER0_GlitchData,
          OutSignalName => "CFGDEVICENUMBER(0)",
          OutTemp       => CFGDEVICENUMBER_out(0),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDEVICENUMBER(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDEVICENUMBER(1),
          GlitchData    => CFGDEVICENUMBER1_GlitchData,
          OutSignalName => "CFGDEVICENUMBER(1)",
          OutTemp       => CFGDEVICENUMBER_out(1),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDEVICENUMBER(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDEVICENUMBER(2),
          GlitchData    => CFGDEVICENUMBER2_GlitchData,
          OutSignalName => "CFGDEVICENUMBER(2)",
          OutTemp       => CFGDEVICENUMBER_out(2),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDEVICENUMBER(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDEVICENUMBER(3),
          GlitchData    => CFGDEVICENUMBER3_GlitchData,
          OutSignalName => "CFGDEVICENUMBER(3)",
          OutTemp       => CFGDEVICENUMBER_out(3),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDEVICENUMBER(3),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDEVICENUMBER(4),
          GlitchData    => CFGDEVICENUMBER4_GlitchData,
          OutSignalName => "CFGDEVICENUMBER(4)",
          OutTemp       => CFGDEVICENUMBER_out(4),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDEVICENUMBER(4),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on CFGDEVICENUMBER_out;
    end process TIMING_PD_CFGDEVICENUMBER;
    TIMING_PD_CFGDO : process
      variable CFGDO0_GlitchData : VitalGlitchDataType;
      variable CFGDO10_GlitchData : VitalGlitchDataType;
      variable CFGDO11_GlitchData : VitalGlitchDataType;
      variable CFGDO12_GlitchData : VitalGlitchDataType;
      variable CFGDO13_GlitchData : VitalGlitchDataType;
      variable CFGDO14_GlitchData : VitalGlitchDataType;
      variable CFGDO15_GlitchData : VitalGlitchDataType;
      variable CFGDO16_GlitchData : VitalGlitchDataType;
      variable CFGDO17_GlitchData : VitalGlitchDataType;
      variable CFGDO18_GlitchData : VitalGlitchDataType;
      variable CFGDO19_GlitchData : VitalGlitchDataType;
      variable CFGDO1_GlitchData : VitalGlitchDataType;
      variable CFGDO20_GlitchData : VitalGlitchDataType;
      variable CFGDO21_GlitchData : VitalGlitchDataType;
      variable CFGDO22_GlitchData : VitalGlitchDataType;
      variable CFGDO23_GlitchData : VitalGlitchDataType;
      variable CFGDO24_GlitchData : VitalGlitchDataType;
      variable CFGDO25_GlitchData : VitalGlitchDataType;
      variable CFGDO26_GlitchData : VitalGlitchDataType;
      variable CFGDO27_GlitchData : VitalGlitchDataType;
      variable CFGDO28_GlitchData : VitalGlitchDataType;
      variable CFGDO29_GlitchData : VitalGlitchDataType;
      variable CFGDO2_GlitchData : VitalGlitchDataType;
      variable CFGDO30_GlitchData : VitalGlitchDataType;
      variable CFGDO31_GlitchData : VitalGlitchDataType;
      variable CFGDO3_GlitchData : VitalGlitchDataType;
      variable CFGDO4_GlitchData : VitalGlitchDataType;
      variable CFGDO5_GlitchData : VitalGlitchDataType;
      variable CFGDO6_GlitchData : VitalGlitchDataType;
      variable CFGDO7_GlitchData : VitalGlitchDataType;
      variable CFGDO8_GlitchData : VitalGlitchDataType;
      variable CFGDO9_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => CFGDO(0),
          GlitchData    => CFGDO0_GlitchData,
          OutSignalName => "CFGDO(0)",
          OutTemp       => CFGDO_out(0),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDO(1),
          GlitchData    => CFGDO1_GlitchData,
          OutSignalName => "CFGDO(1)",
          OutTemp       => CFGDO_out(1),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDO(10),
          GlitchData    => CFGDO10_GlitchData,
          OutSignalName => "CFGDO(10)",
          OutTemp       => CFGDO_out(10),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(10),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDO(11),
          GlitchData    => CFGDO11_GlitchData,
          OutSignalName => "CFGDO(11)",
          OutTemp       => CFGDO_out(11),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(11),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDO(12),
          GlitchData    => CFGDO12_GlitchData,
          OutSignalName => "CFGDO(12)",
          OutTemp       => CFGDO_out(12),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(12),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDO(13),
          GlitchData    => CFGDO13_GlitchData,
          OutSignalName => "CFGDO(13)",
          OutTemp       => CFGDO_out(13),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(13),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDO(14),
          GlitchData    => CFGDO14_GlitchData,
          OutSignalName => "CFGDO(14)",
          OutTemp       => CFGDO_out(14),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(14),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDO(15),
          GlitchData    => CFGDO15_GlitchData,
          OutSignalName => "CFGDO(15)",
          OutTemp       => CFGDO_out(15),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(15),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDO(16),
          GlitchData    => CFGDO16_GlitchData,
          OutSignalName => "CFGDO(16)",
          OutTemp       => CFGDO_out(16),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(16),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDO(17),
          GlitchData    => CFGDO17_GlitchData,
          OutSignalName => "CFGDO(17)",
          OutTemp       => CFGDO_out(17),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(17),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDO(18),
          GlitchData    => CFGDO18_GlitchData,
          OutSignalName => "CFGDO(18)",
          OutTemp       => CFGDO_out(18),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(18),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDO(19),
          GlitchData    => CFGDO19_GlitchData,
          OutSignalName => "CFGDO(19)",
          OutTemp       => CFGDO_out(19),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(19),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDO(2),
          GlitchData    => CFGDO2_GlitchData,
          OutSignalName => "CFGDO(2)",
          OutTemp       => CFGDO_out(2),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDO(20),
          GlitchData    => CFGDO20_GlitchData,
          OutSignalName => "CFGDO(20)",
          OutTemp       => CFGDO_out(20),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(20),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDO(21),
          GlitchData    => CFGDO21_GlitchData,
          OutSignalName => "CFGDO(21)",
          OutTemp       => CFGDO_out(21),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(21),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDO(22),
          GlitchData    => CFGDO22_GlitchData,
          OutSignalName => "CFGDO(22)",
          OutTemp       => CFGDO_out(22),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(22),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDO(23),
          GlitchData    => CFGDO23_GlitchData,
          OutSignalName => "CFGDO(23)",
          OutTemp       => CFGDO_out(23),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(23),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDO(24),
          GlitchData    => CFGDO24_GlitchData,
          OutSignalName => "CFGDO(24)",
          OutTemp       => CFGDO_out(24),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(24),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDO(25),
          GlitchData    => CFGDO25_GlitchData,
          OutSignalName => "CFGDO(25)",
          OutTemp       => CFGDO_out(25),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(25),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDO(26),
          GlitchData    => CFGDO26_GlitchData,
          OutSignalName => "CFGDO(26)",
          OutTemp       => CFGDO_out(26),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(26),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDO(27),
          GlitchData    => CFGDO27_GlitchData,
          OutSignalName => "CFGDO(27)",
          OutTemp       => CFGDO_out(27),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(27),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDO(28),
          GlitchData    => CFGDO28_GlitchData,
          OutSignalName => "CFGDO(28)",
          OutTemp       => CFGDO_out(28),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(28),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDO(29),
          GlitchData    => CFGDO29_GlitchData,
          OutSignalName => "CFGDO(29)",
          OutTemp       => CFGDO_out(29),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(29),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDO(3),
          GlitchData    => CFGDO3_GlitchData,
          OutSignalName => "CFGDO(3)",
          OutTemp       => CFGDO_out(3),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(3),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDO(30),
          GlitchData    => CFGDO30_GlitchData,
          OutSignalName => "CFGDO(30)",
          OutTemp       => CFGDO_out(30),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(30),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDO(31),
          GlitchData    => CFGDO31_GlitchData,
          OutSignalName => "CFGDO(31)",
          OutTemp       => CFGDO_out(31),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(31),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDO(4),
          GlitchData    => CFGDO4_GlitchData,
          OutSignalName => "CFGDO(4)",
          OutTemp       => CFGDO_out(4),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(4),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDO(5),
          GlitchData    => CFGDO5_GlitchData,
          OutSignalName => "CFGDO(5)",
          OutTemp       => CFGDO_out(5),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(5),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDO(6),
          GlitchData    => CFGDO6_GlitchData,
          OutSignalName => "CFGDO(6)",
          OutTemp       => CFGDO_out(6),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(6),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDO(7),
          GlitchData    => CFGDO7_GlitchData,
          OutSignalName => "CFGDO(7)",
          OutTemp       => CFGDO_out(7),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(7),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDO(8),
          GlitchData    => CFGDO8_GlitchData,
          OutSignalName => "CFGDO(8)",
          OutTemp       => CFGDO_out(8),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(8),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDO(9),
          GlitchData    => CFGDO9_GlitchData,
          OutSignalName => "CFGDO(9)",
          OutTemp       => CFGDO_out(9),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDO(9),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on CFGDO_out;
    end process TIMING_PD_CFGDO;
    TIMING_PD_CFGFUNCTIONNUMBER : process
      variable CFGFUNCTIONNUMBER0_GlitchData : VitalGlitchDataType;
      variable CFGFUNCTIONNUMBER1_GlitchData : VitalGlitchDataType;
      variable CFGFUNCTIONNUMBER2_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => CFGFUNCTIONNUMBER(0),
          GlitchData    => CFGFUNCTIONNUMBER0_GlitchData,
          OutSignalName => "CFGFUNCTIONNUMBER(0)",
          OutTemp       => CFGFUNCTIONNUMBER_out(0),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGFUNCTIONNUMBER(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGFUNCTIONNUMBER(1),
          GlitchData    => CFGFUNCTIONNUMBER1_GlitchData,
          OutSignalName => "CFGFUNCTIONNUMBER(1)",
          OutTemp       => CFGFUNCTIONNUMBER_out(1),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGFUNCTIONNUMBER(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGFUNCTIONNUMBER(2),
          GlitchData    => CFGFUNCTIONNUMBER2_GlitchData,
          OutSignalName => "CFGFUNCTIONNUMBER(2)",
          OutTemp       => CFGFUNCTIONNUMBER_out(2),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGFUNCTIONNUMBER(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on CFGFUNCTIONNUMBER_out;
    end process TIMING_PD_CFGFUNCTIONNUMBER;
    TIMING_PD_CFGINTERRUPTDO : process
      variable CFGINTERRUPTDO0_GlitchData : VitalGlitchDataType;
      variable CFGINTERRUPTDO1_GlitchData : VitalGlitchDataType;
      variable CFGINTERRUPTDO2_GlitchData : VitalGlitchDataType;
      variable CFGINTERRUPTDO3_GlitchData : VitalGlitchDataType;
      variable CFGINTERRUPTDO4_GlitchData : VitalGlitchDataType;
      variable CFGINTERRUPTDO5_GlitchData : VitalGlitchDataType;
      variable CFGINTERRUPTDO6_GlitchData : VitalGlitchDataType;
      variable CFGINTERRUPTDO7_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => CFGINTERRUPTDO(0),
          GlitchData    => CFGINTERRUPTDO0_GlitchData,
          OutSignalName => "CFGINTERRUPTDO(0)",
          OutTemp       => CFGINTERRUPTDO_out(0),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGINTERRUPTDO(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGINTERRUPTDO(1),
          GlitchData    => CFGINTERRUPTDO1_GlitchData,
          OutSignalName => "CFGINTERRUPTDO(1)",
          OutTemp       => CFGINTERRUPTDO_out(1),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGINTERRUPTDO(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGINTERRUPTDO(2),
          GlitchData    => CFGINTERRUPTDO2_GlitchData,
          OutSignalName => "CFGINTERRUPTDO(2)",
          OutTemp       => CFGINTERRUPTDO_out(2),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGINTERRUPTDO(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGINTERRUPTDO(3),
          GlitchData    => CFGINTERRUPTDO3_GlitchData,
          OutSignalName => "CFGINTERRUPTDO(3)",
          OutTemp       => CFGINTERRUPTDO_out(3),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGINTERRUPTDO(3),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGINTERRUPTDO(4),
          GlitchData    => CFGINTERRUPTDO4_GlitchData,
          OutSignalName => "CFGINTERRUPTDO(4)",
          OutTemp       => CFGINTERRUPTDO_out(4),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGINTERRUPTDO(4),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGINTERRUPTDO(5),
          GlitchData    => CFGINTERRUPTDO5_GlitchData,
          OutSignalName => "CFGINTERRUPTDO(5)",
          OutTemp       => CFGINTERRUPTDO_out(5),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGINTERRUPTDO(5),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGINTERRUPTDO(6),
          GlitchData    => CFGINTERRUPTDO6_GlitchData,
          OutSignalName => "CFGINTERRUPTDO(6)",
          OutTemp       => CFGINTERRUPTDO_out(6),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGINTERRUPTDO(6),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGINTERRUPTDO(7),
          GlitchData    => CFGINTERRUPTDO7_GlitchData,
          OutSignalName => "CFGINTERRUPTDO(7)",
          OutTemp       => CFGINTERRUPTDO_out(7),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGINTERRUPTDO(7),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on CFGINTERRUPTDO_out;
    end process TIMING_PD_CFGINTERRUPTDO;
    TIMING_PD_CFGINTERRUPTMMENABLE : process
      variable CFGINTERRUPTMMENABLE0_GlitchData : VitalGlitchDataType;
      variable CFGINTERRUPTMMENABLE1_GlitchData : VitalGlitchDataType;
      variable CFGINTERRUPTMMENABLE2_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => CFGINTERRUPTMMENABLE(0),
          GlitchData    => CFGINTERRUPTMMENABLE0_GlitchData,
          OutSignalName => "CFGINTERRUPTMMENABLE(0)",
          OutTemp       => CFGINTERRUPTMMENABLE_out(0),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGINTERRUPTMMENABLE(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGINTERRUPTMMENABLE(1),
          GlitchData    => CFGINTERRUPTMMENABLE1_GlitchData,
          OutSignalName => "CFGINTERRUPTMMENABLE(1)",
          OutTemp       => CFGINTERRUPTMMENABLE_out(1),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGINTERRUPTMMENABLE(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGINTERRUPTMMENABLE(2),
          GlitchData    => CFGINTERRUPTMMENABLE2_GlitchData,
          OutSignalName => "CFGINTERRUPTMMENABLE(2)",
          OutTemp       => CFGINTERRUPTMMENABLE_out(2),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGINTERRUPTMMENABLE(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on CFGINTERRUPTMMENABLE_out;
    end process TIMING_PD_CFGINTERRUPTMMENABLE;
    TIMING_PD_CFGLINKCONTROLASPMCONTROL : process
      variable CFGLINKCONTROLASPMCONTROL0_GlitchData : VitalGlitchDataType;
      variable CFGLINKCONTROLASPMCONTROL1_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => CFGLINKCONTROLASPMCONTROL(0),
          GlitchData    => CFGLINKCONTROLASPMCONTROL0_GlitchData,
          OutSignalName => "CFGLINKCONTROLASPMCONTROL(0)",
          OutTemp       => CFGLINKCONTROLASPMCONTROL_out(0),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGLINKCONTROLASPMCONTROL(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGLINKCONTROLASPMCONTROL(1),
          GlitchData    => CFGLINKCONTROLASPMCONTROL1_GlitchData,
          OutSignalName => "CFGLINKCONTROLASPMCONTROL(1)",
          OutTemp       => CFGLINKCONTROLASPMCONTROL_out(1),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGLINKCONTROLASPMCONTROL(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on CFGLINKCONTROLASPMCONTROL_out;
    end process TIMING_PD_CFGLINKCONTROLASPMCONTROL;
    TIMING_PD_CFGLTSSMSTATE : process
      variable CFGLTSSMSTATE0_GlitchData : VitalGlitchDataType;
      variable CFGLTSSMSTATE1_GlitchData : VitalGlitchDataType;
      variable CFGLTSSMSTATE2_GlitchData : VitalGlitchDataType;
      variable CFGLTSSMSTATE3_GlitchData : VitalGlitchDataType;
      variable CFGLTSSMSTATE4_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => CFGLTSSMSTATE(0),
          GlitchData    => CFGLTSSMSTATE0_GlitchData,
          OutSignalName => "CFGLTSSMSTATE(0)",
          OutTemp       => CFGLTSSMSTATE_out(0),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_CFGLTSSMSTATE(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGLTSSMSTATE(1),
          GlitchData    => CFGLTSSMSTATE1_GlitchData,
          OutSignalName => "CFGLTSSMSTATE(1)",
          OutTemp       => CFGLTSSMSTATE_out(1),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_CFGLTSSMSTATE(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGLTSSMSTATE(2),
          GlitchData    => CFGLTSSMSTATE2_GlitchData,
          OutSignalName => "CFGLTSSMSTATE(2)",
          OutTemp       => CFGLTSSMSTATE_out(2),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_CFGLTSSMSTATE(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGLTSSMSTATE(3),
          GlitchData    => CFGLTSSMSTATE3_GlitchData,
          OutSignalName => "CFGLTSSMSTATE(3)",
          OutTemp       => CFGLTSSMSTATE_out(3),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_CFGLTSSMSTATE(3),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGLTSSMSTATE(4),
          GlitchData    => CFGLTSSMSTATE4_GlitchData,
          OutSignalName => "CFGLTSSMSTATE(4)",
          OutTemp       => CFGLTSSMSTATE_out(4),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_CFGLTSSMSTATE(4),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on CFGLTSSMSTATE_out;
    end process TIMING_PD_CFGLTSSMSTATE;
    TIMING_PD_CFGPCIELINKSTATEN : process
      variable CFGPCIELINKSTATEN0_GlitchData : VitalGlitchDataType;
      variable CFGPCIELINKSTATEN1_GlitchData : VitalGlitchDataType;
      variable CFGPCIELINKSTATEN2_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => CFGPCIELINKSTATEN(0),
          GlitchData    => CFGPCIELINKSTATEN0_GlitchData,
          OutSignalName => "CFGPCIELINKSTATEN(0)",
          OutTemp       => CFGPCIELINKSTATEN_out(0),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGPCIELINKSTATEN(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGPCIELINKSTATEN(1),
          GlitchData    => CFGPCIELINKSTATEN1_GlitchData,
          OutSignalName => "CFGPCIELINKSTATEN(1)",
          OutTemp       => CFGPCIELINKSTATEN_out(1),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGPCIELINKSTATEN(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGPCIELINKSTATEN(2),
          GlitchData    => CFGPCIELINKSTATEN2_GlitchData,
          OutSignalName => "CFGPCIELINKSTATEN(2)",
          OutTemp       => CFGPCIELINKSTATEN_out(2),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGPCIELINKSTATEN(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on CFGPCIELINKSTATEN_out;
    end process TIMING_PD_CFGPCIELINKSTATEN;
    TIMING_PD_MIMRXRADDR : process
      variable MIMRXRADDR0_GlitchData : VitalGlitchDataType;
      variable MIMRXRADDR10_GlitchData : VitalGlitchDataType;
      variable MIMRXRADDR11_GlitchData : VitalGlitchDataType;
      variable MIMRXRADDR1_GlitchData : VitalGlitchDataType;
      variable MIMRXRADDR2_GlitchData : VitalGlitchDataType;
      variable MIMRXRADDR3_GlitchData : VitalGlitchDataType;
      variable MIMRXRADDR4_GlitchData : VitalGlitchDataType;
      variable MIMRXRADDR5_GlitchData : VitalGlitchDataType;
      variable MIMRXRADDR6_GlitchData : VitalGlitchDataType;
      variable MIMRXRADDR7_GlitchData : VitalGlitchDataType;
      variable MIMRXRADDR8_GlitchData : VitalGlitchDataType;
      variable MIMRXRADDR9_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => MIMRXRADDR(0),
          GlitchData    => MIMRXRADDR0_GlitchData,
          OutSignalName => "MIMRXRADDR(0)",
          OutTemp       => MIMRXRADDR_out(0),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXRADDR(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXRADDR(1),
          GlitchData    => MIMRXRADDR1_GlitchData,
          OutSignalName => "MIMRXRADDR(1)",
          OutTemp       => MIMRXRADDR_out(1),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXRADDR(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXRADDR(10),
          GlitchData    => MIMRXRADDR10_GlitchData,
          OutSignalName => "MIMRXRADDR(10)",
          OutTemp       => MIMRXRADDR_out(10),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXRADDR(10),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXRADDR(11),
          GlitchData    => MIMRXRADDR11_GlitchData,
          OutSignalName => "MIMRXRADDR(11)",
          OutTemp       => MIMRXRADDR_out(11),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXRADDR(11),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXRADDR(2),
          GlitchData    => MIMRXRADDR2_GlitchData,
          OutSignalName => "MIMRXRADDR(2)",
          OutTemp       => MIMRXRADDR_out(2),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXRADDR(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXRADDR(3),
          GlitchData    => MIMRXRADDR3_GlitchData,
          OutSignalName => "MIMRXRADDR(3)",
          OutTemp       => MIMRXRADDR_out(3),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXRADDR(3),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXRADDR(4),
          GlitchData    => MIMRXRADDR4_GlitchData,
          OutSignalName => "MIMRXRADDR(4)",
          OutTemp       => MIMRXRADDR_out(4),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXRADDR(4),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXRADDR(5),
          GlitchData    => MIMRXRADDR5_GlitchData,
          OutSignalName => "MIMRXRADDR(5)",
          OutTemp       => MIMRXRADDR_out(5),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXRADDR(5),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXRADDR(6),
          GlitchData    => MIMRXRADDR6_GlitchData,
          OutSignalName => "MIMRXRADDR(6)",
          OutTemp       => MIMRXRADDR_out(6),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXRADDR(6),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXRADDR(7),
          GlitchData    => MIMRXRADDR7_GlitchData,
          OutSignalName => "MIMRXRADDR(7)",
          OutTemp       => MIMRXRADDR_out(7),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXRADDR(7),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXRADDR(8),
          GlitchData    => MIMRXRADDR8_GlitchData,
          OutSignalName => "MIMRXRADDR(8)",
          OutTemp       => MIMRXRADDR_out(8),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXRADDR(8),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXRADDR(9),
          GlitchData    => MIMRXRADDR9_GlitchData,
          OutSignalName => "MIMRXRADDR(9)",
          OutTemp       => MIMRXRADDR_out(9),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXRADDR(9),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on MIMRXRADDR_out;
    end process TIMING_PD_MIMRXRADDR;
    TIMING_PD_MIMRXWADDR : process
      variable MIMRXWADDR0_GlitchData : VitalGlitchDataType;
      variable MIMRXWADDR10_GlitchData : VitalGlitchDataType;
      variable MIMRXWADDR11_GlitchData : VitalGlitchDataType;
      variable MIMRXWADDR1_GlitchData : VitalGlitchDataType;
      variable MIMRXWADDR2_GlitchData : VitalGlitchDataType;
      variable MIMRXWADDR3_GlitchData : VitalGlitchDataType;
      variable MIMRXWADDR4_GlitchData : VitalGlitchDataType;
      variable MIMRXWADDR5_GlitchData : VitalGlitchDataType;
      variable MIMRXWADDR6_GlitchData : VitalGlitchDataType;
      variable MIMRXWADDR7_GlitchData : VitalGlitchDataType;
      variable MIMRXWADDR8_GlitchData : VitalGlitchDataType;
      variable MIMRXWADDR9_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => MIMRXWADDR(0),
          GlitchData    => MIMRXWADDR0_GlitchData,
          OutSignalName => "MIMRXWADDR(0)",
          OutTemp       => MIMRXWADDR_out(0),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWADDR(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWADDR(1),
          GlitchData    => MIMRXWADDR1_GlitchData,
          OutSignalName => "MIMRXWADDR(1)",
          OutTemp       => MIMRXWADDR_out(1),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWADDR(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWADDR(10),
          GlitchData    => MIMRXWADDR10_GlitchData,
          OutSignalName => "MIMRXWADDR(10)",
          OutTemp       => MIMRXWADDR_out(10),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWADDR(10),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWADDR(11),
          GlitchData    => MIMRXWADDR11_GlitchData,
          OutSignalName => "MIMRXWADDR(11)",
          OutTemp       => MIMRXWADDR_out(11),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWADDR(11),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWADDR(2),
          GlitchData    => MIMRXWADDR2_GlitchData,
          OutSignalName => "MIMRXWADDR(2)",
          OutTemp       => MIMRXWADDR_out(2),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWADDR(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWADDR(3),
          GlitchData    => MIMRXWADDR3_GlitchData,
          OutSignalName => "MIMRXWADDR(3)",
          OutTemp       => MIMRXWADDR_out(3),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWADDR(3),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWADDR(4),
          GlitchData    => MIMRXWADDR4_GlitchData,
          OutSignalName => "MIMRXWADDR(4)",
          OutTemp       => MIMRXWADDR_out(4),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWADDR(4),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWADDR(5),
          GlitchData    => MIMRXWADDR5_GlitchData,
          OutSignalName => "MIMRXWADDR(5)",
          OutTemp       => MIMRXWADDR_out(5),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWADDR(5),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWADDR(6),
          GlitchData    => MIMRXWADDR6_GlitchData,
          OutSignalName => "MIMRXWADDR(6)",
          OutTemp       => MIMRXWADDR_out(6),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWADDR(6),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWADDR(7),
          GlitchData    => MIMRXWADDR7_GlitchData,
          OutSignalName => "MIMRXWADDR(7)",
          OutTemp       => MIMRXWADDR_out(7),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWADDR(7),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWADDR(8),
          GlitchData    => MIMRXWADDR8_GlitchData,
          OutSignalName => "MIMRXWADDR(8)",
          OutTemp       => MIMRXWADDR_out(8),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWADDR(8),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWADDR(9),
          GlitchData    => MIMRXWADDR9_GlitchData,
          OutSignalName => "MIMRXWADDR(9)",
          OutTemp       => MIMRXWADDR_out(9),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWADDR(9),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on MIMRXWADDR_out;
    end process TIMING_PD_MIMRXWADDR;
    TIMING_PD_MIMRXWDATA : process
      variable MIMRXWDATA0_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA10_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA11_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA12_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA13_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA14_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA15_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA16_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA17_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA18_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA19_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA1_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA20_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA21_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA22_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA23_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA24_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA25_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA26_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA27_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA28_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA29_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA2_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA30_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA31_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA32_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA33_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA34_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA3_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA4_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA5_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA6_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA7_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA8_GlitchData : VitalGlitchDataType;
      variable MIMRXWDATA9_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(0),
          GlitchData    => MIMRXWDATA0_GlitchData,
          OutSignalName => "MIMRXWDATA(0)",
          OutTemp       => MIMRXWDATA_out(0),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(1),
          GlitchData    => MIMRXWDATA1_GlitchData,
          OutSignalName => "MIMRXWDATA(1)",
          OutTemp       => MIMRXWDATA_out(1),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(10),
          GlitchData    => MIMRXWDATA10_GlitchData,
          OutSignalName => "MIMRXWDATA(10)",
          OutTemp       => MIMRXWDATA_out(10),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(10),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(11),
          GlitchData    => MIMRXWDATA11_GlitchData,
          OutSignalName => "MIMRXWDATA(11)",
          OutTemp       => MIMRXWDATA_out(11),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(11),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(12),
          GlitchData    => MIMRXWDATA12_GlitchData,
          OutSignalName => "MIMRXWDATA(12)",
          OutTemp       => MIMRXWDATA_out(12),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(12),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(13),
          GlitchData    => MIMRXWDATA13_GlitchData,
          OutSignalName => "MIMRXWDATA(13)",
          OutTemp       => MIMRXWDATA_out(13),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(13),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(14),
          GlitchData    => MIMRXWDATA14_GlitchData,
          OutSignalName => "MIMRXWDATA(14)",
          OutTemp       => MIMRXWDATA_out(14),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(14),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(15),
          GlitchData    => MIMRXWDATA15_GlitchData,
          OutSignalName => "MIMRXWDATA(15)",
          OutTemp       => MIMRXWDATA_out(15),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(15),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(16),
          GlitchData    => MIMRXWDATA16_GlitchData,
          OutSignalName => "MIMRXWDATA(16)",
          OutTemp       => MIMRXWDATA_out(16),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(16),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(17),
          GlitchData    => MIMRXWDATA17_GlitchData,
          OutSignalName => "MIMRXWDATA(17)",
          OutTemp       => MIMRXWDATA_out(17),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(17),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(18),
          GlitchData    => MIMRXWDATA18_GlitchData,
          OutSignalName => "MIMRXWDATA(18)",
          OutTemp       => MIMRXWDATA_out(18),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(18),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(19),
          GlitchData    => MIMRXWDATA19_GlitchData,
          OutSignalName => "MIMRXWDATA(19)",
          OutTemp       => MIMRXWDATA_out(19),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(19),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(2),
          GlitchData    => MIMRXWDATA2_GlitchData,
          OutSignalName => "MIMRXWDATA(2)",
          OutTemp       => MIMRXWDATA_out(2),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(20),
          GlitchData    => MIMRXWDATA20_GlitchData,
          OutSignalName => "MIMRXWDATA(20)",
          OutTemp       => MIMRXWDATA_out(20),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(20),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(21),
          GlitchData    => MIMRXWDATA21_GlitchData,
          OutSignalName => "MIMRXWDATA(21)",
          OutTemp       => MIMRXWDATA_out(21),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(21),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(22),
          GlitchData    => MIMRXWDATA22_GlitchData,
          OutSignalName => "MIMRXWDATA(22)",
          OutTemp       => MIMRXWDATA_out(22),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(22),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(23),
          GlitchData    => MIMRXWDATA23_GlitchData,
          OutSignalName => "MIMRXWDATA(23)",
          OutTemp       => MIMRXWDATA_out(23),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(23),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(24),
          GlitchData    => MIMRXWDATA24_GlitchData,
          OutSignalName => "MIMRXWDATA(24)",
          OutTemp       => MIMRXWDATA_out(24),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(24),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(25),
          GlitchData    => MIMRXWDATA25_GlitchData,
          OutSignalName => "MIMRXWDATA(25)",
          OutTemp       => MIMRXWDATA_out(25),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(25),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(26),
          GlitchData    => MIMRXWDATA26_GlitchData,
          OutSignalName => "MIMRXWDATA(26)",
          OutTemp       => MIMRXWDATA_out(26),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(26),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(27),
          GlitchData    => MIMRXWDATA27_GlitchData,
          OutSignalName => "MIMRXWDATA(27)",
          OutTemp       => MIMRXWDATA_out(27),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(27),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(28),
          GlitchData    => MIMRXWDATA28_GlitchData,
          OutSignalName => "MIMRXWDATA(28)",
          OutTemp       => MIMRXWDATA_out(28),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(28),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(29),
          GlitchData    => MIMRXWDATA29_GlitchData,
          OutSignalName => "MIMRXWDATA(29)",
          OutTemp       => MIMRXWDATA_out(29),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(29),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(3),
          GlitchData    => MIMRXWDATA3_GlitchData,
          OutSignalName => "MIMRXWDATA(3)",
          OutTemp       => MIMRXWDATA_out(3),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(3),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(30),
          GlitchData    => MIMRXWDATA30_GlitchData,
          OutSignalName => "MIMRXWDATA(30)",
          OutTemp       => MIMRXWDATA_out(30),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(30),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(31),
          GlitchData    => MIMRXWDATA31_GlitchData,
          OutSignalName => "MIMRXWDATA(31)",
          OutTemp       => MIMRXWDATA_out(31),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(31),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(32),
          GlitchData    => MIMRXWDATA32_GlitchData,
          OutSignalName => "MIMRXWDATA(32)",
          OutTemp       => MIMRXWDATA_out(32),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(32),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(33),
          GlitchData    => MIMRXWDATA33_GlitchData,
          OutSignalName => "MIMRXWDATA(33)",
          OutTemp       => MIMRXWDATA_out(33),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(33),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(34),
          GlitchData    => MIMRXWDATA34_GlitchData,
          OutSignalName => "MIMRXWDATA(34)",
          OutTemp       => MIMRXWDATA_out(34),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(34),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(4),
          GlitchData    => MIMRXWDATA4_GlitchData,
          OutSignalName => "MIMRXWDATA(4)",
          OutTemp       => MIMRXWDATA_out(4),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(4),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(5),
          GlitchData    => MIMRXWDATA5_GlitchData,
          OutSignalName => "MIMRXWDATA(5)",
          OutTemp       => MIMRXWDATA_out(5),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(5),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(6),
          GlitchData    => MIMRXWDATA6_GlitchData,
          OutSignalName => "MIMRXWDATA(6)",
          OutTemp       => MIMRXWDATA_out(6),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(6),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(7),
          GlitchData    => MIMRXWDATA7_GlitchData,
          OutSignalName => "MIMRXWDATA(7)",
          OutTemp       => MIMRXWDATA_out(7),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(7),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(8),
          GlitchData    => MIMRXWDATA8_GlitchData,
          OutSignalName => "MIMRXWDATA(8)",
          OutTemp       => MIMRXWDATA_out(8),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(8),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWDATA(9),
          GlitchData    => MIMRXWDATA9_GlitchData,
          OutSignalName => "MIMRXWDATA(9)",
          OutTemp       => MIMRXWDATA_out(9),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWDATA(9),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on MIMRXWDATA_out;
    end process TIMING_PD_MIMRXWDATA;
    TIMING_PD_MIMTXRADDR : process
      variable MIMTXRADDR0_GlitchData : VitalGlitchDataType;
      variable MIMTXRADDR10_GlitchData : VitalGlitchDataType;
      variable MIMTXRADDR11_GlitchData : VitalGlitchDataType;
      variable MIMTXRADDR1_GlitchData : VitalGlitchDataType;
      variable MIMTXRADDR2_GlitchData : VitalGlitchDataType;
      variable MIMTXRADDR3_GlitchData : VitalGlitchDataType;
      variable MIMTXRADDR4_GlitchData : VitalGlitchDataType;
      variable MIMTXRADDR5_GlitchData : VitalGlitchDataType;
      variable MIMTXRADDR6_GlitchData : VitalGlitchDataType;
      variable MIMTXRADDR7_GlitchData : VitalGlitchDataType;
      variable MIMTXRADDR8_GlitchData : VitalGlitchDataType;
      variable MIMTXRADDR9_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => MIMTXRADDR(0),
          GlitchData    => MIMTXRADDR0_GlitchData,
          OutSignalName => "MIMTXRADDR(0)",
          OutTemp       => MIMTXRADDR_out(0),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXRADDR(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXRADDR(1),
          GlitchData    => MIMTXRADDR1_GlitchData,
          OutSignalName => "MIMTXRADDR(1)",
          OutTemp       => MIMTXRADDR_out(1),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXRADDR(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXRADDR(10),
          GlitchData    => MIMTXRADDR10_GlitchData,
          OutSignalName => "MIMTXRADDR(10)",
          OutTemp       => MIMTXRADDR_out(10),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXRADDR(10),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXRADDR(11),
          GlitchData    => MIMTXRADDR11_GlitchData,
          OutSignalName => "MIMTXRADDR(11)",
          OutTemp       => MIMTXRADDR_out(11),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXRADDR(11),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXRADDR(2),
          GlitchData    => MIMTXRADDR2_GlitchData,
          OutSignalName => "MIMTXRADDR(2)",
          OutTemp       => MIMTXRADDR_out(2),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXRADDR(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXRADDR(3),
          GlitchData    => MIMTXRADDR3_GlitchData,
          OutSignalName => "MIMTXRADDR(3)",
          OutTemp       => MIMTXRADDR_out(3),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXRADDR(3),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXRADDR(4),
          GlitchData    => MIMTXRADDR4_GlitchData,
          OutSignalName => "MIMTXRADDR(4)",
          OutTemp       => MIMTXRADDR_out(4),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXRADDR(4),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXRADDR(5),
          GlitchData    => MIMTXRADDR5_GlitchData,
          OutSignalName => "MIMTXRADDR(5)",
          OutTemp       => MIMTXRADDR_out(5),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXRADDR(5),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXRADDR(6),
          GlitchData    => MIMTXRADDR6_GlitchData,
          OutSignalName => "MIMTXRADDR(6)",
          OutTemp       => MIMTXRADDR_out(6),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXRADDR(6),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXRADDR(7),
          GlitchData    => MIMTXRADDR7_GlitchData,
          OutSignalName => "MIMTXRADDR(7)",
          OutTemp       => MIMTXRADDR_out(7),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXRADDR(7),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXRADDR(8),
          GlitchData    => MIMTXRADDR8_GlitchData,
          OutSignalName => "MIMTXRADDR(8)",
          OutTemp       => MIMTXRADDR_out(8),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXRADDR(8),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXRADDR(9),
          GlitchData    => MIMTXRADDR9_GlitchData,
          OutSignalName => "MIMTXRADDR(9)",
          OutTemp       => MIMTXRADDR_out(9),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXRADDR(9),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on MIMTXRADDR_out;
    end process TIMING_PD_MIMTXRADDR;
    TIMING_PD_MIMTXWADDR : process
      variable MIMTXWADDR0_GlitchData : VitalGlitchDataType;
      variable MIMTXWADDR10_GlitchData : VitalGlitchDataType;
      variable MIMTXWADDR11_GlitchData : VitalGlitchDataType;
      variable MIMTXWADDR1_GlitchData : VitalGlitchDataType;
      variable MIMTXWADDR2_GlitchData : VitalGlitchDataType;
      variable MIMTXWADDR3_GlitchData : VitalGlitchDataType;
      variable MIMTXWADDR4_GlitchData : VitalGlitchDataType;
      variable MIMTXWADDR5_GlitchData : VitalGlitchDataType;
      variable MIMTXWADDR6_GlitchData : VitalGlitchDataType;
      variable MIMTXWADDR7_GlitchData : VitalGlitchDataType;
      variable MIMTXWADDR8_GlitchData : VitalGlitchDataType;
      variable MIMTXWADDR9_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => MIMTXWADDR(0),
          GlitchData    => MIMTXWADDR0_GlitchData,
          OutSignalName => "MIMTXWADDR(0)",
          OutTemp       => MIMTXWADDR_out(0),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWADDR(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWADDR(1),
          GlitchData    => MIMTXWADDR1_GlitchData,
          OutSignalName => "MIMTXWADDR(1)",
          OutTemp       => MIMTXWADDR_out(1),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWADDR(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWADDR(10),
          GlitchData    => MIMTXWADDR10_GlitchData,
          OutSignalName => "MIMTXWADDR(10)",
          OutTemp       => MIMTXWADDR_out(10),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWADDR(10),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWADDR(11),
          GlitchData    => MIMTXWADDR11_GlitchData,
          OutSignalName => "MIMTXWADDR(11)",
          OutTemp       => MIMTXWADDR_out(11),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWADDR(11),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWADDR(2),
          GlitchData    => MIMTXWADDR2_GlitchData,
          OutSignalName => "MIMTXWADDR(2)",
          OutTemp       => MIMTXWADDR_out(2),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWADDR(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWADDR(3),
          GlitchData    => MIMTXWADDR3_GlitchData,
          OutSignalName => "MIMTXWADDR(3)",
          OutTemp       => MIMTXWADDR_out(3),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWADDR(3),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWADDR(4),
          GlitchData    => MIMTXWADDR4_GlitchData,
          OutSignalName => "MIMTXWADDR(4)",
          OutTemp       => MIMTXWADDR_out(4),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWADDR(4),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWADDR(5),
          GlitchData    => MIMTXWADDR5_GlitchData,
          OutSignalName => "MIMTXWADDR(5)",
          OutTemp       => MIMTXWADDR_out(5),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWADDR(5),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWADDR(6),
          GlitchData    => MIMTXWADDR6_GlitchData,
          OutSignalName => "MIMTXWADDR(6)",
          OutTemp       => MIMTXWADDR_out(6),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWADDR(6),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWADDR(7),
          GlitchData    => MIMTXWADDR7_GlitchData,
          OutSignalName => "MIMTXWADDR(7)",
          OutTemp       => MIMTXWADDR_out(7),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWADDR(7),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWADDR(8),
          GlitchData    => MIMTXWADDR8_GlitchData,
          OutSignalName => "MIMTXWADDR(8)",
          OutTemp       => MIMTXWADDR_out(8),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWADDR(8),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWADDR(9),
          GlitchData    => MIMTXWADDR9_GlitchData,
          OutSignalName => "MIMTXWADDR(9)",
          OutTemp       => MIMTXWADDR_out(9),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWADDR(9),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on MIMTXWADDR_out;
    end process TIMING_PD_MIMTXWADDR;
    TIMING_PD_MIMTXWDATA : process
      variable MIMTXWDATA0_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA10_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA11_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA12_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA13_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA14_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA15_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA16_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA17_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA18_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA19_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA1_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA20_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA21_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA22_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA23_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA24_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA25_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA26_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA27_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA28_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA29_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA2_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA30_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA31_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA32_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA33_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA34_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA35_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA3_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA4_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA5_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA6_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA7_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA8_GlitchData : VitalGlitchDataType;
      variable MIMTXWDATA9_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(0),
          GlitchData    => MIMTXWDATA0_GlitchData,
          OutSignalName => "MIMTXWDATA(0)",
          OutTemp       => MIMTXWDATA_out(0),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(1),
          GlitchData    => MIMTXWDATA1_GlitchData,
          OutSignalName => "MIMTXWDATA(1)",
          OutTemp       => MIMTXWDATA_out(1),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(10),
          GlitchData    => MIMTXWDATA10_GlitchData,
          OutSignalName => "MIMTXWDATA(10)",
          OutTemp       => MIMTXWDATA_out(10),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(10),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(11),
          GlitchData    => MIMTXWDATA11_GlitchData,
          OutSignalName => "MIMTXWDATA(11)",
          OutTemp       => MIMTXWDATA_out(11),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(11),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(12),
          GlitchData    => MIMTXWDATA12_GlitchData,
          OutSignalName => "MIMTXWDATA(12)",
          OutTemp       => MIMTXWDATA_out(12),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(12),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(13),
          GlitchData    => MIMTXWDATA13_GlitchData,
          OutSignalName => "MIMTXWDATA(13)",
          OutTemp       => MIMTXWDATA_out(13),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(13),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(14),
          GlitchData    => MIMTXWDATA14_GlitchData,
          OutSignalName => "MIMTXWDATA(14)",
          OutTemp       => MIMTXWDATA_out(14),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(14),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(15),
          GlitchData    => MIMTXWDATA15_GlitchData,
          OutSignalName => "MIMTXWDATA(15)",
          OutTemp       => MIMTXWDATA_out(15),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(15),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(16),
          GlitchData    => MIMTXWDATA16_GlitchData,
          OutSignalName => "MIMTXWDATA(16)",
          OutTemp       => MIMTXWDATA_out(16),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(16),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(17),
          GlitchData    => MIMTXWDATA17_GlitchData,
          OutSignalName => "MIMTXWDATA(17)",
          OutTemp       => MIMTXWDATA_out(17),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(17),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(18),
          GlitchData    => MIMTXWDATA18_GlitchData,
          OutSignalName => "MIMTXWDATA(18)",
          OutTemp       => MIMTXWDATA_out(18),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(18),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(19),
          GlitchData    => MIMTXWDATA19_GlitchData,
          OutSignalName => "MIMTXWDATA(19)",
          OutTemp       => MIMTXWDATA_out(19),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(19),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(2),
          GlitchData    => MIMTXWDATA2_GlitchData,
          OutSignalName => "MIMTXWDATA(2)",
          OutTemp       => MIMTXWDATA_out(2),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(20),
          GlitchData    => MIMTXWDATA20_GlitchData,
          OutSignalName => "MIMTXWDATA(20)",
          OutTemp       => MIMTXWDATA_out(20),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(20),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(21),
          GlitchData    => MIMTXWDATA21_GlitchData,
          OutSignalName => "MIMTXWDATA(21)",
          OutTemp       => MIMTXWDATA_out(21),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(21),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(22),
          GlitchData    => MIMTXWDATA22_GlitchData,
          OutSignalName => "MIMTXWDATA(22)",
          OutTemp       => MIMTXWDATA_out(22),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(22),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(23),
          GlitchData    => MIMTXWDATA23_GlitchData,
          OutSignalName => "MIMTXWDATA(23)",
          OutTemp       => MIMTXWDATA_out(23),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(23),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(24),
          GlitchData    => MIMTXWDATA24_GlitchData,
          OutSignalName => "MIMTXWDATA(24)",
          OutTemp       => MIMTXWDATA_out(24),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(24),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(25),
          GlitchData    => MIMTXWDATA25_GlitchData,
          OutSignalName => "MIMTXWDATA(25)",
          OutTemp       => MIMTXWDATA_out(25),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(25),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(26),
          GlitchData    => MIMTXWDATA26_GlitchData,
          OutSignalName => "MIMTXWDATA(26)",
          OutTemp       => MIMTXWDATA_out(26),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(26),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(27),
          GlitchData    => MIMTXWDATA27_GlitchData,
          OutSignalName => "MIMTXWDATA(27)",
          OutTemp       => MIMTXWDATA_out(27),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(27),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(28),
          GlitchData    => MIMTXWDATA28_GlitchData,
          OutSignalName => "MIMTXWDATA(28)",
          OutTemp       => MIMTXWDATA_out(28),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(28),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(29),
          GlitchData    => MIMTXWDATA29_GlitchData,
          OutSignalName => "MIMTXWDATA(29)",
          OutTemp       => MIMTXWDATA_out(29),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(29),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(3),
          GlitchData    => MIMTXWDATA3_GlitchData,
          OutSignalName => "MIMTXWDATA(3)",
          OutTemp       => MIMTXWDATA_out(3),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(3),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(30),
          GlitchData    => MIMTXWDATA30_GlitchData,
          OutSignalName => "MIMTXWDATA(30)",
          OutTemp       => MIMTXWDATA_out(30),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(30),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(31),
          GlitchData    => MIMTXWDATA31_GlitchData,
          OutSignalName => "MIMTXWDATA(31)",
          OutTemp       => MIMTXWDATA_out(31),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(31),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(32),
          GlitchData    => MIMTXWDATA32_GlitchData,
          OutSignalName => "MIMTXWDATA(32)",
          OutTemp       => MIMTXWDATA_out(32),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(32),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(33),
          GlitchData    => MIMTXWDATA33_GlitchData,
          OutSignalName => "MIMTXWDATA(33)",
          OutTemp       => MIMTXWDATA_out(33),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(33),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(34),
          GlitchData    => MIMTXWDATA34_GlitchData,
          OutSignalName => "MIMTXWDATA(34)",
          OutTemp       => MIMTXWDATA_out(34),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(34),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(35),
          GlitchData    => MIMTXWDATA35_GlitchData,
          OutSignalName => "MIMTXWDATA(35)",
          OutTemp       => MIMTXWDATA_out(35),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(35),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(4),
          GlitchData    => MIMTXWDATA4_GlitchData,
          OutSignalName => "MIMTXWDATA(4)",
          OutTemp       => MIMTXWDATA_out(4),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(4),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(5),
          GlitchData    => MIMTXWDATA5_GlitchData,
          OutSignalName => "MIMTXWDATA(5)",
          OutTemp       => MIMTXWDATA_out(5),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(5),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(6),
          GlitchData    => MIMTXWDATA6_GlitchData,
          OutSignalName => "MIMTXWDATA(6)",
          OutTemp       => MIMTXWDATA_out(6),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(6),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(7),
          GlitchData    => MIMTXWDATA7_GlitchData,
          OutSignalName => "MIMTXWDATA(7)",
          OutTemp       => MIMTXWDATA_out(7),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(7),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(8),
          GlitchData    => MIMTXWDATA8_GlitchData,
          OutSignalName => "MIMTXWDATA(8)",
          OutTemp       => MIMTXWDATA_out(8),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(8),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWDATA(9),
          GlitchData    => MIMTXWDATA9_GlitchData,
          OutSignalName => "MIMTXWDATA(9)",
          OutTemp       => MIMTXWDATA_out(9),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWDATA(9),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on MIMTXWDATA_out;
    end process TIMING_PD_MIMTXWDATA;
    TIMING_PD_PIPEGTPOWERDOWNA : process
      variable PIPEGTPOWERDOWNA0_GlitchData : VitalGlitchDataType;
      variable PIPEGTPOWERDOWNA1_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => PIPEGTPOWERDOWNA(0),
          GlitchData    => PIPEGTPOWERDOWNA0_GlitchData,
          OutSignalName => "PIPEGTPOWERDOWNA(0)",
          OutTemp       => PIPEGTPOWERDOWNA_out(0),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPEGTPOWERDOWNA(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPEGTPOWERDOWNA(1),
          GlitchData    => PIPEGTPOWERDOWNA1_GlitchData,
          OutSignalName => "PIPEGTPOWERDOWNA(1)",
          OutTemp       => PIPEGTPOWERDOWNA_out(1),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPEGTPOWERDOWNA(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on PIPEGTPOWERDOWNA_out;
    end process TIMING_PD_PIPEGTPOWERDOWNA;
    TIMING_PD_PIPEGTPOWERDOWNB : process
      variable PIPEGTPOWERDOWNB0_GlitchData : VitalGlitchDataType;
      variable PIPEGTPOWERDOWNB1_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => PIPEGTPOWERDOWNB(0),
          GlitchData    => PIPEGTPOWERDOWNB0_GlitchData,
          OutSignalName => "PIPEGTPOWERDOWNB(0)",
          OutTemp       => PIPEGTPOWERDOWNB_out(0),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPEGTPOWERDOWNB(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPEGTPOWERDOWNB(1),
          GlitchData    => PIPEGTPOWERDOWNB1_GlitchData,
          OutSignalName => "PIPEGTPOWERDOWNB(1)",
          OutTemp       => PIPEGTPOWERDOWNB_out(1),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPEGTPOWERDOWNB(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on PIPEGTPOWERDOWNB_out;
    end process TIMING_PD_PIPEGTPOWERDOWNB;
    TIMING_PD_PIPETXCHARDISPMODEA : process
      variable PIPETXCHARDISPMODEA0_GlitchData : VitalGlitchDataType;
      variable PIPETXCHARDISPMODEA1_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => PIPETXCHARDISPMODEA(0),
          GlitchData    => PIPETXCHARDISPMODEA0_GlitchData,
          OutSignalName => "PIPETXCHARDISPMODEA(0)",
          OutTemp       => PIPETXCHARDISPMODEA_out(0),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXCHARDISPMODEA(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXCHARDISPMODEA(1),
          GlitchData    => PIPETXCHARDISPMODEA1_GlitchData,
          OutSignalName => "PIPETXCHARDISPMODEA(1)",
          OutTemp       => PIPETXCHARDISPMODEA_out(1),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXCHARDISPMODEA(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on PIPETXCHARDISPMODEA_out;
    end process TIMING_PD_PIPETXCHARDISPMODEA;
    TIMING_PD_PIPETXCHARDISPMODEB : process
      variable PIPETXCHARDISPMODEB0_GlitchData : VitalGlitchDataType;
      variable PIPETXCHARDISPMODEB1_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => PIPETXCHARDISPMODEB(0),
          GlitchData    => PIPETXCHARDISPMODEB0_GlitchData,
          OutSignalName => "PIPETXCHARDISPMODEB(0)",
          OutTemp       => PIPETXCHARDISPMODEB_out(0),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXCHARDISPMODEB(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXCHARDISPMODEB(1),
          GlitchData    => PIPETXCHARDISPMODEB1_GlitchData,
          OutSignalName => "PIPETXCHARDISPMODEB(1)",
          OutTemp       => PIPETXCHARDISPMODEB_out(1),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXCHARDISPMODEB(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on PIPETXCHARDISPMODEB_out;
    end process TIMING_PD_PIPETXCHARDISPMODEB;
    TIMING_PD_PIPETXCHARDISPVALA : process
      variable PIPETXCHARDISPVALA0_GlitchData : VitalGlitchDataType;
      variable PIPETXCHARDISPVALA1_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => PIPETXCHARDISPVALA(0),
          GlitchData    => PIPETXCHARDISPVALA0_GlitchData,
          OutSignalName => "PIPETXCHARDISPVALA(0)",
          OutTemp       => PIPETXCHARDISPVALA_out(0),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXCHARDISPVALA(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXCHARDISPVALA(1),
          GlitchData    => PIPETXCHARDISPVALA1_GlitchData,
          OutSignalName => "PIPETXCHARDISPVALA(1)",
          OutTemp       => PIPETXCHARDISPVALA_out(1),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXCHARDISPVALA(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on PIPETXCHARDISPVALA_out;
    end process TIMING_PD_PIPETXCHARDISPVALA;
    TIMING_PD_PIPETXCHARDISPVALB : process
      variable PIPETXCHARDISPVALB0_GlitchData : VitalGlitchDataType;
      variable PIPETXCHARDISPVALB1_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => PIPETXCHARDISPVALB(0),
          GlitchData    => PIPETXCHARDISPVALB0_GlitchData,
          OutSignalName => "PIPETXCHARDISPVALB(0)",
          OutTemp       => PIPETXCHARDISPVALB_out(0),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXCHARDISPVALB(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXCHARDISPVALB(1),
          GlitchData    => PIPETXCHARDISPVALB1_GlitchData,
          OutSignalName => "PIPETXCHARDISPVALB(1)",
          OutTemp       => PIPETXCHARDISPVALB_out(1),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXCHARDISPVALB(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on PIPETXCHARDISPVALB_out;
    end process TIMING_PD_PIPETXCHARDISPVALB;
    TIMING_PD_PIPETXCHARISKA : process
      variable PIPETXCHARISKA0_GlitchData : VitalGlitchDataType;
      variable PIPETXCHARISKA1_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => PIPETXCHARISKA(0),
          GlitchData    => PIPETXCHARISKA0_GlitchData,
          OutSignalName => "PIPETXCHARISKA(0)",
          OutTemp       => PIPETXCHARISKA_out(0),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXCHARISKA(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXCHARISKA(1),
          GlitchData    => PIPETXCHARISKA1_GlitchData,
          OutSignalName => "PIPETXCHARISKA(1)",
          OutTemp       => PIPETXCHARISKA_out(1),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXCHARISKA(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on PIPETXCHARISKA_out;
    end process TIMING_PD_PIPETXCHARISKA;
    TIMING_PD_PIPETXCHARISKB : process
      variable PIPETXCHARISKB0_GlitchData : VitalGlitchDataType;
      variable PIPETXCHARISKB1_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => PIPETXCHARISKB(0),
          GlitchData    => PIPETXCHARISKB0_GlitchData,
          OutSignalName => "PIPETXCHARISKB(0)",
          OutTemp       => PIPETXCHARISKB_out(0),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXCHARISKB(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXCHARISKB(1),
          GlitchData    => PIPETXCHARISKB1_GlitchData,
          OutSignalName => "PIPETXCHARISKB(1)",
          OutTemp       => PIPETXCHARISKB_out(1),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXCHARISKB(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on PIPETXCHARISKB_out;
    end process TIMING_PD_PIPETXCHARISKB;
    TIMING_PD_PIPETXDATAA : process
      variable PIPETXDATAA0_GlitchData : VitalGlitchDataType;
      variable PIPETXDATAA10_GlitchData : VitalGlitchDataType;
      variable PIPETXDATAA11_GlitchData : VitalGlitchDataType;
      variable PIPETXDATAA12_GlitchData : VitalGlitchDataType;
      variable PIPETXDATAA13_GlitchData : VitalGlitchDataType;
      variable PIPETXDATAA14_GlitchData : VitalGlitchDataType;
      variable PIPETXDATAA15_GlitchData : VitalGlitchDataType;
      variable PIPETXDATAA1_GlitchData : VitalGlitchDataType;
      variable PIPETXDATAA2_GlitchData : VitalGlitchDataType;
      variable PIPETXDATAA3_GlitchData : VitalGlitchDataType;
      variable PIPETXDATAA4_GlitchData : VitalGlitchDataType;
      variable PIPETXDATAA5_GlitchData : VitalGlitchDataType;
      variable PIPETXDATAA6_GlitchData : VitalGlitchDataType;
      variable PIPETXDATAA7_GlitchData : VitalGlitchDataType;
      variable PIPETXDATAA8_GlitchData : VitalGlitchDataType;
      variable PIPETXDATAA9_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAA(0),
          GlitchData    => PIPETXDATAA0_GlitchData,
          OutSignalName => "PIPETXDATAA(0)",
          OutTemp       => PIPETXDATAA_out(0),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAA(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAA(1),
          GlitchData    => PIPETXDATAA1_GlitchData,
          OutSignalName => "PIPETXDATAA(1)",
          OutTemp       => PIPETXDATAA_out(1),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAA(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAA(10),
          GlitchData    => PIPETXDATAA10_GlitchData,
          OutSignalName => "PIPETXDATAA(10)",
          OutTemp       => PIPETXDATAA_out(10),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAA(10),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAA(11),
          GlitchData    => PIPETXDATAA11_GlitchData,
          OutSignalName => "PIPETXDATAA(11)",
          OutTemp       => PIPETXDATAA_out(11),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAA(11),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAA(12),
          GlitchData    => PIPETXDATAA12_GlitchData,
          OutSignalName => "PIPETXDATAA(12)",
          OutTemp       => PIPETXDATAA_out(12),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAA(12),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAA(13),
          GlitchData    => PIPETXDATAA13_GlitchData,
          OutSignalName => "PIPETXDATAA(13)",
          OutTemp       => PIPETXDATAA_out(13),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAA(13),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAA(14),
          GlitchData    => PIPETXDATAA14_GlitchData,
          OutSignalName => "PIPETXDATAA(14)",
          OutTemp       => PIPETXDATAA_out(14),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAA(14),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAA(15),
          GlitchData    => PIPETXDATAA15_GlitchData,
          OutSignalName => "PIPETXDATAA(15)",
          OutTemp       => PIPETXDATAA_out(15),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAA(15),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAA(2),
          GlitchData    => PIPETXDATAA2_GlitchData,
          OutSignalName => "PIPETXDATAA(2)",
          OutTemp       => PIPETXDATAA_out(2),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAA(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAA(3),
          GlitchData    => PIPETXDATAA3_GlitchData,
          OutSignalName => "PIPETXDATAA(3)",
          OutTemp       => PIPETXDATAA_out(3),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAA(3),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAA(4),
          GlitchData    => PIPETXDATAA4_GlitchData,
          OutSignalName => "PIPETXDATAA(4)",
          OutTemp       => PIPETXDATAA_out(4),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAA(4),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAA(5),
          GlitchData    => PIPETXDATAA5_GlitchData,
          OutSignalName => "PIPETXDATAA(5)",
          OutTemp       => PIPETXDATAA_out(5),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAA(5),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAA(6),
          GlitchData    => PIPETXDATAA6_GlitchData,
          OutSignalName => "PIPETXDATAA(6)",
          OutTemp       => PIPETXDATAA_out(6),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAA(6),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAA(7),
          GlitchData    => PIPETXDATAA7_GlitchData,
          OutSignalName => "PIPETXDATAA(7)",
          OutTemp       => PIPETXDATAA_out(7),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAA(7),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAA(8),
          GlitchData    => PIPETXDATAA8_GlitchData,
          OutSignalName => "PIPETXDATAA(8)",
          OutTemp       => PIPETXDATAA_out(8),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAA(8),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAA(9),
          GlitchData    => PIPETXDATAA9_GlitchData,
          OutSignalName => "PIPETXDATAA(9)",
          OutTemp       => PIPETXDATAA_out(9),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAA(9),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on PIPETXDATAA_out;
    end process TIMING_PD_PIPETXDATAA;
    TIMING_PD_PIPETXDATAB : process
      variable PIPETXDATAB0_GlitchData : VitalGlitchDataType;
      variable PIPETXDATAB10_GlitchData : VitalGlitchDataType;
      variable PIPETXDATAB11_GlitchData : VitalGlitchDataType;
      variable PIPETXDATAB12_GlitchData : VitalGlitchDataType;
      variable PIPETXDATAB13_GlitchData : VitalGlitchDataType;
      variable PIPETXDATAB14_GlitchData : VitalGlitchDataType;
      variable PIPETXDATAB15_GlitchData : VitalGlitchDataType;
      variable PIPETXDATAB1_GlitchData : VitalGlitchDataType;
      variable PIPETXDATAB2_GlitchData : VitalGlitchDataType;
      variable PIPETXDATAB3_GlitchData : VitalGlitchDataType;
      variable PIPETXDATAB4_GlitchData : VitalGlitchDataType;
      variable PIPETXDATAB5_GlitchData : VitalGlitchDataType;
      variable PIPETXDATAB6_GlitchData : VitalGlitchDataType;
      variable PIPETXDATAB7_GlitchData : VitalGlitchDataType;
      variable PIPETXDATAB8_GlitchData : VitalGlitchDataType;
      variable PIPETXDATAB9_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAB(0),
          GlitchData    => PIPETXDATAB0_GlitchData,
          OutSignalName => "PIPETXDATAB(0)",
          OutTemp       => PIPETXDATAB_out(0),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAB(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAB(1),
          GlitchData    => PIPETXDATAB1_GlitchData,
          OutSignalName => "PIPETXDATAB(1)",
          OutTemp       => PIPETXDATAB_out(1),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAB(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAB(10),
          GlitchData    => PIPETXDATAB10_GlitchData,
          OutSignalName => "PIPETXDATAB(10)",
          OutTemp       => PIPETXDATAB_out(10),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAB(10),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAB(11),
          GlitchData    => PIPETXDATAB11_GlitchData,
          OutSignalName => "PIPETXDATAB(11)",
          OutTemp       => PIPETXDATAB_out(11),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAB(11),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAB(12),
          GlitchData    => PIPETXDATAB12_GlitchData,
          OutSignalName => "PIPETXDATAB(12)",
          OutTemp       => PIPETXDATAB_out(12),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAB(12),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAB(13),
          GlitchData    => PIPETXDATAB13_GlitchData,
          OutSignalName => "PIPETXDATAB(13)",
          OutTemp       => PIPETXDATAB_out(13),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAB(13),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAB(14),
          GlitchData    => PIPETXDATAB14_GlitchData,
          OutSignalName => "PIPETXDATAB(14)",
          OutTemp       => PIPETXDATAB_out(14),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAB(14),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAB(15),
          GlitchData    => PIPETXDATAB15_GlitchData,
          OutSignalName => "PIPETXDATAB(15)",
          OutTemp       => PIPETXDATAB_out(15),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAB(15),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAB(2),
          GlitchData    => PIPETXDATAB2_GlitchData,
          OutSignalName => "PIPETXDATAB(2)",
          OutTemp       => PIPETXDATAB_out(2),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAB(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAB(3),
          GlitchData    => PIPETXDATAB3_GlitchData,
          OutSignalName => "PIPETXDATAB(3)",
          OutTemp       => PIPETXDATAB_out(3),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAB(3),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAB(4),
          GlitchData    => PIPETXDATAB4_GlitchData,
          OutSignalName => "PIPETXDATAB(4)",
          OutTemp       => PIPETXDATAB_out(4),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAB(4),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAB(5),
          GlitchData    => PIPETXDATAB5_GlitchData,
          OutSignalName => "PIPETXDATAB(5)",
          OutTemp       => PIPETXDATAB_out(5),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAB(5),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAB(6),
          GlitchData    => PIPETXDATAB6_GlitchData,
          OutSignalName => "PIPETXDATAB(6)",
          OutTemp       => PIPETXDATAB_out(6),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAB(6),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAB(7),
          GlitchData    => PIPETXDATAB7_GlitchData,
          OutSignalName => "PIPETXDATAB(7)",
          OutTemp       => PIPETXDATAB_out(7),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAB(7),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAB(8),
          GlitchData    => PIPETXDATAB8_GlitchData,
          OutSignalName => "PIPETXDATAB(8)",
          OutTemp       => PIPETXDATAB_out(8),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAB(8),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXDATAB(9),
          GlitchData    => PIPETXDATAB9_GlitchData,
          OutSignalName => "PIPETXDATAB(9)",
          OutTemp       => PIPETXDATAB_out(9),
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXDATAB(9),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on PIPETXDATAB_out;
    end process TIMING_PD_PIPETXDATAB;
    TIMING_PD_TRNFCCPLD : process
      variable TRNFCCPLD0_GlitchData : VitalGlitchDataType;
      variable TRNFCCPLD10_GlitchData : VitalGlitchDataType;
      variable TRNFCCPLD11_GlitchData : VitalGlitchDataType;
      variable TRNFCCPLD1_GlitchData : VitalGlitchDataType;
      variable TRNFCCPLD2_GlitchData : VitalGlitchDataType;
      variable TRNFCCPLD3_GlitchData : VitalGlitchDataType;
      variable TRNFCCPLD4_GlitchData : VitalGlitchDataType;
      variable TRNFCCPLD5_GlitchData : VitalGlitchDataType;
      variable TRNFCCPLD6_GlitchData : VitalGlitchDataType;
      variable TRNFCCPLD7_GlitchData : VitalGlitchDataType;
      variable TRNFCCPLD8_GlitchData : VitalGlitchDataType;
      variable TRNFCCPLD9_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => TRNFCCPLD(0),
          GlitchData    => TRNFCCPLD0_GlitchData,
          OutSignalName => "TRNFCCPLD(0)",
          OutTemp       => TRNFCCPLD_out(0),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCCPLD(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCCPLD(1),
          GlitchData    => TRNFCCPLD1_GlitchData,
          OutSignalName => "TRNFCCPLD(1)",
          OutTemp       => TRNFCCPLD_out(1),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCCPLD(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCCPLD(10),
          GlitchData    => TRNFCCPLD10_GlitchData,
          OutSignalName => "TRNFCCPLD(10)",
          OutTemp       => TRNFCCPLD_out(10),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCCPLD(10),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCCPLD(11),
          GlitchData    => TRNFCCPLD11_GlitchData,
          OutSignalName => "TRNFCCPLD(11)",
          OutTemp       => TRNFCCPLD_out(11),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCCPLD(11),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCCPLD(2),
          GlitchData    => TRNFCCPLD2_GlitchData,
          OutSignalName => "TRNFCCPLD(2)",
          OutTemp       => TRNFCCPLD_out(2),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCCPLD(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCCPLD(3),
          GlitchData    => TRNFCCPLD3_GlitchData,
          OutSignalName => "TRNFCCPLD(3)",
          OutTemp       => TRNFCCPLD_out(3),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCCPLD(3),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCCPLD(4),
          GlitchData    => TRNFCCPLD4_GlitchData,
          OutSignalName => "TRNFCCPLD(4)",
          OutTemp       => TRNFCCPLD_out(4),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCCPLD(4),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCCPLD(5),
          GlitchData    => TRNFCCPLD5_GlitchData,
          OutSignalName => "TRNFCCPLD(5)",
          OutTemp       => TRNFCCPLD_out(5),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCCPLD(5),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCCPLD(6),
          GlitchData    => TRNFCCPLD6_GlitchData,
          OutSignalName => "TRNFCCPLD(6)",
          OutTemp       => TRNFCCPLD_out(6),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCCPLD(6),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCCPLD(7),
          GlitchData    => TRNFCCPLD7_GlitchData,
          OutSignalName => "TRNFCCPLD(7)",
          OutTemp       => TRNFCCPLD_out(7),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCCPLD(7),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCCPLD(8),
          GlitchData    => TRNFCCPLD8_GlitchData,
          OutSignalName => "TRNFCCPLD(8)",
          OutTemp       => TRNFCCPLD_out(8),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCCPLD(8),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCCPLD(9),
          GlitchData    => TRNFCCPLD9_GlitchData,
          OutSignalName => "TRNFCCPLD(9)",
          OutTemp       => TRNFCCPLD_out(9),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCCPLD(9),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on TRNFCCPLD_out;
    end process TIMING_PD_TRNFCCPLD;
    TIMING_PD_TRNFCCPLH : process
      variable TRNFCCPLH0_GlitchData : VitalGlitchDataType;
      variable TRNFCCPLH1_GlitchData : VitalGlitchDataType;
      variable TRNFCCPLH2_GlitchData : VitalGlitchDataType;
      variable TRNFCCPLH3_GlitchData : VitalGlitchDataType;
      variable TRNFCCPLH4_GlitchData : VitalGlitchDataType;
      variable TRNFCCPLH5_GlitchData : VitalGlitchDataType;
      variable TRNFCCPLH6_GlitchData : VitalGlitchDataType;
      variable TRNFCCPLH7_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => TRNFCCPLH(0),
          GlitchData    => TRNFCCPLH0_GlitchData,
          OutSignalName => "TRNFCCPLH(0)",
          OutTemp       => TRNFCCPLH_out(0),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCCPLH(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCCPLH(1),
          GlitchData    => TRNFCCPLH1_GlitchData,
          OutSignalName => "TRNFCCPLH(1)",
          OutTemp       => TRNFCCPLH_out(1),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCCPLH(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCCPLH(2),
          GlitchData    => TRNFCCPLH2_GlitchData,
          OutSignalName => "TRNFCCPLH(2)",
          OutTemp       => TRNFCCPLH_out(2),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCCPLH(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCCPLH(3),
          GlitchData    => TRNFCCPLH3_GlitchData,
          OutSignalName => "TRNFCCPLH(3)",
          OutTemp       => TRNFCCPLH_out(3),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCCPLH(3),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCCPLH(4),
          GlitchData    => TRNFCCPLH4_GlitchData,
          OutSignalName => "TRNFCCPLH(4)",
          OutTemp       => TRNFCCPLH_out(4),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCCPLH(4),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCCPLH(5),
          GlitchData    => TRNFCCPLH5_GlitchData,
          OutSignalName => "TRNFCCPLH(5)",
          OutTemp       => TRNFCCPLH_out(5),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCCPLH(5),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCCPLH(6),
          GlitchData    => TRNFCCPLH6_GlitchData,
          OutSignalName => "TRNFCCPLH(6)",
          OutTemp       => TRNFCCPLH_out(6),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCCPLH(6),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCCPLH(7),
          GlitchData    => TRNFCCPLH7_GlitchData,
          OutSignalName => "TRNFCCPLH(7)",
          OutTemp       => TRNFCCPLH_out(7),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCCPLH(7),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on TRNFCCPLH_out;
    end process TIMING_PD_TRNFCCPLH;
    TIMING_PD_TRNFCNPD : process
      variable TRNFCNPD0_GlitchData : VitalGlitchDataType;
      variable TRNFCNPD10_GlitchData : VitalGlitchDataType;
      variable TRNFCNPD11_GlitchData : VitalGlitchDataType;
      variable TRNFCNPD1_GlitchData : VitalGlitchDataType;
      variable TRNFCNPD2_GlitchData : VitalGlitchDataType;
      variable TRNFCNPD3_GlitchData : VitalGlitchDataType;
      variable TRNFCNPD4_GlitchData : VitalGlitchDataType;
      variable TRNFCNPD5_GlitchData : VitalGlitchDataType;
      variable TRNFCNPD6_GlitchData : VitalGlitchDataType;
      variable TRNFCNPD7_GlitchData : VitalGlitchDataType;
      variable TRNFCNPD8_GlitchData : VitalGlitchDataType;
      variable TRNFCNPD9_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => TRNFCNPD(0),
          GlitchData    => TRNFCNPD0_GlitchData,
          OutSignalName => "TRNFCNPD(0)",
          OutTemp       => TRNFCNPD_out(0),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCNPD(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCNPD(1),
          GlitchData    => TRNFCNPD1_GlitchData,
          OutSignalName => "TRNFCNPD(1)",
          OutTemp       => TRNFCNPD_out(1),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCNPD(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCNPD(10),
          GlitchData    => TRNFCNPD10_GlitchData,
          OutSignalName => "TRNFCNPD(10)",
          OutTemp       => TRNFCNPD_out(10),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCNPD(10),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCNPD(11),
          GlitchData    => TRNFCNPD11_GlitchData,
          OutSignalName => "TRNFCNPD(11)",
          OutTemp       => TRNFCNPD_out(11),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCNPD(11),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCNPD(2),
          GlitchData    => TRNFCNPD2_GlitchData,
          OutSignalName => "TRNFCNPD(2)",
          OutTemp       => TRNFCNPD_out(2),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCNPD(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCNPD(3),
          GlitchData    => TRNFCNPD3_GlitchData,
          OutSignalName => "TRNFCNPD(3)",
          OutTemp       => TRNFCNPD_out(3),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCNPD(3),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCNPD(4),
          GlitchData    => TRNFCNPD4_GlitchData,
          OutSignalName => "TRNFCNPD(4)",
          OutTemp       => TRNFCNPD_out(4),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCNPD(4),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCNPD(5),
          GlitchData    => TRNFCNPD5_GlitchData,
          OutSignalName => "TRNFCNPD(5)",
          OutTemp       => TRNFCNPD_out(5),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCNPD(5),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCNPD(6),
          GlitchData    => TRNFCNPD6_GlitchData,
          OutSignalName => "TRNFCNPD(6)",
          OutTemp       => TRNFCNPD_out(6),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCNPD(6),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCNPD(7),
          GlitchData    => TRNFCNPD7_GlitchData,
          OutSignalName => "TRNFCNPD(7)",
          OutTemp       => TRNFCNPD_out(7),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCNPD(7),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCNPD(8),
          GlitchData    => TRNFCNPD8_GlitchData,
          OutSignalName => "TRNFCNPD(8)",
          OutTemp       => TRNFCNPD_out(8),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCNPD(8),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCNPD(9),
          GlitchData    => TRNFCNPD9_GlitchData,
          OutSignalName => "TRNFCNPD(9)",
          OutTemp       => TRNFCNPD_out(9),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCNPD(9),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on TRNFCNPD_out;
    end process TIMING_PD_TRNFCNPD;
    TIMING_PD_TRNFCNPH : process
      variable TRNFCNPH0_GlitchData : VitalGlitchDataType;
      variable TRNFCNPH1_GlitchData : VitalGlitchDataType;
      variable TRNFCNPH2_GlitchData : VitalGlitchDataType;
      variable TRNFCNPH3_GlitchData : VitalGlitchDataType;
      variable TRNFCNPH4_GlitchData : VitalGlitchDataType;
      variable TRNFCNPH5_GlitchData : VitalGlitchDataType;
      variable TRNFCNPH6_GlitchData : VitalGlitchDataType;
      variable TRNFCNPH7_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => TRNFCNPH(0),
          GlitchData    => TRNFCNPH0_GlitchData,
          OutSignalName => "TRNFCNPH(0)",
          OutTemp       => TRNFCNPH_out(0),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCNPH(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCNPH(1),
          GlitchData    => TRNFCNPH1_GlitchData,
          OutSignalName => "TRNFCNPH(1)",
          OutTemp       => TRNFCNPH_out(1),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCNPH(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCNPH(2),
          GlitchData    => TRNFCNPH2_GlitchData,
          OutSignalName => "TRNFCNPH(2)",
          OutTemp       => TRNFCNPH_out(2),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCNPH(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCNPH(3),
          GlitchData    => TRNFCNPH3_GlitchData,
          OutSignalName => "TRNFCNPH(3)",
          OutTemp       => TRNFCNPH_out(3),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCNPH(3),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCNPH(4),
          GlitchData    => TRNFCNPH4_GlitchData,
          OutSignalName => "TRNFCNPH(4)",
          OutTemp       => TRNFCNPH_out(4),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCNPH(4),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCNPH(5),
          GlitchData    => TRNFCNPH5_GlitchData,
          OutSignalName => "TRNFCNPH(5)",
          OutTemp       => TRNFCNPH_out(5),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCNPH(5),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCNPH(6),
          GlitchData    => TRNFCNPH6_GlitchData,
          OutSignalName => "TRNFCNPH(6)",
          OutTemp       => TRNFCNPH_out(6),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCNPH(6),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCNPH(7),
          GlitchData    => TRNFCNPH7_GlitchData,
          OutSignalName => "TRNFCNPH(7)",
          OutTemp       => TRNFCNPH_out(7),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCNPH(7),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on TRNFCNPH_out;
    end process TIMING_PD_TRNFCNPH;
    TIMING_PD_TRNFCPD : process
      variable TRNFCPD0_GlitchData : VitalGlitchDataType;
      variable TRNFCPD10_GlitchData : VitalGlitchDataType;
      variable TRNFCPD11_GlitchData : VitalGlitchDataType;
      variable TRNFCPD1_GlitchData : VitalGlitchDataType;
      variable TRNFCPD2_GlitchData : VitalGlitchDataType;
      variable TRNFCPD3_GlitchData : VitalGlitchDataType;
      variable TRNFCPD4_GlitchData : VitalGlitchDataType;
      variable TRNFCPD5_GlitchData : VitalGlitchDataType;
      variable TRNFCPD6_GlitchData : VitalGlitchDataType;
      variable TRNFCPD7_GlitchData : VitalGlitchDataType;
      variable TRNFCPD8_GlitchData : VitalGlitchDataType;
      variable TRNFCPD9_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => TRNFCPD(0),
          GlitchData    => TRNFCPD0_GlitchData,
          OutSignalName => "TRNFCPD(0)",
          OutTemp       => TRNFCPD_out(0),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCPD(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCPD(1),
          GlitchData    => TRNFCPD1_GlitchData,
          OutSignalName => "TRNFCPD(1)",
          OutTemp       => TRNFCPD_out(1),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCPD(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCPD(10),
          GlitchData    => TRNFCPD10_GlitchData,
          OutSignalName => "TRNFCPD(10)",
          OutTemp       => TRNFCPD_out(10),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCPD(10),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCPD(11),
          GlitchData    => TRNFCPD11_GlitchData,
          OutSignalName => "TRNFCPD(11)",
          OutTemp       => TRNFCPD_out(11),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCPD(11),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCPD(2),
          GlitchData    => TRNFCPD2_GlitchData,
          OutSignalName => "TRNFCPD(2)",
          OutTemp       => TRNFCPD_out(2),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCPD(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCPD(3),
          GlitchData    => TRNFCPD3_GlitchData,
          OutSignalName => "TRNFCPD(3)",
          OutTemp       => TRNFCPD_out(3),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCPD(3),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCPD(4),
          GlitchData    => TRNFCPD4_GlitchData,
          OutSignalName => "TRNFCPD(4)",
          OutTemp       => TRNFCPD_out(4),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCPD(4),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCPD(5),
          GlitchData    => TRNFCPD5_GlitchData,
          OutSignalName => "TRNFCPD(5)",
          OutTemp       => TRNFCPD_out(5),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCPD(5),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCPD(6),
          GlitchData    => TRNFCPD6_GlitchData,
          OutSignalName => "TRNFCPD(6)",
          OutTemp       => TRNFCPD_out(6),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCPD(6),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCPD(7),
          GlitchData    => TRNFCPD7_GlitchData,
          OutSignalName => "TRNFCPD(7)",
          OutTemp       => TRNFCPD_out(7),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCPD(7),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCPD(8),
          GlitchData    => TRNFCPD8_GlitchData,
          OutSignalName => "TRNFCPD(8)",
          OutTemp       => TRNFCPD_out(8),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCPD(8),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCPD(9),
          GlitchData    => TRNFCPD9_GlitchData,
          OutSignalName => "TRNFCPD(9)",
          OutTemp       => TRNFCPD_out(9),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCPD(9),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on TRNFCPD_out;
    end process TIMING_PD_TRNFCPD;
    TIMING_PD_TRNFCPH : process
      variable TRNFCPH0_GlitchData : VitalGlitchDataType;
      variable TRNFCPH1_GlitchData : VitalGlitchDataType;
      variable TRNFCPH2_GlitchData : VitalGlitchDataType;
      variable TRNFCPH3_GlitchData : VitalGlitchDataType;
      variable TRNFCPH4_GlitchData : VitalGlitchDataType;
      variable TRNFCPH5_GlitchData : VitalGlitchDataType;
      variable TRNFCPH6_GlitchData : VitalGlitchDataType;
      variable TRNFCPH7_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => TRNFCPH(0),
          GlitchData    => TRNFCPH0_GlitchData,
          OutSignalName => "TRNFCPH(0)",
          OutTemp       => TRNFCPH_out(0),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCPH(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCPH(1),
          GlitchData    => TRNFCPH1_GlitchData,
          OutSignalName => "TRNFCPH(1)",
          OutTemp       => TRNFCPH_out(1),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCPH(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCPH(2),
          GlitchData    => TRNFCPH2_GlitchData,
          OutSignalName => "TRNFCPH(2)",
          OutTemp       => TRNFCPH_out(2),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCPH(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCPH(3),
          GlitchData    => TRNFCPH3_GlitchData,
          OutSignalName => "TRNFCPH(3)",
          OutTemp       => TRNFCPH_out(3),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCPH(3),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCPH(4),
          GlitchData    => TRNFCPH4_GlitchData,
          OutSignalName => "TRNFCPH(4)",
          OutTemp       => TRNFCPH_out(4),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCPH(4),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCPH(5),
          GlitchData    => TRNFCPH5_GlitchData,
          OutSignalName => "TRNFCPH(5)",
          OutTemp       => TRNFCPH_out(5),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCPH(5),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCPH(6),
          GlitchData    => TRNFCPH6_GlitchData,
          OutSignalName => "TRNFCPH(6)",
          OutTemp       => TRNFCPH_out(6),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCPH(6),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNFCPH(7),
          GlitchData    => TRNFCPH7_GlitchData,
          OutSignalName => "TRNFCPH(7)",
          OutTemp       => TRNFCPH_out(7),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNFCPH(7),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on TRNFCPH_out;
    end process TIMING_PD_TRNFCPH;
    TIMING_PD_TRNRBARHITN : process
      variable TRNRBARHITN0_GlitchData : VitalGlitchDataType;
      variable TRNRBARHITN1_GlitchData : VitalGlitchDataType;
      variable TRNRBARHITN2_GlitchData : VitalGlitchDataType;
      variable TRNRBARHITN3_GlitchData : VitalGlitchDataType;
      variable TRNRBARHITN4_GlitchData : VitalGlitchDataType;
      variable TRNRBARHITN5_GlitchData : VitalGlitchDataType;
      variable TRNRBARHITN6_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => TRNRBARHITN(0),
          GlitchData    => TRNRBARHITN0_GlitchData,
          OutSignalName => "TRNRBARHITN(0)",
          OutTemp       => TRNRBARHITN_out(0),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRBARHITN(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRBARHITN(1),
          GlitchData    => TRNRBARHITN1_GlitchData,
          OutSignalName => "TRNRBARHITN(1)",
          OutTemp       => TRNRBARHITN_out(1),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRBARHITN(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRBARHITN(2),
          GlitchData    => TRNRBARHITN2_GlitchData,
          OutSignalName => "TRNRBARHITN(2)",
          OutTemp       => TRNRBARHITN_out(2),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRBARHITN(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRBARHITN(3),
          GlitchData    => TRNRBARHITN3_GlitchData,
          OutSignalName => "TRNRBARHITN(3)",
          OutTemp       => TRNRBARHITN_out(3),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRBARHITN(3),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRBARHITN(4),
          GlitchData    => TRNRBARHITN4_GlitchData,
          OutSignalName => "TRNRBARHITN(4)",
          OutTemp       => TRNRBARHITN_out(4),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRBARHITN(4),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRBARHITN(5),
          GlitchData    => TRNRBARHITN5_GlitchData,
          OutSignalName => "TRNRBARHITN(5)",
          OutTemp       => TRNRBARHITN_out(5),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRBARHITN(5),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRBARHITN(6),
          GlitchData    => TRNRBARHITN6_GlitchData,
          OutSignalName => "TRNRBARHITN(6)",
          OutTemp       => TRNRBARHITN_out(6),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRBARHITN(6),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on TRNRBARHITN_out;
    end process TIMING_PD_TRNRBARHITN;
    TIMING_PD_TRNRD : process
      variable TRNRD0_GlitchData : VitalGlitchDataType;
      variable TRNRD10_GlitchData : VitalGlitchDataType;
      variable TRNRD11_GlitchData : VitalGlitchDataType;
      variable TRNRD12_GlitchData : VitalGlitchDataType;
      variable TRNRD13_GlitchData : VitalGlitchDataType;
      variable TRNRD14_GlitchData : VitalGlitchDataType;
      variable TRNRD15_GlitchData : VitalGlitchDataType;
      variable TRNRD16_GlitchData : VitalGlitchDataType;
      variable TRNRD17_GlitchData : VitalGlitchDataType;
      variable TRNRD18_GlitchData : VitalGlitchDataType;
      variable TRNRD19_GlitchData : VitalGlitchDataType;
      variable TRNRD1_GlitchData : VitalGlitchDataType;
      variable TRNRD20_GlitchData : VitalGlitchDataType;
      variable TRNRD21_GlitchData : VitalGlitchDataType;
      variable TRNRD22_GlitchData : VitalGlitchDataType;
      variable TRNRD23_GlitchData : VitalGlitchDataType;
      variable TRNRD24_GlitchData : VitalGlitchDataType;
      variable TRNRD25_GlitchData : VitalGlitchDataType;
      variable TRNRD26_GlitchData : VitalGlitchDataType;
      variable TRNRD27_GlitchData : VitalGlitchDataType;
      variable TRNRD28_GlitchData : VitalGlitchDataType;
      variable TRNRD29_GlitchData : VitalGlitchDataType;
      variable TRNRD2_GlitchData : VitalGlitchDataType;
      variable TRNRD30_GlitchData : VitalGlitchDataType;
      variable TRNRD31_GlitchData : VitalGlitchDataType;
      variable TRNRD3_GlitchData : VitalGlitchDataType;
      variable TRNRD4_GlitchData : VitalGlitchDataType;
      variable TRNRD5_GlitchData : VitalGlitchDataType;
      variable TRNRD6_GlitchData : VitalGlitchDataType;
      variable TRNRD7_GlitchData : VitalGlitchDataType;
      variable TRNRD8_GlitchData : VitalGlitchDataType;
      variable TRNRD9_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => TRNRD(0),
          GlitchData    => TRNRD0_GlitchData,
          OutSignalName => "TRNRD(0)",
          OutTemp       => TRNRD_out(0),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRD(1),
          GlitchData    => TRNRD1_GlitchData,
          OutSignalName => "TRNRD(1)",
          OutTemp       => TRNRD_out(1),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRD(10),
          GlitchData    => TRNRD10_GlitchData,
          OutSignalName => "TRNRD(10)",
          OutTemp       => TRNRD_out(10),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(10),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRD(11),
          GlitchData    => TRNRD11_GlitchData,
          OutSignalName => "TRNRD(11)",
          OutTemp       => TRNRD_out(11),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(11),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRD(12),
          GlitchData    => TRNRD12_GlitchData,
          OutSignalName => "TRNRD(12)",
          OutTemp       => TRNRD_out(12),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(12),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRD(13),
          GlitchData    => TRNRD13_GlitchData,
          OutSignalName => "TRNRD(13)",
          OutTemp       => TRNRD_out(13),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(13),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRD(14),
          GlitchData    => TRNRD14_GlitchData,
          OutSignalName => "TRNRD(14)",
          OutTemp       => TRNRD_out(14),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(14),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRD(15),
          GlitchData    => TRNRD15_GlitchData,
          OutSignalName => "TRNRD(15)",
          OutTemp       => TRNRD_out(15),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(15),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRD(16),
          GlitchData    => TRNRD16_GlitchData,
          OutSignalName => "TRNRD(16)",
          OutTemp       => TRNRD_out(16),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(16),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRD(17),
          GlitchData    => TRNRD17_GlitchData,
          OutSignalName => "TRNRD(17)",
          OutTemp       => TRNRD_out(17),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(17),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRD(18),
          GlitchData    => TRNRD18_GlitchData,
          OutSignalName => "TRNRD(18)",
          OutTemp       => TRNRD_out(18),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(18),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRD(19),
          GlitchData    => TRNRD19_GlitchData,
          OutSignalName => "TRNRD(19)",
          OutTemp       => TRNRD_out(19),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(19),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRD(2),
          GlitchData    => TRNRD2_GlitchData,
          OutSignalName => "TRNRD(2)",
          OutTemp       => TRNRD_out(2),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRD(20),
          GlitchData    => TRNRD20_GlitchData,
          OutSignalName => "TRNRD(20)",
          OutTemp       => TRNRD_out(20),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(20),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRD(21),
          GlitchData    => TRNRD21_GlitchData,
          OutSignalName => "TRNRD(21)",
          OutTemp       => TRNRD_out(21),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(21),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRD(22),
          GlitchData    => TRNRD22_GlitchData,
          OutSignalName => "TRNRD(22)",
          OutTemp       => TRNRD_out(22),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(22),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRD(23),
          GlitchData    => TRNRD23_GlitchData,
          OutSignalName => "TRNRD(23)",
          OutTemp       => TRNRD_out(23),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(23),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRD(24),
          GlitchData    => TRNRD24_GlitchData,
          OutSignalName => "TRNRD(24)",
          OutTemp       => TRNRD_out(24),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(24),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRD(25),
          GlitchData    => TRNRD25_GlitchData,
          OutSignalName => "TRNRD(25)",
          OutTemp       => TRNRD_out(25),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(25),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRD(26),
          GlitchData    => TRNRD26_GlitchData,
          OutSignalName => "TRNRD(26)",
          OutTemp       => TRNRD_out(26),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(26),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRD(27),
          GlitchData    => TRNRD27_GlitchData,
          OutSignalName => "TRNRD(27)",
          OutTemp       => TRNRD_out(27),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(27),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRD(28),
          GlitchData    => TRNRD28_GlitchData,
          OutSignalName => "TRNRD(28)",
          OutTemp       => TRNRD_out(28),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(28),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRD(29),
          GlitchData    => TRNRD29_GlitchData,
          OutSignalName => "TRNRD(29)",
          OutTemp       => TRNRD_out(29),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(29),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRD(3),
          GlitchData    => TRNRD3_GlitchData,
          OutSignalName => "TRNRD(3)",
          OutTemp       => TRNRD_out(3),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(3),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRD(30),
          GlitchData    => TRNRD30_GlitchData,
          OutSignalName => "TRNRD(30)",
          OutTemp       => TRNRD_out(30),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(30),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRD(31),
          GlitchData    => TRNRD31_GlitchData,
          OutSignalName => "TRNRD(31)",
          OutTemp       => TRNRD_out(31),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(31),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRD(4),
          GlitchData    => TRNRD4_GlitchData,
          OutSignalName => "TRNRD(4)",
          OutTemp       => TRNRD_out(4),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(4),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRD(5),
          GlitchData    => TRNRD5_GlitchData,
          OutSignalName => "TRNRD(5)",
          OutTemp       => TRNRD_out(5),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(5),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRD(6),
          GlitchData    => TRNRD6_GlitchData,
          OutSignalName => "TRNRD(6)",
          OutTemp       => TRNRD_out(6),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(6),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRD(7),
          GlitchData    => TRNRD7_GlitchData,
          OutSignalName => "TRNRD(7)",
          OutTemp       => TRNRD_out(7),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(7),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRD(8),
          GlitchData    => TRNRD8_GlitchData,
          OutSignalName => "TRNRD(8)",
          OutTemp       => TRNRD_out(8),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(8),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRD(9),
          GlitchData    => TRNRD9_GlitchData,
          OutSignalName => "TRNRD(9)",
          OutTemp       => TRNRD_out(9),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRD(9),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on TRNRD_out;
    end process TIMING_PD_TRNRD;
    TIMING_PD_TRNTBUFAV : process
      variable TRNTBUFAV0_GlitchData : VitalGlitchDataType;
      variable TRNTBUFAV1_GlitchData : VitalGlitchDataType;
      variable TRNTBUFAV2_GlitchData : VitalGlitchDataType;
      variable TRNTBUFAV3_GlitchData : VitalGlitchDataType;
      variable TRNTBUFAV4_GlitchData : VitalGlitchDataType;
      variable TRNTBUFAV5_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => TRNTBUFAV(0),
          GlitchData    => TRNTBUFAV0_GlitchData,
          OutSignalName => "TRNTBUFAV(0)",
          OutTemp       => TRNTBUFAV_out(0),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNTBUFAV(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNTBUFAV(1),
          GlitchData    => TRNTBUFAV1_GlitchData,
          OutSignalName => "TRNTBUFAV(1)",
          OutTemp       => TRNTBUFAV_out(1),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNTBUFAV(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNTBUFAV(2),
          GlitchData    => TRNTBUFAV2_GlitchData,
          OutSignalName => "TRNTBUFAV(2)",
          OutTemp       => TRNTBUFAV_out(2),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNTBUFAV(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNTBUFAV(3),
          GlitchData    => TRNTBUFAV3_GlitchData,
          OutSignalName => "TRNTBUFAV(3)",
          OutTemp       => TRNTBUFAV_out(3),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNTBUFAV(3),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNTBUFAV(4),
          GlitchData    => TRNTBUFAV4_GlitchData,
          OutSignalName => "TRNTBUFAV(4)",
          OutTemp       => TRNTBUFAV_out(4),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNTBUFAV(4),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNTBUFAV(5),
          GlitchData    => TRNTBUFAV5_GlitchData,
          OutSignalName => "TRNTBUFAV(5)",
          OutTemp       => TRNTBUFAV_out(5),
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNTBUFAV(5),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on TRNTBUFAV_out;
    end process TIMING_PD_TRNTBUFAV;
    TIMING_PD : process
      variable CFGCOMMANDBUSMASTERENABLE_GlitchData : VitalGlitchDataType;
      variable CFGCOMMANDINTERRUPTDISABLE_GlitchData : VitalGlitchDataType;
      variable CFGCOMMANDIOENABLE_GlitchData : VitalGlitchDataType;
      variable CFGCOMMANDMEMENABLE_GlitchData : VitalGlitchDataType;
      variable CFGCOMMANDSERREN_GlitchData : VitalGlitchDataType;
      variable CFGDEVCONTROLAUXPOWEREN_GlitchData : VitalGlitchDataType;
      variable CFGDEVCONTROLCORRERRREPORTINGEN_GlitchData : VitalGlitchDataType;
      variable CFGDEVCONTROLENABLERO_GlitchData : VitalGlitchDataType;
      variable CFGDEVCONTROLEXTTAGEN_GlitchData : VitalGlitchDataType;
      variable CFGDEVCONTROLFATALERRREPORTINGEN_GlitchData : VitalGlitchDataType;
      variable CFGDEVCONTROLNONFATALREPORTINGEN_GlitchData : VitalGlitchDataType;
      variable CFGDEVCONTROLNOSNOOPEN_GlitchData : VitalGlitchDataType;
      variable CFGDEVCONTROLPHANTOMEN_GlitchData : VitalGlitchDataType;
      variable CFGDEVCONTROLURERRREPORTINGEN_GlitchData : VitalGlitchDataType;
      variable CFGDEVSTATUSCORRERRDETECTED_GlitchData : VitalGlitchDataType;
      variable CFGDEVSTATUSFATALERRDETECTED_GlitchData : VitalGlitchDataType;
      variable CFGDEVSTATUSNONFATALERRDETECTED_GlitchData : VitalGlitchDataType;
      variable CFGDEVSTATUSURDETECTED_GlitchData : VitalGlitchDataType;
      variable CFGERRCPLRDYN_GlitchData : VitalGlitchDataType;
      variable CFGINTERRUPTMSIENABLE_GlitchData : VitalGlitchDataType;
      variable CFGINTERRUPTRDYN_GlitchData : VitalGlitchDataType;
      variable CFGLINKCONTOLRCB_GlitchData : VitalGlitchDataType;
      variable CFGLINKCONTROLCOMMONCLOCK_GlitchData : VitalGlitchDataType;
      variable CFGLINKCONTROLEXTENDEDSYNC_GlitchData : VitalGlitchDataType;
      variable CFGRDWRDONEN_GlitchData : VitalGlitchDataType;
      variable CFGTOTURNOFFN_GlitchData : VitalGlitchDataType;
      variable DBGBADDLLPSTATUS_GlitchData : VitalGlitchDataType;
      variable DBGBADTLPLCRC_GlitchData : VitalGlitchDataType;
      variable DBGBADTLPSEQNUM_GlitchData : VitalGlitchDataType;
      variable DBGBADTLPSTATUS_GlitchData : VitalGlitchDataType;
      variable DBGDLPROTOCOLSTATUS_GlitchData : VitalGlitchDataType;
      variable DBGFCPROTOCOLERRSTATUS_GlitchData : VitalGlitchDataType;
      variable DBGMLFRMDLENGTH_GlitchData : VitalGlitchDataType;
      variable DBGMLFRMDMPS_GlitchData : VitalGlitchDataType;
      variable DBGMLFRMDTCVC_GlitchData : VitalGlitchDataType;
      variable DBGMLFRMDTLPSTATUS_GlitchData : VitalGlitchDataType;
      variable DBGMLFRMDUNRECTYPE_GlitchData : VitalGlitchDataType;
      variable DBGPOISTLPSTATUS_GlitchData : VitalGlitchDataType;
      variable DBGRCVROVERFLOWSTATUS_GlitchData : VitalGlitchDataType;
      variable DBGREGDETECTEDCORRECTABLE_GlitchData : VitalGlitchDataType;
      variable DBGREGDETECTEDFATAL_GlitchData : VitalGlitchDataType;
      variable DBGREGDETECTEDNONFATAL_GlitchData : VitalGlitchDataType;
      variable DBGREGDETECTEDUNSUPPORTED_GlitchData : VitalGlitchDataType;
      variable DBGRPLYROLLOVERSTATUS_GlitchData : VitalGlitchDataType;
      variable DBGRPLYTIMEOUTSTATUS_GlitchData : VitalGlitchDataType;
      variable DBGURNOBARHIT_GlitchData : VitalGlitchDataType;
      variable DBGURPOISCFGWR_GlitchData : VitalGlitchDataType;
      variable DBGURSTATUS_GlitchData : VitalGlitchDataType;
      variable DBGURUNSUPMSG_GlitchData : VitalGlitchDataType;
      variable MIMRXREN_GlitchData : VitalGlitchDataType;
      variable MIMRXWEN_GlitchData : VitalGlitchDataType;
      variable MIMTXREN_GlitchData : VitalGlitchDataType;
      variable MIMTXWEN_GlitchData : VitalGlitchDataType;
      variable PIPEGTTXELECIDLEA_GlitchData : VitalGlitchDataType;
      variable PIPEGTTXELECIDLEB_GlitchData : VitalGlitchDataType;
      variable PIPERXPOLARITYA_GlitchData : VitalGlitchDataType;
      variable PIPERXPOLARITYB_GlitchData : VitalGlitchDataType;
      variable PIPERXRESETA_GlitchData : VitalGlitchDataType;
      variable PIPERXRESETB_GlitchData : VitalGlitchDataType;
      variable PIPETXRCVRDETA_GlitchData : VitalGlitchDataType;
      variable PIPETXRCVRDETB_GlitchData : VitalGlitchDataType;
      variable RECEIVEDHOTRESET_GlitchData : VitalGlitchDataType;
      variable TRNLNKUPN_GlitchData : VitalGlitchDataType;
      variable TRNREOFN_GlitchData : VitalGlitchDataType;
      variable TRNRERRFWDN_GlitchData : VitalGlitchDataType;
      variable TRNRSOFN_GlitchData : VitalGlitchDataType;
      variable TRNRSRCDSCN_GlitchData : VitalGlitchDataType;
      variable TRNRSRCRDYN_GlitchData : VitalGlitchDataType;
      variable TRNTCFGREQN_GlitchData : VitalGlitchDataType;
      variable TRNTDSTRDYN_GlitchData : VitalGlitchDataType;
      variable TRNTERRDROPN_GlitchData : VitalGlitchDataType;
      variable USERRSTN_GlitchData : VitalGlitchDataType;
      begin
        VitalPathDelay01
        (
          OutSignal     => CFGCOMMANDBUSMASTERENABLE,
          GlitchData    => CFGCOMMANDBUSMASTERENABLE_GlitchData,
          OutSignalName => "CFGCOMMANDBUSMASTERENABLE",
          OutTemp       => CFGCOMMANDBUSMASTERENABLE_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGCOMMANDBUSMASTERENABLE,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGCOMMANDINTERRUPTDISABLE,
          GlitchData    => CFGCOMMANDINTERRUPTDISABLE_GlitchData,
          OutSignalName => "CFGCOMMANDINTERRUPTDISABLE",
          OutTemp       => CFGCOMMANDINTERRUPTDISABLE_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGCOMMANDINTERRUPTDISABLE,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGCOMMANDIOENABLE,
          GlitchData    => CFGCOMMANDIOENABLE_GlitchData,
          OutSignalName => "CFGCOMMANDIOENABLE",
          OutTemp       => CFGCOMMANDIOENABLE_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGCOMMANDIOENABLE,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGCOMMANDMEMENABLE,
          GlitchData    => CFGCOMMANDMEMENABLE_GlitchData,
          OutSignalName => "CFGCOMMANDMEMENABLE",
          OutTemp       => CFGCOMMANDMEMENABLE_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGCOMMANDMEMENABLE,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGCOMMANDSERREN,
          GlitchData    => CFGCOMMANDSERREN_GlitchData,
          OutSignalName => "CFGCOMMANDSERREN",
          OutTemp       => CFGCOMMANDSERREN_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGCOMMANDSERREN,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDEVCONTROLAUXPOWEREN,
          GlitchData    => CFGDEVCONTROLAUXPOWEREN_GlitchData,
          OutSignalName => "CFGDEVCONTROLAUXPOWEREN",
          OutTemp       => CFGDEVCONTROLAUXPOWEREN_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDEVCONTROLAUXPOWEREN,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDEVCONTROLCORRERRREPORTINGEN,
          GlitchData    => CFGDEVCONTROLCORRERRREPORTINGEN_GlitchData,
          OutSignalName => "CFGDEVCONTROLCORRERRREPORTINGEN",
          OutTemp       => CFGDEVCONTROLCORRERRREPORTINGEN_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDEVCONTROLCORRERRREPORTINGEN,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDEVCONTROLENABLERO,
          GlitchData    => CFGDEVCONTROLENABLERO_GlitchData,
          OutSignalName => "CFGDEVCONTROLENABLERO",
          OutTemp       => CFGDEVCONTROLENABLERO_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDEVCONTROLENABLERO,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDEVCONTROLEXTTAGEN,
          GlitchData    => CFGDEVCONTROLEXTTAGEN_GlitchData,
          OutSignalName => "CFGDEVCONTROLEXTTAGEN",
          OutTemp       => CFGDEVCONTROLEXTTAGEN_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDEVCONTROLEXTTAGEN,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDEVCONTROLFATALERRREPORTINGEN,
          GlitchData    => CFGDEVCONTROLFATALERRREPORTINGEN_GlitchData,
          OutSignalName => "CFGDEVCONTROLFATALERRREPORTINGEN",
          OutTemp       => CFGDEVCONTROLFATALERRREPORTINGEN_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDEVCONTROLFATALERRREPORTINGEN,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDEVCONTROLNONFATALREPORTINGEN,
          GlitchData    => CFGDEVCONTROLNONFATALREPORTINGEN_GlitchData,
          OutSignalName => "CFGDEVCONTROLNONFATALREPORTINGEN",
          OutTemp       => CFGDEVCONTROLNONFATALREPORTINGEN_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDEVCONTROLNONFATALREPORTINGEN,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDEVCONTROLNOSNOOPEN,
          GlitchData    => CFGDEVCONTROLNOSNOOPEN_GlitchData,
          OutSignalName => "CFGDEVCONTROLNOSNOOPEN",
          OutTemp       => CFGDEVCONTROLNOSNOOPEN_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDEVCONTROLNOSNOOPEN,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDEVCONTROLPHANTOMEN,
          GlitchData    => CFGDEVCONTROLPHANTOMEN_GlitchData,
          OutSignalName => "CFGDEVCONTROLPHANTOMEN",
          OutTemp       => CFGDEVCONTROLPHANTOMEN_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDEVCONTROLPHANTOMEN,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDEVCONTROLURERRREPORTINGEN,
          GlitchData    => CFGDEVCONTROLURERRREPORTINGEN_GlitchData,
          OutSignalName => "CFGDEVCONTROLURERRREPORTINGEN",
          OutTemp       => CFGDEVCONTROLURERRREPORTINGEN_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDEVCONTROLURERRREPORTINGEN,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDEVSTATUSCORRERRDETECTED,
          GlitchData    => CFGDEVSTATUSCORRERRDETECTED_GlitchData,
          OutSignalName => "CFGDEVSTATUSCORRERRDETECTED",
          OutTemp       => CFGDEVSTATUSCORRERRDETECTED_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDEVSTATUSCORRERRDETECTED,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDEVSTATUSFATALERRDETECTED,
          GlitchData    => CFGDEVSTATUSFATALERRDETECTED_GlitchData,
          OutSignalName => "CFGDEVSTATUSFATALERRDETECTED",
          OutTemp       => CFGDEVSTATUSFATALERRDETECTED_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDEVSTATUSFATALERRDETECTED,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDEVSTATUSNONFATALERRDETECTED,
          GlitchData    => CFGDEVSTATUSNONFATALERRDETECTED_GlitchData,
          OutSignalName => "CFGDEVSTATUSNONFATALERRDETECTED",
          OutTemp       => CFGDEVSTATUSNONFATALERRDETECTED_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDEVSTATUSNONFATALERRDETECTED,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGDEVSTATUSURDETECTED,
          GlitchData    => CFGDEVSTATUSURDETECTED_GlitchData,
          OutSignalName => "CFGDEVSTATUSURDETECTED",
          OutTemp       => CFGDEVSTATUSURDETECTED_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGDEVSTATUSURDETECTED,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGERRCPLRDYN,
          GlitchData    => CFGERRCPLRDYN_GlitchData,
          OutSignalName => "CFGERRCPLRDYN",
          OutTemp       => CFGERRCPLRDYN_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGERRCPLRDYN,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGINTERRUPTMSIENABLE,
          GlitchData    => CFGINTERRUPTMSIENABLE_GlitchData,
          OutSignalName => "CFGINTERRUPTMSIENABLE",
          OutTemp       => CFGINTERRUPTMSIENABLE_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGINTERRUPTMSIENABLE,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGINTERRUPTRDYN,
          GlitchData    => CFGINTERRUPTRDYN_GlitchData,
          OutSignalName => "CFGINTERRUPTRDYN",
          OutTemp       => CFGINTERRUPTRDYN_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGINTERRUPTRDYN,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGLINKCONTOLRCB,
          GlitchData    => CFGLINKCONTOLRCB_GlitchData,
          OutSignalName => "CFGLINKCONTOLRCB",
          OutTemp       => CFGLINKCONTOLRCB_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGLINKCONTOLRCB,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGLINKCONTROLCOMMONCLOCK,
          GlitchData    => CFGLINKCONTROLCOMMONCLOCK_GlitchData,
          OutSignalName => "CFGLINKCONTROLCOMMONCLOCK",
          OutTemp       => CFGLINKCONTROLCOMMONCLOCK_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGLINKCONTROLCOMMONCLOCK,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGLINKCONTROLEXTENDEDSYNC,
          GlitchData    => CFGLINKCONTROLEXTENDEDSYNC_GlitchData,
          OutSignalName => "CFGLINKCONTROLEXTENDEDSYNC",
          OutTemp       => CFGLINKCONTROLEXTENDEDSYNC_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGLINKCONTROLEXTENDEDSYNC,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGRDWRDONEN,
          GlitchData    => CFGRDWRDONEN_GlitchData,
          OutSignalName => "CFGRDWRDONEN",
          OutTemp       => CFGRDWRDONEN_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGRDWRDONEN,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => CFGTOTURNOFFN,
          GlitchData    => CFGTOTURNOFFN_GlitchData,
          OutSignalName => "CFGTOTURNOFFN",
          OutTemp       => CFGTOTURNOFFN_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_CFGTOTURNOFFN,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => DBGBADDLLPSTATUS,
          GlitchData    => DBGBADDLLPSTATUS_GlitchData,
          OutSignalName => "DBGBADDLLPSTATUS",
          OutTemp       => DBGBADDLLPSTATUS_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_DBGBADDLLPSTATUS,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => DBGBADTLPLCRC,
          GlitchData    => DBGBADTLPLCRC_GlitchData,
          OutSignalName => "DBGBADTLPLCRC",
          OutTemp       => DBGBADTLPLCRC_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_DBGBADTLPLCRC,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => DBGBADTLPSEQNUM,
          GlitchData    => DBGBADTLPSEQNUM_GlitchData,
          OutSignalName => "DBGBADTLPSEQNUM",
          OutTemp       => DBGBADTLPSEQNUM_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_DBGBADTLPSEQNUM,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => DBGBADTLPSTATUS,
          GlitchData    => DBGBADTLPSTATUS_GlitchData,
          OutSignalName => "DBGBADTLPSTATUS",
          OutTemp       => DBGBADTLPSTATUS_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_DBGBADTLPSTATUS,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => DBGDLPROTOCOLSTATUS,
          GlitchData    => DBGDLPROTOCOLSTATUS_GlitchData,
          OutSignalName => "DBGDLPROTOCOLSTATUS",
          OutTemp       => DBGDLPROTOCOLSTATUS_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_DBGDLPROTOCOLSTATUS,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => DBGFCPROTOCOLERRSTATUS,
          GlitchData    => DBGFCPROTOCOLERRSTATUS_GlitchData,
          OutSignalName => "DBGFCPROTOCOLERRSTATUS",
          OutTemp       => DBGFCPROTOCOLERRSTATUS_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_DBGFCPROTOCOLERRSTATUS,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => DBGMLFRMDLENGTH,
          GlitchData    => DBGMLFRMDLENGTH_GlitchData,
          OutSignalName => "DBGMLFRMDLENGTH",
          OutTemp       => DBGMLFRMDLENGTH_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_DBGMLFRMDLENGTH,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => DBGMLFRMDMPS,
          GlitchData    => DBGMLFRMDMPS_GlitchData,
          OutSignalName => "DBGMLFRMDMPS",
          OutTemp       => DBGMLFRMDMPS_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_DBGMLFRMDMPS,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => DBGMLFRMDTCVC,
          GlitchData    => DBGMLFRMDTCVC_GlitchData,
          OutSignalName => "DBGMLFRMDTCVC",
          OutTemp       => DBGMLFRMDTCVC_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_DBGMLFRMDTCVC,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => DBGMLFRMDTLPSTATUS,
          GlitchData    => DBGMLFRMDTLPSTATUS_GlitchData,
          OutSignalName => "DBGMLFRMDTLPSTATUS",
          OutTemp       => DBGMLFRMDTLPSTATUS_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_DBGMLFRMDTLPSTATUS,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => DBGMLFRMDUNRECTYPE,
          GlitchData    => DBGMLFRMDUNRECTYPE_GlitchData,
          OutSignalName => "DBGMLFRMDUNRECTYPE",
          OutTemp       => DBGMLFRMDUNRECTYPE_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_DBGMLFRMDUNRECTYPE,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => DBGPOISTLPSTATUS,
          GlitchData    => DBGPOISTLPSTATUS_GlitchData,
          OutSignalName => "DBGPOISTLPSTATUS",
          OutTemp       => DBGPOISTLPSTATUS_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_DBGPOISTLPSTATUS,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => DBGRCVROVERFLOWSTATUS,
          GlitchData    => DBGRCVROVERFLOWSTATUS_GlitchData,
          OutSignalName => "DBGRCVROVERFLOWSTATUS",
          OutTemp       => DBGRCVROVERFLOWSTATUS_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_DBGRCVROVERFLOWSTATUS,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => DBGREGDETECTEDCORRECTABLE,
          GlitchData    => DBGREGDETECTEDCORRECTABLE_GlitchData,
          OutSignalName => "DBGREGDETECTEDCORRECTABLE",
          OutTemp       => DBGREGDETECTEDCORRECTABLE_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_DBGREGDETECTEDCORRECTABLE,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => DBGREGDETECTEDFATAL,
          GlitchData    => DBGREGDETECTEDFATAL_GlitchData,
          OutSignalName => "DBGREGDETECTEDFATAL",
          OutTemp       => DBGREGDETECTEDFATAL_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_DBGREGDETECTEDFATAL,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => DBGREGDETECTEDNONFATAL,
          GlitchData    => DBGREGDETECTEDNONFATAL_GlitchData,
          OutSignalName => "DBGREGDETECTEDNONFATAL",
          OutTemp       => DBGREGDETECTEDNONFATAL_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_DBGREGDETECTEDNONFATAL,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => DBGREGDETECTEDUNSUPPORTED,
          GlitchData    => DBGREGDETECTEDUNSUPPORTED_GlitchData,
          OutSignalName => "DBGREGDETECTEDUNSUPPORTED",
          OutTemp       => DBGREGDETECTEDUNSUPPORTED_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_DBGREGDETECTEDUNSUPPORTED,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => DBGRPLYROLLOVERSTATUS,
          GlitchData    => DBGRPLYROLLOVERSTATUS_GlitchData,
          OutSignalName => "DBGRPLYROLLOVERSTATUS",
          OutTemp       => DBGRPLYROLLOVERSTATUS_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_DBGRPLYROLLOVERSTATUS,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => DBGRPLYTIMEOUTSTATUS,
          GlitchData    => DBGRPLYTIMEOUTSTATUS_GlitchData,
          OutSignalName => "DBGRPLYTIMEOUTSTATUS",
          OutTemp       => DBGRPLYTIMEOUTSTATUS_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_DBGRPLYTIMEOUTSTATUS,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => DBGURNOBARHIT,
          GlitchData    => DBGURNOBARHIT_GlitchData,
          OutSignalName => "DBGURNOBARHIT",
          OutTemp       => DBGURNOBARHIT_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_DBGURNOBARHIT,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => DBGURPOISCFGWR,
          GlitchData    => DBGURPOISCFGWR_GlitchData,
          OutSignalName => "DBGURPOISCFGWR",
          OutTemp       => DBGURPOISCFGWR_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_DBGURPOISCFGWR,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => DBGURSTATUS,
          GlitchData    => DBGURSTATUS_GlitchData,
          OutSignalName => "DBGURSTATUS",
          OutTemp       => DBGURSTATUS_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_DBGURSTATUS,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => DBGURUNSUPMSG,
          GlitchData    => DBGURUNSUPMSG_GlitchData,
          OutSignalName => "DBGURUNSUPMSG",
          OutTemp       => DBGURUNSUPMSG_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_DBGURUNSUPMSG,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXREN,
          GlitchData    => MIMRXREN_GlitchData,
          OutSignalName => "MIMRXREN",
          OutTemp       => MIMRXREN_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXREN,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMRXWEN,
          GlitchData    => MIMRXWEN_GlitchData,
          OutSignalName => "MIMRXWEN",
          OutTemp       => MIMRXWEN_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMRXWEN,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXREN,
          GlitchData    => MIMTXREN_GlitchData,
          OutSignalName => "MIMTXREN",
          OutTemp       => MIMTXREN_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXREN,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => MIMTXWEN,
          GlitchData    => MIMTXWEN_GlitchData,
          OutSignalName => "MIMTXWEN",
          OutTemp       => MIMTXWEN_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_MIMTXWEN,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPEGTTXELECIDLEA,
          GlitchData    => PIPEGTTXELECIDLEA_GlitchData,
          OutSignalName => "PIPEGTTXELECIDLEA",
          OutTemp       => PIPEGTTXELECIDLEA_out,
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPEGTTXELECIDLEA,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPEGTTXELECIDLEB,
          GlitchData    => PIPEGTTXELECIDLEB_GlitchData,
          OutSignalName => "PIPEGTTXELECIDLEB",
          OutTemp       => PIPEGTTXELECIDLEB_out,
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPEGTTXELECIDLEB,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPERXPOLARITYA,
          GlitchData    => PIPERXPOLARITYA_GlitchData,
          OutSignalName => "PIPERXPOLARITYA",
          OutTemp       => PIPERXPOLARITYA_out,
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPERXPOLARITYA,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPERXPOLARITYB,
          GlitchData    => PIPERXPOLARITYB_GlitchData,
          OutSignalName => "PIPERXPOLARITYB",
          OutTemp       => PIPERXPOLARITYB_out,
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPERXPOLARITYB,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPERXRESETA,
          GlitchData    => PIPERXRESETA_GlitchData,
          OutSignalName => "PIPERXRESETA",
          OutTemp       => PIPERXRESETA_out,
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPERXRESETA,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPERXRESETB,
          GlitchData    => PIPERXRESETB_GlitchData,
          OutSignalName => "PIPERXRESETB",
          OutTemp       => PIPERXRESETB_out,
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPERXRESETB,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXRCVRDETA,
          GlitchData    => PIPETXRCVRDETA_GlitchData,
          OutSignalName => "PIPETXRCVRDETA",
          OutTemp       => PIPETXRCVRDETA_out,
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXRCVRDETA,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => PIPETXRCVRDETB,
          GlitchData    => PIPETXRCVRDETB_GlitchData,
          OutSignalName => "PIPETXRCVRDETB",
          OutTemp       => PIPETXRCVRDETB_out,
          Paths       => (0 => (MGTCLK_dly'last_event, tpd_MGTCLK_PIPETXRCVRDETB,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => RECEIVEDHOTRESET,
          GlitchData    => RECEIVEDHOTRESET_GlitchData,
          OutSignalName => "RECEIVEDHOTRESET",
          OutTemp       => RECEIVEDHOTRESET_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_RECEIVEDHOTRESET,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNLNKUPN,
          GlitchData    => TRNLNKUPN_GlitchData,
          OutSignalName => "TRNLNKUPN",
          OutTemp       => TRNLNKUPN_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNLNKUPN,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNREOFN,
          GlitchData    => TRNREOFN_GlitchData,
          OutSignalName => "TRNREOFN",
          OutTemp       => TRNREOFN_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNREOFN,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRERRFWDN,
          GlitchData    => TRNRERRFWDN_GlitchData,
          OutSignalName => "TRNRERRFWDN",
          OutTemp       => TRNRERRFWDN_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRERRFWDN,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRSOFN,
          GlitchData    => TRNRSOFN_GlitchData,
          OutSignalName => "TRNRSOFN",
          OutTemp       => TRNRSOFN_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRSOFN,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRSRCDSCN,
          GlitchData    => TRNRSRCDSCN_GlitchData,
          OutSignalName => "TRNRSRCDSCN",
          OutTemp       => TRNRSRCDSCN_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRSRCDSCN,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNRSRCRDYN,
          GlitchData    => TRNRSRCRDYN_GlitchData,
          OutSignalName => "TRNRSRCRDYN",
          OutTemp       => TRNRSRCRDYN_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNRSRCRDYN,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNTCFGREQN,
          GlitchData    => TRNTCFGREQN_GlitchData,
          OutSignalName => "TRNTCFGREQN",
          OutTemp       => TRNTCFGREQN_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNTCFGREQN,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNTDSTRDYN,
          GlitchData    => TRNTDSTRDYN_GlitchData,
          OutSignalName => "TRNTDSTRDYN",
          OutTemp       => TRNTDSTRDYN_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNTDSTRDYN,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => TRNTERRDROPN,
          GlitchData    => TRNTERRDROPN_GlitchData,
          OutSignalName => "TRNTERRDROPN",
          OutTemp       => TRNTERRDROPN_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_TRNTERRDROPN,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => USERRSTN,
          GlitchData    => USERRSTN_GlitchData,
          OutSignalName => "USERRSTN",
          OutTemp       => USERRSTN_out,
          Paths       => (0 => (USERCLK_dly'last_event, tpd_USERCLK_USERRSTN,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
      wait on
        CFGCOMMANDBUSMASTERENABLE_out,
        CFGCOMMANDINTERRUPTDISABLE_out,
        CFGCOMMANDIOENABLE_out,
        CFGCOMMANDMEMENABLE_out,
        CFGCOMMANDSERREN_out,
        CFGDEVCONTROLAUXPOWEREN_out,
        CFGDEVCONTROLCORRERRREPORTINGEN_out,
        CFGDEVCONTROLENABLERO_out,
        CFGDEVCONTROLEXTTAGEN_out,
        CFGDEVCONTROLFATALERRREPORTINGEN_out,
        CFGDEVCONTROLNONFATALREPORTINGEN_out,
        CFGDEVCONTROLNOSNOOPEN_out,
        CFGDEVCONTROLPHANTOMEN_out,
        CFGDEVCONTROLURERRREPORTINGEN_out,
        CFGDEVSTATUSCORRERRDETECTED_out,
        CFGDEVSTATUSFATALERRDETECTED_out,
        CFGDEVSTATUSNONFATALERRDETECTED_out,
        CFGDEVSTATUSURDETECTED_out,
        CFGERRCPLRDYN_out,
        CFGINTERRUPTMSIENABLE_out,
        CFGINTERRUPTRDYN_out,
        CFGLINKCONTOLRCB_out,
        CFGLINKCONTROLCOMMONCLOCK_out,
        CFGLINKCONTROLEXTENDEDSYNC_out,
        CFGRDWRDONEN_out,
        CFGTOTURNOFFN_out,
        DBGBADDLLPSTATUS_out,
        DBGBADTLPLCRC_out,
        DBGBADTLPSEQNUM_out,
        DBGBADTLPSTATUS_out,
        DBGDLPROTOCOLSTATUS_out,
        DBGFCPROTOCOLERRSTATUS_out,
        DBGMLFRMDLENGTH_out,
        DBGMLFRMDMPS_out,
        DBGMLFRMDTCVC_out,
        DBGMLFRMDTLPSTATUS_out,
        DBGMLFRMDUNRECTYPE_out,
        DBGPOISTLPSTATUS_out,
        DBGRCVROVERFLOWSTATUS_out,
        DBGREGDETECTEDCORRECTABLE_out,
        DBGREGDETECTEDFATAL_out,
        DBGREGDETECTEDNONFATAL_out,
        DBGREGDETECTEDUNSUPPORTED_out,
        DBGRPLYROLLOVERSTATUS_out,
        DBGRPLYTIMEOUTSTATUS_out,
        DBGURNOBARHIT_out,
        DBGURPOISCFGWR_out,
        DBGURSTATUS_out,
        DBGURUNSUPMSG_out,
        MIMRXREN_out,
        MIMRXWEN_out,
        MIMTXREN_out,
        MIMTXWEN_out,
        PIPEGTTXELECIDLEA_out,
        PIPEGTTXELECIDLEB_out,
        PIPERXPOLARITYA_out,
        PIPERXPOLARITYB_out,
        PIPERXRESETA_out,
        PIPERXRESETB_out,
        PIPETXRCVRDETA_out,
        PIPETXRCVRDETB_out,
        RECEIVEDHOTRESET_out,
        TRNLNKUPN_out,
        TRNREOFN_out,
        TRNRERRFWDN_out,
        TRNRSOFN_out,
        TRNRSRCDSCN_out,
        TRNRSRCRDYN_out,
        TRNTCFGREQN_out,
        TRNTDSTRDYN_out,
        TRNTERRDROPN_out,
        USERRSTN_out;
    end process TIMING_PD;


    Period_Check : process
      variable Pviol_MGTCLK : STD_ULOGIC := '0';
      variable Pviol_USERCLK : STD_ULOGIC := '0';
      variable PInfo_MGTCLK : VitalPeriodDataType := VitalPeriodDataInit;
      variable PInfo_USERCLK : VitalPeriodDataType := VitalPeriodDataInit;
    begin
        VitalPeriodPulseCheck
        (
          Violation      => Pviol_MGTCLK,
          PeriodData     => PInfo_MGTCLK,
          TestSignal     => MGTCLK_dly,
          TestSignalName => "MGTCLK",
          TestDelay      => 0 ps,
          Period         => tperiod_MGTCLK_posedge,
          PulseWidthHigh => 0 ps,
          PulseWidthLow  => 0 ps,
          CheckEnabled   => TRUE,
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalPeriodPulseCheck
        (
          Violation      => Pviol_USERCLK,
          PeriodData     => PInfo_USERCLK,
          TestSignal     => USERCLK_dly,
          TestSignalName => "USERCLK",
          TestDelay      => 0 ps,
          Period         => tperiod_USERCLK_posedge,
          PulseWidthHigh => 0 ps,
          PulseWidthLow  => 0 ps,
          CheckEnabled   => TRUE,
          HeaderMsg      => InstancePath & "/X_PCIE_A1",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
      wait on USERCLK_dly, MGTCLK_dly;
    end process Period_Check;

  end X_PCIE_A1_V;

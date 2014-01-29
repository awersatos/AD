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
--  /   /                      : Tri-Mode Ethernet MAC
-- /___/   /\      Filename    : temac_single.vhd
-- \   \  /  \     
--  \__ \/\__ \                   
--                                 
--  Revision: 1.0
--  11/05/07 - - CR453443 - Initial version.
--  05/30/08 - CR1014 - Added parameter
--  06/06/08 - CR1014 - added component instantiation
--  08/05/08 - CR1014 - yml updates - EMAC_MDIO_IGNORE_PHYADZERO string to boolean, EMAC_DCRBASEADDR updated from [7:0] to [0:7]
--  10/24/08 - CR493615 - Add timing section
--  11/11/08 - CR493972 - Add SIM_VERSION
--  11/17/08 - CR496607 - convert bit_vector to string for VHDL simulation
--  04/03/09 - CR515882 - Fix for 16 bit client mode
--  09/01/09 - CR532335 - Delay YML update, specify block update
-------------------------------------------------------

----- CELL X_TEMAC_SINGLE -----

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

  entity X_TEMAC_SINGLE is
    generic (
      TimingChecksOn : boolean := TRUE;
      InstancePath   : string  := "*";
      Xon            : boolean := TRUE;
      MsgOn          : boolean := FALSE;
      LOC            : string  := "UNPLACED";
      EMAC_1000BASEX_ENABLE : boolean := FALSE;
      EMAC_ADDRFILTER_ENABLE : boolean := FALSE;
      EMAC_BYTEPHY : boolean := FALSE;
      EMAC_CTRLLENCHECK_DISABLE : boolean := FALSE;
      EMAC_DCRBASEADDR : bit_vector := X"00";
      EMAC_GTLOOPBACK : boolean := FALSE;
      EMAC_HOST_ENABLE : boolean := FALSE;
      EMAC_LINKTIMERVAL : bit_vector := X"000";
      EMAC_LTCHECK_DISABLE : boolean := FALSE;
      EMAC_MDIO_ENABLE : boolean := FALSE;
      EMAC_MDIO_IGNORE_PHYADZERO : boolean := FALSE;
      EMAC_PAUSEADDR : bit_vector := X"000000000000";
      EMAC_PHYINITAUTONEG_ENABLE : boolean := FALSE;
      EMAC_PHYISOLATE : boolean := FALSE;
      EMAC_PHYLOOPBACKMSB : boolean := FALSE;
      EMAC_PHYPOWERDOWN : boolean := FALSE;
      EMAC_PHYRESET : boolean := FALSE;
      EMAC_RGMII_ENABLE : boolean := FALSE;
      EMAC_RX16BITCLIENT_ENABLE : boolean := FALSE;
      EMAC_RXFLOWCTRL_ENABLE : boolean := FALSE;
      EMAC_RXHALFDUPLEX : boolean := FALSE;
      EMAC_RXINBANDFCS_ENABLE : boolean := FALSE;
      EMAC_RXJUMBOFRAME_ENABLE : boolean := FALSE;
      EMAC_RXRESET : boolean := FALSE;
      EMAC_RXVLAN_ENABLE : boolean := FALSE;
      EMAC_RX_ENABLE : boolean := TRUE;
      EMAC_SGMII_ENABLE : boolean := FALSE;
      EMAC_SPEED_LSB : boolean := FALSE;
      EMAC_SPEED_MSB : boolean := FALSE;
      EMAC_TX16BITCLIENT_ENABLE : boolean := FALSE;
      EMAC_TXFLOWCTRL_ENABLE : boolean := FALSE;
      EMAC_TXHALFDUPLEX : boolean := FALSE;
      EMAC_TXIFGADJUST_ENABLE : boolean := FALSE;
      EMAC_TXINBANDFCS_ENABLE : boolean := FALSE;
      EMAC_TXJUMBOFRAME_ENABLE : boolean := FALSE;
      EMAC_TXRESET : boolean := FALSE;
      EMAC_TXVLAN_ENABLE : boolean := FALSE;
      EMAC_TX_ENABLE : boolean := TRUE;
      EMAC_UNICASTADDR : bit_vector := X"000000000000";
      EMAC_UNIDIRECTION_ENABLE : boolean := FALSE;
      EMAC_USECLKEN : boolean := FALSE;
      SIM_VERSION : string := "1.0";
      tipd_CLIENTEMACDCMLOCKED : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_CLIENTEMACPAUSEREQ : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_CLIENTEMACPAUSEVAL : VitalDelayArrayType01 (15 downto 0) := (others => (0 ps, 0 ps));
      tipd_CLIENTEMACRXCLIENTCLKIN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_CLIENTEMACTXCLIENTCLKIN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_CLIENTEMACTXD : VitalDelayArrayType01 (15 downto 0) := (others => (0 ps, 0 ps));
      tipd_CLIENTEMACTXDVLD : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_CLIENTEMACTXDVLDMSW : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_CLIENTEMACTXFIRSTBYTE : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_CLIENTEMACTXIFGDELAY : VitalDelayArrayType01 (7 downto 0) := (others => (0 ps, 0 ps));
      tipd_CLIENTEMACTXUNDERRUN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_DCREMACABUS : VitalDelayArrayType01 (0 to 9) := (others => (0 ps, 0 ps));
      tipd_DCREMACCLK : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_DCREMACDBUS : VitalDelayArrayType01 (0 to 31) := (others => (0 ps, 0 ps));
      tipd_DCREMACENABLE : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_DCREMACREAD : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_DCREMACWRITE : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_HOSTADDR : VitalDelayArrayType01 (9 downto 0) := (others => (0 ps, 0 ps));
      tipd_HOSTCLK : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_HOSTMIIMSEL : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_HOSTOPCODE : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_HOSTREQ : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_HOSTWRDATA : VitalDelayArrayType01 (31 downto 0) := (others => (0 ps, 0 ps));
      tipd_PHYEMACCOL : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PHYEMACCRS : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PHYEMACGTXCLK : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PHYEMACMCLKIN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PHYEMACMDIN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PHYEMACMIITXCLK : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PHYEMACPHYAD : VitalDelayArrayType01 (4 downto 0) := (others => (0 ps, 0 ps));
      tipd_PHYEMACRXBUFSTATUS : VitalDelayArrayType01 (1 downto 0) := (others => (0 ps, 0 ps));
      tipd_PHYEMACRXCHARISCOMMA : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PHYEMACRXCHARISK : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PHYEMACRXCLK : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PHYEMACRXCLKCORCNT : VitalDelayArrayType01 (2 downto 0) := (others => (0 ps, 0 ps));
      tipd_PHYEMACRXD : VitalDelayArrayType01 (7 downto 0) := (others => (0 ps, 0 ps));
      tipd_PHYEMACRXDISPERR : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PHYEMACRXDV : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PHYEMACRXER : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PHYEMACRXNOTINTABLE : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PHYEMACRXRUNDISP : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PHYEMACSIGNALDET : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PHYEMACTXBUFERR : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_PHYEMACTXGMIIMIICLKIN : VitalDelayType01 :=  (0 ps, 0 ps);
      tipd_RESET : VitalDelayType01 :=  (0 ps, 0 ps);
      tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXBADFRAME : VitalDelayType01 := (0 ps, 0 ps);
      tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXCLIENTCLKOUT : VitalDelayType01 := (0 ps, 0 ps);
      tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXD : VitalDelayArrayType01(15 downto 0) := (others => (0 ps, 0 ps));
      tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXDVLD : VitalDelayType01 := (0 ps, 0 ps);
      tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXDVLDMSW : VitalDelayType01 := (0 ps, 0 ps);
      tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXFRAMEDROP : VitalDelayType01 := (0 ps, 0 ps);
      tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXGOODFRAME : VitalDelayType01 := (0 ps, 0 ps);
      tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXSTATS : VitalDelayArrayType01(6 downto 0) := (others => (0 ps, 0 ps));
      tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXSTATSBYTEVLD : VitalDelayType01 := (0 ps, 0 ps);
      tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXSTATSVLD : VitalDelayType01 := (0 ps, 0 ps);
      tpd_CLIENTEMACTXCLIENTCLKIN_EMACCLIENTTXACK : VitalDelayType01 := (0 ps, 0 ps);
      tpd_CLIENTEMACTXCLIENTCLKIN_EMACCLIENTTXCOLLISION : VitalDelayType01 := (0 ps, 0 ps);
      tpd_CLIENTEMACTXCLIENTCLKIN_EMACCLIENTTXRETRANSMIT : VitalDelayType01 := (0 ps, 0 ps);
      tpd_CLIENTEMACTXCLIENTCLKIN_EMACCLIENTTXSTATS : VitalDelayType01 := (0 ps, 0 ps);
      tpd_CLIENTEMACTXCLIENTCLKIN_EMACCLIENTTXSTATSBYTEVLD : VitalDelayType01 := (0 ps, 0 ps);
      tpd_CLIENTEMACTXCLIENTCLKIN_EMACCLIENTTXSTATSVLD : VitalDelayType01 := (0 ps, 0 ps);
      tpd_DCREMACCLK_DCRHOSTDONEIR : VitalDelayType01 := (0 ps, 0 ps);
      tpd_DCREMACCLK_EMACDCRACK : VitalDelayType01 := (0 ps, 0 ps);
      tpd_DCREMACCLK_EMACDCRDBUS : VitalDelayArrayType01(0 to 31) := (others => (0 ps, 0 ps));
      tpd_HOSTCLK_EMACPHYMCLKOUT : VitalDelayType01 := (0 ps, 0 ps);
      tpd_HOSTCLK_EMACPHYMDOUT : VitalDelayType01 := (0 ps, 0 ps);
      tpd_HOSTCLK_EMACPHYMDTRI : VitalDelayType01 := (0 ps, 0 ps);
      tpd_HOSTCLK_EMACSPEEDIS10100 : VitalDelayType01 := (0 ps, 0 ps);
      tpd_HOSTCLK_HOSTMIIMRDY : VitalDelayType01 := (0 ps, 0 ps);
      tpd_HOSTCLK_HOSTRDDATA : VitalDelayArrayType01(31 downto 0) := (others => (0 ps, 0 ps));
      tpd_PHYEMACGTXCLK_EMACCLIENTANINTERRUPT : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACGTXCLK_EMACCLIENTRXCLIENTCLKOUT : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACGTXCLK_EMACCLIENTTXCLIENTCLKOUT : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACGTXCLK_EMACPHYENCOMMAALIGN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACGTXCLK_EMACPHYLOOPBACKMSB : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACGTXCLK_EMACPHYMGTRXRESET : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACGTXCLK_EMACPHYMGTTXRESET : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACGTXCLK_EMACPHYPOWERDOWN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACGTXCLK_EMACPHYSYNCACQSTATUS : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACGTXCLK_EMACPHYTXCHARDISPMODE : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACGTXCLK_EMACPHYTXCHARDISPVAL : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACGTXCLK_EMACPHYTXCHARISK : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACGTXCLK_EMACPHYTXCLK : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACGTXCLK_EMACPHYTXD : VitalDelayArrayType01(7 downto 0) := (others => (0 ps, 0 ps));
      tpd_PHYEMACGTXCLK_EMACPHYTXEN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACGTXCLK_EMACPHYTXER : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACGTXCLK_EMACPHYTXGMIIMIICLKOUT : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACMCLKIN_EMACPHYMCLKOUT : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACMCLKIN_EMACPHYMDOUT : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACMCLKIN_EMACPHYMDTRI : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACMIITXCLK_EMACCLIENTRXBADFRAME : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACMIITXCLK_EMACCLIENTRXCLIENTCLKOUT : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACMIITXCLK_EMACCLIENTRXD : VitalDelayArrayType01(15 downto 0) := (others => (0 ps, 0 ps));
      tpd_PHYEMACMIITXCLK_EMACCLIENTRXDVLD : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACMIITXCLK_EMACCLIENTRXDVLDMSW : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACMIITXCLK_EMACCLIENTRXFRAMEDROP : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACMIITXCLK_EMACCLIENTRXGOODFRAME : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACMIITXCLK_EMACCLIENTTXACK : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACMIITXCLK_EMACCLIENTTXCLIENTCLKOUT : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACMIITXCLK_EMACCLIENTTXCOLLISION : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACMIITXCLK_EMACCLIENTTXRETRANSMIT : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACMIITXCLK_EMACPHYTXGMIIMIICLKOUT : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACRXCLK_EMACCLIENTRXBADFRAME : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACRXCLK_EMACCLIENTRXCLIENTCLKOUT : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACRXCLK_EMACCLIENTRXD : VitalDelayArrayType01(15 downto 0) := (others => (0 ps, 0 ps));
      tpd_PHYEMACRXCLK_EMACCLIENTRXDVLD : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACRXCLK_EMACCLIENTRXDVLDMSW : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACRXCLK_EMACCLIENTRXFRAMEDROP : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACRXCLK_EMACCLIENTRXGOODFRAME : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACRXCLK_EMACCLIENTRXSTATS : VitalDelayArrayType01(6 downto 0) := (others => (0 ps, 0 ps));
      tpd_PHYEMACRXCLK_EMACCLIENTRXSTATSBYTEVLD : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACRXCLK_EMACCLIENTRXSTATSVLD : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACTXGMIIMIICLKIN_EMACCLIENTTXACK : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACTXGMIIMIICLKIN_EMACCLIENTTXCLIENTCLKOUT : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACTXGMIIMIICLKIN_EMACCLIENTTXCOLLISION : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACTXGMIIMIICLKIN_EMACCLIENTTXRETRANSMIT : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACTXGMIIMIICLKIN_EMACCLIENTTXSTATS : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACTXGMIIMIICLKIN_EMACCLIENTTXSTATSBYTEVLD : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACTXGMIIMIICLKIN_EMACCLIENTTXSTATSVLD : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACTXGMIIMIICLKIN_EMACPHYSYNCACQSTATUS : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACTXGMIIMIICLKIN_EMACPHYTXCHARDISPMODE : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACTXGMIIMIICLKIN_EMACPHYTXCHARDISPVAL : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACTXGMIIMIICLKIN_EMACPHYTXCHARISK : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACTXGMIIMIICLKIN_EMACPHYTXCLK : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACTXGMIIMIICLKIN_EMACPHYTXD : VitalDelayArrayType01(7 downto 0) := (others => (0 ps, 0 ps));
      tpd_PHYEMACTXGMIIMIICLKIN_EMACPHYTXEN : VitalDelayType01 := (0 ps, 0 ps);
      tpd_PHYEMACTXGMIIMIICLKIN_EMACPHYTXER : VitalDelayType01 := (0 ps, 0 ps);
      trecovery_RESET_CLIENTEMACTXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0 ps;
      trecovery_RESET_CLIENTEMACTXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0 ps;
      trecovery_RESET_HOSTCLK_negedge_posedge : VitalDelayType := 0 ps;
      trecovery_RESET_HOSTCLK_posedge_posedge : VitalDelayType := 0 ps;
      trecovery_RESET_PHYEMACGTXCLK_negedge_posedge : VitalDelayType := 0 ps;
      trecovery_RESET_PHYEMACGTXCLK_posedge_posedge : VitalDelayType := 0 ps;
      trecovery_RESET_PHYEMACMIITXCLK_negedge_posedge : VitalDelayType := 0 ps;
      trecovery_RESET_PHYEMACMIITXCLK_posedge_posedge : VitalDelayType := 0 ps;
      trecovery_RESET_PHYEMACTXGMIIMIICLKIN_negedge_posedge : VitalDelayType := 0 ps;
      trecovery_RESET_PHYEMACTXGMIIMIICLKIN_posedge_posedge : VitalDelayType := 0 ps;
      tremoval_RESET_CLIENTEMACTXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0 ps;
      tremoval_RESET_CLIENTEMACTXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0 ps;
      tremoval_RESET_HOSTCLK_negedge_posedge : VitalDelayType := 0 ps;
      tremoval_RESET_HOSTCLK_posedge_posedge : VitalDelayType := 0 ps;
      tremoval_RESET_PHYEMACGTXCLK_negedge_posedge : VitalDelayType := 0 ps;
      tremoval_RESET_PHYEMACGTXCLK_posedge_posedge : VitalDelayType := 0 ps;
      tremoval_RESET_PHYEMACMIITXCLK_negedge_posedge : VitalDelayType := 0 ps;
      tremoval_RESET_PHYEMACMIITXCLK_posedge_posedge : VitalDelayType := 0 ps;
      tremoval_RESET_PHYEMACTXGMIIMIICLKIN_negedge_posedge : VitalDelayType := 0 ps;
      tremoval_RESET_PHYEMACTXGMIIMIICLKIN_posedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACDCMLOCKED_CLIENTEMACTXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACDCMLOCKED_CLIENTEMACTXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACDCMLOCKED_PHYEMACMIITXCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACDCMLOCKED_PHYEMACMIITXCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACDCMLOCKED_PHYEMACTXGMIIMIICLKIN_negedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACDCMLOCKED_PHYEMACTXGMIIMIICLKIN_posedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACPAUSEREQ_CLIENTEMACTXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACPAUSEREQ_CLIENTEMACTXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACPAUSEREQ_PHYEMACMIITXCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACPAUSEREQ_PHYEMACMIITXCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACPAUSEREQ_PHYEMACTXGMIIMIICLKIN_negedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACPAUSEREQ_PHYEMACTXGMIIMIICLKIN_posedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_CLIENTEMACTXDVLDMSW_CLIENTEMACTXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACTXDVLDMSW_CLIENTEMACTXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACTXDVLDMSW_PHYEMACMIITXCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACTXDVLDMSW_PHYEMACMIITXCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACTXDVLDMSW_PHYEMACTXGMIIMIICLKIN_negedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACTXDVLDMSW_PHYEMACTXGMIIMIICLKIN_posedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACTXDVLD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACTXDVLD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACTXDVLD_PHYEMACMIITXCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACTXDVLD_PHYEMACMIITXCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACTXDVLD_PHYEMACTXGMIIMIICLKIN_negedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACTXDVLD_PHYEMACTXGMIIMIICLKIN_posedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      thold_CLIENTEMACTXFIRSTBYTE_CLIENTEMACTXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACTXFIRSTBYTE_CLIENTEMACTXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACTXFIRSTBYTE_PHYEMACMIITXCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACTXFIRSTBYTE_PHYEMACMIITXCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACTXFIRSTBYTE_PHYEMACTXGMIIMIICLKIN_negedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACTXFIRSTBYTE_PHYEMACTXGMIIMIICLKIN_posedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_CLIENTEMACTXUNDERRUN_CLIENTEMACTXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACTXUNDERRUN_CLIENTEMACTXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACTXUNDERRUN_PHYEMACMIITXCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACTXUNDERRUN_PHYEMACMIITXCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACTXUNDERRUN_PHYEMACTXGMIIMIICLKIN_negedge_posedge : VitalDelayType := 0 ps;
      thold_CLIENTEMACTXUNDERRUN_PHYEMACTXGMIIMIICLKIN_posedge_posedge : VitalDelayType := 0 ps;
      thold_DCREMACABUS_DCREMACCLK_negedge_posedge : VitalDelayArrayType(0 to 9) := (others => 0 ps);
      thold_DCREMACABUS_DCREMACCLK_posedge_posedge : VitalDelayArrayType(0 to 9) := (others => 0 ps);
      thold_DCREMACDBUS_DCREMACCLK_negedge_posedge : VitalDelayArrayType(0 to 31) := (others => 0 ps);
      thold_DCREMACDBUS_DCREMACCLK_posedge_posedge : VitalDelayArrayType(0 to 31) := (others => 0 ps);
      thold_DCREMACENABLE_DCREMACCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_DCREMACENABLE_DCREMACCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_DCREMACREAD_DCREMACCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_DCREMACREAD_DCREMACCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_DCREMACWRITE_DCREMACCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_DCREMACWRITE_DCREMACCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_HOSTADDR_HOSTCLK_negedge_posedge : VitalDelayArrayType(9 downto 0) := (others => 0 ps);
      thold_HOSTADDR_HOSTCLK_posedge_posedge : VitalDelayArrayType(9 downto 0) := (others => 0 ps);
      thold_HOSTMIIMSEL_HOSTCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_HOSTMIIMSEL_HOSTCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_HOSTOPCODE_HOSTCLK_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_HOSTOPCODE_HOSTCLK_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_HOSTREQ_HOSTCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_HOSTREQ_HOSTCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_HOSTWRDATA_HOSTCLK_negedge_posedge : VitalDelayArrayType(31 downto 0) := (others => 0 ps);
      thold_HOSTWRDATA_HOSTCLK_posedge_posedge : VitalDelayArrayType(31 downto 0) := (others => 0 ps);
      thold_PHYEMACCOL_PHYEMACGTXCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACCOL_PHYEMACGTXCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACCOL_PHYEMACRXCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACCOL_PHYEMACRXCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACCRS_PHYEMACGTXCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACCRS_PHYEMACGTXCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACCRS_PHYEMACRXCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACCRS_PHYEMACRXCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACMDIN_HOSTCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACMDIN_HOSTCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACMDIN_PHYEMACMCLKIN_negedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACMDIN_PHYEMACMCLKIN_posedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACPHYAD_HOSTCLK_negedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
      thold_PHYEMACPHYAD_HOSTCLK_posedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
      thold_PHYEMACRXBUFSTATUS_PHYEMACGTXCLK_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_PHYEMACRXBUFSTATUS_PHYEMACGTXCLK_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_PHYEMACRXBUFSTATUS_PHYEMACRXCLK_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_PHYEMACRXBUFSTATUS_PHYEMACRXCLK_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      thold_PHYEMACRXCHARISCOMMA_PHYEMACGTXCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACRXCHARISCOMMA_PHYEMACGTXCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACRXCHARISCOMMA_PHYEMACRXCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACRXCHARISCOMMA_PHYEMACRXCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACRXCHARISK_PHYEMACGTXCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACRXCHARISK_PHYEMACGTXCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACRXCHARISK_PHYEMACRXCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACRXCHARISK_PHYEMACRXCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_PHYEMACRXCLKCORCNT_PHYEMACRXCLK_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_PHYEMACRXCLKCORCNT_PHYEMACRXCLK_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      thold_PHYEMACRXDISPERR_PHYEMACGTXCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACRXDISPERR_PHYEMACGTXCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACRXDISPERR_PHYEMACRXCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACRXDISPERR_PHYEMACRXCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACRXDV_PHYEMACGTXCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACRXDV_PHYEMACGTXCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACRXDV_PHYEMACRXCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACRXDV_PHYEMACRXCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACRXD_PHYEMACGTXCLK_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_PHYEMACRXD_PHYEMACGTXCLK_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_PHYEMACRXD_PHYEMACRXCLK_negedge_negedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_PHYEMACRXD_PHYEMACRXCLK_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_PHYEMACRXD_PHYEMACRXCLK_posedge_negedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_PHYEMACRXD_PHYEMACRXCLK_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      thold_PHYEMACRXER_PHYEMACGTXCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACRXER_PHYEMACGTXCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACRXER_PHYEMACRXCLK_negedge_negedge : VitalDelayType := 0 ps;
      thold_PHYEMACRXER_PHYEMACRXCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACRXER_PHYEMACRXCLK_posedge_negedge : VitalDelayType := 0 ps;
      thold_PHYEMACRXER_PHYEMACRXCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACRXNOTINTABLE_PHYEMACGTXCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACRXNOTINTABLE_PHYEMACGTXCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACRXNOTINTABLE_PHYEMACRXCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACRXNOTINTABLE_PHYEMACRXCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACRXRUNDISP_PHYEMACGTXCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACRXRUNDISP_PHYEMACGTXCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACRXRUNDISP_PHYEMACRXCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACRXRUNDISP_PHYEMACRXCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACSIGNALDET_PHYEMACGTXCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACSIGNALDET_PHYEMACGTXCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACSIGNALDET_PHYEMACRXCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACSIGNALDET_PHYEMACRXCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACTXBUFERR_PHYEMACGTXCLK_negedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACTXBUFERR_PHYEMACGTXCLK_posedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACTXBUFERR_PHYEMACTXGMIIMIICLKIN_negedge_posedge : VitalDelayType := 0 ps;
      thold_PHYEMACTXBUFERR_PHYEMACTXGMIIMIICLKIN_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACDCMLOCKED_CLIENTEMACTXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACDCMLOCKED_CLIENTEMACTXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACDCMLOCKED_PHYEMACMIITXCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACDCMLOCKED_PHYEMACMIITXCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACDCMLOCKED_PHYEMACTXGMIIMIICLKIN_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACDCMLOCKED_PHYEMACTXGMIIMIICLKIN_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACPAUSEREQ_CLIENTEMACTXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACPAUSEREQ_CLIENTEMACTXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACPAUSEREQ_PHYEMACMIITXCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACPAUSEREQ_PHYEMACMIITXCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACPAUSEREQ_PHYEMACTXGMIIMIICLKIN_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACPAUSEREQ_PHYEMACTXGMIIMIICLKIN_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_CLIENTEMACTXDVLDMSW_CLIENTEMACTXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACTXDVLDMSW_CLIENTEMACTXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACTXDVLDMSW_PHYEMACMIITXCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACTXDVLDMSW_PHYEMACMIITXCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACTXDVLDMSW_PHYEMACTXGMIIMIICLKIN_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACTXDVLDMSW_PHYEMACTXGMIIMIICLKIN_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACTXDVLD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACTXDVLD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACTXDVLD_PHYEMACMIITXCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACTXDVLD_PHYEMACMIITXCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACTXDVLD_PHYEMACTXGMIIMIICLKIN_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACTXDVLD_PHYEMACTXGMIIMIICLKIN_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tsetup_CLIENTEMACTXFIRSTBYTE_CLIENTEMACTXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACTXFIRSTBYTE_CLIENTEMACTXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACTXFIRSTBYTE_PHYEMACMIITXCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACTXFIRSTBYTE_PHYEMACMIITXCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACTXFIRSTBYTE_PHYEMACTXGMIIMIICLKIN_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACTXFIRSTBYTE_PHYEMACTXGMIIMIICLKIN_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_CLIENTEMACTXUNDERRUN_CLIENTEMACTXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACTXUNDERRUN_CLIENTEMACTXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACTXUNDERRUN_PHYEMACMIITXCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACTXUNDERRUN_PHYEMACMIITXCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACTXUNDERRUN_PHYEMACTXGMIIMIICLKIN_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_CLIENTEMACTXUNDERRUN_PHYEMACTXGMIIMIICLKIN_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_DCREMACABUS_DCREMACCLK_negedge_posedge : VitalDelayArrayType(0 to 9) := (others => 0 ps);
      tsetup_DCREMACABUS_DCREMACCLK_posedge_posedge : VitalDelayArrayType(0 to 9) := (others => 0 ps);
      tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge : VitalDelayArrayType(0 to 31) := (others => 0 ps);
      tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge : VitalDelayArrayType(0 to 31) := (others => 0 ps);
      tsetup_DCREMACENABLE_DCREMACCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_DCREMACENABLE_DCREMACCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_DCREMACREAD_DCREMACCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_DCREMACREAD_DCREMACCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_DCREMACWRITE_DCREMACCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_DCREMACWRITE_DCREMACCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_HOSTADDR_HOSTCLK_negedge_posedge : VitalDelayArrayType(9 downto 0) := (others => 0 ps);
      tsetup_HOSTADDR_HOSTCLK_posedge_posedge : VitalDelayArrayType(9 downto 0) := (others => 0 ps);
      tsetup_HOSTMIIMSEL_HOSTCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_HOSTMIIMSEL_HOSTCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_HOSTOPCODE_HOSTCLK_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_HOSTOPCODE_HOSTCLK_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_HOSTREQ_HOSTCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_HOSTREQ_HOSTCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge : VitalDelayArrayType(31 downto 0) := (others => 0 ps);
      tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge : VitalDelayArrayType(31 downto 0) := (others => 0 ps);
      tsetup_PHYEMACCOL_PHYEMACGTXCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACCOL_PHYEMACGTXCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACCOL_PHYEMACRXCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACCOL_PHYEMACRXCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACCRS_PHYEMACGTXCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACCRS_PHYEMACGTXCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACCRS_PHYEMACRXCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACCRS_PHYEMACRXCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACMDIN_HOSTCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACMDIN_HOSTCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACMDIN_PHYEMACMCLKIN_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACMDIN_PHYEMACMCLKIN_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACPHYAD_HOSTCLK_negedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
      tsetup_PHYEMACPHYAD_HOSTCLK_posedge_posedge : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
      tsetup_PHYEMACRXBUFSTATUS_PHYEMACGTXCLK_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_PHYEMACRXBUFSTATUS_PHYEMACGTXCLK_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_PHYEMACRXBUFSTATUS_PHYEMACRXCLK_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_PHYEMACRXBUFSTATUS_PHYEMACRXCLK_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tsetup_PHYEMACRXCHARISCOMMA_PHYEMACGTXCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACRXCHARISCOMMA_PHYEMACGTXCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACRXCHARISCOMMA_PHYEMACRXCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACRXCHARISCOMMA_PHYEMACRXCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACRXCHARISK_PHYEMACGTXCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACRXCHARISK_PHYEMACGTXCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACRXCHARISK_PHYEMACRXCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACRXCHARISK_PHYEMACRXCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_PHYEMACRXCLKCORCNT_PHYEMACRXCLK_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_PHYEMACRXCLKCORCNT_PHYEMACRXCLK_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tsetup_PHYEMACRXDISPERR_PHYEMACGTXCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACRXDISPERR_PHYEMACGTXCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACRXDISPERR_PHYEMACRXCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACRXDISPERR_PHYEMACRXCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACRXDV_PHYEMACGTXCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACRXDV_PHYEMACGTXCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACRXDV_PHYEMACRXCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACRXDV_PHYEMACRXCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACRXD_PHYEMACGTXCLK_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_PHYEMACRXD_PHYEMACGTXCLK_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_PHYEMACRXD_PHYEMACRXCLK_negedge_negedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_PHYEMACRXD_PHYEMACRXCLK_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_PHYEMACRXD_PHYEMACRXCLK_posedge_negedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_PHYEMACRXD_PHYEMACRXCLK_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tsetup_PHYEMACRXER_PHYEMACGTXCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACRXER_PHYEMACGTXCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACRXER_PHYEMACRXCLK_negedge_negedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACRXER_PHYEMACRXCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACRXER_PHYEMACRXCLK_posedge_negedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACRXER_PHYEMACRXCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACRXNOTINTABLE_PHYEMACGTXCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACRXNOTINTABLE_PHYEMACGTXCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACRXNOTINTABLE_PHYEMACRXCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACRXNOTINTABLE_PHYEMACRXCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACRXRUNDISP_PHYEMACGTXCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACRXRUNDISP_PHYEMACGTXCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACRXRUNDISP_PHYEMACRXCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACRXRUNDISP_PHYEMACRXCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACSIGNALDET_PHYEMACGTXCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACSIGNALDET_PHYEMACGTXCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACSIGNALDET_PHYEMACRXCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACSIGNALDET_PHYEMACRXCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACTXBUFERR_PHYEMACGTXCLK_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACTXBUFERR_PHYEMACGTXCLK_posedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACTXBUFERR_PHYEMACTXGMIIMIICLKIN_negedge_posedge : VitalDelayType := 0 ps;
      tsetup_PHYEMACTXBUFERR_PHYEMACTXGMIIMIICLKIN_posedge_posedge : VitalDelayType := 0 ps;
      tisd_CLIENTEMACDCMLOCKED_CLIENTEMACTXCLIENTCLKIN : VitalDelayType := 0 ps;
      tisd_CLIENTEMACDCMLOCKED_PHYEMACMIITXCLK : VitalDelayType := 0 ps;
      tisd_CLIENTEMACDCMLOCKED_PHYEMACTXGMIIMIICLKIN : VitalDelayType := 0 ps;
      tisd_CLIENTEMACPAUSEREQ_CLIENTEMACTXCLIENTCLKIN : VitalDelayType := 0 ps;
      tisd_CLIENTEMACPAUSEREQ_PHYEMACMIITXCLK : VitalDelayType := 0 ps;
      tisd_CLIENTEMACPAUSEREQ_PHYEMACTXGMIIMIICLKIN : VitalDelayType := 0 ps;
      tisd_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tisd_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tisd_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tisd_CLIENTEMACTXDVLDMSW_CLIENTEMACTXCLIENTCLKIN : VitalDelayType := 0 ps;
      tisd_CLIENTEMACTXDVLDMSW_PHYEMACMIITXCLK : VitalDelayType := 0 ps;
      tisd_CLIENTEMACTXDVLDMSW_PHYEMACTXGMIIMIICLKIN : VitalDelayType := 0 ps;
      tisd_CLIENTEMACTXDVLD_CLIENTEMACTXCLIENTCLKIN : VitalDelayType := 0 ps;
      tisd_CLIENTEMACTXDVLD_PHYEMACMIITXCLK : VitalDelayType := 0 ps;
      tisd_CLIENTEMACTXDVLD_PHYEMACTXGMIIMIICLKIN : VitalDelayType := 0 ps;
      tisd_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tisd_CLIENTEMACTXD_PHYEMACMIITXCLK : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tisd_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN : VitalDelayArrayType(15 downto 0) := (others => 0 ps);
      tisd_CLIENTEMACTXFIRSTBYTE_CLIENTEMACTXCLIENTCLKIN : VitalDelayType := 0 ps;
      tisd_CLIENTEMACTXFIRSTBYTE_PHYEMACMIITXCLK : VitalDelayType := 0 ps;
      tisd_CLIENTEMACTXFIRSTBYTE_PHYEMACTXGMIIMIICLKIN : VitalDelayType := 0 ps;
      tisd_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tisd_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tisd_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tisd_CLIENTEMACTXUNDERRUN_CLIENTEMACTXCLIENTCLKIN : VitalDelayType := 0 ps;
      tisd_CLIENTEMACTXUNDERRUN_PHYEMACMIITXCLK : VitalDelayType := 0 ps;
      tisd_CLIENTEMACTXUNDERRUN_PHYEMACTXGMIIMIICLKIN : VitalDelayType := 0 ps;
      tisd_DCREMACABUS_DCREMACCLK : VitalDelayArrayType(0 to 9) := (others => 0 ps);
      tisd_DCREMACDBUS_DCREMACCLK : VitalDelayArrayType(0 to 31) := (others => 0 ps);
      tisd_DCREMACENABLE_DCREMACCLK : VitalDelayType := 0 ps;
      tisd_DCREMACREAD_DCREMACCLK : VitalDelayType := 0 ps;
      tisd_DCREMACWRITE_DCREMACCLK : VitalDelayType := 0 ps;
      tisd_HOSTADDR_HOSTCLK : VitalDelayArrayType(9 downto 0) := (others => 0 ps);
      tisd_HOSTMIIMSEL_HOSTCLK : VitalDelayType := 0 ps;
      tisd_HOSTOPCODE_HOSTCLK : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tisd_HOSTREQ_HOSTCLK : VitalDelayType := 0 ps;
      tisd_HOSTWRDATA_HOSTCLK : VitalDelayArrayType(31 downto 0) := (others => 0 ps);
      tisd_PHYEMACCOL_PHYEMACGTXCLK : VitalDelayType := 0 ps;
      tisd_PHYEMACCOL_PHYEMACRXCLK : VitalDelayType := 0 ps;
      tisd_PHYEMACCRS_PHYEMACGTXCLK : VitalDelayType := 0 ps;
      tisd_PHYEMACCRS_PHYEMACRXCLK : VitalDelayType := 0 ps;
      tisd_PHYEMACMDIN_HOSTCLK : VitalDelayType := 0 ps;
      tisd_PHYEMACMDIN_PHYEMACMCLKIN : VitalDelayType := 0 ps;
      tisd_PHYEMACPHYAD_HOSTCLK : VitalDelayArrayType(4 downto 0) := (others => 0 ps);
      tisd_PHYEMACRXBUFSTATUS_PHYEMACGTXCLK : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tisd_PHYEMACRXBUFSTATUS_PHYEMACRXCLK : VitalDelayArrayType(1 downto 0) := (others => 0 ps);
      tisd_PHYEMACRXCHARISCOMMA_PHYEMACGTXCLK : VitalDelayType := 0 ps;
      tisd_PHYEMACRXCHARISCOMMA_PHYEMACRXCLK : VitalDelayType := 0 ps;
      tisd_PHYEMACRXCHARISK_PHYEMACGTXCLK : VitalDelayType := 0 ps;
      tisd_PHYEMACRXCHARISK_PHYEMACRXCLK : VitalDelayType := 0 ps;
      tisd_PHYEMACRXCLKCORCNT_PHYEMACGTXCLK : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tisd_PHYEMACRXCLKCORCNT_PHYEMACRXCLK : VitalDelayArrayType(2 downto 0) := (others => 0 ps);
      tisd_PHYEMACRXDISPERR_PHYEMACGTXCLK : VitalDelayType := 0 ps;
      tisd_PHYEMACRXDISPERR_PHYEMACRXCLK : VitalDelayType := 0 ps;
      tisd_PHYEMACRXDV_PHYEMACGTXCLK : VitalDelayType := 0 ps;
      tisd_PHYEMACRXDV_PHYEMACRXCLK : VitalDelayType := 0 ps;
      tisd_PHYEMACRXD_PHYEMACGTXCLK : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tisd_PHYEMACRXD_PHYEMACRXCLK : VitalDelayArrayType(7 downto 0) := (others => 0 ps);
      tisd_PHYEMACRXER_PHYEMACGTXCLK : VitalDelayType := 0 ps;
      tisd_PHYEMACRXER_PHYEMACRXCLK : VitalDelayType := 0 ps;
      tisd_PHYEMACRXNOTINTABLE_PHYEMACGTXCLK : VitalDelayType := 0 ps;
      tisd_PHYEMACRXNOTINTABLE_PHYEMACRXCLK : VitalDelayType := 0 ps;
      tisd_PHYEMACRXRUNDISP_PHYEMACGTXCLK : VitalDelayType := 0 ps;
      tisd_PHYEMACRXRUNDISP_PHYEMACRXCLK : VitalDelayType := 0 ps;
      tisd_PHYEMACSIGNALDET_PHYEMACGTXCLK : VitalDelayType := 0 ps;
      tisd_PHYEMACSIGNALDET_PHYEMACRXCLK : VitalDelayType := 0 ps;
      tisd_PHYEMACTXBUFERR_PHYEMACGTXCLK : VitalDelayType := 0 ps;
      tisd_PHYEMACTXBUFERR_PHYEMACTXGMIIMIICLKIN : VitalDelayType := 0 ps;
      tisd_RESET_CLIENTEMACTXCLIENTCLKIN : VitalDelayType := 0 ps;
      tisd_RESET_HOSTCLK : VitalDelayType := 0 ps;
      tisd_RESET_PHYEMACGTXCLK : VitalDelayType := 0 ps;
      tisd_RESET_PHYEMACMIITXCLK : VitalDelayType := 0 ps;
      tisd_RESET_PHYEMACTXGMIIMIICLKIN : VitalDelayType := 0 ps;
      ticd_CLIENTEMACRXCLIENTCLKIN : VitalDelayType := 0 ps;
      ticd_CLIENTEMACTXCLIENTCLKIN : VitalDelayType := 0 ps;
      ticd_DCREMACCLK : VitalDelayType := 0 ps;
      ticd_HOSTCLK : VitalDelayType := 0 ps;
      ticd_PHYEMACGTXCLK : VitalDelayType := 0 ps;
      ticd_PHYEMACMCLKIN : VitalDelayType := 0 ps;
      ticd_PHYEMACMIITXCLK : VitalDelayType := 0 ps;
      ticd_PHYEMACRXCLK : VitalDelayType := 0 ps;
      ticd_PHYEMACTXGMIIMIICLKIN : VitalDelayType := 0 ps
    );

    port (
      DCRHOSTDONEIR        : out std_ulogic;
      EMACCLIENTANINTERRUPT : out std_ulogic;
      EMACCLIENTRXBADFRAME : out std_ulogic;
      EMACCLIENTRXCLIENTCLKOUT : out std_ulogic;
      EMACCLIENTRXD        : out std_logic_vector(15 downto 0);
      EMACCLIENTRXDVLD     : out std_ulogic;
      EMACCLIENTRXDVLDMSW  : out std_ulogic;
      EMACCLIENTRXFRAMEDROP : out std_ulogic;
      EMACCLIENTRXGOODFRAME : out std_ulogic;
      EMACCLIENTRXSTATS    : out std_logic_vector(6 downto 0);
      EMACCLIENTRXSTATSBYTEVLD : out std_ulogic;
      EMACCLIENTRXSTATSVLD : out std_ulogic;
      EMACCLIENTTXACK      : out std_ulogic;
      EMACCLIENTTXCLIENTCLKOUT : out std_ulogic;
      EMACCLIENTTXCOLLISION : out std_ulogic;
      EMACCLIENTTXRETRANSMIT : out std_ulogic;
      EMACCLIENTTXSTATS    : out std_ulogic;
      EMACCLIENTTXSTATSBYTEVLD : out std_ulogic;
      EMACCLIENTTXSTATSVLD : out std_ulogic;
      EMACDCRACK           : out std_ulogic;
      EMACDCRDBUS          : out std_logic_vector(0 to 31);
      EMACPHYENCOMMAALIGN  : out std_ulogic;
      EMACPHYLOOPBACKMSB   : out std_ulogic;
      EMACPHYMCLKOUT       : out std_ulogic;
      EMACPHYMDOUT         : out std_ulogic;
      EMACPHYMDTRI         : out std_ulogic;
      EMACPHYMGTRXRESET    : out std_ulogic;
      EMACPHYMGTTXRESET    : out std_ulogic;
      EMACPHYPOWERDOWN     : out std_ulogic;
      EMACPHYSYNCACQSTATUS : out std_ulogic;
      EMACPHYTXCHARDISPMODE : out std_ulogic;
      EMACPHYTXCHARDISPVAL : out std_ulogic;
      EMACPHYTXCHARISK     : out std_ulogic;
      EMACPHYTXCLK         : out std_ulogic;
      EMACPHYTXD           : out std_logic_vector(7 downto 0);
      EMACPHYTXEN          : out std_ulogic;
      EMACPHYTXER          : out std_ulogic;
      EMACPHYTXGMIIMIICLKOUT : out std_ulogic;
      EMACSPEEDIS10100     : out std_ulogic;
      HOSTMIIMRDY          : out std_ulogic;
      HOSTRDDATA           : out std_logic_vector(31 downto 0);
      CLIENTEMACDCMLOCKED  : in std_ulogic;
      CLIENTEMACPAUSEREQ   : in std_ulogic;
      CLIENTEMACPAUSEVAL   : in std_logic_vector(15 downto 0);
      CLIENTEMACRXCLIENTCLKIN : in std_ulogic;
      CLIENTEMACTXCLIENTCLKIN : in std_ulogic;
      CLIENTEMACTXD        : in std_logic_vector(15 downto 0);
      CLIENTEMACTXDVLD     : in std_ulogic;
      CLIENTEMACTXDVLDMSW  : in std_ulogic;
      CLIENTEMACTXFIRSTBYTE : in std_ulogic;
      CLIENTEMACTXIFGDELAY : in std_logic_vector(7 downto 0);
      CLIENTEMACTXUNDERRUN : in std_ulogic;
      DCREMACABUS          : in std_logic_vector(0 to 9);
      DCREMACCLK           : in std_ulogic;
      DCREMACDBUS          : in std_logic_vector(0 to 31);
      DCREMACENABLE        : in std_ulogic;
      DCREMACREAD          : in std_ulogic;
      DCREMACWRITE         : in std_ulogic;
      HOSTADDR             : in std_logic_vector(9 downto 0);
      HOSTCLK              : in std_ulogic;
      HOSTMIIMSEL          : in std_ulogic;
      HOSTOPCODE           : in std_logic_vector(1 downto 0);
      HOSTREQ              : in std_ulogic;
      HOSTWRDATA           : in std_logic_vector(31 downto 0);
      PHYEMACCOL           : in std_ulogic;
      PHYEMACCRS           : in std_ulogic;
      PHYEMACGTXCLK        : in std_ulogic;
      PHYEMACMCLKIN        : in std_ulogic;
      PHYEMACMDIN          : in std_ulogic;
      PHYEMACMIITXCLK      : in std_ulogic;
      PHYEMACPHYAD         : in std_logic_vector(4 downto 0);
      PHYEMACRXBUFSTATUS   : in std_logic_vector(1 downto 0);
      PHYEMACRXCHARISCOMMA : in std_ulogic;
      PHYEMACRXCHARISK     : in std_ulogic;
      PHYEMACRXCLK         : in std_ulogic;
      PHYEMACRXCLKCORCNT   : in std_logic_vector(2 downto 0);
      PHYEMACRXD           : in std_logic_vector(7 downto 0);
      PHYEMACRXDISPERR     : in std_ulogic;
      PHYEMACRXDV          : in std_ulogic;
      PHYEMACRXER          : in std_ulogic;
      PHYEMACRXNOTINTABLE  : in std_ulogic;
      PHYEMACRXRUNDISP     : in std_ulogic;
      PHYEMACSIGNALDET     : in std_ulogic;
      PHYEMACTXBUFERR      : in std_ulogic;
      PHYEMACTXGMIIMIICLKIN : in std_ulogic;
      RESET                : in std_ulogic      
    );
    attribute VITAL_LEVEL0 of X_TEMAC_SINGLE :     entity is true;
  end X_TEMAC_SINGLE;

  architecture X_TEMAC_SINGLE_V of X_TEMAC_SINGLE is
    TYPE VitalTimingDataArrayType IS ARRAY (NATURAL RANGE <>) OF VitalTimingDataType;
    component TEMAC_SINGLE_WRAP
     generic (
      EMAC_1000BASEX_ENABLE : string;
      EMAC_ADDRFILTER_ENABLE : string;
      EMAC_BYTEPHY : string;
      EMAC_CTRLLENCHECK_DISABLE : string;
      EMAC_DCRBASEADDR : string;
      EMAC_GTLOOPBACK : string;
      EMAC_HOST_ENABLE : string;
      EMAC_LINKTIMERVAL : string;
      EMAC_LTCHECK_DISABLE : string;
      EMAC_MDIO_ENABLE : string;
      EMAC_MDIO_IGNORE_PHYADZERO : string;
      EMAC_PAUSEADDR : string;
      EMAC_PHYINITAUTONEG_ENABLE : string;
      EMAC_PHYISOLATE : string;
      EMAC_PHYLOOPBACKMSB : string;
      EMAC_PHYPOWERDOWN : string;
      EMAC_PHYRESET : string;
      EMAC_RGMII_ENABLE : string;
      EMAC_RX16BITCLIENT_ENABLE : string;
      EMAC_RXFLOWCTRL_ENABLE : string;
      EMAC_RXHALFDUPLEX : string;
      EMAC_RXINBANDFCS_ENABLE : string;
      EMAC_RXJUMBOFRAME_ENABLE : string;
      EMAC_RXRESET : string;
      EMAC_RXVLAN_ENABLE : string;
      EMAC_RX_ENABLE : string;
      EMAC_SGMII_ENABLE : string;
      EMAC_SPEED_LSB : string;
      EMAC_SPEED_MSB : string;
      EMAC_TX16BITCLIENT_ENABLE : string;
      EMAC_TXFLOWCTRL_ENABLE : string;
      EMAC_TXHALFDUPLEX : string;
      EMAC_TXIFGADJUST_ENABLE : string;
      EMAC_TXINBANDFCS_ENABLE : string;
      EMAC_TXJUMBOFRAME_ENABLE : string;
      EMAC_TXRESET : string;
      EMAC_TXVLAN_ENABLE : string;
      EMAC_TX_ENABLE : string;
      EMAC_UNICASTADDR : string;
      EMAC_UNIDIRECTION_ENABLE : string;
      EMAC_USECLKEN : string
    );

      port (
        DCRHOSTDONEIR        : out std_ulogic;
        EMACCLIENTANINTERRUPT : out std_ulogic;
        EMACCLIENTRXBADFRAME : out std_ulogic;
        EMACCLIENTRXCLIENTCLKOUT : out std_ulogic;
        EMACCLIENTRXD        : out std_logic_vector(15 downto 0);
        EMACCLIENTRXDVLD     : out std_ulogic;
        EMACCLIENTRXDVLDMSW  : out std_ulogic;
        EMACCLIENTRXFRAMEDROP : out std_ulogic;
        EMACCLIENTRXGOODFRAME : out std_ulogic;
        EMACCLIENTRXSTATS    : out std_logic_vector(6 downto 0);
        EMACCLIENTRXSTATSBYTEVLD : out std_ulogic;
        EMACCLIENTRXSTATSVLD : out std_ulogic;
        EMACCLIENTTXACK      : out std_ulogic;
        EMACCLIENTTXCLIENTCLKOUT : out std_ulogic;
        EMACCLIENTTXCOLLISION : out std_ulogic;
        EMACCLIENTTXRETRANSMIT : out std_ulogic;
        EMACCLIENTTXSTATS    : out std_ulogic;
        EMACCLIENTTXSTATSBYTEVLD : out std_ulogic;
        EMACCLIENTTXSTATSVLD : out std_ulogic;
        EMACDCRACK           : out std_ulogic;
        EMACDCRDBUS          : out std_logic_vector(0 to 31);
        EMACPHYENCOMMAALIGN  : out std_ulogic;
        EMACPHYLOOPBACKMSB   : out std_ulogic;
        EMACPHYMCLKOUT       : out std_ulogic;
        EMACPHYMDOUT         : out std_ulogic;
        EMACPHYMDTRI         : out std_ulogic;
        EMACPHYMGTRXRESET    : out std_ulogic;
        EMACPHYMGTTXRESET    : out std_ulogic;
        EMACPHYPOWERDOWN     : out std_ulogic;
        EMACPHYSYNCACQSTATUS : out std_ulogic;
        EMACPHYTXCHARDISPMODE : out std_ulogic;
        EMACPHYTXCHARDISPVAL : out std_ulogic;
        EMACPHYTXCHARISK     : out std_ulogic;
        EMACPHYTXCLK         : out std_ulogic;
        EMACPHYTXD           : out std_logic_vector(7 downto 0);
        EMACPHYTXEN          : out std_ulogic;
        EMACPHYTXER          : out std_ulogic;
        EMACPHYTXGMIIMIICLKOUT : out std_ulogic;
        EMACSPEEDIS10100     : out std_ulogic;
        HOSTMIIMRDY          : out std_ulogic;
        HOSTRDDATA           : out std_logic_vector(31 downto 0);
        GSR                  : in std_ulogic;
        CLIENTEMACDCMLOCKED  : in std_ulogic;
        CLIENTEMACPAUSEREQ   : in std_ulogic;
        CLIENTEMACPAUSEVAL   : in std_logic_vector(15 downto 0);
        CLIENTEMACRXCLIENTCLKIN : in std_ulogic;
        CLIENTEMACTXCLIENTCLKIN : in std_ulogic;
        CLIENTEMACTXD        : in std_logic_vector(15 downto 0);
        CLIENTEMACTXDVLD     : in std_ulogic;
        CLIENTEMACTXDVLDMSW  : in std_ulogic;
        CLIENTEMACTXFIRSTBYTE : in std_ulogic;
        CLIENTEMACTXIFGDELAY : in std_logic_vector(7 downto 0);
        CLIENTEMACTXUNDERRUN : in std_ulogic;
        DCREMACABUS          : in std_logic_vector(0 to 9);
        DCREMACCLK           : in std_ulogic;
        DCREMACDBUS          : in std_logic_vector(0 to 31);
        DCREMACENABLE        : in std_ulogic;
        DCREMACREAD          : in std_ulogic;
        DCREMACWRITE         : in std_ulogic;
        HOSTADDR             : in std_logic_vector(9 downto 0);
        HOSTCLK              : in std_ulogic;
        HOSTMIIMSEL          : in std_ulogic;
        HOSTOPCODE           : in std_logic_vector(1 downto 0);
        HOSTREQ              : in std_ulogic;
        HOSTWRDATA           : in std_logic_vector(31 downto 0);
        PHYEMACCOL           : in std_ulogic;
        PHYEMACCRS           : in std_ulogic;
        PHYEMACGTXCLK        : in std_ulogic;
        PHYEMACMCLKIN        : in std_ulogic;
        PHYEMACMDIN          : in std_ulogic;
        PHYEMACMIITXCLK      : in std_ulogic;
        PHYEMACPHYAD         : in std_logic_vector(4 downto 0);
        PHYEMACRXBUFSTATUS   : in std_logic_vector(1 downto 0);
        PHYEMACRXCHARISCOMMA : in std_ulogic;
        PHYEMACRXCHARISK     : in std_ulogic;
        PHYEMACRXCLK         : in std_ulogic;
        PHYEMACRXCLKCORCNT   : in std_logic_vector(2 downto 0);
        PHYEMACRXD           : in std_logic_vector(7 downto 0);
        PHYEMACRXDISPERR     : in std_ulogic;
        PHYEMACRXDV          : in std_ulogic;
        PHYEMACRXER          : in std_ulogic;
        PHYEMACRXNOTINTABLE  : in std_ulogic;
        PHYEMACRXRUNDISP     : in std_ulogic;
        PHYEMACSIGNALDET     : in std_ulogic;
        PHYEMACTXBUFERR      : in std_ulogic;
        PHYEMACTXGMIIMIICLKIN : in std_ulogic;
        RESET                : in std_ulogic        
      );
    end component;

    function GetValue_EMAC (
    EMAC_TX16BITCLIENT_ENABLE : in boolean
    )  return time is 
    variable delay_time : time;
  begin 
    case EMAC_TX16BITCLIENT_ENABLE is 
      when TRUE => delay_time := 25 ps;
      when FALSE => delay_time := 0 ps;
    end case;
    return delay_time;
  end;
    
    constant IN_DELAY : time := 50 ps;
    constant OUT_DELAY : time := 0 ps;
    constant INCLK_DELAY : time := 0 ps;
    constant OUTCLK_DELAY : time := 0 ps;

    constant EMACMIITXCLK_DELAY : time := GetValue_EMAC(EMAC_TX16BITCLIENT_ENABLE);
  
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
    constant EMAC_DCRBASEADDR_BINARY : std_logic_vector(7 downto 0) := To_StdLogicVector(EMAC_DCRBASEADDR)(7 downto 0);
    constant EMAC_LINKTIMERVAL_BINARY : std_logic_vector(8 downto 0) := To_StdLogicVector(EMAC_LINKTIMERVAL)(8 downto 0);
    constant EMAC_PAUSEADDR_BINARY : std_logic_vector(47 downto 0) := To_StdLogicVector(EMAC_PAUSEADDR)(47 downto 0);
    constant EMAC_UNICASTADDR_BINARY : std_logic_vector(47 downto 0) := To_StdLogicVector(EMAC_UNICASTADDR)(47 downto 0);
    
    -- Get String Length
    constant EMAC_DCRBASEADDR_STRLEN : integer := getstrlength(EMAC_DCRBASEADDR_BINARY);
    constant EMAC_LINKTIMERVAL_STRLEN : integer := getstrlength(EMAC_LINKTIMERVAL_BINARY);
    constant EMAC_PAUSEADDR_STRLEN : integer := getstrlength(EMAC_PAUSEADDR_BINARY);
    constant EMAC_UNICASTADDR_STRLEN : integer := getstrlength(EMAC_UNICASTADDR_BINARY);
    
    -- Convert std_logic_vector to string
    constant EMAC_DCRBASEADDR_STRING : string := SLV_TO_HEX(EMAC_DCRBASEADDR_BINARY, EMAC_DCRBASEADDR_STRLEN);
    constant EMAC_LINKTIMERVAL_STRING : string := SLV_TO_HEX(EMAC_LINKTIMERVAL_BINARY, EMAC_LINKTIMERVAL_STRLEN);
    constant EMAC_PAUSEADDR_STRING : string := SLV_TO_HEX(EMAC_PAUSEADDR_BINARY, EMAC_PAUSEADDR_STRLEN);
    constant EMAC_UNICASTADDR_STRING : string := SLV_TO_HEX(EMAC_UNICASTADDR_BINARY, EMAC_UNICASTADDR_STRLEN);
    
    -- Convert boolean to string
    constant EMAC_1000BASEX_ENABLE_STRING : string := boolean_to_string(EMAC_1000BASEX_ENABLE);
    constant EMAC_ADDRFILTER_ENABLE_STRING : string := boolean_to_string(EMAC_ADDRFILTER_ENABLE);
    constant EMAC_BYTEPHY_STRING : string := boolean_to_string(EMAC_BYTEPHY);
    constant EMAC_CTRLLENCHECK_DISABLE_STRING : string := boolean_to_string(EMAC_CTRLLENCHECK_DISABLE);
    constant EMAC_GTLOOPBACK_STRING : string := boolean_to_string(EMAC_GTLOOPBACK);
    constant EMAC_HOST_ENABLE_STRING : string := boolean_to_string(EMAC_HOST_ENABLE);
    constant EMAC_LTCHECK_DISABLE_STRING : string := boolean_to_string(EMAC_LTCHECK_DISABLE);
    constant EMAC_MDIO_ENABLE_STRING : string := boolean_to_string(EMAC_MDIO_ENABLE);
    constant EMAC_MDIO_IGNORE_PHYADZERO_STRING : string := boolean_to_string(EMAC_MDIO_IGNORE_PHYADZERO);
    constant EMAC_PHYINITAUTONEG_ENABLE_STRING : string := boolean_to_string(EMAC_PHYINITAUTONEG_ENABLE);
    constant EMAC_PHYISOLATE_STRING : string := boolean_to_string(EMAC_PHYISOLATE);
    constant EMAC_PHYLOOPBACKMSB_STRING : string := boolean_to_string(EMAC_PHYLOOPBACKMSB);
    constant EMAC_PHYPOWERDOWN_STRING : string := boolean_to_string(EMAC_PHYPOWERDOWN);
    constant EMAC_PHYRESET_STRING : string := boolean_to_string(EMAC_PHYRESET);
    constant EMAC_RGMII_ENABLE_STRING : string := boolean_to_string(EMAC_RGMII_ENABLE);
    constant EMAC_RX16BITCLIENT_ENABLE_STRING : string := boolean_to_string(EMAC_RX16BITCLIENT_ENABLE);
    constant EMAC_RXFLOWCTRL_ENABLE_STRING : string := boolean_to_string(EMAC_RXFLOWCTRL_ENABLE);
    constant EMAC_RXHALFDUPLEX_STRING : string := boolean_to_string(EMAC_RXHALFDUPLEX);
    constant EMAC_RXINBANDFCS_ENABLE_STRING : string := boolean_to_string(EMAC_RXINBANDFCS_ENABLE);
    constant EMAC_RXJUMBOFRAME_ENABLE_STRING : string := boolean_to_string(EMAC_RXJUMBOFRAME_ENABLE);
    constant EMAC_RXRESET_STRING : string := boolean_to_string(EMAC_RXRESET);
    constant EMAC_RXVLAN_ENABLE_STRING : string := boolean_to_string(EMAC_RXVLAN_ENABLE);
    constant EMAC_RX_ENABLE_STRING : string := boolean_to_string(EMAC_RX_ENABLE);
    constant EMAC_SGMII_ENABLE_STRING : string := boolean_to_string(EMAC_SGMII_ENABLE);
    constant EMAC_SPEED_LSB_STRING : string := boolean_to_string(EMAC_SPEED_LSB);
    constant EMAC_SPEED_MSB_STRING : string := boolean_to_string(EMAC_SPEED_MSB);
    constant EMAC_TX16BITCLIENT_ENABLE_STRING : string := boolean_to_string(EMAC_TX16BITCLIENT_ENABLE);
    constant EMAC_TXFLOWCTRL_ENABLE_STRING : string := boolean_to_string(EMAC_TXFLOWCTRL_ENABLE);
    constant EMAC_TXHALFDUPLEX_STRING : string := boolean_to_string(EMAC_TXHALFDUPLEX);
    constant EMAC_TXIFGADJUST_ENABLE_STRING : string := boolean_to_string(EMAC_TXIFGADJUST_ENABLE);
    constant EMAC_TXINBANDFCS_ENABLE_STRING : string := boolean_to_string(EMAC_TXINBANDFCS_ENABLE);
    constant EMAC_TXJUMBOFRAME_ENABLE_STRING : string := boolean_to_string(EMAC_TXJUMBOFRAME_ENABLE);
    constant EMAC_TXRESET_STRING : string := boolean_to_string(EMAC_TXRESET);
    constant EMAC_TXVLAN_ENABLE_STRING : string := boolean_to_string(EMAC_TXVLAN_ENABLE);
    constant EMAC_TX_ENABLE_STRING : string := boolean_to_string(EMAC_TX_ENABLE);
    constant EMAC_UNIDIRECTION_ENABLE_STRING : string := boolean_to_string(EMAC_UNIDIRECTION_ENABLE);
    constant EMAC_USECLKEN_STRING : string := boolean_to_string(EMAC_USECLKEN);
    
    signal EMAC_1000BASEX_ENABLE_BINARY : std_ulogic;
    signal EMAC_ADDRFILTER_ENABLE_BINARY : std_ulogic;
    signal EMAC_BYTEPHY_BINARY : std_ulogic;
    signal EMAC_CTRLLENCHECK_DISABLE_BINARY : std_ulogic;
    signal EMAC_GTLOOPBACK_BINARY : std_ulogic;
    signal EMAC_HOST_ENABLE_BINARY : std_ulogic;
    signal EMAC_LTCHECK_DISABLE_BINARY : std_ulogic;
    signal EMAC_MDIO_ENABLE_BINARY : std_ulogic;
    signal EMAC_MDIO_IGNORE_PHYADZERO_BINARY : std_ulogic;
    signal EMAC_PHYINITAUTONEG_ENABLE_BINARY : std_ulogic;
    signal EMAC_PHYISOLATE_BINARY : std_ulogic;
    signal EMAC_PHYLOOPBACKMSB_BINARY : std_ulogic;
    signal EMAC_PHYPOWERDOWN_BINARY : std_ulogic;
    signal EMAC_PHYRESET_BINARY : std_ulogic;
    signal EMAC_RGMII_ENABLE_BINARY : std_ulogic;
    signal EMAC_RX16BITCLIENT_ENABLE_BINARY : std_ulogic;
    signal EMAC_RXFLOWCTRL_ENABLE_BINARY : std_ulogic;
    signal EMAC_RXHALFDUPLEX_BINARY : std_ulogic;
    signal EMAC_RXINBANDFCS_ENABLE_BINARY : std_ulogic;
    signal EMAC_RXJUMBOFRAME_ENABLE_BINARY : std_ulogic;
    signal EMAC_RXRESET_BINARY : std_ulogic;
    signal EMAC_RXVLAN_ENABLE_BINARY : std_ulogic;
    signal EMAC_RX_ENABLE_BINARY : std_ulogic;
    signal EMAC_SGMII_ENABLE_BINARY : std_ulogic;
    signal EMAC_SPEED_LSB_BINARY : std_ulogic;
    signal EMAC_SPEED_MSB_BINARY : std_ulogic;
    signal EMAC_TX16BITCLIENT_ENABLE_BINARY : std_ulogic;
    signal EMAC_TXFLOWCTRL_ENABLE_BINARY : std_ulogic;
    signal EMAC_TXHALFDUPLEX_BINARY : std_ulogic;
    signal EMAC_TXIFGADJUST_ENABLE_BINARY : std_ulogic;
    signal EMAC_TXINBANDFCS_ENABLE_BINARY : std_ulogic;
    signal EMAC_TXJUMBOFRAME_ENABLE_BINARY : std_ulogic;
    signal EMAC_TXRESET_BINARY : std_ulogic;
    signal EMAC_TXVLAN_ENABLE_BINARY : std_ulogic;
    signal EMAC_TX_ENABLE_BINARY : std_ulogic;
    signal EMAC_UNIDIRECTION_ENABLE_BINARY : std_ulogic;
    signal EMAC_USECLKEN_BINARY : std_ulogic;
    signal SIM_VERSION_BINARY : std_ulogic;
    
    signal DCRHOSTDONEIR_out : std_ulogic;
    signal EMACCLIENTANINTERRUPT_out : std_ulogic;
    signal EMACCLIENTRXBADFRAME_out : std_ulogic;
    signal EMACCLIENTRXCLIENTCLKOUT_out : std_ulogic;
    signal EMACCLIENTRXDVLDMSW_out : std_ulogic;
    signal EMACCLIENTRXDVLD_out : std_ulogic;
    signal EMACCLIENTRXD_out : std_logic_vector(15 downto 0);
    signal EMACCLIENTRXFRAMEDROP_out : std_ulogic;
    signal EMACCLIENTRXGOODFRAME_out : std_ulogic;
    signal EMACCLIENTRXSTATSBYTEVLD_out : std_ulogic;
    signal EMACCLIENTRXSTATSVLD_out : std_ulogic;
    signal EMACCLIENTRXSTATS_out : std_logic_vector(6 downto 0);
    signal EMACCLIENTTXACK_out : std_ulogic;
    signal EMACCLIENTTXCLIENTCLKOUT_out : std_ulogic;
    signal EMACCLIENTTXCOLLISION_out : std_ulogic;
    signal EMACCLIENTTXRETRANSMIT_out : std_ulogic;
    signal EMACCLIENTTXSTATSBYTEVLD_out : std_ulogic;
    signal EMACCLIENTTXSTATSVLD_out : std_ulogic;
    signal EMACCLIENTTXSTATS_out : std_ulogic;
    signal EMACDCRACK_out : std_ulogic;
    signal EMACDCRDBUS_out : std_logic_vector(0 to 31);
    signal EMACPHYENCOMMAALIGN_out : std_ulogic;
    signal EMACPHYLOOPBACKMSB_out : std_ulogic;
    signal EMACPHYMCLKOUT_out : std_ulogic;
    signal EMACPHYMDOUT_out : std_ulogic;
    signal EMACPHYMDTRI_out : std_ulogic;
    signal EMACPHYMGTRXRESET_out : std_ulogic;
    signal EMACPHYMGTTXRESET_out : std_ulogic;
    signal EMACPHYPOWERDOWN_out : std_ulogic;
    signal EMACPHYSYNCACQSTATUS_out : std_ulogic;
    signal EMACPHYTXCHARDISPMODE_out : std_ulogic;
    signal EMACPHYTXCHARDISPVAL_out : std_ulogic;
    signal EMACPHYTXCHARISK_out : std_ulogic;
    signal EMACPHYTXCLK_out : std_ulogic;
    signal EMACPHYTXD_out : std_logic_vector(7 downto 0);
    signal EMACPHYTXEN_out : std_ulogic;
    signal EMACPHYTXER_out : std_ulogic;
    signal EMACPHYTXGMIIMIICLKOUT_out : std_ulogic;
    signal EMACSPEEDIS10100_out : std_ulogic;
    signal HOSTMIIMRDY_out : std_ulogic;
    signal HOSTRDDATA_out : std_logic_vector(31 downto 0);
    
    signal DCRHOSTDONEIR_outdelay : std_ulogic;
    signal EMACCLIENTANINTERRUPT_outdelay : std_ulogic;
    signal EMACCLIENTRXBADFRAME_outdelay : std_ulogic;
    signal EMACCLIENTRXCLIENTCLKOUT_outdelay : std_ulogic;
    signal EMACCLIENTRXDVLDMSW_outdelay : std_ulogic;
    signal EMACCLIENTRXDVLD_outdelay : std_ulogic;
    signal EMACCLIENTRXD_outdelay : std_logic_vector(15 downto 0);
    signal EMACCLIENTRXFRAMEDROP_outdelay : std_ulogic;
    signal EMACCLIENTRXGOODFRAME_outdelay : std_ulogic;
    signal EMACCLIENTRXSTATSBYTEVLD_outdelay : std_ulogic;
    signal EMACCLIENTRXSTATSVLD_outdelay : std_ulogic;
    signal EMACCLIENTRXSTATS_outdelay : std_logic_vector(6 downto 0);
    signal EMACCLIENTTXACK_outdelay : std_ulogic;
    signal EMACCLIENTTXCLIENTCLKOUT_outdelay : std_ulogic;
    signal EMACCLIENTTXCOLLISION_outdelay : std_ulogic;
    signal EMACCLIENTTXRETRANSMIT_outdelay : std_ulogic;
    signal EMACCLIENTTXSTATSBYTEVLD_outdelay : std_ulogic;
    signal EMACCLIENTTXSTATSVLD_outdelay : std_ulogic;
    signal EMACCLIENTTXSTATS_outdelay : std_ulogic;
    signal EMACDCRACK_outdelay : std_ulogic;
    signal EMACDCRDBUS_outdelay : std_logic_vector(0 to 31);
    signal EMACPHYENCOMMAALIGN_outdelay : std_ulogic;
    signal EMACPHYLOOPBACKMSB_outdelay : std_ulogic;
    signal EMACPHYMCLKOUT_outdelay : std_ulogic;
    signal EMACPHYMDOUT_outdelay : std_ulogic;
    signal EMACPHYMDTRI_outdelay : std_ulogic;
    signal EMACPHYMGTRXRESET_outdelay : std_ulogic;
    signal EMACPHYMGTTXRESET_outdelay : std_ulogic;
    signal EMACPHYPOWERDOWN_outdelay : std_ulogic;
    signal EMACPHYSYNCACQSTATUS_outdelay : std_ulogic;
    signal EMACPHYTXCHARDISPMODE_outdelay : std_ulogic;
    signal EMACPHYTXCHARDISPVAL_outdelay : std_ulogic;
    signal EMACPHYTXCHARISK_outdelay : std_ulogic;
    signal EMACPHYTXCLK_outdelay : std_ulogic;
    signal EMACPHYTXD_outdelay : std_logic_vector(7 downto 0);
    signal EMACPHYTXEN_outdelay : std_ulogic;
    signal EMACPHYTXER_outdelay : std_ulogic;
    signal EMACPHYTXGMIIMIICLKOUT_outdelay : std_ulogic;
    signal EMACSPEEDIS10100_outdelay : std_ulogic;
    signal HOSTMIIMRDY_outdelay : std_ulogic;
    signal HOSTRDDATA_outdelay : std_logic_vector(31 downto 0);
    
    signal CLIENTEMACDCMLOCKED_ipd : std_ulogic;
    signal CLIENTEMACPAUSEREQ_ipd : std_ulogic;
    signal CLIENTEMACPAUSEVAL_ipd : std_logic_vector(15 downto 0);
    signal CLIENTEMACRXCLIENTCLKIN_ipd : std_ulogic;
    signal CLIENTEMACTXCLIENTCLKIN_ipd : std_ulogic;
    signal CLIENTEMACTXDVLDMSW_ipd : std_ulogic;
    signal CLIENTEMACTXDVLD_ipd : std_ulogic;
    signal CLIENTEMACTXD_ipd : std_logic_vector(15 downto 0);
    signal CLIENTEMACTXFIRSTBYTE_ipd : std_ulogic;
    signal CLIENTEMACTXIFGDELAY_ipd : std_logic_vector(7 downto 0);
    signal CLIENTEMACTXUNDERRUN_ipd : std_ulogic;
    signal DCREMACABUS_ipd : std_logic_vector(0 to 9);
    signal DCREMACCLK_ipd : std_ulogic;
    signal DCREMACDBUS_ipd : std_logic_vector(0 to 31);
    signal DCREMACENABLE_ipd : std_ulogic;
    signal DCREMACREAD_ipd : std_ulogic;
    signal DCREMACWRITE_ipd : std_ulogic;
    signal HOSTADDR_ipd : std_logic_vector(9 downto 0);
    signal HOSTCLK_ipd : std_ulogic;
    signal HOSTMIIMSEL_ipd : std_ulogic;
    signal HOSTOPCODE_ipd : std_logic_vector(1 downto 0);
    signal HOSTREQ_ipd : std_ulogic;
    signal HOSTWRDATA_ipd : std_logic_vector(31 downto 0);
    signal PHYEMACCOL_ipd : std_ulogic;
    signal PHYEMACCRS_ipd : std_ulogic;
    signal PHYEMACGTXCLK_ipd : std_ulogic;
    signal PHYEMACMCLKIN_ipd : std_ulogic;
    signal PHYEMACMDIN_ipd : std_ulogic;
    signal PHYEMACMIITXCLK_ipd : std_ulogic;
    signal PHYEMACPHYAD_ipd : std_logic_vector(4 downto 0);
    signal PHYEMACRXBUFSTATUS_ipd : std_logic_vector(1 downto 0);
    signal PHYEMACRXCHARISCOMMA_ipd : std_ulogic;
    signal PHYEMACRXCHARISK_ipd : std_ulogic;
    signal PHYEMACRXCLKCORCNT_ipd : std_logic_vector(2 downto 0);
    signal PHYEMACRXCLK_ipd : std_ulogic;
    signal PHYEMACRXDISPERR_ipd : std_ulogic;
    signal PHYEMACRXDV_ipd : std_ulogic;
    signal PHYEMACRXD_ipd : std_logic_vector(7 downto 0);
    signal PHYEMACRXER_ipd : std_ulogic;
    signal PHYEMACRXNOTINTABLE_ipd : std_ulogic;
    signal PHYEMACRXRUNDISP_ipd : std_ulogic;
    signal PHYEMACSIGNALDET_ipd : std_ulogic;
    signal PHYEMACTXBUFERR_ipd : std_ulogic;
    signal PHYEMACTXGMIIMIICLKIN_ipd : std_ulogic;
    signal RESET_ipd : std_ulogic;
    
    signal CLIENTEMACDCMLOCKED_CLIENTEMACTXCLIENTCLKIN_dly : std_ulogic;
    signal CLIENTEMACDCMLOCKED_PHYEMACMIITXCLK_dly : std_ulogic;
    signal CLIENTEMACDCMLOCKED_PHYEMACTXGMIIMIICLKIN_dly : std_ulogic;
    signal CLIENTEMACPAUSEREQ_CLIENTEMACTXCLIENTCLKIN_dly : std_ulogic;
    signal CLIENTEMACPAUSEREQ_PHYEMACMIITXCLK_dly : std_ulogic;
    signal CLIENTEMACPAUSEREQ_PHYEMACTXGMIIMIICLKIN_dly : std_ulogic;
    signal CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_dly : std_logic_vector(15 downto 0);
    signal CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_dly : std_logic_vector(15 downto 0);
    signal CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_dly : std_logic_vector(15 downto 0);
    signal CLIENTEMACRXCLIENTCLKIN_dly : std_ulogic;
    signal CLIENTEMACTXCLIENTCLKIN_dly : std_ulogic;
    signal CLIENTEMACTXDVLDMSW_CLIENTEMACTXCLIENTCLKIN_dly : std_ulogic;
    signal CLIENTEMACTXDVLDMSW_PHYEMACMIITXCLK_dly : std_ulogic;
    signal CLIENTEMACTXDVLDMSW_PHYEMACTXGMIIMIICLKIN_dly : std_ulogic;
    signal CLIENTEMACTXDVLD_CLIENTEMACTXCLIENTCLKIN_dly : std_ulogic;
    signal CLIENTEMACTXDVLD_PHYEMACMIITXCLK_dly : std_ulogic;
    signal CLIENTEMACTXDVLD_PHYEMACTXGMIIMIICLKIN_dly : std_ulogic;
    signal CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_dly : std_logic_vector(15 downto 0);
    signal CLIENTEMACTXD_PHYEMACMIITXCLK_dly : std_logic_vector(15 downto 0);
    signal CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_dly : std_logic_vector(15 downto 0);
    signal CLIENTEMACTXFIRSTBYTE_CLIENTEMACTXCLIENTCLKIN_dly : std_ulogic;
    signal CLIENTEMACTXFIRSTBYTE_PHYEMACMIITXCLK_dly : std_ulogic;
    signal CLIENTEMACTXFIRSTBYTE_PHYEMACTXGMIIMIICLKIN_dly : std_ulogic;
    signal CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_dly : std_logic_vector(7 downto 0);
    signal CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_dly : std_logic_vector(7 downto 0);
    signal CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_dly : std_logic_vector(7 downto 0);
    signal CLIENTEMACTXUNDERRUN_CLIENTEMACTXCLIENTCLKIN_dly : std_ulogic;
    signal CLIENTEMACTXUNDERRUN_PHYEMACMIITXCLK_dly : std_ulogic;
    signal CLIENTEMACTXUNDERRUN_PHYEMACTXGMIIMIICLKIN_dly : std_ulogic;
    signal DCREMACABUS_DCREMACCLK_dly : std_logic_vector(0 to 9);
    signal DCREMACCLK_dly : std_ulogic;
    signal DCREMACDBUS_DCREMACCLK_dly : std_logic_vector(0 to 31);
    signal DCREMACENABLE_DCREMACCLK_dly : std_ulogic;
    signal DCREMACREAD_DCREMACCLK_dly : std_ulogic;
    signal DCREMACWRITE_DCREMACCLK_dly : std_ulogic;
    signal HOSTADDR_HOSTCLK_dly : std_logic_vector(9 downto 0);
    signal HOSTCLK_dly : std_ulogic;
    signal HOSTMIIMSEL_HOSTCLK_dly : std_ulogic;
    signal HOSTOPCODE_HOSTCLK_dly : std_logic_vector(1 downto 0);
    signal HOSTREQ_HOSTCLK_dly : std_ulogic;
    signal HOSTWRDATA_HOSTCLK_dly : std_logic_vector(31 downto 0);
    signal PHYEMACCOL_PHYEMACGTXCLK_dly : std_ulogic;
    signal PHYEMACCOL_PHYEMACRXCLK_dly : std_ulogic;
    signal PHYEMACCRS_PHYEMACGTXCLK_dly : std_ulogic;
    signal PHYEMACCRS_PHYEMACRXCLK_dly : std_ulogic;
    signal PHYEMACGTXCLK_dly : std_ulogic;
    signal PHYEMACMCLKIN_dly : std_ulogic;
    signal PHYEMACMDIN_HOSTCLK_dly : std_ulogic;
    signal PHYEMACMDIN_PHYEMACMCLKIN_dly : std_ulogic;
    signal PHYEMACMIITXCLK_dly : std_ulogic;
    signal PHYEMACPHYAD_HOSTCLK_dly : std_logic_vector(4 downto 0);
    signal PHYEMACRXBUFSTATUS_PHYEMACGTXCLK_dly : std_logic_vector(1 downto 0);
    signal PHYEMACRXBUFSTATUS_PHYEMACRXCLK_dly : std_logic_vector(1 downto 0);
    signal PHYEMACRXCHARISCOMMA_PHYEMACGTXCLK_dly : std_ulogic;
    signal PHYEMACRXCHARISCOMMA_PHYEMACRXCLK_dly : std_ulogic;
    signal PHYEMACRXCHARISK_PHYEMACGTXCLK_dly : std_ulogic;
    signal PHYEMACRXCHARISK_PHYEMACRXCLK_dly : std_ulogic;
    signal PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_dly : std_logic_vector(2 downto 0);
    signal PHYEMACRXCLKCORCNT_PHYEMACRXCLK_dly : std_logic_vector(2 downto 0);
    signal PHYEMACRXCLK_dly : std_ulogic;
    signal PHYEMACRXDISPERR_PHYEMACGTXCLK_dly : std_ulogic;
    signal PHYEMACRXDISPERR_PHYEMACRXCLK_dly : std_ulogic;
    signal PHYEMACRXDV_PHYEMACGTXCLK_dly : std_ulogic;
    signal PHYEMACRXDV_PHYEMACRXCLK_dly : std_ulogic;
    signal PHYEMACRXD_PHYEMACGTXCLK_dly : std_logic_vector(7 downto 0);
    signal PHYEMACRXD_PHYEMACRXCLK_dly : std_logic_vector(7 downto 0);
    signal PHYEMACRXER_PHYEMACGTXCLK_dly : std_ulogic;
    signal PHYEMACRXER_PHYEMACRXCLK_dly : std_ulogic;
    signal PHYEMACRXNOTINTABLE_PHYEMACGTXCLK_dly : std_ulogic;
    signal PHYEMACRXNOTINTABLE_PHYEMACRXCLK_dly : std_ulogic;
    signal PHYEMACRXRUNDISP_PHYEMACGTXCLK_dly : std_ulogic;
    signal PHYEMACRXRUNDISP_PHYEMACRXCLK_dly : std_ulogic;
    signal PHYEMACSIGNALDET_PHYEMACGTXCLK_dly : std_ulogic;
    signal PHYEMACSIGNALDET_PHYEMACRXCLK_dly : std_ulogic;
    signal PHYEMACTXBUFERR_PHYEMACGTXCLK_dly : std_ulogic;
    signal PHYEMACTXBUFERR_PHYEMACTXGMIIMIICLKIN_dly : std_ulogic;
    signal PHYEMACTXGMIIMIICLKIN_dly : std_ulogic;
    signal RESET_CLIENTEMACTXCLIENTCLKIN_dly : std_ulogic;
    signal RESET_HOSTCLK_dly : std_ulogic;
    signal RESET_PHYEMACGTXCLK_dly : std_ulogic;
    signal RESET_PHYEMACMIITXCLK_dly : std_ulogic;
    signal RESET_PHYEMACTXGMIIMIICLKIN_dly : std_ulogic;

    signal CLIENTEMACDCMLOCKED_indelay : std_ulogic;
    signal CLIENTEMACPAUSEREQ_indelay : std_ulogic;
    signal CLIENTEMACPAUSEVAL_indelay : std_logic_vector(15 downto 0);
    signal CLIENTEMACRXCLIENTCLKIN_indelay : std_ulogic;
    signal CLIENTEMACTXCLIENTCLKIN_indelay : std_ulogic;
    signal CLIENTEMACTXDVLDMSW_indelay : std_ulogic;
    signal CLIENTEMACTXDVLD_indelay : std_ulogic;
    signal CLIENTEMACTXD_indelay : std_logic_vector(15 downto 0);
    signal CLIENTEMACTXFIRSTBYTE_indelay : std_ulogic;
    signal CLIENTEMACTXIFGDELAY_indelay : std_logic_vector(7 downto 0);
    signal CLIENTEMACTXUNDERRUN_indelay : std_ulogic;
    signal DCREMACABUS_indelay : std_logic_vector(0 to 9);
    signal DCREMACCLK_indelay : std_ulogic;
    signal DCREMACDBUS_indelay : std_logic_vector(0 to 31);
    signal DCREMACENABLE_indelay : std_ulogic;
    signal DCREMACREAD_indelay : std_ulogic;
    signal DCREMACWRITE_indelay : std_ulogic;
    signal HOSTADDR_indelay : std_logic_vector(9 downto 0);
    signal HOSTCLK_indelay : std_ulogic;
    signal HOSTMIIMSEL_indelay : std_ulogic;
    signal HOSTOPCODE_indelay : std_logic_vector(1 downto 0);
    signal HOSTREQ_indelay : std_ulogic;
    signal HOSTWRDATA_indelay : std_logic_vector(31 downto 0);
    signal PHYEMACCOL_indelay : std_ulogic;
    signal PHYEMACCRS_indelay : std_ulogic;
    signal PHYEMACGTXCLK_indelay : std_ulogic;
    signal PHYEMACMCLKIN_indelay : std_ulogic;
    signal PHYEMACMDIN_indelay : std_ulogic;
    signal PHYEMACMIITXCLK_indelay : std_ulogic;
    signal PHYEMACPHYAD_indelay : std_logic_vector(4 downto 0);
    signal PHYEMACRXBUFSTATUS_indelay : std_logic_vector(1 downto 0);
    signal PHYEMACRXCHARISCOMMA_indelay : std_ulogic;
    signal PHYEMACRXCHARISK_indelay : std_ulogic;
    signal PHYEMACRXCLKCORCNT_indelay : std_logic_vector(2 downto 0);
    signal PHYEMACRXCLK_indelay : std_ulogic;
    signal PHYEMACRXDISPERR_indelay : std_ulogic;
    signal PHYEMACRXDV_indelay : std_ulogic;
    signal PHYEMACRXD_indelay : std_logic_vector(7 downto 0);
    signal PHYEMACRXER_indelay : std_ulogic;
    signal PHYEMACRXNOTINTABLE_indelay : std_ulogic;
    signal PHYEMACRXRUNDISP_indelay : std_ulogic;
    signal PHYEMACSIGNALDET_indelay : std_ulogic;
    signal PHYEMACTXBUFERR_indelay : std_ulogic;
    signal PHYEMACTXGMIIMIICLKIN_indelay : std_ulogic;
    signal RESET_indelay : std_ulogic;
    
    signal CLIENTEMACDCMLOCKED_indly : std_ulogic;
    signal CLIENTEMACPAUSEREQ_indly : std_ulogic;
    signal CLIENTEMACPAUSEVAL_indly : std_logic_vector(15 downto 0);
    signal CLIENTEMACRXCLIENTCLKIN_indly : std_ulogic;
    signal CLIENTEMACTXCLIENTCLKIN_indly : std_ulogic;
    signal CLIENTEMACTXDVLDMSW_indly : std_ulogic;
    signal CLIENTEMACTXDVLD_indly : std_ulogic;
    signal CLIENTEMACTXD_indly : std_logic_vector(15 downto 0);
    signal CLIENTEMACTXFIRSTBYTE_indly : std_ulogic;
    signal CLIENTEMACTXIFGDELAY_indly : std_logic_vector(7 downto 0);
    signal CLIENTEMACTXUNDERRUN_indly : std_ulogic;
    signal DCREMACABUS_indly : std_logic_vector(0 to 9);
    signal DCREMACCLK_indly : std_ulogic;
    signal DCREMACDBUS_indly : std_logic_vector(0 to 31);
    signal DCREMACENABLE_indly : std_ulogic;
    signal DCREMACREAD_indly : std_ulogic;
    signal DCREMACWRITE_indly : std_ulogic;
    signal HOSTADDR_indly : std_logic_vector(9 downto 0);
    signal HOSTCLK_indly : std_ulogic;
    signal HOSTMIIMSEL_indly : std_ulogic;
    signal HOSTOPCODE_indly : std_logic_vector(1 downto 0);
    signal HOSTREQ_indly : std_ulogic;
    signal HOSTWRDATA_indly : std_logic_vector(31 downto 0);
    signal PHYEMACCOL_indly : std_ulogic;
    signal PHYEMACCRS_indly : std_ulogic;
    signal PHYEMACGTXCLK_indly : std_ulogic;
    signal PHYEMACMCLKIN_indly : std_ulogic;
    signal PHYEMACMDIN_indly : std_ulogic;
    signal PHYEMACMIITXCLK_indly : std_ulogic;
    signal PHYEMACPHYAD_indly : std_logic_vector(4 downto 0);
    signal PHYEMACRXBUFSTATUS_indly : std_logic_vector(1 downto 0);
    signal PHYEMACRXCHARISCOMMA_indly : std_ulogic;
    signal PHYEMACRXCHARISK_indly : std_ulogic;
    signal PHYEMACRXCLKCORCNT_indly : std_logic_vector(2 downto 0);
    signal PHYEMACRXCLK_indly : std_ulogic;
    signal PHYEMACRXDISPERR_indly : std_ulogic;
    signal PHYEMACRXDV_indly : std_ulogic;
    signal PHYEMACRXD_indly : std_logic_vector(7 downto 0);
    signal PHYEMACRXER_indly : std_ulogic;
    signal PHYEMACRXNOTINTABLE_indly : std_ulogic;
    signal PHYEMACRXRUNDISP_indly : std_ulogic;
    signal PHYEMACSIGNALDET_indly : std_ulogic;
    signal PHYEMACTXBUFERR_indly : std_ulogic;
    signal PHYEMACTXGMIIMIICLKIN_indly : std_ulogic;
    signal RESET_indly : std_ulogic;
    
-- <!--Aldec correction start
	signal GSR_local : std_ulogic;
-- Aldec correction end -->

    begin
    
    WireDelay : block
    begin
      CLIENTEMACPAUSEVAL_DELAY : for i in 0 to 15 generate
        VitalWireDelay (CLIENTEMACPAUSEVAL_ipd(i),CLIENTEMACPAUSEVAL(i),tipd_CLIENTEMACPAUSEVAL(i));
      end generate CLIENTEMACPAUSEVAL_DELAY;
      CLIENTEMACTXD_DELAY : for i in 0 to 15 generate
        VitalWireDelay (CLIENTEMACTXD_ipd(i),CLIENTEMACTXD(i),tipd_CLIENTEMACTXD(i));
      end generate CLIENTEMACTXD_DELAY;
      CLIENTEMACTXIFGDELAY_DELAY : for i in 0 to 7 generate
        VitalWireDelay (CLIENTEMACTXIFGDELAY_ipd(i),CLIENTEMACTXIFGDELAY(i),tipd_CLIENTEMACTXIFGDELAY(i));
      end generate CLIENTEMACTXIFGDELAY_DELAY;
      DCREMACABUS_DELAY : for i in 0 to 9 generate
        VitalWireDelay (DCREMACABUS_ipd(i),DCREMACABUS(i),tipd_DCREMACABUS(i));
      end generate DCREMACABUS_DELAY;
      DCREMACDBUS_DELAY : for i in 0 to 31 generate
        VitalWireDelay (DCREMACDBUS_ipd(i),DCREMACDBUS(i),tipd_DCREMACDBUS(i));
      end generate DCREMACDBUS_DELAY;
      HOSTADDR_DELAY : for i in 0 to 9 generate
        VitalWireDelay (HOSTADDR_ipd(i),HOSTADDR(i),tipd_HOSTADDR(i));
      end generate HOSTADDR_DELAY;
      HOSTOPCODE_DELAY : for i in 0 to 1 generate
        VitalWireDelay (HOSTOPCODE_ipd(i),HOSTOPCODE(i),tipd_HOSTOPCODE(i));
      end generate HOSTOPCODE_DELAY;
      HOSTWRDATA_DELAY : for i in 0 to 31 generate
        VitalWireDelay (HOSTWRDATA_ipd(i),HOSTWRDATA(i),tipd_HOSTWRDATA(i));
      end generate HOSTWRDATA_DELAY;
      PHYEMACPHYAD_DELAY : for i in 0 to 4 generate
        VitalWireDelay (PHYEMACPHYAD_ipd(i),PHYEMACPHYAD(i),tipd_PHYEMACPHYAD(i));
      end generate PHYEMACPHYAD_DELAY;
      PHYEMACRXBUFSTATUS_DELAY : for i in 0 to 1 generate
        VitalWireDelay (PHYEMACRXBUFSTATUS_ipd(i),PHYEMACRXBUFSTATUS(i),tipd_PHYEMACRXBUFSTATUS(i));
      end generate PHYEMACRXBUFSTATUS_DELAY;
      PHYEMACRXCLKCORCNT_DELAY : for i in 0 to 2 generate
        VitalWireDelay (PHYEMACRXCLKCORCNT_ipd(i),PHYEMACRXCLKCORCNT(i),tipd_PHYEMACRXCLKCORCNT(i));
      end generate PHYEMACRXCLKCORCNT_DELAY;
      PHYEMACRXD_DELAY : for i in 0 to 7 generate
        VitalWireDelay (PHYEMACRXD_ipd(i),PHYEMACRXD(i),tipd_PHYEMACRXD(i));
      end generate PHYEMACRXD_DELAY;
      VitalWireDelay (CLIENTEMACDCMLOCKED_ipd,CLIENTEMACDCMLOCKED,tipd_CLIENTEMACDCMLOCKED);
      VitalWireDelay (CLIENTEMACPAUSEREQ_ipd,CLIENTEMACPAUSEREQ,tipd_CLIENTEMACPAUSEREQ);
      VitalWireDelay (CLIENTEMACRXCLIENTCLKIN_ipd,CLIENTEMACRXCLIENTCLKIN,tipd_CLIENTEMACRXCLIENTCLKIN);
      VitalWireDelay (CLIENTEMACTXCLIENTCLKIN_ipd,CLIENTEMACTXCLIENTCLKIN,tipd_CLIENTEMACTXCLIENTCLKIN);
      VitalWireDelay (CLIENTEMACTXDVLDMSW_ipd,CLIENTEMACTXDVLDMSW,tipd_CLIENTEMACTXDVLDMSW);
      VitalWireDelay (CLIENTEMACTXDVLD_ipd,CLIENTEMACTXDVLD,tipd_CLIENTEMACTXDVLD);
      VitalWireDelay (CLIENTEMACTXFIRSTBYTE_ipd,CLIENTEMACTXFIRSTBYTE,tipd_CLIENTEMACTXFIRSTBYTE);
      VitalWireDelay (CLIENTEMACTXUNDERRUN_ipd,CLIENTEMACTXUNDERRUN,tipd_CLIENTEMACTXUNDERRUN);
      VitalWireDelay (DCREMACCLK_ipd,DCREMACCLK,tipd_DCREMACCLK);
      VitalWireDelay (DCREMACENABLE_ipd,DCREMACENABLE,tipd_DCREMACENABLE);
      VitalWireDelay (DCREMACREAD_ipd,DCREMACREAD,tipd_DCREMACREAD);
      VitalWireDelay (DCREMACWRITE_ipd,DCREMACWRITE,tipd_DCREMACWRITE);
      VitalWireDelay (HOSTCLK_ipd,HOSTCLK,tipd_HOSTCLK);
      VitalWireDelay (HOSTMIIMSEL_ipd,HOSTMIIMSEL,tipd_HOSTMIIMSEL);
      VitalWireDelay (HOSTREQ_ipd,HOSTREQ,tipd_HOSTREQ);
      VitalWireDelay (PHYEMACCOL_ipd,PHYEMACCOL,tipd_PHYEMACCOL);
      VitalWireDelay (PHYEMACCRS_ipd,PHYEMACCRS,tipd_PHYEMACCRS);
      VitalWireDelay (PHYEMACGTXCLK_ipd,PHYEMACGTXCLK,tipd_PHYEMACGTXCLK);
      VitalWireDelay (PHYEMACMCLKIN_ipd,PHYEMACMCLKIN,tipd_PHYEMACMCLKIN);
      VitalWireDelay (PHYEMACMDIN_ipd,PHYEMACMDIN,tipd_PHYEMACMDIN);
      VitalWireDelay (PHYEMACMIITXCLK_ipd,PHYEMACMIITXCLK,tipd_PHYEMACMIITXCLK);
      VitalWireDelay (PHYEMACRXCHARISCOMMA_ipd,PHYEMACRXCHARISCOMMA,tipd_PHYEMACRXCHARISCOMMA);
      VitalWireDelay (PHYEMACRXCHARISK_ipd,PHYEMACRXCHARISK,tipd_PHYEMACRXCHARISK);
      VitalWireDelay (PHYEMACRXCLK_ipd,PHYEMACRXCLK,tipd_PHYEMACRXCLK);
      VitalWireDelay (PHYEMACRXDISPERR_ipd,PHYEMACRXDISPERR,tipd_PHYEMACRXDISPERR);
      VitalWireDelay (PHYEMACRXDV_ipd,PHYEMACRXDV,tipd_PHYEMACRXDV);
      VitalWireDelay (PHYEMACRXER_ipd,PHYEMACRXER,tipd_PHYEMACRXER);
      VitalWireDelay (PHYEMACRXNOTINTABLE_ipd,PHYEMACRXNOTINTABLE,tipd_PHYEMACRXNOTINTABLE);
      VitalWireDelay (PHYEMACRXRUNDISP_ipd,PHYEMACRXRUNDISP,tipd_PHYEMACRXRUNDISP);
      VitalWireDelay (PHYEMACSIGNALDET_ipd,PHYEMACSIGNALDET,tipd_PHYEMACSIGNALDET);
      VitalWireDelay (PHYEMACTXBUFERR_ipd,PHYEMACTXBUFERR,tipd_PHYEMACTXBUFERR);
      VitalWireDelay (PHYEMACTXGMIIMIICLKIN_ipd,PHYEMACTXGMIIMIICLKIN,tipd_PHYEMACTXGMIIMIICLKIN);
      VitalWireDelay (RESET_ipd,RESET,tipd_RESET);
    end block;
    
    SignalDelay : block
    begin
      CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_DELAY : for i in 15 downto 0 generate
        VitalSignalDelay (CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_dly(i),CLIENTEMACPAUSEVAL_ipd(i),tisd_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN(i));
      end generate CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_DELAY;
      CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_DELAY : for i in 15 downto 0 generate
        VitalSignalDelay (CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_dly(i),CLIENTEMACPAUSEVAL_ipd(i),tisd_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK(i));
      end generate CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_DELAY;
      CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_DELAY : for i in 15 downto 0 generate
        VitalSignalDelay (CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_dly(i),CLIENTEMACPAUSEVAL_ipd(i),tisd_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN(i));
      end generate CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_DELAY;
      CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_DELAY : for i in 15 downto 0 generate
        VitalSignalDelay (CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_dly(i),CLIENTEMACTXD_ipd(i),tisd_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN(i));
      end generate CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_DELAY;
      CLIENTEMACTXD_PHYEMACMIITXCLK_DELAY : for i in 15 downto 0 generate
        VitalSignalDelay (CLIENTEMACTXD_PHYEMACMIITXCLK_dly(i),CLIENTEMACTXD_ipd(i),tisd_CLIENTEMACTXD_PHYEMACMIITXCLK(i));
      end generate CLIENTEMACTXD_PHYEMACMIITXCLK_DELAY;
      CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_DELAY : for i in 15 downto 0 generate
        VitalSignalDelay (CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_dly(i),CLIENTEMACTXD_ipd(i),tisd_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN(i));
      end generate CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_DELAY;
      CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_DELAY : for i in 7 downto 0 generate
        VitalSignalDelay (CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_dly(i),CLIENTEMACTXIFGDELAY_ipd(i),tisd_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN(i));
      end generate CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_DELAY;
      CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_DELAY : for i in 7 downto 0 generate
        VitalSignalDelay (CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_dly(i),CLIENTEMACTXIFGDELAY_ipd(i),tisd_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK(i));
      end generate CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_DELAY;
      CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_DELAY : for i in 7 downto 0 generate
        VitalSignalDelay (CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_dly(i),CLIENTEMACTXIFGDELAY_ipd(i),tisd_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN(i));
      end generate CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_DELAY;
      DCREMACABUS_DCREMACCLK_DELAY : for i in 0 to 9 generate
        VitalSignalDelay (DCREMACABUS_DCREMACCLK_dly(i),DCREMACABUS_ipd(i),tisd_DCREMACABUS_DCREMACCLK(i));
      end generate DCREMACABUS_DCREMACCLK_DELAY;
      DCREMACDBUS_DCREMACCLK_DELAY : for i in 0 to 31 generate
        VitalSignalDelay (DCREMACDBUS_DCREMACCLK_dly(i),DCREMACDBUS_ipd(i),tisd_DCREMACDBUS_DCREMACCLK(i));
      end generate DCREMACDBUS_DCREMACCLK_DELAY;
      HOSTADDR_HOSTCLK_DELAY : for i in 9 downto 0 generate
        VitalSignalDelay (HOSTADDR_HOSTCLK_dly(i),HOSTADDR_ipd(i),tisd_HOSTADDR_HOSTCLK(i));
      end generate HOSTADDR_HOSTCLK_DELAY;
      HOSTOPCODE_HOSTCLK_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (HOSTOPCODE_HOSTCLK_dly(i),HOSTOPCODE_ipd(i),tisd_HOSTOPCODE_HOSTCLK(i));
      end generate HOSTOPCODE_HOSTCLK_DELAY;
      HOSTWRDATA_HOSTCLK_DELAY : for i in 31 downto 0 generate
        VitalSignalDelay (HOSTWRDATA_HOSTCLK_dly(i),HOSTWRDATA_ipd(i),tisd_HOSTWRDATA_HOSTCLK(i));
      end generate HOSTWRDATA_HOSTCLK_DELAY;
      PHYEMACPHYAD_HOSTCLK_DELAY : for i in 4 downto 0 generate
        VitalSignalDelay (PHYEMACPHYAD_HOSTCLK_dly(i),PHYEMACPHYAD_ipd(i),tisd_PHYEMACPHYAD_HOSTCLK(i));
      end generate PHYEMACPHYAD_HOSTCLK_DELAY;
      PHYEMACRXBUFSTATUS_PHYEMACGTXCLK_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (PHYEMACRXBUFSTATUS_PHYEMACGTXCLK_dly(i),PHYEMACRXBUFSTATUS_ipd(i),tisd_PHYEMACRXBUFSTATUS_PHYEMACGTXCLK(i));
      end generate PHYEMACRXBUFSTATUS_PHYEMACGTXCLK_DELAY;
      PHYEMACRXBUFSTATUS_PHYEMACRXCLK_DELAY : for i in 1 downto 0 generate
        VitalSignalDelay (PHYEMACRXBUFSTATUS_PHYEMACRXCLK_dly(i),PHYEMACRXBUFSTATUS_ipd(i),tisd_PHYEMACRXBUFSTATUS_PHYEMACRXCLK(i));
      end generate PHYEMACRXBUFSTATUS_PHYEMACRXCLK_DELAY;
      PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_DELAY : for i in 2 downto 0 generate
        VitalSignalDelay (PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_dly(i),PHYEMACRXCLKCORCNT_ipd(i),tisd_PHYEMACRXCLKCORCNT_PHYEMACGTXCLK(i));
      end generate PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_DELAY;
      PHYEMACRXCLKCORCNT_PHYEMACRXCLK_DELAY : for i in 2 downto 0 generate
        VitalSignalDelay (PHYEMACRXCLKCORCNT_PHYEMACRXCLK_dly(i),PHYEMACRXCLKCORCNT_ipd(i),tisd_PHYEMACRXCLKCORCNT_PHYEMACRXCLK(i));
      end generate PHYEMACRXCLKCORCNT_PHYEMACRXCLK_DELAY;
      PHYEMACRXD_PHYEMACGTXCLK_DELAY : for i in 7 downto 0 generate
        VitalSignalDelay (PHYEMACRXD_PHYEMACGTXCLK_dly(i),PHYEMACRXD_ipd(i),tisd_PHYEMACRXD_PHYEMACGTXCLK(i));
      end generate PHYEMACRXD_PHYEMACGTXCLK_DELAY;
      PHYEMACRXD_PHYEMACRXCLK_DELAY : for i in 7 downto 0 generate
        VitalSignalDelay (PHYEMACRXD_PHYEMACRXCLK_dly(i),PHYEMACRXD_ipd(i),tisd_PHYEMACRXD_PHYEMACRXCLK(i));
      end generate PHYEMACRXD_PHYEMACRXCLK_DELAY;
      VitalSignalDelay (CLIENTEMACDCMLOCKED_CLIENTEMACTXCLIENTCLKIN_dly,CLIENTEMACDCMLOCKED_ipd,tisd_CLIENTEMACDCMLOCKED_CLIENTEMACTXCLIENTCLKIN);
      VitalSignalDelay (CLIENTEMACDCMLOCKED_PHYEMACMIITXCLK_dly,CLIENTEMACDCMLOCKED_ipd,tisd_CLIENTEMACDCMLOCKED_PHYEMACMIITXCLK);
      VitalSignalDelay (CLIENTEMACDCMLOCKED_PHYEMACTXGMIIMIICLKIN_dly,CLIENTEMACDCMLOCKED_ipd,tisd_CLIENTEMACDCMLOCKED_PHYEMACTXGMIIMIICLKIN);
      VitalSignalDelay (CLIENTEMACPAUSEREQ_CLIENTEMACTXCLIENTCLKIN_dly,CLIENTEMACPAUSEREQ_ipd,tisd_CLIENTEMACPAUSEREQ_CLIENTEMACTXCLIENTCLKIN);
      VitalSignalDelay (CLIENTEMACPAUSEREQ_PHYEMACMIITXCLK_dly,CLIENTEMACPAUSEREQ_ipd,tisd_CLIENTEMACPAUSEREQ_PHYEMACMIITXCLK);
      VitalSignalDelay (CLIENTEMACPAUSEREQ_PHYEMACTXGMIIMIICLKIN_dly,CLIENTEMACPAUSEREQ_ipd,tisd_CLIENTEMACPAUSEREQ_PHYEMACTXGMIIMIICLKIN);
      VitalSignalDelay (CLIENTEMACTXDVLDMSW_CLIENTEMACTXCLIENTCLKIN_dly,CLIENTEMACTXDVLDMSW_ipd,tisd_CLIENTEMACTXDVLDMSW_CLIENTEMACTXCLIENTCLKIN);
      VitalSignalDelay (CLIENTEMACTXDVLDMSW_PHYEMACMIITXCLK_dly,CLIENTEMACTXDVLDMSW_ipd,tisd_CLIENTEMACTXDVLDMSW_PHYEMACMIITXCLK);
      VitalSignalDelay (CLIENTEMACTXDVLDMSW_PHYEMACTXGMIIMIICLKIN_dly,CLIENTEMACTXDVLDMSW_ipd,tisd_CLIENTEMACTXDVLDMSW_PHYEMACTXGMIIMIICLKIN);
      VitalSignalDelay (CLIENTEMACTXDVLD_CLIENTEMACTXCLIENTCLKIN_dly,CLIENTEMACTXDVLD_ipd,tisd_CLIENTEMACTXDVLD_CLIENTEMACTXCLIENTCLKIN);
      VitalSignalDelay (CLIENTEMACTXDVLD_PHYEMACMIITXCLK_dly,CLIENTEMACTXDVLD_ipd,tisd_CLIENTEMACTXDVLD_PHYEMACMIITXCLK);
      VitalSignalDelay (CLIENTEMACTXDVLD_PHYEMACTXGMIIMIICLKIN_dly,CLIENTEMACTXDVLD_ipd,tisd_CLIENTEMACTXDVLD_PHYEMACTXGMIIMIICLKIN);
      VitalSignalDelay (CLIENTEMACTXFIRSTBYTE_CLIENTEMACTXCLIENTCLKIN_dly,CLIENTEMACTXFIRSTBYTE_ipd,tisd_CLIENTEMACTXFIRSTBYTE_CLIENTEMACTXCLIENTCLKIN);
      VitalSignalDelay (CLIENTEMACTXFIRSTBYTE_PHYEMACMIITXCLK_dly,CLIENTEMACTXFIRSTBYTE_ipd,tisd_CLIENTEMACTXFIRSTBYTE_PHYEMACMIITXCLK);
      VitalSignalDelay (CLIENTEMACTXFIRSTBYTE_PHYEMACTXGMIIMIICLKIN_dly,CLIENTEMACTXFIRSTBYTE_ipd,tisd_CLIENTEMACTXFIRSTBYTE_PHYEMACTXGMIIMIICLKIN);
      VitalSignalDelay (CLIENTEMACTXUNDERRUN_CLIENTEMACTXCLIENTCLKIN_dly,CLIENTEMACTXUNDERRUN_ipd,tisd_CLIENTEMACTXUNDERRUN_CLIENTEMACTXCLIENTCLKIN);
      VitalSignalDelay (CLIENTEMACTXUNDERRUN_PHYEMACMIITXCLK_dly,CLIENTEMACTXUNDERRUN_ipd,tisd_CLIENTEMACTXUNDERRUN_PHYEMACMIITXCLK);
      VitalSignalDelay (CLIENTEMACTXUNDERRUN_PHYEMACTXGMIIMIICLKIN_dly,CLIENTEMACTXUNDERRUN_ipd,tisd_CLIENTEMACTXUNDERRUN_PHYEMACTXGMIIMIICLKIN);
      VitalSignalDelay (DCREMACENABLE_DCREMACCLK_dly,DCREMACENABLE_ipd,tisd_DCREMACENABLE_DCREMACCLK);
      VitalSignalDelay (DCREMACREAD_DCREMACCLK_dly,DCREMACREAD_ipd,tisd_DCREMACREAD_DCREMACCLK);
      VitalSignalDelay (DCREMACWRITE_DCREMACCLK_dly,DCREMACWRITE_ipd,tisd_DCREMACWRITE_DCREMACCLK);
      VitalSignalDelay (HOSTMIIMSEL_HOSTCLK_dly,HOSTMIIMSEL_ipd,tisd_HOSTMIIMSEL_HOSTCLK);
      VitalSignalDelay (HOSTREQ_HOSTCLK_dly,HOSTREQ_ipd,tisd_HOSTREQ_HOSTCLK);
      VitalSignalDelay (PHYEMACCOL_PHYEMACGTXCLK_dly,PHYEMACCOL_ipd,tisd_PHYEMACCOL_PHYEMACGTXCLK);
      VitalSignalDelay (PHYEMACCOL_PHYEMACRXCLK_dly,PHYEMACCOL_ipd,tisd_PHYEMACCOL_PHYEMACRXCLK);
      VitalSignalDelay (PHYEMACCRS_PHYEMACGTXCLK_dly,PHYEMACCRS_ipd,tisd_PHYEMACCRS_PHYEMACGTXCLK);
      VitalSignalDelay (PHYEMACCRS_PHYEMACRXCLK_dly,PHYEMACCRS_ipd,tisd_PHYEMACCRS_PHYEMACRXCLK);
      VitalSignalDelay (PHYEMACMDIN_HOSTCLK_dly,PHYEMACMDIN_ipd,tisd_PHYEMACMDIN_HOSTCLK);
      VitalSignalDelay (PHYEMACMDIN_PHYEMACMCLKIN_dly,PHYEMACMDIN_ipd,tisd_PHYEMACMDIN_PHYEMACMCLKIN);
      VitalSignalDelay (PHYEMACRXCHARISCOMMA_PHYEMACGTXCLK_dly,PHYEMACRXCHARISCOMMA_ipd,tisd_PHYEMACRXCHARISCOMMA_PHYEMACGTXCLK);
      VitalSignalDelay (PHYEMACRXCHARISCOMMA_PHYEMACRXCLK_dly,PHYEMACRXCHARISCOMMA_ipd,tisd_PHYEMACRXCHARISCOMMA_PHYEMACRXCLK);
      VitalSignalDelay (PHYEMACRXCHARISK_PHYEMACGTXCLK_dly,PHYEMACRXCHARISK_ipd,tisd_PHYEMACRXCHARISK_PHYEMACGTXCLK);
      VitalSignalDelay (PHYEMACRXCHARISK_PHYEMACRXCLK_dly,PHYEMACRXCHARISK_ipd,tisd_PHYEMACRXCHARISK_PHYEMACRXCLK);
      VitalSignalDelay (PHYEMACRXDISPERR_PHYEMACGTXCLK_dly,PHYEMACRXDISPERR_ipd,tisd_PHYEMACRXDISPERR_PHYEMACGTXCLK);
      VitalSignalDelay (PHYEMACRXDISPERR_PHYEMACRXCLK_dly,PHYEMACRXDISPERR_ipd,tisd_PHYEMACRXDISPERR_PHYEMACRXCLK);
      VitalSignalDelay (PHYEMACRXDV_PHYEMACGTXCLK_dly,PHYEMACRXDV_ipd,tisd_PHYEMACRXDV_PHYEMACGTXCLK);
      VitalSignalDelay (PHYEMACRXDV_PHYEMACRXCLK_dly,PHYEMACRXDV_ipd,tisd_PHYEMACRXDV_PHYEMACRXCLK);
      VitalSignalDelay (PHYEMACRXER_PHYEMACGTXCLK_dly,PHYEMACRXER_ipd,tisd_PHYEMACRXER_PHYEMACGTXCLK);
      VitalSignalDelay (PHYEMACRXER_PHYEMACRXCLK_dly,PHYEMACRXER_ipd,tisd_PHYEMACRXER_PHYEMACRXCLK);
      VitalSignalDelay (PHYEMACRXNOTINTABLE_PHYEMACGTXCLK_dly,PHYEMACRXNOTINTABLE_ipd,tisd_PHYEMACRXNOTINTABLE_PHYEMACGTXCLK);
      VitalSignalDelay (PHYEMACRXNOTINTABLE_PHYEMACRXCLK_dly,PHYEMACRXNOTINTABLE_ipd,tisd_PHYEMACRXNOTINTABLE_PHYEMACRXCLK);
      VitalSignalDelay (PHYEMACRXRUNDISP_PHYEMACGTXCLK_dly,PHYEMACRXRUNDISP_ipd,tisd_PHYEMACRXRUNDISP_PHYEMACGTXCLK);
      VitalSignalDelay (PHYEMACRXRUNDISP_PHYEMACRXCLK_dly,PHYEMACRXRUNDISP_ipd,tisd_PHYEMACRXRUNDISP_PHYEMACRXCLK);
      VitalSignalDelay (PHYEMACSIGNALDET_PHYEMACGTXCLK_dly,PHYEMACSIGNALDET_ipd,tisd_PHYEMACSIGNALDET_PHYEMACGTXCLK);
      VitalSignalDelay (PHYEMACSIGNALDET_PHYEMACRXCLK_dly,PHYEMACSIGNALDET_ipd,tisd_PHYEMACSIGNALDET_PHYEMACRXCLK);
      VitalSignalDelay (PHYEMACTXBUFERR_PHYEMACGTXCLK_dly,PHYEMACTXBUFERR_ipd,tisd_PHYEMACTXBUFERR_PHYEMACGTXCLK);
      VitalSignalDelay (PHYEMACTXBUFERR_PHYEMACTXGMIIMIICLKIN_dly,PHYEMACTXBUFERR_ipd,tisd_PHYEMACTXBUFERR_PHYEMACTXGMIIMIICLKIN);
      VitalSignalDelay (RESET_CLIENTEMACTXCLIENTCLKIN_dly,RESET_ipd,tisd_RESET_CLIENTEMACTXCLIENTCLKIN);
      VitalSignalDelay (RESET_HOSTCLK_dly,RESET_ipd,tisd_RESET_HOSTCLK);
      VitalSignalDelay (RESET_PHYEMACGTXCLK_dly,RESET_ipd,tisd_RESET_PHYEMACGTXCLK);
      VitalSignalDelay (RESET_PHYEMACMIITXCLK_dly,RESET_ipd,tisd_RESET_PHYEMACMIITXCLK);
      VitalSignalDelay (RESET_PHYEMACTXGMIIMIICLKIN_dly,RESET_ipd,tisd_RESET_PHYEMACTXGMIIMIICLKIN);

      VitalSignalDelay (CLIENTEMACRXCLIENTCLKIN_dly,CLIENTEMACRXCLIENTCLKIN_ipd,ticd_CLIENTEMACRXCLIENTCLKIN);
      VitalSignalDelay (CLIENTEMACTXCLIENTCLKIN_dly,CLIENTEMACTXCLIENTCLKIN_ipd,ticd_CLIENTEMACTXCLIENTCLKIN);
      VitalSignalDelay (DCREMACCLK_dly,DCREMACCLK_ipd,ticd_DCREMACCLK);
      VitalSignalDelay (HOSTCLK_dly,HOSTCLK_ipd,ticd_HOSTCLK);
      VitalSignalDelay (PHYEMACGTXCLK_dly,PHYEMACGTXCLK_ipd,ticd_PHYEMACGTXCLK);
      VitalSignalDelay (PHYEMACMCLKIN_dly,PHYEMACMCLKIN_ipd,ticd_PHYEMACMCLKIN);
      VitalSignalDelay (PHYEMACMIITXCLK_dly,PHYEMACMIITXCLK_ipd,ticd_PHYEMACMIITXCLK);
      VitalSignalDelay (PHYEMACRXCLK_dly,PHYEMACRXCLK_ipd,ticd_PHYEMACRXCLK);
      VitalSignalDelay (PHYEMACTXGMIIMIICLKIN_dly,PHYEMACTXGMIIMIICLKIN_ipd,ticd_PHYEMACTXGMIIMIICLKIN);
    end block;

    SELECTPROC: process (
      PHYEMACCOL_PHYEMACRXCLK_dly,
      PHYEMACCOL_PHYEMACGTXCLK_dly,
      PHYEMACCRS_PHYEMACRXCLK_dly,
      PHYEMACCRS_PHYEMACGTXCLK_dly,
      PHYEMACMDIN_PHYEMACMCLKIN_dly,
      PHYEMACMDIN_HOSTCLK_dly,
      PHYEMACRXBUFSTATUS_PHYEMACRXCLK_dly,
      PHYEMACRXBUFSTATUS_PHYEMACGTXCLK_dly,
      PHYEMACRXCHARISCOMMA_PHYEMACRXCLK_dly,
      PHYEMACRXCHARISCOMMA_PHYEMACGTXCLK_dly,
      PHYEMACRXCHARISK_PHYEMACRXCLK_dly,
      PHYEMACRXCHARISK_PHYEMACGTXCLK_dly,
      PHYEMACRXCLKCORCNT_PHYEMACRXCLK_dly,
      PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_dly,
      PHYEMACRXD_PHYEMACRXCLK_dly,
      PHYEMACRXD_PHYEMACGTXCLK_dly,
      PHYEMACRXDISPERR_PHYEMACRXCLK_dly,
      PHYEMACRXDISPERR_PHYEMACGTXCLK_dly,
      PHYEMACRXDV_PHYEMACRXCLK_dly,
      PHYEMACRXDV_PHYEMACGTXCLK_dly,
      PHYEMACRXER_PHYEMACRXCLK_dly,
      PHYEMACRXER_PHYEMACGTXCLK_dly,
      PHYEMACRXNOTINTABLE_PHYEMACRXCLK_dly,
      PHYEMACRXNOTINTABLE_PHYEMACGTXCLK_dly,
      PHYEMACRXRUNDISP_PHYEMACRXCLK_dly,
      PHYEMACRXRUNDISP_PHYEMACGTXCLK_dly,
      PHYEMACSIGNALDET_PHYEMACRXCLK_dly,
      PHYEMACSIGNALDET_PHYEMACGTXCLK_dly,
      PHYEMACTXBUFERR_PHYEMACTXGMIIMIICLKIN_dly,
      PHYEMACTXBUFERR_PHYEMACGTXCLK_dly)
    begin
      PHYEMACRXBUFSTATUS_FOR: for i in 1 downto 0 loop
        PHYEMACRXBUFSTATUS_IF : if(abs(tisd_PHYEMACRXBUFSTATUS_PHYEMACRXCLK(i))> abs(tisd_PHYEMACRXBUFSTATUS_PHYEMACGTXCLK(i))) then
          PHYEMACRXBUFSTATUS_indelay(i) <= PHYEMACRXBUFSTATUS_PHYEMACRXCLK_dly(i);
        else
          PHYEMACRXBUFSTATUS_indelay(i) <= PHYEMACRXBUFSTATUS_PHYEMACGTXCLK_dly(i);
        end if;
      end loop;
      PHYEMACRXCLKCORCNT_FOR: for i in 2 downto 0 loop
        PHYEMACRXCLKCORCNT_IF : if(abs(tisd_PHYEMACRXCLKCORCNT_PHYEMACRXCLK(i))> abs(tisd_PHYEMACRXCLKCORCNT_PHYEMACGTXCLK(i))) then
          PHYEMACRXCLKCORCNT_indelay(i) <= PHYEMACRXCLKCORCNT_PHYEMACRXCLK_dly(i);
        else
          PHYEMACRXCLKCORCNT_indelay(i) <= PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_dly(i);
        end if;
      end loop;
      PHYEMACRXD_FOR: for i in 7 downto 0 loop
        PHYEMACRXD_IF : if(abs(tisd_PHYEMACRXD_PHYEMACRXCLK(i))> abs(tisd_PHYEMACRXD_PHYEMACGTXCLK(i))) then
          PHYEMACRXD_indelay(i) <= PHYEMACRXD_PHYEMACRXCLK_dly(i);
        else
          PHYEMACRXD_indelay(i) <= PHYEMACRXD_PHYEMACGTXCLK_dly(i);
        end if;
      end loop;
      if(abs(tisd_PHYEMACCOL_PHYEMACRXCLK) > abs(tisd_PHYEMACCOL_PHYEMACGTXCLK)) then
        PHYEMACCOL_indelay <= PHYEMACCOL_PHYEMACRXCLK_dly;
      else
        PHYEMACCOL_indelay <= PHYEMACCOL_PHYEMACGTXCLK_dly;
      end if;
      if(abs(tisd_PHYEMACCRS_PHYEMACRXCLK) > abs(tisd_PHYEMACCRS_PHYEMACGTXCLK)) then
        PHYEMACCRS_indelay <= PHYEMACCRS_PHYEMACRXCLK_dly;
      else
        PHYEMACCRS_indelay <= PHYEMACCRS_PHYEMACGTXCLK_dly;
      end if;
      if(abs(tisd_PHYEMACMDIN_PHYEMACMCLKIN) > abs(tisd_PHYEMACMDIN_HOSTCLK)) then
        PHYEMACMDIN_indelay <= PHYEMACMDIN_PHYEMACMCLKIN_dly;
      else
        PHYEMACMDIN_indelay <= PHYEMACMDIN_HOSTCLK_dly;
      end if;
      if(abs(tisd_PHYEMACRXCHARISCOMMA_PHYEMACRXCLK) > abs(tisd_PHYEMACRXCHARISCOMMA_PHYEMACGTXCLK)) then
        PHYEMACRXCHARISCOMMA_indelay <= PHYEMACRXCHARISCOMMA_PHYEMACRXCLK_dly;
      else
        PHYEMACRXCHARISCOMMA_indelay <= PHYEMACRXCHARISCOMMA_PHYEMACGTXCLK_dly;
      end if;
      if(abs(tisd_PHYEMACRXCHARISK_PHYEMACRXCLK) > abs(tisd_PHYEMACRXCHARISK_PHYEMACGTXCLK)) then
        PHYEMACRXCHARISK_indelay <= PHYEMACRXCHARISK_PHYEMACRXCLK_dly;
      else
        PHYEMACRXCHARISK_indelay <= PHYEMACRXCHARISK_PHYEMACGTXCLK_dly;
      end if;
      if(abs(tisd_PHYEMACRXDISPERR_PHYEMACRXCLK) > abs(tisd_PHYEMACRXDISPERR_PHYEMACGTXCLK)) then
        PHYEMACRXDISPERR_indelay <= PHYEMACRXDISPERR_PHYEMACRXCLK_dly;
      else
        PHYEMACRXDISPERR_indelay <= PHYEMACRXDISPERR_PHYEMACGTXCLK_dly;
      end if;
      if(abs(tisd_PHYEMACRXDV_PHYEMACRXCLK) > abs(tisd_PHYEMACRXDV_PHYEMACGTXCLK)) then
        PHYEMACRXDV_indelay <= PHYEMACRXDV_PHYEMACRXCLK_dly;
      else
        PHYEMACRXDV_indelay <= PHYEMACRXDV_PHYEMACGTXCLK_dly;
      end if;
      if(abs(tisd_PHYEMACRXER_PHYEMACRXCLK) > abs(tisd_PHYEMACRXER_PHYEMACGTXCLK)) then
        PHYEMACRXER_indelay <= PHYEMACRXER_PHYEMACRXCLK_dly;
      else
        PHYEMACRXER_indelay <= PHYEMACRXER_PHYEMACGTXCLK_dly;
      end if;
      if(abs(tisd_PHYEMACRXNOTINTABLE_PHYEMACRXCLK) > abs(tisd_PHYEMACRXNOTINTABLE_PHYEMACGTXCLK)) then
        PHYEMACRXNOTINTABLE_indelay <= PHYEMACRXNOTINTABLE_PHYEMACRXCLK_dly;
      else
        PHYEMACRXNOTINTABLE_indelay <= PHYEMACRXNOTINTABLE_PHYEMACGTXCLK_dly;
      end if;
      if(abs(tisd_PHYEMACRXRUNDISP_PHYEMACRXCLK) > abs(tisd_PHYEMACRXRUNDISP_PHYEMACGTXCLK)) then
        PHYEMACRXRUNDISP_indelay <= PHYEMACRXRUNDISP_PHYEMACRXCLK_dly;
      else
        PHYEMACRXRUNDISP_indelay <= PHYEMACRXRUNDISP_PHYEMACGTXCLK_dly;
      end if;
      if(abs(tisd_PHYEMACSIGNALDET_PHYEMACRXCLK) > abs(tisd_PHYEMACSIGNALDET_PHYEMACGTXCLK)) then
        PHYEMACSIGNALDET_indelay <= PHYEMACSIGNALDET_PHYEMACRXCLK_dly;
      else
        PHYEMACSIGNALDET_indelay <= PHYEMACSIGNALDET_PHYEMACGTXCLK_dly;
      end if;
      if(abs(tisd_PHYEMACTXBUFERR_PHYEMACTXGMIIMIICLKIN) > abs(tisd_PHYEMACTXBUFERR_PHYEMACGTXCLK)) then
        PHYEMACTXBUFERR_indelay <= PHYEMACTXBUFERR_PHYEMACTXGMIIMIICLKIN_dly;
      else
        PHYEMACTXBUFERR_indelay <= PHYEMACTXBUFERR_PHYEMACGTXCLK_dly;
      end if;
      end process SELECTPROC;

      --Input ports sensitive to single clock
      DCREMACABUS_indelay <= DCREMACABUS_DCREMACCLK_dly;
      DCREMACDBUS_indelay <= DCREMACDBUS_DCREMACCLK_dly;
      DCREMACENABLE_indelay <= DCREMACENABLE_DCREMACCLK_dly;
      DCREMACREAD_indelay <= DCREMACREAD_DCREMACCLK_dly;
      DCREMACWRITE_indelay <= DCREMACWRITE_DCREMACCLK_dly;
      HOSTADDR_indelay <= HOSTADDR_HOSTCLK_dly;
      HOSTMIIMSEL_indelay <= HOSTMIIMSEL_HOSTCLK_dly;
      HOSTOPCODE_indelay <= HOSTOPCODE_HOSTCLK_dly;
      HOSTREQ_indelay <= HOSTREQ_HOSTCLK_dly;
      HOSTWRDATA_indelay <= HOSTWRDATA_HOSTCLK_dly;
      PHYEMACPHYAD_indelay <= PHYEMACPHYAD_HOSTCLK_dly;
      
      --Input ports sensitive to more than two clocks
      CLIENTEMACDCMLOCKED_indelay <= CLIENTEMACDCMLOCKED_ipd;
      CLIENTEMACPAUSEREQ_indelay <= CLIENTEMACPAUSEREQ_ipd;
      CLIENTEMACPAUSEVAL_indelay <= CLIENTEMACPAUSEVAL_ipd;
      CLIENTEMACTXDVLDMSW_indelay <= CLIENTEMACTXDVLDMSW_ipd;
      CLIENTEMACTXDVLD_indelay <= CLIENTEMACTXDVLD_ipd;
      CLIENTEMACTXD_indelay <= CLIENTEMACTXD_ipd;
      CLIENTEMACTXFIRSTBYTE_indelay <= CLIENTEMACTXFIRSTBYTE_ipd;
      CLIENTEMACTXIFGDELAY_indelay <= CLIENTEMACTXIFGDELAY_ipd;
      CLIENTEMACTXUNDERRUN_indelay <= CLIENTEMACTXUNDERRUN_ipd;
      RESET_indelay <= RESET_ipd;
      
      CLIENTEMACRXCLIENTCLKIN_indelay <= CLIENTEMACRXCLIENTCLKIN_dly;
      CLIENTEMACTXCLIENTCLKIN_indelay <= CLIENTEMACTXCLIENTCLKIN_dly;
      DCREMACCLK_indelay <= DCREMACCLK_dly;
      HOSTCLK_indelay <= HOSTCLK_dly;
      PHYEMACGTXCLK_indelay <= PHYEMACGTXCLK_dly;
      PHYEMACMCLKIN_indelay <= PHYEMACMCLKIN_dly;
      PHYEMACMIITXCLK_indelay <= PHYEMACMIITXCLK_dly;
      PHYEMACRXCLK_indelay <= PHYEMACRXCLK_dly;
      PHYEMACTXGMIIMIICLKIN_indelay <= PHYEMACTXGMIIMIICLKIN_dly;
      
      DCRHOSTDONEIR_out <= DCRHOSTDONEIR_outdelay after OUT_DELAY;
      EMACCLIENTANINTERRUPT_out <= EMACCLIENTANINTERRUPT_outdelay after OUT_DELAY;
      EMACCLIENTRXBADFRAME_out <= EMACCLIENTRXBADFRAME_outdelay after OUT_DELAY;
      EMACCLIENTRXCLIENTCLKOUT_out <= EMACCLIENTRXCLIENTCLKOUT_outdelay after OUT_DELAY;
      EMACCLIENTRXDVLDMSW_out <= EMACCLIENTRXDVLDMSW_outdelay after OUT_DELAY;
      EMACCLIENTRXDVLD_out <= EMACCLIENTRXDVLD_outdelay after OUT_DELAY;
      EMACCLIENTRXD_out <= EMACCLIENTRXD_outdelay after OUT_DELAY;
      EMACCLIENTRXFRAMEDROP_out <= EMACCLIENTRXFRAMEDROP_outdelay after OUT_DELAY;
      EMACCLIENTRXGOODFRAME_out <= EMACCLIENTRXGOODFRAME_outdelay after OUT_DELAY;
      EMACCLIENTRXSTATSBYTEVLD_out <= EMACCLIENTRXSTATSBYTEVLD_outdelay after OUT_DELAY;
      EMACCLIENTRXSTATSVLD_out <= EMACCLIENTRXSTATSVLD_outdelay after OUT_DELAY;
      EMACCLIENTRXSTATS_out <= EMACCLIENTRXSTATS_outdelay after OUT_DELAY;
      EMACCLIENTTXACK_out <= EMACCLIENTTXACK_outdelay after OUT_DELAY;
      EMACCLIENTTXCLIENTCLKOUT_out <= EMACCLIENTTXCLIENTCLKOUT_outdelay after OUT_DELAY;
      EMACCLIENTTXCOLLISION_out <= EMACCLIENTTXCOLLISION_outdelay after OUT_DELAY;
      EMACCLIENTTXRETRANSMIT_out <= EMACCLIENTTXRETRANSMIT_outdelay after OUT_DELAY;
      EMACCLIENTTXSTATSBYTEVLD_out <= EMACCLIENTTXSTATSBYTEVLD_outdelay after OUT_DELAY;
      EMACCLIENTTXSTATSVLD_out <= EMACCLIENTTXSTATSVLD_outdelay after OUT_DELAY;
      EMACCLIENTTXSTATS_out <= EMACCLIENTTXSTATS_outdelay after OUT_DELAY;
      EMACDCRACK_out <= EMACDCRACK_outdelay after OUT_DELAY;
      EMACDCRDBUS_out <= EMACDCRDBUS_outdelay after OUT_DELAY;
      EMACPHYENCOMMAALIGN_out <= EMACPHYENCOMMAALIGN_outdelay after OUT_DELAY;
      EMACPHYLOOPBACKMSB_out <= EMACPHYLOOPBACKMSB_outdelay after OUT_DELAY;
      EMACPHYMCLKOUT_out <= EMACPHYMCLKOUT_outdelay after OUT_DELAY;
      EMACPHYMDOUT_out <= EMACPHYMDOUT_outdelay after OUT_DELAY;
      EMACPHYMDTRI_out <= EMACPHYMDTRI_outdelay after OUT_DELAY;
      EMACPHYMGTRXRESET_out <= EMACPHYMGTRXRESET_outdelay after OUT_DELAY;
      EMACPHYMGTTXRESET_out <= EMACPHYMGTTXRESET_outdelay after OUT_DELAY;
      EMACPHYPOWERDOWN_out <= EMACPHYPOWERDOWN_outdelay after OUT_DELAY;
      EMACPHYSYNCACQSTATUS_out <= EMACPHYSYNCACQSTATUS_outdelay after OUT_DELAY;
      EMACPHYTXCHARDISPMODE_out <= EMACPHYTXCHARDISPMODE_outdelay after OUT_DELAY;
      EMACPHYTXCHARDISPVAL_out <= EMACPHYTXCHARDISPVAL_outdelay after OUT_DELAY;
      EMACPHYTXCHARISK_out <= EMACPHYTXCHARISK_outdelay after OUT_DELAY;
      EMACPHYTXCLK_out <= EMACPHYTXCLK_outdelay after OUT_DELAY;
      EMACPHYTXD_out <= EMACPHYTXD_outdelay after OUT_DELAY;
      EMACPHYTXEN_out <= EMACPHYTXEN_outdelay after OUT_DELAY;
      EMACPHYTXER_out <= EMACPHYTXER_outdelay after OUT_DELAY;
      EMACPHYTXGMIIMIICLKOUT_out <= EMACPHYTXGMIIMIICLKOUT_outdelay after OUT_DELAY;
      EMACSPEEDIS10100_out <= EMACSPEEDIS10100_outdelay after OUT_DELAY;
      HOSTMIIMRDY_out <= HOSTMIIMRDY_outdelay after OUT_DELAY;
      HOSTRDDATA_out <= HOSTRDDATA_outdelay after OUT_DELAY;
      
      CLIENTEMACRXCLIENTCLKIN_indly <= CLIENTEMACRXCLIENTCLKIN_indelay after INCLK_DELAY;
      CLIENTEMACTXCLIENTCLKIN_indly <= CLIENTEMACTXCLIENTCLKIN_indelay after INCLK_DELAY;
      DCREMACCLK_indly <= DCREMACCLK_indelay after INCLK_DELAY;
      HOSTCLK_indly <= HOSTCLK_indelay after INCLK_DELAY;
      PHYEMACGTXCLK_indly <= PHYEMACGTXCLK_indelay after INCLK_DELAY;
      PHYEMACMCLKIN_indly <= PHYEMACMCLKIN_indelay after INCLK_DELAY;
      PHYEMACMIITXCLK_indly <= PHYEMACMIITXCLK_indelay after EMACMIITXCLK_DELAY;
      PHYEMACRXCLK_indly <= PHYEMACRXCLK_indelay after INCLK_DELAY;
      PHYEMACTXGMIIMIICLKIN_indly <= PHYEMACTXGMIIMIICLKIN_indelay after INCLK_DELAY;
      
      CLIENTEMACDCMLOCKED_indly <= CLIENTEMACDCMLOCKED_indelay after IN_DELAY;
      CLIENTEMACPAUSEREQ_indly <= CLIENTEMACPAUSEREQ_indelay after IN_DELAY;
      CLIENTEMACPAUSEVAL_indly <= CLIENTEMACPAUSEVAL_indelay after IN_DELAY;
      CLIENTEMACTXDVLDMSW_indly <= CLIENTEMACTXDVLDMSW_indelay after IN_DELAY;
      CLIENTEMACTXDVLD_indly <= CLIENTEMACTXDVLD_indelay after IN_DELAY;
      CLIENTEMACTXD_indly <= CLIENTEMACTXD_indelay after IN_DELAY;
      CLIENTEMACTXFIRSTBYTE_indly <= CLIENTEMACTXFIRSTBYTE_indelay after IN_DELAY;
      CLIENTEMACTXIFGDELAY_indly <= CLIENTEMACTXIFGDELAY_indelay after IN_DELAY;
      CLIENTEMACTXUNDERRUN_indly <= CLIENTEMACTXUNDERRUN_indelay after IN_DELAY;
      DCREMACABUS_indly <= DCREMACABUS_indelay after IN_DELAY;
      DCREMACDBUS_indly <= DCREMACDBUS_indelay after IN_DELAY;
      DCREMACENABLE_indly <= DCREMACENABLE_indelay after IN_DELAY;
      DCREMACREAD_indly <= DCREMACREAD_indelay after IN_DELAY;
      DCREMACWRITE_indly <= DCREMACWRITE_indelay after IN_DELAY;
      HOSTADDR_indly <= HOSTADDR_indelay after IN_DELAY;
      HOSTMIIMSEL_indly <= HOSTMIIMSEL_indelay after IN_DELAY;
      HOSTOPCODE_indly <= HOSTOPCODE_indelay after IN_DELAY;
      HOSTREQ_indly <= HOSTREQ_indelay after IN_DELAY;
      HOSTWRDATA_indly <= HOSTWRDATA_indelay after IN_DELAY;
      PHYEMACCOL_indly <= PHYEMACCOL_indelay after IN_DELAY;
      PHYEMACCRS_indly <= PHYEMACCRS_indelay after IN_DELAY;
      PHYEMACMDIN_indly <= PHYEMACMDIN_indelay after IN_DELAY;
      PHYEMACPHYAD_indly <= PHYEMACPHYAD_indelay after IN_DELAY;
      PHYEMACRXBUFSTATUS_indly <= PHYEMACRXBUFSTATUS_indelay after IN_DELAY;
      PHYEMACRXCHARISCOMMA_indly <= PHYEMACRXCHARISCOMMA_indelay after IN_DELAY;
      PHYEMACRXCHARISK_indly <= PHYEMACRXCHARISK_indelay after IN_DELAY;
      PHYEMACRXCLKCORCNT_indly <= PHYEMACRXCLKCORCNT_indelay after IN_DELAY;
      PHYEMACRXDISPERR_indly <= PHYEMACRXDISPERR_indelay after IN_DELAY;
      PHYEMACRXDV_indly <= PHYEMACRXDV_indelay after IN_DELAY;
      PHYEMACRXD_indly <= PHYEMACRXD_indelay after IN_DELAY;
      PHYEMACRXER_indly <= PHYEMACRXER_indelay after IN_DELAY;
      PHYEMACRXNOTINTABLE_indly <= PHYEMACRXNOTINTABLE_indelay after IN_DELAY;
      PHYEMACRXRUNDISP_indly <= PHYEMACRXRUNDISP_indelay after IN_DELAY;
      PHYEMACSIGNALDET_indly <= PHYEMACSIGNALDET_indelay after IN_DELAY;
      PHYEMACTXBUFERR_indly <= PHYEMACTXBUFERR_indelay after IN_DELAY;
      RESET_indly <= RESET_indelay after IN_DELAY;

-- <!--Aldec correction start
	GSR_local <= GSR;
-- Aldec correction end -->

      TEMAC_SINGLE_INST : TEMAC_SINGLE_WRAP
        generic map (
        EMAC_1000BASEX_ENABLE => EMAC_1000BASEX_ENABLE_STRING,
        EMAC_ADDRFILTER_ENABLE => EMAC_ADDRFILTER_ENABLE_STRING,
        EMAC_BYTEPHY         => EMAC_BYTEPHY_STRING,
        EMAC_CTRLLENCHECK_DISABLE => EMAC_CTRLLENCHECK_DISABLE_STRING,
        EMAC_DCRBASEADDR     => EMAC_DCRBASEADDR_STRING,
        EMAC_GTLOOPBACK      => EMAC_GTLOOPBACK_STRING,
        EMAC_HOST_ENABLE     => EMAC_HOST_ENABLE_STRING,
        EMAC_LINKTIMERVAL    => EMAC_LINKTIMERVAL_STRING,
        EMAC_LTCHECK_DISABLE => EMAC_LTCHECK_DISABLE_STRING,
        EMAC_MDIO_ENABLE     => EMAC_MDIO_ENABLE_STRING,
        EMAC_MDIO_IGNORE_PHYADZERO => EMAC_MDIO_IGNORE_PHYADZERO_STRING,
        EMAC_PAUSEADDR       => EMAC_PAUSEADDR_STRING,
        EMAC_PHYINITAUTONEG_ENABLE => EMAC_PHYINITAUTONEG_ENABLE_STRING,
        EMAC_PHYISOLATE      => EMAC_PHYISOLATE_STRING,
        EMAC_PHYLOOPBACKMSB  => EMAC_PHYLOOPBACKMSB_STRING,
        EMAC_PHYPOWERDOWN    => EMAC_PHYPOWERDOWN_STRING,
        EMAC_PHYRESET        => EMAC_PHYRESET_STRING,
        EMAC_RGMII_ENABLE    => EMAC_RGMII_ENABLE_STRING,
        EMAC_RX16BITCLIENT_ENABLE => EMAC_RX16BITCLIENT_ENABLE_STRING,
        EMAC_RXFLOWCTRL_ENABLE => EMAC_RXFLOWCTRL_ENABLE_STRING,
        EMAC_RXHALFDUPLEX    => EMAC_RXHALFDUPLEX_STRING,
        EMAC_RXINBANDFCS_ENABLE => EMAC_RXINBANDFCS_ENABLE_STRING,
        EMAC_RXJUMBOFRAME_ENABLE => EMAC_RXJUMBOFRAME_ENABLE_STRING,
        EMAC_RXRESET         => EMAC_RXRESET_STRING,
        EMAC_RXVLAN_ENABLE   => EMAC_RXVLAN_ENABLE_STRING,
        EMAC_RX_ENABLE       => EMAC_RX_ENABLE_STRING,
        EMAC_SGMII_ENABLE    => EMAC_SGMII_ENABLE_STRING,
        EMAC_SPEED_LSB       => EMAC_SPEED_LSB_STRING,
        EMAC_SPEED_MSB       => EMAC_SPEED_MSB_STRING,
        EMAC_TX16BITCLIENT_ENABLE => EMAC_TX16BITCLIENT_ENABLE_STRING,
        EMAC_TXFLOWCTRL_ENABLE => EMAC_TXFLOWCTRL_ENABLE_STRING,
        EMAC_TXHALFDUPLEX    => EMAC_TXHALFDUPLEX_STRING,
        EMAC_TXIFGADJUST_ENABLE => EMAC_TXIFGADJUST_ENABLE_STRING,
        EMAC_TXINBANDFCS_ENABLE => EMAC_TXINBANDFCS_ENABLE_STRING,
        EMAC_TXJUMBOFRAME_ENABLE => EMAC_TXJUMBOFRAME_ENABLE_STRING,
        EMAC_TXRESET         => EMAC_TXRESET_STRING,
        EMAC_TXVLAN_ENABLE   => EMAC_TXVLAN_ENABLE_STRING,
        EMAC_TX_ENABLE       => EMAC_TX_ENABLE_STRING,
        EMAC_UNICASTADDR     => EMAC_UNICASTADDR_STRING,
        EMAC_UNIDIRECTION_ENABLE => EMAC_UNIDIRECTION_ENABLE_STRING,
        EMAC_USECLKEN        => EMAC_USECLKEN_STRING
         )

        port map (
-- <!--Aldec correction start        
        GSR => GSR_local,
-- Aldec correction end -->
          DCRHOSTDONEIR        => DCRHOSTDONEIR_outdelay,
          EMACCLIENTANINTERRUPT => EMACCLIENTANINTERRUPT_outdelay,
          EMACCLIENTRXBADFRAME => EMACCLIENTRXBADFRAME_outdelay,
          EMACCLIENTRXCLIENTCLKOUT => EMACCLIENTRXCLIENTCLKOUT_outdelay,
          EMACCLIENTRXD        => EMACCLIENTRXD_outdelay,
          EMACCLIENTRXDVLD     => EMACCLIENTRXDVLD_outdelay,
          EMACCLIENTRXDVLDMSW  => EMACCLIENTRXDVLDMSW_outdelay,
          EMACCLIENTRXFRAMEDROP => EMACCLIENTRXFRAMEDROP_outdelay,
          EMACCLIENTRXGOODFRAME => EMACCLIENTRXGOODFRAME_outdelay,
          EMACCLIENTRXSTATS    => EMACCLIENTRXSTATS_outdelay,
          EMACCLIENTRXSTATSBYTEVLD => EMACCLIENTRXSTATSBYTEVLD_outdelay,
          EMACCLIENTRXSTATSVLD => EMACCLIENTRXSTATSVLD_outdelay,
          EMACCLIENTTXACK      => EMACCLIENTTXACK_outdelay,
          EMACCLIENTTXCLIENTCLKOUT => EMACCLIENTTXCLIENTCLKOUT_outdelay,
          EMACCLIENTTXCOLLISION => EMACCLIENTTXCOLLISION_outdelay,
          EMACCLIENTTXRETRANSMIT => EMACCLIENTTXRETRANSMIT_outdelay,
          EMACCLIENTTXSTATS    => EMACCLIENTTXSTATS_outdelay,
          EMACCLIENTTXSTATSBYTEVLD => EMACCLIENTTXSTATSBYTEVLD_outdelay,
          EMACCLIENTTXSTATSVLD => EMACCLIENTTXSTATSVLD_outdelay,
          EMACDCRACK           => EMACDCRACK_outdelay,
          EMACDCRDBUS          => EMACDCRDBUS_outdelay,
          EMACPHYENCOMMAALIGN  => EMACPHYENCOMMAALIGN_outdelay,
          EMACPHYLOOPBACKMSB   => EMACPHYLOOPBACKMSB_outdelay,
          EMACPHYMCLKOUT       => EMACPHYMCLKOUT_outdelay,
          EMACPHYMDOUT         => EMACPHYMDOUT_outdelay,
          EMACPHYMDTRI         => EMACPHYMDTRI_outdelay,
          EMACPHYMGTRXRESET    => EMACPHYMGTRXRESET_outdelay,
          EMACPHYMGTTXRESET    => EMACPHYMGTTXRESET_outdelay,
          EMACPHYPOWERDOWN     => EMACPHYPOWERDOWN_outdelay,
          EMACPHYSYNCACQSTATUS => EMACPHYSYNCACQSTATUS_outdelay,
          EMACPHYTXCHARDISPMODE => EMACPHYTXCHARDISPMODE_outdelay,
          EMACPHYTXCHARDISPVAL => EMACPHYTXCHARDISPVAL_outdelay,
          EMACPHYTXCHARISK     => EMACPHYTXCHARISK_outdelay,
          EMACPHYTXCLK         => EMACPHYTXCLK_outdelay,
          EMACPHYTXD           => EMACPHYTXD_outdelay,
          EMACPHYTXEN          => EMACPHYTXEN_outdelay,
          EMACPHYTXER          => EMACPHYTXER_outdelay,
          EMACPHYTXGMIIMIICLKOUT => EMACPHYTXGMIIMIICLKOUT_outdelay,
          EMACSPEEDIS10100     => EMACSPEEDIS10100_outdelay,
          HOSTMIIMRDY          => HOSTMIIMRDY_outdelay,
          HOSTRDDATA           => HOSTRDDATA_outdelay,
          CLIENTEMACDCMLOCKED  => CLIENTEMACDCMLOCKED_indly,
          CLIENTEMACPAUSEREQ   => CLIENTEMACPAUSEREQ_indly,
          CLIENTEMACPAUSEVAL   => CLIENTEMACPAUSEVAL_indly,
          CLIENTEMACRXCLIENTCLKIN => CLIENTEMACRXCLIENTCLKIN_indly,
          CLIENTEMACTXCLIENTCLKIN => CLIENTEMACTXCLIENTCLKIN_indly,
          CLIENTEMACTXD        => CLIENTEMACTXD_indly,
          CLIENTEMACTXDVLD     => CLIENTEMACTXDVLD_indly,
          CLIENTEMACTXDVLDMSW  => CLIENTEMACTXDVLDMSW_indly,
          CLIENTEMACTXFIRSTBYTE => CLIENTEMACTXFIRSTBYTE_indly,
          CLIENTEMACTXIFGDELAY => CLIENTEMACTXIFGDELAY_indly,
          CLIENTEMACTXUNDERRUN => CLIENTEMACTXUNDERRUN_indly,
          DCREMACABUS          => DCREMACABUS_indly,
          DCREMACCLK           => DCREMACCLK_indly,
          DCREMACDBUS          => DCREMACDBUS_indly,
          DCREMACENABLE        => DCREMACENABLE_indly,
          DCREMACREAD          => DCREMACREAD_indly,
          DCREMACWRITE         => DCREMACWRITE_indly,
          HOSTADDR             => HOSTADDR_indly,
          HOSTCLK              => HOSTCLK_indly,
          HOSTMIIMSEL          => HOSTMIIMSEL_indly,
          HOSTOPCODE           => HOSTOPCODE_indly,
          HOSTREQ              => HOSTREQ_indly,
          HOSTWRDATA           => HOSTWRDATA_indly,
          PHYEMACCOL           => PHYEMACCOL_indly,
          PHYEMACCRS           => PHYEMACCRS_indly,
          PHYEMACGTXCLK        => PHYEMACGTXCLK_indly,
          PHYEMACMCLKIN        => PHYEMACMCLKIN_indly,
          PHYEMACMDIN          => PHYEMACMDIN_indly,
          PHYEMACMIITXCLK      => PHYEMACMIITXCLK_indly,
          PHYEMACPHYAD         => PHYEMACPHYAD_indly,
          PHYEMACRXBUFSTATUS   => PHYEMACRXBUFSTATUS_indly,
          PHYEMACRXCHARISCOMMA => PHYEMACRXCHARISCOMMA_indly,
          PHYEMACRXCHARISK     => PHYEMACRXCHARISK_indly,
          PHYEMACRXCLK         => PHYEMACRXCLK_indly,
          PHYEMACRXCLKCORCNT   => PHYEMACRXCLKCORCNT_indly,
          PHYEMACRXD           => PHYEMACRXD_indly,
          PHYEMACRXDISPERR     => PHYEMACRXDISPERR_indly,
          PHYEMACRXDV          => PHYEMACRXDV_indly,
          PHYEMACRXER          => PHYEMACRXER_indly,
          PHYEMACRXNOTINTABLE  => PHYEMACRXNOTINTABLE_indly,
          PHYEMACRXRUNDISP     => PHYEMACRXRUNDISP_indly,
          PHYEMACSIGNALDET     => PHYEMACSIGNALDET_indly,
          PHYEMACTXBUFERR      => PHYEMACTXBUFERR_indly,
          PHYEMACTXGMIIMIICLKIN => PHYEMACTXGMIIMIICLKIN_indly,
          RESET                => RESET_indly          
        );
      
      INIPROC : process
      begin
      case EMAC_1000BASEX_ENABLE is
        when FALSE   =>  EMAC_1000BASEX_ENABLE_BINARY <= '0';
        when TRUE    =>  EMAC_1000BASEX_ENABLE_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_1000BASEX_ENABLE is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_ADDRFILTER_ENABLE is
        when FALSE   =>  EMAC_ADDRFILTER_ENABLE_BINARY <= '0';
        when TRUE    =>  EMAC_ADDRFILTER_ENABLE_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_ADDRFILTER_ENABLE is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_BYTEPHY is
        when FALSE   =>  EMAC_BYTEPHY_BINARY <= '0';
        when TRUE    =>  EMAC_BYTEPHY_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_BYTEPHY is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_CTRLLENCHECK_DISABLE is
        when FALSE   =>  EMAC_CTRLLENCHECK_DISABLE_BINARY <= '0';
        when TRUE    =>  EMAC_CTRLLENCHECK_DISABLE_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_CTRLLENCHECK_DISABLE is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_GTLOOPBACK is
        when FALSE   =>  EMAC_GTLOOPBACK_BINARY <= '0';
        when TRUE    =>  EMAC_GTLOOPBACK_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_GTLOOPBACK is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_HOST_ENABLE is
        when FALSE   =>  EMAC_HOST_ENABLE_BINARY <= '0';
        when TRUE    =>  EMAC_HOST_ENABLE_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_HOST_ENABLE is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_LTCHECK_DISABLE is
        when FALSE   =>  EMAC_LTCHECK_DISABLE_BINARY <= '0';
        when TRUE    =>  EMAC_LTCHECK_DISABLE_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_LTCHECK_DISABLE is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_MDIO_ENABLE is
        when FALSE   =>  EMAC_MDIO_ENABLE_BINARY <= '0';
        when TRUE    =>  EMAC_MDIO_ENABLE_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_MDIO_ENABLE is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_MDIO_IGNORE_PHYADZERO is
        when FALSE   =>  EMAC_MDIO_IGNORE_PHYADZERO_BINARY <= '0';
        when TRUE    =>  EMAC_MDIO_IGNORE_PHYADZERO_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_MDIO_IGNORE_PHYADZERO is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_PHYINITAUTONEG_ENABLE is
        when FALSE   =>  EMAC_PHYINITAUTONEG_ENABLE_BINARY <= '0';
        when TRUE    =>  EMAC_PHYINITAUTONEG_ENABLE_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_PHYINITAUTONEG_ENABLE is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_PHYISOLATE is
        when FALSE   =>  EMAC_PHYISOLATE_BINARY <= '0';
        when TRUE    =>  EMAC_PHYISOLATE_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_PHYISOLATE is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_PHYLOOPBACKMSB is
        when FALSE   =>  EMAC_PHYLOOPBACKMSB_BINARY <= '0';
        when TRUE    =>  EMAC_PHYLOOPBACKMSB_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_PHYLOOPBACKMSB is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_PHYPOWERDOWN is
        when FALSE   =>  EMAC_PHYPOWERDOWN_BINARY <= '0';
        when TRUE    =>  EMAC_PHYPOWERDOWN_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_PHYPOWERDOWN is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_PHYRESET is
        when FALSE   =>  EMAC_PHYRESET_BINARY <= '0';
        when TRUE    =>  EMAC_PHYRESET_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_PHYRESET is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_RGMII_ENABLE is
        when FALSE   =>  EMAC_RGMII_ENABLE_BINARY <= '0';
        when TRUE    =>  EMAC_RGMII_ENABLE_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_RGMII_ENABLE is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_RX16BITCLIENT_ENABLE is
        when FALSE   =>  EMAC_RX16BITCLIENT_ENABLE_BINARY <= '0';
        when TRUE    =>  EMAC_RX16BITCLIENT_ENABLE_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_RX16BITCLIENT_ENABLE is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_RXFLOWCTRL_ENABLE is
        when FALSE   =>  EMAC_RXFLOWCTRL_ENABLE_BINARY <= '0';
        when TRUE    =>  EMAC_RXFLOWCTRL_ENABLE_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_RXFLOWCTRL_ENABLE is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_RXHALFDUPLEX is
        when FALSE   =>  EMAC_RXHALFDUPLEX_BINARY <= '0';
        when TRUE    =>  EMAC_RXHALFDUPLEX_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_RXHALFDUPLEX is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_RXINBANDFCS_ENABLE is
        when FALSE   =>  EMAC_RXINBANDFCS_ENABLE_BINARY <= '0';
        when TRUE    =>  EMAC_RXINBANDFCS_ENABLE_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_RXINBANDFCS_ENABLE is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_RXJUMBOFRAME_ENABLE is
        when FALSE   =>  EMAC_RXJUMBOFRAME_ENABLE_BINARY <= '0';
        when TRUE    =>  EMAC_RXJUMBOFRAME_ENABLE_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_RXJUMBOFRAME_ENABLE is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_RXRESET is
        when FALSE   =>  EMAC_RXRESET_BINARY <= '0';
        when TRUE    =>  EMAC_RXRESET_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_RXRESET is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_RXVLAN_ENABLE is
        when FALSE   =>  EMAC_RXVLAN_ENABLE_BINARY <= '0';
        when TRUE    =>  EMAC_RXVLAN_ENABLE_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_RXVLAN_ENABLE is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_RX_ENABLE is
        when FALSE   =>  EMAC_RX_ENABLE_BINARY <= '0';
        when TRUE    =>  EMAC_RX_ENABLE_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_RX_ENABLE is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_SGMII_ENABLE is
        when FALSE   =>  EMAC_SGMII_ENABLE_BINARY <= '0';
        when TRUE    =>  EMAC_SGMII_ENABLE_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_SGMII_ENABLE is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_SPEED_LSB is
        when FALSE   =>  EMAC_SPEED_LSB_BINARY <= '0';
        when TRUE    =>  EMAC_SPEED_LSB_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_SPEED_LSB is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_SPEED_MSB is
        when FALSE   =>  EMAC_SPEED_MSB_BINARY <= '0';
        when TRUE    =>  EMAC_SPEED_MSB_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_SPEED_MSB is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_TX16BITCLIENT_ENABLE is
        when FALSE   =>  EMAC_TX16BITCLIENT_ENABLE_BINARY <= '0';
        when TRUE    =>  EMAC_TX16BITCLIENT_ENABLE_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_TX16BITCLIENT_ENABLE is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_TXFLOWCTRL_ENABLE is
        when FALSE   =>  EMAC_TXFLOWCTRL_ENABLE_BINARY <= '0';
        when TRUE    =>  EMAC_TXFLOWCTRL_ENABLE_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_TXFLOWCTRL_ENABLE is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_TXHALFDUPLEX is
        when FALSE   =>  EMAC_TXHALFDUPLEX_BINARY <= '0';
        when TRUE    =>  EMAC_TXHALFDUPLEX_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_TXHALFDUPLEX is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_TXIFGADJUST_ENABLE is
        when FALSE   =>  EMAC_TXIFGADJUST_ENABLE_BINARY <= '0';
        when TRUE    =>  EMAC_TXIFGADJUST_ENABLE_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_TXIFGADJUST_ENABLE is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_TXINBANDFCS_ENABLE is
        when FALSE   =>  EMAC_TXINBANDFCS_ENABLE_BINARY <= '0';
        when TRUE    =>  EMAC_TXINBANDFCS_ENABLE_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_TXINBANDFCS_ENABLE is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_TXJUMBOFRAME_ENABLE is
        when FALSE   =>  EMAC_TXJUMBOFRAME_ENABLE_BINARY <= '0';
        when TRUE    =>  EMAC_TXJUMBOFRAME_ENABLE_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_TXJUMBOFRAME_ENABLE is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_TXRESET is
        when FALSE   =>  EMAC_TXRESET_BINARY <= '0';
        when TRUE    =>  EMAC_TXRESET_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_TXRESET is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_TXVLAN_ENABLE is
        when FALSE   =>  EMAC_TXVLAN_ENABLE_BINARY <= '0';
        when TRUE    =>  EMAC_TXVLAN_ENABLE_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_TXVLAN_ENABLE is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_TX_ENABLE is
        when FALSE   =>  EMAC_TX_ENABLE_BINARY <= '0';
        when TRUE    =>  EMAC_TX_ENABLE_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_TX_ENABLE is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_UNIDIRECTION_ENABLE is
        when FALSE   =>  EMAC_UNIDIRECTION_ENABLE_BINARY <= '0';
        when TRUE    =>  EMAC_UNIDIRECTION_ENABLE_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_UNIDIRECTION_ENABLE is neither TRUE nor FALSE." severity error;
      end case;
      case EMAC_USECLKEN is
        when FALSE   =>  EMAC_USECLKEN_BINARY <= '0';
        when TRUE    =>  EMAC_USECLKEN_BINARY <= '1';
        when others  =>  assert FALSE report "Error : EMAC_USECLKEN is neither TRUE nor FALSE." severity error;
      end case;
      wait;
      end process INIPROC;
      
      TIMING : process
      variable Tmkr_CLIENTEMACDCMLOCKED_CLIENTEMACTXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_CLIENTEMACDCMLOCKED_PHYEMACMIITXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_CLIENTEMACDCMLOCKED_PHYEMACTXGMIIMIICLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_CLIENTEMACPAUSEREQ_CLIENTEMACTXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_CLIENTEMACPAUSEREQ_PHYEMACMIITXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_CLIENTEMACPAUSEREQ_PHYEMACTXGMIIMIICLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge : VitalTimingDataArrayType(15 downto 0);
      variable Tmkr_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge : VitalTimingDataArrayType(15 downto 0);
      variable Tmkr_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge : VitalTimingDataArrayType(15 downto 0);
      variable Tmkr_CLIENTEMACTXDVLDMSW_CLIENTEMACTXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_CLIENTEMACTXDVLDMSW_PHYEMACMIITXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_CLIENTEMACTXDVLDMSW_PHYEMACTXGMIIMIICLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_CLIENTEMACTXDVLD_CLIENTEMACTXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_CLIENTEMACTXDVLD_PHYEMACMIITXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_CLIENTEMACTXDVLD_PHYEMACTXGMIIMIICLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge : VitalTimingDataArrayType(15 downto 0);
      variable Tmkr_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge : VitalTimingDataArrayType(15 downto 0);
      variable Tmkr_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge : VitalTimingDataArrayType(15 downto 0);
      variable Tmkr_CLIENTEMACTXFIRSTBYTE_CLIENTEMACTXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_CLIENTEMACTXFIRSTBYTE_PHYEMACMIITXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_CLIENTEMACTXFIRSTBYTE_PHYEMACTXGMIIMIICLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge : VitalTimingDataArrayType(7 downto 0);
      variable Tmkr_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge : VitalTimingDataArrayType(7 downto 0);
      variable Tmkr_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge : VitalTimingDataArrayType(7 downto 0);
      variable Tmkr_CLIENTEMACTXUNDERRUN_CLIENTEMACTXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_CLIENTEMACTXUNDERRUN_PHYEMACMIITXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_CLIENTEMACTXUNDERRUN_PHYEMACTXGMIIMIICLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_DCREMACABUS_DCREMACCLK_posedge : VitalTimingDataArrayType(0 to 9);
      variable Tmkr_DCREMACDBUS_DCREMACCLK_posedge : VitalTimingDataArrayType(0 to 31);
      variable Tmkr_DCREMACENABLE_DCREMACCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_DCREMACREAD_DCREMACCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_DCREMACWRITE_DCREMACCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_HOSTADDR_HOSTCLK_posedge : VitalTimingDataArrayType(9 downto 0);
      variable Tmkr_HOSTMIIMSEL_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_HOSTOPCODE_HOSTCLK_posedge : VitalTimingDataArrayType(1 downto 0);
      variable Tmkr_HOSTREQ_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_HOSTWRDATA_HOSTCLK_posedge : VitalTimingDataArrayType(31 downto 0);
      variable Tmkr_PHYEMACCOL_PHYEMACGTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PHYEMACCOL_PHYEMACRXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PHYEMACCRS_PHYEMACGTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PHYEMACCRS_PHYEMACRXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PHYEMACMDIN_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PHYEMACMDIN_PHYEMACMCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PHYEMACPHYAD_HOSTCLK_posedge : VitalTimingDataArrayType(4 downto 0);
      variable Tmkr_PHYEMACRXBUFSTATUS_PHYEMACGTXCLK_posedge : VitalTimingDataArrayType(1 downto 0);
      variable Tmkr_PHYEMACRXBUFSTATUS_PHYEMACRXCLK_posedge : VitalTimingDataArrayType(1 downto 0);
      variable Tmkr_PHYEMACRXCHARISCOMMA_PHYEMACGTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PHYEMACRXCHARISCOMMA_PHYEMACRXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PHYEMACRXCHARISK_PHYEMACGTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PHYEMACRXCHARISK_PHYEMACRXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_posedge : VitalTimingDataArrayType(2 downto 0);
      variable Tmkr_PHYEMACRXCLKCORCNT_PHYEMACRXCLK_posedge : VitalTimingDataArrayType(2 downto 0);
      variable Tmkr_PHYEMACRXDISPERR_PHYEMACGTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PHYEMACRXDISPERR_PHYEMACRXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PHYEMACRXDV_PHYEMACGTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PHYEMACRXDV_PHYEMACRXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PHYEMACRXD_PHYEMACGTXCLK_posedge : VitalTimingDataArrayType(7 downto 0);
      variable Tmkr_PHYEMACRXD_PHYEMACRXCLK_negedge : VitalTimingDataArrayType(7 downto 0);
      variable Tmkr_PHYEMACRXD_PHYEMACRXCLK_posedge : VitalTimingDataArrayType(7 downto 0);
      variable Tmkr_PHYEMACRXER_PHYEMACGTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PHYEMACRXER_PHYEMACRXCLK_negedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PHYEMACRXER_PHYEMACRXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PHYEMACRXNOTINTABLE_PHYEMACGTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PHYEMACRXNOTINTABLE_PHYEMACRXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PHYEMACRXRUNDISP_PHYEMACGTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PHYEMACRXRUNDISP_PHYEMACRXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PHYEMACSIGNALDET_PHYEMACGTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PHYEMACSIGNALDET_PHYEMACRXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PHYEMACTXBUFERR_PHYEMACGTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_PHYEMACTXBUFERR_PHYEMACTXGMIIMIICLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_RESET_CLIENTEMACTXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_RESET_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_RESET_PHYEMACGTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_RESET_PHYEMACMIITXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tmkr_RESET_PHYEMACTXGMIIMIICLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
      variable Tviol_CLIENTEMACDCMLOCKED_CLIENTEMACTXCLIENTCLKIN_posedge :  std_ulogic := '0';
      variable Tviol_CLIENTEMACDCMLOCKED_PHYEMACMIITXCLK_posedge :  std_ulogic := '0';
      variable Tviol_CLIENTEMACDCMLOCKED_PHYEMACTXGMIIMIICLKIN_posedge :  std_ulogic := '0';
      variable Tviol_CLIENTEMACPAUSEREQ_CLIENTEMACTXCLIENTCLKIN_posedge :  std_ulogic := '0';
      variable Tviol_CLIENTEMACPAUSEREQ_PHYEMACMIITXCLK_posedge :  std_ulogic := '0';
      variable Tviol_CLIENTEMACPAUSEREQ_PHYEMACTXGMIIMIICLKIN_posedge :  std_ulogic := '0';
      variable Tviol_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge : std_logic_vector(15 downto 0) := (others => '0');
      variable Tviol_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge : std_logic_vector(15 downto 0) := (others => '0');
      variable Tviol_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge : std_logic_vector(15 downto 0) := (others => '0');
      variable Tviol_CLIENTEMACTXDVLDMSW_CLIENTEMACTXCLIENTCLKIN_posedge :  std_ulogic := '0';
      variable Tviol_CLIENTEMACTXDVLDMSW_PHYEMACMIITXCLK_posedge :  std_ulogic := '0';
      variable Tviol_CLIENTEMACTXDVLDMSW_PHYEMACTXGMIIMIICLKIN_posedge :  std_ulogic := '0';
      variable Tviol_CLIENTEMACTXDVLD_CLIENTEMACTXCLIENTCLKIN_posedge :  std_ulogic := '0';
      variable Tviol_CLIENTEMACTXDVLD_PHYEMACMIITXCLK_posedge :  std_ulogic := '0';
      variable Tviol_CLIENTEMACTXDVLD_PHYEMACTXGMIIMIICLKIN_posedge :  std_ulogic := '0';
      variable Tviol_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge : std_logic_vector(15 downto 0) := (others => '0');
      variable Tviol_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge : std_logic_vector(15 downto 0) := (others => '0');
      variable Tviol_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge : std_logic_vector(15 downto 0) := (others => '0');
      variable Tviol_CLIENTEMACTXFIRSTBYTE_CLIENTEMACTXCLIENTCLKIN_posedge :  std_ulogic := '0';
      variable Tviol_CLIENTEMACTXFIRSTBYTE_PHYEMACMIITXCLK_posedge :  std_ulogic := '0';
      variable Tviol_CLIENTEMACTXFIRSTBYTE_PHYEMACTXGMIIMIICLKIN_posedge :  std_ulogic := '0';
      variable Tviol_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge : std_logic_vector(7 downto 0) := (others => '0');
      variable Tviol_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge : std_logic_vector(7 downto 0) := (others => '0');
      variable Tviol_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge : std_logic_vector(7 downto 0) := (others => '0');
      variable Tviol_CLIENTEMACTXUNDERRUN_CLIENTEMACTXCLIENTCLKIN_posedge :  std_ulogic := '0';
      variable Tviol_CLIENTEMACTXUNDERRUN_PHYEMACMIITXCLK_posedge :  std_ulogic := '0';
      variable Tviol_CLIENTEMACTXUNDERRUN_PHYEMACTXGMIIMIICLKIN_posedge :  std_ulogic := '0';
      variable Tviol_DCREMACABUS_DCREMACCLK_posedge : std_logic_vector(0 to 9) := (others => '0');
      variable Tviol_DCREMACDBUS_DCREMACCLK_posedge : std_logic_vector(0 to 31) := (others => '0');
      variable Tviol_DCREMACENABLE_DCREMACCLK_posedge :  std_ulogic := '0';
      variable Tviol_DCREMACREAD_DCREMACCLK_posedge :  std_ulogic := '0';
      variable Tviol_DCREMACWRITE_DCREMACCLK_posedge :  std_ulogic := '0';
      variable Tviol_HOSTADDR_HOSTCLK_posedge : std_logic_vector(9 downto 0) := (others => '0');
      variable Tviol_HOSTMIIMSEL_HOSTCLK_posedge :  std_ulogic := '0';
      variable Tviol_HOSTOPCODE_HOSTCLK_posedge : std_logic_vector(1 downto 0) := (others => '0');
      variable Tviol_HOSTREQ_HOSTCLK_posedge :  std_ulogic := '0';
      variable Tviol_HOSTWRDATA_HOSTCLK_posedge : std_logic_vector(31 downto 0) := (others => '0');
      variable Tviol_PHYEMACCOL_PHYEMACGTXCLK_posedge :  std_ulogic := '0';
      variable Tviol_PHYEMACCOL_PHYEMACRXCLK_posedge :  std_ulogic := '0';
      variable Tviol_PHYEMACCRS_PHYEMACGTXCLK_posedge :  std_ulogic := '0';
      variable Tviol_PHYEMACCRS_PHYEMACRXCLK_posedge :  std_ulogic := '0';
      variable Tviol_PHYEMACMDIN_HOSTCLK_posedge :  std_ulogic := '0';
      variable Tviol_PHYEMACMDIN_PHYEMACMCLKIN_posedge :  std_ulogic := '0';
      variable Tviol_PHYEMACPHYAD_HOSTCLK_posedge : std_logic_vector(4 downto 0) := (others => '0');
      variable Tviol_PHYEMACRXBUFSTATUS_PHYEMACGTXCLK_posedge : std_logic_vector(1 downto 0) := (others => '0');
      variable Tviol_PHYEMACRXBUFSTATUS_PHYEMACRXCLK_posedge : std_logic_vector(1 downto 0) := (others => '0');
      variable Tviol_PHYEMACRXCHARISCOMMA_PHYEMACGTXCLK_posedge :  std_ulogic := '0';
      variable Tviol_PHYEMACRXCHARISCOMMA_PHYEMACRXCLK_posedge :  std_ulogic := '0';
      variable Tviol_PHYEMACRXCHARISK_PHYEMACGTXCLK_posedge :  std_ulogic := '0';
      variable Tviol_PHYEMACRXCHARISK_PHYEMACRXCLK_posedge :  std_ulogic := '0';
      variable Tviol_PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_posedge : std_logic_vector(2 downto 0) := (others => '0');
      variable Tviol_PHYEMACRXCLKCORCNT_PHYEMACRXCLK_posedge : std_logic_vector(2 downto 0) := (others => '0');
      variable Tviol_PHYEMACRXDISPERR_PHYEMACGTXCLK_posedge :  std_ulogic := '0';
      variable Tviol_PHYEMACRXDISPERR_PHYEMACRXCLK_posedge :  std_ulogic := '0';
      variable Tviol_PHYEMACRXDV_PHYEMACGTXCLK_posedge :  std_ulogic := '0';
      variable Tviol_PHYEMACRXDV_PHYEMACRXCLK_posedge :  std_ulogic := '0';
      variable Tviol_PHYEMACRXD_PHYEMACGTXCLK_posedge : std_logic_vector(7 downto 0) := (others => '0');
      variable Tviol_PHYEMACRXD_PHYEMACRXCLK_negedge : std_logic_vector(7 downto 0) := (others => '0');
      variable Tviol_PHYEMACRXD_PHYEMACRXCLK_posedge : std_logic_vector(7 downto 0) := (others => '0');
      variable Tviol_PHYEMACRXER_PHYEMACGTXCLK_posedge :  std_ulogic := '0';
      variable Tviol_PHYEMACRXER_PHYEMACRXCLK_negedge :  std_ulogic := '0';
      variable Tviol_PHYEMACRXER_PHYEMACRXCLK_posedge :  std_ulogic := '0';
      variable Tviol_PHYEMACRXNOTINTABLE_PHYEMACGTXCLK_posedge :  std_ulogic := '0';
      variable Tviol_PHYEMACRXNOTINTABLE_PHYEMACRXCLK_posedge :  std_ulogic := '0';
      variable Tviol_PHYEMACRXRUNDISP_PHYEMACGTXCLK_posedge :  std_ulogic := '0';
      variable Tviol_PHYEMACRXRUNDISP_PHYEMACRXCLK_posedge :  std_ulogic := '0';
      variable Tviol_PHYEMACSIGNALDET_PHYEMACGTXCLK_posedge :  std_ulogic := '0';
      variable Tviol_PHYEMACSIGNALDET_PHYEMACRXCLK_posedge :  std_ulogic := '0';
      variable Tviol_PHYEMACTXBUFERR_PHYEMACGTXCLK_posedge :  std_ulogic := '0';
      variable Tviol_PHYEMACTXBUFERR_PHYEMACTXGMIIMIICLKIN_posedge :  std_ulogic := '0';
      variable Tviol_RESET_CLIENTEMACTXCLIENTCLKIN_posedge :  std_ulogic := '0';
      variable Tviol_RESET_HOSTCLK_posedge :  std_ulogic := '0';
      variable Tviol_RESET_PHYEMACGTXCLK_posedge :  std_ulogic := '0';
      variable Tviol_RESET_PHYEMACMIITXCLK_posedge :  std_ulogic := '0';
      variable Tviol_RESET_PHYEMACTXGMIIMIICLKIN_posedge :  std_ulogic := '0';
      variable DCRHOSTDONEIR_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTANINTERRUPT_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTRXBADFRAME_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTRXCLIENTCLKOUT_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTRXD0_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTRXD10_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTRXD11_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTRXD12_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTRXD13_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTRXD14_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTRXD15_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTRXD1_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTRXD2_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTRXD3_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTRXD4_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTRXD5_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTRXD6_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTRXD7_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTRXD8_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTRXD9_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTRXDVLDMSW_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTRXDVLD_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTRXFRAMEDROP_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTRXGOODFRAME_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTRXSTATS0_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTRXSTATS1_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTRXSTATS2_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTRXSTATS3_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTRXSTATS4_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTRXSTATS5_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTRXSTATS6_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTRXSTATSBYTEVLD_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTRXSTATSVLD_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTTXACK_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTTXCLIENTCLKOUT_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTTXCOLLISION_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTTXRETRANSMIT_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTTXSTATSBYTEVLD_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTTXSTATSVLD_GlitchData : VitalGlitchDataType;
      variable EMACCLIENTTXSTATS_GlitchData : VitalGlitchDataType;
      variable EMACDCRACK_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS0_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS10_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS11_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS12_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS13_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS14_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS15_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS16_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS17_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS18_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS19_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS1_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS20_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS21_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS22_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS23_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS24_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS25_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS26_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS27_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS28_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS29_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS2_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS30_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS31_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS3_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS4_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS5_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS6_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS7_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS8_GlitchData : VitalGlitchDataType;
      variable EMACDCRDBUS9_GlitchData : VitalGlitchDataType;
      variable EMACPHYENCOMMAALIGN_GlitchData : VitalGlitchDataType;
      variable EMACPHYLOOPBACKMSB_GlitchData : VitalGlitchDataType;
      variable EMACPHYMCLKOUT_GlitchData : VitalGlitchDataType;
      variable EMACPHYMDOUT_GlitchData : VitalGlitchDataType;
      variable EMACPHYMDTRI_GlitchData : VitalGlitchDataType;
      variable EMACPHYMGTRXRESET_GlitchData : VitalGlitchDataType;
      variable EMACPHYMGTTXRESET_GlitchData : VitalGlitchDataType;
      variable EMACPHYPOWERDOWN_GlitchData : VitalGlitchDataType;
      variable EMACPHYSYNCACQSTATUS_GlitchData : VitalGlitchDataType;
      variable EMACPHYTXCHARDISPMODE_GlitchData : VitalGlitchDataType;
      variable EMACPHYTXCHARDISPVAL_GlitchData : VitalGlitchDataType;
      variable EMACPHYTXCHARISK_GlitchData : VitalGlitchDataType;
      variable EMACPHYTXCLK_GlitchData : VitalGlitchDataType;
      variable EMACPHYTXD0_GlitchData : VitalGlitchDataType;
      variable EMACPHYTXD1_GlitchData : VitalGlitchDataType;
      variable EMACPHYTXD2_GlitchData : VitalGlitchDataType;
      variable EMACPHYTXD3_GlitchData : VitalGlitchDataType;
      variable EMACPHYTXD4_GlitchData : VitalGlitchDataType;
      variable EMACPHYTXD5_GlitchData : VitalGlitchDataType;
      variable EMACPHYTXD6_GlitchData : VitalGlitchDataType;
      variable EMACPHYTXD7_GlitchData : VitalGlitchDataType;
      variable EMACPHYTXEN_GlitchData : VitalGlitchDataType;
      variable EMACPHYTXER_GlitchData : VitalGlitchDataType;
      variable EMACPHYTXGMIIMIICLKOUT_GlitchData : VitalGlitchDataType;
      variable EMACSPEEDIS10100_GlitchData : VitalGlitchDataType;
      variable HOSTMIIMRDY_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA0_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA10_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA11_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA12_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA13_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA14_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA15_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA16_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA17_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA18_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA19_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA1_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA20_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA21_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA22_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA23_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA24_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA25_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA26_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA27_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA28_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA29_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA2_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA30_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA31_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA3_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA4_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA5_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA6_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA7_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA8_GlitchData : VitalGlitchDataType;
      variable HOSTRDDATA9_GlitchData : VitalGlitchDataType;

      begin

      if (TimingChecksOn) then
        VitalRecoveryRemovalCheck
        (
          Violation => Tviol_RESET_CLIENTEMACTXCLIENTCLKIN_posedge,
          TimingData => Tmkr_RESET_CLIENTEMACTXCLIENTCLKIN_posedge,
          TestSignal => RESET_CLIENTEMACTXCLIENTCLKIN_dly,
          TestSignalName => "RESET",
          TestDelay => tisd_RESET_CLIENTEMACTXCLIENTCLKIN,
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          Recovery => trecovery_RESET_CLIENTEMACTXCLIENTCLKIN_negedge_posedge,
          Removal => tremoval_RESET_CLIENTEMACTXCLIENTCLKIN_negedge_posedge,
          ActiveLow      => false,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalRecoveryRemovalCheck
        (
          Violation => Tviol_RESET_HOSTCLK_posedge,
          TimingData => Tmkr_RESET_HOSTCLK_posedge,
          TestSignal => RESET_HOSTCLK_dly,
          TestSignalName => "RESET",
          TestDelay => tisd_RESET_HOSTCLK,
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          Recovery => trecovery_RESET_HOSTCLK_negedge_posedge,
          Removal => tremoval_RESET_HOSTCLK_negedge_posedge,
          ActiveLow      => false,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalRecoveryRemovalCheck
        (
          Violation => Tviol_RESET_PHYEMACGTXCLK_posedge,
          TimingData => Tmkr_RESET_PHYEMACGTXCLK_posedge,
          TestSignal => RESET_PHYEMACGTXCLK_dly,
          TestSignalName => "RESET",
          TestDelay => tisd_RESET_PHYEMACGTXCLK,
          RefSignal => PHYEMACGTXCLK_dly,
          RefSignalName => "PHYEMACGTXCLK",
          RefDelay => ticd_PHYEMACGTXCLK,
          Recovery => trecovery_RESET_PHYEMACGTXCLK_negedge_posedge,
          Removal => tremoval_RESET_PHYEMACGTXCLK_negedge_posedge,
          ActiveLow      => false,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalRecoveryRemovalCheck
        (
          Violation => Tviol_RESET_PHYEMACMIITXCLK_posedge,
          TimingData => Tmkr_RESET_PHYEMACMIITXCLK_posedge,
          TestSignal => RESET_PHYEMACMIITXCLK_dly,
          TestSignalName => "RESET",
          TestDelay => tisd_RESET_PHYEMACMIITXCLK,
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          Recovery => trecovery_RESET_PHYEMACMIITXCLK_negedge_posedge,
          Removal => tremoval_RESET_PHYEMACMIITXCLK_negedge_posedge,
          ActiveLow      => false,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalRecoveryRemovalCheck
        (
          Violation => Tviol_RESET_PHYEMACTXGMIIMIICLKIN_posedge,
          TimingData => Tmkr_RESET_PHYEMACTXGMIIMIICLKIN_posedge,
          TestSignal => RESET_PHYEMACTXGMIIMIICLKIN_dly,
          TestSignalName => "RESET",
          TestDelay => tisd_RESET_PHYEMACTXGMIIMIICLKIN,
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          Recovery => trecovery_RESET_PHYEMACTXGMIIMIICLKIN_negedge_posedge,
          Removal => tremoval_RESET_PHYEMACTXGMIIMIICLKIN_negedge_posedge,
          ActiveLow      => false,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACDCMLOCKED_CLIENTEMACTXCLIENTCLKIN_posedge,
          TimingData => Tmkr_CLIENTEMACDCMLOCKED_CLIENTEMACTXCLIENTCLKIN_posedge,
          TestSignal => CLIENTEMACDCMLOCKED_CLIENTEMACTXCLIENTCLKIN_dly,
          TestSignalName => "CLIENTEMACDCMLOCKED",
          TestDelay => tisd_CLIENTEMACDCMLOCKED_CLIENTEMACTXCLIENTCLKIN,
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACDCMLOCKED_CLIENTEMACTXCLIENTCLKIN_posedge_posedge,
          HoldHigh => thold_CLIENTEMACDCMLOCKED_CLIENTEMACTXCLIENTCLKIN_posedge_posedge,
          SetupLow => tsetup_CLIENTEMACDCMLOCKED_CLIENTEMACTXCLIENTCLKIN_negedge_posedge,
          HoldLow => thold_CLIENTEMACDCMLOCKED_CLIENTEMACTXCLIENTCLKIN_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACDCMLOCKED_PHYEMACMIITXCLK_posedge,
          TimingData => Tmkr_CLIENTEMACDCMLOCKED_PHYEMACMIITXCLK_posedge,
          TestSignal => CLIENTEMACDCMLOCKED_PHYEMACMIITXCLK_dly,
          TestSignalName => "CLIENTEMACDCMLOCKED",
          TestDelay => tisd_CLIENTEMACDCMLOCKED_PHYEMACMIITXCLK,
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACDCMLOCKED_PHYEMACMIITXCLK_posedge_posedge,
          HoldHigh => thold_CLIENTEMACDCMLOCKED_PHYEMACMIITXCLK_posedge_posedge,
          SetupLow => tsetup_CLIENTEMACDCMLOCKED_PHYEMACMIITXCLK_negedge_posedge,
          HoldLow => thold_CLIENTEMACDCMLOCKED_PHYEMACMIITXCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACDCMLOCKED_PHYEMACTXGMIIMIICLKIN_posedge,
          TimingData => Tmkr_CLIENTEMACDCMLOCKED_PHYEMACTXGMIIMIICLKIN_posedge,
          TestSignal => CLIENTEMACDCMLOCKED_PHYEMACTXGMIIMIICLKIN_dly,
          TestSignalName => "CLIENTEMACDCMLOCKED",
          TestDelay => tisd_CLIENTEMACDCMLOCKED_PHYEMACTXGMIIMIICLKIN,
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACDCMLOCKED_PHYEMACTXGMIIMIICLKIN_posedge_posedge,
          HoldHigh => thold_CLIENTEMACDCMLOCKED_PHYEMACTXGMIIMIICLKIN_posedge_posedge,
          SetupLow => tsetup_CLIENTEMACDCMLOCKED_PHYEMACTXGMIIMIICLKIN_negedge_posedge,
          HoldLow => thold_CLIENTEMACDCMLOCKED_PHYEMACTXGMIIMIICLKIN_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEREQ_CLIENTEMACTXCLIENTCLKIN_posedge,
          TimingData => Tmkr_CLIENTEMACPAUSEREQ_CLIENTEMACTXCLIENTCLKIN_posedge,
          TestSignal => CLIENTEMACPAUSEREQ_CLIENTEMACTXCLIENTCLKIN_dly,
          TestSignalName => "CLIENTEMACPAUSEREQ",
          TestDelay => tisd_CLIENTEMACPAUSEREQ_CLIENTEMACTXCLIENTCLKIN,
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEREQ_CLIENTEMACTXCLIENTCLKIN_posedge_posedge,
          HoldHigh => thold_CLIENTEMACPAUSEREQ_CLIENTEMACTXCLIENTCLKIN_posedge_posedge,
          SetupLow => tsetup_CLIENTEMACPAUSEREQ_CLIENTEMACTXCLIENTCLKIN_negedge_posedge,
          HoldLow => thold_CLIENTEMACPAUSEREQ_CLIENTEMACTXCLIENTCLKIN_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEREQ_PHYEMACMIITXCLK_posedge,
          TimingData => Tmkr_CLIENTEMACPAUSEREQ_PHYEMACMIITXCLK_posedge,
          TestSignal => CLIENTEMACPAUSEREQ_PHYEMACMIITXCLK_dly,
          TestSignalName => "CLIENTEMACPAUSEREQ",
          TestDelay => tisd_CLIENTEMACPAUSEREQ_PHYEMACMIITXCLK,
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACPAUSEREQ_PHYEMACMIITXCLK_posedge_posedge,
          HoldHigh => thold_CLIENTEMACPAUSEREQ_PHYEMACMIITXCLK_posedge_posedge,
          SetupLow => tsetup_CLIENTEMACPAUSEREQ_PHYEMACMIITXCLK_negedge_posedge,
          HoldLow => thold_CLIENTEMACPAUSEREQ_PHYEMACMIITXCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEREQ_PHYEMACTXGMIIMIICLKIN_posedge,
          TimingData => Tmkr_CLIENTEMACPAUSEREQ_PHYEMACTXGMIIMIICLKIN_posedge,
          TestSignal => CLIENTEMACPAUSEREQ_PHYEMACTXGMIIMIICLKIN_dly,
          TestSignalName => "CLIENTEMACPAUSEREQ",
          TestDelay => tisd_CLIENTEMACPAUSEREQ_PHYEMACTXGMIIMIICLKIN,
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEREQ_PHYEMACTXGMIIMIICLKIN_posedge_posedge,
          HoldHigh => thold_CLIENTEMACPAUSEREQ_PHYEMACTXGMIIMIICLKIN_posedge_posedge,
          SetupLow => tsetup_CLIENTEMACPAUSEREQ_PHYEMACTXGMIIMIICLKIN_negedge_posedge,
          HoldLow => thold_CLIENTEMACPAUSEREQ_PHYEMACTXGMIIMIICLKIN_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(0),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(0),
          TestSignal => CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_dly(0),
          TestSignalName => "CLIENTEMACPAUSEVAL(0)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN(0),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(0),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(0),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(0),
          HoldLow => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(1),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(1),
          TestSignal => CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_dly(1),
          TestSignalName => "CLIENTEMACPAUSEVAL(1)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN(1),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(1),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(1),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(1),
          HoldLow => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(10),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(10),
          TestSignal => CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_dly(10),
          TestSignalName => "CLIENTEMACPAUSEVAL(10)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN(10),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(10),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(10),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(10),
          HoldLow => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(10),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(11),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(11),
          TestSignal => CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_dly(11),
          TestSignalName => "CLIENTEMACPAUSEVAL(11)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN(11),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(11),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(11),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(11),
          HoldLow => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(11),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(12),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(12),
          TestSignal => CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_dly(12),
          TestSignalName => "CLIENTEMACPAUSEVAL(12)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN(12),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(12),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(12),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(12),
          HoldLow => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(12),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(13),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(13),
          TestSignal => CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_dly(13),
          TestSignalName => "CLIENTEMACPAUSEVAL(13)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN(13),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(13),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(13),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(13),
          HoldLow => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(13),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(14),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(14),
          TestSignal => CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_dly(14),
          TestSignalName => "CLIENTEMACPAUSEVAL(14)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN(14),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(14),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(14),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(14),
          HoldLow => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(14),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(15),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(15),
          TestSignal => CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_dly(15),
          TestSignalName => "CLIENTEMACPAUSEVAL(15)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN(15),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(15),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(15),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(15),
          HoldLow => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(15),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(2),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(2),
          TestSignal => CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_dly(2),
          TestSignalName => "CLIENTEMACPAUSEVAL(2)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN(2),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(2),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(2),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(2),
          HoldLow => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(3),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(3),
          TestSignal => CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_dly(3),
          TestSignalName => "CLIENTEMACPAUSEVAL(3)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN(3),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(3),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(3),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(3),
          HoldLow => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(3),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(4),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(4),
          TestSignal => CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_dly(4),
          TestSignalName => "CLIENTEMACPAUSEVAL(4)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN(4),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(4),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(4),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(4),
          HoldLow => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(4),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(5),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(5),
          TestSignal => CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_dly(5),
          TestSignalName => "CLIENTEMACPAUSEVAL(5)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN(5),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(5),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(5),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(5),
          HoldLow => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(5),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(6),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(6),
          TestSignal => CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_dly(6),
          TestSignalName => "CLIENTEMACPAUSEVAL(6)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN(6),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(6),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(6),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(6),
          HoldLow => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(6),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(7),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(7),
          TestSignal => CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_dly(7),
          TestSignalName => "CLIENTEMACPAUSEVAL(7)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN(7),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(7),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(7),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(7),
          HoldLow => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(7),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(8),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(8),
          TestSignal => CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_dly(8),
          TestSignalName => "CLIENTEMACPAUSEVAL(8)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN(8),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(8),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(8),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(8),
          HoldLow => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(8),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(9),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge(9),
          TestSignal => CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_dly(9),
          TestSignalName => "CLIENTEMACPAUSEVAL(9)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN(9),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(9),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(9),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(9),
          HoldLow => thold_CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(9),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(0),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(0),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_dly(0),
          TestSignalName => "CLIENTEMACPAUSEVAL(0)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK(0),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(0),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(0),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(0),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(1),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(1),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_dly(1),
          TestSignalName => "CLIENTEMACPAUSEVAL(1)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK(1),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(1),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(1),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(1),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(10),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(10),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_dly(10),
          TestSignalName => "CLIENTEMACPAUSEVAL(10)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK(10),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(10),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(10),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(10),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(10),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(11),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(11),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_dly(11),
          TestSignalName => "CLIENTEMACPAUSEVAL(11)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK(11),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(11),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(11),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(11),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(11),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(12),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(12),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_dly(12),
          TestSignalName => "CLIENTEMACPAUSEVAL(12)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK(12),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(12),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(12),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(12),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(12),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(13),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(13),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_dly(13),
          TestSignalName => "CLIENTEMACPAUSEVAL(13)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK(13),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(13),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(13),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(13),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(13),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(14),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(14),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_dly(14),
          TestSignalName => "CLIENTEMACPAUSEVAL(14)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK(14),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(14),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(14),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(14),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(14),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(15),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(15),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_dly(15),
          TestSignalName => "CLIENTEMACPAUSEVAL(15)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK(15),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(15),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(15),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(15),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(15),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(2),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(2),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_dly(2),
          TestSignalName => "CLIENTEMACPAUSEVAL(2)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK(2),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(2),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(2),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(2),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(3),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(3),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_dly(3),
          TestSignalName => "CLIENTEMACPAUSEVAL(3)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK(3),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(3),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(3),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(3),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(3),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(4),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(4),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_dly(4),
          TestSignalName => "CLIENTEMACPAUSEVAL(4)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK(4),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(4),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(4),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(4),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(4),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(5),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(5),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_dly(5),
          TestSignalName => "CLIENTEMACPAUSEVAL(5)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK(5),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(5),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(5),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(5),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(5),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(6),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(6),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_dly(6),
          TestSignalName => "CLIENTEMACPAUSEVAL(6)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK(6),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(6),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(6),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(6),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(6),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(7),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(7),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_dly(7),
          TestSignalName => "CLIENTEMACPAUSEVAL(7)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK(7),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(7),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(7),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(7),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(7),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(8),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(8),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_dly(8),
          TestSignalName => "CLIENTEMACPAUSEVAL(8)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK(8),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(8),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(8),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(8),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(8),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(9),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge(9),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_dly(9),
          TestSignalName => "CLIENTEMACPAUSEVAL(9)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK(9),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(9),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_posedge_posedge(9),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(9),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_negedge_posedge(9),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(0),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(0),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_dly(0),
          TestSignalName => "CLIENTEMACPAUSEVAL(0)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN(0),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(0),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(0),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(0),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(1),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(1),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_dly(1),
          TestSignalName => "CLIENTEMACPAUSEVAL(1)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN(1),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(1),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(1),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(1),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(10),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(10),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_dly(10),
          TestSignalName => "CLIENTEMACPAUSEVAL(10)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN(10),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(10),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(10),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(10),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(10),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(11),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(11),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_dly(11),
          TestSignalName => "CLIENTEMACPAUSEVAL(11)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN(11),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(11),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(11),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(11),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(11),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(12),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(12),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_dly(12),
          TestSignalName => "CLIENTEMACPAUSEVAL(12)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN(12),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(12),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(12),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(12),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(12),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(13),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(13),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_dly(13),
          TestSignalName => "CLIENTEMACPAUSEVAL(13)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN(13),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(13),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(13),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(13),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(13),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(14),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(14),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_dly(14),
          TestSignalName => "CLIENTEMACPAUSEVAL(14)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN(14),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(14),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(14),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(14),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(14),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(15),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(15),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_dly(15),
          TestSignalName => "CLIENTEMACPAUSEVAL(15)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN(15),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(15),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(15),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(15),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(15),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(2),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(2),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_dly(2),
          TestSignalName => "CLIENTEMACPAUSEVAL(2)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN(2),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(2),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(2),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(2),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(3),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(3),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_dly(3),
          TestSignalName => "CLIENTEMACPAUSEVAL(3)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN(3),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(3),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(3),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(3),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(3),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(4),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(4),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_dly(4),
          TestSignalName => "CLIENTEMACPAUSEVAL(4)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN(4),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(4),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(4),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(4),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(4),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(5),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(5),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_dly(5),
          TestSignalName => "CLIENTEMACPAUSEVAL(5)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN(5),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(5),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(5),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(5),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(5),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(6),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(6),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_dly(6),
          TestSignalName => "CLIENTEMACPAUSEVAL(6)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN(6),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(6),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(6),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(6),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(6),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(7),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(7),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_dly(7),
          TestSignalName => "CLIENTEMACPAUSEVAL(7)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN(7),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(7),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(7),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(7),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(7),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(8),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(8),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_dly(8),
          TestSignalName => "CLIENTEMACPAUSEVAL(8)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN(8),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(8),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(8),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(8),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(8),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(9),
          TimingData => Tmkr_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge(9),
          TestSignal => CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_dly(9),
          TestSignalName => "CLIENTEMACPAUSEVAL(9)",
          TestDelay => tisd_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN(9),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(9),
          HoldHigh => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_posedge_posedge(9),
          SetupLow => tsetup_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(9),
          HoldLow => thold_CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_negedge_posedge(9),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXDVLDMSW_CLIENTEMACTXCLIENTCLKIN_posedge,
          TimingData => Tmkr_CLIENTEMACTXDVLDMSW_CLIENTEMACTXCLIENTCLKIN_posedge,
          TestSignal => CLIENTEMACTXDVLDMSW_CLIENTEMACTXCLIENTCLKIN_dly,
          TestSignalName => "CLIENTEMACTXDVLDMSW",
          TestDelay => tisd_CLIENTEMACTXDVLDMSW_CLIENTEMACTXCLIENTCLKIN,
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACTXDVLDMSW_CLIENTEMACTXCLIENTCLKIN_posedge_posedge,
          HoldHigh => thold_CLIENTEMACTXDVLDMSW_CLIENTEMACTXCLIENTCLKIN_posedge_posedge,
          SetupLow => tsetup_CLIENTEMACTXDVLDMSW_CLIENTEMACTXCLIENTCLKIN_negedge_posedge,
          HoldLow => thold_CLIENTEMACTXDVLDMSW_CLIENTEMACTXCLIENTCLKIN_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXDVLDMSW_PHYEMACMIITXCLK_posedge,
          TimingData => Tmkr_CLIENTEMACTXDVLDMSW_PHYEMACMIITXCLK_posedge,
          TestSignal => CLIENTEMACTXDVLDMSW_PHYEMACMIITXCLK_dly,
          TestSignalName => "CLIENTEMACTXDVLDMSW",
          TestDelay => tisd_CLIENTEMACTXDVLDMSW_PHYEMACMIITXCLK,
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACTXDVLDMSW_PHYEMACMIITXCLK_posedge_posedge,
          HoldHigh => thold_CLIENTEMACTXDVLDMSW_PHYEMACMIITXCLK_posedge_posedge,
          SetupLow => tsetup_CLIENTEMACTXDVLDMSW_PHYEMACMIITXCLK_negedge_posedge,
          HoldLow => thold_CLIENTEMACTXDVLDMSW_PHYEMACMIITXCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXDVLDMSW_PHYEMACTXGMIIMIICLKIN_posedge,
          TimingData => Tmkr_CLIENTEMACTXDVLDMSW_PHYEMACTXGMIIMIICLKIN_posedge,
          TestSignal => CLIENTEMACTXDVLDMSW_PHYEMACTXGMIIMIICLKIN_dly,
          TestSignalName => "CLIENTEMACTXDVLDMSW",
          TestDelay => tisd_CLIENTEMACTXDVLDMSW_PHYEMACTXGMIIMIICLKIN,
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACTXDVLDMSW_PHYEMACTXGMIIMIICLKIN_posedge_posedge,
          HoldHigh => thold_CLIENTEMACTXDVLDMSW_PHYEMACTXGMIIMIICLKIN_posedge_posedge,
          SetupLow => tsetup_CLIENTEMACTXDVLDMSW_PHYEMACTXGMIIMIICLKIN_negedge_posedge,
          HoldLow => thold_CLIENTEMACTXDVLDMSW_PHYEMACTXGMIIMIICLKIN_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXDVLD_CLIENTEMACTXCLIENTCLKIN_posedge,
          TimingData => Tmkr_CLIENTEMACTXDVLD_CLIENTEMACTXCLIENTCLKIN_posedge,
          TestSignal => CLIENTEMACTXDVLD_CLIENTEMACTXCLIENTCLKIN_dly,
          TestSignalName => "CLIENTEMACTXDVLD",
          TestDelay => tisd_CLIENTEMACTXDVLD_CLIENTEMACTXCLIENTCLKIN,
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACTXDVLD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge,
          HoldHigh => thold_CLIENTEMACTXDVLD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge,
          SetupLow => tsetup_CLIENTEMACTXDVLD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge,
          HoldLow => thold_CLIENTEMACTXDVLD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXDVLD_PHYEMACMIITXCLK_posedge,
          TimingData => Tmkr_CLIENTEMACTXDVLD_PHYEMACMIITXCLK_posedge,
          TestSignal => CLIENTEMACTXDVLD_PHYEMACMIITXCLK_dly,
          TestSignalName => "CLIENTEMACTXDVLD",
          TestDelay => tisd_CLIENTEMACTXDVLD_PHYEMACMIITXCLK,
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACTXDVLD_PHYEMACMIITXCLK_posedge_posedge,
          HoldHigh => thold_CLIENTEMACTXDVLD_PHYEMACMIITXCLK_posedge_posedge,
          SetupLow => tsetup_CLIENTEMACTXDVLD_PHYEMACMIITXCLK_negedge_posedge,
          HoldLow => thold_CLIENTEMACTXDVLD_PHYEMACMIITXCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXDVLD_PHYEMACTXGMIIMIICLKIN_posedge,
          TimingData => Tmkr_CLIENTEMACTXDVLD_PHYEMACTXGMIIMIICLKIN_posedge,
          TestSignal => CLIENTEMACTXDVLD_PHYEMACTXGMIIMIICLKIN_dly,
          TestSignalName => "CLIENTEMACTXDVLD",
          TestDelay => tisd_CLIENTEMACTXDVLD_PHYEMACTXGMIIMIICLKIN,
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACTXDVLD_PHYEMACTXGMIIMIICLKIN_posedge_posedge,
          HoldHigh => thold_CLIENTEMACTXDVLD_PHYEMACTXGMIIMIICLKIN_posedge_posedge,
          SetupLow => tsetup_CLIENTEMACTXDVLD_PHYEMACTXGMIIMIICLKIN_negedge_posedge,
          HoldLow => thold_CLIENTEMACTXDVLD_PHYEMACTXGMIIMIICLKIN_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(0),
          TimingData => Tmkr_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(0),
          TestSignal => CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_dly(0),
          TestSignalName => "CLIENTEMACTXD(0)",
          TestDelay => tisd_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN(0),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(0),
          HoldHigh => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(0),
          SetupLow => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(0),
          HoldLow => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(1),
          TimingData => Tmkr_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(1),
          TestSignal => CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_dly(1),
          TestSignalName => "CLIENTEMACTXD(1)",
          TestDelay => tisd_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN(1),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(1),
          HoldHigh => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(1),
          SetupLow => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(1),
          HoldLow => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(10),
          TimingData => Tmkr_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(10),
          TestSignal => CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_dly(10),
          TestSignalName => "CLIENTEMACTXD(10)",
          TestDelay => tisd_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN(10),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(10),
          HoldHigh => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(10),
          SetupLow => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(10),
          HoldLow => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(10),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(11),
          TimingData => Tmkr_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(11),
          TestSignal => CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_dly(11),
          TestSignalName => "CLIENTEMACTXD(11)",
          TestDelay => tisd_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN(11),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(11),
          HoldHigh => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(11),
          SetupLow => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(11),
          HoldLow => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(11),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(12),
          TimingData => Tmkr_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(12),
          TestSignal => CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_dly(12),
          TestSignalName => "CLIENTEMACTXD(12)",
          TestDelay => tisd_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN(12),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(12),
          HoldHigh => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(12),
          SetupLow => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(12),
          HoldLow => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(12),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(13),
          TimingData => Tmkr_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(13),
          TestSignal => CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_dly(13),
          TestSignalName => "CLIENTEMACTXD(13)",
          TestDelay => tisd_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN(13),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(13),
          HoldHigh => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(13),
          SetupLow => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(13),
          HoldLow => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(13),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(14),
          TimingData => Tmkr_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(14),
          TestSignal => CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_dly(14),
          TestSignalName => "CLIENTEMACTXD(14)",
          TestDelay => tisd_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN(14),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(14),
          HoldHigh => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(14),
          SetupLow => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(14),
          HoldLow => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(14),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(15),
          TimingData => Tmkr_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(15),
          TestSignal => CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_dly(15),
          TestSignalName => "CLIENTEMACTXD(15)",
          TestDelay => tisd_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN(15),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(15),
          HoldHigh => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(15),
          SetupLow => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(15),
          HoldLow => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(15),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(2),
          TimingData => Tmkr_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(2),
          TestSignal => CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_dly(2),
          TestSignalName => "CLIENTEMACTXD(2)",
          TestDelay => tisd_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN(2),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(2),
          HoldHigh => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(2),
          SetupLow => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(2),
          HoldLow => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(3),
          TimingData => Tmkr_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(3),
          TestSignal => CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_dly(3),
          TestSignalName => "CLIENTEMACTXD(3)",
          TestDelay => tisd_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN(3),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(3),
          HoldHigh => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(3),
          SetupLow => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(3),
          HoldLow => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(3),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(4),
          TimingData => Tmkr_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(4),
          TestSignal => CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_dly(4),
          TestSignalName => "CLIENTEMACTXD(4)",
          TestDelay => tisd_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN(4),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(4),
          HoldHigh => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(4),
          SetupLow => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(4),
          HoldLow => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(4),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(5),
          TimingData => Tmkr_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(5),
          TestSignal => CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_dly(5),
          TestSignalName => "CLIENTEMACTXD(5)",
          TestDelay => tisd_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN(5),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(5),
          HoldHigh => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(5),
          SetupLow => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(5),
          HoldLow => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(5),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(6),
          TimingData => Tmkr_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(6),
          TestSignal => CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_dly(6),
          TestSignalName => "CLIENTEMACTXD(6)",
          TestDelay => tisd_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN(6),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(6),
          HoldHigh => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(6),
          SetupLow => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(6),
          HoldLow => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(6),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(7),
          TimingData => Tmkr_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(7),
          TestSignal => CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_dly(7),
          TestSignalName => "CLIENTEMACTXD(7)",
          TestDelay => tisd_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN(7),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(7),
          HoldHigh => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(7),
          SetupLow => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(7),
          HoldLow => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(7),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(8),
          TimingData => Tmkr_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(8),
          TestSignal => CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_dly(8),
          TestSignalName => "CLIENTEMACTXD(8)",
          TestDelay => tisd_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN(8),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(8),
          HoldHigh => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(8),
          SetupLow => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(8),
          HoldLow => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(8),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(9),
          TimingData => Tmkr_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge(9),
          TestSignal => CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_dly(9),
          TestSignalName => "CLIENTEMACTXD(9)",
          TestDelay => tisd_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN(9),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(9),
          HoldHigh => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(9),
          SetupLow => tsetup_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(9),
          HoldLow => thold_CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(9),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(0),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(0),
          TestSignal => CLIENTEMACTXD_PHYEMACMIITXCLK_dly(0),
          TestSignalName => "CLIENTEMACTXD(0)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACMIITXCLK(0),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(0),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(0),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(0),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(1),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(1),
          TestSignal => CLIENTEMACTXD_PHYEMACMIITXCLK_dly(1),
          TestSignalName => "CLIENTEMACTXD(1)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACMIITXCLK(1),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(1),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(1),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(1),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(10),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(10),
          TestSignal => CLIENTEMACTXD_PHYEMACMIITXCLK_dly(10),
          TestSignalName => "CLIENTEMACTXD(10)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACMIITXCLK(10),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(10),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(10),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(10),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(10),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(11),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(11),
          TestSignal => CLIENTEMACTXD_PHYEMACMIITXCLK_dly(11),
          TestSignalName => "CLIENTEMACTXD(11)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACMIITXCLK(11),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(11),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(11),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(11),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(11),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(12),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(12),
          TestSignal => CLIENTEMACTXD_PHYEMACMIITXCLK_dly(12),
          TestSignalName => "CLIENTEMACTXD(12)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACMIITXCLK(12),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(12),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(12),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(12),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(12),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(13),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(13),
          TestSignal => CLIENTEMACTXD_PHYEMACMIITXCLK_dly(13),
          TestSignalName => "CLIENTEMACTXD(13)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACMIITXCLK(13),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(13),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(13),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(13),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(13),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(14),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(14),
          TestSignal => CLIENTEMACTXD_PHYEMACMIITXCLK_dly(14),
          TestSignalName => "CLIENTEMACTXD(14)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACMIITXCLK(14),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(14),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(14),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(14),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(14),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(15),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(15),
          TestSignal => CLIENTEMACTXD_PHYEMACMIITXCLK_dly(15),
          TestSignalName => "CLIENTEMACTXD(15)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACMIITXCLK(15),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(15),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(15),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(15),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(15),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(2),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(2),
          TestSignal => CLIENTEMACTXD_PHYEMACMIITXCLK_dly(2),
          TestSignalName => "CLIENTEMACTXD(2)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACMIITXCLK(2),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(2),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(2),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(2),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(3),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(3),
          TestSignal => CLIENTEMACTXD_PHYEMACMIITXCLK_dly(3),
          TestSignalName => "CLIENTEMACTXD(3)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACMIITXCLK(3),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(3),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(3),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(3),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(3),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(4),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(4),
          TestSignal => CLIENTEMACTXD_PHYEMACMIITXCLK_dly(4),
          TestSignalName => "CLIENTEMACTXD(4)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACMIITXCLK(4),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(4),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(4),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(4),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(4),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(5),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(5),
          TestSignal => CLIENTEMACTXD_PHYEMACMIITXCLK_dly(5),
          TestSignalName => "CLIENTEMACTXD(5)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACMIITXCLK(5),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(5),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(5),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(5),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(5),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(6),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(6),
          TestSignal => CLIENTEMACTXD_PHYEMACMIITXCLK_dly(6),
          TestSignalName => "CLIENTEMACTXD(6)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACMIITXCLK(6),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(6),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(6),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(6),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(6),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(7),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(7),
          TestSignal => CLIENTEMACTXD_PHYEMACMIITXCLK_dly(7),
          TestSignalName => "CLIENTEMACTXD(7)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACMIITXCLK(7),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(7),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(7),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(7),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(7),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(8),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(8),
          TestSignal => CLIENTEMACTXD_PHYEMACMIITXCLK_dly(8),
          TestSignalName => "CLIENTEMACTXD(8)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACMIITXCLK(8),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(8),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(8),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(8),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(8),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(9),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge(9),
          TestSignal => CLIENTEMACTXD_PHYEMACMIITXCLK_dly(9),
          TestSignalName => "CLIENTEMACTXD(9)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACMIITXCLK(9),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(9),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_posedge_posedge(9),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(9),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACMIITXCLK_negedge_posedge(9),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(0),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(0),
          TestSignal => CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_dly(0),
          TestSignalName => "CLIENTEMACTXD(0)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN(0),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(0),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(0),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(0),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(1),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(1),
          TestSignal => CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_dly(1),
          TestSignalName => "CLIENTEMACTXD(1)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN(1),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(1),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(1),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(1),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(10),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(10),
          TestSignal => CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_dly(10),
          TestSignalName => "CLIENTEMACTXD(10)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN(10),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(10),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(10),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(10),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(10),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(11),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(11),
          TestSignal => CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_dly(11),
          TestSignalName => "CLIENTEMACTXD(11)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN(11),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(11),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(11),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(11),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(11),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(12),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(12),
          TestSignal => CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_dly(12),
          TestSignalName => "CLIENTEMACTXD(12)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN(12),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(12),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(12),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(12),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(12),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(13),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(13),
          TestSignal => CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_dly(13),
          TestSignalName => "CLIENTEMACTXD(13)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN(13),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(13),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(13),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(13),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(13),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(14),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(14),
          TestSignal => CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_dly(14),
          TestSignalName => "CLIENTEMACTXD(14)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN(14),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(14),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(14),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(14),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(14),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(15),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(15),
          TestSignal => CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_dly(15),
          TestSignalName => "CLIENTEMACTXD(15)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN(15),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(15),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(15),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(15),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(15),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(2),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(2),
          TestSignal => CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_dly(2),
          TestSignalName => "CLIENTEMACTXD(2)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN(2),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(2),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(2),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(2),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(3),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(3),
          TestSignal => CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_dly(3),
          TestSignalName => "CLIENTEMACTXD(3)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN(3),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(3),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(3),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(3),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(3),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(4),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(4),
          TestSignal => CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_dly(4),
          TestSignalName => "CLIENTEMACTXD(4)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN(4),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(4),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(4),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(4),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(4),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(5),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(5),
          TestSignal => CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_dly(5),
          TestSignalName => "CLIENTEMACTXD(5)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN(5),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(5),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(5),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(5),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(5),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(6),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(6),
          TestSignal => CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_dly(6),
          TestSignalName => "CLIENTEMACTXD(6)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN(6),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(6),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(6),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(6),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(6),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(7),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(7),
          TestSignal => CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_dly(7),
          TestSignalName => "CLIENTEMACTXD(7)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN(7),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(7),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(7),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(7),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(7),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(8),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(8),
          TestSignal => CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_dly(8),
          TestSignalName => "CLIENTEMACTXD(8)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN(8),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(8),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(8),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(8),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(8),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(9),
          TimingData => Tmkr_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge(9),
          TestSignal => CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_dly(9),
          TestSignalName => "CLIENTEMACTXD(9)",
          TestDelay => tisd_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN(9),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(9),
          HoldHigh => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_posedge_posedge(9),
          SetupLow => tsetup_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(9),
          HoldLow => thold_CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_negedge_posedge(9),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXFIRSTBYTE_CLIENTEMACTXCLIENTCLKIN_posedge,
          TimingData => Tmkr_CLIENTEMACTXFIRSTBYTE_CLIENTEMACTXCLIENTCLKIN_posedge,
          TestSignal => CLIENTEMACTXFIRSTBYTE_CLIENTEMACTXCLIENTCLKIN_dly,
          TestSignalName => "CLIENTEMACTXFIRSTBYTE",
          TestDelay => tisd_CLIENTEMACTXFIRSTBYTE_CLIENTEMACTXCLIENTCLKIN,
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACTXFIRSTBYTE_CLIENTEMACTXCLIENTCLKIN_posedge_posedge,
          HoldHigh => thold_CLIENTEMACTXFIRSTBYTE_CLIENTEMACTXCLIENTCLKIN_posedge_posedge,
          SetupLow => tsetup_CLIENTEMACTXFIRSTBYTE_CLIENTEMACTXCLIENTCLKIN_negedge_posedge,
          HoldLow => thold_CLIENTEMACTXFIRSTBYTE_CLIENTEMACTXCLIENTCLKIN_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXFIRSTBYTE_PHYEMACMIITXCLK_posedge,
          TimingData => Tmkr_CLIENTEMACTXFIRSTBYTE_PHYEMACMIITXCLK_posedge,
          TestSignal => CLIENTEMACTXFIRSTBYTE_PHYEMACMIITXCLK_dly,
          TestSignalName => "CLIENTEMACTXFIRSTBYTE",
          TestDelay => tisd_CLIENTEMACTXFIRSTBYTE_PHYEMACMIITXCLK,
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACTXFIRSTBYTE_PHYEMACMIITXCLK_posedge_posedge,
          HoldHigh => thold_CLIENTEMACTXFIRSTBYTE_PHYEMACMIITXCLK_posedge_posedge,
          SetupLow => tsetup_CLIENTEMACTXFIRSTBYTE_PHYEMACMIITXCLK_negedge_posedge,
          HoldLow => thold_CLIENTEMACTXFIRSTBYTE_PHYEMACMIITXCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXFIRSTBYTE_PHYEMACTXGMIIMIICLKIN_posedge,
          TimingData => Tmkr_CLIENTEMACTXFIRSTBYTE_PHYEMACTXGMIIMIICLKIN_posedge,
          TestSignal => CLIENTEMACTXFIRSTBYTE_PHYEMACTXGMIIMIICLKIN_dly,
          TestSignalName => "CLIENTEMACTXFIRSTBYTE",
          TestDelay => tisd_CLIENTEMACTXFIRSTBYTE_PHYEMACTXGMIIMIICLKIN,
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACTXFIRSTBYTE_PHYEMACTXGMIIMIICLKIN_posedge_posedge,
          HoldHigh => thold_CLIENTEMACTXFIRSTBYTE_PHYEMACTXGMIIMIICLKIN_posedge_posedge,
          SetupLow => tsetup_CLIENTEMACTXFIRSTBYTE_PHYEMACTXGMIIMIICLKIN_negedge_posedge,
          HoldLow => thold_CLIENTEMACTXFIRSTBYTE_PHYEMACTXGMIIMIICLKIN_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge(0),
          TimingData => Tmkr_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge(0),
          TestSignal => CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_dly(0),
          TestSignalName => "CLIENTEMACTXIFGDELAY(0)",
          TestDelay => tisd_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN(0),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(0),
          HoldHigh => thold_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(0),
          SetupLow => tsetup_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(0),
          HoldLow => thold_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge(1),
          TimingData => Tmkr_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge(1),
          TestSignal => CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_dly(1),
          TestSignalName => "CLIENTEMACTXIFGDELAY(1)",
          TestDelay => tisd_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN(1),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(1),
          HoldHigh => thold_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(1),
          SetupLow => tsetup_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(1),
          HoldLow => thold_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge(2),
          TimingData => Tmkr_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge(2),
          TestSignal => CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_dly(2),
          TestSignalName => "CLIENTEMACTXIFGDELAY(2)",
          TestDelay => tisd_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN(2),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(2),
          HoldHigh => thold_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(2),
          SetupLow => tsetup_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(2),
          HoldLow => thold_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge(3),
          TimingData => Tmkr_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge(3),
          TestSignal => CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_dly(3),
          TestSignalName => "CLIENTEMACTXIFGDELAY(3)",
          TestDelay => tisd_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN(3),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(3),
          HoldHigh => thold_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(3),
          SetupLow => tsetup_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(3),
          HoldLow => thold_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(3),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge(4),
          TimingData => Tmkr_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge(4),
          TestSignal => CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_dly(4),
          TestSignalName => "CLIENTEMACTXIFGDELAY(4)",
          TestDelay => tisd_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN(4),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(4),
          HoldHigh => thold_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(4),
          SetupLow => tsetup_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(4),
          HoldLow => thold_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(4),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge(5),
          TimingData => Tmkr_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge(5),
          TestSignal => CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_dly(5),
          TestSignalName => "CLIENTEMACTXIFGDELAY(5)",
          TestDelay => tisd_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN(5),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(5),
          HoldHigh => thold_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(5),
          SetupLow => tsetup_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(5),
          HoldLow => thold_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(5),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge(6),
          TimingData => Tmkr_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge(6),
          TestSignal => CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_dly(6),
          TestSignalName => "CLIENTEMACTXIFGDELAY(6)",
          TestDelay => tisd_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN(6),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(6),
          HoldHigh => thold_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(6),
          SetupLow => tsetup_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(6),
          HoldLow => thold_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(6),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge(7),
          TimingData => Tmkr_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge(7),
          TestSignal => CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_dly(7),
          TestSignalName => "CLIENTEMACTXIFGDELAY(7)",
          TestDelay => tisd_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN(7),
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(7),
          HoldHigh => thold_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_posedge_posedge(7),
          SetupLow => tsetup_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(7),
          HoldLow => thold_CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_negedge_posedge(7),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge(0),
          TimingData => Tmkr_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge(0),
          TestSignal => CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_dly(0),
          TestSignalName => "CLIENTEMACTXIFGDELAY(0)",
          TestDelay => tisd_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK(0),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge_posedge(0),
          HoldHigh => thold_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge_posedge(0),
          SetupLow => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_negedge_posedge(0),
          HoldLow => thold_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge(1),
          TimingData => Tmkr_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge(1),
          TestSignal => CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_dly(1),
          TestSignalName => "CLIENTEMACTXIFGDELAY(1)",
          TestDelay => tisd_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK(1),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge_posedge(1),
          HoldHigh => thold_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge_posedge(1),
          SetupLow => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_negedge_posedge(1),
          HoldLow => thold_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge(2),
          TimingData => Tmkr_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge(2),
          TestSignal => CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_dly(2),
          TestSignalName => "CLIENTEMACTXIFGDELAY(2)",
          TestDelay => tisd_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK(2),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge_posedge(2),
          HoldHigh => thold_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge_posedge(2),
          SetupLow => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_negedge_posedge(2),
          HoldLow => thold_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge(3),
          TimingData => Tmkr_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge(3),
          TestSignal => CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_dly(3),
          TestSignalName => "CLIENTEMACTXIFGDELAY(3)",
          TestDelay => tisd_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK(3),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge_posedge(3),
          HoldHigh => thold_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge_posedge(3),
          SetupLow => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_negedge_posedge(3),
          HoldLow => thold_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_negedge_posedge(3),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge(4),
          TimingData => Tmkr_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge(4),
          TestSignal => CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_dly(4),
          TestSignalName => "CLIENTEMACTXIFGDELAY(4)",
          TestDelay => tisd_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK(4),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge_posedge(4),
          HoldHigh => thold_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge_posedge(4),
          SetupLow => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_negedge_posedge(4),
          HoldLow => thold_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_negedge_posedge(4),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge(5),
          TimingData => Tmkr_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge(5),
          TestSignal => CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_dly(5),
          TestSignalName => "CLIENTEMACTXIFGDELAY(5)",
          TestDelay => tisd_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK(5),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge_posedge(5),
          HoldHigh => thold_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge_posedge(5),
          SetupLow => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_negedge_posedge(5),
          HoldLow => thold_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_negedge_posedge(5),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge(6),
          TimingData => Tmkr_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge(6),
          TestSignal => CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_dly(6),
          TestSignalName => "CLIENTEMACTXIFGDELAY(6)",
          TestDelay => tisd_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK(6),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge_posedge(6),
          HoldHigh => thold_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge_posedge(6),
          SetupLow => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_negedge_posedge(6),
          HoldLow => thold_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_negedge_posedge(6),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge(7),
          TimingData => Tmkr_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge(7),
          TestSignal => CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_dly(7),
          TestSignalName => "CLIENTEMACTXIFGDELAY(7)",
          TestDelay => tisd_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK(7),
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge_posedge(7),
          HoldHigh => thold_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_posedge_posedge(7),
          SetupLow => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_negedge_posedge(7),
          HoldLow => thold_CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_negedge_posedge(7),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge(0),
          TimingData => Tmkr_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge(0),
          TestSignal => CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_dly(0),
          TestSignalName => "CLIENTEMACTXIFGDELAY(0)",
          TestDelay => tisd_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN(0),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge_posedge(0),
          HoldHigh => thold_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge_posedge(0),
          SetupLow => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_negedge_posedge(0),
          HoldLow => thold_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge(1),
          TimingData => Tmkr_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge(1),
          TestSignal => CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_dly(1),
          TestSignalName => "CLIENTEMACTXIFGDELAY(1)",
          TestDelay => tisd_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN(1),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge_posedge(1),
          HoldHigh => thold_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge_posedge(1),
          SetupLow => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_negedge_posedge(1),
          HoldLow => thold_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge(2),
          TimingData => Tmkr_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge(2),
          TestSignal => CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_dly(2),
          TestSignalName => "CLIENTEMACTXIFGDELAY(2)",
          TestDelay => tisd_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN(2),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge_posedge(2),
          HoldHigh => thold_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge_posedge(2),
          SetupLow => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_negedge_posedge(2),
          HoldLow => thold_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge(3),
          TimingData => Tmkr_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge(3),
          TestSignal => CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_dly(3),
          TestSignalName => "CLIENTEMACTXIFGDELAY(3)",
          TestDelay => tisd_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN(3),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge_posedge(3),
          HoldHigh => thold_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge_posedge(3),
          SetupLow => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_negedge_posedge(3),
          HoldLow => thold_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_negedge_posedge(3),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge(4),
          TimingData => Tmkr_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge(4),
          TestSignal => CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_dly(4),
          TestSignalName => "CLIENTEMACTXIFGDELAY(4)",
          TestDelay => tisd_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN(4),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge_posedge(4),
          HoldHigh => thold_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge_posedge(4),
          SetupLow => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_negedge_posedge(4),
          HoldLow => thold_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_negedge_posedge(4),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge(5),
          TimingData => Tmkr_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge(5),
          TestSignal => CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_dly(5),
          TestSignalName => "CLIENTEMACTXIFGDELAY(5)",
          TestDelay => tisd_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN(5),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge_posedge(5),
          HoldHigh => thold_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge_posedge(5),
          SetupLow => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_negedge_posedge(5),
          HoldLow => thold_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_negedge_posedge(5),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge(6),
          TimingData => Tmkr_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge(6),
          TestSignal => CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_dly(6),
          TestSignalName => "CLIENTEMACTXIFGDELAY(6)",
          TestDelay => tisd_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN(6),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge_posedge(6),
          HoldHigh => thold_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge_posedge(6),
          SetupLow => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_negedge_posedge(6),
          HoldLow => thold_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_negedge_posedge(6),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge(7),
          TimingData => Tmkr_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge(7),
          TestSignal => CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_dly(7),
          TestSignalName => "CLIENTEMACTXIFGDELAY(7)",
          TestDelay => tisd_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN(7),
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge_posedge(7),
          HoldHigh => thold_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_posedge_posedge(7),
          SetupLow => tsetup_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_negedge_posedge(7),
          HoldLow => thold_CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_negedge_posedge(7),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXUNDERRUN_CLIENTEMACTXCLIENTCLKIN_posedge,
          TimingData => Tmkr_CLIENTEMACTXUNDERRUN_CLIENTEMACTXCLIENTCLKIN_posedge,
          TestSignal => CLIENTEMACTXUNDERRUN_CLIENTEMACTXCLIENTCLKIN_dly,
          TestSignalName => "CLIENTEMACTXUNDERRUN",
          TestDelay => tisd_CLIENTEMACTXUNDERRUN_CLIENTEMACTXCLIENTCLKIN,
          RefSignal => CLIENTEMACTXCLIENTCLKIN_dly,
          RefSignalName => "CLIENTEMACTXCLIENTCLKIN",
          RefDelay => ticd_CLIENTEMACTXCLIENTCLKIN,
          SetupHigh => tsetup_CLIENTEMACTXUNDERRUN_CLIENTEMACTXCLIENTCLKIN_posedge_posedge,
          HoldHigh => thold_CLIENTEMACTXUNDERRUN_CLIENTEMACTXCLIENTCLKIN_posedge_posedge,
          SetupLow => tsetup_CLIENTEMACTXUNDERRUN_CLIENTEMACTXCLIENTCLKIN_negedge_posedge,
          HoldLow => thold_CLIENTEMACTXUNDERRUN_CLIENTEMACTXCLIENTCLKIN_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXUNDERRUN_PHYEMACMIITXCLK_posedge,
          TimingData => Tmkr_CLIENTEMACTXUNDERRUN_PHYEMACMIITXCLK_posedge,
          TestSignal => CLIENTEMACTXUNDERRUN_PHYEMACMIITXCLK_dly,
          TestSignalName => "CLIENTEMACTXUNDERRUN",
          TestDelay => tisd_CLIENTEMACTXUNDERRUN_PHYEMACMIITXCLK,
          RefSignal => PHYEMACMIITXCLK_dly,
          RefSignalName => "PHYEMACMIITXCLK",
          RefDelay => ticd_PHYEMACMIITXCLK,
          SetupHigh => tsetup_CLIENTEMACTXUNDERRUN_PHYEMACMIITXCLK_posedge_posedge,
          HoldHigh => thold_CLIENTEMACTXUNDERRUN_PHYEMACMIITXCLK_posedge_posedge,
          SetupLow => tsetup_CLIENTEMACTXUNDERRUN_PHYEMACMIITXCLK_negedge_posedge,
          HoldLow => thold_CLIENTEMACTXUNDERRUN_PHYEMACMIITXCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_CLIENTEMACTXUNDERRUN_PHYEMACTXGMIIMIICLKIN_posedge,
          TimingData => Tmkr_CLIENTEMACTXUNDERRUN_PHYEMACTXGMIIMIICLKIN_posedge,
          TestSignal => CLIENTEMACTXUNDERRUN_PHYEMACTXGMIIMIICLKIN_dly,
          TestSignalName => "CLIENTEMACTXUNDERRUN",
          TestDelay => tisd_CLIENTEMACTXUNDERRUN_PHYEMACTXGMIIMIICLKIN,
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_CLIENTEMACTXUNDERRUN_PHYEMACTXGMIIMIICLKIN_posedge_posedge,
          HoldHigh => thold_CLIENTEMACTXUNDERRUN_PHYEMACTXGMIIMIICLKIN_posedge_posedge,
          SetupLow => tsetup_CLIENTEMACTXUNDERRUN_PHYEMACTXGMIIMIICLKIN_negedge_posedge,
          HoldLow => thold_CLIENTEMACTXUNDERRUN_PHYEMACTXGMIIMIICLKIN_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACABUS_DCREMACCLK_posedge(0),
          TimingData => Tmkr_DCREMACABUS_DCREMACCLK_posedge(0),
          TestSignal => DCREMACABUS_DCREMACCLK_dly(0),
          TestSignalName => "DCREMACABUS(0)",
          TestDelay => tisd_DCREMACABUS_DCREMACCLK(0),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACABUS_DCREMACCLK_posedge_posedge(0),
          HoldHigh => thold_DCREMACABUS_DCREMACCLK_posedge_posedge(0),
          SetupLow => tsetup_DCREMACABUS_DCREMACCLK_negedge_posedge(0),
          HoldLow => thold_DCREMACABUS_DCREMACCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACABUS_DCREMACCLK_posedge(1),
          TimingData => Tmkr_DCREMACABUS_DCREMACCLK_posedge(1),
          TestSignal => DCREMACABUS_DCREMACCLK_dly(1),
          TestSignalName => "DCREMACABUS(1)",
          TestDelay => tisd_DCREMACABUS_DCREMACCLK(1),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACABUS_DCREMACCLK_posedge_posedge(1),
          HoldHigh => thold_DCREMACABUS_DCREMACCLK_posedge_posedge(1),
          SetupLow => tsetup_DCREMACABUS_DCREMACCLK_negedge_posedge(1),
          HoldLow => thold_DCREMACABUS_DCREMACCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACABUS_DCREMACCLK_posedge(2),
          TimingData => Tmkr_DCREMACABUS_DCREMACCLK_posedge(2),
          TestSignal => DCREMACABUS_DCREMACCLK_dly(2),
          TestSignalName => "DCREMACABUS(2)",
          TestDelay => tisd_DCREMACABUS_DCREMACCLK(2),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACABUS_DCREMACCLK_posedge_posedge(2),
          HoldHigh => thold_DCREMACABUS_DCREMACCLK_posedge_posedge(2),
          SetupLow => tsetup_DCREMACABUS_DCREMACCLK_negedge_posedge(2),
          HoldLow => thold_DCREMACABUS_DCREMACCLK_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACABUS_DCREMACCLK_posedge(3),
          TimingData => Tmkr_DCREMACABUS_DCREMACCLK_posedge(3),
          TestSignal => DCREMACABUS_DCREMACCLK_dly(3),
          TestSignalName => "DCREMACABUS(3)",
          TestDelay => tisd_DCREMACABUS_DCREMACCLK(3),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACABUS_DCREMACCLK_posedge_posedge(3),
          HoldHigh => thold_DCREMACABUS_DCREMACCLK_posedge_posedge(3),
          SetupLow => tsetup_DCREMACABUS_DCREMACCLK_negedge_posedge(3),
          HoldLow => thold_DCREMACABUS_DCREMACCLK_negedge_posedge(3),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACABUS_DCREMACCLK_posedge(4),
          TimingData => Tmkr_DCREMACABUS_DCREMACCLK_posedge(4),
          TestSignal => DCREMACABUS_DCREMACCLK_dly(4),
          TestSignalName => "DCREMACABUS(4)",
          TestDelay => tisd_DCREMACABUS_DCREMACCLK(4),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACABUS_DCREMACCLK_posedge_posedge(4),
          HoldHigh => thold_DCREMACABUS_DCREMACCLK_posedge_posedge(4),
          SetupLow => tsetup_DCREMACABUS_DCREMACCLK_negedge_posedge(4),
          HoldLow => thold_DCREMACABUS_DCREMACCLK_negedge_posedge(4),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACABUS_DCREMACCLK_posedge(5),
          TimingData => Tmkr_DCREMACABUS_DCREMACCLK_posedge(5),
          TestSignal => DCREMACABUS_DCREMACCLK_dly(5),
          TestSignalName => "DCREMACABUS(5)",
          TestDelay => tisd_DCREMACABUS_DCREMACCLK(5),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACABUS_DCREMACCLK_posedge_posedge(5),
          HoldHigh => thold_DCREMACABUS_DCREMACCLK_posedge_posedge(5),
          SetupLow => tsetup_DCREMACABUS_DCREMACCLK_negedge_posedge(5),
          HoldLow => thold_DCREMACABUS_DCREMACCLK_negedge_posedge(5),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACABUS_DCREMACCLK_posedge(6),
          TimingData => Tmkr_DCREMACABUS_DCREMACCLK_posedge(6),
          TestSignal => DCREMACABUS_DCREMACCLK_dly(6),
          TestSignalName => "DCREMACABUS(6)",
          TestDelay => tisd_DCREMACABUS_DCREMACCLK(6),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACABUS_DCREMACCLK_posedge_posedge(6),
          HoldHigh => thold_DCREMACABUS_DCREMACCLK_posedge_posedge(6),
          SetupLow => tsetup_DCREMACABUS_DCREMACCLK_negedge_posedge(6),
          HoldLow => thold_DCREMACABUS_DCREMACCLK_negedge_posedge(6),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACABUS_DCREMACCLK_posedge(7),
          TimingData => Tmkr_DCREMACABUS_DCREMACCLK_posedge(7),
          TestSignal => DCREMACABUS_DCREMACCLK_dly(7),
          TestSignalName => "DCREMACABUS(7)",
          TestDelay => tisd_DCREMACABUS_DCREMACCLK(7),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACABUS_DCREMACCLK_posedge_posedge(7),
          HoldHigh => thold_DCREMACABUS_DCREMACCLK_posedge_posedge(7),
          SetupLow => tsetup_DCREMACABUS_DCREMACCLK_negedge_posedge(7),
          HoldLow => thold_DCREMACABUS_DCREMACCLK_negedge_posedge(7),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACABUS_DCREMACCLK_posedge(8),
          TimingData => Tmkr_DCREMACABUS_DCREMACCLK_posedge(8),
          TestSignal => DCREMACABUS_DCREMACCLK_dly(8),
          TestSignalName => "DCREMACABUS(8)",
          TestDelay => tisd_DCREMACABUS_DCREMACCLK(8),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACABUS_DCREMACCLK_posedge_posedge(8),
          HoldHigh => thold_DCREMACABUS_DCREMACCLK_posedge_posedge(8),
          SetupLow => tsetup_DCREMACABUS_DCREMACCLK_negedge_posedge(8),
          HoldLow => thold_DCREMACABUS_DCREMACCLK_negedge_posedge(8),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACABUS_DCREMACCLK_posedge(9),
          TimingData => Tmkr_DCREMACABUS_DCREMACCLK_posedge(9),
          TestSignal => DCREMACABUS_DCREMACCLK_dly(9),
          TestSignalName => "DCREMACABUS(9)",
          TestDelay => tisd_DCREMACABUS_DCREMACCLK(9),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACABUS_DCREMACCLK_posedge_posedge(9),
          HoldHigh => thold_DCREMACABUS_DCREMACCLK_posedge_posedge(9),
          SetupLow => tsetup_DCREMACABUS_DCREMACCLK_negedge_posedge(9),
          HoldLow => thold_DCREMACABUS_DCREMACCLK_negedge_posedge(9),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(0),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(0),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(0),
          TestSignalName => "DCREMACDBUS(0)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(0),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(0),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(0),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(0),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(1),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(1),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(1),
          TestSignalName => "DCREMACDBUS(1)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(1),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(1),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(1),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(1),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(10),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(10),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(10),
          TestSignalName => "DCREMACDBUS(10)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(10),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(10),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(10),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(10),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(10),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(11),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(11),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(11),
          TestSignalName => "DCREMACDBUS(11)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(11),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(11),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(11),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(11),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(11),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(12),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(12),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(12),
          TestSignalName => "DCREMACDBUS(12)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(12),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(12),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(12),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(12),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(12),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(13),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(13),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(13),
          TestSignalName => "DCREMACDBUS(13)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(13),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(13),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(13),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(13),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(13),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(14),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(14),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(14),
          TestSignalName => "DCREMACDBUS(14)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(14),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(14),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(14),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(14),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(14),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(15),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(15),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(15),
          TestSignalName => "DCREMACDBUS(15)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(15),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(15),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(15),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(15),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(15),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(16),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(16),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(16),
          TestSignalName => "DCREMACDBUS(16)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(16),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(16),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(16),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(16),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(16),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(17),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(17),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(17),
          TestSignalName => "DCREMACDBUS(17)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(17),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(17),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(17),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(17),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(17),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(18),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(18),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(18),
          TestSignalName => "DCREMACDBUS(18)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(18),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(18),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(18),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(18),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(18),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(19),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(19),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(19),
          TestSignalName => "DCREMACDBUS(19)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(19),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(19),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(19),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(19),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(19),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(2),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(2),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(2),
          TestSignalName => "DCREMACDBUS(2)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(2),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(2),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(2),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(2),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(20),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(20),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(20),
          TestSignalName => "DCREMACDBUS(20)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(20),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(20),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(20),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(20),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(20),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(21),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(21),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(21),
          TestSignalName => "DCREMACDBUS(21)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(21),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(21),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(21),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(21),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(21),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(22),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(22),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(22),
          TestSignalName => "DCREMACDBUS(22)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(22),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(22),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(22),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(22),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(22),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(23),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(23),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(23),
          TestSignalName => "DCREMACDBUS(23)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(23),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(23),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(23),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(23),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(23),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(24),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(24),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(24),
          TestSignalName => "DCREMACDBUS(24)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(24),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(24),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(24),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(24),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(24),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(25),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(25),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(25),
          TestSignalName => "DCREMACDBUS(25)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(25),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(25),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(25),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(25),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(25),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(26),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(26),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(26),
          TestSignalName => "DCREMACDBUS(26)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(26),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(26),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(26),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(26),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(26),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(27),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(27),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(27),
          TestSignalName => "DCREMACDBUS(27)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(27),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(27),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(27),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(27),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(27),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(28),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(28),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(28),
          TestSignalName => "DCREMACDBUS(28)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(28),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(28),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(28),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(28),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(28),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(29),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(29),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(29),
          TestSignalName => "DCREMACDBUS(29)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(29),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(29),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(29),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(29),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(29),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(3),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(3),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(3),
          TestSignalName => "DCREMACDBUS(3)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(3),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(3),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(3),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(3),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(3),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(30),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(30),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(30),
          TestSignalName => "DCREMACDBUS(30)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(30),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(30),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(30),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(30),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(30),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(31),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(31),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(31),
          TestSignalName => "DCREMACDBUS(31)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(31),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(31),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(31),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(31),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(31),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(4),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(4),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(4),
          TestSignalName => "DCREMACDBUS(4)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(4),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(4),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(4),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(4),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(4),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(5),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(5),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(5),
          TestSignalName => "DCREMACDBUS(5)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(5),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(5),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(5),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(5),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(5),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(6),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(6),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(6),
          TestSignalName => "DCREMACDBUS(6)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(6),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(6),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(6),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(6),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(6),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(7),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(7),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(7),
          TestSignalName => "DCREMACDBUS(7)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(7),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(7),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(7),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(7),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(7),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(8),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(8),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(8),
          TestSignalName => "DCREMACDBUS(8)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(8),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(8),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(8),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(8),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(8),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACDBUS_DCREMACCLK_posedge(9),
          TimingData => Tmkr_DCREMACDBUS_DCREMACCLK_posedge(9),
          TestSignal => DCREMACDBUS_DCREMACCLK_dly(9),
          TestSignalName => "DCREMACDBUS(9)",
          TestDelay => tisd_DCREMACDBUS_DCREMACCLK(9),
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACDBUS_DCREMACCLK_posedge_posedge(9),
          HoldHigh => thold_DCREMACDBUS_DCREMACCLK_posedge_posedge(9),
          SetupLow => tsetup_DCREMACDBUS_DCREMACCLK_negedge_posedge(9),
          HoldLow => thold_DCREMACDBUS_DCREMACCLK_negedge_posedge(9),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACENABLE_DCREMACCLK_posedge,
          TimingData => Tmkr_DCREMACENABLE_DCREMACCLK_posedge,
          TestSignal => DCREMACENABLE_DCREMACCLK_dly,
          TestSignalName => "DCREMACENABLE",
          TestDelay => tisd_DCREMACENABLE_DCREMACCLK,
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACENABLE_DCREMACCLK_posedge_posedge,
          HoldHigh => thold_DCREMACENABLE_DCREMACCLK_posedge_posedge,
          SetupLow => tsetup_DCREMACENABLE_DCREMACCLK_negedge_posedge,
          HoldLow => thold_DCREMACENABLE_DCREMACCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACREAD_DCREMACCLK_posedge,
          TimingData => Tmkr_DCREMACREAD_DCREMACCLK_posedge,
          TestSignal => DCREMACREAD_DCREMACCLK_dly,
          TestSignalName => "DCREMACREAD",
          TestDelay => tisd_DCREMACREAD_DCREMACCLK,
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACREAD_DCREMACCLK_posedge_posedge,
          HoldHigh => thold_DCREMACREAD_DCREMACCLK_posedge_posedge,
          SetupLow => tsetup_DCREMACREAD_DCREMACCLK_negedge_posedge,
          HoldLow => thold_DCREMACREAD_DCREMACCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_DCREMACWRITE_DCREMACCLK_posedge,
          TimingData => Tmkr_DCREMACWRITE_DCREMACCLK_posedge,
          TestSignal => DCREMACWRITE_DCREMACCLK_dly,
          TestSignalName => "DCREMACWRITE",
          TestDelay => tisd_DCREMACWRITE_DCREMACCLK,
          RefSignal => DCREMACCLK_dly,
          RefSignalName => "DCREMACCLK",
          RefDelay => ticd_DCREMACCLK,
          SetupHigh => tsetup_DCREMACWRITE_DCREMACCLK_posedge_posedge,
          HoldHigh => thold_DCREMACWRITE_DCREMACCLK_posedge_posedge,
          SetupLow => tsetup_DCREMACWRITE_DCREMACCLK_negedge_posedge,
          HoldLow => thold_DCREMACWRITE_DCREMACCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTADDR_HOSTCLK_posedge(0),
          TimingData => Tmkr_HOSTADDR_HOSTCLK_posedge(0),
          TestSignal => HOSTADDR_HOSTCLK_dly(0),
          TestSignalName => "HOSTADDR(0)",
          TestDelay => tisd_HOSTADDR_HOSTCLK(0),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTADDR_HOSTCLK_posedge_posedge(0),
          HoldHigh => thold_HOSTADDR_HOSTCLK_posedge_posedge(0),
          SetupLow => tsetup_HOSTADDR_HOSTCLK_negedge_posedge(0),
          HoldLow => thold_HOSTADDR_HOSTCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTADDR_HOSTCLK_posedge(1),
          TimingData => Tmkr_HOSTADDR_HOSTCLK_posedge(1),
          TestSignal => HOSTADDR_HOSTCLK_dly(1),
          TestSignalName => "HOSTADDR(1)",
          TestDelay => tisd_HOSTADDR_HOSTCLK(1),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTADDR_HOSTCLK_posedge_posedge(1),
          HoldHigh => thold_HOSTADDR_HOSTCLK_posedge_posedge(1),
          SetupLow => tsetup_HOSTADDR_HOSTCLK_negedge_posedge(1),
          HoldLow => thold_HOSTADDR_HOSTCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTADDR_HOSTCLK_posedge(2),
          TimingData => Tmkr_HOSTADDR_HOSTCLK_posedge(2),
          TestSignal => HOSTADDR_HOSTCLK_dly(2),
          TestSignalName => "HOSTADDR(2)",
          TestDelay => tisd_HOSTADDR_HOSTCLK(2),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTADDR_HOSTCLK_posedge_posedge(2),
          HoldHigh => thold_HOSTADDR_HOSTCLK_posedge_posedge(2),
          SetupLow => tsetup_HOSTADDR_HOSTCLK_negedge_posedge(2),
          HoldLow => thold_HOSTADDR_HOSTCLK_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTADDR_HOSTCLK_posedge(3),
          TimingData => Tmkr_HOSTADDR_HOSTCLK_posedge(3),
          TestSignal => HOSTADDR_HOSTCLK_dly(3),
          TestSignalName => "HOSTADDR(3)",
          TestDelay => tisd_HOSTADDR_HOSTCLK(3),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTADDR_HOSTCLK_posedge_posedge(3),
          HoldHigh => thold_HOSTADDR_HOSTCLK_posedge_posedge(3),
          SetupLow => tsetup_HOSTADDR_HOSTCLK_negedge_posedge(3),
          HoldLow => thold_HOSTADDR_HOSTCLK_negedge_posedge(3),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTADDR_HOSTCLK_posedge(4),
          TimingData => Tmkr_HOSTADDR_HOSTCLK_posedge(4),
          TestSignal => HOSTADDR_HOSTCLK_dly(4),
          TestSignalName => "HOSTADDR(4)",
          TestDelay => tisd_HOSTADDR_HOSTCLK(4),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTADDR_HOSTCLK_posedge_posedge(4),
          HoldHigh => thold_HOSTADDR_HOSTCLK_posedge_posedge(4),
          SetupLow => tsetup_HOSTADDR_HOSTCLK_negedge_posedge(4),
          HoldLow => thold_HOSTADDR_HOSTCLK_negedge_posedge(4),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTADDR_HOSTCLK_posedge(5),
          TimingData => Tmkr_HOSTADDR_HOSTCLK_posedge(5),
          TestSignal => HOSTADDR_HOSTCLK_dly(5),
          TestSignalName => "HOSTADDR(5)",
          TestDelay => tisd_HOSTADDR_HOSTCLK(5),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTADDR_HOSTCLK_posedge_posedge(5),
          HoldHigh => thold_HOSTADDR_HOSTCLK_posedge_posedge(5),
          SetupLow => tsetup_HOSTADDR_HOSTCLK_negedge_posedge(5),
          HoldLow => thold_HOSTADDR_HOSTCLK_negedge_posedge(5),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTADDR_HOSTCLK_posedge(6),
          TimingData => Tmkr_HOSTADDR_HOSTCLK_posedge(6),
          TestSignal => HOSTADDR_HOSTCLK_dly(6),
          TestSignalName => "HOSTADDR(6)",
          TestDelay => tisd_HOSTADDR_HOSTCLK(6),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTADDR_HOSTCLK_posedge_posedge(6),
          HoldHigh => thold_HOSTADDR_HOSTCLK_posedge_posedge(6),
          SetupLow => tsetup_HOSTADDR_HOSTCLK_negedge_posedge(6),
          HoldLow => thold_HOSTADDR_HOSTCLK_negedge_posedge(6),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTADDR_HOSTCLK_posedge(7),
          TimingData => Tmkr_HOSTADDR_HOSTCLK_posedge(7),
          TestSignal => HOSTADDR_HOSTCLK_dly(7),
          TestSignalName => "HOSTADDR(7)",
          TestDelay => tisd_HOSTADDR_HOSTCLK(7),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTADDR_HOSTCLK_posedge_posedge(7),
          HoldHigh => thold_HOSTADDR_HOSTCLK_posedge_posedge(7),
          SetupLow => tsetup_HOSTADDR_HOSTCLK_negedge_posedge(7),
          HoldLow => thold_HOSTADDR_HOSTCLK_negedge_posedge(7),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTADDR_HOSTCLK_posedge(8),
          TimingData => Tmkr_HOSTADDR_HOSTCLK_posedge(8),
          TestSignal => HOSTADDR_HOSTCLK_dly(8),
          TestSignalName => "HOSTADDR(8)",
          TestDelay => tisd_HOSTADDR_HOSTCLK(8),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTADDR_HOSTCLK_posedge_posedge(8),
          HoldHigh => thold_HOSTADDR_HOSTCLK_posedge_posedge(8),
          SetupLow => tsetup_HOSTADDR_HOSTCLK_negedge_posedge(8),
          HoldLow => thold_HOSTADDR_HOSTCLK_negedge_posedge(8),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTADDR_HOSTCLK_posedge(9),
          TimingData => Tmkr_HOSTADDR_HOSTCLK_posedge(9),
          TestSignal => HOSTADDR_HOSTCLK_dly(9),
          TestSignalName => "HOSTADDR(9)",
          TestDelay => tisd_HOSTADDR_HOSTCLK(9),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTADDR_HOSTCLK_posedge_posedge(9),
          HoldHigh => thold_HOSTADDR_HOSTCLK_posedge_posedge(9),
          SetupLow => tsetup_HOSTADDR_HOSTCLK_negedge_posedge(9),
          HoldLow => thold_HOSTADDR_HOSTCLK_negedge_posedge(9),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTMIIMSEL_HOSTCLK_posedge,
          TimingData => Tmkr_HOSTMIIMSEL_HOSTCLK_posedge,
          TestSignal => HOSTMIIMSEL_HOSTCLK_dly,
          TestSignalName => "HOSTMIIMSEL",
          TestDelay => tisd_HOSTMIIMSEL_HOSTCLK,
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTMIIMSEL_HOSTCLK_posedge_posedge,
          HoldHigh => thold_HOSTMIIMSEL_HOSTCLK_posedge_posedge,
          SetupLow => tsetup_HOSTMIIMSEL_HOSTCLK_negedge_posedge,
          HoldLow => thold_HOSTMIIMSEL_HOSTCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTOPCODE_HOSTCLK_posedge(0),
          TimingData => Tmkr_HOSTOPCODE_HOSTCLK_posedge(0),
          TestSignal => HOSTOPCODE_HOSTCLK_dly(0),
          TestSignalName => "HOSTOPCODE(0)",
          TestDelay => tisd_HOSTOPCODE_HOSTCLK(0),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTOPCODE_HOSTCLK_posedge_posedge(0),
          HoldHigh => thold_HOSTOPCODE_HOSTCLK_posedge_posedge(0),
          SetupLow => tsetup_HOSTOPCODE_HOSTCLK_negedge_posedge(0),
          HoldLow => thold_HOSTOPCODE_HOSTCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTOPCODE_HOSTCLK_posedge(1),
          TimingData => Tmkr_HOSTOPCODE_HOSTCLK_posedge(1),
          TestSignal => HOSTOPCODE_HOSTCLK_dly(1),
          TestSignalName => "HOSTOPCODE(1)",
          TestDelay => tisd_HOSTOPCODE_HOSTCLK(1),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTOPCODE_HOSTCLK_posedge_posedge(1),
          HoldHigh => thold_HOSTOPCODE_HOSTCLK_posedge_posedge(1),
          SetupLow => tsetup_HOSTOPCODE_HOSTCLK_negedge_posedge(1),
          HoldLow => thold_HOSTOPCODE_HOSTCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTREQ_HOSTCLK_posedge,
          TimingData => Tmkr_HOSTREQ_HOSTCLK_posedge,
          TestSignal => HOSTREQ_HOSTCLK_dly,
          TestSignalName => "HOSTREQ",
          TestDelay => tisd_HOSTREQ_HOSTCLK,
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTREQ_HOSTCLK_posedge_posedge,
          HoldHigh => thold_HOSTREQ_HOSTCLK_posedge_posedge,
          SetupLow => tsetup_HOSTREQ_HOSTCLK_negedge_posedge,
          HoldLow => thold_HOSTREQ_HOSTCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(0),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(0),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(0),
          TestSignalName => "HOSTWRDATA(0)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(0),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(0),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(0),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(0),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(1),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(1),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(1),
          TestSignalName => "HOSTWRDATA(1)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(1),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(1),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(1),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(1),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(10),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(10),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(10),
          TestSignalName => "HOSTWRDATA(10)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(10),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(10),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(10),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(10),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(10),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(11),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(11),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(11),
          TestSignalName => "HOSTWRDATA(11)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(11),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(11),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(11),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(11),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(11),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(12),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(12),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(12),
          TestSignalName => "HOSTWRDATA(12)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(12),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(12),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(12),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(12),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(12),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(13),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(13),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(13),
          TestSignalName => "HOSTWRDATA(13)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(13),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(13),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(13),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(13),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(13),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(14),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(14),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(14),
          TestSignalName => "HOSTWRDATA(14)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(14),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(14),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(14),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(14),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(14),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(15),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(15),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(15),
          TestSignalName => "HOSTWRDATA(15)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(15),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(15),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(15),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(15),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(15),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(16),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(16),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(16),
          TestSignalName => "HOSTWRDATA(16)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(16),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(16),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(16),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(16),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(16),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(17),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(17),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(17),
          TestSignalName => "HOSTWRDATA(17)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(17),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(17),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(17),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(17),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(17),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(18),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(18),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(18),
          TestSignalName => "HOSTWRDATA(18)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(18),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(18),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(18),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(18),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(18),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(19),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(19),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(19),
          TestSignalName => "HOSTWRDATA(19)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(19),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(19),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(19),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(19),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(19),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(2),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(2),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(2),
          TestSignalName => "HOSTWRDATA(2)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(2),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(2),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(2),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(2),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(20),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(20),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(20),
          TestSignalName => "HOSTWRDATA(20)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(20),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(20),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(20),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(20),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(20),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(21),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(21),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(21),
          TestSignalName => "HOSTWRDATA(21)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(21),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(21),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(21),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(21),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(21),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(22),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(22),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(22),
          TestSignalName => "HOSTWRDATA(22)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(22),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(22),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(22),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(22),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(22),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(23),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(23),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(23),
          TestSignalName => "HOSTWRDATA(23)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(23),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(23),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(23),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(23),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(23),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(24),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(24),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(24),
          TestSignalName => "HOSTWRDATA(24)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(24),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(24),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(24),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(24),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(24),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(25),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(25),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(25),
          TestSignalName => "HOSTWRDATA(25)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(25),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(25),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(25),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(25),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(25),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(26),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(26),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(26),
          TestSignalName => "HOSTWRDATA(26)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(26),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(26),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(26),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(26),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(26),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(27),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(27),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(27),
          TestSignalName => "HOSTWRDATA(27)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(27),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(27),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(27),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(27),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(27),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(28),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(28),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(28),
          TestSignalName => "HOSTWRDATA(28)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(28),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(28),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(28),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(28),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(28),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(29),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(29),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(29),
          TestSignalName => "HOSTWRDATA(29)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(29),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(29),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(29),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(29),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(29),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(3),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(3),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(3),
          TestSignalName => "HOSTWRDATA(3)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(3),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(3),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(3),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(3),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(3),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(30),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(30),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(30),
          TestSignalName => "HOSTWRDATA(30)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(30),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(30),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(30),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(30),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(30),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(31),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(31),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(31),
          TestSignalName => "HOSTWRDATA(31)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(31),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(31),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(31),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(31),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(31),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(4),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(4),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(4),
          TestSignalName => "HOSTWRDATA(4)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(4),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(4),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(4),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(4),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(4),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(5),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(5),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(5),
          TestSignalName => "HOSTWRDATA(5)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(5),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(5),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(5),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(5),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(5),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(6),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(6),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(6),
          TestSignalName => "HOSTWRDATA(6)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(6),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(6),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(6),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(6),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(6),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(7),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(7),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(7),
          TestSignalName => "HOSTWRDATA(7)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(7),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(7),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(7),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(7),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(7),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(8),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(8),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(8),
          TestSignalName => "HOSTWRDATA(8)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(8),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(8),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(8),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(8),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(8),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_HOSTWRDATA_HOSTCLK_posedge(9),
          TimingData => Tmkr_HOSTWRDATA_HOSTCLK_posedge(9),
          TestSignal => HOSTWRDATA_HOSTCLK_dly(9),
          TestSignalName => "HOSTWRDATA(9)",
          TestDelay => tisd_HOSTWRDATA_HOSTCLK(9),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(9),
          HoldHigh => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(9),
          SetupLow => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(9),
          HoldLow => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(9),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACCOL_PHYEMACGTXCLK_posedge,
          TimingData => Tmkr_PHYEMACCOL_PHYEMACGTXCLK_posedge,
          TestSignal => PHYEMACCOL_PHYEMACGTXCLK_dly,
          TestSignalName => "PHYEMACCOL",
          TestDelay => tisd_PHYEMACCOL_PHYEMACGTXCLK,
          RefSignal => PHYEMACGTXCLK_dly,
          RefSignalName => "PHYEMACGTXCLK",
          RefDelay => ticd_PHYEMACGTXCLK,
          SetupHigh => tsetup_PHYEMACCOL_PHYEMACGTXCLK_posedge_posedge,
          HoldHigh => thold_PHYEMACCOL_PHYEMACGTXCLK_posedge_posedge,
          SetupLow => tsetup_PHYEMACCOL_PHYEMACGTXCLK_negedge_posedge,
          HoldLow => thold_PHYEMACCOL_PHYEMACGTXCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACCOL_PHYEMACRXCLK_posedge,
          TimingData => Tmkr_PHYEMACCOL_PHYEMACRXCLK_posedge,
          TestSignal => PHYEMACCOL_PHYEMACRXCLK_dly,
          TestSignalName => "PHYEMACCOL",
          TestDelay => tisd_PHYEMACCOL_PHYEMACRXCLK,
          RefSignal => PHYEMACRXCLK_dly,
          RefSignalName => "PHYEMACRXCLK",
          RefDelay => ticd_PHYEMACRXCLK,
          SetupHigh => tsetup_PHYEMACCOL_PHYEMACRXCLK_posedge_posedge,
          HoldHigh => thold_PHYEMACCOL_PHYEMACRXCLK_posedge_posedge,
          SetupLow => tsetup_PHYEMACCOL_PHYEMACRXCLK_negedge_posedge,
          HoldLow => thold_PHYEMACCOL_PHYEMACRXCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACCRS_PHYEMACGTXCLK_posedge,
          TimingData => Tmkr_PHYEMACCRS_PHYEMACGTXCLK_posedge,
          TestSignal => PHYEMACCRS_PHYEMACGTXCLK_dly,
          TestSignalName => "PHYEMACCRS",
          TestDelay => tisd_PHYEMACCRS_PHYEMACGTXCLK,
          RefSignal => PHYEMACGTXCLK_dly,
          RefSignalName => "PHYEMACGTXCLK",
          RefDelay => ticd_PHYEMACGTXCLK,
          SetupHigh => tsetup_PHYEMACCRS_PHYEMACGTXCLK_posedge_posedge,
          HoldHigh => thold_PHYEMACCRS_PHYEMACGTXCLK_posedge_posedge,
          SetupLow => tsetup_PHYEMACCRS_PHYEMACGTXCLK_negedge_posedge,
          HoldLow => thold_PHYEMACCRS_PHYEMACGTXCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACCRS_PHYEMACRXCLK_posedge,
          TimingData => Tmkr_PHYEMACCRS_PHYEMACRXCLK_posedge,
          TestSignal => PHYEMACCRS_PHYEMACRXCLK_dly,
          TestSignalName => "PHYEMACCRS",
          TestDelay => tisd_PHYEMACCRS_PHYEMACRXCLK,
          RefSignal => PHYEMACRXCLK_dly,
          RefSignalName => "PHYEMACRXCLK",
          RefDelay => ticd_PHYEMACRXCLK,
          SetupHigh => tsetup_PHYEMACCRS_PHYEMACRXCLK_posedge_posedge,
          HoldHigh => thold_PHYEMACCRS_PHYEMACRXCLK_posedge_posedge,
          SetupLow => tsetup_PHYEMACCRS_PHYEMACRXCLK_negedge_posedge,
          HoldLow => thold_PHYEMACCRS_PHYEMACRXCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACMDIN_HOSTCLK_posedge,
          TimingData => Tmkr_PHYEMACMDIN_HOSTCLK_posedge,
          TestSignal => PHYEMACMDIN_HOSTCLK_dly,
          TestSignalName => "PHYEMACMDIN",
          TestDelay => tisd_PHYEMACMDIN_HOSTCLK,
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_PHYEMACMDIN_HOSTCLK_posedge_posedge,
          HoldHigh => thold_PHYEMACMDIN_HOSTCLK_posedge_posedge,
          SetupLow => tsetup_PHYEMACMDIN_HOSTCLK_negedge_posedge,
          HoldLow => thold_PHYEMACMDIN_HOSTCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACMDIN_PHYEMACMCLKIN_posedge,
          TimingData => Tmkr_PHYEMACMDIN_PHYEMACMCLKIN_posedge,
          TestSignal => PHYEMACMDIN_PHYEMACMCLKIN_dly,
          TestSignalName => "PHYEMACMDIN",
          TestDelay => tisd_PHYEMACMDIN_PHYEMACMCLKIN,
          RefSignal => PHYEMACMCLKIN_dly,
          RefSignalName => "PHYEMACMCLKIN",
          RefDelay => ticd_PHYEMACMCLKIN,
          SetupHigh => tsetup_PHYEMACMDIN_PHYEMACMCLKIN_posedge_posedge,
          HoldHigh => thold_PHYEMACMDIN_PHYEMACMCLKIN_posedge_posedge,
          SetupLow => tsetup_PHYEMACMDIN_PHYEMACMCLKIN_negedge_posedge,
          HoldLow => thold_PHYEMACMDIN_PHYEMACMCLKIN_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACPHYAD_HOSTCLK_posedge(0),
          TimingData => Tmkr_PHYEMACPHYAD_HOSTCLK_posedge(0),
          TestSignal => PHYEMACPHYAD_HOSTCLK_dly(0),
          TestSignalName => "PHYEMACPHYAD(0)",
          TestDelay => tisd_PHYEMACPHYAD_HOSTCLK(0),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_PHYEMACPHYAD_HOSTCLK_posedge_posedge(0),
          HoldHigh => thold_PHYEMACPHYAD_HOSTCLK_posedge_posedge(0),
          SetupLow => tsetup_PHYEMACPHYAD_HOSTCLK_negedge_posedge(0),
          HoldLow => thold_PHYEMACPHYAD_HOSTCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACPHYAD_HOSTCLK_posedge(1),
          TimingData => Tmkr_PHYEMACPHYAD_HOSTCLK_posedge(1),
          TestSignal => PHYEMACPHYAD_HOSTCLK_dly(1),
          TestSignalName => "PHYEMACPHYAD(1)",
          TestDelay => tisd_PHYEMACPHYAD_HOSTCLK(1),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_PHYEMACPHYAD_HOSTCLK_posedge_posedge(1),
          HoldHigh => thold_PHYEMACPHYAD_HOSTCLK_posedge_posedge(1),
          SetupLow => tsetup_PHYEMACPHYAD_HOSTCLK_negedge_posedge(1),
          HoldLow => thold_PHYEMACPHYAD_HOSTCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACPHYAD_HOSTCLK_posedge(2),
          TimingData => Tmkr_PHYEMACPHYAD_HOSTCLK_posedge(2),
          TestSignal => PHYEMACPHYAD_HOSTCLK_dly(2),
          TestSignalName => "PHYEMACPHYAD(2)",
          TestDelay => tisd_PHYEMACPHYAD_HOSTCLK(2),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_PHYEMACPHYAD_HOSTCLK_posedge_posedge(2),
          HoldHigh => thold_PHYEMACPHYAD_HOSTCLK_posedge_posedge(2),
          SetupLow => tsetup_PHYEMACPHYAD_HOSTCLK_negedge_posedge(2),
          HoldLow => thold_PHYEMACPHYAD_HOSTCLK_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACPHYAD_HOSTCLK_posedge(3),
          TimingData => Tmkr_PHYEMACPHYAD_HOSTCLK_posedge(3),
          TestSignal => PHYEMACPHYAD_HOSTCLK_dly(3),
          TestSignalName => "PHYEMACPHYAD(3)",
          TestDelay => tisd_PHYEMACPHYAD_HOSTCLK(3),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_PHYEMACPHYAD_HOSTCLK_posedge_posedge(3),
          HoldHigh => thold_PHYEMACPHYAD_HOSTCLK_posedge_posedge(3),
          SetupLow => tsetup_PHYEMACPHYAD_HOSTCLK_negedge_posedge(3),
          HoldLow => thold_PHYEMACPHYAD_HOSTCLK_negedge_posedge(3),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACPHYAD_HOSTCLK_posedge(4),
          TimingData => Tmkr_PHYEMACPHYAD_HOSTCLK_posedge(4),
          TestSignal => PHYEMACPHYAD_HOSTCLK_dly(4),
          TestSignalName => "PHYEMACPHYAD(4)",
          TestDelay => tisd_PHYEMACPHYAD_HOSTCLK(4),
          RefSignal => HOSTCLK_dly,
          RefSignalName => "HOSTCLK",
          RefDelay => ticd_HOSTCLK,
          SetupHigh => tsetup_PHYEMACPHYAD_HOSTCLK_posedge_posedge(4),
          HoldHigh => thold_PHYEMACPHYAD_HOSTCLK_posedge_posedge(4),
          SetupLow => tsetup_PHYEMACPHYAD_HOSTCLK_negedge_posedge(4),
          HoldLow => thold_PHYEMACPHYAD_HOSTCLK_negedge_posedge(4),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXBUFSTATUS_PHYEMACGTXCLK_posedge(0),
          TimingData => Tmkr_PHYEMACRXBUFSTATUS_PHYEMACGTXCLK_posedge(0),
          TestSignal => PHYEMACRXBUFSTATUS_PHYEMACGTXCLK_dly(0),
          TestSignalName => "PHYEMACRXBUFSTATUS(0)",
          TestDelay => tisd_PHYEMACRXBUFSTATUS_PHYEMACGTXCLK(0),
          RefSignal => PHYEMACGTXCLK_dly,
          RefSignalName => "PHYEMACGTXCLK",
          RefDelay => ticd_PHYEMACGTXCLK,
          SetupHigh => tsetup_PHYEMACRXBUFSTATUS_PHYEMACGTXCLK_posedge_posedge(0),
          HoldHigh => thold_PHYEMACRXBUFSTATUS_PHYEMACGTXCLK_posedge_posedge(0),
          SetupLow => tsetup_PHYEMACRXBUFSTATUS_PHYEMACGTXCLK_negedge_posedge(0),
          HoldLow => thold_PHYEMACRXBUFSTATUS_PHYEMACGTXCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXBUFSTATUS_PHYEMACGTXCLK_posedge(1),
          TimingData => Tmkr_PHYEMACRXBUFSTATUS_PHYEMACGTXCLK_posedge(1),
          TestSignal => PHYEMACRXBUFSTATUS_PHYEMACGTXCLK_dly(1),
          TestSignalName => "PHYEMACRXBUFSTATUS(1)",
          TestDelay => tisd_PHYEMACRXBUFSTATUS_PHYEMACGTXCLK(1),
          RefSignal => PHYEMACGTXCLK_dly,
          RefSignalName => "PHYEMACGTXCLK",
          RefDelay => ticd_PHYEMACGTXCLK,
          SetupHigh => tsetup_PHYEMACRXBUFSTATUS_PHYEMACGTXCLK_posedge_posedge(1),
          HoldHigh => thold_PHYEMACRXBUFSTATUS_PHYEMACGTXCLK_posedge_posedge(1),
          SetupLow => tsetup_PHYEMACRXBUFSTATUS_PHYEMACGTXCLK_negedge_posedge(1),
          HoldLow => thold_PHYEMACRXBUFSTATUS_PHYEMACGTXCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXBUFSTATUS_PHYEMACRXCLK_posedge(0),
          TimingData => Tmkr_PHYEMACRXBUFSTATUS_PHYEMACRXCLK_posedge(0),
          TestSignal => PHYEMACRXBUFSTATUS_PHYEMACRXCLK_dly(0),
          TestSignalName => "PHYEMACRXBUFSTATUS(0)",
          TestDelay => tisd_PHYEMACRXBUFSTATUS_PHYEMACRXCLK(0),
          RefSignal => PHYEMACRXCLK_dly,
          RefSignalName => "PHYEMACRXCLK",
          RefDelay => ticd_PHYEMACRXCLK,
          SetupHigh => tsetup_PHYEMACRXBUFSTATUS_PHYEMACRXCLK_posedge_posedge(0),
          HoldHigh => thold_PHYEMACRXBUFSTATUS_PHYEMACRXCLK_posedge_posedge(0),
          SetupLow => tsetup_PHYEMACRXBUFSTATUS_PHYEMACRXCLK_negedge_posedge(0),
          HoldLow => thold_PHYEMACRXBUFSTATUS_PHYEMACRXCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXBUFSTATUS_PHYEMACRXCLK_posedge(1),
          TimingData => Tmkr_PHYEMACRXBUFSTATUS_PHYEMACRXCLK_posedge(1),
          TestSignal => PHYEMACRXBUFSTATUS_PHYEMACRXCLK_dly(1),
          TestSignalName => "PHYEMACRXBUFSTATUS(1)",
          TestDelay => tisd_PHYEMACRXBUFSTATUS_PHYEMACRXCLK(1),
          RefSignal => PHYEMACRXCLK_dly,
          RefSignalName => "PHYEMACRXCLK",
          RefDelay => ticd_PHYEMACRXCLK,
          SetupHigh => tsetup_PHYEMACRXBUFSTATUS_PHYEMACRXCLK_posedge_posedge(1),
          HoldHigh => thold_PHYEMACRXBUFSTATUS_PHYEMACRXCLK_posedge_posedge(1),
          SetupLow => tsetup_PHYEMACRXBUFSTATUS_PHYEMACRXCLK_negedge_posedge(1),
          HoldLow => thold_PHYEMACRXBUFSTATUS_PHYEMACRXCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXCHARISCOMMA_PHYEMACGTXCLK_posedge,
          TimingData => Tmkr_PHYEMACRXCHARISCOMMA_PHYEMACGTXCLK_posedge,
          TestSignal => PHYEMACRXCHARISCOMMA_PHYEMACGTXCLK_dly,
          TestSignalName => "PHYEMACRXCHARISCOMMA",
          TestDelay => tisd_PHYEMACRXCHARISCOMMA_PHYEMACGTXCLK,
          RefSignal => PHYEMACGTXCLK_dly,
          RefSignalName => "PHYEMACGTXCLK",
          RefDelay => ticd_PHYEMACGTXCLK,
          SetupHigh => tsetup_PHYEMACRXCHARISCOMMA_PHYEMACGTXCLK_posedge_posedge,
          HoldHigh => thold_PHYEMACRXCHARISCOMMA_PHYEMACGTXCLK_posedge_posedge,
          SetupLow => tsetup_PHYEMACRXCHARISCOMMA_PHYEMACGTXCLK_negedge_posedge,
          HoldLow => thold_PHYEMACRXCHARISCOMMA_PHYEMACGTXCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXCHARISCOMMA_PHYEMACRXCLK_posedge,
          TimingData => Tmkr_PHYEMACRXCHARISCOMMA_PHYEMACRXCLK_posedge,
          TestSignal => PHYEMACRXCHARISCOMMA_PHYEMACRXCLK_dly,
          TestSignalName => "PHYEMACRXCHARISCOMMA",
          TestDelay => tisd_PHYEMACRXCHARISCOMMA_PHYEMACRXCLK,
          RefSignal => PHYEMACRXCLK_dly,
          RefSignalName => "PHYEMACRXCLK",
          RefDelay => ticd_PHYEMACRXCLK,
          SetupHigh => tsetup_PHYEMACRXCHARISCOMMA_PHYEMACRXCLK_posedge_posedge,
          HoldHigh => thold_PHYEMACRXCHARISCOMMA_PHYEMACRXCLK_posedge_posedge,
          SetupLow => tsetup_PHYEMACRXCHARISCOMMA_PHYEMACRXCLK_negedge_posedge,
          HoldLow => thold_PHYEMACRXCHARISCOMMA_PHYEMACRXCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXCHARISK_PHYEMACGTXCLK_posedge,
          TimingData => Tmkr_PHYEMACRXCHARISK_PHYEMACGTXCLK_posedge,
          TestSignal => PHYEMACRXCHARISK_PHYEMACGTXCLK_dly,
          TestSignalName => "PHYEMACRXCHARISK",
          TestDelay => tisd_PHYEMACRXCHARISK_PHYEMACGTXCLK,
          RefSignal => PHYEMACGTXCLK_dly,
          RefSignalName => "PHYEMACGTXCLK",
          RefDelay => ticd_PHYEMACGTXCLK,
          SetupHigh => tsetup_PHYEMACRXCHARISK_PHYEMACGTXCLK_posedge_posedge,
          HoldHigh => thold_PHYEMACRXCHARISK_PHYEMACGTXCLK_posedge_posedge,
          SetupLow => tsetup_PHYEMACRXCHARISK_PHYEMACGTXCLK_negedge_posedge,
          HoldLow => thold_PHYEMACRXCHARISK_PHYEMACGTXCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXCHARISK_PHYEMACRXCLK_posedge,
          TimingData => Tmkr_PHYEMACRXCHARISK_PHYEMACRXCLK_posedge,
          TestSignal => PHYEMACRXCHARISK_PHYEMACRXCLK_dly,
          TestSignalName => "PHYEMACRXCHARISK",
          TestDelay => tisd_PHYEMACRXCHARISK_PHYEMACRXCLK,
          RefSignal => PHYEMACRXCLK_dly,
          RefSignalName => "PHYEMACRXCLK",
          RefDelay => ticd_PHYEMACRXCLK,
          SetupHigh => tsetup_PHYEMACRXCHARISK_PHYEMACRXCLK_posedge_posedge,
          HoldHigh => thold_PHYEMACRXCHARISK_PHYEMACRXCLK_posedge_posedge,
          SetupLow => tsetup_PHYEMACRXCHARISK_PHYEMACRXCLK_negedge_posedge,
          HoldLow => thold_PHYEMACRXCHARISK_PHYEMACRXCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_posedge(0),
          TimingData => Tmkr_PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_posedge(0),
          TestSignal => PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_dly(0),
          TestSignalName => "PHYEMACRXCLKCORCNT(0)",
          TestDelay => tisd_PHYEMACRXCLKCORCNT_PHYEMACGTXCLK(0),
          RefSignal => PHYEMACGTXCLK_dly,
          RefSignalName => "PHYEMACGTXCLK",
          RefDelay => ticd_PHYEMACGTXCLK,
          SetupHigh => tsetup_PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_posedge_posedge(0),
          HoldHigh => thold_PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_posedge_posedge(0),
          SetupLow => tsetup_PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_negedge_posedge(0),
          HoldLow => thold_PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_posedge(1),
          TimingData => Tmkr_PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_posedge(1),
          TestSignal => PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_dly(1),
          TestSignalName => "PHYEMACRXCLKCORCNT(1)",
          TestDelay => tisd_PHYEMACRXCLKCORCNT_PHYEMACGTXCLK(1),
          RefSignal => PHYEMACGTXCLK_dly,
          RefSignalName => "PHYEMACGTXCLK",
          RefDelay => ticd_PHYEMACGTXCLK,
          SetupHigh => tsetup_PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_posedge_posedge(1),
          HoldHigh => thold_PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_posedge_posedge(1),
          SetupLow => tsetup_PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_negedge_posedge(1),
          HoldLow => thold_PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_posedge(2),
          TimingData => Tmkr_PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_posedge(2),
          TestSignal => PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_dly(2),
          TestSignalName => "PHYEMACRXCLKCORCNT(2)",
          TestDelay => tisd_PHYEMACRXCLKCORCNT_PHYEMACGTXCLK(2),
          RefSignal => PHYEMACGTXCLK_dly,
          RefSignalName => "PHYEMACGTXCLK",
          RefDelay => ticd_PHYEMACGTXCLK,
          SetupHigh => tsetup_PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_posedge_posedge(2),
          HoldHigh => thold_PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_posedge_posedge(2),
          SetupLow => tsetup_PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_negedge_posedge(2),
          HoldLow => thold_PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXCLKCORCNT_PHYEMACRXCLK_posedge(0),
          TimingData => Tmkr_PHYEMACRXCLKCORCNT_PHYEMACRXCLK_posedge(0),
          TestSignal => PHYEMACRXCLKCORCNT_PHYEMACRXCLK_dly(0),
          TestSignalName => "PHYEMACRXCLKCORCNT(0)",
          TestDelay => tisd_PHYEMACRXCLKCORCNT_PHYEMACRXCLK(0),
          RefSignal => PHYEMACRXCLK_dly,
          RefSignalName => "PHYEMACRXCLK",
          RefDelay => ticd_PHYEMACRXCLK,
          SetupHigh => tsetup_PHYEMACRXCLKCORCNT_PHYEMACRXCLK_posedge_posedge(0),
          HoldHigh => thold_PHYEMACRXCLKCORCNT_PHYEMACRXCLK_posedge_posedge(0),
          SetupLow => tsetup_PHYEMACRXCLKCORCNT_PHYEMACRXCLK_negedge_posedge(0),
          HoldLow => thold_PHYEMACRXCLKCORCNT_PHYEMACRXCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXCLKCORCNT_PHYEMACRXCLK_posedge(1),
          TimingData => Tmkr_PHYEMACRXCLKCORCNT_PHYEMACRXCLK_posedge(1),
          TestSignal => PHYEMACRXCLKCORCNT_PHYEMACRXCLK_dly(1),
          TestSignalName => "PHYEMACRXCLKCORCNT(1)",
          TestDelay => tisd_PHYEMACRXCLKCORCNT_PHYEMACRXCLK(1),
          RefSignal => PHYEMACRXCLK_dly,
          RefSignalName => "PHYEMACRXCLK",
          RefDelay => ticd_PHYEMACRXCLK,
          SetupHigh => tsetup_PHYEMACRXCLKCORCNT_PHYEMACRXCLK_posedge_posedge(1),
          HoldHigh => thold_PHYEMACRXCLKCORCNT_PHYEMACRXCLK_posedge_posedge(1),
          SetupLow => tsetup_PHYEMACRXCLKCORCNT_PHYEMACRXCLK_negedge_posedge(1),
          HoldLow => thold_PHYEMACRXCLKCORCNT_PHYEMACRXCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXCLKCORCNT_PHYEMACRXCLK_posedge(2),
          TimingData => Tmkr_PHYEMACRXCLKCORCNT_PHYEMACRXCLK_posedge(2),
          TestSignal => PHYEMACRXCLKCORCNT_PHYEMACRXCLK_dly(2),
          TestSignalName => "PHYEMACRXCLKCORCNT(2)",
          TestDelay => tisd_PHYEMACRXCLKCORCNT_PHYEMACRXCLK(2),
          RefSignal => PHYEMACRXCLK_dly,
          RefSignalName => "PHYEMACRXCLK",
          RefDelay => ticd_PHYEMACRXCLK,
          SetupHigh => tsetup_PHYEMACRXCLKCORCNT_PHYEMACRXCLK_posedge_posedge(2),
          HoldHigh => thold_PHYEMACRXCLKCORCNT_PHYEMACRXCLK_posedge_posedge(2),
          SetupLow => tsetup_PHYEMACRXCLKCORCNT_PHYEMACRXCLK_negedge_posedge(2),
          HoldLow => thold_PHYEMACRXCLKCORCNT_PHYEMACRXCLK_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXDISPERR_PHYEMACGTXCLK_posedge,
          TimingData => Tmkr_PHYEMACRXDISPERR_PHYEMACGTXCLK_posedge,
          TestSignal => PHYEMACRXDISPERR_PHYEMACGTXCLK_dly,
          TestSignalName => "PHYEMACRXDISPERR",
          TestDelay => tisd_PHYEMACRXDISPERR_PHYEMACGTXCLK,
          RefSignal => PHYEMACGTXCLK_dly,
          RefSignalName => "PHYEMACGTXCLK",
          RefDelay => ticd_PHYEMACGTXCLK,
          SetupHigh => tsetup_PHYEMACRXDISPERR_PHYEMACGTXCLK_posedge_posedge,
          HoldHigh => thold_PHYEMACRXDISPERR_PHYEMACGTXCLK_posedge_posedge,
          SetupLow => tsetup_PHYEMACRXDISPERR_PHYEMACGTXCLK_negedge_posedge,
          HoldLow => thold_PHYEMACRXDISPERR_PHYEMACGTXCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXDISPERR_PHYEMACRXCLK_posedge,
          TimingData => Tmkr_PHYEMACRXDISPERR_PHYEMACRXCLK_posedge,
          TestSignal => PHYEMACRXDISPERR_PHYEMACRXCLK_dly,
          TestSignalName => "PHYEMACRXDISPERR",
          TestDelay => tisd_PHYEMACRXDISPERR_PHYEMACRXCLK,
          RefSignal => PHYEMACRXCLK_dly,
          RefSignalName => "PHYEMACRXCLK",
          RefDelay => ticd_PHYEMACRXCLK,
          SetupHigh => tsetup_PHYEMACRXDISPERR_PHYEMACRXCLK_posedge_posedge,
          HoldHigh => thold_PHYEMACRXDISPERR_PHYEMACRXCLK_posedge_posedge,
          SetupLow => tsetup_PHYEMACRXDISPERR_PHYEMACRXCLK_negedge_posedge,
          HoldLow => thold_PHYEMACRXDISPERR_PHYEMACRXCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXDV_PHYEMACGTXCLK_posedge,
          TimingData => Tmkr_PHYEMACRXDV_PHYEMACGTXCLK_posedge,
          TestSignal => PHYEMACRXDV_PHYEMACGTXCLK_dly,
          TestSignalName => "PHYEMACRXDV",
          TestDelay => tisd_PHYEMACRXDV_PHYEMACGTXCLK,
          RefSignal => PHYEMACGTXCLK_dly,
          RefSignalName => "PHYEMACGTXCLK",
          RefDelay => ticd_PHYEMACGTXCLK,
          SetupHigh => tsetup_PHYEMACRXDV_PHYEMACGTXCLK_posedge_posedge,
          HoldHigh => thold_PHYEMACRXDV_PHYEMACGTXCLK_posedge_posedge,
          SetupLow => tsetup_PHYEMACRXDV_PHYEMACGTXCLK_negedge_posedge,
          HoldLow => thold_PHYEMACRXDV_PHYEMACGTXCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXDV_PHYEMACRXCLK_posedge,
          TimingData => Tmkr_PHYEMACRXDV_PHYEMACRXCLK_posedge,
          TestSignal => PHYEMACRXDV_PHYEMACRXCLK_dly,
          TestSignalName => "PHYEMACRXDV",
          TestDelay => tisd_PHYEMACRXDV_PHYEMACRXCLK,
          RefSignal => PHYEMACRXCLK_dly,
          RefSignalName => "PHYEMACRXCLK",
          RefDelay => ticd_PHYEMACRXCLK,
          SetupHigh => tsetup_PHYEMACRXDV_PHYEMACRXCLK_posedge_posedge,
          HoldHigh => thold_PHYEMACRXDV_PHYEMACRXCLK_posedge_posedge,
          SetupLow => tsetup_PHYEMACRXDV_PHYEMACRXCLK_negedge_posedge,
          HoldLow => thold_PHYEMACRXDV_PHYEMACRXCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXD_PHYEMACGTXCLK_posedge(0),
          TimingData => Tmkr_PHYEMACRXD_PHYEMACGTXCLK_posedge(0),
          TestSignal => PHYEMACRXD_PHYEMACGTXCLK_dly(0),
          TestSignalName => "PHYEMACRXD(0)",
          TestDelay => tisd_PHYEMACRXD_PHYEMACGTXCLK(0),
          RefSignal => PHYEMACGTXCLK_dly,
          RefSignalName => "PHYEMACGTXCLK",
          RefDelay => ticd_PHYEMACGTXCLK,
          SetupHigh => tsetup_PHYEMACRXD_PHYEMACGTXCLK_posedge_posedge(0),
          HoldHigh => thold_PHYEMACRXD_PHYEMACGTXCLK_posedge_posedge(0),
          SetupLow => tsetup_PHYEMACRXD_PHYEMACGTXCLK_negedge_posedge(0),
          HoldLow => thold_PHYEMACRXD_PHYEMACGTXCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXD_PHYEMACGTXCLK_posedge(1),
          TimingData => Tmkr_PHYEMACRXD_PHYEMACGTXCLK_posedge(1),
          TestSignal => PHYEMACRXD_PHYEMACGTXCLK_dly(1),
          TestSignalName => "PHYEMACRXD(1)",
          TestDelay => tisd_PHYEMACRXD_PHYEMACGTXCLK(1),
          RefSignal => PHYEMACGTXCLK_dly,
          RefSignalName => "PHYEMACGTXCLK",
          RefDelay => ticd_PHYEMACGTXCLK,
          SetupHigh => tsetup_PHYEMACRXD_PHYEMACGTXCLK_posedge_posedge(1),
          HoldHigh => thold_PHYEMACRXD_PHYEMACGTXCLK_posedge_posedge(1),
          SetupLow => tsetup_PHYEMACRXD_PHYEMACGTXCLK_negedge_posedge(1),
          HoldLow => thold_PHYEMACRXD_PHYEMACGTXCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXD_PHYEMACGTXCLK_posedge(2),
          TimingData => Tmkr_PHYEMACRXD_PHYEMACGTXCLK_posedge(2),
          TestSignal => PHYEMACRXD_PHYEMACGTXCLK_dly(2),
          TestSignalName => "PHYEMACRXD(2)",
          TestDelay => tisd_PHYEMACRXD_PHYEMACGTXCLK(2),
          RefSignal => PHYEMACGTXCLK_dly,
          RefSignalName => "PHYEMACGTXCLK",
          RefDelay => ticd_PHYEMACGTXCLK,
          SetupHigh => tsetup_PHYEMACRXD_PHYEMACGTXCLK_posedge_posedge(2),
          HoldHigh => thold_PHYEMACRXD_PHYEMACGTXCLK_posedge_posedge(2),
          SetupLow => tsetup_PHYEMACRXD_PHYEMACGTXCLK_negedge_posedge(2),
          HoldLow => thold_PHYEMACRXD_PHYEMACGTXCLK_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXD_PHYEMACGTXCLK_posedge(3),
          TimingData => Tmkr_PHYEMACRXD_PHYEMACGTXCLK_posedge(3),
          TestSignal => PHYEMACRXD_PHYEMACGTXCLK_dly(3),
          TestSignalName => "PHYEMACRXD(3)",
          TestDelay => tisd_PHYEMACRXD_PHYEMACGTXCLK(3),
          RefSignal => PHYEMACGTXCLK_dly,
          RefSignalName => "PHYEMACGTXCLK",
          RefDelay => ticd_PHYEMACGTXCLK,
          SetupHigh => tsetup_PHYEMACRXD_PHYEMACGTXCLK_posedge_posedge(3),
          HoldHigh => thold_PHYEMACRXD_PHYEMACGTXCLK_posedge_posedge(3),
          SetupLow => tsetup_PHYEMACRXD_PHYEMACGTXCLK_negedge_posedge(3),
          HoldLow => thold_PHYEMACRXD_PHYEMACGTXCLK_negedge_posedge(3),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXD_PHYEMACGTXCLK_posedge(4),
          TimingData => Tmkr_PHYEMACRXD_PHYEMACGTXCLK_posedge(4),
          TestSignal => PHYEMACRXD_PHYEMACGTXCLK_dly(4),
          TestSignalName => "PHYEMACRXD(4)",
          TestDelay => tisd_PHYEMACRXD_PHYEMACGTXCLK(4),
          RefSignal => PHYEMACGTXCLK_dly,
          RefSignalName => "PHYEMACGTXCLK",
          RefDelay => ticd_PHYEMACGTXCLK,
          SetupHigh => tsetup_PHYEMACRXD_PHYEMACGTXCLK_posedge_posedge(4),
          HoldHigh => thold_PHYEMACRXD_PHYEMACGTXCLK_posedge_posedge(4),
          SetupLow => tsetup_PHYEMACRXD_PHYEMACGTXCLK_negedge_posedge(4),
          HoldLow => thold_PHYEMACRXD_PHYEMACGTXCLK_negedge_posedge(4),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXD_PHYEMACGTXCLK_posedge(5),
          TimingData => Tmkr_PHYEMACRXD_PHYEMACGTXCLK_posedge(5),
          TestSignal => PHYEMACRXD_PHYEMACGTXCLK_dly(5),
          TestSignalName => "PHYEMACRXD(5)",
          TestDelay => tisd_PHYEMACRXD_PHYEMACGTXCLK(5),
          RefSignal => PHYEMACGTXCLK_dly,
          RefSignalName => "PHYEMACGTXCLK",
          RefDelay => ticd_PHYEMACGTXCLK,
          SetupHigh => tsetup_PHYEMACRXD_PHYEMACGTXCLK_posedge_posedge(5),
          HoldHigh => thold_PHYEMACRXD_PHYEMACGTXCLK_posedge_posedge(5),
          SetupLow => tsetup_PHYEMACRXD_PHYEMACGTXCLK_negedge_posedge(5),
          HoldLow => thold_PHYEMACRXD_PHYEMACGTXCLK_negedge_posedge(5),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXD_PHYEMACGTXCLK_posedge(6),
          TimingData => Tmkr_PHYEMACRXD_PHYEMACGTXCLK_posedge(6),
          TestSignal => PHYEMACRXD_PHYEMACGTXCLK_dly(6),
          TestSignalName => "PHYEMACRXD(6)",
          TestDelay => tisd_PHYEMACRXD_PHYEMACGTXCLK(6),
          RefSignal => PHYEMACGTXCLK_dly,
          RefSignalName => "PHYEMACGTXCLK",
          RefDelay => ticd_PHYEMACGTXCLK,
          SetupHigh => tsetup_PHYEMACRXD_PHYEMACGTXCLK_posedge_posedge(6),
          HoldHigh => thold_PHYEMACRXD_PHYEMACGTXCLK_posedge_posedge(6),
          SetupLow => tsetup_PHYEMACRXD_PHYEMACGTXCLK_negedge_posedge(6),
          HoldLow => thold_PHYEMACRXD_PHYEMACGTXCLK_negedge_posedge(6),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXD_PHYEMACGTXCLK_posedge(7),
          TimingData => Tmkr_PHYEMACRXD_PHYEMACGTXCLK_posedge(7),
          TestSignal => PHYEMACRXD_PHYEMACGTXCLK_dly(7),
          TestSignalName => "PHYEMACRXD(7)",
          TestDelay => tisd_PHYEMACRXD_PHYEMACGTXCLK(7),
          RefSignal => PHYEMACGTXCLK_dly,
          RefSignalName => "PHYEMACGTXCLK",
          RefDelay => ticd_PHYEMACGTXCLK,
          SetupHigh => tsetup_PHYEMACRXD_PHYEMACGTXCLK_posedge_posedge(7),
          HoldHigh => thold_PHYEMACRXD_PHYEMACGTXCLK_posedge_posedge(7),
          SetupLow => tsetup_PHYEMACRXD_PHYEMACGTXCLK_negedge_posedge(7),
          HoldLow => thold_PHYEMACRXD_PHYEMACGTXCLK_negedge_posedge(7),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXD_PHYEMACRXCLK_negedge(4),
          TimingData => Tmkr_PHYEMACRXD_PHYEMACRXCLK_negedge(4),
          TestSignal => PHYEMACRXD_PHYEMACRXCLK_dly(4),
          TestSignalName => "PHYEMACRXD(4)",
          TestDelay => tisd_PHYEMACRXD_PHYEMACRXCLK(4),
          RefSignal => PHYEMACRXCLK_dly,
          RefSignalName => "PHYEMACRXCLK",
          RefDelay => ticd_PHYEMACRXCLK,
          SetupHigh => tsetup_PHYEMACRXD_PHYEMACRXCLK_posedge_negedge(4),
          HoldHigh => thold_PHYEMACRXD_PHYEMACRXCLK_posedge_negedge(4),
          SetupLow => tsetup_PHYEMACRXD_PHYEMACRXCLK_negedge_negedge(4),
          HoldLow => thold_PHYEMACRXD_PHYEMACRXCLK_negedge_negedge(4),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXD_PHYEMACRXCLK_negedge(5),
          TimingData => Tmkr_PHYEMACRXD_PHYEMACRXCLK_negedge(5),
          TestSignal => PHYEMACRXD_PHYEMACRXCLK_dly(5),
          TestSignalName => "PHYEMACRXD(5)",
          TestDelay => tisd_PHYEMACRXD_PHYEMACRXCLK(5),
          RefSignal => PHYEMACRXCLK_dly,
          RefSignalName => "PHYEMACRXCLK",
          RefDelay => ticd_PHYEMACRXCLK,
          SetupHigh => tsetup_PHYEMACRXD_PHYEMACRXCLK_posedge_negedge(5),
          HoldHigh => thold_PHYEMACRXD_PHYEMACRXCLK_posedge_negedge(5),
          SetupLow => tsetup_PHYEMACRXD_PHYEMACRXCLK_negedge_negedge(5),
          HoldLow => thold_PHYEMACRXD_PHYEMACRXCLK_negedge_negedge(5),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXD_PHYEMACRXCLK_negedge(6),
          TimingData => Tmkr_PHYEMACRXD_PHYEMACRXCLK_negedge(6),
          TestSignal => PHYEMACRXD_PHYEMACRXCLK_dly(6),
          TestSignalName => "PHYEMACRXD(6)",
          TestDelay => tisd_PHYEMACRXD_PHYEMACRXCLK(6),
          RefSignal => PHYEMACRXCLK_dly,
          RefSignalName => "PHYEMACRXCLK",
          RefDelay => ticd_PHYEMACRXCLK,
          SetupHigh => tsetup_PHYEMACRXD_PHYEMACRXCLK_posedge_negedge(6),
          HoldHigh => thold_PHYEMACRXD_PHYEMACRXCLK_posedge_negedge(6),
          SetupLow => tsetup_PHYEMACRXD_PHYEMACRXCLK_negedge_negedge(6),
          HoldLow => thold_PHYEMACRXD_PHYEMACRXCLK_negedge_negedge(6),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXD_PHYEMACRXCLK_negedge(7),
          TimingData => Tmkr_PHYEMACRXD_PHYEMACRXCLK_negedge(7),
          TestSignal => PHYEMACRXD_PHYEMACRXCLK_dly(7),
          TestSignalName => "PHYEMACRXD(7)",
          TestDelay => tisd_PHYEMACRXD_PHYEMACRXCLK(7),
          RefSignal => PHYEMACRXCLK_dly,
          RefSignalName => "PHYEMACRXCLK",
          RefDelay => ticd_PHYEMACRXCLK,
          SetupHigh => tsetup_PHYEMACRXD_PHYEMACRXCLK_posedge_negedge(7),
          HoldHigh => thold_PHYEMACRXD_PHYEMACRXCLK_posedge_negedge(7),
          SetupLow => tsetup_PHYEMACRXD_PHYEMACRXCLK_negedge_negedge(7),
          HoldLow => thold_PHYEMACRXD_PHYEMACRXCLK_negedge_negedge(7),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXD_PHYEMACRXCLK_posedge(0),
          TimingData => Tmkr_PHYEMACRXD_PHYEMACRXCLK_posedge(0),
          TestSignal => PHYEMACRXD_PHYEMACRXCLK_dly(0),
          TestSignalName => "PHYEMACRXD(0)",
          TestDelay => tisd_PHYEMACRXD_PHYEMACRXCLK(0),
          RefSignal => PHYEMACRXCLK_dly,
          RefSignalName => "PHYEMACRXCLK",
          RefDelay => ticd_PHYEMACRXCLK,
          SetupHigh => tsetup_PHYEMACRXD_PHYEMACRXCLK_posedge_posedge(0),
          HoldHigh => thold_PHYEMACRXD_PHYEMACRXCLK_posedge_posedge(0),
          SetupLow => tsetup_PHYEMACRXD_PHYEMACRXCLK_negedge_posedge(0),
          HoldLow => thold_PHYEMACRXD_PHYEMACRXCLK_negedge_posedge(0),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXD_PHYEMACRXCLK_posedge(1),
          TimingData => Tmkr_PHYEMACRXD_PHYEMACRXCLK_posedge(1),
          TestSignal => PHYEMACRXD_PHYEMACRXCLK_dly(1),
          TestSignalName => "PHYEMACRXD(1)",
          TestDelay => tisd_PHYEMACRXD_PHYEMACRXCLK(1),
          RefSignal => PHYEMACRXCLK_dly,
          RefSignalName => "PHYEMACRXCLK",
          RefDelay => ticd_PHYEMACRXCLK,
          SetupHigh => tsetup_PHYEMACRXD_PHYEMACRXCLK_posedge_posedge(1),
          HoldHigh => thold_PHYEMACRXD_PHYEMACRXCLK_posedge_posedge(1),
          SetupLow => tsetup_PHYEMACRXD_PHYEMACRXCLK_negedge_posedge(1),
          HoldLow => thold_PHYEMACRXD_PHYEMACRXCLK_negedge_posedge(1),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXD_PHYEMACRXCLK_posedge(2),
          TimingData => Tmkr_PHYEMACRXD_PHYEMACRXCLK_posedge(2),
          TestSignal => PHYEMACRXD_PHYEMACRXCLK_dly(2),
          TestSignalName => "PHYEMACRXD(2)",
          TestDelay => tisd_PHYEMACRXD_PHYEMACRXCLK(2),
          RefSignal => PHYEMACRXCLK_dly,
          RefSignalName => "PHYEMACRXCLK",
          RefDelay => ticd_PHYEMACRXCLK,
          SetupHigh => tsetup_PHYEMACRXD_PHYEMACRXCLK_posedge_posedge(2),
          HoldHigh => thold_PHYEMACRXD_PHYEMACRXCLK_posedge_posedge(2),
          SetupLow => tsetup_PHYEMACRXD_PHYEMACRXCLK_negedge_posedge(2),
          HoldLow => thold_PHYEMACRXD_PHYEMACRXCLK_negedge_posedge(2),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXD_PHYEMACRXCLK_posedge(3),
          TimingData => Tmkr_PHYEMACRXD_PHYEMACRXCLK_posedge(3),
          TestSignal => PHYEMACRXD_PHYEMACRXCLK_dly(3),
          TestSignalName => "PHYEMACRXD(3)",
          TestDelay => tisd_PHYEMACRXD_PHYEMACRXCLK(3),
          RefSignal => PHYEMACRXCLK_dly,
          RefSignalName => "PHYEMACRXCLK",
          RefDelay => ticd_PHYEMACRXCLK,
          SetupHigh => tsetup_PHYEMACRXD_PHYEMACRXCLK_posedge_posedge(3),
          HoldHigh => thold_PHYEMACRXD_PHYEMACRXCLK_posedge_posedge(3),
          SetupLow => tsetup_PHYEMACRXD_PHYEMACRXCLK_negedge_posedge(3),
          HoldLow => thold_PHYEMACRXD_PHYEMACRXCLK_negedge_posedge(3),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXD_PHYEMACRXCLK_posedge(4),
          TimingData => Tmkr_PHYEMACRXD_PHYEMACRXCLK_posedge(4),
          TestSignal => PHYEMACRXD_PHYEMACRXCLK_dly(4),
          TestSignalName => "PHYEMACRXD(4)",
          TestDelay => tisd_PHYEMACRXD_PHYEMACRXCLK(4),
          RefSignal => PHYEMACRXCLK_dly,
          RefSignalName => "PHYEMACRXCLK",
          RefDelay => ticd_PHYEMACRXCLK,
          SetupHigh => tsetup_PHYEMACRXD_PHYEMACRXCLK_posedge_posedge(4),
          HoldHigh => thold_PHYEMACRXD_PHYEMACRXCLK_posedge_posedge(4),
          SetupLow => tsetup_PHYEMACRXD_PHYEMACRXCLK_negedge_posedge(4),
          HoldLow => thold_PHYEMACRXD_PHYEMACRXCLK_negedge_posedge(4),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXD_PHYEMACRXCLK_posedge(5),
          TimingData => Tmkr_PHYEMACRXD_PHYEMACRXCLK_posedge(5),
          TestSignal => PHYEMACRXD_PHYEMACRXCLK_dly(5),
          TestSignalName => "PHYEMACRXD(5)",
          TestDelay => tisd_PHYEMACRXD_PHYEMACRXCLK(5),
          RefSignal => PHYEMACRXCLK_dly,
          RefSignalName => "PHYEMACRXCLK",
          RefDelay => ticd_PHYEMACRXCLK,
          SetupHigh => tsetup_PHYEMACRXD_PHYEMACRXCLK_posedge_posedge(5),
          HoldHigh => thold_PHYEMACRXD_PHYEMACRXCLK_posedge_posedge(5),
          SetupLow => tsetup_PHYEMACRXD_PHYEMACRXCLK_negedge_posedge(5),
          HoldLow => thold_PHYEMACRXD_PHYEMACRXCLK_negedge_posedge(5),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXD_PHYEMACRXCLK_posedge(6),
          TimingData => Tmkr_PHYEMACRXD_PHYEMACRXCLK_posedge(6),
          TestSignal => PHYEMACRXD_PHYEMACRXCLK_dly(6),
          TestSignalName => "PHYEMACRXD(6)",
          TestDelay => tisd_PHYEMACRXD_PHYEMACRXCLK(6),
          RefSignal => PHYEMACRXCLK_dly,
          RefSignalName => "PHYEMACRXCLK",
          RefDelay => ticd_PHYEMACRXCLK,
          SetupHigh => tsetup_PHYEMACRXD_PHYEMACRXCLK_posedge_posedge(6),
          HoldHigh => thold_PHYEMACRXD_PHYEMACRXCLK_posedge_posedge(6),
          SetupLow => tsetup_PHYEMACRXD_PHYEMACRXCLK_negedge_posedge(6),
          HoldLow => thold_PHYEMACRXD_PHYEMACRXCLK_negedge_posedge(6),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXD_PHYEMACRXCLK_posedge(7),
          TimingData => Tmkr_PHYEMACRXD_PHYEMACRXCLK_posedge(7),
          TestSignal => PHYEMACRXD_PHYEMACRXCLK_dly(7),
          TestSignalName => "PHYEMACRXD(7)",
          TestDelay => tisd_PHYEMACRXD_PHYEMACRXCLK(7),
          RefSignal => PHYEMACRXCLK_dly,
          RefSignalName => "PHYEMACRXCLK",
          RefDelay => ticd_PHYEMACRXCLK,
          SetupHigh => tsetup_PHYEMACRXD_PHYEMACRXCLK_posedge_posedge(7),
          HoldHigh => thold_PHYEMACRXD_PHYEMACRXCLK_posedge_posedge(7),
          SetupLow => tsetup_PHYEMACRXD_PHYEMACRXCLK_negedge_posedge(7),
          HoldLow => thold_PHYEMACRXD_PHYEMACRXCLK_negedge_posedge(7),
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXER_PHYEMACGTXCLK_posedge,
          TimingData => Tmkr_PHYEMACRXER_PHYEMACGTXCLK_posedge,
          TestSignal => PHYEMACRXER_PHYEMACGTXCLK_dly,
          TestSignalName => "PHYEMACRXER",
          TestDelay => tisd_PHYEMACRXER_PHYEMACGTXCLK,
          RefSignal => PHYEMACGTXCLK_dly,
          RefSignalName => "PHYEMACGTXCLK",
          RefDelay => ticd_PHYEMACGTXCLK,
          SetupHigh => tsetup_PHYEMACRXER_PHYEMACGTXCLK_posedge_posedge,
          HoldHigh => thold_PHYEMACRXER_PHYEMACGTXCLK_posedge_posedge,
          SetupLow => tsetup_PHYEMACRXER_PHYEMACGTXCLK_negedge_posedge,
          HoldLow => thold_PHYEMACRXER_PHYEMACGTXCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXER_PHYEMACRXCLK_negedge,
          TimingData => Tmkr_PHYEMACRXER_PHYEMACRXCLK_negedge,
          TestSignal => PHYEMACRXER_PHYEMACRXCLK_dly,
          TestSignalName => "PHYEMACRXER",
          TestDelay => tisd_PHYEMACRXER_PHYEMACRXCLK,
          RefSignal => PHYEMACRXCLK_dly,
          RefSignalName => "PHYEMACRXCLK",
          RefDelay => ticd_PHYEMACRXCLK,
          SetupHigh => tsetup_PHYEMACRXER_PHYEMACRXCLK_posedge_negedge,
          HoldHigh => thold_PHYEMACRXER_PHYEMACRXCLK_posedge_negedge,
          SetupLow => tsetup_PHYEMACRXER_PHYEMACRXCLK_negedge_negedge,
          HoldLow => thold_PHYEMACRXER_PHYEMACRXCLK_negedge_negedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXER_PHYEMACRXCLK_posedge,
          TimingData => Tmkr_PHYEMACRXER_PHYEMACRXCLK_posedge,
          TestSignal => PHYEMACRXER_PHYEMACRXCLK_dly,
          TestSignalName => "PHYEMACRXER",
          TestDelay => tisd_PHYEMACRXER_PHYEMACRXCLK,
          RefSignal => PHYEMACRXCLK_dly,
          RefSignalName => "PHYEMACRXCLK",
          RefDelay => ticd_PHYEMACRXCLK,
          SetupHigh => tsetup_PHYEMACRXER_PHYEMACRXCLK_posedge_posedge,
          HoldHigh => thold_PHYEMACRXER_PHYEMACRXCLK_posedge_posedge,
          SetupLow => tsetup_PHYEMACRXER_PHYEMACRXCLK_negedge_posedge,
          HoldLow => thold_PHYEMACRXER_PHYEMACRXCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXNOTINTABLE_PHYEMACGTXCLK_posedge,
          TimingData => Tmkr_PHYEMACRXNOTINTABLE_PHYEMACGTXCLK_posedge,
          TestSignal => PHYEMACRXNOTINTABLE_PHYEMACGTXCLK_dly,
          TestSignalName => "PHYEMACRXNOTINTABLE",
          TestDelay => tisd_PHYEMACRXNOTINTABLE_PHYEMACGTXCLK,
          RefSignal => PHYEMACGTXCLK_dly,
          RefSignalName => "PHYEMACGTXCLK",
          RefDelay => ticd_PHYEMACGTXCLK,
          SetupHigh => tsetup_PHYEMACRXNOTINTABLE_PHYEMACGTXCLK_posedge_posedge,
          HoldHigh => thold_PHYEMACRXNOTINTABLE_PHYEMACGTXCLK_posedge_posedge,
          SetupLow => tsetup_PHYEMACRXNOTINTABLE_PHYEMACGTXCLK_negedge_posedge,
          HoldLow => thold_PHYEMACRXNOTINTABLE_PHYEMACGTXCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXNOTINTABLE_PHYEMACRXCLK_posedge,
          TimingData => Tmkr_PHYEMACRXNOTINTABLE_PHYEMACRXCLK_posedge,
          TestSignal => PHYEMACRXNOTINTABLE_PHYEMACRXCLK_dly,
          TestSignalName => "PHYEMACRXNOTINTABLE",
          TestDelay => tisd_PHYEMACRXNOTINTABLE_PHYEMACRXCLK,
          RefSignal => PHYEMACRXCLK_dly,
          RefSignalName => "PHYEMACRXCLK",
          RefDelay => ticd_PHYEMACRXCLK,
          SetupHigh => tsetup_PHYEMACRXNOTINTABLE_PHYEMACRXCLK_posedge_posedge,
          HoldHigh => thold_PHYEMACRXNOTINTABLE_PHYEMACRXCLK_posedge_posedge,
          SetupLow => tsetup_PHYEMACRXNOTINTABLE_PHYEMACRXCLK_negedge_posedge,
          HoldLow => thold_PHYEMACRXNOTINTABLE_PHYEMACRXCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXRUNDISP_PHYEMACGTXCLK_posedge,
          TimingData => Tmkr_PHYEMACRXRUNDISP_PHYEMACGTXCLK_posedge,
          TestSignal => PHYEMACRXRUNDISP_PHYEMACGTXCLK_dly,
          TestSignalName => "PHYEMACRXRUNDISP",
          TestDelay => tisd_PHYEMACRXRUNDISP_PHYEMACGTXCLK,
          RefSignal => PHYEMACGTXCLK_dly,
          RefSignalName => "PHYEMACGTXCLK",
          RefDelay => ticd_PHYEMACGTXCLK,
          SetupHigh => tsetup_PHYEMACRXRUNDISP_PHYEMACGTXCLK_posedge_posedge,
          HoldHigh => thold_PHYEMACRXRUNDISP_PHYEMACGTXCLK_posedge_posedge,
          SetupLow => tsetup_PHYEMACRXRUNDISP_PHYEMACGTXCLK_negedge_posedge,
          HoldLow => thold_PHYEMACRXRUNDISP_PHYEMACGTXCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACRXRUNDISP_PHYEMACRXCLK_posedge,
          TimingData => Tmkr_PHYEMACRXRUNDISP_PHYEMACRXCLK_posedge,
          TestSignal => PHYEMACRXRUNDISP_PHYEMACRXCLK_dly,
          TestSignalName => "PHYEMACRXRUNDISP",
          TestDelay => tisd_PHYEMACRXRUNDISP_PHYEMACRXCLK,
          RefSignal => PHYEMACRXCLK_dly,
          RefSignalName => "PHYEMACRXCLK",
          RefDelay => ticd_PHYEMACRXCLK,
          SetupHigh => tsetup_PHYEMACRXRUNDISP_PHYEMACRXCLK_posedge_posedge,
          HoldHigh => thold_PHYEMACRXRUNDISP_PHYEMACRXCLK_posedge_posedge,
          SetupLow => tsetup_PHYEMACRXRUNDISP_PHYEMACRXCLK_negedge_posedge,
          HoldLow => thold_PHYEMACRXRUNDISP_PHYEMACRXCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACSIGNALDET_PHYEMACGTXCLK_posedge,
          TimingData => Tmkr_PHYEMACSIGNALDET_PHYEMACGTXCLK_posedge,
          TestSignal => PHYEMACSIGNALDET_PHYEMACGTXCLK_dly,
          TestSignalName => "PHYEMACSIGNALDET",
          TestDelay => tisd_PHYEMACSIGNALDET_PHYEMACGTXCLK,
          RefSignal => PHYEMACGTXCLK_dly,
          RefSignalName => "PHYEMACGTXCLK",
          RefDelay => ticd_PHYEMACGTXCLK,
          SetupHigh => tsetup_PHYEMACSIGNALDET_PHYEMACGTXCLK_posedge_posedge,
          HoldHigh => thold_PHYEMACSIGNALDET_PHYEMACGTXCLK_posedge_posedge,
          SetupLow => tsetup_PHYEMACSIGNALDET_PHYEMACGTXCLK_negedge_posedge,
          HoldLow => thold_PHYEMACSIGNALDET_PHYEMACGTXCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACSIGNALDET_PHYEMACRXCLK_posedge,
          TimingData => Tmkr_PHYEMACSIGNALDET_PHYEMACRXCLK_posedge,
          TestSignal => PHYEMACSIGNALDET_PHYEMACRXCLK_dly,
          TestSignalName => "PHYEMACSIGNALDET",
          TestDelay => tisd_PHYEMACSIGNALDET_PHYEMACRXCLK,
          RefSignal => PHYEMACRXCLK_dly,
          RefSignalName => "PHYEMACRXCLK",
          RefDelay => ticd_PHYEMACRXCLK,
          SetupHigh => tsetup_PHYEMACSIGNALDET_PHYEMACRXCLK_posedge_posedge,
          HoldHigh => thold_PHYEMACSIGNALDET_PHYEMACRXCLK_posedge_posedge,
          SetupLow => tsetup_PHYEMACSIGNALDET_PHYEMACRXCLK_negedge_posedge,
          HoldLow => thold_PHYEMACSIGNALDET_PHYEMACRXCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACTXBUFERR_PHYEMACGTXCLK_posedge,
          TimingData => Tmkr_PHYEMACTXBUFERR_PHYEMACGTXCLK_posedge,
          TestSignal => PHYEMACTXBUFERR_PHYEMACGTXCLK_dly,
          TestSignalName => "PHYEMACTXBUFERR",
          TestDelay => tisd_PHYEMACTXBUFERR_PHYEMACGTXCLK,
          RefSignal => PHYEMACGTXCLK_dly,
          RefSignalName => "PHYEMACGTXCLK",
          RefDelay => ticd_PHYEMACGTXCLK,
          SetupHigh => tsetup_PHYEMACTXBUFERR_PHYEMACGTXCLK_posedge_posedge,
          HoldHigh => thold_PHYEMACTXBUFERR_PHYEMACGTXCLK_posedge_posedge,
          SetupLow => tsetup_PHYEMACTXBUFERR_PHYEMACGTXCLK_negedge_posedge,
          HoldLow => thold_PHYEMACTXBUFERR_PHYEMACGTXCLK_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
        VitalSetupHoldCheck
        (
          Violation => Tviol_PHYEMACTXBUFERR_PHYEMACTXGMIIMIICLKIN_posedge,
          TimingData => Tmkr_PHYEMACTXBUFERR_PHYEMACTXGMIIMIICLKIN_posedge,
          TestSignal => PHYEMACTXBUFERR_PHYEMACTXGMIIMIICLKIN_dly,
          TestSignalName => "PHYEMACTXBUFERR",
          TestDelay => tisd_PHYEMACTXBUFERR_PHYEMACTXGMIIMIICLKIN,
          RefSignal => PHYEMACTXGMIIMIICLKIN_dly,
          RefSignalName => "PHYEMACTXGMIIMIICLKIN",
          RefDelay => ticd_PHYEMACTXGMIIMIICLKIN,
          SetupHigh => tsetup_PHYEMACTXBUFERR_PHYEMACTXGMIIMIICLKIN_posedge_posedge,
          HoldHigh => thold_PHYEMACTXBUFERR_PHYEMACTXGMIIMIICLKIN_posedge_posedge,
          SetupLow => tsetup_PHYEMACTXBUFERR_PHYEMACTXGMIIMIICLKIN_negedge_posedge,
          HoldLow => thold_PHYEMACTXBUFERR_PHYEMACTXGMIIMIICLKIN_negedge_posedge,
          CheckEnabled   => TRUE,
          RefTransition  => 'R',
          HeaderMsg      => InstancePath & "/X_TEMAC_SINGLE",
          Xon            => Xon,
          MsgOn          => MsgOn,
          MsgSeverity    => WARNING
        );
      end if;
        VitalPathDelay01
        (
          OutSignal     => DCRHOSTDONEIR,
          GlitchData    => DCRHOSTDONEIR_GlitchData,
          OutSignalName => "DCRHOSTDONEIR",
          OutTemp       => DCRHOSTDONEIR_out,
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_DCRHOSTDONEIR,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTANINTERRUPT,
          GlitchData    => EMACCLIENTANINTERRUPT_GlitchData,
          OutSignalName => "EMACCLIENTANINTERRUPT",
          OutTemp       => EMACCLIENTANINTERRUPT_out,
          Paths       => (0 => (PHYEMACGTXCLK_dly'last_event, tpd_PHYEMACGTXCLK_EMACCLIENTANINTERRUPT,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXBADFRAME,
          GlitchData    => EMACCLIENTRXBADFRAME_GlitchData,
          OutSignalName => "EMACCLIENTRXBADFRAME",
          OutTemp       => EMACCLIENTRXBADFRAME_out,
          Paths       => (0 => (CLIENTEMACRXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXBADFRAME,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXBADFRAME,
          GlitchData    => EMACCLIENTRXBADFRAME_GlitchData,
          OutSignalName => "EMACCLIENTRXBADFRAME",
          OutTemp       => EMACCLIENTRXBADFRAME_out,
          Paths       => (0 => (PHYEMACMIITXCLK_dly'last_event, tpd_PHYEMACMIITXCLK_EMACCLIENTRXBADFRAME,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXBADFRAME,
          GlitchData    => EMACCLIENTRXBADFRAME_GlitchData,
          OutSignalName => "EMACCLIENTRXBADFRAME",
          OutTemp       => EMACCLIENTRXBADFRAME_out,
          Paths       => (0 => (PHYEMACRXCLK_dly'last_event, tpd_PHYEMACRXCLK_EMACCLIENTRXBADFRAME,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXCLIENTCLKOUT,
          GlitchData    => EMACCLIENTRXCLIENTCLKOUT_GlitchData,
          OutSignalName => "EMACCLIENTRXCLIENTCLKOUT",
          OutTemp       => EMACCLIENTRXCLIENTCLKOUT_out,
          Paths       => (0 => (CLIENTEMACRXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXCLIENTCLKOUT,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXCLIENTCLKOUT,
          GlitchData    => EMACCLIENTRXCLIENTCLKOUT_GlitchData,
          OutSignalName => "EMACCLIENTRXCLIENTCLKOUT",
          OutTemp       => EMACCLIENTRXCLIENTCLKOUT_out,
          Paths       => (0 => (PHYEMACGTXCLK_dly'last_event, tpd_PHYEMACGTXCLK_EMACCLIENTRXCLIENTCLKOUT,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXCLIENTCLKOUT,
          GlitchData    => EMACCLIENTRXCLIENTCLKOUT_GlitchData,
          OutSignalName => "EMACCLIENTRXCLIENTCLKOUT",
          OutTemp       => EMACCLIENTRXCLIENTCLKOUT_out,
          Paths       => (0 => (PHYEMACMIITXCLK_dly'last_event, tpd_PHYEMACMIITXCLK_EMACCLIENTRXCLIENTCLKOUT,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXCLIENTCLKOUT,
          GlitchData    => EMACCLIENTRXCLIENTCLKOUT_GlitchData,
          OutSignalName => "EMACCLIENTRXCLIENTCLKOUT",
          OutTemp       => EMACCLIENTRXCLIENTCLKOUT_out,
          Paths       => (0 => (PHYEMACRXCLK_dly'last_event, tpd_PHYEMACRXCLK_EMACCLIENTRXCLIENTCLKOUT,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(0),
          GlitchData    => EMACCLIENTRXD0_GlitchData,
          OutSignalName => "EMACCLIENTRXD(0)",
          OutTemp       => EMACCLIENTRXD_out(0),
          Paths       => (0 => (CLIENTEMACRXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXD(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(0),
          GlitchData    => EMACCLIENTRXD0_GlitchData,
          OutSignalName => "EMACCLIENTRXD(0)",
          OutTemp       => EMACCLIENTRXD_out(0),
          Paths       => (0 => (PHYEMACMIITXCLK_dly'last_event, tpd_PHYEMACMIITXCLK_EMACCLIENTRXD(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(0),
          GlitchData    => EMACCLIENTRXD0_GlitchData,
          OutSignalName => "EMACCLIENTRXD(0)",
          OutTemp       => EMACCLIENTRXD_out(0),
          Paths       => (0 => (PHYEMACRXCLK_dly'last_event, tpd_PHYEMACRXCLK_EMACCLIENTRXD(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(1),
          GlitchData    => EMACCLIENTRXD1_GlitchData,
          OutSignalName => "EMACCLIENTRXD(1)",
          OutTemp       => EMACCLIENTRXD_out(1),
          Paths       => (0 => (CLIENTEMACRXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXD(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(1),
          GlitchData    => EMACCLIENTRXD1_GlitchData,
          OutSignalName => "EMACCLIENTRXD(1)",
          OutTemp       => EMACCLIENTRXD_out(1),
          Paths       => (0 => (PHYEMACMIITXCLK_dly'last_event, tpd_PHYEMACMIITXCLK_EMACCLIENTRXD(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(1),
          GlitchData    => EMACCLIENTRXD1_GlitchData,
          OutSignalName => "EMACCLIENTRXD(1)",
          OutTemp       => EMACCLIENTRXD_out(1),
          Paths       => (0 => (PHYEMACRXCLK_dly'last_event, tpd_PHYEMACRXCLK_EMACCLIENTRXD(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(10),
          GlitchData    => EMACCLIENTRXD10_GlitchData,
          OutSignalName => "EMACCLIENTRXD(10)",
          OutTemp       => EMACCLIENTRXD_out(10),
          Paths       => (0 => (CLIENTEMACRXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXD(10),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(10),
          GlitchData    => EMACCLIENTRXD10_GlitchData,
          OutSignalName => "EMACCLIENTRXD(10)",
          OutTemp       => EMACCLIENTRXD_out(10),
          Paths       => (0 => (PHYEMACMIITXCLK_dly'last_event, tpd_PHYEMACMIITXCLK_EMACCLIENTRXD(10),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(10),
          GlitchData    => EMACCLIENTRXD10_GlitchData,
          OutSignalName => "EMACCLIENTRXD(10)",
          OutTemp       => EMACCLIENTRXD_out(10),
          Paths       => (0 => (PHYEMACRXCLK_dly'last_event, tpd_PHYEMACRXCLK_EMACCLIENTRXD(10),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(11),
          GlitchData    => EMACCLIENTRXD11_GlitchData,
          OutSignalName => "EMACCLIENTRXD(11)",
          OutTemp       => EMACCLIENTRXD_out(11),
          Paths       => (0 => (CLIENTEMACRXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXD(11),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(11),
          GlitchData    => EMACCLIENTRXD11_GlitchData,
          OutSignalName => "EMACCLIENTRXD(11)",
          OutTemp       => EMACCLIENTRXD_out(11),
          Paths       => (0 => (PHYEMACMIITXCLK_dly'last_event, tpd_PHYEMACMIITXCLK_EMACCLIENTRXD(11),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(11),
          GlitchData    => EMACCLIENTRXD11_GlitchData,
          OutSignalName => "EMACCLIENTRXD(11)",
          OutTemp       => EMACCLIENTRXD_out(11),
          Paths       => (0 => (PHYEMACRXCLK_dly'last_event, tpd_PHYEMACRXCLK_EMACCLIENTRXD(11),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(12),
          GlitchData    => EMACCLIENTRXD12_GlitchData,
          OutSignalName => "EMACCLIENTRXD(12)",
          OutTemp       => EMACCLIENTRXD_out(12),
          Paths       => (0 => (CLIENTEMACRXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXD(12),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(12),
          GlitchData    => EMACCLIENTRXD12_GlitchData,
          OutSignalName => "EMACCLIENTRXD(12)",
          OutTemp       => EMACCLIENTRXD_out(12),
          Paths       => (0 => (PHYEMACMIITXCLK_dly'last_event, tpd_PHYEMACMIITXCLK_EMACCLIENTRXD(12),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(12),
          GlitchData    => EMACCLIENTRXD12_GlitchData,
          OutSignalName => "EMACCLIENTRXD(12)",
          OutTemp       => EMACCLIENTRXD_out(12),
          Paths       => (0 => (PHYEMACRXCLK_dly'last_event, tpd_PHYEMACRXCLK_EMACCLIENTRXD(12),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(13),
          GlitchData    => EMACCLIENTRXD13_GlitchData,
          OutSignalName => "EMACCLIENTRXD(13)",
          OutTemp       => EMACCLIENTRXD_out(13),
          Paths       => (0 => (CLIENTEMACRXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXD(13),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(13),
          GlitchData    => EMACCLIENTRXD13_GlitchData,
          OutSignalName => "EMACCLIENTRXD(13)",
          OutTemp       => EMACCLIENTRXD_out(13),
          Paths       => (0 => (PHYEMACMIITXCLK_dly'last_event, tpd_PHYEMACMIITXCLK_EMACCLIENTRXD(13),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(13),
          GlitchData    => EMACCLIENTRXD13_GlitchData,
          OutSignalName => "EMACCLIENTRXD(13)",
          OutTemp       => EMACCLIENTRXD_out(13),
          Paths       => (0 => (PHYEMACRXCLK_dly'last_event, tpd_PHYEMACRXCLK_EMACCLIENTRXD(13),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(14),
          GlitchData    => EMACCLIENTRXD14_GlitchData,
          OutSignalName => "EMACCLIENTRXD(14)",
          OutTemp       => EMACCLIENTRXD_out(14),
          Paths       => (0 => (CLIENTEMACRXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXD(14),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(14),
          GlitchData    => EMACCLIENTRXD14_GlitchData,
          OutSignalName => "EMACCLIENTRXD(14)",
          OutTemp       => EMACCLIENTRXD_out(14),
          Paths       => (0 => (PHYEMACMIITXCLK_dly'last_event, tpd_PHYEMACMIITXCLK_EMACCLIENTRXD(14),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(14),
          GlitchData    => EMACCLIENTRXD14_GlitchData,
          OutSignalName => "EMACCLIENTRXD(14)",
          OutTemp       => EMACCLIENTRXD_out(14),
          Paths       => (0 => (PHYEMACRXCLK_dly'last_event, tpd_PHYEMACRXCLK_EMACCLIENTRXD(14),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(15),
          GlitchData    => EMACCLIENTRXD15_GlitchData,
          OutSignalName => "EMACCLIENTRXD(15)",
          OutTemp       => EMACCLIENTRXD_out(15),
          Paths       => (0 => (CLIENTEMACRXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXD(15),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(15),
          GlitchData    => EMACCLIENTRXD15_GlitchData,
          OutSignalName => "EMACCLIENTRXD(15)",
          OutTemp       => EMACCLIENTRXD_out(15),
          Paths       => (0 => (PHYEMACMIITXCLK_dly'last_event, tpd_PHYEMACMIITXCLK_EMACCLIENTRXD(15),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(15),
          GlitchData    => EMACCLIENTRXD15_GlitchData,
          OutSignalName => "EMACCLIENTRXD(15)",
          OutTemp       => EMACCLIENTRXD_out(15),
          Paths       => (0 => (PHYEMACRXCLK_dly'last_event, tpd_PHYEMACRXCLK_EMACCLIENTRXD(15),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(2),
          GlitchData    => EMACCLIENTRXD2_GlitchData,
          OutSignalName => "EMACCLIENTRXD(2)",
          OutTemp       => EMACCLIENTRXD_out(2),
          Paths       => (0 => (CLIENTEMACRXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXD(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(2),
          GlitchData    => EMACCLIENTRXD2_GlitchData,
          OutSignalName => "EMACCLIENTRXD(2)",
          OutTemp       => EMACCLIENTRXD_out(2),
          Paths       => (0 => (PHYEMACMIITXCLK_dly'last_event, tpd_PHYEMACMIITXCLK_EMACCLIENTRXD(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(2),
          GlitchData    => EMACCLIENTRXD2_GlitchData,
          OutSignalName => "EMACCLIENTRXD(2)",
          OutTemp       => EMACCLIENTRXD_out(2),
          Paths       => (0 => (PHYEMACRXCLK_dly'last_event, tpd_PHYEMACRXCLK_EMACCLIENTRXD(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(3),
          GlitchData    => EMACCLIENTRXD3_GlitchData,
          OutSignalName => "EMACCLIENTRXD(3)",
          OutTemp       => EMACCLIENTRXD_out(3),
          Paths       => (0 => (CLIENTEMACRXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXD(3),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(3),
          GlitchData    => EMACCLIENTRXD3_GlitchData,
          OutSignalName => "EMACCLIENTRXD(3)",
          OutTemp       => EMACCLIENTRXD_out(3),
          Paths       => (0 => (PHYEMACMIITXCLK_dly'last_event, tpd_PHYEMACMIITXCLK_EMACCLIENTRXD(3),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(3),
          GlitchData    => EMACCLIENTRXD3_GlitchData,
          OutSignalName => "EMACCLIENTRXD(3)",
          OutTemp       => EMACCLIENTRXD_out(3),
          Paths       => (0 => (PHYEMACRXCLK_dly'last_event, tpd_PHYEMACRXCLK_EMACCLIENTRXD(3),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(4),
          GlitchData    => EMACCLIENTRXD4_GlitchData,
          OutSignalName => "EMACCLIENTRXD(4)",
          OutTemp       => EMACCLIENTRXD_out(4),
          Paths       => (0 => (CLIENTEMACRXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXD(4),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(4),
          GlitchData    => EMACCLIENTRXD4_GlitchData,
          OutSignalName => "EMACCLIENTRXD(4)",
          OutTemp       => EMACCLIENTRXD_out(4),
          Paths       => (0 => (PHYEMACMIITXCLK_dly'last_event, tpd_PHYEMACMIITXCLK_EMACCLIENTRXD(4),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(4),
          GlitchData    => EMACCLIENTRXD4_GlitchData,
          OutSignalName => "EMACCLIENTRXD(4)",
          OutTemp       => EMACCLIENTRXD_out(4),
          Paths       => (0 => (PHYEMACRXCLK_dly'last_event, tpd_PHYEMACRXCLK_EMACCLIENTRXD(4),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(5),
          GlitchData    => EMACCLIENTRXD5_GlitchData,
          OutSignalName => "EMACCLIENTRXD(5)",
          OutTemp       => EMACCLIENTRXD_out(5),
          Paths       => (0 => (CLIENTEMACRXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXD(5),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(5),
          GlitchData    => EMACCLIENTRXD5_GlitchData,
          OutSignalName => "EMACCLIENTRXD(5)",
          OutTemp       => EMACCLIENTRXD_out(5),
          Paths       => (0 => (PHYEMACMIITXCLK_dly'last_event, tpd_PHYEMACMIITXCLK_EMACCLIENTRXD(5),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(5),
          GlitchData    => EMACCLIENTRXD5_GlitchData,
          OutSignalName => "EMACCLIENTRXD(5)",
          OutTemp       => EMACCLIENTRXD_out(5),
          Paths       => (0 => (PHYEMACRXCLK_dly'last_event, tpd_PHYEMACRXCLK_EMACCLIENTRXD(5),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(6),
          GlitchData    => EMACCLIENTRXD6_GlitchData,
          OutSignalName => "EMACCLIENTRXD(6)",
          OutTemp       => EMACCLIENTRXD_out(6),
          Paths       => (0 => (CLIENTEMACRXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXD(6),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(6),
          GlitchData    => EMACCLIENTRXD6_GlitchData,
          OutSignalName => "EMACCLIENTRXD(6)",
          OutTemp       => EMACCLIENTRXD_out(6),
          Paths       => (0 => (PHYEMACMIITXCLK_dly'last_event, tpd_PHYEMACMIITXCLK_EMACCLIENTRXD(6),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(6),
          GlitchData    => EMACCLIENTRXD6_GlitchData,
          OutSignalName => "EMACCLIENTRXD(6)",
          OutTemp       => EMACCLIENTRXD_out(6),
          Paths       => (0 => (PHYEMACRXCLK_dly'last_event, tpd_PHYEMACRXCLK_EMACCLIENTRXD(6),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(7),
          GlitchData    => EMACCLIENTRXD7_GlitchData,
          OutSignalName => "EMACCLIENTRXD(7)",
          OutTemp       => EMACCLIENTRXD_out(7),
          Paths       => (0 => (CLIENTEMACRXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXD(7),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(7),
          GlitchData    => EMACCLIENTRXD7_GlitchData,
          OutSignalName => "EMACCLIENTRXD(7)",
          OutTemp       => EMACCLIENTRXD_out(7),
          Paths       => (0 => (PHYEMACMIITXCLK_dly'last_event, tpd_PHYEMACMIITXCLK_EMACCLIENTRXD(7),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(7),
          GlitchData    => EMACCLIENTRXD7_GlitchData,
          OutSignalName => "EMACCLIENTRXD(7)",
          OutTemp       => EMACCLIENTRXD_out(7),
          Paths       => (0 => (PHYEMACRXCLK_dly'last_event, tpd_PHYEMACRXCLK_EMACCLIENTRXD(7),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(8),
          GlitchData    => EMACCLIENTRXD8_GlitchData,
          OutSignalName => "EMACCLIENTRXD(8)",
          OutTemp       => EMACCLIENTRXD_out(8),
          Paths       => (0 => (CLIENTEMACRXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXD(8),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(8),
          GlitchData    => EMACCLIENTRXD8_GlitchData,
          OutSignalName => "EMACCLIENTRXD(8)",
          OutTemp       => EMACCLIENTRXD_out(8),
          Paths       => (0 => (PHYEMACMIITXCLK_dly'last_event, tpd_PHYEMACMIITXCLK_EMACCLIENTRXD(8),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(8),
          GlitchData    => EMACCLIENTRXD8_GlitchData,
          OutSignalName => "EMACCLIENTRXD(8)",
          OutTemp       => EMACCLIENTRXD_out(8),
          Paths       => (0 => (PHYEMACRXCLK_dly'last_event, tpd_PHYEMACRXCLK_EMACCLIENTRXD(8),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(9),
          GlitchData    => EMACCLIENTRXD9_GlitchData,
          OutSignalName => "EMACCLIENTRXD(9)",
          OutTemp       => EMACCLIENTRXD_out(9),
          Paths       => (0 => (CLIENTEMACRXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXD(9),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(9),
          GlitchData    => EMACCLIENTRXD9_GlitchData,
          OutSignalName => "EMACCLIENTRXD(9)",
          OutTemp       => EMACCLIENTRXD_out(9),
          Paths       => (0 => (PHYEMACMIITXCLK_dly'last_event, tpd_PHYEMACMIITXCLK_EMACCLIENTRXD(9),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXD(9),
          GlitchData    => EMACCLIENTRXD9_GlitchData,
          OutSignalName => "EMACCLIENTRXD(9)",
          OutTemp       => EMACCLIENTRXD_out(9),
          Paths       => (0 => (PHYEMACRXCLK_dly'last_event, tpd_PHYEMACRXCLK_EMACCLIENTRXD(9),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXDVLD,
          GlitchData    => EMACCLIENTRXDVLD_GlitchData,
          OutSignalName => "EMACCLIENTRXDVLD",
          OutTemp       => EMACCLIENTRXDVLD_out,
          Paths       => (0 => (CLIENTEMACRXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXDVLD,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXDVLD,
          GlitchData    => EMACCLIENTRXDVLD_GlitchData,
          OutSignalName => "EMACCLIENTRXDVLD",
          OutTemp       => EMACCLIENTRXDVLD_out,
          Paths       => (0 => (PHYEMACMIITXCLK_dly'last_event, tpd_PHYEMACMIITXCLK_EMACCLIENTRXDVLD,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXDVLD,
          GlitchData    => EMACCLIENTRXDVLD_GlitchData,
          OutSignalName => "EMACCLIENTRXDVLD",
          OutTemp       => EMACCLIENTRXDVLD_out,
          Paths       => (0 => (PHYEMACRXCLK_dly'last_event, tpd_PHYEMACRXCLK_EMACCLIENTRXDVLD,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXDVLDMSW,
          GlitchData    => EMACCLIENTRXDVLDMSW_GlitchData,
          OutSignalName => "EMACCLIENTRXDVLDMSW",
          OutTemp       => EMACCLIENTRXDVLDMSW_out,
          Paths       => (0 => (CLIENTEMACRXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXDVLDMSW,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXDVLDMSW,
          GlitchData    => EMACCLIENTRXDVLDMSW_GlitchData,
          OutSignalName => "EMACCLIENTRXDVLDMSW",
          OutTemp       => EMACCLIENTRXDVLDMSW_out,
          Paths       => (0 => (PHYEMACMIITXCLK_dly'last_event, tpd_PHYEMACMIITXCLK_EMACCLIENTRXDVLDMSW,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXDVLDMSW,
          GlitchData    => EMACCLIENTRXDVLDMSW_GlitchData,
          OutSignalName => "EMACCLIENTRXDVLDMSW",
          OutTemp       => EMACCLIENTRXDVLDMSW_out,
          Paths       => (0 => (PHYEMACRXCLK_dly'last_event, tpd_PHYEMACRXCLK_EMACCLIENTRXDVLDMSW,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXFRAMEDROP,
          GlitchData    => EMACCLIENTRXFRAMEDROP_GlitchData,
          OutSignalName => "EMACCLIENTRXFRAMEDROP",
          OutTemp       => EMACCLIENTRXFRAMEDROP_out,
          Paths       => (0 => (CLIENTEMACRXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXFRAMEDROP,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXFRAMEDROP,
          GlitchData    => EMACCLIENTRXFRAMEDROP_GlitchData,
          OutSignalName => "EMACCLIENTRXFRAMEDROP",
          OutTemp       => EMACCLIENTRXFRAMEDROP_out,
          Paths       => (0 => (PHYEMACMIITXCLK_dly'last_event, tpd_PHYEMACMIITXCLK_EMACCLIENTRXFRAMEDROP,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXFRAMEDROP,
          GlitchData    => EMACCLIENTRXFRAMEDROP_GlitchData,
          OutSignalName => "EMACCLIENTRXFRAMEDROP",
          OutTemp       => EMACCLIENTRXFRAMEDROP_out,
          Paths       => (0 => (PHYEMACRXCLK_dly'last_event, tpd_PHYEMACRXCLK_EMACCLIENTRXFRAMEDROP,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXGOODFRAME,
          GlitchData    => EMACCLIENTRXGOODFRAME_GlitchData,
          OutSignalName => "EMACCLIENTRXGOODFRAME",
          OutTemp       => EMACCLIENTRXGOODFRAME_out,
          Paths       => (0 => (CLIENTEMACRXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXGOODFRAME,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXGOODFRAME,
          GlitchData    => EMACCLIENTRXGOODFRAME_GlitchData,
          OutSignalName => "EMACCLIENTRXGOODFRAME",
          OutTemp       => EMACCLIENTRXGOODFRAME_out,
          Paths       => (0 => (PHYEMACMIITXCLK_dly'last_event, tpd_PHYEMACMIITXCLK_EMACCLIENTRXGOODFRAME,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXGOODFRAME,
          GlitchData    => EMACCLIENTRXGOODFRAME_GlitchData,
          OutSignalName => "EMACCLIENTRXGOODFRAME",
          OutTemp       => EMACCLIENTRXGOODFRAME_out,
          Paths       => (0 => (PHYEMACRXCLK_dly'last_event, tpd_PHYEMACRXCLK_EMACCLIENTRXGOODFRAME,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXSTATS(0),
          GlitchData    => EMACCLIENTRXSTATS0_GlitchData,
          OutSignalName => "EMACCLIENTRXSTATS(0)",
          OutTemp       => EMACCLIENTRXSTATS_out(0),
          Paths       => (0 => (CLIENTEMACRXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXSTATS(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXSTATS(0),
          GlitchData    => EMACCLIENTRXSTATS0_GlitchData,
          OutSignalName => "EMACCLIENTRXSTATS(0)",
          OutTemp       => EMACCLIENTRXSTATS_out(0),
          Paths       => (0 => (PHYEMACRXCLK_dly'last_event, tpd_PHYEMACRXCLK_EMACCLIENTRXSTATS(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXSTATS(1),
          GlitchData    => EMACCLIENTRXSTATS1_GlitchData,
          OutSignalName => "EMACCLIENTRXSTATS(1)",
          OutTemp       => EMACCLIENTRXSTATS_out(1),
          Paths       => (0 => (CLIENTEMACRXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXSTATS(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXSTATS(1),
          GlitchData    => EMACCLIENTRXSTATS1_GlitchData,
          OutSignalName => "EMACCLIENTRXSTATS(1)",
          OutTemp       => EMACCLIENTRXSTATS_out(1),
          Paths       => (0 => (PHYEMACRXCLK_dly'last_event, tpd_PHYEMACRXCLK_EMACCLIENTRXSTATS(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXSTATS(2),
          GlitchData    => EMACCLIENTRXSTATS2_GlitchData,
          OutSignalName => "EMACCLIENTRXSTATS(2)",
          OutTemp       => EMACCLIENTRXSTATS_out(2),
          Paths       => (0 => (CLIENTEMACRXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXSTATS(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXSTATS(2),
          GlitchData    => EMACCLIENTRXSTATS2_GlitchData,
          OutSignalName => "EMACCLIENTRXSTATS(2)",
          OutTemp       => EMACCLIENTRXSTATS_out(2),
          Paths       => (0 => (PHYEMACRXCLK_dly'last_event, tpd_PHYEMACRXCLK_EMACCLIENTRXSTATS(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXSTATS(3),
          GlitchData    => EMACCLIENTRXSTATS3_GlitchData,
          OutSignalName => "EMACCLIENTRXSTATS(3)",
          OutTemp       => EMACCLIENTRXSTATS_out(3),
          Paths       => (0 => (CLIENTEMACRXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXSTATS(3),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXSTATS(3),
          GlitchData    => EMACCLIENTRXSTATS3_GlitchData,
          OutSignalName => "EMACCLIENTRXSTATS(3)",
          OutTemp       => EMACCLIENTRXSTATS_out(3),
          Paths       => (0 => (PHYEMACRXCLK_dly'last_event, tpd_PHYEMACRXCLK_EMACCLIENTRXSTATS(3),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXSTATS(4),
          GlitchData    => EMACCLIENTRXSTATS4_GlitchData,
          OutSignalName => "EMACCLIENTRXSTATS(4)",
          OutTemp       => EMACCLIENTRXSTATS_out(4),
          Paths       => (0 => (CLIENTEMACRXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXSTATS(4),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXSTATS(4),
          GlitchData    => EMACCLIENTRXSTATS4_GlitchData,
          OutSignalName => "EMACCLIENTRXSTATS(4)",
          OutTemp       => EMACCLIENTRXSTATS_out(4),
          Paths       => (0 => (PHYEMACRXCLK_dly'last_event, tpd_PHYEMACRXCLK_EMACCLIENTRXSTATS(4),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXSTATS(5),
          GlitchData    => EMACCLIENTRXSTATS5_GlitchData,
          OutSignalName => "EMACCLIENTRXSTATS(5)",
          OutTemp       => EMACCLIENTRXSTATS_out(5),
          Paths       => (0 => (CLIENTEMACRXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXSTATS(5),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXSTATS(5),
          GlitchData    => EMACCLIENTRXSTATS5_GlitchData,
          OutSignalName => "EMACCLIENTRXSTATS(5)",
          OutTemp       => EMACCLIENTRXSTATS_out(5),
          Paths       => (0 => (PHYEMACRXCLK_dly'last_event, tpd_PHYEMACRXCLK_EMACCLIENTRXSTATS(5),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXSTATS(6),
          GlitchData    => EMACCLIENTRXSTATS6_GlitchData,
          OutSignalName => "EMACCLIENTRXSTATS(6)",
          OutTemp       => EMACCLIENTRXSTATS_out(6),
          Paths       => (0 => (CLIENTEMACRXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXSTATS(6),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXSTATS(6),
          GlitchData    => EMACCLIENTRXSTATS6_GlitchData,
          OutSignalName => "EMACCLIENTRXSTATS(6)",
          OutTemp       => EMACCLIENTRXSTATS_out(6),
          Paths       => (0 => (PHYEMACRXCLK_dly'last_event, tpd_PHYEMACRXCLK_EMACCLIENTRXSTATS(6),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXSTATSBYTEVLD,
          GlitchData    => EMACCLIENTRXSTATSBYTEVLD_GlitchData,
          OutSignalName => "EMACCLIENTRXSTATSBYTEVLD",
          OutTemp       => EMACCLIENTRXSTATSBYTEVLD_out,
          Paths       => (0 => (CLIENTEMACRXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXSTATSBYTEVLD,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXSTATSBYTEVLD,
          GlitchData    => EMACCLIENTRXSTATSBYTEVLD_GlitchData,
          OutSignalName => "EMACCLIENTRXSTATSBYTEVLD",
          OutTemp       => EMACCLIENTRXSTATSBYTEVLD_out,
          Paths       => (0 => (PHYEMACRXCLK_dly'last_event, tpd_PHYEMACRXCLK_EMACCLIENTRXSTATSBYTEVLD,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXSTATSVLD,
          GlitchData    => EMACCLIENTRXSTATSVLD_GlitchData,
          OutSignalName => "EMACCLIENTRXSTATSVLD",
          OutTemp       => EMACCLIENTRXSTATSVLD_out,
          Paths       => (0 => (CLIENTEMACRXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACRXCLIENTCLKIN_EMACCLIENTRXSTATSVLD,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTRXSTATSVLD,
          GlitchData    => EMACCLIENTRXSTATSVLD_GlitchData,
          OutSignalName => "EMACCLIENTRXSTATSVLD",
          OutTemp       => EMACCLIENTRXSTATSVLD_out,
          Paths       => (0 => (PHYEMACRXCLK_dly'last_event, tpd_PHYEMACRXCLK_EMACCLIENTRXSTATSVLD,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTTXACK,
          GlitchData    => EMACCLIENTTXACK_GlitchData,
          OutSignalName => "EMACCLIENTTXACK",
          OutTemp       => EMACCLIENTTXACK_out,
          Paths       => (0 => (CLIENTEMACTXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACTXCLIENTCLKIN_EMACCLIENTTXACK,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTTXACK,
          GlitchData    => EMACCLIENTTXACK_GlitchData,
          OutSignalName => "EMACCLIENTTXACK",
          OutTemp       => EMACCLIENTTXACK_out,
          Paths       => (0 => (PHYEMACMIITXCLK_dly'last_event, tpd_PHYEMACMIITXCLK_EMACCLIENTTXACK,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTTXACK,
          GlitchData    => EMACCLIENTTXACK_GlitchData,
          OutSignalName => "EMACCLIENTTXACK",
          OutTemp       => EMACCLIENTTXACK_out,
          Paths       => (0 => (PHYEMACTXGMIIMIICLKIN_dly'last_event, tpd_PHYEMACTXGMIIMIICLKIN_EMACCLIENTTXACK,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTTXCLIENTCLKOUT,
          GlitchData    => EMACCLIENTTXCLIENTCLKOUT_GlitchData,
          OutSignalName => "EMACCLIENTTXCLIENTCLKOUT",
          OutTemp       => EMACCLIENTTXCLIENTCLKOUT_out,
          Paths       => (0 => (PHYEMACGTXCLK_dly'last_event, tpd_PHYEMACGTXCLK_EMACCLIENTTXCLIENTCLKOUT,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTTXCLIENTCLKOUT,
          GlitchData    => EMACCLIENTTXCLIENTCLKOUT_GlitchData,
          OutSignalName => "EMACCLIENTTXCLIENTCLKOUT",
          OutTemp       => EMACCLIENTTXCLIENTCLKOUT_out,
          Paths       => (0 => (PHYEMACMIITXCLK_dly'last_event, tpd_PHYEMACMIITXCLK_EMACCLIENTTXCLIENTCLKOUT,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTTXCLIENTCLKOUT,
          GlitchData    => EMACCLIENTTXCLIENTCLKOUT_GlitchData,
          OutSignalName => "EMACCLIENTTXCLIENTCLKOUT",
          OutTemp       => EMACCLIENTTXCLIENTCLKOUT_out,
          Paths       => (0 => (PHYEMACTXGMIIMIICLKIN_dly'last_event, tpd_PHYEMACTXGMIIMIICLKIN_EMACCLIENTTXCLIENTCLKOUT,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTTXCOLLISION,
          GlitchData    => EMACCLIENTTXCOLLISION_GlitchData,
          OutSignalName => "EMACCLIENTTXCOLLISION",
          OutTemp       => EMACCLIENTTXCOLLISION_out,
          Paths       => (0 => (CLIENTEMACTXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACTXCLIENTCLKIN_EMACCLIENTTXCOLLISION,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTTXCOLLISION,
          GlitchData    => EMACCLIENTTXCOLLISION_GlitchData,
          OutSignalName => "EMACCLIENTTXCOLLISION",
          OutTemp       => EMACCLIENTTXCOLLISION_out,
          Paths       => (0 => (PHYEMACMIITXCLK_dly'last_event, tpd_PHYEMACMIITXCLK_EMACCLIENTTXCOLLISION,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTTXCOLLISION,
          GlitchData    => EMACCLIENTTXCOLLISION_GlitchData,
          OutSignalName => "EMACCLIENTTXCOLLISION",
          OutTemp       => EMACCLIENTTXCOLLISION_out,
          Paths       => (0 => (PHYEMACTXGMIIMIICLKIN_dly'last_event, tpd_PHYEMACTXGMIIMIICLKIN_EMACCLIENTTXCOLLISION,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTTXRETRANSMIT,
          GlitchData    => EMACCLIENTTXRETRANSMIT_GlitchData,
          OutSignalName => "EMACCLIENTTXRETRANSMIT",
          OutTemp       => EMACCLIENTTXRETRANSMIT_out,
          Paths       => (0 => (CLIENTEMACTXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACTXCLIENTCLKIN_EMACCLIENTTXRETRANSMIT,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTTXRETRANSMIT,
          GlitchData    => EMACCLIENTTXRETRANSMIT_GlitchData,
          OutSignalName => "EMACCLIENTTXRETRANSMIT",
          OutTemp       => EMACCLIENTTXRETRANSMIT_out,
          Paths       => (0 => (PHYEMACMIITXCLK_dly'last_event, tpd_PHYEMACMIITXCLK_EMACCLIENTTXRETRANSMIT,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTTXRETRANSMIT,
          GlitchData    => EMACCLIENTTXRETRANSMIT_GlitchData,
          OutSignalName => "EMACCLIENTTXRETRANSMIT",
          OutTemp       => EMACCLIENTTXRETRANSMIT_out,
          Paths       => (0 => (PHYEMACTXGMIIMIICLKIN_dly'last_event, tpd_PHYEMACTXGMIIMIICLKIN_EMACCLIENTTXRETRANSMIT,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTTXSTATS,
          GlitchData    => EMACCLIENTTXSTATS_GlitchData,
          OutSignalName => "EMACCLIENTTXSTATS",
          OutTemp       => EMACCLIENTTXSTATS_out,
          Paths       => (0 => (CLIENTEMACTXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACTXCLIENTCLKIN_EMACCLIENTTXSTATS,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTTXSTATS,
          GlitchData    => EMACCLIENTTXSTATS_GlitchData,
          OutSignalName => "EMACCLIENTTXSTATS",
          OutTemp       => EMACCLIENTTXSTATS_out,
          Paths       => (0 => (PHYEMACTXGMIIMIICLKIN_dly'last_event, tpd_PHYEMACTXGMIIMIICLKIN_EMACCLIENTTXSTATS,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTTXSTATSBYTEVLD,
          GlitchData    => EMACCLIENTTXSTATSBYTEVLD_GlitchData,
          OutSignalName => "EMACCLIENTTXSTATSBYTEVLD",
          OutTemp       => EMACCLIENTTXSTATSBYTEVLD_out,
          Paths       => (0 => (CLIENTEMACTXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACTXCLIENTCLKIN_EMACCLIENTTXSTATSBYTEVLD,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTTXSTATSBYTEVLD,
          GlitchData    => EMACCLIENTTXSTATSBYTEVLD_GlitchData,
          OutSignalName => "EMACCLIENTTXSTATSBYTEVLD",
          OutTemp       => EMACCLIENTTXSTATSBYTEVLD_out,
          Paths       => (0 => (PHYEMACTXGMIIMIICLKIN_dly'last_event, tpd_PHYEMACTXGMIIMIICLKIN_EMACCLIENTTXSTATSBYTEVLD,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTTXSTATSVLD,
          GlitchData    => EMACCLIENTTXSTATSVLD_GlitchData,
          OutSignalName => "EMACCLIENTTXSTATSVLD",
          OutTemp       => EMACCLIENTTXSTATSVLD_out,
          Paths       => (0 => (CLIENTEMACTXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMACTXCLIENTCLKIN_EMACCLIENTTXSTATSVLD,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACCLIENTTXSTATSVLD,
          GlitchData    => EMACCLIENTTXSTATSVLD_GlitchData,
          OutSignalName => "EMACCLIENTTXSTATSVLD",
          OutTemp       => EMACCLIENTTXSTATSVLD_out,
          Paths       => (0 => (PHYEMACTXGMIIMIICLKIN_dly'last_event, tpd_PHYEMACTXGMIIMIICLKIN_EMACCLIENTTXSTATSVLD,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRACK,
          GlitchData    => EMACDCRACK_GlitchData,
          OutSignalName => "EMACDCRACK",
          OutTemp       => EMACDCRACK_out,
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRACK,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(0),
          GlitchData    => EMACDCRDBUS0_GlitchData,
          OutSignalName => "EMACDCRDBUS(0)",
          OutTemp       => EMACDCRDBUS_out(0),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(1),
          GlitchData    => EMACDCRDBUS1_GlitchData,
          OutSignalName => "EMACDCRDBUS(1)",
          OutTemp       => EMACDCRDBUS_out(1),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(10),
          GlitchData    => EMACDCRDBUS10_GlitchData,
          OutSignalName => "EMACDCRDBUS(10)",
          OutTemp       => EMACDCRDBUS_out(10),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(10),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(11),
          GlitchData    => EMACDCRDBUS11_GlitchData,
          OutSignalName => "EMACDCRDBUS(11)",
          OutTemp       => EMACDCRDBUS_out(11),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(11),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(12),
          GlitchData    => EMACDCRDBUS12_GlitchData,
          OutSignalName => "EMACDCRDBUS(12)",
          OutTemp       => EMACDCRDBUS_out(12),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(12),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(13),
          GlitchData    => EMACDCRDBUS13_GlitchData,
          OutSignalName => "EMACDCRDBUS(13)",
          OutTemp       => EMACDCRDBUS_out(13),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(13),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(14),
          GlitchData    => EMACDCRDBUS14_GlitchData,
          OutSignalName => "EMACDCRDBUS(14)",
          OutTemp       => EMACDCRDBUS_out(14),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(14),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(15),
          GlitchData    => EMACDCRDBUS15_GlitchData,
          OutSignalName => "EMACDCRDBUS(15)",
          OutTemp       => EMACDCRDBUS_out(15),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(15),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(16),
          GlitchData    => EMACDCRDBUS16_GlitchData,
          OutSignalName => "EMACDCRDBUS(16)",
          OutTemp       => EMACDCRDBUS_out(16),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(16),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(17),
          GlitchData    => EMACDCRDBUS17_GlitchData,
          OutSignalName => "EMACDCRDBUS(17)",
          OutTemp       => EMACDCRDBUS_out(17),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(17),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(18),
          GlitchData    => EMACDCRDBUS18_GlitchData,
          OutSignalName => "EMACDCRDBUS(18)",
          OutTemp       => EMACDCRDBUS_out(18),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(18),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(19),
          GlitchData    => EMACDCRDBUS19_GlitchData,
          OutSignalName => "EMACDCRDBUS(19)",
          OutTemp       => EMACDCRDBUS_out(19),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(19),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(2),
          GlitchData    => EMACDCRDBUS2_GlitchData,
          OutSignalName => "EMACDCRDBUS(2)",
          OutTemp       => EMACDCRDBUS_out(2),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(20),
          GlitchData    => EMACDCRDBUS20_GlitchData,
          OutSignalName => "EMACDCRDBUS(20)",
          OutTemp       => EMACDCRDBUS_out(20),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(20),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(21),
          GlitchData    => EMACDCRDBUS21_GlitchData,
          OutSignalName => "EMACDCRDBUS(21)",
          OutTemp       => EMACDCRDBUS_out(21),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(21),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(22),
          GlitchData    => EMACDCRDBUS22_GlitchData,
          OutSignalName => "EMACDCRDBUS(22)",
          OutTemp       => EMACDCRDBUS_out(22),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(22),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(23),
          GlitchData    => EMACDCRDBUS23_GlitchData,
          OutSignalName => "EMACDCRDBUS(23)",
          OutTemp       => EMACDCRDBUS_out(23),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(23),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(24),
          GlitchData    => EMACDCRDBUS24_GlitchData,
          OutSignalName => "EMACDCRDBUS(24)",
          OutTemp       => EMACDCRDBUS_out(24),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(24),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(25),
          GlitchData    => EMACDCRDBUS25_GlitchData,
          OutSignalName => "EMACDCRDBUS(25)",
          OutTemp       => EMACDCRDBUS_out(25),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(25),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(26),
          GlitchData    => EMACDCRDBUS26_GlitchData,
          OutSignalName => "EMACDCRDBUS(26)",
          OutTemp       => EMACDCRDBUS_out(26),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(26),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(27),
          GlitchData    => EMACDCRDBUS27_GlitchData,
          OutSignalName => "EMACDCRDBUS(27)",
          OutTemp       => EMACDCRDBUS_out(27),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(27),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(28),
          GlitchData    => EMACDCRDBUS28_GlitchData,
          OutSignalName => "EMACDCRDBUS(28)",
          OutTemp       => EMACDCRDBUS_out(28),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(28),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(29),
          GlitchData    => EMACDCRDBUS29_GlitchData,
          OutSignalName => "EMACDCRDBUS(29)",
          OutTemp       => EMACDCRDBUS_out(29),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(29),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(3),
          GlitchData    => EMACDCRDBUS3_GlitchData,
          OutSignalName => "EMACDCRDBUS(3)",
          OutTemp       => EMACDCRDBUS_out(3),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(3),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(30),
          GlitchData    => EMACDCRDBUS30_GlitchData,
          OutSignalName => "EMACDCRDBUS(30)",
          OutTemp       => EMACDCRDBUS_out(30),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(30),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(31),
          GlitchData    => EMACDCRDBUS31_GlitchData,
          OutSignalName => "EMACDCRDBUS(31)",
          OutTemp       => EMACDCRDBUS_out(31),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(31),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(4),
          GlitchData    => EMACDCRDBUS4_GlitchData,
          OutSignalName => "EMACDCRDBUS(4)",
          OutTemp       => EMACDCRDBUS_out(4),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(4),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(5),
          GlitchData    => EMACDCRDBUS5_GlitchData,
          OutSignalName => "EMACDCRDBUS(5)",
          OutTemp       => EMACDCRDBUS_out(5),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(5),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(6),
          GlitchData    => EMACDCRDBUS6_GlitchData,
          OutSignalName => "EMACDCRDBUS(6)",
          OutTemp       => EMACDCRDBUS_out(6),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(6),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(7),
          GlitchData    => EMACDCRDBUS7_GlitchData,
          OutSignalName => "EMACDCRDBUS(7)",
          OutTemp       => EMACDCRDBUS_out(7),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(7),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(8),
          GlitchData    => EMACDCRDBUS8_GlitchData,
          OutSignalName => "EMACDCRDBUS(8)",
          OutTemp       => EMACDCRDBUS_out(8),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(8),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACDCRDBUS(9),
          GlitchData    => EMACDCRDBUS9_GlitchData,
          OutSignalName => "EMACDCRDBUS(9)",
          OutTemp       => EMACDCRDBUS_out(9),
          Paths       => (0 => (DCREMACCLK_dly'last_event, tpd_DCREMACCLK_EMACDCRDBUS(9),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYENCOMMAALIGN,
          GlitchData    => EMACPHYENCOMMAALIGN_GlitchData,
          OutSignalName => "EMACPHYENCOMMAALIGN",
          OutTemp       => EMACPHYENCOMMAALIGN_out,
          Paths       => (0 => (PHYEMACGTXCLK_dly'last_event, tpd_PHYEMACGTXCLK_EMACPHYENCOMMAALIGN,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYLOOPBACKMSB,
          GlitchData    => EMACPHYLOOPBACKMSB_GlitchData,
          OutSignalName => "EMACPHYLOOPBACKMSB",
          OutTemp       => EMACPHYLOOPBACKMSB_out,
          Paths       => (0 => (PHYEMACGTXCLK_dly'last_event, tpd_PHYEMACGTXCLK_EMACPHYLOOPBACKMSB,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYMCLKOUT,
          GlitchData    => EMACPHYMCLKOUT_GlitchData,
          OutSignalName => "EMACPHYMCLKOUT",
          OutTemp       => EMACPHYMCLKOUT_out,
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_EMACPHYMCLKOUT,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYMCLKOUT,
          GlitchData    => EMACPHYMCLKOUT_GlitchData,
          OutSignalName => "EMACPHYMCLKOUT",
          OutTemp       => EMACPHYMCLKOUT_out,
          Paths       => (0 => (PHYEMACMCLKIN_dly'last_event, tpd_PHYEMACMCLKIN_EMACPHYMCLKOUT,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYMDOUT,
          GlitchData    => EMACPHYMDOUT_GlitchData,
          OutSignalName => "EMACPHYMDOUT",
          OutTemp       => EMACPHYMDOUT_out,
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_EMACPHYMDOUT,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYMDOUT,
          GlitchData    => EMACPHYMDOUT_GlitchData,
          OutSignalName => "EMACPHYMDOUT",
          OutTemp       => EMACPHYMDOUT_out,
          Paths       => (0 => (PHYEMACMCLKIN_dly'last_event, tpd_PHYEMACMCLKIN_EMACPHYMDOUT,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYMDTRI,
          GlitchData    => EMACPHYMDTRI_GlitchData,
          OutSignalName => "EMACPHYMDTRI",
          OutTemp       => EMACPHYMDTRI_out,
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_EMACPHYMDTRI,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYMDTRI,
          GlitchData    => EMACPHYMDTRI_GlitchData,
          OutSignalName => "EMACPHYMDTRI",
          OutTemp       => EMACPHYMDTRI_out,
          Paths       => (0 => (PHYEMACMCLKIN_dly'last_event, tpd_PHYEMACMCLKIN_EMACPHYMDTRI,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYMGTRXRESET,
          GlitchData    => EMACPHYMGTRXRESET_GlitchData,
          OutSignalName => "EMACPHYMGTRXRESET",
          OutTemp       => EMACPHYMGTRXRESET_out,
          Paths       => (0 => (PHYEMACGTXCLK_dly'last_event, tpd_PHYEMACGTXCLK_EMACPHYMGTRXRESET,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYMGTTXRESET,
          GlitchData    => EMACPHYMGTTXRESET_GlitchData,
          OutSignalName => "EMACPHYMGTTXRESET",
          OutTemp       => EMACPHYMGTTXRESET_out,
          Paths       => (0 => (PHYEMACGTXCLK_dly'last_event, tpd_PHYEMACGTXCLK_EMACPHYMGTTXRESET,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYPOWERDOWN,
          GlitchData    => EMACPHYPOWERDOWN_GlitchData,
          OutSignalName => "EMACPHYPOWERDOWN",
          OutTemp       => EMACPHYPOWERDOWN_out,
          Paths       => (0 => (PHYEMACGTXCLK_dly'last_event, tpd_PHYEMACGTXCLK_EMACPHYPOWERDOWN,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYSYNCACQSTATUS,
          GlitchData    => EMACPHYSYNCACQSTATUS_GlitchData,
          OutSignalName => "EMACPHYSYNCACQSTATUS",
          OutTemp       => EMACPHYSYNCACQSTATUS_out,
          Paths       => (0 => (PHYEMACGTXCLK_dly'last_event, tpd_PHYEMACGTXCLK_EMACPHYSYNCACQSTATUS,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYSYNCACQSTATUS,
          GlitchData    => EMACPHYSYNCACQSTATUS_GlitchData,
          OutSignalName => "EMACPHYSYNCACQSTATUS",
          OutTemp       => EMACPHYSYNCACQSTATUS_out,
          Paths       => (0 => (PHYEMACTXGMIIMIICLKIN_dly'last_event, tpd_PHYEMACTXGMIIMIICLKIN_EMACPHYSYNCACQSTATUS,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYTXCHARDISPMODE,
          GlitchData    => EMACPHYTXCHARDISPMODE_GlitchData,
          OutSignalName => "EMACPHYTXCHARDISPMODE",
          OutTemp       => EMACPHYTXCHARDISPMODE_out,
          Paths       => (0 => (PHYEMACGTXCLK_dly'last_event, tpd_PHYEMACGTXCLK_EMACPHYTXCHARDISPMODE,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYTXCHARDISPMODE,
          GlitchData    => EMACPHYTXCHARDISPMODE_GlitchData,
          OutSignalName => "EMACPHYTXCHARDISPMODE",
          OutTemp       => EMACPHYTXCHARDISPMODE_out,
          Paths       => (0 => (PHYEMACTXGMIIMIICLKIN_dly'last_event, tpd_PHYEMACTXGMIIMIICLKIN_EMACPHYTXCHARDISPMODE,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYTXCHARDISPVAL,
          GlitchData    => EMACPHYTXCHARDISPVAL_GlitchData,
          OutSignalName => "EMACPHYTXCHARDISPVAL",
          OutTemp       => EMACPHYTXCHARDISPVAL_out,
          Paths       => (0 => (PHYEMACGTXCLK_dly'last_event, tpd_PHYEMACGTXCLK_EMACPHYTXCHARDISPVAL,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYTXCHARDISPVAL,
          GlitchData    => EMACPHYTXCHARDISPVAL_GlitchData,
          OutSignalName => "EMACPHYTXCHARDISPVAL",
          OutTemp       => EMACPHYTXCHARDISPVAL_out,
          Paths       => (0 => (PHYEMACTXGMIIMIICLKIN_dly'last_event, tpd_PHYEMACTXGMIIMIICLKIN_EMACPHYTXCHARDISPVAL,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYTXCHARISK,
          GlitchData    => EMACPHYTXCHARISK_GlitchData,
          OutSignalName => "EMACPHYTXCHARISK",
          OutTemp       => EMACPHYTXCHARISK_out,
          Paths       => (0 => (PHYEMACGTXCLK_dly'last_event, tpd_PHYEMACGTXCLK_EMACPHYTXCHARISK,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYTXCHARISK,
          GlitchData    => EMACPHYTXCHARISK_GlitchData,
          OutSignalName => "EMACPHYTXCHARISK",
          OutTemp       => EMACPHYTXCHARISK_out,
          Paths       => (0 => (PHYEMACTXGMIIMIICLKIN_dly'last_event, tpd_PHYEMACTXGMIIMIICLKIN_EMACPHYTXCHARISK,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYTXCLK,
          GlitchData    => EMACPHYTXCLK_GlitchData,
          OutSignalName => "EMACPHYTXCLK",
          OutTemp       => EMACPHYTXCLK_out,
          Paths       => (0 => (PHYEMACGTXCLK_dly'last_event, tpd_PHYEMACGTXCLK_EMACPHYTXCLK,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYTXCLK,
          GlitchData    => EMACPHYTXCLK_GlitchData,
          OutSignalName => "EMACPHYTXCLK",
          OutTemp       => EMACPHYTXCLK_out,
          Paths       => (0 => (PHYEMACTXGMIIMIICLKIN_dly'last_event, tpd_PHYEMACTXGMIIMIICLKIN_EMACPHYTXCLK,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYTXD(0),
          GlitchData    => EMACPHYTXD0_GlitchData,
          OutSignalName => "EMACPHYTXD(0)",
          OutTemp       => EMACPHYTXD_out(0),
          Paths       => (0 => (PHYEMACGTXCLK_dly'last_event, tpd_PHYEMACGTXCLK_EMACPHYTXD(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYTXD(0),
          GlitchData    => EMACPHYTXD0_GlitchData,
          OutSignalName => "EMACPHYTXD(0)",
          OutTemp       => EMACPHYTXD_out(0),
          Paths       => (0 => (PHYEMACTXGMIIMIICLKIN_dly'last_event, tpd_PHYEMACTXGMIIMIICLKIN_EMACPHYTXD(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYTXD(1),
          GlitchData    => EMACPHYTXD1_GlitchData,
          OutSignalName => "EMACPHYTXD(1)",
          OutTemp       => EMACPHYTXD_out(1),
          Paths       => (0 => (PHYEMACGTXCLK_dly'last_event, tpd_PHYEMACGTXCLK_EMACPHYTXD(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYTXD(1),
          GlitchData    => EMACPHYTXD1_GlitchData,
          OutSignalName => "EMACPHYTXD(1)",
          OutTemp       => EMACPHYTXD_out(1),
          Paths       => (0 => (PHYEMACTXGMIIMIICLKIN_dly'last_event, tpd_PHYEMACTXGMIIMIICLKIN_EMACPHYTXD(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYTXD(2),
          GlitchData    => EMACPHYTXD2_GlitchData,
          OutSignalName => "EMACPHYTXD(2)",
          OutTemp       => EMACPHYTXD_out(2),
          Paths       => (0 => (PHYEMACGTXCLK_dly'last_event, tpd_PHYEMACGTXCLK_EMACPHYTXD(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYTXD(2),
          GlitchData    => EMACPHYTXD2_GlitchData,
          OutSignalName => "EMACPHYTXD(2)",
          OutTemp       => EMACPHYTXD_out(2),
          Paths       => (0 => (PHYEMACTXGMIIMIICLKIN_dly'last_event, tpd_PHYEMACTXGMIIMIICLKIN_EMACPHYTXD(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYTXD(3),
          GlitchData    => EMACPHYTXD3_GlitchData,
          OutSignalName => "EMACPHYTXD(3)",
          OutTemp       => EMACPHYTXD_out(3),
          Paths       => (0 => (PHYEMACGTXCLK_dly'last_event, tpd_PHYEMACGTXCLK_EMACPHYTXD(3),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYTXD(3),
          GlitchData    => EMACPHYTXD3_GlitchData,
          OutSignalName => "EMACPHYTXD(3)",
          OutTemp       => EMACPHYTXD_out(3),
          Paths       => (0 => (PHYEMACTXGMIIMIICLKIN_dly'last_event, tpd_PHYEMACTXGMIIMIICLKIN_EMACPHYTXD(3),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYTXD(4),
          GlitchData    => EMACPHYTXD4_GlitchData,
          OutSignalName => "EMACPHYTXD(4)",
          OutTemp       => EMACPHYTXD_out(4),
          Paths       => (0 => (PHYEMACGTXCLK_dly'last_event, tpd_PHYEMACGTXCLK_EMACPHYTXD(4),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYTXD(4),
          GlitchData    => EMACPHYTXD4_GlitchData,
          OutSignalName => "EMACPHYTXD(4)",
          OutTemp       => EMACPHYTXD_out(4),
          Paths       => (0 => (PHYEMACTXGMIIMIICLKIN_dly'last_event, tpd_PHYEMACTXGMIIMIICLKIN_EMACPHYTXD(4),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYTXD(5),
          GlitchData    => EMACPHYTXD5_GlitchData,
          OutSignalName => "EMACPHYTXD(5)",
          OutTemp       => EMACPHYTXD_out(5),
          Paths       => (0 => (PHYEMACGTXCLK_dly'last_event, tpd_PHYEMACGTXCLK_EMACPHYTXD(5),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYTXD(5),
          GlitchData    => EMACPHYTXD5_GlitchData,
          OutSignalName => "EMACPHYTXD(5)",
          OutTemp       => EMACPHYTXD_out(5),
          Paths       => (0 => (PHYEMACTXGMIIMIICLKIN_dly'last_event, tpd_PHYEMACTXGMIIMIICLKIN_EMACPHYTXD(5),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYTXD(6),
          GlitchData    => EMACPHYTXD6_GlitchData,
          OutSignalName => "EMACPHYTXD(6)",
          OutTemp       => EMACPHYTXD_out(6),
          Paths       => (0 => (PHYEMACGTXCLK_dly'last_event, tpd_PHYEMACGTXCLK_EMACPHYTXD(6),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYTXD(6),
          GlitchData    => EMACPHYTXD6_GlitchData,
          OutSignalName => "EMACPHYTXD(6)",
          OutTemp       => EMACPHYTXD_out(6),
          Paths       => (0 => (PHYEMACTXGMIIMIICLKIN_dly'last_event, tpd_PHYEMACTXGMIIMIICLKIN_EMACPHYTXD(6),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYTXD(7),
          GlitchData    => EMACPHYTXD7_GlitchData,
          OutSignalName => "EMACPHYTXD(7)",
          OutTemp       => EMACPHYTXD_out(7),
          Paths       => (0 => (PHYEMACGTXCLK_dly'last_event, tpd_PHYEMACGTXCLK_EMACPHYTXD(7),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYTXD(7),
          GlitchData    => EMACPHYTXD7_GlitchData,
          OutSignalName => "EMACPHYTXD(7)",
          OutTemp       => EMACPHYTXD_out(7),
          Paths       => (0 => (PHYEMACTXGMIIMIICLKIN_dly'last_event, tpd_PHYEMACTXGMIIMIICLKIN_EMACPHYTXD(7),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYTXEN,
          GlitchData    => EMACPHYTXEN_GlitchData,
          OutSignalName => "EMACPHYTXEN",
          OutTemp       => EMACPHYTXEN_out,
          Paths       => (0 => (PHYEMACGTXCLK_dly'last_event, tpd_PHYEMACGTXCLK_EMACPHYTXEN,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYTXEN,
          GlitchData    => EMACPHYTXEN_GlitchData,
          OutSignalName => "EMACPHYTXEN",
          OutTemp       => EMACPHYTXEN_out,
          Paths       => (0 => (PHYEMACTXGMIIMIICLKIN_dly'last_event, tpd_PHYEMACTXGMIIMIICLKIN_EMACPHYTXEN,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYTXER,
          GlitchData    => EMACPHYTXER_GlitchData,
          OutSignalName => "EMACPHYTXER",
          OutTemp       => EMACPHYTXER_out,
          Paths       => (0 => (PHYEMACGTXCLK_dly'last_event, tpd_PHYEMACGTXCLK_EMACPHYTXER,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYTXER,
          GlitchData    => EMACPHYTXER_GlitchData,
          OutSignalName => "EMACPHYTXER",
          OutTemp       => EMACPHYTXER_out,
          Paths       => (0 => (PHYEMACTXGMIIMIICLKIN_dly'last_event, tpd_PHYEMACTXGMIIMIICLKIN_EMACPHYTXER,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYTXGMIIMIICLKOUT,
          GlitchData    => EMACPHYTXGMIIMIICLKOUT_GlitchData,
          OutSignalName => "EMACPHYTXGMIIMIICLKOUT",
          OutTemp       => EMACPHYTXGMIIMIICLKOUT_out,
          Paths       => (0 => (PHYEMACGTXCLK_dly'last_event, tpd_PHYEMACGTXCLK_EMACPHYTXGMIIMIICLKOUT,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACPHYTXGMIIMIICLKOUT,
          GlitchData    => EMACPHYTXGMIIMIICLKOUT_GlitchData,
          OutSignalName => "EMACPHYTXGMIIMIICLKOUT",
          OutTemp       => EMACPHYTXGMIIMIICLKOUT_out,
          Paths       => (0 => (PHYEMACMIITXCLK_dly'last_event, tpd_PHYEMACMIITXCLK_EMACPHYTXGMIIMIICLKOUT,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => EMACSPEEDIS10100,
          GlitchData    => EMACSPEEDIS10100_GlitchData,
          OutSignalName => "EMACSPEEDIS10100",
          OutTemp       => EMACSPEEDIS10100_out,
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_EMACSPEEDIS10100,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTMIIMRDY,
          GlitchData    => HOSTMIIMRDY_GlitchData,
          OutSignalName => "HOSTMIIMRDY",
          OutTemp       => HOSTMIIMRDY_out,
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTMIIMRDY,TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(0),
          GlitchData    => HOSTRDDATA0_GlitchData,
          OutSignalName => "HOSTRDDATA(0)",
          OutTemp       => HOSTRDDATA_out(0),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(0),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(1),
          GlitchData    => HOSTRDDATA1_GlitchData,
          OutSignalName => "HOSTRDDATA(1)",
          OutTemp       => HOSTRDDATA_out(1),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(1),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(10),
          GlitchData    => HOSTRDDATA10_GlitchData,
          OutSignalName => "HOSTRDDATA(10)",
          OutTemp       => HOSTRDDATA_out(10),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(10),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(11),
          GlitchData    => HOSTRDDATA11_GlitchData,
          OutSignalName => "HOSTRDDATA(11)",
          OutTemp       => HOSTRDDATA_out(11),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(11),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(12),
          GlitchData    => HOSTRDDATA12_GlitchData,
          OutSignalName => "HOSTRDDATA(12)",
          OutTemp       => HOSTRDDATA_out(12),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(12),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(13),
          GlitchData    => HOSTRDDATA13_GlitchData,
          OutSignalName => "HOSTRDDATA(13)",
          OutTemp       => HOSTRDDATA_out(13),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(13),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(14),
          GlitchData    => HOSTRDDATA14_GlitchData,
          OutSignalName => "HOSTRDDATA(14)",
          OutTemp       => HOSTRDDATA_out(14),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(14),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(15),
          GlitchData    => HOSTRDDATA15_GlitchData,
          OutSignalName => "HOSTRDDATA(15)",
          OutTemp       => HOSTRDDATA_out(15),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(15),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(16),
          GlitchData    => HOSTRDDATA16_GlitchData,
          OutSignalName => "HOSTRDDATA(16)",
          OutTemp       => HOSTRDDATA_out(16),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(16),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(17),
          GlitchData    => HOSTRDDATA17_GlitchData,
          OutSignalName => "HOSTRDDATA(17)",
          OutTemp       => HOSTRDDATA_out(17),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(17),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(18),
          GlitchData    => HOSTRDDATA18_GlitchData,
          OutSignalName => "HOSTRDDATA(18)",
          OutTemp       => HOSTRDDATA_out(18),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(18),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(19),
          GlitchData    => HOSTRDDATA19_GlitchData,
          OutSignalName => "HOSTRDDATA(19)",
          OutTemp       => HOSTRDDATA_out(19),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(19),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(2),
          GlitchData    => HOSTRDDATA2_GlitchData,
          OutSignalName => "HOSTRDDATA(2)",
          OutTemp       => HOSTRDDATA_out(2),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(2),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(20),
          GlitchData    => HOSTRDDATA20_GlitchData,
          OutSignalName => "HOSTRDDATA(20)",
          OutTemp       => HOSTRDDATA_out(20),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(20),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(21),
          GlitchData    => HOSTRDDATA21_GlitchData,
          OutSignalName => "HOSTRDDATA(21)",
          OutTemp       => HOSTRDDATA_out(21),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(21),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(22),
          GlitchData    => HOSTRDDATA22_GlitchData,
          OutSignalName => "HOSTRDDATA(22)",
          OutTemp       => HOSTRDDATA_out(22),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(22),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(23),
          GlitchData    => HOSTRDDATA23_GlitchData,
          OutSignalName => "HOSTRDDATA(23)",
          OutTemp       => HOSTRDDATA_out(23),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(23),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(24),
          GlitchData    => HOSTRDDATA24_GlitchData,
          OutSignalName => "HOSTRDDATA(24)",
          OutTemp       => HOSTRDDATA_out(24),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(24),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(25),
          GlitchData    => HOSTRDDATA25_GlitchData,
          OutSignalName => "HOSTRDDATA(25)",
          OutTemp       => HOSTRDDATA_out(25),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(25),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(26),
          GlitchData    => HOSTRDDATA26_GlitchData,
          OutSignalName => "HOSTRDDATA(26)",
          OutTemp       => HOSTRDDATA_out(26),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(26),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(27),
          GlitchData    => HOSTRDDATA27_GlitchData,
          OutSignalName => "HOSTRDDATA(27)",
          OutTemp       => HOSTRDDATA_out(27),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(27),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(28),
          GlitchData    => HOSTRDDATA28_GlitchData,
          OutSignalName => "HOSTRDDATA(28)",
          OutTemp       => HOSTRDDATA_out(28),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(28),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(29),
          GlitchData    => HOSTRDDATA29_GlitchData,
          OutSignalName => "HOSTRDDATA(29)",
          OutTemp       => HOSTRDDATA_out(29),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(29),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(3),
          GlitchData    => HOSTRDDATA3_GlitchData,
          OutSignalName => "HOSTRDDATA(3)",
          OutTemp       => HOSTRDDATA_out(3),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(3),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(30),
          GlitchData    => HOSTRDDATA30_GlitchData,
          OutSignalName => "HOSTRDDATA(30)",
          OutTemp       => HOSTRDDATA_out(30),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(30),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(31),
          GlitchData    => HOSTRDDATA31_GlitchData,
          OutSignalName => "HOSTRDDATA(31)",
          OutTemp       => HOSTRDDATA_out(31),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(31),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(4),
          GlitchData    => HOSTRDDATA4_GlitchData,
          OutSignalName => "HOSTRDDATA(4)",
          OutTemp       => HOSTRDDATA_out(4),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(4),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(5),
          GlitchData    => HOSTRDDATA5_GlitchData,
          OutSignalName => "HOSTRDDATA(5)",
          OutTemp       => HOSTRDDATA_out(5),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(5),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(6),
          GlitchData    => HOSTRDDATA6_GlitchData,
          OutSignalName => "HOSTRDDATA(6)",
          OutTemp       => HOSTRDDATA_out(6),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(6),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(7),
          GlitchData    => HOSTRDDATA7_GlitchData,
          OutSignalName => "HOSTRDDATA(7)",
          OutTemp       => HOSTRDDATA_out(7),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(7),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(8),
          GlitchData    => HOSTRDDATA8_GlitchData,
          OutSignalName => "HOSTRDDATA(8)",
          OutTemp       => HOSTRDDATA_out(8),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(8),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        VitalPathDelay01
        (
          OutSignal     => HOSTRDDATA(9),
          GlitchData    => HOSTRDDATA9_GlitchData,
          OutSignalName => "HOSTRDDATA(9)",
          OutTemp       => HOSTRDDATA_out(9),
          Paths       => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(9),TRUE)),
          Mode          => VitalTransport,
          Xon           => false,
          MsgOn          => false,
          MsgSeverity    => WARNING
        );
        wait on
        DCRHOSTDONEIR_out,
        EMACCLIENTANINTERRUPT_out,
        EMACCLIENTRXBADFRAME_out,
        EMACCLIENTRXCLIENTCLKOUT_out,
        EMACCLIENTRXDVLDMSW_out,
        EMACCLIENTRXDVLD_out,
        EMACCLIENTRXD_out,
        EMACCLIENTRXFRAMEDROP_out,
        EMACCLIENTRXGOODFRAME_out,
        EMACCLIENTRXSTATSBYTEVLD_out,
        EMACCLIENTRXSTATSVLD_out,
        EMACCLIENTRXSTATS_out,
        EMACCLIENTTXACK_out,
        EMACCLIENTTXCLIENTCLKOUT_out,
        EMACCLIENTTXCOLLISION_out,
        EMACCLIENTTXRETRANSMIT_out,
        EMACCLIENTTXSTATSBYTEVLD_out,
        EMACCLIENTTXSTATSVLD_out,
        EMACCLIENTTXSTATS_out,
        EMACDCRACK_out,
        EMACDCRDBUS_out,
        EMACPHYENCOMMAALIGN_out,
        EMACPHYLOOPBACKMSB_out,
        EMACPHYMCLKOUT_out,
        EMACPHYMDOUT_out,
        EMACPHYMDTRI_out,
        EMACPHYMGTRXRESET_out,
        EMACPHYMGTTXRESET_out,
        EMACPHYPOWERDOWN_out,
        EMACPHYSYNCACQSTATUS_out,
        EMACPHYTXCHARDISPMODE_out,
        EMACPHYTXCHARDISPVAL_out,
        EMACPHYTXCHARISK_out,
        EMACPHYTXCLK_out,
        EMACPHYTXD_out,
        EMACPHYTXEN_out,
        EMACPHYTXER_out,
        EMACPHYTXGMIIMIICLKOUT_out,
        EMACSPEEDIS10100_out,
        HOSTMIIMRDY_out,
        HOSTRDDATA_out,
        CLIENTEMACDCMLOCKED_CLIENTEMACTXCLIENTCLKIN_dly,
        CLIENTEMACDCMLOCKED_PHYEMACMIITXCLK_dly,
        CLIENTEMACDCMLOCKED_PHYEMACTXGMIIMIICLKIN_dly,
        CLIENTEMACPAUSEREQ_CLIENTEMACTXCLIENTCLKIN_dly,
        CLIENTEMACPAUSEREQ_PHYEMACMIITXCLK_dly,
        CLIENTEMACPAUSEREQ_PHYEMACTXGMIIMIICLKIN_dly,
        CLIENTEMACPAUSEVAL_CLIENTEMACTXCLIENTCLKIN_dly,
        CLIENTEMACPAUSEVAL_PHYEMACMIITXCLK_dly,
        CLIENTEMACPAUSEVAL_PHYEMACTXGMIIMIICLKIN_dly,
        CLIENTEMACTXDVLDMSW_CLIENTEMACTXCLIENTCLKIN_dly,
        CLIENTEMACTXDVLDMSW_PHYEMACMIITXCLK_dly,
        CLIENTEMACTXDVLDMSW_PHYEMACTXGMIIMIICLKIN_dly,
        CLIENTEMACTXDVLD_CLIENTEMACTXCLIENTCLKIN_dly,
        CLIENTEMACTXDVLD_PHYEMACMIITXCLK_dly,
        CLIENTEMACTXDVLD_PHYEMACTXGMIIMIICLKIN_dly,
        CLIENTEMACTXD_CLIENTEMACTXCLIENTCLKIN_dly,
        CLIENTEMACTXD_PHYEMACMIITXCLK_dly,
        CLIENTEMACTXD_PHYEMACTXGMIIMIICLKIN_dly,
        CLIENTEMACTXFIRSTBYTE_CLIENTEMACTXCLIENTCLKIN_dly,
        CLIENTEMACTXFIRSTBYTE_PHYEMACMIITXCLK_dly,
        CLIENTEMACTXFIRSTBYTE_PHYEMACTXGMIIMIICLKIN_dly,
        CLIENTEMACTXIFGDELAY_CLIENTEMACTXCLIENTCLKIN_dly,
        CLIENTEMACTXIFGDELAY_PHYEMACMIITXCLK_dly,
        CLIENTEMACTXIFGDELAY_PHYEMACTXGMIIMIICLKIN_dly,
        CLIENTEMACTXUNDERRUN_CLIENTEMACTXCLIENTCLKIN_dly,
        CLIENTEMACTXUNDERRUN_PHYEMACMIITXCLK_dly,
        CLIENTEMACTXUNDERRUN_PHYEMACTXGMIIMIICLKIN_dly,
        DCREMACABUS_DCREMACCLK_dly,
        DCREMACDBUS_DCREMACCLK_dly,
        DCREMACENABLE_DCREMACCLK_dly,
        DCREMACREAD_DCREMACCLK_dly,
        DCREMACWRITE_DCREMACCLK_dly,
        HOSTADDR_HOSTCLK_dly,
        HOSTMIIMSEL_HOSTCLK_dly,
        HOSTOPCODE_HOSTCLK_dly,
        HOSTREQ_HOSTCLK_dly,
        HOSTWRDATA_HOSTCLK_dly,
        PHYEMACCOL_PHYEMACGTXCLK_dly,
        PHYEMACCOL_PHYEMACRXCLK_dly,
        PHYEMACCRS_PHYEMACGTXCLK_dly,
        PHYEMACCRS_PHYEMACRXCLK_dly,
        PHYEMACMDIN_HOSTCLK_dly,
        PHYEMACMDIN_PHYEMACMCLKIN_dly,
        PHYEMACPHYAD_HOSTCLK_dly,
        PHYEMACRXBUFSTATUS_PHYEMACGTXCLK_dly,
        PHYEMACRXBUFSTATUS_PHYEMACRXCLK_dly,
        PHYEMACRXCHARISCOMMA_PHYEMACGTXCLK_dly,
        PHYEMACRXCHARISCOMMA_PHYEMACRXCLK_dly,
        PHYEMACRXCHARISK_PHYEMACGTXCLK_dly,
        PHYEMACRXCHARISK_PHYEMACRXCLK_dly,
        PHYEMACRXCLKCORCNT_PHYEMACGTXCLK_dly,
        PHYEMACRXCLKCORCNT_PHYEMACRXCLK_dly,
        PHYEMACRXDISPERR_PHYEMACGTXCLK_dly,
        PHYEMACRXDISPERR_PHYEMACRXCLK_dly,
        PHYEMACRXDV_PHYEMACGTXCLK_dly,
        PHYEMACRXDV_PHYEMACRXCLK_dly,
        PHYEMACRXD_PHYEMACGTXCLK_dly,
        PHYEMACRXD_PHYEMACRXCLK_dly,
        PHYEMACRXER_PHYEMACGTXCLK_dly,
        PHYEMACRXER_PHYEMACRXCLK_dly,
        PHYEMACRXNOTINTABLE_PHYEMACGTXCLK_dly,
        PHYEMACRXNOTINTABLE_PHYEMACRXCLK_dly,
        PHYEMACRXRUNDISP_PHYEMACGTXCLK_dly,
        PHYEMACRXRUNDISP_PHYEMACRXCLK_dly,
        PHYEMACSIGNALDET_PHYEMACGTXCLK_dly,
        PHYEMACSIGNALDET_PHYEMACRXCLK_dly,
        PHYEMACTXBUFERR_PHYEMACGTXCLK_dly,
        PHYEMACTXBUFERR_PHYEMACTXGMIIMIICLKIN_dly,
        RESET_CLIENTEMACTXCLIENTCLKIN_dly,
        RESET_HOSTCLK_dly,
        RESET_PHYEMACGTXCLK_dly,
        RESET_PHYEMACMIITXCLK_dly,
        RESET_PHYEMACTXGMIIMIICLKIN_dly;
    end process TIMING;
  end X_TEMAC_SINGLE_V;

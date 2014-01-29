-------------------------------------------------------------------------------
-- Copyright (c) 1995/2004 Xilinx, Inc.
-- All Right Reserved.
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor : Xilinx
-- \   \   \/     Version : 11.1
--  \   \         Description : Xilinx Timing Simulation Library Component
--  /   /                  Ethernet Media Access Controller
-- /___/   /\     Filename : X_EMAC.vhd
-- \   \  /  \    Timestamp : Fri Jun 18 10:57:22 PDT 2004
--  \___\/\___\
--
-- Revision:
--    03/23/04 - Initial version.
--    08/08/05 - Added missing timing checks.(CR#214079)
--    08/08/05 - Fixed signal connectivity issues.(CR#211723)
--    10/04/05 - Fixed CR#217767. Fixed connectivity for three output ports EMACDCRACK, EMACDCRDBUS and DCRHOSTDONEIR.
--    12/07/07 - Fixed CR#455025. Added delays for 16 bit client mode.
--    02/04/08 - Fixed CR#460680. Changed delay to 125ps.
--    09/11/08 - Fixed CR#476740. Added 10 ps delay to dcremacclk.
-- End Revision
----- CELL X_EMAC -----
library IEEE;
use IEEE.STD_LOGIC_1164.all;

library IEEE;
use IEEE.VITAL_Timing.all;

library simprim;
use simprim.VCOMPONENTS.all; 

library secureip; 
use secureip.all; 

entity X_EMAC is
generic (
        TimingChecksOn : boolean := TRUE;
        InstancePath   : string  := "*";
        Xon            : boolean := TRUE;
        MsgOn          : boolean := FALSE;
        LOC            : string  := "UNPLACED";                

--  Pin pulse width delays
--  Pin period delays

--  Input Pin path delays
        tipd_CLIENTEMAC0DCMLOCKED : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_CLIENTEMAC0PAUSEREQ : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_CLIENTEMAC0PAUSEVAL : VitalDelayArrayType01 (15 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_CLIENTEMAC0RXCLIENTCLKIN : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_CLIENTEMAC0TXCLIENTCLKIN : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_CLIENTEMAC0TXD : VitalDelayArrayType01 (15 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_CLIENTEMAC0TXDVLD : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_CLIENTEMAC0TXDVLDMSW : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_CLIENTEMAC0TXFIRSTBYTE : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_CLIENTEMAC0TXGMIIMIICLKIN : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_CLIENTEMAC0TXIFGDELAY : VitalDelayArrayType01 (7 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_CLIENTEMAC0TXUNDERRUN : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_CLIENTEMAC1DCMLOCKED : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_CLIENTEMAC1PAUSEREQ : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_CLIENTEMAC1PAUSEVAL : VitalDelayArrayType01 (15 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_CLIENTEMAC1RXCLIENTCLKIN : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_CLIENTEMAC1TXCLIENTCLKIN : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_CLIENTEMAC1TXD : VitalDelayArrayType01 (15 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_CLIENTEMAC1TXDVLD : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_CLIENTEMAC1TXDVLDMSW : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_CLIENTEMAC1TXFIRSTBYTE : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_CLIENTEMAC1TXGMIIMIICLKIN : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_CLIENTEMAC1TXIFGDELAY : VitalDelayArrayType01 (7 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_CLIENTEMAC1TXUNDERRUN : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_DCREMACENABLE : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_HOSTADDR : VitalDelayArrayType01 (9 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_HOSTCLK : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_HOSTEMAC1SEL : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_HOSTMIIMSEL : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_HOSTOPCODE : VitalDelayArrayType01 (1 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_HOSTREQ : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_HOSTWRDATA : VitalDelayArrayType01 (31 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_PHYEMAC0COL : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC0CRS : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC0GTXCLK : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC0MCLKIN : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC0MDIN : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC0MIITXCLK : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC0PHYAD : VitalDelayArrayType01 (4 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_PHYEMAC0RXBUFERR : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC0RXBUFSTATUS : VitalDelayArrayType01 (1 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_PHYEMAC0RXCHARISCOMMA : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC0RXCHARISK : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC0RXCHECKINGCRC : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC0RXCLK : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC0RXCLKCORCNT : VitalDelayArrayType01 (2 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_PHYEMAC0RXCOMMADET : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC0RXD : VitalDelayArrayType01 (7 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_PHYEMAC0RXDISPERR : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC0RXDV : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC0RXER : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC0RXLOSSOFSYNC : VitalDelayArrayType01 (1 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_PHYEMAC0RXNOTINTABLE : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC0RXRUNDISP : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC0SIGNALDET : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC0TXBUFERR : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC1COL : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC1CRS : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC1GTXCLK : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC1MCLKIN : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC1MDIN : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC1MIITXCLK : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC1PHYAD : VitalDelayArrayType01 (4 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_PHYEMAC1RXBUFERR : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC1RXBUFSTATUS : VitalDelayArrayType01 (1 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_PHYEMAC1RXCHARISCOMMA : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC1RXCHARISK : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC1RXCHECKINGCRC : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC1RXCLK : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC1RXCLKCORCNT : VitalDelayArrayType01 (2 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_PHYEMAC1RXCOMMADET : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC1RXD : VitalDelayArrayType01 (7 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_PHYEMAC1RXDISPERR : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC1RXDV : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC1RXER : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC1RXLOSSOFSYNC : VitalDelayArrayType01 (1 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_PHYEMAC1RXNOTINTABLE : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC1RXRUNDISP : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC1SIGNALDET : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_PHYEMAC1TXBUFERR : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_RESET : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_TIEEMAC0CONFIGVEC : VitalDelayArrayType01 (79 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_TIEEMAC0UNICASTADDR : VitalDelayArrayType01 (47 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_TIEEMAC1CONFIGVEC : VitalDelayArrayType01 (79 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_TIEEMAC1UNICASTADDR : VitalDelayArrayType01 (47 downto 0) := (others => (0.0 ns, 0.0 ns));
        tipd_DCREMACWRITE : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_DCREMACREAD : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_DCREMACDBUS : VitalDelayArrayType01 (0 to 31) := (others => (0.0 ns, 0.0 ns));
        tipd_DCREMACABUS : VitalDelayArrayType01 (8 to 9) := (others => (0.0 ns, 0.0 ns));
        tipd_DCREMACCLK : VitalDelayType01 :=  (0.0 ns, 0.0 ns);
        tipd_GSR : VitalDelayType01 := (0.0 ns, 0.0 ns);
--  clk-to-output path delays
        tpd_PHYEMAC0GTXCLK_EMAC0CLIENTANINTERRUPT : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXBADFRAME : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC0GTXCLK_EMAC0CLIENTRXCLIENTCLKOUT : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC0RXCLK_EMAC0CLIENTRXCLIENTCLKOUT : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXD : VitalDelayArrayType01(15 downto 0) := (others => (0.1 ns, 0.1 ns));
        tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXDVLD : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXDVLDMSW : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXDVREG6 : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXFRAMEDROP : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXGOODFRAME : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXSTATS : VitalDelayArrayType01(6 downto 0) := (others => (0.1 ns, 0.1 ns));
        tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXSTATSBYTEVLD : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXSTATSVLD : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC0TXCLIENTCLKIN_EMAC0CLIENTTXACK : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC0GTXCLK_EMAC0CLIENTTXCLIENTCLKOUT : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC0MIITXCLK_EMAC0CLIENTTXCLIENTCLKOUT : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC0TXCLIENTCLKIN_EMAC0CLIENTTXCOLLISION : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC0GTXCLK_EMAC0CLIENTTXGMIIMIICLKOUT : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC0MIITXCLK_EMAC0CLIENTTXGMIIMIICLKOUT : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC0TXCLIENTCLKIN_EMAC0CLIENTTXRETRANSMIT : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC0TXCLIENTCLKIN_EMAC0CLIENTTXSTATS : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC0TXCLIENTCLKIN_EMAC0CLIENTTXSTATSBYTEVLD : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC0TXCLIENTCLKIN_EMAC0CLIENTTXSTATSVLD : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC0GTXCLK_EMAC0PHYENCOMMAALIGN : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC0GTXCLK_EMAC0PHYLOOPBACKMSB : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_HOSTCLK_EMAC0PHYMCLKOUT : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC0MCLKIN_EMAC0PHYMCLKOUT : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_HOSTCLK_EMAC0PHYMDOUT : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC0MCLKIN_EMAC0PHYMDOUT : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_HOSTCLK_EMAC0PHYMDTRI : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC0MCLKIN_EMAC0PHYMDTRI : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC0GTXCLK_EMAC0PHYMGTRXRESET : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC0GTXCLK_EMAC0PHYMGTTXRESET : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC0GTXCLK_EMAC0PHYPOWERDOWN : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC0GTXCLK_EMAC0PHYSYNCACQSTATUS : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC0GTXCLK_EMAC0PHYTXCHARDISPMODE : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC0GTXCLK_EMAC0PHYTXCHARDISPVAL : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC0GTXCLK_EMAC0PHYTXCHARISK : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC0GTXCLK_EMAC0PHYTXCLK : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC0TXGMIIMIICLKIN_EMAC0PHYTXD : VitalDelayArrayType01(7 downto 0) := (others => (0.1 ns, 0.1 ns));
        tpd_CLIENTEMAC0TXGMIIMIICLKIN_EMAC0PHYTXEN : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC0TXGMIIMIICLKIN_EMAC0PHYTXER : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC1GTXCLK_EMAC1CLIENTANINTERRUPT : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXBADFRAME : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC1GTXCLK_EMAC1CLIENTRXCLIENTCLKOUT : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC1RXCLK_EMAC1CLIENTRXCLIENTCLKOUT : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXD : VitalDelayArrayType01(15 downto 0) := (others => (0.1 ns, 0.1 ns));
        tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXDVLD : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXDVLDMSW : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXDVREG6 : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXFRAMEDROP : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXGOODFRAME : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXSTATS : VitalDelayArrayType01(6 downto 0) := (others => (0.1 ns, 0.1 ns));
        tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXSTATSBYTEVLD : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXSTATSVLD : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC1TXCLIENTCLKIN_EMAC1CLIENTTXACK : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC1GTXCLK_EMAC1CLIENTTXCLIENTCLKOUT : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC1MIITXCLK_EMAC1CLIENTTXCLIENTCLKOUT : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC1TXCLIENTCLKIN_EMAC1CLIENTTXCOLLISION : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC1GTXCLK_EMAC1CLIENTTXGMIIMIICLKOUT : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC1MIITXCLK_EMAC1CLIENTTXGMIIMIICLKOUT : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC1TXCLIENTCLKIN_EMAC1CLIENTTXRETRANSMIT : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC1TXCLIENTCLKIN_EMAC1CLIENTTXSTATS : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC1TXCLIENTCLKIN_EMAC1CLIENTTXSTATSBYTEVLD : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC1TXCLIENTCLKIN_EMAC1CLIENTTXSTATSVLD : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC1GTXCLK_EMAC1PHYENCOMMAALIGN : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC1GTXCLK_EMAC1PHYLOOPBACKMSB : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_HOSTCLK_EMAC1PHYMCLKOUT : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC1MCLKIN_EMAC1PHYMCLKOUT : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_HOSTCLK_EMAC1PHYMDOUT : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC1MCLKIN_EMAC1PHYMDOUT : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_HOSTCLK_EMAC1PHYMDTRI : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC1MCLKIN_EMAC1PHYMDTRI : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC1GTXCLK_EMAC1PHYMGTRXRESET : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC1GTXCLK_EMAC1PHYMGTTXRESET : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC1GTXCLK_EMAC1PHYPOWERDOWN : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC1GTXCLK_EMAC1PHYSYNCACQSTATUS : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC1GTXCLK_EMAC1PHYTXCHARDISPMODE : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC1GTXCLK_EMAC1PHYTXCHARDISPVAL : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC1GTXCLK_EMAC1PHYTXCHARISK : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_PHYEMAC1GTXCLK_EMAC1PHYTXCLK : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC1TXGMIIMIICLKIN_EMAC1PHYTXD : VitalDelayArrayType01(7 downto 0) := (others => (0.1 ns, 0.1 ns));
        tpd_CLIENTEMAC1TXGMIIMIICLKIN_EMAC1PHYTXEN : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_CLIENTEMAC1TXGMIIMIICLKIN_EMAC1PHYTXER : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_HOSTCLK_HOSTMIIMRDY : VitalDelayType01 := (0.1 ns, 0.1 ns);
        tpd_HOSTCLK_HOSTRDDATA : VitalDelayArrayType01(31 downto 0) := (others => (0.1 ns, 0.1 ns));

--  Setup/Hold delays
        tsetup_CLIENTEMAC0DCMLOCKED_PHYEMAC0GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_CLIENTEMAC0DCMLOCKED_PHYEMAC0GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_CLIENTEMAC0DCMLOCKED_PHYEMAC0GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_CLIENTEMAC0DCMLOCKED_PHYEMAC0GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_CLIENTEMAC0PAUSEREQ_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_CLIENTEMAC0PAUSEREQ_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_CLIENTEMAC0PAUSEREQ_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_CLIENTEMAC0PAUSEREQ_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0.0 ns);
        tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0.0 ns);
        thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0.0 ns);
        thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0.0 ns);
        tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0.0 ns);
        tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0.0 ns);
        thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0.0 ns);
        thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0.0 ns);
        tsetup_CLIENTEMAC0TXDVLD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_CLIENTEMAC0TXDVLD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_CLIENTEMAC0TXDVLD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_CLIENTEMAC0TXDVLD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_CLIENTEMAC0TXDVLDMSW_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_CLIENTEMAC0TXDVLDMSW_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_CLIENTEMAC0TXDVLDMSW_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_CLIENTEMAC0TXDVLDMSW_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_CLIENTEMAC0TXFIRSTBYTE_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_CLIENTEMAC0TXFIRSTBYTE_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_CLIENTEMAC0TXFIRSTBYTE_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_CLIENTEMAC0TXFIRSTBYTE_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        tsetup_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        thold_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        thold_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        tsetup_CLIENTEMAC0TXUNDERRUN_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_CLIENTEMAC0TXUNDERRUN_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_CLIENTEMAC0TXUNDERRUN_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_CLIENTEMAC0TXUNDERRUN_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_CLIENTEMAC1DCMLOCKED_PHYEMAC1GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_CLIENTEMAC1DCMLOCKED_PHYEMAC1GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_CLIENTEMAC1DCMLOCKED_PHYEMAC1GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_CLIENTEMAC1DCMLOCKED_PHYEMAC1GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_CLIENTEMAC1PAUSEREQ_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_CLIENTEMAC1PAUSEREQ_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_CLIENTEMAC1PAUSEREQ_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_CLIENTEMAC1PAUSEREQ_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0.0 ns);
        tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0.0 ns);
        thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0.0 ns);
        thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0.0 ns);
        tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0.0 ns);
        tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0.0 ns);
        thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0.0 ns);
        thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge : VitalDelayArrayType(15 downto 0) := (others => 0.0 ns);
        tsetup_CLIENTEMAC1TXDVLD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_CLIENTEMAC1TXDVLD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_CLIENTEMAC1TXDVLD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_CLIENTEMAC1TXDVLD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_CLIENTEMAC1TXDVLDMSW_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_CLIENTEMAC1TXDVLDMSW_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_CLIENTEMAC1TXDVLDMSW_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_CLIENTEMAC1TXDVLDMSW_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_CLIENTEMAC1TXFIRSTBYTE_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_CLIENTEMAC1TXFIRSTBYTE_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_CLIENTEMAC1TXFIRSTBYTE_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_CLIENTEMAC1TXFIRSTBYTE_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        tsetup_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        thold_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        thold_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        tsetup_CLIENTEMAC1TXUNDERRUN_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_CLIENTEMAC1TXUNDERRUN_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_CLIENTEMAC1TXUNDERRUN_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_CLIENTEMAC1TXUNDERRUN_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_HOSTADDR_HOSTCLK_posedge_posedge : VitalDelayArrayType(9 downto 0) := (others => 0.0 ns);
        tsetup_HOSTADDR_HOSTCLK_negedge_posedge : VitalDelayArrayType(9 downto 0) := (others => 0.0 ns);
        thold_HOSTADDR_HOSTCLK_posedge_posedge : VitalDelayArrayType(9 downto 0) := (others => 0.0 ns);
        thold_HOSTADDR_HOSTCLK_negedge_posedge : VitalDelayArrayType(9 downto 0) := (others => 0.0 ns);
        tsetup_HOSTEMAC1SEL_HOSTCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_HOSTEMAC1SEL_HOSTCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_HOSTEMAC1SEL_HOSTCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_HOSTEMAC1SEL_HOSTCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_HOSTMIIMSEL_HOSTCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_HOSTMIIMSEL_HOSTCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_HOSTMIIMSEL_HOSTCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_HOSTMIIMSEL_HOSTCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_HOSTOPCODE_HOSTCLK_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0.0 ns);
        tsetup_HOSTOPCODE_HOSTCLK_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0.0 ns);
        thold_HOSTOPCODE_HOSTCLK_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0.0 ns);
        thold_HOSTOPCODE_HOSTCLK_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0.0 ns);
        tsetup_HOSTREQ_HOSTCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_HOSTREQ_HOSTCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_HOSTREQ_HOSTCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_HOSTREQ_HOSTCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge : VitalDelayArrayType(31 downto 0) := (others => 0.0 ns);
        tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge : VitalDelayArrayType(31 downto 0) := (others => 0.0 ns);
        thold_HOSTWRDATA_HOSTCLK_posedge_posedge : VitalDelayArrayType(31 downto 0) := (others => 0.0 ns);
        thold_HOSTWRDATA_HOSTCLK_negedge_posedge : VitalDelayArrayType(31 downto 0) := (others => 0.0 ns);
        tsetup_PHYEMAC0COL_PHYEMAC0RXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC0COL_PHYEMAC0RXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC0COL_PHYEMAC0RXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC0COL_PHYEMAC0RXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC0CRS_PHYEMAC0RXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC0CRS_PHYEMAC0RXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC0CRS_PHYEMAC0RXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC0CRS_PHYEMAC0RXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC0MDIN_HOSTCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC0MDIN_HOSTCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC0MDIN_HOSTCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC0MDIN_HOSTCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC0MDIN_PHYEMAC0MCLKIN_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC0MDIN_PHYEMAC0MCLKIN_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC0MDIN_PHYEMAC0MCLKIN_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC0MDIN_PHYEMAC0MCLKIN_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC0RXBUFERR_PHYEMAC0GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC0RXBUFERR_PHYEMAC0GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC0RXBUFERR_PHYEMAC0GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC0RXBUFERR_PHYEMAC0GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC0RXBUFSTATUS_PHYEMAC0GTXCLK_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0.0 ns);
        tsetup_PHYEMAC0RXBUFSTATUS_PHYEMAC0GTXCLK_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0.0 ns);
        thold_PHYEMAC0RXBUFSTATUS_PHYEMAC0GTXCLK_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0.0 ns);
        thold_PHYEMAC0RXBUFSTATUS_PHYEMAC0GTXCLK_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0.0 ns);
        tsetup_PHYEMAC0RXCHARISCOMMA_PHYEMAC0GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC0RXCHARISCOMMA_PHYEMAC0GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC0RXCHARISCOMMA_PHYEMAC0GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC0RXCHARISCOMMA_PHYEMAC0GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC0RXCHARISK_PHYEMAC0GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC0RXCHARISK_PHYEMAC0GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC0RXCHARISK_PHYEMAC0GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC0RXCHARISK_PHYEMAC0GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC0RXCHECKINGCRC_PHYEMAC0GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC0RXCHECKINGCRC_PHYEMAC0GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC0RXCHECKINGCRC_PHYEMAC0GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC0RXCHECKINGCRC_PHYEMAC0GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC0RXCLKCORCNT_PHYEMAC0GTXCLK_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0.0 ns);
        tsetup_PHYEMAC0RXCLKCORCNT_PHYEMAC0GTXCLK_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0.0 ns);
        thold_PHYEMAC0RXCLKCORCNT_PHYEMAC0GTXCLK_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0.0 ns);
        thold_PHYEMAC0RXCLKCORCNT_PHYEMAC0GTXCLK_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0.0 ns);
        tsetup_PHYEMAC0RXCOMMADET_PHYEMAC0GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC0RXCOMMADET_PHYEMAC0GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC0RXCOMMADET_PHYEMAC0GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC0RXCOMMADET_PHYEMAC0GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC0RXD_PHYEMAC0RXCLK_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        tsetup_PHYEMAC0RXD_PHYEMAC0RXCLK_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        thold_PHYEMAC0RXD_PHYEMAC0RXCLK_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        thold_PHYEMAC0RXD_PHYEMAC0RXCLK_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        tsetup_PHYEMAC0RXDISPERR_PHYEMAC0GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC0RXDISPERR_PHYEMAC0GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC0RXDISPERR_PHYEMAC0GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC0RXDISPERR_PHYEMAC0GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC0RXDV_PHYEMAC0RXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC0RXDV_PHYEMAC0RXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC0RXDV_PHYEMAC0RXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC0RXDV_PHYEMAC0RXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC0RXER_PHYEMAC0RXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC0RXER_PHYEMAC0RXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC0RXER_PHYEMAC0RXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC0RXER_PHYEMAC0RXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC0RXLOSSOFSYNC_PHYEMAC0GTXCLK_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0.0 ns);
        tsetup_PHYEMAC0RXLOSSOFSYNC_PHYEMAC0GTXCLK_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0.0 ns);
        thold_PHYEMAC0RXLOSSOFSYNC_PHYEMAC0GTXCLK_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0.0 ns);
        thold_PHYEMAC0RXLOSSOFSYNC_PHYEMAC0GTXCLK_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0.0 ns);
        tsetup_PHYEMAC0RXNOTINTABLE_PHYEMAC0GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC0RXNOTINTABLE_PHYEMAC0GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC0RXNOTINTABLE_PHYEMAC0GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC0RXNOTINTABLE_PHYEMAC0GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC0RXRUNDISP_PHYEMAC0GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC0RXRUNDISP_PHYEMAC0GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC0RXRUNDISP_PHYEMAC0GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC0RXRUNDISP_PHYEMAC0GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC0TXBUFERR_PHYEMAC0GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC0TXBUFERR_PHYEMAC0GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC0TXBUFERR_PHYEMAC0GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC0TXBUFERR_PHYEMAC0GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC1COL_PHYEMAC1RXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC1COL_PHYEMAC1RXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC1COL_PHYEMAC1RXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC1COL_PHYEMAC1RXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC1CRS_PHYEMAC1RXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC1CRS_PHYEMAC1RXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC1CRS_PHYEMAC1RXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC1CRS_PHYEMAC1RXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC1MDIN_HOSTCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC1MDIN_HOSTCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC1MDIN_HOSTCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC1MDIN_HOSTCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC1MDIN_PHYEMAC1MCLKIN_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC1MDIN_PHYEMAC1MCLKIN_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC1MDIN_PHYEMAC1MCLKIN_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC1MDIN_PHYEMAC1MCLKIN_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC1RXBUFERR_PHYEMAC1GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC1RXBUFERR_PHYEMAC1GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC1RXBUFERR_PHYEMAC1GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC1RXBUFERR_PHYEMAC1GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC1RXBUFSTATUS_PHYEMAC1GTXCLK_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0.0 ns);
        tsetup_PHYEMAC1RXBUFSTATUS_PHYEMAC1GTXCLK_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0.0 ns);
        thold_PHYEMAC1RXBUFSTATUS_PHYEMAC1GTXCLK_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0.0 ns);
        thold_PHYEMAC1RXBUFSTATUS_PHYEMAC1GTXCLK_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0.0 ns);
        tsetup_PHYEMAC1RXCHARISCOMMA_PHYEMAC1GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC1RXCHARISCOMMA_PHYEMAC1GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC1RXCHARISCOMMA_PHYEMAC1GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC1RXCHARISCOMMA_PHYEMAC1GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC1RXCHARISK_PHYEMAC1GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC1RXCHARISK_PHYEMAC1GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC1RXCHARISK_PHYEMAC1GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC1RXCHARISK_PHYEMAC1GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC1RXCHECKINGCRC_PHYEMAC1GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC1RXCHECKINGCRC_PHYEMAC1GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC1RXCHECKINGCRC_PHYEMAC1GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC1RXCHECKINGCRC_PHYEMAC1GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC1RXCLKCORCNT_PHYEMAC1GTXCLK_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0.0 ns);
        tsetup_PHYEMAC1RXCLKCORCNT_PHYEMAC1GTXCLK_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0.0 ns);
        thold_PHYEMAC1RXCLKCORCNT_PHYEMAC1GTXCLK_posedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0.0 ns);
        thold_PHYEMAC1RXCLKCORCNT_PHYEMAC1GTXCLK_negedge_posedge : VitalDelayArrayType(2 downto 0) := (others => 0.0 ns);
        tsetup_PHYEMAC1RXCOMMADET_PHYEMAC1GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC1RXCOMMADET_PHYEMAC1GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC1RXCOMMADET_PHYEMAC1GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC1RXCOMMADET_PHYEMAC1GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC1RXD_PHYEMAC1RXCLK_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        tsetup_PHYEMAC1RXD_PHYEMAC1RXCLK_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        thold_PHYEMAC1RXD_PHYEMAC1RXCLK_posedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        thold_PHYEMAC1RXD_PHYEMAC1RXCLK_negedge_posedge : VitalDelayArrayType(7 downto 0) := (others => 0.0 ns);
        tsetup_PHYEMAC1RXDISPERR_PHYEMAC1GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC1RXDISPERR_PHYEMAC1GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC1RXDISPERR_PHYEMAC1GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC1RXDISPERR_PHYEMAC1GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC1RXDV_PHYEMAC1RXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC1RXDV_PHYEMAC1RXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC1RXDV_PHYEMAC1RXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC1RXDV_PHYEMAC1RXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC1RXER_PHYEMAC1RXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC1RXER_PHYEMAC1RXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC1RXER_PHYEMAC1RXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC1RXER_PHYEMAC1RXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC1RXLOSSOFSYNC_PHYEMAC1GTXCLK_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0.0 ns);
        tsetup_PHYEMAC1RXLOSSOFSYNC_PHYEMAC1GTXCLK_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0.0 ns);
        thold_PHYEMAC1RXLOSSOFSYNC_PHYEMAC1GTXCLK_posedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0.0 ns);
        thold_PHYEMAC1RXLOSSOFSYNC_PHYEMAC1GTXCLK_negedge_posedge : VitalDelayArrayType(1 downto 0) := (others => 0.0 ns);
        tsetup_PHYEMAC1RXNOTINTABLE_PHYEMAC1GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC1RXNOTINTABLE_PHYEMAC1GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC1RXNOTINTABLE_PHYEMAC1GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC1RXNOTINTABLE_PHYEMAC1GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC1RXRUNDISP_PHYEMAC1GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC1RXRUNDISP_PHYEMAC1GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC1RXRUNDISP_PHYEMAC1GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC1RXRUNDISP_PHYEMAC1GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC1TXBUFERR_PHYEMAC1GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_PHYEMAC1TXBUFERR_PHYEMAC1GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC1TXBUFERR_PHYEMAC1GTXCLK_posedge_posedge : VitalDelayType := 0.0 ns;
        thold_PHYEMAC1TXBUFERR_PHYEMAC1GTXCLK_negedge_posedge : VitalDelayType := 0.0 ns;
        tsetup_TIEEMAC0CONFIGVEC_PHYEMAC0GTXCLK_posedge_posedge : VitalDelayArrayType(79 downto 0) := (others => 0.0 ns);
        tsetup_TIEEMAC0CONFIGVEC_PHYEMAC0GTXCLK_negedge_posedge : VitalDelayArrayType(79 downto 0) := (others => 0.0 ns);
        thold_TIEEMAC0CONFIGVEC_PHYEMAC0GTXCLK_posedge_posedge : VitalDelayArrayType(79 downto 0) := (others => 0.0 ns);
        thold_TIEEMAC0CONFIGVEC_PHYEMAC0GTXCLK_negedge_posedge : VitalDelayArrayType(79 downto 0) := (others => 0.0 ns);
        tsetup_TIEEMAC1CONFIGVEC_PHYEMAC1GTXCLK_posedge_posedge : VitalDelayArrayType(79 downto 0) := (others => 0.0 ns);
        tsetup_TIEEMAC1CONFIGVEC_PHYEMAC1GTXCLK_negedge_posedge : VitalDelayArrayType(79 downto 0) := (others => 0.0 ns);
        thold_TIEEMAC1CONFIGVEC_PHYEMAC1GTXCLK_posedge_posedge : VitalDelayArrayType(79 downto 0) := (others => 0.0 ns);
        thold_TIEEMAC1CONFIGVEC_PHYEMAC1GTXCLK_negedge_posedge : VitalDelayArrayType(79 downto 0) := (others => 0.0 ns);

--  Clock ticd

        ticd_PHYEMAC0GTXCLK : VitalDelayType := 0.000 ns;
        ticd_CLIENTEMAC0TXCLIENTCLKIN : VitalDelayType := 0.000 ns;
        ticd_PHYEMAC1GTXCLK : VitalDelayType := 0.000 ns;
        ticd_CLIENTEMAC1TXCLIENTCLKIN : VitalDelayType := 0.000 ns;
        ticd_HOSTCLK : VitalDelayType := 0.000 ns;
        ticd_PHYEMAC0MCLKIN : VitalDelayType := 0.000 ns;
        ticd_PHYEMAC1MCLKIN : VitalDelayType := 0.000 ns;                        
        ticd_PHYEMAC0RXCLK : VitalDelayType := 0.000 ns;
        ticd_PHYEMAC1RXCLK : VitalDelayType := 0.000 ns;

-- Clock-to-pin tisd 
        tisd_CLIENTEMAC0DCMLOCKED : VitalDelayType := 0.000 ns;
        tisd_CLIENTEMAC0PAUSEREQ : VitalDelayType := 0.000 ns;
        tisd_CLIENTEMAC0PAUSEVAL : VitalDelayArrayType(15 downto 0) := (others => 0.000 ns);
        tisd_CLIENTEMAC0TXD : VitalDelayArrayType(15 downto 0) := (others => 0.000 ns);
        tisd_CLIENTEMAC0TXDVLD : VitalDelayType := 0.000 ns;
        tisd_CLIENTEMAC0TXDVLDMSW : VitalDelayType := 0.000 ns;
        tisd_CLIENTEMAC0TXFIRSTBYTE : VitalDelayType := 0.000 ns;
        tisd_CLIENTEMAC0TXIFGDELAY : VitalDelayArrayType(7 downto 0) := (others => 0.000 ns);
        tisd_CLIENTEMAC0TXUNDERRUN : VitalDelayType := 0.000 ns;
        tisd_CLIENTEMAC1DCMLOCKED : VitalDelayType := 0.000 ns;
        tisd_CLIENTEMAC1PAUSEREQ : VitalDelayType := 0.000 ns;
        tisd_CLIENTEMAC1PAUSEVAL : VitalDelayArrayType(15 downto 0) := (others => 0.000 ns);
        tisd_CLIENTEMAC1TXD : VitalDelayArrayType(15 downto 0) := (others => 0.000 ns);
        tisd_CLIENTEMAC1TXDVLD : VitalDelayType := 0.000 ns;
        tisd_CLIENTEMAC1TXDVLDMSW : VitalDelayType := 0.000 ns;
        tisd_CLIENTEMAC1TXFIRSTBYTE : VitalDelayType := 0.000 ns;
        tisd_CLIENTEMAC1TXIFGDELAY : VitalDelayArrayType(7 downto 0) := (others => 0.000 ns);
        tisd_CLIENTEMAC1TXUNDERRUN : VitalDelayType := 0.000 ns;
        tisd_HOSTADDR : VitalDelayArrayType(9 downto 0) := (others => 0.000 ns);
        tisd_HOSTEMAC1SEL : VitalDelayType := 0.000 ns;
        tisd_HOSTMIIMSEL : VitalDelayType := 0.000 ns;
        tisd_HOSTOPCODE : VitalDelayArrayType(1 downto 0) := (others => 0.000 ns);
        tisd_HOSTREQ : VitalDelayType := 0.000 ns;
        tisd_HOSTWRDATA : VitalDelayArrayType(31 downto 0) := (others => 0.000 ns);
        tisd_PHYEMAC0COL : VitalDelayType := 0.000 ns;
        tisd_PHYEMAC0CRS : VitalDelayType := 0.000 ns;
        tisd_PHYEMAC0MDIN : VitalDelayType := 0.000 ns;
        tisd_PHYEMAC0RXBUFERR : VitalDelayType := 0.000 ns;
        tisd_PHYEMAC0RXBUFSTATUS : VitalDelayArrayType(1 downto 0) := (others => 0.000 ns);
        tisd_PHYEMAC0RXCHARISCOMMA : VitalDelayType := 0.000 ns;
        tisd_PHYEMAC0RXCHARISK : VitalDelayType := 0.000 ns;
        tisd_PHYEMAC0RXCHECKINGCRC : VitalDelayType := 0.000 ns;
        tisd_PHYEMAC0RXCLKCORCNT : VitalDelayArrayType(2 downto 0) := (others => 0.000 ns);
        tisd_PHYEMAC0RXCOMMADET : VitalDelayType := 0.000 ns;
        tisd_PHYEMAC0RXD : VitalDelayArrayType(7 downto 0) := (others => 0.000 ns);
        tisd_PHYEMAC0RXDISPERR : VitalDelayType := 0.000 ns;
        tisd_PHYEMAC0RXDV : VitalDelayType := 0.000 ns;
        tisd_PHYEMAC0RXER : VitalDelayType := 0.000 ns;
        tisd_PHYEMAC0RXLOSSOFSYNC : VitalDelayArrayType(1 downto 0) := (others => 0.000 ns);
        tisd_PHYEMAC0RXNOTINTABLE : VitalDelayType := 0.000 ns;
        tisd_PHYEMAC0RXRUNDISP : VitalDelayType := 0.000 ns;
        tisd_PHYEMAC0TXBUFERR : VitalDelayType := 0.000 ns;
        tisd_PHYEMAC1COL : VitalDelayType := 0.000 ns;
        tisd_PHYEMAC1CRS : VitalDelayType := 0.000 ns;
        tisd_PHYEMAC1MDIN : VitalDelayType := 0.000 ns;
        tisd_PHYEMAC1RXBUFERR : VitalDelayType := 0.000 ns;
        tisd_PHYEMAC1RXBUFSTATUS : VitalDelayArrayType(1 downto 0) := (others => 0.000 ns);
        tisd_PHYEMAC1RXCHARISCOMMA : VitalDelayType := 0.000 ns;
        tisd_PHYEMAC1RXCHARISK : VitalDelayType := 0.000 ns;
        tisd_PHYEMAC1RXCHECKINGCRC : VitalDelayType := 0.000 ns;
        tisd_PHYEMAC1RXCLKCORCNT : VitalDelayArrayType(2 downto 0) := (others => 0.000 ns);
        tisd_PHYEMAC1RXCOMMADET : VitalDelayType := 0.000 ns;
        tisd_PHYEMAC1RXD : VitalDelayArrayType(7 downto 0) := (others => 0.000 ns);
        tisd_PHYEMAC1RXDISPERR : VitalDelayType := 0.000 ns;
        tisd_PHYEMAC1RXDV : VitalDelayType := 0.000 ns;
        tisd_PHYEMAC1RXER : VitalDelayType := 0.000 ns;
        tisd_PHYEMAC1RXLOSSOFSYNC : VitalDelayArrayType(1 downto 0) := (others => 0.000 ns);
        tisd_PHYEMAC1RXNOTINTABLE : VitalDelayType := 0.000 ns;
        tisd_PHYEMAC1RXRUNDISP : VitalDelayType := 0.000 ns;
        tisd_PHYEMAC1TXBUFERR : VitalDelayType := 0.000 ns;
        tisd_TIEEMAC0CONFIGVEC : VitalDelayArrayType(79 downto 0) := (others => 0.000 ns);
        tisd_TIEEMAC1CONFIGVEC : VitalDelayArrayType(79 downto 0) := (others => 0.000 ns)

  );

port (
		DCRHOSTDONEIR : out std_ulogic;
		EMAC0CLIENTANINTERRUPT : out std_ulogic;
		EMAC0CLIENTRXBADFRAME : out std_ulogic;
		EMAC0CLIENTRXCLIENTCLKOUT : out std_ulogic;
		EMAC0CLIENTRXD : out std_logic_vector(15 downto 0);
		EMAC0CLIENTRXDVLD : out std_ulogic;
		EMAC0CLIENTRXDVLDMSW : out std_ulogic;
		EMAC0CLIENTRXDVREG6 : out std_ulogic;
		EMAC0CLIENTRXFRAMEDROP : out std_ulogic;
		EMAC0CLIENTRXGOODFRAME : out std_ulogic;
		EMAC0CLIENTRXSTATS : out std_logic_vector(6 downto 0);
		EMAC0CLIENTRXSTATSBYTEVLD : out std_ulogic;
		EMAC0CLIENTRXSTATSVLD : out std_ulogic;
		EMAC0CLIENTTXACK : out std_ulogic;
		EMAC0CLIENTTXCLIENTCLKOUT : out std_ulogic;
		EMAC0CLIENTTXCOLLISION : out std_ulogic;
		EMAC0CLIENTTXGMIIMIICLKOUT : out std_ulogic;
		EMAC0CLIENTTXRETRANSMIT : out std_ulogic;
		EMAC0CLIENTTXSTATS : out std_ulogic;
		EMAC0CLIENTTXSTATSBYTEVLD : out std_ulogic;
		EMAC0CLIENTTXSTATSVLD : out std_ulogic;
		EMAC0PHYENCOMMAALIGN : out std_ulogic;
		EMAC0PHYLOOPBACKMSB : out std_ulogic;
		EMAC0PHYMCLKOUT : out std_ulogic;
		EMAC0PHYMDOUT : out std_ulogic;
		EMAC0PHYMDTRI : out std_ulogic;
		EMAC0PHYMGTRXRESET : out std_ulogic;
		EMAC0PHYMGTTXRESET : out std_ulogic;
		EMAC0PHYPOWERDOWN : out std_ulogic;
		EMAC0PHYSYNCACQSTATUS : out std_ulogic;
		EMAC0PHYTXCHARDISPMODE : out std_ulogic;
		EMAC0PHYTXCHARDISPVAL : out std_ulogic;
		EMAC0PHYTXCHARISK : out std_ulogic;
		EMAC0PHYTXCLK : out std_ulogic;
		EMAC0PHYTXD : out std_logic_vector(7 downto 0);
		EMAC0PHYTXEN : out std_ulogic;
		EMAC0PHYTXER : out std_ulogic;
		EMAC1CLIENTANINTERRUPT : out std_ulogic;
		EMAC1CLIENTRXBADFRAME : out std_ulogic;
		EMAC1CLIENTRXCLIENTCLKOUT : out std_ulogic;
		EMAC1CLIENTRXD : out std_logic_vector(15 downto 0);
		EMAC1CLIENTRXDVLD : out std_ulogic;
		EMAC1CLIENTRXDVLDMSW : out std_ulogic;
		EMAC1CLIENTRXDVREG6 : out std_ulogic;
		EMAC1CLIENTRXFRAMEDROP : out std_ulogic;
		EMAC1CLIENTRXGOODFRAME : out std_ulogic;
		EMAC1CLIENTRXSTATS : out std_logic_vector(6 downto 0);
		EMAC1CLIENTRXSTATSBYTEVLD : out std_ulogic;
		EMAC1CLIENTRXSTATSVLD : out std_ulogic;
		EMAC1CLIENTTXACK : out std_ulogic;
		EMAC1CLIENTTXCLIENTCLKOUT : out std_ulogic;
		EMAC1CLIENTTXCOLLISION : out std_ulogic;
		EMAC1CLIENTTXGMIIMIICLKOUT : out std_ulogic;
		EMAC1CLIENTTXRETRANSMIT : out std_ulogic;
		EMAC1CLIENTTXSTATS : out std_ulogic;
		EMAC1CLIENTTXSTATSBYTEVLD : out std_ulogic;
		EMAC1CLIENTTXSTATSVLD : out std_ulogic;
		EMAC1PHYENCOMMAALIGN : out std_ulogic;
		EMAC1PHYLOOPBACKMSB : out std_ulogic;
		EMAC1PHYMCLKOUT : out std_ulogic;
		EMAC1PHYMDOUT : out std_ulogic;
		EMAC1PHYMDTRI : out std_ulogic;
		EMAC1PHYMGTRXRESET : out std_ulogic;
		EMAC1PHYMGTTXRESET : out std_ulogic;
		EMAC1PHYPOWERDOWN : out std_ulogic;
		EMAC1PHYSYNCACQSTATUS : out std_ulogic;
		EMAC1PHYTXCHARDISPMODE : out std_ulogic;
		EMAC1PHYTXCHARDISPVAL : out std_ulogic;
		EMAC1PHYTXCHARISK : out std_ulogic;
		EMAC1PHYTXCLK : out std_ulogic;
		EMAC1PHYTXD : out std_logic_vector(7 downto 0);
		EMAC1PHYTXEN : out std_ulogic;
		EMAC1PHYTXER : out std_ulogic;
		EMACDCRACK : out std_ulogic;
		EMACDCRDBUS : out std_logic_vector(0 to 31);
		HOSTMIIMRDY : out std_ulogic;
		HOSTRDDATA : out std_logic_vector(31 downto 0);

		CLIENTEMAC0DCMLOCKED : in std_ulogic;
		CLIENTEMAC0PAUSEREQ : in std_ulogic;
		CLIENTEMAC0PAUSEVAL : in std_logic_vector(15 downto 0);
		CLIENTEMAC0RXCLIENTCLKIN : in std_ulogic;
		CLIENTEMAC0TXCLIENTCLKIN : in std_ulogic;
		CLIENTEMAC0TXD : in std_logic_vector(15 downto 0);
		CLIENTEMAC0TXDVLD : in std_ulogic;
		CLIENTEMAC0TXDVLDMSW : in std_ulogic;
		CLIENTEMAC0TXFIRSTBYTE : in std_ulogic;
		CLIENTEMAC0TXGMIIMIICLKIN : in std_ulogic;
		CLIENTEMAC0TXIFGDELAY : in std_logic_vector(7 downto 0);
		CLIENTEMAC0TXUNDERRUN : in std_ulogic;
		CLIENTEMAC1DCMLOCKED : in std_ulogic;
		CLIENTEMAC1PAUSEREQ : in std_ulogic;
		CLIENTEMAC1PAUSEVAL : in std_logic_vector(15 downto 0);
		CLIENTEMAC1RXCLIENTCLKIN : in std_ulogic;
		CLIENTEMAC1TXCLIENTCLKIN : in std_ulogic;
		CLIENTEMAC1TXD : in std_logic_vector(15 downto 0);
		CLIENTEMAC1TXDVLD : in std_ulogic;
		CLIENTEMAC1TXDVLDMSW : in std_ulogic;
		CLIENTEMAC1TXFIRSTBYTE : in std_ulogic;
		CLIENTEMAC1TXGMIIMIICLKIN : in std_ulogic;
		CLIENTEMAC1TXIFGDELAY : in std_logic_vector(7 downto 0);
		CLIENTEMAC1TXUNDERRUN : in std_ulogic;
		DCREMACABUS : in std_logic_vector(8 to 9);
		DCREMACCLK : in std_ulogic;
		DCREMACDBUS : in std_logic_vector(0 to 31);
		DCREMACENABLE : in std_ulogic;
		DCREMACREAD : in std_ulogic;
		DCREMACWRITE : in std_ulogic;
		HOSTADDR : in std_logic_vector(9 downto 0);
		HOSTCLK : in std_ulogic;
		HOSTEMAC1SEL : in std_ulogic;
		HOSTMIIMSEL : in std_ulogic;
		HOSTOPCODE : in std_logic_vector(1 downto 0);
		HOSTREQ : in std_ulogic;
		HOSTWRDATA : in std_logic_vector(31 downto 0);
		PHYEMAC0COL : in std_ulogic;
		PHYEMAC0CRS : in std_ulogic;
		PHYEMAC0GTXCLK : in std_ulogic;
		PHYEMAC0MCLKIN : in std_ulogic;
		PHYEMAC0MDIN : in std_ulogic;
		PHYEMAC0MIITXCLK : in std_ulogic;
		PHYEMAC0PHYAD : in std_logic_vector(4 downto 0);
		PHYEMAC0RXBUFERR : in std_ulogic;
		PHYEMAC0RXBUFSTATUS : in std_logic_vector(1 downto 0);
		PHYEMAC0RXCHARISCOMMA : in std_ulogic;
		PHYEMAC0RXCHARISK : in std_ulogic;
		PHYEMAC0RXCHECKINGCRC : in std_ulogic;
		PHYEMAC0RXCLK : in std_ulogic;
		PHYEMAC0RXCLKCORCNT : in std_logic_vector(2 downto 0);
		PHYEMAC0RXCOMMADET : in std_ulogic;
		PHYEMAC0RXD : in std_logic_vector(7 downto 0);
		PHYEMAC0RXDISPERR : in std_ulogic;
		PHYEMAC0RXDV : in std_ulogic;
		PHYEMAC0RXER : in std_ulogic;
		PHYEMAC0RXLOSSOFSYNC : in std_logic_vector(1 downto 0);
		PHYEMAC0RXNOTINTABLE : in std_ulogic;
		PHYEMAC0RXRUNDISP : in std_ulogic;
		PHYEMAC0SIGNALDET : in std_ulogic;
		PHYEMAC0TXBUFERR : in std_ulogic;
		PHYEMAC1COL : in std_ulogic;
		PHYEMAC1CRS : in std_ulogic;
		PHYEMAC1GTXCLK : in std_ulogic;
		PHYEMAC1MCLKIN : in std_ulogic;
		PHYEMAC1MDIN : in std_ulogic;
		PHYEMAC1MIITXCLK : in std_ulogic;
		PHYEMAC1PHYAD : in std_logic_vector(4 downto 0);
		PHYEMAC1RXBUFERR : in std_ulogic;
		PHYEMAC1RXBUFSTATUS : in std_logic_vector(1 downto 0);
		PHYEMAC1RXCHARISCOMMA : in std_ulogic;
		PHYEMAC1RXCHARISK : in std_ulogic;
		PHYEMAC1RXCHECKINGCRC : in std_ulogic;
		PHYEMAC1RXCLK : in std_ulogic;
		PHYEMAC1RXCLKCORCNT : in std_logic_vector(2 downto 0);
		PHYEMAC1RXCOMMADET : in std_ulogic;
		PHYEMAC1RXD : in std_logic_vector(7 downto 0);
		PHYEMAC1RXDISPERR : in std_ulogic;
		PHYEMAC1RXDV : in std_ulogic;
		PHYEMAC1RXER : in std_ulogic;
		PHYEMAC1RXLOSSOFSYNC : in std_logic_vector(1 downto 0);
		PHYEMAC1RXNOTINTABLE : in std_ulogic;
		PHYEMAC1RXRUNDISP : in std_ulogic;
		PHYEMAC1SIGNALDET : in std_ulogic;
		PHYEMAC1TXBUFERR : in std_ulogic;
		RESET : in std_ulogic;
		TIEEMAC0CONFIGVEC : in std_logic_vector(79 downto 0);
		TIEEMAC0UNICASTADDR : in std_logic_vector(47 downto 0);
		TIEEMAC1CONFIGVEC : in std_logic_vector(79 downto 0);
		TIEEMAC1UNICASTADDR : in std_logic_vector(47 downto 0)
     );
end X_EMAC;

-- Architecture body --

architecture X_EMAC_V of X_EMAC is

  component EMAC_SWIFT
    port (
      DCRHOSTDONEIR        : out std_ulogic;
      EMAC0CLIENTANINTERRUPT : out std_ulogic;
      EMAC0CLIENTRXBADFRAME : out std_ulogic;
      EMAC0CLIENTRXCLIENTCLKOUT : out std_ulogic;
      EMAC0CLIENTRXD       : out std_logic_vector(15 downto 0);
      EMAC0CLIENTRXDVLD    : out std_ulogic;
      EMAC0CLIENTRXDVLDMSW : out std_ulogic;
      EMAC0CLIENTRXDVREG6  : out std_ulogic;
      EMAC0CLIENTRXFRAMEDROP : out std_ulogic;
      EMAC0CLIENTRXGOODFRAME : out std_ulogic;
      EMAC0CLIENTRXSTATS   : out std_logic_vector(6 downto 0);
      EMAC0CLIENTRXSTATSBYTEVLD : out std_ulogic;
      EMAC0CLIENTRXSTATSVLD : out std_ulogic;
      EMAC0CLIENTTXACK     : out std_ulogic;
      EMAC0CLIENTTXCLIENTCLKOUT : out std_ulogic;
      EMAC0CLIENTTXCOLLISION : out std_ulogic;
      EMAC0CLIENTTXGMIIMIICLKOUT : out std_ulogic;
      EMAC0CLIENTTXRETRANSMIT : out std_ulogic;
      EMAC0CLIENTTXSTATS   : out std_ulogic;
      EMAC0CLIENTTXSTATSBYTEVLD : out std_ulogic;
      EMAC0CLIENTTXSTATSVLD : out std_ulogic;
      EMAC0PHYENCOMMAALIGN : out std_ulogic;
      EMAC0PHYLOOPBACKMSB  : out std_ulogic;
      EMAC0PHYMCLKOUT      : out std_ulogic;
      EMAC0PHYMDOUT        : out std_ulogic;
      EMAC0PHYMDTRI        : out std_ulogic;
      EMAC0PHYMGTRXRESET   : out std_ulogic;
      EMAC0PHYMGTTXRESET   : out std_ulogic;
      EMAC0PHYPOWERDOWN    : out std_ulogic;
      EMAC0PHYSYNCACQSTATUS : out std_ulogic;
      EMAC0PHYTXCHARDISPMODE : out std_ulogic;
      EMAC0PHYTXCHARDISPVAL : out std_ulogic;
      EMAC0PHYTXCHARISK    : out std_ulogic;
      EMAC0PHYTXCLK        : out std_ulogic;
      EMAC0PHYTXD          : out std_logic_vector(7 downto 0);
      EMAC0PHYTXEN         : out std_ulogic;
      EMAC0PHYTXER         : out std_ulogic;
      EMAC1CLIENTANINTERRUPT : out std_ulogic;
      EMAC1CLIENTRXBADFRAME : out std_ulogic;
      EMAC1CLIENTRXCLIENTCLKOUT : out std_ulogic;
      EMAC1CLIENTRXD       : out std_logic_vector(15 downto 0);
      EMAC1CLIENTRXDVLD    : out std_ulogic;
      EMAC1CLIENTRXDVLDMSW : out std_ulogic;
      EMAC1CLIENTRXDVREG6  : out std_ulogic;
      EMAC1CLIENTRXFRAMEDROP : out std_ulogic;
      EMAC1CLIENTRXGOODFRAME : out std_ulogic;
      EMAC1CLIENTRXSTATS   : out std_logic_vector(6 downto 0);
      EMAC1CLIENTRXSTATSBYTEVLD : out std_ulogic;
      EMAC1CLIENTRXSTATSVLD : out std_ulogic;
      EMAC1CLIENTTXACK     : out std_ulogic;
      EMAC1CLIENTTXCLIENTCLKOUT : out std_ulogic;
      EMAC1CLIENTTXCOLLISION : out std_ulogic;
      EMAC1CLIENTTXGMIIMIICLKOUT : out std_ulogic;
      EMAC1CLIENTTXRETRANSMIT : out std_ulogic;
      EMAC1CLIENTTXSTATS   : out std_ulogic;
      EMAC1CLIENTTXSTATSBYTEVLD : out std_ulogic;
      EMAC1CLIENTTXSTATSVLD : out std_ulogic;
      EMAC1PHYENCOMMAALIGN : out std_ulogic;
      EMAC1PHYLOOPBACKMSB  : out std_ulogic;
      EMAC1PHYMCLKOUT      : out std_ulogic;
      EMAC1PHYMDOUT        : out std_ulogic;
      EMAC1PHYMDTRI        : out std_ulogic;
      EMAC1PHYMGTRXRESET   : out std_ulogic;
      EMAC1PHYMGTTXRESET   : out std_ulogic;
      EMAC1PHYPOWERDOWN    : out std_ulogic;
      EMAC1PHYSYNCACQSTATUS : out std_ulogic;
      EMAC1PHYTXCHARDISPMODE : out std_ulogic;
      EMAC1PHYTXCHARDISPVAL : out std_ulogic;
      EMAC1PHYTXCHARISK    : out std_ulogic;
      EMAC1PHYTXCLK        : out std_ulogic;
      EMAC1PHYTXD          : out std_logic_vector(7 downto 0);
      EMAC1PHYTXEN         : out std_ulogic;
      EMAC1PHYTXER         : out std_ulogic;
      EMACDCRACK           : out std_ulogic;
      EMACDCRDBUS          : out std_logic_vector(0 to 31);
      HOSTMIIMRDY          : out std_ulogic;
      HOSTRDDATA           : out std_logic_vector(31 downto 0);

      CLIENTEMAC0DCMLOCKED : in std_ulogic;
      CLIENTEMAC0PAUSEREQ  : in std_ulogic;
      CLIENTEMAC0PAUSEVAL  : in std_logic_vector(15 downto 0);
      CLIENTEMAC0RXCLIENTCLKIN : in std_ulogic;
      CLIENTEMAC0TXCLIENTCLKIN : in std_ulogic;
      CLIENTEMAC0TXD       : in std_logic_vector(15 downto 0);
      CLIENTEMAC0TXDVLD    : in std_ulogic;
      CLIENTEMAC0TXDVLDMSW : in std_ulogic;
      CLIENTEMAC0TXFIRSTBYTE : in std_ulogic;
      CLIENTEMAC0TXGMIIMIICLKIN : in std_ulogic;
      CLIENTEMAC0TXIFGDELAY : in std_logic_vector(7 downto 0);
      CLIENTEMAC0TXUNDERRUN : in std_ulogic;
      CLIENTEMAC1DCMLOCKED : in std_ulogic;
      CLIENTEMAC1PAUSEREQ  : in std_ulogic;
      CLIENTEMAC1PAUSEVAL  : in std_logic_vector(15 downto 0);
      CLIENTEMAC1RXCLIENTCLKIN : in std_ulogic;
      CLIENTEMAC1TXCLIENTCLKIN : in std_ulogic;
      CLIENTEMAC1TXD       : in std_logic_vector(15 downto 0);
      CLIENTEMAC1TXDVLD    : in std_ulogic;
      CLIENTEMAC1TXDVLDMSW : in std_ulogic;
      CLIENTEMAC1TXFIRSTBYTE : in std_ulogic;
      CLIENTEMAC1TXGMIIMIICLKIN : in std_ulogic;
      CLIENTEMAC1TXIFGDELAY : in std_logic_vector(7 downto 0);
      CLIENTEMAC1TXUNDERRUN : in std_ulogic;
      DCREMACABUS          : in std_logic_vector(8 to 9);
      DCREMACCLK           : in std_ulogic;
      DCREMACDBUS          : in std_logic_vector(0 to 31);
      DCREMACENABLE        : in std_ulogic;
      DCREMACREAD          : in std_ulogic;
      DCREMACWRITE         : in std_ulogic;
      HOSTADDR             : in std_logic_vector(9 downto 0);
      HOSTCLK              : in std_ulogic;
      HOSTEMAC1SEL         : in std_ulogic;
      HOSTMIIMSEL          : in std_ulogic;
      HOSTOPCODE           : in std_logic_vector(1 downto 0);
      HOSTREQ              : in std_ulogic;
      HOSTWRDATA           : in std_logic_vector(31 downto 0);
      PHYEMAC0COL          : in std_ulogic;
      PHYEMAC0CRS          : in std_ulogic;
      PHYEMAC0GTXCLK       : in std_ulogic;
      PHYEMAC0MCLKIN       : in std_ulogic;
      PHYEMAC0MDIN         : in std_ulogic;
      PHYEMAC0MIITXCLK     : in std_ulogic;
      PHYEMAC0PHYAD        : in std_logic_vector(4 downto 0);
      PHYEMAC0RXBUFERR     : in std_ulogic;
      PHYEMAC0RXBUFSTATUS  : in std_logic_vector(1 downto 0);
      PHYEMAC0RXCHARISCOMMA : in std_ulogic;
      PHYEMAC0RXCHARISK    : in std_ulogic;
      PHYEMAC0RXCHECKINGCRC : in std_ulogic;
      PHYEMAC0RXCLK        : in std_ulogic;
      PHYEMAC0RXCLKCORCNT  : in std_logic_vector(2 downto 0);
      PHYEMAC0RXCOMMADET   : in std_ulogic;
      PHYEMAC0RXD          : in std_logic_vector(7 downto 0);
      PHYEMAC0RXDISPERR    : in std_ulogic;
      PHYEMAC0RXDV         : in std_ulogic;
      PHYEMAC0RXER         : in std_ulogic;
      PHYEMAC0RXLOSSOFSYNC : in std_logic_vector(1 downto 0);
      PHYEMAC0RXNOTINTABLE : in std_ulogic;
      PHYEMAC0RXRUNDISP    : in std_ulogic;
      PHYEMAC0SIGNALDET    : in std_ulogic;
      PHYEMAC0TXBUFERR     : in std_ulogic;
      PHYEMAC1COL          : in std_ulogic;
      PHYEMAC1CRS          : in std_ulogic;
      PHYEMAC1GTXCLK       : in std_ulogic;
      PHYEMAC1MCLKIN       : in std_ulogic;
      PHYEMAC1MDIN         : in std_ulogic;
      PHYEMAC1MIITXCLK     : in std_ulogic;
      PHYEMAC1PHYAD        : in std_logic_vector(4 downto 0);
      PHYEMAC1RXBUFERR     : in std_ulogic;
      PHYEMAC1RXBUFSTATUS  : in std_logic_vector(1 downto 0);
      PHYEMAC1RXCHARISCOMMA : in std_ulogic;
      PHYEMAC1RXCHARISK    : in std_ulogic;
      PHYEMAC1RXCHECKINGCRC : in std_ulogic;
      PHYEMAC1RXCLK        : in std_ulogic;
      PHYEMAC1RXCLKCORCNT  : in std_logic_vector(2 downto 0);
      PHYEMAC1RXCOMMADET   : in std_ulogic;
      PHYEMAC1RXD          : in std_logic_vector(7 downto 0);
      PHYEMAC1RXDISPERR    : in std_ulogic;
      PHYEMAC1RXDV         : in std_ulogic;
      PHYEMAC1RXER         : in std_ulogic;
      PHYEMAC1RXLOSSOFSYNC : in std_logic_vector(1 downto 0);
      PHYEMAC1RXNOTINTABLE : in std_ulogic;
      PHYEMAC1RXRUNDISP    : in std_ulogic;
      PHYEMAC1SIGNALDET    : in std_ulogic;
      PHYEMAC1TXBUFERR     : in std_ulogic;
      RESET                : in std_ulogic;
      TIEEMAC0CONFIGVEC    : in std_logic_vector(79 downto 0);
      TIEEMAC0UNICASTADDR  : in std_logic_vector(47 downto 0);
      TIEEMAC1CONFIGVEC    : in std_logic_vector(79 downto 0);
      TIEEMAC1UNICASTADDR  : in std_logic_vector(47 downto 0)

    );
  end component;

   -- CR 455025 -- Delay wrapper for 16-bit client mode
        signal PHYEMAC0MIITXCLK_delay : std_ulogic;
        signal CLIENTEMAC0TXD_delay : std_logic_vector(15 downto 0);
        signal CLIENTEMAC0TXDVLD_delay : std_ulogic;
        signal CLIENTEMAC0TXDVLDMSW_delay : std_ulogic;
        signal PHYEMAC0MIITXCLK_skewed : std_ulogic;
        signal CLIENTEMAC0TXD_client16_delay : std_logic_vector(15 downto 0);
        signal CLIENTEMAC0TXDVLD_client16_delay : std_ulogic;
        signal CLIENTEMAC0TXDVLDMSW_client16_delay : std_ulogic;

        signal PHYEMAC1MIITXCLK_delay : std_ulogic;
        signal CLIENTEMAC1TXD_delay : std_logic_vector(15 downto 0);
        signal CLIENTEMAC1TXDVLD_delay : std_ulogic;
        signal CLIENTEMAC1TXDVLDMSW_delay : std_ulogic;
        signal PHYEMAC1MIITXCLK_skewed : std_ulogic;
        signal CLIENTEMAC1TXD_client16_delay : std_logic_vector(15 downto 0);
        signal CLIENTEMAC1TXDVLD_client16_delay : std_ulogic;
        signal CLIENTEMAC1TXDVLDMSW_client16_delay : std_ulogic;

        constant client_in_delay : time := 125 ps;
        constant miitxclk_delay : time := 125 ps; 
        signal dcremacclk_delay : std_ulogic;
-- Attribute-to-Cell mapping signals

-- Input/Output Pin signals

        signal   GSR_ipd  :  std_ulogic;
        signal   CLIENTEMAC0DCMLOCKED_ipd  :  std_ulogic;
        signal   CLIENTEMAC0PAUSEREQ_ipd  :  std_ulogic;
        signal   CLIENTEMAC0PAUSEVAL_ipd  :  std_logic_vector(15 downto 0);
        signal   CLIENTEMAC0RXCLIENTCLKIN_ipd  :  std_ulogic;
        signal   CLIENTEMAC0TXCLIENTCLKIN_ipd  :  std_ulogic;
        signal   CLIENTEMAC0TXD_ipd  :  std_logic_vector(15 downto 0);
        signal   CLIENTEMAC0TXDVLD_ipd  :  std_ulogic;
        signal   CLIENTEMAC0TXDVLDMSW_ipd  :  std_ulogic;
        signal   CLIENTEMAC0TXFIRSTBYTE_ipd  :  std_ulogic;
        signal   CLIENTEMAC0TXGMIIMIICLKIN_ipd  :  std_ulogic;
        signal   CLIENTEMAC0TXIFGDELAY_ipd  :  std_logic_vector(7 downto 0);
        signal   CLIENTEMAC0TXUNDERRUN_ipd  :  std_ulogic;
        signal   CLIENTEMAC1DCMLOCKED_ipd  :  std_ulogic;
        signal   CLIENTEMAC1PAUSEREQ_ipd  :  std_ulogic;
        signal   CLIENTEMAC1PAUSEVAL_ipd  :  std_logic_vector(15 downto 0);
        signal   CLIENTEMAC1RXCLIENTCLKIN_ipd  :  std_ulogic;
        signal   CLIENTEMAC1TXCLIENTCLKIN_ipd  :  std_ulogic;
        signal   CLIENTEMAC1TXD_ipd  :  std_logic_vector(15 downto 0);
        signal   CLIENTEMAC1TXDVLD_ipd  :  std_ulogic;
        signal   CLIENTEMAC1TXDVLDMSW_ipd  :  std_ulogic;
        signal   CLIENTEMAC1TXFIRSTBYTE_ipd  :  std_ulogic;
        signal   CLIENTEMAC1TXGMIIMIICLKIN_ipd  :  std_ulogic;
        signal   CLIENTEMAC1TXIFGDELAY_ipd  :  std_logic_vector(7 downto 0);
        signal   CLIENTEMAC1TXUNDERRUN_ipd  :  std_ulogic;
        signal   DCREMACENABLE_ipd  :  std_ulogic;
        signal   HOSTADDR_ipd  :  std_logic_vector(9 downto 0);
        signal   HOSTCLK_ipd  :  std_ulogic;
        signal   HOSTEMAC1SEL_ipd  :  std_ulogic;
        signal   HOSTMIIMSEL_ipd  :  std_ulogic;
        signal   HOSTOPCODE_ipd  :  std_logic_vector(1 downto 0);
        signal   HOSTREQ_ipd  :  std_ulogic;
        signal   HOSTWRDATA_ipd  :  std_logic_vector(31 downto 0);
        signal   PHYEMAC0COL_ipd  :  std_ulogic;
        signal   PHYEMAC0CRS_ipd  :  std_ulogic;
        signal   PHYEMAC0GTXCLK_ipd  :  std_ulogic;
        signal   PHYEMAC0MCLKIN_ipd  :  std_ulogic;
        signal   PHYEMAC0MDIN_ipd  :  std_ulogic;
        signal   PHYEMAC0MIITXCLK_ipd  :  std_ulogic;
        signal   PHYEMAC0PHYAD_ipd  :  std_logic_vector(4 downto 0);
        signal   PHYEMAC0RXBUFERR_ipd  :  std_ulogic;
        signal   PHYEMAC0RXBUFSTATUS_ipd  :  std_logic_vector(1 downto 0);
        signal   PHYEMAC0RXCHARISCOMMA_ipd  :  std_ulogic;
        signal   PHYEMAC0RXCHARISK_ipd  :  std_ulogic;
        signal   PHYEMAC0RXCHECKINGCRC_ipd  :  std_ulogic;
        signal   PHYEMAC0RXCLK_ipd  :  std_ulogic;
        signal   PHYEMAC0RXCLKCORCNT_ipd  :  std_logic_vector(2 downto 0);
        signal   PHYEMAC0RXCOMMADET_ipd  :  std_ulogic;
        signal   PHYEMAC0RXD_ipd  :  std_logic_vector(7 downto 0);
        signal   PHYEMAC0RXDISPERR_ipd  :  std_ulogic;
        signal   PHYEMAC0RXDV_ipd  :  std_ulogic;
        signal   PHYEMAC0RXER_ipd  :  std_ulogic;
        signal   PHYEMAC0RXLOSSOFSYNC_ipd  :  std_logic_vector(1 downto 0);
        signal   PHYEMAC0RXNOTINTABLE_ipd  :  std_ulogic;
        signal   PHYEMAC0RXRUNDISP_ipd  :  std_ulogic;
        signal   PHYEMAC0SIGNALDET_ipd  :  std_ulogic;
        signal   PHYEMAC0TXBUFERR_ipd  :  std_ulogic;
        signal   PHYEMAC1COL_ipd  :  std_ulogic;
        signal   PHYEMAC1CRS_ipd  :  std_ulogic;
        signal   PHYEMAC1GTXCLK_ipd  :  std_ulogic;
        signal   PHYEMAC1MCLKIN_ipd  :  std_ulogic;
        signal   PHYEMAC1MDIN_ipd  :  std_ulogic;
        signal   PHYEMAC1MIITXCLK_ipd  :  std_ulogic;
        signal   PHYEMAC1PHYAD_ipd  :  std_logic_vector(4 downto 0);
        signal   PHYEMAC1RXBUFERR_ipd  :  std_ulogic;
        signal   PHYEMAC1RXBUFSTATUS_ipd  :  std_logic_vector(1 downto 0);
        signal   PHYEMAC1RXCHARISCOMMA_ipd  :  std_ulogic;
        signal   PHYEMAC1RXCHARISK_ipd  :  std_ulogic;
        signal   PHYEMAC1RXCHECKINGCRC_ipd  :  std_ulogic;
        signal   PHYEMAC1RXCLK_ipd  :  std_ulogic;
        signal   PHYEMAC1RXCLKCORCNT_ipd  :  std_logic_vector(2 downto 0);
        signal   PHYEMAC1RXCOMMADET_ipd  :  std_ulogic;
        signal   PHYEMAC1RXD_ipd  :  std_logic_vector(7 downto 0);
        signal   PHYEMAC1RXDISPERR_ipd  :  std_ulogic;
        signal   PHYEMAC1RXDV_ipd  :  std_ulogic;
        signal   PHYEMAC1RXER_ipd  :  std_ulogic;
        signal   PHYEMAC1RXLOSSOFSYNC_ipd  :  std_logic_vector(1 downto 0);
        signal   PHYEMAC1RXNOTINTABLE_ipd  :  std_ulogic;
        signal   PHYEMAC1RXRUNDISP_ipd  :  std_ulogic;
        signal   PHYEMAC1SIGNALDET_ipd  :  std_ulogic;
        signal   PHYEMAC1TXBUFERR_ipd  :  std_ulogic;
        signal   RESET_ipd  :  std_ulogic;
        signal   TIEEMAC0CONFIGVEC_ipd  :  std_logic_vector(79 downto 0);
        signal   TIEEMAC0UNICASTADDR_ipd  :  std_logic_vector(47 downto 0);
        signal   TIEEMAC1CONFIGVEC_ipd  :  std_logic_vector(79 downto 0);
        signal   TIEEMAC1UNICASTADDR_ipd  :  std_logic_vector(47 downto 0);
        signal   DCREMACWRITE_ipd  :  std_ulogic;
        signal   DCREMACREAD_ipd  :  std_ulogic;
        signal   DCREMACDBUS_ipd  :  std_logic_vector(0 to 31);
        signal   DCREMACABUS_ipd  :  std_logic_vector(8 to 9);
        signal   DCREMACCLK_ipd  :  std_ulogic;

        signal   DCRHOSTDONEIR_out  :  std_ulogic;
        signal   EMAC0CLIENTANINTERRUPT_out  :  std_ulogic;
        signal   EMAC0CLIENTRXBADFRAME_out  :  std_ulogic;
        signal   EMAC0CLIENTRXCLIENTCLKOUT_out  :  std_ulogic;
        signal   EMAC0CLIENTRXD_out  :  std_logic_vector(15 downto 0);
        signal   EMAC0CLIENTRXDVLD_out  :  std_ulogic;
        signal   EMAC0CLIENTRXDVLDMSW_out  :  std_ulogic;
        signal   EMAC0CLIENTRXDVREG6_out  :  std_ulogic;
        signal   EMAC0CLIENTRXFRAMEDROP_out  :  std_ulogic;
        signal   EMAC0CLIENTRXGOODFRAME_out  :  std_ulogic;
        signal   EMAC0CLIENTRXSTATS_out  :  std_logic_vector(6 downto 0);
        signal   EMAC0CLIENTRXSTATSBYTEVLD_out  :  std_ulogic;
        signal   EMAC0CLIENTRXSTATSVLD_out  :  std_ulogic;
        signal   EMAC0CLIENTTXACK_out  :  std_ulogic;
        signal   EMAC0CLIENTTXCLIENTCLKOUT_out  :  std_ulogic;
        signal   EMAC0CLIENTTXCOLLISION_out  :  std_ulogic;
        signal   EMAC0CLIENTTXGMIIMIICLKOUT_out  :  std_ulogic;
        signal   EMAC0CLIENTTXRETRANSMIT_out  :  std_ulogic;
        signal   EMAC0CLIENTTXSTATS_out  :  std_ulogic;
        signal   EMAC0CLIENTTXSTATSBYTEVLD_out  :  std_ulogic;
        signal   EMAC0CLIENTTXSTATSVLD_out  :  std_ulogic;
        signal   EMAC0PHYENCOMMAALIGN_out  :  std_ulogic;
        signal   EMAC0PHYLOOPBACKMSB_out  :  std_ulogic;
        signal   EMAC0PHYMCLKOUT_out  :  std_ulogic;
        signal   EMAC0PHYMDOUT_out  :  std_ulogic;
        signal   EMAC0PHYMDTRI_out  :  std_ulogic;
        signal   EMAC0PHYMGTRXRESET_out  :  std_ulogic;
        signal   EMAC0PHYMGTTXRESET_out  :  std_ulogic;
        signal   EMAC0PHYPOWERDOWN_out  :  std_ulogic;
        signal   EMAC0PHYSYNCACQSTATUS_out  :  std_ulogic;
        signal   EMAC0PHYTXCHARDISPMODE_out  :  std_ulogic;
        signal   EMAC0PHYTXCHARDISPVAL_out  :  std_ulogic;
        signal   EMAC0PHYTXCHARISK_out  :  std_ulogic;
        signal   EMAC0PHYTXCLK_out  :  std_ulogic;
        signal   EMAC0PHYTXD_out  :  std_logic_vector(7 downto 0);
        signal   EMAC0PHYTXEN_out  :  std_ulogic;
        signal   EMAC0PHYTXER_out  :  std_ulogic;
        signal   EMAC1CLIENTANINTERRUPT_out  :  std_ulogic;
        signal   EMAC1CLIENTRXBADFRAME_out  :  std_ulogic;
        signal   EMAC1CLIENTRXCLIENTCLKOUT_out  :  std_ulogic;
        signal   EMAC1CLIENTRXD_out  :  std_logic_vector(15 downto 0);
        signal   EMAC1CLIENTRXDVLD_out  :  std_ulogic;
        signal   EMAC1CLIENTRXDVLDMSW_out  :  std_ulogic;
        signal   EMAC1CLIENTRXDVREG6_out  :  std_ulogic;
        signal   EMAC1CLIENTRXFRAMEDROP_out  :  std_ulogic;
        signal   EMAC1CLIENTRXGOODFRAME_out  :  std_ulogic;
        signal   EMAC1CLIENTRXSTATS_out  :  std_logic_vector(6 downto 0);
        signal   EMAC1CLIENTRXSTATSBYTEVLD_out  :  std_ulogic;
        signal   EMAC1CLIENTRXSTATSVLD_out  :  std_ulogic;
        signal   EMAC1CLIENTTXACK_out  :  std_ulogic;
        signal   EMAC1CLIENTTXCLIENTCLKOUT_out  :  std_ulogic;
        signal   EMAC1CLIENTTXCOLLISION_out  :  std_ulogic;
        signal   EMAC1CLIENTTXGMIIMIICLKOUT_out  :  std_ulogic;
        signal   EMAC1CLIENTTXRETRANSMIT_out  :  std_ulogic;
        signal   EMAC1CLIENTTXSTATS_out  :  std_ulogic;
        signal   EMAC1CLIENTTXSTATSBYTEVLD_out  :  std_ulogic;
        signal   EMAC1CLIENTTXSTATSVLD_out  :  std_ulogic;
        signal   EMAC1PHYENCOMMAALIGN_out  :  std_ulogic;
        signal   EMAC1PHYLOOPBACKMSB_out  :  std_ulogic;
        signal   EMAC1PHYMCLKOUT_out  :  std_ulogic;
        signal   EMAC1PHYMDOUT_out  :  std_ulogic;
        signal   EMAC1PHYMDTRI_out  :  std_ulogic;
        signal   EMAC1PHYMGTRXRESET_out  :  std_ulogic;
        signal   EMAC1PHYMGTTXRESET_out  :  std_ulogic;
        signal   EMAC1PHYPOWERDOWN_out  :  std_ulogic;
        signal   EMAC1PHYSYNCACQSTATUS_out  :  std_ulogic;
        signal   EMAC1PHYTXCHARDISPMODE_out  :  std_ulogic;
        signal   EMAC1PHYTXCHARDISPVAL_out  :  std_ulogic;
        signal   EMAC1PHYTXCHARISK_out  :  std_ulogic;
        signal   EMAC1PHYTXCLK_out  :  std_ulogic;
        signal   EMAC1PHYTXD_out  :  std_logic_vector(7 downto 0);
        signal   EMAC1PHYTXEN_out  :  std_ulogic;
        signal   EMAC1PHYTXER_out  :  std_ulogic;
        signal   HOSTMIIMRDY_out  :  std_ulogic;
        signal   HOSTRDDATA_out  :  std_logic_vector(31 downto 0);
        signal   EMACDCRDBUS_out  :  std_logic_vector(0 to 31);
        signal   EMACDCRACK_out  :  std_ulogic;

        signal   GSR_dly  :  std_ulogic;
        signal   CLIENTEMAC0DCMLOCKED_dly  :  std_ulogic;
        signal   CLIENTEMAC0PAUSEREQ_dly  :  std_ulogic;
        signal   CLIENTEMAC0PAUSEVAL_dly  :  std_logic_vector(15 downto 0);
        signal   CLIENTEMAC0RXCLIENTCLKIN_dly  :  std_ulogic;
        signal   CLIENTEMAC0TXCLIENTCLKIN_dly  :  std_ulogic;
        signal   CLIENTEMAC0TXD_dly  :  std_logic_vector(15 downto 0);
        signal   CLIENTEMAC0TXDVLD_dly  :  std_ulogic;
        signal   CLIENTEMAC0TXDVLDMSW_dly  :  std_ulogic;
        signal   CLIENTEMAC0TXFIRSTBYTE_dly  :  std_ulogic;
        signal   CLIENTEMAC0TXGMIIMIICLKIN_dly  :  std_ulogic;
        signal   CLIENTEMAC0TXIFGDELAY_dly  :  std_logic_vector(7 downto 0);
        signal   CLIENTEMAC0TXUNDERRUN_dly  :  std_ulogic;
        signal   CLIENTEMAC1DCMLOCKED_dly  :  std_ulogic;
        signal   CLIENTEMAC1PAUSEREQ_dly  :  std_ulogic;
        signal   CLIENTEMAC1PAUSEVAL_dly  :  std_logic_vector(15 downto 0);
        signal   CLIENTEMAC1RXCLIENTCLKIN_dly  :  std_ulogic;
        signal   CLIENTEMAC1TXCLIENTCLKIN_dly  :  std_ulogic;
        signal   CLIENTEMAC1TXD_dly  :  std_logic_vector(15 downto 0);
        signal   CLIENTEMAC1TXDVLD_dly  :  std_ulogic;
        signal   CLIENTEMAC1TXDVLDMSW_dly  :  std_ulogic;
        signal   CLIENTEMAC1TXFIRSTBYTE_dly  :  std_ulogic;
        signal   CLIENTEMAC1TXGMIIMIICLKIN_dly  :  std_ulogic;
        signal   CLIENTEMAC1TXIFGDELAY_dly  :  std_logic_vector(7 downto 0);
        signal   CLIENTEMAC1TXUNDERRUN_dly  :  std_ulogic;
        signal   DCREMACENABLE_dly  :  std_ulogic;
        signal   HOSTADDR_dly  :  std_logic_vector(9 downto 0);
        signal   HOSTCLK_dly  :  std_ulogic;
        signal   HOSTEMAC1SEL_dly  :  std_ulogic;
        signal   HOSTMIIMSEL_dly  :  std_ulogic;
        signal   HOSTOPCODE_dly  :  std_logic_vector(1 downto 0);
        signal   HOSTREQ_dly  :  std_ulogic;
        signal   HOSTWRDATA_dly  :  std_logic_vector(31 downto 0);
        signal   PHYEMAC0COL_dly  :  std_ulogic;
        signal   PHYEMAC0CRS_dly  :  std_ulogic;
        signal   PHYEMAC0GTXCLK_dly  :  std_ulogic;
        signal   PHYEMAC0MCLKIN_dly  :  std_ulogic;
        signal   PHYEMAC0MDIN_dly  :  std_ulogic;
        signal   PHYEMAC0MIITXCLK_dly  :  std_ulogic;
        signal   PHYEMAC0PHYAD_dly  :  std_logic_vector(4 downto 0);
        signal   PHYEMAC0RXBUFERR_dly  :  std_ulogic;
        signal   PHYEMAC0RXBUFSTATUS_dly  :  std_logic_vector(1 downto 0);
        signal   PHYEMAC0RXCHARISCOMMA_dly  :  std_ulogic;
        signal   PHYEMAC0RXCHARISK_dly  :  std_ulogic;
        signal   PHYEMAC0RXCHECKINGCRC_dly  :  std_ulogic;
        signal   PHYEMAC0RXCLK_dly  :  std_ulogic;
        signal   PHYEMAC0RXCLKCORCNT_dly  :  std_logic_vector(2 downto 0);
        signal   PHYEMAC0RXCOMMADET_dly  :  std_ulogic;
        signal   PHYEMAC0RXD_dly  :  std_logic_vector(7 downto 0);
        signal   PHYEMAC0RXDISPERR_dly  :  std_ulogic;
        signal   PHYEMAC0RXDV_dly  :  std_ulogic;
        signal   PHYEMAC0RXER_dly  :  std_ulogic;
        signal   PHYEMAC0RXLOSSOFSYNC_dly  :  std_logic_vector(1 downto 0);
        signal   PHYEMAC0RXNOTINTABLE_dly  :  std_ulogic;
        signal   PHYEMAC0RXRUNDISP_dly  :  std_ulogic;
        signal   PHYEMAC0SIGNALDET_dly  :  std_ulogic;
        signal   PHYEMAC0TXBUFERR_dly  :  std_ulogic;
        signal   PHYEMAC1COL_dly  :  std_ulogic;
        signal   PHYEMAC1CRS_dly  :  std_ulogic;
        signal   PHYEMAC1GTXCLK_dly  :  std_ulogic;
        signal   PHYEMAC1MCLKIN_dly  :  std_ulogic;
        signal   PHYEMAC1MDIN_dly  :  std_ulogic;
        signal   PHYEMAC1MIITXCLK_dly  :  std_ulogic;
        signal   PHYEMAC1PHYAD_dly  :  std_logic_vector(4 downto 0);
        signal   PHYEMAC1RXBUFERR_dly  :  std_ulogic;
        signal   PHYEMAC1RXBUFSTATUS_dly  :  std_logic_vector(1 downto 0);
        signal   PHYEMAC1RXCHARISCOMMA_dly  :  std_ulogic;
        signal   PHYEMAC1RXCHARISK_dly  :  std_ulogic;
        signal   PHYEMAC1RXCHECKINGCRC_dly  :  std_ulogic;
        signal   PHYEMAC1RXCLK_dly  :  std_ulogic;
        signal   PHYEMAC1RXCLKCORCNT_dly  :  std_logic_vector(2 downto 0);
        signal   PHYEMAC1RXCOMMADET_dly  :  std_ulogic;
        signal   PHYEMAC1RXD_dly  :  std_logic_vector(7 downto 0);
        signal   PHYEMAC1RXDISPERR_dly  :  std_ulogic;
        signal   PHYEMAC1RXDV_dly  :  std_ulogic;
        signal   PHYEMAC1RXER_dly  :  std_ulogic;
        signal   PHYEMAC1RXLOSSOFSYNC_dly  :  std_logic_vector(1 downto 0);
        signal   PHYEMAC1RXNOTINTABLE_dly  :  std_ulogic;
        signal   PHYEMAC1RXRUNDISP_dly  :  std_ulogic;
        signal   PHYEMAC1SIGNALDET_dly  :  std_ulogic;
        signal   PHYEMAC1TXBUFERR_dly  :  std_ulogic;
        signal   RESET_dly  :  std_ulogic;
        signal   TIEEMAC0CONFIGVEC_dly  :  std_logic_vector(79 downto 0);
        signal   TIEEMAC0UNICASTADDR_dly  :  std_logic_vector(47 downto 0);
        signal   TIEEMAC1CONFIGVEC_dly  :  std_logic_vector(79 downto 0);
        signal   TIEEMAC1UNICASTADDR_dly  :  std_logic_vector(47 downto 0);
        signal   DCREMACWRITE_dly  :  std_ulogic;
        signal   DCREMACREAD_dly  :  std_ulogic;
        signal   DCREMACDBUS_dly  :  std_logic_vector(0 to 31);
        signal   DCREMACABUS_dly  :  std_logic_vector(8 to 9);
        signal   DCREMACCLK_dly  :  std_ulogic;

begin


   WireDelay : block
       begin
              VitalWireDelay (CLIENTEMAC0DCMLOCKED_ipd,CLIENTEMAC0DCMLOCKED,tipd_CLIENTEMAC0DCMLOCKED);
              VitalWireDelay (CLIENTEMAC0PAUSEREQ_ipd,CLIENTEMAC0PAUSEREQ,tipd_CLIENTEMAC0PAUSEREQ);
           CLIENTEMAC0PAUSEVAL_DELAY : for i in 15 downto 0 generate
              VitalWireDelay (CLIENTEMAC0PAUSEVAL_ipd(i),CLIENTEMAC0PAUSEVAL(i),tipd_CLIENTEMAC0PAUSEVAL(i));
           end generate CLIENTEMAC0PAUSEVAL_DELAY;
              VitalWireDelay (CLIENTEMAC0RXCLIENTCLKIN_ipd,CLIENTEMAC0RXCLIENTCLKIN,tipd_CLIENTEMAC0RXCLIENTCLKIN);
              VitalWireDelay (CLIENTEMAC0TXCLIENTCLKIN_ipd,CLIENTEMAC0TXCLIENTCLKIN,tipd_CLIENTEMAC0TXCLIENTCLKIN);
           CLIENTEMAC0TXD_DELAY : for i in 15 downto 0 generate
              VitalWireDelay (CLIENTEMAC0TXD_ipd(i),CLIENTEMAC0TXD(i),tipd_CLIENTEMAC0TXD(i));
           end generate CLIENTEMAC0TXD_DELAY;
              VitalWireDelay (CLIENTEMAC0TXDVLD_ipd,CLIENTEMAC0TXDVLD,tipd_CLIENTEMAC0TXDVLD);
              VitalWireDelay (CLIENTEMAC0TXDVLDMSW_ipd,CLIENTEMAC0TXDVLDMSW,tipd_CLIENTEMAC0TXDVLDMSW);
              VitalWireDelay (CLIENTEMAC0TXFIRSTBYTE_ipd,CLIENTEMAC0TXFIRSTBYTE,tipd_CLIENTEMAC0TXFIRSTBYTE);
              VitalWireDelay (CLIENTEMAC0TXGMIIMIICLKIN_ipd,CLIENTEMAC0TXGMIIMIICLKIN,tipd_CLIENTEMAC0TXGMIIMIICLKIN);
           CLIENTEMAC0TXIFGDELAY_DELAY : for i in 7 downto 0 generate
              VitalWireDelay (CLIENTEMAC0TXIFGDELAY_ipd(i),CLIENTEMAC0TXIFGDELAY(i),tipd_CLIENTEMAC0TXIFGDELAY(i));
           end generate CLIENTEMAC0TXIFGDELAY_DELAY;
              VitalWireDelay (CLIENTEMAC0TXUNDERRUN_ipd,CLIENTEMAC0TXUNDERRUN,tipd_CLIENTEMAC0TXUNDERRUN);
              VitalWireDelay (CLIENTEMAC1DCMLOCKED_ipd,CLIENTEMAC1DCMLOCKED,tipd_CLIENTEMAC1DCMLOCKED);
              VitalWireDelay (CLIENTEMAC1PAUSEREQ_ipd,CLIENTEMAC1PAUSEREQ,tipd_CLIENTEMAC1PAUSEREQ);
           CLIENTEMAC1PAUSEVAL_DELAY : for i in 15 downto 0 generate
              VitalWireDelay (CLIENTEMAC1PAUSEVAL_ipd(i),CLIENTEMAC1PAUSEVAL(i),tipd_CLIENTEMAC1PAUSEVAL(i));
           end generate CLIENTEMAC1PAUSEVAL_DELAY;
              VitalWireDelay (CLIENTEMAC1RXCLIENTCLKIN_ipd,CLIENTEMAC1RXCLIENTCLKIN,tipd_CLIENTEMAC1RXCLIENTCLKIN);
              VitalWireDelay (CLIENTEMAC1TXCLIENTCLKIN_ipd,CLIENTEMAC1TXCLIENTCLKIN,tipd_CLIENTEMAC1TXCLIENTCLKIN);
           CLIENTEMAC1TXD_DELAY : for i in 15 downto 0 generate
              VitalWireDelay (CLIENTEMAC1TXD_ipd(i),CLIENTEMAC1TXD(i),tipd_CLIENTEMAC1TXD(i));
           end generate CLIENTEMAC1TXD_DELAY;
              VitalWireDelay (CLIENTEMAC1TXDVLD_ipd,CLIENTEMAC1TXDVLD,tipd_CLIENTEMAC1TXDVLD);
              VitalWireDelay (CLIENTEMAC1TXDVLDMSW_ipd,CLIENTEMAC1TXDVLDMSW,tipd_CLIENTEMAC1TXDVLDMSW);
              VitalWireDelay (CLIENTEMAC1TXFIRSTBYTE_ipd,CLIENTEMAC1TXFIRSTBYTE,tipd_CLIENTEMAC1TXFIRSTBYTE);
              VitalWireDelay (CLIENTEMAC1TXGMIIMIICLKIN_ipd,CLIENTEMAC1TXGMIIMIICLKIN,tipd_CLIENTEMAC1TXGMIIMIICLKIN);
           CLIENTEMAC1TXIFGDELAY_DELAY : for i in 7 downto 0 generate
              VitalWireDelay (CLIENTEMAC1TXIFGDELAY_ipd(i),CLIENTEMAC1TXIFGDELAY(i),tipd_CLIENTEMAC1TXIFGDELAY(i));
           end generate CLIENTEMAC1TXIFGDELAY_DELAY;
              VitalWireDelay (CLIENTEMAC1TXUNDERRUN_ipd,CLIENTEMAC1TXUNDERRUN,tipd_CLIENTEMAC1TXUNDERRUN);
              VitalWireDelay (DCREMACENABLE_ipd,DCREMACENABLE,tipd_DCREMACENABLE);
           HOSTADDR_DELAY : for i in 9 downto 0 generate
              VitalWireDelay (HOSTADDR_ipd(i),HOSTADDR(i),tipd_HOSTADDR(i));
           end generate HOSTADDR_DELAY;
              VitalWireDelay (HOSTCLK_ipd,HOSTCLK,tipd_HOSTCLK);
              VitalWireDelay (HOSTEMAC1SEL_ipd,HOSTEMAC1SEL,tipd_HOSTEMAC1SEL);
              VitalWireDelay (HOSTMIIMSEL_ipd,HOSTMIIMSEL,tipd_HOSTMIIMSEL);
           HOSTOPCODE_DELAY : for i in 1 downto 0 generate
              VitalWireDelay (HOSTOPCODE_ipd(i),HOSTOPCODE(i),tipd_HOSTOPCODE(i));
           end generate HOSTOPCODE_DELAY;
              VitalWireDelay (HOSTREQ_ipd,HOSTREQ,tipd_HOSTREQ);
           HOSTWRDATA_DELAY : for i in 31 downto 0 generate
              VitalWireDelay (HOSTWRDATA_ipd(i),HOSTWRDATA(i),tipd_HOSTWRDATA(i));
           end generate HOSTWRDATA_DELAY;
              VitalWireDelay (PHYEMAC0COL_ipd,PHYEMAC0COL,tipd_PHYEMAC0COL);
              VitalWireDelay (PHYEMAC0CRS_ipd,PHYEMAC0CRS,tipd_PHYEMAC0CRS);
              VitalWireDelay (PHYEMAC0GTXCLK_ipd,PHYEMAC0GTXCLK,tipd_PHYEMAC0GTXCLK);
              VitalWireDelay (PHYEMAC0MCLKIN_ipd,PHYEMAC0MCLKIN,tipd_PHYEMAC0MCLKIN);
              VitalWireDelay (PHYEMAC0MDIN_ipd,PHYEMAC0MDIN,tipd_PHYEMAC0MDIN);
              VitalWireDelay (PHYEMAC0MIITXCLK_ipd,PHYEMAC0MIITXCLK,tipd_PHYEMAC0MIITXCLK);
           PHYEMAC0PHYAD_DELAY : for i in 4 downto 0 generate
              VitalWireDelay (PHYEMAC0PHYAD_ipd(i),PHYEMAC0PHYAD(i),tipd_PHYEMAC0PHYAD(i));
           end generate PHYEMAC0PHYAD_DELAY;
              VitalWireDelay (PHYEMAC0RXBUFERR_ipd,PHYEMAC0RXBUFERR,tipd_PHYEMAC0RXBUFERR);
           PHYEMAC0RXBUFSTATUS_DELAY : for i in 1 downto 0 generate
              VitalWireDelay (PHYEMAC0RXBUFSTATUS_ipd(i),PHYEMAC0RXBUFSTATUS(i),tipd_PHYEMAC0RXBUFSTATUS(i));
           end generate PHYEMAC0RXBUFSTATUS_DELAY;
              VitalWireDelay (PHYEMAC0RXCHARISCOMMA_ipd,PHYEMAC0RXCHARISCOMMA,tipd_PHYEMAC0RXCHARISCOMMA);
              VitalWireDelay (PHYEMAC0RXCHARISK_ipd,PHYEMAC0RXCHARISK,tipd_PHYEMAC0RXCHARISK);
              VitalWireDelay (PHYEMAC0RXCHECKINGCRC_ipd,PHYEMAC0RXCHECKINGCRC,tipd_PHYEMAC0RXCHECKINGCRC);
              VitalWireDelay (PHYEMAC0RXCLK_ipd,PHYEMAC0RXCLK,tipd_PHYEMAC0RXCLK);
           PHYEMAC0RXCLKCORCNT_DELAY : for i in 2 downto 0 generate
              VitalWireDelay (PHYEMAC0RXCLKCORCNT_ipd(i),PHYEMAC0RXCLKCORCNT(i),tipd_PHYEMAC0RXCLKCORCNT(i));
           end generate PHYEMAC0RXCLKCORCNT_DELAY;
              VitalWireDelay (PHYEMAC0RXCOMMADET_ipd,PHYEMAC0RXCOMMADET,tipd_PHYEMAC0RXCOMMADET);
           PHYEMAC0RXD_DELAY : for i in 7 downto 0 generate
              VitalWireDelay (PHYEMAC0RXD_ipd(i),PHYEMAC0RXD(i),tipd_PHYEMAC0RXD(i));
           end generate PHYEMAC0RXD_DELAY;
              VitalWireDelay (PHYEMAC0RXDISPERR_ipd,PHYEMAC0RXDISPERR,tipd_PHYEMAC0RXDISPERR);
              VitalWireDelay (PHYEMAC0RXDV_ipd,PHYEMAC0RXDV,tipd_PHYEMAC0RXDV);
              VitalWireDelay (PHYEMAC0RXER_ipd,PHYEMAC0RXER,tipd_PHYEMAC0RXER);
           PHYEMAC0RXLOSSOFSYNC_DELAY : for i in 1 downto 0 generate
              VitalWireDelay (PHYEMAC0RXLOSSOFSYNC_ipd(i),PHYEMAC0RXLOSSOFSYNC(i),tipd_PHYEMAC0RXLOSSOFSYNC(i));
           end generate PHYEMAC0RXLOSSOFSYNC_DELAY;
              VitalWireDelay (PHYEMAC0RXNOTINTABLE_ipd,PHYEMAC0RXNOTINTABLE,tipd_PHYEMAC0RXNOTINTABLE);
              VitalWireDelay (PHYEMAC0RXRUNDISP_ipd,PHYEMAC0RXRUNDISP,tipd_PHYEMAC0RXRUNDISP);
              VitalWireDelay (PHYEMAC0SIGNALDET_ipd,PHYEMAC0SIGNALDET,tipd_PHYEMAC0SIGNALDET);
              VitalWireDelay (PHYEMAC0TXBUFERR_ipd,PHYEMAC0TXBUFERR,tipd_PHYEMAC0TXBUFERR);
              VitalWireDelay (PHYEMAC1COL_ipd,PHYEMAC1COL,tipd_PHYEMAC1COL);
              VitalWireDelay (PHYEMAC1CRS_ipd,PHYEMAC1CRS,tipd_PHYEMAC1CRS);
              VitalWireDelay (PHYEMAC1GTXCLK_ipd,PHYEMAC1GTXCLK,tipd_PHYEMAC1GTXCLK);
              VitalWireDelay (PHYEMAC1MCLKIN_ipd,PHYEMAC1MCLKIN,tipd_PHYEMAC1MCLKIN);
              VitalWireDelay (PHYEMAC1MDIN_ipd,PHYEMAC1MDIN,tipd_PHYEMAC1MDIN);
              VitalWireDelay (PHYEMAC1MIITXCLK_ipd,PHYEMAC1MIITXCLK,tipd_PHYEMAC1MIITXCLK);
           PHYEMAC1PHYAD_DELAY : for i in 4 downto 0 generate
              VitalWireDelay (PHYEMAC1PHYAD_ipd(i),PHYEMAC1PHYAD(i),tipd_PHYEMAC1PHYAD(i));
           end generate PHYEMAC1PHYAD_DELAY;
              VitalWireDelay (PHYEMAC1RXBUFERR_ipd,PHYEMAC1RXBUFERR,tipd_PHYEMAC1RXBUFERR);
           PHYEMAC1RXBUFSTATUS_DELAY : for i in 1 downto 0 generate
              VitalWireDelay (PHYEMAC1RXBUFSTATUS_ipd(i),PHYEMAC1RXBUFSTATUS(i),tipd_PHYEMAC1RXBUFSTATUS(i));
           end generate PHYEMAC1RXBUFSTATUS_DELAY;
              VitalWireDelay (PHYEMAC1RXCHARISCOMMA_ipd,PHYEMAC1RXCHARISCOMMA,tipd_PHYEMAC1RXCHARISCOMMA);
              VitalWireDelay (PHYEMAC1RXCHARISK_ipd,PHYEMAC1RXCHARISK,tipd_PHYEMAC1RXCHARISK);
              VitalWireDelay (PHYEMAC1RXCHECKINGCRC_ipd,PHYEMAC1RXCHECKINGCRC,tipd_PHYEMAC1RXCHECKINGCRC);
              VitalWireDelay (PHYEMAC1RXCLK_ipd,PHYEMAC1RXCLK,tipd_PHYEMAC1RXCLK);
           PHYEMAC1RXCLKCORCNT_DELAY : for i in 2 downto 0 generate
              VitalWireDelay (PHYEMAC1RXCLKCORCNT_ipd(i),PHYEMAC1RXCLKCORCNT(i),tipd_PHYEMAC1RXCLKCORCNT(i));
           end generate PHYEMAC1RXCLKCORCNT_DELAY;
              VitalWireDelay (PHYEMAC1RXCOMMADET_ipd,PHYEMAC1RXCOMMADET,tipd_PHYEMAC1RXCOMMADET);
           PHYEMAC1RXD_DELAY : for i in 7 downto 0 generate
              VitalWireDelay (PHYEMAC1RXD_ipd(i),PHYEMAC1RXD(i),tipd_PHYEMAC1RXD(i));
           end generate PHYEMAC1RXD_DELAY;
              VitalWireDelay (PHYEMAC1RXDISPERR_ipd,PHYEMAC1RXDISPERR,tipd_PHYEMAC1RXDISPERR);
              VitalWireDelay (PHYEMAC1RXDV_ipd,PHYEMAC1RXDV,tipd_PHYEMAC1RXDV);
              VitalWireDelay (PHYEMAC1RXER_ipd,PHYEMAC1RXER,tipd_PHYEMAC1RXER);
           PHYEMAC1RXLOSSOFSYNC_DELAY : for i in 1 downto 0 generate
              VitalWireDelay (PHYEMAC1RXLOSSOFSYNC_ipd(i),PHYEMAC1RXLOSSOFSYNC(i),tipd_PHYEMAC1RXLOSSOFSYNC(i));
           end generate PHYEMAC1RXLOSSOFSYNC_DELAY;
              VitalWireDelay (PHYEMAC1RXNOTINTABLE_ipd,PHYEMAC1RXNOTINTABLE,tipd_PHYEMAC1RXNOTINTABLE);
              VitalWireDelay (PHYEMAC1RXRUNDISP_ipd,PHYEMAC1RXRUNDISP,tipd_PHYEMAC1RXRUNDISP);
              VitalWireDelay (PHYEMAC1SIGNALDET_ipd,PHYEMAC1SIGNALDET,tipd_PHYEMAC1SIGNALDET);
              VitalWireDelay (PHYEMAC1TXBUFERR_ipd,PHYEMAC1TXBUFERR,tipd_PHYEMAC1TXBUFERR);
              VitalWireDelay (RESET_ipd,RESET,tipd_RESET);
           TIEEMAC0CONFIGVEC_DELAY : for i in 79 downto 0 generate
              VitalWireDelay (TIEEMAC0CONFIGVEC_ipd(i),TIEEMAC0CONFIGVEC(i),tipd_TIEEMAC0CONFIGVEC(i));
           end generate TIEEMAC0CONFIGVEC_DELAY;
           TIEEMAC0UNICASTADDR_DELAY : for i in 47 downto 0 generate
              VitalWireDelay (TIEEMAC0UNICASTADDR_ipd(i),TIEEMAC0UNICASTADDR(i),tipd_TIEEMAC0UNICASTADDR(i));
           end generate TIEEMAC0UNICASTADDR_DELAY;
           TIEEMAC1CONFIGVEC_DELAY : for i in 79 downto 0 generate
              VitalWireDelay (TIEEMAC1CONFIGVEC_ipd(i),TIEEMAC1CONFIGVEC(i),tipd_TIEEMAC1CONFIGVEC(i));
           end generate TIEEMAC1CONFIGVEC_DELAY;
           TIEEMAC1UNICASTADDR_DELAY : for i in 47 downto 0 generate
              VitalWireDelay (TIEEMAC1UNICASTADDR_ipd(i),TIEEMAC1UNICASTADDR(i),tipd_TIEEMAC1UNICASTADDR(i));
           end generate TIEEMAC1UNICASTADDR_DELAY;
              VitalWireDelay (DCREMACWRITE_ipd,DCREMACWRITE,tipd_DCREMACWRITE);
              VitalWireDelay (DCREMACREAD_ipd,DCREMACREAD,tipd_DCREMACREAD);
           DCREMACDBUS_DELAY : for i in 0 to 31 generate
              VitalWireDelay (DCREMACDBUS_ipd(i),DCREMACDBUS(i),tipd_DCREMACDBUS(i));
           end generate DCREMACDBUS_DELAY;
           DCREMACABUS_DELAY : for i in 8 to 9 generate
              VitalWireDelay (DCREMACABUS_ipd(i),DCREMACABUS(i),tipd_DCREMACABUS(i));
           end generate DCREMACABUS_DELAY;
              VitalWireDelay (DCREMACCLK_ipd,DCREMACCLK,tipd_DCREMACCLK);
              VitalWireDelay (GSR_ipd,GSR,tipd_GSR);
       end block;

   SignalDelay : block
       begin
              VitalSignalDelay (CLIENTEMAC0DCMLOCKED_dly,CLIENTEMAC0DCMLOCKED_ipd,tisd_CLIENTEMAC0DCMLOCKED);
              VitalSignalDelay (CLIENTEMAC0PAUSEREQ_dly,CLIENTEMAC0PAUSEREQ_ipd,tisd_CLIENTEMAC0PAUSEREQ);
           CLIENTEMAC0PAUSEVAL_DELAY : for i in 15 downto 0 generate
              VitalSignalDelay (CLIENTEMAC0PAUSEVAL_dly(i),CLIENTEMAC0PAUSEVAL_ipd(i),tisd_CLIENTEMAC0PAUSEVAL(i));
           end generate CLIENTEMAC0PAUSEVAL_DELAY;
           CLIENTEMAC0TXD_DELAY : for i in 15 downto 0 generate
              VitalSignalDelay (CLIENTEMAC0TXD_dly(i),CLIENTEMAC0TXD_ipd(i),tisd_CLIENTEMAC0TXD(i));
           end generate CLIENTEMAC0TXD_DELAY;
              VitalSignalDelay (CLIENTEMAC0TXDVLD_dly,CLIENTEMAC0TXDVLD_ipd,tisd_CLIENTEMAC0TXDVLD);
              VitalSignalDelay (CLIENTEMAC0TXDVLDMSW_dly,CLIENTEMAC0TXDVLDMSW_ipd,tisd_CLIENTEMAC0TXDVLDMSW);
              VitalSignalDelay (CLIENTEMAC0TXFIRSTBYTE_dly,CLIENTEMAC0TXFIRSTBYTE_ipd,tisd_CLIENTEMAC0TXFIRSTBYTE);
           CLIENTEMAC0TXIFGDELAY_DELAY : for i in 7 downto 0 generate
              VitalSignalDelay (CLIENTEMAC0TXIFGDELAY_dly(i),CLIENTEMAC0TXIFGDELAY_ipd(i),tisd_CLIENTEMAC0TXIFGDELAY(i));
           end generate CLIENTEMAC0TXIFGDELAY_DELAY;
              VitalSignalDelay (CLIENTEMAC0TXUNDERRUN_dly,CLIENTEMAC0TXUNDERRUN_ipd,tisd_CLIENTEMAC0TXUNDERRUN);
              VitalSignalDelay (CLIENTEMAC1DCMLOCKED_dly,CLIENTEMAC1DCMLOCKED_ipd,tisd_CLIENTEMAC1DCMLOCKED);
              VitalSignalDelay (CLIENTEMAC1PAUSEREQ_dly,CLIENTEMAC1PAUSEREQ_ipd,tisd_CLIENTEMAC1PAUSEREQ);
           CLIENTEMAC1PAUSEVAL_DELAY : for i in 15 downto 0 generate
              VitalSignalDelay (CLIENTEMAC1PAUSEVAL_dly(i),CLIENTEMAC1PAUSEVAL_ipd(i),tisd_CLIENTEMAC1PAUSEVAL(i));
           end generate CLIENTEMAC1PAUSEVAL_DELAY;
           CLIENTEMAC1TXD_DELAY : for i in 15 downto 0 generate
              VitalSignalDelay (CLIENTEMAC1TXD_dly(i),CLIENTEMAC1TXD_ipd(i),tisd_CLIENTEMAC1TXD(i));
           end generate CLIENTEMAC1TXD_DELAY;
              VitalSignalDelay (CLIENTEMAC1TXDVLD_dly,CLIENTEMAC1TXDVLD_ipd,tisd_CLIENTEMAC1TXDVLD);
              VitalSignalDelay (CLIENTEMAC1TXDVLDMSW_dly,CLIENTEMAC1TXDVLDMSW_ipd,tisd_CLIENTEMAC1TXDVLDMSW);
              VitalSignalDelay (CLIENTEMAC1TXFIRSTBYTE_dly,CLIENTEMAC1TXFIRSTBYTE_ipd,tisd_CLIENTEMAC1TXFIRSTBYTE);
           CLIENTEMAC1TXIFGDELAY_DELAY : for i in 7 downto 0 generate
              VitalSignalDelay (CLIENTEMAC1TXIFGDELAY_dly(i),CLIENTEMAC1TXIFGDELAY_ipd(i),tisd_CLIENTEMAC1TXIFGDELAY(i));
           end generate CLIENTEMAC1TXIFGDELAY_DELAY;
              VitalSignalDelay (CLIENTEMAC1TXUNDERRUN_dly,CLIENTEMAC1TXUNDERRUN_ipd,tisd_CLIENTEMAC1TXUNDERRUN);
           HOSTADDR_DELAY : for i in 9 downto 0 generate
              VitalSignalDelay (HOSTADDR_dly(i),HOSTADDR_ipd(i),tisd_HOSTADDR(i));
           end generate HOSTADDR_DELAY;
              VitalSignalDelay (HOSTEMAC1SEL_dly,HOSTEMAC1SEL_ipd,tisd_HOSTEMAC1SEL);
              VitalSignalDelay (HOSTMIIMSEL_dly,HOSTMIIMSEL_ipd,tisd_HOSTMIIMSEL);
           HOSTOPCODE_DELAY : for i in 1 downto 0 generate
              VitalSignalDelay (HOSTOPCODE_dly(i),HOSTOPCODE_ipd(i),tisd_HOSTOPCODE(i));
           end generate HOSTOPCODE_DELAY;
              VitalSignalDelay (HOSTREQ_dly,HOSTREQ_ipd,tisd_HOSTREQ);
           HOSTWRDATA_DELAY : for i in 31 downto 0 generate
              VitalSignalDelay (HOSTWRDATA_dly(i),HOSTWRDATA_ipd(i),tisd_HOSTWRDATA(i));
           end generate HOSTWRDATA_DELAY;
              VitalSignalDelay (PHYEMAC0COL_dly,PHYEMAC0COL_ipd,tisd_PHYEMAC0COL);
              VitalSignalDelay (PHYEMAC0CRS_dly,PHYEMAC0CRS_ipd,tisd_PHYEMAC0CRS);
              VitalSignalDelay (PHYEMAC0MDIN_dly,PHYEMAC0MDIN_ipd,tisd_PHYEMAC0MDIN);
              VitalSignalDelay (PHYEMAC0RXBUFERR_dly,PHYEMAC0RXBUFERR_ipd,tisd_PHYEMAC0RXBUFERR);
           PHYEMAC0RXBUFSTATUS_DELAY : for i in 1 downto 0 generate
              VitalSignalDelay (PHYEMAC0RXBUFSTATUS_dly(i),PHYEMAC0RXBUFSTATUS_ipd(i),tisd_PHYEMAC0RXBUFSTATUS(i));
           end generate PHYEMAC0RXBUFSTATUS_DELAY;
              VitalSignalDelay (PHYEMAC0RXCHARISCOMMA_dly,PHYEMAC0RXCHARISCOMMA_ipd,tisd_PHYEMAC0RXCHARISCOMMA);
              VitalSignalDelay (PHYEMAC0RXCHARISK_dly,PHYEMAC0RXCHARISK_ipd,tisd_PHYEMAC0RXCHARISK);
              VitalSignalDelay (PHYEMAC0RXCHECKINGCRC_dly,PHYEMAC0RXCHECKINGCRC_ipd,tisd_PHYEMAC0RXCHECKINGCRC);
           PHYEMAC0RXCLKCORCNT_DELAY : for i in 2 downto 0 generate
              VitalSignalDelay (PHYEMAC0RXCLKCORCNT_dly(i),PHYEMAC0RXCLKCORCNT_ipd(i),tisd_PHYEMAC0RXCLKCORCNT(i));
           end generate PHYEMAC0RXCLKCORCNT_DELAY;
              VitalSignalDelay (PHYEMAC0RXCOMMADET_dly,PHYEMAC0RXCOMMADET_ipd,tisd_PHYEMAC0RXCOMMADET);
           PHYEMAC0RXD_DELAY : for i in 7 downto 0 generate
              VitalSignalDelay (PHYEMAC0RXD_dly(i),PHYEMAC0RXD_ipd(i),tisd_PHYEMAC0RXD(i));
           end generate PHYEMAC0RXD_DELAY;
              VitalSignalDelay (PHYEMAC0RXDISPERR_dly,PHYEMAC0RXDISPERR_ipd,tisd_PHYEMAC0RXDISPERR);
              VitalSignalDelay (PHYEMAC0RXDV_dly,PHYEMAC0RXDV_ipd,tisd_PHYEMAC0RXDV);
              VitalSignalDelay (PHYEMAC0RXER_dly,PHYEMAC0RXER_ipd,tisd_PHYEMAC0RXER);
           PHYEMAC0RXLOSSOFSYNC_DELAY : for i in 1 downto 0 generate
              VitalSignalDelay (PHYEMAC0RXLOSSOFSYNC_dly(i),PHYEMAC0RXLOSSOFSYNC_ipd(i),tisd_PHYEMAC0RXLOSSOFSYNC(i));
           end generate PHYEMAC0RXLOSSOFSYNC_DELAY;
              VitalSignalDelay (PHYEMAC0RXNOTINTABLE_dly,PHYEMAC0RXNOTINTABLE_ipd,tisd_PHYEMAC0RXNOTINTABLE);
              VitalSignalDelay (PHYEMAC0RXRUNDISP_dly,PHYEMAC0RXRUNDISP_ipd,tisd_PHYEMAC0RXRUNDISP);
              VitalSignalDelay (PHYEMAC0TXBUFERR_dly,PHYEMAC0TXBUFERR_ipd,tisd_PHYEMAC0TXBUFERR);
              VitalSignalDelay (PHYEMAC1COL_dly,PHYEMAC1COL_ipd,tisd_PHYEMAC1COL);
              VitalSignalDelay (PHYEMAC1CRS_dly,PHYEMAC1CRS_ipd,tisd_PHYEMAC1CRS);
              VitalSignalDelay (PHYEMAC1MDIN_dly,PHYEMAC1MDIN_ipd,tisd_PHYEMAC1MDIN);
              VitalSignalDelay (PHYEMAC1RXBUFERR_dly,PHYEMAC1RXBUFERR_ipd,tisd_PHYEMAC1RXBUFERR);
           PHYEMAC1RXBUFSTATUS_DELAY : for i in 1 downto 0 generate
              VitalSignalDelay (PHYEMAC1RXBUFSTATUS_dly(i),PHYEMAC1RXBUFSTATUS_ipd(i),tisd_PHYEMAC1RXBUFSTATUS(i));
           end generate PHYEMAC1RXBUFSTATUS_DELAY;
              VitalSignalDelay (PHYEMAC1RXCHARISCOMMA_dly,PHYEMAC1RXCHARISCOMMA_ipd,tisd_PHYEMAC1RXCHARISCOMMA);
              VitalSignalDelay (PHYEMAC1RXCHARISK_dly,PHYEMAC1RXCHARISK_ipd,tisd_PHYEMAC1RXCHARISK);
              VitalSignalDelay (PHYEMAC1RXCHECKINGCRC_dly,PHYEMAC1RXCHECKINGCRC_ipd,tisd_PHYEMAC1RXCHECKINGCRC);
           PHYEMAC1RXCLKCORCNT_DELAY : for i in 2 downto 0 generate
              VitalSignalDelay (PHYEMAC1RXCLKCORCNT_dly(i),PHYEMAC1RXCLKCORCNT_ipd(i),tisd_PHYEMAC1RXCLKCORCNT(i));
           end generate PHYEMAC1RXCLKCORCNT_DELAY;
              VitalSignalDelay (PHYEMAC1RXCOMMADET_dly,PHYEMAC1RXCOMMADET_ipd,tisd_PHYEMAC1RXCOMMADET);
           PHYEMAC1RXD_DELAY : for i in 7 downto 0 generate
              VitalSignalDelay (PHYEMAC1RXD_dly(i),PHYEMAC1RXD_ipd(i),tisd_PHYEMAC1RXD(i));
           end generate PHYEMAC1RXD_DELAY;
              VitalSignalDelay (PHYEMAC1RXDISPERR_dly,PHYEMAC1RXDISPERR_ipd,tisd_PHYEMAC1RXDISPERR);
              VitalSignalDelay (PHYEMAC1RXDV_dly,PHYEMAC1RXDV_ipd,tisd_PHYEMAC1RXDV);
              VitalSignalDelay (PHYEMAC1RXER_dly,PHYEMAC1RXER_ipd,tisd_PHYEMAC1RXER);
           PHYEMAC1RXLOSSOFSYNC_DELAY : for i in 1 downto 0 generate
              VitalSignalDelay (PHYEMAC1RXLOSSOFSYNC_dly(i),PHYEMAC1RXLOSSOFSYNC_ipd(i),tisd_PHYEMAC1RXLOSSOFSYNC(i));
           end generate PHYEMAC1RXLOSSOFSYNC_DELAY;
              VitalSignalDelay (PHYEMAC1RXNOTINTABLE_dly,PHYEMAC1RXNOTINTABLE_ipd,tisd_PHYEMAC1RXNOTINTABLE);
              VitalSignalDelay (PHYEMAC1RXRUNDISP_dly,PHYEMAC1RXRUNDISP_ipd,tisd_PHYEMAC1RXRUNDISP);
              VitalSignalDelay (PHYEMAC1TXBUFERR_dly,PHYEMAC1TXBUFERR_ipd,tisd_PHYEMAC1TXBUFERR);

              VitalSignalDelay (PHYEMAC0GTXCLK_dly,PHYEMAC0GTXCLK_ipd,ticd_PHYEMAC0GTXCLK);
              VitalSignalDelay (CLIENTEMAC0TXCLIENTCLKIN_dly,CLIENTEMAC0TXCLIENTCLKIN_ipd,ticd_CLIENTEMAC0TXCLIENTCLKIN);
              VitalSignalDelay (PHYEMAC1GTXCLK_dly,PHYEMAC1GTXCLK_ipd,ticd_PHYEMAC1GTXCLK);
              VitalSignalDelay (CLIENTEMAC1TXCLIENTCLKIN_dly,CLIENTEMAC1TXCLIENTCLKIN_ipd,ticd_CLIENTEMAC1TXCLIENTCLKIN);
              VitalSignalDelay (HOSTCLK_dly,HOSTCLK_ipd,ticd_HOSTCLK);
              VitalSignalDelay (PHYEMAC0RXCLK_dly,PHYEMAC0RXCLK_ipd,ticd_PHYEMAC0RXCLK);
              VitalSignalDelay (PHYEMAC1RXCLK_dly,PHYEMAC1RXCLK_ipd,ticd_PHYEMAC1RXCLK);
              VitalSignalDelay (PHYEMAC0MCLKIN_dly,PHYEMAC0MCLKIN_ipd,ticd_PHYEMAC0MCLKIN);
              VitalSignalDelay (PHYEMAC1MCLKIN_dly,PHYEMAC1MCLKIN_ipd,ticd_PHYEMAC1MCLKIN);                                          
       end block;

   DCREMACENABLE_dly <= DCREMACENABLE_ipd;
   PHYEMAC0PHYAD_dly <= PHYEMAC0PHYAD_ipd;
   PHYEMAC0SIGNALDET_dly <= PHYEMAC0SIGNALDET_ipd;
   PHYEMAC1PHYAD_dly <= PHYEMAC1PHYAD_ipd;
   PHYEMAC1SIGNALDET_dly <= PHYEMAC1SIGNALDET_ipd;
   RESET_dly <= RESET_ipd;
   TIEEMAC0UNICASTADDR_dly <= TIEEMAC0UNICASTADDR_ipd;
   TIEEMAC1UNICASTADDR_dly <= TIEEMAC1UNICASTADDR_ipd;
   DCREMACWRITE_dly <= DCREMACWRITE_ipd;
   DCREMACREAD_dly <= DCREMACREAD_ipd;
   DCREMACDBUS_dly <= DCREMACDBUS_ipd;
   DCREMACABUS_dly <= DCREMACABUS_ipd;
   DCREMACCLK_dly <= DCREMACCLK_ipd;
   TIEEMAC0CONFIGVEC_dly <= TIEEMAC0CONFIGVEC_ipd;
   TIEEMAC1CONFIGVEC_dly <= TIEEMAC1CONFIGVEC_ipd;
   PHYEMAC0MIITXCLK_dly <= PHYEMAC0MIITXCLK_ipd;
   CLIENTEMAC0RXCLIENTCLKIN_dly <= CLIENTEMAC0RXCLIENTCLKIN_ipd;       
   CLIENTEMAC0TXGMIIMIICLKIN_dly <= CLIENTEMAC0TXGMIIMIICLKIN_ipd;
   PHYEMAC1MIITXCLK_dly <= PHYEMAC1MIITXCLK_ipd;
   CLIENTEMAC1RXCLIENTCLKIN_dly <= CLIENTEMAC1RXCLIENTCLKIN_ipd;
   CLIENTEMAC1TXGMIIMIICLKIN_dly <= CLIENTEMAC1TXGMIIMIICLKIN_ipd;           

   -- CR 455025 Delay EMAC# client input signals in 16-bit client mode
   -- EMAC0
   CLIENTEMAC0TXD_delay <= CLIENTEMAC0TXD_dly after client_in_delay;
   CLIENTEMAC0TXDVLD_delay <= CLIENTEMAC0TXDVLD_dly after client_in_delay;
   CLIENTEMAC0TXDVLDMSW_delay <= CLIENTEMAC0TXDVLDMSW_dly after client_in_delay;

   CLIENTEMAC0TXD_client16_delay       <= CLIENTEMAC0TXD_delay when TIEEMAC0CONFIGVEC(66) = '1' else CLIENTEMAC0TXD_dly;        -- CONFIGVEC[66] is 16-bit Tx client 
   CLIENTEMAC0TXDVLD_client16_delay    <= CLIENTEMAC0TXDVLD_delay when TIEEMAC0CONFIGVEC(66) = '1' else CLIENTEMAC0TXDVLD_dly;  
   CLIENTEMAC0TXDVLDMSW_client16_delay <= CLIENTEMAC0TXDVLDMSW_delay when TIEEMAC0CONFIGVEC(66) = '1' else CLIENTEMAC0TXDVLDMSW_dly;  

   -- EMAC1
   CLIENTEMAC1TXD_delay <= CLIENTEMAC1TXD_dly after client_in_delay;
   CLIENTEMAC1TXDVLD_delay <= CLIENTEMAC1TXDVLD_dly after client_in_delay;
   CLIENTEMAC1TXDVLDMSW_delay <= CLIENTEMAC1TXDVLDMSW_dly after client_in_delay;

   CLIENTEMAC1TXD_client16_delay       <= CLIENTEMAC1TXD_delay when TIEEMAC1CONFIGVEC(66) = '1' else CLIENTEMAC1TXD_dly;        -- CONFIGVEC[66] is 16-bit Tx client 
   CLIENTEMAC1TXDVLD_client16_delay    <= CLIENTEMAC1TXDVLD_delay when TIEEMAC1CONFIGVEC(66) = '1' else CLIENTEMAC1TXDVLD_dly;  
   CLIENTEMAC1TXDVLDMSW_client16_delay <= CLIENTEMAC1TXDVLDMSW_delay when TIEEMAC1CONFIGVEC(66) = '1' else CLIENTEMAC1TXDVLDMSW_dly;  

  --Skew 125 MHz clock EMAC#MIITXCLK against 250 MHz clock in 16-bit client mode
   PHYEMAC0MIITXCLK_delay <= PHYEMAC0MIITXCLK_dly after miitxclk_delay;
   PHYEMAC0MIITXCLK_skewed <= PHYEMAC0MIITXCLK_delay when TIEEMAC0CONFIGVEC(66) = '1' else PHYEMAC0MIITXCLK_dly; -- In TXCLIENT16 mode

   PHYEMAC1MIITXCLK_delay <= PHYEMAC1MIITXCLK_dly after miitxclk_delay;
   PHYEMAC1MIITXCLK_skewed <= PHYEMAC1MIITXCLK_delay when TIEEMAC1CONFIGVEC(66) = '1' else PHYEMAC1MIITXCLK_dly; -- In TXCLIENT16 mode 
    dcremacclk_delay <= DCREMACCLK_dly after 10 ps;

   emac_swift_bw_1 : EMAC_SWIFT
      port map (
          CLIENTEMAC0DCMLOCKED  =>  CLIENTEMAC0DCMLOCKED_dly,
          CLIENTEMAC0PAUSEREQ  =>  CLIENTEMAC0PAUSEREQ_dly,
          CLIENTEMAC0PAUSEVAL  =>  CLIENTEMAC0PAUSEVAL_dly,
          CLIENTEMAC0RXCLIENTCLKIN  =>  CLIENTEMAC0RXCLIENTCLKIN_dly,
          CLIENTEMAC0TXCLIENTCLKIN  =>  CLIENTEMAC0TXCLIENTCLKIN_dly,
          CLIENTEMAC0TXD  =>  CLIENTEMAC0TXD_client16_delay,
          CLIENTEMAC0TXDVLD  =>  CLIENTEMAC0TXDVLD_client16_delay,
          CLIENTEMAC0TXDVLDMSW  =>  CLIENTEMAC0TXDVLDMSW_client16_delay,
          CLIENTEMAC0TXFIRSTBYTE  =>  CLIENTEMAC0TXFIRSTBYTE_dly,
          CLIENTEMAC0TXGMIIMIICLKIN  =>  CLIENTEMAC0TXGMIIMIICLKIN_dly,
          CLIENTEMAC0TXIFGDELAY  =>  CLIENTEMAC0TXIFGDELAY_dly,
          CLIENTEMAC0TXUNDERRUN  =>  CLIENTEMAC0TXUNDERRUN_dly,
          CLIENTEMAC1DCMLOCKED  =>  CLIENTEMAC1DCMLOCKED_dly,
          CLIENTEMAC1PAUSEREQ  =>  CLIENTEMAC1PAUSEREQ_dly,
          CLIENTEMAC1PAUSEVAL  =>  CLIENTEMAC1PAUSEVAL_dly,
          CLIENTEMAC1RXCLIENTCLKIN  =>  CLIENTEMAC1RXCLIENTCLKIN_dly,
          CLIENTEMAC1TXCLIENTCLKIN  =>  CLIENTEMAC1TXCLIENTCLKIN_dly,
          CLIENTEMAC1TXD  =>  CLIENTEMAC1TXD_client16_delay,
          CLIENTEMAC1TXDVLD  =>  CLIENTEMAC1TXDVLD_client16_delay,
          CLIENTEMAC1TXDVLDMSW  =>  CLIENTEMAC1TXDVLDMSW_client16_delay,
          CLIENTEMAC1TXFIRSTBYTE  =>  CLIENTEMAC1TXFIRSTBYTE_dly,
          CLIENTEMAC1TXGMIIMIICLKIN  =>  CLIENTEMAC1TXGMIIMIICLKIN_dly,
          CLIENTEMAC1TXIFGDELAY  =>  CLIENTEMAC1TXIFGDELAY_dly,
          CLIENTEMAC1TXUNDERRUN  =>  CLIENTEMAC1TXUNDERRUN_dly,
          DCREMACABUS  =>  DCREMACABUS_dly,
          DCREMACCLK  =>  dcremacclk_delay,
          DCREMACDBUS  =>  DCREMACDBUS_dly,
          DCREMACENABLE  =>  DCREMACENABLE_dly,
          DCREMACREAD  =>  DCREMACREAD_dly,
          DCREMACWRITE  =>  DCREMACWRITE_dly,
          DCRHOSTDONEIR  =>  DCRHOSTDONEIR_out,
          EMAC0CLIENTANINTERRUPT  =>  EMAC0CLIENTANINTERRUPT_out,
          EMAC0CLIENTRXBADFRAME  =>  EMAC0CLIENTRXBADFRAME_out,
          EMAC0CLIENTRXCLIENTCLKOUT  =>  EMAC0CLIENTRXCLIENTCLKOUT_out,
          EMAC0CLIENTRXD  =>  EMAC0CLIENTRXD_out,
          EMAC0CLIENTRXDVLD  =>  EMAC0CLIENTRXDVLD_out,
          EMAC0CLIENTRXDVLDMSW  =>  EMAC0CLIENTRXDVLDMSW_out,
          EMAC0CLIENTRXDVREG6  =>  EMAC0CLIENTRXDVREG6_out,
          EMAC0CLIENTRXFRAMEDROP  =>  EMAC0CLIENTRXFRAMEDROP_out,
          EMAC0CLIENTRXGOODFRAME  =>  EMAC0CLIENTRXGOODFRAME_out,
          EMAC0CLIENTRXSTATS  =>  EMAC0CLIENTRXSTATS_out,
          EMAC0CLIENTRXSTATSBYTEVLD  =>  EMAC0CLIENTRXSTATSBYTEVLD_out,
          EMAC0CLIENTRXSTATSVLD  =>  EMAC0CLIENTRXSTATSVLD_out,
          EMAC0CLIENTTXACK  =>  EMAC0CLIENTTXACK_out,
          EMAC0CLIENTTXCLIENTCLKOUT  =>  EMAC0CLIENTTXCLIENTCLKOUT_out,
          EMAC0CLIENTTXCOLLISION  =>  EMAC0CLIENTTXCOLLISION_out,
          EMAC0CLIENTTXGMIIMIICLKOUT  =>  EMAC0CLIENTTXGMIIMIICLKOUT_out,
          EMAC0CLIENTTXRETRANSMIT  =>  EMAC0CLIENTTXRETRANSMIT_out,
          EMAC0CLIENTTXSTATS  =>  EMAC0CLIENTTXSTATS_out,
          EMAC0CLIENTTXSTATSBYTEVLD  =>  EMAC0CLIENTTXSTATSBYTEVLD_out,
          EMAC0CLIENTTXSTATSVLD  =>  EMAC0CLIENTTXSTATSVLD_out,
          EMAC0PHYENCOMMAALIGN  =>  EMAC0PHYENCOMMAALIGN_out,
          EMAC0PHYLOOPBACKMSB  =>  EMAC0PHYLOOPBACKMSB_out,
          EMAC0PHYMCLKOUT  =>  EMAC0PHYMCLKOUT_out,
          EMAC0PHYMDOUT  =>  EMAC0PHYMDOUT_out,
          EMAC0PHYMDTRI  =>  EMAC0PHYMDTRI_out,
          EMAC0PHYMGTRXRESET  =>  EMAC0PHYMGTRXRESET_out,
          EMAC0PHYMGTTXRESET  =>  EMAC0PHYMGTTXRESET_out,
          EMAC0PHYPOWERDOWN  =>  EMAC0PHYPOWERDOWN_out,
          EMAC0PHYSYNCACQSTATUS  =>  EMAC0PHYSYNCACQSTATUS_out,
          EMAC0PHYTXCHARDISPMODE  =>  EMAC0PHYTXCHARDISPMODE_out,
          EMAC0PHYTXCHARDISPVAL  =>  EMAC0PHYTXCHARDISPVAL_out,
          EMAC0PHYTXCHARISK  =>  EMAC0PHYTXCHARISK_out,
          EMAC0PHYTXCLK  =>  EMAC0PHYTXCLK_out,
          EMAC0PHYTXD  =>  EMAC0PHYTXD_out,
          EMAC0PHYTXEN  =>  EMAC0PHYTXEN_out,
          EMAC0PHYTXER  =>  EMAC0PHYTXER_out,
          EMAC1CLIENTANINTERRUPT  =>  EMAC1CLIENTANINTERRUPT_out,
          EMAC1CLIENTRXBADFRAME  =>  EMAC1CLIENTRXBADFRAME_out,
          EMAC1CLIENTRXCLIENTCLKOUT  =>  EMAC1CLIENTRXCLIENTCLKOUT_out,
          EMAC1CLIENTRXD  =>  EMAC1CLIENTRXD_out,
          EMAC1CLIENTRXDVLD  =>  EMAC1CLIENTRXDVLD_out,
          EMAC1CLIENTRXDVLDMSW  =>  EMAC1CLIENTRXDVLDMSW_out,
          EMAC1CLIENTRXDVREG6  =>  EMAC1CLIENTRXDVREG6_out,
          EMAC1CLIENTRXFRAMEDROP  =>  EMAC1CLIENTRXFRAMEDROP_out,
          EMAC1CLIENTRXGOODFRAME  =>  EMAC1CLIENTRXGOODFRAME_out,
          EMAC1CLIENTRXSTATS  =>  EMAC1CLIENTRXSTATS_out,
          EMAC1CLIENTRXSTATSBYTEVLD  =>  EMAC1CLIENTRXSTATSBYTEVLD_out,
          EMAC1CLIENTRXSTATSVLD  =>  EMAC1CLIENTRXSTATSVLD_out,
          EMAC1CLIENTTXACK  =>  EMAC1CLIENTTXACK_out,
          EMAC1CLIENTTXCLIENTCLKOUT  =>  EMAC1CLIENTTXCLIENTCLKOUT_out,
          EMAC1CLIENTTXCOLLISION  =>  EMAC1CLIENTTXCOLLISION_out,
          EMAC1CLIENTTXGMIIMIICLKOUT  =>  EMAC1CLIENTTXGMIIMIICLKOUT_out,
          EMAC1CLIENTTXRETRANSMIT  =>  EMAC1CLIENTTXRETRANSMIT_out,
          EMAC1CLIENTTXSTATS  =>  EMAC1CLIENTTXSTATS_out,
          EMAC1CLIENTTXSTATSBYTEVLD  =>  EMAC1CLIENTTXSTATSBYTEVLD_out,
          EMAC1CLIENTTXSTATSVLD  =>  EMAC1CLIENTTXSTATSVLD_out,
          EMAC1PHYENCOMMAALIGN  =>  EMAC1PHYENCOMMAALIGN_out,
          EMAC1PHYLOOPBACKMSB  =>  EMAC1PHYLOOPBACKMSB_out,
          EMAC1PHYMCLKOUT  =>  EMAC1PHYMCLKOUT_out,
          EMAC1PHYMDOUT  =>  EMAC1PHYMDOUT_out,
          EMAC1PHYMDTRI  =>  EMAC1PHYMDTRI_out,
          EMAC1PHYMGTRXRESET  =>  EMAC1PHYMGTRXRESET_out,
          EMAC1PHYMGTTXRESET  =>  EMAC1PHYMGTTXRESET_out,
          EMAC1PHYPOWERDOWN  =>  EMAC1PHYPOWERDOWN_out,
          EMAC1PHYSYNCACQSTATUS  =>  EMAC1PHYSYNCACQSTATUS_out,
          EMAC1PHYTXCHARDISPMODE  =>  EMAC1PHYTXCHARDISPMODE_out,
          EMAC1PHYTXCHARDISPVAL  =>  EMAC1PHYTXCHARDISPVAL_out,
          EMAC1PHYTXCHARISK  =>  EMAC1PHYTXCHARISK_out,
          EMAC1PHYTXCLK  =>  EMAC1PHYTXCLK_out,
          EMAC1PHYTXD  =>  EMAC1PHYTXD_out,
          EMAC1PHYTXEN  =>  EMAC1PHYTXEN_out,
          EMAC1PHYTXER  =>  EMAC1PHYTXER_out,
          EMACDCRACK  =>  EMACDCRACK_out,
          EMACDCRDBUS  =>  EMACDCRDBUS_out,
          HOSTADDR  =>  HOSTADDR_dly,
          HOSTCLK  =>  HOSTCLK_dly,
          HOSTEMAC1SEL  =>  HOSTEMAC1SEL_dly,
          HOSTMIIMRDY  =>  HOSTMIIMRDY_out,
          HOSTMIIMSEL  =>  HOSTMIIMSEL_dly,
          HOSTOPCODE  =>  HOSTOPCODE_dly,
          HOSTRDDATA  =>  HOSTRDDATA_out,
          HOSTREQ  =>  HOSTREQ_dly,
          HOSTWRDATA  =>  HOSTWRDATA_dly,
          PHYEMAC0COL  =>  PHYEMAC0COL_dly,
          PHYEMAC0CRS  =>  PHYEMAC0CRS_dly,
          PHYEMAC0GTXCLK  =>  PHYEMAC0GTXCLK_dly,
          PHYEMAC0MCLKIN  =>  PHYEMAC0MCLKIN_dly,
          PHYEMAC0MDIN  =>  PHYEMAC0MDIN_dly,
          PHYEMAC0MIITXCLK  =>  PHYEMAC0MIITXCLK_skewed,
          PHYEMAC0PHYAD  =>  PHYEMAC0PHYAD_dly,
          PHYEMAC0RXBUFERR  =>  PHYEMAC0RXBUFERR_dly,
          PHYEMAC0RXBUFSTATUS  =>  PHYEMAC0RXBUFSTATUS_dly,
          PHYEMAC0RXCHARISCOMMA  =>  PHYEMAC0RXCHARISCOMMA_dly,
          PHYEMAC0RXCHARISK  =>  PHYEMAC0RXCHARISK_dly,
          PHYEMAC0RXCHECKINGCRC  =>  PHYEMAC0RXCHECKINGCRC_dly,
          PHYEMAC0RXCLK  =>  PHYEMAC0RXCLK_dly,
          PHYEMAC0RXCLKCORCNT  =>  PHYEMAC0RXCLKCORCNT_dly,
          PHYEMAC0RXCOMMADET  =>  PHYEMAC0RXCOMMADET_dly,
          PHYEMAC0RXD  =>  PHYEMAC0RXD_dly,
          PHYEMAC0RXDISPERR  =>  PHYEMAC0RXDISPERR_dly,
          PHYEMAC0RXDV  =>  PHYEMAC0RXDV_dly,
          PHYEMAC0RXER  =>  PHYEMAC0RXER_dly,
          PHYEMAC0RXLOSSOFSYNC  =>  PHYEMAC0RXLOSSOFSYNC_dly,
          PHYEMAC0RXNOTINTABLE  =>  PHYEMAC0RXNOTINTABLE_dly,
          PHYEMAC0RXRUNDISP  =>  PHYEMAC0RXRUNDISP_dly,
          PHYEMAC0SIGNALDET  =>  PHYEMAC0SIGNALDET_dly,
          PHYEMAC0TXBUFERR  =>  PHYEMAC0TXBUFERR_dly,
          PHYEMAC1COL  =>  PHYEMAC1COL_dly,
          PHYEMAC1CRS  =>  PHYEMAC1CRS_dly,
          PHYEMAC1GTXCLK  =>  PHYEMAC1GTXCLK_dly,
          PHYEMAC1MCLKIN  =>  PHYEMAC1MCLKIN_dly,
          PHYEMAC1MDIN  =>  PHYEMAC1MDIN_dly,
          PHYEMAC1MIITXCLK  =>  PHYEMAC1MIITXCLK_skewed,
          PHYEMAC1PHYAD  =>  PHYEMAC1PHYAD_dly,
          PHYEMAC1RXBUFERR  =>  PHYEMAC1RXBUFERR_dly,
          PHYEMAC1RXBUFSTATUS  =>  PHYEMAC1RXBUFSTATUS_dly,
          PHYEMAC1RXCHARISCOMMA  =>  PHYEMAC1RXCHARISCOMMA_dly,
          PHYEMAC1RXCHARISK  =>  PHYEMAC1RXCHARISK_dly,
          PHYEMAC1RXCHECKINGCRC  =>  PHYEMAC1RXCHECKINGCRC_dly,
          PHYEMAC1RXCLK  =>  PHYEMAC1RXCLK_dly,
          PHYEMAC1RXCLKCORCNT  =>  PHYEMAC1RXCLKCORCNT_dly,
          PHYEMAC1RXCOMMADET  =>  PHYEMAC1RXCOMMADET_dly,
          PHYEMAC1RXD  =>  PHYEMAC1RXD_dly,
          PHYEMAC1RXDISPERR  =>  PHYEMAC1RXDISPERR_dly,
          PHYEMAC1RXDV  =>  PHYEMAC1RXDV_dly,
          PHYEMAC1RXER  =>  PHYEMAC1RXER_dly,
          PHYEMAC1RXLOSSOFSYNC  =>  PHYEMAC1RXLOSSOFSYNC_dly,
          PHYEMAC1RXNOTINTABLE  =>  PHYEMAC1RXNOTINTABLE_dly,
          PHYEMAC1RXRUNDISP  =>  PHYEMAC1RXRUNDISP_dly,
          PHYEMAC1SIGNALDET  =>  PHYEMAC1SIGNALDET_dly,
          PHYEMAC1TXBUFERR  =>  PHYEMAC1TXBUFERR_dly,
          RESET  =>  RESET_dly,
          TIEEMAC0CONFIGVEC  =>  TIEEMAC0CONFIGVEC_dly,
          TIEEMAC0UNICASTADDR  =>  TIEEMAC0UNICASTADDR_dly,
          TIEEMAC1CONFIGVEC  =>  TIEEMAC1CONFIGVEC_dly,
          TIEEMAC1UNICASTADDR  =>  TIEEMAC1UNICASTADDR_dly

      );

   TIMING : process

--  Pin timing violations (clock input pins)

--  Pin Timing Violations (all input pins)
     variable Tviol_CLIENTEMAC0DCMLOCKED_PHYEMAC0GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0DCMLOCKED_PHYEMAC0GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0PAUSEREQ_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0PAUSEREQ_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0PAUSEVAL0_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0PAUSEVAL0_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0PAUSEVAL1_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0PAUSEVAL1_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0PAUSEVAL2_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0PAUSEVAL2_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0PAUSEVAL3_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0PAUSEVAL3_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0PAUSEVAL4_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0PAUSEVAL4_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0PAUSEVAL5_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0PAUSEVAL5_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0PAUSEVAL6_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0PAUSEVAL6_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0PAUSEVAL7_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0PAUSEVAL7_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0PAUSEVAL8_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0PAUSEVAL8_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0PAUSEVAL9_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0PAUSEVAL9_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0PAUSEVAL10_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0PAUSEVAL10_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0PAUSEVAL11_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0PAUSEVAL11_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0PAUSEVAL12_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0PAUSEVAL12_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0PAUSEVAL13_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0PAUSEVAL13_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0PAUSEVAL14_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0PAUSEVAL14_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0PAUSEVAL15_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0PAUSEVAL15_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0TXD0_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0TXD0_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0TXD1_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0TXD1_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0TXD2_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0TXD2_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0TXD3_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0TXD3_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0TXD4_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0TXD4_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0TXD5_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0TXD5_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0TXD6_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0TXD6_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0TXD7_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0TXD7_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0TXD8_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0TXD8_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0TXD9_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0TXD9_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0TXD10_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0TXD10_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0TXD11_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0TXD11_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0TXD12_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0TXD12_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0TXD13_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0TXD13_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0TXD14_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0TXD14_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0TXD15_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0TXD15_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0TXDVLD_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0TXDVLD_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0TXDVLDMSW_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0TXDVLDMSW_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0TXFIRSTBYTE_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0TXFIRSTBYTE_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0TXIFGDELAY0_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0TXIFGDELAY0_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0TXIFGDELAY1_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0TXIFGDELAY1_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0TXIFGDELAY2_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0TXIFGDELAY2_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0TXIFGDELAY3_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0TXIFGDELAY3_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0TXIFGDELAY4_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0TXIFGDELAY4_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0TXIFGDELAY5_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0TXIFGDELAY5_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0TXIFGDELAY6_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0TXIFGDELAY6_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0TXIFGDELAY7_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0TXIFGDELAY7_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC0TXUNDERRUN_CLIENTEMAC0TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC0TXUNDERRUN_CLIENTEMAC0TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1DCMLOCKED_PHYEMAC1GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1DCMLOCKED_PHYEMAC1GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1PAUSEREQ_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1PAUSEREQ_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1PAUSEVAL0_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1PAUSEVAL0_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1PAUSEVAL1_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1PAUSEVAL1_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1PAUSEVAL2_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1PAUSEVAL2_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1PAUSEVAL3_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1PAUSEVAL3_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1PAUSEVAL4_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1PAUSEVAL4_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1PAUSEVAL5_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1PAUSEVAL5_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1PAUSEVAL6_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1PAUSEVAL6_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1PAUSEVAL7_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1PAUSEVAL7_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1PAUSEVAL8_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1PAUSEVAL8_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1PAUSEVAL9_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1PAUSEVAL9_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1PAUSEVAL10_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1PAUSEVAL10_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1PAUSEVAL11_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1PAUSEVAL11_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1PAUSEVAL12_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1PAUSEVAL12_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1PAUSEVAL13_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1PAUSEVAL13_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1PAUSEVAL14_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1PAUSEVAL14_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1PAUSEVAL15_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1PAUSEVAL15_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1TXD0_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1TXD0_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1TXD1_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1TXD1_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1TXD2_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1TXD2_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1TXD3_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1TXD3_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1TXD4_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1TXD4_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1TXD5_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1TXD5_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1TXD6_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1TXD6_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1TXD7_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1TXD7_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1TXD8_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1TXD8_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1TXD9_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1TXD9_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1TXD10_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1TXD10_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1TXD11_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1TXD11_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1TXD12_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1TXD12_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1TXD13_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1TXD13_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1TXD14_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1TXD14_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1TXD15_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1TXD15_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1TXDVLD_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1TXDVLD_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1TXDVLDMSW_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1TXDVLDMSW_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1TXFIRSTBYTE_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1TXFIRSTBYTE_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1TXIFGDELAY0_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1TXIFGDELAY0_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1TXIFGDELAY1_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1TXIFGDELAY1_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1TXIFGDELAY2_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1TXIFGDELAY2_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1TXIFGDELAY3_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1TXIFGDELAY3_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1TXIFGDELAY4_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1TXIFGDELAY4_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1TXIFGDELAY5_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1TXIFGDELAY5_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1TXIFGDELAY6_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1TXIFGDELAY6_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1TXIFGDELAY7_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1TXIFGDELAY7_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_CLIENTEMAC1TXUNDERRUN_CLIENTEMAC1TXCLIENTCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_CLIENTEMAC1TXUNDERRUN_CLIENTEMAC1TXCLIENTCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTADDR0_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTADDR0_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTADDR1_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTADDR1_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTADDR2_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTADDR2_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTADDR3_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTADDR3_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTADDR4_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTADDR4_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTADDR5_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTADDR5_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTADDR6_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTADDR6_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTADDR7_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTADDR7_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTADDR8_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTADDR8_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTADDR9_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTADDR9_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTEMAC1SEL_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTEMAC1SEL_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTMIIMSEL_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTMIIMSEL_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTOPCODE0_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTOPCODE0_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTOPCODE1_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTOPCODE1_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTREQ_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTREQ_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA0_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA0_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA1_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA1_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA2_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA2_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA3_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA3_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA4_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA4_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA5_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA5_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA6_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA6_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA7_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA7_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA8_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA8_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA9_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA9_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA10_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA10_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA11_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA11_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA12_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA12_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA13_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA13_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA14_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA14_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA15_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA15_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA16_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA16_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA17_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA17_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA18_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA18_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA19_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA19_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA20_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA20_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA21_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA21_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA22_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA22_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA23_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA23_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA24_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA24_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA25_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA25_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA26_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA26_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA27_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA27_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA28_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA28_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA29_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA29_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA30_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA30_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_HOSTWRDATA31_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_HOSTWRDATA31_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC0COL_PHYEMAC0RXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC0COL_PHYEMAC0RXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC0CRS_PHYEMAC0RXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC0CRS_PHYEMAC0RXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC0MDIN_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC0MDIN_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC0MDIN_PHYEMAC0MCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC0MDIN_PHYEMAC0MCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC0RXBUFERR_PHYEMAC0GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC0RXBUFERR_PHYEMAC0GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC0RXBUFSTATUS0_PHYEMAC0GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC0RXBUFSTATUS0_PHYEMAC0GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC0RXBUFSTATUS1_PHYEMAC0GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC0RXBUFSTATUS1_PHYEMAC0GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC0RXCHARISCOMMA_PHYEMAC0GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC0RXCHARISCOMMA_PHYEMAC0GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC0RXCHARISK_PHYEMAC0GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC0RXCHARISK_PHYEMAC0GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC0RXCHECKINGCRC_PHYEMAC0GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC0RXCHECKINGCRC_PHYEMAC0GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC0RXCLKCORCNT0_PHYEMAC0GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC0RXCLKCORCNT0_PHYEMAC0GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC0RXCLKCORCNT1_PHYEMAC0GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC0RXCLKCORCNT1_PHYEMAC0GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC0RXCLKCORCNT2_PHYEMAC0GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC0RXCLKCORCNT2_PHYEMAC0GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC0RXCOMMADET_PHYEMAC0GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC0RXCOMMADET_PHYEMAC0GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC0RXD0_PHYEMAC0RXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC0RXD0_PHYEMAC0RXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC0RXD1_PHYEMAC0RXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC0RXD1_PHYEMAC0RXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC0RXD2_PHYEMAC0RXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC0RXD2_PHYEMAC0RXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC0RXD3_PHYEMAC0RXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC0RXD3_PHYEMAC0RXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC0RXD4_PHYEMAC0RXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC0RXD4_PHYEMAC0RXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC0RXD5_PHYEMAC0RXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC0RXD5_PHYEMAC0RXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC0RXD6_PHYEMAC0RXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC0RXD6_PHYEMAC0RXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC0RXD7_PHYEMAC0RXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC0RXD7_PHYEMAC0RXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC0RXDISPERR_PHYEMAC0GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC0RXDISPERR_PHYEMAC0GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC0RXDV_PHYEMAC0RXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC0RXDV_PHYEMAC0RXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC0RXER_PHYEMAC0RXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC0RXER_PHYEMAC0RXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC0RXLOSSOFSYNC0_PHYEMAC0GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC0RXLOSSOFSYNC0_PHYEMAC0GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC0RXLOSSOFSYNC1_PHYEMAC0GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC0RXLOSSOFSYNC1_PHYEMAC0GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC0RXNOTINTABLE_PHYEMAC0GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC0RXNOTINTABLE_PHYEMAC0GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC0RXRUNDISP_PHYEMAC0GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC0RXRUNDISP_PHYEMAC0GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC0TXBUFERR_PHYEMAC0GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC0TXBUFERR_PHYEMAC0GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC1COL_PHYEMAC1RXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC1COL_PHYEMAC1RXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC1CRS_PHYEMAC1RXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC1CRS_PHYEMAC1RXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC1MDIN_HOSTCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC1MDIN_HOSTCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC1MDIN_PHYEMAC1MCLKIN_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC1MDIN_PHYEMAC1MCLKIN_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC1RXBUFERR_PHYEMAC1GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC1RXBUFERR_PHYEMAC1GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC1RXBUFSTATUS0_PHYEMAC1GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC1RXBUFSTATUS0_PHYEMAC1GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC1RXBUFSTATUS1_PHYEMAC1GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC1RXBUFSTATUS1_PHYEMAC1GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC1RXCHARISCOMMA_PHYEMAC1GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC1RXCHARISCOMMA_PHYEMAC1GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC1RXCHARISK_PHYEMAC1GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC1RXCHARISK_PHYEMAC1GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC1RXCHECKINGCRC_PHYEMAC1GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC1RXCHECKINGCRC_PHYEMAC1GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC1RXCLKCORCNT0_PHYEMAC1GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC1RXCLKCORCNT0_PHYEMAC1GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC1RXCLKCORCNT1_PHYEMAC1GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC1RXCLKCORCNT1_PHYEMAC1GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC1RXCLKCORCNT2_PHYEMAC1GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC1RXCLKCORCNT2_PHYEMAC1GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC1RXCOMMADET_PHYEMAC1GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC1RXCOMMADET_PHYEMAC1GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC1RXD0_PHYEMAC1RXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC1RXD0_PHYEMAC1RXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC1RXD1_PHYEMAC1RXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC1RXD1_PHYEMAC1RXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC1RXD2_PHYEMAC1RXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC1RXD2_PHYEMAC1RXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC1RXD3_PHYEMAC1RXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC1RXD3_PHYEMAC1RXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC1RXD4_PHYEMAC1RXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC1RXD4_PHYEMAC1RXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC1RXD5_PHYEMAC1RXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC1RXD5_PHYEMAC1RXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC1RXD6_PHYEMAC1RXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC1RXD6_PHYEMAC1RXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC1RXD7_PHYEMAC1RXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC1RXD7_PHYEMAC1RXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC1RXDISPERR_PHYEMAC1GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC1RXDISPERR_PHYEMAC1GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC1RXDV_PHYEMAC1RXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC1RXDV_PHYEMAC1RXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC1RXER_PHYEMAC1RXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC1RXER_PHYEMAC1RXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC1RXLOSSOFSYNC0_PHYEMAC1GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC1RXLOSSOFSYNC0_PHYEMAC1GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC1RXLOSSOFSYNC1_PHYEMAC1GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC1RXLOSSOFSYNC1_PHYEMAC1GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC1RXNOTINTABLE_PHYEMAC1GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC1RXNOTINTABLE_PHYEMAC1GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC1RXRUNDISP_PHYEMAC1GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC1RXRUNDISP_PHYEMAC1GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_PHYEMAC1TXBUFERR_PHYEMAC1GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_PHYEMAC1TXBUFERR_PHYEMAC1GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TIEEMAC0CONFIGVEC74_PHYEMAC0GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TIEEMAC0CONFIGVEC74_PHYEMAC0GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TIEEMAC0CONFIGVEC75_PHYEMAC0GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TIEEMAC0CONFIGVEC75_PHYEMAC0GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TIEEMAC0CONFIGVEC76_PHYEMAC0GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TIEEMAC0CONFIGVEC76_PHYEMAC0GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TIEEMAC0CONFIGVEC77_PHYEMAC0GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TIEEMAC0CONFIGVEC77_PHYEMAC0GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TIEEMAC0CONFIGVEC78_PHYEMAC0GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TIEEMAC0CONFIGVEC78_PHYEMAC0GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TIEEMAC1CONFIGVEC74_PHYEMAC1GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TIEEMAC1CONFIGVEC74_PHYEMAC1GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TIEEMAC1CONFIGVEC75_PHYEMAC1GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TIEEMAC1CONFIGVEC75_PHYEMAC1GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TIEEMAC1CONFIGVEC76_PHYEMAC1GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TIEEMAC1CONFIGVEC76_PHYEMAC1GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TIEEMAC1CONFIGVEC77_PHYEMAC1GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TIEEMAC1CONFIGVEC77_PHYEMAC1GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;
     variable Tviol_TIEEMAC1CONFIGVEC78_PHYEMAC1GTXCLK_posedge : STD_ULOGIC := '0';
     variable  Tmkr_TIEEMAC1CONFIGVEC78_PHYEMAC1GTXCLK_posedge : VitalTimingDataType := VitalTimingDataInit;

--  Output Pin glitch declaration
     variable  DCRHOSTDONEIR_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTANINTERRUPT_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXBADFRAME_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXCLIENTCLKOUT_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXD0_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXD1_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXD2_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXD3_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXD4_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXD5_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXD6_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXD7_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXD8_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXD9_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXD10_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXD11_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXD12_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXD13_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXD14_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXD15_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXDVLD_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXDVLDMSW_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXDVREG6_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXFRAMEDROP_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXGOODFRAME_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXSTATS0_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXSTATS1_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXSTATS2_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXSTATS3_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXSTATS4_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXSTATS5_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXSTATS6_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXSTATSBYTEVLD_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTRXSTATSVLD_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTTXACK_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTTXCLIENTCLKOUT_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTTXCOLLISION_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTTXGMIIMIICLKOUT_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTTXRETRANSMIT_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTTXSTATS_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTTXSTATSBYTEVLD_GlitchData : VitalGlitchDataType;
     variable  EMAC0CLIENTTXSTATSVLD_GlitchData : VitalGlitchDataType;
     variable  EMAC0PHYENCOMMAALIGN_GlitchData : VitalGlitchDataType;
     variable  EMAC0PHYLOOPBACKMSB_GlitchData : VitalGlitchDataType;
     variable  EMAC0PHYMCLKOUT_GlitchData : VitalGlitchDataType;
     variable  EMAC0PHYMDOUT_GlitchData : VitalGlitchDataType;
     variable  EMAC0PHYMDTRI_GlitchData : VitalGlitchDataType;
     variable  EMAC0PHYMGTRXRESET_GlitchData : VitalGlitchDataType;
     variable  EMAC0PHYMGTTXRESET_GlitchData : VitalGlitchDataType;
     variable  EMAC0PHYPOWERDOWN_GlitchData : VitalGlitchDataType;
     variable  EMAC0PHYSYNCACQSTATUS_GlitchData : VitalGlitchDataType;
     variable  EMAC0PHYTXCHARDISPMODE_GlitchData : VitalGlitchDataType;
     variable  EMAC0PHYTXCHARDISPVAL_GlitchData : VitalGlitchDataType;
     variable  EMAC0PHYTXCHARISK_GlitchData : VitalGlitchDataType;
     variable  EMAC0PHYTXCLK_GlitchData : VitalGlitchDataType;
     variable  EMAC0PHYTXD0_GlitchData : VitalGlitchDataType;
     variable  EMAC0PHYTXD1_GlitchData : VitalGlitchDataType;
     variable  EMAC0PHYTXD2_GlitchData : VitalGlitchDataType;
     variable  EMAC0PHYTXD3_GlitchData : VitalGlitchDataType;
     variable  EMAC0PHYTXD4_GlitchData : VitalGlitchDataType;
     variable  EMAC0PHYTXD5_GlitchData : VitalGlitchDataType;
     variable  EMAC0PHYTXD6_GlitchData : VitalGlitchDataType;
     variable  EMAC0PHYTXD7_GlitchData : VitalGlitchDataType;
     variable  EMAC0PHYTXEN_GlitchData : VitalGlitchDataType;
     variable  EMAC0PHYTXER_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTANINTERRUPT_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXBADFRAME_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXCLIENTCLKOUT_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXD0_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXD1_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXD2_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXD3_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXD4_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXD5_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXD6_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXD7_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXD8_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXD9_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXD10_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXD11_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXD12_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXD13_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXD14_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXD15_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXDVLD_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXDVLDMSW_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXDVREG6_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXFRAMEDROP_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXGOODFRAME_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXSTATS0_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXSTATS1_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXSTATS2_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXSTATS3_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXSTATS4_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXSTATS5_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXSTATS6_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXSTATSBYTEVLD_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTRXSTATSVLD_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTTXACK_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTTXCLIENTCLKOUT_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTTXCOLLISION_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTTXGMIIMIICLKOUT_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTTXRETRANSMIT_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTTXSTATS_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTTXSTATSBYTEVLD_GlitchData : VitalGlitchDataType;
     variable  EMAC1CLIENTTXSTATSVLD_GlitchData : VitalGlitchDataType;
     variable  EMAC1PHYENCOMMAALIGN_GlitchData : VitalGlitchDataType;
     variable  EMAC1PHYLOOPBACKMSB_GlitchData : VitalGlitchDataType;
     variable  EMAC1PHYMCLKOUT_GlitchData : VitalGlitchDataType;
     variable  EMAC1PHYMDOUT_GlitchData : VitalGlitchDataType;
     variable  EMAC1PHYMDTRI_GlitchData : VitalGlitchDataType;
     variable  EMAC1PHYMGTRXRESET_GlitchData : VitalGlitchDataType;
     variable  EMAC1PHYMGTTXRESET_GlitchData : VitalGlitchDataType;
     variable  EMAC1PHYPOWERDOWN_GlitchData : VitalGlitchDataType;
     variable  EMAC1PHYSYNCACQSTATUS_GlitchData : VitalGlitchDataType;
     variable  EMAC1PHYTXCHARDISPMODE_GlitchData : VitalGlitchDataType;
     variable  EMAC1PHYTXCHARDISPVAL_GlitchData : VitalGlitchDataType;
     variable  EMAC1PHYTXCHARISK_GlitchData : VitalGlitchDataType;
     variable  EMAC1PHYTXCLK_GlitchData : VitalGlitchDataType;
     variable  EMAC1PHYTXD0_GlitchData : VitalGlitchDataType;
     variable  EMAC1PHYTXD1_GlitchData : VitalGlitchDataType;
     variable  EMAC1PHYTXD2_GlitchData : VitalGlitchDataType;
     variable  EMAC1PHYTXD3_GlitchData : VitalGlitchDataType;
     variable  EMAC1PHYTXD4_GlitchData : VitalGlitchDataType;
     variable  EMAC1PHYTXD5_GlitchData : VitalGlitchDataType;
     variable  EMAC1PHYTXD6_GlitchData : VitalGlitchDataType;
     variable  EMAC1PHYTXD7_GlitchData : VitalGlitchDataType;
     variable  EMAC1PHYTXEN_GlitchData : VitalGlitchDataType;
     variable  EMAC1PHYTXER_GlitchData : VitalGlitchDataType;
     variable  HOSTMIIMRDY_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA0_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA1_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA2_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA3_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA4_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA5_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA6_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA7_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA8_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA9_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA10_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA11_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA12_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA13_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA14_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA15_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA16_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA17_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA18_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA19_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA20_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA21_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA22_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA23_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA24_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA25_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA26_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA27_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA28_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA29_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA30_GlitchData : VitalGlitchDataType;
     variable  HOSTRDDATA31_GlitchData : VitalGlitchDataType;
     variable  EMACDCRACK_GlitchData : VitalGlitchDataType;
begin
  

--  Setup/Hold Check Violations (all input pins)

     if (TimingChecksOn) then
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0DCMLOCKED_PHYEMAC0GTXCLK_posedge,
         TimingData     => Tmkr_CLIENTEMAC0DCMLOCKED_PHYEMAC0GTXCLK_posedge,
         TestSignal     => CLIENTEMAC0DCMLOCKED,
         TestSignalName => "CLIENTEMAC0DCMLOCKED",
         TestDelay      => 0 ns,
         RefSignal      => PHYEMAC0GTXCLK_dly,
         RefSignalName  => "PHYEMAC0GTXCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_CLIENTEMAC0DCMLOCKED_PHYEMAC0GTXCLK_posedge_posedge,
         SetupLow       => tsetup_CLIENTEMAC0DCMLOCKED_PHYEMAC0GTXCLK_negedge_posedge,
         HoldLow        => thold_CLIENTEMAC0DCMLOCKED_PHYEMAC0GTXCLK_posedge_posedge,
         HoldHigh       => thold_CLIENTEMAC0DCMLOCKED_PHYEMAC0GTXCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0PAUSEREQ_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0PAUSEREQ_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0PAUSEREQ,
         TestSignalName => "CLIENTEMAC0PAUSEREQ",
         TestDelay      => 0 ns,
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_CLIENTEMAC0PAUSEREQ_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge,
         SetupLow       => tsetup_CLIENTEMAC0PAUSEREQ_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge,
         HoldLow        => thold_CLIENTEMAC0PAUSEREQ_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge,
         HoldHigh       => thold_CLIENTEMAC0PAUSEREQ_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0PAUSEVAL0_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0PAUSEVAL0_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0PAUSEVAL_dly(0),
         TestSignalName => "CLIENTEMAC0PAUSEVAL(0)",
         TestDelay      => tisd_CLIENTEMAC0PAUSEVAL(0),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(0),
         SetupLow       => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(0),
         HoldLow        => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(0),
         HoldHigh       => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0PAUSEVAL1_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0PAUSEVAL1_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0PAUSEVAL_dly(1),
         TestSignalName => "CLIENTEMAC0PAUSEVAL(1)",
         TestDelay      => tisd_CLIENTEMAC0PAUSEVAL(1),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(1),
         SetupLow       => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(1),
         HoldLow        => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(1),
         HoldHigh       => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0PAUSEVAL2_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0PAUSEVAL2_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0PAUSEVAL_dly(2),
         TestSignalName => "CLIENTEMAC0PAUSEVAL(2)",
         TestDelay      => tisd_CLIENTEMAC0PAUSEVAL(2),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(2),
         SetupLow       => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(2),
         HoldLow        => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(2),
         HoldHigh       => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0PAUSEVAL3_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0PAUSEVAL3_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0PAUSEVAL_dly(3),
         TestSignalName => "CLIENTEMAC0PAUSEVAL(3)",
         TestDelay      => tisd_CLIENTEMAC0PAUSEVAL(3),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(3),
         SetupLow       => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(3),
         HoldLow        => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(3),
         HoldHigh       => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(3),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0PAUSEVAL4_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0PAUSEVAL4_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0PAUSEVAL_dly(4),
         TestSignalName => "CLIENTEMAC0PAUSEVAL(4)",
         TestDelay      => tisd_CLIENTEMAC0PAUSEVAL(4),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(4),
         SetupLow       => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(4),
         HoldLow        => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(4),
         HoldHigh       => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(4),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0PAUSEVAL5_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0PAUSEVAL5_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0PAUSEVAL_dly(5),
         TestSignalName => "CLIENTEMAC0PAUSEVAL(5)",
         TestDelay      => tisd_CLIENTEMAC0PAUSEVAL(5),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(5),
         SetupLow       => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(5),
         HoldLow        => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(5),
         HoldHigh       => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(5),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0PAUSEVAL6_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0PAUSEVAL6_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0PAUSEVAL_dly(6),
         TestSignalName => "CLIENTEMAC0PAUSEVAL(6)",
         TestDelay      => tisd_CLIENTEMAC0PAUSEVAL(6),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(6),
         SetupLow       => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(6),
         HoldLow        => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(6),
         HoldHigh       => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(6),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0PAUSEVAL7_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0PAUSEVAL7_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0PAUSEVAL_dly(7),
         TestSignalName => "CLIENTEMAC0PAUSEVAL(7)",
         TestDelay      => tisd_CLIENTEMAC0PAUSEVAL(7),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(7),
         SetupLow       => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(7),
         HoldLow        => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(7),
         HoldHigh       => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(7),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0PAUSEVAL8_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0PAUSEVAL8_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0PAUSEVAL_dly(8),
         TestSignalName => "CLIENTEMAC0PAUSEVAL(8)",
         TestDelay      => tisd_CLIENTEMAC0PAUSEVAL(8),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(8),
         SetupLow       => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(8),
         HoldLow        => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(8),
         HoldHigh       => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(8),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0PAUSEVAL9_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0PAUSEVAL9_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0PAUSEVAL_dly(9),
         TestSignalName => "CLIENTEMAC0PAUSEVAL(9)",
         TestDelay      => tisd_CLIENTEMAC0PAUSEVAL(9),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(9),
         SetupLow       => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(9),
         HoldLow        => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(9),
         HoldHigh       => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(9),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0PAUSEVAL10_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0PAUSEVAL10_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0PAUSEVAL_dly(10),
         TestSignalName => "CLIENTEMAC0PAUSEVAL(10)",
         TestDelay      => tisd_CLIENTEMAC0PAUSEVAL(10),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(10),
         SetupLow       => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(10),
         HoldLow        => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(10),
         HoldHigh       => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(10),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0PAUSEVAL11_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0PAUSEVAL11_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0PAUSEVAL_dly(11),
         TestSignalName => "CLIENTEMAC0PAUSEVAL(11)",
         TestDelay      => tisd_CLIENTEMAC0PAUSEVAL(11),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(11),
         SetupLow       => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(11),
         HoldLow        => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(11),
         HoldHigh       => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(11),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0PAUSEVAL12_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0PAUSEVAL12_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0PAUSEVAL_dly(12),
         TestSignalName => "CLIENTEMAC0PAUSEVAL(12)",
         TestDelay      => tisd_CLIENTEMAC0PAUSEVAL(12),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(12),
         SetupLow       => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(12),
         HoldLow        => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(12),
         HoldHigh       => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(12),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0PAUSEVAL13_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0PAUSEVAL13_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0PAUSEVAL_dly(13),
         TestSignalName => "CLIENTEMAC0PAUSEVAL(13)",
         TestDelay      => tisd_CLIENTEMAC0PAUSEVAL(13),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(13),
         SetupLow       => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(13),
         HoldLow        => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(13),
         HoldHigh       => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(13),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0PAUSEVAL14_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0PAUSEVAL14_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0PAUSEVAL_dly(14),
         TestSignalName => "CLIENTEMAC0PAUSEVAL(14)",
         TestDelay      => tisd_CLIENTEMAC0PAUSEVAL(14),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(14),
         SetupLow       => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(14),
         HoldLow        => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(14),
         HoldHigh       => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(14),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0PAUSEVAL15_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0PAUSEVAL15_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0PAUSEVAL_dly(15),
         TestSignalName => "CLIENTEMAC0PAUSEVAL(15)",
         TestDelay      => tisd_CLIENTEMAC0PAUSEVAL(15),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(15),
         SetupLow       => tsetup_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(15),
         HoldLow        => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(15),
         HoldHigh       => thold_CLIENTEMAC0PAUSEVAL_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(15),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0TXD0_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0TXD0_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0TXD_dly(0),
         TestSignalName => "CLIENTEMAC0TXD(0)",
         TestDelay      => tisd_CLIENTEMAC0TXD(0),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(0),
         SetupLow       => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(0),
         HoldLow        => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(0),
         HoldHigh       => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0TXD1_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0TXD1_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0TXD_dly(1),
         TestSignalName => "CLIENTEMAC0TXD(1)",
         TestDelay      => tisd_CLIENTEMAC0TXD(1),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(1),
         SetupLow       => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(1),
         HoldLow        => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(1),
         HoldHigh       => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0TXD2_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0TXD2_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0TXD_dly(2),
         TestSignalName => "CLIENTEMAC0TXD(2)",
         TestDelay      => tisd_CLIENTEMAC0TXD(2),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(2),
         SetupLow       => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(2),
         HoldLow        => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(2),
         HoldHigh       => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0TXD3_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0TXD3_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0TXD_dly(3),
         TestSignalName => "CLIENTEMAC0TXD(3)",
         TestDelay      => tisd_CLIENTEMAC0TXD(3),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(3),
         SetupLow       => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(3),
         HoldLow        => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(3),
         HoldHigh       => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(3),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0TXD4_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0TXD4_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0TXD_dly(4),
         TestSignalName => "CLIENTEMAC0TXD(4)",
         TestDelay      => tisd_CLIENTEMAC0TXD(4),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(4),
         SetupLow       => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(4),
         HoldLow        => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(4),
         HoldHigh       => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(4),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0TXD5_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0TXD5_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0TXD_dly(5),
         TestSignalName => "CLIENTEMAC0TXD(5)",
         TestDelay      => tisd_CLIENTEMAC0TXD(5),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(5),
         SetupLow       => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(5),
         HoldLow        => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(5),
         HoldHigh       => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(5),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0TXD6_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0TXD6_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0TXD_dly(6),
         TestSignalName => "CLIENTEMAC0TXD(6)",
         TestDelay      => tisd_CLIENTEMAC0TXD(6),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(6),
         SetupLow       => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(6),
         HoldLow        => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(6),
         HoldHigh       => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(6),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0TXD7_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0TXD7_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0TXD_dly(7),
         TestSignalName => "CLIENTEMAC0TXD(7)",
         TestDelay      => tisd_CLIENTEMAC0TXD(7),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(7),
         SetupLow       => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(7),
         HoldLow        => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(7),
         HoldHigh       => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(7),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0TXD8_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0TXD8_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0TXD_dly(8),
         TestSignalName => "CLIENTEMAC0TXD(8)",
         TestDelay      => tisd_CLIENTEMAC0TXD(8),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(8),
         SetupLow       => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(8),
         HoldLow        => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(8),
         HoldHigh       => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(8),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0TXD9_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0TXD9_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0TXD_dly(9),
         TestSignalName => "CLIENTEMAC0TXD(9)",
         TestDelay      => tisd_CLIENTEMAC0TXD(9),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(9),
         SetupLow       => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(9),
         HoldLow        => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(9),
         HoldHigh       => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(9),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0TXD10_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0TXD10_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0TXD_dly(10),
         TestSignalName => "CLIENTEMAC0TXD(10)",
         TestDelay      => tisd_CLIENTEMAC0TXD(10),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(10),
         SetupLow       => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(10),
         HoldLow        => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(10),
         HoldHigh       => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(10),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0TXD11_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0TXD11_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0TXD_dly(11),
         TestSignalName => "CLIENTEMAC0TXD(11)",
         TestDelay      => tisd_CLIENTEMAC0TXD(11),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(11),
         SetupLow       => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(11),
         HoldLow        => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(11),
         HoldHigh       => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(11),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0TXD12_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0TXD12_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0TXD_dly(12),
         TestSignalName => "CLIENTEMAC0TXD(12)",
         TestDelay      => tisd_CLIENTEMAC0TXD(12),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(12),
         SetupLow       => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(12),
         HoldLow        => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(12),
         HoldHigh       => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(12),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0TXD13_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0TXD13_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0TXD_dly(13),
         TestSignalName => "CLIENTEMAC0TXD(13)",
         TestDelay      => tisd_CLIENTEMAC0TXD(13),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(13),
         SetupLow       => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(13),
         HoldLow        => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(13),
         HoldHigh       => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(13),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0TXD14_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0TXD14_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0TXD_dly(14),
         TestSignalName => "CLIENTEMAC0TXD(14)",
         TestDelay      => tisd_CLIENTEMAC0TXD(14),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(14),
         SetupLow       => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(14),
         HoldLow        => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(14),
         HoldHigh       => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(14),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0TXD15_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0TXD15_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0TXD_dly(15),
         TestSignalName => "CLIENTEMAC0TXD(15)",
         TestDelay      => tisd_CLIENTEMAC0TXD(15),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(15),
         SetupLow       => tsetup_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(15),
         HoldLow        => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(15),
         HoldHigh       => thold_CLIENTEMAC0TXD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(15),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0TXDVLD_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0TXDVLD_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0TXDVLD,
         TestSignalName => "CLIENTEMAC0TXDVLD",
         TestDelay      => 0 ns,
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_CLIENTEMAC0TXDVLD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge,
         SetupLow       => tsetup_CLIENTEMAC0TXDVLD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge,
         HoldLow        => thold_CLIENTEMAC0TXDVLD_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge,
         HoldHigh       => thold_CLIENTEMAC0TXDVLD_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0TXDVLDMSW_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0TXDVLDMSW_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0TXDVLDMSW,
         TestSignalName => "CLIENTEMAC0TXDVLDMSW",
         TestDelay      => 0 ns,
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_CLIENTEMAC0TXDVLDMSW_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge,
         SetupLow       => tsetup_CLIENTEMAC0TXDVLDMSW_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge,
         HoldLow        => thold_CLIENTEMAC0TXDVLDMSW_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge,
         HoldHigh       => thold_CLIENTEMAC0TXDVLDMSW_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0TXFIRSTBYTE_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0TXFIRSTBYTE_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0TXFIRSTBYTE,
         TestSignalName => "CLIENTEMAC0TXFIRSTBYTE",
         TestDelay      => 0 ns,
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_CLIENTEMAC0TXFIRSTBYTE_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge,
         SetupLow       => tsetup_CLIENTEMAC0TXFIRSTBYTE_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge,
         HoldLow        => thold_CLIENTEMAC0TXFIRSTBYTE_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge,
         HoldHigh       => thold_CLIENTEMAC0TXFIRSTBYTE_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0TXIFGDELAY0_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0TXIFGDELAY0_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0TXIFGDELAY_dly(0),
         TestSignalName => "CLIENTEMAC0TXIFGDELAY(0)",
         TestDelay      => tisd_CLIENTEMAC0TXIFGDELAY(0),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(0),
         SetupLow       => tsetup_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(0),
         HoldLow        => thold_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(0),
         HoldHigh       => thold_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0TXIFGDELAY1_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0TXIFGDELAY1_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0TXIFGDELAY_dly(1),
         TestSignalName => "CLIENTEMAC0TXIFGDELAY(1)",
         TestDelay      => tisd_CLIENTEMAC0TXIFGDELAY(1),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(1),
         SetupLow       => tsetup_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(1),
         HoldLow        => thold_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(1),
         HoldHigh       => thold_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0TXIFGDELAY2_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0TXIFGDELAY2_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0TXIFGDELAY_dly(2),
         TestSignalName => "CLIENTEMAC0TXIFGDELAY(2)",
         TestDelay      => tisd_CLIENTEMAC0TXIFGDELAY(2),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(2),
         SetupLow       => tsetup_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(2),
         HoldLow        => thold_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(2),
         HoldHigh       => thold_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0TXIFGDELAY3_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0TXIFGDELAY3_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0TXIFGDELAY_dly(3),
         TestSignalName => "CLIENTEMAC0TXIFGDELAY(3)",
         TestDelay      => tisd_CLIENTEMAC0TXIFGDELAY(3),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(3),
         SetupLow       => tsetup_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(3),
         HoldLow        => thold_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(3),
         HoldHigh       => thold_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(3),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0TXIFGDELAY4_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0TXIFGDELAY4_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0TXIFGDELAY_dly(4),
         TestSignalName => "CLIENTEMAC0TXIFGDELAY(4)",
         TestDelay      => tisd_CLIENTEMAC0TXIFGDELAY(4),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(4),
         SetupLow       => tsetup_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(4),
         HoldLow        => thold_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(4),
         HoldHigh       => thold_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(4),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0TXIFGDELAY5_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0TXIFGDELAY5_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0TXIFGDELAY_dly(5),
         TestSignalName => "CLIENTEMAC0TXIFGDELAY(5)",
         TestDelay      => tisd_CLIENTEMAC0TXIFGDELAY(5),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(5),
         SetupLow       => tsetup_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(5),
         HoldLow        => thold_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(5),
         HoldHigh       => thold_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(5),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0TXIFGDELAY6_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0TXIFGDELAY6_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0TXIFGDELAY_dly(6),
         TestSignalName => "CLIENTEMAC0TXIFGDELAY(6)",
         TestDelay      => tisd_CLIENTEMAC0TXIFGDELAY(6),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(6),
         SetupLow       => tsetup_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(6),
         HoldLow        => thold_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(6),
         HoldHigh       => thold_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(6),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0TXIFGDELAY7_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0TXIFGDELAY7_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0TXIFGDELAY_dly(7),
         TestSignalName => "CLIENTEMAC0TXIFGDELAY(7)",
         TestDelay      => tisd_CLIENTEMAC0TXIFGDELAY(7),
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC0TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(7),
         SetupLow       => tsetup_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(7),
         HoldLow        => thold_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge(7),
         HoldHigh       => thold_CLIENTEMAC0TXIFGDELAY_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge(7),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC0TXUNDERRUN_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC0TXUNDERRUN_CLIENTEMAC0TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC0TXUNDERRUN,
         TestSignalName => "CLIENTEMAC0TXUNDERRUN",
         TestDelay      => 0 ns,
         RefSignal      => CLIENTEMAC0TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC0TXCLIENTCLKIN",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_CLIENTEMAC0TXUNDERRUN_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge,
         SetupLow       => tsetup_CLIENTEMAC0TXUNDERRUN_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge,
         HoldLow        => thold_CLIENTEMAC0TXUNDERRUN_CLIENTEMAC0TXCLIENTCLKIN_posedge_posedge,
         HoldHigh       => thold_CLIENTEMAC0TXUNDERRUN_CLIENTEMAC0TXCLIENTCLKIN_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1DCMLOCKED_PHYEMAC1GTXCLK_posedge,
         TimingData     => Tmkr_CLIENTEMAC1DCMLOCKED_PHYEMAC1GTXCLK_posedge,
         TestSignal     => CLIENTEMAC1DCMLOCKED,
         TestSignalName => "CLIENTEMAC1DCMLOCKED",
         TestDelay      => 0 ns,
         RefSignal      => PHYEMAC1GTXCLK_dly,
         RefSignalName  => "PHYEMAC1GTXCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_CLIENTEMAC1DCMLOCKED_PHYEMAC1GTXCLK_posedge_posedge,
         SetupLow       => tsetup_CLIENTEMAC1DCMLOCKED_PHYEMAC1GTXCLK_negedge_posedge,
         HoldLow        => thold_CLIENTEMAC1DCMLOCKED_PHYEMAC1GTXCLK_posedge_posedge,
         HoldHigh       => thold_CLIENTEMAC1DCMLOCKED_PHYEMAC1GTXCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1PAUSEREQ_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1PAUSEREQ_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1PAUSEREQ,
         TestSignalName => "CLIENTEMAC1PAUSEREQ",
         TestDelay      => 0 ns,
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_CLIENTEMAC1PAUSEREQ_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge,
         SetupLow       => tsetup_CLIENTEMAC1PAUSEREQ_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge,
         HoldLow        => thold_CLIENTEMAC1PAUSEREQ_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge,
         HoldHigh       => thold_CLIENTEMAC1PAUSEREQ_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1PAUSEVAL0_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1PAUSEVAL0_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1PAUSEVAL_dly(0),
         TestSignalName => "CLIENTEMAC1PAUSEVAL(0)",
         TestDelay      => tisd_CLIENTEMAC1PAUSEVAL(0),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(0),
         SetupLow       => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(0),
         HoldLow        => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(0),
         HoldHigh       => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1PAUSEVAL1_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1PAUSEVAL1_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1PAUSEVAL_dly(1),
         TestSignalName => "CLIENTEMAC1PAUSEVAL(1)",
         TestDelay      => tisd_CLIENTEMAC1PAUSEVAL(1),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(1),
         SetupLow       => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(1),
         HoldLow        => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(1),
         HoldHigh       => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1PAUSEVAL2_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1PAUSEVAL2_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1PAUSEVAL_dly(2),
         TestSignalName => "CLIENTEMAC1PAUSEVAL(2)",
         TestDelay      => tisd_CLIENTEMAC1PAUSEVAL(2),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(2),
         SetupLow       => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(2),
         HoldLow        => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(2),
         HoldHigh       => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1PAUSEVAL3_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1PAUSEVAL3_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1PAUSEVAL_dly(3),
         TestSignalName => "CLIENTEMAC1PAUSEVAL(3)",
         TestDelay      => tisd_CLIENTEMAC1PAUSEVAL(3),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(3),
         SetupLow       => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(3),
         HoldLow        => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(3),
         HoldHigh       => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(3),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1PAUSEVAL4_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1PAUSEVAL4_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1PAUSEVAL_dly(4),
         TestSignalName => "CLIENTEMAC1PAUSEVAL(4)",
         TestDelay      => tisd_CLIENTEMAC1PAUSEVAL(4),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(4),
         SetupLow       => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(4),
         HoldLow        => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(4),
         HoldHigh       => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(4),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1PAUSEVAL5_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1PAUSEVAL5_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1PAUSEVAL_dly(5),
         TestSignalName => "CLIENTEMAC1PAUSEVAL(5)",
         TestDelay      => tisd_CLIENTEMAC1PAUSEVAL(5),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(5),
         SetupLow       => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(5),
         HoldLow        => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(5),
         HoldHigh       => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(5),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1PAUSEVAL6_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1PAUSEVAL6_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1PAUSEVAL_dly(6),
         TestSignalName => "CLIENTEMAC1PAUSEVAL(6)",
         TestDelay      => tisd_CLIENTEMAC1PAUSEVAL(6),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(6),
         SetupLow       => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(6),
         HoldLow        => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(6),
         HoldHigh       => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(6),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1PAUSEVAL7_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1PAUSEVAL7_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1PAUSEVAL_dly(7),
         TestSignalName => "CLIENTEMAC1PAUSEVAL(7)",
         TestDelay      => tisd_CLIENTEMAC1PAUSEVAL(7),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(7),
         SetupLow       => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(7),
         HoldLow        => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(7),
         HoldHigh       => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(7),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1PAUSEVAL8_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1PAUSEVAL8_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1PAUSEVAL_dly(8),
         TestSignalName => "CLIENTEMAC1PAUSEVAL(8)",
         TestDelay      => tisd_CLIENTEMAC1PAUSEVAL(8),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(8),
         SetupLow       => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(8),
         HoldLow        => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(8),
         HoldHigh       => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(8),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1PAUSEVAL9_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1PAUSEVAL9_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1PAUSEVAL_dly(9),
         TestSignalName => "CLIENTEMAC1PAUSEVAL(9)",
         TestDelay      => tisd_CLIENTEMAC1PAUSEVAL(9),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(9),
         SetupLow       => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(9),
         HoldLow        => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(9),
         HoldHigh       => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(9),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1PAUSEVAL10_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1PAUSEVAL10_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1PAUSEVAL_dly(10),
         TestSignalName => "CLIENTEMAC1PAUSEVAL(10)",
         TestDelay      => tisd_CLIENTEMAC1PAUSEVAL(10),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(10),
         SetupLow       => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(10),
         HoldLow        => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(10),
         HoldHigh       => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(10),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1PAUSEVAL11_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1PAUSEVAL11_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1PAUSEVAL_dly(11),
         TestSignalName => "CLIENTEMAC1PAUSEVAL(11)",
         TestDelay      => tisd_CLIENTEMAC1PAUSEVAL(11),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(11),
         SetupLow       => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(11),
         HoldLow        => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(11),
         HoldHigh       => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(11),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1PAUSEVAL12_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1PAUSEVAL12_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1PAUSEVAL_dly(12),
         TestSignalName => "CLIENTEMAC1PAUSEVAL(12)",
         TestDelay      => tisd_CLIENTEMAC1PAUSEVAL(12),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(12),
         SetupLow       => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(12),
         HoldLow        => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(12),
         HoldHigh       => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(12),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1PAUSEVAL13_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1PAUSEVAL13_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1PAUSEVAL_dly(13),
         TestSignalName => "CLIENTEMAC1PAUSEVAL(13)",
         TestDelay      => tisd_CLIENTEMAC1PAUSEVAL(13),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(13),
         SetupLow       => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(13),
         HoldLow        => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(13),
         HoldHigh       => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(13),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1PAUSEVAL14_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1PAUSEVAL14_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1PAUSEVAL_dly(14),
         TestSignalName => "CLIENTEMAC1PAUSEVAL(14)",
         TestDelay      => tisd_CLIENTEMAC1PAUSEVAL(14),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(14),
         SetupLow       => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(14),
         HoldLow        => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(14),
         HoldHigh       => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(14),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1PAUSEVAL15_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1PAUSEVAL15_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1PAUSEVAL_dly(15),
         TestSignalName => "CLIENTEMAC1PAUSEVAL(15)",
         TestDelay      => tisd_CLIENTEMAC1PAUSEVAL(15),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(15),
         SetupLow       => tsetup_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(15),
         HoldLow        => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(15),
         HoldHigh       => thold_CLIENTEMAC1PAUSEVAL_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(15),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1TXD0_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1TXD0_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1TXD_dly(0),
         TestSignalName => "CLIENTEMAC1TXD(0)",
         TestDelay      => tisd_CLIENTEMAC1TXD(0),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(0),
         SetupLow       => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(0),
         HoldLow        => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(0),
         HoldHigh       => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1TXD1_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1TXD1_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1TXD_dly(1),
         TestSignalName => "CLIENTEMAC1TXD(1)",
         TestDelay      => tisd_CLIENTEMAC1TXD(1),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(1),
         SetupLow       => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(1),
         HoldLow        => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(1),
         HoldHigh       => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1TXD2_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1TXD2_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1TXD_dly(2),
         TestSignalName => "CLIENTEMAC1TXD(2)",
         TestDelay      => tisd_CLIENTEMAC1TXD(2),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(2),
         SetupLow       => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(2),
         HoldLow        => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(2),
         HoldHigh       => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1TXD3_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1TXD3_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1TXD_dly(3),
         TestSignalName => "CLIENTEMAC1TXD(3)",
         TestDelay      => tisd_CLIENTEMAC1TXD(3),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(3),
         SetupLow       => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(3),
         HoldLow        => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(3),
         HoldHigh       => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(3),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1TXD4_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1TXD4_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1TXD_dly(4),
         TestSignalName => "CLIENTEMAC1TXD(4)",
         TestDelay      => tisd_CLIENTEMAC1TXD(4),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(4),
         SetupLow       => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(4),
         HoldLow        => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(4),
         HoldHigh       => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(4),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1TXD5_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1TXD5_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1TXD_dly(5),
         TestSignalName => "CLIENTEMAC1TXD(5)",
         TestDelay      => tisd_CLIENTEMAC1TXD(5),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(5),
         SetupLow       => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(5),
         HoldLow        => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(5),
         HoldHigh       => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(5),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1TXD6_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1TXD6_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1TXD_dly(6),
         TestSignalName => "CLIENTEMAC1TXD(6)",
         TestDelay      => tisd_CLIENTEMAC1TXD(6),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(6),
         SetupLow       => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(6),
         HoldLow        => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(6),
         HoldHigh       => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(6),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1TXD7_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1TXD7_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1TXD_dly(7),
         TestSignalName => "CLIENTEMAC1TXD(7)",
         TestDelay      => tisd_CLIENTEMAC1TXD(7),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(7),
         SetupLow       => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(7),
         HoldLow        => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(7),
         HoldHigh       => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(7),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1TXD8_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1TXD8_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1TXD_dly(8),
         TestSignalName => "CLIENTEMAC1TXD(8)",
         TestDelay      => tisd_CLIENTEMAC1TXD(8),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(8),
         SetupLow       => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(8),
         HoldLow        => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(8),
         HoldHigh       => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(8),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1TXD9_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1TXD9_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1TXD_dly(9),
         TestSignalName => "CLIENTEMAC1TXD(9)",
         TestDelay      => tisd_CLIENTEMAC1TXD(9),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(9),
         SetupLow       => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(9),
         HoldLow        => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(9),
         HoldHigh       => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(9),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1TXD10_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1TXD10_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1TXD_dly(10),
         TestSignalName => "CLIENTEMAC1TXD(10)",
         TestDelay      => tisd_CLIENTEMAC1TXD(10),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(10),
         SetupLow       => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(10),
         HoldLow        => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(10),
         HoldHigh       => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(10),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1TXD11_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1TXD11_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1TXD_dly(11),
         TestSignalName => "CLIENTEMAC1TXD(11)",
         TestDelay      => tisd_CLIENTEMAC1TXD(11),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(11),
         SetupLow       => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(11),
         HoldLow        => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(11),
         HoldHigh       => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(11),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1TXD12_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1TXD12_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1TXD_dly(12),
         TestSignalName => "CLIENTEMAC1TXD(12)",
         TestDelay      => tisd_CLIENTEMAC1TXD(12),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(12),
         SetupLow       => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(12),
         HoldLow        => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(12),
         HoldHigh       => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(12),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1TXD13_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1TXD13_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1TXD_dly(13),
         TestSignalName => "CLIENTEMAC1TXD(13)",
         TestDelay      => tisd_CLIENTEMAC1TXD(13),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(13),
         SetupLow       => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(13),
         HoldLow        => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(13),
         HoldHigh       => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(13),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1TXD14_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1TXD14_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1TXD_dly(14),
         TestSignalName => "CLIENTEMAC1TXD(14)",
         TestDelay      => tisd_CLIENTEMAC1TXD(14),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(14),
         SetupLow       => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(14),
         HoldLow        => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(14),
         HoldHigh       => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(14),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1TXD15_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1TXD15_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1TXD_dly(15),
         TestSignalName => "CLIENTEMAC1TXD(15)",
         TestDelay      => tisd_CLIENTEMAC1TXD(15),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(15),
         SetupLow       => tsetup_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(15),
         HoldLow        => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(15),
         HoldHigh       => thold_CLIENTEMAC1TXD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(15),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1TXDVLD_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1TXDVLD_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1TXDVLD,
         TestSignalName => "CLIENTEMAC1TXDVLD",
         TestDelay      => 0 ns,
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_CLIENTEMAC1TXDVLD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge,
         SetupLow       => tsetup_CLIENTEMAC1TXDVLD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge,
         HoldLow        => thold_CLIENTEMAC1TXDVLD_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge,
         HoldHigh       => thold_CLIENTEMAC1TXDVLD_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1TXDVLDMSW_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1TXDVLDMSW_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1TXDVLDMSW,
         TestSignalName => "CLIENTEMAC1TXDVLDMSW",
         TestDelay      => 0 ns,
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_CLIENTEMAC1TXDVLDMSW_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge,
         SetupLow       => tsetup_CLIENTEMAC1TXDVLDMSW_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge,
         HoldLow        => thold_CLIENTEMAC1TXDVLDMSW_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge,
         HoldHigh       => thold_CLIENTEMAC1TXDVLDMSW_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1TXFIRSTBYTE_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1TXFIRSTBYTE_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1TXFIRSTBYTE,
         TestSignalName => "CLIENTEMAC1TXFIRSTBYTE",
         TestDelay      => 0 ns,
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_CLIENTEMAC1TXFIRSTBYTE_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge,
         SetupLow       => tsetup_CLIENTEMAC1TXFIRSTBYTE_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge,
         HoldLow        => thold_CLIENTEMAC1TXFIRSTBYTE_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge,
         HoldHigh       => thold_CLIENTEMAC1TXFIRSTBYTE_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1TXIFGDELAY0_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1TXIFGDELAY0_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1TXIFGDELAY_dly(0),
         TestSignalName => "CLIENTEMAC1TXIFGDELAY(0)",
         TestDelay      => tisd_CLIENTEMAC1TXIFGDELAY(0),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(0),
         SetupLow       => tsetup_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(0),
         HoldLow        => thold_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(0),
         HoldHigh       => thold_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1TXIFGDELAY1_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1TXIFGDELAY1_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1TXIFGDELAY_dly(1),
         TestSignalName => "CLIENTEMAC1TXIFGDELAY(1)",
         TestDelay      => tisd_CLIENTEMAC1TXIFGDELAY(1),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(1),
         SetupLow       => tsetup_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(1),
         HoldLow        => thold_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(1),
         HoldHigh       => thold_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1TXIFGDELAY2_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1TXIFGDELAY2_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1TXIFGDELAY_dly(2),
         TestSignalName => "CLIENTEMAC1TXIFGDELAY(2)",
         TestDelay      => tisd_CLIENTEMAC1TXIFGDELAY(2),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(2),
         SetupLow       => tsetup_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(2),
         HoldLow        => thold_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(2),
         HoldHigh       => thold_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1TXIFGDELAY3_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1TXIFGDELAY3_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1TXIFGDELAY_dly(3),
         TestSignalName => "CLIENTEMAC1TXIFGDELAY(3)",
         TestDelay      => tisd_CLIENTEMAC1TXIFGDELAY(3),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(3),
         SetupLow       => tsetup_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(3),
         HoldLow        => thold_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(3),
         HoldHigh       => thold_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(3),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1TXIFGDELAY4_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1TXIFGDELAY4_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1TXIFGDELAY_dly(4),
         TestSignalName => "CLIENTEMAC1TXIFGDELAY(4)",
         TestDelay      => tisd_CLIENTEMAC1TXIFGDELAY(4),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(4),
         SetupLow       => tsetup_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(4),
         HoldLow        => thold_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(4),
         HoldHigh       => thold_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(4),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1TXIFGDELAY5_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1TXIFGDELAY5_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1TXIFGDELAY_dly(5),
         TestSignalName => "CLIENTEMAC1TXIFGDELAY(5)",
         TestDelay      => tisd_CLIENTEMAC1TXIFGDELAY(5),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(5),
         SetupLow       => tsetup_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(5),
         HoldLow        => thold_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(5),
         HoldHigh       => thold_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(5),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1TXIFGDELAY6_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1TXIFGDELAY6_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1TXIFGDELAY_dly(6),
         TestSignalName => "CLIENTEMAC1TXIFGDELAY(6)",
         TestDelay      => tisd_CLIENTEMAC1TXIFGDELAY(6),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(6),
         SetupLow       => tsetup_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(6),
         HoldLow        => thold_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(6),
         HoldHigh       => thold_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(6),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1TXIFGDELAY7_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1TXIFGDELAY7_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1TXIFGDELAY_dly(7),
         TestSignalName => "CLIENTEMAC1TXIFGDELAY(7)",
         TestDelay      => tisd_CLIENTEMAC1TXIFGDELAY(7),
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => ticd_CLIENTEMAC1TXCLIENTCLKIN,
         SetupHigh      => tsetup_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(7),
         SetupLow       => tsetup_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(7),
         HoldLow        => thold_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge(7),
         HoldHigh       => thold_CLIENTEMAC1TXIFGDELAY_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge(7),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_CLIENTEMAC1TXUNDERRUN_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TimingData     => Tmkr_CLIENTEMAC1TXUNDERRUN_CLIENTEMAC1TXCLIENTCLKIN_posedge,
         TestSignal     => CLIENTEMAC1TXUNDERRUN,
         TestSignalName => "CLIENTEMAC1TXUNDERRUN",
         TestDelay      => 0 ns,
         RefSignal      => CLIENTEMAC1TXCLIENTCLKIN_dly,
         RefSignalName  => "CLIENTEMAC1TXCLIENTCLKIN",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_CLIENTEMAC1TXUNDERRUN_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge,
         SetupLow       => tsetup_CLIENTEMAC1TXUNDERRUN_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge,
         HoldLow        => thold_CLIENTEMAC1TXUNDERRUN_CLIENTEMAC1TXCLIENTCLKIN_posedge_posedge,
         HoldHigh       => thold_CLIENTEMAC1TXUNDERRUN_CLIENTEMAC1TXCLIENTCLKIN_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTADDR0_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTADDR0_HOSTCLK_posedge,
         TestSignal     => HOSTADDR_dly(0),
         TestSignalName => "HOSTADDR(0)",
         TestDelay      => tisd_HOSTADDR(0),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTADDR_HOSTCLK_posedge_posedge(0),
         SetupLow       => tsetup_HOSTADDR_HOSTCLK_negedge_posedge(0),
         HoldLow        => thold_HOSTADDR_HOSTCLK_posedge_posedge(0),
         HoldHigh       => thold_HOSTADDR_HOSTCLK_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTADDR1_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTADDR1_HOSTCLK_posedge,
         TestSignal     => HOSTADDR_dly(1),
         TestSignalName => "HOSTADDR(1)",
         TestDelay      => tisd_HOSTADDR(1),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTADDR_HOSTCLK_posedge_posedge(1),
         SetupLow       => tsetup_HOSTADDR_HOSTCLK_negedge_posedge(1),
         HoldLow        => thold_HOSTADDR_HOSTCLK_posedge_posedge(1),
         HoldHigh       => thold_HOSTADDR_HOSTCLK_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTADDR2_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTADDR2_HOSTCLK_posedge,
         TestSignal     => HOSTADDR_dly(2),
         TestSignalName => "HOSTADDR(2)",
         TestDelay      => tisd_HOSTADDR(2),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTADDR_HOSTCLK_posedge_posedge(2),
         SetupLow       => tsetup_HOSTADDR_HOSTCLK_negedge_posedge(2),
         HoldLow        => thold_HOSTADDR_HOSTCLK_posedge_posedge(2),
         HoldHigh       => thold_HOSTADDR_HOSTCLK_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTADDR3_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTADDR3_HOSTCLK_posedge,
         TestSignal     => HOSTADDR_dly(3),
         TestSignalName => "HOSTADDR(3)",
         TestDelay      => tisd_HOSTADDR(3),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTADDR_HOSTCLK_posedge_posedge(3),
         SetupLow       => tsetup_HOSTADDR_HOSTCLK_negedge_posedge(3),
         HoldLow        => thold_HOSTADDR_HOSTCLK_posedge_posedge(3),
         HoldHigh       => thold_HOSTADDR_HOSTCLK_negedge_posedge(3),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTADDR4_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTADDR4_HOSTCLK_posedge,
         TestSignal     => HOSTADDR_dly(4),
         TestSignalName => "HOSTADDR(4)",
         TestDelay      => tisd_HOSTADDR(4),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTADDR_HOSTCLK_posedge_posedge(4),
         SetupLow       => tsetup_HOSTADDR_HOSTCLK_negedge_posedge(4),
         HoldLow        => thold_HOSTADDR_HOSTCLK_posedge_posedge(4),
         HoldHigh       => thold_HOSTADDR_HOSTCLK_negedge_posedge(4),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTADDR5_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTADDR5_HOSTCLK_posedge,
         TestSignal     => HOSTADDR_dly(5),
         TestSignalName => "HOSTADDR(5)",
         TestDelay      => tisd_HOSTADDR(5),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTADDR_HOSTCLK_posedge_posedge(5),
         SetupLow       => tsetup_HOSTADDR_HOSTCLK_negedge_posedge(5),
         HoldLow        => thold_HOSTADDR_HOSTCLK_posedge_posedge(5),
         HoldHigh       => thold_HOSTADDR_HOSTCLK_negedge_posedge(5),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTADDR6_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTADDR6_HOSTCLK_posedge,
         TestSignal     => HOSTADDR_dly(6),
         TestSignalName => "HOSTADDR(6)",
         TestDelay      => tisd_HOSTADDR(6),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTADDR_HOSTCLK_posedge_posedge(6),
         SetupLow       => tsetup_HOSTADDR_HOSTCLK_negedge_posedge(6),
         HoldLow        => thold_HOSTADDR_HOSTCLK_posedge_posedge(6),
         HoldHigh       => thold_HOSTADDR_HOSTCLK_negedge_posedge(6),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTADDR7_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTADDR7_HOSTCLK_posedge,
         TestSignal     => HOSTADDR_dly(7),
         TestSignalName => "HOSTADDR(7)",
         TestDelay      => tisd_HOSTADDR(7),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTADDR_HOSTCLK_posedge_posedge(7),
         SetupLow       => tsetup_HOSTADDR_HOSTCLK_negedge_posedge(7),
         HoldLow        => thold_HOSTADDR_HOSTCLK_posedge_posedge(7),
         HoldHigh       => thold_HOSTADDR_HOSTCLK_negedge_posedge(7),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTADDR8_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTADDR8_HOSTCLK_posedge,
         TestSignal     => HOSTADDR_dly(8),
         TestSignalName => "HOSTADDR(8)",
         TestDelay      => tisd_HOSTADDR(8),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTADDR_HOSTCLK_posedge_posedge(8),
         SetupLow       => tsetup_HOSTADDR_HOSTCLK_negedge_posedge(8),
         HoldLow        => thold_HOSTADDR_HOSTCLK_posedge_posedge(8),
         HoldHigh       => thold_HOSTADDR_HOSTCLK_negedge_posedge(8),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTADDR9_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTADDR9_HOSTCLK_posedge,
         TestSignal     => HOSTADDR_dly(9),
         TestSignalName => "HOSTADDR(9)",
         TestDelay      => tisd_HOSTADDR(9),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTADDR_HOSTCLK_posedge_posedge(9),
         SetupLow       => tsetup_HOSTADDR_HOSTCLK_negedge_posedge(9),
         HoldLow        => thold_HOSTADDR_HOSTCLK_posedge_posedge(9),
         HoldHigh       => thold_HOSTADDR_HOSTCLK_negedge_posedge(9),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTEMAC1SEL_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTEMAC1SEL_HOSTCLK_posedge,
         TestSignal     => HOSTEMAC1SEL,
         TestSignalName => "HOSTEMAC1SEL",
         TestDelay      => 0 ns,
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_HOSTEMAC1SEL_HOSTCLK_posedge_posedge,
         SetupLow       => tsetup_HOSTEMAC1SEL_HOSTCLK_negedge_posedge,
         HoldLow        => thold_HOSTEMAC1SEL_HOSTCLK_posedge_posedge,
         HoldHigh       => thold_HOSTEMAC1SEL_HOSTCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTMIIMSEL_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTMIIMSEL_HOSTCLK_posedge,
         TestSignal     => HOSTMIIMSEL,
         TestSignalName => "HOSTMIIMSEL",
         TestDelay      => 0 ns,
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_HOSTMIIMSEL_HOSTCLK_posedge_posedge,
         SetupLow       => tsetup_HOSTMIIMSEL_HOSTCLK_negedge_posedge,
         HoldLow        => thold_HOSTMIIMSEL_HOSTCLK_posedge_posedge,
         HoldHigh       => thold_HOSTMIIMSEL_HOSTCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTOPCODE0_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTOPCODE0_HOSTCLK_posedge,
         TestSignal     => HOSTOPCODE_dly(0),
         TestSignalName => "HOSTOPCODE(0)",
         TestDelay      => tisd_HOSTOPCODE(0),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTOPCODE_HOSTCLK_posedge_posedge(0),
         SetupLow       => tsetup_HOSTOPCODE_HOSTCLK_negedge_posedge(0),
         HoldLow        => thold_HOSTOPCODE_HOSTCLK_posedge_posedge(0),
         HoldHigh       => thold_HOSTOPCODE_HOSTCLK_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTOPCODE1_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTOPCODE1_HOSTCLK_posedge,
         TestSignal     => HOSTOPCODE_dly(1),
         TestSignalName => "HOSTOPCODE(1)",
         TestDelay      => tisd_HOSTOPCODE(1),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTOPCODE_HOSTCLK_posedge_posedge(1),
         SetupLow       => tsetup_HOSTOPCODE_HOSTCLK_negedge_posedge(1),
         HoldLow        => thold_HOSTOPCODE_HOSTCLK_posedge_posedge(1),
         HoldHigh       => thold_HOSTOPCODE_HOSTCLK_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTREQ_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTREQ_HOSTCLK_posedge,
         TestSignal     => HOSTREQ,
         TestSignalName => "HOSTREQ",
         TestDelay      => 0 ns,
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_HOSTREQ_HOSTCLK_posedge_posedge,
         SetupLow       => tsetup_HOSTREQ_HOSTCLK_negedge_posedge,
         HoldLow        => thold_HOSTREQ_HOSTCLK_posedge_posedge,
         HoldHigh       => thold_HOSTREQ_HOSTCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA0_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA0_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(0),
         TestSignalName => "HOSTWRDATA(0)",
         TestDelay      => tisd_HOSTWRDATA(0),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(0),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(0),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(0),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA1_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA1_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(1),
         TestSignalName => "HOSTWRDATA(1)",
         TestDelay      => tisd_HOSTWRDATA(1),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(1),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(1),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(1),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA2_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA2_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(2),
         TestSignalName => "HOSTWRDATA(2)",
         TestDelay      => tisd_HOSTWRDATA(2),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(2),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(2),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(2),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA3_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA3_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(3),
         TestSignalName => "HOSTWRDATA(3)",
         TestDelay      => tisd_HOSTWRDATA(3),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(3),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(3),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(3),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(3),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA4_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA4_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(4),
         TestSignalName => "HOSTWRDATA(4)",
         TestDelay      => tisd_HOSTWRDATA(4),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(4),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(4),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(4),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(4),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA5_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA5_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(5),
         TestSignalName => "HOSTWRDATA(5)",
         TestDelay      => tisd_HOSTWRDATA(5),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(5),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(5),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(5),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(5),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA6_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA6_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(6),
         TestSignalName => "HOSTWRDATA(6)",
         TestDelay      => tisd_HOSTWRDATA(6),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(6),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(6),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(6),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(6),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA7_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA7_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(7),
         TestSignalName => "HOSTWRDATA(7)",
         TestDelay      => tisd_HOSTWRDATA(7),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(7),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(7),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(7),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(7),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA8_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA8_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(8),
         TestSignalName => "HOSTWRDATA(8)",
         TestDelay      => tisd_HOSTWRDATA(8),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(8),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(8),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(8),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(8),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA9_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA9_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(9),
         TestSignalName => "HOSTWRDATA(9)",
         TestDelay      => tisd_HOSTWRDATA(9),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(9),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(9),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(9),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(9),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA10_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA10_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(10),
         TestSignalName => "HOSTWRDATA(10)",
         TestDelay      => tisd_HOSTWRDATA(10),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(10),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(10),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(10),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(10),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA11_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA11_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(11),
         TestSignalName => "HOSTWRDATA(11)",
         TestDelay      => tisd_HOSTWRDATA(11),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(11),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(11),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(11),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(11),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA12_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA12_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(12),
         TestSignalName => "HOSTWRDATA(12)",
         TestDelay      => tisd_HOSTWRDATA(12),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(12),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(12),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(12),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(12),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA13_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA13_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(13),
         TestSignalName => "HOSTWRDATA(13)",
         TestDelay      => tisd_HOSTWRDATA(13),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(13),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(13),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(13),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(13),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA14_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA14_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(14),
         TestSignalName => "HOSTWRDATA(14)",
         TestDelay      => tisd_HOSTWRDATA(14),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(14),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(14),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(14),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(14),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA15_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA15_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(15),
         TestSignalName => "HOSTWRDATA(15)",
         TestDelay      => tisd_HOSTWRDATA(15),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(15),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(15),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(15),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(15),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA16_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA16_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(16),
         TestSignalName => "HOSTWRDATA(16)",
         TestDelay      => tisd_HOSTWRDATA(16),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(16),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(16),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(16),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(16),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA17_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA17_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(17),
         TestSignalName => "HOSTWRDATA(17)",
         TestDelay      => tisd_HOSTWRDATA(17),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(17),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(17),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(17),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(17),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA18_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA18_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(18),
         TestSignalName => "HOSTWRDATA(18)",
         TestDelay      => tisd_HOSTWRDATA(18),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(18),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(18),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(18),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(18),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA19_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA19_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(19),
         TestSignalName => "HOSTWRDATA(19)",
         TestDelay      => tisd_HOSTWRDATA(19),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(19),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(19),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(19),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(19),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA20_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA20_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(20),
         TestSignalName => "HOSTWRDATA(20)",
         TestDelay      => tisd_HOSTWRDATA(20),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(20),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(20),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(20),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(20),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA21_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA21_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(21),
         TestSignalName => "HOSTWRDATA(21)",
         TestDelay      => tisd_HOSTWRDATA(21),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(21),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(21),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(21),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(21),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA22_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA22_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(22),
         TestSignalName => "HOSTWRDATA(22)",
         TestDelay      => tisd_HOSTWRDATA(22),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(22),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(22),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(22),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(22),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA23_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA23_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(23),
         TestSignalName => "HOSTWRDATA(23)",
         TestDelay      => tisd_HOSTWRDATA(23),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(23),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(23),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(23),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(23),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA24_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA24_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(24),
         TestSignalName => "HOSTWRDATA(24)",
         TestDelay      => tisd_HOSTWRDATA(24),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(24),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(24),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(24),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(24),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA25_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA25_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(25),
         TestSignalName => "HOSTWRDATA(25)",
         TestDelay      => tisd_HOSTWRDATA(25),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(25),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(25),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(25),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(25),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA26_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA26_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(26),
         TestSignalName => "HOSTWRDATA(26)",
         TestDelay      => tisd_HOSTWRDATA(26),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(26),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(26),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(26),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(26),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA27_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA27_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(27),
         TestSignalName => "HOSTWRDATA(27)",
         TestDelay      => tisd_HOSTWRDATA(27),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(27),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(27),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(27),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(27),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA28_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA28_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(28),
         TestSignalName => "HOSTWRDATA(28)",
         TestDelay      => tisd_HOSTWRDATA(28),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(28),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(28),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(28),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(28),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA29_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA29_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(29),
         TestSignalName => "HOSTWRDATA(29)",
         TestDelay      => tisd_HOSTWRDATA(29),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(29),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(29),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(29),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(29),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA30_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA30_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(30),
         TestSignalName => "HOSTWRDATA(30)",
         TestDelay      => tisd_HOSTWRDATA(30),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(30),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(30),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(30),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(30),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_HOSTWRDATA31_HOSTCLK_posedge,
         TimingData     => Tmkr_HOSTWRDATA31_HOSTCLK_posedge,
         TestSignal     => HOSTWRDATA_dly(31),
         TestSignalName => "HOSTWRDATA(31)",
         TestDelay      => tisd_HOSTWRDATA(31),
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => ticd_HOSTCLK,
         SetupHigh      => tsetup_HOSTWRDATA_HOSTCLK_posedge_posedge(31),
         SetupLow       => tsetup_HOSTWRDATA_HOSTCLK_negedge_posedge(31),
         HoldLow        => thold_HOSTWRDATA_HOSTCLK_posedge_posedge(31),
         HoldHigh       => thold_HOSTWRDATA_HOSTCLK_negedge_posedge(31),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC0COL_PHYEMAC0RXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC0COL_PHYEMAC0RXCLK_posedge,
         TestSignal     => PHYEMAC0COL,
         TestSignalName => "PHYEMAC0COL",
         TestDelay      => 0 ns,
         RefSignal      => PHYEMAC0RXCLK_dly,
         RefSignalName  => "PHYEMAC0RXCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PHYEMAC0COL_PHYEMAC0RXCLK_posedge_posedge,
         SetupLow       => tsetup_PHYEMAC0COL_PHYEMAC0RXCLK_negedge_posedge,
         HoldLow        => thold_PHYEMAC0COL_PHYEMAC0RXCLK_posedge_posedge,
         HoldHigh       => thold_PHYEMAC0COL_PHYEMAC0RXCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC0CRS_PHYEMAC0RXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC0CRS_PHYEMAC0RXCLK_posedge,
         TestSignal     => PHYEMAC0CRS,
         TestSignalName => "PHYEMAC0CRS",
         TestDelay      => 0 ns,
         RefSignal      => PHYEMAC0RXCLK_dly,
         RefSignalName  => "PHYEMAC0RXCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PHYEMAC0CRS_PHYEMAC0RXCLK_posedge_posedge,
         SetupLow       => tsetup_PHYEMAC0CRS_PHYEMAC0RXCLK_negedge_posedge,
         HoldLow        => thold_PHYEMAC0CRS_PHYEMAC0RXCLK_posedge_posedge,
         HoldHigh       => thold_PHYEMAC0CRS_PHYEMAC0RXCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC0MDIN_HOSTCLK_posedge,
         TimingData     => Tmkr_PHYEMAC0MDIN_HOSTCLK_posedge,
         TestSignal     => PHYEMAC0MDIN,
         TestSignalName => "PHYEMAC0MDIN",
         TestDelay      => 0 ns,
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PHYEMAC0MDIN_HOSTCLK_posedge_posedge,
         SetupLow       => tsetup_PHYEMAC0MDIN_HOSTCLK_negedge_posedge,
         HoldLow        => thold_PHYEMAC0MDIN_HOSTCLK_posedge_posedge,
         HoldHigh       => thold_PHYEMAC0MDIN_HOSTCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC0MDIN_PHYEMAC0MCLKIN_posedge,
         TimingData     => Tmkr_PHYEMAC0MDIN_PHYEMAC0MCLKIN_posedge,
         TestSignal     => PHYEMAC0MDIN,
         TestSignalName => "PHYEMAC0MDIN",
         TestDelay      => tisd_PHYEMAC0MDIN,
         RefSignal      => PHYEMAC0MCLKIN_dly,
         RefSignalName  => "PHYEMAC0MCLKIN",
         RefDelay       => ticd_PHYEMAC0MCLKIN,
         SetupHigh      => tsetup_PHYEMAC0MDIN_PHYEMAC0MCLKIN_posedge_posedge,
         SetupLow       => tsetup_PHYEMAC0MDIN_PHYEMAC0MCLKIN_negedge_posedge,
         HoldLow        => thold_PHYEMAC0MDIN_PHYEMAC0MCLKIN_posedge_posedge,
         HoldHigh       => thold_PHYEMAC0MDIN_PHYEMAC0MCLKIN_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC0RXBUFERR_PHYEMAC0GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC0RXBUFERR_PHYEMAC0GTXCLK_posedge,
         TestSignal     => PHYEMAC0RXBUFERR,
         TestSignalName => "PHYEMAC0RXBUFERR",
         TestDelay      => 0 ns,
         RefSignal      => PHYEMAC0GTXCLK_dly,
         RefSignalName  => "PHYEMAC0GTXCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PHYEMAC0RXBUFERR_PHYEMAC0GTXCLK_posedge_posedge,
         SetupLow       => tsetup_PHYEMAC0RXBUFERR_PHYEMAC0GTXCLK_negedge_posedge,
         HoldLow        => thold_PHYEMAC0RXBUFERR_PHYEMAC0GTXCLK_posedge_posedge,
         HoldHigh       => thold_PHYEMAC0RXBUFERR_PHYEMAC0GTXCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC0RXBUFSTATUS0_PHYEMAC0GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC0RXBUFSTATUS0_PHYEMAC0GTXCLK_posedge,
         TestSignal     => PHYEMAC0RXBUFSTATUS_dly(0),
         TestSignalName => "PHYEMAC0RXBUFSTATUS(0)",
         TestDelay      => tisd_PHYEMAC0RXBUFSTATUS(0),
         RefSignal      => PHYEMAC0GTXCLK_dly,
         RefSignalName  => "PHYEMAC0GTXCLK",
         RefDelay       => ticd_PHYEMAC0GTXCLK,
         SetupHigh      => tsetup_PHYEMAC0RXBUFSTATUS_PHYEMAC0GTXCLK_posedge_posedge(0),
         SetupLow       => tsetup_PHYEMAC0RXBUFSTATUS_PHYEMAC0GTXCLK_negedge_posedge(0),
         HoldLow        => thold_PHYEMAC0RXBUFSTATUS_PHYEMAC0GTXCLK_posedge_posedge(0),
         HoldHigh       => thold_PHYEMAC0RXBUFSTATUS_PHYEMAC0GTXCLK_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC0RXBUFSTATUS1_PHYEMAC0GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC0RXBUFSTATUS1_PHYEMAC0GTXCLK_posedge,
         TestSignal     => PHYEMAC0RXBUFSTATUS_dly(1),
         TestSignalName => "PHYEMAC0RXBUFSTATUS(1)",
         TestDelay      => tisd_PHYEMAC0RXBUFSTATUS(1),
         RefSignal      => PHYEMAC0GTXCLK_dly,
         RefSignalName  => "PHYEMAC0GTXCLK",
         RefDelay       => ticd_PHYEMAC0GTXCLK,
         SetupHigh      => tsetup_PHYEMAC0RXBUFSTATUS_PHYEMAC0GTXCLK_posedge_posedge(1),
         SetupLow       => tsetup_PHYEMAC0RXBUFSTATUS_PHYEMAC0GTXCLK_negedge_posedge(1),
         HoldLow        => thold_PHYEMAC0RXBUFSTATUS_PHYEMAC0GTXCLK_posedge_posedge(1),
         HoldHigh       => thold_PHYEMAC0RXBUFSTATUS_PHYEMAC0GTXCLK_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC0RXCHARISCOMMA_PHYEMAC0GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC0RXCHARISCOMMA_PHYEMAC0GTXCLK_posedge,
         TestSignal     => PHYEMAC0RXCHARISCOMMA,
         TestSignalName => "PHYEMAC0RXCHARISCOMMA",
         TestDelay      => 0 ns,
         RefSignal      => PHYEMAC0GTXCLK_dly,
         RefSignalName  => "PHYEMAC0GTXCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PHYEMAC0RXCHARISCOMMA_PHYEMAC0GTXCLK_posedge_posedge,
         SetupLow       => tsetup_PHYEMAC0RXCHARISCOMMA_PHYEMAC0GTXCLK_negedge_posedge,
         HoldLow        => thold_PHYEMAC0RXCHARISCOMMA_PHYEMAC0GTXCLK_posedge_posedge,
         HoldHigh       => thold_PHYEMAC0RXCHARISCOMMA_PHYEMAC0GTXCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC0RXCHARISK_PHYEMAC0GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC0RXCHARISK_PHYEMAC0GTXCLK_posedge,
         TestSignal     => PHYEMAC0RXCHARISK,
         TestSignalName => "PHYEMAC0RXCHARISK",
         TestDelay      => 0 ns,
         RefSignal      => PHYEMAC0GTXCLK_dly,
         RefSignalName  => "PHYEMAC0GTXCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PHYEMAC0RXCHARISK_PHYEMAC0GTXCLK_posedge_posedge,
         SetupLow       => tsetup_PHYEMAC0RXCHARISK_PHYEMAC0GTXCLK_negedge_posedge,
         HoldLow        => thold_PHYEMAC0RXCHARISK_PHYEMAC0GTXCLK_posedge_posedge,
         HoldHigh       => thold_PHYEMAC0RXCHARISK_PHYEMAC0GTXCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC0RXCHECKINGCRC_PHYEMAC0GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC0RXCHECKINGCRC_PHYEMAC0GTXCLK_posedge,
         TestSignal     => PHYEMAC0RXCHECKINGCRC,
         TestSignalName => "PHYEMAC0RXCHECKINGCRC",
         TestDelay      => 0 ns,
         RefSignal      => PHYEMAC0GTXCLK_dly,
         RefSignalName  => "PHYEMAC0GTXCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PHYEMAC0RXCHECKINGCRC_PHYEMAC0GTXCLK_posedge_posedge,
         SetupLow       => tsetup_PHYEMAC0RXCHECKINGCRC_PHYEMAC0GTXCLK_negedge_posedge,
         HoldLow        => thold_PHYEMAC0RXCHECKINGCRC_PHYEMAC0GTXCLK_posedge_posedge,
         HoldHigh       => thold_PHYEMAC0RXCHECKINGCRC_PHYEMAC0GTXCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC0RXCLKCORCNT0_PHYEMAC0GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC0RXCLKCORCNT0_PHYEMAC0GTXCLK_posedge,
         TestSignal     => PHYEMAC0RXCLKCORCNT_dly(0),
         TestSignalName => "PHYEMAC0RXCLKCORCNT(0)",
         TestDelay      => tisd_PHYEMAC0RXCLKCORCNT(0),
         RefSignal      => PHYEMAC0GTXCLK_dly,
         RefSignalName  => "PHYEMAC0GTXCLK",
         RefDelay       => ticd_PHYEMAC0GTXCLK,
         SetupHigh      => tsetup_PHYEMAC0RXCLKCORCNT_PHYEMAC0GTXCLK_posedge_posedge(0),
         SetupLow       => tsetup_PHYEMAC0RXCLKCORCNT_PHYEMAC0GTXCLK_negedge_posedge(0),
         HoldLow        => thold_PHYEMAC0RXCLKCORCNT_PHYEMAC0GTXCLK_posedge_posedge(0),
         HoldHigh       => thold_PHYEMAC0RXCLKCORCNT_PHYEMAC0GTXCLK_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC0RXCLKCORCNT1_PHYEMAC0GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC0RXCLKCORCNT1_PHYEMAC0GTXCLK_posedge,
         TestSignal     => PHYEMAC0RXCLKCORCNT_dly(1),
         TestSignalName => "PHYEMAC0RXCLKCORCNT(1)",
         TestDelay      => tisd_PHYEMAC0RXCLKCORCNT(1),
         RefSignal      => PHYEMAC0GTXCLK_dly,
         RefSignalName  => "PHYEMAC0GTXCLK",
         RefDelay       => ticd_PHYEMAC0GTXCLK,
         SetupHigh      => tsetup_PHYEMAC0RXCLKCORCNT_PHYEMAC0GTXCLK_posedge_posedge(1),
         SetupLow       => tsetup_PHYEMAC0RXCLKCORCNT_PHYEMAC0GTXCLK_negedge_posedge(1),
         HoldLow        => thold_PHYEMAC0RXCLKCORCNT_PHYEMAC0GTXCLK_posedge_posedge(1),
         HoldHigh       => thold_PHYEMAC0RXCLKCORCNT_PHYEMAC0GTXCLK_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC0RXCLKCORCNT2_PHYEMAC0GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC0RXCLKCORCNT2_PHYEMAC0GTXCLK_posedge,
         TestSignal     => PHYEMAC0RXCLKCORCNT_dly(2),
         TestSignalName => "PHYEMAC0RXCLKCORCNT(2)",
         TestDelay      => tisd_PHYEMAC0RXCLKCORCNT(2),
         RefSignal      => PHYEMAC0GTXCLK_dly,
         RefSignalName  => "PHYEMAC0GTXCLK",
         RefDelay       => ticd_PHYEMAC0GTXCLK,
         SetupHigh      => tsetup_PHYEMAC0RXCLKCORCNT_PHYEMAC0GTXCLK_posedge_posedge(2),
         SetupLow       => tsetup_PHYEMAC0RXCLKCORCNT_PHYEMAC0GTXCLK_negedge_posedge(2),
         HoldLow        => thold_PHYEMAC0RXCLKCORCNT_PHYEMAC0GTXCLK_posedge_posedge(2),
         HoldHigh       => thold_PHYEMAC0RXCLKCORCNT_PHYEMAC0GTXCLK_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC0RXCOMMADET_PHYEMAC0GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC0RXCOMMADET_PHYEMAC0GTXCLK_posedge,
         TestSignal     => PHYEMAC0RXCOMMADET,
         TestSignalName => "PHYEMAC0RXCOMMADET",
         TestDelay      => 0 ns,
         RefSignal      => PHYEMAC0GTXCLK_dly,
         RefSignalName  => "PHYEMAC0GTXCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PHYEMAC0RXCOMMADET_PHYEMAC0GTXCLK_posedge_posedge,
         SetupLow       => tsetup_PHYEMAC0RXCOMMADET_PHYEMAC0GTXCLK_negedge_posedge,
         HoldLow        => thold_PHYEMAC0RXCOMMADET_PHYEMAC0GTXCLK_posedge_posedge,
         HoldHigh       => thold_PHYEMAC0RXCOMMADET_PHYEMAC0GTXCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC0RXD0_PHYEMAC0RXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC0RXD0_PHYEMAC0RXCLK_posedge,
         TestSignal     => PHYEMAC0RXD_dly(0),
         TestSignalName => "PHYEMAC0RXD(0)",
         TestDelay      => tisd_PHYEMAC0RXD(0),
         RefSignal      => PHYEMAC0RXCLK_dly,
         RefSignalName  => "PHYEMAC0RXCLK",
         RefDelay       => ticd_PHYEMAC0RXCLK,
         SetupHigh      => tsetup_PHYEMAC0RXD_PHYEMAC0RXCLK_posedge_posedge(0),
         SetupLow       => tsetup_PHYEMAC0RXD_PHYEMAC0RXCLK_negedge_posedge(0),
         HoldLow        => thold_PHYEMAC0RXD_PHYEMAC0RXCLK_posedge_posedge(0),
         HoldHigh       => thold_PHYEMAC0RXD_PHYEMAC0RXCLK_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC0RXD1_PHYEMAC0RXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC0RXD1_PHYEMAC0RXCLK_posedge,
         TestSignal     => PHYEMAC0RXD_dly(1),
         TestSignalName => "PHYEMAC0RXD(1)",
         TestDelay      => tisd_PHYEMAC0RXD(1),
         RefSignal      => PHYEMAC0RXCLK_dly,
         RefSignalName  => "PHYEMAC0RXCLK",
         RefDelay       => ticd_PHYEMAC0RXCLK,
         SetupHigh      => tsetup_PHYEMAC0RXD_PHYEMAC0RXCLK_posedge_posedge(1),
         SetupLow       => tsetup_PHYEMAC0RXD_PHYEMAC0RXCLK_negedge_posedge(1),
         HoldLow        => thold_PHYEMAC0RXD_PHYEMAC0RXCLK_posedge_posedge(1),
         HoldHigh       => thold_PHYEMAC0RXD_PHYEMAC0RXCLK_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC0RXD2_PHYEMAC0RXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC0RXD2_PHYEMAC0RXCLK_posedge,
         TestSignal     => PHYEMAC0RXD_dly(2),
         TestSignalName => "PHYEMAC0RXD(2)",
         TestDelay      => tisd_PHYEMAC0RXD(2),
         RefSignal      => PHYEMAC0RXCLK_dly,
         RefSignalName  => "PHYEMAC0RXCLK",
         RefDelay       => ticd_PHYEMAC0RXCLK,
         SetupHigh      => tsetup_PHYEMAC0RXD_PHYEMAC0RXCLK_posedge_posedge(2),
         SetupLow       => tsetup_PHYEMAC0RXD_PHYEMAC0RXCLK_negedge_posedge(2),
         HoldLow        => thold_PHYEMAC0RXD_PHYEMAC0RXCLK_posedge_posedge(2),
         HoldHigh       => thold_PHYEMAC0RXD_PHYEMAC0RXCLK_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC0RXD3_PHYEMAC0RXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC0RXD3_PHYEMAC0RXCLK_posedge,
         TestSignal     => PHYEMAC0RXD_dly(3),
         TestSignalName => "PHYEMAC0RXD(3)",
         TestDelay      => tisd_PHYEMAC0RXD(3),
         RefSignal      => PHYEMAC0RXCLK_dly,
         RefSignalName  => "PHYEMAC0RXCLK",
         RefDelay       => ticd_PHYEMAC0RXCLK,
         SetupHigh      => tsetup_PHYEMAC0RXD_PHYEMAC0RXCLK_posedge_posedge(3),
         SetupLow       => tsetup_PHYEMAC0RXD_PHYEMAC0RXCLK_negedge_posedge(3),
         HoldLow        => thold_PHYEMAC0RXD_PHYEMAC0RXCLK_posedge_posedge(3),
         HoldHigh       => thold_PHYEMAC0RXD_PHYEMAC0RXCLK_negedge_posedge(3),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC0RXD4_PHYEMAC0RXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC0RXD4_PHYEMAC0RXCLK_posedge,
         TestSignal     => PHYEMAC0RXD_dly(4),
         TestSignalName => "PHYEMAC0RXD(4)",
         TestDelay      => tisd_PHYEMAC0RXD(4),
         RefSignal      => PHYEMAC0RXCLK_dly,
         RefSignalName  => "PHYEMAC0RXCLK",
         RefDelay       => ticd_PHYEMAC0RXCLK,
         SetupHigh      => tsetup_PHYEMAC0RXD_PHYEMAC0RXCLK_posedge_posedge(4),
         SetupLow       => tsetup_PHYEMAC0RXD_PHYEMAC0RXCLK_negedge_posedge(4),
         HoldLow        => thold_PHYEMAC0RXD_PHYEMAC0RXCLK_posedge_posedge(4),
         HoldHigh       => thold_PHYEMAC0RXD_PHYEMAC0RXCLK_negedge_posedge(4),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC0RXD5_PHYEMAC0RXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC0RXD5_PHYEMAC0RXCLK_posedge,
         TestSignal     => PHYEMAC0RXD_dly(5),
         TestSignalName => "PHYEMAC0RXD(5)",
         TestDelay      => tisd_PHYEMAC0RXD(5),
         RefSignal      => PHYEMAC0RXCLK_dly,
         RefSignalName  => "PHYEMAC0RXCLK",
         RefDelay       => ticd_PHYEMAC0RXCLK,
         SetupHigh      => tsetup_PHYEMAC0RXD_PHYEMAC0RXCLK_posedge_posedge(5),
         SetupLow       => tsetup_PHYEMAC0RXD_PHYEMAC0RXCLK_negedge_posedge(5),
         HoldLow        => thold_PHYEMAC0RXD_PHYEMAC0RXCLK_posedge_posedge(5),
         HoldHigh       => thold_PHYEMAC0RXD_PHYEMAC0RXCLK_negedge_posedge(5),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC0RXD6_PHYEMAC0RXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC0RXD6_PHYEMAC0RXCLK_posedge,
         TestSignal     => PHYEMAC0RXD_dly(6),
         TestSignalName => "PHYEMAC0RXD(6)",
         TestDelay      => tisd_PHYEMAC0RXD(6),
         RefSignal      => PHYEMAC0RXCLK_dly,
         RefSignalName  => "PHYEMAC0RXCLK",
         RefDelay       => ticd_PHYEMAC0RXCLK,
         SetupHigh      => tsetup_PHYEMAC0RXD_PHYEMAC0RXCLK_posedge_posedge(6),
         SetupLow       => tsetup_PHYEMAC0RXD_PHYEMAC0RXCLK_negedge_posedge(6),
         HoldLow        => thold_PHYEMAC0RXD_PHYEMAC0RXCLK_posedge_posedge(6),
         HoldHigh       => thold_PHYEMAC0RXD_PHYEMAC0RXCLK_negedge_posedge(6),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC0RXD7_PHYEMAC0RXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC0RXD7_PHYEMAC0RXCLK_posedge,
         TestSignal     => PHYEMAC0RXD_dly(7),
         TestSignalName => "PHYEMAC0RXD(7)",
         TestDelay      => tisd_PHYEMAC0RXD(7),
         RefSignal      => PHYEMAC0RXCLK_dly,
         RefSignalName  => "PHYEMAC0RXCLK",
         RefDelay       => ticd_PHYEMAC0RXCLK,
         SetupHigh      => tsetup_PHYEMAC0RXD_PHYEMAC0RXCLK_posedge_posedge(7),
         SetupLow       => tsetup_PHYEMAC0RXD_PHYEMAC0RXCLK_negedge_posedge(7),
         HoldLow        => thold_PHYEMAC0RXD_PHYEMAC0RXCLK_posedge_posedge(7),
         HoldHigh       => thold_PHYEMAC0RXD_PHYEMAC0RXCLK_negedge_posedge(7),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC0RXDISPERR_PHYEMAC0GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC0RXDISPERR_PHYEMAC0GTXCLK_posedge,
         TestSignal     => PHYEMAC0RXDISPERR,
         TestSignalName => "PHYEMAC0RXDISPERR",
         TestDelay      => 0 ns,
         RefSignal      => PHYEMAC0GTXCLK_dly,
         RefSignalName  => "PHYEMAC0GTXCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PHYEMAC0RXDISPERR_PHYEMAC0GTXCLK_posedge_posedge,
         SetupLow       => tsetup_PHYEMAC0RXDISPERR_PHYEMAC0GTXCLK_negedge_posedge,
         HoldLow        => thold_PHYEMAC0RXDISPERR_PHYEMAC0GTXCLK_posedge_posedge,
         HoldHigh       => thold_PHYEMAC0RXDISPERR_PHYEMAC0GTXCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC0RXDV_PHYEMAC0RXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC0RXDV_PHYEMAC0RXCLK_posedge,
         TestSignal     => PHYEMAC0RXDV,
         TestSignalName => "PHYEMAC0RXDV",
         TestDelay      => 0 ns,
         RefSignal      => PHYEMAC0RXCLK_dly,
         RefSignalName  => "PHYEMAC0RXCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PHYEMAC0RXDV_PHYEMAC0RXCLK_posedge_posedge,
         SetupLow       => tsetup_PHYEMAC0RXDV_PHYEMAC0RXCLK_negedge_posedge,
         HoldLow        => thold_PHYEMAC0RXDV_PHYEMAC0RXCLK_posedge_posedge,
         HoldHigh       => thold_PHYEMAC0RXDV_PHYEMAC0RXCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC0RXER_PHYEMAC0RXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC0RXER_PHYEMAC0RXCLK_posedge,
         TestSignal     => PHYEMAC0RXER,
         TestSignalName => "PHYEMAC0RXER",
         TestDelay      => 0 ns,
         RefSignal      => PHYEMAC0RXCLK_dly,
         RefSignalName  => "PHYEMAC0RXCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PHYEMAC0RXER_PHYEMAC0RXCLK_posedge_posedge,
         SetupLow       => tsetup_PHYEMAC0RXER_PHYEMAC0RXCLK_negedge_posedge,
         HoldLow        => thold_PHYEMAC0RXER_PHYEMAC0RXCLK_posedge_posedge,
         HoldHigh       => thold_PHYEMAC0RXER_PHYEMAC0RXCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC0RXLOSSOFSYNC0_PHYEMAC0GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC0RXLOSSOFSYNC0_PHYEMAC0GTXCLK_posedge,
         TestSignal     => PHYEMAC0RXLOSSOFSYNC_dly(0),
         TestSignalName => "PHYEMAC0RXLOSSOFSYNC(0)",
         TestDelay      => tisd_PHYEMAC0RXLOSSOFSYNC(0),
         RefSignal      => PHYEMAC0GTXCLK_dly,
         RefSignalName  => "PHYEMAC0GTXCLK",
         RefDelay       => ticd_PHYEMAC0GTXCLK,
         SetupHigh      => tsetup_PHYEMAC0RXLOSSOFSYNC_PHYEMAC0GTXCLK_posedge_posedge(0),
         SetupLow       => tsetup_PHYEMAC0RXLOSSOFSYNC_PHYEMAC0GTXCLK_negedge_posedge(0),
         HoldLow        => thold_PHYEMAC0RXLOSSOFSYNC_PHYEMAC0GTXCLK_posedge_posedge(0),
         HoldHigh       => thold_PHYEMAC0RXLOSSOFSYNC_PHYEMAC0GTXCLK_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC0RXLOSSOFSYNC1_PHYEMAC0GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC0RXLOSSOFSYNC1_PHYEMAC0GTXCLK_posedge,
         TestSignal     => PHYEMAC0RXLOSSOFSYNC_dly(1),
         TestSignalName => "PHYEMAC0RXLOSSOFSYNC(1)",
         TestDelay      => tisd_PHYEMAC0RXLOSSOFSYNC(1),
         RefSignal      => PHYEMAC0GTXCLK_dly,
         RefSignalName  => "PHYEMAC0GTXCLK",
         RefDelay       => ticd_PHYEMAC0GTXCLK,
         SetupHigh      => tsetup_PHYEMAC0RXLOSSOFSYNC_PHYEMAC0GTXCLK_posedge_posedge(1),
         SetupLow       => tsetup_PHYEMAC0RXLOSSOFSYNC_PHYEMAC0GTXCLK_negedge_posedge(1),
         HoldLow        => thold_PHYEMAC0RXLOSSOFSYNC_PHYEMAC0GTXCLK_posedge_posedge(1),
         HoldHigh       => thold_PHYEMAC0RXLOSSOFSYNC_PHYEMAC0GTXCLK_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC0RXNOTINTABLE_PHYEMAC0GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC0RXNOTINTABLE_PHYEMAC0GTXCLK_posedge,
         TestSignal     => PHYEMAC0RXNOTINTABLE,
         TestSignalName => "PHYEMAC0RXNOTINTABLE",
         TestDelay      => 0 ns,
         RefSignal      => PHYEMAC0GTXCLK_dly,
         RefSignalName  => "PHYEMAC0GTXCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PHYEMAC0RXNOTINTABLE_PHYEMAC0GTXCLK_posedge_posedge,
         SetupLow       => tsetup_PHYEMAC0RXNOTINTABLE_PHYEMAC0GTXCLK_negedge_posedge,
         HoldLow        => thold_PHYEMAC0RXNOTINTABLE_PHYEMAC0GTXCLK_posedge_posedge,
         HoldHigh       => thold_PHYEMAC0RXNOTINTABLE_PHYEMAC0GTXCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC0RXRUNDISP_PHYEMAC0GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC0RXRUNDISP_PHYEMAC0GTXCLK_posedge,
         TestSignal     => PHYEMAC0RXRUNDISP,
         TestSignalName => "PHYEMAC0RXRUNDISP",
         TestDelay      => 0 ns,
         RefSignal      => PHYEMAC0GTXCLK_dly,
         RefSignalName  => "PHYEMAC0GTXCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PHYEMAC0RXRUNDISP_PHYEMAC0GTXCLK_posedge_posedge,
         SetupLow       => tsetup_PHYEMAC0RXRUNDISP_PHYEMAC0GTXCLK_negedge_posedge,
         HoldLow        => thold_PHYEMAC0RXRUNDISP_PHYEMAC0GTXCLK_posedge_posedge,
         HoldHigh       => thold_PHYEMAC0RXRUNDISP_PHYEMAC0GTXCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC0TXBUFERR_PHYEMAC0GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC0TXBUFERR_PHYEMAC0GTXCLK_posedge,
         TestSignal     => PHYEMAC0TXBUFERR,
         TestSignalName => "PHYEMAC0TXBUFERR",
         TestDelay      => 0 ns,
         RefSignal      => PHYEMAC0GTXCLK_dly,
         RefSignalName  => "PHYEMAC0GTXCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PHYEMAC0TXBUFERR_PHYEMAC0GTXCLK_posedge_posedge,
         SetupLow       => tsetup_PHYEMAC0TXBUFERR_PHYEMAC0GTXCLK_negedge_posedge,
         HoldLow        => thold_PHYEMAC0TXBUFERR_PHYEMAC0GTXCLK_posedge_posedge,
         HoldHigh       => thold_PHYEMAC0TXBUFERR_PHYEMAC0GTXCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC1COL_PHYEMAC1RXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC1COL_PHYEMAC1RXCLK_posedge,
         TestSignal     => PHYEMAC1COL,
         TestSignalName => "PHYEMAC1COL",
         TestDelay      => 0 ns,
         RefSignal      => PHYEMAC1RXCLK_dly,
         RefSignalName  => "PHYEMAC1RXCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PHYEMAC1COL_PHYEMAC1RXCLK_posedge_posedge,
         SetupLow       => tsetup_PHYEMAC1COL_PHYEMAC1RXCLK_negedge_posedge,
         HoldLow        => thold_PHYEMAC1COL_PHYEMAC1RXCLK_posedge_posedge,
         HoldHigh       => thold_PHYEMAC1COL_PHYEMAC1RXCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC1CRS_PHYEMAC1RXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC1CRS_PHYEMAC1RXCLK_posedge,
         TestSignal     => PHYEMAC1CRS,
         TestSignalName => "PHYEMAC1CRS",
         TestDelay      => 0 ns,
         RefSignal      => PHYEMAC1RXCLK_dly,
         RefSignalName  => "PHYEMAC1RXCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PHYEMAC1CRS_PHYEMAC1RXCLK_posedge_posedge,
         SetupLow       => tsetup_PHYEMAC1CRS_PHYEMAC1RXCLK_negedge_posedge,
         HoldLow        => thold_PHYEMAC1CRS_PHYEMAC1RXCLK_posedge_posedge,
         HoldHigh       => thold_PHYEMAC1CRS_PHYEMAC1RXCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC1MDIN_HOSTCLK_posedge,
         TimingData     => Tmkr_PHYEMAC1MDIN_HOSTCLK_posedge,
         TestSignal     => PHYEMAC1MDIN,
         TestSignalName => "PHYEMAC1MDIN",
         TestDelay      => 0 ns,
         RefSignal      => HOSTCLK_dly,
         RefSignalName  => "HOSTCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PHYEMAC1MDIN_HOSTCLK_posedge_posedge,
         SetupLow       => tsetup_PHYEMAC1MDIN_HOSTCLK_negedge_posedge,
         HoldLow        => thold_PHYEMAC1MDIN_HOSTCLK_posedge_posedge,
         HoldHigh       => thold_PHYEMAC1MDIN_HOSTCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC1MDIN_PHYEMAC1MCLKIN_posedge,
         TimingData     => Tmkr_PHYEMAC1MDIN_PHYEMAC1MCLKIN_posedge,
         TestSignal     => PHYEMAC1MDIN,
         TestSignalName => "PHYEMAC1MDIN",
         TestDelay      => tisd_PHYEMAC1MDIN,
         RefSignal      => PHYEMAC1MCLKIN_dly,
         RefSignalName  => "PHYEMAC1MCLKIN",
         RefDelay       => ticd_PHYEMAC1MCLKIN,
         SetupHigh      => tsetup_PHYEMAC1MDIN_PHYEMAC1MCLKIN_posedge_posedge,
         SetupLow       => tsetup_PHYEMAC1MDIN_PHYEMAC1MCLKIN_negedge_posedge,
         HoldLow        => thold_PHYEMAC1MDIN_PHYEMAC1MCLKIN_posedge_posedge,
         HoldHigh       => thold_PHYEMAC1MDIN_PHYEMAC1MCLKIN_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );     
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC1RXBUFERR_PHYEMAC1GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC1RXBUFERR_PHYEMAC1GTXCLK_posedge,
         TestSignal     => PHYEMAC1RXBUFERR,
         TestSignalName => "PHYEMAC1RXBUFERR",
         TestDelay      => 0 ns,
         RefSignal      => PHYEMAC1GTXCLK_dly,
         RefSignalName  => "PHYEMAC1GTXCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PHYEMAC1RXBUFERR_PHYEMAC1GTXCLK_posedge_posedge,
         SetupLow       => tsetup_PHYEMAC1RXBUFERR_PHYEMAC1GTXCLK_negedge_posedge,
         HoldLow        => thold_PHYEMAC1RXBUFERR_PHYEMAC1GTXCLK_posedge_posedge,
         HoldHigh       => thold_PHYEMAC1RXBUFERR_PHYEMAC1GTXCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC1RXBUFSTATUS0_PHYEMAC1GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC1RXBUFSTATUS0_PHYEMAC1GTXCLK_posedge,
         TestSignal     => PHYEMAC1RXBUFSTATUS_dly(0),
         TestSignalName => "PHYEMAC1RXBUFSTATUS(0)",
         TestDelay      => tisd_PHYEMAC1RXBUFSTATUS(0),
         RefSignal      => PHYEMAC1GTXCLK_dly,
         RefSignalName  => "PHYEMAC1GTXCLK",
         RefDelay       => ticd_PHYEMAC1GTXCLK,
         SetupHigh      => tsetup_PHYEMAC1RXBUFSTATUS_PHYEMAC1GTXCLK_posedge_posedge(0),
         SetupLow       => tsetup_PHYEMAC1RXBUFSTATUS_PHYEMAC1GTXCLK_negedge_posedge(0),
         HoldLow        => thold_PHYEMAC1RXBUFSTATUS_PHYEMAC1GTXCLK_posedge_posedge(0),
         HoldHigh       => thold_PHYEMAC1RXBUFSTATUS_PHYEMAC1GTXCLK_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC1RXBUFSTATUS1_PHYEMAC1GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC1RXBUFSTATUS1_PHYEMAC1GTXCLK_posedge,
         TestSignal     => PHYEMAC1RXBUFSTATUS_dly(1),
         TestSignalName => "PHYEMAC1RXBUFSTATUS(1)",
         TestDelay      => tisd_PHYEMAC1RXBUFSTATUS(1),
         RefSignal      => PHYEMAC1GTXCLK_dly,
         RefSignalName  => "PHYEMAC1GTXCLK",
         RefDelay       => ticd_PHYEMAC1GTXCLK,
         SetupHigh      => tsetup_PHYEMAC1RXBUFSTATUS_PHYEMAC1GTXCLK_posedge_posedge(1),
         SetupLow       => tsetup_PHYEMAC1RXBUFSTATUS_PHYEMAC1GTXCLK_negedge_posedge(1),
         HoldLow        => thold_PHYEMAC1RXBUFSTATUS_PHYEMAC1GTXCLK_posedge_posedge(1),
         HoldHigh       => thold_PHYEMAC1RXBUFSTATUS_PHYEMAC1GTXCLK_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC1RXCHARISCOMMA_PHYEMAC1GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC1RXCHARISCOMMA_PHYEMAC1GTXCLK_posedge,
         TestSignal     => PHYEMAC1RXCHARISCOMMA,
         TestSignalName => "PHYEMAC1RXCHARISCOMMA",
         TestDelay      => 0 ns,
         RefSignal      => PHYEMAC1GTXCLK_dly,
         RefSignalName  => "PHYEMAC1GTXCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PHYEMAC1RXCHARISCOMMA_PHYEMAC1GTXCLK_posedge_posedge,
         SetupLow       => tsetup_PHYEMAC1RXCHARISCOMMA_PHYEMAC1GTXCLK_negedge_posedge,
         HoldLow        => thold_PHYEMAC1RXCHARISCOMMA_PHYEMAC1GTXCLK_posedge_posedge,
         HoldHigh       => thold_PHYEMAC1RXCHARISCOMMA_PHYEMAC1GTXCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC1RXCHARISK_PHYEMAC1GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC1RXCHARISK_PHYEMAC1GTXCLK_posedge,
         TestSignal     => PHYEMAC1RXCHARISK,
         TestSignalName => "PHYEMAC1RXCHARISK",
         TestDelay      => 0 ns,
         RefSignal      => PHYEMAC1GTXCLK_dly,
         RefSignalName  => "PHYEMAC1GTXCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PHYEMAC1RXCHARISK_PHYEMAC1GTXCLK_posedge_posedge,
         SetupLow       => tsetup_PHYEMAC1RXCHARISK_PHYEMAC1GTXCLK_negedge_posedge,
         HoldLow        => thold_PHYEMAC1RXCHARISK_PHYEMAC1GTXCLK_posedge_posedge,
         HoldHigh       => thold_PHYEMAC1RXCHARISK_PHYEMAC1GTXCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC1RXCHECKINGCRC_PHYEMAC1GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC1RXCHECKINGCRC_PHYEMAC1GTXCLK_posedge,
         TestSignal     => PHYEMAC1RXCHECKINGCRC,
         TestSignalName => "PHYEMAC1RXCHECKINGCRC",
         TestDelay      => 0 ns,
         RefSignal      => PHYEMAC1GTXCLK_dly,
         RefSignalName  => "PHYEMAC1GTXCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PHYEMAC1RXCHECKINGCRC_PHYEMAC1GTXCLK_posedge_posedge,
         SetupLow       => tsetup_PHYEMAC1RXCHECKINGCRC_PHYEMAC1GTXCLK_negedge_posedge,
         HoldLow        => thold_PHYEMAC1RXCHECKINGCRC_PHYEMAC1GTXCLK_posedge_posedge,
         HoldHigh       => thold_PHYEMAC1RXCHECKINGCRC_PHYEMAC1GTXCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC1RXCLKCORCNT0_PHYEMAC1GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC1RXCLKCORCNT0_PHYEMAC1GTXCLK_posedge,
         TestSignal     => PHYEMAC1RXCLKCORCNT_dly(0),
         TestSignalName => "PHYEMAC1RXCLKCORCNT(0)",
         TestDelay      => tisd_PHYEMAC1RXCLKCORCNT(0),
         RefSignal      => PHYEMAC1GTXCLK_dly,
         RefSignalName  => "PHYEMAC1GTXCLK",
         RefDelay       => ticd_PHYEMAC1GTXCLK,
         SetupHigh      => tsetup_PHYEMAC1RXCLKCORCNT_PHYEMAC1GTXCLK_posedge_posedge(0),
         SetupLow       => tsetup_PHYEMAC1RXCLKCORCNT_PHYEMAC1GTXCLK_negedge_posedge(0),
         HoldLow        => thold_PHYEMAC1RXCLKCORCNT_PHYEMAC1GTXCLK_posedge_posedge(0),
         HoldHigh       => thold_PHYEMAC1RXCLKCORCNT_PHYEMAC1GTXCLK_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC1RXCLKCORCNT1_PHYEMAC1GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC1RXCLKCORCNT1_PHYEMAC1GTXCLK_posedge,
         TestSignal     => PHYEMAC1RXCLKCORCNT_dly(1),
         TestSignalName => "PHYEMAC1RXCLKCORCNT(1)",
         TestDelay      => tisd_PHYEMAC1RXCLKCORCNT(1),
         RefSignal      => PHYEMAC1GTXCLK_dly,
         RefSignalName  => "PHYEMAC1GTXCLK",
         RefDelay       => ticd_PHYEMAC1GTXCLK,
         SetupHigh      => tsetup_PHYEMAC1RXCLKCORCNT_PHYEMAC1GTXCLK_posedge_posedge(1),
         SetupLow       => tsetup_PHYEMAC1RXCLKCORCNT_PHYEMAC1GTXCLK_negedge_posedge(1),
         HoldLow        => thold_PHYEMAC1RXCLKCORCNT_PHYEMAC1GTXCLK_posedge_posedge(1),
         HoldHigh       => thold_PHYEMAC1RXCLKCORCNT_PHYEMAC1GTXCLK_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC1RXCLKCORCNT2_PHYEMAC1GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC1RXCLKCORCNT2_PHYEMAC1GTXCLK_posedge,
         TestSignal     => PHYEMAC1RXCLKCORCNT_dly(2),
         TestSignalName => "PHYEMAC1RXCLKCORCNT(2)",
         TestDelay      => tisd_PHYEMAC1RXCLKCORCNT(2),
         RefSignal      => PHYEMAC1GTXCLK_dly,
         RefSignalName  => "PHYEMAC1GTXCLK",
         RefDelay       => ticd_PHYEMAC1GTXCLK,
         SetupHigh      => tsetup_PHYEMAC1RXCLKCORCNT_PHYEMAC1GTXCLK_posedge_posedge(2),
         SetupLow       => tsetup_PHYEMAC1RXCLKCORCNT_PHYEMAC1GTXCLK_negedge_posedge(2),
         HoldLow        => thold_PHYEMAC1RXCLKCORCNT_PHYEMAC1GTXCLK_posedge_posedge(2),
         HoldHigh       => thold_PHYEMAC1RXCLKCORCNT_PHYEMAC1GTXCLK_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC1RXCOMMADET_PHYEMAC1GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC1RXCOMMADET_PHYEMAC1GTXCLK_posedge,
         TestSignal     => PHYEMAC1RXCOMMADET,
         TestSignalName => "PHYEMAC1RXCOMMADET",
         TestDelay      => 0 ns,
         RefSignal      => PHYEMAC1GTXCLK_dly,
         RefSignalName  => "PHYEMAC1GTXCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PHYEMAC1RXCOMMADET_PHYEMAC1GTXCLK_posedge_posedge,
         SetupLow       => tsetup_PHYEMAC1RXCOMMADET_PHYEMAC1GTXCLK_negedge_posedge,
         HoldLow        => thold_PHYEMAC1RXCOMMADET_PHYEMAC1GTXCLK_posedge_posedge,
         HoldHigh       => thold_PHYEMAC1RXCOMMADET_PHYEMAC1GTXCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC1RXD0_PHYEMAC1RXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC1RXD0_PHYEMAC1RXCLK_posedge,
         TestSignal     => PHYEMAC1RXD_dly(0),
         TestSignalName => "PHYEMAC1RXD(0)",
         TestDelay      => tisd_PHYEMAC1RXD(0),
         RefSignal      => PHYEMAC1RXCLK_dly,
         RefSignalName  => "PHYEMAC1RXCLK",
         RefDelay       => ticd_PHYEMAC1RXCLK,
         SetupHigh      => tsetup_PHYEMAC1RXD_PHYEMAC1RXCLK_posedge_posedge(0),
         SetupLow       => tsetup_PHYEMAC1RXD_PHYEMAC1RXCLK_negedge_posedge(0),
         HoldLow        => thold_PHYEMAC1RXD_PHYEMAC1RXCLK_posedge_posedge(0),
         HoldHigh       => thold_PHYEMAC1RXD_PHYEMAC1RXCLK_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC1RXD1_PHYEMAC1RXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC1RXD1_PHYEMAC1RXCLK_posedge,
         TestSignal     => PHYEMAC1RXD_dly(1),
         TestSignalName => "PHYEMAC1RXD(1)",
         TestDelay      => tisd_PHYEMAC1RXD(1),
         RefSignal      => PHYEMAC1RXCLK_dly,
         RefSignalName  => "PHYEMAC1RXCLK",
         RefDelay       => ticd_PHYEMAC1RXCLK,
         SetupHigh      => tsetup_PHYEMAC1RXD_PHYEMAC1RXCLK_posedge_posedge(1),
         SetupLow       => tsetup_PHYEMAC1RXD_PHYEMAC1RXCLK_negedge_posedge(1),
         HoldLow        => thold_PHYEMAC1RXD_PHYEMAC1RXCLK_posedge_posedge(1),
         HoldHigh       => thold_PHYEMAC1RXD_PHYEMAC1RXCLK_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC1RXD2_PHYEMAC1RXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC1RXD2_PHYEMAC1RXCLK_posedge,
         TestSignal     => PHYEMAC1RXD_dly(2),
         TestSignalName => "PHYEMAC1RXD(2)",
         TestDelay      => tisd_PHYEMAC1RXD(2),
         RefSignal      => PHYEMAC1RXCLK_dly,
         RefSignalName  => "PHYEMAC1RXCLK",
         RefDelay       => ticd_PHYEMAC1RXCLK,
         SetupHigh      => tsetup_PHYEMAC1RXD_PHYEMAC1RXCLK_posedge_posedge(2),
         SetupLow       => tsetup_PHYEMAC1RXD_PHYEMAC1RXCLK_negedge_posedge(2),
         HoldLow        => thold_PHYEMAC1RXD_PHYEMAC1RXCLK_posedge_posedge(2),
         HoldHigh       => thold_PHYEMAC1RXD_PHYEMAC1RXCLK_negedge_posedge(2),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC1RXD3_PHYEMAC1RXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC1RXD3_PHYEMAC1RXCLK_posedge,
         TestSignal     => PHYEMAC1RXD_dly(3),
         TestSignalName => "PHYEMAC1RXD(3)",
         TestDelay      => tisd_PHYEMAC1RXD(3),
         RefSignal      => PHYEMAC1RXCLK_dly,
         RefSignalName  => "PHYEMAC1RXCLK",
         RefDelay       => ticd_PHYEMAC1RXCLK,
         SetupHigh      => tsetup_PHYEMAC1RXD_PHYEMAC1RXCLK_posedge_posedge(3),
         SetupLow       => tsetup_PHYEMAC1RXD_PHYEMAC1RXCLK_negedge_posedge(3),
         HoldLow        => thold_PHYEMAC1RXD_PHYEMAC1RXCLK_posedge_posedge(3),
         HoldHigh       => thold_PHYEMAC1RXD_PHYEMAC1RXCLK_negedge_posedge(3),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC1RXD4_PHYEMAC1RXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC1RXD4_PHYEMAC1RXCLK_posedge,
         TestSignal     => PHYEMAC1RXD_dly(4),
         TestSignalName => "PHYEMAC1RXD(4)",
         TestDelay      => tisd_PHYEMAC1RXD(4),
         RefSignal      => PHYEMAC1RXCLK_dly,
         RefSignalName  => "PHYEMAC1RXCLK",
         RefDelay       => ticd_PHYEMAC1RXCLK,
         SetupHigh      => tsetup_PHYEMAC1RXD_PHYEMAC1RXCLK_posedge_posedge(4),
         SetupLow       => tsetup_PHYEMAC1RXD_PHYEMAC1RXCLK_negedge_posedge(4),
         HoldLow        => thold_PHYEMAC1RXD_PHYEMAC1RXCLK_posedge_posedge(4),
         HoldHigh       => thold_PHYEMAC1RXD_PHYEMAC1RXCLK_negedge_posedge(4),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC1RXD5_PHYEMAC1RXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC1RXD5_PHYEMAC1RXCLK_posedge,
         TestSignal     => PHYEMAC1RXD_dly(5),
         TestSignalName => "PHYEMAC1RXD(5)",
         TestDelay      => tisd_PHYEMAC1RXD(5),
         RefSignal      => PHYEMAC1RXCLK_dly,
         RefSignalName  => "PHYEMAC1RXCLK",
         RefDelay       => ticd_PHYEMAC1RXCLK,
         SetupHigh      => tsetup_PHYEMAC1RXD_PHYEMAC1RXCLK_posedge_posedge(5),
         SetupLow       => tsetup_PHYEMAC1RXD_PHYEMAC1RXCLK_negedge_posedge(5),
         HoldLow        => thold_PHYEMAC1RXD_PHYEMAC1RXCLK_posedge_posedge(5),
         HoldHigh       => thold_PHYEMAC1RXD_PHYEMAC1RXCLK_negedge_posedge(5),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC1RXD6_PHYEMAC1RXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC1RXD6_PHYEMAC1RXCLK_posedge,
         TestSignal     => PHYEMAC1RXD_dly(6),
         TestSignalName => "PHYEMAC1RXD(6)",
         TestDelay      => tisd_PHYEMAC1RXD(6),
         RefSignal      => PHYEMAC1RXCLK_dly,
         RefSignalName  => "PHYEMAC1RXCLK",
         RefDelay       => ticd_PHYEMAC1RXCLK,
         SetupHigh      => tsetup_PHYEMAC1RXD_PHYEMAC1RXCLK_posedge_posedge(6),
         SetupLow       => tsetup_PHYEMAC1RXD_PHYEMAC1RXCLK_negedge_posedge(6),
         HoldLow        => thold_PHYEMAC1RXD_PHYEMAC1RXCLK_posedge_posedge(6),
         HoldHigh       => thold_PHYEMAC1RXD_PHYEMAC1RXCLK_negedge_posedge(6),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC1RXD7_PHYEMAC1RXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC1RXD7_PHYEMAC1RXCLK_posedge,
         TestSignal     => PHYEMAC1RXD_dly(7),
         TestSignalName => "PHYEMAC1RXD(7)",
         TestDelay      => tisd_PHYEMAC1RXD(7),
         RefSignal      => PHYEMAC1RXCLK_dly,
         RefSignalName  => "PHYEMAC1RXCLK",
         RefDelay       => ticd_PHYEMAC1RXCLK,
         SetupHigh      => tsetup_PHYEMAC1RXD_PHYEMAC1RXCLK_posedge_posedge(7),
         SetupLow       => tsetup_PHYEMAC1RXD_PHYEMAC1RXCLK_negedge_posedge(7),
         HoldLow        => thold_PHYEMAC1RXD_PHYEMAC1RXCLK_posedge_posedge(7),
         HoldHigh       => thold_PHYEMAC1RXD_PHYEMAC1RXCLK_negedge_posedge(7),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC1RXDISPERR_PHYEMAC1GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC1RXDISPERR_PHYEMAC1GTXCLK_posedge,
         TestSignal     => PHYEMAC1RXDISPERR,
         TestSignalName => "PHYEMAC1RXDISPERR",
         TestDelay      => 0 ns,
         RefSignal      => PHYEMAC1GTXCLK_dly,
         RefSignalName  => "PHYEMAC1GTXCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PHYEMAC1RXDISPERR_PHYEMAC1GTXCLK_posedge_posedge,
         SetupLow       => tsetup_PHYEMAC1RXDISPERR_PHYEMAC1GTXCLK_negedge_posedge,
         HoldLow        => thold_PHYEMAC1RXDISPERR_PHYEMAC1GTXCLK_posedge_posedge,
         HoldHigh       => thold_PHYEMAC1RXDISPERR_PHYEMAC1GTXCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC1RXDV_PHYEMAC1RXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC1RXDV_PHYEMAC1RXCLK_posedge,
         TestSignal     => PHYEMAC1RXDV,
         TestSignalName => "PHYEMAC1RXDV",
         TestDelay      => 0 ns,
         RefSignal      => PHYEMAC1RXCLK_dly,
         RefSignalName  => "PHYEMAC1RXCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PHYEMAC1RXDV_PHYEMAC1RXCLK_posedge_posedge,
         SetupLow       => tsetup_PHYEMAC1RXDV_PHYEMAC1RXCLK_negedge_posedge,
         HoldLow        => thold_PHYEMAC1RXDV_PHYEMAC1RXCLK_posedge_posedge,
         HoldHigh       => thold_PHYEMAC1RXDV_PHYEMAC1RXCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC1RXER_PHYEMAC1RXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC1RXER_PHYEMAC1RXCLK_posedge,
         TestSignal     => PHYEMAC1RXER,
         TestSignalName => "PHYEMAC1RXER",
         TestDelay      => 0 ns,
         RefSignal      => PHYEMAC1RXCLK_dly,
         RefSignalName  => "PHYEMAC1RXCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PHYEMAC1RXER_PHYEMAC1RXCLK_posedge_posedge,
         SetupLow       => tsetup_PHYEMAC1RXER_PHYEMAC1RXCLK_negedge_posedge,
         HoldLow        => thold_PHYEMAC1RXER_PHYEMAC1RXCLK_posedge_posedge,
         HoldHigh       => thold_PHYEMAC1RXER_PHYEMAC1RXCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC1RXLOSSOFSYNC0_PHYEMAC1GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC1RXLOSSOFSYNC0_PHYEMAC1GTXCLK_posedge,
         TestSignal     => PHYEMAC1RXLOSSOFSYNC_dly(0),
         TestSignalName => "PHYEMAC1RXLOSSOFSYNC(0)",
         TestDelay      => tisd_PHYEMAC1RXLOSSOFSYNC(0),
         RefSignal      => PHYEMAC1GTXCLK_dly,
         RefSignalName  => "PHYEMAC1GTXCLK",
         RefDelay       => ticd_PHYEMAC1GTXCLK,
         SetupHigh      => tsetup_PHYEMAC1RXLOSSOFSYNC_PHYEMAC1GTXCLK_posedge_posedge(0),
         SetupLow       => tsetup_PHYEMAC1RXLOSSOFSYNC_PHYEMAC1GTXCLK_negedge_posedge(0),
         HoldLow        => thold_PHYEMAC1RXLOSSOFSYNC_PHYEMAC1GTXCLK_posedge_posedge(0),
         HoldHigh       => thold_PHYEMAC1RXLOSSOFSYNC_PHYEMAC1GTXCLK_negedge_posedge(0),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC1RXLOSSOFSYNC1_PHYEMAC1GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC1RXLOSSOFSYNC1_PHYEMAC1GTXCLK_posedge,
         TestSignal     => PHYEMAC1RXLOSSOFSYNC_dly(1),
         TestSignalName => "PHYEMAC1RXLOSSOFSYNC(1)",
         TestDelay      => tisd_PHYEMAC1RXLOSSOFSYNC(1),
         RefSignal      => PHYEMAC1GTXCLK_dly,
         RefSignalName  => "PHYEMAC1GTXCLK",
         RefDelay       => ticd_PHYEMAC1GTXCLK,
         SetupHigh      => tsetup_PHYEMAC1RXLOSSOFSYNC_PHYEMAC1GTXCLK_posedge_posedge(1),
         SetupLow       => tsetup_PHYEMAC1RXLOSSOFSYNC_PHYEMAC1GTXCLK_negedge_posedge(1),
         HoldLow        => thold_PHYEMAC1RXLOSSOFSYNC_PHYEMAC1GTXCLK_posedge_posedge(1),
         HoldHigh       => thold_PHYEMAC1RXLOSSOFSYNC_PHYEMAC1GTXCLK_negedge_posedge(1),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC1RXNOTINTABLE_PHYEMAC1GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC1RXNOTINTABLE_PHYEMAC1GTXCLK_posedge,
         TestSignal     => PHYEMAC1RXNOTINTABLE,
         TestSignalName => "PHYEMAC1RXNOTINTABLE",
         TestDelay      => 0 ns,
         RefSignal      => PHYEMAC1GTXCLK_dly,
         RefSignalName  => "PHYEMAC1GTXCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PHYEMAC1RXNOTINTABLE_PHYEMAC1GTXCLK_posedge_posedge,
         SetupLow       => tsetup_PHYEMAC1RXNOTINTABLE_PHYEMAC1GTXCLK_negedge_posedge,
         HoldLow        => thold_PHYEMAC1RXNOTINTABLE_PHYEMAC1GTXCLK_posedge_posedge,
         HoldHigh       => thold_PHYEMAC1RXNOTINTABLE_PHYEMAC1GTXCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC1RXRUNDISP_PHYEMAC1GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC1RXRUNDISP_PHYEMAC1GTXCLK_posedge,
         TestSignal     => PHYEMAC1RXRUNDISP,
         TestSignalName => "PHYEMAC1RXRUNDISP",
         TestDelay      => 0 ns,
         RefSignal      => PHYEMAC1GTXCLK_dly,
         RefSignalName  => "PHYEMAC1GTXCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PHYEMAC1RXRUNDISP_PHYEMAC1GTXCLK_posedge_posedge,
         SetupLow       => tsetup_PHYEMAC1RXRUNDISP_PHYEMAC1GTXCLK_negedge_posedge,
         HoldLow        => thold_PHYEMAC1RXRUNDISP_PHYEMAC1GTXCLK_posedge_posedge,
         HoldHigh       => thold_PHYEMAC1RXRUNDISP_PHYEMAC1GTXCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_PHYEMAC1TXBUFERR_PHYEMAC1GTXCLK_posedge,
         TimingData     => Tmkr_PHYEMAC1TXBUFERR_PHYEMAC1GTXCLK_posedge,
         TestSignal     => PHYEMAC1TXBUFERR,
         TestSignalName => "PHYEMAC1TXBUFERR",
         TestDelay      => 0 ns,
         RefSignal      => PHYEMAC1GTXCLK_dly,
         RefSignalName  => "PHYEMAC1GTXCLK",
         RefDelay       => 0 ns,
         SetupHigh      => tsetup_PHYEMAC1TXBUFERR_PHYEMAC1GTXCLK_posedge_posedge,
         SetupLow       => tsetup_PHYEMAC1TXBUFERR_PHYEMAC1GTXCLK_negedge_posedge,
         HoldLow        => thold_PHYEMAC1TXBUFERR_PHYEMAC1GTXCLK_posedge_posedge,
         HoldHigh       => thold_PHYEMAC1TXBUFERR_PHYEMAC1GTXCLK_negedge_posedge,
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TIEEMAC0CONFIGVEC74_PHYEMAC0GTXCLK_posedge,
         TimingData     => Tmkr_TIEEMAC0CONFIGVEC74_PHYEMAC0GTXCLK_posedge,
         TestSignal     => TIEEMAC0CONFIGVEC_dly(74),
         TestSignalName => "TIEEMAC0CONFIGVEC(74)",
         TestDelay      => tisd_TIEEMAC0CONFIGVEC(74),
         RefSignal      => PHYEMAC0GTXCLK_dly,
         RefSignalName  => "PHYEMAC0GTXCLK",
         RefDelay       => ticd_PHYEMAC0GTXCLK,
         SetupHigh      => tsetup_TIEEMAC0CONFIGVEC_PHYEMAC0GTXCLK_posedge_posedge(74),
         SetupLow       => tsetup_TIEEMAC0CONFIGVEC_PHYEMAC0GTXCLK_negedge_posedge(74),
         HoldLow        => thold_TIEEMAC0CONFIGVEC_PHYEMAC0GTXCLK_posedge_posedge(74),
         HoldHigh       => thold_TIEEMAC0CONFIGVEC_PHYEMAC0GTXCLK_negedge_posedge(74),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TIEEMAC0CONFIGVEC75_PHYEMAC0GTXCLK_posedge,
         TimingData     => Tmkr_TIEEMAC0CONFIGVEC75_PHYEMAC0GTXCLK_posedge,
         TestSignal     => TIEEMAC0CONFIGVEC_dly(75),
         TestSignalName => "TIEEMAC0CONFIGVEC(75)",
         TestDelay      => tisd_TIEEMAC0CONFIGVEC(75),
         RefSignal      => PHYEMAC0GTXCLK_dly,
         RefSignalName  => "PHYEMAC0GTXCLK",
         RefDelay       => ticd_PHYEMAC0GTXCLK,
         SetupHigh      => tsetup_TIEEMAC0CONFIGVEC_PHYEMAC0GTXCLK_posedge_posedge(75),
         SetupLow       => tsetup_TIEEMAC0CONFIGVEC_PHYEMAC0GTXCLK_negedge_posedge(75),
         HoldLow        => thold_TIEEMAC0CONFIGVEC_PHYEMAC0GTXCLK_posedge_posedge(75),
         HoldHigh       => thold_TIEEMAC0CONFIGVEC_PHYEMAC0GTXCLK_negedge_posedge(75),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TIEEMAC0CONFIGVEC76_PHYEMAC0GTXCLK_posedge,
         TimingData     => Tmkr_TIEEMAC0CONFIGVEC76_PHYEMAC0GTXCLK_posedge,
         TestSignal     => TIEEMAC0CONFIGVEC_dly(76),
         TestSignalName => "TIEEMAC0CONFIGVEC(76)",
         TestDelay      => tisd_TIEEMAC0CONFIGVEC(76),
         RefSignal      => PHYEMAC0GTXCLK_dly,
         RefSignalName  => "PHYEMAC0GTXCLK",
         RefDelay       => ticd_PHYEMAC0GTXCLK,
         SetupHigh      => tsetup_TIEEMAC0CONFIGVEC_PHYEMAC0GTXCLK_posedge_posedge(76),
         SetupLow       => tsetup_TIEEMAC0CONFIGVEC_PHYEMAC0GTXCLK_negedge_posedge(76),
         HoldLow        => thold_TIEEMAC0CONFIGVEC_PHYEMAC0GTXCLK_posedge_posedge(76),
         HoldHigh       => thold_TIEEMAC0CONFIGVEC_PHYEMAC0GTXCLK_negedge_posedge(76),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TIEEMAC0CONFIGVEC77_PHYEMAC0GTXCLK_posedge,
         TimingData     => Tmkr_TIEEMAC0CONFIGVEC77_PHYEMAC0GTXCLK_posedge,
         TestSignal     => TIEEMAC0CONFIGVEC_dly(77),
         TestSignalName => "TIEEMAC0CONFIGVEC(77)",
         TestDelay      => tisd_TIEEMAC0CONFIGVEC(77),
         RefSignal      => PHYEMAC0GTXCLK_dly,
         RefSignalName  => "PHYEMAC0GTXCLK",
         RefDelay       => ticd_PHYEMAC0GTXCLK,
         SetupHigh      => tsetup_TIEEMAC0CONFIGVEC_PHYEMAC0GTXCLK_posedge_posedge(77),
         SetupLow       => tsetup_TIEEMAC0CONFIGVEC_PHYEMAC0GTXCLK_negedge_posedge(77),
         HoldLow        => thold_TIEEMAC0CONFIGVEC_PHYEMAC0GTXCLK_posedge_posedge(77),
         HoldHigh       => thold_TIEEMAC0CONFIGVEC_PHYEMAC0GTXCLK_negedge_posedge(77),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TIEEMAC0CONFIGVEC78_PHYEMAC0GTXCLK_posedge,
         TimingData     => Tmkr_TIEEMAC0CONFIGVEC78_PHYEMAC0GTXCLK_posedge,
         TestSignal     => TIEEMAC0CONFIGVEC_dly(78),
         TestSignalName => "TIEEMAC0CONFIGVEC(78)",
         TestDelay      => tisd_TIEEMAC0CONFIGVEC(78),
         RefSignal      => PHYEMAC0GTXCLK_dly,
         RefSignalName  => "PHYEMAC0GTXCLK",
         RefDelay       => ticd_PHYEMAC0GTXCLK,
         SetupHigh      => tsetup_TIEEMAC0CONFIGVEC_PHYEMAC0GTXCLK_posedge_posedge(78),
         SetupLow       => tsetup_TIEEMAC0CONFIGVEC_PHYEMAC0GTXCLK_negedge_posedge(78),
         HoldLow        => thold_TIEEMAC0CONFIGVEC_PHYEMAC0GTXCLK_posedge_posedge(78),
         HoldHigh       => thold_TIEEMAC0CONFIGVEC_PHYEMAC0GTXCLK_negedge_posedge(78),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TIEEMAC1CONFIGVEC74_PHYEMAC1GTXCLK_posedge,
         TimingData     => Tmkr_TIEEMAC1CONFIGVEC74_PHYEMAC1GTXCLK_posedge,
         TestSignal     => TIEEMAC1CONFIGVEC_dly(74),
         TestSignalName => "TIEEMAC1CONFIGVEC(74)",
         TestDelay      => tisd_TIEEMAC1CONFIGVEC(74),
         RefSignal      => PHYEMAC1GTXCLK_dly,
         RefSignalName  => "PHYEMAC1GTXCLK",
         RefDelay       => ticd_PHYEMAC1GTXCLK,
         SetupHigh      => tsetup_TIEEMAC1CONFIGVEC_PHYEMAC1GTXCLK_posedge_posedge(74),
         SetupLow       => tsetup_TIEEMAC1CONFIGVEC_PHYEMAC1GTXCLK_negedge_posedge(74),
         HoldLow        => thold_TIEEMAC1CONFIGVEC_PHYEMAC1GTXCLK_posedge_posedge(74),
         HoldHigh       => thold_TIEEMAC1CONFIGVEC_PHYEMAC1GTXCLK_negedge_posedge(74),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TIEEMAC1CONFIGVEC75_PHYEMAC1GTXCLK_posedge,
         TimingData     => Tmkr_TIEEMAC1CONFIGVEC75_PHYEMAC1GTXCLK_posedge,
         TestSignal     => TIEEMAC1CONFIGVEC_dly(75),
         TestSignalName => "TIEEMAC1CONFIGVEC(75)",
         TestDelay      => tisd_TIEEMAC1CONFIGVEC(75),
         RefSignal      => PHYEMAC1GTXCLK_dly,
         RefSignalName  => "PHYEMAC1GTXCLK",
         RefDelay       => ticd_PHYEMAC1GTXCLK,
         SetupHigh      => tsetup_TIEEMAC1CONFIGVEC_PHYEMAC1GTXCLK_posedge_posedge(75),
         SetupLow       => tsetup_TIEEMAC1CONFIGVEC_PHYEMAC1GTXCLK_negedge_posedge(75),
         HoldLow        => thold_TIEEMAC1CONFIGVEC_PHYEMAC1GTXCLK_posedge_posedge(75),
         HoldHigh       => thold_TIEEMAC1CONFIGVEC_PHYEMAC1GTXCLK_negedge_posedge(75),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TIEEMAC1CONFIGVEC76_PHYEMAC1GTXCLK_posedge,
         TimingData     => Tmkr_TIEEMAC1CONFIGVEC76_PHYEMAC1GTXCLK_posedge,
         TestSignal     => TIEEMAC1CONFIGVEC_dly(76),
         TestSignalName => "TIEEMAC1CONFIGVEC(76)",
         TestDelay      => tisd_TIEEMAC1CONFIGVEC(76),
         RefSignal      => PHYEMAC1GTXCLK_dly,
         RefSignalName  => "PHYEMAC1GTXCLK",
         RefDelay       => ticd_PHYEMAC1GTXCLK,
         SetupHigh      => tsetup_TIEEMAC1CONFIGVEC_PHYEMAC1GTXCLK_posedge_posedge(76),
         SetupLow       => tsetup_TIEEMAC1CONFIGVEC_PHYEMAC1GTXCLK_negedge_posedge(76),
         HoldLow        => thold_TIEEMAC1CONFIGVEC_PHYEMAC1GTXCLK_posedge_posedge(76),
         HoldHigh       => thold_TIEEMAC1CONFIGVEC_PHYEMAC1GTXCLK_negedge_posedge(76),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TIEEMAC1CONFIGVEC77_PHYEMAC1GTXCLK_posedge,
         TimingData     => Tmkr_TIEEMAC1CONFIGVEC77_PHYEMAC1GTXCLK_posedge,
         TestSignal     => TIEEMAC1CONFIGVEC_dly(77),
         TestSignalName => "TIEEMAC1CONFIGVEC(77)",
         TestDelay      => tisd_TIEEMAC1CONFIGVEC(77),
         RefSignal      => PHYEMAC1GTXCLK_dly,
         RefSignalName  => "PHYEMAC1GTXCLK",
         RefDelay       => ticd_PHYEMAC1GTXCLK,
         SetupHigh      => tsetup_TIEEMAC1CONFIGVEC_PHYEMAC1GTXCLK_posedge_posedge(77),
         SetupLow       => tsetup_TIEEMAC1CONFIGVEC_PHYEMAC1GTXCLK_negedge_posedge(77),
         HoldLow        => thold_TIEEMAC1CONFIGVEC_PHYEMAC1GTXCLK_posedge_posedge(77),
         HoldHigh       => thold_TIEEMAC1CONFIGVEC_PHYEMAC1GTXCLK_negedge_posedge(77),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     VitalSetupHoldCheck
       (
         Violation      => Tviol_TIEEMAC1CONFIGVEC78_PHYEMAC1GTXCLK_posedge,
         TimingData     => Tmkr_TIEEMAC1CONFIGVEC78_PHYEMAC1GTXCLK_posedge,
         TestSignal     => TIEEMAC1CONFIGVEC_dly(78),
         TestSignalName => "TIEEMAC1CONFIGVEC(78)",
         TestDelay      => tisd_TIEEMAC1CONFIGVEC(78),
         RefSignal      => PHYEMAC1GTXCLK_dly,
         RefSignalName  => "PHYEMAC1GTXCLK",
         RefDelay       => ticd_PHYEMAC1GTXCLK,
         SetupHigh      => tsetup_TIEEMAC1CONFIGVEC_PHYEMAC1GTXCLK_posedge_posedge(78),
         SetupLow       => tsetup_TIEEMAC1CONFIGVEC_PHYEMAC1GTXCLK_negedge_posedge(78),
         HoldLow        => thold_TIEEMAC1CONFIGVEC_PHYEMAC1GTXCLK_posedge_posedge(78),
         HoldHigh       => thold_TIEEMAC1CONFIGVEC_PHYEMAC1GTXCLK_negedge_posedge(78),
         CheckEnabled   => TRUE,
         RefTransition  => 'R',
         HeaderMsg      => InstancePath & "/X_EMAC",
         Xon            => Xon,
         MsgOn          => MsgOn,
         MsgSeverity    => WARNING
       );
     end if;
-- End of (TimingChecksOn)

     EMACDCRACK <= EMACDCRACK_out;
     EMACDCRDBUS <= EMACDCRDBUS_out;
     DCRHOSTDONEIR <= DCRHOSTDONEIR_out;

--  Output-to-Clock path delay
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTANINTERRUPT,
         GlitchData    => EMAC0CLIENTANINTERRUPT_GlitchData,
         OutSignalName => "EMAC0CLIENTANINTERRUPT",
         OutTemp       => EMAC0CLIENTANINTERRUPT_OUT,
         Paths         => (0 => (PHYEMAC0GTXCLK_dly'last_event, tpd_PHYEMAC0GTXCLK_EMAC0CLIENTANINTERRUPT,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXBADFRAME,
         GlitchData    => EMAC0CLIENTRXBADFRAME_GlitchData,
         OutSignalName => "EMAC0CLIENTRXBADFRAME",
         OutTemp       => EMAC0CLIENTRXBADFRAME_OUT,
         Paths         => (0 => (CLIENTEMAC0RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXBADFRAME,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXCLIENTCLKOUT,
         GlitchData    => EMAC0CLIENTRXCLIENTCLKOUT_GlitchData,
         OutSignalName => "EMAC0CLIENTRXCLIENTCLKOUT",
         OutTemp       => EMAC0CLIENTRXCLIENTCLKOUT_OUT,
         Paths         => (0 => (PHYEMAC0GTXCLK_dly'last_event, tpd_PHYEMAC0GTXCLK_EMAC0CLIENTRXCLIENTCLKOUT,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXD(0),
         GlitchData    => EMAC0CLIENTRXD0_GlitchData,
         OutSignalName => "EMAC0CLIENTRXD(0)",
         OutTemp       => EMAC0CLIENTRXD_OUT(0),
         Paths         => (0 => (CLIENTEMAC0RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXD(0),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXD(1),
         GlitchData    => EMAC0CLIENTRXD1_GlitchData,
         OutSignalName => "EMAC0CLIENTRXD(1)",
         OutTemp       => EMAC0CLIENTRXD_OUT(1),
         Paths         => (0 => (CLIENTEMAC0RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXD(1),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXD(2),
         GlitchData    => EMAC0CLIENTRXD2_GlitchData,
         OutSignalName => "EMAC0CLIENTRXD(2)",
         OutTemp       => EMAC0CLIENTRXD_OUT(2),
         Paths         => (0 => (CLIENTEMAC0RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXD(2),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXD(3),
         GlitchData    => EMAC0CLIENTRXD3_GlitchData,
         OutSignalName => "EMAC0CLIENTRXD(3)",
         OutTemp       => EMAC0CLIENTRXD_OUT(3),
         Paths         => (0 => (CLIENTEMAC0RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXD(3),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXD(4),
         GlitchData    => EMAC0CLIENTRXD4_GlitchData,
         OutSignalName => "EMAC0CLIENTRXD(4)",
         OutTemp       => EMAC0CLIENTRXD_OUT(4),
         Paths         => (0 => (CLIENTEMAC0RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXD(4),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXD(5),
         GlitchData    => EMAC0CLIENTRXD5_GlitchData,
         OutSignalName => "EMAC0CLIENTRXD(5)",
         OutTemp       => EMAC0CLIENTRXD_OUT(5),
         Paths         => (0 => (CLIENTEMAC0RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXD(5),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXD(6),
         GlitchData    => EMAC0CLIENTRXD6_GlitchData,
         OutSignalName => "EMAC0CLIENTRXD(6)",
         OutTemp       => EMAC0CLIENTRXD_OUT(6),
         Paths         => (0 => (CLIENTEMAC0RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXD(6),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXD(7),
         GlitchData    => EMAC0CLIENTRXD7_GlitchData,
         OutSignalName => "EMAC0CLIENTRXD(7)",
         OutTemp       => EMAC0CLIENTRXD_OUT(7),
         Paths         => (0 => (CLIENTEMAC0RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXD(7),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXD(8),
         GlitchData    => EMAC0CLIENTRXD8_GlitchData,
         OutSignalName => "EMAC0CLIENTRXD(8)",
         OutTemp       => EMAC0CLIENTRXD_OUT(8),
         Paths         => (0 => (CLIENTEMAC0RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXD(8),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXD(9),
         GlitchData    => EMAC0CLIENTRXD9_GlitchData,
         OutSignalName => "EMAC0CLIENTRXD(9)",
         OutTemp       => EMAC0CLIENTRXD_OUT(9),
         Paths         => (0 => (CLIENTEMAC0RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXD(9),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXD(10),
         GlitchData    => EMAC0CLIENTRXD10_GlitchData,
         OutSignalName => "EMAC0CLIENTRXD(10)",
         OutTemp       => EMAC0CLIENTRXD_OUT(10),
         Paths         => (0 => (CLIENTEMAC0RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXD(10),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXD(11),
         GlitchData    => EMAC0CLIENTRXD11_GlitchData,
         OutSignalName => "EMAC0CLIENTRXD(11)",
         OutTemp       => EMAC0CLIENTRXD_OUT(11),
         Paths         => (0 => (CLIENTEMAC0RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXD(11),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXD(12),
         GlitchData    => EMAC0CLIENTRXD12_GlitchData,
         OutSignalName => "EMAC0CLIENTRXD(12)",
         OutTemp       => EMAC0CLIENTRXD_OUT(12),
         Paths         => (0 => (CLIENTEMAC0RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXD(12),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXD(13),
         GlitchData    => EMAC0CLIENTRXD13_GlitchData,
         OutSignalName => "EMAC0CLIENTRXD(13)",
         OutTemp       => EMAC0CLIENTRXD_OUT(13),
         Paths         => (0 => (CLIENTEMAC0RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXD(13),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXD(14),
         GlitchData    => EMAC0CLIENTRXD14_GlitchData,
         OutSignalName => "EMAC0CLIENTRXD(14)",
         OutTemp       => EMAC0CLIENTRXD_OUT(14),
         Paths         => (0 => (CLIENTEMAC0RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXD(14),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXD(15),
         GlitchData    => EMAC0CLIENTRXD15_GlitchData,
         OutSignalName => "EMAC0CLIENTRXD(15)",
         OutTemp       => EMAC0CLIENTRXD_OUT(15),
         Paths         => (0 => (CLIENTEMAC0RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXD(15),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXDVLD,
         GlitchData    => EMAC0CLIENTRXDVLD_GlitchData,
         OutSignalName => "EMAC0CLIENTRXDVLD",
         OutTemp       => EMAC0CLIENTRXDVLD_OUT,
         Paths         => (0 => (CLIENTEMAC0RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXDVLD,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXDVLDMSW,
         GlitchData    => EMAC0CLIENTRXDVLDMSW_GlitchData,
         OutSignalName => "EMAC0CLIENTRXDVLDMSW",
         OutTemp       => EMAC0CLIENTRXDVLDMSW_OUT,
         Paths         => (0 => (CLIENTEMAC0RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXDVLDMSW,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXDVREG6,
         GlitchData    => EMAC0CLIENTRXDVREG6_GlitchData,
         OutSignalName => "EMAC0CLIENTRXDVREG6",
         OutTemp       => EMAC0CLIENTRXDVREG6_OUT,
         Paths         => (0 => (CLIENTEMAC0RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXDVREG6,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXFRAMEDROP,
         GlitchData    => EMAC0CLIENTRXFRAMEDROP_GlitchData,
         OutSignalName => "EMAC0CLIENTRXFRAMEDROP",
         OutTemp       => EMAC0CLIENTRXFRAMEDROP_OUT,
         Paths         => (0 => (CLIENTEMAC0RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXFRAMEDROP,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXGOODFRAME,
         GlitchData    => EMAC0CLIENTRXGOODFRAME_GlitchData,
         OutSignalName => "EMAC0CLIENTRXGOODFRAME",
         OutTemp       => EMAC0CLIENTRXGOODFRAME_OUT,
         Paths         => (0 => (CLIENTEMAC0RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXGOODFRAME,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXSTATS(0),
         GlitchData    => EMAC0CLIENTRXSTATS0_GlitchData,
         OutSignalName => "EMAC0CLIENTRXSTATS(0)",
         OutTemp       => EMAC0CLIENTRXSTATS_OUT(0),
         Paths         => (0 => (CLIENTEMAC0RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXSTATS(0),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXSTATS(1),
         GlitchData    => EMAC0CLIENTRXSTATS1_GlitchData,
         OutSignalName => "EMAC0CLIENTRXSTATS(1)",
         OutTemp       => EMAC0CLIENTRXSTATS_OUT(1),
         Paths         => (0 => (CLIENTEMAC0RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXSTATS(1),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXSTATS(2),
         GlitchData    => EMAC0CLIENTRXSTATS2_GlitchData,
         OutSignalName => "EMAC0CLIENTRXSTATS(2)",
         OutTemp       => EMAC0CLIENTRXSTATS_OUT(2),
         Paths         => (0 => (CLIENTEMAC0RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXSTATS(2),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXSTATS(3),
         GlitchData    => EMAC0CLIENTRXSTATS3_GlitchData,
         OutSignalName => "EMAC0CLIENTRXSTATS(3)",
         OutTemp       => EMAC0CLIENTRXSTATS_OUT(3),
         Paths         => (0 => (CLIENTEMAC0RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXSTATS(3),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXSTATS(4),
         GlitchData    => EMAC0CLIENTRXSTATS4_GlitchData,
         OutSignalName => "EMAC0CLIENTRXSTATS(4)",
         OutTemp       => EMAC0CLIENTRXSTATS_OUT(4),
         Paths         => (0 => (CLIENTEMAC0RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXSTATS(4),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXSTATS(5),
         GlitchData    => EMAC0CLIENTRXSTATS5_GlitchData,
         OutSignalName => "EMAC0CLIENTRXSTATS(5)",
         OutTemp       => EMAC0CLIENTRXSTATS_OUT(5),
         Paths         => (0 => (CLIENTEMAC0RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXSTATS(5),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXSTATS(6),
         GlitchData    => EMAC0CLIENTRXSTATS6_GlitchData,
         OutSignalName => "EMAC0CLIENTRXSTATS(6)",
         OutTemp       => EMAC0CLIENTRXSTATS_OUT(6),
         Paths         => (0 => (CLIENTEMAC0RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXSTATS(6),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXSTATSBYTEVLD,
         GlitchData    => EMAC0CLIENTRXSTATSBYTEVLD_GlitchData,
         OutSignalName => "EMAC0CLIENTRXSTATSBYTEVLD",
         OutTemp       => EMAC0CLIENTRXSTATSBYTEVLD_OUT,
         Paths         => (0 => (CLIENTEMAC0RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXSTATSBYTEVLD,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTRXSTATSVLD,
         GlitchData    => EMAC0CLIENTRXSTATSVLD_GlitchData,
         OutSignalName => "EMAC0CLIENTRXSTATSVLD",
         OutTemp       => EMAC0CLIENTRXSTATSVLD_OUT,
         Paths         => (0 => (CLIENTEMAC0RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0RXCLIENTCLKIN_EMAC0CLIENTRXSTATSVLD,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTTXACK,
         GlitchData    => EMAC0CLIENTTXACK_GlitchData,
         OutSignalName => "EMAC0CLIENTTXACK",
         OutTemp       => EMAC0CLIENTTXACK_OUT,
         Paths         => (0 => (CLIENTEMAC0TXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0TXCLIENTCLKIN_EMAC0CLIENTTXACK,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTTXCLIENTCLKOUT,
         GlitchData    => EMAC0CLIENTTXCLIENTCLKOUT_GlitchData,
         OutSignalName => "EMAC0CLIENTTXCLIENTCLKOUT",
         OutTemp       => EMAC0CLIENTTXCLIENTCLKOUT_OUT,
         Paths         => (0 => (PHYEMAC0GTXCLK_dly'last_event, tpd_PHYEMAC0GTXCLK_EMAC0CLIENTTXCLIENTCLKOUT,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTTXCOLLISION,
         GlitchData    => EMAC0CLIENTTXCOLLISION_GlitchData,
         OutSignalName => "EMAC0CLIENTTXCOLLISION",
         OutTemp       => EMAC0CLIENTTXCOLLISION_OUT,
         Paths         => (0 => (CLIENTEMAC0TXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0TXCLIENTCLKIN_EMAC0CLIENTTXCOLLISION,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTTXGMIIMIICLKOUT,
         GlitchData    => EMAC0CLIENTTXGMIIMIICLKOUT_GlitchData,
         OutSignalName => "EMAC0CLIENTTXGMIIMIICLKOUT",
         OutTemp       => EMAC0CLIENTTXGMIIMIICLKOUT_OUT,
         Paths         => (0 => (PHYEMAC0GTXCLK_dly'last_event, tpd_PHYEMAC0GTXCLK_EMAC0CLIENTTXGMIIMIICLKOUT,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTTXRETRANSMIT,
         GlitchData    => EMAC0CLIENTTXRETRANSMIT_GlitchData,
         OutSignalName => "EMAC0CLIENTTXRETRANSMIT",
         OutTemp       => EMAC0CLIENTTXRETRANSMIT_OUT,
         Paths         => (0 => (CLIENTEMAC0TXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0TXCLIENTCLKIN_EMAC0CLIENTTXRETRANSMIT,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTTXSTATS,
         GlitchData    => EMAC0CLIENTTXSTATS_GlitchData,
         OutSignalName => "EMAC0CLIENTTXSTATS",
         OutTemp       => EMAC0CLIENTTXSTATS_OUT,
         Paths         => (0 => (CLIENTEMAC0TXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0TXCLIENTCLKIN_EMAC0CLIENTTXSTATS,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTTXSTATSBYTEVLD,
         GlitchData    => EMAC0CLIENTTXSTATSBYTEVLD_GlitchData,
         OutSignalName => "EMAC0CLIENTTXSTATSBYTEVLD",
         OutTemp       => EMAC0CLIENTTXSTATSBYTEVLD_OUT,
         Paths         => (0 => (CLIENTEMAC0TXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0TXCLIENTCLKIN_EMAC0CLIENTTXSTATSBYTEVLD,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0CLIENTTXSTATSVLD,
         GlitchData    => EMAC0CLIENTTXSTATSVLD_GlitchData,
         OutSignalName => "EMAC0CLIENTTXSTATSVLD",
         OutTemp       => EMAC0CLIENTTXSTATSVLD_OUT,
         Paths         => (0 => (CLIENTEMAC0TXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC0TXCLIENTCLKIN_EMAC0CLIENTTXSTATSVLD,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0PHYENCOMMAALIGN,
         GlitchData    => EMAC0PHYENCOMMAALIGN_GlitchData,
         OutSignalName => "EMAC0PHYENCOMMAALIGN",
         OutTemp       => EMAC0PHYENCOMMAALIGN_OUT,
         Paths         => (0 => (PHYEMAC0GTXCLK_dly'last_event, tpd_PHYEMAC0GTXCLK_EMAC0PHYENCOMMAALIGN,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0PHYLOOPBACKMSB,
         GlitchData    => EMAC0PHYLOOPBACKMSB_GlitchData,
         OutSignalName => "EMAC0PHYLOOPBACKMSB",
         OutTemp       => EMAC0PHYLOOPBACKMSB_OUT,
         Paths         => (0 => (PHYEMAC0GTXCLK_dly'last_event, tpd_PHYEMAC0GTXCLK_EMAC0PHYLOOPBACKMSB,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0PHYMCLKOUT,
         GlitchData    => EMAC0PHYMCLKOUT_GlitchData,
         OutSignalName => "EMAC0PHYMCLKOUT",
         OutTemp       => EMAC0PHYMCLKOUT_OUT,
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_EMAC0PHYMCLKOUT,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0PHYMDOUT,
         GlitchData    => EMAC0PHYMDOUT_GlitchData,
         OutSignalName => "EMAC0PHYMDOUT",
         OutTemp       => EMAC0PHYMDOUT_OUT,
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_EMAC0PHYMDOUT,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0PHYMDTRI,
         GlitchData    => EMAC0PHYMDTRI_GlitchData,
         OutSignalName => "EMAC0PHYMDTRI",
         OutTemp       => EMAC0PHYMDTRI_OUT,
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_EMAC0PHYMDTRI,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0PHYMGTRXRESET,
         GlitchData    => EMAC0PHYMGTRXRESET_GlitchData,
         OutSignalName => "EMAC0PHYMGTRXRESET",
         OutTemp       => EMAC0PHYMGTRXRESET_OUT,
         Paths         => (0 => (PHYEMAC0GTXCLK_dly'last_event, tpd_PHYEMAC0GTXCLK_EMAC0PHYMGTRXRESET,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0PHYMGTTXRESET,
         GlitchData    => EMAC0PHYMGTTXRESET_GlitchData,
         OutSignalName => "EMAC0PHYMGTTXRESET",
         OutTemp       => EMAC0PHYMGTTXRESET_OUT,
         Paths         => (0 => (PHYEMAC0GTXCLK_dly'last_event, tpd_PHYEMAC0GTXCLK_EMAC0PHYMGTTXRESET,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0PHYPOWERDOWN,
         GlitchData    => EMAC0PHYPOWERDOWN_GlitchData,
         OutSignalName => "EMAC0PHYPOWERDOWN",
         OutTemp       => EMAC0PHYPOWERDOWN_OUT,
         Paths         => (0 => (PHYEMAC0GTXCLK_dly'last_event, tpd_PHYEMAC0GTXCLK_EMAC0PHYPOWERDOWN,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0PHYSYNCACQSTATUS,
         GlitchData    => EMAC0PHYSYNCACQSTATUS_GlitchData,
         OutSignalName => "EMAC0PHYSYNCACQSTATUS",
         OutTemp       => EMAC0PHYSYNCACQSTATUS_OUT,
         Paths         => (0 => (PHYEMAC0GTXCLK_dly'last_event, tpd_PHYEMAC0GTXCLK_EMAC0PHYSYNCACQSTATUS,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0PHYTXCHARDISPMODE,
         GlitchData    => EMAC0PHYTXCHARDISPMODE_GlitchData,
         OutSignalName => "EMAC0PHYTXCHARDISPMODE",
         OutTemp       => EMAC0PHYTXCHARDISPMODE_OUT,
         Paths         => (0 => (PHYEMAC0GTXCLK_dly'last_event, tpd_PHYEMAC0GTXCLK_EMAC0PHYTXCHARDISPMODE,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0PHYTXCHARDISPVAL,
         GlitchData    => EMAC0PHYTXCHARDISPVAL_GlitchData,
         OutSignalName => "EMAC0PHYTXCHARDISPVAL",
         OutTemp       => EMAC0PHYTXCHARDISPVAL_OUT,
         Paths         => (0 => (PHYEMAC0GTXCLK_dly'last_event, tpd_PHYEMAC0GTXCLK_EMAC0PHYTXCHARDISPVAL,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0PHYTXCHARISK,
         GlitchData    => EMAC0PHYTXCHARISK_GlitchData,
         OutSignalName => "EMAC0PHYTXCHARISK",
         OutTemp       => EMAC0PHYTXCHARISK_OUT,
         Paths         => (0 => (PHYEMAC0GTXCLK_dly'last_event, tpd_PHYEMAC0GTXCLK_EMAC0PHYTXCHARISK,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0PHYTXCLK,
         GlitchData    => EMAC0PHYTXCLK_GlitchData,
         OutSignalName => "EMAC0PHYTXCLK",
         OutTemp       => EMAC0PHYTXCLK_OUT,
         Paths         => (0 => (PHYEMAC0GTXCLK_dly'last_event, tpd_PHYEMAC0GTXCLK_EMAC0PHYTXCLK,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0PHYTXD(0),
         GlitchData    => EMAC0PHYTXD0_GlitchData,
         OutSignalName => "EMAC0PHYTXD(0)",
         OutTemp       => EMAC0PHYTXD_OUT(0),
         Paths         => (0 => (CLIENTEMAC0TXGMIIMIICLKIN_dly'last_event, tpd_CLIENTEMAC0TXGMIIMIICLKIN_EMAC0PHYTXD(0),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0PHYTXD(1),
         GlitchData    => EMAC0PHYTXD1_GlitchData,
         OutSignalName => "EMAC0PHYTXD(1)",
         OutTemp       => EMAC0PHYTXD_OUT(1),
         Paths         => (0 => (CLIENTEMAC0TXGMIIMIICLKIN_dly'last_event, tpd_CLIENTEMAC0TXGMIIMIICLKIN_EMAC0PHYTXD(1),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0PHYTXD(2),
         GlitchData    => EMAC0PHYTXD2_GlitchData,
         OutSignalName => "EMAC0PHYTXD(2)",
         OutTemp       => EMAC0PHYTXD_OUT(2),
         Paths         => (0 => (CLIENTEMAC0TXGMIIMIICLKIN_dly'last_event, tpd_CLIENTEMAC0TXGMIIMIICLKIN_EMAC0PHYTXD(2),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0PHYTXD(3),
         GlitchData    => EMAC0PHYTXD3_GlitchData,
         OutSignalName => "EMAC0PHYTXD(3)",
         OutTemp       => EMAC0PHYTXD_OUT(3),
         Paths         => (0 => (CLIENTEMAC0TXGMIIMIICLKIN_dly'last_event, tpd_CLIENTEMAC0TXGMIIMIICLKIN_EMAC0PHYTXD(3),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0PHYTXD(4),
         GlitchData    => EMAC0PHYTXD4_GlitchData,
         OutSignalName => "EMAC0PHYTXD(4)",
         OutTemp       => EMAC0PHYTXD_OUT(4),
         Paths         => (0 => (CLIENTEMAC0TXGMIIMIICLKIN_dly'last_event, tpd_CLIENTEMAC0TXGMIIMIICLKIN_EMAC0PHYTXD(4),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0PHYTXD(5),
         GlitchData    => EMAC0PHYTXD5_GlitchData,
         OutSignalName => "EMAC0PHYTXD(5)",
         OutTemp       => EMAC0PHYTXD_OUT(5),
         Paths         => (0 => (CLIENTEMAC0TXGMIIMIICLKIN_dly'last_event, tpd_CLIENTEMAC0TXGMIIMIICLKIN_EMAC0PHYTXD(5),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0PHYTXD(6),
         GlitchData    => EMAC0PHYTXD6_GlitchData,
         OutSignalName => "EMAC0PHYTXD(6)",
         OutTemp       => EMAC0PHYTXD_OUT(6),
         Paths         => (0 => (CLIENTEMAC0TXGMIIMIICLKIN_dly'last_event, tpd_CLIENTEMAC0TXGMIIMIICLKIN_EMAC0PHYTXD(6),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0PHYTXD(7),
         GlitchData    => EMAC0PHYTXD7_GlitchData,
         OutSignalName => "EMAC0PHYTXD(7)",
         OutTemp       => EMAC0PHYTXD_OUT(7),
         Paths         => (0 => (CLIENTEMAC0TXGMIIMIICLKIN_dly'last_event, tpd_CLIENTEMAC0TXGMIIMIICLKIN_EMAC0PHYTXD(7),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0PHYTXEN,
         GlitchData    => EMAC0PHYTXEN_GlitchData,
         OutSignalName => "EMAC0PHYTXEN",
         OutTemp       => EMAC0PHYTXEN_OUT,
         Paths         => (0 => (CLIENTEMAC0TXGMIIMIICLKIN_dly'last_event, tpd_CLIENTEMAC0TXGMIIMIICLKIN_EMAC0PHYTXEN,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC0PHYTXER,
         GlitchData    => EMAC0PHYTXER_GlitchData,
         OutSignalName => "EMAC0PHYTXER",
         OutTemp       => EMAC0PHYTXER_OUT,
         Paths         => (0 => (CLIENTEMAC0TXGMIIMIICLKIN_dly'last_event, tpd_CLIENTEMAC0TXGMIIMIICLKIN_EMAC0PHYTXER,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTANINTERRUPT,
         GlitchData    => EMAC1CLIENTANINTERRUPT_GlitchData,
         OutSignalName => "EMAC1CLIENTANINTERRUPT",
         OutTemp       => EMAC1CLIENTANINTERRUPT_OUT,
         Paths         => (0 => (PHYEMAC1GTXCLK_dly'last_event, tpd_PHYEMAC1GTXCLK_EMAC1CLIENTANINTERRUPT,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXBADFRAME,
         GlitchData    => EMAC1CLIENTRXBADFRAME_GlitchData,
         OutSignalName => "EMAC1CLIENTRXBADFRAME",
         OutTemp       => EMAC1CLIENTRXBADFRAME_OUT,
         Paths         => (0 => (CLIENTEMAC1RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXBADFRAME,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXCLIENTCLKOUT,
         GlitchData    => EMAC1CLIENTRXCLIENTCLKOUT_GlitchData,
         OutSignalName => "EMAC1CLIENTRXCLIENTCLKOUT",
         OutTemp       => EMAC1CLIENTRXCLIENTCLKOUT_OUT,
         Paths         => (0 => (PHYEMAC1GTXCLK_dly'last_event, tpd_PHYEMAC1GTXCLK_EMAC1CLIENTRXCLIENTCLKOUT,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXD(0),
         GlitchData    => EMAC1CLIENTRXD0_GlitchData,
         OutSignalName => "EMAC1CLIENTRXD(0)",
         OutTemp       => EMAC1CLIENTRXD_OUT(0),
         Paths         => (0 => (CLIENTEMAC1RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXD(0),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXD(1),
         GlitchData    => EMAC1CLIENTRXD1_GlitchData,
         OutSignalName => "EMAC1CLIENTRXD(1)",
         OutTemp       => EMAC1CLIENTRXD_OUT(1),
         Paths         => (0 => (CLIENTEMAC1RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXD(1),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXD(2),
         GlitchData    => EMAC1CLIENTRXD2_GlitchData,
         OutSignalName => "EMAC1CLIENTRXD(2)",
         OutTemp       => EMAC1CLIENTRXD_OUT(2),
         Paths         => (0 => (CLIENTEMAC1RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXD(2),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXD(3),
         GlitchData    => EMAC1CLIENTRXD3_GlitchData,
         OutSignalName => "EMAC1CLIENTRXD(3)",
         OutTemp       => EMAC1CLIENTRXD_OUT(3),
         Paths         => (0 => (CLIENTEMAC1RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXD(3),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXD(4),
         GlitchData    => EMAC1CLIENTRXD4_GlitchData,
         OutSignalName => "EMAC1CLIENTRXD(4)",
         OutTemp       => EMAC1CLIENTRXD_OUT(4),
         Paths         => (0 => (CLIENTEMAC1RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXD(4),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXD(5),
         GlitchData    => EMAC1CLIENTRXD5_GlitchData,
         OutSignalName => "EMAC1CLIENTRXD(5)",
         OutTemp       => EMAC1CLIENTRXD_OUT(5),
         Paths         => (0 => (CLIENTEMAC1RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXD(5),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXD(6),
         GlitchData    => EMAC1CLIENTRXD6_GlitchData,
         OutSignalName => "EMAC1CLIENTRXD(6)",
         OutTemp       => EMAC1CLIENTRXD_OUT(6),
         Paths         => (0 => (CLIENTEMAC1RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXD(6),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXD(7),
         GlitchData    => EMAC1CLIENTRXD7_GlitchData,
         OutSignalName => "EMAC1CLIENTRXD(7)",
         OutTemp       => EMAC1CLIENTRXD_OUT(7),
         Paths         => (0 => (CLIENTEMAC1RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXD(7),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXD(8),
         GlitchData    => EMAC1CLIENTRXD8_GlitchData,
         OutSignalName => "EMAC1CLIENTRXD(8)",
         OutTemp       => EMAC1CLIENTRXD_OUT(8),
         Paths         => (0 => (CLIENTEMAC1RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXD(8),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXD(9),
         GlitchData    => EMAC1CLIENTRXD9_GlitchData,
         OutSignalName => "EMAC1CLIENTRXD(9)",
         OutTemp       => EMAC1CLIENTRXD_OUT(9),
         Paths         => (0 => (CLIENTEMAC1RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXD(9),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXD(10),
         GlitchData    => EMAC1CLIENTRXD10_GlitchData,
         OutSignalName => "EMAC1CLIENTRXD(10)",
         OutTemp       => EMAC1CLIENTRXD_OUT(10),
         Paths         => (0 => (CLIENTEMAC1RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXD(10),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXD(11),
         GlitchData    => EMAC1CLIENTRXD11_GlitchData,
         OutSignalName => "EMAC1CLIENTRXD(11)",
         OutTemp       => EMAC1CLIENTRXD_OUT(11),
         Paths         => (0 => (CLIENTEMAC1RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXD(11),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXD(12),
         GlitchData    => EMAC1CLIENTRXD12_GlitchData,
         OutSignalName => "EMAC1CLIENTRXD(12)",
         OutTemp       => EMAC1CLIENTRXD_OUT(12),
         Paths         => (0 => (CLIENTEMAC1RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXD(12),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXD(13),
         GlitchData    => EMAC1CLIENTRXD13_GlitchData,
         OutSignalName => "EMAC1CLIENTRXD(13)",
         OutTemp       => EMAC1CLIENTRXD_OUT(13),
         Paths         => (0 => (CLIENTEMAC1RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXD(13),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXD(14),
         GlitchData    => EMAC1CLIENTRXD14_GlitchData,
         OutSignalName => "EMAC1CLIENTRXD(14)",
         OutTemp       => EMAC1CLIENTRXD_OUT(14),
         Paths         => (0 => (CLIENTEMAC1RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXD(14),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXD(15),
         GlitchData    => EMAC1CLIENTRXD15_GlitchData,
         OutSignalName => "EMAC1CLIENTRXD(15)",
         OutTemp       => EMAC1CLIENTRXD_OUT(15),
         Paths         => (0 => (CLIENTEMAC1RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXD(15),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXDVLD,
         GlitchData    => EMAC1CLIENTRXDVLD_GlitchData,
         OutSignalName => "EMAC1CLIENTRXDVLD",
         OutTemp       => EMAC1CLIENTRXDVLD_OUT,
         Paths         => (0 => (CLIENTEMAC1RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXDVLD,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXDVLDMSW,
         GlitchData    => EMAC1CLIENTRXDVLDMSW_GlitchData,
         OutSignalName => "EMAC1CLIENTRXDVLDMSW",
         OutTemp       => EMAC1CLIENTRXDVLDMSW_OUT,
         Paths         => (0 => (CLIENTEMAC1RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXDVLDMSW,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXDVREG6,
         GlitchData    => EMAC1CLIENTRXDVREG6_GlitchData,
         OutSignalName => "EMAC1CLIENTRXDVREG6",
         OutTemp       => EMAC1CLIENTRXDVREG6_OUT,
         Paths         => (0 => (CLIENTEMAC1RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXDVREG6,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXFRAMEDROP,
         GlitchData    => EMAC1CLIENTRXFRAMEDROP_GlitchData,
         OutSignalName => "EMAC1CLIENTRXFRAMEDROP",
         OutTemp       => EMAC1CLIENTRXFRAMEDROP_OUT,
         Paths         => (0 => (CLIENTEMAC1RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXFRAMEDROP,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXGOODFRAME,
         GlitchData    => EMAC1CLIENTRXGOODFRAME_GlitchData,
         OutSignalName => "EMAC1CLIENTRXGOODFRAME",
         OutTemp       => EMAC1CLIENTRXGOODFRAME_OUT,
         Paths         => (0 => (CLIENTEMAC1RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXGOODFRAME,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXSTATS(0),
         GlitchData    => EMAC1CLIENTRXSTATS0_GlitchData,
         OutSignalName => "EMAC1CLIENTRXSTATS(0)",
         OutTemp       => EMAC1CLIENTRXSTATS_OUT(0),
         Paths         => (0 => (CLIENTEMAC1RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXSTATS(0),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXSTATS(1),
         GlitchData    => EMAC1CLIENTRXSTATS1_GlitchData,
         OutSignalName => "EMAC1CLIENTRXSTATS(1)",
         OutTemp       => EMAC1CLIENTRXSTATS_OUT(1),
         Paths         => (0 => (CLIENTEMAC1RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXSTATS(1),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXSTATS(2),
         GlitchData    => EMAC1CLIENTRXSTATS2_GlitchData,
         OutSignalName => "EMAC1CLIENTRXSTATS(2)",
         OutTemp       => EMAC1CLIENTRXSTATS_OUT(2),
         Paths         => (0 => (CLIENTEMAC1RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXSTATS(2),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXSTATS(3),
         GlitchData    => EMAC1CLIENTRXSTATS3_GlitchData,
         OutSignalName => "EMAC1CLIENTRXSTATS(3)",
         OutTemp       => EMAC1CLIENTRXSTATS_OUT(3),
         Paths         => (0 => (CLIENTEMAC1RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXSTATS(3),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXSTATS(4),
         GlitchData    => EMAC1CLIENTRXSTATS4_GlitchData,
         OutSignalName => "EMAC1CLIENTRXSTATS(4)",
         OutTemp       => EMAC1CLIENTRXSTATS_OUT(4),
         Paths         => (0 => (CLIENTEMAC1RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXSTATS(4),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXSTATS(5),
         GlitchData    => EMAC1CLIENTRXSTATS5_GlitchData,
         OutSignalName => "EMAC1CLIENTRXSTATS(5)",
         OutTemp       => EMAC1CLIENTRXSTATS_OUT(5),
         Paths         => (0 => (CLIENTEMAC1RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXSTATS(5),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXSTATS(6),
         GlitchData    => EMAC1CLIENTRXSTATS6_GlitchData,
         OutSignalName => "EMAC1CLIENTRXSTATS(6)",
         OutTemp       => EMAC1CLIENTRXSTATS_OUT(6),
         Paths         => (0 => (CLIENTEMAC1RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXSTATS(6),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXSTATSBYTEVLD,
         GlitchData    => EMAC1CLIENTRXSTATSBYTEVLD_GlitchData,
         OutSignalName => "EMAC1CLIENTRXSTATSBYTEVLD",
         OutTemp       => EMAC1CLIENTRXSTATSBYTEVLD_OUT,
         Paths         => (0 => (CLIENTEMAC1RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXSTATSBYTEVLD,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTRXSTATSVLD,
         GlitchData    => EMAC1CLIENTRXSTATSVLD_GlitchData,
         OutSignalName => "EMAC1CLIENTRXSTATSVLD",
         OutTemp       => EMAC1CLIENTRXSTATSVLD_OUT,
         Paths         => (0 => (CLIENTEMAC1RXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1RXCLIENTCLKIN_EMAC1CLIENTRXSTATSVLD,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTTXACK,
         GlitchData    => EMAC1CLIENTTXACK_GlitchData,
         OutSignalName => "EMAC1CLIENTTXACK",
         OutTemp       => EMAC1CLIENTTXACK_OUT,
         Paths         => (0 => (CLIENTEMAC1TXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1TXCLIENTCLKIN_EMAC1CLIENTTXACK,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTTXCLIENTCLKOUT,
         GlitchData    => EMAC1CLIENTTXCLIENTCLKOUT_GlitchData,
         OutSignalName => "EMAC1CLIENTTXCLIENTCLKOUT",
         OutTemp       => EMAC1CLIENTTXCLIENTCLKOUT_OUT,
         Paths         => (0 => (PHYEMAC1GTXCLK_dly'last_event, tpd_PHYEMAC1GTXCLK_EMAC1CLIENTTXCLIENTCLKOUT,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTTXCOLLISION,
         GlitchData    => EMAC1CLIENTTXCOLLISION_GlitchData,
         OutSignalName => "EMAC1CLIENTTXCOLLISION",
         OutTemp       => EMAC1CLIENTTXCOLLISION_OUT,
         Paths         => (0 => (CLIENTEMAC1TXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1TXCLIENTCLKIN_EMAC1CLIENTTXCOLLISION,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTTXGMIIMIICLKOUT,
         GlitchData    => EMAC1CLIENTTXGMIIMIICLKOUT_GlitchData,
         OutSignalName => "EMAC1CLIENTTXGMIIMIICLKOUT",
         OutTemp       => EMAC1CLIENTTXGMIIMIICLKOUT_OUT,
         Paths         => (0 => (PHYEMAC1GTXCLK_dly'last_event, tpd_PHYEMAC1GTXCLK_EMAC1CLIENTTXGMIIMIICLKOUT,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTTXRETRANSMIT,
         GlitchData    => EMAC1CLIENTTXRETRANSMIT_GlitchData,
         OutSignalName => "EMAC1CLIENTTXRETRANSMIT",
         OutTemp       => EMAC1CLIENTTXRETRANSMIT_OUT,
         Paths         => (0 => (CLIENTEMAC1TXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1TXCLIENTCLKIN_EMAC1CLIENTTXRETRANSMIT,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTTXSTATS,
         GlitchData    => EMAC1CLIENTTXSTATS_GlitchData,
         OutSignalName => "EMAC1CLIENTTXSTATS",
         OutTemp       => EMAC1CLIENTTXSTATS_OUT,
         Paths         => (0 => (CLIENTEMAC1TXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1TXCLIENTCLKIN_EMAC1CLIENTTXSTATS,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTTXSTATSBYTEVLD,
         GlitchData    => EMAC1CLIENTTXSTATSBYTEVLD_GlitchData,
         OutSignalName => "EMAC1CLIENTTXSTATSBYTEVLD",
         OutTemp       => EMAC1CLIENTTXSTATSBYTEVLD_OUT,
         Paths         => (0 => (CLIENTEMAC1TXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1TXCLIENTCLKIN_EMAC1CLIENTTXSTATSBYTEVLD,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1CLIENTTXSTATSVLD,
         GlitchData    => EMAC1CLIENTTXSTATSVLD_GlitchData,
         OutSignalName => "EMAC1CLIENTTXSTATSVLD",
         OutTemp       => EMAC1CLIENTTXSTATSVLD_OUT,
         Paths         => (0 => (CLIENTEMAC1TXCLIENTCLKIN_dly'last_event, tpd_CLIENTEMAC1TXCLIENTCLKIN_EMAC1CLIENTTXSTATSVLD,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1PHYENCOMMAALIGN,
         GlitchData    => EMAC1PHYENCOMMAALIGN_GlitchData,
         OutSignalName => "EMAC1PHYENCOMMAALIGN",
         OutTemp       => EMAC1PHYENCOMMAALIGN_OUT,
         Paths         => (0 => (PHYEMAC1GTXCLK_dly'last_event, tpd_PHYEMAC1GTXCLK_EMAC1PHYENCOMMAALIGN,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1PHYLOOPBACKMSB,
         GlitchData    => EMAC1PHYLOOPBACKMSB_GlitchData,
         OutSignalName => "EMAC1PHYLOOPBACKMSB",
         OutTemp       => EMAC1PHYLOOPBACKMSB_OUT,
         Paths         => (0 => (PHYEMAC1GTXCLK_dly'last_event, tpd_PHYEMAC1GTXCLK_EMAC1PHYLOOPBACKMSB,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1PHYMCLKOUT,
         GlitchData    => EMAC1PHYMCLKOUT_GlitchData,
         OutSignalName => "EMAC1PHYMCLKOUT",
         OutTemp       => EMAC1PHYMCLKOUT_OUT,
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_EMAC1PHYMCLKOUT,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1PHYMDOUT,
         GlitchData    => EMAC1PHYMDOUT_GlitchData,
         OutSignalName => "EMAC1PHYMDOUT",
         OutTemp       => EMAC1PHYMDOUT_OUT,
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_EMAC1PHYMDOUT,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1PHYMDTRI,
         GlitchData    => EMAC1PHYMDTRI_GlitchData,
         OutSignalName => "EMAC1PHYMDTRI",
         OutTemp       => EMAC1PHYMDTRI_OUT,
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_EMAC1PHYMDTRI,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1PHYMGTRXRESET,
         GlitchData    => EMAC1PHYMGTRXRESET_GlitchData,
         OutSignalName => "EMAC1PHYMGTRXRESET",
         OutTemp       => EMAC1PHYMGTRXRESET_OUT,
         Paths         => (0 => (PHYEMAC1GTXCLK_dly'last_event, tpd_PHYEMAC1GTXCLK_EMAC1PHYMGTRXRESET,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1PHYMGTTXRESET,
         GlitchData    => EMAC1PHYMGTTXRESET_GlitchData,
         OutSignalName => "EMAC1PHYMGTTXRESET",
         OutTemp       => EMAC1PHYMGTTXRESET_OUT,
         Paths         => (0 => (PHYEMAC1GTXCLK_dly'last_event, tpd_PHYEMAC1GTXCLK_EMAC1PHYMGTTXRESET,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1PHYPOWERDOWN,
         GlitchData    => EMAC1PHYPOWERDOWN_GlitchData,
         OutSignalName => "EMAC1PHYPOWERDOWN",
         OutTemp       => EMAC1PHYPOWERDOWN_OUT,
         Paths         => (0 => (PHYEMAC1GTXCLK_dly'last_event, tpd_PHYEMAC1GTXCLK_EMAC1PHYPOWERDOWN,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1PHYSYNCACQSTATUS,
         GlitchData    => EMAC1PHYSYNCACQSTATUS_GlitchData,
         OutSignalName => "EMAC1PHYSYNCACQSTATUS",
         OutTemp       => EMAC1PHYSYNCACQSTATUS_OUT,
         Paths         => (0 => (PHYEMAC1GTXCLK_dly'last_event, tpd_PHYEMAC1GTXCLK_EMAC1PHYSYNCACQSTATUS,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1PHYTXCHARDISPMODE,
         GlitchData    => EMAC1PHYTXCHARDISPMODE_GlitchData,
         OutSignalName => "EMAC1PHYTXCHARDISPMODE",
         OutTemp       => EMAC1PHYTXCHARDISPMODE_OUT,
         Paths         => (0 => (PHYEMAC1GTXCLK_dly'last_event, tpd_PHYEMAC1GTXCLK_EMAC1PHYTXCHARDISPMODE,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1PHYTXCHARDISPVAL,
         GlitchData    => EMAC1PHYTXCHARDISPVAL_GlitchData,
         OutSignalName => "EMAC1PHYTXCHARDISPVAL",
         OutTemp       => EMAC1PHYTXCHARDISPVAL_OUT,
         Paths         => (0 => (PHYEMAC1GTXCLK_dly'last_event, tpd_PHYEMAC1GTXCLK_EMAC1PHYTXCHARDISPVAL,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1PHYTXCHARISK,
         GlitchData    => EMAC1PHYTXCHARISK_GlitchData,
         OutSignalName => "EMAC1PHYTXCHARISK",
         OutTemp       => EMAC1PHYTXCHARISK_OUT,
         Paths         => (0 => (PHYEMAC1GTXCLK_dly'last_event, tpd_PHYEMAC1GTXCLK_EMAC1PHYTXCHARISK,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1PHYTXCLK,
         GlitchData    => EMAC1PHYTXCLK_GlitchData,
         OutSignalName => "EMAC1PHYTXCLK",
         OutTemp       => EMAC1PHYTXCLK_OUT,
         Paths         => (0 => (PHYEMAC1GTXCLK_dly'last_event, tpd_PHYEMAC1GTXCLK_EMAC1PHYTXCLK,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1PHYTXD(0),
         GlitchData    => EMAC1PHYTXD0_GlitchData,
         OutSignalName => "EMAC1PHYTXD(0)",
         OutTemp       => EMAC1PHYTXD_OUT(0),
         Paths         => (0 => (CLIENTEMAC1TXGMIIMIICLKIN_dly'last_event, tpd_CLIENTEMAC1TXGMIIMIICLKIN_EMAC1PHYTXD(0),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1PHYTXD(1),
         GlitchData    => EMAC1PHYTXD1_GlitchData,
         OutSignalName => "EMAC1PHYTXD(1)",
         OutTemp       => EMAC1PHYTXD_OUT(1),
         Paths         => (0 => (CLIENTEMAC1TXGMIIMIICLKIN_dly'last_event, tpd_CLIENTEMAC1TXGMIIMIICLKIN_EMAC1PHYTXD(1),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1PHYTXD(2),
         GlitchData    => EMAC1PHYTXD2_GlitchData,
         OutSignalName => "EMAC1PHYTXD(2)",
         OutTemp       => EMAC1PHYTXD_OUT(2),
         Paths         => (0 => (CLIENTEMAC1TXGMIIMIICLKIN_dly'last_event, tpd_CLIENTEMAC1TXGMIIMIICLKIN_EMAC1PHYTXD(2),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1PHYTXD(3),
         GlitchData    => EMAC1PHYTXD3_GlitchData,
         OutSignalName => "EMAC1PHYTXD(3)",
         OutTemp       => EMAC1PHYTXD_OUT(3),
         Paths         => (0 => (CLIENTEMAC1TXGMIIMIICLKIN_dly'last_event, tpd_CLIENTEMAC1TXGMIIMIICLKIN_EMAC1PHYTXD(3),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1PHYTXD(4),
         GlitchData    => EMAC1PHYTXD4_GlitchData,
         OutSignalName => "EMAC1PHYTXD(4)",
         OutTemp       => EMAC1PHYTXD_OUT(4),
         Paths         => (0 => (CLIENTEMAC1TXGMIIMIICLKIN_dly'last_event, tpd_CLIENTEMAC1TXGMIIMIICLKIN_EMAC1PHYTXD(4),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1PHYTXD(5),
         GlitchData    => EMAC1PHYTXD5_GlitchData,
         OutSignalName => "EMAC1PHYTXD(5)",
         OutTemp       => EMAC1PHYTXD_OUT(5),
         Paths         => (0 => (CLIENTEMAC1TXGMIIMIICLKIN_dly'last_event, tpd_CLIENTEMAC1TXGMIIMIICLKIN_EMAC1PHYTXD(5),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1PHYTXD(6),
         GlitchData    => EMAC1PHYTXD6_GlitchData,
         OutSignalName => "EMAC1PHYTXD(6)",
         OutTemp       => EMAC1PHYTXD_OUT(6),
         Paths         => (0 => (CLIENTEMAC1TXGMIIMIICLKIN_dly'last_event, tpd_CLIENTEMAC1TXGMIIMIICLKIN_EMAC1PHYTXD(6),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1PHYTXD(7),
         GlitchData    => EMAC1PHYTXD7_GlitchData,
         OutSignalName => "EMAC1PHYTXD(7)",
         OutTemp       => EMAC1PHYTXD_OUT(7),
         Paths         => (0 => (CLIENTEMAC1TXGMIIMIICLKIN_dly'last_event, tpd_CLIENTEMAC1TXGMIIMIICLKIN_EMAC1PHYTXD(7),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1PHYTXEN,
         GlitchData    => EMAC1PHYTXEN_GlitchData,
         OutSignalName => "EMAC1PHYTXEN",
         OutTemp       => EMAC1PHYTXEN_OUT,
         Paths         => (0 => (CLIENTEMAC1TXGMIIMIICLKIN_dly'last_event, tpd_CLIENTEMAC1TXGMIIMIICLKIN_EMAC1PHYTXEN,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => EMAC1PHYTXER,
         GlitchData    => EMAC1PHYTXER_GlitchData,
         OutSignalName => "EMAC1PHYTXER",
         OutTemp       => EMAC1PHYTXER_OUT,
         Paths         => (0 => (CLIENTEMAC1TXGMIIMIICLKIN_dly'last_event, tpd_CLIENTEMAC1TXGMIIMIICLKIN_EMAC1PHYTXER,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTMIIMRDY,
         GlitchData    => HOSTMIIMRDY_GlitchData,
         OutSignalName => "HOSTMIIMRDY",
         OutTemp       => HOSTMIIMRDY_OUT,
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTMIIMRDY,TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(0),
         GlitchData    => HOSTRDDATA0_GlitchData,
         OutSignalName => "HOSTRDDATA(0)",
         OutTemp       => HOSTRDDATA_OUT(0),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(0),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(1),
         GlitchData    => HOSTRDDATA1_GlitchData,
         OutSignalName => "HOSTRDDATA(1)",
         OutTemp       => HOSTRDDATA_OUT(1),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(1),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(2),
         GlitchData    => HOSTRDDATA2_GlitchData,
         OutSignalName => "HOSTRDDATA(2)",
         OutTemp       => HOSTRDDATA_OUT(2),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(2),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(3),
         GlitchData    => HOSTRDDATA3_GlitchData,
         OutSignalName => "HOSTRDDATA(3)",
         OutTemp       => HOSTRDDATA_OUT(3),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(3),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(4),
         GlitchData    => HOSTRDDATA4_GlitchData,
         OutSignalName => "HOSTRDDATA(4)",
         OutTemp       => HOSTRDDATA_OUT(4),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(4),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(5),
         GlitchData    => HOSTRDDATA5_GlitchData,
         OutSignalName => "HOSTRDDATA(5)",
         OutTemp       => HOSTRDDATA_OUT(5),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(5),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(6),
         GlitchData    => HOSTRDDATA6_GlitchData,
         OutSignalName => "HOSTRDDATA(6)",
         OutTemp       => HOSTRDDATA_OUT(6),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(6),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(7),
         GlitchData    => HOSTRDDATA7_GlitchData,
         OutSignalName => "HOSTRDDATA(7)",
         OutTemp       => HOSTRDDATA_OUT(7),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(7),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(8),
         GlitchData    => HOSTRDDATA8_GlitchData,
         OutSignalName => "HOSTRDDATA(8)",
         OutTemp       => HOSTRDDATA_OUT(8),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(8),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(9),
         GlitchData    => HOSTRDDATA9_GlitchData,
         OutSignalName => "HOSTRDDATA(9)",
         OutTemp       => HOSTRDDATA_OUT(9),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(9),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(10),
         GlitchData    => HOSTRDDATA10_GlitchData,
         OutSignalName => "HOSTRDDATA(10)",
         OutTemp       => HOSTRDDATA_OUT(10),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(10),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(11),
         GlitchData    => HOSTRDDATA11_GlitchData,
         OutSignalName => "HOSTRDDATA(11)",
         OutTemp       => HOSTRDDATA_OUT(11),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(11),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(12),
         GlitchData    => HOSTRDDATA12_GlitchData,
         OutSignalName => "HOSTRDDATA(12)",
         OutTemp       => HOSTRDDATA_OUT(12),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(12),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(13),
         GlitchData    => HOSTRDDATA13_GlitchData,
         OutSignalName => "HOSTRDDATA(13)",
         OutTemp       => HOSTRDDATA_OUT(13),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(13),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(14),
         GlitchData    => HOSTRDDATA14_GlitchData,
         OutSignalName => "HOSTRDDATA(14)",
         OutTemp       => HOSTRDDATA_OUT(14),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(14),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(15),
         GlitchData    => HOSTRDDATA15_GlitchData,
         OutSignalName => "HOSTRDDATA(15)",
         OutTemp       => HOSTRDDATA_OUT(15),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(15),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(16),
         GlitchData    => HOSTRDDATA16_GlitchData,
         OutSignalName => "HOSTRDDATA(16)",
         OutTemp       => HOSTRDDATA_OUT(16),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(16),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(17),
         GlitchData    => HOSTRDDATA17_GlitchData,
         OutSignalName => "HOSTRDDATA(17)",
         OutTemp       => HOSTRDDATA_OUT(17),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(17),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(18),
         GlitchData    => HOSTRDDATA18_GlitchData,
         OutSignalName => "HOSTRDDATA(18)",
         OutTemp       => HOSTRDDATA_OUT(18),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(18),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(19),
         GlitchData    => HOSTRDDATA19_GlitchData,
         OutSignalName => "HOSTRDDATA(19)",
         OutTemp       => HOSTRDDATA_OUT(19),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(19),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(20),
         GlitchData    => HOSTRDDATA20_GlitchData,
         OutSignalName => "HOSTRDDATA(20)",
         OutTemp       => HOSTRDDATA_OUT(20),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(20),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(21),
         GlitchData    => HOSTRDDATA21_GlitchData,
         OutSignalName => "HOSTRDDATA(21)",
         OutTemp       => HOSTRDDATA_OUT(21),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(21),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(22),
         GlitchData    => HOSTRDDATA22_GlitchData,
         OutSignalName => "HOSTRDDATA(22)",
         OutTemp       => HOSTRDDATA_OUT(22),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(22),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(23),
         GlitchData    => HOSTRDDATA23_GlitchData,
         OutSignalName => "HOSTRDDATA(23)",
         OutTemp       => HOSTRDDATA_OUT(23),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(23),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(24),
         GlitchData    => HOSTRDDATA24_GlitchData,
         OutSignalName => "HOSTRDDATA(24)",
         OutTemp       => HOSTRDDATA_OUT(24),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(24),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(25),
         GlitchData    => HOSTRDDATA25_GlitchData,
         OutSignalName => "HOSTRDDATA(25)",
         OutTemp       => HOSTRDDATA_OUT(25),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(25),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(26),
         GlitchData    => HOSTRDDATA26_GlitchData,
         OutSignalName => "HOSTRDDATA(26)",
         OutTemp       => HOSTRDDATA_OUT(26),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(26),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(27),
         GlitchData    => HOSTRDDATA27_GlitchData,
         OutSignalName => "HOSTRDDATA(27)",
         OutTemp       => HOSTRDDATA_OUT(27),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(27),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(28),
         GlitchData    => HOSTRDDATA28_GlitchData,
         OutSignalName => "HOSTRDDATA(28)",
         OutTemp       => HOSTRDDATA_OUT(28),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(28),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(29),
         GlitchData    => HOSTRDDATA29_GlitchData,
         OutSignalName => "HOSTRDDATA(29)",
         OutTemp       => HOSTRDDATA_OUT(29),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(29),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(30),
         GlitchData    => HOSTRDDATA30_GlitchData,
         OutSignalName => "HOSTRDDATA(30)",
         OutTemp       => HOSTRDDATA_OUT(30),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(30),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );
     VitalPathDelay01
       (
         OutSignal     => HOSTRDDATA(31),
         GlitchData    => HOSTRDDATA31_GlitchData,
         OutSignalName => "HOSTRDDATA(31)",
         OutTemp       => HOSTRDDATA_OUT(31),
         Paths         => (0 => (HOSTCLK_dly'last_event, tpd_HOSTCLK_HOSTRDDATA(31),TRUE)),
         Mode          => VitalTransport,
         Xon           => false,
         MsgOn         => false,
         MsgSeverity   => WARNING
       );

--  Wait signal (input/output pins)
   wait on
     CLIENTEMAC0DCMLOCKED_dly,
     CLIENTEMAC0PAUSEREQ_dly,
     CLIENTEMAC0PAUSEVAL_dly,
     CLIENTEMAC0RXCLIENTCLKIN_dly,
     CLIENTEMAC0TXCLIENTCLKIN_dly,
     CLIENTEMAC0TXD_client16_delay,
     CLIENTEMAC0TXDVLD_client16_delay,
     CLIENTEMAC0TXDVLDMSW_client16_delay,
     CLIENTEMAC0TXFIRSTBYTE_dly,
     CLIENTEMAC0TXGMIIMIICLKIN_dly,
     CLIENTEMAC0TXIFGDELAY_dly,
     CLIENTEMAC0TXUNDERRUN_dly,
     CLIENTEMAC1DCMLOCKED_dly,
     CLIENTEMAC1PAUSEREQ_dly,
     CLIENTEMAC1PAUSEVAL_dly,
     CLIENTEMAC1RXCLIENTCLKIN_dly,
     CLIENTEMAC1TXCLIENTCLKIN_dly,
     CLIENTEMAC1TXD_client16_delay,
     CLIENTEMAC1TXDVLD_client16_delay,
     CLIENTEMAC1TXDVLDMSW_client16_delay,
     CLIENTEMAC1TXFIRSTBYTE_dly,
     CLIENTEMAC1TXGMIIMIICLKIN_dly,
     CLIENTEMAC1TXIFGDELAY_dly,
     CLIENTEMAC1TXUNDERRUN_dly,
     DCREMACENABLE_dly,
     DCRHOSTDONEIR_OUT,
     EMAC0CLIENTANINTERRUPT_OUT,
     EMAC0CLIENTRXBADFRAME_OUT,
     EMAC0CLIENTRXCLIENTCLKOUT_OUT,
     EMAC0CLIENTRXD_OUT,
     EMAC0CLIENTRXDVLD_OUT,
     EMAC0CLIENTRXDVLDMSW_OUT,
     EMAC0CLIENTRXDVREG6_OUT,
     EMAC0CLIENTRXFRAMEDROP_OUT,
     EMAC0CLIENTRXGOODFRAME_OUT,
     EMAC0CLIENTRXSTATS_OUT,
     EMAC0CLIENTRXSTATSBYTEVLD_OUT,
     EMAC0CLIENTRXSTATSVLD_OUT,
     EMAC0CLIENTTXACK_OUT,
     EMAC0CLIENTTXCLIENTCLKOUT_OUT,
     EMAC0CLIENTTXCOLLISION_OUT,
     EMAC0CLIENTTXGMIIMIICLKOUT_OUT,
     EMAC0CLIENTTXRETRANSMIT_OUT,
     EMAC0CLIENTTXSTATS_OUT,
     EMAC0CLIENTTXSTATSBYTEVLD_OUT,
     EMAC0CLIENTTXSTATSVLD_OUT,
     EMAC0PHYENCOMMAALIGN_OUT,
     EMAC0PHYLOOPBACKMSB_OUT,
     EMAC0PHYMCLKOUT_OUT,
     EMAC0PHYMDOUT_OUT,
     EMAC0PHYMDTRI_OUT,
     EMAC0PHYMGTRXRESET_OUT,
     EMAC0PHYMGTTXRESET_OUT,
     EMAC0PHYPOWERDOWN_OUT,
     EMAC0PHYSYNCACQSTATUS_OUT,
     EMAC0PHYTXCHARDISPMODE_OUT,
     EMAC0PHYTXCHARDISPVAL_OUT,
     EMAC0PHYTXCHARISK_OUT,
     EMAC0PHYTXCLK_OUT,
     EMAC0PHYTXD_OUT,
     EMAC0PHYTXEN_OUT,
     EMAC0PHYTXER_OUT,
     EMAC1CLIENTANINTERRUPT_OUT,
     EMAC1CLIENTRXBADFRAME_OUT,
     EMAC1CLIENTRXCLIENTCLKOUT_OUT,
     EMAC1CLIENTRXD_OUT,
     EMAC1CLIENTRXDVLD_OUT,
     EMAC1CLIENTRXDVLDMSW_OUT,
     EMAC1CLIENTRXDVREG6_OUT,
     EMAC1CLIENTRXFRAMEDROP_OUT,
     EMAC1CLIENTRXGOODFRAME_OUT,
     EMAC1CLIENTRXSTATS_OUT,
     EMAC1CLIENTRXSTATSBYTEVLD_OUT,
     EMAC1CLIENTRXSTATSVLD_OUT,
     EMAC1CLIENTTXACK_OUT,
     EMAC1CLIENTTXCLIENTCLKOUT_OUT,
     EMAC1CLIENTTXCOLLISION_OUT,
     EMAC1CLIENTTXGMIIMIICLKOUT_OUT,
     EMAC1CLIENTTXRETRANSMIT_OUT,
     EMAC1CLIENTTXSTATS_OUT,
     EMAC1CLIENTTXSTATSBYTEVLD_OUT,
     EMAC1CLIENTTXSTATSVLD_OUT,
     EMAC1PHYENCOMMAALIGN_OUT,
     EMAC1PHYLOOPBACKMSB_OUT,
     EMAC1PHYMCLKOUT_OUT,
     EMAC1PHYMDOUT_OUT,
     EMAC1PHYMDTRI_OUT,
     EMAC1PHYMGTRXRESET_OUT,
     EMAC1PHYMGTTXRESET_OUT,
     EMAC1PHYPOWERDOWN_OUT,
     EMAC1PHYSYNCACQSTATUS_OUT,
     EMAC1PHYTXCHARDISPMODE_OUT,
     EMAC1PHYTXCHARDISPVAL_OUT,
     EMAC1PHYTXCHARISK_OUT,
     EMAC1PHYTXCLK_OUT,
     EMAC1PHYTXD_OUT,
     EMAC1PHYTXEN_OUT,
     EMAC1PHYTXER_OUT,
     HOSTADDR_dly,
     HOSTCLK_dly,
     HOSTEMAC1SEL_dly,
     HOSTMIIMRDY_OUT,
     HOSTMIIMSEL_dly,
     HOSTOPCODE_dly,
     HOSTRDDATA_OUT,
     HOSTREQ_dly,
     HOSTWRDATA_dly,
     PHYEMAC0COL_dly,
     PHYEMAC0CRS_dly,
     PHYEMAC0GTXCLK_dly,
     PHYEMAC0MCLKIN_dly,
     PHYEMAC0MDIN_dly,
     PHYEMAC0MIITXCLK_skewed,
     PHYEMAC0PHYAD_dly,
     PHYEMAC0RXBUFERR_dly,
     PHYEMAC0RXBUFSTATUS_dly,
     PHYEMAC0RXCHARISCOMMA_dly,
     PHYEMAC0RXCHARISK_dly,
     PHYEMAC0RXCHECKINGCRC_dly,
     PHYEMAC0RXCLK_dly,
     PHYEMAC0RXCLKCORCNT_dly,
     PHYEMAC0RXCOMMADET_dly,
     PHYEMAC0RXD_dly,
     PHYEMAC0RXDISPERR_dly,
     PHYEMAC0RXDV_dly,
     PHYEMAC0RXER_dly,
     PHYEMAC0RXLOSSOFSYNC_dly,
     PHYEMAC0RXNOTINTABLE_dly,
     PHYEMAC0RXRUNDISP_dly,
     PHYEMAC0SIGNALDET_dly,
     PHYEMAC0TXBUFERR_dly,
     PHYEMAC1COL_dly,
     PHYEMAC1CRS_dly,
     PHYEMAC1GTXCLK_dly,
     PHYEMAC1MCLKIN_dly,
     PHYEMAC1MDIN_dly,
     PHYEMAC1MIITXCLK_skewed,
     PHYEMAC1PHYAD_dly,
     PHYEMAC1RXBUFERR_dly,
     PHYEMAC1RXBUFSTATUS_dly,
     PHYEMAC1RXCHARISCOMMA_dly,
     PHYEMAC1RXCHARISK_dly,
     PHYEMAC1RXCHECKINGCRC_dly,
     PHYEMAC1RXCLK_dly,
     PHYEMAC1RXCLKCORCNT_dly,
     PHYEMAC1RXCOMMADET_dly,
     PHYEMAC1RXD_dly,
     PHYEMAC1RXDISPERR_dly,
     PHYEMAC1RXDV_dly,
     PHYEMAC1RXER_dly,
     PHYEMAC1RXLOSSOFSYNC_dly,
     PHYEMAC1RXNOTINTABLE_dly,
     PHYEMAC1RXRUNDISP_dly,
     PHYEMAC1SIGNALDET_dly,
     PHYEMAC1TXBUFERR_dly,
     RESET_dly,
     TIEEMAC0CONFIGVEC_dly,
     TIEEMAC0UNICASTADDR_dly,
     TIEEMAC1CONFIGVEC_dly,
     TIEEMAC1UNICASTADDR_dly,
     DCREMACWRITE_dly,
     DCREMACREAD_dly,
     DCREMACDBUS_dly,
     DCREMACABUS_dly,
     DCREMACCLK_dly,
     EMACDCRDBUS_OUT,
     EMACDCRACK_OUT;

   end process TIMING;

end X_EMAC_V;
